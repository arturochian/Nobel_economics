# laureados/2021_card_angrist_imbens/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2021 · Diferencias en Diferencias y Salario Mínimo (Card & Krueger)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("empleo_pa", "Empleo promedio PA (Estado Control)", min = 15, max = 28, value = 21.2, step = 0.5),
    sliderInput("cambio_macro", "Variación económica general (shock común)", min = -4.0, max = 2.0, value = -2.1, step = 0.2),
    sliderInput("efecto_salario", "Efecto causal del salario mínimo en NJ", min = -4.0, max = 5.0, value = 2.76, step = 0.2),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Card & Krueger (1994): experimento natural evaluando el aumento del salario mínimo de 1992 entre Nueva Jersey y Pensilvania.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>El gráfico compara Nueva Jersey (que elevó su salario mínimo de US$ 4.25 a 5.05) con Pensilvania oriental (que lo mantuvo sin cambios). Al restar la tendencia macroeconómica observada en Pensilvania, se obtiene el efecto causal neto sobre el empleo.</p>'),
    HTML('<p><strong>Contribución Nobel 2021:</strong> David Card revolucionó la economía laboral con experimentos naturales, mientras que Joshua Angrist y Guido Imbens crearon el marco metodológico LATE para interpretar la causalidad con instrumentos imperfectos.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "empleo_pa", value = 21.2)
    updateSliderInput(session, "cambio_macro", value = -2.1)
    updateSliderInput(session, "efecto_salario", value = 2.76)
  })

    datos <- reactive({
      # Valores antes
      nj_antes <- 20.4
      pa_antes <- input$empleo_pa
      
      # Despues
      pa_despues <- pa_antes + input$cambio_macro
      # Contrafactual de NJ si siguiera tendencia paralela
      nj_contrafactual <- nj_antes + input$cambio_macro
      # Observado NJ
      nj_despues <- nj_contrafactual + input$efecto_salario
      
      did <- (nj_despues - nj_antes) - (pa_despues - pa_antes)
      
      list(nj_antes = nj_antes, nj_despues = nj_despues,
           pa_antes = pa_antes, pa_despues = pa_despues,
           nj_cf = nj_contrafactual, did = did)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      x <- c(1, 2)
      plot(x, c(d$pa_antes, d$pa_despues), type = "b", pch = 19, col = "#7f8c8d", lwd = 2.5,
           xlim = c(0.8, 2.2), ylim = c(14, 27), xaxt = "n",
           xlab = "Momento del tiempo", ylab = "Empleo FTE promedio por restaurante",
           main = "Diseño de Diferencias en Diferencias (DiD)")
      axis(1, at = c(1, 2), labels = c("Antes (Feb 1992)", "Después (Nov 1992)"))
      
      # NJ observado
      lines(x, c(d$nj_antes, d$nj_despues), type = "b", pch = 19, col = "#2980b9", lwd = 3)
      # Contrafactual
      lines(x, c(d$nj_antes, d$nj_cf), type = "l", lty = 2, col = "#e67e22", lwd = 2)
      points(2, d$nj_cf, pch = 1, col = "#e67e22", cex = 1.8, lwd = 2)
      
      # Flecha did
      arrows(2, d$nj_cf, 2, d$nj_despues, col = "#27ae60", lwd = 3, length = 0.12)
      text(2.05, (d$nj_cf + d$nj_despues)/2, sprintf("DiD = %+0.2f FTE", d$did), col = "#27ae60", font = 2, adj = 0)
      
      grid()
      legend("topleft", legend = c("PA (Control - sin cambio)", "NJ (Tratado - sube salario)", "NJ (Contrafactual no observado)"),
             col = c("#7f8c8d", "#2980b9", "#e67e22"), lwd = c(2.5, 3, 2), lty = c(1, 1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Estimador de Diferencias en Diferencias:"),
        tags$p(sprintf("Variación en Pensilvania: %+.2f FTE | Variación en Nueva Jersey: %+.2f FTE. El impacto causal estimado del salario mínimo es de %+.2f empleos equivalentes a tiempo completo por establecimiento.",
                       d$pa_despues - d$pa_antes, d$nj_despues - d$nj_antes, d$did))
      )
    })
}

shinyApp(ui = ui, server = server)

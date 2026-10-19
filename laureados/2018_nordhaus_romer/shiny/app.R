# laureados/2018_nordhaus_romer/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2018 · Economía del Cambio Climático y Crecimiento Endógeno",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("tax_co2", "Impuesto al carbono ($/tonelada de CO2)", min = 0, max = 250, value = 40, step = 10),
    sliderInput("subsidio_id", "Subsidio a I+D e innovación verde (%)", min = 0, max = 50, value = 15, step = 5),
    sliderInput("horizonte", "Horizonte de proyección (años)", min = 20, max = 100, value = 60, step = 10),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Nordhaus (Modelo DICE) y Romer (Ideas no rivales): integración del daño climático y la innovación endógena.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>William Nordhaus construyó el modelo de Evaluación Integrada Clima-Economía (DICE), calculando el costo social del carbono. Paul Romer demostró matemáticamente que las ideas son bienes no rivales que generan rendimientos crecientes y crecimiento ilimitado.</p>'),
    HTML('<p><strong>Contribución Nobel 2018:</strong> Integraron las dos mayores fuerzas globales a largo plazo en el análisis macroeconómico: el agotamiento ambiental y la generación de conocimiento tecnológico.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "tax_co2", value = 40)
    updateSliderInput(session, "subsidio_id", value = 15)
    updateSliderInput(session, "horizonte", value = 60)
  })

    datos <- reactive({
      t_seq <- 0:input$horizonte
      tax <- input$tax_co2
      sub_id <- input$subsidio_id / 100
      
      # Emisiones bajo escenario business as usual vs impuesto
      reduccion_emisiones <- min(0.85, (tax / 300)^0.6 + sub_id * 0.5)
      emisiones_bau <- 36 * (1 + 0.015 * t_seq)
      emisiones_opt <- 36 * (1 + 0.015 * t_seq) * (1 - reduccion_emisiones)
      
      # Calentamiento proyectado
      temp_bau <- 1.1 + 0.028 * t_seq
      temp_opt <- 1.1 + 0.028 * t_seq * (1 - reduccion_emisiones * 0.7)
      
      list(t = t_seq, e_bau = emisiones_bau, e_opt = emisiones_opt,
           t_bau = temp_bau, t_opt = temp_opt, red = reduccion_emisiones)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Emisiones
      plot(d$t, d$e_bau, type = "l", col = "#c0392b", lwd = 2.5, lty = 2,
           xlab = "Años desde el presente", ylab = "Gt CO2 anuales",
           ylim = c(0, max(d$e_bau) * 1.1), main = "Trayectoria de Emisiones")
      lines(d$t, d$e_opt, col = "#27ae60", lwd = 3)
      grid()
      legend("topleft", legend = c("Inacción (BAU)", "Con Política Óptima"),
             col = c("#c0392b", "#27ae60"), lwd = c(2.5, 3), lty = c(2, 1), bty = "n")

      # Temperatura
      plot(d$t, d$t_bau, type = "l", col = "#c0392b", lwd = 2.5, lty = 2,
           xlab = "Años desde el presente", ylab = "Aumento de Temperatura (°C)",
           ylim = c(1.0, 3.5), main = "Temperatura Global Media")
      lines(d$t, d$t_opt, col = "#2980b9", lwd = 3)
      abline(h = 1.5, lty = 3, col = "#e67e22")
      abline(h = 2.0, lty = 3, col = "#d35400")
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Balance del Modelo DICE-Romer:"),
        tags$p(sprintf("Un precio al carbono de $%d/t combinado con %.0f%% de subsidio a la tecnología verde abate el %.1f%% de las emisiones contaminantes, limitando el calentamiento global a %.2f °C en el año %d.",
                       input$tax_co2, input$subsidio_id, d$red * 100, tail(d$t_opt, 1), tail(d$t, 1)))
      )
    })
}

shinyApp(ui = ui, server = server)

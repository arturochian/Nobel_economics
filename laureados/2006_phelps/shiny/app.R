# laureados/2006_phelps/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2006 · Curva de Phillips con expectativas y Regla de Oro",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("inflacion_esperada", "Inflación esperada por trabajadores (pi^e %)", min = 1, max = 10, value = 3, step = 0.5),
    sliderInput("u_natural", "Tasa natural de desempleo NAIRU (%)", min = 3.5, max = 8.0, value = 5.0, step = 0.5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Edmund Phelps (1968): a largo plazo no existe compensación entre inflación y desempleo; las expectativas anulan el trade-off.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Antes de Phelps y Friedman, la macroeconomía creía erróneamente que los gobiernos podían comprar menos desempleo tolerando permanentemente un poco más de inflación.</p>'),
    HTML('<p><strong>Contribución Nobel 2006:</strong> Edmund Phelps demostró que las expectativas intertemporales anulan la curva de Phillips a largo plazo y formuló la célebre Regla de Oro de acumulación de capital para el consumo intergeneracional óptimo.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "inflacion_esperada", value = 3)
    updateSliderInput(session, "u_natural", value = 5.0)
  })

    datos <- reactive({
      pie <- input$inflacion_esperada
      un <- input$u_natural
      
      u_seq <- seq(2.5, 9.5, length.out = 100)
      # Curva de Phillips de corto plazo: pi = pi^e - beta * (u - u_n)
      pi_cp <- pie - 1.2 * (u_seq - un)
      
      list(u = u_seq, pi = pi_cp, un = un, pie = pie)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$u, d$pi, type = "l", col = "#2980b9", lwd = 3,
           xlim = c(2.5, 9.5), ylim = c(-1, 12),
           xlab = "Tasa de Desempleo (%)", ylab = "Tasa de Inflación (%)",
           main = "Curva de Phillips Aumentada por Expectativas (Phelps)")
      # Curva de largo plazo vertical en u_natural
      abline(v = d$un, col = "#c0392b", lwd = 2.5, lty = 2)
      points(d$un, d$pie, pch = 21, bg = "#f1c40f", cex = 2.2, lwd = 2)
      grid()
      legend("topright", legend = c("Corto plazo (Expectativa fija)", "Largo plazo vertical (NAIRU)"),
             col = c("#2980b9", "#c0392b"), lwd = c(3, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Postulado de Phelps:"),
        tags$p(sprintf("Cualquier intento de reducir el desempleo por debajo de su tasa natural (%.1f%%) sólo produce inflación no anticipada temporalmente. Cuando las expectativas se ajustan a %.1f%%, el desempleo regresa íntegramente a su equilibrio estructural.",
                       d$un, d$pie))
      )
    })
}

shinyApp(ui = ui, server = server)

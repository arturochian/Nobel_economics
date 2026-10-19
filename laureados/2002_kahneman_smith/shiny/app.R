# laureados/2002_kahneman_smith/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2002 · Teoría prospectiva y aversión a pérdidas (Kahneman & Tversky)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("lambda", "Coeficiente de aversión a las pérdidas (lambda)", min = 1.0, max = 3.5, value = 2.25, step = 0.25),
    sliderInput("alfa", "Sensibilidad decreciente al valor (alfa)", min = 0.5, max = 0.95, value = 0.88, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Daniel Kahneman (psicología del juicio y teoría prospectiva) y Vernon Smith (experimentos de laboratorio en economía).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Daniel Kahneman y Amos Tversky sustituyeron la teoría de la utilidad esperada por la Teoría Prospectiva: las decisiones se evalúan respecto a puntos de referencia subjetivos, con concavidad en las ganancias (aversión al riesgo) y convexidad pronunciada en las pérdidas (búsqueda de riesgo para evitar perder).</p>'),
    HTML('<p><strong>Contribución Nobel 2002:</strong> Daniel Kahneman integró la psicología cognitiva en la ciencia económica, mientras que Vernon Smith validó empíricamente el funcionamiento de los mercados en el laboratorio.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "lambda", value = 2.25)
    updateSliderInput(session, "alfa", value = 0.88)
  })

    datos <- reactive({
      lam <- input$lambda
      a <- input$alfa
      
      x <- seq(-100, 100, length.out = 200)
      # Funcion de valor en forma de S de Kahneman-Tversky:
      # v(x) = x^alfa si x >= 0;  -lambda * (-x)^alfa si x < 0
      v <- ifelse(x >= 0, x^a, -lam * ((-x)^a))
      
      list(x = x, v = v, lam = lam)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$x, d$v, type = "l", col = "#2980b9", lwd = 3,
           xlab = "Ganancias o Pérdidas relativas al punto de referencia ($)",
           ylab = "Valor subjetivo / Utilidad psicológica v(x)",
           main = "Función de Valor Asimétrica (Teoría Prospectiva)")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      abline(v = 0, lty = 2, col = "#7f8c8d")
      text(-50, -40, sprintf("Pendiente en pérdidas: %.2fx más empinada", d$lam), col = "#c0392b", font = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Psicología de la decisión económica:"),
        tags$p(sprintf("Con lambda = %.2f, el dolor psicológico de perder $100 es más del doble de intenso que la satisfacción de ganar esos mismos $100, explicando por qué las personas rechazan sistemáticamente apuestas justas.",
                       d$lam))
      )
    })
}

shinyApp(ui = ui, server = server)

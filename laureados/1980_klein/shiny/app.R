# laureados/1980_klein/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1980 · Modelos Macroeconométricos de Ecuaciones Simultáneas (Klein)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("propension_c", "Propensión marginal a consumir (c)", min = 0.4, max = 0.9, value = 0.7, step = 0.05),
    sliderInput("gasto_publico", "Incremento de gasto público (G)", min = 0, max = 40, value = 15, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Lawrence Klein: pionero en la construcción de los primeros modelos econométricos computacionales para pronóstico macroeconómico.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Lawrence Klein transformó la teoría keynesiana abstracta en sistemas de ecuaciones estimables empíricamente (como el Modelo Klein-Goldberger y el Proyecto LINK que conectaba los modelos económicos de múltiples países).</p>'),
    HTML('<p><strong>Contribución Nobel 1980:</strong> Lawrence Klein fue el padre de los pronósticos macroeconométricos computarizados para la formulación de políticas públicas.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "propension_c", value = 0.7)
    updateSliderInput(session, "gasto_publico", value = 15)
  })

    datos <- reactive({
      c <- input$propension_c
      g <- input$gasto_publico
      
      # Multiplicador keynesiano estructural de Klein: k = 1 / (1 - c)
      k <- 1 / (1 - c)
      delta_pib <- k * g
      
      list(c = c, g = g, k = k, dpib = delta_pib)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      c_seq <- seq(0.4, 0.9, length.out = 50)
      k_seq <- 1 / (1 - c_seq)
      
      plot(c_seq, k_seq, type = "l", col = "#2980b9", lwd = 3,
           xlab = "Propensión marginal a consumir (c)", ylab = "Multiplicador del Gasto k = 1/(1-c)",
           ylim = c(1, 10), main = "Multiplicador Estructural de Klein")
      points(d$c, d$k, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Predicción del Modelo de Klein:"),
        tags$p(sprintf("Con una propensión a consumir de %.2f, el multiplicador macroeconómico es de %.2f. Un paquete de gasto fiscal de $%d genera una expansión acumulada en el PIB de +$%.1f.",
                       d$c, d$k, d$g, d$dpib))
      )
    })
}

shinyApp(ui = ui, server = server)

# laureados/1972_hicks_arrow/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1972 · Equilibrio General y Modelo IS-LM (Hicks & Arrow)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("sensibilidad_i", "Sensibilidad de la inversión a la tasa de interés", min = 5, max = 30, value = 15, step = 2),
    sliderInput("demanda_dinero_k", "Sensibilidad de la demanda de dinero al ingreso (k)", min = 0.2, max = 0.8, value = 0.5, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("John Hicks (creador del modelo IS-LM y efecto sustitución/renta) y Kenneth Arrow (teoremas fundamentales del bienestar y teorema de imposibilidad).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>John Hicks tradujo la densa \'Teoría General\' de Keynes a la síntesis gráfica del modelo IS-LM en 1937. Kenneth Arrow demostró matemáticamente los Teoremas Fundamentales del Bienestar y formuló el Teorema de Imposibilidad de Arrow, probando que no existe ningún sistema democrático de votación perfecto.</p>'),
    HTML('<p><strong>Contribución Nobel 1972:</strong> John Hicks y Kenneth Arrow transformaron la teoría del equilibrio general y la economía del bienestar.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "sensibilidad_i", value = 15)
    updateSliderInput(session, "demanda_dinero_k", value = 0.5)
  })

    datos <- reactive({
      b <- input$sensibilidad_i
      k <- input$demanda_dinero_k
      
      # Equilibrio IS-LM
      # Curva IS: r = 12 - 0.08 * Y
      # Curva LM: r = 2 + (k / 10) * Y
      y_seq <- seq(40, 140, length.out = 100)
      r_is <- 14 - (b / 100) * y_seq
      r_lm <- 1 + (k / 10) * (y_seq - 40)
      
      # Interseccion
      # 14 - (b/100)*Y = 1 + (k/10)*Y - 4*k  =>  Y*(b/100 + k/10) = 13 + 4*k
      y_eq <- (13 + 4 * k) / (b / 100 + k / 10)
      r_eq <- 14 - (b / 100) * y_eq
      
      list(y = y_seq, is = r_is, lm = r_lm, y_eq = y_eq, r_eq = r_eq)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$y, d$is, type = "l", col = "#c0392b", lwd = 3,
           xlab = "Ingreso / Producción Real (Y)", ylab = "Tasa de Interés Real (r %)",
           ylim = c(0, 15), main = "El Modelo IS-LM de John Hicks (1937)")
      lines(d$y, d$lm, col = "#2980b9", lwd = 3)
      points(d$y_eq, d$r_eq, pch = 21, bg = "#f1c40f", cex = 2.4, lwd = 2)
      text(d$y_eq + 3, d$r_eq + 0.8, "Equilibrio Macroeconómico", font = 2)
      grid()
      legend("topright", legend = c("Mercado de Bienes (IS)", "Mercado de Dinero (LM)"),
             col = c("#c0392b", "#2980b9"), lwd = 3, bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Equilibrio Conjunto IS-LM:"),
        tags$p(sprintf("El producto real de equilibrio se sitúa en Y = %.1f y la tasa de interés de equilibrio en r = %.2f%%, donde simultáneamente la inversión iguala al ahorro y la oferta monetaria iguala a la demanda de liquidez.",
                       d$y_eq, d$r_eq))
      )
    })
}

shinyApp(ui = ui, server = server)

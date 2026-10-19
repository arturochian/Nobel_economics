# laureados/1973_leontief/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1973 · Tablas Insumo-Producto y Matriz de Leontief",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("demanda_final_ind", "Aumento en demanda final industrial ($ M)", min = 10, max = 100, value = 40, step = 10),
    sliderInput("interdependencia", "Coeficiente de interdependencia insumo-producto (a12)", min = 0.1, max = 0.5, value = 0.3, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Wassily Leontief: invención de las matrices de Insumo-Producto (Input-Output) para calcular la producción total directa e indirecta.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Wassily Leontief transformó la economía aplicada al desarrollar las matrices de Insumo-Producto (Input-Output), que trazan matemáticamente cómo el carbón entra en el acero, el acero en la maquinaria y la maquinaria en los bienes de consumo final.</p>'),
    HTML('<p><strong>Contribución Nobel 1973:</strong> Wassily Leontief creó el método de insumo-producto utilizado hoy universalmente en matrices contables y análisis de huella de carbono.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "demanda_final_ind", value = 40)
    updateSliderInput(session, "interdependencia", value = 0.3)
  })

    datos <- reactive({
      d2 <- input$demanda_final_ind
      a <- input$interdependencia
      
      # Matriz simplificada de 2 sectores (Agricultura e Industria)
      # X = (I - A)^(-1) * D
      # Multiplicador Leontief: 1 / (1 - a)
      mult <- 1 / (1 - a^2)
      produccion_total <- mult * d2
      produccion_indirecta <- produccion_total - d2
      
      list(d2 = d2, tot = produccion_total, ind = produccion_indirecta, mult = mult)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      valores <- c(d$d2, d$tot)
      bp <- barplot(valores, names.arg = c("Demanda Final Directa", "Producción Bruta Requerida Total"),
                    col = c("#3498db", "#27ae60"),
                    ylab = "Millones de Dólares ($ M)",
                    ylim = c(0, max(valores) * 1.25),
                    main = "Efecto Multiplicador Intersectorial de Leontief")
      text(bp, valores + 3, sprintf("$%.1f M", valores), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Cálculo Inverso de Leontief (I - A)^(-1):"),
        tags$p(sprintf("Para satisfacer un pedido final de $%.0f M, la economía debe generar $%.1f M en producción total bruta debido a los $%.1f M necesarios en insumos intermedios intersectoriales.",
                       d$d2, d$tot, d$ind))
      )
    })
}

shinyApp(ui = ui, server = server)

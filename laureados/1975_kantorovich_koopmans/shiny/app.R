# laureados/1975_kantorovich_koopmans/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1975 · Programación Lineal y Precios Sombra (Kantorovich & Koopmans)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("recurso_horas", "Disponibilidad de horas de maquinaria disponible", min = 40, max = 150, value = 100, step = 10),
    sliderInput("precio_producto1", "Margen unitario Producto A ($)", min = 20, max = 80, value = 40, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Leonid Kantorovich y Tjalling Koopmans: formulación de la programación lineal y descubrimiento de los precios sombra como multiplicadores de escasez.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Leonid Kantorovich descubrió en la Unión Soviética en 1939 la programación lineal para optimizar la producción industrial, demostrando que los precios sombra son indispensables para la eficiencia incluso en una economía centralizada. Tjalling Koopmans desarrolló el análisis de actividades en Occidente.</p>'),
    HTML('<p><strong>Contribución Nobel 1975:</strong> Crearon la teoría de la asignación óptima de recursos y los métodos de optimización matemática lineal.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "recurso_horas", value = 100)
    updateSliderInput(session, "precio_producto1", value = 40)
  })

    datos <- reactive({
      H <- input$recurso_horas
      p1 <- input$precio_producto1
      
      # Max p1*x1 + 30*x2  s.a.  2*x1 + 1*x2 <= H
      # Si p1/2 > 30/1 => produce todo Producto A, precio sombra = p1/2
      if (p1 / 2 >= 30) {
        x1_opt <- H / 2
        x2_opt <- 0
        precio_sombra <- p1 / 2
      } else {
        x1_opt <- 0
        x2_opt <- H
        precio_sombra <- 30
      }
      beneficio_max <- p1 * x1_opt + 30 * x2_opt
      
      list(x1 = x1_opt, x2 = x2_opt, sombra = precio_sombra, ben = beneficio_max)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      cantidades <- c(d$x1, d$x2)
      bp <- barplot(cantidades, names.arg = c("Producto A Óptimo", "Producto B Óptimo"),
                    col = c("#2980b9", "#27ae60"),
                    ylab = "Unidades a fabricar",
                    ylim = c(0, max(cantidades) * 1.25),
                    main = "Asignación Óptima por Programación Lineal")
      text(bp, cantidades + 3, sprintf("%.0f uds", cantidades), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Valoración Marginal del Recurso Escaso:"),
        tags$p(sprintf("El precio sombra (shadow price) de una hora adicional de maquinaria es de $%.2f. El beneficio máximo obtenido asciende a $%.0f.",
                       d$sombra, d$ben))
      )
    })
}

shinyApp(ui = ui, server = server)

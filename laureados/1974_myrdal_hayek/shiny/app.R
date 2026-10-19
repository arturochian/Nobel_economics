# laureados/1974_myrdal_hayek/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1974 · El Sistema de Precios como Transmisor de Información (Hayek)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("shock_escasez", "Magnitud de la escasez física local (pérdida de suministro %)", min = 10, max = 80, value = 40, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Friedrich von Hayek (1945, 'The Use of Knowledge in Society'): los precios comunican información dispersa sin que nadie conozca la causa.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Friedrich Hayek demostró que el verdadero problema económico no es el cálculo matemático de recursos conocidos, sino cómo utilizar un conocimiento disperso que nadie posee en su totalidad: los precios de mercado actúan como telecomunicaciones que sintetizan información oculta.</p>'),
    HTML('<p><strong>Contribución Nobel 1974:</strong> Gunnar Myrdal y Friedrich Hayek fueron reconocidos por su trabajo pionero en la teoría del dinero y el análisis interdisciplinario de las instituciones económicas.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "shock_escasez", value = 40)
  })

    datos <- reactive({
      shock <- input$shock_escasez
      # Senal de precios resultante
      precio_rel <- 100 * (1 + (shock / 100)^1.2 * 1.8)
      # Sustitucion voluntaria del consumidor
      consumo_reducido <- 100 * (1 - shock / 120)
      
      list(p = precio_rel, c = consumo_reducido)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      vals <- c(100, d$p)
      bp <- barplot(vals, names.arg = c("Precio Normal de Referencia", "Precio tras Shock de Escasez"),
                    col = c("#bdc3c7", "#e74c3c"),
                    ylab = "Índice de Precios",
                    ylim = c(0, max(vals) * 1.25),
                    main = "El Sistema de Precios como Mecanismo de Señales (Hayek)")
      text(bp, vals + 10, sprintf("%.0f", vals), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Coordinación Espontánea de Hayek:"),
        tags$p(sprintf("Al subir el precio a %.0f, millones de consumidores racionan su consumo en un %.1f%% de forma instantánea, sin que ningún ministerio central deba ordenarles qué hacer ni explicarles por qué se redujo la oferta.",
                       d$p, 100 - d$c))
      )
    })
}

shinyApp(ui = ui, server = server)

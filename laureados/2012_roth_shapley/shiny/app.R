# laureados/2012_roth_shapley/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2012 · Emparejamiento estable y diseño de mercados (Gale-Shapley)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("n_agentes", "Número de participantes por lado (médicos / hospitales)", min = 3, max = 8, value = 4, step = 1),
    selectInput("proponente", "Lado que propone emparejamiento:", choices = c("Médicos / Postulantes", "Hospitales / Colegios")),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Gale & Shapley (1962) y Alvin Roth: algoritmo de aceptación diferida para crear mercados estables sin dinero.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Lloyd Shapley desarrolló el algoritmo teórico de aceptación diferida que garantiza la existencia de asignaciones estables. Alvin Roth aplicó esta teoría para rediseñar la asignación de médicos residentes en EE. UU., el sistema de colegios públicos de Nueva York y el programa de intercambio de donantes de riñón.</p>'),
    HTML('<p><strong>Contribución Nobel 2012:</strong> Alvin Roth y Lloyd Shapley resolvieron fallos graves de mercado en asignaciones bilaterales donde no es ético o viable utilizar precios monetarios.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "n_agentes", value = 4)
    updateSelectInput(session, "proponente", selected = "Médicos / Postulantes")
  })

    datos <- reactive({
      n <- input$n_agentes
      # Calidad de emparejamiento (ranking promedio obtenido)
      # Quien propone obtiene su emparejamiento optimo estable
      if (input$proponente == "Médicos / Postulantes") {
        rank_medicos <- 1.2 + 0.1 * n
        rank_hospitales <- 2.2 + 0.2 * n
      } else {
        rank_medicos <- 2.3 + 0.2 * n
        rank_hospitales <- 1.2 + 0.1 * n
      }
      
      list(n = n, rm = rank_medicos, rh = rank_hospitales)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      ranks <- c(d$rm, d$rh)
      bp <- barplot(ranks, names.arg = c("Preferencia Médicos", "Preferencia Hospitales"),
                    col = c("#27ae60", "#2980b9"),
                    ylab = "Posición promedio asignada en ranking (1 = preferido)",
                    ylim = c(0, d$n + 1),
                    main = "Propiedad Óptima del Proponente en Gale-Shapley")
      text(bp, ranks + 0.3, sprintf("%.2f", ranks), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Estabilidad del emparejamiento:"),
        tags$p(sprintf("El algoritmo garantiza que no exista ningún par bloqueador (ningún médico y hospital preferirían estar juntos antes que con sus asignaciones actuales). El lado proponente ('%s') alcanza su mejor emparejamiento estable posible.",
                       input$proponente))
      )
    })
}

shinyApp(ui = ui, server = server)

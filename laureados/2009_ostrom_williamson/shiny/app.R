# laureados/2009_ostrom_williamson/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2009 · Gobernanza económica: Bienes comunes y límites de la empresa",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("usuarios", "Número de usuarios del recurso común", min = 10, max = 100, value = 30, step = 5),
    sliderInput("monitoreo", "Efectividad del monitoreo y sanciones comunitarias", min = 0, max = 1, value = 0.7, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Elinor Ostrom (gobernanza de bienes comunes sin Estado ni privatización) y Oliver Williamson (costos de transacción).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Elinor Ostrom desafió la creencia arraigada de que los recursos comunes (pesquerías, bosques, cuencas de agua) solo podían salvarse mediante privatización o estatización, demostrando con cientos de casos de campo que las comunidades locales crean reglas de autogobierno estables y duraderas.</p>'),
    HTML('<p><strong>Contribución Nobel 2009:</strong> Elinor Ostrom y Oliver Williamson demostraron que la gobernanza económica institucional trasciende la dicotomía simplista entre mercados anónimos y jerarquías estatales.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "usuarios", value = 30)
    updateSliderInput(session, "monitoreo", value = 0.7)
  })

    datos <- reactive({
      n <- input$usuarios
      m <- input$monitoreo
      
      # Tragedia de los comunes clasica de Hardin vs cooperacion de Ostrom
      # Extraccion individual
      extraccion_hardin <- 100 / (1 + 0.02 * n)
      extraccion_ostrom <- 100 / (1 + 0.02 * n * (1 - m * 0.85))
      
      biomasa_hardin <- max(5, 1000 - n * extraccion_hardin * 0.4)
      biomasa_ostrom <- max(5, 1000 - n * extraccion_ostrom * 0.4)
      
      list(n = n, eh = extraccion_hardin, eo = extraccion_ostrom,
           bh = biomasa_hardin, bo = biomasa_ostrom)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      biomasas <- c(d$bh, d$bo)
      bp <- barplot(biomasas, names.arg = c("Tragedia de Comunes (Hardin)", "Gobernanza Comunitaria (Ostrom)"),
                    col = c("#c0392b", "#27ae60"),
                    ylab = "Stock sostenible del recurso biológico",
                    ylim = c(0, 1100),
                    main = "Sostenibilidad de Recursos de Uso Común")
      text(bp, biomasas + 40, sprintf("%.0f uds", biomasas), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Resultados de la Gobernanza de Ostrom:"),
        tags$p(sprintf("Con monitoreo comunitario (efectividad = %.0f%%), el stock del recurso protegido es de %.0f unidades frente a solo %.0f bajo la tragedia clásica de sobreexplotación.",
                       input$monitoreo * 100, d$bo, d$bh))
      )
    })
}

shinyApp(ui = ui, server = server)

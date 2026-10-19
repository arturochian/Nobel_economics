# laureados/2005_aumann_schelling/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2005 · Segregación emergente (Schelling) y cooperación (Aumann)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("tolerancia", "Tolerancia mínima de vecinos del mismo grupo (%)", min = 20, max = 80, value = 33, step = 5),
    sliderInput("densidad", "Ocupación del vecindario (%)", min = 60, max = 95, value = 80, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Thomas Schelling (1971): micromotivos con tolerancias moderadas generan macroniveles extremos de segregación espacial.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Thomas Schelling modeló cómo pequeñas preferencias individuales pueden coordinar dinámicas colectivas dramáticas (segregación urbana o desarme nuclear). Robert Aumann amplió la teoría de juegos con el concepto de equilibrios correlacionados y juegos repetidos infinitos.</p>'),
    HTML('<p><strong>Contribución Nobel 2005:</strong> Robert Aumann y Thomas Schelling profundizaron el entendimiento del conflicto y la cooperación mediante la teoría de juegos interactiva.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "tolerancia", value = 33)
    updateSliderInput(session, "densidad", value = 80)
  })

    datos <- reactive({
      tol <- input$tolerancia
      # Indice de segregacion final alcanzado en equilibrio
      seg_final <- min(98, tol * 1.5 + 20)
      list(tol = tol, seg = seg_final)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      tolerancias <- seq(20, 80, by = 5)
      seg_curva <- pmin(98, tolerancias * 1.5 + 20)
      
      plot(tolerancias, seg_curva, type = "b", pch = 19, col = "#8e44ad", lwd = 2.5,
           xlab = "Preferencia individual de similitud mínima (%)",
           ylab = "Segregación resultante a nivel de vecindario (%)",
           ylim = c(30, 100), main = "Efecto Macro de Micromotivos (Modelo de Schelling)")
      points(d$tol, d$seg, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Paradoja de Schelling:"),
        tags$p(sprintf("Aun cuando las personas toleran tener hasta un %.0f%% de vecinos distintos, las reubicaciones individuales encadenadas producen un vecindario segregado al %.0f%%, sin que ningún agente lo haya deseado explícitamente.",
                       100 - d$tol, d$seg))
      )
    })
}

shinyApp(ui = ui, server = server)

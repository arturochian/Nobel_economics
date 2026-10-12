library(shiny)
library(bslib)

source("R/cargar_modelo.R", local = TRUE)

ui <- page_sidebar(
  title = "1969 · Impulsos y propagación",
  theme = bs_theme(version = 5, bootswatch = "sandstone", bg = "#f8f5ec", fg = "#17251f", primary = "#8a5d12"),
  sidebar = sidebar(
    sliderInput("c", "Propensión del gasto (c)", min = 0.1, max = 0.9, value = 0.6, step = 0.05),
    sliderInput("v", "Acelerador (v)", min = 0.05, max = 0.9, value = 0.7, step = 0.05),
    sliderInput("rho", "Persistencia del choque", min = 0, max = 0.9, value = 0, step = 0.05),
    sliderInput("amp", "Tamaño del impulso", min = 1, max = 20, value = 10, step = 1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Nivel: ilustrativa. No representa una predicción de una economía real.")
  ),
  card(
    card_header("Respuesta de la actividad"),
    plotOutput("irf", alt = "Línea temporal de la desviación de la actividad después de un impulso económico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    p("El impulso entra al inicio. Los rezagos del modelo lo propagan: la actividad puede seguir oscilando aun cuando el golpe original ya desapareció."),
    p("Mueve un control cada vez. Así podrás separar el tamaño del golpe, su persistencia y la dinámica interna del sistema.")
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "c", value = 0.6)
    updateSliderInput(session, "v", value = 0.7)
    updateSliderInput(session, "rho", value = 0)
    updateSliderInput(session, "amp", value = 10)
  })

  datos <- reactive({
    simular_impulso(40, input$c, input$v, input$rho, input$amp)
  })

  output$irf <- renderPlot({
    x <- datos()
    plot(x$periodo, x$actividad,
      type = "o", pch = 16, lwd = 2, col = "#9b6714",
      xlab = "Periodo", ylab = "Desviación de la actividad",
      main = "Función impulso-respuesta"
    )
    abline(h = 0, lty = 2, col = "#53645c")
  }, res = 110)

  output$lectura <- renderUI({
    x <- datos()$actividad
    tags$div(
      class = "alert alert-info",
      sprintf("Pico: %.2f · Valle: %.2f · El sistema es estable: %s",
        max(x), min(x), ifelse(es_estable(input$c, input$v), "sí", "no"))
    )
  })
}

shinyApp(ui, server)

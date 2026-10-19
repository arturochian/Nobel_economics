# laureados/2017_thaler/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2017 · Economía Conductual y Arquitectura de Decisión",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("beta", "Sesgo del presente / Impaciencia (beta)", min = 0.5, max = 1.0, value = 0.75, step = 0.05),
    sliderInput("lambda", "Aversión a las pérdidas (lambda)", min = 1.0, max = 3.5, value = 2.25, step = 0.25),
    checkboxInput("usar_nudge", "Aplicar 'Nudge' (Ahorro automático SMarT)", value = TRUE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Richard Thaler: los humanos sufren de autocontrol imperfecto, contabilidad mental y aversión asimétrica a las pérdidas.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>La economía clásica asumía un <em>Homo economicus</em> con autocontrol infinito y racionalidad perfecta. Thaler demostró que las personas postergan decisiones complejas (como ahorrar para la vejez) debido al sesgo del presente.</p>'),
    HTML('<p><strong>Contribución Nobel 2017:</strong> Richard Thaler fundó la economía conductual y diseñó intervenciones institucionales ("nudges") que aumentaron el ahorro de millones de trabajadores preservando su libertad de elección.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "beta", value = 0.75)
    updateSliderInput(session, "lambda", value = 2.25)
    updateCheckboxInput(session, "usar_nudge", value = TRUE)
  })

    datos <- reactive({
      anios <- 0:10
      # Tasa de ahorro bajo decision tradicional (afiliacion opt-in)
      ahorro_tradicional <- 3.5 * input$beta * (1 + 0.02 * anios)
      
      # Tasa bajo Save More Tomorrow (SMarT): compromiso vinculado a aumentos salariales
      if (input$usar_nudge) {
        ahorro_nudge <- 3.5 + 1.2 * anios
        ahorro_nudge <- pmin(15.0, ahorro_nudge)
      } else {
        ahorro_nudge <- ahorro_tradicional
      }
      
      list(anios = anios, trad = ahorro_tradicional, nudge = ahorro_nudge)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$anios, d$nudge, type = "b", pch = 19, col = "#27ae60", lwd = 3,
           xlab = "Años en el plan de retiro", ylab = "Tasa de ahorro sobre el salario (%)",
           ylim = c(0, 16), main = "Ahorro para la Jubilación: Nudge vs. Opt-In Tradicional")
      lines(d$anios, d$trad, type = "b", pch = 17, col = "#c0392b", lwd = 2.5, lty = 2)
      grid()
      legend("topleft", legend = c("Con Nudge 'Save More Tomorrow'", "Sin Nudge (Tradicional Opt-in)"),
             col = c("#27ae60", "#c0392b"), lwd = c(3, 2.5), lty = c(1, 2), pch = c(19, 17), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Efecto del Empujón Conductual:"),
        tags$p(sprintf("Con un coeficiente de sesgo presente beta = %.2f y aversión a pérdidas lambda = %.2f, el programa automático de Thaler eleva la tasa de ahorro final del %.1f%% al %.1f%% del ingreso.",
                       input$beta, input$lambda, tail(d$trad, 1), tail(d$nudge, 1)))
      )
    })
}

shinyApp(ui = ui, server = server)

# laureados/1996_mirrlees_vickrey/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1996 · Tributación óptima (Mirrlees) y Subastas Vickrey",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("elasticidad_trabajo", "Elasticidad de oferta laboral (desincentivo al esfuerzo)", min = 0.1, max = 0.8, value = 0.3, step = 0.05),
    sliderInput("preferencia_social", "Preferencia social por la redistribución (aversion a la desigualdad)", min = 0.5, max = 3.0, value = 1.5, step = 0.25),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("James Mirrlees (impuesto sobre la renta óptimo con información oculta) y William Vickrey (subasta de segundo precio compatible con incentivos).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>James Mirrlees resolvió el dilema de cómo diseñar un sistema fiscal redistributivo cuando el gobierno puede observar los ingresos pero no el talento innato o el esfuerzo de los ciudadanos. William Vickrey demostró que en una subasta a sobre cerrado de segundo precio, la estrategia dominante de cada postor es revelar con absoluta sinceridad su verdadera valoración.</p>'),
    HTML('<p><strong>Contribución Nobel 1996:</strong> William Vickrey y James Mirrlees sentaron los cimientos de la economía de incentivos bajo información asimétrica.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "elasticidad_trabajo", value = 0.3)
    updateSliderInput(session, "preferencia_social", value = 1.5)
  })

    datos <- reactive({
      el <- input$elasticidad_trabajo
      g_soc <- input$preferencia_social
      
      # Estructura de tasas marginales optimas de Mirrlees en forma de U invertida:
      # Cero en el tope superior (para no destruir incentivos al maximo talento) y moderada en el centro
      ingresos <- seq(10, 200, length.out = 100)
      tasa_marginal <- (g_soc / (1 + el * 2)) * (ingresos / 100) * exp(-ingresos / 120) * 1.8
      tasa_marginal <- pmax(5, pmin(70, tasa_marginal * 100))
      
      list(ing = ingresos, t_mg = tasa_marginal)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$ing, d$t_mg, type = "l", col = "#8e44ad", lwd = 3,
           xlab = "Nivel de ingreso del contribuyente (miles de $)",
           ylab = "Tasa impositiva marginal óptima (%)",
           ylim = c(0, 75), main = "Curva Impositiva Óptima de Mirrlees (1971)")
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Resultado central de Mirrlees:"),
        tags$p(sprintf("La tasa impositiva marginal alcanza un pico máximo del %.1f%% en tramos medios y desciende para ingresos extremadamente altos, resolviendo la compatibilidad de incentivos entre recaudación fiscal y motivación productiva.",
                       max(d$t_mg)))
      )
    })
}

shinyApp(ui = ui, server = server)

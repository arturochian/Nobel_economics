# laureados/1995_lucas/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1995 · Expectativas racionales y la Crítica de Lucas",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("sorpresa_politica", "Magnitud de la sorpresa monetaria no anticipada (%)", min = 0, max = 10, value = 4, step = 0.5),
    checkboxInput("politica_anunciada", "¿La política fue anunciada y anticipada por el público?", value = FALSE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Robert E. Lucas Jr.: las relaciones econométricas del pasado colapsan cuando el gobierno cambia su regla de política económica.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>La célebre \'Crítica de Lucas\' (1976) advirtió que usar parámetros históricos para predecir el impacto de nuevas políticas conduce al desastre: cuando las reglas del juego cambian, las expectativas y conductas de los ciudadanos cambian con ellas.</p>'),
    HTML('<p><strong>Contribución Nobel 1995:</strong> Robert Lucas Jr. transformó por completo el análisis macroeconómico, exigiendo que todos los modelos modernos posean microfundamentos y expectativas racionales.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "sorpresa_politica", value = 4)
    updateCheckboxInput(session, "politica_anunciada", value = FALSE)
  })

    datos <- reactive({
      shock <- input$sorpresa_politica
      anticipada <- input$politica_anunciada
      
      # Curva de oferta de Lucas (modelo de islas):
      # y = y_n + alfa * (pi - pi^e)
      # Si es anticipada, pi^e = pi => y = y_n (neutralidad del dinero)
      if (anticipada) {
        efecto_pib <- 0.0
        inflacion <- shock
      } else {
        efecto_pib <- shock * 0.75 # Expansion transitoria
        inflacion <- shock * 0.5
      }
      
      list(pib = efecto_pib, inf = inflacion, ant = anticipada)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      resultados <- c(d$pib, d$inf)
      bp <- barplot(resultados, names.arg = c("Efecto en el PIB Real (pp)", "Aumento de Inflación (pp)"),
                    col = c("#2980b9", "#c0392b"),
                    ylab = "Desviación del equilibrio base",
                    ylim = c(0, max(8, resultados + 2)),
                    main = ifelse(d$ant, "Política Anunciada: Neutralidad Monetaria Total", "Política Sorpresa: Expansión Transitoria"))
      text(bp, resultados + 0.3, sprintf("+%.2f pp", resultados), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      if (d$ant) {
        tags$div(
          class = "alert alert-warning mt-3",
          tags$strong("Crítica de Lucas comprobada:"),
          " Cuando la política es anticipada, los agentes racionales ajustan sus precios y contratos inmediatamente. El dinero es neutral: el estímulo no genera ningún empleo adicional y solo crea inflación pura."
        )
      } else {
        tags$div(
          class = "alert alert-info mt-3",
          tags$strong("Efecto sorpresa transitorio:"),
          sprintf(" Al no haber sido prevista, la sorpresa monetaria engaña temporalmente a las empresas (confunden inflación general con demanda sectorial), elevando el PIB en +%.2f pp.", d$pib)
        )
      }
    })
}

shinyApp(ui = ui, server = server)

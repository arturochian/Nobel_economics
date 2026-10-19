# laureados/1986_buchanan/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1986 · Elección Pública y Costos de Votación (Buchanan)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("regla_mayoria", "Regla de votación requerida (% del congreso)", min = 50, max = 100, value = 51, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("James M. Buchanan (El Cálculo del Consenso, 1962): los políticos y burócratas actúan como agentes maximizadores de su propio interés, no del bienestar colectivo abstracto.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>James Buchanan fundó la Teoría de la Elección Pública (Public Choice) al aplicar el rigor analítico de la microeconomía al proceso político: los gobernantes y grupos de presión no persiguen desinteresadamente el \'bien común\', sino rentas electorales y presupuestarias.</p>'),
    HTML('<p><strong>Contribución Nobel 1986:</strong> James M. Buchanan desarrolló las bases contractuales y constitucionales de la toma de decisiones políticas y económicas.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "regla_mayoria", value = 51)
  })

    datos <- reactive({
      K <- input$regla_mayoria
      
      # Buchanan & Tullock (1962):
      # Costos externos de decision D(K) (tirania de la mayoria sobre la minoria) disminuyen con K
      # Costos de decision C(K) (tiempo y dificultad para lograr acuerdo) aumentan con K
      k_grid <- 1:100
      costos_externos <- 100 * exp(-k_grid / 25)
      costos_acuerdo <- 2 * exp(k_grid / 25)
      costo_total <- costos_externos + costos_acuerdo
      
      opt_k <- which.min(costo_total)
      
      ce_actual <- 100 * exp(-K / 25)
      ca_actual <- 2 * exp(K / 25)
      ct_actual <- ce_actual + ca_actual
      
      list(k = k_grid, ce = costos_externos, ca = costos_acuerdo, ct = costo_total,
           K = K, ct_act = ct_actual, opt_k = opt_k)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$k, d$ct, type = "l", col = "#8e44ad", lwd = 3,
           xlab = "Regla de votación (% de votos requeridos)",
           ylab = "Costos constitucionales",
           ylim = c(0, 110), main = "Regla de Decisión Óptima de Buchanan & Tullock")
      lines(d$k, d$ce, col = "#c0392b", lwd = 2, lty = 2)
      lines(d$k, d$ca, col = "#2980b9", lwd = 2, lty = 2)
      abline(v = d$K, col = "#f39c12", lwd = 2, lty = 3)
      grid()
      legend("topright", legend = c("Costo Total Constitucional", "Costos Externos (Tiranía)", "Costos de Negociación"),
             col = c("#8e44ad", "#c0392b", "#2980b9"), lwd = c(3, 2, 2), lty = c(1, 2, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Diseño Constitucional:"),
        tags$p(sprintf("Para la regla del %d%%, el costo constitucional total es de %.1f unidades. La regla teórica que minimiza el costo total se sitúa en torno al %d%% de los votos.",
                       d$K, d$ct_act, d$opt_k))
      )
    })
}

shinyApp(ui = ui, server = server)

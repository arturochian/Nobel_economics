# laureados/2024_acemoglu_johnson_robinson/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2024 · Instituciones coloniales y desarrollo a largo plazo",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("mortalidad", "Log mortalidad de colonos europeos", min = 2.0, max = 8.0, value = 4.5, step = 0.2),
    sliderInput("efecto_inst", "Efecto causal de instituciones (beta 2SLS)", min = 0.3, max = 1.5, value = 0.94, step = 0.05),
    checkboxInput("mostrar_ols", "Comparar con sesgo MCO (OLS)", value = TRUE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("AJR (2001): la mortalidad de colonos determina las instituciones extractivas o inclusivas, y estas explican el PIB per cápita actual.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>La gráfica izquierda muestra la <strong>primera etapa</strong>: donde los colonos enfrentaron alta mortalidad por malaria o fiebre amarilla, establecieron estados extractivos sin proteger derechos de propiedad. La gráfica derecha muestra la <strong>ecuación estructural</strong>: cómo esas instituciones heredadas explican la enorme brecha de riqueza mundial actual.</p>'),
    HTML('<p><strong>Contribución Nobel 2024:</strong> Daron Acemoglu, Simon Johnson y James A. Robinson resolvieron el dilema de causalidad inversa utilizando la mortalidad histórica de colonos como instrumento exógeno de las instituciones modernas.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "mortalidad", value = 4.5)
    updateSliderInput(session, "efecto_inst", value = 0.94)
    updateCheckboxInput(session, "mostrar_ols", value = TRUE)
  })

    datos <- reactive({
      # Simulacion calibrada con los 64 paises de la muestra base AJR (2001)
      set.seed(2024)
      n <- 64
      log_mort <- seq(2.5, 7.8, length.out = n)
      # Primera etapa: avexpr = 9.5 - 0.6 * log_mort + e
      instituciones <- 9.5 - 0.6 * log_mort + rnorm(n, 0, 0.7)
      instituciones <- pmax(3, pmin(10, instituciones))
      # Segunda etapa estructural: logpgp = alpha + beta * instituciones + u
      log_pib <- 4.0 + input$efecto_inst * instituciones + rnorm(n, 0, 0.4)
      
      # Prediccion puntual para el slider
      inst_pred <- 9.5 - 0.6 * input$mortalidad
      pib_pred <- 4.0 + input$efecto_inst * inst_pred
      
      list(log_mort = log_mort, inst = instituciones, pib = log_pib,
           inst_pred = inst_pred, pib_pred = pib_pred)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Panel 1: Primera etapa
      plot(d$log_mort, d$inst, pch = 19, col = "#2980b9",
           xlab = "Log mortalidad de colonos (siglos XVIII-XIX)",
           ylab = "Protección de derechos de propiedad (avexpr)",
           main = "1ra Etapa: Mortalidad -> Instituciones")
      abline(lm(d$inst ~ d$log_mort), col = "#c0392b", lwd = 2)
      points(input$mortalidad, d$inst_pred, pch = 21, bg = "#f1c40f", cex = 2.2, lwd = 2)
      grid()

      # Panel 2: Ecuacion estructural 2SLS
      plot(d$inst, d$pib, pch = 19, col = "#27ae60",
           xlab = "Calidad institucional (avexpr)",
           ylab = "Log PIB per cápita (1995)",
           main = "2da Etapa: Instituciones -> PIB")
      mod_iv <- lm(d$pib ~ d$inst)
      abline(mod_iv, col = "#8e44ad", lwd = 2.5)
      if (input$mostrar_ols) {
        # OLS sesgado hacia arriba por causalidad inversa
        abline(a = 3.2, b = 0.52, col = "#7f8c8d", lwd = 2, lty = 2)
        legend("topleft", legend = c("Efecto causal 2SLS (IV)", "Sesgo MCO (OLS)"),
               col = c("#8e44ad", "#7f8c8d"), lwd = c(2.5, 2), lty = c(1, 2), bty = "n")
      }
      points(d$inst_pred, d$pib_pred, pch = 21, bg = "#f1c40f", cex = 2.2, lwd = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Predicción del modelo para el país seleccionado:"),
        tags$p(sprintf("Con log-mortalidad = %.1f, el índice de instituciones esperado es %.2f (de 10), y el PIB per cápita proyectado es de US$ %s.",
                       input$mortalidad, d$inst_pred, format(round(exp(d$pib_pred)), big.mark = ",")))
      )
    })
}

shinyApp(ui = ui, server = server)

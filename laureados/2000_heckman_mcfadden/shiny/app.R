# laureados/2000_heckman_mcfadden/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2000 · Microeconometría: Corrección de Heckman y McFadden Logit",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("rho_seleccion", "Correlación de factores no observados (rho de Heckman)", min = -0.8, max = 0.8, value = 0.5, step = 0.1),
    sliderInput("tasa_participacion", "Tasa de participación laboral femenina (%)", min = 30, max = 80, value = 55, step = 5),
    checkboxInput("corregir_sesgo", "Aplicar Corrección en Dos Etapas de Heckman", value = TRUE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("James Heckman (sesgo de selección y razón inversa de Mills) y Daniel McFadden (modelos de elección discreta).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>James Heckman descubrió que analizar muestras no aleatorias (como los salarios de mujeres que optan por trabajar) equivale a un problema de variable omitida, diseñando el procedimiento bietápico de corrección \'Heckit\'. Daniel McFadden formuló el modelo logit condicional que permite predecir elecciones discretas entre alternativas de transporte o consumo.</p>'),
    HTML('<p><strong>Contribución Nobel 2000:</strong> Desarrollaron las herramientas metodológicas fundamentales para el análisis cuantitativo de microdatos de individuos y empresas.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "rho_seleccion", value = 0.5)
    updateSliderInput(session, "tasa_participacion", value = 55)
    updateCheckboxInput(session, "corregir_sesgo", value = TRUE)
  })

    datos <- reactive({
      rho <- input$rho_seleccion
      part <- input$tasa_participacion / 100
      
      # Retorno real a la educacion (beta verdadero = 8.0%)
      beta_verdadero <- 8.0
      
      # Razon inversa de Mills promedio (lambda)
      z <- qnorm(part)
      lambda_mills <- dnorm(z) / part
      
      # Sesgo en estimacion MCO sin corregir: beta_ols = beta + sesgo
      sesgo_ols <- rho * 3.5 * lambda_mills * 0.4
      beta_ols <- beta_verdadero + sesgo_ols
      
      beta_estimado <- if (input$corregir_sesgo) beta_verdadero else beta_ols
      
      list(beta_v = beta_verdadero, beta_ols = beta_ols, beta_est = beta_estimado,
           lambda = lambda_mills, sesgo = sesgo_ols)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      betas <- c(d$beta_v, d$beta_ols, d$beta_est)
      bp <- barplot(betas, names.arg = c("Efecto Real Causal", "MCO Sesgado (Sin Corrección)", "Estimador Heckit (2 Etapas)"),
                    col = c("#7f8c8d", "#c0392b", "#27ae60"),
                    ylab = "Retorno salarial por año de educación (%)",
                    ylim = c(0, max(betas) * 1.3),
                    main = "Corrección de Sesgo de Selección de Heckman (1979)")
      text(bp, betas + 0.5, sprintf("%.2f%%", betas), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Impacto del sesgo de selección muestral:"),
        tags$p(sprintf("Dado que solo observamos salarios de quienes deciden trabajar, el estimador tradicional de MCO se desvía en %+.2f puntos porcentuales (retorno aparente de %.2f%%). El método Heckit elimina este sesgo utilizando la razón inversa de Mills (lambda = %.2f).",
                       d$sesgo, d$beta_ols, d$lambda))
      )
    })
}

shinyApp(ui = ui, server = server)

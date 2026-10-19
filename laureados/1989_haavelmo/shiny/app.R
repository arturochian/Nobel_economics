# laureados/1989_haavelmo/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1989 · El enfoque probabilístico en econometría (Haavelmo)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("simultaneidad", "Fuerza de la retroalimentación simultánea de oferta y demanda", min = 0.1, max = 0.9, value = 0.5, step = 0.05),
    checkboxInput("corregir_iv", "Estimar con Variables Instrumentales (2SLS)", value = TRUE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Trygve Haavelmo (1944): la econometría requiere modelos probabilísticos de ecuaciones simultáneas para no incurrir en sesgos graves.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Trygve Haavelmo publicó en 1944 el manifiesto fundacional que transformó la econometría de un simple ajuste de curvas deterministas a una disciplina rigurosa basada en la teoría de la probabilidad y la identificación de sistemas simultáneos.</p>'),
    HTML('<p><strong>Contribución Nobel 1989:</strong> Trygve Haavelmo estableció los cimientos probabilísticos de la econometría moderna.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "simultaneidad", value = 0.5)
    updateCheckboxInput(session, "corregir_iv", value = TRUE)
  })

    datos <- reactive({
      rho <- input$simultaneidad
      # Elasticidad real verdadera = -1.0
      beta_verdadero <- -1.0
      # Sesgo de ecuaciones simultaneas de MCO
      beta_ols <- beta_verdadero + rho * 0.85
      beta_estimado <- if (input$corregir_iv) beta_verdadero else beta_ols
      
      list(beta_v = beta_verdadero, beta_ols = beta_ols, beta_est = beta_estimado)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      betas <- c(abs(d$beta_v), abs(d$beta_ols), abs(d$beta_est))
      bp <- barplot(betas, names.arg = c("Valor Real Causal", "MCO Sesgado (Simultaneidad)", "Estimador Haavelmo (IV / 2SLS)"),
                    col = c("#7f8c8d", "#c0392b", "#27ae60"),
                    ylab = "Magnitud de la pendiente estimada |beta|",
                    ylim = c(0, 1.5),
                    main = "Sesgo de Ecuaciones Simultáneas de Haavelmo")
      text(bp, betas + 0.05, sprintf("%.2f", betas), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Lección metodológica de Haavelmo:"),
        tags$p(sprintf("Dado que el precio y la cantidad se determinan simultáneamente en el mercado, el estimador simple MCO produce un parámetro sesgado de %.2f. El enfoque probabilístico de Haavelmo restaura el parámetro verdadero (-1.00).",
                       d$beta_ols))
      )
    })
}

shinyApp(ui = ui, server = server)

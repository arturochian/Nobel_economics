# laureados/2003_engle_granger/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2003 · Volatilidad financiera (ARCH) y Cointegración",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("alpha_arch", "Persistencia de choques de volatilidad (alfa ARCH)", min = 0.1, max = 0.9, value = 0.65, step = 0.05),
    sliderInput("omega", "Varianza base incondicional (omega)", min = 0.05, max = 0.50, value = 0.15, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Robert Engle (modelos ARCH de volatilidad cambiante en finanzas) y Clive Granger (análisis de cointegración).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Robert Engle descubrió que en los mercados financieros la volatilidad no es constante: días de grandes oscilaciones son seguidos por más oscilaciones (volatility clustering). Clive Granger resolvió la trampa de la regresión espuria demostrando cómo analizar series no estacionarias que comparten tendencias comunes (cointegración).</p>'),
    HTML('<p><strong>Contribución Nobel 2003:</strong> Robert Engle y Clive Granger revolucionaron la econometría de series temporales y la gestión moderna del riesgo financiero.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "alpha_arch", value = 0.65)
    updateSliderInput(session, "omega", value = 0.15)
  })

    datos <- reactive({
      set.seed(2003)
      n <- 200
      omega <- input$omega
      alpha <- input$alpha_arch
      
      eps <- numeric(n)
      sigma2 <- numeric(n)
      sigma2[1] <- omega / (1 - alpha)
      eps[1] <- rnorm(1, 0, sqrt(sigma2[1]))
      
      for (t in 2:n) {
        sigma2[t] <- omega + alpha * (eps[t - 1]^2)
        eps[t] <- rnorm(1, 0, sqrt(sigma2[t]))
      }
      
      list(t = 1:n, ret = eps, sig = sqrt(sigma2))
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Retornos con agrupamiento de volatilidad
      plot(d$t, d$ret, type = "l", col = "#2c3e50", lwd = 1.2,
           xlab = "Días de negociación", ylab = "Rendimiento bursátil diario (%)",
           main = "Rendimientos Financieros con Clústeres")
      grid()

      # Volatilidad condicional estimada
      plot(d$t, d$sig, type = "l", col = "#c0392b", lwd = 2,
           xlab = "Días de negociación", ylab = "Volatilidad condicional (sigma_t)",
           main = "Proceso ARCH(1) de Engle")
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Detección de heterocedasticidad condicional:"),
        tags$p(sprintf("Con alfa = %.2f, los periodos de turbulencia bursátil se retroalimentan y agrupan en el tiempo, permitiendo medir el riesgo financiero y calcular métricas como el Value at Risk (VaR).",
                       input$alpha_arch))
      )
    })
}

shinyApp(ui = ui, server = server)

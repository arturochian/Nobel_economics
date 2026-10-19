# laureados/2013_fama_hansen_shiller/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2013 · Precios de activos: Eficiencia (Fama) vs. Volatilidad (Shiller)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("tasa_descuento", "Tasa de descuento esperada (r)", min = 0.03, max = 0.10, value = 0.06, step = 0.01),
    sliderInput("psicologia_mercado", "Amplificación por exceso de optimismo/pánico", min = 0.5, max = 3.0, value = 1.8, step = 0.1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Fama (mercados eficientes), Hansen (método GMM) y Shiller (exceso de volatilidad y predictibilidad a largo plazo).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Eugene Fama demostró que a corto plazo los precios bursátiles son casi imposibles de predecir porque incorporan inmediatamente la información disponible. Robert Shiller demostró que a plazos largos (5-10 años) los precios sufren de exceso de volatilidad y pueden predecirse mediante métricas como el ratio CAPE.</p>'),
    HTML('<p><strong>Contribución Nobel 2013:</strong> Eugene Fama, Lars Peter Hansen y Robert Shiller construyeron la base moderna de la valoración empírica de activos financieros.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "tasa_descuento", value = 0.06)
    updateSliderInput(session, "psicologia_mercado", value = 1.8)
  })

    datos <- reactive({
      set.seed(2013)
      t_anios <- 1:40
      
      # Serie de dividendos (camino aleatorio con crecimiento)
      divs <- 2.0 * exp(0.02 * t_anios + cumsum(rnorm(40, 0, 0.03)))
      
      # Precio fundamental segun Fama (valor presente descontado perfecto p*)
      r <- input$tasa_descuento
      g <- 0.02
      p_fundamental <- divs / (r - g)
      
      # Precio observado de mercado segun Shiller (con olas de euforia/panico)
      ruido_shiller <- sin(t_anios / 3.5) * input$psicologia_mercado * 15
      p_mercado <- p_fundamental + ruido_shiller + rnorm(40, 0, 4)
      
      list(t = t_anios, p_fund = p_fundamental, p_mkt = p_mercado)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$t, d$p_mkt, type = "l", col = "#c0392b", lwd = 2.5,
           ylim = c(min(d$p_mkt, d$p_fund) * 0.8, max(d$p_mkt, d$p_fund) * 1.2),
           xlab = "Horizonte temporal (años)", ylab = "Índice de precios accionarios ($)",
           main = "Prueba de Exceso de Volatilidad de Shiller (1981)")
      lines(d$t, d$p_fund, col = "#2980b9", lwd = 3, lty = 2)
      grid()
      legend("topleft", legend = c("Precio de Mercado Observado (Shiller)", "Valor Presente Fundamental (Fama p*)"),
             col = c("#c0392b", "#2980b9"), lwd = c(2.5, 3), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      vol_mkt <- sd(diff(log(d$p_mkt)))
      vol_fund <- sd(diff(log(d$p_fund)))
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Contraste empírico del mercado:"),
        tags$p(sprintf("Volatilidad de precios bursátiles: %.2f%% anual vs. Volatilidad de fundamentales de dividendos: %.2f%% anual. La volatilidad observada supera en %.1fx al fundamento económico, confirmando la tesis de Shiller.",
                       vol_mkt * 100, vol_fund * 100, vol_mkt / vol_fund))
      )
    })
}

shinyApp(ui = ui, server = server)

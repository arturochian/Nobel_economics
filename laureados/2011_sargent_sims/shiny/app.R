# laureados/2011_sargent_sims/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2011 · Causa y efecto en macroeconomía (SVAR y Expectativas)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("shock_tasa", "Magnitud del shock en tasa de interés (pb)", min = 25, max = 300, value = 100, step = 25),
    sliderInput("persistencia", "Inercia de la política monetaria", min = 0.3, max = 0.9, value = 0.7, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Christopher Sims (vectores autorregresivos SVAR) y Thomas Sargent (expectativas racionales y política económica).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Christopher Sims introdujo los modelos de Vectores Autorregresivos (VAR) para analizar la causalidad macroeconómica sin imponer restricciones teóricas arbitrarias. Thomas Sargent exploró cómo las expectativas racionales condicionan el éxito de las políticas fiscales y monetarias.</p>'),
    HTML('<p><strong>Contribución Nobel 2011:</strong> Thomas Sargent y Christopher Sims diseñaron las herramientas estándar con las que todos los bancos centrales del mundo evalúan hoy el impacto de sus decisiones.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "shock_tasa", value = 100)
    updateSliderInput(session, "persistencia", value = 0.7)
  })

    datos <- reactive({
      h <- 0:20 # Trimestres tras el shock
      shock <- input$shock_tasa / 100
      rho <- input$persistencia
      
      # Trayectoria tasa de interes
      irf_tasa <- shock * (rho^h)
      # Respuesta del PIB (cae y se recupera con joroba)
      irf_pib <- -0.45 * shock * (h * exp(-h / 3.0))
      # Respuesta de inflacion
      irf_inf <- -0.25 * shock * (h * exp(-h / 4.0))
      
      list(h = h, tasa = irf_tasa, pib = irf_pib, inf = irf_inf)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Panel 1: Tasa
      plot(d$h, d$tasa, type = "b", pch = 19, col = "#2980b9", lwd = 2.5,
           xlab = "Trimestres tras el shock", ylab = "Variación de tasa de interés (pp)",
           main = "Shock de Política Monetaria")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      grid()

      # Panel 2: Respuesta PIB e Inflacion
      plot(d$h, d$pib, type = "l", col = "#c0392b", lwd = 3,
           ylim = c(min(d$pib, d$inf) * 1.2, 0.2),
           xlab = "Trimestres tras el shock", ylab = "Variación porcentual (%)",
           main = "Función Impulso-Respuesta (IRF)")
      lines(d$h, d$inf, col = "#e67e22", lwd = 2.5, lty = 2)
      abline(h = 0, lty = 2, col = "#7f8c8d")
      grid()
      legend("bottomright", legend = c("Brecha de PIB", "Inflación"),
             col = c("#c0392b", "#e67e22"), lwd = c(3, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Transmisión del shock monetario:"),
        tags$p(sprintf("Una subida sorpresiva de %d pb enfría la actividad económica alcanzando una caída máxima de %.2f%% en el PIB hacia el trimestre %d, con moderación gradual de la inflación.",
                       input$shock_tasa, abs(min(d$pib)), which.min(d$pib) - 1))
      )
    })
}

shinyApp(ui = ui, server = server)

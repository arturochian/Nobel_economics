# laureados/1990_markowitz_miller_sharpe/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1990 · Teoría de Portafolios y Modelo CAPM (Markowitz & Sharpe)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("correlacion", "Correlación entre dos activos (rho)", min = -0.9, max = 0.9, value = 0.2, step = 0.1),
    sliderInput("peso_a", "Proporción invertida en Activo A (%)", min = 0, max = 100, value = 50, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Markowitz (frontera eficiente de varianza mínima), William Sharpe (CAPM y beta de mercado) y Merton Miller (finanzas corporativas).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Harry Markowitz demostró matemáticamente en 1952 que un inversor no debe juzgar un activo por su riesgo individual aislado, sino por cómo aporta al riesgo del conjunto del portafolio. William Sharpe derivó el Capital Asset Pricing Model (CAPM) mostrando que el único riesgo recompensado es el riesgo sistemático no diversificable (Beta).</p>'),
    HTML('<p><strong>Contribución Nobel 1990:</strong> Harry Markowitz, Merton Miller y William Sharpe crearon las finanzas modernas como una disciplina científica cuantitativa.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "correlacion", value = 0.2)
    updateSliderInput(session, "peso_a", value = 50)
  })

    datos <- reactive({
      rho <- input$correlacion
      w_a <- input$peso_a / 100
      w_b <- 1 - w_a
      
      # Retornos esperados y desvíos estándar
      r_a <- 12.0; sd_a <- 20.0
      r_b <- 6.0;  sd_b <- 10.0
      
      # Portafolio
      r_p <- w_a * r_a + w_b * r_b
      var_p <- (w_a * sd_a)^2 + (w_b * sd_b)^2 + 2 * w_a * w_b * sd_a * sd_b * rho
      sd_p <- sqrt(var_p)
      
      # Frontera completa para graficar
      w_seq <- seq(0, 1, length.out = 100)
      r_curve <- w_seq * r_a + (1 - w_seq) * r_b
      sd_curve <- sqrt((w_seq * sd_a)^2 + ((1 - w_seq) * sd_b)^2 + 2 * w_seq * (1 - w_seq) * sd_a * sd_b * rho)
      
      list(r_p = r_p, sd_p = sd_p, r_c = r_curve, sd_c = sd_curve)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$sd_c, d$r_c, type = "l", col = "#2980b9", lwd = 3,
           xlab = "Riesgo de la cartera (Desviación Estándar %)",
           ylab = "Retorno Esperado (%)",
           xlim = c(5, 22), ylim = c(5, 13),
           main = "Frontera Eficiente de Markowitz")
      points(d$sd_p, d$r_p, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      text(d$sd_p + 0.8, d$r_p, "Portafolio Actual", col = "#e74c3c", font = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Poder de la Diversificación de Markowitz:"),
        tags$p(sprintf("Con una correlación rho = %.1f y ponderación del %.0f%% en el activo A, el portafolio alcanza un retorno esperado del %.2f%% con un riesgo total de solo %.2f%%, demostrando que diversificar activos no correlacionados reduce el riesgo sin sacrificar rendimiento.",
                       input$correlacion, input$peso_a, d$r_p, d$sd_p))
      )
    })
}

shinyApp(ui = ui, server = server)

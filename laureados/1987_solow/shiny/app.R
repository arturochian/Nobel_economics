# laureados/1987_solow/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1987 · El Modelo de Crecimiento Neoclásico de Solow",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("tasa_ahorro", "Tasa de ahorro e inversión (s %)", min = 5, max = 40, value = 20, step = 1),
    sliderInput("depreciacion", "Tasa de depreciación del capital (delta %)", min = 2, max = 10, value = 5, step = 0.5),
    sliderInput("crec_poblacion", "Crecimiento de la población (n %)", min = 0.5, max = 4.0, value = 1.5, step = 0.5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Robert M. Solow (1956): a largo plazo el ahorro determina el nivel de capital de estado estacionario, pero solo el progreso tecnológico explica el crecimiento continuo per cápita.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Robert Solow demostró que aumentar la tasa de ahorro eleva el nivel de vida temporalmente pero no la tasa de crecimiento tendencial a largo plazo: el crecimiento sostenido del PIB per cápita sólo puede explicarse por el residuo de Solow (avance tecnológico y productividad total de los factores).</p>'),
    HTML('<p><strong>Contribución Nobel 1987:</strong> Robert Solow construyó el modelo canónico del crecimiento económico sobre el que se apoya toda la macroeconomía moderna.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "tasa_ahorro", value = 20)
    updateSliderInput(session, "depreciacion", value = 5)
    updateSliderInput(session, "crec_poblacion", value = 1.5)
  })

    datos <- reactive({
      s <- input$tasa_ahorro / 100
      delta <- input$depreciacion / 100
      n <- input$crec_poblacion / 100
      alpha <- 0.35 # Participacion del capital
      
      # Capital de estado estacionario k* = (s / (n + delta))^(1 / (1 - alpha))
      k_star <- (s / (n + delta))^(1 / (1 - alpha))
      y_star <- k_star^alpha
      c_star <- (1 - s) * y_star
      
      # Curvas de produccion e inversion
      k_seq <- seq(0.1, max(k_star * 1.6, 15), length.out = 150)
      inv_seq <- s * (k_seq^alpha)
      dep_seq <- (n + delta) * k_seq
      
      list(k_star = k_star, y_star = y_star, c_star = c_star,
           k_seq = k_seq, inv = inv_seq, dep = dep_seq)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$k_seq, d$inv, type = "l", col = "#27ae60", lwd = 3,
           xlab = "Capital por trabajador (k)", ylab = "Inversión y Depreciación per cápita",
           ylim = c(0, max(d$inv, d$dep) * 1.1),
           main = "Estado Estacionario en el Modelo de Solow")
      lines(d$k_seq, d$dep, col = "#c0392b", lwd = 2.5, lty = 2)
      abline(v = d$k_star, col = "#2980b9", lwd = 2, lty = 3)
      points(d$k_star, (input$tasa_ahorro/100) * (d$k_star^0.35), pch = 21, bg = "#f1c40f", cex = 2.2, lwd = 2)
      grid()
      legend("topleft", legend = c("Inversión s * f(k)", "Depreciación de reposición (n + delta) * k"),
             col = c("#27ae60", "#c0392b"), lwd = c(3, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Estado Estacionario Alcanzado:"),
        tags$p(sprintf("Capital por trabajador k* = %.2f | PIB por trabajador y* = %.2f | Consumo per cápita c* = %.2f. La acumulación de capital cesa cuando la inversión iguala exactamente la depreciación y el crecimiento poblacional.",
                       d$k_star, d$y_star, d$c_star))
      )
    })
}

shinyApp(ui = ui, server = server)

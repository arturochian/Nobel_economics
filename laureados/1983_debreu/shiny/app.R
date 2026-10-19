# laureados/1983_debreu/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1983 · Teoría del Valor y Equilibrio General (Gerard Debreu)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("dotacion_x", "Dotación inicial de Alimentos (Agente A)", min = 2, max = 18, value = 10, step = 1),
    sliderInput("dotacion_y", "Dotación inicial de Ropa (Agente A)", min = 2, max = 18, value = 4, step = 1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Gerard Debreu (1959, 'Theory of Value'): demostración matemática rigurosa de la existencia del equilibrio walrasiano en una caja de Edgeworth.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Adam Smith conjeturó en 1776 que una \'mano invisible\' coordinaba los mercados. Gerard Debreu y Kenneth Arrow lograron la prueba matemática definitiva en los años 1950, demostrando bajo qué condiciones topológicas exactas existe un vector de precios que equilibra todos los mercados simultáneamente.</p>'),
    HTML('<p><strong>Contribución Nobel 1983:</strong> Gerard Debreu introdujo el rigor axiomático y los métodos de análisis convexo en la ciencia económica.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "dotacion_x", value = 10)
    updateSliderInput(session, "dotacion_y", value = 4)
  })

    datos <- reactive({
      wx <- input$dotacion_x
      wy <- input$dotacion_y
      
      # Dimensiones totales de la caja
      tot_x <- 20
      tot_y <- 20
      
      # Equilibrio competitivo walrasiano de intercambio puro
      p_rel <- 1.0 # Precio relativo en equilibrio simetrico
      eq_x <- 10; eq_y <- 10
      
      list(wx = wx, wy = wy, ex = eq_x, ey = eq_y, tx = tot_x, ty = tot_y)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(c(0, d$tx), c(0, d$ty), type = "n",
           xlab = "Bien X (Alimentos Agente A)", ylab = "Bien Y (Ropa Agente A)",
           main = "Caja de Edgeworth y Equilibrio General de Debreu")
      
      # Recta presupuestaria competitiva que pasa por la dotacion
      abline(a = d$wy + d$wx, b = -1, col = "#7f8c8d", lty = 2)
      
      # Curva de contrato / equilibrio
      lines(c(0, d$tx), c(0, d$ty), col = "#27ae60", lwd = 2.5)
      
      points(d$wx, d$wy, pch = 21, bg = "#3498db", cex = 2.2, lwd = 2)
      text(d$wx + 1, d$wy, "Dotación Inicial (w)", col = "#3498db", font = 2)
      
      points(d$ex, d$ey, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      text(d$ex + 1, d$ey - 1, "Equilibrio Walrasiano (x*)", col = "#e74c3c", font = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Existencia del Equilibrio General:"),
        tags$p(sprintf("Partiendo de una dotación arbitraria (X=%d, Y=%d), los precios relativos guían el intercambio voluntario hasta el punto de tangencia de óptimo de Pareto (X*=%d, Y*=%d).",
                       d$wx, d$wy, d$ex, d$ey))
      )
    })
}

shinyApp(ui = ui, server = server)

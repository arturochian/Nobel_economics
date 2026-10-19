# laureados/2007_hurwicz_maskin_myerson/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2007 · Diseño de mecanismos y subastas óptimas (Myerson)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("valor_esperado", "Valor promedio esperado del postor ($)", min = 40, max = 150, value = 100, step = 5),
    sliderInput("dispersion", "Dispersión de valoraciones privadas ($)", min = 10, max = 50, value = 30, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Hurwicz, Maskin y Myerson: teoría de diseño de mecanismos y principio de revelación para diseñar reglas óptimas.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Leonid Hurwicz concibió la teoría de diseño de mecanismos preguntándose qué reglas e incentivos permiten alcanzar objetivos sociales cuando la información está dispersa. Eric Maskin desarrolló la teoría de implementación y Roger Myerson derivó la forma de la subasta óptima con información privada.</p>'),
    HTML('<p><strong>Contribución Nobel 2007:</strong> Sentaron las bases de la ingeniería económica para subastas de telecomunicaciones, asignación de emisiones y regulación pública.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "valor_esperado", value = 100)
    updateSliderInput(session, "dispersion", value = 30)
  })

    datos <- reactive({
      v_bar <- input$valor_esperado
      sigma <- input$dispersion
      
      # Ingreso virtual de Myerson: J(v) = v - (1 - F(v))/f(v)
      # Para distribucion uniforme U[v_min, v_max]:
      v_min <- max(0, v_bar - sigma)
      v_max <- v_bar + sigma
      
      # J(v) = 2*v - v_max
      # Precio de reserva optimo donde J(r*) = 0  => r* = v_max / 2
      r_star <- v_max / 2
      
      v_grid <- seq(v_min, v_max, length.out = 100)
      J_grid <- 2 * v_grid - v_max
      
      list(v_min = v_min, v_max = v_max, r = r_star, vg = v_grid, Jg = J_grid)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$vg, d$Jg, type = "l", col = "#8e44ad", lwd = 3,
           xlab = "Valoración privada del comprador (v)", ylab = "Ingreso virtual de Myerson J(v)",
           main = "Ingreso Virtual y Precio de Reserva Óptimo")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      abline(v = d$r, lty = 3, col = "#e74c3c", lwd = 2)
      text(d$r + 1, -10, sprintf("Precio Reserva r* = $%.1f", d$r), col = "#e74c3c", font = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Diseño óptimo de la subasta:"),
        tags$p(sprintf("Para compradores con valoraciones entre $%d y $%d, el vendedor maximiza su recaudación fijando un precio de reserva estricto de $%.1f, aunque eso implique el riesgo de que el bien quede sin vender.",
                       d$v_min, d$v_max, d$r))
      )
    })
}

shinyApp(ui = ui, server = server)

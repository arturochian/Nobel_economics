# laureados/2010_diamond_mortensen_pissarides/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2010 · Fricciones de búsqueda y desempleo (Modelo DMP)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("costo_vacante", "Costo de mantener una vacante abierta (c)", min = 0.1, max = 0.8, value = 0.35, step = 0.05),
    sliderInput("productividad", "Productividad del trabajador (p)", min = 0.8, max = 2.0, value = 1.2, step = 0.1),
    sliderInput("tasa_destruccion", "Tasa de separación laboral (s)", min = 0.01, max = 0.08, value = 0.03, step = 0.005),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Diamond, Mortensen & Pissarides: en presencia de costos de emparejamiento coexisten desempleo y vacantes desiertas.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>El modelo Diamond-Mortensen-Pissarides (DMP) explica por qué incluso en una economía próspera persisten trabajadores sin empleo y empresas con vacantes vacías: emparejar personas con puestos adecuados toma tiempo y consume recursos reales.</p>'),
    HTML('<p><strong>Contribución Nobel 2010:</strong> Peter Diamond, Dale Mortensen y Christopher Pissarides crearon el marco analítico líder para evaluar seguros de desempleo y políticas activas de empleo.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "costo_vacante", value = 0.35)
    updateSliderInput(session, "productividad", value = 1.2)
    updateSliderInput(session, "tasa_destruccion", value = 0.03)
  })

    datos <- reactive({
      c <- input$costo_vacante
      p <- input$productividad
      s <- input$tasa_destruccion
      
      # Tensión del mercado laboral theta = v / u
      # Ecuacion de creacion de empleo (JC): c / q(theta) = (p - w) / (r + s)
      # Con q(theta) = theta^(-0.5), w = 0.5 * p
      theta <- ((0.5 * p) / (c * (0.05 + s)))^2
      theta <- max(0.1, min(5.0, theta))
      
      # Tasa de desempleo de equilibrio Beveridge: u* = s / (s + f(theta))
      # con f(theta) = theta^0.5
      tasa_encuentro <- theta^0.5
      u_star <- s / (s + tasa_encuentro)
      v_star <- theta * u_star
      
      # Curva de Beveridge
      u_grid <- seq(0.02, 0.18, length.out = 100)
      v_beveridge <- (s * (1 - u_grid) / u_grid)^2 * 0.05
      
      list(theta = theta, u = u_star, v = v_star, u_grid = u_grid, v_bev = v_beveridge)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$u_grid * 100, d$v_bev * 100, type = "l", col = "#2980b9", lwd = 3,
           xlim = c(2, 18), ylim = c(0, 15),
           xlab = "Tasa de Desempleo (%)", ylab = "Tasa de Vacantes (%)",
           main = "Curva de Beveridge y Equilibrio DMP")
      points(d$u * 100, d$v * 100, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      text(d$u * 100 + 0.6, d$v * 100 + 0.6, "Equilibrio u*", col = "#e74c3c", font = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Equilibrio del Mercado de Trabajo:"),
        tags$p(sprintf("Tasa natural de desempleo de fricción: %.1f%% | Tasa de vacantes: %.1f%% | Tensión del mercado (vacantes/desempleados): %.2f.",
                       d$u * 100, d$v * 100, d$theta))
      )
    })
}

shinyApp(ui = ui, server = server)

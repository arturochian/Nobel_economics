# laureados/2016_hart_holmstrom/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2016 · Teoría de Contratos y Compensación de Ejecutivos",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("riesgo_agente", "Aversión al riesgo del agente (r)", min = 0.1, max = 2.0, value = 0.8, step = 0.1),
    sliderInput("ruido_var", "Varianza de la señal de desempeño (sigma^2)", min = 0.2, max = 3.0, value = 1.0, step = 0.2),
    sliderInput("costo_esfuerzo", "Costo marginal de esfuerzo (c)", min = 0.5, max = 2.5, value = 1.0, step = 0.2),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Holmström (1979) y Hart (1986): tensión fundamental entre proveer incentivos y asegurar al trabajador contra el riesgo.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Bengt Holmström formalizó el "Principio de Informatividad": los pagos solo deben vincularse a métricas que revelen esfuerzo no observable, descartando shocks exógenos ajenos al control del agente.</p>'),
    HTML('<p><strong>Contribución Nobel 2016:</strong> Oliver Hart y Bengt Holmström revolucionaron la comprensión de los contratos incompletos, la propiedad de las empresas y los límites entre el empleo asalariado y el mercado.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "riesgo_agente", value = 0.8)
    updateSliderInput(session, "ruido_var", value = 1.0)
    updateSliderInput(session, "costo_esfuerzo", value = 1.0)
  })

    datos <- reactive({
      r <- input$riesgo_agente
      sigma2 <- input$ruido_var
      c <- input$costo_esfuerzo
      
      # Pendiente optima del contrato lineal: beta* = 1 / (1 + r * c * sigma^2)
      beta_opt <- 1 / (1 + r * c * sigma2)
      esfuerzo_opt <- beta_opt / c
      salario_fijo <- 5.0 - (beta_opt * esfuerzo_opt - 0.5 * c * esfuerzo_opt^2 - 0.5 * r * beta_opt^2 * sigma2)
      
      list(beta = beta_opt, esfuerzo = esfuerzo_opt, fijo = salario_fijo)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      desempeno <- seq(0, 10, length.out = 100)
      compensacion <- d$fijo + d$beta * desempeno
      
      plot(desempeno, compensacion, type = "l", col = "#2980b9", lwd = 3,
           xlab = "Resultado observado de la empresa (Ventas / Rendimiento)",
           ylab = "Compensación total del ejecutivo (W)",
           ylim = c(0, 15), main = "Estructura del Contrato Óptimo de Holmström")
      abline(h = d$fijo, lty = 2, col = "#7f8c8d")
      grid()
      legend("topleft", legend = c("Contrato W = alfa + beta * Y", "Salario base fijo (alfa)"),
             col = c("#2980b9", "#7f8c8d"), lwd = c(3, 1.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Propiedades del contrato de incentivos:"),
        tags$p(sprintf("La fuerza óptima del incentivo es beta* = %.2f. Cuanto mayor es el riesgo no controlable (sigma^2 = %.1f) o la aversión al riesgo (r = %.1f), menor debe ser el componente variable para evitar trasladar volatilidad indeseada al trabajador.",
                       d$beta, input$ruido_var, input$riesgo_agente))
      )
    })
}

shinyApp(ui = ui, server = server)

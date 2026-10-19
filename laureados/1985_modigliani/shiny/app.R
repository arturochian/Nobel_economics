# laureados/1985_modigliani/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1985 · Hipótesis del Ciclo de Vida del Consumo (Modigliani)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("edad_retiro", "Edad planificada de jubilación", min = 55, max = 75, value = 65, step = 1),
    sliderInput("esperanza_vida", "Esperanza de vida estimada", min = 70, max = 95, value = 85, step = 1),
    sliderInput("ingreso_anual", "Salario anual durante la etapa laboral ($)", min = 20000, max = 100000, value = 50000, step = 5000),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Franco Modigliani (1954): los individuos suavizan su consumo a lo largo de su vida, acumulando riqueza durante sus años activos para financiar su vejez.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Franco Modigliani derribó la hipótesis keynesiana simple de que el consumo dependía únicamente del ingreso corriente del mes: las familias planifican su consumo a lo largo de toda su vida, ahorrando en su juventud y desahorrando en la vejez.</p>'),
    HTML('<p><strong>Contribución Nobel 1985:</strong> Franco Modigliani transformó la teoría macroeconómica del ahorro y, junto a Merton Miller, fundó los teoremas modernos de estructura de capital corporativo.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "edad_retiro", value = 65)
    updateSliderInput(session, "esperanza_vida", value = 85)
    updateSliderInput(session, "ingreso_anual", value = 50000)
  })

    datos <- reactive({
      req(input$edad_retiro < input$esperanza_vida)
      edad_inicio <- 20
      R <- input$edad_retiro
      L <- input$esperanza_vida
      Y <- input$ingreso_anual
      
      anios_trabajo <- R - edad_inicio
      anios_vida <- L - edad_inicio
      
      # Consumo constante anual: C = (anios_trabajo / anios_vida) * Y
      C <- (anios_trabajo / anios_vida) * Y
      
      edades <- edad_inicio:L
      ingresos <- ifelse(edades < R, Y, 0)
      consumo <- rep(C, length(edades))
      
      # Riqueza acumulada W_t = sum(Y - C)
      riqueza <- cumsum(ingresos - consumo)
      
      list(edades = edades, Y = ingresos, C = consumo, W = riqueza,
           c_val = C, w_max = max(riqueza), R = R)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Panel 1: Ingreso vs Consumo
      plot(d$edades, d$Y, type = "l", col = "#2980b9", lwd = 2.5, lty = 2,
           xlab = "Edad del individuo", ylab = "Flujo anual ($)",
           ylim = c(0, max(d$Y) * 1.2), main = "Ingreso vs. Consumo Suavizado")
      lines(d$edades, d$C, col = "#27ae60", lwd = 3)
      abline(v = d$R, col = "#7f8c8d", lty = 3)
      grid()
      legend("topright", legend = c("Ingreso Laboral", "Consumo Constante (C)"),
             col = c("#2980b9", "#27ae60"), lwd = c(2.5, 3), lty = c(2, 1), bty = "n")

      # Panel 2: Trayectoria de Riqueza Acumulada
      plot(d$edades, d$W, type = "l", col = "#e67e22", lwd = 3,
           xlab = "Edad del individuo", ylab = "Riqueza acumulada ($)",
           main = "Joroba de Riqueza (Ciclo de Vida)")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      abline(v = d$R, col = "#7f8c8d", lty = 3)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Patrón de Ahorro Intertemporal:"),
        tags$p(sprintf("El individuo mantiene un consumo estable de $%.0f/año. Su riqueza alcanza un pico de $%.0f a los %d años de edad (momento de jubilación) y se desahorra progresivamente hasta agotarse al final de la vida.",
                       d$c_val, d$w_max, d$R))
      )
    })
}

shinyApp(ui = ui, server = server)

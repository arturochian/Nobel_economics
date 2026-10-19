# laureados/2022_bernanke_diamond_dybvig/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2022 · Bancos, liquidez y corridas bancarias (Diamond-Dybvig)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("t_prop", "Proporción de depositantes impacientes (t)", min = 0.10, max = 0.50, value = 0.25, step = 0.05),
    sliderInput("r1", "Retorno prometido en retiro temprano (r1)", min = 1.05, max = 1.40, value = 1.20, step = 0.05),
    sliderInput("R", "Retorno de proyectos productivos maduros (R)", min = 1.20, max = 2.00, value = 1.50, step = 0.05),
    checkboxInput("seguro_depositos", "Activar seguro de depósitos (FDIC)", value = FALSE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Diamond & Dybvig (1983): los bancos transforman plazos pero crean fragilidad intrínseca ante pánicos autorrealizables.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>El modelo Diamond-Dybvig muestra que la intermediación bancaria ofrece seguros de liquidez a los ahorristas, pero sufre de equilibrios múltiples: el óptimo cooperativo y el pánico bancario donde todos corren a retirar antes de que el banco quiebre.</p>'),
    HTML('<p><strong>Contribución Nobel 2022:</strong> Ben Bernanke analizó el colapso del crédito en la Gran Depresión de 1929, mientras que Douglas Diamond y Philip Dybvig formalizaron matemáticamente por qué las corridas bancarias requieren prestamistas de última instancia y seguro de depósitos.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "t_prop", value = 0.25)
    updateSliderInput(session, "r1", value = 1.20)
    updateSliderInput(session, "R", value = 1.50)
    updateCheckboxInput(session, "seguro_depositos", value = FALSE)
  })

    datos <- reactive({
      t <- input$t_prop
      r1 <- input$r1
      R <- input$R
      
      # Retorno optimo tarde
      r2_opt <- (R * (1 - t * r1)) / (1 - t)
      # Umbral agotamiento
      f_bar <- 1 / r1
      # Umbral critico de panico f* donde V2(f*) = r1
      f_star <- (R - r1) / (r1 * (R - 1))
      
      f_vec <- seq(0.01, 0.99, length.out = 150)
      
      if (input$seguro_depositos) {
        # Con seguro, no hay incentivo para corrida de pacientes
        V1 <- rep(r1, length(f_vec))
        V2 <- rep(r2_opt, length(f_vec))
      } else {
        V1 <- ifelse(f_vec <= f_bar, r1, 1 / f_vec)
        V2 <- pmax(0, (R * (1 - f_vec * r1)) / (1 - f_vec))
        V2[f_vec > f_bar] <- 0
      }
      
      list(f = f_vec, V1 = V1, V2 = V2, r2_opt = r2_opt, f_star = f_star, f_bar = f_bar)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$f, d$V2, type = "l", col = "#2980b9", lwd = 3,
           xlab = "Fracción de personas que retiran sus fondos (f)",
           ylab = "Retorno recibido por dólar depositado",
           ylim = c(0, max(d$V1, d$V2, 1.8)),
           main = "Dilema del Depositante Paciente: V2(f) vs. V1")
      lines(d$f, d$V1, col = "#e74c3c", lwd = 2.5, lty = 2)
      
      if (!input$seguro_depositos && d$f_star > 0 && d$f_star < 1) {
        abline(v = d$f_star, col = "#d35400", lty = 3, lwd = 2)
        text(d$f_star + 0.03, 0.4, sprintf("Umbral pánico f* = %.2f", d$f_star), col = "#d35400", adj = 0)
      }
      grid()
      legend("topright", legend = c("Esperar a maduración V2(f)", "Retirar temprano V1(f)"),
             col = c("#2980b9", "#e74c3c"), lwd = c(3, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      if (input$seguro_depositos) {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Seguro de depósitos activado:"),
          " El seguro elimina el equilibrio de pánico. Los pacientes siempre prefieren esperar a T=2 (retorno = ", sprintf("%.2f", d$r2_opt), "), haciendo imposible una corrida bancaria."
        )
      } else {
        tags$div(
          class = "alert alert-warning mt-3",
          tags$strong("Vulnerabilidad bancaria:"),
          sprintf(" Si más del %.1f%% de los depositantes retira prematuramente, el banco liquida inversiones y V2 cae por debajo de V1, detonando un colapso sistémico.", d$f_star * 100)
        )
      }
    })
}

shinyApp(ui = ui, server = server)

# laureados/2023_goldin/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2023 · La brecha de género y la curva en U en el desarrollo",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("pib_pc", "PIB per cápita (miles de USD constantes)", min = 2, max = 55, value = 25, step = 1),
    sliderInput("penalizacion_maternidad", "Penalización por maternidad en empleos 'codiciosos' (%)", min = 10, max = 60, value = 35, step = 5),
    sliderInput("flexibilidad", "Grado de flexibilidad horaria del mercado", min = 0, max = 1, value = 0.4, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Claudia Goldin: la participación femenina sigue una curva en U a lo largo del desarrollo; la brecha moderna se explica por los 'greedy jobs'.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Claudia Goldin corrigió más de dos siglos de datos para demostrar que la participación femenina no creció en línea recta: en la economía agraria era alta, cayó drásticamente con las fábricas por estigmas sociales, y volvió a subir con las oficinas y la píldora anticonceptiva.</p>'),
    HTML('<p><strong>Contribución Nobel 2023:</strong> Goldin descubrió que la mayor parte de la brecha salarial actual no surge dentro del mismo puesto, sino por la penalización que sufren las mujeres al buscar flexibilidad en empleos \'codiciosos\' con retornos desproporcionados a horas continuas.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "pib_pc", value = 25)
    updateSliderInput(session, "penalizacion_maternidad", value = 35)
    updateSliderInput(session, "flexibilidad", value = 0.4)
  })

    datos <- reactive({
      # 1. Curva en U historica
      pib_seq <- seq(1.5, 60, length.out = 100)
      flfp_teorica <- 45 - 28 * (log(pib_seq) - log(2)) / (log(12) - log(2)) + 
                      42 * ((log(pib_seq) - log(12)) / (log(60) - log(12)))^2
      flfp_teorica <- pmax(12, pmin(75, flfp_teorica))
      
      # Punto actual
      flfp_actual <- 45 - 28 * (log(input$pib_pc) - log(2)) / (log(12) - log(2)) + 
                     42 * ((log(input$pib_pc) - log(12)) / (log(60) - log(12)))^2
      flfp_actual <- max(12, min(75, flfp_actual))
      
      # 2. Brecha salarial por anios de experiencia tras el primer hijo
      anios <- 0:15
      brecha_base <- (input$penalizacion_maternidad * (1 - input$flexibilidad * 0.8)) * (1 - exp(-0.25 * anios))
      
      list(pib_seq = pib_seq, flfp_teorica = flfp_teorica, flfp_actual = flfp_actual,
           anios = anios, brecha = brecha_base)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Panel 1: Curva en U
      plot(d$pib_seq, d$flfp_teorica, type = "l", col = "#8e44ad", lwd = 3,
           xlab = "PIB per cápita (miles de USD)", ylab = "Participación laboral femenina (%)",
           main = "Curva en U Histórica (Goldin)")
      points(input$pib_pc, d$flfp_actual, pch = 21, bg = "#e74c3c", cex = 2.2, lwd = 2)
      text(d$pib_seq[15], 38, "Fase agrícola", cex = 0.85, col = "#555")
      text(d$pib_seq[35], 16, "Industrialización", cex = 0.85, col = "#555")
      text(d$pib_seq[80], 65, "Sector servicios", cex = 0.85, col = "#555")
      grid()

      # Panel 2: Penalizacion por maternidad en empleos codiciosos
      plot(d$anios, d$brecha, type = "b", pch = 19, col = "#c0392b", lwd = 2.5,
           xlab = "Años tras el nacimiento del primer hijo",
           ylab = "Brecha salarial hombre-mujer (%)",
           ylim = c(0, 60),
           main = "Penalización Salarial de la Maternidad")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Diagnóstico del mercado laboral:"),
        tags$p(sprintf("A un nivel de ingreso de US$ %d k, la participación femenina estimada es %.1f%%. La brecha salarial a 10 años del primer hijo se sitúa en %.1f%% debido a la prima por horas largas en empleos no flexibles.",
                       input$pib_pc, d$flfp_actual, d$brecha[11]))
      )
    })
}

shinyApp(ui = ui, server = server)

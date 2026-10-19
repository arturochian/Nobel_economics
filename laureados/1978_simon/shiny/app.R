# laureados/1978_simon/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1978 · Racionalidad Limitada y Conducta de Satisfacción (Simon)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("umbral_aspiracion", "Nivel de exigencia / aspiración del decisor ($)", min = 60, max = 95, value = 80, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Herbert A. Simon: los humanos no optimizan globalmente porque la mente humana tiene capacidad de cómputo finita; toman decisiones de satisfacción (satisficing).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Herbert Simon fue un polímata pionero en inteligencia artificial y psicología organizacional que demostró la imposibilidad práctica de la optimización perfecta neoclásica: las personas y las empresas usan heurísticas de satisfacción satisfactoria dadas sus restricciones cognitivas y de tiempo.</p>'),
    HTML('<p><strong>Contribución Nobel 1978:</strong> Herbert Simon revolucionó la teoría de la toma de decisiones dentro de las organizaciones económicas.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "umbral_aspiracion", value = 80)
  })

    datos <- reactive({
      set.seed(1978)
      alternativas <- round(runif(30, 40, 100))
      umbral <- input$umbral_aspiracion
      
      # Primer elemento que cumple el umbral
      idx <- which(alternativas >= umbral)[1]
      if (is.na(idx)) idx <- 30
      
      valor_elegido <- alternativas[idx]
      optimo_global <- max(alternativas)
      
      list(alt = alternativas, idx = idx, val = valor_elegido, opt = optimo_global, umb = umbral)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      plot(1:length(d$alt), d$alt, type = "b", pch = 19, col = "#bdc3c7",
           xlab = "Alternativas evaluadas secuencialmente", ylab = "Calidad de la opción ($)",
           ylim = c(35, 105), main = "Satisfacción (Satisficing) vs. Optimización Exhaustiva")
      abline(h = d$umb, col = "#e67e22", lwd = 2, lty = 2)
      abline(h = d$opt, col = "#27ae60", lwd = 1.5, lty = 3)
      
      # Marcamos la elegida
      points(d$idx, d$val, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      text(d$idx, d$val + 5, "Elegida por Satisfacción", col = "#e74c3c", font = 2)
      grid()
      legend("bottomright", legend = c("Umbral de Aspiración", "Óptimo Global Inalcanzable"),
             col = c("#e67e22", "#27ae60"), lwd = c(2, 1.5), lty = c(2, 3), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Heurística de Herbert Simon:"),
        tags$p(sprintf("El agente se detiene en la alternativa número %d tras encontrar una opción de valor %d que satisface su aspiración (%d), ahorrándose evaluar las 30 opciones del mercado.",
                       d$idx, d$val, d$umb))
      )
    })
}

shinyApp(ui = ui, server = server)

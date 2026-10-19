# laureados/2015_deaton/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2015 · Consumo, Demanda (AIDS) y Medición de Pobreza",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("gasto", "Presupuesto total del hogar ($)", min = 200, max = 2500, value = 800, step = 50),
    sliderInput("precio_alim", "Precio relativo de alimentos básicos", min = 0.5, max = 2.0, value = 1.0, step = 0.1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Angus Deaton: el Sistema Casi Ideal de Demanda (AIDS) conecta microdatos de consumo con bienestar agregado.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>El Almost Ideal Demand System (AIDS) propuesto por Deaton y Muellbauer en 1980 permitió contrastar las restricciones de simetría y homogeneidad de la teoría del consumidor con datos reales de encuestas de hogares.</p>'),
    HTML('<p><strong>Contribución Nobel 2015:</strong> Angus Deaton integró el análisis microeconómico del consumo, la nutrición y el bienestar con la medición rigurosa de la pobreza en países en desarrollo.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "gasto", value = 800)
    updateSliderInput(session, "precio_alim", value = 1.0)
  })

    datos <- reactive({
      # Sistema AIDS simplificado para 3 bienes: Alimentos (necesidad), Vivienda, Lujos
      # w_i = alpha_i + beta_i * log(X / P)
      X <- input$gasto
      p1 <- input$precio_alim
      log_xp <- log(X / (p1^0.4))
      
      # Alimentos: beta negativo (bien necesario - Ley de Engel)
      w_alim <- 0.65 - 0.08 * log_xp
      w_alim <- max(0.10, min(0.70, w_alim))
      
      # Lujos: beta positivo (bien suntuario)
      w_lujo <- 0.05 + 0.07 * log_xp
      w_lujo <- max(0.05, min(0.60, w_lujo))
      
      # Vivienda: residuo
      w_viv <- 1 - w_alim - w_lujo
      
      # Curva de Engel para Alimentos
      g_seq <- seq(200, 2500, length.out = 100)
      w_engel <- 0.65 - 0.08 * log(g_seq / (p1^0.4))
      
      list(w_alim = w_alim, w_lujo = w_lujo, w_viv = w_viv,
           g_seq = g_seq, w_engel = w_engel)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Composicion de la canasta
      cuotas <- c(d$w_alim, d$w_viv, d$w_lujo) * 100
      bp <- barplot(cuotas, names.arg = c("Alimentos", "Vivienda", "Bienes Lujo"),
                    col = c("#e67e22", "#3498db", "#9b59b6"),
                    ylab = "Proporción del gasto total (%)", ylim = c(0, 80),
                    main = "Estructura del Presupuesto")
      text(bp, cuotas + 3, sprintf("%.1f%%", cuotas), font = 2)
      grid(nx = NA, ny = NULL)

      # Curva de Engel (Ley de Engel de Deaton)
      plot(d$g_seq, d$w_engel * 100, type = "l", col = "#e67e22", lwd = 3,
           xlab = "Presupuesto total del hogar ($)", ylab = "% Destinado a alimentos",
           ylim = c(10, 70), main = "Curva de Engel (Alimentos)")
      points(input$gasto, d$w_alim * 100, pch = 21, bg = "#c0392b", cex = 2.2, lwd = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Cumplimiento de la Ley de Engel:"),
        tags$p(sprintf("Con un presupuesto de $%d, el hogar destina el %.1f%% a alimentos básicos. Conforme aumentan los ingresos, la proporción alimentaria decrece y la cuota de bienes suntuarios se expande hasta el %.1f%%.",
                       input$gasto, d$w_alim * 100, d$w_lujo * 100))
      )
    })
}

shinyApp(ui = ui, server = server)

# laureados/1976_friedman/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1976 · Ingreso Permanente, Monetarismo y Ecuación Cuantitativa (Friedman)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("ingreso_transitorio", "Shock de ingreso temporal / lotería ($)", min = -5000, max = 15000, value = 8000, step = 1000),
    sliderInput("crecimiento_dinero", "Tasa de crecimiento monetario (M %)", min = 0, max = 15, value = 6, step = 1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Milton Friedman: el consumo responde al ingreso permanente, no al transitorio; 'la inflación es siempre y en todo lugar un fenómeno monetario'.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Milton Friedman demostró empíricamente que la Gran Depresión de 1929 fue provocada por una contracción devastadora de la oferta monetaria por parte de la Reserva Federal. También refutó la política de transferencias de estímulo puntual al probar que las familias ahorran los ingresos transitorios.</p>'),
    HTML('<p><strong>Contribución Nobel 1976:</strong> Milton Friedman fue el líder del monetarismo y de la reformulación del consumo intertemporal y la política de estabilización.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "ingreso_transitorio", value = 8000)
    updateSliderInput(session, "crecimiento_dinero", value = 6)
  })

    datos <- reactive({
      y_p <- 40000 # Ingreso permanente constante
      y_t <- input$ingreso_transitorio
      m_dot <- input$crecimiento_dinero
      
      # Hipotesis del ingreso permanente: propension marginal a consumir del ingreso transitorio es casi nula
      consumo <- 0.9 * y_p + 0.05 * y_t
      
      # Ecuacion cuantitativa MV = PY: a largo plazo pi = m_dot - y_dot
      crecimiento_pib_real <- 2.5
      inflacion_eq <- max(0, m_dot - crecimiento_pib_real)
      
      list(c = consumo, inf = inflacion_eq, yp = y_p, yt = y_t)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Ingreso total vs Consumo
      y_total <- d$yp + d$yt
      bp <- barplot(c(y_total, d$c), names.arg = c("Ingreso Total del Año", "Consumo Efectivo"),
                    col = c("#3498db", "#27ae60"),
                    ylab = "Dólares ($)", ylim = c(0, max(y_total, d$c) * 1.25),
                    main = "Hipótesis del Ingreso Permanente")
      text(bp, c(y_total, d$c) + 2000, sprintf("$%.0f", c(y_total, d$c)), font = 2)
      grid(nx = NA, ny = NULL)

      # Inflacion monetaria
      bp2 <- barplot(d$inf, names.arg = c("Inflación a Largo Plazo"),
                     col = "#c0392b", ylab = "Tasa de Inflación Anual (%)", ylim = c(0, 15),
                     main = "Monetarismo (MV = PY)")
      text(bp2, d$inf + 0.6, sprintf("%.1f%%", d$inf), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Conclusiones de Milton Friedman:"),
        tags$p(sprintf("Un bono transitorio de $%.0f apenas eleva el consumo en $%.0f porque casi todo se ahorra. Un crecimiento monetario del %.1f%% genera una inflación estructural a largo plazo del %.1f%%.",
                       d$yt, 0.05 * d$yt, input$crecimiento_dinero, d$inf))
      )
    })
}

shinyApp(ui = ui, server = server)

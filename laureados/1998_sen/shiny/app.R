# laureados/1998_sen/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1998 · Bienestar, Hambrunas y Enfoque de Capacidades (Sen)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("gini", "Desigualdad en la distribución del ingreso (Gini)", min = 0.20, max = 0.65, value = 0.40, step = 0.05),
    sliderInput("ingreso_medio", "Ingreso per cápita medio ($)", min = 500, max = 5000, value = 2000, step = 100),
    sliderInput("linea_pobreza", "Línea de pobreza extrema ($)", min = 400, max = 1500, value = 800, step = 50),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Amartya Sen: la pobreza no es solo falta de dinero sino privación de capacidades básicas; las hambrunas ocurren por colapso de titularidades, no por falta de alimentos.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Amartya Sen demostró que medir el desarrollo exclusivamente por el PIB per cápita es ciego ante la equidad y la libertad real de las personas. En su célebre estudio sobre la Gran Hambruna de Bengala de 1943, demostró que la comida no había escaseado: la gente murió porque sus \'titularidades de intercambio\' colapsaron frente a la inflación salarial.</p>'),
    HTML('<p><strong>Contribución Nobel 1998:</strong> Amartya Sen fundó la economía del desarrollo moderna, el Índice de Desarrollo Humano (IDH) del PNUD y el enfoque ético de capacidades.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "gini", value = 0.40)
    updateSliderInput(session, "ingreso_medio", value = 2000)
    updateSliderInput(session, "linea_pobreza", value = 800)
  })

    datos <- reactive({
      y_bar <- input$ingreso_medio
      g <- input$gini
      z <- input$linea_pobreza
      
      # Indice de bienestar de Sen: W = y_bar * (1 - Gini)
      w_sen <- y_bar * (1 - g)
      
      # Simulacion lognormal de distribucion del ingreso
      sigma <- sqrt(2) * qnorm((g + 1) / 2)
      mu <- log(y_bar) - 0.5 * sigma^2
      
      # Tasa de pobreza (Headcount H)
      H <- pnorm((log(z) - mu) / sigma)
      
      list(w = w_sen, H = H, y_bar = y_bar, g = g, z = z)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Comparacion Ingreso vs Bienestar Sen
      bp <- barplot(c(d$y_bar, d$w), names.arg = c("PIB per cápita medio", "Índice de Bienestar de Sen"),
                    col = c("#bdc3c7", "#27ae60"),
                    ylab = "Dólares ($)", ylim = c(0, d$y_bar * 1.25),
                    main = "Bienestar Corregido por Desigualdad")
      text(bp, c(d$y_bar, d$w) + 100, sprintf("$%.0f", c(d$y_bar, d$w)), font = 2)
      grid(nx = NA, ny = NULL)

      # Tasa de pobreza headcount
      bp2 <- barplot(d$H * 100, names.arg = c("Población bajo Línea de Pobreza"),
                     col = "#c0392b", ylab = "% de la población", ylim = c(0, 100),
                     main = "Tasa de Incidencia (H)")
      text(bp2, d$H * 100 + 4, sprintf("%.1f%%", d$H * 100), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Evaluación de Bienestar Social:"),
        tags$p(sprintf("El ingreso medio de $%.0f se reduce a un bienestar social efectivo de $%.0f tras descontar la penalización por desigualdad (Gini = %.2f). La tasa de pobreza extrema alcanza el %.1f%%.",
                       d$y_bar, d$w, d$g, d$H * 100))
      )
    })
}

shinyApp(ui = ui, server = server)

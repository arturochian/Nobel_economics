# laureados/1992_becker/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1992 · Economía de la conducta humana y del crimen (Gary Becker)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("prob_captura", "Probabilidad de aprehensión y condena (p %)", min = 5, max = 80, value = 25, step = 5),
    sliderInput("severidad_pena", "Severidad de la pena monetaria o carcelaria (f $)", min = 200, max = 2000, value = 800, step = 100),
    sliderInput("botin_ilegal", "Ganancia económica del delito ($)", min = 100, max = 1500, value = 500, step = 50),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Gary Becker (1968): el delito es una decisión racional donde los individuos comparan la ganancia con el costo esperado de ser castigados.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Gary Becker expandió el dominio del análisis microeconómico hacia áreas tradicionalmente reservadas a la sociología o el derecho: la discriminación racial, la natalidad, el matrimonio, la asignación del tiempo en el hogar y el delito.</p>'),
    HTML('<p><strong>Contribución Nobel 1992:</strong> Gary Becker demostró que el principio del comportamiento optimizador y los incentivos explican facetas cruciales de la interacción humana fuera del mercado formal.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "prob_captura", value = 25)
    updateSliderInput(session, "severidad_pena", value = 800)
    updateSliderInput(session, "botin_ilegal", value = 500)
  })

    datos <- reactive({
      p <- input$prob_captura / 100
      f <- input$severidad_pena
      g <- input$botin_ilegal
      
      # Costo esperado del delito: E[C] = p * f
      costo_esperado <- p * f
      beneficio_neto <- g - costo_esperado
      
      # Tasa agregada de criminalidad resultante
      crimen_indice <- max(5, 100 * exp(-costo_esperado / g * 0.8))
      
      list(p = p, f = f, g = g, ce = costo_esperado, bn = beneficio_neto, cr = crimen_indice)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      valores <- c(d$g, d$ce)
      bp <- barplot(valores, names.arg = c("Ganancia del Delito", "Costo Esperado del Castigo (p * f)"),
                    col = c("#e67e22", ifelse(d$bn > 0, "#c0392b", "#27ae60")),
                    ylab = "Valoración económica ($)",
                    ylim = c(0, max(valores) * 1.3),
                    main = "Ecuación Racional del Delito de Gary Becker")
      text(bp, valores + 25, sprintf("$%.0f", valores), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      if (d$bn > 0) {
        tags$div(
          class = "alert alert-danger mt-3",
          tags$strong("Disuasión insuficiente:"),
          sprintf(" El beneficio ilícito ($%.0f) supera el costo penal esperado ($%.0f). El crimen es económicamente rentable con una ganancia neta esperada de +$%.0f.", d$g, d$ce, d$bn)
        )
      } else {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Disuasión efectiva:"),
          sprintf(" El costo esperado del castigo ($%.0f) excede el botín ($%.0f), logrando disuadir la conducta delictiva racional.", d$ce, d$g)
        )
      }
    })
}

shinyApp(ui = ui, server = server)

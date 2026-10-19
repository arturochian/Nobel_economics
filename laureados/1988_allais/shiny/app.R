# laureados/1988_allais/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1988 · La Paradoja de Allais y la Utilidad Esperada",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("certeza_bonus", "Ponderación psicológica de la certeza absoluta (%)", min = 0, max = 50, value = 25, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Maurice Allais (1953): demostró mediante experimentos que las personas violan sistemáticamente el axioma de independencia de Von Neumann-Morgenstern.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Maurice Allais diseñó un famoso dilema que dejó perplejos a los mejores economistas de su época en un congreso en París: demostró que las personas no calculan probabilidades lineales, anticipando en décadas la teoría prospectiva.</p>'),
    HTML('<p><strong>Contribución Nobel 1988:</strong> Maurice Allais fue pionero en la teoría de mercados, equilibrio general y utilización eficiente de recursos económicos.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "certeza_bonus", value = 25)
  })

    datos <- reactive({
      bonus <- input$certeza_bonus
      # Opcion A: $1 millon seguro (100%)
      # Opcion B: 10% de $5M, 89% de $1M, 1% de $0
      pref_a <- 50 + bonus
      pref_b <- 100 - pref_a
      
      list(a = pref_a, b = pref_b)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      porcs <- c(d$a, d$b)
      bp <- barplot(porcs, names.arg = c("Eligen $1M con 100% Certeza", "Eligen Lotería con mayor valor esperado"),
                    col = c("#2980b9", "#bdc3c7"),
                    ylab = "% de individuos que eligen cada opción",
                    ylim = c(0, 100),
                    main = "El Efecto Certeza de la Paradoja de Allais")
      text(bp, porcs + 3, sprintf("%.0f%%", porcs), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-warning mt-3",
        tags$strong("Violación del axioma de independencia:"),
        tags$p(sprintf("El %.0f%% de las personas prefiere la opción segura de $1 millón aun cuando la lotería tiene un valor esperado superior, debido a la aversión desproporcionada al arrepentimiento.",
                       d$a))
      )
    })
}

shinyApp(ui = ui, server = server)

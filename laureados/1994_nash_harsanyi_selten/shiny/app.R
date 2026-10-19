# laureados/1994_nash_harsanyi_selten/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1994 · Equilibrio de Nash y Juegos no cooperativos",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("beneficio_coop", "Premio por cooperación mutua (R)", min = 2, max = 8, value = 3, step = 1),
    sliderInput("tentacion_traic", "Tentación de traicionar / defeccionar (T)", min = 4, max = 10, value = 5, step = 1),
    sliderInput("castigo_mutuo", "Castigo por deserción mutua (P)", min = 0, max = 3, value = 1, step = 1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("John Nash (equilibrio no cooperativo), John Harsanyi (juegos bayesianos) y Reinhard Selten (perfección en subjuegos).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>John Forbes Nash demostró que en cualquier juego con un número finito de jugadores y estrategias existe al menos un punto de equilibrio estable donde ningún jugador tiene incentivos unilaterales para cambiar de estrategia.</p>'),
    HTML('<p><strong>Contribución Nobel 1994:</strong> John Nash, John Harsanyi y Reinhard Selten convirtieron la teoría de juegos en el lenguaje unificado de la economía, la ciencia política y la biología evolutiva.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "beneficio_coop", value = 3)
    updateSliderInput(session, "tentacion_traic", value = 5)
    updateSliderInput(session, "castigo_mutuo", value = 1)
  })

    datos <- reactive({
      R <- input$beneficio_coop
      T_val <- input$tentacion_traic
      P <- input$castigo_mutuo
      S <- 0 # Pago del estafado
      
      # Matriz de pagos del Dilema del Prisionero
      # Estrategia dominante de ambos: Traicionar
      list(R = R, T = T_val, P = P, S = S)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      pagos <- c(d$R, d$P)
      bp <- barplot(pagos, names.arg = c("Cooperación Mutua (Óptimo Social)", "Equilibrio de Nash (Ambos Traicionan)"),
                    col = c("#27ae60", "#c0392b"),
                    ylab = "Pago individual obtenido",
                    ylim = c(0, max(d$T, d$R) + 2),
                    main = "El Dilema del Prisionero: Nash vs. Pareto")
      text(bp, pagos + 0.3, sprintf("%.0f pts", pagos), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-danger mt-3",
        tags$strong("Equilibrio de Nash estricto:"),
        tags$p(sprintf("Dado que traicionar ofrece un pago de %d frente a %d al cooperar unilateralmente, la estrategia dominante conduce al equilibrio (Traicionar, Traicionar) con solo %d puntos, destruyendo el óptimo cooperativo de %d puntos.",
                       d$T, d$S, d$P, d$R))
      )
    })
}

shinyApp(ui = ui, server = server)

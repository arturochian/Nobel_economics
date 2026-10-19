# laureados/2020_milgrom_wilson/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2020 · Teoría de Subastas y la Maldición del Ganador",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("N", "Número de postores en la subasta (N)", min = 2, max = 30, value = 8, step = 1),
    sliderInput("ruido", "Incertidumbre / dispersión de señales (epsilon)", min = 5, max = 40, value = 20, step = 5),
    checkboxInput("es_racional", "Postor Racional (corrige maldición del ganador)", value = FALSE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Wilson (1977) y Milgrom (1982): en bienes con valor común, el postor más optimista gana la subasta pero sobrepaga si no descuenta el sesgo.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>En subastas de espectro radioeléctrico o yacimientos petrolíferos, el valor del recurso es el mismo para todos pero nadie lo conoce con exactitud. Ganar la subasta contiene la mala noticia de haber sido el postor con la estimación más exagerada.</p>'),
    HTML('<p><strong>Contribución Nobel 2020:</strong> Paul Milgrom y Robert Wilson diseñaron nuevos formatos de subastas ascendentes simultáneas (SMRA) que permiten a los participantes aprender del comportamiento ajeno, mitigando la maldición del ganador y recaudando cientos de miles de millones de dólares para el erario público.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "N", value = 8)
    updateSliderInput(session, "ruido", value = 20)
    updateCheckboxInput(session, "es_racional", value = FALSE)
  })

    datos <- reactive({
      N <- input$N
      eps <- input$ruido
      V_true <- 150
      
      # Esperanza del maximo de N uniformes: V + eps * (N - 1)/(N + 1)
      E_max_senal <- V_true + eps * (N - 1) / (N + 1)
      
      # Postor ingenuo descuenta como si fuera valor privado
      puja_ingenua <- E_max_senal - (2 * eps) / (N + 1)
      beneficio_ingenuo <- V_true - puja_ingenua
      
      # Postor racional descuenta condicionando en ser el maximo
      puja_racional <- V_true - eps + (2 * eps) / (N + 1) # Sombreado correcto
      beneficio_racional <- eps - (2 * eps) / (N + 1)
      
      # Curva para varios N
      n_vec <- 2:30
      curva_ing <- numeric(length(n_vec))
      curva_rac <- numeric(length(n_vec))
      for (i in seq_along(n_vec)) {
        nn <- n_vec[i]
        max_s <- V_true + eps * (nn - 1) / (nn + 1)
        p_ing <- max_s - (2 * eps) / (nn + 1)
        curva_ing[i] <- V_true - p_ing
        curva_rac[i] <- eps - (2 * eps) / (nn + 1)
      }
      
      list(N = N, beneficio_ing = beneficio_ingenuo, beneficio_rac = beneficio_racional,
           n_vec = n_vec, curva_ing = curva_ing, curva_rac = curva_rac)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$n_vec, d$curva_ing, type = "l", col = "#c0392b", lwd = 2.5,
           ylim = c(min(d$curva_ing) - 5, max(d$curva_rac) + 5),
           xlab = "Número de postores compitiendo (N)",
           ylab = "Beneficio esperado del ganador",
           main = "Maldición del Ganador: Pérdidas por Competencia")
      lines(d$n_vec, d$curva_rac, col = "#27ae60", lwd = 2.5, lty = 2)
      abline(h = 0, lty = 3, col = "#7f8c8d")
      
      # Punto actual
      ben_actual <- if (input$es_racional) d$beneficio_rac else d$beneficio_ing
      col_pt <- if (input$es_racional) "#27ae60" else "#c0392b"
      points(input$N, ben_actual, pch = 21, bg = col_pt, cex = 2.2, lwd = 2)
      
      grid()
      legend("topright", legend = c("Postor Ingenuo (Maldición)", "Postor Racional (Sombreado)"),
             col = c("#c0392b", "#27ae60"), lwd = c(2.5, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      if (input$es_racional) {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Estrategia racional activada:"),
          sprintf(" Al sombrar la puja tomando en cuenta que ganar significa haber recibido la señal más alta, el postor obtiene un beneficio positivo de +%.2f unidades.", d$beneficio_rac)
        )
      } else {
        tags$div(
          class = "alert alert-danger mt-3",
          tags$strong("Maldición del ganador en acción:"),
          sprintf(" Con N = %d postores, el ganador ingenuo sufre pérdidas sistemáticas de %.2f unidades debido a que confunde el optimismo de su estimación con el verdadero valor del bien.", input$N, d$beneficio_ing)
        )
      }
    })
}

shinyApp(ui = ui, server = server)

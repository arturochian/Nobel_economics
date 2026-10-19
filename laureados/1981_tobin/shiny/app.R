# laureados/1981_tobin/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1981 · Teoría de Cartera y la Q de Tobin para Inversión",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("valor_mercado", "Valor de mercado en bolsa de la empresa ($ millones)", min = 50, max = 300, value = 140, step = 10),
    sliderInput("costo_reposicion", "Costo de reposición del capital físico ($ millones)", min = 50, max = 200, value = 100, step = 10),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("James Tobin: el ratio Q (valor de mercado / costo de reposición) explica la decisión de inversión productiva de las empresas.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>James Tobin conectó las finanzas con la economía real formulando el indicador Q de Tobin y el Teorema de Separación de Portafolios (los inversores sólo necesitan combinar un portafolio de activos riesgosos con un activo libre de riesgo según su aversión personal).</p>'),
    HTML('<p><strong>Contribución Nobel 1981:</strong> James Tobin revolucionó la teoría de los mercados financieros y su relación con el gasto, el empleo y los precios.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "valor_mercado", value = 140)
    updateSliderInput(session, "costo_reposicion", value = 100)
  })

    datos <- reactive({
      vm <- input$valor_mercado
      cr <- input$costo_reposicion
      
      q <- vm / cr
      # Tasa de inversion corporativa en funcion de Q
      inversion <- max(0, 15 * (q - 1))
      
      list(q = q, inv = inversion)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      bp <- barplot(d$q, names.arg = c("Ratio Q de Tobin"),
                    col = ifelse(d$q > 1, "#27ae60", "#c0392b"),
                    ylab = "Valoración de Mercado / Costo Físico",
                    ylim = c(0, 2.5), main = "La Regla Q de Inversión de Tobin")
      abline(h = 1.0, col = "#7f8c8d", lwd = 2.5, lty = 2)
      text(bp, d$q + 0.12, sprintf("Q = %.2f", d$q), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Decisión de Inversión Empresarial:"),
        tags$p(sprintf("Con Q = %.2f: %s Tasa de inversión productiva estimada: %.1f%% del stock de capital.",
                       d$q,
                       ifelse(d$q > 1,
                              "Al ser Q > 1, comprar maquinaria nueva es más barato que comprar acciones de empresas existentes; las empresas tienen fuertes incentivos para invertir en capital físico.",
                              "Al ser Q < 1, el mercado valora el capital por debajo de su costo de reemplazo; es más barato crecer comprando competidores que construyendo fábricas nuevas."),
                       d$inv))
      )
    })
}

shinyApp(ui = ui, server = server)

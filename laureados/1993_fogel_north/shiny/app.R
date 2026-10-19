# laureados/1993_fogel_north/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1993 · Historia económica, Cliometría e Instituciones (North & Fogel)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("costo_transaccion", "Nivel de costos de transacción institucionales (%)", min = 5, max = 50, value = 25, step = 5),
    sliderInput("seguridad_juridica", "Seguridad contractual y derechos de propiedad", min = 0, max = 1, value = 0.7, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Robert Fogel (revolución cliométrica de contrafactuales) y Douglass North (instituciones como reglas del juego en la historia).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Douglass North demostró que las instituciones son las \'reglas del juego\' formales e informales que reducen la incertidumbre en el intercambio humano. Robert Fogel empleó contrafactuales matemáticos para calcular que la economía estadounidense hubiese crecido casi igual sin ferrocarriles gracias a la red de canales fluviales.</p>'),
    HTML('<p><strong>Contribución Nobel 1993:</strong> Renovaron la historia económica mediante la aplicación de teoría económica y métodos cuantitativos rigurosos (cliometría).</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "costo_transaccion", value = 25)
    updateSliderInput(session, "seguridad_juridica", value = 0.7)
  })

    datos <- reactive({
      ct <- input$costo_transaccion / 100
      sj <- input$seguridad_juridica
      
      # Crecimiento economico de largo plazo segun North
      pib_crecimiento <- 3.5 * sj * (1 - ct * 0.8)
      eficiencia_mercado <- 100 * (1 - ct) * sj
      
      list(g = pib_crecimiento, ef = eficiencia_mercado)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      costos <- seq(5, 50, by = 5)
      crec_curva <- 3.5 * input$seguridad_juridica * (1 - (costos / 100) * 0.8)
      
      plot(costos, crec_curva, type = "b", pch = 19, col = "#2980b9", lwd = 2.5,
           xlab = "Costos de transacción en la economía (%)",
           ylab = "Tasa de crecimiento económico anual (%)",
           ylim = c(0, 4), main = "Instituciones y Crecimiento Histórico (North)")
      points(input$costo_transaccion, d$g, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Tesis institucional de Douglass North:"),
        tags$p(sprintf("Con costos de transacción al %.0f%% y solidez jurídica al %.0f%%, la tasa de crecimiento económico sostenido alcanza %.2f%% anual. Las instituciones deficientes son la causa primaria del estancamiento histórico.",
                       input$costo_transaccion, input$seguridad_juridica * 100, d$g))
      )
    })
}

shinyApp(ui = ui, server = server)

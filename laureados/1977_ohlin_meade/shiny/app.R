# laureados/1977_ohlin_meade/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1977 · Comercio Heckscher-Ohlin y Teoría del Segundo Mejor (Meade)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("abundancia_capital", "Ratio Capital/Trabajo del País Doméstico", min = 0.5, max = 3.0, value = 2.0, step = 0.25),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Bertil Ohlin (el comercio surge de la dotación factorial de recursos) y James Meade (política comercial internacional y el Teorema del Segundo Mejor).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Bertil Ohlin y Eli Heckscher formularon el modelo que explica por qué los países comercian: exportan aquellos bienes que utilizan intensivamente sus factores de producción abundantes. James Meade formuló la Teoría del Segundo Mejor: eliminar una sola distorsión arancelaria cuando persisten otras puede reducir el bienestar en vez de aumentarlo.</p>'),
    HTML('<p><strong>Contribución Nobel 1977:</strong> Bertil Ohlin y James Meade transformaron la teoría del comercio internacional y los movimientos mundiales de capital.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "abundancia_capital", value = 2.0)
  })

    datos <- reactive({
      k_l <- input$abundancia_capital
      
      # Si K/L > 1 exporta bienes intensivos en capital e importa intensivos en trabajo
      exp_capital <- 100 * (k_l / (1 + k_l))
      exp_trabajo <- 100 - exp_capital
      
      list(kl = k_l, ec = exp_capital, et = exp_trabajo)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      partes <- c(d$ec, d$et)
      bp <- barplot(partes, names.arg = c("Bienes Intensivos en Capital (Maquinaria)", "Bienes Intensivos en Trabajo (Textiles)"),
                    col = c("#2980b9", "#e67e22"),
                    ylab = "Composición de exportaciones (%)",
                    ylim = c(0, 100),
                    main = "Patrón de Comercio de Heckscher-Ohlin")
      text(bp, partes + 3, sprintf("%.1f%%", partes), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Teorema de Heckscher-Ohlin:"),
        tags$p(sprintf("Al ser abundante en capital (K/L = %.2f), el país tiene ventaja comparativa y exporta mayoritariamente bienes intensivos en capital (%.1f%% de sus ventas externas).",
                       d$kl, d$ec))
      )
    })
}

shinyApp(ui = ui, server = server)

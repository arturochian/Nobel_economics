# laureados/2008_krugman/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2008 · Nueva geografía económica y aglomeración industrial",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("costo_transporte", "Costo de transporte de comercio (tau)", min = 1.05, max = 2.50, value = 1.40, step = 0.05),
    sliderInput("rendimientos_escala", "Economías de escala industriales (sigma)", min = 2.0, max = 7.0, value = 4.0, step = 0.5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Paul Krugman (1991): la interacción entre rendimientos crecientes y costos de transporte genera aglomeración centro-periferia.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Paul Krugman formuló la Nueva Teoría del Comercio y la Nueva Geografía Económica, explicando por qué países con dotaciones similares comercian masivamente entre sí (comercio intraindustrial) y cómo surgen núcleos urbanos gigantes como Silicon Valley.</p>'),
    HTML('<p><strong>Contribución Nobel 2008:</strong> Paul Krugman integró la competencia monopolística de Dixit-Stiglitz con los costos de transporte para modelar la localización de la actividad económica en el espacio.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "costo_transporte", value = 1.40)
    updateSliderInput(session, "rendimientos_escala", value = 4.0)
  })

    datos <- reactive({
      tau <- input$costo_transporte
      sig <- input$rendimientos_escala
      
      # Indice de concentracion geografica (proporcion industrial en el Centro)
      # Con costos de transporte muy altos -> dispersion; con costos moderados -> aglomeracion
      concentracion <- ifelse(tau > 2.0, 0.5,
                              0.5 + 0.45 * (1 - (tau - 1.05) / 0.95)^(sig / 3.0))
      concentracion <- max(0.5, min(0.95, concentracion))
      
      list(c_centro = concentracion, c_periferia = 1 - concentracion)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      partes <- c(d$c_centro, d$c_periferia) * 100
      bp <- barplot(partes, names.arg = c("Región Central (Aglomeración)", "Región Periférica"),
                    col = c("#2980b9", "#bdc3c7"),
                    ylab = "Participación de la industria manufacturera (%)",
                    ylim = c(0, 100),
                    main = "Distribución Geográfica Centro-Periferia (Krugman)")
      text(bp, partes + 3, sprintf("%.1f%%", partes), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Patrón espacial emergente:"),
        tags$p(sprintf("Con costos de transporte tau = %.2f, la región centro concentra el %.1f%% de las fábricas. %s",
                       input$costo_transporte, d$c_centro * 100,
                       ifelse(d$c_centro > 0.65, "Se consolida un equilibrio centro-periferia con fuerte aglomeración industrial.", "La industria permanece dispersa regionalmente.")))
      )
    })
}

shinyApp(ui = ui, server = server)

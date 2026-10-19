# laureados/1999_mundell/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1999 · El Trilema Macroeconómico de Mundell-Fleming",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
selectInput("regimen", "Régimen cambiario:", choices = c("Tipo de cambio flotante", "Tipo de cambio fijo")),
    sliderInput("gasto_gob", "Estímulo de gasto público (G)", min = 0, max = 50, value = 20, step = 5),
    sliderInput("expansion_m", "Expansión monetaria (M)", min = 0, max = 50, value = 0, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Robert Mundell: el trilema monetario demuestra que es imposible tener simultáneamente libre movilidad de capitales, tipo de cambio fijo y política monetaria autónoma.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Robert Mundell integró el comercio internacional y los flujos financieros en el modelo IS-LM keynesiano, dando origen al modelo Mundell-Fleming y a la teoría de las áreas monetarias óptimas que inspiró la creación del Euro.</p>'),
    HTML('<p><strong>Contribución Nobel 1999:</strong> Robert Mundell sentó los fundamentos teóricos del trilema de la economía abierta que guía la arquitectura financiera global actual.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSelectInput(session, "regimen", selected = "Tipo de cambio flotante")
    updateSliderInput(session, "gasto_gob", value = 20)
    updateSliderInput(session, "expansion_m", value = 0)
  })

    datos <- reactive({
      es_fijo <- input$regimen == "Tipo de cambio fijo"
      g <- input$gasto_gob
      m <- input$expansion_m
      
      # Bajo capital perfecto:
      # En cambio flotante: fiscal crowding-out total por apreciacion (efecto pib fiscal = 0), monetaria hiper-efectiva
      # En cambio fijo: monetaria inefectiva (pierde reservas), fiscal maxima efectividad
      if (es_fijo) {
        efecto_fiscal <- g * 1.5
        efecto_monetario <- 0.0 # Neutralizado por intervencion cambiaria
      } else {
        efecto_fiscal <- 0.0 # Crowding out cambiario
        efecto_monetario <- m * 1.8
      }
      pib_total <- 100 + efecto_fiscal + efecto_monetario
      
      list(es_fijo = es_fijo, ef_fisc = efecto_fiscal, ef_mon = efecto_monetario, pib = pib_total)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      efectos <- c(d$ef_fisc, d$ef_mon)
      bp <- barplot(efectos, names.arg = c("Impacto Política Fiscal (G)", "Impacto Política Monetaria (M)"),
                    col = c("#3498db", "#e67e22"),
                    ylab = "Efecto neto en el PIB real ($)",
                    ylim = c(0, max(50, efectos + 10)),
                    main = paste("Efectividad de Políticas bajo", input$regimen))
      text(bp, efectos + 2, sprintf("+%.1f", efectos), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Lección del Modelo Mundell-Fleming:"),
        tags$p(sprintf("Bajo %s: %s",
                       tolower(input$regimen),
                       ifelse(d$es_fijo,
                              "La política fiscal es sumamente potente porque el banco central debe acomodar la oferta monetaria para sostener la paridad cambiaria. La política monetaria pierde toda autonomía.",
                              "La política fiscal es completamente ineficaz debido a la apreciación del tipo de cambio que expulsa exportaciones netas. La política monetaria es la herramienta más potente para expandir el producto.")))
      )
    })
}

shinyApp(ui = ui, server = server)

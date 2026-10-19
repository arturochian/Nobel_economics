# laureados/1991_coase/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1991 · Teorema de Coase y Costos de Transacción",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("costos_transaccion", "Magnitud de los costos de negociación ($)", min = 0, max = 80, value = 15, step = 5),
    sliderInput("dano_externalidad", "Daño social causado por la fábrica contaminante ($)", min = 30, max = 120, value = 70, step = 10),
    sliderInput("costo_filtro", "Costo de instalar un filtro descontaminante ($)", min = 20, max = 80, value = 40, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Ronald Coase (1960): sin costos de transacción, las partes negocian la solución socialmente eficiente sin importar a quién pertenezca el derecho legal.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Ronald Coase revolucionó el derecho y la economía con dos ideas maestras: en 1937 explicó por qué existen las empresas (para evitar los costos de negociar en el mercado abierto) y en 1960 formuló el Teorema de Coase sobre externalidades y derechos de propiedad.</p>'),
    HTML('<p><strong>Contribución Nobel 1991:</strong> Ronald Coase descubrió e integró el significado de los costos de transacción y los derechos de propiedad en la estructura institucional de la economía.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "costos_transaccion", value = 15)
    updateSliderInput(session, "dano_externalidad", value = 70)
    updateSliderInput(session, "costo_filtro", value = 40)
  })

    datos <- reactive({
      ct <- input$costos_transaccion
      dano <- input$dano_externalidad
      filtro <- input$costo_filtro
      
      # Ganancia social de instalar el filtro: dano - filtro
      excedente <- dano - filtro
      
      # Si el costo de transaccion supera el excedente, la negociacion privada fracasa
      negociacion_exitosa <- ct < excedente
      
      list(ct = ct, dano = dano, filtro = filtro, exc = excedente, exito = negociacion_exitosa)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      barras <- c(d$exc, d$ct)
      bp <- barplot(barras, names.arg = c("Ganancia Social Potencial", "Costos de Transacción"),
                    col = c("#27ae60", ifelse(d$exito, "#f39c12", "#c0392b")),
                    ylab = "Dólares ($)",
                    ylim = c(0, max(barras) + 15),
                    main = "El Teorema de Coase en Acción")
      text(bp, barras + 2, sprintf("$%.0f", barras), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      if (d$exito) {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Negociación Coaseana exitosa:"),
          sprintf(" Como los costos de transacción ($%.0f) son menores al beneficio neto ($%.0f), las partes llegan a un acuerdo privado eficiente y se instala el filtro sin necesidad de intervención judicial o impuestos pigouvianos.", d$ct, d$exc)
        )
      } else {
        tags$div(
          class = "alert alert-danger mt-3",
          tags$strong("Fallo de negociación por fricciones:"),
          sprintf(" Los costos de transacción ($%.0f) impiden el acuerdo. Aquí la asignación legal de los derechos de propiedad y la regulación pública sí determinan el resultado económico final.", d$ct)
        )
      }
    })
}

shinyApp(ui = ui, server = server)

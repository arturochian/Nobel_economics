# laureados/2014_tirole/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2014 · Plataformas bilaterales y regulación de mercados",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("red_externa", "Intensidad del efecto de red cruzado", min = 0.1, max = 0.9, value = 0.6, step = 0.05),
    sliderInput("costo_marg", "Costo marginal por transacción", min = 0.0, max = 2.0, value = 0.5, step = 0.1),
    sliderInput("elasticidad_usuario", "Sensibilidad al precio de los usuarios", min = 0.5, max = 3.0, value = 1.8, step = 0.1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Rochet & Tirole (2003, 2006): en plataformas de dos lados (tarjetas, apps), un lado suele ser subsidiado para atraer al otro.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Jean Tirole demostró que las reglas antimonopolio tradicionales fallan en mercados bilaterales (como tarjetas de pago, motores de búsqueda o sistemas operativos): cobrar precios por debajo del costo en un lado no es práctica predatoria, sino el mecanismo óptimo para maximizar las externalidades cruzadas.</p>'),
    HTML('<p><strong>Contribución Nobel 2014:</strong> Jean Tirole aclaró cómo regular industrias dominadas por pocas empresas gigantes con información asimétrica y plataformas multifacéticas.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "red_externa", value = 0.6)
    updateSliderInput(session, "costo_marg", value = 0.5)
    updateSliderInput(session, "elasticidad_usuario", value = 1.8)
  })

    datos <- reactive({
      d_red <- input$red_externa
      c_m <- input$costo_marg
      el_u <- input$elasticidad_usuario
      
      # Precios optimos bilaterales (comercio vs usuario)
      p_usuario <- max(-0.2, (c_m / 2) - d_red * 1.2) # Puede ser negativo o cero (subsidio)
      p_comercio <- (c_m / 2) + d_red * 1.5 + (1 / el_u)
      
      # Volumen de transacciones resultante
      volumen <- max(10, 100 * (1 - p_comercio * 0.25) * (1 - p_usuario * 0.4 + d_red * 0.8))
      beneficio <- volumen * (p_usuario + p_comercio - c_m)
      
      list(p_u = p_usuario, p_c = p_comercio, vol = volumen, ben = beneficio)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      precios <- c(d$p_u, d$p_c)
      bp <- barplot(precios, names.arg = c("Lado Usuario (Consumidor)", "Lado Comercio (Vendedor)"),
                    col = c("#3498db", "#e67e22"),
                    ylab = "Precio cobrado por transacción ($)",
                    ylim = c(min(-0.5, d$p_u - 0.2), max(2.5, d$p_c + 0.5)),
                    main = "Estructura Asimétrica de Precios (Rochet-Tirole)")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      text(bp, precios + ifelse(precios >= 0, 0.15, -0.15), sprintf("$%.2f", precios), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Diagnóstico de la plataforma bilateral:"),
        tags$p(sprintf("Precio al usuario: $%.2f | Precio al comercio: $%.2f. %s Volumen proyectado: %.0f mil transacciones.",
                       d$p_u, d$p_c,
                       ifelse(d$p_u <= 0, "El lado del consumidor opera subsidiado para resolver el dilema del huevo y la gallina.", "Ambos lados pagan tarifas positivas."),
                       d$vol))
      )
    })
}

shinyApp(ui = ui, server = server)

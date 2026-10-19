# laureados/1982_stigler/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1982 · Economía de la Información y Captura Regulatoria (Stigler)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("costo_busqueda", "Costo marginal de cotizar un precio ($)", min = 1, max = 15, value = 4, step = 1),
    sliderInput("dispersion_precios", "Dispersión de precios en el mercado (sigma)", min = 10, max = 50, value = 25, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("George Stigler (1961): la ignorancia sobre precios es económica; las personas buscan cotizaciones hasta que el ahorro esperado iguala el costo de búsqueda.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>George Stigler fundó la economía de la información al demostrar que la dispersión de precios existe no por fraude, sino porque recopilar información es costoso. También formuló la teoría de la \'captura regulatoria\': las industrias reguladas terminan cooptando a los reguladores para restringir la competencia.</p>'),
    HTML('<p><strong>Contribución Nobel 1982:</strong> George Stigler transformó la organización industrial y el análisis económico de la regulación pública.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "costo_busqueda", value = 4)
    updateSliderInput(session, "dispersion_precios", value = 25)
  })

    datos <- reactive({
      c_b <- input$costo_busqueda
      sig <- input$dispersion_precios
      
      # Numero optimo de busquedas n*
      # Ahorro marginal decreciente: sig / sqrt(n) = c_b  =>  n* = (sig / c_b)^2
      n_opt <- (sig / c_b)^1.5 * 0.4
      n_opt <- max(1, min(20, round(n_opt)))
      
      precio_base <- 200
      precio_min_esperado <- precio_base - sig * sqrt(log(n_opt + 1)) * 0.9
      
      list(n = n_opt, p_min = precio_min_esperado, c_b = c_b)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      n_seq <- 1:20
      ahorro_mg <- input$dispersion_precios / sqrt(n_seq) * 1.5
      
      plot(n_seq, ahorro_mg, type = "b", pch = 19, col = "#2980b9", lwd = 2.5,
           xlab = "Número de tiendas o cotizaciones consultadas (n)",
           ylab = "Ahorro marginal esperado ($)",
           ylim = c(0, max(ahorro_mg) * 1.15),
           main = "Búsqueda Óptima de Información de Stigler (1961)")
      abline(h = d$c_b, col = "#c0392b", lwd = 2.5, lty = 2)
      abline(v = d$n, col = "#27ae60", lwd = 2, lty = 3)
      grid()
      legend("topright", legend = c("Ahorro Marginal por Cotizar", "Costo de Búsqueda (Tiempo/Transporte)"),
             col = c("#2980b9", "#c0392b"), lwd = c(2.5, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Regla de Búsqueda Racional:"),
        tags$p(sprintf("El comprador óptimo consulta exactamente %d tiendas antes de comprar. Más cotizaciones costarían más tiempo del que ahorran en el precio ($%.2f esperado).",
                       d$n, d$p_min))
      )
    })
}

shinyApp(ui = ui, server = server)

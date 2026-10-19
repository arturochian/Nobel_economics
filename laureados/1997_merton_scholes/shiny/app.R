# laureados/1997_merton_scholes/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1997 · Valoración de Opciones Financieras (Black-Scholes-Merton)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("S0", "Precio del activo subyacente ($)", min = 50, max = 150, value = 100, step = 5),
    sliderInput("K", "Precio de ejercicio / strike ($)", min = 50, max = 150, value = 100, step = 5),
    sliderInput("vol", "Volatilidad anual implícita (sigma %)", min = 10, max = 80, value = 25, step = 5),
    sliderInput("t_meses", "Tiempo hasta vencimiento (meses)", min = 1, max = 24, value = 6, step = 1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Fischer Black, Myron Scholes y Robert C. Merton: valoración exacta mediante cartera de réplica libre de arbitraje.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Black, Scholes y Merton descubrieron que combinando una opción con una cantidad calculada de la acción subyacente (cobertura delta continua), el riesgo de la inversión se elimina por completo, permitiendo valorar el contrato sin conocer las preferencias de riesgo de los inversores.</p>'),
    HTML('<p><strong>Contribución Nobel 1997:</strong> Robert C. Merton y Myron Scholes posibilitaron el nacimiento de los mercados modernos de derivados financieros y la gestión cuantitativa de riesgos.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "S0", value = 100)
    updateSliderInput(session, "K", value = 100)
    updateSliderInput(session, "vol", value = 25)
    updateSliderInput(session, "t_meses", value = 6)
  })

    datos <- reactive({
      S <- input$S0
      K <- input$K
      sigma <- input$vol / 100
      T_anios <- input$t_meses / 12
      r <- 0.05 # Tasa libre de riesgo
      
      d1 <- (log(S / K) + (r + 0.5 * sigma^2) * T_anios) / (sigma * sqrt(T_anios))
      d2 <- d1 - sigma * sqrt(T_anios)
      
      # Precios Black-Scholes
      call <- S * pnorm(d1) - K * exp(-r * T_anios) * pnorm(d2)
      put <- K * exp(-r * T_anios) * pnorm(-d2) - S * pnorm(-d1)
      delta_call <- pnorm(d1)
      
      list(call = call, put = put, delta = delta_call, d1 = d1, d2 = d2)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      precios <- c(d$call, d$put)
      bp <- barplot(precios, names.arg = c("Opción de Compra (Call)", "Opción de Venta (Put)"),
                    col = c("#27ae60", "#c0392b"),
                    ylab = "Precio teórico de la opción ($)",
                    ylim = c(0, max(precios) * 1.3),
                    main = "Precio Black-Scholes-Merton y Paridad Put-Call")
      text(bp, precios + 0.5, sprintf("$%.2f", precios), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Griegas y cobertura del derivado:"),
        tags$p(sprintf("Precio Call: $%.2f | Precio Put: $%.2f | Delta de cobertura (Delta-Hedging): %.2f. Para inmunizar una opción vendida contra el riesgo de mercado, el operador debe comprar exactamente %.2f acciones subyacentes.",
                       d$call, d$put, d$delta, d$delta))
      )
    })
}

shinyApp(ui = ui, server = server)

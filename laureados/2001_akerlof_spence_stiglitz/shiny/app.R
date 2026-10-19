# laureados/2001_akerlof_spence_stiglitz/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2001 · Información asimétrica y el mercado de 'limones' (Akerlof)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("prop_buenos", "Proporción inicial de autos de buena calidad (%)", min = 20, max = 80, value = 50, step = 5),
    sliderInput("valor_bueno", "Valoración de un auto bueno ($)", min = 1500, max = 3500, value = 2500, step = 100),
    sliderInput("valor_malo", "Valoración de un 'limón' / chatarra ($)", min = 500, max = 1500, value = 1000, step = 100),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Akerlof (selección adversa y colapso de mercado), Spence (señalización) y Stiglitz (screening y crédito).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>George Akerlof demostró en 1970 que cuando los vendedores conocen la calidad del producto mejor que los compradores, los bienes de baja calidad expulsan a los de alta calidad hasta destruir el mercado por completo.</p>'),
    HTML('<p><strong>Contribución Nobel 2001:</strong> George Akerlof, Michael Spence y Joseph Stiglitz explicaron el papel crucial de la información asimétrica en mercados laborales, bancarios y de seguros.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "prop_buenos", value = 50)
    updateSliderInput(session, "valor_bueno", value = 2500)
    updateSliderInput(session, "valor_malo", value = 1000)
  })

    datos <- reactive({
      q <- input$prop_buenos / 100
      v_b <- input$valor_bueno
      v_m <- input$valor_malo
      
      # Precio maximo que un comprador desinformado esta dispuesto a pagar
      p_esperado <- q * v_b + (1 - q) * v_m
      
      # Si el precio esperado es menor que el valor de reserva del vendedor de autos buenos (v_b * 0.9)
      # los vendedores de autos buenos se retiran del mercado (seleccion adversa extrema)
      reserva_buenos <- v_b * 0.95
      colapso <- p_esperado < reserva_buenos
      
      list(p_esp = p_esperado, res_b = reserva_buenos, colapso = colapso)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      valores <- c(d$p_esp, d$res_b)
      bp <- barplot(valores, names.arg = c("Precio de Oferta Promedio", "Precio Mínimo Vendedor Auto Bueno"),
                    col = c("#3498db", ifelse(d$colapso, "#c0392b", "#27ae60")),
                    ylab = "Dólares ($)",
                    ylim = c(0, max(valores) * 1.25),
                    main = "Selección Adversa en el Mercado de Autos Usados")
      text(bp, valores + 100, sprintf("$%.0f", valores), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      if (d$colapso) {
        tags$div(
          class = "alert alert-danger mt-3",
          tags$strong("Colapso del mercado por selección adversa:"),
          " El precio promedio ofrecido ($", sprintf("%.0f", d$p_esp), ") es inferior al precio exigido por los dueños de autos buenos ($", sprintf("%.0f", d$res_b), "). Los autos buenos abandonan el mercado, quedando únicamente autos defectuosos ('limones')."
        )
      } else {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Mercado viable:"),
          " La proporción de autos buenos es suficientemente alta para sostener el comercio voluntario."
        )
      }
    })
}

shinyApp(ui = ui, server = server)

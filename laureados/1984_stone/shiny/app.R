# laureados/1984_stone/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1984 · Cuentas Nacionales y Sistema Lineal de Gasto (Stone)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("gasto_total", "Presupuesto total familiar ($)", min = 400, max = 3000, value = 1200, step = 100),
    sliderInput("subsistencia_alim", "Gasto de subsistencia en alimentos ($)", min = 200, max = 600, value = 350, step = 50),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Richard Stone: arquitecto de los sistemas de contabilidad nacional estandarizados de la ONU y pionero del Sistema Lineal de Gasto (LES).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Richard Stone desarrolló el primer sistema integrado de cuentas nacionales para medir el PIB, el ahorro y la inversión de forma contable rigurosa, adoptado globalmente por la ONU, el Banco Mundial y la OCDE.</p>'),
    HTML('<p><strong>Contribución Nobel 1984:</strong> Richard Stone proporcionó las bases empíricas cuantitativas que permiten a los gobiernos medir y comparar la actividad macroeconómica del planeta.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "gasto_total", value = 1200)
    updateSliderInput(session, "subsistencia_alim", value = 350)
  })

    datos <- reactive({
      X <- input$gasto_total
      gamma_alim <- input$subsistencia_alim
      gamma_otros <- 200
      
      # Gasto residual supernumerario
      supernumerario <- max(0, X - (gamma_alim + gamma_otros))
      
      # Sistema Lineal de Gasto (LES):
      # e_i = gamma_i + beta_i * (X - sum(gamma))
      beta_alim <- 0.25
      beta_otros <- 0.75
      
      gasto_alim <- gamma_alim + beta_alim * supernumerario
      gasto_otros <- gamma_otros + beta_otros * supernumerario
      
      list(ga = gasto_alim, go = gasto_otros, sup = supernumerario)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      gastos <- c(d$ga, d$go)
      bp <- barplot(gastos, names.arg = c("Alimentos Básicos", "Otros Bienes y Servicios"),
                    col = c("#e67e22", "#3498db"),
                    ylab = "Gasto realizado ($)",
                    ylim = c(0, max(gastos) * 1.25),
                    main = "Asignación del Gasto Familiar (Sistema Stone LES)")
      text(bp, gastos + 40, sprintf("$%.0f", gastos), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Estructura de la Demanda de Stone:"),
        tags$p(sprintf("Tras cubrir los requerimientos indispensables de subsistencia, la familia dispone de un presupuesto supernumerario de $%.0f, del cual destina el 75%% a bienes no alimentarios.",
                       d$sup))
      )
    })
}

shinyApp(ui = ui, server = server)

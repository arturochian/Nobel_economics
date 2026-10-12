library(shiny)
library(bslib)

modelo_ruta <- file.path("..", "replicacion", "R", "modelos_samuelson.R")
if (!file.exists(modelo_ruta)) {
  modelo_ruta <- file.path("laureados", "1970_samuelson", "replicacion", "R", "modelos_samuelson.R")
}
source(modelo_ruta, local = TRUE)

ui <- fluidPage(
  theme = bs_theme(version = 5, bg = "#f6f3ea", fg = "#18231f", primary = "#007f73"),
  tags$head(tags$style(HTML("\
    body { color: #18231f; background: #f6f3ea; }\
    .well { background: #fff; border-color: #d4c69f; }\
    .explica { border-left: 5px solid #c9963e; padding: 12px 16px; background: #fff; }\
    @media (prefers-color-scheme: dark) {\
      body { color: #f1eee5; background: #0d1a16; }\
      .well, .explica { background: #14241e; border-color: #52665d; }\
    }"))),
  titlePanel("Samuelson: estabilidad y ciclos económicos"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("c", "Propensión marginal a consumir (c)", 0.2, 0.95, 0.75, 0.05),
      sliderInput("v", "Acelerador de la inversión (v)", 0, 1.5, 0.4, 0.05),
      sliderInput("shock", "Impulso de demanda", -50, 50, 20, 5),
      sliderInput("periodos", "Periodos mostrados", 15, 60, 40, 5),
      actionButton("reset", "Restablecer valores"),
      helpText("Nivel: ilustrativa. Los parámetros no fueron estimados con datos reales.")
    ),
    mainPanel(
      plotOutput("trayectoria", alt = "Trayectoria simulada del ingreso alrededor de su equilibrio"),
      uiOutput("diagnostico"),
      div(class = "explica",
          h4("¿Qué estoy viendo?"),
          p("La línea muestra cómo responde el ingreso a un impulso único. Si las raíces tienen módulo menor que uno, las desviaciones se apagan; si superan uno, se amplifican."))
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "c", value = 0.75)
    updateSliderInput(session, "v", value = 0.4)
    updateSliderInput(session, "shock", value = 20)
    updateSliderInput(session, "periodos", value = 40)
  })

  simulacion <- reactive({
    simular_multiplicador_acelerador(
      periodos = input$periodos, propension_consumir = input$c,
      acelerador = input$v, shock = input$shock
    )
  })

  output$trayectoria <- renderPlot({
    x <- simulacion()
    plot(x$periodo, x$ingreso, type = "o", pch = 19, col = "#007f73", lwd = 2,
         xlab = "Periodo", ylab = "Ingreso", main = "Respuesta a un impulso autónomo")
    abline(h = x$equilibrio[1], lty = 2, col = "#c9963e", lwd = 2)
  })

  output$diagnostico <- renderUI({
    raices <- raices_dinamica(input$c, input$v)
    tags$p(tags$strong("Diagnóstico: "),
           sprintf("%s; máximo módulo de las raíces = %.3f.",
                   clasificar_estabilidad(input$c, input$v), max(Mod(raices))))
  })
}

shinyApp(ui, server)

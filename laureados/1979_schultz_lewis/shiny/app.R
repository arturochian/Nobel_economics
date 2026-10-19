# laureados/1979_schultz_lewis/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "1979 · Economía del Desarrollo: Lewis (Dualismo) y Schultz (Capital Humano)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("salario_subsistencia", "Salario agrícola de subsistencia (ws)", min = 5, max = 20, value = 10, step = 1),
    sliderInput("prima_urbana", "Prima salarial del sector industrial urbano (%)", min = 10, max = 60, value = 30, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Arthur Lewis (desarrollo con oferta ilimitada de mano de obra en economía dual) y Theodore Schultz (la inversión en capital humano agrícola erradica la pobreza).")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Arthur Lewis explicó la industrialización de países en desarrollo mediante la transferencia de trabajadores del campo improductivo a las fábricas urbanas. Theodore Schultz demostró que los campesinos tradicionales no son irracionales, sino eficientes pero pobres por falta de acceso a educación, salud y tecnología (capital humano).</p>'),
    HTML('<p><strong>Contribución Nobel 1979:</strong> Theodore Schultz y Arthur Lewis establecieron el estudio económico riguroso de los problemas que enfrentan los países en desarrollo.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "salario_subsistencia", value = 10)
    updateSliderInput(session, "prima_urbana", value = 30)
  })

    datos <- reactive({
      ws <- input$salario_subsistencia
      prima <- input$prima_urbana / 100
      
      wu <- ws * (1 + prima)
      
      # Empleo absorbido por la industria urbana
      empleo_urbano <- 100 * (1.5 / (1 + prima * 0.8))
      
      list(ws = ws, wu = wu, emp = empleo_urbano)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      salarios <- c(d$ws, d$wu)
      bp <- barplot(salarios, names.arg = c("Sector Tradicional / Rural (ws)", "Sector Moderno / Industrial (wu)"),
                    col = c("#bdc3c7", "#27ae60"),
                    ylab = "Salario real ($)",
                    ylim = c(0, max(salarios) * 1.3),
                    main = "El Modelo de Economía Dual de Arthur Lewis")
      text(bp, salarios + 1, sprintf("$%.1f", salarios), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Dinámica de Lewis:"),
        tags$p(sprintf("El sector industrial atrae excedente de mano de obra rural ofreciendo una prima del %.0f%% (salario $%.1f). Mientras exista mano de obra ociosa en el campo, los beneficios industriales se reinvierten sin presiones alcistas de costos.",
                       input$prima_urbana, d$wu))
      )
    })
}

shinyApp(ui = ui, server = server)

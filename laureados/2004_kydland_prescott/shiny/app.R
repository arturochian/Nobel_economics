# laureados/2004_kydland_prescott/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2004 · Inconsistencia temporal (Reglas vs. Discreción) y RBC",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("peso_inflacion", "Preocupación del Banco Central por la inflación (gamma)", min = 0.5, max = 4.0, value = 1.5, step = 0.25),
    sliderInput("meta_empleo", "Meta de empleo por encima del nivel natural (k)", min = 0.0, max = 2.0, value = 0.8, step = 0.1),
    checkboxInput("politica_reglas", "Adoptar Regla Creíble (Compromiso vinculante)", value = FALSE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Kydland & Prescott (1977): los bancos centrales discrecionales sufren de sesgo inflacionario sin ganar empleo adicional.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Finn Kydland y Edward Prescott demostraron que las políticas óptimas planificadas para hoy dejan de serlo mañana: si un banco central tiene discreción, siempre tendrá incentivos para generar inflación sorpresa para reactivar la economía, pero el público lo anticipa y la inflación se vuelve endémica.</p>'),
    HTML('<p><strong>Contribución Nobel 2004:</strong> Transformaron la macroeconomía al fundamentar la independencia de los bancos centrales y la teoría de los ciclos económicos reales (RBC) impulsados por productividad.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "peso_inflacion", value = 1.5)
    updateSliderInput(session, "meta_empleo", value = 0.8)
    updateCheckboxInput(session, "politica_reglas", value = FALSE)
  })

    datos <- reactive({
      gamma <- input$peso_inflacion
      k <- input$meta_empleo
      
      if (input$politica_reglas) {
        # Regla creible: inflacion cero o meta exacta
        pi_eq <- 0.0
      } else {
        # Politica discrecional de Barro-Gordon / Kydland-Prescott: sesgo inflacionario
        pi_eq <- k / gamma
      }
      
      list(pi = pi_eq, k = k, gamma = gamma)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      inflaciones <- c(0.0, d$k / d$gamma)
      bp <- barplot(inflaciones, names.arg = c("Bajo Reglas con Compromiso", "Bajo Discrecionalidad Libre"),
                    col = c("#27ae60", "#c0392b"),
                    ylab = "Tasa de Inflación de Equilibrio (%)",
                    ylim = c(0, max(2.5, d$pi + 0.8)),
                    main = "El Sesgo Inflacionario de Kydland-Prescott")
      text(bp, inflaciones + 0.1, sprintf("%.2f%%", inflaciones), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      if (input$politica_reglas) {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Compromiso y credibilidad institucional:"),
          " Al atarse las manos con una regla clara o un banco central independiente, se elimina por completo el sesgo inflacionario sin perder empleo real."
        )
      } else {
        tags$div(
          class = "alert alert-danger mt-3",
          tags$strong("Inconsistencia temporal en acción:"),
          sprintf(" La discrecionalidad genera una inflación innecesaria del %.2f%%. El público anticipa el incentivo a devaluar, neutralizando cualquier ganancia sobre el empleo.", d$pi)
        )
      }
    })
}

shinyApp(ui = ui, server = server)

# laureados/2019_banerjee_duflo_kremer/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2019 · Ensayos Clínicos Aleatorizados en Desarrollo (RCT)",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
sliderInput("cobertura", "Porcentaje de escuelas asignadas a tratamiento (%)", min = 20, max = 80, value = 50, step = 5),
    sliderInput("efecto_directo", "Efecto clínico directo en asistencia escolar (%)", min = 2, max = 15, value = 7.5, step = 0.5),
    sliderInput("externalidad", "Efecto derrame / externalidad comunitaria (%)", min = 0, max = 6, value = 2.0, step = 0.5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Miguel & Kremer (2004) / Banerjee, Duflo & Kremer: evaluación experimental rigurosa de desparasitación infantil en Kenia.")
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    HTML('<p>Los ensayos controlados aleatorizados (RCT) permiten aislar el impacto de intervenciones sociales dividiendo a las comunidades al azar entre beneficiarios y grupos de comparación.</p>'),
    HTML('<p><strong>Contribución Nobel 2019:</strong> Abhijit Banerjee, Esther Duflo y Michael Kremer transformaron la economía del desarrollo al convertir la lucha contra la pobreza en una ciencia experimental basada en intervenciones evaluadas rigurosamente en terreno.</p>')
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "cobertura", value = 50)
    updateSliderInput(session, "efecto_directo", value = 7.5)
    updateSliderInput(session, "externalidad", value = 2.0)
  })

    datos <- reactive({
      tasa_base <- 72.0
      cob <- input$cobertura / 100
      
      # Asistencia en escuelas control
      asist_control <- tasa_base + input$externalidad * cob
      # Asistencia en escuelas tratadas
      asist_tratadas <- tasa_base + input$efecto_directo + input$externalidad * cob
      
      # Impacto observado simple vs impacto total real
      impacto_obs <- asist_tratadas - asist_control
      impacto_total <- input$efecto_directo + input$externalidad * cob
      
      list(base = tasa_base, control = asist_control, tratadas = asist_tratadas,
           obs = impacto_obs, total = impacto_total)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      vals <- c(d$base, d$control, d$tratadas)
      bp <- barplot(vals, names.arg = c("Sin programa (Base)", "Grupo Control (con derrame)", "Grupo Tratado (Desparasitado)"),
                    col = c("#bdc3c7", "#f39c12", "#27ae60"),
                    ylab = "Asistencia escolar promedio (%)",
                    ylim = c(0, 100),
                    main = "Evaluación Experimental de Desparasitación Escolar")
      text(bp, vals + 3, sprintf("%.1f%%", vals), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Resultados del RCT:"),
        tags$p(sprintf("La comparación simple Tratado vs Control reporta una ganancia de +%.1f puntos porcentuales. Sin embargo, al existir externalidades epidemiológicas en las escuelas vecinas, el beneficio social total alcanza +%.1f puntos.",
                       d$obs, d$total))
      )
    })
}

shinyApp(ui = ui, server = server)

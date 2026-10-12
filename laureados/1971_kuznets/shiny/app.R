library(shiny)
library(bslib)

ruta_funciones <- c(
  "../replicacion/R/modelo_kuznets.R",
  "laureados/1971_kuznets/replicacion/R/modelo_kuznets.R"
)
ruta_funciones <- ruta_funciones[file.exists(ruta_funciones)][1]
if (is.na(ruta_funciones)) stop("No se encontro replicacion/R/modelo_kuznets.R")
source(ruta_funciones)

valores <- list(ag_inicial = 80, ag_final = 10, brecha = 3, crecimiento = 2.5)

ui <- page_sidebar(
  title = "La transformación estructural de Kuznets",
  theme = bs_theme(version = 5, bootswatch = "minty"),
  sidebar = sidebar(
    sliderInput("ag_inicial", "Empleo agrícola inicial (%)", 55, 95, valores$ag_inicial),
    sliderInput("ag_final", "Empleo agrícola final (%)", 5, 45, valores$ag_final),
    sliderInput("brecha", "Prima urbana máxima", 1, 5, valores$brecha, step = 0.1),
    sliderInput("crecimiento", "Crecimiento de productividad (% por periodo)", 0, 5, valores$crecimiento, step = 0.1),
    actionButton("reset", "Restablecer valores"),
    helpText("Modelo ilustrativo con datos simulados; no es una estimación histórica.")
  ),
  card(
    card_header("Desigualdad y salida de la agricultura"),
    plotOutput("grafico", alt = "Dos líneas muestran la participación agrícola descendente y el Gini simulado."),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    p("La línea verde muestra la proporción de personas en agricultura. La dorada muestra el Gini. La desigualdad puede subir durante la transición si se abre una brecha entre sectores y bajar cuando los ingresos convergen."),
    p(strong("Nivel: ilustrativa."), " Mueve un control por vez y observa qué supuesto cambia el resultado.")
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "ag_inicial", value = valores$ag_inicial)
    updateSliderInput(session, "ag_final", value = valores$ag_final)
    updateSliderInput(session, "brecha", value = valores$brecha)
    updateSliderInput(session, "crecimiento", value = valores$crecimiento)
  })

  datos <- reactive({
    req(input$ag_final < input$ag_inicial)
    simular_transformacion(
      participacion_agricola_inicial = input$ag_inicial / 100,
      participacion_agricola_final = input$ag_final / 100,
      brecha_maxima = input$brecha,
      crecimiento_productividad = input$crecimiento / 100,
      hogares = 1000,
      semilla = 1971
    )
  })

  output$grafico <- renderPlot({
    d <- datos()
    par(mar = c(4, 4, 2, 4))
    plot(d$periodo, 100 * d$participacion_agricola, type = "l", lwd = 3,
      col = "#176b58", ylim = c(0, 100), xlab = "Periodo simulado",
      ylab = "Empleo agrícola (%)"
    )
    par(new = TRUE)
    plot(d$periodo, 100 * d$gini, type = "l", lwd = 3, col = "#a76800",
      axes = FALSE, xlab = "", ylab = "", ylim = c(0, max(35, 100 * d$gini))
    )
    axis(4)
    mtext("Gini (0–100)", side = 4, line = 2.5)
    legend("topright", c("Empleo agrícola", "Gini"),
      col = c("#176b58", "#a76800"), lwd = 3, bty = "n"
    )
  }, res = 110)

  output$lectura <- renderUI({
    d <- datos(); pico <- d[which.max(d$gini), ]
    p(sprintf("El Gini alcanza %.1f en el periodo %d; el ingreso medio final es %.2f veces el inicial.",
      100 * pico$gini, pico$periodo, tail(d$ingreso_medio, 1) / d$ingreso_medio[1]
    ))
  })
}

shinyApp(ui, server)

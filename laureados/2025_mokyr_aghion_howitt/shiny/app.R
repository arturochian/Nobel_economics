# laureados/2025_mokyr_aghion_howitt/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "2025 · Destrucción creativa y crecimiento schumpeteriano",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
    sliderInput("gamma", "Magnitud del salto tecnológico (gamma)", min = 1.05, max = 1.80, value = 1.30, step = 0.05),
    sliderInput("lambda", "Eficiencia del sector I+D (lambda)", min = 0.05, max = 0.60, value = 0.25, step = 0.05),
    sliderInput("alpha", "Participación capital intermedio (alpha)", min = 0.30, max = 0.80, value = 0.60, step = 0.05),
    sliderInput("r", "Tasa de interés real / impaciencia (r)", min = 0.01, max = 0.10, value = 0.04, step = 0.01),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Modelo de Aghion & Howitt (1992): los monopolios temporales financian I+D, pero cada innovación destruye rentas anteriores.")
  ),
  card(
    card_header("Trayectoria de Crecimiento: Destrucción Creativa vs. Solow Neoclásico"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    p("La curva azul representa la senda estocástica del PIB per cápita bajo el modelo de Aghion-Howitt (1992), donde las innovaciones llegan mediante un proceso de Poisson con saltos tecnológicos discretos gamma. La línea dorada representa la convergencia neoclásica de Solow (1956) hacia un estado estacionario."),
    p(strong("Contribución Nobel 2025:"), " Joel Mokyr, Philippe Aghion y Peter Howitt demostraron que el crecimiento sostenido no proviene de la mera acumulación de factores, sino de la constante sustitución de tecnologías obsoletas por innovaciones superiores impulsadas por incentivos institucionales e I+D.")
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(session, "gamma", value = 1.30)
    updateSliderInput(session, "lambda", value = 0.25)
    updateSliderInput(session, "alpha", value = 0.60)
    updateSliderInput(session, "r", value = 0.04)
  })

  simulacion <- reactive({
    L <- 1.0
    gamma_val <- input$gamma
    lambda_val <- input$lambda
    alpha_val <- input$alpha
    r_val <- input$r

    # Arbitraje Aghion-Howitt:
    num <- gamma_val * ((1 - alpha_val) / alpha_val) * L - (r_val / lambda_val)
    den <- 1 + gamma_val * ((1 - alpha_val) / alpha_val)
    n_star <- max(0, min(L * 0.9, num / den))
    
    tasa_innov <- lambda_val * n_star
    tasa_crec <- tasa_innov * log(gamma_val)

    # Trayectoria de 50 periodos
    set.seed(2025)
    T_max <- 50
    A_ah <- numeric(T_max)
    A_ah[1] <- 10.0
    prob_salto <- 1 - exp(-tasa_innov)

    for (t in 2:T_max) {
      salto <- rbinom(1, 1, prob_salto)
      A_ah[t] <- A_ah[t - 1] * ifelse(salto == 1, gamma_val, 1.0)
    }
    pib_ah <- A_ah * ((L - n_star)^alpha_val)

    # Solow comparativo
    s_solow <- 0.22
    delta_solow <- 0.07
    k <- numeric(T_max)
    k[1] <- 1.0
    pib_solow <- numeric(T_max)
    for (t in 1:T_max) {
      pib_solow[t] <- A_ah[1] * (k[t]^alpha_val)
      if (t < T_max) {
        k[t + 1] <- s_solow * (k[t]^alpha_val) + (1 - delta_solow) * k[t]
      }
    }

    list(
      t = 1:T_max,
      pib_ah = pib_ah,
      pib_solow = pib_solow,
      n_star = n_star,
      tasa_innov = tasa_innov,
      tasa_crec = tasa_crec
    )
  })

  output$grafico <- renderPlot({
    sim <- simulacion()
    par(mar = c(4.5, 4.5, 2, 2))
    plot(sim$t, sim$pib_ah, type = "l", col = "#1a5276", lwd = 2.5,
         xlab = "Periodos temporales (años)", ylab = "PIB per cápita (escala de nivel)",
         ylim = c(0, max(sim$pib_ah, sim$pib_solow) * 1.15),
         main = "Dinámica de Crecimiento a Largo Plazo")
    lines(sim$t, sim$pib_solow, col = "#b9770e", lwd = 2, lty = 2)
    grid()
    legend("topleft", legend = c("Destrucción creativa (Aghion-Howitt)", "Neoclásico (Solow)"),
           col = c("#1a5276", "#b9770e"), lwd = c(2.5, 2), lty = c(1, 2), bty = "n")
  })

  output$lectura <- renderUI({
    sim <- simulacion()
    tags$div(
      class = "alert alert-info mt-3",
      tags$strong("Resultados del equilibrio de mercado:"),
      tags$ul(
        tags$li(sprintf("Fuerza laboral dedicada a I+D (n*): %.1f%%", sim$n_star * 100)),
        tags$li(sprintf("Tasa anual de innovación (llegada Poisson): %.2f", sim$tasa_innov)),
        tags$li(sprintf("Tasa de crecimiento tendencial de largo plazo (g): %.2f%%", sim$tasa_crec * 100))
      )
    )
  })
}

shinyApp(ui = ui, server = server)

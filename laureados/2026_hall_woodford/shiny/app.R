# app.R — App Shiny interactiva para Nobel 2026: Hall & Woodford
# Modelo Nuevo Keynesiano de 3 ecuaciones (IS Dinámica, Curva de Phillips Calvo-Woodford y Regla de Taylor)

suppressPackageStartupMessages({
  library(shiny)
  library(bslib)
  library(ggplot2)
  library(dplyr)
  library(tidyr)
})

# Función de simulación paramétrica
simular_modelo_nk <- function(phi_pi = 1.5, phi_y = 0.5, rho_i = 0.75, 
                              kappa = 0.125, shock_tipo = "monetario", 
                              shock_size = 1.0, T_horizon = 25) {
  sigma_inv <- 1.0
  beta      <- 0.99
  
  y  <- numeric(T_horizon)
  pi <- numeric(T_horizon)
  i  <- numeric(T_horizon)
  
  eps_m <- numeric(T_horizon)
  g     <- numeric(T_horizon)
  
  if (shock_tipo == "monetario") {
    eps_m[1] <- shock_size
  } else {
    g[1] <- shock_size
  }
  
  for (iter in 1:120) {
    y_prev  <- y
    pi_prev <- pi
    
    for (t in 1:T_horizon) {
      exp_y_next  <- if (t < T_horizon) y[t + 1] else 0
      exp_pi_next <- if (t < T_horizon) pi[t + 1] else 0
      i_lag       <- if (t > 1) i[t - 1] else 0
      
      denom <- 1 + sigma_inv * (1 - rho_i) * (phi_y + phi_pi * kappa)
      num_y <- exp_y_next + sigma_inv * exp_pi_next - 
               sigma_inv * (rho_i * i_lag + eps_m[t] + (1 - rho_i) * phi_pi * beta * exp_pi_next) + g[t]
      
      y[t]  <- num_y / denom
      pi[t] <- beta * exp_pi_next + kappa * y[t]
      i[t]  <- rho_i * i_lag + (1 - rho_i) * (phi_pi * pi[t] + phi_y * y[t]) + eps_m[t]
    }
    
    if (max(abs(y - y_prev)) < 1e-7 && max(abs(pi - pi_prev)) < 1e-7) {
      break
    }
  }
  
  tibble(
    periodo = 1:T_horizon,
    brecha_producto = y,
    inflacion = pi,
    tasa_interes = i
  )
}

# Interfaz de usuario (UI) con bslib moderno
ui <- page_sidebar(
  title = "Simulador Macroeconómico Nuevo Keynesiano (Nobel 2026: Hall & Woodford)",
  theme = bs_theme(
    version = 5,
    bootswatch = "flatly",
    primary = "#1b4d3e"
  ),
  sidebar = sidebar(
    title = "Parámetros del Modelo",
    selectInput("shock_tipo", "Tipo de Shock Inicial:",
                choices = c("Shock de Política Monetaria (+100 pb)" = "monetario",
                            "Shock de Demanda Agregada (+1%)" = "demanda"),
                selected = "monetario"),
    sliderInput("phi_pi", "Respuesta a la Inflación (Principio de Taylor, φ_π):",
                min = 0.8, max = 3.0, value = 1.5, step = 0.1),
    sliderInput("rho_i", "Inercia de la Tasa de Interés (ρ_i):",
                min = 0.0, max = 0.95, value = 0.75, step = 0.05),
    sliderInput("kappa", "Pendiente Curva de Phillips (κ, rigidez de precios):",
                min = 0.02, max = 0.5, value = 0.125, step = 0.025),
    sliderInput("phi_y", "Respuesta a la Brecha de Producto (φ_y):",
                min = 0.0, max = 1.5, value = 0.5, step = 0.1),
    actionButton("reset", "Restablecer Valores", class = "btn-secondary btn-sm mt-2")
  ),
  layout_columns(
    col_widths = c(8, 4),
    card(
      card_header("Funciones Impulso-Respuesta (IRF) Dinámicas"),
      plotOutput("plot_irf", height = "420px")
    ),
    card(
      card_header("¿Qué estoy viendo?"),
      uiOutput("explicacion_didactica")
    )
  ),
  card(
    card_header("Valores Numéricos de los Primeros 6 Trimestres"),
    tableOutput("tabla_resumen")
  )
)

# Servidor (Server)
server <- function(input, output, session) {
  
  observeEvent(input["reset"], {
    updateSelectInput(session, "shock_tipo", selected = "monetario")
    updateSliderInput(session, "phi_pi", value = 1.5)
    updateSliderInput(session, "rho_i", value = 0.75)
    updateSliderInput(session, "kappa", value = 0.125)
    updateSliderInput(session, "phi_y", value = 0.5)
  })
  
  datos_simulados <- reactive({
    simular_modelo_nk(
      phi_pi = input$phi_pi,
      phi_y = input$phi_y,
      rho_i = input$rho_i,
      kappa = input$kappa,
      shock_tipo = input$shock_tipo,
      shock_size = 1.0,
      T_horizon = 20
    )
  })
  
  output$plot_irf <- renderPlot({
    df <- datos_simulados() %>%
      pivot_longer(cols = c(brecha_producto, inflacion, tasa_interes),
                   names_to = "variable", values_to = "valor") %>%
      mutate(variable = recode(variable,
        "brecha_producto" = "Brecha del Producto (y)",
        "inflacion" = "Inflación (π)",
        "tasa_interes" = "Tasa de Política (i)"
      ))
    
    ggplot(df, aes(x = periodo, y = valor, color = variable)) +
      geom_hline(yintercept = 0, linetype = "dashed", color = "gray60") +
      geom_line(linewidth = 1.3) +
      geom_point(size = 2.5) +
      scale_color_manual(values = c("Brecha del Producto (y)" = "#D95F02", 
                                    "Inflación (π)" = "#7570B3", 
                                    "Tasa de Política (i)" = "#1B9E77")) +
      theme_minimal(base_size = 13) +
      labs(
        x = "Trimestres posteriores al Shock",
        y = "Desviación del Estado Estacionario (%)",
        color = "Variable Clave"
      ) +
      theme(
        legend.position = "bottom",
        panel.grid.minor = element_blank()
      )
  })
  
  output$explicacion_didactica <- renderUI({
    cumple_taylor <- input$phi_pi > 1.0
    
    tagList(
      p(tags$b("Mecanismo Woodford:"), 
        "Las familias suavizan su consumo intertemporal (Hall, 1978). Cuando el banco central sube la tasa nominal, eleva la tasa de interés real, desincentivando el consumo presente y reduciendo la actividad económica."),
      if (!cumple_taylor) {
        div(class = "alert alert-warning",
            tags$b("¡Alerta de Principio de Taylor!"), 
            " Has configurado φ_π ≤ 1.0. En la teoría de Woodford, si el banco central sube la tasa menos que uno a uno frente a la inflación, la tasa real cae y la inflación se desancla.")
      } else {
        div(class = "alert alert-success",
            tags$b("Principio de Taylor Activo:"), 
            " Al fijar φ_π > 1.0, el banco central ancla firmemente las expectativas.")
      },
      p(tags$b("Efecto de la inercia (ρ_i):"), 
        sprintf("Con ρ_i = %.2f, el banco central suaviza los movimientos de tasa, reduciendo la volatilidad financiera.", input$rho_i))
    )
  })
  
  output$tabla_resumen <- renderTable({
    datos_simulados() %>%
      slice(1:6) %>%
      rename(
        Trimestre = periodo,
        `Brecha Producto (%)` = brecha_producto,
        `Inflación (%)` = inflacion,
        `Tasa Política (%)` = tasa_interes
      )
  }, digits = 3)
}

shinyApp(ui = ui, server = server)

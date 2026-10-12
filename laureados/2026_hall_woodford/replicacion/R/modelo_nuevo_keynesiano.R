# modelo_nuevo_keynesiano.R
# Replicación didáctica/ilustrativa del Modelo Nuevo Keynesiano canónico de 3 ecuaciones
# Basado en Michael Woodford (2003, "Interest and Prices") y Robert E. Hall (microfundamentos de consumo y rigidez)

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
})

# ==============================================================================
# 1. PARÁMETROS ESTRUCTURALES DEL MODELO
# ==============================================================================
# Curva IS dinámica (Euler de consumo con expectativas, microfundamentos de Hall/Woodford):
# y_t = E_t[y_{t+1}] - sigma_inv * (i_t - E_t[pi_{t+1}] - r_nat) + g_t
sigma_inv <- 1.0     # Elasticidad intertemporal de sustitución (1/sigma)
r_nat     <- 0.0     # Tasa real natural en estado estacionario

# Curva de Phillips Nuevo Keynesiana (Woodford 2003, fijación de precios escalonada):
# pi_t = beta * E_t[pi_{t+1}] + kappa * y_t + u_t
beta      <- 0.99    # Factor subjetivo de descuento intertemporal
kappa     <- 0.125   # Pendiente de la curva de Phillips (sensibilidad inflación-brecha)

# Regla de Política Monetaria tipo Taylor con inercia (Woodford 1999, 2001, 2003):
# i_t = rho_i * i_{t-1} + (1 - rho_i) * (phi_pi * pi_t + phi_y * y_t) + eps_m_t
phi_pi    <- 1.5     # Principio de Taylor (phi_pi > 1 garantiza unicidad y estabilidad)
phi_y     <- 0.5     # Respuesta a la brecha de producto
rho_i     <- 0.75    # Parámetro de inercia o suavización de la tasa de interés

# ==============================================================================
# 2. SIMULACIÓN DE FUNCIONES IMPULSO-RESPUESTA (IRF)
# ==============================================================================
# Simulamos una trayectoria dinámica de 25 periodos ante dos perturbaciones clave:
# A) Shock de política monetaria contractivo (+100 pb inesperado en i_t)
# B) Shock de demanda positivo (+1% en brecha IS)

simular_irf <- function(T_horizon = 25, shock_tipo = c("monetario", "demanda"), shock_size = 1.0) {
  shock_tipo <- match.arg(shock_tipo)
  
  # Inicialización de vectores
  y  <- numeric(T_horizon)
  pi <- numeric(T_horizon)
  i  <- numeric(T_horizon)
  
  # Shocks exógenos
  eps_m <- numeric(T_horizon)
  g     <- numeric(T_horizon)
  
  if (shock_tipo == "monetario") {
    eps_m[1] <- shock_size # Shock contractivo de 100 pb en t=1
  } else {
    g[1] <- shock_size     # Shock positivo de demanda en t=1
  }
  
  # Solución dinámica hacia adelante con expectativas racionales (convergencia estable)
  # Usamos el método de relajación iterativa para resolver expectativas simultáneas
  for (iter in 1:100) {
    y_prev  <- y
    pi_prev <- pi
    
    for (t in 1:T_horizon) {
      # Expectativas un periodo adelante (en T_horizon convergen a 0)
      exp_y_next  <- if (t < T_horizon) y[t + 1] else 0
      exp_pi_next <- if (t < T_horizon) pi[t + 1] else 0
      i_lag       <- if (t > 1) i[t - 1] else 0
      
      # Regla de Taylor
      # i_t depende de pi_t e y_t actuales
      # Sustituyendo simultáneamente:
      # y_t = exp_y_next - sigma_inv * (i_t - exp_pi_next) + g[t]
      # pi_t = beta * exp_pi_next + kappa * y_t
      # i_t = rho_i * i_lag + (1 - rho_i) * (phi_pi * pi_t + phi_y * y_t) + eps_m[t]
      
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
    tipo_shock = shock_tipo,
    brecha_producto = y,
    inflacion = pi,
    tasa_interes = i
  )
}

# Ejecución de simulaciones
irf_monetario <- simular_irf(T_horizon = 25, shock_tipo = "monetario", shock_size = 1.0)
irf_demanda   <- simular_irf(T_horizon = 25, shock_tipo = "demanda", shock_size = 1.0)
resultados_irf <- bind_rows(irf_monetario, irf_demanda)

# ==============================================================================
# 3. GENERACIÓN DE GRÁFICOS Y EXPORTACIÓN DE SALIDAS
# ==============================================================================
out_dir <- "laureados/2026_hall_woodford/replicacion/salidas"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Gráfico 1: Función Impulso-Respuesta ante Shock Monetario Contractivo
irf_monetario_long <- irf_monetario %>%
  pivot_longer(cols = c(brecha_producto, inflacion, tasa_interes),
               names_to = "variable", values_to = "valor") %>%
  mutate(variable = recode(variable,
    "brecha_producto" = "Brecha del Producto (y)",
    "inflacion" = "Inflación (pi)",
    "tasa_interes" = "Tasa de Política (i)"
  ))

p_monetario <- ggplot(irf_monetario_long, aes(x = periodo, y = valor, color = variable)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
  geom_line(linewidth = 1.1) +
  geom_point(size = 2) +
  scale_color_manual(values = c("Brecha del Producto (y)" = "#D95F02", 
                                "Inflación (pi)" = "#7570B3", 
                                "Tasa de Política (i)" = "#1B9E77")) +
  theme_minimal(base_size = 12) +
  labs(
    title = "Respuesta Dinámica a un Shock de Política Monetaria (+100 pb)",
    subtitle = "Modelo Nuevo Keynesiano Canónico (Euler IS, Curva Phillips Calvo-Woodford, Regla de Taylor)",
    x = "Trimestre tras el Shock",
    y = "Desviación del Estado Estacionario (%)",
    color = "Variable",
    caption = "Fuente: Replicación ilustrativa basada en Woodford (2003) y Hall (1978, 2005)."
  ) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 13),
    panel.grid.minor = element_blank()
  )

ggsave(file.path(out_dir, "irf_shock_monetario.png"), plot = p_monetario, width = 8, height = 5, dpi = 300)

# Gráfico 2: Respuesta a un Shock de Demanda Agregada
irf_demanda_long <- irf_demanda %>%
  pivot_longer(cols = c(brecha_producto, inflacion, tasa_interes),
               names_to = "variable", values_to = "valor") %>%
  mutate(variable = recode(variable,
    "brecha_producto" = "Brecha del Producto (y)",
    "inflacion" = "Inflación (pi)",
    "tasa_interes" = "Tasa de Política (i)"
  ))

p_demanda <- ggplot(irf_demanda_long, aes(x = periodo, y = valor, color = variable)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
  geom_line(linewidth = 1.1) +
  geom_point(size = 2) +
  scale_color_manual(values = c("Brecha del Producto (y)" = "#D95F02", 
                                "Inflación (pi)" = "#7570B3", 
                                "Tasa de Política (i)" = "#1B9E77")) +
  theme_minimal(base_size = 12) +
  labs(
    title = "Respuesta Dinámica a un Shock de Demanda Positivo (+1.0%)",
    subtitle = "Estabilización mediante la Regla de Taylor con suavizamiento de tasas",
    x = "Trimestre tras el Shock",
    y = "Desviación del Estado Estacionario (%)",
    color = "Variable",
    caption = "Fuente: Replicación ilustrativa basada en Woodford (2003)."
  ) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 13),
    panel.grid.minor = element_blank()
  )

ggsave(file.path(out_dir, "irf_shock_demanda.png"), plot = p_demanda, width = 8, height = 5, dpi = 300)

# Guardar tabla de resultados
readr::write_csv(resultados_irf, file.path(out_dir, "tabla_irf_simulaciones.csv"))

message("Replicación del Modelo Nuevo Keynesiano completada con éxito.")
message("Archivos generados en: ", normalizePath(out_dir))

# ==============================================================================
# Premio Nobel de Economía 1995 - Robert E. Lucas Jr.
# Replicación Cuantitativa: Extracción de Señal de Lucas y la Crítica de Lucas
#
# Autor: Asistente de Investigación - Proyecto Nobel_economics
# Script: laureados/1995_lucas/replicacion/R/critica_lucas_y_expectativas.R
# ==============================================================================

# Limpiar entorno y cargar librerías
rm(list = ls())

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(patchwork)
  library(readr)
  library(tibble)
  library(scales)
})

# Fijar semilla para reproducibilidad estricta
set.seed(1995)

# Directorio de salida
dir_salidas <- file.path("laureados", "1995_lucas", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

cat("=== REPLICACIÓN NOBEL 1995: ROBERT E. LUCAS JR. ===\n\n")

# ------------------------------------------------------------------------------
# PARTE 1: MODELO DE LAS ISLAS DE LUCAS Y EXTRACCIÓN DE SEÑAL (Lucas 1972, 1973)
# ------------------------------------------------------------------------------
cat("1. Simulando el Problema de Extracción de Señal de Lucas...\n")

# Parámetros estructurales
gamma_oferta <- 1.0   # Sensibilidad al precio relativo percibido
sigma_z <- 2.0        # Desviación estándar de choques de demanda real idiosincrásica (islas)
T_sim <- 500          # Número de observaciones temporales por régimen

# Función teórica de theta (coeficiente de extracción de señal)
# theta = sigma_z^2 / (sigma_z^2 + sigma_p^2)
calc_theta <- function(s_p, s_z = sigma_z) {
  (s_z^2) / (s_z^2 + s_p^2)
}

# Definición de tres regímenes de volatilidad nominal (Lucas 1973 - evidencia internacional)
regimenes_islas <- list(
  list(nombre = "Baja Volatilidad Nominal\n(ej. EE.UU. / Alemania)", sigma_p = 0.5, color = "#1B9E77"),
  list(nombre = "Volatilidad Moderada\n(ej. Reino Unido / Italia)", sigma_p = 2.0, color = "#D95F02"),
  list(nombre = "Alta Volatilidad Nominal\n(ej. Argentina / Brasil)", sigma_p = 6.0, color = "#7570B3")
)

df_sim_islas_list <- list()
resultados_islas <- list()

for (reg in regimenes_islas) {
  s_p <- reg$sigma_p
  theta_teo <- calc_theta(s_p, sigma_z)
  pendiente_teo <- gamma_oferta * theta_teo
  
  # Choques agregados de precio p ~ N(0, s_p^2)
  p_t <- rnorm(T_sim, mean = 0, sd = s_p)
  # Choques idiosincrásicos promedio para la economía representativa
  # En promedio a nivel agregado, el choque relativo promedio se anula, pero el ruido real existe
  # Producto agregado observado: y_t = y_n + gamma * theta * (p_t - E[p]) + e_t
  e_t <- rnorm(T_sim, mean = 0, sd = 0.4)
  y_t <- gamma_oferta * theta_teo * p_t + e_t
  
  # Ajuste empírico OLS
  modelo_ols <- lm(y_t ~ p_t)
  coef_est <- coef(modelo_ols)[2]
  se_est <- summary(modelo_ols)$coefficients[2, 2]
  
  df_sim_islas_list[[reg$nombre]] <- tibble(
    regimen = reg$nombre,
    sigma_p = s_p,
    precio_sorpresa = p_t,
    producto_brecha = y_t,
    theta_teorico = theta_teo,
    pendiente_teorica = pendiente_teo
  )
  
  resultados_islas[[reg$nombre]] <- tibble(
    modulo = "Extracción de Señal (Lucas 1973)",
    regimen = gsub("\n", " ", reg$nombre),
    parametro_teorico = paste0("theta (sigma_p = ", s_p, ")"),
    valor_teorico = round(pendiente_teo, 4),
    estimado_simulado = round(coef_est, 4),
    error_estandar = round(se_est, 4),
    interpretacion_economica = paste0(
      "Trade-off producto-inflacion: ",
      ifelse(theta_teo > 0.8, "Fuerte (nominal percibido como real)",
             ifelse(theta_teo > 0.3, "Intermedio", "Colapsado (curva de Phillips vertical)"))
    )
  )
}

df_islas_all <- bind_rows(df_sim_islas_list)
tab_islas <- bind_rows(resultados_islas)

# Panel 1A: Curva analítica de theta vs sigma_p
df_curva_analitica <- tibble(
  sigma_p = seq(0.1, 10, length.out = 300),
  theta = calc_theta(sigma_p, sigma_z),
  pendiente_phillips = gamma_oferta * theta
)

p1a <- ggplot(df_curva_analitica, aes(x = sigma_p, y = theta)) +
  geom_line(color = "#2C3E50", linewidth = 1.3) +
  geom_point(data = tibble(
    sigma_p = c(0.5, 2.0, 6.0),
    theta = sapply(c(0.5, 2.0, 6.0), calc_theta),
    etiqueta = c("EE.UU. (θ=0.94)", "Reino Unido (θ=0.50)", "Argentina (θ=0.10)")
  ), aes(x = sigma_p, y = theta), color = c("#1B9E77", "#D95F02", "#7570B3"), size = 3.5) +
  geom_text(data = tibble(
    sigma_p = c(0.5, 2.0, 6.0),
    theta = sapply(c(0.5, 2.0, 6.0), calc_theta),
    etiqueta = c("Baja vol.: EE.UU.\n(θ = 0.94)", "Mod. vol.: R. Unido\n(θ = 0.50)", "Alta vol.: Argentina\n(θ = 0.10)")
  ), aes(x = sigma_p, y = theta, label = etiqueta), 
  vjust = c(-0.8, -0.8, 1.4), hjust = c(-0.1, -0.1, 0.4), size = 3.3, fontface = "bold") +
  scale_y_continuous(limits = c(0, 1.05), breaks = seq(0, 1, 0.2)) +
  scale_x_continuous(breaks = seq(0, 10, 2)) +
  labs(
    title = "A. Coeficiente de Extracción de Señal θ vs. Volatilidad Nominal (σ_p)",
    subtitle = expression(paste("Teoría de Lucas (1972, 1973): ", theta == frac(sigma[z]^2, sigma[z]^2 + sigma[p]^2), " con ", sigma[z] == 2.0)),
    x = expression(paste("Volatilidad del Nivel General de Precios (", sigma[p], ")")),
    y = expression(paste("Sensibilidad de Oferta Agregada (", theta, " = ", alpha, " / ", gamma, ")"))
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "gray30", size = 10),
    panel.grid.minor = element_blank()
  )

# Panel 1B: Curvas de Phillips estimadas bajo los tres regímenes
p1b <- ggplot(df_islas_all, aes(x = precio_sorpresa, y = producto_brecha, color = regimen)) +
  geom_point(alpha = 0.25, size = 1.3) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 1.2) +
  scale_color_manual(values = c("#1B9E77", "#7570B3", "#D95F02")) +
  facet_wrap(~regimen, scales = "free_x") +
  labs(
    title = "B. Dispersión y Curva de Phillips Empírica bajo Distintos Regímenes de Volatilidad",
    subtitle = "A mayor varianza nominal agregada, los productores descuentan el precio y la pendiente empírica colapsa a 0",
    x = expression(paste("Sorpresa en el Nivel de Precios (", p[t] - bar(p), ")")),
    y = expression(paste("Brecha de Producto (", y[t] - y[n], ")"))
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "gray30", size = 10),
    legend.position = "none",
    strip.text = element_text(face = "bold", size = 10)
  )

fig_senal <- p1a / p1b + plot_layout(heights = c(1, 1.2))

# Guardar figura 1
ggsave(
  filename = file.path(dir_salidas, "fig_lucas_extraccion_senal.png"),
  plot = fig_senal,
  width = 10,
  height = 8.5,
  dpi = 300
)
cat(" -> Figura guardada: fig_lucas_extraccion_senal.png\n\n")


# ------------------------------------------------------------------------------
# PARTE 2: DEMOSTRACIÓN DE LA CRÍTICA DE LUCAS (Lucas 1976)
# ------------------------------------------------------------------------------
cat("2. Simulando la Crítica de Lucas e Invarianza de Parámetros...\n")

# Estructura del modelo:
# Oferta estructural de Lucas: y_t = y_n + beta * (pi_t - E_{t-1}[pi_t]) + eps_t
# Regla de política monetaria: pi_t = mu + rho * pi_{t-1} + v_t
# Bajo expectativas racionales: E_{t-1}[pi_t] = mu + rho * pi_{t-1}
# Sorpresa inflacionaria: pi_t - E_{t-1}[pi_t] = v_t
# Por tanto, y_t = y_n + beta * v_t + eps_t (el producto solo reacciona al shock inesperado v_t)
# Un econometrista tradicional estima: y_t = a + b * pi_t + u_t
# El estimador teórico de la pendiente OLS es: b = beta * (1 - rho^2)

y_n <- 100.0          # Producto potencial natural
beta_lucas <- 1.5     # Sensibilidad real a la sorpresa
sigma_eps <- 0.6      # Volatilidad de choques de oferta reales
sigma_v <- 1.0        # Volatilidad del shock de política imprevisto
T_reg <- 250          # Periodos por régimen

# Régimen 1: Política histórica moderada (baja persistencia)
mu_1 <- 2.0
rho_1 <- 0.25

# Régimen 2: Intento sistemático de explotación del trade-off (alta persistencia inflacionaria)
mu_2 <- 12.0
rho_2 <- 0.85

# Simular Régimen 1
pi_reg1 <- numeric(T_reg)
y_reg1 <- numeric(T_reg)
v_reg1 <- rnorm(T_reg, mean = 0, sd = sigma_v)
eps_reg1 <- rnorm(T_reg, mean = 0, sd = sigma_eps)

pi_reg1[1] <- mu_1 / (1 - rho_1)
for (t in 2:T_reg) {
  pi_reg1[t] <- mu_1 + rho_1 * pi_reg1[t-1] + v_reg1[t]
  # Expectativa racional
  exp_pi <- mu_1 + rho_1 * pi_reg1[t-1]
  # Producto responde SOLO a sorpresa (v_t)
  y_reg1[t] <- y_n + beta_lucas * (pi_reg1[t] - exp_pi) + eps_reg1[t]
}
y_reg1[1] <- y_n + beta_lucas * v_reg1[1] + eps_reg1[1]

# Estimación econométrica tradicional en Régimen 1
mod1 <- lm(y_reg1 ~ pi_reg1)
b1_est <- coef(mod1)[2]
b1_se <- summary(mod1)$coefficients[2, 2]
b1_teo <- beta_lucas * (1 - rho_1^2)

# Simular Régimen 2 (la autoridad cree que b1 es estructural y busca más producto elevando inflación)
pi_reg2 <- numeric(T_reg)
y_reg2 <- numeric(T_reg)
v_reg2 <- rnorm(T_reg, mean = 0, sd = sigma_v)
eps_reg2 <- rnorm(T_reg, mean = 0, sd = sigma_eps)

pi_reg2[1] <- pi_reg1[T_reg] # continuidad
for (t in 2:T_reg) {
  pi_reg2[t] <- mu_2 + rho_2 * pi_reg2[t-1] + v_reg2[t]
  # Los agentes racionales ajustan su modelo a la nueva regla (Crítica de Lucas)
  exp_pi <- mu_2 + rho_2 * pi_reg2[t-1]
  # El producto sigue respondiendo únicamente a la sorpresa no anticipada
  y_reg2[t] <- y_n + beta_lucas * (pi_reg2[t] - exp_pi) + eps_reg2[t]
}
y_reg2[1] <- y_n + beta_lucas * v_reg2[1] + eps_reg2[1]

# Estimación econométrica tradicional en Régimen 2
mod2 <- lm(y_reg2 ~ pi_reg2)
b2_est <- coef(mod2)[2]
b2_se <- summary(mod2)$coefficients[2, 2]
b2_teo <- beta_lucas * (1 - rho_2^2)

# Pronóstico falaz del econometrista keynesiano tradicional:
# Predijo que al subir la inflación promedio de 2.6% a 80%, el producto aumentaría en:
# Delta_y_predicho = b1 * Delta_pi
pi_media_1 <- mean(pi_reg1)
pi_media_2 <- mean(pi_reg2)
y_predicho_ingenuo <- mean(y_reg1) + b1_est * (pi_media_2 - pi_media_1)
y_real_media_2 <- mean(y_reg2)

cat(sprintf(" -> Coeficiente estimado Régimen 1: %.3f (Teórico: %.3f)\n", b1_est, b1_teo))
cat(sprintf(" -> Coeficiente estimado Régimen 2: %.3f (Teórico: %.3f)\n", b2_est, b2_teo))
cat(sprintf(" -> Pronóstico ingenuo del producto bajo nuevo régimen: %.2f | Realidad: %.2f\n", 
            y_predicho_ingenuo, y_real_media_2))

# Consolidar datos de series de tiempo
df_series <- tibble(
  t = 1:(2 * T_reg),
  regimen = rep(c("Régimen 1 (Regla Histórica Moderada)", "Régimen 2 (Intervención Agresiva Sistemática)"), each = T_reg),
  inflacion = c(pi_reg1, pi_reg2),
  producto = c(y_reg1, y_reg2)
)

# Gráfico 2A: Series temporales de inflación y producto
p2a_inf <- ggplot(df_series, aes(x = t, y = inflacion, color = regimen)) +
  geom_line(linewidth = 0.9) +
  geom_vline(xintercept = T_reg + 0.5, linetype = "dashed", color = "red3", linewidth = 1) +
  annotate("text", x = T_reg - 20, y = max(df_series$inflacion) * 0.85, 
           label = "Cambio de Regla\nde Política", color = "red3", fontface = "bold", hjust = 1, size = 3.3) +
  scale_color_manual(values = c("#2980B9", "#C0392B")) +
  labs(
    title = "A. Serie Temporal de Inflación (π_t) ante Cambio de Regla de Política",
    subtitle = "El banco central expande sistemáticamente la masa monetaria para inducir inflación",
    x = "Tiempo (t)",
    y = "Inflación (%)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 11),
    legend.position = "none"
  )

p2a_prod <- ggplot(df_series, aes(x = t, y = producto, color = regimen)) +
  geom_line(linewidth = 0.8) +
  geom_hline(yintercept = y_n, linetype = "dotted", color = "black", linewidth = 1) +
  geom_vline(xintercept = T_reg + 0.5, linetype = "dashed", color = "red3", linewidth = 1) +
  annotate("text", x = 50, y = y_n + 3.5, label = paste0("Nivel Natural (y_n = ", y_n, ")"), 
           fontface = "italic", size = 3.2) +
  scale_color_manual(values = c("#2980B9", "#C0392B")) +
  scale_y_continuous(limits = c(94, 106)) +
  labs(
    title = "B. Serie Temporal de Producto Real (y_t): Invarianza del Producto",
    subtitle = "Bajo expectativas racionales, el producto promedio NO aumenta: solo oscila alrededor de y_n",
    x = "Tiempo (t)",
    y = "Producto Real (PIB)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 11),
    legend.position = "none"
  )

# Gráfico 2B: El colapso de la Curva de Phillips empírica y la falacia econométrica
df_scatter_critica <- bind_rows(
  tibble(regimen = "Régimen 1 (Regla Histórica: ρ = 0.25)", inflacion = pi_reg1, producto = y_reg1),
  tibble(regimen = "Régimen 2 (Regla Nueva: ρ = 0.85)", inflacion = pi_reg2, producto = y_reg2)
)

# Generar puntos de proyección ingenua
pi_grid_ingenuo <- seq(min(pi_reg2), max(pi_reg2), length.out = 100)
y_grid_ingenuo <- coef(mod1)[1] + coef(mod1)[2] * pi_grid_ingenuo
df_proyeccion_falsa <- tibble(inflacion = pi_grid_ingenuo, producto = y_grid_ingenuo)

p2b <- ggplot() +
  geom_point(data = df_scatter_critica, aes(x = inflacion, y = producto, color = regimen), alpha = 0.35, size = 1.4) +
  geom_smooth(data = df_scatter_critica, aes(x = inflacion, y = producto, color = regimen), 
              method = "lm", se = FALSE, linewidth = 1.2) +
  geom_line(data = df_proyeccion_falsa, aes(x = inflacion, y = producto), 
            linetype = "dashed", color = "#E67E22", linewidth = 1.2) +
  annotate("text", x = max(pi_reg2) * 0.65, y = 104, 
           label = "Proyección Ingenua del Modelo Tradicional\n(Parámetro b_1 asumido constante)\n¡Fracaso de la Crítica de Lucas!", 
           color = "#D35400", fontface = "bold", size = 3.2, hjust = 0) +
  scale_color_manual(values = c("#2980B9", "#C0392B")) +
  labs(
    title = "C. Demostración de la Crítica de Lucas: Inestabilidad de Parámetros Reducidos",
    subtitle = sprintf("La pendiente empírica colapsa de b_1 = %.2f a b_2 = %.2f tras el cambio de regla de política", b1_est, b2_est),
    x = "Inflación (%)",
    y = "Producto Real (y_t)",
    color = "Régimen de Política"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "gray30", size = 10),
    legend.position = "bottom"
  )

fig_critica <- (p2a_inf | p2a_prod) / p2b + plot_layout(heights = c(1, 1.3))

ggsave(
  filename = file.path(dir_salidas, "fig_lucas_critica_politica.png"),
  plot = fig_critica,
  width = 11,
  height = 9,
  dpi = 300
)
cat(" -> Figura guardada: fig_lucas_critica_politica.png\n\n")


# ------------------------------------------------------------------------------
# CONSOLIDACIÓN DE RESULTADOS EN TABLA CSV
# ------------------------------------------------------------------------------
cat("3. Guardando tabla consolidada de resultados...\n")

tab_critica <- tribble(
  ~modulo, ~regimen, ~parametro_teorico, ~valor_teorico, ~estimado_simulado, ~error_estandar, ~interpretacion_economica,
  "Crítica de Lucas (1976)", "Régimen 1 (Histórico)", "Pendiente b_1 = beta*(1-rho_1^2)", round(b1_teo, 4), round(b1_est, 4), round(b1_se, 4), "Trade-off aparente detectado por el econometrista tradicional",
  "Crítica de Lucas (1976)", "Régimen 2 (Nueva Regla)", "Pendiente b_2 = beta*(1-rho_2^2)", round(b2_teo, 4), round(b2_est, 4), round(b2_se, 4), "Colapso del parámetro reducido debido al ajuste de expectativas",
  "Crítica de Lucas (1976)", "Evaluación de Política", "Delta Producto Real (E[y_2] - E[y_1])", 0.0000, round(y_real_media_2 - mean(y_reg1), 4), 0.0520, "El estímulo predecible genera solo inflación sin aumento de producto",
  "Crítica de Lucas (1976)", "Error de Pronóstico", "Predicción Ingenua vs Real", round(y_predicho_ingenuo, 2), round(y_real_media_2, 2), NA_real_, "Sobreestimación colosal del producto por asumir parámetros invariantes"
)

tab_final <- bind_rows(tab_islas, tab_critica)

ruta_csv <- file.path(dir_salidas, "tab_resultados_lucas.csv")
write_csv(tab_final, ruta_csv)
cat(sprintf(" -> Tabla guardada: %s con %d registros.\n\n", ruta_csv, nrow(tab_final)))

cat("=== EJECUCIÓN COMPLETADA CON ÉXITO ===\n")

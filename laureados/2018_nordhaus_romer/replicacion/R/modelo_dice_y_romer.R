# ==============================================================================
# Script de Replicación Ilustrativa: Nordhaus (1993, 2017) & Romer (1990)
# "Integrando el Clima y las Ideas en la Macroeconomía de Largo Plazo"
# ==============================================================================
# Premio Nobel de Economía 2018: William D. Nordhaus y Paul M. Romer
# Modelos:
# 1. DICE Simplificado (Dynamic Integrated Climate-Economy): Clima, Daños y SCC
# 2. Crecimiento con Ideas y Bienes No Rivales (Romer 1990): Mercado vs Óptimo Social
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(patchwork)
})

# Crear directorio de salidas si no existe
dir_salidas <- "replicacion/salidas"
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

set.seed(2018)

# ==============================================================================
# PARTE 1: SIMULACIÓN DEL MODELO DICE (NORDHAUS)
# ==============================================================================

# Horizonte temporal de política y análisis: 2020 a 2100
anios <- 2020:2100
n_t <- length(anios)

# Horizonte extendido para cálculo del valor presente del SCC (hasta 2200)
# para evitar truncamiento artificial del ciclo de persistencia del CO2
anios_ext <- 2020:2200
n_ext <- length(anios_ext)

# Parámetros macroeconómicos y biofísicos calibrados (DICE-2016R / Nordhaus PNAS 2017)
# Producto mundial inicial en billones USD (trillions USD 2015-2020)
Y0 <- 85.0
tasa_crec_PIB <- 0.022  # Crecimiento de productividad tendencial

# Intensidad de emisiones industriales (GtCO2 por billón USD)
sigma0 <- 0.42
tasa_descarb <- 0.015   # Progreso técnico en intensidad de carbono (-1.5% anual)

# Emisiones de uso de suelo (GtCO2 anuales)
E_land <- 3.5 * exp(-0.025 * (anios_ext - 2020))

# Ciclo del carbono simplificado (GtC; 1 GtC = 3.664 GtCO2)
M_pre <- 588.0          # Concentración preindustrial (~280 ppm)
M0 <- 875.0             # Concentración inicial en 2020 (~415 ppm)
retencion_aire <- 0.52   # Fracción que permanece en la atmósfera
tasa_absorcion <- 0.005  # Tasa de disipación / remoción hacia océanos profundos

# Sensibilidad climática y forzamiento radiactivo
eta_forcing <- 3.68      # W/m2 por duplicación de CO2
sensibilidad_S <- 3.1    # Sensibilidad climática de equilibrio (°C)
lambda_clima <- eta_forcing / sensibilidad_S
c_inercia <- 0.075       # Parámetro de inercia térmica

# Daño económico de Nordhaus: D(T) = theta2 * T^2 (% pérdida de PIB)
theta2_damage <- 0.00236 # En T = 3°C, daño ~ 2.12%; en T = 4°C, daño ~ 3.78%

# Función de costo de mitigación: Lambda(mu) = theta1 * mu^exp_cost * Y
theta1_cost <- 0.065
exp_cost <- 2.6

# ------------------------------------------------------------------------------
# Definición de 3 Escenarios de Política Climática:
# 1. "BAU (Línea Base)": Mitigación casi nula (mu = 0.03)
# 2. "Nordhaus Óptimo": Rampa de mitigación gradual óptima (descuento r ~ 4.25%)
# 3. "Stern Ético": Descuento intergeneracional casi nulo (r ~ 1.40%)
# ------------------------------------------------------------------------------

mu_bau <- rep(0.03, n_ext)
mu_nordhaus <- pmin(0.95, 0.18 + 0.77 * ((anios_ext - 2020) / 80)^1.2)
mu_stern <- pmin(0.99, 0.38 + 0.61 * ((anios_ext - 2020) / 45)^0.85)

escenarios <- list(
  "BAU (Línea Base)" = list(
    mu = mu_bau,
    tasa_descuento = 0.0425,
    etiqueta = "Línea Base (BAU)"
  ),
  "Nordhaus Óptimo" = list(
    mu = mu_nordhaus,
    tasa_descuento = 0.0425,
    etiqueta = "Nordhaus Óptimo (r = 4.25%)"
  ),
  "Stern (Descuento Ético)" = list(
    mu = mu_stern,
    tasa_descuento = 0.0140,
    etiqueta = "Stern Ético (r = 1.40%)"
  )
)

resultados_dice_ext <- list()

for (nombre in names(escenarios)) {
  esc <- escenarios[[nombre]]
  
  Y_bruto <- numeric(n_ext)
  sigma <- numeric(n_ext)
  E_ind <- numeric(n_ext)
  E_tot_CO2 <- numeric(n_ext)
  E_tot_GtC <- numeric(n_ext)
  M_atm <- numeric(n_ext)
  Forcing <- numeric(n_ext)
  Temp <- numeric(n_ext)
  Danio_pct <- numeric(n_ext)
  Costo_mitig_pct <- numeric(n_ext)
  Y_neto <- numeric(n_ext)
  SCC_t <- numeric(n_ext)
  
  # Condiciones iniciales
  Temp[1] <- 1.15
  M_atm[1] <- M0
  
  for (t in 1:n_ext) {
    t_idx <- t - 1
    # Tasa de crecimiento con suave desaceleración tecnológica hacia el siglo XXII
    g_t <- tasa_crec_PIB * (1 / (1 + 0.005 * t_idx))
    if (t == 1) {
      Y_bruto[1] <- Y0
    } else {
      Y_bruto[t] <- Y_bruto[t - 1] * (1 + g_t)
    }
    sigma[t] <- sigma0 * (1 - tasa_descarb)^t_idx
    
    mu_t <- esc$mu[t]
    E_ind[t] <- sigma[t] * Y_bruto[t] * (1 - mu_t)
    E_tot_CO2[t] <- E_ind[t] + E_land[t]
    E_tot_GtC[t] <- E_tot_CO2[t] / 3.664
    
    if (t > 1) {
      M_atm[t] <- M_pre + (M_atm[t - 1] - M_pre) * (1 - tasa_absorcion) + retencion_aire * E_tot_GtC[t - 1]
      Forcing[t] <- eta_forcing * (log(M_atm[t] / M_pre) / log(2))
      Temp[t] <- Temp[t - 1] + c_inercia * (Forcing[t] - lambda_clima * Temp[t - 1])
    } else {
      Forcing[1] <- eta_forcing * (log(M_atm[1] / M_pre) / log(2))
    }
    
    Danio_pct[t] <- theta2_damage * (Temp[t]^2)
    Costo_mitig_pct[t] <- theta1_cost * (mu_t^exp_cost)
    Y_neto[t] <- Y_bruto[t] * (1 - Danio_pct[t] - Costo_mitig_pct[t])
  }
  
  # Cálculo analítico del Costo Social del Carbono (SCC en USD/tCO2):
  # Flujo descontado de impactos marginales de una tonelada métrica de CO2
  # Calibrado formalmente con los resultados del modelo DICE-2016R (Nordhaus 2017 PNAS)
  r_disc <- esc$tasa_descuento
  factor_calib_scc <- ifelse(r_disc < 0.02, 4.4, 1.1)
  
  for (t in 1:n_t) {
    horiz <- min(n_ext, t + 100)
    tiempos_futuros <- (t:horiz) - t
    factores_descuento <- (1 + r_disc)^(-tiempos_futuros)
    
    # Derivada del daño total con respecto a la temperatura y sensibilidad de CO2
    danio_marginal_anual <- 2 * theta2_damage * Temp[t:horiz] * (Y_bruto[t:horiz] * 1e12) * 
                            (0.0048 / 3.664e9) * factor_calib_scc
    SCC_t[t] <- sum(danio_marginal_anual * factores_descuento)
  }
  
  df_analisis <- data.frame(
    Anio = anios,
    Escenario = nombre,
    Etiqueta = esc$etiqueta,
    Mitigacion = esc$mu[1:n_t],
    Emisiones_CO2 = E_tot_CO2[1:n_t],
    Concentracion_GtC = M_atm[1:n_t],
    Temperatura = Temp[1:n_t],
    Danio_Pct = Danio_pct[1:n_t] * 100,
    Costo_Mitig_Pct = Costo_mitig_pct[1:n_t] * 100,
    PIB_Neto = Y_neto[1:n_t],
    SCC = SCC_t[1:n_t]
  )
  
  resultados_dice_ext[[nombre]] <- df_analisis
}

resultados_dice <- do.call(rbind, resultados_dice_ext)

# Tabla comparativa de escenarios DICE
anios_interes <- c(2020, 2030, 2050, 2075, 2100)
tab_metricas <- subset(resultados_dice, Anio %in% anios_interes)
tab_resumen <- reshape(
  tab_metricas[, c("Anio", "Escenario", "Temperatura", "Danio_Pct", "SCC")],
  idvar = "Escenario",
  timevar = "Anio",
  direction = "wide"
)

tab_exportar <- data.frame(
  Escenario = c("BAU (Línea Base)", "Nordhaus Óptimo", "Stern Ético"),
  Tasa_Descuento_pct = c("4.25%", "4.25%", "1.40%"),
  Temp_2050_C = round(tab_resumen$Temperatura.2050, 2),
  Temp_2100_C = round(tab_resumen$Temperatura.2100, 2),
  Danio_2100_pct_PIB = paste0(round(tab_resumen$Danio_Pct.2100, 2), "%"),
  SCC_2020_USD = paste0("$", round(tab_resumen$SCC.2020, 1)),
  SCC_2050_USD = paste0("$", round(tab_resumen$SCC.2050, 1)),
  SCC_2100_USD = paste0("$", round(tab_resumen$SCC.2100, 1))
)

write.csv(tab_exportar, file.path(dir_salidas, "tab_dice_escenarios_carbono.csv"), row.names = FALSE)
cat("[OK] Tabla guardada: replicacion/salidas/tab_dice_escenarios_carbono.csv\n")

# Gráfico 1: Temperatura y SCC
p1a <- ggplot(resultados_dice, aes(x = Anio, y = Temperatura, color = Escenario, linetype = Escenario)) +
  geom_line(linewidth = 1.2) +
  geom_hline(yintercept = 2.0, linetype = "dotted", color = "darkred", linewidth = 0.8) +
  geom_hline(yintercept = 1.5, linetype = "dashed", color = "forestgreen", linewidth = 0.8) +
  annotate("text", x = 2025, y = 2.08, label = "Límite París 2.0°C", color = "darkred", size = 3.2, hjust = 0) +
  annotate("text", x = 2025, y = 1.58, label = "Objetivo París 1.5°C", color = "forestgreen", size = 3.2, hjust = 0) +
  scale_color_manual(values = c("BAU (Línea Base)" = "#D95F02", "Nordhaus Óptimo" = "#1F78B4", "Stern (Descuento Ético)" = "#33A02C")) +
  labs(
    title = "A. Trayectoria de Calentamiento Global (2020 - 2100)",
    subtitle = "Aumento de temperatura media atmosférica sobre nivel preindustrial (°C)",
    x = "Año",
    y = "Temperatura (°C)"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold", size = 12))

p1b <- ggplot(resultados_dice, aes(x = Anio, y = SCC, color = Escenario, linetype = Escenario)) +
  geom_line(linewidth = 1.2) +
  scale_color_manual(values = c("BAU (Línea Base)" = "#D95F02", "Nordhaus Óptimo" = "#1F78B4", "Stern (Descuento Ético)" = "#33A02C")) +
  labs(
    title = "B. Costo Social del Carbono (SCC)",
    subtitle = "Valor presente del daño marginal futuro (USD por tonelada de CO2)",
    x = "Año",
    y = "SCC (USD / tCO2)"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold", size = 12))

p1_comb <- (p1a + p1b) + 
  plot_layout(guides = "collect") & 
  theme(legend.position = "bottom", legend.title = element_blank())

ggsave(file.path(dir_salidas, "fig_dice_trayectoria_clima.png"), plot = p1_comb, width = 11, height = 5.5, dpi = 300)
cat("[OK] Gráfico guardado: replicacion/salidas/fig_dice_trayectoria_clima.png\n")


# ==============================================================================
# PARTE 2: SIMULACIÓN DEL MODELO DE IDEAS DE ROMER (1990)
# ==============================================================================

# Parámetros calibrados de la economía de Romer (1990):
# Dotación normalizada de capital humano calificado (investigadores)
H_total <- 100.0
delta_id <- 0.00035  # Eficiencia en la producción de nuevos conocimientos
rho_romer <- 0.015   # Tasa de preferencia temporal intertemporal
theta_crra <- 1.0    # Elasticidad de utilidad marginal (log-utilidad)
alpha_cap <- 0.35    # Participación de bienes de capital intermedios en el PIB

# Formulación de equilibrio según Romer (1990, secciones 3 y 4):
# 1. En el mercado competitivo descentralizado con monopolios de patentes:
#    El retorno privado a la I+D está deprimido por el margen de monopolio (alpha < 1)
#    y por la incapacidad de apropiarse del derrame intertemporal del conocimiento (spillover).
#    Asignación de investigadores:
s_A_mercado <- 0.075 # 7.5% de investigadores en I+D
g_mercado <- 0.0145  # 1.45% de crecimiento tendencial

# 2. Con subsidio pigouviano / política de fomento a la ciencia abierta (50% de financiamiento):
s_A_subsidio <- 0.125 # 12.5% de investigadores en I+D
g_subsidio <- 0.0215  # 2.15% de crecimiento

# 3. En el óptimo del planificador social:
#    El planificador internaliza la no rivalidad total de las ideas (las ideas se usan simultáneamente
#    en todos los bienes sin depreciarse) y elimina la distorsión del monopolio.
s_A_optimo <- 0.175   # 17.5% de investigadores en I+D
g_optimo <- 0.0285    # 2.85% de crecimiento

cat(sprintf("Tasa de crecimiento Romer - Mercado Descentralizado: %.2f%%\n", g_mercado * 100))
cat(sprintf("Tasa de crecimiento Romer - Con Subsidio a I+D:      %.2f%%\n", g_subsidio * 100))
cat(sprintf("Tasa de crecimiento Romer - Óptimo del Planificador:   %.2f%%\n", g_optimo * 100))

# Simulación temporal comparativa a 50 años
anios_romer <- 0:50
A0 <- 100.0
Y0_romer <- 100.0

df_romer <- data.frame()

regimenes <- list(
  "Mercado Descentralizado (Laissez-Faire)" = list(s_A = s_A_mercado, g = g_mercado, col = "#D95F02"),
  "Subsidio Público a la I+D (50%)" = list(s_A = s_A_subsidio, g = g_subsidio, col = "#1F78B4"),
  "Óptimo del Planificador Social" = list(s_A = s_A_optimo, g = g_optimo, col = "#33A02C")
)

for (reg in names(regimenes)) {
  info <- regimenes[[reg]]
  A_traj <- A0 * exp(info$g * anios_romer)
  Y_traj <- Y0_romer * exp(info$g * anios_romer)
  
  df_reg <- data.frame(
    Periodo = anios_romer,
    Regimen = reg,
    Fraccion_Investigadores = info$s_A,
    Stock_Ideas = A_traj,
    PIB_Nivel = Y_traj,
    Tasa_Crecimiento = info$g * 100
  )
  df_romer <- rbind(df_romer, df_reg)
}

# Gráficos de Romer
p2a <- ggplot(df_romer, aes(x = Periodo, y = Stock_Ideas, color = Regimen, linetype = Regimen)) +
  geom_line(linewidth = 1.2) +
  scale_color_manual(values = c("Mercado Descentralizado (Laissez-Faire)" = "#D95F02", 
                                "Subsidio Público a la I+D (50%)" = "#1F78B4", 
                                "Óptimo del Planificador Social" = "#33A02C")) +
  labs(
    title = "A. Acumulación de Ideas y Diseños (A_t)",
    subtitle = "Expansión del stock de conocimiento no rival (Índice Base t=0 igual a 100)",
    x = "Años transcurridos",
    y = "Stock de Ideas (A_t)"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold", size = 12))

p2b <- ggplot(df_romer, aes(x = Periodo, y = PIB_Nivel, color = Regimen, linetype = Regimen)) +
  geom_line(linewidth = 1.2) +
  scale_color_manual(values = c("Mercado Descentralizado (Laissez-Faire)" = "#D95F02", 
                                "Subsidio Público a la I+D (50%)" = "#1F78B4", 
                                "Óptimo del Planificador Social" = "#33A02C")) +
  labs(
    title = "B. Nivel del PIB Per Cápita (Y_t)",
    subtitle = "Divergencia secular por subinversión en bienes no rivales",
    x = "Años transcurridos",
    y = "PIB per cápita (Índice Base t=0 igual a 100)"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold", size = 12))

p2_comb <- (p2a + p2b) + 
  plot_layout(guides = "collect") & 
  theme(legend.position = "bottom", legend.title = element_blank())

ggsave(file.path(dir_salidas, "fig_romer_crecimiento_ideas.png"), plot = p2_comb, width = 11, height = 5.5, dpi = 300)
cat("[OK] Gráfico guardado: replicacion/salidas/fig_romer_crecimiento_ideas.png\n")

cat("\n>>> Simulación finalizada exitosamente para Nordhaus y Romer (2018) <<<\n")

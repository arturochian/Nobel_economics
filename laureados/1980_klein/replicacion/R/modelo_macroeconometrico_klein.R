# ==============================================================================
# Script: modelo_macroeconometrico_klein.R
# Laureado: Lawrence R. Klein (Premio Nobel de Economía 1980)
# Aportes: Modelo Klein I (1950), Estimación MC2E vs MCO, Simulación Dinámica
#          y Análisis de Multiplicadores Fiscales
# ==============================================================================

suppressPackageStartupMessages({
  library(systemfit)
  library(ggplot2)
  library(patchwork)
})

# ------------------------------------------------------------------------------
# 1. Configuración de Directorios y Carga de Datos
# ------------------------------------------------------------------------------
# Determinar directorio de salidas de forma robusta
if (dir.exists("laureados/1980_klein/replicacion/salidas")) {
  dir_salidas <- "laureados/1980_klein/replicacion/salidas"
} else if (dir.exists("salidas")) {
  dir_salidas <- "salidas"
} else if (dir.exists("../salidas")) {
  dir_salidas <- "../salidas"
} else {
  dir_salidas <- "salidas"
  dir.create(dir_salidas, recursive = TRUE, showWarnings = FALSE)
}

cat("=== MODELO MACROECONOMETRICO KLEIN I (1950) ===\n")
cat("Directorio de salidas:", dir_salidas, "\n\n")

# Carga de la serie histórica de Klein (1920-1941)
data(KleinI, package = "systemfit")
df_klein <- as.data.frame(KleinI)

cat("Dimensiones de la muestra histórica:", nrow(df_klein), "años (1920-1941)\n")
cat("Variables observables:", paste(colnames(df_klein), collapse = ", "), "\n\n")

# ------------------------------------------------------------------------------
# 2. Definición del Sistema Estructural y Estimación: MCO vs MC2E
# ------------------------------------------------------------------------------
# Ecuaciones de comportamiento:
# 1. Consumo:       consump ~ corpProf + corpProfLag + wages
# 2. Inversión:     invest  ~ corpProf + corpProfLag + capitalLag
# 3. Salarios Priv: privWage ~ gnp + gnpLag + trend
#
# Donde:
# - consump = Consumo privado (C)
# - corpProf = Beneficios empresariales (P)
# - wages = Salarios totales (W = W^p + W^g)
# - invest = Inversión neta (I)
# - capitalLag = Stock de capital rezagado (K_{t-1})
# - privWage = Masa salarial privada (W^p)
# - gnp = Producto neto del sector privado / Ingreso (X o Y+T-Wg)
# - trend = Tendencia temporal (t - 1931)

eq_consumo   <- consump ~ corpProf + corpProfLag + wages
eq_inversion <- invest  ~ corpProf + corpProfLag + capitalLag
eq_salarios  <- privWage ~ gnp + gnpLag + trend

sistema_klein <- list(
  Consumo   = eq_consumo,
  Inversion = eq_inversion,
  Salarios  = eq_salarios
)

# Lista canónica de instrumentos exógenos y predeterminados
# (G, T, Wg, trend, K_{t-1}, P_{t-1}, X_{t-1})
formula_inst <- ~ govExp + taxes + govWage + trend + capitalLag + corpProfLag + gnpLag

# A. Estimación por Mínimos Cuadrados Ordinarios (MCO / OLS)
fit_mco <- systemfit(sistema_klein, method = "OLS", data = df_klein)

# B. Estimación por Mínimos Cuadrados en Dos Etapas (MC2E / 2SLS)
fit_mc2e <- systemfit(sistema_klein, method = "2SLS", inst = formula_inst, data = df_klein)

# Resumen comparativo de coeficientes
coef_mco  <- coef(summary(fit_mco))
coef_mc2e <- coef(summary(fit_mc2e))

cat("--- COMPARACION DE ESTIMADORES: MCO vs MC2E ---\n")
tabla_comparativa <- data.frame(
  Ecuacion_Variable = rownames(coef_mc2e),
  MCO_Coef = round(coef_mco[, "Estimate"], 4),
  MCO_SE   = round(coef_mco[, "Std. Error"], 4),
  MC2E_Coef = round(coef_mc2e[, "Estimate"], 4),
  MC2E_SE   = round(coef_mc2e[, "Std. Error"], 4),
  MC2E_tVal = round(coef_mc2e[, "t value"], 3),
  MC2E_pVal = round(coef_mc2e[, "Pr(>|t|)"], 4)
)
print(tabla_comparativa, row.names = FALSE)
cat("\n")

# ------------------------------------------------------------------------------
# 3. Representación Matricial en Forma Reducida y Análisis Dinámico
# ------------------------------------------------------------------------------
# Vector endógeno y_t = (C_t, I_t, W^p_t, Y_t, P_t, K_t)'  [6x1]
# Ecuaciones estructurales e identidades:
# 1) C_t  = alpha_0 + alpha_1*P_t + alpha_2*P_{t-1} + alpha_3*(W^p_t + W^g_t)
# 2) I_t  = beta_0  + beta_1*P_t  + beta_2*P_{t-1}  + beta_3*K_{t-1}
# 3) W^p_t = gamma_0 + gamma_1*Y_t + gamma_2*Y_{t-1} + gamma_3*Trend
# 4) Y_t  = C_t + I_t + G_t - T_t  (donde Y = GNP neto)
# 5) P_t  = Y_t - W^p_t
# 6) K_t  = K_{t-1} + I_t

cf <- coef(fit_mc2e)
alpha0 <- cf["Consumo_(Intercept)"]
alpha1 <- cf["Consumo_corpProf"]
alpha2 <- cf["Consumo_corpProfLag"]
alpha3 <- cf["Consumo_wages"]

beta0  <- cf["Inversion_(Intercept)"]
beta1  <- cf["Inversion_corpProf"]
beta2  <- cf["Inversion_corpProfLag"]
beta3  <- cf["Inversion_capitalLag"]

gamma0 <- cf["Salarios_(Intercept)"]
gamma1 <- cf["Salarios_gnp"]
gamma2 <- cf["Salarios_gnpLag"]
gamma3 <- cf["Salarios_trend"]

# Matriz Gamma (coeficientes contemporáneos de variables endógenas)
# y_t = Gamma * y_t + B1 * y_{t-1} + B0 * x_t + c + u_t
# Orden: 1:C, 2:I, 3:Wp, 4:Y, 5:P, 6:K
Gamma <- matrix(0, nrow = 6, ncol = 6)
Gamma[1, 5] <- alpha1   # P en C
Gamma[1, 3] <- alpha3   # Wp en C
Gamma[2, 5] <- beta1    # P en I
Gamma[3, 4] <- gamma1   # Y en Wp
Gamma[4, 1] <- 1        # C en Y
Gamma[4, 2] <- 1        # I en Y
Gamma[5, 4] <- 1        # Y en P
Gamma[5, 3] <- -1       # -Wp en P
Gamma[6, 2] <- 1        # I en K

I_minus_Gamma <- diag(6) - Gamma
inv_Gamma <- solve(I_minus_Gamma)

# Matriz B1 (coeficientes sobre variables endógenas rezagadas y_{t-1})
B1 <- matrix(0, nrow = 6, ncol = 6)
B1[1, 5] <- alpha2      # P_{t-1} en C
B1[2, 5] <- beta2      # P_{t-1} en I
B1[2, 6] <- beta3      # K_{t-1} en I
B1[3, 4] <- gamma2      # Y_{t-1} en Wp
B1[6, 6] <- 1           # K_{t-1} en K

# Matriz acompañante dinámica: Pi_1 = (I - Gamma)^{-1} * B1
Pi1 <- inv_Gamma %*% B1

# Raíces características (eigenvalues) y estabilidad del sistema
autovalores <- eigen(Pi1)$values
modulos <- Mod(autovalores)

cat("--- ANALISIS DE ESTABILIDAD Y PROPIEDADES DINAMICAS ---\n")
cat("Autovalores de Pi_1:\n")
for (i in seq_along(autovalores)) {
  cat(sprintf("  lambda_%d: %8.4f %s %8.4fi  (Modulo: %.4f)\n", 
              i, Re(autovalores[i]), 
              ifelse(Im(autovalores[i]) >= 0, "+", "-"), 
              abs(Im(autovalores[i])), modulos[i]))
}

radio_espectral <- max(modulos)
cat(sprintf("\nRadio espectral (max |lambda|): %.4f (< 1 => Sistema estable y convergente)\n", radio_espectral))

# Frecuencia cíclica del par complejo principal
raiz_compleja <- autovalores[which.max(abs(Im(autovalores)))]
periodo_ciclo <- 2 * pi / atan2(abs(Im(raiz_compleja)), Re(raiz_compleja))
cat(sprintf("Periodo fundamental del ciclo endógeno de Klein: %.2f años\n\n", periodo_ciclo))

# ------------------------------------------------------------------------------
# 4. Multiplicadores de Política Fiscal (Impacto, Dinámicos y Largo Plazo)
# ------------------------------------------------------------------------------
# Choque de gasto público: incremento exógeno en G de 1 unidad
# Efecto contemporáneo directo sobre Y (identidad Y = C + I + G - T)
e_G <- c(0, 0, 0, 1, 0, 0) # G entra en fila 4 con coeficiente 1

# Multiplicador de impacto: Pi_0 = (I - Gamma)^{-1} * e_G
mult_impacto <- as.vector(inv_Gamma %*% e_G)
names(mult_impacto) <- c("C", "I", "Wp", "Y", "P", "K")

cat("--- MULTIPLICADORES FISCALES ANTE UN SHOCK DEL GASTO PUBLICO (Delta G = 1) ---\n")
cat("Multiplicador de Impacto (Periodo t):\n")
print(round(mult_impacto, 4))
cat("\n")

# Multiplicadores dinámicos e interinos para un horizonte de 15 periodos
horizonte <- 15
mult_dinamicos <- matrix(0, nrow = horizonte + 1, ncol = 6)
colnames(mult_dinamicos) <- c("C", "I", "Wp", "Y", "P", "K")

Pi1_potencia <- diag(6)
for (s in 0:horizonte) {
  mult_dinamicos[s + 1, ] <- as.vector(Pi1_potencia %*% mult_impacto)
  Pi1_potencia <- Pi1_potencia %*% Pi1
}

# Multiplicadores acumulados (shock permanente de gasto público)
mult_acumulados <- apply(mult_dinamicos, 2, cumsum)

# Multiplicador analítico de largo plazo: (I - Pi_1)^{-1} * mult_impacto
mult_largo_plazo <- as.vector(solve(diag(6) - Pi1) %*% mult_impacto)
names(mult_largo_plazo) <- c("C", "I", "Wp", "Y", "P", "K")

cat("Multiplicador de Largo Plazo (Shock Fiscal Permanente):\n")
print(round(mult_largo_plazo, 4))
cat("\n")

# ------------------------------------------------------------------------------
# 5. Simulación Histórica Dinámica del Modelo Klein I (1921-1941)
# ------------------------------------------------------------------------------
# Resolver simultáneamente año a año con valores predichos de variables endógenas rezagadas
df_simul <- df_klein[!is.na(df_klein$corpProfLag), ]
anios <- df_simul$year
N_anios <- length(anios)

# Matriz para almacenar trayectorias simuladas
sim_dinamica <- matrix(NA, nrow = N_anios, ncol = 6)
colnames(sim_dinamica) <- c("C", "I", "Wp", "Y", "P", "K")

# Vector constante estructural
# C = alpha0 + alpha3*Wg; I = beta0; Wp = gamma0 + gamma3*Trend
# Y = G - T; P = 0; K = 0
for (t in 1:N_anios) {
  # Variables predeterminadas rezagadas
  if (t == 1) {
    p_lag <- df_simul$corpProfLag[t]
    k_lag <- df_simul$capitalLag[t]
    y_lag <- df_simul$gnpLag[t]
  } else {
    p_lag <- sim_dinamica[t - 1, "P"]
    k_lag <- sim_dinamica[t - 1, "K"]
    y_lag <- sim_dinamica[t - 1, "Y"]
  }
  
  # Variables exógenas en t
  g_t  <- df_simul$govExp[t]
  t_t  <- df_simul$taxes[t]
  wg_t <- df_simul$govWage[t]
  tr_t <- df_simul$trend[t]
  
  # Vector de términos autónomos y exógenos c_t
  c_t <- c(
    alpha0 + alpha3 * wg_t,
    beta0,
    gamma0 + gamma3 * tr_t,
    g_t - t_t,
    0,
    0
  )
  
  # Vector de términos rezagados B1 * y_{t-1}
  y_lag_vec <- c(0, 0, 0, y_lag, p_lag, k_lag)
  lag_terms <- B1 %*% y_lag_vec
  
  # Solución simultánea reducida
  sim_dinamica[t, ] <- as.vector(inv_Gamma %*% (c_t + lag_terms))
}

# ------------------------------------------------------------------------------
# 6. Generación y Guardado de Salidas Gráficas y Tablas
# ------------------------------------------------------------------------------

# FIGURA 1: Simulación Dinámica vs Datos Históricos Reales
df_plot_sim <- data.frame(
  Anio = rep(anios, 3),
  Variable = factor(rep(c("Producto (Y / PBI)", "Consumo Privado (C)", "Inversion Neta (I)"), each = N_anios),
                    levels = c("Producto (Y / PBI)", "Consumo Privado (C)", "Inversion Neta (I)")),
  Observado = c(df_simul$gnp, df_simul$consump, df_simul$invest),
  Simulado  = c(sim_dinamica[, "Y"], sim_dinamica[, "C"], sim_dinamica[, "I"])
)

p1 <- ggplot(df_plot_sim, aes(x = Anio)) +
  geom_line(aes(y = Observado, color = "Histórico Observado"), linewidth = 1.1) +
  geom_point(aes(y = Observado, color = "Histórico Observado"), size = 2) +
  geom_line(aes(y = Simulado, color = "Simulado Klein I (MC2E)"), linewidth = 1.1, linetype = "dashed") +
  geom_point(aes(y = Simulado, color = "Simulado Klein I (MC2E)"), size = 2, shape = 17) +
  facet_wrap(~ Variable, scales = "free_y", ncol = 1) +
  scale_color_manual(values = c("Histórico Observado" = "#1b365d", "Simulado Klein I (MC2E)" = "#b22222")) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "top",
    legend.title = element_blank(),
    panel.grid.minor = element_blank(),
    strip.text = element_text(face = "bold", size = 11),
    plot.title = element_text(face = "bold", size = 13, hjust = 0.5),
    plot.subtitle = element_text(color = "gray30", size = 10, hjust = 0.5)
  ) +
  labs(
    title = "Modelo Macroeconométrico Klein I: Simulación Dinámica vs. Datos Históricos (1921-1941)",
    subtitle = "Ajuste simultáneo del Producto, Consumo e Inversión con estimación MC2E",
    x = "Año",
    y = "Miles de millones de USD (1934 constantes)"
  )

ruta_fig1 <- file.path(dir_salidas, "fig_klein_modelo_simulacion.png")
ggsave(ruta_fig1, plot = p1, width = 10, height = 8, dpi = 300)
cat("Figura guardada:", ruta_fig1, "\n")

# FIGURA 2: Multiplicadores Dinámicos de Política Fiscal
df_plot_mult <- data.frame(
  Horizonte = rep(0:horizonte, 5),
  Variable = factor(rep(c("Producto (Y)", "Consumo (C)", "Beneficios (P)", "Salarios Privados (Wp)", "Inversion (I)"), each = horizonte + 1),
                    levels = c("Producto (Y)", "Consumo (C)", "Beneficios (P)", "Salarios Privados (Wp)", "Inversion (I)")),
  Transitorio = c(mult_dinamicos[, "Y"], mult_dinamicos[, "C"], mult_dinamicos[, "P"], mult_dinamicos[, "Wp"], mult_dinamicos[, "I"]),
  Permanente  = c(mult_acumulados[, "Y"], mult_acumulados[, "C"], mult_acumulados[, "P"], mult_acumulados[, "Wp"], mult_acumulados[, "I"])
)

p2a <- ggplot(df_plot_mult, aes(x = Horizonte, y = Transitorio, color = Variable)) +
  geom_hline(yintercept = 0, linetype = "dotted", color = "gray50") +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  scale_color_brewer(palette = "Set1") +
  scale_x_continuous(breaks = seq(0, horizonte, 2)) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "right",
    plot.title = element_text(face = "bold", size = 12),
    panel.grid.minor = element_blank()
  ) +
  labs(
    title = "A. Multiplicadores Dinámicos Interinos (Choque Transitorio: Delta G_t = 1)",
    x = "Años transcurridos desde el shock (s)",
    y = "Respuesta marginal (Delta Y_{t+s} / Delta G_t)"
  )

p2b <- ggplot(df_plot_mult, aes(x = Horizonte, y = Permanente, color = Variable)) +
  geom_hline(yintercept = 0, linetype = "dotted", color = "gray50") +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  scale_color_brewer(palette = "Set1") +
  scale_x_continuous(breaks = seq(0, horizonte, 2)) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "right",
    plot.title = element_text(face = "bold", size = 12),
    panel.grid.minor = element_blank()
  ) +
  labs(
    title = "B. Multiplicadores Acumulados (Expansión Fiscal Permanente: Delta G = 1)",
    x = "Años transcurridos desde la política (s)",
    y = "Impacto acumulado (Convergencia a LP)"
  )

p2_combined <- p2a / p2b + 
  plot_annotation(
    title = "Efectos Dinámicos de la Política Fiscal en el Modelo Klein I (Nobel 1980)",
    subtitle = "Respuesta cíclica amortiguada y convergencia al multiplicador de largo plazo",
    theme = theme(
      plot.title = element_text(face = "bold", size = 13, hjust = 0.5),
      plot.subtitle = element_text(color = "gray30", size = 10, hjust = 0.5)
    )
  )

ruta_fig2 <- file.path(dir_salidas, "fig_klein_multiplicadores_dinamicos.png")
ggsave(ruta_fig2, plot = p2_combined, width = 11, height = 9, dpi = 300)
cat("Figura guardada:", ruta_fig2, "\n")

# TABLA RESUMEN EN CSV
df_salida_tabla <- data.frame(
  Concepto = c(
    paste0("Coef_", tabla_comparativa$Ecuacion_Variable),
    "Multiplicador_Impacto_Y",
    "Multiplicador_Impacto_C",
    "Multiplicador_Impacto_I",
    "Multiplicador_Impacto_P",
    "Multiplicador_Impacto_Wp",
    "Multiplicador_LargoPlazo_Y",
    "Multiplicador_LargoPlazo_C",
    "Multiplicador_LargoPlazo_I",
    "Multiplicador_LargoPlazo_P",
    "Multiplicador_LargoPlazo_Wp",
    "Radio_Espectral_Estabilidad",
    "Periodo_Ciclo_Anios"
  ),
  MCO = c(
    tabla_comparativa$MCO_Coef,
    rep(NA, 12)
  ),
  MC2E = c(
    tabla_comparativa$MC2E_Coef,
    mult_impacto["Y"],
    mult_impacto["C"],
    mult_impacto["I"],
    mult_impacto["P"],
    mult_impacto["Wp"],
    mult_largo_plazo["Y"],
    mult_largo_plazo["C"],
    mult_largo_plazo["I"],
    mult_largo_plazo["P"],
    mult_largo_plazo["Wp"],
    radio_espectral,
    periodo_ciclo
  ),
  Error_Estandar_MC2E = c(
    tabla_comparativa$MC2E_SE,
    rep(NA, 12)
  ),
  Valor_t_MC2E = c(
    tabla_comparativa$MC2E_tVal,
    rep(NA, 12)
  )
)

ruta_tab <- file.path(dir_salidas, "tab_resultados_klein.csv")
write.csv(df_salida_tabla, ruta_tab, row.names = FALSE)
cat("Tabla guardada:", ruta_tab, "\n\n")

cat("=== EJECUCION EXITOSA DEL MODELO KLEIN I ===\n")

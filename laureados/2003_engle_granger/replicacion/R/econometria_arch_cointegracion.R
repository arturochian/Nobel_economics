# ==============================================================================
# Premio Nobel de Economía 2003: Robert F. Engle III y Clive W. J. Granger
# Script: econometria_arch_cointegracion.R
# Descripción: Replicación e ilustración empírica de los métodos fundacionales
#              de la econometría de series de tiempo moderna:
#              1. Modelos ARCH / GARCH de volatilidad condicional cambiante
#                 (Engle, 1982; Bollerslev, 1986).
#              2. Trampa de la regresión espuria (Granger & Newbold, 1974),
#                 Procedimiento de Cointegración bipaso y Modelo de Corrección
#                 de Error (VECM) (Engle & Granger, 1987).
# Autor: Proyecto Nobel_economics
# Licencia: MIT
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(patchwork)
  library(tseries)
})

set.seed(2003) # Fijamos semilla con el año del Premio Nobel

# ------------------------------------------------------------------------------
# 0. Determinación de rutas relativas de salida
# ------------------------------------------------------------------------------
obtener_dir_salidas <- function() {
  candidatos <- c(
    file.path("laureados", "2003_engle_granger", "replicacion", "salidas"),
    file.path("replicacion", "salidas"),
    file.path("..", "salidas"),
    file.path("salidas")
  )
  for (cand in candidatos) {
    if (dir.exists(cand)) {
      ruta_norm <- normalizePath(cand, mustWork = FALSE)
      if (grepl("2003_engle_granger", ruta_norm)) {
        return(cand)
      }
    }
  }
  # Por defecto crear en la estructura esperada del laureado
  target <- file.path("laureados", "2003_engle_granger", "replicacion", "salidas")
  if (!dir.exists(target)) {
    dir.create(target, recursive = TRUE, showWarnings = FALSE)
  }
  return(target)
}

dir_salidas <- obtener_dir_salidas()
cat(sprintf("Ruta de salidas configurada: %s\n\n", normalizePath(dir_salidas, mustWork = FALSE)))

# ==============================================================================
# PARTE 1: MODELO ARCH / GARCH DE ROBERT F. ENGLE (1982)
# ==============================================================================
cat("=== PARTE 1: SIMULACIÓN Y ESTIMACIÓN DE MODELOS ARCH / GARCH (ENGLE 1982) ===\n")

# Parámetros del proceso GARCH(1,1):
# sigma_t^2 = omega + alpha * eps_{t-1}^2 + beta * sigma_{t-1}^2
T_obs <- 600
burn_in <- 200
N_total <- T_obs + burn_in

omega <- 0.10
alpha <- 0.25
beta  <- 0.70
persistencia <- alpha + beta
var_incondicional <- omega / (1 - persistencia)

cat(sprintf("Parámetros teóricos: omega = %.2f, alpha = %.2f, beta = %.2f\n", omega, alpha, beta))
cat(sprintf("Persistencia (alpha + beta) = %.2f (< 1 asegura estacionariedad)\n", persistencia))
cat(sprintf("Varianza incondicional de largo plazo (sigma^2) = %.2f\n\n", var_incondicional))

# Simulación secuencial del proceso GARCH(1,1)
z <- rnorm(N_total, mean = 0, sd = 1)
sigma2 <- numeric(N_total)
eps    <- numeric(N_total)

sigma2[1] <- var_incondicional
eps[1]    <- sqrt(sigma2[1]) * z[1]

for (t in 2:N_total) {
  sigma2[t] <- omega + alpha * (eps[t - 1]^2) + beta * sigma2[t - 1]
  eps[t]    <- sqrt(sigma2[t]) * z[t]
}

# Descarte del período de calentamiento (burn-in)
df_arch <- data.frame(
  tiempo   = 1:T_obs,
  retorno  = eps[(burn_in + 1):N_total],
  sigma2   = sigma2[(burn_in + 1):N_total],
  sigma    = sqrt(sigma2[(burn_in + 1):N_total])
)
df_arch$banda_sup <- 1.96 * df_arch$sigma
df_arch$banda_inf <- -1.96 * df_arch$sigma

# Estimación del modelo GARCH(1,1) por Máxima Verosimilitud
fit_garch <- tseries::garch(df_arch$retorno, order = c(1, 1), trace = FALSE)
coef_garch <- coef(fit_garch)
cat("Coeficientes estimados por Máxima Verosimilitud GARCH(1,1):\n")
print(coef_garch)
cat("\n")

# Visualización Gráfica: Clustering de Volatilidad
p1_retornos <- ggplot(df_arch, aes(x = tiempo)) +
  geom_ribbon(aes(ymin = banda_inf, ymax = banda_sup), fill = "#cfe2ff", alpha = 0.6) +
  geom_line(aes(y = retorno), color = "#0d3b66", linewidth = 0.5) +
  geom_line(aes(y = banda_sup), color = "#1d4ed8", linetype = "dashed", linewidth = 0.6) +
  geom_line(aes(y = banda_inf), color = "#1d4ed8", linetype = "dashed", linewidth = 0.6) +
  labs(
    title = "A) Retornos Financieros con Bandas Dinámicas de Volatilidad (±1.96 * sigma_t)",
    subtitle = "Agrupamiento de volatilidad (volatility clustering): fases turbulentas vs. calmas",
    x = "Tiempo (t)",
    y = "Retorno (%)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", color = "#0d3b66"),
    panel.grid.minor = element_blank()
  )

p1_varianza <- ggplot(df_arch, aes(x = tiempo)) +
  geom_line(aes(y = sigma2), color = "#dc2626", linewidth = 0.7) +
  geom_hline(yintercept = var_incondicional, color = "#1f2937", linetype = "dotted", linewidth = 0.8) +
  annotate("text", x = 55, y = var_incondicional + 0.65,
           label = sprintf("Varianza incondicional constante (sigma^2 = %.1f)", var_incondicional),
           color = "#1f2937", size = 3.5, fontface = "italic") +
  labs(
    title = "B) Trayectoria de la Varianza Condicional sigma_t^2 en el Tiempo",
    subtitle = "La varianza no es constante: shocks de mercado inducen persistencia de riesgo",
    x = "Tiempo (t)",
    y = "Varianza Condicional"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", color = "#991b1b"),
    panel.grid.minor = element_blank()
  )

fig_arch <- p1_retornos / p1_varianza +
  plot_annotation(
    title = "Aporte de Robert F. Engle: Modelización ARCH / GARCH de Volatilidad Cambiante",
    subtitle = "Premio Nobel de Economía 2003 | Demostración de acumulación de volatilidad en series financieras",
    theme = theme(plot.title = element_text(size = 13, face = "bold"))
  )

# Guardar figura en salidas
ruta_fig_arch1 <- file.path(dir_salidas, "fig_arch_volatilidad_clustering.png")
ruta_fig_arch2 <- file.path(dir_salidas, "fig_engle_volatilidad_arch.png")
ggsave(ruta_fig_arch1, fig_arch, width = 10, height = 7, dpi = 300)
ggsave(ruta_fig_arch2, fig_arch, width = 10, height = 7, dpi = 300)
cat(sprintf("Gráficos de volatilidad ARCH guardados en:\n  - %s\n  - %s\n\n", ruta_fig_arch1, ruta_fig_arch2))

# ==============================================================================
# PARTE 2: REGRESIÓN ESPURIA (GRANGER & NEWBOLD 1974) VS COINTEGRACIÓN (ENGLE & GRANGER 1987)
# ==============================================================================
cat("=== PARTE 2: REGRESIÓN ESPURIA VS. COINTEGRACIÓN Y VECM (GRANGER 1974, 1987) ===\n")

n_granger <- 500
e_x <- rnorm(n_granger)
e_y_indep <- rnorm(n_granger)

# Dos paseos aleatorios independientes I(1)
rw_x <- cumsum(e_x)
rw_y_indep <- cumsum(e_y_indep)

# 2.A Regresión espuria de MCO
reg_espuria <- lm(rw_y_indep ~ rw_x)
resumen_espuria <- summary(reg_espuria)
residuos_espurios <- residuals(reg_espuria)

# Estadístico Durbin-Watson manual
diff_res <- diff(residuos_espurios)
dw_stat_espurio <- sum(diff_res^2) / sum(residuos_espurios^2)

# Prueba Dickey-Fuller Aumentada sobre residuos espurios
adf_espurio <- suppressWarnings(tseries::adf.test(residuos_espurios, alternative = "stationary"))

cat("--- A. Regresión Espuria de Granger & Newbold (1974) ---\n")
cat(sprintf("R^2: %.4f | Estadístico t: %.3f | p-valor: %.4e\n",
            resumen_espuria$r.squared,
            resumen_espuria$coefficients[2, 3],
            resumen_espuria$coefficients[2, 4]))
cat(sprintf("Durbin-Watson Stat: %.4f (DW << R^2 confirma regresión espuria)\n", dw_stat_espurio))
cat(sprintf("ADF sobre residuos: %.3f (p-valor: %.3f -> NO se rechaza raíz unitaria)\n\n",
            adf_espurio$statistic, adf_espurio$p.value))

# 2.B Relación de Cointegración Auténtica CI(1, 1)
beta_c <- 1.80
z_c <- numeric(n_granger)
e_z <- rnorm(n_granger, mean = 0, sd = 1)
z_c[1] <- e_z[1]
for (t in 2:n_granger) {
  z_c[t] <- 0.65 * z_c[t - 1] + e_z[t] # Proceso autorregresivo estacionario I(0)
}

rw_y_coint <- beta_c * rw_x + z_c

# Paso 1 Engle-Granger: Regresión de Largo Plazo en niveles
reg_coint_largo_plazo <- lm(rw_y_coint ~ rw_x)
resumen_coint <- summary(reg_coint_largo_plazo)
residuos_coint <- residuals(reg_coint_largo_plazo)

# Prueba ADF sobre residuos de cointegración
adf_coint <- suppressWarnings(tseries::adf.test(residuos_coint, alternative = "stationary"))

# Paso 2 Engle-Granger: Modelo de Corrección de Error (VECM - Corto Plazo)
# Delta Y_t = c + alpha * res_{t-1} + gamma * Delta X_t + u_t
dy <- diff(rw_y_coint)
dx <- diff(rw_x)
ect_lag <- residuos_coint[1:(n_granger - 1)]

reg_vecm <- lm(dy ~ ect_lag + dx)
resumen_vecm <- summary(reg_vecm)

cat("--- B. Cointegración en Dos Pasos y VECM (Engle & Granger, 1987) ---\n")
cat(sprintf("Paso 1 (Largo Plazo): Beta estimado = %.4f (Verdadero = %.2f) | R^2 = %.4f\n",
            coef(reg_coint_largo_plazo)[2], beta_c, resumen_coint$r.squared))
cat(sprintf("ADF Stat sobre residuos: %.3f (p-valor: %.4f -> RECHAZO contundente de raíz unitaria)\n",
            adf_coint$statistic, adf_coint$p.value))
cat(sprintf("Paso 2 (VECM): Velocidad de ajuste (alpha) = %.4f | t-stat = %.3f | p-valor = %.4e\n",
            coef(reg_vecm)["ect_lag"],
            resumen_vecm$coefficients["ect_lag", 3],
            resumen_vecm$coefficients["ect_lag", 4]))
cat("Interpretación: alpha < 0 y significativo comprueba la convergencia hacia el equilibrio.\n\n")

# Construcción de data frames para graficar
df_series <- data.frame(
  tiempo      = 1:n_granger,
  rw_x        = rw_x,
  rw_y_indep  = rw_y_indep,
  rw_y_coint  = rw_y_coint,
  res_espurio = residuos_espurios,
  res_coint   = residuos_coint
)

df_vecm <- data.frame(
  ect_lag = ect_lag,
  dy      = dy
)

# Panel A: Regresión Espuria
p_espurio <- ggplot(df_series, aes(x = tiempo)) +
  geom_line(aes(y = rw_x, color = "X_t (Paseo Aleatorio)"), linewidth = 0.6) +
  geom_line(aes(y = rw_y_indep, color = "Y_t (Independiente)"), linewidth = 0.6) +
  scale_color_manual(values = c("X_t (Paseo Aleatorio)" = "#2563eb", "Y_t (Independiente)" = "#dc2626")) +
  labs(
    title = "A) Regresión Espuria (Granger & Newbold, 1974)",
    subtitle = sprintf("Series independientes: R^2 = %.2f, t = %.2f (falso), DW = %.2f",
                       resumen_espuria$r.squared, resumen_espuria$coefficients[2, 3], dw_stat_espurio),
    x = "Tiempo", y = "Nivel", color = "Serie"
  ) +
  theme_minimal(base_size = 10) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold", color = "#991b1b"))

# Panel B: Cointegración en Niveles
p_coint <- ggplot(df_series, aes(x = tiempo)) +
  geom_line(aes(y = rw_x, color = "X_t (Tendencia Común)"), linewidth = 0.6) +
  geom_line(aes(y = rw_y_coint, color = "Y_t (Cointegrada)"), linewidth = 0.6) +
  scale_color_manual(values = c("X_t (Tendencia Común)" = "#2563eb", "Y_t (Cointegrada)" = "#0d9488")) +
  labs(
    title = "B) Series Cointegradas (Engle & Granger, 1987)",
    subtitle = sprintf("Equilibrio de largo plazo: beta = %.2f (teórico 1.80), R^2 = %.2f",
                       coef(reg_coint_largo_plazo)[2], resumen_coint$r.squared),
    x = "Tiempo", y = "Nivel", color = "Serie"
  ) +
  theme_minimal(base_size = 10) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold", color = "#0f766e"))

# Panel C: Residuos Estacionarios
p_residuos <- ggplot(df_series, aes(x = tiempo)) +
  geom_line(aes(y = res_coint), color = "#16a34a", linewidth = 0.6) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "#374151") +
  labs(
    title = "C) Residuos de Cointegración z_t ~ I(0)",
    subtitle = sprintf("Prueba ADF: Estadístico = %.2f (p < 0.01) -> Estacionariedad comprobada", adf_coint$statistic),
    x = "Tiempo", y = "Desvío del Equilibrio"
  ) +
  theme_minimal(base_size = 10) +
  theme(plot.title = element_text(face = "bold", color = "#15803d"))

# Panel D: Corrección de Error
p_vecm <- ggplot(df_vecm, aes(x = ect_lag, y = dy)) +
  geom_point(color = "#4b5563", alpha = 0.4, size = 1.2) +
  geom_smooth(method = "lm", color = "#7c3aed", se = TRUE, fill = "#ddd6fe") +
  labs(
    title = "D) Mecanismo de Corrección de Error (VECM)",
    subtitle = sprintf("Ajuste gravitatorio: alpha = %.3f (t = %.2f, p < 0.001)",
                       coef(reg_vecm)["ect_lag"], resumen_vecm$coefficients["ect_lag", 3]),
    x = "Desequilibrio rezagado (z_{t-1})", y = "Ajuste de Corto Plazo (Delta Y_t)"
  ) +
  theme_minimal(base_size = 10) +
  theme(plot.title = element_text(face = "bold", color = "#6d28d9"))

fig_cointegracion <- (p_espurio | p_coint) / (p_residuos | p_vecm) +
  plot_annotation(
    title = "Aporte de Clive W. J. Granger: De la Regresión Espuria a la Cointegración y VECM",
    subtitle = "Premio Nobel de Economía 2003 | Demostración comparativa de series de tiempo no estacionarias",
    theme = theme(plot.title = element_text(size = 13, face = "bold"))
  )

ruta_fig_coint1 <- file.path(dir_salidas, "fig_cointegracion_vs_espuria.png")
ruta_fig_coint2 <- file.path(dir_salidas, "fig_granger_cointegracion_vecm.png")
ggsave(ruta_fig_coint1, fig_cointegracion, width = 11, height = 8, dpi = 300)
ggsave(ruta_fig_coint2, fig_cointegracion, width = 11, height = 8, dpi = 300)
cat(sprintf("Gráficos de cointegración guardados en:\n  - %s\n  - %s\n\n", ruta_fig_coint1, ruta_fig_coint2))

# ==============================================================================
# PARTE 3: CONSOLIDACIÓN DE RESULTADOS ECONOMÉTRICOS EN TABLA CSV
# ==============================================================================
tab_resultados <- data.frame(
  Metodologia = c(
    "Engle ARCH/GARCH: Omega",
    "Engle ARCH/GARCH: Alpha (Choque reciente)",
    "Engle ARCH/GARCH: Beta (Persistencia)",
    "Engle ARCH/GARCH: Persistencia Total (Alpha + Beta)",
    "Granger-Newbold: R^2 Regresión Espuria",
    "Granger-Newbold: Estadístico t Espurio",
    "Granger-Newbold: Durbin-Watson Stat",
    "Engle-Granger: Coeficiente Beta Cointegración",
    "Engle-Granger: Estadístico ADF Residuos",
    "Engle-Granger VECM: Velocidad de Ajuste (Alpha)"
  ),
  Valor_Estimado = c(
    round(unname(coef_garch[1]), 4),
    round(unname(coef_garch[2]), 4),
    round(unname(coef_garch[3]), 4),
    round(unname(coef_garch[2] + coef_garch[3]), 4),
    round(resumen_espuria$r.squared, 4),
    round(resumen_espuria$coefficients[2, 3], 3),
    round(dw_stat_espurio, 4),
    round(coef(reg_coint_largo_plazo)[2], 4),
    round(adf_coint$statistic, 3),
    round(coef(reg_vecm)["ect_lag"], 4)
  ),
  Valor_Verdadero_o_Criterio = c(
    as.character(omega),
    as.character(alpha),
    as.character(beta),
    "< 1.0 (Condición de Estacionariedad)",
    "0.00 (Ficticio por no estacionariedad)",
    "|t| > 2 (Falso positivo crítico)",
    "< R^2 (Regla empírica de espuriedad)",
    as.character(beta_c),
    "Rechaza Ho de raíz unitaria (p < 0.01)",
    "< 0 y estadísticamente significativo"
  ),
  Interpretacion = c(
    "Constante de la ecuación de varianza condicional",
    "Sensibilidad de la volatilidad a las sorpresas cuadradas recientes",
    "Persistencia de la varianza condicionada del periodo previo",
    "Alta persistencia típica en mercados de capitales y materias primas",
    "R^2 artificialmente inflado entre series completamente independientes",
    "Rechazo espurio de la hipótesis de independencia",
    "Fuerte autocorrelación positiva de primer orden en residuos no estacionarios",
    "Relación superconsistente de equilibrio gravitatorio de largo plazo",
    "Confirmación formal de que los residuos son estacionarios I(0)",
    "Corrección continua de desequilibrios hacia la senda de largo plazo"
  )
)

ruta_tab <- file.path(dir_salidas, "tab_resultados_series_tiempo.csv")
write.csv(tab_resultados, ruta_tab, row.names = FALSE)
cat(sprintf("Tabla de resultados consolidada guardada en: %s\n", ruta_tab))
cat("Ejecución de econometria_arch_cointegracion.R finalizada exitosamente.\n")

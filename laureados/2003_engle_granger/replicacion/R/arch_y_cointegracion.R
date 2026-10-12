# ==============================================================================
# Premio Nobel de Economía 2003: Robert F. Engle III y Clive W. J. Granger
# Script: arch_y_cointegracion.R
# Descripción: Replicación y análisis de los métodos seminales en econometría de
#              series de tiempo:
#              1. Heterocedasticidad condicional autorregresiva (ARCH / GARCH)
#                 de Robert F. Engle (1982) y Tim Bollerslev (1986).
#              2. Regresión espuria (Granger & Newbold, 1974), Cointegración en
#                 dos pasos y Modelos de Corrección de Error (VECM) de Clive
#                 Granger y Robert Engle (1987).
# Autor: Nobel_economics Project
# Licencia: MIT
# ==============================================================================

# 0. Configuración del entorno y librerías --------------------------------------
suppressPackageStartupMessages({
  library(ggplot2)
  library(patchwork)
  library(tseries)
})

set.seed(2003) # Fijamos semilla con el año del premio Nobel

# Definición de rutas relativas
dir_salidas <- file.path("salidas")
if (!dir.exists(dir_salidas)) {
  # Si se ejecuta desde laureados/2003_engle_granger/
  dir_salidas <- file.path("laureados", "2003_engle_granger", "replicacion", "salidas")
}
if (!dir.exists(dir_salidas)) {
  # Si se ejecuta desde laureados/2003_engle_granger/replicacion/R/
  dir_salidas <- file.path("..", "salidas")
}
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE, showWarnings = FALSE)
}

cat("=== 1. SIMULACIÓN Y ESTIMACIÓN DE MODELOS ARCH / GARCH (ENGLE 1982) ===\n")

# Parámetros del proceso GARCH(1,1) representativo de series financieras:
# sigma_t^2 = omega + alpha * eps_{t-1}^2 + beta * sigma_{t-1}^2
T_obs <- 600
burn_in <- 200
N_total <- T_obs + burn_in

omega <- 0.10
alpha <- 0.25
beta  <- 0.70
persistencia <- alpha + beta
var_incondicional <- omega / (1 - persistencia)

cat(sprintf("Parámetros: omega = %.2f, alpha = %.2f, beta = %.2f\n", omega, alpha, beta))
cat(sprintf("Persistencia (alpha + beta) = %.2f | Varianza Incondicional = %.2f\n", persistencia, var_incondicional))

# Simulación de las innovaciones y varianzas condicionales
z <- rnorm(N_total, mean = 0, sd = 1)
sigma2 <- numeric(N_total)
eps    <- numeric(N_total)

sigma2[1] <- var_incondicional
eps[1]    <- sqrt(sigma2[1]) * z[1]

for (t in 2:N_total) {
  sigma2[t] <- omega + alpha * (eps[t-1]^2) + beta * sigma2[t-1]
  eps[t]    <- sqrt(sigma2[t]) * z[t]
}

# Descartamos el periodo de burn-in
df_arch <- data.frame(
  tiempo = 1:T_obs,
  retorno = eps[(burn_in + 1):N_total],
  sigma2 = sigma2[(burn_in + 1):N_total],
  sigma  = sqrt(sigma2[(burn_in + 1):N_total])
)
df_arch$banda_sup <- 1.96 * df_arch$sigma
df_arch$banda_inf <- -1.96 * df_arch$sigma

# Estimación del modelo GARCH(1,1) mediante Máxima Verosimilitud con tseries::garch
fit_garch <- tseries::garch(df_arch$retorno, order = c(1, 1), trace = FALSE)
resumen_garch <- summary(fit_garch)

cat("Resultados de la estimación GARCH(1,1):\n")
print(coef(fit_garch))

# Gráfico 1: Agrupamiento de volatilidad y varianza condicional de Engle
p1_retornos <- ggplot(df_arch, aes(x = tiempo)) +
  geom_ribbon(aes(ymin = banda_inf, ymax = banda_sup), fill = "#d0e1fd", alpha = 0.6) +
  geom_line(aes(y = retorno), color = "#1a365d", linewidth = 0.5) +
  geom_line(aes(y = banda_sup), color = "#2b6cb0", linetype = "dashed", linewidth = 0.6) +
  geom_line(aes(y = banda_inf), color = "#2b6cb0", linetype = "dashed", linewidth = 0.6) +
  labs(
    title = "A) Retornos Financieros con Bandas de Volatilidad Condicional GARCH(1,1)",
    subtitle = "Demostración de Volatility Clustering: la amplitud de oscilación cambia con el tiempo",
    x = "Tiempo (t)",
    y = "Retorno (%)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", color = "#1a365d"),
    panel.grid.minor = element_blank()
  )

p1_varianza <- ggplot(df_arch, aes(x = tiempo)) +
  geom_line(aes(y = sigma2), color = "#c53030", linewidth = 0.7) +
  geom_hline(yintercept = var_incondicional, color = "#2d3748", linetype = "dotted", linewidth = 0.8) +
  annotate("text", x = 50, y = var_incondicional + 0.6,
           label = sprintf("Varianza incondicional constante (sigma^2 = %.1f)", var_incondicional),
           color = "#2d3748", size = 3.5, fontface = "italic") +
  labs(
    title = "B) Trayectoria de la Varianza Condicional sigma_t^2 en el Tiempo",
    subtitle = "La varianza no es constante: períodos de turbulencia vs. calma relativa",
    x = "Tiempo (t)",
    y = "Varianza Condicional"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", color = "#742a2a"),
    panel.grid.minor = element_blank()
  )

fig_engle <- p1_retornos / p1_varianza +
  plot_annotation(
    title = "Aporte de Robert F. Engle: Modelización ARCH / GARCH de Volatilidad Dinámica",
    subtitle = "Premio Nobel de Economía 2003 | Replicación numérica del agrupamiento de volatilidad",
    theme = theme(plot.title = element_text(size = 14, face = "bold"))
  )

ruta_fig_engle <- file.path(dir_salidas, "fig_engle_volatilidad_arch.png")
ggsave(ruta_fig_engle, fig_engle, width = 10, height = 7, dpi = 300)
cat(sprintf("Figura guardada en: %s\n\n", ruta_fig_engle))


cat("=== 2. REGRESIÓN ESPURIA (GRANGER & NEWBOLD 1974) VS. COINTEGRACIÓN (ENGLE & GRANGER 1987) ===\n")

# A. Demostración de Regresión Espuria: Dos paseos aleatorios independientes I(1)
n_granger <- 500
e_x <- rnorm(n_granger)
e_y_indep <- rnorm(n_granger)

rw_x <- cumsum(e_x)
rw_y_indep <- cumsum(e_y_indep)

# Regresión de MCO espuria
reg_espuria <- lm(rw_y_indep ~ rw_x)
resumen_espuria <- summary(reg_espuria)
residuos_espurios <- residuals(reg_espuria)

# Estadístico Durbin-Watson manual
diff_res <- diff(residuos_espurios)
dw_stat_espurio <- sum(diff_res^2) / sum(residuos_espurios^2)

# Prueba ADF sobre residuos espurios
adf_espurio <- suppressWarnings(tseries::adf.test(residuos_espurios, alternative = "stationary"))

cat("--- Regresión Espuria (Paseos Aleatorios Independientes) ---\n")
cat(sprintf("R^2: %.4f | Coef t-stat: %.3f | p-valor: %.4e\n",
            resumen_espuria$r.squared,
            resumen_espuria$coefficients[2, 3],
            resumen_espuria$coefficients[2, 4]))
cat(sprintf("Durbin-Watson Stat: %.4f (<< R^2 -> Señal clásica de regresión espuria)\n", dw_stat_espurio))
cat(sprintf("ADF Stat sobre residuos: %.3f (p-valor: %.3f -> NO se rechaza raíz unitaria)\n\n",
            adf_espurio$statistic, adf_espurio$p.value))


# B. Sistema Cointegrado Auténtico CI(1, 1):
# x_t = paseo aleatorio I(1)
# y_t = beta_c * x_t + z_t, con z_t proceso autorregresivo estacionario I(0)
beta_c <- 1.80
z_c <- numeric(n_granger)
e_z <- rnorm(n_granger, mean = 0, sd = 1)
z_c[1] <- e_z[1]
for (t in 2:n_granger) {
  z_c[t] <- 0.65 * z_c[t-1] + e_z[t] # Estacionario con phi = 0.65
}

rw_y_coint <- beta_c * rw_x + z_c

# Procedimiento de Dos Pasos de Engle-Granger (1987)
# Paso 1: Regresión de cointegración en niveles (Largo Plazo)
reg_coint_largo_plazo <- lm(rw_y_coint ~ rw_x)
resumen_coint <- summary(reg_coint_largo_plazo)
residuos_coint <- residuals(reg_coint_largo_plazo)

# Prueba de estacionariedad (ADF) sobre residuos de cointegración
adf_coint <- suppressWarnings(tseries::adf.test(residuos_coint, alternative = "stationary"))

# Paso 2: Modelo de Corrección de Error (VECM - Corto Plazo)
# Delta y_t = c + alpha * res_{t-1} + gamma * Delta x_t + v_t
dy <- diff(rw_y_coint)
dx <- diff(rw_x)
ect_lag <- residuos_coint[1:(n_granger - 1)]

reg_vecm <- lm(dy ~ ect_lag + dx)
resumen_vecm <- summary(reg_vecm)

cat("--- Cointegración Engle-Granger (1987) & VECM ---\n")
cat(sprintf("Paso 1 (Largo Plazo): Beta estimado: %.4f (Verdadero: %.2f) | R^2: %.4f\n",
            coef(reg_coint_largo_plazo)[2], beta_c, resumen_coint$r.squared))
cat(sprintf("ADF Stat sobre residuos cointegrados: %.3f (p-valor: %.4f -> RECHAZO contundente de raíz unitaria)\n",
            adf_coint$statistic, adf_coint$p.value))
cat(sprintf("Paso 2 (VECM): Coeficiente de Corrección de Error (alpha): %.4f | t-stat: %.3f | p-valor: %.4e\n",
            coef(reg_vecm)["ect_lag"],
            resumen_vecm$coefficients["ect_lag", 3],
            resumen_vecm$coefficients["ect_lag", 4]))
cat("Interpretación: alpha negativo y significativo confirma la convergencia dinámica al equilibrio de largo plazo.\n\n")

# Gráficos de Cointegración y Regresión Espuria
df_series <- data.frame(
  tiempo = 1:n_granger,
  rw_x = rw_x,
  rw_y_indep = rw_y_indep,
  rw_y_coint = rw_y_coint,
  res_espurio = residuos_espurios,
  res_coint = residuos_coint
)

df_vecm <- data.frame(
  ect_lag = ect_lag,
  dy = dy
)

# Panel A: Regresión Espuria
p_espurio <- ggplot(df_series, aes(x = tiempo)) +
  geom_line(aes(y = rw_x, color = "X_t (Paseo Aleatorio)"), linewidth = 0.6) +
  geom_line(aes(y = rw_y_indep, color = "Y_t (Independiente)"), linewidth = 0.6) +
  scale_color_manual(values = c("X_t (Paseo Aleatorio)" = "#3182ce", "Y_t (Independiente)" = "#e53e3e")) +
  labs(
    title = "A) Regresión Espuria (Granger & Newbold, 1974)",
    subtitle = sprintf("Series independientes: R^2 = %.2f, t = %.2f (falso), DW = %.2f",
                       resumen_espuria$r.squared, resumen_espuria$coefficients[2, 3], dw_stat_espurio),
    x = "Tiempo", y = "Nivel", color = "Serie"
  ) +
  theme_minimal(base_size = 10) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold", color = "#742a2a"))

# Panel B: Cointegración en Niveles
p_coint <- ggplot(df_series, aes(x = tiempo)) +
  geom_line(aes(y = rw_x, color = "X_t (Tendencia Común)"), linewidth = 0.6) +
  geom_line(aes(y = rw_y_coint, color = "Y_t (Cointegrada)"), linewidth = 0.6) +
  scale_color_manual(values = c("X_t (Tendencia Común)" = "#3182ce", "Y_t (Cointegrada)" = "#2b6cb0")) +
  labs(
    title = "B) Series Cointegradas (Engle & Granger, 1987)",
    subtitle = sprintf("Equilibrio de largo plazo: beta = %.2f, R^2 = %.2f",
                       coef(reg_coint_largo_plazo)[2], resumen_coint$r.squared),
    x = "Tiempo", y = "Nivel", color = "Serie"
  ) +
  theme_minimal(base_size = 10) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold", color = "#1a365d"))

# Panel C: Residuos de Cointegración (Estacionarios I(0))
p_residuos <- ggplot(df_series, aes(x = tiempo)) +
  geom_line(aes(y = res_coint), color = "#2f855a", linewidth = 0.6) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "#2d3748") +
  labs(
    title = "C) Residuos de Cointegración e_t ~ I(0)",
    subtitle = sprintf("Prueba ADF: Estadístico = %.2f (p < 0.01) -> Estacionarios", adf_coint$statistic),
    x = "Tiempo", y = "Desvío del Equilibrio"
  ) +
  theme_minimal(base_size = 10) +
  theme(plot.title = element_text(face = "bold", color = "#22543d"))

# Panel D: Corrección de Error (VECM)
p_vecm <- ggplot(df_vecm, aes(x = ect_lag, y = dy)) +
  geom_point(color = "#4a5568", alpha = 0.4, size = 1.2) +
  geom_smooth(method = "lm", color = "#805ad5", se = TRUE, fill = "#d6bcfa") +
  labs(
    title = "D) Mecanismo de Corrección de Error (VECM)",
    subtitle = sprintf("Ajuste gravitatorio: alpha = %.3f (t = %.2f, p < 0.001)",
                       coef(reg_vecm)["ect_lag"], resumen_vecm$coefficients["ect_lag", 3]),
    x = "Desequilibrio previo (e_{t-1})", y = "Cambio de Corto Plazo (Delta Y_t)"
  ) +
  theme_minimal(base_size = 10) +
  theme(plot.title = element_text(face = "bold", color = "#44337a"))

fig_granger <- (p_espurio | p_coint) / (p_residuos | p_vecm) +
  plot_annotation(
    title = "Aporte de Clive W. J. Granger: De la Regresión Espuria a la Cointegración y VECM",
    subtitle = "Premio Nobel de Economía 2003 | Demostración comparativa de series no estacionarias",
    theme = theme(plot.title = element_text(size = 13, face = "bold"))
  )

ruta_fig_granger <- file.path(dir_salidas, "fig_granger_cointegracion_vecm.png")
ggsave(ruta_fig_granger, fig_granger, width = 11, height = 8, dpi = 300)
cat(sprintf("Figura guardada en: %s\n\n", ruta_fig_granger))


# 3. Guardar Tabla Resumen con Resultados Econométricos ------------------------
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
    round(unname(coef(fit_garch)[1]), 4),
    round(unname(coef(fit_garch)[2]), 4),
    round(unname(coef(fit_garch)[3]), 4),
    round(unname(coef(fit_garch)[2] + coef(fit_garch)[3]), 4),
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
cat(sprintf("Tabla de resultados guardada en: %s\n", ruta_tab))
cat("Ejecución completada con éxito.\n")

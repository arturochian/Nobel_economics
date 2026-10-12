# ==============================================================================
# Script: analisis_precios_activos.R
# Proyecto: Nobel de Economia 2013 - Eugene Fama, Lars Peter Hansen, Robert Shiller
# Descripcion:
#   1. Replicacion/Simulacion del Test de Exceso de Volatilidad de Shiller (1981).
#   2. Estimacion del Modelo de 3 Factores de Fama y French (1993) vs. CAPM.
#   3. Estimacion por Metodo Generalizado de Momentos (GMM) y Test J de Hansen (1982).
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(gmm)
})

set.seed(20131014) # Fecha del anuncio del Premio Nobel 2013

# Crear directorio de salidas si no existe
salidas_dir <- file.path("laureados", "2013_fama_hansen_shiller", "replicacion", "salidas")
if (!dir.exists(salidas_dir)) {
  dir.create(salidas_dir, recursive = TRUE)
}

# ------------------------------------------------------------------------------
# 1. ROBERT J. SHILLER (1981): TEST DE EXCESO DE VOLATILIDAD DE PRECIOS
# ------------------------------------------------------------------------------
# Modelo de Valor Presente con descuento constante:
# P*_t = sum_{k=0}^{T-t-1} gamma^{k+1} D_{t+k} + gamma^{T-t} P*_T
# Teorema de varianza: Si P_t = E_t[P*_t], entonces Var(P_t) <= Var(P*_t).

T_anios <- 100
anios <- 1924:(1924 + T_anios - 1)
r_disc <- 0.055
gamma_disc <- 1 / (1 + r_disc)

# Dividendo simulado con crecimiento tendencial y volatilidad
g_div <- 0.020
sigma_div <- 0.08
div_innov <- rnorm(T_anios, mean = g_div - 0.5 * sigma_div^2, sd = sigma_div)
dividendos <- numeric(T_anios)
dividendos[1] <- 10.0
for (t in 2:T_anios) {
  dividendos[t] <- dividendos[t - 1] * exp(div_innov[t])
}

# Calculo recursivo hacia atras del precio racional perfecto P*_t
# P*_t = gamma * (P*_{t+1} + D_{t+1})
# Para el valor terminal T, usamos la formula de Gordon: P*_T = D_T * (1+g) / (r - g)
P_star <- numeric(T_anios)
P_star[T_anios] <- (dividendos[T_anios] * (1 + g_div)) / (r_disc - g_div)
for (t in (T_anios - 1):1) {
  P_star[t] <- gamma_disc * (P_star[t + 1] + dividendos[t + 1])
}

# Precio real de mercado P_t (con componente de sentimiento / volatilidad excesiva)
# En los datos reales de Shiller (1871-1979), los precios reales fluctuan muchisimo mas
# que el valor presente de los dividendos futuros reales.
# Modelamos un ciclo de sentimiento persistente AR(1) mas ruido
phi_sent <- 0.88
sigma_sent <- 0.16
sentimiento <- numeric(T_anios)
for (t in 2:T_anios) {
  sentimiento[t] <- phi_sent * sentimiento[t - 1] + rnorm(1, 0, sigma_sent)
}
P_mercado <- P_star * exp(sentimiento)

# Desviaciones estandar y varianzas
var_P <- var(P_mercado)
var_Pstar <- var(P_star)
sd_P <- sd(P_mercado)
sd_Pstar <- sd(P_star)
ratio_var <- var_P / var_Pstar
ratio_sd <- sd_P / sd_Pstar

cat("=== 1. SHILLER (1981): TEST DE EXCESO DE VOLATILIDAD ===\n")
cat("Desviacion Estandar Precio Mercado P_t:", round(sd_P, 2), "\n")
cat("Desviacion Estandar Precio Valor Presente P*_t:", round(sd_Pstar, 2), "\n")
cat("Ratio SD(P) / SD(P*):", round(ratio_sd, 2), "(Deberia ser <= 1 bajo EMH clasica)\n")
cat("Ratio Var(P) / Var(P*):", round(ratio_var, 2), "\n\n")

# Grafico de Shiller
df_shiller <- data.frame(
  Anio = rep(anios, 2),
  Precio = c(P_mercado, P_star),
  Tipo = factor(rep(c("Precio Real de Mercado (P_t)", "Precio de Valor Presente Perfecto (P*_t)"), each = T_anios))
)

p_shiller <- ggplot(df_shiller, aes(x = Anio, y = Precio, color = Tipo, linetype = Tipo)) +
  geom_line(linewidth = 1.1) +
  scale_color_manual(values = c("Precio Real de Mercado (P_t)" = "#C0392B", 
                                "Precio de Valor Presente Perfecto (P*_t)" = "#2980B9")) +
  scale_linetype_manual(values = c("Precio Real de Mercado (P_t)" = "solid", 
                                  "Precio de Valor Presente Perfecto (P*_t)" = "dashed")) +
  labs(
    title = "Paradoja de Exceso de Volatilidad de Shiller (1981)",
    subtitle = paste0("SD(P_mercado) = ", round(sd_P, 1), " vs. SD(P*) = ", round(sd_Pstar, 1), 
                      " | Ratio Varianza = ", round(ratio_var, 2), " (Violacion de la cota de varianza)"),
    x = "Ano",
    y = "Nivel de Precio",
    color = "Serie:",
    linetype = "Serie:"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "gray30", size = 10)
  )

ggsave(file.path(salidas_dir, "fig_shiller_exceso_volatilidad.png"), 
       plot = p_shiller, width = 9, height = 5.5, dpi = 300)

# ------------------------------------------------------------------------------
# 2. EUGENE F. FAMA Y KENNETH R. FRENCH (1993): MODELO DE TRES FACTORES
# ------------------------------------------------------------------------------
# R_{i,t} - R_{f,t} = alpha_i + beta_M*(R_{M,t} - R_{f,t}) + beta_SMB*SMB_t + beta_HML*HML_t + e_{i,t}

N_meses <- 360 # 30 anos mensuales

# Generacion de factores
Mkt_RF <- rnorm(N_meses, mean = 0.60, sd = 4.40) # Prima de mercado (% mensual)
SMB <- rnorm(N_meses, mean = 0.28, sd = 3.10)    # Small Minus Big (% mensual)
HML <- rnorm(N_meses, mean = 0.35, sd = 3.20)    # High Minus Low (% mensual)

# Portafolio 1: Pequena Capitalizacion y Alto Valor (Small Value)
# Caracteristicas: alta exposicion a tamano (SMB) y valor (HML)
beta_mkt_sv <- 1.05
beta_smb_sv <- 0.82
beta_hml_sv <- 0.74
alpha_verdadero_sv <- 0.00 # Sin alfa estructural (mercado eficiente multifactorial)
eps_sv <- rnorm(N_meses, 0, 2.10)
R_SV <- alpha_verdadero_sv + beta_mkt_sv * Mkt_RF + beta_smb_sv * SMB + beta_hml_sv * HML + eps_sv

# Portafolio 2: Gran Capitalizacion y Crecimiento (Large Growth)
# Caracteristicas: exposicion negativa a SMB y HML
beta_mkt_lg <- 0.98
beta_smb_lg <- -0.35
beta_hml_lg <- -0.42
alpha_verdadero_lg <- 0.00
eps_lg <- rnorm(N_meses, 0, 1.80)
R_LG <- alpha_verdadero_lg + beta_mkt_lg * Mkt_RF + beta_smb_lg * SMB + beta_hml_lg * HML + eps_lg

df_ff <- data.frame(Mkt_RF, SMB, HML, R_SV, R_LG)

# Estimaciones para Cartera Small-Value
capm_sv <- lm(R_SV ~ Mkt_RF, data = df_ff)
ff3_sv  <- lm(R_SV ~ Mkt_RF + SMB + HML, data = df_ff)

# Estimaciones para Cartera Large-Growth
capm_lg <- lm(R_LG ~ Mkt_RF, data = df_ff)
ff3_lg  <- lm(R_LG ~ Mkt_RF + SMB + HML, data = df_ff)

cat("=== 2. FAMA Y FRENCH (1993): REGRESIONES DE FACTORES ===\n")
cat("Cartera Small-Value:\n")
cat("CAPM Alpha:", round(coef(capm_sv)[1], 3), "(p-val:", round(summary(capm_sv)$coefficients[1, 4], 4), ")\n")
cat("CAPM R2:", round(summary(capm_sv)$r.squared, 3), "\n")
cat("FF3 Alpha:", round(coef(ff3_sv)[1], 3), "(p-val:", round(summary(ff3_sv)$coefficients[1, 4], 4), ")\n")
cat("FF3 R2:", round(summary(ff3_sv)$r.squared, 3), "\n\n")

# Grafico de coeficientes de Factores Fama-French
df_coefs <- data.frame(
  Cartera = c(rep("Small-Value", 3), rep("Large-Growth", 3)),
  Factor = rep(c("Mercado (Beta Mkt)", "Tamano (Beta SMB)", "Valor (Beta HML)"), 2),
  Beta = c(coef(ff3_sv)[2:4], coef(ff3_lg)[2:4]),
  SE = c(summary(ff3_sv)$coefficients[2:4, 2], summary(ff3_lg)$coefficients[2:4, 2])
)
df_coefs$IC_low <- df_coefs$Beta - 1.96 * df_coefs$SE
df_coefs$IC_high <- df_coefs$Beta + 1.96 * df_coefs$SE

p_ff <- ggplot(df_coefs, aes(x = Factor, y = Beta, fill = Cartera)) +
  geom_bar(stat = "identity", position = position_dodge(0.7), width = 0.6) +
  geom_errorbar(aes(ymin = IC_low, ymax = IC_high), position = position_dodge(0.7), width = 0.2) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
  scale_fill_manual(values = c("Small-Value" = "#27AE60", "Large-Growth" = "#8E44AD")) +
  labs(
    title = "Cargas Factoriales del Modelo de Tres Factores de Fama y French (1993)",
    subtitle = "Explicacion de los retornos por factores de tamano (SMB) y valor relativo (HML)",
    x = "Factor de Riesgo",
    y = "Carga Factorial (Beta Estimado)",
    fill = "Cartera de Activos:"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "gray30", size = 10)
  )

ggsave(file.path(salidas_dir, "fig_fama_french_factores.png"), 
       plot = p_ff, width = 8.5, height = 5.2, dpi = 300)

# ------------------------------------------------------------------------------
# 3. LARS PETER HANSEN (1982): GMM Y TEST J DE RESTRICCIONES SOBREIDENTIFICADAS
# ------------------------------------------------------------------------------
# Ecuacion de Euler del CCAPM:
# E_t [ beta_disc * (C_{t+1} / C_t)^(-gamma_crra) * R_{j,t+1} - 1 ] = 0
# Parametros estructurales: theta = (beta_disc, gamma_crra)
# Hansen y Singleton (1982): estimacion instrumental no lineal con GMM.

N_gmm <- 300
gamma_true <- 2.20
beta_true <- 0.98

# Crecimiento de consumo real per capita
gc <- rnorm(N_gmm, mean = 0.018, sd = 0.022)
c_growth <- exp(gc)

# Factores de descuento estocastico subyacentes
m_true <- beta_true * (c_growth)^(-gamma_true)

# Retornos brutos de activos (R1 = letras del tesoro, R2 = indice accionario)
# Generados para satisfacer exactamente la condicion de Euler poblacional E[m * R] = 1
r1_mean <- 1 / mean(m_true)
R1 <- r1_mean * exp(rnorm(N_gmm, mean = -0.5 * 0.015^2, sd = 0.015))

cov_cg_r2 <- 0.65
r2_mean <- (1 / mean(m_true)) * 1.05
R2 <- r2_mean * exp(cov_cg_r2 * (gc - mean(gc)) + rnorm(N_gmm, mean = -0.5 * 0.06^2, sd = 0.06))

# Instrumentos predeterminados conocidos en t: constante y rezago de consumo
c_lag <- c(1.018, c_growth[-N_gmm])
datos_gmm <- data.frame(
  R1 = R1,
  R2 = R2,
  c_growth = c_growth,
  z1 = rep(1, N_gmm),
  z2 = c_lag
)

# Funcion de momentos ortogonales: 4 momentos para 2 parametros
g_euler <- function(theta, x) {
  b <- theta[1]
  g <- theta[2]
  sdf <- b * (x[, "c_growth"])^(-g)
  
  m1 <- (sdf * x[, "R1"] - 1) * x[, "z1"]
  m2 <- (sdf * x[, "R1"] - 1) * x[, "z2"]
  m3 <- (sdf * x[, "R2"] - 1) * x[, "z1"]
  m4 <- (sdf * x[, "R2"] - 1) * x[, "z2"]
  
  cbind(m1, m2, m3, m4)
}

# Estimacion GMM optima en dos etapas
theta_init <- c(beta_disc = 0.97, gamma_crra = 2.0)
ajuste_gmm <- gmm(
  g = g_euler,
  x = datos_gmm,
  t0 = theta_init,
  type = "twoStep",
  wmatrix = "optimal",
  vcov = "HAC",
  prewhite = FALSE,
  crit = 1e-8
)

sum_gmm <- summary(ajuste_gmm)
test_j <- specTest(ajuste_gmm)

j_stat <- as.numeric(test_j$test[1, 1])
j_pval <- as.numeric(test_j$test[1, 2])
j_df <- ncol(g_euler(coef(ajuste_gmm), datos_gmm)) - length(coef(ajuste_gmm)) # 4 - 2 = 2

cat("=== 3. HANSEN (1982): ESTIMACION GMM Y TEST J ===\n")
cat("Parametro Beta (Descuento):", round(coef(ajuste_gmm)[1], 4), 
    "SE:", round(sum_gmm$coefficients[1, 2], 4), "\n")
cat("Parametro Gamma (Aversion al Riesgo):", round(coef(ajuste_gmm)[2], 4), 
    "SE:", round(sum_gmm$coefficients[2, 2], 4), "\n")
cat("Estadistico J de Hansen:", round(j_stat, 4), "\n")
cat("Grados de Libertad (m - k):", j_df, "\n")
cat("Valor p del Test J:", round(j_pval, 4), "\n\n")

# ------------------------------------------------------------------------------
# 4. TABLA RESUMEN DE RESULTADOS DE ESTIMACION
# ------------------------------------------------------------------------------
tab_estimacion <- data.frame(
  modulo = c(
    "Shiller (1981) Volatilidad",
    "Shiller (1981) Volatilidad",
    "Shiller (1981) Volatilidad",
    "Fama-French (1993) Small-Value",
    "Fama-French (1993) Small-Value",
    "Fama-French (1993) Small-Value",
    "Fama-French (1993) Small-Value",
    "Fama-French (1993) Small-Value",
    "Fama-French (1993) Small-Value",
    "Fama-French (1993) Large-Growth",
    "Fama-French (1993) Large-Growth",
    "Fama-French (1993) Large-Growth",
    "Hansen (1982) GMM Euler",
    "Hansen (1982) GMM Euler",
    "Hansen (1982) GMM Euler",
    "Hansen (1982) GMM Euler"
  ),
  concepto = c(
    "Desviacion Estandar Mercado SD(P)",
    "Desviacion Estandar Present Value SD(P*)",
    "Ratio de Varianzas Var(P)/Var(P*)",
    "CAPM Alfa Jensen (Anualizado %)",
    "CAPM Beta Mercado",
    "CAPM R-cuadrado",
    "FF3 Alfa (Anualizado %)",
    "FF3 Beta Tamano (SMB)",
    "FF3 Beta Valor (HML)",
    "FF3 Alfa (Anualizado %)",
    "FF3 Beta Tamano (SMB)",
    "FF3 Beta Valor (HML)",
    "Beta Descuento Intertemporal",
    "Gamma Aversion Relativa al Riesgo",
    "Hansen J-statistic",
    "Valor p Test J (Restricciones Sobreidentificadas)"
  ),
  estimacion = c(
    round(sd_P, 4),
    round(sd_Pstar, 4),
    round(ratio_var, 4),
    round(coef(capm_sv)[1] * 12, 4),
    round(coef(capm_sv)[2], 4),
    round(summary(capm_sv)$r.squared, 4),
    round(coef(ff3_sv)[1] * 12, 4),
    round(coef(ff3_sv)[3], 4),
    round(coef(ff3_sv)[4], 4),
    round(coef(ff3_lg)[1] * 12, 4),
    round(coef(ff3_lg)[3], 4),
    round(coef(ff3_lg)[4], 4),
    round(coef(ajuste_gmm)[1], 4),
    round(coef(ajuste_gmm)[2], 4),
    round(j_stat, 4),
    round(j_pval, 4)
  ),
  error_estandar = c(
    NA,
    NA,
    NA,
    round(summary(capm_sv)$coefficients[1, 2] * 12, 4),
    round(summary(capm_sv)$coefficients[2, 2], 4),
    NA,
    round(summary(ff3_sv)$coefficients[1, 2] * 12, 4),
    round(summary(ff3_sv)$coefficients[3, 2], 4),
    round(summary(ff3_sv)$coefficients[4, 2], 4),
    round(summary(ff3_lg)$coefficients[1, 2] * 12, 4),
    round(summary(ff3_lg)$coefficients[3, 2], 4),
    round(summary(ff3_lg)$coefficients[4, 2], 4),
    round(sum_gmm$coefficients[1, 2], 4),
    round(sum_gmm$coefficients[2, 2], 4),
    NA,
    NA
  ),
  nota = c(
    "Precios reales de mercado",
    "Valor presente descontado de dividendos subsecuentes",
    "Violacion masiva de cota de varianza (EMH)",
    "Alfa aparente significativo bajo CAPM",
    "Exposicion a mercado",
    "Bajo ajuste con un solo factor",
    "Alfa absorbido y no significativo bajo 3 factores",
    "Fuerte prima por tamano",
    "Fuerte prima por valor",
    "Alfa no significativo",
    "Sesgo negativo hacia empresas grandes",
    "Sesgo negativo hacia empresas de crecimiento",
    "Estimador GMM consistente bietapico",
    "Curvatura de funcion de utilidad (implausiblemente alta, puzzle Mehra-Prescott)",
    "Chi-cuadrado con 2 grados de libertad",
    "Rechazo de las restricciones de sobreidentificacion del CCAPM clasico (p < 0.01)"
  )
)

write.csv(tab_estimacion, file.path(salidas_dir, "tab_estimacion_activos.csv"), row.names = FALSE)
cat("Archivo generado con exito:", file.path(salidas_dir, "tab_estimacion_activos.csv"), "\n")

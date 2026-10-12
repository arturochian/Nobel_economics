# ==============================================================================
# Script de Replicación Econométrica: Acemoglu, Johnson & Robinson (2001, AER)
# "The Colonial Origins of Comparative Development: An Empirical Investigation"
# ==============================================================================
# Premio Nobel de Economía 2024: Daron Acemoglu, Simon Johnson, James A. Robinson
# Muestra base: 64 ex-colonias con datos de mortalidad de colonos europeos
# ==============================================================================

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(ggplot2)
  library(AER)
})

# 1. Localización y Carga de Datos ---------------------------------------------
ruta_datos_rel <- "replicacion/datos/ajr_2001.csv"
ruta_datos_alt <- "../datos/ajr_2001.csv"
ruta_datos_direct <- "datos/ajr_2001.csv"

if (file.exists(ruta_datos_rel)) {
  df <- read_csv(ruta_datos_rel, show_col_types = FALSE)
} else if (file.exists(ruta_datos_alt)) {
  df <- read_csv(ruta_datos_alt, show_col_types = FALSE)
} else if (file.exists(ruta_datos_direct)) {
  df <- read_csv(ruta_datos_direct, show_col_types = FALSE)
} else {
  # Fallback en línea si se ejecuta en entorno aislado
  df <- haven::read_dta("https://statalasso.github.io/dta/AJR.dta")
}

# Filtrar muestra base con las tres variables clave completas (N = 64)
df_base <- df %>%
  filter(!is.na(logpgp95), !is.na(avexpr), !is.na(logem4))

cat("Muestra analizada:", nrow(df_base), "países observados.\n\n")

# 2. Estimaciones Econométricas ------------------------------------------------

# (A) MCO / OLS (Mínimos Cuadrados Ordinarios)
# Ecuación estructural: logpgp95 = alpha + beta * avexpr + u
mod_ols <- lm(logpgp95 ~ avexpr, data = df_base)

# (B) Primera Etapa (First Stage)
# avexpr = gamma_0 + gamma_1 * logem4 + v
mod_fs <- lm(avexpr ~ logem4, data = df_base)

# (C) MCO en Dos Etapas / Variables Instrumentales (2SLS / IV)
# Instrumento: logem4 (Log mortalidad de colonos europeos)
mod_iv <- AER::ivreg(logpgp95 ~ avexpr | logem4, data = df_base)

# (D) Modelo con control por Latitud (Robustez geográfica, Tabla 4 col 2)
mod_ols_lat <- lm(logpgp95 ~ avexpr + lat_abst, data = df_base)
mod_iv_lat  <- AER::ivreg(logpgp95 ~ avexpr + lat_abst | logem4 + lat_abst, data = df_base)

# 3. Resumen y Formateo de Resultados en Tabla CSV ------------------------------
res_ols <- summary(mod_ols)
res_fs  <- summary(mod_fs)
res_iv  <- summary(mod_iv)
res_iv_lat <- summary(mod_iv_lat)

f_stat_fs <- res_fs$fstatistic[1]

tabla_resultados <- tibble(
  Modelo = c(
    "MCO (OLS) Básico",
    "Primera Etapa (First Stage)",
    "2SLS / IV (Sin controles)",
    "MCO con Latitud",
    "2SLS / IV con Latitud"
  ),
  Variable_Dependiente = c("logpgp95", "avexpr", "logpgp95", "logpgp95", "logpgp95"),
  Variable_Explicativa = c("avexpr", "logem4", "avexpr (IV)", "avexpr", "avexpr (IV)"),
  Coeficiente = c(
    coef(mod_ols)["avexpr"],
    coef(mod_fs)["logem4"],
    coef(mod_iv)["avexpr"],
    coef(mod_ols_lat)["avexpr"],
    coef(mod_iv_lat)["avexpr"]
  ),
  Error_Estandar = c(
    res_ols$coefficients["avexpr", "Std. Error"],
    res_fs$coefficients["logem4", "Std. Error"],
    res_iv$coefficients["avexpr", "Std. Error"],
    summary(mod_ols_lat)$coefficients["avexpr", "Std. Error"],
    res_iv_lat$coefficients["avexpr", "Std. Error"]
  ),
  Estadistico_t = c(
    res_ols$coefficients["avexpr", "t value"],
    res_fs$coefficients["logem4", "t value"],
    res_iv$coefficients["avexpr", "t value"],
    summary(mod_ols_lat)$coefficients["avexpr", "t value"],
    res_iv_lat$coefficients["avexpr", "t value"]
  ),
  P_Valor = c(
    res_ols$coefficients["avexpr", "Pr(>|t|)"],
    res_fs$coefficients["logem4", "Pr(>|t|)"],
    res_iv$coefficients["avexpr", "Pr(>|t|)"],
    summary(mod_ols_lat)$coefficients["avexpr", "Pr(>|t|)"],
    res_iv_lat$coefficients["avexpr", "Pr(>|t|)"]
  ),
  R2 = c(
    res_ols$r.squared,
    res_fs$r.squared,
    res_iv$r.squared,
    summary(mod_ols_lat)$r.squared,
    res_iv_lat$r.squared
  ),
  F_Primera_Etapa = c(NA, f_stat_fs, f_stat_fs, NA, summary(lm(avexpr ~ logem4 + lat_abst, data = df_base))$fstatistic[1]),
  N_Observaciones = rep(nrow(df_base), 5)
)

# Determinar directorio de salidas
dir_salidas <- if (dir.exists("replicacion/salidas")) {
  "replicacion/salidas"
} else if (dir.exists("../salidas")) {
  "../salidas"
} else if (dir.exists("salidas")) {
  "salidas"
} else {
  "laureados/2024_acemoglu_johnson_robinson/replicacion/salidas"
}

dir.create(dir_salidas, showWarnings = FALSE, recursive = TRUE)

archivo_csv <- file.path(dir_salidas, "tab_regresiones_iv.csv")
write_csv(tabla_resultados, archivo_csv)
cat("Tabla exportada exitosamente a:", archivo_csv, "\n")

# 4. Gráficos de Diagnóstico y Relaciones Empíricas -----------------------------

# Paleta y estilo sobrio académico
color_primario <- "#1A365D"   # Azul Oxford
color_secundario <- "#C53030" # Rojo terracota
color_puntos <- "#2B6CB0"
tema_academico <- theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 13, color = "#2D3748"),
    plot.subtitle = element_text(size = 10, color = "#4A5568", margin = margin(b = 10)),
    plot.caption = element_text(size = 8, color = "#718096", hjust = 0),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#E2E8F0", linewidth = 0.5),
    axis.title = element_text(face = "bold", size = 10, color = "#2D3748"),
    plot.background = element_rect(fill = "white", color = NA)
  )

# Gráfico 1: Primera Etapa (Log Mortalidad vs Protección contra Expropiación)
p_fs <- ggplot(df_base, aes(x = logem4, y = avexpr)) +
  geom_point(color = color_puntos, alpha = 0.75, size = 2.5) +
  geom_text(aes(label = shortnam), vjust = -0.7, size = 2.8, color = "#4A5568", check_overlap = TRUE) +
  geom_smooth(method = "lm", se = TRUE, color = color_secundario, fill = "#FED7D7", linewidth = 1) +
  labs(
    title = "Primera Etapa: Mortalidad de Colonos e Instituciones Iniciales",
    subtitle = paste0("Efecto estimado = ", round(coef(mod_fs)["logem4"], 3), 
                      " (e.e. = ", round(res_fs$coefficients["logem4", "Std. Error"], 3), 
                      ", Estadístico F = ", round(f_stat_fs, 2), ")"),
    x = "Logaritmo de la Mortalidad de Colonos Europeos (logem4)",
    y = "Protección Promedio contra Riesgo de Expropiación 1985-95 (avexpr)",
    caption = "Fuente: Acemoglu, Johnson & Robinson (2001, AER). N = 64 ex-colonias."
  ) +
  tema_academico

archivo_fig_fs <- file.path(dir_salidas, "fig_ajr_primera_etapa.png")
ggsave(archivo_fig_fs, plot = p_fs, width = 8, height = 5.5, dpi = 300)
cat("Figura de primera etapa guardada en:", archivo_fig_fs, "\n")

# Gráfico 2: Relación Instituciones vs PIB per cápita (Comparativa MCO vs 2SLS)
beta_ols <- coef(mod_ols)["avexpr"]
beta_iv  <- coef(mod_iv)["avexpr"]
alpha_iv <- coef(mod_iv)["(Intercept)"]

p_ols_iv <- ggplot(df_base, aes(x = avexpr, y = logpgp95)) +
  geom_point(color = color_puntos, alpha = 0.75, size = 2.5) +
  geom_text(aes(label = shortnam), vjust = -0.7, size = 2.8, color = "#4A5568", check_overlap = TRUE) +
  geom_smooth(aes(color = "MCO / OLS (Pendiente = 0.522)"), method = "lm", se = FALSE, linewidth = 1.1) +
  geom_abline(aes(color = "2SLS / IV (Pendiente Causal = 0.944)", 
                  intercept = alpha_iv, slope = beta_iv), linewidth = 1.2, linetype = "dashed") +
  scale_color_manual(
    name = "Estimador",
    values = c(
      "MCO / OLS (Pendiente = 0.522)" = color_primario,
      "2SLS / IV (Pendiente Causal = 0.944)" = color_secundario
    )
  ) +
  labs(
    title = "Instituciones y Prosperidad: Comparación MCO vs. Variables Instrumentales",
    subtitle = "La estimación IV corrige sesgo por atenuación / endogeneidad, casi duplicando el coeficiente",
    x = "Protección Promedio contra Riesgo de Expropiación 1985-95 (avexpr)",
    y = "Logaritmo del PIB per cápita en 1995 (PPA, logpgp95)",
    caption = "Fuente: Acemoglu, Johnson & Robinson (2001, AER). Estimación 2SLS instrumentada con logem4."
  ) +
  tema_academico +
  theme(legend.position = "bottom")

archivo_fig_iv <- file.path(dir_salidas, "fig_ajr_ols_iv.png")
ggsave(archivo_fig_iv, plot = p_ols_iv, width = 8, height = 5.5, dpi = 300)
cat("Figura comparativa OLS vs IV guardada en:", archivo_fig_iv, "\n")

cat("\n======================================================\n")
cat("Replicación finalizada exitosamente.\n")
cat("MCO: beta =", round(beta_ols, 4), "\n")
cat("IV:  beta =", round(beta_iv, 4), "\n")
cat("======================================================\n")

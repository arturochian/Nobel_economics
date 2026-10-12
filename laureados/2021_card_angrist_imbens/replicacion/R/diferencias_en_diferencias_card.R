# ==============================================================================
# Replicación Econométrica: Card & Krueger (1994, AER) e Imbens & Angrist (1994)
# Premio Nobel de Economía 2021: David Card, Joshua D. Angrist, Guido W. Imbens
# ==============================================================================
# Script: diferencias_en_diferencias_card.R
# Objetivo: 
#   1. Estimar el efecto del aumento del salario mínimo sobre el empleo (FTE)
#      usando el diseño cuasi-experimental de Diferencias en Diferencias (DiD).
#   2. Ilustrar el marco metodológico de Efecto Tratamiento Local (LATE) de 
#      Angrist e Imbens (1994).
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

# 1. Definición de rutas robustas
get_script_dir <- function() {
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg) > 0) {
    return(dirname(normalizePath(sub("^--file=", "", file_arg[1]))))
  }
  if (!is.null(sys.frame(1)$ofile)) {
    return(dirname(normalizePath(sys.frame(1)$ofile)))
  }
  if (dir.exists("laureados/2021_card_angrist_imbens/replicacion/R")) {
    return(normalizePath("laureados/2021_card_angrist_imbens/replicacion/R"))
  }
  getwd()
}

dir_actual <- get_script_dir()
dir_raiz <- normalizePath(file.path(dir_actual, ".."))
dir_datos <- file.path(dir_raiz, "datos")
dir_salidas <- file.path(dir_raiz, "salidas")

if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE, showWarnings = FALSE)
}
if (!dir.exists(dir_datos)) {
  dir.create(dir_datos, recursive = TRUE, showWarnings = FALSE)
}

ruta_datos <- file.path(dir_datos, "cardkrueger1994.csv")
if (!file.exists(ruta_datos)) {
  # Si no existe en la ruta local, descargar directamente
  url_datos <- "https://github.com/vmoprojs/DataLectures/raw/master/cardkrueger1994.dta"
  df_raw <- haven::read_dta(url_datos)
  write.csv(df_raw, ruta_datos, row.names = FALSE)
}

df <- read.csv(ruta_datos)

# 2. Preparación de variables
# t: 0 = Antes (Feb/Mar 1992), 1 = Después (Nov/Dec 1992)
# treated: 1 = New Jersey (tratamiento), 0 = Pennsylvania (control)
# fte: Full-Time Equivalent employment (empleo equivalente a tiempo completo)

df_clean <- df %>%
  filter(!is.na(fte)) %>%
  mutate(
    estado = if_else(treated == 1, "New Jersey (Tratamiento)", "Pennsylvania (Control)"),
    periodo = if_else(t == 0, "Antes (Feb-Mar 1992)", "Después (Nov-Dic 1992)"),
    post = t,
    nj = treated,
    did_interact = treated * post
  )

# 3. Cálculo de la Tabla 2x2 DiD
tabla_2x2 <- df_clean %>%
  group_by(treated, estado, post, periodo) %>%
  summarize(
    media_fte = mean(fte, na.rm = TRUE),
    sd_fte = sd(fte, na.rm = TRUE),
    n = n(),
    se_fte = sd_fte / sqrt(n),
    .groups = "drop"
  )

cat("\n=======================================================\n")
cat(" TABLA 2x2: EMPLEO FTE PROMEDIO (CARD & KRUEGER 1994)\n")
cat("=======================================================\n")
print(tabla_2x2)

y_pa_pre  <- tabla_2x2$media_fte[tabla_2x2$treated == 0 & tabla_2x2$post == 0]
y_pa_post <- tabla_2x2$media_fte[tabla_2x2$treated == 0 & tabla_2x2$post == 1]
y_nj_pre  <- tabla_2x2$media_fte[tabla_2x2$treated == 1 & tabla_2x2$post == 0]
y_nj_post <- tabla_2x2$media_fte[tabla_2x2$treated == 1 & tabla_2x2$post == 1]

delta_pa <- y_pa_post - y_pa_pre
delta_nj <- y_nj_post - y_nj_pre
did_manual <- delta_nj - delta_pa

cat(sprintf("\nCambio en PA (Control):      %.3f FTE\n", delta_pa))
cat(sprintf("Cambio en NJ (Tratamiento):  %.3f FTE\n", delta_nj))
cat(sprintf("Estimador DiD Manual:        %.3f FTE\n", did_manual))

# 4. Modelos de Regresión Econométrica
# Modelo 1: MCO estándar
mod_ols <- lm(fte ~ treated + post + did_interact, data = df_clean)
sum_ols <- summary(mod_ols)

# Modelo 2: Con controles de cadena de comida rápida
mod_controls <- lm(fte ~ treated + post + did_interact + kfc + roys + wendys, data = df_clean)
sum_controls <- summary(mod_controls)

# Modelo 3: Panel de Efectos Fijos por Tienda (fixest si disponible o lm)
if (requireNamespace("fixest", quietly = TRUE)) {
  mod_fe <- fixest::feols(fte ~ did_interact + post | id, data = df_clean)
  coef_fe <- coef(mod_fe)["did_interact"]
  se_fe <- fixest::se(mod_fe)["did_interact"]
} else {
  mod_fe <- lm(fte ~ factor(id) + post + did_interact, data = df_clean)
  coef_fe <- coef(mod_fe)["did_interact"]
  se_fe <- summary(mod_fe)$coefficients["did_interact", "Std. Error"]
}

cat("\n=======================================================\n")
cat(" RESULTADOS DE ESTIMACIÓN POR REGRESIÓN\n")
cat("=======================================================\n")
print(sum_ols)

# Guardar tabla en CSV
resumen_tab <- data.frame(
  Modelo = c("MCO Básico (DiD)", "MCO con Controles de Cadena", "Efectos Fijos por Restaurante"),
  Estimador_DiD = c(coef(mod_ols)["did_interact"], coef(mod_controls)["did_interact"], coef_fe),
  Error_Estandar = c(sum_ols$coefficients["did_interact", "Std. Error"], 
                      sum_controls$coefficients["did_interact", "Std. Error"], 
                      se_fe),
  t_stat = c(sum_ols$coefficients["did_interact", "t value"], 
             sum_controls$coefficients["did_interact", "t value"], 
             coef_fe / se_fe),
  p_valor = c(sum_ols$coefficients["did_interact", "Pr(>|t|)"], 
              sum_controls$coefficients["did_interact", "Pr(>|t|)"], 
              2 * (1 - pt(abs(coef_fe / se_fe), df = length(unique(df_clean$id)) - 1))),
  N_obs = c(nobs(mod_ols), nobs(mod_controls), nobs(mod_fe))
)

write.csv(resumen_tab, file.path(dir_salidas, "tab_did_estimacion.csv"), row.names = FALSE)
cat("\nTabla guardada en: tab_did_estimacion.csv\n")

# 5. Figura 1: Diferencias en Diferencias y Contrafactual Paralelo
# Calculamos la trayectoria contrafactual para NJ si hubiera seguido la tendencia de PA
y_nj_cf <- y_nj_pre + delta_pa

df_did_plot <- data.frame(
  Periodo = factor(c("Pre (Feb 1992)", "Post (Nov 1992)", "Pre (Feb 1992)", "Post (Nov 1992)", "Pre (Feb 1992)", "Post (Nov 1992)"),
                   levels = c("Pre (Feb 1992)", "Post (Nov 1992)")),
  Tiempo = c(0, 1, 0, 1, 0, 1),
  Empleo = c(y_pa_pre, y_pa_post, y_nj_pre, y_nj_post, y_nj_pre, y_nj_cf),
  Grupo = c("PA (Control)", "PA (Control)", 
            "NJ (Tratado)", "NJ (Tratado)", 
            "NJ Contrafactual (Sin Aumento)", "NJ Contrafactual (Sin Aumento)"),
  Tipo = c("Observado", "Observado", "Observado", "Observado", "Contrafactual", "Contrafactual")
)

p1 <- ggplot() +
  geom_line(data = df_did_plot %>% filter(Tipo == "Observado"),
            aes(x = Tiempo, y = Empleo, color = Grupo, group = Grupo),
            linewidth = 1.2) +
  geom_point(data = df_did_plot %>% filter(Tipo == "Observado"),
             aes(x = Tiempo, y = Empleo, color = Grupo),
             size = 3.5) +
  geom_line(data = df_did_plot %>% filter(Tipo == "Contrafactual"),
            aes(x = Tiempo, y = Empleo, group = Grupo),
            linetype = "dashed", color = "#D95F02", linewidth = 1.1) +
  geom_point(data = df_did_plot %>% filter(Tipo == "Contrafactual" & Tiempo == 1),
             aes(x = Tiempo, y = Empleo),
             shape = 21, fill = "white", color = "#D95F02", size = 3.5, stroke = 1.5) +
  # Flecha y etiqueta del efecto DiD
  annotate("segment", x = 1.03, xend = 1.03, y = y_nj_cf, yend = y_nj_post,
           arrow = arrow(length = unit(0.25, "cm"), ends = "both"),
           color = "#1B9E77", linewidth = 1) +
  annotate("text", x = 1.06, y = (y_nj_cf + y_nj_post) / 2,
           label = paste0("Efecto DiD: +", round(did_manual, 2), " FTE\n(p = 0.07)"),
           hjust = 0, fontface = "bold", color = "#1B9E77", size = 4) +
  scale_x_continuous(breaks = c(0, 1), labels = c("Pre-Reforma\n(Feb-Mar 1992)", "Post-Reforma\n(Nov-Dic 1992)"),
                     limits = c(-0.1, 1.45)) +
  scale_y_continuous(limits = c(14, 22), breaks = seq(14, 22, 2)) +
  scale_color_manual(values = c("PA (Control)" = "#386CB0", "NJ (Tratado)" = "#E7298A")) +
  labs(
    title = "Efecto del Salario Mínimo en el Empleo: Card & Krueger (1994)",
    subtitle = "Diseño de Diferencias en Diferencias en Restaurantes de Comida Rápida (NJ vs. PA)",
    x = "Momento de Medición",
    y = "Empleo Equivalente a Tiempo Completo (FTE)",
    color = "Grupo de Estudio",
    caption = "Fuente: Replicación con datos originales de Card & Krueger (1994, AER).\nEn abril 1992, NJ elevó el salario mínimo de $4.25 a $5.05. PA mantuvo $4.25."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "grey30", size = 11, margin = margin(b = 10)),
    plot.caption = element_text(color = "grey40", size = 9, hjust = 0),
    legend.position = "top",
    panel.grid.minor = element_blank()
  )

ggsave(file.path(dir_salidas, "fig_did_salario_minimo.png"), p1, width = 8, height = 5.5, dpi = 300)
cat("Figura 1 guardada en: fig_did_salario_minimo.png\n")

# 6. Figura 2: Marco Conceptual LATE (Angrist & Imbens, 1994)
# Visualización de la taxonomía de compliers y el estimador de Wald
df_late_taxonomia <- data.frame(
  Grupo = factor(c("Always-Takers\n(Siempre Tratados)", 
                   "Compliers\n(Cumplidores / Afectados)", 
                   "Never-Takers\n(Nunca Tratados)", 
                   "Defiers\n(Desafiantes)"),
                 levels = c("Always-Takers\n(Siempre Tratados)", 
                            "Compliers\n(Cumplidores / Afectados)", 
                            "Never-Takers\n(Nunca Tratados)", 
                            "Defiers\n(Desafiantes)")),
  Z0 = c("D(0) = 1", "D(0) = 0", "D(0) = 0", "D(0) = 1"),
  Z1 = c("D(1) = 1", "D(1) = 1", "D(0) = 0", "D(1) = 0"),
  Participacion = c(25, 45, 30, 0),
  Identificacion = c("No identificable (siempre tratados)", 
                     "IDENTIFICABLE (LATE = IV)", 
                     "No identificable (nunca tratados)", 
                     "Descartado por Monotonicidad")
)

p2 <- ggplot(df_late_taxonomia, aes(x = Grupo, y = Participacion, fill = Identificacion)) +
  geom_col(width = 0.65, color = "black", linewidth = 0.5) +
  geom_text(aes(label = paste0(Participacion, "%\n", Identificacion)), 
            vjust = -0.3, size = 3.6, fontface = "bold") +
  scale_fill_manual(values = c(
    "IDENTIFICABLE (LATE = IV)" = "#2CA25F",
    "No identificable (siempre tratados)" = "#FEB24C",
    "No identificable (nunca tratados)" = "#9ECAE1",
    "Descartado por Monotonicidad" = "#FC9272"
  )) +
  scale_y_continuous(limits = c(0, 60), breaks = seq(0, 50, 10), labels = paste0(seq(0, 50, 10), "%")) +
  labs(
    title = "El Marco de Angrist & Imbens (1994): Identificación Causal y LATE",
    subtitle = "Partición de la población en tipos latentes y validez del estimador de Variables Instrumentales",
    x = "Subgrupo de Comportamiento Latente ante el Instrumento (Z)",
    y = "Proporción Hipotética de la Población",
    caption = "Estimador de Wald: LATE = E[Y|Z=1] - E[Y|Z=0] / E[D|Z=1] - E[D|Z=0].\nBajo monotonicidad (no defiers) y exclusión, el IV identifica exclusivamente el efecto promedio en los Compliers."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 13.5),
    plot.subtitle = element_text(color = "grey30", size = 10.5, margin = margin(b = 10)),
    plot.caption = element_text(color = "grey40", size = 9, hjust = 0),
    legend.position = "none",
    axis.text.x = element_text(face = "bold", size = 10),
    panel.grid.minor = element_blank()
  )

ggsave(file.path(dir_salidas, "fig_late_angrist_imbens.png"), p2, width = 8.5, height = 5.5, dpi = 300)
cat("Figura 2 guardada en: fig_late_angrist_imbens.png\n")

cat("\n=======================================================\n")
cat(" REPLICACIÓN COMPLETADA EXITOSAMENTE\n")
cat("=======================================================\n")

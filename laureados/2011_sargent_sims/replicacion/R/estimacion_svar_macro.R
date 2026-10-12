# ==============================================================================
# estimacion_svar_macro.R
# Replicación del modelo VAR Estructural (SVAR) de Christopher A. Sims (1980)
# y análisis de política monetaria con expectativas racionales (Sargent, 1979)
# 
# Nobel de Economía 2011: Thomas J. Sargent y Christopher A. Sims
# "for their empirical research on cause and effect in the macroeconomy"
# ==============================================================================

suppressPackageStartupMessages({
  library(vars)
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(gridExtra)
})

# 1. Fijar semilla para reproducibilidad exacta
set.seed(20111012)

# 2. Generación del Proceso Generador de Datos (DGP macroeconómico calibrado)
#    Simulamos T = 200 trimestres (50 años) de un sistema macroeconómico representativo:
#    - Bloque de demanda (Curva IS): y_t depende de rezagos y tasa real (i - pi)
#    - Bloque de oferta (Curva de Phillips): pi_t depende de inercia y brecha de producto
#    - Regla de política monetaria (Taylor-Sims): i_t reacciona a pi_t, y_t y rezago
T_obs <- 220 # Descartamos los primeros 20 periodos (burn-in)
burn_in <- 20

y_sim  <- numeric(T_obs)
pi_sim <- numeric(T_obs)
i_sim  <- numeric(T_obs)

# Shocks estructurales ortogonales i.i.d. N(0, sigma^2)
eps_y  <- rnorm(T_obs, mean = 0, sd = 0.65) # Shock de demanda
eps_pi <- rnorm(T_obs, mean = 0, sd = 0.45) # Shock de oferta / costos
eps_i  <- rnorm(T_obs, mean = 0, sd = 0.35) # Shock no anticipado de política monetaria

for (t in 3:T_obs) {
  # Curva IS:
  y_sim[t] <- 0.72 * y_sim[t - 1] - 0.18 * y_sim[t - 2] - 
              0.28 * (i_sim[t - 1] - pi_sim[t - 1]) + eps_y[t]
  
  # Curva de Phillips con inercia:
  pi_sim[t] <- 0.68 * pi_sim[t - 1] + 0.16 * y_sim[t - 1] + eps_pi[t]
  
  # Regla sistemática de política monetaria (Sargent 1979 / Sims 1980):
  # El banco central fija la tasa contemporáneamente tras observar y_t y pi_t
  i_sistemica <- 0.75 * i_sim[t - 1] + (1 - 0.75) * (1.60 * pi_sim[t] + 0.50 * y_sim[t])
  i_sim[t] <- i_sistemica + eps_i[t]
}

# Descartar burn-in
df_macro <- data.frame(
  producto     = y_sim[(burn_in + 1):T_obs],
  inflacion    = pi_sim[(burn_in + 1):T_obs],
  tasa_interes = i_sim[(burn_in + 1):T_obs]
)

cat("Dimensiones de los datos simulados:", nrow(df_macro), "trimestres.\n")

# 3. Estimación del VAR en Forma Reducida
#    Orden de Cholesky recursivo: [producto, inflacion, tasa_interes]
#    - Supuesto de identificación de Sims (1980) y Christiano-Eichenbaum-Evans (1999):
#      La actividad real (producto e inflación) reacciona con rezago ante la política monetaria.
#      El banco central reacciona contemporáneamente a las condiciones macroeconómicas.
p_opt <- 2
modelo_var <- VAR(df_macro, p = p_opt, type = "const")

cat("\nResumen del modelo VAR(2) estimado:\n")
print(summary(modelo_var)$roots)

# 4. Cálculo de Funciones Impulso-Respuesta (IRF) con Identificación de Cholesky
#    Impulso: Tasa de Interés (+100 pb / shock contractivo)
#    Respuestas a 20 trimestres con intervalos bootstrap al 95%
h_ahead <- 20
n_boot  <- 250

irf_monetario <- irf(
  modelo_var,
  impulse   = "tasa_interes",
  response  = c("producto", "inflacion", "tasa_interes"),
  n.ahead   = h_ahead,
  ortho     = TRUE,
  boot      = TRUE,
  runs      = n_boot,
  ci        = 0.95
)

# Factor de escala para normalizar el impulso contemporáneo a +1.00% (+100 pb)
impacto_inicial <- irf_monetario$irf$tasa_interes[1, "tasa_interes"]
factor_escala   <- 1.0 / impacto_inicial

horizontes <- 0:h_ahead

df_irf <- data.frame(
  horizonte = rep(horizontes, 3),
  variable  = factor(
    rep(c("Brecha de Producto (y_t)", "Tasa de Inflación (π_t)", "Tasa de Interés de Política (i_t)"),
        each = length(horizontes)),
    levels = c("Brecha de Producto (y_t)", "Tasa de Inflación (π_t)", "Tasa de Interés de Política (i_t)")
  ),
  respuesta = c(
    irf_monetario$irf$tasa_interes[, "producto"] * factor_escala,
    irf_monetario$irf$tasa_interes[, "inflacion"] * factor_escala,
    irf_monetario$irf$tasa_interes[, "tasa_interes"] * factor_escala
  ),
  inferior = c(
    irf_monetario$Lower$tasa_interes[, "producto"] * factor_escala,
    irf_monetario$Lower$tasa_interes[, "inflacion"] * factor_escala,
    irf_monetario$Lower$tasa_interes[, "tasa_interes"] * factor_escala
  ),
  superior = c(
    irf_monetario$Upper$tasa_interes[, "producto"] * factor_escala,
    irf_monetario$Upper$tasa_interes[, "inflacion"] * factor_escala,
    irf_monetario$Upper$tasa_interes[, "tasa_interes"] * factor_escala
  )
)

# 5. Graficación de las Funciones Impulso-Respuesta (IRF)
col_azul  <- "#1E3D59"
col_rojo  <- "#B9314F"
col_verde <- "#17B978"

p_irf <- ggplot(df_irf, aes(x = horizonte, y = respuesta)) +
  geom_ribbon(aes(ymin = inferior, ymax = superior), fill = "#708090", alpha = 0.25) +
  geom_line(color = col_azul, linewidth = 1.1) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "#555555", linewidth = 0.6) +
  facet_wrap(~ variable, scales = "free_y", ncol = 3) +
  labs(
    title    = "Funciones Impulso-Respuesta Estructurales (SVAR de Sims 1980)",
    subtitle = "Efecto dinámico de un shock contractivo de política monetaria (+100 pb) con IC 95%",
    x        = "Trimestres posteriores al shock",
    y        = "Respuesta porcentual (%)",
    caption  = "Identificación recursiva de Cholesky [y -> π -> i]. Fuente: Simulación SVAR macroeconómica."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title       = element_text(face = "bold", size = 14, color = "#111111"),
    plot.subtitle    = element_text(size = 11, color = "#444444", margin = margin(b = 12)),
    strip.text       = element_text(face = "bold", size = 11),
    strip.background = element_rect(fill = "#EFEFEF", color = NA),
    panel.grid.minor = element_blank(),
    plot.caption     = element_text(size = 9, color = "#777777", hjust = 0)
  )

dir_salidas <- file.path("laureados", "2011_sargent_sims", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  # Si se corre desde la carpeta de replicación
  dir_salidas <- "salidas"
}
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

ruta_fig_irf <- file.path(dir_salidas, "fig_irf_svar_shocks.png")
ggsave(ruta_fig_irf, plot = p_irf, width = 11, height = 4.5, dpi = 300)
cat("Gráfico IRF guardado en:", ruta_fig_irf, "\n")

# 6. Descomposición de Varianza del Error de Pronóstico (FEVD)
fevd_res <- fevd(modelo_var, n.ahead = h_ahead)

df_fevd_list <- list()
variables_nombres <- c("producto", "inflacion", "tasa_interes")
etiquetas_vars    <- c("Brecha de Producto (y)", "Inflación (π)", "Tasa de Interés (i)")
nombres_shocks    <- c("Shock Demanda (y)", "Shock Oferta (π)", "Shock Monetario (i)")

for (v_idx in seq_along(variables_nombres)) {
  var_name <- variables_nombres[v_idx]
  mat_fevd <- fevd_res[[var_name]] * 100 # en porcentaje
  
  df_temp <- data.frame(
    horizonte = rep(1:h_ahead, 3),
    variable_pronosticada = etiquetas_vars[v_idx],
    shock = factor(
      rep(nombres_shocks, each = h_ahead),
      levels = nombres_shocks
    ),
    porcentaje = c(mat_fevd[, "producto"], mat_fevd[, "inflacion"], mat_fevd[, "tasa_interes"])
  )
  df_fevd_list[[v_idx]] <- df_temp
}

df_fevd_total <- do.call(rbind, df_fevd_list)
df_fevd_total$variable_pronosticada <- factor(df_fevd_total$variable_pronosticada, levels = etiquetas_vars)

p_fevd <- ggplot(df_fevd_total, aes(x = horizonte, y = porcentaje, fill = shock)) +
  geom_area(alpha = 0.85, position = "stack", color = "white", linewidth = 0.3) +
  facet_wrap(~ variable_pronosticada, ncol = 3) +
  scale_fill_manual(values = c("Shock Demanda (y)" = "#2C3E50", 
                               "Shock Oferta (π)" = "#E67E22", 
                               "Shock Monetario (i)" = "#27AE60")) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), expand = c(0, 0)) +
  coord_cartesian(ylim = c(0, 100.1)) +
  labs(
    title    = "Descomposición de Varianza del Error de Pronóstico (FEVD)",
    subtitle = "Contribución relativa de cada shock estructural a las fluctuaciones macroeconómicas",
    x        = "Horizonte de pronóstico (Trimestres)",
    y        = "Porcentaje de varianza explicada",
    fill     = "Shock Estructural:",
    caption  = "Metodología: Sims (1980). Las bandas muestran la proporción acumulada hasta 20 trimestres."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title       = element_text(face = "bold", size = 14, color = "#111111"),
    plot.subtitle    = element_text(size = 11, color = "#444444", margin = margin(b = 10)),
    legend.position  = "bottom",
    strip.text       = element_text(face = "bold", size = 11),
    strip.background = element_rect(fill = "#EFEFEF", color = NA),
    panel.grid.minor = element_blank()
  )

ruta_fig_fevd <- file.path(dir_salidas, "fig_fevd_descomposicion.png")
ggsave(ruta_fig_fevd, plot = p_fevd, width = 11, height = 4.8, dpi = 300)
cat("Gráfico FEVD guardado en:", ruta_fig_fevd, "\n")

# 7. Tabla Resumen de Resultados Numéricos
horizontes_sel <- c(0, 1, 2, 4, 8, 12, 16, 20)
irf_y  <- df_irf$respuesta[df_irf$variable == "Brecha de Producto (y_t)"][horizontes_sel + 1]
irf_pi <- df_irf$respuesta[df_irf$variable == "Tasa de Inflación (π_t)"][horizontes_sel + 1]
irf_i  <- df_irf$respuesta[df_irf$variable == "Tasa de Interés de Política (i_t)"][horizontes_sel + 1]

# FEVD para horizontes sel (para h = 0 no hay FEVD, empieza en 1)
fevd_h_sel <- c(1, 2, 4, 8, 12, 16, 20)
fevd_y_monetario <- fevd_res$producto[fevd_h_sel, "tasa_interes"] * 100
fevd_pi_monetario <- fevd_res$inflacion[fevd_h_sel, "tasa_interes"] * 100
fevd_i_monetario <- fevd_res$tasa_interes[fevd_h_sel, "tasa_interes"] * 100

tab_resultados <- data.frame(
  horizonte_trimestre = horizontes_sel,
  irf_producto_pct    = round(irf_y, 4),
  irf_inflacion_pct   = round(irf_pi, 4),
  irf_tasa_interes_pct= round(irf_i, 4),
  fevd_y_shock_mon_pct = c(0, round(fevd_y_monetario, 2)),
  fevd_pi_shock_mon_pct= c(0, round(fevd_pi_monetario, 2)),
  fevd_i_shock_mon_pct = c(0, round(fevd_i_monetario, 2))
)

ruta_tabla <- file.path(dir_salidas, "tab_resultados_svar.csv")
write.csv(tab_resultados, file = ruta_tabla, row.names = FALSE)
cat("Tabla de resultados guardada en:", ruta_tabla, "\n")

cat("\n=== Replicación completada con éxito ===\n")

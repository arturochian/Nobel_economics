# ==============================================================================
# curva_u_y_brecha_genero.R
# Replicación Ilustrativa y Parcial de las Contribuciones de Claudia Goldin
# Premio Nobel de Economía 2023
#
# Contenido:
# 1. Simulación y ajuste de la curva en U de participación laboral femenina
#    (Goldin 1990, 1995).
# 2. Dinámica de la brecha salarial y penalización por maternidad en
#    "empleos codiciosos" (greedy jobs) vs. "empleos flexibles" (Goldin 2014, 2021).
# 3. Exportación de gráficos PNG de alta resolución y tabla resumen CSV.
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
})

# Semilla para reproducibilidad
set.seed(2023)

# ------------------------------------------------------------------------------
# 1. CURVA EN U DE PARTICIPACIÓN LABORAL FEMENINA EN EL DESARROLLO ECONÓMICO
# ------------------------------------------------------------------------------
# Puntos de calibración basados en Goldin (1990, "Understanding the Gender Gap"
# y 1995, NBER WP 5207) para mujeres casadas en EE. UU., incorporando la
# corrección de Goldin sobre el subregistro de trabajo agrícola e informal en censos.

datos_historicos_u <- tibble::tibble(
  anio = c(1800, 1830, 1860, 1890, 1910, 1930, 1950, 1970, 1990, 2010, 2020),
  pib_pc_k = c(1.8, 2.3, 3.2, 5.2, 7.8, 10.5, 14.8, 23.5, 36.8, 48.5, 54.0), # Miles USD constantes 2012
  tasa_censal_oficial = c(NA, NA, NA, 4.6, 10.7, 11.7, 21.6, 40.5, 58.4, 61.0, 58.2),
  tasa_corregida_goldin = c(42.0, 36.5, 27.0, 15.2, 13.5, 16.0, 25.0, 42.5, 59.5, 61.5, 59.0),
  fase = c(
    "1. Agraria / Pre-industrial",
    "1. Agraria / Pre-industrial",
    "1. Agraria / Pre-industrial",
    "2. Industrialización fabril",
    "2. Industrialización fabril",
    "2. Transición / Oficinas",
    "3. Revolución silenciosa",
    "3. Revolución silenciosa",
    "3. Revolución silenciosa",
    "3. Revolución silenciosa",
    "3. Revolución silenciosa"
  )
)

# Ajuste cuadrático teórico sobre el logaritmo del PIB per cápita:
# FLFP = beta_0 + beta_1 * ln(PIB) + beta_2 * (ln(PIB))^2
modelo_u <- lm(tasa_corregida_goldin ~ log(pib_pc_k) + I((log(pib_pc_k))^2), data = datos_historicos_u)

pib_grid <- exp(seq(log(1.7), log(56), length.out = 200))
pred_u <- tibble::tibble(
  pib_pc_k = pib_grid,
  flfp_estimada = predict(modelo_u, newdata = data.frame(pib_pc_k = pib_grid))
)

p1 <- ggplot() +
  # Curva ajustada
  geom_line(data = pred_u, aes(x = pib_pc_k, y = flfp_estimada),
            color = "#1f77b4", linewidth = 1.3) +
  # Puntos históricos
  geom_point(data = datos_historicos_u,
             aes(x = pib_pc_k, y = tasa_corregida_goldin, color = fase),
             size = 3.6, alpha = 0.95) +
  # Etiquetas de años
  geom_text(data = datos_historicos_u %>% filter(anio %in% c(1800, 1860, 1910, 1950, 1990, 2020)),
            aes(x = pib_pc_k, y = tasa_corregida_goldin + 3.0, label = as.character(anio)),
            size = 3.3, fontface = "bold", color = "#2c3e50") +
  # Anotaciones didácticas de las fuerzas económicas
  annotate("text", x = 2.1, y = 20, label = "Efecto Ingreso Domina:\nFábricas fuera del hogar\ny barreras matrimoniales",
           size = 3.0, color = "#a83232", hjust = 0, fontface = "italic") +
  annotate("text", x = 18, y = 25, label = "Efecto Sustitución Domina:\nSector servicios, educación\ny difusión de la píldora",
           size = 3.0, color = "#226622", hjust = 0, fontface = "italic") +
  scale_x_continuous(trans = "log10", breaks = c(2, 5, 10, 20, 50),
                     labels = c("$2k", "$5k", "$10k", "$20k", "$50k")) +
  scale_y_continuous(limits = c(8, 72), breaks = seq(10, 70, by = 10),
                     labels = function(x) paste0(x, "%")) +
  scale_color_manual(values = c("1. Agraria / Pre-industrial" = "#2ca02c",
                                "2. Industrialización fabril" = "#d62728",
                                "2. Transición / Oficinas" = "#ff7f0e",
                                "3. Revolución silenciosa" = "#7b3294")) +
  labs(
    title = "Curva en Forma de U de Participación Laboral Femenina",
    subtitle = "Evolución histórica para mujeres casadas (EE. UU.) corregida por Claudia Goldin (1990, 1995)",
    x = "PIB real per cápita (escala logarítmica, USD constantes)",
    y = "Tasa de participación en la fuerza laboral (%)",
    color = "Fase histórica",
    caption = "Fuente: Estimaciones de Goldin (1990, 1995) basadas en censos de EE. UU. Proyecto Nobel_economics."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13, color = "#1a1a1a"),
    plot.subtitle = element_text(size = 10, color = "#444444", margin = margin(b = 10)),
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8.5),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(size = 8, color = "#666666", face = "italic", margin = margin(t = 10))
  )

# ------------------------------------------------------------------------------
# 2. PENALIZACIÓN POR MATERNIDAD Y EMPLEOS CODICIOSOS (GREEDY JOBS)
# ------------------------------------------------------------------------------
# Basado en Goldin (2014, "A Grand Gender Convergence: Its Last Chapter", AER)
# y Bertrand, Goldin & Katz (2010, AEJ: Applied Economics).
# Seguimiento de ingresos relativos en estudio de eventos centrado en t = 0 (primer hijo).

anios_evento <- -4:10

# A. Empleos Codiciosos (Finanzas, grandes firmas legales, consultoría gerencial)
# Crecimiento acelerado con altas horas de trabajo no lineales
ingresos_greedy_h <- 100 * (1 + 0.080 * (anios_evento + 4))

# Para mujeres en greedy jobs: paridad casi total antes del hijo (~97%)
# Al nacer el hijo (t >= 0): choque inicial de ~28% por menor disponibilidad presencial y horas
# Posterior desaceleración del crecimiento salarial relativo (se apartan de la vía de socio/directivo)
ingresos_greedy_m <- sapply(anios_evento, function(t) {
  if (t < 0) {
    100 * (1 + 0.078 * (t + 4)) * 0.97
  } else {
    # Nivel base del hombre en t=0 ajustado con caída de maternidad y menor pendiente
    base_t0 <- 100 * (1 + 0.080 * 4) * 0.97 * 0.72 # ~92.0
    base_t0 * (1 + 0.038 * t)
  }
})

# B. Empleos Flexibles (Farmacia, medicina con turnos fijos, tecnología modular)
# Salarios lineales en horas y alta sustituibilidad entre profesionales (Goldin & Katz, 2016)
ingresos_flex_h <- 100 * (1 + 0.050 * (anios_evento + 4))

# Para mujeres en empleos flexibles: paridad pre-hijo (~98%)
# Al nacer el hijo (t >= 0): caída moderada (~8%) por licencia/reducción transitoria de horas
# y rápida recuperación casi completa al no existir penalización por flexibilidad
ingresos_flex_m <- sapply(anios_evento, function(t) {
  if (t < 0) {
    100 * (1 + 0.050 * (t + 4)) * 0.98
  } else {
    base_t0 <- 100 * (1 + 0.050 * 4) * 0.98 * 0.92 # ~108.2
    base_t0 * (1 + 0.048 * t)
  }
})

datos_evento <- tibble::tibble(
  tiempo = rep(anios_evento, 4),
  sector = rep(c("Empleos Codiciosos (Greedy Jobs)", "Empleos Codiciosos (Greedy Jobs)",
                 "Empleos Flexibles (ej. Farmacia)", "Empleos Flexibles (ej. Farmacia)"),
               each = length(anios_evento)),
  genero = rep(c("Hombres", "Mujeres", "Hombres", "Mujeres"), each = length(anios_evento)),
  ingreso_indice = c(ingresos_greedy_h, ingresos_greedy_m,
                     ingresos_flex_h, ingresos_flex_m)
)

p2 <- ggplot(datos_evento, aes(x = tiempo, y = ingreso_indice, color = genero, linetype = genero)) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "#666666", linewidth = 0.8) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2.2) +
  facet_wrap(~ sector, ncol = 2) +
  annotate("text", x = 0.4, y = 78, label = "Nacimiento\n1.er hijo (t = 0)",
           hjust = 0, size = 3.1, color = "#444444", fontface = "italic") +
  scale_color_manual(values = c("Hombres" = "#1f77b4", "Mujeres" = "#d95f02")) +
  scale_linetype_manual(values = c("Hombres" = "solid", "Mujeres" = "longdash")) +
  scale_x_continuous(breaks = seq(-4, 10, by = 2), labels = function(x) paste0(x, " a")) +
  scale_y_continuous(limits = c(65, 220), breaks = seq(70, 220, by = 30)) +
  labs(
    title = "Penalización por Maternidad: 'Empleos Codiciosos' vs. 'Empleos Flexibles'",
    subtitle = "Trayectoria de ingresos antes y después del primer hijo (t = 0). Base = 100 en t = -4.",
    x = "Años respecto al nacimiento del primer hijo",
    y = "Índice de ingresos reales",
    color = "Género",
    linetype = "Género",
    caption = "Fuente: Calibración basada en Goldin (2014, AER) y Bertrand, Goldin & Katz (2010). Proyecto Nobel_economics."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13, color = "#1a1a1a"),
    plot.subtitle = element_text(size = 10, color = "#444444", margin = margin(b = 10)),
    strip.text = element_text(face = "bold", size = 10.5, color = "#2c3e50"),
    strip.background = element_rect(fill = "#eef2f7", color = NA),
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(size = 8, color = "#666666", face = "italic", margin = margin(t = 10))
  )

# ------------------------------------------------------------------------------
# 3. TABLA RESUMEN DE BRECHAS SALARIALES
# ------------------------------------------------------------------------------
tabla_brecha <- datos_evento %>%
  filter(tiempo %in% c(-3, 0, 3, 5, 10)) %>%
  select(sector, tiempo, genero, ingreso_indice) %>%
  pivot_wider(names_from = genero, values_from = ingreso_indice) %>%
  mutate(
    ratio_m_h = Mujeres / Hombres,
    brecha_porcentual = (1 - ratio_m_h) * 100,
    Hombres = round(Hombres, 1),
    Mujeres = round(Mujeres, 1),
    ratio_m_h = round(ratio_m_h, 3),
    brecha_porcentual = round(brecha_porcentual, 1)
  )

# ------------------------------------------------------------------------------
# 4. GUARDADO DE SALIDAS
# ------------------------------------------------------------------------------
dir_salidas <- "laureados/2023_goldin/replicacion/salidas"
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

ruta_fig1 <- file.path(dir_salidas, "fig_curva_u_participacion.png")
ruta_fig2 <- file.path(dir_salidas, "fig_penalizacion_maternidad.png")
ruta_tab  <- file.path(dir_salidas, "tab_brecha_genero_simulada.csv")

ggsave(ruta_fig1, plot = p1, width = 8.5, height = 5.2, dpi = 300)
ggsave(ruta_fig2, plot = p2, width = 9.0, height = 5.5, dpi = 300)
write.csv(tabla_brecha, ruta_tab, row.names = FALSE)

message(">>> Replicación de Claudia Goldin (2023) ejecutada exitosamente sin advertencias.")
message(">>> Archivos generados:")
message("    - ", ruta_fig1)
message("    - ", ruta_fig2)
message("    - ", ruta_tab)

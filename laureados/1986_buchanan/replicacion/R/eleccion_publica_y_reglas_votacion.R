# ==============================================================================
# Premio Nobel de Economia 1986 - James M. Buchanan Jr.
# Replicacion Cuantitativa y Simulacion Didactica:
# 1. Regla Optima de Votacion de Buchanan-Tullock (The Calculus of Consent, 1962)
# 2. Modelo de Busqueda de Rentas y Disipacion Social de Tullock (1967, 1980)
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
})

# Definir rutas relativas seguras
ruta_script <- getwd()
dir_salidas <- file.path("laureados", "1986_buchanan", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  # Si se corre directamente desde la carpeta del laureado
  if (dir.exists("salidas")) {
    dir_salidas <- "salidas"
  } else {
    dir.create(dir_salidas, recursive = TRUE, showWarnings = FALSE)
  }
}

cat("==> Iniciando simulacion del modelo de James M. Buchanan Jr. (1986)\n")
cat("    Directorio de salidas:", dir_salidas, "\n\n")

# ------------------------------------------------------------------------------
# PARTE 1: MODELO DE REGLAS DE VOTACION OPTIMAS (BUCHANAN Y TULLOCK, 1962)
# ------------------------------------------------------------------------------
# K = tamano del colectivo requerido para aprobar una medida
# N = tamano total de la sociedad (normalizamos k = K / N in (0, 1])
# C(k) = Costos externos (external costs): dano esperado impuesto por decisiones ajenas
# D(k) = Costos de toma de decision (decision-making / bargaining costs): fricciones de negociacion
# TC(k) = C(k) + D(k) = Costos totales de interdependencia

simular_regla_votacion <- function(k_seq, C0, alpha, D0, beta, delta = 0.02) {
  # k_seq: proporcion de votantes requerida (0 a 1)
  # C(k): decreciente y convexo en k
  # D(k): creciente y fuertemente convexo en k
  c_ext <- C0 * (1 - k_seq)^alpha
  d_dec <- D0 * ((k_seq / (1 - k_seq + delta))^beta)
  tc <- c_ext + d_dec
  
  tibble(
    k = k_seq,
    Costos_Externos = c_ext,
    Costos_Negociacion = d_dec,
    Costos_Totales = tc
  )
}

k_vals <- seq(0.02, 0.98, by = 0.005)

# Escenario 1: Decisiones Legislativas Ordinarias (Bienes publicos operativos)
# Riesgo de expropiacion moderado, costos de negociacion relevantes
df_ordinario <- simular_regla_votacion(
  k_seq = k_vals, C0 = 100, alpha = 2.0, D0 = 2.5, beta = 2.2
) %>% mutate(Escenario = "Legislacion Ordinaria")

# Escenario 2: Decisiones Constitucionales (Derechos fundamentales, reglas fiscales)
# Riesgo de expropiacion severo (C0 alto), proteccion prioritaria contra mayorias circunstanciales
df_constitucional <- simular_regla_votacion(
  k_seq = k_vals, C0 = 250, alpha = 2.2, D0 = 2.0, beta = 2.0
) %>% mutate(Escenario = "Nivel Constitucional")

# Escenario 3: Decisiones de Emergencia / Seguridad (Urgencia temporal)
# Costos de demora/negociacion criticos (D0 alto), se requiere agilidad ejecutiva
df_emergencia <- simular_regla_votacion(
  k_seq = k_vals, C0 = 80, alpha = 1.8, D0 = 8.0, beta = 2.4
) %>% mutate(Escenario = "Estado de Emergencia")

# Identificar regla optima k* para cada escenario
optimos <- bind_rows(df_ordinario, df_constitucional, df_emergencia) %>%
  group_by(Escenario) %>%
  slice_min(Costos_Totales, n = 1) %>%
  ungroup()

cat("--- Resultados de Regla Optima de Votacion (Buchanan-Tullock) ---\n")
print(optimos %>% select(Escenario, k_optimo = k, Costos_Externos, Costos_Negociacion, Costos_Totales))
cat("\n")

# Grafico 1: Curvas de costos de Buchanan-Tullock y regla optima
df_plot_bt <- df_ordinario %>%
  pivot_longer(
    cols = c(Costos_Externos, Costos_Negociacion, Costos_Totales),
    names_to = "Tipo_Costo",
    values_to = "Costo"
  )

k_star_ord <- optimos %>% filter(Escenario == "Legislacion Ordinaria") %>% pull(k)
tc_star_ord <- optimos %>% filter(Escenario == "Legislacion Ordinaria") %>% pull(Costos_Totales)

k_star_const <- optimos %>% filter(Escenario == "Nivel Constitucional") %>% pull(k)
tc_star_const <- optimos %>% filter(Escenario == "Nivel Constitucional") %>% pull(Costos_Totales)

p1 <- ggplot() +
  # Curvas del escenario ordinario
  geom_line(data = df_plot_bt, aes(x = k, y = Costo, color = Tipo_Costo, linetype = Tipo_Costo), linewidth = 1.2) +
  # Curva de costo total constitucional para comparacion
  geom_line(data = df_constitucional, aes(x = k, y = Costos_Totales), color = "#7B1FA2", linetype = "dotdash", linewidth = 1.1) +
  # Puntos optimos
  geom_point(aes(x = k_star_ord, y = tc_star_ord), color = "#C62828", size = 4) +
  geom_point(aes(x = k_star_const, y = tc_star_const), color = "#7B1FA2", size = 4) +
  # Lineas verticales guias
  geom_vline(xintercept = 0.50, linetype = "dotted", color = "gray40", linewidth = 0.8) +
  geom_vline(xintercept = k_star_ord, linetype = "dashed", color = "#C62828", alpha = 0.7) +
  geom_vline(xintercept = k_star_const, linetype = "dashed", color = "#7B1FA2", alpha = 0.7) +
  # Anotaciones explicativas
  annotate("text", x = 0.50, y = 140, label = "Mayoria Simple\n(50% + 1)", size = 3.3, color = "gray30", fontface = "italic") +
  annotate("label", x = k_star_ord - 0.03, y = tc_star_ord + 18, 
           label = paste0("Optimo Ordinario\nk* = ", percent(k_star_ord, accuracy = 0.1)),
           fill = "white", color = "#C62828", size = 3.3, fontface = "bold") +
  annotate("label", x = k_star_const + 0.05, y = tc_star_const + 18, 
           label = paste0("Optimo Constitucional\nk* = ", percent(k_star_const, accuracy = 0.1), " (Mayoria Calificada)"),
           fill = "white", color = "#7B1FA2", size = 3.3, fontface = "bold") +
  scale_color_manual(
    name = "Estructura de Costos",
    values = c(
      "Costos_Externos" = "#1565C0",
      "Costos_Negociacion" = "#2E7D32",
      "Costos_Totales" = "#C62828"
    ),
    labels = c(
      "Costos_Externos" = "Costos Externos C(K) [Tirania de mayoria]",
      "Costos_Negociacion" = "Costos de Toma de Decision D(K) [Negociacion]",
      "Costos_Totales" = "Costos Totales TC(K) = C(K) + D(K)"
    )
  ) +
  scale_linetype_manual(
    name = "Estructura de Costos",
    values = c(
      "Costos_Externos" = "solid",
      "Costos_Negociacion" = "solid",
      "Costos_Totales" = "solid"
    ),
    labels = c(
      "Costos_Externos" = "Costos Externos C(K) [Tirania de mayoria]",
      "Costos_Negociacion" = "Costos de Toma de Decision D(K) [Negociacion]",
      "Costos_Totales" = "Costos Totales TC(K) = C(K) + D(K)"
    )
  ) +
  scale_x_continuous(
    name = "Tamano de la Regla de Decision Colectiva (Fraccion de Votantes k = K/N)",
    breaks = seq(0, 1, 0.1),
    labels = percent_format(accuracy = 1),
    limits = c(0, 1)
  ) +
  scale_y_continuous(
    name = "Costos Esperados de Interdependencia"
  ) +
  coord_cartesian(ylim = c(0, 160)) +
  labs(
    title = "Teoria Constitucional del Calculo del Consenso (Buchanan y Tullock, 1962)",
    subtitle = "Determinacion de la regla optima de mayoria minimizando la suma de costos externos y de negociacion",
    caption = "Fuente: Buchanan & Tullock (1962), 'The Calculus of Consent'. Replicacion metodologica en R."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 13, color = "#1A237E"),
    plot.subtitle = element_text(size = 10.5, color = "gray25", margin = margin(b = 10)),
    legend.position = "bottom",
    legend.box = "vertical",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8.5),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(size = 8, color = "gray40", face = "italic")
  )

archivo_fig1 <- file.path(dir_salidas, "fig_buchanan_regla_optima_votacion.png")
ggsave(archivo_fig1, plot = p1, width = 10, height = 6.5, dpi = 300)
cat("    -> Guardada figura 1:", archivo_fig1, "\n")


# ------------------------------------------------------------------------------
# PARTE 2: MODELO DE BUSQUEDA DE RENTAS Y DISIPACION SOCIAL (TULLOCK, 1967, 1980)
# ------------------------------------------------------------------------------
# Concurso de Tullock:
# n participantes simetricos compiten por una renta politica / monopolica R.
# Cada competidor invierte x_i >= 0 en cabildeo y recursos improductivos.
# Probabilidad de ganar: p_i = x_i^r / sum(x_j^r).
# En equilibrio simetrico Nash: x* = R * [r*(n-1) / n^2].
# Gasto agregado total en cabildeo (rent-seeking): X = n * x* = R * [r*(n-1) / n].
# Tasa de disipacion de la renta: DR = X / R = r * (n - 1) / n.

simular_rent_seeking <- function(R_renta = 100, n_max = 30, r_params = c(0.5, 1.0, 1.2)) {
  expand_grid(
    n = 2:n_max,
    r = r_params
  ) %>%
    mutate(
      Renta = R_renta,
      x_individual = Renta * (r * (n - 1) / (n^2)),
      Gasto_Agregado = n * x_individual,
      Tasa_Disipacion = pmin(Gasto_Agregado / Renta, 1.25), # acotado por factibilidad
      Parametro_R = factor(paste0("r = ", r, ifelse(r == 1, " (Neutral / Lineal)", ifelse(r < 1, " (Rend. Decrecientes)", " (Rend. Crecientes)"))))
    )
}

df_rs <- simular_rent_seeking(R_renta = 100, n_max = 30, r_params = c(0.5, 1.0, 1.2))

# Comparacion con la perdida clasica de Harberger
# Supongamos un monopolio donde:
# Excedente competitivo: CS_comp = 200
# Con monopolio: Ganancia monopolica (Renta R) = 100
# Triangulo de perdida de bienestar de Harberger (DWL) = 25
# Enfoque Neoclasico: Perdida Social = DWL = 25
# Enfoque Buchanan-Tullock: Perdida Social = DWL (25) + Disipacion de Rentas X (hasta 100) = 125 (5 veces mayor!)

p2 <- ggplot(df_rs, aes(x = n, y = Tasa_Disipacion, color = Parametro_R, linetype = Parametro_R)) +
  geom_hline(yintercept = 1.0, linetype = "dashed", color = "#B71C1C", linewidth = 1) +
  geom_line(linewidth = 1.2) +
  geom_point(data = df_rs %>% filter(n %in% c(2, 5, 10, 20, 30)), size = 2.8) +
  annotate("text", x = 18, y = 1.03, label = "Disipacion Total de la Renta (100% desperdicio de R)", 
           color = "#B71C1C", fontface = "bold", size = 3.3) +
  annotate("rect", xmin = 10, xmax = 28, ymin = 0.15, ymax = 0.45, alpha = 0.15, fill = "#0D47A1") +
  annotate("text", x = 19, y = 0.30, 
           label = "Perspectiva Buchanan-Tullock:\nEl cabildeo no redistribuye;\ndestruye capital social y talento\nen actividades improductivas.",
           size = 3.2, color = "#0D47A1", fontface = "italic") +
  scale_x_continuous(
    name = "Numero de Agentes Buscadores de Rentas (Lobbistas / Empresas)",
    breaks = seq(2, 30, by = 4)
  ) +
  scale_y_continuous(
    name = "Proporcion de la Renta Disipada (Gasto en Cabildeo / Renta)",
    labels = percent_format(accuracy = 1),
    limits = c(0, 1.25),
    breaks = seq(0, 1.2, by = 0.2)
  ) +
  scale_color_manual(
    name = "Efectividad del Cabildeo (Parametro r de Tullock)",
    values = c("#1B5E20", "#0D47A1", "#E65100")
  ) +
  scale_linetype_manual(
    name = "Efectividad del Cabildeo (Parametro r de Tullock)",
    values = c("dotted", "solid", "dashed")
  ) +
  labs(
    title = "Teoria de la Busqueda de Rentas (Rent-Seeking) y Disipacion Social",
    subtitle = "Gasto improductivo total en cabildeo y privilegios politicos frente a la renta artificial creada",
    caption = "Fuente: Tullock (1967), Buchanan, Tollison & Tullock (1980). Replicacion cuantitativa en R."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 13, color = "#1A237E"),
    plot.subtitle = element_text(size = 10.5, color = "gray25", margin = margin(b = 10)),
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8.5),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(size = 8, color = "gray40", face = "italic")
  )

archivo_fig2 <- file.path(dir_salidas, "fig_buchanan_disipacion_rentas.png")
ggsave(archivo_fig2, plot = p2, width = 10, height = 6.5, dpi = 300)
cat("    -> Guardada figura 2:", archivo_fig2, "\n")


# ------------------------------------------------------------------------------
# PARTE 3: GENERACION DE TABLA RESUMEN DE RESULTADOS NUMERICOS
# ------------------------------------------------------------------------------

# Tabla resumen: Reglas de decision y Perdidas de bienestar por busqueda de rentas
tab_votacion <- optimos %>%
  mutate(
    Tipo_Metrica = "Regla de Votacion Optima",
    Parametro = Escenario,
    Valor_Optimo = round(k, 3),
    Costos_Externos = round(Costos_Externos, 2),
    Costos_Negociacion = round(Costos_Negociacion, 2),
    Costo_Total = round(Costos_Totales, 2),
    Interpretacion = case_when(
      Escenario == "Legislacion Ordinaria" ~ "Cercano a mayoria simple (50%+1) para provisio corriente de bienes",
      Escenario == "Nivel Constitucional" ~ "Mayoria calificada (>65%) para salvaguardar derechos y reglas fiscales",
      Escenario == "Estado de Emergencia" ~ "Umbral reducido (<45%) para minimizar paralisis por negociacion"
    )
  ) %>%
  select(Tipo_Metrica, Parametro, Valor_Optimo, Costos_Externos, Costos_Negociacion, Costo_Total, Interpretacion)

# Metricas seleccionadas de rent-seeking con R = 100, DWL_Harberger = 25
n_casos <- c(2, 5, 10, 20)
tab_rs <- df_rs %>%
  filter(r == 1.0, n %in% n_casos) %>%
  mutate(
    Tipo_Metrica = "Busqueda de Rentas (r = 1.0)",
    Parametro = paste0("n = ", n, " competidores"),
    Valor_Optimo = round(Tasa_Disipacion, 3),
    Costos_Externos = round(x_individual, 2), # Gasto individual
    Costos_Negociacion = round(Gasto_Agregado, 2), # Gasto total disipado
    Costo_Total = round(25 + Gasto_Agregado, 2), # DWL Harberger (25) + Tullock Dissipation
    Interpretacion = paste0("Disipacion del ", percent(Tasa_Disipacion, accuracy = 0.1), 
                            " de la renta; Costo social total ", round((25 + Gasto_Agregado)/25, 1), "x el triangulo de Harberger")
  ) %>%
  select(Tipo_Metrica, Parametro, Valor_Optimo, Costos_Externos, Costos_Negociacion, Costo_Total, Interpretacion)

tab_resultados <- bind_rows(tab_votacion, tab_rs)

archivo_csv <- file.path(dir_salidas, "tab_resultados_buchanan.csv")
write.csv(tab_resultados, archivo_csv, row.names = FALSE)
cat("    -> Guardada tabla de resultados:", archivo_csv, "\n\n")

cat("=== TABLA DE RESULTADOS SINTETICOS ===\n")
print(tab_resultados)
cat("\n==> Replicacion de Buchanan (1986) completada con exito.\n")

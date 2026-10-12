# ==============================================================================
# REPLICACION ILUSTRATIVA: ROBERT A. MUNDELL (PREMIO NOBEL DE ECONOMIA 1999)
# MODELOS FUNDAMENTALES:
# 1. Modelo Mundell-Fleming (IS-LM-BP) con Perfecta Movilidad de Capitales:
#    Eficacia comparada de la política monetaria y fiscal bajo tipo de cambio
#    fijo versus flexible (Mundell 1960, 1962, 1963; Fleming 1962).
# 2. El Trilema Macroeconómico (Trinidad Imposible de Mundell):
#    Geometría de compatibilidad entre estabilidad cambiaria, libre movilidad
#    de capitales y autonomía monetaria.
# ==============================================================================

suppressPackageStartupMessages({
  library(tidyverse)
  library(scales)
  library(patchwork)
})

# Fijar semilla para reproducibilidad numérica estricta
set.seed(19991013)

# ------------------------------------------------------------------------------
# 0. Gestion inteligente del directorio de salida
# ------------------------------------------------------------------------------
out_dir <- "salidas"
if (!dir.exists(out_dir)) {
  if (dir.exists("replicacion/salidas")) {
    out_dir <- "replicacion/salidas"
  } else if (dir.exists("laureados/1999_mundell/replicacion/salidas")) {
    out_dir <- "laureados/1999_mundell/replicacion/salidas"
  } else {
    dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  }
}

message("Directorio de salida: ", out_dir)

# ==============================================================================
# PARTE 1: MODELO MUNDELL-FLEMING (IS-LM-BP)
# ==============================================================================
# Especificación matemática canónica de economía abierta pequeña:
# Curva IS:  Y = C(Y - T) + I(i) + G + NX(Y, e)
#   C = c0 + c1 * (Y - T)
#   I = I0 - d * i
#   NX = X0 - m * Y + q * e
#   Despejando i en función de Y:
#   i = (A0 + G + q*e - (1 - c1*(1 - t) + m)*Y) / d
#   donde A0 = c0 - c1*T0 + I0 + X0
#
# Curva LM:  M / P = k * Y - h * i
#   Despejando i en función de Y:
#   i = (k * Y - M/P) / h
#
# Curva BP (con perfecta movilidad de capitales, CF -> Inf):
#   i = i_star  (tasa de interés internacional exógena)

# Parámetros estructurales base
c0 <- 20; c1 <- 0.75; t <- 0.20
I0 <- 30; d  <- 15
G0 <- 30; T0 <- 20
X0 <- 25; m  <- 0.15; q <- 12
e0 <- 1.0  # Tipo de cambio inicial normalizado

k_param <- 0.50
h_param <- 25
M0      <- 50
P_val   <- 1.0
i_star  <- 5.0  # Tasa internacional en % (5%)

# Propensión marginal al gasto: s = 1 - c1*(1 - t) + m = 1 - 0.75*0.8 + 0.15 = 0.55
s_param <- 1 - c1 * (1 - t) + m
A0      <- c0 - c1 * T0 + I0 + X0  # 20 - 15 + 30 + 25 = 60

# Funciones generadoras de curvas
get_is_curve <- function(Y, G_val, e_val) {
  (A0 + G_val + q * e_val - s_param * Y) / d
}

get_lm_curve <- function(Y, M_val) {
  (k_param * Y - (M_val / P_val)) / h_param
}

# Rango del producto para graficación
Y_grid <- seq(60, 220, by = 1)

# Equilibrio inicial E0 (coincidente con i = i_star):
# En equilibrio con i = i_star:
# Y_eq0 = (A0 + G0 + q*e0 - d*i_star) / s_param
# (60 + 30 + 12*1 - 15*5) / 0.55 = (102 - 75) / 0.55 = 27 / 0.55 = 49.09
# Calibremos G0 y M0 para que Y_eq0 sea redondo (ej. Y = 120, i = 5)
# Si Y0 = 120, i_star = 5:
# Requerimos s_param * 120 + d * 5 = 0.55 * 120 + 75 = 66 + 75 = 141.
# Con A0 = 60, q*e0 = 12: G0 = 141 - 72 = 69.
# Para LM: (k_param * 120 - M0) / h_param = 5 -> 60 - M0 = 125 -> M0 = -65 (no realista).
# Reajustemos escala:
# k = 0.25, h = 2.0, i = 5 -> k*120 - h*5 = 30 - 10 = 20 -> M0 = 20.

k_param <- 0.25
h_param <- 2.0
M0      <- 20
G0      <- 69

Y_eq0 <- 120
i_eq0 <- i_star

message(sprintf("Equilibrio Inicial E0: Y = %.2f, i = %.2f%%", Y_eq0, i_eq0))

# Magnitud de shocks:
delta_G <- 22  # Política Fiscal Expansiva (G pasa de 69 a 91)
delta_M <- 11  # Política Monetaria Expansiva (M pasa de 20 a 31)

# ------------------------------------------------------------------------------
# Caso 1: Politica Fiscal Expansiva con Tipo de Cambio Fijo
# Shock G -> IS se desplaza a la derecha. Transitoriamente i > i*, entran capitales.
# El Banco Central interviene comprando divisas para sostener el tipo de cambio (e fijo).
# La oferta monetaria se expande endógenamente (M_final > M0) hasta que i = i*.
# Multiplicador pleno: Y_final = (A0 + G1 + q*e0 - d*i_star) / s_param = 120 + 22/0.55 = 160.
# ------------------------------------------------------------------------------
G_c1 <- G0 + delta_G
Y_c1_final <- (A0 + G_c1 + q * e0 - d * i_star) / s_param
M_c1_final <- k_param * Y_c1_final - h_param * i_star

df_c1 <- tibble(
  Y = Y_grid,
  IS_orig = get_is_curve(Y_grid, G0, e0),
  IS_shock = get_is_curve(Y_grid, G_c1, e0),
  LM_orig = get_lm_curve(Y_grid, M0),
  LM_final = get_lm_curve(Y_grid, M_c1_final),
  BP = rep(i_star, length(Y_grid))
)

p1 <- ggplot(df_c1, aes(x = Y)) +
  geom_line(aes(y = IS_orig), color = "#1f77b4", linewidth = 0.9, linetype = "dashed") +
  geom_line(aes(y = IS_shock), color = "#1f77b4", linewidth = 1.2) +
  geom_line(aes(y = LM_orig), color = "#d62728", linewidth = 0.9, linetype = "dashed") +
  geom_line(aes(y = LM_final), color = "#d62728", linewidth = 1.2) +
  geom_line(aes(y = BP), color = "#2ca02c", linewidth = 1.1) +
  annotate("point", x = Y_eq0, y = i_eq0, size = 3, color = "black") +
  annotate("text", x = Y_eq0 - 8, y = i_eq0 - 0.7, label = "E0", fontface = "bold", size = 3.8) +
  annotate("point", x = Y_c1_final, y = i_star, size = 3.5, color = "#d62728") +
  annotate("text", x = Y_c1_final + 8, y = i_star + 0.7, label = "E1", fontface = "bold", color = "#d62728", size = 3.8) +
  annotate("segment", x = 135, y = 8.5, xend = 155, yend = 8.5,
           arrow = arrow(length = unit(0.2, "cm")), color = "#1f77b4", linewidth = 0.8) +
  annotate("text", x = 145, y = 9.4, label = "IS desplaza (+G)", color = "#1f77b4", size = 3.2, fontface = "bold") +
  annotate("segment", x = 120, y = 1.5, xend = 148, yend = 1.5,
           arrow = arrow(length = unit(0.2, "cm")), color = "#d62728", linewidth = 0.8) +
  annotate("text", x = 134, y = 0.7, label = "LM acomoda (+M)", color = "#d62728", size = 3.2, fontface = "bold") +
  scale_y_continuous(limits = c(0, 12), breaks = seq(0, 12, 2)) +
  scale_x_continuous(limits = c(70, 200)) +
  labs(
    title = "1. Política Fiscal: Tipo de Cambio Fijo",
    subtitle = "Eficacia Máxima: Multiplicador pleno (ΔY = +40.0, Δe = 0)",
    x = "Ingreso / Producto (Y)",
    y = "Tasa de Interés (%)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 11, color = "#111827"),
    plot.subtitle = element_text(size = 9.5, color = "#059669", face = "italic"),
    panel.grid.minor = element_blank()
  )

# ------------------------------------------------------------------------------
# Caso 2: Politica Monetaria Expansiva con Tipo de Cambio Fijo
# Shock M -> LM intenta desplazarse a la derecha. i < i*, salida masiva de capitales.
# Banco Central debe vender reservas para defender la paridad fija.
# M colapsa de regreso a M0. La LM regresa íntegramente a su posición original.
# Ineficacia total: Delta Y = 0.
# ------------------------------------------------------------------------------
df_c2 <- tibble(
  Y = Y_grid,
  IS_orig = get_is_curve(Y_grid, G0, e0),
  LM_orig = get_lm_curve(Y_grid, M0),
  LM_shock = get_lm_curve(Y_grid, M0 + delta_M),
  BP = rep(i_star, length(Y_grid))
)

p2 <- ggplot(df_c2, aes(x = Y)) +
  geom_line(aes(y = IS_orig), color = "#1f77b4", linewidth = 1.2) +
  geom_line(aes(y = LM_orig), color = "#d62728", linewidth = 1.2) +
  geom_line(aes(y = LM_shock), color = "#d62728", linewidth = 0.9, linetype = "dotted") +
  geom_line(aes(y = BP), color = "#2ca02c", linewidth = 1.1) +
  annotate("point", x = Y_eq0, y = i_eq0, size = 3.5, color = "black") +
  annotate("text", x = Y_eq0 - 10, y = i_eq0 + 0.8, label = "E0 = E1", fontface = "bold", size = 3.8) +
  annotate("segment", x = 125, y = 3.2, xend = 145, yend = 2.0,
           arrow = arrow(length = unit(0.2, "cm")), color = "#d62728", linewidth = 0.8) +
  annotate("segment", x = 145, y = 2.0, xend = 125, yend = 3.2,
           arrow = arrow(length = unit(0.2, "cm")), color = "#b91c1c", linewidth = 0.8, linetype = "dashed") +
  annotate("text", x = 150, y = 1.0, label = "1. Expansión inicial\n2. Fuga de reservas revierte LM",
           color = "#b91c1c", size = 3.0, fontface = "italic") +
  scale_y_continuous(limits = c(0, 12), breaks = seq(0, 12, 2)) +
  scale_x_continuous(limits = c(70, 200)) +
  labs(
    title = "2. Política Monetaria: Tipo de Cambio Fijo",
    subtitle = "Ineficacia Absoluta: Pérdida de reservas (ΔY = 0, LM retorna)",
    x = "Ingreso / Producto (Y)",
    y = "Tasa de Interés (%)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 11, color = "#111827"),
    plot.subtitle = element_text(size = 9.5, color = "#dc2626", face = "italic"),
    panel.grid.minor = element_blank()
  )

# ------------------------------------------------------------------------------
# Caso 3: Politica Fiscal Expansiva con Tipo de Cambio Flexible
# Shock G -> IS intenta desplazarse a la derecha. Transitoriamente i > i*,
# entrada masiva de capitales aprecia la moneda (e cae).
# Apreciacion reduce exportaciones netas NX(e), desplazando IS de regreso a IS0.
# Crowding-out externo total: Delta Y = 0.
# ------------------------------------------------------------------------------
e_c3_final <- e0 - (delta_G / q)  # Apreciación requerida para anular el impulso fiscal

df_c3 <- tibble(
  Y = Y_grid,
  IS_orig = get_is_curve(Y_grid, G0, e0),
  IS_shock = get_is_curve(Y_grid, G0 + delta_G, e0),
  LM_orig = get_lm_curve(Y_grid, M0),
  BP = rep(i_star, length(Y_grid))
)

p3 <- ggplot(df_c3, aes(x = Y)) +
  geom_line(aes(y = IS_orig), color = "#1f77b4", linewidth = 1.2) +
  geom_line(aes(y = IS_shock), color = "#1f77b4", linewidth = 0.9, linetype = "dotted") +
  geom_line(aes(y = LM_orig), color = "#d62728", linewidth = 1.2) +
  geom_line(aes(y = BP), color = "#2ca02c", linewidth = 1.1) +
  annotate("point", x = Y_eq0, y = i_eq0, size = 3.5, color = "black") +
  annotate("text", x = Y_eq0 - 10, y = i_eq0 + 0.8, label = "E0 = E1", fontface = "bold", size = 3.8) +
  annotate("segment", x = 135, y = 8.5, xend = 155, yend = 8.5,
           arrow = arrow(length = unit(0.2, "cm")), color = "#1f77b4", linewidth = 0.8) +
  annotate("segment", x = 155, y = 8.2, xend = 135, yend = 8.2,
           arrow = arrow(length = unit(0.2, "cm")), color = "#2563eb", linewidth = 0.8, linetype = "dashed") +
  annotate("text", x = 150, y = 9.8, label = "1. Impulso fiscal (+G)\n2. Apreciación cambiaria destruye NX",
           color = "#1d4ed8", size = 3.0, fontface = "italic") +
  scale_y_continuous(limits = c(0, 12), breaks = seq(0, 12, 2)) +
  scale_x_continuous(limits = c(70, 200)) +
  labs(
    title = "3. Política Fiscal: Tipo de Cambio Flexible",
    subtitle = "Ineficacia Absoluta: Apreciación cambiaria expulsa NX (ΔY = 0)",
    x = "Ingreso / Producto (Y)",
    y = "Tasa de Interés (%)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 11, color = "#111827"),
    plot.subtitle = element_text(size = 9.5, color = "#dc2626", face = "italic"),
    panel.grid.minor = element_blank()
  )

# ------------------------------------------------------------------------------
# Caso 4: Politica Monetaria Expansiva con Tipo de Cambio Flexible
# Shock M -> LM se desplaza a la derecha. Transitoriamente i < i*,
# fuga de capitales deprecia la moneda nacional (e sube).
# Depreciación estimula exportaciones netas NX(e), empujando IS a la derecha.
# Eficacia máxima: Delta Y = Delta M / k.
# ------------------------------------------------------------------------------
M_c4 <- M0 + delta_M
Y_c4_final <- (M_c4 + h_param * i_star) / k_param  # 164
delta_Y_c4 <- Y_c4_final - Y_eq0
# Depreciación requerida en IS para alcanzar Y_c4_final:
e_c4_final <- e0 + (s_param * delta_Y_c4) / q

df_c4 <- tibble(
  Y = Y_grid,
  IS_orig = get_is_curve(Y_grid, G0, e0),
  IS_final = get_is_curve(Y_grid, G0, e_c4_final),
  LM_orig = get_lm_curve(Y_grid, M0),
  LM_shock = get_lm_curve(Y_grid, M_c4),
  BP = rep(i_star, length(Y_grid))
)

p4 <- ggplot(df_c4, aes(x = Y)) +
  geom_line(aes(y = IS_orig), color = "#1f77b4", linewidth = 0.9, linetype = "dashed") +
  geom_line(aes(y = IS_final), color = "#1f77b4", linewidth = 1.2) +
  geom_line(aes(y = LM_orig), color = "#d62728", linewidth = 0.9, linetype = "dashed") +
  geom_line(aes(y = LM_shock), color = "#d62728", linewidth = 1.2) +
  geom_line(aes(y = BP), color = "#2ca02c", linewidth = 1.1) +
  annotate("point", x = Y_eq0, y = i_eq0, size = 3, color = "black") +
  annotate("text", x = Y_eq0 - 8, y = i_eq0 - 0.7, label = "E0", fontface = "bold", size = 3.8) +
  annotate("point", x = Y_c4_final, y = i_star, size = 3.5, color = "#059669") +
  annotate("text", x = Y_c4_final + 8, y = i_star + 0.7, label = "E1", fontface = "bold", color = "#059669", size = 3.8) +
  annotate("segment", x = 115, y = 1.5, xend = 145, yend = 1.5,
           arrow = arrow(length = unit(0.2, "cm")), color = "#d62728", linewidth = 0.8) +
  annotate("text", x = 130, y = 0.7, label = "LM desplaza (+M)", color = "#d62728", size = 3.2, fontface = "bold") +
  annotate("segment", x = 135, y = 8.5, xend = 158, yend = 8.5,
           arrow = arrow(length = unit(0.2, "cm")), color = "#1f77b4", linewidth = 0.8) +
  annotate("text", x = 148, y = 9.4, label = "IS desplaza (depreciación +NX)", color = "#1f77b4", size = 3.2, fontface = "bold") +
  scale_y_continuous(limits = c(0, 12), breaks = seq(0, 12, 2)) +
  scale_x_continuous(limits = c(70, 200)) +
  labs(
    title = "4. Política Monetaria: Tipo de Cambio Flexible",
    subtitle = "Eficacia Máxima: Depreciación cambiaria impulsa NX (ΔY = +44.0)",
    x = "Ingreso / Producto (Y)",
    y = "Tasa de Interés (%)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 11, color = "#111827"),
    plot.subtitle = element_text(size = 9.5, color = "#059669", face = "italic"),
    panel.grid.minor = element_blank()
  )

# Ensamble de los 4 cuadrantes con patchwork
fig_politicas <- (p1 + p2) / (p3 + p4) +
  plot_annotation(
    title = "Modelo Mundell-Fleming: Eficacia de Políticas bajo Movilidad Perfecta de Capitales",
    subtitle = "Premio Nobel de Economía 1999 — Robert A. Mundell | Simulación comparativa en economía abierta pequeña",
    caption = "Líneas: Azul = IS, Roja = LM, Verde = BP (i = i* = 5%). Fuente: Elaboración propia según Mundell (1963).",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14, color = "#0f172a"),
      plot.subtitle = element_text(size = 11, color = "#475569", margin = margin(b = 10)),
      plot.caption = element_text(size = 9, color = "#64748b", face = "italic")
    )
  )

file_fig_politicas <- file.path(out_dir, "fig_mundell_fleming_politicas.png")
ggsave(file_fig_politicas, plot = fig_politicas, width = 11, height = 8.5, dpi = 300)
message("Guardada figura de políticas: ", file_fig_politicas)

# ==============================================================================
# PARTE 2: EL TRILEMA MACROECONÓMICO (TRINIDAD IMPOSIBLE DE MUNDELL)
# ==============================================================================
# Geometría del Trilema en coordenadas cartesianas:
# Vértice A (Arriba): Libre Movilidad de Capitales (x = 0, y = 1)
# Vértice B (Abajo-Izq): Tipo de Cambio Fijo (x = -0.866, y = -0.5)
# Vértice C (Abajo-Der): Autonomía de la Política Monetaria (x = 0.866, y = -0.5)

vertices <- tibble(
  vertice = c("Libre Movilidad\nde Capitales", "Tipo de Cambio\nFijo", "Autonomía de la\nPolítica Monetaria"),
  x = c(0, -1.0, 1.0),
  y = c(1.0, -0.6, -0.6),
  color = c("#0284c7", "#059669", "#7c3aed")
)

lados <- tibble(
  regimen = c(
    "LADO 1: UNIÓN MONETARIA / CAJA DE CONVERSIÓN\n• Libre Movilidad + TC Fijo\n• Renuncia a Política Monetaria\nEjemplos: Eurozona (1999-hoy), Hong Kong (1983-hoy),\nArgentina (Convertibilidad 1991-2001)",
    "LADO 2: CONTROLES DE CAPITAL\n• TC Fijo + Autonomía Monetaria\n• Cierre de la Cuenta Financiera\nEjemplos: Bretton Woods (1944-1971),\nChina (1980-2015), Malasia (1998)",
    "LADO 3: METAS DE INFLACIÓN CON FLOTACIÓN\n• Libre Movilidad + Autonomía Monetaria\n• Tipo de Cambio Flexible\nEjemplos: Reserva Federal, BCE, Banco de Inglaterra,\nChile, Colombia, México, Perú"
  ),
  x_mid = c(-0.62, 0, 0.62),
  y_mid = c(0.28, -0.85, 0.28),
  color_regimen = c("#0369a1", "#047857", "#6d28d9")
)

triangle_df <- tibble(
  x = c(0, -1.0, 1.0, 0),
  y = c(1.0, -0.6, -0.6, 1.0)
)

fig_trilema <- ggplot() +
  # Área interna prohibida
  geom_polygon(data = triangle_df, aes(x = x, y = y), fill = "#f8fafc", color = "#94a3b8", linewidth = 1.5) +
  # Sombreado de incompatibilidad central
  annotate("polygon", x = c(0, -0.4, 0.4), y = c(0.4, -0.2, -0.2), fill = "#fee2e2", alpha = 0.6) +
  annotate("text", x = 0, y = 0.05,
           label = "ZONA IMPOSIBLE\n(Trinidad Inconsistente)\nNingún país puede situarse\nen los 3 vértices a la vez",
           color = "#b91c1c", fontface = "bold", size = 3.6, hjust = 0.5) +
  # Vértices con círculos
  geom_point(data = vertices, aes(x = x, y = y), size = 16, color = vertices$color) +
  geom_point(data = vertices, aes(x = x, y = y), size = 13, color = "white") +
  geom_point(data = vertices, aes(x = x, y = y), size = 10, color = vertices$color) +
  # Texto en vértices
  annotate("text", x = 0, y = 1.25, label = "1. INTEGRACIÓN FINANCIERA\n(Libre Movilidad de Capitales)",
           fontface = "bold", size = 4.2, color = "#0369a1", hjust = 0.5) +
  annotate("text", x = -1.15, y = -0.78, label = "2. ESTABILIDAD CAMBIARIA\n(Tipo de Cambio Fijo)",
           fontface = "bold", size = 4.0, color = "#047857", hjust = 0.5) +
  annotate("text", x = 1.15, y = -0.78, label = "3. AUTONOMÍA MONETARIA\n(Política Nacional Propia)",
           fontface = "bold", size = 4.0, color = "#6d28d9", hjust = 0.5) +
  # Cajas de los 3 regímenes
  annotate("label", x = -0.75, y = 0.28, label = lados$regimen[1],
           fill = "#f0f9ff", color = "#0369a1", fontface = "bold", size = 3.1,
           label.padding = unit(0.4, "lines"), linewidth = 0.6) +
  annotate("label", x = 0, y = -0.92, label = lados$regimen[2],
           fill = "#ecfdf5", color = "#047857", fontface = "bold", size = 3.1,
           label.padding = unit(0.4, "lines"), linewidth = 0.6) +
  annotate("label", x = 0.75, y = 0.28, label = lados$regimen[3],
           fill = "#f5f3ff", color = "#6d28d9", fontface = "bold", size = 3.1,
           label.padding = unit(0.4, "lines"), linewidth = 0.6) +
  coord_fixed(ratio = 1, xlim = c(-1.6, 1.6), ylim = c(-1.15, 1.45)) +
  labs(
    title = "La Trinidad Imposible o Trilema Macroeconómico de Mundell",
    subtitle = "Una economía abierta solo puede escoger dos de las tres esquinas del triángulo (Robert A. Mundell, 1963)",
    caption = "Base conceptual: Mundell (1963), Obstfeld & Taylor (2004). Nobel de Economía 1999."
  ) +
  theme_void(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 15, color = "#0f172a", hjust = 0.5, margin = margin(t = 10, b = 4)),
    plot.subtitle = element_text(size = 11, color = "#475569", hjust = 0.5, margin = margin(b = 15)),
    plot.caption = element_text(size = 9, color = "#64748b", face = "italic", hjust = 0.5, margin = margin(t = 15, b = 10)),
    plot.background = element_rect(fill = "white", color = NA)
  )

file_fig_trilema <- file.path(out_dir, "fig_mundell_trilema_monetario.png")
ggsave(file_fig_trilema, plot = fig_trilema, width = 11, height = 8.5, dpi = 300)
message("Guardada figura del trilema: ", file_fig_trilema)

# ==============================================================================
# PARTE 3: TABLA RESUMEN DE RESULTADOS CUANTITATIVOS
# ==============================================================================
tab_resultados <- tibble(
  regimen_cambiario = c("Tipo de Cambio Fijo", "Tipo de Cambio Fijo", "Tipo de Cambio Flexible", "Tipo de Cambio Flexible"),
  politica = c("Fiscal Expansiva (+G)", "Monetaria Expansiva (+M)", "Fiscal Expansiva (+G)", "Monetaria Expansiva (+M)"),
  shock_nominal = c(sprintf("+%.1f (G)", delta_G), sprintf("+%.1f (M)", delta_M), sprintf("+%.1f (G)", delta_G), sprintf("+%.1f (M)", delta_M)),
  efecto_producto = c(sprintf("+%.1f", Y_c1_final - Y_eq0), "0.0", "0.0", sprintf("+%.1f", delta_Y_c4)),
  efecto_tasa_interes = c("0.0 (anclada a i*)", "0.0 (anclada a i*)", "0.0 (anclada a i*)", "0.0 (anclada a i*)"),
  efecto_tipo_cambio = c("0.0 (fijo)", "0.0 (fijo)", sprintf("%.3f (apreciación)", e_c3_final - e0), sprintf("+%.3f (depreciación)", e_c4_final - e0)),
  mecanismo_ajuste = c(
    "Entrada de capitales fuerza expansión monetaria endógena (ΔM = +10.0)",
    "Fuga de capitales drena reservas internacionales hasta revertir la oferta de dinero",
    "Entrada de capitales aprecia la moneda, destruyendo exportaciones netas (crowding-out externo)",
    "Salida de capitales deprecia la moneda, estimulando exportaciones netas y producción"
  ),
  eficacia_relativa = c("Máxima", "Nula", "Nula", "Máxima")
)

file_tab_resultados <- file.path(out_dir, "tab_resultados_mundell.csv")
write_csv(tab_resultados, file_tab_resultados)
message("Guardada tabla cuantitativa: ", file_tab_resultados)

message("Replicación Mundell completada exitosamente.")

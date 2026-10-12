# ==============================================================================
# Premio Nobel de Economia 1983: Gerard Debreu
# Script de Replicacion: Equilibrio General Competitivo y Teorema del Nucleo
#
# Autor: Repositorio Nobel Economics
# Fecha: Octubre 1983 / Edicion Reproducible 2026
# Descripcion:
#   1. Modela una economia de intercambio puro en la Caja de Edgeworth con
#      dos consumidores y preferencias Cobb-Douglas diferenciadas.
#   2. Resuelve el equilibrio general competitivo Arrow-Debreu (1954),
#      la curva de contrato y el segmento del nucleo (Core) para N = 1.
#   3. Implementa el Teorema de Debreu-Scarf (1963): convergencia del nucleo
#      hacia el equilibrio walrasiano en economias replicadas (N = 1, 2, 5, 20, 50).
#   4. Genera figuras en alta resolucion y tabla de resultados en 'salidas/'.
# ==============================================================================

# 0. Cargar librerias requeridas ------------------------------------------------
suppressPackageStartupMessages({
  library(ggplot2)
  library(patchwork)
  library(dplyr)
  library(tibble)
  library(readr)
  library(scales)
})

# Definir directorios de trabajo y salida
args <- commandArgs(trailingOnly = FALSE)
script_dir <- tryCatch({
  needle <- "--file="
  match <- grep(needle, args)
  if (length(match) > 0) {
    dirname(normalizePath(sub(needle, "", args[match])))
  } else {
    getwd()
  }
}, error = function(e) getwd())

# Directorio de salidas relativo a la raiz o a este script
salidas_dir <- file.path(script_dir, "..", "salidas")
if (!dir.exists(salidas_dir)) {
  salidas_dir <- file.path(getwd(), "laureados", "1983_debreu", "replicacion", "salidas")
}
dir.create(salidas_dir, recursive = TRUE, showWarnings = FALSE)

cat(sprintf("==> Guardando salidas en: %s\n", normalizePath(salidas_dir)))

# 1. Parametrizacion del Modelo Economico ---------------------------------------
# Dotaciones iniciales de recursos
wA <- c(x1 = 8.0, x2 = 2.0)  # Consumidor A: rico en bien 1, escaso en bien 2
wB <- c(x1 = 2.0, x2 = 8.0)  # Consumidor B: escaso en bien 1, rico en bien 2
W_tot <- wA + wB             # Dotacion total: (10, 10)

# Parametros de utilidad Cobb-Douglas:
# U_A(x1A, x2A) = x1A^alpha * x2A^(1 - alpha)
# U_B(x1B, x2B) = x1B^beta  * x2B^(1 - beta)
alpha <- 0.6  # Consumidor A valora relativamente mas el bien 1
beta  <- 0.4  # Consumidor B valora relativamente mas el bien 2

uA <- function(x1, x2) (x1^alpha) * (x2^(1 - alpha))
uB <- function(x1, x2) (x1^beta)  * (x2^(1 - beta))

# Utilidades en la dotacion inicial
uA_endow <- uA(wA["x1"], wA["x2"])
uB_endow <- uB(wB["x1"], wB["x2"])

# 2. Equilibrio Competitivo Arrow-Debreu -----------------------------------------
# Resolucion analitica:
# Renta de A: I_A = p1*8 + p2*2. Demanda x1A = alpha * I_A / p1 = 4.8 + 1.2 * (p2/p1)
# Renta de B: I_B = p1*2 + p2*8. Demanda x1B = beta  * I_B / p1 = 0.8 + 3.2 * (p2/p1)
# Vaciado de mercado bien 1: x1A + x1B = 10 => 5.6 + 4.4*(p2/p1) = 10 => p2/p1 = 1.0
p_rel <- 1.0  # Precio relativo de equilibrio: p1* / p2* = 1.0
xA_star <- c(x1 = 6.0, x2 = 4.0)
xB_star <- c(x1 = 4.0, x2 = 6.0)

uA_star <- uA(xA_star["x1"], xA_star["x2"])
uB_star <- uB(xB_star["x1"], xB_star["x2"])

cat(sprintf("Equilibrio Walrasiano: p1/p2 = %.2f | xA* = (%.2f, %.2f) | xB* = (%.2f, %.2f)\n",
            p_rel, xA_star["x1"], xA_star["x2"], xB_star["x1"], xB_star["x2"]))
cat(sprintf("Utilidades en equilibrio: UA* = %.4f | UB* = %.4f\n", uA_star, uB_star))
cat(sprintf("Utilidades en dotacion:   UA0 = %.4f | UB0 = %.4f\n", uA_endow, uB_endow))

# 3. Curva de Contrato Analitica ------------------------------------------------
# Relacion Marginal de Sustitucion:
# RMS_A = (alpha / (1-alpha)) * (x2A / x1A) = 1.5 * (x2A / x1A)
# RMS_B = (beta / (1-beta))   * (x2B / x1B) = (2/3) * (10 - x2A) / (10 - x1A)
# RMS_A = RMS_B => 1.5 * (x2A / x1A) = (2/3) * (10 - x2A) / (10 - x1A)
# Formula explicita de la curva de contrato: x2A = 8 * x1A / (18 - x1A)
cc_x2 <- function(x1) 8.0 * x1 / (18.0 - x1)

# Puntos de la curva de contrato
grid_cc <- seq(0, 10, length.out = 300)
df_cc <- tibble(
  x1 = grid_cc,
  x2 = cc_x2(grid_cc)
)

# 4. Algoritmo del Teorema de Debreu-Scarf (Nucleo en Economias Replicadas) ------
# Verificacion si una asignacion sobre la curva de contrato puede ser bloqueada
# por una coalicion (Sa, Sb) con Sa agentes tipo A y Sb agentes tipo B
is_blocked_coalition <- function(x1, Sa, Sb) {
  x2 <- cc_x2(x1)
  t_uA <- uA(x1, x2)
  t_uB <- uB(W_tot["x1"] - x1, W_tot["x2"] - x2)
  
  if (Sa == 0 && Sb > 0) return(uB_endow > t_uB + 1e-7)
  if (Sb == 0 && Sa > 0) return(uA_endow > t_uA + 1e-7)
  if (Sa == Sb) return(FALSE)
  
  rho <- Sb / Sa
  # Coalicion puede bloquear si existe yB tal que UB(yB) >= t_uB
  # y UA(wA + rho * (wB - yB)) > t_uA
  opt_fun <- function(yB1) {
    if (yB1 <= 0.001) return(-1e9)
    yB2 <- (t_uB / (yB1^beta))^(1.0 / (1.0 - beta))
    yA1 <- wA["x1"] + rho * (wB["x1"] - yB1)
    yA2 <- wA["x2"] + rho * (wB["x2"] - yB2)
    if (yA1 <= 0.001 || yA2 <= 0.001) return(-1e9)
    uA(yA1, yA2)
  }
  
  ub_yB1 <- min(wB["x1"] + wA["x1"] / rho - 0.01, 9.99)
  if (ub_yB1 <= 0.05) return(FALSE)
  res <- optimize(opt_fun, interval = c(0.05, ub_yB1), maximum = TRUE)
  return(res$objective > t_uA + 1e-6)
}

# Calculo de los limites del nucleo para replica de tamano N
get_core_bounds <- function(N) {
  if (is.infinite(N)) {
    return(c(min = unname(xA_star["x1"]), max = unname(xA_star["x1"])))
  }
  
  # Generar combinaciones criticas de coaliciones segun Debreu-Scarf (1963)
  coalitions <- list(c(1, 0), c(0, 1))
  if (N >= 2) {
    for (s in 1:(N - 1)) {
      coalitions[[length(coalitions) + 1]] <- c(N, s)
      coalitions[[length(coalitions) + 1]] <- c(s, N)
    }
  }
  
  is_blocked <- function(x1) {
    for (c in coalitions) {
      if (is_blocked_coalition(x1, c[1], c[2])) return(TRUE)
    }
    return(FALSE)
  }
  
  # Busqueda dicotomica para limite inferior
  low <- 5.4939
  high <- 6.0
  for (iter in 1:28) {
    mid <- (low + high) / 2
    if (is_blocked(mid)) low <- mid else high <- mid
  }
  x1_min <- high
  
  # Busqueda dicotomica para limite superior
  low <- 6.0
  high <- 6.4856
  for (iter in 1:28) {
    mid <- (low + high) / 2
    if (is_blocked(mid)) high <- mid else low <- mid
  }
  x1_max <- low
  
  return(c(min = unname(x1_min), max = unname(x1_max)))
}

# Replicar para N = 1, 2, 3, 5, 10, 20, 50 y Limite (Infinito)
N_values <- c(1, 2, 3, 5, 10, 20, 50, Inf)
res_nucleo <- list()

for (n in N_values) {
  b <- get_core_bounds(n)
  x1_lo <- b["min"]
  x1_hi <- b["max"]
  x2_lo <- cc_x2(x1_lo)
  x2_hi <- cc_x2(x1_hi)
  
  ua_lo <- uA(x1_lo, x2_lo)
  ua_hi <- uA(x1_hi, x2_hi)
  ub_lo <- uB(W_tot["x1"] - x1_hi, W_tot["x2"] - x2_hi)
  ub_hi <- uB(W_tot["x1"] - x1_lo, W_tot["x2"] - x2_lo)
  width <- x1_hi - x1_lo
  
  res_nucleo[[length(res_nucleo) + 1]] <- tibble(
    N_replica = if (is.infinite(n)) "Inf (Limite)" else as.character(n),
    N_num = n,
    total_agentes = if (is.infinite(n)) "Infinito" else as.character(2 * n),
    x1A_min = round(x1_lo, 4),
    x1A_max = round(x1_hi, 4),
    ancho_nucleo = round(width, 4),
    x2A_min = round(x2_lo, 4),
    x2A_max = round(x2_hi, 4),
    utilidad_A_min = round(ua_lo, 4),
    utilidad_A_max = round(ua_hi, 4),
    utilidad_B_min = round(ub_lo, 4),
    utilidad_B_max = round(ub_hi, 4)
  )
}

df_resultados <- bind_rows(res_nucleo)
ancho_inicial <- df_resultados$ancho_nucleo[1]
df_resultados <- df_resultados %>%
  mutate(
    reduccion_ancho_pct = round((1 - ancho_nucleo / ancho_inicial) * 100, 2)
  )

# Guardar tabla CSV
csv_path <- file.path(salidas_dir, "tab_resultados_debreu.csv")
write_csv(df_resultados, csv_path)
cat(sprintf("==> Tabla exportada: %s\n", normalizePath(csv_path)))

# 5. Visualizacion 1: Caja de Edgeworth y Equilibrio Arrow-Debreu --------------
# Mallas de curvas de indiferencia
x1_grid <- seq(0.1, 9.9, length.out = 200)

# Curvas de A:
# x2A = (U / x1A^alpha)^(1 / (1 - alpha))
ic_A <- function(U, x1) (U / (x1^alpha))^(1.0 / (1.0 - alpha))
# Curvas de B medidas desde origen B (10, 10):
# UB(10 - x1, 10 - x2) = U => 10 - x2 = (U / (10 - x1)^beta)^(1 / (1 - beta))
# => x2 = 10 - (U / (10 - x1)^beta)^(1 / (1 - beta))
ic_B <- function(U, x1) 10.0 - (U / ((10.0 - x1)^beta))^(1.0 / (1.0 - beta))

df_ic_A_endow <- tibble(x1 = x1_grid) %>%
  mutate(x2 = ic_A(uA_endow, x1)) %>%
  filter(x2 >= 0 & x2 <= 10)

df_ic_A_star <- tibble(x1 = x1_grid) %>%
  mutate(x2 = ic_A(uA_star, x1)) %>%
  filter(x2 >= 0 & x2 <= 10)

df_ic_B_endow <- tibble(x1 = x1_grid) %>%
  mutate(x2 = ic_B(uB_endow, x1)) %>%
  filter(x2 >= 0 & x2 <= 10)

df_ic_B_star <- tibble(x1 = x1_grid) %>%
  mutate(x2 = ic_B(uB_star, x1)) %>%
  filter(x2 >= 0 & x2 <= 10)

# Segmento del nucleo para N = 1
n1_bounds <- get_core_bounds(1)
grid_core_n1 <- seq(n1_bounds["min"], n1_bounds["max"], length.out = 100)
df_core_n1 <- tibble(
  x1 = grid_core_n1,
  x2 = cc_x2(grid_core_n1)
)

# Recta de presupuesto walrasiana: pasa por w = (8,2) con pendiente -1
df_presupuesto <- tibble(
  x1 = seq(0, 10, length.out = 100),
  x2 = 10 - seq(0, 10, length.out = 100)
)

# Construir Grafico de Caja de Edgeworth
p1 <- ggplot() +
  # Marco de la caja
  annotate("rect", xmin = 0, xmax = 10, ymin = 0, ymax = 10, 
           fill = "#FAFAFA", color = "#2B2D42", linewidth = 1.0) +
  # Curva de Contrato completa
  geom_line(data = df_cc, aes(x = x1, y = x2), 
            color = "#7209B7", linewidth = 1.2, linetype = "solid") +
  # Segmento del Nucleo N = 1 (Grueso y destacado)
  geom_line(data = df_core_n1, aes(x = x1, y = x2), 
            color = "#06D6A0", linewidth = 3.5, alpha = 0.85) +
  # Recta de precios walrasianos
  geom_line(data = df_presupuesto, aes(x = x1, y = x2), 
            color = "#4A4E69", linewidth = 0.9, linetype = "dashed") +
  # Curvas de indiferencia de A
  geom_line(data = df_ic_A_endow, aes(x = x1, y = x2), 
            color = "#3A86FF", linewidth = 0.9, linetype = "dotdash") +
  geom_line(data = df_ic_A_star, aes(x = x1, y = x2), 
            color = "#3A86FF", linewidth = 1.2) +
  # Curvas de indiferencia de B
  geom_line(data = df_ic_B_endow, aes(x = x1, y = x2), 
            color = "#E63946", linewidth = 0.9, linetype = "dotdash") +
  geom_line(data = df_ic_B_star, aes(x = x1, y = x2), 
            color = "#E63946", linewidth = 1.2) +
  # Puntos clave: Dotacion inicial omega y Equilibrio W*
  geom_point(aes(x = wA["x1"], y = wA["x2"]), 
             color = "#E76F51", size = 4.5, shape = 19) +
  geom_point(aes(x = xA_star["x1"], y = xA_star["x2"]), 
             color = "#1D3557", size = 5.0, shape = 18) +
  # Anotaciones
  annotate("text", x = wA["x1"] + 0.35, y = wA["x2"] - 0.35, 
           label = expression(bold(omega) == "(8, 2)"), 
           color = "#E76F51", fontface = "bold", size = 4.2) +
  annotate("text", x = xA_star["x1"] - 0.45, y = xA_star["x2"] + 0.55, 
           label = expression(bold(W)^"*" == "(6, 4)"), 
           color = "#1D3557", fontface = "bold", size = 4.5) +
  annotate("text", x = 3.2, y = 1.8, 
           label = "Curva de Contrato", color = "#7209B7", fontface = "bold.italic", size = 3.8) +
  annotate("text", x = 6.2, y = 3.3, 
           label = "Núcleo C(E) (N = 1)", color = "#087E5B", fontface = "bold", size = 3.8) +
  annotate("text", x = 1.8, y = 8.8, 
           label = "Recta presupuestaria (p1/p2 = 1.0)", color = "#4A4E69", size = 3.4, angle = -45) +
  # Etiquetas de esquinas (Origenes)
  annotate("text", x = 0.3, y = 0.4, label = "O[A]", parse = TRUE, fontface = "bold", size = 5) +
  annotate("text", x = 9.7, y = 9.6, label = "O[B]", parse = TRUE, fontface = "bold", size = 5) +
  scale_x_continuous(limits = c(0, 10), breaks = seq(0, 10, by = 2), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 10), breaks = seq(0, 10, by = 2), expand = c(0, 0)) +
  labs(
    title = "Caja de Edgeworth y Equilibrio Competitivo Arrow-Debreu (1954)",
    subtitle = "Tangencia de curvas de indiferencia, dotación inicial y Núcleo de la economía para N = 1",
    x = expression("Cantidad del Bien 1 para el Consumidor A (" * x[1*A] * ")"),
    y = expression("Cantidad del Bien 2 para el Consumidor A (" * x[2*A] * ")"),
    caption = "Elaborado para Nobel_economics. Preferencias: UA = x1^0.6 x2^0.4, UB = x1^0.4 x2^0.6."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#1D3557"),
    plot.subtitle = element_text(size = 10.5, color = "#4A4E69", margin = margin(b = 10)),
    plot.caption = element_text(size = 9, color = "#6C757D", margin = margin(t = 10)),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "#2B2D42", fill = NA, linewidth = 0.8)
  )

fig1_path <- file.path(salidas_dir, "fig_debreu_caja_edgeworth.png")
ggsave(fig1_path, plot = p1, width = 8.5, height = 7.5, dpi = 300)
cat(sprintf("==> Figura 1 exportada: %s\n", normalizePath(fig1_path)))

# 6. Visualizacion 2: Convergencia del Nucleo (Debreu & Scarf 1963) ------------
# Segmentos del nucleo para N = 1, 2, 5, 20
df_cores_comp <- bind_rows(
  lapply(c(1, 2, 5, 20), function(n) {
    b <- get_core_bounds(n)
    grid_x <- seq(b["min"], b["max"], length.out = 60)
    tibble(
      N = paste0("N = ", n),
      N_val = n,
      x1 = grid_x,
      x2 = cc_x2(grid_x)
    )
  })
)

df_cores_comp$N <- factor(df_cores_comp$N, levels = c("N = 1", "N = 2", "N = 5", "N = 20"))

# Panel A: Zoom del nucleo sobre la curva de contrato
p2a <- ggplot() +
  # Curva de contrato de fondo
  geom_line(data = df_cc %>% filter(x1 >= 5.2 & x1 <= 6.8), 
            aes(x = x1, y = x2), color = "#C77DFF", linewidth = 1.0, linetype = "dotted") +
  # Segmentos del nucleo superpuestos por nivel de N
  geom_line(data = df_cores_comp, aes(x = x1, y = x2, color = N), 
            linewidth = 3.2, alpha = 0.85) +
  # Punto de equilibrio walrasiano
  geom_point(aes(x = 6.0, y = 4.0), color = "#1D3557", size = 4.5, shape = 18) +
  annotate("text", x = 6.0, y = 4.15, label = "W* (Equilibrio Walrasiano)", 
           fontface = "bold", size = 3.8, color = "#1D3557") +
  scale_color_manual(
    name = "Réplica (N):",
    values = c("N = 1" = "#06D6A0", "N = 2" = "#FFD166", "N = 5" = "#F77F00", "N = 20" = "#D62828")
  ) +
  labs(
    title = "A. Contracción del Núcleo sobre la Curva de Contrato",
    subtitle = "A medida que N se expande, las coaliciones bloqueantes reducen el núcleo",
    x = expression("Asignación de Bien 1 a Consumidor A (" * x[1*A] * ")"),
    y = expression("Asignación de Bien 2 a Consumidor A (" * x[2*A] * ")")
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 12, color = "#1D3557"),
    plot.subtitle = element_text(size = 9.5, color = "#4A4E69"),
    panel.grid.minor = element_blank()
  )

# Panel B: Tasa de convergencia del ancho del nucleo vs N
df_conv_curve <- df_resultados %>%
  filter(!is.infinite(N_num)) %>%
  mutate(
    ancho_teorico = ancho_inicial / N_num
  )

p2b <- ggplot(df_conv_curve, aes(x = N_num, y = ancho_nucleo)) +
  geom_line(color = "#1D3557", linewidth = 1.2) +
  geom_point(color = "#E63946", size = 3.5) +
  # Linea teorica O(1/N)
  geom_line(aes(y = ancho_teorico), color = "#6C757D", linetype = "dashed", linewidth = 0.9) +
  geom_text(aes(label = sprintf("%.3f", ancho_nucleo)), 
            vjust = -0.9, size = 3.2, fontface = "bold") +
  scale_x_continuous(breaks = c(1, 2, 3, 5, 10, 20, 50)) +
  scale_y_continuous(limits = c(0, 1.15), breaks = seq(0, 1.2, by = 0.2)) +
  annotate("text", x = 25, y = 0.40, 
           label = "Convergencia O(1/N)\nDebreu & Scarf (1963)", 
           color = "#4A4E69", fontface = "italic", size = 3.6) +
  labs(
    title = "B. Tasa de Convergencia hacia el Equilibrio Único",
    subtitle = "Longitud del Núcleo vs Tamaño de Réplica N (Límite: Amplitud -> 0)",
    x = "Número de Réplicas (N)",
    y = expression("Longitud del Núcleo (" * Delta * x[1*A] * ")")
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12, color = "#1D3557"),
    plot.subtitle = element_text(size = 9.5, color = "#4A4E69"),
    panel.grid.minor = element_blank()
  )

p2_combo <- p2a / p2b +
  plot_annotation(
    title = "Teorema de Equivalencia del Núcleo: Debreu & Scarf (1963)",
    subtitle = "Demostración de que la competencia perfecta emerge como el límite no cooperativo de coaliciones",
    caption = "Elaborado para Nobel_economics. N representa el número de consumidores de cada tipo en la economía.",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14, color = "#1D3557"),
      plot.subtitle = element_text(size = 11, color = "#4A4E69"),
      plot.caption = element_text(size = 9, color = "#6C757D")
    )
  )

fig2_path <- file.path(salidas_dir, "fig_debreu_convergencia_nucleo.png")
ggsave(fig2_path, plot = p2_combo, width = 8.5, height = 9.5, dpi = 300)
cat(sprintf("==> Figura 2 exportada: %s\n", normalizePath(fig2_path)))

cat("\n==============================================================================\n")
cat("Replicacion completada con exito para Gerard Debreu (Premio Nobel 1983).\n")
cat("==============================================================================\n")

# ==============================================================================
# Premio Nobel de Economia 1975: Leonid V. Kantorovich y Tjalling C. Koopmans
# Replicacion: Programacion Lineal, Analisis de Actividades y Precios Sombra
# Autor: Coleccion Nobel de Economia
# ==============================================================================

# Cargar librerias necesarias
suppressPackageStartupMessages({
  library(lpSolve)
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(readr)
})

# Fijar semilla para reproducibilidad
set.seed(1975)

# Directorio de salida
dir_salidas <- "laureados/1975_kantorovich_koopmans/replicacion/salidas"
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

message("=== Iniciando modelo de optimizacion Kantorovich-Koopmans (1975) ===")

# ------------------------------------------------------------------------------
# 1. DEFINICION DEL MODELO DE ASIGNACION OPTIMA MULTI-SECTORIAL
# ------------------------------------------------------------------------------
# Dos bienes finales / actividades productivas:
#   x1: Maquinaria y Bienes de Capital (precio unitario o valor social c1 = 40)
#   x2: Bienes de Consumo y Manufacturas (precio unitario o valor social c2 = 30)
#
# Tres recursos productivos escasos:
#   1. Trabajo calificado (L):  2*x1 + 1*x2 <= 1000 horas
#   2. Capacidad de Capital (K): 1*x1 + 2*x2 <= 800 horas-maquina
#   3. Energia / Combustible (E): 1*x1 + 1*x2 <= 700 MWh

c_obj <- c(40, 30)

A_mat <- matrix(c(
  2, 1,   # Trabajo
  1, 2,   # Capital
  1, 1    # Energia
), nrow = 3, byrow = TRUE)

dir_mat <- c("<=", "<=", "<=")
b_vec_base <- c(1000, 800, 700)
nombres_recursos <- c("Trabajo (L)", "Capital (K)", "Energia (E)")

# ------------------------------------------------------------------------------
# 2. RESOLUCION DEL PRIMAL Y DUAL (CASO BASE)
# ------------------------------------------------------------------------------
res_primal <- lp(
  direction = "max",
  objective.in = c_obj,
  const.mat = A_mat,
  const.dir = dir_mat,
  const.rhs = b_vec_base,
  compute.sens = TRUE
)

x_opt <- res_primal$solution
Z_opt <- res_primal$objval
holguras <- b_vec_base - (A_mat %*% x_opt)
precios_sombra <- res_primal$duals[1:3]

cat(sprintf("Solucion Primal Optima:\n"))
cat(sprintf("  x1* (Bienes de Capital) = %.2f unidades\n", x_opt[1]))
cat(sprintf("  x2* (Bienes de Consumo) = %.2f unidades\n", x_opt[2]))
cat(sprintf("  Valor Objetivo Z*       = %.2f unidades monetarias\n\n", Z_opt))

cat(sprintf("Uso de Recursos y Holguras (Slacks):\n"))
for (i in 1:3) {
  uso_i <- sum(A_mat[i, ] * x_opt)
  cat(sprintf("  Recurso %s: Uso = %.2f / %.2f | Holgura = %.2f\n", 
              nombres_recursos[i], uso_i, b_vec_base[i], holguras[i]))
}

cat(sprintf("\nPrecios Sombra Duales (Multiplicadores Resolutivos de Kantorovich):\n"))
for (i in 1:3) {
  cat(sprintf("  lambda_%d (%s) = %.4f\n", i, nombres_recursos[i], precios_sombra[i]))
}

# Verificacion del Teorema Fuerte de Dualidad
W_dual <- sum(b_vec_base * precios_sombra)
cat(sprintf("\nVerificacion de Teorema Fuerte de Dualidad:\n"))
cat(sprintf("  Z* (Primal) = %.4f | W* (Dual) = %.4f | Brecha = %.6f\n", 
            Z_opt, W_dual, abs(Z_opt - W_dual)))

# ------------------------------------------------------------------------------
# 3. ANALISIS DE SENSIBILIDAD EN RECURSO CAPITAL (b_K)
# ------------------------------------------------------------------------------
grid_bK <- seq(300, 1300, by = 10)
df_sensibilidad <- data.frame()

for (bk_val in grid_bK) {
  b_temp <- c(b_vec_base[1], bk_val, b_vec_base[3])
  res_temp <- lp(
    direction = "max",
    objective.in = c_obj,
    const.mat = A_mat,
    const.dir = dir_mat,
    const.rhs = b_temp,
    compute.sens = TRUE
  )
  
  if (res_temp$status == 0) {
    x1_t <- res_temp$solution[1]
    x2_t <- res_temp$solution[2]
    z_t  <- res_temp$objval
    duals_t <- res_temp$duals[1:3]
    h_t <- b_temp - (A_mat %*% c(x1_t, x2_t))
    
    df_sensibilidad <- rbind(df_sensibilidad, data.frame(
      b_K = bk_val,
      x1 = x1_t,
      x2 = x2_t,
      Z = z_t,
      sombra_L = duals_t[1],
      sombra_K = duals_t[2],
      sombra_E = duals_t[3],
      holgura_L = h_t[1],
      holgura_K = h_t[2],
      holgura_E = h_t[3]
    ))
  }
}

# ------------------------------------------------------------------------------
# 4. TABLA DE ESCENARIOS DE ASIGNACION OPTIMA
# ------------------------------------------------------------------------------
escenarios <- list(
  list(nombre = "Caso Base (Calibracion 1975)", b = c(1000, 800, 700)),
  list(nombre = "Escasez Severa de Capital", b = c(1000, 500, 700)),
  list(nombre = "Abundancia de Capital", b = c(1000, 1100, 700)),
  list(nombre = "Restriccion Energetica Vinculante", b = c(1000, 800, 550)),
  list(nombre = "Expansion de Fuerza Laboral (+20%)", b = c(1200, 800, 700)),
  list(nombre = "Economia Deprimida (Shock Generalizado)", b = c(800, 600, 500))
)

tab_resultados <- data.frame()

for (esc in escenarios) {
  res_esc <- lp(
    direction = "max",
    objective.in = c_obj,
    const.mat = A_mat,
    const.dir = dir_mat,
    const.rhs = esc$b,
    compute.sens = TRUE
  )
  
  x_e <- res_esc$solution
  z_e <- res_esc$objval
  d_e <- res_esc$duals[1:3]
  h_e <- esc$b - (A_mat %*% x_e)
  
  tab_resultados <- rbind(tab_resultados, data.frame(
    escenario = esc$nombre,
    b_Trabajo = esc$b[1],
    b_Capital = esc$b[2],
    b_Energia = esc$b[3],
    x1_opt_Maquinaria = round(x_e[1], 2),
    x2_opt_Consumo = round(x_e[2], 2),
    Z_opt_ValorTotal = round(z_e, 2),
    holgura_Trabajo = round(h_e[1], 2),
    holgura_Capital = round(h_e[2], 2),
    holgura_Energia = round(h_e[3], 2),
    precio_sombra_Trabajo = round(d_e[1], 4),
    precio_sombra_Capital = round(d_e[2], 4),
    precio_sombra_Energia = round(d_e[3], 4)
  ))
}

# Guardar tabla CSV
ruta_csv <- file.path(dir_salidas, "tab_resultados_optimizacion_1975.csv")
write_csv(tab_resultados, ruta_csv)
cat(sprintf("\nTabla de resultados guardada exitosamente en:\n  %s\n", ruta_csv))

# ------------------------------------------------------------------------------
# 5. GENERACION DE FIGURAS
# ------------------------------------------------------------------------------

# FIGURA 1: Espacio Primal y Poliedro Factible de Kantorovich
# Crear lineas de restriccion en R2
x1_seq <- seq(0, 600, length.out = 500)

df_restricciones <- data.frame(
  x1 = rep(x1_seq, 3),
  x2 = c(
    pmax(0, 1000 - 2 * x1_seq),       # Trabajo: 2*x1 + x2 <= 1000 => x2 <= 1000 - 2*x1
    pmax(0, (800 - x1_seq) / 2),      # Capital: x1 + 2*x2 <= 800 => x2 <= (800 - x1)/2
    pmax(0, 700 - x1_seq)             # Energia: x1 + x2 <= 700 => x2 <= 700 - x1
  ),
  Restriccion = rep(c("Trabajo: 2*x1 + x2 <= 1000", 
                      "Capital: x1 + 2*x2 <= 800", 
                      "Energia: x1 + x2 <= 700"), each = length(x1_seq))
)

# Region Factible (interseccion)
df_factible <- data.frame(x1 = x1_seq) %>%
  mutate(
    x2_lim1 = pmax(0, 1000 - 2 * x1),
    x2_lim2 = pmax(0, (800 - x1) / 2),
    x2_lim3 = pmax(0, 700 - x1),
    x2_max = pmin(x2_lim1, x2_lim2, x2_lim3)
  ) %>%
  filter(x2_max >= 0)

# Curvas de Iso-Valor / Iso-Beneficio: 40*x1 + 30*x2 = Z => x2 = (Z - 40*x1)/30
df_isovalor <- expand.grid(x1 = seq(0, 550, length.out = 200), Z = c(12000, 18000, 22000)) %>%
  mutate(
    x2 = (Z - 40 * x1) / 30,
    Nivel = factor(sprintf("Iso-Valor Z = %s", scales::comma(Z)))
  ) %>%
  filter(x2 >= 0 & x2 <= 500)

# Vertices del poliedro factible
df_vertices <- data.frame(
  x1 = c(0, 0, 400, 500),
  x2 = c(0, 400, 200, 0),
  Etiqueta = c("O (0, 0)\nZ = 0", 
               "A (0, 400)\nZ = 12,000", 
               "Optimo (400, 200)\nZ* = 22,000", 
               "B (500, 0)\nZ = 20,000")
)

p1 <- ggplot() +
  # Region factible sombreada
  geom_ribbon(data = df_factible, aes(x = x1, ymin = 0, ymax = x2_max), 
              fill = "#2c7bb6", alpha = 0.25) +
  # Lineas de restricciones
  geom_line(data = df_restricciones, aes(x = x1, y = x2, color = Restriccion), 
            linewidth = 1.1) +
  # Lineas de iso-valor
  geom_line(data = df_isovalor, aes(x = x1, y = x2, group = Nivel, linetype = Nivel), 
            color = "#d7191c", linewidth = 0.9) +
  # Vertices
  geom_point(data = df_vertices, aes(x = x1, y = x2), size = 3, color = "#252525") +
  geom_point(aes(x = 400, y = 200), size = 5, color = "#d7191c", shape = 18) +
  # Anotacion del optimo
  annotate("label", x = 400, y = 240, 
           label = "Solucion Optima Primal de Kantorovich:\nx1* = 400, x2* = 200\nZ* = 22,000\nHolgura Energia = 100", 
           fill = "#ffffbf", color = "#1a1a1a", size = 3.5, fontface = "bold") +
  # Limites y escalas
  coord_cartesian(xlim = c(0, 550), ylim = c(0, 450)) +
  scale_color_manual(values = c("Trabajo: 2*x1 + x2 <= 1000" = "#2b83ba", 
                                "Capital: x1 + 2*x2 <= 800" = "#fdae61", 
                                "Energia: x1 + x2 <= 700" = "#abd9e9")) +
  scale_linetype_manual(values = c("dotted", "dashed", "solid")) +
  labs(
    title = "Figura 1: Poliedro Factible y Planificacion Optima (Kantorovich 1939, 1959)",
    subtitle = "Max Z = 40 x1 + 30 x2 sujeto a restricciones de Trabajo, Capital y Energia",
    x = "Bien 1: Maquinaria y Equipos Industriales (x1)",
    y = "Bien 2: Bienes de Consumo Final (x2)",
    color = "Fronteras de Recursos",
    linetype = "Niveles de Valor Social",
    caption = "Fuente: Elaboracion propia basada en Kantorovich (1939) y Metodo de Multiplicadores Resolutivos."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#1a1a1a"),
    plot.subtitle = element_text(size = 11, color = "#4a4a4a"),
    legend.position = "right",
    legend.box = "vertical",
    panel.grid.minor = element_blank()
  )

ruta_fig1 <- file.path(dir_salidas, "fig_kantorovich_programacion_lineal.png")
ggsave(ruta_fig1, plot = p1, width = 10, height = 6.5, dpi = 300)
cat(sprintf("Figura 1 guardada en:\n  %s\n", ruta_fig1))


# FIGURA 2: Analisis de Actividades y Sensibilidad de Precios Sombra (Koopmans 1951)
# Panel doble: Valor Optimo Z* vs b_K y Precios Sombra vs b_K

p2_a <- ggplot(df_sensibilidad, aes(x = b_K, y = Z)) +
  geom_line(color = "#2c7bb6", linewidth = 1.3) +
  geom_vline(xintercept = 800, linetype = "dashed", color = "#d7191c") +
  annotate("text", x = 820, y = 17500, label = "Capacidad Base\nb_K = 800", 
           hjust = 0, color = "#d7191c", size = 3.5, fontface = "italic") +
  labs(
    title = "A) Valor Maximo de Produccion Z* segun Capacidad de Capital (b_K)",
    subtitle = "Concavidad de la funcion de valor optimo Z*(b)",
    x = "Disponibilidad de Horas-Maquina de Capital (b_K)",
    y = "Valor Optimo Total Z*"
  ) +
  theme_minimal(base_size = 11) +
  theme(plot.title = element_text(face = "bold", size = 12))

df_sombras_long <- df_sensibilidad %>%
  select(b_K, sombra_L, sombra_K, sombra_E) %>%
  pivot_longer(cols = starts_with("sombra_"), names_to = "Recurso", values_to = "Precio_Sombra") %>%
  mutate(Recurso = case_when(
    Recurso == "sombra_L" ~ "lambda_L (Trabajo)",
    Recurso == "sombra_K" ~ "lambda_K (Capital)",
    Recurso == "sombra_E" ~ "lambda_E (Energia)"
  ))

p2_b <- ggplot(df_sombras_long, aes(x = b_K, y = Precio_Sombra, color = Recurso)) +
  geom_line(linewidth = 1.2) +
  geom_vline(xintercept = 800, linetype = "dashed", color = "#636363") +
  scale_color_manual(values = c("lambda_L (Trabajo)" = "#2b83ba", 
                                "lambda_K (Capital)" = "#d7191c", 
                                "lambda_E (Energia)" = "#2ca25f")) +
  labs(
    title = "B) Precios Sombra Duales (Multiplicadores de Koopmans-Kantorovich)",
    subtitle = "Cambio de base simplex y holgura complementaria: lambda_i = 0 si holgura_i > 0",
    x = "Disponibilidad de Horas-Maquina de Capital (b_K)",
    y = "Precio Sombra Marginal (lambda_i)",
    color = "Precio Sombra"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.position = "bottom"
  )

# Combinar ambos paneles verticalmente usando patchwork o gridExtra basico
p2_combinado <- gridExtra::grid.arrange(
  p2_a, p2_b, ncol = 1,
  top = grid::textGrob(
    "Figura 2: Analisis de Actividades y Precios Contables de Koopmans (1951, 1957)",
    gp = grid::gpar(fontsize = 14, fontface = "bold")
  ),
  bottom = grid::textGrob(
    "Fuente: Replicacion computacional basada en Koopmans (1951) y Teoria de la Dualidad Lineal.",
    gp = grid::gpar(fontsize = 9, fontface = "italic")
  )
)

ruta_fig2 <- file.path(dir_salidas, "fig_koopmans_analisis_actividades.png")
ggsave(ruta_fig2, plot = p2_combinado, width = 10, height = 8, dpi = 300)
cat(sprintf("Figura 2 guardada en:\n  %s\n", ruta_fig2))

message("=== Replicacion ejecutada exitosamente. Todos los archivos generados. ===")

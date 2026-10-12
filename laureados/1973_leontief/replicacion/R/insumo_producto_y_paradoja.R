# ==============================================================================
# Insumo-Producto, Multiplicadores de Leontief y la Paradoja de 1953
# Laureado: Wassily Leontief (Premio Nobel de Economia 1973)
# Autor: Nobel_economics Project
# Descripcion:
#   1. Construccion y balance de una Matriz Insumo-Producto (MIP) multisectorial
#      (Agricultura, Manufactura, Servicios, Energia).
#   2. Derivacion de la Matriz de Coeficientes Tecnicos A y la Inversa de
#      Leontief L = (I - A)^(-1).
#   3. Calculo de multiplicadores de produccion y encadenamientos de Rasmussen
#      (Backward y Forward linkages / Poder y Sensibilidad de dispersion).
#   4. Simulacion dinamica de shock en la demanda final y descomposicion
#      por rondas de impacto (Serie de Neumann: L = I + A + A^2 + ...).
#   5. Evaluacion del contenido factorial (Capital y Trabajo) directo e indirecto,
#      reproduciendo analiticamente la celebre Paradoja de Leontief (1953).
#   6. Exportacion de salidas graficas en alta resolucion y tabla de resultados.
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(readr)
  library(scales)
  library(patchwork)
})

# Definicion de rutas relativas
dir_salidas <- file.path("laureados", "1973_leontief", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  # Si se ejecuta directamente desde la carpeta de replicacion
  if (dir.exists("salidas")) {
    dir_salidas <- "salidas"
  } else {
    dir.create(dir_salidas, recursive = TRUE)
  }
}

message("=== 1. CONSTRUCCION DE LA MATRIZ INSUMO-PRODUCTO ===")

# Definicion de sectores economicos
sectores <- c("Agricultura", "Manufactura", "Servicios", "Energia")
n <- length(sectores)

# Matriz de transacciones intersectoriales Z (flujos intermedios en miles de millones USD)
# Filas: sector vendedor / Columnas: sector comprador
Z <- matrix(c(
  30,  85,  15,  10,   # Agricultura vende a: Agr, Man, Ser, Ene
  25, 140,  60,  35,   # Manufactura vende a: Agr, Man, Ser, Ene
  20,  50, 110,  20,   # Servicios vende a: Agr, Man, Ser, Ene
  15,  45,  35,  25    # Energia vende a: Agr, Man, Ser, Ene
), nrow = 4, byrow = TRUE, dimnames = list(sectores, sectores))

# Demanda final y (Consumo de hogares, Inversion, Gasto publico, Exportaciones netas)
y <- c(Agricultura = 110, Manufactura = 240, Servicios = 320, Energia = 85)

# Produccion bruta total x = sum_j(z_ij) + y_i
x <- rowSums(Z) + y

# Valor agregado v = x - colSums(Z) (Remuneracion al trabajo, excedente de capital, etc.)
v <- x - colSums(Z)

# Validacion del balance macroeconomico (Oferta total = Demanda total)
total_insumos <- colSums(Z) + v
stopifnot(all.equal(as.numeric(x), as.numeric(total_insumos)))
stopifnot(sum(y) == sum(v)) # PIB por el lado de la demanda = PIB por el lado del ingreso

message(sprintf("PIB agregado (Valor Agregado Total): $%.1f mil millones USD", sum(v)))
message(sprintf("Produccion Bruta Agregada: $%.1f mil millones USD", sum(x)))

# ==============================================================================
# 2. MATRIZ DE COEFICIENTES TECNICOS (A) E INVERSA DE LEONTIEF (L)
# ==============================================================================
message("\n=== 2. MATRIZ TECNICA E INVERSA DE LEONTIEF ===")

# Coeficientes tecnicos a_ij = z_ij / x_j
A <- Z %*% diag(1 / x)
colnames(A) <- sectores
rownames(A) <- sectores

# Matriz Identidad
I <- diag(n)
dimnames(I) <- list(sectores, sectores)

# Inversa de Leontief L = (I - A)^(-1)
I_minus_A <- I - A
L <- solve(I_minus_A)
colnames(L) <- sectores
rownames(L) <- sectores

# Multiplicadores de produccion hacia atras (column sums of L)
mult_backward <- colSums(L)

# Multiplicadores de produccion hacia adelante (row sums of L)
mult_forward <- rowSums(L)

# Indices normalizados de encadenamiento de Rasmussen (centrados en 1.0)
# Un valor > 1 indica una capacidad de arrastre / empuje superior al promedio del sistema economico
promedio_sistema <- mean(mult_backward) # Media aritmetica de los multiplicadores

# Poder de dispersion (Backward linkages / Arrastre hacia atras)
BL <- mult_backward / promedio_sistema

# Sensibilidad de dispersion (Forward linkages / Empuje hacia adelante)
FL <- mult_forward / promedio_sistema

# Clasificacion tipologica sectorial de Chenery-Watanabe / Rasmussen
clasificacion <- case_when(
  BL > 1 & FL > 1 ~ "Sector Clave",
  BL > 1 & FL <= 1 ~ "Sector Impulsor (Hacia atras)",
  BL <= 1 & FL > 1 ~ "Sector Estrategico (Hacia adelante)",
  TRUE ~ "Sector Independiente"
)

df_encadenamientos <- tibble(
  Sector = sectores,
  Produccion_Bruta = round(x, 2),
  Valor_Agregado = round(v, 2),
  Multiplicador_Produccion = round(mult_backward, 3),
  Backward_Linkage = round(BL, 3),
  Forward_Linkage = round(FL, 3),
  Tipologia = clasificacion
)

print(df_encadenamientos)

# ==============================================================================
# 3. SIMULACION DE SHOCK DE DEMANDA Y DESCOMPOSICION POR RONDAS (NEUMANN)
# ==============================================================================
message("\n=== 3. SHOCK DE DEMANDA Y DESCOMPOSICION POR RONDAS ===")

# Simulamos un choque exogeno de +$50 mil millones en la demanda de Manufactura
delta_y <- c(Agricultura = 0, Manufactura = 50, Servicios = 0, Energia = 0)

# Impacto total sobre la produccion bruta: Delta_x = L %*% Delta_y
delta_x_total <- as.vector(L %*% delta_y)
names(delta_x_total) <- sectores

# Descomposicion por rondas de impacto (Serie de Neumann):
# Ronda 0: Impacto directo = Delta_y
# Ronda 1: Primer impacto indirecto = A %*% Delta_y
# Ronda 2: Segundo impacto indirecto = A^2 %*% Delta_y
# Ronda 3: Tercer impacto indirecto = A^3 %*% Delta_y
# Ronda 4+: Impactos residuales = Delta_x_total - (Ronda 0 + 1 + 2 + 3)

ronda_0 <- delta_y
ronda_1 <- as.vector(A %*% delta_y)
ronda_2 <- as.vector(A %*% ronda_1)
ronda_3 <- as.vector(A %*% ronda_2)
ronda_residual <- delta_x_total - (ronda_0 + ronda_1 + ronda_2 + ronda_3)

df_rondas <- tibble(
  Sector = rep(sectores, 5),
  Ronda = factor(rep(c("Directo (Ronda 0)", "Ronda 1", "Ronda 2", "Ronda 3", "Rondas 4+ (Residual)"), each = n),
                 levels = c("Directo (Ronda 0)", "Ronda 1", "Ronda 2", "Ronda 3", "Rondas 4+ (Residual)")),
  Impacto = c(ronda_0, ronda_1, ronda_2, ronda_3, ronda_residual)
)

# ==============================================================================
# 4. LA PARADOJA DE LEONTIEF (1953): INTENSIDAD FACTORIAL DIRECTA E INDIRECTA
# ==============================================================================
message("\n=== 4. LA PARADOJA DE LEONTIEF (1953) ===")

# Asignacion de stocks factoriales por sector (calibrados historicamente al estudio de 1947/1953)
# K: Stock de Capital en miles de millones USD
# N: Empleo en millones de personas-ano
K_stock <- c(Agricultura = 180, Manufactura = 360, Servicios = 340, Energia = 210)
N_trabajo <- c(Agricultura = 12.5, Manufactura = 16.0, Servicios = 22.0, Energia = 3.5)

# Coeficientes factoriales directos por unidad de produccion bruta
# k_j = K_j / x_j  (Capital por unidad de producto bruto)
# l_j = N_j / x_j  (Trabajo por unidad de producto bruto)
k_directo <- K_stock / x
l_directo <- N_trabajo / x

# Requerimientos factoriales totales (Directos + Indirectos):
# k_total' = k' %*% (I - A)^(-1)
# l_total' = l' %*% (I - A)^(-1)
k_total <- as.vector(k_directo %*% L)
names(k_total) <- sectores

l_total <- as.vector(l_directo %*% L)
names(l_total) <- sectores

# Canastas representativas del comercio exterior de Estados Unidos (normalizadas a $100 mil millones)
# Exportaciones: fuertemente concentradas en Manufactura avanzada y Servicios tecnicos
# Importaciones competitivas: bienes que compiten con Manufactura intensiva y materias primas/energia
exportaciones_canasta <- c(Agricultura = 10, Manufactura = 65, Servicios = 20, Energia = 5)
importaciones_canasta <- c(Agricultura = 15, Manufactura = 45, Servicios = 10, Energia = 30)

# 1. Contenido Factorial Directo en Exportaciones vs Importaciones:
K_dir_exp <- sum(k_directo * exportaciones_canasta)
L_dir_exp <- sum(l_directo * exportaciones_canasta)
ratio_KL_dir_exp <- K_dir_exp / L_dir_exp

K_dir_imp <- sum(k_directo * importaciones_canasta)
L_dir_imp <- sum(l_directo * importaciones_canasta)
ratio_KL_dir_imp <- K_dir_imp / L_dir_imp

paradoja_directa <- ratio_KL_dir_exp / ratio_KL_dir_imp

# 2. Contenido Factorial Total (Directo + Indirecto mediante la Inversa de Leontief):
K_tot_exp <- sum(k_total * exportaciones_canasta)
L_tot_exp <- sum(l_total * exportaciones_canasta)
ratio_KL_tot_exp <- K_tot_exp / L_tot_exp

K_tot_imp <- sum(k_total * importaciones_canasta)
L_tot_imp <- sum(l_total * importaciones_canasta)
ratio_KL_tot_imp <- K_tot_imp / L_tot_imp

paradoja_leontief_total <- ratio_KL_tot_exp / ratio_KL_tot_imp

message(sprintf("Directo  - (K/L) Exportaciones: $%.3f miles/trabajador | (K/L) Importaciones: $%.3f miles/trabajador | Ratio: %.3f",
                ratio_KL_dir_exp * 1000, ratio_KL_dir_imp * 1000, paradoja_directa))
message(sprintf("Total    - (K/L) Exportaciones: $%.3f miles/trabajador | (K/L) Importaciones: $%.3f miles/trabajador | Ratio: %.3f",
                ratio_KL_tot_exp * 1000, ratio_KL_tot_imp * 1000, paradoja_leontief_total))

if (paradoja_leontief_total < 1) {
  message(">> CONFIRMADA LA PARADOJA DE LEONTIEF: El ratio Capital/Trabajo incorporado en las exportaciones estadounidenses es MENOR que el de las importaciones competitivas, desafiando el teorema Heckscher-Ohlin convencional.")
}

# Consolidacion de tabla de resultados
df_factores <- tibble(
  Sector = sectores,
  Capital_Stock_USD = K_stock,
  Empleo_Personas_Millones = N_trabajo,
  Coef_Capital_Directo = round(k_directo, 4),
  Coef_Trabajo_Directo = round(l_directo, 4),
  Coef_Capital_Total = round(k_total, 4),
  Coef_Trabajo_Total = round(l_total, 4),
  KL_Directo = round(k_directo / l_directo, 3),
  KL_Total = round(k_total / l_total, 3),
  Exportaciones_Canasta = exportaciones_canasta,
  Importaciones_Canasta = importaciones_canasta
)

df_consolidado <- left_join(df_encadenamientos, df_factores, by = "Sector")

# ==============================================================================
# 5. GENERACION DE FIGURAS
# ==============================================================================
message("\n=== 5. GENERACION DE GRAFICOS ===")

# Colorimetria sobria y profesional
col_primario <- "#1B365D"   # Azul institucional profundo
col_secundario <- "#D97706" # Ambar / dorado
col_acento <- "#059669"     # Esmeralda
col_gris <- "#4B5563"       # Gris pizarra

tema_nobel <- theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12, color = "#111827"),
    plot.subtitle = element_text(size = 9.5, color = "#4B5563", margin = margin(b = 8)),
    plot.caption = element_text(size = 8, color = "#6B7280", hjust = 0),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#E5E7EB", linewidth = 0.4),
    legend.position = "bottom",
    legend.title = element_text(size = 9, face = "bold"),
    legend.text = element_text(size = 8.5),
    strip.text = element_text(face = "bold", size = 10, color = "#1F2937")
  )

# --- FIGURA 1: MATRIZ DE LEONTIEF Y ENCADENAMIENTOS DE RASMUSSEN ---
# Panel 1A: Mapa de Calor de la Inversa de Leontief L = (I - A)^(-1)
df_L_heatmap <- as.data.frame(as.table(L)) %>%
  rename(Sector_Origen = Var1, Sector_Destino = Var2, Requerimiento = Freq)

p1a <- ggplot(df_L_heatmap, aes(x = Sector_Destino, y = Sector_Origen, fill = Requerimiento)) +
  geom_tile(color = "white", linewidth = 0.8) +
  geom_text(aes(label = sprintf("%.3f", Requerimiento)), color = ifelse(df_L_heatmap$Requerimiento > 1.4, "white", "black"), size = 3.8, fontface = "bold") +
  scale_fill_gradient(low = "#EFF6FF", high = "#1D4ED8", name = "Requerimiento Total:") +
  labs(
    title = "A. Matriz Inversa de Leontief: Requerimientos Totales (L = (I - A)^-1)",
    subtitle = "Produccion bruta necesaria del sector origen (fila) por cada unidad de demanda final del sector destino (columna)",
    x = "Sector de Demanda Final (Comprador)",
    y = "Sector de Produccion Bruta (Proveedor)"
  ) +
  tema_nobel +
  theme(axis.text.x = element_text(angle = 15, hjust = 1))

# Panel 1B: Plano de Encadenamientos de Rasmussen (Backward vs Forward Linkages)
p1b <- ggplot(df_encadenamientos, aes(x = Backward_Linkage, y = Forward_Linkage)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "#9CA3AF", linewidth = 0.6) +
  geom_vline(xintercept = 1, linetype = "dashed", color = "#9CA3AF", linewidth = 0.6) +
  annotate("rect", xmin = 1, xmax = 1.35, ymin = 1, ymax = 1.35, alpha = 0.08, fill = "#10B981") +
  annotate("text", x = 1.25, y = 1.30, label = "Sectores Clave\n(BL > 1, FL > 1)", size = 2.8, color = "#065F46", fontface = "bold") +
  annotate("text", x = 0.80, y = 1.30, label = "Sectores Estrategicos\n(BL <= 1, FL > 1)", size = 2.8, color = "#1E40AF", fontface = "italic") +
  annotate("text", x = 1.25, y = 0.75, label = "Sectores Impulsores\n(BL > 1, FL <= 1)", size = 2.8, color = "#B45309", fontface = "italic") +
  annotate("text", x = 0.80, y = 0.75, label = "Sectores Independientes\n(BL <= 1, FL <= 1)", size = 2.8, color = "#6B7280", fontface = "italic") +
  geom_point(aes(size = Produccion_Bruta, color = Tipologia), alpha = 0.9) +
  geom_text(aes(label = Sector), vjust = -1.1, size = 3.4, fontface = "bold") +
  scale_color_manual(values = c(
    "Sector Clave" = "#059669",
    "Sector Estrategico (Hacia adelante)" = "#2563EB",
    "Sector Impulsor (Hacia atras)" = "#D97706",
    "Sector Independiente" = "#6B7280"
  )) +
  scale_size_continuous(range = c(4, 9), name = "Prod. Bruta ($MM):") +
  scale_x_continuous(limits = c(0.70, 1.35), breaks = seq(0.7, 1.3, 0.1)) +
  scale_y_continuous(limits = c(0.70, 1.35), breaks = seq(0.7, 1.3, 0.1)) +
  labs(
    title = "B. Encadenamientos de Rasmussen: Poder vs Sensibilidad de Dispersion",
    subtitle = "Clasificacion estructural: identificacion de sectores clave con efectos multiplicadores superiores a la media",
    x = "Encadenamiento Hacia Atras (Backward Linkage - Poder de Dispersion)",
    y = "Encadenamiento Hacia Adelante (Forward Linkage - Sensibilidad)"
  ) +
  tema_nobel

fig1 <- p1a / p1b +
  plot_annotation(
    title = "Estructura Multisectorial y Analisis Insumo-Producto de Wassily Leontief (1973)",
    caption = "Fuente: Nobel_economics Project. Modelo calibrado segun principios de Leontief (1941, 1966) y encadenamientos de Rasmussen (1956).",
    theme = theme(plot.title = element_text(size = 14, face = "bold", color = "#111827", margin = margin(b = 6)))
  )

archivo_fig1 <- file.path(dir_salidas, "fig_leontief_matriz_multiplicadores.png")
ggsave(archivo_fig1, plot = fig1, width = 11, height = 11, dpi = 300)
message(sprintf("Grafico guardado: %s", archivo_fig1))

# --- FIGURA 2: DESCOMPOSICION POR RONDAS Y LA PARADOJA DE LEONTIEF ---
# Panel 2A: Descomposicion del shock de demanda de manufactura por rondas (Serie de Neumann)
p2a <- ggplot(df_rondas, aes(x = Sector, y = Impacto, fill = Ronda)) +
  geom_col(position = "stack", width = 0.65) +
  scale_fill_brewer(palette = "Blues", direction = 1, name = "Fase de Transmision:") +
  labs(
    title = "A. Difusion del Estimulo Economico por Rondas de Produccion (Serie de Neumann)",
    subtitle = "Impacto sectorial de un shock de demanda de +$50 mil millones en Manufactura: L = I + A + A^2 + A^3 + ...",
    x = "Sector Afectado",
    y = "Incremento en Produccion Bruta ($ mil millones USD)"
  ) +
  tema_nobel +
  theme(legend.position = "right")

# Panel 2B: La Paradoja de Leontief (Intensidad K/L Directa vs Total)
df_paradoja_grafico <- tibble(
  Tipo = factor(c("Requerimiento Directo", "Requerimiento Directo",
                  "Requerimiento Total (Directo + Indirecto)", "Requerimiento Total (Directo + Indirecto)"),
                levels = c("Requerimiento Directo", "Requerimiento Total (Directo + Indirecto)")),
  Flujo = factor(c("Exportaciones", "Importaciones Competitivas",
                   "Exportaciones", "Importaciones Competitivas"),
                 levels = c("Exportaciones", "Importaciones Competitivas")),
  Ratio_KL = c(ratio_KL_dir_exp * 1000, ratio_KL_dir_imp * 1000,
               ratio_KL_tot_exp * 1000, ratio_KL_tot_imp * 1000)
)

p2b <- ggplot(df_paradoja_grafico, aes(x = Tipo, y = Ratio_KL, fill = Flujo)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.6) +
  geom_text(aes(label = sprintf("$%.0f", Ratio_KL)),
            position = position_dodge(width = 0.7), vjust = -0.6, size = 3.6, fontface = "bold") +
  annotate("label", x = 2, y = 24000,
           label = sprintf("Ratio de Paradoja = (K/L)_exp / (K/L)_imp = %.2f < 1.0\n(EE.UU. exporta bienes relativamente mas intensivos en trabajo)", paradoja_leontief_total),
           color = "#B91C1C", size = 3.3, fontface = "bold.italic", fill = "white") +
  scale_fill_manual(values = c("Exportaciones" = "#1D4ED8", "Importaciones Competitivas" = "#D97706"),
                    name = "Flujo de Comercio:") +
  scale_y_continuous(labels = dollar_format(), limits = c(0, 27000)) +
  labs(
    title = "B. La Paradoja de Leontief (1953): Intensidad de Capital por Trabajador",
    subtitle = "Comparacion de la razon K/L por trabajador (USD) incorporada en exportaciones vs sustitutos de importacion",
    x = "Metodologia de Estimacion",
    y = "Capital por Trabajador (USD / Persona-Ano)"
  ) +
  tema_nobel

fig2 <- p2a / p2b +
  plot_annotation(
    title = "Mecanismos de Transmision y la Paradoja del Comercio Exterior de Leontief",
    caption = "Fuente: Nobel_economics Project. Basado en Leontief (1953, 'Domestic Production and Foreign Trade Re-Examined').",
    theme = theme(plot.title = element_text(size = 14, face = "bold", color = "#111827", margin = margin(b = 6)))
  )

archivo_fig2 <- file.path(dir_salidas, "fig_leontief_paradoja_intensidad.png")
ggsave(archivo_fig2, plot = fig2, width = 11, height = 11, dpi = 300)
message(sprintf("Grafico guardado: %s", archivo_fig2))

# ==============================================================================
# 6. EXPORTACION DE TABLA CONSOLIDADA CSV
# ==============================================================================
archivo_csv <- file.path(dir_salidas, "tab_resultados_insumo_producto_1973.csv")
write_csv(df_consolidado, archivo_csv)
message(sprintf("Tabla consolidada exportada exitosamente: %s", archivo_csv))

message("\n>>> REPLICACION COMPLETADA CON EXITO <<<")

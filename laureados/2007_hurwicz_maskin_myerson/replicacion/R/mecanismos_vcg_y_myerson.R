# ==============================================================================
# Premio Nobel de Economía 2007: Leonid Hurwicz, Eric S. Maskin, Roger B. Myerson
# Replicación Ilustrativa: Teoría del Diseño de Mecanismos
#
# Contenido:
# 1. Simulación del Mecanismo Vickrey-Clarke-Groves (VCG) para la provisión
#    de un bien público, probando que la revelación veraz es estrategia dominante
#    (Hurwicz 1972, 1973; Clarke 1971; Groves 1973).
# 2. Simulación y verificación Monte Carlo del Teorema de Equivalencia del
#    Ingreso de Myerson (Myerson 1981) en cuatro formatos canónicos de subastas:
#    - Subasta de Primer Precio (FPA)
#    - Subasta de Segundo Precio / Vickrey (SPA)
#    - Subasta Inglesa Ascendente
#    - Subasta de Todos Pagan (All-Pay Auction)
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(scales)
  library(patchwork)
})

# Fijar semilla para estricta reproducibilidad
set.seed(20071015)

cat("======================================================================\n")
cat("Premio Nobel de Economía 2007: Hurwicz, Maskin, Myerson\n")
cat("Simulación de Diseño de Mecanismos y Equivalencia del Ingreso\n")
cat("======================================================================\n\n")

# Determinar directorios de salida
script_dir <- getwd()
if (dir.exists("laureados/2007_hurwicz_maskin_myerson/replicacion/salidas")) {
  dir_salidas <- "laureados/2007_hurwicz_maskin_myerson/replicacion/salidas"
} else if (dir.exists("../salidas")) {
  dir_salidas <- "../salidas"
} else if (dir.exists("salidas")) {
  dir_salidas <- "salidas"
} else {
  dir_salidas <- "laureados/2007_hurwicz_maskin_myerson/replicacion/salidas"
  dir.create(dir_salidas, recursive = TRUE, showWarnings = FALSE)
}

# ------------------------------------------------------------------------------
# PARTE 1: MECANISMO VICKREY-CLARKE-GROVES (VCG) PARA UN BIEN PÚBLICO
# ------------------------------------------------------------------------------
cat(">> Simulando Mecanismo VCG para provisión de un bien público...\n")

# Parámetros del bien público
Costo_Proyecto <- 120
N_agentes <- 3

# Caso ilustrativo representativo:
# Agente 1 tiene valor verdadero v1 = 50.
# Evaluamos el beneficio de mentir reportando v1_hat != v1.
# Modelamos la incertidumbre sobre los demás agentes (v2, v3) ~ U[20, 60].
# Muestreamos M_vcg perfiles de los otros agentes.

M_vcg <- 50000
v_otros <- matrix(runif(M_vcg * (N_agentes - 1), min = 20, max = 60), ncol = N_agentes - 1)
sum_v_otros <- rowSums(v_otros)

# Valores verdaderos de prueba para el Agente 1
valores_verdaderos <- c(35, 50, 65)
grilla_reportes <- seq(0, 100, by = 1)

df_vcg_esperado <- expand.grid(
  v_verdadero = valores_verdaderos,
  v_reportado = grilla_reportes
)

# Calcular utilidad esperada del Agente 1 bajo el mecanismo VCG (regla pivote de Clarke):
# Proyecto se construye si v_hat + sum_otros >= Costo_Proyecto.
# Pago de Clarke del Agente 1: p1 = max(0, Costo_Proyecto - sum_otros) si se construye, 0 si no.
# Utilidad neta de 1: u1 = v_verdadero - p1 si se construye, 0 si no.

calcular_utilidad_esperada_vcg <- function(v_real, v_rep, sum_otros, costo) {
  construye <- (v_rep + sum_otros >= costo)
  pago_clarke <- ifelse(construye, pmax(0, costo - sum_otros), 0)
  utilidad_neta <- ifelse(construye, v_real - pago_clarke, 0)
  mean(utilidad_neta)
}

# También comparamos con una regla ingenua de prorrateo uniforme del costo (C/N = 40):
# Proyecto se aprueba si v_rep + sum_otros >= costo.
# Pago fijo: 40 si se construye, 0 si no.
calcular_utilidad_esperada_fija <- function(v_real, v_rep, sum_otros, costo, n_ag) {
  construye <- (v_rep + sum_otros >= costo)
  pago_fijo <- ifelse(construye, costo / n_ag, 0)
  utilidad_neta <- ifelse(construye, v_real - pago_fijo, 0)
  mean(utilidad_neta)
}

df_vcg_esperado$utilidad_vcg <- mapply(
  calcular_utilidad_esperada_vcg,
  df_vcg_esperado$v_verdadero,
  df_vcg_esperado$v_reportado,
  MoreArgs = list(sum_otros = sum_v_otros, costo = Costo_Proyecto)
)

df_vcg_esperado$utilidad_fija <- mapply(
  calcular_utilidad_esperada_fija,
  df_vcg_esperado$v_verdadero,
  df_vcg_esperado$v_reportado,
  MoreArgs = list(sum_otros = sum_v_otros, costo = Costo_Proyecto, n_ag = N_agentes)
)

# Generar gráfico de VCG: Revelación veraz como estrategia dominante
df_plot_vcg <- df_vcg_esperado %>%
  mutate(label_tipo = paste0("Valor Verdadero: v = ", v_verdadero))

p_vcg1 <- ggplot(df_plot_vcg, aes(x = v_reportado, y = utilidad_vcg, color = factor(v_verdadero))) +
  geom_line(linewidth = 1.2) +
  geom_vline(aes(xintercept = v_verdadero, color = factor(v_verdadero)), linetype = "dashed", linewidth = 0.8) +
  facet_wrap(~ label_tipo, scales = "free_y") +
  scale_color_manual(values = c("35" = "#1b9e77", "50" = "#d95f02", "65" = "#7570b3")) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 11, color = "gray30"),
    strip.text = element_text(face = "bold", size = 11),
    panel.grid.minor = element_blank()
  ) +
  labs(
    title = "Mecanismo VCG: Compatibilidad de Incentivos en Estrategias Dominantes",
    subtitle = "La utilidad esperada alcanza su máximo estricto y exacto cuando el reporte coincide con la valoración veraz (línea discontinua)",
    x = "Valoración Reportada (v̂)",
    y = "Utilidad Neta Esperada (E[u])"
  )

# Gráfico comparativo: VCG vs Pago Fijo para v = 50
df_comp_50 <- df_plot_vcg %>%
  filter(v_verdadero == 50) %>%
  select(v_reportado, VCG = utilidad_vcg, `Pago Uniforme (C/N)` = utilidad_fija) %>%
  pivot_longer(cols = c("VCG", "Pago Uniforme (C/N)"), names_to = "Mecanismo", values_to = "Utilidad")

p_vcg2 <- ggplot(df_comp_50, aes(x = v_reportado, y = Utilidad, color = Mecanismo, linetype = Mecanismo)) +
  geom_line(linewidth = 1.2) +
  geom_vline(xintercept = 50, linetype = "dotted", color = "black", linewidth = 1) +
  annotate("text", x = 52, y = 5, label = "Valor Real v = 50", hjust = 0, fontface = "italic", size = 3.5) +
  scale_color_manual(values = c("VCG" = "#08519c", "Pago Uniforme (C/N)" = "#cb181d")) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 13),
    panel.grid.minor = element_blank()
  ) +
  labs(
    title = "VCG vs. Regla Ingenua de Costo Fijo (v = 50)",
    subtitle = "Bajo costo fijo, mentir hacia abajo o arriba distorsiona los incentivos (riesgo de free-riding o sobre-inversión)",
    x = "Valoración Reportada (v̂)",
    y = "Utilidad Neta Esperada"
  )

fig_vcg_combinada <- p_vcg1 / p_vcg2 + plot_layout(heights = c(1.3, 1))

ruta_fig_vcg <- file.path(dir_salidas, "fig_vcg_revelacion_veraz.png")
ggsave(ruta_fig_vcg, fig_vcg_combinada, width = 10, height = 8, dpi = 300)
cat("   [OK] Guardada figura VCG en:", ruta_fig_vcg, "\n")

# ------------------------------------------------------------------------------
# PARTE 2: TEOREMA DE EQUIVALENCIA DEL INGRESO DE MYERSON (1981)
# ------------------------------------------------------------------------------
cat("\n>> Simulando Teorema de Equivalencia del Ingreso de Myerson (1981)...\n")

# Parámetros del entorno de subastas:
# N = 4 postores neutrales al riesgo con valoraciones independientes v_i ~ U[0, 100].
# Vendedor neutral al riesgo con valoración de reserva r = 0.
N_postores <- 4
v_max <- 100
M_subastas <- 100000 # 100,000 subastas Monte Carlo para máxima precisión

# Generar matriz de valoraciones: M_subastas filas, N_postores columnas
mat_v <- matrix(runif(M_subastas * N_postores, min = 0, max = v_max), ncol = N_postores)

# Estadísticas de orden para cada subasta:
# v_ordenado[1] es la mayor valoración (v_(N)), v_ordenado[2] es la segunda (v_(N-1))
mat_v_sort <- t(apply(mat_v, 1, function(x) sort(x, decreasing = TRUE)))
v_1st <- mat_v_sort[, 1] # Ganador eficiente
v_2nd <- mat_v_sort[, 2] # Segundo valor más alto

# 1. Subasta de Primer Precio (FPA):
# En el equilibrio bayesiano simétrico de Nash:
# b_i(v_i) = ((N - 1) / N) * v_i = (3 / 4) * v_i
ingreso_fpa <- ((N_postores - 1) / N_postores) * v_1st

# 2. Subasta de Segundo Precio (SPA / Vickrey):
# En equilibrio de estrategias dominantes: b_i(v_i) = v_i
# El ganador paga la segunda puja más alta
ingreso_spa <- v_2nd

# 3. Subasta Inglesa Ascendente:
# Estratégicamente equivalente a SPA bajo valores privados e información simétrica
# El precio final se detiene en la segunda valoración
ingreso_inglesa <- v_2nd

# 4. Subasta de Todos Pagan (All-Pay Auction):
# En equilibrio bayesiano simétrico:
# b_i(v_i) = ((N - 1) / N) * (v_i^N / (v_max^(N - 1)))
# Cada postor paga su puja independientemente de si gana o pierde.
# El ingreso del vendedor es la suma de las pujas de todos los postores.
pujas_allpay <- ((N_postores - 1) / N_postores) * (mat_v^N_postores / (v_max^(N_postores - 1)))
ingreso_allpay <- rowSums(pujas_allpay)

# Valor teórico exacto de Myerson:
# E[Ingreso] = E[v_(2)] = ((N - 1) / (N + 1)) * v_max = (3 / 5) * 100 = 60.00
ingreso_teorico_myerson <- ((N_postores - 1) / (N_postores + 1)) * v_max

# Consolidar datos de las subastas
df_subastas <- data.frame(
  Subasta_ID = 1:M_subastas,
  FPA = ingreso_fpa,
  SPA = ingreso_spa,
  Inglesa = ingreso_inglesa,
  AllPay = ingreso_allpay
)

# Estadísticas resumidas
resumen_mecanismos <- data.frame(
  Mecanismo = c(
    "Subasta Primer Precio (FPA)",
    "Subasta Segundo Precio (SPA / Vickrey)",
    "Subasta Inglesa Ascendente",
    "Subasta de Todos Pagan (All-Pay)"
  ),
  Codigo = c("FPA", "SPA", "Inglesa", "AllPay"),
  Ingreso_Teorico = ingreso_teorico_myerson,
  Ingreso_Medio_Simulado = c(
    mean(ingreso_fpa),
    mean(ingreso_spa),
    mean(ingreso_inglesa),
    mean(ingreso_allpay)
  ),
  Error_Estandar = c(
    sd(ingreso_fpa) / sqrt(M_subastas),
    sd(ingreso_spa) / sqrt(M_subastas),
    sd(ingreso_inglesa) / sqrt(M_subastas),
    sd(ingreso_allpay) / sqrt(M_subastas)
  ),
  Desviacion_Estandar = c(
    sd(ingreso_fpa),
    sd(ingreso_spa),
    sd(ingreso_inglesa),
    sd(ingreso_allpay)
  ),
  Diferencia_vs_Teorico = c(
    mean(ingreso_fpa) - ingreso_teorico_myerson,
    mean(ingreso_spa) - ingreso_teorico_myerson,
    mean(ingreso_inglesa) - ingreso_teorico_myerson,
    mean(ingreso_allpay) - ingreso_teorico_myerson
  ),
  Eficiencia_Asignacion_Pct = 100.0
)

cat("Resultados de Equivalencia del Ingreso de Myerson:\n")
print(resumen_mecanismos[, c("Mecanismo", "Ingreso_Teorico", "Ingreso_Medio_Simulado", "Desviacion_Estandar")])

# Guardar tabla CSV
ruta_tab <- file.path(dir_salidas, "tab_resultados_mecanismos.csv")
write.csv(resumen_mecanismos, ruta_tab, row.names = FALSE)
cat("   [OK] Guardada tabla de resultados en:", ruta_tab, "\n")

# Gráfico de densidades y medias de Myerson
df_subastas_long <- df_subastas %>%
  select(FPA, SPA, AllPay) %>%
  pivot_longer(cols = everything(), names_to = "Mecanismo", values_to = "Ingreso") %>%
  mutate(Mecanismo = recode(
    Mecanismo,
    "FPA" = "Primer Precio (FPA)",
    "SPA" = "Segundo Precio (SPA / Vickrey / Inglesa)",
    "AllPay" = "Todos Pagan (All-Pay Auction)"
  ))

p_myerson <- ggplot(df_subastas_long, aes(x = Ingreso, fill = Mecanismo, color = Mecanismo)) +
  geom_density(alpha = 0.35, linewidth = 0.9) +
  geom_vline(xintercept = ingreso_teorico_myerson, linetype = "dashed", color = "black", linewidth = 1.1) +
  annotate(
    "text",
    x = ingreso_teorico_myerson + 2,
    y = 0.030,
    label = paste0("E[Ingreso] de Myerson = ", sprintf("%.2f", ingreso_teorico_myerson)),
    hjust = 0,
    fontface = "bold",
    size = 4,
    color = "black"
  ) +
  scale_fill_manual(values = c(
    "Primer Precio (FPA)" = "#3182bd",
    "Segundo Precio (SPA / Vickrey / Inglesa)" = "#31a354",
    "Todos Pagan (All-Pay Auction)" = "#e6550d"
  )) +
  scale_color_manual(values = c(
    "Primer Precio (FPA)" = "#08519c",
    "Segundo Precio (SPA / Vickrey / Inglesa)" = "#006d2c",
    "Todos Pagan (All-Pay Auction)" = "#a63603"
  )) +
  scale_x_continuous(limits = c(0, 100), breaks = seq(0, 100, by = 20)) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 11, color = "gray30"),
    panel.grid.minor = element_blank()
  ) +
  labs(
    title = "Teorema de Equivalencia del Ingreso de Myerson (1981)",
    subtitle = paste0(
      "Distribuciones empíricas de ingresos para N = 4 postores IID U[0, 100] (100,000 subastas).\n",
      "Pese a volatilidades muy distintas, las medias convergen idénticamente a 60.00."
    ),
    x = "Ingreso del Vendedor en la Subasta",
    y = "Densidad de Probabilidad",
    fill = "Regla de Subasta:",
    color = "Regla de Subasta:"
  )

ruta_fig_myerson <- file.path(dir_salidas, "fig_myerson_equivalencia_ingreso.png")
ggsave(ruta_fig_myerson, p_myerson, width = 10, height = 6, dpi = 300)
cat("   [OK] Guardada figura Myerson en:", ruta_fig_myerson, "\n")

cat("\n>> Simulación finalizada con éxito. Todos los archivos generados.\n")

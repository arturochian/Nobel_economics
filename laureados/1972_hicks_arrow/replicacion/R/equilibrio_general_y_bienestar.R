# ==============================================================================
# Premio Nobel de Economia 1972: Sir John R. Hicks y Kenneth J. Arrow
# Script: equilibrio_general_y_bienestar.R
# Descripcion:
#   1. Descomposicion de Hicks del efecto precio en efecto sustitucion y efecto
#      ingreso, calculo de Variacion Compensatoria (CV) y Variacion Equivalente (EV).
#   2. Caja de Edgeworth y Equilibrio General de Arrow-Debreu con contratos
#      contingentes de Arrow (Arrow securities) para reparto optimo del riesgo.
#   3. Generacion y exportacion de figuras (PNG) y tabla cuantitativa (CSV).
# ==============================================================================

# Paquetes requeridos
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(readr)
  library(gridExtra)
})

# Crear directorio de salidas si no existe
dir_salidas <- file.path("laureados", "1972_hicks_arrow", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

message("=== Iniciando simulacion Hicks & Arrow (1972) ===")

# ==============================================================================
# PARTE 1: DESCOMPOSICION DE HICKS (SUSTITUCION E INGRESO) Y BIENESTAR
# ==============================================================================
# Preferencias: Cobb-Douglas U(x1, x2) = x1^alpha * x2^(1-alpha)
alpha <- 0.5
beta  <- 1 - alpha

# Parametros iniciales
I_0    <- 100.0   # Ingreso nominal
p1_0   <- 2.0     # Precio inicial del bien 1
p2     <- 2.0     # Precio del bien 2 (constante)
p1_1   <- 1.0     # Precio nuevo del bien 1 (reduccion de precio)

# Cesta Inicial A (Marshalliana a p1_0, p2, I_0)
x1_A <- (alpha * I_0) / p1_0
x2_A <- (beta * I_0) / p2
U_0  <- (x1_A^alpha) * (x2_A^beta)

# Cesta Final C (Marshalliana a p1_1, p2, I_0)
x1_C <- (alpha * I_0) / p1_1
x2_C <- (beta * I_0) / p2
U_1  <- (x1_C^alpha) * (x2_C^beta)

# Cesta Compensada de Hicks B (Hicksiana a p1_1, p2 manteniendo U = U_0)
# Condicion de tangencia: TMS = (alpha * x2) / (beta * x1) = p1_1 / p2
# Para alpha = 0.5: x2 / x1 = p1_1 / p2 => x1 = (p2 / p1_1) * x2
# U_0 = sqrt(x1 * x2) = sqrt((p2 / p1_1) * x2^2) = x2 * sqrt(p2 / p1_1)
x2_B <- U_0 / sqrt(p2 / p1_1)
x1_B <- (p2 / p1_1) * x2_B

# Gasto compensado de Hicks al nuevo vector de precios
E_comp_Hicks <- p1_1 * x1_B + p2 * x2_B

# Variacion Compensatoria (CV): Cuanto ingreso se le puede retirar al consumidor
# a los nuevos precios para dejarlo en su bienestar original U_0
CV <- I_0 - E_comp_Hicks

# Gasto requerido a los precios iniciales para alcanzar el bienestar final U_1
# E(p^0, U_1) = U_1 * (p1_0 / alpha)^alpha * (p2 / beta)^beta (para alpha = 0.5: 2 * sqrt(p1_0 * p2) * U_1)
E_equiv <- (U_1 / ( (alpha^alpha) * (beta^beta) )) * (p1_0^alpha) * (p2^beta)

# Variacion Equivalente (EV): Cuanto ingreso adicional habria que darle a precios
# iniciales para que alcance el nuevo nivel de bienestar U_1
EV <- E_equiv - I_0

# Descomposicion de Hicks sobre el bien 1:
efecto_sustitucion_x1 <- x1_B - x1_A
efecto_ingreso_x1      <- x1_C - x1_B
efecto_total_x1        <- x1_C - x1_A

# Descomposicion de Slutsky (compensacion al poder adquisitivo inicial)
I_slutsky <- p1_1 * x1_A + p2 * x2_A
x1_B_slutsky <- (alpha * I_slutsky) / p1_1
x2_B_slutsky <- (beta * I_slutsky) / p2
efecto_sustitucion_slutsky <- x1_B_slutsky - x1_A
efecto_ingreso_slutsky     <- x1_C - x1_B_slutsky

message(sprintf("Hicks - A: (%.2f, %.2f), B: (%.2f, %.2f), C: (%.2f, %.2f)",
                x1_A, x2_A, x1_B, x2_B, x1_C, x2_C))
message(sprintf("Efecto Sustitucion: +%.3f | Efecto Ingreso: +%.3f | Efecto Total: +%.3f",
                efecto_sustitucion_x1, efecto_ingreso_x1, efecto_total_x1))
message(sprintf("CV (Hicks): %.3f | EV (Hicks): %.3f", CV, EV))

# Visualizacion de la Descomposicion de Hicks
x_seq <- seq(2, 70, length.out = 400)

# Curvas de indiferencia
df_indif_U0 <- data.frame(
  x1 = x_seq,
  x2 = (U_0 / (x_seq^alpha))^(1 / beta),
  Curva = "U0 (Inicial = 25.0)"
)
df_indif_U1 <- data.frame(
  x1 = x_seq,
  x2 = (U_1 / (x_seq^alpha))^(1 / beta),
  Curva = "U1 (Final = 35.36)"
)

# Restricciones presupuestarias
df_ppto_0 <- data.frame(
  x1 = x_seq,
  x2 = (I_0 - p1_0 * x_seq) / p2,
  Tipo = "L0: Presupuesto inicial (p1 = 2, I = 100)"
) %>% filter(x2 >= 0)

df_ppto_1 <- data.frame(
  x1 = x_seq,
  x2 = (I_0 - p1_1 * x_seq) / p2,
  Tipo = "L1: Presupuesto final (p1 = 1, I = 100)"
) %>% filter(x2 >= 0)

df_ppto_comp <- data.frame(
  x1 = x_seq,
  x2 = (E_comp_Hicks - p1_1 * x_seq) / p2,
  Tipo = "Lc: Presupuesto compensado Hicks (p1 = 1, E = 70.71)"
) %>% filter(x2 >= 0)

# Puntos clave
df_puntos <- data.frame(
  x1 = c(x1_A, x1_B, x1_C),
  x2 = c(x2_A, x2_B, x2_C),
  Etiqueta = c("A (Inicial)", "B (Hicks)", "C (Final)"),
  Color = c("#1b9e77", "#d95f02", "#7570b3")
)

p_hicks <- ggplot() +
  # Lineas presupuestarias
  geom_line(data = df_ppto_0, aes(x = x1, y = x2), color = "#4a5568", linewidth = 1.0, linetype = "dashed") +
  geom_line(data = df_ppto_1, aes(x = x1, y = x2), color = "#2b6cb0", linewidth = 1.1) +
  geom_line(data = df_ppto_comp, aes(x = x1, y = x2), color = "#c53030", linewidth = 1.0, linetype = "dotdash") +
  # Curvas de indiferencia
  geom_line(data = df_indif_U0, aes(x = x1, y = x2), color = "#2d3748", linewidth = 0.9) +
  geom_line(data = df_indif_U1, aes(x = x1, y = x2), color = "#2c5282", linewidth = 0.9) +
  # Vectores de descomposicion sobre el eje X
  annotate("segment", x = x1_A, xend = x1_B, y = 3, yend = 3,
           arrow = arrow(length = unit(0.25, "cm")), color = "#c53030", linewidth = 1.1) +
  annotate("text", x = (x1_A + x1_B) / 2, y = 5.5, label = sprintf("E. Sustitucion (+%.2f)", efecto_sustitucion_x1),
           color = "#c53030", fontface = "bold", size = 3.6) +
  annotate("segment", x = x1_B, xend = x1_C, y = 3, yend = 3,
           arrow = arrow(length = unit(0.25, "cm")), color = "#2b6cb0", linewidth = 1.1) +
  annotate("text", x = (x1_B + x1_C) / 2, y = 5.5, label = sprintf("E. Ingreso (+%.2f)", efecto_ingreso_x1),
           color = "#2b6cb0", fontface = "bold", size = 3.6) +
  # Puntos y etiquetas
  geom_point(data = df_puntos, aes(x = x1, y = x2), color = c("#1b9e77", "#c53030", "#2b6cb0"), size = 4) +
  geom_text(data = df_puntos, aes(x = x1, y = x2, label = sprintf("%s\n(%.1f, %.1f)", Etiqueta, x1, x2)),
            vjust = -0.6, hjust = -0.15, fontface = "bold", size = 3.8) +
  # Anotaciones de bienestar (CV y EV)
  annotate("label", x = 50, y = 44,
           label = sprintf("Bienestar Hicks (1939):\nVariacion Compensatoria (CV) = $%.2f\nVariacion Equivalente (EV) = $%.2f\nEfecto Total: +%.1f unidades",
                           CV, EV, efecto_total_x1),
           fill = "#f7fafc", color = "#1a202c", size = 3.5, label.padding = unit(0.4, "lines"), hjust = 0) +
  annotate("text", x = 62, y = 14, label = "U1 (Final)", color = "#2c5282", fontface = "italic", size = 3.6) +
  annotate("text", x = 62, y = 7, label = "U0 (Inicial)", color = "#2d3748", fontface = "italic", size = 3.6) +
  scale_x_continuous(limits = c(0, 75), breaks = seq(0, 75, 10), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 55), breaks = seq(0, 55, 10), expand = c(0, 0)) +
  labs(
    title = "Descomposicion de Hicks: Efecto Sustitucion y Efecto Ingreso",
    subtitle = "Reduccion del precio del bien 1 de p1 = 2 a p1 = 1 | Preferencias Cobb-Douglas U = x1^0.5 * x2^0.5",
    x = "Consumo de Bien 1 (x1)",
    y = "Consumo de Bien 2 (x2)",
    caption = "Fuente: Elaboracion propia con base en John R. Hicks, 'Value and Capital' (1939)."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#1a365d"),
    plot.subtitle = element_text(color = "#4a5568", size = 10.5, margin = margin(b = 10)),
    plot.caption = element_text(face = "italic", color = "#718096", size = 8.5),
    panel.grid.minor = element_blank()
  )

# Guardar figura 1
ruta_fig_hicks <- file.path(dir_salidas, "fig_hicks_descomposicion_sustitucion_ingreso.png")
ggsave(ruta_fig_hicks, plot = p_hicks, width = 9.5, height = 6.5, dpi = 300)
message(sprintf("Guardada figura Hicks en: %s", ruta_fig_hicks))

# ==============================================================================
# PARTE 2: EQUILIBRIO GENERAL DE ARROW-DEBREU EN CAJA DE EDGEWORTH
#          CON MERCADOS COMPLETOS Y ACTIVOS CONTINGENTES DE ARROW
# ==============================================================================
# Economia 2x2: Dos agentes (A y B) y dos estados de la naturaleza (s = 1, s = 2).
# Estado 1: Clima favorable / Auge economico (probabilidad pi_1 = 0.5)
# Estado 2: Clima desfavorable / Recesion (probabilidad pi_2 = 0.5)
pi_1 <- 0.5
pi_2 <- 0.5

# Dotaciones contingentes iniciales
# Agente A: Alta dotacion en estado 1, baja en estado 2
w_A1 <- 80.0
w_A2 <- 20.0

# Agente B: Baja dotacion en estado 1, alta en estado 2 (cobertura complementaria)
w_B1 <- 20.0
w_B2 <- 80.0

# Dotacion agregada total en cada estado
Omega_1 <- w_A1 + w_B1  # 100
Omega_2 <- w_A2 + w_B2  # 100

# Utilidad esperada von Neumann-Morgenstern con aversion al riesgo logaritmica:
# U_i = pi_1 * ln(c_i1) + pi_2 * ln(c_i2)
# TMS_i = (pi_1 / c_i1) / (pi_2 / c_i2) = c_i2 / c_i1 (al ser pi_1 = pi_2 = 0.5)

# En equilibrio walrasiano con activos contingentes de Arrow (q1, q2):
# Agente A maximiza U_A sujeto a: q1*c_A1 + q2*c_A2 = q1*w_A1 + q2*w_A2 = W_A
# Condicion de primer orden: TMS_A = q1 / q2  =>  c_A2 / c_A1 = q1 / q2
# Demandas optimas de activos:
# c_A1 = (pi_1 * W_A) / q1 = (0.5 * W_A) / q1
# c_A2 = (pi_2 * W_A) / q2 = (0.5 * W_A) / q2
# Igualmente para Agente B:
# c_B1 = (0.5 * W_B) / q1
# c_B2 = (0.5 * W_B) / q2

# Vaciado de mercado en estado 1:
# c_A1 + c_B1 = Omega_1 => (0.5*W_A + 0.5*W_B)/q1 = Omega_1
# (0.5 * (q1*Omega_1 + q2*Omega_2)) / q1 = Omega_1
# Como Omega_1 = Omega_2 = 100:
# 50 + 50*(q2/q1) = 100 => q2/q1 = 1.0
q1_eq <- 1.0  # Normalizacion de precio del activo de Arrow 1
q2_eq <- 1.0  # Precio relativo del activo de Arrow 2

# Riquezas de equilibrio:
W_A_eq <- q1_eq * w_A1 + q2_eq * w_A2  # 100.0
W_B_eq <- q1_eq * w_B1 + q2_eq * w_B2  # 100.0

# Asignaciones optimas de equilibrio (suavizamiento total del riesgo):
c_A1_eq <- (pi_1 * W_A_eq) / q1_eq     # 50.0
c_A2_eq <- (pi_2 * W_A_eq) / q2_eq     # 50.0

c_B1_eq <- Omega_1 - c_A1_eq           # 50.0
c_B2_eq <- Omega_2 - c_A2_eq           # 50.0

# Posicion neta en activos de Arrow:
# Agente A vende (w_A1 - c_A1) = 30 unidades del activo contingente 1
# Agente A compra (c_A2 - w_A2) = 30 unidades del activo contingente 2
posicion_neta_A_s1 <- c_A1_eq - w_A1   # -30.0 (vendedor neto en estado 1)
posicion_neta_A_s2 <- c_A2_eq - w_A2   # +30.0 (comprador neto en estado 2)

# Evaluacion de bienestar (Utilidad Esperada y Equivalente Cierto):
# Autarquia (sin mercados de Arrow):
U_A_aut <- pi_1 * log(w_A1) + pi_2 * log(w_A2)
CE_A_aut <- exp(U_A_aut)  # Equivalente Cierto = sqrt(80 * 20) = 40.0
U_B_aut <- pi_1 * log(w_B1) + pi_2 * log(w_B2)
CE_B_aut <- exp(U_B_aut)

# Equilibrio competitivo con mercados completos de Arrow:
U_A_eq <- pi_1 * log(c_A1_eq) + pi_2 * log(c_A2_eq)
CE_A_eq <- exp(U_A_eq)    # Equivalente Cierto = 50.0
U_B_eq <- pi_1 * log(c_B1_eq) + pi_2 * log(c_B2_eq)
CE_B_eq <- exp(U_B_eq)

ganancia_CE_A <- CE_A_eq - CE_A_aut   # +10.0 unidades de consumo
ganancia_CE_B <- CE_B_eq - CE_B_aut   # +10.0 unidades de consumo

message(sprintf("Arrow-Debreu: Precios q1=%.2f, q2=%.2f", q1_eq, q2_eq))
message(sprintf("Asignacion Walrasiana A: (%.1f, %.1f) | B: (%.1f, %.1f)",
                c_A1_eq, c_A2_eq, c_B1_eq, c_B2_eq))
message(sprintf("Bienestar A - Autarquia CE: %.2f | Equilibrio CE: %.2f | Ganancia: +%.2f",
                CE_A_aut, CE_A_eq, ganancia_CE_A))

# Visualizacion de la Caja de Edgeworth para Arrow-Debreu
c1_grid <- seq(1, Omega_1 - 1, length.out = 300)

# Curvas de indiferencia del Agente A (origen inferior izquierdo)
# U_A = sqrt(c_A1 * c_A2) => c_A2 = U^2 / c_A1
df_indif_A_aut <- data.frame(
  c1 = c1_grid,
  c2 = (CE_A_aut^2) / c1_grid
) %>% filter(c2 <= Omega_2)

df_indif_A_eq <- data.frame(
  c1 = c1_grid,
  c2 = (CE_A_eq^2) / c1_grid
) %>% filter(c2 <= Omega_2)

# Curvas de indiferencia del Agente B (origen superior derecho: c_B1 = 100 - c_A1, c_B2 = 100 - c_A2)
# U_B = sqrt((100 - c_A1) * (100 - c_A2)) = CE => 100 - c_A2 = CE^2 / (100 - c_A1) => c_A2 = 100 - CE^2 / (100 - c_A1)
df_indif_B_aut <- data.frame(
  c1 = c1_grid,
  c2 = Omega_2 - (CE_B_aut^2) / (Omega_1 - c1_grid)
) %>% filter(c2 >= 0)

df_indif_B_eq <- data.frame(
  c1 = c1_grid,
  c2 = Omega_2 - (CE_B_eq^2) / (Omega_1 - c1_grid)
) %>% filter(c2 >= 0)

# Curva de contrato: Asignaciones Pareto eficientes donde TMS_A = TMS_B
# c_A2 / c_A1 = (100 - c_A2) / (100 - c_A1) => c_A2 = c_A1 (diagonal de la caja)
df_contrato <- data.frame(
  c1 = seq(0, Omega_1, length.out = 100),
  c2 = seq(0, Omega_2, length.out = 100)
)

# Recta presupuestaria competitiva que pasa por la dotacion (w_A1, w_A2) = (80, 20):
# q1 * c_A1 + q2 * c_A2 = q1 * w_A1 + q2 * w_A2 => c_A2 = 100 - c_A1
df_ppto_arrow <- data.frame(
  c1 = seq(0, Omega_1, length.out = 100),
  c2 = (W_A_eq - q1_eq * seq(0, Omega_1, length.out = 100)) / q2_eq
)

p_arrow <- ggplot() +
  # Marco de la Caja de Edgeworth
  annotate("rect", xmin = 0, xmax = Omega_1, ymin = 0, ymax = Omega_2,
           fill = "#f7fafc", color = "#4a5568", linewidth = 1.0) +
  # Curva de Contrato (Pareto Eficiente / Seguro Completo)
  geom_line(data = df_contrato, aes(x = c1, y = c2),
            color = "#805ad5", linewidth = 1.3, linetype = "dashed") +
  # Curvas de indiferencia de autarquia
  geom_line(data = df_indif_A_aut, aes(x = c1, y = c2), color = "#e53e3e", linetype = "dotted", linewidth = 0.9) +
  geom_line(data = df_indif_B_aut, aes(x = c1, y = c2), color = "#3182ce", linetype = "dotted", linewidth = 0.9) +
  # Curvas de indiferencia de equilibrio
  geom_line(data = df_indif_A_eq, aes(x = c1, y = c2), color = "#c53030", linewidth = 1.0) +
  geom_line(data = df_indif_B_eq, aes(x = c1, y = c2), color = "#2b6cb0", linewidth = 1.0) +
  # Recta presupuestaria de Arrow-Debreu
  geom_line(data = df_ppto_arrow, aes(x = c1, y = c2), color = "#2d3748", linewidth = 1.1) +
  # Puntos clave: Dotacion inicial y Equilibrio
  geom_point(aes(x = w_A1, y = w_A2), color = "#dd6b20", size = 4.5) +
  geom_point(aes(x = c_A1_eq, y = c_A2_eq), color = "#38a169", size = 5.0) +
  # Etiquetas de puntos
  annotate("text", x = w_A1 - 2, y = w_A2 - 4,
           label = sprintf("Dotacion Inicial w\nA:(%d,%d) | B:(%d,%d)", as.integer(w_A1), as.integer(w_A2), as.integer(w_B1), as.integer(w_B2)),
           color = "#dd6b20", fontface = "bold", size = 3.6, hjust = 1) +
  annotate("text", x = c_A1_eq + 3, y = c_A2_eq + 4,
           label = sprintf("Equilibrio Arrow-Debreu E*\nA:(%d,%d) | B:(%d,%d)\nq1/q2 = %.1f",
                           as.integer(c_A1_eq), as.integer(c_A2_eq), as.integer(c_B1_eq), as.integer(c_B2_eq), q1_eq / q2_eq),
           color = "#276749", fontface = "bold", size = 3.8, hjust = 0) +
  # Vector de transaccion financiera
  annotate("segment", x = w_A1, xend = c_A1_eq, y = w_A2, yend = c_A2_eq,
           arrow = arrow(length = unit(0.3, "cm")), color = "#38a169", linewidth = 1.2, linetype = "solid") +
  # Anotaciones explicativas
  annotate("text", x = 12, y = 92, label = "Curva de Contrato:\nSeguro Perfecto (cA1 = cA2)",
           color = "#6b46c1", fontface = "bold", size = 3.5, hjust = 0) +
  annotate("label", x = 5, y = 15,
           label = sprintf("Teorema de Arrow (1953/1964):\nMercados contingentes completos permiten diversificar\ntodo el riesgo idiosincratico.\nEquivalente Cierto: 40.0 -> 50.0 (+25.0%%)"),
           fill = "white", color = "#1a202c", size = 3.4, label.padding = unit(0.35, "lines"), hjust = 0) +
  # Etiquetas de origen
  annotate("text", x = 3, y = 3, label = "Origen Agente A (0,0)", fontface = "bold", size = 3.5, color = "#c53030") +
  annotate("text", x = 97, y = 97, label = "Origen Agente B (100,100)", fontface = "bold", size = 3.5, color = "#2b6cb0", hjust = 1) +
  scale_x_continuous(limits = c(0, Omega_1), breaks = seq(0, 100, 20), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, Omega_2), breaks = seq(0, 100, 20), expand = c(0, 0)) +
  labs(
    title = "Caja de Edgeworth: Equilibrio de Arrow-Debreu con Activos Contingentes de Arrow",
    subtitle = "Reparto optimo de riesgo entre estados contingentes (s1: Auge, s2: Recesion) | Preferencias logaritmicas",
    x = "Consumo del Agente A en Estado 1 (c_A1)  -->  <--  (c_B1) Consumo del Agente B",
    y = "Consumo del Agente A en Estado 2 (c_A2)  -->  <--  (c_B2) Consumo del Agente B",
    caption = "Fuente: Elaboracion propia con base en Kenneth J. Arrow, 'The Role of Securities in Risk-bearing' (1964)."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 13.5, color = "#1a365d"),
    plot.subtitle = element_text(color = "#4a5568", size = 10, margin = margin(b = 10)),
    plot.caption = element_text(face = "italic", color = "#718096", size = 8.5),
    panel.grid.minor = element_blank()
  )

# Guardar figura 2
ruta_fig_arrow <- file.path(dir_salidas, "fig_arrow_equilibrio_general_edgeworth.png")
ggsave(ruta_fig_arrow, plot = p_arrow, width = 9.5, height = 7.5, dpi = 300)
message(sprintf("Guardada figura Arrow en: %s", ruta_fig_arrow))

# ==============================================================================
# PARTE 3: TABLA CONSOLIDADA DE RESULTADOS CUANTITATIVOS (CSV)
# ==============================================================================
df_resultados <- tibble(
  modulo = c(
    rep("Hicks_Descomposicion_Demanda", 8),
    rep("Arrow_Equilibrio_General_Riesgo", 8)
  ),
  concepto = c(
    "Cesta_Inicial_A_x1_x2",
    "Cesta_Final_C_x1_x2",
    "Cesta_Compensada_Hicks_B_x1_x2",
    "Efecto_Sustitucion_Hicks_x1",
    "Efecto_Ingreso_Hicks_x1",
    "Efecto_Total_x1",
    "Variacion_Compensatoria_CV",
    "Variacion_Equivalente_EV",
    "Dotacion_Inicial_Agente_A",
    "Dotacion_Inicial_Agente_B",
    "Precio_Relativo_Arrow_q1_q2",
    "Asignacion_Equilibrio_Agente_A",
    "Asignacion_Equilibrio_Agente_B",
    "Equivalente_Cierto_Autarquia_A",
    "Equivalente_Cierto_Equilibrio_A",
    "Ganancia_Bienestar_Equivalente_Cierto_A"
  ),
  valor_numerico = c(
    x1_A,
    x1_C,
    x1_B,
    efecto_sustitucion_x1,
    efecto_ingreso_x1,
    efecto_total_x1,
    CV,
    EV,
    w_A1,
    w_B1,
    q1_eq / q2_eq,
    c_A1_eq,
    c_B1_eq,
    CE_A_aut,
    CE_A_eq,
    ganancia_CE_A
  ),
  unidad_o_detalle = c(
    sprintf("Cesta (%.2f, %.2f) a precios (2.0, 2.0)", x1_A, x2_A),
    sprintf("Cesta (%.2f, %.2f) a precios (1.0, 2.0)", x1_C, x2_C),
    sprintf("Cesta (%.2f, %.2f) manteniendo U0=%.2f", x1_B, x2_B, U_0),
    "Unidades adicionales de bien 1 por cambio en precio relativo",
    "Unidades adicionales de bien 1 por aumento de poder adquisitivo",
    "Cambio total observado en la cantidad demandada de bien 1",
    "Monto en USD que compensa exactamente el cambio de precios ($)",
    "Monto en USD equivalente a precios originales ($)",
    sprintf("Dotacion estados (s1=%d, s2=%d)", as.integer(w_A1), as.integer(w_A2)),
    sprintf("Dotacion estados (s1=%d, s2=%d)", as.integer(w_B1), as.integer(w_B2)),
    "Ratio de precios de activos contingentes de Arrow q1*/q2*",
    sprintf("Consumo suavizado en estados s1 y s2 (%.1f, %.1f)", c_A1_eq, c_A2_eq),
    sprintf("Consumo suavizado en estados s1 y s2 (%.1f, %.1f)", c_B1_eq, c_B2_eq),
    "Nivel de consumo cierto que rinde igual utilidad en autarquia",
    "Nivel de consumo cierto alcanzado con mercados completos de Arrow",
    "Aumento en el consumo equivalente cierto gracias al mercado de seguros (+25.0%)"
  )
)

ruta_tabla <- file.path(dir_salidas, "tab_resultados_hicks_arrow_1972.csv")
write_csv(df_resultados, ruta_tabla)
message(sprintf("Guardada tabla consolidada en: %s", ruta_tabla))

message("=== Replicacion ejecutada exitosamente sin errores ===")

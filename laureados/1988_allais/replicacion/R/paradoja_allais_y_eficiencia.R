# ==============================================================================
# Script: paradoja_allais_y_eficiencia.R
# Laureado: Maurice Allais (Premio Nobel de Economia 1988)
# Descripcion:
#   1. Modelizacion y visualizacion de la Paradoja de Allais (1953) en el
#      triangulo de probabilidades de Marschak-Machina (1982), demostrando
#      la violacion del axioma de independencia de la Utilidad Esperada
#      y la hipotesis de apertura en abanico (fanning out).
#   2. Simulacion del modelo de equilibrio y tarificacion optima en monopolio
#      natural (Allais 1943 / Boiteux 1956): comparacion analitica entre
#      Monopolio No Regulado, Tarificacion al Costo Medio y Regla de Allais (P = CMg).
#   3. Generacion y exportacion de figuras en alta resolucion y tabla de datos.
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
})

# Definicion de rutas relativas y absolutas seguras
directorio_actual <- tryCatch({
  dirname(normalizePath(sys.frame(1)$ofile))
}, error = function(e) {
  getwd()
})

# Asegurar carpeta de salidas
ruta_salidas <- file.path(dirname(directorio_actual), "salidas")
if (!dir.exists(ruta_salidas)) {
  # Si se ejecuta desde la raiz del repositorio
  ruta_salidas <- file.path("laureados", "1988_allais", "replicacion", "salidas")
  if (!dir.exists(ruta_salidas)) {
    dir.create(ruta_salidas, recursive = TRUE, showWarnings = FALSE)
  }
}

cat("==> Directorio de salidas configurado en:", ruta_salidas, "\n")

# ==============================================================================
# SECCION 1: PARADOJA DE ALLAIS Y TRIANGULO DE MARSCHAK-MACHINA
# ==============================================================================
cat("1. Generando simulacion y grafico de la Paradoja de Allais...\n")

# En el triangulo de Marschak-Machina:
# 3 resultados: x1 = 0 francos, x2 = 100M francos, x3 = 500M francos
# p1 = Pr(x1), p3 = Pr(x3), p2 = 1 - p1 - p3
# Espacio: p1 >= 0, p3 >= 0, p1 + p3 <= 1

loterias <- data.frame(
  id = c("L1 (A)", "L2 (B)", "L3 (C)", "L4 (D)"),
  par = c("Par 1", "Par 1", "Par 2", "Par 2"),
  eleccion = c("Mayoritaria (82%)", "Minoritaria (18%)", "Minoritaria (17%)", "Mayoritaria (83%)"),
  p1 = c(0.00, 0.01, 0.89, 0.90),
  p3 = c(0.00, 0.10, 0.00, 0.10),
  label = c("L1: 100M seguro\n(p1=0, p3=0)",
            "L2: 10% 500M, 89% 100M, 1% 0\n(p1=0.01, p3=0.10)",
            "L3: 11% 100M, 89% 0\n(p1=0.89, p3=0)",
            "L4: 10% 500M, 90% 0\n(p1=0.90, p3=0.10)")
)

# Vectores paralelos de desplazamiento:
# De L1 a L2: Delta p1 = 0.01, Delta p3 = 0.10 (pendiente = 10)
# De L3 a L4: Delta p1 = 0.01, Delta p3 = 0.10 (pendiente = 10)

segmentos_loterias <- data.frame(
  x = c(0.00, 0.89),
  y = c(0.00, 0.00),
  xend = c(0.01, 0.90),
  yend = c(0.10, 0.10),
  par = c("Par 1: L1 -> L2 (Pendiente = 10)", "Par 2: L3 -> L4 (Pendiente = 10)")
)

# Curvas de indiferencia no lineales que reproducen la apertura en abanico (Fanning out de Machina):
# Cerca del origen (alta seguridad): pendiente > 10 (L1 queda por encima de L2)
# Hacia la derecha (alta probabilidad de cero): pendiente < 10 (L4 queda por encima de L3)
p1_seq <- seq(0, 1, length.out = 300)

grid_curvas <- expand.grid(p1 = p1_seq, nivel = c(1, 2, 3, 4, 5)) %>%
  # Funcion de utilidad no lineal ordinal: U(p1, p3) = p3 - (0.05 + 0.12 * (1 - p1)^1.8) * p1 ...
  # Representacion fanning out: curvas de pendiente creciente hacia la izquierda
  mutate(
    # Pendiente dependiente de p1: pendiente m(p1) = 14 - 10 * p1
    # p3 = c_nivel + integral(m(p1)) aproximada
    p3_fanning = case_when(
      nivel == 1 ~ -0.01 + 14 * p1 - 6 * p1^2,
      nivel == 2 ~ 0.04 + 12.5 * p1 - 5.5 * p1^2,
      nivel == 3 ~ 0.08 + 11.2 * p1 - 5.0 * p1^2,
      nivel == 4 ~ -0.05 + 9.5 * p1 - 3.8 * p1^2,
      nivel == 5 ~ -0.15 + 8.2 * p1 - 2.8 * p1^2
    )
  ) %>%
  filter(p1 >= 0, p3_fanning >= 0, p1 + p3_fanning <= 1)

# Curvas de indiferencia de Utilidad Esperada lineal (con pendiente fija m = 10):
# Muestran que si una recta pasa por L1 y deja abajo a L2, forzosamente en el par 2
# L3 deberia ser preferida a L4, contradiciendo el experimento.
grid_eut <- expand.grid(p1 = p1_seq, k = c(0.01, 0.05, -0.05, -0.80, -0.89)) %>%
  mutate(p3_eut = k + 10 * p1) %>%
  filter(p1 >= 0, p3_eut >= 0, p1 + p3_eut <= 1)

p_allais <- ggplot() +
  # Limite del simplex
  geom_polygon(data = data.frame(x = c(0, 1, 0), y = c(0, 0, 1)),
               aes(x = x, y = y), fill = "#f8fafc", color = "#64748b", linewidth = 0.8) +
  # Curvas lineales de la teoria clasica (EUT) en gris discontinuo
  geom_line(data = grid_eut, aes(x = p1, y = p3_eut, group = k),
            color = "#94a3b8", linetype = "dotted", linewidth = 0.6, alpha = 0.7) +
  # Curvas fanning out de Machina (no lineales)
  geom_line(data = grid_curvas, aes(x = p1, y = p3_fanning, group = nivel),
            color = "#0284c7", linewidth = 0.9, alpha = 0.85) +
  # Segmentos de eleccion
  geom_segment(data = segmentos_loterias,
               aes(x = x, y = y, xend = xend, yend = yend),
               color = "#dc2626", linewidth = 1.1, arrow = arrow(length = unit(0.25, "cm"))) +
  # Puntos de las loterias
  geom_point(data = loterias, aes(x = p1, y = p3, color = eleccion), size = 4.5) +
  geom_text(data = loterias, aes(x = p1, y = p3, label = id),
            vjust = c(-1.2, 1.8, -1.2, 1.8),
            hjust = c(-0.1, -0.1, 0.9, 0.9),
            fontface = "bold", size = 3.6, color = "#0f172a") +
  scale_color_manual(values = c("Mayoritaria (82%)" = "#16a34a",
                                "Mayoritaria (83%)" = "#16a34a",
                                "Minoritaria (18%)" = "#9333ea",
                                "Minoritaria (17%)" = "#9333ea")) +
  annotate("text", x = 0.03, y = 0.22,
           label = "Efecto Certeza:\nCurvas mas empinadas\n(L1 preferido a L2)",
           color = "#0369a1", fontface = "bold", size = 3.2, hjust = 0) +
  annotate("text", x = 0.70, y = 0.18,
           label = "Incertidumbre Dominante:\nCurvas mas planas\n(L4 preferido a L3)",
           color = "#0369a1", fontface = "bold", size = 3.2, hjust = 0.5) +
  annotate("text", x = 0.55, y = 0.40,
           label = "Segmentos de cambio paralelos (Pendiente = 10)\nLineas punteadas = Utilidad Esperada lineal (EUT)\nLineas continuas azules = Fanning out (Machina 1982)",
           color = "#475569", size = 3.0, hjust = 0.5, fontface = "italic") +
  scale_x_continuous(limits = c(0, 1.02), breaks = seq(0, 1, 0.2),
                     labels = percent_format(accuracy = 1)) +
  scale_y_continuous(limits = c(0, 1.02), breaks = seq(0, 1, 0.2),
                     labels = percent_format(accuracy = 1)) +
  labs(
    title = "La Paradoja de Allais (1953) en el Triangulo de Marschak-Machina",
    subtitle = "Refutacion de la Utilidad Esperada lineal: el 'Fanning Out' y el Efecto Certeza",
    x = expression(Probabilidad~del~peor~resultado~p[1]~"("*0~francos*")"),
    y = expression(Probabilidad~del~mejor~resultado~p[3]~"("*500~millones~francos*")"),
    color = "Patron de Eleccion Empirica",
    caption = "Fuente: Allais (1953), Econometrica; Machina (1982). Replicacion cuantitativa."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13, color = "#0f172a"),
    plot.subtitle = element_text(color = "#334155", size = 10.5, margin = margin(b = 10)),
    legend.position = "bottom",
    legend.background = element_rect(fill = "#f1f5f9", color = NA),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "white", color = NA)
  )

archivo_fig1 <- file.path(ruta_salidas, "fig_allais_paradoja_triangulo.png")
ggsave(archivo_fig1, plot = p_allais, width = 8.5, height = 7.0, dpi = 300)
cat("   -> Figura guardada:", archivo_fig1, "\n")


# ==============================================================================
# SECCION 2: MODELO DE EFICIENCIA Y TARIFICACION EN MONOPOLIO NATURAL
# ==============================================================================
cat("2. Simulando equilibrio de monopolio natural y regla de costo marginal de Allais...\n")

# Parametros de mercado representativos:
# Demanda: P(Q) = 120 - Q
# Costo Total: C(Q) = F + c * Q = 800 + 20 * Q
# CMg = 20
# CMe(Q) = 800/Q + 20

a <- 120
b <- 1
F_fijo <- 800
c_mg <- 20

# 1. Monopolio Privado no regulado:
# IMg = a - 2*b*Q = c_mg => Q_mon = (a - c_mg) / (2*b)
Q_mon <- (a - c_mg) / (2 * b)
P_mon <- a - b * Q_mon
CS_mon <- 0.5 * (a - P_mon) * Q_mon
Benef_mon <- (P_mon - c_mg) * Q_mon - F_fijo
Excedente_mon <- CS_mon + Benef_mon
DWL_mon <- 0.5 * (P_mon - c_mg) * (((a - c_mg)/b) - Q_mon)

# 2. Tarificacion al Costo Medio (Equilibrio de Presupuesto Balanceado sin Subsidio):
# a - b*Q = F/Q + c_mg => b*Q^2 - (a - c_mg)*Q + F = 0
# Q^2 - 100*Q + 800 = 0
discrim <- (a - c_mg)^2 - 4 * b * F_fijo
Q_cme <- ((a - c_mg) + sqrt(discrim)) / (2 * b)
P_cme <- a - b * Q_cme
CS_cme <- 0.5 * (a - P_cme) * Q_cme
Benef_cme <- (P_cme * Q_cme) - (F_fijo + c_mg * Q_cme)  # Identicamente 0
Excedente_cme <- CS_cme + Benef_cme
DWL_cme <- 0.5 * (P_cme - c_mg) * (((a - c_mg)/b) - Q_cme)

# 3. Regla de Eficiencia de Allais (Primer Mejor: P = CMg):
# P = c_mg => Q = (a - c_mg)/b
Q_allais <- (a - c_mg) / b
P_allais <- c_mg
CS_allais <- 0.5 * (a - P_allais) * Q_allais
Benef_allais <- (P_allais - c_mg) * Q_allais - F_fijo  # Deficit = -F_fijo = -800
Excedente_allais <- CS_allais + Benef_allais
DWL_allais <- 0  # Maximo bienestar social paretiano

# Crear curvas continuas para el grafico
q_grid <- seq(5, 115, length.out = 300)
curvas_costo <- data.frame(
  Q = q_grid,
  Demanda = a - b * q_grid,
  IMg = ifelse(a - 2 * b * q_grid >= 0, a - 2 * b * q_grid, NA),
  CMg = rep(c_mg, length(q_grid)),
  CMe = (F_fijo / q_grid) + c_mg
)

puntos_equilibrio <- data.frame(
  Regimen = c("1. Monopolio Privado (IMg = CMg)",
              "2. Tarificacion al Costo Medio (P = CMe)",
              "3. Regla de Allais / Primer Mejor (P = CMg)"),
  Q = c(Q_mon, Q_cme, Q_allais),
  P = c(P_mon, P_cme, P_allais),
  color = c("#dc2626", "#eab308", "#16a34a")
)

# Poligono de perdida irrecuperable del monopolio privado
dwl_poly <- data.frame(
  x = c(Q_mon, Q_allais, Q_mon),
  y = c(P_mon, c_mg, c_mg)
)

# Poligono del deficit publico bajo Allais (Q de 0 a Q_allais entre CMe y CMg)
# El deficit es exactamente igual al costo fijo F = 800
deficit_poly <- data.frame(
  x = c(0, Q_allais, Q_allais, 0),
  y = c(P_allais, P_allais, (F_fijo/Q_allais) + c_mg, (F_fijo/Q_allais) + c_mg)
)

p_eficiencia <- ggplot() +
  # Area de perdida irrecuperable de eficiencia bajo monopolio privado
  geom_polygon(data = dwl_poly, aes(x = x, y = y), fill = "#fecaca", alpha = 0.55) +
  # Curvas
  geom_line(data = curvas_costo, aes(x = Q, y = Demanda), color = "#1e293b", linewidth = 1.1) +
  geom_line(data = curvas_costo, aes(x = Q, y = IMg), color = "#64748b", linetype = "dashed", linewidth = 0.9) +
  geom_line(data = curvas_costo, aes(x = Q, y = CMe), color = "#d97706", linewidth = 1.1) +
  geom_line(data = curvas_costo, aes(x = Q, y = CMg), color = "#059669", linewidth = 1.1) +
  # Puntos de operacion
  geom_point(data = puntos_equilibrio, aes(x = Q, y = P, color = Regimen), size = 4) +
  # Segmentos de referencia
  geom_segment(data = puntos_equilibrio,
               aes(x = Q, y = 0, xend = Q, yend = P, color = Regimen),
               linetype = "dotted", linewidth = 0.7) +
  geom_segment(data = puntos_equilibrio,
               aes(x = 0, y = P, xend = Q, yend = P, color = Regimen),
               linetype = "dotted", linewidth = 0.7) +
  # Anotaciones
  annotate("text", x = 110, y = 14, label = "Demanda P(Q)", color = "#1e293b", fontface = "bold", size = 3.3) +
  annotate("text", x = 58, y = 8, label = "IMg", color = "#64748b", fontface = "bold", size = 3.3) +
  annotate("text", x = 110, y = 32, label = "CMe(Q)", color = "#d97706", fontface = "bold", size = 3.3) +
  annotate("text", x = 110, y = 23, label = "CMg = 20", color = "#059669", fontface = "bold", size = 3.3) +
  annotate("text", x = 65, y = 42,
           label = "Perdida Social del Monopolio\n(DWL = $1,250)",
           color = "#991b1b", fontface = "bold", size = 3.0) +
  annotate("label", x = 95, y = 75,
           label = "Regla de Allais (1943):\nP = CMg maximiza el Excedente Social,\npero exige subsidio fiscal de explotacion\npara cubrir el costo fijo F ($800)",
           color = "#065f46", fill = "#ecfdf5", size = 3.1, hjust = 0.5) +
  scale_color_manual(values = c(
    "1. Monopolio Privado (IMg = CMg)" = "#dc2626",
    "2. Tarificacion al Costo Medio (P = CMe)" = "#d97706",
    "3. Regla de Allais / Primer Mejor (P = CMg)" = "#059669"
  )) +
  scale_x_continuous(limits = c(0, 120), breaks = seq(0, 120, 20)) +
  scale_y_continuous(limits = c(0, 125), breaks = seq(0, 120, 20)) +
  labs(
    title = "Tarificacion Eficiente en Monopolio Natural: La Teoria de Maurice Allais",
    subtitle = "Comparacion entre Monopolio Privado, Tarificacion al Costo Medio y Primer Mejor de Allais (P = CMg)",
    x = "Cantidad producida (Q)",
    y = "Precio y Costes unitarios ($)",
    color = "Regimen Regulatorio / Asignativo",
    caption = "Fuente: Allais (1943, Traite d'economie pure); Boiteux (1956). Replicacion cuantitativa."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13, color = "#0f172a"),
    plot.subtitle = element_text(color = "#334155", size = 10, margin = margin(b = 10)),
    legend.position = "bottom",
    legend.background = element_rect(fill = "#f8fafc", color = NA),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "white", color = NA)
  )

archivo_fig2 <- file.path(ruta_salidas, "fig_allais_tarificacion_costo_marginal.png")
ggsave(archivo_fig2, plot = p_eficiencia, width = 8.5, height = 7.0, dpi = 300)
cat("   -> Figura guardada:", archivo_fig2, "\n")


# ==============================================================================
# SECCION 3: TABLA DE RESULTADOS COMPARATIVOS
# ==============================================================================
cat("3. Generando tabla de resultados comparativos...\n")

tab_resultados <- data.frame(
  dimension = c(
    "1. Paradoja Allais: Eleccion Par 1",
    "1. Paradoja Allais: Eleccion Par 2",
    "1. Paradoja Allais: Tasa Violacion EUT",
    "2. Tarificacion: Monopolio No Regulado",
    "2. Tarificacion: Costo Medio (CMe)",
    "2. Tarificacion: Primer Mejor Allais (P=CMg)",
    "2. Eficiencia: Ganancia Social vs Monopolio"
  ),
  regimen_o_prueba = c(
    "L1 (Certeza 100M) vs L2 (Loteria arriesgada)",
    "L4 (Loteria 10% 500M) vs L3 (11% 100M)",
    "Porcentaje de sujetos que eligen L1 y L4",
    "Maximiza beneficio privado (IMg = CMg)",
    "Equilibrio presupuestario cero (P = CMe)",
    "Optimo paretiano de bienestar (P = CMg)",
    "Incremento de excedente social total"
  ),
  precio_o_tasa = c(
    "L1: 82% eligen certeza",
    "L4: 83% eligen mayor premio",
    "80% de inconsistencia empirica",
    paste0("$", sprintf("%.2f", P_mon)),
    paste0("$", sprintf("%.2f", P_cme)),
    paste0("$", sprintf("%.2f", P_allais)),
    paste0("+$", sprintf("%.2f", Excedente_allais - Excedente_mon))
  ),
  cantidad_producida = c(
    "N/A", "N/A", "N/A",
    sprintf("%.2f", Q_mon),
    sprintf("%.2f", Q_cme),
    sprintf("%.2f", Q_allais),
    paste0("+", sprintf("%.2f", Q_allais - Q_mon))
  ),
  excedente_consumidor = c(
    "N/A", "N/A", "N/A",
    paste0("$", sprintf("%.2f", CS_mon)),
    paste0("$", sprintf("%.2f", CS_cme)),
    paste0("$", sprintf("%.2f", CS_allais)),
    paste0("+$", sprintf("%.2f", CS_allais - CS_mon))
  ),
  beneficio_productor = c(
    "N/A", "N/A", "N/A",
    paste0("$", sprintf("%.2f", Benef_mon)),
    paste0("$", sprintf("%.2f", Benef_cme)),
    paste0("-$", sprintf("%.2f", abs(Benef_allais)), " (Deficit)"),
    paste0("-$", sprintf("%.2f", Benef_mon - Benef_allais))
  ),
  bienestar_total = c(
    "N/A", "N/A", "N/A",
    paste0("$", sprintf("%.2f", Excedente_mon)),
    paste0("$", sprintf("%.2f", Excedente_cme)),
    paste0("$", sprintf("%.2f", Excedente_allais)),
    paste0("+$", sprintf("%.2f", Excedente_allais - Excedente_mon))
  ),
  perdida_eficiencia_dwl = c(
    "Refuta Axioma de Independencia",
    "Confirma Apertura en Abanico",
    "Efecto Certeza demostrable",
    paste0("$", sprintf("%.2f", DWL_mon)),
    paste0("$", sprintf("%.2f", DWL_cme)),
    "$0.00 (Eficiencia Absoluta)",
    "Pobreza paretiana eliminada"
  )
)

archivo_tabla <- file.path(ruta_salidas, "tab_resultados_allais.csv")
write.csv(tab_resultados, archivo_tabla, row.names = FALSE)
cat("   -> Tabla guardada:", archivo_tabla, "\n")

cat("\n==> Replicacion de Maurice Allais finalizada con exito total.\n")

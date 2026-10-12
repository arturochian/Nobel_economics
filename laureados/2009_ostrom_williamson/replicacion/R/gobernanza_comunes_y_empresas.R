# ==============================================================================
# Script: gobernanza_comunes_y_empresas.R
# Laureados: Elinor Ostrom y Oliver E. Williamson (Premio Nobel de Economia 2009)
# Descripcion:
#   1. Simulacion del dilema de apropiacion de recursos de uso comun (CPR) de Ostrom
#      (1990, 1994), contrastando la Tragedia de Hardin con la gobernanza institucional
#      comunitaria basada en monitoreo y reglas locales.
#   2. Simulacion del modelo de costos de transaccion y especificidad de activos
#      de Williamson (1985, 1991), modelando la eleccion optima entre Mercado,
#      Contrato Hibrido y Jerarquia (Empresa).
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
})

# Establecer semilla para reproducibilidad
set.seed(2009)

# Directorio de salida
dir_salidas <- file.path("laureados", "2009_ostrom_williamson", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

# ------------------------------------------------------------------------------
# 1. MODELO DE ELINOR OSTROM: DILEMA DE RECURSOS DE USO COMUN (CPR)
# ------------------------------------------------------------------------------
# Parametros del juego CPR:
# N = 8 apropiadores
# Dotacion individual e = 10 fichas (total = 80 fichas)
# Costo de oportunidad / retorno exterior seguro: w = 5 por ficha
# Retorno del recurso comun: F(X) = a*X - b*X^2 con a = 25, b = 0.25
# Retorno medio: a - b*X. Retorno marginal: a - 2*b*X.

N <- 8
e <- 10
w <- 5
a <- 25
b <- 0.25
T_periodos <- 20

# Solucion teorica:
# Optimo Social (Pareto eficiente): F'(X*) = w  =>  a - 2*b*X* = w  =>  X* = (a - w)/(2*b)
X_optimo <- (a - w) / (2 * b)
x_optimo_ind <- X_optimo / N
pi_optimo_total <- (a * X_optimo - b * X_optimo^2) + w * (N * e - X_optimo)
renta_maxima <- (a * X_optimo - b * X_optimo^2) - w * X_optimo

# Equilibrio de Nash (Hardin - Tragedia de los Comunes sin comunicacion):
# Cada agente maximiza x_i*(a - b*(x_i + X_{-i})) + w*(e - x_i)
# FOC: a - b*X - b*x_i - w = 0  =>  (N + 1)*b*x_nash = a - w  =>  x_nash = (a - w)/((N+1)*b)
x_nash_ind <- (a - w) / ((N + 1) * b)
X_nash <- N * x_nash_ind
pi_nash_total <- (a * X_nash - b * X_nash^2) + w * (N * e - X_nash)
renta_nash <- (a * X_nash - b * X_nash^2) - w * X_nash

cat("=== PARAMETROS TEORICOS DE OSTROM ===\n")
cat("Optimo Social: Esfuerzo agregado X* =", X_optimo, "| Esfuerzo indiv =", round(x_optimo_ind, 2), "\n")
cat("Equilibrio de Nash (Hardin): Esfuerzo agregado X_NE =", round(X_nash, 2), "| Esfuerzo indiv =", round(x_nash_ind, 2), "\n")
cat("Renta economica optima =", renta_maxima, "| Renta Nash =", round(renta_nash, 2), "\n\n")

# Simulacion dinamica a lo largo de 20 rondas con 3 regímenes:
# 1. Tragedia de Hardin (Acceso abierto no cooperativo):
#    Apropiadores miopes aumentan la extraccion guiados por sobreexplotacion
# 2. Gobernanza de Ostrom (Reglas comunitarias, comunicacion cara a cara, monitoreo mutuo):
#    Apropiadores pactan la cuota cooperativa; quienes se desvian sufren sanciones graduales
# 3. Regulacion Estatal Centralizada (Comando y control externo con costo burocratico):
#    Fija cuota optima pero con 15% de costo administrativo de fiscalizacion

sim_ostrom <- data.frame()

for (t in 1:T_periodos) {
  # Regimen 1: Hardin (convergencia a sobreexplotacion)
  # Comienza con algo de mesura pero escala por falta de confianza
  peso_hardin <- min(1, 0.4 + 0.6 * (t / 10))
  X_h <- (1 - peso_hardin) * (X_optimo * 1.1) + peso_hardin * X_nash + rnorm(1, 0, 1.2)
  X_h <- min(N * e, max(0, X_h))
  renta_h <- (a * X_h - b * X_h^2) - w * X_h
  eficiencia_h <- max(0, renta_h / renta_maxima) * 100
  
  # Regimen 2: Ostrom (gobernanza comunitaria con aprendizaje y monitoreo)
  # Al inicio calibran normas, convergen al optimo comunitario
  peso_ostrom <- min(1, 0.5 + 0.5 * (t / 6))
  X_o <- (1 - peso_ostrom) * (X_nash * 0.8) + peso_ostrom * (X_optimo * 1.03) + rnorm(1, 0, 0.8)
  X_o <- min(N * e, max(0, X_o))
  renta_o <- (a * X_o - b * X_o^2) - w * X_o
  # Costo menor de monitoreo peer-to-peer (5% de la renta)
  renta_o_neta <- renta_o * 0.95
  eficiencia_o <- max(0, renta_o_neta / renta_maxima) * 100
  
  # Regimen 3: Regulacion Estatal (burocracia externa)
  X_s <- X_optimo * 1.05 + rnorm(1, 0, 1.0)
  renta_s <- (a * X_s - b * X_s^2) - w * X_s
  # Costo burocratico estatal significativo (25% de perdida de peso muerto)
  renta_s_neta <- renta_s * 0.75
  eficiencia_s <- max(0, renta_s_neta / renta_maxima) * 100
  
  sim_ostrom <- rbind(sim_ostrom, data.frame(
    periodo = rep(t, 3),
    regimen = c("Acceso Abierto (Tragedia de Hardin)", 
                "Gobernanza Comunitaria (Ostrom)", 
                "Regulación Estatal Centralizada"),
    esfuerzo = c(X_h, X_o, X_s),
    eficiencia = c(eficiencia_h, eficiencia_o, eficiencia_s)
  ))
}

# Grafico 1: Dilema de Ostrom
p1_a <- ggplot(sim_ostrom, aes(x = periodo, y = esfuerzo, color = regimen, linetype = regimen)) +
  geom_hline(yintercept = X_optimo, linetype = "dashed", color = "#2ca02c", linewidth = 0.9) +
  geom_hline(yintercept = X_nash, linetype = "dotted", color = "#d62728", linewidth = 0.9) +
  geom_line(linewidth = 1.1) +
  geom_point(size = 1.8) +
  annotate("text", x = 3.5, y = X_optimo - 2.5, label = "Óptimo Social (X* = 40)", color = "#2ca02c", fontface = "bold", size = 3.2) +
  annotate("text", x = 3.5, y = X_nash + 2.5, label = "Nash / Hardin (X = 71.1)", color = "#d62728", fontface = "bold", size = 3.2) +
  scale_color_manual(values = c("Acceso Abierto (Tragedia de Hardin)" = "#d62728",
                                "Gobernanza Comunitaria (Ostrom)" = "#1f77b4",
                                "Regulación Estatal Centralizada" = "#ff7f0e")) +
  scale_linetype_manual(values = c("Acceso Abierto (Tragedia de Hardin)" = "solid",
                                  "Gobernanza Comunitaria (Ostrom)" = "solid",
                                  "Regulación Estatal Centralizada" = "longdash")) +
  labs(
    title = "Apropiación del Recurso Común a lo Largo del Tiempo",
    subtitle = "Simulación experimental basada en Ostrom, Gardner y Walker (1994)",
    x = "Ronda de Decisión",
    y = "Esfuerzo Agregado de Extracción (X)",
    color = "Régimen Institucional",
    linetype = "Régimen Institucional"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom", legend.box = "vertical")

p1_b <- ggplot(sim_ostrom, aes(x = periodo, y = eficiencia, color = regimen)) +
  geom_line(linewidth = 1.1) +
  geom_point(size = 1.8) +
  scale_color_manual(values = c("Acceso Abierto (Tragedia de Hardin)" = "#d62728",
                                "Gobernanza Comunitaria (Ostrom)" = "#1f77b4",
                                "Regulación Estatal Centralizada" = "#ff7f0e")) +
  labs(
    title = "Eficiencia Económica (% del Excedente Social Máximo)",
    subtitle = "Neto de costos de monitoreo y burocracia administrativa",
    x = "Ronda de Decisión",
    y = "Eficiencia del Recurso (%)",
    color = "Régimen Institucional"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "none")

# Combinar visualizacion de Ostrom usando patchwork o layout base
# Guardar p1
png(file.path(dir_salidas, "fig_ostrom_dilema_comunes.png"), width = 2400, height = 1500, res = 260)
gridExtra::grid.arrange(p1_a, p1_b, ncol = 2, 
                       top = grid::textGrob("Gobernanza de Bienes Comunes (Elinor Ostrom, 1990)", 
                                           gp = grid::gpar(fontsize = 15, fontface = "bold")))
dev.off()
cat("Guardado: fig_ostrom_dilema_comunes.png\n")


# ------------------------------------------------------------------------------
# 2. MODELO DE OLIVER E. WILLIAMSON: COSTOS DE GOBERNANZA Y ESPECIFICIDAD
# ------------------------------------------------------------------------------
# Modelo de Williamson (1985, 1991):
# Especificidad de activos k in [0, 1]
# Tres estructuras discretas de gobernanza:
# - Mercado (M): Costos burocraticos fijos muy bajos (alpha_M), pero alta vulnerabilidad
#   al oportunismo contractual y holdup cuando k crece (friccion cuadratica beta_M).
#   G_M(k) = alpha_M + beta_M * k^2
# - Hibrido / Contrato Relacional (X): Arbitraje, contratos de largo plazo.
#   G_X(k) = alpha_X + beta_X * k
# - Jerarquia / Empresa Integrada (H): Burocracia interna fija alta (alpha_H), pero
#   inmunidad al holdup mediante autoridad y resolucion interna por fiat.
#   G_H(k) = alpha_H + beta_H * k

k_grid <- seq(0, 1, length.out = 300)

alpha_M <- 10;  beta_M <- 180   # G_M = 10 + 180 * k^2
alpha_X <- 30;  beta_X <- 75    # G_X = 30 + 75 * k
alpha_H <- 65;  beta_H <- 15    # G_H = 65 + 15 * k

G_M <- alpha_M + beta_M * (k_grid^2)
G_X <- alpha_X + beta_X * k_grid
G_H <- alpha_H + beta_H * k_grid

# Calculo de puntos de cruce analiticos:
# Cruce Mercado vs Hibrido: 10 + 180*k^2 = 30 + 75*k  =>  180*k^2 - 75*k - 20 = 0
# Discriminante: (-75)^2 - 4*180*(-20) = 5625 + 14400 = 20025
k1_star <- (75 + sqrt(20025)) / (2 * 180) # ~ 0.6014

# Cruce Hibrido vs Jerarquia: 30 + 75*k = 65 + 15*k  =>  60*k = 35  =>  k2_star = 35/60 = 0.5833
# Con estos parametros especificos, calibremos para que exista la zona intermedia tipica de Williamson:
# Calibracion estilizada canonica:
# G_M(k) = 10 + 120 * k^2
# G_X(k) = 28 + 45 * k
# G_H(k) = 55 + 8 * k

alpha_M <- 10; beta_M <- 120
alpha_X <- 28; beta_X <- 45
alpha_H <- 55; beta_H <- 8

G_M <- alpha_M + beta_M * (k_grid^2)
G_X <- alpha_X + beta_X * k_grid
G_H <- alpha_H + beta_H * k_grid

# Cruce Mercado vs Hibrido: 120*k^2 - 45*k - 18 = 0
# k = (45 + sqrt(45^2 - 4*120*(-18))) / (240) = (45 + sqrt(2025 + 8640)) / 240 = (45 + sqrt(10665)) / 240
k1_star <- (45 + sqrt(45^2 - 4 * 120 * (alpha_M - alpha_X))) / (2 * beta_M)

# Cruce Hibrido vs Jerarquia: 28 + 45*k = 55 + 8*k  =>  37*k = 27  =>  k2_star = 27/37 ~ 0.7297
k2_star <- (alpha_H - alpha_X) / (beta_X - beta_H)

cat("=== UMBRALES DE GOBERNANZA DE WILLIAMSON ===\n")
cat("Umbral k1* (Mercado -> Híbrido) =", round(k1_star, 4), "\n")
cat("Umbral k2* (Híbrido -> Jerarquía) =", round(k2_star, 4), "\n\n")

df_williamson <- data.frame(
  k = rep(k_grid, 3),
  Costo = c(G_M, G_X, G_H),
  Estructura = rep(c("Mercado (M)", "Híbrido / Relacional (X)", "Jerarquía / Empresa (H)"), each = length(k_grid))
)

# Estructura optima envolvente inferior
costo_minimo <- pmin(G_M, G_X, G_H)
df_minimo <- data.frame(k = k_grid, Costo_Min = costo_minimo)

p2 <- ggplot() +
  # Curvas de costos de gobernanza
  geom_line(data = df_williamson, aes(x = k, y = Costo, color = Estructura, linetype = Estructura), linewidth = 1.1) +
  # Envolvente inferior de gobernanza eficiente
  geom_line(data = df_minimo, aes(x = k, y = Costo_Min), color = "black", linewidth = 1.8, alpha = 0.5) +
  # Lineas verticales de transicion
  geom_vline(xintercept = k1_star, linetype = "dashed", color = "gray40", linewidth = 0.8) +
  geom_vline(xintercept = k2_star, linetype = "dashed", color = "gray40", linewidth = 0.8) +
  # Sombreado de zonas optimas
  annotate("rect", xmin = 0, xmax = k1_star, ymin = 0, ymax = 130, fill = "#1f77b4", alpha = 0.08) +
  annotate("rect", xmin = k1_star, xmax = k2_star, ymin = 0, ymax = 130, fill = "#2ca02c", alpha = 0.08) +
  annotate("rect", xmin = k2_star, xmax = 1, ymin = 0, ymax = 130, fill = "#d62728", alpha = 0.08) +
  # Textos explicativos en cada zona
  annotate("text", x = k1_star / 2, y = 120, label = "RÉGIMEN 1:\nMERCADO\n(Incentivos fuertes)", fontface = "bold", size = 3.3, color = "#1f77b4") +
  annotate("text", x = (k1_star + k2_star) / 2, y = 120, label = "RÉGIMEN 2:\nCONTRATO HÍBRIDO\n(Alianzas / JV)", fontface = "bold", size = 3.3, color = "#2ca02c") +
  annotate("text", x = (k2_star + 1) / 2, y = 120, label = "RÉGIMEN 3:\nJERARQUÍA\n(Integración vertical)", fontface = "bold", size = 3.3, color = "#d62728") +
  annotate("text", x = k1_star, y = 15, label = paste0("k1* = ", round(k1_star, 2)), color = "gray20", fontface = "bold", size = 3.2, hjust = -0.1) +
  annotate("text", x = k2_star, y = 15, label = paste0("k2* = ", round(k2_star, 2)), color = "gray20", fontface = "bold", size = 3.2, hjust = -0.1) +
  scale_color_manual(values = c("Mercado (M)" = "#1f77b4", "Híbrido / Relacional (X)" = "#2ca02c", "Jerarquía / Empresa (H)" = "#d62728")) +
  scale_linetype_manual(values = c("Mercado (M)" = "solid", "Híbrido / Relacional (X)" = "dashed", "Jerarquía / Empresa (H)" = "dotdash")) +
  scale_x_continuous(breaks = seq(0, 1, 0.2), limits = c(0, 1)) +
  scale_y_continuous(limits = c(0, 130)) +
  labs(
    title = "Frontera de Costos de Transacción y Límites de la Empresa",
    subtitle = "Modelo de Williamson (1985, 1991): Elección de gobernanza según la especificidad de activos (k)",
    x = "Especificidad de Activos (k: 0 = genérico, 1 = altamente idiosincrásico)",
    y = "Costo Total de Gobernanza G(k)",
    color = "Estructura de Gobernanza",
    linetype = "Estructura de Gobernanza"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom")

ggsave(file.path(dir_salidas, "fig_williamson_costos_transaccion.png"), plot = p2, width = 9.5, height = 6.2, dpi = 300)
cat("Guardado: fig_williamson_costos_transaccion.png\n")


# ------------------------------------------------------------------------------
# 3. TABLA CONSOLIDADA DE RESULTADOS
# ------------------------------------------------------------------------------
# Resumen cuantitativo comparativo de los dos modelos institucionales

tab_resultados <- data.frame(
  Dimension = c(
    "Ostrom: Tragedia de Hardin (Acceso Abierto)",
    "Ostrom: Óptimo Social Cooperativo",
    "Ostrom: Gobernanza Comunitaria (Monitoreo Local)",
    "Ostrom: Regulación Estatal Centralizada",
    "Williamson: Régimen de Mercado Óptimo (k < k1*)",
    "Williamson: Umbral de Transición k1* (Mercado -> Híbrido)",
    "Williamson: Régimen Híbrido Óptimo (k1* <= k < k2*)",
    "Williamson: Umbral de Transición k2* (Híbrido -> Jerarquía)",
    "Williamson: Régimen de Jerarquía Óptimo (k >= k2*)"
  ),
  Mecanismo_Clave = c(
    "Competencia miope individual, sin comunicación ni sanciones",
    "Coordinación perfecta de extracción del recurso",
    "Reglas autónomas, sanciones graduales, confianza recíproca",
    "Inspección jerárquica externa y aparato burocrático",
    "Precios de mercado y contratos estándar con alta potencia",
    "Punto de corte donde el riesgo de holdup supera la ventaja del mercado",
    "Contratos a largo plazo, alianzas estratégicas y arbitraje privado",
    "Punto de corte donde la fricción relacional justifica absorber la firma",
    "Propiedad unificada, resolución interna por fiat y autoridad ejecutiva"
  ),
  Variable_Resultado = c(
    paste0("Esfuerzo X = ", round(X_nash, 1), " (Sobreexplotación)"),
    paste0("Esfuerzo X* = ", round(X_optimo, 1), " (Sustentable)"),
    paste0("Eficiencia media = ", round(mean(sim_ostrom$eficiencia[sim_ostrom$regimen == "Gobernanza Comunitaria (Ostrom)"]), 1), "%"),
    paste0("Eficiencia media = ", round(mean(sim_ostrom$eficiencia[sim_ostrom$regimen == "Regulación Estatal Centralizada"]), 1), "%"),
    paste0("Rango k: [0.00, ", round(k1_star, 2), "]"),
    paste0("k1* = ", round(k1_star, 3)),
    paste0("Rango k: [", round(k1_star, 2), ", ", round(k2_star, 2), "]"),
    paste0("k2* = ", round(k2_star, 3)),
    paste0("Rango k: [", round(k2_star, 2), ", 1.00]")
  ),
  Implicacion_Politica_o_Empresarial = c(
    "Disipación casi total de rentas económicas por falta de reglas.",
    "Punto de referencia para asignación comunitaria o cuotas.",
    "Las comunidades locales gestionan recursos comunes mejor que el libre acceso y con menores costos que el Estado.",
    "El Estado sufre altos costos administrativos y asimetría de información local.",
    "Ideal para bienes estandarizados con activos genéricos (comodities).",
    "Señala la necesidad de salvaguardas contractuales o acuerdos colaborativos.",
    "Equilibrio entre flexibilidad de mercado y salvaguardas bilaterales.",
    "Justifica la integración vertical para neutralizar el chantaje ex-post.",
    "Apropiado para tecnologías propietarias y activos altamente especializados."
  )
)

write.csv(tab_resultados, file.path(dir_salidas, "tab_gobernanza_resultados.csv"), row.names = FALSE, fileEncoding = "UTF-8")
cat("Guardado: tab_gobernanza_resultados.csv\n")
cat("Simulacion completada exitosamente.\n")

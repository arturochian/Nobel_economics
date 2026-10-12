# ==============================================================================
# Nobel de Economía 2005: Robert J. Aumann y Thomas C. Schelling
# Script de Replicación y Simulación:
# 1. Modelo de Segregación Espacial Basado en Agentes de Schelling (1969, 1971)
# 2. Teorema Folk y Juegos Repetidos de Aumann (1959, 1976)
# 3. Equilibrio Correlacionado de Aumann (1974)
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(gridExtra)
})

# Establecer semilla para reproducibilidad estricta
set.seed(2005)

# Directorio base de salidas
salidas_dir <- file.path("laureados", "2005_aumann_schelling", "replicacion", "salidas")
if (!dir.exists(salidas_dir)) {
  dir.create(salidas_dir, recursive = TRUE)
}

# ==============================================================================
# PARTE 1: MODELO DE SEGREGACIÓN ESPACIAL DE THOMAS C. SCHELLING (1969, 1971)
# ==============================================================================
cat("=== Ejecutando Modelo de Segregación de Schelling ===\n")

# Parámetros de la simulación
grid_dim <- 30            # Grilla 30x30 = 900 celdas
prop_grupo_a <- 0.40      # 40% Grupo A (Rojo / Valor 1)
prop_grupo_b <- 0.40      # 40% Grupo B (Azul / Valor 2)
# 20% Celdas Vacías (Valor 0)
umbral_tolerancia <- 0.375 # Tolerancia: feliz si al menos 37.5% (3/8) de vecinos son iguales
max_iter <- 50            # Rondas máximas de reubicación

# Inicialización de la grilla
total_celdas <- grid_dim * grid_dim
n_a <- round(total_celdas * prop_grupo_a)
n_b <- round(total_celdas * prop_grupo_b)
n_vacias <- total_celdas - n_a - n_b

poblacion_inicial <- sample(c(rep(1, n_a), rep(2, n_b), rep(0, n_vacias)))
grilla <- matrix(poblacion_inicial, nrow = grid_dim, ncol = grid_dim)
grilla_inicial <- grilla

# Función para calcular estado de felicidad y ratio de similitud en vecindario de Moore (8 vecinos)
calcular_metricas_celda <- function(g, r, c, umbral) {
  val <- g[r, c]
  if (val == 0) return(list(feliz = TRUE, similitud = NA))
  
  # Coordenadas de los 8 vecinos con condiciones de borde toroidal (grilla periódica)
  filas <- ((r - 2 + c(-1, 0, 1)) %% nrow(g)) + 1
  cols  <- ((c - 2 + c(-1, 0, 1)) %% ncol(g)) + 1
  
  vecinos <- g[filas, cols]
  # Excluir la propia celda
  vecinos[2, 2] <- NA
  vecinos_ocupados <- vecinos[!is.na(vecinos) & vecinos != 0]
  
  if (length(vecinos_ocupados) == 0) {
    return(list(feliz = TRUE, similitud = 1.0))
  }
  
  n_iguales <- sum(vecinos_ocupados == val)
  ratio_similitud <- n_iguales / length(vecinos_ocupados)
  feliz <- (ratio_similitud >= umbral)
  
  return(list(feliz = feliz, similitud = ratio_similitud))
}

# Evaluar toda la grilla
evaluar_grilla <- function(g, umbral) {
  n_r <- nrow(g)
  n_c <- ncol(g)
  felicidad <- matrix(TRUE, nrow = n_r, ncol = n_c)
  similitud <- matrix(NA, nrow = n_r, ncol = n_c)
  
  for (r in 1:n_r) {
    for (c in 1:n_c) {
      if (g[r, c] != 0) {
        res <- calcular_metricas_celda(g, r, c, umbral)
        felicidad[r, c] <- res$feliz
        similitud[r, c] <- res$similitud
      }
    }
  }
  
  ocupados <- (g != 0)
  tasa_satisfaccion <- mean(felicidad[ocupados])
  similitud_media <- mean(similitud[ocupados], na.rm = TRUE)
  
  list(felicidad = felicidad, similitud = similitud,
       tasa_satisfaccion = tasa_satisfaccion, similitud_media = similitud_media)
}

# Trayectoria de convergencia
historial_satisfaccion <- numeric(max_iter + 1)
historial_similitud <- numeric(max_iter + 1)

eval_ini <- evaluar_grilla(grilla, umbral_tolerancia)
historial_satisfaccion[1] <- eval_ini$tasa_satisfaccion
historial_similitud[1] <- eval_ini$similitud_media

cat(sprintf("Ronda 0 (Inicial): Satisfacción = %.2f%%, Similitud Media = %.2f%%\n",
            eval_ini$tasa_satisfaccion * 100, eval_ini$similitud_media * 100))

# Bucle dinámico de reubicación
iter_convergencia <- max_iter
for (iter in 1:max_iter) {
  eval_actual <- evaluar_grilla(grilla, umbral_tolerancia)
  infelices_idx <- which(grilla != 0 & !eval_actual$felicidad, arr.ind = TRUE)
  vacias_idx <- which(grilla == 0, arr.ind = TRUE)
  
  if (nrow(infelices_idx) == 0) {
    iter_convergencia <- iter - 1
    cat(sprintf("Convergencia alcanzada en la ronda %d!\n", iter_convergencia))
    historial_satisfaccion[(iter + 1):(max_iter + 1)] <- eval_actual$tasa_satisfaccion
    historial_similitud[(iter + 1):(max_iter + 1)] <- eval_actual$similitud_media
    break
  }
  
  # Mover agentes infelices a celdas vacías aleatorias
  n_mover <- min(nrow(infelices_idx), nrow(vacias_idx))
  agentes_a_mover <- sample(1:nrow(infelices_idx), n_mover)
  destinos <- sample(1:nrow(vacias_idx), n_mover)
  
  for (k in 1:n_mover) {
    orig <- infelices_idx[agentes_a_mover[k], ]
    dest <- vacias_idx[destinos[k], ]
    grilla[dest[1], dest[2]] <- grilla[orig[1], orig[2]]
    grilla[orig[1], orig[2]] <- 0
  }
  
  eval_post <- evaluar_grilla(grilla, umbral_tolerancia)
  historial_satisfaccion[iter + 1] <- eval_post$tasa_satisfaccion
  historial_similitud[iter + 1] <- eval_post$similitud_media
}

eval_fin <- evaluar_grilla(grilla, umbral_tolerancia)
grilla_final <- grilla

cat(sprintf("Ronda Final: Satisfacción = %.2f%%, Similitud Media = %.2f%%\n",
            eval_fin$tasa_satisfaccion * 100, eval_fin$similitud_media * 100))

# Visualización del modelo de Schelling
# Convertir matrices a data frames para ggplot2
df_grilla_ini <- expand.grid(x = 1:grid_dim, y = 1:grid_dim)
df_grilla_ini$grupo <- factor(as.vector(grilla_inicial), levels = c(0, 1, 2),
                              labels = c("Vacío", "Grupo A (Rojo)", "Grupo B (Azul)"))

df_grilla_fin <- expand.grid(x = 1:grid_dim, y = 1:grid_dim)
df_grilla_fin$grupo <- factor(as.vector(grilla_final), levels = c(0, 1, 2),
                              labels = c("Vacío", "Grupo A (Rojo)", "Grupo B (Azul)"))

df_dinamica <- data.frame(
  Ronda = 0:max_iter,
  Satisfaccion = historial_satisfaccion * 100,
  Similitud = historial_similitud * 100
)

# Colores sobrios institucionales
colores_agentes <- c("Vacío" = "#F0F0F0", "Grupo A (Rojo)" = "#D95F02", "Grupo B (Azul)" = "#1F78B4")

p1 <- ggplot(df_grilla_ini, aes(x = x, y = y, fill = grupo)) +
  geom_tile(color = "white", linewidth = 0.3) +
  scale_fill_manual(values = colores_agentes) +
  coord_fixed() +
  theme_minimal(base_size = 11) +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(face = "bold", size = 11, hjust = 0.5),
        plot.subtitle = element_text(size = 9, hjust = 0.5)) +
  labs(title = "A. Distribución Inicial (t = 0)",
       subtitle = sprintf("Similitud media: %.1f%% | Satisfacción: %.1f%%",
                          eval_ini$similitud_media * 100, eval_ini$tasa_satisfaccion * 100))

p2 <- ggplot(df_grilla_fin, aes(x = x, y = y, fill = grupo)) +
  geom_tile(color = "white", linewidth = 0.3) +
  scale_fill_manual(values = colores_agentes) +
  coord_fixed() +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom",
        legend.title = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(face = "bold", size = 11, hjust = 0.5),
        plot.subtitle = element_text(size = 9, hjust = 0.5)) +
  labs(title = sprintf("B. Distribución Final Convergida (t = %d)", iter_convergencia),
       subtitle = sprintf("Similitud media: %.1f%% | Satisfacción: %.1f%%",
                          eval_fin$similitud_media * 100, eval_fin$tasa_satisfaccion * 100))

p3 <- ggplot(df_dinamica, aes(x = Ronda)) +
  geom_line(aes(y = Similitud, color = "Similitud Vecinal Media (%)"), linewidth = 1.1) +
  geom_line(aes(y = Satisfaccion, color = "Tasa de Agentes Satisfechos (%)"), linewidth = 1.1, linetype = "dashed") +
  geom_hline(yintercept = umbral_tolerancia * 100, linetype = "dotted", color = "gray40") +
  annotate("text", x = max_iter * 0.7, y = umbral_tolerancia * 100 - 3,
           label = sprintf("Umbral de tolerancia mínima (%.1f%%)", umbral_tolerancia * 100),
           size = 3.2, color = "gray30") +
  scale_color_manual(values = c("Similitud Vecinal Media (%)" = "#2C3E50",
                                "Tasa de Agentes Satisfechos (%)" = "#27AE60")) +
  scale_y_continuous(limits = c(30, 100), breaks = seq(30, 100, 10)) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom",
        legend.title = element_blank(),
        plot.title = element_text(face = "bold", size = 11, hjust = 0.5),
        panel.grid.minor = element_blank()) +
  labs(title = "C. Dinámica Macro Emergente",
       x = "Rondas de Reubicación",
       y = "Porcentaje (%)")

# Gráfico combinado de Schelling
fig_schelling <- gridExtra::arrangeGrob(
  p1, p2, p3,
  layout_matrix = rbind(c(1, 2), c(3, 3)),
  top = grid::textGrob(
    "Modelo de Segregación Espacial de Thomas C. Schelling (1969, 1971)\nPreferencia leve individual (37.5%) genera macro-segregación espontánea no intencionada",
    gp = grid::gpar(fontsize = 13, fontface = "bold")
  )
)

ggsave(filename = file.path(salidas_dir, "fig_schelling_segregacion.png"),
       plot = fig_schelling, width = 10, height = 9, dpi = 300)
cat("Guardado: fig_schelling_segregacion.png\n")


# ==============================================================================
# PARTE 2: TEOREMA FOLK Y JUEGOS REPETIDOS DE ROBERT J. AUMANN (1959, 1976)
# ==============================================================================
cat("\n=== Ejecutando Análisis de Aumann: Teorema Folk y Equilibrio Correlacionado ===\n")

# Matriz de pagos del Dilema del Prisionero
# C = Cooperar, D = Defeccionar
# (R=3, R=3), (S=0, T=5), (T=5, S=0), (P=1, P=1)
R <- 3 # Recompensa por cooperación mutua
T_val <- 5 # Tentación de defraudar
S <- 0 # Pago del incauto (sucker)
P <- 1 # Castigo por defección mutua

v_minimax <- P # Nivel de reserva / minimax en estrategias puras

# 1. Región de Pagos Factibles e Individualmente Racionales (Folk Theorem)
# Vértices del polígono de pagos factibles: (3,3), (5,0), (1,1), (0,5)
vertices_factibles <- data.frame(
  u1 = c(0, 1, 5, 3, 0),
  u2 = c(5, 1, 0, 3, 5)
)

# Región Folk Theorem: Factible y u1 >= 1, u2 >= 1
vertices_folk <- data.frame(
  u1 = c(1, 4.2, 3, 1),
  u2 = c(4.2, 1, 3, 1)
)

p_folk_a <- ggplot() +
  geom_polygon(data = vertices_factibles, aes(x = u1, y = u2), fill = "#BDC3C7", alpha = 0.4) +
  geom_polygon(data = data.frame(u1 = c(1, 4.2, 3, 1), u2 = c(4.2, 1, 3, 1)),
               aes(x = u1, y = u2), fill = "#3498DB", alpha = 0.5) +
  geom_point(aes(x = c(3, 5, 0, 1), y = c(3, 0, 5, 1)), color = "#2C3E50", size = 3) +
  annotate("text", x = 3, y = 3.3, label = "Cooperación (3, 3)", fontface = "bold", size = 3.5) +
  annotate("text", x = 1, y = 0.7, label = "Nash Estático (1, 1)", fontface = "bold", color = "#C0392B", size = 3.5) +
  annotate("text", x = 5, y = 0.3, label = "(5, 0) [T, S]", size = 3) +
  annotate("text", x = 0.3, y = 5, label = "(0, 5) [S, T]", size = 3) +
  geom_vline(xintercept = v_minimax, linetype = "dashed", color = "#C0392B", linewidth = 0.8) +
  geom_hline(yintercept = v_minimax, linetype = "dashed", color = "#C0392B", linewidth = 0.8) +
  annotate("text", x = 2.2, y = 2.2, label = "Conjunto del\nTeorema Folk\n(Sustentable si delta >= 0.5)",
           color = "#1B4F72", fontface = "bold", size = 3.5) +
  scale_x_continuous(limits = c(-0.5, 5.5), breaks = 0:5) +
  scale_y_continuous(limits = c(-0.5, 5.5), breaks = 0:5) +
  theme_minimal(base_size = 11) +
  labs(title = "A. Espacio de Pagos y Teorema Folk (Aumann 1959)",
       subtitle = "La región azul contiene equilibrios perfectos en subjuegos si el horizonte es infinito",
       x = "Pago Jugador 1 (u1)",
       y = "Pago Jugador 2 (u2)")

# 2. Análisis del Factor de Descuento Crítico (Gatillo Sombrío / Grim Trigger)
# V_coop(delta) promedio normalizado = (1 - delta) * sum(delta^t * R) = R = 3
# V_defect(delta) promedio normalizado = (1 - delta) * (T + sum_{t>=1} delta^t * P) = (1 - delta)*T + delta*P
deltas <- seq(0.01, 0.99, by = 0.01)
pago_norm_coop <- rep(R, length(deltas))
pago_norm_defect <- (1 - deltas) * T_val + deltas * P
pago_norm_nash <- rep(P, length(deltas))

# Factor crítico delta*
delta_critico <- (T_val - R) / (T_val - P) # (5 - 3) / (5 - 1) = 2/4 = 0.5

df_descuento <- data.frame(
  delta = rep(deltas, 3),
  pago = c(pago_norm_coop, pago_norm_defect, pago_norm_nash),
  estrategia = factor(rep(c("Cooperación Sostenida (Grim Trigger)",
                            "Desviación Unilateral Óptima",
                            "Equilibrio de Nash Estático"), each = length(deltas)))
)

p_folk_b <- ggplot() +
  geom_line(data = df_descuento, aes(x = delta, y = pago, color = estrategia, linetype = estrategia), linewidth = 1.1) +
  geom_vline(xintercept = delta_critico, linetype = "dotted", color = "#C0392B", linewidth = 1) +
  annotate("point", x = delta_critico, y = R, size = 4, color = "#C0392B") +
  annotate("text", x = delta_critico + 0.18, y = 3.8,
           label = sprintf("delta* = %.2f (Umbral crítico de Aumann)\nCooperación es equilibrio para delta >= 0.50", delta_critico),
           size = 3.2, fontface = "bold", color = "#922B21") +
  scale_color_manual(values = c("Cooperación Sostenida (Grim Trigger)" = "#27AE60",
                                "Desviación Unilateral Óptima" = "#E67E22",
                                "Equilibrio de Nash Estático" = "#7F8C8D")) +
  scale_linetype_manual(values = c("Cooperación Sostenida (Grim Trigger)" = "solid",
                                   "Desviación Unilateral Óptima" = "dashed",
                                   "Equilibrio de Nash Estático" = "dotdash")) +
  scale_x_continuous(breaks = seq(0, 1, 0.2)) +
  scale_y_continuous(breaks = seq(1, 5, 1), limits = c(0.8, 5.2)) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom",
        legend.title = element_blank(),
        plot.title = element_text(face = "bold", size = 11)) +
  labs(title = "B. Factor de Descuento Crítico de Aumann",
       subtitle = "La cooperación se sostiene si el valor del futuro supera la tentación de corto plazo",
       x = "Factor de Descuento Intertemporal (delta)",
       y = "Pago Promedio Normalizado (1 - delta) * V")

# 3. Equilibrio Correlacionado de Aumann (1974) vs Equilibrios de Nash en el Juego del Gallina
# Pagos: Parar/Cruzar
# (Cruzar, Parar) = (7, 2), (Parar, Cruzar) = (2, 7), (Parar, Parar) = (6, 6), (Cruzar, Cruzar) = (0, 0)
# Nash Puros: (7, 2) y (2, 7) -> Asimétricos
# Nash Mixto: p = 2/3 Cruzar -> Pagos esperados = (4.67, 4.67) con prob 4/9 de choque (0,0)!
# Equilibrio Correlacionado con Semáforo (Aumann 1974):
# Señal: 1/3 (Cruzar, Parar), 1/3 (Parar, Cruzar), 1/3 (Parar, Parar).
# Pago esperado = 1/3*7 + 1/3*2 + 1/3*6 = 5.0 para ambos. Sin ningún choque!
df_correlacionado <- data.frame(
  Tipo = c("Nash Puro 1 (Cruzar, Parar)", "Nash Puro 2 (Parar, Cruzar)",
           "Nash Mixto (Independiente)", "Equilibrio Correlacionado (Aumann 1974)",
           "Cooperación Ideal no auto-ejecutable"),
  u1 = c(7, 2, 4.67, 5.0, 6.0),
  u2 = c(2, 7, 4.67, 5.0, 6.0),
  categoria = c("Nash Puro", "Nash Puro", "Nash Mixto", "Equilibrio Correlacionado", "Óptimo Social")
)

p_folk_c <- ggplot(df_correlacionado, aes(x = u1, y = u2, color = categoria, shape = categoria)) +
  geom_point(size = 4.5) +
  geom_text(aes(label = Tipo), vjust = -1, size = 3, fontface = "bold", show.legend = FALSE) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "gray70") +
  scale_color_manual(values = c("Nash Puro" = "#E74C3C",
                                "Nash Mixto" = "#E67E22",
                                "Equilibrio Correlacionado" = "#2980B9",
                                "Óptimo Social" = "#27AE60")) +
  scale_x_continuous(limits = c(1, 8), breaks = 1:8) +
  scale_y_continuous(limits = c(1, 8), breaks = 1:8) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom",
        legend.title = element_blank(),
        plot.title = element_text(face = "bold", size = 11)) +
  labs(title = "C. Equilibrio Correlacionado vs Nash (Aumann 1974)",
       subtitle = "Una señal pública (semáforo) expande los pagos eficientes sin incentivos a desobedecer",
       x = "Pago Jugador 1",
       y = "Pago Jugador 2")

fig_aumann <- gridExtra::arrangeGrob(
  p_folk_a, p_folk_b, p_folk_c,
  ncol = 1,
  top = grid::textGrob(
    "Contribuciones Matemáticas de Robert J. Aumann: Juegos Repetidos y Equilibrio Correlacionado\nFundamentos formales de la cooperación duradera y la coordinación con información común",
    gp = grid::gpar(fontsize = 13, fontface = "bold")
  )
)

ggsave(filename = file.path(salidas_dir, "fig_aumann_teorema_folk.png"),
       plot = fig_aumann, width = 9, height = 14, dpi = 300)
cat("Guardado: fig_aumann_teorema_folk.png\n")


# ==============================================================================
# PARTE 3: TABLA RESUMEN DE RESULTADOS NUMÉRICOS
# ==============================================================================
tabla_resultados <- data.frame(
  Modulo = c(
    "Schelling (1969, 1971)",
    "Schelling (1969, 1971)",
    "Schelling (1969, 1971)",
    "Schelling (1969, 1971)",
    "Schelling (1969, 1971)",
    "Aumann (1959) - Folk Theorem",
    "Aumann (1959) - Folk Theorem",
    "Aumann (1959) - Folk Theorem",
    "Aumann (1959) - Folk Theorem",
    "Aumann (1974) - Correlated Eq.",
    "Aumann (1974) - Correlated Eq."
  ),
  Parametro_o_Concepto = c(
    "Dimension de la grilla espacial",
    "Tolerancia minima requerida (umbral tau)",
    "Similitud vecinal inicial (t = 0)",
    "Similitud vecinal final convergida",
    "Rondas hasta convergencia",
    "Pago de Cooperacion Mutua (R)",
    "Pago de Defeccion Mutua / Minimax (P)",
    "Tentacion de Defraudar (T)",
    "Factor de descuento critico (delta*)",
    "Pago esperado Nash Mixto (Gallina)",
    "Pago esperado Correlacionado (Aumann)"
  ),
  Valor = c(
    sprintf("%dx%d (%d agentes)", grid_dim, grid_dim, n_a + n_b),
    sprintf("%.1f%% (3/8 vecinos)", umbral_tolerancia * 100),
    sprintf("%.2f%% (satisfaccion: %.1f%%)", eval_ini$similitud_media * 100, eval_ini$tasa_satisfaccion * 100),
    sprintf("%.2f%% (satisfaccion: %.1f%%)", eval_fin$similitud_media * 100, eval_fin$tasa_satisfaccion * 100),
    as.character(iter_convergencia),
    as.character(R),
    as.character(P),
    as.character(T_val),
    sprintf("%.2f (o >= 50%%)", delta_critico),
    "4.67 (probabilidad de colision: 44.4%)",
    "5.00 (probabilidad de colision: 0.0%)"
  ),
  Interpretacion_Economica = c(
    "Ciudad estilizada con 80% ocupacion residencial y 20% vacancia",
    "Preferencia individual estrictamente integracionista y tolerante",
    "Distribucion espacial aleatoria y heterogenea",
    "Segregacion macroscopica extrema emergente no intencionada",
    "Dinamica rapida de cascada y tipping points espaciales",
    "Beneficio social obtenido bajo cooperacion sostenida",
    "Castigo minimax en equilibrio estatico no cooperativo",
    "Ganancia oportunista de corto plazo al defraudar al incauto",
    "Umbral minimo de paciencia para sostener colusion/cooperacion",
    "Resultado ineficiente de conjeturas no coordinadas con choques",
    "Coordinacion mediante mediador/semaforo elimina choques y maximiza bienestar"
  ),
  stringsAsFactors = FALSE
)

csv_path <- file.path(salidas_dir, "tab_resultados_juegos.csv")
write.csv(tabla_resultados, csv_path, row.names = FALSE)
cat(sprintf("Guardado: tab_resultados_juegos.csv (%d registros)\n", nrow(tabla_resultados)))

cat("=== Ejecución completada exitosamente ===\n")

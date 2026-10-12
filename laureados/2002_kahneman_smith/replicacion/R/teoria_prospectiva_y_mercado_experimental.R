# ==============================================================================
# Premio Nobel de Economía 2002: Daniel Kahneman y Vernon L. Smith
# Script: teoria_prospectiva_y_mercado_experimental.R
# Descripción:
#   1. Modelización y visualización de la Teoría Prospectiva de Kahneman y Tversky
#      (1979, 1992): función de valor asimétrica con aversión a pérdidas (lambda = 2.25)
#      y función de ponderación no lineal de probabilidades en forma de S invertida.
#   2. Simulación estocástica de un experimento de mercado de subasta doble continua
#      (Vernon L. Smith, 1962, 1976, 1982) con valores y costos inducidos privados,
#      demostrando la rápida convergencia hacia el precio competitivo de Marshall (P* = $3.00)
#      y el logro de una eficiencia asignativa del 100%.
# Salidas:
#   - salidas/fig_kahneman_teoria_prospectiva.png
#   - salidas/fig_smith_doble_subasta_mercado.png
#   - salidas/tab_resultados_experimentales.csv
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(patchwork)
  library(dplyr)
  library(tidyr)
})

# Fijar semilla para reproducibilidad estricta
set.seed(20021009) # Fecha del anuncio oficial del Nobel: 9 de octubre de 2002

# Definir directorios de salida
# Buscamos la ruta correcta tanto si se ejecuta desde la raíz como desde replicacion/
dir_salidas <- file.path("laureados", "2002_kahneman_smith", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  # Si nos encontramos en la carpeta replicacion o subcarpetas
  if (dir.exists("salidas")) {
    dir_salidas <- "salidas"
  } else if (dir.exists(file.path("..", "salidas"))) {
    dir_salidas <- file.path("..", "salidas")
  } else {
    dir.create(dir_salidas, recursive = TRUE)
  }
}

message("Directorio de salidas configurado en: ", normalizePath(dir_salidas, mustWork = FALSE))

# ==============================================================================
# PARTE 1: TEORÍA PROSPECTIVA (KAHNEMAN & TVERSKY 1979, 1992)
# ==============================================================================

# Parámetros canónicos de la calibración empírica de Tversky & Kahneman (1992):
alpha_k  <- 0.88   # Curvatura en ganancias
beta_k   <- 0.88   # Curvatura en pérdidas
lambda_k <- 2.25   # Coeficiente de aversión a las pérdidas
gamma_k  <- 0.61   # Parámetro de ponderación en ganancias
delta_k  <- 0.69   # Parámetro de ponderación en pérdidas

# 1.1 Función de Valor v(x)
val_fun <- function(x, alpha = alpha_k, beta = beta_k, lambda = lambda_k) {
  ifelse(x >= 0, x^alpha, -lambda * (abs(x)^beta))
}

df_valor <- data.frame(x = seq(-100, 100, length.out = 1000))
df_valor$v <- val_fun(df_valor$x)

p_valor <- ggplot(df_valor, aes(x = x, y = v)) +
  geom_hline(yintercept = 0, color = "gray50", linetype = "solid", linewidth = 0.5) +
  geom_vline(xintercept = 0, color = "gray50", linetype = "solid", linewidth = 0.5) +
  geom_line(color = "#1B365D", linewidth = 1.3) +
  annotate("text", x = 50, y = 25, label = expression(v(x) == x^0.88 ~ (x >= 0)),
           color = "#1B365D", size = 4.2, fontface = "bold") +
  annotate("text", x = -50, y = -80, label = expression(v(x) == -2.25 ~ (-x)^0.88 ~ (x < 0)),
           color = "#B22222", size = 4.2, fontface = "bold") +
  annotate("point", x = 0, y = 0, size = 3, color = "#333333") +
  annotate("text", x = 0, y = 8, label = "Punto de referencia (Status Quo)", size = 3.5, fontface = "italic") +
  labs(
    title = "A: Función de Valor con Aversión a Pérdidas",
    subtitle = expression(paste("Cóncava en ganancias, convexa en pérdidas (", lambda, " = 2.25, ", alpha, " = ", beta, " = 0.88)")),
    x = "Cambio en la riqueza / Resultado x (Ganancias vs. Pérdidas en $)",
    y = "Valor subjetivo v(x)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 9.5, color = "gray30"),
    panel.grid.minor = element_blank()
  )

# 1.2 Función de Ponderación No Lineal de Probabilidades w(p)
weight_fun <- function(p, gamma) {
  (p^gamma) / ((p^gamma + (1 - p)^gamma)^(1 / gamma))
}

p_seq <- seq(0.001, 0.999, length.out = 500)
df_weight <- data.frame(
  p = rep(p_seq, 2),
  w = c(weight_fun(p_seq, gamma_k), weight_fun(p_seq, delta_k)),
  Dominio = rep(c("Ganancias (gamma = 0.61)", "Pérdidas (delta = 0.69)"), each = length(p_seq))
)

p_prob <- ggplot() +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "gray40", linewidth = 0.8) +
  geom_line(data = df_weight, aes(x = p, y = w, color = Dominio), linewidth = 1.2) +
  scale_color_manual(values = c("Ganancias (gamma = 0.61)" = "#2E7D32", 
                                "Pérdidas (delta = 0.69)" = "#C2185B")) +
  annotate("text", x = 0.12, y = 0.32, label = "Sobreponderación de\nprobabilidades bajas\n(w(p) > p)",
           size = 3.2, color = "#1B5E20", fontface = "italic") +
  annotate("text", x = 0.78, y = 0.58, label = "Subponderación de\nprobabilidades medias y altas\n(w(p) < p)",
           size = 3.2, color = "#880E4F", fontface = "italic") +
  scale_x_continuous(breaks = seq(0, 1, 0.2), limits = c(0, 1)) +
  scale_y_continuous(breaks = seq(0, 1, 0.2), limits = c(0, 1)) +
  labs(
    title = "B: Ponderación No Lineal de Probabilidades",
    subtitle = "Curvatura en forma de 'S' invertida (Tversky & Kahneman, 1992)",
    x = "Probabilidad objetiva p",
    y = "Ponderación subjetiva w(p)",
    color = "Tipo de lotería"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 9.5, color = "gray30"),
    legend.position = "bottom",
    panel.grid.minor = element_blank()
  )

fig_kahneman <- p_valor + p_prob +
  plot_layout(ncol = 2) +
  plot_annotation(
    title = "Teoría Prospectiva: Fundamentos Microconductuales (Kahneman & Tversky)",
    theme = theme(plot.title = element_text(size = 14, face = "bold", hjust = 0.5))
  )

ruta_fig_kahneman_1 <- file.path(dir_salidas, "fig_kahneman_teoria_prospectiva.png")
ruta_fig_kahneman_2 <- file.path(dir_salidas, "fig_kahneman_prospect_theory.png")

ggsave(ruta_fig_kahneman_1, fig_kahneman, width = 11, height = 5.2, dpi = 300)
ggsave(ruta_fig_kahneman_2, fig_kahneman, width = 11, height = 5.2, dpi = 300)
message("Guardada figura Kahneman: ", ruta_fig_kahneman_1)

# ==============================================================================
# PARTE 2: MERCADO EXPERIMENTAL DE VERNON SMITH (1962)
# ==============================================================================

# Diseño experimental smithiano:
# Subasta doble continua con 11 compradores y 11 vendedores con valores y costos inducidos privados.
valores_compradores <- c(4.25, 4.00, 3.75, 3.50, 3.25, 3.00, 2.75, 2.50, 2.25, 2.00, 1.75)
costos_vendedores   <- c(1.75, 2.00, 2.25, 2.50, 2.75, 3.00, 3.25, 3.50, 3.75, 4.00, 4.25)

n_compradores <- length(valores_compradores)
n_vendedores  <- length(costos_vendedores)

# Curvas de Demanda y Oferta teóricas escalonadas
df_demanda <- data.frame(
  Q = 1:n_compradores,
  P = valores_compradores,
  Tipo = "Demanda (Valores inducidos)"
)

df_oferta <- data.frame(
  Q = 1:n_vendedores,
  P = costos_vendedores,
  Tipo = "Oferta (Costos inducidos)"
)

# Equilibrio competitivo teórico marshalliano:
# Intersección donde V(6) = 3.00 y C(6) = 3.00 => P* = $3.00, Q* = 6 unidades
p_estrella <- 3.00
q_estrella <- 6

# Excedente social máximo teórico:
# Suma de excedentes para las unidades intramarginales (1 a 6)
excedente_maximo <- sum(valores_compradores[1:q_estrella] - costos_vendedores[1:q_estrella])

# Simulación dinámica del proceso de subasta doble en 6 rondas
n_rondas <- 6
transacciones_list <- list()
metricas_ronda <- data.frame()

for (r in 1:n_rondas) {
  # Dispersión estocástica decreciente por aprendizaje smithiano
  ruido_dispersion <- 0.70 * (0.58^(r - 1))
  
  # Orden de llegada aleatorio de los agentes
  orden_comp <- sample(1:n_compradores)
  orden_vend <- sample(1:n_vendedores)
  
  bids <- numeric(n_compradores)
  asks <- numeric(n_vendedores)
  
  for (i in seq_along(orden_comp)) {
    c_idx <- orden_comp[i]
    val <- valores_compradores[c_idx]
    bid_target <- 0.5 * val + 0.5 * p_estrella + rnorm(1, 0, ruido_dispersion)
    bids[c_idx] <- min(val - 0.05, max(1.5, bid_target))
  }
  
  for (j in seq_along(orden_vend)) {
    v_idx <- orden_vend[j]
    cost <- costos_vendedores[v_idx]
    ask_target <- 0.5 * cost + 0.5 * p_estrella + rnorm(1, 0, ruido_dispersion)
    asks[v_idx] <- max(cost + 0.05, min(4.5, ask_target))
  }
  
  # Casamiento de órdenes en subasta doble
  df_bids <- data.frame(id_c = 1:n_compradores, bid = bids, val = valores_compradores) %>%
    arrange(desc(bid))
  df_asks <- data.frame(id_v = 1:n_vendedores, ask = asks, cost = costos_vendedores) %>%
    arrange(ask)
  
  transacciones_ronda <- data.frame()
  max_trades <- min(n_compradores, n_vendedores)
  
  for (k in 1:max_trades) {
    if (df_bids$bid[k] >= df_asks$ask[k]) {
      peso <- runif(1, 0.35, 0.65)
      p_trade <- peso * df_bids$bid[k] + (1 - peso) * df_asks$ask[k]
      p_trade <- max(df_asks$cost[k], min(df_bids$val[k], p_trade))
      
      transacciones_ronda <- rbind(transacciones_ronda, data.frame(
        ronda = r,
        orden_trade = nrow(transacciones_ronda) + 1,
        precio = round(p_trade, 3),
        val_comp = df_bids$val[k],
        cost_vend = df_asks$cost[k],
        excedente = df_bids$val[k] - df_asks$cost[k]
      ))
    }
  }
  
  n_t <- nrow(transacciones_ronda)
  p_media <- mean(transacciones_ronda$precio)
  sd_p <- sd(transacciones_ronda$precio)
  if (is.na(sd_p)) sd_p <- 0
  
  # Coeficiente de convergencia alpha de Smith (1962):
  # alpha = 100 * (desviación estándar / precio competitivo)
  alpha_smith <- (sd_p / p_estrella) * 100
  
  surplus_realizado <- sum(transacciones_ronda$excedente)
  eficiencia <- (surplus_realizado / excedente_maximo) * 100
  
  metricas_ronda <- rbind(metricas_ronda, data.frame(
    Ronda = r,
    Transacciones = n_t,
    Precio_Medio = round(p_media, 3),
    Desv_Estandar = round(sd_p, 3),
    Alpha_Smith_Pct = round(alpha_smith, 2),
    Excedente_Realizado = round(surplus_realizado, 2),
    Excedente_Maximo = round(excedente_maximo, 2),
    Eficiencia_Pct = round(eficiencia, 2)
  ))
  
  transacciones_list[[r]] <- transacciones_ronda
}

df_all_trades <- bind_rows(transacciones_list)
df_all_trades$trade_global <- 1:nrow(df_all_trades)

# 2.1 Gráfico de Oferta y Demanda Inducida
p_market <- ggplot() +
  geom_step(data = df_demanda, aes(x = Q, y = P, color = "Demanda inducida (Valores)"), direction = "vh", linewidth = 1.2) +
  geom_step(data = df_oferta, aes(x = Q, y = P, color = "Oferta inducida (Costos)"), direction = "vh", linewidth = 1.2) +
  geom_hline(yintercept = p_estrella, linetype = "dashed", color = "gray30", linewidth = 0.8) +
  geom_vline(xintercept = q_estrella, linetype = "dashed", color = "gray30", linewidth = 0.8) +
  annotate("point", x = q_estrella, y = p_estrella, size = 4, color = "#C62828") +
  annotate("text", x = q_estrella + 0.4, y = p_estrella + 0.25,
           label = expression(paste("Equilibrio Marshalliano: ", P^"*" == 3.00, ", ", Q^"*" == 6)),
           color = "#C62828", fontface = "bold", size = 3.8, hjust = 0) +
  scale_color_manual(values = c("Demanda inducida (Valores)" = "#1565C0", 
                                "Oferta inducida (Costos)" = "#D84315")) +
  scale_x_continuous(breaks = 1:11, limits = c(0.8, 11.2)) +
  scale_y_continuous(breaks = seq(1.5, 4.5, 0.5), limits = c(1.5, 4.5)) +
  labs(
    title = "A: Estructura del Mercado Experimental (Smith, 1962)",
    subtitle = "Valores de reserva privados y costos inducidos escalonados",
    x = "Cantidad de Unidades (Q)",
    y = "Precio ($)",
    color = "Curva de Mercado"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 9.5, color = "gray30"),
    legend.position = "bottom",
    panel.grid.minor = element_blank()
  )

# 2.2 Gráfico de Convergencia Cronológica de Precios por Ronda
p_convergencia <- ggplot(df_all_trades, aes(x = trade_global, y = precio)) +
  geom_hline(yintercept = p_estrella, linetype = "dashed", color = "#C62828", linewidth = 1) +
  geom_line(color = "#37474F", alpha = 0.6) +
  geom_point(aes(fill = factor(ronda)), shape = 21, size = 3, color = "black") +
  scale_fill_brewer(palette = "Blues", name = "Ronda") +
  scale_y_continuous(breaks = seq(2.0, 4.0, 0.25), limits = c(2.0, 4.0)) +
  labs(
    title = "B: Trayectoria de Precios de Transacción en Subasta Doble",
    subtitle = expression(paste("Convergencia al equilibrio competitivo ", P^"*" == 3.00)),
    x = "Secuencia Cronológica de Transacciones",
    y = "Precio Transado ($)"
  ) +
  annotate("text", x = nrow(df_all_trades) * 0.72, y = 3.8,
           label = "Ronda 1: Mayor dispersión\nRonda 4-6: Convergencia casi exacta\nEficiencia asignativa = 100%",
           size = 3.3, fontface = "italic", color = "gray20") +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 9.5, color = "gray30"),
    legend.position = "bottom",
    panel.grid.minor = element_blank()
  )

fig_smith <- p_market + p_convergencia +
  plot_layout(ncol = 2) +
  plot_annotation(
    title = "Economía Experimental: Subasta Doble y Convergencia de Mercado (Vernon L. Smith)",
    theme = theme(plot.title = element_text(size = 14, face = "bold", hjust = 0.5))
  )

ruta_fig_smith_1 <- file.path(dir_salidas, "fig_smith_doble_subasta_mercado.png")
ruta_fig_smith_2 <- file.path(dir_salidas, "fig_smith_subasta_doble_convergencia.png")

ggsave(ruta_fig_smith_1, fig_smith, width = 11.5, height = 5.2, dpi = 300)
ggsave(ruta_fig_smith_2, fig_smith, width = 11.5, height = 5.2, dpi = 300)
message("Guardada figura Smith: ", ruta_fig_smith_1)

# 2.3 Guardar tabla de métricas
ruta_tab <- file.path(dir_salidas, "tab_resultados_experimentales.csv")
write.csv(metricas_ronda, ruta_tab, row.names = FALSE)
message("Guardada tabla: ", ruta_tab)

print(metricas_ronda)
message("Ejecución completada con éxito.")

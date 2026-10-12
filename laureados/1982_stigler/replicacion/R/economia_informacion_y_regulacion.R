# ==============================================================================
# Premio Nobel de Economia 1982 - George J. Stigler
# Replicacion Cuantitativa y Simulacion Didactica:
# 1. El Modelo de Busqueda de Informacion y Dispersion de Precios (Stigler, 1961)
# 2. Teoria de la Captura Regulatoria y Barreras a la Entrada (Stigler, 1971)
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
  library(patchwork)
})

# Establecer semilla para reproducibilidad estricta
set.seed(19821020)

# Definir rutas relativas seguras
ruta_script <- getwd()
dir_salidas <- file.path("laureados", "1982_stigler", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  if (dir.exists("salidas")) {
    dir_salidas <- "salidas"
  } else {
    dir.create(dir_salidas, recursive = TRUE, showWarnings = FALSE)
  }
}

cat("==> Iniciando simulacion cuantitativa de George J. Stigler (1982)\n")
cat("    Directorio de salidas:", dir_salidas, "\n\n")

# ------------------------------------------------------------------------------
# PARTE 1: MODELO DE BUSQUEDA DE INFORMACION (STIGLER, 1961)
# ------------------------------------------------------------------------------
# Supuesto basico: En un mercado con ignorancia del consumidor, los vendedores
# cobran precios heterogeneos distribuidos segun F(P). El comprador obtiene
# n cotizaciones independientes de precio y compra al menor precio observado:
# P_(1:n) = min(P_1, P_2, ..., P_n).
#
# Cada cotizacion adicional tiene un costo de busqueda marginal constante 'c'.
# El comprador busca n* que iguale el beneficio marginal esperado (ahorro en precio)
# con el costo marginal c: Q * MB(n*) >= c > Q * MB(n* + 1).

# 1.1 Solucion Analitica con Distribucion Uniforme P ~ U(a, b)
# a = 50, b = 150 (media = 100, rango = 100)
a_unif <- 50
b_unif <- 150
rango_unif <- b_unif - a_unif

n_seq <- 1:20

# Para distribucion uniforme, E[P_(1:n)] = a + (b - a) / (n + 1)
e_min_unif <- a_unif + rango_unif / (n_seq + 1)
mb_unif <- c(NA, -diff(e_min_unif)) # MB(n) = E[min_(n-1)] - E[min_n] = (b - a) / (n * (n + 1))
mb_unif[1] <- rango_unif / 2 # Ahorro frente al precio maximo o expectativa inicial

# 1.2 Simulacion de Monte Carlo con Distribucion Log-Normal
# P ~ LogNormal(mu = 4.55, sigma = 0.25) -> Media aprox 100, asimetria positiva
n_simulaciones <- 50000
mu_ln <- 4.55
sigma_ln <- 0.25

matriz_precios <- matrix(rlnorm(n_simulaciones * max(n_seq), meanlog = mu_ln, sdlog = sigma_ln),
                         nrow = n_simulaciones, ncol = max(n_seq))

minimos_ln <- apply(matriz_precios, 1, cummin) # Matriz de max(n_seq) x n_simulaciones
e_min_ln <- rowMeans(minimos_ln)
q10_ln <- apply(minimos_ln, 1, quantile, probs = 0.10)
q90_ln <- apply(minimos_ln, 1, quantile, probs = 0.90)

mb_ln <- c(NA, -diff(e_min_ln))
mb_ln[1] <- mean(matriz_precios[, 1]) - e_min_ln[1] # Referencia

df_busqueda <- tibble(
  n = n_seq,
  E_min_unif = e_min_unif,
  MB_unif = c(rango_unif / 2, rango_unif / (n_seq[-1] * (n_seq[-1] + 1))),
  E_min_ln = e_min_ln,
  Q10_ln = q10_ln,
  Q90_ln = q90_ln,
  MB_ln = c(mb_ln[1], -diff(e_min_ln))
)

# Evaluar regla de parada para diferentes volumenes de compra Q y costos de busqueda c
c_busqueda <- 3.0 # Costo de cotizacion en unidades monetarias
q_baja <- 1       # Consumidor individual de un bien menor (Q = 1)
q_media <- 3      # Consumidor de volumen intermedio (Q = 3)
q_alta <- 8       # Comprador de gran volumen o bien durable (Q = 8)

df_optimo <- df_busqueda %>%
  mutate(
    MB_Q1 = MB_unif * q_baja,
    MB_Q3 = MB_unif * q_media,
    MB_Q8 = MB_unif * q_alta,
    Costo_Marginal = c_busqueda
  )

# Identificar n* optimo analitico para cada Q
n_opt_q1 <- max(which(df_optimo$MB_Q1 >= c_busqueda))
n_opt_q3 <- max(which(df_optimo$MB_Q3 >= c_busqueda))
n_opt_q8 <- max(which(df_optimo$MB_Q8 >= c_busqueda))

cat(sprintf("==> Busqueda Optima de Stigler (c = $%.2f):\n", c_busqueda))
cat(sprintf("    Q = 1 unidad:  n* = %d cotizaciones (Precio min esperado = $%.2f)\n", n_opt_q1, e_min_unif[n_opt_q1]))
cat(sprintf("    Q = 3 unidades: n* = %d cotizaciones (Precio min esperado = $%.2f)\n", n_opt_q3, e_min_unif[n_opt_q3]))
cat(sprintf("    Q = 8 unidades: n* = %d cotizaciones (Precio min esperado = $%.2f)\n\n", n_opt_q8, e_min_unif[n_opt_q8]))

# ------------------------------------------------------------------------------
# GRAFICA 1: MODELO DE BUSQUEDA DE INFORMACION
# ------------------------------------------------------------------------------
tema_stigler <- theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12, color = "#1a252f"),
    plot.subtitle = element_text(size = 9.5, color = "#4a5568", margin = margin(b = 8)),
    plot.caption = element_text(size = 8, color = "#718096", hjust = 0),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#edf2f7", linewidth = 0.5),
    axis.title = element_text(face = "bold", size = 9.5, color = "#2d3748"),
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.background = element_rect(fill = "white", color = "#e2e8f0", linewidth = 0.4)
  )

# Panel A: Curva de Precio Minimo Esperado
p1a <- ggplot(df_busqueda, aes(x = n)) +
  geom_ribbon(aes(ymin = Q10_ln, ymax = Q90_ln, fill = "Intervalo 10%-90% (Log-Normal)"), alpha = 0.22) +
  geom_line(aes(y = E_min_unif, color = "Uniforme U(50, 150) - Analitica"), linewidth = 1.1) +
  geom_point(aes(y = E_min_unif, color = "Uniforme U(50, 150) - Analitica"), size = 2.2) +
  geom_line(aes(y = E_min_ln, color = "Log-Normal (MC 50k sims)"), linewidth = 1.0, linetype = "dashed") +
  geom_point(aes(y = E_min_ln, color = "Log-Normal (MC 50k sims)"), size = 1.8, shape = 17) +
  scale_color_manual(
    name = "Distribucion de Precios:",
    values = c("Uniforme U(50, 150) - Analitica" = "#1e3a8a", "Log-Normal (MC 50k sims)" = "#b91c1c")
  ) +
  scale_fill_manual(
    name = "Dispersion Monte Carlo:",
    values = c("Intervalo 10%-90% (Log-Normal)" = "#fca5a5")
  ) +
  scale_x_continuous(breaks = seq(1, 20, by = 2)) +
  scale_y_continuous(labels = dollar_format(prefix = "$")) +
  labs(
    title = "A. Rendimientos Decrecientes de la Informacion",
    subtitle = "Precio minimo esperado E[min(P1, ..., Pn)] en funcion del tamano de busqueda n",
    x = "Numero de cotizaciones buscadas (n)",
    y = "Precio minimo esperado ($)"
  ) +
  tema_stigler

# Panel B: Beneficio Marginal vs Costo Marginal y n* optimo
p1b <- ggplot() +
  geom_line(data = df_optimo, aes(x = n, y = MB_Q1, color = "Q = 1 unidad (MB minorista)"), linewidth = 1.0) +
  geom_point(data = df_optimo, aes(x = n, y = MB_Q1, color = "Q = 1 unidad (MB minorista)"), size = 1.8) +
  geom_line(data = df_optimo, aes(x = n, y = MB_Q3, color = "Q = 3 unidades (MB intermedio)"), linewidth = 1.0) +
  geom_point(data = df_optimo, aes(x = n, y = MB_Q3, color = "Q = 3 unidades (MB intermedio)"), size = 1.8) +
  geom_line(data = df_optimo, aes(x = n, y = MB_Q8, color = "Q = 8 unidades (MB compras al por mayor)"), linewidth = 1.1) +
  geom_point(data = df_optimo, aes(x = n, y = MB_Q8, color = "Q = 8 unidades (MB compras al por mayor)"), size = 2.0) +
  geom_hline(aes(yintercept = c_busqueda, linetype = "Costo Marginal de Busqueda c = $3.00"), color = "#111827", linewidth = 0.9) +
  geom_vline(xintercept = c(n_opt_q1, n_opt_q3, n_opt_q8), linetype = "dotted", color = "#4b5563", linewidth = 0.6) +
  annotate("text", x = n_opt_q1 + 0.3, y = 14, label = paste0("n* = ", n_opt_q1), fontface = "bold", color = "#0284c7", size = 3.2) +
  annotate("text", x = n_opt_q3 + 0.3, y = 22, label = paste0("n* = ", n_opt_q3), fontface = "bold", color = "#d97706", size = 3.2) +
  annotate("text", x = n_opt_q8 + 0.3, y = 30, label = paste0("n* = ", n_opt_q8), fontface = "bold", color = "#059669", size = 3.2) +
  scale_color_manual(
    name = "Volumen Comprado:",
    values = c(
      "Q = 1 unidad (MB minorista)" = "#0284c7",
      "Q = 3 unidades (MB intermedio)" = "#d97706",
      "Q = 8 unidades (MB compras al por mayor)" = "#059669"
    )
  ) +
  scale_linetype_manual(
    name = "Costo Marginal:",
    values = c("Costo Marginal de Busqueda c = $3.00" = "solid")
  ) +
  scale_x_continuous(breaks = seq(1, 20, by = 2), limits = c(1, 16)) +
  scale_y_continuous(limits = c(0, 50), labels = dollar_format(prefix = "$")) +
  labs(
    title = "B. Regla de Parada Optima de Stigler: Q * MB(n) = c",
    subtitle = "Mayor volumen de compra o mayor dispersion justifica una busqueda mas intensiva",
    x = "Numero de cotizacion (n)",
    y = "Beneficio / Costo Marginal ($)"
  ) +
  tema_stigler

fig_busqueda <- p1a / p1b +
  plot_annotation(
    title = "Teoria de la Busqueda de Informacion de George J. Stigler (1961)",
    subtitle = "La dispersion de precios como medida de ignorancia y la regla de parada optima racional",
    caption = "Fuente: Replicacion basada en Stigler (1961), 'The Economics of Information', JPE. Proyecto Nobel_economics.",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14, color = "#0f172a"),
      plot.subtitle = element_text(size = 11, color = "#334155")
    )
  )

ruta_fig1 <- file.path(dir_salidas, "fig_stigler_busqueda_precios.png")
ggsave(ruta_fig1, fig_busqueda, width = 10, height = 8.5, dpi = 300)
cat(sprintf("==> Figura 1 guardada con exito: %s\n", ruta_fig1))


# ------------------------------------------------------------------------------
# PARTE 2: TEORIA DE LA CAPTURA REGULATORIA (STIGLER, 1971)
# ------------------------------------------------------------------------------
# Mercado hipotetico de un servicio regulado (ej. transporte en taxi, telecomunicaciones o banca):
# Demanda de mercado inversa: P(Q) = P_max - b * Q
# Costo marginal competitivo constante: MC = c_0
#
# Parametros base:
P_max <- 120
b_demanda <- 1.0
c_costo <- 30

# Equilibrio Competitivo (Libre Entrada, Desregulado):
# P_comp = c_costo = 30
# Q_comp = (P_max - c_costo) / b = (120 - 30) / 1.0 = 90
# Excedente Consumidor = 0.5 * (P_max - P_comp) * Q_comp = 0.5 * 90 * 90 = 4050
# Beneficio Industria = 0
# Bienestar Social = 4050
Q_comp <- (P_max - c_costo) / b_demanda
P_comp <- c_costo
CS_comp <- 0.5 * (P_max - P_comp) * Q_comp
PI_comp <- 0
DWL_comp <- 0
Bienestar_comp <- CS_comp + PI_comp

# Escenarios de Captura Regulatoria:
# Las empresas titulares forman un grupo de cabildeo concentrado y obtienen
# regulaciones de entrada (licencias, cupos, tarifas oficiales minimas).
# Sea 'tasa_restriccion' in [0, 1]:
# 0 = Competencia perfecta (libre entrada)
# 1 = Monopolio puro capturado por cartel legal (P_monopolio = (P_max + c_0) / 2 = 75)
P_monopolio <- (P_max + c_costo) / 2
Q_monopolio <- (P_max - P_monopolio) / b_demanda

grid_captura <- tibble(
  grado_captura = seq(0, 1, by = 0.02) # De libre mercado a monopolio legal
) %>%
  mutate(
    P_reg = P_comp + grado_captura * (P_monopolio - P_comp),
    Q_reg = (P_max - P_reg) / b_demanda,
    CS_reg = 0.5 * (P_max - P_reg) * Q_reg,
    Renta_Industria = (P_reg - c_costo) * Q_reg,
    DWL_Harberger = 0.5 * (P_reg - P_comp) * (Q_comp - Q_reg),
    # Hipotesis de Tullock-Stigler: el gasto en cabildeo y proteccion politica
    # disipa una fraccion gamma de la renta lograda (ej. gamma = 0.35)
    Gasto_Cabildeo = 0.35 * Renta_Industria,
    Renta_Neta_Productores = Renta_Industria - Gasto_Cabildeo,
    Perdida_Social_Total = DWL_Harberger + Gasto_Cabildeo,
    Bienestar_Social_Efectivo = CS_reg + Renta_Neta_Productores
  )

# Detalle de 3 escenarios canonicos para reporte y tablas
escenarios_canonicos <- tibble(
  Escenario = c("1. Competencia Perfecta (Libre Entrada)",
                "2. Captura Moderada (Licencias Restringidas)",
                "3. Captura Total (Cartel Monopolico Legalizado)"),
  grado = c(0.0, 0.5, 1.0)
) %>%
  left_join(grid_captura, by = c("grado" = "grado_captura")) %>%
  select(Escenario, P_reg, Q_reg, CS_reg, Renta_Industria, Gasto_Cabildeo,
         Renta_Neta_Productores, DWL_Harberger, Perdida_Social_Total, Bienestar_Social_Efectivo)

# ------------------------------------------------------------------------------
# GRAFICA 2: DIAGRAMA DE CAPTURA REGULATORIA Y BIENESTAR
# ------------------------------------------------------------------------------

# Panel A: Diagrama de Mercado en Captura Moderada (P = 52.5, Q = 67.5)
esc_mod <- grid_captura %>% filter(grado_captura == 0.5)

df_demanda <- tibble(
  Q = seq(0, 110, by = 1),
  P = P_max - b_demanda * Q
)

# Poligonos de Excedente Consumidor, Renta y DWL
poly_cs <- data.frame(
  Q = c(0, esc_mod$Q_reg, 0),
  P = c(esc_mod$P_reg, esc_mod$P_reg, P_max)
)

poly_renta <- data.frame(
  Q = c(0, esc_mod$Q_reg, esc_mod$Q_reg, 0),
  P = c(c_costo, c_costo, esc_mod$P_reg, esc_mod$P_reg)
)

poly_dwl <- data.frame(
  Q = c(esc_mod$Q_reg, Q_comp, esc_mod$Q_reg),
  P = c(esc_mod$P_reg, c_costo, c_costo)
)

p2a <- ggplot() +
  geom_polygon(data = poly_cs, aes(x = Q, y = P, fill = "Excedente Consumidor (CS)"), alpha = 0.4) +
  geom_polygon(data = poly_renta, aes(x = Q, y = P, fill = "Rentas de la Industria Capturada (Transferencia)"), alpha = 0.5) +
  geom_polygon(data = poly_dwl, aes(x = Q, y = P, fill = "Perdida de Peso Muerto (DWL)"), alpha = 0.5) +
  geom_line(data = df_demanda, aes(x = Q, y = P), color = "#0f172a", linewidth = 1.1) +
  geom_hline(yintercept = c_costo, color = "#059669", linetype = "dashed", linewidth = 1.0) +
  geom_hline(yintercept = esc_mod$P_reg, color = "#b91c1c", linetype = "dotted", linewidth = 1.0) +
  geom_vline(xintercept = esc_mod$Q_reg, color = "#b91c1c", linetype = "dotted", linewidth = 0.8) +
  geom_vline(xintercept = Q_comp, color = "#059669", linetype = "dashed", linewidth = 0.8) +
  annotate("text", x = 18, y = 78, label = "Excedente del\nConsumidor", color = "#1e3a8a", fontface = "bold", size = 3.2) +
  annotate("text", x = 32, y = 41, label = "Rentas de la Industria\n(Captura del Regulador)", color = "#78350f", fontface = "bold", size = 3.2) +
  annotate("text", x = 74, y = 37, label = "Pérdida Social\n(DWL)", color = "#7f1d1d", fontface = "bold", size = 3.1) +
  annotate("text", x = 95, y = 33, label = "MC = P_comp = $30", color = "#059669", fontface = "bold", size = 3.2, hjust = 0) +
  annotate("text", x = 5, y = esc_mod$P_reg + 3, label = paste0("P_reg = $", esc_mod$P_reg), color = "#b91c1c", fontface = "bold", size = 3.2, hjust = 0) +
  scale_fill_manual(
    name = "Distribucion de Excedentes:",
    values = c(
      "Excedente Consumidor (CS)" = "#93c5fd",
      "Rentas de la Industria Capturada (Transferencia)" = "#fde047",
      "Perdida de Peso Muerto (DWL)" = "#fca5a5"
    )
  ) +
  scale_x_continuous(limits = c(0, 110), breaks = seq(0, 100, by = 20)) +
  scale_y_continuous(limits = c(20, 125), breaks = seq(20, 120, by = 20), labels = dollar_format(prefix = "$")) +
  labs(
    title = "A. Efecto Distributivo de la Restriccion de Entrada",
    subtitle = "Fijacion de precios / licencias legales: transferencia masiva desde consumidores",
    x = "Cantidad producida en el mercado (Q)",
    y = "Precio ($)"
  ) +
  tema_stigler

# Panel B: Rentas de la Industria vs Perdida Social Segun Grado de Captura
p2b <- ggplot(grid_captura, aes(x = grado_captura * 100)) +
  geom_line(aes(y = Renta_Industria, color = "Renta Bruta de la Industria"), linewidth = 1.2) +
  geom_point(aes(y = Renta_Industria, color = "Renta Bruta de la Industria"), size = 1.8) +
  geom_line(aes(y = Perdida_Social_Total, color = "Perdida Social Total (DWL + Cabildeo)"), linewidth = 1.1) +
  geom_point(aes(y = Perdida_Social_Total, color = "Perdida Social Total (DWL + Cabildeo)"), size = 1.8) +
  geom_line(aes(y = Gasto_Cabildeo, color = "Gasto en Cabildeo (Recursos Disipados)"), linewidth = 1.0, linetype = "dashed") +
  geom_point(aes(y = Gasto_Cabildeo, color = "Gasto en Cabildeo (Recursos Disipados)"), size = 1.5) +
  scale_color_manual(
    name = "Variables de Bienestar y Rentas:",
    values = c(
      "Renta Bruta de la Industria" = "#b45309",
      "Perdida Social Total (DWL + Cabildeo)" = "#dc2626",
      "Gasto en Cabildeo (Recursos Disipados)" = "#4b5563"
    )
  ) +
  scale_x_continuous(breaks = seq(0, 100, by = 20), labels = function(x) paste0(x, "%")) +
  scale_y_continuous(labels = dollar_format(prefix = "$")) +
  labs(
    title = "B. Por que las Industrias Adquieren la Regulacion",
    subtitle = "Maximizacion de rentas privadas a costa del bienestar general conforme aumenta la captura",
    x = "Grado de captura regulatoria (% hacia monopolio legal)",
    y = "Monto monetario agregado ($)"
  ) +
  tema_stigler

fig_regulacion <- p2a / p2b +
  plot_annotation(
    title = "Teoria de la Captura Regulatoria de George J. Stigler (1971)",
    subtitle = "La regulacion como producto adquirido por grupos de interes para restringir la competencia",
    caption = "Fuente: Replicacion basada en Stigler (1971), 'The Theory of Economic Regulation', Bell J. Econ. Proyecto Nobel_economics.",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14, color = "#0f172a"),
      plot.subtitle = element_text(size = 11, color = "#334155")
    )
  )

ruta_fig2 <- file.path(dir_salidas, "fig_stigler_captura_regulatoria.png")
ggsave(ruta_fig2, fig_regulacion, width = 10, height = 8.5, dpi = 300)
cat(sprintf("==> Figura 2 guardada con exito: %s\n", ruta_fig2))


# ------------------------------------------------------------------------------
# PARTE 3: GENERACION Y GUARDADO DE TABLA DE RESULTADOS
# ------------------------------------------------------------------------------

# Crear tabla consolidada para exportacion CSV
tab_export <- bind_rows(
  # Bloque de Busqueda
  df_optimo %>%
    filter(n %in% c(1, 2, 3, 4, 5, 6, 8, 10, 15, 20)) %>%
    transmute(
      Modulo = "1. Busqueda de Precios (Stigler 1961)",
      Metrica_o_Escenario = paste0("n = ", n, " cotizaciones"),
      Parametro_1 = sprintf("E[P_min] = $%.2f", E_min_unif),
      Parametro_2 = sprintf("MB (Q=1) = $%.2f", MB_Q1),
      Parametro_3 = sprintf("MB (Q=3) = $%.2f", MB_Q3),
      Parametro_4 = sprintf("MB (Q=8) = $%.2f", MB_Q8),
      Resultado_Clave = case_when(
        n == n_opt_q1 ~ "Optimo n* para Q=1",
        n == n_opt_q3 ~ "Optimo n* para Q=3",
        n == n_opt_q8 ~ "Optimo n* para Q=8",
        TRUE ~ "-"
      )
    ),
  # Bloque de Captura Regulatoria
  escenarios_canonicos %>%
    transmute(
      Modulo = "2. Captura Regulatoria (Stigler 1971)",
      Metrica_o_Escenario = Escenario,
      Parametro_1 = sprintf("Precio = $%.2f (Q = %.1f)", P_reg, Q_reg),
      Parametro_2 = sprintf("Excedente Consumidor = $%.1f", CS_reg),
      Parametro_3 = sprintf("Renta Industria = $%.1f", Renta_Industria),
      Parametro_4 = sprintf("DWL Harberger = $%.1f", DWL_Harberger),
      Resultado_Clave = sprintf("Perdida Social Total = $%.1f", Perdida_Social_Total)
    )
)

ruta_tabla <- file.path(dir_salidas, "tab_resultados_stigler.csv")
write.csv(tab_export, ruta_tabla, row.names = FALSE)
cat(sprintf("==> Tabla de resultados guardada con exito: %s\n\n", ruta_tabla))

cat("==> Replicacion cuantitativa de George J. Stigler (1982) finalizada exitosamente.\n")

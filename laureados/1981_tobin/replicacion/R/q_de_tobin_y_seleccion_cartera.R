# ==============================================================================
# Script: q_de_tobin_y_seleccion_cartera.R
# Autor: Proyecto Nobel_economics
# Laureado: James Tobin (Premio Nobel de Economia 1981)
# Descripcion:
#   Este script implementa y replica cuantitativamente dos de las aportaciones
#   seminales de James Tobin:
#   1. Teoria de la Inversion basada en la q de Tobin con costos de ajuste
#      cuadraticos (Tobin 1969; Hayashi 1982; Summers 1981).
#   2. Teorema de Separacion de Tobin y Teoria de Seleccion de Cartera bajo
#      preferencia por liquidez (Tobin 1958).
#
# Salidas generadas:
#   - salidas/fig_tobin_q_inversion.png
#   - salidas/fig_tobin_separacion_cartera.png
#   - salidas/tab_resultados_tobin.csv
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
})

# Definicion de rutas relativas
dir_salidas <- file.path("salidas")
if (!dir.exists(dir_salidas)) {
  # Si se corre desde la raiz de la carpeta laureados/1981_tobin/replicacion
  if (dir.exists("replicacion/salidas")) {
    dir_salidas <- "replicacion/salidas"
  } else if (dir.exists("laureados/1981_tobin/replicacion/salidas")) {
    dir_salidas <- "laureados/1981_tobin/replicacion/salidas"
  } else {
    dir_salidas <- "."
  }
}

cat("=== Inicio de la replicacion cuantitativa de James Tobin (1981) ===\n")
cat("Directorio de salidas:", dir_salidas, "\n")

# ------------------------------------------------------------------------------
# PARTE 1: LA q DE TOBIN Y LA TASA DE INVERSION EMPRESARIAL
# ------------------------------------------------------------------------------
# Modelo:
#   Max V_0 = integral_0^infty e^{-r t} [ pi(K_t) - I_t - C(I_t, K_t) ] dt
#   s.a. dot{K}_t = I_t - delta * K_t
#   C(I, K) = (chi / 2) * (I/K - delta)^2 * K
#
# Condicion de primer orden:
#   q = 1 + chi * (I/K - delta)  ==>  I/K = delta + (1 / chi) * (q - 1)
# ------------------------------------------------------------------------------

delta <- 0.08  # Tasa de depreciacion anual del capital (8%)
q_seq <- seq(0.5, 2.0, by = 0.01)

# Comparacion con tres niveles de costo de ajuste: bajo (chi=5), medio (chi=10), alto (chi=20)
parametros_chi <- c(5, 10, 20)
nombres_chi <- c("Bajo costo de ajuste (chi = 5)",
                 "Costo medio de ajuste (chi = 10)",
                 "Alto costo de ajuste (chi = 20)")

datos_inversion <- expand.grid(q = q_seq, chi = parametros_chi) %>%
  mutate(
    etiqueta_chi = factor(chi, levels = parametros_chi, labels = nombres_chi),
    tasa_inversion = delta + (1 / chi) * (q - 1),
    inversion_neta = (1 / chi) * (q - 1),
    costo_ajuste_unitario = (chi / 2) * (tasa_inversion - delta)^2
  )

# Modelo con asimetria o irreversibilidad parcial (desinvertir tiene costo mayor)
# chi_up = 8 (cuando q > 1), chi_down = 20 (cuando q < 1)
datos_asimetrico <- data.frame(q = q_seq) %>%
  mutate(
    tasa_inversion_simetrica = delta + (1 / 10) * (q - 1),
    tasa_inversion_asimetrica = ifelse(
      q >= 1,
      delta + (1 / 8) * (q - 1),
      delta + (1 / 20) * (q - 1)
    )
  )

# Generacion del Grafico 1: Dinamica de Inversion segun la q de Tobin
p1a <- ggplot(datos_inversion, aes(x = q, y = tasa_inversion, color = etiqueta_chi)) +
  geom_line(linewidth = 1.2) +
  geom_hline(yintercept = delta, linetype = "dashed", color = "gray40", linewidth = 0.8) +
  geom_vline(xintercept = 1.0, linetype = "dashed", color = "gray40", linewidth = 0.8) +
  annotate("point", x = 1.0, y = delta, color = "black", size = 3) +
  annotate("text", x = 1.02, y = delta - 0.02,
           label = "Punto de reposicion:\nq = 1, I/K = delta (8%)",
           hjust = 0, size = 3.5, fontface = "italic") +
  annotate("rect", xmin = 1.0, xmax = 2.0, ymin = delta, ymax = 0.35,
           alpha = 0.08, fill = "#2E7D32") +
  annotate("text", x = 1.5, y = 0.30, label = "Zona de expansion neta (I > delta K)",
           color = "#1B5E20", fontface = "bold", size = 3.8) +
  annotate("rect", xmin = 0.5, xmax = 1.0, ymin = -0.05, ymax = delta,
           alpha = 0.08, fill = "#C62828") +
  annotate("text", x = 0.75, y = 0.02, label = "Zona de contraccion de capital (I < delta K)",
           color = "#B71C1C", fontface = "bold", size = 3.8) +
  scale_color_manual(values = c("#1565C0", "#E65100", "#6A1B9A")) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  labs(
    title = "Teoria de la Inversion Empresarial segun la q de Tobin",
    subtitle = "Relacion no lineal entre el incentivo de mercado (q) y la tasa de acumulacion de capital (I/K)",
    x = "q de Tobin (Valor de Mercado / Costo de Reposicion Fisica)",
    y = "Tasa de Inversion Bruta (I / K)",
    color = "Friccion de instalacion:"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 10, color = "gray30"),
    panel.grid.minor = element_blank()
  )

ruta_fig1 <- file.path(dir_salidas, "fig_tobin_q_inversion.png")
ggsave(ruta_fig1, plot = p1a, width = 9.5, height = 6.2, dpi = 300)
cat("Grafico 1 guardado en:", ruta_fig1, "\n")


# ------------------------------------------------------------------------------
# PARTE 2: TEOREMA DE SEPARACION DE TOBIN Y PREFERENCIA POR LIQUIDEZ (1958)
# ------------------------------------------------------------------------------
# Enfoque:
#   Activo libre de riesgo (dinero / letras del tesoro): R_f = 3%
#   Tres activos riesgosos (Acciones, Bonos Corporativos, Bienes Raices):
#     mu = [11%, 6.5%, 8.5%]
#     Matriz de covarianzas Sigma
# ------------------------------------------------------------------------------

set.seed(1981)

r_f <- 0.03
mu_activos <- c(0.11, 0.065, 0.085)
names(mu_activos) <- c("Acciones", "Bonos_Corp", "Bienes_Raices")

# Matriz de covarianzas coherente y definida positiva
sd_activos <- c(0.18, 0.08, 0.12)
cor_mat <- matrix(c(
  1.0, 0.25, 0.40,
  0.25, 1.0, 0.30,
  0.40, 0.30, 1.0
), nrow = 3, byrow = TRUE)

sigma_mat <- diag(sd_activos) %*% cor_mat %*% diag(sd_activos)
inv_sigma <- solve(sigma_mat)
ones <- rep(1, 3)

# 1. Cartera Tangente (Optima de activos riesgosos de Tobin)
#    Maximiza la ratio de Sharpe: w_T = inv(Sigma)*(mu - r_f) / sum(...)
exceso_retorno <- mu_activos - r_f
w_tangente_unnorm <- inv_sigma %*% exceso_retorno
w_tangente <- as.vector(w_tangente_unnorm / sum(w_tangente_unnorm))
names(w_tangente) <- names(mu_activos)

mu_T <- sum(w_tangente * mu_activos)
sigma_T <- sqrt(as.numeric(t(w_tangente) %*% sigma_mat %*% w_tangente))
sharpe_T <- (mu_T - r_f) / sigma_T

cat("\n--- Cartera Tangente de Tobin (Super-Trust Portfolio) ---\n")
cat("Ponderaciones en activos riesgosos:\n")
print(round(w_tangente, 4))
cat(sprintf("Retorno esperado mu_T: %.2f%%\n", mu_T * 100))
cat(sprintf("Volatilidad sigma_T: %.2f%%\n", sigma_T * 100))
cat(sprintf("Ratio de Sharpe maximo: %.4f\n", sharpe_T))

# 2. Generacion de la Frontera Eficiente de Markowitz (solo activos riesgosos)
#    Resolviendo carteras para una malla de ponderaciones aleatorias y frontera
num_sim <- 5000
pesos_sim <- matrix(runif(num_sim * 3), ncol = 3)
pesos_sim <- pesos_sim / rowSums(pesos_sim)

ret_sim <- as.vector(pesos_sim %*% mu_activos)
vol_sim <- apply(pesos_sim, 1, function(w) sqrt(t(w) %*% sigma_mat %*% w))
df_simulacion <- data.frame(volatilidad = vol_sim, retorno = ret_sim)

# Frontera eficiente analitica (parabola de Markowitz)
A <- as.numeric(t(ones) %*% inv_sigma %*% ones)
B <- as.numeric(t(ones) %*% inv_sigma %*% mu_activos)
C <- as.numeric(t(mu_activos) %*% inv_sigma %*% mu_activos)
D <- A * C - B^2

mu_grid <- seq(min(mu_activos), max(mu_activos) + 0.03, length.out = 300)
sigma_frontier <- sqrt((A * mu_grid^2 - 2 * B * mu_grid + C) / D)
df_frontera_markowitz <- data.frame(volatilidad = sigma_frontier, retorno = mu_grid) %>%
  filter(retorno >= B / A) # Solo tramo eficiente (por encima del minimo de varianza global)

# 3. Linea de Asignacion de Capital de Tobin (CAL / Capital Allocation Line)
#    mu_c = r_f + Sharpe_T * sigma_c
sigma_cal_seq <- seq(0, 0.22, length.out = 200)
df_cal <- data.frame(
  volatilidad = sigma_cal_seq,
  retorno = r_f + sharpe_T * sigma_cal_seq
)

# 4. Tres perfiles de aversor al riesgo
#    Optimizacion: max U = mu_c - 0.5 * gamma * sigma_c^2
#    x* = (mu_T - r_f) / (gamma * sigma_T^2)
#    Con mu_T - r_f = 0.0501 y sigma_T^2 = 0.00684, (mu_T - r_f)/sigma_T^2 = 7.32
perfiles <- data.frame(
  perfil = c("Muy conservador\n(59% Liquidez)",
             "Moderado / Equilibrado\n(19% Liquidez)",
             "Agresivo / Tolerante\n(Apalancado)"),
  gamma = c(18, 9, 5.5),
  color = c("#00796B", "#E65100", "#7B1FA2")
) %>%
  mutate(
    x_opt = (mu_T - r_f) / (gamma * sigma_T^2),
    peso_libre_riesgo = 1 - x_opt,
    sigma_opt = x_opt * sigma_T,
    retorno_opt = r_f + x_opt * (mu_T - r_f),
    utilidad = retorno_opt - 0.5 * gamma * (sigma_opt^2)
  )

cat("\n--- Teorema de Separacion: Eleccion segun Aversion al Riesgo ---\n")
print(perfiles[, c("perfil", "gamma", "x_opt", "peso_libre_riesgo", "retorno_opt", "sigma_opt")])

# Curvas de indiferencia para cada perfil: mu = U + 0.5 * gamma * sigma^2
df_indif <- do.call(rbind, lapply(1:nrow(perfiles), function(i) {
  p <- perfiles[i, ]
  sigmas <- seq(max(0, p$sigma_opt - 0.035), p$sigma_opt + 0.035, length.out = 100)
  data.frame(
    perfil = p$perfil,
    volatilidad = sigmas,
    retorno = p$utilidad + 0.5 * p$gamma * sigmas^2
  )
}))

# Grafico 2: Teorema de Separacion de Tobin
p2 <- ggplot() +
  # Nube de activos riesgosos
  geom_point(data = df_simulacion, aes(x = volatilidad, y = retorno),
             color = "gray82", size = 0.6, alpha = 0.4) +
  # Frontera eficiente de Markowitz
  geom_line(data = df_frontera_markowitz, aes(x = volatilidad, y = retorno),
            color = "#1565C0", linewidth = 1.1, linetype = "solid") +
  # Linea de Asignacion de Capital (Tobin)
  geom_line(data = df_cal, aes(x = volatilidad, y = retorno),
            color = "#D32F2F", linewidth = 1.3) +
  # Curvas de indiferencia
  geom_line(data = df_indif, aes(x = volatilidad, y = retorno, group = perfil),
            color = "#455A64", linetype = "dashed", linewidth = 0.8) +
  # Puntos individuales
  annotate("point", x = 0, y = r_f, color = "#2E7D32", size = 4) +
  annotate("text", x = 0.003, y = r_f + 0.005, label = "Dinero / Activo seguro (Rf = 3%)",
           hjust = 0, fontface = "bold", size = 3.6, color = "#1B5E20") +
  annotate("point", x = sigma_T, y = mu_T, color = "#D32F2F", size = 4) +
  annotate("text", x = sigma_T + 0.004, y = mu_T - 0.005,
           label = "Cartera Tangente (T)\n(Optima de activos riesgosos)",
           hjust = 0, fontface = "bold", size = 3.6, color = "#B71C1C") +
  # Puntos optimos de los perfiles
  geom_point(data = perfiles, aes(x = sigma_opt, y = retorno_opt),
             color = "black", fill = "#FFD54F", shape = 21, size = 4, stroke = 1.5) +
  geom_text(data = perfiles, aes(x = sigma_opt, y = retorno_opt + 0.008, label = perfil),
            size = 3.2, fontface = "bold") +
  scale_x_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0, 0.20)) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0.02, 0.15)) +
  labs(
    title = "Teorema de Separacion de Tobin (1958) y Preferencia por Liquidez",
    subtitle = "Separacion en dos pasos: (1) Seleccion de la cartera riesgosa optima (T) independiente de preferencias;\n(2) Eleccion de liquidez (Rf vs. T) segun la aversion al riesgo individual.",
    x = "Riesgo / Volatilidad anual (Desviacion Estandar sigma)",
    y = "Rendimiento Esperado Anual (mu)",
    caption = "Linea roja: Linea de Asignacion de Capital (CAL). Curva azul: Frontera eficiente de activos riesgosos."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 13.5),
    plot.subtitle = element_text(size = 9.8, color = "gray25"),
    panel.grid.minor = element_blank()
  )

ruta_fig2 <- file.path(dir_salidas, "fig_tobin_separacion_cartera.png")
ggsave(ruta_fig2, plot = p2, width = 9.5, height = 6.5, dpi = 300)
cat("Grafico 2 guardado en:", ruta_fig2, "\n")


# ------------------------------------------------------------------------------
# PARTE 3: GENERACION DE TABLA DE RESULTADOS CONSOLIDADOS
# ------------------------------------------------------------------------------

# Tabla resumen: Escenarios de inversion empresarial por valores de q de Tobin
escenarios_q <- data.frame(
  q_escenario = c(0.60, 0.80, 1.00, 1.20, 1.50, 1.80),
  interpretacion = c("Severa infravaloracion bursatil / Desinversion",
                     "Ligera infravaloracion / Capacidad ociosa",
                     "Equilibrio de reposicion perfecta (q = 1)",
                     "Estimulo moderado a la inversion fisica",
                     "Fuerte auge de inversion corporativa",
                     "Euforia de mercado / Inversion masiva")
) %>%
  mutate(
    I_K_chi5 = delta + (1 / 5) * (q_escenario - 1),
    I_K_chi10 = delta + (1 / 10) * (q_escenario - 1),
    I_K_chi20 = delta + (1 / 20) * (q_escenario - 1)
  )

# Resumen de carteras de Tobin
resumen_carteras <- data.frame(
  categoria = "Seleccion de Cartera",
  indicador = c(
    "Tasa libre de riesgo Rf",
    "Retorno esperado Cartera Tangente (mu_T)",
    "Volatilidad Cartera Tangente (sigma_T)",
    "Ratio de Sharpe Cartera Tangente",
    "Peso Acciones en Cartera Tangente",
    "Peso Bonos Corp en Cartera Tangente",
    "Peso Bienes Raices en Cartera Tangente",
    "Conservador: Peso en Liquidez (Rf)",
    "Conservador: Retorno Cartera",
    "Conservador: Volatilidad Cartera",
    "Moderado: Peso en Liquidez (Rf)",
    "Moderado: Retorno Cartera",
    "Moderado: Volatilidad Cartera",
    "Agresivo: Peso en Liquidez (Rf)",
    "Agresivo: Retorno Cartera",
    "Agresivo: Volatilidad Cartera"
  ),
  valor = c(
    r_f,
    mu_T,
    sigma_T,
    sharpe_T,
    w_tangente["Acciones"],
    w_tangente["Bonos_Corp"],
    w_tangente["Bienes_Raices"],
    perfiles$peso_libre_riesgo[1],
    perfiles$retorno_opt[1],
    perfiles$sigma_opt[1],
    perfiles$peso_libre_riesgo[2],
    perfiles$retorno_opt[2],
    perfiles$sigma_opt[2],
    perfiles$peso_libre_riesgo[3],
    perfiles$retorno_opt[3],
    perfiles$sigma_opt[3]
  )
)

ruta_tabla <- file.path(dir_salidas, "tab_resultados_tobin.csv")
write.csv(resumen_carteras, ruta_tabla, row.names = FALSE)
cat("Tabla de resultados consolidada guardada en:", ruta_tabla, "\n")

cat("\n=== Replicacion ejecutada exitosamente ===\n")

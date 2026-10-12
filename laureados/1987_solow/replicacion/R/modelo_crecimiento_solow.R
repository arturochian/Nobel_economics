# ==============================================================================
# Script: modelo_crecimiento_solow.R
# Laureado: Robert M. Solow (Premio Nobel de Economia 1987)
# Descripcion:
#   1. Simulacion y analisis geometrico del Modelo de Crecimiento Neoclasico
#      de Solow-Swan (1956): funcion de produccion Cobb-Douglas, estado
#      estacionario (k*), Regla de Oro del capital (k_gold*) y dinamica de
#      transicion temporal hacia el equilibrio.
#   2. Contabilidad del crecimiento y estimacion del Residuo de Solow
#      (Productividad Total de los Factores, PTF) segun la metodologia de
#      Solow (1957), descomponiendo la evolucion del producto agregado.
#   3. Generacion y exportacion de figuras en alta resolucion y tabla de datos.
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
})

# ------------------------------------------------------------------------------
# 0. Configuracion de Rutas de Salida
# ------------------------------------------------------------------------------
directorio_actual <- tryCatch({
  dirname(normalizePath(sys.frame(1)$ofile))
}, error = function(e) {
  getwd()
})

ruta_salidas <- file.path(dirname(directorio_actual), "salidas")
if (!dir.exists(ruta_salidas)) {
  ruta_salidas <- file.path("laureados", "1987_solow", "replicacion", "salidas")
  if (!dir.exists(ruta_salidas)) {
    dir.create(ruta_salidas, recursive = TRUE, showWarnings = FALSE)
  }
}

cat("==> Directorio de salidas configurado en:", ruta_salidas, "\n")

# Paleta editorial sobria (azul petroleo, terracota, gris marengo, dorado)
col_base     <- "#1E3D59"  # Azul petroleo profundo
col_sec      <- "#17B890"  # Verde esmeralda
col_inversion<- "#E76F51"  # Terracota
col_deprec   <- "#264653"  # Azul marino oscuro
col_gold     <- "#F4A261"  # Ocre / Oro
col_ptf      <- "#457B9D"  # Azul pizarra
col_capital  <- "#E76F51"  # Terracota
col_trabajo  <- "#2A9D8F"  # Verde turquesa

# ==============================================================================
# SECCION 1: MODELO NEOCLASICO DE SOLOW-SWAN (1956)
# ==============================================================================
cat("1. Modelando dinamica de transicion y estado estacionario de Solow (1956)...\n")

# Parametros estructurales clasicos
alpha <- 0.35    # Participacion del capital en el producto (Cobb-Douglas)
s_base <- 0.22   # Tasa de ahorro e inversion base
n <- 0.015       # Tasa de crecimiento poblacional (1.5% anual)
g <- 0.020       # Tasa de progreso tecnologico exogeno (2.0% anual)
delta <- 0.050   # Tasa de depreciacion fisica del capital (5.0% anual)

# Depreciacion efectiva y dilucion de capital
dilucion <- n + g + delta # 0.085 (8.5% anual)

# Calculos analiticos de estado estacionario
# k* = [s / (n + g + delta)]^(1 / (1 - alpha))
k_star <- (s_base / dilucion)^(1 / (1 - alpha))
y_star <- k_star^alpha
c_star <- (1 - s_base) * y_star
i_star <- s_base * y_star

# Regla de Oro del capital (s_gold = alpha)
s_gold <- alpha
k_gold <- (s_gold / dilucion)^(1 / (1 - alpha))
y_gold <- k_gold^alpha
c_gold <- (1 - s_gold) * y_gold
i_gold <- s_gold * y_gold

# Velocidad de convergencia lambda = (1 - alpha)(n + g + delta)
lambda_conv <- (1 - alpha) * dilucion
t_medivida  <- log(2) / lambda_conv

cat(sprintf("   - Estado Estacionario Base: k* = %.3f | y* = %.3f | c* = %.3f\n", k_star, y_star, c_star))
cat(sprintf("   - Regla de Oro: s_oro = %.2f | k_oro* = %.3f | c_oro* = %.3f\n", s_gold, k_gold, c_gold))
cat(sprintf("   - Velocidad de convergencia: lambda = %.3f (Vida media: %.1f anios)\n", lambda_conv, t_medivida))

# --- Curvas analiticas para el diagrama de Solow ---
k_vals <- seq(0.01, 15, length.out = 400)
df_diagrama <- data.frame(
  k = k_vals,
  y = k_vals^alpha,
  inversion_base = s_base * (k_vals^alpha),
  inversion_gold = s_gold * (k_vals^alpha),
  depreciacion_efectiva = dilucion * k_vals
)

# Panel A: Diagrama clasico de Solow
p1a <- ggplot(df_diagrama, aes(x = k)) +
  geom_ribbon(aes(ymin = inversion_base, ymax = y), fill = "#EBF4F6", alpha = 0.5) +
  geom_line(aes(y = y, color = "Producto: y = f(k) = k^α"), linewidth = 1.1) +
  geom_line(aes(y = depreciacion_efectiva, color = "Depreciación efectiva: (n + g + δ)k"), linewidth = 1.1, linetype = "dashed") +
  geom_line(aes(y = inversion_base, color = "Inversión base: s·f(k) (s = 0.22)"), linewidth = 1.2) +
  geom_line(aes(y = inversion_gold, color = "Regla de Oro: s_oro·f(k) (s = 0.35)"), linewidth = 1.0, linetype = "dotdash") +
  # Puntos de equilibrio
  geom_point(x = k_star, y = s_base * (k_star^alpha), color = col_inversion, size = 3.5) +
  geom_point(x = k_gold, y = s_gold * (k_gold^alpha), color = col_gold, size = 3.5) +
  # Anotaciones
  annotate("text", x = k_star + 0.3, y = (s_base * (k_star^alpha)) + 0.18,
           label = paste0("k* = ", round(k_star, 2)), color = col_inversion, fontface = "bold", size = 3.8) +
  annotate("text", x = k_gold + 0.3, y = (s_gold * (k_gold^alpha)) - 0.12,
           label = paste0("k[oro]* = ", round(k_gold, 2)), color = "#B25E00", fontface = "bold", size = 3.8) +
  annotate("text", x = 2.5, y = 1.35,
           label = "Área de consumo per cápita\nc* = y* - s·y*", color = "#3B6978", size = 3.2, fontface = "italic") +
  scale_color_manual(
    name = "Curvas del Modelo:",
    values = c(
      "Producto: y = f(k) = k^α" = col_deprec,
      "Depreciación efectiva: (n + g + δ)k" = "#8D99AE",
      "Inversión base: s·f(k) (s = 0.22)" = col_inversion,
      "Regla de Oro: s_oro·f(k) (s = 0.35)" = col_gold
    )
  ) +
  scale_x_continuous(breaks = seq(0, 15, 2.5), expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 3, 0.5), limits = c(0, 2.7)) +
  labs(
    title = "A. Diagrama del Estado Estacionario y Regla de Oro",
    subtitle = expression(paste("Equilibrio donde el ahorro bruto iguala la reposición y dilución del capital: ", s %.% f(k) == (n + g + delta) %.% k)),
    x = "Capital por unidad de trabajo eficiente (k)",
    y = "Valores por unidad eficiente"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8.5),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", color = "#1E3D59", size = 12),
    plot.subtitle = element_text(color = "#4A5568", size = 9.5)
  )

# --- Simulacion de la Dinamica de Transicion Temporal ---
T_max <- 70
simular_transicion <- function(k0, s_val, T_horizon = 70) {
  k_vec <- numeric(T_horizon)
  k_vec[1] <- k0
  for (t in 1:(T_horizon - 1)) {
    # Dinamica discreta: k_{t+1} - k_t = s * k_t^alpha - dilucion * k_t
    dk <- s_val * (k_vec[t]^alpha) - dilucion * k_vec[t]
    k_vec[t + 1] <- max(0.001, k_vec[t] + dk)
  }
  return(k_vec)
}

trayectoria_1 <- data.frame(
  t = 1:T_max,
  k = simular_transicion(k0 = 0.5, s_val = s_base, T_horizon = T_max),
  escenario = "1. País subdesarrollado (k0 = 0.50 < k*)"
)
trayectoria_2 <- data.frame(
  t = 1:T_max,
  k = simular_transicion(k0 = 8.0, s_val = s_base, T_horizon = T_max),
  escenario = "2. Capital excedente (k0 = 8.00 > k*)"
)
trayectoria_3 <- data.frame(
  t = 1:T_max,
  k = simular_transicion(k0 = 0.5, s_val = s_gold, T_horizon = T_max),
  escenario = "3. Transición con Regla de Oro (s = 0.35)"
)

df_transicion <- rbind(trayectoria_1, trayectoria_2, trayectoria_3)

# Panel B: Dinamica temporal de transicion y convergencia
p1b <- ggplot(df_transicion, aes(x = t, y = k, color = escenario, linetype = escenario)) +
  geom_hline(yintercept = k_star, color = col_inversion, linetype = "dashed", alpha = 0.7) +
  geom_hline(yintercept = k_gold, color = col_gold, linetype = "dotdash", alpha = 0.7) +
  geom_line(linewidth = 1.2) +
  annotate("text", x = 60, y = k_star + 0.35, label = paste0("k* = ", round(k_star, 2)),
           color = col_inversion, fontface = "bold", size = 3.5) +
  annotate("text", x = 60, y = k_gold + 0.35, label = paste0("k[oro]* = ", round(k_gold, 2)),
           color = "#B25E00", fontface = "bold", size = 3.5) +
  scale_color_manual(
    name = "Trayectoria Temporal:",
    values = c(
      "1. País subdesarrollado (k0 = 0.50 < k*)" = "#2A9D8F",
      "2. Capital excedente (k0 = 8.00 > k*)" = "#E76F51",
      "3. Transición con Regla de Oro (s = 0.35)" = "#E9C46A"
    )
  ) +
  scale_linetype_manual(
    name = "Trayectoria Temporal:",
    values = c(
      "1. País subdesarrollado (k0 = 0.50 < k*)" = "solid",
      "2. Capital excedente (k0 = 8.00 > k*)" = "solid",
      "3. Transición con Regla de Oro (s = 0.35)" = "dashed"
    )
  ) +
  scale_x_continuous(breaks = seq(0, T_max, 10)) +
  labs(
    title = "B. Trayectoria de Transición y Convergencia Hacia el Estado Estacionario",
    subtitle = sprintf("Convergencia incondicional asintótica a una tasa teórica λ = %.2f%% anual", lambda_conv * 100),
    x = "Tiempo (períodos / años)",
    y = "Capital por trabajador efectivo k(t)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8.5),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", color = "#1E3D59", size = 12),
    plot.subtitle = element_text(color = "#4A5568", size = 9.5)
  )

# Guardar figura compuesta 1
png(filename = file.path(ruta_salidas, "fig_solow_estado_estacionario.png"),
    width = 3400, height = 3600, res = 300)
gridExtra::grid.arrange(p1a, p1b, ncol = 1)
dev.off()
cat("   -> Guardado: fig_solow_estado_estacionario.png\n")


# ==============================================================================
# SECCION 2: CONTABILIDAD DEL CRECIMIENTO Y RESIDUO DE SOLOW (1957)
# ==============================================================================
cat("2. Generando simulacion y contabilidad del crecimiento (Solow 1957)...\n")

set.seed(1987) # Semilla en homenaje al anio del Nobel de Solow

# Periodo historico simulado de 50 anios (ej. 1971 a 2020)
anios <- 1971:2020
N_anios <- length(anios)

# Generacion de dinamica macroeconomica con hechos estilizados del crecimiento:
# - Participacion factorial: capital alpha = 0.35, trabajo (1 - alpha) = 0.65
# - Crecimiento del trabajo g_L: media 1.2%, sd 0.5%
# - Crecimiento del capital g_K: media 3.0%, sd 1.0%
# - Productividad Total de los Factores g_A: media 1.4%, con aceleracion en los 90 (revolucion TIC)
#   y desaceleracion post-2008.

g_L_sim <- rnorm(N_anios, mean = 0.012, sd = 0.005)
g_K_sim <- rnorm(N_anios, mean = 0.030, sd = 0.010)

# Patron estructural de PTF (con oleadas de innovacion)
g_A_base <- rnorm(N_anios, mean = 0.013, sd = 0.007)
# Boom digital (1995-2004)
anios_boom <- anios >= 1995 & anios <= 2004
g_A_base[anios_boom] <- g_A_base[anios_boom] + 0.012
# Gran Recesion (2008-2009)
anios_crisis <- anios %in% c(2008, 2009)
g_A_base[anios_crisis] <- g_A_base[anios_crisis] - 0.025

g_A_sim <- g_A_base

# Descomposicion exacta de Solow:
# g_Y = alpha * g_K + (1 - alpha) * g_L + g_A
g_Y_sim <- alpha * g_K_sim + (1 - alpha) * g_L_sim + g_A_sim

# Contribuciones contables
contrib_K <- alpha * g_K_sim
contrib_L <- (1 - alpha) * g_L_sim
residuo_solow <- g_Y_sim - (contrib_K + contrib_L) # Idéntico a g_A_sim por construcción

# Construccion de series de indices base 100 en 1970
idx_Y <- numeric(N_anios + 1)
idx_K <- numeric(N_anios + 1)
idx_L <- numeric(N_anios + 1)
idx_A <- numeric(N_anios + 1)

idx_Y[1] <- 100
idx_K[1] <- 100
idx_L[1] <- 100
idx_A[1] <- 100

for (i in 1:N_anios) {
  idx_Y[i + 1] <- idx_Y[i] * (1 + g_Y_sim[i])
  idx_K[i + 1] <- idx_K[i] * (1 + g_K_sim[i])
  idx_L[i + 1] <- idx_L[i] * (1 + g_L_sim[i])
  idx_A[i + 1] <- idx_A[i] * (1 + residuo_solow[i])
}

# Data frame de contabilidad anual
df_contabilidad <- data.frame(
  anio = anios,
  g_Y = g_Y_sim * 100,
  contrib_K = contrib_K * 100,
  contrib_L = contrib_L * 100,
  residuo_PTF = residuo_solow * 100
)

# Data frame en formato largo para barras apiladas
df_barras <- df_contabilidad %>%
  select(anio, contrib_K, contrib_L, residuo_PTF) %>%
  pivot_longer(cols = c(contrib_K, contrib_L, residuo_PTF),
               names_to = "componente", values_to = "contribucion") %>%
  mutate(componente_lab = factor(
    componente,
    levels = c("contrib_L", "contrib_K", "residuo_PTF"),
    labels = c("Trabajo: (1 - α)·Δln L", "Capital: α·Δln K", "Residuo de Solow (PTF): Δln A")
  ))

# Data frame de indices acumulados
df_indices <- data.frame(
  anio = 1970:2020,
  PIB_Total = idx_Y,
  Capital_por_Trabajador = (idx_K / idx_L) * 100,
  PTF_Solow = idx_A
) %>%
  pivot_longer(cols = c(PIB_Total, Capital_por_Trabajador, PTF_Solow),
               names_to = "variable", values_to = "indice") %>%
  mutate(variable_lab = factor(
    variable,
    levels = c("PIB_Total", "Capital_por_Trabajador", "PTF_Solow"),
    labels = c("PIB Agregado Y(t)", "Intensidad de Capital K(t)/L(t)", "Productividad Total de Factores A(t)")
  ))

# Panel 2A: Descomposicion anual del crecimiento (barras y linea de PIB)
p2a <- ggplot() +
  geom_bar(data = df_barras, aes(x = anio, y = contribucion, fill = componente_lab),
           stat = "identity", position = "stack", width = 0.75, alpha = 0.9) +
  geom_line(data = df_contabilidad, aes(x = anio, y = g_Y, color = "Crecimiento del PIB: Δln Y"),
            linewidth = 1.0) +
  geom_point(data = df_contabilidad, aes(x = anio, y = g_Y, color = "Crecimiento del PIB: Δln Y"),
             size = 1.5) +
  scale_fill_manual(
    name = "Fuentes de Crecimiento:",
    values = c(
      "Trabajo: (1 - α)·Δln L" = col_trabajo,
      "Capital: α·Δln K" = col_capital,
      "Residuo de Solow (PTF): Δln A" = col_ptf
    )
  ) +
  scale_color_manual(
    name = "",
    values = c("Crecimiento del PIB: Δln Y" = "#1E2022")
  ) +
  scale_x_continuous(breaks = seq(1970, 2020, 5)) +
  scale_y_continuous(breaks = seq(-4, 8, 2), labels = function(x) paste0(x, "%")) +
  labs(
    title = "A. Descomposición Anual del Crecimiento Económico (1971–2020)",
    subtitle = "Contribución contable de factores productivos y del Residuo de Solow (PTF)",
    x = "Año",
    y = "Tasa de crecimiento anual"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8.5),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", color = "#1E3D59", size = 12),
    plot.subtitle = element_text(color = "#4A5568", size = 9.5)
  )

# Panel 2B: Evolucion de indices acumulados
p2b <- ggplot(df_indices, aes(x = anio, y = indice, color = variable_lab, linetype = variable_lab)) +
  geom_hline(yintercept = 100, linetype = "dotted", color = "gray50") +
  geom_line(linewidth = 1.2) +
  scale_color_manual(
    name = "Índice Acumulado (1970 = 100):",
    values = c(
      "PIB Agregado Y(t)" = col_base,
      "Intensidad de Capital K(t)/L(t)" = col_capital,
      "Productividad Total de Factores A(t)" = col_ptf
    )
  ) +
  scale_linetype_manual(
    name = "Índice Acumulado (1970 = 100):",
    values = c(
      "PIB Agregado Y(t)" = "solid",
      "Intensidad de Capital K(t)/L(t)" = "dashed",
      "Productividad Total de Factores A(t)" = "dotdash"
    )
  ) +
  scale_x_continuous(breaks = seq(1970, 2020, 5)) +
  scale_y_continuous(breaks = seq(100, 600, 100)) +
  labs(
    title = "B. Evolución de Índices Acumulados de Largo Plazo (Base 1970 = 100)",
    subtitle = "Replicando el hallazgo de Solow (1957): la PTF impulsa la mayor parte del crecimiento sostenido",
    x = "Año",
    y = "Nivel del índice (1970 = 100)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8.5),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", color = "#1E3D59", size = 12),
    plot.subtitle = element_text(color = "#4A5568", size = 9.5)
  )

# Guardar figura compuesta 2
png(filename = file.path(ruta_salidas, "fig_solow_contabilidad_crecimiento.png"),
    width = 3400, height = 3600, res = 300)
gridExtra::grid.arrange(p2a, p2b, ncol = 1)
dev.off()
cat("   -> Guardado: fig_solow_contabilidad_crecimiento.png\n")


# ==============================================================================
# SECCION 3: TABLA CONSOLIDADA DE RESULTADOS
# ==============================================================================
cat("3. Consolidando tabla de resultados y metricas analiticas...\n")

prom_g_Y <- mean(df_contabilidad$g_Y)
prom_contrib_K <- mean(df_contabilidad$contrib_K)
prom_contrib_L <- mean(df_contabilidad$contrib_L)
prom_PTF <- mean(df_contabilidad$residuo_PTF)

pct_PTF <- (prom_PTF / prom_g_Y) * 100
pct_K   <- (prom_contrib_K / prom_g_Y) * 100
pct_L   <- (prom_contrib_L / prom_g_Y) * 100

tabla_resultados <- data.frame(
  categoria = c(
    rep("Modelo Neoclasico (Estado Estacionario)", 6),
    rep("Regla de Oro del Capital", 4),
    rep("Dinamica de Transicion", 2),
    rep("Contabilidad del Crecimiento (1971-2020)", 7)
  ),
  metrica = c(
    "Elasticidad del capital (alpha)",
    "Tasa de ahorro base (s)",
    "Depreciacion efectiva (n + g + delta)",
    "Capital por trabajo efectivo estacionario (k*)",
    "Producto por trabajo efectivo estacionario (y*)",
    "Consumo por trabajo efectivo estacionario (c*)",
    "Tasa de ahorro de la Regla de Oro (s_oro)",
    "Capital de la Regla de Oro (k_oro*)",
    "Producto de la Regla de Oro (y_oro*)",
    "Consumo maximo de la Regla de Oro (c_oro*)",
    "Velocidad de convergencia (lambda)",
    "Vida media de convergencia (t_1/2 en anios)",
    "Tasa media anual de crecimiento del PIB (g_Y)",
    "Contribucion media anual del Capital (alpha * g_K)",
    "Contribucion media anual del Trabajo ((1 - alpha) * g_L)",
    "Residuo medio anual de Solow / PTF (g_A)",
    "Participacion porcentual de la PTF en el crecimiento",
    "Participacion porcentual del Capital en el crecimiento",
    "Participacion porcentual del Trabajo en el crecimiento"
  ),
  valor = c(
    sprintf("%.2f", alpha),
    sprintf("%.2f", s_base),
    sprintf("%.3f", dilucion),
    sprintf("%.3f", k_star),
    sprintf("%.3f", y_star),
    sprintf("%.3f", c_star),
    sprintf("%.2f", s_gold),
    sprintf("%.3f", k_gold),
    sprintf("%.3f", y_gold),
    sprintf("%.3f", c_gold),
    sprintf("%.4f (%.2f%%)", lambda_conv, lambda_conv * 100),
    sprintf("%.1f anios", t_medivida),
    sprintf("%.2f%%", prom_g_Y),
    sprintf("%.2f%%", prom_contrib_K),
    sprintf("%.2f%%", prom_contrib_L),
    sprintf("%.2f%%", prom_PTF),
    sprintf("%.1f%%", pct_PTF),
    sprintf("%.1f%%", pct_K),
    sprintf("%.1f%%", pct_L)
  ),
  interpretacion = c(
    "Participacion del capital bajo competencia perfecta",
    "Proporcion del producto agregado reinvertida",
    "Tasa a la que se diluye y desgasta el capital per capita",
    "Nivel de equilibrio de largo plazo",
    "Nivel de produccion intensiva de equilibrio",
    "Bienestar y consumo material por habitante sostenible",
    "Tasa de ahorro que maximiza el consumo intertemporal permanente",
    "Nivel de capital con maxima holgura de consumo",
    "Producto alcanzable bajo la regla de oro",
    "Maximo consumo per capita alcanzable en estado estacionario",
    "Ritmo al que se cierra la brecha al equilibrio",
    "Tiempo requerido para cerrar el 50% de la brecha inicial",
    "Crecimiento medio del producto en la simulacion historica",
    "Aporte de la acumulacion de capital fisico al PIB",
    "Aporte de la expansion demografica y horas trabajadas",
    "Progreso tecnologico exogeno e innovacion no explicada",
    "Fraccion del crecimiento explicada por el progreso tecnico",
    "Fraccion del crecimiento atribuible a maquinaria e infraestructura",
    "Fraccion del crecimiento atribuible al factor humano"
  ),
  stringsAsFactors = FALSE
)

archivo_csv <- file.path(ruta_salidas, "tab_resultados_solow.csv")
write.csv(tabla_resultados, archivo_csv, row.names = FALSE, fileEncoding = "UTF-8")
cat("   -> Guardado:", archivo_csv, "\n")

cat("\n==============================================================================\n")
cat("Ejecucion completada con exito. Todos los productos generados.\n")
cat("==============================================================================\n")

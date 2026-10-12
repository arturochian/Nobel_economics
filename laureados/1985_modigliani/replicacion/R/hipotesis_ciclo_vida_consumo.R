# ==============================================================================
# Script: hipotesis_ciclo_vida_consumo.R
# Autor: Proyecto Nobel_economics
# Descripción: Replicación cuantitativa y computacional de la Hipótesis del Ciclo
#              de Vida (Life-Cycle Hypothesis, LCH) de Franco Modigliani.
#              1. Perfiles individuales de ingreso, consumo y riqueza (20 a 85 años).
#              2. Modelo de generaciones solapadas y tasa de ahorro agregada ante
#                 envejecimiento demográfico y crecimiento económico.
# Salidas:
#   - salidas/fig_modigliani_ciclo_vida_perfiles.png
#   - salidas/fig_modigliani_ahorro_demografia.png
#   - salidas/tab_resultados_modigliani.csv
# ==============================================================================

# Cargar librerías necesarias
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
  library(patchwork)
})

# Configurar directorio de trabajo y rutas de salida de forma robusta
obtener_script_dir <- function() {
  cmd_args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", cmd_args, value = TRUE)
  if (length(file_arg) > 0) {
    return(dirname(normalizePath(sub("^--file=", "", file_arg[1]))))
  }
  if (!is.null(sys.frame(1)$ofile)) {
    return(dirname(normalizePath(sys.frame(1)$ofile)))
  }
  if (dir.exists(file.path("laureados", "1985_modigliani", "replicacion", "R"))) {
    return(normalizePath(file.path("laureados", "1985_modigliani", "replicacion", "R")))
  }
  return(getwd())
}

script_dir <- obtener_script_dir()
output_dir <- file.path(dirname(script_dir), "salidas")
if (!dir.exists(output_dir)) {
  output_dir <- file.path("laureados", "1985_modigliani", "replicacion", "salidas")
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  }
}
output_dir <- normalizePath(output_dir, mustWork = FALSE)

# Configuración estética global para gráficos estilo publicación
tema_nobel <- theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#1a252f", hjust = 0),
    plot.subtitle = element_text(size = 11, color = "#555555", margin = margin(b = 10)),
    plot.caption = element_text(size = 9, color = "#777777", hjust = 1, margin = margin(t = 10)),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#e2e8f0", linewidth = 0.5),
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 10),
    legend.background = element_rect(fill = alpha("#f8fafc", 0.8), color = NA),
    axis.title = element_text(face = "bold", size = 10, color = "#2c3e50"),
    axis.text = element_text(color = "#4a5568", size = 9),
    strip.text = element_text(face = "bold", size = 10, color = "#2c3e50")
  )

# ==============================================================================
# PARTE 1: MODELO MICROECONÓMICO DEL CICLO DE VIDA INDIVIDUAL (MODIGLIANI-BRUMBERG)
# ==============================================================================

# Parámetros del ciclo vital individual
edad_inicio   <- 20   # Entrada al mercado laboral
edad_retiro   <- 65   # Edad de jubilación
edad_muerte   <- 85   # Fin del horizonte vital esperado
anios_totales <- edad_muerte - edad_inicio + 1 # 66 años de vida adulta (20 a 85)
anios_laboral <- edad_retiro - edad_inicio     # 45 años de trabajo activo
anios_retiro  <- edad_muerte - edad_retiro + 1 # 21 años de retiro

edades <- edad_inicio:edad_muerte
n_edades <- length(edades)

# Perfil empírico salarial con joroba (hump-shaped earnings profile)
# Aproximado mediante función cuadrática estandarizada:
# Ingreso laboral crece en juventud por acumulación de capital humano,
# alcanza un máximo en torno a los 50-52 años y decae levemente previo al retiro.
ingreso_laboral_base <- function(e) {
  if (e < edad_retiro) {
    # Salario horario/anual escalado (en miles de dólares anuales)
    # Pico en torno a edad 50
    base <- 25 + 2.5 * (e - 20) - 0.045 * (e - 20)^2
    return(max(0, base))
  } else {
    return(0) # Sin pensión contributiva en el caso base sin transferencias
  }
}

Y_base <- sapply(edades, ingreso_laboral_base)

# Tasa de interés real (r) y tasa subjetiva de descuento intertemporal (rho)
r <- 0.03
rho <- 0.03 # Si r == rho, el perfil óptimo de consumo es plano (Euler estándar)

# Factores de descuento estocástico/financiero
# Para una persona de 20 años:
# Valor presente de ingresos laborales vitales (Human Wealth)
vp_factores <- (1 + r)^(-(0:(n_edades - 1)))
riqueza_humana_vp <- sum(Y_base * vp_factores)

# Anualidad del consumo constante:
# PV(C) = C * sum_{t=0}^{T-1} (1+r)^{-t} = riqueza_humana_vp
factor_anualidad <- sum(vp_factores)
C_optimo_constante <- riqueza_humana_vp / factor_anualidad

# Trayectoria de ahorro y acumulación de riqueza financiera:
# A_{t+1} = (1+r) * A_t + Y_t - C_t, con A_20 = 0
A_trayectoria <- numeric(n_edades)
S_trayectoria <- numeric(n_edades) # Ahorro corriente: Y_t + r*A_t - C_t
A_actual <- 0

for (i in 1:n_edades) {
  A_trayectoria[i] <- A_actual
  ahorro_corriente <- Y_base[i] + r * A_actual - C_optimo_constante
  S_trayectoria[i] <- ahorro_corriente
  A_actual <- (1 + r) * A_actual + Y_base[i] - C_optimo_constante
}

# Caso 2: Con Sistema de Seguridad Social / Pensiones de Reparto (Pay-As-You-Go)
# Aporte previsional del 12% durante etapa laboral, pensión de reemplazo del 50% en retiro.
tasa_aporte <- 0.12
pension_reemplazo <- mean(Y_base[1:anios_laboral]) * 0.45

Y_con_pension <- numeric(n_edades)
for (i in 1:n_edades) {
  if (edades[i] < edad_retiro) {
    Y_con_pension[i] <- Y_base[i] * (1 - tasa_aporte)
  } else {
    Y_con_pension[i] <- pension_reemplazo
  }
}

vp_recursos_pension <- sum(Y_con_pension * vp_factores)
C_con_pension <- vp_recursos_pension / factor_anualidad

A_con_pension <- numeric(n_edades)
A_actual_pen <- 0
for (i in 1:n_edades) {
  A_con_pension[i] <- A_actual_pen
  A_actual_pen <- (1 + r) * A_actual_pen + Y_con_pension[i] - C_con_pension
}

df_individual <- data.frame(
  Edad = rep(edades, 2),
  Escenario = rep(c("Sin Seguridad Social (Ahorro Puro)", "Con Seguridad Social (Pensión de Reparto)"), each = n_edades),
  Ingreso = c(Y_base, Y_con_pension),
  Consumo = c(rep(C_optimo_constante, n_edades), rep(C_con_pension, n_edades)),
  Riqueza = c(A_trayectoria, A_con_pension),
  Ahorro = c(S_trayectoria, Y_con_pension + r * A_con_pension - C_con_pension)
)

# ==============================================================================
# GENERACIÓN DE FIGURA 1: PERFILES INDIVIDUALES DE CICLO DE VIDA
# ==============================================================================

# Filtrar para el caso canónico de Modigliani (ahorro privado puro)
df_canonico <- df_individual %>% filter(Escenario == "Sin Seguridad Social (Ahorro Puro)")

# Panel A: Ingreso vs Consumo con zonas de desahorro y acumulación
p1_a <- ggplot(df_canonico, aes(x = Edad)) +
  geom_ribbon(aes(ymin = Consumo, ymax = pmax(Ingreso, Consumo)), fill = "#2ecc71", alpha = 0.25) +
  geom_ribbon(aes(ymin = pmin(Ingreso, Consumo), ymax = Consumo), fill = "#e74c3c", alpha = 0.20) +
  geom_line(aes(y = Ingreso, color = "Ingreso Laboral (Y)"), linewidth = 1.2) +
  geom_line(aes(y = Consumo, color = "Consumo Suavizado (C)"), linewidth = 1.2, linetype = "solid") +
  geom_vline(xintercept = 65, linetype = "dashed", color = "#7f8c8d", linewidth = 0.8) +
  annotate("text", x = 65.5, y = 55, label = "Edad de Retiro (65)", hjust = 0, size = 3.2, color = "#34495e", fontface = "italic") +
  annotate("text", x = 38, y = 48, label = "Acumulación / Ahorro Activo", size = 3.4, color = "#27ae60", fontface = "bold") +
  annotate("text", x = 75, y = 25, label = "Desahorro\n(Jubilación)", size = 3.4, color = "#c0392b", fontface = "bold") +
  scale_color_manual(name = "Variable", values = c("Ingreso Laboral (Y)" = "#2980b9", "Consumo Suavizado (C)" = "#e67e22")) +
  scale_y_continuous(labels = label_dollar(suffix = "k", prefix = "$")) +
  scale_x_continuous(breaks = seq(20, 85, by = 10)) +
  labs(
    title = "A. Hipótesis del Ciclo de Vida: Flujos de Ingreso y Consumo",
    subtitle = "Suavizamiento del consumo ante variabilidad previsible del ingreso laboral",
    x = "Edad del Individuo",
    y = "Monto Anual ($ miles)"
  ) +
  tema_nobel

# Panel B: Trayectoria de Riqueza Acumulada (Efecto Desplazamiento por Pensiones)
p1_b <- ggplot(df_individual, aes(x = Edad, y = Riqueza, color = Escenario, linetype = Escenario)) +
  geom_line(linewidth = 1.2) +
  geom_vline(xintercept = 65, linetype = "dashed", color = "#7f8c8d", linewidth = 0.8) +
  scale_color_manual(name = "Régimen Institucional", values = c("Sin Seguridad Social (Ahorro Puro)" = "#2c3e50", "Con Seguridad Social (Pensión de Reparto)" = "#8e44ad")) +
  scale_linetype_manual(name = "Régimen Institucional", values = c("solid", "longdash")) +
  scale_y_continuous(labels = label_dollar(suffix = "k", prefix = "$")) +
  scale_x_continuous(breaks = seq(20, 85, by = 10)) +
  annotate("text", x = 64, y = max(df_individual$Riqueza) * 0.95, label = "Pico de Riqueza en Retiro", hjust = 1, size = 3.3, color = "#2c3e50", fontface = "bold") +
  labs(
    title = "B. Acumulación de Riqueza y Efecto Desplazamiento de Pensiones",
    subtitle = "La seguridad social de reparto reduce el acervo privado de capital (Efecto Modigliani-Feldstein)",
    x = "Edad del Individuo",
    y = "Riqueza Financiera Acumulada ($ miles)",
    caption = "Fuente: Modelo cuantitativo de Ciclo de Vida (Modigliani & Brumberg 1954; Ando & Modigliani 1963)."
  ) +
  tema_nobel

fig_perfiles <- p1_a / p1_b

ggsave(
  filename = file.path(output_dir, "fig_modigliani_ciclo_vida_perfiles.png"),
  plot = fig_perfiles,
  width = 9.5,
  height = 8.5,
  dpi = 300
)

# ==============================================================================
# PARTE 2: AGREGACIÓN MACROECONÓMICA Y ENVEJECIMIENTO DEMOGRÁFICO
# ==============================================================================
# En el modelo agregado de Modigliani (1966, 1986):
# La tasa de ahorro nacional agregada (S/Y) no depende del nivel de ingreso, sino de:
# 1. La tasa de crecimiento poblacional (n).
# 2. La tasa de crecimiento de la productividad y salarios (g).
# 3. La estructura de edades (tasa de dependencia de la vejez).
#
# Para una cohorte nacida en el año (t - edad):
# Su tamaño poblacional es N(edad) = N_0 * (1 + n)^(-edad).
# Su salario a edad equivalente es mayor por crecimiento g: Y_cohorte(edad) = Y_base(edad) * (1 + g)^(-edad).

simular_ahorro_agregado <- function(n_crec, g_crec, perfil_Y = Y_base, C_opt = C_optimo_constante, A_perfil = A_trayectoria) {
  # Cohortes de edad 20 a 85
  pesos_poblacion <- (1 + n_crec)^(-(edades - 20))
  pesos_productividad <- (1 + g_crec)^(-(edades - 20))
  
  # Cantidades agregadas
  N_activos <- sum(pesos_poblacion[edades < edad_retiro])
  N_retirados <- sum(pesos_poblacion[edades >= edad_retiro])
  tasa_dependencia_vejez <- N_retirados / N_activos
  
  # Ingreso, Consumo y Ahorro agregados de cada cohorte
  # Salario de cohorte ajustado por crecimiento generacional
  Y_agregado_cohorte <- pesos_poblacion * (perfil_Y * pesos_productividad)
  C_agregado_cohorte <- pesos_poblacion * (C_opt * pesos_productividad)
  A_agregado_cohorte <- pesos_poblacion * (A_perfil * pesos_productividad)
  
  # Ingreso nacional: Ingreso laboral + Renta del capital r*A
  Y_laboral_total <- sum(Y_agregado_cohorte)
  Renta_capital_total <- r * sum(A_agregado_cohorte)
  Y_nacional_total <- Y_laboral_total + Renta_capital_total
  
  C_total <- sum(C_agregado_cohorte)
  Ahorro_total <- Y_nacional_total - C_total
  
  Riqueza_total <- sum(A_agregado_cohorte)
  
  tasa_ahorro_nacional <- Ahorro_total / Y_nacional_total
  ratio_riqueza_ingreso <- Riqueza_total / Y_nacional_total
  
  return(data.frame(
    n = n_crec,
    g = g_crec,
    tasa_dependencia = tasa_dependencia_vejez,
    tasa_ahorro = tasa_ahorro_nacional,
    ratio_W_Y = ratio_riqueza_ingreso,
    Y_total = Y_nacional_total,
    S_total = Ahorro_total,
    W_total = Riqueza_total
  ))
}

# Grid de simulación: Variación en la tasa de crecimiento demográfico n (-1.5% a +3%)
grid_n <- seq(-0.015, 0.030, by = 0.001)

# Evaluamos para diferentes niveles de crecimiento de productividad g (0%, 1.5%, 3%)
df_sim_demografia <- bind_rows(
  lapply(grid_n, function(n_val) simular_ahorro_agregado(n_val, g_crec = 0.00)),
  lapply(grid_n, function(n_val) simular_ahorro_agregado(n_val, g_crec = 0.015)),
  lapply(grid_n, function(n_val) simular_ahorro_agregado(n_val, g_crec = 0.030))
) %>% mutate(
  g_etiqueta = factor(
    case_when(
      g == 0.000 ~ "Productividad Estacionaria (g = 0%)",
      g == 0.015 ~ "Crecimiento Moderado (g = 1.5%)",
      g == 0.030 ~ "Crecimiento Dinámico (g = 3.0%)"
    ),
    levels = c("Productividad Estacionaria (g = 0%)", "Crecimiento Moderado (g = 1.5%)", "Crecimiento Dinámico (g = 3.0%)")
  )
)

# ==============================================================================
# GENERACIÓN DE FIGURA 2: IMPACTO DEMOGRÁFICO SOBRE EL AHORRO NACIONAL
# ==============================================================================

# Panel A: Tasa de Ahorro Agregada vs. Crecimiento Demográfico (n)
p2_a <- ggplot(df_sim_demografia, aes(x = n, y = tasa_ahorro, color = g_etiqueta)) +
  geom_hline(yintercept = 0, linetype = "solid", color = "#7f8c8d", linewidth = 0.6) +
  geom_line(linewidth = 1.2) +
  scale_x_continuous(labels = label_percent(accuracy = 0.1), breaks = seq(-0.015, 0.03, by = 0.01)) +
  scale_y_continuous(labels = label_percent(accuracy = 1)) +
  scale_color_manual(name = "Crecimiento de Productividad (g)", values = c("#c0392b", "#2980b9", "#27ae60")) +
  labs(
    title = "A. Tasa de Ahorro Nacional vs. Crecimiento Demográfico (n)",
    subtitle = "A mayor natalidad/juventud, la masa de ahorradores activos domina a los jubilados",
    x = "Tasa de Crecimiento Poblacional Anual (n)",
    y = "Tasa de Ahorro Agregada (S / Y)"
  ) +
  tema_nobel

# Panel B: Tasa de Ahorro Agregada vs. Tasa de Dependencia de la Vejez
p2_b <- ggplot(df_sim_demografia, aes(x = tasa_dependencia, y = tasa_ahorro, color = g_etiqueta)) +
  geom_hline(yintercept = 0, linetype = "solid", color = "#7f8c8d", linewidth = 0.6) +
  geom_line(linewidth = 1.2) +
  scale_x_continuous(labels = label_percent(accuracy = 1)) +
  scale_y_continuous(labels = label_percent(accuracy = 1)) +
  scale_color_manual(name = "Crecimiento de Productividad (g)", values = c("#c0392b", "#2980b9", "#27ae60")) +
  annotate("rect", xmin = 0.40, xmax = 0.70, ymin = -Inf, ymax = Inf, fill = "#e74c3c", alpha = 0.08) +
  annotate("text", x = 0.55, y = 0.15, label = "Sociedades Envejecidas\n(Europa, Japón actual)", size = 3.2, color = "#c0392b", fontface = "italic") +
  labs(
    title = "B. Efecto del Envejecimiento: Tasa de Dependencia de Vejez",
    subtitle = "La contracción de la base laboral genera desahorro neto agregado en ausencia de crecimiento",
    x = "Tasa de Dependencia de Vejez (Adultos Mayores / Población Activa)",
    y = "Tasa de Ahorro Agregada (S / Y)",
    caption = "Fuente: Modelo agregado de ciclo de vida (Modigliani 1966, 1986). Simulación propia Nobel_economics."
  ) +
  tema_nobel

fig_demografia <- (p2_a + p2_b) +
  plot_layout(guides = "collect") &
  theme(legend.position = "bottom")

ggsave(
  filename = file.path(output_dir, "fig_modigliani_ahorro_demografia.png"),
  plot = fig_demografia,
  width = 11,
  height = 5.5,
  dpi = 300
)

# ==============================================================================
# TABLA RESUMEN DE RESULTADOS: ESCENARIOS DEMOGRÁFICOS TÍPICOS
# ==============================================================================

# Seleccionar puntos clave que representen diferentes etapas históricas y globales:
# 1. Envejecimiento Severo / Despoblación (n = -1.0%, g = 1.0%)
# 2. Sociedad Estacionaria / Madura (n = 0.0%, g = 1.5%)
# 3. Bono Demográfico Moderado (n = 1.0%, g = 2.0%)
# 4. Expansión Demográfica Rápida / Países Emergentes (n = 2.5%, g = 3.0%)
# 5. Escenario Sin Crecimiento (n = 0.0%, g = 0.0% -> Modigliani Teorema Cero)

escenarios_clave <- list(
  list(nombre = "Envejecimiento Severo (Crisis Demográfica)", n = -0.010, g = 0.010),
  list(nombre = "Población Estacionaria (Reemplazo Cero)", n = 0.000, g = 0.015),
  list(nombre = "Teorema Puro de Modigliani (g=0, n=0)", n = 0.000, g = 0.000),
  list(nombre = "Bono Demográfico Dinámico", n = 0.015, g = 0.020),
  list(nombre = "Expansión Demográfica Emergente", n = 0.025, g = 0.030)
)

tab_resultados <- bind_rows(lapply(escenarios_clave, function(sc) {
  res <- simular_ahorro_agregado(sc$n, sc$g)
  res$Escenario <- sc$nombre
  return(res)
})) %>%
  select(
    Escenario,
    n_poblacion = n,
    g_productividad = g,
    tasa_dependencia,
    tasa_ahorro,
    ratio_W_Y
  ) %>%
  mutate(
    Crecimiento_Poblacional_pct = sprintf("%.1f%%", n_poblacion * 100),
    Crecimiento_Productividad_pct = sprintf("%.1f%%", g_productividad * 100),
    Tasa_Dependencia_pct = sprintf("%.1f%%", tasa_dependencia * 100),
    Tasa_Ahorro_Nacional_pct = sprintf("%.2f%%", tasa_ahorro * 100),
    Ratio_Riqueza_Ingreso = sprintf("%.2f", ratio_W_Y)
  )

# Guardar tabla consolidada en CSV
write.csv(
  tab_resultados,
  file = file.path(output_dir, "tab_resultados_modigliani.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

message(">>> Replicación de Modigliani completada exitosamente.")
message(">>> Archivos generados en: ", output_dir)
message("    - fig_modigliani_ciclo_vida_perfiles.png")
message("    - fig_modigliani_ahorro_demografia.png")
message("    - tab_resultados_modigliani.csv")

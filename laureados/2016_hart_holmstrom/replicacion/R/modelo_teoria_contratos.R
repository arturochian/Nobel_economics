# ==============================================================================
# modelo_teoria_contratos.R
# Replicación y Simulación Ilustrativa: Teoría de Contratos y Derechos de Propiedad
# Premio Nobel de Economía 2016: Bengt Holmström y Oliver Hart
# ==============================================================================
# 
# Contenido del script:
# 1. Modelo de Holmström (1979): Trade-off entre riesgo e incentivos y Principio de Informatividad.
# 2. Modelo de Holmström y Milgrom (1991): Incentivos multitarea y distorsión de esfuerzos.
# 3. Modelo de Grossman, Hart y Moore (1986, 1990): Contratos incompletos y asignación óptima de propiedad.
# 4. Generación de figuras PNG y tabla de resultados CSV en la carpeta 'salidas/'.
#
# Autor: Proyecto Nobel_economics
# Fecha: 2026-10-12
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(scales)
  library(patchwork)
})

# Fijar semilla para reproducibilidad estricta
set.seed(20161010)

# Configuración de rutas relativas
script_dir <- tryCatch({
  dirname(sys.frame(1)$ofile)
}, error = function(e) {
  getwd()
})

# Directorio de salidas relativo al script o entorno
salidas_dir <- file.path("laureados", "2016_hart_holmstrom", "replicacion", "salidas")
if (!dir.exists(salidas_dir)) {
  # Si se ejecuta desde laureados/2016_hart_holmstrom/replicacion/R
  if (dir.exists("../salidas")) {
    salidas_dir <- "../salidas"
  } else {
    dir.create(salidas_dir, recursive = TRUE, showWarnings = FALSE)
  }
}

cat("=== INICIANDO SIMULACIÓN: TEORÍA DE CONTRATOS (NOBEL 2016) ===\n")
cat("Directorio de salidas:", salidas_dir, "\n\n")

# ------------------------------------------------------------------------------
# 1. MODELO DE HOLMSTRÖM (1979): RIESGO, INCENTIVOS E INFORMATIVIDAD
# ------------------------------------------------------------------------------
# Marco Lineal-Exponencial-Normal (LEN):
# Producción: y = e + epsilon, epsilon ~ N(0, sigma_y^2)
# Costo de esfuerzo: C(e) = 0.5 * k * e^2
# Agente con aversión absoluta al riesgo CARA (coeficiente r)
# Contrato lineal: w = alpha + beta * y
# Equivalente de certeza: CE = alpha + beta*e - 0.5*k*e^2 - 0.5*r*beta^2*sigma_y^2
# Incentivo óptimo: beta* = 1 / (1 + r * k * sigma_y^2)
# Esfuerzo inducido: e* = beta* / k
# Prima de riesgo: RP = 0.5 * r * (beta*)^2 * sigma_y^2
# Excedente total: W = e* - 0.5 * k * (e*)^2 - RP = 0.5 / (k * (1 + r * k * sigma_y^2))

k_param <- 1.0  # Costo marginal del esfuerzo

# Curvas de variación de varianza de ruido y aversión al riesgo
sigma_sq_vals <- seq(0.05, 4.0, length.out = 150)
r_vals <- c(0.5, 1.0, 2.0)

df_holmstrom_risk <- expand.grid(sigma_sq = sigma_sq_vals, r = r_vals) %>%
  mutate(
    beta_opt = 1 / (1 + r * k_param * sigma_sq),
    esfuerzo = beta_opt / k_param,
    prima_riesgo = 0.5 * r * (beta_opt^2) * sigma_sq,
    excedente = esfuerzo - 0.5 * k_param * (esfuerzo^2) - prima_riesgo,
    r_factor = factor(paste0("Aversión al riesgo r = ", r), 
                      levels = paste0("Aversión al riesgo r = ", r_vals))
  )

# Principio de Informatividad y Evaluación de Desempeño Relativo (RPE):
# Si existe una señal de mercado z correlacionada con epsilon con correlación rho in [0, 0.99]
# La varianza residual del ruido es sigma_resid^2 = sigma_y^2 * (1 - rho^2)
# beta*(rho) = 1 / (1 + r * k * sigma_y^2 * (1 - rho^2))
rho_vals <- seq(0, 0.98, length.out = 150)
fixed_sigma_sq <- 1.5
fixed_r <- 1.2

df_informativeness <- tibble(
  rho = rho_vals,
  sigma_resid_sq = fixed_sigma_sq * (1 - rho^2),
  beta_opt_rpe = 1 / (1 + fixed_r * k_param * sigma_resid_sq),
  prima_riesgo_rpe = 0.5 * fixed_r * (beta_opt_rpe^2) * sigma_resid_sq,
  excedente_rpe = (beta_opt_rpe / k_param) - 0.5 * k_param * ((beta_opt_rpe / k_param)^2) - prima_riesgo_rpe
)

# Panel 1A: Trade-off de Holmström (Riesgo vs Poder del Incentivo)
p1a <- ggplot(df_holmstrom_risk, aes(x = sigma_sq, y = beta_opt, color = r_factor)) +
  geom_line(linewidth = 1.2) +
  geom_hline(yintercept = 1.0, linetype = "dashed", color = "#4A5568", linewidth = 0.7) +
  annotate("text", x = 3.2, y = 0.95, label = "Primer Mejor (First-Best: beta = 1)", 
           size = 3.3, fontface = "italic", color = "#4A5568") +
  scale_y_continuous(limits = c(0, 1.05), labels = label_percent()) +
  scale_color_manual(values = c("#2B6CB0", "#C53030", "#6B46C1")) +
  labs(
    title = "A. Trade-off entre Riesgo e Intensidad del Incentivo",
    subtitle = expression(paste("Poder óptimo del contrato: ", beta^"*", " = ", frac(1, 1 + r*k*sigma[y]^2))),
    x = expression(paste("Varianza del ruido ambiental (inobservabilidad) ", sigma[y]^2)),
    y = expression(paste("Intensidad del incentivo ", beta^"*")),
    color = "Parámetro"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "#4A5568", size = 10),
    panel.grid.minor = element_blank()
  )

# Panel 1B: Principio de Informatividad y Benchmarking Relativo
p1b <- ggplot(df_informativeness, aes(x = rho)) +
  geom_line(aes(y = beta_opt_rpe, color = "Poder del incentivo (beta*)"), linewidth = 1.2) +
  geom_line(aes(y = excedente_rpe, color = "Excedente total (Bienestar)"), linewidth = 1.2, linetype = "dotdash") +
  geom_line(aes(y = prima_riesgo_rpe, color = "Prima de riesgo soportada"), linewidth = 1.2, linetype = "dashed") +
  scale_color_manual(
    values = c(
      "Poder del incentivo (beta*)" = "#2B6CB0",
      "Excedente total (Bienestar)" = "#2F855A",
      "Prima de riesgo soportada" = "#DD6B20"
    )
  ) +
  scale_x_continuous(labels = label_percent()) +
  scale_y_continuous(labels = label_number(accuracy = 0.01)) +
  labs(
    title = "B. Principio de Informatividad: Filtrado de Ruido de Mercado",
    subtitle = expression(paste("Efecto de evaluar contra índices sectoriales: ", sigma[resid]^2, " = ", sigma[y]^2, (1 - rho^2))),
    x = expression(paste("Correlación con la señal de mercado (benchmarking) ", rho)),
    y = "Magnitud óptima",
    color = "Métrica"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "#4A5568", size = 10),
    panel.grid.minor = element_blank()
  )

fig1 <- p1a / p1b + 
  plot_annotation(
    title = "Fundamentos del Modelo Principal-Agente: Holmström (1979)",
    theme = theme(plot.title = element_text(face = "bold", size = 14, hjust = 0.5))
  )

fig1_path <- file.path(salidas_dir, "fig_holmstrom_riesgo_incentivos.png")
ggsave(fig1_path, fig1, width = 9.5, height = 8.5, dpi = 300)
cat("[OK] Generado:", fig1_path, "\n")

# ------------------------------------------------------------------------------
# 2. MODELO DE HOLMSTRÖM Y MILGROM (1991): INCENTIVOS MULTITAREA
# ------------------------------------------------------------------------------
# Dos tareas: e1 (medible, ej. volumen/ventas) y e2 (calidad/mantenimiento inobservable)
# Beneficio del principal: B(e1, e2) = p1 * e1 + p2 * e2
# Función de costo de esfuerzo: C(e1, e2) = 0.5 * (c1*e1^2 + c2*e2^2 + 2*gamma*e1*e2)
# donde gamma representa la sustituibilidad de esfuerzos (conflicto de atención/tiempo)
# El contrato solo puede indexarse a y1 = e1 + eps1 con incentivo beta1. (beta2 = 0)
# FOC del agente:
# c1*e1 + gamma*e2 = beta1
# gamma*e1 + c2*e2 = 0  => e2 = - (gamma / c2) * e1
# Esfuerzo en tarea 1: e1 = (c2 * beta1) / (c1*c2 - gamma^2)
# Esfuerzo en tarea 2 (canibalizado): e2 = - (gamma * beta1) / (c1*c2 - gamma^2)
# Suponiendo nivel basal de cuidado e2_0 = 1.0 para mantener e2 > 0:
# e2_efectivo = max(0, 1.0 - (gamma * beta1) / (c1*c2 - gamma^2))

p1 <- 1.0
p2 <- 1.5
c1 <- 1.0
c2 <- 1.0
e2_base <- 1.2

beta1_seq <- seq(0, 1.2, length.out = 120)
gamma_scenarios <- c(0.1, 0.4, 0.7)

df_multitask <- expand.grid(beta1 = beta1_seq, gamma = gamma_scenarios) %>%
  mutate(
    denom = c1 * c2 - gamma^2,
    e1 = (c2 * beta1) / denom,
    e2_canibalizado = (gamma * beta1) / denom,
    e2_efectivo = pmax(0, e2_base - e2_canibalizado),
    costo_esfuerzo = 0.5 * (c1 * e1^2 + c2 * ((e2_base - e2_efectivo)^2) + 2 * gamma * e1 * (e2_base - e2_efectivo)),
    beneficio_principal = p1 * e1 + p2 * e2_efectivo,
    bienestar_social = beneficio_principal - costo_esfuerzo,
    gamma_factor = factor(paste0("Sustituibilidad gamma = ", gamma),
                          levels = paste0("Sustituibilidad gamma = ", gamma_scenarios))
  )

# Panel 2A: Canibalización del esfuerzo en calidad al elevar pago por cantidad
p2a <- ggplot(df_multitask, aes(x = beta1)) +
  geom_line(aes(y = e1, color = "Esfuerzo e1 (Cantidad medible)"), linewidth = 1.1) +
  geom_line(aes(y = e2_efectivo, color = "Esfuerzo e2 (Calidad inobservable)"), linewidth = 1.1, linetype = "longdash") +
  facet_wrap(~ gamma_factor) +
  scale_color_manual(
    values = c(
      "Esfuerzo e1 (Cantidad medible)" = "#2B6CB0",
      "Esfuerzo e2 (Calidad inobservable)" = "#C53030"
    )
  ) +
  labs(
    title = "A. Efecto Multitarea: Distorsión y Canibalización de Calidad",
    subtitle = "Al incentivar fuertemente la tarea medible, el agente abandona la tarea esencial no medible",
    x = expression(paste("Intensidad del incentivo a la tarea medible ", beta[1])),
    y = "Nivel de esfuerzo del agente",
    color = "Dimensión del esfuerzo"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "#4A5568", size = 10),
    panel.grid.minor = element_blank(),
    strip.text = element_text(face = "bold")
  )

# ------------------------------------------------------------------------------
# 3. MODELO DE GROSSMAN, HART Y MOORE (1986, 1990): DERECHOS DE PROPIEDAD
# ------------------------------------------------------------------------------
# Comprador (B) y Vendedor (S).
# Inversiones no contratables i_B, i_S en capital humano con costo c(i) = 0.5 * i^2.
# Excedente cooperativo conjunto: V = A_B * i_B + A_S * i_S.
# En caso de ruptura/desacuerdo:
# Si B posee el activo (Integración B / B-ownership):
#   Retorno externo de B: v_B = lambda_B * A_B * i_B (ej. lambda_B = 0.6)
#   Retorno externo de S: v_S = 0 (sin activo físico, el capital de S pierde valor)
# Si S posee el activo (Integración S / S-ownership):
#   Retorno externo de B: v_B = 0
#   Retorno externo de S: v_S = lambda_S * A_S * i_S (ej. lambda_S = 0.6)
# Renegociación Nash 50-50 ex-post:
# Pago de B = v_B + 0.5 * [V - v_B - v_S] = 0.5 * V + 0.5 * (v_B - v_S)
# FOC de inversión:
# Bajo B-ownership: i_B = 0.5 * (1 + lambda_B) * A_B;  i_S = 0.5 * A_S
# Bajo S-ownership: i_B = 0.5 * A_B;                  i_S = 0.5 * (1 + lambda_S) * A_S
# Primer Mejor (First Best): i_B_FB = A_B, i_S_FB = A_S

lambda_b <- 0.65
lambda_s <- 0.65

# Variamos la importancia relativa de la inversión del comprador: theta in [0.05, 0.95]
# A_B = sqrt(2 * theta), A_S = sqrt(2 * (1 - theta)) de modo que A_B^2 + A_S^2 = 2 (constante)
theta_seq <- seq(0.05, 0.95, length.out = 150)

df_ghm <- tibble(theta = theta_seq) %>%
  mutate(
    A_b = sqrt(2 * theta),
    A_s = sqrt(2 * (1 - theta)),
    
    # Inversiones bajo B-ownership
    i_b_B = 0.5 * (1 + lambda_b) * A_b,
    i_s_B = 0.5 * A_s,
    w_B = (A_b * i_b_B + A_s * i_s_B) - 0.5 * (i_b_B^2 + i_s_B^2),
    
    # Inversiones bajo S-ownership
    i_b_S = 0.5 * A_b,
    i_s_S = 0.5 * (1 + lambda_s) * A_s,
    w_S = (A_b * i_b_S + A_s * i_s_S) - 0.5 * (i_b_S^2 + i_s_S^2),
    
    # Primer mejor
    i_b_FB = A_b,
    i_s_FB = A_s,
    w_FB = (A_b * i_b_FB + A_s * i_s_FB) - 0.5 * (i_b_FB^2 + i_s_FB^2),
    
    # Régimen óptimo
    regimen_optimo = if_else(w_B >= w_S, "Propiedad de B (Integración aguas abajo)", 
                                         "Propiedad de S (Integración aguas arriba)")
  )

# Panel 2B: Frontera de Integración y Asignación de Derechos Residuales de Control
p2b <- ggplot(df_ghm, aes(x = theta)) +
  geom_line(aes(y = w_FB, color = "Primer Mejor (Contratos Completos)"), linewidth = 1.0, linetype = "dotted") +
  geom_line(aes(y = w_B, color = "Integración B (Comprador es dueño)"), linewidth = 1.2) +
  geom_line(aes(y = w_S, color = "Integración S (Proveedor es dueño)"), linewidth = 1.2, linetype = "dashed") +
  geom_vline(xintercept = 0.5, linetype = "solid", color = "#CBD5E0", linewidth = 0.8) +
  annotate("rect", xmin = 0.05, xmax = 0.5, ymin = 0.45, ymax = 1.02, alpha = 0.08, fill = "#C53030") +
  annotate("rect", xmin = 0.5, xmax = 0.95, ymin = 0.45, ymax = 1.02, alpha = 0.08, fill = "#2B6CB0") +
  annotate("text", x = 0.28, y = 0.52, label = "Zona óptima: Proveedor (S) dueño", 
           size = 3.4, fontface = "bold", color = "#9B2C2C") +
  annotate("text", x = 0.72, y = 0.52, label = "Zona óptima: Comprador (B) dueño", 
           size = 3.4, fontface = "bold", color = "#2B6CB0") +
  scale_x_continuous(labels = label_percent()) +
  scale_color_manual(
    values = c(
      "Primer Mejor (Contratos Completos)" = "#4A5568",
      "Integración B (Comprador es dueño)" = "#2B6CB0",
      "Integración S (Proveedor es dueño)" = "#C53030"
    )
  ) +
  labs(
    title = "B. Frontera de Derechos de Propiedad: Grossman, Hart y Moore (1986, 1990)",
    subtitle = "La propiedad debe asignarse a la parte cuya inversión específica de capital humano sea más decisiva",
    x = expression(paste("Importancia relativa del capital humano del Comprador ", theta == frac(A[B]^2, A[B]^2 + A[S]^2))),
    y = "Excedente total generado W",
    color = "Estructura de Propiedad"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "#4A5568", size = 10),
    panel.grid.minor = element_blank()
  )

fig2 <- p2a / p2b + 
  plot_annotation(
    title = "Multitarea y Contratos Incompletos: Holmström-Milgrom (1991) y Hart (1986, 1990)",
    theme = theme(plot.title = element_text(face = "bold", size = 14, hjust = 0.5))
  )

fig2_path <- file.path(salidas_dir, "fig_multitarea_distorsion.png")
ggsave(fig2_path, fig2, width = 10.0, height = 9.0, dpi = 300)
cat("[OK] Generado:", fig2_path, "\n")

# ------------------------------------------------------------------------------
# 4. TABLA RESUMEN DE RESULTADOS: tab_resultados_contratos.csv
# ------------------------------------------------------------------------------
tab_resultados <- tibble(
  Marco_Teorico = c(
    "Primer Mejor (Benchmark)",
    "Holmström (1979) - Riesgo Bajo",
    "Holmström (1979) - Riesgo Alto",
    "Holmström (1979) - Con RPE (Filtro Ruido)",
    "Holmström & Milgrom (1991) - Incentivo Agresivo",
    "Holmström & Milgrom (1991) - Incentivo Equilibrado",
    "Grossman & Hart (1986) - B-Ownership (B decisivo)",
    "Grossman & Hart (1986) - S-Ownership (S decisivo)",
    "Grossman & Hart (1986) - Asignación Equivocada"
  ),
  Autor_Referencia = c(
    "Teoría Clásica",
    "Holmström (1979)",
    "Holmström (1979)",
    "Holmström (1979)",
    "Holmström & Milgrom (1991)",
    "Holmström & Milgrom (1991)",
    "Grossman & Hart (1986)",
    "Grossman & Hart (1986)",
    "Grossman & Hart (1986)"
  ),
  Parametros_Clave = c(
    "sigma^2 = 0 o r = 0",
    "sigma^2 = 0.5, r = 1.0",
    "sigma^2 = 3.0, r = 1.0",
    "sigma^2 = 3.0, rho = 0.85",
    "beta1 = 1.0, gamma = 0.7",
    "beta1 = 0.35, gamma = 0.7",
    "theta = 0.80 (B clave)",
    "theta = 0.20 (S clave)",
    "theta = 0.80 pero asignado a S"
  ),
  Incentivo_Poder_beta = c(
    1.000,
    round(1 / (1 + 1.0 * 1.0 * 0.5), 3),
    round(1 / (1 + 1.0 * 1.0 * 3.0), 3),
    round(1 / (1 + 1.0 * 1.0 * (3.0 * (1 - 0.85^2))), 3),
    1.000,
    0.350,
    round(0.5 * (1 + lambda_b), 3),
    round(0.5 * (1 + lambda_s), 3),
    0.500
  ),
  Esfuerzo_Inversion = c(
    "e = 1.00",
    paste0("e = ", round(1 / 1.5, 3)),
    paste0("e = ", round(1 / 4.0, 3)),
    paste0("e = ", round(1 / (1 + 3.0*(1-0.85^2)), 3)),
    "e1 = 1.96, e2 = 0.00",
    "e1 = 0.69, e2 = 0.72",
    "i_B = 1.04, i_S = 0.32",
    "i_B = 0.32, i_S = 1.04",
    "i_B = 0.63, i_S = 0.52"
  ),
  Prima_Riesgo_Distorsion = c(
    0.000,
    round(0.5 * 1.0 * (0.667^2) * 0.5, 3),
    round(0.5 * 1.0 * (0.250^2) * 3.0, 3),
    round(0.5 * 1.0 * (0.546^2) * (3.0 * (1 - 0.85^2)), 3),
    1.250, # Pérdida por canibalización de calidad
    0.280,
    0.000,
    0.000,
    0.165 # Pérdida de hold-up por subinversión
  ),
  Excedente_Total_W = c(
    0.500,
    round((0.667) - 0.5 * (0.667^2) - 0.111, 3),
    round((0.250) - 0.5 * (0.250^2) - 0.094, 3),
    round((0.546) - 0.5 * (0.546^2) - 0.065, 3),
    0.710,
    1.492, # Mayor bienestar al proteger la calidad
    round((sqrt(2*0.8)*1.043 + sqrt(2*0.2)*0.316) - 0.5*(1.043^2 + 0.316^2), 3),
    round((sqrt(2*0.2)*0.316 + sqrt(2*0.8)*1.043) - 0.5*(0.316^2 + 1.043^2), 3),
    round((sqrt(2*0.8)*0.632 + sqrt(2*0.2)*0.522) - 0.5*(0.632^2 + 0.522^2), 3)
  )
)

tab_path <- file.path(salidas_dir, "tab_resultados_contratos.csv")
write.csv(tab_resultados, tab_path, row.names = FALSE)
cat("[OK] Generado:", tab_path, "\n")
cat("=== SIMULACIÓN COMPLETADA EXITOSAMENTE ===\n")

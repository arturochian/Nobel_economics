# ==============================================================================
# Premio Nobel de Economía 1991: Ronald H. Coase
# Script de Replicación y Simulación:
# 1. Teorema de Coase, Asignación de Derechos y Fricciones de Transacción (1960)
# 2. La Frontera Óptima de la Empresa y los Costos de Organización (1937)
# ==============================================================================

# Paquetes requeridos
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(readr)
  library(patchwork)
  library(scales)
})

# Directorio de salida
salidas_dir <- file.path("laureados", "1991_coase", "replicacion", "salidas")
if (!dir.exists(salidas_dir)) {
  dir.create(salidas_dir, recursive = TRUE)
}

# Configuración de tema gráfico reproducible y estético
tema_nobel <- theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 13, color = "#1a252f"),
    plot.subtitle = element_text(size = 10, color = "#566573", margin = margin(b = 10)),
    plot.caption = element_text(size = 8, color = "#7f8c8d", hjust = 0),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#eaeded"),
    axis.title = element_text(face = "bold", size = 10, color = "#2c3e50"),
    axis.text = element_text(color = "#34495e"),
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 9)
  )

# ==============================================================================
# PARTE 1: MODELO DE EXTERNALIDADES Y NEGOCIACIÓN COASEANA (Coase, 1960)
# ==============================================================================
# Supongamos una fábrica/confitero (emisor) que genera ruido/emisiones Q,
# perjudicando a un vecino/médico (receptor).
# Beneficio privado del emisor: B(Q) = p_0 * Q - 0.5 * b * Q^2
# Beneficio marginal privado: MB(Q) = p_0 - b * Q
# Daño total al receptor: D(Q) = 0.5 * c * Q^2
# Daño marginal al receptor: MD(Q) = c * Q
#
# Parámetros base:
p0 <- 120    # Beneficio marginal inicial
b  <- 1.2    # Pendiente del beneficio marginal
c  <- 0.8    # Pendiente del daño marginal

# Puntos analíticos de referencia:
# 1. Óptimo social (primer mejor): MB(Q*) = MD(Q*)
#    p0 - b*Q* = c*Q* => Q* = p0 / (b + c)
Q_opt <- p0 / (b + c) # 120 / (1.2 + 0.8) = 60 unidades

# 2. Sin negociación y derecho a favor del emisor (permiso de contaminar):
#    MB(Q_priv) = 0 => Q_priv = p0 / b
Q_priv <- p0 / b # 120 / 1.2 = 100 unidades

# 3. Sin negociación y derecho a favor del receptor (derecho a silencio/aire puro):
#    Q_rec = 0 unidades

# Funciones de bienestar
calc_B <- function(Q) p0 * Q - 0.5 * b * Q^2
calc_D <- function(Q) 0.5 * c * Q^2
calc_W <- function(Q) calc_B(Q) - calc_D(Q) # Excedente social neto

W_opt  <- calc_W(Q_opt)   # Bienestar social máximo: B(60) - D(60) = 5040 - 1440 = 3600
W_priv <- calc_W(Q_priv)  # Con Q=100: B(100) - D(100) = 6000 - 4000 = 2000
W_rec  <- calc_W(0)       # Con Q=0: 0

# Ganancia bruta del acuerdo eficiente:
# Si el derecho inicial es del emisor (de Q=100 a Q*=60):
delta_W_emisor <- W_opt - W_priv # 3600 - 2000 = 1600
# Si el derecho inicial es del receptor (de Q=0 a Q*=60):
delta_W_receptor <- W_opt - W_rec # 3600 - 0 = 3600

cat("--- Resultados Analíticos de Coase (1960) ---\n")
cat("Nivel óptimo social (Q*):", Q_opt, "\n")
cat("Nivel emisor unilateral (Q_priv):", Q_priv, "\n")
cat("Excedente máximo (W*):", W_opt, "\n")
cat("Excedente emisor unilateral:", W_priv, " (Pérdida social =", W_opt - W_priv, ")\n")
cat("Excedente receptor unilateral:", W_rec, " (Pérdida social =", W_opt - W_rec, ")\n")
cat("Ganancia potencial de negociar (Derecho al Emisor):", delta_W_emisor, "\n")
cat("Ganancia potencial de negociar (Derecho al Receptor):", delta_W_receptor, "\n\n")

# Gráfica 1A: Curvas de Beneficio Marginal y Daño Marginal
df_q <- data.frame(Q = seq(0, 100, length.out = 400)) %>%
  mutate(
    MB = pmax(0, p0 - b * Q),
    MD = c * Q
  )

p_coase_curvas <- ggplot(df_q, aes(x = Q)) +
  # Áreas sombreadas
  geom_ribbon(
    data = filter(df_q, Q >= Q_opt, Q <= Q_priv),
    aes(ymin = MB, ymax = MD),
    fill = "#e74c3c", alpha = 0.25
  ) +
  geom_ribbon(
    data = filter(df_q, Q <= Q_opt),
    aes(ymin = MD, ymax = MB),
    fill = "#27ae60", alpha = 0.20
  ) +
  geom_line(aes(y = MB, color = "Beneficio Marginal Privado (MB)"), linewidth = 1.2) +
  geom_line(aes(y = MD, color = "Daño Marginal Externo (MD)"), linewidth = 1.2) +
  geom_vline(xintercept = Q_opt, linetype = "dashed", color = "#2c3e50", linewidth = 0.8) +
  geom_vline(xintercept = Q_priv, linetype = "dotted", color = "#c0392b", linewidth = 0.8) +
  annotate("point", x = Q_opt, y = c * Q_opt, size = 3.5, color = "#2c3e50") +
  annotate(
    "text", x = Q_opt, y = c * Q_opt + 10,
    label = paste0("Óptimo Social (Q* = ", Q_opt, ")"),
    fontface = "bold", size = 3.5, hjust = 0.5
  ) +
  annotate(
    "text", x = 30, y = 35,
    label = paste0("Excedente Social Máximo\n(W* = ", W_opt, ")"),
    color = "#1e8449", size = 3.3, fontface = "bold"
  ) +
  annotate(
    "text", x = 80, y = 40,
    label = paste0("Pérdida por exceso\nsin acuerdo (DWL = ", delta_W_emisor, ")"),
    color = "#922b21", size = 3.3, fontface = "italic"
  ) +
  scale_color_manual(
    name = "Curvas Marginales:",
    values = c(
      "Beneficio Marginal Privado (MB)" = "#2980b9",
      "Daño Marginal Externo (MD)" = "#e67e22"
    )
  ) +
  labs(
    title = "A. Equilibrio Coaseano y Óptimo Social",
    subtitle = "Intersección entre el Beneficio Marginal Privado del emisor y el Daño Marginal Externo",
    x = "Nivel de Actividad / Emisión (Q)",
    y = "Valor Marginal Monetario ($)"
  ) +
  scale_x_continuous(breaks = seq(0, 100, 20), limits = c(0, 102)) +
  scale_y_continuous(breaks = seq(0, 120, 20), limits = c(0, 125)) +
  tema_nobel

# Gráfica 1B: Teorema de Coase con Costos de Transacción (Fricciones)
T_valores <- seq(0, 4500, by = 25)

df_transaccion <- data.frame(T_cost = T_valores) %>%
  mutate(
    W_neto_emisor = if_else(T_cost < delta_W_emisor, W_opt - T_cost, W_priv),
    W_neto_receptor = if_else(T_cost < delta_W_receptor, W_opt - T_cost, W_rec)
  )

df_long_t <- df_transaccion %>%
  select(T_cost, W_neto_emisor, W_neto_receptor) %>%
  pivot_longer(
    cols = c(W_neto_emisor, W_neto_receptor),
    names_to = "Regimen_Legal",
    values_to = "Bienestar_Neto"
  ) %>%
  mutate(
    Regimen_Etiqueta = if_else(
      Regimen_Legal == "W_neto_emisor",
      "Régimen A: Derecho al Emisor (Fábrica/Confitero)",
      "Régimen B: Derecho al Receptor (Vecino/Médico)"
    )
  )

p_coase_friccion <- ggplot(df_long_t, aes(x = T_cost, y = Bienestar_Neto, color = Regimen_Etiqueta)) +
  geom_line(linewidth = 1.3) +
  geom_vline(xintercept = delta_W_emisor, linetype = "dashed", color = "#c0392b", alpha = 0.7) +
  geom_vline(xintercept = delta_W_receptor, linetype = "dashed", color = "#2980b9", alpha = 0.7) +
  annotate(
    "text", x = 100, y = 3750,
    label = "Teorema de Coase:\nSi T = 0, W = 3,600 (Indiferencia Legal)",
    hjust = 0, size = 3.3, fontface = "bold", color = "#1e8449"
  ) +
  annotate(
    "text", x = delta_W_emisor + 50, y = 2200,
    label = paste0("Colapso Régimen A\n(T = ", delta_W_emisor, ")"),
    hjust = 0, size = 3, color = "#922b21"
  ) +
  annotate(
    "text", x = delta_W_receptor + 50, y = 500,
    label = paste0("Colapso Régimen B\n(T = ", delta_W_receptor, ")"),
    hjust = 0, size = 3, color = "#2471a3"
  ) +
  scale_color_manual(
    name = "Estructura de Derechos Legales:",
    values = c(
      "Régimen A: Derecho al Emisor (Fábrica/Confitero)" = "#e74c3c",
      "Régimen B: Derecho al Receptor (Vecino/Médico)" = "#3498db"
    )
  ) +
  labs(
    title = "B. Sensibilidad del Excedente a los Costos de Transacción",
    subtitle = "En presencia de fricciones (T > 0), la asignación inicial de derechos determina la eficiencia",
    x = "Costos de Transacción del Acuerdo (T en $)",
    y = "Bienestar Social Neto ($)",
    caption = "Fuente: Modelo cuantitativo basado en Coase (1960). Visualización Nobel_economics."
  ) +
  scale_x_continuous(labels = dollar_format(prefix = "$"), breaks = seq(0, 4500, 1000)) +
  scale_y_continuous(labels = dollar_format(prefix = "$"), breaks = seq(0, 4000, 1000)) +
  tema_nobel

# Combinar ambas figuras con patchwork
fig_negociacion <- p_coase_curvas / p_coase_friccion +
  plot_annotation(
    title = "El Teorema de Coase: Externalidades, Negociación y Fricciones Contractuales",
    subtitle = "Replicación analítica de 'The Problem of Social Cost' (Coase, 1960)",
    theme = theme(
      plot.title = element_text(face = "bold", size = 15, color = "#1a252f"),
      plot.subtitle = element_text(size = 11, color = "#566573")
    )
  )

ggsave(
  filename = file.path(salidas_dir, "fig_coase_negociacion_externalidad.png"),
  plot = fig_negociacion,
  width = 10, height = 11, dpi = 300
)

# ==============================================================================
# PARTE 2: LA NATURALEZA Y FRONTERA DE LA EMPRESA (Coase, 1937)
# ==============================================================================
# Coase (1937) postuló que una empresa organiza transacciones internamente
# hasta el punto donde el costo de organizar una transacción adicional dentro
# de la empresa iguala al costo de realizarla en el mercado abierto.
#
# Definición matemática:
# N = escala operativa / volumen de transacciones internas coordinadas
# MC_m(N) = m0 + m1 * N (costo marginal de acudir al mercado abierto)
# MC_f(N) = g0 + g1 * N (costo marginal de organización jerárquica interna)

N_seq <- seq(1, 100, length.out = 300)

# Escenario Base (Economía Tradicional)
m0_base <- 70; m1_base <- 0.20
g0_base <- 20; g1_base <- 0.90

# Escenario 1: Plataformas Digitales (reducción de costos de búsqueda e intermediación)
m0_digital <- 35; m1_digital <- 0.15

# Escenario 2: IA y software de control de gestión
g0_ia <- 15; g1_ia <- 0.50

df_empresa <- data.frame(N = N_seq) %>%
  mutate(
    MC_mercado_base    = m0_base + m1_base * N,
    MC_firma_base      = g0_base + g1_base * N,
    MC_mercado_digital = m0_digital + m1_digital * N
  )

N_star_base <- (m0_base - g0_base) / (g1_base - m1_base)       # 71.4
N_star_digital <- (m0_digital - g0_base) / (g1_base - m1_digital) # 20.0
N_star_ia <- (m0_base - g0_ia) / (g1_ia - m1_base)             # 183.3

cat("--- Resultados de Frontera de la Empresa (Coase, 1937) ---\n")
cat("Frontera Óptima Base (N*_base):", round(N_star_base, 1), "transacciones internas\n")
cat("Frontera Óptima Digital (N*_digital):", round(N_star_digital, 1), "(Desintegración vertical / Outsourcing)\n")
cat("Frontera Óptima IA (N*_ia):", round(N_star_ia, 1), "(Mayor concentración empresarial)\n\n")

# Gráfico de Frontera de la Empresa
y_star_base <- g0_base + g1_base * N_star_base
y_star_digital <- g0_base + g1_base * N_star_digital

p_frontera <- ggplot(df_empresa, aes(x = N)) +
  # Áreas sombreadas
  geom_ribbon(
    data = filter(df_empresa, N <= N_star_base),
    aes(ymin = MC_firma_base, ymax = MC_mercado_base),
    fill = "#3498db", alpha = 0.18
  ) +
  geom_ribbon(
    data = filter(df_empresa, N >= N_star_base),
    aes(ymin = MC_mercado_base, ymax = MC_firma_base),
    fill = "#e67e22", alpha = 0.18
  ) +
  # Curvas
  geom_line(aes(y = MC_mercado_base, color = "Costo Marginal de Mercado (MCm) - Base"), linewidth = 1.3) +
  geom_line(aes(y = MC_firma_base, color = "Costo Marginal de Organización Interna (MCf) - Base"), linewidth = 1.3) +
  geom_line(aes(y = MC_mercado_digital, color = "Costo Marginal de Mercado - Plataformas Digitales"), linewidth = 1.2, linetype = "dashed") +
  # Puntos de frontera óptima usando annotate para evitar warnings
  annotate("point", x = N_star_base, y = y_star_base, size = 3.5, color = "#2c3e50") +
  annotate("point", x = N_star_digital, y = y_star_digital, size = 3.5, color = "#8e44ad") +
  # Anotaciones de texto
  annotate(
    "text", x = N_star_base, y = y_star_base + 8,
    label = paste0("Frontera Base\nN* = ", round(N_star_base, 1)),
    fontface = "bold", size = 3.3, color = "#2c3e50"
  ) +
  annotate(
    "text", x = N_star_digital - 2, y = y_star_digital + 10,
    label = paste0("Efecto Plataformas\nN* = ", round(N_star_digital, 1), "\n(Desintegración)"),
    fontface = "bold", size = 3.3, color = "#8e44ad"
  ) +
  annotate(
    "text", x = 32, y = 38,
    label = "Zona de Coordinación Interna\n(Dentro de la Empresa:\nMC_firma < MC_mercado)",
    size = 3.2, fontface = "bold", color = "#1b4f72"
  ) +
  annotate(
    "text", x = 86, y = 80,
    label = "Zona de Transacción Abierta\n(Recurrir al Mercado:\nMC_mercado < MC_firma)",
    size = 3.2, fontface = "bold", color = "#784212"
  ) +
  scale_color_manual(
    name = "Mecanismos de Coordinación:",
    values = c(
      "Costo Marginal de Mercado (MCm) - Base" = "#e74c3c",
      "Costo Marginal de Organización Interna (MCf) - Base" = "#2980b9",
      "Costo Marginal de Mercado - Plataformas Digitales" = "#8e44ad"
    )
  ) +
  labs(
    title = "La Naturaleza de la Empresa: Determinación de la Frontera Óptima",
    subtitle = "Equilibrio marginal entre costos de transacción del mercado y costos de coordinación jerárquica (Coase, 1937)",
    x = "Número de Transacciones Coordinadas Internamente (N)",
    y = "Costo Marginal de Coordinación ($)",
    caption = "Fuente: Modelo coaseano de frontera empresarial. Visualización elaborada por Nobel_economics."
  ) +
  scale_x_continuous(breaks = seq(0, 100, 10), limits = c(0, 100)) +
  scale_y_continuous(breaks = seq(0, 120, 20), limits = c(0, 120)) +
  tema_nobel

ggsave(
  filename = file.path(salidas_dir, "fig_coase_frontera_empresa.png"),
  plot = p_frontera,
  width = 9.5, height = 6.5, dpi = 300
)

# ==============================================================================
# PARTE 3: TABLA RESUMEN DE RESULTADOS Y EXPORTACIÓN A CSV
# ==============================================================================
tab_resultados <- tibble(
  concepto = c(
    "Externalidad: Óptimo Social Q*",
    "Externalidad: Emisión sin Negociación (Derecho Emisor)",
    "Externalidad: Emisión sin Negociación (Derecho Receptor)",
    "Excedente Máximo W*",
    "Excedente Status Quo (Derecho Emisor)",
    "Pérdida de Bienestar DWL (Derecho Emisor sin Negociar)",
    "Ganancia Potencial de Negociación Delta_W (Derecho Emisor)",
    "Ganancia Potencial de Negociación Delta_W (Derecho Receptor)",
    "Frontera Óptima Empresa N* (Economía Base)",
    "Frontera Óptima Empresa N* (Plataformas Digitales)",
    "Frontera Óptima Empresa N* (IA y Software de Gestión)"
  ),
  valor_numerico = c(
    round(Q_opt, 2),
    round(Q_priv, 2),
    0,
    round(W_opt, 2),
    round(W_priv, 2),
    round(W_opt - W_priv, 2),
    round(delta_W_emisor, 2),
    round(delta_W_receptor, 2),
    round(N_star_base, 2),
    round(N_star_digital, 2),
    round(N_star_ia, 2)
  ),
  unidad = c(
    "Unidades de actividad",
    "Unidades de actividad",
    "Unidades de actividad",
    "Dólares ($)",
    "Dólares ($)",
    "Dólares ($)",
    "Dólares ($)",
    "Dólares ($)",
    "Transacciones internas",
    "Transacciones internas",
    "Transacciones internas"
  ),
  interpretacion_coaseana = c(
    "Asignación que maximiza el excedente social neto igualando beneficio y daño marginal.",
    "El emisor satura la actividad hasta que MB=0; genera sobreproducción social e ineficiencia.",
    "Cese total de actividad; genera subproducción social si no hay negociación.",
    "Bienestar total alcanzable con negociación coaseana perfecta libre de fricciones (T=0).",
    "Excedente social residual cuando la fábrica emite sin compensar ni cooperar.",
    "Costo social de la inacción o de costos de transacción prohibitivos que impiden el pacto.",
    "Umbral máximo de fricción de transacción T tolerable para alcanzar el pacto desde el régimen A.",
    "Umbral máximo de fricción de transacción T tolerable para alcanzar el pacto desde el régimen B.",
    "Frontera donde el costo marginal interno iguala el costo marginal del mercado abierto.",
    "Reducción de costos de búsqueda/contratación provoca desintegración y auge de outsourcing.",
    "Mejora en software de control y monitoreo administrativo permite ampliar la jerarquía."
  )
)

write_csv(tab_resultados, file.path(salidas_dir, "tab_resultados_coase.csv"))

cat("Script completado exitosamente sin advertencias. Archivos generados en:", salidas_dir, "\n")

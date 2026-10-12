# ==============================================================================
# modelo_diamond_dybvig.R
# Simulación numérica del modelo Diamond-Dybvig (1983) y el Canal de Crédito
# de Bernanke (1983) / Bernanke & Gertler (1989)
#
# Nobel de Economía 2022: Ben S. Bernanke, Douglas W. Diamond, Philip H. Dybvig
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
})

# Definir rutas relativas seguras
dir_actual <- getwd()
ruta_salidas <- file.path("laureados", "2022_bernanke_diamond_dybvig", "replicacion", "salidas")
if (!dir.exists(ruta_salidas)) {
  # Si se corre desde dentro de la carpeta laureados/...
  if (dir.exists("salidas")) {
    ruta_salidas <- "salidas"
  } else {
    dir.create(ruta_salidas, recursive = TRUE, showWarnings = FALSE)
  }
}

# ------------------------------------------------------------------------------
# 1. PARÁMETROS DEL MODELO DIAMOND-DYBVIG (1983)
# ------------------------------------------------------------------------------
# Tiempos: T = 0 (depósito), T = 1 (retiro temprano), T = 2 (inversión madura)
# Dotación inicial por depositante: 1 unidad
t_prop <- 0.25    # Proporción real de depositantes impacientes (Tipo 1)
R      <- 1.50    # Retorno bruto de la tecnología ilíquida a largo plazo (T=2)
L      <- 1.00    # Valor de liquidación anticipada por unidad en T=1
r1     <- 1.20    # Pago prometido por el banco a retiros en T=1

# Retorno óptimo para pacientes en T=2 cuando solo retiran los impacientes (f = t):
r2_opt <- (R * (1 - t_prop * r1)) / (1 - t_prop)
# Con t=0.25, r1=1.20, R=1.5: r2_opt = 1.5 * (1 - 0.30) / 0.75 = 1.05 / 0.75 = 1.40

# Umbral de agotamiento de reservas del banco: f_bar = 1 / r1
f_bar  <- 1 / r1 # 1 / 1.20 = 0.8333

# Umbral crítico de pánico f*: punto donde V2(f*) = r1
# R*(1 - f* * r1) / (1 - f*) = r1  =>  f* = (R - r1) / (r1 * (R - 1))
f_star <- (R - r1) / (r1 * (R - 1)) # (1.5 - 1.2) / (1.2 * 0.5) = 0.30 / 0.60 = 0.50

cat(sprintf("=== PARÁMETROS DIAMOND-DYBVIG ===\n"))
cat(sprintf("Proporción de impacientes (t): %.2f\n", t_prop))
cat(sprintf("Retorno largo plazo (R): %.2f\n", R))
cat(sprintf("Pago prometido temprano (r1): %.2f\n", r1))
cat(sprintf("Pago esperado óptimo tarde (r2): %.2f\n", r2_opt))
cat(sprintf("Umbral crítico de pánico (f*): %.2f\n", f_star))
cat(sprintf("Agotamiento total de liquidez (f_bar): %.4f\n\n", f_bar))

# ------------------------------------------------------------------------------
# 2. FUNCIONES DE PAGO SEGÚN LA FRACCIÓN DE RETIROS (f)
# ------------------------------------------------------------------------------
simular_pagos <- function(f) {
  # Pago para quien retira en T=1 (V1)
  # Si f <= f_bar, el banco atiende a todos y paga r1.
  # Si f > f_bar, el banco quiebra por liquidación; paga en promedio 1/f
  v1 <- ifelse(f <= f_bar, r1, 1 / f)
  
  # Pago para quien espera a T=2 (V2)
  # Si f <= f_bar, recibe activos remanentes: R * (1 - f * r1) / (1 - f)
  # Si f > f_bar, no queda nada: 0
  v2 <- ifelse(f < f_bar, (R * (1 - f * r1)) / (1 - f), 0)
  v2 <- pmax(0, v2)
  
  # Con Seguro de Depósitos creíble (respaldado por impuestos / prestamista de última instancia)
  # El pago a pacientes está garantizado en r2_opt
  v2_seguro <- rep(r2_opt, length(f))
  
  data.frame(
    f = f,
    V1 = v1,
    V2 = v2,
    V2_seguro = v2_seguro
  )
}

# Grid continuo para gráficos
grid_f <- seq(0.01, 0.99, by = 0.005)
df_curvas <- simular_pagos(grid_f)

# ------------------------------------------------------------------------------
# 3. TABLA RESUMEN DE PAGOS Y LIQUIDEZ (tab_pagos_liquidez.csv)
# ------------------------------------------------------------------------------
puntos_clave <- c(0.10, 0.25, 0.35, 0.50, 0.65, round(f_bar, 3), 0.95)
df_tabla <- simular_pagos(puntos_clave)

df_tabla$incentivo_corrida <- ifelse(
  df_tabla$f < df_tabla$f[df_tabla$f == t_prop],
  "Retiro por debajo del óptimo",
  ifelse(
    abs(df_tabla$f - t_prop) < 1e-4,
    "Equilibrio Bueno (sin pánico)",
    ifelse(
      df_tabla$f < f_star,
      "Zona Estable (esperar es óptimo)",
      ifelse(
        abs(df_tabla$f - f_star) < 1e-4,
        "Umbral Crítico de Indiferencia (f*)",
        ifelse(
          df_tabla$f <= f_bar,
          "Pánico Bancario (retirar es óptimo)",
          "Colapso Total y Quiebra Bancaria"
        )
      )
    )
  )
)

df_tabla$estado_banco <- ifelse(
  df_tabla$f <= t_prop,
  "Solvente y Plenamente Líquido",
  ifelse(
    df_tabla$f < f_star,
    "Solvente (estrés moderado de liquidez)",
    ifelse(
      df_tabla$f < f_bar,
      "Vulnerable a corrida sistémica",
      "Liquidación forzosa / Insolvencia"
    )
  )
)

# Renombrar columnas para exportar
tab_export <- data.frame(
  fraccion_retiro_f = round(df_tabla$f, 3),
  pago_esperado_t1  = round(df_tabla$V1, 3),
  pago_esperado_t2  = round(df_tabla$V2, 3),
  pago_con_seguro_t2 = round(df_tabla$V2_seguro, 3),
  incentivo_agente_t2 = df_tabla$incentivo_corrida,
  estado_banco = df_tabla$estado_banco
)

archivo_csv <- file.path(ruta_salidas, "tab_pagos_liquidez.csv")
write.csv(tab_export, archivo_csv, row.names = FALSE)
cat(sprintf("Tabla guardada en: %s\n", archivo_csv))

# ------------------------------------------------------------------------------
# 4. GRÁFICA 1: MODELO DIAMOND-DYBVIG (fig_diamond_dybvig_panico.png)
# ------------------------------------------------------------------------------
p1 <- ggplot(df_curvas, aes(x = f)) +
  # Fondo sombreado de zonas
  annotate("rect", xmin = 0, xmax = f_star, ymin = 0, ymax = 2.0,
           alpha = 0.08, fill = "#2ECC71") +
  annotate("rect", xmin = f_star, xmax = 1.0, ymin = 0, ymax = 2.0,
           alpha = 0.10, fill = "#E74C3C") +
  
  # Líneas de pago
  geom_line(aes(y = V1, color = "Retiro en T=1 (V1)"), linewidth = 1.2) +
  geom_line(aes(y = V2, color = "Espera a T=2 (V2 sin seguro)"), linewidth = 1.3) +
  geom_line(aes(y = V2_seguro, color = "Espera a T=2 (V2 con Seguro de Depósitos)"),
            linewidth = 1.1, linetype = "dashed") +
  
  # Puntos y líneas de referencia
  geom_vline(xintercept = t_prop, linetype = "dotted", color = "#27AE60", linewidth = 0.9) +
  geom_vline(xintercept = f_star, linetype = "longdash", color = "#C0392B", linewidth = 0.9) +
  geom_vline(xintercept = f_bar, linetype = "dotdash", color = "#7F8C8D", linewidth = 0.7) +
  
  # Etiquetas de puntos críticos
  annotate("point", x = t_prop, y = r2_opt, size = 3.5, color = "#27AE60") +
  annotate("text", x = t_prop + 0.02, y = r2_opt + 0.09,
           label = "Equilibrio Bueno\n(f = t = 0.25, r2 = 1.40)",
           hjust = 0, size = 3.5, fontface = "bold", color = "#1E8449") +
  
  annotate("point", x = f_star, y = r1, size = 3.5, color = "#C0392B") +
  annotate("text", x = f_star + 0.02, y = r1 + 0.12,
           label = "Umbral Crítico f* = 0.50\n(V2 = V1 = 1.20)",
           hjust = 0, size = 3.5, fontface = "bold", color = "#922B21") +
  
  annotate("text", x = 0.15, y = 0.25, label = "ZONA ESTABLE\n(V2 > V1: No correr)",
           color = "#196F3D", fontface = "bold", size = 3.5) +
  annotate("text", x = 0.72, y = 0.25, label = "ZONA DE PÁNICO\n(V1 > V2: Corrida autoverificable)",
           color = "#943126", fontface = "bold", size = 3.5) +
  
  scale_color_manual(
    name = "Estrategia / Régimen",
    values = c(
      "Retiro en T=1 (V1)" = "#E67E22",
      "Espera a T=2 (V2 sin seguro)" = "#2980B9",
      "Espera a T=2 (V2 con Seguro de Depósitos)" = "#27AE60"
    )
  ) +
  scale_x_continuous(breaks = seq(0, 1, 0.1), limits = c(0, 1)) +
  scale_y_continuous(breaks = seq(0, 2.0, 0.2), limits = c(0, 2.0)) +
  labs(
    title = "Modelo Diamond-Dybvig (1983): Equilibrios Múltiples y Seguro de Depósitos",
    subtitle = "Pagos esperados según la fracción f de depositantes que retiran en T=1",
    x = "Fracción de depositantes que retiran en T=1 (f)",
    y = "Pago esperado por unidad depositada",
    caption = "Fuente: Simulación basada en Diamond & Dybvig (1983). Parámetros: t = 0.25, R = 1.5, r1 = 1.20."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13),
    plot.subtitle = element_text(color = "#555555", size = 10),
    legend.position = "bottom",
    legend.box = "horizontal",
    panel.grid.minor = element_blank()
  )

archivo_fig1 <- file.path(ruta_salidas, "fig_diamond_dybvig_panico.png")
ggsave(archivo_fig1, plot = p1, width = 9.5, height = 6.2, dpi = 300)
cat(sprintf("Gráfico 1 guardado en: %s\n", archivo_fig1))

# ------------------------------------------------------------------------------
# 5. GRÁFICA 2: EL CANAL DE CRÉDITO Y ACELERADOR FINANCIERO DE BERNANKE (1983, 1989)
# ------------------------------------------------------------------------------
# Simulación del Costo de Intermediación Crediticia (CCI) y la Prima de Financiamiento Externo (EFP)
# en función del capital bancario / patrimonio neto de los prestatarios (N)
net_worth <- seq(0.05, 1.20, by = 0.01)

# EFP (Prima de Financiamiento Externo) = c / (N^alpha)
alpha_efp <- 0.8
mu_cost   <- 0.15
efp_spread <- mu_cost / (net_worth^alpha_efp) # Puntos porcentuales de prima sobre tasa libre de riesgo

# Volumen de Crédito Bancario agregado L(N): colapso no lineal por pérdida de capital y solvencia
L_max <- 100
credito_bancario <- L_max / (1 + exp(-6 * (net_worth - 0.45)))

df_bernanke <- data.frame(
  net_worth = rep(net_worth, 2),
  valor = c(efp_spread * 100, credito_bancario), # EFP en puntos base / Credito en indice base 100
  variable = rep(c("Prima de Financiamiento Externo (EFP, pb)",
                   "Volumen de Crédito Intermediado (Índice = 100)"), each = length(net_worth))
)

p2 <- ggplot(df_bernanke, aes(x = net_worth, y = valor, color = variable)) +
  geom_line(linewidth = 1.3) +
  facet_wrap(~variable, scales = "free_y", ncol = 2) +
  geom_vline(xintercept = 0.35, linetype = "dashed", color = "#C0392B", linewidth = 0.8) +
  annotate("text", x = 0.38, y = Inf, label = "Umbral de Crisis Sistémica\n(Destrucción de Capital)",
           hjust = 0, vjust = 1.5, size = 3.2, color = "#922B21", fontface = "bold") +
  scale_color_manual(values = c("Prima de Financiamiento Externo (EFP, pb)" = "#C0392B",
                                "Volumen de Crédito Intermediado (Índice = 100)" = "#2980B9")) +
  labs(
    title = "Mecanismo del Canal de Crédito de Bernanke (1983) y Bernanke & Gertler (1989)",
    subtitle = "Impacto del deterioro del patrimonio neto bancario sobre costos de intermediación y oferta de crédito",
    x = "Patrimonio Neto / Capital Bancario (N)",
    y = "Nivel / Puntos base",
    caption = "Fuente: Calibración ilustrativa del acelerador financiero y fricciones de intermediación no monetarias."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13),
    plot.subtitle = element_text(color = "#555555", size = 10),
    legend.position = "none",
    strip.text = element_text(face = "bold", size = 11),
    panel.grid.minor = element_blank()
  )

archivo_fig2 <- file.path(ruta_salidas, "fig_canal_credito_bernanke.png")
ggsave(archivo_fig2, plot = p2, width = 10.0, height = 5.5, dpi = 300)
cat(sprintf("Gráfico 2 guardado en: %s\n", archivo_fig2))

cat("Simulación completada con éxito.\n")

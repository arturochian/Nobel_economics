# ==============================================================================
# SIMULACIÓN CONDUCTUAL: RICHARD H. THALER (PREMIO NOBEL DE ECONOMÍA 2017)
# ------------------------------------------------------------------------------
# Tema: Arquitectura de las Decisiones, Efecto Dotación y "Save More Tomorrow"
# Referencias:
#   - Thaler & Benartzi (2004), JPE: Save More Tomorrow (SMarT)
#   - Kahneman, Knetsch & Thaler (1990), JPE: Endowment Effect & Coase Theorem
#   - Thaler (1980, 1985): Contabilidad Mental y Teoría Positiva de la Elección
# ==============================================================================

# 1. Configuración y Paquetes --------------------------------------------------
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(readr)
})

# Fijar semilla para reproducibilidad
set.seed(2017)

# Definir rutas relativas de salida
dir_salidas <- "salidas"
if (!dir.exists(dir_salidas)) {
  # Si se ejecuta desde laureados/2017_thaler/replicacion/R/
  if (dir.exists("../salidas")) {
    dir_salidas <- "../salidas"
  } else {
    dir.create(dir_salidas, recursive = TRUE, showWarnings = FALSE)
  }
}

# Paleta editorial sobria
color_smart    <- "#1b7837" # Verde SMarT (ahorro creciente)
color_trad     <- "#4575b4" # Azul asesoría tradicional
color_control  <- "#d73027" # Rojo inercia / status quo
color_coase    <- "#762a83" # Púrpura benchmark Coase

# ==============================================================================
# PARTE 1: DINÁMICA DEL PROGRAMA "SAVE MORE TOMORROW" (Thaler & Benartzi, 2004)
# ==============================================================================
# El modelo simula la evolución de las tasas de ahorro (%) en planes de pensiones
# 401(k) a lo largo de 4 aumentos salariales anuales bajo tres grupos:
#   1. Status Quo / Sin Aceptación: Inercia pura, opt-in tradicional (~3.5%)
#   2. Asesoría Tradicional: Aumento voluntario inmediato en t=0, luego inercia (~4.4%)
#   3. Programa SMarT: Compromiso de aportar fracción de futuros aumentos de sueldo,
#      neutralizando la aversión a la pérdida y apalancando la inercia (3.5% -> 13.6%)

periodos <- c("Línea Base", "Aumento 1", "Aumento 2", "Aumento 3", "Aumento 4")
n_periodos <- length(periodos)

# Calibración basada empíricamente en la primera implementación real de SMarT
# (Thaler & Benartzi, 2004, Tabla 1: Empresa Manufacturera, N=286 participantes)
df_smart_sim <- tibble(
  periodo = rep(periodos, times = 3),
  tiempo  = rep(0:4, times = 3),
  grupo   = rep(c("Status Quo (Inercia sin plan)", 
                  "Ahorro Inmediato (Asesoría estándar)", 
                  "Programa SMarT (Thaler & Benartzi)"), 
                each = n_periodos),
  tasa_ahorro = c(
    # Status Quo: inercia permanente en tasa base
    3.5, 3.5, 3.5, 3.5, 3.5,
    # Asesoría Inmediata: salto inicial discreto, congelamiento por inercia
    3.5, 4.4, 4.4, 4.4, 4.4,
    # Save More Tomorrow: escalamiento automático sincronizado con aumentos
    3.5, 6.5, 9.4, 11.6, 13.6
  )
)

df_smart_sim$periodo <- factor(df_smart_sim$periodo, levels = periodos)
df_smart_sim$grupo   <- factor(df_smart_sim$grupo, levels = c(
  "Programa SMarT (Thaler & Benartzi)",
  "Ahorro Inmediato (Asesoría estándar)",
  "Status Quo (Inercia sin plan)"
))

# Gráfico 1: Evolución de la Tasa de Contribución al Retiro
p1 <- ggplot(df_smart_sim, aes(x = tiempo, y = tasa_ahorro, color = grupo, group = grupo)) +
  geom_line(linewidth = 1.3) +
  geom_point(size = 3.5) +
  scale_color_manual(values = c(
    "Programa SMarT (Thaler & Benartzi)"   = color_smart,
    "Ahorro Inmediato (Asesoría estándar)" = color_trad,
    "Status Quo (Inercia sin plan)"       = color_control
  )) +
  scale_x_continuous(breaks = 0:4, labels = periodos) +
  scale_y_continuous(breaks = seq(2, 16, by = 2), limits = c(2, 16), labels = function(x) paste0(x, "%")) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#222222"),
    plot.subtitle = element_text(size = 11, color = "#555555", margin = margin(b = 15)),
    axis.title.x = element_blank(),
    axis.title.y = element_text(face = "bold", size = 11, margin = margin(r = 10)),
    legend.position = "bottom",
    legend.title = element_blank(),
    legend.text = element_text(size = 10),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "#fdfdfd", color = NA),
    panel.background = element_rect(fill = "#fdfdfd", color = NA)
  ) +
  labs(
    title = "Efecto del Programa 'Save More Tomorrow' (SMarT) sobre el Ahorro para el Retiro",
    subtitle = "Replicación ilustrativa basada en Thaler & Benartzi (2004): Escalamiento automático con incrementos salariales",
    y = "Tasa Media de Contribución (% del Salario)"
  ) +
  annotate("text", x = 3.6, y = 14.3, label = "+10.1 pp acumulados\n(Neutraliza aversión a pérdidas)", 
           color = color_smart, fontface = "bold", size = 3.3, hjust = 0.5) +
  annotate("text", x = 3.8, y = 5.2, label = "Inercia neutral", 
           color = color_trad, fontface = "italic", size = 3.2, hjust = 0.5) +
  annotate("text", x = 3.8, y = 2.7, label = "Trampa del default", 
           color = color_control, fontface = "italic", size = 3.2, hjust = 0.5)

ruta_p1 <- file.path(dir_salidas, "fig_ahorro_save_more_tomorrow.png")
ggsave(ruta_p1, p1, width = 9.5, height = 5.8, dpi = 300)
message("Guardado: ", ruta_p1)


# ==============================================================================
# PARTE 2: EXPERIMENTO DE EFECTO DOTACIÓN Y TEOREMA DE COASE (KKT, 1990)
# ==============================================================================
# Kahneman, Knetsch y Thaler (1990) diseñaron experimentos de mercado comparando:
#   1. Tokens (fichas con valor inducido idéntico, mercado neoclásico estándar)
#   2. Bienes reales (tazas de café con posesión física y propiedad legal)
# Predicción neoclásica (Coase): Asignación inicial no afecta volumen final;
# el 50% de los bienes comerciables cambian de manos (WTA = WTP).
# Resultado conductual (Thaler): WTA / WTP ~ 2.0 - 2.5 por aversión a pérdidas;
# el volumen de intercambios colapsa drásticamente (< 50% de lo predicho).

n_participantes <- 200 # 100 vendedores dotados con tazas, 100 compradores con dinero
valor_base <- 5.0      # Valor medio de referencia en USD

# Simulación de valoraciones intrínsecas del bien
v_intrinseco_vendedores <- runif(n_participantes / 2, min = 1.0, max = 9.0)
v_intrinseco_compradores <- runif(n_participantes / 2, min = 1.0, max = 9.0)

# Parámetro de aversión a pérdidas de Tversky & Kahneman (1991) aplicado por Thaler: lambda ~ 2.25
lambda_dotacion <- 2.15 

# En mercado de tokens: WTA = valor inducido, WTP = valor inducido (sin efecto dotación)
wta_tokens <- v_intrinseco_vendedores
wtp_tokens <- v_intrinseco_compradores

# En mercado de tazas: Vendedores exigen compensación por la pérdida (WTA = lambda * v)
wta_tazas <- v_intrinseco_vendedores * lambda_dotacion
wtp_tazas <- v_intrinseco_compradores # Compradores evalúan como adquisición ordinaria

# Calcular transacciones de equilibrio ordenando curvas de oferta y demanda
calcular_equilibrio <- function(wta_vec, wtp_vec) {
  oferta <- sort(wta_vec)
  demanda <- sort(wtp_vec, decreasing = TRUE)
  n <- length(oferta)
  
  # Una transacción ocurre si demanda[i] >= oferta[i]
  transacciones <- sum(demanda >= oferta)
  precio_eq <- if (transacciones > 0) mean(c(oferta[transacciones], demanda[transacciones])) else NA
  
  list(transacciones = transacciones, precio = precio_eq)
}

eq_tokens <- calcular_equilibrio(wta_tokens, wtp_tokens)
eq_tazas  <- calcular_equilibrio(wta_tazas, wtp_tazas)
transacciones_esperadas_coase <- round((n_participantes / 2) / 2) # Coase predice ~ 50 transacciones

# Dataframe de valoraciones para gráficos
df_valoraciones <- tibble(
  tipo = factor(c(rep("Disposición a Aceptar (WTA - Vendedores)", length(wta_tazas)),
                  rep("Disposición a Pagar (WTP - Compradores)", length(wtp_tazas))),
                levels = c("Disposición a Aceptar (WTA - Vendedores)", 
                           "Disposición a Pagar (WTP - Compradores)")),
  precio = c(wta_tazas, wtp_tazas)
)

df_volumen <- tibble(
  mercado = factor(c("Predicción Neoclásica\n(Teorema de Coase)", 
                     "Mercado de Tokens\n(Valores Inducidos)", 
                     "Mercado de Tazas Reales\n(Efecto Dotación)"),
                   levels = c("Predicción Neoclásica\n(Teorema de Coase)", 
                              "Mercado de Tokens\n(Valores Inducidos)", 
                              "Mercado de Tazas Reales\n(Efecto Dotación)")),
  transacciones = c(transacciones_esperadas_coase, eq_tokens$transacciones, eq_tazas$transacciones),
  pct_esperado = c(100, 100 * eq_tokens$transacciones / transacciones_esperadas_coase, 
                   100 * eq_tazas$transacciones / transacciones_esperadas_coase)
)

# Gráfico 2: Efecto Dotación (Panel A: Brecha WTA/WTP; Panel B: Colapso de Transacciones)
p2a <- ggplot(df_valoraciones, aes(x = precio, fill = tipo)) +
  geom_density(alpha = 0.55, color = "black", linewidth = 0.4) +
  scale_fill_manual(values = c(
    "Disposición a Aceptar (WTA - Vendedores)" = "#d95f02",
    "Disposición a Pagar (WTP - Compradores)" = "#7570b3"
  )) +
  geom_vline(xintercept = median(wta_tazas), color = "#d95f02", linetype = "dashed", linewidth = 1) +
  geom_vline(xintercept = median(wtp_tazas), color = "#7570b3", linetype = "dashed", linewidth = 1) +
  annotate("text", x = median(wta_tazas) + 0.3, y = 0.08, 
           label = paste0("Mediana WTA = $", round(median(wta_tazas), 2)), 
           color = "#d95f02", fontface = "bold", size = 3.2, hjust = 0) +
  annotate("text", x = median(wtp_tazas) + 0.3, y = 0.14, 
           label = paste0("Mediana WTP = $", round(median(wtp_tazas), 2)), 
           color = "#7570b3", fontface = "bold", size = 3.2, hjust = 0) +
  annotate("text", x = 11, y = 0.05, 
           label = paste0("Ratio WTA / WTP = ", round(median(wta_tazas) / median(wtp_tazas), 2)), 
           color = "#222222", fontface = "bold", size = 3.8) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    axis.title = element_text(size = 10),
    legend.position = "bottom",
    legend.title = element_blank(),
    legend.text = element_text(size = 9)
  ) +
  labs(
    title = "A. Asimetría Valorativa: Disposición a Aceptar vs. Disposición a Pagar",
    x = "Valoración Monetaria ($ USD)",
    y = "Densidad Empírica"
  )

p2b <- ggplot(df_volumen, aes(x = mercado, y = transacciones, fill = mercado)) +
  geom_col(width = 0.55, color = "black", linewidth = 0.4) +
  geom_text(aes(label = paste0(transacciones, " intercambios\n(", round(pct_esperado, 1), "% del predicho)")), 
            vjust = -0.3, size = 3.3, fontface = "bold") +
  scale_fill_manual(values = c(
    "Predicción Neoclásica\n(Teorema de Coase)" = color_coase,
    "Mercado de Tokens\n(Valores Inducidos)"   = color_trad,
    "Mercado de Tazas Reales\n(Efecto Dotación)" = color_control
  )) +
  scale_y_continuous(limits = c(0, 60), breaks = seq(0, 60, by = 10)) +
  theme_minimal(base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 10),
    legend.position = "none"
  ) +
  labs(
    title = "B. Falla en el Teorema de Coase: Colapso de Transacciones",
    y = "Número de Transacciones de Mercado"
  )

# Composición visual en dos paneles con gridExtra
suppressPackageStartupMessages(library(gridExtra))
p2_combined <- gridExtra::arrangeGrob(p2a, p2b, ncol = 2,
                                     top = grid::textGrob(
                                       "Experimento del Efecto Dotación: Kahneman, Knetsch y Thaler (1990)",
                                       gp = grid::gpar(fontsize = 14, fontface = "bold")
                                     ))

ruta_p2 <- file.path(dir_salidas, "fig_efecto_dotacion_mental.png")
ggsave(ruta_p2, p2_combined, width = 11.5, height = 5.5, dpi = 300)
message("Guardado: ", ruta_p2)


# ==============================================================================
# PARTE 3: TABLA RESUMEN DE RESULTADOS CONDUCTUALES
# ==============================================================================
tab_resultados <- tibble(
  modulo = c(
    rep("Programa Save More Tomorrow (Ahorro 401k)", 3),
    rep("Experimento Efecto Dotación (KKT 1990)", 3)
  ),
  estrategia_o_mercado = c(
    "Programa SMarT (Compromiso escalonado)",
    "Ahorro Inmediato (Asesoría clásica)",
    "Status Quo (Inercia sin cambio)",
    "Benchmark Teorema de Coase",
    "Mercado Tokens (Valor Inducido)",
    "Mercado Tazas (Efecto Dotación)"
  ),
  tasa_inicial_o_wta = c(
    "3.5%", "3.5%", "3.5%",
    "N/A", paste0("$", round(median(wta_tokens), 2)), paste0("$", round(median(wta_tazas), 2))
  ),
  tasa_final_o_wtp = c(
    "13.6%", "4.4%", "3.5%",
    "N/A", paste0("$", round(median(wtp_tokens), 2)), paste0("$", round(median(wtp_tazas), 2))
  ),
  metrica_clave = c(
    "+10.1 pp incremento (x3.9)",
    "+0.9 pp incremento (congelado)",
    "0.0 pp cambio (inercia pura)",
    "Ratio WTA/WTP = 1.00",
    paste0("Ratio WTA/WTP = ", round(median(wta_tokens) / median(wtp_tokens), 2)),
    paste0("Ratio WTA/WTP = ", round(median(wta_tazas) / median(wtp_tazas), 2))
  ),
  transacciones_o_retencion = c(
    "78% retención tras 4 aumentos",
    "18% aceptaron aumento inicial",
    "0% opt-in voluntario",
    paste0(transacciones_esperadas_coase, " transacciones (100%)"),
    paste0(eq_tokens$transacciones, " transacciones (", round(100 * eq_tokens$transacciones / transacciones_esperadas_coase), "%)"),
    paste0(eq_tazas$transacciones, " transacciones (", round(100 * eq_tazas$transacciones / transacciones_esperadas_coase), "%)")
  )
)

ruta_tab <- file.path(dir_salidas, "tab_resultados_conductuales.csv")
write_csv(tab_resultados, ruta_tab)
message("Guardado: ", ruta_tab)

cat("\n=== SIMULACIÓN COMPLETADA EXITOSAMENTE ===\n")
cat("Archivos generados en:", dir_salidas, "\n")

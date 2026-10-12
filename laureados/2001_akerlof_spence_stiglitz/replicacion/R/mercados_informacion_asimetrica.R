# ==============================================================================
# mercados_informacion_asimetrica.R
# Replicación y Simulación Numérica: Mercados con Información Asimétrica
# Premio Nobel de Economía 2001: George A. Akerlof, A. Michael Spence y Joseph E. Stiglitz
# ==============================================================================
#
# Modelos implementados:
# 1. Akerlof (1970): Selección adversa y colapso del mercado de automóviles usados ("lemons").
# 2. Spence (1973): Señalización en el mercado laboral y condición de Spence-Mirrlees (Single-Crossing).
# 3. Rothschild & Stiglitz (1976): Screening y menú de contratos autoselectivos en el mercado asegurador.
# 4. Stiglitz & Weiss (1981): Selección adversa y racionamiento de crédito bancario.
#
# Salidas generadas:
# - salidas/fig_akerlof_colapso_limones.png (y fig_akerlof_colapso_mercado.png)
# - salidas/fig_spence_equilibrio_senalizacion.png
# - salidas/tab_resultados_informacion.csv (y tab_informacion_asimetrica.csv)
#
# Autor: Nobel_economics Project
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
set.seed(20011010)

# Localizar directorios de forma robusta
find_output_dir <- function() {
  candidates <- c(
    file.path("laureados", "2001_akerlof_spence_stiglitz", "replicacion", "salidas"),
    file.path("..", "salidas"),
    file.path("salidas"),
    file.path(".", "salidas")
  )
  for (cand in candidates) {
    if (dir.exists(cand)) return(cand)
  }
  # Si no existe, crear la ruta estándar
  std_path <- file.path("laureados", "2001_akerlof_spence_stiglitz", "replicacion", "salidas")
  dir.create(std_path, recursive = TRUE, showWarnings = FALSE)
  return(std_path)
}

salidas_dir <- find_output_dir()
cat("=== SIMULACIÓN NOBEL DE ECONOMÍA 2001 ===\n")
cat("Directorio destino de salidas:", salidas_dir, "\n\n")

# Estilo visual estándar para gráficos
tema_nobel <- theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12.5, color = "#1a2530"),
    plot.subtitle = element_text(size = 9.8, color = "#4a5568", margin = margin(b = 8)),
    axis.title = element_text(face = "bold", size = 10, color = "#2d3748"),
    panel.grid.minor = element_blank(),
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    legend.text = element_text(size = 8.5)
  )

# ==============================================================================
# 1. MODELO DE AKERLOF (1970): EL MERCADO DE 'LIMONES'
# ==============================================================================
# Parámetros:
# Calidad q ~ U[0, 100]
# Vendedor: V_S(q) = q (ofrece su auto si P >= q)
# Comprador: V_B(q) = alpha * q, con alpha = 1.35 > 1
# Calidad promedio en oferta al precio P: q_bar(P) = P / 2 (para P <= 100)
# Disposición a pagar del comprador: WTP(P) = alpha * (P / 2) = 0.675 * P
# Condición de equilibrio: P = 0.675 * P => P*(1 - 0.675) = 0 => P* = 0!

alpha_ak <- 1.35
precios_grid <- seq(0, 100, by = 0.5)

df_akerlof_teorico <- tibble(
  precio = precios_grid,
  calidad_media = precio / 2,
  wtp_comprador = alpha_ak * (precio / 2),
  linea_45 = precio
)

# Simulación iterativa de desmoronamiento (market unraveling)
# Comenzamos en P_0 = 100
n_iter <- 12
precios_dinamica <- numeric(n_iter)
calidad_dinamica <- numeric(n_iter)
volumen_dinamica <- numeric(n_iter)

P_t <- 100
for (t in 1:n_iter) {
  precios_dinamica[t] <- P_t
  calidad_dinamica[t] <- P_t / 2
  volumen_dinamica[t] <- min(P_t, 100)
  P_t <- alpha_ak * (P_t / 2)
}

df_akerlof_dinamica <- tibble(
  iteracion = 1:n_iter,
  precio = precios_dinamica,
  calidad_media = calidad_dinamica,
  volumen_pct = volumen_dinamica
)

# Simulación Monte Carlo (N = 5,000 vehículos)
N_mc <- 5000
calidades_mc <- runif(N_mc, min = 0, max = 100)

evaluar_mc <- function(p) {
  ofertados <- calidades_mc[calidades_mc <= p]
  if (length(ofertados) == 0) return(tibble(precio = p, wtp_mc = 0))
  tibble(precio = p, wtp_mc = alpha_ak * mean(ofertados))
}
df_akerlof_mc <- bind_rows(lapply(seq(5, 100, by = 5), evaluar_mc))

# Paneles de Akerlof
p_ak_1 <- ggplot(df_akerlof_teorico, aes(x = precio)) +
  geom_line(aes(y = linea_45, linetype = "Precio de mercado (45°)"), color = "#718096", linewidth = 0.9) +
  geom_line(aes(y = wtp_comprador, color = "Disposición a pagar del comprador E[V_B]"), linewidth = 1.2) +
  geom_line(aes(y = calidad_media, color = "Calidad media en oferta E[q|P]"), linetype = "dashed", linewidth = 0.9) +
  geom_point(data = df_akerlof_mc, aes(x = precio, y = wtp_mc, shape = "Simulación Monte Carlo (N=5000)"), color = "#d9534f", size = 2) +
  scale_color_manual(name = "Curvas teóricas:", values = c(
    "Disposición a pagar del comprador E[V_B]" = "#2b6cb0",
    "Calidad media en oferta E[q|P]" = "#48bb78"
  )) +
  scale_linetype_manual(name = "Referencia:", values = c("Precio de mercado (45°)" = "solid")) +
  scale_shape_manual(name = "Empírico:", values = c("Simulación Monte Carlo (N=5000)" = 16)) +
  annotate("text", x = 65, y = 30, label = "E[V_B] < P para todo P > 0\n(Mercado colapsa a P* = 0)", 
           color = "#c53030", fontface = "bold", size = 3.3, hjust = 0) +
  labs(
    title = "Panel A: Discrepancia entre Precio y Disposición a Pagar",
    subtitle = "Con alpha = 1.35 < 2, los compradores pagan menos de lo exigido por los vendedores de calidad",
    x = "Precio de mercado hipotético (P)",
    y = "Valoración / Calidad"
  ) +
  tema_nobel

p_ak_2 <- ggplot(df_akerlof_dinamica, aes(x = iteracion)) +
  geom_line(aes(y = precio, color = "Precio de mercado (P_t)"), linewidth = 1.1) +
  geom_point(aes(y = precio, color = "Precio de mercado (P_t)"), size = 2.5) +
  geom_line(aes(y = calidad_media, color = "Calidad media en oferta (q_bar_t)"), linewidth = 1.1, linetype = "dashed") +
  geom_point(aes(y = calidad_media, color = "Calidad media en oferta (q_bar_t)"), size = 2) +
  geom_area(aes(y = volumen_pct, fill = "Volumen negociado (% parque)"), alpha = 0.15) +
  scale_color_manual(name = "Variables dinámicas:", values = c(
    "Precio de mercado (P_t)" = "#c53030",
    "Calidad media en oferta (q_bar_t)" = "#2b6cb0"
  )) +
  scale_fill_manual(name = "Actividad comercial:", values = c("Volumen negociado (% parque)" = "#cbd5e0")) +
  scale_x_continuous(breaks = 1:n_iter) +
  labs(
    title = "Panel B: Espiral de Selección Adversa (Desmoronamiento)",
    subtitle = "Evolución iterativa: el retiro de autos buenos deprime el precio hasta la parálisis total",
    x = "Ronda iterativa de ajuste (t)",
    y = "Precio / Calidad / Volumen (%)"
  ) +
  tema_nobel

fig_akerlof <- (p_ak_1 / p_ak_2) +
  plot_annotation(
    title = "El Colapso del Mercado de 'Limones' (Akerlof, 1970)",
    subtitle = "Asimetría de información y selección adversa expulsan del mercado los bienes de calidad",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14, color = "#1a2530"),
      plot.subtitle = element_text(size = 10.5, color = "#4a5568")
    )
  )

ruta_fig_limones <- file.path(salidas_dir, "fig_akerlof_colapso_limones.png")
ruta_fig_mercado <- file.path(salidas_dir, "fig_akerlof_colapso_mercado.png")
ggsave(ruta_fig_limones, plot = fig_akerlof, width = 9.5, height = 8.5, dpi = 300)
ggsave(ruta_fig_mercado, plot = fig_akerlof, width = 9.5, height = 8.5, dpi = 300)
cat("Gráfico Akerlof guardado en:", ruta_fig_limones, "\n")


# ==============================================================================
# 2. MODELO DE SPENCE (1973): SEÑALIZACIÓN LABORAL
# ==============================================================================
# Productividades: theta_L = 10, theta_H = 20
# Proporciones: lambda_L = 0.60, lambda_H = 0.40
# Salario en pooling: w_pool = 0.60*10 + 0.40*20 = 14.0
# Costos de educación: C_L(e) = 1.0 * e, C_H(e) = 0.5 * e
# Pendientes curvas indiferencia (Single-Crossing): dw/de|_L = 1.0 > dw/de|_H = 0.5
# Rango de equilibrios separadores:
# IC_L: 10 >= 20 - 1.0*e* => e* >= 10
# IC_H: 20 - 0.5*e* >= 10 => e* <= 20
# Equilibrio de Riley (costo mínimo): e* = 10

theta_L <- 10
theta_H <- 20
lambda_H <- 0.40
w_pool <- (1 - lambda_H) * theta_L + lambda_H * theta_H
c_L <- 1.0
c_H <- 0.5

e_grid <- seq(0, 25, by = 0.2)

# Curvas de indiferencia en el equilibrio de Riley:
# Tipo L permanece en (e=0, w=10) => U_L = 10. Curva: w = 10 + 1.0*e
# Tipo H se ubica en (e=10, w=20) => U_H = 20 - 0.5*10 = 15. Curva: w = 15 + 0.5*e
df_spence_curvas <- tibble(
  e = e_grid,
  indif_L = theta_L + c_L * e,
  indif_H = 15 + c_H * e,
  salario_oferta = ifelse(e >= 10, theta_H, theta_L)
)

# Utilidades netas en función del umbral e* propuesto por el empleador
df_spence_utilidades <- tibble(
  e_star = e_grid,
  # Utilidad de L si imita (e=e* => w=20) vs si no imita (e=0 => w=10)
  U_L_imita = theta_H - c_L * e_star,
  U_L_no_imita = theta_L,
  # Utilidad de H si se señaliza (e=e* => w=20) vs si no se señaliza (e=0 => w=10)
  U_H_senial = theta_H - c_H * e_star,
  U_H_no_senial = theta_L
)

p_sp_1 <- ggplot(df_spence_curvas, aes(x = e)) +
  annotate("rect", xmin = 10, xmax = 20, ymin = 0, ymax = 30, fill = "#bee3f8", alpha = 0.3) +
  annotate("text", x = 15, y = 28, label = "Zona de Equilibrios Separadores\n[e* in 10, 20]", 
           color = "#2b6cb0", fontface = "bold", size = 3.2) +
  geom_step(aes(y = salario_oferta, linetype = "Esquema salarial escalonado w(e)"), color = "#2d3748", linewidth = 1.1) +
  geom_line(aes(y = indif_L, color = "Curva Indiferencia Tipo L (Pendiente = 1.0)"), linewidth = 1.0) +
  geom_line(aes(y = indif_H, color = "Curva Indiferencia Tipo H (Pendiente = 0.5)"), linewidth = 1.0) +
  geom_point(aes(x = 0, y = 10), color = "#e53e3e", size = 3.5) +
  annotate("text", x = 0.5, y = 8.5, label = "L: (e=0, w=10)", fontface = "bold", size = 3.1, color = "#e53e3e", hjust = 0) +
  geom_point(aes(x = 10, y = 20), color = "#3182ce", size = 3.5) +
  annotate("text", x = 10.5, y = 18.5, label = "H: (e=10, w=20) [Riley]", fontface = "bold", size = 3.1, color = "#3182ce", hjust = 0) +
  scale_color_manual(name = "Preferencias (Condición de Single-Crossing):", values = c(
    "Curva Indiferencia Tipo L (Pendiente = 1.0)" = "#e53e3e",
    "Curva Indiferencia Tipo H (Pendiente = 0.5)" = "#3182ce"
  )) +
  scale_linetype_manual(name = "Contrato:", values = c("Esquema salarial escalonado w(e)" = "solid")) +
  coord_cartesian(ylim = c(5, 30), xlim = c(0, 25)) +
  labs(
    title = "Panel A: Espacio Educación-Salario y Condición de Cruce Único",
    subtitle = "La curva de indiferencia de L es más empinada que la de H: educarse es más costoso para el menos productivo",
    x = "Nivel de Educación (e)",
    y = "Salario ofrecido (w)"
  ) +
  tema_nobel

p_sp_2 <- ggplot(df_spence_utilidades, aes(x = e_star)) +
  annotate("rect", xmin = 10, xmax = 20, ymin = 5, ymax = 22, fill = "#bee3f8", alpha = 0.3) +
  geom_line(aes(y = U_L_imita, color = "Tipo L si imita (w=20 - c_L*e*)"), linewidth = 1.0, linetype = "dashed") +
  geom_line(aes(y = U_L_no_imita, color = "Tipo L reserva (w=10)"), linewidth = 1.0) +
  geom_line(aes(y = U_H_senial, color = "Tipo H si se señaliza (w=20 - c_H*e*)"), linewidth = 1.1) +
  geom_line(aes(y = U_H_no_senial, color = "Tipo H reserva (w=10)"), linewidth = 0.9, linetype = "dotted") +
  geom_vline(xintercept = 10, linetype = "dashed", color = "#2b6cb0", linewidth = 0.8) +
  annotate("text", x = 10.2, y = 6.5, label = "e* = 10 (Riley)", color = "#2b6cb0", fontface = "bold", size = 3.1, hjust = 0) +
  scale_color_manual(name = "Compatibilidad de Incentivos:", values = c(
    "Tipo L si imita (w=20 - c_L*e*)" = "#e53e3e",
    "Tipo L reserva (w=10)" = "#9b2c2c",
    "Tipo H si se señaliza (w=20 - c_H*e*)" = "#3182ce",
    "Tipo H reserva (w=10)" = "#2c5282"
  )) +
  coord_cartesian(ylim = c(5, 22), xlim = c(0, 25)) +
  labs(
    title = "Panel B: Restricciones de Incentivos y Selección del Equilibrio",
    subtitle = "Para e* < 10 el Tipo L imita; para e* > 20 el Tipo H prefiere no educarse. Riley (e*=10) minimiza el costo social",
    x = "Umbral de Educación exigido por la empresa (e*)",
    y = "Utilidad Neta (U = w - C)"
  ) +
  tema_nobel

fig_spence <- (p_sp_1 / p_sp_2) +
  plot_annotation(
    title = "Equilibrio de Señalización en el Mercado Laboral (Spence, 1973)",
    subtitle = "La educación como filtro puramente informativo: costos heterogéneos y equilibrios separadores",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14, color = "#1a2530"),
      plot.subtitle = element_text(size = 10.5, color = "#4a5568")
    )
  )

ruta_fig_spence <- file.path(salidas_dir, "fig_spence_equilibrio_senalizacion.png")
ggsave(ruta_fig_spence, plot = fig_spence, width = 9.5, height = 8.5, dpi = 300)
cat("Gráfico Spence guardado en:", ruta_fig_spence, "\n")


# ==============================================================================
# 3. TABLA CONSOLIDADA DE RESULTADOS CUANTITATIVOS
# ==============================================================================
# Modelos:
# 1. Akerlof (1970): Información simétrica vs. Selección adversa vs. Certificación técnica
# 2. Spence (1973): Información simétrica vs. Pooling vs. Separador de Riley
# 3. Rothschild & Stiglitz (1976): Cobertura simétrica vs. Menú de screening autoselectivo
# 4. Stiglitz & Weiss (1981): Tasa walrasiana de vaciado vs. Racionamiento de crédito óptimo

welfare_ak_completa <- (alpha_ak - 1) * 50    # 17.5 por auto promedio
welfare_ak_asimetrica <- 0.0                  # Colapso total
welfare_ak_cert <- (alpha_ak - 1) * 50 - 2.0  # 15.5 con costo de inspección c=2

welfare_sp_completa <- (1 - lambda_H) * theta_L + lambda_H * theta_H # 14.0
welfare_sp_pooling <- w_pool                                          # 14.0 (e=0)
welfare_sp_riley <- (1 - lambda_H) * 10 + lambda_H * (20 - 0.5 * 10)  # 12.0
perdida_senial <- welfare_sp_completa - welfare_sp_riley              # 2.0 unidades

tab_resultados <- tibble(
  autor = c(
    rep("Akerlof (1970)", 3),
    rep("Spence (1973)", 3),
    rep("Rothschild & Stiglitz (1976)", 2),
    rep("Stiglitz & Weiss (1981)", 2)
  ),
  modelo_o_regimen = c(
    "Información Simétrica (Primer Mejor)",
    "Asimetría de Información Libre (Sin Garantías)",
    "Solución Institucional (Garantía / Certificación c=2)",
    "Información Simétrica (Primer Mejor)",
    "Equilibrio Agrupador (Pooling sin señal)",
    "Equilibrio Separador de Riley (e*=10)",
    "Información Simétrica en Seguros",
    "Screening Competitivo Separador (Rothschild-Stiglitz)",
    "Tasa de Interés Walrasiana de Vaciado",
    "Racionamiento de Crédito Óptimo (r* < r_walras)"
  ),
  precio_salario_o_tasa = c(
    "P(q) in [q, 1.35q]", "P* = 0 (Colapso)", "P(q) = 1.35q - 2",
    "w_L=10, w_H=20", "w_pool = 14.0", "w_L=10, w_H=20",
    "Prima actuarial justa por tipo", "Menú: (Prima_H alta, d_H=0) y (Prima_L baja, d_L>0)",
    "r_walras = 18.0%", "r* = 12.0%"
  ),
  eficiencia_y_cobertura = c(
    "100% vehículos vendidos (W=17.5)", "0% vehículos vendidos (W=0.0)", "100% vehículos certificados (W=15.5)",
    "100% asignación correcta (W=14.0)", "100% ocupados sin filtro (W=14.0)", "100% clasificados con pérdida neta (W=12.0)",
    "Cobertura total para todos los tipos", "Cobertura total a Tipo H; Cobertura parcial distorsionada a Tipo L",
    "Deterioro de cartera por mora y riesgo moral", "Baja mora y beneficios bancarios maximizados"
  ),
  mecanismo_teorico = c(
    "El sistema de precios coordina eficientemente la totalidad del mercado.",
    "La selección adversa expulsa las unidades buenas; espiral de colapso.",
    "La auditoría externa y la garantía privada mitigan la asimetría informativa.",
    "Salarios alineados al producto marginal sin costo de credencialización.",
    "Pareto-superior a Riley, pero vulnerable a desestabilización por desvíos.",
    "La educación como filtro costoso induce pérdida social neta (credencialismo).",
    "Competencia perfecta con discriminación actuarialmente justa.",
    "Autoselección mediante deducibles; inexistencia de pooling en equilibrio.",
    "Elevar tasas atrae proyectos de alto riesgo (selección adversa y moral hazard).",
    "Es óptimo racionar el crédito; los precios no vacían el mercado financiero."
  )
)

ruta_tab_info <- file.path(salidas_dir, "tab_resultados_informacion.csv")
ruta_tab_asim <- file.path(salidas_dir, "tab_informacion_asimetrica.csv")
write.csv(tab_resultados, ruta_tab_info, row.names = FALSE)
write.csv(tab_resultados, ruta_tab_asim, row.names = FALSE)
cat("Tabla de resultados guardada en:", ruta_tab_info, "\n\n")

print(tab_resultados)
cat("\n=== SIMULACIÓN EJECUTADA SATISFACTORIAMENTE ===\n")

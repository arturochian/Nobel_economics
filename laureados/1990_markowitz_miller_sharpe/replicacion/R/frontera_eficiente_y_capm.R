# ==============================================================================
# REPLICACION NOBEL DE ECONOMIA 1990:
# HARRY M. MARKOWITZ, MERTON H. MILLER Y WILLIAM F. SHARPE
#
# Fundamentos de la Economia Financiera Moderna:
# 1. Harry Markowitz (1952, 1959): Seleccion de Cartera, Diversificacion del Riesgo
#    Idiosincratico y Frontera Eficiente Media-Varianza.
# 2. William Sharpe (1964, 1966): Modelo de Valoracion de Activos de Capital (CAPM),
#    Linea de Mercado de Capitales (CML), Linea de Mercado de Valores (SML) y Ratio de Sharpe.
# 3. Merton Miller (1958, 1961): Teorema de Modigliani-Miller, Irrelevancia de la
#    Estructura de Capital (Proposicion I y II) y Politica de Dividendos.
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(grid)
})

# ------------------------------------------------------------------------------
# 0. Configuracion de directorios de salida
# ------------------------------------------------------------------------------
obtener_dir_salidas <- function() {
  posibles_dirs <- c(
    file.path("laureados", "1990_markowitz_miller_sharpe", "replicacion", "salidas"),
    file.path("..", "salidas"),
    file.path("salidas"),
    file.path(getwd(), "salidas")
  )
  for (d in posibles_dirs) {
    if (dir.exists(d)) return(normalizePath(d))
  }
  target <- file.path("laureados", "1990_markowitz_miller_sharpe", "replicacion", "salidas")
  dir.create(target, recursive = TRUE, showWarnings = FALSE)
  return(normalizePath(target))
}

dir_salidas <- obtener_dir_salidas()
message("[INFO] Directorio de salidas configurado en: ", dir_salidas)

# Fijar semilla para reproducibilidad estricta
set.seed(19901016)

# ------------------------------------------------------------------------------
# 1. Modelo de Seleccion de Cartera de Harry Markowitz (1952)
# ------------------------------------------------------------------------------

# Definicion de activos representativos de clases de inversion
nombres_activos <- c(
  "Acciones Grandes EE.UU.",
  "Acciones Pequenas EE.UU.",
  "Renta Variable Internacional",
  "Bonos Corporativos",
  "Bonos del Tesoro (Largo Plazo)"
)

# Retornos anuales esperados (mu) y volatilidades (sigma)
mu_activos <- c(0.105, 0.125, 0.090, 0.055, 0.040)
sigma_activos <- c(0.160, 0.220, 0.180, 0.080, 0.060)
n_activos <- length(mu_activos)
names(mu_activos) <- nombres_activos
names(sigma_activos) <- nombres_activos

# Matriz de correlaciones empiricas estilizadas
corr_mat <- matrix(c(
  1.00,  0.75,  0.65,  0.25, -0.10,
  0.75,  1.00,  0.55,  0.30, -0.15,
  0.65,  0.55,  1.00,  0.20, -0.05,
  0.25,  0.30,  0.20,  1.00,  0.60,
 -0.10, -0.15, -0.05,  0.60,  1.00
), nrow = n_activos, byrow = TRUE)
rownames(corr_mat) <- nombres_activos
colnames(corr_mat) <- nombres_activos

# Matriz de covarianzas Sigma = D * Corr * D
D <- diag(sigma_activos)
Sigma <- D %*% corr_mat %*% D
rownames(Sigma) <- nombres_activos
colnames(Sigma) <- nombres_activos

# Tasa libre de riesgo (rf)
rf <- 0.030

# Inversa de la matriz de covarianza
inv_Sigma <- solve(Sigma)
unos <- rep(1, n_activos)

# Constantes analiticas de Merton-Markowitz
A_const <- as.numeric(t(unos) %*% inv_Sigma %*% unos)
B_const <- as.numeric(t(unos) %*% inv_Sigma %*% mu_activos)
C_const <- as.numeric(t(mu_activos) %*% inv_Sigma %*% mu_activos)
Delta_const <- A_const * C_const - B_const^2

message(sprintf("[INFO] Constantes analiticas de Markowitz: A=%.4f, B=%.4f, C=%.4f, Delta=%.4f",
                A_const, B_const, C_const, Delta_const))

# A. Portafolio de Minima Varianza Global (GMVP)
w_gmv <- as.vector(inv_Sigma %*% unos) / A_const
names(w_gmv) <- nombres_activos
mu_gmv <- as.numeric(t(w_gmv) %*% mu_activos)
var_gmv <- 1 / A_const
sigma_gmv <- sqrt(var_gmv)
sr_gmv <- (mu_gmv - rf) / sigma_gmv

message(sprintf("[GMVP] Retorno: %.2f%%, Volatilidad: %.2f%%, Sharpe: %.3f",
                mu_gmv * 100, sigma_gmv * 100, sr_gmv))

# B. Portafolio de Tangencia (Maximo Sharpe / Mercado en CAPM)
z_tan <- as.vector(inv_Sigma %*% (mu_activos - rf * unos))
w_tan <- z_tan / sum(z_tan)
names(w_tan) <- nombres_activos
mu_tan <- as.numeric(t(w_tan) %*% mu_activos)
var_tan <- as.numeric(t(w_tan) %*% Sigma %*% w_tan)
sigma_tan <- sqrt(var_tan)
sr_tan <- (mu_tan - rf) / sigma_tan

message(sprintf("[TANGENCIA] Retorno: %.2f%%, Volatilidad: %.2f%%, Sharpe: %.3f",
                mu_tan * 100, sigma_tan * 100, sr_tan))

# C. Curva de Frontera Eficiente Analitica
mu_seq <- seq(from = 0.02, to = 0.16, length.out = 300)
var_frontier <- (A_const * mu_seq^2 - 2 * B_const * mu_seq + C_const) / Delta_const
sigma_frontier <- sqrt(var_frontier)

df_frontera <- data.frame(
  mu = mu_seq,
  sigma = sigma_frontier,
  eficiente = ifelse(mu_seq >= mu_gmv, "Frontera Eficiente", "Suboptima (Infeiciente)")
)

# Pesos analiticos a lo largo de la frontera eficiente para retorno objetivo mu_target
calcular_pesos_frontera <- function(mu_target) {
  lambda1 <- (C_const - B_const * mu_target) / Delta_const
  lambda2 <- (A_const * mu_target - B_const) / Delta_const
  w <- as.vector(lambda1 * (inv_Sigma %*% unos) + lambda2 * (inv_Sigma %*% mu_activos))
  names(w) <- nombres_activos
  return(w)
}

mu_pesos_seq <- seq(from = mu_gmv, to = 0.14, length.out = 100)
mat_pesos <- t(sapply(mu_pesos_seq, calcular_pesos_frontera))
df_pesos <- data.frame(
  mu = rep(mu_pesos_seq, times = n_activos),
  activo = rep(nombres_activos, each = length(mu_pesos_seq)),
  peso = as.vector(mat_pesos)
)

# D. Simulacion Monte Carlo de 3,500 Carteras Aleatorias
n_sim <- 3500
w_sim <- matrix(runif(n_sim * n_activos, min = 0, max = 1), nrow = n_sim)
w_sim <- w_sim / rowSums(w_sim) # Ponderaciones positivas normalizadas (sin ventas en corto)

mu_sim <- as.vector(w_sim %*% mu_activos)
var_sim <- apply(w_sim, 1, function(w) as.numeric(t(w) %*% Sigma %*% w))
sigma_sim <- sqrt(var_sim)
sr_sim <- (mu_sim - rf) / sigma_sim

df_sim <- data.frame(
  mu = mu_sim,
  sigma = sigma_sim,
  sharpe = sr_sim
)

# E. Linea de Mercado de Capitales (CML)
# mu_cml = rf + sr_tan * sigma
sigma_cml_seq <- seq(0, 0.25, length.out = 100)
mu_cml_seq <- rf + sr_tan * sigma_cml_seq
df_cml <- data.frame(sigma = sigma_cml_seq, mu = mu_cml_seq)

# Data frame de activos individuales
df_activos <- data.frame(
  activo = nombres_activos,
  mu = mu_activos,
  sigma = sigma_activos,
  sharpe = (mu_activos - rf) / sigma_activos
)

# ------------------------------------------------------------------------------
# 2. Generacion de Figura 1: Frontera Eficiente de Markowitz y Asignacion
# ------------------------------------------------------------------------------

p1_a <- ggplot() +
  geom_point(data = df_sim, aes(x = sigma * 100, y = mu * 100, color = sharpe),
             alpha = 0.45, size = 1.2) +
  scale_color_viridis_c(option = "plasma", name = "Ratio de\nSharpe") +
  # Frontera ineficiente
  geom_line(data = subset(df_frontera, eficiente == "Suboptima (Infeiciente)"),
            aes(x = sigma * 100, y = mu * 100),
            color = "gray50", linetype = "dashed", linewidth = 0.9) +
  # Frontera eficiente de Markowitz
  geom_line(data = subset(df_frontera, eficiente == "Frontera Eficiente"),
            aes(x = sigma * 100, y = mu * 100),
            color = "#1b9e77", linewidth = 1.4) +
  # Linea CML de Sharpe
  geom_line(data = df_cml, aes(x = sigma * 100, y = mu * 100),
            color = "#d95f02", linewidth = 1.2, linetype = "dotdash") +
  # Activos individuales
  geom_point(data = df_activos, aes(x = sigma * 100, y = mu * 100),
             color = "black", fill = "#386cb0", shape = 21, size = 3.5, stroke = 1.1) +
  geom_text(data = df_activos, aes(x = sigma * 100, y = mu * 100, label = activo),
            vjust = -0.9, hjust = 0.4, size = 2.8, fontface = "bold", color = "#1a1a1a") +
  # GMVP
  geom_point(aes(x = sigma_gmv * 100, y = mu_gmv * 100),
             color = "black", fill = "#e7298a", shape = 23, size = 4.5, stroke = 1.3) +
  annotate("text", x = sigma_gmv * 100 + 0.3, y = mu_gmv * 100 - 0.5,
           label = "Minima Varianza (GMVP)", size = 3.1, fontface = "bold", color = "#e7298a", hjust = 0) +
  # Portafolio de Tangencia (Mercado)
  geom_point(aes(x = sigma_tan * 100, y = mu_tan * 100),
             color = "black", fill = "#e6ab02", shape = 24, size = 4.8, stroke = 1.3) +
  annotate("text", x = sigma_tan * 100 + 0.3, y = mu_tan * 100 + 0.5,
           label = "Portafolio de Tangencia (Mercado)", size = 3.2, fontface = "bold", color = "#b8860b", hjust = 0) +
  # Activo libre de riesgo
  geom_point(aes(x = 0, y = rf * 100), color = "black", fill = "#d95f02", shape = 22, size = 4) +
  annotate("text", x = 0.6, y = rf * 100 + 0.3,
           label = "Tasa Libre de Riesgo (rf = 3.0%)", size = 3.1, fontface = "bold", color = "#d95f02", hjust = 0) +
  labs(
    title = "A. Seleccion de Cartera de Markowitz (1952) y Linea CML de Sharpe (1964)",
    subtitle = "Frontera eficiente media-varianza analitica, universo simulado y portafolio de tangencia optimo",
    x = "Volatilidad Anualizada (Desviacion Estandar, %)",
    y = "Retorno Esperado Anualizado (%)"
  ) +
  coord_cartesian(xlim = c(0, 26), ylim = c(1, 16)) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 9.5, color = "gray30"),
    legend.position = "right",
    panel.grid.minor = element_blank()
  )

p1_b <- ggplot(df_pesos, aes(x = mu * 100, y = peso * 100, fill = activo)) +
  geom_area(position = "stack", alpha = 0.88, color = "white", linewidth = 0.3) +
  scale_fill_brewer(palette = "Set2", name = "Activo") +
  geom_vline(xintercept = mu_gmv * 100, linetype = "dashed", color = "#e7298a", linewidth = 0.8) +
  annotate("text", x = mu_gmv * 100 + 0.15, y = 85, label = "GMVP",
           color = "#e7298a", fontface = "bold", size = 3.1, hjust = 0) +
  geom_vline(xintercept = mu_tan * 100, linetype = "dotdash", color = "#b8860b", linewidth = 0.8) +
  annotate("text", x = mu_tan * 100 + 0.15, y = 85, label = "Tangencia",
           color = "#b8860b", fontface = "bold", size = 3.1, hjust = 0) +
  labs(
    title = "B. Estructura de Ponderaciones Optimas a lo Largo de la Frontera Eficiente",
    subtitle = "Transicion de ponderaciones analiticas a medida que se incrementa el retorno objetivo",
    x = "Retorno Esperado Objetivo (%)",
    y = "Ponderacion en Cartera (%)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 9.5, color = "gray30"),
    legend.position = "bottom",
    panel.grid.minor = element_blank()
  )

# Guardar figura 1 combinada
ruta_fig1 <- file.path(dir_salidas, "fig_markowitz_frontera_eficiente.png")
png(ruta_fig1, width = 11, height = 12, units = "in", res = 300)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 1, heights = unit(c(1.15, 0.85), "null"))))
print(p1_a, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(p1_b, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
dev.off()
message("[INFO] Figura 1 guardada en: ", ruta_fig1)

# ------------------------------------------------------------------------------
# 3. William Sharpe (1964): CAPM y Security Market Line (SML)
# ------------------------------------------------------------------------------

# Calculo de Betas de los activos respecto al portafolio de tangencia (Mercado M)
# Beta_i = Cov(R_i, R_m) / Var(R_m) = (Sigma %*% w_tan)_i / var_tan
cov_con_mercado <- as.vector(Sigma %*% w_tan)
betas_activos <- cov_con_mercado / var_tan
names(betas_activos) <- nombres_activos

# CAPM: E[R_i] = rf + Beta_i * (E[R_m] - rf)
prima_mercado <- mu_tan - rf
capm_esperado <- rf + betas_activos * prima_mercado
alfas_activos <- mu_activos - capm_esperado # Debe ser 0 en equilibrio

# Adicionamos activos hipoteticos desalineados (fondos activos con Alfa != 0)
df_sml_puntos <- data.frame(
  nombre = c(nombres_activos, "Mercado (Tangencia)", "Activo Libre de Riesgo",
             "Fondo Alfa Positivo (Generador de Valor)", "Fondo Alfa Negativo (Comisiones Altas)"),
  beta = c(betas_activos, 1.0, 0.0, 1.10, 0.85),
  retorno = c(mu_activos, mu_tan, rf, rf + 1.10 * prima_mercado + 0.025, rf + 0.85 * prima_mercado - 0.022),
  tipo = c(rep("Activo del Universo", n_activos), "Mercado", "Libre de Riesgo", "Fondo Desalineado", "Fondo Desalineado"),
  alfa = c(alfas_activos, 0.0, 0.0, 0.025, -0.022)
)

beta_seq <- seq(-0.2, 1.8, length.out = 100)
sml_line <- data.frame(
  beta = beta_seq,
  retorno = rf + beta_seq * prima_mercado
)

p2_a <- ggplot() +
  # Linea SML de Sharpe
  geom_line(data = sml_line, aes(x = beta, y = retorno * 100),
            color = "#005a32", linewidth = 1.3) +
  # Region de subvaluacion (alfa > 0) y sobrevaluacion (alfa < 0)
  annotate("text", x = 0.3, y = 14.5, label = "Region Infravalorada (Alfa > 0)\nOportunidad de Compra / Subvalorada",
           color = "#238b45", fontface = "italic", size = 3.2, hjust = 0) +
  annotate("text", x = 1.2, y = 3.5, label = "Region Sobrevalorada (Alfa < 0)\nRetorno Inferior al Riesgo Sistematico",
           color = "#cb181d", fontface = "italic", size = 3.2, hjust = 0) +
  # Puntos
  geom_point(data = subset(df_sml_puntos, tipo == "Activo del Universo"),
             aes(x = beta, y = retorno * 100),
             color = "black", fill = "#386cb0", shape = 21, size = 3.8, stroke = 1.1) +
  geom_text(data = subset(df_sml_puntos, tipo == "Activo del Universo"),
            aes(x = beta, y = retorno * 100, label = nombre),
            vjust = -0.8, hjust = 0.5, size = 2.7, fontface = "bold", color = "#1a1a1a") +
  # Mercado
  geom_point(data = subset(df_sml_puntos, tipo == "Mercado"),
             aes(x = beta, y = retorno * 100),
             color = "black", fill = "#e6ab02", shape = 24, size = 4.8, stroke = 1.3) +
  geom_text(data = subset(df_sml_puntos, tipo == "Mercado"),
            aes(x = beta, y = retorno * 100, label = "Mercado (Beta = 1.0)"),
            vjust = 1.8, hjust = 0.5, size = 3.1, fontface = "bold", color = "#b8860b") +
  # Activo libre de riesgo
  geom_point(data = subset(df_sml_puntos, tipo == "Libre de Riesgo"),
             aes(x = beta, y = retorno * 100),
             color = "black", fill = "#d95f02", shape = 22, size = 4.2, stroke = 1.1) +
  geom_text(data = subset(df_sml_puntos, tipo == "Libre de Riesgo"),
            aes(x = beta, y = retorno * 100, label = "rf = 3.0% (Beta = 0)"),
            vjust = -0.9, hjust = -0.1, size = 3.0, fontface = "bold", color = "#d95f02") +
  # Fondos desalineados
  geom_point(data = subset(df_sml_puntos, tipo == "Fondo Desalineado"),
             aes(x = beta, y = retorno * 100),
             color = "black", fill = "#e41a1c", shape = 25, size = 4.0, stroke = 1.1) +
  geom_segment(data = subset(df_sml_puntos, alfa > 0),
               aes(x = beta, xend = beta, y = (retorno - alfa) * 100, yend = retorno * 100),
               color = "#238b45", linewidth = 1.0, linetype = "dotted",
               arrow = arrow(length = unit(0.2, "cm"))) +
  annotate("text", x = 1.12, y = (rf + 1.10 * prima_mercado + 0.012) * 100,
           label = "Alfa de Jensen = +2.5%", color = "#238b45", fontface = "bold", size = 2.9, hjust = 0) +
  geom_segment(data = subset(df_sml_puntos, alfa < 0),
               aes(x = beta, xend = beta, y = (retorno - alfa) * 100, yend = retorno * 100),
               color = "#cb181d", linewidth = 1.0, linetype = "dotted",
               arrow = arrow(length = unit(0.2, "cm"))) +
  annotate("text", x = 0.87, y = (rf + 0.85 * prima_mercado - 0.011) * 100,
           label = "Alfa de Jensen = -2.2%", color = "#cb181d", fontface = "bold", size = 2.9, hjust = 0) +
  labs(
    title = "A. Linea de Mercado de Valores (SML) del Modelo CAPM de William Sharpe (1964)",
    subtitle = "Remuneracion exclusiva del riesgo sistematico (Beta): E[Ri] = rf + Beta * (E[Rm] - rf)",
    x = "Riesgo Sistematico: Coeficiente Beta (Beta_i)",
    y = "Retorno Esperado Anualizado (%)"
  ) +
  coord_cartesian(xlim = c(-0.1, 1.7), ylim = c(1, 16)) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 9.5, color = "gray30"),
    panel.grid.minor = element_blank()
  )

# ------------------------------------------------------------------------------
# 4. Merton Miller (1958, 1961): Teorema de Modigliani-Miller (Estructura de Capital)
# ------------------------------------------------------------------------------

# Parametros corporativos de la firma representativa
ebit <- 10.0 # Flujo operativo libre de riesgo de negocio EBIT = $10M anuales
r0 <- 0.10   # Costo del capital no apalancado (costo de activos) = 10%
r_deuda <- 0.05 # Tasa de interes de la deuda libre de quiebra = 5%

# Modigliani-Miller Proposicion I (sin impuestos):
# El valor de la firma es independiente de su estructura de capital: V = EBIT / r0 = $100M constante
v_total <- ebit / r0

# Rango de apalancamiento: Ratio Deuda / Capital Propio (D/E)
de_ratio_seq <- seq(0, 4.0, length.out = 150)
d_val <- (de_ratio_seq / (1 + de_ratio_seq)) * v_total
e_val <- v_total - d_val
l_ratio <- d_val / v_total # D / V

# Modigliani-Miller Proposicion II:
# r_E = r0 + (r0 - r_D) * (D / E)
r_e_mm <- r0 + (r0 - r_deuda) * de_ratio_seq

# Costo Promedio Ponderado de Capital (WACC):
# WACC = (E / V) * r_E + (D / V) * r_D = r0 (constante!)
wacc_mm <- (e_val / v_total) * r_e_mm + (d_val / v_total) * r_deuda

# Caso con impuestos corporativos (Modigliani-Miller 1963 / Escudo Fiscal)
tax_rate <- 0.30
# V_L = V_U + t * D.
# WACC_tax = (E / V_L) * r_E + (D / V_L) * r_D * (1 - tax)
# Para comparacion didactica en el mismo rango D/E
r_e_tax <- r0 + (1 - tax_rate) * (r0 - r_deuda) * de_ratio_seq
wacc_tax <- r0 * (1 - tax_rate * (de_ratio_seq / (1 + de_ratio_seq)))

df_mm <- data.frame(
  de_ratio = de_ratio_seq,
  leverage_dv = l_ratio,
  r_equity = r_e_mm,
  r_debt = rep(r_deuda, length(de_ratio_seq)),
  wacc = wacc_mm,
  wacc_con_impuestos = wacc_tax,
  r_equity_con_impuestos = r_e_tax
)

p2_b <- ggplot(df_mm, aes(x = de_ratio)) +
  # Proposicion II: Costo de equity creciente
  geom_line(aes(y = r_equity * 100, color = "Costo del Capital Propio (r_E, Sin Impuestos)"),
            linewidth = 1.3) +
  # Costo de deuda constante
  geom_line(aes(y = r_debt * 100, color = "Costo de la Deuda (r_D)"),
            linewidth = 1.1, linetype = "dashed") +
  # Proposicion I: WACC estrictamente constante
  geom_line(aes(y = wacc * 100, color = "WACC Sin Impuestos (Constante = r_0 = 10%)"),
            linewidth = 1.4) +
  # Curva con impuestos corporativos (escudo fiscal)
  geom_line(aes(y = wacc_con_impuestos * 100, color = "WACC Con Impuestos (Tasa t = 30%)"),
            linewidth = 1.2, linetype = "dotdash") +
  scale_color_manual(
    name = "Tasa de Rendimiento / Costo",
    values = c(
      "Costo del Capital Propio (r_E, Sin Impuestos)" = "#e41a1c",
      "Costo de la Deuda (r_D)" = "#377eb8",
      "WACC Sin Impuestos (Constante = r_0 = 10%)" = "#4daf4a",
      "WACC Con Impuestos (Tasa t = 30%)" = "#984ea3"
    )
  ) +
  annotate("text", x = 2.5, y = 24.5,
           label = "Proposicion II: r_E = r_0 + (r_0 - r_D) * (D/E)\nEl mayor riesgo financiero encarece el capital propio",
           color = "#e41a1c", fontface = "italic", size = 3.0, hjust = 0) +
  annotate("text", x = 2.2, y = 10.7,
           label = "Proposicion I: El WACC permanece constante e invariable",
           color = "#238b45", fontface = "bold", size = 3.0, hjust = 0) +
  labs(
    title = "B. Teorema de Modigliani-Miller (1958, 1963): Irrelevancia del Apalancamiento",
    subtitle = "El valor corporativo no se crea cambiando el pastel financiero; el costo de equity compensa exactamente la deuda barata",
    x = "Ratio de Apalancamiento Financiero Deuda / Capital Propio (D / E)",
    y = "Costo de Capital / Rendimiento Anualizado (%)"
  ) +
  coord_cartesian(xlim = c(0, 4.0), ylim = c(3, 31)) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 9.5, color = "gray30"),
    legend.position = "bottom",
    panel.grid.minor = element_blank()
  )

# Guardar figura 2 combinada (CAPM + Modigliani-Miller)
ruta_fig2 <- file.path(dir_salidas, "fig_sharpe_capm_sml.png")
png(ruta_fig2, width = 11, height = 12, units = "in", res = 300)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 1, heights = unit(c(1.05, 0.95), "null"))))
print(p2_a, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(p2_b, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
dev.off()
message("[INFO] Figura 2 guardada en: ", ruta_fig2)

# ------------------------------------------------------------------------------
# 5. Generacion de Tabla de Datos Consolidada: tab_resultados_finanzas_1990.csv
# ------------------------------------------------------------------------------

tab_activos <- data.frame(
  Elemento = nombres_activos,
  Categoria = "Activo Individual",
  Retorno_Esperado_Pct = round(mu_activos * 100, 2),
  Volatilidad_Pct = round(sigma_activos * 100, 2),
  Beta_CAPM = round(betas_activos, 3),
  Ratio_Sharpe = round((mu_activos - rf) / sigma_activos, 3),
  Peso_GMVP_Pct = round(w_gmv * 100, 2),
  Peso_Tangencia_Pct = round(w_tan * 100, 2)
)

tab_portafolios <- data.frame(
  Elemento = c("Portafolio Minima Varianza (GMVP)", "Portafolio de Tangencia (Mercado)", "Tasa Libre de Riesgo"),
  Categoria = c("Optimo Markowitz", "Optimo Sharpe (CAPM)", "Referencia Libre de Riesgo"),
  Retorno_Esperado_Pct = round(c(mu_gmv, mu_tan, rf) * 100, 2),
  Volatilidad_Pct = round(c(sigma_gmv, sigma_tan, 0) * 100, 2),
  Beta_CAPM = round(c(as.numeric(t(w_gmv) %*% betas_activos), 1.00, 0.00), 3),
  Ratio_Sharpe = round(c(sr_gmv, sr_tan, NA), 3),
  Peso_GMVP_Pct = c(100.0, NA, NA),
  Peso_Tangencia_Pct = c(NA, 100.0, NA)
)

tab_consolidada <- rbind(tab_activos, tab_portafolios)
ruta_csv <- file.path(dir_salidas, "tab_resultados_finanzas_1990.csv")
write.csv(tab_consolidada, file = ruta_csv, row.names = FALSE)
message("[INFO] Tabla de resultados guardada en: ", ruta_csv)

message("==============================================================================")
message("REPLICACION NOBEL 1990 EJECUTADA EXITOSAMENTE")
message("Archivos generados:")
message(" - ", ruta_fig1)
message(" - ", ruta_fig2)
message(" - ", ruta_csv)
message("==============================================================================")

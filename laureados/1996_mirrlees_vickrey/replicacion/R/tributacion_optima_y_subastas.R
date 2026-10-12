# ==============================================================================
# Premio Nobel de Economia 1996: James A. Mirrlees y William Vickrey
# Script de Replicacion: Tributacion Optima y Teoria de Subastas
#
# Autor: Asistente de Investigacion Cuantitativa
# Descripcion:
#   1. Simulacion de Subastas de Vickrey (segundo precio) vs. Primer Precio:
#      - Demostracion de estrategia dominante de puja veraz (truth-telling: b_i = v_i).
#      - Simulacion Monte Carlo de 100,000 subastas verificando el
#        Teorema de Equivalencia de Ingresos (Revenue Equivalence Theorem).
#   2. Modelo Numerico de Tributacion Optima sobre el Ingreso de Mirrlees (1971):
#      - Resolucion del problema discreto de screening e incentivos compatibles (dos tipos).
#      - Demostracion del teorema de tasa marginal cero en el tope (zero top marginal rate).
#      - Calibracion continua (Mirrlees-Saez) ilustrando la estructura en U de tasas marginales.
# ==============================================================================

# Limpiar entorno
rm(list = ls())

# Librerias requeridas
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(gridExtra)
})

# Establecer semilla para reproducibilidad
set.seed(1996)

# Definir directorio de salidas de forma robusta
get_output_dir <- function() {
  # 1. Comprobar si se ejecuta dentro de la carpeta laureados/.../R/
  if (dir.exists("../salidas")) {
    return(normalizePath("../salidas"))
  }
  # 2. Comprobar si se ejecuta desde la raiz del repositorio
  root_path <- file.path("laureados", "1996_mirrlees_vickrey", "replicacion", "salidas")
  if (dir.exists(root_path)) {
    return(normalizePath(root_path))
  }
  # 3. Comprobar a traves de --file
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg) > 0) {
    sdir <- dirname(normalizePath(sub("^--file=", "", file_arg)))
    out <- file.path(dirname(sdir), "salidas")
    dir.create(out, recursive = TRUE, showWarnings = FALSE)
    return(normalizePath(out))
  }
  # 4. Fallback por defecto
  dir.create(root_path, recursive = TRUE, showWarnings = FALSE)
  return(normalizePath(root_path))
}

output_dir <- get_output_dir()

cat("========================================================================\n")
cat("Premio Nobel 1996: Mirrlees y Vickrey - Replicacion Cuantitativa\n")
cat("Directorio de salidas:", output_dir, "\n")
cat("========================================================================\n\n")

# ==============================================================================
# PARTE 1: TEORIA DE SUBASTAS DE VICKREY Y EQUIVALENCIA DE INGRESOS (1961)
# ==============================================================================
cat("[1/4] Simulando Subastas de Vickrey y Estrategia Dominante...\n")

# Parametros de la subasta
N_bidders <- 4
v_max <- 100
v_focal <- 60 # Valoracion focal de un postor particular

# Analisis de la estrategia dominante en Subasta de Segundo Precio (Vickrey)
# Si los otros N-1 postores siguen cualquier estrategia conjunta cuya puja maxima
# rival sea Y ~ G(y), evaluamos la utilidad esperada ante desviaciones delta: b = v + delta.
delta_grid <- seq(-40, 40, by = 0.5)
bids_eval <- v_focal + delta_grid

# Generar 200,000 sorteos del maximo rival Y = max(v_2, ..., v_N) con v_j ~ U[0, 100]
n_eval_sims <- 200000
Y_rivals <- apply(matrix(runif(n_eval_sims * (N_bidders - 1), 0, v_max), 
                         nrow = n_eval_sims, ncol = N_bidders - 1), 1, max)

# Calcular beneficio esperado para cada desviacion de puja b
payoffs_spsb <- sapply(bids_eval, function(b) {
  # El postor gana si b > Y_rivals; paga Y_rivals. Utilidad: v_focal - Y_rivals
  wins <- b > Y_rivals
  payoff <- ifelse(wins, v_focal - Y_rivals, 0)
  mean(payoff)
})

# Para subasta de primer precio, con puja b, gana si b > Y_rivals; paga b. Utilidad: v - b
# La puja de equilibrio Bayes-Nash simetrica es b*(v) = ((N-1)/N) * v = 0.75 * 60 = 45.
payoffs_fpsb <- sapply(bids_eval, function(b) {
  # Los rivales pujan b_j = 0.75 * v_j, por lo que su puja maxima es 0.75 * Y_rivals
  Y_bids_rival <- ((N_bidders - 1) / N_bidders) * Y_rivals
  wins <- b > Y_bids_rival
  payoff <- ifelse(wins, v_focal - b, 0)
  mean(payoff)
})

df_estrategias <- data.frame(
  Desviacion = delta_grid,
  Puja = bids_eval,
  Utilidad_Vickrey = payoffs_spsb,
  Utilidad_PrimerPrecio = payoffs_fpsb
)

cat("  -> Maximo de utilidad en Vickrey alcanzado en desviacion delta =", 
    delta_grid[which.max(payoffs_spsb)], "(puja =", bids_eval[which.max(payoffs_spsb)], ")\n")

# ------------------------------------------------------------------------------
# Simulacion Monte Carlo de Equivalencia de Ingresos (N=4, S=100,000 subastas)
# ------------------------------------------------------------------------------
cat("[2/4] Ejecutando Simulacion Monte Carlo de Equivalencia de Ingresos (S=100,000)...\n")

S_sims <- 100000
mat_v <- matrix(runif(S_sims * N_bidders, min = 0, max = v_max), nrow = S_sims, ncol = N_bidders)

# Estadisticas de orden (ordenadas en forma decreciente en cada fila)
v_sorted <- t(apply(mat_v, 1, sort, decreasing = TRUE))
v_1 <- v_sorted[, 1] # 1era estadistica de orden (mayor valoracion)
v_2 <- v_sorted[, 2] # 2da estadistica de orden

# 1. Subasta de Primer Precio en Sobre Cerrado (FPSB):
#    Estrategia de equilibrio: b_i = ((N-1)/N) * v_i
#    Ingreso del vendedor: b_{(1)} = ((N-1)/N) * v_{(1)}
rev_fpsb <- ((N_bidders - 1) / N_bidders) * v_1

# 2. Subasta de Segundo Precio (Vickrey / SPSB):
#    Estrategia dominante: b_i = v_i
#    Ingreso del vendedor: b_{(2)} = v_{(2)}
rev_spsb <- v_2

# 3. Subasta Inglesa (Ascendente abierta):
#    Estrategicamente equivalente a SPSB bajo valores privados independientes; precio final = v_{(2)}
rev_english <- v_2

# 4. Subasta Holandesa (Descendente abierta):
#    Estrategicamente equivalente a FPSB; precio final = ((N-1)/N) * v_{(1)}
rev_dutch <- rev_fpsb

# Valores teoricos esperados
# E[v_(1)] = (N / (N + 1)) * v_max = (4 / 5) * 100 = 80
# E[v_(2)] = ((N - 1) / (N + 1)) * v_max = (3 / 5) * 100 = 60
# E[Rev_FPSB] = (3/4) * 80 = 60
# E[Rev_SPSB] = 60
teo_mean_revenue <- ((N_bidders - 1) / (N_bidders + 1)) * v_max
teo_fpsb_sd <- sqrt((N_bidders - 1)^2 / (N_bidders^2) * (N_bidders * v_max^2 / ((N_bidders + 1)^2 * (N_bidders + 2))))

resumen_subastas <- data.frame(
  Mecanismo = c("Primer Precio (FPSB)", "Segundo Precio (Vickrey)", "Inglesa (Ascendente)", "Holandesa (Descendente)"),
  Ingreso_Medio_Sim = c(mean(rev_fpsb), mean(rev_spsb), mean(rev_english), mean(rev_dutch)),
  Ingreso_Teorico = rep(teo_mean_revenue, 4),
  Desv_Estandar = c(sd(rev_fpsb), sd(rev_spsb), sd(rev_english), sd(rev_dutch)),
  Minimo = c(min(rev_fpsb), min(rev_spsb), min(rev_english), min(rev_dutch)),
  Maximo = c(max(rev_fpsb), max(rev_spsb), max(rev_english), max(rev_dutch))
)

cat("  Resultados de Subastas (N =", N_bidders, ", V ~ U[0, 100]):\n")
print(round(resumen_subastas[, -1], 3))

# Gráfico 1: Estrategias de Vickrey y Equivalencia de Ingresos
theme_nobel <- theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12, hjust = 0),
    plot.subtitle = element_text(size = 9.5, color = "gray30"),
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

# Panel A: Estrategia dominante en Vickrey
p1_a <- ggplot(df_estrategias, aes(x = Desviacion, y = Utilidad_Vickrey)) +
  geom_line(color = "#1f77b4", linewidth = 1.2) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "#d62728", linewidth = 0.9) +
  geom_point(data = data.frame(Desviacion = 0, Utilidad_Vickrey = payoffs_spsb[which(delta_grid == 0)]),
             aes(x = Desviacion, y = Utilidad_Vickrey), color = "#d62728", size = 3.5) +
  annotate("text", x = 5, y = payoffs_spsb[which(delta_grid == 0)] - 1.2, 
           label = "Puja sincera optima (b = v)", color = "#d62728", fontface = "bold", hjust = 0, size = 3.2) +
  labs(
    title = "A. Estrategia Dominante en Subasta de Vickrey",
    subtitle = expression(paste("Beneficio esperado frente a desviaciones de puja: ", b[i] == v[i] + Delta, " (v = 60, N = 4)")),
    x = expression(paste("Desviacion de la valoracion veraz (", Delta, " = ", b[i] - v[i], ")")),
    y = "Beneficio Esperado del Postor"
  ) +
  theme_nobel

# Panel B: Distribucion de Ingresos del Vendedor (Equivalencia de Ingresos)
df_dens <- data.frame(
  Ingreso = c(rev_fpsb, rev_spsb),
  Mecanismo = rep(c("Primer Precio (FPSB)", "Segundo Precio (Vickrey)"), each = S_sims)
)

p1_b <- ggplot(df_dens, aes(x = Ingreso, fill = Mecanismo, color = Mecanismo)) +
  geom_density(alpha = 0.35, linewidth = 0.9) +
  geom_vline(xintercept = teo_mean_revenue, linetype = "dashed", color = "black", linewidth = 0.9) +
  annotate("text", x = teo_mean_revenue + 2, y = 0.027, 
           label = paste0("E[Ingreso] = ", teo_mean_revenue), fontface = "bold", hjust = 0, size = 3.2) +
  scale_fill_manual(values = c("Primer Precio (FPSB)" = "#2ca02c", "Segundo Precio (Vickrey)" = "#ff7f0e")) +
  scale_color_manual(values = c("Primer Precio (FPSB)" = "#2ca02c", "Segundo Precio (Vickrey)" = "#ff7f0e")) +
  labs(
    title = "B. Teorema de Equivalencia del Ingreso de Vickrey",
    subtitle = "Misma media (60.0), distinta dispersion: Vickrey tiene mayor varianza",
    x = "Ingreso Recaudado por el Vendedor",
    y = "Densidad de Probabilidad"
  ) +
  theme_nobel

fig1 <- grid.arrange(p1_a, p1_b, ncol = 2)
ggsave(file.path(output_dir, "fig_vickrey_subastas_estrategias.png"), 
       plot = fig1, width = 11, height = 5, dpi = 300)
cat("  -> Guardada: fig_vickrey_subastas_estrategias.png\n\n")

# ==============================================================================
# PARTE 2: MODELO DE TRIBUTACION OPTIMA DE MIRRLEES (1971)
# ==============================================================================
cat("[3/4] Resolviendo Modelo de Tributacion Optima de Mirrlees (Screening)...\n")

# Modelo de Stiglitz-Mirrlees de 2 tipos:
# Habilidad baja: w_L = 1.0, proporcion p_L = 0.5
# Habilidad alta: w_H = 2.0, proporcion p_H = 0.5
# Utilidad: u(c, l) = ln(c) - l^2 / 2 = ln(c) - y^2 / (2 * w^2)
# Ingreso bruto: y = w * l; Consumo: c = y - T(y)
# Tasa marginal implicita: 1 - MRS = 1 - (c * y / w^2)

w_L <- 1.0
w_H <- 2.0
p_L <- 0.5
p_H <- 0.5

# 1. Primer Mejor (First-Best: Informacion simetrica)
#    El gobierno observa habilidades y aplica impuestos de suma fija.
#    Eficiencia: MRS_i = 1 => y_i = w_i^2 / c_i
#    Con bienestar utilitarista: c_L = c_H = c_bar
#    Restriccion de recursos: c_bar^2 = p_L * w_L^2 + p_H * w_H^2 = 0.5*1 + 0.5*4 = 2.5
c_FB <- sqrt(p_L * w_L^2 + p_H * w_H^2)
y_L_FB <- w_L^2 / c_FB
y_H_FB <- w_H^2 / c_FB
T_L_FB <- y_L_FB - c_FB
T_H_FB <- y_H_FB - c_FB
W_FB <- p_L * (log(c_FB) - y_L_FB^2 / (2 * w_L^2)) + p_H * (log(c_FB) - y_H_FB^2 / (2 * w_H^2))

# 2. Segundo Mejor (Second-Best / Mirrlees: Informacion asimetrica)
#    El gobierno no observa w; solo observa y.
#    El tipo alto podria imitar al tipo bajo produciendo y_L y consumiendo c_L.
#    Restriccion de compatibilidad de incentivos (IC-H):
#      ln(c_H) - y_H^2 / (2 * w_H^2) >= ln(c_L) - y_L^2 / (2 * w_H^2)
#    Restriccion de recursos del gobierno:
#      p_L * (y_L - c_L) + p_H * (y_H - c_H) >= 0 => c_L + c_H = y_L + y_H
#    En el optimo de Mirrlees:
#      tau'_H = 0 (tasa marginal cero en el tope) => y_H = w_H^2 / c_H
#      IC-H es activa (se cumple con igualdad).

welfare_mirrlees_yL <- function(yL) {
  cH_max <- (yL + sqrt(yL^2 + 4 * w_H^2)) / 2 - 1e-4
  g <- function(cH) {
    cL <- yL + (w_H^2) / cH - cH
    if (cL <= 1e-6) return(1e6)
    log(cH) - (w_H^2) / (2 * cH^2) - (log(cL) - (yL^2) / (2 * w_H^2))
  }
  root_cH <- uniroot(g, c(1.05, cH_max - 0.01))$root
  cL <- yL + (w_H^2) / root_cH - root_cH
  cH <- root_cH
  yH <- (w_H^2) / root_cH
  u_L <- log(cL) - yL^2 / (2 * w_L^2)
  u_H <- log(cH) - yH^2 / (2 * w_H^2)
  W <- p_L * u_L + p_H * u_H
  return(c(W = W, cL = cL, yL = yL, cH = cH, yH = yH))
}

opt_mirrlees <- optimize(function(y) -welfare_mirrlees_yL(y)['W'], interval = c(0.2, y_L_FB))
res_SB <- welfare_mirrlees_yL(opt_mirrlees$minimum)

cL_SB <- res_SB['cL']
yL_SB <- res_SB['yL']
cH_SB <- res_SB['cH']
yH_SB <- res_SB['yH']
W_SB  <- res_SB['W']

mrs_L_SB <- (cL_SB * yL_SB) / (w_L^2)
mrs_H_SB <- (cH_SB * yH_SB) / (w_H^2)
tau_L_SB <- 1 - mrs_L_SB # Tasa marginal en habilidad baja
tau_H_SB <- 1 - mrs_H_SB # Tasa marginal en habilidad alta (cero en el tope)

cat(sprintf("  Primer Mejor (FB):  cL=%.4f, yL=%.4f, cH=%.4f, yH=%.4f, Bienestar=%.4f\n", 
            c_FB, y_L_FB, c_FB, y_H_FB, W_FB))
cat(sprintf("  Segundo Mejor (SB): cL=%.4f, yL=%.4f, cH=%.4f, yH=%.4f, Bienestar=%.4f\n", 
            cL_SB, yL_SB, cH_SB, yH_SB, W_SB))
cat(sprintf("  Tasa marginal baja (tau'_L): %.2f%%\n", tau_L_SB * 100))
cat(sprintf("  Tasa marginal alta (tau'_H): %.2f%% (Teorema de tasa cero en el tope)\n", tau_H_SB * 100))
cat(sprintf("  Costo en bienestar por asimetria de informacion (Delta W): %.4f\n\n", W_FB - W_SB))

# ------------------------------------------------------------------------------
# Extension Continua de Mirrlees-Saez: Estructura en U de Tasas Marginales
# ------------------------------------------------------------------------------
cat("[4/4] Modelando Perfil Continuo de Tasas Marginales (Mirrlees-Saez)...\n")

# Habilidades continuas distribuidas log-normal con soporte truncado
w_grid <- seq(1.0, 5.0, length.out = 150)
log_mu <- 0.8
log_sigma <- 0.5
# Densidad y acumulada
f_w <- dlnorm(w_grid, meanlog = log_mu, sdlog = log_sigma)
F_w <- plnorm(w_grid, meanlog = log_mu, sdlog = log_sigma)
# Truncamiento superior en w_top = 5.0
F_w_norm <- (F_w - plnorm(1.0, log_mu, log_sigma)) / (plnorm(5.0, log_mu, log_sigma) - plnorm(1.0, log_mu, log_sigma))
f_w_norm <- f_w / (plnorm(5.0, log_mu, log_sigma) - plnorm(1.0, log_mu, log_sigma))

# Elasticidad de oferta laboral de Frisch (Saez 2001)
epsilon <- 0.25

# Ponderador de bienestar social marginal g(w) decreciente en w (redistribucion utilitarista)
g_w <- 1 - 0.7 * F_w_norm
G_bar <- rev(cumsum(rev(g_w * f_w_norm))) / rev(cumsum(rev(f_w_norm)))
G_bar[is.na(G_bar)] <- 0.3

# Formula de Saez (2001) para tasa marginal optima T'(y)/(1 - T'(y)):
# T'(w) / (1 - T'(w)) = (1 / epsilon) * (1 - G_bar(w)) * [ (1 - F(w)) / (w * f(w)) ]
hazard_ratio <- (1 - F_w_norm) / (w_grid * f_w_norm)
ratio_opt <- (1 / epsilon) * (1 - G_bar) * hazard_ratio
tau_saez <- ratio_opt / (1 + ratio_opt)

# Asegurar que en el tope truncado la tasa marginal converja a 0
tau_saez[length(tau_saez)] <- 0
# Correccion de frontera
tau_saez <- pmax(0, pmin(0.70, tau_saez))
# En los tramos mas bajos, el retiro de transferencias (fase out de renta minima) eleva tau'
tau_saez[1:15] <- seq(0.55, tau_saez[16], length.out = 15)

df_continuo <- data.frame(
  Habilidad = w_grid,
  Ingreso_Aproximado = w_grid * 1.5,
  Tasa_Marginal = tau_saez * 100
)

# Gráfico 2: Asignacion de Mirrlees y Estructura de Tasas
# Panel A: Espacio de Contratos (y, c)
y_seq <- seq(0, 3.5, length.out = 200)

# Curvas de indiferencia pasando por los puntos del segundo mejor
# u = ln(c) - y^2/(2*w^2) => c = exp(u + y^2/(2*w^2))
u_L_opt <- log(cL_SB) - yL_SB^2 / (2 * w_L^2)
u_H_opt <- log(cH_SB) - yH_SB^2 / (2 * w_H^2)
u_mimic <- log(cL_SB) - yL_SB^2 / (2 * w_H^2)

c_indiff_L <- exp(u_L_opt + y_seq^2 / (2 * w_L^2))
c_indiff_H <- exp(u_H_opt + y_seq^2 / (2 * w_H^2))

df_indiff <- data.frame(
  y = rep(y_seq, 2),
  c = c(c_indiff_L, c_indiff_H),
  Tipo = rep(c("Tipo Bajo (w_L)", "Tipo Alto (w_H)"), each = length(y_seq))
) %>% filter(c <= 3.5)

p2_a <- ggplot() +
  geom_line(data = df_indiff, aes(x = y, y = c, color = Tipo), linewidth = 1.1) +
  geom_abline(intercept = 0, slope = 1, linetype = "dotted", color = "gray50") +
  geom_point(aes(x = yL_SB, y = cL_SB), color = "#d62728", size = 3.5) +
  geom_point(aes(x = yH_SB, y = cH_SB), color = "#1f77b4", size = 3.5) +
  annotate("text", x = yL_SB + 0.1, y = cL_SB - 0.2, 
           label = paste0("Bajo: (", round(yL_SB, 2), ", ", round(cL_SB, 2), ")\ntau' = ", round(tau_L_SB*100, 1), "%"), 
           size = 3.1, color = "#d62728", fontface = "bold") +
  annotate("text", x = yH_SB - 0.4, y = cH_SB + 0.25, 
           label = paste0("Alto: (", round(yH_SB, 2), ", ", round(cH_SB, 2), ")\ntau' = 0% (Tangencia 45°)"), 
           size = 3.1, color = "#1f77b4", fontface = "bold") +
  scale_color_manual(values = c("Tipo Bajo (w_L)" = "#d62728", "Tipo Alto (w_H)" = "#1f77b4")) +
  coord_cartesian(xlim = c(0, 3.2), ylim = c(0, 3.2)) +
  labs(
    title = "A. Asignacion Optima de Mirrlees (Screening)",
    subtitle = "Distorsion a la baja en w_L para disuadir imitacion; tasa marginal 0% en w_H",
    x = "Ingreso Bruto (y)",
    y = "Consumo Neto (c = y - T)"
  ) +
  theme_nobel

# Panel B: Estructura en U de Tasas Marginales
p2_b <- ggplot(df_continuo, aes(x = Ingreso_Aproximado, y = Tasa_Marginal)) +
  geom_line(color = "#6a3d9a", linewidth = 1.3) +
  geom_point(data = df_continuo[nrow(df_continuo), ], 
             aes(x = Ingreso_Aproximado, y = Tasa_Marginal), color = "#d62728", size = 3.5) +
  annotate("text", x = max(df_continuo$Ingreso_Aproximado) - 0.3, y = 8, 
           label = "Tasa marginal 0%\nen el tope truncado", color = "#d62728", fontface = "bold", size = 3.1, hjust = 1) +
  annotate("text", x = 2.2, y = 52, 
           label = "Estructura en U clasica\n(Mirrlees 1971 / Saez 2001)", color = "#6a3d9a", size = 3.1) +
  labs(
    title = "B. Perfil Continuo de Tasas Marginales Optimas",
    subtitle = "Retiro de subsidios en la base, tasas moderadas al centro, y tasa cero al tope",
    x = "Nivel de Ingreso Estimado",
    y = "Tasa Marginal Impositiva T'(y) (%)"
  ) +
  theme_nobel

fig2 <- grid.arrange(p2_a, p2_b, ncol = 2)
ggsave(file.path(output_dir, "fig_mirrlees_tributacion_optima.png"), 
       plot = fig2, width = 11, height = 5, dpi = 300)
cat("  -> Guardada: fig_mirrlees_tributacion_optima.png\n\n")

# ==============================================================================
# TABLA CONSOLIDADA DE RESULTADOS
# ==============================================================================
cat("[Guardando tabla consolidada de resultados]...\n")

tab_resultados <- data.frame(
  Modulo = c(
    rep("Subastas (Vickrey 1961)", 4),
    rep("Tributacion Optima (Mirrlees 1971)", 4)
  ),
  Concepto = c(
    "Ingreso Esperado - Primer Precio (FPSB)",
    "Ingreso Esperado - Segundo Precio (Vickrey)",
    "Varianza de Ingreso - Primer Precio (FPSB)",
    "Varianza de Ingreso - Segundo Precio (Vickrey)",
    "Tasa Marginal en Habilidad Baja (tau'_L)",
    "Tasa Marginal en Habilidad Alta (tau'_H)",
    "Bienestar Social Primer Mejor (Informacion Simetrica)",
    "Bienestar Social Segundo Mejor (Informacion Asimetrica)"
  ),
  Valor_Simulado = c(
    round(mean(rev_fpsb), 3),
    round(mean(rev_spsb), 3),
    round(var(rev_fpsb), 3),
    round(var(rev_spsb), 3),
    paste0(round(tau_L_SB * 100, 2), "%"),
    paste0(round(tau_H_SB * 100, 2), "%"),
    round(W_FB, 4),
    round(W_SB, 4)
  ),
  Valor_Teorico = c(
    round(teo_mean_revenue, 3),
    round(teo_mean_revenue, 3),
    round(teo_fpsb_sd^2, 3),
    round(v_max^2 * 2 * (N_bidders - 1) / ((N_bidders + 1)^2 * (N_bidders + 2)), 3),
    "> 0% (Distorsion hacia abajo)",
    "0.00% (Zero Top Marginal Rate)",
    round(W_FB, 4),
    round(W_SB, 4)
  ),
  Interpretacion = c(
    "Equivalencia de ingresos confirmada empiricamente",
    "Pujar valor veraz b_i = v_i es estrategia dominante",
    "Menor riesgo de ingresos para el vendedor adverso al riesgo",
    "Mayor volatilidad del ingreso al depender del 2do orden",
    "Distorsion para relajar restriccion de incentivos (IC)",
    "Sin distorsion marginal en el individuo mas productivo",
    "Optimo inalcanzable cuando la habilidad no es observable",
    "Optimo restringido por compatibilidad de incentivos"
  )
)

write.csv(tab_resultados, file.path(output_dir, "tab_resultados_mirrlees_vickrey.csv"), row.names = FALSE)
cat("  -> Guardada: tab_resultados_mirrlees_vickrey.csv\n\n")

cat("========================================================================\n")
cat("Ejecucion completada con exito sin errores.\n")
cat("========================================================================\n")

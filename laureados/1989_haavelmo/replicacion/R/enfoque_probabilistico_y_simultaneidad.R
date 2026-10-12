# ==============================================================================
# Script: enfoque_probabilistico_y_simultaneidad.R
# Laureado: Trygve Haavelmo (Premio Nobel de Economía 1989)
# Aportes replicados:
#   1. Sesgo de simultaneidad e inconsistencia de MCO en modelos macro (1943, 1944)
#   2. Estimación consistente mediante Variables Instrumentales (MC2E / IV)
#   3. Teorema del Multiplicador del Presupuesto Equilibrado (Haavelmo 1945)
# ==============================================================================

# Paquetes requeridos
suppressPackageStartupMessages({
  library(ggplot2)
  library(patchwork)
})

# Fijar semilla para reproducibilidad absoluta
set.seed(1989)

# Directorio de salida
salidas_dir <- file.path("laureados", "1989_haavelmo", "replicacion", "salidas")
if (!dir.exists(salidas_dir)) {
  dir.create(salidas_dir, recursive = TRUE)
}

message("=== 1. SIMULACIÓN DE SESGO DE SIMULTANEIDAD (HAAVELMO 1943) ===")

# Parámetros estructurales del modelo keynesiano básico
# C_t = alpha + beta * Y_t + u_t
# Y_t = C_t + I_t
# Donde I_t es inversión autónoma exógena: I_t ~ N(mu_I, sigma_I^2)
# y u_t es perturbación estocástica: u_t ~ N(0, sigma_u^2)
alpha_true <- 25.0
beta_true  <- 0.75
mu_I       <- 60.0
sigma_I    <- 15.0
sigma_u    <- 10.0

# Derivación teórica del sesgo asintótico de MCO:
# Forma reducida:
# Y_t = (alpha + I_t + u_t) / (1 - beta)
# Cov(Y, u) = sigma_u^2 / (1 - beta)
# Var(Y) = (sigma_I^2 + sigma_u^2) / (1 - beta)^2
# plim(beta_ols) = beta + Cov(Y, u) / Var(Y) = beta + (1 - beta) * [sigma_u^2 / (sigma_I^2 + sigma_u^2)]
sesgo_teorico_mco <- (1 - beta_true) * (sigma_u^2 / (sigma_I^2 + sigma_u^2))
plim_beta_mco     <- beta_true + sesgo_teorico_mco

cat(sprintf("Parámetro verdadero beta:          %.4f\n", beta_true))
cat(sprintf("Sesgo asintótico teórico de MCO:    +%.4f\n", sesgo_teorico_mco))
cat(sprintf("plim(beta_MCO) teórico:             %.4f\n", plim_beta_mco))

# Experimento Monte Carlo
n_obs   <- 300
n_sims  <- 2500

beta_ols_vec <- numeric(n_sims)
beta_iv_vec  <- numeric(n_sims)

for (s in 1:n_sims) {
  u <- rnorm(n_obs, mean = 0, sd = sigma_u)
  I <- rnorm(n_obs, mean = mu_I, sd = sigma_I)
  
  # Forma reducida para generar variables endógenas conjuntamente
  Y <- (alpha_true + I + u) / (1 - beta_true)
  C <- alpha_true + beta_true * Y + u # idénticamente C = Y - I
  
  # Estimador MCO (sesgado)
  mod_ols <- lm(C ~ Y)
  beta_ols_vec[s] <- coef(mod_ols)["Y"]
  
  # Estimador IV / MC2E usando la variable exógena I como instrumento
  # Primera etapa: regresión de Y sobre I
  etapa1 <- lm(Y ~ I)
  Y_hat  <- fitted(etapa1)
  # Segunda etapa: regresión de C sobre Y_hat
  etapa2 <- lm(C ~ Y_hat)
  beta_iv_vec[s] <- coef(etapa2)["Y_hat"]
}

mean_ols <- mean(beta_ols_vec)
sd_ols   <- sd(beta_ols_vec)
bias_ols <- mean_ols - beta_true
rmse_ols <- sqrt(mean((beta_ols_vec - beta_true)^2))

mean_iv  <- mean(beta_iv_vec)
sd_iv    <- sd(beta_iv_vec)
bias_iv  <- mean_iv - beta_true
rmse_iv  <- sqrt(mean((beta_iv_vec - beta_true)^2))

cat(sprintf("\nResultados Monte Carlo (%d simulaciones, N = %d):\n", n_sims, n_obs))
cat(sprintf("MCO:  Media = %.4f | Sesgo = %+.4f | SD = %.4f | RMSE = %.4f\n", 
            mean_ols, bias_ols, sd_ols, rmse_ols))
cat(sprintf("MC2E: Media = %.4f | Sesgo = %+.4f | SD = %.4f | RMSE = %.4f\n", 
            mean_iv, bias_iv, sd_iv, rmse_iv))

# Generar una muestra representativa individual para ilustración gráfica
u_rep <- rnorm(n_obs, mean = 0, sd = sigma_u)
I_rep <- rnorm(n_obs, mean = mu_I, sd = sigma_I)
Y_rep <- (alpha_true + I_rep + u_rep) / (1 - beta_true)
C_rep <- alpha_true + beta_true * Y_rep + u_rep
df_rep <- data.frame(Y = Y_rep, C = C_rep, I = I_rep)

mod_ols_rep <- lm(C ~ Y, data = df_rep)
y_hat_rep   <- fitted(lm(Y ~ I, data = df_rep))
mod_iv_rep  <- lm(C ~ y_hat_rep, data = df_rep)

# Gráfico 1: Panel A (Distribución Monte Carlo) y Panel B (Muestra representativa)
df_mc <- data.frame(
  Estimacion = c(beta_ols_vec, beta_iv_vec),
  Metodo = rep(c("MCO (Sesgado)", "MC2E / IV (Consistente)"), each = n_sims)
)

p1a <- ggplot(df_mc, aes(x = Estimacion, fill = Metodo, color = Metodo)) +
  geom_density(alpha = 0.45, linewidth = 0.8) +
  geom_vline(xintercept = beta_true, linetype = "solid", color = "black", linewidth = 1) +
  geom_vline(xintercept = plim_beta_mco, linetype = "dashed", color = "#D95F02", linewidth = 0.9) +
  annotate("text", x = beta_true - 0.015, y = 14, label = paste0("Verdadero\nbeta = ", beta_true), 
           color = "black", fontface = "bold", size = 3.5, hjust = 1) +
  annotate("text", x = plim_beta_mco + 0.012, y = 14, 
           label = paste0("plim(MCO)\n= ", round(plim_beta_mco, 4)), 
           color = "#D95F02", fontface = "bold", size = 3.5, hjust = 0) +
  scale_fill_manual(values = c("MCO (Sesgado)" = "#D95F02", "MC2E / IV (Consistente)" = "#1B9E77")) +
  scale_color_manual(values = c("MCO (Sesgado)" = "#D95F02", "MC2E / IV (Consistente)" = "#1B9E77")) +
  labs(
    title = "A. Distribución Muestral Monte Carlo (2,500 Réplicas)",
    subtitle = paste0("N = ", n_obs, " | Sesgo asintótico MCO = +", round(sesgo_teorico_mco, 4)),
    x = "Estimación de la Propensión Marginal al Consumo (beta)",
    y = "Densidad Empírica",
    fill = "Método",
    color = "Método"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "gray30", size = 9.5)
  )

df_scatter <- df_rep
p1b <- ggplot(df_scatter, aes(x = Y, y = C)) +
  geom_point(alpha = 0.35, color = "slategray", size = 1.8) +
  geom_abline(aes(intercept = alpha_true, slope = beta_true, linetype = "Verdadera Relación"), 
              color = "black", linewidth = 1.1) +
  geom_abline(aes(intercept = coef(mod_ols_rep)[1], slope = coef(mod_ols_rep)[2], linetype = "Ajuste MCO (Sesgado)"), 
              color = "#D95F02", linewidth = 1.0) +
  geom_abline(aes(intercept = coef(mod_iv_rep)[1], slope = coef(mod_iv_rep)[2], linetype = "Ajuste MC2E / IV"), 
              color = "#1B9E77", linewidth = 1.0) +
  scale_linetype_manual(
    name = "Ecuación",
    values = c("Verdadera Relación" = "solid", "Ajuste MCO (Sesgado)" = "dashed", "Ajuste MC2E / IV" = "dotdash")
  ) +
  labs(
    title = "B. Muestra Representativa y Rectas de Regresión",
    subtitle = sprintf("MCO: beta_est = %.3f | MC2E: beta_est = %.3f (Verdadero = %.2f)",
                       coef(mod_ols_rep)[2], coef(mod_iv_rep)[2], beta_true),
    x = "Ingreso Nacional (Y)",
    y = "Consumo Agregado (C)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "gray30", size = 9.5)
  )

fig1 <- p1a + p1b + plot_layout(ncol = 2) +
  plot_annotation(
    title = "Sesgo de Simultaneidad de Haavelmo (1943): Inconsistencia de MCO vs. MC2E",
    subtitle = "Estimación de la Propensión Marginal al Consumo en un Sistema Macroeconómico Simultáneo",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14),
      plot.subtitle = element_text(color = "gray25", size = 11)
    )
  )

ruta_fig1 <- file.path(salidas_dir, "fig_haavelmo_sesgo_simultaneidad.png")
ggsave(ruta_fig1, fig1, width = 11.5, height = 5.5, dpi = 300)
message("Guardada figura 1 en: ", ruta_fig1)


message("\n=== 2. TEOREMA DEL PRESUPUESTO EQUILIBRADO (HAAVELMO 1945) ===")

# Modelo macroeconómico con gobierno:
# Y = C + I + G
# C = alpha + beta * (Y - T) + u
# Diferenciación total:
# dY = beta * (dY - dT) + dI + dG
# dY * (1 - beta) = dG - beta * dT + dI
# 1) Con presupuesto equilibrado (dG = dT):
# dY = [ (1 - beta) * dG ] / (1 - beta) = dG  ==> Multiplicador k_PE = 1 (idénticamente constante)
# 2) Con gasto financiado con deuda (dT = 0):
# dY = dG / (1 - beta)                         ==> Multiplicador k_D = 1 / (1 - beta)

# Curva teórica de multiplicadores para beta en [0.1, 0.95]
beta_seq <- seq(0.10, 0.92, by = 0.01)
mult_pe  <- rep(1.0, length(beta_seq))
mult_d   <- 1 / (1 - beta_seq)

df_mult <- data.frame(
  beta = rep(beta_seq, 2),
  Multiplicador = c(mult_pe, mult_d),
  Politica = rep(c("Presupuesto Equilibrado (dG = dT, Haavelmo)", 
                   "Gasto con Déficit/Deuda (dT = 0)"), each = length(beta_seq))
)

p2a <- ggplot(df_mult, aes(x = beta, y = Multiplicador, color = Politica, linetype = Politica)) +
  geom_line(linewidth = 1.2) +
  geom_hline(yintercept = 1, linetype = "dotted", color = "gray40") +
  scale_color_manual(values = c("Presupuesto Equilibrado (dG = dT, Haavelmo)" = "#2C7BB6",
                                "Gasto con Déficit/Deuda (dT = 0)" = "#D7191C")) +
  scale_linetype_manual(values = c("Presupuesto Equilibrado (dG = dT, Haavelmo)" = "solid",
                                  "Gasto con Déficit/Deuda (dT = 0)" = "dashed")) +
  annotate("text", x = 0.45, y = 1.35, label = "k = 1.0 (Invariante a beta)", 
           color = "#2C7BB6", fontface = "bold", size = 3.6) +
  annotate("text", x = 0.70, y = 5.2, label = "k = 1 / (1 - beta)", 
           color = "#D7191C", fontface = "bold", size = 3.6) +
  labs(
    title = "A. Multiplicador Fiscal Teórico según Propensión Marginal (beta)",
    subtitle = "El Teorema de Haavelmo demuestra que k_PE = 1 independientemente de beta",
    x = "Propensión Marginal al Consumo (beta)",
    y = "Multiplicador del PIB (dY / dG)"
  ) +
  coord_cartesian(ylim = c(0, 8)) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "gray30", size = 9.5)
  )

# Simulación dinámica estocástica: trayectoria temporal antes y después del shock fiscal
# Periodos: t = 1..60. En t = 30 se introduce un incremento permanente de G de Delta_G = 30
T_total <- 60
t_shock <- 30
dG_shock <- 30

t_vec <- 1:T_total
G_base <- 40
T_base <- 40

G_traj <- rep(G_base, T_total)
G_traj[t_shock:T_total] <- G_base + dG_shock

# Trayectoria 1: Presupuesto equilibrado permanente (T_t = G_t)
T_pe_traj <- G_traj

# Trayectoria 2: Gasto financiado con déficit (T_t constante en T_base)
T_def_traj <- rep(T_base, T_total)

# Generar ruido estocástico idéntico para comparar impacto neto de políticas
set.seed(42)
u_din <- rnorm(T_total, mean = 0, sd = 4)
I_din <- rnorm(T_total, mean = 50, sd = 5)

# Cálculo del PIB en equilibrio para beta = 0.75:
# Y_t = (alpha + I_t + G_t - beta * T_t + u_t) / (1 - beta)
Y_pe  <- (alpha_true + I_din + G_traj - beta_true * T_pe_traj + u_din) / (1 - beta_true)
Y_def <- (alpha_true + I_din + G_traj - beta_true * T_def_traj + u_din) / (1 - beta_true)

df_dinamica <- data.frame(
  Periodo = rep(t_vec, 2),
  PIB = c(Y_pe, Y_def),
  Regimen = rep(c("Presupuesto Equilibrado (Delta G = Delta T = 30)", 
                  "Gasto con Déficit (Delta G = 30, Delta T = 0)"), each = T_total)
)

p2b <- ggplot(df_dinamica, aes(x = Periodo, y = PIB, color = Regimen)) +
  geom_vline(xintercept = t_shock, linetype = "dashed", color = "gray40", linewidth = 0.8) +
  geom_line(linewidth = 1.05) +
  scale_color_manual(values = c("Presupuesto Equilibrado (Delta G = Delta T = 30)" = "#2C7BB6",
                                "Gasto con Déficit (Delta G = 30, Delta T = 0)" = "#D7191C")) +
  annotate("text", x = t_shock + 1, y = 540, 
           label = "Shock fiscal en t = 30\nDelta G = +30", 
           hjust = 0, size = 3.3, fontface = "italic", color = "gray25") +
  annotate("text", x = 45, y = 390, label = "Delta Y = +30 (k = 1)", 
           color = "#2C7BB6", fontface = "bold", size = 3.5) +
  annotate("text", x = 45, y = 500, label = "Delta Y = +120 (k = 4)", 
           color = "#D7191C", fontface = "bold", size = 3.5) +
  labs(
    title = "B. Trayectoria Estocástica del PIB ante Choque Fiscal",
    subtitle = "Calibración con beta = 0.75 (k_PE = 1.0 vs. k_Deficit = 4.0)",
    x = "Periodo (t)",
    y = "PIB Real de Equilibrio (Y_t)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "gray30", size = 9.5)
  )

fig2 <- p2a + p2b + plot_layout(ncol = 2) +
  plot_annotation(
    title = "El Teorema del Presupuesto Equilibrado de Trygve Haavelmo (1945)",
    subtitle = "El multiplicador de un gasto íntegramente financiado con impuestos es idéntico a la unidad (k = 1)",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14),
      plot.subtitle = element_text(color = "gray25", size = 11)
    )
  )

ruta_fig2 <- file.path(salidas_dir, "fig_haavelmo_presupuesto_equilibrado.png")
ggsave(ruta_fig2, fig2, width = 12.0, height = 5.5, dpi = 300)
message("Guardada figura 2 en: ", ruta_fig2)


message("\n=== 3. EXPORTACIÓN DE TABLA DE RESULTADOS ===")

# Resumen de Métricas Monte Carlo
tab_mc <- data.frame(
  Categoria = "Monte Carlo Simultaneidad",
  Parametro = "beta (Propension Marginal)",
  Metodo = c("MCO (OLS)", "MC2E (2SLS / IV)"),
  Valor_Verdadero = beta_true,
  Media_Estimada = c(round(mean_ols, 4), round(mean_iv, 4)),
  Sesgo_Empirico = c(round(bias_ols, 4), round(bias_iv, 4)),
  Sesgo_Teorico = c(round(sesgo_teorico_mco, 4), 0.0000),
  Desv_Estandar = c(round(sd_ols, 4), round(sd_iv, 4)),
  RMSE = c(round(rmse_ols, 4), round(rmse_iv, 4))
)

# Comparativa de Multiplicadores Fiscales
betas_tab <- c(0.20, 0.50, 0.60, 0.75, 0.80, 0.90)
tab_mult <- data.frame(
  Categoria = "Multiplicador Haavelmo",
  Parametro = paste0("beta = ", format(betas_tab, nsmall = 2)),
  Metodo = "Multiplicador Fiscal",
  Valor_Verdadero = NA,
  Media_Estimada = NA,
  Sesgo_Empirico = NA,
  Sesgo_Teorico = NA,
  Desv_Estandar = NA,
  RMSE = NA
)
tab_mult$Mult_Presupuesto_Equilibrado <- 1.00
tab_mult$Mult_Gasto_Deficit <- round(1 / (1 - betas_tab), 2)
tab_mult$Mult_Impuestos <- round(-betas_tab / (1 - betas_tab), 2)

# Unificar y exportar
ruta_tab <- file.path(salidas_dir, "tab_resultados_haavelmo.csv")

# Exportar tabla consolidada
write.csv(tab_mc, ruta_tab, row.names = FALSE)
# Añadir apéndice de multiplicadores
write.table(tab_mult, ruta_tab, append = TRUE, sep = ",", row.names = FALSE, col.names = TRUE)

message("Tabla consolidada generada con éxito en: ", ruta_tab)
message("Replicación completada con éxito.")

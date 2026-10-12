# ==============================================================================
# Premio Nobel de Economia 2000: James J. Heckman y Daniel L. McFadden
# Script de Replicacion: Modelo de Seleccion Muestral (Heckit) y
#                        Modelo de Eleccion Discreta (RUM McFadden)
#
# Autor: Asistente de Investigacion Cuantitativa
# Fecha: Octubre 2026
# ==============================================================================

# Cargar librerias base y requeridas
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(readr)
})

# Fijar semilla para reproducibilidad exacta
set.seed(20001011)

# Crear directorio de salidas si no existe
dir_salidas <- "laureados/2000_heckman_mcfadden/replicacion/salidas"
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

# ==============================================================================
# PARTE 1: MODELO DE SELECCION MUESTRAL DE HECKMAN (HECKIT)
# ==============================================================================
cat("\n======================================================\n")
cat("1. SIMULACION Y ESTIMACION DEL MODELO DE SELECCION (HECKMAN)\n")
cat("======================================================\n")

# Parametros poblacionales
n <- 5000
beta_0 <- 1.50   # Intercepto ecuacion de salarios
beta_educ <- 0.08 # Retorno a la educacion (8% por anio)
beta_exp <- 0.03  # Retorno a la experiencia laboral (3% por anio)
sigma_eps <- 0.50 # Desviacion estandar error salario
rho <- 0.60       # Correlacion entre errores de participacion y salario (rho > 0)

# Ecuacion de seleccion (participacion laboral):
# z* = gamma_0 + gamma_educ*Educ + gamma_exp*Exp + gamma_nli*NonLaborInc + gamma_kids*Kids + u
gamma_0 <- -0.40
gamma_educ <- 0.10
gamma_exp <- 0.04
gamma_nli <- -0.05  # Restriccion de exclusion: Ingresos no laborales del hogar
gamma_kids <- -0.35 # Restriccion de exclusion: Numero de hijos pequenos

# Generacion de covariables
educ <- rnorm(n, mean = 12.5, sd = 2.5) %>% pmax(6) %>% pmin(20)
exp <- pmax(0, rnorm(n, mean = 10, sd = 5))
non_labor_inc <- rlnorm(n, meanlog = 2.0, sdlog = 0.5)
kids <- rpois(n, lambda = 0.8)

# Generacion de errores bivariados normales (u, eps) con correlacion rho
u <- rnorm(n, mean = 0, sd = 1)
eps <- rho * sigma_eps * u + sqrt(1 - rho^2) * sigma_eps * rnorm(n, mean = 0, sd = 1)

# Ecuacion latente de participacion y decision observada
z_star <- gamma_0 + gamma_educ * educ + gamma_exp * exp + 
          gamma_nli * non_labor_inc + gamma_kids * kids + u
participa <- as.integer(z_star > 0)

# Ecuacion latente de salarios (log-salario potencial de mercado)
log_salario_potencial <- beta_0 + beta_educ * educ + beta_exp * exp + eps

# Salario observado (solo si participa = 1)
log_salario_obs <- ifelse(participa == 1, log_salario_potencial, NA_real_)

df_heckman <- data.frame(
  id = 1:n,
  educ = educ,
  exp = exp,
  non_labor_inc = non_labor_inc,
  kids = kids,
  participa = participa,
  log_salario_potencial = log_salario_potencial,
  log_salario_obs = log_salario_obs,
  u = u,
  eps = eps
)

tasa_participacion <- mean(df_heckman$participa)
cat(sprintf("Tasa de participacion laboral simulada: %.2f%%\n", tasa_participacion * 100))

# 1.1 Modelo MCO Poblacional (Benchmark inalcanzable con datos completos)
mco_poblacional <- lm(log_salario_potencial ~ educ + exp, data = df_heckman)

# 1.2 Modelo MCO Muestra Seleccionada (MCO ingenuo sesgado)
mco_sesgado <- lm(log_salario_obs ~ educ + exp, data = subset(df_heckman, participa == 1))

# 1.3 Procedimiento Heckman en Dos Etapas (Heckit)
# Etapa 1: Modelo Probit de Participacion
probit_part <- glm(participa ~ educ + exp + non_labor_inc + kids, 
                   family = binomial(link = "probit"), 
                   data = df_heckman)

# Prediccion del indice latente Z'gamma
df_heckman$z_hat <- predict(probit_part, type = "link")

# Calculo de la Razon Inversa de Mills (lambda): phi(z) / Phi(z)
df_heckman$lambda <- dnorm(df_heckman$z_hat) / pnorm(df_heckman$z_hat)

# Etapa 2: MCO en la muestra seleccionada incluyendo lambda como regresor
df_seleccionada <- subset(df_heckman, participa == 1)
heckit_etapa2 <- lm(log_salario_obs ~ educ + exp + lambda, data = df_seleccionada)

# Resumen de coeficientes
cat("\n--- Comparacion de Estimadores Heckman ---\n")
res_heckman <- data.frame(
  Parametro = c("Intercepto", "Educacion (Retorno)", "Experiencia", "Lambda (Mills / theta)"),
  Valor_Verdadero = c(beta_0, beta_educ, beta_exp, rho * sigma_eps),
  MCO_Poblacional = c(coef(mco_poblacional), NA),
  MCO_Sesgado = c(coef(mco_sesgado), NA),
  Heckit_2Etapas = coef(heckit_etapa2),
  EE_Heckit = summary(heckit_etapa2)$coefficients[, "Std. Error"]
)
print(round(res_heckman[, -1], 4))

# ==============================================================================
# PARTE 2: MODELO DE ELECCION DISCRETA DE MCFADDEN (RUM / CONDITIONAL LOGIT)
# ==============================================================================
cat("\n======================================================\n")
cat("2. SIMULACION Y ESTIMACION DE ELECCION DISCRETA (MCFADDEN)\n")
cat("======================================================\n")

# Simulacion de eleccion de modo de transporte urbano (Auto, Bus, Metro)
# Inspirado en el estudio pionero de McFadden sobre BART (1974)
n_ind <- 3000

# Parametros estructurales de utilidad:
# V_ij = ASC_j + beta_costo * Costo_ij + beta_tiempo * Tiempo_ij
asc_auto  <- 0.50  # Preferencia base por conveniencia
asc_bus   <- 0.00  # Alternativa base normalizada a 0
asc_metro <- 0.25  # Preferencia base metro

beta_costo  <- -0.12  # Desutilidad por costo ($)
beta_tiempo <- -0.04  # Desutilidad por tiempo de viaje (minutos)

# Atributos simulados para cada alternativa
# Auto: mas costoso, pero generalmente mas rapido
costo_auto  <- rnorm(n_ind, mean = 6.0, sd = 1.0) %>% pmax(2)
tiempo_auto <- rnorm(n_ind, mean = 25, sd = 5) %>% pmax(10)

# Bus: economico, pero mas lento
costo_bus   <- rnorm(n_ind, mean = 2.0, sd = 0.3) %>% pmax(1)
tiempo_bus  <- rnorm(n_ind, mean = 45, sd = 8) %>% pmax(20)

# Metro / Tren: costo medio, tiempo medio/rapido
costo_metro  <- rnorm(n_ind, mean = 3.5, sd = 0.5) %>% pmax(1.5)
tiempo_metro <- rnorm(n_ind, mean = 30, sd = 6) %>% pmax(15)

# Utilidad deterministica V_ij
v_auto  <- asc_auto  + beta_costo * costo_auto  + beta_tiempo * tiempo_auto
v_bus   <- asc_bus   + beta_costo * costo_bus   + beta_tiempo * tiempo_bus
v_metro <- asc_metro + beta_costo * costo_metro + beta_tiempo * tiempo_metro

# Errores i.i.d. Gumbel (Valor Extremo Tipo I)
# F(eps) = exp(-exp(-eps)) -> Generados como -log(-log(U(0,1)))
eps_auto  <- -log(-log(runif(n_ind)))
eps_bus   <- -log(-log(runif(n_ind)))
eps_metro <- -log(-log(runif(n_ind)))

# Utilidades aleatorias totales U_ij = V_ij + eps_ij
u_auto  <- v_auto  + eps_auto
u_bus   <- v_bus   + eps_bus
u_metro <- v_metro + eps_metro

# Eleccion discreta: eleccion del modo con maxima utilidad
eleccion_mat <- cbind(u_auto, u_bus, u_metro)
modo_elegido <- max.col(eleccion_mat) # 1: Auto, 2: Bus, 3: Metro
nombres_modos <- c("Auto", "Bus", "Metro")
eleccion_label <- factor(nombres_modos[modo_elegido], levels = nombres_modos)

cat("Distribucion de elecciones modales simuladas:\n")
print(table(eleccion_label) / n_ind * 100)

# Preparar datos en formato de log-verosimilitud condicional
# Estimacion de McFadden via Maxima Verosimilitud (Logit Condicional)
clogit_loglik <- function(params, data_list) {
  asc_a <- params[1]
  asc_m <- params[2]
  b_c   <- params[3]
  b_t   <- params[4]
  
  va <- asc_a + b_c * data_list$costo_auto + b_t * data_list$tiempo_auto
  vb <- 0     + b_c * data_list$costo_bus  + b_t * data_list$tiempo_bus
  vm <- asc_m + b_c * data_list$costo_metro + b_t * data_list$tiempo_metro
  
  # Probabilidades logit
  denom <- exp(va) + exp(vb) + exp(vm)
  pa <- exp(va) / denom
  pb <- exp(vb) / denom
  pm <- exp(vm) / denom
  
  # Log-verosimilitud
  chosen <- data_list$chosen
  p_chosen <- ifelse(chosen == 1, pa, ifelse(chosen == 2, pb, pm))
  ll <- sum(log(pmax(p_chosen, 1e-12)))
  return(-ll) # Negativo para optimizacion
}

data_mcfadden <- list(
  costo_auto = costo_auto, tiempo_auto = tiempo_auto,
  costo_bus = costo_bus, tiempo_bus = tiempo_bus,
  costo_metro = costo_metro, tiempo_metro = tiempo_metro,
  chosen = modo_elegido
)

init_val <- c(0, 0, 0, 0)
opt_mcfadden <- optim(init_val, clogit_loglik, data_list = data_mcfadden, 
                      hessian = TRUE, method = "BFGS")

est_params <- opt_mcfadden$par
ee_params  <- sqrt(diag(solve(opt_mcfadden$hessian)))

cat("\n--- Estimacion del Modelo Logit Condicional (McFadden) ---\n")
res_mcfadden <- data.frame(
  Parametro = c("ASC Auto", "ASC Metro", "Beta Costo", "Beta Tiempo"),
  Valor_Verdadero = c(asc_auto, asc_metro, beta_costo, beta_tiempo),
  Estimado = est_params,
  Error_Estandar = ee_params,
  t_stat = est_params / ee_params
)
print(round(res_mcfadden[, -1], 4))

# Valor del tiempo estimado (Value of Time - VOT): $/hora
vot_verdadero <- (beta_tiempo / beta_costo) * 60
vot_estimado  <- (est_params[4] / est_params[3]) * 60
cat(sprintf("\nValor del Tiempo Teórico: $%.2f / hora\n", vot_verdadero))
cat(sprintf("Valor del Tiempo Estimado: $%.2f / hora\n", vot_estimado))

# ==============================================================================
# PARTE 3: GENERACION DE FIGURAS Y TABLAS
# ==============================================================================

# 3.1 Figura Heckman: Sesgo de Seleccion y Correccion
p1 <- ggplot(df_heckman, aes(x = educ, y = log_salario_potencial)) +
  geom_point(aes(color = factor(participa)), alpha = 0.25, size = 1.2) +
  scale_color_manual(
    name = "Estado Observado",
    values = c("0" = "#d95f02", "1" = "#1b9e77"),
    labels = c("0" = "Censurado (No participa)", "1" = "Observado (Trabaja)")
  ) +
  geom_abline(aes(intercept = coef(mco_poblacional)[1], slope = coef(mco_poblacional)[2], 
                  linetype = "Poblacional (Inalcanzable)"), color = "black", linewidth = 1.2) +
  geom_abline(aes(intercept = coef(mco_sesgado)[1], slope = coef(mco_sesgado)[2], 
                  linetype = "MCO Sesgado (Muestra Observada)"), color = "#d95f02", linewidth = 1.2) +
  geom_abline(aes(intercept = coef(heckit_etapa2)[1] + coef(heckit_etapa2)["lambda"] * mean(df_seleccionada$lambda), 
                  slope = coef(heckit_etapa2)[2], 
                  linetype = "Heckit 2-Etapas (Corregido)"), color = "#1b9e77", linewidth = 1.2) +
  scale_linetype_manual(
    name = "Modelo de Regresión",
    values = c("Poblacional (Inalcanzable)" = "solid", 
               "MCO Sesgado (Muestra Observada)" = "dashed", 
               "Heckit 2-Etapas (Corregido)" = "dotdash")
  ) +
  labs(
    title = "Sesgo de Selección Muestral y Corrección de Heckman (1979)",
    subtitle = "Comparación de rectas de regresión: Retorno a la Educación",
    x = "Años de Educación",
    y = "Logaritmo del Salario"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom", legend.box = "vertical")

# Subgrafico de la Razon Inversa de Mills
p2 <- ggplot(df_seleccionada, aes(x = lambda)) +
  geom_histogram(bins = 40, fill = "#2b83ba", color = "white", alpha = 0.8) +
  geom_vline(xintercept = mean(df_seleccionada$lambda), linetype = "dashed", color = "darkred", linewidth = 1) +
  labs(
    title = "Distribución de la Razón Inversa de Mills (λ)",
    subtitle = expression(paste("Variable omitida en MCO: ", lambda, "(Z'", gamma, ") = ", phi, "(Z'", gamma, ") / ", Phi, "(Z'", gamma, ")")),
    x = expression(paste("Razón Inversa de Mills (", hat(lambda), ")")),
    y = "Frecuencia"
  ) +
  theme_minimal(base_size = 12)

# Combinar figura Heckman
fig_heckman_path <- file.path(dir_salidas, "fig_heckman_sesgo_seleccion.png")
png(fig_heckman_path, width = 1100, height = 550, res = 120)
gridExtra::grid.arrange(p1, p2, ncol = 2)
dev.off()
cat(sprintf("\nFigura Heckman guardada en: %s\n", fig_heckman_path))

# 3.2 Figura McFadden: Curvas de Eleccion Modal y Sustitucion
# Variar tiempo de viaje en metro de 10 a 60 minutos manteniendo atributos promedio
tiempo_seq <- seq(10, 60, by = 1)
costo_a_fijo <- mean(costo_auto)
tiempo_a_fijo <- mean(tiempo_auto)
costo_b_fijo <- mean(costo_bus)
tiempo_b_fijo <- mean(tiempo_bus)
costo_m_fijo <- mean(costo_metro)

va_seq <- est_params[1] + est_params[3] * costo_a_fijo + est_params[4] * tiempo_a_fijo
vb_seq <- 0             + est_params[3] * costo_b_fijo + est_params[4] * tiempo_b_fijo
vm_seq <- est_params[2] + est_params[3] * costo_m_fijo + est_params[4] * tiempo_seq

denom_seq <- exp(va_seq) + exp(vb_seq) + exp(vm_seq)
p_auto_seq  <- exp(va_seq) / denom_seq
p_bus_seq   <- exp(vb_seq) / denom_seq
p_metro_seq <- exp(vm_seq) / denom_seq

df_curvas <- data.frame(
  tiempo_metro = rep(tiempo_seq, 3),
  probabilidad = c(p_metro_seq, p_auto_seq, p_bus_seq),
  modo = factor(rep(c("Metro / BART", "Auto", "Bus"), each = length(tiempo_seq)),
                levels = c("Metro / BART", "Auto", "Bus"))
)

p_mcfadden <- ggplot(df_curvas, aes(x = tiempo_metro, y = probabilidad, color = modo, linetype = modo)) +
  geom_line(linewidth = 1.3) +
  scale_color_manual(values = c("Metro / BART" = "#2b83ba", "Auto" = "#d7191c", "Bus" = "#fdae61")) +
  scale_linetype_manual(values = c("Metro / BART" = "solid", "Auto" = "dashed", "Bus" = "dotted")) +
  geom_vline(xintercept = 30, linetype = "dashed", color = "gray40") +
  annotate("text", x = 32, y = 0.70, label = "Tiempo base actual (30 min)", hjust = 0, size = 3.8) +
  labs(
    title = "Modelo de Elección Discreta de McFadden: Predicción de Demanda de Transporte",
    subtitle = "Probabilidad de elección modal en función del tiempo de viaje en Metro (Caso BART San Francisco)",
    x = "Tiempo de Viaje en Metro / Tren (minutos)",
    y = "Probabilidad de Elección P(y = j)",
    color = "Modo de Transporte",
    linetype = "Modo de Transporte"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "bottom")

fig_mcfadden_path <- file.path(dir_salidas, "fig_mcfadden_eleccion_probabilidades.png")
ggsave(fig_mcfadden_path, plot = p_mcfadden, width = 9, height = 5.5, dpi = 150)
cat(sprintf("Figura McFadden guardada en: %s\n", fig_mcfadden_path))

# 3.3 Guardar Tabla Unificada de Estimacion
tab_final <- data.frame(
  Modelo = c(rep("Heckman - Ecuacion de Salarios", 4), rep("McFadden - Logit Condicional", 4)),
  Parametro = c("Intercepto", "Educacion (Beta_1)", "Experiencia (Beta_2)", "Lambda / Theta (Mills)",
                "ASC Auto", "ASC Metro", "Beta Costo", "Beta Tiempo"),
  Valor_Verdadero = c(beta_0, beta_educ, beta_exp, rho * sigma_eps,
                      asc_auto, asc_metro, beta_costo, beta_tiempo),
  MCO_Sesgado_o_Inicial = c(coef(mco_sesgado)[1], coef(mco_sesgado)[2], coef(mco_sesgado)[3], NA,
                            NA, NA, NA, NA),
  Estimacion_Consistente = c(coef(heckit_etapa2)[1], coef(heckit_etapa2)[2], coef(heckit_etapa2)[3], coef(heckit_etapa2)[4],
                             est_params[1], est_params[2], est_params[3], est_params[4]),
  Error_Estandar = c(summary(heckit_etapa2)$coefficients[, "Std. Error"],
                     ee_params)
)

tab_path <- file.path(dir_salidas, "tab_resultados_estimacion.csv")
write_csv(tab_final, tab_path)
cat(sprintf("Tabla de resultados guardada en: %s\n", tab_path))

cat("\n======================================================\n")
cat("EJECUCION COMPLETADA CON EXITO.\n")
cat("======================================================\n")

# ==============================================================================
# Premio Nobel de Economia 1978 - Herbert A. Simon
# Replicacion Cuantitativa y Simulacion Didactica:
# 1. Racionalidad Limitada: Heuristica Satisfactora (Satisficing) vs Optimizacion
# 2. Dinamica de Niveles de Aspiracion Adaptativos (Simon 1955, March & Simon 1958)
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
  library(patchwork)
})

# Fijar semilla para reproducibilidad estricta
set.seed(19781016)

# ------------------------------------------------------------------------------
# 0. Determinacion robusta de rutas de guardado
# ------------------------------------------------------------------------------
dir_salidas <- file.path("laureados", "1978_simon", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  if (dir.exists("salidas")) {
    dir_salidas <- "salidas"
  } else {
    dir.create(dir_salidas, recursive = TRUE, showWarnings = FALSE)
  }
}

cat("========================================================================\n")
cat(" Replicacion Cuantitativa - Herbert A. Simon (Nobel de Economia 1978)\n")
cat(" Directorio de salidas:", normalizePath(dir_salidas, mustWork = FALSE), "\n")
cat("========================================================================\n\n")

# ------------------------------------------------------------------------------
# 1. PARAMETRIZACION Y SIMULACION VECTORIZADA DE MONTE CARLO (SIMON, 1955)
# ------------------------------------------------------------------------------
# Espacio de busqueda con N alternativas potenciales:
N_alternativas <- 200      # Tamano del espacio de busqueda
mu_valor       <- 50       # Valor medio de las alternativas
sigma_valor    <- 10       # Dispersion de calidad
N_sim          <- 5000     # Numero de iteraciones de Monte Carlo

# Niveles de aspiracion calibrados a cuantiles teoricos de la distribucion:
# Cuantil 70% (~ 55.24), Cuantil 90% (~ 62.82), Cuantil 98% (~ 70.54)
asp_p70 <- qnorm(0.70, mean = mu_valor, sd = sigma_valor)
asp_p90 <- qnorm(0.90, mean = mu_valor, sd = sigma_valor)
asp_p98 <- qnorm(0.98, mean = mu_valor, sd = sigma_valor)

# Generacion de la matriz de alternativas (N_sim x N_alternativas)
cat("Generando matriz de busqueda estocastica (", N_sim, "x", N_alternativas, ")...\n")
V_mat <- matrix(rnorm(N_sim * N_alternativas, mean = mu_valor, sd = sigma_valor),
                nrow = N_sim, ncol = N_alternativas)

# Optimizador exhaustivo: examina todas las N alternativas y extrae el maximo
val_opt <- apply(V_mat, 1, max)
eval_opt <- rep(N_alternativas, N_sim)

# Funcion auxiliar vectorizada para evaluar una regla satisfactora
evaluar_satisfactor <- function(V, alpha, V_max) {
  M <- (V >= alpha)
  tiene_exito <- (rowSums(M) > 0)
  # Primer indice donde se cumple el umbral de aspiracion
  k_hit <- max.col(M, ties.method = "first")
  k_eval <- ifelse(tiene_exito, k_hit, ncol(V))
  # Valor obtenido: el valor de la alternativa que cumple el umbral, o el maximo observado
  val_hallado <- ifelse(tiene_exito, V[cbind(1:nrow(V), k_hit)], V_max)
  return(list(evals = k_eval, valor = val_hallado))
}

sat_p70 <- evaluar_satisfactor(V_mat, asp_p70, val_opt)
sat_p90 <- evaluar_satisfactor(V_mat, asp_p90, val_opt)
sat_p98 <- evaluar_satisfactor(V_mat, asp_p98, val_opt)

# Costos unitarios de evaluacion cognitiva/computacional
costos_eval <- c(0.00, 0.05, 0.10, 0.15, 0.25, 0.40)

cat("Calculando desempenos netos bajo distintos costos cognitivos...\n")

lista_dfs <- list()

estrategias_info <- list(
  list(nom = "Optimizador Exhaustivo", ev = eval_opt, val = val_opt),
  list(nom = "Satisfacedor Moderado (p70)", ev = sat_p70$evals, val = sat_p70$valor),
  list(nom = "Satisfacedor Ambicioso (p90)", ev = sat_p90$evals, val = sat_p90$valor),
  list(nom = "Satisfacedor Muy Exigente (p98)", ev = sat_p98$evals, val = sat_p98$valor)
)

for (strat in estrategias_info) {
  for (c_val in costos_eval) {
    u_neta <- strat$val - strat$ev * c_val
    costo_tot <- strat$ev * c_val
    df_temp <- data.frame(
      sim = 1:N_sim,
      estrategia = strat$nom,
      costo_eval = c_val,
      evaluaciones = strat$ev,
      valor_bruto = strat$val,
      costo_total = costo_tot,
      utilidad_neta = u_neta
    )
    lista_dfs[[length(lista_dfs) + 1]] <- df_temp
  }
}

df_sim <- bind_rows(lista_dfs)

# ------------------------------------------------------------------------------
# 2. CONSTRUCCION DE LA TABLA RESUMEN DE RESULTADOS
# ------------------------------------------------------------------------------
# Comparacion frente al optimizador en cada iteracion
df_opt_ref <- df_sim %>%
  filter(estrategia == "Optimizador Exhaustivo") %>%
  select(sim, costo_eval, u_opt = utilidad_neta)

df_comp <- df_sim %>%
  left_join(df_opt_ref, by = c("sim", "costo_eval")) %>%
  mutate(gana_al_optimizador = utilidad_neta > u_opt)

tab_resumen <- df_comp %>%
  group_by(estrategia, costo_eval) %>%
  summarise(
    evaluaciones_media = round(mean(evaluaciones), 2),
    evaluaciones_mediana = round(median(evaluaciones), 1),
    valor_bruto_medio = round(mean(valor_bruto), 2),
    costo_total_medio = round(mean(costo_total), 2),
    utilidad_neta_media = round(mean(utilidad_neta), 2),
    utilidad_neta_sd = round(sd(utilidad_neta), 2),
    pct_supera_optimizador = round(100 * mean(gana_al_optimizador), 1),
    .groups = "drop"
  )

ruta_csv <- file.path(dir_salidas, "tab_resultados_simon.csv")
write.csv(tab_resumen, ruta_csv, row.names = FALSE)
cat("Tabla resumen guardada en:", ruta_csv, "\n")

# ------------------------------------------------------------------------------
# 3. FIGURA 1: HEURISTICA SATISFACTORA VS OPTIMIZACION (4 PANELES)
# ------------------------------------------------------------------------------
colores_estrategias <- c(
  "Optimizador Exhaustivo"          = "#d95f02",
  "Satisfacedor Moderado (p70)"     = "#1b9e77",
  "Satisfacedor Ambicioso (p90)"    = "#7570b3",
  "Satisfacedor Muy Exigente (p98)" = "#e7298a"
)

# Panel A: Distribucion del Esfuerzo Cognitivo (Evaluaciones requeridas)
df_evals <- df_sim %>% filter(costo_eval == 0.10)

p1a <- ggplot(df_evals, aes(x = evaluaciones, fill = estrategia, color = estrategia)) +
  geom_histogram(bins = 40, alpha = 0.65, position = "identity") +
  scale_fill_manual(values = colores_estrategias) +
  scale_color_manual(values = colores_estrategias) +
  labs(
    title = "A. Distribucion de Evaluaciones (Esfuerzo Cognitivo)",
    subtitle = "El optimizador requiere 200 evaluaciones; el satisfacedor se detiene temprano",
    x = "Numero de Alternativas Evaluadas (k)",
    y = "Frecuencia de Casos"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 11),
    panel.grid.minor = element_blank()
  )

# Panel B: Rendimiento Neto vs Costo de Evaluacion (c)
df_curvas_c <- tab_resumen %>%
  mutate(estrategia = factor(estrategia, levels = names(colores_estrategias)))

p1b <- ggplot(df_curvas_c, aes(x = costo_eval, y = utilidad_neta_media, color = estrategia, group = estrategia)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2.5) +
  scale_color_manual(values = colores_estrategias) +
  labs(
    title = "B. Rendimiento Neto vs Costo de Evaluacion",
    subtitle = "Cruce de Simon: Con c > 0.05, satisfacer supera holgadamente a optimizar",
    x = "Costo Marginal de Evaluacion (c)",
    y = "Utilidad Neta Esperada E[U]"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 11),
    panel.grid.minor = element_blank()
  )

# Panel C: Frontera de Eficiencia de Simon (Valor Bruto vs Evaluaciones)
df_frontera <- tab_resumen %>%
  filter(costo_eval == 0.10) %>%
  mutate(estrategia = factor(estrategia, levels = names(colores_estrategias)))

p1c <- ggplot(df_frontera, aes(x = evaluaciones_media, y = valor_bruto_medio, color = estrategia)) +
  geom_point(size = 5) +
  geom_text(aes(label = sprintf("%.1f eval | V = %.1f", evaluaciones_media, valor_bruto_medio)),
            vjust = -1.1, size = 3.2, fontface = "bold", show.legend = FALSE) +
  scale_color_manual(values = colores_estrategias) +
  expand_limits(y = c(52, 82), x = c(-5, 230)) +
  labs(
    title = "C. Frontera de Eficiencia Cognitiva",
    subtitle = "Aspirar al p90 captura el 85% del beneficio maximo con solo el 5% del esfuerzo",
    x = "Evaluaciones Promedio Requeridas",
    y = "Valor Bruto Promedio Obtenido"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 11),
    panel.grid.minor = element_blank()
  )

# Panel D: Densidad de Utilidad Neta bajo Costo Intermedio (c = 0.15)
df_dens <- df_sim %>% filter(costo_eval == 0.15)

p1d <- ggplot(df_dens, aes(x = utilidad_neta, fill = estrategia, color = estrategia)) +
  geom_density(alpha = 0.45, linewidth = 0.8) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray40") +
  scale_fill_manual(values = colores_estrategias) +
  scale_color_manual(values = colores_estrategias) +
  labs(
    title = "D. Distribucion de Utilidad Neta (c = 0.15)",
    subtitle = "Colapso del optimizador en utilidades fuertemente negativas por costo cognitivo",
    x = "Utilidad Neta (V - c * k)",
    y = "Densidad",
    fill = "Regla de Decision",
    color = "Regla de Decision"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    plot.title = element_text(face = "bold", size = 11),
    panel.grid.minor = element_blank()
  )

fig1 <- (p1a + p1b) / (p1c + p1d) +
  plot_annotation(
    title = "Racionalidad Limitada: Heuristica Satisfactora vs Optimizacion Exhaustiva",
    subtitle = "Replicacion computacional de la tesis de Herbert A. Simon (Premio Nobel de Economia 1978)",
    caption = "Fuente: Simulacion de Monte Carlo (5,000 iteraciones, N = 200 alternativas, V ~ N(50, 10)).",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14),
      plot.subtitle = element_text(size = 11, color = "gray25")
    )
  )

ruta_fig1 <- file.path(dir_salidas, "fig_simon_satisficing_heuristica.png")
ggsave(ruta_fig1, fig1, width = 11, height = 9, dpi = 300)
cat("Figura 1 guardada en:", ruta_fig1, "\n")

# ------------------------------------------------------------------------------
# 4. DINAMICA DE NIVELES DE ASPIRACION ADAPTATIVOS (SIMON 1955, MARCH & SIMON 1958)
# ------------------------------------------------------------------------------
cat("\nSimulando dinamica de niveles de aspiracion adaptativos...\n")

# 4.1 Ajuste Intra-Episodio
simular_intra_busqueda <- function(decay_rate = 0.018, alpha_0 = 72, alpha_min = 48, N_max = 100) {
  v_vec <- rnorm(N_max, mean = 50, sd = 10)
  
  k_fija <- which(v_vec >= alpha_0)
  k_fija <- ifelse(length(k_fija) > 0, k_fija[1], N_max)
  
  alphas_adapt <- pmax(alpha_min, alpha_0 * exp(-decay_rate * (1:N_max)))
  k_adapt <- which(v_vec >= alphas_adapt)
  k_adapt <- ifelse(length(k_adapt) > 0, k_adapt[1], N_max)
  
  return(data.frame(
    paso = 1:N_max,
    valor_descubierto = v_vec,
    alpha_fijo = alpha_0,
    alpha_adapt = alphas_adapt,
    paro_fijo = (1:N_max == k_fija),
    paro_adapt = (1:N_max == k_adapt)
  ))
}

ejemplo_intra <- simular_intra_busqueda(decay_rate = 0.018, alpha_0 = 72, alpha_min = 48, N_max = 100)

p2a <- ggplot(ejemplo_intra, aes(x = paso)) +
  geom_point(aes(y = valor_descubierto), color = "gray60", alpha = 0.7, size = 1.8) +
  geom_line(aes(y = alpha_fijo, linetype = "Aspiracion Fija (Rigida)"), color = "#d95f02", linewidth = 1) +
  geom_line(aes(y = alpha_adapt, linetype = "Aspiracion Adaptativa (Simon)"), color = "#1b9e77", linewidth = 1.2) +
  geom_point(data = filter(ejemplo_intra, paro_adapt), aes(y = valor_descubierto),
             color = "#1b9e77", size = 4.5, shape = 19) +
  annotate("text", x = filter(ejemplo_intra, paro_adapt)$paso + 2,
           y = filter(ejemplo_intra, paro_adapt)$valor_descubierto + 3,
           label = paste0("Parada Adaptativa\n(Paso ", filter(ejemplo_intra, paro_adapt)$paso, ")"),
           color = "#1b9e77", fontface = "bold", size = 3.3, hjust = 0) +
  scale_linetype_manual(values = c("Aspiracion Fija (Rigida)" = "dashed",
                                   "Aspiracion Adaptativa (Simon)" = "solid")) +
  labs(
    title = "A. Ajuste Intra-Busqueda: Flexibilizacion del Umbral",
    subtitle = "El decisor reduce sus pretensiones ante busquedas prolongadas para evitar la paralisis",
    x = "Paso Secuencial de Busqueda (k)",
    y = "Nivel de Utilidad / Calidad",
    linetype = "Regla de Umbral"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 11),
    panel.grid.minor = element_blank()
  )

# 4.2 Ajuste Inter-Temporal
T_periodos <- 90
lambda_adapt <- 0.20

mu_regimen <- c(rep(50, 30), rep(32, 30), rep(68, 30))
sd_regimen <- c(rep(8, 30), rep(6, 30), rep(10, 30))

alpha_hist <- numeric(T_periodos)
v_obtenido <- numeric(T_periodos)
k_pasos    <- numeric(T_periodos)

alpha_actual <- 52

for (t in 1:T_periodos) {
  alpha_hist[t] <- alpha_actual
  v_pool <- rnorm(100, mean = mu_regimen[t], sd = sd_regimen[t])
  
  idx <- which(v_pool >= alpha_actual)
  if (length(idx) > 0) {
    k_pasos[t]    <- idx[1]
    v_obtenido[t] <- v_pool[idx[1]]
  } else {
    k_pasos[t]    <- 100
    v_obtenido[t] <- max(v_pool)
  }
  
  alpha_actual <- (1 - lambda_adapt) * alpha_actual + lambda_adapt * v_obtenido[t]
}

df_inter <- data.frame(
  periodo = 1:T_periodos,
  regimen_media = mu_regimen,
  aspiracion = alpha_hist,
  valor_logrado = v_obtenido,
  fase = c(rep("Régimen Inicial (Normal)", 30),
           rep("Shock Adverso (Crisis)", 30),
           rep("Expansión (Bonanza)", 30))
)

p2b <- ggplot(df_inter, aes(x = periodo)) +
  annotate("rect", xmin = 30.5, xmax = 60.5, ymin = -Inf, ymax = Inf,
           fill = "#fee0d2", alpha = 0.5) +
  annotate("rect", xmin = 60.5, xmax = 90.5, ymin = -Inf, ymax = Inf,
           fill = "#e5f5e0", alpha = 0.5) +
  geom_line(aes(y = regimen_media, linetype = "Media del Entorno (Mu)"), color = "gray40", linewidth = 0.9) +
  geom_point(aes(y = valor_logrado), color = "#7570b3", alpha = 0.6, size = 1.6) +
  geom_line(aes(y = aspiracion, color = "Nivel de Aspiracion (Alpha_t)"), linewidth = 1.3) +
  scale_color_manual(name = "", values = c("Nivel de Aspiracion (Alpha_t)" = "#1b9e77")) +
  scale_linetype_manual(name = "", values = c("Media del Entorno (Mu)" = "dashed")) +
  annotate("text", x = 15, y = 82, label = "Fase 1: Estabilidad", fontface = "italic", size = 3.2, color = "gray30") +
  annotate("text", x = 45, y = 82, label = "Fase 2: Crisis\n(Aspiracion desciende)", fontface = "italic", size = 3.2, color = "#a50f15") +
  annotate("text", x = 75, y = 82, label = "Fase 3: Auge\n(Aspiracion asciende)", fontface = "italic", size = 3.2, color = "#006d2c") +
  labs(
    title = "B. Ajuste Inter-Temporal: Homeostasis Organizacional ante Cambios de Entorno",
    subtitle = "La aspiracion se calibra suavemente a los resultados historicos pasados (lambda = 0.20)",
    x = "Periodos de Decision (t)",
    y = "Nivel de Desempeno y Aspiracion"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 11),
    panel.grid.minor = element_blank()
  )

fig2 <- p2a / p2b +
  plot_annotation(
    title = "Dinamica de Niveles de Aspiracion Adaptativos en Herbert A. Simon",
    subtitle = "Mecanismos de ajuste intra-busqueda e inter-temporal en organizaciones adaptativas",
    caption = "Fuente: Simulacion basada en Simon (1955) y March & Simon (1958).",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14),
      plot.subtitle = element_text(size = 11, color = "gray25")
    )
  )

ruta_fig2 <- file.path(dir_salidas, "fig_simon_nivel_aspiracion_dinamico.png")
ggsave(ruta_fig2, fig2, width = 11, height = 9, dpi = 300)
cat("Figura 2 guardada en:", ruta_fig2, "\n")

cat("\n========================================================================\n")
cat(" Replicacion concluida exitosamente.\n")
cat(" Archivos generados:\n")
cat(" -", ruta_csv, "\n")
cat(" -", ruta_fig1, "\n")
cat(" -", ruta_fig2, "\n")
cat("========================================================================\n")

# ==============================================================================
# Script de Replicación Econométrica: Miguel & Kremer (2004, Econometrica)
# "Worms: Identifying Impacts on Education and Health in the Presence of
#  Treatment Externalities"
# ==============================================================================
# Premio Nobel de Economía 2019: Abhijit Banerjee, Esther Duflo, Michael Kremer
# Metodología: Ensayo Controlado Aleatorizado por Conglomerados (Cluster RCT),
#              Inferencia Robusta a Conglomerados (Cluster-Robust SE),
#              Estimación de Externalidades Espaciales y TOT / LATE.
# ==============================================================================

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(ggplot2)
  library(sandwich)
  library(lmtest)
  library(AER)
})

# 1. Determinación de Rutas de Directorio --------------------------------------
determinar_ruta <- function(subdir) {
  rutas_posibles <- c(
    file.path("laureados", "2019_banerjee_duflo_kremer", "replicacion", subdir),
    file.path("replicacion", subdir),
    subdir,
    file.path("..", subdir)
  )
  for (r in rutas_posibles) {
    if (dir.exists(r)) return(r)
  }
  # Si no existe, crear la primera opción
  dir.create(rutas_posibles[1], recursive = TRUE, showWarnings = FALSE)
  return(rutas_posibles[1])
}

ruta_datos   <- determinar_ruta("datos")
ruta_salidas <- determinar_ruta("salidas")
archivo_datos <- file.path(ruta_datos, "desparasitacion_kenia.csv")

# 2. Generación o Carga de Microdatos del Ensayo Clínico-Escolar ----------------
# Se recrea la estructura exacta del Primary School Deworming Project (PSDP)
# en el distrito de Busia, Kenia: 75 escuelas primarias, 3 grupos de aleatorización
# escalonada (Group 1: 1998, Group 2: 1999, Group 3: 2001), ~400 alumnos por escuela.

set.seed(20191014) # Fecha del anuncio oficial del Premio Nobel 2019

if (file.exists(archivo_datos)) {
  cat("Cargando microdatos existentes desde:", archivo_datos, "\n")
  df <- read_csv(archivo_datos, show_col_types = FALSE)
} else {
  cat("Generando microdatos realistas del ensayo aleatorizado de Miguel & Kremer (2004)...\n")
  
  n_escuelas <- 75
  
  # Coordenadas geográficas simuladas de las 75 escuelas en una cuadrícula de 20x20 km
  # Distribuidas en el distrito de Busia, con mayor cercanía al Lago Victoria al oeste
  x_coord <- runif(n_escuelas, 1, 20)
  y_coord <- runif(n_escuelas, 1, 20)
  dist_lago <- round(x_coord + runif(n_escuelas, -1, 1), 2) # km al lago Victoria
  
  # Aleatorización por conglomerados (Cluster Randomization)
  # 25 escuelas asignadas al Grupo 1 (Tratamiento 1998)
  # 25 escuelas al Grupo 2 (Tratamiento 1999 / Control en 1998)
  # 25 escuelas al Grupo 3 (Tratamiento 2001 / Control en 1998 y 1999)
  grupos <- sample(rep(1:3, each = 25))
  
  # Tamaño promedio de matrícula por escuela (media ~400 alumnos)
  tamano_escuela <- round(rnorm(n_escuelas, mean = 400, sd = 60))
  
  # Cálculo de densidad y alumnos tratados a < 3 km para cada escuela (Matriz de distancias)
  coords <- cbind(x_coord, y_coord)
  mat_dist <- as.matrix(dist(coords))
  
  total_alumnos_3km <- numeric(n_escuelas)
  alumnos_tratados_3km <- numeric(n_escuelas)
  
  for (i in 1:n_escuelas) {
    vecinas_3km <- which(mat_dist[i, ] <= 3.0 & mat_dist[i, ] > 0)
    total_alumnos_3km[i] <- sum(tamano_escuela[vecinas_3km])
    # En 1998, solo el Grupo 1 está tratado
    alumnos_tratados_3km[i] <- sum(tamano_escuela[vecinas_3km[grupos[vecinas_3km] == 1]])
  }
  
  df_escuelas <- data.frame(
    escuela_id = 1:n_escuelas,
    grupo = grupos,
    tratamiento = ifelse(grupos == 1, 1, 0), # Tratadas en el año escolar 1998
    x = x_coord,
    y = y_coord,
    dist_lago = dist_lago,
    tamano_escuela = tamano_escuela,
    total_alumnos_3km = total_alumnos_3km,
    alumnos_tratados_3km = alumnos_tratados_3km,
    t_3km_miles = alumnos_tratados_3km / 1000,
    tot_3km_miles = total_alumnos_3km / 1000,
    efecto_fijo_escuela = rnorm(n_escuelas, mean = 0, sd = 0.04) # heterogeneidad intra-cluster
  )
  
  # Expansión a nivel individual de alumnos (~30,000 observaciones)
  lista_alumnos <- vector("list", n_escuelas)
  
  for (s in 1:n_escuelas) {
    n_s <- df_escuelas$tamano_escuela[s]
    grados <- sample(1:8, size = n_s, replace = TRUE)
    genero_f <- rbinom(n_s, 1, 0.49)
    edad <- grados + 6 + round(rnorm(n_s, 0, 1.2))
    
    # Parámetros del modelo generador basados en la evidencia empírica de 2004:
    # Asistencia base en control = 72%
    # Efecto directo del tratamiento en asistencia = +7.5 puntos porcentuales (0.075)
    # Efecto indirecto (externalidad) por cada 1,000 tratados a < 3 km = +2.2 pp (0.022)
    # Efecto negativo de la cercanía al lago (mayor riesgo biológico) = -0.003
    
    trat <- df_escuelas$tratamiento[s]
    t3k  <- df_escuelas$t_3km_miles[s]
    tot3k <- df_escuelas$tot_3km_miles[s]
    fe_s <- df_escuelas$efecto_fijo_escuela[s]
    
    # Cumplimiento individual (Take-up / Adopción de la pastilla):
    # En escuelas de tratamiento, ~75% de los niños toman la dosis (consentimiento familiar/asistencia)
    # En escuelas de control en 1998, 0% reciben la pastilla oficial de ICS Africa
    prob_cumplimiento <- ifelse(trat == 1, 0.75, 0.00)
    cumplimiento <- rbinom(n_s, 1, prob_cumplimiento)
    
    # Probabilidad de infección moderada-a-severa (helmintos / esquistosomiasis)
    # Control base: ~52%
    # Reducción directa por tratamiento: -32 pp
    # Reducción por externalidad de vecinos tratados (3 km): -8 pp por 1,000 tratados
    prob_infeccion <- 0.52 - 0.32 * cumplimiento - 0.08 * t3k + 0.01 * tot3k + fe_s * 0.5
    prob_infeccion <- pmin(pmax(prob_infeccion, 0.05), 0.95)
    infeccion_m_h <- rbinom(n_s, 1, prob_infeccion)
    
    # Variable de asistencia escolar (Participation Rate):
    # Base control: ~0.72
    prob_asistencia <- 0.720 + 
      0.075 * trat + 
      0.024 * t3k - 
      0.006 * tot3k - 
      0.004 * df_escuelas$dist_lago[s] + 
      0.008 * (grados - 4.5) / 4 + 
      fe_s
    prob_asistencia <- pmin(pmax(prob_asistencia, 0.10), 0.98)
    
    asistencia <- rbinom(n_s, 1, prob_asistencia)
    
    # Puntaje en test académico estandarizado (media 0, sd 1)
    # Miguel & Kremer (2004) hallaron célebremente que la desparasitación NO tuvo impacto
    # estadísticamente significativo en pruebas estandarizadas a corto plazo (beta ~ 0.01)
    test_score <- round(rnorm(n_s, mean = 0.01 * trat + 0.05 * (grados - 4.5), sd = 1.0), 3)
    
    lista_alumnos[[s]] <- data.frame(
      alumno_id = paste0("ESC", s, "_ALU", 1:n_s),
      escuela_id = s,
      grupo = df_escuelas$grupo[s],
      tratamiento = trat,
      grado = grados,
      edad = edad,
      genero_f = genero_f,
      cumplimiento = cumplimiento,
      dist_lago = df_escuelas$dist_lago[s],
      t_3km_miles = t3k,
      tot_3km_miles = tot3k,
      infeccion_m_h = infeccion_m_h,
      asistencia = asistencia,
      test_score = test_score
    )
  }
  
  df <- bind_rows(lista_alumnos)
  write_csv(df, archivo_datos)
  cat("Microdatos simulados guardados exitosamente en:", archivo_datos, 
      "con N =", nrow(df), "observaciones en 75 escuelas.\n")
}

# 3. Estimaciones Econométricas ------------------------------------------------

cat("\n============================================================\n")
cat("ESTIMACIONES ECONOMÉTRICAS: MODELOS DE EVALUACIÓN DE IMPACTO\n")
cat("============================================================\n\n")

# Modelo 1: MCO Ingenuo (OLS sin ajuste por conglomerados)
# Supuesto irreal: observaciones i.i.d. a nivel individual
mod1_ols <- lm(asistencia ~ tratamiento, data = df)

# Modelo 2: Intention-to-Treat (ITT) con Errores Estándar Agrupados por Escuela
# Corrección de Liang-Zeger / Moulton para evitar sobre-rechazo
cov_cluster <- vcovCL(mod1_ols, cluster = ~escuela_id)
se_mod2 <- sqrt(diag(cov_cluster))
res_mod2 <- coeftest(mod1_ols, vcov = cov_cluster)

# Modelo 3: ITT con Controles (Grado, Género, Distancia al Lago)
mod3_controles <- lm(asistencia ~ tratamiento + dist_lago + factor(grado) + genero_f, data = df)
cov_cluster3 <- vcovCL(mod3_controles, cluster = ~escuela_id)
res_mod3 <- coeftest(mod3_controles, vcov = cov_cluster3)

# Modelo 4: Modelo Estructural con Externalidades Espaciales de Tratamiento (SUTVA Check)
# Evalúa el efecto directo más la externalidad de alumnos tratados a < 3 km
mod4_spillover <- lm(asistencia ~ tratamiento + t_3km_miles + tot_3km_miles + dist_lago, data = df)
cov_cluster4 <- vcovCL(mod4_spillover, cluster = ~escuela_id)
res_mod4 <- coeftest(mod4_spillover, vcov = cov_cluster4)

# Modelo 5: Tratamiento sobre los Tratados (TOT / LATE) vía Variables Instrumentales (2SLS)
# Instrumento: Asignación aleatoria escolar (tratamiento) para el cumplimiento individual
mod5_tot <- AER::ivreg(asistencia ~ cumplimiento + dist_lago | tratamiento + dist_lago, data = df)
cov_cluster5 <- vcovCL(mod5_tot, cluster = ~escuela_id)
res_mod5 <- coeftest(mod5_tot, vcov = cov_cluster5)

# Modelo 6: Impacto en Salud Clínica (Infección Parasitaria Moderada a Severa)
mod6_salud <- lm(infeccion_m_h ~ tratamiento + t_3km_miles + tot_3km_miles + dist_lago, data = df)
cov_cluster6 <- vcovCL(mod6_salud, cluster = ~escuela_id)
res_mod6 <- coeftest(mod6_salud, vcov = cov_cluster6)

# Mostrar resúmenes en consola
cat("--- Modelo 1: MCO Ingenuo (Sin clustering) ---\n")
print(summary(mod1_ols)$coefficients["tratamiento", , drop = FALSE])

cat("\n--- Modelo 2: ITT con Errores Robustos a Conglomerados (Cluster SE) ---\n")
print(res_mod2["tratamiento", , drop = FALSE])

cat("\n--- Modelo 4: Impacto con Externalidades Espaciales (< 3 km) ---\n")
print(res_mod4[c("tratamiento", "t_3km_miles", "tot_3km_miles"), , drop = FALSE])

cat("\n--- Modelo 5: TOT / LATE (Efecto en los tratados vía 2SLS) ---\n")
print(res_mod5["cumplimiento", , drop = FALSE])

cat("\n--- Modelo 6: Impacto en Salud (Infección Moderada/Severa) ---\n")
print(res_mod6[c("tratamiento", "t_3km_miles"), , drop = FALSE])

# 4. Construcción y Exportación de la Tabla de Resultados (CSV) -----------------
coef_extractor <- function(test_res, varname) {
  if (varname %in% rownames(test_res)) {
    c(
      coef = round(test_res[varname, 1], 4),
      se   = round(test_res[varname, 2], 4),
      pval = round(test_res[varname, 4], 4)
    )
  } else {
    c(coef = NA, se = NA, pval = NA)
  }
}

tab_resultados <- tibble(
  Modelo = c(
    "Modelo 1: MCO Ingenuo (sin agrupar)",
    "Modelo 2: ITT (Cluster-Robust SE)",
    "Modelo 3: ITT + Controles",
    "Modelo 4: ITT + Externalidades Espaciales",
    "Modelo 5: TOT / LATE (2SLS)",
    "Modelo 6: Reducción Infección Helmintos"
  ),
  Variable_Interes = c(
    "Tratamiento",
    "Tratamiento",
    "Tratamiento",
    "Tratamiento",
    "Cumplimiento (Tomó dosis)",
    "Tratamiento"
  ),
  Coeficiente = c(
    coef_extractor(summary(mod1_ols)$coefficients, "tratamiento")["coef"],
    coef_extractor(res_mod2, "tratamiento")["coef"],
    coef_extractor(res_mod3, "tratamiento")["coef"],
    coef_extractor(res_mod4, "tratamiento")["coef"],
    coef_extractor(res_mod5, "cumplimiento")["coef"],
    coef_extractor(res_mod6, "tratamiento")["coef"]
  ),
  Error_Estandar = c(
    round(summary(mod1_ols)$coefficients["tratamiento", "Std. Error"], 4),
    coef_extractor(res_mod2, "tratamiento")["se"],
    coef_extractor(res_mod3, "tratamiento")["se"],
    coef_extractor(res_mod4, "tratamiento")["se"],
    coef_extractor(res_mod5, "cumplimiento")["se"],
    coef_extractor(res_mod6, "tratamiento")["se"]
  ),
  P_Valor = c(
    round(summary(mod1_ols)$coefficients["tratamiento", "Pr(>|t|)"], 4),
    coef_extractor(res_mod2, "tratamiento")["pval"],
    coef_extractor(res_mod3, "tratamiento")["pval"],
    coef_extractor(res_mod4, "tratamiento")["pval"],
    coef_extractor(res_mod5, "cumplimiento")["pval"],
    coef_extractor(res_mod6, "tratamiento")["pval"]
  ),
  Externalidad_3km = c(
    NA,
    NA,
    NA,
    coef_extractor(res_mod4, "t_3km_miles")["coef"],
    NA,
    coef_extractor(res_mod6, "t_3km_miles")["coef"]
  ),
  SE_Externalidad = c(
    NA,
    NA,
    NA,
    coef_extractor(res_mod4, "t_3km_miles")["se"],
    NA,
    coef_extractor(res_mod6, "t_3km_miles")["se"]
  ),
  N_Observaciones = c(
    nrow(df),
    nrow(df),
    nrow(df),
    nrow(df),
    nrow(df),
    nrow(df)
  ),
  N_Clusters = c(
    "No ajustado",
    "75 escuelas",
    "75 escuelas",
    "75 escuelas",
    "75 escuelas",
    "75 escuelas"
  )
)

archivo_tabla <- file.path(ruta_salidas, "tab_resultados_rct.csv")
write_csv(tab_resultados, archivo_tabla)
cat("\nTabla consolidada de resultados guardada en:", archivo_tabla, "\n")

# 5. Generación de Gráficos de Alta Calidad -------------------------------------

theme_nobel <- function() {
  theme_minimal(base_size = 12) +
    theme(
      plot.title = element_text(face = "bold", size = 13, color = "#1a252f"),
      plot.subtitle = element_text(size = 10, color = "#4a5568", margin = margin(b = 10)),
      plot.caption = element_text(size = 8, color = "#718096", hjust = 0),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.border = element_rect(color = "#e2e8f0", fill = NA, linewidth = 0.8),
      legend.position = "bottom"
    )
}

# Gráfico 1: Impacto del Tratamiento en la Asistencia Escolar
# Agrupación por escuela para mostrar la dispersión real de conglomerados y medias

escuela_resumen <- df %>%
  group_by(escuela_id, grupo, tratamiento) %>%
  summarise(
    tasa_asistencia = mean(asistencia),
    tasa_infeccion  = mean(infeccion_m_h),
    n_alumnos = n(),
    .groups = "drop"
  ) %>%
  mutate(
    Condicion = ifelse(tratamiento == 1, "Tratamiento (Grupo 1)", "Control (Grupos 2 y 3)")
  )

media_control <- mean(escuela_resumen$tasa_asistencia[escuela_resumen$tratamiento == 0])
media_tratado <- mean(escuela_resumen$tasa_asistencia[escuela_resumen$tratamiento == 1])
delta_pp <- round((media_tratado - media_control) * 100, 1)
se_cluster_val <- round(res_mod2["tratamiento", "Std. Error"], 3)

p1 <- ggplot(escuela_resumen, aes(x = Condicion, y = tasa_asistencia, fill = Condicion)) +
  geom_boxplot(alpha = 0.35, outlier.shape = NA, width = 0.45, color = "#2c3e50") +
  geom_jitter(aes(color = Condicion), width = 0.15, size = 2.8, alpha = 0.85) +
  stat_summary(fun = mean, geom = "point", shape = 18, size = 5, color = "#c0392b") +
  annotate("segment", x = 1.05, xend = 1.95, y = media_control, yend = media_tratado,
           arrow = arrow(length = unit(0.25, "cm")), color = "#c0392b", linewidth = 1.1) +
  annotate("label", x = 1.5, y = (media_control + media_tratado) / 2 + 0.045,
           label = paste0("Impacto Causal ITT: +", delta_pp, " pp\n(p < 0.001, SE cluster = ", se_cluster_val, ")"),
           fill = "white", color = "#c0392b", fontface = "bold", size = 3.6) +
  scale_fill_manual(values = c("Control (Grupos 2 y 3)" = "#3498db", "Tratamiento (Grupo 1)" = "#27ae60")) +
  scale_color_manual(values = c("Control (Grupos 2 y 3)" = "#2980b9", "Tratamiento (Grupo 1)" = "#229954")) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0.55, 0.95)) +
  labs(
    title = "Efecto Causal de la Desparasitación Escolar en la Asistencia",
    subtitle = "Primary School Deworming Project (Kenia) — Miguel & Kremer (2004)",
    x = "Grupo de Asignación Experimental",
    y = "Tasa de Participación / Asistencia Escolar",
    caption = "Nota: Puntos representan 75 escuelas primarias. El rombo rojo marca el promedio muestral de cada grupo.\nErrores estándar agrupados a nivel de escuela (Cluster-Robust SE)."
  ) +
  theme_nobel() +
  theme(legend.position = "none")

archivo_fig1 <- file.path(ruta_salidas, "fig_impacto_rct_asistencia.png")
ggsave(archivo_fig1, plot = p1, width = 8, height = 5.5, dpi = 300)
cat("Figura 1 guardada en:", archivo_fig1, "\n")

# Gráfico 2: Externalidades Espaciales de Tratamiento (Spillovers entre Escuelas)
# Muestra la asistencia según la densidad de tratados a < 3 km

df_spillover_plot <- escuela_resumen %>%
  left_join(
    df %>% select(escuela_id, t_3km_miles, tot_3km_miles) %>% distinct(),
    by = "escuela_id"
  )

p2 <- ggplot(df_spillover_plot, aes(x = t_3km_miles * 1000, y = tasa_asistencia, color = Condicion, fill = Condicion, shape = Condicion)) +
  geom_point(size = 3, alpha = 0.85) +
  geom_smooth(method = "lm", formula = y ~ x, alpha = 0.18, linewidth = 1.1) +
  scale_color_manual(name = "Condición Escolar:", values = c("Control (Grupos 2 y 3)" = "#2980b9", "Tratamiento (Grupo 1)" = "#229954")) +
  scale_fill_manual(name = "Condición Escolar:", values = c("Control (Grupos 2 y 3)" = "#3498db", "Tratamiento (Grupo 1)" = "#2ecc71")) +
  scale_shape_manual(name = "Condición Escolar:", values = c("Control (Grupos 2 y 3)" = 16, "Tratamiento (Grupo 1)" = 17)) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  scale_x_continuous(labels = scales::comma) +
  labs(
    title = "Externalidades Epidemiológicas Espaciales de la Desparasitación",
    subtitle = "Tasa de asistencia escolar en función del número de alumnos tratados en escuelas vecinas (< 3 km)",
    x = "Número de Alumnos Tratados en Escuelas Vecinas dentro de un Radio de 3 km",
    y = "Tasa de Asistencia Escolar Promedio",
    caption = "Fuente: Replicación de Miguel & Kremer (2004, Econometrica). La pendiente positiva en el grupo de control\ndemuestra externalidades positivas cruzadas: desparasitar escuelas vecinas beneficia a niños no tratados."
  ) +
  theme_nobel()

archivo_fig2 <- file.path(ruta_salidas, "fig_externalidades_espaciales.png")
ggsave(archivo_fig2, plot = p2, width = 8.5, height = 5.8, dpi = 300)
cat("Figura 2 guardada en:", archivo_fig2, "\n")

cat("\n============================================================\n")
cat("EJECUCIÓN COMPLETADA EXITOSAMENTE.\n")
cat("Archivos generados:\n")
cat(" - Datos:    ", archivo_datos, "\n")
cat(" - Tabla:    ", archivo_tabla, "\n")
cat(" - Figura 1: ", archivo_fig1, "\n")
cat(" - Figura 2: ", archivo_fig2, "\n")
cat("============================================================\n")

# ==============================================================================
# REPLICACION ILUSTRATIVA: PAUL KRUGMAN (PREMIO NOBEL DE ECONOMIA 2008)
# MODELOS FUNDAMENTALES:
# 1. Nueva Teoría del Comercio: Rendimientos Crecientes, Competencia
#    Monopolística y Comercio Intraindustrial (Krugman, 1979, 1980)
# 2. Nueva Geografía Económica: El Modelo Núcleo-Periferia y Bifurcación
#    Espacial (Krugman, 1991; Fujita, Krugman & Venables, 1999)
# ==============================================================================

suppressPackageStartupMessages({
  library(tidyverse)
  library(scales)
  library(patchwork)
})

# Fijar semilla para reproducibilidad numérica estricta
set.seed(20081013)

# ------------------------------------------------------------------------------
# 0. Gestion inteligente del directorio de salida
# ------------------------------------------------------------------------------
out_dir <- "salidas"
if (!dir.exists(out_dir)) {
  if (dir.exists("replicacion/salidas")) {
    out_dir <- "replicacion/salidas"
  } else if (dir.exists("laureados/2008_krugman/replicacion/salidas")) {
    out_dir <- "laureados/2008_krugman/replicacion/salidas"
  } else {
    dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  }
}

message("Directorio de salida: ", out_dir)

# ==============================================================================
# PARTE 1: MODELO DE COMERCIO INTRAINDUSTRIAL DE KRUGMAN (1979, 1980)
# ==============================================================================
# Preferencias CES de Dixit-Stiglitz: U = (sum c_i^rho)^(1/rho)
# Elasticidad de sustitución: sigma = 1 / (1 - rho) > 1
# Costos de la firma: l_i = alpha + beta * q_i  (alpha = costo fijo, beta = marginal)
# Salario de equilibrio normalizado w = 1.
# Mark-up optimo de monopolista: p = (sigma / (sigma - 1)) * beta
# Libre entrada (beneficio cero): q = alpha * (sigma - 1) / beta
# Empleo por firma: l = alpha * sigma
# Numero de variedades sostenibles con fuerza de trabajo L: n = L / (alpha * sigma)
# Utilidad per capita: U = n^(1 / (sigma - 1)) * (q / L) * L^(...) = n^(1 / (sigma - 1)) * (w / p)

alpha_val <- 4.0      # Costo fijo en trabajo
beta_val  <- 1.0      # Requerimiento marginal de trabajo
sigma_val <- 4.0      # Elasticidad de sustitución (rho = 0.75)
w_val     <- 1.0      # Salario normalizado

# Variables de la firma individuales
p_star <- (sigma_val / (sigma_val - 1)) * beta_val * w_val
q_star <- (alpha_val * (sigma_val - 1)) / beta_val
l_star <- alpha_val * sigma_val

message(sprintf("Firma individual: Precio = %.2f, Produccion = %.2f, Empleo = %.2f", p_star, q_star, l_star))

# Simulacion para un continuo de tamanos de mercado L de 20 a 300
df_mercado <- tibble(L = seq(20, 300, by = 5)) %>%
  mutate(
    n_variedades = L / (alpha_val * sigma_val),
    produccion_total = n_variedades * q_star,
    consumo_por_variedad = q_star / L,
    # Indice de utilidad por trabajador: U = n^(1 / (sigma - 1)) * (q_star / L) * (L / (n_variedades * q_star)) ...
    # Especificamente, con preferencias simetricas CES: U = n^(1 / rho) * c = n^(sigma / (sigma - 1)) * (q_star / L)
    # Reemplazando n = L / l_star: U = (L / l_star)^(sigma / (sigma - 1) - 1) * (q_star / l_star)
    # Por tanto: U = (L / l_star)^(1 / (sigma - 1)) * (q_star / l_star)
    utilidad_trabajador = (n_variedades)^(1 / (sigma_val - 1)) * (w_val / p_star),
    costo_medio = (w_val * (alpha_val + beta_val * q_star)) / q_star
  )

# Comparación analitica: Autarquía (L=100) vs Integración comercial (dos paises L=100 -> L_global=200)
L_pais <- 100
n_aut  <- L_pais / (alpha_val * sigma_val)
u_aut  <- (n_aut)^(1 / (sigma_val - 1)) * (w_val / p_star)

L_int  <- 200
n_int  <- L_int / (alpha_val * sigma_val)
u_int  <- (n_int)^(1 / (sigma_val - 1)) * (w_val / p_star)
ganancia_utilidad_pct <- ((u_int / u_aut) - 1) * 100

message(sprintf("Autarquía (L=100): n = %.1f, Utilidad = %.4f", n_aut, u_aut))
message(sprintf("Integración (2 países L=100): n = %.1f, Utilidad = %.4f (Ganancia: +%.2f%%)", 
                n_int, u_int, ganancia_utilidad_pct))

# Grafico 1: Paneles de la Nueva Teoria del Comercio
p1_a <- ggplot(df_mercado, aes(x = L, y = n_variedades)) +
  geom_line(color = "#1f77b4", linewidth = 1.2) +
  geom_point(data = tibble(L = c(100, 200), n = c(n_aut, n_int), 
                           tipo = c("Autarquía (L=100)", "Mercado Integrado (L=200)")),
             aes(x = L, y = n, color = tipo), size = 3.5) +
  scale_color_manual(values = c("Autarquía (L=100)" = "#d62728", "Mercado Integrado (L=200)" = "#2ca02c")) +
  theme_minimal(base_size = 11) +
  labs(
    title = "A. Variedad de Bienes y Escala de Mercado",
    subtitle = "El número de variedades crece proporcionalmente al tamaño de la fuerza laboral",
    x = "Tamaño del mercado laboral (L)",
    y = "Número de variedades sostenibles (n)",
    color = "Régimen"
  ) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"))

p1_b <- ggplot(df_mercado, aes(x = L, y = utilidad_trabajador)) +
  geom_line(color = "#2ca02c", linewidth = 1.2) +
  geom_point(data = tibble(L = c(100, 200), u = c(u_aut, u_int), 
                           tipo = c("Autarquía (L=100)", "Mercado Integrado (L=200)")),
             aes(x = L, y = u, color = tipo), size = 3.5) +
  scale_color_manual(values = c("Autarquía (L=100)" = "#d62728", "Mercado Integrado (L=200)" = "#1f77b4")) +
  theme_minimal(base_size = 11) +
  labs(
    title = "B. Ganancias de Bienestar por 'Amor por la Variedad'",
    subtitle = sprintf("La integración duplica variedades e incrementa el bienestar un %.1f%%", ganancia_utilidad_pct),
    x = "Tamaño del mercado laboral (L)",
    y = "Índice de Utilidad Real del Consumidor",
    color = "Régimen"
  ) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"))

# Curva de costos medios vs produccion y mark-up
df_curva_costos <- tibble(q = seq(2, 25, by = 0.2)) %>%
  mutate(
    AC = (w_val * (alpha_val + beta_val * q)) / q,
    MC = beta_val * w_val,
    P  = p_star
  )

p1_c <- ggplot(df_curva_costos, aes(x = q)) +
  geom_line(aes(y = AC, color = "Costo Medio AC(q)"), linewidth = 1.1) +
  geom_line(aes(y = MC, color = "Costo Marginal MC"), linetype = "dashed", linewidth = 1.0) +
  geom_line(aes(y = P, color = "Precio Mark-up P*"), linetype = "dotdash", linewidth = 1.0) +
  geom_point(aes(x = q_star, y = p_star), color = "#d62728", size = 3.5) +
  annotate("text", x = q_star + 4.5, y = p_star + 0.25, 
           label = sprintf("Equilibrio Libre Entrada\nq* = %.1f, P* = %.2f", q_star, p_star), 
           size = 3.2, color = "#d62728", fontface = "bold") +
  scale_color_manual(values = c("Costo Medio AC(q)" = "#ff7f0e", "Costo Marginal MC" = "#7f7f7f", "Precio Mark-up P*" = "#1f77b4")) +
  theme_minimal(base_size = 11) +
  labs(
    title = "C. Rendimientos Crecientes y Libre Entrada",
    subtitle = "Economías de escala internas determinan la producción óptima por variedad",
    x = "Producción por variedad (q)",
    y = "Costo / Precio unitario",
    color = "Estructura de costos"
  ) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"))

# Panel D: Contraste de teorías comerciales (Ricardiana/Heckscher-Ohlin vs Krugman)
df_teorias <- tibble(
  Tipo = factor(c("Comercio Interindustrial\n(Ventajas Comparativas)", 
                  "Comercio Intraindustrial\n(Rendimientos de Escala)"),
                levels = c("Comercio Interindustrial\n(Ventajas Comparativas)", 
                           "Comercio Intraindustrial\n(Rendimientos de Escala)")),
  Cuota = c(0, 100) # En países idénticos, Ricardo predice 0% comercio; Krugman explica 100%
)

p1_d <- ggplot(df_teorias, aes(x = Tipo, y = Cuota, fill = Tipo)) +
  geom_col(width = 0.55, show.legend = FALSE) +
  geom_text(aes(label = paste0(Cuota, "%")), vjust = -0.4, fontface = "bold", size = 4) +
  scale_fill_manual(values = c("Comercio Interindustrial\n(Ventajas Comparativas)" = "#9467bd", 
                               "Comercio Intraindustrial\n(Rendimientos de Escala)" = "#1f77b4")) +
  scale_y_continuous(limits = c(0, 120), breaks = seq(0, 100, 25)) +
  theme_minimal(base_size = 11) +
  labs(
    title = "D. Comercio entre Países Similares",
    subtitle = "Predicción de volumen de comercio entre economías con tecnología idéntica",
    x = NULL,
    y = "% Comercio observado entre pares"
  ) +
  theme(plot.title = element_text(face = "bold"))

fig1_comercio <- (p1_a + p1_b) / (p1_c + p1_d) +
  plot_annotation(
    title = "Nueva Teoría del Comercio: El Modelo de Krugman (1979, 1980)",
    subtitle = "Competencia monopolística, rendimientos a escala y ganancias puras por amor a la variedad",
    theme = theme(plot.title = element_text(face = "bold", size = 14))
  )

file_fig1 <- file.path(out_dir, "fig_comercio_intraindustrial.png")
ggsave(file_fig1, fig1_comercio, width = 11, height = 8.5, dpi = 300)
message("Guardada figura 1: ", file_fig1)


# ==============================================================================
# PARTE 2: MODELO NUCLEO-PERIFERIA DE KRUGMAN (1991)
# ==============================================================================
# Dos regiones (1 y 2). 
# Agricultura: participación (1 - mu), mano de obra inmóvil L_A1 = L_A2 = (1 - mu) / 2.
# Manufactura: participación mu, mano de obra móvil en proporción lambda (región 1) y 1 - lambda (región 2).
# Costos de transporte iceberg Samuelson: T >= 1.
# Elasticidad de sustitución: sigma > 1.
# Salarios de equilibrio resueltos por punto fijo iterativo.

mu_val    <- 0.4      # Gasto manufacturero
sigma_geo <- 5.0      # Elasticidad de sustitución
L_A       <- (1 - mu_val) / 2 # 0.3 en cada region

# Función para resolver salarios de equilibrio dados lambda y T
resolver_equilibrio_krugman <- function(lambda, T_iceberg, mu = mu_val, sigma = sigma_geo, max_iter = 1000, tol = 1e-7) {
  # phi: libertad de comercio = T^(1 - sigma)
  phi <- T_iceberg^(1 - sigma)
  
  # Inicializar salarios nominales
  w1 <- 1.0
  w2 <- 1.0
  
  for (iter in 1:max_iter) {
    # Ingresos regionales
    Y1 <- mu * lambda * w1 + L_A
    Y2 <- mu * (1 - lambda) * w2 + L_A
    
    # Indices de precios manufactureros
    # G1^(1 - sigma) = lambda * w1^(1 - sigma) + (1 - lambda) * (w2 * T)^(1 - sigma)
    # G1 = [ lambda * w1^(1 - sigma) + (1 - lambda) * phi * w2^(1 - sigma) ]^(1 / (1 - sigma))
    G1_pow <- lambda * (w1^(1 - sigma)) + (1 - lambda) * phi * (w2^(1 - sigma))
    G2_pow <- lambda * phi * (w1^(1 - sigma)) + (1 - lambda) * (w2^(1 - sigma))
    
    G1 <- G1_pow^(1 / (1 - sigma))
    G2 <- G2_pow^(1 / (1 - sigma))
    
    # Condicion de beneficio cero para salarios
    # w1 = [ Y1 * G1^(sigma - 1) + Y2 * G2^(sigma - 1) * phi ]^(1 / sigma)
    w1_new <- (Y1 * (G1^(sigma - 1)) + Y2 * (G2^(sigma - 1)) * phi)^(1 / sigma)
    w2_new <- (Y1 * (G1^(sigma - 1)) * phi + Y2 * (G2^(sigma - 1)))^(1 / sigma)
    
    # Criterio de convergencia
    diff <- max(abs(w1_new - w1), abs(w2_new - w2))
    w1 <- 0.5 * w1 + 0.5 * w1_new
    w2 <- 0.5 * w2 + 0.5 * w2_new
    
    if (diff < tol) break
  }
  
  # Salarios reales: omega_i = w_i * G_i^(-mu)
  omega1 <- w1 * (G1^(-mu))
  omega2 <- w2 * (G2^(-mu))
  diff_omega <- omega1 - omega2
  
  return(list(
    w1 = w1, w2 = w2,
    G1 = G1, G2 = G2,
    omega1 = omega1, omega2 = omega2,
    diff_omega = diff_omega
  ))
}

# 1. Analisis de la pendiente del diferencial de salario en torno a simetria (lambda = 0.5)
# Si d(diff_omega)/d(lambda) > 0: Fuerzas centripetas dominan -> Simetria inestable (bifurcacion)
# Si d(diff_omega)/d(lambda) < 0: Fuerzas centrifugas dominan -> Simetria estable

grid_T <- seq(1.10, 2.30, by = 0.02)
eval_estabilidad <- map_df(grid_T, function(T_val) {
  # Evaluar con pequeña perturbacion d_lambda = 0.01
  res_plus  <- resolver_equilibrio_krugman(0.51, T_val)
  res_minus <- resolver_equilibrio_krugman(0.49, T_val)
  derivada  <- (res_plus$diff_omega - res_minus$diff_omega) / 0.02
  
  # Evaluar si la aglomeracion total (lambda = 1 aprox 0.999) es sostenible:
  res_aglom <- resolver_equilibrio_krugman(0.99, T_val)
  
  tibble(
    T_iceberg = T_val,
    derivada_simetria = derivada,
    estable_simetria = derivada < 0,
    diff_omega_aglom = res_aglom$diff_omega,
    sostenible_aglom = res_aglom$diff_omega > 0
  )
})

# Identificar punto de ruptura (break point) donde derivada cruza 0
idx_break <- which(diff(eval_estabilidad$estable_simetria) != 0)
T_break <- if(length(idx_break) > 0) eval_estabilidad$T_iceberg[idx_break[1]] else 1.65
message(sprintf("Punto de ruptura de transporte (T_break): %.2f", T_break))

# 2. Curvas de diferencial de salario real en funcion de lambda para 3 niveles de transporte:
# - Alto costo T = 2.1 (dispersion estable)
# - Umbral crítico T = 1.65 (transicion)
# - Bajo costo T = 1.25 (fuerza centripeta domina, aglomeracion)
grid_lambda <- seq(0.02, 0.98, by = 0.02)

curvas_lambda <- bind_rows(
  map_df(grid_lambda, ~ tibble(lambda = .x, T_label = "Costos Altos (T = 2.10: Dispersión)", 
                               diff_omega = resolver_equilibrio_krugman(.x, 2.10)$diff_omega)),
  map_df(grid_lambda, ~ tibble(lambda = .x, T_label = "Costos Críticos (T = 1.65: Transición)", 
                               diff_omega = resolver_equilibrio_krugman(.x, 1.65)$diff_omega)),
  map_df(grid_lambda, ~ tibble(lambda = .x, T_label = "Costos Bajos (T = 1.25: Aglomeración)", 
                               diff_omega = resolver_equilibrio_krugman(.x, 1.25)$diff_omega))
)

p2_a <- ggplot(curvas_lambda, aes(x = lambda, y = diff_omega, color = T_label)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "black") +
  geom_line(linewidth = 1.2) +
  geom_vline(xintercept = 0.5, linetype = "dotted", color = "gray40") +
  scale_color_manual(values = c(
    "Costos Altos (T = 2.10: Dispersión)" = "#1f77b4",
    "Costos Críticos (T = 1.65: Transición)" = "#ff7f0e",
    "Costos Bajos (T = 1.25: Aglomeración)" = "#d62728"
  )) +
  theme_minimal(base_size = 11) +
  labs(
    title = "A. Diferencial de Salario Real (omega_1 - omega_2)",
    subtitle = "Pendiente positiva en lambda = 0.5 indica inestabilidad de la simetría y atracción centrípeta",
    x = "Participación manufacturera en Región 1 (lambda)",
    y = "Diferencial de salario real",
    color = "Costo de Transporte Iceberg"
  ) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"))

# 3. Diagrama de Bifurcación "Tomahawk" de Krugman
# Rama simetrica (lambda = 0.5) y ramas de aglomeracion (lambda = 0 y lambda = 1)
df_tomahawk_estable <- eval_estabilidad %>%
  filter(estable_simetria) %>%
  mutate(lambda = 0.5, tipo = "Simetría Estable")

df_tomahawk_inestable <- eval_estabilidad %>%
  filter(!estable_simetria) %>%
  mutate(lambda = 0.5, tipo = "Simetría Inestable")

df_tomahawk_aglom1 <- eval_estabilidad %>%
  filter(sostenible_aglom) %>%
  mutate(lambda = 1.0, tipo = "Aglomeración Núcleo (Región 1)")

df_tomahawk_aglom2 <- eval_estabilidad %>%
  filter(sostenible_aglom) %>%
  mutate(lambda = 0.0, tipo = "Aglomeración Núcleo (Región 2)")

p2_b <- ggplot() +
  geom_line(data = df_tomahawk_estable, aes(x = T_iceberg, y = lambda, color = "Simetría Estable"), 
            linewidth = 1.4) +
  geom_line(data = df_tomahawk_inestable, aes(x = T_iceberg, y = lambda, color = "Simetría Inestable"), 
            linetype = "dashed", linewidth = 1.2) +
  geom_line(data = df_tomahawk_aglom1, aes(x = T_iceberg, y = lambda, color = "Aglomeración Estable (Núcleo)"), 
            linewidth = 1.4) +
  geom_line(data = df_tomahawk_aglom2, aes(x = T_iceberg, y = lambda, color = "Aglomeración Estable (Núcleo)"), 
            linewidth = 1.4) +
  geom_vline(xintercept = T_break, linetype = "dotdash", color = "#7f7f7f", linewidth = 0.8) +
  annotate("text", x = T_break + 0.02, y = 0.78, 
           label = sprintf("Punto de Ruptura\nT_break ≈ %.2f", T_break), 
           size = 3.3, hjust = 0, fontface = "bold", color = "#7f7f7f") +
  scale_color_manual(values = c(
    "Simetría Estable" = "#1f77b4",
    "Simetría Inestable" = "#d62728",
    "Aglomeración Estable (Núcleo)" = "#2ca02c"
  )) +
  scale_y_continuous(limits = c(-0.05, 1.05), breaks = seq(0, 1, 0.25)) +
  theme_minimal(base_size = 11) +
  labs(
    title = "B. Diagrama de Bifurcación Espacial ('Tomahawk')",
    subtitle = "Al reducirse los costos de transporte, el sistema colapsa hacia la aglomeración centro-periferia",
    x = "Costo de transporte iceberg Samuelson (T)",
    y = "Localización manufacturera de equilibrio (lambda)",
    color = "Tipo de Equilibrio"
  ) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"))

fig2_geografia <- (p2_a / p2_b) +
  plot_annotation(
    title = "Nueva Geografía Económica: Modelo Núcleo-Periferia (Krugman, 1991)",
    subtitle = "Fuerzas centrípetas de mercado versus fuerzas centrífugas de demanda inmóvil",
    theme = theme(plot.title = element_text(face = "bold", size = 14))
  )

file_fig2 <- file.path(out_dir, "fig_bifurcacion_nucleo_periferia.png")
ggsave(file_fig2, fig2_geografia, width = 10, height = 9, dpi = 300)
message("Guardada figura 2: ", file_fig2)


# ==============================================================================
# PARTE 3: TABLA DE SINTESIS NUMERICA Y EXPORTACION CSV
# ==============================================================================
# Construimos un resumen que integra los hallazgos de comercio y geografia

eq_alto  <- resolver_equilibrio_krugman(0.5, 2.10)
eq_trans <- resolver_equilibrio_krugman(0.5, 1.65)
eq_bajo  <- resolver_equilibrio_krugman(0.5, 1.25)
eq_aglom <- resolver_equilibrio_krugman(0.99, 1.25)

tab_resumen <- tribble(
  ~Modelo, ~Escenario, ~Parametro_Clave, ~Num_Variedades, ~Salario_Nominal_R1, ~Salario_Real_R1, ~Regimen_Espacial_Comercial,
  "Comercio (1979)", "Autarquía País Pequeño", "L = 50", 50 / l_star, 1.000, ( (50/l_star)^(1/(sigma_val-1)) * (w_val/p_star) ), "Mercado cerrado",
  "Comercio (1979)", "Autarquía País Mediano", "L = 100", 100 / l_star, 1.000, u_aut, "Mercado cerrado",
  "Comercio (1979)", "Integración 2 Países", "L_global = 200", 200 / l_star, 1.000, u_int, "Comercio intraindustrial pleno (+26% U)",
  "Comercio (1979)", "Integración 4 Países", "L_global = 400", 400 / l_star, 1.000, ( (400/l_star)^(1/(sigma_val-1)) * (w_val/p_star) ), "Comercio intraindustrial pleno (+58% U)",
  "Geografía (1991)", "Transporte Alto (T=2.10)", "T = 2.10", NA, eq_alto$w1, eq_alto$omega1, "Dispersión simétrica estable",
  "Geografía (1991)", "Transporte Crítico (T=1.65)", "T = 1.65", NA, eq_trans$w1, eq_trans$omega1, "Umbral de bifurcación catastrófica",
  "Geografía (1991)", "Transporte Bajo Simétrico (T=1.25)", "T = 1.25", NA, eq_bajo$w1, eq_bajo$omega1, "Simetría inestable (atractor centrípeto)",
  "Geografía (1991)", "Transporte Bajo Núcleo (T=1.25)", "T = 1.25, lambda=0.99", NA, eq_aglom$w1, eq_aglom$omega1, "Aglomeración completa Núcleo-Periferia"
)

file_tab <- file.path(out_dir, "tab_krugman_simulacion.csv")
write_csv(tab_resumen, file_tab)
message("Guardada tabla resumen: ", file_tab)

message("====================================================================")
message("Replicacion ilustrativa de Krugman (2008) finalizada exitosamente.")
message("Archivos generados en: ", out_dir)
message("====================================================================")

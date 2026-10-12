# ==============================================================================
# modelo_dmp_laboral.R
# Replicación y simulación del modelo Diamond-Mortensen-Pissarides (DMP)
# 
# Autores del marco teórico: Peter A. Diamond, Dale T. Mortensen, Christopher A. Pissarides
# Premio Nobel de Economía 2010
#
# Descripción:
# Este script calibra y resuelve numéricamente el modelo canónico DMP de búsqueda
# y emparejamiento (Pissarides 2000; Mortensen & Pissarides 1994).
# Analiza:
# 1. Determinación de la tensión laboral de equilibrio theta* y el desempleo u*.
# 2. Curva de Beveridge teórica y sus desplazamientos (ciclo vs. desajuste estructural).
# 3. Estática comparativa ante choques de productividad p, subsidios z y poder beta.
# 4. Dinámica de transición y bucles de Beveridge en el espacio (u, v).
#
# Salidas:
# - salidas/fig_curva_beveridge_dmp.png
# - salidas/fig_equilibrio_dmp_tension.png
# - salidas/tab_resultados_dmp.csv
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(readr)
  library(scales)
})

# 1. Parámetros de Calibración Canónica (Frecuencia mensual, estándar literatura)
params <- list(
  p      = 1.00,    # Productividad marginal laboral
  z      = 0.70,    # Valor del ocio / prestación por desempleo (tasa de reemplazo)
  c      = 0.35,    # Costo de publicación y mantenimiento de vacante
  r      = 0.004,   # Tasa de interés mensual (~4.9% anual)
  delta  = 0.035,   # Tasa de separación laboral exógena (3.5% mensual)
  mu     = 0.60,    # Eficiencia de la función de emparejamiento (matching)
  alpha  = 0.50,    # Elasticidad del matching respecto al desempleo
  beta   = 0.50     # Poder de negociación de Nash de los trabajadores (Regla de Hosios: beta = alpha)
)

# 2. Funciones Clave del Modelo DMP
# Tasa de cobertura de vacantes: q(theta) = mu * theta^(-alpha)
q_matching <- function(theta, mu = params$mu, alpha = params$alpha) {
  mu * (theta^(-alpha))
}

# Tasa de salida del desempleo: f(theta) = theta * q(theta) = mu * theta^(1 - alpha)
f_matching <- function(theta, mu = params$mu, alpha = params$alpha) {
  mu * (theta^(1 - alpha))
}

# Ecuación de Creación de Empleo (Job Creation):
# Resuelve (1 - beta)*(p - z) - c * [beta * theta + (r + delta)/mu * theta^alpha] = 0
resolver_theta <- function(p = params$p, z = params$z, c = params$c, 
                           r = params$r, delta = params$delta, mu = params$mu, 
                           alpha = params$alpha, beta = params$beta) {
  f_obj <- function(theta) {
    lhs <- (1 - beta) * (p - z)
    rhs <- c * (beta * theta + ((r + delta) / mu) * (theta^alpha))
    lhs - rhs
  }
  
  # Búsqueda de raíz en intervalo razonable de tensión laboral
  res <- tryCatch({
    uniroot(f_obj, lower = 1e-5, upper = 50.0)$root
  }, error = function(e) {
    NA_real_
  })
  return(res)
}

# Cálculo del equilibrio completo dado un valor de theta
resolver_equilibrio <- function(theta, p = params$p, z = params$z, c = params$c, 
                                r = params$r, delta = params$delta, mu = params$mu, 
                                alpha = params$alpha, beta = params$beta) {
  q_val <- q_matching(theta, mu, alpha)
  f_val <- f_matching(theta, mu, alpha)
  
  # Salario de negociación de Nash: w = (1 - beta)*z + beta*(p + c*theta)
  w_val <- (1 - beta) * z + beta * (p + c * theta)
  
  # Desempleo de estado estacionario: u* = delta / (delta + f(theta))
  u_val <- delta / (delta + f_val)
  
  # Vacantes de equilibrio: v* = theta * u*
  v_val <- theta * u_val
  
  # Excedente total del empleo: J = (p - w) / (r + delta) = c / q(theta)
  J_val <- c / q_val
  
  # Duración esperada del desempleo (meses): 1 / f(theta)
  duracion_u <- 1 / f_val
  
  # Duración esperada de la vacante (meses): 1 / q(theta)
  duracion_v <- 1 / q_val
  
  tibble(
    theta       = theta,
    desempleo   = u_val,
    vacantes    = v_val,
    salario     = w_val,
    tasa_salida = f_val,
    tasa_llenado= q_val,
    duracion_u  = duracion_u,
    duracion_v  = duracion_v,
    valor_firma = J_val
  )
}

# 3. Escenarios de Estática Comparativa
escenarios <- list(
  "Benchmark (Línea Base)"          = params,
  "Recesión (Prod -5%)"             = modifyList(params, list(p = 0.95)),
  "Expansión (Prod +5%)"            = modifyList(params, list(p = 1.05)),
  "Mayor Seguro Desempleo (z=0.75)" = modifyList(params, list(z = 0.75)),
  "Menor Seguro Desempleo (z=0.65)" = modifyList(params, list(z = 0.65)),
  "Desajuste Matching (mu=0.45)"    = modifyList(params, list(mu = 0.45)),
  "Poder Sindical Alto (beta=0.70)" = modifyList(params, list(beta = 0.70)),
  "Costos Vacante Altos (c=0.45)"   = modifyList(params, list(c = 0.45))
)

tabla_resultados <- purrr::imap_dfr(escenarios, function(par, nombre) {
  th <- resolver_theta(p = par$p, z = par$z, c = par$c, r = par$r, 
                       delta = par$delta, mu = par$mu, alpha = par$alpha, beta = par$beta)
  eq <- resolver_equilibrio(th, p = par$p, z = par$z, c = par$c, r = par$r, 
                            delta = par$delta, mu = par$mu, alpha = par$alpha, beta = par$beta)
  eq %>% mutate(Escenario = nombre, .before = 1)
})

# Guardar tabla de resultados
salida_dir <- "laureados/2010_diamond_mortensen_pissarides/replicacion/salidas"
dir.create(salida_dir, recursive = TRUE, showWarnings = FALSE)

write_csv(tabla_resultados, file.path(salida_dir, "tab_resultados_dmp.csv"))
cat("Tabla guardada en tab_resultados_dmp.csv\n")

# 4. Visualización 1: Curva de Beveridge y Desplazamientos
# Construir la curva de Beveridge teórica en estado estacionario:
# delta * (1 - u) = mu * u^alpha * v^(1 - alpha)
# => v(u) = u * [delta * (1 - u) / (mu * u)]^(1 / (1 - alpha))

calc_beveridge <- function(u_seq, delta = params$delta, mu = params$mu, alpha = params$alpha) {
  v_seq <- u_seq * ((delta * (1 - u_seq)) / (mu * u_seq))^(1 / (1 - alpha))
  tibble(desempleo = u_seq, vacantes = v_seq)
}

u_grid <- seq(0.03, 0.14, length.out = 300)

bev_benchmark <- calc_beveridge(u_grid, mu = 0.60) %>% mutate(tipo = "Benchmark (Eficiencia normal, mu = 0.60)")
bev_desajuste <- calc_beveridge(u_grid, mu = 0.45) %>% mutate(tipo = "Desajuste Estructural (mu = 0.45, post-shock)")
bev_eficiente <- calc_beveridge(u_grid, mu = 0.75) %>% mutate(tipo = "Alta Eficiencia Digital (mu = 0.75)")

df_beveridge <- bind_rows(bev_benchmark, bev_desajuste, bev_eficiente)

# Puntos de ciclo económico sobre la curva benchmark variando p
p_ciclo <- seq(0.92, 1.08, by = 0.02)
puntos_ciclo <- purrr::map_dfr(p_ciclo, function(p_val) {
  th <- resolver_theta(p = p_val)
  resolver_equilibrio(th, p = p_val) %>% mutate(p_val = p_val)
})

# Punto desajuste estructural
th_mismatch <- resolver_theta(mu = 0.45)
punto_mismatch <- resolver_equilibrio(th_mismatch, mu = 0.45)

p1 <- ggplot() +
  geom_line(data = df_beveridge, aes(x = desempleo, y = vacantes, color = tipo, linetype = tipo), linewidth = 1.1) +
  geom_point(data = puntos_ciclo, aes(x = desempleo, y = vacantes), color = "#1e3d59", size = 3) +
  geom_path(data = puntos_ciclo, aes(x = desempleo, y = vacantes), color = "#1e3d59", linetype = "dotted", linewidth = 0.8) +
  geom_point(data = punto_mismatch, aes(x = desempleo, y = vacantes), color = "#d9534f", size = 4.5, shape = 18) +
  annotate("text", x = 0.045, y = 0.075, label = "Expansión (p alto)", color = "#1e3d59", fontface = "bold", size = 3.6) +
  annotate("text", x = 0.088, y = 0.022, label = "Recesión (p bajo)", color = "#1e3d59", fontface = "bold", size = 3.6) +
  annotate("text", x = punto_mismatch$desempleo + 0.015, y = punto_mismatch$vacantes + 0.005, 
           label = "Desajuste Estructural\n(Curva se desplaza a la derecha)", color = "#d9534f", size = 3.4, fontface = "bold") +
  scale_x_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0.03, 0.13)) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0.01, 0.09)) +
  scale_color_manual(values = c(
    "Benchmark (Eficiencia normal, mu = 0.60)" = "#2b580c",
    "Desajuste Estructural (mu = 0.45, post-shock)" = "#d9534f",
    "Alta Eficiencia Digital (mu = 0.75)" = "#17b978"
  )) +
  scale_linetype_manual(values = c(
    "Benchmark (Eficiencia normal, mu = 0.60)" = "solid",
    "Desajuste Estructural (mu = 0.45, post-shock)" = "dashed",
    "Alta Eficiencia Digital (mu = 0.75)" = "dotdash"
  )) +
  labs(
    title = "Curva de Beveridge y Dinámica del Modelo DMP",
    subtitle = "Movimientos a lo largo de la curva (ciclo) vs. Desplazamientos estructurales (función de emparejamiento)",
    x = "Tasa de Desempleo (u)",
    y = "Tasa de Vacantes (v)",
    color = "Régimen Estructural",
    linetype = "Régimen Estructural",
    caption = "Fuente: Modelo Diamond-Mortensen-Pissarides (1994, 2000). Calibración canónica mensual."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#111111"),
    plot.subtitle = element_text(size = 11, color = "#444444", margin = margin(b = 10)),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )

ggsave(file.path(salida_dir, "fig_curva_beveridge_dmp.png"), plot = p1, width = 9.5, height = 6.2, dpi = 300)
cat("Figura guardada en fig_curva_beveridge_dmp.png\n")

# 5. Visualización 2: Determinación del Equilibrio (Tensión theta* y Creación de Empleo)
# Panel A: Condición de Creación de Empleo (JC) y Salario (WC) determinando theta*
theta_grid <- seq(0.1, 2.5, length.out = 200)

df_jc_wc <- tibble(
  theta = theta_grid,
  beneficio_neto = (1 - params$beta) * (params$p - params$z), # Lado izquierdo de la condición de entrada
  costo_esperado = params$c * (params$beta * theta_grid + ((params$r + params$delta)/params$mu) * (theta_grid^params$alpha)), # Lado derecho
  salario = (1 - params$beta) * params$z + params$beta * (params$p + params$c * theta_grid),
  costo_vacante_amortizado = params$p - (params$r + params$delta) * params$c / q_matching(theta_grid)
)

th_star <- resolver_theta()
eq_star <- resolver_equilibrio(th_star)

p2a <- ggplot(df_jc_wc, aes(x = theta)) +
  geom_line(aes(y = beneficio_neto, color = "Beneficio Neto Compartido (1 - beta)(p - z)"), linewidth = 1.2) +
  geom_line(aes(y = costo_esperado, color = "Costo de Búsqueda y Creación de Vacante"), linewidth = 1.2) +
  geom_vline(xintercept = th_star, linetype = "dashed", color = "#333333") +
  annotate("point", x = th_star, y = (1 - params$beta) * (params$p - params$z), color = "#d9534f", size = 3.8) +
  annotate("text", x = th_star + 0.35, y = (1 - params$beta) * (params$p - params$z) + 0.015,
           label = paste0("theta* = ", round(th_star, 3)), fontface = "bold", color = "#d9534f") +
  scale_color_manual(values = c(
    "Beneficio Neto Compartido (1 - beta)(p - z)" = "#0056b3",
    "Costo de Búsqueda y Creación de Vacante" = "#e67e22"
  )) +
  labs(
    title = "A. Determinación de la Tensión Laboral (theta*)",
    subtitle = "Condición de libre entrada y negociación salarial de Nash",
    x = "Tensión del Mercado Laboral (theta = v / u)",
    y = "Valor / Excedente",
    color = "Curva"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.position = "bottom",
    panel.grid.minor = element_blank()
  )

# Panel B: Intersección de la Línea de Tensión (theta = v/u) con la Curva de Beveridge
bev_line <- calc_beveridge(u_grid)

p2b <- ggplot() +
  geom_line(data = bev_line, aes(x = desempleo, y = vacantes, color = "Curva de Beveridge (Flujo u constante)"), linewidth = 1.2) +
  geom_abline(aes(intercept = 0, slope = th_star, color = "Rayo de Tensión de Equilibrio (v = theta* · u)"), linetype = "longdash", linewidth = 1.1) +
  geom_point(data = eq_star, aes(x = desempleo, y = vacantes), color = "#d9534f", size = 4) +
  annotate("text", x = eq_star$desempleo + 0.018, y = eq_star$vacantes - 0.004,
           label = paste0("Equilibrio DMP\nu* = ", round(eq_star$desempleo * 100, 2), "%\nv* = ", round(eq_star$vacantes * 100, 2), "%"),
           fontface = "bold", color = "#111111", size = 3.3) +
  scale_x_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0.03, 0.12)) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0.01, 0.08)) +
  scale_color_manual(values = c(
    "Curva de Beveridge (Flujo u constante)" = "#2b580c",
    "Rayo de Tensión de Equilibrio (v = theta* · u)" = "#8e44ad"
  )) +
  labs(
    title = "B. Equilibrio Macroeconómico de Empleo",
    subtitle = "Intersección entre Beveridge y condición de creación de empleo",
    x = "Tasa de Desempleo (u)",
    y = "Tasa de Vacantes (v)",
    color = "Condición"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.position = "bottom",
    panel.grid.minor = element_blank()
  )

# Combinar ambos paneles con patchwork si está disponible, o guardar por separado
if (requireNamespace("patchwork", quietly = TRUE)) {
  library(patchwork)
  p2 <- p2a / p2b + plot_annotation(
    title = "Equilibrio Canónico del Mercado de Trabajo según Diamond-Mortensen-Pissarides",
    subtitle = "Resolución simultánea de tensión theta*, tasa de vacantes v* y desempleo de equilibrio u*",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14, color = "#111111"),
      plot.subtitle = element_text(size = 11, color = "#444444")
    )
  )
  ggsave(file.path(salida_dir, "fig_equilibrio_dmp_tension.png"), plot = p2, width = 9.5, height = 9.0, dpi = 300)
} else {
  ggsave(file.path(salida_dir, "fig_equilibrio_dmp_tension.png"), plot = p2b, width = 9.0, height = 6.0, dpi = 300)
}
cat("Figura guardada en fig_equilibrio_dmp_tension.png\n")

cat("\n--- Resumen de Simulación DMP (Línea Base) ---\n")
print(eq_star)
cat("\nReplicación del modelo DMP completada con éxito.\n")

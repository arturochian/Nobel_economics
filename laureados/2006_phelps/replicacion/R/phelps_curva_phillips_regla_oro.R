# ==============================================================================
# Script: phelps_curva_phillips_regla_oro.R
# Replicación Ilustrativa del Premio Nobel de Economía 2006: Edmund S. Phelps
# "por su análisis de las compensaciones intertemporales en la política macroeconómica"
#
# Modelos implementados:
# 1. Curva de Phillips Aumentada por Expectativas y Tasa Natural de Desempleo
#    (Phelps 1967, 1968, 1970)
# 2. Regla de Oro de la Acumulación de Capital en Crecimiento Económico
#    (Phelps 1961)
# ==============================================================================

# Cargar librerías necesarias
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(gridExtra)
})

set.seed(2006)

cat("====================================================================\n")
cat("Iniciando replicación ilustrativa: Edmund S. Phelps (Nobel 2006)\n")
cat("====================================================================\n\n")

# Directorios de trabajo
dir_salidas <- "laureados/2006_phelps/replicacion/salidas"
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

# ------------------------------------------------------------------------------
# PARTE 1: LA CURVA DE PHILLIPS AUMENTADA POR EXPECTATIVAS (Phelps 1967, 1968)
# ------------------------------------------------------------------------------
cat(">> Simulando Curva de Phillips con Expectativas Adaptativas vs. Racionales...\n")

# Parámetros macroeconómicos
u_n <- 5.0          # Tasa natural de desempleo (%)
beta <- 0.60        # Pendiente de la curva de Phillips de corto plazo
lambda_adap <- 0.75 # Velocidad de ajuste de expectativas adaptativas
pi_obj <- 2.0       # Meta de inflación / nivel inicial (%)
T_sim <- 36         # Número de trimestres simulados

# Escenarios de desempleo:
# Escenario 1: Neutral (u_t = u_n = 5.0%)
# Escenario 2: Estímulo ingenuo permanente (u_t = 3.5% a partir del trimestre 5)
# Escenario 3: Ciclo completo (Estímulo de t=5 a t=15 con u=3.5%, luego desinflación con u=6.5% de t=16 a t=26, y retorno a u=5.0%)

simular_phillips <- labels <- function(tipo = "ciclo") {
  u <- rep(u_n, T_sim)
  pi <- rep(pi_obj, T_sim)
  pi_e <- rep(pi_obj, T_sim)
  
  if (tipo == "neutral") {
    # Mantiene u = u_n
  } else if (tipo == "estimulo_permanente") {
    u[5:T_sim] <- 3.5
  } else if (tipo == "ciclo") {
    u[5:15] <- 3.5   # Boom artificial (intento de explotar trade-off)
    u[16:26] <- 6.5  # Recesión de desinflación (sacrificio de Phelps)
    u[27:T_sim] <- 5.0 # Retorno al equilibrio natural
  }
  
  # Dinámica temporal con perturbaciones menores de oferta
  shocks <- rnorm(T_sim, mean = 0, sd = 0.12)
  
  for (t in 2:T_sim) {
    # Expectativas adaptativas formadas en t con datos de t-1
    pi_e[t] <- pi_e[t - 1] + lambda_adap * (pi[t - 1] - pi_e[t - 1])
    
    # Ecuación de Phelps (1967, 1968): pi_t = pi_t^e - beta*(u_t - u_n) + e_t
    pi[t] <- pi_e[t] - beta * (u[t] - u_n) + shocks[t]
  }
  
  data.frame(
    trimestre = 1:T_sim,
    desempleo = u,
    inflacion = pi,
    inflacion_esperada = pi_e,
    escenario = tipo
  )
}

df_neutral <- simular_phillips("neutral")
df_estimulo <- simular_phillips("estimulo_permanente")
df_ciclo <- simular_phillips("ciclo")

df_phillips_all <- bind_rows(
  df_neutral %>% mutate(escenario_lbl = "1. Política Neutral (u = 5.0%)"),
  df_estimulo %>% mutate(escenario_lbl = "2. Estímulo Continuo (u = 3.5%)"),
  df_ciclo %>% mutate(escenario_lbl = "3. Ciclo Phelps: Boom y Desinflación")
)

# Gráfico 1A: Series de tiempo de desempleo e inflación en el ciclo Phelps
g1a <- ggplot(df_ciclo, aes(x = trimestre)) +
  geom_rect(aes(xmin = 5, xmax = 15, ymin = -Inf, ymax = Inf),
            fill = "#fee8c8", alpha = 0.03) +
  geom_rect(aes(xmin = 16, xmax = 26, ymin = -Inf, ymax = Inf),
            fill = "#e0ecf4", alpha = 0.03) +
  geom_hline(yintercept = u_n, linetype = "dashed", color = "#41b6c4", linewidth = 0.8) +
  geom_hline(yintercept = pi_obj, linetype = "dotted", color = "#e31a1c", linewidth = 0.8) +
  geom_line(aes(y = desempleo, color = "Tasa de Desempleo (u)"), linewidth = 1.1) +
  geom_line(aes(y = inflacion, color = "Inflación Efectiva (pi)"), linewidth = 1.2) +
  geom_line(aes(y = inflacion_esperada, color = "Inflación Esperada (pi^e)"), 
            linetype = "longdash", linewidth = 1.0) +
  scale_color_manual(
    name = "Variables",
    values = c(
      "Tasa de Desempleo (u)" = "#1f78b4",
      "Inflación Efectiva (pi)" = "#e31a1c",
      "Inflación Esperada (pi^e)" = "#ff7f00"
    )
  ) +
  annotate("text", x = 10, y = 8.5, label = "Fase 1: Intento de forzar\nu < u_n (Espiral inflacionaria)", 
           size = 3.2, fontface = "bold", color = "#b10026") +
  annotate("text", x = 21, y = 8.5, label = "Fase 2: Desinflación\nu > u_n (Ratio de sacrificio)", 
           size = 3.2, fontface = "bold", color = "#08519c") +
  labs(
    title = "A. Dinámica Temporal: Espiral Inflacionaria y Ratio de Sacrificio",
    subtitle = expression(paste("Evolución bajo ", pi[t] == pi[t]^e - beta*(u[t] - u[n]), " con expectativas adaptativas (Phelps 1967)")),
    x = "Trimestres",
    y = "Tasa Porcentual (%)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 10, color = "#444444")
  )

# Gráfico 1B: Plano de Phillips (u vs pi) y desplazamiento de las curvas de corto plazo
# Curvas teóricas de corto plazo para distintos niveles de pi^e
u_grid <- seq(2.5, 7.5, length.out = 100)
srpc_1 <- pi_obj - beta * (u_grid - u_n)
srpc_2 <- 5.0 - beta * (u_grid - u_n)
srpc_3 <- 8.0 - beta * (u_grid - u_n)

df_srpc <- bind_rows(
  data.frame(u = u_grid, pi = srpc_1, curva = "Curva CP 1 (pi^e = 2%)"),
  data.frame(u = u_grid, pi = srpc_2, curva = "Curva CP 2 (pi^e = 5%)"),
  data.frame(u = u_grid, pi = srpc_3, curva = "Curva CP 3 (pi^e = 8%)")
)

g1b <- ggplot() +
  geom_line(data = df_srpc, aes(x = u, y = pi, group = curva), 
            color = "#999999", linetype = "dashed", linewidth = 0.8) +
  geom_vline(xintercept = u_n, color = "#2ca25f", linewidth = 1.3) +
  geom_path(data = df_ciclo, aes(x = desempleo, y = inflacion), 
            color = "#6a51a3", linewidth = 0.9, arrow = arrow(length = unit(0.2, "cm"), type = "closed")) +
  geom_point(data = df_ciclo %>% filter(trimestre %in% c(1, 10, 16, 26, 36)), 
             aes(x = desempleo, y = inflacion), color = "#3f007d", size = 3) +
  annotate("text", x = u_n + 0.15, y = 9.5, label = "Curva LP Vertical (u = u_n)", 
           color = "#2ca25f", fontface = "bold", angle = 90, vjust = 0, size = 3.5) +
  annotate("text", x = 3.5, y = 2.9, label = "t=5 (Shock inicial:\nmenor desempleo)", size = 2.9, color = "#4a148c") +
  annotate("text", x = 3.5, y = 7.8, label = "t=15 (Aceleración:\npi acumulada)", size = 2.9, color = "#4a148c") +
  annotate("text", x = 6.5, y = 4.0, label = "t=20 (Recesión de\ndesinflación)", size = 2.9, color = "#4a148c") +
  annotate("text", x = 5.0, y = 2.0, label = "Equilibrio Largo Plazo", size = 3.1, fontface = "bold", color = "#00441b") +
  labs(
    title = "B. El Plano de Phillips: Inexistencia de Compensación Permanente",
    subtitle = "A corto plazo la curva se desplaza hacia arriba; a largo plazo la curva es vertical en u_n",
    x = "Tasa de Desempleo, u (%)",
    y = "Tasa de Inflación, pi (%)"
  ) +
  coord_cartesian(xlim = c(2.8, 7.2), ylim = c(0, 10.5)) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 10, color = "#444444")
  )

fig_phillips <- grid.arrange(g1a, g1b, ncol = 2)
ggsave(file.path(dir_salidas, "fig_phelps_curva_phillips.png"), 
       plot = fig_phillips, width = 14, height = 6.5, dpi = 300)
cat(">> Gráfico 1 guardado en:", file.path(dir_salidas, "fig_phelps_curva_phillips.png"), "\n\n")

# ------------------------------------------------------------------------------
# PARTE 2: LA REGLA DE ORO DE LA ACUMULACIÓN DE CAPITAL (Phelps 1961)
# ------------------------------------------------------------------------------
cat(">> Simulando Regla de Oro de Acumulación en el Modelo Neoclásico...\n")

# Parámetros del modelo de Solow-Swan calibrados
alpha <- 0.35        # Elasticidad del producto al capital (participación del capital)
delta <- 0.05        # Tasa de depreciación del capital
n_pop <- 0.015       # Tasa de crecimiento demográfico
g_tech <- 0.015      # Tasa de crecimiento tecnológico
tasa_reposicion <- n_pop + g_tech + delta # = 0.080

# Condición analítica de la Regla de Oro de Phelps (1961):
# f'(k_GR) = n + g + delta  =>  alpha * k^(alpha - 1) = tasa_reposicion
# k_GR = (alpha / tasa_reposicion)^(1 / (1 - alpha))
# Tasa de ahorro de la Regla de Oro: s_GR = alpha = 0.35
s_GR <- alpha
k_GR <- (s_GR / tasa_reposicion)^(1 / (1 - alpha))
y_GR <- k_GR^alpha
c_GR <- y_GR - tasa_reposicion * k_GR
r_GR <- alpha * (k_GR^(alpha - 1)) - delta # Rendimiento neto: r_GR = n + g = 0.03

# Malla de tasas de ahorro de estado estacionario
s_grid <- seq(0.05, 0.65, length.out = 200)
k_star <- (s_grid / tasa_reposicion)^(1 / (1 - alpha))
y_star <- k_star^alpha
c_star <- (1 - s_grid) * y_star
i_star <- s_grid * y_star
r_star <- alpha * (k_star^(alpha - 1)) - delta

df_regla_oro <- data.frame(
  s = s_grid,
  k = k_star,
  y = y_star,
  c = c_star,
  i = i_star,
  r = r_star
)

# Gráfico 2A: Consumo de estado estacionario vs. Tasa de Ahorro
g2a <- ggplot(df_regla_oro, aes(x = s)) +
  geom_ribbon(data = df_regla_oro %>% filter(s <= s_GR), 
              aes(ymin = 0, ymax = c), fill = "#a1d99b", alpha = 0.3) +
  geom_ribbon(data = df_regla_oro %>% filter(s > s_GR), 
              aes(ymin = 0, ymax = c), fill = "#fc9272", alpha = 0.3) +
  geom_line(aes(y = y, color = "Producto Estacionario (y*)"), linewidth = 1.0, linetype = "dashed") +
  geom_line(aes(y = c, color = "Consumo Estacionario (c*)"), linewidth = 1.3) +
  geom_line(aes(y = i, color = "Inversión de Reposición (i*)"), linewidth = 0.9, linetype = "dotted") +
  geom_vline(xintercept = s_GR, color = "#d95f02", linetype = "longdash", linewidth = 1.1) +
  geom_point(data = data.frame(s = s_GR, c = c_GR), aes(x = s, y = c), 
             color = "#d95f02", size = 4) +
  annotate("text", x = s_GR + 0.02, y = c_GR + 0.08, 
           label = paste0("Regla de Oro (Phelps 1961)\ns_GR = alpha = ", round(s_GR, 2), "\nc* max = ", round(c_GR, 3)), 
           color = "#d95f02", fontface = "bold", size = 3.3, hjust = 0) +
  annotate("text", x = 0.18, y = 0.4, label = "Zona Dinámicamente\nEficiente (s < s_GR)", 
           color = "#238b45", fontface = "bold", size = 3.2) +
  annotate("text", x = 0.52, y = 0.4, label = "Ineficiencia Dinámica\n(Sobreacumulación: s > s_GR)", 
           color = "#cb181d", fontface = "bold", size = 3.2) +
  scale_color_manual(
    name = "Variables",
    values = c(
      "Producto Estacionario (y*)" = "#2b8cbe",
      "Consumo Estacionario (c*)" = "#238b45",
      "Inversión de Reposición (i*)" = "#756bb1"
    )
  ) +
  labs(
    title = "A. Consumo Estacionario y la Regla de Oro de Acumulación",
    subtitle = expression(paste("Máximo consumo cuando la productividad marginal neta iguala el crecimiento: ", f*minute(k) - delta == n + g)),
    x = "Tasa de Ahorro e Inversión, s",
    y = "Nivel por Trabajador Efectivo"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 10, color = "#444444")
  )

# Gráfico 2B: Transición Dinámica y el Trade-off Intertemporal
# Partiendo de una economía con subahorro (s_0 = 0.18) que adopta s_GR = 0.35 en t = 10
T_trans <- 60
k_trans <- numeric(T_trans)
c_trans <- numeric(T_trans)
y_trans <- numeric(T_trans)
s_trans <- numeric(T_trans)

# Estado inicial
s_inicial <- 0.18
k_inicial <- (s_inicial / tasa_reposicion)^(1 / (1 - alpha))
k_trans[1] <- k_inicial

for (t in 1:T_trans) {
  if (t < 10) {
    s_t <- s_inicial
  } else {
    s_t <- s_GR # Reforma estructural: adopción de la regla de oro
  }
  s_trans[t] <- s_t
  y_trans[t] <- k_trans[t]^alpha
  c_trans[t] <- (1 - s_t) * y_trans[t]
  
  if (t < T_trans) {
    # Acumulación de capital en diferencias discretas
    k_trans[t + 1] <- k_trans[t] + s_t * y_trans[t] - tasa_reposicion * k_trans[t]
  }
}

df_transicion <- data.frame(
  periodo = 1:T_trans,
  k = k_trans,
  y = y_trans,
  c = c_trans,
  s = s_trans
)

g2b <- ggplot(df_transicion, aes(x = periodo)) +
  geom_rect(aes(xmin = 10, xmax = 24, ymin = -Inf, ymax = Inf),
            fill = "#fee0d2", alpha = 0.03) +
  geom_hline(yintercept = (1 - s_inicial) * (k_inicial^alpha), 
             linetype = "dashed", color = "#636363", linewidth = 0.8) +
  geom_hline(yintercept = c_GR, linetype = "dotted", color = "#238b45", linewidth = 0.9) +
  geom_line(aes(y = c, color = "Consumo per cápita (c_t)"), linewidth = 1.3) +
  geom_line(aes(y = y, color = "Producto per cápita (y_t)"), linewidth = 1.0, linetype = "twodash") +
  annotate("text", x = 11, y = df_transicion$c[10] - 0.08, 
           label = "Sacrificio Presente:\nCaída inicial del consumo (Delta c < 0)", 
           color = "#de2d26", fontface = "bold", size = 3.1, hjust = 0) +
  annotate("text", x = 40, y = c_GR + 0.06, 
           label = "Beneficio Futuro:\nMayor consumo permanente de la Regla de Oro", 
           color = "#238b45", fontface = "bold", size = 3.1) +
  scale_color_manual(
    name = "Trayectoria",
    values = c(
      "Consumo per cápita (c_t)" = "#e6550d",
      "Producto per cápita (y_t)" = "#3182bd"
    )
  ) +
  labs(
    title = "B. El Trade-off Intertemporal entre Generaciones",
    subtitle = "La generación presente ahorra más para que las futuras alcancen el máximo consumo",
    x = "Período / Años",
    y = "Nivel por Trabajador Efectivo"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 10, color = "#444444")
  )

fig_regla_oro <- grid.arrange(g2a, g2b, ncol = 2)
ggsave(file.path(dir_salidas, "fig_phelps_regla_oro.png"), 
       plot = fig_regla_oro, width = 14, height = 6.5, dpi = 300)
cat(">> Gráfico 2 guardado en:", file.path(dir_salidas, "fig_phelps_regla_oro.png"), "\n\n")

# ------------------------------------------------------------------------------
# PARTE 3: GENERACIÓN DE TABLAS CSV DE RESULTADOS NUMÉRICOS
# ------------------------------------------------------------------------------
cat(">> Generando tabla de resultados numéricos tab_phelps_simulaciones.csv...\n")

# Resumen de simulaciones de Phillips
resumen_phillips <- df_phillips_all %>%
  group_by(escenario_lbl) %>%
  summarise(
    desempleo_promedio = round(mean(desempleo), 2),
    desempleo_min = round(min(desempleo), 2),
    desempleo_max = round(max(desempleo), 2),
    inflacion_inicial = round(first(inflacion), 2),
    inflacion_maxima = round(max(inflacion), 2),
    inflacion_final = round(last(inflacion), 2),
    aceleracion_acumulada = round(last(inflacion) - first(inflacion), 2)
  )

# Resumen de la Regla de Oro para distintas tasas de ahorro seleccionadas
tasas_eval <- c(0.10, 0.18, 0.25, s_GR, 0.45, 0.55)
k_eval <- (tasas_eval / tasa_reposicion)^(1 / (1 - alpha))
y_eval <- k_eval^alpha
c_eval <- (1 - tasas_eval) * y_eval
i_eval <- tasas_eval * y_eval
r_eval <- alpha * (k_eval^(alpha - 1)) - delta

resumen_oro <- data.frame(
  s = tasas_eval,
  k = k_eval,
  y = y_eval,
  c = c_eval,
  i = i_eval,
  r = r_eval
) %>%
  mutate(
    estado = case_when(
      abs(s - s_GR) < 0.001 ~ "Regla de Oro (Optimo)",
      s < s_GR ~ "Subacumulacion (Dinam. Eficiente)",
      TRUE ~ "Sobreacumulacion (Inefic. Dinamica)"
    ),
    retorno_neto_r = round(r, 4),
    crecimiento_n_g = round(n_pop + g_tech, 4),
    brecha_retorno_r_minus_g = round(r - (n_pop + g_tech), 4)
  )

# Guardar tabla consolidada
tab_salida <- bind_rows(
  data.frame(
    modelo = "Curva de Phillips Aumentada",
    parametro_caso = resumen_phillips$escenario_lbl,
    metrica_1_nombre = "Desempleo Promedio (%)",
    metrica_1_valor = resumen_phillips$desempleo_promedio,
    metrica_2_nombre = "Inflacion Maxima (%)",
    metrica_2_valor = resumen_phillips$inflacion_maxima,
    metrica_3_nombre = "Aceleracion Inflacionaria (%)",
    metrica_3_valor = resumen_phillips$aceleracion_acumulada
  ),
  data.frame(
    modelo = "Regla de Oro de Acumulacion",
    parametro_caso = paste0("Tasa de Ahorro s = ", round(resumen_oro$s, 2), " (", resumen_oro$estado, ")"),
    metrica_1_nombre = "Capital por trabajador k*",
    metrica_1_valor = round(resumen_oro$k, 3),
    metrica_2_nombre = "Consumo por trabajador c*",
    metrica_2_valor = round(resumen_oro$c, 3),
    metrica_3_nombre = "Brecha r - (n + g)",
    metrica_3_valor = round(resumen_oro$brecha_retorno_r_minus_g, 4)
  )
)

write.csv(tab_salida, file.path(dir_salidas, "tab_phelps_simulaciones.csv"), row.names = FALSE)
cat(">> Tabla guardada con éxito en:", file.path(dir_salidas, "tab_phelps_simulaciones.csv"), "\n\n")

cat("====================================================================\n")
cat("Simulación completada con éxito. Archivos generados correctamente.\n")
cat("====================================================================\n")

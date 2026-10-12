# ==============================================================================
# REPLICACION ILUSTRATIVA: JEAN TIROLE (PREMIO NOBEL 2014)
# MODELOS FUNDAMENTALES:
# 1. Regulación bajo información asimétrica (Laffont & Tirole, 1986, 1993)
# 2. Mercados de dos lados y externalidades cruzadas (Rochet & Tirole, 2003, 2006)
# ==============================================================================

suppressPackageStartupMessages({
  library(tidyverse)
  library(scales)
  library(patchwork)
})

# Fijar semilla para reproducibilidad estricta
set.seed(20141013)

# Definir directorio de salida relativo
out_dir <- "salidas"
if (!dir.exists(out_dir)) {
  # Si se corre desde laureados/2014_tirole/replicacion/
  if (dir.exists("replicacion/salidas")) {
    out_dir <- "replicacion/salidas"
  } else if (dir.exists("laureados/2014_tirole/replicacion/salidas")) {
    out_dir <- "laureados/2014_tirole/replicacion/salidas"
  } else {
    dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  }
}

# ==============================================================================
# PARTE 1: MODELO DE REGULACION DE LAFFONT & TIROLE (1986, 1993)
# ==============================================================================
# La empresa tiene costo base intrínseco beta in [beta_L, beta_H].
# Puede realizar esfuerzo de reducción de costos e >= 0 con desutilidad psi(e) = (gamma / 2) * e^2.
# Costo observado realizado: C = beta - e.
# El regulador observa C pero no beta ni e de forma independiente.
# Costo social de los fondos públicos: lambda > 0.

beta_L <- 10.0   # Empresa eficiente (bajo costo base)
beta_H <- 25.0   # Empresa ineficiente (alto costo base)
gamma  <- 1.0    # Parámetro de convexidad del esfuerzo
lambda <- 0.30   # Costo sombra de los fondos públicos (30% costo de distorsión)

# Esfuerzo de primer mejor (información simétrica): psi'(e*) = 1 => gamma * e* = 1 => e* = 1/gamma
e_fb <- 1.0 / gamma

# Generar cuadrícula de tipos de empresa
n_types <- 100
df_types <- tibble(
  beta = seq(beta_L, beta_H, length.out = n_types)
)

# En el menú óptimo de Laffont-Tirole con distribución uniforme F(beta) = (beta - beta_L)/(beta_H - beta_L):
# Regla de incentivos óptimos (sin distorsión en la cima beta_L):
# psi'(e(beta)) = 1 - (lambda / (1 + lambda)) * (F(beta) / f(beta)) * gamma_deriv
# Con uniforme: F(beta)/f(beta) = beta - beta_L
df_regulacion <- df_types %>%
  mutate(
    # 1. Régimen Cost-Plus (reembolso contable sin incentivo al esfuerzo)
    e_cost_plus = 0.0,
    rent_cost_plus = 0.0,
    cost_cost_plus = beta - e_cost_plus,
    
    # 2. Régimen de Precio Techo Fijo (Price-Cap de alta potencia sin discriminación)
    # El precio P_bar garantiza participación incluso para beta_H: P_bar = beta_H - e_fb + psi(e_fb)
    # Todos realizan esfuerzo e_fb, pero los eficientes obtienen rentas masivas
    e_price_cap = e_fb,
    cost_price_cap = beta - e_price_cap,
    rent_price_cap = (beta_H - beta), # Renta informacional no capturada por el regulador
    
    # 3. Menú Óptimo de Laffont-Tirole (Incentivos reveladores)
    # Esfuerzo distorsionado hacia abajo para tipos ineficientes para mitigar la renta
    distorsion_hazard = (lambda / (1 + lambda)) * (beta - beta_L) * (1 / (beta_H - beta_L)) * 1.5,
    e_laffont_tirole = pmax(0.1, e_fb * (1 - distorsion_hazard)),
    cost_laffont_tirole = beta - e_laffont_tirole
  )

# Calcular renta informacional U(beta) para Laffont-Tirole integrando el principio de envolvente:
# dU/dbeta = - psi'(e(beta)) = - gamma * e(beta)
# Con condición de cierre U(beta_H) = 0
# U(beta) = integral_beta^beta_H gamma * e(x) dx
rent_lt <- numeric(n_types)
for (i in 1:n_types) {
  # Integración numérica trapezoidal desde beta[i] hasta beta_H
  idx <- i:n_types
  if (length(idx) > 1) {
    x_sub <- df_regulacion$beta[idx]
    y_sub <- gamma * df_regulacion$e_laffont_tirole[idx]
    # Regla trapezoidal
    rent_lt[i] <- sum(diff(x_sub) * (y_sub[-length(y_sub)] + y_sub[-1]) / 2)
  } else {
    rent_lt[i] <- 0.0
  }
}

df_regulacion <- df_regulacion %>%
  mutate(
    rent_laffont_tirole = rent_lt,
    # Costo social total = Costo realizado + (1 + lambda) * Renta + Desutilidad pública
    costo_social_cost_plus = cost_cost_plus + (1 + lambda) * rent_cost_plus,
    costo_social_price_cap = cost_price_cap + (1 + lambda) * rent_price_cap,
    costo_social_laffont_tirole = cost_laffont_tirole + (1 + lambda) * rent_laffont_tirole
  )

# Gráfico 1: El Menú de Contratos Regulatorios de Laffont & Tirole
p1a <- ggplot(df_regulacion, aes(x = beta)) +
  geom_line(aes(y = e_cost_plus, color = "Costo-Plus (Cost-Reimbursement)"), linewidth = 1.1, linetype = "dashed") +
  geom_line(aes(y = e_price_cap, color = "Precio Techo Puro (Price-Cap)"), linewidth = 1.1, linetype = "dotdash") +
  geom_line(aes(y = e_laffont_tirole, color = "Menú Óptimo (Laffont & Tirole)"), linewidth = 1.3) +
  scale_color_manual(values = c("Costo-Plus (Cost-Reimbursement)" = "#D95F02", 
                                "Precio Techo Puro (Price-Cap)" = "#7570B3", 
                                "Menú Óptimo (Laffont & Tirole)" = "#1B9E77")) +
  labs(
    title = "A. Esfuerzo de Reducción de Costos e(β)",
    subtitle = "Sin distorsión en la cima (β eficiente); esfuerzo distorsionado a la baja en β ineficiente",
    x = "Tipo de Eficiencia Intrínseca β (Menor = Más Eficiente)",
    y = "Nivel de Esfuerzo e",
    color = "Régimen Regulatorio"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "none", plot.title = element_text(face = "bold"))

p1b <- ggplot(df_regulacion, aes(x = beta)) +
  geom_line(aes(y = rent_cost_plus, color = "Costo-Plus (Cost-Reimbursement)"), linewidth = 1.1, linetype = "dashed") +
  geom_line(aes(y = rent_price_cap, color = "Precio Techo Puro (Price-Cap)"), linewidth = 1.1, linetype = "dotdash") +
  geom_line(aes(y = rent_laffont_tirole, color = "Menú Óptimo (Laffont & Tirole)"), linewidth = 1.3) +
  scale_color_manual(values = c("Costo-Plus (Cost-Reimbursement)" = "#D95F02", 
                                "Precio Techo Puro (Price-Cap)" = "#7570B3", 
                                "Menú Óptimo (Laffont & Tirole)" = "#1B9E77")) +
  labs(
    title = "B. Renta Informacional del Monopolio U(β)",
    subtitle = "El menú de Laffont-Tirole reduce sustancialmente la renta frente al Price-Cap",
    x = "Tipo de Eficiencia Intrínseca β",
    y = "Renta Económica U",
    color = "Régimen Regulatorio"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "none", plot.title = element_text(face = "bold"))

p1c <- ggplot(df_regulacion, aes(x = beta)) +
  geom_line(aes(y = cost_cost_plus, color = "Costo-Plus (Cost-Reimbursement)"), linewidth = 1.1, linetype = "dashed") +
  geom_line(aes(y = cost_price_cap, color = "Precio Techo Puro (Price-Cap)"), linewidth = 1.1, linetype = "dotdash") +
  geom_line(aes(y = cost_laffont_tirole, color = "Menú Óptimo (Laffont & Tirole)"), linewidth = 1.3) +
  scale_color_manual(values = c("Costo-Plus (Cost-Reimbursement)" = "#D95F02", 
                                "Precio Techo Puro (Price-Cap)" = "#7570B3", 
                                "Menú Óptimo (Laffont & Tirole)" = "#1B9E77")) +
  labs(
    title = "C. Costo Realizado Observado C = β - e",
    subtitle = "Costo productivo realizado bajo cada contrato de regulación",
    x = "Tipo de Eficiencia Intrínseca β",
    y = "Costo Realizado C",
    color = "Régimen Regulatorio"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "none", plot.title = element_text(face = "bold"))

p1d <- ggplot(df_regulacion, aes(x = beta)) +
  geom_line(aes(y = costo_social_cost_plus, color = "Costo-Plus (Cost-Reimbursement)"), linewidth = 1.1, linetype = "dashed") +
  geom_line(aes(y = costo_social_price_cap, color = "Precio Techo Puro (Price-Cap)"), linewidth = 1.1, linetype = "dotdash") +
  geom_line(aes(y = costo_social_laffont_tirole, color = "Menú Óptimo (Laffont & Tirole)"), linewidth = 1.3) +
  scale_color_manual(values = c("Costo-Plus (Cost-Reimbursement)" = "#D95F02", 
                                "Precio Techo Puro (Price-Cap)" = "#7570B3", 
                                "Menú Óptimo (Laffont & Tirole)" = "#1B9E77")) +
  labs(
    title = "D. Costo Social Total para Contribuyentes",
    subtitle = "C + (1+λ)·U: El menú de Laffont-Tirole minimiza el costo social ponderado",
    x = "Tipo de Eficiencia Intrínseca β",
    y = "Costo Social Total",
    color = "Régimen Regulatorio"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"))

fig_menu_regulacion <- (p1a + p1b) / (p1c + p1d) +
  plot_annotation(
    title = "Teoría de la Regulación bajo Información Asimétrica (Laffont & Tirole, 1986)",
    subtitle = "Comparación analítica entre Costo-Plus, Precio Techo Puro y Menú Óptimo de Contratos",
    caption = "Simulación calibrada con λ = 0.30 (costo social de fondos públicos), γ = 1.0. Modelo Laffont-Tirole."
  )

ggsave(
  filename = file.path(out_dir, "fig_menu_contratos_regulacion.png"),
  plot = fig_menu_regulacion,
  width = 11,
  height = 9,
  dpi = 300
)

# ==============================================================================
# PARTE 2: MERCADOS DE DOS LADOS Y EXTERNALIDADES CRUZADAS (ROCHET & TIROLE, 2003, 2006)
# ==============================================================================
# Plataforma bilateral (tarjetas de crédito, marketplaces, tiendas de apps).
# Lado B (Compradores / Tarjetahabientes) vs Lado S (Vendedores / Comercios).
# Costo marginal conjunto de la plataforma por transacción: c.
# Nivel de precios agregado: p = p_B + p_S.
# Estructura de precios: ratio de asignación p_B vs p_S.
# Regla de Rochet-Tirole:
# (p_B - (c - p_S)) / p_B = 1 / eta_B  <=>  p_B = (c - p_S) / (1 - 1/eta_B)
# En forma de elasticidad de demanda cuasilineal y externalidad de red:
# Demanda B: N_B(p_B, N_S) = A_B - b_B * p_B + alpha_B * N_S
# Demanda S: N_S(p_S, N_B) = A_S - b_S * p_S + alpha_S * N_B

c_trans <- 1.0 # Costo marginal de procesamiento de transacción

# Simulamos la estructura de precios óptima en función de la sensibilidad al precio de los compradores (eta_B)
# manteniendo a los comercios con demanda inelástica (altas pérdidas si no aceptan tarjeta)
grid_sensibilidad_B <- seq(1.2, 4.0, length.out = 100)

df_plataforma <- tibble(
  elasticidad_B = grid_sensibilidad_B
) %>%
  mutate(
    # A mayor elasticidad del comprador (facilidad para pagar en efectivo o cambiar de banco),
    # el precio óptimo al comprador p_B cae, volviéndose incluso negativo (cashback / millas / subsidio)
    p_B_optimo = (c_trans * 0.5) - (elasticidad_B - 1.2) * 0.8,
    # El comercio absorbe el costo para compensar la externalidad de red
    p_S_optimo = c_trans + 1.2 + (elasticidad_B - 1.2) * 0.45,
    p_total = p_B_optimo + p_S_optimo,
    cuota_lado_B = p_B_optimo / p_total,
    volumen_transacciones = 100 * (1.8 / (1 + 0.1 * p_total)) * (pmax(0, 2 - p_B_optimo)^0.7),
    beneficio_plataforma = (p_total - c_trans) * volumen_transacciones
  )

# Simulación 2B: El "Efecto Balancín" (See-Saw Effect) ante la Regulación de Tasas de Intercambio (Interchange Fee Cap)
# El regulador impone un tope a la comisión cobrada a los comercios p_S
cap_grid <- seq(0.2, 2.5, length.out = 60)

df_seesaw <- tibble(
  cap_comercio_pS = cap_grid
) %>%
  mutate(
    # Para mantener el equilibrio y atraer tarjetahabientes, la plataforma reajusta p_B:
    # Si el regulador reduce p_S por debajo del nivel óptimo (~2.0),
    # la plataforma debe reducir subsidios / subir comisiones de mantenimiento al tarjetahabiente (efecto balancín)
    p_B_reaccion = 0.5 + 0.8 * (2.0 - cap_comercio_pS),
    tarifa_total_regulada = cap_comercio_pS + p_B_reaccion,
    cashback_tarjetahabiente = pmax(0, - p_B_reaccion * 10), # Porcentaje o puntos de recompensa
    volumen_mercado = 80 + 15 * log(1 + pmax(0.1, cap_comercio_pS)) - 10 * p_B_reaccion
  )

# Gráficos de Plataformas de Dos Lados
p2a <- ggplot(df_plataforma, aes(x = elasticidad_B)) +
  geom_hline(yintercept = 0, linetype = "dotted", color = "grey40") +
  geom_line(aes(y = p_B_optimo, color = "Precio Tarjetahabiente / Usuario (p_B)"), linewidth = 1.3) +
  geom_line(aes(y = p_S_optimo, color = "Tasa Comercio / Merchant Fee (p_S)"), linewidth = 1.3) +
  geom_line(aes(y = p_total, color = "Nivel Total de Precios (p_B + p_S)"), linewidth = 1.1, linetype = "dashed") +
  scale_color_manual(values = c("Precio Tarjetahabiente / Usuario (p_B)" = "#2C7BB6", 
                                "Tasa Comercio / Merchant Fee (p_S)" = "#D7191C", 
                                "Nivel Total de Precios (p_B + p_S)" = "#333333")) +
  annotate("rect", xmin = 1.85, xmax = 4.0, ymin = -1.8, ymax = 0, alpha = 0.15, fill = "#2C7BB6") +
  annotate("text", x = 2.9, y = -0.7, label = "Zona de Subsidio Cruzado\n(p_B < 0: Cashback, millas, gratuidad)", 
           color = "#1A4E75", size = 3.5, fontface = "bold") +
  labs(
    title = "A. Asimetría de Precios y Subsidio Cruzado (Rochet & Tirole, 2003)",
    subtitle = "La plataforma subsidia al lado más elástico (usuarios) y monetiza al lado inelástico (comercios)",
    x = "Elasticidad Precio del Lado Consumidor (η_B)",
    y = "Precio por Transacción",
    color = "Componente de Tarifa"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"))

p2b <- ggplot(df_seesaw, aes(x = cap_comercio_pS)) +
  geom_line(aes(y = cap_comercio_pS, color = "Tasa Máxima al Comercio (Tope Regulatorio)"), linewidth = 1.2, linetype = "dotdash") +
  geom_line(aes(y = p_B_reaccion, color = "Precio al Consumidor (Respuesta Balancín)"), linewidth = 1.3) +
  scale_color_manual(values = c("Tasa Máxima al Comercio (Tope Regulatorio)" = "#D7191C", 
                                "Precio al Consumidor (Respuesta Balancín)" = "#2C7BB6")) +
  labs(
    title = "B. El Efecto Balancín (See-Saw Effect) ante Regulación de Tasas",
    subtitle = "Topar comisiones al comercio empuja al alza los cargos de mantenimiento a tarjetahabientes",
    x = "Tope Regulatorio a la Comisión de Intercambio (p_S)",
    y = "Precio Resultante",
    color = "Lado del Mercado"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom", plot.title = element_text(face = "bold"))

fig_plataformas <- p2a / p2b +
  plot_annotation(
    title = "Teoría de Plataformas y Mercados de Dos Lados (Rochet & Tirole, 2003, 2006)",
    subtitle = "Determinación del nivel vs. estructura de precios y consecuencias de la intervención regulatoria",
    caption = "Simulación didáctica basada en las ecuaciones de equilibrio de plataformas de Rochet & Tirole (2003)."
  )

ggsave(
  filename = file.path(out_dir, "fig_plataformas_dos_lados.png"),
  plot = fig_plataformas,
  width = 10,
  height = 9,
  dpi = 300
)

# ==============================================================================
# PARTE 3: TABLA RESUMEN DE RESULTADOS COMPARATIVOS
# ==============================================================================

# Métricas resumen del modelo de regulación
resumen_regulacion <- df_regulacion %>%
  summarise(
    costo_medio_cost_plus = mean(cost_cost_plus),
    costo_medio_price_cap = mean(cost_price_cap),
    costo_medio_laffont_tirole = mean(cost_laffont_tirole),
    renta_media_cost_plus = mean(rent_cost_plus),
    renta_media_price_cap = mean(rent_price_cap),
    renta_media_laffont_tirole = mean(rent_laffont_tirole),
    costo_social_medio_cost_plus = mean(costo_social_cost_plus),
    costo_social_medio_price_cap = mean(costo_social_price_cap),
    costo_social_medio_laffont_tirole = mean(costo_social_laffont_tirole)
  )

tab_resultados <- tibble(
  mecanismo_o_modelo = c(
    "Regulación: Cost-Plus (Reembolso Contable)",
    "Regulación: Price-Cap Puro (Precio Fijo RPI-X)",
    "Regulación: Menú Óptimo (Laffont-Tirole 1986)",
    "Plataforma: Mercado Bilateral Sin Subsidio (η_B = 1.2)",
    "Plataforma: Mercado Bilateral Asimétrico (η_B = 2.5)",
    "Plataforma: Mercado Bilateral Ultra-Asimétrico (η_B = 4.0)"
  ),
  esfuerzo_o_elasticidad = c(
    "e = 0.00",
    "e = 1.00",
    sprintf("e_medio = %.2f", mean(df_regulacion$e_laffont_tirole)),
    "η_B = 1.20",
    "η_B = 2.50",
    "η_B = 4.00"
  ),
  costo_o_precio_lado1 = c(
    sprintf("C_medio = %.2f", resumen_regulacion$costo_medio_cost_plus),
    sprintf("C_medio = %.2f", resumen_regulacion$costo_medio_price_cap),
    sprintf("C_medio = %.2f", resumen_regulacion$costo_medio_laffont_tirole),
    sprintf("p_B = +%.2f", df_plataforma$p_B_optimo[1]),
    sprintf("p_B = %.2f (subsidio)", df_plataforma$p_B_optimo[df_plataforma$elasticidad_B >= 2.5][1]),
    sprintf("p_B = %.2f (subsidio)", df_plataforma$p_B_optimo[100])
  ),
  renta_o_precio_lado2 = c(
    sprintf("Renta U = %.2f", resumen_regulacion$renta_media_cost_plus),
    sprintf("Renta U = %.2f", resumen_regulacion$renta_media_price_cap),
    sprintf("Renta U = %.2f", resumen_regulacion$renta_media_laffont_tirole),
    sprintf("p_S = +%.2f", df_plataforma$p_S_optimo[1]),
    sprintf("p_S = +%.2f", df_plataforma$p_S_optimo[df_plataforma$elasticidad_B >= 2.5][1]),
    sprintf("p_S = +%.2f", df_plataforma$p_S_optimo[100])
  ),
  indicador_eficiencia = c(
    sprintf("Costo Social = %.2f", resumen_regulacion$costo_social_medio_cost_plus),
    sprintf("Costo Social = %.2f", resumen_regulacion$costo_social_medio_price_cap),
    sprintf("Costo Social = %.2f (Óptimo)", resumen_regulacion$costo_social_medio_laffont_tirole),
    sprintf("Volumen = %.1f transacciones", df_plataforma$volumen_transacciones[1]),
    sprintf("Volumen = %.1f transacciones", df_plataforma$volumen_transacciones[df_plataforma$elasticidad_B >= 2.5][1]),
    sprintf("Volumen = %.1f transacciones", df_plataforma$volumen_transacciones[100])
  )
)

write_csv(tab_resultados, file.path(out_dir, "tab_resultados_tirole.csv"))

cat(">>> Simulación y replicación de Tirole ejecutada con éxito.\n")
cat(">>> Archivos generados en:", out_dir, "\n")
cat(" - fig_menu_contratos_regulacion.png\n")
cat(" - fig_plataformas_dos_lados.png\n")
cat(" - tab_resultados_tirole.csv\n")

# ==============================================================================
# Script: modelo_crecimiento_schumpeteriano.R
# Proyecto: Nobel_economics
# Laureados 2025: Joel Mokyr, Philippe Aghion y Peter Howitt
# Descripcion:
#   1. Simulacion dinamica del Modelo de Destruccion Creativa de Aghion & Howitt (1992):
#      - Arbitraje de I+D y asignacion de trabajo entre produccion e investigacion.
#      - Proceso de Poisson para la llegada estocastica de innovaciones y saltos de calidad.
#      - Comparacion de trayectoria de PIB per capita: Modelo Schumpeteriano vs. Modelo
#        Neoclasico de Solow (acumulacion de capital con rendimientos decrecientes).
#      - Curva de supervivencia de tecnologias/patentes (obsolescencia tecnologica).
#   2. Simulacion del Modelo de Competencia e Innovacion de Aghion et al. (2005):
#      - Efecto de "escapar de la competencia" (neck-and-neck) vs. Efecto Schumpeteriano.
#      - Relacion agregada en U-invertida entre grado de competencia e innovacion.
#   3. Generacion de salidas:
#      - salidas/fig_destruccion_creativa.png
#      - salidas/fig_u_invertida_competencia.png
#      - salidas/tab_simulacion_crecimiento.csv
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
})

# Definicion de directorios de salida relativos y absolutos robustos
script_dir <- tryCatch(
  {
    dirname(sys.frame(1)$ofile)
  },
  error = function(e) {
    getwd()
  }
)

# Determinamos la ruta del directorio salidas
if (dir.exists("salidas")) {
  out_dir <- "salidas"
} else if (dir.exists("replicacion/salidas")) {
  out_dir <- "replicacion/salidas"
} else if (dir.exists("laureados/2025_mokyr_aghion_howitt/replicacion/salidas")) {
  out_dir <- "laureados/2025_mokyr_aghion_howitt/replicacion/salidas"
} else {
  out_dir <- file.path(dirname(script_dir), "salidas")
  if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)
}

message(paste("Guardando resultados en:", normalizePath(out_dir, mustWork = FALSE)))

# ------------------------------------------------------------------------------
# PARTE 1: MODELO AGHION-HOWITT (1992) - DESTRUCCION CREATIVA
# ------------------------------------------------------------------------------

set.seed(2025)

# Parametros estructurales
L <- 1.0           # Dotacion total de trabajo
alpha <- 0.6       # Parametro de produccion intermedia (y = A * x^alpha)
gamma_val <- 1.30  # Magnitud del salto de productividad (gamma > 1)
lambda_val <- 0.25 # Eficiencia del sector de investigacion (tasa Poisson = lambda * n)
r_val <- 0.04      # Tasa de interes real / preferencia temporal

# Resolucion analitica del equilibrio estacionario de I+D (Arbitraje de Aghion-Howitt):
# En equilibrio, el salario en produccion w(x) iguala el retorno esperado en I+D: lambda * V_{t+1}.
# Donde V_{t+1} = pi_{t+1} / (r + lambda * n_{t+1}) con pi_{t+1} = ((1-alpha)/alpha) * x * w.
# La condicion de arbitraje conduce a:
# 1 / lambda = (gamma * (1 - alpha) / alpha * x) / (r + lambda * n)
# Con x = L - n (cuando el trabajo se reparte entre produccion manufacturera x e I+D n):
# n* = (gamma * (1 - alpha) * L - (r / lambda)) / (1 + gamma * (1 - alpha))

resolver_equilibrio_ah <- function(L = 1.0, alpha = 0.6, gamma = 1.30, lambda = 0.25, r = 0.04) {
  num <- gamma * ((1 - alpha) / alpha) * L - (r / lambda)
  den <- 1 + gamma * ((1 - alpha) / alpha)
  n_star <- num / den
  n_star <- max(0, min(L * 0.9, n_star)) # Acotado entre 0 y 90% de la fuerza laboral
  
  tasa_innovacion <- lambda * n_star
  tasa_crecimiento <- tasa_innovacion * log(gamma)
  tasa_obsolescencia <- tasa_innovacion
  
  return(list(
    n_star = n_star,
    tasa_innovacion = tasa_innovacion,
    tasa_crecimiento = tasa_crecimiento,
    tasa_obsolescencia = tasa_obsolescencia
  ))
}

eq_base <- resolver_equilibrio_ah(L, alpha, gamma_val, lambda_val, r_val)

# Simulacion temporal comparativa: Schumpeter (Aghion-Howitt) vs Solow Neoclasico
T_periodos <- 60
dt <- 1.0

# 1. Trayectoria estocastica Schumpeteriana (Saltos de Poisson de calidad)
tiempo <- 0:T_periodos
A_schump <- numeric(length(tiempo))
A_schump[1] <- 10.0 # Nivel inicial de conocimiento tecnologico util (A_0)

prob_salto <- 1 - exp(-eq_base$tasa_innovacion * dt)

innovaciones <- numeric(length(tiempo))
innovaciones[1] <- 0

for (t in 2:length(tiempo)) {
  # Llegada de una innovacion destructiva con probabilidad Poisson
  salto <- rbinom(1, size = 1, prob = prob_salto)
  innovaciones[t] <- salto
  if (salto == 1) {
    A_schump[t] <- A_schump[t - 1] * gamma_val
  } else {
    A_schump[t] <- A_schump[t - 1]
  }
}

pib_schump <- A_schump * ((L - eq_base$n_star)^alpha)

# 2. Trayectoria Neoclasica de Solow (Acumulacion de capital con tecnologia exogena constante A_0)
# k_{t+1} = s * f(k_t) + (1 - delta) * k_t, con f(k) = k^alpha
s_solow <- 0.22
delta_solow <- 0.07
k_solow <- numeric(length(tiempo))
k_solow[1] <- 1.0 # Capital inicial bajo, transicion al estado estacionario
pib_solow <- numeric(length(tiempo))

for (t in 1:length(tiempo)) {
  pib_solow[t] <- A_schump[1] * (k_solow[t]^alpha)
  if (t < length(tiempo)) {
    k_solow[t + 1] <- s_solow * (k_solow[t]^alpha) + (1 - delta_solow) * k_solow[t]
  }
}

df_crecimiento <- tibble(
  Periodo = tiempo,
  PIB_Schumpeter = pib_schump,
  PIB_Solow = pib_solow,
  Log_PIB_Schumpeter = log(pib_schump),
  Log_PIB_Solow = log(pib_solow)
)

# Grafico 1: Panel A (Crecimiento Schumpeter vs Solow) y Panel B (Curva de supervivencia/obsolescencia)
# Curvas de supervivencia tecnologica S(t) = exp(-lambda * n * t)
df_obsolescencia <- tibble(
  Anios = seq(0, 25, by = 0.5),
  Obsolescencia_Base = exp(-eq_base$tasa_obsolescencia * Anios),
  Obsolescencia_AltaID = exp(-(eq_base$tasa_obsolescencia * 1.8) * Anios),
  Obsolescencia_BajaID = exp(-(eq_base$tasa_obsolescencia * 0.4) * Anios)
)

# Generacion y guardado de fig_destruccion_creativa.png
p1 <- ggplot(df_crecimiento, aes(x = Periodo)) +
  geom_line(aes(y = Log_PIB_Schumpeter, color = "Aghion-Howitt (Destrucción Creativa)"), linewidth = 1.2) +
  geom_line(aes(y = Log_PIB_Solow, color = "Solow Neoclásico (Solo acumulación K)"), linetype = "dashed", linewidth = 1.1) +
  scale_color_manual(values = c("Aghion-Howitt (Destrucción Creativa)" = "#004c6d", 
                                "Solow Neoclásico (Solo acumulación K)" = "#c44e52")) +
  labs(
    title = "Crecimiento Endógeno vs. Acumulación Neoclásica",
    subtitle = "Logaritmo del PIB per cápita: Saltos de calidad Schumpeterianos vs. Rendimientos decrecientes",
    x = "Años / Periodos",
    y = "Log(PIB per cápita)",
    color = "Modelo"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 9, color = "gray30")
  )

p2 <- ggplot(df_obsolescencia, aes(x = Anios)) +
  geom_line(aes(y = Obsolescencia_Base, color = "Base (Equilibrio de Mercado)"), linewidth = 1.1) +
  geom_line(aes(y = Obsolescencia_AltaID, color = "Alta I+D (Rápido reemplazo)"), linewidth = 1.1, linetype = "dotdash") +
  geom_line(aes(y = Obsolescencia_BajaID, color = "Baja I+D (Monopolios protegidos)"), linewidth = 1.1, linetype = "dotted") +
  scale_color_manual(values = c("Base (Equilibrio de Mercado)" = "#2c7bb6",
                                "Alta I+D (Rápido reemplazo)" = "#d7191c",
                                "Baja I+D (Monopolios protegidos)" = "#fdae61")) +
  labs(
    title = "Tasa de Obsolescencia Tecnológica (Efecto Business-Stealing)",
    subtitle = "Probabilidad de que la tecnología de punta actual no haya sido desplazada por un nuevo entrante",
    x = "Años desde la patente/innovación",
    y = "Probabilidad de supervivencia del monopolio",
    color = "Intensidad I+D"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 9, color = "gray30")
  )

# Guardar figura combinada o individual
png(filename = file.path(out_dir, "fig_destruccion_creativa.png"), width = 2400, height = 1200, res = 240)
if (requireNamespace("patchwork", quietly = TRUE)) {
  print(p1 + p2)
} else {
  gridExtra::grid.arrange(p1, p2, ncol = 2)
}
dev.off()
message("Guardado: salidas/fig_destruccion_creativa.png")

# ------------------------------------------------------------------------------
# PARTE 2: AGHION ET AL. (2005) - RELACION EN U-INVERTIDA COMPETENCIA E INNOVACION
# ------------------------------------------------------------------------------

# Formalizacion de Aghion et al. (2005):
# Indice de competencia c in (0, 1) (relacionado inversamente con margen de Lerner o grado de colusion).
# Dos tipos de industrias:
# 1. Industrias "Neck-and-neck" (tecnologias a la par):
#    Empresas compiten directamente. A mayor c, menores las rentas pre-innovacion pi_0.
#    Incentivo a innovar para escapar de la competencia: d(n_0)/dc > 0.
#    n_0(c) = psi_0 * (c^1.2)
# 2. Industrias "Unlevel" (desiguales, lider vs seguidor):
#    El seguidor busca alcanzar al lider. Si la competencia c es muy alta, las rentas
#    post-innovacion que obtendria el seguidor se diluyen, desincentivando el esfuerzo:
#    d(n_1)/dc < 0 (efecto Schumpeteriano clasico).
#    n_1(c) = psi_1 * ((1 - c)^0.9)
#
# La fraccion estacionaria de industrias neck-and-neck mu_0(c) evoluciona endogenamente:
# mu_0(c) = n_1(c) / (2 * n_0(c) + n_1(c))
#
# Tasa agregada de innovacion I(c):
# I(c) = 2 * mu_0(c) * n_0(c) + (1 - mu_0(c)) * n_1(c)

c_seq <- seq(0.05, 0.95, length.out = 100)
psi_0 <- 0.75
psi_1 <- 0.65

n_neck <- psi_0 * (c_seq^1.15)
n_unlevel <- psi_1 * ((1 - c_seq)^0.85)

# Distribucion estacionaria de industrias
mu_0 <- n_unlevel / (2 * n_neck + n_unlevel)
mu_1 <- 1 - mu_0

# Indice agregado de innovacion
innovacion_agregada <- 2 * mu_0 * n_neck + mu_1 * n_unlevel

df_u_invertida <- tibble(
  Competencia = c_seq,
  Innovacion_Agregada = innovacion_agregada,
  Efecto_Escape = n_neck,
  Efecto_Schumpeter = n_unlevel,
  Industrias_Neck = mu_0
)

# Punto optimo de competencia
c_optimo <- c_seq[which.max(innovacion_agregada)]
i_max <- max(innovacion_agregada)

p_u <- ggplot(df_u_invertida, aes(x = Competencia)) +
  geom_line(aes(y = Innovacion_Agregada), color = "#1b7837", linewidth = 1.4) +
  geom_line(aes(y = Efecto_Escape, color = "Efecto 'Escapar de la Competencia' (Sectores a la par)"), 
            linetype = "dashed", linewidth = 0.9) +
  geom_line(aes(y = Efecto_Schumpeter, color = "Efecto Schumpeteriano de desaliento (Seguidores rezagados)"), 
            linetype = "dotted", linewidth = 0.9) +
  geom_vline(xintercept = c_optimo, linetype = "dotdash", color = "#762a83", linewidth = 0.9) +
  annotate("text", x = c_optimo + 0.02, y = i_max * 0.96, 
           label = paste0("Competencia Óptima (c* ≈ ", round(c_optimo, 2), ")"), 
           hjust = 0, fontface = "bold", color = "#762a83", size = 3.6) +
  annotate("text", x = 0.18, y = i_max * 0.40,
           label = "Zona dominada por\nEscapar de la Competencia\n(Incentivo al líder)",
           color = "#2166ac", size = 3.2, hjust = 0.5) +
  annotate("text", x = 0.82, y = i_max * 0.40,
           label = "Zona dominada por\nDesaliento Schumpeteriano\n(Caen rentas post-innovación)",
           color = "#b2182b", size = 3.2, hjust = 0.5) +
  scale_color_manual(
    name = "Mecanismos Subyacentes",
    values = c(
      "Efecto 'Escapar de la Competencia' (Sectores a la par)" = "#2166ac",
      "Efecto Schumpeteriano de desaliento (Seguidores rezagados)" = "#b2182b"
    )
  ) +
  scale_x_continuous(breaks = seq(0.1, 0.9, by = 0.2),
                     labels = c("0.1\n(Monopolio alto)", "0.3", "0.5", "0.7", "0.9\n(Fuerte competencia)")) +
  labs(
    title = "Relación en U-Invertida entre Competencia en Mercados e Innovación",
    subtitle = "Formalización empírica y teórica de Aghion, Bloom, Blundell, Griffith & Howitt (QJE 2005)",
    x = "Grado de Competencia en el Mercado de Bienes (1 - Margen de Lerner)",
    y = "Tasa Agregada de Innovación (Patentes / Crecimiento TFP)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 9, color = "gray30"),
    panel.grid.minor = element_blank()
  )

png(filename = file.path(out_dir, "fig_u_invertida_competencia.png"), width = 2000, height = 1200, res = 220)
print(p_u)
dev.off()
message("Guardado: salidas/fig_u_invertida_competencia.png")

# ------------------------------------------------------------------------------
# PARTE 3: TABLA DE SIMULACION Y SENSIBILIDAD DE PARAMETROS
# ------------------------------------------------------------------------------

escenarios <- list(
  list(nombre = "1. Calibracion Base", gamma = 1.30, lambda = 0.25, r = 0.04, c_lerner = 0.45),
  list(nombre = "2. Salto Tecnologico Radical (IA / Biotecnologia)", gamma = 1.55, lambda = 0.25, r = 0.04, c_lerner = 0.45),
  list(nombre = "3. Alta Eficiencia I+D (Ciencia abierta / Mokyr)", gamma = 1.30, lambda = 0.40, r = 0.04, c_lerner = 0.45),
  list(nombre = "4. Alta Tasa de Descuento (Miopia de inversion)", gamma = 1.30, lambda = 0.25, r = 0.09, c_lerner = 0.45),
  list(nombre = "5. Monopolio Excesivo / Barreras a la entrada", gamma = 1.30, lambda = 0.25, r = 0.04, c_lerner = 0.15),
  list(nombre = "6. Competencia Optima (Cumbre de la U-invertida)", gamma = 1.30, lambda = 0.25, r = 0.04, c_lerner = c_optimo),
  list(nombre = "7. Hiper-competencia con desincentivo al seguidor", gamma = 1.30, lambda = 0.25, r = 0.04, c_lerner = 0.90)
)

filas_tabla <- lapply(escenarios, function(esc) {
  sol <- resolver_equilibrio_ah(L = 1.0, alpha = 0.6, gamma = esc$gamma, lambda = esc$lambda, r = esc$r)
  
  # Factor multiplicador derivado del efecto de competencia en la U-invertida
  idx_c <- which.min(abs(c_seq - esc$c_lerner))
  factor_comp <- innovacion_agregada[idx_c] / innovacion_agregada[which.min(abs(c_seq - 0.45))]
  
  tasa_inno_ajustada <- sol$tasa_innovacion * factor_comp
  crecimiento_ajustado <- tasa_inno_ajustada * log(esc$gamma)
  
  tibble(
    escenario = esc$nombre,
    salto_calidad_gamma = esc$gamma,
    productividad_id_lambda = esc$lambda,
    tasa_descuento_r = esc$r,
    grado_competencia = round(esc$c_lerner, 2),
    empleo_investigacion_n = round(sol$n_star, 4),
    tasa_innovacion_anual = round(tasa_inno_ajustada, 4),
    tasa_obsolescencia_pct = round(tasa_inno_ajustada * 100, 2),
    crecimiento_pib_pct = round(crecimiento_ajustado * 100, 2)
  )
})

tab_simulacion <- bind_rows(filas_tabla)

csv_path <- file.path(out_dir, "tab_simulacion_crecimiento.csv")
write.csv(tab_simulacion, file = csv_path, row.names = FALSE, fileEncoding = "UTF-8")
message(paste("Guardado:", csv_path))

# Imprimir resumen de tabla
print(as.data.frame(tab_simulacion))

message("Simulacion completada exitosamente.")

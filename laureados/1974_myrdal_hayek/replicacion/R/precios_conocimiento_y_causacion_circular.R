# ==============================================================================
# Nobel de Economia 1974: Gunnar Myrdal y Friedrich August von Hayek
# Script: precios_conocimiento_y_causacion_circular.R
# Objetivo:
#   1. Simular el mecanismo de precios de Hayek (1945): transmision de conocimiento
#      disperso y adaptacion descentralizada vs planificacion central desfasada.
#   2. Simular la dinamica de Causacion Circular Acumulativa de Myrdal (1957):
#      divergencia regional bajo efectos de retroceso ("backwash") vs difusion ("spread").
# Salidas:
#   - salidas/fig_hayek_sistema_precios_informacion.png
#   - salidas/fig_myrdal_causacion_circular.png
#   - salidas/tab_resultados_hayek_myrdal_1974.csv
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(scales)
})

# Configuracion de reproducibilidad
set.seed(19741009)

# Resolucion robusta de rutas de salida
script_dir <- tryCatch({
  rprojroot::find_root(rprojroot::has_file("README.md"))
}, error = function(e) {
  getwd()
})

# Carpeta de salidas
out_dir <- file.path(script_dir, "laureados", "1974_myrdal_hayek", "replicacion", "salidas")
if (!dir.exists(out_dir)) {
  # Si se ejecuta desde laureados/1974_myrdal_hayek/replicacion/
  if (dir.exists("salidas")) {
    out_dir <- "salidas"
  } else if (dir.exists("../salidas")) {
    out_dir <- "../salidas"
  } else {
    dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
  }
}

cat("Directorio de salidas:", out_dir, "\n")

# Estilo grafico academico sobrio
tema_nobel <- theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12, color = "#111827"),
    plot.subtitle = element_text(size = 9.5, color = "#4B5563", margin = margin(b = 8)),
    plot.caption = element_text(size = 8, color = "#6B7280", hjust = 0),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#E5E7EB", linewidth = 0.5),
    legend.position = "bottom",
    legend.title = element_text(size = 9, face = "bold"),
    legend.text = element_text(size = 8.5),
    strip.text = element_text(face = "bold", size = 9.5)
  )

# ==============================================================================
# PARTE 1: HAYEK (1945) - EL USO DEL CONOCIMIENTO EN LA SOCIEDAD
# Modelo de procesamiento de informacion y senales de precios
# ==============================================================================
# Se modela una economia con J = 40 mercados locales/bienes heterogeneos.
# Cada sector j enfrenta un choque continuo de escasez/preferencias locales theta_{j,t}
# que sigue un proceso estocastico autorregresivo AR(1) con innovaciones locales:
#   theta_{j,t} = rho * theta_{j,t-1} + epsilon_{j,t}, epsilon ~ N(0, sigma_local^2)
#
# La asignacion socialmente optima es q^*_{j,t} = theta_{j,t}.
#
# 1. Regimen Descentralizado (Hayek):
#    Los agentes locales poseen conocimiento tacito directo de "tiempo y lugar":
#    observan theta_{j,t} con leve ruido epsilon_tacito. El precio de mercado p_{j,t}
#    se ajusta segun el exceso de demanda: p_{j,t} = p_{j,t-1} + gamma * (theta_{j,t} - q_{j,t-1}).
#    La produccion descentralizada responde agilmente al precio:
#    q^D_{j,t} = (1 - alpha_D)*q^D_{j,t-1} + alpha_D * p_{j,t} + eta_{j,t}.
#
# 2. Regimen Planificado Centralizado (Debate del Calculo Socialista):
#    El planificador no tiene conocimiento directo de las circunstancias locales.
#    Debe recolectar reportes estadisticos agregados, que sufren:
#    a) Rezago burocratico de transmision (lag = L periodos, ej. L = 2).
#    b) Ruido de agregacion y distorsion en la cadena de mando (sigma_bureau).
#    c) Estandarizacion rigida: aplica una cuota agregada o ajuste homogeneo.
#    q^C_{j,t} = (1 - alpha_C)*q^C_{j,t-1} + alpha_C * theta_{j, t-L} + xi_{j,t}.
# ==============================================================================

T_sim <- 60
J_sectores <- 40
rho <- 0.85
sigma_local <- 1.2
alpha_D <- 0.70  # Rapidez de ajuste local via precios
alpha_C <- 0.25  # Inercia burocratica de la planificacion
L_lag <- 2       # Rezago de datos en planificacion central

# Inicializar matrices
theta <- matrix(0, nrow = T_sim, ncol = J_sectores)
q_hayek <- matrix(0, nrow = T_sim, ncol = J_sectores)
q_central <- matrix(0, nrow = T_sim, ncol = J_sectores)
p_hayek <- matrix(0, nrow = T_sim, ncol = J_sectores)

# Condiciones iniciales
theta[1, ] <- rnorm(J_sectores, 0, sigma_local)
q_hayek[1, ] <- theta[1, ] + rnorm(J_sectores, 0, 0.2)
q_central[1, ] <- mean(theta[1, ]) + rnorm(J_sectores, 0, 0.5)
p_hayek[1, ] <- theta[1, ]

# Introducir un choque estructural agregado a mitad del horizonte (t = 25)
# que afecta asimetricamente a los mercados (ej. crisis energetica o cambio tecnologico)
for (t in 2:T_sim) {
  choque_adicional <- if (t == 25) rnorm(J_sectores, mean = 2.5, sd = 1.0) else 0
  theta[t, ] <- rho * theta[t - 1, ] + rnorm(J_sectores, 0, sigma_local) + choque_adicional
  
  # Sistema Hayekiano: precios transmiten escasez
  p_hayek[t, ] <- p_hayek[t - 1, ] + 0.6 * (theta[t, ] - q_hayek[t - 1, ])
  # Agentes locales responden al vector de precios locales
  q_hayek[t, ] <- (1 - alpha_D) * q_hayek[t - 1, ] + alpha_D * p_hayek[t, ] + rnorm(J_sectores, 0, 0.15)
  
  # Sistema Centralizado: asignacion basada en informacion atrasada y agregada
  t_info <- max(1, t - L_lag)
  # Planificador observa estadisticas pasadas con ruido burocratico
  info_pasada <- theta[t_info, ] + rnorm(J_sectores, 0, 0.6)
  # Cuota planificada con sesgo a la media (uniformizacion)
  cuota_uniforme <- 0.6 * info_pasada + 0.4 * mean(info_pasada)
  q_central[t, ] <- (1 - alpha_C) * q_central[t - 1, ] + alpha_C * cuota_uniforme + rnorm(J_sectores, 0, 0.3)
}

# Calcular Perdida de Bienestar / Error Cuadratico Medio (MSE) en cada periodo
mse_hayek <- rowMeans((q_hayek - theta)^2)
mse_central <- rowMeans((q_central - theta)^2)

df_hayek_dinamica <- data.frame(
  Periodo = 1:T_sim,
  MSE_Hayek = mse_hayek,
  MSE_Planificador = mse_central,
  Optimo_Sector1 = theta[, 1],
  Hayek_Sector1 = q_hayek[, 1],
  Central_Sector1 = q_central[, 1]
)

# Grafico 1: Hayek - Dinamica de ajuste y perdida de bienestar
p1_trayectoria <- ggplot(df_hayek_dinamica, aes(x = Periodo)) +
  geom_line(aes(y = Optimo_Sector1, color = "Optimo local (theta_1,t)"), linewidth = 1.1, linetype = "solid") +
  geom_line(aes(y = Hayek_Sector1, color = "Sistema de precios descentralizado (Hayek)"), linewidth = 0.9, linetype = "dashed") +
  geom_line(aes(y = Central_Sector1, color = "Planificador central (estadistica atrasada L=2)"), linewidth = 0.9, linetype = "dotdash") +
  geom_vline(xintercept = 25, linetype = "dotted", color = "#DC2626", linewidth = 0.7) +
  annotate("text", x = 26, y = max(df_hayek_dinamica$Optimo_Sector1) * 0.9,
           label = "Choque asimetrico (t=25)", hjust = 0, size = 3, color = "#DC2626") +
  scale_color_manual(
    name = "Mecanismo:",
    values = c(
      "Optimo local (theta_1,t)" = "#111827",
      "Sistema de precios descentralizado (Hayek)" = "#0284C7",
      "Planificador central (estadistica atrasada L=2)" = "#E11D48"
    )
  ) +
  labs(
    title = "Mecanismo de Precios de Hayek vs Planificacion Central",
    subtitle = "Adaptacion en tiempo real al conocimiento tacito local frente al rezago y uniformidad burocratica",
    x = "Periodo (t)",
    y = "Cantidad asignada en Sector 1"
  ) +
  tema_nobel

p1_mse <- ggplot(df_hayek_dinamica, aes(x = Periodo)) +
  geom_line(aes(y = MSE_Hayek, color = "Mecanismo descentralizado de precios (Hayek)"), linewidth = 1) +
  geom_line(aes(y = MSE_Planificador, color = "Planificador central (informacion agregada y rezagada)"), linewidth = 1) +
  geom_vline(xintercept = 25, linetype = "dotted", color = "#DC2626", linewidth = 0.7) +
  scale_color_manual(
    name = "Regimen institucional:",
    values = c(
      "Mecanismo descentralizado de precios (Hayek)" = "#0284C7",
      "Planificador central (informacion agregada y rezagada)" = "#E11D48"
    )
  ) +
  labs(
    title = "Perdida de Eficiencia Asignativa (Error Cuadratico Medio)",
    subtitle = "El sistema de precios minimiza la perdida social condensando informacion dispersa",
    x = "Periodo (t)",
    y = "Error Cuadratico Medio (MSE)"
  ) +
  tema_nobel

fig_hayek <- patchwork::wrap_plots(p1_trayectoria, p1_mse, ncol = 1) +
  patchwork::plot_annotation(
    title = "Premio Nobel 1974: Friedrich A. Hayek y el Uso del Conocimiento en la Sociedad",
    subtitle = "Simulacion del problema del calculo economico y coordinacion mediante el sistema de precios (AER 1945)",
    caption = "Fuente: Simulacion basada en Hayek (1945, 1975). Elaboracion propia para Nobel_economics.",
    theme = theme(
      plot.title = element_text(face = "bold", size = 13, color = "#1E3A8A"),
      plot.subtitle = element_text(size = 10, color = "#374151")
    )
  )

file_fig_hayek <- file.path(out_dir, "fig_hayek_sistema_precios_informacion.png")
ggsave(file_fig_hayek, fig_hayek, width = 9.5, height = 7.5, dpi = 300)
cat("Guardado:", file_fig_hayek, "\n")


# ==============================================================================
# PARTE 2: MYRDAL (1957) - CAUSACION CIRCULAR ACUMULATIVA
# Dinamica espacial Centro-Periferia: Efectos Backwash vs Spread
# ==============================================================================
# Sean dos regiones: Region C (Centro / Avanzada) y Region P (Periferia / Rezagada).
# En el enfoque neoclasico tradicional, los rendimientos decrecientes del capital
# forzarian al capital a fluir hacia la periferia (mayor producto marginal) y el trabajo
# migraria al centro, igualando salarios y tasas de retorno (convergencia automatica).
#
# Gunnar Myrdal (1957) refuto esta vision armonica postulando la Causacion Acumulativa:
# - Rendimientos crecientes a escala dinamicos (efecto Kaldor-Verdoorn):
#   Productividad A_{r,t} = A_{r,0} * (Y_{r,t-1})^gamma_V
# - Efectos de Retroceso ("Backwash effects"):
#   1. Fuga de capital financiero hacia el centro atraido por liquidez y retornos de aglomeracion.
#   2. Migracion selectiva de mano de obra cualificada (fuga de talentos / brain drain).
#   3. Desindustrializacion periferica por destruccion de artesanias/manufacturas locales.
# - Efectos de Derrame ("Spread effects"):
#   1. Demanda del centro de materias primas y bienes perifericos.
#   2. Desbordamiento tecnologico y congestion en el centro que abarata relocalizacion.
#
# Ecuaciones diferenciales discretas:
#   Y_{C,t} = (1 + g_base + beta_agg * Y_{C,t-1} + delta_backwash - delta_spread) * Y_{C,t-1}
#   Y_{P,t} = (1 + g_base - delta_backwash + delta_spread + I_politica) * Y_{P,t-1}
#
# Se evaluan 3 escenarios:
#   Escenario A: Libre mercado sin intervencion (Backwash domina: delta_bw = 0.04, delta_sp = 0.015) -> Divergencia.
#   Escenario B: Difusion espontanea madura (Spread iguala Backwash: delta_bw = 0.03, delta_sp = 0.03) -> Crecimiento paralelo.
#   Escenario C: Gran Impulso de Politica Regional (Myrdal: inversiones publicas, instituciones y subsidios productivos).
# ==============================================================================

T_regiones <- 40
periodos <- 1:T_regiones

simular_myrdal <- function(delta_bw, delta_sp, politica_inversion = 0, nombre_escenario) {
  Y_C <- numeric(T_regiones)
  Y_P <- numeric(T_regiones)
  
  # Condicion inicial: ligera ventaja inicial del Centro
  Y_C[1] <- 100
  Y_P[1] <- 70
  
  g_base <- 0.02
  gamma_agg <- 0.012  # Economias de aglomeracion acumulativas en el Centro
  
  for (t in 2:T_regiones) {
    # Tasa neta de atraccion/retroceso
    efecto_bw <- delta_bw * (Y_C[t - 1] / Y_P[t - 1])^0.5
    efecto_sp <- delta_sp * (Y_C[t - 1] / 100)^0.4
    
    # Crecimiento del Centro con aglomeracion
    tasa_C <- g_base + gamma_agg * log(Y_C[t - 1] / 100 + 1) + 0.5 * (efecto_bw - efecto_sp)
    Y_C[t] <- Y_C[t - 1] * (1 + tasa_C)
    
    # Crecimiento de la Periferia afectado por backwash y spread
    tasa_P <- g_base - efecto_bw + efecto_sp + politica_inversion
    # Evitar colapso a valores negativos
    tasa_P <- max(tasa_P, -0.01)
    Y_P[t] <- Y_P[t - 1] * (1 + tasa_P)
  }
  
  brecha_ratio <- Y_C / Y_P
  
  data.frame(
    Periodo = periodos,
    Centro = Y_C,
    Periferia = Y_P,
    Brecha_Centro_Periferia = brecha_ratio,
    Escenario = nombre_escenario
  )
}

# Simulacion de los tres escenarios
esc_a <- simular_myrdal(delta_bw = 0.035, delta_sp = 0.012, politica_inversion = 0.000, 
                        nombre_escenario = "1. Libre Mercado: Backwash dominante (Divergencia)")
esc_b <- simular_myrdal(delta_bw = 0.025, delta_sp = 0.025, politica_inversion = 0.000, 
                        nombre_escenario = "2. Fuerzas equilibradas: Spread neutral")
esc_c <- simular_myrdal(delta_bw = 0.035, delta_sp = 0.020, politica_inversion = 0.030, 
                        nombre_escenario = "3. Estado Desarrollista Myrdal: Politica regional activa")

df_myrdal <- bind_rows(esc_a, esc_b, esc_c)

# Formato largo para graficar ingresos de Centro y Periferia
df_myrdal_long <- df_myrdal %>%
  pivot_longer(cols = c(Centro, Periferia), names_to = "Region", values_to = "Ingreso_PerCapita")

# Graficos Myrdal
p2_ingresos <- ggplot(df_myrdal_long, aes(x = Periodo, y = Ingreso_PerCapita, color = Region, linetype = Region)) +
  geom_line(linewidth = 0.95) +
  facet_wrap(~ Escenario, scales = "free_y", ncol = 3) +
  scale_color_manual(
    name = "Region:",
    values = c("Centro" = "#1D4ED8", "Periferia" = "#D97706")
  ) +
  scale_linetype_manual(
    name = "Region:",
    values = c("Centro" = "solid", "Periferia" = "dashed")
  ) +
  labs(
    title = "Trayectoria de Ingreso por Habitante: Centro vs Periferia",
    subtitle = "La causacion acumulativa amplifica ventajas iniciales salvo intervencion deliberada de desarrollo",
    x = "Horizonte Temporal (Anos)",
    y = "Indice de Ingreso Real per capita"
  ) +
  tema_nobel

p2_brecha <- ggplot(df_myrdal, aes(x = Periodo, y = Brecha_Centro_Periferia, color = Escenario)) +
  geom_line(linewidth = 1.05) +
  geom_hline(yintercept = 100/70, linetype = "dotted", color = "#6B7280") +
  annotate("text", x = 2, y = (100/70) + 0.1, label = "Brecha inicial (1.43x)", size = 3, color = "#4B5563", hjust = 0) +
  scale_color_manual(
    name = "Regimen institucional / Escenario:",
    values = c(
      "1. Libre Mercado: Backwash dominante (Divergencia)" = "#DC2626",
      "2. Fuerzas equilibradas: Spread neutral" = "#4B5563",
      "3. Estado Desarrollista Myrdal: Politica regional activa" = "#059669"
    )
  ) +
  labs(
    title = "Evolucion de la Desigualdad Espacial (Ratio Ingreso Centro / Periferia)",
    subtitle = "Refutacion de la convergencia neoclasica automatica: la divergencia acumulativa de Myrdal",
    x = "Horizonte Temporal (Anos)",
    y = "Ratio de Disparidad (Centro / Periferia)"
  ) +
  tema_nobel

fig_myrdal <- patchwork::wrap_plots(p2_ingresos, p2_brecha, ncol = 1, heights = c(1, 0.9)) +
  patchwork::plot_annotation(
    title = "Premio Nobel 1974: Gunnar Myrdal y la Causacion Circular Acumulativa",
    subtitle = "Efectos de retroceso (backwash) y derrame (spread) en la dinamica regional e internacional (1957)",
    caption = "Fuente: Modelo cuantitativo de causacion acumulativa basado en Myrdal (1957) y Kaldor (1970). Nobel_economics.",
    theme = theme(
      plot.title = element_text(face = "bold", size = 13, color = "#065F46"),
      plot.subtitle = element_text(size = 10, color = "#374151")
    )
  )

file_fig_myrdal <- file.path(out_dir, "fig_myrdal_causacion_circular.png")
ggsave(file_fig_myrdal, fig_myrdal, width = 10, height = 8, dpi = 300)
cat("Guardado:", file_fig_myrdal, "\n")


# ==============================================================================
# PARTE 3: TABLA DE METRICAS CONSOLIDADAS
# Resumen comparativo de Hayek (1945) y Myrdal (1957)
# ==============================================================================

# Metricas Hayek
error_total_hayek <- mean(df_hayek_dinamica$MSE_Hayek)
error_total_central <- mean(df_hayek_dinamica$MSE_Planificador)
ratio_eficiencia_hayek <- error_total_central / error_total_hayek

# Metricas Myrdal (en T = 40)
res_myrdal_final <- df_myrdal %>%
  filter(Periodo == T_regiones) %>%
  select(Escenario, Centro, Periferia, Brecha_Centro_Periferia)

# Tabla consolidada para exportacion
tab_resultados <- data.frame(
  Dimension = c(
    "Hayek: Error Cuadratico Medio (Precios Descentralizados)",
    "Hayek: Error Cuadratico Medio (Planificador Central L=2)",
    "Hayek: Ventaja de Eficiencia Asignativa (Ratio MSE Central / Precios)",
    "Myrdal: Brecha Centro/Periferia final (Libre Mercado / Backwash Dominante)",
    "Myrdal: Brecha Centro/Periferia final (Fuerzas Equilibradas / Spread Neutral)",
    "Myrdal: Brecha Centro/Periferia final (Estado Desarrollista / Politica Activa)"
  ),
  Valor = c(
    round(error_total_hayek, 3),
    round(error_total_central, 3),
    round(ratio_eficiencia_hayek, 2),
    round(res_myrdal_final$Brecha_Centro_Periferia[1], 2),
    round(res_myrdal_final$Brecha_Centro_Periferia[2], 2),
    round(res_myrdal_final$Brecha_Centro_Periferia[3], 2)
  ),
  Interpretacion_Economica = c(
    "Precios procesan informacion local dispersa en tiempo real con minima perdida",
    "Agregacion y rezago administrativo de 2 periodos generan desajustes cronicos",
    "El mecanismo de precios reduce las perdidas sociales en multiples veces",
    "Fuga acumulativa de recursos crea divergencia creciente sin autorregulacion",
    "Los derrames compensan exactamente el drenaje de factores manteniendo disparidad",
    "Inversion deliberada en capital humano e infraestructura quiebra la trampa y converge"
  )
)

file_tab_csv <- file.path(out_dir, "tab_resultados_hayek_myrdal_1974.csv")
write.csv(tab_resultados, file_tab_csv, row.names = FALSE)
cat("Guardado:", file_tab_csv, "\n")

cat("\n--- EJECUCION EXITOSA ---\n")
print(tab_resultados)

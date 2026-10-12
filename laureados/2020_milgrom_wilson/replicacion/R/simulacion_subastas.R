# ==============================================================================
# simulacion_subastas.R
# Replicacion Ilustrativa: Teoria de Subastas de Milgrom y Wilson (Premio Nobel 2020)
# 
# 1. Modelo de Valor Comun y Maldicion del Ganador (Wilson 1977, Milgrom & Weber 1982)
#    - Evaluacion de sobrepuja y perdidas sistematicas en postores ingenuos vs racionales.
# 2. Simulacion de Subasta Ascendente Simultanea (SMRA, Milgrom 2000, 2004)
#    - Dinamica de rondas, regla de actividad y resolucion del problema de exposicion.
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
  library(patchwork)
})

# Fijar semilla para estricta reproducibilidad
set.seed(20201012)

# Crear directorio de salidas si no existe
dir_salidas <- "laureados/2020_milgrom_wilson/replicacion/salidas"
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

message("=== 1. SIMULACION: VALOR COMUN Y LA MALDICION DEL GANADOR ===")

# Parametros de simulacion de Monte Carlo
N_vec <- c(2, 3, 4, 6, 8, 10, 15, 20, 25, 30)
M_rep <- 3000       # Repeticiones por cada valor de N
epsilon_0 <- 20     # Semiamplitud del ruido en la senal uniforme: X_i ~ U[V - eps, V + eps]
V_min <- 100
V_max <- 200

resultados_mc <- list()

for (n_idx in seq_along(N_vec)) {
  N <- N_vec[n_idx]
  
  # Generar valor comun verdadero para cada repeticion
  V_true <- runif(M_rep, min = V_min, max = V_max)
  
  # Matriz de senales: M_rep filas x N columnas
  # Cada postor i recibe X_i = V + U[-epsilon_0, epsilon_0]
  ruido <- matrix(runif(M_rep * N, min = -epsilon_0, max = epsilon_0), nrow = M_rep, ncol = N)
  senales <- matrix(rep(V_true, N), nrow = M_rep, ncol = N) + ruido
  
  # Estadisticos de las senales
  max_senal <- apply(senales, 1, max)
  
  # Estrategia 1: Postor Ingenuo (Naive)
  # No condiciona en el evento de ganar; asume que su senal es el valor esperado no condicionado
  # y descuenta unicamente el sombreado de competencia como si fuera valor privado:
  # b_naive(X_i) = X_i - (2 * epsilon_0) / (N + 1)
  # El ganador es quien tiene la senal maxima:
  puja_naive_ganador <- max_senal - (2 * epsilon_0) / (N + 1)
  beneficio_naive <- V_true - puja_naive_ganador
  maldicion_naive <- beneficio_naive < 0
  
  # Estrategia 2: Postor Racional Bayesiano (Wilson / Milgrom-Weber)
  # Condiciona en ganar: E[V | X_i = max_j X_j] = X_i - epsilon_0 * (N - 1) / (N + 1)
  # Ademas, descuenta por el sombreado de competencia de primer precio:
  # b_racional(X_i) = X_i - epsilon_0 + (2 * epsilon_0) / (N + 1) * factor
  # Forma cerrada analitica de Wilson (1977) para subasta de primer precio con senales uniformes:
  # b*(X_i) = X_i - epsilon_0 * ((N - 1) / (N + 1)) - (2 * epsilon_0) / (N + 1)
  # Simplificando: b*(X_i) = X_i - epsilon_0
  # El postor gana con la senal maxima y su puja es:
  puja_racional_ganador <- max_senal - epsilon_0
  beneficio_racional <- V_true - puja_racional_ganador
  maldicion_racional <- beneficio_racional < 0
  
  # Sesgo de la senal ganadora frente al valor real
  sesgo_senal <- max_senal - V_true
  
  resultados_mc[[n_idx]] <- data.frame(
    N = N,
    V_true_medio = mean(V_true),
    sesgo_senal_medio = mean(sesgo_senal),
    sesgo_senal_teorico = epsilon_0 * (N - 1) / (N + 1),
    puja_naive_media = mean(puja_naive_ganador),
    beneficio_naive_medio = mean(beneficio_naive),
    beneficio_naive_teorico = -epsilon_0 * (N - 3) / (N + 1),
    pct_perdidas_naive = mean(maldicion_naive) * 100,
    puja_racional_media = mean(puja_racional_ganador),
    beneficio_racional_medio = mean(beneficio_racional),
    beneficio_racional_teorico = epsilon_0 * 2 / (N + 1),
    pct_perdidas_racional = mean(maldicion_racional) * 100
  )
}

df_resultados <- bind_rows(resultados_mc)

# Guardar tabla de resultados
write.csv(df_resultados, file.path(dir_salidas, "tab_resultados_subasta.csv"), row.names = FALSE)
message("Tabla tab_resultados_subasta.csv guardada exitosamente.")

# Graficar resultados de la Maldicion del Ganador
theme_nobel <- function() {
  theme_minimal(base_size = 11) +
    theme(
      plot.title = element_text(face = "bold", size = 12, color = "#1a252f"),
      plot.subtitle = element_text(size = 9, color = "#555555"),
      axis.title = element_text(face = "bold", size = 10, color = "#2c3e50"),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "#e8e8e8"),
      legend.position = "bottom",
      legend.title = element_text(face = "bold", size = 9),
      plot.caption = element_text(size = 8, color = "#7f8c8d", hjust = 0)
    )
}

# Panel A: Beneficio esperado del ganador vs Numero de postores
p1 <- ggplot(df_resultados, aes(x = N)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray40", linewidth = 0.8) +
  geom_line(aes(y = beneficio_naive_medio, color = "Postor Ingenuo (Sin sombreado por seleccion)"), linewidth = 1.2) +
  geom_point(aes(y = beneficio_naive_medio, color = "Postor Ingenuo (Sin sombreado por seleccion)"), size = 2.5) +
  geom_line(aes(y = beneficio_racional_medio, color = "Postor Racional Bayesiano (Wilson / Milgrom)"), linewidth = 1.2) +
  geom_point(aes(y = beneficio_racional_medio, color = "Postor Racional Bayesiano (Wilson / Milgrom)"), size = 2.5) +
  scale_color_manual(values = c(
    "Postor Ingenuo (Sin sombreado por seleccion)" = "#d9534f",
    "Postor Racional Bayesiano (Wilson / Milgrom)" = "#2e6da4"
  )) +
  scale_x_continuous(breaks = N_vec) +
  labs(
    title = "A. Beneficio Esperado del Ganador vs. Competencia (N)",
    subtitle = "A mayor N, la senal maxima sobrestima mas el valor comun; la puja ingenua genera perdidas sistematicas.",
    x = "Numero de Postores (N)",
    y = "Beneficio Neto Esperado E[V - Pago]",
    color = "Estrategia de Puja:"
  ) +
  theme_nobel()

# Panel B: Probabilidad de sufrir perdidas netas (Maldicion del Ganador)
p2 <- ggplot(df_resultados, aes(x = N)) +
  geom_line(aes(y = pct_perdidas_naive, color = "Postor Ingenuo"), linewidth = 1.2) +
  geom_point(aes(y = pct_perdidas_naive, color = "Postor Ingenuo"), size = 2.5) +
  geom_line(aes(y = pct_perdidas_racional, color = "Postor Racional"), linewidth = 1.2) +
  geom_point(aes(y = pct_perdidas_racional, color = "Postor Racional"), size = 2.5) +
  scale_color_manual(values = c(
    "Postor Ingenuo" = "#d9534f",
    "Postor Racional" = "#2e6da4"
  )) +
  scale_x_continuous(breaks = N_vec) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(0, 100)) +
  labs(
    title = "B. Tasa de Incidencia de la Maldicion del Ganador",
    subtitle = "Porcentaje de subastas donde el ganador termina pagando mas que el valor real V.",
    x = "Numero de Postores (N)",
    y = "Frecuencia de Ganadores con Perdidas (%)",
    color = "Estrategia:"
  ) +
  theme_nobel()

fig_maldicion <- p1 / p2 + 
  plot_annotation(
    title = "Teoria de Subastas de Valor Comun: Wilson (1977) y Milgrom & Weber (1982)",
    subtitle = "Simulacion Monte Carlo (M = 3,000 reps) de valor comun con senales ruidosas X_i ~ U[V - 20, V + 20]",
    caption = "Fuente: Simulacion basada en Robert Wilson (1977, Rev. Econ. Stud.) y Milgrom & Weber (1982, Econometrica)."
  )

ggsave(
  filename = file.path(dir_salidas, "fig_maldicion_ganador.png"),
  plot = fig_maldicion,
  width = 9,
  height = 8,
  dpi = 300
)
message("Grafico fig_maldicion_ganador.png guardado exitosamente.")

# ==============================================================================
# 2. SIMULACION: SUBASTA ASCENDENTE SIMULTANEA (SMRA)
# Disenada por Milgrom y Wilson (con McAfee) para la FCC (1994)
# ==============================================================================
message("=== 2. SIMULACION: SUBASTA ASCENDENTE SIMULTANEA (SMRA) ===")

# Simulamos la asignacion de dos licencias de espectro con sinergias geograficas:
# Licencia 1: Region Norte (p. ej., Chicago)
# Licencia 2: Region Sur (p. ej., Dallas)

# Postores y valoraciones privadas:
# Postor A (Nacional Integrado): Valora Norte en 70, Sur en 70, con fuerte Sinergia de red (+40 si gana ambas -> 180 total).
# Postor B (Especialista Norte): Valora Norte en 90, Sur en 20, Sinergia minima (+5 -> 115 total).
# Postor C (Especialista Sur):   Valora Norte en 20, Sur en 90, Sinergia minima (+5 -> 115 total).
# Postor D (Consorcio Emergente): Valora Norte en 65, Sur en 65, Sinergia moderada (+20 -> 150 total).

postores <- c("Postor A (Nacional)", "Postor B (Norte)", "Postor C (Sur)", "Postor D (Emergente)")

# Parametros del formato SMRA
incremento_minimo <- 5
precio_reserva <- 10

# Algoritmo de Subasta Ascendente Simultanea en Rondas
max_rondas <- 25
historial_rondas <- list()

# Precios iniciales y mejores postores provisionales (Standing High Bidders - SHB)
precios <- c(Norte = precio_reserva, Sur = precio_reserva)
shb <- c(Norte = NA_character_, Sur = NA_character_)

# Reglas de valoracion
calc_disposicion_pago <- function(postor, lic_poseidas, lic_objetivo) {
  # Retorna el valor marginal de anadir lic_objetivo dado que ya tiene lic_poseidas
  if (postor == "Postor A (Nacional)") {
    if (length(lic_poseidas) == 0) return(70)
    if (lic_poseidas != lic_objetivo) return(70 + 40) # Sinergia completa: 110 marginal
  } else if (postor == "Postor B (Norte)") {
    if (lic_objetivo == "Norte") return(90)
    if (lic_objetivo == "Sur") return(20)
  } else if (postor == "Postor C (Sur)") {
    if (lic_objetivo == "Sur") return(90)
    if (lic_objetivo == "Norte") return(20)
  } else if (postor == "Postor D (Emergente)") {
    if (length(lic_poseidas) == 0) return(65)
    if (lic_poseidas != lic_objetivo) return(65 + 20) # Sinergia moderada: 85 marginal
  }
  return(0)
}

actividad_elegible <- setNames(rep(2, length(postores)), postores) # Pueden pujar por hasta 2 licencias

for (ronda in 1:max_rondas) {
  nuevas_pujas <- list()
  
  for (p in postores) {
    # Licencias que ya tiene como mejor postor provisional
    posee <- names(shb)[!is.na(shb) & shb == p]
    cuotas_activas <- length(posee)
    
    # Evaluar pujar por cada licencia no poseida
    for (lic in c("Norte", "Sur")) {
      if (!(lic %in% posee)) {
        precio_a_superar <- precios[lic] + (if (is.na(shb[lic])) 0 else incremento_minimo)
        valor_marginal <- calc_disposicion_pago(p, posee, lic)
        
        # Si tiene elegibilidad de actividad y el valor marginal supera el precio:
        if (cuotas_activas < actividad_elegible[p] && valor_marginal >= precio_a_superar) {
          nuevas_pujas[[length(nuevas_pujas) + 1]] <- data.frame(
            ronda = ronda,
            postor = p,
            licencia = lic,
            monto = precio_a_superar,
            stringsAsFactors = FALSE
          )
        }
      }
    }
  }
  
  # Registrar estado actual de la ronda
  historial_rondas[[length(historial_rondas) + 1]] <- data.frame(
    ronda = ronda,
    precio_Norte = precios["Norte"],
    precio_Sur = precios["Sur"],
    shb_Norte = ifelse(is.na(shb["Norte"]), "Sin puja", shb["Norte"]),
    shb_Sur = ifelse(is.na(shb["Sur"]), "Sin puja", shb["Sur"]),
    stringsAsFactors = FALSE
  )
  
  if (length(nuevas_pujas) == 0) {
    message(paste("Subasta concluida en ronda", ronda, "- Cierre simultaneo por inactividad."))
    break
  }
  
  df_pujas_ronda <- bind_rows(nuevas_pujas)
  
  # Actualizar mejores postores provisionales para cada licencia
  for (lic in c("Norte", "Sur")) {
    pujas_lic <- df_pujas_ronda %>% filter(licencia == lic)
    if (nrow(pujas_lic) > 0) {
      # Si hay empates, romper aleatoriamente o elegir el primero
      ganador_ronda <- pujas_lic[which.max(pujas_lic$monto), ]
      precios[lic] <- ganador_ronda$monto
      shb[lic] <- ganador_ronda$postor
    }
  }
}

df_smra <- bind_rows(historial_rondas)

# Reformat para grafico
df_smra_long <- df_smra %>%
  pivot_longer(cols = c(precio_Norte, precio_Sur), names_to = "Licencia", values_to = "Precio") %>%
  mutate(
    Licencia = ifelse(Licencia == "precio_Norte", "Licencia Norte (Chicago)", "Licencia Sur (Dallas)"),
    Lider = ifelse(Licencia == "Licencia Norte (Chicago)", shb_Norte, shb_Sur)
  )

fig_smra <- ggplot(df_smra_long, aes(x = ronda, y = Precio, color = Licencia, group = Licencia)) +
  geom_line(linewidth = 1.3) +
  geom_point(aes(shape = Licencia), size = 3) +
  geom_text(
    aes(label = gsub("Postor ", "P-", Lider)),
    vjust = -0.8,
    size = 2.8,
    check_overlap = TRUE,
    show.legend = FALSE
  ) +
  scale_color_manual(values = c("Licencia Norte (Chicago)" = "#1f77b4", "Licencia Sur (Dallas)" = "#ff7f0e")) +
  scale_x_continuous(breaks = seq(1, max(df_smra$ronda), by = 2)) +
  labs(
    title = "Dinamica de Precios en Subasta Ascendente Simultanea (SMRA)",
    subtitle = "Innovacion de Milgrom y Wilson (1994): Rondas simultaneas con reglas de actividad y cierre unificado.",
    x = "Numero de Ronda",
    y = "Precio Actual de la Licencia (USD M)",
    color = "Banda / Licencia:",
    shape = "Banda / Licencia:",
    caption = "Nota: Etiquetas indican el mejor postor provisional (SHB). El cierre simultaneo resolvio el problema de exposicion.\nFuente: Simulacion basada en Paul Milgrom (2000, J. Polit. Econ.) y Wilson (2002)."
  ) +
  theme_nobel()

ggsave(
  filename = file.path(dir_salidas, "fig_subasta_ascendente_smra.png"),
  plot = fig_smra,
  width = 9,
  height = 5.5,
  dpi = 300
)
message("Grafico fig_subasta_ascendente_smra.png guardado exitosamente.")

message("=== SIMULACION COMPLETADA CON EXITO ===")

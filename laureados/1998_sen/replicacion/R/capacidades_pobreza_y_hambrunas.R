# ==============================================================================
# Premio Nobel de Economia 1998: Amartya Sen
# Script: capacidades_pobreza_y_hambrunas.R
# Descripcion:
#   1. Medicion axiomatica de pobreza: Calculo y comparacion del Indice de Sen
#      P_S = H * [I + (1 - I) * G_p] frente a la Tasa de Recuento (H) y la
#      Brecha de Ingresos (I) bajo violaciones controladas de axiomas.
#   2. Simulacion del colapso de titularidades (Entitlement Failure) de Sen (1981):
#      Demostracion formal de la hambruna de Bengala (1943) sin caida en la
#      disponibilidad total de alimentos (FAD = 0).
# Salidas:
#   - salidas/fig_sen_indice_pobreza.png
#   - salidas/fig_sen_hambrunas_titularidades.png
#   - salidas/tab_resultados_sen.csv
# ==============================================================================

# 0. Configuracion inicial y librerias -----------------------------------------
suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(scales)
  library(patchwork)
})

# Fijar semilla para reproducibilidad exacta
set.seed(19981012)

# Directorio de salida
dir_salidas <- file.path("laureados", "1998_sen", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

cat("=====================================================================\n")
cat("Premio Nobel 1998 - Amartya Sen: Pobreza y Colapso de Titularidades\n")
cat("=====================================================================\n\n")

# ==============================================================================
# PARTE 1: MEDICION AXIOMATICA DE LA POBREZA (SEN, 1976)
# ==============================================================================

# Definicion de funciones para los indices de pobreza
calc_gini_pobres <- function(ingresos_pobres) {
  # Coeficiente de Gini entre los pobres
  q <- length(ingresos_pobres)
  if (q <= 1) return(0)
  mu <- mean(ingresos_pobres)
  if (mu == 0) return(0)
  # Formula discreta ordenada
  y_ord <- sort(ingresos_pobres)
  i <- seq_len(q)
  gini <- (2 * sum(i * y_ord)) / (q * sum(y_ord)) - (q + 1) / q
  return(pmax(0, pmin(1, gini)))
}

calc_indices_pobreza <- function(y, linea_z) {
  N <- length(y)
  pobres <- y[y < linea_z]
  q <- length(pobres)
  
  if (q == 0) {
    return(data.frame(
      N = N, q = 0, H = 0, I = 0, P_G = 0, G_p = 0, P_Sen = 0
    ))
  }
  
  # 1. Headcount ratio (Tasa de recuento)
  H <- q / N
  
  # 2. Income gap ratio de los pobres (Brecha proporcional de los pobres)
  I <- mean((linea_z - pobres) / linea_z)
  
  # 3. Poverty Gap Index tradicional (Brecha agregada normalizada)
  P_G <- H * I
  
  # 4. Coeficiente de Gini entre los pobres
  G_p <- calc_gini_pobres(pobres)
  
  # 5. Indice de Pobreza de Sen (1976)
  P_Sen <- H * (I + (1 - I) * G_p)
  
  return(data.frame(
    N = N,
    q = q,
    H = round(H, 4),
    I = round(I, 4),
    P_G = round(P_G, 4),
    G_p = round(G_p, 4),
    P_Sen = round(P_Sen, 4)
  ))
}

# Generar poblacion sintetica base
N_pob <- 1000
linea_pobreza <- 50
# Distribucion log-normal de ingresos
ingresos_base <- rlnorm(N_pob, meanlog = 3.9, sdlog = 0.65)

# Escenario 1: Distribucion Base
res_base <- calc_indices_pobreza(ingresos_base, linea_pobreza)
res_base$Escenario <- "1. Distribución Base"

# Escenario 2: Transferencia Regresiva entre Pobres (Axioma de Transferencia)
# Transferimos exactamente dinero de los pobres mas rezagados a los menos rezagados
# preservando la media de los pobres y el numero de pobres intactos (H e I constantes).
ingresos_transf <- ingresos_base
idx_pobres <- which(ingresos_transf < linea_pobreza)
pobres_ord <- idx_pobres[order(ingresos_transf[idx_pobres])]
q_pob <- length(pobres_ord)
m <- floor(q_pob / 2)

# Pares de transferencia balanceada delta
delta <- 3.0
ingresos_transf[pobres_ord[1:m]] <- pmax(1.0, ingresos_transf[pobres_ord[1:m]] - delta)
ingresos_transf[pobres_ord[(q_pob - m + 1):q_pob]] <- pmin(
  linea_pobreza - 0.05,
  ingresos_transf[pobres_ord[(q_pob - m + 1):q_pob]] + delta
)

res_transf <- calc_indices_pobreza(ingresos_transf, linea_pobreza)
res_transf$Escenario <- "2. Transferencia Regresiva (Axioma T)"

# Escenario 3: Caida de ingresos de los pobres sin cruzar la linea (Axioma de Monotonia)
# Todos los pobres pierden un 15% de su ingreso. Nadie nuevo cae en pobreza (H constante).
ingresos_monot <- ingresos_base
ingresos_monot[idx_pobres] <- ingresos_monot[idx_pobres] * 0.85

res_monot <- calc_indices_pobreza(ingresos_monot, linea_pobreza)
res_monot$Escenario <- "3. Caída de Ingreso en Pobres (Axioma M)"

# Escenario 4: Rescate oportunista en la frontera de pobreza
# Politica tipica de focalizacion perversa que solo rescata a quienes estan inmediatamente bajo z.
ingresos_rescate <- ingresos_base
cercanos_z <- idx_pobres[ingresos_base[idx_pobres] >= (linea_pobreza - 5)]
ingresos_rescate[cercanos_z] <- linea_pobreza + 2

res_rescate <- calc_indices_pobreza(ingresos_rescate, linea_pobreza)
res_rescate$Escenario <- "4. Rescate Superficial (Frontera z)"

# Consolidar tabla de comparacion de indices
tabla_pobreza <- bind_rows(res_base, res_transf, res_monot, res_rescate) %>%
  select(Escenario, N, q, H, I, P_G, G_p, P_Sen)

cat("Tabla 1: Comparacion de Indices de Pobreza bajo los Axiomas de Sen (1976)\n")
print(tabla_pobreza)
cat("\n")

# Graficar la comparacion de indices
df_graf_pobreza <- tabla_pobreza %>%
  select(Escenario, H, I, G_p, P_Sen) %>%
  pivot_longer(cols = c(H, I, G_p, P_Sen), names_to = "Indicador", values_to = "Valor") %>%
  mutate(Indicador = factor(Indicador, levels = c("H", "I", "G_p", "P_Sen"),
                           labels = c("Tasa Recuento (H)", 
                                      "Brecha Ingresos (I)", 
                                      "Gini Pobres (G_p)", 
                                      "Índice de Sen (P_S)")))

p_pobreza <- ggplot(df_graf_pobreza, aes(x = Escenario, y = Valor, fill = Indicador)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7, color = "black", linewidth = 0.2) +
  geom_text(aes(label = sprintf("%.3f", Valor)), 
            position = position_dodge(width = 0.8), vjust = -0.4, size = 3, fontface = "bold") +
  scale_fill_manual(values = c("Tasa Recuento (H)" = "#34495e", 
                               "Brecha Ingresos (I)" = "#2980b9", 
                               "Gini Pobres (G_p)" = "#e67e22", 
                               "Índice de Sen (P_S)" = "#c0392b")) +
  scale_y_continuous(limits = c(0, max(df_graf_pobreza$Valor) * 1.25), labels = label_number(accuracy = 0.1)) +
  labs(
    title = "Índice de Pobreza de Sen (1976) vs. Indicadores Tradicionales",
    subtitle = expression(paste("Respuesta a los axiomas de monotonía y transferencia: ", P[S] == H %*% (I + (1 - I) %*% G[p]))),
    x = "Escenario de Política o Shock Distributivo",
    y = "Valor del Índice",
    fill = "Medida",
    caption = "Fuente: Nobel_economics. Simulación basada en Sen (1976, Econometrica)."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 13, hjust = 0),
    plot.subtitle = element_text(size = 10, color = "gray25", margin = margin(b = 10)),
    axis.text.x = element_text(angle = 15, hjust = 1, face = "bold"),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )

ruta_fig1 <- file.path(dir_salidas, "fig_sen_indice_pobreza.png")
ggsave(ruta_fig1, plot = p_pobreza, width = 9.5, height = 5.5, dpi = 300)
cat(paste0("Figura 1 guardada: ", ruta_fig1, "\n"))


# ==============================================================================
# PARTE 2: SIMULACION DE FALLO DE TITULARIDADES EN HAMBRUNAS (SEN, 1981)
# ==============================================================================
# Contexto: Hambruna de Bengala de 1943 descrita en 'Poverty and Famines' (1981).
# Disponibilidad total agregada de alimentos (FAD = Food Availability Decline):
# No cae la produccion agregada; de hecho, sube levemente por una cosecha normal.
# Shock: Expansion belica britanica en Calcuta, emision monetaria e inflacion de
# alimentos impulsada por acaparamiento especulativo.

periodos <- 1:8
n_per <- length(periodos)

# Disponibilidad agregada de alimentos (en miles de toneladas metricas)
# Demuestra formalmente FAD = 0: La disponibilidad de granos se mantiene estable o creciente
alimento_agregado <- c(100, 102, 101, 103, 102, 104, 103, 105)

# Precio del alimento basico (arroz por seer/kg)
# Disparo inflacionario cuadruplicado (shock belico y especulacion)
precio_alimento <- c(10, 11, 15, 28, 42, 38, 22, 14)

# Definicion de grupos ocupacionales
# 1. Jornaleros agricolas rurales (Rural wage laborers): Salarios nominales rigidos
salario_jornalero <- c(12, 12.5, 13, 15, 17, 18, 16, 14)

# 2. Artesanos / Pescadores rurales (Rural craftsmen/fishermen): Su demanda y precios colapsan
ingreso_artesano <- c(14, 14, 13, 12, 10, 11, 13, 14)

# 3. Productores agricolas de arroz con excedente (Peasant farmers with surplus):
# Tienen grano fisico propio y venden con ganancias extraordinarias
ingreso_agricultor <- c(18, 20, 28, 55, 82, 75, 45, 26)

# 4. Trabajadores urbanos formales subsidiados (Urban subsidized workers en Calcuta):
# Con raciones de guerra y salarios protegidos
ingreso_urbano <- c(16, 18, 24, 40, 52, 48, 32, 22)

# Requerimiento biologico minimo de subsistencia alimentaria (unidades de arroz)
subsistencia_minima <- 1.0  # kg o raciones diarias

# Construir dataset panel para los 8 periodos
datos_hambruna <- data.frame(
  Periodo = rep(periodos, times = 4),
  Grupo = rep(c("Jornaleros Agrícolas", "Artesanos/Pescadores", "Productores de Arroz", "Trabajadores Urbanos"), each = n_per),
  Ingreso_Nominal = c(salario_jornalero, ingreso_artesano, ingreso_agricultor, ingreso_urbano),
  Precio_Arroz = rep(precio_alimento, times = 4),
  Alimento_Total = rep(alimento_agregado, times = 4)
) %>%
  mutate(
    # Titularidad alimentaria directa por grupo: Q_alimento = Ingreso / Precio
    Titularidad_Alimento = Ingreso_Nominal / Precio_Arroz,
    # Deficit o brecha nutricional bajo el umbral de supervivencia
    En_Inanicion = Titularidad_Alimento < subsistencia_minima,
    Brecha_Supervivencia = pmax(0, subsistencia_minima - Titularidad_Alimento)
  )

# Resumen de dinamica agregada y titularidades
cat("Tabla 2: Dinamica de Titularidades Alimentarias (Modelo Bengal 1943)\n")
resumen_hambruna <- datos_hambruna %>%
  filter(Periodo %in% c(1, 3, 5, 8)) %>%
  select(Periodo, Grupo, Ingreso_Nominal, Precio_Arroz, Titularidad_Alimento, En_Inanicion)
print(resumen_hambruna)
cat("\n")

# Visualizacion del Colapso de Titularidades (Sen 1981)
p_fad <- ggplot(data.frame(Periodo = periodos, Alimento = alimento_agregado), aes(x = Periodo, y = Alimento)) +
  geom_line(color = "#27ae60", linewidth = 1.2) +
  geom_point(color = "#27ae60", size = 2.5) +
  scale_y_continuous(limits = c(80, 120)) +
  labs(
    title = "A. Hipótesis FAD: Disponibilidad Agregada de Alimentos",
    subtitle = "La producción física de alimentos no disminuye (FAD = 0)",
    y = "Índice de Alimento (Base 1 = 100)",
    x = "Fase / Período Histórico"
  ) +
  theme_minimal(base_size = 10) +
  theme(plot.title = element_text(face = "bold", size = 10))

p_titularidades <- ggplot(datos_hambruna, aes(x = Periodo, y = Titularidad_Alimento, color = Grupo, group = Grupo)) +
  geom_hline(yintercept = subsistencia_minima, linetype = "dashed", color = "#c0392b", linewidth = 0.9) +
  annotate("text", x = 2.5, y = subsistencia_minima + 0.12, label = "Línea de Subsistencia Biológica", 
           color = "#c0392b", fontface = "bold.italic", size = 3) +
  geom_line(linewidth = 1.1) +
  geom_point(size = 2.2) +
  scale_color_manual(values = c(
    "Jornaleros Agrícolas" = "#c0392b",
    "Artesanos/Pescadores" = "#e67e22",
    "Productores de Arroz" = "#2980b9",
    "Trabajadores Urbanos" = "#8e44ad"
  )) +
  labs(
    title = "B. Enfoque de Titularidades de Sen (Entitlement Approach)",
    subtitle = "Colapso del poder adquisitivo alimentario en jornaleros rurales por shock inflacionario",
    x = "Fase / Período (Pico de Hambruna en t=5)",
    y = "Titularidad de Alimento (Raciones)",
    color = "Grupo Social"
  ) +
  theme_minimal(base_size = 10) +
  theme(
    plot.title = element_text(face = "bold", size = 10),
    legend.position = "bottom"
  )

# Combinar ambas graficas con patchwork
p_hambruna_total <- (p_fad / p_titularidades) +
  plot_annotation(
    title = "Fallo de Titularidades (Sen, 1981): Por Qué Ocurren las Hambrunas",
    subtitle = "Contraste entre la disponibilidad física total de comida y los derechos de intercambio (exchange entitlements)",
    caption = "Fuente: Nobel_economics. Inspirado en Amartya Sen (1981), 'Poverty and Famines'."
  )

ruta_fig2 <- file.path(dir_salidas, "fig_sen_hambrunas_titularidades.png")
ggsave(ruta_fig2, plot = p_hambruna_total, width = 9.5, height = 7.5, dpi = 300)
cat(paste0("Figura 2 guardada: ", ruta_fig2, "\n"))

# ==============================================================================
# PARTE 3: EXPORTAR TABLA DE RESULTADOS
# ==============================================================================

# Guardar tabla de resultados consolidada en CSV
ruta_csv <- file.path(dir_salidas, "tab_resultados_sen.csv")
write.csv(tabla_pobreza, file = ruta_csv, row.names = FALSE)
cat(paste0("Tabla de resultados guardada en: ", ruta_csv, "\n\n"))

cat("Script ejecutado con éxito. Todas las figuras y tablas fueron generadas.\n")

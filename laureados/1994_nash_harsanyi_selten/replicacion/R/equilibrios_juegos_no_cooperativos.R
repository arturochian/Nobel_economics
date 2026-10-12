# ==============================================================================
# Script: equilibrios_juegos_no_cooperativos.R
# Proyecto: Nobel_economics - Premio Nobel 1994
# Laureados: John F. Nash Jr., Reinhard Selten, John C. Harsanyi
# Proposito: Replicacion cuantitativa de conceptos fundacionales de teoria de juegos:
#   1. Equilibrios de Nash en estrategias puras y mixtas (Nash 1950, 1951)
#   2. Equilibrio Perfecto en Subjuegos (SPE) vs. Amenazas no creibles (Selten 1965)
#   3. Transformacion bayesiana de juegos con informacion incompleta (Harsanyi 1967)
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(tibble)
})

# Fijar semilla para reproducibilidad estocastica
set.seed(19941011)

# Detectar directorio base de salidas
dir_script <- tryCatch({
  dirname(sys.frame(1)$ofile)
}, error = function(e) {
  getwd()
})

# Garantizar que la ruta a salidas exista
dir_salidas <- file.path("laureados", "1994_nash_harsanyi_selten", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  # Si se ejecuta desde laureados/1994_nash_harsanyi_selten/replicacion/R/
  if (dir.exists("../salidas")) {
    dir_salidas <- "../salidas"
  } else if (dir.exists("salidas")) {
    dir_salidas <- "salidas"
  } else {
    dir.create(dir_salidas, recursive = TRUE, showWarnings = FALSE)
  }
}

cat("=== Iniciando Replicacion Cuantitativa Nobel 1994 ===\n")
cat("Directorio de destino para salidas:", dir_salidas, "\n\n")

# ==============================================================================
# SECCION 1: EQUILIBRIOS DE NASH EN JUEGOS ESTATICOS 2x2 (NASH 1950, 1951)
# ==============================================================================

# 1.1 Batalla de los Sexos (Juego de Coordinacion con Conflicto de Preferencias)
# Jugador 1 (Ella): O1 (Opera), F1 (Futbol)
# Jugador 2 (El):   O2 (Opera), F2 (Futbol)
# Matriz de pagos:
#           O2       F2
#   O1    (3, 2)   (0, 0)
#   F1    (0, 0)   (2, 3)

cat("1. Analizando Batalla de los Sexos (Nash 1950)...\n")

# Parametros de probabilidad:
# p = Pr(Jugador 1 juega Opera) en [0, 1]
# q = Pr(Jugador 2 juega Opera) en [0, 1]

# Pagos esperados para Jugador 1:
# EU1(Opera; q) = 3*q + 0*(1-q) = 3q
# EU1(Futbol; q) = 0*q + 2*(1-q) = 2 - 2q
# Indiferencia: 3q = 2 - 2q => 5q = 2 => q* = 2/5 = 0.40

# Pagos esperados para Jugador 2:
# EU2(Opera; p) = 2*p + 0*(1-p) = 2p
# EU2(Futbol; p) = 0*p + 3*(1-p) = 3 - 3p
# Indiferencia: 2p = 3 - 3p => 5p = 3 => p* = 3/5 = 0.60

q_star <- 2 / 5
p_star <- 3 / 5

# Crear mallas de puntos para graficar las correspondencias de mejor respuesta
grid_pts <- 500
eps <- 1e-4

# Mejor respuesta del Jugador 1 (p como funcion de q):
# Si q < q*: p = 0
# Si q > q*: p = 1
# Si q == q*: p en [0, 1]
br1_df <- data.frame(
  q = c(0, q_star - eps, q_star, q_star, q_star + eps, 1),
  p = c(0, 0,             0,      1,      1,            1),
  jugador = "Jugador 1: BR1(q) [Eleccion de p]"
)

# Mejor respuesta del Jugador 2 (q como funcion de p):
# Si p < p*: q = 0
# Si p > p*: q = 1
# Si p == p*: q en [0, 1]
br2_df <- data.frame(
  p = c(0, p_star - eps, p_star, p_star, p_star + eps, 1),
  q = c(0, 0,             0,      1,      1,            1),
  jugador = "Jugador 2: BR2(p) [Eleccion de q]"
)

# Puntos de equilibrio de Nash (interseccion de BR1 y BR2)
eq_puntos <- data.frame(
  p = c(0, 1, p_star),
  q = c(0, 1, q_star),
  etiqueta = c(
    "Eq. Puro 1: (Futbol, Futbol)\np=0, q=0 | Pagos: (2, 3)",
    "Eq. Puro 2: (Opera, Opera)\np=1, q=1 | Pagos: (3, 2)",
    "Eq. Mixto de Nash\np*=0.60, q*=0.40 | Pagos: (1.2, 1.2)"
  ),
  tipo = c("Puro", "Puro", "Mixto")
)

# Generar grafico de alta calidad con ggplot2
p_nash <- ggplot() +
  # Lineas de correspondencia de mejor respuesta
  geom_line(data = br1_df, aes(x = p, y = q, color = "BR1(q): Jugador 1 (Ella)"), linewidth = 1.3) +
  geom_line(data = br2_df, aes(x = p, y = q, color = "BR2(p): Jugador 2 (El)"), linewidth = 1.3, linetype = "dashed") +
  # Lineas de referencia de indiferencia
  geom_vline(xintercept = p_star, linetype = "dotted", color = "gray50", alpha = 0.7) +
  geom_hline(yintercept = q_star, linetype = "dotted", color = "gray50", alpha = 0.7) +
  # Puntos de equilibrio
  geom_point(data = eq_puntos, aes(x = p, y = q, fill = tipo), size = 5, shape = 21, stroke = 1.5, color = "black") +
  # Anotaciones
  annotate("text", x = 0.12, y = 0.08, label = "NE Puro:\n(Futbol, Futbol)", fontface = "bold", size = 3.6, color = "#1b4332") +
  annotate("text", x = 0.88, y = 0.92, label = "NE Puro:\n(Opera, Opera)", fontface = "bold", size = 3.6, color = "#1b4332") +
  annotate("text", x = 0.62, y = 0.32, label = "NE Mixto:\np*=0.60, q*=0.40", fontface = "bold", size = 3.6, color = "#8b0000") +
  scale_color_manual(
    name = "Correspondencia de Mejor Respuesta",
    values = c("BR1(q): Jugador 1 (Ella)" = "#0072B2", "BR2(p): Jugador 2 (El)" = "#D55E00")
  ) +
  scale_fill_manual(
    name = "Tipo de Equilibrio de Nash",
    values = c("Puro" = "#2a9d8f", "Mixto" = "#e76f51")
  ) +
  scale_x_continuous(breaks = seq(0, 1, 0.2), limits = c(-0.02, 1.02)) +
  scale_y_continuous(breaks = seq(0, 1, 0.2), limits = c(-0.02, 1.02)) +
  labs(
    title = "Equilibrios de Nash en Estrategias Puras y Mixtas (Batalla de los Sexos)",
    subtitle = "Correspondencias de mejor respuesta cruzandose en [0,1]x[0,1] (Teorema de Nash 1950)",
    x = "p = Probabilidad de que Jugador 1 elija Opera",
    y = "q = Probabilidad de que Jugador 2 elija Opera",
    caption = "Fuente: Nobel_economics (Nash 1950, 1951). El punto mixto es el unico equilibrio completamente interior."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 13, hjust = 0),
    plot.subtitle = element_text(size = 10, color = "gray30", margin = margin(b = 10)),
    legend.position = "bottom",
    legend.box = "vertical",
    legend.spacing.y = unit(0.2, "cm"),
    panel.grid.minor = element_blank()
  )

ruta_fig1 <- file.path(dir_salidas, "fig_nash_equilibrio_mixto.png")
ggsave(ruta_fig1, plot = p_nash, width = 8, height = 7, dpi = 300)
cat("Guardada figura 1:", ruta_fig1, "\n\n")

# ==============================================================================
# SECCION 2: EQUILIBRIO PERFECTO EN SUBJUEGOS (SPE) Y REFINAMIENTO DE SELTEN (1965)
# ==============================================================================

cat("2. Analizando Juego Dinamico de Entrada y Refinamiento de Selten (1965)...\n")

# Modelo de Entrada al Mercado:
# Jugador 1 (Entrante E): {Entrar (E), Quedarse Fuera (O)}
# Jugador 2 (Incumbente I): {Acomodar (A), Pelear/Guerra de Precios (F)}
# Pagos:
# Si E juega O -> Pagos: (0, 2)
# Si E juega E y I juega A -> Pagos: (1, 1)
# Si E juega E y I juega F -> Pagos: (-1, -1)

# En forma normal estatica, hay 2 equilibrios de Nash:
# NE 1: (Entrar, Acomodar) con pagos (1, 1)
# NE 2: (Fuera, Pelear) con pagos (0, 2) [Sostenido por una amenaza no creible]

# Refinamiento de Selten (SPE):
# En el subjuego posterior a la entrada, el incumbente decide entre:
# u_I(A) = 1 vs u_I(F) = -1. Como 1 > -1, A domina estrictamente a F.
# La amenaza de pelear NO es creible. Unico SPE: (Entrar, Acomodar).

# Extension Bayesiana de Harsanyi (1967):
# Que pasa si la naturaleza elige el tipo del incumbente:
# Tipo Agresivo (costo bajo, disfruta pelear): u_I(F)=0 > u_I(A)=-1 -> Siempre Pelea
# Tipo Racional (costo normal): u_I(A)=1 > u_I(F)=-1 -> Siempre Acomoda
# Sea mu = Pr(Incumbente Agresivo).
# Retorno esperado del Entrante al entrar:
# EU_E(Entrar; mu) = mu*(-1) + (1 - mu)*(1) = 1 - 2*mu
# Retorno esperado si se queda fuera:
# EU_E(Fuera) = 0
# Entrada optima si 1 - 2*mu > 0 <=> mu < 0.50.

# Malla de probabilidades a priori para el analisis bayesiano
mu_seq <- seq(0, 1, length.out = 300)
eu_entrar <- 1 - 2 * mu_seq
eu_fuera <- rep(0, length(mu_seq))

df_bayes <- data.frame(
  mu = mu_seq,
  eu_entrar = eu_entrar,
  eu_fuera = eu_fuera
)

# Generar visualizacion combinada:
# Panel A: Diagrama conceptual del arbol y la induccion hacia atras
# Panel B: Respuesta bayesiana frente a la creencia a priori de tipo agresivo

p_bayes <- ggplot(df_bayes, aes(x = mu)) +
  geom_ribbon(aes(ymin = pmin(eu_entrar, 0), ymax = pmax(eu_entrar, 0), fill = eu_entrar > 0), alpha = 0.25) +
  geom_line(aes(y = eu_entrar, color = "EU(Entrar) = 1 - 2*mu"), linewidth = 1.3) +
  geom_line(aes(y = eu_fuera, color = "EU(Quedarse Fuera) = 0"), linewidth = 1.1, linetype = "dashed") +
  geom_vline(xintercept = 0.50, linetype = "dotted", color = "#8b0000", linewidth = 1) +
  annotate("point", x = 0.50, y = 0, color = "#8b0000", size = 4) +
  annotate("text", x = 0.22, y = 0.45, label = "Zona de Entrada Racional\n(EU_Entrar > 0)", color = "#1b4332", fontface = "bold", size = 3.8) +
  annotate("text", x = 0.78, y = -0.45, label = "Zona de Disuasion Efectiva\n(EU_Entrar < 0)", color = "#8b0000", fontface = "bold", size = 3.8) +
  annotate("text", x = 0.50, y = 0.15, label = "Umbral Critico de Harsanyi\nmu* = 0.50", color = "#8b0000", fontface = "italic", size = 3.4) +
  scale_fill_manual(
    name = "Decision Optima del Entrante",
    values = c("TRUE" = "#2a9d8f", "FALSE" = "#e76f51"),
    labels = c("TRUE" = "Entrar al mercado", "FALSE" = "Permanecer fuera")
  ) +
  scale_color_manual(
    name = "Utilidad Esperada",
    values = c("EU(Entrar) = 1 - 2*mu" = "#0072B2", "EU(Quedarse Fuera) = 0" = "#495057")
  ) +
  scale_x_continuous(breaks = seq(0, 1, 0.1), limits = c(0, 1)) +
  scale_y_continuous(breaks = seq(-1, 1, 0.5), limits = c(-1.05, 1.05)) +
  labs(
    title = "Refinamiento Dinamico de Selten y Extension Bayesiana de Harsanyi",
    subtitle = "Decision de entrada cuando el Incumbente puede ser de tipo Agresivo con probabilidad a priori mu",
    x = expression(paste("Creencia a Priori sobre Tipo Agresivo / Fuerte (", mu, " = Pr(Agresivo))")),
    y = "Utilidad Esperada del Entrante (EU)",
    caption = "Fuente: Nobel_economics (Selten 1965, Harsanyi 1967). Si mu=0 (informacion completa), el SPE de Selten predice Entrada.\nSi mu > 0.50, la amenaza del incumbente adquiere credibilidad bayesiana y disuade la entrada."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 13, hjust = 0),
    plot.subtitle = element_text(size = 10, color = "gray30", margin = margin(b = 10)),
    legend.position = "bottom",
    legend.box = "horizontal",
    panel.grid.minor = element_blank()
  )

ruta_fig2 <- file.path(dir_salidas, "fig_selten_juego_dinamico_spe.png")
ggsave(ruta_fig2, plot = p_bayes, width = 9, height = 6.5, dpi = 300)
cat("Guardada figura 2:", ruta_fig2, "\n\n")

# ==============================================================================
# SECCION 3: TABLA MAESTRA COMPARATIVA DE RESULTADOS Y EQUILIBRIOS
# ==============================================================================

cat("3. Generando tabla de resultados comparativa...\n")

tab_resultados <- tibble(
  juego = c(
    "Dilema del Prisionero",
    "Batalla de los Sexos",
    "Batalla de los Sexos",
    "Batalla de los Sexos",
    "Entrada al Mercado (Estatico)",
    "Entrada al Mercado (Estatico)",
    "Entrada al Mercado (Dinamico)",
    "Entrada Bayesiana (Harsanyi, mu < 0.5)",
    "Entrada Bayesiana (Harsanyi, mu > 0.5)"
  ),
  laureado_principal = c(
    "Nash (1950)",
    "Nash (1950)",
    "Nash (1950)",
    "Nash (1950)",
    "Nash (1951)",
    "Nash (1951)",
    "Selten (1965)",
    "Harsanyi (1967)",
    "Harsanyi (1967)"
  ),
  forma_juego = c(
    "Normal 2x2",
    "Normal 2x2",
    "Normal 2x2",
    "Normal 2x2",
    "Normal 2x2",
    "Normal 2x2",
    "Extensiva 2 Etapas",
    "Bayesiana",
    "Bayesiana"
  ),
  concepto_equilibrio = c(
    "Nash Puro (Estrategia Dominante)",
    "Nash Puro (Coordinacion 1)",
    "Nash Puro (Coordinacion 2)",
    "Nash Mixto (Indiferencia)",
    "Nash Puro 1 (Induccion hacia adelante)",
    "Nash Puro 2 (Amenaza no creible)",
    "Equilibrio Perfecto en Subjuegos (SPE)",
    "Equilibrio de Nash Bayesiano (BNE)",
    "Equilibrio de Nash Bayesiano (BNE)"
  ),
  perfil_estrategias = c(
    "(Confesar, Confesar)",
    "(Opera, Opera)",
    "(Futbol, Futbol)",
    "(p*=0.60, q*=0.40)",
    "(Entrar, Acomodar)",
    "(Fuera, Pelear)",
    "E: Entrar; I: Acomodar si Entra",
    "E: Entrar; I: Pelear si Agresivo, Acomodar si Racional",
    "E: Fuera; I: Pelear si Agresivo, Acomodar si Racional"
  ),
  prob_p = c(1.0, 1.0, 0.0, 0.60, 1.0, 0.0, 1.0, 1.0, 0.0),
  prob_q = c(1.0, 1.0, 0.0, 0.40, 1.0, 0.0, 1.0, 0.5, 0.5),
  pago_j1 = c(1.0, 3.0, 2.0, 1.20, 1.0, 0.0, 1.0, "1 - 2*mu (>0)", 0.0),
  pago_j2 = c(1.0, 2.0, 3.0, 1.20, 1.0, 2.0, 1.0, "mu*0 + (1-mu)*1", 2.0),
  es_spe = c(
    "N/A (Estatico)",
    "N/A (Estatico)",
    "N/A (Estatico)",
    "N/A (Estatico)",
    "SI",
    "NO (Amenaza descartada por induccion hacia atras)",
    "SI (Unico equilibrio creible)",
    "SI (Bayes-Nash en juego estatico transformado)",
    "SI (Bayes-Nash en juego estatico transformado)"
  ),
  interpretacion_economica = c(
    "Resultado ineficiente en sentido de Pareto por incentivos individuales al oportunismo.",
    "Coordinacion eficiente que favorece a la jugadora 1.",
    "Coordinacion eficiente que favorece al jugador 2.",
    "Equilibrio mixto interior: descoordina el 52% de las veces; pagos esperados inferiores a ambos puros.",
    "Entrada exitosa en duopolio; incumbente no puede comprometerse a una guerra de precios costosa.",
    "Equilibrio espurio de forma normal: el entrante teme una represalia que no seria racional ejecutar.",
    "El refinamiento de Selten elimina la amenaza no creible y predice entrada competitiva garantizada.",
    "Si la probabilidad de encontrar un incumbente agresivo es baja (mu < 0.5), entrar sigue siendo rentable.",
    "La incertidumbre informacional sobre la agresividad del rival disuade la entrada (paradoja de la cadena de tiendas)."
  )
)

ruta_csv <- file.path(dir_salidas, "tab_resultados_juegos_1994.csv")
write.csv(tab_resultados, file = ruta_csv, row.names = FALSE, fileEncoding = "UTF-8")
cat("Guardada tabla CSV:", ruta_csv, "\n\n")

cat("=== Replicacion ejecutada con exito total ===\n")

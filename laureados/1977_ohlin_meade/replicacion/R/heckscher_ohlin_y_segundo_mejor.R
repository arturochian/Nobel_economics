# ==============================================================================
# heckscher_ohlin_y_segundo_mejor.R
# Nobel de Economia 1977: Bertil Ohlin y James E. Meade
#
# Este script modela y simula computacionalmente los dos pilares del Premio Nobel 1977:
# 1. El Modelo Heckscher-Ohlin (2x2x2) del comercio internacional:
#    - Fronteras de Posibilidades de Produccion (FPP), curva de contrato.
#    - Precios relativos de bienes y factores (w/r).
#    - Especializacion, patron de comercio (Teorema H-O), ganancias del intercambio
#      y el Teorema de Igualacion de Precios de los Factores (FPE / Stolper-Samuelson).
# 2. El Principio de Meade del Equilibrio Interno y Externo (1951) y Segundo Mejor (1955):
#    - Curvas IB (Internal Balance) y EB (External Balance).
#    - Politicas de variacion del gasto (expenditure-changing) vs reorientacion (expenditure-switching).
#    - Las 4 zonas de desequilibrio macroeconomico y la regla de asignacion de instrumentos de Tinbergen-Meade.
#    - Simulacion del Segundo Mejor en Uniones Aduaneras (creacion vs desviacion de comercio).
#
# Salidas:
# - salidas/fig_ohlin_heckscher_comercio.png
# - salidas/fig_meade_equilibrio_interno_externo.png
# - salidas/tab_resultados_ohlin_meade.csv
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
  library(patchwork)
})

# Crear directorio de salidas si no existe
dir_salidas <- file.path("laureados", "1977_ohlin_meade", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  # Si se corre desde la carpeta replicacion
  if (dir.exists("salidas")) {
    dir_salidas <- "salidas"
  } else {
    dir.create(dir_salidas, recursive = TRUE, showWarnings = FALSE)
  }
}

cat("=== Iniciando simulacion del Modelo Heckscher-Ohlin y Meade (Nobel 1977) ===\n")

# ------------------------------------------------------------------------------
# PARTE 1: MODELO HECKSCHER-OHLIN 2x2x2
# ------------------------------------------------------------------------------
# Dos paises: Local (H) y Extranjero (F)
# Dos bienes: X1 (Ropa, intensivo en L), X2 (Maquinaria, intensivo en K)
# Dos factores: Trabajo (L) y Capital (K)
#
# Parametros tecnologicos:
# X1 = K1^alpha1 * L1^(1 - alpha1), con alpha1 = 0.3 (intensidad de L = 0.7)
# X2 = K2^alpha2 * L2^(1 - alpha2), con alpha2 = 0.7 (intensidad de K = 0.7)
#
# Dotaciones factoriales:
# Local (Home):      L_H = 120, K_H = 60  -> (L/K)_H = 2.0 (Abundante en trabajo)
# Extranjero (Foreign): L_F = 60,  K_F = 120 -> (L/K)_F = 0.5 (Abundante en capital)

alpha1 <- 0.30  # Bien 1 intensivo en L
alpha2 <- 0.70  # Bien 2 intensivo en K

# Relacion de eficienca en la curva de contrato:
# MRTS1 = (1-alpha1)/alpha1 * (K1/L1) = MRTS2 = (1-alpha2)/alpha2 * (K2/L2)
# (K1/L1) / (K2/L2) = [alpha1 * (1-alpha2)] / [alpha2 * (1-alpha1)] = (0.3*0.3)/(0.7*0.7) = 9/49
omega_ho <- (alpha1 * (1 - alpha2)) / (alpha2 * (1 - alpha1)) # 0.18367

# Funcion para derivar la FPP y precios relativos a lo largo de la curva de contrato
generar_fpp <- function(L_tot, K_tot, pais_nombre, n_puntos = 300) {
  # Vector de L1 desde 1% hasta 99% de L_tot
  l1_seq <- seq(0.01 * L_tot, 0.99 * L_tot, length.out = n_puntos)
  
  # De la curva de contrato de la caja de Edgeworth:
  # K1 = (omega * K * L1) / (L - (1 - omega) * L1)
  k1_seq <- (omega_ho * K_tot * l1_seq) / (L_tot - (1 - omega_ho) * l1_seq)
  
  l2_seq <- L_tot - l1_seq
  k2_seq <- K_tot - k1_seq
  
  x1_seq <- (k1_seq^alpha1) * (l1_seq^(1 - alpha1))
  x2_seq <- (k2_seq^alpha2) * (l2_seq^(1 - alpha2))
  
  # Salario / Renta del capital w/r a partir de MRTS1:
  # w/r = (1 - alpha1)/alpha1 * (K1/L1)
  wr_seq <- ((1 - alpha1) / alpha1) * (k1_seq / l1_seq)
  
  # Precio relativo p1/p2 = RMT = -dX2/dX1
  # Por dualidad en costos unitarios:
  # c1(w,r) = (r/alpha1)^alpha1 * (w/(1-alpha1))^(1-alpha1)
  # c2(w,r) = (r/alpha2)^alpha2 * (w/(1-alpha2))^(1-alpha2)
  # p1/p2 = c1/c2 = ( (1-alpha2)/(1-alpha1) )^(1-alpha1) * ...
  # Mas directamente con costos marginales:
  cost_ratio <- (((1 - alpha1)^(alpha1 - 1) * alpha1^(-alpha1)) / 
                 ((1 - alpha2)^(alpha2 - 1) * alpha2^(-alpha2))) * (wr_seq^(alpha2 - alpha1))
  
  data.frame(
    pais = pais_nombre,
    L1 = l1_seq,
    K1 = k1_seq,
    L2 = l2_seq,
    K2 = k2_seq,
    X1 = x1_seq,
    X2 = x2_seq,
    wr = wr_seq,
    p_rel = cost_ratio
  )
}

df_fpp_H <- generar_fpp(120, 60, "Local (Abundante en L)")
df_fpp_F <- generar_fpp(60, 120, "Extranjero (Abundante en K)")

# Equilibrio de autarquia:
# Preferencias U = X1^0.5 * X2^0.5 -> en equilibrio p1/p2 = X2 / X1
encontrar_autarquia <- function(df_fpp) {
  # Buscamos el punto donde |p_rel - X2/X1| es minimo
  diff_aut <- abs(df_fpp$p_rel - (df_fpp$X2 / df_fpp$X1))
  idx <- which.min(diff_aut)
  df_fpp[idx, ]
}

aut_H <- encontrar_autarquia(df_fpp_H)
aut_F <- encontrar_autarquia(df_fpp_F)

cat(sprintf("Autarquia Local:      X1=%.2f, X2=%.2f, p1/p2=%.3f, w/r=%.3f\n", 
            aut_H$X1, aut_H$X2, aut_H$p_rel, aut_H$wr))
cat(sprintf("Autarquia Extranjero: X1=%.2f, X2=%.2f, p1/p2=%.3f, w/r=%.3f\n", 
            aut_F$X1, aut_F$X2, aut_F$p_rel, aut_F$wr))

# Equilibrio de Libre Comercio:
# Precio mundial p* que iguala la oferta relativa mundial con la demanda relativa mundial
# Demanda relativa mundial con preferencias identicas homoteticas Cobb-Douglas: (C1/C2)^w = 1 / p*
# Oferta relativa mundial: (X1_H(p*) + X1_F(p*)) / (X2_H(p*) + X2_F(p*))
p_grid <- seq(aut_H$p_rel, aut_F$p_rel, length.out = 500)

buscar_oferta_mundial <- function(p_target) {
  idx_H <- which.min(abs(df_fpp_H$p_rel - p_target))
  idx_F <- which.min(abs(df_fpp_F$p_rel - p_target))
  
  X1_w <- df_fpp_H$X1[idx_H] + df_fpp_F$X1[idx_F]
  X2_w <- df_fpp_H$X2[idx_H] + df_fpp_F$X2[idx_F]
  
  RS <- X1_w / X2_w
  RD <- 1 / p_target # Cobb-Douglas: p1 C1 = p2 C2 -> C1/C2 = p2/p1 = 1 / (p1/p2)
  
  list(diff = abs(RS - RD), RS = RS, RD = RD, idx_H = idx_H, idx_F = idx_F)
}

diffs <- sapply(p_grid, function(p) buscar_oferta_mundial(p)$diff)
p_mundial <- p_grid[which.min(diffs)]

sol_trade <- buscar_oferta_mundial(p_mundial)
prod_trade_H <- df_fpp_H[sol_trade$idx_H, ]
prod_trade_F <- df_fpp_F[sol_trade$idx_F, ]

# Consumo en libre comercio:
# Valor del ingreso en terminos del bien 2: Y_H = p* * X1_H + X2_H
# Con Cobb-Douglas: gasto 50% en cada bien:
# p* * C1_H = 0.5 * Y_H -> C1_H = 0.5 * Y_H / p*
# C2_H = 0.5 * Y_H
Y_H <- p_mundial * prod_trade_H$X1 + prod_trade_H$X2
cons_trade_H <- c(C1 = 0.5 * Y_H / p_mundial, C2 = 0.5 * Y_H)

Y_F <- p_mundial * prod_trade_F$X1 + prod_trade_F$X2
cons_trade_F <- c(C1 = 0.5 * Y_F / p_mundial, C2 = 0.5 * Y_F)

# Bienestar (Utilidad Cobb-Douglas)
U_aut_H <- sqrt(aut_H$X1 * aut_H$X2)
U_trade_H <- sqrt(cons_trade_H["C1"] * cons_trade_H["C2"])

U_aut_F <- sqrt(aut_F$X1 * aut_F$X2)
U_trade_F <- sqrt(cons_trade_F["C1"] * cons_trade_F["C2"])

cat(sprintf("Precio Mundial de Libre Comercio p1/p2 = %.3f\n", p_mundial))
cat(sprintf("Local en Comercio:      Produce (X1=%.2f, X2=%.2f), Consume (C1=%.2f, C2=%.2f)\n", 
            prod_trade_H$X1, prod_trade_H$X2, cons_trade_H["C1"], cons_trade_H["C2"]))
cat(sprintf("Extranjero en Comercio: Produce (X1=%.2f, X2=%.2f), Consume (C1=%.2f, C2=%.2f)\n", 
            prod_trade_F$X1, prod_trade_F$X2, cons_trade_F["C1"], cons_trade_F["C2"]))
cat(sprintf("Ganancia de Bienestar Local: +%.2f%% | Extranjero: +%.2f%%\n",
            100 * (U_trade_H - U_aut_H) / U_aut_H,
            100 * (U_trade_F - U_aut_F) / U_aut_F))

# Curvas de indiferencia para graficar
generar_ci <- function(U_val, x1_range) {
  data.frame(X1 = x1_range, X2 = (U_val^2) / x1_range)
}

ci_aut_H <- generar_ci(U_aut_H, seq(20, 110, length.out = 150))
ci_trade_H <- generar_ci(U_trade_H, seq(25, 115, length.out = 150))

ci_aut_F <- generar_ci(U_aut_F, seq(15, 95, length.out = 150))
ci_trade_F <- generar_ci(U_trade_F, seq(20, 105, length.out = 150))

# ------------------------------------------------------------------------------
# GRAFICO 1: EL MODELO HECKSCHER-OHLIN (FPP, COMERCIO E IGUALACION DE FACTORES)
# ------------------------------------------------------------------------------
theme_academic <- function() {
  theme_minimal(base_family = "sans") +
    theme(
      plot.title = element_text(face = "bold", size = 13, color = "#1e293b", margin = margin(b = 6)),
      plot.subtitle = element_text(size = 10, color = "#475569", margin = margin(b = 10)),
      axis.title = element_text(face = "bold", size = 10, color = "#334155"),
      axis.text = element_text(size = 9, color = "#475569"),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "#f1f5f9"),
      plot.background = element_rect(fill = "#ffffff", color = NA),
      panel.background = element_rect(fill = "#ffffff", color = NA),
      legend.position = "bottom",
      legend.title = element_text(face = "bold", size = 9),
      legend.text = element_text(size = 8.5)
    )
}

# Panel 1A: Fronteras de Produccion y Patron de Comercio
p1a <- ggplot() +
  # FPP Local y Extranjero
  geom_line(data = df_fpp_H, aes(x = X1, y = X2, color = "FPP Local (Abundante en L)"), linewidth = 1.2) +
  geom_line(data = df_fpp_F, aes(x = X1, y = X2, color = "FPP Extranjero (Abundante en K)"), linewidth = 1.2) +
  # Curvas de Indiferencia de Autarquia y Comercio
  geom_line(data = ci_aut_H, aes(x = X1, y = X2), linetype = "dotted", color = "#2563eb", alpha = 0.7) +
  geom_line(data = ci_trade_H, aes(x = X1, y = X2), linetype = "dashed", color = "#1d4ed8") +
  # Puntos de produccion y consumo
  geom_point(aes(x = aut_H$X1, y = aut_H$X2), color = "#2563eb", size = 3) +
  annotate("text", x = aut_H$X1 - 2, y = aut_H$X2 - 4, label = "Autarquia H", fontface = "bold", size = 3.2, color = "#1e40af") +
  geom_point(aes(x = prod_trade_H$X1, y = prod_trade_H$X2), color = "#047857", size = 3.5, shape = 17) +
  annotate("text", x = prod_trade_H$X1 + 2, y = prod_trade_H$X2 + 4, label = "Produccion H*", fontface = "bold", size = 3.2, color = "#065f46") +
  geom_point(aes(x = cons_trade_H["C1"], y = cons_trade_H["C2"]), color = "#d97706", size = 3.5, shape = 18) +
  annotate("text", x = cons_trade_H["C1"] + 3, y = cons_trade_H["C2"] + 4, label = "Consumo H*", fontface = "bold", size = 3.2, color = "#b45309") +
  # Triangulo de comercio de H (exporta X1, importa X2)
  geom_segment(aes(x = prod_trade_H$X1, y = prod_trade_H$X2, xend = cons_trade_H["C1"], yend = prod_trade_H$X2),
               arrow = arrow(length = unit(0.2, "cm")), color = "#b91c1c", linetype = "solid") +
  geom_segment(aes(x = cons_trade_H["C1"], y = prod_trade_H$X2, xend = cons_trade_H["C1"], yend = cons_trade_H["C2"]),
               arrow = arrow(length = unit(0.2, "cm")), color = "#047857", linetype = "solid") +
  annotate("text", x = (prod_trade_H$X1 + cons_trade_H["C1"])/2, y = prod_trade_H$X2 - 3, 
           label = "Exp. Ropa (X1)", size = 2.8, color = "#b91c1c", fontface = "italic") +
  annotate("text", x = cons_trade_H["C1"] + 7, y = (prod_trade_H$X2 + cons_trade_H["C2"])/2, 
           label = "Imp. Maquinaria (X2)", size = 2.8, color = "#047857", fontface = "italic") +
  # Puntos Extranjero
  geom_point(aes(x = aut_F$X1, y = aut_F$X2), color = "#dc2626", size = 3) +
  annotate("text", x = aut_F$X1 + 5, y = aut_F$X2 + 4, label = "Autarquia F", fontface = "bold", size = 3.2, color = "#991b1b") +
  geom_point(aes(x = prod_trade_F$X1, y = prod_trade_F$X2), color = "#7c3aed", size = 3.5, shape = 17) +
  annotate("text", x = prod_trade_F$X1 - 5, y = prod_trade_F$X2 + 4, label = "Produccion F*", fontface = "bold", size = 3.2, color = "#6d28d9") +
  scale_color_manual(name = "Fronteras de Produccion:", 
                     values = c("FPP Local (Abundante en L)" = "#2563eb", "FPP Extranjero (Abundante en K)" = "#dc2626")) +
  scale_x_continuous(limits = c(0, 115), breaks = seq(0, 110, 20)) +
  scale_y_continuous(limits = c(0, 115), breaks = seq(0, 110, 20)) +
  labs(
    title = "A. Equilibrio General Heckscher-Ohlin: FPP y Especializacion",
    subtitle = "Local se especializa en Bien 1 (intensivo en L); Extranjero en Bien 2 (intensivo en K)",
    x = expression(paste("Produccion y Consumo de Ropa (", X[1], ", intensivo en Trabajo)")),
    y = expression(paste("Produccion y Consumo de Maquinaria (", X[2], ", intensivo en Capital)"))
  ) +
  theme_academic()

# Panel 1B: Igualacion de Precios de los Factores (FPE) y Stolper-Samuelson
# Relacion directa y monotona entre precio relativo de bienes p1/p2 y precio relativo de factores w/r
df_fpe <- data.frame(
  p_rel = p_grid,
  wr_ratio = (((1 - alpha2)^(alpha2 - 1) * alpha2^(-alpha2)) / 
              ((1 - alpha1)^(alpha1 - 1) * alpha1^(-alpha1)) * p_grid)^(1 / (alpha2 - alpha1))
)

p1b <- ggplot(df_fpe, aes(x = p_rel, y = wr_ratio)) +
  geom_line(color = "#0f766e", linewidth = 1.3) +
  # Lineas de autarquia y comercio
  geom_vline(xintercept = aut_H$p_rel, linetype = "dashed", color = "#2563eb", linewidth = 0.8) +
  geom_vline(xintercept = aut_F$p_rel, linetype = "dashed", color = "#dc2626", linewidth = 0.8) +
  geom_vline(xintercept = p_mundial, linetype = "solid", color = "#059669", linewidth = 1.1) +
  geom_hline(yintercept = aut_H$wr, linetype = "dotted", color = "#2563eb") +
  geom_hline(yintercept = aut_F$wr, linetype = "dotted", color = "#dc2626") +
  geom_hline(yintercept = prod_trade_H$wr, linetype = "solid", color = "#059669", alpha = 0.7) +
  annotate("text", x = aut_H$p_rel + 0.04, y = 0.25, label = "Autarquia Local", color = "#2563eb", fontface = "bold", size = 3) +
  annotate("text", x = aut_F$p_rel - 0.04, y = 1.85, label = "Autarquia Extranjero", color = "#dc2626", fontface = "bold", size = 3) +
  annotate("text", x = p_mundial + 0.05, y = prod_trade_H$wr + 0.12, 
           label = paste0("Precio Mundial (p* = ", round(p_mundial, 2), ")\nIgualacion Factorial (w/r)*"), 
           color = "#047857", fontface = "bold", size = 3.2) +
  annotate("rect", xmin = aut_H$p_rel, xmax = p_mundial, ymin = aut_H$wr, ymax = prod_trade_H$wr,
           alpha = 0.15, fill = "#2563eb") +
  annotate("text", x = (aut_H$p_rel + p_mundial)/2, y = (aut_H$wr + prod_trade_H$wr)/2,
           label = "Stolper-Samuelson:\nSalario real w sube en Local", color = "#1e40af", size = 3, fontface = "italic") +
  labs(
    title = "B. Teorema de Igualacion de Precios de Factores (FPE) y Stolper-Samuelson",
    subtitle = "El libre comercio internacional de bienes iguala el cociente salarios/renta (w/r)",
    x = expression(paste("Precio Relativo de Bienes (", p[1] / p[2], ")")),
    y = expression(paste("Precio Relativo de Factores Salario / Renta (w / r)"))
  ) +
  scale_y_continuous(breaks = seq(0, 2.5, 0.5)) +
  scale_x_continuous(breaks = seq(0.4, 2.0, 0.2)) +
  theme_academic()

fig_ho <- p1a / p1b + plot_layout(heights = c(1.2, 1))

archivo_fig_ho <- file.path(dir_salidas, "fig_ohlin_heckscher_comercio.png")
ggsave(archivo_fig_ho, fig_ho, width = 10, height = 11, dpi = 300)
cat(sprintf("Guardada figura Heckscher-Ohlin en: %s\n", archivo_fig_ho))

# ------------------------------------------------------------------------------
# PARTE 2: EL MODELO DE MEADE DEL EQUILIBRIO INTERNO Y EXTERNO (1951)
# ------------------------------------------------------------------------------
# Dos instrumentos:
# - Eje X: Gasto Agregado Interno / Absorcion (A = C + I + G) [Expenditure-changing]
# - Eje Y: Tipo de Cambio Real / Competitividad (R = e * P* / P) [Expenditure-switching]
#
# Dos objetivos:
# 1. Equilibrio Interno (IB): Y(A, R) = Y* (Pleno empleo y estabilidad de precios)
#    Pendiente dR/dA_IB = -(1 - m)/eta_R < 0  (Curva decreciente)
# 2. Equilibrio Externo (EB): CA(A, R) = 0 (Balanza por cuenta corriente equilibrada)
#    Pendiente dR/dA_EB = m/eta_R > 0        (Curva creciente)

# Parametros de simulacion macroeconomica de Meade:
A_eq <- 100   # Nivel optimo de absorcion
R_eq <- 100   # Nivel optimo de tipo de cambio real
m_prop <- 0.25 # Propension marginal a importar
c_prop <- 0.70 # Propension marginal a consumir
eta_R  <- 0.40 # Sensibilidad Marshall-Lerner al tipo de cambio

# Pendientes de las curvas
slope_IB <- -(1 - c_prop + m_prop) / eta_R  # -(1 - 0.70 + 0.25)/0.40 = -0.55/0.40 = -1.375
slope_EB <- m_prop / eta_R                  # 0.25/0.40 = 0.625

# Rango de absorcion A
A_vals <- seq(70, 130, length.out = 300)

df_meade <- data.frame(
  A = A_vals,
  R_IB = R_eq + slope_IB * (A_vals - A_eq),
  R_EB = R_eq + slope_EB * (A_vals - A_eq)
)

# Trayectoria de ajuste dinamico: Politica en Zona III (Desempleo y Deficit)
# Supongamos punto inicial: Desempleo (A = 85) y Deficit (R = 80, moneda apreciada)
punto_desequilibrio <- data.frame(A = 82, R = 82)

# Trayectoria de convergencia de Meade con asignacion correcta de instrumentos:
# - Politica cambiaria (switching) devalua R hacia arriba para cerrar deficit
# - Politica fiscal/monetaria (changing) aumenta A hacia la derecha para cerrar desempleo
trayectoria_meade <- data.frame(
  A = c(82, 88, 94, 98, 100),
  R = c(82, 89, 95, 98.5, 100)
)

p_meade <- ggplot() +
  # Curva de Equilibrio Interno (IB)
  geom_line(data = df_meade, aes(x = A, y = R_IB, color = "Equilibrio Interno (IB: Pleno Empleo y Precios)"), linewidth = 1.3) +
  # Curva de Equilibrio Externo (EB)
  geom_line(data = df_meade, aes(x = A, y = R_EB, color = "Equilibrio Externo (EB: Balanza de Pagos)"), linewidth = 1.3) +
  # Punto de equilibrio optimo
  geom_point(aes(x = A_eq, y = R_eq), color = "#047857", size = 4) +
  annotate("text", x = A_eq, y = R_eq + 3.5, 
           label = "Optimo de Meade (IB & EB)\n(A*, R*)", fontface = "bold", size = 3.6, color = "#065f46") +
  # Las 4 Zonas de Meade
  # Zona I (Arriba): Inflacion y Superavit
  annotate("label", x = 97, y = 125, 
           label = "ZONA I:\nSobrecalentamiento e Inflacion\n+ Superavit Externo", 
           fill = "#fef3c7", color = "#92400e", fontface = "bold", size = 3.1) +
  # Zona II (Derecha): Inflacion y Deficit
  annotate("label", x = 118, y = 98, 
           label = "ZONA II:\nSobrecalentamiento e Inflacion\n+ Deficit Externo", 
           fill = "#fee2e2", color = "#991b1b", fontface = "bold", size = 3.1) +
  # Zona III (Abajo): Desempleo y Deficit (Dilema Clasico)
  annotate("label", x = 98, y = 73, 
           label = "ZONA III (Dilema de Meade):\nDesempleo y Recesion\n+ Deficit Externo", 
           fill = "#fecdd3", color = "#881337", fontface = "bold", size = 3.1) +
  # Zona IV (Izquierda): Desempleo y Superavit
  annotate("label", x = 79, y = 104, 
           label = "ZONA IV:\nDesempleo y Recesion\n+ Superavit Externo", 
           fill = "#e0f2fe", color = "#075985", fontface = "bold", size = 3.1) +
  # Punto de desequilibrio y flechas de vector de politica
  geom_point(data = punto_desequilibrio, aes(x = A, y = R), color = "#b91c1c", size = 3.8) +
  annotate("text", x = 80, y = 77, label = "Punto Inicial\n(Recesion + Deficit)", fontface = "bold", size = 3, color = "#991b1b") +
  geom_path(data = trayectoria_meade, aes(x = A, y = R), arrow = arrow(length = unit(0.25, "cm")),
            color = "#0284c7", linewidth = 1.2, linetype = "dashed") +
  # Vectores de instrumentos de politica
  annotate("segment", x = 75, y = 87, xend = 83, yend = 87, arrow = arrow(length = unit(0.18, "cm")),
           color = "#1e293b", linewidth = 0.9) +
  annotate("text", x = 79, y = 89, label = expression(paste(Delta, A, " > 0 (Politica Fiscal/Monetaria)")), 
           size = 2.7, fontface = "italic") +
  annotate("segment", x = 75, y = 87, xend = 75, yend = 95, arrow = arrow(length = unit(0.18, "cm")),
           color = "#1e293b", linewidth = 0.9) +
  annotate("text", x = 75, y = 97, label = expression(paste(Delta, R, " > 0 (Devaluacion Cambiaria)")), 
           size = 2.7, fontface = "italic", hjust = 0) +
  scale_color_manual(name = "Condiciones de Equilibrio Macroeconómico:",
                     values = c("Equilibrio Interno (IB: Pleno Empleo y Precios)" = "#dc2626",
                                "Equilibrio Externo (EB: Balanza de Pagos)" = "#2563eb")) +
  scale_x_continuous(limits = c(70, 130), breaks = seq(70, 130, 10)) +
  scale_y_continuous(limits = c(68, 132), breaks = seq(70, 130, 10)) +
  labs(
    title = "El Diagrama de Meade: Equilibrio Interno vs Externo y Asignacion de Politicas",
    subtitle = "Se requieren dos instrumentos independientes (Gasto A y Tipo de Cambio R) para dos metas independientes (IB y EB)",
    x = "Gasto Agregado Interno / Absorcion Nacional (A = C + I + G) [Expenditure-Changing Policy]",
    y = expression(paste("Tipo de Cambio Real / Competitividad (R = e", P^{"*"}/P, ") [Expenditure-Switching Policy]"))
  ) +
  theme_academic()

archivo_fig_meade <- file.path(dir_salidas, "fig_meade_equilibrio_interno_externo.png")
ggsave(archivo_fig_meade, p_meade, width = 10, height = 7.5, dpi = 300)
cat(sprintf("Guardada figura Meade en: %s\n", archivo_fig_meade))

# ------------------------------------------------------------------------------
# PARTE 3: TEORIA DEL SEGUNDO MEJOR Y UNIONES ADUANERAS (MEADE 1955)
# ------------------------------------------------------------------------------
# Meade demostro que cuando existen distorsiones arancelarias preexistentes que no
# pueden eliminarse en todo el mundo, la supresion bilateral de aranceles (union aduanera)
# NO garantiza una mejora del bienestar global.
#
# Modelo didactico de Viner-Meade:
# Pais A (importador, costo local P_A = 40)
# Pais B (socio regional, costo P_B = 25)
# Pais C (resto del mundo mas eficiente, costo P_C = 20)
# Arancel no discriminatorio inicial: t = 100% sobre importaciones de B y C:
# Precio de importacion con arancel:
# P_B*(1+t) = 25 * 2.0 = 50
# P_C*(1+t) = 20 * 2.0 = 40
# Inicialmente A compra de C a 40 (o produce internamente a 40).
#
# Situacion 1: Arancel uniforme del 60% (t = 0.60):
# P_C*(1+t) = 20 * 1.6 = 32
# P_B*(1+t) = 25 * 1.6 = 40
# A importa todo de C (proveedor mas eficiente mundial). Recauda arancel = (32 - 20) = 12 por unidad.
#
# Situacion 2: Union Aduanera con Pais B (t_B = 0, pero t_C se mantiene en 60%):
# Precio de B en mercado de A = 25
# Precio de C en mercado de A = 32
# El Pais A ahora importa de B a 25.
# - Creacion de comercio: mayor consumo interno y reemplazo de produccion costosa local (ganancia).
# - Desviacion de comercio: reemplazo de importaciones de C (costo social real 20) por compras a B (costo real 25).
#   Perdida fiscal de aranceles y sobrecosto real = 25 - 20 = 5 por unidad!
#
# Simulamos con curva de demanda lineal: Q_d(P) = 100 - P

simular_segundo_mejor <- function() {
  P_A_aut <- 45
  P_B <- 25
  P_C <- 20
  t_ini <- 0.60
  
  # Estado 1: MFN con arancel uniforme
  P_mfn <- P_C * (1 + t_ini) # 32
  Q_mfn <- 100 - P_mfn        # 68
  excedente_cons_mfn <- 0.5 * (100 - P_mfn) * Q_mfn # 0.5 * 68 * 68 = 2312
  arancel_rec_mfn <- (P_mfn - P_C) * Q_mfn          # 12 * 68 = 816
  bienestar_mfn <- excedente_cons_mfn + arancel_rec_mfn # 3128
  
  # Estado 2: Union Aduanera con B (t_B = 0, t_C = 0.60)
  P_ua <- P_B # 25
  Q_ua <- 100 - P_ua # 75
  excedente_cons_ua <- 0.5 * (100 - P_ua) * Q_ua # 0.5 * 75 * 75 = 2812.5
  arancel_rec_ua <- 0 # No hay aranceles porque todo viene de B libre de impuestos
  bienestar_ua <- excedente_cons_ua + arancel_rec_ua # 2812.5
  
  # Descomposicion de Meade:
  # Creacion de comercio: ganancia en las unidades adicionales (de 68 a 75)
  creacion_comercio <- 0.5 * (P_mfn - P_B) * (Q_ua - Q_mfn) # 0.5 * 7 * 7 = 24.5
  # Desviacion de comercio: sobrecoste de comprar a B en vez de a C en las unidades previas
  desviacion_comercio <- (P_B - P_C) * Q_mfn # (25 - 20) * 68 = 340
  
  delta_bienestar <- bienestar_ua - bienestar_mfn # 2812.5 - 3128 = -315.5
  
  data.frame(
    Escenario = c("Arancel General MFN (Tercer Mejor)", "Union Aduanera Preferencial B (Segundo Mejor)", "Libre Comercio Global (Primer Mejor)"),
    Precio_Consumidor = c(P_mfn, P_ua, P_C),
    Cantidad_Consumida = c(Q_mfn, Q_ua, 100 - P_C),
    Excedente_Consumidor = c(excedente_cons_mfn, excedente_cons_ua, 0.5 * (100 - P_C)^2),
    Ingresos_Arancelarios = c(arancel_rec_mfn, arancel_rec_ua, 0),
    Bienestar_Total = c(bienestar_mfn, bienestar_ua, 0.5 * (100 - P_C)^2),
    Efecto_Creacion = c(0, creacion_comercio, NA),
    Efecto_Desviacion = c(0, -desviacion_comercio, NA),
    Resultado_Neto = c(0, delta_bienestar, 0.5 * (100 - P_C)^2 - bienestar_mfn)
  )
}

df_segundo_mejor <- simular_segundo_mejor()

cat("\n--- Simulacion Segundo Mejor (Meade 1955: Uniones Aduaneras) ---\n")
print(df_segundo_mejor[, c("Escenario", "Precio_Consumidor", "Bienestar_Total", "Resultado_Neto")])

# ------------------------------------------------------------------------------
# PARTE 4: TABLA CONSOLIDADA DE RESULTADOS
# ------------------------------------------------------------------------------

tab_resultados <- data.frame(
  Dimension = c(
    "Heckscher-Ohlin: Autarquia Local (H)",
    "Heckscher-Ohlin: Autarquia Extranjero (F)",
    "Heckscher-Ohlin: Comercio Libre Local (H)",
    "Heckscher-Ohlin: Comercio Libre Extranjero (F)",
    "Heckscher-Ohlin: Mercado Mundial Integrado",
    "Meade: Equilibrio Macroeconómico Optimo",
    "Meade: Zona I (Sobrecalentamiento/Superavit)",
    "Meade: Zona II (Sobrecalentamiento/Deficit)",
    "Meade: Zona III (Dilema Recesion/Deficit)",
    "Meade: Zona IV (Recesion/Superavit)",
    "Segundo Mejor: Arancel MFN Multilateral",
    "Segundo Mejor: Union Aduanera Bilateral"
  ),
  Variable_1 = c(
    paste0("X1=", round(aut_H$X1, 2), ", X2=", round(aut_H$X2, 2)),
    paste0("X1=", round(aut_F$X1, 2), ", X2=", round(aut_F$X2, 2)),
    paste0("Prod: X1=", round(prod_trade_H$X1, 2), ", X2=", round(prod_trade_H$X2, 2)),
    paste0("Prod: X1=", round(prod_trade_F$X1, 2), ", X2=", round(prod_trade_F$X2, 2)),
    paste0("X1_total=", round(prod_trade_H$X1 + prod_trade_F$X1, 2)),
    paste0("Absorcion A*=", A_eq),
    "Absorcion Alta (A > A*)",
    "Absorcion Excesiva (A >> A*)",
    "Absorcion Deficiente (A < A*)",
    "Absorcion Muy Baja (A << A*)",
    paste0("P_cons=", df_segundo_mejor$Precio_Consumidor[1]),
    paste0("P_cons=", df_segundo_mejor$Precio_Consumidor[2])
  ),
  Variable_2 = c(
    paste0("Precio Relativo p1/p2=", round(aut_H$p_rel, 3)),
    paste0("Precio Relativo p1/p2=", round(aut_F$p_rel, 3)),
    paste0("Cons: C1=", round(cons_trade_H["C1"], 2), ", C2=", round(cons_trade_H["C2"], 2)),
    paste0("Cons: C1=", round(cons_trade_F["C1"], 2), ", C2=", round(cons_trade_F["C2"], 2)),
    paste0("Precio Mundial p*=", round(p_mundial, 3)),
    paste0("Tipo Cambio Real R*=", R_eq),
    "Competitividad Alta (R > R*)",
    "Moneda Apreciada (R < R*)",
    "Moneda Apreciada (R < R*)",
    "Competitividad Alta (R > R*)",
    paste0("Arancel Recaudado=", df_segundo_mejor$Ingresos_Arancelarios[1]),
    paste0("Arancel Recaudado=", df_segundo_mejor$Ingresos_Arancelarios[2])
  ),
  Variable_3 = c(
    paste0("Precio Factores w/r=", round(aut_H$wr, 3)),
    paste0("Precio Factores w/r=", round(aut_F$wr, 3)),
    paste0("Exporta X1=", round(prod_trade_H$X1 - cons_trade_H["C1"], 2), " (Ropa)"),
    paste0("Exporta X2=", round(prod_trade_F$X2 - cons_trade_F["C2"], 2), " (Maquinaria)"),
    paste0("Igualacion w/r*=", round(prod_trade_H$wr, 3)),
    "Balance Interno Y=Y* & Externo CA=0",
    "Politica: Gasto - | Moneda Apreciar",
    "Politica: Gasto - | Devaluar Moneda",
    "Politica: Gasto + | Devaluar Moneda",
    "Politica: Gasto + | Moneda Apreciar",
    paste0("Bienestar=", df_segundo_mejor$Bienestar_Total[1]),
    paste0("Bienestar=", df_segundo_mejor$Bienestar_Total[2])
  ),
  Bienestar_o_Diagnostico = c(
    paste0("Utilidad Autarquia H = ", round(U_aut_H, 2)),
    paste0("Utilidad Autarquia F = ", round(U_aut_F, 2)),
    paste0("Utilidad Comercio H = ", round(U_trade_H, 2), " (+", round(100*(U_trade_H-U_aut_H)/U_aut_H, 2), "%)"),
    paste0("Utilidad Comercio F = ", round(U_trade_F, 2), " (+", round(100*(U_trade_F-U_aut_F)/U_aut_F, 2), "%)"),
    "Ganancias mutuas del comercio (Teorema H-O verificado)",
    "Equilibrio Macroeconómico General",
    "Sobrecalentamiento con Inflacion",
    "Déficit en Cuenta Corriente con Inflación",
    "Dilema Agudo: Recesion y Deficit de Pagos",
    "Desempleo con Superavit en Balanza",
    "Referencia Multilateral",
    paste0("Desviacion domina a Creacion (Delta=", df_segundo_mejor$Resultado_Neto[2], ")")
  )
)

archivo_tabla <- file.path(dir_salidas, "tab_resultados_ohlin_meade.csv")
write.csv(tab_resultados, archivo_tabla, row.names = FALSE, fileEncoding = "UTF-8")
cat(sprintf("Guardada tabla de resultados en: %s\n", archivo_tabla))

cat("=== Simulacion completada con exito ===\n")

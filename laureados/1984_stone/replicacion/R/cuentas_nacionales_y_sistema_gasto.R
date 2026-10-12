# ==============================================================================
# REPLICACION CUANTITATIVA: NOBEL DE ECONOMIA 1984 (SIR RICHARD STONE)
# Sistema de Cuentas Nacionales (SNA), Matrices de Contabilidad Social (SAM)
# y Sistema Lineal de Gasto (Linear Expenditure System - LES)
#
# Autor: Proyecto Nobel_economics
# Licencia: MIT
# ==============================================================================

options(warn = -1)

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(scales)
  library(patchwork)
})

# Fijar semilla para reproducibilidad estocástica
set.seed(1984)

# Definir rutas relativas
dir_salidas <- file.path("salidas")
if (!dir.exists(dir_salidas)) {
  # Si se ejecuta desde laureados/1984_stone/ o desde el root
  if (dir.exists("laureados/1984_stone/replicacion/salidas")) {
    dir_salidas <- "laureados/1984_stone/replicacion/salidas"
  } else if (dir.exists("replicacion/salidas")) {
    dir_salidas <- "replicacion/salidas"
  } else {
    dir.create(dir_salidas, recursive = TRUE, showWarnings = FALSE)
  }
}

cat("=== 1. SISTEMA LINEAL DE GASTO (LES / STONE-GEARY 1954) ===\n")

# Parametros estructurales del modelo de demanda de Stone (1954)
# 4 categorias agregadas de gasto:
# 1. Alimentos y bebidas (Food)
# 2. Vivienda y suministros (Housing & Utilities)
# 3. Ropa y calzado (Clothing)
# 4. Servicios, transporte y esparcimiento (Services & Other)

bienes <- c("Alimentos", "Vivienda", "Vestimenta", "Servicios y Otros")
n_bienes <- length(bienes)

# Cantidades minimas de subsistencia (gamma_i)
gamma <- c(Alimentos = 35, Vivienda = 25, Vestimenta = 12, `Servicios y Otros` = 15)

# Propensiones marginales al gasto (beta_i, deben sumar 1)
beta <- c(Alimentos = 0.15, Vivienda = 0.20, Vestimenta = 0.15, `Servicios y Otros` = 0.50)

# Precios normalizados base
precios_base <- c(Alimentos = 1.0, Vivienda = 1.2, Vestimenta = 0.8, `Servicios y Otros` = 1.5)

# Gasto total minimo de subsistencia: sum(p_i * gamma_i)
gasto_subsistencia_total <- sum(precios_base * gamma)
cat(sprintf("Gasto total de subsistencia (comprometido): %.2f\n", gasto_subsistencia_total))

# Secuencia de ingreso que incluye exactamente 250
ingreso_seq <- sort(unique(c(seq(from = ceiling(gasto_subsistencia_total) + 5, to = 500, by = 5), 250)))

df_les_ingreso <- expand.grid(
  Ingreso = ingreso_seq,
  Bien = bienes,
  stringsAsFactors = FALSE
) %>%
  mutate(
    p_i = precios_base[Bien],
    gamma_i = gamma[Bien],
    beta_i = beta[Bien],
    gasto_sub_i = p_i * gamma_i,
    ingreso_supernumerario = pmax(0, Ingreso - gasto_subsistencia_total),
    gasto_discrecional_i = beta_i * ingreso_supernumerario,
    gasto_total_i = gasto_sub_i + gasto_discrecional_i,
    cantidad_i = gasto_total_i / p_i,
    participacion_w_i = gasto_total_i / Ingreso,
    # Elasticidades analiticas de Stone (1954)
    elasticidad_ingreso = beta_i / participacion_w_i,
    elasticidad_precio_propia = -1 + (1 - beta_i) * (gamma_i / cantidad_i)
  )

# Evaluacion en un punto de referencia medio (Ingreso = 250)
punto_ref <- df_les_ingreso %>%
  filter(Ingreso == 250) %>%
  select(Bien, gasto_sub_i, gasto_discrecional_i, gasto_total_i, participacion_w_i,
         elasticidad_ingreso, elasticidad_precio_propia)

cat("\nResultados en punto de referencia (Ingreso = 250):\n")
print(as.data.frame(punto_ref))

# Estimacion econometrica simulada: Generar 35 observaciones anuales (estilo series britanicas de Stone)
t_obs <- 35
tiempo <- 1:t_obs
tendencia_y <- seq(120, 380, length.out = t_obs) + rnorm(t_obs, 0, 8)
p1 <- 1.0 + 0.015 * tiempo + rnorm(t_obs, 0, 0.02)
p2 <- 1.2 + 0.020 * tiempo + rnorm(t_obs, 0, 0.03)
p3 <- 0.8 + 0.010 * tiempo + rnorm(t_obs, 0, 0.02)
p4 <- 1.5 + 0.025 * tiempo + rnorm(t_obs, 0, 0.03)

mat_p <- cbind(p1, p2, p3, p4)
colnames(mat_p) <- bienes

# Generar gastos teoricos con perturbacion aditiva multivariada
g_sub_mat <- t(apply(mat_p, 1, function(p) p * gamma))
g_sub_tot <- rowSums(g_sub_mat)
y_sup <- pmax(5, tendencia_y - g_sub_tot)

mat_gasto_obs <- matrix(0, nrow = t_obs, ncol = n_bienes)
colnames(mat_gasto_obs) <- bienes
for (j in 1:n_bienes) {
  mat_gasto_obs[, j] <- g_sub_mat[, j] + beta[j] * y_sup + rnorm(t_obs, 0, 2.5)
}
# Asegurar coherencia presupuestaria exacta (aditividad)
mat_gasto_obs <- mat_gasto_obs * (tendencia_y / rowSums(mat_gasto_obs))

cat("\nEstimacion NLS simplificada del parametro beta_alimentos:\n")
df_est_alimentos <- data.frame(
  Gasto = mat_gasto_obs[, "Alimentos"],
  p = mat_p[, "Alimentos"],
  y = tendencia_y,
  S = g_sub_tot
)
fit_nls <- nls(Gasto ~ p * g1 + b1 * (y - S), data = df_est_alimentos,
               start = list(g1 = 30, b1 = 0.20))
print(summary(fit_nls))

# ------------------------------------------------------------------------------
# Figura 1: Sistema Lineal de Gasto (LES / Stone-Geary)
# Panel A: Descomposicion de Engel (Subsistencia vs Discrecional)
# Panel B: Convergencia de Elasticidades Ingreso
# ------------------------------------------------------------------------------

p_les_a <- ggplot(df_les_ingreso, aes(x = Ingreso, y = gasto_total_i, color = Bien)) +
  geom_line(linewidth = 1.2) +
  geom_hline(data = distinct(df_les_ingreso, Bien, gasto_sub_i),
             aes(yintercept = gasto_sub_i, color = Bien),
             linetype = "dashed", alpha = 0.6) +
  annotate("rect", xmin = min(ingreso_seq), xmax = gasto_subsistencia_total,
           ymin = 0, ymax = Inf, fill = "gray80", alpha = 0.3) +
  geom_vline(xintercept = gasto_subsistencia_total, linetype = "dotted", color = "firebrick", linewidth = 0.8) +
  annotate("text", x = gasto_subsistencia_total + 15, y = 175,
           label = sprintf("Minimo de Subsistencia Total\nS = %.1f", gasto_subsistencia_total),
           color = "firebrick", size = 3.2, hjust = 0, fontface = "italic") +
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "A. Curvas de Engel del Sistema Lineal de Gasto (LES)",
    subtitle = "Lineas continuas: Gasto total. Lineas discontinuas: Gasto de subsistencia comprometido",
    x = "Ingreso Total del Consumidor (y)",
    y = "Gasto Monetario en cada Bien (p_i * q_i)",
    color = "Categoria de Bien"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "bottom"
  )

p_les_b <- ggplot(df_les_ingreso, aes(x = Ingreso, y = elasticidad_ingreso, color = Bien)) +
  geom_line(linewidth = 1.1) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "gray40") +
  annotate("text", x = 450, y = 1.08, label = "Elasticidad unitaria = 1", color = "gray40", size = 3) +
  scale_y_continuous(breaks = seq(0, 3, by = 0.5), limits = c(0.2, 2.8)) +
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "B. Trayectoria de Elasticidades Ingreso (Stone 1954)",
    subtitle = "Los alimentos se consolidan como bien necesario (eta < 1); servicios como bien de lujo (eta > 1)",
    x = "Ingreso Total del Consumidor (y)",
    y = "Elasticidad Ingreso (eta_i = beta_i / w_i)",
    color = "Categoria de Bien"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "bottom"
  )

fig_les_completa <- p_les_a + p_les_b + plot_layout(guides = "collect") & theme(legend.position = "bottom")

ruta_fig_les <- file.path(dir_salidas, "fig_stone_sistema_gasto_les.png")
ggsave(ruta_fig_les, plot = fig_les_completa, width = 12, height = 5.5, dpi = 300)
cat(sprintf("Figura guardada con exito: %s\n", ruta_fig_les))


cat("\n=== 2. MATRIZ DE CONTABILIDAD SOCIAL (SAM) Y MULTIPLICADORES ===\n")

# Estructura de 7 cuentas macroeconomicas canónicas (Stone 1968, Pyatt & Round 1979):
# 1. Actividades de Produccion (Act)
# 2. Factores de Produccion: Trabajo y Capital (Fact)
# 3. Hogares (Hog)
# 4. Empresas / Sociedades (Emp)
# 5. Gobierno (Gob)
# 6. Acumulacion / Inversion-Ahorro (Inv)
# 7. Resto del Mundo / Sector Externo (RdM)

cuentas_sam <- c("Actividades", "Factores", "Hogares", "Empresas", "Gobierno", "Inversion", "Resto_Mundo")
m <- length(cuentas_sam)

# Matriz de transacciones T (filas = ingresos/entradas, columnas = gastos/salidas)
T_mat <- matrix(0, nrow = m, ncol = m, dimnames = list(cuentas_sam, cuentas_sam))

# 1. Actividades recibe de:
T_mat["Actividades", "Actividades"] <- 120   # Consumo intermedio
T_mat["Actividades", "Hogares"]     <- 310   # Consumo final de los hogares
T_mat["Actividades", "Gobierno"]    <- 90    # Gasto de consumo publico
T_mat["Actividades", "Inversion"]   <- 110   # Formacion bruta de capital (Inversion)
T_mat["Actividades", "Resto_Mundo"] <- 130   # Exportaciones
# Total demanda de produccion = 120 + 310 + 90 + 110 + 130 = 760

# 2. Factores recibe de:
T_mat["Factores", "Actividades"]    <- 480   # Valor agregado bruto
# Total ingreso factorial = 480

# 3. Hogares recibe de:
T_mat["Hogares", "Factores"]        <- 360   # Remuneraciones al trabajo y rentas directas
T_mat["Hogares", "Empresas"]        <- 40    # Dividendos distribuidos
T_mat["Hogares", "Gobierno"]        <- 35    # Transferencias sociales
T_mat["Hogares", "Resto_Mundo"]     <- 15    # Remesas del exterior
# Total ingreso de hogares = 360 + 40 + 35 + 15 = 450

# 4. Empresas recibe de:
T_mat["Empresas", "Factores"]       <- 120   # Excedente bruto retenido
# Total ingreso de empresas = 120

# 5. Gobierno recibe de:
T_mat["Gobierno", "Actividades"]    <- 30    # Impuestos indirectos a produccion
T_mat["Gobierno", "Hogares"]        <- 45    # Impuestos directos
T_mat["Gobierno", "Empresas"]       <- 25    # Impuestos de sociedades
T_mat["Gobierno", "Resto_Mundo"]    <- 10    # Aranceles
# Total ingreso del gobierno = 30 + 45 + 25 + 10 = 110

# 6. Inversion recibe de:
T_mat["Inversion", "Hogares"]       <- 55    # Ahorro privado hogares
T_mat["Inversion", "Empresas"]      <- 45    # Ahorro empresas
T_mat["Inversion", "Gobierno"]      <- -15   # Deficit fiscal (desahorro publico)
T_mat["Inversion", "Resto_Mundo"]   <- 25    # Deficit cuenta corriente / Ahorro externo
# Total ahorro = 55 + 45 - 15 + 25 = 110

# 7. Resto del Mundo recibe de:
T_mat["Resto_Mundo", "Actividades"] <- 130   # Importaciones
T_mat["Resto_Mundo", "Hogares"]     <- 40    # Compras en el exterior
T_mat["Resto_Mundo", "Empresas"]    <- 10    # Pagos de rentas al capital extranjero
# Total pagos al exterior = 130 + 40 + 10 = 180

# Verificacion estricta de partida doble
ingresos_totales <- rowSums(T_mat)
gastos_totales <- colSums(T_mat)
diferencia_contable <- ingresos_totales - gastos_totales

cat("Verificacion del equilibrio contable de partida doble de Stone:\n")
df_balance <- data.frame(
  Cuenta = cuentas_sam,
  Ingresos_Fila = ingresos_totales,
  Gastos_Columna = gastos_totales,
  Diferencia = diferencia_contable
)
print(df_balance)

error_maximo <- max(abs(diferencia_contable))
cat(sprintf("Diferencia maxima absoluta entre ingresos y gastos: %.4e\n", error_maximo))
stopifnot(error_maximo < 1e-8)

# Calculo de Multiplicadores Contables de Stone (Stone 1968, Pyatt & Round 1979)
endo_idx <- 1:3
exo_idx <- 4:7

T_endo <- T_mat[endo_idx, endo_idx]
y_endo <- ingresos_totales[endo_idx]

# Matriz de propensiones medias endogenas A_n
A_n <- sweep(T_endo, 2, y_endo, "/")
cat("\nMatriz de propensiones medias endogenas (A_n):\n")
print(round(A_n, 4))

# Matriz de multiplicadores de Stone: M = (I - A_n)^(-1)
I_mat <- diag(length(endo_idx))
M_stone <- solve(I_mat - A_n)
rownames(M_stone) <- cuentas_sam[endo_idx]
colnames(M_stone) <- cuentas_sam[endo_idx]

cat("\nMatriz de Multiplicadores Contables de Stone (M):\n")
print(round(M_stone, 4))

# Simulacion de un shock de demanda exogena: Incremento de 100 en gasto publico o exportaciones
shock_vector <- c(Actividades = 100, Factores = 0, Hogares = 0)
impacto_vector <- M_stone %*% shock_vector

cat("\nImpacto de un shock de 100 unidades en la demanda final de Actividades:\n")
print(round(impacto_vector, 2))

# ------------------------------------------------------------------------------
# Figura 2: Matriz de Contabilidad Social (SAM) y Multiplicadores
# ------------------------------------------------------------------------------

df_sam_long <- as.data.frame(as.table(T_mat)) %>%
  rename(Ingreso_Hacia = Var1, Gasto_Desde = Var2, Flujo = Freq)

df_sam_long$Ingreso_Hacia <- factor(df_sam_long$Ingreso_Hacia, levels = rev(cuentas_sam))

p_sam_heatmap <- ggplot(df_sam_long, aes(x = Gasto_Desde, y = Ingreso_Hacia, fill = Flujo)) +
  geom_tile(color = "white", linewidth = 0.8) +
  geom_text(aes(label = ifelse(Flujo != 0, as.character(round(Flujo, 0)), "")),
            color = ifelse(df_sam_long$Flujo > 250, "white", "gray15"), size = 3.3, fontface = "bold") +
  scale_fill_gradient(low = "#eef4fb", high = "#1a5276", na.value = "white") +
  labs(
    title = "A. Matriz de Contabilidad Social (SAM) Balanceada",
    subtitle = "Partida doble cerrada: Cada fila (ingreso) es exactamente igual a su columna (gasto)",
    x = "Cuenta de Gasto / Salida (Columnas)",
    y = "Cuenta de Ingreso / Entrada (Filas)",
    fill = "Flujo (Millones)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold"),
    axis.text.x = element_text(angle = 35, hjust = 1, face = "bold"),
    axis.text.y = element_text(face = "bold"),
    panel.grid = element_blank(),
    legend.position = "right"
  )

df_mult_long <- as.data.frame(as.table(M_stone)) %>%
  rename(Efecto_En = Var1, Inyeccion_En = Var2, Multiplicador = Freq)

p_sam_mult <- ggplot(df_mult_long, aes(x = Inyeccion_En, y = Multiplicador, fill = Efecto_En)) +
  geom_col(position = position_dodge(0.8), width = 0.7) +
  geom_text(aes(label = sprintf("%.2f", Multiplicador)),
            position = position_dodge(0.8), vjust = -0.4, size = 3.2, fontface = "bold") +
  scale_fill_brewer(palette = "Blues", direction = -1) +
  scale_y_continuous(limits = c(0, 3.2), breaks = seq(0, 3, by = 0.5)) +
  labs(
    title = "B. Multiplicadores Contables de Stone M = (I - A)^(-1)",
    subtitle = "Efecto total en cuentas endogenas tras una inyeccion unitaria en cada cuenta",
    x = "Cuenta donde se inyecta la demanda",
    y = "Multiplicador contable total",
    fill = "Efecto generado en:"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "bottom"
  )

fig_sam_completa <- p_sam_heatmap + p_sam_mult + plot_layout(ncol = 1, heights = c(1.3, 1))

ruta_fig_sam <- file.path(dir_salidas, "fig_stone_matriz_contabilidad_sam.png")
ggsave(ruta_fig_sam, plot = fig_sam_completa, width = 11, height = 10, dpi = 300)
cat(sprintf("Figura guardada con exito: %s\n", ruta_fig_sam))

# ------------------------------------------------------------------------------
# 3. Exportar tabla consolidada de resultados
# ------------------------------------------------------------------------------

tab_salida <- bind_rows(
  punto_ref %>%
    mutate(
      Seccion = "LES_Elasticidades_y250",
      Metrica = Bien,
      Valor_1 = round(participacion_w_i, 4),
      Valor_2 = round(elasticidad_ingreso, 4),
      Valor_3 = round(elasticidad_precio_propia, 4),
      Descripcion = "Gasto y elasticidades ingreso y precio en punto medio (y=250)"
    ) %>%
    select(Seccion, Metrica, Valor_1, Valor_2, Valor_3, Descripcion),

  df_balance %>%
    mutate(
      Seccion = "SAM_Equilibrio_Contable",
      Metrica = Cuenta,
      Valor_1 = Ingresos_Fila,
      Valor_2 = Gastos_Columna,
      Valor_3 = Diferencia,
      Descripcion = "Balance de partida doble de la SAM: Ingresos vs Gastos"
    ) %>%
    select(Seccion, Metrica, Valor_1, Valor_2, Valor_3, Descripcion),

  df_mult_long %>%
    mutate(
      Seccion = "SAM_Multiplicadores",
      Metrica = paste0(Inyeccion_En, " -> ", Efecto_En),
      Valor_1 = round(Multiplicador, 4),
      Valor_2 = NA_real_,
      Valor_3 = NA_real_,
      Descripcion = "Multiplicador contable de Stone M_ij"
    ) %>%
    select(Seccion, Metrica, Valor_1, Valor_2, Valor_3, Descripcion)
)

ruta_tab <- file.path(dir_salidas, "tab_resultados_stone.csv")
write.csv(tab_salida, ruta_tab, row.names = FALSE)
cat(sprintf("Tabla de resultados guardada con exito: %s\n", ruta_tab))

cat("\n=== REPLICACION DE RICHARD STONE FINALIZADA EXITOSAMENTE ===\n")

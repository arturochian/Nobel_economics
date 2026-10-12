# ==============================================================================
# REPLICACION ILUSTRATIVA: SISTEMA CASI IDEAL DE DEMANDA (AIDS) Y
# LA PARADOJA DE DEATON (EXCESS SMOOTHNESS OF CONSUMPTION)
# Premio Nobel de Economia 2015: Angus Deaton
# ==============================================================================
# Autores: Proyecto Nobel_economics
# Referencias seminales:
#   - Deaton, A., & Muellbauer, J. (1980). An Almost Ideal Demand System. AER.
#   - Deaton, A. (1987). Life-Cycle Models of Consumption. NBER WP 1910.
#   - Campbell, J. Y., & Deaton, A. (1989). Why Is Consumption So Smooth? ReStud.
#   - Deaton, A. (1991). Saving and Liquidity Constraints. Econometrica.
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
})

set.seed(2015)

# Directorios de salida
script_dir <- getwd()
out_dir <- file.path(script_dir, "laureados", "2015_deaton", "replicacion", "salidas")
if (!dir.exists(out_dir)) {
  dir.create(out_dir, recursive = TRUE)
}

# ==============================================================================
# PARTE 1: SISTEMA CASI IDEAL DE DEMANDA (AIDS - DEATON & MUELLBAUER 1980)
# ==============================================================================

# Definicion de 4 canastas de consumo:
# 1. Alimentos (bien necesario basico, beta < 0)
# 2. Vivienda y Servicios (bien necesario, beta < 0)
# 3. Transporte y Comunicaciones (bien neutro/lujo moderado, beta > 0)
# 4. Recreacion, Cultura y Lujo (bien de lujo superior, beta > 0)

bienes <- c("Alimentos", "Vivienda y Servicios", "Transporte y Com.", "Recreacion y Lujo")
K <- length(bienes)

# Parametros alfa (participaciones de gasto autonomas en el punto medio)
alpha <- c(0.35, 0.25, 0.25, 0.15) # Suma = 1.0 (Adding-up)

# Parametros beta (sensibilidad al gasto real per capita ln(X/P))
# beta < 0: bien necesario; beta > 0: bien de lujo
beta <- c(-0.12, -0.03, 0.05, 0.10) # Suma = 0.0 (Adding-up)

# Matriz Gamma (respuestas a precios cruzados y propios)
# Restricciones teoricas:
# Simetria de Slutsky: gamma_ij = gamma_ji
# Homogeneidad: suma por filas = 0
# Aditividad: suma por columnas = 0
gamma <- matrix(c(
   0.08, -0.03, -0.03, -0.02,
  -0.03,  0.05, -0.01, -0.01,
  -0.03, -0.01,  0.06, -0.02,
  -0.02, -0.01, -0.02,  0.05
), nrow = K, byrow = TRUE)

rownames(gamma) <- bienes
colnames(gamma) <- bienes

# Verificacion de restricciones teoricas
cat("--- Verificacion de Restricciones del Sistema AIDS ---\n")
cat("Suma de alfa (Adding-up, debe ser 1):", sum(alpha), "\n")
cat("Suma de beta (Adding-up, debe ser 0):", sum(beta), "\n")
cat("Suma de filas gamma (Homogeneidad, debe ser 0):", rowSums(gamma), "\n")
cat("Simetria gamma (Slutsky):", isSymmetric(gamma), "\n\n")

# Evaluacion en precios base (p_j = 1 => ln(p_j) = 0, ln(P) = 0)
# Nivel de gasto medio de referencia X_0 = 100
X_ref <- 100
ln_X_ref <- log(X_ref)

# En precios unitarios normalizados p_j = 1, ln(P) = 0, por lo que ln(X/P) = ln(X)
# Normalizamos el gasto centrado en la mediana ln(X) - ln(X_ref) = 0
w_ref <- alpha

# Calculo de Elasticidades en el punto de referencia:
# 1. Elasticidad Ingreso/Gasto: e_i = 1 + beta_i / w_i
e_gasto <- 1 + (beta / w_ref)

# 2. Elasticidad Precio Marshalliana (Propia): e_ii = -1 + (gamma_ii / w_i) - beta_i
# Usando la formula estandar con indice de Stone:
# e_ij = -delta_ij + (gamma_ij / w_i) - (beta_i * w_j / w_i)
e_precio_marsh <- diag(-1, K) + (gamma / matrix(w_ref, K, K, byrow = FALSE)) - 
                  matrix(beta / w_ref, K, K, byrow = FALSE) * matrix(w_ref, K, K, byrow = TRUE)

e_ii_marsh <- diag(e_precio_marsh)

# 3. Elasticidad Precio Hicksiana / Compensada (Ecuacion de Slutsky):
# e_ij^H = e_ij + e_i * w_j
e_precio_hicks <- e_precio_marsh + matrix(e_gasto, K, K, byrow = FALSE) * matrix(w_ref, K, K, byrow = TRUE)
e_ii_hicks <- diag(e_precio_hicks)

tab_elasticidades <- data.frame(
  Bien = bienes,
  Participacion_Gasto_Base = round(w_ref, 3),
  Parametro_Beta = round(beta, 3),
  Elasticidad_Gasto = round(e_gasto, 3),
  Elasticidad_Precio_Marshalliana = round(e_ii_marsh, 3),
  Elasticidad_Precio_Hicksiana = round(e_ii_hicks, 3),
  Clasificacion_Engel = ifelse(beta < 0, "Bien Necesario (Inelastico)", "Bien de Lujo (Elastico)")
)

print(tab_elasticidades)

# Guardar tabla CSV
csv_file <- file.path(out_dir, "tab_elasticidades_aids.csv")
write.csv(tab_elasticidades, csv_file, row.names = FALSE)
cat("Tabla de elasticidades guardada en:", csv_file, "\n")

# Curvas de Engel del Sistema AIDS:
# Variacion del gasto total real X de 30 a 350 (distribucion percentil 5 al 95)
X_seq <- seq(30, 350, length.out = 300)
ln_ratio <- log(X_seq / X_ref)

df_engel <- expand.grid(X = X_seq, Bien = bienes) %>%
  mutate(
    alpha_i = case_when(
      Bien == bienes[1] ~ alpha[1],
      Bien == bienes[2] ~ alpha[2],
      Bien == bienes[3] ~ alpha[3],
      Bien == bienes[4] ~ alpha[4]
    ),
    beta_i = case_when(
      Bien == bienes[1] ~ beta[1],
      Bien == bienes[2] ~ beta[2],
      Bien == bienes[3] ~ beta[3],
      Bien == bienes[4] ~ beta[4]
    ),
    w_i = alpha_i + beta_i * log(X / X_ref)
  )

# Grafico 1: Curvas de Engel de Deaton y Muellbauer (1980)
colores_bienes <- c(
  "Alimentos" = "#B22222",
  "Vivienda y Servicios" = "#2E8B57",
  "Transporte y Com." = "#1F77B4",
  "Recreacion y Lujo" = "#9467BD"
)

p_engel <- ggplot(df_engel, aes(x = X, y = w_i, color = Bien)) +
  geom_line(linewidth = 1.3) +
  geom_vline(xintercept = X_ref, linetype = "dashed", color = "gray40", alpha = 0.7) +
  annotate("text", x = X_ref + 8, y = 0.40, label = "Hogar Mediano\n(Gasto = 100)", 
           hjust = 0, size = 3.5, color = "gray30") +
  scale_color_manual(values = colores_bienes) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0.00, 0.55)) +
  scale_x_continuous(breaks = seq(50, 350, by = 50)) +
  labs(
    title = "Curvas de Engel en el Sistema Casi Ideal de Demanda (AIDS)",
    subtitle = "Deaton & Muellbauer (1980): Participacion presupuestaria vs. Gasto Total del Hogar",
    x = "Nivel de Gasto Total Real del Hogar (X / P)",
    y = "Participacion en el Presupuesto (w_i)",
    color = "Grupo de Gasto",
    caption = "Fuente: Replicacion estilizada del modelo AIDS (Deaton y Muellbauer 1980; Deaton 1997)."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "gray30", size = 11),
    legend.position = "bottom",
    panel.grid.minor = element_blank()
  )

png_engel <- file.path(out_dir, "fig_curvas_engel_aids.png")
ggsave(png_engel, p_engel, width = 9, height = 6, dpi = 300)
cat("Figura de Curvas de Engel guardada en:", png_engel, "\n")

# ==============================================================================
# PARTE 2: LA PARADOJA DE DEATON (EXCESO DE SUAVIDAD DEL CONSUMO)
# ==============================================================================
# Teoria:
# 1. Modelo de Ingreso Permanente Estandar (Hall 1978, Flavin 1981):
#    Si el ingreso sigue un paseo aleatorio con deriva y shocks persistentes:
#    Delta y_t = rho * Delta y_{t-1} + epsilon_t (con rho > 0, tipico en series macro rho ~ 0.4)
#    La hipotesis de ingreso permanente predice EXCESS VOLATILITY:
#    Delta c_t = ((1+r)/(1+r-rho)) * epsilon_t > epsilon_t.
#
# 2. Hecho Estilizado de Deaton (1987) y Campbell & Deaton (1989):
#    Empiricamente, el consumo agregado es mucho MAS SUAVE que el ingreso:
#    Var(Delta c_t) << Var(Delta y_t).
#
# 3. Solucion de Deaton (1991):
#    Ahorro por precaucion (Buffer-Stock Saving) y restricciones de liquidez a nivel micro.
#    Los hogares acumulan un colchon de activos de seguridad y no pueden endeudarse ilimitadamente,
#    lo que amortigua fuertemente las fluctuaciones del consumo.

T_obs <- 60
rho <- 0.42 # Persistencia autorregresiva observada en variaciones del ingreso
r <- 0.03   # Tasa de interes real
sd_eps <- 2.0

eps <- rnorm(T_obs, mean = 0, sd = sd_eps)

# Trayectoria de ingreso en primeras diferencias y nivel
delta_y <- numeric(T_obs)
delta_y[1] <- eps[1]
for (t in 2:T_obs) {
  delta_y[t] <- rho * delta_y[t - 1] + eps[t]
}

y_level <- 100 + cumsum(delta_y)

# 1. Prediccion de Hall-Flavin PIH con persistencia (Exceso de Volatilidad Teorico)
# Delta c_PIH = ((1 + r) / (1 + r - rho)) * eps
multiplicador_pih <- (1 + r) / (1 + r - rho)
delta_c_pih <- multiplicador_pih * eps
c_level_pih <- 100 + cumsum(delta_c_pih)

# 2. Modelo de Deaton con Restricciones de Liquidez y Ahorro Precautorio (Buffer-Stock)
# El consumo ajusta solo parcialmente hacia el nuevo nivel de ingreso permanente (suavizamiento micro)
# c_t = lambda * c_{t-1} + (1 - lambda) * y_t, o ajuste amortiguado con ahorro colchon
lambda <- 0.75 # Inercia / suavizamiento precautorio
c_level_deaton <- numeric(T_obs)
c_level_deaton[1] <- 100
for (t in 2:T_obs) {
  c_level_deaton[t] <- lambda * c_level_deaton[t - 1] + (1 - lambda) * y_level[t]
}
delta_c_deaton <- c(0, diff(c_level_deaton))

# Comparacion de Varianzas
var_dy <- var(delta_y)
var_dc_pih <- var(delta_c_pih)
var_dc_deaton <- var(delta_c_deaton[-1])

ratio_pih <- var_dc_pih / var_dy
ratio_deaton <- var_dc_deaton / var_dy

cat("\n--- Resultados de la Paradoja de Deaton (1987) ---\n")
cat("Varianza de cambios en ingreso Var(Delta y):", round(var_dy, 3), "\n")
cat("Varianza PIH tradicional Var(Delta c_PIH):", round(var_dc_pih, 3), 
    "| Ratio Volatilidad (Predicho > 1):", round(ratio_pih, 3), "\n")
cat("Varianza Modelo Deaton Var(Delta c_Deaton):", round(var_dc_deaton, 3), 
    "| Ratio Volatilidad (Observado < 1):", round(ratio_deaton, 3), "\n\n")

# Data frame para graficar trayectorias en niveles y en variaciones
df_tiempo <- data.frame(
  Periodo = 1:T_obs,
  Ingreso = y_level,
  PIH_Teorico = c_level_pih,
  Deaton_Buffer = c_level_deaton
) %>%
  pivot_longer(cols = c("Ingreso", "PIH_Teorico", "Deaton_Buffer"), 
               names_to = "Serie", values_to = "Nivel") %>%
  mutate(
    Serie = factor(Serie, 
                   levels = c("Ingreso", "PIH_Teorico", "Deaton_Buffer"),
                   labels = c("Ingreso Real (y_t)", 
                              "Consumo PIH (Hall-Flavin: Exceso de Volatilidad)", 
                              "Consumo Real / Deaton (Buffer-Stock: Exceso de Suavidad)"))
  )

p_deaton <- ggplot(df_tiempo, aes(x = Periodo, y = Nivel, color = Serie, linetype = Serie)) +
  geom_line(linewidth = 1.2) +
  scale_color_manual(values = c(
    "Ingreso Real (y_t)" = "#333333",
    "Consumo PIH (Hall-Flavin: Exceso de Volatilidad)" = "#D95F02",
    "Consumo Real / Deaton (Buffer-Stock: Exceso de Suavidad)" = "#1B9E77"
  )) +
  scale_linetype_manual(values = c("dotted", "dashed", "solid")) +
  labs(
    title = "La Paradoja del Consumo de Deaton: Exceso de Suavidad",
    subtitle = "Deaton (1987, 1991) y Campbell & Deaton (1989): Prediccion teorica PIH vs. Evidencia empirica",
    x = "Periodo Temporal (t)",
    y = "Nivel de Consumo e Ingreso (Base 100)",
    color = "Trayectoria Dinamica:",
    linetype = "Trayectoria Dinamica:",
    caption = paste0(
      "Razon de varianzas: Var(Delta c_PIH)/Var(Delta y) = ", round(ratio_pih, 2),
      " (Exceso de volatilidad no verificado en la realidad)\n",
      "Var(Delta c_Deaton)/Var(Delta y) = ", round(ratio_deaton, 2),
      " (Exceso de suavidad empírico debido a restricciones de liquidez y ahorro precautorio)"
    )
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "gray30", size = 11),
    plot.caption = element_text(face = "italic", color = "gray25", size = 9),
    legend.position = "bottom",
    legend.box = "vertical",
    panel.grid.minor = element_blank()
  )

png_deaton <- file.path(out_dir, "fig_paradoja_deaton_consumo.png")
ggsave(png_deaton, p_deaton, width = 9, height = 6, dpi = 300)
cat("Figura de la Paradoja de Deaton guardada en:", png_deaton, "\n")

cat("\n[OK] Ejecucion de replicacion completada con exito.\n")

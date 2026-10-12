# ==============================================================================
# REPLICACION CUANTITATIVA: MILTON FRIEDMAN (NOBEL DE ECONOMIA 1976)
# 
# 1. Hipotesis del Ingreso Permanente (Permanent Income Hypothesis, 1957)
#    vs. Funcion de Consumo Keynesiana Simple.
# 2. Curva de Phillips con Expectativas Adaptativas y Aceleracionismo (1968)
#    (Teoria Cuantitativa y Tasa Natural de Desempleo).
#
# Autor: Proyecto Nobel_economics
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(readr)
  library(patchwork)
})

# Establecer semilla para reproducibilidad estricta
set.seed(1976)

# Definir directorio base de salidas relativo a este script
# Si se ejecuta desde laureados/1976_friedman/replicacion/R o desde la raiz:
ruta_salidas <- file.path("salidas")
if (!dir.exists(ruta_salidas)) {
  # Si se corre desde la raiz del repo
  ruta_salidas <- file.path("laureados", "1976_friedman", "replicacion", "salidas")
  if (!dir.exists(ruta_salidas)) {
    dir.create(ruta_salidas, recursive = TRUE)
  }
}

message("=== Iniciando Replicacion Cuantitativa: Milton Friedman (1976) ===")

# ==============================================================================
# SECCION 1: HIPOTESIS DEL INGRESO PERMANENTE (PIH, 1957)
# ==============================================================================

# Contexto:
# Friedman (1957) descompuso el ingreso en: Y_t = Y_t^p + Y_t^tr
# y el consumo en: C_t = C_t^p + C_t^tr
# Demostro que C_t^p = k * Y_t^p (con k constante en el largo plazo)
# y que la correlacion entre el ingreso transitorio y el consumo transitorio es nula:
# Cov(Y_t^tr, C_t^tr) = 0.

# 1.1 Simulacion Dinamica: Respuesta ante Choques Transitorios vs Permanentes
T_periodos <- 30
tiempo <- 1:T_periodos
ingreso_base <- 100

# Parametros de comportamiento:
# Keynesiano ingenuo: C = a + c * Y_t (MPC corriente c = 0.80, a = 15)
# Friedman PIH: C = k * Y_t^p, con k = 0.90, y horizonte intertemporal suavizado
c_keynes <- 0.80
a_keynes <- 10.0
k_friedman <- 0.90
r_interes <- 0.05 # Tasa de interes real intertemporal

# Escenario A: Choque Transitorio (Bono extraordinario de 50 en t = 10 solamente)
y_transitorio <- rep(ingreso_base, T_periodos)
y_transitorio[10] <- ingreso_base + 50

# Escenario B: Choque Permanente (Ascenso laboral que eleva ingreso en 50 a partir de t = 10)
y_permanente <- rep(ingreso_base, T_periodos)
y_permanente[10:T_periodos] <- ingreso_base + 50

# Trayectoria de Ingreso Permanente (anualidad esperada suavizada)
# Para un choque transitorio de tamano S en horizonte remanente T_rem:
# El incremento en consumo PIH en t=10 es aprox r / (1 - (1+r)^(-H)) * S
# Con horizonte vital largo, Delta C_PIH ~ r * S = 0.05 * 50 = 2.5 unidades
# Mientras que Keynes predice Delta C_Keynes = c * 50 = 40 unidades!

consumo_k_trans <- a_keynes + c_keynes * y_transitorio
ahorro_k_trans  <- y_transitorio - consumo_k_trans

# Friedman PIH ante choque transitorio:
# El agente distribuye el choque transitorio en el valor presente del horizonte
y_p_trans <- rep(ingreso_base, T_periodos)
# El ingreso permanente absorbe el choque como rendimiento de la riqueza acumulada
y_p_trans[10:T_periodos] <- ingreso_base + (r_interes * 50)
consumo_f_trans <- k_friedman * y_p_trans
ahorro_f_trans  <- y_transitorio - consumo_f_trans

# Consumos ante choque permanente:
consumo_k_perm <- a_keynes + c_keynes * y_permanente
ahorro_k_perm  <- y_permanente - consumo_k_perm

y_p_perm <- rep(ingreso_base, T_periodos)
y_p_perm[10:T_periodos] <- ingreso_base + 50
consumo_f_perm <- k_friedman * y_p_perm
ahorro_f_perm  <- y_permanente - consumo_f_perm

df_dinamico <- data.frame(
  t = rep(tiempo, 4),
  Escenario = rep(c("Choque Transitorio (t=10)", "Choque Permanente (desde t=10)"), each = T_periodos * 2),
  Modelo = rep(rep(c("Keynesiano (Ingreso Corriente)", "Friedman (Ingreso Permanente)"), each = T_periodos), 2),
  Ingreso = c(rep(y_transitorio, 2), rep(y_permanente, 2)),
  Consumo = c(consumo_k_trans, consumo_f_trans, consumo_k_perm, consumo_f_perm),
  Ahorro  = c(ahorro_k_trans, ahorro_f_trans, ahorro_k_perm, ahorro_f_perm)
)

# 1.2 Simulacion de Corte Transversal y la Paradoja de Simon Kuznets
# Friedman demostro que en corte transversal, los individuos con alto ingreso observado
# tienen en promedio un componente transitorio positivo (Y^tr > 0), lo que hace parecer
# que su propension media a consumir (C/Y) es menor, reconciliando la paradoja de Kuznets.
N_hogares <- 1000
log_yp <- rnorm(N_hogares, mean = 4.6, sd = 0.35) # Ingreso permanente
y_p_cross <- exp(log_yp)
# Componente transitorio no correlacionado con Y_p
y_tr_cross <- rnorm(N_hogares, mean = 0, sd = 15)
y_obs_cross <- y_p_cross + y_tr_cross

# Consumo segun PIH: C = k * Y_p + error de consumo transitorio no correlacionado
c_obs_cross <- k_friedman * y_p_cross + rnorm(N_hogares, mean = 0, sd = 3)
apc_cross <- c_obs_cross / y_obs_cross

df_cross <- data.frame(
  Y_obs = y_obs_cross,
  C_obs = c_obs_cross,
  APC   = apc_cross,
  Y_perm = y_p_cross
) %>% filter(Y_obs > 20, APC > 0.4, APC < 1.4)

# Regresion lineal aparente de corte transversal (modelo keynesiano estimado)
reg_cross <- lm(C_obs ~ Y_obs, data = df_cross)
mpc_aparente <- coef(reg_cross)[2]
interseccion_aparente <- coef(reg_cross)[1]

message(sprintf("Regresion de corte transversal: Consumo = %.2f + %.2f * Ingreso",
                interseccion_aparente, mpc_aparente))
message(sprintf("Propension marginal keynesiana aparente: %.3f (sesgada por choque transitorio)", mpc_aparente))
message(sprintf("Propension verdadera respecto a Ingreso Permanente: %.3f", k_friedman))

# Grafico 1: Hipotesis del Ingreso Permanente
p1_dinamico <- ggplot(df_dinamico %>% filter(Escenario == "Choque Transitorio (t=10)"), 
                      aes(x = t)) +
  geom_line(aes(y = Ingreso, color = "Ingreso Corriente"), linetype = "dotted", linewidth = 1.1) +
  geom_line(aes(y = Consumo, color = Modelo), linewidth = 1.2) +
  scale_color_manual(values = c(
    "Ingreso Corriente" = "gray40",
    "Keynesiano (Ingreso Corriente)" = "#D95F02",
    "Friedman (Ingreso Permanente)" = "#1B9E77"
  )) +
  labs(
    title = "A. Respuesta ante un Choque Transitorio (+50 en t=10)",
    subtitle = "Friedman: El consumo apenas varia; el ingreso transitorio se absorbe como ahorro.",
    x = "Periodo (t)",
    y = "Nivel (Unidades)",
    color = "Variable / Enfoque"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom")

p2_cross <- ggplot(df_cross, aes(x = Y_obs, y = C_obs)) +
  geom_point(alpha = 0.25, color = "#2C3E50", size = 1.4) +
  geom_smooth(method = "lm", formula = y ~ x, color = "#D95F02", linewidth = 1.3, se = FALSE,
              aes(linetype = "Regresion transversal aparente (Keynesiana)")) +
  geom_abline(aes(intercept = 0, slope = k_friedman, linetype = "Relacion permanente secular (Friedman)"), 
              color = "#1B9E77", linewidth = 1.3) +
  scale_linetype_manual(name = "Estructura", values = c(
    "Regresion transversal aparente (Keynesiana)" = "solid",
    "Relacion permanente secular (Friedman)" = "dashed"
  )) +
  labs(
    title = "B. Resolucion de la Paradoja de Kuznets (Corte Transversal)",
    subtitle = sprintf("Pendiente aparente = %.2f (con intercepto > 0) vs. Relacion de largo plazo k = %.2f",
                       mpc_aparente, k_friedman),
    x = "Ingreso Observado Corriente (Y)",
    y = "Consumo Observado (C)"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom")

fig_ingreso_permanente <- p1_dinamico / p2_cross

archivo_fig1 <- file.path(ruta_salidas, "fig_friedman_ingreso_permanente.png")
ggsave(archivo_fig1, plot = fig_ingreso_permanente, width = 10, height = 9, dpi = 300)
message(sprintf("Figura guardada con exito: %s", archivo_fig1))

# ==============================================================================
# SECCION 2: CURVA DE PHILLIPS CON EXPECTATIVAS ADAPTATIVAS (FRIEDMAN 1968)
# ==============================================================================

# Contexto:
# Friedman (1968) postulo que no existe trade-off permanente entre inflacion y desempleo:
# Curva de Phillips de corto plazo: pi_t = pi_t^e - alpha * (u_t - u_n)
# con expectativas adaptativas: pi_t^e = pi_{t-1}^e + lambda * (pi_{t-1} - pi_{t-1}^e)
# Tasa Natural de Desempleo u_n = 5.0%

u_natural <- 0.05   # 5%
alpha_phillips <- 0.8 # Pendiente de corto plazo
lambda_adap <- 0.65  # Velocidad de adaptacion de expectativas

# Simulacion de una politica que intenta sostener el desempleo en 3.5% (por debajo de u_n)
# durante 8 periodos, seguida por una desinflacion (politica monetaria restrictiva estilo Volcker)
T_sim <- 16
periodos_sim <- 1:T_sim

u_trayectoria <- numeric(T_sim)
pi_trayectoria <- numeric(T_sim)
pi_e_trayectoria <- numeric(T_sim)

# Condiciones iniciales de equilibrio estable en t = 1
u_trayectoria[1] <- u_natural
pi_trayectoria[1] <- 0.02   # 2% de inflacion inicial
pi_e_trayectoria[1] <- 0.02

# Fases:
# Periodos 2 a 8: Expansion monetaria forzada, meta u = 3.5%
# Periodos 9 a 12: Desinflacion restrictiva, el desempleo sube a 6.5% para quebrar expectativas
# Periodos 13 a 16: Retorno al equilibrio natural de largo plazo con u = 5.0%

for (t in 2:T_sim) {
  # Actualizacion de expectativas adaptativas
  pi_e_trayectoria[t] <- pi_e_trayectoria[t-1] + lambda_adap * (pi_trayectoria[t-1] - pi_e_trayectoria[t-1])
  
  if (t >= 2 && t <= 8) {
    u_trayectoria[t] <- 0.035 # Expansionismo artificial
  } else if (t >= 9 && t <= 12) {
    u_trayectoria[t] <- 0.065 # Estabilizacion / Desinflacion
  } else {
    u_trayectoria[t] <- u_natural # Retorno a tasa natural
  }
  
  # Generacion de inflacion segun Curva de Phillips aumentada por expectativas
  pi_trayectoria[t] <- pi_e_trayectoria[t] - alpha_phillips * (u_trayectoria[t] - u_natural)
}

df_phillips_dinamica <- data.frame(
  Periodo = periodos_sim,
  Tasa_Desempleo = u_trayectoria * 100,
  Inflacion = pi_trayectoria * 100,
  Inflacion_Esperada = pi_e_trayectoria * 100,
  Brecha_Desempleo = (u_trayectoria - u_natural) * 100
)

# Crear curvas de Phillips teoricas de corto plazo para distintos niveles de pi^e
grid_u <- seq(0.025, 0.075, length.out = 100)
srpc_1 <- (0.02 - alpha_phillips * (grid_u - u_natural)) * 100 # Con pi^e = 2%
srpc_2 <- (0.04 - alpha_phillips * (grid_u - u_natural)) * 100 # Con pi^e = 4%
srpc_3 <- (0.065 - alpha_phillips * (grid_u - u_natural)) * 100 # Con pi^e = 6.5%

df_srpc <- data.frame(
  u = rep(grid_u * 100, 3),
  pi = c(srpc_1, srpc_2, srpc_3),
  Nivel_Expectativa = rep(c("SRPC 1: pi^e = 2.0%", "SRPC 2: pi^e = 4.0%", "SRPC 3: pi^e = 6.5%"), each = 100)
)

# Grafico 2: Espiral Inflacionaria y Curva de Phillips Vertical a Largo Plazo
p_phillips_espacio <- ggplot() +
  # Curvas de corto plazo
  geom_line(data = df_srpc, aes(x = u, y = pi, color = Nivel_Expectativa), 
            linewidth = 1.0, linetype = "dashed") +
  # Curva de largo plazo vertical (LRPC)
  geom_vline(xintercept = u_natural * 100, color = "#2C3E50", linewidth = 1.4, linetype = "solid") +
  # Trayectoria historica de la espiral
  geom_path(data = df_phillips_dinamica, aes(x = Tasa_Desempleo, y = Inflacion), 
            arrow = arrow(length = unit(0.25, "cm"), type = "closed"), 
            color = "#E7298A", linewidth = 1.1) +
  geom_point(data = df_phillips_dinamica, aes(x = Tasa_Desempleo, y = Inflacion), 
             color = "#E7298A", size = 2.5) +
  geom_text(data = df_phillips_dinamica[c(1, 4, 8, 10, 16), ],
            aes(x = Tasa_Desempleo, y = Inflacion, label = paste0("t=", Periodo)),
            vjust = -0.8, fontface = "bold", size = 3.3) +
  annotate("text", x = 5.08, y = 8.5, label = "Curva de Phillips de Largo Plazo (LRPC Vertical en u_n)", 
           angle = 90, fontface = "bold", color = "#2C3E50", hjust = 1) +
  scale_color_manual(name = "Curvas de Corto Plazo (SRPC)", values = c(
    "SRPC 1: pi^e = 2.0%" = "#7570B3",
    "SRPC 2: pi^e = 4.0%" = "#E6AB02",
    "SRPC 3: pi^e = 6.5%" = "#E7298A"
  )) +
  labs(
    title = "A. Espiral Dinamica en el Plano Desempleo - Inflacion",
    subtitle = "Intentar mantener u < u_n traslada la SRPC hacia arriba sin ganancia real permanente.",
    x = "Tasa de Desempleo u (%)",
    y = "Tasa de Inflacion pi (%)"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom")

p_phillips_tiempo <- ggplot(df_phillips_dinamica, aes(x = Periodo)) +
  geom_line(aes(y = Inflacion, color = "Inflacion Observada (pi)"), linewidth = 1.2) +
  geom_line(aes(y = Inflacion_Esperada, color = "Inflacion Esperada (pi^e)"), linewidth = 1.1, linetype = "dashed") +
  geom_line(aes(y = Tasa_Desempleo, color = "Tasa de Desempleo (u)"), linewidth = 1.1) +
  geom_hline(yintercept = u_natural * 100, linetype = "dotted", color = "gray30", linewidth = 0.9) +
  annotate("text", x = 14, y = 5.2, label = "Tasa Natural u_n = 5.0%", size = 3.2, color = "gray30") +
  scale_color_manual(name = "Serie Macroeconomica", values = c(
    "Inflacion Observada (pi)" = "#D95F02",
    "Inflacion Esperada (pi^e)" = "#7570B3",
    "Tasa de Desempleo (u)" = "#1B9E77"
  )) +
  labs(
    title = "B. Evolucion Temporal: Aceleracionismo y Estanflacion",
    subtitle = "Expansion (t=2..8) desata aceleracion; estabilizacion (t=9..12) exige costo de desempleo transitorio.",
    x = "Periodo Temporal (t)",
    y = "Porcentaje Anual (%)"
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom")

fig_phillips_vertical <- p_phillips_espacio / p_phillips_tiempo

archivo_fig2 <- file.path(ruta_salidas, "fig_friedman_curva_phillips_vertical.png")
ggsave(archivo_fig2, plot = fig_phillips_vertical, width = 10, height = 9, dpi = 300)
message(sprintf("Figura guardada con exito: %s", archivo_fig2))

# ==============================================================================
# SECCION 3: CONSOLIDACION DE TABLA DE RESULTADOS NUMERICOS
# ==============================================================================

# Consolidamos un cuadro resumen con las respuestas comparativas ante choques
# y los equilibrios dinamicos de la Curva de Phillips

tab_friedman_resumen <- df_phillips_dinamica %>%
  mutate(
    Fase_Politica = case_when(
      Periodo == 1 ~ "Equilibrio Inicial",
      Periodo >= 2 & Periodo <= 8 ~ "Expansion Artificial (u < u_n)",
      Periodo >= 9 & Periodo <= 12 ~ "Desinflacion Estricta",
      TRUE ~ "Nuevo Equilibrio Natural"
    ),
    Tasa_Desempleo = round(Tasa_Desempleo, 2),
    Inflacion = round(Inflacion, 2),
    Inflacion_Esperada = round(Inflacion_Esperada, 2),
    Brecha_Desempleo = round(Brecha_Desempleo, 2)
  )

archivo_tab <- file.path(ruta_salidas, "tab_resultados_friedman.csv")
write_csv(tab_friedman_resumen, archivo_tab)
message(sprintf("Tabla guardada con exito: %s", archivo_tab))

message("=== Replicacion de Milton Friedman (1976) finalizada exitosamente ===")

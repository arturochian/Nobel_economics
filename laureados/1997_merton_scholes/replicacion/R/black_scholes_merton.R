# ==============================================================================
# REPLICACION NOBEL DE ECONOMIA 1997: ROBERT C. MERTON Y MYRON S. SCHOLES
# (Con Fischer Black in memoriam)
#
# Modelo Black-Scholes-Merton (1973):
# - Formula analitica cerrada para Opciones Europeas (Calls y Puts)
# - Griegas de primer y segundo orden (Delta, Gamma, Vega, Theta, Rho)
# - Metodos numericos: Arbol Binomial (Cox-Ross-Rubinstein) y Monte Carlo
# - Modelo estructural de Merton (1974) para riesgo de credito corporativo
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(grid)
})

# ------------------------------------------------------------------------------
# 0. Configuracion de directorios de salida
# ------------------------------------------------------------------------------
# Determinar ruta base del script
obtener_dir_salidas <- function() {
  posibles_dirs <- c(
    file.path("laureados", "1997_merton_scholes", "replicacion", "salidas"),
    file.path("..", "salidas"),
    file.path("salidas"),
    file.path(getwd(), "salidas")
  )
  for (d in posibles_dirs) {
    if (dir.exists(d)) return(normalizePath(d))
  }
  # Si no existe, crear la ruta canonica
  target <- file.path("laureados", "1997_merton_scholes", "replicacion", "salidas")
  dir.create(target, recursive = TRUE, showWarnings = FALSE)
  return(normalizePath(target))
}

dir_salidas <- obtener_dir_salidas()
message("Directorio de salidas configurado en: ", dir_salidas)

# ------------------------------------------------------------------------------
# 1. Formulas Analiticas Black-Scholes-Merton (1973)
# ------------------------------------------------------------------------------

#' Calculo de d1 en Black-Scholes-Merton
bsm_d1 <- function(S, K, r, q = 0, sigma, T) {
  if (T <= 0) return(rep(NA, length(S)))
  (log(S / K) + (r - q + 0.5 * sigma^2) * T) / (sigma * sqrt(T))
}

#' Calculo de d2 en Black-Scholes-Merton
bsm_d2 <- function(S, K, r, q = 0, sigma, T) {
  if (T <= 0) return(rep(NA, length(S)))
  bsm_d1(S, K, r, q, sigma, T) - sigma * sqrt(T)
}

#' Valoracion analitica de Opciones Europeas BSM
#'
#' @param S Precio del activo subyacente (Spot)
#' @param K Precio de ejercicio (Strike)
#' @param r Tasa de interes libre de riesgo anualizada (continua)
#' @param q Rendimiento continuo por dividendos (Merton 1973)
#' @param sigma Volatilidad anualizada del rendimiento del subyacente
#' @param T Tiempo hasta el vencimiento en anios
#' @param type Tipo de opcion: "call" o "put"
#' @return Precio teorico de la opcion
bsm_price <- function(S, K, r, q = 0, sigma, T, type = c("call", "put")) {
  type <- match.arg(type)
  
  if (T <= 0) {
    if (type == "call") return(pmax(S - K, 0))
    if (type == "put")  return(pmax(K - S, 0))
  }
  
  d1 <- bsm_d1(S, K, r, q, sigma, T)
  d2 <- bsm_d2(S, K, r, q, sigma, T)
  
  if (type == "call") {
    precio <- S * exp(-q * T) * pnorm(d1) - K * exp(-r * T) * pnorm(d2)
  } else {
    precio <- K * exp(-r * T) * pnorm(-d2) - S * exp(-q * T) * pnorm(-d1)
  }
  return(precio)
}

#' Calculo de las Griegas (Sensibilidades) en Black-Scholes-Merton
bsm_greeks <- function(S, K, r, q = 0, sigma, T, type = c("call", "put")) {
  type <- match.arg(type)
  
  d1 <- bsm_d1(S, K, r, q, sigma, T)
  d2 <- bsm_d2(S, K, r, q, sigma, T)
  phi_d1 <- dnorm(d1)
  
  # Delta
  if (type == "call") {
    delta <- exp(-q * T) * pnorm(d1)
  } else {
    delta <- -exp(-q * T) * pnorm(-d1)
  }
  
  # Gamma (igual para call y put)
  gamma <- (exp(-q * T) * phi_d1) / (S * sigma * sqrt(T))
  
  # Vega (igual para call y put, derivada respecto a sigma)
  vega <- S * exp(-q * T) * sqrt(T) * phi_d1
  
  # Theta (decaimiento temporal por anio)
  termino_comun <- -(S * sigma * exp(-q * T) * phi_d1) / (2 * sqrt(T))
  if (type == "call") {
    theta <- termino_comun - r * K * exp(-r * T) * pnorm(d2) + q * S * exp(-q * T) * pnorm(d1)
  } else {
    theta <- termino_comun + r * K * exp(-r * T) * pnorm(-d2) - q * S * exp(-q * T) * pnorm(-d1)
  }
  
  # Rho (sensibilidad respecto a la tasa de interes)
  if (type == "call") {
    rho <- K * T * exp(-r * T) * pnorm(d2)
  } else {
    rho <- -K * T * exp(-r * T) * pnorm(-d2)
  }
  
  data.frame(
    S = S,
    precio = bsm_price(S, K, r, q, sigma, T, type),
    delta = delta,
    gamma = gamma,
    vega = vega,
    theta = theta,
    rho = rho,
    type = type
  )
}

# ------------------------------------------------------------------------------
# 2. Arbol Binomial de Cox-Ross-Rubinstein (1979)
# ------------------------------------------------------------------------------

#' Valoracion mediante Arbol Binomial CRR
#'
#' @param n_steps Numero de pasos temporales en el arbol
#' @param style Estilo de ejercicio: "european" o "american"
crr_binomial_price <- function(S, K, r, q = 0, sigma, T, n_steps = 100,
                               type = c("call", "put"), style = c("european", "american")) {
  type  <- match.arg(type)
  style <- match.arg(style)
  
  dt <- T / n_steps
  u  <- exp(sigma * sqrt(dt))
  d  <- 1 / u
  p  <- (exp((r - q) * dt) - d) / (u - d)
  disc <- exp(-r * dt)
  
  # Precios del subyacente en el paso terminal N
  j <- 0:n_steps
  ST <- S * (u^j) * (d^(n_steps - j))
  
  # Payoffs al vencimiento
  if (type == "call") {
    valores <- pmax(ST - K, 0)
  } else {
    valores <- pmax(K - ST, 0)
  }
  
  # Induccion hacia atras (Backward Induction)
  for (i in (n_steps - 1):0) {
    valores <- disc * (p * valores[2:(i + 2)] + (1 - p) * valores[1:(i + 1)])
    if (style == "american") {
      j_sub <- 0:i
      S_actual <- S * (u^j_sub) * (d^(i - j_sub))
      if (type == "call") {
        valores <- pmax(valores, S_actual - K)
      } else {
        valores <- pmax(valores, K - S_actual)
      }
    }
  }
  
  return(valores[1])
}

# ------------------------------------------------------------------------------
# 3. Simulacion de Monte Carlo Neutral al Riesgo
# ------------------------------------------------------------------------------

#' Valoracion de Opciones por Monte Carlo con Variables Antiteticas
#'
#' @param n_sim Numero de simulaciones
#' @param antithetic Logico; si TRUE usa variables antiteticas para reduccion de varianza
#' @param seed Semilla reproducible
mc_option_price <- function(S, K, r, q = 0, sigma, T, n_sim = 100000,
                            type = c("call", "put"), antithetic = TRUE, seed = 1997) {
  type <- match.arg(type)
  if (!is.null(seed)) set.seed(seed)
  
  drift <- (r - q - 0.5 * sigma^2) * T
  vol_term <- sigma * sqrt(T)
  
  if (antithetic) {
    m <- ceiling(n_sim / 2)
    z <- rnorm(m)
    st_pos <- S * exp(drift + vol_term * z)
    st_neg <- S * exp(drift - vol_term * z)
    
    if (type == "call") {
      payoffs_pos <- pmax(st_pos - K, 0)
      payoffs_neg <- pmax(st_neg - K, 0)
    } else {
      payoffs_pos <- pmax(K - st_pos, 0)
      payoffs_neg <- pmax(K - st_neg, 0)
    }
    
    payoffs <- 0.5 * (payoffs_pos + payoffs_neg)
    n_eff <- m
  } else {
    z <- rnorm(n_sim)
    st <- S * exp(drift + vol_term * z)
    if (type == "call") {
      payoffs <- pmax(st - K, 0)
    } else {
      payoffs <- pmax(K - st, 0)
    }
    n_eff <- n_sim
  }
  
  factor_descuento <- exp(-r * T)
  precio_mc <- factor_descuento * mean(payoffs)
  se_mc     <- factor_descuento * sd(payoffs) / sqrt(n_eff)
  
  list(
    precio = precio_mc,
    error_estandar = se_mc,
    ic_inferior = precio_mc - 1.96 * se_mc,
    ic_superior = precio_mc + 1.96 * se_mc,
    n_simulaciones = n_sim
  )
}

# ------------------------------------------------------------------------------
# 4. Modelo Estructural de Deuda de Merton (1974)
# ------------------------------------------------------------------------------

#' Modelo Estructural de Deuda Corporativa y Riesgo de Credito (Merton 1974)
#'
#' @param V Valor actual de los activos totales de la empresa
#' @param D Valor nominal de la deuda que vence en T (punto de quiebra)
#' @param r Tasa de interes libre de riesgo anualizada
#' @param sigma_V Volatilidad anualizada del valor de los activos
#' @param T Vencimiento de la deuda
merton_credit_risk <- function(V, D, r, sigma_V, T) {
  # El capital accionario (Equity) es un Call sobre los activos V con strike D
  equity <- bsm_price(S = V, K = D, r = r, q = 0, sigma = sigma_V, T = T, type = "call")
  
  # El valor de la deuda riesgosa es: Activos - Equity
  # Deuda = D * exp(-r*T) - Put(V, D, r, sigma_V, T)
  put_quiebra <- bsm_price(S = V, K = D, r = r, q = 0, sigma = sigma_V, T = T, type = "put")
  deuda_riesgosa <- V - equity
  
  # Rendimiento implícito al vencimiento de la deuda
  ytm <- -log(deuda_riesgosa / D) / T
  credit_spread <- (ytm - r) * 10000 # en puntos basicos (bps)
  
  # Probabilidad de incumplimiento neutral al riesgo
  d2 <- bsm_d2(S = V, K = D, r = r, q = 0, sigma = sigma_V, T = T)
  prob_default_rn <- pnorm(-d2)
  
  data.frame(
    V = V,
    D = D,
    Equity = equity,
    Deuda_Riesgosa = deuda_riesgosa,
    Deuda_Libre_Riesgo = D * exp(-r * T),
    Put_Quiebra = put_quiebra,
    Spread_Credito_bps = credit_spread,
    Prob_Default_RN = prob_default_rn
  )
}

# ------------------------------------------------------------------------------
# 5. Generacion de Resultados, Figuras y Tablas
# ------------------------------------------------------------------------------

cat("=== 1. Ejecutando Simulaciones y Comparaciones Numericas ===\n")

# Parametros de referencia del contrato
S0    <- 100   # Spot
K0    <- 100   # Strike
r0    <- 0.05  # 5% tasa libre de riesgo
q0    <- 0.02  # 2% dividend yield continuo
sigma0<- 0.20  # 20% volatilidad
T0    <- 1.0   # 1 anio

# A. Tabla Comparativa de Precision: Analitica vs Arbol CRR vs Monte Carlo
contratos_test <- data.frame(
  Nombre = c("ITM Call", "ATM Call", "OTM Call", "ITM Put", "ATM Put", "OTM Put"),
  Tipo   = c("call", "call", "call", "put", "put", "put"),
  S      = c(110, 100, 90, 90, 100, 110),
  K      = rep(100, 6)
)

resultados_lista <- list()

for (i in seq_len(nrow(contratos_test))) {
  ct <- contratos_test[i, ]
  p_analitico <- bsm_price(ct$S, ct$K, r0, q0, sigma0, T0, type = ct$Tipo)
  p_crr_100   <- crr_binomial_price(ct$S, ct$K, r0, q0, sigma0, T0, n_steps = 100, type = ct$Tipo)
  p_crr_500   <- crr_binomial_price(ct$S, ct$K, r0, q0, sigma0, T0, n_steps = 500, type = ct$Tipo)
  mc_res      <- mc_option_price(ct$S, ct$K, r0, q0, sigma0, T0, n_sim = 500000, type = ct$Tipo, seed = 1997 + i)
  
  resultados_lista[[i]] <- data.frame(
    Contrato           = ct$Nombre,
    Tipo               = ct$Tipo,
    S                  = ct$S,
    K                  = ct$K,
    BSM_Analitico      = round(p_analitico, 4),
    CRR_100_Pasos      = round(p_crr_100, 4),
    CRR_500_Pasos      = round(p_crr_500, 4),
    Error_CRR_500      = round(abs(p_crr_500 - p_analitico), 5),
    Monte_Carlo_500k   = round(mc_res$precio, 4),
    MC_Error_Estandar  = round(mc_res$error_estandar, 5),
    MC_IC_Inf          = round(mc_res$ic_inferior, 4),
    MC_IC_Sup          = round(mc_res$ic_superior, 4),
    Error_MC           = round(abs(mc_res$precio - p_analitico), 5)
  )
}

tab_resultados <- do.call(rbind, resultados_lista)
ruta_tabla <- file.path(dir_salidas, "tab_resultados_bsm.csv")
write.csv(tab_resultados, ruta_tabla, row.names = FALSE)
cat("-> Tabla guardada en:", ruta_tabla, "\n")
print(tab_resultados[, c("Contrato", "BSM_Analitico", "CRR_500_Pasos", "Monte_Carlo_500k", "MC_Error_Estandar")])

# B. Figura 1: Precios y Griegas de BSM vs Spot
cat("\n=== 2. Generando Figura 1: Curvas de Precios y Griegas ===\n")

s_grid <- seq(50, 150, by = 0.5)

# Calculo de datos para graficos
df_call <- bsm_greeks(s_grid, K0, r0, q0, sigma0, T0, type = "call")
df_put  <- bsm_greeks(s_grid, K0, r0, q0, sigma0, T0, type = "put")

# Sensibilidad temporal de Delta (T = 0.1, 0.5, 1.0)
df_delta_t <- do.call(rbind, lapply(c(0.1, 0.5, 1.0), function(tt) {
  data.frame(
    S = s_grid,
    Delta = bsm_greeks(s_grid, K0, r0, q0, sigma0, tt, type = "call")$delta,
    Vencimiento = paste0("T = ", tt, " anios")
  )
}))

# Tema visual institucional
tema_nobel <- theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12, color = "#1a252f"),
    plot.subtitle = element_text(size = 9, color = "#555555"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#e5e7eb", linewidth = 0.5),
    legend.position = "bottom",
    legend.title = element_text(face = "bold", size = 9),
    strip.text = element_text(face = "bold", size = 10)
  )

# Panel 1: Precios de Opcion vs Spot con valor intrinseco
df_precios <- data.frame(
  S = rep(s_grid, 2),
  Precio = c(df_call$precio, df_put$precio),
  Intrinseco = c(pmax(s_grid - K0, 0), pmax(K0 - s_grid, 0)),
  Tipo = factor(rep(c("Call Europeo", "Put Europeo"), each = length(s_grid)))
)

p1 <- ggplot(df_precios, aes(x = S)) +
  geom_line(aes(y = Precio, color = Tipo), linewidth = 1.1) +
  geom_line(aes(y = Intrinseco, color = Tipo), linetype = "dashed", alpha = 0.6, linewidth = 0.7) +
  geom_vline(xintercept = K0, linetype = "dotted", color = "#7f8c8d") +
  annotate("text", x = K0 + 2, y = 45, label = "Strike K = 100", size = 3, hjust = 0, color = "#555555") +
  scale_color_manual(values = c("Call Europeo" = "#1e3a8a", "Put Europeo" = "#b91c1c")) +
  labs(
    title = "A) Precios Black-Scholes-Merton y Payoffs Intrinsecos",
    subtitle = "Lineas continuas: Valor teorico BSM. Lineas punteadas: Payoff intrinseco al vencimiento.",
    x = "Precio del Subyacente (Spot S)",
    y = "Precio de la Opcion ($)",
    color = "Instrumento:"
  ) +
  tema_nobel

# Panel 2: Delta vs Spot para distintos vencimientos
p2 <- ggplot(df_delta_t, aes(x = S, y = Delta, color = Vencimiento)) +
  geom_line(linewidth = 1) +
  geom_vline(xintercept = K0, linetype = "dotted", color = "#7f8c8d") +
  scale_color_manual(values = c("T = 0.1 anios" = "#dc2626", "T = 0.5 anios" = "#d97706", "T = 1 anios" = "#2563eb")) +
  labs(
    title = "B) Cobertura Dinamica: Delta del Call para Distintos Plazos",
    subtitle = "A medida que T -> 0, Delta converge a una funcion escalon Heaviside en el Strike.",
    x = "Precio del Subyacente (Spot S)",
    y = "Delta (dC/dS)",
    color = "Madurez:"
  ) +
  tema_nobel

# Panel 3: Gamma vs Spot (Curvatura)
p3 <- ggplot(df_call, aes(x = S, y = gamma)) +
  geom_area(fill = "#3b82f6", alpha = 0.25) +
  geom_line(color = "#1d4ed8", linewidth = 1) +
  geom_vline(xintercept = K0, linetype = "dotted", color = "#7f8c8d") +
  labs(
    title = "C) Gamma (Riesgo de Curvatura de Cobertura)",
    subtitle = "Alcanza su maximo exactamente en el dinero (ATM, S = K = 100).",
    x = "Precio del Subyacente (Spot S)",
    y = "Gamma (d2C/dS2)"
  ) +
  tema_nobel

# Panel 4: Vega vs Spot (Sensibilidad a la Volatilidad)
p4 <- ggplot(df_call, aes(x = S, y = vega)) +
  geom_area(fill = "#10b981", alpha = 0.25) +
  geom_line(color = "#047857", linewidth = 1) +
  geom_vline(xintercept = K0, linetype = "dotted", color = "#7f8c8d") +
  labs(
    title = "D) Vega (Sensibilidad a la Volatilidad Implicita)",
    subtitle = "Maximo valor temporal y sensibilidad en contratos ATM.",
    x = "Precio del Subyacente (Spot S)",
    y = "Vega (dC/dsigma)"
  ) +
  tema_nobel

# Panel 5: Theta vs Spot (Decaimiento Temporal)
p5 <- ggplot(df_call, aes(x = S, y = theta)) +
  geom_area(fill = "#f97316", alpha = 0.25) +
  geom_line(color = "#c2410c", linewidth = 1) +
  geom_vline(xintercept = K0, linetype = "dotted", color = "#7f8c8d") +
  labs(
    title = "E) Theta del Call (Decaimiento Temporal por Anio)",
    subtitle = "Tasa negativa de perdida de valor por el mero paso del tiempo.",
    x = "Precio del Subyacente (Spot S)",
    y = "Theta (dC/dt)"
  ) +
  tema_nobel

# Ensamblado de Figura 1 con base grid
ruta_fig1 <- file.path(dir_salidas, "fig_bsm_precio_y_griegas.png")

# Guardar figura compuesta de 2x2 paneles principales
png(ruta_fig1, width = 2800, height = 2200, res = 260)
grid::grid.newpage()
grid::pushViewport(grid::viewport(layout = grid::grid.layout(2, 2)))

print(p1, vp = grid::viewport(layout.pos.row = 1, layout.pos.col = 1))
print(p2, vp = grid::viewport(layout.pos.row = 1, layout.pos.col = 2))
print(p3, vp = grid::viewport(layout.pos.row = 2, layout.pos.col = 1))
print(p4, vp = grid::viewport(layout.pos.row = 2, layout.pos.col = 2))
dev.off()
cat("-> Figura 1 guardada en:", ruta_fig1, "\n")

# C. Figura 2: Convergencia Numerica (Monte Carlo y Arbol Binomial CRR)
cat("\n=== 3. Generando Figura 2: Convergencia Monte Carlo y Arbol Binomial ===\n")

# 1. Evaluacion de convergencia Monte Carlo para ATM Call
sim_grid <- c(500, 1000, 2500, 5000, 10000, 25000, 50000, 100000, 250000, 500000)
precio_analitico_atm <- bsm_price(S0, K0, r0, q0, sigma0, T0, type = "call")

mc_conv <- do.call(rbind, lapply(sim_grid, function(m) {
  res <- mc_option_price(S0, K0, r0, q0, sigma0, T0, n_sim = m, type = "call", seed = 42 + m)
  data.frame(
    Simulaciones = m,
    Precio_MC    = res$precio,
    IC_Inf       = res$ic_inferior,
    IC_Sup       = res$ic_superior,
    Error_Abs    = abs(res$precio - precio_analitico_atm)
  )
}))

p_mc_conv <- ggplot(mc_conv, aes(x = Simulaciones, y = Precio_MC)) +
  geom_ribbon(aes(ymin = IC_Inf, ymax = IC_Sup), fill = "#93c5fd", alpha = 0.4) +
  geom_line(color = "#1d4ed8", linewidth = 1) +
  geom_point(color = "#1e40af", size = 2) +
  geom_hline(yintercept = precio_analitico_atm, color = "#b91c1c", linetype = "dashed", linewidth = 1) +
  scale_x_log10(labels = scales::comma) +
  annotate("text", x = 1000, y = precio_analitico_atm + 0.35,
           label = paste0("Precio Analitico BSM = $", round(precio_analitico_atm, 4)),
           color = "#b91c1c", fontface = "bold", size = 3.5, hjust = 0) +
  labs(
    title = "A) Convergencia de Monte Carlo al Valor Analitico BSM",
    subtitle = "Intervalo de confianza al 95% (banda azul) estrechandose con tasa O(1/sqrt(M)).",
    x = "Numero de Trayectorias Simuladas (Escala Logaritmica)",
    y = "Precio Estimado del Call ($)"
  ) +
  tema_nobel

# 2. Evaluacion de convergencia de Arbol Binomial CRR (efecto paridad/imparidad de pasos)
pasos_grid <- seq(5, 250, by = 1)
crr_precios <- sapply(pasos_grid, function(n) {
  crr_binomial_price(S0, K0, r0, q0, sigma0, T0, n_steps = n, type = "call")
})

df_crr_conv <- data.frame(
  Pasos = pasos_grid,
  Precio_CRR = crr_precios,
  Paridad = ifelse(pasos_grid %% 2 == 0, "Pasos Pares", "Pasos Impares")
)

p_crr_conv <- ggplot(df_crr_conv, aes(x = Pasos, y = Precio_CRR)) +
  geom_line(aes(color = Paridad), alpha = 0.8, linewidth = 0.7) +
  geom_hline(yintercept = precio_analitico_atm, color = "#b91c1c", linetype = "dashed", linewidth = 1) +
  scale_color_manual(values = c("Pasos Pares" = "#059669", "Pasos Impares" = "#d97706")) +
  annotate("text", x = 10, y = precio_analitico_atm + 0.25,
           label = paste0("Limite Continuo BSM = $", round(precio_analitico_atm, 4)),
           color = "#b91c1c", fontface = "bold", size = 3.5, hjust = 0) +
  labs(
    title = "B) Convergencia Oscilatoria del Arbol Binomial (CRR 1979)",
    subtitle = "Demostracion numerica de que el modelo binomial converge al continuo BSM cuando Delta t -> 0.",
    x = "Numero de Pasos Discretos en el Arbol (N)",
    y = "Precio Estimado del Call ($)",
    color = "Particion:"
  ) +
  tema_nobel

ruta_fig2 <- file.path(dir_salidas, "fig_bsm_convergencia_monte_carlo.png")

png(ruta_fig2, width = 2800, height = 1500, res = 260)
grid::grid.newpage()
grid::pushViewport(grid::viewport(layout = grid::grid.layout(1, 2)))
print(p_mc_conv, vp = grid::viewport(layout.pos.row = 1, layout.pos.col = 1))
print(p_crr_conv, vp = grid::viewport(layout.pos.row = 1, layout.pos.col = 2))
dev.off()
cat("-> Figura 2 guardada en:", ruta_fig2, "\n")

cat("\n=== Replicacion de Black-Scholes-Merton completada con exito ===\n")

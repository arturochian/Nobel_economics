# Funciones didácticas inspiradas en Samuelson (nivel ilustrativo).

simular_multiplicador_acelerador <- function(
    periodos = 40, gasto_autonomo = 50, propension_consumir = 0.75,
    acelerador = 0.4, shock = 20, periodo_shock = 3) {
  stopifnot(periodos >= 3, propension_consumir >= 0, acelerador >= 0)
  equilibrio <- gasto_autonomo / (1 - propension_consumir)
  ingreso <- rep(equilibrio, periodos)
  impulso <- rep(0, periodos)
  impulso[periodo_shock] <- shock

  for (t in 3:periodos) {
    ingreso[t] <- gasto_autonomo + propension_consumir * ingreso[t - 1] +
      acelerador * (ingreso[t - 1] - ingreso[t - 2]) + impulso[t]
  }

  data.frame(periodo = seq_len(periodos), ingreso, equilibrio, impulso)
}

raices_dinamica <- function(propension_consumir, acelerador) {
  polyroot(c(acelerador, -(propension_consumir + acelerador), 1))
}

clasificar_estabilidad <- function(propension_consumir, acelerador) {
  modulo <- Mod(raices_dinamica(propension_consumir, acelerador))
  if (max(modulo) < 1) "estable" else if (max(modulo) > 1) "inestable" else "frontera"
}

elegir_cobb_douglas <- function(p1, p2, ingreso, alpha = 0.5) {
  data.frame(x1 = alpha * ingreso / p1, x2 = (1 - alpha) * ingreso / p2)
}

comprobar_warp <- function(precios, elecciones, tolerancia = 1e-8) {
  n <- nrow(precios)
  violaciones <- list()
  for (i in seq_len(n - 1)) {
    for (j in (i + 1):n) {
      gasto_i_xi <- sum(precios[i, ] * elecciones[i, ])
      gasto_i_xj <- sum(precios[i, ] * elecciones[j, ])
      gasto_j_xj <- sum(precios[j, ] * elecciones[j, ])
      gasto_j_xi <- sum(precios[j, ] * elecciones[i, ])
      if (gasto_i_xi + tolerancia >= gasto_i_xj &&
          gasto_j_xj > gasto_j_xi + tolerancia) {
        violaciones[[length(violaciones) + 1]] <- c(i, j)
      }
      if (gasto_j_xj + tolerancia >= gasto_j_xi &&
          gasto_i_xi > gasto_i_xj + tolerancia) {
        violaciones[[length(violaciones) + 1]] <- c(j, i)
      }
    }
  }
  if (!length(violaciones)) matrix(integer(), ncol = 2) else do.call(rbind, violaciones)
}


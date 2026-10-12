# Modelo didáctico de impulso-propagación inspirado en Frisch y Tinbergen.
# Trabaja con desviaciones respecto del equilibrio, no con unidades monetarias.

simular_impulso <- function(periodos = 40L,
                            propension = 0.6,
                            acelerador = 0.7,
                            persistencia = 0,
                            amplitud = 10,
                            estocastico = FALSE,
                            desviacion = 1,
                            semilla = 1969L) {
  stopifnot(periodos >= 4, propension >= 0, propension < 1,
            acelerador >= 0, acelerador < 1,
            persistencia >= 0, persistencia < 1,
            desviacion >= 0)

  set.seed(semilla)
  choque <- numeric(periodos)
  innovacion <- if (estocastico) rnorm(periodos, sd = desviacion) else numeric(periodos)
  choque[1] <- amplitud + innovacion[1]
  if (periodos > 1) {
    for (t in 2:periodos) {
      choque[t] <- persistencia * choque[t - 1] + innovacion[t]
    }
  }

  actividad <- numeric(periodos)
  for (t in seq_len(periodos)) {
    rezago_1 <- if (t > 1) actividad[t - 1] else 0
    rezago_2 <- if (t > 2) actividad[t - 2] else 0
    actividad[t] <- (propension + acelerador) * rezago_1 -
      acelerador * rezago_2 + choque[t]
  }

  data.frame(
    periodo = seq_len(periodos),
    actividad = actividad,
    choque = choque
  )
}

raices_modelo <- function(propension = 0.6, acelerador = 0.7) {
  polyroot(c(acelerador, -(propension + acelerador), 1))
}

es_estable <- function(propension = 0.6, acelerador = 0.7) {
  all(Mod(raices_modelo(propension, acelerador)) < 1)
}

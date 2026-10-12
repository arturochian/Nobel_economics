# Funciones didacticas para una economia de dos sectores.
# No estiman la relacion historica de Kuznets: generan una ilustracion calibrada.

gini_vector <- function(x) {
  x <- as.numeric(x)
  if (any(!is.finite(x)) || any(x < 0) || mean(x) == 0) {
    stop("Los ingresos deben ser finitos, no negativos y con media positiva.")
  }
  n <- length(x)
  sum(abs(outer(x, x, "-"))) / (2 * n^2 * mean(x))
}

simular_transformacion <- function(
    periodos = 61,
    participacion_agricola_inicial = 0.80,
    participacion_agricola_final = 0.10,
    brecha_maxima = 3,
    crecimiento_productividad = 0.025,
    hogares = 1000,
    semilla = 1971) {
  stopifnot(periodos >= 3, hogares >= 100, brecha_maxima >= 1)
  set.seed(semilla)
  etapa <- seq(0, 1, length.out = periodos)
  share_ag <- participacion_agricola_inicial *
    (participacion_agricola_final / participacion_agricola_inicial)^etapa
  productividad_ag <- exp(crecimiento_productividad * (etapa * (periodos - 1)))
  # La prima urbano/agricola primero crece y luego converge.
  prima_urbana <- 1 + (brecha_maxima - 1) * 4 * etapa * (1 - etapa)

  filas <- lapply(seq_along(etapa), function(i) {
    es_agricola <- seq_len(hogares) <= round(hogares * share_ag[i])
    ruido <- exp(rnorm(hogares, mean = -0.5 * 0.12^2, sd = 0.12))
    ingreso <- productividad_ag[i] * ifelse(es_agricola, 1, prima_urbana[i]) * ruido
    data.frame(
      periodo = i - 1,
      etapa = etapa[i],
      participacion_agricola = mean(es_agricola),
      prima_urbana = prima_urbana[i],
      ingreso_medio = mean(ingreso),
      gini = gini_vector(ingreso)
    )
  })
  do.call(rbind, filas)
}

guardar_salidas_kuznets <- function(resultados, directorio = "salidas") {
  dir.create(directorio, recursive = TRUE, showWarnings = FALSE)
  utils::write.csv(
    resultados,
    file.path(directorio, "tab_kuznets_simulacion.csv"),
    row.names = FALSE
  )

  grDevices::png(file.path(directorio, "fig_kuznets_transformacion.png"),
    width = 1400, height = 850, res = 150
  )
  old <- graphics::par(mar = c(5, 5, 3, 5))
  on.exit({graphics::par(old); grDevices::dev.off()}, add = TRUE)
  graphics::plot(resultados$periodo, 100 * resultados$participacion_agricola,
    type = "l", lwd = 3, col = "#256d5b", xlab = "Periodo simulado",
    ylab = "Empleo agricola (%)", ylim = c(0, 100)
  )
  graphics::par(new = TRUE)
  graphics::plot(resultados$periodo, 100 * resultados$gini,
    type = "l", lwd = 3, col = "#c58b2a", axes = FALSE, xlab = "", ylab = ""
  )
  graphics::axis(4, col.axis = "#c58b2a")
  graphics::mtext("Gini simulado (0-100)", side = 4, line = 3, col = "#c58b2a")
  graphics::legend("topright", c("Empleo agricola", "Gini"),
    col = c("#256d5b", "#c58b2a"), lwd = 3, bty = "n"
  )
  invisible(resultados)
}

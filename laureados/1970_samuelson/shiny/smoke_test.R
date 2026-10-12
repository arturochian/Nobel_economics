# Prueba de humo no interactiva: carga la lógica compartida y valida la salida.
source(file.path("laureados", "1970_samuelson", "replicacion", "R", "modelos_samuelson.R"))

x <- simular_multiplicador_acelerador(periodos = 15)
stopifnot(nrow(x) == 15, all(is.finite(x$ingreso)))
stopifnot(clasificar_estabilidad(0.75, 0.4) == "estable")

if (requireNamespace("shiny", quietly = TRUE) &&
    requireNamespace("bslib", quietly = TRUE)) {
  app <- shiny::shinyAppFile(file.path("laureados", "1970_samuelson", "shiny", "app.R"))
  stopifnot(inherits(app, "shiny.appobj"))
}


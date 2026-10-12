# Reutiliza la única implementación del modelo; no duplica la lógica.
ruta_modelo <- file.path("..", "replicacion", "R", "modelo_dinamico.R")
if (!file.exists(ruta_modelo)) {
  ruta_modelo <- file.path("laureados", "1969_frisch_tinbergen", "replicacion", "R", "modelo_dinamico.R")
}
source(ruta_modelo, local = TRUE)

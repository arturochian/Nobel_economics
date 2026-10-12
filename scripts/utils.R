# utils.R — Funciones utilitarias comunes para Nobel_economics

#' Obtener cabecera de petición HTTP con email de contacto
#' @return Carácter con el User-Agent o email configurado
get_contact_email <- function() {
  email <- Sys.getenv("NOBEL_CONTACT_EMAIL", unset = "researcher@example.org")
  return(email)
}

#' Guardar gráfico en formato PNG estándar para salidas de replicación
#' @param plot Objeto ggplot2
#' @param filename Nombre del archivo en salidas/
#' @param width Ancho en pulgadas (por defecto 8)
#' @param height Alto en pulgadas (por defecto 5)
guardar_grafico <- function(plot, filename, width = 8, height = 5) {
  if (!dir.exists(dirname(filename))) {
    dir.create(dirname(filename), recursive = TRUE, showWarnings = FALSE)
  }
  ggplot2::ggsave(
    filename = filename,
    plot = plot,
    width = width,
    height = height,
    dpi = 300
  )
  message(sprintf("Gráfico guardado en: %s", filename))
}

#' Guardar tabla resumen en CSV
#' @param df data.frame o tibble
#' @param filename Ruta del archivo destino
guardar_tabla <- function(df, filename) {
  if (!dir.exists(dirname(filename))) {
    dir.create(dirname(filename), recursive = TRUE, showWarnings = FALSE)
  }
  readr::write_csv(df, filename)
  message(sprintf("Tabla guardada en: %s", filename))
}

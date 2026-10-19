# scripts/verificar_shiny.R
# Verifica que todas las apps Shiny en laureados/*/shiny/app.R
# sean sintacticamente validas y creen un objeto shiny.appobj operativo sin errores.

suppressPackageStartupMessages({
  library(shiny)
  library(bslib)
})

slugs_to_test <- commandArgs(trailingOnly = TRUE)

if (length(slugs_to_test) == 0) {
  # Si no se pasan argumentos, buscar todas las carpetas en laureados/
  all_dirs <- list.dirs("laureados", recursive = FALSE)
} else {
  all_dirs <- file.path("laureados", slugs_to_test)
}

resultados <- data.frame(
  slug = character(),
  tiene_shiny = logical(),
  es_valido = logical(),
  error = character(),
  stringsAsFactors = FALSE
)

for (d in all_dirs) {
  slug <- basename(d)
  app_file <- file.path(d, "shiny", "app.R")
  
  if (!file.exists(app_file)) {
    resultados <- rbind(resultados, data.frame(
      slug = slug,
      tiene_shiny = FALSE,
      es_valido = FALSE,
      error = "No existe app.R",
      stringsAsFactors = FALSE
    ))
    next
  }
  
  # Evaluar app en un entorno aislado
  env <- new.env(parent = globalenv())
  err_msg <- ""
  valido <- FALSE
  
  tryCatch({
    # sys.source carga el archivo
    sys.source(app_file, envir = env)
    if (!exists("ui", envir = env) || !exists("server", envir = env)) {
      stop("Falta definir 'ui' o 'server' en el archivo app.R")
    }
    app_obj <- shiny::shinyApp(ui = env$ui, server = env$server)
    if (!inherits(app_obj, "shiny.appobj")) {
      stop("shinyApp() no retorno un objeto clase 'shiny.appobj'")
    }
    valido <- TRUE
  }, error = function(e) {
    err_msg <<- conditionMessage(e)
  })
  
  resultados <- rbind(resultados, data.frame(
    slug = slug,
    tiene_shiny = TRUE,
    es_valido = valido,
    error = err_msg,
    stringsAsFactors = FALSE
  ))
}

# Reporte
cat("\n=======================================================\n")
cat("RESULTADOS DE VERIFICACION SHINY\n")
cat("=======================================================\n")
cat("Total evaluados:       ", nrow(resultados), "\n")
cat("Con shiny/app.R:       ", sum(resultados$tiene_shiny), "\n")
cat("Validos y operativos:  ", sum(resultados$es_valido), "\n")
cat("Con errores:           ", sum(resultados$tiene_shiny & !resultados$es_valido), "\n")
cat("Sin shiny:             ", sum(!resultados$tiene_shiny), "\n")
cat("=======================================================\n")

errores <- resultados[resultados$tiene_shiny & !resultados$es_valido, ]
if (nrow(errores) > 0) {
  cat("\nERRORES ENCONTRADOS:\n")
  for (i in seq_len(nrow(errores))) {
    cat(sprintf(" - %s: %s\n", errores$slug[i], errores$error[i]))
  }
}

faltantes <- resultados[!resultados$tiene_shiny, ]
if (nrow(faltantes) > 0) {
  cat(sprintf("\nFALTAN SHINY (%d laureados):\n", nrow(faltantes)))
  cat(paste(faltantes$slug, collapse = ", "), "\n")
}

# Salir con codigo 0 si los que tienen shiny son validos, o 1 si hay errores
if (nrow(errores) > 0) {
  quit(status = 1)
} else {
  quit(status = 0)
}

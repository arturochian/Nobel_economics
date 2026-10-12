# App Shiny: impulsos y propagación

La app permite cambiar cuatro parámetros y observar en vivo la respuesta de un modelo dinámico ilustrativo. Reutiliza `replicacion/R/modelo_dinamico.R`, no descarga datos ni necesita claves de API.

Desde la raíz del repositorio, restaura el entorno y ejecútala:

```r
renv::restore()
shiny::runApp("laureados/1969_frisch_tinbergen/shiny")
```

Los valores iniciales (`c = 0.6`, `v = 0.7`, persistencia `0`, impulso `10`) coinciden con la figura principal de la replicación. Nivel: **ilustrativa**. La exportación a Shinylive debe realizarse durante el build global del sitio.

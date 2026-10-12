# App Shiny: transformación estructural

La app ilustra cómo la salida de la agricultura y una brecha temporal de ingresos entre sectores pueden producir una trayectoria no monótona del Gini. Es una simulación **ilustrativa**, sin datos históricos ni API.

Desde la raíz del repositorio, restaura el entorno y ejecuta:

```r
renv::restore()
shiny::runApp("laureados/1971_kuznets/shiny")
```

Los cuatro controles modifican la estructura sectorial, la prima urbana y la productividad. El botón **Restablecer valores** recupera la calibración usada en la replicación. La lógica se reutiliza desde `replicacion/R/modelo_kuznets.R`; no se duplica el modelo.

La exportación Shinylive queda pendiente de la fase global de publicación, porque `web/public/apps/` es generado y no pertenece a esta carpeta.

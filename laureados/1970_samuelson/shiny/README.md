# Laboratorio dinámico de Samuelson

App didáctica **ilustrativa** del modelo multiplicador–acelerador usado en la replicación. Permite variar la propensión a consumir, el acelerador, el tamaño del shock y el horizonte; muestra la trayectoria del ingreso y el criterio de estabilidad. No descarga datos ni requiere API.

Desde la raíz del repositorio:

```r
renv::restore()
shiny::runApp("laureados/1970_samuelson/shiny")
```

La app utiliza `shiny` y gráficos de R base para mantenerla ligera. El botón **Restablecer valores** recupera la calibración del informe. La exportación Shinylive queda a cargo del proceso global de publicación.


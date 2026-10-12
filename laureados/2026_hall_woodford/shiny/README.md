# App Interactiva Shiny: Modelo Nuevo Keynesiano (Nobel 2026)

Esta aplicación permite a los estudiantes experimentar de forma directa e interactiva con el marco analítico de **Michael Woodford** y **Robert E. Hall**, visualizando cómo las decisiones de política monetaria y los parámetros estructurales determinan la estabilidad macroeconómica.

## Qué enseña la app
1. **El Principio de Taylor ($\phi_\pi > 1$):** Comprueba cómo responde la inflación cuando el banco central sube la tasa de interés más de 1 a 1 versus cuando es pasivo ($\phi_\pi \le 1$).
2. **Suavizamiento de tasas / Inercia ($\rho_i$):** Observa cómo una política monetaria predecible y gradual estabiliza las fluctuaciones del ciclo.
3. **Rigideces de precios ($\kappa$):** Explora cómo la pendiente de la Curva de Phillips Calvo-Woodford altera la velocidad de transmisión monetaria.

## Cómo ejecutar la aplicación localmente en R
Desde R o RStudio en la raíz del proyecto:

```r
# Instalar dependencias si no las tienes
install.packages(c("shiny", "bslib", "ggplot2", "dplyr", "tidyr"))

# Correr la app
shiny::runApp("laureados/2026_hall_woodford/shiny")
```

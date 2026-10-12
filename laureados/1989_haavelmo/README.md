# Nobel de Economía 1989: Trygve Haavelmo

> **Motivación oficial:** *"for his clarification of the probability theory foundations of econometrics and his analyses of simultaneous economic structures"* (por su clarificación de los fundamentos de la teoría probabilística de la econometría y sus análisis de las estructuras económicas simultáneas).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 11 de octubre de 1989.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Entradas BibTeX verificadas de las obras fundamentales de Haavelmo (1943, 1944, 1945, 1947, 1960) y los documentos oficiales del comité Nobel (comunicado de prensa e información científica).
  - [manifest.csv](referencias/manifest.csv): Inventario sistemático de fuentes con identificadores DOI, enlaces canónicos y licencias de acceso.
  - [pdf/](referencias/pdf/): Directorio preparado para albergar documentos y reportes oficiales de libre acceso de la Fundación Nobel.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Documento Quarto reproducible con desarrollo matemático exhaustivo del enfoque probabilístico, derivación analítica paso a paso del sesgo de simultaneidad e inconsistencia de MCO, demostración del estimador de Variables Instrumentales (MC2E) y derivación del Teorema del Presupuesto Equilibrado.
  - [R/enfoque_probabilistico_y_simultaneidad.R](replicacion/R/enfoque_probabilistico_y_simultaneidad.R): Script autónomo y modular en R que simula el experimento Monte Carlo de sesgo de simultaneidad y modela el multiplicador del presupuesto equilibrado.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución (`fig_haavelmo_sesgo_simultaneidad.png`, `fig_haavelmo_presupuesto_equilibrado.png`) y tabla de resultados consolidados (`tab_resultados_haavelmo.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con ejercicios progresivos (básico: derivación del sesgo e inconsistencia asintótica de MCO; intermedio: el teorema del multiplicador de presupuesto equilibrado con impuestos proporcionales; avanzado/reto: condiciones de identificación de Cowles y problema de instrumentos débiles).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Manual docente confidencial con demostraciones matemáticas paso a paso, derivaciones analíticas completas, soluciones numéricas y rúbrica de evaluación pedagógica.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha canónica con metadatos estructurados en YAML para el portal web del proyecto Nobel_economics.

---

## Resumen Ejecutivo del Aporte

Trygve Haavelmo (1911–1999) es considerado el padre metodológico de la econometría moderna. Sus aportes transformaron la disciplina económica:

1. **El Enfoque Probabilístico en Econometría (1944):**
   - Resolvió el escepticismo de Keynes (1939) y Robbins sobre la aplicación de la estadística matemática a datos económicos no experimentales.
   - Demostró que las relaciones macroeconómicas deben formularse formalmente como **procesos generadores de datos estocásticos** (*data-generating processes*, DGP) donde los errores son variables aleatorias dotadas de una función de distribución de probabilidad conjunta, legitimando el uso de la verosimilitud y el contraste de hipótesis.

2. **Sistemas de Ecuaciones Simultáneas y Sesgo de Simultaneidad (1943):**
   - Probó que al estimar una ecuación aislada dentro de un sistema macroeconómico interdependiente (como la función de consumo en interacción con el ingreso nacional), la variable explicativa endógena se correlaciona con la perturbación estructural:
     $$\text{Cov}(Y_t, u_t) = \frac{\sigma_u^2}{1 - \beta} > 0$$
   - En consecuencia, el estimador de MCO es asintóticamente inconsistente y sobreestima la propensión marginal al consumo:
     $$\text{plim} \, \hat{\beta}_{MCO} = \beta + (1 - \beta)\left(\frac{\sigma_u^2}{\sigma_I^2 + \sigma_u^2}\right) > \beta$$
   - Este descubrimiento dio origen al legendario programa de la **Comisión Cowles** (*Cowles Commission*), que desarrolló la teoría de identificación y los estimadores de Variables Instrumentales (MC2E / 2SLS, FIML).

3. **El Teorema del Presupuesto Equilibrado (1945):**
   - Demostró analíticamente que un incremento del gasto público financiado en un 100% mediante impuestos ($\Delta G = \Delta T$) no es macroeconómicamente neutral, sino que produce un efecto expansivo en el PIB con un multiplicador idéntico a 1 ($k=1$), independiente de la propensión marginal al consumo.

---

## Cómo Ejecutar la Replicación

Para reproducir computacionalmente los modelos, generar las figuras y verificar las tablas desde PowerShell:

```powershell
& "C:\Program Files\R\R-4.6.0\bin\Rscript.exe" laureados/1989_haavelmo/replicacion/R/enfoque_probabilistico_y_simultaneidad.R
```

O dentro de una sesión interactiva de R:

```r
source("laureados/1989_haavelmo/replicacion/R/enfoque_probabilistico_y_simultaneidad.R")
```

Las figuras y datos se generarán automáticamente en `laureados/1989_haavelmo/replicacion/salidas/`:
- `fig_haavelmo_sesgo_simultaneidad.png`: Comparación visual de densidades Monte Carlo (MCO vs. MC2E) y rectas estimadas.
- `fig_haavelmo_presupuesto_equilibrado.png`: Curva del multiplicador fiscal teórico según $\beta$ y trayectoria estocástica del PIB ante un choque fiscal.
- `tab_resultados_haavelmo.csv`: Resumen cuantitativo de métricas de sesgo, varianza, RMSE y multiplicadores.

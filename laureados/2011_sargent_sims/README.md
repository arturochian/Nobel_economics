# Nobel de Economía 2011: Thomas J. Sargent y Christopher A. Sims

> **Motivación oficial:** *"for their empirical research on cause and effect in the macroeconomy"* (Por sus investigaciones empíricas sobre causa y efecto en la macroeconomía).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 10 de octubre de 2011.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Sargent y Sims (Econometrica 1980, JPE 1975, monografías académicas) y el documento oficial de antecedentes científicos del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, enlaces y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Directorio preparado para almacenar documentos y artículos de libre acceso.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa del modelo SVAR tri-variado de Sims (1980) y la política sistemática de Sargent (1979).
  - [R/estimacion_svar_macro.R](replicacion/R/estimacion_svar_macro.R): Script autónomo en R que simula las series macroeconómicas, estima el modelo VAR(2), aplica la identificación recursiva de Cholesky y computa las funciones impulso-respuesta (IRF) y la descomposición de varianza del error de pronóstico (FEVD).
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_irf_svar_shocks.png`, `fig_fevd_descomposicion.png`) y datos tabulares numéricos (`tab_resultados_svar.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de ejercicios prácticos graduados (básico sobre la factorización de Cholesky e impacto contemporáneo, intermedio sobre la paradoja del precio (*price puzzle*) y variables informacionales, y avanzado/reto sobre identificación estructural por restricciones de signos de Uhlig vs. restricciones de largo plazo de Blanchard-Quah).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Guía pedagógica confidencial con derivaciones algebraicas paso a paso, respuestas analíticas exhaustivas y rúbrica de evaluación para el profesor.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha técnica y divulgativa con front-matter YAML para integración en la plataforma web del proyecto.

---

## Resumen Ejecutivo del Aporte

Thomas J. Sargent y Christopher A. Sims transformaron radicalmente la comprensión empírica de cómo interactúan las políticas económicas y las variables macroeconómicas agregadas, resolviendo el desafío fundamental de distinguir entre causa y correlación en sistemas dinámicos complejos:

1. **Christopher A. Sims (1980, 1986):** Revolucionó la macroeconometría al introducir los **Vectores Autorregresivos (VAR)** y **VAR Estructurales (SVAR)**. Sims demostró que los modelos keynesianos simultáneos tradicionales imponían restricciones de exclusión teóricamente injustificadas e "increíbles". Su enfoque permitió tratar a las variables endógenamente y utilizar la descomposición de perturbaciones ortogonales (identificación recursiva de Cholesky) para estimar las **Funciones Impulso-Respuesta (IRF)** y la **Descomposición de Varianza del Error de Pronóstico (FEVD)**, cuantificando por primera vez con rigor empírico el efecto dinámico rezagado de los shocks monetarios y fiscales.
2. **Thomas J. Sargent (1975, 1979, 1987):** Desarrolló los métodos econométricos para estimar modelos dinámicos consistentes con la hipótesis de **Expectativas Racionales**. Sargent demostró que los agentes económicos adaptan prospectivamente sus conductas ante cambios en las reglas de las autoridades económicas (operativizando la Crítica de Lucas). Mostró que las decisiones de política no deben evaluarse como shocks aislados aleatorios, sino como **reglas de política sistemáticas**, formulando restricciones de ecuaciones cruzadas (*cross-equation restrictions*) que vinculan las expectativas de los agentes con los parámetros de la regla de política económica.

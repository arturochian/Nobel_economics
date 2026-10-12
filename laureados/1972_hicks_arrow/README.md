# Nobel de Economía 1972: Sir John R. Hicks y Kenneth J. Arrow

> **Motivación oficial:**  
> *"for their pioneering contributions to general economic equilibrium theory and welfare theory"* (Por sus contribuciones pioneras a la teoría del equilibrio económico general y a la teoría del bienestar).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 25 de octubre de 1972.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras fundamentales de Hicks (*Value and Capital* 1939, *Econometrica* 1937, *Economic Journal* 1939, Discurso Nobel 1973) y de Arrow (*Social Choice* 1951, *Econometrica* 1954 con Debreu, *Review of Economic Studies* 1964, *American Economic Review* 1963, Discurso Nobel 1974) y los comunicados oficiales del Comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI, enlaces canónicos y régimen de derechos de autor.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos oficiales y notas técnicas del Comité Nobel (1972).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte reproducible exhaustivo en Quarto que documenta la teoría de la dualidad del consumo, la descomposición de Slutsky-Hicks, las medidas de bienestar ($CV$ y $EV$), y el equilibrio competitivo general de Arrow-Debreu con mercados de activos contingentes de Arrow.
  - [R/equilibrio_general_y_bienestar.R](replicacion/R/equilibrio_general_y_bienestar.R): Script autónomo y ejecutable en R que realiza la descomposición de Hicks y calibra la Caja de Edgeworth con contratos contingentes de Arrow para la asignación óptima del riesgo.
  - [salidas/](replicacion/salidas/): Figuras generadas en alta resolución ([fig_hicks_descomposicion_sustitucion_ingreso.png](replicacion/salidas/fig_hicks_descomposicion_sustitucion_ingreso.png), [fig_arrow_equilibrio_general_edgeworth.png](replicacion/salidas/fig_arrow_equilibrio_general_edgeworth.png)) y tabla cuantitativa de resultados ([tab_resultados_hicks_arrow_1972.csv](replicacion/salidas/tab_resultados_hicks_arrow_1972.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: dualidad, Slutsky-Hicks y variaciones de bienestar; intermedio: activos de Arrow y reparto de riesgo en Caja de Edgeworth; reto: Teorema de Imposibilidad de Arrow y la regla de la mayoría).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, demostraciones analíticas completas paso a paso y solucionario exhaustivo con rúbricas cuantitativas para el equipo docente.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con metadatos YAML canónicos para el portal web estático de la colección Nobel.

---

## Resumen Ejecutivo de las Contribuciones

Sir John R. Hicks (1904–1989) y Kenneth J. Arrow (1921–2017) fundaron las bases formales sobre las que se apoya la microeconomía y la economía del bienestar contemporáneas:

1. **Sir John R. Hicks: Dualidad, Demanda Compensada y Bienestar:**
   - En *Value and Capital* (1939), introdujo de forma sistemática la teoría de la dualidad entre maximización de la utilidad y minimización del gasto, formulando las demandas compensadas hicksianas.
   - Demostró analíticamente la descomposición de la ecuación de Slutsky-Hicks, aislando el **efecto sustitución puro** (siempre no positivo para variaciones en el propio precio) del **efecto ingreso**.
   - Definió las medidas monetarias exactas del cambio en el bienestar del consumidor: la **Variación Compensatoria ($CV$)** y la **Variación Equivalente ($EV$)**, superando las limitaciones metodológicas del excedente del consumidor de Alfred Marshall.
   - En 1937 sintetizó la teoría macroeconómica keynesiana formulando el clásico esquema **IS-LM** (*Mr. Keynes and the "Classics"*).

2. **Kenneth J. Arrow: Imposibilidad Social, Existencia del Equilibrio y Riesgo Contingente:**
   - En *Social Choice and Individual Values* (1951), formuló el **Teorema de Imposibilidad de Arrow**, probando que bajo un dominio universal de preferencias, ninguna regla de decisión social puede satisfacer simultáneamente los principios de no dictadura, transitividad, Pareto débil e independencia de alternativas irrelevantes.
   - En 1954, junto con Gérard Debreu, formuló la primera demostración rigurosa de la **existencia del equilibrio competitivo general** en una economía descentralizada, aplicando métodos topológicos y el teorema de punto fijo de Kakutani.
   - En 1953 y 1964, introdujo los **activos contingentes de Arrow** (*Arrow securities*), demostrando que un sistema de mercados financieros completos permite a agentes con aversión al riesgo asegurarse mutuamente contra contingencias futuras, descentralizando una asignación Pareto-eficiente del riesgo.
   - En 1963, sentó las bases de la economía de la salud, mostrando cómo la incertidumbre y las asimetrías de información rompen los supuestos de competencia perfecta en los servicios médicos.

# Nobel de Economía 1975: Leonid Vitaliyevich Kantorovich y Tjalling C. Koopmans

> **Motivación oficial:**  
> *"for their contributions to the theory of optimum allocation of resources"* (Por sus contribuciones a la teoría de la asignación óptima de recursos).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 14 de octubre de 1975.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras seminales de Kantorovich (*Management Science* 1960 / original 1939; *The Best Use of Economic Resources* 1959/1965; Discurso Nobel 1976) y Koopmans (*Activity Analysis of Production and Allocation* 1951; *Three Essays on the State of Economic Science* 1957; *On the Concept of Optimal Economic Growth* 1965; Discurso Nobel 1977), junto con el comunicado oficial de la Real Academia Sueca de Ciencias.
  - [manifest.csv](referencias/manifest.csv): Control de metadatos bibliográficos, identificadores DOI, enlaces canónicos y regímenes de licencia.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos en PDF de libre acceso y notas técnicas del Comité Nobel.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte reproducible exhaustivo en Quarto con la fundamentación matemática de la programación lineal, la teoría de la dualidad de Von Neumann-Kantorovich-Koopmans, el Teorema de Holguras Complementarias y la simulación multi-sectorial.
  - [R/programacion_lineal_y_precios_sombra.R](replicacion/R/programacion_lineal_y_precios_sombra.R): Script autónomo y ejecutable en R que implementa el algoritmo simplex primal y dual (`lpSolve`), efectúa el análisis de sensibilidad ante variaciones en las dotaciones de insumos y genera las salidas cuantitativas y gráficas.
  - [salidas/](replicacion/salidas/): Figuras generadas en alta resolución ([fig_kantorovich_programacion_lineal.png](replicacion/salidas/fig_kantorovich_programacion_lineal.png), [fig_koopmans_analisis_actividades.png](replicacion/salidas/fig_koopmans_analisis_actividades.png)) y tabla de escenarios de optimización ([tab_resultados_optimizacion_1975.csv](replicacion/salidas/tab_resultados_optimizacion_1975.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: poliedro factible, holgura complementaria y precios sombra; intermedio: análisis de actividades de Koopmans y costos reducidos de nuevas tecnologías; reto: no convexidades, costos fijos, programación lineal entera mixta MIP y la brecha de dualidad).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, rúbrica de evaluación detallada, demostraciones analíticas completas paso a paso y solucionario en R para el equipo docente.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha canónica en Markdown con metadatos YAML estructurados para la web estática de la colección Nobel, incluyendo contexto de época, comparación Antes/Después y cuatro aplicaciones industriales y regulatorias contemporáneas (PJM/LMP en redes eléctricas, Amazon/Maersk en logística global, FAA/Eurocontrol en slots de aeropuertos, y el mercado de derechos de emisión EU ETS).

---

## Resumen Ejecutivo de las Contribuciones

El Premio Nobel de Economía de 1975 marcó un hito histórico al reconocer simultáneamente a investigadores a ambos lados del Telón de Acero, evidenciando que las leyes matemáticas de la eficiencia económica trascienden los sistemas ideológicos:

1. **Leonid V. Kantorovich (1912–1986) y la Invención de la Programación Lineal (1939):**
   - Formado como un brillante matemático en Leningrado, Kantorovich resolvió en 1939 el problema práctico de asignación óptima de máquinas de corte en una fábrica de contrachapado, formulando por primera vez la **Programación Lineal**.
   - Descubrió de forma independiente el problema dual y desarrolló el método de los **multiplicadores resolutivos** (*resolving multipliers*), anticipando en ocho años los trabajos de George Dantzig y John von Neumann.
   - En su monografía *The Best Use of Economic Resources* (1959), aplicó estas ideas al conjunto de la economía nacional soviética, demostrando que la planificación socialista no podía funcionar eficientemente mediante balances materiales físicos y precios contables marxistas que ignoraban el costo de oportunidad del capital y la tierra. Demostró que los multiplicadores duales actúan como **precios sombra objetivos** que miden la verdadera escasez marginal de los recursos.

2. **Tjalling C. Koopmans (1910–1985) y el Análisis de Actividades de Producción (1951):**
   - Durante la Segunda Guerra Mundial, Koopmans optimizó la navegación de convoyes mercantes aliados en el Atlántico Norte, formulando matemáticamente el problema de transporte.
   - Al liderar la célebre *Cowles Commission* en Chicago y Yale, Koopmans publicó la obra fundamental *Activity Analysis of Production and Allocation* (1951), reformulando la teoría de la producción en términos de conos convexos poliédricos generados por actividades discretas.
   - Formalizó el concepto de **eficiencia de producción de Pareto-Koopmans** (un vector de producción es eficiente si no es posible aumentar la producción de un bien sin reducir la de otro ni consumir más insumos) y demostró que cualquier asignación técnica eficiente está soportada por un vector de **precios contables internos** (*accounting prices*) que cumple la condición de beneficio económico nulo para las actividades activas.

3. **La Teoría del Crecimiento Óptimo Intertemporal (Koopmans 1965):**
   - Koopmans extendió el principio de asignación óptima al horizonte dinámico intertemporal en su célebre ensayo *On the Concept of Optimal Economic Growth* (1965).
   - Analizó rigurosamente la existencia de senderos de ahorro óptimo en el modelo neoclásico continuo de Ramsey-Cass-Koopmans, demostrando la necesidad de incorporar una tasa de descuento puro sobre la utilidad intertemporal para garantizar la convergencia matemática del bienestar social agregado.

4. **El Teorema de Dualidad Fuerte y Holguras Complementarias:**
   - La síntesis teórica de Kantorovich y Koopmans demostró que a cada problema de optimización en el espacio de cantidades físicas (el Primal) le corresponde un problema espejo en el espacio de valoraciones monetarias (el Dual).
   - La condición de **holgura complementaria** prueba que cualquier recurso no plenamente saturado en el óptimo tiene un precio sombra estrictamente cero ($\lambda_i^* = 0$), mientras que los recursos con precios sombra positivos constituyen cuellos de botella estrictos que determinan el valor marginal del crecimiento.

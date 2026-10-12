# Nobel de Economía 1999: Robert A. Mundell

> **Motivación oficial:** *"for his analysis of monetary and fiscal policy under different exchange rate regimes and his analysis of optimum currency areas"* (Por su análisis de la política monetaria y fiscal bajo diferentes regímenes cambiarios y su análisis de las áreas monetarias óptimas).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 13 de octubre de 1999.  
> **Afiliación institucional al momento del premio:** Columbia University, Nueva York, EE. UU.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las publicaciones seminales de Mundell (1960, 1961, 1962, 1963), el artículo paralelo de Fleming (1962), el tratado canónico (1968) y los documentos científicos oficiales de la Real Academia Sueca de Ciencias (1999).
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, DOIs, enlaces web y licencias documentales.
  - [pdf/](referencias/pdf/): Directorio preparado para almacenamiento local de referencias de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con la formulación matemática exhaustiva del modelo Mundell-Fleming (IS-LM-BP), la deducción del Trilema Macroeconómico y la teoría de las Áreas Monetarias Óptimas (OCA).
  - [R/mundell_fleming_y_trilema.R](replicacion/R/mundell_fleming_y_trilema.R): Script autónomo y reproducible en R que simula los 4 cuadrantes de política macroeconómica en economía abierta y traza la geometría analítica de la Trinidad Imposible.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([`fig_mundell_fleming_politicas.png`](replicacion/salidas/fig_mundell_fleming_politicas.png), [`fig_mundell_trilema_monetario.png`](replicacion/salidas/fig_mundell_trilema_monetario.png)) y tabla cuantitativa de estática comparativa ([`tab_resultados_mundell.csv`](replicacion/salidas/tab_resultados_mundell.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de ejercicios prácticos graduados (básico: estática comparativa IS-LM-BP; intermedio: paridad de intereses y trilema macroeconómico; avanzado/reto: shock asimétrico en un área monetaria óptima y mecanismos de ajuste).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Guía docente confidencial con deducciones algebraicas completas, cálculos cuantitativos exactos, criterios pedagógicos de evaluación y preguntas de examen.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha canónica en Markdown con YAML front-matter estructurado para el sitio web del proyecto.

---

## Resumen Ejecutivo del Aporte

Robert A. Mundell transformó de raíz la macroeconomía moderna al integrar de forma sistemática el comercio internacional y los flujos financieros transfronterizos en el análisis de estabilización económica:

1. **El Modelo Mundell-Fleming (1960, 1962, 1963):**
   Antes de Mundell, la teoría macroeconómica predominante (la síntesis neoclásica IS-LM de Hicks y Hansen) asumía una economía cerrada o con comercio exterior aislado de los mercados de capitales. Mundell incorporó los flujos de capital internacionales en respuesta a los diferenciales de tasas de interés y contrastó de manera sistemática la efectividad de las políticas fiscal y monetaria bajo tipos de cambio fijos versus flexibles:
   - **Bajo tipo de cambio fijo y perfecta movilidad de capitales:** La política fiscal alcanza su máxima eficacia expansiva porque las presiones al alza de la tasa de interés atraen capitales extranjeros, forzando al banco central a expandir la oferta monetaria para sostener la paridad cambiaria (eliminando el efecto desplazamiento o *crowding-out*). Por el contrario, la política monetaria es completamente inútil: cualquier intento de expansión abarata el dinero, induce fuga masiva de capitales y obliga al banco central a agotar sus reservas de divisas para defender la paridad fija, retornando la oferta monetaria a su nivel inicial.
   - **Bajo tipo de cambio flexible y perfecta movilidad de capitales:** Los roles se invierten de forma tajante. La política fiscal se vuelve totalmente ineficaz: el aumento de gasto público atrae capitales que aprecian la moneda nacional, destruyendo las exportaciones netas y neutralizando el impulso original (*crowding-out* externo total). En cambio, la política monetaria se vuelve poderosísima: la expansión monetaria reduce transitoriamente las tasas de interés, empuja la salida de capitales y deprecia la moneda nacional, disparando las exportaciones netas y el producto aggregate.

2. **La Trinidad Imposible o Trilema Macroeconómico:**
   A partir de estas dinámicas, Mundell formuló el principio rector de las finanzas internacionales contemporáneas: una economía no puede disfrutar simultáneamente de: (1) tipo de cambio fijo, (2) libre movilidad de capitales y (3) autonomía de la política monetaria. Forzosamente debe sacrificar uno de los tres vértices.

3. **La Teoría de las Áreas Monetarias Óptimas (OCA, 1961):**
   Mundell formuló la pregunta pionera: ¿cuál es el dominio geográfico idóneo para una moneda única? Demostró que compartir una moneda elimina los costos de transacción cambiarios y el riesgo de tipo de cambio, pero priva a las regiones de la devaluación como válvula de escape ante shocks asimétricos. Estableció que una unión monetaria solo es viable y beneficiosa si existe una elevada movilidad de mano de obra y capital entre sus miembros, flexibilidad de salarios reales o un sistema federal de transferencias fiscales compensatorias. Este marco constituyó el fundamento analítico e intelectual para la creación del **Euro** y la Unión Económica y Monetaria europea.

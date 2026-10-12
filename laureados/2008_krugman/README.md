# Nobel de Economía 2008: Paul Krugman

> **Motivación oficial:** *"for his analysis of trade patterns and location of economic activity"* (Por su análisis de los patrones de comercio y la localización de la actividad económica).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 13 de octubre de 2008.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Krugman (1979, 1980, 1991), los tratados con Helpman (1985) y Fujita-Venables (1999), y los documentos científicos oficiales de la Real Academia Sueca de Ciencias (2008).
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, DOIs, URLs y licencias de acceso.
  - [pdf/](referencias/pdf/): Directorio preparado para almacenamiento local de referencias documentales de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con la formulación matemática completa de la Nueva Teoría del Comercio y del modelo Núcleo-Periferia.
  - [R/modelo_comercio_geografia_krugman.R](replicacion/R/modelo_comercio_geografia_krugman.R): Script autónomo en R que ejecuta la simulación numérica de las variedades Dixit-Stiglitz y el algoritmo de punto fijo de salarios de equilibrio espacial.
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_comercio_intraindustrial.png`, `fig_bifurcacion_nucleo_periferia.png`) y tabla de resultados (`tab_krugman_simulacion.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: medición empírica del comercio intraindustrial con el índice de Grubel-Lloyd; intermedio: función de utilidad Dixit-Stiglitz y ganancias puras de variedad; avanzado/reto: fuerzas centrípetas vs. centrífugas y aglomeración en megaciudades y clusters).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes confidenciales con deducciones analíticas paso a paso, cálculos cuantitativos exactos y criterios pedagógicos de evaluación.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con front-matter YAML para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

Paul Krugman unificó y revolucionó dos de los campos más trascendentes de la ciencia económica contemporánea:

1. **La Nueva Teoría del Comercio (*New Trade Theory*, 1979, 1980):**
   Antes de Krugman, la teoría dominante del comercio (David Ricardo y Heckscher-Ohlin) explicaba el comercio exclusivamente a partir de ventajas comparativas y diferencias entre países (recursos naturales, climas, tecnología o dotaciones de factores). Sin embargo, este marco no podía dar cuenta de por qué la mayor parte del comercio de la posguerra ocurría entre países industrializados muy similares intercambiando bienes casi sustitutos (comercio intraindustrial). Krugman incorporó la competencia monopolística de Dixit-Stiglitz y los rendimientos crecientes a escala internos a las empresas, demostrando que el comercio internacional expande la escala de producción agregada y multiplica el número de variedades accesibles a los consumidores, generando sustanciales ganancias de bienestar mutuas sin requerir diferencias tecnológicas ni dotacionales previas.

2. **La Nueva Geografía Económica (*New Economic Geography*, 1991):**
   Krugman integró la dimensión espacial al análisis económico riguroso, respondiendo a la pregunta de por qué las industrias y las poblaciones se concentran intensamente en ciertas regiones metropolitanas o clusters (como Silicon Valley o las megalópolis industriales). En su modelo Núcleo-Periferia, formalizó la tensión entre fuerzas centrípetas (encadenamientos hacia atrás y hacia adelante, y el efecto mercado local) y fuerzas centrífugas (demanda agrícola dispersa). Demostró que una reducción progresiva en los costos de transporte no dispersa la manufactura, sino que precipita una bifurcación catastrófica que desestabiliza la simetría y provoca la aglomeración acumulativa en un polo núcleo, relegando a otras regiones a la periferia económica.

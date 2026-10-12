# Nobel de Economía 2019: Abhijit Banerjee, Esther Duflo y Michael Kremer

> **Motivación oficial:** *"for their experimental approach to alleviating global poverty"* (Por su enfoque experimental para aliviar la pobreza global).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 14 de octubre de 2019.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Banerjee, Duflo y Kremer (*Econometrica* 2004, *AEJ: Applied Economics* 2015, *AER* 2011, *Science* 2015, libro *Poor Economics* 2011) y los informes oficiales de la Real Academia Sueca de Ciencias.
  - [manifest.csv](referencias/manifest.csv): Registro de metadatos, DOIs, URLs y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Artículos y documentos de acceso abierto (`nobel2019scientific.pdf`, `nobel2019popular.pdf`, `miguel2004replication_guide.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación con derivación econométrica del ensayo controlado aleatorizado por conglomerados (*Cluster RCT*), corrección de errores estándar por conglomerados (Moulton), estimación de externalidades espaciales (violación de SUTVA) y LATE/TOT.
  - [R/evaluacion_rct_desparasitacion.R](replicacion/R/evaluacion_rct_desparasitacion.R): Script autónomo en R que genera y analiza la base de microdatos escolares, ejecuta los modelos econométricos y produce las tablas y gráficos.
  - [datos/](replicacion/datos/): Microdatos escolares simulados según los parámetros empíricos exactos del *Primary School Deworming Project* (`desparasitacion_kenia.csv`).
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_impacto_rct_asistencia.png](replicacion/salidas/fig_impacto_rct_asistencia.png), [fig_externalidades_espaciales.png](replicacion/salidas/fig_externalidades_espaciales.png)) y tabla de estimaciones consolidadas ([tab_resultados_rct.csv](replicacion/salidas/tab_resultados_rct.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo práctico con 3 ejercicios formativos (básico: diferencia de medias e ITT vs. TOT; intermedio: aleatorización por conglomerados y sesgo de Moulton; avanzado: externalidades espaciales y supuesto SUTVA).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes confidenciales con desarrollos matemáticos, justificación econométrica formal y respuestas a los ejercicios.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con YAML front-matter para el portal web del proyecto.

---

## Resumen Ejecutivo del Aporte

Abhijit Banerjee, Esther Duflo y Michael Kremer transformaron la economía del desarrollo al reemplazar las grandes teorías macroeconómicas y los debates ideológicos abstractos por una metodología empírica basada en **ensayos controlados aleatorizados en campo** (*Randomized Controlled Trials*, RCTs):

1. **Descomposición del Problema de la Pobreza:** En lugar de preguntarse de forma monolítica *"¿Cómo erradicar la pobreza mundial?"*, el enfoque experimental divide la pobreza en preguntas operativas concretas y evaluables: ¿los libros de texto aumentan el aprendizaje de los alumnos vulnerables? ¿los incentivos en lentejas aumentan las tasas de vacunación infantil? ¿las pastillas antiparasitarias gratuitas incrementan la asistencia a la escuela?
2. **Rigor Metodológico y Causalidad Experimental:** Introdujeron en las ciencias sociales el estándar de la medicina basada en evidencia: la asignación aleatoria a nivel individual, de aula o de aldea asegura que los grupos de tratamiento y control sean idénticos en características observables y no observables, aislando con precisión el efecto causal de la intervención.
3. **Mecanismos de Comportamiento y Economía Conductual:** Demostraron empíricamente que los pobres no son ni irracionales ni agentes hiper-calculadores homogéneos; enfrentan pequeñas fricciones cotidianas (*nudges*, sesgo de presente, restricciones de liquidez y escasez de información) que impiden adoptar tecnologías de alto retorno (como fertilizantes, cloro para agua o vacunas).
4. **Impacto Institucional y Escalamiento Global:** A través del laboratorio Abdul Latif Jameel Poverty Action Lab (**J-PAL**), cofundado por Banerjee y Duflo en el MIT en 2003, y la red de investigación liderada por Kremer, sus hallazgos han servido de base directa para políticas públicas que benefician a más de 500 millones de personas en África, Asia y América Latina (programas de desparasitación infantil, tutorías personalizadas *Teaching at the Right Level* y transferencias productivas de graduación).

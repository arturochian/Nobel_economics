# Nobel de Economía 2016: Oliver Hart y Bengt Holmström

> **Motivación oficial:** *"for their contributions to contract theory"* (Por sus contribuciones a la teoría de los contratos).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 10 de octubre de 2016.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las 8 publicaciones seminales de Holmström (1979, 1991), Grossman y Hart (1986), Hart y Moore (1990), Hart (1995), Hart, Shleifer y Vishny (1997) y los documentos del comité Nobel (2016).
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias.
  - [pdf/](referencias/pdf/): Documentos oficiales de libre acceso descargados (`nobel2016scientific.pdf`, `nobel2016popular.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con derivación analítica completa del modelo LEN de riesgo-incentivos, el teorema de informatividad, el dilema multitarea y la frontera de derechos de propiedad.
  - [R/modelo_teoria_contratos.R](replicacion/R/modelo_teoria_contratos.R): Script autónomo en R que resuelve y simula los modelos contractuales y genera las visualizaciones y tablas.
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_holmstrom_riesgo_incentivos.png`, `fig_multitarea_distorsion.png`) y tabla de resultados (`tab_resultados_contratos.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: evaluación de desempeño relativo y RPE en directivos; intermedio: multitarea y distorsión de incentivos en educación y sanidad; avanzado/reto: privatización de prisiones y derechos residuales de control).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes confidenciales con deducciones matemáticas detalladas y respuestas analíticas completas.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

Oliver Hart y Bengt Holmström crearon las herramientas analíticas para entender la arquitectura de los contratos y las organizaciones en presencia de incertidumbre y fricciones de información:

1. **El Principio de Informatividad y el Modelo LEN (Holmström 1979):**
   Holmström formalizó el trade-off fundamental entre la provisión de incentivos y el aseguramiento del riesgo. Demostró que el pago por desempeño debe incorporar cualquier variable que reduzca el ruido sobre el esfuerzo del agente y purgar los choques de mercado ajenos a su control mediante la evaluación de desempeño relativo (RPE).

2. **Incentivos Multitarea (Holmström y Milgrom 1991):**
   Explicaron por qué los incentivos agresivos sobre métricas medibles provocan el descuido y canibalización de dimensiones cualitativas esenciales pero inobservables (como la calidad, la seguridad o la atención humana). Este principio fundamenta la prevalencia de salarios fijos en profesiones como la docencia, la policía y la sanidad.

3. **Contratos Incompletos y Derechos de Propiedad (Grossman y Hart 1986; Hart y Moore 1990):**
   Hart formuló la teoría moderna de la empresa al reconocer que los contratos reales nunca pueden prever todas las contingencias futuras. Ante la imprevisibilidad, la propiedad del activo físico confiere los **derechos residuales de control**, determinando el poder de negociación ex-post y los incentivos a invertir ex-ante. Este marco resolvió el debate sobre la integración vertical y definió los límites entre la provisión pública y privada de servicios esenciales.

# Nobel de Economía 2010: Peter A. Diamond, Dale T. Mortensen y Christopher A. Pissarides

> **Motivación oficial:** *"for their analysis of markets with search frictions"* (Por su análisis de los mercados con fricciones de búsqueda).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 11 de octubre de 2010.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las 8 publicaciones seminales de Diamond (1971), Mortensen (1982), Pissarides (1985, 2000), Mortensen y Pissarides (1994), Hosios (1990) y los documentos oficiales del comité Nobel (2010).
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias.
  - [pdf/](referencias/pdf/): Documentos oficiales de libre acceso descargados (`nobel2010scientific.pdf`, `nobel2010popular.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con fundamentación matemática completa del modelo DMP, condición de libre entrada de vacantes, curva de Beveridge y condición de eficiencia de Hosios.
  - [R/modelo_dmp_laboral.R](replicacion/R/modelo_dmp_laboral.R): Script autónomo en R que resuelve numéricamente y calibra el modelo estacionario y dinámico, simulando fluctuaciones cíclicas y choques estructurales de matching.
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_curva_beveridge_dmp.png`, `fig_equilibrio_dmp_tension.png`) y tabla cuantitativa de resultados (`tab_resultados_dmp.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: derivación de la curva de Beveridge y flujos de empleo; intermedio: externalidades de búsqueda y la regla de Hosios; avanzado/reto: reformas al seguro de desempleo y tensión laboral).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes confidenciales con deducciones matemáticas detalladas y respuestas analíticas completas.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

Peter Diamond, Dale Mortensen y Christopher Pissarides construyeron el marco analítico moderno para comprender cómo funcionan los mercados en presencia de fricciones de búsqueda y emparejamiento (*search and matching frictions*):

1. **La Paradoja de Diamond y los Fundamentos Microeconómicos (Diamond 1971):**
   Diamond demostró que incluso fricciones de búsqueda infinitesimales pueden destruir por completo los equilibrios competitivos walrasianos, otorgando a las empresas poder de mercado monopólico. Esto abrió un nuevo campo de estudio: cómo los costos de encontrar un socio comercial o un empleo generan rentas bilaterales ex-post que deben ser resueltas mediante procesos de negociación.

2. **La Dinámica de Creación y Destrucción de Empleo (Mortensen y Pissarides 1994):**
   Mortensen y Pissarides formalizaron cómo las empresas deciden abrir o cerrar puestos en respuesta a choques de productividad agregada y sectorial. Su modelo capturó la coexistencia simultánea de despidos y nuevas contrataciones a lo largo de todo el ciclo económico.

3. **El Modelo Canónico de Equilibrio y la Curva de Beveridge (Pissarides 1985, 2000):**
   Pissarides integró la función de emparejamiento macroeconómica con la condición de libre entrada de vacantes y la negociación salarial de Nash. Este esquema proporcionó la base teórica definitiva para la **Curva de Beveridge** (la relación inversa entre vacantes y desempleo) y estableció el estándar universal para evaluar las políticas de seguro de desempleo, salarios mínimos y programas activos de mercado de trabajo.

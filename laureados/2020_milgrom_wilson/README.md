# Nobel de Economía 2020: Paul R. Milgrom y Robert B. Wilson

> **Motivación oficial:** *"for improvements to auction theory and inventions of new auction formats"* (Por sus mejoras a la teoría de subastas y la invención de nuevos formatos de subasta).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 12 de octubre de 2020.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Wilson (1969, 1977), Milgrom y Weber (1982), Milgrom (2000, 2004) y los documentos oficiales del comité Nobel (2020).
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Documentos oficiales de libre acceso descargados (`nobel2020scientific.pdf`, `nobel2020popular.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con derivación formal del sesgo de sobrepuja, equilibrio bayesiano de Wilson y dinámica del algoritmo SMRA.
  - [R/simulacion_subastas.R](replicacion/R/simulacion_subastas.R): Script autónomo en R que ejecuta la simulación de Monte Carlo de la maldición del ganador y la subasta ascendente simultánea.
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_maldicion_ganador.png`, `fig_subasta_ascendente_smra.png`) y tabla de resultados (`tab_resultados_subasta.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: cálculo del sesgo condicional y maldición del ganador; intermedio: complementariedad y problema de exposición; avanzado/reto: diseño contra colusión táctica en subastas de espectro).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes confidenciales con deducciones matemáticas detalladas y respuestas analíticas.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

Paul R. Milgrom y Robert B. Wilson transformaron la teoría de subastas y fundaron la ingeniería económica moderna al vincular la teoría matemática de juegos con el diseño práctico de mercados:

1. **La Teoría del Valor Común y la Maldición del Ganador (Wilson 1977):**
   Wilson identificó que cuando un bien tiene el mismo valor subyacente para todos los postores pero estos solo disponen de estimaciones imperfectas, el ganador tiende a ser quien sobrestimó más el valor real. Desarrolló el primer marco de equilibrio bayesiano demostrando cómo los postores racionales deben sombrear sus ofertas para protegerse de este sesgo adverso de selección.

2. **Señales Afiliadas y el Principio de Vinculación (Milgrom y Weber 1982):**
   Milgrom y Weber demostraron que en entornos con información interdependiente, los formatos de subasta que hacen más transparente la información (como la subasta inglesa ascendente) mitigan el temor a sobrepujar y generan mayores ingresos promedio para el vendedor que las subastas tradicionales a sobre cerrado.

3. **La Subasta Ascendente Simultánea de Múltiples Rondas (SMRA, 1994):**
   Para la asignación del espectro radioeléctrico en la FCC, Milgrom y Wilson (con Preston McAfee) concibieron un diseño de mercado completamente nuevo. Al subastar todas las licencias de manera concurrente en rondas discretas con cierre unificado y reglas de actividad estrictas, resolvieron el *problema de exposición* que impedía a las empresas ensamblar paquetes geográficos complementarios. Este formato se convirtió en el estándar mundial para telecomunicaciones, electricidad, cuotas pesqueras y derechos de emisión de carbono.

# Nobel de Economía 2012: Alvin E. Roth y Lloyd S. Shapley

> **Motivación oficial:** *"for the theory of stable allocations and the practice of market design"* (Por la teoría de las asignaciones estables y la práctica del diseño de mercados).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 15 de octubre de 2012.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Gale y Shapley (1962), Shapley (1953), Shapley y Scarf (1974), Roth (1984, 2002), Roth, Sönmez y Ünver (2004) y el informe científico del comité Nobel (2012).
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Documentos oficiales de libre acceso descargados (`nobel2012scientific.pdf`, `nobel2012popular.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con derivación formal del algoritmo de aceptación diferida, pares bloqueadores, asimetría proponente-receptor y algoritmo Top Trading Cycles (TTC) para trasplante renal.
  - [R/algoritmo_matching_gale_shapley.R](replicacion/R/algoritmo_matching_gale_shapley.R): Script autónomo en R que ejecuta la simulación de Monte Carlo de emparejamientos bilaterales y la optimización de ciclos de donación cruzada de riñones.
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución ([fig_convergencia_matching.png](replicacion/salidas/fig_convergencia_matching.png), [fig_donacion_rinon_cadenas.png](replicacion/salidas/fig_donacion_rinon_cadenas.png)) y tabla consolidada de resultados ([tab_matching_resultados.csv](replicacion/salidas/tab_matching_resultados.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: ejecución manual paso a paso de Gale-Shapley y detección de pares bloqueadores; intermedio: asimetría proponente-receptor y veracidad estratégica; avanzado/reto: algoritmo Top Trading Cycles y cadenas de donación renal altruista).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes confidenciales con deducciones matemáticas detalladas, resoluciones paso a paso y análisis pedagógico.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

Lloyd S. Shapley y Alvin E. Roth fundaron la teoría moderna del diseño de mercados al demostrar que la asignación eficiente de recursos en entornos donde los precios monetarios están ausentes depende de la alineación de incentivos y de la **estabilidad** de las asignaciones:

1. **La Teoría Fundamental de las Asignaciones Estables (Gale y Shapley 1962, Shapley y Scarf 1974):**
   David Gale y Lloyd Shapley concibieron el **algoritmo de aceptación diferida** (*Deferred Acceptance* - DA) para resolver el problema del matrimonio estable y las admisiones universitarias. Demostraron que siempre existe al menos una asignación estable, libre de pares bloqueadores (agentes que prefieran abandonar sus asignaciones para emparejarse entre sí). Asimismo, probaron que el mecanismo favorece óptimamente al lado que realiza las propuestas. Posteriormente, Shapley y Herbert Scarf idearon el algoritmo **Top Trading Cycles** (TTC) para el intercambio de bienes indivisibles sin dinero.

2. **La Práctica e Ingeniería de Diseño de Mercados (Roth 1984, 2002, 2004):**
   Alvin Roth reconoció que el mercado de médicos residentes en Estados Unidos (NRMP) había adoptado espontáneamente en 1952 una versión equivalente a Gale-Shapley para sobrevivir al colapso histórico generado por ofertas prematuras (*unraveling*). Roth probó que la estabilidad matemática es la condición necesaria y suficiente para la viabilidad de mercados de emparejamiento descentralizados. Roth asumió el papel de "economista como ingeniero", rediseñando el sistema de residencias médicas en 1998, implementando los sistemas centralizados de asignación escolar en Nueva York y Boston, y creando los primeros registros de donación cruzada de riñones basados en TTC.

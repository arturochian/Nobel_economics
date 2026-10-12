# Nobel de Economía 2007: Leonid Hurwicz, Eric S. Maskin y Roger B. Myerson

> **Motivación oficial:** *"for having laid the foundations of mechanism design theory"* (Por haber sentado las bases de la teoría del diseño de mecanismos).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 15 de octubre de 2007.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las 8 publicaciones seminales de Hurwicz (1972, 1973), Myerson (1979, 1981, 1983), Maskin (1999) y los documentos oficiales del comité Nobel (2007).
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias.
  - [pdf/](referencias/pdf/): Documentos oficiales descargados de libre acceso (`nobel2007scientific.pdf`, `nobel2007popular.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con deducciones teóricas completas del Principio de Revelación, la regla pivote del mecanismo VCG, la implementación de Nash de Maskin y el Teorema de Equivalencia del Ingreso de Myerson.
  - [R/mecanismos_vcg_y_myerson.R](replicacion/R/mecanismos_vcg_y_myerson.R): Script autónomo en R que simula la compatibilidad de incentivos en VCG y ejecuta una simulación Monte Carlo de 100,000 subastas comparando cuatro formatos estándar.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_vcg_revelacion_veraz.png](replicacion/salidas/fig_vcg_revelacion_veraz.png), [fig_myerson_equivalencia_ingreso.png](replicacion/salidas/fig_myerson_equivalencia_ingreso.png)) y tabla consolidada ([tab_resultados_mecanismos.csv](replicacion/salidas/tab_resultados_mecanismos.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: cálculo de pagos VCG e impuestos de Clarke en un bien público; intermedio: deducción analítica de pujas en subastas de primer precio y equivalencia del ingreso de Myerson; avanzado/reto: el Teorema de Imposibilidad de Myerson-Satterthwaite en comercio bilateral).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes confidenciales con deducciones matemáticas detalladas y respuestas numéricas completas.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con front-matter YAML para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

Leonid Hurwicz, Eric Maskin y Roger Myerson transformaron la ciencia económica al crear la **teoría del diseño de mecanismos**, la disciplina que permite diseñar instituciones y reglas de juego óptimas cuando la información está dispersa y los agentes actúan estratégicamente:

1. **Leonid Hurwicz (1972, 1973) — El Principio de Compatibilidad de Incentivos:**
   Hurwicz demostró que la asignación eficiente de recursos en una sociedad no es un mero problema de cómputo algorítmico, sino de incentivos para revelar información secreta. Descubrió que ningún mecanismo no dictatorial puede lograr la eficiencia de Pareto en economías privadas a menos que las reglas hagan que decir la verdad sea compatible con el propio interés de cada participante (*incentive compatibility*).

2. **Eric S. Maskin (1977, 1999) — La Teoría de la Implementación:**
   Maskin formalizó las condiciones matemáticas bajo las cuales una función de bienestar social puede implementarse en **Equilibrio de Nash**. Introdujo el concepto crucial de la **Monotonicidad de Maskin**, demostrando que si un resultado deseado preserva su posición relativa en las preferencias de los agentes ante un cambio de estado, puede garantizarse mediante un mecanismo donde todos los equilibrios del juego conduzcan exactamente al resultado deseado por el diseñador.

3. **Roger B. Myerson (1979, 1981, 1983) — El Principio de Revelación y la Arquitectura de Subastas:**
   Myerson formuló el **Principio de Revelación** universal, que demostró que cualquier objetivo factible mediante mecanismos indirectos complejos puede lograrse mediante un mecanismo directo donde decir la verdad es óptimo. Con esta herramienta, Myerson formuló el **Teorema de Equivalencia del Ingreso** (probando que subastas aparentemente distintas como primer precio, segundo precio o inglesa recaudan exactamente lo mismo en esperanza) y diseñó la subasta óptima que maximiza los ingresos del vendedor mediante precios de reserva virtuales. Asimismo, con Mark Satterthwaite demostró el límite infranqueable del libre mercado: la imposibilidad de lograr comercio bilateral eficiente sin subsidio externo.

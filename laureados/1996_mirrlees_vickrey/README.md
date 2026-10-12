# Nobel de Economía 1996: James A. Mirrlees y William Vickrey

> **Motivación oficial:** *"for their fundamental contributions to the economic theory of incentives under asymmetric information"* (Por sus contribuciones fundamentales a la teoría económica de los incentivos bajo información asimétrica).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 8 de octubre de 1996.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las publicaciones seminales de Mirrlees (1971, 1976), Diamond y Mirrlees (1971), Vickrey (1961, 1969) y los documentos oficiales del comité Nobel (1996).
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos oficiales de libre acceso de la Fundación Nobel.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación reproducible con deducciones matemáticas rigurosas, formulación de modelos, simulación computacional y ejercicios aplicados.
  - [R/tributacion_optima_y_subastas.R](replicacion/R/tributacion_optima_y_subastas.R): Script autónomo en R que evalúa la estrategia dominante de Vickrey ($b_i = v_i$), ejecuta una simulación Monte Carlo de 100,000 subastas verificando el Teorema de Equivalencia del Ingreso, y resuelve numéricamente el modelo de screening y tributación óptima de Mirrlees demostrando el teorema de tasa marginal cero en el tope.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_vickrey_subastas_estrategias.png](replicacion/salidas/fig_vickrey_subastas_estrategias.png), [fig_mirrlees_tributacion_optima.png](replicacion/salidas/fig_mirrlees_tributacion_optima.png)) y tabla consolidada de resultados ([tab_resultados_mirrlees_vickrey.csv](replicacion/salidas/tab_resultados_mirrlees_vickrey.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: subasta de segundo precio de Vickrey vs. primer precio y estrategia dominante; intermedio: modelo de screening de Mirrlees en dos tipos y tasa cero en el tope; avanzado/reto: modelo de cuello de botella de Vickrey y tarificación por congestión en tiempo real).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes confidenciales con deducciones algebraicas completas, cálculos numéricos y notas pedagógicas de evaluación.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha técnica y divulgativa en Markdown con YAML front-matter estructurado para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

James A. Mirrlees y William Vickrey establecieron los cimientos de la moderna microeconomía de la información y la teoría de contratos, transformando el diseño de las políticas públicas y las instituciones de mercado:

1. **James A. Mirrlees (1971) — Tributación Óptima sobre el Ingreso y Screening:**
   Mirrlees formuló matemáticamente el dilema entre equidad y eficiencia distributiva cuando el Estado no puede observar la habilidad innata de los trabajadores. Modeló el sistema tributario como un menú de incentivos compatibles donde el gobierno induce a los agentes a revelar su productividad mediante sus decisiones de ingreso bruto. Descubrió el célebre **Teorema de la Tasa Marginal Cero en el Tope** (*zero top marginal rate*), demostrando que distorsionar el esfuerzo marginal del trabajador más productivo no reporta beneficios distributivos hacia abajo, mientras que las tasas marginales en los niveles inferiores deben ser positivas para disuadir a los individuos altamente capacitados de imitar a los menos productivos.

2. **William Vickrey (1961) — Subasta de Segundo Precio y Equivalencia del Ingreso:**
   Tres décadas antes de la explosión de internet y la teoría de juegos aplicada, Vickrey inventó la **Subasta de Segundo Precio** (Subasta de Vickrey). Demostró formalmente que obligar al postor ganador a pagar el segundo precio más alto hace que reportar la verdadera valoración privada ($b_i = v_i$) sea una estrategia débilmente dominante, eliminando el desperdicio cognitivo de especular sobre los rivales. Formuló además el **Teorema de Equivalencia del Ingreso**, probando que los cuatro formatos clásicos de subastas recaudan en esperanza exactamente el mismo valor cuando los postores son neutrales al riesgo. Este principio fue la base sobre la que Clarke (1971) y Groves (1973) construyeron el mecanismo VCG.

3. **William Vickrey (1963, 1969) — Tarificación de Congestión en Tiempo Real:**
   Vickrey demostró que el tráfico urbano no debe ser gestionado mediante la construcción indiscriminada de calzadas (que genera demanda inducida), sino mediante precios que reflejen el costo marginal externo de la congestión. Su **modelo de cuello de botella vial** (*bottleneck model*) demostró que un peaje variable en tiempo real elimina al 100% las colas viales sin alterar el costo privado del viaje, convirtiendo el tiempo perdido en recaudación fiscal productiva para el transporte público.

4. **Peter Diamond y James Mirrlees (1971) — Teorema de Eficiencia Productiva:**
   Demostraron que, en presencia de impuestos óptimos al consumo (aunque sean distorsivos), el sistema fiscal nunca debe distorsionar la eficiencia en la producción agregada de bienes intermedios. El sector público y las empresas privadas deben operar sobre la frontera de posibilidades de producción de Pareto.

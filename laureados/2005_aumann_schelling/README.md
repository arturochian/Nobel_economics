# Nobel de Economía 2005: Robert J. Aumann y Thomas C. Schelling

> **Motivación oficial:** *"for having enhanced our understanding of conflict and cooperation through game-theory analysis"* (Por haber mejorado nuestra comprensión del conflicto y la cooperación a través del análisis de la teoría de juegos).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 10 de octubre de 2005.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las 10 publicaciones fundamentales de Aumann (1959, 1974, 1976, 1981), Schelling (1960, 1969, 1971, 1978) y los informes oficiales de la Real Academia Sueca de Ciencias (2005).
  - [manifest.csv](referencias/manifest.csv): Control de inventario de fuentes, DOIs verificados, URLs y licencias.
  - [pdf/](referencias/pdf/): Documentos oficiales descargados de libre acceso (`nobel2005scientific.pdf`, `nobel2005popular.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación reproducible con derivaciones matemáticas rigurosas del Teorema Popular de Aumann, equilibrios correlacionados, teoremas de conocimiento común y dinámica espacial de Schelling.
  - [R/juegos_conflicto_y_segregacion.R](replicacion/R/juegos_conflicto_y_segregacion.R): Script modular y autónomo en R que simula la reubicación en cuadrículas toroidales de Schelling y evalúa el dilema del prisionero repetido bajo la sombra del futuro y errores de implementación.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_schelling_segregacion_espacial.png](replicacion/salidas/fig_schelling_segregacion_espacial.png), [fig_aumann_folk_theorem_cooperacion.png](replicacion/salidas/fig_aumann_folk_theorem_cooperacion.png)) y tabla consolidada ([tab_resultados_aumann_schelling.csv](replicacion/salidas/tab_resultados_aumann_schelling.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía práctica con tres problemas graduados (nivel básico: cálculo de factores de descuento críticos en juegos repetidos; intermedio: diseño de equilibrios correlacionados y valor de la mediación; avanzado/reto: simulación de micromotivos y bifurcaciones de Schelling).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Guía docente completa con deducciones matemáticas paso a paso, demostraciones formales y códigos de apoyo.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en formato Markdown estructurada con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

Robert J. Aumann y Thomas C. Schelling transformaron las ciencias sociales al introducir la perspectiva analítica de la **teoría de juegos interactiva**, demostrando cómo la cooperación voluntaria puede florecer a partir de intereses egoístas y cómo los conflictos, las crisis y la segregación social son el resultado de dinámicas estratégicas y agregaciones imprevistas:

1. **Robert J. Aumann — Juegos Repetidos, Conocimiento Común y Racionalidad Correlacionada:**
   - **Teoría de juegos repetidos y Teorema Popular (*Folk Theorem*):** Aumann demostró rigurosamente que las interacciones prolongadas en el tiempo permiten sostener la cooperación social sin necesidad de un gobierno central coercitivo. Cuando el horizonte temporal es indefinido y los jugadores valoran suficientemente el futuro ($\delta \ge \delta^*$), la amenaza creíble de castigos ante cualquier traición transforma la cooperación mutua en un equilibrio racional.
   - **Equilibrio Correlacionado (1974):** Amplió el concepto de equilibrio de Nash demostrando que la presencia de señales aleatorias o mediadores de coordinación permite alcanzar niveles de bienestar social superiores a los equilibrios en estrategias independientes.
   - **Conocimiento Común y "Agreeing to Disagree" (1976):** Fundó la teoría de juegos epistémica al probar que dos agentes racionales con creencias a priori comunes no pueden sostener desacuerdos informados si sus probabilidades subjetivas posteriores son de conocimiento común.

2. **Thomas C. Schelling — Estrategia del Conflicto, Compromisos Creíbles y Micromotivos:**
   - **The Strategy of Conflict (1960):** Formuló los conceptos seminales de la disuasión moderna: puntos focales (*Schelling points*), compromisos creíbles irreversibles (*burning bridges*), cables trampa (*tripwires*) y la manipulación deliberada del riesgo de escalada (*brinkmanship*). Demostró que restringir voluntariamente las propias opciones puede otorgar una ventaja estratégica decisiva.
   - **Micromotivos y Macrocomportamiento (1971, 1978):** Desarrolló el modelo de segregación espacial que probó por primera vez cómo decisiones individuales autónomas y perfectamente tolerantes (por ejemplo, agentes dispuestos a ser minoría local del 35%) generan agregaciones macroscópicas no deseadas de segregación urbana extrema (>75%), inaugurando los modelos basados en agentes en economía.

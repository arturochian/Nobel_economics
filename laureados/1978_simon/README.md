# Nobel de Economía 1978: Herbert A. Simon

> **Motivación oficial:** *"for his pioneering research into the decision-making process within economic organizations"* (Por su investigación pionera sobre el proceso de toma de decisiones en el seno de las organizaciones económicas).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 16 de octubre de 1978.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las obras canónicas de Herbert A. Simon (1947–1979) y el comunicado oficial de la Academia Sueca.
  - [manifest.csv](referencias/manifest.csv): Inventario estructurado de publicaciones, identificadores DOI, enlaces verificados y estado de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para monografías y documentos oficiales en formato PDF.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte reproducible integral en Quarto con la formalización teórica, derivación matemática de la heurística satisfactora (*satisficing*), dinámica adaptativa de aspiraciones y gráficos comparativos.
  - [R/racionalidad_limitada_y_satisfaccion.R](replicacion/R/racionalidad_limitada_y_satisfaccion.R): Script autónomo y vectorizado en R que simula la búsqueda secuencial heurística frente a la optimización exhaustiva, analiza el impacto de los costos cognitivos y grafica la dinámica temporal de las aspiraciones.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_simon_satisficing_heuristica.png](replicacion/salidas/fig_simon_satisficing_heuristica.png), [fig_simon_nivel_aspiracion_dinamico.png](replicacion/salidas/fig_simon_nivel_aspiracion_dinamico.png)) y tabla de resultados numéricos de Monte Carlo ([tab_resultados_simon.csv](replicacion/salidas/tab_resultados_simon.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de ejercicios pedagógicos estructurada en tres niveles (básico sobre la probabilidad de parada y valor esperado de satisfacción; intermedio sobre aspiraciones adaptativas y costos de búsqueda; avanzado/reto en R sobre árboles de decisión heurísticos vs optimización exhaustiva).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes completas, justificaciones metodológicas, resolución matemática analítica paso a paso y código reproducible para las soluciones docentes.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada con front-matter YAML y secciones estandarizadas para el portal web.

---

## Resumen Ejecutivo del Aporte

Herbert Alexander Simon (1916–2001), pionero de la ciencia cognitiva, la inteligencia artificial, la teoría organizacional y la economía, recibió el Premio Nobel en 1978 por desmantelar el mito del *Homo economicus* omnisciente y sentar los cimientos de la **economía conductual** y la **racionalidad limitada**:

1. **Racionalidad Limitada (*Bounded Rationality*, 1947, 1955, 1957):** La microeconomía clásica y neoclásica asumía que los seres humanos poseen información perfecta, capacidad computacional infinita y preferencias estables para maximizar globalmente la utilidad o el beneficio. Simon demostró que los agentes reales enfrentan severas restricciones fisiológicas y computacionales: atención finita, memoria limitada, tiempo escaso e incertidumbre radical sobre el futuro.
2. **Conducta Satisfactora vs Optimizadora (*Satisficing* vs *Optimizing*, 1955, 1956):** Simon acuñó el término *satisficing* (amalgama de *satisfy* y *suffice*). En lugar de buscar un óptimo global inalcanzable evaluando billones de combinaciones posibles, los tomadores de decisiones definen un **nivel de aspiración** ($\alpha$) aceptable y buscan secuencialmente hasta encontrar la primera alternativa que satisface o supera dicho umbral.
3. **Niveles de Aspiración Adaptativos (March & Simon, 1958; Cyert & March, 1963):** Las metas y aspiraciones no son fijas ni dogmáticas. Si la búsqueda resulta sencilla y abundante, las aspiraciones se elevan suavemente; si el entorno es hostil y la búsqueda prolongada fracasa, el nivel de aspiración decae gradualmente para desbloquear la toma de decisiones y evitar la parálisis.
4. **Toma de Decisiones en Organizaciones (*Administrative Behavior*, 1947):** Las empresas no operan como funciones de producción abstractas que maximizan ganancias puntuales, sino como sistemas sociales complejos donde la autoridad, la división del trabajo y las rutinas organizacionales sirven precisamente para compensar las limitaciones cognitivas individuales.
5. **Fundamentos de la Inteligencia Artificial y la Ciencia Cognitiva:** Junto con Allen Newell, Simon desarrolló el *Logic Theorist* (1956) y el *General Problem Solver* (1959), demostrando que tanto la mente humana como las computadoras operan mediante sistemas de búsqueda heurística en árboles de posibilidades, resolviendo problemas mediante subobjetivos y reglas prácticas en vez de fuerza bruta matemática.

---

## Instrucciones de Reproducción

Para ejecutar la simulación en R y regenerar todas las figuras y tablas desde la raíz del repositorio:

```bash
# Ejecutar script R de replicación
Rscript laureados/1978_simon/replicacion/R/racionalidad_limitada_y_satisfaccion.R
```

Para renderizar el informe completo en Quarto:

```bash
# Renderizar documento Quarto reproducible
quarto render laureados/1978_simon/replicacion/replicar.qmd
```

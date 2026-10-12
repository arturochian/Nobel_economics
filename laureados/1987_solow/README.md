# Nobel de Economía 1987: Robert M. Solow

> **Motivación oficial:**  
> *"for his contributions to the theory of economic growth"* (Por sus contribuciones a la teoría del crecimiento económico).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 21 de octubre de 1987.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras fundamentales de Solow (*Quarterly Journal of Economics* 1956, *Review of Economics and Statistics* 1957, Conferencia Nobel 1988), el aporte coetáneo de Trevor Swan (1956), la extensión empírica de Mankiw, Romer y Weil (1992), y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI, enlaces verificados y estado de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la derivación matemática formal, simulación de convergencia y contabilidad del crecimiento reproducible.
  - [R/modelo_crecimiento_solow.R](replicacion/R/modelo_crecimiento_solow.R): Script autónomo y modular en R que modela el diagrama del estado estacionario de Solow, la dinámica temporal de transición hacia el equilibrio, la Regla de Oro del capital y la descomposición histórica de la Productividad Total de los Factores (Residuo de Solow).
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_solow_estado_estacionario.png](replicacion/salidas/fig_solow_estado_estacionario.png), [fig_solow_contabilidad_crecimiento.png](replicacion/salidas/fig_solow_contabilidad_crecimiento.png)) y tabla consolidada de métricas ([tab_resultados_solow.csv](replicacion/salidas/tab_resultados_solow.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: estado estacionario y velocidad de convergencia; intermedio: Regla de Oro del capital e ineficiencia dinámica; reto: contabilidad del crecimiento con capital humano en el marco MRW).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, fundamentos analíticos, solucionario completo paso a paso y rúbrica de evaluación para los docentes.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo de las Contribuciones

Robert M. Solow (1924–2023), profesor del Massachusetts Institute of Technology (MIT), sentó las bases teóricas y empíricas de la macroeconomía contemporánea a través de dos aportes decisivos:

1. **El Modelo Neoclásico de Crecimiento (Solow-Swan, 1956):**
   - Reemplazó la tecnología rígida y la inestabilidad de "filo de navaja" del modelo Harrod-Domar por una función de producción agregada neoclásica con sustitución suave entre capital y trabajo y rendimientos marginales decrecientes del capital.
   - Demostró que las economías convergen de forma global y asintótica hacia un **estado estacionario** (*steady state*) donde el capital por trabajador eficiente ($k^*$) permanece constante.
   - Probó que la tasa de ahorro determina el **nivel** de riqueza por habitante, pero no la **tasa de crecimiento** sostenida de largo plazo, la cual depende exclusivamente del progreso tecnológico exógeno ($g$).
   - Caracterizó la **Regla de Oro del Capital** ($s_{oro} = \alpha$), delimitando el umbral a partir del cual el sobreahorro provoca **ineficiencia dinámica** (despilfarro intertemporal).

2. **La Contabilidad del Crecimiento y el Residuo de Solow (1957):**
   - Desarrolló un método econométrico riguroso para descomponer la tasa de crecimiento del PIB entre el aporte de los factores tangibles (capital físico y trabajo) y un residuo no observado: la **Productividad Total de los Factores (PTF)**.
   - Descubrió que cerca del $87.5\%$ del crecimiento histórico del producto por hora trabajada en Estados Unidos entre 1909 y 1949 provenía del progreso técnico y solo el $12.5\%$ de la intensificación del capital.
   - Convirtió la medición de la productividad en el estándar metodológico internacional adoptado por la U.S. BLS, la OCDE, el Banco Mundial y el FMI.

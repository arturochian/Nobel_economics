# Nobel de Economía 1980: Lawrence R. Klein

> **Motivación oficial:**  
> *"for the creation of econometric models and the application to the analysis of economic fluctuations and economic policies"* (Por la creación de modelos econométricos y su aplicación al análisis de las fluctuaciones económicas y las políticas económicas).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 15 de octubre de 1980.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras fundamentales de Klein (*The Keynesian Revolution* 1947, *Economic Fluctuations in the United States* 1950, *Klein-Goldberger Model* 1955, *Brookings Model* 1965, *Project LINK* 1976, Discurso Nobel 1981) y los comunicados oficiales de la Fundación Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI, enlaces directos y régimen de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos de referencia y notas de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la derivación matemática del sesgo de simultaneidad, el método de Mínimos Cuadrados en Dos Etapas (MC2E / 2SLS), la representación en forma reducida matricial, el análisis de autovalores y la simulación dinámica de multiplicadores fiscales.
  - [R/modelo_macroeconometrico_klein.R](replicacion/R/modelo_macroeconometrico_klein.R): Script autónomo y reproducible en R que estima el Modelo Klein I mediante MCO vs MC2E con datos históricos de la Comisión Cowles (1920–1941), calcula las matrices dinámicas y genera los multiplicadores fiscales.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_klein_modelo_simulacion.png](replicacion/salidas/fig_klein_modelo_simulacion.png), [fig_klein_multiplicadores_dinamicos.png](replicacion/salidas/fig_klein_multiplicadores_dinamicos.png)) y tabla estructurada de resultados ([tab_resultados_klein.csv](replicacion/salidas/tab_resultados_klein.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: deducción del sesgo de simultaneidad y variables instrumentales en MC2E; intermedio: álgebra de forma reducida y multiplicador de impacto de impuestos; reto: dinámica matricial, raíces complejas conjugadas, estabilidad y ciclos endógenos de Kuznets/Juglar).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, fundamentos analíticos y solucionario completo paso a paso con rúbrica de evaluación para el cuerpo docente.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el portal web estático.

---

## Resumen Ejecutivo de las Contribuciones

Lawrence Robert Klein (1920–2013), profesor de la Universidad de Pennsylvania e investigador fundamental de la *Cowles Commission for Research in Economics*, es reconocido internacionalmente como el **padre de la modelización macroeconométrica moderna**:

1. **El Modelo Klein I (1950) y la Estimación Simultánea:**
   - En su monografía de 1950 para la Comisión Cowles (*Economic Fluctuations in the United States 1921-1941*), formuló el primer sistema empírico de ecuaciones simultáneas diseñado para someter la teoría macroeconómica keynesiana al rigor de las series de tiempo estadísticas.
   - Demostró formalmente que estimar ecuaciones uniecuacionales mediante Mínimos Cuadrados Ordinarios (MCO) produce estimadores sesgados e inconsistentes debido a la retroalimentación simultánea entre el producto, los salarios y el consumo.
   - Estableció el estándar metodológico para la estimación con variables instrumentales mediante Mínimos Cuadrados en Dos Etapas (MC2E / 2SLS) y Máxima Verosimilitud de Información Completa (FIML), permitiendo descomponer las fluctuaciones en ciclos endógenos amortiguados y choques exógenos.

2. **Los Megamodelos Macroeconométricos de Posguerra:**
   - **Modelo Klein-Goldberger (1955):** Desarrollado en la Universidad de Michigan junto a Arthur Goldberger, integró 20 ecuaciones simultáneas no lineales que incorporaron el sistema monetario y financiero, los impuestos progresivos, los precios y las tendencias demográficas, convirtiéndose en el primer modelo aplicado para pronósticos de política fiscal en Estados Unidos.
   - **Modelo Brookings (1965):** Codirigido por Klein con James Duesenberry, Gary Fromm y Edwin Kuh, articuló cerca de 400 ecuaciones que integraban el comportamiento de sectores industriales desglosados, el mercado laboral y el sector financiero, sentando la base de los modelos operativos del Banco de la Reserva Federal (modelo MPS y posteriormente FRB/US).
   - **Wharton Econometric Forecasting Associates (WEFA):** Fundada por Klein en la Wharton School (Universidad de Pennsylvania) en 1963, fue la primera consultora macroeconométrica comercial del mundo en suministrar pronósticos y simulaciones de escenarios a gobiernos, bancos centrales y corporaciones globales.

3. **El Proyecto LINK (1968): La Primera Red Macroeconométrica Mundial:**
   - Fundó y coordinó el **Proyecto LINK** en 1968 con el auspicio del *Social Science Research Council* y las Naciones Unidas.
   - Resolvió el problema de frontera de la macroeconometría tradicional: hasta entonces, cada país modelaba sus importaciones y exportaciones asumiendo el resto del mundo como variables exógenas arbitrarias.
   - LINK articuló docenas de modelos macroeconómicos nacionales independientes (de economías occidentales desarrolladas, países en desarrollo y economías planificadas socialistas) a través de una matriz mundial consistente de comercio internacional. Hoy en día, la red continúa activa y es administrada por el Departamento de Asuntos Económicos y Sociales de Naciones Unidas (UN DESA) para proyectar el informe anual *World Economic Situation and Prospects* (WESP).

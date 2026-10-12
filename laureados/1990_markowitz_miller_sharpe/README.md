# Nobel de Economía 1990: Harry M. Markowitz, Merton H. Miller y William F. Sharpe

> **Motivación oficial:**  
> *"for their pioneering work in the theory of financial economics"* (Por su trabajo pionero en la teoría de la economía financiera).  
> **Reconocimientos específicos del comité:**  
> - **Harry M. Markowitz:** *"for having developed the theory of portfolio choice"* (por haber desarrollado la teoría de selección de cartera).  
> - **William F. Sharpe:** *"for his contributions to the theory for the price formation for financial assets, the so-called, Capital Asset Pricing Model (CAPM)"* (por sus contribuciones a la teoría de formación de precios de activos financieros, el denominado Modelo CAPM).  
> - **Merton H. Miller:** *"for his fundamental contributions to the theory of corporate finance"* (por sus contribuciones fundamentales a la teoría de las finanzas corporativas).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 16 de octubre de 1990.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Markowitz (*J. Finance* 1952, libro 1959), Sharpe (*J. Finance* 1964, *J. Business* 1966), Modigliani & Miller (*AER* 1958, *J. Business* 1961, *J. Finance* 1977) y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias de las obras referenciadas.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia de libre acceso.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la formulación matricial de Markowitz, derivación analítica de la frontera eficiente continua, portafolio de mínima varianza y de tangencia, deducción del modelo CAPM y simulación del teorema de Modigliani-Miller.
  - [R/frontera_eficiente_y_capm.R](replicacion/R/frontera_eficiente_y_capm.R): Script autónomo y reproducible en R que ejecuta la optimización media-varianza, simulación Monte Carlo, gráficos de la SML y cálculo del WACC corporativo.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_markowitz_frontera_eficiente.png](replicacion/salidas/fig_markowitz_frontera_eficiente.png), [fig_sharpe_capm_sml.png](replicacion/salidas/fig_sharpe_capm_sml.png)) y tabla consolidada de métricas ([tab_resultados_finanzas_1990.csv](replicacion/salidas/tab_resultados_finanzas_1990.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: diversificación en carteras de dos activos y correlación; intermedio: cálculo de Betas, SML y Alfa de Jensen; reto: teorema de Modigliani-Miller, apalancamiento casero y escudo fiscal).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes, marco pedagógico unificado y solucionario matemático paso a paso de toda la guía de ejercicios.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter y secciones canónicas para el portal web estático.

---

## Resumen Ejecutivo del Aporte

Harry Markowitz, Merton Miller y William Sharpe fundaron las tres columnas maestras sobre las que descansa toda la economía financiera moderna:

1. **Harry M. Markowitz: Teoría Moderna de Selección de Cartera (1952, 1959)**
   - Estableció que el riesgo no puede medirse por la volatilidad individual de un activo, sino por su **covarianza** con el resto de la cartera.
   - Demostró el poder matemático de la **diversificación**: al combinar activos imperfectamente correlacionados, el riesgo específico o idiosincrático se cancela a costo cero sin mermar la rentabilidad esperada.
   - Formuló la **frontera eficiente media-varianza**, permitiendo identificar de forma analítica el conjunto de carteras óptimas que ofrecen el máximo retorno esperado para cada nivel de riesgo.

2. **William F. Sharpe: Modelo de Valoración de Activos de Capital (CAPM, 1964, 1966)**
   - Transformó la regla de optimización individual de Markowitz en una teoría de equilibrio general para todo el mercado.
   - Demostró que en equilibrio todos los inversores diversificados mantienen la misma cartera de mercado combinada con préstamos o endeudamiento al tipo libre de riesgo (**Teorema de Separación de Tobin-Sharpe** y **Línea CML**).
   - Concluyó que, como el riesgo idiosincrático se elimina gratis con la diversificación, **los mercados solo pagan una prima por asumir riesgo sistemático no diversificable**, medido por el coeficiente **Beta** ($\beta$).
   - Desarrolló la **Línea de Mercado de Valores (SML)** y el **Ratio de Sharpe**, herramientas universales para la valoración de inversiones y el análisis de atribución de resultados (Alfa de Jensen).

3. **Merton H. Miller: Teorema de Modigliani-Miller sobre Finanzas Corporativas (1958, 1961)**
   - Desmintió la idea tradicional de que las empresas podían crear valor mediante trucos de ingeniería financiera entre deuda y acciones.
   - **Proposición I:** En ausencia de impuestos y costos de quiebra, el valor total de una empresa está determinado únicamente por sus activos productivos y flujos de caja operativos ($V_L = V_U$), siendo irrelevante su estructura de capital. El arbitraje de los inversores mediante "apalancamiento casero" (*homemade leverage*) garantiza la paridad de valoración.
   - **Proposición II:** El aparente beneficio de endeudarse a un menor costo queda contrarrestado exactamente por el incremento en el riesgo financiero y la rentabilidad exigida por los accionistas, manteniendo el **Costo Promedio Ponderado de Capital (WACC)** estrictamente constante.
   - **Irrelevancia de Dividendos (1961):** La política de dividendos no altera la riqueza del inversor, quien puede sintetizar sus propios flujos vendiendo o reinvirtiendo títulos en el mercado.

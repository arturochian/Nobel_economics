# Nobel de Economía 1981: James Tobin

> **Motivación oficial:**  
> *"for his analysis of financial markets and their relations to expenditure decisions, employment, production and prices"* (Por su análisis de los mercados financieros y sus relaciones con las decisiones de gasto, empleo, producción y precios).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 13 de octubre de 1981.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras seminales de Tobin (*Review of Economic Studies* 1958, *Econometrica* 1958, *American Economic Review* 1968, *Journal of Money, Credit and Banking* 1969, *Eastern Economic Journal* 1978, Discurso Nobel 1982), el teorema de Hayashi (1982) y el comunicado oficial de la Academia Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI/JSTOR, enlaces estables y régimen de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la fundamentación analítica, derivación micro y macroeconómica, gráficos reproducibles y simulación computacional.
  - [R/q_de_tobin_y_seleccion_cartera.R](replicacion/R/q_de_tobin_y_seleccion_cartera.R): Script autónomo y modular en R que modela la tasa de inversión empresarial en función de la $q$ de Tobin bajo costos convexos de ajuste cuadráticos, y resuelve analíticamente el Teorema de Separación de Dos Fondos de Tobin en el plano riesgo-retorno con activo libre de riesgo.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_tobin_q_inversion.png](replicacion/salidas/fig_tobin_q_inversion.png), [fig_tobin_separacion_cartera.png](replicacion/salidas/fig_tobin_separacion_cartera.png)) y tabla consolidada de escenarios ([tab_resultados_tobin.csv](replicacion/salidas/tab_resultados_tobin.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: valoración corporativa y cálculo de la $q$ de Tobin; intermedio: Teorema de Separación de Tobin, cálculo de la cartera tangente y CAL; reto: costos asimétricos de ajuste e irreversibilidad del capital, y fundamentos del estimador Tobit).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, fundamentos analíticos, solucionario completo paso a paso y rúbrica de evaluación para los docentes.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo de las Contribuciones

James Tobin (1918–2002), catedrático de la Universidad de Yale y expresidente de la American Economic Association, transformó la macroeconomía y la economía financiera al construir el andamiaje que conecta los mercados de activos con las decisiones reales de gasto, producción y empleo.

### 1. La q de Tobin y la Teoría de la Inversión Empresarial (1969)
- **Definición y mecanismo:**  
  Definió la ratio $q$ como el cociente entre la valoración bursátil de los activos de capital de una empresa y su costo de reposición física en bienes de capital nuevo ($q = V / p_K K$).
- **Incentivo a la formación de capital:**  
  Si $q > 1$, las empresas encuentran rentable emitir títulos en los mercados financieros para adquirir maquinaria nueva o construir fábricas adicionales, puesto que el mercado valora el capital instalado por encima de lo que cuesta reponerlo. Si $q < 1$, resulta más barato expandirse adquiriendo firmas existentes, frenando la inversión bruta por debajo de la tasa de depreciación.
- **Microfundamentación con costos de ajuste:**  
  Formalizada junto a Fumio Hayashi (1982) y Lawrence Summers (1981), la relación óptima $\frac{I}{K} = \delta + \frac{1}{\chi}(q - 1)$ explica por qué la inversión reacciona de forma gradual ante las fluctuaciones financieras debido a los costos internos de instalación del capital ($\chi$).

### 2. Teoría de Selección de Cartera y Teorema de Separación de Tobin (1958)
- **Preferencias por liquidez como conducta ante el riesgo:**  
  Rompió con el supuesto keynesiano de expectativas rígidas sobre las tasas de interés, demostrando que los agentes diversifican racionalmente entre dinero seguro y activos de riesgo para optimizar la relación riesgo-retorno.
- **El Teorema de Separación de Dos Fondos (*Two-Fund Separation*):**  
  Demostró que el problema de inversión se divide en dos fases independientes:
  1. *Fase técnica:* La selección de la cartera de activos de riesgo óptima (la cartera tangente $T$), idéntica para todos los inversores.
  2. *Fase subjetiva:* La partición del patrimonio total entre dicha cartera tangente y el dinero libre de riesgo, determinada exclusivamente por la aversión al riesgo del individuo.
- **Pilar del CAPM:**  
  Este teorema constituyó el fundamento directo sobre el cual William Sharpe formuló el Capital Asset Pricing Model (CAPM) y la Línea del Mercado de Capitales (CML).

### 3. El Modelo Tobit (1958) y la Tasa Tobin (1978)
- **Regresión con datos censurados (Tobit):**  
  Creó el primer estimador de máxima verosimilitud para corregir el sesgo sistemático de Mínimos Cuadrados Ordinarios en variables dependientes no negativas con acumulación de ceros.
- **Tasa Tobin:**  
  Propuso gravar con un tipo impositivo reducido las transacciones cambiarías internacionales a corto plazo para moderar la volatilidad financiera especulativa.

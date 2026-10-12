---
anio: 1984
slug: 1984_stone
laureados: ["Sir Richard Stone"]
motivacion_oficial: "for having made fundamental contributions to the development of systems of national accounts and hence greatly improved the basis for empirical economic analysis [por haber hecho contribuciones fundamentales al desarrollo de los sistemas de cuentas nacionales y por tanto haber mejorado enormemente las bases para el análisis económico empírico]"
area: ["Macroeconomía", "Econometría", "Estadística Económica"]
tags: ["cuentas nacionales", "SNA", "PIB", "matriz de contabilidad social", "SAM", "sistema lineal de gasto", "Stone-Geary", "insumo-producto"]
referencias_clave: ["stone1954linear", "meade1941construction", "un1968sna", "un1953sna", "stone1986accounts"]
replicacion: "laureados/1984_stone/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Sir Richard Stone dotó a la economía de su lenguaje cuantitativo universal al concebir el Sistema de Cuentas Nacionales (SNA) basado en la partida doble macroeconómica, articular las Matrices de Contabilidad Social (SAM) y formular el Sistema Lineal de Gasto (LES), transformando la medición empírica del PIB y la demanda del consumidor en una ciencia rigurosa.

## Resumen de la investigación
Antes de la década de 1940, los gobiernos carecían de una métrica coherente y sistemática de la actividad económica agregada. Las estimaciones de riqueza e ingreso nacional eran fragmentarias, se calculaban mediante metodologías no homologadas y no existía un marco contable cerrado que vinculara la producción de bienes con la remuneración de los factores de producción y el gasto final de las familias.

En los inicios de la Segunda Guerra Mundial, John Maynard Keynes convocó a Sir Richard Stone (1913–1991) y a James Meade (Nobel 1977) al Tesoro británico con una misión urgente: calcular la capacidad productiva de Gran Bretaña para financiar el esfuerzo de guerra sin desatar una espiral inflacionaria devastadora. El resultado fue el histórico *White Paper* de 1941 (*An Analysis of the Sources of War Finance and an Estimate of the National Income and Expenditure in 1938 and 1940*), primer intento formal de construir un sistema de contabilidad macroeconómica articulado.

Tras la guerra, como director del *Department of Applied Economics* (DAE) de la Universidad de Cambridge, Stone lideró los esfuerzos internacionales para diseñar el estándar definitivo de la contabilidad económica global:
1. **El Sistema de Cuentas Nacionales de Naciones Unidas (SNA 1953 y 1968):** Estandarizó a escala planetaria la contabilidad de partida doble para macromagnitudes, asegurando la identidad matemática estricta entre la producción agregada, el ingreso factorial y el gasto final.
2. **Matrices de Contabilidad Social (SAM):** En el marco del *Cambridge Growth Project* (1962), integró las tablas insumo-producto (*Input-Output*) de Wassily Leontief con las cuentas institucionales de distribución del ingreso, construyendo matrices balanceadas de flujos circulares que originaron los modelos de equilibrio general computable.
3. **El Sistema Lineal de Gasto (Linear Expenditure System - LES, 1954):** Formuló y estimó el primer sistema empírico de demanda microfundamentado derivado de una función de utilidad (Stone-Geary), logrando separar analíticamente el consumo básico de subsistencia del gasto discrecional del hogar.

## Metodología y resultados

### 1. El Sistema de Cuentas Nacionales (SNA) y la Partida Doble Macroeconómica
Stone comprendió que el flujo circular de la renta solo puede medirse sin sesgos si cada transacción económica se registra simultáneamente como un crédito (ingreso) para el sector emisor y un débito (gasto) para el sector receptor. Este principio de partida doble cerrada garantiza que el Producto Interno Bruto (PIB) calculado por tres vías independientes sea rigurosamente idéntico:

$$\text{PIB} = \text{Producción Neta (Valor Agregado)} \equiv \text{Ingreso Factorial Total} \equiv \text{Gasto Final Agregado}$$

Bajo el marco del SNA de 1953 y su versión ampliada de 1968, Stone formalizó los cuatro sectores institucionales clásicos:
- **Empresas productivas:** Generan valor agregado bruto ($VAB = \text{Ventas} - \text{Consumo Intermedio}$) y remuneran a los factores.
- **Hogares:** Perciben salarios y rentas de capital, asignando sus ingresos al consumo privado ($C$) y al ahorro ($S$).
- **Gobierno:** Recauda impuestos ($T$), ejecuta gasto de consumo público e inversión ($G$) y otorga transferencias sociales.
- **Sector Externo (Resto del Mundo):** Intercambia bienes y servicios mediante exportaciones ($X$) e importaciones ($M$).

La identidad contable fundamental asegura el equilibrio ahorro-inversión:

$$(S - I) + (T - G) = (X - M)$$

### 2. Matrices de Contabilidad Social (SAM) y Multiplicadores de Stone
Stone amplió la tabla insumo-producto tradicional hacia la **Matriz de Contabilidad Social (SAM)**, una matriz cuadrada balanceada $T$ de orden $m \times m$ donde cada fila $i$ representa las entradas (ingresos) de la cuenta $i$ y cada columna $j$ representa las salidas (gastos) de la cuenta $j$. La condición de cierre contable impone:

$$\sum_{j=1}^m T_{ij} = \sum_{k=1}^m T_{ki} = y_i \quad \forall i = 1, \dots, m$$

Al particionar la SAM en cuentas endógenas (actividades productivas, factores de producción y hogares) y cuentas exógenas (gobierno, acumulación de capital y resto del mundo), Stone dedujo la matriz de coeficientes de propensión al gasto medio $A_n = T_{endo} \hat{y}_{endo}^{-1}$ y formuló los **multiplicadores contables de Stone**:

$$y_{endo} = A_n y_{endo} + x_{exo} \iff y_{endo} = (I - A_n)^{-1} x_{exo} = M x_{exo}$$

Donde $M = (I - A_n)^{-1}$ es la matriz de multiplicadores contables, análoga a la inversa de Leontief pero enriquecida con el circuito de distribución factorial del ingreso y el consumo endógeno de los hogares.

### 3. El Sistema Lineal de Gasto (Linear Expenditure System - LES, 1954)
Stone (1954) resolvió la paradoja de cómo estimar sistemas de demanda empíricos que satisfagan automáticamente las restricciones de la microeconomía axiomática. Derivó el LES a partir de la función de utilidad Stone-Geary:

$$U(q_1, \dots, q_n) = \sum_{i=1}^n \beta_i \ln(q_i - \gamma_i), \quad \text{con } \sum_{i=1}^n \beta_i = 1, \quad q_i > \gamma_i$$

Donde $\gamma_i$ representa el parámetro de consumo comprometido o de subsistencia en el bien $i$, y $\beta_i$ es la propensión marginal al gasto. Resolviendo la maximización de utilidad sujeta a la restricción presupuestaria $\sum p_j q_j = y$, Stone obtuvo la ecuación de gasto lineal:

$$p_i q_i = p_i \gamma_i + \beta_i \left( y - \sum_{j=1}^n p_j \gamma_j \right)$$

Este sistema posee propiedades teóricas fundamentales:
1. **Descomposición del ingreso:** El consumidor primero adquiere el consumo mínimo indispensable $\sum p_j \gamma_j$; el remanente, llamado **ingreso supernumerario o discrecional** ($y - \sum p_j \gamma_j$), se distribuye entre los bienes según los coeficientes $\beta_i$.
2. **Propiedades microeconómicas exactas:** Satisface la aditividad presupuestaria ($\sum p_i q_i = y$), la homogeneidad de grado cero en precios e ingreso y la simetría de sustitución de Slutsky.
3. **Elasticidades estructurales:**
   - Elasticidad ingreso: $\eta_i = \frac{\beta_i}{w_i}$, donde $w_i = \frac{p_i q_i}{y}$.
   - Elasticidad precio propia: $\epsilon_{ii} = -1 + (1 - \beta_i) \frac{\gamma_i}{q_i}$.

---

## Antes y después

### Antes
- **Estimaciones macroeconómicas aisladas y no reconciliadas:** Hacia 1930, economistas como Colin Clark y Simon Kuznets producían estimaciones pioneras del ingreso nacional, pero no existía un marco contable unificado de partida doble. El PIB por el método del gasto difería significativamente del PIB por el método del ingreso sin explicación metodológica rigurosa.
- **Inexistencia de un lenguaje estadístico internacional:** Cada país publicaba cifras según definiciones locales arbitrarias de ahorro, producción e impuestos, impidiendo comparaciones internacionales válidas y la coordinación económica multilateral de posguerra.
- **Modelos de demanda ad-hoc no microfundamentados:** La econometría aplicada de la demanda se reducía a estimar regresiones uniecuacionales $q_i = a_0 + a_1 p_i + a_2 y$. Estas ecuaciones violaban flagrantemente la restricción presupuestaria (la suma del gasto predicho no coincidía con el ingreso) y carecían de consistencia con la teoría del consumidor.

### Después (qué cambió gracias al aporte)
- **Universalización del Sistema de Cuentas Nacionales (SNA):** El SNA de la ONU se convirtió en la arquitectura contable adoptada obligatoriamente por todos los países miembros de Naciones Unidas, el FMI, el Banco Mundial y la OCDE. Conceptos como PIB, valor agregado bruto, ingreso nacional disponible y déficit público quedaron formalizados matemáticamente.
- **Nacimiento de los Modelos de Equilibrio General Computable (CGE):** La invención de las Matrices de Contabilidad Social (SAM) permitió vincular el aparato productivo intersectorial con la estratificación social de los hogares, permitiendo a los economistas simular impactos distributivos de reformas arancelarias y tributarias.
- **Fundación de la econometría de la demanda moderna:** El Sistema Lineal de Gasto (Stone 1954) inauguró el estudio riguroso de sistemas completos de demanda empírica, abriendo el camino a desarrollos posteriores como el Sistema Casi Ideal de Demanda (AIDS) de Angus Deaton y John Muellbauer (1980).

---

## Cómo se aplica hoy

1. **Compilación Oficial del PIB y Estándar SNA 2008 / SNA 2025 (ONU, FMI, OCDE, Eurostat):**  
   La División de Estadística de las Naciones Unidas ([UNSD](https://unstats.un.org/unsd/nationalaccount/)) y la Oficina de Estadística de la Unión Europea ([Eurostat](https://ec.europa.eu/eurostat)) coordinan la compilación trimestral de las cuentas nacionales de más de 190 países siguiendo el estándar del *System of National Accounts* (SNA 2008, en proceso de actualización al SNA 2025). Todos los agregados macroeconómicos que determinan los techos de endeudamiento soberano, las contribuciones al presupuesto de la Unión Europea y las metas de inflación de los bancos centrales se calculan sobre la estructura de partida doble diseñada originalmente por Stone.
2. **Modelos de Equilibrio General Computable y Evaluación de Pobreza (Banco Mundial e IFPRI):**  
   El Banco Mundial ([World Bank](https://www.worldbank.org/)) y el Instituto Internacional de Investigación sobre Políticas Alimentarias ([IFPRI](https://www.ifpri.org/)) construyen Matrices de Contabilidad Social (SAM) para economías emergentes con el fin de evaluar reformas tributarias, subsidios a combustibles y acuerdos de libre comercio. Gracias a los multiplicadores contables de Stone ($M = (I - A)^{-1}$), los analistas simulan cómo un shock en las exportaciones agrícolas impacta el ingreso real de los deciles más vulnerables de la población rural.
3. **Medición de Canastas Básicas y Líneas de Pobreza (CEPAL y Bancos Centrales):**  
   Institutos nacionales de estadística en América Latina (como el [INEI](https://www.inei.gob.pe/) en Perú y el [INEGI](https://www.inegi.org.mx/) en México) y la [CEPAL](https://www.cepal.org/) aplican sistemas de gasto tipo Stone-Geary / LES para modelar el gasto de subsistencia ($\gamma_i$). Estos parámetros de consumo comprometido permiten calibrar objetivamente el costo de la canasta básica alimentaria y fijar los umbrales monetarios de las líneas de pobreza extrema y moderada.

---

## Replicación en R

La replicación cuantitativa de los aportes de Sir Richard Stone se implementa de manera autónoma en el script [`cuentas_nacionales_y_sistema_gasto.R`](laureados/1984_stone/replicacion/R/cuentas_nacionales_y_sistema_gasto.R):

1. **Sistema Lineal de Gasto (LES / Stone-Geary 1954):**  
   Se calibran cuatro categorías agregadas de gasto (Alimentos, Vivienda, Vestimenta y Servicios) con requerimientos de subsistencia $\gamma = (35, 25, 12, 15)$ y propensiones marginales $\beta = (0.15, 0.20, 0.15, 0.50)$, con un gasto total de subsistencia de $S = 97.10$. Se modela la trayectoria del gasto y la convergencia de las elasticidades ingreso $\eta_i(y)$ a medida que el ingreso se expande de $100$ a $500$, demostrando la ley de Engel en alimentos ($\eta < 1$) y el carácter suntuario de los servicios ($\eta > 1$). La visualización generada es [`fig_stone_sistema_gasto_les.png`](laureados/1984_stone/replicacion/salidas/fig_stone_sistema_gasto_les.png).
2. **Matriz de Contabilidad Social (SAM) y Multiplicadores Contables:**  
   Se construye una SAM cerrada y balanceada de 7 cuentas macroeconómicas canónicas (Actividades, Factores, Hogares, Empresas, Gobierno, Inversión y Resto del Mundo). Se demuestra que el error contable de partida doble es idénticamente cero ($0.0000$). Se particionan las cuentas en endógenas y exógenas, calculando la matriz de multiplicadores de Stone $M = (I - A_n)^{-1}$. Un shock unitario en actividades genera un multiplicador de $1.94$ en producción, $1.22$ en remuneración a factores y $0.92$ en ingreso disponible de los hogares. El gráfico consolidado se exporta a [`fig_stone_matriz_contabilidad_sam.png`](laureados/1984_stone/replicacion/salidas/fig_stone_matriz_contabilidad_sam.png).
3. **Resultados Numéricos:**  
   Todos los valores computados de elasticidades, balances contables y multiplicadores se registran de forma estructurada en [`tab_resultados_stone.csv`](laureados/1984_stone/replicacion/salidas/tab_resultados_stone.csv).

---

## Para profundizar

- **Meade, J. E. & Stone, R. (1941):** "The Construction of Tables of National Income, Expenditure, Savings and Investment". *The Economic Journal*, 51(202/203), 216–233. [DOI: 10.2307/2226254](https://doi.org/10.2307/2226254). El histórico artículo que sentó las bases de la contabilidad nacional británica durante la Segunda Guerra Mundial.
- **Stone, R. (1954):** "Linear Expenditure Systems and Demand Analysis: An Application to the Pattern of British Demand". *The Economic Journal*, 64(255), 511–527. [DOI: 10.2307/2227743](https://doi.org/10.2307/2227743). Artículo seminal que introduce el Sistema Lineal de Gasto (LES) derivado de la función de utilidad Stone-Geary.
- **Stone, R. (1954):** *The Measurement of Consumers' Expenditure and Behaviour in the United Kingdom, 1920–1938*, Vol. 1. Cambridge University Press. Monografía monumental sobre econometría aplicada de series de tiempo de consumo.
- **United Nations (1953):** *A System of National Accounts and Supporting Tables*. Studies in Methods, Series F, No. 2. New York: United Nations. [PDF oficial](https://unstats.un.org/unsd/nationalaccount/docs/1953SNA.pdf). El primer manual internacional de cuentas nacionales coordinado por Stone.
- **United Nations (1968):** *A System of National Accounts*. Studies in Methods, Series F, No. 2, Rev. 3. New York: United Nations. [PDF oficial](https://unstats.un.org/unsd/nationalaccount/docs/1968SNA.pdf). La gran reforma del SNA que incorporó las matrices de insumo-producto y contabilidad social.
- **Stone, R. (1986):** "Nobel Lecture: The Accounts of Society". *Journal of Applied Econometrics*, 1(1), 5–28. [DOI: 10.1002/jae.3950010103](https://doi.org/10.1002/jae.3950010103). Discurso Nobel donde Stone expone su visión unificada de las cuentas económicas, demográficas y sociales.
- **The Royal Swedish Academy of Sciences (1984):** *Information to the Public: Richard Stone and the Development of Systems of National Accounts*. [NobelPrize.org](https://www.nobelprize.org/prizes/economic-sciences/1984/popular-information/).

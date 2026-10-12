---
anio: 1997
slug: 1997_merton_scholes
laureados: ["Robert C. Merton", "Myron S. Scholes"]
motivacion_oficial: "for a new method to determine the value of derivatives [por un nuevo método para determinar el valor de los derivados]"
area: ["Economía Financiera", "Finanzas Cuantitativas"]
tags: ["Black-Scholes-Merton", "opciones", "derivados", "cobertura dinámica", "delta hedging", "fijación neutral al riesgo", "riesgo de crédito", "modelo de Merton", "volatilidad implícita"]
referencias_clave: ["black1973pricing", "merton1973rational", "merton1974debt", "cox1979option", "black1976commodity"]
replicacion: "laureados/1997_merton_scholes/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Robert C. Merton y Myron S. Scholes (junto con Fischer Black *in memoriam*) desarrollaron la fórmula matemática y la técnica de cobertura dinámica que permitieron fijar el precio exacto de las opciones financieras sin conocer el retorno esperado del activo ni las preferencias de riesgo de los inversores, inaugurando la era moderna de las finanzas cuantitativas.

## Resumen de la investigación
Durante décadas, economistas y matemáticos trataron infructuosamente de calcular el valor justo de un contrato de opción. Desde los trabajos pioneros de Louis Bachelier en 1900 hasta Paul Samuelson en los años sesenta, todos los modelos tropezaban con un obstáculo insalvable: se creía indispensable estimar la tasa esperada de rentabilidad del activo subyacente y la prima subjetiva por riesgo requerida por los agentes de mercado.

En 1973, **Fischer Black y Myron S. Scholes** publicaron su artículo seminal *"The Pricing of Options and Corporate Liabilities"* en el *Journal of Political Economy*, y simultáneamente **Robert C. Merton** publicó *"Theory of Rational Option Pricing"* en el *Bell Journal of Economics and Management Science*. Juntos formularon una revolución conceptual:

1. **La Cartera de Réplica Libre de Riesgo:** Demostraron que combinando una opción con una posición continuamente ajustada en la acción subyacente mediante el coeficiente **Delta** ($\Delta = \partial C / \partial S$), las perturbaciones aleatorias de mercado se cancelan instantáneamente.
2. **Principio de No Arbitraje:** Como la cartera resultante carece de riesgo local, su rendimiento debe ser obligatoriamente igual a la **tasa de interés libre de riesgo** ($r$). De lo contrario, cualquier inversor podría generar beneficios infinitos sin desembolso neto de capital ni riesgo alguno.
3. **Fórmula Cerrada y Volatilidad:** El precio de la opción no depende del retorno esperado del activo ni de la aversión al riesgo de los compradores, sino de solo cinco variables: el precio al contado ($S$), el precio de ejercicio ($K$), el tiempo al vencimiento ($T$), la tasa libre de riesgo ($r$) y la volatilidad del subyacente ($\sigma$).

Robert C. Merton amplió sustancialmente el modelo introduciendo dividendos continuos, formalizando la valoración bajo el lema de Itô y el cálculo estocástico en tiempo continuo, y concibiendo en 1974 el **modelo estructural de riesgo de crédito corporativo**, donde las acciones y los bonos de una empresa se interpretan como opciones sobre los activos totales de la firma.

## Metodología y resultados

### 1. La Ecuación Diferencial Parcial de Black-Scholes-Merton
Considerando que el precio del subyacente $S_t$ sigue un movimiento browniano geométrico $dS_t = \mu S_t dt + \sigma S_t dW_t$, el lema de Itô aplicado a una función diferenciable de valor $V(S, t)$ arroja:

$$dV = \left( \frac{\partial V}{\partial t} + \mu S \frac{\partial V}{\partial S} + \frac{1}{2}\sigma^2 S^2 \frac{\partial^2 V}{\partial S^2} \right) dt + \sigma S \frac{\partial V}{\partial S} dW_t$$

Al formar la cartera de cobertura $\Pi = V - \Delta S$ con $\Delta = \frac{\partial V}{\partial S}$, el término estocástico $dW_t$ se extingue. Imponiendo ausencia de arbitraje ($d\Pi = r\Pi dt$), se deduce la célebre ecuación en derivadas parciales (PDE):

$$\frac{\partial V}{\partial t} + \frac{1}{2}\sigma^2 S^2 \frac{\partial^2 V}{\partial S^2} + (r - q) S \frac{\partial V}{\partial S} - r V = 0$$

donde $q$ es la tasa continua de dividendos incorporada por Merton.

### 2. La Fórmula de Valoración Cerrada
Para una opción europea de compra (*Call*), la solución analítica exacta es:

$$C(S, t) = S e^{-q(T-t)} \mathcal{N}(d_1) - K e^{-r(T-t)} \mathcal{N}(d_2)$$

Y para una opción europea de venta (*Put*):

$$P(S, t) = K e^{-r(T-t)} \mathcal{N}(-d_2) - S e^{-q(T-t)} \mathcal{N}(-d_1)$$

donde $\mathcal{N}(\cdot)$ es la función de distribución acumulada de una normal estándar, y:

$$d_1 = \frac{\ln(S / K) + \left(r - q + \frac{1}{2}\sigma^2\right)(T - t)}{\sigma \sqrt{T - t}}, \quad d_2 = d_1 - \sigma \sqrt{T - t}$$

### 3. Las Griegas y la Gestión Dinámica
El modelo proporciona las fórmulas cerradas de sensibilidad paramétrica para mesas de operaciones:
- **Delta ($\Delta$):** Ratio de réplica óptimo ($e^{-q\tau}\mathcal{N}(d_1)$).
- **Gamma ($\Gamma$):** Curvatura de la opción y velocidad de ajuste requerida de Delta.
- **Vega ($\nu$):** Sensibilidad ante cambios en la volatilidad implícita del mercado.
- **Theta ($\Theta$):** Pérdida de valor temporal por el transcurso de los días.

---

## Antes y después

### Antes
- **Ausencia de mercados organizados de opciones:** La negociación de contratos de derivados era marginal, opaca y carecía de precios estandarizados fiables.
- **Subjetividad en la fijación de precios:** Se creía que el valor de una opción dependía intrínsecamente del optimismo o pesimismo de los inversores sobre el rumbo de la acción y de su aversión individual al riesgo.
- **Inexistencia de técnicas cuantitativas de cobertura:** Los intermediarios financieros no disponían de un procedimiento riguroso para cubrir carteras masivas de derivados frente a fluctuaciones de mercado sin asumir apuestas especulativas directas.
- **Riesgo crediticio evaluado solo cualitativamente:** La solvencia empresarial se analizaba mediante balances contables estáticos y calificaciones subjetivas, sin modelos cuantitativos que vincularan la volatilidad del negocio con el riesgo de impago.

### Después (qué cambió gracias al aporte)
- **Explosión de los mercados globales de derivados:** En abril de 1973 nació el *Chicago Board Options Exchange* (CBOE). Los operadores comenzaron a usar calculadoras programadas con la fórmula Black-Scholes para fijar precios en tiempo real, transformando los derivados en una de las industrias financieras más gigantescas del planeta.
- **Fijación neutral al riesgo (*Risk-Neutral Pricing*):** Se consolidó el principio de que los derivados pueden valorarse bajo una medida donde todos los activos descuentan a la tasa libre de riesgo, dando pie a los teoremas fundamentales de la valoración de activos (*Harrison & Kreps 1979*).
- **Cobertura dinámica industrializada:** Surgió el *Delta-hedging* como estándar operativo indispensable en bancos de inversión mundiales, permitiendo intermediar billones de dólares en riesgos de tasas de interés, divisas y acciones.
- **El modelo estructural de crédito corporativo:** El modelo de Merton (1974) redefinió el análisis del riesgo crediticio: el patrimonio neto es una opción de compra y la deuda riesgosa es un bono con una opción de venta implícita concedida a los accionistas.

---

## Cómo se aplica hoy

1. **El Índice de Volatilidad VIX de CBOE (1993, 2003–presente):**
   El famoso "índice del miedo" de los mercados financieros mundiales ([CBOE Volatility Index - VIX](https://www.cboe.com/tradable_products/vix/)) se calcula invirtiendo los precios de mercado de una amplia gama de opciones *Put* y *Call* sobre el índice S&P 500 para extraer la volatilidad implícita esperada a 30 días, un concepto directo derivado del marco analítico de Black-Scholes-Merton.

2. **Modelo Moody's Analytics KMV para Riesgo Crediticio (1993–presente):**
   Instituciones financieras de todo el planeta emplean el modelo comercial [Moody's Analytics Public EDF](https://www.moodysanalytics.com/solutions-overview/credit-risk/credit-scoring-and-assessment/riskcalc-and-public-edf), una implementación directa del modelo estructural de Merton (1974) que utiliza el valor de mercado de las acciones y la estructura de pasivos para calcular la frecuencia de impago esperada (*Expected Default Frequency*, EDF) en decenas de miles de empresas.

3. **Regulación Bancaria Internacional de Capital de Mercado (Basilea III / FRTB, 2019–2026):**
   El Comité de Supervisión Bancaria de Basilea ([Bank for International Settlements - FRTB](https://www.bis.org/bcbs/publ/d457.htm)) exige a todos los bancos sistémicos del mundo reportar sensibilidades basadas en las Griegas (Delta, Gamma, Vega y curvatura) según las fórmulas de Black-Scholes-Merton para determinar los requerimientos de capital regulatorio frente a riesgos de mercado en libros de negociación.

4. **Normas Internacionales de Contabilidad para Opciones a Empleados (IFRS 2 / US GAAP ASC 718):**
   Las directrices contables globales ([IFRS 2 Share-based Payment](https://www.ifrs.org/issued-standards/list-of-standards/ifrs-2-share-based-payment/)) obligan a las corporaciones cotizadas de todo el mundo a valorar y registrar como gasto operativo las opciones otorgadas a ejecutivos y trabajadores utilizando el modelo Black-Scholes-Merton o extensiones de árboles binomiales.

---

## Replicación en R
En la carpeta [`replicacion/`](../replicacion/) se encuentra el código completo que:
1. Implementa las fórmulas analíticas cerradas para opciones europeas de compra y venta con dividendos continuos, junto con sus Griegas analíticas (Delta, Gamma, Vega, Theta y Rho).
2. Contrasta la solución continua contra dos métodos numéricos independientes:
   - El árbol binomial de **Cox, Ross y Rubinstein (1979)** hasta 500 pasos temporales.
   - La simulación estocástica de **Monte Carlo** neutral al riesgo (con variables antitéticas) hasta 500,000 trayectorias.
3. Evalúa empíricamente el modelo estructural de crédito corporativo de Merton (1974), cuantificando el valor del capital, el valor de la deuda riesgosa, el diferencial crediticio (*credit spread*) y la probabilidad de quiebra implícita.

Las salidas generadas incluyen:
- [`fig_bsm_precio_y_griegas.png`](../replicacion/salidas/fig_bsm_precio_y_griegas.png): Paneles con curvas de precios vs valor intrínseco, Delta por vencimiento, Gamma y Vega.
- [`fig_bsm_convergencia_monte_carlo.png`](../replicacion/salidas/fig_bsm_convergencia_monte_carlo.png): Convergencia del error Monte Carlo con bandas al 95% y oscilaciones del árbol binomial.
- [`tab_resultados_bsm.csv`](../replicacion/salidas/tab_resultados_bsm.csv): Comparativa de exactitud numérica para contratos ITM, ATM y OTM.

---

## Para profundizar
- **Black, F. & Scholes, M. (1973):** *"The Pricing of Options and Corporate Liabilities"*, *Journal of Political Economy*, 81(3), 637–654. [DOI: 10.1086/260062](https://doi.org/10.1086/260062).
- **Merton, R. C. (1973):** *"Theory of Rational Option Pricing"*, *The Bell Journal of Economics and Management Science*, 4(1), 141–183. [DOI: 10.2307/3003143](https://doi.org/10.2307/3003143).
- **Merton, R. C. (1974):** *"On the Pricing of Corporate Debt: The Risk Structure of Interest Rates"*, *The Journal of Finance*, 29(2), 449–470. [DOI: 10.1111/j.1540-6261.1974.tb03058.x](https://doi.org/10.1111/j.1540-6261.1974.tb03058.x).
- **Cox, J. C., Ross, S. A., & Rubinstein, M. (1979):** *"Option Pricing: A Simplified Approach"*, *Journal of Financial Economics*, 7(3), 229–263. [DOI: 10.1016/0304-405X(79)90015-1](https://doi.org/10.1016/0304-405X(79)90015-1).
- **Merton, R. C. (1990):** *Continuous-Time Finance*, Basil Blackwell, Oxford / Cambridge.
- **Royal Swedish Academy of Sciences (1997):** *Scientific Background: A New Method to Determine the Value of Derivatives*, [nobelprize.org](https://www.nobelprize.org/prizes/economic-sciences/1997/advanced-information/).

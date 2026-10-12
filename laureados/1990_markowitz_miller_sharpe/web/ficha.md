---
anio: 1990
slug: 1990_markowitz_miller_sharpe
laureados: ["Harry M. Markowitz", "Merton H. Miller", "William F. Sharpe"]
motivacion_oficial: "for their pioneering work in the theory of financial economics [por su trabajo pionero en la teoría de la economía financiera]"
area: ["Economía Financiera", "Finanzas Cuantitativas", "Finanzas Corporativas"]
tags: ["teoría de cartera", "Markowitz", "frontera eficiente", "diversificación", "CAPM", "Sharpe", "Beta", "ratio de Sharpe", "Modigliani-Miller", "estructura de capital", "WACC"]
referencias_clave: ["markowitz1952portfolio", "markowitz1959portfolio", "sharpe1964capital", "sharpe1966mutual", "modigliani1958cost", "miller1961dividend", "miller1977debt"]
replicacion: "laureados/1990_markowitz_miller_sharpe/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Harry Markowitz demostró que el riesgo se reduce combinando activos en carteras eficientes, William Sharpe probó que solo el riesgo sistemático de mercado merece compensación financiera (CAPM), y Merton Miller reveló que el valor de una empresa reside en sus activos reales y no en su mezcla de deuda y capital propio.

## Resumen de la investigación
A mediados del siglo XX, las finanzas eran un campo dominado por reglas heurísticas, descripciones contables y consejos empíricos sin fundamento formal. Las decisiones de inversión y de financiación corporativa carecían de una teoría económica rigurosa. El Premio Nobel de 1990 reconoció la tríada de aportes que transformó las finanzas en una ciencia económica exacta:

1. **Harry M. Markowitz (1952, 1959) y la Teoría de Cartera (*Portfolio Selection*):**  
   Markowitz concibió la inversión como un problema de optimización matemática bajo incertidumbre. Su descubrimiento capital fue que **el riesgo de un activo no puede medirse de forma aislada**, sino a través de su covarianza con los demás activos de la cartera. Demostró matemáticamente el proverbio de "no poner todos los huevos en la misma canasta": combinando activos no perfectamente correlacionados, el riesgo específico (idiosincrático) se diluye sin disminuir el retorno esperado. Formuló el concepto de **frontera eficiente**, el conjunto de carteras que maximizan la rentabilidad para cada nivel de volatilidad (media-varianza).

2. **William F. Sharpe (1964, 1966) y el Modelo CAPM (*Capital Asset Pricing Model*):**  
   Sharpe elevó la teoría normativa de elección individual de Markowitz a una teoría de equilibrio general del mercado. Si todos los inversores optimizan sus carteras según Markowitz, en equilibrio todos mantendrán una combinación del activo libre de riesgo y la cartera representativa de todo el mercado (*portafolio de tangencia*). Como el riesgo específico puede eliminarse a costo cero mediante la diversificación, **el mercado solo remunera el riesgo sistemático no diversificable**. Sharpe formalizó la **Línea de Mercado de Valores (SML)**, donde el retorno esperado de cualquier activo depende linealmente de su sensibilidad macroeconómica o coeficiente **Beta** ($\beta$), y creó el **Ratio de Sharpe** como estándar universal de desempeño ajustado por riesgo.

3. **Merton H. Miller (1958, 1961) y el Teorema de Modigliani-Miller:**  
   Junto a Franco Modigliani, Miller desarmó la creencia corporativa de que los ejecutivos podían "crear valor" simplemente emitiendo deuda en lugar de acciones o modificando la política de dividendos. Bajo condiciones de mercados financieros sin fricciones (sin impuestos, costos de transacción ni costos de quiebra), el valor de una firma está determinado exclusivamente por su capacidad de generar flujos operativos con sus activos reales (**Proposición I**). Si una empresa se endeuda, el aparente beneficio de pagar una tasa de interés más baja queda neutralizado exactamente por el incremento en el riesgo financiero y la rentabilidad exigida por los accionistas (**Proposición II**), manteniendo el Costo Promedio Ponderado de Capital (WACC) inalterado. El arbitraje de los propios inversores mediante "apalancamiento casero" (*homemade leverage*) impide cualquier discrepancia de valoración.

## Metodología y resultados

### 1. La Frontera Eficiente de Markowitz
El inversor resuelve el programa cuadrático:
$$\min_{\mathbf{w}} \frac{1}{2} \mathbf{w}' \boldsymbol{\Sigma} \mathbf{w} \quad \text{sujeto a} \quad \mathbf{w}' \mathbf{1} = 1, \quad \mathbf{w}' \boldsymbol{\mu} = \mu_p$$
Definiendo las constantes de Merton-Markowitz $A = \mathbf{1}' \boldsymbol{\Sigma}^{-1} \mathbf{1}$, $B = \mathbf{1}' \boldsymbol{\Sigma}^{-1} \boldsymbol{\mu}$, $C = \boldsymbol{\mu}' \boldsymbol{\Sigma}^{-1} \boldsymbol{\mu}$ y $\Delta = AC - B^2$, la envolvente de mínima varianza traza una hipérbola en el plano $(\sigma, \mu)$:
$$\sigma_p^2(\mu_p) = \frac{1}{A} + \frac{A}{\Delta}\left(\mu_p - \frac{B}{A}\right)^2$$
El vértice define el **Portafolio de Mínima Varianza Global (GMVP)** con $\mu_{\text{gmv}} = B/A$ y $\sigma_{\text{gmv}} = 1/\sqrt{A}$.

### 2. El Modelo CAPM y la Línea SML
Al introducir un activo libre de riesgo ($r_f$), la frontera se expande linealmente hacia la **Línea de Mercado de Capitales (CML)**, tangente a la frontera riesgosa en la cartera de mercado $M$:
$$\mathbb{E}[R_p] = r_f + \left(\frac{\mathbb{E}[R_M] - r_f}{\sigma_M}\right) \sigma_p$$
Para cualquier activo o proyecto de inversión individual $i$, la **Línea de Mercado de Valores (SML)** fija su rentabilidad requerida en función de su riesgo sistemático:
$$\mathbb{E}[R_i] = r_f + \beta_i \left(\mathbb{E}[R_M] - r_f\right), \quad \text{donde } \beta_i = \frac{\text{Cov}(R_i, R_M)}{\sigma_M^2}$$

### 3. Las Proposiciones de Modigliani-Miller
- **Proposición I:** $V_L = V_U = \frac{\text{EBIT}}{r_0}$ (la suma del valor de mercado de acciones y bonos es constante).
- **Proposición II:** $r_E = r_0 + (r_0 - r_D)\frac{D}{E}$ (el costo del capital propio crece linealmente con la razón de deuda a capital).
- **WACC invariante:** $\text{WACC} = \frac{E}{V} r_E + \frac{D}{V} r_D = r_0$.

---

## Antes y después

### Antes
- **Enfoque ingenuo de inversión:** Las acciones se evaluaban individualmente analizando dividendos pasados y balances contables aislados, asumiendo que el riesgo de una cartera era simplemente el promedio del riesgo de sus componentes.
- **Creencia de que todo riesgo debe ser pagado:** Se pensaba que las acciones más volátiles debían rendir más en promedio, sin distinguir si esa volatilidad provenía de problemas internos de la empresa o de oscilaciones macroeconómicas de mercado.
- **Ingeniería financiera como creadora de riqueza:** Se creía que una empresa podía enriquecer a sus accionistas sustituyendo capital propio por deuda bancaria más barata, creyendo falsamente que el costo promedio del capital disminuía indefinidamente.
- **Política de dividendos mágica:** Existía el consenso de que repartir altos dividendos en efectivo aumentaba de forma permanente el valor intrínseco de las acciones.

### Después (qué cambió gracias al aporte)
- **Nacimiento de la Gestión Cuantitativa de Carteras:** Se institucionalizó el uso de matrices de covarianza, optimizadores media-varianza y asignación estratégica de activos (*Asset Allocation*) en fondos de pensiones y bancas de inversión.
- **Fijación de precios de activos por factores sistemáticos:** El CAPM sentó el principio moderno de que el riesgo idiosincrático se diversifica a costo cero; los mercados eficientes solo pagan primas por riesgos no eludibles ($\beta$). Surgió la separación entre rentabilidad de mercado (*Beta*) y habilidad de gestión (*Alfa*).
- **Invención de los Fondos Indexados (Gestión Pasiva):** La conclusión de Sharpe de que la cartera de mercado es eficiente justificó la creación de vehículos indexados de costo ultra bajo (John Bogle / Vanguard).
- **Fundación de las Finanzas Corporativas Modernas:** Las juntas directivas comprendieron que el valor empresarial se crea en el lado izquierdo del balance (inversiones reales en proyectos con VAN positivo), no en el lado derecho (artificios contables de deuda vs acciones).

---

## Cómo se aplica hoy

1. **Gestión Pasiva e Indexación Global (Vanguard / BlackRock, 1975–presente):**  
   La deducción de Sharpe de que la cartera de mercado ponderada por capitalización es la óptima para el inversor medio fundamentó la creación del primer fondo indexado por John Bogle ([Vanguard 500 Index Fund](https://investor.vanguard.com/investment-products/mutual-funds/profile/vfinx)). En la actualidad, más de 15 billones de dólares en activos globales se gestionan pasivamente replicando carteras de mercado de Sharpe a costos inferiores a 5 puntos básicos anuales.

2. **Asignación Estratégica del Fondo Soberano de Noruega (NBIM, 1998–presente):**  
   El mayor fondo soberano del mundo, el *Government Pension Fund Global* gestionado por [Norges Bank Investment Management (NBIM)](https://www.nbim.no/en/the-fund/how-we-invest/), con más de 1.7 billones de dólares de patrimonio, estructura su cartera en más de 8,800 empresas de 70 países basándose en los principios de diversificación global de Markowitz para eliminar casi la totalidad del riesgo idiosincrático.

3. **Determinación del Costo de Capital en Regulación de Infraestructura (Ofgem y FERC, 1989–presente):**  
   Reguladores internacionales de monopolios naturales como [Ofgem en el Reino Unido](https://www.ofgem.gov.uk/) y la [Federal Energy Regulatory Commission (FERC)](https://www.ferc.gov/) en Estados Unidos utilizan obligatoriamente el CAPM de Sharpe y la fórmula WACC de Modigliani-Miller para fijar la tasa máxima permitida de retorno sobre el capital en redes de electricidad, gas, agua y ferrocarriles.

4. **Optimización de Estructura de Capital y Emisión de Deuda Corporativa (Apple Inc., 2013–presente):**  
   Corporaciones globales como [Apple Inc.](https://investor.apple.com/) han aplicado activamente las proposiciones de Modigliani-Miller sobre el escudo fiscal al emitir más de 100,000 millones de dólares en deuda con tasas históricamente bajas, recomprando sus propias acciones para optimizar su WACC sin afectar negativamente sus operaciones operativas reales.

---

## Replicación en R
En la carpeta [`replicacion/`](../replicacion/) se encuentra el código completo que:
1. Resuelve matricialmente la frontera eficiente continua de Markowitz para un universo de activos diversificados (acciones estadounidenses de alta y baja capitalización, renta variable internacional, bonos corporativos y deuda soberana).
2. Calcula de forma analítica el Portafolio de Mínima Varianza Global (GMVP) y el Portafolio de Tangencia (Mercado).
3. Simula una nube de 3,500 carteras aleatorias para ilustrar el espacio de carteras factibles y el principio de no dominancia.
4. Traza la Línea de Mercado de Valores (SML) del CAPM, evaluando los coeficientes Beta ($\beta$) y el Alfa de Jensen ($\alpha$) para activos eficientes y fondos con desviaciones de comisiones.
5. Modela las Proposiciones I y II de Modigliani-Miller, demostrando la constancia del WACC en función del apalancamiento $D/E$ y el impacto del escudo fiscal corporativo.

Las salidas generadas incluyen:
- [`fig_markowitz_frontera_eficiente.png`](../replicacion/salidas/fig_markowitz_frontera_eficiente.png): Frontera eficiente analítica, nube de carteras simuladas, cartera GMVP, portafolio de tangencia y desglose de ponderaciones óptimas.
- [`fig_sharpe_capm_sml.png`](../replicacion/salidas/fig_sharpe_capm_sml.png): Línea SML del CAPM con alfas de inversión y curvas de costo de capital de Modigliani-Miller (Proposición I y II con y sin impuestos).
- [`tab_resultados_finanzas_1990.csv`](../replicacion/salidas/tab_resultados_finanzas_1990.csv): Tabla cuantitativa con retornos esperados, volatilidades, Betas, Ratios de Sharpe y pesos óptimos.

---

## Para profundizar
- **Markowitz, H. (1952):** *"Portfolio Selection"*, *The Journal of Finance*, 7(1), 77–91. [DOI: 10.1111/j.1540-6261.1952.tb01525.x](https://doi.org/10.1111/j.1540-6261.1952.tb01525.x).
- **Markowitz, H. M. (1959):** *Portfolio Selection: Efficient Diversification of Investments*, Cowles Foundation Monograph 16, John Wiley & Sons, New York. [Cowles Foundation](https://cowles.yale.edu/publications/monographs/portfolio-selection).
- **Sharpe, W. F. (1964):** *"Capital Asset Prices: A Theory of Market Equilibrium under Conditions of Risk"*, *The Journal of Finance*, 19(3), 425–442. [DOI: 10.1111/j.1540-6261.1964.tb02865.x](https://doi.org/10.1111/j.1540-6261.1964.tb02865.x).
- **Sharpe, W. F. (1966):** *"Mutual Fund Performance"*, *The Journal of Business*, 39(1), 119–138. [DOI: 10.1086/294846](https://doi.org/10.1086/294846).
- **Modigliani, F. & Miller, M. H. (1958):** *"The Cost of Capital, Corporation Finance and the Theory of Investment"*, *The American Economic Review*, 48(3), 261–297. [JSTOR: 1809766](https://www.jstor.org/stable/1809766).
- **Miller, M. H. & Modigliani, F. (1961):** *"Dividend Policy, Growth, and the Valuation of Shares"*, *The Journal of Business*, 34(4), 411–433. [DOI: 10.1086/294442](https://doi.org/10.1086/294442).
- **Miller, M. H. (1977):** *"Debt and Taxes"*, *The Journal of Finance*, 32(2), 261–275. [DOI: 10.1111/j.1540-6261.1977.tb03267.x](https://doi.org/10.1111/j.1540-6261.1977.tb03267.x).
- **Royal Swedish Academy of Sciences (1990):** *The Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 1990*, [nobelprize.org](https://www.nobelprize.org/prizes/economic-sciences/1990/press-release/).
- **Royal Swedish Academy of Sciences (1990):** *Scientific Background on the Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 1990*, [nobelprize.org](https://www.nobelprize.org/prizes/economic-sciences/1990/advanced-information/).

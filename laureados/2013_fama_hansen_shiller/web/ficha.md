---
anio: 2013
slug: 2013_fama_hansen_shiller
laureados: ["Eugene F. Fama", "Lars Peter Hansen", "Robert J. Shiller"]
motivacion_oficial: "for their empirical analysis of asset prices"
area: ["Economía Financiera", "Econometría Financiera"]
tags: ["hipótesis de mercados eficientes", "modelo de tres factores de Fama-French", "método generalizado de momentos", "GMM", "exceso de volatilidad de Shiller", "CAPE ratio", "Shiller PE"]
referencias_clave: ["fama1970efficient", "fama_french1993common", "hansen1982large", "hansen_singleton1982generalized", "shiller1981stock", "campbell_shiller1988dividend", "nobel2013scientific"]
replicacion: "laureados/2013_fama_hansen_shiller/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Eugene F. Fama, Lars Peter Hansen y Robert J. Shiller revolucionaron el entendimiento de los mercados financieros al demostrar que, si bien los precios de las acciones son prácticamente impredecibles en el corto plazo (días o semanas), exhiben patrones significativos de predictibilidad en horizontes largos (tres a cinco años), ofreciendo los fundamentos empíricos y econométricos que sostienen la gestión moderna de carteras.

## Resumen de la investigación
A finales de la década de 1960, la profesión económica carecía de consenso sobre si los movimientos bursátiles obedecían a leyes racionales o al azar desordenado. Eugene F. Fama (1970) transformó este debate al formalizar la Hipótesis de Mercados Eficientes (*Efficient Market Hypothesis*, EMH). Fama probó que los mercados de capitales procesan la información pública a velocidad extrema, de modo que las variaciones de precios a corto plazo se comportan esencialmente como un paseo aleatorio (*random walk*): ningún inversionista puede superar sistemáticamente al mercado mediante reglas de análisis técnico o información histórica. Posteriormente, junto a Kenneth French (1993), Fama amplió esta visión al demostrar que los retornos de las acciones no dependen de un único riesgo de mercado (como postulaba el CAPM), sino de factores multidimensionales de riesgo sistemático asociados al tamaño de la empresa (*Small Minus Big*, SMB) y a su valoración contable frente a mercado (*High Minus Low*, HML).

Una década después, Robert J. Shiller (1981) desafió la ortodoxia reinante al plantear una pregunta deceptivamente sencilla: ¿se mueven los precios de las acciones más de lo que justifican los dividendos posteriores? Shiller descubrió la llamada "paradoja de exceso de volatilidad": mientras que el valor presente descontado de los dividendos corporativos reales es suave y estable, las cotizaciones bursátiles oscilan con fluctuaciones gigantescas. En trabajos posteriores junto a John Campbell (1988), Shiller demostró que a horizontes de 3 a 10 años los mercados no son impredecibles: cuando las acciones cotizan a múltiplos excesivamente altos respecto a sus ganancias históricas (el ratio CAPE o *Shiller P/E*), los rendimientos futuros subsecuentes tienden a ser sustancialmente más bajos. Esto abrió la puerta al análisis de las primas de riesgo cambiantes en el tiempo y a las finanzas conductuales (*behavioral finance*).

Por su parte, Lars Peter Hansen (1982) aportó el andamiaje econométrico indispensable para poner a prueba todas estas teorías dinámicas. Hansen desarrolló el Método Generalizado de Momentos (*Generalized Method of Moments*, GMM), una técnica de estimación que no requiere supuestos restrictivos sobre la distribución estadística de los datos (como normalidad o homocedasticidad). A través de su célebre test de restricciones sobreidentificadas (el Test $J$), Hansen y Kenneth Singleton (1982) permitieron confrontar directamente las ecuaciones de Euler de consumo intertemporal con los datos de mercado, probando que los modelos estándar de agentes representativos no lograban explicar la prima de riesgo observada (el *Equity Premium Puzzle*) e impulsando la creación de la moderna macro-finanza.

## Metodología y resultados
1. **La Hipótesis de Mercados Eficientes y el Modelo de Tres Factores (Fama 1970, 1993):**
   - Fama formuló el problema de la hipótesis conjunta (*joint hypothesis problem*): evaluar la eficiencia del mercado requiere necesariamente asumir un modelo de retornos esperados en equilibrio.
   - Junto a French (1993), demostró mediante regresiones de series de tiempo sobre 25 carteras ordenadas por tamaño y ratio *Book-to-Market* que el alfa de Jensen se disipa ($\alpha \approx 0$) al incorporar las primas de riesgo $SMB$ y $HML$, explicando más del $90\%$ de la variación en retornos transversales.
2. **Cotas de Varianza y Previsibilidad a Largo Plazo (Shiller 1981; Campbell y Shiller 1988):**
   - Bajo expectativas racionales, el error de pronóstico de dividendos futuros debe ser ortogonal a los precios contemporáneos, exigiendo matemáticamente que $\operatorname{Var}(P_t) \le \operatorname{Var}(P_t^*)$.
   - En datos históricos reales de EE.UU. (1871–1979), Shiller demostró que $\operatorname{Var}(P_t) \gg \operatorname{Var}(P_t^*)$ por un factor de hasta 10 veces, evidenciando que la volatilidad bursátil está dominada por variaciones en las tasas de descuento y sentimiento del mercado, no por noticias fundamentales de flujos de caja.
   - Creó el ratio CAPE (*Cyclically Adjusted Price-to-Earnings*), promediando los beneficios reales durante 10 años para filtrar oscilaciones transitorias del ciclo económico.
3. **Econometría del GMM y el Factor de Descuento Estocástico (Hansen 1982):**
   - Formalizó la minimización de formas cuadráticas de condiciones de ortogonalidad poblacional $\mathbb{E}[g_t(\theta)] = 0$ con matrices de ponderación asintóticamente óptimas $W^* = S^{-1}$.
   - Desarrolló el estadístico $J = T \bar{g}_T' \hat{S}^{-1} \bar{g}_T \sim \chi^2(M-K)$ para contrastar si un modelo estructural comete errores sistemáticos.
   - Derivó junto a Ravi Jagannathan (1991) las cotas de volatilidad del factor de descuento estocástico: $\frac{\sigma(m)}{\mathbb{E}[m]} \ge \frac{|\mathbb{E}[R^e]|}{\sigma(R^e)}$, demostrando matemáticamente la insuficiencia de los modelos clásicos de consumo para justificar el ratio de Sharpe del mercado accionario.

## Antes y después

### Antes
- **Precios bursátiles vistos como un casino caótico:** No existía una teoría formal que explicara por qué los analistas técnicos o "gurús" no podían generar rendimientos consistentes en el tiempo.
- **Riesgo modelado exclusivamente a través del CAPM:** Se asumía que todo el riesgo relevante de una acción se resumía en una única covariación lineal con el mercado ($\beta$), catalogando cualquier desviación persistente como una "anomalía inexplicable".
- **Supuestos de descuento temporal constante:** Se creía que las fluctuaciones de precios reflejaban exclusivamente revisiones racionales sobre las utilidades y dividendos futuros de las empresas.
- **Econometría limitada a máxima verosimilitud bajo normalidad:** Los modelos dinámicos intertemporales no podían estimarse con rigor empírico sin imponer supuestos de distribución paramétrica altamente restrictivos y poco realistas.

### Después (qué cambió gracias al aporte)
- **Reconocimiento de la eficiencia informacional a corto plazo:** Se estableció empíricamente que los precios absorben las noticias con rapidez, convirtiendo la inversión indexada pasiva y de bajo costo en el estándar dominante para la mayoría de inversionistas.
- **Valoración de activos multifactorial:** Las primas de riesgo por tamaño (*size*), valor relativo (*value*) y calidad se convirtieron en la base cuantitativa de la industria financiera moderna (*smart beta* e inversión por factores).
- **Comprensión de la predictibilidad a largo plazo:** Se aceptó que los mercados pueden experimentar desviaciones prolongadas respecto a sus fundamentales debido a variaciones en la aversión al riesgo y sesgos conductuales, legitimando el monitoreo macroprudencial y las finanzas conductuales.
- **Adopción universal del GMM:** El Método Generalizado de Momentos se transformó en la herramienta econométrica insignia de la macroeconomía moderna, la econometría financiera y la banca central.

## Cómo se aplica hoy

1. **Revolución de la Inversión Indexada Pasiva y ETFs de Factores (Vanguard / BlackRock, 1975–presente):**
   La confirmación empírica de Fama de que la gestión activa no bate consistentemente al mercado tras deducir comisiones impulsó la creación de los primeros fondos indexados por John Bogle (Vanguard 500) y el auge contemporáneo de fondos cotizados en bolsa (ETFs). Hoy en día, gigantes como BlackRock (iShares) y Vanguard gestionan billones de dólares en fondos que implementan directamente los factores de Fama-French (ETFs de factores de *Value*, *Small-Cap* y *Quality* como los fondos iShares Russell 2000 Value ETF [IWN] o Vanguard Value ETF [VTV]; véase [BlackRock Factor Investing Overview](https://www.blackrock.com/institutions/en-us/strategies/factor-investing)).

2. **Monitoreo Global de Burbujas y Asignación de Activos con el Shiller CAPE Ratio (1996–presente):**
   El ratio Shiller CAPE se ha convertido en el indicador estándar de valoración de mercado para bancos de inversión, fondos soberanos y reguladores a nivel mundial. Administrado y actualizado mensualmente por la Universidad de Yale ([Yale Department of Economics - Online Data Robert Shiller](http://www.econ.yale.edu/~shiller/data.htm)), el CAPE alertó formalmente sobre la burbuja de las puntocom en el año 2000 (cuando superó 44) y sobre las exuberancias previas a la crisis financiera de 2008. Asimismo, Barclays y la Bolsa de Nueva York estructuran familias de índices y productos cotizados basados en la metodología de valor sectorial de Shiller ([Barclays Shiller CAPE Indices](https://indices.cib.barclays/web/index/details/barclays-shiller-cape-etn)).

3. **Estimación de Modelos Macro-Financieros y Reglas de Política Monetaria en Bancos Centrales (Reserva Federal y BCE):**
   El marco econométrico del GMM desarrollado por Hansen constituye el procedimiento estándar utilizado por los investigadores de la Reserva Federal de EE.UU. y el Banco Central Europeo para estimar funciones de reacción de política monetaria (como las reglas de Taylor con expectativas racionales de Clarida, Galí y Gertler 2000) y modelos de estructura temporal de tasas de interés libre de arbitraje (consúltese el repositorio de investigación de la Reserva Federal: [Federal Reserve Board Working Papers - GMM and Asset Pricing](https://www.federalreserve.gov/econres/feds/)).

## Replicación en R
- **Qué se replicó:** Simulación y contrastación de los tres pilares del Nobel 2013: 
  1. El test de exceso de volatilidad de Shiller (1981) calculando el precio racional de valor presente $P_t^*$ y verificando la violación de la cota de varianza $\operatorname{Var}(P_t) \le \operatorname{Var}(P_t^*)$.
  2. La estimación del modelo de tres factores de Fama-French (1993) comparando el CAPM unifactorial frente al modelo multifactorial ($SMB$, $HML$) en carteras Small-Value y Large-Growth.
  3. La estimación bietápica por GMM de la ecuación de Euler de consumo intertemporal (CCAPM) y el contraste de especificación mediante el Test $J$ de Hansen (1982).
- **Con qué datos:** Series temporales macro-financieras simuladas calibradas a los momentos poblacionales históricos de la economía estadounidense ($T = 100$ años anuales para Shiller, $N = 360$ meses para factores Fama-French y $N = 300$ observaciones para GMM).
- **Resultados obtenidos:**
  - El ratio de dispersión $\sigma(P_t)/\sigma(P_t^*)$ alcanzó $1.86$ con un ratio de varianzas de $3.46$, reproduciendo la paradoja de exceso de volatilidad de Shiller.
  - En la cartera Small-Value, el CAPM generó un alfa aparente positivo de $+4.74\%$ anualizado ($p = 0.0636$) con $R^2 = 0.527$; al incorporar los factores $SMB$ ($\beta = 0.843$) y $HML$ ($\beta = 0.701$), el alfa colapsó a $-1.46\%$ ($p = 0.246$) y el $R^2$ aumentó a $0.888$, confirmando la absorción del exceso de retorno por compensación de riesgo sistemático.
  - La estimación GMM rechazó contundentemente el modelo estándar de consumo intertemporal (Test $J = 10.9527$, $df = 2$, valor $p = 0.0042$), arrojando un coeficiente de aversión al riesgo $\hat{\gamma} \approx 118$, capturando el célebre rompecabezas del premio por riesgo de Hansen y Singleton (1982).
- **Limitaciones:** Los datos se generaron mediante procesos estocásticos calibrados a los parámetros de la literatura en lugar de microdatos propietarios directos de CRSP y Compustat.

## Para profundizar
- Fama, E. F. (1970). *Efficient Capital Markets: A Review of Theory and Empirical Work*. `fama1970efficient`.
- Fama, E. F., & French, K. R. (1993). *Common Risk Factors in the Returns on Stocks and Bonds*. `fama_french1993common`.
- Hansen, L. P. (1982). *Large Sample Properties of Generalized Method of Moments Estimators*. `hansen1982large`.
- Hansen, L. P., & Singleton, K. J. (1982). *Generalized Instrumental Variables Estimation of Nonlinear Rational Expectations Models*. `hansen_singleton1982generalized`.
- Shiller, R. J. (1981). *Do Stock Prices Move Too Much to be Justified by Subsequent Changes in Dividends?*. `shiller1981stock`.
- Campbell, J. Y., & Shiller, R. J. (1988). *Stock Prices, Earnings, and Expected Dividends*. `campbell_shiller1988dividend`.
- The Royal Swedish Academy of Sciences (2013). *Understanding Asset Prices: Scientific Background on the Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 2013*. `nobel2013scientific`.

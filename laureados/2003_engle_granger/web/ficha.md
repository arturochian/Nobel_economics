---
anio: 2003
slug: 2003_engle_granger
laureados: ["Robert F. Engle III", "Clive W. J. Granger"]
motivacion_oficial: "for methods of analyzing economic time series with time-varying volatility (ARCH) [Engle] and for methods of analyzing economic time series with common trends (cointegration) [Granger]"
area: ["Econometría de Series de Tiempo"]
tags: ["volatilidad condicional", "modelos ARCH", "GARCH", "raíces unitarias", "regresión espuria", "cointegración", "modelo de corrección de error", "VECM"]
referencias_clave: ["engle1982autoregressive", "granger_newbold1974spurious", "engle_granger1987cointegration", "bollerslev1986generalized", "granger1969investigating", "nobel2003scientific"]
replicacion: "laureados/2003_engle_granger/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Robert F. Engle III y Clive W. J. Granger refundaron el análisis de series temporales al dotar a la economía de herramientas para capturar la volatilidad oscilante en los mercados financieros (modelos ARCH) y distinguir correlaciones espurias de auténticos equilibrios de largo plazo entre variables no estacionarias (cointegración y modelos VECM).

## Resumen de la investigación
Durante décadas, los economistas aplicaron técnicas estándar de regresión lineal diseñadas para datos estáticos a series cronológicas de precios, tasas de interés, consumo y producción agregada. Sin embargo, las series temporales económicas violan sistemáticamente los supuestos clásicos de la estadística: ni su nivel medio se mantiene estacionario a lo largo de los años, ni su incertidumbre (varianza) permanece inalterable día a día.

Robert F. Engle abordó el enigma de la varianza en los mercados financieros. En las bolsas y los mercados de divisas, la volatilidad no es un valor fijo, sino un fenómeno dinámico que experimenta acumulación o agrupamiento (*volatility clustering*): días de oscilaciones bruscas suelen ir acompañados de días igualmente turbulentos, seguidos de prolongadas rachas de relativa calma. Al asumir erróneamente una varianza constante (homocedasticidad), los modelos convencionales ignoraban la explosión del riesgo en periodos críticos. En 1982, Engle formuló el modelo **ARCH** (*Autoregressive Conditional Heteroskedasticity*), en el que la varianza condicional del presente depende directamente de la magnitud al cuadrado de los choques imprevistos recientes, proporcionando por primera vez un marco riguroso para predecir el riesgo y valorar activos financieros.

Por su parte, Clive W. J. Granger desentrañó los peligros ocultos de las tendencias macroeconómicas. En 1974, junto con Paul Newbold, demostró que estimar una regresión de Mínimos Cuadrados Ordinarios entre variables no estacionarias (que deambulan libremente como caminatas aleatorias independientes) produce casi invariablemente una **regresión espuria**: coeficientes de determinación ($R^2$) inflados y estadísticos $t$ que indican una falsa relación causal estadísticamente significativa cuando en realidad no existe ninguna conexión entre las variables. Posteriormente, en 1981 y formalizado junto a Engle en 1987, Granger descubrió la **cointegración**: dos o más series no estacionarias pueden compartir una tendencia estocástica común de modo que su diferencia sea estacionaria, reflejando una fuerza de equilibrio económico de largo plazo. El **Teorema de Representación de Granger** demostró que tales variables pueden formularse de forma exacta mediante un **Modelo de Corrección de Error (VECM)**, permitiendo a los investigadores reconciliar las oscilaciones de corto plazo con las fuerzas estructurales de largo plazo.

## Metodología y resultados
1. **Modelos ARCH y GARCH de Robert F. Engle (1982, 1986):**
   Engle definió el error de pronóstico como $\varepsilon_t = \sigma_t z_t$, donde $z_t \sim \text{i.i.d. } \mathcal{N}(0, 1)$ y la varianza condicional $\sigma_t^2 = Var(\varepsilon_t \mid I_{t-1})$ responde dinámicamente a choques pasados:
   $$\sigma_t^2 = \omega + \sum_{i=1}^q \alpha_i \varepsilon_{t-i}^2$$
   Su discípulo Tim Bollerslev (1986) amplió la formulación al modelo GARCH(p, q), incorporando inercias autorregresivas de la propia varianza condicional ($\beta \sigma_{t-1}^2$). Engle demostró cómo estimar estos parámetros por Máxima Verosimilitud y desarrolló la prueba multiplicadora de Lagrange (ARCH-LM) para diagnosticar heterocedasticidad en residuos.

2. **Diagnóstico de Regresión Espuria de Granger y Newbold (1974):**
   Demostraron que dos procesos integrados de orden uno $I(1)$ independientes generan una regresión con estadístico de Durbin-Watson $DW \to 0$ y $DW < R^2$, donde el estadístico $t$ no tiene distribución asintótica normal sino que diverge con el tamaño de muestra a tasa $\sqrt{T}$, elevando la tasa de rechazo erróneo de la hipótesis nula de independencia por encima del 75%.

3. **Cointegración y el Teorema de Representación de Granger (1987):**
   Engle y Granger probaron que si $y_t \sim I(1)$ y $x_t \sim I(1)$, pero existe una combinación lineal $z_t = y_t - \beta x_t \sim I(0)$, las series están cointegradas. Demostraron que el estimador MCO del vector de cointegración es superconsistente (converge a tasa $T$ en vez de $\sqrt{T}$) y probaron el teorema que establece la equivalencia matemática entre cointegración y la existencia de un Vector de Corrección de Error (VECM):
   $$\Delta y_t = \mu + \alpha (y_{t-1} - \beta x_{t-1}) + \sum_{i=1}^p \gamma_i \Delta y_{t-i} + \sum_{j=1}^q \delta_j \Delta x_{t-j} + u_t$$
   donde el coeficiente de corrección $\alpha < 0$ cuantifica la velocidad gravitacional de ajuste hacia el equilibrio.

## Antes y después

### Antes
- **Homocedasticidad irreal:** Se modelaban los retornos de acciones, divisas y materias primas asumiendo una dispersión de riesgo constante a lo largo de décadas, lo que impedía cuantificar los incrementos súbitos de vulnerabilidad financiera en momentos de tensión.
- **Riesgo de regresiones espurias masivas:** La profesión académica y los gobiernos publicaban rutinariamente modelos macroeconómicos en niveles con elevados coeficientes $R^2$, sin percatarse de que las asociaciones encontradas eran meros artefactos causados por tendencias estocásticas independientes.
- **El dilema de la diferenciación:** Para evitar la no estacionariedad, los analistas diferenciaban todas las series ($\Delta y_t$), pero al hacerlo eliminaban y destruían la información económica sobre las relaciones de equilibrio a largo plazo.

### Después (qué cambió gracias al aporte)
- **Cálculo dinámico del riesgo financiero:** Los modelos ARCH y GARCH se convirtieron en el estándar de la industria bancaria y bursátil para la estimación del Valor en Riesgo (VaR), el Déficit Esperado (*Expected Shortfall*) y la fijación de precios de opciones financieras con volatilidad cambiante.
- **Protocolo de verificación de raíces unitarias:** Toda investigación moderna de series temporales somete obligatoriamente los datos a pruebas formales de integración (como Dickey-Fuller) antes de cualquier estimación, desterrando las regresiones espurias.
- **Modelación integral con VECM:** La cointegración dotó a la econometría de un puente matemático entre la teoría económica de largo plazo (teorías de paridad, función de consumo, demanda monetaria) y los ajustes dinámicos de corto plazo mediante vectores de corrección de error.

## Cómo se aplica hoy

1. **Regulación Bancaria Internacional de Basilea (FRTB, Value-at-Risk y Expected Shortfall):**
   El Comité de Basilea de Supervisión Bancaria (*Basel Committee on Banking Supervision*, BIS) exige a las instituciones financieras globales modelar el riesgo de mercado en sus carteras de negociación (*trading book*) mediante medidas dinámicas de volatilidad como el Valor en Riesgo (*Value-at-Risk*, VaR) y el Déficit Esperado (*Expected Shortfall*, ES). Bajo el marco *Fundamental Review of the Trading Book* (FRTB, 2019–2025), las matrices de riesgo de los bancos se calibran en tiempo real usando extensiones multivariadas del modelo ARCH/GARCH formuladas por Robert Engle (como el DCC-GARCH), calculando requerimientos obligatorios de capital regulatorio frente a shocks de volatilidad ([Bank for International Settlements - Basel Framework: Minimum capital requirements for market risk](https://www.bis.org/bcbs/publ/d457.htm)).

2. **Modelos Macroeconómicos de Cointegración y VECM en Bancos Centrales (Reserva Federal, Banco de Inglaterra y BCE):**
   Los bancos centrales emplean de forma rutinaria modelos de Vectores de Corrección de Error (VECM) para vincular variables fundamentales no estacionarias en el largo plazo: consumo y riqueza, demanda de dinero y tasas de interés, paridad del poder adquisitivo (PPP) y tipos de cambio reales. Por ejemplo, el modelo COMPASS del Banco de Inglaterra y los marcos de proyección del Banco Central Europeo integran relaciones de cointegración para proyectar cómo los desalineamientos macroeconómicos temporales convergen hacia trayectorias sustentables de deuda e inflación ([Bank of England - The Bank of England's forecasting platform COMPASS](https://www.bankofengland.co.uk/working-paper/2013/the-bank-of-englands-forecasting-platform-compass)), así como la serie de documentos de trabajo del Banco Central Europeo sobre vectores cointegrados ([European Central Bank Working Paper Series](https://www.ecb.europa.eu/pub/research/working-papers/html/index.en.html)).

3. **Estrategias Cuantitativas de Arbitraje Estadístico y Pairs Trading en Mercados Financieros:**
   En los fondos de cobertura cuantitativos (*quantitative hedge funds*) y creadores de mercado algorítmicos en Wall Street y centros bursátiles globales (como Renaissance Technologies, AQR Capital Management y Citadel), la cointegración de Engle-Granger y Johansen constituye el fundamento matemático del arbitraje estadístico (*statistical arbitrage / pairs trading*). Al identificar canastas de acciones, materias primas o contratos de futuros que comparten una tendencia común $I(1)$, los algoritmos detectan desvíos temporales estacionarios $I(0)$ en el spread, ejecutando posiciones largas en el activo subvaluado y cortas en el sobrevaluado hasta que la fuerza de corrección de error restituye la paridad de mercado ([AQR Capital Management - Quantitative Equity Strategies](https://www.aqr.com/Insights/Research/White-Papers)).

## Replicación en R
- **Qué se replicó:** Simulación y estimación estructural paramétrica de procesos GARCH(1,1) de volatilidad condicional de Robert Engle, demostración empírica de regresión espuria de Granger y Newbold (1974), y calibración del procedimiento de cointegración en dos pasos de Engle-Granger (1987) con especificación de un Modelo de Corrección de Error (VECM).
- **Con qué datos:** Datos simulados con semilla reproducible (`set.seed(2003)`), calibrados con parámetros estándar del mercado de capitales ($\omega = 0.10, \alpha = 0.25, \beta = 0.70$ con persistencia $0.95$ para GARCH; $T = 600$ y $T = 500$).
- **Resultados obtenidos:**
  1. El modelo GARCH reproduce fielmente la alternancia de regímenes de calma y turbulencia; la banda condicional $\pm 1.96 \sigma_t$ se expande drásticamente durante los episodios de shock.
  2. La regresión entre dos paseos aleatorios independientes generó un espurio $R^2 = 0.2886$ con un estadístico $t = -14.21$ altamente engañoso y un Durbin-Watson colapsado de $0.0329$ ($DW < R^2$), confirmando la advertencia de Granger y Newbold.
  3. En el sistema cointegrado auténtico, el estimador de cointegración alcanzó $\hat{\beta} = 1.791$ (frente al parámetro verdadero de $1.80$), los residuos resultaron estacionarios con prueba ADF ($ADF = -6.942, p < 0.01$), y el término de corrección de error del VECM exhibió una velocidad de ajuste estadísticamente muy significativa $\hat{\alpha} = -0.3522$ ($t = -10.27, p < 10^{-20}$), corroborando el retorno dinámico al equilibrio.
- **Limitaciones:** El modelo GARCH básico es simétrico y no captura el efecto apalancamiento (*leverage effect*), mientras que el procedimiento de Engle-Granger asume un único vector de cointegración en un marco bivariado.

## Para profundizar
- Engle, Robert F. (1982). *Autoregressive Conditional Heteroscedasticity with Estimates of the Variance of United Kingdom Inflation*. `engle1982autoregressive`.
- Granger, Clive W. J. & Newbold, Paul (1974). *Spurious Regressions in Econometrics*. `granger_newbold1974spurious`.
- Granger, Clive W. J. (1969). *Investigating Causal Relations by Econometric Models and Cross-spectral Methods*. `granger1969investigating`.
- Granger, Clive W. J. (1981). *Some Properties of Time Series Data and Their Use in Econometric Model Specification*. `granger1981some`.
- Engle, Robert F. & Granger, Clive W. J. (1987). *Co-Integration and Error Correction: Representation, Estimation, and Testing*. `engle_granger1987cointegration`.
- Bollerslev, Tim (1986). *Generalized Autoregressive Conditional Heteroskedasticity*. `bollerslev1986generalized`.
- Engle, Robert F. (2001). *GARCH 101: The Use of ARCH/GARCH Models in Applied Econometrics*. `engle2001garch`.
- Royal Swedish Academy of Sciences (2003). *Time-Series Econometrics: Cointegration and Autoregressive Conditional Heteroskedasticity (Scientific Background)*. `nobel2003scientific`.

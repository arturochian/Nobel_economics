# Guía Pedagógica y Soluciones: Análisis Empírico de Precios de Activos

**Premio Nobel de Economía 2013: Eugene F. Fama, Lars Peter Hansen y Robert J. Shiller**  
*Material docente confidencial – Nobel_economics Project*

---

## Orientaciones Pedagógicas para el Docente

El objetivo pedagógico central de este módulo es desarticular un malentendido frecuente entre los estudiantes: la falsa noción de que Eugene Fama y Robert Shiller sostienen posturas irreconciliables sobre el funcionamiento de los mercados de capitales. 

Al estructurar la clase o seminario, se sugiere enfatizar los siguientes tres ejes conceptuales:
1. **La dimensión del horizonte temporal:** A corto plazo (días, semanas), los precios absorben las noticias con rapidez casi instantánea, haciendo que los retornos sean esencialmente impredecibles (Fama, 1970). Sin embargo, a largo plazo (horizontes de 3 a 10 años), las valoraciones acumuladas se apartan sustancialmente de los fundamentos de dividendos y exhiben una marcada reversión a la media predictiva (Shiller, 1981; Campbell y Shiller, 1988).
2. **El problema de la hipótesis conjunta (*Joint Hypothesis Problem*):** Toda afirmación sobre "mercados ineficientes" o "retornos anormales" depende de la validez del modelo de riesgo utilizado. Lo que bajo el CAPM unifactorial parece ser un alfa milagroso, bajo el modelo de tres factores de Fama-French (1993) se revela como una mera compensación por asumir riesgo de tamaño (*SMB*) o estrés financiero (*HML*).
3. **El puente econométrico de Hansen:** El marco unificador del factor de descuento estocástico ($m_{t+1}$) y el Método Generalizado de Momentos (GMM, Hansen 1982) proporciona el lenguaje matemático riguroso para testear simultáneamente si la dinámica de precios es consistente con las preferencias de consumo intertemporal y el ciclo macroeconómico.

---

## Solución al Ejercicio 1: Formas de Eficiencia de Fama y el Alfa de Jensen

### 1. Cálculo de los Alfas de Jensen
El modelo CAPM postula que el retorno esperado de un activo $i$ en exceso sobre la tasa libre de riesgo depende exclusivamente de su sensibilidad al factor de mercado:
$$\mathbb{E}(R_i) - R_f = \beta_i (\mathbb{E}(R_M) - R_f)$$

El alfa de Jensen mensual mide la desviación respecto al retorno teórico requerido:
$$\alpha_i = \bar{R}_i - [R_f + \beta_i (\bar{R}_M - R_f)]$$

Datos del enunciado:
- Tasa libre de riesgo: $R_f = 0.25\%$ mensual.
- Rendimiento del mercado: $\bar{R}_M = 0.85\%$ mensual.
- Prima de riesgo de mercado: $\bar{R}_M - R_f = 0.85\% - 0.25\% = 0.60\%$ mensual.

**Fondo 1 (Alpha-Tech):**
- $\bar{R}_1 = 1.35\%$, $\beta_1 = 1.40$.
- Retorno requerido por CAPM:
  $$R_{req, 1} = 0.25\% + 1.40 \times 0.60\% = 0.25\% + 0.84\% = 1.09\% \text{ mensual}$$
- Alfa mensual:
  $$\alpha_1^{mes} = 1.35\% - 1.09\% = +0.26\% \text{ mensual}$$
- Alfa anualizado (compuesto o lineal usual):
  $$\alpha_1^{anual} \approx 0.26\% \times 12 = +3.12\% \text{ anual}$$

**Fondo 2 (Deep-Value):**
- $\bar{R}_2 = 0.95\%$, $\beta_2 = 0.80$.
- Retorno requerido por CAPM:
  $$R_{req, 2} = 0.25\% + 0.80 \times 0.60\% = 0.25\% + 0.48\% = 0.73\% \text{ mensual}$$
- Alfa mensual:
  $$\alpha_2^{mes} = 0.95\% - 0.73\% = +0.22\% \text{ mensual}$$
- Alfa anualizado:
  $$\alpha_2^{anual} \approx 0.22\% \times 12 = +2.64\% \text{ anual}$$

*Diagnóstico preliminar:* Ambos fondos parecen generar un alfa positivo frente al mercado, destacando ligeramente *Alpha-Tech* con $+3.12\%$ anualizado frente a $+2.64\%$ de *Deep-Value*.

### 2. El Problema de la Hipótesis Conjunta de Fama
El *Joint Hypothesis Problem* postulado por Fama (1970, 1991) establece que **es imposible contrastar la eficiencia informacional de un mercado sin asumir simultáneamente un modelo de equilibrio para los retornos esperados**.
- Si un fondo obtiene un $\alpha > 0$ estadísticamente significativo bajo el CAPM, existen dos explicaciones ontológicamente indistinguibles para un observador empírico:
  1. El mercado es ineficiente y el gestor explota malas valoraciones de los precios.
  2. El modelo CAPM está mal especificado (omite factores de riesgo sistemático relevantes) y el mercado es perfectamente eficiente.
- Fama y French (1993) demostraron empíricamente que el segundo caso es el verdadero: cuando se descomponen los rendimientos del *Fondo Deep-Value* incorporando el factor de valor ($HML$, empresas con alto *Book-to-Market*) y el factor de tamaño ($SMB$), la carga $\beta_{HML} > 0$ absorbe completamente el rendimiento excedente, haciendo que el alfa multifactorial caiga a cero ($\alpha_{FF3} \approx 0$). El exceso de retorno no proviene de la genialidad del gestor ni de ineficiencias de mercado, sino de compensar al inversionista por asumir el riesgo de empresas maduras con mayor probabilidad de dificultades financieras.

### 3. Formas de Eficiencia y Reglas de Trading
La Hipótesis de Eficiencia Débil postula que **el conjunto de información disponible incluye toda la historia de precios pasados, volúmenes y transacciones**.
- Por ende, si una regla basada en medias móviles exponenciales sobre precios pasados genera rentabilidades anormales netas de costos de transacción y comisiones de forma persistente, refutaría directamente la **forma débil de eficiencia**.
- Al refutar la forma débil, se refutan automáticamente las formas semifuerte y fuerte, ya que los precios pasados son un subconjunto estricto de la información pública y de la información total.

---

## Solución al Ejercicio 2: La Paradoja de Shiller y las Cotas de Varianza

### 1. Demostración Matemática de la Cota de Varianza de Shiller (1981)
Definimos:
$$P_t^* = \sum_{k=0}^{\infty} \gamma^{k+1} D_{t+k}, \quad \text{donde } \gamma = \frac{1}{1+r} \in (0, 1)$$
Bajo expectativas racionales, el precio de mercado es la esperanza matemática condicionada a la información disponible $\Omega_t$:
$$P_t = \mathbb{E}[P_t^* \mid \Omega_t]$$
Definimos el error de predicción:
$$\varepsilon_t \equiv P_t^* - P_t = P_t^* - \mathbb{E}[P_t^* \mid \Omega_t]$$

Por la propiedad de la esperanza condicional (teorema de proyección ortogonal):
$$\mathbb{E}[\varepsilon_t \mid \Omega_t] = \mathbb{E}[P_t^* \mid \Omega_t] - \mathbb{E}[P_t^* \mid \Omega_t] = 0$$
Dado que el precio de mercado $P_t$ pertenece al conjunto de información contemporáneo ($P_t \in \Omega_t$):
$$\operatorname{Cov}(P_t, \varepsilon_t) = \mathbb{E}[(P_t - \mathbb{E}[P_t])(\varepsilon_t - \mathbb{E}[\varepsilon_t])] = \mathbb{E}[(P_t - \mathbb{E}[P_t]) \mathbb{E}[\varepsilon_t \mid \Omega_t]] = \mathbb{E}[(P_t - \mathbb{E}[P_t]) \cdot 0] = 0$$

Descomponiendo $P_t^* = P_t + \varepsilon_t$:
$$\operatorname{Var}(P_t^*) = \operatorname{Var}(P_t + \varepsilon_t) = \operatorname{Var}(P_t) + \operatorname{Var}(\varepsilon_t) + 2\operatorname{Cov}(P_t, \varepsilon_t)$$
Como $\operatorname{Cov}(P_t, \varepsilon_t) = 0$:
$$\operatorname{Var}(P_t^*) = \operatorname{Var}(P_t) + \operatorname{Var}(\varepsilon_t)$$
Puesto que la varianza de cualquier variable aleatoria es no negativa ($\operatorname{Var}(\varepsilon_t) \ge 0$):
$$\operatorname{Var}(P_t^*) \ge \operatorname{Var}(P_t) \quad \implies \quad \operatorname{Var}(P_t) \le \operatorname{Var}(P_t^*)$$
Tomando la raíz cuadrada a ambos lados (función monótona creciente para reales no negativos):
$$\sigma(P_t) \le \sigma(P_t^*)$$
*Q.E.D.*

### 2. Interpretación Económica y Reconciliación Moderna
- **Violación empírica:** En los datos de Shiller (1981), $\sigma(P_t) \approx 5 \cdot \sigma(P_t^*)$, lo cual viola frontalmente la cota teórica. Para que el precio de mercado fluctúe tanto, los dividendos futuros tendrían que haber variado de forma violenta. Sin embargo, la serie real de dividendos agregados de las corporaciones estadounidenses es sumamente suave y estable a lo largo del tiempo.
- **Reconciliación econométrica:** Campbell y Shiller (1988) resolvieron analíticamente la aparente paradoja mediante una aproximación log-lineal del ratio dividendo-precio. Demostraron que la varianza de los precios no proviene de revisiones racionales en el crecimiento de los dividendos futuros $\Delta d_{t+k}$, sino de **variaciones temporales en la tasa de descuento esperada $r_{t+k}$**:
  $$\frac{P_t}{D_t} \approx \frac{1}{r_t - g_t}$$
  Si la tasa de descuento (o prima de riesgo requerida) cambia con las condiciones macroeconómicas o con el optimismo/pesimismo psicológico de los agentes (*animal spirits* de Shiller 2000), los precios bursátiles oscilarán con enorme violencia sin que los dividendos fundamentales experimenten cambio alguno.

### 3. Fundamento del Ratio Shiller CAPE
- El ratio tradicional $P/E$ anual sufre de alta distorsión por la prociclicidad de las ganancias contables corporativas: en el fondo de una recesión, las ganancias contables caen transitoriamente a cero, disparando artificialmente el $P/E$ spot.
- Shiller propuso el **CAPE** (*Cyclically Adjusted Price-to-Earnings*):
  $$\text{CAPE}_t = \frac{P_t}{\frac{1}{10}\sum_{k=0}^9 E_{t-k}^{real}}$$
  Al deflactar por la inflación y promediar los beneficios reales durante un ciclo económico completo de 10 años, se elimina el ruido transitorio.
- **Poder predictivo:** Un valor históricamente elevado de CAPE (por ejemplo, por encima de 30, comparado con el promedio histórico de ~16-17) predice rendimientos reales anualizados muy bajos o negativos en los siguientes 10 años, debido a la inexorable reversión a la media de las valoraciones de mercado.

---

## Solución al Ejercicio 3: GMM, la Ecuación de Euler y la Cota Hansen-Jagannathan

### 1. Vector de Momentos y Grados de Libertad
Para cada activo $j \in \{1, 2, 3\}$, la condición teórica de no arbitraje es:
$$\mathbb{E} [m_{t+1}(\theta) R_{j,t+1} - 1 \mid \Omega_t] = 0, \quad \text{con } m_{t+1}(\theta) = \beta \left( \frac{C_{t+1}}{C_t} \right)^{-\gamma}$$
Dado un vector de $K=2$ instrumentos predeterminados $Z_t = (1, \frac{C_t}{C_{t-1}})'$, aplicamos la ley de expectativas iteradas:
$$\mathbb{E} \left[ (m_{t+1}(\theta) R_{j,t+1} - 1) \otimes Z_t \right] = \mathbf{0}_{2 \times 1}, \quad \forall j \in \{1, 2, 3\}$$

El vector conjunto de condiciones de momentos empíricos es:
$$g_t(\theta) = \begin{pmatrix}
(m_{t+1} R_{1,t+1} - 1) \cdot 1 \\
(m_{t+1} R_{1,t+1} - 1) \cdot \frac{C_t}{C_{t-1}} \\
(m_{t+1} R_{2,t+1} - 1) \cdot 1 \\
(m_{t+1} R_{2,t+1} - 1) \cdot \frac{C_t}{C_{t-1}} \\
(m_{t+1} R_{3,t+1} - 1) \cdot 1 \\
(m_{t+1} R_{3,t+1} - 1) \cdot \frac{C_t}{C_{t-1}}
\end{pmatrix}_{6 \times 1}$$

- Número total de condiciones de momentos: $M = N \times K = 3 \times 2 = 6$.
- Número de parámetros estructurales a estimar: $K_{param} = 2$ ($\theta = (\beta, \gamma)'$).
- Grados de libertad para el test de restricciones sobreidentificadas de Hansen:
  $$df = M - K_{param} = 6 - 2 = 4$$

### 2. Evaluación del Test $J$ de Hansen
Bajo la hipótesis nula $H_0$ de que el modelo de consumo intertemporal está correctamente especificado y las restricciones de sobreidentificación se cumplen:
$$J = T \cdot \bar{g}_T(\hat{\theta})' \hat{S}^{-1} \bar{g}_T(\hat{\theta}) \xrightarrow{d} \chi^2(df) = \chi^2(4)$$

- Estadístico observado: $J = 11.85$.
- Valor crítico tabular al $5\%$: $\chi^2_{0.95}(4) = 9.49$.
- Dado que $J = 11.85 > 9.49$ (y el valor $p = \mathbb{P}(\chi^2_4 \ge 11.85) \approx 0.0185 < 0.05$):
- **Conclusión econométrica:** Se rechaza la hipótesis nula al nivel del $5\%$ de significancia (e incluso al $2\%$). Esto demuestra que la ecuación de Euler clásica del modelo de consumo CCAPM con utilidad isoelástica CRRA no es consistente con el comportamiento simultáneo de los retornos de los activos financieros y los datos de consumo.

### 3. Demostración de la Cota Hansen-Jagannathan (1991)
Consideremos el exceso de retorno de un activo arriesgado sobre la tasa libre de riesgo: $R^e = R - R_f$.
Por definición de la ecuación de Euler:
$$\mathbb{E}[m R] = 1 \quad \text{y} \quad \mathbb{E}[m R_f] = 1 \implies \mathbb{E}[m R^e] = 0$$

Por la definición de covarianza entre dos variables:
$$\operatorname{Cov}(m, R^e) = \mathbb{E}[m R^e] - \mathbb{E}[m] \mathbb{E}[R^e] = 0 - \mathbb{E}[m] \mathbb{E}[R^e] = -\mathbb{E}[m] \mathbb{E}[R^e]$$
Por lo tanto:
$$\mathbb{E}[R^e] = -\frac{\operatorname{Cov}(m, R^e)}{\mathbb{E}[m]}$$

Recordando que el coeficiente de correlación de Pearson $\rho_{m, R^e} = \frac{\operatorname{Cov}(m, R^e)}{\sigma(m) \sigma(R^e)}$ satisface estrictamente $|\rho_{m, R^e}| \le 1$:
$$|\operatorname{Cov}(m, R^e)| \le \sigma(m) \sigma(R^e)$$

Tomando el valor absoluto en la ecuación del exceso de retorno esperado:
$$|\mathbb{E}[R^e]| = \frac{|\operatorname{Cov}(m, R^e)|}{\mathbb{E}[m]} \le \frac{\sigma(m) \sigma(R^e)}{\mathbb{E}[m]}$$
Dividiendo ambos lados por $\sigma(R^e)$:
$$\frac{|\mathbb{E}[R^e]|}{\sigma(R^e)} \le \frac{\sigma(m)}{\mathbb{E}[m]}$$
Invirtiendo la desigualdad se obtiene la **cota de volatilidad de Hansen-Jagannathan**:
$$\frac{\sigma(m)}{\mathbb{E}[m]} \ge \frac{|\mathbb{E}[R^e]|}{\sigma(R^e)} = \text{Sharpe Ratio}$$
*Q.E.D.*

**Aplicación numérica y conexión con el Equity Premium Puzzle:**
- Datos: Ratio de Sharpe anualizado $= 0.40$, $\mathbb{E}[m] \approx 0.98$.
- Volatilidad mínima requerida del factor de descuento:
  $$\sigma(m) \ge 0.40 \times 0.98 \approx 0.392 \quad (39.2\% \text{ anual})$$
- Sin embargo, bajo utilidad CRRA, $m_{t+1} \approx \beta (1 - \gamma \Delta \ln C_{t+1})$. Por ende:
  $$\sigma(m) \approx \gamma \cdot \sigma(\Delta \ln C)$$
- En los datos empíricos de las cuentas nacionales de EE.UU., la desviación estándar del crecimiento del consumo real per cápita es $\sigma(\Delta \ln C) \approx 1.5\% = 0.015$.
- Para alcanzar $\sigma(m) \ge 0.392$:
  $$\gamma \ge \frac{0.392}{0.015} \approx 26.1$$
  (Y en estimaciones trimestrales o mensuales, $\gamma$ supera típicamente $50$ o $100$, como observamos en la replicación GMM con $\hat{\gamma} \approx 118$).
- Ningún ser humano plausible posee una aversión al riesgo de $\gamma > 25$ (un agente con $\gamma = 25$ preferiría perder el $99\%$ de su riqueza antes de arriesgar una moneda al aire que reduzca su consumo en un $20\%$). Este desfase matemático descubierto por Hansen y Singleton (1982) y Mehra y Prescott (1985) constituye el célebre **Equity Premium Puzzle**.

# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2019: Abhijit Banerjee, Esther Duflo y Michael Kremer

> **Nota confidencial para el profesor:** Este documento contiene el desarrollo matemático, analítico y econométrico formal de las actividades propuestas en `estudiante/ejercicios.qmd`. Mantener reservado para evaluación pedagógica y preparación de clases prácticas.

---

### Solución Ejercicio 1 (Cumplimiento Imperfecto, ITT vs. TOT)

#### (a) Estimador de Intención de Tratar (ITT)
- **Cálculo numérico:**
  $$\hat{\tau}_{\text{ITT}} = \mathbb{E}[Y | Z=1] - \mathbb{E}[Y | Z=0] = 0.750 - 0.688 = 0.062 \quad (+6.2 \text{ puntos porcentuales})$$
  *(En la regresión MCO con toda la muestra de microdatos, el coeficiente exacto es $\hat{\beta} \approx 0.0632$ o $+6.32 \text{ pp}$).*
- **Interpretación económica:** El ITT mide el efecto causal de **ofrecer o poner a disposición** el programa sobre la población elegible, promediando el efecto nulo de quienes no asistieron o no recibieron la dosis con el beneficio de quienes sí lo hicieron.

#### (b) Estimador del Efecto en los Tratados (TOT / LATE) vía Estimador de Wald
- **Fórmula de Wald:**
  $$\hat{\tau}_{\text{TOT}} = \frac{\mathbb{E}[Y | Z=1] - \mathbb{E}[Y | Z=0]}{\mathbb{E}[D | Z=1] - \mathbb{E}[D | Z=0]}$$
  Dado que en las escuelas de tratamiento el cumplimiento fue del $75\%$ ($0.75$) y en las de control del $0\%$ ($0.00$):
  $$\hat{\tau}_{\text{TOT}} = \frac{0.062}{0.75 - 0.00} = \frac{0.062}{0.75} \approx \mathbf{0.0827} \quad (+8.27 \text{ puntos porcentuales})$$
  *(En la estimación formal 2SLS con controles del Modelo 5, el estimador instrumental arroja $\hat{\beta}_{\text{2SLS}} = \mathbf{0.0864}$ con $SE = 0.0125$, $p < 0.001$).*
- **Interpretación:** Para un niño que efectivamente ingiere el fármaco antiparasitario, la probabilidad de asistencia escolar se incrementa en aproximadamente un $8.6\%$.

#### (c) ¿ITT o TOT para la Decisión Presupuestaria de Hacienda?
- Para el Ministro de Hacienda o la dirección de presupuesto, **el estimador clave de política pública es el ITT**:
  1. El gobierno debe financiar la logística, la compra de pastillas y las brigadas médicas para el $100\%$ de las escuelas asignadas, asumiendo inevitablemente los costos fijos aunque una fracción de los alumnos falte el día de distribución o sus familias rechacen la dosis.
  2. El retorno social agregado efectivo que el país experimentará en el sistema educativo viene dado por el ITT multiplicado por el total de niños elegibles.
  3. El TOT es indispensable para la farmacología y la medicina clínica (para saber si la molécula biológica funciona en el organismo humano), pero para la economía de las políticas públicas el parámetro operativo central es el ITT.

---

### Solución Ejercicio 2 (Aleatorización por Conglomerados y el Factor de Moulton)

#### (a) ¿Por qué no cambia el estimador puntual pero sí el error estándar?
- El estimador MCO de la pendiente $\hat{\beta} = (X'X)^{-1}X'y$ continúa siendo insesgado y consistente bajo asignación aleatoria, dado que $\mathbb{E}[\varepsilon_{is} | T_s] = 0$.
- Sin embargo, los errores individuales dentro de una misma escuela $s$ comparten factores comunes no observados (el director, la calidad de los docentes locales, la distancia a vías de transporte, la carga parasitaria ambiental):
  $$\varepsilon_{is} = \eta_s + u_{is}$$
  donde $\eta_s \sim (0, \sigma_{\eta}^2)$ es el shock específico de la escuela y $u_{is} \sim (0, \sigma_u^2)$ es el shock idiosincrático del alumno.
- Por tanto, la matriz de varianza-covarianza de las perturbaciones ya no es una matriz identidad escalada ($\Omega \ne \sigma^2 I_N$), sino una matriz diagonal por bloques. Al agregar $N = 29,457$ observaciones que en realidad provienen de solo $J = 75$ unidades independientes de asignación aleatoria, MCO clásico asume falsamente que cada observación aporta información independiente, subestimando drásticamente el error muestral.

#### (b) Cálculo del Coeficiente de Correlación Intraclase ($\rho$)
- De acuerdo con la fórmula asintótica de Moulton (1986):
  $$\frac{V(\hat{\beta}_{\text{Cluster}})}{V(\hat{\beta}_{\text{OLS}})} = \left(\frac{\text{SE}_{\text{Cluster}}}{\text{SE}_{\text{OLS}}}\right)^2 \approx 1 + (\bar{m} - 1)\rho$$
- Sustituyendo los valores del laboratorio:
  $$\left(\frac{0.0106}{0.0057}\right)^2 \approx (1.8596)^2 \approx 3.458$$
  $$1 + (393 - 1)\rho = 3.458 \implies 392 \cdot \rho = 2.458 \implies \rho = \frac{2.458}{392} \approx \mathbf{0.00627} \quad (\approx 0.63\%)$$
- **Lección docente central:** Una correlación intraclase extraordinariamente baja ($\rho < 1\%$) es suficiente para **más que triplicar la varianza muestral** y casi duplicar el error estándar cuando el tamaño del conglomerado es grande ($\bar{m} \approx 400$).

#### (c) Riesgo de Error Tipo I
- Ignorar la estructura de conglomerados genera una inflación artificial extrema de los estadísticos $t$ (de $t = 5.96$ a $t = 11.18$).
- En investigaciones donde el efecto verdadero es débil o nulo, los intervalos de confianza ingenuos serán artificialmente estrechos, induciendo un grave **Error Tipo I** (rechazar erróneamente la hipótesis nula de ausencia de efecto). En simulaciones de Monte Carlo, un test con nivel nominal del $\alpha = 5\%$ puede llegar a rechazar la hipótesis nula en más del $40\%$ o $50\%$ de los casos si se omite la corrección por clusters de Moulton.

---

### Solución Ejercicio 3 (Violación de SUTVA y Externalidades Espaciales)

#### 1. Justificación Biológica y Demostración del Sesgo
- **Mecanismo epidemiológico:** Los parásitos intestinales se transmiten por vía fecal-oral o por penetración cutánea de larvas en aguas estancadas. Los niños tratados en escuelas del Grupo 1 dejan de excretar miles de huevos diarios al entorno. Por consiguiente, los ríos, pozas y senderos utilizados conjuntamente por niños de escuelas vecinas (incluso las asignadas al grupo de control) quedan libres de larvas infecciosas, rompiendo la cadena de reinfección comunitaria.
- **Demostración del sesgo por atenuación:**
  - Denotemos por $Y_i(d, W)$ el resultado potencial del niño $i$ bajo su tratamiento propio $d \in \{0, 1\}$ y el entorno de tratamiento vecinal $W \in \{0, 1\}$.
  - El verdadero contrafactual sin programa en la región es $\mathbb{E}[Y_i(0, 0)]$.
  - En presencia de externalidades positivas ($W=1$ en la vecindad):
    $$\mathbb{E}[Y | T=0, W=1] = \mathbb{E}[Y_i(0, 1)] > \mathbb{E}[Y_i(0, 0)]$$
  - La diferencia observada ingenua es:
    $$\tau_{\text{ingenuo}} = \mathbb{E}[Y | T=1] - \mathbb{E}[Y | T=0] = \mathbb{E}[Y_i(1, W)] - \mathbb{E}[Y_i(0, 1)] < \mathbb{E}[Y_i(1, W)] - \mathbb{E}[Y_i(0, 0)]$$
  - Por lo tanto, el evaluador que ignora las externalidades comete un sesgo negativo (*atenuación*): **atribuye menor eficacia al programa de la que realmente genera sobre la sociedad**.

#### 2. Modelación Econométrica y Beneficio Social Agregado
- **¿Por qué controlar por $N^{\text{Tot}}_{3\text{km}}$?**
  - En zonas geográficas con mayor densidad poblacional o cercanía a centros urbanos rurales, el número absoluto de escuelas y alumnos es naturalmente mayor.
  - La densidad se correlaciona con la cercanía a caminos pavimentados, mercados y centros de salud, los cuales afectan directamente la asistencia escolar.
  - Al incluir el número total de alumnos a 3 km ($N^{\text{Tot}}_{3\text{km}}$), el coeficiente de los alumnos tratados ($N^T_{3\text{km}}$) queda puramente identificado por la **proporción asignada aleatoriamente** por el experimento en la vecindad, garantizando la exogeneidad del spillover.
- **Cálculo del Impacto Total Esperado:**
  $$\Delta \text{Asistencia} = \hat{\beta}_1 \cdot (1) + \hat{\beta}_2 \cdot \left(\frac{2000}{1000}\right) = 0.0611 + 0.0340 \times 2 = 0.0611 + 0.0680 = \mathbf{0.1291} \quad (+12.91 \text{ pp})$$
  - El efecto directo en su propia escuela aporta $+6.11$ puntos porcentuales.
  - La externalidad comunitaria de tener 2,000 niños tratados alrededor aporta $+6.80$ puntos porcentuales adicionales.
  - **Conclusión de política:** La externalidad espacial duplica el impacto total del programa. Esto justifica plenamente el financiamiento con subsidio público al 100%, ya que el beneficio social supera con creces el beneficio privado individual percibido por cada familia.

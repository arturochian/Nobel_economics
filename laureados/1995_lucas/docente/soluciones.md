# Soluciones y Pautas de Evaluación (Docente)
## Laureado 1995: Robert E. Lucas Jr.

> **Nota pedagógica confidencial para el profesor:** Este documento contiene las derivaciones matemáticas analíticas completas, demostraciones estadísticas, cálculos numéricos paso a paso, interpretaciones pedagógicas y rúbricas de corrección para los ejercicios presentados en `estudiante/ejercicios.qmd`.

---

### Solución Ejercicio 1 (Extracción de Señal y la Hipótesis de Varianza de Lucas)

#### 1. Derivación de la Proyección Lineal y Coeficiente $\theta$:
- El precio local es $p_{it} = p_t + z_{it}$, donde $p_t \sim \mathcal{N}(\bar{p}, \sigma_p^2)$ y $z_{it} \sim \mathcal{N}(0, \sigma_z^2)$, con $\text{Cov}(p_t, z_{it}) = 0$.
- El vector $(p_t, p_{it})'$ sigue una distribución normal bivariada:
  $$\begin{pmatrix} p_t \\ p_{it} \end{pmatrix} \sim \mathcal{N}\left( \begin{pmatrix} \bar{p} \\ \bar{p} \end{pmatrix}, \begin{pmatrix} \sigma_p^2 & \sigma_p^2 \\ \sigma_p^2 & \sigma_p^2 + \sigma_z^2 \end{pmatrix} \right)$$
  puesto que $\text{Cov}(p_t, p_{it}) = \text{Cov}(p_t, p_t + z_{it}) = \text{Var}(p_t) = \sigma_p^2$.
- Por el teorema de la distribución normal condicional (o proyección lineal MCO):
  $$\mathbb{E}[p_t \mid p_{it}] = \mathbb{E}[p_t] + \frac{\text{Cov}(p_t, p_{it})}{\text{Var}(p_{it})} (p_{it} - \mathbb{E}[p_{it}]) = \bar{p} + \frac{\sigma_p^2}{\sigma_p^2 + \sigma_z^2} (p_{it} - \bar{p})$$
- El precio relativo percibido por el productor en la isla $i$ es:
  $$r_{it}^{percebido} = p_{it} - \mathbb{E}[p_t \mid p_{it}] = (p_{it} - \bar{p}) - \frac{\sigma_p^2}{\sigma_p^2 + \sigma_z^2}(p_{it} - \bar{p}) = \left( 1 - \frac{\sigma_p^2}{\sigma_p^2 + \sigma_z^2} \right) (p_{it} - \bar{p})$$
  $$r_{it}^{percebido} = \frac{\sigma_z^2}{\sigma_z^2 + \sigma_p^2} (p_{it} - \bar{p}) = \theta (p_{it} - \bar{p})$$
  donde definimos el **coeficiente de extracción de señal de Lucas** como:
  $$\theta \equiv \frac{\sigma_z^2}{\sigma_z^2 + \sigma_p^2} \in (0, 1)$$

#### 2. Oferta Agregada y Pendiente de la Curva de Phillips:
- La oferta de la isla $i$ es:
  $$y_{it} = y_n + \gamma r_{it}^{percebido} = y_n + \gamma \theta (p_{it} - \bar{p})$$
- Agregando e integrando sobre el continuo de todas las islas $i \in [0, 1]$:
  $$y_t = \int_0^1 y_{it} di = y_n + \gamma \theta \left( \int_0^1 p_{it} di - \bar{p} \right)$$
- Como $p_{it} = p_t + z_{it}$ y por la ley de grandes números $\int_0^1 z_{it} di = \mathbb{E}[z_{it}] = 0$, el precio medio observado en la economía es $\int_0^1 p_{it} di = p_t$.
- Por tanto:
  $$y_t = y_n + \gamma \theta (p_t - \bar{p}) = y_n + \alpha(\sigma_p) (p_t - \bar{p})$$
  donde la pendiente de la curva de Phillips agregada es:
  $$\alpha(\sigma_p) = \gamma \theta = \gamma \frac{\sigma_z^2}{\sigma_z^2 + \sigma_p^2}$$

#### 3. Calibración Numérica e Interpretación Económica:
- Parámetros dados: $\sigma_z^2 = 4.0$ ($\sigma_z = 2.0$), $\gamma = 1.0$.
  - **País A (Baja volatilidad, ej. EE.UU. años 60):**
    $\sigma_p = 0.5 \implies \sigma_p^2 = 0.25$.
    $$\theta_A = \frac{4.0}{4.0 + 0.25} = \frac{4.0}{4.25} \approx 0.9412$$
    $$\alpha_A = 1.0 \times 0.9412 = 0.9412$$
  - **País B (Volatilidad moderada, ej. Italia años 70):**
    $\sigma_p = 2.0 \implies \sigma_p^2 = 4.0$.
    $$\theta_B = \frac{4.0}{4.0 + 4.0} = \frac{4.0}{8.0} = 0.5000$$
    $$\alpha_B = 1.0 \times 0.5000 = 0.5000$$
  - **País C (Alta volatilidad, ej. Argentina años 80):**
    $\sigma_p = 6.0 \implies \sigma_p^2 = 36.0$.
    $$\theta_C = \frac{4.0}{4.0 + 36.0} = \frac{4.0}{40.0} = 0.1000$$
    $$\alpha_C = 1.0 \times 0.1000 = 0.1000$$
- **Interpretación Pedagógica:**
  En un país de alta inflación e inestabilidad monetaria (Argentina), cuando un comerciante o fabricante observa que el precio de su producto sube $10\%$, sabe por experiencia estadística que la probabilidad de que se trate de inflación general es abrumadora ($90\%$). En consecuencia, no contrata más trabajadores ni amplía su planta ($\theta = 0.10$). Por el contrario, en Alemania o EE.UU. con inflación anclada al $2\%$, si un precio sube $10\%$, el productor infiere que hay una demanda real vigorosa por su producto específico y expande su producción ($\theta = 0.94$). Esto explica por qué el intento de los bancos centrales de explotar la curva de Phillips destruye su propia efectividad al incrementar la volatilidad nominal.

---

### Solución Ejercicio 2 (La Crítica de Lucas y la Inestabilidad Econométrica)

#### 1. Formación de Expectativas Racionales:
- Regla de política del banco central:
  $$\pi_t = \mu + \rho \pi_{t-1} + v_t, \quad v_t \sim \text{iid}\mathcal{N}(0, \sigma_v^2)$$
- Bajo expectativas racionales, utilizando el conjunto de información disponible en $t-1$ ($\mathcal{I}_{t-1} = \{\pi_{t-1}, \pi_{t-2}, \dots\}$):
  $$\mathbb{E}_{t-1}[\pi_t] = \mathbb{E}[\mu + \rho \pi_{t-1} + v_t \mid \mathcal{I}_{t-1}] = \mu + \rho \pi_{t-1}$$
  puesto que $\mathbb{E}[v_t \mid \mathcal{I}_{t-1}] = 0$.
- La sorpresa inflacionaria es:
  $$\pi_t - \mathbb{E}_{t-1}[\pi_t] = (\mu + \rho \pi_{t-1} + v_t) - (\mu + \rho \pi_{t-1}) = v_t$$
- Sustituyendo en la oferta estructural de Lucas:
  $$y_t = y_n + \beta v_t + \varepsilon_t$$
- El producto esperado incondicional es:
  $$\mathbb{E}[y_t] = \mathbb{E}[y_n + \beta v_t + \varepsilon_t] = y_n + \beta (0) + 0 = y_n$$
  Nótese que $\mathbb{E}[y_t] = y_n = 100$ no depende de $\mu$ ni de $\rho$. Ningún cambio sistemático y predecible en la regla de política monetaria puede modificar el nivel medio de producto.

#### 2. La Ilusión Econométrica Tradicional:
- Regresión de forma reducida: $y_t = a + b \pi_t + u_t$.
- El estimador MCO converge al ratio de covarianza sobre varianza poblacional:
  $$b = \frac{\text{Cov}(y_t, \pi_t)}{\text{Var}(\pi_t)}$$
- Calculamos el numerador:
  $$\text{Cov}(y_t, \pi_t) = \text{Cov}(y_n + \beta v_t + \varepsilon_t, \mu + \rho \pi_{t-1} + v_t)$$
  Como $v_t$ es independiente de $\pi_{t-1}$ y $\varepsilon_t$ es independiente de los shocks de demanda:
  $$\text{Cov}(y_t, \pi_t) = \text{Cov}(\beta v_t, v_t) = \beta \text{Var}(v_t) = \beta \sigma_v^2$$
- Calculamos el denominador para el proceso estacionario $\text{AR}(1)$ con $|\rho| < 1$:
  $$\text{Var}(\pi_t) = \frac{\sigma_v^2}{1 - \rho^2}$$
- Sustituyendo:
  $$b(\rho) = \frac{\beta \sigma_v^2}{\frac{\sigma_v^2}{1 - \rho^2}} = \beta (1 - \rho^2)$$
- **Conclusión errónea del econometrista tradicional:**
  Dado que en los datos históricos encuentra $b > 0$ estadísticamente significativo, el econometrista cree falsamente que $b$ es un parámetro estructural invariante (como una constante física). Cree que existe una "curva de transformación" que permite intercambiar inflación por mayor producto.

#### 3. Simulación del Cambio de Régimen (La Falacia de Política):
- **Régimen 1 (Histórico):** $\mu_1 = 2.0, \rho_1 = 0.25, \beta = 1.5$.
  $$b_1 = 1.5 \times (1 - 0.25^2) = 1.5 \times (1 - 0.0625) = 1.5 \times 0.9375 = 1.40625$$
  $$\bar{\pi}_1 = \frac{\mu_1}{1 - \rho_1} = \frac{2.0}{1 - 0.25} = \frac{2.0}{0.75} = 2.667\%$$
- **Régimen 2 (Intervención agresiva):** $\mu_2 = 12.0, \rho_2 = 0.85$.
  $$\bar{\pi}_2 = \frac{\mu_2}{1 - \rho_2} = \frac{12.0}{1 - 0.85} = \frac{12.0}{0.15} = 80.0\%$$
  La inflación media se incrementa en $\Delta \bar{\pi} = 80.0 - 2.667 = 77.333\%$.
- **Pronóstico falaz ingenuo:**
  $$\Delta y^{\text{ingenuo}} = b_1 \times \Delta \bar{\pi} = 1.40625 \times 77.333 \approx +108.75 \text{ puntos}$$
  El econometrista promete que el PIB pasará de $100$ a $208.75$.
- **Realidad bajo Expectativas Racionales:**
  Los agentes incorporan la nueva regla en sus expectativas. La sorpresa sigue siendo únicamente $v_t \sim (0, \sigma_v^2)$.
  $$\mathbb{E}[y_2] = y_n = 100$$
  El producto real medio no aumenta absolutamente nada: $\Delta y^{\text{real}} = 0$.
  El nuevo parámetro empírico estimado bajo el Régimen 2 converge a:
  $$b_2 = \beta (1 - \rho_2^2) = 1.5 \times (1 - 0.85^2) = 1.5 \times (1 - 0.7225) = 1.5 \times 0.2775 = 0.41625$$
  Si hay un shock no estacionario de transición, el parámetro empírico cae aún más cerca de $0$.
- **Esencia de la Crítica de Lucas:**
  Los parámetros de los modelos empíricos dependen de las políticas vigentes. No se puede predecir el efecto de un cambio de política económica asumiendo que los coeficientes estimados con políticas anteriores se mantendrán fijos.

---

### Solución Ejercicio 3 (Reto Avanzado: Crecimiento Endógeno y Paradoja de Lucas)

#### Parte A: El Modelo de Crecimiento con Capital Humano (Lucas 1988)

1. **Tasa de Crecimiento del Capital Humano:**
   - La ecuación diferencial de acumulación es $\dot{h}_t = \delta (1 - u_t) h_t$.
   - Dividiendo entre $h_t$, la tasa de crecimiento instantánea es:
     $$g_h \equiv \frac{\dot{h}_t}{h_t} = \delta (1 - u_t)$$
   - En una senda de crecimiento balanceado (BGP), la fracción de tiempo dedicada al estudio es constante ($u_t = u^*$), por lo que $g_h = \delta (1 - u^*)$ es constante.

2. **Tasa de Crecimiento del Producto ($g_y$):**
   - La función de producción es $Y_t = A K_t^\alpha (u^* h_t L_t)^{1-\alpha} h_t^\gamma$, pues en equilibrio agregado $h_{a,t} = h_t$.
   - Asumiendo que la fuerza laboral $L_t$ es constante (normalizada a 1):
     $$Y_t = A (u^*)^{1-\alpha} K_t^\alpha h_t^{1 - \alpha + \gamma}$$
   - Tomando logaritmos y derivando con respecto al tiempo:
     $$\frac{\dot{Y}_t}{Y_t} = \alpha \frac{\dot{K}_t}{K_t} + (1 - \alpha + \gamma) \frac{\dot{h}_t}{h_t}$$
   - En la BGP, el capital y el producto crecen a la misma tasa común ($g_k = g_y$ para mantener constante el ratio $K/Y$):
     $$g_y = \alpha g_y + (1 - \alpha + \gamma) g_h$$
     $$g_y (1 - \alpha) = (1 - \alpha + \gamma) g_h \implies g_y = \frac{1 - \alpha + \gamma}{1 - \alpha} g_h$$

3. **Implicación Teórica y de Política Pública:**
   - En el modelo neoclásico tradicional de Solow, el crecimiento per cápita cesa si no hay choques tecnológicos exógenos debido a rendimientos decrecientes. En el modelo de Lucas, los rendimientos a escala en los factores reproducibles ($K$ y $h$) son no decrecientes (especialmente cuando $\gamma > 0$), permitiendo un crecimiento per cápita permanente.
   - Puesto que $\gamma > 0$ representa un derrame o externalidad social que los individuos privados no internalizan al decidir cuánto tiempo estudiar ($u^*$), el equilibrio competitivo de mercado genera **subinversión en educación** en comparación con el óptimo del planificador social. Esto fundamenta teóricamente la necesidad de subsidios estatales a la educación, becas de investigación y fomento del capital humano.

---

#### Parte B: La Paradoja de Lucas (1990)

1. **Diferencial Neoclásico de Retornos al Capital:**
   - Función de producción intensiva: $y = k^\alpha$ con $\alpha = 0.4$.
   - Producto marginal del capital:
     $$\text{PMK} = \frac{\partial y}{\partial k} = \alpha k^{\alpha - 1}$$
   - Como $k = y^{1/\alpha}$, tenemos:
     $$\text{PMK} = \alpha (y^{1/\alpha})^{\alpha - 1} = \alpha y^{\frac{\alpha - 1}{\alpha}} = \alpha y^{-\frac{1-\alpha}{\alpha}}$$
   - Evaluando el ratio entre India y Estados Unidos dado $y_{US} / y_{IN} = 15$:
     $$\frac{\text{PMK}_{IN}}{\text{PMK}_{US}} = \left( \frac{y_{IN}}{y_{US}} \right)^{-\frac{1-\alpha}{\alpha}} = \left( \frac{y_{US}}{y_{IN}} \right)^{\frac{1-\alpha}{\alpha}} = (15)^{\frac{0.6}{0.4}} = 15^{1.5} \approx 58.09$$
   - *Predicción de la teoría neoclásica:* El capital en la India debería rendir un $5800\%$ más que en Estados Unidos. Si la tasa de interés en EE.UU. fuera del $5\%$, en la India debería ser cercana al $290\%$ anual. Por consiguiente, los capitales de todo el planeta deberían fluir masivamente hacia la India hasta que los stocks de capital por trabajador se equiparen. En la realidad, esto jamás ocurrió (la Paradoja de Lucas).

2. **Resolución de la Paradoja:**
   - Incorporando capital humano ($h$):
     $$y = k^\alpha (h)^{1-\alpha} \implies \frac{y}{h} = \left( \frac{k}{h} \right)^\alpha \implies \tilde{y} = \tilde{k}^\alpha$$
     donde $\tilde{k} = k/h$ es el capital por unidad de trabajo efectivo.
     El producto marginal del capital pasa a ser:
     $$\text{PMK} = \alpha \tilde{k}^{\alpha - 1} = \alpha \left( \frac{y}{h} \right)^{-\frac{1-\alpha}{\alpha}}$$
     Si el trabajador estadounidense tiene $h_{US} / h_{IN} = 5$:
     $$\frac{\tilde{y}_{US}}{\tilde{y}_{IN}} = \frac{y_{US} / h_{US}}{y_{IN} / h_{IN}} = \frac{y_{US} / y_{IN}}{h_{US} / h_{IN}} = \frac{15}{5} = 3$$
     Recalculando el ratio de retornos al capital:
     $$\frac{\text{PMK}_{IN}}{\text{PMK}_{US}} = (3)^{1.5} \approx 5.19$$
     ¡La brecha se redujo drásticamente de $58.1$ a solo $5.2$!
   - Factores adicionales demostrados por Alfaro, Kalemli-Ozcan y Volosovych (2008):
     - **Riesgo institucional y derechos de propiedad:** La debilidad del estado de derecho, la corrupción y el riesgo de expropiación o congelamiento de activos actúan como un impuesto implícito severo sobre el rendimiento del capital foráneo.
     - **Asimetrías de información y desarrollo financiero:** Los mercados financieros subdesarrollados en países emergentes dificultan la canalización eficiente de liquidez internacional.
     - Una vez descontada la prima por riesgo institucional y el capital humano, el retorno ajustado por riesgo en las economías en desarrollo no es sustancialmente mayor que en los países avanzados, disipando la paradoja.

---

### Rúbrica de Calificación Sugerida

| Criterio | Puntos | Descripción de Desempeño |
| :--- | :---: | :--- |
| **Ejercicio 1: Extracción de Señal** | 30% | Derivación correcta de la proyección lineal condicional (10 pts), deducción de la oferta agregada de Lucas (10 pts), calibración de los tres países e intuición de la hipótesis de varianza (10 pts). |
| **Ejercicio 2: Crítica de Lucas** | 35% | Cálculo de expectativas racionales y sorpresa monetaria (10 pts), derivación del estimador OLS $b = \beta(1-\rho^2)$ (10 pts), demostración cuantitativa del fracaso de la política y colapso del parámetro (15 pts). |
| **Ejercicio 3: Crecimiento y Paradoja** | 35% | Derivación de la BGP y tasas de crecimiento en el modelo de capital humano (15 pts), cálculo del ratio neoclásico 58:1 y resolución por trabajo efectivo y riesgo institucional (20 pts). |

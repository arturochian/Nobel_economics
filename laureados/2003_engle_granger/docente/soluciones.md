# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2003: Robert F. Engle III y Clive W. J. Granger

> **Nota pedagógica confidencial para el profesor:** Este documento contiene el desarrollo algebraico íntegro, cálculos numéricos paso a paso, derivaciones asintóticas y criterios de corrección para los ejercicios de `estudiante/ejercicios.qmd`. Prohibida su divulgación antes de la entrega formal.

---

### Solución Ejercicio 1 (Dinámica de Volatilidad ARCH/GARCH y Gestión de Riesgo)

#### 1. Condición de Estacionariedad y Varianza Incondicional:
- El modelo GARCH(1,1) es:
  $$\sigma_t^2 = \omega + \alpha r_{t-1}^2 + \beta \sigma_{t-1}^2$$
  con $\omega = 0.05$, $\alpha = 0.15$ y $\beta = 0.80$.
- **Condición de estacionariedad débil:** La varianza incondicional es finita y constante en el tiempo si y solo si:
  $$\alpha + \beta < 1$$
  En este caso: $\alpha + \beta = 0.15 + 0.80 = 0.95 < 1$. Por ende, el proceso es estrictamente estacionario de segundo orden con una alta persistencia de volatilidad ($0.95$).
- **Cálculo de la varianza incondicional $\sigma^2$:**
  Aplicando el operador de valor esperado a ambos lados:
  $$E[\sigma_t^2] = \omega + \alpha E[r_{t-1}^2] + \beta E[\sigma_{t-1}^2]$$
  Dado que $E[r_{t-1}^2] = E[E[r_{t-1}^2 \mid I_{t-2}]] = E[\sigma_{t-1}^2] = \sigma^2$:
  $$\sigma^2 = \omega + (\alpha + \beta)\sigma^2 \implies \sigma^2 = \frac{\omega}{1 - (\alpha + \beta)}$$
  $$\sigma^2 = \frac{0.05}{1 - 0.95} = \frac{0.05}{0.05} = 1.00 \quad (\%^2)$$
- **Desviación estándar incondicional diaria:** $\sigma = \sqrt{1.00} = 1.00\%$.
- **Desviación estándar anualizada (252 días de negociación):**
  $$\sigma_{anual} = \sigma_{diaria} \times \sqrt{252} = 1.00\% \times 15.8745 = 15.87\%$$

#### 2. Actualización Condicional de la Volatilidad tras el Shock:
- Datos del choque en $t-1$:
  - $\sigma_{t-1}^2 = \sigma^2 = 1.00$.
  - $r_{t-1} = -3.50\% \implies r_{t-1}^2 = (-3.50)^2 = 12.25$.
- Proyección de la varianza condicional para el día $t$:
  $$\sigma_t^2 = \omega + \alpha r_{t-1}^2 + \beta \sigma_{t-1}^2$$
  $$\sigma_t^2 = 0.05 + 0.15 \times (12.25) + 0.80 \times (1.00)$$
  $$\sigma_t^2 = 0.05 + 1.8375 + 0.80 = 2.6875 \quad (\%^2)$$
- **Desviación estándar condicional proyectada:**
  $$\sigma_t = \sqrt{2.6875} \approx 1.6394\%$$
  *Interpretación:* La volatilidad esperada se dispara en un $63.94\%$ de un día para otro debido al choque extremo, capturando fielmente el efecto de acumulación de volatilidad (*volatility clustering*).

#### 3. Cálculo del Valor en Riesgo (VaR) al 99% a 1 Día:
- Portafolio $V_0 = 10.000.000$ USD.
- Cuantil normal estándar para $99\%$ de confianza unilateral: $z_{0.99} = 2.326$.
- **a) Modelo Ingenuo de Volatilidad Constante (Incondicional):**
  $$\text{VaR}_{incondicional} = V_0 \times z_{0.99} \times \sigma = 10.000.000 \times 2.326 \times 0.0100 = 232.600 \text{ USD}$$
- **b) Modelo Dinámico GARCH (Varianza Condicional Actualizada):**
  $$\text{VaR}_{GARCH} = V_0 \times z_{0.99} \times \sigma_t = 10.000.000 \times 2.326 \times 0.016394 \approx 381.324 \text{ USD}$$
- **Discusión financiera:**
  - El modelo con volatilidad constante subestima la pérdida máxima probable en $148.724$ USD (un déficit de reservas de capital de casi el $39\%$).
  - Asumir varianza constante ignora que el mercado acaba de ingresar en un régimen turbulento. Esta deficiencia fue el origen de las masivas pérdidas de las entidades bancarias antes de las reformas de Basilea II y III inspiradas en la obra de Robert Engle.

---

### Solución Ejercicio 2 (De la Regresión Espuria a la Cointegración de Engle-Granger)

#### 1. Detección de Espuriedad y Regla de Granger-Newbold:
- **Anomalía:** $R^2 = 0.74 > DW = 0.18$.
  Granger y Newbold (1974) establecieron la regla heurística fundamental: si $R^2 > DW$, la regresión es casi con certeza **espuria**.
- **Fundamento del colapso de Durbin-Watson:**
  El estadístico Durbin-Watson se aproxima asintóticamente por $DW \approx 2(1 - \hat{\rho}_e)$, donde $\hat{\rho}_e$ es el coeficiente de autocorrelación de primer orden de los residuos $\hat{e}_t$.
  $$0.18 \approx 2(1 - \hat{\rho}_e) \implies 1 - \hat{\rho}_e = 0.09 \implies \hat{\rho}_e \approx 0.91$$
  Un $\hat{\rho}_e \approx 0.91$ extremadamente cercano a $1$ confirma que los residuos se comportan como un paseo aleatorio no estacionario $I(1)$. En consecuencia, la varianza de los residuos crece con $T$, invalidando los supuestos de Gauss-Markov y provocando que el estadístico $t$ diverja a infinito independientemente de que no exista vínculo causal real alguno entre las variables.

#### 2. Procedimiento Bipaso de Engle-Granger (1987):
- **Paso 1: Estimación de la relación estática de largo plazo.**
  Se estima por MCO en niveles: $Y_t = \beta_0 + \beta_1 X_t + e_t$. Se extraen los residuos estimados $\hat{e}_t = Y_t - \hat{\beta}_0 - \hat{\beta}_1 X_t$.
  Se realiza una prueba Dickey-Fuller Aumentada (ADF) sobre $\hat{e}_t$:
  $$\Delta \hat{e}_t = \delta \hat{e}_{t-1} + \sum_{i=1}^p \psi_i \Delta \hat{e}_{t-i} + \nu_t$$
  con $H_0: \delta = 0$ (raíz unitaria / no cointegración) vs. $H_1: \delta < 0$ (estacionariedad / cointegración).
- **Invalidez de las tablas estándar de Dickey-Fuller:**
  En una serie observada $Z_t$, los valores de la serie están fijos. Sin embargo, en el Paso 1, los estimadores $\hat{\beta}_0$ y $\hat{\beta}_1$ se calcularon explícitamente minimizando la suma de residuos al cuadrado $\sum \hat{e}_t^2$. Por construcción muestral, los residuos $\hat{e}_t$ lucen "más estacionarios" de lo que realmente son. Por lo tanto, la distribución del estadístico $t$ de $\delta$ se encuentra desplazada hacia la izquierda. Se deben utilizar los valores críticos corregidos de **Engle-Yoo (1987)** o **MacKinnon (1991)** (por ejemplo, valor crítico al 5% para dos variables es aprox. $-3.37$, sustancialmente más exigente que el $-2.86$ del ADF univariado sin tendencia).
- **Paso 2: Estimación del Modelo de Corrección de Error (VECM).**
  Si se rechaza la raíz unitaria en los residuos, se estima por MCO la dinámica de corto plazo:
  $$\Delta Y_t = c + \alpha \hat{e}_{t-1} + \sum_{j=1}^k \gamma_j \Delta Y_{t-j} + \sum_{l=0}^m \theta_l \Delta X_{t-l} + u_t$$
  Se verifica que $\alpha < 0$ con significancia estadística formal.

#### 3. Diferenciación Simple vs. Cointegración:
- Si ambas series están cointegradas y el analista estima simplemente $\Delta Y_t = \gamma_0 + \gamma_1 \Delta X_t + \epsilon_t$, el modelo incurre en un **sesgo por omisión de variable relevante**: omite el término de corrección de error $\alpha \hat{e}_{t-1}$.
- El modelo diferenciado captura únicamente oscilaciones de muy corto plazo (ruido de alta frecuencia) pero "olvida" por completo la atracción gravitatoria hacia el equilibrio de largo plazo, perdiendo toda capacidad predictiva en horizontes superiores a un periodo.

---

### Solución Ejercicio 3 (Modelos VECM y Arbitraje Cuantitativo de Pares)

#### 1. Mecanismo Gravitatorio y Velocidad de Ajuste:
- Ecuaciones del VECM con $z_{t-1} = \ln(P_{t-1}^B) - \ln(P_{t-1}^W) = +0.10$:
  $$\Delta \ln(P_t^B) = c_B - 0.30 \times (0.10) + \dots = c_B - 0.030$$
  $$\Delta \ln(P_t^W) = c_W + 0.20 \times (0.10) + \dots = c_W + 0.020$$
- **Interpretación económica:**
  - Para el Brent ($\alpha_B = -0.30 < 0$): Al estar relativamente "caro" ($z_{t-1} > 0$), su precio cae un $3.0\%$ en el periodo $t$ para corregir el desequilibrio.
  - Para el WTI ($\alpha_W = +0.20 > 0$): Al estar relativamente "barato", su precio se incrementa un $2.0\%$ en el periodo $t$.
- **Evolución dinámica del diferencial $z_t$:**
  Restando ambas ecuaciones:
  $$\Delta z_t = \Delta \ln(P_t^B) - \Delta \ln(P_t^W) = (\alpha_B - \alpha_W) z_{t-1} = (-0.30 - 0.20) z_{t-1} = -0.50 z_{t-1}$$
  Dado que $\Delta z_t = z_t - z_{t-1}$:
  $$z_t - z_{t-1} = -0.50 z_{t-1} \implies z_t = 0.50 z_{t-1}$$
  El desvío se contrae a la mitad en cada periodo (vida media o *half-life* de 1 periodo), convergiendo exponencial y asintóticamente a cero:
  $$z_t = (0.50)^t z_0 \xrightarrow{t \to \infty} 0$$
  Esto demuestra formalmente la estabilidad global del equilibrio cointegrado.

#### 2. Exogeneidad Débil y Formación de Precios:
- Si $\alpha_W = 0$, el precio del WTI no reacciona ante los desequilibrios respecto al Brent ($\Delta \ln(P_t^W)$ no depende de $z_{t-1}$).
- En la terminología econométrica de Engle, Hendry y Richard (1983), el WTI es **débilmente exógeno** respecto a los parámetros de cointegración de largo plazo.
- En términos de microestructura de mercado, todo el esfuerzo de corrección recae sobre el Brent ($\alpha_B = -0.50$). El mercado WTI opera como el líder dominante de descubrimiento de precios (*price discovery leader*), mientras que el Brent actúa como seguidor que debe ajustarse pasivamente.

#### 3. Regla Cuantitativa de Inversión (Pairs Trading):
- **Estrategia basada en Z-Score del término de corrección de error:**
  Se calcula el residuo normalizado:
  $$S_t = \frac{z_t - \mu_z}{\sigma_z}$$
  - **Señal de Venta en Corto del Spread ($S_t > +2$):** El Brent está anormalmente sobrevalorado relativo al WTI. Vender en corto contratos de Brent y comprar en largo contratos de WTI en montos ponderados por el vector de cointegración (estrategia de retorno absoluto neutral al mercado general del petróleo).
  - **Señal de Compra del Spread ($S_t < -2$):** El Brent está subvalorado relativo al WTI. Comprar Brent y vender en corto WTI.
  - **Cierre de Posiciones / Toma de Ganancias:** Deshacer las posiciones cuando $S_t$ retorna a su media de equilibrio ($|S_t| \le 0.2$).
  - **Stop-Loss Cuantitativo:** Liquidar forzosamente si $|S_t| > 4$, indicativo de un posible quiebre estructural de cointegración (cambio permanente en la calidad de crudos o rutas de transporte).

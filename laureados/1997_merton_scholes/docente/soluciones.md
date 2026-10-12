# Pautas Docentes y Solucionario: Modelo Black-Scholes-Merton (1997)

> **Premio Nobel de Economía 1997:** Robert C. Merton y Myron S. Scholes (con Fischer Black *in memoriam*).  
> **Área temática:** Economía Financiera Cuantitativa / Derivados y Gestión de Riesgos.  
> **Audiencia:** Cursos avanzados de pregrado y posgrado en Finanzas Cuantitativas, Economía Financiera y Macro-Finanzas.

---

## 1. Orientación Pedagógica para el Profesor

El modelo Black-Scholes-Merton (BSM) suele presentarse como una fórmula memorística. El propósito de este módulo es desmitificar la fórmula y transmitir las **tres intuiciones económicas fundamentales**:

1. **La magia de la ausencia de arbitraje:** El retorno esperado $\mu$ del activo no aparece en la fórmula. No importa cuán optimista o pesimista sea un operador sobre la acción; el precio de la opción está anclado únicamente por el costo de mantener la cartera de cobertura libre de riesgo.
2. **Cobertura dinámica (Delta Hedging):** La cobertura no es una transacción estática. Requiere ajustes continuos guiados por Delta y limitados por Gamma y los costos de transacción.
3. **El enfoque de opciones contingentes (Merton 1974):** La teoría de derivados trasciende a las opciones financieras bursátiles: es una poderosa teoría de la estructura de capital corporativo, el riesgo crediticio bancario y las garantías soberanas.

---

## 2. Solucionario Detallado de la Guía de Ejercicios

### Ejercicio 1: Valoración Manual y Paridad Put-Call (Nivel Básico)

**Datos:** $S_0 = 100, K = 100, r = 0.05, q = 0, \sigma = 0.20, T = 0.5$ años.

#### Pregunta 1: Parámetros estandarizados
$$\sigma \sqrt{T} = 0.20 \times \sqrt{0.5} = 0.20 \times 0.707107 = 0.141421$$

$$d_1 = \frac{\ln(100 / 100) + \left(0.05 + \frac{1}{2}(0.20)^2\right)(0.5)}{0.141421} = \frac{0 + (0.05 + 0.02)(0.5)}{0.141421} = \frac{0.035}{0.141421} \approx \mathbf{0.2475}$$

$$d_2 = d_1 - \sigma \sqrt{T} = 0.247487 - 0.141421 \approx \mathbf{0.1061}$$

Consultando la tabla de distribución normal estándar acumulada:
$$\mathcal{N}(d_1) = \mathcal{N}(0.2475) \approx \mathbf{0.5977}$$
$$\mathcal{N}(d_2) = \mathcal{N}(0.1061) \approx \mathbf{0.5422}$$

#### Pregunta 2: Precio del Call Europeo
Factor de descuento: $e^{-r T} = e^{-0.05 \times 0.5} = e^{-0.025} \approx 0.975310$.

$$C = S_0 \mathcal{N}(d_1) - K e^{-r T} \mathcal{N}(d_2)$$
$$C = 100 \times 0.597735 - 100 \times 0.975310 \times 0.542235$$
$$C = 59.7735 - 52.8848 = \mathbf{\$6.8887} \approx \mathbf{\$6.89}$$

#### Pregunta 3: Paridad Put-Call y Precio del Put
Por no arbitraje:
$$C - P = S_0 - K e^{-r T}$$
$$P = C - S_0 + K e^{-r T} = 6.8887 - 100 + 100(0.975310) = 6.8887 - 100 + 97.5310 = \mathbf{\$4.4197} \approx \mathbf{\$4.42}$$

**Comprobación directa:**
$$\mathcal{N}(-d_1) = 1 - 0.597735 = 0.402265$$
$$\mathcal{N}(-d_2) = 1 - 0.542235 = 0.457765$$
$$P = 100(0.975310)(0.457765) - 100(0.402265) = 44.6462 - 40.2265 = \mathbf{\$4.4197}$$
*El resultado coincide exactamente.*

#### Pregunta 4: Intuición Financiera
A pesar de que $S_0 = K = 100$, el Call ($\$6.89$) vale sustancialmente más que el Put ($\$4.42$). La razón estriba en el **valor temporal del dinero** ($r > 0$):
- Comprar un Call otorga el derecho de adquirir la acción en el futuro pagando el strike diferido $K$. El inversor ahorra el costo de oportunidad de los fondos durante 6 meses, invirtiendo el capital a la tasa libre de riesgo.
- En cambio, poseer un Put otorga el derecho de vender y cobrar $K$ recién en 6 meses, sufriendo una pérdida de valor presente en el efectivo a recibir ($K e^{-r T} = \$97.53 < \$100$).
- En equilibrio sin dividendos, $C - P = S_0 - K e^{-r T} = 100 - 97.53 = +\$2.47 > 0$.

---

### Ejercicio 2: Cobertura Dinámica (Delta-Hedging) y Riesgo de Curvatura (Nivel Intermedio)

#### Pregunta 1: Ratio de Cobertura Delta y Posición Inicial
- Delta unitario del Call: $\Delta = \mathcal{N}(d_1) = 0.597735$.
- La entidad bancaria vendió $10,000 \times 100 = 1,000,000$ de opciones. Su posición en derivados es corta:
  $$\Delta_{\text{opciones}} = -1,000,000 \times 0.597735 = \mathbf{-597,735} \text{ acciones}$$
- Para que la cartera combinada sea Delta-neutral ($\Delta_{\text{cartera}} = \Delta_{\text{opciones}} + N_{\text{acciones}} = 0$):
  $$N_{\text{acciones}} = +\mathbf{597,735} \text{ acciones}$$
  **El operador debe comprar inmediatamente 597,735 acciones en el mercado al contado a $\$100$.**

#### Pregunta 2: Rebalanceo ante Movimiento del Subyacente
El precio del subyacente sube a $S = \$105$.
- Nuevo $d_1$:
  $$d_1^{\text{nuevo}} = \frac{\ln(105/100) + 0.035}{0.141421} = \frac{0.048790 + 0.035}{0.141421} \approx 0.5925$$
- Nuevo Delta unitario: $\Delta^{\text{nuevo}} = \mathcal{N}(0.5925) \approx \mathbf{0.7232}$.
- La nueva exposición corta de las opciones es:
  $$\Delta_{\text{opciones}}^{\text{nuevo}} = -1,000,000 \times 0.723237 = -723,237 \text{ acciones}$$
- El operador posee actualmente $+597,735$ acciones. El desfase neto es:
  $$\Delta_{\text{neto}} = +597,735 - 723,237 = -125,502 \text{ acciones}$$
- **Acción requerida:** Para restaurar la neutralidad de Delta, el operador debe **comprar 125,502 acciones adicionales al nuevo precio más alto de $\$105$**.
- **Intuición de Gamma negativo:** Quien vende opciones tiene Gamma negativo ($\Gamma < 0$). Esto lo obliga sistemáticamente a comprar activos cuando el precio sube y a vender activos cuando el precio baja (*buy high, sell low*). Esta sangría por rebalanceo se compensa en ausencia de saltos con el cobro del paso del tiempo ($\Theta > 0$).

#### Pregunta 3: El Papel de Vega
- Una posición corta en opciones tiene **Vega negativo** ($\nu < 0$).
- Si la volatilidad implícita se dispara del $20\%$ al $25\%$, el valor teórico de la opción de compra aumenta significativamente.
- En consecuencia, la posición corta del banco sufrirá una **pérdida no realizada inmediata** por aumento en el pasivo de las opciones emitidas, antes de cualquier rebalanceo de mercado.

---

### Ejercicio 3: El Modelo Estructural de Deuda de Merton (Nivel Reto)

**Datos:** $V_0 = \$500$M, $D = \$400$M, $r = 0.04$, $\sigma_V = 0.30$, $T = 3$ años.

#### Pregunta 1: Valoración del Capital Accionario ($E_0$)
$$\sigma_V \sqrt{T} = 0.30 \times \sqrt{3} = 0.30 \times 1.732051 = 0.519615$$
$$d_1 = \frac{\ln(500 / 400) + \left(0.04 + \frac{1}{2}(0.30)^2\right)(3)}{0.519615} = \frac{0.223144 + (0.04 + 0.045)(3)}{0.519615} = \frac{0.223144 + 0.255}{0.519615} = \frac{0.478144}{0.519615} \approx \mathbf{0.9202}$$
$$d_2 = d_1 - \sigma_V \sqrt{T} = 0.920188 - 0.519615 \approx \mathbf{0.4006}$$

$$\mathcal{N}(d_1) = \mathcal{N}(0.9202) \approx \mathbf{0.8212}, \quad \mathcal{N}(d_2) = \mathcal{N}(0.4006) \approx \mathbf{0.6556}$$

Factor de descuento: $e^{-0.04 \times 3} = e^{-0.12} \approx 0.886920$.
$$E_0 = V_0 \mathcal{N}(d_1) - D e^{-r T} \mathcal{N}(d_2)$$
$$E_0 = 500(0.821245) - 400(0.886920)(0.655642) = 410.6225 - 232.5887 = \mathbf{\$178.03} \text{ millones}$$

#### Pregunta 2: Valoración de la Deuda Riesgosa ($B_0$) y Spread de Crédito
- Valor de mercado de la deuda riesgosa:
  $$B_0 = V_0 - E_0 = 500 - 178.0338 = \mathbf{\$321.97} \text{ millones}$$
- Valor si fuese libre de riesgo:
  $$B_{\text{rf}} = D e^{-r T} = 400 \times e^{-0.12} = \mathbf{\$354.77} \text{ millones}$$
- Rendimiento al vencimiento ($y$):
  $$y = -\frac{1}{3} \ln\left( \frac{321.9662}{400} \right) = -\frac{1}{3} \ln(0.804916) = -\frac{1}{3} (-0.217018) \approx \mathbf{0.07234} \quad (7.23\%)$$
- **Spread crediticio:**
  $$\text{Spread} = y - r = 0.07234 - 0.0400 = 0.03234 \quad \to \quad \mathbf{323.4} \text{ puntos básicos (bps)}$$

#### Pregunta 3: Probabilidad de Quiebra y Sustitución de Activos
- Probabilidad neutral al riesgo de quiebra:
  $$\mathbb{Q}(\text{Default}) = \mathcal{N}(-d_2) = 1 - 0.655633 = \mathbf{0.3444} \quad (34.4\%)$$
- **Impacto de aumentar la volatilidad a $\sigma_V = 45\%$:**
  Resolviendo con $\sigma_V = 0.45$:
  - $E_0$ pasa de $\$178.03$M a **$\$213.83$M** (los accionistas ganan $+\$35.8$M).
  - $B_0$ cae de $\$321.97$M a **$\$286.17$M** (los acreedores pierden $-\$35.8$M).
  - El spread salta de $323$ bps a **$716$ bps**.
  - La probabilidad de quiebra sube de $34.4\%$ a **$48.0\%$**.
- **Mecanismo de Sustitución de Activos (*Risk Shifting*):**
  Como el capital accionario es una opción de compra, su función de pago es asimétrica y convexa ($\max(V_T - D, 0)$). Los accionistas capturan todo el beneficio si el megaproyecto resulta extraordinario, mientras que las pérdidas en caso de fracaso son absorbidas por los acreedores debido a la responsabilidad limitada. Esto incentiva a empresas sobreendeudadas a tomar riesgos excesivos a expensas de los bonistas.

---

## 3. Discusión Conceptual en Clase

### 1. ¿Por qué no aparece la rentabilidad esperada $\mu$?
Porque una opción no es un activo independiente; es un derivado redundante cuyo riesgo puede ser replicado exactamente combinando el subyacente y un bono libre de riesgo. Si el precio de la opción se desviara del valor dado por BSM en función de opiniones optimistas o pesimistas sobre $\mu$, surgiría una oportunidad de **arbitraje puro** (ganancia infinita y sin riesgo).

### 2. Lecciones del Colapso de LTCM (1998)
- **Supuesto de liquidez perfecta:** Los modelos asumían que siempre sería posible comprar o vender cantidades masivas al precio de mercado sin afectarlo. En agosto de 1998, los mercados se congelaron por completo.
- **Riesgo de cola no gaussiano:** Las distribuciones reales tienen colas pesadas (*leptocurtosis*) y saltos discretos; los movimientos de 4 o 5 desviaciones estándar ocurren con una frecuencia órdenes de magnitud superior a la campana de Gauss.
- **Apalancamiento excesivo:** Una ventaja teórica minúscula no tolera horizontes adversos cuando la firma está endeudada a razones de 25:1.

# Guía Docente y Solucionario: James Tobin (Nobel 1981)

> **Material de uso pedagógico exclusivo para el profesorado.**  
> Este documento contiene el solucionario analítico riguroso paso a paso, comentarios conceptuales y rúbricas de evaluación para los ejercicios presentados en `laureados/1981_tobin/estudiante/ejercicios.qmd`.

---

## 1. Pautas Pedagógicas y Contexto Teórico

### El legado intelectual de James Tobin
James Tobin (1918–2002) construyó el andamiaje que conecta los mercados monetarios y financieros con la economía real. Al impartir este módulo, se sugiere enfatizar tres ejes formativos:

1. **La q de Tobin como eslabón macrofinanciero:**  
   En la macroeconomía tradicional previa a Tobin, la política monetaria influía en la inversión a través de una única tasa de interés de bonos en el modelo IS-LM. Tobin demostró que lo que determina las decisiones de inversión corporativa no es el costo del crédito aislado, sino el valor relativo del capital instalado frente a su costo de reposición física en la economía real ($q = V / p_K K$). Esta visión integra la bolsa de valores, la banca, la deuda corporativa y la política monetaria en un marco unificado de equilibrio general de activos.
2. **El Teorema de Separación de Dos Fondos y la microfundamentación de la liquidez:**  
   Tobin depuró la teoría keynesiana de la trampa de liquidez y el motivo especulación. Al demostrar que la diversificación y la aversión al riesgo explican por qué los agentes eligen retener dinero seguro frente a una cartera diversificada de activos riesgosos, sentó las bases directas del modelo CAPM de Sharpe (1964). Enfatice a los estudiantes que la separación entre "qué activos de riesgo comprar" y "cuánto riesgo tolerar" es la columna vertebral de la moderna industria de gestión de carteras y fondos mutuos.
3. **Econometría aplicada con variables censuradas (Tobit):**  
   Tobin abrió la puerta a la microeconometría moderna al advertir que los datos económicos reales están llenos de decisiones de esquina (compras nulas, horas trabajadas cero, importaciones cero). Forzar una regresión lineal sobre datos acotados distorsiona las estimaciones de elasticidades y recomendaciones de política pública.

---

## 2. Solución Detallada del Ejercicio 1 (Nivel Básico)

### Pregunta 1: Cálculo del Valor de la Empresa y la q de Tobin

- **Capitalización bursátil ($E$):**
  $$E = 50.000.000 \times 24 = 1.200.000.000 \text{ USD} \quad (1.200 \text{ millones})$$
- **Valor de mercado de la deuda financiera ($D$):**
  $$D = 400.000.000 \text{ USD} \quad (400 \text{ millones})$$
- **Caja y activos líquidos disponibles ($C$):**
  $$C = 100.000.000 \text{ USD} \quad (100 \text{ millones})$$
- **Valor total de mercado de los activos operativos de la firma ($V$):**
  $$V = E + D - C = 1.200.000.000 + 400.000.000 - 100.000.000 = 1.500.000.000 \text{ USD} \quad (1.500 \text{ millones})$$
  *(Nota docente: si el estudiante utiliza el valor bruto de mercado de los pasivos $V = E + D = 1.600$ millones, $q = 1,60$. Ambas convenciones son válidas en la literatura siempre que se justifique explícitamente el tratamiento de la caja).*
- **Costo de reposición del capital físico ($p_K K$):**
  $$p_K K = 1.000.000.000 \text{ USD} \quad (1.000 \text{ millones})$$
- **Cálculo de la $q$ de Tobin media:**
  $$q = \frac{V}{p_K K} = \frac{1.500.000.000}{1.000.000.000} = 1,50$$

*Interpretación económica:*  
Como $q = 1,50 > 1$, el mercado financiero atribuye a los activos instalados de la empresa una valoración un $50\%$ superior a lo que costaría construirlos o adquirirlos nuevos en el mercado de bienes de capital. La empresa se encuentra en una **zona clara de estímulo a la formación bruta de capital**: tiene un incentivo rentable para emitir acciones o endeudarse y destinar esos fondos a la adquisición de maquinaria y plantas productivas.

---

### Pregunta 2: Determinación de la Tasa de Inversión Óptima

- **Regla óptima de inversión con costos cuadráticos de ajuste:**
  $$\frac{I}{K} = \delta + \frac{1}{\chi}(q - 1)$$
- **Sustitución de parámetros ($\delta = 0,08$, $\chi = 10$, $q = 1,50$):**
  $$\frac{I}{K} = 0,08 + \frac{1}{10}(1,50 - 1) = 0,08 + \frac{0,50}{10} = 0,08 + 0,05 = 0,13 \quad (13\% \text{ anual})$$
- **Tasa de inversión neta:**
  $$\frac{I_{\text{neta}}}{K} = \frac{I}{K} - \delta = 0,13 - 0,08 = 0,05 \quad (5\% \text{ de crecimiento neto anual del stock de capital})$$
- **Gasto monetario total en inversión anual ($I$):**
  $$I = 0,13 \times 1.000.000.000 = 130.000.000 \text{ USD al año} \quad (130 \text{ millones})$$
  Descompuesto en:
  - Reposición por depreciación: $0,08 \times 1.000.000.000 = 80.000.000$ USD.
  - Formación neta de nuevo capital: $0,05 \times 1.000.000.000 = 50.000.000$ USD.

---

### Pregunta 3: Análisis de Sensibilidad ante un Shock Bursátil

- **Nueva capitalización bursátil ($P = 14$ USD/acción):**
  $$E_{\text{nuevo}} = 50.000.000 \times 14 = 700.000.000 \text{ USD}$$
- **Nuevo valor de mercado de los activos de la firma ($V_{\text{nuevo}}$):**
  $$V_{\text{nuevo}} = 700.000.000 + 400.000.000 - 100.000.000 = 1.000.000.000 \text{ USD}$$
- **Nueva $q$ de Tobin:**
  $$q_{\text{nuevo}} = \frac{1.000.000.000}{1.000.000.000} = 1,00$$
- **Nueva tasa de inversión:**
  $$\frac{I_{\text{nuevo}}}{K} = 0,08 + \frac{1}{10}(1,00 - 1) = 0,08 + 0 = 0,08 \quad (8\% \text{ anual})$$
- **Inversión neta:**
  $$\frac{I_{\text{neta}}}{K} = 0,08 - 0,08 = 0\%$$
- **Impacto dinámico:**  
  La contracción bursátil elimina por completo el incentivo a la expansión corporativa. La empresa reduce su gasto anual en inversión de $130$ a $80$ millones de dólares. El stock de capital físico se estanca ($\dot{K} = 0$), limitándose a reponer el desgaste productivo. Si el precio bursátil cayese aún más por debajo de $14$ USD ($q < 1$), la inversión neta se volvería negativa y la empresa reduciría su tamaño mediante desinversión progresiva.

---

## 3. Solución Detallada del Ejercicio 2 (Nivel Intermedio)

### Pregunta 1: Matriz de Covarianzas
- Parámetros dados: $\sigma_A = 0,20$, $\sigma_B = 0,10$, $\rho_{AB} = 0,25$.
- Varianzas: $\sigma_A^2 = 0,20^2 = 0,04$, $\sigma_B^2 = 0,10^2 = 0,01$.
- Covarianza:
  $$\sigma_{AB} = \rho_{AB} \sigma_A \sigma_B = 0,25 \times 0,20 \times 0,10 = 0,005$$
- Matriz de covarianzas:
  $$\boldsymbol{\Sigma} = \begin{pmatrix} 0,04 & 0,005 \\ 0,005 & 0,01 \end{pmatrix}$$

---

### Pregunta 2: Deducción de la Cartera Tangente (Fase Técnica)

- Determinante de $\boldsymbol{\Sigma}$:
  $$\det(\boldsymbol{\Sigma}) = (0,04)(0,01) - (0,005)^2 = 0,0004 - 0,000025 = 0,000375$$
- Inversa de la matriz de covarianzas $\boldsymbol{\Sigma}^{-1}$:
  $$\boldsymbol{\Sigma}^{-1} = \frac{1}{0,000375} \begin{pmatrix} 0,01 & -0,005 \\ -0,005 & 0,04 \end{pmatrix} = \begin{pmatrix} 26,6667 & -13,3333 \\ -13,3333 & 106,6667 \end{pmatrix}$$
- Vector de exceso de retorno esperado ($\boldsymbol{\mu} - R_f \mathbf{1}$):
  $$\boldsymbol{\mu} - R_f \mathbf{1} = \begin{pmatrix} 0,12 - 0,03 \\ 0,06 - 0,03 \end{pmatrix} = \begin{pmatrix} 0,09 \\ 0,03 \end{pmatrix}$$
- Multiplicación matricial:
  $$\mathbf{z} = \boldsymbol{\Sigma}^{-1}(\boldsymbol{\mu} - R_f \mathbf{1}) = \begin{pmatrix} 26,6667 \times 0,09 - 13,3333 \times 0,03 \\ -13,3333 \times 0,09 + 106,6667 \times 0,03 \end{pmatrix} = \begin{pmatrix} 2,40 - 0,40 \\ -1,20 + 3,20 \end{pmatrix} = \begin{pmatrix} 2,00 \\ 2,00 \end{pmatrix}$$
- Normalización:
  $$\mathbf{1}^\top \mathbf{z} = 2,00 + 2,00 = 4,00$$
  $$w_A^* = \frac{2,00}{4,00} = 0,50 \quad (50\%), \quad w_B^* = \frac{2,00}{4,00} = 0,50 \quad (50\%)$$

- **Rendimiento esperado de la cartera tangente:**
  $$\mu_T = 0,50 \times 0,12 + 0,50 \times 0,06 = 0,06 + 0,03 = 0,09 \quad (9,0\%)$$
- **Varianza y volatilidad de la cartera tangente:**
  $$\sigma_T^2 = (0,50)^2 (0,04) + (0,50)^2 (0,01) + 2(0,50)(0,50)(0,005) = 0,0100 + 0,0025 + 0,0025 = 0,0150$$
  $$\sigma_T = \sqrt{0,0150} \approx 0,12247 \quad (12,25\%)$$
- **Ratio de Sharpe máximo:**
  $$\text{SR}_T = \frac{\mu_T - R_f}{\sigma_T} = \frac{0,09 - 0,03}{0,12247} = \frac{0,06}{0,12247} \approx 0,4899$$

---

### Pregunta 3: Línea de Asignación de Capital (CAL)

$$\mu_c = R_f + \text{SR}_T \cdot \sigma_c = 0,03 + 0,4899 \cdot \sigma_c$$

---

### Pregunta 4: Separación de Preferencias y Asignación de Activos

La asignación óptima de riqueza en la cartera riesgosa es:
$$x^* = \frac{\mu_T - R_f}{\gamma \sigma_T^2} = \frac{0,06}{\gamma \times 0,0150} = \frac{4,00}{\gamma}$$

1. **Perfil Prudente ($\gamma = 8$):**
   - Fracción en cartera de riesgo: $x^* = \frac{4,00}{8} = 0,50$ ($50\%$).
   - Fracción en liquidez (activo libre de riesgo): $1 - x^* = 0,50$ ($50\%$).
   - Asignación patrimonial detallada:
     - **Dinero / Letras soberanas ($R_f$):** $50,0\%$.
     - **Acciones ($A$):** $0,50 \times 50\% = 25,0\%$.
     - **Deuda Corporativa ($B$):** $0,50 \times 50\% = 25,0\%$.
   - Rentabilidad esperada de la cartera: $\mu_c = 0,50(0,03) + 0,50(0,09) = 0,06$ ($6,0\%$).
   - Volatilidad: $\sigma_c = 0,50 \times 12,25\% = 6,12\%$.

2. **Perfil Crecimiento ($\gamma = 2,5$):**
   - Fracción en cartera de riesgo: $x^* = \frac{4,00}{2,5} = 1,60$ ($160\%$).
   - Fracción en liquidez: $1 - x^* = -0,60$ (endeudamiento del $60\%$ a la tasa libre de riesgo).
   - Asignación patrimonial detallada:
     - **Liquidez ($R_f$):** $-60,0\%$ (endeudamiento neto).
     - **Acciones ($A$):** $1,60 \times 50\% = 80,0\%$.
     - **Deuda Corporativa ($B$):** $1,60 \times 50\% = 80,0\%$.
   - Rentabilidad esperada de la cartera: $\mu_c = 0,03 + 1,60(0,06) = 0,126$ ($12,6\%$).
   - Volatilidad: $\sigma_c = 1,60 \times 12,25\% = 19,6\%$.

- **Verificación del Teorema de Separación de Tobin:**  
  En ambos perfiles, la relación entre acciones y deuda corporativa en la cartera de riesgo es idéntica:
  $$\frac{w_A}{w_B} = \frac{25\%}{25\%} = \frac{80\%}{80\%} = 1,00$$
  Las preferencias y la aversión al riesgo no alteran la composición interna de los activos de riesgo, verificando la separación estricta en dos fondos demostrada por Tobin.

---

## 4. Solución Detallada del Ejercicio 3 (Nivel Reto)

### Parte A: Irreversibilidad y Costos Asimétricos
- Para $q \ge 1$: $\frac{I}{K} = 0,08 + \frac{1}{8}(q - 1) = 0,08 + 0,125(q - 1)$.
- Para $q < 1$: $\frac{I}{K} = 0,08 + \frac{1}{24}(q - 1) = 0,08 + 0,0417(q - 1)$.

Cálculos numéricos:
- $q = 0,60 \implies I/K = 0,08 + \frac{1}{24}(-0,40) = 0,08 - 0,0167 = 0,0633$ ($6,33\%$).
- $q = 0,80 \implies I/K = 0,08 + \frac{1}{24}(-0,20) = 0,08 - 0,0083 = 0,0717$ ($7,17\%$).
- $q = 1,00 \implies I/K = 0,08$ ($8,00\%$).
- $q = 1,20 \implies I/K = 0,08 + \frac{1}{8}(0,20) = 0,08 + 0,0250 = 0,1050$ ($10,50\%$).
- $q = 1,40 \implies I/K = 0,08 + \frac{1}{8}(0,40) = 0,08 + 0,0500 = 0,1300$ ($13,00\%$).

*Implicancias macroeconómicas:*  
La pendiente de la curva de inversión a la izquierda de $q = 1$ es tres veces menor que a la derecha. La alta fricción de desinstalación ($\chi_{\text{down}} = 24$) genera una fuerte retención de capital ocioso en recesiones. Cuando la economía repunta, la existencia de exceso de capacidad amortigua la necesidad de nueva inversión hasta que la demanda agota la capacidad preexistente, generando recuperaciones con lento crecimiento de la inversión fija (*sluggish investment recoveries*).

### Parte B: La Lógica del Estimador Tobit (1958)
1. **Sesgo por MCO sobre toda la muestra:**  
   Al forzar una recta de regresión a través de un cúmulo de observaciones en cero, la pendiente se aplana artificialmente. MCO supone un rango no restringido en los errores y predeciría gastos en consumo negativos para niveles bajos de ingreso, lo cual carece de sentido económico.
2. **Sesgo por MCO truncado ($y_i > 0$):**  
   Descartar los ceros introduce un sesgo de selección: las familias de bajos ingresos que aun así compraron un vehículo poseen necesariamente un término de error inobservable fuertemente positivo ($\varepsilon_i > -x_i'\beta$). Por tanto, $E[\varepsilon_i \mid y_i > 0, x_i]$ está correlacionado negativamente con $x_i$, sesgando el coeficiente estimado hacia abajo.
3. **Solución del Modelo Tobit:**  
   Tobin formuló la variable latente $y_i^* = x_i'\beta + \varepsilon_i$ con $\varepsilon_i \sim \mathcal{N}(0, \sigma^2)$ y la regla observada $y_i = \max(0, y_i^*)$. La función de verosimilitud modela conjuntamente ambos regímenes:
   $$L = \prod_{y_i = 0} \left[ 1 - \Phi\left(\frac{x_i'\beta}{\sigma}\right) \right] \prod_{y_i > 0} \frac{1}{\sigma}\phi\left(\frac{y_i - x_i'\beta}{\sigma}\right)$$
   Los ceros aportan información legítima a través de la probabilidad acumulada normal, mientras que los valores positivos aportan a través de la densidad normal condicional, permitiendo estimar $\beta$ y $\sigma$ sin sesgo alguno.

---

## 5. Rúbrica de Evaluación Sugerida

| Criterio | Excelente (90–100%) | Satisfactorio (70–89%) | Necesita Mejora (<70%) |
|---|---|---|---|
| **Cálculo de la q de Tobin e Inversión (Ej. 1)** | Determina correctamente el valor de mercado, la ratio $q$ y la descomposición entre inversión bruta y neta. Interpreta con precisión el impacto del shock bursátil. | Calcula $q$ y la tasa de inversión con errores menores en el tratamiento de la caja o redondeo. | Confunde la $q$ media con la marginal o yerra la regla de costos de ajuste. |
| **Teorema de Separación de Tobin (Ej. 2)** | Invierte correctamente la matriz de covarianzas, deduce la cartera tangente analítica, grafica/escribe la CAL y demuestra la invariancia de proporciones entre perfiles. | Deduce la cartera tangente pero comete errores algebraicos en las ponderaciones de los perfiles de aversión al riesgo. | No logra invertir la matriz o desconoce el concepto de separación de dos fondos. |
| **Irreversibilidad y Tobit (Ej. 3)** | Modela la asimetría de costos, cuantifica las tasas de inversión y explica con rigor econométrico los sesgos de MCO frente a la máxima verosimilitud de Tobit. | Resuelve la parte de inversión pero presenta una explicación superficial o intuitiva del modelo Tobit sin rigor estadístico. | No resuelve la asimetría ni comprende el problema de censura de datos. |

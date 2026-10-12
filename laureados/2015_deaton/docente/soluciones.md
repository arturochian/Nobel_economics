# Solucionario y Guía Pedagógica: Demanda, Consumo y Bienestar
## Premio Nobel de Economía 2015: Angus Deaton
### Material exclusivo para el cuerpo docente

---

## Orientaciones Pedagógicas Generales

La obra de Angus Deaton constituye uno de los mejores puentes curriculares para integrar la microeconomía del consumidor (dualidad, lema de Shephard, sistemas de ecuaciones) con la macroeconomía moderna del consumo intertemporal y la econometría del desarrollo.

Los tres ejercicios propuestos permiten evaluar:
1. **Rigor analítico microeconómico:** Capacidad de operar con funciones de gasto logarítmicas y derivar elasticidades no lineales sin perder de vista las restricciones axiomáticas.
2. **Razonamiento macroeconométrico e intertemporal:** Comprensión de los límites del agente representativo y la naturaleza de las expectativas racionales frente a procesos de series temporales integrados.
3. **Economía aplicada y evaluación de políticas públicas:** Discernimiento de las dificultades de medir la pobreza, identificar la discriminación intra-hogar y fijar ponderadores en encuestas socioeconómicas reales.

---

## Solución al Ejercicio 1: Curvas de Engel y Clasificación de Bienes en el Sistema AIDS

### 1. Demostración analítica de la elasticidad de gasto
Partimos de la definición de participación presupuestaria del bien $i$:
$$w_i = \frac{p_i q_i}{X} \implies p_i q_i = w_i X$$
Tomando logaritmos naturales a ambos lados:
$$\ln p_i + \ln q_i = \ln w_i + \ln X \implies \ln q_i = \ln w_i + \ln X - \ln p_i$$
Derivando con respecto al logaritmo del gasto total $\ln X$ (manteniendo los precios fijos):
$$e_i \equiv \frac{\partial \ln q_i}{\partial \ln X} = \frac{\partial \ln w_i}{\partial \ln X} + 1 - 0$$
Por la regla de la cadena:
$$\frac{\partial \ln w_i}{\partial \ln X} = \frac{1}{w_i} \frac{\partial w_i}{\partial \ln X}$$
En el sistema AIDS, la ecuación es $w_i = \alpha_i + \sum_j \gamma_{ij} \ln p_j + \beta_i \ln(X/P) = \alpha_i + \sum_j \gamma_{ij} \ln p_j + \beta_i \ln X - \beta_i \ln P$.
Por lo tanto:
$$\frac{\partial w_i}{\partial \ln X} = \beta_i$$
Sustituyendo esto en la expresión anterior:
$$e_i = 1 + \frac{1}{w_i} \beta_i = 1 + \frac{\beta_i}{w_i} \quad \blacksquare$$

### 2. Cálculos para la política de subsidios
- **Alimentos ($i=1$):**
  $$e_1 = 1 + \frac{\beta_1}{w_1} = 1 + \frac{-0.13}{0.52} = 1 - 0.25 = 0.75$$
  - *Interpretación:* Es un **bien necesario inelástico al gasto** ($e_1 < 1$). Por cada 10% de aumento en los recursos del hogar pobre, el gasto en alimentos crece únicamente un 7.5%. La participación presupuestaria decae conforme aumenta el bienestar (Ley de Engel). El subsidio a alimentos beneficia fuertemente la canasta de subsistencia de las familias más vulnerables.
- **Recreación ($i=2$):**
  $$e_2 = 1 + \frac{\beta_2}{w_2} = 1 + \frac{+0.08}{0.04} = 1 + 2.00 = 3.00$$
  - *Interpretación:* Es un **bien de lujo superior** ($e_2 > 1$). Un aumento del 10% en el gasto del hogar triplica relativamente el consumo de este rubro (+30%). Gravar este bien tiene carácter marcadamente progresivo, ya que su peso en los hogares de menores recursos es marginal (solo 4%).

### 3. Condición de aditividad (*adding-up*)
Por definición, el presupuesto total del hogar se agota en la suma de gastos de todos los bienes:
$$\sum_{i=1}^K w_i = 1, \quad \forall X, \mathbf{p}$$
Sustituyendo la ecuación del sistema AIDS:
$$\sum_{i=1}^K \left[ \alpha_i + \sum_{j=1}^K \gamma_{ij} \ln p_j + \beta_i \ln \left( \frac{X}{P} \right) \right] = 1$$
Para que esta igualdad se mantenga para cualquier valor arbitrario de $\ln(X/P)$, el coeficiente multiplicador debe anularse:
$$\sum_{i=1}^K \beta_i = 0$$
*Absurdo económico:* Si todos los bienes fuesen de lujo ($\beta_i > 0$ para todo $i$), entonces $\sum_i \beta_i > 0$. Al incrementarse el ingreso un 1%, el gasto total en la suma de bienes tendría que incrementarse en más del 1%, lo cual violaría la restricción presupuestaria básica (el gasto total excedería el ingreso disponible total).

---

## Solución al Ejercicio 2: La Paradoja de Deaton y el Exceso de Suavidad

### 1. Deducción analítica de la revisión en el ingreso permanente
El modelo PIH estipula:
$$\Delta c_t = \frac{r}{1+r} \sum_{j=0}^\infty (1+r)^{-j} (E_t - E_{t-1}) y_{t+j}$$
Dado el proceso $\Delta y_t = \rho \Delta y_{t-1} + \epsilon_t$, el nivel futuro de ingreso en $t+j$ se puede escribir como:
$$y_{t+j} = y_t + \sum_{k=1}^j \Delta y_{t+k}$$
El error de pronóstico entre las expectativas formadas en $t$ y las de $t-1$ para el crecimiento futuro es:
$$(E_t - E_{t-1}) \Delta y_{t+k} = \rho^k \epsilon_t$$
Por consiguiente, el impacto acumulado sobre el nivel futuro de ingreso es:
$$(E_t - E_{t-1}) y_{t+j} = (E_t - E_{t-1}) \left[ y_{t-1} + \Delta y_t + \dots + \Delta y_{t+j} \right] = \left( 1 + \rho + \rho^2 + \dots + \rho^j \right) \epsilon_t = \left( \frac{1 - \rho^{j+1}}{1 - \rho} \right) \epsilon_t$$
Sustituyendo en la fórmula del consumo:
$$\Delta c_t = \frac{r}{1+r} \sum_{j=0}^\infty (1+r)^{-j} \left( \frac{1 - \rho^{j+1}}{1 - \rho} \right) \epsilon_t$$
Descomponiendo la suma en dos series geométricas infinitas:
$$\sum_{j=0}^\infty (1+r)^{-j} = \frac{1}{1 - (1+r)^{-1}} = \frac{1+r}{r}$$
$$\sum_{j=0}^\infty (1+r)^{-j} \rho^{j+1} = \rho \sum_{j=0}^\infty \left( \frac{\rho}{1+r} \right)^j = \rho \frac{1}{1 - \frac{\rho}{1+r}} = \frac{\rho (1+r)}{1 + r - \rho}$$
Restando ambos términos y dividiendo entre $(1 - \rho)$:
$$\frac{1+r}{r} - \frac{\rho(1+r)}{1+r-\rho} = (1+r) \left[ \frac{1+r-\rho - \rho r}{r(1+r-\rho)} \right] = (1+r) \frac{(1-\rho)(1+r)}{r(1+r-\rho)}$$
Multiplicando por el factor frontal $\frac{r}{1+r} \frac{1}{1-\rho}$:
$$\Delta c_t = \frac{r}{1+r} \frac{1}{1-\rho} \left[ \frac{(1+r)^2 (1-\rho)}{r(1+r-\rho)} \right] \epsilon_t = \left( \frac{1+r}{1+r-\rho} \right) \epsilon_t \quad \blacksquare$$

### 2. Cálculo cuantitativo del exceso de volatilidad
Con $r = 0.03$ y $\rho = 0.44$:
$$\kappa = \frac{1 + 0.03}{1 + 0.03 - 0.44} = \frac{1.03}{0.59} \approx 1.7458$$
Dado que $\Delta c_t = 1.746 \epsilon_t$, su varianza es:
$$\operatorname{Var}(\Delta c_t) = (1.7458)^2 \sigma_\epsilon^2 \approx 3.048 \, \sigma_\epsilon^2$$
Para el proceso de crecimiento del ingreso $\Delta y_t = \rho \Delta y_{t-1} + \epsilon_t$, la varianza incondicional de $\Delta y_t$ es:
$$\operatorname{Var}(\Delta y_t) = \frac{\sigma_\epsilon^2}{1 - \rho^2} = \frac{\sigma_\epsilon^2}{1 - (0.44)^2} = \frac{\sigma_\epsilon^2}{1 - 0.1936} = \frac{\sigma_\epsilon^2}{0.8064} \approx 1.240 \, \sigma_\epsilon^2$$
Por lo tanto, la razón teórica de varianzas que predice la hipótesis de ingreso permanente es:
$$\frac{\operatorname{Var}(\Delta c_t)}{\operatorname{Var}(\Delta y_t)} = \frac{3.048}{1.240} \approx 2.458$$
¡La teoría PIH tradicional predice que el consumo debería fluctuar casi **2.5 veces más** que el ingreso!

### 3. Explicación de la Paradoja de Deaton (1987, 1991)
En la realidad macroeconómica, el consumo agregado no es más volátil que el ingreso, sino mucho más suave ($\operatorname{Var}(\Delta c) / \operatorname{Var}(\Delta y) < 0.5$). Deaton resolvió esta discordancia mediante:
1. **Restricciones de Endeudamiento (*Borrowing Constraints*):** Los hogares típicos no pueden solicitar préstamos sin garantías contra sus salarios futuros esperados ($A_t \ge 0$). Si reciben una noticia positiva sobre ingresos lejanos, no pueden expandir su consumo de inmediato.
2. **Ahorro Precautorio (*Buffer-Stock Saving*):** Los hogares enfrentan incertidumbre de ingresos no asegurable y función de utilidad con prudencia ($u'''(c) > 0$). Mantienen un fondo de reserva para emergencias; cuando ocurre un shock positivo, aprovechan para recomponer su colchón financiero, amortiguando la respuesta del gasto presente.
3. **Falacia de Agregación:** Las series macroeconómicas agregan millones de hogares heterogéneos. Aunque para la economía agregada el shock parece permanente y persistente, para el hogar individual los shocks a su empleo o salud son en gran medida transitorios e idiosincrásicos. Aplicar un modelo de "consumidor representativo" a datos agregados confunde la microeconomía subyacente.

---

## Solución al Ejercicio 3: Reto de Medición de la Pobreza y Escalas de Equivalencia

### 1. Cálculos de escalas de equivalencia en R
Fórmula: $y^* = \frac{Y}{(A + \theta K)^\gamma}$ con $Y = 1\,000$, $\theta = 0.6$, $\gamma = 0.8$.
- **Hogar A (2 adultos):**
  $$y_A^* = \frac{1\,000}{(2 + 0.6 \times 0)^{0.8}} = \frac{1\,000}{2^{0.8}} \approx \frac{1\,000}{1.7411} \approx \$574.35$$
- **Hogar B (2 adultos, 3 niños):**
  $$y_B^* = \frac{1\,000}{(2 + 0.6 \times 3)^{0.8}} = \frac{1\,000}{(2 + 1.8)^{0.8}} = \frac{1\,000}{3.8^{0.8}} \approx \frac{1\,000}{2.9157} \approx \$342.97$$
- **Métrica per cápita cruda ($\gamma = 1, \theta = 1$):**
  - Hogar A: $y_{A,\text{crudo}} = 1\,000 / 2 = \$500.00$.
  - Hogar B: $y_{B,\text{crudo}} = 1\,000 / 5 = \$200.00$.
- **Comparación porcentual de sobreestimación:**
  Bajo la métrica cruda, el ingreso del Hogar B parece ser $\$200$, cuando su capacidad real de bienestar ajustada por economías de escala y necesidades infantiles equivale a $\$342.97$.
  $$\text{Sobreestimación del déficit} = \frac{342.97 - 200}{342.97} \approx 41.7\%$$
  La métrica per cápita cruda subestima el bienestar del hogar con niños en más de un 41%, inflando artificialmente la tasa de pobreza infantil.

### 2. El método de los bienes de adultos (*Outlay Equivalent Method*)
- *Mecanismo:* Dado que los niños no consumen tabaco, café de adultos o ropa formal de trabajo, cualquier reducción en el gasto del hogar en estos bienes tras el nacimiento de un hijo refleja el "efecto ingreso" que el costo de crianza impone sobre los padres.
- *Interpretación de los números:*
  Si un varón reduce el gasto de los padres en $\$25$ y una niña en solo $\$10$, significa que los padres están dispuestos a recortar su propio bienestar más del doble para adquirir nutrición, medicinas y comodidades para un hijo varón que para una hija mujer.
  Esto provee una prueba econométrica contundente de **discriminación de género intra-hogar**, sorteando la dificultad de observar directamente qué miembro de la familia ingiere cada caloría en la mesa.

### 3. Discusión crítica sobre líneas de pobreza absoluta
Deaton argumenta que las líneas globales de pobreza (como la de $\$1.90$ o $\$2.15$ PPP del Banco Mundial) adolecen de severas vulnerabilidades:
1. Las encuestas del Programa de Comparación Internacional (ICP) de precios entre países cambian drásticamente las canastas de referencia en cada ronda (2005 vs 2011 vs 2017), lo que puede hacer "desaparecer" o "crear" a cientos de millones de pobres de un día para otro solo por un cambio en la ponderación de precios urbanos versus rurales.
2. Los países en vías de desarrollo difieren enormemente en los cuestionarios de encuestas de hogares: encuestas que preguntan por 10 ítems de alimentos arrojan un gasto significativamente menor que encuestas con listas detalladas de 50 ítems, alterando artificialmente las tasas de pobreza regional.

---

## Rúbrica de Calificación Sugerida

| Criterio | Puntos | Descripción |
|:---|:---:|:---|
| **Ejercicio 1: Derivación y Elasticidades AIDS** | 30 pts | Demostración matemática limpia de $e_i$ (10 pts), cálculos numéricos e interpretación económica de bienes (10 pts), justificación axiomática de aditividad (10 pts). |
| **Ejercicio 2: Paradoja de Deaton y Volatilidad** | 35 pts | Deducción del multiplicador de Hall-Flavin (15 pts), cálculo de razón de varianzas (10 pts), explicación de las 2 causas de exceso de suavidad (10 pts). |
| **Ejercicio 3: Reto de Medición y Bienestar** | 35 pts | Cálculo numérico de escalas de equivalencia (15 pts), interpretación económica del método de bienes de adultos (10 pts), análisis crítico de líneas de pobreza (10 pts). |

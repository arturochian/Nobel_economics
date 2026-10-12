# Guía Docente y Solucionario: Robert M. Solow (Nobel 1987)

> **Material de uso exclusivo para el profesorado.**  
> Este documento contiene las pautas pedagógicas, los fundamentos analíticos formales, el solucionario detallado paso a paso y la rúbrica de evaluación de la guía de ejercicios de `laureados/1987_solow/estudiante/ejercicios.qmd`.

---

## 1. Pautas Pedagógicas y Contexto Teórico

### El Modelo de Solow como Columna Vertebral de la Macroeconomía
Robert M. Solow transformó radicalmente la macroeconomía moderna en 1956 al responder al pesimismo del modelo Harrod-Domar. En la formulación de Harrod y Domar, las tecnologías de proporciones fijas (función de Leontief) obligaban a que el pleno empleo fuera una "navaja de afeitar" (*razor's edge*): cualquier discrepancia entre la tasa natural de crecimiento y la tasa garantizada conducía a desempleo crónico o inflación galopante.

Solow introdujo la **sustitución continua entre capital y trabajo** bajo una función de producción neoclásica con rendimientos decrecientes del capital. Al hacerlo, demostró que la relación capital-producto ($K/Y$) es una variable endógena que se ajusta automáticamente para restablecer el equilibrio macroeconómico.

Al impartir este módulo, se recomienda enfatizar a los estudiantes tres lecciones clave:
1. **La distinción entre Efecto Nivel y Efecto Tasa:** Aumentar la tasa de ahorro desplaza la economía a un estado estacionario con mayor producto y capital per cápita (efecto nivel), pero en el largo plazo la tasa de crecimiento del PIB por habitante es idéntica a la tasa de progreso técnico ($g$).
2. **La paradoja del capital físico:** En su paper de 1957, Solow demostró que la acumulación de maquinaria e infraestructuras solo explica una fracción menor del crecimiento secular; la gran fuerza impulsora es la Productividad Total de los Factores (PTF).
3. **La ineficiencia dinámica:** Es vital que los estudiantes comprendan que "más ahorro no siempre es mejor". Una economía que ahorra por encima de la participación del capital ($s > \alpha$) cae en un despilfarro intertemporal donde todas las generaciones estarían mejor si se redujera la inversión.

---

## 2. Solución Detallada del Ejercicio 1 (Nivel Básico)

### Pregunta 1: Variables Intensivas y Ecuación Fundamental
1. **Definiciones:**
   - Capital por unidad de trabajo eficiente: $k(t) \equiv \frac{K(t)}{A(t)L(t)}$.
   - Producto por unidad de trabajo eficiente: $y(t) \equiv \frac{Y(t)}{A(t)L(t)} = \frac{K^\alpha (AL)^{1-\alpha}}{AL} = \left(\frac{K}{AL}\right)^\alpha = k(t)^\alpha$.

2. **Derivación de la ecuación de acumulación:**
   Diferenciando logarítmicamente $k(t)$ respecto al tiempo:
   $$\frac{\dot{k}}{k} = \frac{\dot{K}}{K} - \frac{\dot{A}}{A} - \frac{\dot{L}}{L}$$
   Dado que $\dot{K} = s Y - \delta K$, $\frac{\dot{A}}{A} = g$ y $\frac{\dot{L}}{L} = n$:
   $$\frac{\dot{k}}{k} = \frac{s Y - \delta K}{K} - g - n = s \frac{Y}{K} - (n + g + \delta)$$
   Multiplicando ambos miembros por $k$:
   $$\dot{k}(t) = s \frac{Y}{AL} - (n + g + \delta) \frac{K}{AL} = s y(t) - (n + g + \delta) k(t)$$
   Sustituyendo $y(t) = k(t)^\alpha$:
   $$\dot{k}(t) = s k(t)^\alpha - (n + g + \delta) k(t)$$

3. **Significado del término $(n + g + \delta)k$:**
   - $\delta k$: **Depreciación física**, el desgaste del equipo y maquinaria existente.
   - $n k$: **Dilución demográfica**, el capital necesario para dotar a los nuevos trabajadores de la misma cantidad de herramientas que los trabajadores ya empleados.
   - $g k$: **Dilución tecnológica**, el capital adicional requerido para mantener constante la relación capital por unidad de eficiencia ante el aumento de la productividad del trabajo.

### Pregunta 2: Cálculo del Estado Estacionario
Parámetros: $\alpha = 0.30$, $s = 0.24$, $n = 0.02$, $g = 0.02$, $\delta = 0.04$.  
Tasa de dilución efectiva: $n + g + \delta = 0.02 + 0.02 + 0.04 = 0.08$.

1. **Capital de equilibrio $k^*$:**
   $$s (k^*)^\alpha = (n + g + \delta) k^* \implies (k^*)^{1 - \alpha} = \frac{s}{n + g + \delta}$$
   $$k^* = \left( \frac{0.24}{0.08} \right)^{\frac{1}{1 - 0.30}} = 3^{\frac{1}{0.70}} = 3^{\frac{10}{7}} \approx 4.7960$$

2. **Producto de equilibrio $y^*$:**
   $$y^* = (k^*)^\alpha = (4.7960)^{0.30} = 3^{\frac{3}{7}} \approx 1.5987$$

3. **Consumo de equilibrio $c^*$:**
   $$c^* = (1 - s) y^* = (1 - 0.24) \times 1.5987 = 0.76 \times 1.5987 \approx 1.2150$$

4. **Inversión de equilibrio $i^*$:**
   $$i^* = s y^* = 0.24 \times 1.5987 \approx 0.3837$$
   *Comprobación:* $(n + g + \delta) k^* = 0.08 \times 4.7960 = 0.38368 \approx 0.3837$. Coincide exactamente.

### Pregunta 3: Tasas de Crecimiento en Equilibrio
- a) **Producto por unidad de trabajo eficiente ($y = Y / AL$):** Crece al **$0\%$** anual (constante en $y^*$).
- b) **Producto por trabajador real ($Y / L = A y^*$):** Crece a la tasa de progreso tecnológico **$g = 2.0\%$** anual.
- c) **PIB real agregado ($Y = A L y^*$):** Crece a la tasa combinada **$n + g = 2.0\% + 2.0\% = 4.0\%$** anual.

### Pregunta 4: Velocidad de Convergencia y Vida Media
1. **Tasa de convergencia $\lambda$:**
   $$\lambda = (1 - \alpha)(n + g + \delta) = (1 - 0.30) \times 0.08 = 0.70 \times 0.08 = 0.0560 \quad (5.60\% \text{ anual})$$

2. **Vida media ($t_{1/2}$):**
   $$t_{1/2} = \frac{\ln(2)}{\lambda} = \frac{0.693147}{0.0560} \approx 12.38 \text{ años}$$

3. **Tiempo para cerrar el $90\%$ de la brecha:**
   $$\frac{k(t) - k^*}{k(0) - k^*} = e^{-\lambda t} = 1 - 0.90 = 0.10$$
   $$-\lambda t = \ln(0.10) \implies t = \frac{\ln(10)}{\lambda} = \frac{2.302585}{0.0560} \approx 41.12 \text{ años}$$

---

## 3. Solución Detallada del Ejercicio 2 (Nivel Intermedio)

### Pregunta 1: Derivación de la Regla de Oro
Partiendo del consumo en estado estacionario:
$$c^*(s) = (1 - s) y^*(s) = f(k^*(s)) - (n + g + \delta) k^*(s)$$
Derivando respecto a $s$:
$$\frac{dc^*}{ds} = \left[ f'(k^*) - (n + g + \delta) \right] \frac{dk^*}{ds} = 0$$
Dado que $\frac{dk^*}{ds} > 0$, la condición de máximo requiere:
$$f'(k_{oro}^*) = n + g + \delta$$
Para la Cobb-Douglas $f'(k) = \alpha k^{\alpha - 1} = \alpha \frac{y}{k}$:
$$\alpha \frac{y_{oro}^*}{k_{oro}^*} = n + g + \delta \implies \alpha y_{oro}^* = (n + g + \delta) k_{oro}^*$$
Sustituyendo la condición de estado estacionario $s y_{oro}^* = (n + g + \delta) k_{oro}^*$:
$$s_{oro} y_{oro}^* = \alpha y_{oro}^* \implies s_{oro} = \alpha = 0.30$$

### Pregunta 2: Comparación Cuantitativa
Con $s_{oro} = 0.30$ y $n + g + \delta = 0.08$:
$$k_{oro}^* = \left( \frac{0.30}{0.08} \right)^{\frac{1}{0.70}} = (3.75)^{\frac{10}{7}} \approx 6.5772$$
$$y_{oro}^* = (6.5772)^{0.30} \approx 1.7539$$
$$c_{oro}^* = (1 - 0.30) \times 1.7539 = 0.70 \times 1.7539 \approx 1.2277$$

*Comparación con la economía base ($s = 0.24$):*
- En la base: $c^* = 1.2150$.
- En la Regla de Oro: $c_{oro}^* = 1.2277$.
- La economía base sacrifica: $\Delta c^* = 1.2277 - 1.2150 = 0.0127$ unidades de consumo por trabajador eficiente (una pérdida de bienestar potencial del $1.05\%$).

### Pregunta 3: Ineficiencia Dinámica en la Economía X ($s_X = 0.45$)
1. **Cálculos:**
   $$k_X^* = \left( \frac{0.45}{0.08} \right)^{\frac{1}{0.70}} = (5.625)^{\frac{10}{7}} \approx 11.8384$$
   $$y_X^* = (11.8384)^{0.30} \approx 2.1054$$
   $$c_X^* = (1 - 0.45) \times 2.1054 = 0.55 \times 2.1054 \approx 1.1580$$

2. **Comparación:**
   $$c_X^* = 1.1580 < c_{oro}^* = 1.2277 \quad \text{y además} \quad c_X^* = 1.1580 < c_{base}^* = 1.2150$$
   A pesar de tener un PIB por trabajador más alto ($y_X^* = 2.105$ frente a $1.599$), el consumo es sustancialmente menor debido a la enorme cantidad de recursos absorbidos por la reposición del capital ($i_X^* = 0.45 \times 2.105 = 0.947$).

3. **Definición de Ineficiencia Dinámica:**
   Ocurre cuando la economía acumula un exceso de capital tal que el producto marginal del capital es inferior al costo de reposición: $f'(k) < n + g + \delta$. Es un caso de despilfarro intertemporal puro.

4. **Trayectoria temporal al reducir el ahorro a $s = 0.30$:**
   - En el instante inicial ($t = 0$), el stock de capital está en $k_X^* \approx 11.84$. El consumo salta inmediatamente de $c(0^-) = 0.55 y(0) = 1.158$ a $c(0^+) = (1 - 0.30) y(0) = 0.70 \times 2.105 = 1.474$.
   - Conforme el capital se desacumula hacia $k_{oro}^* = 6.58$, el consumo desciende suavemente desde $1.474$ hasta el nuevo equilibrio $c_{oro}^* = 1.228$.
   - En ningún instante el consumo es inferior al nivel previo ($1.158$). Es una **mejora de Pareto estricta** intergeneracional: no hay sacrificio presente.
   - En la economía base ($s = 0.24 < 0.30$), pasar a la Regla de Oro requiere un **sacrificio presente**: en $t=0$, el consumo cae inmediatamente de $0.76 y(0) = 1.215$ a $0.70 y(0) = 1.119$, tardando años en recuperarse. Por tanto, la economía base es **dinámicamente eficiente**.

---

## 4. Solución Detallada del Ejercicio 3 (Nivel Reto / Avanzado)

### Pregunta 1: Contabilidad del Crecimiento Canónica (Solow 1957)
Datos: $\Delta \ln Y = 0.045$, $\Delta \ln K = 0.050$, $\Delta \ln L = 0.015$, $\alpha = 0.40$, $1 - \alpha = 0.60$.

1. **Contribución del Capital:**
   $$\alpha \Delta \ln K = 0.40 \times 0.050 = 0.0200 \quad (2.00\% \text{ anual})$$

2. **Contribución del Trabajo:**
   $$(1 - \alpha) \Delta \ln L = 0.60 \times 0.015 = 0.0090 \quad (0.90\% \text{ anual})$$

3. **Residuo de Solow (PTF):**
   $$\Delta \ln A = \Delta \ln Y - \left[ \alpha \Delta \ln K + (1 - \alpha) \Delta \ln L \right] = 0.0450 - (0.0200 + 0.0090) = 0.0160 \quad (1.60\% \text{ anual})$$

4. **Participación porcentual en el crecimiento total:**
   - Capital: $\frac{0.0200}{0.0450} \times 100 \approx 44.44\%$
   - Trabajo: $\frac{0.0090}{0.0450} \times 100 = 20.00\%$
   - Acumulación factorial total: $44.44\% + 20.00\% = 64.44\%$
   - Residuo de Solow (PTF): $\frac{0.0160}{0.0450} \times 100 \approx 35.56\%$

### Pregunta 2: Crecimiento Intensivo (Producto por Trabajador)
1. **Crecimiento de variables intensivas:**
   - Crecimiento de la productividad laboral: $\Delta \ln y = \Delta \ln Y - \Delta \ln L = 0.045 - 0.015 = 0.0300$ ($3.00\%$ anual).
   - Intensificación del capital: $\Delta \ln(K/L) = \Delta \ln K - \Delta \ln L = 0.050 - 0.015 = 0.0350$ ($3.50\%$ anual).

2. **Descomposición:**
   $$\Delta \ln y = \alpha \Delta \ln(K/L) + \Delta \ln A$$
   $$0.0300 = 0.40 \times 0.0350 + 0.0160 = 0.0140 + 0.0160 = 0.0300$$

3. **Participaciones relativas:**
   - Intensificación del capital: $\frac{0.0140}{0.0300} \times 100 \approx 46.67\%$
   - Productividad Total de Factores: $\frac{0.0160}{0.0300} \times 100 \approx 53.33\%$
   La PTF explica más de la mitad del incremento en el nivel de vida de los trabajadores.

### Pregunta 3: Ampliación con Capital Humano (MRW 1992)
Tecnología: $Y = A K^\alpha H^\beta L^{1 - \alpha - \beta}$, con $\alpha = 0.30$, $\beta = 0.30$, $1 - \alpha - \beta = 0.40$.  
Tasa de crecimiento de $H$: $\Delta \ln H = 0.035$ ($3.5\%$ anual).

1. **Ecuación de contabilidad ampliada:**
   $$\Delta \ln Y = \alpha \Delta \ln K + \beta \Delta \ln H + (1 - \alpha - \beta) \Delta \ln L + \Delta \ln A_{MRW}$$

2. **Cálculo del nuevo residuo:**
   $$\alpha \Delta \ln K = 0.30 \times 0.050 = 0.0150$$
   $$\beta \Delta \ln H = 0.30 \times 0.035 = 0.0105$$
   $$(1 - \alpha - \beta) \Delta \ln L = 0.40 \times 0.015 = 0.0060$$
   Contribución factorial total: $0.0150 + 0.0105 + 0.0060 = 0.0315$ ($3.15\%$).
   $$\Delta \ln A_{MRW} = 0.0450 - 0.0315 = 0.0135 \quad (1.35\% \text{ anual})$$

3. **Interpretación:**
   El residuo sin explicar se reduce de $1.60\%$ a $1.35\%$ (una caída de $0.25$ puntos porcentuales). El capital humano acumulado explica el $\frac{0.0105}{0.0450} \times 100 \approx 23.33\%$ del crecimiento total del PIB, absorbiendo un tercio de lo que antes se catalogaba genéricamente como "progreso técnico".

---

## 5. Rúbrica de Evaluación Sugerida

| Criterio | Excelente (90–100%) | Satisfactorio (70–89%) | Requiere Mejora (<70%) |
| :--- | :--- | :--- | :--- |
| **Rigor Analítico y Derivaciones** | Deriva con precisión matemática las ecuaciones diferenciales y la condición de la regla de oro; justifica cada paso algebraico. | Llega a las ecuaciones correctas pero omite pasos intermedios o comete errores algebraicos menores. | Aplica fórmulas de memoria sin demostrar su origen o confunde variables agregadas con intensivas. |
| **Cálculo Numérico e Interpretación** | Obtiene los valores exactos de $k^*, y^*, c^*$, velocidad de convergencia y vida media; interpreta con solidez su significado económico. | Realiza cálculos correctos pero no explica el significado intuitivo de la tasa de convergencia o el estado estacionario. | Errores numéricos en potencias fraccionarias o en tasas de dilución. |
| **Concepto de Ineficiencia Dinámica** | Distingue con total claridad entre economías dinámicamente eficientes e ineficientes; describe con precisión las trayectorias de consumo. | Identifica la regla de oro pero duda sobre si hay o no sacrificio intertemporal al reducir la tasa de ahorro. | Confunde la regla de oro con una condición de estabilidad o maximización de producto. |
| **Contabilidad del Crecimiento** | Descompone con exactitud el PIB y el producto por trabajador; entiende la función del Residuo de Solow y la extensión de MRW. | Calcula el residuo correctamente pero no desagrega en términos intensivos ni interpreta el rol del capital humano. | Confunde elasticidades de factores con participaciones o calcula erróneamente las tasas de crecimiento. |

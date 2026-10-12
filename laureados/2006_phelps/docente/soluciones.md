# Solucionario y Guía Pedagógica: Dinámica Intertemporal de Edmund S. Phelps

> **Documento Confidencial para el Docente**  
> **Asignatura:** Macroeconomía Avanzada / Crecimiento Económico / Teoría Monetaria  
> **Premio Nobel de Economía 2006:** Edmund S. Phelps  
> **Tema:** Curva de Phillips Aumentada, Tasa Natural de Desempleo, Regla de Oro de Acumulación y Compensaciones Intertemporales

---

## Objetivos de Aprendizaje y Competencias

Al resolver esta serie de ejercicios, el estudiante debe ser capaz de:
1. Derivar algebraicamente la Curva de Phillips con expectativas y demostrar por qué el largo plazo descarta cualquier menú de opciones permanente entre inflación y desempleo.
2. Cuantificar el proceso de aceleración inflacionaria cuando la política económica intenta situar el desempleo por debajo de su tasa natural estructural.
3. Formular y resolver el problema de optimización intergeneracional de Solow-Phelps, deduciendo la condición $r^* = n + g$ y la tasa de ahorro de la Regla de Oro ($s_{GR} = \alpha$).
4. Distinguir rigurosamente entre eficiencia dinámica e ineficiencia dinámica, interpretando el sacrificio intergeneracional en la senda de transición.
5. Contrastar los costos de estabilización y el ratio de sacrificio bajo expectativas adaptativas frente a expectativas racionales con credibilidad perfecta e imperfecciones contractuales.

---

## Solución al Ejercicio 1: Derivación de la Tasa Natural de Desempleo y la Hipótesis Aceleracionista (Nivel Básico)

### 1. Equilibrio de Largo Plazo y Verticalidad

- **Definición de equilibrio de largo plazo:** En el largo plazo o estado estacionario macroeconómico, los agentes económicos no incurren en errores sistemáticos de pronóstico. Por lo tanto, la inflación esperada converge exactamente a la inflación efectiva observada:
  $$\pi_t^e = \pi_t$$
  Adicionalmente, los shocks transitorios de oferta se han disipado ($\mathbb{E}[\varepsilon_t] = 0$).

- **Demostración de la verticalidad:**
  Partiendo de la ecuación de Phelps:
  $$\pi_t = \pi_t^e - \beta (u_t - u_n) + \varepsilon_t$$
  Sustituyendo $\pi_t^e = \pi_t$ y $\varepsilon_t = 0$:
  $$\pi_t = \pi_t - \beta (u_t - u_n)$$
  Restando $\pi_t$ a ambos lados:
  $$0 = -\beta (u_t - u_n)$$
  Dado que $\beta = 0.50 \ne 0$, dividimos entre $-\beta$:
  $$u_t - u_n = 0 \implies u_t = u_n = 5.5\%$$
  
  **Implicancia económica y gráfica:**
  La tasa de desempleo en el largo plazo está completamente desacoplada del nivel de inflación. Ya sea que la inflación sea del $2\%$, del $10\%$ o del $50\%$, el desempleo de equilibrio será inexorablemente $5.5\%$. En el plano cartesiano con desempleo ($u$) en el eje horizontal e inflación ($\pi$) en el eje vertical, la Curva de Phillips de largo plazo (LRPC) es una **línea recta vertical perfecta** en $u = u_n$. No existe ninguna compensación permanente entre ambas variables.

---

### 2. La Espiral Aceleracionista bajo Expectativas Adaptativas

Se tiene $\pi_t^e = \pi_{t-1}$, $u_n = 5.5\%$, $\beta = 0.50$, $\varepsilon_t = 0$, y la autoridad fija $u_t = 3.5\%$ para todo $t \ge 1$, con $\pi_0 = 2.0\%$.

La brecha de desempleo es constante:
$$(u_t - u_n) = 3.5\% - 5.5\% = -2.0\%$$

Por lo tanto, la ecuación de actualización es:
$$\pi_t = \pi_{t-1} - 0.50(-2.0\%) = \pi_{t-1} + 1.0\%$$

Calculamos período a período:
- **Período $t = 1$:**
  $$\pi_1^e = \pi_0 = 2.0\%$$
  $$\pi_1 = 2.0\% + 1.0\% = \mathbf{3.0\%}$$
- **Período $t = 2$:**
  $$\pi_2^e = \pi_1 = 3.0\%$$
  $$\pi_2 = 3.0\% + 1.0\% = \mathbf{4.0\%}$$
- **Período $t = 3$:**
  $$\pi_3^e = \pi_2 = 4.0\%$$
  $$\pi_3 = 4.0\% + 1.0\% = \mathbf{5.0\%}$$
- **Período $t = 4$:**
  $$\pi_4^e = \pi_3 = 5.0\%$$
  $$\pi_4 = 5.0\% + 1.0\% = \mathbf{6.0\%}$$
- **Período $t = 5$:**
  $$\pi_5^e = \pi_4 = 6.0\%$$
  $$\pi_5 = 6.0\% + 1.0\% = \mathbf{7.0\%}$$

**Variación de la inflación ($\Delta \pi_t$):**
$$\Delta \pi_t = \pi_t - \pi_{t-1} = +1.0\% \quad \text{para todo } t \ge 1$$

**Explicación económica:**
La inflación no se estaciona en un nivel más alto; **crece en $1$ punto porcentual cada período**. La razón reside en que para mantener el desempleo por debajo de la tasa natural, la inflación efectiva debe ser sistemáticamente mayor que la esperada ($\pi_t > \pi_t^e$) para sorprender a los agentes y abaratar temporalmente el salario real. Pero al actualizarse las expectativas adaptativas, la curva de Phillips de corto plazo se desplaza hacia arriba; para mantener el mismo desempleo de $3.5\%$, la autoridad debe generar una sorpresa inflacionaria aún mayor en el siguiente período, originando una **espiral inflacionaria aceleracionista**.

---

### 3. Compensación Intertemporal (*Intertemporal Tradeoff*)

La reducción del desempleo por debajo de $u_n$ hoy no es una ganancia neta permanente. Es un **préstamo intertemporal de bienestar**:
1. En el presente ($t=1\dots 5$), la economía disfruta de mayor empleo transitorio a costa de acumular inflación y expectativas de inflación cada vez más desancladas.
2. En el futuro, dado que una inflación acelerada desestabiliza el sistema financiero y la asignación de recursos, el banco central se verá forzado a estabilizar los precios.
3. Para reducir la inflación acumulada de regreso al $2\%$, la autoridad deberá revertir la brecha: requerirá inducir una recesión con desempleo por encima de la tasa natural ($u_t > u_n$) durante varios períodos. El beneficio transitorio de empleo hoy se devuelve íntegramente con intereses en forma de desempleo futuro forzado.

---

## Solución al Ejercicio 2: La Regla de Oro de Acumulación y el Dilema Intergeneracional (Nivel Intermedio)

### 1. Estado Estacionario

- **Ecuación fundamental de acumulación:**
  $$\dot{k} = s f(k) - (n + g + \delta) k = s k^\alpha - (n + g + \delta) k$$

- **Stock de capital de estado estacionario ($k^*$):**
  Haciendo $\dot{k} = 0$:
  $$s (k^*)^\alpha = (n + g + \delta) k^*$$
  Dividiendo entre $(k^*)^\alpha$:
  $$s = (n + g + \delta) (k^*)^{1 - \alpha} \implies k^*(s) = \left( \frac{s}{n + g + \delta} \right)^{\frac{1}{1 - \alpha}}$$

- **Producto por trabajador efectivo ($y^*$):**
  $$y^*(s) = (k^*(s))^\alpha = \left( \frac{s}{n + g + \delta} \right)^{\frac{\alpha}{1 - \alpha}}$$

- **Consumo por trabajador efectivo ($c^*$):**
  $$c^*(s) = (1 - s) y^*(s) = (1 - s) \left( \frac{s}{n + g + \delta} \right)^{\frac{\alpha}{1 - \alpha}}$$
  O en términos de inversión de reposición:
  $$c^*(s) = f(k^*(s)) - (n + g + \delta) k^*(s)$$

---

### 2. Condición de la Regla de Oro

- **Problema de optimización de Phelps (1961):**
  Maximizar el consumo de estado estacionario eligiendo el stock de capital $k^*$:
  $$\max_{k^*} c(k^*) = f(k^*) - (n + g + \delta) k^*$$

- **Condición de Primer Orden (CPO):**
  Derivando respecto a $k^*$ e igualando a cero:
  $$\frac{dc^*}{dk^*} = f'(k^*) - (n + g + \delta) = 0 \implies f'(k_{GR}^*) = n + g + \delta$$
  Restando la tasa de depreciación $\delta$ a ambos lados:
  $$f'(k_{GR}^*) - \delta = n + g$$
  Dado que la tasa de rendimiento real neta del capital es $r^* = f'(k^*) - \delta$, obtenemos la célebre condición de Phelps:
  $$r_{GR}^* = n + g$$
  **Interpretación:** En la Regla de Oro, la productividad marginal neta del capital debe igualar la tasa de crecimiento de la economía en la senda de equilibrio balanceado. Si $r^* > n + g$, la sociedad no tiene suficiente capital; si $r^* < n + g$, la sociedad acumula capital en exceso.

- **Tasa de ahorro de la Regla de Oro ($s_{GR} = \alpha$):**
  Para $f(k) = k^\alpha$, la productividad marginal es $f'(k) = \alpha k^{\alpha - 1}$.
  Sustituyendo en la CPO:
  $$\alpha (k_{GR}^*)^{\alpha - 1} = n + g + \delta \implies \alpha \frac{(k_{GR}^*)^\alpha}{k_{GR}^*} = n + g + \delta \implies \alpha \frac{y_{GR}^*}{k_{GR}^*} = n + g + \delta$$
  Multiplicando por $k_{GR}^* / y_{GR}^*$:
  $$\frac{(n + g + \delta) k_{GR}^*}{y_{GR}^*} = \alpha$$
  En estado estacionario, la inversión bruta total es $(n + g + \delta) k^* = s y^*$. Por lo tanto:
  $$\frac{s_{GR} y_{GR}^*}{y_{GR}^*} = \alpha \implies s_{GR} = \alpha$$

- **Cálculo de los valores numéricos:**
  Parámetros: $\alpha = 0.30$, $n = 0.01$, $g = 0.02$, $\delta = 0.05 \implies n + g + \delta = 0.08$.
  Tasa de ahorro de la regla de oro: $s_{GR} = 0.30$.
  
  $$k_{GR}^* = \left( \frac{0.30}{0.08} \right)^{\frac{1}{1 - 0.30}} = (3.75)^{\frac{1}{0.70}} = (3.75)^{1.42857} \approx \mathbf{6.568}$$
  
  $$y_{GR}^* = (k_{GR}^*)^\alpha = (6.568)^{0.30} \approx \mathbf{1.751}$$
  
  $$c_{GR}^* = (1 - s_{GR}) y_{GR}^* = (1 - 0.30) \times 1.7514 = 0.70 \times 1.7514 \approx \mathbf{1.226}$$
  
  $$r_{GR}^* = f'(k_{GR}^*) - \delta = (n + g + \delta) - \delta = n + g = 0.01 + 0.02 = \mathbf{0.030} \quad (3.0\% \text{ anual})$$

---

### 3. Eficiencia Dinámica y Transición Intertemporal

- **Efecto instantáneo en $t = t_0$ al elevar $s$ de $0.15$ a $0.30$:**
  En el instante exacto del cambio, el stock de capital $k$ es una variable de estado que **no puede saltar**: $k(t_0) = k_0^*$.
  El producto $y(t_0) = f(k_0^*)$ permanece idéntico.
  Sin embargo, la tasa de ahorro sube instantáneamente de $0.15$ a $0.30$. Por ende, la tasa de consumo cae de $(1 - 0.15) = 0.85$ a $(1 - 0.30) = 0.70$.
  
  Numéricamente:
  $$k_0^* = \left(\frac{0.15}{0.08}\right)^{1.42857} = (1.875)^{1.42857} \approx 2.443$$
  $$y_0^* = (2.443)^{0.30} \approx 1.303$$
  $$c_0^* = 0.85 \times 1.303 \approx \mathbf{1.108}$$
  En el instante de la reforma:
  $$c(t_0) = (1 - 0.30) \times 1.303 \approx \mathbf{0.912}$$
  **El consumo cae inmediatamente en un $-17.7\%$ ($\Delta c(t_0) = -0.196$).**

- **Quién asume el costo y quién disfruta el beneficio:**
  - **La generación presente ($t_0$):** Soporta íntegramente el sacrificio. Consume menos y debe apretarse el cinturón para canalizar más producto a la inversión en bienes de capital.
  - **Las generaciones futuras:** Conforme se acumula el capital hacia $k_{GR}^* = 6.568$, el producto se expande y el consumo per cápita se recupera hasta alcanzar $c_{GR}^* = 1.226$, disfrutando de un estándar de vida permanentemente más alto que el inicial ($1.226 > 1.108$).

- **Contraste con ineficiencia dinámica ($s_0 = 0.50 > s_{GR}$):**
  Si una economía ahorraba en exceso ($s_0 = 0.50$), reducir el ahorro a $s_{GR} = 0.30$ hace que la fracción consumida salte de $0.50$ a $0.70$. El consumo aumenta **inmediatamente hoy** y permanece más alto en el estado estacionario final. **No existe ningún sacrificio presente:** la reforma constituye una mejora de Pareto intergeneracional estricta.

---

## Solución al Ejercicio 3: Formación de Expectativas, Credibilidad y el Ratio de Sacrificio (Nivel Avanzado / Reto)

Modelo: $\pi_t = \pi_t^e - \beta (u_t - u_n)$, con $\beta = 0.75$, $u_n = 5.0\%$, $\pi_0 = 10.0\%$, meta $\pi^* = 2.0\%$. Reducción total de inflación deseada: $\Delta \pi = \pi_0 - \pi^* = 10\% - 2\% = 8.0\%$.

### 1. Desinflación bajo Expectativas Adaptativas ($\pi_t^e = \pi_{t-1}$)

Despejando el desempleo de la ecuación de Phillips:
$$\pi_t = \pi_{t-1} - \beta (u_t - u_n) \implies \beta (u_t - u_n) = \pi_{t-1} - \pi_t \implies u_t - u_n = \frac{\pi_{t-1} - \pi_t}{\beta}$$

- **Estrategia A (Shock Frío / *Cold Turkey*, $T = 1$ año):**
  La inflación cae de $\pi_0 = 10\%$ a $\pi_1 = 2\%$ en el primer período.
  $$\pi_1^e = \pi_0 = 10\%$$
  $$u_1 - u_n = \frac{10\% - 2\%}{0.75} = \frac{8\%}{0.75} = 10.67\%$$
  Tasa de desempleo observada en el año 1:
  $$u_1 = u_n + 10.67\% = 5.0\% + 10.67\% = \mathbf{15.67\%}$$
  Desempleo excesivo acumulado: $\sum (u_t - u_n) = 10.67\%$ año-persona.
  
  **Ratio de Sacrificio:**
  $$SR_A = \frac{u_1 - u_n}{\pi_0 - \pi_1} = \frac{10.67\%}{8\%} = \frac{1}{\beta} = \frac{1}{0.75} = \mathbf{1.33}$$
  (Se requieren $1.33$ puntos de desempleo por encima de la tasa natural por cada $1\%$ de desinflación lograda).

- **Estrategia B (Gradualismo a 4 años):**
  Trayectoria de desinflación: $\pi_1 = 8\%$, $\pi_2 = 6\%$, $\pi_3 = 4\%$, $\pi_4 = 2\%$.
  En cada año $t$, la desinflación es $\pi_{t-1} - \pi_t = 2.0\%$.
  $$u_t - u_n = \frac{2\%}{0.75} = 2.67\% \implies u_t = 5.0\% + 2.67\% = \mathbf{7.67\%} \quad \text{para } t = 1, 2, 3, 4$$
  Desempleo excesivo acumulado en los 4 años:
  $$\sum_{t=1}^4 (u_t - u_n) = 4 \times 2.67\% = 10.67\%$$
  
  **Ratio de Sacrificio:**
  $$SR_B = \frac{10.67\%}{8\%} = \mathbf{1.33}$$

  **Conclusión pedagógica:**
  Bajo expectativas puramente adaptativas lineales, **el Ratio de Sacrificio total es idéntico e invariable** ($SR = 1/\beta = 1.33$), sin importar si la desinflación se ejecuta en 1 año mediante un shock violento o en 4 años de forma gradual. La única diferencia radica en la distribución temporal del costo: un dolor intenso y concentrado ($u = 15.67\%$ en un año) frente a una recesión moderada pero prolongada ($u = 7.67\%$ durante cuatro años).

---

### 2. Expectativas Racionales y la Crítica de Credibilidad

- **Análisis con Credibilidad Perfecta:**
  Si el banco central anuncia que $\pi_1 = 2.0\%$ y los agentes forman expectativas racionales basadas en la regla de política creíble:
  $$\pi_1^e = \mathbb{E}_1[\pi_1] = \mathbf{2.0\%}$$
  Sustituyendo en la ecuación de Phelps:
  $$\pi_1 = \pi_1^e - \beta (u_1 - u_n) \implies 2.0\% = 2.0\% - 0.75 (u_1 - u_n)$$
  $$0 = -0.75 (u_1 - u_n) \implies u_1 - u_n = 0 \implies u_1 = u_n = \mathbf{5.0\%}$$
  
  **Ratio de Sacrificio:**
  $$SR = \frac{0}{8\%} = \mathbf{0}$$
  ¡La desinflación es completamente gratuita e indolora (*costless disinflation*)! Si las expectativas son racionales y el anuncio es perfectamente creíble, los formadores de salarios y precios coordinan inmediatamente sus expectativas hacia la nueva meta, eliminando la necesidad de generar una recesión.

- **Por qué el ratio de sacrificio rara vez es cero en la práctica (Phelps 1972, Fischer 1977, Taylor 1980):**
  1. **Rigideces contractuales escalonadas:** Incluso si los agentes tienen expectativas racionales y creen en el banco central, muchos salarios y precios ya están fijados mediante convenios colectivos o contratos a largo plazo celebrados con anterioridad (*overlapping contracts*). Ajustar los salarios nominales a la nueva meta requiere tiempo hasta el vencimiento de los contratos.
  2. **Incredulidad y costo de reputación:** Los agentes saben que las autoridades enfrentan un incentivo de inconsistencia temporal (generar sorpresa inflacionaria una vez negociados los salarios). Por ende, el público no ajusta de inmediato sus expectativas hasta ver evidencia tangible de contracción monetaria.
  3. **Fricciones de búsqueda e información imperfecta (Islas de Phelps):** La dispersión informativa en el mercado laboral impide que todos los trabajadores perciban simultáneamente que el menor crecimiento nominal de su salario no reduce su poder adquisitivo relativo, provocando despidos o renuncias durante la transición.

---

## Rúbrica de Calificación Sugerida (100 Puntos)

| Ejercicio | Criterio de Evaluación | Puntaje |
| :--- | :--- | :--- |
| **Ejercicio 1** | **Derivación de $u_n$ y verticalidad de largo plazo:** Definición formal de expectativas cumplidas y demostración algebraica de $u = u_n$. | 15 pts |
| | **Simulación aceleracionista:** Cálculo numérico correcto de $\pi_1 \dots \pi_5$ e interpretación de $\Delta \pi_t = 1\%$. | 10 pts |
| | **Intuición del trade-off intertemporal:** Explicación de por qué no es una ganancia permanente sino un costo diferido. | 5 pts |
| **Ejercicio 2** | **Estado estacionario neoclásico:** Expresiones correctas de $k^*$, $y^*$ y $c^*$. | 10 pts |
| | **Condición de Regla de Oro:** Planteamiento de optimización, derivación de $r^* = n + g$ y demostración de $s_{GR} = \alpha$. | 15 pts |
| | **Cálculos numéricos:** Valores exactos de $k_{GR}^*, y_{GR}^*, c_{GR}^*, r_{GR}^*$. | 5 pts |
| | **Transición intertemporal:** Identificación de la caída instantánea del consumo ($\Delta c < 0$) y distinción entre eficiencia e ineficiencia dinámica. | 10 pts |
| **Ejercicio 3** | **Desinflación adaptativa:** Cálculo correcto de tasas de desempleo en Shock Frío vs Gradualismo y demostración de $SR = 1/\beta$. | 15 pts |
| | **Expectativas racionales y credibilidad:** Demostración de $SR = 0$ bajo credibilidad perfecta. | 10 pts |
| | **Microfundamentos y rigideces reales:** Argumentación teórica de contratos escalonados e islas de Phelps. | 5 pts |
| **Total** | | **100 pts** |

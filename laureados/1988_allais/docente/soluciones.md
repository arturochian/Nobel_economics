# Guía Docente y Solucionario: Maurice Allais (Nobel 1988)

> **Material de uso exclusivo para el profesorado.**  
> Este documento contiene las pautas pedagógicas, los fundamentos formales y el solucionario analítico paso a paso de la guía de ejercicios de `laureados/1988_allais/estudiante/ejercicios.qmd`.

---

## 1. Pautas Pedagógicas y Contexto Teórico

### El papel de Maurice Allais en la Historia del Pensamiento Económico
Maurice Allais es a menudo calificado como el "padre de la escuela de ingenieros-economistas franceses" de la posguerra. Formado en la École Polytechnique y en el Cuerpo de Minas, su aproximación a la economía unió el máximo rigor matemático con una orientación decididamente práctica a los problemas de ingeniería pública y reconstrucción nacional.

Al enseñar este módulo, es fundamental transmitir a los estudiantes:
1. **La independencia de los descubrimientos:** Allais formuló los Teoremas Fundamentales del Bienestar (1943) al mismo tiempo que Hicks y antes que Arrow y Debreu; formuló la Regla de Oro del Capital (1947) 14 años antes que Phelps (1961); y formuló la refutación experimental de la utilidad esperada (1953) 26 años antes de la Teoría Prospectiva de Kahneman y Tversky (1979). El hecho de publicar en francés y en monografías independientes redujo su impacto inmediato en el mundo anglosajón, lo que el propio comité Nobel reparó en 1988.
2. **La tensión entre teoría normativa y positiva:** Allais no era un crítico cínico de la racionalidad; al contrario, defendía que el ser humano racional presta atención natural a la dispersión de los pagos psicológicos (la varianza de la utilidad), lo que hace que una certidumbre total tenga un estatus cualitativo especial frente a cualquier probabilidad inferior a uno.
3. **El pragmatismo en la regulación pública:** Allais enseñó que la regla de eficiencia $P = CMg$ no es una curiosidad abstracta, sino el principio operativo que debe regir las inversiones públicas y las tarifas eléctricas o de ferrocarril, anticipando los debates modernos sobre infraestructuras de red y subsidios cruzados.

---

## 2. Solución Detallada del Ejercicio 1 (Nivel Básico)

### Pregunta 1: Valores Monetarios Esperados
- **Lotería $L_1$:**
  $$\mathbb{E}[L_1] = 1.0 \times 1.000.000 = 1.000.000 \text{ €}$$
- **Lotería $L_2$:**
  $$\mathbb{E}[L_2] = 0.10 \times 5.000.000 + 0.89 \times 1.000.000 + 0.01 \times 0 = 500.000 + 890.000 + 0 = 1.390.000 \text{ €}$$
- **Lotería $L_3$:**
  $$\mathbb{E}[L_3] = 0.11 \times 1.000.000 + 0.89 \times 0 = 110.000 \text{ €}$$
- **Lotería $L_4$:**
  $$\mathbb{E}[L_4] = 0.10 \times 5.000.000 + 0.90 \times 0 = 500.000 \text{ €}$$

*Elección de un agente neutral al riesgo:*  
Un agente neutral al riesgo solo maximiza el valor esperado:
- En la Decisión 1: como $\mathbb{E}[L_2] = 1.390.000 > \mathbb{E}[L_1] = 1.000.000$, elige **$L_2$**.
- En la Decisión 2: como $\mathbb{E}[L_4] = 500.000 > \mathbb{E}[L_3] = 110.000$, elige **$L_4$**.

### Pregunta 2: Inconsistencia con la Utilidad Esperada
Normalizando $u(0) = 0$ y denotando $u_1 = u(1.000.000)$ y $u_5 = u(5.000.000)$, con $0 < u_1 < u_5$:

1. Expresión de las utilidades esperadas:
   - $EU(L_1) = u_1$
   - $EU(L_2) = 0.10 u_5 + 0.89 u_1 + 0.01 u(0) = 0.10 u_5 + 0.89 u_1$
   - $EU(L_3) = 0.11 u_1 + 0.89 u(0) = 0.11 u_1$
   - $EU(L_4) = 0.10 u_5 + 0.90 u(0) = 0.10 u_5$

2. De la preferencia empírica $L_1 \succ L_2$:
   $$u_1 > 0.10 u_5 + 0.89 u_1 \iff u_1 - 0.89 u_1 > 0.10 u_5 \iff 0.11 u_1 > 0.10 u_5$$

3. De la preferencia empírica $L_4 \succ L_3$:
   $$0.10 u_5 > 0.11 u_1$$

4. **Contradicción estricta:**  
   Obtenemos simultáneamente:
   $$0.11 u_1 > 0.10 u_5 \quad \text{y} \quad 0.11 u_1 < 0.10 u_5$$
   Esto es una contradicción algebraica absoluta. No existe ninguna función monótona $u(x)$ en el universo de la Utilidad Esperada que pueda admitir este patrón. Por tanto, el axioma de independencia queda formalmente refutado.

### Pregunta 3: Evaluación Numérica con $u(x) = \sqrt{x}$
Midiendo $x$ en millones de euros ($x_1 = 0, x_2 = 1, x_3 = 5$):
- $u(0) = \sqrt{0} = 0$
- $u(1) = \sqrt{1} = 1$
- $u(5) = \sqrt{5} \approx 2.236068$

Calculamos las utilidades esperadas:
- $EU(L_1) = 1.0000$
- $EU(L_2) = 0.10 \times 2.236068 + 0.89 \times 1.0 = 0.223607 + 0.89 = 1.113607$
  Como $EU(L_2) = 1.1136 > EU(L_1) = 1.0$, este individuo prefiere **$L_2 \succ L_1$**.
- $EU(L_3) = 0.11 \times 1.0 = 0.1100$
- $EU(L_4) = 0.10 \times 2.236068 = 0.2236$
  Como $EU(L_4) = 0.2236 > EU(L_3) = 0.1100$, prefiere **$L_4 \succ L_3$**.

*Conclusión didáctica:*  
Un agente con función Bernoulli cóncava clásica siempre es consistente consigo mismo: elige $(L_2, L_4)$ si su aversión al riesgo es moderada (como aquí), o $(L_1, L_3)$ si su aversión al riesgo es extrema (por ejemplo, con $u(x) = x^{0.1}$). Lo que la teoría clásica es incapaz de producir es el par cruzado $(L_1, L_4)$.

### Pregunta 4: El Efecto Certeza
El efecto certeza (*certainty effect*) postula que los seres humanos asignan una prima psicológica desproporcionada a los resultados completamente seguros ($p = 1.0$) en comparación con resultados que son meramente altamente probables ($p = 0.99$). Pasar de una probabilidad de $1.0$ a $0.99$ no se percibe psicológicamente como una reducción marginal de $0.01$, sino como una alteración cualitativa radical: se pasa de la seguridad total a la posibilidad de la catástrofe y el arrepentimiento (*regret*). En cambio, al comparar $p = 0.11$ frente a $p = 0.10$, ambos escenarios están ya sumidos en la incertidumbre, por lo que el decisor focaliza su atención en la magnitud del premio ($5$ millones frente a $1$ millón).

---

## 3. Solución Detallada del Ejercicio 2 (Nivel Intermedio)

### Datos del problema:
$P(Q) = 140 - Q$, $C(Q) = 1.600 + 20Q$.  
$CMg = 20$, $CMe(Q) = \frac{1.600}{Q} + 20$.

### Pregunta 1: Monopolio Privado No Regulado
- Ingreso total: $IT(Q) = (140 - Q)Q = 140Q - Q^2$.
- Ingreso marginal: $IMg(Q) = 140 - 2Q$.
- Condición de óptimo privado: $IMg = CMg \implies 140 - 2Q = 20 \implies 2Q = 120 \implies Q_m = 60$.
- Precio monopólico: $P_m = 140 - 60 = 80$ €.
- Beneficio privado:
  $$\Pi_m = IT(60) - C(60) = 80 \times 60 - (1.600 + 20 \times 60) = 4.800 - 2.800 = 2.000 \text{ €}$$
- Excedente del Consumidor:
  $$CS_m = \frac{1}{2} (140 - 80) \times 60 = \frac{1}{2} \times 60 \times 60 = 1.800 \text{ €}$$
- Excedente Social Total:
  $$W_m = CS_m + \Pi_m = 1.800 + 2.000 = 3.800 \text{ €}$$
- Pérdida Irrecuperable de Eficiencia ($DWL$ frente al óptimo competitivo donde $Q^* = 120$):
  $$DWL_m = \frac{1}{2} (P_m - CMg)(Q^* - Q_m) = \frac{1}{2} (80 - 20)(120 - 60) = \frac{1}{2} \times 60 \times 60 = 1.800 \text{ €}$$

### Pregunta 2: Regulación al Costo Medio ($P = CMe$)
Condición de presupuesto equilibrado:
$$140 - Q = \frac{1.600}{Q} + 20 \iff 120 - Q = \frac{1.600}{Q} \iff Q^2 - 120Q + 1.600 = 0$$

Resolviendo mediante la fórmula cuadrática:
$$\Delta = (-120)^2 - 4(1)(1.600) = 14.400 - 6.400 = 8.000$$
$$\sqrt{8.000} = 40\sqrt{5} \approx 89.4427$$
$$Q_{cme} = \frac{120 + 89.4427}{2} = \frac{209.4427}{2} \approx 104.72 \text{ miles de } m^3$$

*(Nota docente: la raíz menor $Q = \frac{120 - 89.44}{2} = 15.28$ corresponde al equilibrio con precio muy alto $P = 124.72$, descartable por eficiencia).*

- Precio de costo medio:
  $$P_{cme} = 140 - 104.72 = 35.28 \text{ €}$$
- Beneficio empresarial: $\Pi_{cme} = 0$ €.
- Excedente del Consumidor:
  $$CS_{cme} = \frac{1}{2} (140 - 35.28) \times 104.72 = \frac{1}{2} \times 104.72 \times 104.72 \approx 5.483.3 \text{ €}$$
- Excedente Total: $W_{cme} = CS_{cme} = 5.483.3$ €.
- Pérdida Irrecuperable de Eficiencia:
  $$DWL_{cme} = \frac{1}{2} (P_{cme} - CMg)(Q^* - Q_{cme}) = \frac{1}{2} (35.28 - 20)(120 - 104.72) = \frac{1}{2} \times 15.28 \times 15.28 \approx 116.7 \text{ €}$$

### Pregunta 3: Primer Mejor de Allais ($P = CMg$)
- Condición de Allais: $P^* = CMg = 20$ €.
- Cantidad óptima social: $140 - Q^* = 20 \implies Q^* = 120$ miles de $m^3$.
- Excedente del Consumidor:
  $$CS^* = \frac{1}{2} (140 - 20) \times 120 = \frac{1}{2} \times 120 \times 120 = 7.200 \text{ €}$$
- Beneficio / Déficit de la empresa pública:
  $$\Pi^* = P^* \cdot Q^* - C(Q^*) = 20 \times 120 - (1.600 + 20 \times 120) = 2.400 - 4.000 = -1.600 \text{ €}$$
  El déficit es exactamente igual al costo fijo $F = 1.600$ €.
- Excedente Social Total:
  $$W^* = CS^* + \Pi^* = 7.200 - 1.600 = 5.600 \text{ €}$$
- Pérdida Irrecuperable: $DWL^* = 0$ € (eficiencia paretiana absoluta).
  *(Nótese que $W^* = 5.600 > W_{cme} = 5.483.3 > W_m = 3.800$).*

### Pregunta 4: Diseño de Tarifa en Dos Partes de Allais-Boiteux
Para preservar la señal marginal no distorsionante y al mismo tiempo autofinanciar la red:
- **Precio variable unitario:** $P = CMg = 20$ € por cada mil $m^3$. Al pagar exactamente el costo marginal por cada unidad adicional consumida, cada usuario demanda su cantidad socialmente óptima.
- **Cuota fija de conexión:** Se distribuye el costo fijo entre los $N = 200$ usuarios:
  $$T = \frac{F}{N} = \frac{1.600 \text{ €}}{200 \text{ familias}} = 8 \text{ € mensuales por usuario}$$
- Ingreso total de la empresa: $IT = N \cdot T + P \cdot Q^* = 200 \times 8 + 20 \times 120 = 1.600 + 2.400 = 4.000$ €.
- Costo total: $C(120) = 1.600 + 20 \times 120 = 4.000$ €.
- Beneficio neto: $\Pi = 4.000 - 4.000 = 0$ € (déficit cero).
- Excedente neto promedio por usuario:
  $$\frac{CS^*}{N} - T = \frac{7.200}{200} - 8 = 36 - 8 = 28 \text{ €} > 0$$
  Como el excedente neto es positivo, todas las familias eligen voluntariamente participar en la red. Se alcanza el óptimo paretiano sin subsidios fiscales.

---

## 4. Solución Detallada del Ejercicio 3 (Nivel Reto)

### Pregunta 1: Derivación Analítica del Teorema de la Regla de Oro
Partiendo del consumo per cápita en estado estacionario:
$$c(k) = f(k) - (n + \delta)k$$

Para encontrar el stock de capital $k$ que maximiza $c(k)$, derivamos respecto a $k$:
$$\frac{dc(k)}{dk} = f'(k) - (n + \delta) = 0 \implies f'(k_{oro}) = n + \delta$$

Verificación de la condición de segundo orden (máximo estricto):
$$\frac{d^2 c(k)}{dk^2} = f''(k) < 0$$
dado que la función de producción exhibe rendimientos marginales decrecientes ($f''(k) < 0$).

*Relación con la tasa de interés de mercado:*  
En equilibrio competitivo, el costo del capital iguala el producto marginal del capital. La tasa de interés real neta de depreciación es $r = f'(k) - \delta$. Sustituyendo en la condición de la regla de oro:
$$r_{oro} + \delta = n + \delta \implies r_{oro} = n$$
La tasa de interés real de la economía debe ser exactamente igual a la tasa de crecimiento biológico de la población $n$ (o $n + g$ en presencia de progreso tecnológico).

*Tasa de ahorro de la regla de oro:*  
En estado estacionario, el ahorro por trabajador es $s y = (n + \delta) k$. En la regla de oro:
$$s_{oro} = \frac{(n + \delta) k_{oro}}{f(k_{oro})} = \frac{f'(k_{oro}) k_{oro}}{f(k_{oro})}$$
Para una función de producción Cobb-Douglas $f(k) = A k^\alpha$, la elasticidad del producto respecto al capital es $\frac{f'(k)k}{f(k)} = \alpha$.  
Por tanto:
$$s_{oro} = \alpha$$
La tasa de ahorro óptima que maximiza el consumo intertemporal es exactamente igual a la participación del capital en el ingreso nacional.

### Pregunta 2: Cálculo Numérico
Parámetros: $A = 10$, $\alpha = 0.35$, $n = 0.015$, $\delta = 0.05$.  
Suma $n + \delta = 0.015 + 0.05 = 0.065$.

a) **Capital de la regla de oro $k_{oro}$:**
   $$f'(k) = \alpha A k^{\alpha - 1} = 0.35 \times 10 \times k^{-0.65} = 3.5 k^{-0.65}$$
   $$3.5 k^{-0.65} = 0.065 \implies k^{-0.65} = \frac{0.065}{3.5} \approx 0.0185714$$
   $$k_{oro} = (0.0185714)^{-\frac{1}{0.65}} = (0.0185714)^{-1.53846} \approx 457.17$$

b) **Producto por trabajador $y_{oro}$:**
   $$y_{oro} = 10 \times (457.17)^{0.35} \approx 10 \times 8.4904 = 84.90$$

c) **Consumo por habitante $c_{oro}$:**
   $$i_{oro} = (n + \delta) k_{oro} = 0.065 \times 457.17 \approx 29.72$$
   $$c_{oro} = y_{oro} - i_{oro} = 84.90 - 29.72 = 55.18$$

d) **Tasa de inversión requerida:**
   $$s_{oro} = \frac{i_{oro}}{y_{oro}} = \frac{29.72}{84.90} \approx 0.35 = \alpha$$
   Se confirma empíricamente que la tasa de ahorro de la regla de oro es exactamente $35\%$.

### Pregunta 3: Ineficiencia Dinámica
Si una sociedad ahorra $s = 0.60 > \alpha$, acumula un stock de capital $k > k_{oro}$.  
Como $k > k_{oro}$, el producto marginal del capital cae por debajo de la depreciación y el crecimiento poblacional:
$$f'(k) < n + \delta \implies r < n$$
Cada unidad adicional de capital produce menos producto nuevo ($f'(k)$) que el costo de mantenerlo y reponerlo ($(n + \delta)$). Por consiguiente:
$$\frac{dc}{dk} < 0$$
Reducir el ahorro (por ejemplo, bajando $s$ de $0.60$ a $0.35$) produce un doble beneficio:
1. **En el período inicial:** La sociedad consume inmediatamente la porción del producto antes destinada a inversión excesiva, aumentando el consumo de la generación viva de inmediato.
2. **En el largo plazo:** Al converger hacia $k_{oro}$, el consumo per cápita permanente en estado estacionario se sitúa en su nivel máximo posible ($c_{oro} = 55.18$), superior al consumo del estado sobrecapitalizado.

Es una **mejora en el sentido de Pareto intertemporal**: ninguna generación pierde y todas ganan. Esta patología del sobreahorro es lo que Allais (1947) y posteriormente la macroeconomía moderna definieron como **ineficiencia dinámica**.

---

## 5. Rúbrica de Evaluación

| Criterio | Puntuación | Descripción de Desempeño Sobresaliente |
| :--- | :---: | :--- |
| **Ejercicio 1: Paradoja de Allais** | 30% | Demostración algebraica impecable de la inconsistencia con EUT; cálculo numérico exacto de utilidades; explicación clara del efecto certeza y ruptura de linealidad. |
| **Ejercicio 2: Monopolio y Tarificación** | 35% | Resolución correcta de los 3 regímenes; cuantificación exacta de excedentes y DWL; diseño conceptualmente sólido de tarifa en dos partes. |
| **Ejercicio 3: Regla de Oro del Capital** | 35% | Derivación matemática formal de la CPO; cálculo numérico riguroso de $k^*, y^*, c^*$; demostración analítica de $s^* = \alpha$ y comprensión conceptual profunda de ineficiencia dinámica. |
| **Total** | **100%** | Dominio integral de las aportaciones de Maurice Allais a la micro y macroeconomía. |

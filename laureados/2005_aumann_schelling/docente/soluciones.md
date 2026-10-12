# Pautas Docentes y Soluciones Detalladas: Nobel de Economía 2005

**Asignatura:** Teoría de Juegos Avanzada, Microeconomía y Economía del Conflicto  
**Tema:** Robert J. Aumann y Thomas C. Schelling (2005)  
**Destinatarios:** Docentes, tutores académicos y ayudantes de cátedra  

---

## Solución al Ejercicio 1 (Nivel Básico): La Sombra del Futuro y la Colusión Oligopólica (Aumann)

### 1. Equilibrio de Nash Estático ($T = 1$)
Analizamos la matriz de pagos en una sola etapa:
- Si Beta juega $C$, Alfa compara: $15$ (jugando $D$) vs $10$ (jugando $C$). Elige $D$.
- Si Beta juega $D$, Alfa compara: $3$ (jugando $D$) vs $0$ (jugando $C$). Elige $D$.

Por simetría, la estrategia de guerra de precios ($D$) es una **estrategia estrictamente dominante** para ambas empresas.
- El único Equilibrio de Nash en estrategias puras y dominantes es $(D, D)$, con pagos de beneficio de $(3, 3)$.
- **Eficiencia de Pareto:** Este equilibrio es ineficiente en el sentido de Pareto, ya que el resultado colusivo $(C, C)$ genera $(10, 10)$, otorgando $7$ millones adicionales de beneficio a cada empresa.

### 2. Derivación de la Estrategia Gatillo (*Grim Trigger*)
Sea $\delta \in (0, 1)$ el factor de descuento intertemporal.

- **Valor presente bajo colusión perpetua ($V_C$):**
  $$V_C = \sum_{t=0}^{\infty} \delta^t \cdot 10 = \frac{10}{1 - \delta}$$

- **Valor presente bajo desviación óptima ($V_D$):**
  Si una empresa decide hacer trampa en $t=0$, cobra el precio predatorio obteniendo la tentación $T = 15$. A partir de $t=1$, la otra empresa activa el gatillo y castiga fijando $D$ para siempre, generando el pago de castigo $P = 3$ a perpetuidad:
  $$V_D = 15 + \sum_{t=1}^{\infty} \delta^t \cdot 3 = 15 + \frac{3\delta}{1 - \delta}$$

- **Cálculo del factor de descuento crítico ($\delta^*$):**
  Para que la colusión constituya un Equilibrio Perfecto en Subjuegos (SPE), la condición de no desviación exige:
  $$V_C \ge V_D \iff \frac{10}{1 - \delta} \ge 15 + \frac{3\delta}{1 - \delta}$$
  Multiplicando ambos lados por $(1 - \delta) > 0$:
  $$10 \ge 15(1 - \delta) + 3\delta$$
  $$10 \ge 15 - 15\delta + 3\delta$$
  $$10 \ge 15 - 12\delta \iff 12\delta \ge 5 \iff \delta \ge \delta^* = \frac{5}{12} \approx 0.4167$$

### 3. Interpretación y Tasa de Interés Máxima
- Con una tasa de interés de $r = 15\%$ ($r = 0.15$):
  $$\delta = \frac{1}{1 + 0.15} = \frac{1}{1.15} \approx 0.8696$$
  Como $\delta = 0.8696 > \delta^* = 0.4167$, el cártel es plenamente sostenible como equilibrio de Nash perfecto en subjuegos.
- **Tasa de interés máxima admisible ($r_{\max}$):**
  $$\delta \ge \frac{5}{12} \iff \frac{1}{1 + r} \ge \frac{5}{12} \iff 1 + r \le \frac{12}{5} = 2.40 \iff r_{\max} = 1.40 \text{ (140\% anual)}$$
  Las empresas pueden tolerar tasas de descuento de hasta un 140% anual antes de que la tentación del corto plazo destruya el cártel.

---

## Solución al Ejercicio 2 (Nivel Intermedio): El Equilibrio Correlacionado de Aumann y el Semáforo Social

### 1. Equilibrios de Nash Tradicionales
Matriz de pagos:
- $(S, S) = (4, 4)$, $(S, D) = (1, 5)$, $(D, S) = (5, 1)$, $(D, D) = (0, 0)$.

- **Estrategias Puras:**
  - Si el Jugador 2 juega $S$, el Jugador 1 responde $D$ ($5 > 4$). Si el Jugador 1 juega $D$, el Jugador 2 responde $S$ ($1 > 0$). Por tanto, **$(D, S)$** es equilibrio de Nash con pagos $(5, 1)$.
  - Por simetría, **$(S, D)$** es equilibrio de Nash con pagos $(1, 5)$.
  Ambos equilibrios puros son asimétricos e injustos.

- **Estrategia Mixta Simétrica:**
  Sea $q = \sigma_i(D)$ la probabilidad de avanzar, y $(1 - q) = \sigma_i(S)$ la de ceder.
  Para que el Jugador 1 esté indiferente:
  $$EU_1(S) = (1 - q)(4) + q(1) = 4 - 3q$$
  $$EU_1(D) = (1 - q)(5) + q(0) = 5 - 5q$$
  Igualando utilidades:
  $$4 - 3q = 5 - 5q \iff 2q = 1 \iff q^* = \frac{1}{2}$$
  - **Probabilidad de colisión catastrófica $(D, D)$:**
    $$P(D, D) = q_1 \cdot q_2 = \left(\frac{1}{2}\right) \left(\frac{1}{2}\right) = \frac{1}{4} = 25\%$$
  - **Pago esperado:**
    $$EU_i = 4 - 3\left(\frac{1}{2}\right) = 2.5$$

### 2. El Mediador Correlacionado de Aumann (1974)
Distribución conjunta recomendada:
$$p(S, S) = \frac{1}{3}, \quad p(S, D) = \frac{1}{3}, \quad p(D, S) = \frac{1}{3}, \quad p(D, D) = 0$$

- **Verificación de Incentivos de Aumann (Jugador 1):**
  - **Caso 1: El semáforo recomienda $s_1 = D$:**
    La probabilidad condicional posterior de que al rival se le haya recomendado $S$ es:
    $$P(s_2 = S \mid s_1 = D) = \frac{p(D, S)}{p(D, S) + p(D, D)} = \frac{1/3}{1/3 + 0} = 1$$
    Si obedece jugando $D$, obtiene $u_1(D, S) = 5$.
    Si desobedece jugando $S$, obtiene $u_1(S, S) = 4$.
    Como $5 > 4$, **obedece estrictamente**.
  - **Caso 2: El semáforo recomienda $s_1 = S$:**
    Las probabilidades posteriores bayesianas son:
    $$P(s_2 = S \mid s_1 = S) = \frac{1/3}{1/3 + 1/3} = \frac{1}{2}, \quad P(s_2 = D \mid s_1 = S) = \frac{1/3}{1/3 + 1/3} = \frac{1}{2}$$
    Si obedece jugando $S$, su pago esperado es:
    $$EU_1(S \mid s_1 = S) = \frac{1}{2}(4) + \frac{1}{2}(1) = 2.5$$
    Si desobedece jugando $D$, su pago esperado es:
    $$EU_1(D \mid s_1 = S) = \frac{1}{2}(5) + \frac{1}{2}(0) = 2.5$$
    Como $EU_1(S) \ge EU_1(D)$ ($2.5 = 2.5$), obedecer es una mejor respuesta débil.
  Por simetría estricta, las mismas condiciones se cumplen para el Jugador 2.
  **Conclusión:** La distribución $p$ constituye un **Equilibrio Correlacionado de Aumann**.

- **Pago Esperado en el Equilibrio Correlacionado:**
  $$EU_1 = \frac{1}{3}(4) + \frac{1}{3}(1) + \frac{1}{3}(5) + 0(0) = \frac{10}{3} \approx 3.333$$
  $$EU_2 = \frac{1}{3}(4) + \frac{1}{3}(5) + \frac{1}{3}(1) + 0(0) = \frac{10}{3} \approx 3.333$$

- **Comparación:**
  - El pago esperado pasa de $2.50$ (en Nash mixto) a **$3.33$** (en equilibrio correlacionado), un incremento de bienestar del **$33.3\%$**.
  - La probabilidad de colisión catastrófica pasa del **$25\%$ al $0\%$**.
  - No se requiere ninguna autoridad coercitiva policial: una vez que el dispositivo emite la señal, los jugadores eligen libremente obedecer porque hacerlo maximiza su interés individual esperado.

---

## Solución al Ejercicio 3 (Nivel Avanzado / Reto): Micromotivos de Schelling y Compromisos Estratégicos

### Parte A: El Modelo de Tipping Point de Schelling
1. **Composición inicial:** $A = 50$, $B = 50$, por lo que $f_B = 0.50$.
   Umbral de tolerancia: $\tau_i = 0.20 + 0.01 i$.
   Una familia $i$ del grupo $A$ abandona si $f_B > \tau_i$:
   $$0.50 > 0.20 + 0.01 i \iff 0.01 i < 0.30 \iff i < 30$$
   Las familias $i \in \{1, 2, \dots, 29\}$ (un total de **29 familias**) están insatisfechas porque su umbral personal es inferior al 50%.
2. **Dinámica de Cascada tras el shock exógeno ($B = 55, A = 45$, $f_B = 0.55$):**
   - **Ronda 1:** Se evalúa la insatisfacción con $f_B = 0.55$:
     $$0.55 > 0.20 + 0.01 i \iff 0.01 i < 0.35 \iff i < 35$$
     Las familias $i \in \{1, 2, \dots, 34\}$ (34 familias) están insatisfechas y se marchan.
   - **Ronda 2:** Al marcharse 34 familias del grupo $A$, son reemplazadas por 34 familias del grupo $B$. La nueva cantidad de familias del grupo $B$ es $55 + 34 = 89$. La nueva proporción es:
     $$f_B' = \frac{89}{100} = 0.89$$
   - **Ronda 3:** Con $f_B' = 0.89$, evaluamos las familias restantes del grupo $A$ ($i \in \{35, \dots, 50\}$). La familia con mayor tolerancia en todo el grupo es la $i = 50$, cuyo umbral es:
     $$\tau_{50} = 0.20 + 0.01(50) = 0.70$$
     Dado que $f_B' = 0.89 > 0.70 \ge \tau_i \quad \forall i$, **absolutamente todas las familias restantes del grupo $A$ quedan insatisfechas**.
   - **Equilibrio Final:** Las 11 familias restantes del grupo $A$ abandonan el vecindario.
     Composición final: **$100\%$ familias del grupo $B$, $0\%$ familias del grupo $A$**.
     Un pequeño shock inicial de solo 5 familias activó el efecto de inflexión (*tipping point* de Schelling), colapsando el vecindario integrado hacia la segregación total.

### Parte B: El Compromiso Creíble y "Quemar las Naves" (Schelling, 1960)
1. **Juego Secuencial sin Compromiso:**
   - **Subjuego del Defensor ($D$):** Ante una invasión, $D$ compara:
     $u_D(\text{Luchar}) = -10 \quad \text{vs} \quad u_D(\text{Capitular}) = -2$
     Dado que $-2 > -10$, la mejor respuesta del defensor es **Capitular**.
   - **Elección del Invasor ($I$):** Anticipando la capitulación de $D$, $I$ compara:
     $u_I(\text{Invadir}) = 3 \quad \text{vs} \quad u_I(\text{Paz}) = 0$
     Como $3 > 0$, el invasor decide **Invadir**.
   - **Resultado SPE:** El invasor invade y el defensor capitula. Pagos finales: **$(3, -2)$**. La amenaza previa del defensor de luchar no es creíble (*empty threat*).

2. **Juego con Compromiso Creíble ("Quemar las Naves"):**
   - El defensor gasta $c = 1$ en destruir sus rutas de escape. Si capitula tras quemar las naves, sufre una penalización extrema que deja su pago en $-15$.
   - **Nuevo Subjuego del Defensor ($D$):** Ante una invasión, compara:
     $u_D(\text{Luchar}) = -10 - 1 = -11 \quad \text{vs} \quad u_D(\text{Capitular}) = -15$
     Dado que **$-11 > -15$**, luchar se convierte en la opción estrictamente racional para el defensor. La amenaza es ahora **creíble**.
   - **Nueva Elección del Invasor ($I$):** Anticipando que el defensor luchará irremediablemente, compara:
     $u_I(\text{Invadir}) = -10 \quad \text{vs} \quad u_I(\text{Paz}) = 0$
     Como $0 > -10$, el invasor decide **Mantenerse en Paz**.
   - **Pago Final del Defensor:**
     Al mantenerse la paz, el defensor retiene la soberanía obteniendo su pago de paz menos el costo de demolición:
     $$u_D = 5 - 1 = \mathbf{4}$$
   - **Conclusión de Schelling:** Al eliminar voluntariamente su mejor opción ex-post (capitular), el defensor disuadió con éxito la invasión y aumentó su pago final de $-2$ a $+4$.

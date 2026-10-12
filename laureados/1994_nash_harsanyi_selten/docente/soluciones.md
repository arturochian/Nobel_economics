# Solucionario y Guía Docente: Teoría de Juegos No Cooperativos y Refinamientos de Equilibrio

**Premio Nobel de Economía 1994:** John F. Nash Jr., Reinhard Selten y John C. Harsanyi  
**Material exclusivo para el equipo docente** — *Nobel_economics Project*

---

## 1. Fundamentos Teóricos y Pautas Pedagógicas

### 1.1 El Teorema de Existencia de John Nash (1950, 1951)
Para transmitir con rigor la genialidad de Nash, es crucial enfatizar la transición matemática desde el Teorema Minimax de John von Neumann (1928, válido solo para 2 personas y suma cero) hacia el equilibrio general no cooperativo de $n$ personas:

1. **La correspondencia de mejor respuesta:**
   Definida en el espacio compacto y convexo de perfiles de estrategias mixtas $\Sigma = \prod_{i=1}^n \Delta(S_i) \subset \mathbb{R}^{\sum m_i}$.
2. **Aplicación del Teorema de Punto Fijo de Kakutani (1941):**
   - $\Sigma$ es no vacío, compacto y convexo en espacio euclidiano.
   - Para cada $\sigma \in \Sigma$, $BR(\sigma) = \prod_{i=1}^n BR_i(\sigma_{-i})$ es no vacío y convexo, ya que la función de utilidad esperada $u_i(\cdot, \sigma_{-i})$ es lineal respecto a la probabilidad asignada a cada estrategia pura $\sigma_i$.
   - La correspondencia tiene gráfica cerrada (es hemicontinua superior por el Teorema del Máximo de Berge).
   - Por tanto, existe un punto fijo $\sigma^* \in BR(\sigma^*)$, lo que garantiza la existencia universal de al menos un equilibrio de Nash.

### 1.2 El Refinamiento de Reinhard Selten (1965, 1975)
- El punto pedagógico clave es la diferencia entre **equilibrio de forma normal** y **racionalidad secuencial**.
- En la forma normal, las acciones contingentes en nodos que nunca se alcanzan en el equilibrio no son penalizadas porque tienen probabilidad cero de ocurrir.
- Selten impone que la racionalidad debe ser **robusta subjuego por subjuego**: si un jugador se viera forzado a jugar en un nodo fuera de la trayectoria prevista, su acción debe ser óptima en ese momento. Esto extermina las amenazas vacías (*empty threats*).

### 1.3 La Transformación Bayesiana de John Harsanyi (1967–1968)
- Harsanyi demostró que un juego donde los jugadores no conocen la función de pagos del rival no es insoluble: puede reformularse como un juego estándar de información imperfecta con un movimiento previo de la "Naturaleza".
- Esta doctrina del *prior común* (*common prior assumption*) es el cimiento de toda la literatura sobre asimetría de información: diseño de mecanismos (Hurwicz, Maskin, Myerson), subastas (Vickrey, Milgrom, Wilson) y señalización (Spence).

---

## 2. Soluciones Detalladas a la Guía de Ejercicios

### Ejercicio 1: Inspección Fiscal y Evasión Tributaria (Nivel Básico)

Matriz de pagos netos (Fisco, Contribuyente):

| Fisco \ Contribuyente | Declarar ($D$) | Evadir ($E$) |
| :--- | :---: | :---: |
| **Auditar ($A$)** | $(6, -10)$ | $(14, -18)$ |
| **No Auditar ($NA$)** | $(10, -10)$ | $(0, 0)$ |

#### 1. Inexistencia de Equilibrio en Estrategias Puras:
- Si el perfil fuera $(A, D)$: El Fisco obtiene $6$. Desviándose a $NA$, obtiene $10 > 6$. No es equilibrio.
- Si el perfil fuera $(NA, D)$: El Contribuyente obtiene $-10$. Desviándose a $E$, obtiene $0 > -10$. No es equilibrio.
- Si el perfil fuera $(NA, E)$: El Fisco obtiene $0$. Desviándose a $A$, obtiene $14 > 0$. No es equilibrio.
- Si el perfil fuera $(A, E)$: El Contribuyente obtiene $-18$. Desviándose a $D$, obtiene $-10 > -18$. No es equilibrio.

Ciclo cerrado de mejores respuestas: $(A, D) \to (NA, D) \to (NA, E) \to (A, E) \to (A, D)$. Ninguna celda pura es estable.

#### 2. Condición de Indiferencia y Estrategia Mixta:
- Sea $p = \Pr(\text{Fisco audita})$ y $1 - p = \Pr(\text{Fisco no audita})$.
- Utilidades esperadas del Contribuyente:
  $$EU_C(D) = p(-10) + (1 - p)(-10) = -10$$
  $$EU_C(E) = p(-18) + (1 - p)(0) = -18p$$
  Para que el Contribuyente aleatorice con probabilidad no trivial, debe cumplirse la condición de indiferencia:
  $$EU_C(D) = EU_C(E) \iff -10 = -18p \iff p^* = \frac{10}{18} = \frac{5}{9} \approx 0.5556$$
  **Resultado 1:** El Fisco audita con probabilidad $p^* \approx 55.56\%$.

- Sea $q = \Pr(\text{Contribuyente declara verazmente})$ y $1 - q = \Pr(\text{Contribuyente evade})$.
- Utilidades esperadas del Fisco:
  $$EU_F(A) = q(6) + (1 - q)(14) = 14 - 8q$$
  $$EU_F(NA) = q(10) + (1 - q)(0) = 10q$$
  Condición de indiferencia:
  $$EU_F(A) = EU_F(NA) \iff 14 - 8q = 10q \iff 18q = 14 \iff q^* = \frac{14}{18} = \frac{7}{9} \approx 0.7778$$
  **Resultado 2:** El Contribuyente declara con probabilidad $q^* \approx 77.78\%$ (tasa de evasión de equilibrio $1 - q^* \approx 22.22\%$).

#### 3. Interpretación y Paradoja de las Políticas Públicas:
En términos paramétricos generales:
$$p^* = \frac{T}{T + F}$$
Derivando respecto a la multa sancionadora $F$:
$$\frac{\partial p^*}{\partial F} = -\frac{T}{(T + F)^2} < 0$$
**Intuición económica clave:** Si el legislador incrementa la severidad de la multa sancionadora $F$, la probabilidad de auditoría de equilibrio $p^*$ disminuye estrictamente. 
Esto obedece al principio fundamental de las estrategias mixtas de Nash: *un jugador no elige su propia probabilidad para maximizar su propio pago, sino para hacer que el rival sea indiferente entre sus estrategias*. Al elevar $F$, el castigo por ser atrapado es tan oneroso que una frecuencia menor de inspección basta para mantener al contribuyente en indiferencia.

---

### Ejercicio 2: Disuasión de Entrada y Compromiso Creíble de Selten (Nivel Intermedio)

#### 1. Resolución del Escenario A (Sin Compromiso):
- Árbol de juego:
  - Raíz: Entrante $E$ elige $\{IN, OUT\}$.
  - Si $OUT$: juego termina con vector $(E: 0, I: 9)$.
  - Si $IN$: nodo de decisión del Incumbente $I$ con opciones $\{A, F\}$.
    - Si $A$: pagos $(E: 3, I: 4)$.
    - Si $F$: pagos $(E: -2, I: -1)$.
- Matriz en forma normal estática:
  - Estrategias de $E$: $\{IN, OUT\}$.
  - Estrategias de $I$: $\{A, F\}$.

| $E$ \ $I$ | Acomodar ($A$) | Pelear ($F$) |
| :--- | :---: | :---: |
| **$IN$** | $(\mathbf{3}, \mathbf{4})$ | $(-2, -1)$ |
| **$OUT$** | $(0, 9)$ | $(\mathbf{0}, \mathbf{9})$ |

- **Equilibrios de Nash en forma normal:**
  1. $(IN, A)$ con pagos $(3, 4)$.
  2. $(OUT, F)$ con pagos $(0, 9)$. En $(OUT, F)$, $E$ no entra porque cree que $I$ peleará ($0 > -2$), y dado que $E$ no entra, $I$ obtiene $9$ tanto si había planeado $A$ como $F$.
- **Inducción hacia atrás de Selten (SPE):**
  - En el subjuego post-entrada, $I$ compara $u_I(A) = 4$ frente a $u_I(F) = -1$.
  - Como $4 > -1$, la acción estrictamente óptima es $A$.
  - La estrategia $F$ es una amenaza no creíble (*non-credible threat*).
  - $E$ anticipa racionalmente que $I$ acomodará, por lo que compara entrar (pago 3) contra quedarse fuera (pago 0). Como $3 > 0$, $E$ elige $IN$.
  - **Único Equilibrio Perfecto en Subjuegos (SPE):** $\{E: IN; I: A \text{ si } IN\}$ con pagos finales $(\mathbf{3}, \mathbf{4})$.

#### 2. Resolución del Escenario B (Inversión Irreversible en Capacidad $K = 6$):
- Si el Incumbente invierte $K = 6$, los pagos en el subjuego post-entrada cambian drásticamente:
  - Si $I$ acomoda ($A$): pago $= 4 - 6 = -2$.
  - Si $I$ pelea con su nueva capacidad ($F$): pago $= 0$ (frente a $E: -2$).
- **Subjuego tras la inversión:**
  - En el nodo post-entrada, $I$ compara $u_I(F) = 0$ frente a $u_I(A) = -2$.
  - Ahora $0 > -2$, por lo que **pelear es la acción estrictamente dominante**.
  - $E$ anticipa que si entra sufrirá una guerra de precios con pago $-2 < 0$. Por ende, la mejor respuesta de $E$ es **quedarse fuera ($OUT$)**, obteniendo $0$.
  - El pago de $I$ al lograr disuadir la entrada es $9 - 6 = 3$.
- **Decisión en la Etapa 0 (Invertir o No Invertir):**
  - Si $I$ NO invierte: el resultado del SPE es duopolio acomodado, donde $I$ gana $4$.
  - Si $I$ invierte $K = 6$: el resultado del SPE es disuasión efectiva y monopolio, donde $I$ gana $3$.
  - Como $4 > 3$, **no resulta rentable invertir en capacidad excesiva únicamente para disuadir la entrada**, a menos que el coste $K$ fuera estrictamente menor a $9 - 4 = 5$.
  - Este modelo ilustra elegantemente la teoría de las inversiones estratégicas irreversibles de Dixit (1980) y la doctrina de "quemar las naves" de Thomas Schelling.

---

### Ejercicio 3: Subasta de Primer Precio con Valores Privados (Harsanyi - Nivel Reto)

#### 1. Planteamiento de la Probabilidad de Victoria:
- Conjetura simétrica lineal: $b_j(v_j) = k \cdot v_j$, con $k \in (0, 1)$.
- Dado que $v_j \sim U[0, 1]$, su función de distribución acumulada es $F(x) = x$ para $x \in [0, 1]$.
- La probabilidad de que la puja $b_i$ del postor $i$ supere la puja del competidor $b_j$ es:
  $$\Pr(\text{Ganar}) = \Pr(b_j \le b_i) = \Pr(k \cdot v_j \le b_i) = \Pr\left(v_j \le \frac{b_i}{k}\right) = \frac{b_i}{k}$$
  (válido para $b_i \in [0, k]$).

#### 2. Optimización y Deducción del BNE:
- La función de beneficio esperado para el postor $i$ con valoración privada $v_i$ es:
  $$\mathbb{E}[u_i(b_i; v_i)] = (v_i - b_i) \cdot \Pr(\text{Ganar}) = (v_i - b_i) \left(\frac{b_i}{k}\right) = \frac{1}{k} \left( v_i b_i - b_i^2 \right)$$
- Condición de Primer Orden (CPO):
  $$\frac{\partial \mathbb{E}[u_i]}{\partial b_i} = \frac{1}{k} (v_i - 2 b_i) = 0$$
  Despejando la puja óptima:
  $$2 b_i = v_i \implies b_i^*(v_i) = \frac{1}{2} v_i$$
- Condición de Segundo Orden (CSO):
  $$\frac{\partial^2 \mathbb{E}[u_i]}{\partial b_i^2} = -\frac{2}{k} < 0 \quad (\text{máximo global estricto})$$
- Verificación de consistencia del equilibrio simétrico:
  La función de puja hallada es lineal en $v_i$ con pendiente $k^* = \frac{1}{2}$, lo cual confirma exactamente la conjetura inicial ($k = k^* = 1/2$).
  **Resultado:** En el Equilibrio de Nash Bayesiano, la estrategia simétrica es:
  $$b^*(v_i) = \frac{1}{2} v_i$$

#### 3. Interpretación del Sombreado de Puja (*Bid Shading*):
- Cada postor enfrenta un dilema de compensación (*trade-off*): incrementar su puja eleva la probabilidad de ganar la subasta, pero reduce el margen de beneficio neto $(v_i - b_i)$ en caso de ganar. En equilibrio, el balance marginal óptimo implica pujar exactamente el $50\%$ de la valoración personal.
- **Comparación con Vickrey (1961):** En una subasta de segundo precio, la puja no determina el precio a pagar sino únicamente la probabilidad de ganar. Por ello, la estrategia débilmente dominante es pujar con sinceridad absoluta ($b(v_i) = v_i$). Por el **Teorema de Equivalencia del Ingreso** (Vickrey, Myerson 1981), a pesar de que las pujas individuales difieren radicalmente, el ingreso esperado obtenido por el subastador es idéntico en ambos formatos.

---

## 3. Rúbrica de Evaluación Sugerida

| Criterio | Excelente (90–100%) | Aceptable (70–89%) | Insuficiente (<70%) |
| :--- | :--- | :--- | :--- |
| **Comprensión conceptual (Nash, Selten, Harsanyi)** | Distingue con precisión entre equilibrio estático, racionalidad secuencial e información incompleta. | Aplica los conceptos pero con imprecisiones en las definiciones formales. | Confunde equilibrio de Nash con Pareto o amenaza con compromiso. |
| **Cálculo analítico y álgebra de probabilidades** | Resuelve sin errores las condiciones de indiferencia, derivadas y probabilidades bayesianas. | Llega a resultados numéricos con errores menores de despeje algebraico. | Errores conceptuales graves en cálculo de esperanzas o funciones de probabilidad. |
| **Interpretación económica de resultados** | Articula con claridad el significado institucional, la credibilidad y las implicancias de política. | Interpreta superficialmente los números sin conectar con el comportamiento estratégico. | Se limita a transcribir fórmulas sin explicación económica. |

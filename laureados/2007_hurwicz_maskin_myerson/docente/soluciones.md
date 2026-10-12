# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2007: Leonid Hurwicz, Eric S. Maskin y Roger B. Myerson

> **Nota confidencial para el cuerpo docente:** Este documento contiene el desarrollo algebraico formal, las soluciones cuantitativas completas y las pautas pedagógicas de evaluación correspondientes a la guía de actividades en `estudiante/ejercicios.qmd`. Mantener reservado para uso exclusivo del docente.

---

### Solución Ejercicio 1 (Provisión de un Bien Público y Pagos VCG de Clarke)

#### 1. Eficiencia Social y Decisión del Proyecto
- **Suma de valoraciones verdaderas:**
  $$\sum_{i=1}^3 v_i = v_1 + v_2 + v_3 = 70 + 50 + 45 = \mathbf{165} \text{ mil euros}$$
- **Evaluación frente al costo:**
  Dado que $\sum v_i = 165 \ge C = 150$, la obra genera un **excedente social neto positivo**:
  $$W = \sum_{i=1}^3 v_i - C = 165 - 150 = \mathbf{+15} \text{ mil euros}$$
  Por consiguiente, la decisión socialmente eficiente es **construir el rompeolas** ($x^* = 1$).

- **Análisis de la decisión en ausencia de cada vecindario:**
  - Sin el Vecindario 1: $\sum_{j \ne 1} v_j = v_2 + v_3 = 50 + 45 = \mathbf{95} < 150 \implies$ El proyecto no se construiría.
  - Sin el Vecindario 2: $\sum_{j \ne 2} v_j = v_1 + v_3 = 70 + 45 = \mathbf{115} < 150 \implies$ El proyecto no se construiría.
  - Sin el Vecindario 3: $\sum_{j \ne 3} v_j = v_1 + v_2 = 70 + 50 = \mathbf{120} < 150 \implies$ El proyecto no se construiría.

---

#### 2. Cálculo de Pagos e Impuestos de Clarke
- **Fórmula de la regla pivote de Clarke:**
  Si el proyecto se construye, el pago de $i$ es la diferencia entre el costo del proyecto y la suma de valoraciones de los demás, siempre que los demás no alcancen a cubrir el costo por sí mismos:
  $$p_i = \max\left(0, C - \sum_{j \ne i} \hat{v}_j\right)$$

- **Cálculo de los pagos:**
  - **Vecindario 1:**
    $$p_1 = \max(0, 150 - 95) = \mathbf{55} \text{ mil euros}$$
  - **Vecindario 2:**
    $$p_2 = \max(0, 150 - 115) = \mathbf{35} \text{ mil euros}$$
  - **Vecindario 3:**
    $$p_3 = \max(0, 150 - 120) = \mathbf{30} \text{ mil euros}$$

- **Utilidad neta obtenida ($u_i = v_i - p_i$):**
  - Vecindario 1: $u_1 = 70 - 55 = \mathbf{+15}$ mil euros.
  - Vecindario 2: $u_2 = 50 - 35 = \mathbf{+15}$ mil euros.
  - Vecindario 3: $u_3 = 45 - 30 = \mathbf{+15}$ mil euros.

- **Identificación de Agentes Pivotales:**
  - Un agente es **pivotal** si su presencia altera la decisión social; es decir, sin él la decisión óptima cambiaría de construir ($x=1$) a no construir ($x=0$).
  - En este caso, **los tres vecindarios son pivotales**, porque $\sum_{j \ne i} v_j < 150$ para todo $i \in \{1, 2, 3\}$.
  - Cada agente paga exactamente la **externalidad que impone sobre los demás**: el déficit que los otros $N-1$ miembros no cubren para alcanzar el costo social.

- **Recaudación total y balance presupuestario:**
  $$\sum_{i=1}^3 p_i = p_1 + p_2 + p_3 = 55 + 35 + 30 = \mathbf{120} \text{ mil euros}$$
  - El costo de la obra es $C = 150$ mil euros. La recaudación ($120$) es **menor que el costo total** ($150$).
  - **Déficit presupuestario:** Hay un déficit de $150 - 120 = \mathbf{30}$ mil euros.
  - **Pauta pedagógica:** Este resultado ilustra el conflicto intrínseco formalizado por Hurwicz: el mecanismo VCG clásico con regla pivote no garantiza autofinanciamiento (*balanced budget*) en provisión de bienes públicos con agentes pivotales simétricos; requiere subsidio externo o un mecanismo de reparto adicional que no distorsione las condiciones de primer orden.

---

#### 3. Incentivos a la Manipulación Estratégica (DSIC)
- **Sub-reporte del Vecindario 2 ($\hat{v}_2 = 10$):**
  - La nueva suma declarada es $\hat{v}_1 + \hat{v}_2 + \hat{v}_3 = 70 + 10 + 45 = 125 < 150$.
  - El ayuntamiento cancela el proyecto ($x = 0$).
  - La utilidad neta del Vecindario 2 pasa a ser $u_2 = 0$.
  - Comparación: Diciendo la verdad obtenía $u_2 = +15$. Sub-reportar para "ahorrar" destruye el proyecto y hace que su utilidad caiga de $15$ a $0$.

- **Sobre-reporte del Vecindario 3 ($v_3 = 20, \hat{v}_3 = 35$):**
  - Con $v_1 = 70, v_2 = 50$: $\sum_{j \ne 3} v_j = 120$.
  - Si dice la verdad ($\hat{v}_3 = 20$): $\sum \hat{v} = 140 < 150 \implies$ Proyecto no se hace, $u_3 = 0$.
  - Si miente hacia arriba ($\hat{v}_3 = 35$): $\sum \hat{v} = 155 \ge 150 \implies$ Proyecto se aprueba.
  - Su pago VCG es: $p_3 = 150 - 120 = 30$.
  - Su utilidad neta real es: $u_3 = v_3 - p_3 = 20 - 30 = \mathbf{-10}$.
  - Comparación: Miente para forzar la obra y sufre una pérdida neta de $-10$ frente a $0$ si reporta la verdad.
- **Conclusión teórica:** Para cualquier conjunto de valoraciones de los rivales, ningún desvío $\hat{v}_i \ne v_i$ puede aumentar la utilidad de $i$. La revelación veraz es una estrategia débilmente dominante (DSIC).

---

### Solución Ejercicio 2 (El Teorema de Equivalencia del Ingreso de Myerson)

#### 1. Subasta de Segundo Precio (SPA)
- **Estrategia dominante:**
  En la subasta de segundo precio, la postura de un agente solo determina *si gana o pierde*, pero **no afecta el precio que paga** si resulta ganador (que depende exclusivamente de la postura del rival más alto). Pujar por encima de $v$ arriesga pagar un precio superior a su valoración; pujar por debajo arriesga perder una subasta rentable. Por tanto, $b_i(v_i) = v_i$ domina débilmente a cualquier otra puja.
- **Precio pagado e ingreso:**
  El objeto se asigna al postor con $v_{(1)} = \max \{v_1, v_2, v_3\}$. El ganador paga $v_{(2)}$.
  El ingreso del vendedor es $R^{\text{SPA}} = v_{(2)}$.
- **Valor esperado de la segunda estadística de orden:**
  Para $N = 3$ variables independientes uniformes en $[0, 120]$:
  $$\mathbb{E}[v_{(k)}] = \frac{N + 1 - k}{N + 1} \bar{v}$$
  Para la segunda estadística ($k = 2$):
  $$\mathbb{E}[R^{\text{SPA}}] = \mathbb{E}[v_{(2)}] = \frac{3 + 1 - 2}{3 + 1} \times 120 = \frac{2}{4} \times 120 = \mathbf{60} \text{ mil euros}$$

---

#### 2. Deducción de la Puja en Subasta de Primer Precio (FPA)
- **Principio de Equivalencia:**
  Por el Teorema de Myerson (1981), la regla de asignación es idéntica (gana quien tenga mayor $v$) y el tipo más bajo ($v=0$) tiene utilidad cero. En consecuencia, el pago esperado debe coincidir:
  $$b(v) \cdot \operatorname{Pr}(\text{ganar} \mid v) = \mathbb{E}[v_{(2)} \cdot \mathbf{1}_{\{v_{(2)} < v\}}]$$
  La probabilidad de que los otros $N-1$ postores tengan valoraciones menores a $v$ es:
  $$\operatorname{Pr}(\text{ganar} \mid v) = F(v)^{N-1} = \left(\frac{v}{\bar{v}}\right)^{N-1}$$
  El valor esperado del máximo de los otros $N-1$ postores condicional a ser menor que $v$ es:
  $$\mathbb{E}\left[\max_{j \ne i} v_j \Bigm| \max_{j \ne i} v_j < v\right] = \int_0^v x \frac{(N-1) x^{N-2}}{v^{N-1}} dx = \frac{N-1}{v^{N-1}} \left[\frac{x^N}{N}\right]_0^v = \frac{N - 1}{N} v$$
  Por tanto, igualando el pago esperado:
  $$b(v) \cdot \left(\frac{v}{\bar{v}}\right)^{N-1} = \frac{N - 1}{N} v \cdot \left(\frac{v}{\bar{v}}\right)^{N-1} \implies \mathbf{b(v) = \frac{N - 1}{N} v}$$

- **Aplicación numérica ($N = 3$):**
  $$b(v) = \frac{3 - 1}{3} v = \frac{2}{3} v$$
  Para un postor con $v = 90$ mil euros:
  $$b(90) = \frac{2}{3} \times 90 = \mathbf{60} \text{ mil euros}$$

- **Ingreso esperado del vendedor en FPA:**
  En FPA el vendedor recibe la puja del ganador: $R^{\text{FPA}} = b(v_{(1)}) = \frac{2}{3} v_{(1)}$.
  El valor esperado de la primera estadística de orden ($k = 1$) es:
  $$\mathbb{E}[v_{(1)}] = \frac{3 + 1 - 1}{3 + 1} \times 120 = \frac{3}{4} \times 120 = 90 \text{ mil euros}$$
  Calculando el ingreso esperado del vendedor:
  $$\mathbb{E}[R^{\text{FPA}}] = \frac{2}{3} \mathbb{E}[v_{(1)}] = \frac{2}{3} \times 90 = \mathbf{60} \text{ mil euros}$$
  **¡Idéntico al ingreso en la subasta de segundo precio ($60$ mil euros)!**

---

#### 3. Subasta de Todos Pagan (All-Pay Auction)
- **Deducción de la puja:**
  En All-Pay, cada postor paga su puja $b^{\text{AllPay}}(v)$ con probabilidad 1. El pago esperado es simplemente $b^{\text{AllPay}}(v)$.
  Por el teorema de Myerson, este pago debe igualar el pago esperado de FPA:
  $$b^{\text{AllPay}}(v) = b^{\text{FPA}}(v) \cdot F(v)^{N-1} = \left(\frac{N - 1}{N} v\right) \left(\frac{v}{\bar{v}}\right)^{N-1} = \frac{N - 1}{N} \frac{v^N}{\bar{v}^{N-1}}$$
- **Para este problema ($N = 3, \bar{v} = 120$):**
  $$b^{\text{AllPay}}(v) = \frac{2}{3} \frac{v^3}{120^2} = \frac{v^3}{21600}$$
- **Ingreso total esperado:**
  El recaudador recibe las pujas de los 3 postores:
  $$\mathbb{E}[R^{\text{AllPay}}] = 3 \cdot \mathbb{E}[b^{\text{AllPay}}(v)] = 3 \int_0^{120} \left(\frac{2}{3} \frac{v^3}{120^2}\right) \frac{1}{120} dv = \frac{2}{120^3} \left[\frac{v^4}{4}\right]_0^{120} = \frac{2}{120^3} \frac{120^4}{4} = \frac{2 \times 120}{4} = \mathbf{60}$$
  Se confirma con total exactitud la equivalencia del ingreso en los tres formatos.

---

### Solución Ejercicio 3 (El Teorema de Imposibilidad de Myerson-Satterthwaite)

#### 1. Fracaso del Mecanismo VCG en Comercio Bilateral
- **Mecanismo VCG:**
  El comercio eficiente exige intercambiar si y solo si $v \ge c$.
  - Para que el comprador declare verazmente y participe voluntariamente (IR), debe pagar la valoración mínima del vendedor que habría permitido el trato: $p_B = c$.
  - Para que el vendedor declare verazmente y participe (IR), debe recibir la valoración máxima del comprador que habría permitido el trato: $p_S = v$.
- **Déficit presupuestario:**
  Cuando $v > c$, el comprador transfiere $c$, pero el vendedor exige recibir $v$. La transferencia neta del intermediario o estado es:
  $$\text{Déficit}(v, c) = p_S - p_B = v - c > 0$$
- **Cálculo del subsidio esperado:**
  $$\mathbb{E}[\text{Déficit}] = \int_0^1 \int_0^v (v - c) \, dc \, dv = \int_0^1 \left[v c - \frac{c^2}{2}\right]_0^v dv = \int_0^1 \frac{v^2}{2} dv = \left[\frac{v^3}{6}\right]_0^1 = \mathbf{\frac{1}{6} \approx 0.1667}$$
  Sin un subsidio exógeno constante de $1/6$, el mecanismo VCG colapsa por insolvencia presupuestaria.

---

#### 2. Mecanismo de Chatterjee y Samuelson (1983)
- **Condición de intercambio:**
  El intercambio ocurre si $p_B(v) \ge p_S(c)$. Sustituyendo las funciones de equilibrio lineal:
  $$\frac{2}{3} v + \frac{1}{12} \ge \frac{2}{3} c + \frac{1}{4}$$
  Restando $1/12$ a ambos lados:
  $$\frac{2}{3} v \ge \frac{2}{3} c + \frac{3}{12} - \frac{1}{12} = \frac{2}{3} c + \frac{2}{12} = \frac{2}{3} c + \frac{1}{6}$$
  Multiplicando por $\frac{3}{2}$:
  $$v \ge c + \frac{1}{6} \times \frac{3}{2} = c + \frac{1}{4} \implies \mathbf{v - c \ge \frac{1}{4}}$$

- **Representación gráfica y cálculo de probabilidades:**
  - El espacio de estados es el cuadrado unitario $[0, 1] \times [0, 1]$ de área 1.
  - La región eficiente es el triángulo $v \ge c$, cuya área es $\operatorname{Pr}(\text{eficiente}) = \frac{1}{2} (1)(1) = \mathbf{\frac{1}{2} = 0.500}$.
  - La región efectiva de comercio es el triángulo definido por $c \in [0, 3/4]$ y $v \ge c + 1/4$. Su base en $v=1$ es $3/4$ y su altura es $3/4$:
    $$\operatorname{Pr}(\text{comercio}) = \frac{1}{2} \left(\frac{3}{4}\right) \left(\frac{3}{4}\right) = \mathbf{\frac{9}{32} \approx 0.28125}$$
  - ¡Casi la mitad de las ganancias potenciales de comercio se frustran debido a la asimetría de información!

---

#### 3. Pérdida de Eficiencia y la Cota de Myerson-Satterthwaite
- **Cálculo de la Pérdida de Excedente (Deadweight Loss):**
  La pérdida social ocurre en el trapecio donde $0 \le v - c < 1/4$.
  El excedente social no realizado es:
  $$\text{DWL} = \int_{0}^{1/4} (v - c) \, d(v, c)$$
  Integrando con el cambio de variable $\Delta = v - c \in [0, 1/4]$, la longitud del segmento para un $\Delta$ dado es $1 - \Delta$:
  $$\text{DWL} = \int_0^{1/4} \Delta (1 - \Delta) \, d\Delta = \left[ \frac{\Delta^2}{2} - \frac{\Delta^3}{3} \right]_0^{1/4}$$
  Evaluando en $\Delta = 1/4$:
  $$\text{DWL} = \frac{(1/4)^2}{2} - \frac{(1/4)^3}{3} = \frac{1/16}{2} - \frac{1/64}{3} = \frac{1}{32} - \frac{1}{192} = \frac{6 - 1}{192} = \mathbf{\frac{5}{192} \approx 0.0260}$$
  El excedente social máximo posible de primer mejor es:
  $$W_{\text{max}} = \int_0^1 \int_0^v (v - c) dc dv = \frac{1}{6} = \frac{32}{192} \approx 0.1667$$
  El mecanismo de Chatterjee-Samuelson captura:
  $$W = \frac{32 - 5}{192} = \frac{27}{192} = \mathbf{\frac{9}{64} \approx 0.1406}$$
  Myerson y Satterthwaite (1983) demostraron que $\mathbf{9/64}$ es exactamente el **techo máximo absoluto de bienestar** que CUALQUIER mecanismo voluntario no subsidiado puede alcanzar.
- **Pauta Pedagógica:** Este resultado es crucial para enseñar economía institucional. Las fricciones en negociaciones salariales, fusiones corporativas o disputas legales no reflejan obstinación o estupidez de los agentes: el oportunismo de regatear y simular valoraciones es una respuesta óptima a las reglas descentralizadas de mercado, formalizando el límite infranqueable de la "mano invisible".

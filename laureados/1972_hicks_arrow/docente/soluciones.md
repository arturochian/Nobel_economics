# Guía Pedagógica y Solucionario Completo: Sir John R. Hicks y Kenneth J. Arrow (Nobel 1972)

## Orientaciones para el Docente

Este módulo formativo está diseñado para asignaturas avanzadas de **Microeconomía**, **Economía del Bienestar**, **Teoría del Equilibrio General** y **Finanzas Cuantitativas**. Los aportes de Sir John R. Hicks y Kenneth J. Arrow constituyen la columna vertebral del análisis microeconómico contemporáneo.

El objetivo pedagógico es que el estudiante adquiera destreza en:
1. La **dualidad del consumo**, deduciendo con rigor analítico la ecuación de Slutsky-Hicks y las medidas de bienestar monetario ($CV$ y $EV$).
2. La **teoría de mercados financieros contingentes de Arrow**, resolviendo precios de equilibrio walrasiano y demostrando el reparto óptimo del riesgo.
3. El **Teorema de Imposibilidad de Arrow**, comprendiendo la imposibilidad lógica de construir funciones de bienestar social democráticas libres de paradojas.

---

# Solución al Ejercicio 1: Descomposición de Hicks, Dualidad y Métricas de Bienestar ($CV$ y $EV$) (Nivel Básico)

### 1. Problema Primal y Cestas Marshallianas

Dada la función de utilidad Cobb-Douglas $U(x_1, x_2) = x_1^{1/3} x_2^{2/3}$ con ingreso $I = 120$:

- **Funciones de Demanda Marshallianas:**
  Las participaciones presupuestarias óptimas son $\alpha = 1/3$ y $\beta = 2/3$:
  $$x_1^m(p_1, p_2, I) = \frac{\alpha \cdot I}{p_1} = \frac{1}{3} \frac{120}{p_1} = \frac{40}{p_1}$$
  $$x_2^m(p_1, p_2, I) = \frac{\beta \cdot I}{p_2} = \frac{2}{3} \frac{120}{p_2} = \frac{80}{p_2}$$

- **Cesta Inicial A a precios $(p_1^0 = 4, p_2 = 2)$:**
  $$x_1^A = \frac{40}{4} = 10$$
  $$x_2^A = \frac{80}{2} = 40$$
  $$U_0 = 10^{1/3} \cdot 40^{2/3} = 10^{1/3} \cdot (4 \cdot 10)^{2/3} = 10 \cdot 4^{2/3} \approx 25.19842$$

- **Cesta Final C tras la caída del precio a $p_1^1 = 2$:**
  $$x_1^C = \frac{40}{2} = 20$$
  $$x_2^C = \frac{80}{2} = 40$$
  $$U_1 = 20^{1/3} \cdot 40^{2/3} = 20^{1/3} \cdot (2 \cdot 20)^{2/3} = 20 \cdot 2^{2/3} \approx 31.74802$$

- **Efecto Total ($ET$):**
  $$ET = x_1^C - x_1^A = 20 - 10 = +10 \text{ unidades de bien 1}$$

---

### 2. Problema Dual y Cesta Compensada de Hicks

El problema dual de minimización de gasto es:
$$\min_{x_1, x_2} (p_1 x_1 + p_2 x_2) \quad \text{s.a.} \quad x_1^{1/3} x_2^{2/3} \ge u$$

- **Función de Gasto $e(p_1, p_2, u)$:**
  $$e(p_1, p_2, u) = u \cdot \left(\frac{p_1}{\alpha}\right)^\alpha \left(\frac{p_2}{\beta}\right)^\beta = u \cdot (3 p_1)^{1/3} \left(\frac{3}{2} p_2\right)^{2/3}$$

- **Demandas Compensadas de Hicks (Lema de Shephard):**
  $$h_1(p_1, p_2, u) = \frac{\partial e}{\partial p_1} = \frac{\alpha \cdot e(p_1, p_2, u)}{p_1} = \frac{1}{3} \frac{e(p_1, p_2, u)}{p_1}$$
  $$h_2(p_1, p_2, u) = \frac{\partial e}{\partial p_2} = \frac{\beta \cdot e(p_1, p_2, u)}{p_2} = \frac{2}{3} \frac{e(p_1, p_2, u)}{p_2}$$

- **Gasto Compensado $E^c$ a precios $(p_1^1 = 2, p_2 = 2)$ para alcanzar $U_0$:**
  Dado que $e(p^0, U_0) = 120$, por homogeneidad de grado 1:
  $$E^c = e(p^1, U_0) = 120 \cdot \left(\frac{p_1^1}{p_1^0}\right)^{1/3} = 120 \cdot \left(\frac{2}{4}\right)^{1/3} = 120 \cdot (0.5)^{1/3} \approx 120 \cdot 0.7937005 = 95.24406$$

- **Cesta Compensada de Hicks B:**
  $$x_1^B = h_1(2, 2, U_0) = \frac{1}{3} \cdot \frac{95.24406}{2} = 15.87401$$
  $$x_2^B = h_2(2, 2, U_0) = \frac{2}{3} \cdot \frac{95.24406}{2} = 31.74802$$
  *Verificación de utilidad:* $U(B) = (15.87401)^{1/3} \cdot (31.74802)^{2/3} = 15.87401 \cdot 2^{2/3} = 25.19842 = U_0$.

---

### 3. Descomposición del Efecto Precio

- **Efecto Sustitución de Hicks ($ES$):**
  $$ES = x_1^B - x_1^A = 15.87401 - 10.00000 = +5.87401$$
- **Efecto Ingreso de Hicks ($EI$):**
  $$EI = x_1^C - x_1^B = 20.00000 - 15.87401 = +4.12599$$
- **Verificación de la Ecuación de Hicks:**
  $$ET = ES + EI = 5.87401 + 4.12599 = 10.00000$$

*Comparación con Slutsky:*
El ingreso compensado de Slutsky para comprar la cesta $A = (10, 40)$ a nuevos precios $(2, 2)$ es:
$$I' = 2(10) + 2(40) = 100$$
La cesta de Slutsky es $x_1^{BS} = (1/3)(100/2) = 16.6667$, $x_2^{BS} = (2/3)(100/2) = 33.3333$.
Por tanto: $ES_{Slutsky} = 16.6667 - 10 = +6.6667$, y $EI_{Slutsky} = 20 - 16.6667 = +3.3333$.
Nótese que $ES_{Slutsky} > ES_{Hicks}$ porque la compensación de Slutsky deja al consumidor en una recta secante a la curva de indiferencia, permitiéndole alcanzar un nivel de utilidad estrictamente superior a $U_0$.

---

### 4. Variación Compensatoria ($CV$) y Variación Equivalente ($EV$)

- **Variación Compensatoria:**
  $$CV = I - e(p^1, U_0) = 120 - 95.24406 = \$24.75594$$
  *Interpretación:* Es el impuesto de suma fija máximo que el Estado puede recaudar del consumidor tras la reducción de precios dejándolo exactamente tan bien como al inicio.

- **Variación Equivalente:**
  $$e(p^0, U_1) = 120 \cdot \left(\frac{p_1^0}{p_1^1}\right)^{1/3} = 120 \cdot 2^{1/3} \approx 120 \cdot 1.259921 = 151.19053$$
  $$EV = e(p^0, U_1) - I = 151.19053 - 120 = \$31.19053$$
  *Interpretación:* Es la transferencia monetaria que el consumidor exigiría a los precios iniciales en lugar de que se apruebe la rebaja arancelaria.

- **Desigualdad Hicksiana:**
  El cambio en el excedente del consumidor de Marshall es:
  $$\Delta EC_{Marshall} = \int_{2}^{4} \frac{40}{p_1} dp_1 = 40 \ln(4/2) = 40 \ln(2) \approx 40(0.693147) = \$27.72589$$
  Se verifica con exactitud matemática:
  $$CV (\$24.76) < \Delta EC_{Marshall} (\$27.73) < EV (\$31.19)$$

---

# Solución al Ejercicio 2: Activos Contingentes de Arrow y Equilibrio General con Riesgo (Nivel Intermedio)

### 1. Autarquía y Costo de la Falta de Cobertura

- **Utilidades Esperadas en Autarquía:**
  - Agente A:
    $$U_A(\omega_A) = 0.6 \ln(120) + 0.4 \ln(30) = 0.6(4.78749) + 0.4(3.40120) = 4.23297$$
    $$CE_A = \exp(4.23297) = 120^{0.6} \cdot 30^{0.4} = 69.8517$$
  - Agente B:
    $$U_B(\omega_B) = 0.6 \ln(30) + 0.4 \ln(70) = 0.6(3.40120) + 0.4(4.24850) = 3.74012$$
    $$CE_B = \exp(3.74012) = 30^{0.6} \cdot 70^{0.4} = 42.0739$$

---

### 2. Equilibrio Competitivo Walrasiano con Mercados Completos de Arrow

Normalizando $q_2 = 1$:
- Riquezas:
  $$W_A(q_1) = 120 q_1 + 30$$
  $$W_B(q_1) = 30 q_1 + 70$$

- Demandas Óptimas:
  Para utilidad logarítmica con probabilidades $(\pi_1, \pi_2) = (0.6, 0.4)$:
  $$c_{i1}(q_1) = \frac{0.6 W_i}{q_1}, \quad c_{i2}(q_1) = 0.4 W_i$$

- Vaciado del Mercado en Estado 1:
  $$c_{A1} + c_{B1} = \Omega_1 \iff \frac{0.6(W_A + W_B)}{q_1} = 150$$
  $$0.6(150 q_1 + 100) = 150 q_1 \iff 90 q_1 + 60 = 150 q_1 \iff 60 q_1 = 60 \iff q_1^* = 1.0$$

- Comprobación analítica de la fórmula de precios de Arrow:
  $$q_1^* = \frac{\pi_1}{\pi_2} \cdot \frac{\Omega_2}{\Omega_1} = \frac{0.6}{0.4} \cdot \frac{100}{150} = 1.5 \cdot \frac{2}{3} = 1.0$$

---

### 3. Asignación Óptima y Transferencias Financieras

- Con $q_1^* = 1.0$ y $q_2^* = 1.0$:
  $$W_A^* = 120(1) + 30 = 150, \quad W_B^* = 30(1) + 70 = 100$$
  - Consumos óptimos:
    $$c_{A1}^* = 0.6(150) = 90, \quad c_{A2}^* = 0.4(150) = 60$$
    $$c_{B1}^* = 0.6(100) = 60, \quad c_{B2}^* = 0.4(100) = 40$$

- Posiciones netas en activos de Arrow:
  - Agente A: $\theta_{A1} = 90 - 120 = -30$ (vende 30 contratos del estado 1); $\theta_{A2} = 60 - 30 = +30$ (compra 30 contratos del estado 2).
  - Agente B: $\theta_{B1} = 60 - 30 = +30$ (compra 30 contratos del estado 1); $\theta_{B2} = 40 - 70 = -30$ (vende 30 contratos del estado 2).
  *El mercado financiero de Arrow concilia perfectamente la oferta y demanda de seguro.*

- Ganancias de Bienestar (Equivalente Cierto):
  - Agente A:
    $$U_A^* = 0.6 \ln(90) + 0.4 \ln(60) = 4.33763 \implies CE_A^* = 90^{0.6} \cdot 60^{0.4} = 76.4024$$
    $$\Delta CE_A = 76.4024 - 69.8517 = +6.5507 \quad (+9.38\%)$$
  - Agente B:
    $$U_B^* = 0.6 \ln(60) + 0.4 \ln(40) = 3.93216 \implies CE_B^* = 60^{0.6} \cdot 40^{0.4} = 50.9350$$
    $$\Delta CE_B = 50.9350 - 42.0739 = +8.8611 \quad (+21.06\%)$$

---

### 4. Curva de Contrato

Igualando las Relaciones Marginales de Sustitución entre estados:
$$\text{RMS}_A = \frac{0.6 / c_{A1}}{0.4 / c_{A2}} = 1.5 \frac{c_{A2}}{c_{A1}}$$
$$\text{RMS}_B = \frac{0.6 / (150 - c_{A1})}{0.4 / (100 - c_{A2})} = 1.5 \frac{100 - c_{A2}}{150 - c_{A1}}$$
$$\frac{c_{A2}}{c_{A1}} = \frac{100 - c_{A2}}{150 - c_{A1}} \iff c_{A2} = \frac{100}{150} c_{A1} = \frac{2}{3} c_{A1}$$
La curva de contrato es la recta con pendiente $2/3$, que une el origen del Agente A con el origen del Agente B. Al ser la dotación agregada asimétrica ($\Omega_1 = 150 \ne \Omega_2 = 100$), el consumo en cada estado guarda exactamente la proporción de la abundancia macroeconómica agregada.

---

# Solución al Ejercicio 3: El Teorema de Imposibilidad de Arrow y la Regla de la Mayoría (Nivel Avanzado / Reto)

### 1. Paradoja de Condorcet e Intransitividad

Evaluando las votaciones por pares:
- **$A$ frente a $B$:**
  - Votante 1: $A \succ_1 B$
  - Votante 2: $B \succ_2 A$
  - Votante 3: $A \succ_3 B$ (pues $C \succ_3 A \succ_3 B$)
  - Resultado: $A$ vence a $B$ por 2 votos a 1 ($A \succ_{soc} B$).
- **$B$ frente a $C$:**
  - Votante 1: $B \succ_1 C$
  - Votante 2: $B \succ_2 C$
  - Votante 3: $C \succ_3 B$
  - Resultado: $B$ vence a $C$ por 2 votos a 1 ($B \succ_{soc} C$).
- **$C$ frente a $A$:**
  - Votante 1: $A \succ_1 C$
  - Votante 2: $C \succ_2 A$
  - Votante 3: $C \succ_3 A$
  - Resultado: $C$ vence a $A$ por 2 votos a 1 ($C \succ_{soc} A$).

**Conclusión:** Las preferencias colectivas forman el ciclo $A \succ_{soc} B \succ_{soc} C \succ_{soc} A$, violando el axioma de **transitividad**. No existe alternativa dominante (ganador de Condorcet), por lo que quien controle el orden de la agenda parlamentaria puede manipular el resultado final a su antojo (*Agenda Manipulation*).

---

### 2. Axiomas de Kenneth Arrow

- **Dominio No Restringido ($U$):** La regla $F$ debe estar definida para cualquier perfil concebible de preferencias individuales transitivas.
- **Principio de Pareto Débil ($P$):** Si $\forall i \in N$, $x \succ_i y$, entonces $x \succ_{soc} y$.
- **Independencia de Alternativas Irrelevantes ($I$):** Si dos perfiles de preferencias coinciden en los ordenamientos relativos entre $x$ e $y$, el ordenamiento social resultante entre $x$ e $y$ debe ser idéntico en ambos perfiles, sin verse afectado por la posición de una tercera opción $z$.
- **No Dictadura ($D$):** No existe ningún individuo $d \in N$ tal que $\forall (x, y)$, si $x \succ_d y$, entonces $x \succ_{soc} y$, independientemente de las preferencias del resto.

---

### 3. Demostración del Teorema de Imposibilidad

**Definición:** Una coalición $S \subseteq N$ es decisiva para $(x, y)$ (denotado $D_S(x, y)$) si siempre que $\forall i \in S$, $x \succ_i y$ y $\forall j \notin S$, $y \succ_j x$, la sociedad ordena $x \succ_{soc} y$.

1. **Lema de Extensión:** Por el axioma de Pareto ($P$), la gran coalición $N$ es decisiva. Por tanto, existe al menos una coalición decisiva no vacía.
2. **Coalición Mínima Decisiva:** Sea $S^*$ una coalición decisiva para algún par $(x, y)$ con el mínimo número de miembros posibles. Sea $i \in S^*$ y sea $R = S^* \setminus \{i\}$. Si $S^*$ tiene más de un miembro, $R$ es no vacía.
3. Considérese un perfil donde:
   - Para el individuo $i$: $x \succ_i y \succ_i z$.
   - Para los individuos en $R$: $y \succ_j z \succ_j x$.
   - Para los individuos fuera de $S^*$: $z \succ_k x \succ_k y$.
4. Dado que $S^* = \{i\} \cup R$ es decisiva para $(x, y)$, y todos en $S^*$ prefieren $x \succ y$ mientras el resto prefiere $y \succ x$, la sociedad debe ordenar:
   $$x \succ_{soc} y$$
5. Respecto al par $(y, z)$: Solo los miembros de $R$ prefieren $y \succ z$, mientras que $i$ y los ajenos prefieren $z \succ y$. Si la sociedad ordenara $y \succ_{soc} z$, entonces $R$ sería decisiva para $(y, z)$, lo que contradiría que $S^*$ era la coalición decisiva de tamaño mínimo (ya que $|R| < |S^*|$). Por ende, debe cumplirse que la sociedad **no** prefiere $y$ sobre $z$, o que $z \succsim_{soc} y$.
6. Pero si $x \succ_{soc} y$ y no ocurre que $y \succ_{soc} z$, por transitividad se deduce que $x \succ_{soc} z$.
7. Sin embargo, en la comparación entre $x$ y $z$, el único individuo que prefiere $x \succ_i z$ es el individuo $i$ aislado; todos los demás prefieren $z \succ x$. En consecuencia, el individuo $i$ por sí solo es decisivo para $(x, z)$.
8. Esto contradice que la coalición mínima tuviera más de un miembro. Por inducción, la coalición decisiva mínima consta de un único individuo $d$. Generalizando a todos los pares mediante permutaciones basadas en el axioma $I$, el individuo $d$ es un **Dictador**, violando $D$. $\blacksquare$

---

### 4. Rúbrica de Evaluación

| Criterio | Excelente (90–100%) | Satisfactorio (70–89%) | Insuficiente (<70%) |
| :--- | :--- | :--- | :--- |
| **Ejercicio 1: Dualidad y Hicks** | Deriva analíticamente $h_i(p,u)$, $e(p,u)$, descompone $ET = ES + EI$ con exactitud decimal y verifica la desigualdad $CV < \Delta EC < EV$. | Resuelve demandas y descompone efectos pero comete errores menores en el cálculo de $CV$ o $EV$. | Confunde la compensación de Hicks con Slutsky o no aplica la función de gasto. |
| **Ejercicio 2: Activos de Arrow** | Halla $q_1^* = 1.0$, consumos de equilibrio, posiciones de cobertura financiera y demuestra ganancia de bienestar vía Equivalente Cierto. | Resuelve precios pero no cuantifica la cartera de cobertura ni las ganancias de bienestar. | No comprende la estructura de activos contingentes ni el vaciado de mercado por estados. |
| **Ejercicio 3: Teorema de Arrow** | Formaliza el ciclo de Condorcet, los 4 axiomas de Arrow y demuestra paso a paso la existencia del dictador mediante coaliciones decisivas. | Explica los axiomas y el ciclo de Condorcet pero la demostración formal de imposibilidad es incompleta. | Solo define cualitativamente la paradoja sin rigor axiomático. |

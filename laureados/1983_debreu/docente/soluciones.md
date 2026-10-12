# Guía Pedagógica y Solucionario Completo: Gérard Debreu (Nobel 1983)

## Orientaciones para el Docente

Este módulo formativo está diseñado para cursos avanzados de Microeconomía (nivel pregrado superior o maestría), Economía Matemática y Teoría de Juegos. El objetivo pedagógico central es que el estudiante domine con rigor analítico la transición desde la intuición gráfica del equilibrio walrasiano hacia la formulación axiomática conjuntista y la teoría de juegos cooperativos desarrollada por Gérard Debreu.

---

# Solución al Ejercicio 1: Equilibrio Competitivo Arrow-Debreu en la Caja de Edgeworth (Nivel Básico)

### 1. Rentas y Funciones de Demanda Marshallianas

Con el bien 2 como numerario ($p_2 = 1$) y denotando $p_1 = p$:
- **Consumidor A:**
  - Dotación: $\omega_A = (8, 2)$.
  - Renta monetaria: $I_A(p) = p \cdot 8 + 1 \cdot 2 = 8p + 2$.
  - Utilidad Cobb-Douglas: $U_A = x_{1A}^{0.6} x_{2A}^{0.4}$. Las participaciones presupuestarias óptimas son $\alpha = 0.6$ para el bien 1 y $(1 - \alpha) = 0.4$ para el bien 2:
    $$x_{1A}(p) = \frac{0.6 \cdot I_A(p)}{p} = \frac{0.6 (8p + 2)}{p} = 4.8 + \frac{1.2}{p}$$
    $$x_{2A}(p) = \frac{0.4 \cdot I_A(p)}{1} = 0.4 (8p + 2) = 3.2p + 0.8$$

- **Consumidor B:**
  - Dotación: $\omega_B = (2, 8)$.
  - Renta monetaria: $I_B(p) = p \cdot 2 + 1 \cdot 8 = 2p + 8$.
  - Utilidad Cobb-Douglas: $U_B = x_{1B}^{0.4} x_{2B}^{0.6}$:
    $$x_{1B}(p) = \frac{0.4 \cdot I_B(p)}{p} = \frac{0.4 (2p + 8)}{p} = 0.8 + \frac{3.2}{p}$$
    $$x_{2B}(p) = \frac{0.6 \cdot I_B(p)}{1} = 0.6 (2p + 8) = 1.2p + 4.8$$

### 2. Vaciado de Mercados y Precios de Equilibrio

- **Exceso de demanda agregada del bien 1:**
  $$z_1(p) = x_{1A}(p) + x_{1B}(p) - (\omega_{1A} + \omega_{1B})$$
  $$z_1(p) = \left(4.8 + \frac{1.2}{p}\right) + \left(0.8 + \frac{3.2}{p}\right) - (8 + 2) = 5.6 + \frac{4.4}{p} - 10 = \frac{4.4}{p} - 4.4$$

- **Condición de equilibrio ($z_1(p^*) = 0$):**
  $$\frac{4.4}{p^*} - 4.4 = 0 \iff \frac{4.4}{p^*} = 4.4 \iff p^* = 1.0$$
  El vector de precios relativos de equilibrio es $p^* = (p_1^*, p_2^*) = (1, 1)$.

- **Verificación de la Ley de Walras en el bien 2:**
  $$p_1 z_1(p) + p_2 z_2(p) \equiv 0 \implies 1 \cdot 0 + 1 \cdot z_2(p^*) = 0 \implies z_2(p^*) = 0$$
  Comprobación directa:
  $$x_{2A}(1) + x_{2B}(1) = (3.2(1) + 0.8) + (1.2(1) + 4.8) = 4.0 + 6.0 = 10.0 = \omega_{2A} + \omega_{2B}$$

### 3. Asignación de Equilibrio y Ganancias del Comercio

- **Asignaciones evaluadas en $p^* = 1$:**
  $$x_A^* = (4.8 + 1.2, 3.2 + 0.8) = (6.0, 4.0)$$
  $$x_B^* = (0.8 + 3.2, 1.2 + 4.8) = (4.0, 6.0)$$

- **Comparación de Utilidades:**
  - En la dotación inicial:
    $$U_A(\omega_A) = 8^{0.6} \cdot 2^{0.4} = (2^3)^{0.6} \cdot 2^{0.4} = 2^{1.8} \cdot 2^{0.4} = 2^{2.2} \approx 4.594793$$
    $$U_B(\omega_B) = 2^{0.4} \cdot 8^{0.6} = 2^{0.4} \cdot 2^{1.8} = 2^{2.2} \approx 4.594793$$
  - En el equilibrio competitivo:
    $$U_A(x_A^*) = 6^{0.6} \cdot 4^{0.4} \approx 4.46497 \cdot 1.74110 \approx 5.101716$$
    $$U_B(x_B^*) = 4^{0.4} \cdot 6^{0.6} \approx 5.101716$$
  - Ganancia porcentual de bienestar:
    $$\Delta U \% = \frac{5.101716 - 4.594793}{4.594793} \times 100\% = +11.0325\%$$
  Ambos agentes ganan exactamente un $11.03\%$ de utilidad, demostrando el beneficio mutuo del comercio voluntario y el Primer Teorema Fundamental del Bienestar.

### 4. Curva de Contrato Analítica

- **Relaciones Marginales de Sustitución:**
  $$\text{RMS}_A = -\left.\frac{dx_{2A}}{dx_{1A}}\right|_{U_A} = \frac{\partial U_A / \partial x_{1A}}{\partial U_A / \partial x_{2A}} = \frac{0.6 x_{1A}^{-0.4} x_{2A}^{0.4}}{0.4 x_{1A}^{0.6} x_{2A}^{-0.6}} = \frac{0.6}{0.4} \frac{x_{2A}}{x_{1A}} = 1.5 \frac{x_{2A}}{x_{1A}}$$
  Para el agente B, sabiendo que $x_{1B} = 10 - x_{1A}$ y $x_{2B} = 10 - x_{2A}$:
  $$\text{RMS}_B = \frac{\partial U_B / \partial x_{1B}}{\partial U_B / \partial x_{2B}} = \frac{0.4}{0.6} \frac{x_{2B}}{x_{1B}} = \frac{2}{3} \frac{10 - x_{2A}}{10 - x_{1A}}$$

- **Condición de tangencia de Pareto ($\text{RMS}_A = \text{RMS}_B$):**
  $$1.5 \frac{x_{2A}}{x_{1A}} = \frac{2}{3} \frac{10 - x_{2A}}{10 - x_{1A}} \iff \frac{9}{4} \frac{x_{2A}}{x_{1A}} = \frac{10 - x_{2A}}{10 - x_{1A}}$$
  Multiplicando en cruz:
  $$9 x_{2A} (10 - x_{1A}) = 4 x_{1A} (10 - x_{2A})$$
  $$90 x_{2A} - 9 x_{1A} x_{2A} = 40 x_{1A} - 4 x_{1A} x_{2A}$$
  $$90 x_{2A} - 5 x_{1A} x_{2A} = 40 x_{1A} \iff x_{2A} (90 - 5 x_{1A}) = 40 x_{1A}$$
  Dividiendo numerador y denominador entre 5:
  $$x_{2A} = \frac{8 x_{1A}}{18 - x_{1A}}$$

- **Evaluación en el punto de equilibrio $(6, 4)$:**
  $$x_{2A}(6) = \frac{8(6)}{18 - 6} = \frac{48}{12} = 4.0$$
  El punto $(6,4)$ pertenece a la curva de contrato. Asimismo:
  $$\text{RMS}_A(6, 4) = 1.5 \left(\frac{4}{6}\right) = 1.0 = \text{RMS}_B(4, 6) = \frac{p_1^*}{p_2^*}$$
  Se verifica la tangencia mutua entre las curvas de indiferencia y la recta presupuestaria.

---

# Solución al Ejercicio 2: El Teorema del Núcleo de Debreu-Scarf (Nivel Intermedio)

### 1. El Núcleo para $N = 1$
- **Definición de Núcleo:** Es el conjunto de asignaciones factibles que no pueden ser mejoradas por ninguna coalición de agentes.
- En una economía de 2 agentes, los únicos subconjuntos de agentes son:
  - Coaliciones unifamiliares $\{A\}$ y $\{B\}$: imponen la **racionalidad individual** ($U_A(x_A) \ge U_A(\omega_A)$ y $U_B(x_B) \ge U_B(\omega_B)$).
  - La gran coalición $\{A, B\}$: impone la **eficiencia en el sentido de Pareto** (pertenencia a la curva de contrato).
- **Límites de $x_{1A}$ en el Núcleo:**
  - Límite inferior (donde $U_A = U_A(\omega_A) = 4.5948$): $x_{1A}^{min} = 5.4939$, con $x_{2A} = 3.5144$.
  - Límite superior (donde $U_B = U_B(\omega_B) = 4.5948$): $x_{1A}^{max} = 6.4856$, con $x_{2A} = 4.5061$.
  - Amplitud del núcleo: $\Delta x_{1A} = 6.4856 - 5.4939 = 0.9917$. Existe una amplia zona de indeterminación donde el poder de negociación bilateral determina el reparto del excedente.

### 2. La Propiedad de Igualdad de Trato (*Equal Treatment*)
Debreu y Scarf (1963) demuestran que ninguna asignación que trate de modo desigual a agentes idénticos puede pertenecer al núcleo.
- **Demostración intuitiva:** Supongamos que en una réplica $N=2$, $A_1$ recibe $x_{A1}$ y $A_2$ recibe $x_{A2}$ con $U_A(x_{A1}) < U_A(x_{A2})$.
- Como las preferencias son estrictamente convexas, la cesta promedio $\bar{x}_A = \frac{x_{A1} + x_{A2}}{2}$ satisface $U_A(\bar{x}_A) > U_A(x_{A1})$.
- La gran coalición o una coalición de los agentes desfavorecidos junto con una selección de agentes del otro tipo puede formar una coalición más pequeña que asigne el promedio y mejore estrictamente a todos sus miembros. Por tanto, el agente peor tratado siempre encontrará socios para bloquear la discriminación. En todo núcleo replicado, $x_{A1} = x_{A2} = x_A$ y $x_{B1} = x_{B2} = x_B$.

### 3. Mecanismo de Bloqueo por Coaliciones Asimétricas
- Si se propone una asignación extrema como $x_{1A} = 5.50$ (donde los agentes $A$ reciben casi su utilidad de reserva $4.5948$ y los agentes $B$ se quedan con toda la ganancia del comercio):
- En $N=1$, los agentes $A$ no pueden bloquear solos porque necesitan el bien 2 que posee $B$.
- En $N=2$, existen dos agentes $A$ y dos agentes $B$. Consideremos la coalición formada por **dos agentes $A$ y un solo agente $B$** ($S = \{A_1, A_2, B_1\}$):
  - Recursos de la coalición:
    $$2 \omega_A + 1 \omega_B = 2(8, 2) + 1(2, 8) = (18, 12)$$
  - Si esta coalición le entrega a $B_1$ su cesta asignada $x_B = (10 - 5.50, 10 - 3.52) = (4.50, 6.48)$, a los dos agentes $A$ les queda un remanente colectivo de:
    $$(18 - 4.50, 12 - 6.48) = (13.50, 5.52)$$
  - Cada agente $A$ recibiría $\left(\frac{13.50}{2}, \frac{5.52}{2}\right) = (6.75, 2.76)$.
  - Utilidad resultante para cada $A$: $U_A(6.75, 2.76) = 6.75^{0.6} \cdot 2.76^{0.4} \approx 4.71 > 4.5948$.
  - ¡Ambos agentes $A$ mejoran estrictamente y el agente $B_1$ no empeora! Por tanto, la coalición asimétrica $\{A_1, A_2, B_1\}$ **bloquea la asignación**.
  - Este mecanismo elimina sistemáticamente las asignaciones alejadas del equilibrio competitivo.

### 4. Convergencia Asintótica
- La contracción empírica observada en los datos es:
  - $N = 1 \implies \Delta x_{1A} = 0.9917$
  - $N = 2 \implies \Delta x_{1A} = 0.3056$ (reducción del 69.18%)
  - $N = 5 \implies \Delta x_{1A} = 0.1011$ (reducción del 89.81%)
  - $N = 20 \implies \Delta x_{1A} = 0.0234$ (reducción del 97.64%)
- **Tasa de convergencia:** La amplitud decae a una tasa de orden $O(1/N)$.
- **Implicación institucional:** La competencia perfecta (precios tomados como dados) no es una hipótesis ad-hoc arbitraria sobre el comportamiento psicológico de los agentes; es el **resultado necesario de la libre formación de coaliciones en una economía grande**. A medida que el número de agentes crece, el poder de monopolio u oligopolio de cualquier coalición se disuelve por la amenaza de deserción competitiva de socios comerciales.

---

# Solución al Ejercicio 3: Economías Regulares y el Teorema SMD (Nivel Reto)

### 1. Multiplicidad y el Teorema de Sonnenschein-Mantel-Debreu (SMD)
- El Teorema de Kakutani utilizado por Arrow y Debreu garantiza que el conjunto de equilibrios $E = \{p \in \Delta : z(p) \le 0\}$ es no vacío y compacto. Sin embargo, no impone ninguna restricción sobre su cardinalidad (puede haber 1, 3, o infinitos equilibrios continuos).
- **El Teorema SMD (1973–1974):** Hugo Sonnenschein, Rolf Mantel y Gérard Debreu demostraron que las únicas restricciones que la teoría neoclásica de la elección racional impone sobre la función de exceso de demanda agregada $z(p)$ en precios estrictamente positivos son:
  1. Continuidad.
  2. Homogeneidad de grado cero en precios ($z(\lambda p) = z(p)$ para $\lambda > 0$).
  3. Ley de Walras ($p \cdot z(p) = 0$).
- Por ende, a nivel agregado, el exceso de demanda puede tener cualquier pendiente arbitraria, pendientes positivas (violando la ley de la demanda agregada), múltiples intersecciones con cero e inestabilidad dinámica bajo el tanteo walrasiano (*tâtonnement*).

### 2. Definición de Economía Regular
- Sea $z(p; \omega)$ la función de exceso de demanda agregada para los primeros $l-1$ bienes (excluyendo el numerario). Un vector de precios $p^*$ es un equilibrio para la economía parametrizada por las dotaciones $\omega$ si $z(p^*; \omega) = 0$.
- La economía $\mathcal{E}_\omega$ es **regular** si en todo equilibrio $p^*$, la matriz Jacobiana respecto a los precios $Dz(p^*; \omega) = \left[ \frac{\partial z_i}{\partial p_j} \right]_{(l-1) \times (l-1)}$ es no singular, es decir:
  $$\det Dz(p^*; \omega) \neq 0$$
- **Aplicación del Teorema de la Función Implícita:**
  Si $\det Dz(p^*) \neq 0$, existe una vecindad alrededor de $\omega$ donde el vector de precios de equilibrio es una función unívoca y continuamente diferenciable de los parámetros de dotación: $p^* = g(\omega)$.
  Esto garantiza que los equilibrios son **aislados (localmente únicos)** y que la estática comparativa es rigurosamente válida.

### 3. El Teorema de Sard y la Genericidad del Equilibrio
- **Enunciado del Teorema de Sard:** Sea $f: M \to N$ una función suave entre variedades diferenciales. El conjunto de valores críticos de $f$ (imágenes de puntos donde la derivada no tiene rango completo) tiene medida de Lebesgue cero en la variedad codominio $N$.
- **La demostración de Debreu (1970):**
  Debreu definió la variedad de equilibrio $E = \{(p, \omega) : z(p; \omega) = 0\}$ y la proyección natural $\pi: E \to \Omega$, donde $\pi(p, \omega) = \omega$.
  Una economía $\omega$ es singular si es un valor crítico de $\pi$.
  Por el Teorema de Sard, el conjunto de economías singulares tiene **medida de Lebesgue cero** y su complemento (las economías regulares) es un conjunto **abierto y denso** en el espacio de dotaciones $\Omega$.
- **Importancia:** Debreu demostró que aunque el Teorema SMD permite patologías teóricas, "casi todas" las economías del mundo real son regulares: tienen un número finito e impar de equilibrios y son robustas ante perturbaciones estocásticas de las dotaciones.

---

# Rúbrica de Evaluación Cuantitativa

| Criterio de Evaluación | Excelente (90–100%) | Satisfactorio (70–89%) | Requiere Mejora (<70%) |
|:---|:---|:---|:---|
| **Cálculo de Equilibrio Arrow-Debreu (Ej. 1)** | Deducción analítica exacta de demandas, precios relativos ($p^*=1$), asignaciones ($6,4$) y curva de contrato con verificación de tangencia. | Resuelve demandas y precios correctamente, pero comete errores menores en la curva de contrato o utilidades. | No formula adecuadamente las demandas ni el vaciado de mercado; confunde precios relativos con absolutos. |
| **Teorema del Núcleo y Coaliciones (Ej. 2)** | Define con precisión el Núcleo, demuestra la igualdad de trato, ilustra el bloqueo asimétrico ($2A+1B$) y explica la tasa $O(1/N)$. | Comprende el núcleo y el bloqueo, pero falla en la formalización analítica de los recursos de la coalición. | Confunde el núcleo con la curva de contrato o no comprende cómo una coalición bloquea una asignación. |
| **Topología Diferencial y Regularidad (Ej. 3)** | Articula el Teorema SMD, define economía regular vía el Jacobiano, explica el Teorema de Sard y su relevancia de genericidad. | Explica SMD y regularidad conceptualmente, pero con imprecisiones en el uso del Teorema de la Función Implícita o Sard. | No identifica el problema de multiplicidad ni la definición matemática de regularidad. |
| **Rigor y Presentación Formal** | Notación matemática impecable, interpretaciones económicas profundas, coherencia deductiva y honestidad intelectual. | Notación adecuada y desarrollo comprensible, con explicaciones económicas breves. | Notación descuidada, falta de justificación formal en los pasos algebraicos. |

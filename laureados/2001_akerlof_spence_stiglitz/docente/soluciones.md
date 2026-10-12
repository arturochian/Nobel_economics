# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2001: George Akerlof, Michael Spence y Joseph Stiglitz

> **Nota pedagógica para el docente:** Este documento contiene las derivaciones matemáticas completas, soluciones algebraicas y explicaciones conceptuales correspondientes a la guía de ejercicios de `estudiante/ejercicios.qmd`. Diseñado para apoyar la docencia de microeconomía intermedia y avanzada, teoría de contratos y economía de la información.

---

### Solución Ejercicio 1: Selección Adversa y Colapso del Mercado (Akerlof, 1970)

#### 1. Información Simétrica (Primer Mejor)
- **a) Proporción del parque comercializada:**
  Con información perfecta, el comprador conoce la calidad exacta $q$ de cada auto. Dado que $V_B(q) = 1.40 q > q = V_S(q)$ para todo $q > 0$, existe ganancia mutua del intercambio en todas las transacciones. El precio puede fijarse en cualquier $P(q) \in [q, 1.40q]$.  
  Por tanto, **se comercializa el $100\%$ del parque automotor**.
- **b) Excedente social total ($W^{FB}$):**
  Como la distribución es uniforme $q \sim \mathcal{U}[0, 120]$, la función de densidad es $f(q) = \frac{1}{120}$:
  $$W^{FB} = \int_{0}^{120} (V_B(q) - V_S(q)) f(q) dq = \int_{0}^{120} (1.40 q - q) \frac{1}{120} dq$$
  $$W^{FB} = 0.40 \cdot \frac{1}{120} \left[ \frac{q^2}{2} \right]_{0}^{120} = 0.40 \cdot \frac{1}{120} \cdot \frac{14400}{2} = 0.40 \cdot 60 = \mathbf{24.0 \text{ unidades de bienestar}}$$

---

#### 2. Información Asimétrica y Calidad en Oferta
- **a) Oferta de vehículos:**
  Un vendedor suministra su auto si el precio de mercado $P$ compensa al menos su precio de reserva: $P \ge V_S(q) = q$.  
  Por tanto, el conjunto de autos ofrecidos es:
  $$\mathcal{S}(P) = \{q \in [0, 120] : q \le P\}$$
  Si $P < 120$, los autos ofrecidos son aquellos con calidad $q \in [0, P]$. Los propietarios con autos de alta calidad ($q > P$) se retiran del mercado.
- **b) Calidad promedio ofertada:**
  Dado que los autos en el mercado están uniformemente distribuidos en $[0, P]$:
  $$\bar{q}(P) = \mathbb{E}[q \mid q \le P] = \frac{0 + P}{2} = \mathbf{\frac{P}{2}}$$

---

#### 3. Disposición a Pagar y Condición de Equilibrio
- **a) Ecuación de equilibrio de precios:**
  Los compradores neutrales al riesgo ofrecen un precio igual a su valoración esperada:
  $$P = \mathbb{E}[V_B \mid P] = \alpha \cdot \bar{q}(P) = 1.40 \left( \frac{P}{2} \right) = \mathbf{0.70 P}$$
- **b) Resolución del precio de equilibrio ($P^*$):**
  $$P = 0.70 P \iff P(1 - 0.70) = 0 \iff 0.30 P = 0 \implies \mathbf{P^* = 0}$$
  A $P^* = 0$, ningún vendedor con $q > 0$ está dispuesto a vender.  
  Por lo tanto, **se venden $0$ automóviles ($0\%$ del mercado)** y el excedente social colapsa a $\mathbf{W = 0}$.
- **c) Intuición económica:**
  Este es el núcleo de la tesis de Akerlof: la presencia de asimetría informativa crea una externalidad negativa entre vendedores. Quienes ofrecen vehículos de mala calidad ("limones") deprimen la disposición a pagar promedio, castigando a los vendedores de autos de buena calidad ("cerezas"). Al no poder cobrar su valor real, los dueños de autos buenos se retiran; su retiro reduce aún más la calidad promedio, generando una espiral descendente (*unraveling*) que destruye totalmente el mercado, aun existiendo ganancias de eficiencia universales ($\alpha = 1.40 > 1$).

---

#### 4. Solución Institucional (Certificación Técnica)
- **a) Rango de calidad para certificación voluntaria:**
  Si un vendedor certifica su auto a costo $c = 6$, la calidad $q$ se vuelve pública y puede venderlo al comprador por su valoración total $V_B(q) = 1.40 q$.  
  El vendedor certificará y venderá si su ingreso neto supera su valoración de reserva $q$:
  $$1.40 q - 6 \ge q \iff 0.40 q \ge 6 \iff q \ge \frac{6}{0.40} = \mathbf{15}$$
  Por tanto, **todos los vehículos con calidad $q \in [15, 120]$ serán certificados y vendidos** (el $87.5\%$ del parque automotor). Los vehículos con $q < 15$ ("limones menores") no se certifican porque el costo de la inspección ($6$) supera la ganancia del comercio ($0.40 \cdot 15 = 6$).
- **b) Excedente social neto con certificación:**
  $$W_{\text{cert}} = \int_{15}^{120} (1.40 q - q - 6) \frac{1}{120} dq = \frac{1}{120} \int_{15}^{120} (0.40 q - 6) dq$$
  Calculando la integral:
  $$\int_{15}^{120} 0.40 q \, dq = 0.20 \left[ 120^2 - 15^2 \right] = 0.20 (14400 - 225) = 0.20 (14175) = 2835$$
  $$\int_{15}^{120} 6 \, dq = 6 \cdot (120 - 15) = 6 \cdot 105 = 630$$
  $$W_{\text{cert}} = \frac{2835 - 630}{120} = \frac{2205}{120} = \mathbf{18.375 \text{ unidades}}$$
  *Conclusión pedagógica:* La certificación rescata el mercado, pasando de un bienestar de $0$ a $18.375$ (un $76.6\%$ del bienestar de primer mejor).

---

### Solución Ejercicio 2: Señalización Laboral y Spence-Mirrlees (Spence, 1973)

#### 1. Condición de Spence-Mirrlees (Single-Crossing)
- Curvas de indiferencia: $U_i = w - c_i e \implies w = U_i + c_i e$.
- Tasa marginal de sustitución:
  $$\left. \frac{dw}{de} \right|_{U_L} = c_L = \mathbf{1.20}, \qquad \left. \frac{dw}{de} \right|_{U_H} = c_H = \mathbf{0.60}$$
- **Interpretación:** La condición de cruce único se cumple porque para cualquier nivel de $(e, w)$, la curva de indiferencia del trabajador poco productivo (Tipo L) es estrictamente más empinada que la del trabajador de alta productividad (Tipo H). Esto significa que el trabajador de alta productividad necesita una compensación salarial menor para aceptar un incremento unitario de educación. Sin esta divergencia de costos marginales, la señalización sería imposible, pues cualquier incentivo salarial suficiente para inducir al Tipo H a educarse atraería idénticamente al Tipo L.

---

#### 2. Equilibrio Agrupador (*Pooling*)
- **a) Salario competitivo sin señal ($e = 0$):**
  $$w_{pool} = \mathbb{E}[\theta] = \lambda_L \theta_L + \lambda_H \theta_H = 0.70(12) + 0.30(24) = 8.40 + 7.20 = \mathbf{15.60}$$
- **b) Utilidades netas en pooling:**
  $$U_L^{pool} = 15.60 - 0 = \mathbf{15.60}$$
  $$U_H^{pool} = 15.60 - 0 = \mathbf{15.60}$$

---

#### 3. Equilibrios Separadores
- **a) Compatibilidad de incentivos para el Tipo L ($IC_L$):**
  El Tipo L debe preferir no adquirir educación y ganar $\theta_L = 12$ antes que adquirir $e^*$ y ganar $\theta_H = 24$:
  $$U_L(e=0) \ge U_L(e=e^*) \iff 12 - 0 \ge 24 - 1.20 e^*$$
  $$1.20 e^* \ge 24 - 12 = 12 \implies \mathbf{e^* \ge 10.0}$$
  Por lo tanto, $e^*_{\min} = 10.0$.
- **b) Compatibilidad de incentivos para el Tipo H ($IC_H$):**
  El Tipo H debe preferir educarse al nivel $e^*$ ganando $24$ antes que no educarse y ganar $12$:
  $$U_H(e=e^*) \ge U_H(e=0) \iff 24 - 0.60 e^* \ge 12 - 0$$
  $$0.60 e^* \le 24 - 12 = 12 \implies \mathbf{e^* \le 20.0}$$
  Por lo tanto, $e^*_{\max} = 20.0$.
- **c) Rango de equilibrios separadores:**
  Cualquier nivel educativo en el intervalo $\mathbf{e^* \in [10.0, 20.0]}$ sostiene un equilibrio de señalización separador.

---

#### 4. El Equilibrio de Riley y Pérdida Social de Bienestar
- **a) Umbral de Riley:**
  El equilibrio de Riley selecciona el equilibrio separador más eficiente (de menor costo para los trabajadores de alta productividad):
  $$\mathbf{e^*_{\text{Riley}} = 10.0}$$
- **b) Utilidades en el equilibrio de Riley:**
  $$U_L^{\text{Riley}} = \theta_L - 0 = \mathbf{12.0}$$
  $$U_H^{\text{Riley}} = \theta_H - c_H e^*_{\text{Riley}} = 24 - 0.60(10.0) = 24 - 6.0 = \mathbf{18.0}$$
- **c) Comparación de bienestar social agregado:**
  - **Bienestar con Información Perfecta (Primer Mejor):**
    $$W^{FB} = 0.70(12) + 0.30(24) = \mathbf{15.60}$$
  - **Bienestar en Equilibrio Agrupador ($e=0$):**
    $$W^{pool} = 0.70(15.60) + 0.30(15.60) = \mathbf{15.60}$$
  - **Bienestar en Equilibrio Separador de Riley:**
    $$W^{\text{Riley}} = 0.70(12.0) + 0.30(18.0) = 8.40 + 5.40 = \mathbf{13.80}$$
  - **Pérdida neta de recursos por señalización:**
    $$\Delta W = W^{FB} - W^{\text{Riley}} = 15.60 - 13.80 = \mathbf{1.80 \text{ unidades}}$$
    *Conclusión pedagógica:* Dado que la educación no incrementa la productividad intrínseca en este modelo, el gasto en educación de los trabajadores de alta productividad ($0.30 \times 6.0 = 1.80$) representa una **pérdida de eficiencia social pura**. La señalización permite a los trabajadores de alta productividad apropiarse de una mayor renta privada ($18.0$ vs. $15.60$), pero a costa de empobrecer a los trabajadores de baja productividad ($12.0$ vs. $15.60$) y desperdiciar recursos reales en el proceso.

---

### Solución Ejercicio 3: Screening y Racionamiento de Crédito (Stiglitz-Weiss, 1981)

#### 1. Ganancia del Emprendedor y Selección Adversa
- **a) Emprendedor Seguro (S):**
  Rinde $R_S = 2.0$ con certeza. Su beneficio neto es:
  $$\Pi_S(r) = 2.0 - (1 + r) = 1.0 - r$$
  Solicita el crédito si $\Pi_S(r) \ge 0 \implies \mathbf{r \le r_S^{\max} = 1.0 \ (100\%)}$.
- **b) Emprendedor Arriesgado (A):**
  Rinde $3.6$ con prob. $0.5$ y $0.4$ con prob. $0.5$.  
  Bajo responsabilidad limitada, si $R_A = 0.4 < 1 + r$, el beneficio es $0$.  
  Para $1 + r \in [0.4, 3.6]$, el beneficio esperado es:
  $$\mathbb{E}[\Pi_A(r)] = 0.5 [3.6 - (1 + r)] + 0.5 [0] = 0.5 [2.6 - r] = 1.3 - 0.5 r$$
  Solicita el crédito si $\mathbb{E}[\Pi_A(r)] \ge 0 \implies 1.3 - 0.5 r \ge 0 \implies \mathbf{r \le r_A^{\max} = 2.6 \ (260\%)}$.
- **c) Mecanismo de Selección Adversa:**
  Como $r_A^{\max} = 2.6 > r_S^{\max} = 1.0$, si el banco fija cualquier tasa $r \in (1.0, 2.6]$, **todos los emprendedores con proyectos seguros se retiran del mercado de crédito**, dejando únicamente a los solicitantes con proyectos arriesgados. La subida de la tasa de interés degrada automáticamente la calidad media del pool de prestatarios.

---

#### 2. Retorno Esperado del Banco
- **a) Retorno cuando $r \le 1.0$ (ambos tipos participan en partes iguales):**
  - Retorno cobrado al proyecto seguro: $1 + r$ (no hay default).
  - Retorno cobrado al proyecto arriesgado: $0.5(1 + r) + 0.5(0.4) = 0.5 + 0.5 r + 0.2 = 0.7 + 0.5 r$.
  - Retorno esperado promedio del banco:
    $$\mathbb{E}[\rho(r)] = 0.5(1 + r) + 0.5(0.7 + 0.5 r) = 0.5 + 0.5 r + 0.35 + 0.25 r = \mathbf{0.85 + 0.75 r}$$
    Para la tasa límite $r = 1.0$:
    $$\mathbb{E}[\rho(1.0)] = 0.85 + 0.75(1.0) = \mathbf{1.60}$$
- **b) Retorno cuando $r > 1.0$ (solo quedan prestatarios arriesgados):**
  - El retorno esperado del banco es exclusivamente el del tipo arriesgado:
    $$\mathbb{E}[\rho(r)] = 0.5(1 + r) + 0.5(0.4) = \mathbf{0.70 + 0.50 r}$$
  - Justo después del abandono de los prestatarios seguros ($r = 1.01$):
    $$\mathbb{E}[\rho(1.01)] = 0.70 + 0.50(1.01) = \mathbf{1.205}$$
  - A la tasa máxima factible para los arriesgados $r = 2.6$:
    $$\mathbb{E}[\rho(2.6)] = 0.70 + 0.50(2.6) = 0.70 + 1.30 = \mathbf{2.00}$$
- **c) Forma no monótona del retorno:**
  El retorno del banco alcanza un pico local en $r = 1.0$ con un valor de $1.60$. Inmediatamente después, si el banco eleva la tasa marginalmente a $r = 1.01$, el retorno colapsa a $1.205$ (una caída del $25\%$). Para volver a alcanzar un retorno de $1.60$, el banco tendría que subir la tasa a $r = 1.80$. Sin embargo, en modelos generales con distribuciones continuas de riesgo y esfuerzo no contractible (riesgo moral), la curva de retorno es suavemente cóncava y alcanza un único máximo global $r^*$.

---

#### 3. Racionamiento de Crédito y Relevancia Macroeconómica
- **Por qué el banco no sube la tasa:**
  Si al fijar la tasa óptima $r^* = 1.0$ hay $100$ solicitantes pero el banco sólo tiene fondos para prestar a $60$, el equilibrio walrasiano prescribiría subir la tasa $r$ para equilibrar oferta y demanda. Sin embargo, el banco sabe que subir la tasa provocará la huida de los clientes seguros, aumentando la morosidad y reduciendo sus beneficios netos. Por tanto, el banco mantiene $r^* = 1.0$ y **raciona el crédito mediante una lotería o discreción administrativa**, rechazando al $40\%$ de los clientes idénticos.
- **Vínculo con crisis financieras y PYMEs:**
  Esta teoría fundamenta por qué en periodos de recesión o incertidumbre se produce el fenómeno del **estrangulamiento crediticio** (*credit crunch*). Los bancos no responden a los choques subiendo las tasas de los préstamos, sino contrayendo el volumen de créditos otorgados. Las PYMEs, al carecer de garantías colaterales líquidas para enviar señales de solvencia o neutralizar la selección adversa, son desproporcionadamente racionadas del sistema bancario formal.

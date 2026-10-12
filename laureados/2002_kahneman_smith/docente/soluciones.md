# Solucionario y Guía Pedagógica: Daniel Kahneman y Vernon L. Smith (Premio Nobel 2002)

Esta guía docente acompaña a la carpeta `2002_kahneman_smith`. Proporciona el desarrollo analítico exhaustivo de todos los ejercicios propuestos en `estudiante/ejercicios.qmd`, recomendaciones pedagógicas y una rúbrica sugerida de evaluación.

---

## Solución al Ejercicio 1 (Nivel Básico): Aversión a Pérdidas vs. Utilidad Esperada Neoclásica

### 1. Valor Esperado
- **Lotería $L_1$:**
  $$E[L_1] = 0.5 \times (+200) + 0.5 \times (-100) = 100 - 50 = +\$50$$
  Como $E[L_1] = +\$50 > 0$, un agente neutral al riesgo aceptará la lotería sobre el *status quo* ($S_1 = \$0$).
- **Lotería $L_2$:**
  $$E[L_2] = 0.5 \times (-500) + 0.5 \times (0) = -\$250$$
  El valor esperado de la alternativa cierta es $E[S_2] = -\$250$. Un agente neutral al riesgo se mantendría estrictamente indiferente entre $L_2$ y $S_2$.

---

### 2. Modelo Neoclásico con Utilidad von Neumann-Morgenstern ($u(w) = \ln(w)$, $w_0 = \$10,000$)
- **Elección 1 ($L_1$ vs. $S_1$):**
  - Utilidad del *status quo*:
    $$U(S_1) = \ln(10,000) = 9.21034$$
  - Utilidad esperada de la lotería:
    $$E[U(L_1)] = 0.5 \ln(10,000 + 200) + 0.5 \ln(10,000 - 100) = 0.5 \ln(10,200) + 0.5 \ln(9,900)$$
    $$E[U(L_1)] = 0.5(9.23014) + 0.5(9.20029) = 4.61507 + 4.60015 = 9.21522$$
  - Comparación: Como $E[U(L_1)] = 9.21522 > U(S_1) = 9.21034$, el agente neoclásico **acepta la inversión**. Debido a que el monto en juego ($\$100--\$200$) es minúsculo respecto de la riqueza total ($\$10,000$), la curvatura de la función de utilidad es localmente lineal (casi neutralidad al riesgo).

- **Elección 2 ($L_2$ vs. $S_2$):**
  - Utilidad de la pérdida segura:
    $$U(S_2) = \ln(10,000 - 250) = \ln(9,750) = 9.18502$$
  - Utilidad esperada de la lotería:
    $$E[U(L_2)] = 0.5 \ln(9,500) + 0.5 \ln(10,000) = 0.5(9.15905) + 0.5(9.21034) = 9.18469$$
  - Comparación: Como $U(S_2) = 9.18502 > E[U(L_2)] = 9.18469$, el individuo prefiere la **pérdida segura $S_2$**. La concavidad global de $\ln(w)$ genera aversión al riesgo en todos los cuadrantes.

---

### 3. Teoría Prospectiva de Kahneman y Tversky ($v(x)$, $\alpha = \beta = 0.88$, $\lambda = 2.25$)
- **Elección 1 ($L_1$ vs. $S_1$):**
  - Valor subjetivo de la ganancia:
    $$v(+200) = 200^{0.88} \approx 105.15$$
  - Valor subjetivo de la pérdida:
    $$v(-100) = -2.25 \times (100^{0.88}) = -2.25 \times 57.544 \approx -129.47$$
  - Valor prospectivo de la lotería:
    $$V(L_1) = 0.5 \, v(+200) + 0.5 \, v(-100) = 0.5(105.15) + 0.5(-129.47) = 52.575 - 64.735 = -12.16$$
  - Como $V(L_1) = -12.16 < v(0) = 0$, ¡el individuo **rechaza enérgicamente** la lotería $L_1$!
  - **Explicación cualitativa:** La teoría neoclásica predice que la gente debería aceptar apuestas favorables si la riqueza base es alta (teorema de calibración de Rabin). Sin embargo, empíricamente la gran mayoría de las personas rechazan esta apuesta. Kahneman y Tversky demostraron que evaluamos ganancias y pérdidas en cuentas mentales separadas respecto al punto de referencia, y el dolor de perder $\$100$ está multiplicado por $\lambda = 2.25$, superando el placer de ganar $\$200$.

- **Elección 2 ($L_2$ vs. $S_2$):**
  - Valor subjetivo de la pérdida segura $S_2$:
    $$V(S_2) = v(-250) = -2.25 \times (250^{0.88}) = -2.25 \times 128.63 \approx -289.42$$
  - Valor subjetivo de la lotería $L_2$:
    $$v(-500) = -2.25 \times (500^{0.88}) = -2.25 \times 236.75 \approx -532.69$$
    $$V(L_2) = 0.5 \, v(-500) + 0.5 \, v(0) = 0.5(-532.69) + 0 = -266.35$$
  - Como $V(L_2) = -266.35 > V(S_2) = -289.42$ (nótese que $-266.35$ es menos negativo que $-289.42$), el individuo **prefiere la lotería de riesgo $L_2$** sobre la pérdida segura $S_2$.
  - Muestra una conducta de **búsqueda de riesgo (*risk-seeking*) en el dominio de pérdidas**, provocada por la convexidad de $v(x)$ para $x < 0$ ($\beta = 0.88 < 1$, sensibilidad marginal decreciente al dolor).

---

## Solución al Ejercicio 2 (Nivel Intermedio): Ponderación de Probabilidades y Subasta Doble de Smith

### Parte A: Loterías y Ponderación de Probabilidades

1. **Valores Ponderados $w(p)$ con $\gamma = 0.61$:**
   Fórmula: $w(p) = \frac{p^{0.61}}{\left( p^{0.61} + (1-p)^{0.61} \right)^{1 / 0.61}}$
   - $p = 0.001 \implies w(0.001) \approx 0.0145 \quad (\text{Ratio } w/p = 14.5)$
   - $p = 0.01 \implies w(0.01) \approx 0.0570 \quad (\text{Ratio } w/p = 5.70)$
   - $p = 0.10 \implies w(0.10) \approx 0.1856 \quad (\text{Ratio } w/p = 1.86)$
   - $p = 0.50 \implies w(0.50) \approx 0.4206 \quad (\text{Ratio } w/p = 0.84)$
   - $p = 0.90 \implies w(0.90) \approx 0.7121 \quad (\text{Ratio } w/p = 0.79)$
   - $p = 0.99 \implies w(0.99) \approx 0.9123 \quad (\text{Ratio } w/p = 0.92)$

2. **Rango de Sobreponderación y Subponderación:**
   El punto de cruce con la diagonal de 45° ocurre aproximadamente en $p^* \approx 0.35$:
   - Para $p < 0.35$: $w(p) > p$ (**sobreponderación de probabilidades bajas**). El ratio $w/p$ se dispara conforme $p \to 0$.
   - Para $p > 0.35$: $w(p) < p$ (**subponderación de probabilidades medias y altas**).

3. **Equivalente de Certeza de la Lotería:**
   - Lotería: $x = \$1,000,000$ con $p = 0.001$.
   - Valor de la ganancia: $v(1,000,000) = (1,000,000)^{0.88} \approx 199,526.2$.
   - Valor prospectivo total:
     $$V = w(0.001) \times v(1,000,000) = 0.01445 \times 199,526.2 \approx 2,883.15$$
   - Equivalente de certeza $CE$:
     $$v(CE) = CE^{0.88} = 2,883.15 \implies CE = (2,883.15)^{1 / 0.88} = (2,883.15)^{1.13636} \approx \$8,845$$
   - **Comparación y Consecuencias:** El valor esperado objetivo es $E = 0.001 \times 1,000,000 = \$1,000$. El individuo subjetivamente valora esta lotería como equivalente a recibir casi **$\$8,845$ con total certeza** (casi 9 veces más). Esto explica la inmensa rentabilidad de las loterías estatales y la compra masiva de billetes con valor esperado actuarial fuertemente negativo.

---

### Parte B: El Mercado Experimental de Vernon Smith (1962)

1. **Construcción de Curvas de Demanda y Oferta:**
   - Demanda escalonada (valores de reserva decrecientes de compradores):
     $Q=1 \to \$18; \; Q=2 \to \$16; \; Q=3 \to \$14; \; Q=4 \to \$12; \; Q=5 \to \$10; \; Q=6 \to \$8$.
   - Oferta escalonada (costos de reserva crecientes de vendedores):
     $Q=1 \to \$6; \; Q=2 \to \$8; \; Q=3 \to \$10; \; Q=4 \to \$12; \; Q=5 \to \$14; \; Q=6 \to \$16$.

2. **Equilibrio Competitivo:**
   - En $Q = 4$, el valor del comprador marginal es $V_4 = \$12.00$ y el costo del vendedor marginal es $C_4 = \$12.00$.
   - La curva de demanda y de oferta se intersectan en:
     $$P^* = \$12.00, \quad Q^* = 4 \text{ unidades}$$
     (o $Q^* = 3$ con $P \in [10, 14]$ si solo se cuentan ganancias estrictamente positivas, pero bajo competencia perfecta la unidad marginal 4 se produce a beneficio marginal nulo).

3. **Excedentes Teóricos:**
   - Excedente del Consumidor ($CS^*$):
     $$CS^* = (18 - 12) + (16 - 12) + (14 - 12) + (12 - 12) = 6 + 4 + 2 + 0 = \$12.00$$
   - Excedente del Productor ($PS^*$):
     $$PS^* = (12 - 6) + (12 - 8) + (12 - 10) + (12 - 12) = 6 + 4 + 2 + 0 = \$12.00$$
   - Excedente Social Máximo ($TS^*$):
     $$TS^* = CS^* + PS^* = 12.00 + 12.00 = \$24.00$$

4. **Ronda 1 y Eficiencia Asignativa:**
   - Unidad 1: C1 ($V_1=18$) con V3 ($C_3=10$) a $P=11 \implies \text{Excedente}_1 = 18 - 10 = \$8.00$.
   - Unidad 2: C2 ($V_2=16$) con V1 ($C_1=6$) a $P=15 \implies \text{Excedente}_2 = 16 - 6 = \$10.00$.
   - Unidad 3: C4 ($V_4=12$) con V5 ($C_5=14$) a $P=13 \implies \text{Excedente}_3 = 12 - 14 = -\$2.00$.
     *(Nótese que V5 es un vendedor extramarginal ineficiente: producirle cuesta $\$14$, más de lo que el bien vale para el comprador).*
   - Excedente Social Realizado:
     $$TS_{\text{realizado}} = 8.00 + 10.00 - 2.00 = \$16.00$$
   - **Eficiencia Asignativa del Mercado:**
     $$\text{Eficiencia} = \frac{TS_{\text{realizado}}}{TS^*} \times 100\% = \frac{16.00}{24.00} \times 100\% = 66.67\%$$
     En la primera ronda, errores de emparejamiento reducen la eficiencia al $66.7\%$. En rondas posteriores, como probó Smith, los precios convergen y la eficiencia alcanza sistemáticamente el $98\%-100\%$.

---

## Solución al Ejercicio 3 (Nivel Avanzado / Reto): Efecto Dotación y Burbujas Especulativas

### Parte A: Efecto Dotación y Teorema de Coase

1. **Predicción Neoclásica:**
   Con 40 sujetos idénticos y 20 tazas repartidas al azar, la distribución de valoraciones de los poseedores es idéntica a la de los no poseedores. En el $50\%$ de los casos, un no poseedor valorará la taza más que un poseedor. Por tanto, Coase predice que se transarán exactamente **10 tazas** ($50\%$). La mediana de la disposición a aceptar ($WTA$) de los propietarios debe ser estadísticamente idéntica a la disposición a pagar ($WTP$) de los compradores ($WTA / WTP = 1.0$).

2. **Deducción de la Brecha $WTA/WTP$ con Teoría Prospectiva:**
   Sea $u$ el valor intrínseco del bien.
   - Para un comprador sin la taza (punto de referencia = sin taza): pagar $p$ por adquirir la taza implica evaluar la ganancia del objeto frente al desembolso de dinero:
     $$v(u) - v(p) = 0 \implies u^\alpha = p^\alpha \implies WTP = u$$
   - Para un propietario con la taza (punto de referencia = poseer la taza): venderla a precio $p$ implica ganar el dinero $p$, pero sufrir la **pérdida dolorosa** de desprenderse de la taza:
     $$v(p) + v(-u) = 0 \implies p^\alpha - \lambda \, u^\alpha = 0 \implies p^\alpha = \lambda \, u^\alpha \implies WTA = \lambda^{1/\alpha} \, u$$
   - Por tanto, la relación teórica entre WTA y WTP es:
     $$\frac{WTA}{WTP} = \lambda^{1/\alpha}$$
   - Con $\alpha = 0.88$ y $\lambda = 2.25$:
     $$\frac{WTA}{WTP} = 2.25^{1 / 0.88} = 2.25^{1.13636} \approx 2.51$$
     Esto coincide con la evidencia de Kahneman, Knetsch & Thaler (1990), donde el ratio empírico fue $\approx 2.1 - 2.5$. Como los propietarios exigen el doble de lo que los compradores ofrecen, el volumen de comercio colapsa a menos de la mitad de la predicción coaseana.

3. **Implicancias de Política:**
   - **Mercados de Derechos de Emisión (Bonos de Carbono):** La asignación inicial de licencias no es neutral. Las empresas a las que se les regalan derechos no los venderán fácilmente debido al efecto dotación, encareciendo la reducción total de emisiones.
   - **Expropiaciones y Servidumbres:** Indemnizar a los propietarios al "valor comercial de mercado" genera agravio legítimo, pues su disposición a aceptar para desprenderse de su propiedad duplica el valor que un tercero ajeno pagaría por ella.
   - **Asignación de Espectro Radioeléctrico:** Asignar frecuencias mediante subastas directas de caja abierta es superior a regular derechos históricos de operadores incumbentes.

---

### Parte B: Burbujas Especulativas en Mercados Experimentales (Smith et al., 1988)

1. **Cálculo del Valor Fundamental Teórico $f_t$:**
   $$E[d] = 0.25 \times (0.00 + 0.08 + 0.28 + 0.60) = \frac{0.96}{4} = \$0.24$$
   - Periodo 1: $f_1 = (16 - 1) \times 0.24 = 15 \times 0.24 = \$3.60$
   - Periodo 5: $f_5 = (16 - 5) \times 0.24 = 11 \times 0.24 = \$2.64$
   - Periodo 10: $f_{10} = (16 - 10) \times 0.24 = 6 \times 0.24 = \$1.44$
   - Periodo 15: $f_{15} = (16 - 15) \times 0.24 = 1 \times 0.24 = \$0.24$

2. **Predicción de Mercados Eficientes:**
   Bajo información común y expectativas racionales, el precio en cada periodo $t$ debe ser idéntico al valor fundamental restante: $P_t = f_t$. La trayectoria de precios debe ser una recta monótonamente decreciente que inicia en $\$3.60$ y termina en $\$0.24$.

3. **Hallazgo Empírico de Smith, Suchanek y Williams (1988):**
   - Con sujetos inexpertos, los precios iniciales comienzan cerca de $\$3.60$, pero luego se disparan verticalmente entre los periodos 3 y 9, alcanzando picos de entre $\$4.50$ y $\$6.00$ (muy por encima de cualquier flujo de dividendos posible).
   - Entre los periodos 12 y 14, al agotarse los periodos restantes, se produce un colapso brusco (*crash*), con precios derrumbándose por debajo de los fundamentales y el mercado congelándose sin liquidez.

4. **Tratamiento y Lección Regulatoria:**
   - **La Solución Experimental:** Cuando los mismos sujetos participan por segunda o tercera vez con el mismo diseño, la burbuja desaparece progresivamente. La experiencia genera expectativas racionales de segundo orden.
   - **Lección Macroprudencial:** Las burbujas no requieren asimetría de información externa; emergen endógenamente por la creencia de que se podrá revender a un precio superior antes del colapso (*greater fool theory*). La transparencia de balances por sí sola no evita burbujas en los mercados reales; se requieren mecanismos de amortiguación de liquidez y límites de apalancamiento.

---

## Rúbrica Pedagógica de Evaluación

| Criterio | Excelente (90-100%) | Adecuado (70-89%) | En Desarrollo (<70%) |
| :--- | :--- | :--- | :--- |
| **Dominio Teórico de Teoría Prospectiva** | Explica con rigor la dependencia del punto de referencia, aversión a pérdidas ($\lambda$) y ponderación de probabilidades. | Aplica las fórmulas de $v(x)$ y $w(p)$ pero con dificultades menores de interpretación intuitiva. | Confunde la teoría prospectiva con la teoría de utilidad esperada estándar. |
| **Cálculo y Modelación Numérica** | Deduce con exactitud los valores prospectivos, equivalentes de certeza, equilibrios de Smith y métricas de eficiencia. | Desarrolla la mayoría de los cálculos con pequeños errores aritméticos que no comprometen la lógica central. | Errores sustanciales en el cálculo de probabilidades o valoraciones marginales. |
| **Economía Experimental e Instituciones** | Comprende el rol del valor inducido, la convergencia smithiana y la relevancia de las reglas de mercado frente a la psicología del agente. | Describe la subasta doble pero no articula claramente por qué converge con información privada. | Desconoce los preceptos del diseño experimental smithiano. |
| **Síntesis y Aplicación a Política Pública** | Conecta fluidamente los hallazgos de laboratorio con fallas de mercado reales (Coase, burbujas financieras, regulaciones). | Menciona ejemplos aplicados pero sin profundizar en los mecanismos institucionales. | Respuestas genéricas sin fundamentación empírica ni económica. |

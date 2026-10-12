# Guía Docente y Solucionario: Franco Modigliani (Nobel 1985)

> **Material de uso pedagógico exclusivo para el profesorado.**  
> Este documento contiene el solucionario analítico riguroso paso a paso, comentarios conceptuales y rúbricas de evaluación para los ejercicios presentados en `laureados/1985_modigliani/estudiante/ejercicios.qmd`.

---

## 1. Pautas Pedagógicas y Contexto Teórico

### El legado intelectual de Franco Modigliani
Franco Modigliani transformó simultáneamente la microfundamentación macroeconómica del consumo y la teoría analítica de las finanzas de mercado. Al impartir este módulo, conviene enfatizar tres ejes de aprendizaje:

1. **La ruptura con la función de consumo keynesiana mecánica:**  
   Keynes postuló una relación estática entre consumo e ingreso corriente: $C_t = a + c Y_t$. Modigliani demostró que los seres humanos son agentes optimizadores intertemporales que evalúan la totalidad de sus recursos vitales. El consumo depende del horizonte vital remanente, de los ingresos futuros esperados y del acervo de riqueza acumulada.
2. **La lógica del arbitraje en finanzas (Teoremas de Modigliani-Miller):**  
   Antes de 1958, las finanzas corporativas eran una disciplina descriptiva y contable, dominada por reglas empíricas sobre "ratios óptimos de deuda". Modigliani y Miller introdujeron la metodología del arbitraje competitivo sin fricciones: el valor de una tarta no depende de cómo se corte. El apalancamiento financiero distribuye el riesgo pero no genera valor de la nada a menos que existan distorsiones como el escudo fiscal.
3. **La causalidad invertida en el ahorro nacional:**  
   La sabiduría convencional sugería que los países crecen porque su población tiene una propensión cultural al ahorro elevada. Modigliani demostró la causalidad inversa: **un rápido crecimiento económico y poblacional ($n + g$) es lo que genera una alta tasa de ahorro agregada**, porque cada cohorte activa en fase de ahorro es más numerosa y rica que la cohorte jubilada en fase de desahorro.

---

## 2. Solución Detallada del Ejercicio 1 (Nivel Básico)

### Pregunta 1: Consumo Óptimo Vital
- **Horizonte vital:** 65 años de vida adulta (de los 20 a los 85 años).
- **Años de trabajo:** 45 años (de los 20 a los 65 años) con salario $Y = 40.000$ USD/año.
- **Años de jubilación:** 20 años con salario $Y = 0$.
- **Riqueza humana total:**
  $$\text{Valor Vital de Ingresos} = 45 \times 40.000 = 1.800.000 \text{ USD}$$
- **Restricción presupuestaria vital ($r = \rho = 0, A_0 = 0, A_T = 0$):**
  $$\sum_{t=1}^{65} C_t = 65 \times \bar{C} = 1.800.000 \text{ USD}$$
- **Consumo anual constante óptimo ($\bar{C}$):**
  $$\bar{C} = \frac{1.800.000}{65} \approx 27.692,31 \text{ USD al año}$$

### Pregunta 2: Propensiones Marginales a Consumir
La función de consumo de Modigliani es:
$$C_t = \alpha_t A_t + \beta_t Y_t^e = \left(\frac{1}{L_t}\right) A_t + \left(\frac{R_t}{L_t}\right) Y_t^e$$

- **A los 20 años:**
  - Años de vida restantes: $L_{20} = 85 - 20 = 65$.
  - Años de trabajo restantes: $R_{20} = 65 - 20 = 45$.
  - Propensión marginal de la riqueza: $\alpha_{20} = \frac{1}{65} \approx 0,01538$ (o $1,54\%$).
  - Propensión marginal del ingreso laboral: $\beta_{20} = \frac{45}{65} \approx 0,6923$ (o $69,23\%$).
  - Comprobación: $C_{20} = 0,01538 \times 0 + 0,6923 \times 40.000 = 27.692,31$ USD.

- **A los 60 años:**
  - Años de vida restantes: $L_{60} = 85 - 60 = 25$.
  - Años de trabajo restantes: $R_{60} = 65 - 60 = 5$.
  - Propensión marginal de la riqueza: $\alpha_{60} = \frac{1}{25} = 0,04$ (o $4,00\%$).
  - Propensión marginal del ingreso laboral: $\beta_{60} = \frac{5}{25} = 0,20$ (o $20,00\%$).

*Intuición económica:*  
A mayor edad, el horizonte temporal de vida remanente se estrecha ($L_t$ se reduce), por lo que cualquier dólar de riqueza acumulada debe consumirse a un ritmo anual más acelerado ($\alpha$ se eleva de $1,54\%$ a $4\%$). Al mismo tiempo, como restan muy pocos años productivos en el mercado de trabajo ($R_t$ cae a 5), un dólar de ingreso corriente representa una fracción mucho menor de los recursos vitales, por lo que la propensión marginal a consumir del flujo salarial corriente $\beta$ colapsa de $69,2\%$ a solo $20\%$.

### Pregunta 3: Trayectoria de Riqueza Acumulada
- **Ahorro anual durante la vida laboral activa (20 a 64 años):**
  $$S = Y - \bar{C} = 40.000 - 27.692,31 = 12.307,69 \text{ USD al año}$$
- **Riqueza acumulada al momento del retiro (edad 65):**
  $$A_{65} = 45 \times 12.307,69 \approx 553.846,15 \text{ USD}$$
- **Saldo de riqueza a los 75 años (tras 10 años de jubilación):**
  Durante la jubilación no hay ingresos, por lo que el desahorro anual es exactamente igual al consumo: $S_{\text{vejez}} = - \bar{C} = - 27.692,31$ USD.
  $$A_{75} = A_{65} - (10 \times 27.692,31) = 553.846,15 - 276.923,10 = 276.923,05 \text{ USD}$$
  El individuo ha consumido exactamente la mitad de su riqueza acumulada en la mitad de su horizonte de retiro.
- **Saldo de riqueza a los 85 años:**
  $$A_{85} = A_{75} - (10 \times 27.692,31) = 0,00 \text{ USD}$$
  La riqueza se agota por completo en el momento del fallecimiento, consistente con la ausencia de legados.

### Pregunta 4: Introducción de la Seguridad Social de Reparto
- **Ingreso neto durante vida laboral:**
  $$Y_{\text{disp}} = 40.000 \times (1 - 0,15) = 34.000 \text{ USD al año}$$
- **Recursos vitales con seguridad social:**
  $$\text{Recursos} = (45 \times 34.000) + (20 \times 27.000) = 1.530.000 + 540.000 = 2.070.000 \text{ USD}$$
- **Nuevo consumo anual constante:**
  $$\bar{C}_{\text{pension}} = \frac{2.070.000}{65} \approx 31.846,15 \text{ USD al año}$$
- **Ahorro privado voluntario durante vida laboral:**
  $$S_{\text{privado}} = Y_{\text{disp}} - \bar{C}_{\text{pension}} = 34.000 - 31.846,15 = 2.153,85 \text{ USD al año}$$
- **Riqueza privada acumulada al cumplir 65 años:**
  $$A_{65}^{\text{pension}} = 45 \times 2.153,85 \approx 96.923,08 \text{ USD}$$
- **Tasa de desplazamiento (*crowding-out*):**
  $$\text{Desplazamiento} = \frac{553.846,15 - 96.923,08}{553.846,15} = \frac{456.923,07}{553.846,15} \approx 82,5\%$$

*Implicancias:*  
La promesa de una pensión pública estatal reduce en un **82,5%** el acervo de riqueza financiera privada que el individuo necesita acumular por su cuenta. En un sistema de capitalización individual (donde las cotizaciones se invierten en el mercado de capitales), los activos existen en la economía. Pero en un sistema de reparto (*pay-as-you-go*), las contribuciones se transfieren inmediatamente a pagar las pensiones de los jubilados actuales sin constituir capital físico productivo. Por tanto, tal como demostraron Modigliani (1986) y Feldstein (1974), la seguridad social de reparto genera un fuerte efecto desincentivador sobre la tasa de ahorro y el acervo de capital productivo de la nación.

---

## 3. Solución Detallada del Ejercicio 2 (Nivel Intermedio)

### Caso A: Sin Impuestos Corporativos ($\tau_C = 0$)

#### Pregunta 1: Valor de la Empresa y Estructura de Capital
- **Valor de la empresa desapalancada ($V_U$):**
  $$V_U = \frac{\text{EBIT}}{r_0} = \frac{6.000.000}{0,12} = 50.000.000 \text{ USD}$$
- **Proposición I de Modigliani-Miller:**  
  En mercados perfectos sin impuestos, el valor total no depende de la estructura de capital:
  $$V_L = V_U = 50.000.000 \text{ USD}$$
- **Valor del capital propio restante ($E_L$):**
  $$E_L = V_L - D = 50.000.000 - 20.000.000 = 30.000.000 \text{ USD}$$

#### Pregunta 2: Costo del Capital Propio y WACC
- **Proposición II de Modigliani-Miller:**
  $$r_E = r_0 + (r_0 - r_D)\frac{D}{E_L} = 0,12 + (0,12 - 0,06)\left(\frac{20.000.000}{30.000.000}\right) = 0,12 + 0,06 \times \frac{2}{3} = 0,12 + 0,04 = 0,16 \text{ (16\%)}$$
- **Cálculo del WACC:**
  $$\text{WACC} = \left(\frac{E_L}{V_L}\right) r_E + \left(\frac{D}{V_L}\right) r_D = \left(\frac{30}{50}\right)(0,16) + \left(\frac{20}{50}\right)(0,06) = 0,60(0,16) + 0,40(0,06) = 0,096 + 0,024 = 0,12 \text{ (12\%)}$$
  El WACC permanece rigurosamente inalterado en el $12\%$. Aunque la deuda es más barata que las acciones ($6\% < 16\%$), el incremento en el riesgo financiero de los accionistas eleva el costo de los recursos propios exactamente en la proporción necesaria para cancelar el beneficio de la deuda barata.

#### Pregunta 3: Arbitraje Casero (*Homemade Leverage*)
- Supongamos que el mercado valorara $V_L = 55.000.000$ USD, con $E_L = 35.000.000$ USD y $D = 20.000.000$ USD.
- Flujo de dividendos de la empresa apalancada:
  $$\text{Dividendo Total} = \text{EBIT} - r_D D = 6.000.000 - (0,06 \times 20.000.000) = 6.000.000 - 1.200.000 = 4.800.000 \text{ USD}$$
  El inversionista con el $1\%$ de $E_L$ recibe: $1\% \times 4.800.000 = 48.000$ USD anuales. Sus acciones valen $1\% \times 35.000.000 = 350.000$ USD.
- **Estrategia de arbitraje:**
  1. Vende su participación en $L$ por $350.000$ USD.
  2. Toma un crédito personal al $6\%$ por un monto equivalente a su cuota de deuda corporativa: $1\% \times 20.000.000 = 200.000$ USD. (Costo por intereses personales: $0,06 \times 200.000 = 12.000$ USD).
  3. Liquidez total disponible: $350.000 + 200.000 = 550.000$ USD.
  4. Compra el $1\%$ de las acciones de la empresa desapalancada $U$, cuyo costo es $1\% \times 50.000.000 = 500.000$ USD.
- **Resultado del inversionista:**
  - Flujo de caja percibido de $U$: $1\% \times 6.000.000 = 60.000$ USD.
  - Pago de intereses de su deuda: $-12.000$ USD.
  - Flujo neto anual: $60.000 - 12.000 = 48.000$ USD (idéntico al flujo de la empresa $L$).
  - Excedente de efectivo en mano (*ganancia pura de arbitraje*):
    $$550.000 - 500.000 = 50.000 \text{ USD libres de riesgo en el instante 0}.$$
  La venta masiva de títulos de $L$ y la compra de $U$ restauran de inmediato la igualdad $V_L = V_U = 50.000.000$.

---

### Caso B: Con Impuestos Corporativos ($\tau_C = 30\%$)

#### Pregunta 4: Escudo Fiscal y Valor de la Empresa
- **Valor de la empresa desapalancada con impuestos:**
  $$V_U = \frac{\text{EBIT}(1 - \tau_C)}{r_0} = \frac{6.000.000 \times 0,70}{0,12} = \frac{4.200.000}{0,12} = 35.000.000 \text{ USD}$$
- **Valor actual del Escudo Fiscal:**
  $$\text{PV}(\text{Tax Shield}) = \tau_C D = 0,30 \times 20.000.000 = 6.000.000 \text{ USD}$$
- **Valor total de la empresa apalancada ($V_L$):**
  $$V_L = V_U + \tau_C D = 35.000.000 + 6.000.000 = 41.000.000 \text{ USD}$$
- **Valor del capital accionario ($E_L$):**
  $$E_L = V_L - D = 41.000.000 - 20.000.000 = 21.000.000 \text{ USD}$$

#### Pregunta 5: Costo de Capital y WACC después de Impuestos
- **Costo del capital propio ($r_E$):**
  $$r_E = r_0 + (1 - \tau_C)(r_0 - r_D)\frac{D}{E_L} = 0,12 + (1 - 0,30)(0,12 - 0,06)\left(\frac{20.000.000}{21.000.000}\right)$$
  $$r_E = 0,12 + (0,70 \times 0,06 \times 0,95238) = 0,12 + 0,0400 = 0,16 \text{ (16,00\%)}$$
- **WACC después de impuestos:**
  $$\text{WACC} = \left(\frac{E_L}{V_L}\right) r_E + \left(\frac{D}{V_L}\right) r_D (1 - \tau_C) = \left(\frac{21}{41}\right)(0,16) + \left(\frac{20}{41}\right)(0,06)(0,70)$$
  $$\text{WACC} = (0,5122 \times 0,16) + (0,4878 \times 0,042) = 0,08195 + 0,02049 = 0,10244 \text{ (10,24\%)}$$
- **Conclusión de Modigliani-Miller (1963):**  
  Gracias a la deducibilidad tributaria de los intereses, el WACC se reduce del $12\%$ al $10,24\%$. Esta reducción en la tasa de descuento eleva el valor total de la firma de $35$ a $41$ millones de dólares. El endeudamiento crea valor genuino para la empresa a expensas de la menor recaudación tributaria fiscal del Estado.

---

## 4. Solución Detallada del Ejercicio 3 (Nivel Reto)

### Pregunta 1: Demostración Analítica del Teorema Cero de Modigliani
En el período $t$, la economía cuenta con $N_t$ trabajadores jóvenes y $N_{t-1}$ jubilados.
- Ahorro de la generación joven: $S_t^{\text{jóvenes}} = N_t \cdot (s_1 w_t)$.
- Desahorro de la generación jubilada: $S_t^{\text{viejos}} = N_{t-1} \cdot (-s_1 w_{t-1})$.
- Ahorro nacional agregado:
  $$S_t = N_t s_1 w_t - N_{t-1} s_1 w_{t-1}$$
Bajo condiciones estacionarias sin crecimiento demográfico ($n = 0 \implies N_t = N_{t-1} = N$) y sin progreso técnico ($g = 0 \implies w_t = w_{t-1} = w$):
$$S_t = N s_1 w - N s_1 w = 0 \quad \text{Q.E.D.}$$
El ahorro de los jóvenes se destina en su totalidad a comprar los activos que los ancianos venden para consumir. El acervo de riqueza se traspasa de generación en generación, pero el flujo neto de nuevo capital es estrictamente cero.

### Pregunta 2: Tasa de Ahorro con Crecimiento ($n > 0, g > 0$)
Sustituyendo $N_t = N_{t-1}(1 + n)$ y $w_t = w_{t-1}(1 + g)$:
$$S_t = N_{t-1}(1 + n) s_1 w_{t-1}(1 + g) - N_{t-1} s_1 w_{t-1} = N_{t-1} s_1 w_{t-1} \left[(1 + n)(1 + g) - 1\right]$$
El ingreso nacional total es el salario agregado de los trabajadores activos: $Y_t = N_t w_t = N_{t-1}(1 + n) w_{t-1}(1 + g)$.
La tasa de ahorro nacional agregada es:
$$s_t \equiv \frac{S_t}{Y_t} = \frac{N_{t-1} s_1 w_{t-1} \left[(1 + n)(1 + g) - 1\right]}{N_{t-1}(1 + n) w_{t-1}(1 + g)} = \frac{(1 + n)(1 + g) - 1}{(1 + n)(1 + g)} \cdot s_1$$
Expandiendo el numerador: $(1 + n)(1 + g) - 1 = n + g + ng \approx n + g$. Para valores típicos pequeños de $n$ y $g$, el denominador $(1 + n)(1 + g) \approx 1$. Por ende:
$$s_t \approx s_1 \cdot (n + g) \quad \text{Q.E.D.}$$

*Implicancia de Modigliani:*  
Este resultado refutó la creencia clásica de que las naciones tienen altas tasas de ahorro debido a "virtudes frugales" innatas o niveles elevados de ingreso per cápita. La hipótesis del ciclo de vida demuestra que la causa primaria de un alto ahorro agregado es la **velocidad de expansión de la economía ($n + g$)**. Por ello, Japón en los años 1960-1970 y China en los años 1990-2000 exhibieron tasas de ahorro superiores al $35\%$: sus cohortes laborales jóvenes eran inmensas y ganaban salarios exponencialmente superiores a lo que habían ganado sus padres jubilados.

### Pregunta 3: El Reto Demográfico del Envejecimiento
- Si $n = -1,5\%$ y $g = 0,5\%$, la tasa combinada es:
  $$(1 - 0,015)(1 + 0,005) - 1 = 0,985 \times 1,005 - 1 = 0,989925 - 1 = -0,010075 \approx -1,01\%$$
  La tasa de ahorro nacional agregada $s_t$ se torna **negativa**:
  $$s_t \approx s_1 \times (-0,01) < 0$$
- **Dilema macroeconómico ($S - I = CA$):**  
  Al colapsar el ahorro nacional interno ($S < 0$ o $S \ll I$):
  1. Si la economía desea sostener su nivel de inversión productiva ($I$), deberá incurrir en déficits persistentes de cuenta corriente ($CA < 0$), absorbiendo ahorro foráneo y acumulando deuda externa.
  2. Si el país poseía un gran acervo de activos externos netos acumulados en el pasado (como Japón), deberá proceder a una **liquidación o repatriación sistemática de inversiones en el extranjero** para financiar las pensiones y el consumo de su población anciana.
  3. A escala global, si todas las economías avanzadas envejecen simultáneamente, el ahorro global se contrae, elevando las tasas de interés reales neutrales mundiales ($r^*$) o frenando la formación neta de capital.

---

## 5. Rúbrica de Evaluación Docente

| Criterio | Insuficiente (0-4) | Aceptable (5-7) | Sobresaliente (8-10) |
|---|---|---|---|
| **Optimización del Ciclo de Vida** | No formula la restricción vital ni entiende el concepto de suavizamiento. | Calcula el consumo constante pero confunde las propensiones marginales con la edad. | Deduce con total precisión matemática $\bar{C}$, $\alpha_t$, $\beta_t$ y el efecto crowding-out previsional. |
| **Teoremas de Modigliani-Miller** | Errores conceptuales en el arbitraje; asume que el WACC siempre cambia sin impuestos. | Calcula $V_L$ y WACC pero no formula el arbitraje casero con balance patrimonial. | Demuestra rigurosamente la Proposición I por arbitraje y cuantifica el escudo fiscal y WACC. |
| **Dinámica Demográfica Agregada** | No comprende por qué el ahorro agregado puede ser cero en una economía estática. | Deduce el Teorema Cero pero no deriva la relación con el crecimiento $(n + g)$. | Derivación formal completa de $s_t \approx s_1(n+g)$ e impecable análisis de balance de pagos. |

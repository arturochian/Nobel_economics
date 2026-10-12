# Solucionario y Guía Pedagógica Docente: Richard H. Thaler (Premio Nobel 2017)

**Documento Confidencial para el Docente — Nobel_economics Project**  
**Módulo:** Economía Conductual, Contabilidad Mental y Paternalismo Libertario  
**Material de Base:** `replicacion/R/simulacion_thaler_conductual.R`, `replicacion/replicar.qmd`, `estudiante/ejercicios.qmd`

---

## Objetivos Docentes y Competencias Pedagógicas

Este módulo permite al estudiante de economía y políticas públicas:
1. **Desmitificar el axioma de la fungibilidad neoclásica:** Comprender cómo el etiquetado cognitivo y la apertura/cierre de cuentas mentales alteran las decisiones de consumo de manera predecible.
2. **Operacionalizar la teoría prospectiva en finanzas personales:** Ver en acción la aversión a pérdidas ($\lambda \approx 2.25$) y el descuento hiperbólico ($\beta < 1$) aplicados al ahorro jubilatorio.
3. **Evaluar con rigor normativo el paternalismo libertario:** Discutir cuándo un cambio en la opción predeterminada es una corrección benevolente de la inercia cognitiva y cuándo se transforma en una barrera abusiva (*sludge*).

---

## Solución al Ejercicio 1: Contabilidad Mental, No Fungibilidad y Costos Hundidos (Nivel Básico)

### Caso 1.1: El dilema del concierto y la pérdida de dinero

#### 1. Predicción Neoclásica
- **Riqueza inicial:** $W_0$.
- **Costo de la entrada:** $\$100$.
- **Valor hedónico del concierto:** $v(\text{concierto})$.
- **En el Escenario A:** El individuo compra la entrada ($-\$100$) y la pierde ($-\$100$ en valor físico). Si compra otra entrada para ir al concierto, su desembolso total es de $-\$200$ y su riqueza final es $W_A = W_0 - 200 + v(\text{concierto})$. Si decide no ir, su riqueza final es $W_A' = W_0 - 100$. La ganancia marginal de ir al concierto frente a no ir es $v(\text{concierto}) - 100$.
- **En el Escenario B:** El individuo pierde un billete de $\$100$ ($-\$100$ en efectivo). Si compra la entrada para ir al concierto, su desembolso es de $-\$100$ y su riqueza final es $W_B = W_0 - 200 + v(\text{concierto})$. Si decide no ir, su riqueza final es $W_B' = W_0 - 100$. La ganancia marginal de ir frente a no ir es exactamente $v(\text{concierto}) - 100$.
- **Conclusión microeconómica estándar:** Las restricciones presupuestarias y los costos de oportunidad marginales son idénticos. Si $v(\text{concierto}) > 100$, el individuo racional debe comprar la entrada en **ambos** escenarios. Si $v(\text{concierto}) < 100$, no debe asistir en ninguno. Tratar ambos escenarios de manera diferente viola la fungibilidad del dinero.

#### 2. Análisis de Contabilidad Mental (Thaler 1980, 1985)
- En la mente humana, los recursos no se cargan a un fondo común unificado de riqueza $W$, sino a **cuentas mentales temáticas y acotadas**.
- **En el Escenario A:** La pérdida de la entrada física se carga directamente a la cuenta mental específica: **"Presupuesto de Entretenimiento: Concierto"**. Si el individuo compra una segunda entrada, esa cuenta mental registraría un costo total acumulado de $\$200$ para asistir al mismo evento. Si la disposición a pagar máxima por el concierto era de, por ejemplo, $\$150$, la transacción se percibe como una pérdida neta inaceptable ($\$150 - \$200 = -\$50$). Por tanto, el individuo rehúsa comprar otra entrada.
- **En el Escenario B:** La pérdida del billete de $\$100$ en efectivo se carga a una cuenta mental genérica o no asignada (**"Pérdidas Diversas / Desgracias Personales"**). La cuenta mental **"Presupuesto de Entretenimiento: Concierto"** permanece intacta y disponible con un costo proyectado de solo $\$100$. Al evaluarse por separado, el consumidor compra la entrada por $\$100$ sin percibir que el costo del concierto se haya duplicado.

---

### Caso 1.2: Falacia del costo hundido y cierre de cuenta

#### 1. Regla Marginal Neoclásica
- El dinero gastado en la entrada de cine ($\$15$) es un **costo irrecuperable o hundido** ($S = \$15$). Para las decisiones futuras $t > 20\text{ min}$, los $\$15$ no pueden recuperarse independientemente de la acción elegida.
- La utilidad incremental de permanecer en la sala es negativa: $\Delta U_{\text{quedarse}} = u(\text{película mala}) < 0$.
- La utilidad incremental de salir de la sala es estrictamente positiva: $\Delta U_{\text{salir}} = u(\text{descansar}) > 0$.
- Puesto que $\Delta U_{\text{salir}} > \Delta U_{\text{quedarse}}$, el agente racional sale inmediatamente del cine.

#### 2. Explicación Conductual: Cierre de la Cuenta Mental
- Thaler demostró que una compra abre una cuenta mental que permanece abierta hasta que el bien es consumido por completo.
- Si el individuo sale de la sala a los 20 minutos, se ve obligado psicológicamente a **cerrar la cuenta mental** y reconocer formalmente una **pérdida realizada** de $\$15$ en la función de valor de Kahneman y Tversky ($v(-15) < 0$).
- Debido a la convexidad de $v(x)$ en el cuadrante negativo ($v''(x) > 0$), las personas son propensas al riesgo en pérdidas y prefieren postergar el cierre de la cuenta ("tal vez la película mejore al final") antes que asumir el dolor psíquico inmediato de admitir el desperdicio del dinero. Permanecer sentado genera la ilusión cognitiva de que el boleto pagado no fue dinero tirado a la basura.

---

## Solución al Ejercicio 2: El Diseño de "Save More Tomorrow" (Nivel Intermedio)

### 1. Aversión a la pérdida en asesoría tradicional
- **Datos base:** $W_0 = \$50,000$, tasa base $s_0 = 3.5\%$.
- **Aporte jubilatorio inicial:** $A_0 = 0.035 \times 50,000 = \$1,750$.
- **Salario neto disponible en $t=0$:**
  $$Y_{\text{neto}, 0} = 50,000 - 1,750 = \$48,250$$
- **Bajo recomendación tradicional ($s_0' = 6.5\%$):**
  - Nuevo aporte jubilatorio: $A_0' = 0.065 \times 50,000 = \$3,250$.
  - Nuevo salario neto disponible:
    $$Y_{\text{neto}, 0}' = 50,000 - 3,250 = \$46,750$$
  - Variación nominal en el cheque de bolsillo:
    $$\Delta Y = 46,750 - 48,250 = -\$1,500$$
- **Evaluación en la función de valor prospectiva:**
  Dado que $\Delta Y = -1,500 < 0$:
  $$v(\Delta Y) = -\lambda (1,500)^{0.88} = -2.25 \times (1,500)^{0.88}$$
  Calculando: $1,500^{0.88} \approx 624.47$.
  $$v(\Delta Y) = -2.25 \times 624.47 = -1,405.06\text{ unidades de desutilidad psíquica}$$
- **Razón del rechazo:** El trabajador codifica los $\$1,500$ no como un beneficio acumulado en un fondo de jubilación lejano, sino como una **pérdida directa de ingreso disponible presente**. Puesto que la aversión a pérdidas multiplica por $2.25$ el dolor psíquico de la reducción salarial, la abrumadora mayoría de los trabajadores ($>80\%$) rechaza la recomendación del asesor.

---

### 2. La mecánica no traumática de SMarT

- **En $t=1$:** Salario nominal con aumento del $g=5\%$:
  $$W_1 = 50,000 \times 1.05 = \$52,500$$
  El incremento salarial bruto es:
  $$\Delta W = W_1 - W_0 = 52,500 - 50,000 = \$2,500$$
- **Regla SMarT:** Se destina el $60\%$ del incremento salarial al plan jubilatorio:
  $$\Delta A = 0.60 \times 2,500 = \$1,500$$
- **Nuevo aporte jubilatorio en $t=1$:**
  $$A_1 = A_0 + \Delta A = 1,750 + 1,500 = \$3,250$$
- **Nueva tasa de contribución efectiva:**
  $$s_1 = \frac{A_1}{W_1} = \frac{3,250}{52,500} \approx 6.19\%$$
- **Nuevo salario neto de bolsillo en $t=1$:**
  $$Y_{\text{neto}, 1} = W_1 - A_1 = 52,500 - 3,250 = \$49,250$$
- **Comparación frente al cheque de $t=0$:**
  $$\Delta Y_{\text{bolsillo}} = Y_{\text{neto}, 1} - Y_{\text{neto}, 0} = 49,250 - 48,250 = +\$1,000$$
- **Evaluación en la función de valor prospectiva:**
  Dado que $\Delta Y_{\text{bolsillo}} = +1,000 > 0$:
  $$v(\Delta Y) = (1,000)^{0.88} \approx 436.5\text{ unidades de utilidad positiva}$$
- **Neutralización de la aversión a pérdidas:**
  El trabajador **nunca experimenta una reducción nominal en su cheque de pago**. Cada mes recibe $\$1,000$ más de lo que recibía el año anterior. La aversión a pérdidas ($\lambda$) queda completamente desactivada porque la contribución al ahorro se deduce exclusivamente de un incremento salarial recién otorgado.

---

### 3. Inercia y Descuento Hiperbólico ($\beta$-$\delta$)

- En el modelo cuasi-hiperbólico, la función de descuento intertemporal es $D(t) = 1$ para $t=0$, y $D(t) = \beta \delta^t$ para $t \ge 1$ (con $\beta = 0.7 < 1$).
- **Sacrificio hoy ($t=0$):** El costo de ahorrar hoy se evalúa inmediatamente sin descuento ($D(0) = 1$), mientras que los beneficios del retiro futuro se descuentan fuertemente por $\beta \delta^T$. La desutilidad presente supera los beneficios percibidos, provocando la postergación ("empiezo el próximo mes").
- **Compromiso futuro ($t=1$):** Visto desde hoy ($t=0$), tanto el costo de ahorrar en $t=1$ como los beneficios futuros en $T$ están sujetos al descuento del presente $\beta$. Como el factor de sesgo $\beta$ afecta a ambos términos por igual, el individuo evalúa la decisión utilizando la tasa pura paciente $\delta$. El "planificador" (*planner*) toma el control y se compromete gustosamente a ahorrar en el futuro. Cuando llega el momento del aumento, la inercia del default impide que el "ejecutor" cancele el plan.

---

## Solución al Ejercicio 3: Paternalismo Libertario vs. "Sludge" (Nivel Avanzado / Reto)

### 1. El Teorema de la No Neutralidad del Default
- **Imposibilidad de no diseñar:** En cualquier trámite o formulario (afiliación a pensiones, donación de órganos, privacidad digital), **un estado predeterminado debe existir obligatoriamente**: o la casilla viene desmarcada (*opt-in*), o viene marcada (*opt-out*), o se exige elección forzada.
- Si el regulador no elige activamente, la inercia favorece el status quo arbitrario.
- **Evidencia en donación de órganos:** En Alemania (*opt-in*), donar requiere buscar el formulario, llenarlo y enviarlo: solo el $\sim 12\%$ consiente, a pesar de que el $90\%$ declara apoyar la donación en encuestas. En Austria (*opt-out*), todos son donantes a menos que soliciten activamente no serlo: el consentimiento efectivo supera el $99\%$.
- **Legitimidad moral:** Thaler y Sunstein argumentan que es moralmente legítimo configurar el default para favorecer el bienestar y salvar vidas, siempre que la libertad de rechazo (*opt-out*) sea rápida, libre y de costo cero.

### 2. Frontera entre "Nudge" y "Sludge"
- **Nudge:** Fricción cognitiva reducida para facilitar decisiones alineadas con el propio interés de largo plazo del agente (ej. enrolamiento automático en fondos 401(k), avisos comparativos de consumo de agua con vecinos).
- **Fricción Protectora (*Good Sludge*):** Fricción deliberada introducida para ralentizar decisiones impulsivas de alto riesgo y permitir que el planificador racional sopese la acción (ej. un periodo de espera de 48 horas antes de contraer matrimonio legal, o advertencias de confirmación antes de transferir sumas masivas de dinero).
- **Sludge Extractivo / *Dark Patterns*:** Fricciones burocráticas, cognitivas y temporales diseñadas específicamente por firmas para explotar la inercia, el sesgo del presente y el cansancio de los usuarios en beneficio comercial exclusivo de la firma (ej. cancelación de suscripciones que exige llamar por teléfono a un centro de atención con largas esperas, o subsidios gubernamentales con formularios incomprensibles de 40 páginas que impiden el acceso a los hogares vulnerables).

---

## Rúbrica de Evaluación Sugerida

| Criterio | Excelente (90–100%) | Satisfactorio (70–89%) | Necesita Mejora (<70%) |
| :--- | :--- | :--- | :--- |
| **Ejercicio 1: Contabilidad Mental** | Demuestra con claridad la equivalencia neoclásica formal y desglosa con precisión la apertura y cierre de cuentas mentales en ambos escenarios. | Reconoce la diferencia psicológica pero comete imprecisiones en la formulación matemática o analítica del costo hundido. | Confunde la contabilidad mental con simple falta de dinero; no diferencia la pérdida en efectivo de la pérdida del boleto. |
| **Ejercicio 2: Save More Tomorrow** | Cálculos exactos de salarios netos, evaluaciones numéricas correctas con la función de valor y vinculación impecable con el modelo $\beta$-$\delta$. | Cálculos correctos pero con omisión de la evaluación matemática de la función de valor prospectiva. | Errores aritméticos en el cálculo de tasas y deducciones; no comprende por qué se neutraliza la aversión a pérdidas. |
| **Ejercicio 3: Nudge vs. Sludge** | Análisis riguroso de la no-neutralidad del default, distinción clara entre fricción protectora y extractiva, y propuesta de política factible y coherente. | Buen debate ético pero propuesta de política superficial o sin identificación nítida del sesgo conductual de base. | Respuestas genéricas sin fundamentación en los textos de Thaler; no define formalmente el concepto de *sludge*. |

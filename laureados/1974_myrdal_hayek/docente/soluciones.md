# Guía Docente y Solucionario: Gunnar Myrdal y Friedrich August von Hayek (Nobel 1974)

> **Material de uso pedagógico exclusivo para el profesorado.**  
> Este documento contiene el solucionario analítico riguroso paso a paso, comentarios conceptuales y rúbricas de evaluación para los ejercicios presentados en `laureados/1974_myrdal_hayek/estudiante/ejercicios.qmd`.

---

## 1. Pautas Pedagógicas y Contexto Teórico

### El legado intelectual del Premio Nobel de 1974
La concesión compartida a Gunnar Myrdal y Friedrich August von Hayek ofrece una oportunidad didáctica inigualable para enseñar epistemología económica, dinámica de la información y economía del desarrollo institucional:

1. **Friedrich A. Hayek (Viena / Escuela Austríaca):**
   - **El Problema del Conocimiento (1945):** Los mercados no son simplemente lugares de intercambio, sino gigantescos mecanismos de procesamiento de información dispersa y subjetiva (*tácita*). Los precios son señales comprimidas que permiten la coordinación social espontánea sin planificador central.
   - **La Teoría del Ciclo Económico (1931):** La manipulación artificial del crédito bancario reduce las tasas de interés por debajo de la tasa natural de Wicksell, desalineando las decisiones intertemporales y generando malas inversiones (*malinvestments*) en las etapas tempranas de capital, cuya liquidación inevitable constituye la recesión.
   - **La Pretensión del Conocimiento (1974):** Advertencia epistemológica contra el cientificismo y la falsa creencia de que las autoridades macroeconómicas pueden manipular mecánicamente variables agregadas complejas.

2. **Gunnar Myrdal (Estocolmo / Escuela Institucionalista):**
   - **El Análisis Ex-Ante vs Ex-Post (1939):** La macroeconomía debe distinguir entre decisiones planificadas (*ex-ante*) y registros contables realizados (*ex-post*). Las discrepancias entre planes de ahorro e inversión desatan procesos acumulativos de precios y empleo.
   - **La Causación Circular Acumulativa (1957):** Rechazo de la hipótesis neoclásica de convergencia automática. Las fuerzas de libre mercado generan efectos de retroceso (*backwash*) donde el capital y el talento huyen de la periferia hacia el centro, requiriendo un Estado desarrollista con políticas deliberadas de inversión regional (*spread deliberado*).
   - **Economía Institucional y Dilemas Sociales (1944, 1968):** Demostró que la pobreza no es solo una variable económica, sino un entramado circular de factores culturales, educativos, de salud y prejuicios institucionales.

---

## 2. Solución Detallada del Ejercicio 1 (Nivel Básico — Hayek)

### Pregunta 1: Equilibrio Descentralizado y el Sistema de Precios

1. **Equilibrio inicial:**
   $$Q_d(p) = 120 - 2p, \quad Q_s(p) = 2p$$
   $$120 - 2p = 2p \implies 4p = 120 \implies p_0^* = 30$$
   $$Q_0^* = 2(30) = 60 \text{ unidades}$$

2. **Nuevo equilibrio tras el choque local:**
   $$Q_s'(p) = 2p - 20$$
   $$120 - 2p = 2p - 20 \implies 4p = 140 \implies p_1^* = 35$$
   $$Q_1^* = 2(35) - 20 = 50 \text{ unidades}$$
   El precio de equilibrio sube de $30$ a $35$ ($+16.7\%$) y la cantidad de equilibrio cae de $60$ a $50$ ($-16.7\%$).

3. **Mecanismo epistemológico de Hayek (1945):**
   - Un comprador o fabricante lejano **no necesita saber** qué mina sufrió el derrumbe, ni el estado geológico del yacimiento, ni el costo salarial de los mineros.
   - La única información que necesita es el aumento en el precio de $30 \to 35$.
   - Este precio sintetiza la nueva escasez relativa del insumo en toda la economía. De forma puramente voluntaria e interesada, el fabricante economiza el uso del insumo, busca sustitutos o pospone usos marginales. Al mismo tiempo, otros mineros no afectados encuentran incentivos para operar horas extra. La economía se reasigna eficientemente sin coerción ni cálculo central.

---

### Pregunta 2: Planificación Central con Rezago Burocrático

1. **Cantidad ofrecida al precio regulado:**
   La Junta mantiene el precio oficial en $p_{\text{plan}} = 30$ y la cuota en $Q_{\text{plan}} = 60$.  
   Con la verdadera estructura de costos de los mineros ($Q_s'(p) = 2p - 20$), al precio $p = 30$:
   $$Q_s'(30) = 2(30) - 20 = 40 \text{ unidades}$$
   Los mineros sólo están dispuestos a extraer y vender $40$ unidades.

2. **Magnitud de la escasez física (desabastecimiento):**
   Al precio oficial subsidiado $p = 30$, la cantidad demandada por las fábricas es:
   $$Q_d(30) = 120 - 2(30) = 60 \text{ unidades}$$
   Por lo tanto, la escasez física o exceso de demanda reprimido es:
   $$\text{Déficit} = Q_d(30) - Q_s'(30) = 60 - 40 = 20 \text{ unidades}$$
   Aparecen colas de espera, mercados negros, racionamiento burocrático o paralización imprevista de fábricas por falta de insumo.

---

### Pregunta 3: Pérdida Irrecuperable de Eficiencia (Deadweight Loss)

Al quedar congelada la cantidad en $Q = 40$ (determinada por el lado corto de la oferta al precio regulado):
- La valoración marginal del consumidor por la unidad 40 es:
  $$p_d(40): 40 = 120 - 2p \implies 2p = 80 \implies p_d = 40$$
- El costo marginal de producción de la unidad 40 en la nueva curva es $p_s = 30$.
- La cantidad socialmente óptima tras el choque era $Q_1^* = 50$, con precio sombra $p_1^* = 35$.
- Las unidades entre $40$ y $50$ no se producen ni se intercambian.
- El área de la pérdida irrecuperable de bienestar (el triángulo de pérdida entre la demanda y la oferta efectiva desde $Q = 40$ hasta $Q^* = 50$) es:
  $$DWL = \frac{1}{2} \times [p_d(40) - p_s(40)] \times (Q_1^* - Q_{\text{real}})$$
  $$DWL = \frac{1}{2} \times [40 - 30] \times (50 - 40) = \frac{1}{2} \times 10 \times 10 = 50 \text{ unidades monetarias}$$

**Conclusión pedagógica:** La pérdida no surge de mala fe de la autoridad, sino de la imposibilidad cognitiva de recolectar, verificar y autorizar respuestas a tiempo frente a circunstancias locales imprevistas ("la pretensión del conocimiento").

---

## 3. Solución Detallada del Ejercicio 2 (Nivel Intermedio — Myrdal)

### Pregunta 1: Régimen de Libre Mercado sin Intervención ($I^{\text{pol}} = 0$)

1. **Tasas de crecimiento anual:**
   - Para el Centro:
     $$g_C = g_0 + \gamma_{\text{agg}} + \frac{1}{2}(\delta_{\text{bw}} - \delta_{\text{sp}})$$
     $$g_C = 0.02 + 0.015 + \frac{1}{2}(0.035 - 0.015) = 0.035 + \frac{1}{2}(0.020) = 0.035 + 0.010 = 0.045 \text{ (4.50\% anual)}$$
   - Para la Periferia:
     $$g_P = g_0 - \delta_{\text{bw}} + \delta_{\text{sp}} + I^{\text{pol}}$$
     $$g_P = 0.02 - 0.035 + 0.015 + 0 = 0.000 \text{ (0.00\% anual)}$$

2. **Diferencial de crecimiento:**
   $$g_C - g_P = 0.045 - 0.000 = +0.045 \text{ (+4.5\% anual)}$$
   El Centro crece a una tasa anual positiva del $4.5\%$, mientras que la Periferia se encuentra en un estado de estancamiento secular ($0\%$).

3. **Proyección a $t = 15$ años:**
   $$Y_{C,15} = 100 \times (1 + 0.045)^{15} = 100 \times (1.93528) \approx 193.53$$
   $$Y_{P,15} = 70 \times (1 + 0.000)^{15} = 70.00$$
   Brecha final de disparidad:
   $$\text{Brecha}_{15} = \frac{Y_{C,15}}{Y_{P,15}} = \frac{193.53}{70.00} \approx 2.76$$
   La disparidad regional se multiplicó casi por dos (pasó de $1.43$ a $2.76$).

4. **Conclusión empírica e histórica:**
   Se confirma plenamente la tesis de Myrdal de la **Causación Circular Acumulativa**: las fuerzas de libre mercado desreguladas no conducen a la convergencia, sino a una creciente concentración de riqueza en el polo dinámico a expensas de la periferia.

---

### Pregunta 2: El Gran Impulso de Desarrollo Regional ($I^{\text{pol}}$)

1. **Crecimiento paralelo ($g_P = g_C = 0.045$):**
   $$g_P = 0.000 + I^{\text{pol}} = 0.045 \implies I^{\text{pol}*} = 0.045 \text{ (4.5\% anual)}$$
   El Estado debe inyectar estímulos equivalentes a $4.5\%$ anual de productividad en la periferia para neutralizar el drenaje de factores y mantener la brecha relativa constante.

2. **Convergencia activa con cierre del $2\%$ anual ($g_P = g_C + 0.02 = 0.065$):**
   $$g_P = 0.000 + I^{\text{pol}} = 0.065 \implies I^{\text{pol}**} = 0.065 \text{ (6.5\% anual)}$$
   Con este impulso, el producto per cápita de la Periferia crecerá al $6.5\%$ anual frente al $4.5\%$ del Centro, cerrando progresivamente la brecha histórica.

---

### Pregunta 3: Instrumentos Concretos de Política Económica
Para operacionalizar $I^{\text{pol}}$ en la práctica, el docente debe valorar la mención de:
1. **Infraestructura de Conectividad y Transporte:** Ferrocarriles de carga, carreteras y puertos que reduzcan los costos de transporte de la periferia, permitiendo que sus productos compitan en el centro.
2. **Descentralización de Educación Superior e Investigación:** Creación de institutos tecnológicos y universidades regionales para frenar la "fuga de cerebros" y generar capital humano local.
3. **Incentivos Tributarios Focalizados y Crédito de Fomento:** Bancos de desarrollo regionales que ofrezcan financiamiento a tasas preferenciales para radicar industrias de transformación en la periferia.

---

## 4. Solución Detallada del Ejercicio 3 (Reto / Nivel Avanzado)

### Pregunta 1: La Perspectiva de Gunnar Myrdal (1939)

1. **Brecha Ex-Ante en el mercado financiero:**
   $$\Delta_{\text{ex-ante}} = I_{\text{ex-ante}}(0.03) - S_{\text{ex-ante}}(0.03) = 1.600 - 700 = +900 \text{ millones de dólares}$$
   Existe un exceso de demanda planeada de inversión sobre el ahorro planeado voluntario de $900$ millones.

2. **Mecanismo de ajuste hacia la identidad Ex-Post ($S_{\text{ex-post}} \equiv I_{\text{ex-post}}$):**
   - El sistema bancario cubre la brecha emitiendo $900$ millones de crédito nuevo sin respaldo de ahorro previo.
   - Las empresas utilizan este crédito para pujar por mano de obra, maquinaria e insumos.
   - La demanda agregada excede la producción disponible a los precios iniciales. Los precios de venta aumentan inesperadamente.
   - Este incremento de precios reduce el salario real de los asalariados y genera **ganancias extraordinarias imprevistas (*windfall profits*)** para las empresas.
   - Las utilidades no distribuidas de las empresas y el ahorro involuntario de los consumidores forzados por la inflación cierran contablemente la brecha:
     $$S_{\text{ex-post}} = S_{\text{voluntario}} + \text{Ganancias imprevistas retenidas} = 700 + 900 = 1.600 \text{ millones}$$
   - *Lección de Myrdal:* La identidad contable *ex-post* enmascara un desequilibrio dinámico *ex-ante* que altera la distribución del ingreso y distorsiona las expectativas.

---

### Pregunta 2: La Perspectiva de Friedrich A. von Hayek (1931)

1. **Distorsión del Triángulo de Producción y Malas Inversiones (*Malinvestments*):**
   - La tasa de interés artificialmente baja ($3\% < 6\%$) abarata el valor presente descontado de los flujos de largo plazo:
     $$PV = \sum \frac{CF_t}{(1 + r)^t}$$
   - Esto hace que proyectos enormemente intensivos en capital y alejados del consumo final (etapas tempranas: minería profunda, plantas químicas complejas, megaobras) parezcan rentables.
   - Sin embargo, las familias **no redujeron voluntariamente su consumo presente** (su ahorro voluntario cayó de $1.000$ a $700$). No existe un fondo real de bienes de subsistencia para sostener a los trabajadores en estas etapas prolongadas.

2. **El Cuello de Botella y la Crisis de Liquidación:**
   - Cuando los trabajadores contratados reciben sus salarios, salen al mercado a comprar bienes de consumo final.
   - Los precios de los bienes de consumo suben velozmente (el *Efecto Ricardo*): los márgenes de ganancia en las etapas cercanas al consumo final se disparan frente a las etapas tempranas.
   - Las tasas de interés de mercado se elevan bruscamente ante la escasez de liquidez real.
   - Los proyectos de etapas tempranas quedan a medio terminar por falta de financiamiento rentable (*malinvestments*).
   - Se desata la recesión: no como un fallo intrínseco del mercado, sino como la consecuencia inevitable de la distorsión monetaria previa.

---

### Pregunta 3: Síntesis Institucional Moderna

| Criterio | Enfoque Hayekiano (1945, 1974) | Enfoque Myrdaliano (1939, 1957) |
| :--- | :--- | :--- |
| **Rol primordial del mercado** | Procesador insustituible de información dispersa y motor de innovación descentralizada. | Mecanismo que puede amplificar la divergencia y la asimetría de poder territorial. |
| **Peligro principal** | "La fatal arrogancia": la ilusión de que un planificador puede fijar precios y cuotas eficientemente. | "El mito del equilibrio armónico": ignorar las trampas circulares y el drenaje periférico. |
| **Rol óptimo del Estado** | Marco institucional de reglas de juego claras, imperio de la ley y estabilidad monetaria estricta. | Planificación indicativa, provisión de bienes públicos, inversión en infraestructura y desarrollo regional. |

**Conclusión didáctica de consenso:** El Estado no debe intentar fijar los precios relativos de los bienes ni reemplazar la coordinación del mercado (lección de Hayek), pero debe intervenir deliberadamente en la provisión de infraestructura, educación e instituciones en las regiones rezagadas para que éstas puedan conectarse a las redes de mercado y beneficiarse de los derrames en lugar de sufrir el retroceso (lección de Myrdal).

---

## 5. Rúbrica de Evaluación

| Criterio | Excelente (90–100%) | Satisfactorio (70–89%) | Requiere Mejora (<70%) |
| :--- | :--- | :--- | :--- |
| **Comprensión del Sistema de Precios (Hayek)** | Deriva perfectamente el equilibrio, el desabastecimiento central y la pérdida social; explica el concepto de conocimiento tácito de tiempo y lugar. | Calcula los equilibrios numéricos pero presenta imprecisiones menores en el cálculo del DWL o la explicación teórica. | Errores en el cálculo algebraico del equilibrio o incapacidad para explicar el rol informativo de los precios. |
| **Dinámica de Causación Acumulativa (Myrdal)** | Resuelve analíticamente las tasas de crecimiento regional, la brecha a 15 años y el requerimiento de $I^{\text{pol}}$; argumenta la refutación neoclásica. | Calcula correctamente las tasas pero comete errores en la proyección temporal o en la formulación de los instrumentos de desarrollo. | No distingue adecuadamente entre efectos de retroceso (*backwash*) y de derrame (*spread*). |
| **Síntesis Teórica y Análisis Crítico (Reto)** | Domina la distinción entre identidades ex-post y planes ex-ante; explica la teoría austriaca del ciclo y formula un puente institucional equilibrado. | Explica bien uno de los dos autores pero tiene lagunas en la conexión entre ahorro forzoso y malas inversiones. | Análisis superficial o puramente retórico sin rigor analítico ni comprensión de los modelos. |

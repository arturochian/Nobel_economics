# Guía Docente y Solucionario: Experimentos Naturales y Evaluación Causal

**Premio Nobel de Economía 2021: David Card, Joshua D. Angrist y Guido W. Imbens**  
*Material pedagógico exclusivo para el docente.*

---

## 1. Pautas Pedagógicas y Objetivos de Aprendizaje

Esta unidad didáctica introduce a los estudiantes a la llamada **"Revolución de la Credibilidad"** en econometría empírica. El propósito es desmitificar la idea de que la econometría consiste únicamente en "correr regresiones lineales con muchos controles" y, en su lugar, enfatizar la centralidad del **diseño de investigación** (*research design*).

Al finalizar la actividad, los estudiantes deben ser capaces de:
1. Calcular e interpretar con fluidez el estimador de Diferencias en Diferencias (DiD) en tablas 2x2 y en regresión con términos de interacción.
2. Argumentar formal e intuitivamente por qué el supuesto de tendencias paralelas es fundamental, cómo se evalúa y qué tipo de amenazas empíricas pueden sesgar la inferencia.
3. Descomponer el estimador de Variables Instrumentales en el cociente de Wald, vincularlo al marco de resultados potenciales de Rubin y comprender el teorema del Efecto Tratamiento Promedio Local (LATE) de Angrist e Imbens (1994).

---

## 2. Solución Detallada de los Ejercicios

### Solución al Ejercicio 1: Cálculo e Interpretación Manual de la Tabla 2x2 DiD (Nivel Básico)

#### 1. Diferencias simples antes y después:
- **Grupo de Control (Pennsylvania):**
  $$\Delta \bar{Y}_{\text{PA}} = \bar{Y}_{\text{PA, 1}} - \bar{Y}_{\text{PA, 0}} = 17.542 - 19.949 = -2.407 \text{ FTE}$$
  *Interpretación:* En los locales de comida rápida del este de Pennsylvania, el empleo promedio por establecimiento se contrajo en aproximadamente $2.41$ trabajadores a tiempo completo equivalente entre febrero y noviembre de 1992, reflejando las condiciones macroeconómicas generales de la recesión regional.
- **Grupo de Tratamiento (New Jersey):**
  $$\Delta \bar{Y}_{\text{NJ}} = \bar{Y}_{\text{NJ, 1}} - \bar{Y}_{\text{NJ, 0}} = 17.567 - 17.060 = +0.507 \text{ FTE}$$
  *Interpretación:* A pesar de enfrentar un incremento del $18.8\%$ en el piso salarial (de $\$4.25$ a $\$5.05$), los restaurantes de New Jersey experimentaron un leve incremento de medio trabajador FTE por local.

#### 2. Estimador de Diferencias en Diferencias:
$$\hat{\tau}_{\text{DiD}} = \Delta \bar{Y}_{\text{NJ}} - \Delta \bar{Y}_{\text{PA}} = (+0.507) - (-2.407) = +2.914 \text{ FTE}$$
Equivalentemente, restando las diferencias transversales:
$$\hat{\tau}_{\text{DiD}} = (\bar{Y}_{\text{NJ, 1}} - \bar{Y}_{\text{PA, 1}}) - (\bar{Y}_{\text{NJ, 0}} - \bar{Y}_{\text{PA, 0}}) = (17.567 - 17.542) - (17.060 - 19.949) = 0.025 - (-2.889) = +2.914 \text{ FTE}$$

#### 3. Interpretación Económica:
- **Predicción Neoclásica:** En un mercado competitivo con curvas de demanda laboral con pendiente negativa, un alza del $18.8\%$ en los salarios sin un cambio tecnológico correlativo desplaza el costo marginal hacia arriba, obligando a las firmas a recortar empleo o sustituir trabajo no calificado por maquinaria/automatización. Se predecía una pérdida sustancial de puestos de trabajo.
- **Contradicción Empírica:** El estimador $\hat{\tau}_{\text{DiD}} = +2.91$ indica que, relativo a lo que le ocurrió a Pennsylvania en el mismo periodo, el empleo en New Jersey **creció** en casi 3 trabajadores FTE por restaurante ($p = 0.07$ en MCO básico, $p = 0.009$ con efectos fijos de tienda). Esto refuta que un alza moderada del salario mínimo cause automáticamente despidos masivos.
- **Comparación ingenua post-tratamiento:** Si solo comparamos en el periodo posterior, $\bar{Y}_{\text{NJ, 1}} - \bar{Y}_{\text{PA, 1}} = 17.567 - 17.542 = +0.025 \approx 0$. Concluiríamos erróneamente que el salario mínimo no tuvo ningún efecto relativo. El sesgo surge porque los locales de New Jersey ya tenían históricamente niveles basales de empleo menores que los de Pennsylvania ($\bar{Y}_{\text{NJ, 0}} - \bar{Y}_{\text{PA, 0}} = -2.89$). DiD descuenta este sesgo de nivel fijo persistente.

---

### Solución al Ejercicio 2: El Supuesto de Tendencias Paralelas y Amenazas al Diseño (Nivel Intermedio)

#### 1. Formalización Matemática:
En el marco de resultados potenciales contrafácticos:
$$\mathbb{E}[Y_{i, 1}(0) - Y_{i, 0}(0) \mid \text{Tratado} = 1] = \mathbb{E}[Y_{i, 1}(0) - Y_{i, 0}(0) \mid \text{Control} = 0]$$
- *Por qué es intesteable directamente en $t=1$:* Porque para el grupo tratado en el periodo posterior solo observamos el estado con tratamiento $Y_{i, 1}(1)$. El contrafactual $Y_{i, 1}(0)$ (cuánto empleo habría tenido New Jersey en noviembre de 1992 de no haber incrementado el salario mínimo) es intrínsecamente inobservable en el mundo real.

#### 2. Evaluación Empírica con Datos Previos:
- Se estimaría un modelo de **estudio de eventos** (*event-study*) con múltiples periodos previos ($t = -3, -2, -1, 0$):
  $$Y_{it} = \alpha_i + \lambda_t + \sum_{k \neq -1} \beta_k (\text{NJ}_i \times \mathbf{1}\{t = k\}) + \varepsilon_{it}$$
- Se realiza una prueba de hipótesis conjunta ($F$-test) de pre-tendencias:
  $$H_0: \beta_{-3} = \beta_{-2} = 0$$
- Si los coeficientes previos no son estadísticamente diferentes de cero y la gráfica de eventos oscila en torno a cero antes del evento, se aporta evidencia empírica contundente de que ambos estados seguían dinámicas paralelas antes de la intervención regulatoria.

#### 3. Amenazas al Diseño Cuasi-Experimental:
- **Shocks Macroeconómicos Asimétricos:** Si la recesión manufacturera afectó con mayor intensidad al este de Pennsylvania que al sector servicios de New Jersey, la caída de $-2.41$ FTE en PA exageraría la caída contrafactual atribuible al ciclo, inflando artificialmente el estimador DiD de New Jersey hacia arriba. (Card y Krueger abordaron esto demostrando que tiendas de NJ que ya pagaban salarios altos antes de la ley no mostraron diferencias respecto a tiendas que pagaban salarios bajos).
- **Efectos de Derrame (*Spillovers*) y Violación de SUTVA:** La Asunción de Tratamiento de Valor Único Estable (*Stable Unit Treatment Value Assumption*, SUTVA) requiere que el tratamiento de un local no afecte los resultados potenciales de otros locales. Si trabajadores o clientes se desplazaron a través de la frontera interestatal, Pennsylvania deja de ser un control puro (se vuelve indirectamente "tratado"), sesgando el estimador. En la práctica, en el sector de comida rápida de bajo costo y commute corto, los autores verificaron que el tráfico fronterizo fue marginal.

---

### Solución al Ejercicio 3: Reto Teórico-Econométrico — El Marco LATE vs. ATE y Compliers (Nivel Avanzado)

#### 1. Cumplimiento Imperfecto y Tipos Latentes:
En la lotería del reclutamiento militar de la Guerra de Vietnam (Angrist, 1990):
- Ser sorteado con un número de lotería bajo ($Z_i = 1$) hacía al joven elegible para ser reclutado obligatoriamente, pero no todos los sorteados sirvieron (algunos tenían exenciones médicas, aplazamientos universitarios o salieron del país).
- No ser sorteado ($Z_i = 0$) no impedía alistarse voluntariamente.
- **Clasificación según Imbens & Angrist (1994):**
  - **Compliers:** Jóvenes que van al ejército si y solo si su número sale sorteado ($D(0)=0, D(1)=1$). Son los reclutas inducidos por el draft.
  - **Always-takers:** Jóvenes con vocación militar decidida que se habrían alistado como voluntarios sin importar la lotería ($D(0)=1, D(1)=1$).
  - **Never-takers:** Jóvenes que consiguen librarse del servicio militar bajo cualquier circunstancia ($D(0)=0, D(1)=0$).
  - **Defiers:** Individuos que irían al ejército si no son llamados, pero si el gobierno los recluta deciden no ir ($D(0)=1, D(1)=0$).

#### 2. El Supuesto de Monotonicidad:
- Establece que la asignación del instrumento afecta la probabilidad de tratamiento en una sola dirección: $D_i(1) \ge D_i(0) \ \forall i$. Es decir, la existencia de *Defiers* es nula ($\mathbb{P}(\text{Defiers}) = 0$).
- En el contexto militar, es completamente inverosímil que alguien decida alistarse voluntariamente cuando la ley lo declara exento, pero decida desacatar la orden cuando la ley lo obliga a servir. Por tanto, la monotonicidad se cumple con alta plausibilidad histórica.

#### 3. El Estimador de Wald y la Causalidad Local:
- **Cálculo:**
  - *Forma reducida (impacto del sorteo en ingresos):*
    $$\Delta \bar{Y} = \bar{Y}_{Z=1} - \bar{Y}_{Z=0} = 15,200 - 15,800 = -\$600$$
  - *Primera etapa (impacto del sorteo en la tasa de servicio militar):*
    $$\Delta \bar{D} = \bar{D}_{Z=1} - \bar{D}_{Z=0} = 0.30 - 0.14 = 0.16 \quad (16\%)$$
  - *Estimador de Wald (LATE):*
    $$\hat{\tau}_{\text{Wald}} = \frac{-\$600}{0.16} = -\$3,750$$
- **Interpretación del LATE:**
  - El servicio militar redujo los ingresos anuales futuros en aproximadamente $\$3,750$ dólares **únicamente para los *Compliers*** (aquellos que fueron al ejército exclusivamente porque fueron reclutados a la fuerza por la lotería).
- **LATE vs. ATE y Limitaciones de Validez Externa:**
  - $\hat{\tau}_{\text{Wald}}$ **no** es el ATE (el efecto promedio si reclutáramos a toda la población) ni el efecto en los voluntarios vocacionales (Always-takers), quienes probablemente poseen habilidades físicas o redes que les permiten integrarse mejor tras el retiro.
  - La validez externa es restringida: el resultado estima la penalización salarial por pérdida de experiencia en el mercado laboral civil de personas reacias al servicio militar forzado, por lo que no puede extrapolarse directamente a evaluar los salarios de soldados profesionales en un ejército moderno totalmente voluntario.

---

## 3. Criterios de Evaluación y Rúbrica Sugerida

| Nivel de Desempeño | Ejercicio 1 (DiD Básico) | Ejercicio 2 (Tendencias Paralelas) | Ejercicio 3 (LATE & Compliers) |
| :--- | :--- | :--- | :--- |
| **Excelente (90-100%)** | Cálculos algebraicos sin error ($+2.91$ FTE). Explica con claridad la noción de contrafactual y el sesgo de la comparación transversal ingenua. | Formaliza el supuesto con resultados potenciales. Explica detalladamente el rol de pre-tendencias y dos amenazas empíricas reales. | Descompone los cuatro tipos latentes. Deriva $-\$3,750$ en Wald y analiza con madurez la distinción entre LATE, ATE y validez externa. |
| **Aceptable (70-89%)** | Obtiene el valor DiD pero presenta explicaciones teóricas superficiales sobre el modelo neoclásico. | Entiende el concepto de tendencias paralelas pero omite la formalización o una de las amenazas. | Calcula Wald correctamente pero titubea al definir monotonicidad o a qué subgrupo exacto corresponde el LATE. |
| **Por mejorar (<70%)** | Confunde los signos algebraicos o confunde el estimador DiD con una simple resta temporal. | No logra explicar por qué el supuesto es inobservable post-tratamiento. | Trata al estimador IV como un efecto promedio universal ignorando el cumplimiento imperfecto. |

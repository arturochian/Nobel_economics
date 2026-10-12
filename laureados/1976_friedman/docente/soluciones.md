# Guía Docente y Solucionario: Milton Friedman (Nobel 1976)

> **Material de uso pedagógico exclusivo para el profesorado.**  
> Este documento contiene el solucionario analítico riguroso paso a paso, comentarios conceptuales y rúbricas de evaluación para los ejercicios presentados en `laureados/1976_friedman/estudiante/ejercicios.qmd`.

---

## 1. Pautas Pedagógicas y Contexto Teórico

### El legado intelectual de Milton Friedman
Al impartir este módulo docente, es crucial articular los tres grandes aportes que motivaron el Premio Nobel de Economía de 1976:

1. **La Microeconomía del Ingreso Permanente (1957):**  
   Demostró que el consumo de los hogares no es un reflejo pasivo de la renta corriente mensual, sino el resultado de un plan intertemporal optimizador. El ahorro actúa como un amortiguador (*buffer*) que absorbe las fluctuaciones transitorias. Por tanto, el multiplicador del gasto fiscal keynesiano basado en transferencias extraordinarias es significativamente menor al previsto por la teoría tradicional.
2. **La Teoría Cuantitativa y la Crítica al Activismo Discrecional (1956, 1963):**  
   Friedman probó empíricamente la estabilidad de la demanda de saldos monetarios y la naturaleza esencialmente monetaria de la inflación secular. Asimismo, introdujo el concepto de rezagos largos y variables (*long and variable lags*): la política monetaria tarda meses o años en manifestar sus plenos efectos, por lo que el "ajuste fino" discrecional suele tener un impacto procíclico, aconsejando en su lugar reglas de emisión transparentes y predecibles.
3. **La Tasa Natural de Desempleo y la Curva de Phillips Vertical (1968, 1977):**  
   Desmanteló la noción de un trade-off permanente entre inflación y desempleo. Con expectativas adaptativas (y más tarde racionales), cualquier intento deliberado de fijar el desempleo por debajo de su nivel estructural de equilibrio ($u_n$ o NAIRU) no produce un nivel estable de inflación más alto, sino una inflación en continua aceleración.

---

## 2. Solución Detallada del Ejercicio 1 (Nivel Básico)

### Pregunta 1: Predicción del Modelo Keynesiano Ingenuo
- **Función keynesiana:** $C_t = a + c Y_t$, con $c = 0.80$ y $a = 5.000$.
- **Programa A (Bono transitorio de $10.000$ USD en $t=1$):**
  $$\Delta C_1^{\text{Keynes}} = c \cdot \Delta Y_1 = 0.80 \times 10.000 = 8.000 \text{ USD}$$
  El modelo keynesiano predice que el $80\%$ del bono extraordinario se gastará inmediatamente en bienes de consumo corriente durante el año 1.
- **Programa B (Aumento permanente de $2.000$ USD al año):**
  $$\Delta C_1^{\text{Keynes}} = c \cdot \Delta Y_1 = 0.80 \times 2.000 = 1.600 \text{ USD}$$

### Pregunta 2: Predicción de la Hipótesis del Ingreso Permanente (Friedman, 1957)
- **Factor de anualidad intertemporal ($\phi$):**
  Para $r = 0.04$ y $T = 25$ años:
  $$\phi = \frac{r}{1 - (1+r)^{-T}} = \frac{0.04}{1 - (1.04)^{-25}} = \frac{0.04}{1 - 0.375117} = \frac{0.04}{0.624883} \approx 0.064012$$
- **Programa A (Bono transitorio de $10.000$ USD):**
  El valor presente del incremento en la riqueza intertemporal es simplemente el valor nominal del bono recibido en $t=1$: $\Delta PV = 10.000$ USD.
  El incremento en el ingreso permanente es la anualidad equivalente:
  $$\Delta Y_1^p = \phi \cdot \Delta PV = 0.064012 \times 10.000 \approx 640.12 \text{ USD al año}$$
  Dado que bajo la PIH con suavizamiento perfecto $k = 1.0$:
  $$\Delta C_1^{\text{Friedman}} = k \cdot \Delta Y_1^p = 640.12 \text{ USD}$$
  - **Ahorro en el año 1:**
    $$\Delta S_1^{\text{Friedman}} = \Delta Y_1 - \Delta C_1^{\text{Friedman}} = 10.000 - 640.12 = 9.359.88 \text{ USD}$$
    El hogar ahorra el **$93.6\%$** del bono transitorio, consumiendo únicamente el rendimiento de anualidad que permite sostener un gasto extra de $640.12$ USD durante los 25 años restantes de vida.
- **Programa B (Aumento permanente de $2.000$ USD al año):**
  El flujo salarial aumenta en $2.000$ USD en todos y cada uno de los 25 años.
  Por consiguiente, el ingreso permanente se incrementa exactamente en:
  $$\Delta Y_1^p = 2.000 \text{ USD}$$
  El incremento en el consumo corriente es:
  $$\Delta C_1^{\text{Friedman}} = k \cdot \Delta Y_1^p = 1.0 \times 2.000 = 2.000 \text{ USD al año}$$
  Bajo un choque permanente, la propensión marginal a consumir efectiva respecto al cambio en el flujo salarial es del **$100\%$**.

### Pregunta 3: Comparación e Implicancias de Política Pública

| Métrica / Escenario | Keynesiano Ingenuo | Hipótesis Ingreso Permanente |
|:---|:---:|:---:|
| **Choque Transitorio ($+10.000$ en $t=1$)** | | |
| $\Delta C_1$ (Consumo año 1) | $\$8.000$ ($80\%$) | $\$640.12$ ($6.4\%$) |
| $\Delta S_1$ (Ahorro año 1) | $\$2.000$ ($20\%$) | $\$9.359.88$ ($93.6\%$) |
| **Choque Permanente ($+2.000$ cada año)** | | |
| $\Delta C_1$ (Consumo año 1) | $\$1.600$ ($80\%$) | $\$2.000$ ($100\%$) |
| $\Delta S_1$ (Ahorro año 1) | $\$400$ ($20\%$) | $\$0$ ($0\%$) |

*Comentario Pedagógico:*  
La lección de política económica de Friedman es contundente: las transferencias transitorias (como cheques de alivio fiscal o devoluciones puntuales) tienen una propensión marginal a consumir muy pequeña entre los hogares con acceso a crédito. La mayor parte de los fondos se destina a ahorrar o pagar deudas previas. Para lograr un estímulo duradero del consumo, las familias deben percibir que sus ingresos netos a largo plazo han aumentado estructuralmente.

---

## 3. Solución Detallada del Ejercicio 2 (Nivel Intermedio)

### Pregunta 1: Regla de Crecimiento Monetario ($k\%$ de Friedman)
Partiendo de la identidad cuantitativa diferenciada:
$$\frac{\dot{M}}{M} + \frac{\dot{V}}{V} = \pi + g_y$$
Despejando la tasa de crecimiento monetario fijada como regla constante $k$:
$$k = \frac{\dot{M}}{M} = \pi^* + g_y - \frac{\dot{V}}{V}$$
Sustituyendo los parámetros estructurales:
- $\pi^* = 2.0\%$
- $g_y = 3.2\%$
- $\dot{V}/V = -0.7\%$

$$k = 2.0\% + 3.2\% - (-0.7\%) = 5.2\% + 0.7\% = 5.9\% \text{ anual}$$

*Interpretación:* La oferta monetaria debe expandirse al **$5.9\%$ anual** para absorber el crecimiento del PIB real del $3.2\%$ y compensar la caída tendencial de la velocidad del dinero del $-0.7\%$, garantizando una inflación exacta del $2.0\%$.

- **Caso de emisión descontrolada al $11.5\%$ anual:**
  $$\pi = \frac{\dot{M}}{M} + \frac{\dot{V}}{V} - g_y = 11.5\% + (-0.7\%) - 3.2\% = 7.6\% \text{ anual}$$
  La tasa de inflación resultante en el mediano plazo se estabilizará en el **$7.6\%$ anual**, ratificando la tesis monetarista de que el exceso de oferta monetaria sobre la demanda real se traslada íntegramente a precios.

### Pregunta 2: Rezagos Largos y Variables
a) **Cronología del estímulo:**
   - La recesión comienza en el mes 0 y dura 6 meses (termina en el mes 6).
   - El estímulo monetario discrecional se aprueba e inyecta en el **mes 4**.
   - Con un rezago de transmisión de 9 meses, el efecto expansivo máximo sobre la demanda agregada se materializa en el mes:
     $$\text{Mes de impacto máximo} = 4 + 9 = \text{Mes 13}$$
b) **Carácter procíclico de la política discrecional:**
   - En el mes 13, la recesión terminó hace ya 7 meses y la economía se encuentra en plena fase de recuperación o auge cíclico natural.
   - El masivo estímulo monetario aterriza precisamente cuando los recursos productivos ya están plenamente ocupados, sobrecalentando la economía y generando presiones inflacionarias innecesarias.
   - Friedman concluyó que los intentos bienintencionados de las autoridades por hacer *fine-tuning* suelen desestabilizar la economía debido a la imposibilidad de calibrar con exactitud la duración de los rezagos externos e internos.

---

## 4. Solución Detallada del Ejercicio 3 (Nivel Reto)

### Pregunta 1: Cálculo de la Trayectoria Dinámica y Espiral Inflacionaria
- Modelo: $\pi_t = \pi_t^e - 0.8 (u_t - u_n) = \pi_t^e - 0.8 (0.035 - 0.050) = \pi_t^e + 0.8 \times 0.015 = \pi_t^e + 1.20\%$
- Mecanismo adaptativo: $\pi_t^e = \pi_{t-1}^e + 0.70 (\pi_{t-1} - \pi_{t-1}^e)$

**Cálculo período a período:**
1. **Período $t = 1$:**
   - $\pi_1^e = \pi_0^e = 2.00\%$
   - $\pi_1 = 2.00\% + 1.20\% = 3.20\%$
2. **Período $t = 2$:**
   - $\pi_2^e = 2.00\% + 0.70 \times (3.20\% - 2.00\%) = 2.00\% + 0.84\% = 2.84\%$
   - $\pi_2 = 2.84\% + 1.20\% = 4.04\%$
3. **Período $t = 3$:**
   - $\pi_3^e = 2.84\% + 0.70 \times (4.04\% - 2.84\%) = 2.84\% + 0.84\% = 3.68\%$
   - $\pi_3 = 3.68\% + 1.20\% = 4.88\%$
4. **Período $t = 4$:**
   - $\pi_4^e = 3.68\% + 0.70 \times (4.88\% - 3.68\%) = 3.68\% + 0.84\% = 4.52\%$
   - $\pi_4 = 4.52\% + 1.20\% = 5.72\%$
5. **Período $t = 5$:**
   - $\pi_5^e = 4.52\% + 0.70 \times (5.72\% - 4.52\%) = 4.52\% + 0.84\% = 5.36\%$
   - $\pi_5 = 5.36\% + 1.20\% = 6.56\%$

**Tabla Cronológica Consolidada:**

| Período ($t$) | Tasa de Desempleo ($u_t$) | Inflación Esperada ($\pi_t^e$) | Inflación Efectiva ($\pi_t$) | Aceleración ($\Delta \pi_t$) |
|:---:|:---:|:---:|:---:|:---:|
| $0$ | $5.0\%$ | $2.00\%$ | $2.00\%$ | — |
| $1$ | $3.5\%$ | $2.00\%$ | $3.20\%$ | $+1.20\%$ |
| $2$ | $3.5\%$ | $2.84\%$ | $4.04\%$ | $+0.84\%$ |
| $3$ | $3.5\%$ | $3.68\%$ | $4.88\%$ | $+0.84\%$ |
| $4$ | $3.5\%$ | $4.52\%$ | $5.72\%$ | $+0.84\%$ |
| $5$ | $3.5\%$ | $5.36\%$ | $6.56\%$ | $+0.84\%$ |

*Demostración analítica de la aceleración constante:*  
Dado que $\pi_t - \pi_t^e = 1.20\%$ constante, la revisión de expectativas en cada período es siempre $\Delta \pi_{t+1}^e = \lambda \times 1.20\% = 0.70 \times 1.20\% = 0.84\%$. Por lo tanto, la inflación debe acelerarse permanentemente a un ritmo fijo de $0.84$ puntos porcentuales por período: la curva de Phillips de corto plazo se desplaza continuamente hacia arriba.

### Pregunta 2: Caso de Expectativas Miopes ($\lambda = 1.0$)
- Con $\lambda = 1.0$, $\pi_t^e = \pi_{t-1}$.
- Sustituyendo: $\pi_t = \pi_{t-1} - \alpha (u_t - u_n) \implies \Delta \pi_t = -\alpha (u_t - u_n)$.
- Para $u = 3.5\%$, la aceleración anual es $\Delta \pi = 1.20\%$ constante en cada período.
- Tras 5 períodos:
  $$\pi_5 = \pi_0 + 5 \times 1.20\% = 2.0\% + 6.0\% = 8.0\% \text{ anual}$$

### Pregunta 3: Ratio de Sacrificio y Desinflación
- **Exigencia de desempleo:**  
  Para reducir la inflación observada por debajo de las expectativas vigentes ($\pi_t < \pi_t^e$), la ecuación $\pi_t - \pi_t^e = -\alpha(u_t - u_n)$ exige matemáticamente que $(u_t - u_n) > 0$. El banco central debe inducir deliberadamente un período de recesión y alto desempleo transitorio ($u > 5\%$) para quebrar las expectativas alcistas de los agentes.
- **Definición de Ratio de Sacrificio:**  
  El ratio de sacrificio mide el porcentaje acumulado de pérdida de PIB real (o el exceso acumulado de desempleo en puntos-año) necesario para reducir la inflación tendencial en un punto porcentual permanente:
  $$\text{Sacrifice Ratio} = \frac{\sum (u_t - u_n)}{\Delta \pi_{\text{permanente}}}$$
- **Friedman vs. Lucas-Sargent:**  
  - En el marco de expectativas adaptativas de Friedman, la desinflación siempre conlleva un costo real inevitable porque los agentes tardan tiempo en revisar sus expectativas pasadas.
  - La revolución de las expectativas racionales (Lucas, Sargent 1982) argumentó que si el banco central goza de **plena credibilidad institucional** y anuncia un cambio de régimen monetario transparente e incondicional, los agentes ajustarán sus expectativas de manera instantánea ($\pi_t^e \to \pi^*$), permitiendo una desinflación sin costo de desempleo (ratio de sacrificio cercano a cero).

---

## 5. Rúbrica de Evaluación Sugerida

| Criterio de Evaluación | Ponderación | Excelente (90-100%) | Satisfactorio (70-89%) | Necesita Mejora (<70%) |
|:---|:---:|:---|:---|:---|
| **Ejercicio 1: Ingreso Permanente y Consumo** | 30% | Deriva rigurosamente el factor de anualidad, diferencia choques transitorios y permanentes con exactitud numérica y analiza las implicancias de política fiscal. | Resuelve la mayoría de los cálculos pero comete errores menores en la anualidad o en la interpretación conceptual. | Confunde ingreso permanente con ingreso corriente o no calcula la anualidad intertemporal. |
| **Ejercicio 2: Teoría Cuantitativa y Rezagos** | 30% | Aplica con precisión la identidad porcentual de la TQM, calcula la regla $k\%$ e ilustra lúcidamente la naturaleza procíclica de los rezagos largos y variables. | Determina correctamente el valor de $k\%$ pero la argumentación sobre los rezagos de transmisión es incompleta. | Aplica fórmulas de forma errónea o no explica los rezagos internos y externos. |
| **Ejercicio 3: Curva de Phillips y Aceleracionismo** | 40% | Calcula con total precisión la espiral numérica de $\pi_t$ y $\pi_t^e$, demuestra la hipótesis aceleracionista y discute con profundidad el ratio de sacrificio y la credibilidad. | Obtiene la trayectoria de la espiral pero tiene fallos algebraicos menores o explicaciones superficiales del ratio de sacrificio. | No comprende el mecanismo de expectativas adaptativas o concluye erróneamente que la curva de largo plazo tiene pendiente negativa. |

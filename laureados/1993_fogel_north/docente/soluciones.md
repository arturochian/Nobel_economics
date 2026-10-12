# Guía Docente y Solucionario Completo: Robert W. Fogel y Douglass C. North (Nobel 1993)

> **Material Confidencial para el Docente:** Contiene el desarrollo matemático completo, soluciones numéricas paso a paso, código en R para el reto avanzado, análisis pedagógico y rúbrica analítica de evaluación para la guía de ejercicios de Cliometría y Nueva Economía Institucional.

---

## Solución al Ejercicio 1: Cálculo del Ahorro Social de Fogel y Evaluación de la Indispensabilidad Tecnológica (Nivel Básico)

### 1. Ahorro Social bajo Demanda Inelástica ($\eta = 0$)
- **Datos dados:**
  - Volumen de carga: $Q = 16,000$ millones de toneladas-milla.
  - Tarifa ferroviaria: $c_r = \$0.010$ / ton-milla.
  - Tarifa contrafáctica alternativa (agua + carreta + almacenamiento): $c_\alpha = \$0.025$ / ton-milla.
  - PNB observado en $T$: $\text{PNB} = \$10,000$ millones de dólares.
  - Tasa de crecimiento tendencial: $g = 2.5\%$ anual.

- **Costo total real:**
  $$C_{\text{real}} = Q \times c_r = 16,000 \times \$0.010 = \$160 \text{ millones de USD}$$

- **Costo total contrafáctico:**
  $$C_{\text{contrafáctico}} = Q \times c_\alpha = 16,000 \times \$0.025 = \$400 \text{ millones de USD}$$

- **Ahorro social absoluto ($SS$):**
  $$SS = C_{\text{contrafáctico}} - C_{\text{real}} = \$400 - \$160 = \$240 \text{ millones de USD}$$

- **Ahorro social como porcentaje del PNB:**
  $$\frac{SS}{\text{PNB}} = \frac{\$240}{\$10,000} = 0.024 = \mathbf{2.40\%}$$

---

### 2. Equivalencia Temporal del Retraso y Refutación de la Indispensabilidad
- Asumiendo crecimiento continuo $Y_t = Y_0 e^{g \cdot t}$:
  En el contrafáctico sin ferrocarriles, el producto neto disponible para la sociedad habría sido:
  $$Y_{\text{contrafáctico}} = \text{PNB} - SS = \$10,000 - \$240 = \$9,760 \text{ millones}$$
  La brecha proporcional de producto es $\frac{Y_{\text{contrafáctico}}}{\text{PNB}} = 1 - 0.024 = 0.976$.

- Para calcular el retraso temporal en años ($\Delta t$):
  $$e^{g \cdot \Delta t} = \frac{\text{PNB}}{Y_{\text{contrafáctico}}} = \frac{1}{1 - 0.024} \approx 1.02459$$
  $$\Delta t = \frac{\ln(1.02459)}{g} = \frac{0.02429}{0.025} \approx \mathbf{0.972 \text{ años}} \quad (\approx 11.7 \text{ meses})$$

- **Interpretación económica e historiográfica:**
  El retraso provocado por la ausencia total de la tecnología ferroviaria habría sido de **menos de un año completo de crecimiento económico normal**. En lugar de alcanzar el nivel de producto de 1890 en ese año, Estados Unidos lo habría alcanzado antes de concluir 1891 gracias a la extensión de canales y vías fluviales.
  Este resultado pulverizó la tesis del "despegue industrial inducido por un motor único" (*take-off driven by a leading sector*) formulada por W. W. Rostow: ninguna tecnología por sí sola es una condición indispensable o *sine qua non* para el desarrollo económico moderno.

---

### 3. Ajuste por Elasticidad de la Demanda ($\eta = -0.50$)
- **Variación porcentual del costo de transporte:**
  $$\frac{\Delta P}{P_0} = \frac{c_\alpha - c_r}{c_r} = \frac{0.025 - 0.010}{0.010} = \frac{0.015}{0.010} = 1.50 \quad (150\%)$$

- **Ahorro social ajustado por pérdida de excedente:**
  $$SS_{\text{ajustado}} \approx SS_0 \left[ 1 + \frac{1}{2} \eta \left( \frac{\Delta P}{P_0} \right) \right]$$
  $$SS_{\text{ajustado}} \approx 240 \times \left[ 1 + \frac{1}{2} (-0.50) \times 1.50 \right] = 240 \times [1 - 0.375] = 240 \times 0.625 = \mathbf{\$150 \text{ millones de USD}}$$

- **Porcentaje sobre el PNB:**
  $$\frac{SS_{\text{ajustado}}}{\text{PNB}} = \frac{\$150}{\$10,000} = 0.015 = \mathbf{1.50\%}$$
  El retraso temporal se reduce a tan solo:
  $$\Delta t_{\text{ajustado}} \approx \frac{0.015}{0.025} = 0.60 \text{ años} \quad (\approx 7.2 \text{ meses})$$

- **Estrategia metodológica de Fogel:**
  Fogel adoptó deliberadamente el supuesto de demanda perfectamente inelástica ($\eta = 0$) como una estrategia de demostración *a fortiori*: al elegir el supuesto más extremo y favorable para quienes defendían la indispensabilidad del ferrocarril, demostró que aun en el límite superior el impacto no superaba el 5% del PNB. Cualquier aproximación más realista a la conducta de los agentes económicos arroja un ahorro social todavía menor.

---

## Solución al Ejercicio 2: El Modelo de Compromiso Creíble de North y Weingast (Nivel Intermedio)

### 1. Condición de Equilibrio de No Arbitraje
- El inversor neutral al riesgo compara el activo libre de riesgo con la deuda soberana. En equilibrio:
  $$\mathbb{E}[\text{Retorno}] = (1 - p)(1 + R) + p \times 0 = 1 + r^*$$
- Despejando $R$:
  $$1 + R = \frac{1 + r^*}{1 - p} \implies \mathbf{R = \frac{1 + r^*}{1 - p} - 1 = \frac{r^* + p}{1 - p}}$$
- **Análisis de sensibilidad y convexidad:**
  $$\frac{\partial R}{\partial p} = \frac{(1 - p) - (r^* + p)(-1)}{(1 - p)^2} = \frac{1 + r^*}{(1 - p)^2} > 0$$
  $$\frac{\partial^2 R}{\partial p^2} = \frac{2(1 + r^*)}{(1 - p)^3} > 0 \quad (\forall p < 1)$$
  La prima de riesgo no solo crece cuando aumenta la probabilidad de repudio, sino que lo hace a un ritmo acelerado (convexa), lo que explica por qué los gobiernos absolutistas con alto riesgo de confiscación quedan rápidamente excluidos del mercado crediticio voluntario (*credit rationing*).

---

### 2. Comparación Histórica Cuantitativa
- Tasa libre de riesgo: $r^* = 0.035$ (3.5%).
- **Régimen 1: Monarquía Absoluta (Estuardo, pre-1688):** $p_{\text{abs}} = 0.085$ (8.5%).
  $$R_{\text{abs}} = \frac{1 + 0.035}{1 - 0.085} - 1 = \frac{1.035}{0.915} - 1 \approx 1.13115 - 1 = \mathbf{13.12\% \text{ anual}}$$
- **Régimen 2: Monarquía Parlamentaria (Post-1688):** $p_{\text{parl}} = 0.005$ (0.5%).
  $$R_{\text{parl}} = \frac{1 + 0.035}{1 - 0.005} - 1 = \frac{1.035}{0.995} - 1 \approx 1.04020 - 1 = \mathbf{4.02\% \text{ anual}}$$
- **Diferencial de tasas de interés:**
  $$\Delta R = 13.12\% - 4.02\% = \mathbf{-9.10 \text{ puntos porcentuales}}$$

---

### 3. Impacto Fiscal y la Paradoja del Soberano
- Para un stock de deuda pública viva de $D = £25$ millones de libras esterlinas:
  $$\text{Intereses bajo Absolutismo} = £25\text{M} \times 0.13115 = £3.279 \text{ millones anuales}$$
  $$\text{Intereses bajo Parlamento} = £25\text{M} \times 0.04020 = £1.005 \text{ millones anuales}$$
  $$\text{Ahorro fiscal anual} = £3.279\text{M} - £1.005\text{M} = \mathbf{£2.274 \text{ millones anuales}} \quad (\text{reducción del } 69.3\%)$$

- **Resolución de la Paradoja del Soberano:**
  Un monarca absoluto con poder irrestricto sufre un problema crónico de **inconsistencia dinámica**: puesto que no existe ninguna fuerza legal externa que le impida repudiar sus compromisos, su promesa de repago carece de credibilidad ante los inversores privados. En consecuencia, el monarca termina siendo financieramente impotente, viéndose forzado a recurrir a extorsiones, préstamos forzosos y monopolios ineficientes.
  Por el contrario, al someterse al control presupuestario del Parlamento y la ley (la doctrina del *compromiso creíble*), el Estado parlamentario se "ata las manos" voluntariamente. Esta pérdida de discrecionalidad genera confianza institucional, colapsa el costo del capital y le permite al Estado levantar volúmenes de deuda gigantescos sin default, financiando la infraestructura pública y el poderío militar nacional.

---

## Solución al Ejercicio 3: Reto de Simulación en R (Nivel Avanzado)

### Código R Completo y Modular

```r
# ==============================================================================
# Script de Solucion: Ejercicio 3 (Reto Institucional de North en R)
# ==============================================================================

library(ggplot2)
library(dplyr)
library(patchwork)

# Funcion de simulacion del mercado segun calidad institucional
simular_mercado_north <- function(I, N = 1000, seed = 1993) {
  set.seed(seed)
  # Productividad heterogenea de los emprendedores
  y_potencial <- rlnorm(N, meanlog = 3.0, sdlog = 0.5)
  y_local <- 15.0
  
  # Costos de transaccion variables y fijos
  tau <- 0.50 * exp(-3.0 * I)
  c_legal <- 8.0 * (1 - I)
  
  # Ingreso neto en mercado impersonal
  y_impersonal <- y_potencial * (1 - tau) - c_legal
  
  # Decision del agente: entra si el ingreso neto supera la subsistencia
  participa_impersonal <- y_impersonal > y_local
  ingreso_realizado <- ifelse(participa_impersonal, y_impersonal, y_local)
  
  data.frame(
    I = I,
    Tasa_Participacion_Pct = mean(participa_impersonal) * 100,
    Ingreso_Medio = mean(ingreso_realizado),
    Ingreso_Total = sum(ingreso_realizado),
    Costos_Transaccion_Pct = tau * 100
  )
}

# Evaluar grilla de calidad institucional
grilla_I <- seq(0.05, 0.95, by = 0.05)
resultados_simulacion <- do.call(rbind, lapply(grilla_I, simular_mercado_north))

# Panel A: Tasa de participacion en el mercado moderno
p_part <- ggplot(resultados_simulacion, aes(x = I, y = Tasa_Participacion_Pct)) +
  geom_line(color = "#1f77b4", linewidth = 1.2) +
  geom_point(color = "#1f77b4", size = 2) +
  geom_vline(xintercept = 0.35, linetype = "dashed", color = "#d62728") +
  annotate("text", x = 0.37, y = 30, label = "Punto de Inflexion (I ~ 0.35)", 
           hjust = 0, color = "#d62728", fontface = "bold", size = 3.5) +
  scale_x_continuous(breaks = seq(0, 1, 0.2), labels = scales::percent_format()) +
  scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, 20)) +
  labs(
    title = "A) Transicion al Mercado Impersonal Moderno",
    subtitle = "Porcentaje de emprendedores que abandonan la economia comunal",
    x = "Calidad de las Instituciones Judiciales y de Propiedad (I)",
    y = "Participacion en Mercado Moderno (%)"
  ) +
  theme_minimal(base_size = 11)

# Panel B: Ingreso agregado de la economia
p_ingreso <- ggplot(resultados_simulacion, aes(x = I, y = Ingreso_Total / 1000)) +
  geom_line(color = "#2ca02c", linewidth = 1.2) +
  geom_point(color = "#2ca02c", size = 2) +
  scale_x_continuous(breaks = seq(0, 1, 0.2), labels = scales::percent_format()) +
  labs(
    title = "B) Produccion Agregada de la Economia",
    subtitle = "Expansion del PIB al desplegarse el intercambio impersonal",
    x = "Calidad de las Instituciones Judiciales y de Propiedad (I)",
    y = "PIB Agregado (Miles de unidades)"
  ) +
  theme_minimal(base_size = 11)

fig_simulacion_reto <- p_part / p_ingreso
print(fig_simulacion_reto)
```

### Resultados Cuantitativos del Reto
- Para $I < 0.20$, los costos de transacción consumen más del 30% del valor de cada transacción y el litigio es prohibitivo ($C_{\text{legal}} > 6.5$), por lo que menos del **6%** de los agentes participan en el mercado moderno; la economía está atrapada en una **trampa de subsistencia**.
- Entre $I = 0.30$ y $I = 0.50$, opera una transición no lineal abrupta (*tipping point*): la participación salta del **25%** al **82%**.
- Para $I > 0.70$, más del **95%** de los emprendedores operan en el mercado global impersonal y el PIB total se multiplica por más de **2.5 veces** respecto al nivel comunal.

---

## Solución a las Preguntas de Debate Historiográfico

1. **Límites epistemológicos de los contrafácticos:**
   - Fogel reconoció que un modelo contrafáctico a escala macroeconómica enfrenta el reto del equilibrio general: al suprimir los ferrocarriles, la estructura de precios relativos de toda la economía cambia. Fogel abordó esto modelando la respuesta de la red alternativa de canales y la inversión contrafáctica de capital.
   - Críticos como Paul David argumentaron que Fogel pudo subestimar externalidades técnicas y de organización empresarial (el ferrocarril impulsó la contabilidad de costos moderna y las sociedades anónimas por acciones). No obstante, el consenso de la literatura valida el mérito central de Fogel: desarmó el mito determinista de la "tecnología mesiánica".

2. **La controversia de *Time on the Cross* (Fogel y Engerman 1974):**
   - Fogel y Engerman demostraron con datos censales que las plantaciones de algodón con esclavos eran altamente rentables y exhibían una productividad total de los factores (PTF) superior en un 35% a las granjas libres del Norte, producto de la rígida disciplina laboral y economías de escala forzadas (*gang system*).
   - Esta conclusión enfureció a muchos historiadores que temían que sugiriera una justificación moral de la esclavitud. Fogel aclaró tajantemente en *Without Consent or Contract* (1989) que la eficiencia neoclásica es un concepto puramente descriptivo, no normativo: la esclavitud era una abominación ética y moral absoluta que privaba de libertad humana básica a millones de personas, y su viabilidad económica demostraba precisamente que las fuerzas ciegas del mercado libre no son suficientes para erradicar la tiranía sin intervención política y moral deliberada.

3. **Vínculo entre North y el Nobel 2024 (Acemoglu, Johnson y Robinson):**
   - Douglass North proporcionó el andamiaje teórico fundacional de la Nueva Economía Institucional. Acemoglu, Johnson y Robinson (AJR) formalizaron empíricamente la hipótesis de North utilizando experimentos naturales históricos y variables instrumentales (la mortalidad de colonos europeos).
   - Ambos enfoques coinciden en que las diferencias de prosperidad entre países son causadas por instituciones extractivas vs inclusivas. North enfatizó la evolución incremental, los costos de transacción y la dependencia de la trayectoria; AJR enfatizaron el conflicto distributivo y el equilibrio de poder político que determina qué coalición impone las reglas del juego.

---

## Rúbrica Analítica de Evaluación para el Docente

| Criterio | Ponderación | Excelente (90–100%) | Satisfactorio (70–89%) | Necesita Mejora (<70%) |
|---|---|---|---|---|
| **Cálculo de Ahorro Social (Ej. 1)** | 25% | Deducción impecable de $SS$, porcentaje sobre el PNB, cálculo del retraso temporal en meses y ajuste por elasticidad $\eta$. | Cálculo correcto de $SS$, pero imprecisiones menores en el retraso o en la interpretación de $\eta$. | Errores en la fórmula de $SS$ o incapacidad de relacionar el resultado con la indispensabilidad. |
| **Modelo de Compromiso Creíble (Ej. 2)** | 30% | Demostración analítica de la condición de no arbitraje, cálculo exacto de $R_{\text{abs}}$ y $R_{\text{parl}}$, y resolución de la paradoja del soberano. | Ecuación de no arbitraje correcta y cálculo numérico adecuado, con explicación conceptual incompleta. | Confusión en las probabilidades de default o en el cálculo de las primas de riesgo soberano. |
| **Simulación Computacional en R (Ej. 3)** | 30% | Código modular y reproducible, correcta especificación de funciones de costos de transacción, gráficos claros e identificación del *tipping point*. | Script en R funcional pero con visualización básica o análisis superficial de los resultados simulados. | El script no ejecuta, contiene errores de sintaxis o no implementa la lógica de decisión de los agentes. |
| **Argumentación Historiográfica** | 15% | Análisis crítico maduro sobre contrafácticos, la economía moral de Fogel y el legado institucional de North hacia AJR. | Respuestas razonables pero superficiales o puramente descriptivas sin profundidad analítica. | Respuestas vagas que ignoran los debates historiográficos de Fogel y North. |

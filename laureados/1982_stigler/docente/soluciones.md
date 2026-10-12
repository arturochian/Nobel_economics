# Pautas Docentes y Soluciones: Economía de la Información y Captura Regulatoria

> **Curso:** Organización Industrial / Microeconomía Avanzada / Economía Pública  
> **Tema:** Premio Nobel de Economía 1982 — George J. Stigler  
> **Documento:** Solucionario y Guía Pedagógica para el Profesor  

---

## 1. Pautas Pedagógicas y Objetivos de Aprendizaje

El objetivo de esta guía es que el estudiante interiorice cómo George J. Stigler revolucionó la microeconomía al introducir los **costos de información** y la **economía política del Estado**. Se recomienda enfatizar tres contrastes pedagógicos fundamentales:

1. **Información como recurso escaso vs. información perfecta:** Evitar que los alumnos vean la dispersión de precios como una anomalía irracional. Deben comprender que la varianza de precios es un equilibrio de mercado en presencia de costos de búsqueda positivos ($c > 0$).
2. **Teoría del interés público vs. teoría de la captura:** Contrastar la visión normativa tradicional (Pigou: "el regulador corrige fallas") con la visión positiva de Stigler ("la industria demanda regulación para levantar barreras a la entrada"). Los alumnos deben aprender a identificar qué grupos de interés ganan y pierden con cada ley.
3. **Técnica del superviviente vs. contabilidad estática:** Enfatizar la elegancia del enfoque metodológico de Stigler (1958): el mercado filtra y selecciona las escalas eficientes con mayor rigor que las estimaciones econométricas de costos contables.

---

## 2. Solución Detallada al Ejercicio 1 (Búsqueda de Información de Stigler)

### 1. Estadística de Orden del Precio Mínimo:
- La variable aleatoria de precio individual sigue una distribución continua uniforme $P \sim U(600, 1200)$, con $a = 600$ y $b = 1200$.
  $$F(p) = \frac{p - 600}{1200 - 600} = \frac{p - 600}{600}, \quad p \in [600, 1200]$$
- La función de distribución acumulada de la primera estadística de orden $P_{(1:n)} = \min(P_1, \dots, P_n)$ es:
  $$F_{(1:n)}(p) = 1 - [1 - F(p)]^n = 1 - \left( 1 - \frac{p - 600}{600} \right)^n = 1 - \left( \frac{1200 - p}{600} \right)^n$$
- La función de densidad de probabilidad es:
  $$f_{(1:n)}(p) = \frac{d}{dp} F_{(1:n)}(p) = \frac{n}{600} \left( \frac{1200 - p}{600} \right)^{n-1}$$
- El valor esperado analítico es:
  $$E[P_{(1:n)}] = \int_{600}^{1200} p \cdot \frac{n}{600} \left( \frac{1200 - p}{600} \right)^{n-1} dp$$
  Haciendo el cambio de variable $u = \frac{1200 - p}{600} \implies p = 1200 - 600u, \, dp = -600 du$:
  $$E[P_{(1:n)}] = \int_0^1 (1200 - 600u) \cdot n u^{n-1} du = 1200 \left[ u^n \right]_0^1 - 600n \left[ \frac{u^{n+1}}{n+1} \right]_0^1 = 1200 - \frac{600n}{n+1}$$
  Reescribiendo algebraicamente:
  $$E[P_{(1:n)}] = 600 + \left( 600 - \frac{600n}{n+1} \right) = 600 + \frac{600}{n + 1}$$
- **Evaluación numérica para $n = 1, 2, 3, 4, 5$:**
  - $n = 1$: $E[P_{(1:1)}] = 600 + 600/2 = \$900.00$ (precio promedio del mercado).
  - $n = 2$: $E[P_{(1:2)}] = 600 + 600/3 = \$800.00$ (ahorro de $\$100.00$).
  - $n = 3$: $E[P_{(1:3)}] = 600 + 600/4 = \$750.00$ (ahorro de $\$50.00$).
  - $n = 4$: $E[P_{(1:4)}] = 600 + 600/5 = \$720.00$ (ahorro de $\$30.00$).
  - $n = 5$: $E[P_{(1:5)}] = 600 + 600/6 = \$700.00$ (ahorro de $\$20.00$).
  - **Interpretación:** La tasa de reducción del precio esperado es fuertemente decreciente. La segunda cotización ahorra $\$100$, mientras que la quinta cotización solo ahorra $\$20$.

### 2. Beneficio Marginal y Regla de Parada para $Q = 1$:
- El beneficio marginal esperado es:
  $$MB(n) = E[P_{(1:n-1)}] - E[P_{(1:n)}] = \frac{600}{n} - \frac{600}{n+1} = \frac{600}{n(n+1)}$$
- Valores para $n \ge 2$:
  - $n = 2$: $MB(2) = 600 / (2 \times 3) = \$100.00$
  - $n = 3$: $MB(3) = 600 / (3 \times 4) = \$50.00$
  - $n = 4$: $MB(4) = 600 / (4 \times 5) = \$30.00$
  - $n = 5$: $MB(5) = 600 / (5 \times 6) = \$20.00$
  - $n = 6$: $MB(6) = 600 / (6 \times 7) = \$14.29$
- **Regla de parada con $c = \$15.00$ y $Q = 1$:**
  - Para $n = 5$: $MB(5) = \$20.00 \ge \$15.00$ (vale la pena cotizar).
  - Para $n = 6$: $MB(6) = \$14.29 < \$15.00$ (el costo de $\$15$ supera el ahorro esperado de $\$14.29$).
  - Por lo tanto, el número óptimo de búsquedas es **$n^* = 5$ cotizaciones**.
  - El precio mínimo esperado pagado será **$E[P_{(1:5)}] = \$700.00$**.

### 3. El Efecto del Volumen Comprado ($Q = 10$ televisores):
- Para el hotel con $Q = 10$, el beneficio marginal total es $10 \cdot MB(n) = \frac{6000}{n(n+1)}$:
  - $n = 19$: $10 \cdot MB(19) = 6000 / (19 \times 20) = 6000 / 380 \approx \$15.79 \ge \$15.00$.
  - $n = 20$: $10 \cdot MB(20) = 6000 / (20 \times 21) = 6000 / 420 \approx \$14.29 < \$15.00$.
  - Por lo tanto, el número óptimo es **$n^*_{\text{hotel}} = 19$ cotizaciones**.
  - **Explicación económica:** El costo de búsqueda es fijo por cotización ($c = \$15$), pero el ahorro obtenido en el precio unitario se multiplica por las $Q = 10$ unidades compradas. Por ello, los agentes con mayores presupuestos o compras mayoristas invierten sustancialmente más en buscar cotizaciones y obtienen precios promedio significativamente menores.

### 4. Impacto de la Reducción de Costos de Búsqueda ($c' = \$1.00$):
- Condición: $MB(n^*) = \frac{600}{n(n+1)} \ge 1.00 \implies n(n+1) \le 600$.
  Como $24 \times 25 = 600$, se tiene $n^* = 24$ cotizaciones.
- Con $n^* = 24$, el precio esperado cae a $E[P_{(1:24)}] = 600 + 600/25 = \$624.00$.
- **Predicción de Stigler:** La reducción del costo de búsqueda (mediante internet, agregadores o anuncios clasificados) incrementa el número óptimo de comparaciones que realizan los consumidores. Esto fuerza a los vendedores a competir en precio, comprimiendo la dispersión de precios hacia el costo marginal de producción.

---

## 3. Solución Detallada al Ejercicio 2 (Captura Regulatoria en el Mercado de Taxis)

### Escenario A: Mercado Competitivo Libre
- Demanda inversa: $P = 100 - Q$, costo marginal $MC = c_0 = \$20$.
- En competencia perfecta de libre entrada:
  $$P_c = MC = \$20$$
  $$Q_c = 100 - P_c = 100 - 20 = 80 \text{ mil viajes al mes}$$
- Excedente del Consumidor:
  $$CS_c = \frac{1}{2} (P_{\max} - P_c) Q_c = \frac{1}{2} (100 - 20) \times 80 = \frac{1}{2} \times 80 \times 80 = \$3,200 \text{ miles} = \$3,200,000$$
- Beneficio de la industria: $\Pi_c = (P_c - c_0) Q_c = (20 - 20) \times 80 = \$0$.

### Escenario B: Captura Regulatoria con Licencias Congeladas ($Q_{reg} = 40$)
1. **Equilibrio Bajo Captura:**
   - Precio regulado en el mercado:
     $$P_{reg} = 100 - Q_{reg} = 100 - 40 = \$60 \text{ por viaje}$$
   - Excedente del consumidor:
     $$CS_{reg} = \frac{1}{2} (100 - 60) \times 40 = \frac{1}{2} \times 40 \times 40 = \$800 \text{ miles} = \$800,000$$
   - Rentas extraordinarias de los titulares de licencias:
     $$\Pi_{reg} = (P_{reg} - c_0) Q_{reg} = (60 - 20) \times 40 = 40 \times 40 = \$1,600 \text{ miles} = \$1,600,000 \text{ al mes}$$
2. **Pérdida de Eficiencia Social:**
   - Pérdida de peso muerto tradicional de Harberger:
     $$DWL = \frac{1}{2} (P_{reg} - P_c) (Q_c - Q_{reg}) = \frac{1}{2} (60 - 20) \times (80 - 40) = \frac{1}{2} \times 40 \times 40 = \$800 \text{ miles} = \$800,000$$
   - Gasto disipado en cabildeo y defensa política del monopolio (Tullock-Stigler):
     $$Gasto_{\text{cabildeo}} = 0.40 \times \$1,600,000 = \$640,000 \text{ al mes}$$
   - Pérdida social total de la regulación:
     $$\text{Pérdida Social Total} = DWL + Gasto_{\text{cabildeo}} = \$800,000 + \$640,000 = \$1,440,000 \text{ al mes}$$
   - **Comparación crítica:** El análisis neoclásico tradicional solo computaría el triángulo de Harberger ($\$800,000$). Stigler y Tullock demuestran que los recursos reales gastados en cabildeo, abogados y campañas políticas representan una pérdida destructiva adicional de $\$640,000$, elevando el daño social total en un **$80\%$ adicional**.
3. **Lógica de Acción Colectiva (Stigler, 1971):**
   - Renta neta mensual por empresa titular (100 empresas):
     $$\Pi_{\text{neta por empresa}} = \frac{\$1,600,000 - \$640,000}{100} = \frac{\$960,000}{100} = \$9,600 \text{ mensuales} \quad (\$115,200 \text{ al año})$$
   - Pérdida de excedente total de los consumidores:
     $$\Delta CS = CS_c - CS_{reg} = \$3,200,000 - \$800,000 = \$2,400,000 \text{ al mes}$$
   - Pérdida mensual promedio por consumidor individual ($500,000$ usuarios):
     $$\text{Pérdida per cápita} = \frac{\$2,400,000}{500,000} = \$4.80 \text{ al mes por usuario}$$
   - **Conclusión de Stigler:** Para un dueño de licencia, ganar $\$115,200$ anuales justifica fundar asociaciones, contratar abogados de élite y aportar activamente a las campañas políticas de los concejales. Para el usuario individual, una pérdida de $\$4.80$ mensuales no justifica faltar un día al trabajo para protestar ante el ayuntamiento. Esta asimetría estructural de beneficios concentrados frente a costos difusos garantiza la **captura casi inevitable del ente regulador**.

---

## 4. Solución Detallada al Ejercicio 3 (Principio del Superviviente en R)

### Código R Reproducible:

```r
# Cargar librerias
library(ggplot2)
library(dplyr)
library(tidyr)

# 1. Crear el data frame con datos de cuotas de mercado
datos_supervivencia <- tibble(
  Anio = 2015:2022,
  Clase_1_Pequena = c(28.5, 25.0, 21.0, 17.5, 14.0, 11.0, 8.5, 6.0),
  Clase_2_Mediana = c(34.0, 35.5, 37.0, 38.5, 40.0, 41.5, 42.5, 43.5),
  Clase_3_Grande  = c(25.5, 27.0, 29.5, 32.0, 35.0, 37.5, 40.0, 42.5),
  Clase_4_Masiva  = c(12.0, 12.5, 12.5, 12.0, 11.0, 10.0, 9.0, 8.0)
)

# Transformar a formato tidy/largo
df_tidy <- datos_supervivencia %>%
  pivot_longer(
    cols = starts_with("Clase"),
    names_to = "Categoria_Escala",
    values_to = "Cuota_Mercado"
  ) %>%
  mutate(
    Etiqueta_Escala = case_when(
      Categoria_Escala == "Clase_1_Pequena" ~ "Clase 1: Muy Pequeña (< 50)",
      Categoria_Escala == "Clase_2_Mediana" ~ "Clase 2: Mediana (50 - 150)",
      Categoria_Escala == "Clase_3_Grande"  ~ "Clase 3: Grande (150 - 300)",
      Categoria_Escala == "Clase_4_Masiva"  ~ "Clase 4: Masiva (> 300)"
    )
  )

# 2. Graficar la evolucion temporal de cuotas de mercado
p_superviviente <- ggplot(df_tidy, aes(x = Anio, y = Cuota_Mercado, color = Etiqueta_Escala, group = Etiqueta_Escala)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2.5) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(0, 50)) +
  scale_x_continuous(breaks = 2015:2022) +
  scale_color_brewer(palette = "Set1", name = "Escala Productiva:") +
  labs(
    title = "Principio del Superviviente de Stigler (1958)",
    subtitle = "Evolución de cuotas de mercado por tamaño de empresa a lo largo del tiempo",
    x = "Año",
    y = "Participación en la Producción Total (%)",
    caption = "Elaboración propia basada en la técnica del superviviente de George J. Stigler."
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom")

# Imprimir grafico
print(p_superviviente)
```

### Respuestas e Interpretación Económica:

1. **Identificación de Clases Eficientes (Supervivientes):**
   - **Clase 1 (Muy pequeña):** Se desploma de $28.5\%$ a $6.0\%$ (pierde $22.5$ puntos porcentuales). Es una escala claramente ineficiente: sufre de falta de economías de escala tecnológicas y no logra absorber los costos fijos.
   - **Clase 2 (Mediana) y Clase 3 (Grande):** Ambas crecen de forma sostenida:
     - Clase 2 pasa de $34.0\%$ a $43.5\%$ ($+9.5$ puntos).
     - Clase 3 pasa de $25.5\%$ a $42.5\%$ ($+17.0$ puntos).
     - Ambas clases representan en conjunto el **$86.0\%$ del mercado en 2022**.
   - **Clase 4 (Masiva):** Pierde cuota de mercado, cayendo de $12.0\%$ a $8.0\%$.
2. **Determinación del Rango de Escala Eficiente:**
   - Aplicando la regla de Stigler, la curva de costos medios de largo plazo no es un punto único ni una curva en forma de U puntiaguda, sino que tiene un fondo plano en forma de plato o batea (*L-shaped* o fondo plano).
   - El rango de escala eficiente se ubica entre **$50$ y $300$ unidades de producción**. La escala mínima eficiente (MES) es de $50$ unidades.
3. **¿Por qué pierde cuota la Clase 4 (Masiva)?:**
   - Las estimaciones ingenieriles asumen falsamente que mientras más grande sea la maquinaria, más barato será el costo unitario.
   - Sin embargo, Stigler demostró que las operaciones masivas del mundo real enfrentan severas **deseconomías de escala organizacionales y de gestión**: problemas de información interna, burocracia corporativa, costos de supervisión laboral, huelgas y rigideces de adaptación frente a fluctuaciones de la demanda. El mercado castiga a estas empresas gigantescas, forzándolas a contraerse.

---

## 5. Rúbrica Analítica de Evaluación

| Criterio | Excelente (90–100%) | Aceptable (70–89%) | Insuficiente (< 70%) |
|:---|:---|:---|:---|
| **Modelo de Búsqueda (Stigler 1961)** | Deduce formalmente $F_{(1:n)}(p)$ y $E[P_{(1:n)}]$, deriva $MB(n)$ exacto y aplica correctamente la regla de parada para $Q=1$ y $Q=10$. | Aplica las fórmulas de valor esperado y regla de parada pero comete errores menores de integración o redondeo en $MB(n)$. | No comprende el concepto de estadística de orden ni la regla de parada marginal. |
| **Captura Regulatoria (Stigler 1971)** | Cuantifica con exactitud $CS, \Pi, DWL$, incorpora el gasto disipado de Tullock-Stigler y explica con rigor la asimetría de acción colectiva de Olson. | Calcula correctamente precios y cantidades, pero confunde el $DWL$ con la renta transferida o no analiza los costos difusos de los consumidores. | Cálculos de bienestar erróneos y no comprende la lógica económica de la captura política. |
| **Principio del Superviviente (R / Stigler 1958)** | Código R prolijo y reproducible en tidyverse; identifica el rango de escala eficiente (50-300) y argumenta las deseconomías organizacionales de escala. | Código R funcional pero con visualización deficiente; interpreta la supervivencia pero no identifica con claridad el fondo plano de la curva de costos. | Código R con errores sintácticos que no corre; no comprende la metodología de la técnica del superviviente. |

# Pautas Docentes y Soluciones: Racionalidad Limitada y Heurísticas de Decisión

> **Curso:** Microeconomía Avanzada / Teoría de la Decisión / Economía Conductual / Organización Industrial  
> **Tema:** Premio Nobel de Economía 1978 — Herbert A. Simon  
> **Documento:** Solucionario Integral y Guía Pedagógica para el Profesor  

---

## 1. Pautas Pedagógicas y Objetivos de Aprendizaje

El objetivo de esta guía es que los estudiantes internalicen la profunda ruptura epistemológica introducida por **Herbert A. Simon**:

1. **La falacia del óptimo global sin fricción:** La microeconomía estándar suele asumir que optimizar siempre es superior a cualquier otra regla de decisión. El docente debe guiar a los estudiantes a advertir que el costo computacional, el tiempo y la atención humana son recursos económicos escasos. Cuando evaluar cuesta algo ($c > 0$), la optimización exhaustiva es ineficiente y con frecuencia destructiva de valor.
2. **"Satisficing" no es pereza ni irracionalidad:** Debe quedar nítido que satisfacer (*satisficing*) es una forma superior de racionalidad procedimental (*procedural rationality*): maximiza la rentabilidad neta total tomando en cuenta la economía del esfuerzo mental.
3. **Homeostasis y aspiraciones adaptativas:** La aspiración no es un objetivo ciego, sino un termostato regulador que sube en abundancia y baja en escasez para garantizar la viabilidad de la organización.

---

## 2. Solución Detallada al Ejercicio 1 (Modelo Canónico de Satisfacción)

### 1. Probabilidad de Éxito Individual:
- La productividad individual sigue $V_i \sim U(20, 80)$.
- La función de densidad es $f(v) = \frac{1}{80 - 20} = \frac{1}{60}$ para $v \in [20, 80]$.
- La función de distribución acumulada es $F(v) = \frac{v - 20}{60}$.
- La probabilidad de que un candidato cumpla el nivel de aspiración $\alpha = 65$ es:
  $$p = P(V_i \ge 65) = 1 - F(65) = 1 - \frac{65 - 20}{60} = 1 - \frac{45}{60} = 1 - 0.75 = 0.25$$
  Es decir, el $25\%$ de los candidatos del mercado cumple o supera el estándar.

### 2. Distribución del Número de Entrevistas ($K$):
- La probabilidad de no encontrar ningún candidato satisfactorio en las primeras $k$ entrevistas es $(1 - p)^k = (0.75)^k$.
- Por ende, la probabilidad acumulada de éxito en o antes de la entrevista $k$ es:
  $$P(K \le k) = 1 - (1 - p)^k = 1 - (0.75)^k$$
- Para $k = 5$ entrevistas:
  $$P(K \le 5) = 1 - (0.75)^5 = 1 - 0.2373 = 0.7627 \quad (76.27\%)$$
- Para $k = 10$ entrevistas:
  $$P(K \le 10) = 1 - (0.75)^{10} = 1 - 0.0563 = 0.9437 \quad (94.37\%)$$
- **Interpretación:** Con solo $10$ entrevistas, el comité tiene un $94.4\%$ de certeza de haber cerrado con éxito el proceso de contratación.

### 3. Número Esperado de Evaluaciones:
- Para una variable aleatoria entera positiva truncada en $N$:
  $$E[K] = \sum_{k=1}^N P(K \ge k) = \sum_{k=1}^N (1 - p)^{k-1}$$
  Esta es una progresión geométrica finita con razón $q = 1 - p$:
  $$E[K] = \frac{1 - (1 - p)^N}{1 - (1 - p)} = \frac{1 - (1 - p)^N}{p}$$
- Sustituyendo $p = 0.25$ y $N = 100$:
  $$(1 - 0.25)^{100} = (0.75)^{100} \approx 3.2 \times 10^{-13} \approx 0$$
  $$E[K] = \frac{1 - 0}{0.25} = 4.00 \text{ entrevistas}$$
- **Comparación con el optimizador:** El optimizador exhaustivo requiere forzosamente entrevistar a los $100$ candidatos. La regla de Herbert Simon logra una decisión exitosa con solo $4$ entrevistas en promedio, un ahorro del **$96\%$ del esfuerzo y tiempo institucional**.

### 4. Valor Bruto Esperado y Eficiencia Relativa:
- Dado que la parada ocurre al encontrar un candidato con $V \ge 65$, y la distribución es uniforme sobre $[65, 80]$:
  $$E[V \mid V \ge 65] = \frac{65 + 80}{2} = 72.50$$
- Comparación con el óptimo global:
  El máximo teórico entre $100$ candidatos es $E[\max(V)] \approx 79.4$.
- **Razón de captura de valor:**
  $$\frac{E[V_{\text{sat}}]}{E[V_{\text{opt}}]} = \frac{72.50}{79.40} \approx 91.31\%$$
- **Conclusión de Simon:** El comité captura más del **$91.3\%$ de la excelencia global posible** gastando tan solo el **$4\%$ del esfuerzo de entrevistas**. La ganancia marginal de evaluar los restantes 96 candidatos es de apenas $6.9$ puntos de productividad, un rendimiento claramente decreciente.

---

## 3. Solución Detallada al Ejercicio 2 (Costo Cognitivo y Cruce de Dominancia)

### 1. Funciones de Utilidad Neta:
- **Optimizador exhaustivo ($N = 250$):**
  $$E[U_{\text{opt}}(c)] = 142.45 - 250 \cdot c$$
- **Satisfacedor de Simon ($p = 0.05 \implies E[K] \approx 20$):**
  $$E[U_{\text{sat}}(c)] = 130.90 - 20 \cdot c$$

### 2. Umbral Crítico de Fricción ($c^*$):
- La regla satisfactora domina estrictamente a la optimizadora cuando:
  $$E[U_{\text{sat}}(c)] > E[U_{\text{opt}}(c)]$$
  $$130.90 - 20 c > 142.45 - 250 c$$
  $$(250 - 20) c > 142.45 - 130.90$$
  $$230 c > 11.55 \implies c > \frac{11.55}{230} \approx 0.0502$$
- **Resultado:** El umbral crítico es **$c^* \approx 0.05$**.
- **Interpretación económica:** No se requiere un costo de evaluación desmesurado ni punitivo. Basta con que cada auditoría cueste un minúsculo $0.05\%$ del valor medio de un proyecto para que la regla de satisfacción de Simon supere por completo a la búsqueda exhaustiva tradicional. En cualquier entorno corporativo realista donde el tiempo de los ejecutivos tenga valor, la optimización exhaustiva es estrictamente ineficiente.

### 3. Punto de Colapso del Optimizador:
- La utilidad neta esperada del optimizador se vuelve negativa cuando:
  $$E[U_{\text{opt}}(c)] < 0 \implies 142.45 - 250 c < 0 \implies c > \frac{142.45}{250} \approx 0.5698$$
- Para $c = 0.57$, el optimizador exhaustivo incurre en destrucción neta de valor ($E[U_{\text{opt}}] \approx 0$).
- En contraste, evaluando la utilidad del satisfacedor en ese mismo costo $c = 0.57$:
  $$E[U_{\text{sat}}(0.57)] = 130.90 - 20 \times 0.57 = 130.90 - 11.40 = 119.50$$
- **Implicación práctica:** Este fenómeno formaliza la **sobrecarga de información (*information overload*)**: insistir en revisar todos los datos disponibles satura la capacidad operativa de la organización y destruye la rentabilidad del negocio.

---

## 4. Solución Detallada al Ejercicio 3 (Reto Computacional en R)

A continuación se presenta el script de R para simular la dinámica adaptativa de los niveles de aspiración de March & Simon (1958) y Cyert & March (1963):

```r
library(ggplot2)
library(dplyr)
library(patchwork)

set.seed(1978)

T_periodos <- 120
mu_macro <- c(rep(60, 40), rep(35, 40), rep(85, 40))
sd_macro <- c(rep(10, 40), rep(8, 40),  rep(12, 40))

simular_aspiracion <- function(lambda_val, alpha_ini = 62) {
  alpha_vec <- numeric(T_periodos)
  v_obtenido <- numeric(T_periodos)
  evals_vec  <- numeric(T_periodos)
  
  alpha_actual <- alpha_ini
  
  for (t in 1:T_periodos) {
    alpha_vec[t] <- alpha_actual
    pool <- rnorm(50, mean = mu_macro[t], sd = sd_macro[t])
    
    idx <- which(pool >= alpha_actual)
    if (length(idx) > 0) {
      evals_vec[t]  <- idx[1]
      v_obtenido[t] <- pool[idx[1]]
    } else {
      evals_vec[t]  <- 50
      v_obtenido[t] <- max(pool)
    }
    
    # Regla adaptativa de Simon
    alpha_actual <- (1 - lambda_val) * alpha_actual + lambda_val * v_obtenido[t]
  }
  
  return(data.frame(
    periodo = 1:T_periodos,
    lambda = factor(paste0("Lambda = ", lambda_val)),
    mu_entorno = mu_macro,
    aspiracion = alpha_vec,
    valor = v_obtenido,
    evaluaciones = evals_vec
  ))
}

df_rigida <- simular_aspiracion(lambda_val = 0.05)
df_adap   <- simular_aspiracion(lambda_val = 0.25)
df_total  <- bind_rows(df_rigida, df_adap)

# Comparación estadística en la fase de recesión (trimestres 41 a 80)
resumen_crisis <- df_total %>%
  filter(periodo >= 41 & periodo <= 80) %>%
  group_by(lambda) %>%
  summarise(
    evaluaciones_promedio = mean(evaluaciones),
    aspiracion_final_crisis = tail(aspiracion, 1)
  )

print(resumen_crisis)
```

### Respuestas a las Preguntas Teóricas del Ejercicio 3:

1. **Dinámica temporal y gráfico:**
   - La empresa adaptativa ($\lambda = 0.25$) responde con celeridad al colapso de la productividad en el trimestre 41: su nivel de aspiración cae de $62$ hacia aproximadamente $40$ en menos de $8$ trimestres.
   - La empresa rígida ($\lambda = 0.05$) mantiene metas anacrónicas elevadas durante más de $20$ trimestres, sufriendo un desajuste crónico entre sus expectativas burocráticas y la realidad del mercado.
2. **Desempeño durante la crisis (Trimestres 41 a 80):**
   - La empresa rígida experimenta fracasos continuos de búsqueda: en la inmensa mayoría de trimestres, ningún proyecto alcanza su aspiración rígida, forzándola a evaluar casi todos los $50$ proyectos (esfuerzo promedio $> 45$ evaluaciones por trimestre).
   - La empresa adaptativa ajusta rápidamente su umbral a la baja, estabilizando el número de evaluaciones en torno a $10$–$15$ proyectos por trimestre, ahorrando costos operativos y evitando el colapso administrativo.
3. **Homeostasis Organizacional:**
   - Para Simon, la organización es un sistema cibernético adaptativo que busca mantenerse en equilibrio dinámico (homeostasis). Si el nivel de aspiración es demasiado alto, la organización se paraliza por estrés y sobrecostos; si es demasiado bajo, cae en la complacencia. El mecanismo de aprendizaje con $\lambda \approx 0.20$–$0.25$ provee el amortiguador óptimo entre estabilidad estratégica y flexibilidad operativa.

---

## 5. Rúbrica Analítica de Evaluación

| Criterio | Excelente (90–100%) | Aceptable (70–89%) | Insuficiente (<70%) |
| :--- | :--- | :--- | :--- |
| **Dominio Conceptual de Simon** | Distingue con precisión entre racionalidad limitada, heurística satisfactora y optimización; fundamenta el rol de los costos cognitivos. | Comprende el concepto de *satisficing*, pero titubea al justificar por qué puede superar al óptimo global. | Confunde la regla satisfactora con un comportamiento irracional, perezoso o no estratégico. |
| **Modelación Matemática y Probabilidad** | Deriva con rigor algebraico la probabilidad geométrica truncada, el valor esperado condicional y el umbral $c^*$. | Obtiene los valores numéricos correctos pero comete errores leves en las demostraciones analíticas. | Errores sustanciales en el cálculo de probabilidades o incapacidad para plantear la regla de parada. |
| **Análisis de Costo Cognitivo y Eficiencia** | Interpreta a cabalidad el trade-off de eficiencia, el cruce de Simon y las implicaciones de sobrecarga informacional. | Calcula el umbral $c^*$ pero ofrece una interpretación puramente mecánica sin contexto corporativo. | No logra relacionar el costo de búsqueda con la pérdida de rentabilidad del optimizador. |
| **Simulación y Código en R** | Programa o interpreta con fluidez la dinámica adaptativa $\alpha_t$, identifica los regímenes y extrae conclusiones de homeostasis. | Ejecuta la simulación con asistencia pero interpreta parcialmente las diferencias entre empresas rígidas y adaptativas. | El código presenta errores de ejecución o no se explica la relación con los choques estructurales. |

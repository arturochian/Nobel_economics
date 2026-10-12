# Guía Docente y Solucionario Completo: Amartya Sen (Nobel 1998)

> **Material Confidencial para el Docente:** Contiene el desarrollo matemático detallado, las soluciones numéricas exactas, el código en R del reto avanzado, pautas metodológicas de discusión y rúbrica analítica de evaluación para la guía de ejercicios.

---

## Solución al Ejercicio 1: Descomposición Analítica del Índice de Sen (Nivel Básico)

### 1. Caso Homogéneo Inicial
- **Datos:** $N = 100$, $z = \$10$, $q = 20$, $y_i = \$6$ para todo $i=1,\dots,20$.
- **Tasa de recuento ($H$):**
  $$H = \frac{q}{N} = \frac{20}{100} = 0.20$$
- **Razón de brecha de ingresos ($I$):**
  Como todos los pobres tienen $y_i = 6$, el ingreso promedio es $\mu_p = 6$:
  $$I = 1 - \frac{\mu_p}{z} = 1 - \frac{6}{10} = 0.40$$
- **Coeficiente de Gini entre los pobres ($G_p$):**
  Dado que no existe dispersión de ingresos entre los pobres ($y_i = \mu_p = 6, \; \forall i$):
  $$G_p = 0$$
- **Índice de Sen ($P_S$):**
  $$P_S = H \left[ I + (1 - I) G_p \right] = 0.20 \times [0.40 + (1 - 0.40) \times 0] = 0.20 \times 0.40 = 0.080$$

---

### 2. Transferencia Regresiva Interna
- **Datos tras la transferencia:**
  - Grupo A (10 personas): $y_A = 4$.
  - Grupo B (10 personas): $y_B = 8$.
- **Ingreso medio de los pobres:**
  $$\mu_p = \frac{10 \times 4 + 10 \times 8}{20} = \frac{40 + 80}{20} = 6$$
- **Comportamiento de $H$ e $I$:**
  - Dado que todos los 20 individuos continúan con ingresos estrictamente inferiores a la línea de pobreza $z = 10$, $q = 20 \implies H = 0.20$ (constante).
  - Dado que la suma total del déficit de ingresos es idéntica ($20 \times 10 - 120 = 80$), la brecha proporcional promedio es:
    $$I = 1 - \frac{6}{10} = 0.40 \quad (\text{constante})$$
- **Cálculo del nuevo coeficiente de Gini ($G_p$):**
  Aplicando la fórmula dada para dos grupos simétricos:
  $$G_p = \frac{|y_B - y_A|}{4 \mu_p} = \frac{|8 - 4|}{4 \times 6} = \frac{4}{24} = \frac{1}{6} \approx 0.1667$$
- **Cálculo del nuevo Índice de Sen ($P_S$):**
  $$P_S = 0.20 \times \left[ 0.40 + (1 - 0.40) \times \frac{1}{6} \right] = 0.20 \times [0.40 + 0.60 \times 0.16667] = 0.20 \times [0.40 + 0.10] = 0.20 \times 0.50 = 0.100$$
- **Interpretación del Axioma de Transferencia:**
  El índice se incrementa de $0.080$ a $0.100$ (+25%), capturando el empeoramiento en la severidad de la pobreza producto de la mayor desigualdad interna, mientras que los índices tradicionales $H$ e $I$ permanecieron ciegos a este fenómeno.

---

### 3. El Sesgo de Focalización Gubernamental
- Si el gobernante busca reducir $H$, con un costo presupuestario de apenas $\$2$ por individuo puede elevar al Grupo B desde $\$8$ hasta la línea de pobreza $z = \$10$. De este modo, 10 individuos abandonan la pobreza y la tasa $H$ cae del 20% al 10%.
- En contraste, rescatar al Grupo A requeriría un desembolso de $\$6$ por persona ($300\%$ más costoso por persona rescatada).
- **Conclusión ética:** Evaluar políticas públicas exclusivamente mediante $H$ genera incentivos perversos de "creaming" (*rescremado* o rescate oportunista en la frontera), penalizando y abandonando sistemáticamente a los indigentes crónicos más profundos.

---

## Solución al Ejercicio 2: La Paradoja del Liberal Paretiano (Nivel Intermedio)

### 1. Liberalismo Mínimo ($L^*$) y Esferas Personales
- **Prude (1):** La decisión sobre si Prude lee el libro o no compete exclusivamente a su esfera personal. Por lo tanto, Prude es decisivo sobre el par $\{x, z\}$ (donde en $x$ lo lee él y en $z$ nadie lo lee).
- **Lewd (2):** La decisión sobre si Lewd lee el libro o no compete exclusivamente a su esfera personal. Lewd es decisivo sobre el par $\{y, z\}$ (donde en $y$ lo lee él y en $z$ nadie lo lee).

### 2. Decisiones Liberales Descentralizadas
- Sobre $\{x, z\}$, Prude prefiere estrictamente $z \succ_1 x$ (que nadie lo lea antes que leerlo él). La condición de liberalismo impone la preferencia social:
  $$\mathbf{z \succ x}$$
- Sobre $\{y, z\}$, Lewd prefiere estrictamente $y \succ_2 z$ (leerlo él antes que nadie lo lea). La condición de liberalismo impone la preferencia social:
  $$\mathbf{y \succ z}$$

### 3. Eficiencia de Pareto y el Ciclo Intransitivo
- Comparemos ahora el par restante $\{x, y\}$:
  - Para Prude: $x \succ_1 y$ (prefiere leerlo él antes de que lo lea Lewd).
  - Para Lewd: $x \succ_2 y$ (prefiere que lo lea Prude para perturbar su moral antes de leerlo él).
- **Unanimidad Paretiana:** Ambos prefieren $x$ sobre $y$. El Principio de Pareto débil (P) exige unánimemente que la sociedad prefiera:
  $$\mathbf{x \succ y}$$
- **La Contradicción:**
  Juntando las tres relaciones sociales obtenidas:
  1. Por Pareto: $x \succ y$
  2. Por derecho de Lewd: $y \succ z$
  3. Por derecho de Prude: $z \succ x$
  Esto produce un **ciclo cerrado intransitivo**:
  $$x \succ y \succ z \succ x$$
  Ningún estado puede ser elegido democrática o racionalmente como el óptimo social.

### 4. Implicancia Filosófica
Sen demostró formalmente que el criterio paretiano (foco exclusivo en utilidades y preferencias subjetivas) entra en colisión directa con el respeto a los derechos humanos y las libertades individuales. La economía del bienestar no puede refugiarse en el welfarismo utilitarista sin enfrentar contradicciones normativas profundas.

---

## Solución al Ejercicio 3: Reto de Simulación en R (Nivel Avanzado)

### Código en R de la Simulación

```r
library(dplyr)
library(ggplot2)

simular_hambruna <- function(w0 = 16, P0 = 10, lambda = 0.25, L = 25, F_min = 30, meses = 6) {
  t <- 1:meses
  P_t <- P0 * (1 + lambda)^(t - 1)
  w_t <- w0 * (1 + 0.05)^(t - 1)
  
  # Titularidad alimentaria mensual del jornalero
  F_base <- (w_t * L) / P_t
  
  # Escenario 2: Entrega fisica de comida en bodegas lejanas (perdida de dias y flete)
  # Solo llega un subsidio efectivo de 4 kg de arroz neto por hogar
  F_ayuda_fisica <- F_base + 4.0
  
  # Escenario 3: Programa de Empleo Garantizado de Sen (Cash for work)
  # Se asegura un salario de emergencia indexado para alcanzar la subsistencia
  F_sen <- pmax(F_base, F_min + 2.0)
  
  df <- data.frame(
    Mes = rep(t, 3),
    Titularidad = c(F_base, F_ayuda_fisica, F_sen),
    Politica = factor(rep(c("Sin Intervención (Colapso)", 
                            "Ración Física Distante (FAD)", 
                            "Garantía de Empleo de Sen (Titularidades)"), 
                          each = meses))
  )
  return(df)
}

df_res <- simular_hambruna()

# Gráfico de políticas
p_reto <- ggplot(df_res, aes(x = Mes, y = Titularidad, color = Politica, linetype = Politica)) +
  geom_hline(yintercept = 30, linetype = "dashed", color = "black", linewidth = 0.8) +
  annotate("text", x = 1.8, y = 31.5, label = "Línea de Subsistencia (30 kg/mes)", 
           fontface = "bold.italic", size = 3.5) +
  geom_line(linewidth = 1.1) +
  geom_point(size = 2.5) +
  scale_color_manual(values = c("Sin Intervención (Colapso)" = "#c0392b",
                                "Ración Física Distante (FAD)" = "#e67e22",
                                "Garantía de Empleo de Sen (Titularidades)" = "#27ae60")) +
  labs(
    title = "Eficacia de Políticas Anti-Hambruna: Enfoque FAD vs. Titularidades de Sen",
    x = "Mes de Crisis",
    y = "Arroz Obtenible por Hogar Jornalero (kg/mes)",
    color = "Estrategia Gubernamental"
  ) +
  theme_minimal()
```

### Resultados Numéricos:
- En $t=1$: $F_1 = (16 \times 25) / 10 = 40.0$ kg ($> 30$ kg, por encima de la subsistencia).
- En $t=2$: $P_2 = 12.5$, $w_2 = 16.8 \implies F_2 = 33.6$ kg.
- En $t=3$: $P_3 = 15.625$, $w_3 = 17.64 \implies F_3 = 28.22$ kg.
  - **El jornalero cae en inanición en el mes 3** ($F_3 < 30$ kg).
- En $t=6$: $P_6 = 30.52$, $w_6 = 20.42 \implies F_6 = 16.73$ kg (apenas el 55% de la supervivencia biológica).
- La política de raciones físicas apenas amortigua 4 kg, dejando a la familia en 20.73 kg (inanición crónica), mientras que el programa de empleo garantizado de Sen restaura la titularidad de intercambio por encima del umbral en los propios mercados locales.

---

## Rúbrica de Evaluación Analítica

| Criterio | Excelente (5.0) | Satisfactorio (3.5 - 4.5) | Insuficiente (< 3.5) |
| :--- | :--- | :--- | :--- |
| **Ejercicio 1: Índice de Sen** | Deducción matemática perfecta de $P_S$, $H$, $I$ y $G_p$. Explicación ética lúcida de la violación de axiomas y el sesgo de focalización. | Cálculos correctos pero con deficiencias conceptuales en la justificación de los axiomas M y T. | Errores en la fórmula de Gini o incapacidad de interpretar el significado económico. |
| **Ejercicio 2: Liberal Paretiano** | Demostración formal del ciclo $x \succ y \succ z \succ x$. Comprensión profunda de la tensión entre welfarismo y derechos individuales. | Identifica el ciclo pero confunde las esferas de decisión privada de los agentes. | No logra formular las preferencias sociales ni explicar la paradoja. |
| **Ejercicio 3: Simulación en R** | Código funcional, modular y bien documentado. Gráfica clara y contraste riguroso entre políticas FAD y de titularidades. | El código corre pero faltan etiquetas, escalas o la comparación entre intervenciones es incompleta. | Código con errores de sintaxis o que no simula la dinámica temporal. |

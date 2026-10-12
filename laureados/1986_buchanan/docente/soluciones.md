# Guía para el Docente: Soluciones y Pautas Pedagógicas

## Nobel de Economía 1986: James M. Buchanan Jr.

> **Documento reservado para el equipo docente.** Contiene el desarrollo matemático completo de los ejercicios, soluciones analíticas detalladas, código R ejecutable para el reto de simulación de sesgo al déficit y la rúbrica pedagógica analítica de evaluación.

---

## 1. Pautas Pedagógicas y Objetivos de Aprendizaje

Al enseñar la Teoría de la Elección Pública (*Public Choice*) y la Economía Constitucional de James M. Buchanan, los docentes suelen enfrentarse a prejuicios ideológicos o confusiones conceptuales arraigadas en la ciencia política tradicional y la economía pública convencional:

1. **"Política sin romanticismo" (*Politics without Romance*):** La premisa central de Buchanan no es una postura cínica contra el Estado, sino la exigencia de **consistencia metodológica conductual**. No tiene rigor científico suponer que los seres humanos son oportunistas o egoístas en el supermercado pero se transforman en altruistas desinteresados cuando ganan una elección o aprueban una oposición burocrática. Los políticos y burócratas responden a incentivos estructurados por las reglas electorales y presupuestarias en las que operan.
2. **La Regla de Mayoría Simple no es Sagrada:** Los estudiantes tienden a identificar la "democracia" exclusivamente con la regla del 50% + 1. Es crucial enfatizar el hallazgo de Buchanan y Tullock (1962): la regla del 50% + 1 es meramente una convención instrumental. Si una mayoría simple puede imponer impuestos y redistribuir recursos a su favor a expensas de la minoría (49.9%), el costo externo de expoliación es severo.
3. **La Distinción Constitucional en Dos Etapas:** Debe explicarse con claridad la diferencia entre:
   - **Nivel Constitucional (Reglas del Juego):** Los ciudadanos eligen las reglas básicas (derechos individuales, límites fiscales, mayorías requeridas) bajo un "velo de incertidumbre" respecto a qué posición ocuparán en el futuro. En este nivel se requiere cuasi-unanimidad (consenso amplio).
   - **Nivel Post-Constitucional o Legislativo Ordinario (Juego dentro de las Reglas):** La provisión corriente de bienes públicos se delega a reglas de decisión más expeditas (mayoría calificada o simple) para evitar la parálisis decisoria.
4. **Búsqueda de Rentas vs. Creación de Valor:** Aclarar la distinción entre el beneficio empresarial schumpeteriano (generado por innovación que expande el excedente del consumidor) y la renta política de Tullock (generada por privilegios o barreras creadas por el gobierno, que destruyen riqueza social en cabildeo improductivo).

---

## 2. Soluciones Detalladas de los Ejercicios

### Ejercicio 1: El Cálculo del Consenso y la Regla Óptima de Mayoría (Nivel Básico)

#### Pregunta 1: Interpretación Económica de los Extremos
- **Costos Externos $C(k) = 144(1 - k)^2$:**
  - Cuando $k \to 0$ (autocracia / tiranía unipersonal): $C(0) = 144(1 - 0)^2 = 144$. Un único individuo o una facción mínima puede aprobar cualquier impuesto o regulación confiscatoria sobre el resto de la sociedad. El riesgo de expoliación es máximo.
  - Cuando $k = 1$ (unanimidad wickselliana): $C(1) = 144(1 - 1)^2 = 0$. Ninguna ley puede aprobarse si un solo individuo vota en contra. Por tanto, ninguna persona puede ser obligada a pagar un impuesto o soportar una pérdida neta sin su consentimiento voluntario. Todo acuerdo unánime es una mejora en el sentido de Pareto.
- **Costos de Toma de Decisión / Negociación $D(k) = 16 k^2$:**
  - Cuando $k \to 0$: $D(0) = 16(0)^2 = 0$. Un autócrata toma decisiones instantáneamente sin tener que deliberar ni hacer concesiones con nadie.
  - Cuando $k = 1$: $D(1) = 16(1)^2 = 16$. Lograr el consentimiento del 100% de la asamblea requiere negociaciones intensas, pagos compensatorios (*side payments*) y enfrenta el problema del chantaje estratégico (*holdout*), donde el último votante puede exigir concesiones desproporcionadas.

#### Pregunta 2: Determinación Analítica de la Regla Óptima
- La función de costo total esperado de interdependencia es:
  $$TC(k) = C(k) + D(k) = 144(1 - k)^2 + 16 k^2$$
  Desarrollando los términos algebraicos:
  $$TC(k) = 144(1 - 2k + k^2) + 16 k^2 = 144 - 288 k + 144 k^2 + 16 k^2 = 144 - 288 k + 160 k^2$$
- Condición de primer orden (FOC):
  $$\frac{d TC(k)}{dk} = -288 + 320 k = 0 \implies 320 k^* = 288 \implies k^* = \frac{288}{320} = \frac{9}{10} = 0.90$$
  Equivalentemente, igualando el beneficio marginal de protección al costo marginal de negociación:
  $$-C'(k) = 288(1 - k) = D'(k) = 32 k \implies 288 - 288 k = 32 k \implies 320 k = 288 \implies k^* = 0.90$$
- Condición de segundo orden (SOC):
  $$\frac{d^2 TC(k)}{dk^2} = 320 > 0$$
  Se confirma un mínimo global estricto.
- **Resultado:** La regla óptima exige una **mayoría calificada del 90%** de los miembros de la asamblea ($K^* = 0.90 \times 100 = 90$ ciudadanos).

#### Pregunta 3: Costos en el Óptimo vs. Mayoría Simple
- En el punto óptimo ($k^* = 0.90$):
  $$C(0.90) = 144 (1 - 0.90)^2 = 144 (0.10)^2 = 144 (0.01) = 1.44$$
  $$D(0.90) = 16 (0.90)^2 = 16 (0.81) = 12.96$$
  $$TC(0.90) = 1.44 + 12.96 = 14.40$$
- Bajo la regla convencional de mayoría simple absoluta ($k = 0.50$):
  $$C(0.50) = 144 (1 - 0.50)^2 = 144 (0.25) = 36.00$$
  $$D(0.50) = 16 (0.50)^2 = 16 (0.25) = 4.00$$
  $$TC(0.50) = 36.00 + 4.00 = 40.00$$
- **Pérdida de eficiencia social por usar mayoría simple:**
  $$\Delta TC = TC(0.50) - TC(0.90) = 40.00 - 14.40 = 25.60$$
  La mayoría simple abarata la negociación (baja de 12.96 a 4.00), pero dispara los costos externos de tiranía de la mayoría (de 1.44 a 36.00), provocando un costo neto 2.78 veces mayor ($40 / 14.40$).

#### Pregunta 4: Decisiones Constitucionales vs. Decisiones de Emergencia
- **Caso Constitucional ($C_{\text{const}}(k) = 432(1 - k)^2$):**
  $$TC_{\text{const}}(k) = 432(1 - k)^2 + 16 k^2$$
  $$\frac{d TC}{dk} = -864(1 - k) + 32 k = -864 + 864 k + 32 k = -864 + 896 k = 0$$
  $$k^*_{\text{const}} = \frac{864}{896} = \frac{27}{28} \approx 0.9643 \quad (96.4\% \text{ de aprobación})$$
  Cuando están en juego los derechos fundamentales y las normas fiscales supremas, la regla óptima converge a la **cuasi-unanimidad**.
- **Caso de Emergencia ($D_{\text{emerg}}(k) = 144 k^2$):**
  $$TC_{\text{emerg}}(k) = 144(1 - k)^2 + 144 k^2$$
  $$\frac{d TC}{dk} = -288(1 - k) + 288 k = -288 + 576 k = 0 \implies k^*_{\text{emerg}} = \frac{288}{576} = 0.50 \quad (50\%)$$
  En situaciones de guerra o crisis extrema, donde los retrasos deliberativos son letales, el umbral óptimo cae a la mayoría simple o a decretos ejecutivos delegados con control parlamentario a posteriori.

---

### Ejercicio 2: El Concurso de Tullock y la Disipación del Excedente Social (Nivel Intermedio)

#### Pregunta 1: Equilibrio de Nash Simétrico
- Cada empresa $i$ maximiza:
  $$\pi_i(x_i, x_{-i}) = \left( \frac{x_i}{x_i + \sum_{j \neq i} x_j} \right) R - x_i$$
- Condición de primer orden:
  $$\frac{\partial \pi_i}{\partial x_i} = \frac{1 \cdot (x_i + \sum_{j \neq i} x_j) - x_i \cdot 1}{\left( x_i + \sum_{j \neq i} x_j \right)^2} R - 1 = 0$$
  $$\frac{\sum_{j \neq i} x_j}{\left( \sum_{k=1}^n x_k \right)^2} R = 1$$
- Imponiendo simetría en equilibrio ($x_1 = x_2 = \dots = x_n = x^*$):
  $$\sum_{j \neq i} x_j = (n - 1) x^*, \quad \sum_{k=1}^n x_k = n x^*$$
  $$\frac{(n - 1) x^*}{(n x^*)^2} R = 1 \implies \frac{n - 1}{n^2 x^*} R = 1 \implies x^*(n) = R \cdot \frac{n - 1}{n^2}$$

#### Pregunta 2: Gasto Agregado y Tasa de Disipación
- Gasto agregado total en cabildeo:
  $$X(n) = \sum_{i=1}^n x_i^* = n \cdot \left( R \frac{n - 1}{n^2} \right) = R \frac{n - 1}{n}$$
- Tasa de disipación de la renta:
  $$DR(n) = \frac{X(n)}{R} = \frac{n - 1}{n}$$
- Evaluación numérica para $R = \$1,000,000$:
  - **$n = 2$:**
    $$x^* = 1,000,000 \cdot \frac{1}{4} = \$250,000$$
    $$X = 2 \times 250,000 = \$500,000, \quad DR = \frac{1}{2} = 50\%$$
  - **$n = 5$:**
    $$x^* = 1,000,000 \cdot \frac{4}{25} = \$160,000$$
    $$X = 5 \times 160,000 = \$800,000, \quad DR = \frac{4}{5} = 80\%$$
  - **$n = 20$:**
    $$x^* = 1,000,000 \cdot \frac{19}{400} = \$47,500$$
    $$X = 20 \times 47,500 = \$950,000, \quad DR = \frac{19}{20} = 95\%$$
  - **$\lim_{n \to \infty}$:**
    $$x^* \to 0, \quad X \to \$1,000,000, \quad DR \to 100\%$$
    Toda la renta artificial se destruye íntegramente en actividades improductivas de cabildeo.

#### Pregunta 3: Beneficio Neto Esperado
- El beneficio neto esperado en equilibrio para cada empresa es:
  $$\pi_i^* = p_i^* R - x^* = \frac{1}{n} R - \frac{n - 1}{n^2} R = R \left( \frac{n - (n - 1)}{n^2} \right) = \frac{R}{n^2}$$
- Para $n = 2$: $\pi_i = 1,000,000 / 4 = \$250,000$.
- Para $n = 5$: $\pi_i = 1,000,000 / 25 = \$40,000$.
- Para $n = 20$: $\pi_i = 1,000,000 / 400 = \$2,500$.
- Cuando $n \to \infty$, $\pi_i^* \to 0$.
- **Conclusión económica:** Las empresas participantes terminan con beneficios netos prácticamente nulos; la renta no enriquece a los productores, sino que se esfuma en honorarios de intermediarios, abogados, agencias de publicidad y asesores políticos.

#### Pregunta 4: Costo Social Total (Harberger vs. Tullock)
- Estimación Neoclásica Tradicional (Harberger):
  $$\text{Pérdida Social} = DWL = \$200,000$$
  El rectángulo de renta $R = \$1,000,000$ se consideraba erróneamente una transferencia inocua entre ciudadanos.
- Estimación de Buchanan y Tullock ($n = 20$):
  $$\text{Pérdida Social Verdadera} = DWL + X = \$200,000 + \$950,000 = \$1,150,000$$
- **Multiplicador del daño social:**
  $$\frac{\$1,150,000}{\$200,000} = 5.75 \text{ veces}$$
  El análisis tradicional subestimó el perjuicio económico en casi un 600%.

---

### Ejercicio 3: Reto en R — Ilusión Fiscal, Sesgo al Déficit y Regla Constitucional de Presupuesto Equilibrado (Nivel Avanzado)

#### Código Completo y Reproducible en R:

```r
# ==============================================================================
# Solucion Docente: Reto de Ilusion Fiscal y Regla Constitucional de Buchanan
# ==============================================================================

library(ggplot2)
library(dplyr)
library(tidyr)
library(scales)

set.seed(1986)
periodos <- 10
r_interes <- 0.05

# 1. Simulacion de trayectorias bajo ambos regimenes
simular_trayectoria_fiscal <- function(n_per = 10, r = 0.05) {
  # Regimen A: Discrecionalidad pura (G = 120, T = 100, Deficit = 20)
  deuda_A <- numeric(n_per)
  intereses_A <- numeric(n_per)
  
  deuda_acum <- 0
  for (t in 1:n_per) {
    pago_intereses <- deuda_acum * r
    intereses_A[t] <- pago_intereses
    deuda_acum <- deuda_acum * (1 + r) + 20
    deuda_A[t] <- deuda_acum
  }
  
  # Regimen B: Regla Constitucional Buchanan (Presupuesto Equilibrado: G = 100, T = 100)
  deuda_B <- rep(0, n_per)
  intereses_B <- rep(0, n_per)
  
  tibble(
    Periodo = 1:n_per,
    Deuda_Discrecional = deuda_A,
    Intereses_Discrecional = intereses_A,
    Deuda_Regla_Constitucional = deuda_B,
    Intereses_Regla_Constitucional = intereses_B
  )
}

df_fiscal <- simular_trayectoria_fiscal(n_per = periodos, r = r_interes)

# 2. Resumen numerico acumulado
deuda_final_A <- tail(df_fiscal$Deuda_Discrecional, 1)
intereses_totales_A <- sum(df_fiscal$Intereses_Discrecional)

cat(sprintf("Deuda acumulada al periodo 10 (Discrecional): $%.2f\n", deuda_final_A))
cat(sprintf("Carga acumulada de intereses transferida a futuras generaciones: $%.2f\n", intereses_totales_A))

# 3. Grafico comparativo de trayectorias
df_plot <- df_fiscal %>%
  select(Periodo, Deuda_Discrecional, Deuda_Regla_Constitucional) %>%
  pivot_longer(cols = starts_with("Deuda"), names_to = "Regimen", values_to = "Deuda") %>%
  mutate(
    Regimen = ifelse(grepl("Discrecional", Regimen), 
                     "Regimen Discrecional (Sesgo al Deficit)", 
                     "Regla Constitucional Buchanan (Equilibrio)")
  )

p_reto <- ggplot(df_plot, aes(x = Periodo, y = Deuda, color = Regimen, linetype = Regimen)) +
  geom_line(linewidth = 1.3) +
  geom_point(size = 3) +
  scale_color_manual(values = c("Regimen Discrecional (Sesgo al Deficit)" = "#C62828", 
                                "Regla Constitucional Buchanan (Equilibrio)" = "#2E7D32")) +
  scale_x_continuous(breaks = 1:10) +
  scale_y_continuous(labels = dollar_format()) +
  labs(
    title = "Efecto Estabilizador de una Regla Fiscal Constitucional (Buchanan)",
    subtitle = paste0("Acumulacion de deuda soberana e intereses con r = ", percent(r_interes), " vs. equilibrio obligatorio"),
    x = "Periodo Legislativo (Generaciones)",
    y = "Saldo de Deuda Publica Acumulada ($)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", color = "#1A237E")
  )

print(p_reto)
```

#### Discusión y Reflexión Pedagógica:
- Al cabo de 10 legislaturas, el régimen discrecional acumula **$251.56** en deuda (pese a que el déficit primario nominal fue de solo $200), habiendo pagado **$51.56** en intereses improductivos.
- **¿Por qué la regla debe ser constitucional y no una ley ordinaria?** Si la regla fiscal es una ley ordinaria, cualquier mayoría parlamentaria coyuntural de 50% + 1 tiene incentivos electorales para derogarla antes de las elecciones. La rigidez constitucional (requerir dos tercios o tres cuartos para endeudarse) es el único mecanismo creíble que ata las manos de los gobernantes (metáfora de Ulises y las sirenas).

---

## 3. Rúbrica Pedagógica de Evaluación

| Criterio | Excelente (90–100%) | Bueno (75–89%) | En Desarrollo (<75%) |
| :--- | :--- | :--- | :--- |
| **Modelización de Votación (Buchanan-Tullock)** | Deriva con precisión analítica $k^*=0.90$, comprueba FOC/SOC, calcula la pérdida de bienestar de la mayoría simple y fundamenta la diferencia entre materias constitucionales y de crisis. | Obtiene $k^*$ pero comete errores aritméticos menores en la evaluación de costos totales o no interpreta cabalmente el significado de $C(1)=0$. | Confunde costos externos con costos de transacción o no plantea la condición marginal de equilibrio. |
| **Búsqueda de Rentas de Tullock** | Demuestra el equilibrio de Nash simétrico en el concurso de Tullock, deriva la tasa de disipación, evalúa el límite $n \to \infty$ y computa el multiplicador de daño frente a Harberger. | Conoce la fórmula de equilibrio pero titubea en la derivación formal o no compara la pérdida frente al triángulo de Harberger. | Trata la búsqueda de rentas como una transferencia inocua o no deduce el gasto individual. |
| **Economía Constitucional y Simulación en R** | Programa el script en R de forma modular, simula con exactitud la dinámica de la deuda y argumenta con solidez teórica el compromiso temporal y la ilusión fiscal. | El código en R corre con advertencias o la justificación de las reglas constitucionales frente a leyes ordinarias es superficial. | El código no compila o carece de comprensión del sesgo estructural al déficit. |

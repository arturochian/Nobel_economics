# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2004: Finn E. Kydland y Edward C. Prescott

> **Nota pedagógica confidencial para el profesor:** Este documento contiene las derivaciones algebraicas rigurosas, cálculos numéricos paso a paso, demostraciones matriciales y criterios de corrección para los ejercicios presentados en `estudiante/ejercicios.qmd`. Prohibida su divulgación previa a la entrega formal.

---

### Solución Ejercicio 1 (Inconsistencia Temporal y Álgebra del Sesgo Inflacionario)

#### 1. Optimización bajo Discrecionalidad:
- La función de pérdida del banco central es:
  $$L(\pi, y) = \frac{1}{2} \pi^2 + \frac{\gamma}{2} (y - k y_n)^2$$
- Con la curva de oferta $y = y_n + \alpha (\pi - \pi^e) + \varepsilon$:
  $$L = \frac{1}{2} \pi^2 + \frac{\gamma}{2} \left[ y_n + \alpha (\pi - \pi^e) + \varepsilon - k y_n \right]^2 = \frac{1}{2} \pi^2 + \frac{\gamma}{2} \left[ (1 - k) y_n + \alpha (\pi - \pi^e) + \varepsilon \right]^2$$
- El banco central actúa en un entorno discrecional eligiendo $\pi$ después de observar $\pi^e$ y el choque $\varepsilon$. La Condición de Primer Orden (CPO) es:
  $$\frac{\partial L}{\partial \pi} = \pi + \alpha \gamma \left[ (1 - k) y_n + \alpha (\pi - \pi^e) + \varepsilon \right] = 0$$
- Reordenando términos:
  $$\pi (1 + \alpha^2 \gamma) = \alpha \gamma (k - 1) y_n + \alpha^2 \gamma \pi^e - \alpha \gamma \varepsilon$$
  $$\pi = \frac{\alpha \gamma (k - 1) y_n + \alpha^2 \gamma \pi^e - \alpha \gamma \varepsilon}{1 + \alpha^2 \gamma}$$

#### 2. Equilibrio con Expectativas Racionales:
- Los agentes privados son racionales y conocen el modelo: $\pi^e = E[\pi]$. Dado que $E[\varepsilon] = 0$:
  $$\pi^e = \frac{\alpha \gamma (k - 1) y_n + \alpha^2 \gamma \pi^e}{1 + \alpha^2 \gamma}$$
  $$\pi^e (1 + \alpha^2 \gamma) = \alpha \gamma (k - 1) y_n + \alpha^2 \gamma \pi^e$$
  $$\pi^e + \alpha^2 \gamma \pi^e = \alpha \gamma (k - 1) y_n + \alpha^2 \gamma \pi^e \implies \pi^e = \alpha \gamma (k - 1) y_n$$
- Sustituyendo $\pi^e$ en la regla de política discrecional:
  $$\pi^D = \alpha \gamma (k - 1) y_n - \frac{\alpha \gamma}{1 + \alpha^2 \gamma} \varepsilon$$
- **Sesgo Inflacionario:** $E[\pi^D] = \alpha \gamma (k - 1) y_n > 0$ (puesto que $k > 1, \alpha > 0, \gamma > 0$).
- **Producto Esperado:**
  $$E[y^D] = y_n + \alpha (E[\pi^D] - \pi^e) + E[\varepsilon] = y_n + \alpha (0) + 0 = y_n$$
- *Conclusión fundamental:* La autoridad fracasa por completo en aumentar el producto medio por encima de su tasa natural. El único resultado de la discrecionalidad es generar un costo social inútil en forma de mayor inflación sistemática.

#### 3. Calibración Numérica y Comparación de Bienestar:
- Parámetros: $y_n = 100, k = 1.04, \alpha = 1.2, \gamma = 0.8, \sigma_\varepsilon = 2.0$.
- **Cálculo del sesgo inflacionario:**
  $$\pi^D = \alpha \gamma (k - 1) y_n = 1.2 \times 0.8 \times (1.04 - 1.00) \times 100 = 0.96 \times 4.0 = 3.84\%$$
- **Pérdida social bajo Regla con Compromiso ($\pi = 0, \pi^e = 0$):**
  $$E[L^C] = \frac{1}{2} (0)^2 + \frac{\gamma}{2} (y_n - k y_n)^2 + \frac{\gamma}{2} \sigma_\varepsilon^2$$
  $$E[L^C] = \frac{0.8}{2} [(1 - 1.04) 100]^2 + \frac{0.8}{2} (2.0)^2 = 0.4 \times (-4)^2 + 0.4 \times 4 = 0.4 \times 16 + 1.6 = 6.40 + 1.60 = 8.00$$
- **Pérdida social bajo Discrecionalidad Pura:**
  $$E[L^D] = \frac{1}{2} (\pi^{bias})^2 + E[L^C] + \text{términos del choque}$$
  El componente de inflación sistemática añade a la pérdida:
  $$\frac{1}{2} (3.84)^2 = \frac{1}{2} (14.7456) = 7.3728$$
  El término de estabilización del choque bajo discreción es:
  $$\frac{1}{2} Var(\pi) + \frac{\gamma}{2} Var(y) = \frac{1}{2} \left( \frac{\alpha \gamma}{1 + \alpha^2 \gamma} \right)^2 \sigma_\varepsilon^2 + \frac{\gamma}{2} \left( \frac{1}{1 + \alpha^2 \gamma} \right)^2 \sigma_\varepsilon^2$$
  Con $1 + \alpha^2 \gamma = 1 + (1.44 \times 0.8) = 1 + 1.152 = 2.152$:
  $$\frac{\alpha \gamma}{1 + \alpha^2 \gamma} = \frac{0.96}{2.152} \approx 0.4461, \quad \frac{1}{1 + \alpha^2 \gamma} = \frac{1}{2.152} \approx 0.4647$$
  Término de choque: $0.5 \times (0.4461)^2 \times 4 + 0.4 \times (0.4647)^2 \times 4 = 0.3980 + 0.3455 = 0.7435$.
  $$E[L^D] = 7.3728 + 6.40 + 0.7435 \approx 14.52$$
- *Comparación:* La pérdida social se eleva de $8.00$ a $14.52$ (un incremento del $81.5\%$), atribuible predominantemente al sesgo inflacionario evitable.

#### 4. La Tentación de Defraudar (Cheating):
- Si el público confía en el anuncio de inflación cero ($\pi^e = 0$) y en ausencia momentánea de choques ($\varepsilon = 0$):
  $$\pi^{cheat} = \frac{\alpha \gamma (k - 1) y_n}{1 + \alpha^2 \gamma} = \frac{3.84}{2.152} \approx 1.7844\%$$
- El producto generado en este periodo de sorpresa es:
  $$y^{cheat} = 100 + 1.2 \times (1.7844 - 0) = 100 + 2.1413 = 102.1413$$
- La brecha frente a la meta social es:
  $$y^{cheat} - k y_n = 102.1413 - 104 = -1.8587 \quad (\text{mucho menor que la brecha bajo compromiso } -4.0)$$
- Pérdida social en el periodo del engaño:
  $$L^{cheat} = \frac{1}{2} (1.7844)^2 + \frac{0.8}{2} (-1.8587)^2 = 0.5 \times 3.1841 + 0.4 \times 3.4548 = 1.5920 + 1.3819 = 2.9739$$
- *Interpretación teórica:* $L^{cheat} = 2.97 < L^C = 6.40 < L^D = 13.77$. El gobierno disfruta de un alivio transitorio inmediato al defraudar la confianza pública. Como los ciudadanos reconocen esta tentación matemática, la promesa simple ("prometo que la inflación será cero") carece de credibilidad a menos que existan salvaguardas legales, reputacionales o institucionales vinculantes.

---

### Solución Ejercicio 2 (Banquero Central Conservador de Rogoff)

#### 1. Reacción del Banquero Central Conservador:
- El banquero optimiza su propia función de pérdida con parámetro $\gamma_b < \gamma_s$.
- Replicando las CPO con $\gamma_b$:
  $$\pi(\varepsilon) = \alpha \gamma_b (k - 1) y_n - \frac{\alpha \gamma_b}{1 + \alpha^2 \gamma_b} \varepsilon$$
  $$y(\varepsilon) = y_n + \frac{1}{1 + \alpha^2 \gamma_b} \varepsilon$$

#### 2. Pérdida Social Esperada Evaluada por la Sociedad:
- La sociedad evalúa el resultado con su verdadero peso $\gamma_s$:
  $$E[L_s] = \frac{1}{2} E[\pi^2] + \frac{\gamma_s}{2} E[(y - k y_n)^2]$$
  $$E[\pi^2] = [\alpha \gamma_b (k - 1) y_n]^2 + \left( \frac{\alpha \gamma_b}{1 + \alpha^2 \gamma_b} \right)^2 \sigma_\varepsilon^2$$
  $$E[(y - k y_n)^2] = (1 - k)^2 y_n^2 + \left( \frac{1}{1 + \alpha^2 \gamma_b} \right)^2 \sigma_\varepsilon^2$$
- Agrupando en dos términos:
  $$E[L_s] = \underbrace{\frac{1}{2} [\alpha \gamma_b (k - 1) y_n]^2 + \frac{\gamma_s}{2} (1 - k)^2 y_n^2}_{\text{Costo medio del sesgo inflacionario}} + \underbrace{\frac{1}{2} \left[ \left( \frac{\alpha \gamma_b}{1 + \alpha^2 \gamma_b} \right)^2 + \gamma_s \left( \frac{1}{1 + \alpha^2 \gamma_b} \right)^2 \right] \sigma_\varepsilon^2}_{\text{Costo de estabilización de choques}}$$

#### 3. El Dilema entre Credibilidad y Flexibilidad:
- **Límite $\gamma_b \to 0$ (Halcón monetario puro):**
  - El sesgo inflacionario colapsa a cero: $\alpha (0) (k - 1) y_n = 0$.
  - Sin embargo, la estabilización de choques desaparece: el banco no responde a perturbaciones ($\pi = 0$), y la varianza del producto transmitida al sector privado es máxima ($\sigma_y^2 = \sigma_\varepsilon^2$), lo cual eleva la pérdida por estabilización a $\frac{\gamma_s}{2} \sigma_\varepsilon^2$.
- **Límite $\gamma_b = \gamma_s$ (Sin delegación conservadora):**
  - La respuesta a choques es óptima desde la óptica social, pero la economía sufre el sesgo inflacionario en su máxima expresión.
- **Ponderación óptima $\gamma_b^* \in (0, \gamma_s)$:**
  - Derivando $E[L_s]$ con respecto a $\gamma_b$, la condición de mínimo balancea la reducción marginal del sesgo inflacionario con el incremento marginal de la variabilidad del producto ante choques reales.
  - Rogoff demostró que siempre es óptimo nombrar a un banquero central estrictamente más conservador que la sociedad ($\gamma_b^* < \gamma_s$), pero no infinitamente conservador ($\gamma_b^* > 0$), fundamentando teóricamente la autonomía de los bancos centrales contemporáneos con esquemas de metas explícitas de inflación.

---

### Solución Ejercicio 3 (Filtro HP y Hechos Estilizados RBC)

#### 1. Derivación Matricial del Filtro Hodrick-Prescott:
- Sea el problema:
  $$\min_{\{\tau_t\}_{t=1}^T} \sum_{t=1}^T (y_t - \tau_t)^2 + \lambda \sum_{t=2}^{T-1} [(\tau_{t+1} - \tau_t) - (\tau_t - \tau_{t-1})]^2$$
- El término de ajuste cíclico se escribe matricialmente como:
  $$(y - \tau)' (y - \tau)$$
- La segunda diferencia para cualquier $t \in [2, T-1]$ es:
  $$\Delta^2 \tau_{t+1} = \tau_{t+1} - 2\tau_t + \tau_{t-1}$$
  Definimos la matriz $D$ de dimensión $(T-2) \times T$:
  $$D = \begin{pmatrix}
  1 & -2 & 1 & 0 & 0 & \dots & 0 \\
  0 & 1 & -2 & 1 & 0 & \dots & 0 \\
  \vdots & & \ddots & \ddots & \ddots & & \vdots \\
  0 & \dots & 0 & 1 & -2 & 1 & 0 \\
  0 & \dots & 0 & 0 & 1 & -2 & 1
  \end{pmatrix}$$
- Entonces la suma de cuadrados de las segundas diferencias es exactamente:
  $$\sum_{t=2}^{T-1} (\Delta^2 \tau_{t+1})^2 = (D \tau)' (D \tau) = \tau' D' D \tau$$
- La función objetivo matricial queda:
  $$S(\tau) = (y - \tau)' (y - \tau) + \lambda \tau' D' D \tau$$
- Derivando respecto al vector $\tau$ e igualando a cero:
  $$\frac{\partial S}{\partial \tau} = -2 (y - \tau) + 2 \lambda D' D \tau = 0$$
  $$-(y - \tau) + \lambda D' D \tau = 0 \implies y - \tau = \lambda D' D \tau$$
  $$(I_T + \lambda D' D) \tau = y$$
- Como la matriz $K = D' D$ es simétrica y semidefinida positiva, $(I_T + \lambda K)$ es simétrica y estrictamente definida positiva, por lo que es invertible:
  $$\tau = \left( I_T + \lambda D' D \right)^{-1} y$$

#### 2. Análisis de Sensibilidad del Parámetro $\lambda$:
- **Caso $\lambda \to 0$:**
  - La penalización a la curvatura desaparece por completo: $\tau = (I_T + 0)^{-1} y = y$.
  - La tendencia estimada se vuelve idéntica a la serie observada y el componente cíclico colapsa a cero ($c_t = 0$).
- **Caso $\lambda \to \infty$:**
  - La curvatura está infinitamente penalizada: la segunda diferencia debe ser estrictamente cero en todo punto ($\Delta^2 \tau_t = 0 \implies \tau_t = a + b t$).
  - La tendencia se convierte exactamente en una recta de regresión lineal determinística estimada por Mínimos Cuadrados Ordinarios.
- **Calibración canónica $\lambda = 1600$ (Datos trimestrales):**
  - Hodrick y Prescott (1997) dedujeron este valor asumiendo una razón de varianzas de choques cíclicos y de tendencia $\sigma_c^2 / \sigma_{\Delta^2 \tau}^2 \approx 1600$.
  - En el dominio de las frecuencias, $\lambda = 1600$ actúa como un filtro pasa-altos que retiene ciclos con periodicidad inferior a 32 trimestres (8 años), eliminando las oscilaciones de baja frecuencia asociadas al crecimiento de largo plazo.

#### 3. Hechos Estilizados y Microfundamentos RBC:
- **a) Hipervolatilidad de la Inversión ($\sigma_I / \sigma_Y \approx 3.0 - 4.5$):**
  - Dado que el stock de capital $K_t$ es grande relativo al flujo de inversión anual ($K \approx 10 Y$ en trimestral), un choque positivo de productividad eleva la productividad marginal futura del capital. Para aumentar marginalmente el stock de capital en un $1\%$, el flujo de inversión bruta debe dispararse en magnitudes porcentuales sustancialmente mayores. Además, los proyectos de inversión con períodos prolongados de gestación (*time-to-build*) concentran fuertes decisiones de gasto inicial.
- **b) Suavizamiento del Consumo ($\sigma_C / \sigma_Y < 1.0$):**
  - Deriva de la hipótesis del ingreso permanente y la concavidad de la función de utilidad $u(C) = \ln(C)$. Los hogares racionales buscan igualar su utilidad marginal a lo largo del ciclo vital, ahorrando e invirtiendo la fracción transitoria de las bonanzas de productividad en lugar de consumirla inmediatamente.
- **c) Prociclicidad del Empleo y la Productividad:**
  - Un choque tecnológico positivo eleva el salario real de equilibrio ($W_t = (1-\alpha) A_t K_t^\alpha L_t^{-\alpha}$). Debido al mecanismo de **sustitución intertemporal del ocio**, los trabajadores prefieren concentrar sus horas laborables en periodos donde la remuneración del esfuerzo es transitoriamente más elevada, generando una fuerte co-movilidad positiva entre empleo y producción.

---

### Rúbrica de Corrección para el Docente

| Ejercicio | Criterios Clave de Corrección | Ponderación |
| :--- | :--- | :--- |
| **Ejercicio 1** | Correcta deducción de CPO; demostración formal de $\pi^e = \alpha \gamma (k-1)y_n$; cálculos numéricos de $E[L^C]$ y $E[L^D]$; explicación de la tentación de engañar. | 35% |
| **Ejercicio 2** | Regla de reacción del banquero conservador; separación entre sesgo inflacionario y estabilización de choques; deducción analítica de $\gamma_b^* \in (0, \gamma_s)$. | 30% |
| **Ejercicio 3** | Formulación de la matriz de segundas diferencias $D$; demostración de la solución cerrada $\tau = (I + \lambda D'D)^{-1}y$; análisis de límites $\lambda \to 0$ y $\lambda \to \infty$; interpretación económica RBC (inversión vs. consumo, time-to-build). | 35% |

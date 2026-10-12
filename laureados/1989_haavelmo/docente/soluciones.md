# Soluciones y Pautas de Evaluación (Docente)
## Laureado 1989: Trygve Haavelmo

> **Nota pedagógica confidencial para el profesor:** Este documento contiene las derivaciones matemáticas analíticas completas, demostraciones estadísticas, cálculos numéricos paso a paso, interpretaciones pedagógicas y rúbrica de corrección para los ejercicios presentados en `estudiante/ejercicios.qmd`.

---

### Solución Ejercicio 1 (Derivación Analítica del Sesgo de Simultaneidad)

#### 1. Ecuaciones de Forma Reducida:
- Sistema estructural:
  1. $C_t = \alpha + \beta Y_t + u_t$
  2. $Y_t = C_t + I_t$
- Sustituyendo la ecuación (1) en (2):
  $$Y_t = \alpha + \beta Y_t + u_t + I_t$$
- Reagrupando los términos en $Y_t$:
  $$(1 - \beta) Y_t = \alpha + I_t + u_t$$
- Dado que $0 < \beta < 1 \implies 1 - \beta > 0$, despejamos $Y_t$:
  $$Y_t = \frac{\alpha}{1 - \beta} + \frac{1}{1 - \beta} I_t + \frac{1}{1 - \beta} u_t$$
- Sustituyendo $Y_t$ en la ecuación de consumo (o usando $C_t = Y_t - I_t$):
  $$C_t = \frac{\alpha}{1 - \beta} + \left( \frac{1}{1 - \beta} - 1 \right) I_t + \frac{1}{1 - \beta} u_t = \frac{\alpha}{1 - \beta} + \frac{\beta}{1 - \beta} I_t + \frac{1}{1 - \beta} u_t$$
- El multiplicador keynesiano del gasto autónomo en la forma reducida es $k = \frac{1}{1 - \beta}$.

#### 2. Covarianza y Varianza Asintóticas:
- **Covarianza entre $Y_t$ y $u_t$:**
  $$\text{Cov}(Y_t, u_t) = \text{Cov}\left( \frac{\alpha}{1 - \beta} + \frac{1}{1 - \beta} I_t + \frac{1}{1 - \beta} u_t, u_t \right)$$
  Como $\alpha$ es constante y $I_t$ es independiente de $u_t$ ($\text{Cov}(I_t, u_t) = 0$):
  $$\text{Cov}(Y_t, u_t) = \frac{1}{1 - \beta} \text{Cov}(u_t, u_t) = \frac{\sigma_u^2}{1 - \beta}$$
  Dado que $\sigma_u^2 > 0$ y $1 - \beta > 0$, **la covarianza es estrictamente positiva**.

- **Varianza no condicional de $Y_t$:**
  $$\text{Var}(Y_t) = \text{Var}\left( \frac{\alpha + I_t + u_t}{1 - \beta} \right) = \frac{1}{(1 - \beta)^2} [\text{Var}(I_t) + \text{Var}(u_t) + 2\text{Cov}(I_t, u_t)]$$
  $$\text{Var}(Y_t) = \frac{\sigma_I^2 + \sigma_u^2}{(1 - \beta)^2}$$

#### 3. Límite Probabilístico del Estimador MCO:
- El estimador de MCO para la pendiente es:
  $$\hat{\beta}_{MCO} = \frac{\widehat{\text{Cov}}(Y, C)}{\widehat{\text{Var}}(Y)} = \frac{\widehat{\text{Cov}}(Y, \alpha + \beta Y + u)}{\widehat{\text{Var}}(Y)} = \beta + \frac{\widehat{\text{Cov}}(Y, u)}{\widehat{\text{Var}}(Y)}$$
- Aplicando la Ley Débil de los Grandes Números (Khinchin / Slutsky):
  $$\text{plim}_{T \to \infty} \, \hat{\beta}_{MCO} = \beta + \frac{\text{Cov}(Y_t, u_t)}{\text{Var}(Y_t)}$$
- Sustituyendo las expresiones halladas:
  $$\text{plim}_{T \to \infty} \, \hat{\beta}_{MCO} = \beta + \frac{\frac{\sigma_u^2}{1 - \beta}}{\frac{\sigma_I^2 + \sigma_u^2}{(1 - \beta)^2}} = \beta + (1 - \beta) \left( \frac{\sigma_u^2}{\sigma_I^2 + \sigma_u^2} \right)$$
- **Signo e intuición:**
  Como $1 - \beta > 0$ y $\frac{\sigma_u^2}{\sigma_I^2 + \sigma_u^2} > 0$, el sesgo asintótico es estrictamente positivo: MCO **sobreestima sistemáticamente** la propensión marginal al consumo.
  *Intuición económica:* Un shock positivo no observado en las preferencias de consumo ($u_t > 0$) incrementa directamente $C_t$. Pero en una economía en equilibrio, más consumo implica mayor demanda agregada y por tanto mayor ingreso nacional $Y_t$. En consecuencia, los datos empíricos muestran que $Y_t$ y $C_t$ aumentan conjuntamente no solo por el efecto propensión ($\beta$), sino porque el propio shock $u_t$ alimenta a $Y_t$. MCO confunde este bucle de retroalimentación de equilibrio general con una mayor propensión a consumir de las familias.
- **Casos límite:**
  a) Si $\sigma_u^2 \to 0$: El sesgo tiende a 0. Si no hay perturbaciones estocásticas en la relación estructural, MCO coincide con la verdadera pendiente.
  b) Si $\sigma_I^2 \to \infty$: $\frac{\sigma_u^2}{\sigma_I^2 + \sigma_u^2} \to 0$, por lo que el sesgo colapsa a 0. La variación exógena de la inversión domina la variabilidad de $Y_t$, diluyendo la retroalimentación endógena del error.
  c) Si $\sigma_I^2 \to 0$: $\frac{\sigma_u^2}{\sigma_I^2 + \sigma_u^2} = 1 \implies \text{plim} \, \hat{\beta}_{MCO} = \beta + (1 - \beta) = 1$. MCO estimará siempre una propensión marginal al consumo igual a 1, un error mayúsculo.

---

### Solución Ejercicio 2 (El Multiplicador del Presupuesto Equilibrado)

#### 1. Derivación del Teorema de Haavelmo con Impuestos de Suma Fija:
- Modelo:
  $$Y = C + I + G$$
  $$C = \alpha + \beta(Y - T) + u$$
- Sustitución:
  $$Y = \alpha + \beta Y - \beta T + u + I + G$$
  $$(1 - \beta) Y = \alpha + I + u + G - \beta T$$
  $$Y^* = \frac{\alpha + I + u}{1 - \beta} + \frac{1}{1 - \beta} G - \frac{\beta}{1 - \beta} T$$
- Diferenciando totalmente con respecto a $G$ y $T$:
  $$\Delta Y = \frac{1}{1 - \beta} \Delta G - \frac{\beta}{1 - \beta} \Delta T$$
- Imponiendo la condición de presupuesto equilibrado ($\Delta T = \Delta G$):
  $$\Delta Y = \frac{1}{1 - \beta} \Delta G - \frac{\beta}{1 - \beta} \Delta G = \left( \frac{1 - \beta}{1 - \beta} \right) \Delta G = 1 \cdot \Delta G$$
  $$\frac{\Delta Y}{\Delta G}\Bigg|_{\Delta T = \Delta G} = 1$$
- **Descomposición económica:**
  1. El gobierno compra bienes por valor de $\Delta G$, inyectando demanda agregada directa por valor de $+\Delta G$.
  2. El gobierno cobra impuestos por $\Delta T = \Delta G$, lo cual reduce el ingreso disponible de las familias en $\Delta G$.
  3. Los hogares reducen su consumo en solo $\beta \Delta G$, porque la fracción restante $(1 - \beta)\Delta G$ la habrían ahorrado de todas formas.
  4. La inyección neta inmediata en la economía es:
     $$\text{Demanda Neta Inicial} = \Delta G - \beta \Delta G = (1 - \beta) \Delta G$$
  5. Esta demanda neta se multiplica a lo largo del proceso del multiplicador keynesiano:
     $$\Delta Y = [(1 - \beta)\Delta G] \times \left( \frac{1}{1 - \beta} \right) = \Delta G$$
  Por tanto, el impacto final es exactamente $\Delta Y = \Delta G$, y el multiplicador es 1.

#### 2. Extensión con Impuestos Proporcionales al Ingreso:
- Modelo con impuestos endógenos: $T = t_0 + t Y$.
- Ingreso disponible: $Y_d = Y - (t_0 + t Y) = (1 - t)Y - t_0$.
- Función de consumo: $C = \alpha + \beta(1 - t)Y - \beta t_0 + u$.
- Reemplazando en $Y = C + I + G$:
  $$Y = \alpha + \beta(1 - t)Y - \beta t_0 + u + I + G$$
  $$Y[1 - \beta(1 - t)] = \alpha - \beta t_0 + I + u + G$$
  $$Y^* = \frac{\alpha - \beta t_0 + I + u + G}{1 - \beta(1 - t)}$$
- Si el gasto aumenta en $\Delta G$ y se ajusta la componente fija $t_0$ para mantener el presupuesto equilibrado ex-post ($\Delta T = \Delta G$):
  $$\Delta T = \Delta t_0 + t \Delta Y = \Delta G \implies \Delta t_0 = \Delta G - t \Delta Y$$
- Diferenciando la ecuación de ingreso:
  $$\Delta Y = \frac{\Delta G - \beta \Delta t_0}{1 - \beta(1 - t)} = \frac{\Delta G - \beta(\Delta G - t \Delta Y)}{1 - \beta(1 - t)}$$
  $$\Delta Y [1 - \beta(1 - t)] = (1 - \beta)\Delta G + \beta t \Delta Y$$
  $$\Delta Y [1 - \beta + \beta t - \beta t] = (1 - \beta)\Delta G$$
  $$\Delta Y (1 - \beta) = (1 - \beta) \Delta G \implies \Delta Y = \Delta G \implies \frac{\Delta Y}{\Delta G} = 1$$
- ¡El teorema de Haavelmo se cumple de forma general e invariable aun con impuestos proporcionales si el balance presupuestario se preserva ex-post!

#### 3. Comparación con la Equivalencia Ricardiana (Barro 1974):
- En el modelo keynesiano estático de Haavelmo, los consumidores no optimizan intertemporalmente con horizontes infinitos; consumen en función del ingreso disponible corriente.
- Bajo la hipótesis de Equivalencia Ricardiana (Barro 1974), las familias descuentan la senda futura de impuestos y deuda. Si el gasto público financiado con impuestos es para bienes que sustituyen el consumo privado o generan distorsiones tributarias por impuestos distorsionadores (pérdida de eficiencia), el multiplicador puede ser menor que 1 e incluso negativo. Haavelmo proporcionó la cota de referencia canónica para economías con rigideces de precios y recursos ociosos.

---

### Solución Ejercicio 3 (Identificación, Variables Instrumentales y Ruptura de Exogeneidad)

#### 1. Condiciones de Orden y Rango:
- Sea un sistema de $G$ ecuaciones endógenas y $K$ variables predeterminadas/exógenas totales en el sistema.
- **Condición de orden (necesaria):** Para que una ecuación esté identificada, el número de variables exógenas excluidas de esa ecuación ($K^*$) debe ser al menos igual al número de variables endógenas incluidas en ella menos uno ($G^* - 1$):
  $$K^* \ge G^* - 1$$
- En la Ecuación 1 ($C_t = \alpha_1 + \beta_1 Y_t + u_{1t}$):
  - Variables endógenas incluidas: $C_t, Y_t \implies G^* = 2$.
  - Variables exógenas del sistema: $\{I_t, G_t\} \implies K = 2$.
  - Variables exógenas excluidas de la Ecuación 1: ambas ($I_t, G_t$) están excluidas $\implies K^* = 2$.
  - Condición de orden: $K^* = 2 \ge G^* - 1 = 2 - 1 = 1$. La condición se cumple con desigualdad estricta ($2 > 1$), por lo que la ecuación está **sobreidentificada** por un grado de libertad.
- **Condición de rango (necesaria y suficiente):** La matriz de coeficientes reducidos de las variables excluidas debe tener rango completo de columnas ($\text{rango} = G^* - 1 = 1$). Esto equivale a requerir que al menos una de las variables exógenas excluidas tenga coeficiente no nulo en la proyección de $Y_t$.

#### 2. Demostración de Consistencia de MC2E:
- Proyección de primera etapa:
  $$Y_t = \pi_0 + \pi_1 I_t + \pi_2 G_t + v_t$$
- Predicción: $\hat{Y}_t = \hat{\pi}_0 + \hat{\pi}_1 I_t + \hat{\pi}_2 G_t$.
- En segunda etapa se estima:
  $$C_t = \alpha_1 + \beta_1 \hat{Y}_t + \varepsilon_t$$
- El estimador es:
  $$\hat{\beta}_{1, IV} = (\hat{Y}' \hat{Y})^{-1} \hat{Y}' C = \beta_1 + (\hat{Y}' \hat{Y})^{-1} \hat{Y}' u_1$$
- Como $\hat{Y}$ es combinación lineal de las variables exógenas $Z = [1, I, G]$ y por supuesto de exogeneidad $\text{plim} \, \frac{1}{T} Z' u_1 = 0$:
  $$\text{plim} \, \frac{1}{T} \hat{Y}' u_1 = 0 \implies \text{plim}_{T \to \infty} \, \hat{\beta}_{1, IV} = \beta_1$$
- **Supuesto indispensable:** Las variables instrumentales deben ser estrictamente ortogonales a la perturbación estructural del consumo: $\mathbb{E}[I_t u_{1t}] = 0$ y $\mathbb{E}[G_t u_{1t}] = 0$.

#### 3. Instrumentos Débiles y Literatura Moderna:
- Cuando la correlación entre el instrumento y la variable endógena es muy baja ($\pi_1 \approx 0$), el estadístico $F$ de la primera etapa cae por debajo del umbral de regla empírica de Staiger y Stock (1997) ($F < 10$) o de los valores críticos de Stock y Yogo (2005).
- En este caso, el estimador de variables instrumentales:
  1. Pierde su propiedad de normalidad asintótica.
  2. Su distribución muestral se vuelve fuertemente bimodal o con colas muy pesadas (la varianza muestral explota).
  3. Su sesgo en muestras finitas converge hacia el sesgo de MCO.
- *Conclusión pedagógica:* Haavelmo introdujo la necesidad del instrumental simultáneo; la econometría de finales del siglo XX (Stock, Yogo, Angrist) perfeccionó el diagnóstico de la fuerza de los instrumentos para evitar diagnósticos espurios.

---

### Rúbrica de Corrección Pedagógica

| Criterio | Excelente (90-100%) | Satisfactorio (70-89%) | En Desarrollo (<70%) |
| :--- | :--- | :--- | :--- |
| **Derivación del Sesgo de Simultaneidad (Ej. 1)** | Resuelve la forma reducida sin fallas, calcula rigurosamente $\text{Cov}(Y, u)$ y $\text{Var}(Y)$, y deduce la fórmula exacta del $\text{plim}$ explicando con claridad la intuición económica del sesgo positivo. | Plantea correctamente la sustitución pero comete pequeños errores de álgebra en las varianzas o presenta una intuición económica incompleta. | No resuelve la forma reducida o confunde covarianza muestral con parámetros poblacionales. |
| **Multiplicador de Haavelmo (Ej. 2)** | Demuestra formalmente que $k_{PE} = 1$ para suma fija e impuestos sobre el ingreso, explicando con precisión la descomposición entre absorción directa y contracción del consumo. | Demuestra $k_{PE} = 1$ en el caso simple de suma fija pero omite la extensión a impuestos sobre el ingreso o la intuición económica. | Concluye erróneamente que el multiplicador es 0 o confunde la fórmula con el multiplicador con déficit. |
| **Identificación y VI (Ej. 3)** | Aplica correctamente las condiciones de orden y rango, demuestra la consistencia de MC2E y explica con claridad el problema moderno de instrumentos débiles. | Enuncia la condición de orden pero tiene dificultades con el rango o la derivación asintótica de consistencia. | No distingue entre variables endógenas y exógenas o confunde la primera y segunda etapa de MC2E. |

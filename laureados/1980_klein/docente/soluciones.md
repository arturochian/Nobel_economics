# Guía Docente y Solucionario: Lawrence R. Klein (Nobel 1980)

> **Material de uso exclusivo para el cuerpo docente.**  
> Este documento contiene las pautas pedagógicas, los fundamentos analíticos y el solucionario detallado paso a paso de la guía de ejercicios de `laureados/1980_klein/estudiante/ejercicios.qmd`.

---

## 1. Pautas Pedagógicas y Contexto Teórico

### El papel de Lawrence R. Klein en la Ciencia Económica
Lawrence Robert Klein (1920–2013) transformó la teoría keynesiana de un conjunto de esquemas conceptuales y diagramas estáticos (como las curvas IS-LM de Hicks) en una disciplina empírica cuantitativa basada en sistemas computacionales de ecuaciones simultáneas.

Al impartir este módulo docente, es fundamental transmitir a los estudiantes los siguientes ejes conceptuales:
1. **La Realidad de la Simultaneidad:** En macroeconomía agregada, casi ninguna variable es estrictamente exógena. El ingreso genera consumo, pero el consumo genera demanda agregada e ingreso. Intentar estimar la función de consumo mediante MCO asumiendo que el ingreso es "fijo" es un error conceptual grave que infla artificialmente las propensiones marginales.
2. **El Triunfo y Límites de la Comisión Cowles:** Klein, junto con Koopmans, Marschak y Haavelmo en la Comisión Cowles, desarrolló la teoría de identificación y estimación de ecuaciones simultáneas (MC2E, MC3E, LIML, FIML). Aunque en los años 1970 la Crítica de Lucas (1976) y la revolución de Sims (1980) cuestionaron la invarianza de estos modelos, su arquitectura matemática sigue siendo la base del instrumental operativo moderno en bancos centrales y organismos multilaterales.
3. **El Proyecto LINK como Antecedente de la Globalización:** Explicar cómo el Proyecto LINK (1968) resolvió por primera vez la interconexión mundial: ningún país puede simular su política fiscal de forma aislada sin tener en cuenta que sus importaciones son las exportaciones de sus socios comerciales.

---

## 2. Solución Detallada del Ejercicio 1 (Nivel Básico)

### Pregunta 1: Deducción de la Forma Reducida
El modelo estructural es:
$$C_t = \alpha_0 + \alpha_1 Y_t + u_t$$
$$Y_t = C_t + I_t + G_t$$

Sustituyendo la ecuación de consumo en la identidad del producto:
$$Y_t = \alpha_0 + \alpha_1 Y_t + u_t + I_t + G_t$$
Agrupando los términos en $Y_t$:
$$(1 - \alpha_1) Y_t = \alpha_0 + I_t + G_t + u_t$$
Dado que $0 < \alpha_1 < 1$, dividimos entre $(1 - \alpha_1)$:
$$Y_t = \frac{\alpha_0}{1 - \alpha_1} + \frac{1}{1 - \alpha_1} (I_t + G_t) + \frac{1}{1 - \alpha_1} u_t$$
Esta es la **forma reducida** del producto nacional $Y_t$.

### Pregunta 2: Cálculo del Sesgo de Simultaneidad de MCO
Calculamos la covarianza analítica entre $Y_t$ y el error estructural $u_t$:
$$\text{Cov}(Y_t, u_t) = \mathbb{E}\left[(Y_t - \mathbb{E}[Y_t]) u_t\right]$$
Dado que $I_t$ y $G_t$ son exógenos e independientes de $u_t$ ($\text{Cov}(I_t, u_t) = \text{Cov}(G_t, u_t) = 0$):
$$\text{Cov}(Y_t, u_t) = \mathbb{E}\left[\left(\frac{u_t}{1 - \alpha_1}\right) u_t\right] = \frac{1}{1 - \alpha_1} \mathbb{E}[u_t^2] = \frac{\sigma_u^2}{1 - \alpha_1}$$
Como $\sigma_u^2 > 0$ y $0 < \alpha_1 < 1$, se cumple:
$$\text{Cov}(Y_t, u_t) = \frac{\sigma_u^2}{1 - \alpha_1} > 0$$

*Inconsistencia del estimador MCO:*
El estimador MCO de la pendiente en la ecuación de consumo es:
$$\hat{\alpha}_1^{\text{MCO}} = \frac{\sum (Y_t - \bar{Y})(C_t - \bar{C})}{\sum (Y_t - \bar{Y})^2} = \alpha_1 + \frac{\sum (Y_t - \bar{Y}) u_t}{\sum (Y_t - \bar{Y})^2}$$
Tomando el límite en probabilidad ($\text{plim}$):
$$\text{plim} \, \hat{\alpha}_1^{\text{MCO}} = \alpha_1 + \frac{\text{Cov}(Y_t, u_t)}{\text{Var}(Y_t)} = \alpha_1 + \frac{\sigma_u^2}{(1 - \alpha_1) \text{Var}(Y_t)} > \alpha_1$$
El estimador MCO tiene un **sesgo positivo hacia arriba** (*upward simultaneous equation bias*): atribuye erróneamente al comportamiento del consumidor las perturbaciones macroeconómicas que expanden simultáneamente el producto agregado.

### Pregunta 3: Mecánica de Variables Instrumentales (MC2E / 2SLS)
- **Instrumento Válido:** El gasto público $G_t$ (o el gasto autónomo total $I_t + G_t$).
  - *Relevancia:* $\text{Cov}(G_t, Y_t) = \frac{\text{Var}(G_t)}{1 - \alpha_1} \neq 0$ (puesto que $G_t$ entra directamente en la forma reducida de $Y_t$).
  - *Exogeneidad:* Por definición de política pública exógena, $\text{Cov}(G_t, u_t) = 0$.
- **Primera Etapa:** Regresión de la variable endógena $Y_t$ sobre la constante y el instrumento $G_t$ (o $I_t + G_t$):
  $$Y_t = \pi_0 + \pi_1 (I_t + G_t) + v_t$$
  El valor ajustado predicho es $\hat{Y}_t = \hat{\pi}_0 + \hat{\pi}_1 (I_t + G_t)$.
- **Ortogonalidad:** Dado que $\hat{Y}_t$ es una combinación lineal exacta de variables exógenas, por definición:
  $$\text{plim} \, \frac{1}{N} \sum \hat{Y}_t u_t = 0$$
  Al sustituir $\hat{Y}_t$ en la segunda etapa, el estimador MC2E converge consistentemente a la verdadera propensión marginal al consumo $\alpha_1$.

### Pregunta 4: Interpretación Empírica en Klein I
En el Modelo Klein I, la estimación uniecuacional por MCO arrojaba $\hat{\alpha}_1^{\text{MCO}} = 0.1929$, sugiriendo que un dólar adicional de beneficios empresariales elevaba de inmediato el consumo de las familias capitalistas en casi 20 centavos. Sin embargo, al estimar por MC2E controlando la simultaneidad, el coeficiente se reduce a $\hat{\alpha}_1^{\text{MC2E}} = 0.0173$ (estadísticamente indistinguible de cero en el corto plazo, $p = 0.8966$).

*Explicación económica:* En épocas de bonanza macroeconómica, el auge del producto eleva simultáneamente los beneficios empresariales y el consumo familiar general. MCO confunde esta correlación agregada procíclica con causalidad directa de los beneficios sobre el gasto de consumo. Klein demostró que el consumo de los perceptores de beneficios responde en realidad con retraso temporal ($\hat{\alpha}_2 = 0.2162$ sobre los beneficios rezagados $P_{t-1}$), mientras que el consumo asalariado responde casi de inmediato a la nómina salarial ($\hat{\alpha}_3 = 0.8102$).

---

## 3. Solución Detallada del Ejercicio 2 (Nivel Intermedio)

### Pregunta 1: Construcción de la Matriz $\Gamma$
Vector endógeno: $y_t = (C_t, I_t, W^p_t, Y_t, P_t, K_t)'$.
Las relaciones contemporáneas son:
1. $C_t = \alpha_1 P_t + \alpha_3 W^p_t = 0.0173 P_t + 0.8102 W^p_t$
2. $I_t = \beta_1 P_t = 0.1502 P_t$
3. $W^p_t = \gamma_1 Y_t = 0.4389 Y_t$
4. $Y_t = 1 \cdot C_t + 1 \cdot I_t$
5. $P_t = 1 \cdot Y_t - 1 \cdot W^p_t$
6. $K_t = 1 \cdot I_t$

La matriz $\Gamma$ es:
$$\Gamma = \begin{pmatrix}
0 & 0 & 0.8102 & 0 & 0.0173 & 0 \\
0 & 0 & 0 & 0 & 0.1502 & 0 \\
0 & 0 & 0 & 0.4389 & 0 & 0 \\
1 & 1 & 0 & 0 & 0 & 0 \\
0 & 0 & -1 & 1 & 0 & 0 \\
0 & 1 & 0 & 0 & 0 & 0
\end{pmatrix}$$

### Pregunta 2: Inversión Matricial y Multiplicador de Gasto Público
La matriz $I - \Gamma$ es:
$$I - \Gamma = \begin{pmatrix}
1 & 0 & -0.8102 & 0 & -0.0173 & 0 \\
0 & 1 & 0 & 0 & -0.1502 & 0 \\
0 & 0 & 1 & -0.4389 & 0 & 0 \\
-1 & -1 & 0 & 1 & 0 & 0 \\
0 & 0 & 1 & -1 & 1 & 0 \\
0 & -1 & 0 & 0 & 0 & 1
\end{pmatrix}$$

Invirtiendo la matriz $(I - \Gamma)^{-1}$ y multiplicando por el vector de entrada del gasto público $e_G = (0, 0, 0, 1, 0, 0)'$:
$$\frac{\partial y_t}{\partial G_t} = (I - \Gamma)^{-1} \begin{pmatrix} 0 \\ 0 \\ 0 \\ 1 \\ 0 \\ 0 \end{pmatrix} = \begin{pmatrix} 0.6636 \\ 0.1531 \\ 0.7973 \\ \mathbf{1.8167} \\ 1.0194 \\ 0.1531 \end{pmatrix}$$
- Multiplicador de impacto del producto: $\frac{\partial Y_t}{\partial G_t} = 1.8167$.
- Multiplicador sobre el consumo: $\frac{\partial C_t}{\partial G_t} = 0.6636$.
- Multiplicador sobre la inversión: $\frac{\partial I_t}{\partial G_t} = 0.1531$.
- Multiplicador sobre salarios privados: $\frac{\partial W^p_t}{\partial G_t} = 0.7973$.
- Multiplicador sobre beneficios: $\frac{\partial P_t}{\partial G_t} = 1.0194$.

*Comprobación contable:*
$$\Delta Y = \Delta C + \Delta I + \Delta G = 0.6636 + 0.1531 + 1.0000 = 1.8167$$
$$\Delta P = \Delta Y - \Delta W^p = 1.8167 - 0.7973 = 1.0194$$
El balance contable se cumple de forma exacta.

### Pregunta 3: Multiplicador de Impuestos Indirectos ($T$)
En el sistema, los impuestos entran en la identidad del producto con coeficiente $-1$ (en la fila 4) y en la demanda de salarios privados a través de $X_t = Y_t + T_t - W^g_t$ con coeficiente $+\gamma_1 = 0.4389$ (en la fila 3):
$$e_T = \begin{pmatrix} 0 \\ 0 \\ 0.4389 \\ -1 \\ 0 \\ 0 \end{pmatrix}$$
Multiplicando por $(I - \Gamma)^{-1}$:
$$\frac{\partial y_t}{\partial T_t} = (I - \Gamma)^{-1} e_T = \begin{pmatrix} -0.1285 \\ -0.1759 \\ -0.1336 \\ \mathbf{-1.3043} \\ -1.1708 \\ -0.1759 \end{pmatrix}$$
- Multiplicador tributario sobre el producto: $\frac{\partial Y_t}{\partial T_t} = -1.3043$.
- Multiplicador sobre el consumo: $\frac{\partial C_t}{\partial T_t} = -0.1285$.
- Multiplicador sobre los beneficios corporativos: $\frac{\partial P_t}{\partial T_t} = -1.1708$.

### Pregunta 4: Presupuesto Equilibrado de Haavelmo en Klein I
Un incremento conjunto $\Delta G_t = 1$ y $\Delta T_t = 1$ tiene un vector de entrada $e_{BB} = e_G + e_T$.
El impacto sobre el producto agregado es:
$$\Delta Y = \frac{\partial Y_t}{\partial G_t} + \frac{\partial Y_t}{\partial T_t} = 1.8167 + (-1.3043) = +0.5124$$
*Discusión económica:*
En el modelo estático elemental de Haavelmo (1945), el multiplicador del presupuesto equilibrado es exactamente $1$ porque el gasto público tiene propensión marginal 1 y los impuestos afectan el consumo a través de la propensión marginal $c < 1$. En el Modelo Klein I, los impuestos no son únicamente sobre la renta familiar, sino gravámenes indirectos a la producción de negocios que afectan el cálculo de salarios y beneficios, reduciendo la rentabilidad de las empresas e induciendo una caída en la inversión ($\Delta I = -0.0227$). Por ello, el multiplicador resultante es $+0.5124 < 1$, pero se mantiene nítidamente expansivo.

---

## 4. Solución Detallada del Ejercicio 3 (Nivel Reto)

### Pregunta 1: Condición de Estabilidad Dinámica
El par de raíces complejas conjugadas es:
$$\lambda_{1,2} = 0.7702 \pm 0.3494i$$
Su módulo se calcula como:
$$|\lambda| = \sqrt{0.7702^2 + 0.3494^2} = \sqrt{0.5932 + 0.1221} = \sqrt{0.7153} \approx 0.8457$$
La tercera raíz real es $\lambda_3 = 0.2973$ (con $|\lambda_3| = 0.2973$).
Las restantes raíces son nulas ($\lambda_{4,5,6} = 0$).

El **radio espectral** de la matriz companion es:
$$\rho(\Pi_1) = \max_i |\lambda_i| = 0.8457$$
Como $\rho(\Pi_1) < 1$, todas las raíces se encuentran estrictamente contenidas dentro del círculo unitario en el plano complejo. Por lo tanto, el sistema macroeconómico es **asintóticamente estable**: cualquier choque exógeno transitorio se disipa y el sistema regresa a su senda de equilibrio estacionario.

### Pregunta 2: Periodicidad del Ciclo Económico
Calculamos el argumento polar del número complejo $\lambda_1$:
$$\theta = \arctan\left(\frac{0.3494}{0.7702}\right) \approx \arctan(0.45365) \approx 0.4260 \text{ radianes}$$
El período de oscilación fundamental $\mathcal{P}$ viene dado por:
$$\mathcal{P} = \frac{2\pi}{\theta} = \frac{6.283185}{0.4260} \approx 14.75 \text{ años}$$
*Interpretación histórica:*
Un ciclo de entre 14 y 15 años coincide notablemente con los **ciclos de Kuznets** (fluctuaciones de 15 a 25 años asociadas a la acumulación de infraestructura y formación bruta de capital fijo) y representa aproximadamente dos ciclos comerciales clásicos de **Juglar** (7 a 10 años). Klein demostró cuantitativamente que los ciclos económicos no requieren perturbaciones externas continuas para repetirse: la estructura de ecuaciones simultáneas con retardos genera fluctuaciones armónicas endógenas.

### Pregunta 3: Mecanismo de Aceleración y Amortiguamiento
En la ecuación de inversión:
$$I_t = \beta_0 + \beta_1 P_t + \beta_2 P_{t-1} + \beta_3 K_{t-1}$$
el parámetro del stock de capital es $\beta_3 = -0.1578 < 0$.
- Durante la fase de expansión, los altos beneficios ($P_t, P_{t-1}$) estimulan una fuerte inversión neta ($I_t > 0$).
- Por la identidad de acumulación de capital ($K_t = K_{t-1} + I_t$), el stock de capital acumulado $K$ aumenta sostenidamente.
- En los períodos subsiguientes, el término $\beta_3 K_{t-1} < 0$ actúa como una **fuerza de fricción / freno**: la abundante capacidad productiva instalada reduce la rentabilidad marginal de nuevas inversiones.
- La inversión cae, deprimiendo el producto agregado y dando paso a la fase contractiva del ciclo. Sin este parámetro negativo ($\beta_3 < 0$), el acelerador de inversión provocaría una trayectoria explosiva unidireccional.

### Pregunta 4: Trayectoria del Multiplicador Dinámico
Calculando la potencia $\Pi_1^s \Pi_0^{(G)}$ período a período:
- **Años 0 a 1:** $\Delta Y_0 = 1.8167, \Delta Y_1 = 1.8084$. Fuerte expansión debido al multiplicador de demanda y a que los beneficios rezagados siguen incentivando el consumo y la inversión.
- **Años 2 a 3:** $\Delta Y_2 = 1.1918, \Delta Y_3 = 0.4548$. El gasto público exógeno ha desaparecido ($\Delta G = 0$), pero la inercia del capital mantiene la producción en positivo.
- **Años 4 a 7:** $\Delta Y_4 = -0.1779, \Delta Y_5 = -0.6072, \Delta Y_6 = -0.8102, \Delta Y_7 = -0.8145$. La economía entra en la fase baja de la onda sinusoidal amortiguada: el stock de capital acumulado durante el auge inicial ahora frena la inversión neta ($\Delta I_5 = -0.3287, \Delta I_6 = -0.3757$).
- **Años 8 en adelante:** La economía comienza a recuperar la senda cero ($\Delta Y_{10} = -0.2218$), convergiendo finalmente a cero cuando el exceso de capital se deprecia.

---

## 5. Rúbrica de Evaluación Docente

| Criterio | Excelente (90–100%) | Aceptable (70–89%) | Insuficiente (<70%) |
|---|---|---|---|
| **Ejercicio 1: Simultaneidad e Instrumentos** | Deduce con total rigor la forma reducida, calcula la covarianza analítica exacta y justifica con precisión las condiciones de relevancia y exogeneidad en MC2E. | Deriva la forma reducida pero comete errores algebraicos menores en la covarianza o en la explicación del sesgo de simultaneidad. | No identifica el sesgo de simultaneidad de MCO o confunde la definición de variable instrumental. |
| **Ejercicio 2: Forma Reducida y Multiplicadores** | Construye correctamente la matriz $\Gamma$, calcula con precisión los multiplicadores de gasto e impuestos y discute con criterio la diferencia con el teorema de Haavelmo. | Plantea correctamente la matriz $\Gamma$ pero comete errores aritméticos en los multiplicadores tributarios. | No sabe formular la representación matricial simultánea ni derivar el multiplicador de impacto. |
| **Ejercicio 3: Dinámica y Ciclos Económicos** | Calcula con exactitud el radio espectral ($0.8457$), demuestra la periodicidad del ciclo ($14.75$ años) y articula una sólida explicación del freno del capital. | Determina la estabilidad mediante el módulo pero no logra calcular con precisión la periodicidad cíclica o el papel de $\beta_3$. | Errores sustantivos en álgebra de números complejos; incapacidad de relacionar autovalores con estabilidad dinámica. |

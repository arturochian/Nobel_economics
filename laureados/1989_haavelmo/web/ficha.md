---
anio: 1989
slug: 1989_haavelmo
laureados: ["Trygve Haavelmo"]
motivacion_oficial: "for his clarification of the probability theory foundations of econometrics and his analyses of simultaneous economic structures"
area: ["Econometría", "Macroeconomía", "Metodología Económica"]
tags: ["enfoque probabilístico", "sesgo de simultaneidad", "sistemas de ecuaciones simultáneas", "forma reducida", "teorema del presupuesto equilibrado", "variables instrumentales", "Comisión Cowles"]
referencias_clave: ["haavelmo1944probability", "haavelmo1943simultaneous", "haavelmo1945multiplier", "haavelmo1947measuring", "nobel1989scientific"]
replicacion: "laureados/1989_haavelmo/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase

Trygve Haavelmo revolucionó la ciencia económica al establecer los fundamentos probabilísticos de la econometría moderna, demostrar analíticamente el sesgo de estimar ecuaciones aisladas en sistemas simultáneos y probar el célebre teorema del multiplicador unitario del presupuesto equilibrado.

## Resumen de la investigación

Durante las décadas de 1930 y principios de 1940, la economía cuantitativa se encontraba en un callejón sin salida metodológico. Los pioneros de la econometría temprana (como Ragnar Frisch y Jan Tinbergen) concebían las leyes económicas como relaciones deterministas exactas, considerando las discrepancias empíricas como simples "errores de medición" accidentales. Al mismo tiempo, figuras tutelares como John Maynard Keynes (1939) y Lionel Robbins sostenían con escepticismo que la inferencia estadística moderna desarrollada por Ronald Fisher, Jerzy Neyman y Egon Pearson no tenía validez alguna en economía, argumentando que las series temporales macroeconómicas no provenían de experimentos de laboratorio controlados.

Trygve Haavelmo (1911–1999) demolió este dilema en su monumental disertación doctoral de 1941, publicada como suplemento de *Econometrica* en 1944 con el título *"The Probability Approach in Econometrics"*, y en sus artículos complementarios de 1943 y 1945:

1. **La Fundación Probabilística:** Haavelmo probó que los modelos económicos deben formularse formalmente como **procesos generadores de datos estocásticos** (*data-generating processes* o DGP). Las perturbaciones aleatorias no son impurezas externas, sino propiedades intrínsecas de las decisiones humanas agregadas y de los factores no observados. Al dotar a los modelos de distribuciones de probabilidad conjuntas, unificó por primera vez la teoría económica con la teoría matemática de la probabilidad, legitimando el uso de la estimación por máxima verosimilitud, los contrastes de hipótesis y los intervalos de confianza en datos observacionales no experimentales.
2. **Sistemas de Ecuaciones Simultáneas y Sesgo de Simultaneidad:** Haavelmo (1943) demostró el peligro crítico de aplicar el método de Mínimos Cuadrados Ordinarios (MCO / *Ordinary Least Squares*, OLS) a ecuaciones individuales dentro de un modelo interdependiente. Al analizar la función de consumo keynesiana en interacción con la identidad del ingreso nacional, probó que la variable explicativa (el PIB) está inevitablemente correlacionada con la perturbación estructural del consumo, tornando a los estimadores MCO **inconsistentes y sesgados al alza**. Este hallazgo impulsó el programa de investigación de la Comisión Cowles (*Cowles Commission for Research in Economics*) para crear los métodos de Variables Instrumentales (VI / IV), Mínimos Cuadrados en Dos Etapas (MC2E / 2SLS) y Máxima Verosimilitud con Información Completa (FIML).
3. **El Teorema del Presupuesto Equilibrado (1945):** Haavelmo demostró analíticamente que un incremento del gasto público financiado íntegramente mediante un aumento equivalente en los impuestos ($\Delta G = \Delta T$) no es macroeconómicamente neutral, sino que genera una expansión en el producto nacional con un multiplicador idénticamente igual a 1 ($k=1$), independiente de la propensión marginal a consumir.

## Metodología y resultados

1. **El Enfoque Probabilístico y el Principio de Verosimilitud Estructural (1944):**
   Haavelmo definió un modelo econométrico como una familia paramétrica de distribuciones de probabilidad conjuntas para las variables observables $y = (y_1, y_2, \dots, y_T)$:
   $$\mathcal{P} = \{ P(y; \theta), \theta \in \Theta \}$$
   Bajo este enfoque, contrastar una teoría económica consiste en evaluar si la distribución empírica observada pertenece al subconjunto compatible con las restricciones teóricas impuestas sobre $\theta$. Esto permitió superar la objeción keynesiana sobre la falta de experimentación: la naturaleza realiza "experimentos pasivos" regidos por leyes de probabilidad que el econometrista puede aislar e identificar.

2. **Demostración Analítica del Sesgo de Simultaneidad (1943):**
   En el sistema macroeconómico canónico:
   $$C_t = \alpha + \beta Y_t + u_t, \quad Y_t = C_t + I_t, \quad u_t \sim \text{iid } \mathcal{N}(0, \sigma_u^2), \quad I_t \sim \text{iid } (\mu_I, \sigma_I^2)$$
   Haavelmo resolvió la **forma reducida** para el ingreso nacional:
   $$Y_t = \frac{\alpha + I_t + u_t}{1 - \beta}$$
   Demostró que la covarianza entre la variable explicativa $Y_t$ y el error estructural $u_t$ es estrictamente positiva:
   $$\text{Cov}(Y_t, u_t) = \frac{\sigma_u^2}{1 - \beta} > 0$$
   En consecuencia, el límite probabilístico del estimador de MCO es:
   $$\text{plim}_{T \to \infty} \, \hat{\beta}_{MCO} = \beta + (1 - \beta) \left( \frac{\sigma_u^2}{\sigma_I^2 + \sigma_u^2} \right) > \beta$$
   MCO sobreestima permanentemente la propensión marginal al consumo, mientras que el estimador de Variables Instrumentales usando la inversión exógena $I_t$ recupera el verdadero parámetro: $\text{plim} \, \hat{\beta}_{IV} = \beta$.

3. **El Multiplicador del Presupuesto Equilibrado (1945):**
   En presencia de un gobierno con gasto $G$ e impuestos $T$:
   $$Y = C + I + G, \quad C = \alpha + \beta(Y - T) + u$$
   El ingreso de equilibrio es:
   $$Y^* = \frac{\alpha + I + u}{1 - \beta} + \frac{1}{1 - \beta} G - \frac{\beta}{1 - \beta} T$$
   Diferenciando bajo la regla de presupuesto balanceado ($\Delta G = \Delta T$):
   $$\Delta Y = \left( \frac{1}{1 - \beta} - \frac{\beta}{1 - \beta} \right) \Delta G = \left( \frac{1 - \beta}{1 - \beta} \right) \Delta G = 1 \cdot \Delta G \implies \frac{\Delta Y}{\Delta G}\Bigg|_{\Delta G = \Delta T} = 1$$

## Antes y después

### Antes
- **Econometría determinista y ad-hoc:** Las relaciones macroeconómicas se postulaban como leyes mecánicas exactas; los residuos empíricos eran considerados fallas de medición secundarias sin estatus conceptual.
- **Escepticismo sobre la inferencia estadística:** Keynes, Robbins y economistas clásicos rechazaban el uso de contrastes de hipótesis en economía por la ausencia de laboratorios experimentales controlados.
- **Regresiones lineales aisladas ingenuas:** Se estimaban ecuaciones individuales de oferta, demanda o consumo asumiendo que los precios o el ingreso eran exógenos, generando coeficientes espurios por omisión del equilibrio general.
- **Creencia en la neutralidad del presupuesto balanceado:** Se presumía en los debates de política fiscal que un presupuesto equilibrado ($\Delta G = \Delta T$) no alteraba el producto nacional ($k = 0$).

### Después
- **Fundación estocástica universal:** Todo modelo macroeconométrico moderno se concibe como un proceso generador de datos probabilístico regido por distribuciones conjuntas, verosimilitud y teoría asintótica.
- **Nacimiento de la estimación estructural en la Comisión Cowles:** Haavelmo sentó las bases para el desarrollo del análisis de identificación (condiciones de rango y orden), Variables Instrumentales (VI), Mínimos Cuadrados en Dos Etapas (Theil, Basmann) y FIML/LIML (Koopmans, Anderson, Rubin).
- **Tratamiento sistemático de la endogeneidad:** La distinción entre variables endógenas y exógenas se convirtió en el principio rector para la identificación causal en micro y macroeconometría.
- **Teorema fiscal canónico:** El multiplicador de Haavelmo ($k=1$) se convirtió en el punto de referencia indispensable de la teoría de las finanzas públicas y el análisis del impacto macroeconómico de los paquetes tributarios.

## Cómo se aplica hoy

1. **Estimación y Proyección en Modelos Macroeconómicos de Bancos Centrales (BCRP, Reserva Federal, BCE):**
   Todos los modelos estructurales empleados por las autoridades monetarias contemporáneas descienden directamente del marco de sistemas simultáneos de Haavelmo. Por ejemplo, el **Banco Central de Reserva del Perú (BCRP)** emplea en sus informes de política monetaria su *Modelo de Proyección Trimestral (MPT)* y modelos DSGE semiestructurales ([BCRP - Marco de Política Monetaria](https://www.bcrp.gob.pe)), donde la tasa de interés interbancaria, la brecha de producto y la inflación se determinan simultáneamente y se estiman mediante Máxima Verosimilitud con Información Completa y métodos bayesianos para neutralizar el sesgo de simultaneidad.
2. **Evaluación de Multiplicadores Fiscales en Organismos Multilaterales (Fondo Monetario Internacional y OCDE):**
   El Fondo Monetario Internacional (FMI) utiliza intensivamente el teorema del presupuesto equilibrado de Haavelmo como marco de referencia teórico y empírico para calibrar consolidaciones fiscales neutrales en la deuda. En sus reportes bandera (*Fiscal Monitor* y *World Economic Outlook*, post-2020), el FMI evalúa cómo las reformas tributarias verdes orientadas a financiar inversión pública en infraestructura descarbonizada generan un multiplicador expansivo en el PIB cercano a la unidad ($k \approx 1$), confirmando que el financiamiento tributario simultáneo de gasto no anula el estímulo económico.
3. **Inferencia Causal y Variables Instrumentales en Regulación y Defensa de la Competencia (FTC y Comisión Europea):**
   En la evaluación de fusiones empresariales y fijación de precios antimonopolio, la Comisión Federal de Comercio de EE.UU. (*Federal Trade Commission*, FTC) y la Dirección General de Competencia de la Comisión Europea estiman rutinariamente sistemas simultáneos de oferta y demanda derivados de modelos de elección discreta (Berry, Levinsohn y Pakes, 1995 - BLP). Utilizan variables instrumentales de costos exógenos (como precios de insumos en otras regiones o impuestos locales) para resolver el sesgo de simultaneidad entre precios y cantidades identificado originalmente por Haavelmo.

## Replicación en R

La replicación computacional implementa dos bloques metodológicos fundamentales en [`replicacion/R/enfoque_probabilistico_y_simultaneidad.R`](../replicacion/R/enfoque_probabilistico_y_simultaneidad.R):
1. **Simulación Monte Carlo (2,500 réplicas, $N=300$):** Compara el estimador de MCO frente a MC2E en un modelo keynesiano con $\beta = 0.75$. MCO converge con sesgo sistemático a $\text{plim}(\hat{\beta}) = 0.8269$, mientras que MC2E recupera limpiamente el valor de $0.7500$.
2. **Simulación del Multiplicador Fiscal de Haavelmo:** Demuestra que el multiplicador del presupuesto balanceado es invariante a $\beta$ e idéntico a 1, frente al multiplicador con deuda que explota hiperbólicamente.

Para ejecutar la replicación completa:
```powershell
& "C:\Program Files\R\R-4.6.0\bin\Rscript.exe" laureados/1989_haavelmo/replicacion/R/enfoque_probabilistico_y_simultaneidad.R
```

Las figuras de alta resolución resultantes se encuentran almacenadas en:
- [`salidas/fig_haavelmo_sesgo_simultaneidad.png`](../replicacion/salidas/fig_haavelmo_sesgo_simultaneidad.png)
- [`salidas/fig_haavelmo_presupuesto_equilibrado.png`](../replicacion/salidas/fig_haavelmo_presupuesto_equilibrado.png)
- [`salidas/tab_resultados_haavelmo.csv`](../replicacion/salidas/tab_resultados_haavelmo.csv)

## Para profundizar

- Haavelmo, Trygve (1944). *"The Probability Approach in Econometrics"*, *Econometrica*, 12 (Supplement), pp. iii–viii, 1–115. [DOI: 10.2307/1906935](https://doi.org/10.2307/1906935).
- Haavelmo, Trygve (1943). *"The Statistical Implications of a System of Simultaneous Equations"*, *Econometrica*, 11(1), pp. 1–12. [DOI: 10.2307/1905714](https://doi.org/10.2307/1905714).
- Haavelmo, Trygve (1945). *"Multiplier Effects of a Balanced Budget"*, *Econometrica*, 13(4), pp. 311–318. [DOI: 10.2307/1906914](https://doi.org/10.2307/1906914).
- Real Academia Sueca de Ciencias (1989). *"The Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 1989: Trygve Haavelmo"*. [nobelprize.org](https://www.nobelprize.org/prizes/economic-sciences/1989/press-release/).
- Morgan, Mary S. (1990). *The History of Econometric Ideas*, Cambridge University Press.

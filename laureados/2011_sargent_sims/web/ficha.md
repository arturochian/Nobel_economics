---
anio: 2011
slug: 2011_sargent_sims
laureados: ["Thomas J. Sargent", "Christopher A. Sims"]
motivacion_oficial: "for their empirical research on cause and effect in the macroeconomy"
area: ["Macroeconometría", "Macroeconomía Empírica y Expectativas"]
tags: ["vectores autorregresivos", "VAR estructural", "SVAR", "funciones impulso-respuesta", "expectativas racionales", "crítica de Lucas", "identificación recursiva de Cholesky"]
referencias_clave: ["sims1980macroeconomics", "sargent_wallace1975", "sargent1979macroeconomic", "sims1986forecasting", "nobel2011scientific"]
replicacion: "laureados/2011_sargent_sims/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Thomas J. Sargent y Christopher A. Sims revolucionaron la macroeconomía empírica al desarrollar las herramientas econométricas que permiten desentrañar la causalidad bidireccional entre las decisiones de política económica y la economía real, aislando el impacto dinámico de los shocks imprevistos frente a las reglas de política sistemáticas bajo expectativas racionales.

## Resumen de la investigación
En la macroeconomía existe un dilema fundamental: la economía influye en las políticas públicas, pero las políticas públicas también influyen en la economía. Cuando un banco central eleva las tasas de interés y la inflación se reduce meses después, ¿la caída de precios es consecuencia directa de la tasa de interés, o el banco central subió las tasas precisamente porque ya anticipaba presiones en los precios que luego se disiparon? Del mismo modo, ¿cómo reaccionan los hogares y las empresas cuando el gobierno anuncia un plan fiscal de largo plazo?

Antes de las investigaciones de Sargent y Sims a finales de la década de 1970 y principios de 1980, los modelos macroeconómicos existentes estaban dominados por grandes sistemas de ecuaciones keynesianos simultáneos. Estos modelos asumían que ciertas variables estaban fijas y que las expectativas de la población eran mecánicas o adaptativas.

Christopher A. Sims (1980) propuso un cambio de paradigma radical: los **Vectores Autorregresivos (VAR)** y **VAR Estructurales (SVAR)**. Sims argumentó que las restricciones impuestas por los macroeconometristas para identificar ecuaciones eran teóricamente arbitrarias e "increíbles" (*incredible identification restrictions*). En su lugar, diseñó un sistema multivariado donde todas las variables se tratan simétricamente como potencialmente endógenas. Mediante técnicas de identificación estructural (como la descomposición recursiva de Cholesky), Sims demostró cómo aislar perturbaciones no anticipadas (*shocks*) y seguir su propagación temporal mediante **Funciones Impulso-Respuesta (IRF)** y la **Descomposición de Varianza del Error de Pronóstico (FEVD)**.

Por su parte, Thomas J. Sargent (1975, 1979, 1987) formalizó la integración de las **expectativas racionales** en la estimación macroeconométrica. Sargent demostró que los agentes económicos forman pronósticos optimizadores utilizando toda la información disponible, incluyendo las reglas sistemáticas de las autoridades. Por tanto, un cambio en la política económica modifica la conducta del público, alterando los propios parámetros de los modelos estadísticos tradicionales (operativizando la *Crítica de Lucas*). Sargent demostró que la estabilidad macroeconómica proviene primordialmente de la credibilidad de las reglas de política sistemáticas y no de las sorpresas transitorias.

## Metodología y resultados
1. **Modelos VAR y el Enfoque Estructural de Sims (1980, 1986):**
   Sims formuló el sistema multivariado autorregresivo:
   $$Y_t = c + A_1 Y_{t-1} + \dots + A_p Y_{t-p} + u_t$$
   donde $Y_t$ agrupa variables clave (PIB, inflación, tasa de interés, crédito). Para desentrañar la correlación contemporánea entre los errores reducidos ($u_t$), Sims aplicó la descomposición ortogonal $u_t = P \varepsilon_t$ (factorización de Cholesky con $\Sigma_u = P P'$). Esto permitió simular perturbaciones puras y descubrir que:
   - Los shocks de política monetaria imprevistos explican solo una porción menor (entre 8% y 15%) de las fluctuaciones del producto agregado.
   - Las decisiones sistemáticas de política monetaria (la regla de respuesta) y los shocks reales explican la gran mayoría de la variabilidad observada.

2. **Expectativas Racionales y Restricciones de Ecuaciones Cruzadas (Sargent 1979, 1987):**
   Sargent demostró matemáticamente cómo estimar modelos dinámicos imponiendo restricciones de ecuaciones cruzadas (*cross-equation restrictions*). Bajo expectativas racionales, los coeficientes de las ecuaciones de consumo e inversión dependen explícitamente de los parámetros de la regla de política económica del banco central o del fisco. Sargent demostró cómo estimar los parámetros estructurales profundos de tecnología y preferencias, permitiendo evaluar reformas de política sin caer en la trampa de Lucas.

3. **La Proposición de Inefectividad de la Política (Sargent y Wallace, 1975):**
   Sargent y Neil Wallace demostraron que, en modelos con expectativas racionales y precios flexibles, las políticas monetarias sistemáticas totalmente anticipadas no pueden alterar el nivel de empleo ni el producto real en equilibrio, concentrando su efecto únicamente en el nivel de precios nominales.

## Antes y después

### Antes
- **Ecuaciones simultáneas con restricciones "increíbles":** Los modelos macroeconómicos de los años 60 (Klein-Goldberger, Brookings, Wharton) dependían de decenas de supuestos ad hoc de exclusión (fijar coeficientes en cero sin base microeconómica sólida) para lograr identificar parámetros.
- **Expectativas adaptativas mecánicas:** Se modelaba a los individuos y empresas como agentes pasivos que solo extrapolaban promedios ponderados del pasado, asumiendo que sus hábitos permanecerían inalterados ante reformas fiscales o monetarias radicales.
- **Confusión entre shock y política sistemática:** Se atribuía todo el desempeño económico a las decisiones inmediatas de política, sin distinguir si el impacto provenía de la regla predecible del gobierno o de perturbaciones aleatorias.

### Después (qué cambió gracias al aporte)
- **El instrumental estándar de VAR/SVAR:** El vector autorregresivo se convirtió en el lenguaje empírico universal de la macroeconomía, la banca central y las finanzas internacionales para cuantificar el impacto dinámico de perturbaciones exógenas.
- **Inferencia causal rigurosa:** Se establecieron métodos formales para rastrear la propagación en el tiempo de choques de tasas de interés, gasto público y tecnología mediante funciones impulso-respuesta e intervalos de confianza bootstrap.
- **Modelación basada en reglas y credibilidad:** La política económica dejó de concebirse como una serie de ajustes discrecionales sorpresivos. Se consolidó el consenso de que la mayor ganancia de bienestar proviene de reglas sistemáticas, transparentes y creíbles que anclen las expectativas del público.

## Cómo se aplica hoy

1. **Modelos BVAR y Monitoreo Macroeconómico en la Reserva Federal y el Banco Central Europeo (BCE):**
   Los bancos centrales más importantes del mundo emplean de manera cotidiana modelos VAR Bayesianos (BVAR) y estructurales para predecir la inflación y evaluar escenarios de riesgo. El Banco Central Europeo desarrolló la plataforma de software abierto [ECB BEAR Toolbox](https://www.ecb.europa.eu/pub/research/working-papers/html/bear-toolbox.en.html) (*Bayesian Estimation, Analysis and Regression Toolbox*), utilizada por bancos centrales de todo el Eurosistema para proyectar variables macroeconómicas y calibrar decisiones del Consejo de Gobierno. De manera análoga, los modelos BVAR de la Reserva Federal de Nueva York combinan pronósticos dinámicos con análisis estructural de shocks ([Federal Reserve Bank of New York - Research](https://www.newyorkfed.org/research/macroeconomics)).

2. **Evaluación de los Canales de Transmisión de Política Monetaria en Bancos Centrales de América Latina:**
   Instituciones como el Banco Central de Reserva del Perú ([BCRP - Documentos de Trabajo sobre SVAR](https://www.bcrp.gob.pe/publicaciones/documentos-de-trabajo.html)), el Banco de la República de Colombia ([Banrep - Investigaciones Económicas](https://www.banrep.gov.co/es/publicaciones-investigaciones/ensayos-politica-economica)) y el Banco Central de Chile aplican rutinariamente modelos SVAR para evaluar la velocidad y magnitud con que un cambio en la tasa de interés de referencia se transmite al crédito bancario, al tipo de cambio y a la inflación subyacente. Estos modelos permiten estimar rezagos de política monetaria típicamente situados entre 12 y 18 meses.

3. **Multiplicadores Fiscales y SVARs en el Fondo Monetario Internacional (FMI) y la OCDE:**
   Tras la crisis financiera de 2008 y la pandemia de 2020, el debate sobre el impacto del gasto público y la consolidación fiscal ha sido guiado por modelos SVAR basados en la identificación semi-estructural de Blanchard y Perotti (2002). El Fondo Monetario Internacional utiliza estos marcos en su [Monitor Fiscal del FMI](https://www.imf.org/en/Publications/FM) para calcular multiplicadores fiscales del gasto en infraestructura y transferencias sociales, evaluando cómo las expectativas de sostenibilidad de la deuda condicionan el efecto expansivo de la política fiscal.

## Replicación en R
- **Qué se replicó:** Estimación econométrica de un modelo VAR tri-variado (brecha de producto $y$, inflación $\pi$, tasa de interés $i$) con $p = 2$ rezagos e identificación recursiva de Cholesky ($y \to \pi \to i$), correspondiente al marco canónico de Sims (1980) y Christiano, Eichenbaum y Evans (1999), analizado bajo la regla sistemática de Sargent (1979).
- **Con qué datos:** Proceso generador de datos (DGP) macroeconómico calibrado representativo de 200 trimestres con dinámica realista de Curva IS, Curva de Phillips con inercia y Regla de Taylor con expectativas racionales.
- **Resultados obtenidos:** Un shock contractivo de política monetaria de +100 puntos básicos (+1.0%) genera una respuesta contractiva del producto real que alcanza su piso en el segundo trimestre ($h = 2$) con una caída de $-0.49\%$, disipándose gradualmente hacia el octavo trimestre. La inflación responde con mayor inercia, alcanzando su mínimo en el cuarto trimestre ($h = 4$) con una reducción de $-0.19\%$, sin presentar *price puzzle*. La descomposición de varianza (FEVD) ratifica el hallazgo empírico seminal de Sims: las perturbaciones monetarias no anticipadas explican solo el $12.4\%$ de la varianza del producto y el $4.2\%$ de la inflación, demostrando que la acción estabilizadora del banco central opera mayoritariamente a través de su regla de respuesta sistemática.
- **Limitaciones:** El ordenamiento recursivo de Cholesky asume que el producto y la inflación no responden contemporáneamente dentro del mismo trimestre al shock de tasa. Extensiones modernas utilizan restricciones de signos (Uhlig, 2005) o variables instrumentales externas (*proxy SVAR*, Stock y Watson, 2012).

## Para profundizar
- Sims, C. A. (1980). *Macroeconomics and Reality*. `sims1980macroeconomics`.
- Sargent, T. J., & Wallace, N. (1975). *'Rational' Expectations, the Optimal Monetary Instrument, and the Optimal Money Supply Rule*. `sargent_wallace1975`.
- Sargent, T. J. (1979). *Macroeconomic Theory*. `sargent1979macroeconomic`.
- Sims, C. A. (1986). *Are Forecasting Models Usable for Policy Analysis?*. `sims1986forecasting`.
- Sargent, T. J. (1987). *Dynamic Macroeconomic Theory*. `sargent1987dynamic`.
- Royal Swedish Academy of Sciences (2011). *Empirical Research on Cause and Effect in the Macroeconomy (Scientific Background)*. `nobel2011scientific`.

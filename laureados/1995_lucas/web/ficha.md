---
anio: 1995
slug: 1995_lucas
laureados: ["Robert E. Lucas Jr."]
motivacion_oficial: "for having developed and applied the hypothesis of rational expectations, and thereby having transformed macroeconomic analysis and deepened our understanding of economic policy"
area: ["Macroeconomía", "Expectativas Racionales", "Econometría Teórica y Crecimiento"]
tags: ["expectativas racionales", "crítica de Lucas", "modelo de islas", "extracción de señal", "curva de Phillips", "capital humano", "paradoja de Lucas"]
referencias_clave: ["lucas1972expectations", "lucas1973international", "lucas1976econometric", "lucas1988mechanics", "lucas1990capital", "nobel1995scientific"]
replicacion: "laureados/1995_lucas/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Robert E. Lucas Jr. transformó por completo los cimientos de la macroeconomía moderna al demostrar que los agentes económicos forman expectativas racionales sobre el futuro y que los parámetros de los modelos macroeconométricos tradicionales cambian cuando se alteran las políticas públicas, obligando a fundar el análisis económico en microfundamentos estructurales e invarianza de reglas.

## Resumen de la investigación
A finales de la década de 1960 y principios de 1970, la macroeconomía dominante descansaba en modelos keynesianos a gran escala que postulaban la existencia de una relación de intercambio (*trade-off*) permanente y predecible entre inflación y desempleo a lo largo de la curva de Phillips. Las autoridades económicas creían contar con un "menú" estático mediante el cual podían comprar menor desempleo a costa de tolerar una inflación sistemáticamente más elevada. Además, dichos modelos trataban a los consumidores, empresas y trabajadores como agentes pasivos cuyas expectativas se ajustaban mecánicamente a partir del pasado (*expectativas adaptativas*).

Robert E. Lucas Jr. dinamitó este consenso teórico y metodológico. Partiendo de la hipótesis de expectativas racionales planteada originalmente por John Muth (1961), Lucas demostró que los agentes económicos utilizan de manera eficiente toda la información disponible, incluyendo el conocimiento sobre las propias reglas y objetivos que guían a las autoridades económicas.

En una serie de artículos seminales, Lucas reformuló la disciplina:
1. En su **Modelo de las Islas (Lucas 1972, 1973)**, demostró que las correlaciones empíricas de corto plazo entre dinero, inflación y producto real emergen de problemas de información incompleta (extracción de señal): los productores en mercados aislados confunden temporalmente un shock monetario agregado con un aumento en la demanda relativa de su propio producto. Cuando la volatilidad monetaria se incrementa, los agentes aprenden a descontar la inflación general y la curva de Phillips se vuelve completamente vertical.
2. En su célebre **Crítica de Lucas (Lucas 1976)**, probó que los parámetros de las ecuaciones de regresión estimadas con datos históricos no son invariantes a modificaciones en las reglas de política pública. Cuando el gobierno altera su comportamiento sistemático, los agentes optimizadores adaptan sus reglas de decisión, alterando los parámetros del modelo econométrico y haciendo fracasar cualquier intento de ingeniería social basado en correlaciones pasadas.
3. En el ámbito del desarrollo económico, Lucas (1988, 1990) introdujo el **capital humano con externalidades** como motor del crecimiento endógeno y formuló la célebre **Paradoja de Lucas**, cuestionando por qué el capital global no se desplaza en masa hacia los países pobres según lo predicho por los modelos neoclásicos estándar.

## Metodología y resultados
1. **El Problema de Extracción de Señal de Lucas (1972, 1973):**
   Lucas modeló productores distribuidos en mercados o islas competitivas donde el precio local $p_i = p + z_i$ contiene un shock general de precios ($p \sim \mathcal{N}(\bar{p}, \sigma_p^2)$) y un shock idiosincrásico de preferencia real ($z_i \sim \mathcal{N}(0, \sigma_z^2)$). Mediante proyección lineal condicional, derivó el coeficiente de extracción de señal:
   $$\theta = \frac{\sigma_z^2}{\sigma_z^2 + \sigma_p^2} \in (0, 1)$$
   y la oferta agregada de la economía:
   $$y_t = y_n + \gamma \theta (p_t - \bar{p})$$
   Lucas demostró empíricamente con datos de 18 países que en economías con alta varianza de demanda nominal (como Argentina), $\theta \to 0$ y la curva de Phillips es vertical; mientras que en países con política monetaria estable (como Estados Unidos), $\theta \to 1$ y existe una respuesta temporal del producto real ante sorpresas no anticipadas.

2. **La Crítica de Lucas y la No Invarianza de Parámetros (1976):**
   Bajo una curva de oferta estructural de sorpresas $y_t = y_n + \beta (\pi_t - \mathbb{E}_{t-1}[\pi_t]) + \varepsilon_t$ y una regla monetaria $\pi_t = \mu + \rho \pi_{t-1} + v_t$, Lucas probó que la pendiente estimada por un econometrista tradicional en una regresión $y_t = a + b \pi_t + u_t$ es:
   $$b(\rho) = \beta (1 - \rho^2)$$
   Si el gobierno intenta explotar el parámetro $b > 0$ elevando la persistencia y la tasa sistemática de emisión monetaria ($\rho \to 1$), los agentes racionales ajustan instantáneamente sus expectativas ($\mathbb{E}_{t-1}[\pi_t] = \mu + \rho \pi_{t-1}$). En consecuencia, la sorpresa sigue siendo únicamente el shock no anticipado $v_t$, el producto medio no aumenta en lo absoluto ($\mathbb{E}[y] = y_n$) y el coeficiente empírico $b$ colapsa hacia cero.

3. **Crecimiento Endógeno y la Paradoja de los Flujos de Capital (1988, 1990):**
   Lucas demostró que el producto marginal del capital en un modelo neoclásico sin ajustes debería ser unas 58 veces mayor en países pobres como la India que en Estados Unidos. Probó que la ausencia de flujos masivos de capital se debe a la menor dotación de capital humano efectivo, a externalidades del conocimiento tecnológico y al riesgo institucional de expropiación.

## Antes y después

### Antes
- **Modelos macroeconométricos de ecuaciones simultáneas ad-hoc:** Sistemas con cientos de ecuaciones (modelos Klein-Goldberger, Brookings, Wharton) cuyos parámetros se estimaban asumiendo implícitamente que la conducta privada no reaccionaría ante cambios drásticos de régimen fiscal o monetario.
- **Expectativas adaptativas y mecanicistas:** Se concebía a familias y firmas como autómatas que proyectaban el futuro como un promedio ponderado retrasado de variables pasadas, permitiendo que el Estado las engañara de manera sistemática e indefinida.
- **La curva de Phillips como menú de política permanente:** Los planificadores económicos creían poder escoger a voluntad combinaciones estables de mayor inflación para lograr menor desempleo.

### Después
- **Exigencia de microfundamentos estructurales:** La macroeconomía se refundó sobre la base de decisiones optimizadoras intertemporales de hogares y empresas basadas en preferencias profundas (parámetros de aversión al riesgo y paciencia) y restricciones tecnológicas invariantes, dando origen directo a los modelos de ciclos económicos reales (RBC) y modelos dinámicos estocásticos de equilibrio general (DSGE).
- **Invarianza de parámetros y evaluación rigurosa de políticas:** Quedó establecido que para simular el impacto de una reforma institucional o una regla de política monetaria, los economistas deben modelar explícitamente cómo cambiarán las expectativas y reglas de decisión de los agentes.
- **Primacía de las reglas creíbles y la transparencia:** Las políticas discrecionales que intentan generar sorpresas sistemáticas quedaron desacreditadas; la estabilidad macroeconómica pasó a depender de compromisos institucionales transparentes, bancos centrales independientes y anclaje de expectativas.

## Cómo se aplica hoy

1. **Diseño y Calibración de Modelos DSGE en la Reserva Federal y el Banco Central Europeo (BCE):**
   Todos los bancos centrales líderes han incorporado la Crítica de Lucas en su instrumental nuclear. La Reserva Federal de Estados Unidos utiliza la plataforma de modelación [FRB/US](https://www.federalreserve.gov/econres/us-models-about.htm) y el modelo DSGE [SIGMA](https://www.federalreserve.gov/pubs/ifdp/2005/835/ifdp835.pdf) para evaluar reformas de política monetaria imponiendo expectativas racionales y parámetros estructurales profundos de tecnología y preferencias. De igual forma, el Banco Central Europeo emplea el modelo estructural [NAWM II (New Area-Wide Model)](https://www.ecb.europa.eu/pub/pdf/scpwps/ecb.wp2200~a56b607ce1.en.pdf) para simular escenarios de desinflación sin cometer el error de proyectar parámetros de forma reducida pasados.

2. **Adopción Global del Régimen de Metas de Inflación (*Inflation Targeting*) y la Autonomía de Bancos Centrales:**
   La conclusión de Lucas de que las políticas monetarias predecibles y sistemáticas no causan distorsiones ni sorpresas innecesarias motivó la transición internacional hacia mandatos de estabilidad de precios basados en reglas y credibilidad institucional. Pioneros como el Banco de Inglaterra (otorgamiento de independencia operativa en mayo de 1997), el Riksbank de Suecia (1993) y el Banco Central de Reserva del Perú (autonomía constitucional de 1993 y esquema formal de metas explícitas de inflación desde 2002; [BCRP - Metas de Inflación](https://www.bcrp.gob.pe/politica-monetaria/esquema-de-metas-de-inflacion.html)) operan comunicando pronósticos y reglas transparentes para anclar las expectativas racionales del sector privado a su meta del 2.0% anual.

3. **Políticas de Capital Humano e Inversión Extranjera en el Banco Mundial y el FMI:**
   La Paradoja de Lucas (1990) y su modelo de capital humano (1988) guían los diagnósticos de desarrollo del Banco Mundial. En 2018, el Banco Mundial lanzó formalmente el [Índice de Capital Humano (Human Capital Project)](https://www.worldbank.org/en/publication/human-capital), que cuantifica cómo las brechas de conocimiento y salud explican las diferencias de productividad total de los factores y la rentabilidad del capital entre economías desarrolladas y emergentes, confirmando la tesis de Lucas de que los flujos de inversión privada no viajan automáticamente si las instituciones y el capital humano local no actúan como complementos indispensables.

## Replicación en R
- **Qué se replicó:** Se implementó una simulación numérica computacional y montecarlo de los dos pilares macroeconómicos de Robert Lucas:
  1. El problema de extracción de señal de Lucas (1972, 1973) para tres regímenes internacionales de volatilidad nominal ($\sigma_p \in \{0.5, 2.0, 6.0\}$), calculando la sensibilidad analítica $\theta$ y la pendiente de la curva de Phillips.
  2. La demostración formal de la Crítica de Lucas (1976), modelando una economía de sorpresas monetarias bajo expectativas racionales y evaluando el cambio de una regla histórica moderada ($\rho_1 = 0.25$) a una regla expansiva agresiva ($\rho_2 = 0.85$).
- **Con qué datos:** Datos sintéticos generados a partir de los procesos estocásticos teóricos estructurales calibrados ($T = 500$ para extracción de señal; $T = 500$ divididos en dos regímenes de 250 periodos para la Crítica de Lucas).
- **Resultados obtenidos:**
  - En el modelo de islas, la elasticidad de oferta $\theta$ cae de $0.941$ en el régimen de baja volatilidad a $0.100$ en el régimen de alta inestabilidad monetaria, reproduciendo de manera exacta la hipótesis de varianza de Lucas (1973): a mayor ruido nominal, la curva de Phillips empírica se vuelve vertical ($\alpha = 0.101$).
  - En la simulación de la Crítica de Lucas, el parámetro de forma reducida estimado por regresión colapsa de $b_1 = 1.391$ a $b_2 = 0.028$ tras el cambio de régimen. La proyección ingenua del modelo econométrico tradicional anticipaba un crecimiento ficticio del producto a $205.1$ puntos; en la realidad, el producto medio se mantuvo rígidamente en su nivel natural de $100.02$, generando únicamente un estallido inflacionario del $80\%$ y evidenciando el colapso empírico de las políticas discrecionales.

## Para profundizar
- Lucas, R. E., Jr. (1972). "Expectations and the Neutrality of Money". *Journal of Economic Theory*, 4(2), 103–124.
- Lucas, R. E., Jr. (1973). "Some International Evidence on Output-Inflation Tradeoffs". *The American Economic Review*, 63(3), 326–334.
- Lucas, R. E., Jr. (1976). "Econometric Policy Evaluation: A Critique". *Carnegie-Rochester Conference Series on Public Policy*, 1, 19–46.
- Lucas, R. E., Jr. (1988). "On the Mechanics of Economic Development". *Journal of Monetary Economics*, 22(1), 3–42.
- Lucas, R. E., Jr. (1990). "Why Doesn't Capital Flow from Rich to Poor Countries?". *The American Economic Review*, 80(2), 92–96.
- The Royal Swedish Academy of Sciences (1995). "Scientific Background on the Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 1995: Robert E. Lucas, Jr. and the Rational Expectations Hypothesis".

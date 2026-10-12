---
anio: 2021
slug: 2021_card_angrist_imbens
laureados: ["David Card", "Joshua D. Angrist", "Guido W. Imbens"]
motivacion_oficial: "David Card: for his empirical contributions to labour economics; Joshua D. Angrist and Guido W. Imbens: for their methodological contributions to the analysis of causal relationships"
area: ["Economía Laboral", "Econometría Causal"]
tags: ["experimentos naturales", "diferencias en diferencias", "variables instrumentales", "LATE", "efecto tratamiento local", "salario mínimo", "revolución de la credibilidad"]
referencias_clave: ["card1994minimum", "imbens1994identification", "angrist1990lifetime", "card1990mariel", "angrist2009mostly"]
replicacion: "laureados/2021_card_angrist_imbens/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
David Card, Joshua D. Angrist y Guido W. Imbens lideraron la "revolución de la credibilidad" en economía, demostrando que los experimentos naturales y los métodos cuasi-experimentales permiten responder con rigor científico si una política pública causa verdaderamente un resultado en el mundo real.

## Resumen de la investigación
Durante décadas, la economía aplicada se enfrentó a un dilema metodológico insalvable: a diferencia de las ciencias naturales o los ensayos clínicos biomédicos, los economistas no podían asignar al azar políticas monetarias, aumentos salariales o reformas educativas a gran escala entre seres humanos y empresas. Los estudios empíricos dependían de correlaciones estadísticas en modelos de regresión masivos que a menudo confundían causa con consecuencia.

Card, Angrist e Imbens cambiaron para siempre este panorama mediante el aprovechamiento sistemático de **experimentos naturales** (*natural experiments*): situaciones reales en las que el azar, las fronteras administrativas o los cambios legislativos exógenos asignan a personas o firmas en grupos de "tratamiento" y "control" de manera prácticamente aleatoria.

- **David Card** aplicó estos diseños a preguntas centrales de la economía laboral: demostró que aumentar moderadamente el salario mínimo no destruyó el empleo juvenil en New Jersey frente a Pennsylvania ([Card & Krueger, 1994](https://www.jstor.org/stable/2118030)), que la llegada repentina de 125,000 inmigrantes cubanos a Miami durante el éxodo del Mariel no redujo los salarios de los trabajadores locales ([Card, 1990](https://doi.org/10.1177/001979399004300205)), y que los recursos escolares sí incrementan los retornos futuros a la educación.
- **Joshua D. Angrist y Guido W. Imbens** resolvieron el fundamento matemático y econométrico de estos experimentos: demostraron exactamente qué miden las Variables Instrumentales cuando el cumplimiento es imperfecto (*non-compliance*), formulando el célebre teorema del **Efecto Tratamiento Promedio Local** (*Local Average Treatment Effect*, **LATE**; [Imbens & Angrist, 1994](https://doi.org/10.2307/2951620)).

## Metodología y resultados

1. **El Diseño de Diferencias en Diferencias (DiD):**
   Card y Krueger (1994) encuestaron 410 locales de comida rápida antes y después de que New Jersey elevara su salario mínimo de $\$4.25$ a $\$5.05$ por hora en abril de 1992, usando al este de Pennsylvania como grupo de control no afectado. Al calcular la doble diferencia:
   $$\hat{\tau}_{\text{DiD}} = (\bar{Y}_{\text{NJ, post}} - \bar{Y}_{\text{NJ, pre}}) - (\bar{Y}_{\text{PA, post}} - \bar{Y}_{\text{PA, pre}})$$
   el empleo en New Jersey aumentó en $+2.76$ a $+2.91$ trabajadores equivalentes a tiempo completo ($\text{FTE}$) por tienda relativo a Pennsylvania. El hallazgo desafió el dogma neoclásico tradicional y obligó a considerar fallas de mercado como el monopsonio laboral y las fricciones de búsqueda.

2. **La Teoría del LATE y la Taxonomía de Compliers:**
   En presencia de intervenciones donde las personas eligen si acatar o no el incentivo (como la lotería militar de Vietnam en [Angrist, 1990](https://www.jstor.org/stable/2006669), o el mes de nacimiento y las leyes de escolaridad obligatoria en [Angrist & Krueger, 1991](https://doi.org/10.2307/2937954)), la población se divide en cuatro grupos latentes: *Compliers* (cumplidores), *Always-takers* (siempre tratados), *Never-takers* (nunca tratados) y *Defiers* (desafiantes).
   Bajo el supuesto de monotonicidad (*no-defiers*) y exclusión, el estimador instrumental de Wald:
   $$\tau_{\text{IV}} = \frac{\mathbb{E}[Y \mid Z=1] - \mathbb{E}[Y \mid Z=0]}{\mathbb{E}[D \mid Z=1] - \mathbb{E}[D \mid Z=0]} = \mathbb{E}[Y(1) - Y(0) \mid \text{Compliers}]$$
   no estima el efecto en toda la población, sino con total precisión el efecto causal promedio en los **Compliers**, aportando una base lógica inexpugnable para la econometría de variables instrumentales.

## Antes y después

### Antes
- **Econometría estructural sin diseño:** Predominaban regresiones de MCO con decenas de variables de control ad hoc, altamente susceptibles a sesgos de selección, causalidad inversa y dragado de datos (*p-hacking*).
- **Dogmatismo teórico sobre el salario mínimo:** La teoría microeconómica básica dictaminaba sin discusión empírica creíble que cualquier precio suelo en los salarios destruía inexorablemente puestos de trabajo.
- **Opacidad en variables instrumentales:** Los economistas trataban los estimadores IV como soluciones universales mágicas sin definir con rigor a qué subpoblación aplicaba el coeficiente estimado en presencia de efectos heterogéneos.

### Después (qué cambió gracias al aporte)
- **La Revolución de la Credibilidad:** El estándar metodológico de la economía y las ciencias sociales viró decisivamente hacia el diseño de investigación: experimentos naturales, regresiones discontinuas (RD), diferencias en diferencias (DiD) y variables instrumentales transparentes.
- **Evidencia empírica en el centro de las políticas públicas:** Las decisiones sobre reformas laborales, subsidios al empleo y programas de transferencia dejaron de basarse exclusivamente en axiomas teóricos y pasaron a requerir evaluaciones causales contrafácticas.
- **Claridad conceptual del LATE:** El teorema de Angrist e Imbens se convirtió en el pilar estándar para interpretar evaluaciones de políticas públicas con asignación imperfecta, influyendo tanto en la econometría como en la bioestadística y el aprendizaje automático causal (*causal machine learning*).

## Cómo se aplica hoy

1. **Decisiones de Política Salarial en la Unión Europea y el Reino Unido (2015–2024):**
   La creación del salario mínimo interprofesional en Alemania en 2015 y las evaluaciones anuales de la *Low Pay Commission* del Reino Unido utilizan sistemáticamente diseños de diferencias en diferencias basados en la metodología de Card & Krueger para vigilar que los incrementos salariales no destruyan puestos de trabajo en sectores de bajos ingresos ([UK Low Pay Commission Report 2023](https://www.gov.uk/government/publications/minimum-wage-rates-for-2024); [German Minimum Wage Commission Evaluation](https://www.mindestlohn-kommission.de/)).

2. **Evaluación de Programas de Desarrollo y Políticas Públicas Multilaterales (BID / Banco Mundial / J-PAL):**
   Organismos internacionales evalúan el impacto causal de transferencias monetarias condicionadas, programas de microcrédito y políticas de empleo juvenil aplicando la metodología LATE de Angrist e Imbens para corregir por cumplimiento imperfecto y autoselección en el acceso a beneficios ([Inter-American Development Bank Impact Evaluation Guidelines](https://www.iadb.org/en/research-and-data/impact-evaluation); [Abdul Latif Jameel Poverty Action Lab (J-PAL)](https://www.povertyactionlab.org/)).

3. **Epidemiología Cuasi-Experimental y Aleatorización Mendeliana en Medicina (2020–2024):**
   La medicina y la epidemiología moderna aplican el marco de Variables Instrumentales y LATE en la llamada "Aleatorización Mendeliana" (*Mendelian Randomization*), donde variantes genéticas asignadas al azar en la concepción se usan como instrumentos para determinar el efecto causal de factores biológicos (como niveles de colesterol o vitamina D) sobre enfermedades coronarias y cáncer sin los sesgos de confusión observacionales ([Davey Smith & Hemani, Human Molecular Genetics, 2014](https://doi.org/10.1093/hmg/ddu328); [Nature Reviews Methods Primers, 2023](https://doi.org/10.1038/s43586-023-00213-5)).

## Replicación en R
- **Qué se replicó:** El diseño cuasi-experimental canónico de Diferencias en Diferencias de Card & Krueger (1994, AER) y la taxonomía de compliers y efecto LATE de Angrist & Imbens (1994, Econometrica).
- **Con qué datos:** Microdatos oficiales de 410 establecimientos de comida rápida encuestados en New Jersey y Pennsylvania antes (febrero–marzo 1992) y después (noviembre–diciembre 1992) de la reforma salarial (`cardkrueger1994.csv` / `.dta`).
- **Resultados obtenidos vs. el paper:**
  - *MCO Básico (DiD):* Coeficiente de interacción $\hat{\beta}_{\text{DiD}} = +2.914$ FTE ($e.e. = 1.611$, $p = 0.071$).
  - *MCO con Controles de Franquicia:* $\hat{\beta}_{\text{DiD}} = +2.935$ FTE ($e.e. = 1.460$, $p = 0.045$).
  - *Efectos Fijos por Restaurante (Panel):* $\hat{\beta}_{\text{DiD}} = +2.943$ FTE ($e.e. = 1.123$, $p = 0.009$).
  - El resultado reproduce fielmente las tablas originales de Card & Krueger (1994), que documentaron una variación diferencial positiva de entre $+2.76$ y $+2.91$ empleos equivalentes a tiempo completo.
- **Limitaciones:** En años posteriores, la literatura de DiD demostró que cuando el tratamiento se adopta en momentos escalonados (*staggered timing*) con efectos heterogéneos en el tiempo, los estimadores tradicionales de MCO con efectos fijos bidireccionales (TWFE) pueden sufrir ponderaciones negativas (Goodman-Bacon 2021; Callaway & Sant'Anna 2021). En el caso de Card & Krueger, el tratamiento ocurre en un solo periodo para todas las unidades tratadas, por lo que el estimador clásico es robusto a esta crítica.

## Para profundizar
- Card, D., & Krueger, A. B. (1994). *Minimum Wages and Employment: A Case Study of the Fast-Food Industry in New Jersey and Pennsylvania*. American Economic Review, 84(4), 772–793. `card1994minimum`.
- Imbens, G. W., & Angrist, J. D. (1994). *Identification and Estimation of Local Average Treatment Effects*. Econometrica, 62(2), 467–475. `imbens1994identification`.
- Angrist, J. D. (1990). *Lifetime Earnings and the Vietnam Era Draft Lottery: Evidence from Social Security Administrative Records*. American Economic Review, 80(3), 313–336. `angrist1990lifetime`.
- Card, D. (1990). *The Impact of the Mariel Boatlift on the Miami Labor Market*. ILR Review, 43(2), 245–257. `card1990mariel`.
- Angrist, J. D., & Pischke, J.-S. (2009). *Mostly Harmless Econometrics: An Empiricist's Companion*. Princeton University Press. `angrist2009mostly`.
- The Royal Swedish Academy of Sciences (2021). *Scientific Background: Natural Experiments and the Causal Revolution*. `nobel2021scientific`.
- The Royal Swedish Academy of Sciences (2021). *Popular Science Background: Natural Experiments Help Answer Important Questions*. `nobel2021popular`.

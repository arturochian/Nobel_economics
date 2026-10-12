---
anio: 2010
slug: 2010_diamond_mortensen_pissarides
laureados: ["Peter A. Diamond", "Dale T. Mortensen", "Christopher A. Pissarides"]
motivacion_oficial: "for their analysis of markets with search frictions"
area: ["Macroeconomía Laboral", "Economía de la Búsqueda y Emparejamiento"]
tags: ["modelo DMP", "fricciones de búsqueda", "curva de Beveridge", "función de emparejamiento", "negociación de salarios de Nash", "seguro de desempleo", "tensión del mercado laboral"]
referencias_clave: ["diamond1971model", "mortensen1982property", "pissarides1985short", "mortensen1994creation", "pissarides2000equilibrium", "hosios1990efficiency", "nobel2010scientific"]
replicacion: "laureados/2010_diamond_mortensen_pissarides/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Peter Diamond, Dale Mortensen y Christopher Pissarides transformaron la macroeconomía y la economía laboral al formular el modelo DMP, explicando por qué conviven el desempleo y las vacantes sin cubrir debido a los costos y el tiempo necesarios para que trabajadores y empresas se encuentren, negocien y formalicen un empleo.

## Resumen de la investigación
En la teoría económica tradicional de equilibrio competitivo (el modelo walrasiano), los mercados funcionan como subastas perfectas e instantáneas: compradores y vendedores coinciden sin costo, los precios ajustan de inmediato y la oferta iguala a la demanda. Bajo esa visión, resultaba una paradoja inexplicable que en el mundo real coexistieran millones de personas desempleadas buscando empleo con miles de empresas quejándose de vacantes que no lograban cubrir.

A partir de finales de la década de 1960 y durante los años setenta, **Peter A. Diamond** demostró que la introducción de fricciones de búsqueda aparentemente minúsculas (*search frictions*) altera de forma radical el funcionamiento de los mercados. En su trabajo seminal de 1971, probó que si los compradores enfrentan costos mínimos para consultar precios en otras tiendas, la competencia de precios colapsa y las empresas cobran el precio de monopolio (la célebre "paradoja de Diamond"). Esto reveló que las fricciones otorgan poder de mercado bilateral y crean rentas que deben ser negociadas.

Posteriormente, **Dale T. Mortensen** y **Christopher A. Pissarides** desarrollaron la arquitectura dinámica completa del mercado laboral. Mortensen (1982) estudió cómo se coordinan los agentes descentralizados y cómo surgen externalidades de congestión entre quienes buscan emparejarse. Pissarides (1985, 2000) introdujo la **función agregada de emparejamiento** (*matching function*), que resume la tecnología con la que se conectan vacantes y desempleados, e incorporó la negociación salarial de Nash y la condición de libre entrada de vacantes de las firmas. Juntos, en Mortensen y Pissarides (1994), formularon el **modelo DMP** (*Diamond-Mortensen-Pissarides*), que integra la creación y destrucción endógena de empleo bajo choques agregados y sectoriales de productividad.

El modelo DMP se convirtió en el caballo de batalla canónico de la macroeconomía laboral. Proporcionó una explicación rigurosa a la **Curva de Beveridge** (la relación empírica negativa entre desempleo y vacantes) y dotó a los bancos centrales y gobiernos de una herramienta científica para distinguir si un aumento del desempleo responde a una recesión cíclica o a desajustes estructurales de cualificaciones.

## Metodología y resultados

El modelo canónico DMP articula tres bloques teóricos interconectados en tiempo continuo:

1. **La Función Agregada de Emparejamiento y la Tensión Laboral:**
   Las contrataciones mensuales $M$ dependen del número de desempleados $u$ y de las vacantes publicadas $v$ mediante una función Cobb-Douglas con rendimientos constantes a escala:
   $$M(u, v) = \mu u^{\alpha} v^{1-\alpha}$$
   donde $\mu > 0$ refleja la eficiencia del emparejamiento y $\alpha \in (0, 1)$ es la elasticidad respecto al desempleo.
   Definiendo la **tensión del mercado laboral** como $\theta = v / u$, la tasa a la que un desempleado encuentra empleo es $f(\theta) = M/u = \mu \theta^{1-\alpha}$ (creciente en $\theta$), y la tasa a la que una empresa cubre una vacante es $q(\theta) = M/v = \mu \theta^{-\alpha}$ (decreciente en $\theta$).

2. **La Curva de Beveridge (Dinámica de Flujos de Empleo):**
   Con una tasa exógena de separación laboral $\delta$, la variación del desempleo sigue:
   $$\dot{u} = \delta(1 - u) - f(\theta) u$$
   En estado estacionario ($\dot{u} = 0$), el desempleo de equilibrio es:
   $$u^* = \frac{\delta}{\delta + \mu (\theta^*)^{1-\alpha}}$$
   Sustituyendo $\theta = v/u$, se obtiene la relación negativa entre vacantes y desempleo:
   $$v(u) = u \left[ \frac{\delta(1 - u)}{\mu u} \right]^{\frac{1}{1-\alpha}}$$
   Las fluctuaciones de productividad mueven la economía **a lo largo** de la curva; los cambios estructurales en la eficiencia de matching $\mu$ (por obsolescencia de habilidades o barreras geográficas) **desplazan** la curva hacia afuera.

3. **Condición de Creación de Empleo (Libre Entrada de Vacantes - JC):**
   Mantener una vacante abierta cuesta $c > 0$ por período. Las empresas abren vacantes hasta que su valor esperado neto se anula ($V = 0$):
   $$\frac{p - w}{r + \delta} = \frac{c}{q(\theta)} \iff p - w = \frac{(r + \delta)c}{\mu \theta^{-\alpha}}$$
   donde $p$ es la productividad marginal del trabajador, $w$ es el salario real y $r$ es la tasa de descuento.

4. **Negociación Salarial de Nash (Curva Salarial - WC):**
   Debido a las fricciones, el empleo genera una renta compartida. Trabajador y empresa resuelven un problema de Nash generalizado con poder de negociación $\beta \in (0, 1)$, arrojando:
   $$w = (1 - \beta) z + \beta (p + c \theta)$$
   donde $z$ es el valor de reserva del desempleado (prestación de desempleo y valor del ocio).

5. **Equilibrio Macroeconómico y la Regla de Hosios (1990):**
   Sustituyendo $w$ en la condición de vacantes se determina el valor único de $\theta^*$:
   $$(1 - \beta)(p - z) = c \left[ \beta \theta + \frac{r + \delta}{\mu} \theta^\alpha \right]$$
   Arthur Hosios (1990) demostró que el equilibrio de mercado descentralizado coincide con el óptimo social de un planificador benevolente si y sólo si:
   $$\beta = \alpha$$
   (el poder de negociación del trabajador iguala la elasticidad del matching respecto al desempleo). Si $\beta > \alpha$, los salarios excesivos provocan subempleo; si $\beta < \alpha$, las empresas sobrecrean vacantes generando congestión destructiva.

## Antes y después

### Antes
- **Equilibrio Walrasiano sin fricciones:** El mercado laboral se concebía como una subasta sin costos de intermediación donde el salario real igualaba instantáneamente la oferta y la demanda, implicando que todo desempleo era enteramente voluntario.
- **Incapacidad para explicar la coexistencia de vacantes y desempleo:** La teoría macroeconómica estándar no podía fundamentar por qué un empleador dispuesto a contratar y un desempleado calificado no se vinculaban de inmediato.
- **Tratamiento estático del desempleo:** El desempleo se medía como un stock rígido en lugar de un proceso dinámico de flujos continuos de entrada (despidos, renuncias) y salida (contrataciones, retiros).
- **Visión ingenua del seguro de desempleo:** Se consideraba que las prestaciones por desempleo solo generaban desincentivos laborales simples, sin un marco para evaluar su impacto en el poder de negociación ni en la calidad del emparejamiento (*match quality*).

### Después (qué cambió gracias al aporte)
- **Consolidación del Modelo DMP como estándar de la macroeconomía laboral:** Se convirtió en el bloque indispensable de los modelos macroeconómicos dinámicos estocásticos de equilibrio general (DSGE) empleados por bancos centrales de todo el mundo.
- **Fundamentación microeconómica de la Curva de Beveridge:** Permitió descomponer cuantitativamente si el desempleo de una economía responde a insuficiencia de demanda agregada (movimiento a lo largo de la curva) o a desajuste de habilidades y fricciones institucionales (desplazamiento de la curva).
- **Diseño riguroso de políticas laborales:** Brindó el instrumental para calibrar la generosidad y duración óptima del seguro de desempleo, los costos de despido, los subsidios de contratación y el salario mínimo considerando externalidades de búsqueda.
- **Comprensión de las externalidades de congestión:** Se demostró que la búsqueda descentralizada genera fallas de coordinación (la entrada de un buscador perjudica a los demás del mismo lado del mercado y beneficia a los del lado opuesto), justificando la intervención pública activa.

## Cómo se aplica hoy

1. **Diagnóstico del Desajuste Laboral Post-COVID en la Reserva Federal de EE.UU. (2021–2024):**
   Tras la pandemia de COVID-19, la economía de EE.UU. experimentó simultáneamente una escasez aguda de trabajadores y un desplazamiento histórico hacia afuera de la curva de Beveridge (medido con datos del programa [JOLTS del Bureau of Labor Statistics](https://www.bls.gov/jlt/)). Los economistas de la Reserva Federal (como [Figura y Waller, 2022](https://www.federalreserve.gov/econres/notes/feds-notes/what-does-the-beveridge-curve-tell-us-about-the-likelihood-of-a-soft-landing-20220729.html)) y académicos como [Blanchard, Domash y Summers (2022)](https://www.piie.com/publications/policy-briefs/bad-news-fed-beveridge-curve-and-unemployment) utilizaron el modelo DMP para debatir si el endurecimiento monetario de la Fed podía enfriar las vacantes sin desatar un desempleo masivo (el llamado "aterrizaje suave").
2. **Diseño de Seguros de Desempleo Dependientes del Ciclo Económico en la OCDE (2020–2023):**
   Las directrices de la [OCDE sobre reformas a las prestaciones por desempleo](https://www.oecd.org/employment/job-creation-and-local-economic-development-21152026.htm) aplican los avances del modelo DMP extendido por [Landais, Michaillat y Saez (2018)](https://doi.org/10.1257/aer.20150838). Esta literatura demuestra que las prestaciones por desempleo deben expandirse en recesiones severas —cuando las vacantes escasean y el riesgo moral es insignificante— y endurecerse en auges con abundancia de puestos para acelerar la reincorporación laboral sin sobrecargar las finanzas públicas.
3. **Optimización de Algoritmos de Emparejamiento en Plataformas de Empleo Online (LinkedIn e Indeed, 2018–2024):**
   Plataformas globales de reclutamiento como [LinkedIn Economic Graph](https://economicgraph.linkedin.com/) e Indeed Hiring Lab utilizan directamente funciones de matching inspiradas en Mortensen y Pissarides para modelar la tensión laboral en tiempo real y mitigar la "congestión algorítmica" (donde miles de postulantes saturan un solo aviso mediante solicitudes automatizadas de un clic), rediseñando los sistemas de recomendación para maximizar la probabilidad bilateral de contratación exitosa.

## Replicación en R

En la carpeta [`replicacion/`](../replicacion/) se encuentra el código y el reporte Quarto [`replicar.qmd`](../replicacion/replicar.qmd) con una **simulación ilustrativa** del modelo DMP canónico:
- El script [`R/modelo_dmp_laboral.R`](../replicacion/R/modelo_dmp_laboral.R) calibra el modelo a frecuencia mensual (productividad base $p = 1.0$, subsidio $z = 0.70$, costo de vacante $c = 0.35$, separación $\delta = 3.5\%$, elasticidad $\alpha = 0.5$, poder $\beta = 0.5$).
- Resuelve analíticamente la tensión laboral de equilibrio $\theta^* \approx 0.745$, determinando un desempleo estacionario de $u^* = 6.33\%$ y una tasa de vacantes de $v^* = 4.72\%$.
- Genera y guarda en [`salidas/`](../replicacion/salidas/):
  - `fig_curva_beveridge_dmp.png`: Desplazamientos de la Curva de Beveridge comparando fluctuaciones cíclicas de productividad frente a choques estructurales de desajuste de habilidades ($\mu = 0.45$).
  - `fig_equilibrio_dmp_tension.png`: Panel dual que ilustra la condición de libre entrada de vacantes y la intersección con la curva de Beveridge en el espacio $(u, v)$.
  - `tab_resultados_dmp.csv`: Tabla cuantitativa con 8 escenarios de estática comparativa (recesión, expansión, alza en prestaciones por desempleo, encarecimiento de vacantes y ruptura de la regla de Hosios).

## Para profundizar
- **Diamond, P. A. (1971):** *A Model of Price Adjustment*. Journal of Economic Theory, 3(2), 156-168. [DOI: 10.1016/0022-0531(71)90013-5](https://doi.org/10.1016/0022-0531(71)90013-5).
- **Mortensen, D. T. (1982):** *Property Rights and Efficiency of Mating, Race, and Related Games*. The American Economic Review, 72(5), 968-979. [JSTOR: 1812022](https://www.jstor.org/stable/1812022).
- **Pissarides, C. A. (1985):** *Short-Run Equilibrium Dynamics of Unemployment, Vacancies, and Real Wages*. The American Economic Review, 75(4), 676-690. [JSTOR: 1821360](https://www.jstor.org/stable/1821360).
- **Mortensen, D. T., & Pissarides, C. A. (1994):** *Job Creation and Job Destruction in the Theory of Unemployment*. The Review of Economic Studies, 61(3), 397-415. [DOI: 10.2307/2297896](https://doi.org/10.2307/2297896).
- **Pissarides, C. A. (2000):** *Equilibrium Unemployment Theory* (2nd ed.). MIT Press.
- **Hosios, A. J. (1990):** *On the Efficiency of Matching and Related Models of Search and Unemployment*. The Review of Economic Studies, 57(2), 279-298. [DOI: 10.2307/2297542](https://doi.org/10.2307/2297542).
- **Royal Swedish Academy of Sciences (2010):** *Markets with Search Frictions: Scientific Background*. [nobelprize.org](https://www.nobelprize.org/uploads/2018/06/advanced-economicsciences2010.pdf).

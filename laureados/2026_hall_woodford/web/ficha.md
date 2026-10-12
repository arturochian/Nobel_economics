---
anio: 2026
slug: 2026_hall_woodford
laureados: ["Robert E. Hall", "Michael Woodford"]
motivacion_oficial: "for microeconomic foundations of macroeconomic stabilisation"
area: ["Macroeconomía", "Política Monetaria"]
tags: ["Nuevo Keynesiano", "microfundamentos", "regla de Taylor", "caminata aleatoria del consumo", "estabilización macroeconómica"]
referencias_clave: ["hall1978stochastic", "rotemb_woodford1997", "woodford2003interest", "woodford2001taylor", "hall2005employment"]
replicacion: "laureados/2026_hall_woodford/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Robert E. Hall y Michael Woodford revolucionaron la macroeconomía moderna al fundamentar la política de estabilización en decisiones microeconómicas rigurosas de familias y empresas con expectativas racionales y rigideces nominales.

## Resumen de la investigación
Tras el colapso de los modelos macroeconómicos keynesianos tradicionales durante los episodios de estanflación de la década de 1970, la disciplina enfrentó la célebre Crítica de Lucas: era imposible predecir el impacto de las políticas públicas basándose únicamente en relaciones estadísticas históricas entre agregados (PIB, consumo global, inflación agregada), porque las personas y las empresas modifican sus conductas y expectativas ante cambios en las reglas del juego.

Robert E. Hall sentó las bases de la moderna teoría del consumo y del mercado laboral. En su trabajo seminal de 1978 (*Journal of Political Economy*), demostró que, bajo expectativas racionales y optimización intertemporal, el consumo sigue una caminata aleatoria (*random walk*): las familias suavizan su consumo a lo largo de su ciclo de vida y solo la información imprevista altera sus decisiones. Posteriormente, Hall (1980, 2005) demostró cómo las rigideces salariales de equilibrio amplifican drásticamente las fluctuaciones del empleo sin generar destrucciones ineficientes de puestos de trabajo.

Michael Woodford, por su parte, construyó el edificio teórico del marco Nuevo Keynesiano moderno, coronado en su monumental tratado *Interest and Prices* (2003). Woodford demostró cómo un banco central que opera en una economía con dinero fiduciario puro puede controlar de forma óptima la inflación y estabilizar el ciclo económico gestionando las expectativas de tasas de interés a futuro mediante reglas sistemáticas de política monetaria (como la regla de Taylor y la orientación hacia adelante o *forward guidance*).

## Metodología y resultados
La metodología compartida por ambos laureados descansa en los modelos de equilibrio general dinámico estocástico (DSGE por sus siglas en inglés):
1. **Microfundamentos del Consumo y Demanda:** Cada hogar resuelve un problema de optimización intertemporal, eligiendo consumo presente versus ahorro futuro sujeto a su restricción presupuestaria intertemporal, generando la curva IS dinámica basada en la ecuación de Euler.
2. **Fijación de Precios y Rigideces Nominales:** Las empresas maximizan beneficios bajo competencia monopolística, pero enfrentan costos de ajuste o probabilidades escalonadas de actualización de precios (mecanismo de Calvo-Woodford), lo que produce la Curva de Phillips Nuevo Keynesiana dependiente de la inflación futura esperada.
3. **Regla de Política Monetaria y Principio de Taylor:** Woodford demostró que cuando la autoridad monetaria reacciona ante un incremento de inflación subiendo la tasa de interés nominal en una magnitud superior a uno a uno ($\phi_\pi > 1$, Principio de Taylor), se anclan las expectativas de inflación y se garantiza una trayectoria de equilibrio única y estable.

## Antes y después

### Antes
- **Modelos de gran escala ad-hoc:** La macroeconomía se apoyaba en sistemas empíricos de ecuaciones agregadas sin optimización individual (modelos tipo IS-LM tradicionales o modelos macroeconométricos de los años 60 y 70).
- **Vulnerabilidad a la Crítica de Lucas:** Cuando los gobiernos cambiaban sus políticas para combatir el desempleo, las correlaciones empíricas colapsaban, provocando episodios graves de estanflación y pérdida de credibilidad.
- **Enfoque puramente cuantitativo del dinero:** Se asumía que la política monetaria operaba primordialmente controlando la masa monetaria ($M1$, $M2$), un enfoque que quedó obsoleto con la liberalización financiera y las innovaciones en los medios de pago.

### Después (qué cambió gracias al aporte)
- **Marco Nuevo Keynesiano canónico:** La macroeconomía de estabilización se unificó bajo un modelo explícito con hogares optimizadores, empresas con fijación escalonada de precios y un banco central guiado por reglas.
- **Gestión central de las expectativas:** Se demostró teóricamente que el canal más poderoso de la política económica no es la sorpresa aislada, sino la credibilidad y el compromiso predecible del banco central sobre la trayectoria futura de sus tasas (*forward guidance*).
- **Microfundamentación del mercado laboral y consumo:** El análisis macroeconómico del desempleo y del gasto familiar incorporó formalmente el suavizamiento del consumo de Hall y la búsqueda con salarios rígidos.

## Cómo se aplica hoy

1. **Modelos de Proyección de Bancos Centrales (Federal Reserve, BCE, Banco de la República, BCRP):**
   Los principales bancos centrales del mundo utilizan modelos DSGE estructurales derivados directamente del marco de Woodford (como el modelo *FRB/US* o *SIGMA* de la Reserva Federal, y *NAWM* del Banco Central Europeo) para proyectar inflación, brecha del producto y evaluar decisiones de tasas de interés ([Federal Reserve Board](https://www.federalreserve.gov/econres/us-models-about.htm); [European Central Bank](https://www.ecb.europa.eu/pub/research/working-papers/html/index.en.html)).

2. **Orientación Hacia Adelante (*Forward Guidance*) en Épocas de Crisis:**
   Durante la crisis financiera global de 2008, la crisis del COVID-19 en 2020 y los shocks inflacionarios recientes, los bancos centrales adoptaron explícitamente el instrumental analítico de Woodford sobre gestión de expectativas cuando las tasas alcanzaron el límite inferior cero (*Zero Lower Bound*), guiando las tasas de largo plazo sin requerir expansiones desmedidas de agregados ([Woodford 2012, Jackson Hole Symposium](https://www.kansascityfed.org/research/jackson-hole-economic-symposium/methods-of-policy-accommodation-at-the-interest-rate-lower-bound/)).

3. **Diseño y Evaluación de Reformas del Seguro de Desempleo y Salarios Mínimos:**
   Los modelos de rigideces salariales de equilibrio y fricciones de emparejamiento desarrollados por Hall son la herramienta estándar empleada por ministerios de hacienda y comisiones de productividad para estimar cómo responderá la tasa natural de desempleo ante cambios en transferencias sociales o choques tecnológicos ([Hall, American Economic Review 2005](https://doi.org/10.1257/0002828053854497)).

## Replicación en R
- **Qué se replicó:** Simulación dinámica determinista y estocástica de las Funciones Impulso-Respuesta (IRF) en el modelo canónico Nuevo Keynesiano de 3 ecuaciones (IS Euler, Curva de Phillips Calvo-Woodford y Regla de Taylor con inercia).
- **Con qué datos:** Parámetros calibrados estructurales canónicos ($\sigma^{-1} = 1.0$, $\beta = 0.99$, $\kappa = 0.125$, $\phi_\pi = 1.5$, $\phi_y = 0.5$, $\rho_i = 0.75$).
- **Resultados obtenidos:** Un shock monetario contractivo (+100 pb) reduce contemporáneamente la inflación y la brecha del producto, convergiendo suavemente a su estado estacionario. Un shock positivo de demanda (+1%) induce una respuesta estabilizadora de tasas conforme al Principio de Taylor.
- **Limitaciones:** Representación con agente representativo (RANK); extensiones contemporáneas incorporan fricciones financieras y heterogeneidad de hogares (HANK).

## Pruébalo tú mismo (App Interactiva Shiny)
Este laureado incluye una aplicación interactiva en Shiny (`shiny/app.R`) diseñada con `bslib` para que estudiantes e investigadores puedan manipular directamente los parámetros macroeconómicos en vivo:
- Modificar el parámetro del **Principio de Taylor ($\phi_\pi$)** para observar el desanclaje de expectativas.
- Ajustar la **inercia de la tasa de política ($\rho_i$)** y la **pendiente de la curva de Phillips ($\kappa$)**.
- Ejecución local directa mediante: `shiny::runApp("laureados/2026_hall_woodford/shiny")`.

## Para profundizar
- Hall, R. E. (1978). *Stochastic Implications of the Life Cycle-Permanent Income Hypothesis: Theory and Evidence*. `hall1978stochastic`.
- Woodford, M. (2003). *Interest and Prices: Foundations of a Theory of Monetary Policy*. `woodford2003interest`.
- Rotemberg, J. J., & Woodford, M. (1997). *An Optimization-Based Econometric Framework for the Evaluation of Monetary Policy*. `rotemb_woodford1997`.
- The Royal Swedish Academy of Sciences (2026). *Microeconomic Foundations of Macroeconomic Stabilization (Scientific Background)*. `nobel2026scientific`.

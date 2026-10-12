---
anio: 2004
slug: 2004_kydland_prescott
laureados: ["Finn E. Kydland", "Edward C. Prescott"]
motivacion_oficial: "for their contributions to dynamic macroeconomics: the time consistency of economic policy and the driving forces behind business cycles"
area: ["Macroeconomía Dinámica", "Política Monetaria", "Teoría del Ciclo Económico"]
tags: ["consistencia temporal", "sesgo inflacionario", "reglas vs discreción", "bancos centrales independientes", "ciclos económicos reales", "RBC", "filtro Hodrick-Prescott", "DSGE", "residuo de Solow", "time-to-build"]
referencias_clave: ["kydland_prescott1977rules", "kydland_prescott1982time", "hodrick_prescott1997postwar", "barro_gordon1983rules", "rogoff1985optimal", "nobel2004scientific"]
replicacion: "laureados/2004_kydland_prescott/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Finn E. Kydland y Edward C. Prescott transformaron la macroeconomía moderna al demostrar que la discrecionalidad política genera un sesgo inflacionario inevitable si no existen reglas creíbles con compromiso, y al probar que las fluctuaciones agregadas pueden explicarse como respuestas de equilibrio óptimas de agentes racionales ante choques tecnológicos reales (teoría RBC y filtro Hodrick-Prescott).

## Resumen de la investigación
A finales de la década de 1970, la macroeconomía atravesaba una profunda crisis epistemológica. La estanflación de los años 70 había destrozado la creencia tradicional en una curva de Phillips estable, mientras que los grandes modelos macroeconométricos keynesianos eran incapaces de guiar la política económica ante el impacto de las expectativas racionales (la célebre crítica de Robert Lucas en 1976).

Finn E. Kydland y Edward C. Prescott resolvieron esta encrucijada a través de dos contribuciones fundamentales:

1. **Inconsistencia Temporal y Reglas de Política (1977):**
   Antes de Kydland y Prescott, los gobiernos abordaban la política económica como un problema de control óptimo convencional de la ingeniería física: un planificador benevolente ajustaba instrumentos (tasas de interés, gasto público) para conducir una economía considerada pasiva. Kydland y Prescott probaron que este enfoque era fundamentalmente erróneo. Los agentes económicos no son objetos inertes, sino tomadores de decisiones que miran hacia adelante y anticipan las acciones futuras de la autoridad.
   Bajo **discrecionalidad** (cuando el gobierno puede reoptimizar sus decisiones en cada periodo), la autoridad enfrenta un incentivo oportunista perverso: una vez que el sector privado ha firmado contratos laborales fijando expectativas de inflación moderada, el gobierno siente la tentación de provocar una sorpresa inflacionaria no anticipada para expandir temporalmente la producción y el empleo. Sin embargo, los ciudadanos racionales anticipan este comportamiento e incorporan una mayor tasa de inflación en sus contratos. El equilibrio de Nash resultante es el **sesgo inflacionario**: la economía padece una inflación crónicamente elevada sin experimentar ninguna mejora duradera en el producto ni en el empleo. La conclusión revolucionaria fue que la discrecionalidad es contraproducente; la sociedad maximiza su bienestar cuando la autoridad se autoimpone **reglas de política con compromiso vinculante** (*commitment*) o delega el mandato en instituciones monetarias independientes y creíbles.

2. **Teoría de los Ciclos Económicos Reales (RBC) y Filtro Hodrick-Prescott (1982, 1997):**
   Hasta 1982, la profesión económica asumía de forma casi unánime que el crecimiento tendencial y las fluctuaciones cíclicas eran dos fenómenos divorciados: la tendencia obedecía a factores reales de oferta a largo plazo, mientras que los ciclos eran perturbaciones indeseables de corto plazo causadas por fallas de mercado, rigideces salariales o desequilibrios de demanda monetaria.
   Kydland y Prescott (1982) unificaron ambos horizontes. Construyeron un modelo de equilibrio general dinámico estocástico (DSGE) en el que familias y empresas optimizan intertemporalmente su consumo, inversión y oferta de trabajo en respuesta a **choques exógenos de productividad y tecnología** (el residuo de Solow). Mostraron que las fluctuaciones macroeconómicas no son necesariamente ineficiencias patológicas que el Estado deba corregir, sino respuestas de equilibrio óptimas de la sociedad ante cambios en su frontera tecnológica. Introdujeron el concepto de *time-to-build* (períodos de gestación de proyectos de inversión que amplifican y propagan los choques a lo largo del tiempo) y el **filtro Hodrick-Prescott**, la herramienta matemática que permitió a los investigadores aislar con rigor las tendencias de largo plazo de las desviaciones cíclicas.

## Metodología y resultados
1. **Teoría de Juegos y Formulación Analítica de la Inconsistencia Temporal (1977):**
   Kydland y Prescott formularon el dilema de política como un juego dinámico entre el gobierno y el sector privado. Considerando una función de pérdida social $L = \frac{1}{2} \pi^2 + \frac{\gamma}{2} (y - k y_n)^2$ y una curva de oferta agregada con expectativas $y = y_n + \alpha (\pi - \pi^e) + \varepsilon$ (con $k > 1$ debido a distorsiones estructurales):
   - Bajo **compromiso vinculante**, la regla óptima fija $\pi = 0$, los agentes forman expectativas racionales $\pi^e = 0$, el producto se ubica en su tasa natural ($y = y_n + \varepsilon$) y la pérdida social esperada se minimiza.
   - Bajo **discrecionalidad**, el banco central optimiza periodo a periodo tomando $\pi^e$ como dato, lo que resulta en una función de reacción que eleva la inflación esperada a $\pi^e = \alpha \gamma (k - 1) y_n$. El producto medio sigue siendo $y_n$, pero la inflación sufre un sesgo permanente que destruye el bienestar social.
   - Demostraron que la política óptima no es temporalmente consistente: el plan que parecía óptimo ex-ante deja de ser óptimo ex-post una vez formadas las expectativas, lo que exige blindar institucionalmente el compromiso mediante leyes, delegación en banqueros conservadores (Rogoff, 1985) o esquemas de reputación (Barro y Gordon, 1983).

2. **Equilibrio General Dinámico Estocástico (DSGE) y Calibración Cuantitativa (1982):**
   En lugar de estimar sistemas de ecuaciones reducidas con cientos de variables no restringidas (práctica estándar de la econometría macroeconómica de los años 60 y 70), Kydland y Prescott microfundamentaron el comportamiento agregado:
   - Los hogares maximizan la utilidad intertemporal $E_0 \sum \beta^t u(C_t, L_t)$, decidiendo la sustitución intertemporal de ocio y trabajo.
   - Las empresas maximizan beneficios con función de producción neoclásica $Y_t = A_t K_t^\alpha L_t^{1-\alpha}$, sujeta a un proceso autorregresivo de productividad $\ln A_t = \rho \ln A_{t-1} + \varepsilon_t$.
   - **Metodología de calibración:** En lugar de buscar el ajuste econométrico puntual, calibraron los parámetros fundamentales ($\alpha = 0.36, \beta = 0.99, \delta = 0.025, \rho = 0.95$) utilizando promedios de largo plazo de las cuentas nacionales y microdatos de hogares. Su modelo demostró que los choques tecnológicos son capaces de explicar aproximadamente el 70% de la varianza del producto observado en la economía estadounidense de posguerra.

3. **El Filtro Hodrick-Prescott (1997):**
   Para aislar los hechos estilizados del ciclo de negocios, formularon el problema de programación cuadrática que descompone una serie temporal $y_t$ en tendencia suave $\tau_t$ y componente cíclico $c_t$:
   $$\min_{\{\tau_t\}_{t=1}^T} \left\{ \sum_{t=1}^T (y_t - \tau_t)^2 + \lambda \sum_{t=2}^{T-1} [(\tau_{t+1} - \tau_t) - (\tau_t - \tau_{t-1})]^2 \right\}$$
   cuya solución analítica matricial cerrada es $\tau = (I_T + \lambda D' D)^{-1} y$, con $\lambda = 1600$ para datos trimestrales, fijando el estándar global para la descomposición empírica de series macroeconómicas.

## Antes y después

### Antes
- **Control óptimo tecnocrático:** Se trataba a la economía como un sistema físico predecible de relaciones mecánicas; las autoridades creían que podían calibrar discrecionalmente el gasto y la oferta monetaria año a año para situar el desempleo en cualquier nivel deseado.
- **Inflación crónica por oportunismo:** La discrecionalidad de las políticas monetarias alimentó la gran inflación de los años 70 en las economías avanzadas, debido a continuos intentos por estimular el empleo mediante sorpresas monetarias de corto plazo que rápidamente se disipaban en espirales de precios y salarios.
- **Divorcio conceptual entre crecimiento y ciclos:** La teoría del crecimiento (modelos de Solow) se estudiaba de forma aislada para el largo plazo, mientras que los ciclos económicos se modelaban como perturbaciones patológicas de corto plazo motivadas exclusivamente por la demanda agregada y rigideces de precios.
- **Macromodelos sin microfundamentos sólidos:** Los modelos de predicción económica consistían en vastos sistemas de ecuaciones simultáneas ad-hoc que colapsaban ante cualquier cambio de régimen de política (Crítica de Lucas).

### Después (qué cambió gracias al aporte)
- **Autonomía legal de los bancos centrales:** La demostración del sesgo inflacionario impulsó una ola mundial de reformas institucionales que otorgaron independencia operacional y mandatos prioritarios de estabilidad de precios a los bancos centrales, eliminando la interferencia política electoral.
- **Régimen de Metas de Inflación (*Inflation Targeting*):** La adopción generalizada de reglas cuantitativas públicas y marcos de comunicación transparentes resolvió el problema de credibilidad y ancló las expectativas de inflación a largo plazo.
- **La revolución DSGE en la macroeconomía:** El enfoque de Kydland y Prescott se convirtió en el paradigma fundacional de la investigación macroeconómica. Los modelos DSGE modernos (tanto RBC puros como neokeynesianos con precios pegajosos) son hoy la herramienta analítica estándar utilizada por todos los grandes bancos centrales e instituciones multilaterales.
- **Estandarización de la medición del ciclo:** El filtro Hodrick-Prescott se consolidó como la técnica canónica para calcular brechas de producto (*output gaps*), componentes tendenciales y momentos estadísticos cíclicos en la literatura internacional.

## Cómo se aplica hoy

1. **Autonomía Operacional y Metas de Inflación en Bancos Centrales Globales:**
   La formulación de Kydland y Prescott sobre la consistencia temporal fue el motor conceptual detrás de la ola global de reformas que confirieron independencia a los bancos centrales a partir de la década de 1990. Ejemplos emblemáticos incluyen la creación del **Banco de la Reserva de Nueva Zelanda** bajo el *Reserve Bank of New Zealand Act* (1989), pionero en metas de inflación explícitas; la independencia otorgada al **Banco de Inglaterra** en 1997 (*Bank of England Act 1998*); el diseño estatutario del **Banco Central Europeo** consagrado en el Tratado de Maastricht (1992, operativo desde 1998) con mandato primordial de estabilidad de precios; y el marco formal de metas de inflación al 2% formalizado por la **Reserva Federal de EE. UU.** en 2012 ([Federal Reserve Board - Statement on Longer-Run Goals and Monetary Policy Strategy](https://www.federalreserve.gov/monetarypolicy/files/FOMC_LongerRunGoals.pdf)). Al delegar la política monetaria en banqueros centrales independientes con mandatos explícitos, los gobiernos blindan la credibilidad de sus economías y eliminan el sesgo inflacionario electoral.

2. **Modelos DSGE para la Conducción de la Política Monetaria y Fiscal (FRB/US, SIGMA, NAWM II y GIMF):**
   La metodología de modelación de equilibrio general dinámico estocástico (DSGE) iniciada por Kydland y Prescott (1982) constituye la infraestructura analítica central de las instituciones rectoras de las finanzas internacionales. La **Reserva Federal de los Estados Unidos** opera modelos de linaje DSGE como el modelo SIGMA ([Federal Reserve International Finance Discussion Papers No. 835](https://www.federalreserve.gov/pubs/ifdp/2005/835/ifdp835.pdf)), el **Banco Central Europeo** utiliza el modelo *New Area-Wide Model II* (NAWM II, [ECB Working Paper No. 2200](https://www.ecb.europa.eu/pub/pdf/scpwps/ecb.wp2200.en.pdf)) para simular escenarios de política monetaria no convencional y choques de oferta, y el **Fondo Monetario Internacional (FMI)** calibra rutinariamente el *Global Integrated Monetary and Fiscal Model* (GIMF, [IMF Working Paper WP/10/34](https://www.imf.org/en/Publications/WP/Issues/2016/12/31/The-Global-Integrated-Monetary-and-Fiscal-Model-GIMF-Theoretical-Structure-23616)) para evaluar choques globales de productividad y reformas estructurales en economías avanzadas y emergentes.

3. **Consejos Fiscales Autónomos y Reglas Numéricas contra la Inconsistencia Temporal del Gasto:**
   El principio de inconsistencia temporal no se restringe a la emisión de dinero, sino que se extiende a las finanzas públicas: los gobiernos enfrentan un sesgo sistemático al sobreendeudamiento y déficit fiscal en periodos electorales. Para contrarrestar esta tentación, numerosos países establecieron reglas fiscales estructurales y Consejos Fiscales Independientes (*Independent Fiscal Institutions*, IFIs), tales como la **Oficina de Responsabilidad Presupuestaria del Reino Unido** (*Office for Budget Responsibility*, OBR, creada en 2010), el **Consejo de Política Fiscal de Suecia** (*Finanspolitiska rådet*, 2007), la regla de balance estructural de **Chile** (2001) respaldada por comités independientes de expertos para estimar el PIB tendencial, y la Autoridad Fiscal Independiente de Responsabilidad Fiscal (**AIReF**) en España (2013).

4. **Monitoreo de Brechas de Producto y Colchón de Capital Anticíclico de Basilea III (BIS, OCDE y FMI):**
   El filtro Hodrick-Prescott de Kydland y Prescott (1997) es una herramienta normativa obligatoria en la arquitectura regulatoria financiera global. El **Comité de Basilea de Supervisión Bancaria** (*Bank for International Settlements*, BIS) definió explícitamente en el marco regulatorio de **Basilea III** (2010-2023) que el cálculo de la brecha crédito-PIB (*credit-to-GDP gap*), la variable de activación para fijar el Colchón de Capital Anticíclico (*Countercyclical Capital Buffer*, CCyB), debe determinarse aplicando el filtro Hodrick-Prescott con parámetro de suavizamiento $\lambda = 400.000$ sobre series trimestrales ([Bank for International Settlements - Guidance for national authorities operating the countercyclical capital buffer](https://www.bis.org/publ/bcbs187.htm)). Asimismo, el **FMI** y la **OCDE** reportan de forma continua las estimaciones de brecha de producto (*output gap*) en sus reportes insignia (*World Economic Outlook* y *OECD Economic Outlook*) utilizando variantes del filtro HP.

## Replicación en R
- **Qué se replicó:**
  1. El juego dinámico de política monetaria de Kydland-Prescott (1977) y Barro-Gordon (1983): derivación analítica y numérica del equilibrio bajo Regla con Compromiso, Discrecionalidad pura, Desviación oportunista (*cheating*) y Delegación en un Banquero Central Conservador de Rogoff (1985).
  2. La simulación estocástica de equilibrio general de un modelo de Ciclos Económicos Reales (RBC) de Kydland y Prescott (1982) de 200 trimestres (50 años) impulsado por choques de productividad total de los factores (PTF / residuo de Solow AR(1) con $\rho = 0.95, \sigma = 0.007$).
  3. La descomposición matricial exacta del Filtro Hodrick-Prescott ($\tau = (I_T + \lambda D' D)^{-1} y$, con $\lambda = 1600$) para extraer las fluctuaciones cíclicas del PIB, consumo, inversión y empleo.
- **Con qué datos:** Simulación matemática generada mediante Monte Carlo en R con semilla determinística (`set.seed(2004)`), calibrada rigurosamente con los parámetros estándar de las cuentas nacionales de Estados Unidos ($\alpha = 0.36, \beta = 0.99, \delta = 0.025$).
- **Resultados obtenidos:**
  1. **Consistencia temporal:** Con una meta distorsionada de producto ($k = 1.05$), la discrecionalidad genera un sesgo inflacionario de $5.00$ puntos porcentuales sin ganancia alguna de producto medio ($E[y] = 100.0$). La pérdida social se dispara de $13.63$ (compromiso) a $26.13$ (discreción). La trampa oportunista genera una tentación transitoria (pérdida de $6.25$), pero al destruir la credibilidad condena a la sociedad a la pérdida de $26.13$. La delegación en un banquero conservador ($\gamma_b = 0.3$) reduce la inflación a $1.50\%$ y la pérdida social a $14.75$.
  2. **Ciclos Económicos Reales:** El modelo reproduce con fidelidad los hechos estilizados de la economía real:
     - Volatilidad cíclica del PIB: $\sigma_Y = 1.06\%$.
     - Hipervolatilidad de la inversión: $\sigma_I / \sigma_Y = 3.13$ (hecho empírico de Kydland-Prescott: $3.0 - 4.5$).
     - Suavizamiento del consumo: $\sigma_C / \sigma_Y = 0.30$ (hecho empírico: $< 1.0$).
     - Fuerte prociclicidad de la inversión ($Corr(I, Y) = 0.99$) y del consumo ($Corr(C, Y) = 0.90$).
     - Persistencia del ciclo: autocorrelación de primer orden del PIB cíclico de $\rho_1 = 0.65$.
- **Archivos generados:**
  - Figuras en alta resolución: `replicacion/salidas/fig_kydland_consistencia_temporal.png` y `replicacion/salidas/fig_prescott_rbc_ciclos.png`.
  - Matriz consolidada de resultados: `replicacion/salidas/tab_resultados_kydland_prescott.csv`.
- **Limitaciones:** El modelo RBC básico asume competencia perfecta y precios totalmente flexibles; extensiones modernas (modelos neokeynesianos) incorporan rigideces nominales de precios y salarios a la Calvo y fricciones financieras para capturar la transmisión de la política monetaria.

## Para profundizar
- Kydland, Finn E., & Prescott, Edward C. (1977). *Rules Rather than Discretion: The Inconsistency of Optimal Plans*. `kydland_prescott1977rules`.
- Kydland, Finn E., & Prescott, Edward C. (1982). *Time to Build and Aggregate Fluctuations*. `kydland_prescott1982time`.
- Hodrick, Robert J., & Prescott, Edward C. (1997). *Postwar U.S. Business Cycles: An Empirical Investigation*. `hodrick_prescott1997postwar`.
- Barro, Robert J., & Gordon, David B. (1983). *Rules, Discretion and Reputation in a Model of Monetary Policy*. `barro_gordon1983rules`.
- Rogoff, Kenneth (1985). *The Optimal Degree of Commitment to an Intermediate Monetary Target*. `rogoff1985optimal`.
- Prescott, Edward C. (1986). *Theory Ahead of Business Cycle Measurement*. `prescott1986theory`.
- The Royal Swedish Academy of Sciences (2004). *Dynamic Macroeconomics: The Time Consistency of Economic Policy and the Driving Forces Behind Business Cycles*. `nobel2004scientific`.

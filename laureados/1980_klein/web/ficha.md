---
anio: 1980
slug: 1980_klein
laureados: ["Lawrence R. Klein"]
motivacion_oficial: "for the creation of econometric models and the application to the analysis of economic fluctuations and economic policies [por la creación de modelos econométricos y su aplicación al análisis de las fluctuaciones económicas y las políticas económicas]"
area: ["Macroeconometría", "Macroeconomía", "Econometría Aplicada"]
tags: ["modelos macroeconométricos", "Klein I", "ecuaciones simultáneas", "MC2E", "2SLS", "Proyecto LINK", "multiplicadores dinámicos", "Comisión Cowles"]
referencias_clave: ["klein1950fluctuations", "klein1955model", "klein1947keynesian", "klein1976projectlink", "klein1981nobel"]
replicacion: "laureados/1980_klein/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Lawrence R. Klein convirtió la macroeconomía teórica en una ciencia cuantitativa predictiva al construir los primeros modelos macroeconométricos de ecuaciones simultáneas (Modelo Klein I, Klein-Goldberger y Brookings) e interconectar las economías del planeta en la red global del Proyecto LINK.

## Resumen de la investigación
Tras la publicación de la *Teoría General* de John Maynard Keynes en 1936, la profesión económica contaba con poderosos conceptos agregados —demanda efectiva, propensión marginal al consumo, preferencia por la liquidez y multiplicador de inversión—, pero carecía por completo de herramientas empíricas para estimar cuantitativamente cómo interactuaban estas fuerzas en el mundo real. ¿En cuántos dólares aumentaba el PIB ante un recorte fiscal de 10 mil millones? ¿Con qué desfase temporal respondía el empleo? ¿Qué parte del auge se transformaba en inflación?

Lawrence Robert Klein (1920–2013), trabajando en la *Cowles Commission for Research in Economics* en la Universidad de Chicago y posteriormente en la Universidad de Michigan y la Universidad de Pennsylvania, resolvió este dilema uniendo la teoría keynesiana, el naciente Sistema de Cuentas Nacionales y los métodos estadísticos de ecuaciones simultáneas:

1. **El Modelo Klein I (1950):** Publicado en la Monografía 11 de la Comisión Cowles (*Economic Fluctuations in the United States, 1921–1941*), formuló el primer sistema empírico de ecuaciones simultáneas para una economía nacional, demostrando que la estimación uniecuacional por Mínimos Cuadrados Ordinarios (MCO) adolece de un grave sesgo de simultaneidad que distorsiona las políticas públicas.
2. **Megamodelos de Segunda y Tercera Generación:** Diseñó el célebre **Modelo Klein-Goldberger (1955)** de 20 ecuaciones no lineales y lideró la creación del **Modelo Brookings (1965)** de casi 400 ecuaciones, integrando sectores industriales, mercados laborales y sistemas financieros en las primeras simulaciones computarizadas de gran escala.
3. **El Proyecto LINK (1968):** Concibió y fundó la primera red macroeconométrica global que vinculó modelos nacionales independientes de más de 70 países a través de matrices consistentes de comercio internacional y flujos de capital, eliminando el supuesto irreal de que cada nación puede analizar su economía asumiendo al resto del mundo como un entorno estático y exógeno.

## Metodología y resultados

### 1. El Problema de la Simultaneidad y el Modelo Klein I
En macroeconomía, la causalidad nunca es unidireccional: el ingreso agregado ($Y_t$) determina el consumo privado ($C_t$), pero el consumo privado es simultáneamente un componente directo del ingreso a través de la identidad contable $Y_t = C_t + I_t + G_t - T_t$. Estimar una función de consumo por MCO tratando al ingreso como fijo genera una correlación positiva artificial entre el regresor y el término de error ($\text{Cov}(Y_t, u_t) > 0$), produciendo estimadores inconsistentes y sobreestimando el impacto de corto plazo.

Klein superó esta barrera estructurando el **Modelo Klein I**, compuesto por tres ecuaciones de comportamiento estocásticas y tres identidades contables:
- **Consumo Privado:** $C_t = \alpha_0 + \alpha_1 P_t + \alpha_2 P_{t-1} + \alpha_3 (W^p_t + W^g_t) + u_{1t}$
- **Inversión Neta:** $I_t = \beta_0 + \beta_1 P_t + \beta_2 P_{t-1} + \beta_3 K_{t-1} + u_{2t}$
- **Demanda de Masa Salarial Privada:** $W^p_t = \gamma_0 + \gamma_1 X_t + \gamma_2 X_{t-1} + \gamma_3 A_t + u_{3t}$
- **Identidades de Cierre:**
  $$Y_t = C_t + I_t + G_t - T_t, \quad P_t = Y_t - W^p_t, \quad K_t = K_{t-1} + I_t$$

donde $P_t$ representa los beneficios corporativos, $W^p_t$ los salarios privados, $W^g_t$ los salarios públicos, $K_{t-1}$ el stock de capital rezagado, $X_t$ la producción del sector privado y $A_t$ la tendencia temporal.

Al aplicar el método de **Mínimos Cuadrados en Dos Etapas (MC2E / 2SLS)** propuesto por Henri Theil y Robert Basmann con el conjunto de instrumentos predeterminados de la Comisión Cowles, Klein descubrió que la propensión marginal al consumo sobre los beneficios corrientes cae drásticamente de $0.1929$ (sesgo MCO) a solo $0.0173$ (estadísticamente indistinguible de cero en el corto plazo). En contraste, el consumo de los capitalistas responde con un rezago temporal ($\hat{\alpha}_2 = 0.2162$), mientras que la masa salarial se gasta de forma inmediata ($\hat{\alpha}_3 = 0.8102$).

### 2. Forma Reducida Matricial y Multiplicadores Dinámicos
Expresando el sistema simultáneo en su representación matricial canónica:

$$y_t = \Gamma y_t + B_1 y_{t-1} + B_0 x_t + c + u_t$$

Klein despejó el vector de variables endógenas contemporáneas $y_t = (C, I, W^p, Y, P, K)'$, deduciendo la forma reducida:

$$y_t = (I - \Gamma)^{-1} B_1 y_{t-1} + (I - \Gamma)^{-1} B_0 x_t + (I - \Gamma)^{-1} (c + u_t) = \Pi_1 y_{t-1} + \Pi_0 x_t + \tilde{c} + v_t$$

A partir de esta formulación, se deducen tres multiplicadores canónicos de política económica:
1. **Multiplicador de Impacto:** $\Pi_0^{(G)} = (I - \Gamma)^{-1} e_G$. Ante un incremento del gasto público de $1$ unidad ($\Delta G_t = 1$), el producto se expande contemporáneamente en **$1.8167$** unidades, el consumo en **$0.6636$** y los beneficios en **$1.0194$**.
2. **Multiplicadores Interinos / Dinámicos:** $\Pi_1^s \Pi_0^{(G)}$. La matriz companion $\Pi_1$ posee un par de autovalores complejos conjugados ($\lambda_{1,2} = 0.7702 \pm 0.3494i$) con módulo $\rho = 0.8457 < 1$. Esto garantiza que la economía es **asintóticamente estable**, pero genera oscilaciones cíclicas amortiguadas con una periodicidad intrínseca de **$14.75$ años** (ciclos de Kuznets y Juglar). Tras el impulso inicial, el stock de capital acumulado ejerce un efecto de freno sobre la inversión ($\beta_3 = -0.1578 < 0$), provocando una contracción transitoria antes de converger a la trayectoria estacionaria.
3. **Multiplicador Acumulado de Largo Plazo:** $(I - \Pi_1)^{-1} \Pi_0^{(G)}$. Ante una expansión fiscal permanente, el multiplicador del producto nacional neto alcanza **$2.3320$**, con una elevación permanente del consumo ($+1.3320$) y del stock de capital ($+4.6932$), mientras que la inversión neta regresa a cero en el estado estacionario.

### 3. De los Modelos Nacionales al Proyecto LINK
A finales de los años 1960, Klein identificó la gran limitación de los modelos macroeconómicos de posguerra: trataban a las exportaciones e importaciones como variables exógenas arbitrarias. En 1968, Klein lideró la fundación del **Proyecto LINK** con el auspicio del *Social Science Research Council* y Naciones Unidas. LINK estructuró un algoritmo que resolvía de forma iterativa y simultánea decenas de modelos macroeconométricos de países individuales conectados mediante una matriz cuadrada de comercio internacional de orden $N \times N$, garantizando que:

$$\sum_{i=1}^N X_{ij} \equiv \sum_{j=1}^N M_{ji}$$

es decir, que la suma de las exportaciones mundiales iguale estrictamente a las importaciones mundiales en cada bien y servicio.

## Antes y después

### Antes
- **Macroeconomía cualitativa e intuitiva:** Los debates sobre el impacto del déficit fiscal, la política monetaria o los choques petroleros se dirimían mediante argumentos retóricos o diagramas bidimensionales abstractos (cruces keynesianas y curvas IS-LM).
- **Sesgo sistemático de simultaneidad:** Quienes intentaban hacer regresiones empíricas utilizaban MCO uniecuacional, atribuyendo erróneamente correlaciones macroeconómicas cíclicas a comportamientos microeconómicos estructurales.
- **Autarquía analítica de las naciones:** Cada país proyectaba su economía asumiendo que el comercio internacional era exógeno e inmutable, imposibilitando predecir cómo una recesión en Estados Unidos o Europa se propagaría al resto del planeta.

### Después (qué cambió gracias al aporte)
- **Modelos macroeconométricos operativos:** Los gobiernos, bancos centrales y corporaciones adoptaron sistemas computacionales de decenas o cientos de ecuaciones simultáneas para planificar el presupuesto y anticipar crisis.
- **Inferencia estadística rigurosa:** La estimación de sistemas mediante MC2E, MC3E y FIML se convirtió en el estándar técnico de la econometría de series temporales.
- **Simulación coordinada de la economía mundial:** Con el Proyecto LINK, los organismos multilaterales (FMI, Banco Mundial, ONU) adquirieron la capacidad de evaluar las interconexiones globales y coordinar políticas comerciales y fiscales entre naciones desarrolladas y en desarrollo.

## Cómo se aplica hoy

1. **Naciones Unidas y el Proyecto LINK (ONU / UN DESA, 1968–2026):**
   - El Departamento de Asuntos Económicos y Sociales de Naciones Unidas ([UN DESA](https://www.un.org/development/desa/dpad/project-link.html)) opera de forma continua la red internacional del Proyecto LINK para elaborar el informe insignia *World Economic Situation and Prospects* ([WESP 2024](https://www.un.org/development/desa/dpad/publication/world-economic-situation-and-prospects-2024/)). La red interconecta modelos macroeconómicos de más de 80 economías para cuantificar escenarios de fragmentación comercial, descarbonización global y transmisión de tasas de interés de la Reserva Federal hacia países de bajos ingresos.
2. **Sistema de Modelado Macroeconómico de la Reserva Federal (FRB/US, EE. UU., 1996–2026):**
   - El Consejo de Gobernadores de la Reserva Federal de Estados Unidos utiliza el modelo [FRB/US](https://www.federalreserve.gov/econres/us-models-about.htm), descendiente directo de los modelos estructurales de Klein y el proyecto Brookings. FRB/US cuenta con más de 300 ecuaciones que simulan el impacto dinámico de decisiones sobre la tasa de fondos federales (*federal funds rate*), compras de activos (*quantitative easing*) y choques de oferta sobre la inflación, el desempleo y el producto potencial.
3. **Modelos Macroeconómicos Multi-País del NIESR (NiGEM) y del FMI (GIMF, 2020–2026):**
   - El *National Institute of Economic and Social Research* ([NIESR](https://www.niesr.ac.uk/nigem-macroeconomic-model)) del Reino Unido y el Fondo Monetario Internacional ([FMI](https://www.imf.org/en/Publications/WP/Issues/2016/12/31/The-Global-Integrated-Monetary-and-Fiscal-Model-GIMF-Theoretical-Structure-23659)) emplean modelos globales interconectados (NiGEM y GIMF) inspirados en la metodología LINK para evaluar el impacto de los aranceles arancelarios, choques de precios en materias primas y las reglas de consolidación fiscal de la Unión Europea.

## Replicación en R
En la carpeta [replicacion/](replicacion/) se encuentra el código y el informe Quarto que reproducen fielmente los resultados del Modelo Klein I:
- **Datos históricos utilizados:** Serie cronológica oficial de Estados Unidos (1920–1941) de la Monografía 11 de la Comisión Cowles, disponible en el paquete de R `systemfit::KleinI`.
- **Estimación empírica:** Se estiman las tres ecuaciones de comportamiento comparando MCO frente a MC2E (2SLS). Se reproduce la corrección del sesgo de simultaneidad en la propensión marginal al consumo sobre los beneficios corporativos ($\hat{\alpha}_1^{\text{MC2E}} = 0.0173$ frente a $\hat{\alpha}_1^{\text{MCO}} = 0.1929$).
- **Multiplicadores fiscales:** Se calculan matricialmente el multiplicador de impacto sobre el PIB ($1.8167$), el consumo ($0.6636$) y los beneficios ($1.0194$), y el multiplicador analítico de largo plazo ante una expansión fiscal permanente ($2.3320$).
- **Propiedades dinámicas y cíclicas:** Se obtienen los autovalores de la matriz companion $\Pi_1$, demostrando la estabilidad asintótica del sistema ($\rho = 0.8457 < 1$) y verificando la existencia de un ciclo económico amortiguado intrínseco con periodicidad de $14.75$ años.
- **Salidas generadas:**
  - [fig_klein_modelo_simulacion.png](replicacion/salidas/fig_klein_modelo_simulacion.png): Ajuste de la simulación dinámica histórica frente a los datos observados de 1921 a 1941.
  - [fig_klein_multiplicadores_dinamicos.png](replicacion/salidas/fig_klein_multiplicadores_dinamicos.png): Trayectoria interina y acumulada de los multiplicadores fiscales en un horizonte de 15 años.
  - [tab_resultados_klein.csv](replicacion/salidas/tab_resultados_klein.csv): Tabla consolidada de coeficientes, errores estándar y multiplicadores.

## Para profundizar
- Klein, L. R. (1950). *Economic Fluctuations in the United States, 1921–1941*. Cowles Commission Monograph No. 11. New York: John Wiley & Sons. [klein1950fluctuations]
- Klein, L. R., & Goldberger, A. S. (1955). *An Econometric Model of the United States, 1929–1952*. Amsterdam: North-Holland. [klein1955model]
- Klein, L. R. (1976). Five-year experience of Project LINK. *Economics of Planning*, 13(1), 165–171. [klein1976projectlink]
- Klein, L. R. (1981). Nobel Lecture: Some Economic Scenarios for the 1980's. *The Scandinavian Journal of Economics*, 83(2), 165–184. [klein1981nobel]
- Theil, H. (1971). *Principles of Econometrics*. New York: John Wiley & Sons.
- Royal Swedish Academy of Sciences (1980). *The Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 1980: Press Release and Information*. [nobel1980press, nobel1980popular]

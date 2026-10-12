---
anio: 2000
slug: 2000_heckman_mcfadden
laureados: ["James J. Heckman", "Daniel L. McFadden"]
motivacion_oficial: "James J. Heckman: for his development of theory and methods for analyzing selective samples; Daniel L. McFadden: for his development of theory and methods for analyzing discrete choice"
area: ["Microeconometría", "Economía Laboral", "Economía del Transporte"]
tags: ["sesgo de selección", "razón inversa de Mills", "Heckit", "elección discreta", "modelo de utilidad aleatoria", "logit condicional", "BART", "microdatos"]
referencias_clave: ["heckman1979sample", "mcfadden1974conditional", "heckman1974shadow", "mcfadden1974travel", "nobel2000scientific"]
replicacion: "laureados/2000_heckman_mcfadden/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
James J. Heckman y Daniel L. McFadden crearon las bases metodológicas de la microeconometría contemporánea al resolver, respectivamente, cómo corregir el sesgo estadístico originado por muestras autoseleccionadas y cómo predecir rigurosamente las decisiones cualitativas y discretas de los seres humanos mediante modelos de utilidad aleatoria.

## Resumen de la investigación
Hacia la década de 1970, la proliferación de encuestas de hogares y microdatos a nivel de individuos y empresas enfrentó a los economistas con dos barreras matemáticas insalvables para el instrumental estadístico convencional:

1. **La no aleatoriedad de las muestras socioeconómicas (James J. Heckman):**
   Los agentes económicos no son partículas físicas inertes que se asignan al azar a distintas situaciones; toman decisiones deliberadas. Cuando un investigador analiza datos de salarios, solo observa los ingresos de quienes decidieron trabajar. Aquellas personas cuyo salario de reserva supera la oferta salarial del mercado deciden no participar. Si los factores inobservables que determinan la decisión de trabajar (como la ambición, perseverancia o habilidades no certificadas) están correlacionados con el salario potencial, estimar una ecuación de salarios por Mínimos Cuadrados Ordinarios (MCO) en la submuestra de trabajadores activos genera un **sesgo de selección muestral** (*sample selection bias*). Heckman reformuló este problema demostrando que el sesgo de selección equivale conceptualmente a un **sesgo por omisión de variable** y desarrolló un método computable y transparente en dos etapas (conocido universalmente como **Heckit**) para neutralizarlo.

2. **La modelación de decisiones cualitativas discretas (Daniel L. McFadden):**
   La teoría microeconómica tradicional asumía bienes continuos e infinitamente divisibles. Sin embargo, muchas de las decisiones más trascendentales de la vida económica son categóricas y discretas: qué profesión ejercer, qué marca de vehículo comprar, mudarse o no de ciudad, o viajar al trabajo en metro, autobús o automóvil particular. McFadden conectó la teoría axiomática del consumidor con la econometría probabilística creando el **Modelo de Utilidad Aleatoria** (*Random Utility Model*, RUM) y derivando analíticamente el modelo **Logit Condicional** (*Conditional Logit*). Su formulación permitió estimar la probabilidad de que un individuo elija una opción específica en función de los atributos de dicha alternativa y de las características sociodemográficas del individuo, revolucionando la ingeniería de transporte y la organización industrial.

## Metodología y resultados

### 1. El Estimador en Dos Etapas de Heckman (Heckit, 1979)
Consideremos una ecuación sustantiva de salarios potenciales $y_i^* = X_i'\beta + \epsilon_i$ y una ecuación latente de participación laboral $z_i^* = W_i'\gamma + u_i$. Observamos el salario real $y_i$ únicamente si la persona participa ($d_i = \mathbf{1}\{z_i^* > 0\}$).
Bajo el supuesto de normalidad bivariada de las perturbaciones con correlación $\rho$:
$$\mathbb{E}[y_i \mid d_i = 1, X_i, W_i] = X_i'\beta + \mathbb{E}[\epsilon_i \mid u_i > -W_i'\gamma] = X_i'\beta + (\rho \sigma_\epsilon) \lambda(W_i'\gamma)$$
donde $\lambda(W_i'\gamma) \equiv \frac{\phi(W_i'\gamma)}{\Phi(W_i'\gamma)}$ es la **Razón Inversa de Mills** (*Inverse Mills Ratio*).

El método de Heckman resuelve el sesgo mediante dos pasos secuenciales:
- **Etapa 1:** Estimar un modelo Probit sobre la probabilidad de participación $\Pr(d_i = 1 \mid W_i) = \Phi(W_i'\gamma)$ para toda la muestra poblacional y calcular la razón inversa de Mills predicha $\hat{\lambda}_i$.
- **Etapa 2:** Estimar por MCO la ecuación de salarios en la muestra seleccionada de participantes incluyendo $\hat{\lambda}_i$ como un regresor adicional de control:
  $$y_i = X_i'\beta + \theta \hat{\lambda}_i + \nu_i$$
El coeficiente $\hat{\theta}$ estima consistentemente el parámetro $\rho \sigma_\epsilon$. Una prueba t ordinaria sobre $\hat{\theta} = 0$ constituye un test formal para verificar la existencia de sesgo de selección en los datos.

### 2. El Modelo de Utilidad Aleatoria y Logit Condicional de McFadden (1974)
Un individuo $i$ enfrenta un conjunto de $J$ alternativas. Su utilidad latente por la opción $j$ se descompone en un componente sistemático observable $V_{ij}$ y un choque aleatorio $\epsilon_{ij}$:
$$U_{ij} = V_{ij} + \epsilon_{ij} = X_{ij}'\beta + Z_i'\alpha_j + \epsilon_{ij}$$
McFadden demostró que si los choques $\epsilon_{ij}$ se distribuyen independientes e idénticamente distribuidos siguiendo una distribución de Valor Extremo Tipo I (Gumbel), la probabilidad de que el agente elija la opción $j$ adopta una forma analítica exacta:
$$P_{ij} = \Pr(U_{ij} \ge U_{ik}, \forall k \neq j) = \frac{\exp(V_{ij})}{\sum_{k=1}^J \exp(V_{ik})}$$
Esta estructura permite calcular la **Tasa Marginal de Sustitución** entre atributos y obtener medidas monetarias fundamentales de bienestar, como el **Valor del Tiempo** ahorrado en el transporte: $\text{VOT} = \frac{\beta_{\text{tiempo}}}{\beta_{\text{costo}}}$.

## Antes y después

### Antes
- **Supuesto ingenuo de aleatoriedad muestral:** Los economistas empíricos estimaban ecuaciones salariales y funciones de producción asumiendo implícitamente que no existían diferencias sistemáticas entre quienes decidían trabajar o invertir y quienes no lo hacían.
- **Modelos de probabilidad lineal deficientes:** Las decisiones cualitativas binarias o múltiples se forzaban en regresiones de MCO con el Modelo de Probabilidad Lineal (MPL), generando predicciones incoherentes con probabilidades negativas o superiores al 100%, y carentes de fundamentos teóricos de elección del consumidor.
- **Planificación urbana ciega a la conducta humana:** La demanda de grandes infraestructuras públicas de transporte se proyectaba mediante modelos gravitacionales mecánicos basados en distancia agregada, incapaces de predecir cómo responderían los ciudadanos a atributos cualitativos como tiempos de espera, trasbordos o comodidad.

### Después (qué cambió gracias al aporte)
- **Corrección sistemática de la autoselección:** El estimador Heckit se transformó en una rutina econométrica obligatoria en economía laboral, evaluación de políticas sociales y finanzas corporativas, obligando a explicitar el mecanismo de asignación de las observaciones.
- **Microfundamentación rigurosa de la demanda discreta:** La teoría de utilidad aleatoria de McFadden unificó el análisis axiomático microeconómico con los métodos estadísticos de máxima verosimilitud, abriendo paso al Logit Anidado (*Nested Logit*) y al Logit Mixto (*Mixed Logit* con parámetros aleatorios).
- **Planificación de infraestructura basada en conducta individual:** La predicción precisa que McFadden realizó en la década de 1970 sobre la cuota modal del sistema de metro **BART** (*Bay Area Rapid Transit*) en San Francisco (prediciendo un 6.3% frente al 6.2% observado en la realidad, mientras los consultores tradicionales auguraban un 15%) demostró el poder de los modelos de elección discreta para evitar inversiones públicas deficitarias.

## Cómo se aplica hoy

1. **Diseño y Evaluación de Infraestructura de Transporte Masivo (California High-Speed Rail / UK Department for Transport, 2018–2024):**  
   Los modelos de demanda para proyectos masivos de alta velocidad ferroviaria (como el tren de alta velocidad de California o la planificación de transporte del Reino Unido mediante la guía oficial *Transport Analysis Guidance - TAG*) emplean extensiones del Logit Condicional y Logit Mixto de McFadden para estimar la disposición a pagar por ahorro de tiempo de viaje y la sustitución modal entre tren, automóvil y aviación comercial ([California High-Speed Rail Authority Ridership Models](https://hsr.ca.gov/); [UK DfT TAG Unit M2](https://www.gov.uk/guidance/transport-analysis-guidance-tag)).

2. **Cálculo de la Brecha Salarial de Género y Políticas Activas de Empleo (Eurostat y OCDE, 2019–2024):**  
   Al comparar las retribuciones entre hombres y mujeres, las instituciones estadísticas multilaterales (como Eurostat y la OCDE) aplican el procedimiento de corrección de selección de Heckman. Debido a que las tasas de participación femenina varían intensamente según el nivel educativo y la maternidad, omitir el control de la razón inversa de Mills distorsiona el cálculo de la brecha salarial real en sectores con baja inserción laboral ([Eurostat Gender Pay Gap Statistics](https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Gender_pay_gap_statistics); [OECD Employment Outlook](https://www.oecd.org/employment/outlook/)).

3. **Algoritmos de Fijación Dinámica de Precios y Conjoint Analysis en Plataformas Digitales (Uber, Amazon, Airbnb, 2020–2024):**  
   Las plataformas tecnológicas globales utilizan modelos de elección discreta basados en RUM para predecir la probabilidad de que un usuario acepte un viaje con tarifa dinámica (*surge pricing*), reserve un alojamiento con diversas amenidades o seleccione un producto en el comercio electrónico, optimizando en tiempo real las funciones de ingresos y asignación algorítmica ([Uber Engineering Research](https://www.uber.com/en-US/blog/engineering/); Train, K., *Discrete Choice Methods with Simulation*, Cambridge University Press).

## Replicación en R
- **Qué se replicó:**  
  1. La simulación y estimación del modelo de autoselección de Heckman (1979), comparando el benchmark poblacional contra el MCO sesgado y el estimador consistente en dos etapas con cálculo explícito de la razón inversa de Mills ($\lambda$).  
  2. La simulación del modelo RUM de McFadden (1974) en un contexto de elección modal de transporte (Auto, Bus, Metro), con estimación de parámetros por máxima verosimilitud y cómputo del valor subjetivo del tiempo de viaje ($\text{VOT}$).
- **Resultados obtenidos vs. el modelo teórico:**  
  - En la ecuación de salarios, el MCO ingenuo subestimó el retorno real a la educación ($0.0678$ vs. valor verdadero de $0.0800$). El estimador Heckit recuperó con precisión el retorno real ($\hat{\beta}_{\text{educ}} = 0.0801, e.e. = 0.0036$) y estimó el parámetro de selección $\hat{\theta} = 0.2929$ ($p < 0.001$), prácticamente idéntico al valor teórico $\rho \sigma_\epsilon = 0.30$.
  - En el modelo de transporte de McFadden, los coeficientes de desutilidad de costo ($\hat{\beta}_{\text{costo}} = -0.1290$) y tiempo ($\hat{\beta}_{\text{tiempo}} = -0.0413$) arrojaron un valor del tiempo estimado de $\$19.21$ por hora, replicando el valor estructural teórico de $\$20.00$ por hora.
- **Salidas generadas:**  
  - Gráfico de dispersión y rectas de regresión: [`fig_heckman_sesgo_seleccion.png`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/2000_heckman_mcfadden/replicacion/salidas/fig_heckman_sesgo_seleccion.png).
  - Curvas de probabilidad modal de transporte: [`fig_mcfadden_eleccion_probabilidades.png`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/2000_heckman_mcfadden/replicacion/salidas/fig_mcfadden_eleccion_probabilidades.png).
  - Tabla consolidada de coeficientes: [`tab_resultados_estimacion.csv`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/2000_heckman_mcfadden/replicacion/salidas/tab_resultados_estimacion.csv).

## Para profundizar
- Heckman, J. J. (1979). *Sample Selection Bias as a Specification Error*. Econometrica, 47(1), 153–161. `heckman1979sample`.
- McFadden, D. (1974). *Conditional Logit Analysis of Qualitative Choice Behavior*. In P. Zarembka (Ed.), *Frontiers in Econometrics*, pp. 105–142. Academic Press. `mcfadden1974conditional`.
- Heckman, J. J. (1974). *Shadow Prices, Market Wages, and Labor Supply*. Econometrica, 42(4), 679–694. `heckman1974shadow`.
- McFadden, D. (1974). *The Measurement of Urban Travel Demand*. Journal of Public Economics, 3(4), 303–328. `mcfadden1974travel`.
- The Royal Swedish Academy of Sciences (2000). *Microeconometrics: Advanced Information on the Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 2000*. `nobel2000scientific`.

---
anio: 1994
slug: 1994_nash_harsanyi_selten
laureados: ["John C. Harsanyi", "John F. Nash Jr.", "Reinhard Selten"]
motivacion_oficial: "for their pioneering analysis of equilibria in the theory of non-cooperative games [por su análisis pionero de los equilibrios en la teoría de juegos no cooperativos]"
area: ["Microeconomía", "Teoría de Juegos"]
tags: ["equilibrio de Nash", "juegos no cooperativos", "equilibrio perfecto en subjuegos", "juegos bayesianos", "información incompleta", "estrategias mixtas", "inducción hacia atrás", "subastas"]
referencias_clave: ["nash1950equilibrium", "nash1951noncooperative", "selten1965spieltheoretische", "selten1975reexamination", "harsanyi1967games"]
replicacion: "laureados/1994_nash_harsanyi_selten/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
John F. Nash Jr., Reinhard Selten y John C. Harsanyi construyeron el andamiaje matemático de la teoría de juegos moderna al definir el concepto universal de equilibrio estratégico, refinar la racionalidad dinámica eliminando amenazas no creíbles y permitir el análisis riguroso de decisiones bajo información incompleta.

## Resumen de la investigación
Antes de la década de 1950, la ciencia económica carecía de un lenguaje matemático unificado para analizar situaciones en las que el resultado para un individuo o empresa depende críticamente de las decisiones anticipadas de los demás. La obra fundacional de John von Neumann y Oskar Morgenstern (*Theory of Games and Economic Behavior*, 1944) había sentado las primeras bases, pero estaba limitada casi en su totalidad a juegos de suma cero de dos personas (donde lo que uno gana el otro lo pierde exactamente) y a juegos cooperativos con acuerdos vinculantes previos.

El Premio Nobel de 1994 reconoció tres avances sucesivos que extendieron la teoría de juegos a la totalidad de las ciencias sociales:

1. **John F. Nash Jr. (1950, 1951):** En una tesis doctoral de apenas 28 páginas en la Universidad de Princeton, Nash introdujo la distinción entre juegos cooperativos y **no cooperativos**, y formuló el concepto de **Equilibrio de Nash**: una configuración de estrategias tal que ningún jugador tiene incentivos para cambiar unilateralmente su decisión. Utilizando teoremas de punto fijo (Kakutani y Brouwer), demostró que en cualquier juego finito siempre existe al menos un equilibrio en estrategias mixtas (probabilidades sobre acciones puras). Además, formuló la solución axiomática al problema de negociación (*Nash bargaining solution*, 1950).
2. **Reinhard Selten (1965, 1975):** Demostró que no todos los equilibrios de Nash son plausibles cuando el juego se desenvuelve secuencialmente a lo largo del tiempo. Un jugador puede amenazar con una acción destructiva si el rival entra a un mercado, pero una vez que el rival efectivamente entra, cumplir esa amenaza resulta irracional. Selten introdujo la inducción hacia atrás y el concepto de **Equilibrio Perfecto en Subjuegos** (*Subgame Perfect Equilibrium*, SPE), exigiendo que las estrategias sean racionales en cada etapa. Posteriormente profundizó con el equilibrio perfecto en la mano temblorosa (*trembling hand perfection*, 1975).
3. **John C. Harsanyi (1967–1968):** Resolvió el obstáculo de cómo modelar interacciones donde los jugadores desconocen las características, costes o preferencias de sus competidores (información incompleta). Harsanyi transformó estos escenarios en **juegos bayesianos** con información imperfecta, asignando a cada jugador un "tipo" privado elegido por la Naturaleza a partir de una distribución a priori compartida (*common prior* o doctrina de Harsanyi), definiendo el **Equilibrio de Nash Bayesiano** (BNE).

## Metodología y resultados

### 1. El Teorema de Existencia de Nash y la Mejor Respuesta
Dado un conjunto finito de $n$ jugadores $N = \{1, \dots, n\}$, cada uno con estrategias $S_i$ y pagos $u_i(s)$, un perfil de estrategias mixtas $\sigma^* = (\sigma_1^*, \dots, \sigma_n^*)$ satisface la condición de equilibrio de Nash si:

$$u_i(\sigma_i^*, \sigma_{-i}^*) \ge u_i(\sigma_i, \sigma_{-i}^*) \quad \forall \sigma_i \in \Delta(S_i), \quad \forall i \in N$$

Nash modeló la correspondencia de mejor respuesta conjunta $BR(\sigma) = \prod_{i=1}^n BR_i(\sigma_{-i})$ sobre el espacio producto compacto y convexo de estrategias mixtas $\Sigma$. Al demostrar que $BR(\cdot)$ es no vacía, convexa y de gráfica cerrada, aplicó el **Teorema de Punto Fijo de Kakutani**, asegurando la existencia de al menos un punto fijo $\sigma^* \in BR(\sigma^*)$.

### 2. El Refinamiento Dinámico de Selten (SPE)
En árboles de decisión en forma extensiva, Selten definió un **subjuego propio** como un subárbol que parte de un nodo único y contiene toda la información sucesora sin cortar conjuntos de información. Un perfil de estrategias es un **Equilibrio Perfecto en Subjuegos (SPE)** si induce un equilibrio de Nash en cada subjuego propio. Mediante **inducción hacia atrás**, se eliminan sistemáticamente las amenazas no creíbles, garantizando consistencia temporal.

### 3. La Transformación Bayesiana de Harsanyi
Para modelar información incompleta, Harsanyi introdujo el espacio de tipos privados $\theta_i \in \Theta_i$. La probabilidad conjunta a priori $P(\theta)$ es de conocimiento común. Cada jugador actualiza sus creencias mediante el teorema de Bayes al observar su propio tipo:

$$P(\theta_{-i} \mid \theta_i) = \frac{P(\theta_i, \theta_{-i})}{\sum_{\theta_{-i}'} P(\theta_i, \theta_{-i}')}$$

En el Equilibrio de Nash Bayesiano, cada tipo elige su mejor acción maximizando su utilidad esperada condicional a sus creencias sobre los tipos de los demás.

---

## Antes y después

### Antes
- **Análisis concentrado en suma cero:** Antes de Nash, la teoría formal de juegos se restringía a situaciones de conflicto puro de dos personas ($u_1 + u_2 = 0$), dejando fuera la cooperación potencial, los oligopolios, el comercio internacional y las negociaciones.
- **Predicciones ambiguas en juegos dinámicos:** No existía criterio riguroso para descartar equilibrios basados en amenazas vacías. En modelos de oligopolio, las empresas podían simular compromisos no creíbles sin que la teoría económica pudiera distinguir cuáles eran sostenibles en el tiempo.
- **Bloqueo epistemológico ante la incertidumbre:** Si una empresa desconocía los costes de su rival o un postor desconocía las valoraciones de los demás en una subasta, el juego se consideraba analíticamente insoluble.

### Después (qué cambió gracias al aporte)
- **El lenguaje universal de las ciencias sociales:** El Equilibrio de Nash se convirtió en el concepto organizador central de la microeconomía, la organización industrial, las finanzas corporativas, la ciencia política y la biología evolutiva.
- **Racionalidad secuencial estricta:** El concepto de SPE de Selten y la inducción hacia atrás permitieron distinguir entre compromisos estratégicos genuinos (como inversiones irreversibles en capacidad o patentes) y meras declaraciones retóricas.
- **Nacimiento de la microeconomía de la información y diseño de mercados:** La transformación bayesiana de Harsanyi hizo posible modelar formalmente la asimetría de información, abriendo paso directo a la teoría de contratos, subastas, señalización laboral y diseño de mecanismos.

---

## Cómo se aplica hoy

1. **Diseño de Subastas de Espectro Radioeléctrico (FCC, EE. UU., 1994–presente):**
   La Comisión Federal de Comunicaciones de EE. UU. ([Federal Communications Commission - FCC](https://www.fcc.gov/auctions)) implementó en 1994 las subastas ascendentes simultáneas (diseñadas por Paul Milgrom y Robert Wilson). Los postores poseen información incompleta sobre el valor del espectro y las valoraciones de los rivales; la ingeniería del mecanismo utiliza equilibrios bayesianos de Nash para mitigar la "maldición del ganador" (*winner's curse*), recaudando más de \$200,000 millones para el tesoro público estadounidense y replicándose en telecomunicaciones a nivel global.
2. **Algoritmos de Asignación y Emparejamiento en Medicina y Educación (NRMP, EE. UU.):**
   El Programa Nacional de Emparejamiento de Residencias Médicas ([National Resident Matching Program - NRMP](https://www.nrmp.org/)) y los sistemas de admisión escolar de Nueva York y Boston operan mediante algoritmos de emparejamiento estable (Gale-Shapley / Alvin Roth). El diseño asegura que el perfil de asignación constituya un equilibrio de Nash donde ningún estudiante ni hospital tenga incentivos para eludir el sistema centralizado formando un acuerdo paralelo no regulado.
3. **Control Antimonopolio y Análisis de Fusiones (FTC / DOJ / Comisión Europea):**
   Las agencias antimonopolio, como la Comisión Federal de Comercio ([FTC](https://www.ftc.gov/)) y el Departamento de Justicia de EE. UU., evalúan propuestas de fusión horizontal simulando equilibrios de Nash de Bertrand y Cournot con productos diferenciados. Mediante indicadores como el *Gross Upward Pricing Pressure Index* (GUPPI), predicen si la fusión alterará los incentivos de precios en el equilibrio post-fusión en detrimento de los consumidores.
4. **Ciberseguridad y Mecanismos de Consenso en Redes Descentralizadas:**
   Los protocolos fundamentales de enrutamiento en Internet ([Border Gateway Protocol - BGP](https://www.ietf.org/rfc/rfc4271.txt)) y los algoritmos de consenso de cadenas de bloques (*Proof-of-Work* / *Proof-of-Stake*) están concebidos como juegos no cooperativos donde el cumplimiento honesto del protocolo está estructurado para ser un equilibrio de Nash estricto: cualquier intento unilateral de ataque o fraude resulta económicamente autodestructivo para el atacante.

---

## Replicación en R

La replicación cuantitativa del Nobel de 1994 es completa y autónoma, desarrollada en `replicacion/R/equilibrios_juegos_no_cooperativos.R` y documentada en `replicacion/replicar.qmd`:

- **Equilibrio Mixto de Nash en Batalla de los Sexos:** Se calculan las probabilidades de indiferencia ($p^* = 0.60, q^* = 0.40$) y se trazan las correspondencias de mejor respuesta en el cuadrado unitario $[0,1] \times [0,1]$, visualizando con precisión los tres puntos de equilibrio ([fig_nash_equilibrio_mixto.png](replicacion/salidas/fig_nash_equilibrio_mixto.png)).
- **Juego Dinámico de Entrada y Refinamiento de Selten:** Se modela el juego secuencial en forma extensiva. Se identifican los dos equilibrios estáticos de Nash: el equilibrio creíble (Entrar, Acomodar) y el equilibrio descartado (Quedarse Fuera, Pelear). La inducción hacia atrás demuestra que solo el primero es un Equilibrio Perfecto en Subjuegos (SPE).
- **Extensión Bayesiana de Harsanyi:** Se modela la incertidumbre sobre el tipo del incumbente (Agresivo vs. Racional). Se simula la utilidad esperada del entrante en función de la creencia a priori $\mu$, identificando el umbral exacto $\mu^* = 0.50$ donde la amenaza adquiere credibilidad bayesiana ([fig_selten_juego_dinamico_spe.png](replicacion/salidas/fig_selten_juego_dinamico_spe.png)).
- **Tabla Resumen:** Los resultados comparativos de pagos, probabilidades y conceptos de equilibrio se exportan a [tab_resultados_juegos_1994.csv](replicacion/salidas/tab_resultados_juegos_1994.csv).

---

## Para profundizar

- **Nash (1950):** *"Equilibrium Points in n-Person Games"*, *PNAS*, [10.1073/pnas.36.1.48](https://doi.org/10.1073/pnas.36.1.48). (Demostración fundacional en dos páginas).
- **Nash (1951):** *"Non-Cooperative Games"*, *Annals of Mathematics*, [10.2307/1969529](https://doi.org/10.2307/1969529). (Formalización matemática completa de juegos no cooperativos).
- **Selten (1965):** *"Spieltheoretische Behandlung eines Oligopolmodells mit Nachfragenträgheit"*, *Zeitschrift für die gesamte Staatswissenschaft*, [JSTOR: 40748898](https://www.jstor.org/stable/40748898). (Introducción del equilibrio perfecto en subjuegos).
- **Selten (1975):** *"A Reexamination of the Perfectness Concept for Equilibrium Points in Extensive Games"*, *Int. J. Game Theory*, [10.1007/BF01766185](https://doi.org/10.1007/BF01766185). (Equilibrio de la mano temblorosa).
- **Harsanyi (1967–1968):** *"Games with Incomplete Information Played by 'Bayesian' Players"*, *Management Science*, [10.1287/mnsc.14.3.159](https://doi.org/10.1287/mnsc.14.3.159). (Partes I, II y III: formulación canónica de juegos bayesianos).
- **Real Academia Sueca de Ciencias (1994):** *Information to the Public & Advanced Information*, [NobelPrize.org 1994](https://www.nobelprize.org/prizes/economic-sciences/1994/advanced-information/).

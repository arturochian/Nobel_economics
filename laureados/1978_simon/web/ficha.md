---
anio: 1978
slug: 1978_simon
laureados: ["Herbert A. Simon"]
motivacion_oficial: "for his pioneering research into the decision-making process within economic organizations"
area: ["Toma de Decisiones", "Economía Conductual", "Organización Industrial", "Ciencia Cognitiva e IA"]
tags: ["racionalidad limitada", "satisficing", "niveles de aspiración", "toma de decisiones en organizaciones", "heurísticas", "inteligencia artificial", "economía conductual", "homeostasis organizacional"]
referencias_clave: ["simon1979rational", "simon1947administrative", "simon1955behavioral", "simon1956rational", "simon1957models", "march_simon1958organizations"]
replicacion: "laureados/1978_simon/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Herbert A. Simon transformó para siempre las ciencias sociales y la computación al demostrar que los seres humanos y las organizaciones no optimizan de forma omnisciente, sino que operan bajo racionalidad limitada adoptando reglas de satisfacción (*satisficing*) basadas en niveles de aspiración adaptativos.

## Resumen de la investigación
A mediados del siglo XX, la ciencia económica ortodoxa operaba bajo la ficción del *Homo economicus*: un agente hipotético dotado de información perfecta, capacidad computacional infinita y preferencias inalterables que maximizaba implacablemente su función de utilidad o beneficio global.

Herbert A. Simon (1916–2001), profesor de la Universidad Carnegie Mellon y polímata imprescindible en economía, psicología, administración y ciencias de la computación, desmanteló esta premisa dogmática a través de una serie de investigaciones pioneras:

1. **Racionalidad Limitada (*Bounded Rationality*, 1947, 1955, 1957):** Simon argumentó que los agentes reales enfrentan barreras fisiológicas y cognitivas insoslayables: capacidad limitada de memoria de trabajo, velocidad finita de procesamiento mental, tiempo escaso y una radical incompletitud de información respecto al porvenir.
2. **Conducta Satisfactora vs Optimizadora (*Satisficing* vs *Optimizing*, 1955, 1956):** Acuñó el neologismo *satisficing* (unión de *satisfy* y *suffice*). Frente a espacios combinatorios gigantescos (como elegir un empleo, planificar una inversión corporativa o jugar al ajedrez), la búsqueda del óptimo absoluto es matemáticamente inviable o prohibitivamente costosa. En su lugar, el decisor fija un **nivel de aspiración** ($\alpha$) admisible y busca secuencialmente hasta hallar la primera opción que satisfaga o supere dicho estándar.
3. **Niveles de Aspiración Adaptativos (March & Simon, 1958):** Las aspiraciones no son estáticas. Operan como un mecanismo homeostático de regulación: si el entorno es generoso y abundan las soluciones fáciles, las aspiraciones se elevan suavemente; si el entorno entra en crisis y la búsqueda prolongada fracasa, el nivel de aspiración decae gradualmente para destrabar la toma de decisiones y evitar la parálisis organizativa.
4. **Toma de Decisiones en Organizaciones (*Administrative Behavior*, 1947):** Las empresas no son funciones matemáticas de producción, sino sistemas cooperativos diseñados específicamente para suplir las limitaciones cognitivas individuales mediante la división del trabajo, jerarquías de autoridad y rutinas operativas programadas.
5. **Cimientos de la Inteligencia Artificial y la Ciencia Cognitiva:** Junto a Allen Newell, construyó el *Logic Theorist* (1956) y el *General Problem Solver* (1959), demostrando que tanto la inteligencia humana como la computacional resuelven problemas mediante búsqueda heurística en árboles de posibilidades, submetas y reglas prácticas, no por fuerza bruta matemática.

## Metodología y resultados

### 1. El Modelo Canónico de Satisfacción Secuencial (Simon, 1955)
Sea un conjunto de $N$ alternativas potenciales de decisión, cada una con un valor latente $V_i \sim F(v)$.
- **El Optimizador Exhaustivo:** Examina la totalidad de las $N$ alternativas. Si evaluar cada opción cuesta $c > 0$ en recursos cognitivos o tiempo:
  $$U_{\text{opt}} = \max_{i=1,\dots,N}(V_i) - c \cdot N$$
- **El Satisfacedor de Simon:** Fija un umbral de aceptabilidad $\alpha$. Examina alternativas secuencialmente $1, 2, \dots, K$ y se detiene en el primer índice tal que $V_K \ge \alpha$.
  - Si $p = 1 - F(\alpha)$ es la probabilidad de que una alternativa cumpla el estándar, el número esperado de evaluaciones es $E[K] \approx \frac{1}{p} \ll N$.
  - La utilidad neta es:
    $$U_{\text{sat}} = V_K - c \cdot K$$

### 2. El "Cruce de Simon": Por qué Satisfacer Supera a Optimizar
A través de la simulación de Monte Carlo en R ($5,000$ réplicas sobre $N = 200$ alternativas con $V \sim \mathcal{N}(50, 10)$):
- **Esfuerzo computacional:** El optimizador requiere siempre $200$ evaluaciones. Un satisfacedor ambicioso (aspiración calibrada al percentil 90) requiere un promedio de **$10.07$ evaluaciones** (mediana de $7$).
- **Frontera de eficiencia:** El satisfacedor ambicioso obtiene un valor bruto promedio de $67.50$ (capturando el **$87.1\%$** del valor máximo absoluto de $77.47$), pero consumiendo únicamente el **$5\%$** del esfuerzo de cálculo.
- **Rendimiento neto:** Cuando el costo computacional unitario $c$ supera apenas $0.05$:
  - Con $c = 0.10$, el satisfacedor obtiene una utilidad neta de **$66.49$** frente a solo **$57.47$** del optimizador (superándolo en el **$94.7\%$** de las réplicas).
  - Con $c = 0.15$, el satisfacedor logra **$65.99$** frente a **$47.47$** (superándolo en el **$99.8\%$** de las veces).
  - Con $c = 0.40$, el optimizador exhaustivo colapsa en destrucción neta de valor (**$-2.53$**), mientras que el satisfacedor preserva **$63.47$**, dominándolo en el **$100\%$** de los casos.

### 3. Homeostasis Organizacional y Dinámica Adaptativa
El nivel de aspiración inter-temporal evoluciona según la regla adaptativa:
$$\alpha_{t+1} = (1 - \lambda)\alpha_t + \lambda V_t$$
donde $\lambda \in (0, 1)$ es la tasa de actualización por experiencia acumulada:
- Ante un choque adverso o recesión, las organizaciones adaptativas $(\lambda \approx 0.20)$ reducen suavemente sus expectativas, preservando la viabilidad operativa y estabilizando el número de exploraciones. Las organizaciones burocráticas rígidas $(\lambda \approx 0.05)$ sufren parálisis por insistir en estándares inalcanzables.

## Antes y después

### Antes
- **El Homo Economicus Omnisciente:** La microeconomía neoclásica asumía que los agentes disponían de información perfecta y capacidades matemáticas infinitas para calcular el óptimo global instantáneamente.
- **Optimización como Única Racionalidad:** Cualquier proceso de decisión que no resolviera el problema de cálculo infinitesimal de Lagrange o Kuhn-Tucker era etiquetado como "irracional" o aberrante.
- **La Empresa como Caja Negra:** La teoría económica trataba a la empresa como una simple función de producción $Y = F(K, L)$ que maximizaba beneficios mecánicamente, ignorando los conflictos internos, las jerarquías y las limitaciones de sus directivos.
- **Ausencia de Vínculo entre Psicología y Economía:** Se consideraba que los procesos mentales cognitivos pertenecían al terreno de la psicología descriptiva y no tenían cabida en la modelación económica formal.

### Después (qué cambió gracias al aporte)
- **Nacimiento de la Economía Conductual:** Simon abrió las puertas a las investigaciones sobre heurísticas, sesgos cognitivos y toma de decisiones bajo incertidumbre que luego desarrollaron Kahneman, Tversky y Thaler.
- **Legitimación de la Racionalidad Procedimental:** Se demostró formalmente que las reglas prácticas (*heuristics*) y las estrategias de satisfacción son racionales, adaptativas y económicamente superiores en entornos con costos de procesamiento positivos.
- **Teoría de la Organización y Comportamiento Administrativo:** Las corporaciones pasaron a ser estudiadas como sistemas de información limitados donde las rutinas, manuales de procedimiento y departamentos existen para compensar la memoria y atención finita de los ejecutivos.
- **Fusión de Economía, Computación e Inteligencia Artificial:** Simon demostró que los problemas del mundo real son problemas de búsqueda computacional en espacios masivos (NP-difíciles), cimentando los principios de la IA moderna y la ciencia cognitiva.

## Cómo se aplica hoy

1. **Motores de Búsqueda y Algoritmos de Comercio Electrónico (Amazon y Google, 2018–presente):**
   Al procesar consultas en catálogos de cientos de millones de artículos o miles de millones de páginas web, los servidores de Google y Amazon no ejecutan una optimización exhaustiva combinatoria. Aplican algoritmos de poda y reglas de satisfacción que detienen la búsqueda en decenas de milisegundos cuando se alcanza un umbral de relevancia admisible (*good enough ranking*), balanceando el costo energético de los centros de datos con la latencia percibida por el usuario.
2. **Protocolos Médicos de Triage y Heurísticas Frugales (Servicio Nacional de Salud del Reino Unido - NHS y Mayo Clinic, 2020–2024):**
   Inspirados en las heurísticas ecológicas derivadas del trabajo de Simon (popularizadas por Gerd Gigerenzer), las salas de urgencias hospitalarias no recopilan cientos de análisis biomédicos exhaustivos para cada paciente en shock. Emplean árboles de decisión rápidos y frugales (*fast-and-frugal trees*) de solo tres o cuatro chequeos secuenciales críticos para asignar camas de cuidados intensivos, maximizando la supervivencia bajo severas restricciones de tiempo.
3. **Arquitecturas de Aprendizaje Profundo y Modelos de Búsqueda en IA (DeepMind y OpenAI, 2016–2024):**
   Sistemas emblemáticos como *AlphaGo* (2016) y modelos contemporáneos con razonamiento de cadena de pensamiento (*Reasoning Models* de OpenAI y Google DeepMind, 2024) implementan variantes de *Monte Carlo Tree Search (MCTS)* con podas heurísticas. En lugar de evaluar los $10^{170}$ movimientos posibles del tablero de Go o la totalidad del espacio léxico, las redes simulan ramas prometedoras hasta satisfacer un nivel de confianza objetivo, reproduciendo exactamente la teoría de búsqueda heurística formulada por Simon y Newell en los años cincuenta.
4. **Diseño de Políticas Públicas y Unidades de Ciencias del Comportamiento (OECD y Behavioral Insights Team de EE.UU. y Reino Unido, 2015–presente):**
   Las agencias tributarias y de pensiones de múltiples gobiernos de la OCDE estructuran programas de ahorro para la jubilación mediante opciones predeterminadas de inscripción automática (*default enrollment*), reconociendo que los ciudadanos enfrentan racionalidad limitada y abandonan la planificación financiera ante formularios extensos y sobrecarga de opciones.

## Replicación en R

El análisis cuantitativo de la heurística satisfactora y la dinámica de niveles de aspiración se encuentra totalmente implementado en el script ejecutable:

`laureados/1978_simon/replicacion/R/racionalidad_limitada_y_satisfaccion.R`

Para reproducir la simulación y regenerar las tablas y gráficos desde la consola:

```bash
# Ejecutar simulación completa en R
Rscript laureados/1978_simon/replicacion/R/racionalidad_limitada_y_satisfaccion.R
```

El script genera de manera autónoma:
- `laureados/1978_simon/replicacion/salidas/tab_resultados_simon.csv`: Tabla con evaluaciones promedio, valores brutos, costos totales y tasas empíricas de dominancia sobre el optimizador.
- `laureados/1978_simon/replicacion/salidas/fig_simon_satisficing_heuristica.png`: Gráfico de 4 paneles que ilustra la distribución de evaluaciones, el cruce de costos de Simon, la frontera de eficiencia cognitiva y la densidad de utilidad neta.
- `laureados/1978_simon/replicacion/salidas/fig_simon_nivel_aspiracion_dinamico.png`: Ilustración de los ajustes adaptativos intra-búsqueda e inter-temporales frente a choques estructurales.

## Para profundizar

- **Simon, Herbert A. (1947):** *Administrative Behavior: A Study of Decision-Making Processes in Administrative Organization*. Macmillan, Nueva York. La obra seminal que transformó la teoría organizacional.
- **Simon, Herbert A. (1955):** *"A Behavioral Model of Rational Choice"*, *The Quarterly Journal of Economics*, 69(1), 99–118. El artículo fundacional donde se introduce formalmente la racionalidad limitada y la regla satisfactora (*satisficing*).
- **Simon, Herbert A. (1956):** *"Rational Choice and the Structure of the Environment"*, *Psychological Review*, 63(2), 129–138. Análisis del vínculo entre la estructura del entorno y las heurísticas mentales.
- **March, James G. y Simon, Herbert A. (1958):** *Organizations*. John Wiley & Sons, Nueva York. El texto clásico sobre aprendizaje, aspiraciones y toma de decisiones corporativa.
- **Simon, Herbert A. (1979):** *"Rational Decision-Making in Business Organizations"* (Conferencia del Premio Nobel), *The American Economic Review*, 69(4), 493–513. Síntesis magistral de la evolución histórica y las aplicaciones económicas de la racionalidad limitada.

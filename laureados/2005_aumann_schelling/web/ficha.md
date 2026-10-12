---
anio: 2005
slug: 2005_aumann_schelling
laureados: ["Robert J. Aumann", "Thomas C. Schelling"]
motivacion_oficial: "for having enhanced our understanding of conflict and cooperation through game-theory analysis"
area: ["Teoría de Juegos", "Microeconomía", "Economía del Comportamiento"]
tags: ["teoría de juegos repetidos", "teorema popular", "folk theorem", "equilibrio correlacionado", "conocimiento común", "segregación espacial", "puntos focales", "compromiso creíble"]
referencias_clave: ["schelling1960strategy", "schelling1971dynamic", "schelling1978micromotives", "aumann1959acceptable", "aumann1974subjectivity", "aumann1976agreeing", "nobel2005scientific"]
replicacion: "laureados/2005_aumann_schelling/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Robert J. Aumann y Thomas C. Schelling transformaron radicalmente la comprensión de la interacción estratégica humana, demostrando formal y conceptualmente cómo la cooperación duradera emerge del temor al castigo futuro y cómo los conflictos, la segregación y la coordinación social nacen de compromisos creíbles, puntos focales y micromotivos individuales.

## Resumen de la investigación
Durante las primeras décadas de la Guerra Fría y el desarrollo temprano de la teoría de juegos con John von Neumann y John Nash, el análisis estratégico se hallaba encasillado en dilemas estáticos de suma cero o juegos simultáneos de una sola etapa (*one-shot games*). En ese marco analítico, dilemas fundamentales como el Dilema del Prisionero predecían inevitablemente el colapso cooperativo y la destrucción mutua asegurada: el equilibrio no cooperativo dictaba la deserción inmediata.

**Thomas C. Schelling** y **Robert J. Aumann** revolucionaron este paradigma desde dos perspectivas metodológicas complementarias:
1. **Thomas C. Schelling** abordó la interacción estratégica desde el conflicto real y el comportamiento tácito. En su obra maestra *The Strategy of Conflict* (1960), desarmó el mito de que el poder negociador equivale a una fuerza militar o económica desmedida: probó que atarse las manos deliberadamente (*burning bridges*), enviar señales irreversibles y apoyarse en **puntos focales** (*focal points* o puntos de Schelling) permite a los agentes coordinarse sin comunicarse. Más adelante, en *Dynamic Models of Segregation* (1971) y *Micromotives and Macrobehavior* (1978), formuló el primer modelo basado en agentes (*agent-based model*) de la economía moderna, revelando que pequeñas preferencias individuales no discriminatorias pueden generar patrones macroscópicos de segregación residencial extrema.
2. **Robert J. Aumann** dotó a la teoría de juegos del andamiaje matemático más profundo y riguroso del siglo XX. Aumann fue el arquitecto principal de la **teoría de juegos repetidos** (*repeated games*), formalizando el célebre **Teorema Popular** (*Folk Theorem*): demostró que cuando los agentes interactúan indefinidamente y la "sombra del futuro" (*shadow of the future*) es suficientemente densa, casi cualquier resultado de bienestar mutuo puede sostenerse en equilibrio mediante amenazas de represalia creíbles. Asimismo, Aumann introdujo el concepto de **equilibrio correlacionado** (*correlated equilibrium*, 1974) —superando las restricciones del equilibrio de Nash mediante señales externas no vinculantes— y fundó la teoría epistémica de juegos con su teorema de **conocimiento común** (*common knowledge*, 1976), probando que dos agentes racionales con priors comunes nunca pueden acordar estar en desacuerdo (*agree to disagree*).

## Metodología y resultados

1. **La Teoría del Conflicto Estratégico y Compromisos Creíbles (Schelling, 1960):**
   Schelling demostró que un juego de negociación es una mezcla de conflicto y cooperación mutua (*mixed-motive games*). Para que una amenaza o promesa altere la conducta del rival, debe ser **creíble**:
   - **Atarse las manos (*binding commitments*):** Reducir las propias opciones futuras aumenta el poder de negociación presente al eliminar la posibilidad de retirarse.
   - **Tácticas al borde del abismo (*brinkmanship*):** Introducir un riesgo deliberado y probabilístico de desastre mutuo (*the threat that leaves something to chance*) para forzar la concesión del adversario.
   - **Puntos focales (*Schelling points*):** En juegos de pura coordinación con información incompleta, los agentes convergen en equilibrios prominentes determinados por convenciones culturales, geometría o expectativas mutuas de segundo orden.

2. **Micromotivos y Macrocomportamiento: El Modelo de Segregación (Schelling, 1969, 1971):**
   Schelling diseñó una dinámica espacial descentralizada donde agentes de dos grupos ($A$ y $B$) residen en un retículo y solo toleran estar en su entorno si la fracción de vecinos de su propio grupo es al menos $\tau$. Demostró que incluso con un umbral de tolerancia notablemente inclusivo ($\tau = 0.35$, donde cada individuo acepta felizmente estar en una minoría local del 35%), el proceso dinámico de relocalizaciones descentralizadas converge invariablemente a un estado de **hipersegregación macroscópica** ($\bar{S} > 75\%-80\%$). La macro-segregación observada en las metrópolis no requiere, por tanto, una segregación intencional o maliciosa individual.

3. **El Teorema Popular y la Sombra del Futuro (Aumann, 1959, 1981):**
   En un juego repetido infinitamente con factor de descuento intertemporal $\delta \in (0, 1)$, Aumann y Shapley probaron que el conjunto de pagos en equilibrios perfectos en subjuegos (SPE) coincide con el conjunto de pagos factibles e individualmente racionales del juego base:
   $$v_i \ge v_i^{\min} = \min_{a_{-i}} \max_{a_i} u_i(a_i, a_{-i})$$
   En el Dilema del Prisionero con pagos de etapa $(R, T, P, S)$, la cooperación mutua es sostenible bajo una estrategia de represalia permanente (*Grim Trigger*) si y solo si:
   $$\frac{R}{1 - \delta} \ge T + \frac{\delta P}{1 - \delta} \iff \delta \ge \delta^* = \frac{T - R}{T - P}$$
   Para los parámetros canónicos $(R=3, T=5, P=1, S=0)$, la cooperación se sostiene siempre que los agentes descuenten el futuro a una tasa $\delta \ge 0.50$.

4. **Equilibrio Correlacionado (Aumann, 1974):**
   Aumann generalizó el equilibrio de Nash permitiendo que los jugadores reciban una señal aleatoria pública o privada emitida por un mecanismo mediador correlacionado $p(s_1, \dots, s_n)$. Un perfil de estrategias es un equilibrio correlacionado si ningún jugador tiene incentivos para desobedecer la recomendación de acción recibida:
   $$\sum_{s_{-i}} p(s_i, s_{-i}) [u_i(a_i, s_{-i}) - u_i(a_i', s_{-i})] \ge 0 \quad \forall a_i, a_i'$$
   El conjunto de equilibrios correlacionados es convexo, computable en tiempo polinomial mediante programación lineal y puede generar pagos estrictamente superiores al mejor equilibrio de Nash en estrategias mixtas.

5. **Conocimiento Común y el Teorema "Agreeing to Disagree" (Aumann, 1976):**
   Aumann formalizó un evento $E$ como conocimiento común entre un conjunto de agentes si todos saben que $E$, todos saben que todos saben que $E$, y así sucesivamente *ad infinitum*. Demostró que si dos agentes bayesianos parten de una distribución a priori común (*common prior assumption*) y sus probabilidades posteriores sobre un evento son conocimiento común, **dichas probabilidades posteriores deben ser estrictamente idénticas**:
   $$P_1(A \mid \mathcal{P}_1(\omega)) = P_2(A \mid \mathcal{P}_2(\omega))$$
   Es matemáticamente imposible que dos personas racionales mantengan un desacuerdo de opinión si el hecho mismo de su discrepancia es conocido por ambas.

## Antes y después

### Antes
- **Fatalismo de la deserción:** La teoría económica predecía que en dilemas sociales, bienes públicos y relaciones internacionales, los agentes egoístas estaban condenados irremisiblemente al colapso no cooperativo.
- **Enfoque unidimensional del conflicto:** Se concebía la disuasión militar y la negociación comercial exclusivamente como una demostración de fuerza física o acumulación de recursos brutos.
- **Explicación simplista de la segregación urbana:** Se atribuía la separación racial y socioeconómica barrial exclusivamente a discriminación legal explícita o a prejuicios raciales de máxima hostilidad.
- **Aislamiento informacional:** No existía una definición matemática rigurosa para modelar el conocimiento mutuo y la credibilidad de los rumores y señales públicas.

### Después (qué cambió gracias al aporte)
- **La cooperación como equilibrio racional:** Aumann demostró que las relaciones a largo plazo con horizonte indefinido permiten que la amenaza de sanciones futuras transforme la cooperación mutua en la mejor respuesta individual egoísta.
- **El poder de la vulnerabilidad calculada:** Schelling demostró que autolimitarse, tender cables trampa (*tripwires*) o crear compromisos contractuales irrevocables es la forma más efectiva de ganar poder de negociación y disuadir agresiones.
- **Comprensión de los sistemas complejos sociales:** El modelo de segregación de Schelling inauguró los modelos basados en agentes y la teoría de puntos críticos de inflexión (*tipping points*), demostrando cómo agregaciones no lineales generan fallas colectivas imprevistas.
- **Teoría de juegos epistémica e información compartida:** La formulación de conocimiento común y equilibrio correlacionado de Aumann se convirtió en el pilar estándar para la macroeconomía moderna, las subastas y los mercados financieros.

## Cómo se aplica hoy

1. **Tratados Internacionales de No Proliferación y Disuasión de la OTAN (1960–2024):**
   La arquitectura de la disuasión nuclear contemporánea se rige directamente por los conceptos de Schelling de compromisos creíbles y cables trampa (*tripwires*). El despliegue de tropas multinacionales de la OTAN en los países bálticos ([NATO Enhanced Forward Presence, 2017–2024](https://www.nato.int/cps/en/natohq/topics_136388.htm)) funciona formalmente como un cable trampa schellingiano: una fuerza reducida incapaz de repeler una invasión militar masiva por sí sola, pero cuya muerte automática en caso de ataque involucra de manera irrevocable a todas las potencias aliadas bajo el Artículo 5, impidiendo que el adversario crea que Estados Unidos abandonará a sus socios.

2. **Protocolos de Consenso y Gobernanza en Criptoactivos y Blockchain (2015–2024):**
   Las redes de finanzas descentralizadas y protocolos Proof-of-Stake como Ethereum ([Ethereum Consensus Specs, 2020–2024](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/)) implementan formalmente el Teorema Popular de Aumann mediante mecanismos de castigo conocidos como *slashing*. Los validadores bloquean capital (*stake*) que genera recompensas periódicas en un juego repetido indefinido; cualquier intento de doble gasto o censura es sancionado con la destrucción inmediata e irreversible de sus fondos, garantizando que el factor de descuento efectivo del validador satisfaga $\delta \ge \delta^*$ y haciendo económicamente inviable la defección maliciosa.

3. **Políticas de Integración Escolar y Zonificación Urbana (OCDE y HUD de EE. UU., 2010–2024):**
   El Departamento de Vivienda y Desarrollo Urbano de los Estados Unidos (HUD) y los ministerios de educación europeos emplean modelos dinámicos de Schelling para calibrar límites de zonificación escolar y programas de vales de vivienda ([HUD Affirmatively Furthering Fair Housing Framework](https://www.hud.gov/program_offices/fair_housing_equal_opp/affirmatively_furthering_fair_housing)). Al comprender que una variación mínima en la composición étnica o socioeconómica de una escuela o vecindario puede cruzar un umbral de inflexión (*tipping point*) que desencadene el éxodo masivo (*white flight*), los municipios diseñan subsidios de alquiler dispersos y cuotas escolares dinámicas que previenen la transición descontrolada hacia guetos aislados.

## Replicación en R
- **Qué se replicó:**
  1. El modelo dinámico de segregación espacial de Schelling (1971) sobre un retículo toroidal de $40 \times 40$ celdas con dos grupos de agentes (45% rojos, 45% azules y 10% vacantes), evaluando la evolución temporal del índice de segregación barrial bajo un umbral de tolerancia individual moderado $\tau = 0.35$ (los agentes aceptan ser minoría de hasta 35% frente a 65%).
  2. El Dilema del Prisionero Repetido de Aumann bajo el Teorema Popular, evaluando analíticamente el factor de descuento crítico $\delta^*$ que sostiene la cooperación perfecta en equilibrio SPE para estrategias Gatillo (*Grim Trigger*) y Ojo por Ojo (*Tit-for-Tat*), complementado con una simulación estocástica multi-ronda con fallos de ejecución involuntarios (*trembles* con $\epsilon = 5\%$) a lo largo de $\delta \in [0.10, 0.95]$.
- **Entorno de ejecución:** Script autónomo [juegos_conflicto_y_segregacion.R](../replicacion/R/juegos_conflicto_y_segregacion.R) ejecutado en R 4.6.0 (`tidyverse`, `patchwork`, `scales`).
- **Principales hallazgos cuantitativos:**
  - En la simulación de Schelling ([fig_schelling_segregacion_espacial.png](../replicacion/salidas/fig_schelling_segregacion_espacial.png)):
    * El índice de segregación inicial con distribución aleatoria es de $\mathbf{50.57\%}$ (satisfacción individual del $84.2\%$).
    * Tras 30 iteraciones de reubicaciones autónomas descentralizadas, el sistema converge a un equilibrio estable con $\mathbf{100.0\%}$ de satisfacción y un índice de segregación macroscópico de $\mathbf{75.49\%}$.
    * Pequeñas preferencias individuales por no quedar en extrema minoría multiplican la segregación macroscópica en más de 25 puntos porcentuales, generando guetos densos sin que ningún agente lo tuviera como meta personal.
  - En la simulación de Aumann ([fig_aumann_folk_theorem_cooperacion.png](../replicacion/salidas/fig_aumann_folk_theorem_cooperacion.png) y [tab_resultados_aumann_schelling.csv](../replicacion/salidas/tab_resultados_aumann_schelling.csv)):
    * El factor de descuento crítico teórico para sostener la cooperación mutua con castigo draconiano es $\delta^*_{\text{Grim}} = \mathbf{0.5000}$, mientras que para Tit-for-Tat es $\delta^*_{\text{TFT}} = \mathbf{0.6667}$.
    * Sin perturbaciones ($\epsilon = 0$), *Grim Trigger* rinde el óptimo de primer mejor con un pago de $\mathbf{3.0000}$ para todo $\delta \ge 0.50$.
    * En presencia de errores estocásticos leves ($\epsilon = 0.05$), la estrategia draconiana de Aumann sufre un castigo excesivo ante el primer desliz accidental (reduciendo su pago a $2.63$), mientras que estrategias generosas o adaptativas como *Tit-for-Tat* y *Pavlov* preservan la resiliencia social y superan ampliamente al castigo implacable.
- **Limitaciones:** El modelo de Schelling omite los precios del suelo, costos de mudanza o externalidades de transporte que amortiguan o aceleran la dinámica de relocalización. En el modelo de Aumann, se asume un juego simétrico sin colusión multipartita oculta.

## Para profundizar
- Schelling, T. C. (1960). *The Strategy of Conflict*. Harvard University Press, Cambridge, MA [@schelling1960strategy].
- Schelling, T. C. (1971). *Dynamic Models of Segregation*. Journal of Mathematical Sociology, 1(2), 143-186 [@schelling1971dynamic].
- Schelling, T. C. (1978). *Micromotives and Macrobehavior*. W. W. Norton & Company, New York [@schelling1978micromotives].
- Aumann, R. J. (1959). *Acceptable Points in General Cooperative n-Person Games*. Contributions to the Theory of Games, Vol. IV, Annals of Mathematics Studies 40, 287-324 [@aumann1959acceptable].
- Aumann, R. J. (1974). *Subjectivity and Correlation in Randomized Strategies*. Journal of Mathematical Economics, 1(1), 67-96 [@aumann1974subjectivity].
- Aumann, R. J. (1976). *Agreeing to Disagree*. The Annals of Statistics, 4(6), 1236-1239 [@aumann1976agreeing].
- Aumann, R. J. (1981). *Survey of Repeated Games*. Essays in Game Theory and Mathematical Economics in Honor of Oskar Morgenstern, 11-42 [@aumann1981survey].
- Royal Swedish Academy of Sciences (2005). *Robert Aumann’s and Thomas Schelling’s Contributions to Game Theory: Analyses of Conflict and Co-operation*. Scientific Background [@nobel2005scientific].

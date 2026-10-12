---
anio: 1972
slug: 1972_hicks_arrow
laureados: ["Sir John R. Hicks", "Kenneth J. Arrow"]
motivacion_oficial: "for their pioneering contributions to general economic equilibrium theory and welfare theory [por sus contribuciones pioneras a la teoría del equilibrio económico general y a la teoría del bienestar]"
area: ["Microeconomía", "Economía del Bienestar", "Teoría del Equilibrio General"]
tags: ["equilibrio general", "teoria del bienestar", "IS-LM", "Arrow-Debreu", "activos contingentes", "teorema de imposibilidad", "demanda compensada", "variacion compensatoria", "variacion equivalente", "Slutsky-Hicks"]
referencias_clave: ["hicks1937keynes", "hicks1939value", "hicks1939welfare", "arrow1951social", "arrow1954existence", "arrow1964securities", "arrow1963medical"]
replicacion: "laureados/1972_hicks_arrow/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Sir John R. Hicks y Kenneth J. Arrow transformaron los cimientos de la ciencia económica al formalizar matemáticamente la teoría del equilibrio general, reformular la teoría de la demanda y el bienestar mediante la dualidad y demostrar los límites infranqueables de la elección social colectiva y la asignación óptima del riesgo en los mercados financieros.

## Resumen de la investigación

El Premio Nobel de Economía de 1972 reconoció a dos de los más influyentes teóricos del siglo XX por erigir el andamiaje matemático que sostiene la microeconomía y la teoría del bienestar modernas:

1. **Sir John R. Hicks (1904–1989):**
   - En *Value and Capital* (1939), liberó la teoría del consumidor de las nociones subjetivas de utilidad cardinal. Utilizando el análisis ordinal de curvas de indiferencia, formalizó la **descomposición de Slutsky-Hicks**, separando con precisión el efecto sustitución puro del efecto ingreso originado por variaciones de precios.
   - Desarrolló el enfoque de la **dualidad**, demostrando que minimizar el gasto para alcanzar un bienestar dado es equivalente a maximizar la utilidad bajo restricción presupuestaria. A partir de la función de gasto, introdujo las métricas exactas del bienestar del consumidor: la **Variación Compensatoria ($CV$)** y la **Variación Equivalente ($EV$)**, superando las deficiencias del excedente marshaliano.
   - En 1937, en su célebre artículo *"Mr. Keynes and the 'Classics'"*, integró el mercado monetario y el mercado de bienes en el modelo **IS-LM**, convirtiéndose en la herramienta estándar de la macroeconomía neoclásica-keynesiana durante décadas.

2. **Kenneth J. Arrow (1921–2017):**
   - En *Social Choice and Individual Values* (1951), formuló el revolucionario **Teorema de Imposibilidad de Arrow**, demostrando que es matemáticamente imposible diseñar un sistema de votación o regla de decisión colectiva que satisfaga simultáneamente un conjunto mínimo de condiciones democráticas básicas (dominio no restringido, transitividad, principio de Pareto débil, no dictadura e independencia de alternativas irrelevantes).
   - En 1954, junto con Gérard Debreu, publicó la primera demostración matemática formal y rigurosa de la **existencia del equilibrio competitivo general** en una economía de propiedad privada, utilizando topología de conjuntos convexos y el teorema de punto fijo de Kakutani, resolviendo el problema planteado por Léon Walras en 1874.
   - En 1953 y 1964, introdujo los **activos contingentes de Arrow** (*Arrow securities*), demostrando que cuando existen mercados financieros completos asociados a todos los posibles estados futuros de la naturaleza, el sistema descentralizado de precios asigna el riesgo de manera Pareto-óptima.
   - En 1963, fundó la **economía de la salud moderna**, identificando cómo la asimetría de información y la incertidumbre generan fallas sistemáticas en los mercados de seguros médicos (selección adversa y riesgo moral).

---

## Metodología y resultados

### 1. La Dualidad de Hicks y las Variaciones de Bienestar
Hicks fundamentó el análisis de la demanda sobre el problema dual de minimización de gasto:
$$e(p, u) = \min_{x \ge 0} \{ p \cdot x : U(x) \ge u \}$$
Aplicando el Lema de Shephard ($\nabla_p e(p, u) = h(p, u)$), derivó la matriz de sustitución hicksiana y probó la negatividad semidefinida del efecto sustitución propio ($\partial h_i / \partial p_i \le 0$). Ante un shock de precios de $p^0$ a $p^1$, definió:
- **Variación Compensatoria:** $CV = I - e(p^1, u^0)$, la compensación monetaria ex-post que mantiene constante la utilidad inicial.
- **Variación Equivalente:** $EV = e(p^0, u^1) - I$, la transferencia monetaria ex-ante que alcanzaría la nueva utilidad a precios vigentes.

### 2. El Modelo de Equilibrio General Arrow-Debreu
Arrow y Debreu caracterizaron la economía mediante correspondencias de exceso de demanda agregada $Z(p)$ sobre el símplice de precios $\Delta = \{p \in \mathbb{R}_+^l : \sum p_k = 1\}$. Por la **Ley de Walras** ($p \cdot z = 0, \forall z \in Z(p)$), y bajo supuestos de preferencias estrictamente convexas y tecnologías convexas (rendimientos no crecientes), aplicaron el Teorema de Punto Fijo de Kakutani (1941) a una correspondencia de mejor respuesta, probando la existencia de un vector de precios $p^*$ tal que $Z(p^*) \le 0$.

### 3. Activos Contingentes de Arrow y Eficiencia Financiera
Arrow demostró que no es necesario crear mercados al contado futuros para cada bien físico en cada estado de la naturaleza. Basta con crear un mercado financiero de $S$ activos elementales (activos de Arrow que pagan 1 unidad de numerario en el estado $s$ y 0 en cualquier otro estado). Con precios de activos $q_s$, los agentes eligen sus carteras para suavizar el consumo intertemporal y contingente, igualando las tasas marginales de sustitución entre estados al cociente de precios de Arrow:
$$\frac{\pi_s u'_i(c_{is})}{\pi_{s'} u'_i(c_{is'})} = \frac{q_s}{q_{s'}} \quad \forall i$$
Esto demuestra que los mercados financieros completos descentralizan la asignación óptima de riesgo en el sentido de Pareto.

---

## Antes y después

### Antes
- **Microeconomía:** La teoría del consumidor dependía del concepto nebuloso de "utilidad cardinal" medible en útiles. El cálculo del beneficio del consumidor se basaba en el excedente de Marshall, cuya validez requería asumir de manera poco realista una utilidad marginal del dinero constante.
- **Equilibrio General:** Se creía que el equilibrio de Walras estaba demostrado simplemente contando el número de ecuaciones y de incógnitas en el sistema económico, ignorando que sistemas no lineales con igual número de ecuaciones pueden no tener soluciones reales positivas.
- **Elección Social y Democracia:** La filosofía política y la economía del bienestar tradicional (Pigou, Bergson) daban por sentado que un "planificador social benevolente" podía sintetizar coherentemente las preferencias de la sociedad en una única función de bienestar social.
- **Incertidumbre y Finanzas:** El riesgo se trataba de forma fragmentada o intuitiva, sin un marco matemático que vinculara la valoración de activos financieros con la asignación óptima de recursos en la economía real.

### Después (qué cambió gracias al aporte)
- **Rigor Axiomático y Dualidad:** La microeconomía adoptó la teoría de la dualidad (funciones de gasto, utilidad indirecta, demandas compensadas) y las medidas hicksianas ($CV$ y $EV$), que hoy constituyen el estándar universal en evaluación de impacto, reformas tributarias y políticas comerciales.
- **Demostración de Existencia:** El Teorema de Arrow-Debreu proporcionó la primera prueba rigurosa de que el mecanismo de precios competitivos puede coordinar con éxito la totalidad de los mercados de una economía descentralizada.
- **Frontera Infranqueable de la Elección Social:** El Teorema de Imposibilidad de Arrow obligó a rediseñar la teoría democrática y la economía política, mostrando que todo sistema electoral no dictatorial es susceptible a ciclos de votación, inconsistencias o manipulación de agenda.
- **Fundación de las Finanzas Modernas:** El concepto de activos contingentes de Arrow (*state-contingent claims*) se convirtió en el cimiento sobre el cual se desarrollaron la teoría moderna de precios de activos, la valoración de derivados (Black-Scholes-Merton) y las finanzas cuantitativas.

---

## Cómo se aplica hoy

1. **Evaluación de Impacto de Reformas Tributarias y Arancelarias (OCDE y FMI):**  
   Los ministerios de hacienda y organismos internacionales como la [OCDE](https://www.oecd.org/) y el [FMI](https://www.imf.org/) evalúan reformas al IVA, subsidios a la energía y aranceles comerciales calculando directamente la Variación Compensatoria ($CV$) y la Variación Equivalente ($EV$) de Hicks para diferentes deciles de ingreso (e.g., evaluaciones distributivas del paquete fiscal de la UE y de subsidios a combustibles en América Latina en 2023–2025).
2. **Valoración de Derivados Financieros y Precios Arrow-Debreu (Bancos Centrales y Wall Street):**  
   Los modelos de valoración de opciones y bonos estructurados en mercados globales (como en la Reserva Federal, el Banco Central Europeo y [CME Group](https://www.cmegroup.com/)) emplean la teoría de medidas neutrales al riesgo (precios estado-contingentes), que es la implementación computacional directa de los activos de Arrow concebidos en 1953 y 1964.
3. **Diseño de Mecanismos de Votación y Gobernanza Descentralizada (DAOs y Sistemas Electorales):**  
   El Teorema de Imposibilidad de Arrow guía el diseño de sistemas de votación cuadrática y mecanismos de gobernanza en organizaciones descentralizadas (e.g., protocolos de finanzas descentralizadas en [Ethereum](https://ethereum.org/) y auditorías de sistemas de votación por orden de preferencia en ciudades de EE. UU. y Australia en 2024–2026).
4. **Regulación de Mercados de Salud y Seguros Médicos (Affordable Care Act y OMS):**  
   Las políticas sanitarias contemporáneas que combaten la selección adversa —como los mandatos individuales y los esquemas de ajuste de riesgo en el [Affordable Care Act (ACA)](https://www.healthcare.gov/) en EE. UU.— aplican directamente las lecciones fundacionales de Kenneth Arrow sobre incertidumbre y fallas de mercado en la medicina publicadas en la *American Economic Review* en 1963.

---

## Replicación en R

La carpeta contiene una replicación cuantitativa completa ejecutada mediante el script autónomo [`equilibrio_general_y_bienestar.R`](laureados/1972_hicks_arrow/replicacion/R/equilibrio_general_y_bienestar.R):

1. **Descomposición de Hicks del Efecto Precio:**  
   Se simula un consumidor con función Cobb-Douglas $U = x_1^{0.5} x_2^{0.5}$, ingreso $I = 100$ y una reducción a la mitad del precio del bien 1 ($p_1 = 2 \to 1$). La demanda total se incrementa en $+25.0$ unidades ($25 \to 50$). El script descompone matemáticamente este incremento en un **Efecto Sustitución puro de $+10.36$ unidades** y un **Efecto Ingreso de $+14.64$ unidades**. Asimismo, computa con precisión la Variación Compensatoria ($CV = \$29.29$) y la Variación Equivalente ($EV = \$41.42$). El resultado gráfico se preserva en [`fig_hicks_descomposicion_sustitucion_ingreso.png`](laureados/1972_hicks_arrow/replicacion/salidas/fig_hicks_descomposicion_sustitucion_ingreso.png).

2. **Equilibrio General de Arrow-Debreu en Caja de Edgeworth:**  
   Se modela una economía 2x2 bajo incertidumbre con dotaciones complementarias $\omega_A = (80, 20)$ y $\omega_B = (20, 80)$ y activos de Arrow para dos estados del mundo. El script demuestra que la apertura de mercados financieros de Arrow resuelve un precio relativo $q_1^* / q_2^* = 1.0$, logrando el aseguramiento mutuo completo ($c_{A1}^* = c_{A2}^* = 50$, $c_{B1}^* = c_{B2}^* = 50$) y elevando el consumo equivalente cierto de $40.0$ a $50.0$ (+25.0% de ganancia neta en bienestar). La figura generada es [`fig_arrow_equilibrio_general_edgeworth.png`](laureados/1972_hicks_arrow/replicacion/salidas/fig_arrow_equilibrio_general_edgeworth.png).

3. **Base de Datos de Resultados:**  
   Todos los valores analíticos y numéricos se exportan en la tabla reproducible [`tab_resultados_hicks_arrow_1972.csv`](laureados/1972_hicks_arrow/replicacion/salidas/tab_resultados_hicks_arrow_1972.csv).

---

## Para profundizar

- Hicks, John R. (1937). "Mr. Keynes and the 'Classics'; A Suggested Interpretation", *Econometrica*, 5(2), 147–159 [`hicks1937keynes`].
- Hicks, John R. (1939). *Value and Capital: An Inquiry into Some Fundamental Principles of Economic Theory*, Oxford University Press [`hicks1939value`].
- Hicks, John R. (1939). "The Foundations of Welfare Economics", *The Economic Journal*, 49(196), 696–712 [`hicks1939welfare`].
- Arrow, Kenneth J. (1951). *Social Choice and Individual Values*, Cowles Foundation Monograph 12, John Wiley & Sons [`arrow1951social`].
- Arrow, Kenneth J. y Debreu, Gérard (1954). "Existence of an Equilibrium for a Competitive Economy", *Econometrica*, 22(3), 265–290 [`arrow1954existence`].
- Arrow, Kenneth J. (1964). "The Role of Securities in the Optimal Allocation of Risk-bearing", *The Review of Economic Studies*, 31(2), 91–96 [`arrow1964securities`].
- Arrow, Kenneth J. (1963). "Uncertainty and the Welfare Economics of Medical Care", *The American Economic Review*, 53(5), 941–973 [`arrow1963medical`].

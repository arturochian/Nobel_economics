---
anio: 1983
slug: 1983_debreu
laureados: ["Gérard Debreu"]
motivacion_oficial: "for having incorporated new analytical methods into economic theory and for his rigorous reformulation of the theory of general equilibrium [por haber incorporado nuevos métodos analíticos a la teoría económica y por su rigurosa reformulación de la teoría del equilibrio general]"
area: ["Microeconomía", "Economía Matemática", "Teoría del Equilibrio General"]
tags: ["equilibrio general", "Arrow-Debreu", "Theory of Value", "núcleo", "Core", "Debreu-Scarf", "punto fijo", "Kakutani", "teoremas del bienestar", "economías regulares", "Sonnenschein-Mantel-Debreu"]
referencias_clave: ["arrow1954existence", "debreu1959theory", "debreu1963core", "debreu1952social", "debreu1970economies", "debreu1984economic"]
replicacion: "laureados/1983_debreu/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Gérard Debreu revolucionó la ciencia económica al refundar la teoría del equilibrio general sobre una base axiomática rigurosa, demostrando matemáticamente la existencia del equilibrio competitivo mediante teoremas de punto fijo y probando que la competencia perfecta emerge como el límite natural de la negociación cooperativa entre coaliciones.

## Resumen de la investigación
Durante casi un siglo, desde la publicación de los *Éléments d'économie politique pure* de Léon Walras (1874), la economía descansaba sobre una hipótesis intuitiva pero no demostrada: la idea de que en un sistema descentralizado de mercados interconectados, existe un conjunto de precios positivos capaz de coordinar simultáneamente las decisiones egoístas de millones de consumidores y productores, equilibrando la oferta y la demanda agregadas en todos los bienes a la vez. Walras intentó justificar esto contando el número de ecuaciones e incógnitas, pero en matemáticas la igualdad entre ecuaciones e incógnitas no garantiza la existencia de soluciones reales, no negativas y económicamente coherentes.

Formado en la prestigiosa *École Normale Supérieure* de París e impregnado por el formalismo estructuralista del grupo Nicolas Bourbaki, Gérard Debreu (1921–2004) acometió la tarea de refundar la teoría económica con la máxima elegancia y pureza deductiva:

1. **El Teorema de Existencia Arrow-Debreu (1954):**  
   En colaboración con Kenneth Arrow (Nobel 1972), Debreu formuló el primer modelo matemático riguroso de equilibrio general competitivo. Utilizando topología conjuntista, conos convexos y el **Teorema de Punto Fijo de Kakutani (1941)** sobre correspondencias de exceso de demanda, probó que bajo supuestos de preferencias continuas y convexas y tecnologías de producción con rendimientos no crecientes a escala, existe siempre al menos un vector de precios de equilibrio no negativo.

2. **La Monografía Axiomática *Theory of Value* (1959):**  
   En su obra maestra (*Theory of Value: An Axiomatic Analysis of Economic Equilibrium*), Debreu prescindió totalmente del cálculo diferencial y reconstruyó la economía neoclásica desde primeros principios axiomáticos. Definió el concepto de "bien" de manera cuatridimensional (características físicas, localización espacial, fecha de entrega y estado contingente del mundo), unificando de un solo golpe la teoría del consumo, la producción, el comercio internacional, el equilibrio intertemporal y los mercados financieros bajo incertidumbre (activos contingentes Arrow-Debreu).

3. **El Teorema de Equivalencia del Núcleo de Debreu-Scarf (1963):**  
   Junto con Herbert Scarf, tendió un puente histórico entre la teoría de juegos cooperativos iniciada por Francis Ysidro Edgeworth (1881) y el equilibrio walrasiano. Demostró que en economías donde el número de agentes crece mediante réplicas hacia el infinito ($N \to \infty$), el conjunto de acuerdos inmunes al boicot de cualquier coalición (el **Núcleo** o *Core*) se contrae a una velocidad de orden $O(1/N)$ hasta coincidir exactamente con el conjunto de equilibrios competitivos walrasianos.

4. **Economías Regulares y Topología Diferencial (Debreu 1970):**  
   Frente al problema de la multiplicidad de equilibrios descubierto más tarde por el Teorema de Sonnenschein-Mantel-Debreu, Debreu introdujo la topología diferencial y el **Teorema de Sard**, probando que casi todas las economías (salvo un conjunto de medida de Lebesgue cero) son "regulares", lo que asegura que sus equilibrios son localmente únicos, finitos y estables ante pequeñas perturbaciones.

---

## Metodología y resultados

### 1. El Marco Axiomático y el Teorema de Punto Fijo
Debreu definió formalmente la economía de propiedad privada $\mathcal{E}$ sin recurrir a funciones diferenciables de utilidad ni de costos:
- Consumidores $i \in \{1, \dots, m\}$ caracterizados por un conjunto de consumo $X_i \subset \mathbb{R}^l$ cerrado, convexo y acotado inferiormente, una relación de preferencia binaria completa, transitiva y convexa $\succsim_i$, y un vector de dotaciones iniciales $\omega_i \in X_i$.
- Empresas productoras $j \in \{1, \dots, n\}$ con conjuntos de producción factible $Y_j \subset \mathbb{R}^l$ cerrados y convexos que contienen el origen ($0 \in Y_j$, posibilidad de inactividad sin pérdidas fijas).
- Un símplice de precios normalizados:

$$\Delta = \left\{ p \in \mathbb{R}_+^l : \sum_{k=1}^l p_k = 1 \right\}$$

Bajo la hipótesis de no saturación local de las preferencias, la **Ley de Walras** rige con exactitud: el valor del exceso de demanda agregada $Z(p)$ es nulo para todo vector de precios ($p \cdot z = 0, \forall z \in Z(p)$). Debreu construyó una correspondencia $\mu: \Delta \times X \times Y \rightrightarrows \Delta \times X \times Y$ que cumple las condiciones del Teorema de Punto Fijo de Kakutani (semicontinua superior con imágenes convexas y compactas), demostrando que:

$$\exists p^* \in \Delta \quad \text{tal que} \quad Z(p^*) \le 0, \quad \text{con } p_k^* = 0 \text{ si } z_k(p^*) < 0$$

### 2. Los Dos Teoremas Fundamentales del Bienestar
Debreu formalizó con máxima pureza deductiva la relación entre descentralización de mercado y optimalidad social:
- **Primer Teorema Fundamental:** Todo equilibrio competitivo es un óptimo de Pareto. Si los mercados son completos y los consumidores no están localmente saturados, ninguna intervención centralizada puede mejorar a un individuo sin perjudicar a otro.
- **Segundo Teorema Fundamental:** Cualquier asignación óptima de Pareto puede descentralizarse como un equilibrio competitivo mediante una adecuada redistribución a suma fija de las dotaciones iniciales de riqueza, sustentada matemáticamente en el teorema del hiperplano separador de Hahn-Banach.

### 3. El Teorema del Límite del Núcleo (Debreu & Scarf 1963)
Sea una economía replicada $N$ veces ($\mathcal{E}_N$), con $N$ agentes idénticos de cada tipo. Una coalición $S$ puede bloquear una asignación $x$ si sus miembros pueden mejorar redistribuyendo únicamente sus recursos autónomos:

$$\sum_{i \in S} y_i \le \sum_{i \in S} \omega_i \quad \text{con } y_i \succ_i x_i \quad \forall i \in S$$

Debreu y Scarf probaron:
1. **Igualdad de trato:** Todo elemento del núcleo asigna idéntica cesta a agentes del mismo tipo.
2. **Convergencia del Núcleo:** Conforme $N \to \infty$, las coaliciones que tienen ratios de miembros ligeramente asimétricos (e.g., $N$ agentes de un tipo y $N-1$ de otro) eliminan progresivamente todas las asignaciones que no se apoyen en un hiperplano de precios lineales tangentes:

$$\lim_{N \to \infty} \mathcal{C}(\mathcal{E}_N) = \{W(\mathcal{E})\}$$

---

## Antes y después

### Antes
- **Intuición walrasiana basada en conteo de ecuaciones:** La literatura económica asumía que si había $l-1$ mercados independientes y $l-1$ precios relativos incógnita, el sistema tenía solución matemática garantizada, ignorando que sistemas no lineales con ecuaciones e incógnitas iguales pueden carecer de raíces reales o admitir soluciones negativas absurdas.
- **Dependencia de hipótesis auxiliares ad-hoc:** Se utilizaban derivadas parciales continuas, funciones de producción homogéneas diferenciables y supuestos de sustitución perfecta que no capturaban la geometría real de los conjuntos económicos.
- **Desconexión entre teoría de juegos y teoría del mercado:** Se consideraba que los mercados competitivos y las negociaciones bilaterales (como el oligopolio o los sindicatos) pertenecían a paradigmas económicos incompatibles.

### Después (qué cambió gracias al aporte)
- **Rigor axiomático y topológico universal:** La teoría económica adoptó el estándar bourbakista de Debreu: axiomas explícitos, deducciones topológicas exactas y separación tajante entre la estructura lógica del modelo y sus interpretaciones empíricas.
- **Unificación de la microeconomía y las finanzas modernas:** La definición de activos contingentes Arrow-Debreu permitió fundar matemáticamente la teoría de valoración de derivados financieros, los seguros y las finanzas corporativas.
- **Fundamento no cooperativo de la competencia perfecta:** El teorema de Debreu-Scarf cerró la brecha conceptual entre la teoría de juegos y el equilibrio general, demostrando que la conducta de "tomador de precios" no es una sumisión psicológica, sino una consecuencia matemática de la multiplicidad de coaliciones en grandes economías.

---

## Cómo se aplica hoy

1. **Modelos de Equilibrio General Computable (CGE) y Acuerdos de Comercio Global (OMC y Banco Mundial):**  
   El Proyecto de Análisis del Comercio Global ([GTAP](https://www.gtap.agecon.purdue.edu/)) y el Banco Mundial utilizan modelos CGE basados directamente en la arquitectura Arrow-Debreu para simular el impacto macroeconómico y distributivo de shocks arancelarios, tratados de libre comercio y políticas de descarbonización a escala global (e.g., evaluaciones del impacto de la crisis climática y ajustes fronterizos de carbono de la Unión Europea en 2024–2026).
2. **Mercados de Derivados Financieros y Precios de Activos Contingentes (Wall Street y Reserva Federal):**  
   La fijación de precios de opciones financieras (*pricing* sin arbitraje) mediante medidas de probabilidad neutrales al riesgo (Black-Scholes-Merton, Harrison-Kreps) se fundamenta matemáticamente en la existencia de los precios sombra de los estados contingentes concebidos originalmente por Kenneth Arrow y Gérard Debreu en 1954 y 1959.
3. **Diseño de Mercados Eléctricos Mayoristas y Subastas de Despacho (CAISO y PJM):**  
   Los operadores independientes de redes eléctricas en Estados Unidos (como [PJM Interconnection](https://www.pjm.com/) y [CAISO](https://www.caiso.com/)) resuelven cada cinco minutos un problema de equilibrio general competitivo mediante precios marginales locacionales (LMP). Las condiciones de no arbitraje y vaciado de red con restricciones de transmisión física implementan el equilibrio competitivo de Debreu con bienes indexados por tiempo y localización espacial.

---

## Replicación en R

La replicación cuantitativa del modelo de equilibrio general Arrow-Debreu y el Teorema del Núcleo de Debreu-Scarf se ejecuta de forma autónoma mediante el script [`equilibrio_general_y_nucleo.R`](laureados/1983_debreu/replicacion/R/equilibrio_general_y_nucleo.R):

1. **Caja de Edgeworth y Equilibrio Competitivo:**  
   Se simula una economía de intercambio puro con dotaciones $\omega_A = (8, 2)$ y $\omega_B = (2, 8)$ y preferencias Cobb-Douglas heterogéneas ($U_A = x_1^{0.6} x_2^{0.4}$, $U_B = x_1^{0.4} x_2^{0.6}$). Se resuelve el precio relativo de equilibrio $p_1^*/p_2^* = 1.0$, la asignación walrasiana $x_A^* = (6, 4)$ y la curva de contrato hipérbolica $x_{2A} = \frac{8 x_{1A}}{18 - x_{1A}}$. El gráfico de alta resolución generado es [`fig_debreu_caja_edgeworth.png`](laureados/1983_debreu/replicacion/salidas/fig_debreu_caja_edgeworth.png).
2. **Convergencia del Núcleo (Debreu-Scarf 1963):**  
   Se calculan los límites del núcleo mediante búsqueda dicotómica para economías replicadas de tamaño $N \in \{1, 2, 3, 5, 10, 20, 50, \infty\}$. Para $N=1$, la amplitud del núcleo es $0.9917$; al duplicar a $N=2$ se reduce en un **$69.18\%$** ($0.3056$), para $N=5$ en un **$89.81\%$** ($0.1011$), y para $N=20$ en un **$97.64\%$** ($0.0234$), convergiendo a tasa $O(1/N)$ hacia el punto walrasiano. La visualización consolidada de dos paneles se almacena en [`fig_debreu_convergencia_nucleo.png`](laureados/1983_debreu/replicacion/salidas/fig_debreu_convergencia_nucleo.png).
3. **Base de Datos de Resultados:**  
   La matriz completa de asignaciones extremas, utilidades de bienestar y tasas de contracción se exporta a [`tab_resultados_debreu.csv`](laureados/1983_debreu/replicacion/salidas/tab_resultados_debreu.csv).

---

## Para profundizar

- **Arrow, K. J. & Debreu, G. (1954):** "Existence of an Equilibrium for a Competitive Economy". *Econometrica*, 22(3), 265–290. [DOI: 10.2307/1825832](https://doi.org/10.2307/1825832). El artículo seminal que demostró rigurosamente la existencia del equilibrio walrasiano con el teorema de punto fijo de Kakutani.
- **Debreu, G. (1959):** *Theory of Value: An Axiomatic Analysis of Economic Equilibrium*. Cowles Foundation Monograph 17. Yale University Press. [Enlace Cowles Foundation](https://cowles.yale.edu/publications/monographs/theory-value). Monografía canónica que refundó la teoría del equilibrio general en lenguaje conjuntista y topológico.
- **Debreu, G. & Scarf, H. (1963):** "A Limit Theorem on the Core of an Economy". *International Economic Review*, 4(3), 235–246. [DOI: 10.2307/2525306](https://doi.org/10.2307/2525306). Teorema que prueba la convergencia del núcleo hacia los equilibrios competitivos walrasianos a medida que la economía se replica al infinito.
- **Debreu, G. (1952):** "A Social Equilibrium Existence Theorem". *Proceedings of the National Academy of Sciences*, 38(10), 886–893. [DOI: 10.1073/pnas.38.10.886](https://doi.org/10.1073/pnas.38.10.886). Generalización de los equilibrios de Nash a juegos con conjuntos de estrategias dependientes (cuasi-juegos / equilibrios sociales).
- **Debreu, G. (1970):** "Economies with a Finite Set of Equilibria". *Econometrica*, 38(3), 387–392. [DOI: 10.2307/1909545](https://doi.org/10.2307/1909545). Introducción de la topología diferencial y el Teorema de Sard para probar la regularidad genérica del equilibrio.
- **Debreu, G. (1984):** "Economic Theory in the Mathematical Mode". *The American Economic Review*, 74(3), 267–278. [DOI: 10.2307/1804007](https://doi.org/10.2307/1804007). Conferencia Nobel dictada en Estocolmo el 8 de diciembre de 1983.
- **Royal Swedish Academy of Sciences (1983):** *The Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 1983: Press Release*. [NobelPrize.org](https://www.nobelprize.org/prizes/economic-sciences/1983/press-release/).
- **Royal Swedish Academy of Sciences (1983):** *Information to the Public: Gérard Debreu and the Theory of General Equilibrium*. [NobelPrize.org](https://www.nobelprize.org/prizes/economic-sciences/1983/popular-information/).

---
anio: 1988
slug: 1988_allais
laureados: ["Maurice Allais"]
motivacion_oficial: "for his pioneering contributions to the theory of markets and efficient utilization of resources [por sus contribuciones pioneras a la teoría de los mercados y la utilización eficiente de los recursos]"
area: ["Microeconomía", "Economía Pública y Bienestar"]
tags: ["paradoja de Allais", "utilidad esperada", "efecto certeza", "costo marginal", "monopolio natural", "teoremas del bienestar", "regla de oro", "economía conductual"]
referencias_clave: ["allais1943recherche", "allais1953comportement", "allais1947economie", "machina1982expected", "boiteux1956gestion"]
replicacion: "laureados/1988_allais/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Maurice Allais refundó la microeconomía aplicada al demostrar matemáticamente que la máxima eficiencia social exige fijar precios al costo marginal, anticipar la regla de oro del capital y quebrar el axioma de independencia de la utilidad esperada con su famosa paradoja, piedra angular de la economía conductual.

## Resumen de la investigación
Durante las décadas de 1940 y 1950, Maurice Allais trabajó de forma independiente como ingeniero del cuerpo estatal de minas de Francia y profesor en la École Nationale Supérieure des Mines de Paris. Aislado de la literatura académica anglosajona debido a la Segunda Guerra Mundial, Allais reconstruyó por sí mismo los fundamentos del análisis económico moderno en una trilogía de tratados monumentales: *À la recherche d'une discipline économique* (1943), *Économie et Intérêt* (1947) y su célebre artículo en *Econometrica* sobre el riesgo (1953).

El Premio Nobel de 1988 reconoció tres grandes líneas de investigación pioneras:

1. **La Teoría de los Mercados y la Eficiencia Asignativa (1943, 1952):** Allais demostró de forma autónoma los dos Teoremas Fundamentales del Bienestar Económico, probando que un equilibrio de mercado competitivo descentralizado es eficiente en el sentido de Pareto. Formuló la teoría del excedente distribuible (*surplus distribuable*) y demostró que la condición matemática para maximizar el rendimiento social colectivo es la tarificación al costo marginal ($P = CMg$), incluso cuando las empresas son monopolios estatales con economías de escala decrecientes en costos.
2. **La Paradoja de Allais y la Crítica a la Escuela Americana (1953):** En un coloquio internacional en París en 1952, Allais presentó una serie de experimentos hipotéticos a los más grandes teóricos de la época (incluidos Leonard Savage y Milton Friedman). Los resultados probaron que los individuos racionales violan de forma sistemática el axioma de independencia de John von Neumann y Oskar Morgenstern debido al denominado **efecto certeza** (*certainty effect*). Este hallazgo inspiró el desarrollo de las teorías de utilidad no esperada y la economía conductual moderna.
3. **La Regla de Oro del Capital (1947):** Catorce años antes de que Edmund Phelps formulara la regla de oro de la acumulación de capital en 1961, Allais demostró que el consumo por habitante en una senda de crecimiento equilibrado se maximiza cuando la tasa de interés real neta iguala la tasa de crecimiento de la población ($r = n$), definiendo los límites de la ineficiencia dinámica en macroeconomía.

## Metodología y resultados

### 1. La Paradoja de Allais y la Geometría del Triángulo de Marschak-Machina
La teoría de la Utilidad Esperada (EUT) requiere que las preferencias sobre loterías satisfagan el axioma de independencia: si una lotería $L_1$ se prefiere a $L_2$, cualquier combinación convexa con una tercera lotería $L''$ debe mantener esa preferencia: $\alpha L_1 + (1 - \alpha) L'' \succ \alpha L_2 + (1 - \alpha) L''$.

Allais construyó el contraejemplo definitivo:
- **Elección 1:** Lotería A (100 millones seguros) vs. Lotería B (10% de 500M, 89% de 100M, 1% de 0). Los individuos prefieren masivamente A sobre B ($A \succ B$).
- **Elección 2:** Lotería C (11% de 100M, 89% de 0) vs. Lotería D (10% de 500M, 90% de 0). Los mismos individuos prefieren masivamente D sobre C ($D \succ C$).

Bbajo la Utilidad Esperada, $A \succ B \implies 0.11 u(100) > 0.10 u(500) + 0.01 u(0)$, mientras que $D \succ C \implies 0.10 u(500) + 0.01 u(0) > 0.11 u(100)$, lo que constituye una contradicción lógica insoluble.

En el triángulo de probabilidades de Marschak-Machina (1982), donde las curvas de indiferencia de la utilidad esperada son rectas paralelas de pendiente positiva constante, las decisiones reales exigen que las curvas de indiferencia "se abran en abanico" (*fanning out*): cerca del origen (zona de certeza) son extremadamente empinadas por aversión a perder la seguridad, pero se aplanan en zonas de alta incertidumbre, reconciliando matemáticamente la conducta empírica observada.

### 2. Tarificación al Costo Marginal en Monopolios Naturales
Allais demostró que la función de bienestar social total $W(Q) = \int_0^Q P(q)\,dq - C(Q)$ alcanza su máximo irrestricto cuando:

$$\frac{dW}{dQ} = P(Q) - C'(Q) = 0 \iff P(Q) = CMg(Q)$$

En industrias con altos costos fijos de red $F$ y costos marginales constantes $c$ (monopolio natural), el costo medio $CMe(Q) = \frac{F}{Q} + c$ es estrictamente superior al costo marginal. Si el Estado obliga a tarificar al costo marginal para evitar la pérdida social del monopolio privado ($DWL$), la empresa incurre en un déficit financiero estructural $\Pi = -F$. 

Allais y su discípulo Marcel Boiteux demostraron que este déficit no debe cubrirse aumentando los precios unitarios, sino mediante **tarifas en dos partes** (cuotas fijas de conexión independientes del consumo que cubren $F$) o subsidios fiscales financiados con impuestos de suma fija.

### 3. La Regla de Oro de la Dinámica Intertemporal
Maximizando el consumo estacionario por habitante $c(k) = f(k) - (n + \delta)k$, Allais obtuvo la condición de primer orden:

$$f'(k^*) = n + \delta \iff r^* = n$$

Si una economía ahorra en exceso ($s > \alpha$), acumula un capital tal que $f'(k) < n + \delta$, incurriendo en **ineficiencia dinámica**: un despilfarro intertemporal donde reducir el ahorro aumenta el consumo presente y futuro de todas las generaciones simultáneamente.

---

## Antes y después

### Antes
- **Aceptación dogmática de la utilidad esperada:** La hipótesis de von Neumann y Morgenstern (1944) y los axiomas subjetivos de Savage (1954) se consideraban el estándar inamovible de la conducta racional normativa y descriptiva. Cualquier desviación se catalogaba como un mero error de cálculo individual.
- **Dilema no resuelto de los servicios públicos:** Los monopolios naturales se gestionaban con tarifas arbitrarias basadas en el costo medio contable para evitar déficits, provocando racionamientos ineficientes y grandes pérdidas sociales de bienestar.
- **Teoría del capital intuitiva y desarticulada:** No existía una formulación matemática que relacionara la productividad del capital, la tasa de interés real y la tasa demográfica de crecimiento económico para guiar la tasa de ahorro óptima de una nación.

### Después (qué cambió gracias al aporte)
- **Nacimiento de la economía conductual y de decisiones:** La Paradoja de Allais demostró que decisores altamente educados violan sistemáticamente los axiomas clásicos. Esto impulsó directamente la teoría prospectiva (*Prospect Theory*) de Daniel Kahneman y Amos Tversky (1979), el modelo de *fanning out* de Mark Machina (1982) y los modelos de utilidad dependiente del rango (*Rank-Dependent Utility*) de John Quiggin (1982).
- **Ingeniería tarifaria moderna y regulación de redes:** La escuela francesa de ingenieros-economistas convirtió la regla $P = CMg$ en el estándar internacional para el diseño tarifario en electricidad, gas, ferrocarriles y telecomunicaciones (ej. la célebre *Tarif Vert* de Électricité de France).
- **Consistencia macroeconómica intertemporal:** La formulación de la Regla de Oro proporcionó la piedra angular para evaluar la sostenibilidad de los sistemas de pensiones de reparto y la acumulación de capital en los modelos neoclásicos de crecimiento (Solow, Swan, Phelps).

---

## Cómo se aplica hoy

1. **Tarificación de Redes Eléctricas y Mercados Mayoristas (Francia y Unión Europea):**  
   La Comisión de Regulación de la Energía de Francia ([CRE](https://www.cre.fr/)) y el operador de red RTE estructuran las tarifas de acceso a las redes de transmisión (TURPE) basándose directamente en los principios de Allais y la regla de Ramsey-Boiteux. El término volumétrico de la tarifa refleja el costo marginal de congestión y pérdidas en tiempo real, mientras que los costos de inversión fija en infraestructura se recuperan mediante cuotas de capacidad fijas (tarifas en dos partes), garantizando eficiencia asignativa sin quiebra financiera.
2. **Evaluación de Riesgos y Regulación Financiera y de Seguros:**  
   En la directiva europea [Solvencia II (EIOPA)](https://www.eiopa.europa.eu/) y en el diseño de productos de seguros patrimoniales y de salud, las entidades aseguradoras utilizan funciones de ponderación de probabilidades no lineales para modelar el **efecto certeza** de los asegurados. Las primas comerciales reflejan que los consumidores están dispuestos a pagar recargos desproporcionados para eliminar completamente riesgos pequeños (cobertura total de deducibles) frente a reducciones probabilísticas idénticas en zonas de riesgo intermedio.
3. **Tarificación de Congestión en Infraestructuras de Transporte (París y Singapur):**  
   La Autoridad de Transporte Terrestre de Singapur ([LTA](https://www.lta.gov.sg/)) y las autoridades ferroviarias francesas ([SNCF](https://www.sncf.com/)) aplican modelos de tarificación dinámica por costo marginal social. El precio cobrado a los usuarios y operadoras privadas de tren en horas pico incorpora el costo marginal de congestión y desgaste de vía, desviando la demanda no esencial hacia horas valle y minimizando la pérdida irrecuperable de capacidad de la infraestructura.

---

## Replicación en R

La replicación cuantitativa implementa de forma íntegra los dos modelos centrales de Maurice Allais en el script [`paradoja_allais_y_eficiencia.R`](laureados/1988_allais/replicacion/R/paradoja_allais_y_eficiencia.R):

1. **Paradoja de Allais en el Triángulo de Marschak-Machina:**  
   Se modela el símplex de probabilidades $(p_1, p_3)$, graficando las loterías canónicas de Allais, los vectores de traslación paralelos de pendiente $10$ y las curvas de indiferencia no lineales que exhiben la apertura en abanico (*fanning out*). La figura generada en alta resolución es [`fig_allais_paradoja_triangulo.png`](laureados/1988_allais/replicacion/salidas/fig_allais_paradoja_triangulo.png).
2. **Modelo de Tarificación en Monopolio Natural:**  
   Se resuelve numéricamente una estructura de mercado con demanda lineal $P(Q) = 120 - Q$ y costos $C(Q) = 800 + 20Q$. Se comparan los tres regímenes regulatorios:
   - Monopolio privado no regulado: $Q_m = 50$, $P_m = 70$, $DWL = \$1.250$.
   - Tarificación al costo medio: $Q_{cme} = 91.23$, $P_{cme} = 28.77$, $DWL = \$38.45$.
   - Primer mejor de Allais: $Q^* = 100$, $P^* = 20$, $DWL = \$0$ (con déficit de explotación de $\$800$ cubierto por subsidio o cuota de conexión).
   La visualización correspondiente se exporta a [`fig_allais_tarificacion_costo_marginal.png`](laureados/1988_allais/replicacion/salidas/fig_allais_tarificacion_costo_marginal.png).
3. **Tabla de Resultados:**  
   Los resultados numéricos consolidados se exportan en [`tab_resultados_allais.csv`](laureados/1988_allais/replicacion/salidas/tab_resultados_allais.csv).

---

## Para profundizar

- **Allais, M. (1943):** *À la recherche d'une discipline économique: Première partie: L'économie pure*. Paris: Ateliers Codat. [Gallica BnF](https://gallica.bnf.fr/ark:/12148/bpt6k3324151k). Obra fundacional donde se demuestran los Teoremas del Bienestar y la regla de costo marginal.
- **Allais, M. (1953):** "Le comportement de l'homme rationnel devant le risque: critique des postulats et axiomes de l'école américaine". *Econometrica*, 21(4), 503–546. [DOI: 10.2307/1907921](https://doi.org/10.2307/1907921). Artículo seminal que expone la paradoja y desafía la utilidad esperada.
- **Allais, M. (1947):** *Économie et Intérêt*. Paris: Imprimerie Nationale. Tratado donde se deduce por primera vez la regla de oro de la acumulación de capital.
- **Machina, M. J. (1982):** "'Expected Utility' Analysis without the Independence Axiom". *Econometrica*, 50(2), 277–323. [DOI: 10.2307/1912631](https://doi.org/10.2307/1912631). Formalización matemática moderna del triángulo símplex y la apertura en abanico.
- **Boiteux, M. (1956):** "Sur la gestion des Monopoles Publics astreints à l'équilibre budgétaire". *Econometrica*, 24(1), 22–40. [DOI: 10.2307/1905257](https://doi.org/10.2307/1905257). Aplicación práctica de la teoría de Allais a la fijación de tarifas en empresas públicas monopólicas.
- **The Royal Swedish Academy of Sciences (1988):** *Information to the Public: Maurice Allais and the Theory of Markets and Efficient Resource Allocation*. [NobelPrize.org](https://www.nobelprize.org/prizes/economic-sciences/1988/popular-information/).

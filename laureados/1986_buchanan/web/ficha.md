---
anio: 1986
slug: 1986_buchanan
laureados: ["James M. Buchanan Jr."]
motivacion_oficial: "for his development of the contractual and constitutional bases for the theory of economic and political decision-making"
area: ["Economía Pública", "Elección Pública (Public Choice)", "Economía Constitucional"]
tags: ["elección pública", "economía constitucional", "cálculo del consenso", "reglas de votación", "búsqueda de rentas", "deuda pública", "ilusión fiscal", "leviatán"]
referencias_clave: ["buchanan1987nobel_lecture", "buchanan_tullock1962calculus", "buchanan1949pure_theory", "buchanan1958public_debt", "tullock1967tariffs", "brennan_buchanan1980power"]
replicacion: "laureados/1986_buchanan/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
James M. Buchanan Jr. revolucionó la ciencia económica al desmitificar el Estado mediante la "política sin romanticismo": demostró que los políticos y burócratas responden a los mismos incentivos auto-interesados que los agentes de mercado, y formuló la teoría de las reglas constitucionales óptimas que limitan la tiranía de la mayoría, el despilfarro del cabildeo y el endeudamiento público crónico.

## Resumen de la investigación
Durante más de medio siglo, la teoría económica tradicional asumió una extraña esquizofrenia metodológica: trataba a los consumidores y empresarios en el mercado como maximizadores racionales de su propio bienestar, pero asumía ingenuamente que cuando esas mismas personas ingresaban a la política o a la administración pública se convertían en sabios planificadores altruistas dedicados desinteresadamente a maximizar el "bien común".

James M. Buchanan Jr. (Universidad de Virginia y Universidad George Mason), fundador junto a Gordon Tullock de la **Teoría de la Elección Pública** (*Public Choice Theory*) y de la **Economía Constitucional**, demolió esta premisa ingenua. Aplicando el individualismo metodológico y las herramientas analíticas de la microeconomía al proceso político, Buchanan demostró que:

1. **La Política como Intercambio Complejo:** Los procesos políticos no son mecanismos para descubrir una "voluntad general" mística, sino sistemas complejos de intercambio cataláctico donde los votantes demandan bienes públicos y favores a cambio de votos, los parlamentarios negocian apoyos cruzados (*logrolling*) y los burócratas buscan expandir el presupuesto y el poder de sus agencias.
2. **El Cálculo del Consenso (*The Calculus of Consent*, 1962):** En coautoría con Gordon Tullock, demostró que la regla de decisión colectiva (desde la autocracia hasta la unanimidad) no es un dogma moral, sino el resultado de minimizar la suma de dos costos: los **costos externos** de la decisión (el riesgo de que una coalición mayoritaria despoje o perjudique a la minoría) y los **costos de toma de decisión** (el tiempo, negociación y chantajes estratégicos necesarios para forjar el consenso).
3. **El Doble Nivel Constitucional:** Distinguió con claridad quirúrgica entre el **nivel constitucional** (donde los ciudadanos eligen las reglas del juego tras un velo de incertidumbre y se requiere cuasi-unanimidad) y el **nivel post-constitucional** (donde se juega dentro de las reglas y se delegan decisiones ordinarias a mayorías simples o cualificadas).
4. **La Búsqueda de Rentas (*Rent-Seeking*):** Reveló que cuando el Estado crea monopolios, cuotas o subsidios discrecionales, los grupos de interés invierten ingentes cantidades de recursos reales en cabildeo y favores políticos para capturar esos privilegios. Este gasto destruye valor social en una magnitud muy superior a las tradicionales pérdidas de eficiencia calculadas por la teoría económica clásica.
5. **Ilusión Fiscal y Sesgo al Déficit:** Advirtió que las democracias sin candados constitucionales sufren un sesgo crónico hacia el déficit y la deuda pública: los políticos financian gasto clientelar inmediato con deuda porque los votantes actuales no perciben la carga de impuestos que recaerá sobre las generaciones futuras.

## Metodología y resultados

### 1. El Modelo de Regla Óptima de Votación (Buchanan y Tullock, 1962)
Sea $k = K / N \in (0, 1]$ la fracción de la sociedad requerida para aprobar una decisión colectiva:
- **Costos Externos $C(k)$:** Probabilidad e impacto esperado de que una coalición gobernante imponga costos involuntarios al individuo. Función decreciente y convexa: $C'(k) < 0$, con $C(1) = 0$ (bajo unanimidad wickselliana nadie puede ser coaccionado contra su voluntad).
  $$C(k) = C_0 (1 - k)^\alpha, \quad C_0 > 0, \; \alpha \ge 1$$
- **Costos de Toma de Decisión $D(k)$:** Costo en tiempo, negociación y retención estratégica (*holdout*) para forjar una mayoría de tamaño $k$. Función creciente y convexa: $D'(k) > 0, D''(k) > 0$.
  $$D(k) = D_0 \left( \frac{k}{1 - k + \delta} \right)^\beta, \quad D_0 > 0, \; \beta \ge 1, \; \delta > 0$$
- **Condición de Primer Orden:** La regla óptima $k^*$ minimiza los costos totales de interdependencia $TC(k) = C(k) + D(k)$:
  $$-C'(k^*) = D'(k^*)$$
- **Hallazgo analítico fundamental:** La mayoría simple ($k = 0.50$) carece de cualquier propiedad intrínseca sagrada; es óptima solo cuando los costos externos y de negociación se balancean de forma simétrica. Cuando están en juego derechos constitucionales o potestades impositivas ($C_0 \uparrow$), la regla óptima salta naturalmente a **mayorías calificadas** ($k^* \in [0.67, 0.85]$).

### 2. Disipación Social en Concursos de Tullock (1967, 1980)
Frente a una renta artificial creada por el Estado de valor $R$, $n$ agentes compiten invirtiendo $x_i$ en cabildeo con probabilidad de adjudicación $p_i = x_i^r / \sum x_j^r$:
- En equilibrio simétrico de Nash ($r=1$):
  $$x^* = R \cdot \frac{n - 1}{n^2}, \quad X = \sum_{i=1}^n x_i^* = R \cdot \frac{n - 1}{n}$$
- **Tasa de disipación:** $DR = X / R = (n - 1) / n$. A medida que aumenta el número de postulantes ($n \to \infty$), **el 100% de la renta se disipa** en recursos desperdiciados.
- **Pérdida social total:** $SC = DWL_{\text{Harberger}} + X_{\text{Tullock}}$. En presencia de búsqueda de rentas, el daño del proteccionismo y la regulación discrecional es habitualmente entre **3 y 10 veces mayor** que la estimación convencional neoclásica.

## Antes y después

### Antes
- **El Estado como Planificador Social Benevolente:** La teoría del bienestar asumía que los gobiernos eran agentes neutrales y omniscientes guiados exclusivamente por maximizar el bienestar colectivo.
- **Fetiche de la Mayoría Simple:** La regla del 50% + 1 se consideraba la única definición legítima de democracia, ignorando el riesgo de que el 51% expoliara sistemáticamente al 49% restante.
- **Monopolios como Meras Transferencias:** Se creía que el beneficio extraordinario de un monopolista o de un arancel aduanero era una simple transferencia de dinero sin costo de bienestar adicional al triángulo de Harberger.
- **Teoría Keynesiana del Déficit Contracíclico:** Se enseñaba que los gobiernos acumularían superávits en los años de auge para compensar los déficits de las recesiones, asumiendo una neutralidad temporal que nunca se materializó en la práctica electoral.

### Después (qué cambió gracias al aporte)
- **"Política sin Romanticismo" y Consistencia Metodológica:** Los economistas y politólogos incorporaron el análisis de incentivos, la teoría de juegos y la búsqueda de rentas para modelar el comportamiento real de gobernantes y votantes.
- **Fundamento Económico de las Reglas Constitucionales:** Se demostró la necesidad de limitar el poder de las mayorías legislativas mediante mayorías supercalificadas para reformar la constitución o elevar impuestos.
- **Teoría de la Búsqueda de Rentas (*Rent-Seeking*):** La literatura económica comprendió que las barreras regulatorias y los subsidios provocan una masiva destrucción de capital y talento humano dirigidos a capturar favores gubernamentales.
- **Reglas Fiscales Vinculantes y Freno a la Deuda:** Inspiró el movimiento global hacia cláusulas constitucionales de equilibrio presupuestario, techos de deuda soberana y la independencia técnica de los bancos centrales frente a las urgencias electorales del poder ejecutivo.

## Cómo se aplica hoy

1. **Cláusulas Constitucionales de Freno a la Deuda (*Debt Breaks* en Europa y América Latina):**
   - **Alemania (2009):** Tras la crisis financiera global, Alemania incorporó a su Ley Fundamental (*Grundgesetz*, Artículos 109 y 115) el célebre *Schuldenbremse* (Freno a la Deuda), que prohíbe constitucionalmente a los estados federados incurrir en déficit estructural y limita el déficit federal al 0.35% del PIB. En noviembre de 2023, el Tribunal Constitucional Federal de Karlsruhe ratificó con contundencia la vigencia de esta regla buchananiana, anulando fondos extrapresupuestarios del gobierno.
   - **Suiza (2001/2003):** Adoptó en su Constitución Federal el mecanismo de freno al endeudamiento mediante referéndum ratificado por el 84.7% de los votantes, estabilizando la deuda pública federal suiza en torno al 20-30% del PIB durante las últimas dos décadas.
   - **España (2011):** Reformó el artículo 135 de la Constitución Española para consagrar el principio de estabilidad presupuestaria y priorizar el pago de intereses de la deuda pública sobre cualquier otro gasto.
2. **Supermayorías Constitucionales para Aumentos de Impuestos (EE.UU. y Gobiernos Estatales):**
   - La **Proposición 13 de California (1978)** y más de 15 legislaturas estatales estadounidenses (como Arizona, Nevada y Florida) exigen una mayoría calificada obligatoria de dos tercios (66.7%) en ambas cámaras legislativas para aprobar cualquier incremento de tarifas tributarias, aplicando de manera directa la recomendación de *The Calculus of Consent* para atajar la expoliación fiscal de mayorías simples.
   - La Enmienda TABOR (*Taxpayer's Bill of Rights*, Colorado, 1992) exige someter a referéndum popular obligatorio cualquier recaudación que supere la tasa de crecimiento poblacional e inflación.
3. **Auditoría Regulatoria y Combate a la Búsqueda de Rentas (OIRA en EE.UU. y Marcos RIA de la OCDE):**
   - En Estados Unidos, la **Oficina de Información y Asuntos Regulatorios** (OIRA, *Office of Information and Regulatory Affairs*), dependiente de la Casa Blanca bajo las Órdenes Ejecutivas 12866 y 14094 (actualizada en 2023), somete a toda regulación federal con impacto económico superior a $200 millones a una auditoría estricta de costo-beneficio para desincentivar el cabildeo corporativo y la creación artificial de rentas regulatorias.
   - Las directrices de la **OCDE sobre Política Regulatoria (2012, 2021)** prescriben el uso sistemático de Análisis de Impacto Regulatorio (RIA) para evitar la captura del regulador por monopolios oligárquicos protegidos.
4. **Independencia Constitucional de los Bancos Centrales:**
   - La separación legal de la política monetaria respecto del ciclo político (como en el Banco Central Europeo fundado en 1998, el Banco Central de Reserva del Perú en su Constitución de 1993 o el Banco de México en 1994) responde a la advertencia de Buchanan y Wagner (1977): evitar que los gobernantes recurran al "impuesto inflacionario" para financiar gasto electoral a corto plazo.

## Replicación en R
En el módulo de replicación (`replicacion/R/eleccion_publica_y_reglas_votacion.R` y `replicacion/replicar.qmd`) se simulan computacionalmente dos modelos esenciales:
1. **Regla de Votación Óptima de Buchanan-Tullock:** Modela la minimización de la función de costos totales $TC(k) = C(k) + D(k)$ para tres escenarios: ordinario ($k^* = 64.0\%$), constitucional ($k^* = 72.5\%$, justificando umbrales de mayoría calificada) y de emergencia ($k^* = 51.5\%$).
2. **Concurso de Búsqueda de Rentas de Tullock:** Computa el equilibrio de Nash simétrico ($x^*, X$) y la tasa de disipación social en función del número de competidores ($n \in [2, 30]$) y la tecnología de influencia ($r$), probando cómo el daño social se multiplica hasta quintuplicar la pérdida de bienestar calculada por el triángulo de Harberger tradicional.

Las figuras generadas en `replicacion/salidas/` ilustran:
- `fig_buchanan_regla_optima_votacion.png`: Curvas de costos externos $C(K)$, costos de negociación $D(K)$ y costo total $TC(K)$, contrastando los óptimos según el nivel de riesgo institucional.
- `fig_buchanan_disipacion_rentas.png`: Trayectoria de la tasa de disipación de rentas convergiendo al 100% a medida que aumenta el número de agentes en el concurso.
- `tab_resultados_buchanan.csv`: Métricas de costos, gastos individuales y multiplicadores de pérdida de bienestar social.

## Para profundizar
- **Buchanan, J. M., & Tullock, G. (1962).** *The Calculus of Consent: Logical Foundations of Constitutional Democracy*. University of Michigan Press. [Texto completo en Econlib](https://www.econlib.org/library/Buchanan/buchCv3.html).
- **Buchanan, J. M. (1987).** The Constitution of Economic Policy. *The American Economic Review*, 77(3), 243-250. (Conferencia del Premio Nobel 1986).
- **Tullock, G. (1967).** The Welfare Costs of Tariffs, Monopolies, and Theft. *Western Economic Journal*, 5(3), 224-232. [DOI: 10.1111/j.1465-7295.1967.tb01923.x](https://doi.org/10.1111/j.1465-7295.1967.tb01923.x).
- **Brennan, G., & Buchanan, J. M. (1980).** *The Power to Tax: Analytical Foundations of a Fiscal Constitution*. Cambridge University Press.
- **Buchanan, J. M., Tollison, R. D., & Tullock, G. (Eds.). (1980).** *Toward a Theory of the Rent-Seeking Society*. Texas A&M University Press.

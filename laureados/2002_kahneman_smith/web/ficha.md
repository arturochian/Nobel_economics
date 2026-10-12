---
anio: 2002
slug: 2002_kahneman_smith
laureados: ["Daniel Kahneman", "Vernon L. Smith"]
motivacion_oficial: "for having integrated insights from psychological research into economic science, especially concerning human judgment and decision-making under uncertainty [Daniel Kahneman], and for having established laboratory experiments as a tool in empirical economic analysis, especially in the study of alternative market mechanisms [Vernon L. Smith]"
area: ["Economía Conductual", "Economía Experimental", "Microeconomía Aplicada"]
tags: ["teoria prospectiva", "aversion a las perdidas", "ponderacion de probabilidades", "heuristica y sesgos", "economia experimental", "valor inducido", "subasta doble continua", "convergencia al equilibrio"]
referencias_clave: ["kahneman1979prospect", "tversky1992cumulative", "tversky1974judgment", "smith1962experimental", "smith1976induced", "smith1982microeconomic", "smith1988bubbles"]
replicacion: "laureados/2002_kahneman_smith/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase

Daniel Kahneman y Vernon L. Smith revolucionaron la microeconomía al sustituir la abstracción del *Homo oeconomicus* omnisciente por una ciencia empírica y psicológica rigurosa: Kahneman reveló los sesgos cognitivos y la aversión a las pérdidas que guían las decisiones humanas bajo incertidumbre, mientras Smith demostró que los experimentos de laboratorio son herramientas científicas indispensables para diseñar mecanismos de mercado que coordinan eficientemente a agentes con información incompleta.

## Resumen de la investigación

Durante décadas, la teoría económica tradicional operó bajo dos supuestos metodológicos incontrovertibles:
1. Que los individuos toman decisiones maximizando racionalmente la utilidad esperada según axiomas matemáticos abstractos.
2. Que la economía era una disciplina puramente observacional y no experimental, incapaz de replicar el método de laboratorio propio de las ciencias naturales.

El Premio Nobel de 2002 reconoció la demolición de estos dos dogmas:

1. **Daniel Kahneman y la Economía Conductual:**  
   En una colaboración intelectual legendaria con Amos Tversky, Kahneman demostró que el juicio humano bajo incertidumbre recurre sistemáticamente a **heurísticas cognitivas** (atajos mentales como representatividad, disponibilidad y anclaje) que conducen a sesgos sistemáticos. Formuló la **Teoría Prospectiva** (*Prospect Theory*, [Kahneman & Tversky, 1979](https://doi.org/10.2307/1914185); [Tversky & Kahneman, 1992](https://doi.org/10.1007/BF00122574)), que describe cómo las personas evalúan el riesgo:
   - **Dependencia de un punto de referencia:** Las decisiones no se toman sobre la riqueza total acumulada, sino sobre ganancias y pérdidas relativas al *status quo*.
   - **Aversión a las pérdidas (*loss aversion*):** La desutilidad psíquica de perder una suma de dinero es más de dos veces superior al placer de ganar esa misma cantidad ($\lambda \approx 2.25$).
   - **Ponderación no lineal de probabilidades:** Los agentes sobreponderan eventos altamente improbables (explicando la compra simultánea de billetes de lotería y seguros catastróficos) y subponderan probabilidades moderadas y altas.

2. **Vernon L. Smith y la Economía Experimental:**  
   Smith estableció la **economía experimental** como un campo empírico riguroso. A través de la **Teoría del Valor Inducido** (*Induced Value Theory*, [Smith, 1976](https://www.jstor.org/stable/1817233)), diseñó un protocolo para controlar las preferencias de los participantes en el laboratorio mediante incentivos monetarios reales.
   - En su experimento seminal de **subasta doble continua** (*double auction*, [Smith, 1962](https://doi.org/10.1086/258609)), descubrió que un grupo reducido de compradores y vendedores sin conocimiento previo de las curvas de oferta y demanda convergen rápidamente al precio y cantidad de equilibrio competitivo competitivo, alcanzando una eficiencia asignativa cercana al $100\%$.
   - Smith transformó el laboratorio en un banco de pruebas (*wind tunnel*) para evaluar el diseño de mercados complejos (desregulación eléctrica, derechos de aterrizaje aeroportuario y subastas financieras) antes de su implementación en la economía real.

## Metodología y resultados

1. **La Teoría Prospectiva Acumulativa (Kahneman & Tversky, 1979, 1992):**
   - **Función de Valor en forma de "S":** $v(x) = x^\alpha$ para $x \ge 0$, y $v(x) = -\lambda (-x)^\beta$ para $x < 0$. Con calibraciones empíricas canónicas $\alpha = \beta = 0.88$ y $\lambda = 2.25$, el modelo reproduce fielmente el **patrón de cuatro pliegues**: aversión al riesgo para ganancias moderadas/altas y pérdidas bajas, frente a búsqueda de riesgo para pérdidas moderadas/altas y ganancias improbables.
   - **Efecto Marco (*Framing Effect*):** Demostraron que alterar la presentación lingüística de un problema idéntico (p. ej. en el "dilema de la enfermedad asiática": presentar el resultado como "200 personas salvadas" frente a "400 personas morirán") invierte radicalmente las preferencias de la mayoría de la población de la aversión a la búsqueda de riesgo.

2. **La Subasta Doble y la Convergencia del Mercado (Smith, 1962, 1982):**
   - Smith asignó a participantes universitarios valores de reserva decrecientes (demanda) y costos crecientes (oferta).
   - En una subasta doble continua abierta, los precios transados exhibieron un rápido colapso en su variabilidad: el **coeficiente de convergencia $\alpha = 100 \times \sigma_P / P^*$** decayó drásticamente en menos de 4 a 6 rondas.
   - La eficiencia asignativa del mercado (excedente realizado sobre excedente potencial teórico) superó consistentemente el **$98\%-100\%$**, probando que las instituciones de mercado son capaces de coordinar eficazmente a agentes con información limitada.
   - En mercados de activos de vida finita ([Smith, Suchanek & Williams, 1988](https://doi.org/10.2307/1911361)), documentó cómo surgen burbujas especulativas endógenas seguidas de colapsos repentinos (*crashes*), demostrando que la repetición y la experiencia de los agentes son vitales para disciplinar los precios.

## Antes y después

### Antes
- **Axioma del *Homo oeconomicus*:** Se asumía que los seres humanos actúan como computadoras ultra-racionales, evaluando la utilidad esperada sobre su riqueza global con consistencia temporal perfecta.
- **La Economía como ciencia no experimental:** Los libros de texto afirmaban que los economistas, al igual que los astrónomos o meteorólogos, debían limitarse a observar pasivamente datos históricos del mundo real sin poder realizar experimentos controlados.
- **Conocimiento perfecto como requisito de la competencia:** La microeconomía clásica postulaba que para alcanzar el equilibrio competitivo de mercado era indispensable contar con infinitos agentes perfectamente informados sobre precios y funciones de costos agregadas.
- **Invarianza de la descripción:** Se asumía que la forma en que se redacta o presenta un contrato financiero o una política pública no altera la elección racional de los agentes.

### Después (qué cambió gracias al aporte)
- **Nacimiento de la Economía Conductual y Neuroeconomía:** La psicología cognitiva se fusionó con la teoría económica, transformando las finanzas, la teoría de juegos, la economía pública y el análisis del bienestar.
- **El Laboratorio como método estándar:** La economía experimental se convirtió en una herramienta científica central para validar modelos teóricos, auditar políticas y verificar mecanismos institucionales antes de su lanzamiento.
- **Poder disciplinador de las instituciones de mercado:** Se demostró que las reglas de intercambio (como la subasta doble) son más determinantes para la eficiencia asignativa que la sofisticación cognitiva individual de los operadores.
- **Arquitectura de las Decisiones (*Framing* y *Nudges*):** Se reconoció que el marco en el que se presentan las opciones y los puntos de referencia determinan las decisiones ciudadanas en salud, finanzas y previsión social.

## Cómo se aplica hoy

1. **Diseño y Desregulación de Mercados Eléctricos Mayoristas (FERC y PJM, EE. UU., 2000–2024):**  
   Tras la crisis energética de California en 2000-2001 provocada por manipulaciones de mercado, la Comisión Federal Reguladora de la Energía (FERC) y operadores independientes de red como PJM Interconnection e ISO New England recurrieron a los laboratorios de economía experimental fundados por Vernon Smith (en el *Economic Science Institute* de Chapman University). Utilizando simulaciones de subastas dobles con restricciones de red física y valor inducido, se optimizó el diseño de los algoritmos de precios marginales de localización (*Locational Marginal Pricing*, LMP) que hoy gestionan el despacho diario de electricidad para más de 65 millones de usuarios ([FERC Wholesale Electricity Market Studies, 2021](https://www.ferc.gov/electric-markets-properties)).

2. **Unidades de Ciencias de la Conducta en Políticas Públicas (*Nudge Units*, 2010–2025):**  
   Más de 200 entidades gubernamentales y organismos multilaterales (incluidos el *Behavioural Insights Team* del Reino Unido, la *Social and Behavioral Sciences Team* de la Casa Blanca, la OCDE y la unidad eMBeD del Banco Mundial) aplican sistemáticamente la Teoría Prospectiva. Diseñan campañas fiscales enmarcadas en la aversión a pérdidas ("No pierda el descuento por pronto pago" en lugar de "Gane un bono"), simplifican formularios de beneficios sociales y optimizan campañas de vacunación masiva ([OECD, Behavioural Insights in Public Policy, 2021](https://www.oecd.org/gov/regulatory-policy/behavioural-insights.htm); [World Bank eMBeD Report, 2023](https://www.worldbank.org/en/programs/embed)).

3. **Subastas de Derechos de Aterrizaje (*Airport Slots*) y Espectro Radioeléctrico (FAA y FCC, EE. UU. / Ofcom, Reino Unido, 2008–2024):**  
   La Federal Aviation Administration (FAA) y la Federal Communications Commission (FCC) utilizan bancos de pruebas experimentales en laboratorio (*wind-tunnel experiments*) basados en los protocolos smithianos para testear subastas combinatorias de franjas horarias de despegue y aterrizaje en aeropuertos congestionados (como LaGuardia y JFK de Nueva York) y subastas de espectro 5G. Los mecanismos se calibran en el laboratorio con operadores reales para descartar comportamientos colusorios y garantizar la eficiencia asignativa antes de poner en juego miles de millones de dólares ([FCC Spectrum Auctions Program, 2022](https://www.fcc.gov/auctions)).

4. **Regulación Financiera y Divulgación de Riesgos a Inversionistas (SEC, FINRA y ESMA, 2015–2024):**  
   Las autoridades de mercados financieros en EE. UU. (SEC, FINRA) y la Unión Europea (ESMA) incorporaron la investigación de Kahneman sobre heurística de representatividad y aversión a pérdidas en los estándares de divulgación de productos financieros estructurados. Los documentos de datos fundamentales (*Key Information Documents*, PRIIPs) exigen ilustrar escenarios de pérdidas extremas con puntos de referencia claros para evitar que los inversores minoristas caigan en la falacia del optimismo infundado o en ventas de pánico en mínimos del mercado.

## Replicación en R

La replicación computacional implementa dos módulos canónicos:
1. **Teoría Prospectiva:** Modelación de la función de valor con punto de referencia y asimetría de pérdidas ($\lambda = 2.25$, $\alpha = 0.88$) y la curva de ponderación de probabilidades $w(p)$ con forma de "S" invertida de Tversky & Kahneman (1992).
2. **Subasta Doble Experimental de Vernon Smith:** Simulación estocástica de un mercado con 11 compradores y 11 vendedores con valores y costos inducidos escalonados, rastreando la contracción del coeficiente de dispersión de precios $\alpha$ de Smith y la convergencia al equilibrio competitivo ($P^* = \$3.00$, $Q^* = 6$) con eficiencia del $100\%$.

El script ejecutable se encuentra en `replicacion/R/teoria_prospectiva_y_mercados_exp.R` y el reporte detallado en `replicacion/replicar.qmd`.

```bash
# Ejecutar script de replicación desde la raíz del repositorio
Rscript laureados/2002_kahneman_smith/replicacion/R/teoria_prospectiva_y_mercados_exp.R
```

## Para profundizar

- Kahneman, D. (2011). *Thinking, Fast and Slow*. Farrar, Straus and Giroux. (Obra divulgativa de referencia sobre los Sistemas 1 y 2, heurísticas y sesgos cognitivos).
- Smith, V. L. (2000). *Bargaining and Market Behavior: Essays in Experimental Economics*. Cambridge University Press.
- Smith, V. L. (2008). *Rationality in Economics: Constructivist and Ecological Forms*. Cambridge University Press. (Diferenciación entre racionalidad constructivista y racionalidad ecológica de las instituciones).
- Thaler, R. H. (2015). *Misbehaving: The Making of Behavioral Economics*. W. W. Norton & Company.
- Royal Swedish Academy of Sciences (2002). *Advanced Information on the Prize in Economic Sciences: Foundations of Behavioral and Experimental Economics*.

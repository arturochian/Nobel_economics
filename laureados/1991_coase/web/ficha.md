---
anio: 1991
slug: 1991_coase
laureados: ["Ronald H. Coase"]
motivacion_oficial: "for his discovery and clarification of the significance of transaction costs and property rights for the institutional structure and functioning of the economy"
area: ["Economía Institucional", "Organización Industrial", "Análisis Económico del Derecho (Law and Economics)"]
tags: ["costos de transacción", "teorema de coase", "naturaleza de la empresa", "derechos de propiedad", "externalidades", "organización industrial", "análisis económico del derecho"]
referencias_clave: ["coase1937nature", "coase1959fcc", "coase1960social_cost", "coase1974lighthouse", "coase1988firm_market_law", "coase1992nobel_lecture"]
replicacion: "laureados/1991_coase/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Ronald H. Coase transformó para siempre la ciencia económica al demostrar que los mercados no operan en el vacío sino a través de fricciones e instituciones: descubrió que las empresas existen para ahorrar los costos de transacción del sistema de precios y que la definición legal de los derechos de propiedad determina la resolución eficiente de las externalidades en el mundo real.

## Resumen de la investigación
Durante décadas, la teoría microeconómica tradicional asumió implícitamente un mundo de intercambio instantáneo, omnisciente y libre de fricciones. Bajo esa visión, los precios coordinaban automáticamente a los agentes sin requerir esfuerzo alguno, y cualquier "falla de mercado" (como la contaminación) exigía una intervención punitiva inmediata del Estado a través de impuestos pigouvianos o prohibiciones directas.

Ronald H. Coase (Escuela de Economía de Londres y Universidad de Chicago) dinamitó estos supuestos mediante dos artículos monumentales que dieron origen a dos disciplinas enteras: la **Nueva Economía Institucional** y el **Análisis Económico del Derecho** (*Law and Economics*):

1. **La Naturaleza de la Empresa (*The Nature of the Firm*, 1937):** Planteó una interrogante tan profunda como elemental: *Si el sistema de precios coordina la economía con tanta eficiencia, ¿por qué existen las empresas con jerarquías y jefes que ordenan a los trabajadores en vez de subcontratarlos continuamente en el mercado?* Coase descubrió los **costos de transacción**: recurrir al mercado tiene un precio real (costos de búsqueda de precios, negociación y redacción de contratos para cada tarea, y la incertidumbre contractual a largo plazo). Una empresa surge y sustituye al mercado cuando resulta más barato coordinar una transacción mediante la autoridad directa del empresario. Asimismo, el tamaño óptimo de la empresa tiene un límite: se expande hasta el punto donde el costo de organizar una transacción interna adicional iguala al costo de transarla en el mercado abierto o en otra empresa.
2. **El Problema del Costo Social (*The Problem of Social Cost*, 1960):** Examinó la interacción entre el derecho y la economía en presencia de externalidades. Coase argumentó que los perjuicios sociales son de **naturaleza recíproca**: evitar que una fábrica dañe a los vecinos implica dañar a la fábrica obligándola a cerrar o reducir su actividad. Formuló lo que George Stigler bautizó como el **Teorema de Coase**: en ausencia de costos de transacción y con derechos de propiedad claramente delimitados, las partes negociarán privadamente alcanzando una asignación socialmente eficiente de recursos, con independencia de a quién se le haya otorgado originalmente el derecho legal. Lejos de proponer que el mundo real carece de costos de transacción, Coase subrayó lo contrario: en la realidad, las fricciones son ubicuas ($T > 0$), y por ello **las leyes, la delimitación de derechos de propiedad y las instituciones jurídicas determinan de forma crítica la riqueza y la eficiencia económica de una nación**.

## Metodología y resultados

1. **La Frontera de la Empresa (Coase, 1937):**
   - Una firma compara en el margen dos alternativas de gobernanza económica:
     - Costo marginal de acudir al mercado: $MC_m(N) = m_0 + m_1 N$ (búsqueda, redacción de contratos, oportunismo).
     - Costo marginal de coordinación interna jerárquica: $MC_f(N) = g_0 + g_1 N$ (congestión burocrática, distorsión de información y costos de agencia).
   - La frontera óptima de integración vertical ($N^*$) se alcanza donde $MC_f(N^*) = MC_m(N^*)$:
     $$N^* = \frac{m_0 - g_0}{g_1 - m_1}$$
   - Si las innovaciones tecnológicas o las plataformas abaratan las transacciones abiertas ($m_0 \downarrow$), la empresa óptima se encoge, provocando externalización (*outsourcing*) y desintegración vertical.

2. **El Teorema de Coase y la Eficiencia Social (Coase, 1960):**
   - Sean $MB(Q) = p_0 - b Q$ el beneficio marginal del causante y $MD(Q) = c Q$ el daño marginal de la víctima.
   - El óptimo de bienestar social exige $MB(Q^*) = MD(Q^*)$, obteniendo:
     $$Q^* = \frac{p_0}{b + c}, \quad W(Q^*) = \frac{p_0^2}{2(b + c)}$$
   - **Caso $T = 0$ (Fricciones nulas):**
     - Si la ley favorece a la fábrica (derecho a emitir), la víctima paga una compensación para reducir de $Q_{priv} = \frac{p_0}{b}$ a $Q^*$.
     - Si la ley favorece a los vecinos (derecho al cese total), la fábrica compra permisos para operar hasta $Q^*$.
     - En ambos regímenes se alcanza exactamente $Q^*$; la asignación de recursos es invariante.
   - **Caso $T > 0$ (Mundo real con fricciones):**
     - Las partes negocian si y solo si la ganancia social bruta del acuerdo excede los costos de transacción ($\Delta W > T$).
     - Dado que la ganancia de evitar un daño excesivo ($\Delta W_A$) difiere de la ganancia de permitir una actividad valiosa ($\Delta W_B$), una regla legal inadecuada condena a la economía al colapso de la negociación y a la pérdida irrecuperable de bienestar ($DWL$).

## Antes y después

### Antes
- **Mercados sin fricción ("Pizarra vacía"):** La economía neoclásica asumía que el sistema de precios funcionaba de manera instantánea y gratuita sin costos de búsqueda ni contratación.
- **La empresa como caja negra tecnológica:** Las empresas se modelaban exclusivamente como funciones de producción matemáticas ($y = f(K, L)$), sin explicar por qué existía la jerarquía interna ni qué determinaba los límites de la organización.
- **Visión unidireccional de las externalidades:** La teoría de Pigou consideraba la contaminación como un pecado unilateral que debía corregirse de forma mecánica con impuestos o prohibiciones del Estado.
- **Separación absoluta entre Derecho y Economía:** Los juristas redactaban leyes basados en conceptos abstractos de equidad o culpa moral, sin considerar cómo las reglas de responsabilidad alteraban los incentivos de producción y el costo social.

### Después (qué cambió gracias al aporte)
- **Centralidad de los Costos de Transacción:** Se demostró que las instituciones, contratos y leyes existen precisamente para canalizar y reducir los costos de transacción omnipresentes en la realidad.
- **Teoría Moderna de la Empresa y Gobernanza:** Inspiró a Oliver Williamson (Nobel 2009) y a Oliver Hart (Nobel 2016) en el desarrollo de la economía de los contratos incompletos, la especificidad de activos y los derechos residuales de control.
- **Reconceptualización de las Externalidades:** Las externalidades pasaron a entenderse como problemas de derechos de propiedad mal delimitados o costos de transacción prohibitivos, habilitando soluciones de mercado como las subastas de derechos y cuotas transables.
- **Nacimiento del *Law and Economics*:** Las escuelas de leyes y los tribunales incorporaron el análisis de costos de transacción para redactar contratos eficientes y fijar indemnizaciones basadas en el criterio del "evitador del daño al menor costo" (*cheapest cost avoider*).

## Cómo se aplica hoy

1. **Subastas de Espectro Radioeléctrico de la FCC (1994–presente):**
   - *Institución:* Comisión Federal de Comunicaciones de EE.UU. ([FCC](https://www.fcc.gov/auctions)) y reguladores globales de telecomunicaciones (Ofcom en el Reino Unido, IFT en México).
   - *Aplicación:* En 1959, Coase publicó *"The Federal Communications Commission"*, argumentando que el espectro de radio y frecuencias electromagnéticas no debía asignarse mediante audiencias políticas discrecionales, sino a través de derechos de propiedad transables y subastas de precios.
   - *Impacto:* El Congreso de EE.UU. adoptó formalmente la recomendación en 1993, y en julio de 1994 la FCC lanzó la primera subasta competitiva de espectro. Desde entonces, este mecanismo de mercado coaseano ha recaudado más de **200,000 millones de dólares** para el Tesoro de EE.UU., optimizando el despliegue de redes móviles 3G, 4G y 5G a nivel mundial.

2. **Mercados de Derechos de Emisión y Sistemas Cap-and-Trade (EPA 1990, Directiva Europea EU ETS 2005):**
   - *Institución:* Agencia de Protección Ambiental de EE.UU. ([US EPA](https://www.epa.gov/airmarkets/acid-rain-program)) y la Comisión Europea ([EU ETS](https://climate.ec.europa.eu/eu-action/eu-emissions-trading-system-eu-ets_en)).
   - *Aplicación:* En lugar de ordenar a cada fábrica qué filtros instalar mediante costosa regulación de comando y control, el enfoque coaseano define un techo máximo de emisiones agregado (*cap*) y distribuye permisos de propiedad negociables (*trade*).
   - *Impacto:* El *Acid Rain Program* estadounidense (creado bajo las *Clean Air Act Amendments* de 1990) redujo las emisiones de dióxido de azufre ($SO_2$) en más del 50% con un ahorro estimado de miles de millones de dólares frente a la regulación burocrática. Siguiendo este principio, la Unión Europea implementó en 2005 el Sistema de Comercio de Emisiones de la UE (EU ETS), el mayor mercado de carbono multilateral del mundo.

3. **La Economía de Plataformas y la Contracción de la Firma (Uber, Airbnb, Amazon Marketplace, 2008–presente):**
   - *Institución:* Empresas de plataforma digital e intermediación algorítmica ([Uber Technologies](https://www.uber.com), Airbnb, Upwork).
   - *Aplicación:* La teoría de Coase de 1937 predijo que si los costos de descubrir precios, verificar la reputación y redactar acuerdos caen drásticamente, la frontera de la empresa jerárquica se contrae hacia el mercado abierto.
   - *Impacto:* Plataformas como Uber (2009) o Airbnb (2008) no poseen flotas de vehículos ni hoteles propios; utilizan software para reducir los costos de transacción de emparejamiento entre millones de oferentes y demandantes a niveles cercanos a cero, sustituyendo las corporaciones integradas verticalmente por redes distribuidas y economía gig (*gig economy*).

4. **El Análisis Económico del Derecho de Daños y Responsabilidad Civil en Cortes de Justicia:**
   - *Institución:* Poder Judicial de los Estados Unidos y doctrinas jurisprudenciales de la Escuela de Chicago y Yale (Guido Calabresi, Richard Posner).
   - *Aplicación:* Cuando un accidente involucra a múltiples partes donde la negociación previa es imposible (altos costos de transacción), los tribunales judiciales aplican el criterio coaseano: la regla de negligencia o responsabilidad estricta debe imponerse sobre la parte que podía precaver el riesgo al costo más bajo (*cheapest cost avoider*), minimizando así el costo social conjunto de los accidentes y de las precauciones.

## Replicación en R
En la carpeta [`replicacion/`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/1991_coase/replicacion/) se encuentra el script autónomo [`R/teorema_coase_y_costos_transaccion.R`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/1991_coase/replicacion/R/teorema_coase_y_costos_transaccion.R), el cual ejecuta una simulación numérica exhaustiva:

- **Simulación Coaseana de Externalidades:** Modela las curvas de beneficio y daño marginal, calcula analíticamente el óptimo social ($Q^* = 60, W^* = \$3,600$) y evalúa el bienestar social neto en función de los costos de transacción $T \in [0, 4,500]$. Demuestra cómo el régimen legal inicial se vuelve decisivo una vez que $T$ supera el umbral de ganancia del pacto, generando la figura [`salidas/fig_coase_negociacion_externalidad.png`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/1991_coase/replicacion/salidas/fig_coase_negociacion_externalidad.png).
- **Frontera Óptima de la Empresa:** Modela los costos marginales de mercado ($MC_m$) y los costos marginales de organización jerárquica interna ($MC_f$). Demuestra cómo una disrupción digital en los costos de transacción contrae la escala óptima integrada de $71.4$ a $20.0$ transacciones, generando la figura [`salidas/fig_coase_frontera_empresa.png`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/1991_coase/replicacion/salidas/fig_coase_frontera_empresa.png).
- **Tabla Cuantitativa:** Los resultados numéricos se guardan en [`salidas/tab_resultados_coase.csv`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/1991_coase/replicacion/salidas/tab_resultados_coase.csv).

## Para profundizar
- **coase1937nature:** Coase, R. H. (1937). *The Nature of the Firm*. *Economica*, 4(16), 386–405. Artículo fundacional de la teoría de la empresa y los costos de transacción.
- **coase1959fcc:** Coase, R. H. (1959). *The Federal Communications Commission*. *The Journal of Law and Economics*, 2, 1–40. Origen de las subastas de espectro radioeléctrico y los derechos de propiedad en recursos etéreos.
- **coase1960social_cost:** Coase, R. H. (1960). *The Problem of Social Cost*. *The Journal of Law and Economics*, 3, 1–44. El artículo más citado en la historia de la ciencia económica y del derecho.
- **coase1974lighthouse:** Coase, R. H. (1974). *The Lighthouse in Economics*. *The Journal of Law and Economics*, 17(2), 357–376. Desmitificación histórica del faro como bien público puro que necesariamente exige provisión estatal.
- **coase1988firm_market_law:** Coase, R. H. (1988). *The Firm, the Market, and the Law*. University of Chicago Press. Recopilación de ensayos seminales y clarificación contra las malas interpretaciones del "cero costos de transacción".
- **coase1992nobel_lecture:** Coase, R. H. (1992). *The Institutional Structure of Production: Nobel Lecture*. *The American Economic Review*, 82(4), 713–719. Discurso Nobel sobre el papel de las instituciones en la producción real.
- **nobel1991_advanced:** The Economic Sciences Prize Committee of the Royal Swedish Academy of Sciences (1991). *Ronald H. Coase's Contributions to Economics: Advanced Information*. Documento oficial del Comité Nobel.

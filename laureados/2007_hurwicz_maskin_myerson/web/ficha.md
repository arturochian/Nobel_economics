---
anio: 2007
slug: 2007_hurwicz_maskin_myerson
laureados: ["Leonid Hurwicz", "Eric S. Maskin", "Roger B. Myerson"]
motivacion_oficial: "for having laid the foundations of mechanism design theory"
area: ["Microeconomía", "Teoría de Juegos", "Diseño de Mecanismos"]
tags: ["diseño de mecanismos", "principio de revelación", "compatibilidad de incentivos", "teorema de equivalencia del ingreso", "mecanismo VCG", "implementación en equilibrio de Nash"]
referencias_clave: ["hurwicz1972informationally", "hurwicz1973design", "myerson1979incentive", "myerson1981optimal", "maskin1999nash", "myerson1983efficient", "nobel2007scientific"]
replicacion: "laureados/2007_hurwicz_maskin_myerson/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Leonid Hurwicz, Eric S. Maskin y Roger B. Myerson sentaron las bases de la teoría del diseño de mecanismos, creando la ingeniería matemática que permite diseñar reglas e incentivos institucionales para que agentes privados con información secreta e intereses egoístas alcancen resultados socialmente óptimos.

## Resumen de la investigación
Desde Adam Smith, la doctrina económica sostenía que la competencia descentralizada y la "mano invisible" aseguraban que el interés propio guiara los recursos hacia su uso más eficiente. Sin embargo, en el mundo real abundan las transacciones donde los mercados competitivos no existen o fallan estrepitosamente: desde la provisión de bienes públicos y la mitigación del cambio climático hasta las subastas de frecuencias de telecomunicaciones, la compra pública de suministros hospitalarios o la regulación de monopolios naturales. En todos estos contextos, los participantes poseen **información privada** (cuánto valoran un servicio, cuáles son sus verdaderos costes de producción) y tienen fuertes incentivos para mentir o comportarse como polizones (*free riders*).

La teoría del diseño de mecanismos (*mechanism design theory*) invirtió la metodología analítica tradicional. En vez de tomar las instituciones de mercado existentes como dadas y observar pasivamente su equilibrio, el economista actúa como un **arquitecto institucional**: formula en primer lugar el objetivo colectivo deseado (eficiencia social de Pareto, equidad distributiva o maximización de ingresos públicos) y deduce matemáticamente las reglas de juego, pagos y penalizaciones necesarias para que los participantes elijan, de forma voluntaria y no coactiva, las decisiones que maximizan el bienestar colectivo.

A partir de 1972, **Leonid Hurwicz** definió formalmente el concepto de mecanismo y demostró que la dispersión de información privada impone un límite insalvable: ningún mecanismo puede lograr la eficiencia de primer mejor a menos que sea **compatible con incentivos** (*incentive compatible*). Posteriormente, **Eric Maskin** (1977, 1999) fundó la **teoría de la implementación**, determinando qué funciones de bienestar social pueden ejecutarse en equilibrio de Nash y cómo diseñar juegos que descarten equilibrios indeseados. Finalmente, **Roger Myerson** (1979, 1981) formuló el **Principio de Revelación** universal y el **Teorema de Equivalencia del Ingreso**, caracterizando la arquitectura óptima de subastas y fijando los límites insuperables del comercio voluntario (el Teorema de Myerson-Satterthwaite de 1983).

## Metodología y resultados
1. **Compatibilidad de Incentivos y Teorema de Imposibilidad de Hurwicz (1972, 1973):**
   Hurwicz modeló un mecanismo como un conjunto de mensajes $M_i$ y una función de asignación de resultados $g(m_1, \dots, m_N)$. Demostró que en economías donde los agentes tienen poder de mercado o información asimétrica sobre sus preferencias, **ningún mecanismo descentralizado no dictatorial puede lograr una asignación de Pareto eficiente en todos los entornos posibles**: cualquier intento de redistribuir o financiar bienes públicos induce a los agentes a distorsionar estratégicamente sus señales si no se compensan adecuadamente sus incentivos marginales.

2. **El Principio de Revelación (Hurwicz 1972; Myerson 1979, 1981):**
   Myerson probó que cualquier resultado implementable mediante un juego estratégico complejo (subastas por fases, regateo multidimensional) puede replicarse exactamente mediante un **mecanismo directo y veraz**, donde los agentes simplemente declaran su verdadero tipo ($\hat{\theta}_i = \theta_i$) y decir la verdad es un equilibrio de Nash-Bayes:
   $$\mathbb{E}_{\theta_{-i}}[u_i(x(\theta_i, \theta_{-i}), p(\theta_i, \theta_{-i})) \mid \theta_i] \ge \mathbb{E}_{\theta_{-i}}[u_i(x(\hat{\theta}_i, \theta_{-i}), p(\hat{\theta}_i, \theta_{-i})) \mid \theta_i] \quad \forall \hat{\theta}_i$$
   Este principio redujo el análisis de una infinidad inmanejable de instituciones a la caracterización de funciones directas que satisfacen las restricciones de compatibilidad de incentivos (IC) y racionalidad individual (IR).

3. **Mecanismo Vickrey-Clarke-Groves (VCG) y la Regla Pivote:**
   Hurwicz y sus contemporáneos formalizaron el mecanismo VCG para utilidades cuasilineales. Para un proyecto público con coste $C$, la obra se realiza si $\sum \hat{v}_i \ge C$. Cada participante paga la externalidad neta impuesta sobre los demás:
   $$p_i = \max\left(0, C - \sum_{j \ne i} \hat{v}_j\right)$$
   Al obligar a cada individuo a internalizar el costo que impone a la sociedad, reportar la valoración veraz ($\hat{v}_i = v_i$) se convierte en una **estrategia débilmente dominante** (DSIC).

4. **Teorema de Implementación de Maskin (1977, 1999):**
   Maskin descubrió que para que una función de elección social $F$ sea implementable en equilibrio de Nash con $N \ge 3$ agentes, debe satisfacer la propiedad de **Monotonicidad de Maskin**: si un resultado $a$ es socialmente elegido bajo el perfil de preferencias $R$, y al cambiar al perfil $R'$ el resultado $a$ no cae en el ranking relativo de ningún individuo, entonces $a$ debe seguir siendo socialmente elegido bajo $R'$. Demostró que la monotonicidad, combinada con la ausencia de veto de poder (*no-veto power*), es condición necesaria y casi suficiente para la implementación plena.

5. **Teorema de Equivalencia del Ingreso y Subastas Óptimas (Myerson, 1981):**
   Myerson demostró que para $N$ postores neutrales al riesgo con valoraciones independientes e idénticamente distribuidas (IID) según $F(v)$, **cualquier mecanismo de subasta eficiente donde el postor de menor valoración obtenga cero excedente genera exactamente el mismo ingreso esperado para el vendedor**. Para $v \sim \mathcal{U}[0, \bar{v}]$, este ingreso equivale al valor esperado de la segunda estadística de orden:
   $$\mathbb{E}[R] = \frac{N - 1}{N + 1} \bar{v}$$
   Asimismo, Myerson derivó el mecanismo de recaudación óptima introduciendo el concepto de **valor virtual**:
   $$J(v) = v - \frac{1 - F(v)}{f(v)}$$
   probando que el vendedor debe imponer un precio de reserva estricto $v^* = J^{-1}(0) > 0$ que excluye deliberadamente a postores de baja valoración para extraer rentas informativas a los postores de alta valoración.

## Antes y después

### Antes
- **La dicotomía estéril entre libre mercado y planificación central:** El debate económico oscilaba entre posturas ideológicas binarias: la fe ciega en que los mercados desregulados resuelven todo problema, o la creencia de que un planificador benevolente puede recolectar información centralizada sin fricciones.
- **Incomprensión de las fallas institucionales:** Se atribuía el fracaso de negociaciones bilaterales o la degradación de bienes públicos a irracionalidad psicológica, miopía o falta de ética de los agentes, sin un modelo formal de asimetría de información.
- **Diseño ad-hoc e intuitivo de licitaciones públicas:** Los gobiernos organizaban subastas y contrataciones mediante formatos empíricos arbitrarios, expuestos a la colusión, la corrupción y el "mal del perdedor" o la maldición del ganador.

### Después (qué cambió gracias al aporte)
- **Nacimiento de la ingeniería económica (*market design*):** Los economistas dejaron de ser meros observadores pasivos y se convirtieron en ingenieros institucionales capaces de programar reglas y algoritmos que garantizan la compatibilidad de incentivos.
- **El Principio de Revelación como estándar metodológico:** Se unificó toda la literatura de microeconomía aplicada, regulación de monopolios, contratos laborales, seguros y finanzas públicas bajo un marco matemático riguroso y tratable.
- **Revolución práctica en la asignación de recursos públicos:** La teoría del diseño de mecanismos permitió crear las subastas multimillonarias de espectro radioeléctrico, las subastas de derechos de emisión de carbono y los sistemas algorítmicos de adjudicación de compras públicas.

## Cómo se aplica hoy

1. **Subastas de Publicidad Digital en Tiempo Real de Google y Meta (2007–2024):**
   El motor económico de internet descansa íntegramente sobre la teoría de mecanismos. Plataformas como Google Ads y Meta subastan miles de millones de impresiones publicitarias por segundo mediante variantes de la Subasta de Segundo Precio Generalizada (GSP) y mecanismos directos VCG ([Edelman, Ostrovsky y Schwarz, 2007, American Economic Review](https://doi.org/10.1257/aer.97.1.242); [Meta Research on VCG Auctions](https://research.facebook.com/publications/bidding-in-vickrey-clarke-groves-auctions-with-budget-constraints/)). Los anunciantes reportan su disposición máxima a pagar por clic sabiendo que el algoritmo cobrará la externalidad marginal impuesta al desplazar a los competidores, lo que garantiza estabilidad en las pujas y previene manipulaciones estratégicas continuas.

2. **Licitaciones de Contratación Pública y Compras del Estado (Directiva 2014/24/UE y FAR de EE. UU.):**
   Las agencias estatales utilizan el teorema de subasta óptima de Myerson para licitar infraestructuras y suministros médicos ([Directiva Europea 2014/24/UE sobre Contratación Pública](https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=celex%3A32014L0024)). Mediante subastas inversas electrónicas con precios de reserva calculados a partir de distribuciones de costes virtuales y fórmulas de ponderación técnica a prueba de colusión, las administraciones públicas consiguen ahorros fiscales de entre un 10% y un 25% frente a las licitaciones cerradas tradicionales.

3. **Asignación Eficiente de Slots de Aterrizaje en Aeropuertos Congestionados (FAA y Eurocontrol, 2020–2024):**
   Ante la saturación extrema del espacio aéreo en aeropuertos como JFK, LaGuardia y Londres-Heathrow, la Administración Federal de Aviación (FAA) y las autoridades europeas han implementado mecanismos de mercado de subastas combinatorias de horarios de vuelo ([FAA Slot Allocation Management](https://www.faa.gov/about/office_org/headquarters_offices/ato/service_units/system_operations/slots)). Estos mecanismos compatibles con incentivos eliminan el acaparamiento histórico (*slot squatting*) y permiten que los despegues y aterrizajes se asignen a las aerolíneas que maximizan la conectividad y el beneficio del usuario.

## Replicación en R
- **Qué se replicó:** Simulación microeconómica ilustrativa de dos pilares normativos del premio:
  1. El mecanismo Vickrey-Clarke-Groves (VCG) para la financiación de un proyecto público ($C = 120, N = 3$), evaluando numéricamente la utilidad esperada de un agente representativo sobre una grilla exhaustiva de reportes falsos y verdaderos para verificar la propiedad DSIC frente a una regla ingenua de costo fijo.
  2. El Teorema de Equivalencia del Ingreso de Myerson (1981) mediante una simulación Monte Carlo de $100\,000$ subastas con $N = 4$ postores independientes con valoraciones $v_i \sim \mathcal{U}[0, 100]$. Se compararon cuatro formatos de licitación: Subasta de Primer Precio (FPA), Subasta de Segundo Precio (SPA / Vickrey), Subasta Inglesa Ascendente y Subasta de Todos Pagan (All-Pay Auction).
- **Entorno de ejecución:** Script autónomo [mecanismos_vcg_y_myerson.R](../replicacion/R/mecanismos_vcg_y_myerson.R) ejecutado en R 4.6.0 (`tidyverse`, `scales`, `patchwork`).
- **Principales hallazgos cuantitativos:**
  - En la simulación VCG ([fig_vcg_revelacion_veraz.png](../replicacion/salidas/fig_vcg_revelacion_veraz.png)), la utilidad neta esperada alcanza su máximo estricto y exacto cuando la valoración declarada coincide con el valor verdadero ($v \in \{35, 50, 65\}$), mientras que la regla de reparto uniforme genera incentivos masivos al *free-riding* y a la subinversión.
  - En el teorema de Myerson ([tab_resultados_mecanismos.csv](../replicacion/salidas/tab_resultados_mecanismos.csv)), el ingreso medio simulado del vendedor converge exactamente a la predicción teórica de $\mathbf{60.00}$:
    * Subasta de Primer Precio: $59.9503 \pm 0.0386$ (SD $= 12.21$).
    * Subasta de Segundo Precio / Inglesa: $60.0207 \pm 0.0632$ (SD $= 19.97$).
    * Subasta de Todos Pagan: $59.8451 \pm 0.1265$ (SD $= 40.01$).
  - La eficiencia asignativa es del $100.0\%$ en los cuatro formatos, evidenciando que, aunque la dispersión del ingreso del vendedor varía ostensiblemente, el ingreso esperado es matemáticamente idéntico tal como demostró Myerson.
- **Limitaciones:** La simulación asume postores neutrales al riesgo con valoraciones privadas independientes sin restricciones financieras. Si los postores son adversos al riesgo, la equivalencia del ingreso se rompe a favor de la subasta de primer precio; si los postores tienen valores comunes (*common values*), entra en juego la maldición del ganador analizada por Milgrom y Wilson (2020).

## Para profundizar
- Hurwicz, L. (1972). *On Informationally Decentralized Systems*. En C. B. McGuire & R. Radner (Eds.), Decision and Organization: A Volume in Honor of Jacob Marschak, 297-336 [@hurwicz1972informationally].
- Hurwicz, L. (1973). *The Design of Mechanisms for Resource Allocation*. The American Economic Review, 63(2), 1-30 [@hurwicz1973design].
- Myerson, R. B. (1979). *Incentive Compatibility and the Bargaining Problem*. Econometrica, 47(1), 61-73 [@myerson1979incentive].
- Myerson, R. B. (1981). *Optimal Auction Design*. Mathematics of Operations Research, 6(1), 58-73 [@myerson1981optimal].
- Maskin, E. (1999). *Nash Equilibrium and Welfare Optimality*. The Review of Economic Studies, 66(1), 23-38 [@maskin1999nash].
- Myerson, R. B., & Satterthwaite, M. A. (1983). *Efficient Mechanisms for Bilateral Trading*. Journal of Economic Theory, 29(2), 265-281 [@myerson1983efficient].
- Royal Swedish Academy of Sciences (2007). *Mechanism Design Theory*. Scientific Background on the Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 2007 [@nobel2007scientific].

---
anio: 1996
slug: 1996_mirrlees_vickrey
laureados: ["James A. Mirrlees", "William Vickrey"]
motivacion_oficial: "for their fundamental contributions to the economic theory of incentives under asymmetric information"
area: ["Microeconomía", "Finanzas Públicas", "Teoría de Juegos", "Diseño de Mecanismos"]
tags: ["información asimétrica", "tributación óptima", "subasta de segundo precio", "subasta de Vickrey", "compatibilidad de incentivos", "teorema de equivalencia del ingreso", "tarificación por congestión", "screening"]
referencias_clave: ["mirrlees1971exploration", "diamond1971optimal1", "diamond1971optimal2", "mirrlees1976optimal", "vickrey1961counterspeculation", "vickrey1969congestion", "nobel1996scientific", "nobel1996popular"]
replicacion: "laureados/1996_mirrlees_vickrey/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
James Mirrlees y William Vickrey revolucionaron la ciencia económica al demostrar matemáticamente cómo diseñar impuestos, subastas y tarifas públicas eficientes cuando los individuos ocultan información privada crucial sobre su verdadera productividad, preferencias o disposición a pagar.

## Resumen de la investigación
Hasta comienzos de la década de 1960, la economía normativa y del bienestar operaba bajo una ficción conveniente: se asumía que el Estado o el mercado podían observar sin fricciones las capacidades intrínsecas, costos o valoraciones de cada individuo. Bajo ese prisma idílico, cualquier objetivo de justicia social podía lograrse teóricamente mediante impuestos de suma fija (*lump-sum taxes*) que redistribuyeran la riqueza sin alterar la eficiencia productiva de Pareto.

William Vickrey y James Mirrlees demolieron esa presunción y fundaron el análisis riguroso de los **incentivos bajo información asimétrica** (*incentives under asymmetric information*):

1. **William Vickrey (1961, 1969):** Pionero absoluto del diseño institucional de mercados. En su trabajo seminal sobre subastas (1961), Vickrey descubrió que las subastas tradicionales en sobre cerrado obligan a los participantes a adivinar especulativamente las ofertas ajenas, provocando ineficiencias. Ideó la **Subasta de Segundo Precio** (*Second-Price Sealed-Bid Auction*, hoy conocida como **Subasta de Vickrey**), donde el postor más alto gana pero paga únicamente la segunda puja más alta. Probó que este mecanismo hace que revelar la valoración veraz sea una **estrategia débilmente dominante**, y demostró el célebre **Teorema de Equivalencia del Ingreso** (*Revenue Equivalence Theorem*). Asimismo, Vickrey (1963, 1969) formuló la teoría de la **tarificación de la congestión en tiempo real** (*congestion pricing*), probando que un peaje dependiente de la hora punta elimina las colas en puentes y carreteras sin perjudicar el bienestar del usuario.

2. **James A. Mirrlees (1971, 1976):** Abordó el dilema más esquivo de la hacienda pública: ¿cómo debe gravar el Estado el ingreso laboral para financiar bienes públicos y redistribuir riqueza sin destruir los incentivos al trabajo? Dado que el gobierno no puede observar la productividad innata del trabajador ni su esfuerzo laboral por separado —solo puede registrar el ingreso bruto observado—, los individuos de alta productividad tienen el incentivo de reducir su jornada laboral y "hacerse pasar" por trabajadores de baja productividad si las transferencias son generosas. Mirrlees estructuró el problema como un modelo matemático de **screening e incentivos compatibles**, deduciendo que la tasa impositiva marginal óptima en el tope de la distribución de ingresos debe ser exactamente **cero** (*zero top marginal rate*), y derivó las condiciones para las tasas marginales a lo largo de toda la distribución.

## Metodología y resultados

1. **La Subasta de Segundo Precio y la Revelación Veraz (Vickrey, 1961):**
   Para $N$ postores con valores privados independientes, Vickrey modeló la utilidad de un postor con valoración $v_i$ que oferta $b_i$ frente a la puja máxima rival $Y = \max_{j \ne i} b_j$. El pago es $p = Y$ si gana. Demostró que:
   - Ofertar $b_i > v_i$ no incrementa el beneficio cuando se gana de forma rentable ($Y < v_i$), pero genera pérdidas netas estrictas ($v_i - Y < 0$) cuando la puja inflada supera a un rival más alto ($v_i < Y < b_i$).
   - Ofertar $b_i < v_i$ no reduce el precio a pagar cuando se gana ($Y < b_i$), pero causa la pérdida de transacciones rentables ($b_i < Y < v_i$).
   Por consiguiente, la puja sincera $b_i = v_i$ es una **estrategia dominante** (DSIC), eliminando el costo cognitivo de especular sobre los rivales.

2. **El Teorema de Equivalencia del Ingreso (Vickrey, 1961):**
   Vickrey demostró que bajo valores privados independientes, postores simétricos neutrales al riesgo y precios de reserva idénticos, cuatro formatos aparentemente divergentes —la Subasta de Primer Precio en sobre cerrado, la Subasta de Segundo Precio (Vickrey), la Subasta Abierta Ascendente (Inglesa) y la Subasta Abierta Descendente (Holandesa)— generan **exactamente el mismo ingreso esperado para el vendedor**:
   $$\mathbb{E}[R] = \frac{N - 1}{N + 1} \bar{v} \quad \text{para } v \sim \mathcal{U}[0, \bar{v}]$$
   No obstante, la varianza de la recaudación difiere: la subasta de primer precio presenta menor volatilidad ($\sigma_{FPSB}^2 < \sigma_{SPSB}^2$), por lo que los vendedores con aversión al riesgo prefieren el formato de primer precio.

3. **Tributación Óptima del Ingreso y el Problema de Screening (Mirrlees, 1971):**
   Mirrlees formuló el problema del planificador utilitarista que maximiza:
   $$W = \int u(c(w), y(w)/w) f(w) dw$$
   sujeto al balance presupuestario del gobierno $\int (y(w) - c(w)) f(w) dw \ge 0$ y a la **restricción de compatibilidad de incentivos (IC)**:
   $$u(c(w), y(w)/w) \ge u(c(w'), y(w')/w) \quad \forall w, w'$$
   Mediante cálculo variacional y teoría de control óptimo (principio del máximo de Pontryagin), Mirrlees probó:
   - **Tasa Marginal Cero en el Tope:** Si la distribución de habilidades está acotada superiormente en $\bar{w}$, la tasa impositiva marginal en el extremo superior es idénticamente cero ($\tau'(\bar{w}) = 0$). Gravar marginalmente al individuo más productivo desincentiva su esfuerzo sin proveer beneficios distributivos adicionales hacia abajo.
   - **Tasa Marginal Positiva hacia Abajo:** Para todos los niveles intermedios y bajos, $\tau'(w) > 0$. Distorsionar a la baja la producción de los menos productivos es necesario para hacer que dicho paquete sea poco atractivo para los trabajadores de alta productividad, relajando la restricción de incentivos.

4. **Teorema de Eficiencia Productiva (Diamond y Mirrlees, 1971):**
   En dos artículos conjuntos en la *American Economic Review*, Diamond y Mirrlees demostraron que aun cuando el gobierno no pueda gravar de forma óptima a los consumidores y deba recurrir a impuestos distorsivos sobre bienes finales, **la producción agregada debe mantenerse en la frontera de eficiencia de Pareto**. El sistema tributario nunca debe gravar insumos intermedios o distorsionar las decisiones tecnológicas de las empresas privadas.

5. **El Modelo de Cuello de Botella y Tarificación por Congestión (Vickrey, 1969):**
   Vickrey demostró que los embotellamientos viales urbanos no son una fatalidad inevitable, sino un fallo de mercado por gratuidad del espacio en hora punta. En el cuello de botella vial, el costo del viaje sin peaje se disipa en un 50% en tiempo perdido en la cola. Un peaje dinámico en tiempo real que crezca linealmente hasta la hora punta elimina la fila física al 100%, manteniendo el costo privado del conductor idéntico pero transformando las horas perdidas en recursos fiscales productivos.

## Antes y después

### Antes
- **Supuesto de omnisciencia o suma fija:** La economía del bienestar trataba la redistribución como un ejercicio algebraico trivial donde el Estado podía cobrar impuestos a los ricos sin que estos alteraran sus horas trabajadas o reportaran ingresos falsos.
- **Subastas intuitivas y empíricas:** Los gobiernos y empresas licitaban compras públicas y privatizaciones mediante formatos arbitrarios, expuestos al sombreado excesivo de pujas, a la maldición del ganador (*winner's curse*) o a la colusión de postores.
- **Infraestructura colapsada en hora punta:** El tráfico urbano se combatía exclusivamente ensanchando autopistas (lo que generaba demanda inducida), asumiendo que el racionamiento por colas era la única forma de gestionar la escasez vial.

### Después (qué cambió gracias al aporte)
- **Nacimiento de la microeconomía de incentivos:** La compatibilidad de incentivos se convirtió en el requisito metodológico fundamental de toda política pública, regulación industrial y contrato financiero.
- **La Subasta de Vickrey como piedra angular:** La regla de segundo precio y la arquitectura VCG (*Vickrey-Clarke-Groves*) sentaron las bases para las subastas modernas de telecomunicaciones, electricidad mayorista y publicidad digital.
- **Revolución en la hacienda pública:** La formulación de Mirrlees transformó el debate tributario: los modelos contemporáneos de imposición óptima (Saez 2001, Piketty y Saez 2013) parten de su ecuación integral de incentivos y elasticidades laborales.
- **Tarificación dinámica por congestión:** Las grandes metrópolis adoptaron el modelo de Vickrey para cobrar peajes electrónicos variables según la densidad vehicular en tiempo real.

## Cómo se aplica hoy

1. **Subastas de Publicidad Digital en Tiempo Real de Google Ads y Meta (2007–2026):**
   Las mayores plataformas de internet adjudican miles de millones de anuncios publicitarios por segundo mediante algoritmos inspirados directamente en la subasta de segundo precio de Vickrey (la Subasta de Segundo Precio Generalizada, GSP, y el mecanismo VCG) ([Varian, 2007, International Journal of Industrial Organization](https://doi.org/10.1016/j.ijindorg.2006.10.010); [Edelman, Ostrovsky y Schwarz, 2007, American Economic Review](https://doi.org/10.1257/aer.97.1.242)). Los anunciantes reportan su disposición máxima a pagar por clic sabiendo que el sistema les cobrará solo el incremento marginal necesario para superar al anunciante siguiente, lo que estabiliza el mercado y minimiza la manipulación estratégica de las pujas.

2. **Sistemas de Tarificación por Congestión Urbana (Singapur, Londres, Estocolmo, Milán y Nueva York):**
   - **Singapur:** Desde 1998, la Autoridad de Transporte Terrestre (LTA) opera el sistema *Electronic Road Pricing* (ERP), que ajusta dinámicamente las tarifas de peaje cada trimestre según la velocidad del tráfico en arterias principales, manteniendo el flujo en niveles óptimos de 45–65 km/h ([LTA Singapore ERP System](https://www.lta.gov.sg)).
   - **Londres:** La autoridad *Transport for London* (TfL) introdujo en 2003 el *Congestion Charge* en el centro urbano, reduciendo el tráfico vehicular en un 30% y canalizando cientos de millones de libras anuales a la flota de autobuses eléctricos y metro.
   - **Nueva York:** En 2024–2025, la MTA de Nueva York implementó el programa de tarificación del Distrito Comercial Central de Manhattan (*CBD Tolling Program*), aplicando directamente la recomendación de William Vickrey formulada a las autoridades neoyorquinas en la década de 1950.

3. **Diseño de Impuestos a la Renta y Créditos al Trabajo (EITC en EE. UU. y Políticas de Asistencia Social):**
   Los ministerios de hacienda y agencias tributarias utilizan el modelo de Mirrlees parametrizado con elasticidades de oferta laboral (la fórmula de Saez, 2001) para diseñar los tramos del Impuesto sobre la Renta de las Personas Físicas (IRPF) y créditos fiscales como el *Earned Income Tax Credit* (EITC) en Estados Unidos o el Ingreso Mínimo Vital en Europa. Al calibrar el ritmo de retirada (*phase-out*) de los subsidios sociales, las autoridades evitan crear "trampas de pobreza" donde las tasas marginales implícitas del 100% desincentiven la inserción laboral formal.

4. **Licitaciones de Espectro Radioeléctrico y Energía Mayorista:**
   La Comisión Federal de Comunicaciones (FCC) de EE. UU. y los operadores de mercados eléctricos independientes (como PJM Interconnection en EE. UU. u OMIE en la península ibérica) utilizan subastas de precio uniforme y mecanismos de segundo precio para licitar bloques de frecuencia 5G y despachar energía eléctrica marginal horaria, garantizando que los generadores oferten sus verdaderos costos marginales.

## Replicación en R
La replicación cuantitativa se encuentra en [tributacion_optima_y_subastas.R](../replicacion/R/tributacion_optima_y_subastas.R) y se documenta en detalle en [replicar.qmd](../replicacion/replicar.qmd).

El script ejecuta dos módulos:
- **Subastas de Vickrey:** Evalúa el perfil de utilidad esperada ante desviaciones de puja demostrando que $b_i = v_i$ maximiza el beneficio del postor; y ejecuta una simulación Monte Carlo de 100,000 subastas ($N=4$, $v \sim \mathcal{U}[0, 100]$) ratificando el Teorema de Equivalencia del Ingreso ($\mathbb{E}[R] = 60.00$) y comparando la varianza de ingresos entre el primer precio ($\sigma^2 = 150.9$) y el segundo precio ($\sigma^2 = 399.9$).
- **Modelo de Mirrlees:** Resuelve numéricamente el problema no lineal de screening en dos tipos bajo restricciones de compatibilidad de incentivos, demostrando que la tasa marginal en el tipo bajo es positiva ($\tau'_L = 34.68\%$) y en el tipo alto es nula ($\tau'_H = 0.00\%$), y simula el perfil continuo de tasas en forma de U de Mirrlees-Saez.

Salidas generadas:
- [fig_vickrey_subastas_estrategias.png](../replicacion/salidas/fig_vickrey_subastas_estrategias.png): Estrategia dominante en Vickrey y densidades de ingresos por formato de subasta.
- [fig_mirrlees_tributacion_optima.png](../replicacion/salidas/fig_mirrlees_tributacion_optima.png): Espacio de contratos $(y, c)$ y estructura en U de tasas marginales efectivas.
- [tab_resultados_mirrlees_vickrey.csv](../replicacion/salidas/tab_resultados_mirrlees_vickrey.csv): Métricas simuladas vs. teóricas consolidadas.

## Para profundizar
- Diamond, P. A., & Mirrlees, J. A. (1971). Optimal taxation and public production I: Production efficiency. *The American Economic Review*, 61(1), 8–27.
- Mirrlees, J. A. (1971). An exploration in the theory of optimum income taxation. *The Review of Economic Studies*, 38(2), 175–208. [DOI: 10.2307/2296779](https://doi.org/10.2307/2296779).
- Royal Swedish Academy of Sciences. (1996). *Contributions to the Economic Theory of Incentives under Asymmetric Information: Advanced Information on the Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 1996*. [Nobel Prize Website](https://www.nobelprize.org/prizes/economic-sciences/1996/advanced-information/).
- Saez, E. (2001). Using elasticities to derive optimal income tax rates. *The Review of Economic Studies*, 68(1), 205–229. [DOI: 10.1111/1467-937X.00166](https://doi.org/10.1111/1467-937X.00166).
- Vickrey, W. (1961). Counterspeculation, auctions, and competitive sealed tenders. *The Journal of Finance*, 16(1), 8–37. [DOI: 10.1111/j.1540-6261.1961.tb02789.x](https://doi.org/10.1111/j.1540-6261.1961.tb02789.x).
- Vickrey, W. (1969). Congestion theory and transport investment. *The American Economic Review*, 59(2), 251–260. [JSTOR: 1823678](https://www.jstor.org/stable/1823678).

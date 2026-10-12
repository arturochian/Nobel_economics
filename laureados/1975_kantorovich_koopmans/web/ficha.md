---
anio: 1975
slug: 1975_kantorovich_koopmans
laureados: ["Leonid Vitaliyevich Kantorovich", "Tjalling C. Koopmans"]
motivacion_oficial: "for their contributions to the theory of optimum allocation of resources [por sus contribuciones a la teoría de la asignación óptima de recursos]"
area: ["Economía Matemática", "Optimización y Asignación de Recursos", "Microeconomía"]
tags: ["programación lineal", "análisis de actividades", "precios sombra", "multiplicadores resolutivos", "dualidad", "eficiencia de Koopmans", "cálculo económico socialista"]
referencias_clave: ["kantorovich1939mathematical", "kantorovich1965best", "koopmans1951activity", "koopmans1957three", "koopmans1965optimal"]
replicacion: "laureados/1975_kantorovich_koopmans/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Leonid Kantorovich y Tjalling Koopmans transformaron la ciencia económica al demostrar matemáticamente que la asignación eficiente de recursos escasos genera de forma inevitable un sistema de precios sombra o multiplicadores de valoración marginal, unificando los fundamentos de la planificación centralizada y los mercados descentralizados.

---

## Resumen de la investigación

A mediados del siglo XX, el pensamiento económico se encontraba profundamente dividido por la Guerra Fría: por un lado, las economías occidentales defendían la descentralización del sistema de precios de libre mercado; por el otro, la Unión Soviética y el bloque del Este proclamaban la superioridad de la planificación centralizada basada en balances materiales físicos y la doctrina laboral marxista. En este tenso escenario geopolítico, dos investigadores de horizontes ideológicos opuestos alcanzaron una coincidencia matemática deslumbrante:

1. **Leonid Vitaliyevich Kantorovich (1912–1986):**  
   Genio matemático soviético de la Universidad Estatal de Leningrado. En 1939, convocado para optimizar el corte de láminas de madera en una fábrica estatal de contrachapado, formuló por primera vez en la historia de la ciencia la **Programación Lineal** y el método de los *multiplicadores resolutivos* (*razreshayushchie mnozhiteli*), casi una década antes de los trabajos independientes de George Dantzig en Occidente. Más tarde, en su influyente obra *The Best Use of Economic Resources* (1959), demostró a las autoridades soviéticas que ignorar el costo de oportunidad del capital, la tierra y la escasez física de factores conducía a una ineficiencia colosal en la economía planificada. Probó que los precios no son una creación arbitraria del capitalismo, sino indicadores matemáticos indispensables de escasez marginal inherentes a cualquier sociedad que busque evitar el desperdicio.

2. **Tjalling C. Koopmans (1910–1985):**  
   Físico y matemático holandés formado en Leiden bajo la tutela de Paul Ehrenfest y Jan Tinbergen, radicado posteriormente en los Estados Unidos. Durante la Segunda Guerra Mundial, coordinó la logística de convoyes navales aliados en el *Combined Shipping Adjustment Board*, donde formuló problemas de transporte óptimo. Al frente de la célebre *Cowles Commission* en la Universidad de Chicago y más tarde en Yale, Koopmans publicó la monografía canónica *Activity Analysis of Production and Allocation* (1951). Allí formalizó los conjuntos de producción como conos convexos poliédricos generados por actividades elementales, definió con precisión el concepto de **eficiencia de producción de Pareto-Koopmans** y probó el teorema fundamental de que toda asignación eficiente de actividades productivas está respaldada por un vector de precios contables internos (*accounting prices*) que anula los beneficios supra-económicos de las actividades activas y penaliza los procesos ineficientes.

---

## Metodología y resultados

### 1. El Problema Primal y el Poliedro Factible de Producción
En el planteamiento de Kantorovich y Koopmans, la producción se estructura mediante un conjunto finito de $n$ actividades o bienes finales $x = (x_1, \dots, x_n)' \ge 0$, sujetos a $m$ restricciones físicas de insumos limitados $b = (b_1, \dots, b_m)' \in \mathbb{R}_+^m$ (horas de trabajo, horas-máquina de capital, combustible, minerales). La tecnología se describe mediante una matriz insumo-producto $A \in \mathbb{R}_+^{m \times n}$:

$$\max_{x \ge 0} Z = c'x = \sum_{j=1}^n c_j x_j \quad \text{sujeto a} \quad A x \le b$$

El conjunto de posibilidades de producción forma un poliedro convexo cerrado en $\mathbb{R}^n$. El Teorema Fundamental de la Programación Lineal garantiza que el óptimo se encuentra siempre en uno de los vértices extremos de este poliedro.

### 2. El Problema Dual y los Precios Sombra
A todo problema físico de producción (primal) le corresponde intrínsecamente un problema dual de valoración económica de los factores productivos, formulado con el vector de multiplicadores resolutivos $\lambda = (\lambda_1, \dots, \lambda_m)' \ge 0$:

$$\min_{\lambda \ge 0} W = b'\lambda = \sum_{i=1}^m b_i \lambda_i \quad \text{sujeto a} \quad A' \lambda \ge c$$

### 3. Teorema de Holguras Complementarias (*Complementary Slackness*)
La relación entre el mundo físico de los bienes y el mundo contable de los precios se rige por la ley de holgura complementaria:
$$\lambda_i^* \cdot \left( b_i - \sum_{j=1}^n a_{ij} x_j^* \right) = 0 \quad \forall i \in \{1, \dots, m\}$$
$$x_j^* \cdot \left( \sum_{i=1}^m a_{ij} \lambda_i^* - c_j \right) = 0 \quad \forall j \in \{1, \dots, n\}$$

Este teorema encierra dos principios cardinales:
- **Ley de la Escasez Marginal:** Si un insumo productivo no se agota por completo en el plan óptimo ($\text{holgura}_i > 0$), su precio sombra es estrictamente cero ($\lambda_i^* = 0$). Ningún planificador racional ni mercado eficiente debe cobrar por un recurso que sobra en el margen.
- **Ley de la Rentabilidad Contable Agotada:** Si un bien se produce en cantidades positivas ($x_j^* > 0$), el costo imputado de todos los recursos necesarios para producirlo a precios sombra debe igualar con exactitud su valoración social o precio de venta ($\sum_i a_{ij} \lambda_i^* = c_j$).

### 4. Teorema Fuerte de Dualidad
En el óptimo, la suma de los valores de la producción física coincide de manera exacta con el valor contable total imputado a los recursos disponibles:
$$Z^* = c'x^* = b'\lambda^* = W^*$$
Demostrando que el valor económico total se agota exactamente en la retribución de los factores limitantes de producción (agotamiento del producto de Euler-Wicksteed en entornos lineales convexos).

---

## Antes y después

### Antes
- **En la planificación económica soviética:** Los planes quinquenales del Gosplan se calculaban mediante el método empírico de "balances materiales" (cuadrar físicamente toneladas de acero y trigo en tablas contables estáticas). Los precios se fijaban administrativamente siguiendo interpretaciones dogmáticas de la teoría del valor trabajo, ignorando el valor del capital y la escasez de recursos naturales. Como resultado, las fábricas producían bienes toscos e hiperpesados para cumplir metas fijadas en toneladas de acero, generando una subutilización masiva de maquinaria y cuellos de botella crónicos.
- **En la teoría microeconómica occidental:** La producción se modelaba exclusivamente mediante funciones analíticas suaves y diferenciables (como las funciones de producción Cobb-Douglas), que asumían sustituibilidad continua e infinita de factores. Esto impedía modelar procesos industriales reales donde las tecnologías se eligen entre alternativas discretas con proporciones fijas (análisis de procesos).
- **Incomprensión de la dualidad:** No existía una herramienta matemática que conectara directamente las cantidades físicas de insumos con los precios contables marginales de oportunidad.

### Después (qué cambió gracias al aporte)
- **Nacimiento de la Programación Lineal y la Optimización Moderna:** La formulación de Kantorovich (1939) y Koopmans (1951) sentó las bases matemáticas de la investigación operativa mundial, permitiendo a ingenieros y economistas resolver asignaciones complejas de miles de variables en segundos con el algoritmo simplex.
- **Consenso epistemológico sobre los precios:** Se demostró que los precios no son un artefacto político o ideológico del capitalismo, sino un operador matemático fundamental de información para la asignación eficiente de recursos en cualquier sociedad económica.
- **Análisis de Actividades:** Koopmans dotó a la teoría de la producción de un marco riguroso basado en conos convexos poliédricos, conectando la ingeniería de procesos industriales con los teoremas del bienestar de Arrow y Debreu.
- **Teoría del Crecimiento Óptimo:** En su trabajo seminal de 1965 (*On the Concept of Optimal Economic Growth*), Koopmans extendió el análisis de actividades al horizonte intertemporal continuo, fundando el modelo canónico de Ramsey-Cass-Koopmans utilizado en toda la macroeconomía contemporánea.

---

## Cómo se aplica hoy

### 1. Despacho Económico de Energía Eléctrica y Precios Marginales Locacionales (LMP)
Los operadores de sistemas eléctricos mayoristas de todo el mundo —como **PJM Interconnection** (que coordina la red eléctrica para más de 65 millones de personas en 13 estados de EE. UU.), el **California ISO (CAISO)** y **Red Eléctrica de España (REE)**— resuelven cada 5 minutos problemas masivos de programación lineal y programación entera mixta conocidos como *Security-Constrained Economic Dispatch* (SCED).  
El algoritmo minimiza los costos globales de generación de las centrales eléctricas sujeto a restricciones de capacidad y límites térmicos de las líneas de transmisión. Los precios spot de la electricidad fijados en cada subestación de la red son exactamente los **precios sombra** ($\lambda$) de las restricciones de transmisión formuladas por Kantorovich y Koopmans. Cuando una línea de alta tensión se congestiona, su precio sombra se dispara, reflejando el costo marginal de congestión para el sistema.  
*Fuente:* [PJM Market Operations & Locational Marginal Pricing](https://www.pjm.com/markets-and-operations).

### 2. Logística de Contenedores y Cadenas Globales de Suministro (Amazon, Maersk, FedEx)
Las corporaciones logísticas globales más grandes del planeta implementan variantes a gran escala del modelo de transporte óptimo formulado originalmente por Kantorovich en 1942 (*On the Translocation of Masses*).  
Empresas como **A.P. Moller - Maersk** (líder en transporte marítimo de contenedores) y **Amazon Logistics** utilizan solucionadores de programación lineal para coordinar el reposicionamiento dinámico de millones de contenedores vacíos entre Asia, Europa y América, y la asignación óptima de inventarios en su red global de almacenes (*fulfillment centers*). Los precios sombra calculados por estos algoritmos determinan en tiempo real las tarifas por almacenamiento de capacidad máxima y alertan a los directores operativos sobre qué centros logísticos requieren ampliación urgente de infraestructura.  
*Fuente:* [Amazon Science: Supply Chain Optimization Technologies](https://www.amazon.science/research-areas/operations-research-and-optimization).

### 3. Asignación de Franjas Horarias en Aeropuertos Saturos (FAA y Eurocontrol)
Organismos reguladores de tráfico aéreo como la **Administración Federal de Aviación de EE. UU. (FAA)** y **Eurocontrol** aplican modelos de análisis de actividades y programación lineal para asignar derechos de despegue y aterrizaje (*slots*) en aeropuertos con congestión severa (como Londres Heathrow, Fráncfort o Nueva York JFK).  
Al modelar la capacidad horaria de pistas y terminales como restricciones físicas fijas, el cálculo de los multiplicadores de Lagrange / precios sombra permite cuantificar el costo marginal de demora que cada nuevo vuelo impone sobre el sistema entero, sustentando los mecanismos modernos de tarificación y subastas de franjas horarias recomendados por la Asociación Internacional de Transporte Aéreo (IATA).  
*Fuente:* [Eurocontrol: Network Operations and Capacity Planning](https://www.eurocontrol.int/).

### 4. Tarificación del Carbono y Mercados Ambientales de Emisiones (EU ETS)
En el marco del Sistema de Comercio de Emisiones de la Unión Europea (**EU ETS**, directiva comunitaria actualizada en 2023), los objetivos vinculantes de neutralidad climática imponen un tope rígido (*Cap*) sobre las emisiones tolerables de gases de efecto invernadero para miles de instalaciones industriales y del sector aéreo.  
La programación lineal ambiental modela este tope como una restricción adicional de recurso escaso: $\sum a_{\text{CO}_2, j} x_j \le \text{Cap}$. El precio de mercado que cotizan los permisos europeos de emisión (EUA) en los mercados bursátiles de derechos ambientales corresponde rigurosamente al precio sombra dual de la restricción planetaria de carbono, confirmando la tesis de Koopmans de que imponer una cuota física crea automáticamente un precio contable de equilibrio.  
*Fuente:* [European Commission: EU Emissions Trading System (EU ETS)](https://climate.ec.europa.eu/eu-action/eu-emissions-trading-system-eu-ets_en).

---

## Replicación en R

La replicación computacional implementa un modelo de asignación óptima multi-sectorial con:
- Dos sectores productivos finales: Maquinaria pesada ($x_1$) y Bienes de consumo manufacturados ($x_2$), con valoraciones $c = (40, 30)'$.
- Tres factores limitantes de producción: Trabajo calificado ($L = 1000$ h), Capital productivo ($K = 800$ h-m) y Energía eléctrica ($E = 700$ MWh).

### Resultados Clave:
- **Solución Primal:** $x_1^* = 400.00$ unidades, $x_2^* = 200.00$ unidades, logrando un valor social agregado óptimo de $Z^* = 22,000.00$ u.m.
- **Uso de Recursos y Holguras:**
  - Trabajo: $1000 / 1000$ utilizado ($\text{holgura} = 0$, cuello de botella).
  - Capital: $800 / 800$ utilizado ($\text{holgura} = 0$, cuello de botella).
  - Energía: $600 / 700$ utilizado ($\text{holgura} = 100$ MWh de exceso).
- **Precios Sombra Duales (Multiplicadores Resolutivos):**
  - $\lambda_L^* = 16.6667$ u.m./hora de trabajo.
  - $\lambda_K^* = 6.6667$ u.m./hora-máquina de capital.
  - $\lambda_E^* = 0.0000$ u.m./MWh de energía (validación exacta del principio de holgura complementaria).
- **Dualidad Fuerte:** El valor del problema dual es $W^* = 1000(16.67) + 800(6.67) + 700(0) = 22,000.00$, confirmando una brecha de dualidad nula ($\text{Gap} = 0.0000$).
- **Archivos generados:** El script autónomo `programacion_lineal_y_precios_sombra.R` genera las figuras de alta resolución `fig_kantorovich_programacion_lineal.png` y `fig_koopmans_analisis_actividades.png`, junto con la matriz de sensibilidad en `tab_resultados_optimizacion_1975.csv`.

---

## Para profundizar

1. **Kantorovich, L. V. (1939 / 1960).** *"Mathematical Methods of Organizing and Planning Production"*. *Management Science*, 6(4), 366–422. DOI: [10.1287/mnsc.6.4.366](https://doi.org/10.1287/mnsc.6.4.366). Monografía original que introdujo la programación lineal y los multiplicadores resolutivos.
2. **Kantorovich, L. V. (1965).** *The Best Use of Economic Resources*. Harvard University Press. Aplicación macroeconómica de los precios sombra a la planificación socialista.
3. **Koopmans, T. C. (ed.) (1951).** *Activity Analysis of Production and Allocation*. Cowles Commission Monograph 13, John Wiley & Sons. La obra definitiva que formalizó los conos convexos y la eficiencia en la producción.
4. **Koopmans, T. C. (1957).** *Three Essays on the State of Economic Science*. McGraw-Hill. Ensayo 1: asignación de recursos y el sistema de precios.
5. **Koopmans, T. C. (1965).** *"On the Concept of Optimal Economic Growth"*. *The Econometric Approach to Development Planning*, Pontificiae Academiae Scientiarum Scripta Varia, 28, 225–287. Fundación del modelo de crecimiento óptimo de Ramsey-Cass-Koopmans.
6. **Kantorovich, L. V. (1976).** *"Mathematics in Economics: Achievements, Difficulties, Perspectives"*. Nobel Memorial Lecture. DOI: [10.1007/BF01580393](https://doi.org/10.1007/BF01580393).
7. **Koopmans, T. C. (1977).** *"Concepts of Optimality and Their Uses"*. Nobel Memorial Lecture, *The American Economic Review*, 67(3), 261–274.

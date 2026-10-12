---
anio: 1982
slug: 1982_stigler
laureados: ["George J. Stigler"]
motivacion_oficial: "for his seminal studies of industrial structures, markets and the causes and effects of public regulation"
area: ["Organización Industrial", "Economía de la Información", "Economía de la Regulación"]
tags: ["economía de la información", "búsqueda de precios", "captura regulatoria", "escuela de chicago", "organización industrial", "principio del superviviente", "barreras a la entrada"]
referencias_clave: ["stigler1983nobel_lecture", "stigler1961information", "stigler1971regulation", "stigler1958scale", "stigler_friedland1962electricity", "stigler1964oligopoly"]
replicacion: "laureados/1982_stigler/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
George J. Stigler transformó la economía al demostrar que la información es un bien escaso cuya búsqueda óptima explica la dispersión de precios, y al fundar la teoría de la captura regulatoria, probando que la regulación pública suele ser adquirida por las propias industrias para blindar monopolios y restringir la competencia.

## Resumen de la investigación
A mediados del siglo XX, la ciencia económica ortodoxa descansaba sobre dos premisas cuestionables: en la microeconomía de mercados, se asumía que los consumidores poseían información perfecta instantánea y sin costo sobre los precios; en la economía pública, se creía ingenuamente en la "teoría del interés público", según la cual el Estado intervenía los mercados para corregir fallas y proteger desinteresadamente a la sociedad.

George J. Stigler (1911–1991), profesor de la Universidad de Chicago y una de las mentes más agudas de la Escuela de Chicago, desmanteló ambas ilusiones:

1. **La Economía de la Información (*The Economics of Information*, 1961):** Stigler bautizó la ignorancia como un fenómeno económico sujeto a cálculo racional. Formuló la teoría de la búsqueda (*search theory*): en un mercado con múltiples vendedores, los precios no convergen a un único valor sino que forman una distribución de dispersión. Un comprador racional recoge cotizaciones sucesivas y frena su búsqueda cuando el ahorro marginal esperado en el precio mínimo iguala el costo marginal del tiempo y esfuerzo invertido en buscar ($MB(n^*) = c$). Demostró además que los compradores de grandes volúmenes buscan más intensamente y que la publicidad cumple una función social crucial: reducir radicalmente los costos de búsqueda del consumidor.
2. **La Teoría de la Captura Regulatoria (*The Theory of Economic Regulation*, 1971):** Stigler aplicó el análisis económico a la propia creación de leyes. Postuló que la regulación no surge por la benevolencia de los gobernantes, sino como un producto económico sujeto a oferta y demanda. Los políticos ofrecen regulaciones a cambio de votos y financiamiento de campaña; las industrias organizadas demandan regulación para restringir la entrada de nuevos competidores mediante licencias obligatorias, cuotas, aranceles y tarifas mínimas legales. Debido al problema de acción colectiva (Olson), los productores están concentrados y obtienen enormes rentas per cápita, mientras que los millones de consumidores perjudicados están difusos y no tienen incentivos individuales para litigar o cabildear.
3. **El Principio del Superviviente (*The Survivor Principle*, 1958):** En lugar de confiar en estimaciones contables artificiales de las curvas de costos medios en forma de U, Stigler propuso inferir el tamaño óptimo de las empresas a través del mercado: si una escala productiva es genuinamente eficiente ante la incertidumbre y las regulaciones reales, su cuota de mercado crecerá o se mantendrá estable en el tiempo; si es ineficiente, perderá participación y desaparecerá.
4. **La Primera Evaluación Empírica de Entes Reguladores (1962 con Claire Friedland):** Al examinar las tarifas eléctricas en los estados de EE.UU. con y sin comisiones reguladoras públicas entre 1907 y 1937, encontraron que las comisiones no lograron reducir las tarifas a los consumidores ni moderar las ganancias extraordinarias de las empresas. Fue el primer golpe econométrico contra la presunción de eficacia de los entes reguladores tradicionales.

## Metodología y resultados

### 1. El Modelo de Búsqueda Óptima de Información (Stigler, 1961)
Sea un mercado con dispersión de precios gobernado por una función de distribución continua $F(P)$ en el intervalo $[a, b]$. Un consumidor muestrea $n$ vendedores al azar ($P_1, \dots, P_n$) y adquiere el bien al precio mínimo muestral:
$$P_{(1:n)} = \min(P_1, P_2, \dots, P_n)$$

La función de distribución del precio mínimo es $F_{(1)}(p) = 1 - [1 - F(p)]^n$. Para una distribución Uniforme $P \sim U(a, b)$:
$$E[P_{(1:n)}] = a + \frac{b - a}{n + 1}$$

- **Rendimientos decrecientes de la información:** A medida que $n$ aumenta, el precio mínimo esperado desciende, pero a una tasa marginal decreciente:
  $$MB(n) = E[P_{(1:n-1)}] - E[P_{(1:n)}] = \frac{b - a}{n(n + 1)}$$
- **Regla de Parada Óptima de Stigler:** Si el comprador adquiere una cantidad $Q$ y cada búsqueda cuesta $c$ unidades monetarias, el tamaño óptimo de muestra $n^*$ satisface:
  $$Q \cdot MB(n^*) \ge c > Q \cdot MB(n^* + 1)$$
- **Predicciones empíricas confirmadas:** Quienes compran mayores cantidades ($Q \uparrow$) o adquieren bienes más caros y dispersos buscan más cotizaciones ($n^* \uparrow$). La publicidad comercial agrupa información de precios, reduciendo la dispersión observada en el mercado.

### 2. Captura Regulatoria y Restricción a la Entrada (Stigler, 1971)
En un mercado competitivo con demanda inversa $P = P_{\max} - b Q$ y costo marginal constante $c_0$:
- **Equilibrio Competitivo:** $P_c = c_0$, $Q_c = (P_{\max} - c_0)/b$, con excedente del consumidor máximo $CS_c = \frac{1}{2}(P_{\max} - c_0) Q_c$ y beneficio de la industria $\Pi_c = 0$.
- **Captura Regulatoria:** Las empresas titulares forman una coalición y cabildean al regulador para imponer licencias o cuotas de producción, elevando el precio oficial a $P_{reg} > c_0$.
- **Impacto de Bienestar:**
  1. **Transferencia de rentas:** Se transfieren rentas masivas de los consumidores a las empresas protegidas: $\Pi = (P_{reg} - c_0) Q_{reg}$.
  2. **Pérdida de peso muerto de Harberger:** $DWL = \frac{1}{2}(P_{reg} - c_0)(Q_c - Q_{reg})$.
  3. **Disipación por cabildeo político (Stigler-Tullock):** Las empresas invierten una fracción sustancial de sus rentas en abogados, aportes electorales y relaciones públicas para preservar el blindaje legal, elevando la pérdida social neta muy por encima del clásico triángulo de pérdida de bienestar.

## Antes y después

### Antes
- **Mercados con Información Perfecta:** La teoría del equilibrio general (Walras, Arrow-Debreu) asumía que todos los precios eran de conocimiento público inmediato. La dispersión de precios se trataba como una aberración transitoria o como resultado de diferencias de calidad no observadas.
- **La Publicidad como Desperdicio Manipulador:** Economistas como Galbraith y Robinson consideraban la publicidad comercial como un gasto estéril orientado a manipular irracionalmente los gustos del consumidor y crear monopolios artificiales.
- **Teoría del Interés Público de la Regulación:** Se enseñaba que las agencias estatales de regulación (ferrocarriles, aviación, energía, banca) eran creadas para defender al consumidor indefenso frente al poder de los monopolios naturales.
- **Curvas de Costos Ingenieriles:** La escala eficiente de las empresas se estimaba mediante encuestas contables o fórmulas tecnológicas de ingeniería, asumiendo curvas de costos medios en forma de U simétricas y estáticas.

### Después (qué cambió gracias al aporte)
- **Nacimiento de la Economía de la Información:** Stigler inauguró formalmente el análisis de la información como mercancía escasa, abriendo el camino a la teoría de búsqueda secuencial (McCall, Mortensen, Pissarides) y a los modelos de fricciones de mercado.
- **Rehabilitación Económica de la Publicidad:** Se demostró teórica y empíricamente que la publicidad transmite información verídica sobre precios y disponibilidad, estimulando la competencia y reduciendo los precios promedio.
- **Teoría Económica de la Regulación y Fin del Romanticismo:** Se reconoció que el proceso regulatorio es un mercado político donde grupos de interés organizados obtienen rentas a expensas de la mayoría desorganizada.
- **La Ola Global de Desregulación (1975–1990):** Las investigaciones de Stigler aportaron el arsenal intelectual decisivo para desmontar la regulación de tarifas y rutas en aviación comercial, transporte terrestre, telecomunicaciones y mercados financieros en Occidente.
- **Validación del Principio del Superviviente:** La economía industrial adoptó el comportamiento empírico de las empresas en el mercado a lo largo del tiempo como el estándar científico para evaluar economías de escala.

## Cómo se aplica hoy

1. **Plataformas Digitales de Comparación de Precios y Agregadores (Google Shopping, Skyscanner, Amazon):**
   - El modelo de búsqueda de Stigler (1961) anticipó con exactitud la revolución del comercio electrónico: cuando internet y los motores de búsqueda desploman el costo marginal de cotización ($c \to 0$), el número óptimo de búsquedas $n^*$ explota y la dispersión residual de precios se comprime drásticamente.
   - Estudios empíricos modernos (ej. Brynjolfsson & Smith, 2000; Ellison & Ellison, 2009) utilizan directamente el marco de Stigler para medir cómo los algoritmos de recomendación y las plataformas de comparación comprimen las brechas de precios en productos homogéneos (electrónica, pasajes aéreos, libros).
2. **Reforma y Eliminación de Licencias Ocupacionales Obligatorias (EE.UU., Reino Unido y OCDE):**
   - En Estados Unidos, más del 25% de los trabajadores requieren actualmente una licencia estatal para ejercer (abogados, peluqueros, ópticos, floristas, electricistas). Siguiendo la tesis de Stigler (1971), la **Comisión Federal de Comercio** (FTC, *Federal Trade Commission*) y la Casa Blanca (informes del Consejo de Asesores Económicos desde 2015 a 2023) lideran una agenda de desregulación ocupacional, demostrando que estas licencias no mejoran la calidad del servicio sino que actúan como barreras de entrada que encarecen los servicios para las familias de menores ingresos.
   - En la Unión Europea, la Directiva de Servicios del Mercado Interior (Directiva 2006/123/CE) y las revisiones periódicas de profesiones reguladas obligan a los Estados miembros a justificar con rigurosa proporcionalidad cualquier requisito de colegiación obligatoria.
3. **Análisis de Impacto Regulatorio (RIA) y Auditorías Anti-Captura en la OCDE y la Casa Blanca:**
   - La **Oficina de Información y Asuntos Regulatorios de EE.UU.** (OIRA, bajo las Órdenes Ejecutivas 12866 y 14094 de 2023) evalúa cada año de forma independiente cientos de regulaciones federales con impacto superior a 200 millones de dólares para evitar que agencias sectoriales sean capturadas por los cabilderos de las industrias que supervisan.
   - El Comité de Política Regulatoria de la **OCDE** publica periódicamente recomendaciones vinculantes sobre gobernanza regulatoria y transparencia en consultas públicas para contrarrestar la captura por grupos de interés concentrados.
4. **Programas de Clemencia y Detección de Colusión en Políticas de Competencia (FTC, DoJ y DG COMP):**
   - La teoría de Stigler sobre oligopolios y detección de trampas (1964) es la base matemática de los **programas de clemencia** (*leniency programs*) implementados por la División Antimonopolio del Departamento de Justicia de EE.UU. (DoJ, 1993) y la Comisión Europea (2002/2006). Al ofrecer inmunidad total al primer miembro del cártel que confiese y entregue evidencia, las autoridades desestabilizan estructuralmente la colusión al elevar al 100% la probabilidad de detección de trampas.

## Replicación en R
En el módulo de replicación (`replicacion/R/economia_informacion_y_regulacion.R` y `replicacion/replicar.qmd`) se simulan computacionalmente dos modelos esenciales:
1. **Modelo de Búsqueda Óptima de Información (Stigler, 1961):**
   - Se computa analíticamente la estadística de orden del precio mínimo esperado $E[\min(P_1, \dots, P_n)]$ para una distribución uniforme $U(50, 150)$ y se contrasta con una simulación de Monte Carlo de 50,000 réplicas con distribución log-normal.
   - Se calcula el beneficio marginal esperado $MB(n)$ y se determina el tamaño de muestra óptimo $n^*$ para compradores minoristas ($Q=1 \implies n^* = 5$), intermedios ($Q=3 \implies n^* = 9$) y compras al por mayor ($Q=8 \implies n^* = 15$) ante un costo marginal de cotización de $c = \$3.00$.
2. **Modelo de Captura Regulatoria y Excedentes Sociales (Stigler, 1971):**
   - Se modela la transición de un mercado desde competencia perfecta ($P = \$30$, $Q = 90$) hasta monopolio legal cartelizado ($P = \$75$, $Q = 45$).
   - Se cuantifican las transferencias de excedente hacia los productores protegidos ($\Pi = \$2025.0$), la pérdida de peso muerto de Harberger ($DWL = \$1012.5$) y los costos de cabildeo político de la captura regulatoria, demostrando que la pérdida de bienestar social total se dispara hasta $\$1721.2$.

Las figuras generadas en `replicacion/salidas/` ilustran:
- `fig_stigler_busqueda_precios.png`: Curvas de precio mínimo esperado decreciente y regla de parada óptima $Q \cdot MB(n) = c$.
- `fig_stigler_captura_regulatoria.png`: Diagrama de mercado de los excedentes capturados y evolución de las rentas empresariales frente a la pérdida social neta.
- `tab_resultados_stigler.csv`: Métricas numéricas detalladas para ambos bloques teóricos.

## Para profundizar
- **Stigler, G. J. (1961).** The Economics of Information. *Journal of Political Economy*, 69(3), 213–225. [DOI: 10.1086/258464](https://doi.org/10.1086/258464).
- **Stigler, G. J. (1971).** The Theory of Economic Regulation. *The Bell Journal of Economics and Management Science*, 2(1), 3–21. [DOI: 10.2307/3003160](https://doi.org/10.2307/3003160).
- **Stigler, G. J. (1958).** The Economies of Scale. *The Journal of Law and Economics*, 1, 54–71. [DOI: 10.1086/466541](https://doi.org/10.1086/466541).
- **Stigler, G. J. (1964).** A Theory of Oligopoly. *Journal of Political Economy*, 72(1), 44–61. [DOI: 10.1086/258853](https://doi.org/10.1086/258853).
- **Stigler, G. J., & Friedland, C. (1962).** What Can Regulators Regulate? The Case of Electricity. *The Journal of Law and Economics*, 5, 1–16. [DOI: 10.1086/466579](https://doi.org/10.1086/466579).
- **Stigler, G. J. (1983).** Nobel Lecture: The Process and Progress of Economics. *Journal of Political Economy*, 91(4), 529–545. [DOI: 10.1086/261166](https://doi.org/10.1086/261166).

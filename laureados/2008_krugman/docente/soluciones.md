# Guía del Docente y Solucionario Confidencial

> **Premio Nobel de Economía 2008: Paul Krugman**  
> **Tema:** Nueva Teoría del Comercio Internacional y Nueva Geografía Económica  
> **Uso exclusivo para el cuerpo docente.** Contiene el desarrollo analítico paso a paso, derivaciones matemáticas rigurosas y criterios pedagógicos de evaluación para la guía de ejercicios de estudiantes.

---

## Criterios Pedagógicos Generales

Al evaluar esta unidad, asegúrese de que el estudiante logre:
1. Distinguir con precisión conceptual el **comercio interindustrial** (basado en ventajas comparativas tradicionales) del **comercio intraindustrial** (basado en diferenciación de producto y rendimientos crecientes).
2. Comprender la microfundamentación del modelo de Dixit-Stiglitz: por qué la escala por firma permanece fija bajo elasticidad constante de sustitución y cómo las ganancias provienen de la **amplitud del menú de variedades**.
3. Dominar la intuición de la **causalidad circular acumulativa** de Myrdal formalizada por Krugman: entender que la reducción de costos de transporte no dispersa la actividad, sino que paradójicamente cataliza la aglomeración centro-periferia.

---

## Solución al Ejercicio 1: Medición del Comercio Intraindustrial con el Índice de Grubel-Lloyd

### 1. Cálculo por Industria

La fórmula del índice de Grubel-Lloyd para una industria $i$ es:
$$GL_i = 1 - \frac{|X_i - M_i|}{X_i + M_i}$$

#### Industria A (Vehículos y Autopartes)
- $X_A = 28,000$ millones de USD
- $M_A = 26,000$ millones de USD
- Comercio total del sector: $X_A + M_A = 28,000 + 26,000 = 54,000$ millones.
- Saldo comercial neto absoluto: $|X_A - M_A| = |28,000 - 26,000| = 2,000$ millones.

$$GL_A = 1 - \frac{2,000}{54,000} = 1 - 0.03704 = 0.9630 \quad (\mathbf{96.30\%})$$

**Interpretación Económica:**
El 96.30% del intercambio bilateral en vehículos y componentes automotrices corresponde a **comercio intraindustrial** (flujo cruzado simultáneo de automóviles y piezas diferenciadas entre ambos países). Solo un 3.70% corresponde a un desequilibrio comercial neto unidireccional.

#### Industria B (Madera y Papel en Bruto)
- $X_B = 1,500$ millones de USD
- $M_B = 18,500$ millones de USD
- Comercio total del sector: $X_B + M_B = 1,500 + 18,500 = 20,000$ millones.
- Saldo comercial neto absoluto: $|X_B - M_B| = |1,500 - 18,500| = 17,000$ millones.

$$GL_B = 1 - \frac{17,000}{20,000} = 1 - 0.8500 = 0.1500 \quad (\mathbf{15.00\%})$$

**Interpretación Económica:**
En este sector domina el **comercio interindustrial**: el 85% del flujo es unidireccional (Canadá exporta masivamente recursos forestales a EE. UU.), y solo un 15% refleja intercambio intraindustrial.

---

### 2. Cálculo del Índice Agregado Ponderado

El índice agregado pondera cada sector por su participación en el comercio total:
$$\sum_i (X_i + M_i) = 54,000 + 20,000 = 74,000 \text{ millones}$$
$$\sum_i |X_i - M_i| = 2,000 + 17,000 = 19,000 \text{ millones}$$

$$GL_{agregado} = 1 - \frac{19,000}{74,000} = 1 - 0.25676 = 0.7432 \quad (\mathbf{74.32\%})$$

Casi tres cuartas partes ($74.32\%$) del comercio bilateral combinado entre estas dos economías corresponden a flujos intraindustriales cruzados.

---

### 3. Contraste Teórico

- **Industria B (Madera y Papel):**
  Es explicada cabalmente por el modelo de **Heckscher-Ohlin** (y ricardiano): Canadá posee una dotación relativa gigantesca de bosques naturales y tierra fértil por habitante frente a EE. UU., otorgándole una clara ventaja comparativa en bienes intensivos en recursos naturales.
- **Industria A (Vehículos):**
  La teoría tradicional predice que un país exporta automóviles y el otro debería exportar un bien no automotriz. No puede explicar por qué dos naciones con salarios, tecnologías e intensidades de capital casi indistinguibles intercambian volúmenes colosales de autos de manera simultánea.
  El modelo de **Krugman (1979)** resuelve esto demostrando que, debido a los **rendimientos crecientes a escala**, ninguna fábrica puede producir todos los modelos y configuraciones del mundo. Las firmas estadounidenses se especializan en ciertos segmentos (ej. camionetas, vehículos pesados) y las canadienses en otros (ej. sedanes compactos o transmisiones específicas), intercambiando variedades diferenciadas para satisfacer el gusto por la diversidad de los consumidores.

---

## Solución al Ejercicio 2: Amor por la Variedad y Ganancias de Integración de Dixit-Stiglitz

### 1. Equilibrio de la Firma Individual

#### Derivación de la regla de precios
La demanda que enfrenta una variedad $i$ bajo preferencias Dixit-Stiglitz con sustitución $\sigma$ exhibe una elasticidad precio de la demanda constante igual a $\sigma$:
$$q_i = p_i^{-\sigma} \cdot \Lambda$$
donde $\Lambda$ es un agregador de ingreso e índice de precios que la firma individual toma como dado (al haber muchas firmas, su impacto en el nivel de precios general es infinitesimal).

La firma maximiza su beneficio:
$$\pi_i = p_i q_i - (\alpha + \beta q_i) w$$
Condición de primer orden:
$$\frac{d\pi_i}{dq_i} = p_i \left( 1 - \frac{1}{\sigma} \right) - \beta w = 0 \implies p_i \left( \frac{\sigma - 1}{\sigma} \right) = \beta w \implies p^* = \frac{\sigma}{\sigma - 1} \beta w$$

Sustituyendo los valores $\sigma = 3$, $\beta = 2$, $w = 1$:
$$p^* = \frac{3}{3 - 1} \cdot 2 \cdot 1 = \frac{3}{2} \cdot 2 = \mathbf{3.00}$$

#### Condición de libre entrada
Con libre entrada de firmas, el beneficio en el largo plazo debe ser cero ($\pi = 0$):
$$p^* q^* - (\alpha + \beta q^*) w = 0$$
$$(3.00) q^* - (8 + 2 q^*) (1) = 0 \implies 3 q^* - 2 q^* = 8 \implies \mathbf{q^* = 8}$$

Requerimiento laboral total por firma:
$$l^* = \alpha + \beta q^* = 8 + 2(8) = \mathbf{24 \text{ trabajadores}}$$
*(Nótese la elegante identidad analítica de Dixit-Stiglitz: $l^* = \alpha \sigma = 8 \times 3 = 24$).*

---

### 2. Equilibrio en Autarquía

#### Número de variedades en autarquía
La oferta total de trabajo es $L = 240$. En el mercado laboral, la suma del empleo de todas las firmas agota la mano de obra disponible:
$$n_{aut} = \frac{L}{l^*} = \frac{240}{24} = \mathbf{10 \text{ firmas / variedades}}$$

#### Consumo per cápita de cada variedad
Dado que hay $L = 240$ trabajadores y cada firma produce $q^* = 8$ unidades:
$$c = \frac{q^*}{L} = \frac{8}{240} = \frac{1}{30} \approx \mathbf{0.03333}$$
*(Nótese que el gasto total de cada trabajador es $n \cdot p^* \cdot c = 10 \times 3 \times \frac{1}{30} = 1 = w$, cerrando el presupuesto exacto).*

#### Utilidad per cápita en autarquía
Con $c_i = c = 1/30$ constante para las 10 variedades:
$$U_{aut} = \left( \sum_{i=1}^{10} c^{\frac{3-1}{3}} \right)^{\frac{3}{3-1}} = \left( 10 \cdot c^{2/3} \right)^{3/2} = 10^{3/2} \cdot c$$
Alternativamente, expresado en función de los parámetros de la firma:
$$U_{aut} = n_{aut}^{\frac{\sigma}{\sigma - 1}} \frac{q^*}{L} = n_{aut}^{\frac{1}{\sigma - 1}} \left( \frac{n_{aut} q^*}{L} \right) = n_{aut}^{\frac{1}{\sigma - 1}} \frac{q^*}{l^*} = 10^{\frac{1}{3-1}} \cdot \frac{8}{24} = \sqrt{10} \cdot \frac{1}{3} \approx \mathbf{1.05409}$$

---

### 3. Integración Comercial en Libre Comercio

- **Nuevo número total de variedades ($N$):**
  Al integrarse dos economías idénticas de $L = 240$ cada una, la fuerza de trabajo combinada es $L_{global} = 480$.
  $$N = \frac{L_{global}}{l^*} = \frac{480}{24} = \mathbf{20 \text{ variedades}}$$
- **Producción por firma y precios:**
  Como $\sigma$, $\alpha$ y $\beta$ no cambian, **la escala individual de producción de cada firma se mantiene idéntica** en $q^* = 8$ y el precio permanece en $p^* = 3.00$.
- **Consumo y Utilidad en Libre Comercio:**
  El consumo per cápita de cada una de las 20 variedades pasa a ser $c_{trade} = \frac{q^*}{L_{global}} = \frac{8}{480} = \frac{1}{60}$.
  La nueva utilidad per cápita es:
  $$U_{trade} = N^{\frac{1}{\sigma - 1}} \cdot \frac{q^*}{l^*} = 20^{\frac{1}{2}} \cdot \frac{1}{3} = \sqrt{20} \cdot \frac{1}{3} \approx \mathbf{1.49071}$$

#### Deducción formal de la ganancia relativa:
$$\frac{U_{trade}}{U_{aut}} = \frac{N^{\frac{1}{\sigma-1}} \frac{q^*}{l^*}}{n_{aut}^{\frac{1}{\sigma-1}} \frac{q^*}{l^*}} = \left( \frac{N}{n_{aut}} \right)^{\frac{1}{\sigma - 1}} = \left( \frac{2 n_{aut}}{n_{aut}} \right)^{\frac{1}{\sigma - 1}} = \mathbf{2^{\frac{1}{\sigma - 1}}}$$

Para $\sigma = 3$:
$$\frac{U_{trade}}{U_{aut}} = 2^{1/2} = \sqrt{2} \approx 1.4142 \implies \mathbf{+41.42\% \text{ de aumento en el bienestar real}}$$

**Origen económico de la ganancia:**
No proviene de abaratar costos marginales ni de diferencias salariales, sino enteramente del **efecto variedad**: los consumidores acceden al doble de productos diferenciados, dispersando su consumo entre una gama más rica sin pérdida de escala productiva agregada.

---

## Solución al Ejercicio 3: Fuerzas Centrípetas vs. Centrífugas y Aglomeración Espacial

### 1. Costos de Transporte Prohibitivos ($T \to \infty$)
- Cuando $T \to \infty$, es prohibitivo comercializar bienes industriales entre las dos regiones.
- Si las firmas intentaran concentrarse en la Región 1 ($\lambda = 1$), no podrían vender absolutamente nada a los consumidores y agricultores de la Región 2. Además, la feroz competencia de precios entre firmas en la Región 1 reduciría sus ingresos a cero.
- Por tanto, la **fuerza centrífuga** domina por completo: la necesidad de abastecer a la población agrícola cautiva en cada región obliga a la manufactura a repartirse equitativamente en una distribución simétrica:
$$\lambda^* = 0.50 \quad \text{(único equilibrio estable)}$$

---

### 2. Mecanismo de Bifurcación Catastrófica y Causalidad Circular
A medida que la infraestructura abarata el costo de flete por debajo del umbral crítico $T_{break}$:
1. **Pérdida de protección de la periferia:** Las empresas ya no necesitan ubicarse localmente en la región pequeña para venderle a sus residentes; pueden exportar desde lejos a costo insignificante.
2. **Encadenamiento hacia atrás (*Backward linkage*):** Ubicarse en la región que tiene una ligera mayoría de población ahorra costos de transporte sobre la gran masa de compradores locales.
3. **Encadenamiento hacia adelante (*Forward linkage*):** Más firmas locales reducen el índice de precios de la región mayoritaria, elevando el salario real de sus habitantes.
4. **Retroalimentación acumulativa:** El mayor salario real atrae a trabajadores de la otra región (migración interregional). Esta afluencia agranda todavía más el mercado local, atrayendo a aún más firmas en una espiral que se autoalimenta (*causalidad circular acumulativa*).
5. **Naturaleza catastrófica:** El equilibrio simétrico ($\lambda = 0.5$) no se desplaza suavemente; se vuelve repulsor e inestable. El sistema "salta" de forma discontinua e irreversible hacia la aglomeración completa en un solo polo ($\lambda = 1$ o $\lambda = 0$).

---

### 3. Aplicación a Clusters Reales (Silicon Valley / Bajío Automotriz)

#### Fuerzas Centrípetas Modernas:
- **Pool de mano de obra especializada:** Empresas de semiconductores, software e IA en Silicon Valley pueden reclutar ingenieros de élite de inmediato; a su vez, los ingenieros acuden allí porque saben que si un proyecto quiebra, encontrarán otro empleo sin mudarse de ciudad.
- **Proveedores especializados e insumos específicos:** En el Bajío (Guanajuato, Querétaro, Aguascalientes), una planta ensambladora tiene a menos de 50 km a fabricantes de estampados, cableados, asientos y pinturas técnicas.
- **Derrames de conocimiento (*Knowledge spillovers*):** Intercambio informal de ideas en cafeterías, conferencias y movilidad entre startups ("el conocimiento está en el aire", como anticipó Alfred Marshall).

#### Fuerzas Centrífugas Modernas que frenan la concentración infinita:
- **Costos inmobiliarios y precio del suelo:** El metro cuadrado en San Francisco o Palo Alto es de los más caros del planeta, expulsando a trabajadores de rentas medias y pequeñas empresas hacia Austin, Texas o Denver.
- **Congestión y externalidades negativas:** Tráfico vehicular masivo, saturación de la red eléctrica y contaminación.
- **Incentivos fiscales y salariales descentralizados:** Ciudades periféricas ofrecen menores costos de vida y beneficios fiscales para atraer sedes corporativas.

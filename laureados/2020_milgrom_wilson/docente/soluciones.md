# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2020: Paul R. Milgrom y Robert B. Wilson

> **Nota confidencial para el profesor:** Este material contiene las resoluciones formales, derivaciones matemáticas y pautas de evaluación pedagógica correspondientes a los ejercicios propuestos en `estudiante/ejercicios.qmd`. Mantener reservado para uso docente.

---

### Solución Ejercicio 1 (Cálculo de la Maldición del Ganador y Condicionamiento Bayesiano)

#### 1. Falacia del Estimador No Condicionado
- **La falacia:** La expectativa no condicionada de la señal de la empresa A es, en efecto, un estimador insesgado: $\mathbb{E}[X_A \mid V] = V$.
- Sin embargo, para adjudicarse el contrato en una subasta competitiva, no basta con observar $X_A$; es indispensable que **$X_A$ sea mayor que todas las demás señales** ($X_A > X_j \ \forall j \neq A$).
- El evento de ganar porta información estadística desfavorable: ganar significa que todas las demás $(N - 1)$ empresas de la industria obtuvieron estimaciones más bajas y pesimistas que la de A.
- Por tanto, la expectativa relevante para formular la puja es la expectativa **condicionada al evento de ganar**: $\mathbb{E}[V \mid X_A = \max_{j} X_j]$. Puesto que $\mathbb{E}[V \mid X_A = \max_j X_j] < X_A$, pujar asumiendo que el valor es $X_A$ garantiza que el ganador sobrestime sistemáticamente el activo.

#### 2. Cálculo Analítico del Sesgo de Selección
La fórmula del valor esperado del error máximo de estimación para ruidos uniformes en $[-\varepsilon_0, \varepsilon_0]$ con $\varepsilon_0 = 15$ es:
$$\mathbb{E}[\max_{j=1,\dots,N} \varepsilon_j] = 15 \cdot \frac{N - 1}{N + 1}$$

Calculamos para cada valor de $N$:
- **Para $N = 2$:**
  $$\mathbb{E}[\max \varepsilon] = 15 \cdot \frac{2 - 1}{2 + 1} = 15 \cdot \frac{1}{3} = \mathbf{5.0 \text{ millones}}$$
  $\mathbb{E}[X_{(2)} \mid V] = V + 5.0$.
- **Para $N = 5$:**
  $$\mathbb{E}[\max \varepsilon] = 15 \cdot \frac{5 - 1}{5 + 1} = 15 \cdot \frac{4}{6} = \mathbf{10.0 \text{ millones}}$$
  $\mathbb{E}[X_{(5)} \mid V] = V + 10.0$.
- **Para $N = 29$:**
  $$\mathbb{E}[\max \varepsilon] = 15 \cdot \frac{29 - 1}{29 + 1} = 15 \cdot \frac{28}{30} = \mathbf{14.0 \text{ millones}}$$
  $\mathbb{E}[X_{(29)} \mid V] = V + 14.0$.

**Impacto para $V = 85$ y $N = 29$:**
- La señal del postor ganador promedia: $\mathbb{E}[X_{(29)}] = 85 + 14 = \mathbf{99 \text{ millones de USD}}$.
- El postor ingenuo resta un margen de 2 millones y puja: $b = 99 - 2 = \mathbf{97 \text{ millones}}$.
- **Resultado financiero:** El ganador paga 97 millones por un yacimiento que realmente vale 85 millones. Sufre una pérdida neta catastrófica de:
  $$\Pi = 85 - 97 = \mathbf{-12 \text{ millones de USD}}$$
  Esta es la materialización empírica de la *maldición del ganador*.

#### 3. La Solución de Wilson (1977) y Milgrom-Weber (1982)
- El postor racional bayesiano calcula:
  $$\mathbb{E}[V \mid X_i = \max_{j \neq i} X_j] = X_i - 15 \cdot \frac{N - 1}{N + 1}$$
- En una subasta de primer precio, además de restar este sesgo de selección adverso, resta un margen de competencia estándar.
- **Efecto de la mayor competencia ($N$):** En subastas de valor privado estándar (Vickrey), un mayor número de postores incentiva a pujar más alto para asegurar la victoria. En subastas de valor común, ocurre la fuerza contraria: al haber más competidores, ser el postor con la señal máxima implica que la señal es un valor atípico (*outlier*) aún más extremo en la cola superior. Por ende, la necesidad de sombreado prudencial por selección adversa aumenta con $N$, compensando e incluso superando la presión competitiva hacia arriba.

---

### Solución Ejercicio 2 (Complementariedad y el Problema de Exposición)

#### 1. Asignación Eficiente Social
- Asignación 1 (Paquete al Operador Nacional): Valor generado = $v_1(\{C, S\}) = \mathbf{120 \text{ millones}}$.
- Asignación 2 (Licencias separadas a regionales): Valor generado = $v_2(C) + v_3(S) = 55 + 55 = \mathbf{110 \text{ millones}}$.
- **Conclusión:** La asignación socialmente eficiente exige que el Operador Nacional adquiera ambas licencias, maximizando el bienestar total en 120 millones gracias a las sinergias de red.

#### 2. Falla en Subastas Secuenciales Independientes
- **El Dilema:** Si la Licencia $C$ se subasta primero, el Operador Nacional desconoce a qué precio se adjudicará la Licencia $S$ más adelante.
- Si puja agresivamente por $C$ asumiendo que conseguirá la sinergia total (por ejemplo, pagando 60 millones por $C$), y luego en la segunda subasta el Operador Sur eleva el precio de $S$ hasta 55 millones:
  - Si gana ambas, el costo total es $60 + 55 = 115$ millones (beneficio modesto de $+5$).
  - Si pierde $S$ (porque el Operador Sur gana a 56 millones), el Operador Nacional queda "atrapado" con la Licencia $C$ por la que pagó 60 millones, pero que en aislamiento solo le genera $v_1(C) = 40$ millones, sufriendo una pérdida neta irreversible de $\mathbf{-20 \text{ millones}}$.
- **Definición del Problema de Exposición (*Exposure Problem*):** Riesgo que enfrenta un postor con valoraciones complementarias (superaditivas) de pagar un precio superior a su valoración individual por un bien intermedio, sin certeza de obtener los bienes complementarios necesarios para rentabilizar la inversión. Ante este riesgo, los postores eficientes suelen retirarse prematuramente, generando asignaciones ineficientes y menor recaudación fiscal.

#### 3. Resolución Mediante el Formato SMRA
El diseño de Milgrom y Wilson resuelve este fallo estructural mediante tres pilares coordinados:
1. **Rondas Simultáneas:** Las licencias $C$ y $S$ se abren y actualizan al mismo tiempo en cada ronda de puja.
2. **Cierre Simultáneo:** Ninguna licencia se cierra individualmente; la subasta concluye solo cuando no se emite ninguna nueva puja en ninguna licencia de todo el sistema. Esto permite al Operador Nacional seguir el balance de precios en tiempo real y abandonar ambas licencias de forma coordinada si el costo agregado supera 120 millones, sin quedar nunca expuesto en una sola.
3. **Regla de Actividad de Milgrom-Wilson:** Exige a los participantes mantenerse activos (pujando o siendo líderes provisionales) en una proporción estricta de sus unidades de elegibilidad. Si un postor no puja en una ronda, pierde permanentemente elegibilidad para rondas posteriores. Esto erradica el comportamiento oportunista de ocultar el interés hasta el final (*sniping*) y garantiza que los precios reflejen la verdadera demanda en cada etapa.

---

### Solución Ejercicio 3 (Reto: Mitigación de Colusión en Subastas de Espectro)

#### 1. Mecanismos Institucionales contra la Colusión
1. **Pujas en Bloque con Incrementos Preestablecidos (*Click Bidding*):**
   - En las primeras subastas, los postores podían escribir montos arbitrarios en los teclados, permitiendo enviar "códigos de área" en los últimos dígitos para señalar acuerdos de reparto geográfico.
   - La solución regulatoria de Milgrom fue limitar las pujas a opciones predefinidas por el sistema informático (pujas de un clic que incrementan exactamente en un $\Delta\%$ prefijado, por ejemplo $5\%$ o $10\%$). Al eliminar los dígitos libres, se bloquea el canal de comunicación tácita.
2. **Revelación Anónima de Postores (*Anonymous Bidding*):**
   - Al terminar cada ronda, el sistema solo publica el monto de la oferta más alta y el número total de postores activos, pero mantiene en estricta reserva la identidad de los ofertantes.
   - Sin saber quién está pujando en qué mercado, los cárteles no pueden monitorear el cumplimiento de acuerdos colusorios ni ejecutar represalias dirigidas (*punishment bids*) contra miembros desobedientes.
3. **Reglas de Retiro con Penalizaciones Financieras Severas:**
   - Si un postor retira una puja provisional, está obligado a compensar al Estado por la diferencia entre su puja y el precio final de adjudicación si este resulta inferior, eliminando amenazas no creíbles.

#### 2. Resultados Esperados de la Modificación en R
Al simular un cártel que se divide dos regiones vs. competencia abierta en el script:
- **Recaudación Fiscal:** Cae drásticamente (a menudo en más de un 40% a 60%), ya que cada operador adquiere su mercado local al precio de reserva inicial sin oposición competitiva.
- **Rondas de Subasta:** Se reducen a 2 o 3 rondas (en contraste con 15 a 25 rondas en competencia dinámica).
- **Lección para el Diseñador de Mercados:** Las propiedades de eficiencia de un mecanismo no dependen solo de que los agentes jueguen en equilibrio competitivo, sino de la robustez del diseño frente a equilibrios colusorios alternativos (diseño a prueba de colusión / *collusion-proof mechanism design*).

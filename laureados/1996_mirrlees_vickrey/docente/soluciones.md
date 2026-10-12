# Soluciones y Pautas de Evaluación (Docente)
## Laureados 1996: James A. Mirrlees y William Vickrey

> **Nota confidencial para el cuerpo docente:** Este documento contiene el desarrollo algebraico formal, las soluciones cuantitativas completas y las pautas pedagógicas de evaluación correspondientes a la guía de actividades en `estudiante/ejercicios.qmd`. Mantener reservado para uso exclusivo del docente.

---

### Solución Ejercicio 1 (Subasta de Segundo Precio vs. Primer Precio)

#### 1. Subasta de Segundo Precio en Sobre Cerrado (Vickrey)
- **a) Empresa Ganadora:**
  Cada empresa reporta con veracidad $b_i = v_i$:
  $$b_1 = 90, \quad b_2 = 75, \quad b_3 = 50$$
  La empresa con la mayor puja es la **Empresa 1** ($b_1 = 90 > b_2 = 75 > b_3 = 50$). Por tanto, la Empresa 1 se adjudica la licencia.

- **b) Precio Pagado:**
  En la subasta de Vickrey, el ganador no paga su propia puja, sino la **segunda puja más alta**:
  $$p = \max_{j \ne 1} b_j = b_2 = \mathbf{75} \text{ millones de euros}$$

- **c) Excedentes del Consumidor y del Vendedor:**
  - Excedente neto de la Empresa 1:
    $$u_1 = v_1 - p = 90 - 75 = \mathbf{+15} \text{ millones de euros}$$
  - Recaudación total del Estado:
    $$R = p = \mathbf{75} \text{ millones de euros}$$
  - Excedente social total generado:
    $$W = u_1 + R = 15 + 75 = 90 \text{ millones de euros} = v_1$$
    La asignación es Pareto eficiente (el bien queda en manos de quien más lo valora).

---

#### 2. Prueba de la Estrategia Dominante
- **Desviación a la baja ($b_1 = 70$):**
  - Las ofertas recibidas son: $b_1 = 70, b_2 = 75, b_3 = 50$.
  - Ahora la mayor puja es $b_2 = 75$. ¡La Empresa 1 **pierde la subasta**!
  - La utilidad neta de la Empresa 1 pasa de $+15$ a **0**.
  - *Lección pedagógica:* Subdeclarar la puja nunca reduce el precio pagado (puesto que el precio depende exclusivamente de las pujas rivales), pero expone al jugador al riesgo innecesario de perder una transacción rentable.

- **Desviación al alza ($b_2 = 95$):**
  - Las ofertas recibidas son: $b_1 = 90, b_2 = 95, b_3 = 50$.
  - La Empresa 2 gana la subasta, pues $95 > 90$.
  - Sin embargo, debe pagar la segunda puja más alta ($b_1 = 90$).
  - La utilidad neta de la Empresa 2 es:
    $$u_2 = v_2 - p = 75 - 90 = \mathbf{-15} \text{ millones de euros}$$
  - *Lección pedagógica:* Sobredimensionar la puja solo altera el resultado cuando se supera a un rival que valoraba más el bien, lo que fuerza al postor a pagar un precio superior a su propia valoración, causándole una pérdida económica neta.

---

#### 3. Comparación con Subasta de Primer Precio (FPSB)
- **Cálculo de las pujas sombreadas con $N = 3$ y $v_i \sim \mathcal{U}[0, 100]$:**
  Fórmula de equilibrio simétrico Bayes-Nash:
  $$b(v) = \frac{N - 1}{N} v = \frac{2}{3} v$$
  - Empresa 1: $b_1 = \frac{2}{3} \times 90 = \mathbf{60.00}$ millones de euros.
  - Empresa 2: $b_2 = \frac{2}{3} \times 75 = \mathbf{50.00}$ millones de euros.
  - Empresa 3: $b_3 = \frac{2}{3} \times 50 = \mathbf{33.33}$ millones de euros.

- **Resultado de la subasta:**
  - Gana la **Empresa 1** ($b_1 = 60 > 50 > 33.33$).
  - Paga su propia oferta: $p = b_1 = \mathbf{60.00}$ millones de euros.
  - Ingreso recaudado por el Estado: **60.00 millones de euros**.
  - Excedente de la Empresa 1: $u_1 = 90 - 60 = \mathbf{30.00}$ millones de euros.

- **Comparación e Ilustración del Teorema de Vickrey:**
  - En esta realización muestral específica, el Estado recaudó 75 millones en Vickrey y 60 millones en Primer Precio. Esto se debe a que la realización empírica de $v_2 = 75$ estuvo muy próxima a $v_1 = 90$.
  - En valor esperado ex-ante sobre el soporte $[0, 100]$, el **Teorema de Equivalencia del Ingreso de Vickrey (1961)** establece que ambos mecanismos generan exactamente el mismo ingreso esperado:
    $$\mathbb{E}[R] = \frac{N - 1}{N + 1} \bar{v} = \frac{3 - 1}{3 + 1} \times 100 = \frac{2}{4} \times 100 = \mathbf{50.00} \text{ millones de euros}$$

---

### Solución Ejercicio 2 (Tributación Óptima de Mirrlees en Dos Tipos)

#### 1. Primer Mejor (Información Simétrica)
- **Condición de eficiencia en horas de trabajo:**
  $$MRS_i = \frac{-\partial u / \partial y}{\partial u / \partial c} = \frac{y_i / w_i^2}{1} = \frac{y_i}{w_i^2} = 1 \implies y_i^{FB} = w_i^2$$
  - Para el tipo bajo ($w_L = 10$):
    $$y_L^{FB} = 10^2 = \mathbf{100}$$
  - Para el tipo alto ($w_H = 20$):
    $$y_H^{FB} = 20^2 = \mathbf{400}$$
  - Producción total agregada: $Y = y_L^{FB} + y_H^{FB} = 100 + 400 = \mathbf{500}$.

- **Reparto igualitario de consumo:**
  $$c_L^{FB} = c_H^{FB} = \frac{500}{2} = \mathbf{250}$$
  - Impuesto/Transferencia:
    - Tipo bajo: $T_L = y_L - c_L = 100 - 250 = \mathbf{-150}$ (subsidio neto de 150).
    - Tipo alto: $T_H = y_H - c_H = 400 - 250 = \mathbf{+150}$ (impuesto de suma fija de 150).

- **Incentivos a la imitación bajo información asimétrica:**
  - Si el tipo alto trabaja eficientemente ($y_H = 400, c_H = 250$):
    $$u_H^{verdad} = 250 - \frac{1}{2}\left(\frac{400}{20}\right)^2 = 250 - \frac{20^2}{2} = 250 - 200 = \mathbf{+50}$$
  - Si el tipo alto imita al tipo bajo produciendo $y_L = 100$ para recibir $c_L = 250$:
    $$u_H^{imita} = 250 - \frac{1}{2}\left(\frac{100}{20}\right)^2 = 250 - \frac{5^2}{2} = 250 - 12.5 = \mathbf{+237.5}$$
  - Dado que $u_H^{imita} = 237.5 > u_H^{verdad} = 50$, el trabajador altamente productivo prefiere fingir incapacidad o pereza. El esquema de primer mejor colapsa porque la recaudación prevista de 150 desaparece y el Estado quiebra financieramente.

---

#### 2. Segundo Mejor (Modelo de Screening de Mirrlees)
- **Restricción de Compatibilidad de Incentivos (IC-H):**
  $$c_H - \frac{1}{2}\left(\frac{y_H}{w_H}\right)^2 \ge c_L - \frac{1}{2}\left(\frac{y_L}{w_H}\right)^2$$
  Reordenando términos:
  $$c_H - c_L \ge \frac{y_H^2 - y_L^2}{2 w_H^2}$$

- **Sustitución del presupuesto equilibrado ($c_H = y_L + y_H - c_L$):**
  En el óptimo distributivo, la restricción IC-H se activa con igualdad estricta:
  $$(y_L + y_H - c_L) - c_L = \frac{y_H^2 - y_L^2}{2 w_H^2} \implies 2 c_L = y_L + y_H - \frac{y_H^2 - y_L^2}{2 w_H^2}$$
  $$c_L = \frac{1}{2}\left(y_L + y_H - \frac{y_H^2 - y_L^2}{2 w_H^2}\right)$$

- **Objetivo Social: Maximizar $W = u_L = c_L - \frac{y_L^2}{2 w_L^2}$:**
  $$W(y_L, y_H) = \frac{1}{2}\left(y_L + y_H - \frac{y_H^2 - y_L^2}{2 w_H^2}\right) - \frac{y_L^2}{2 w_L^2}$$

- **Condición de Primer Orden respecto a $y_H$:**
  $$\frac{\partial W}{\partial y_H} = \frac{1}{2}\left(1 - \frac{2 y_H}{2 w_H^2}\right) = \frac{1}{2}\left(1 - \frac{y_H}{w_H^2}\right) = 0$$
  $$\implies y_H^* = w_H^2 = 20^2 = \mathbf{400}$$
  Evaluando la tasa marginal:
  $$MRS_H^* = \frac{y_H^*}{w_H^2} = \frac{400}{400} = 1 \implies \tau'(y_H) = 1 - MRS_H = \mathbf{0\%}$$
  Este es el **Teorema de la Tasa Marginal Cero en el Tope** (*Zero Top Marginal Rate Theorem*).

- **Condición de Primer Orden respecto a $y_L$:**
  $$\frac{\partial W}{\partial y_L} = \frac{1}{2}\left(1 + \frac{2 y_L}{2 w_H^2}\right) - \frac{y_L}{w_L^2} = \frac{1}{2} + \frac{y_L}{2 w_H^2} - \frac{y_L}{w_L^2} = 0$$
  Multiplicando por 2:
  $$1 + \frac{y_L}{w_H^2} - \frac{2 y_L}{w_L^2} = 0 \implies y_L \left(\frac{2}{w_L^2} - \frac{1}{w_H^2}\right) = 1$$
  $$y_L^* = \frac{1}{\frac{2 w_H^2 - w_L^2}{w_L^2 w_H^2}} = \frac{w_L^2}{2 - \frac{w_L^2}{w_H^2}} = \frac{w_L^2}{1 + \left(\frac{w_H^2 - w_L^2}{w_H^2}\right)}$$

- **Valores numéricos exactos:**
  $$\frac{w_L^2}{w_H^2} = \frac{100}{400} = 0.25$$
  $$y_L^* = \frac{100}{2 - 0.25} = \frac{100}{1.75} = \frac{400}{7} \approx \mathbf{57.14} < 100$$
  Tasa marginal efectiva en el tipo bajo:
  $$MRS_L^* = \frac{y_L^*}{w_L^2} = \frac{400 / 7}{100} = \frac{4}{7} \approx 0.5714$$
  $$\tau'(y_L) = 1 - MRS_L^* = 1 - \frac{4}{7} = \frac{3}{7} \approx \mathbf{42.86\%} > 0$$

- **Intuición Económica:**
  ¿Por qué el gobierno impone una tasa marginal positiva del 42.86% a los trabajadores pobres y 0% a los ricos?
  - Si el gobierno distorsiona a la baja el trabajo del tipo bajo ($y_L = 57.14$ en vez de $100$), el tipo bajo produce menos y recibe una transferencia menor.
  - Para el tipo alto, tener que reducir su producción a un nivel tan bajo ($57.14$) para cobrar el subsidio se vuelve extremadamente costoso en términos de aburrimiento y ocio forzado ineficiente.
  - Al hacer deliberadamente poco atractivo el paquete de bajos ingresos, la tentación del tipo alto de imitar al tipo bajo se extingue, lo que **relaja la restricción de incentivos** y permite al Estado redistribuir recursos netos sin provocar la deserción laboral de los más productivos.
  - En el tope, no hay nadie más por encima a quien disuadir de imitar; cualquier impuesto marginal a los más productivos destruiría riqueza sin aportar relajación de incentivos alguna.

---

### Solución Ejercicio 3 (El Modelo de Cuello de Botella de Vickrey)

#### 1. Equilibrio sin Peaje (Congestión y Cola Física)
- **Parámetros:**
  $N = 6,000$, $s = 3,000$ veh/hora $\implies$ Duración total del flujo = $N/s = 2.0$ horas.
  $t^* = 9.0$ AM. $\beta = 6$ €/h (temprano), $\gamma = 18$ €/h (tarde), $\alpha = 12$ €/h (cola).

- **Cálculo de horas de salida extrema ($t_0$ y $t_1$):**
  El primer conductor llega temprano en $t_0$ sin cola:
  $$C(t_0) = \beta (t^* - t_0) = 6 (9 - t_0)$$
  El último conductor llega tarde en $t_1$ sin cola:
  $$C(t_1) = \gamma (t_1 - t^*) = 18 (t_1 - 9)$$
  Dado que el cuello de botella procesa continuamente vehículos a razón $s$ durante 2 horas:
  $$t_1 - t_0 = \frac{N}{s} = 2.0 \implies t_1 = t_0 + 2$$
  En equilibrio de Nash de Wardrop, el costo de todos los conductores es idéntico:
  $$6(9 - t_0) = 18(t_0 + 2 - 9) \implies 54 - 6 t_0 = 18 t_0 - 126$$
  $$24 t_0 = 180 \implies t_0 = \mathbf{7.5} \text{ (7:30 AM)}$$
  $$t_1 = 7.5 + 2 = \mathbf{9.5} \text{ (9:30 AM)}$$

- **Costo total de equilibrio por conductor ($C^*$):**
  $$C^* = \beta(t^* - t_0) = 6 \times (9.0 - 7.5) = 6 \times 1.5 = \mathbf{9.00} \text{ euros}$$
  Alternativamente: $C^* = \gamma(t_1 - t^*) = 18 \times (9.5 - 9.0) = 18 \times 0.5 = 9.00$ euros.
  Fórmula analítica general:
  $$C^* = \frac{\beta \gamma}{\beta + \gamma} \frac{N}{s} = \frac{6 \times 18}{6 + 18} \times 2 = \frac{108}{24} \times 2 = 4.5 \times 2 = \mathbf{9.00} \text{ euros}$$

- **Costo Agregado y Tiempo Disipado en la Cola:**
  - Costo social total:
    $$TC = N \times C^* = 6,000 \times 9.00 = \mathbf{54,000} \text{ euros por día}$$
  - Por la geometría triangular del diagrama de acumulación de colas de Vickrey, el tiempo medio en cola es exactamente:
    $$\bar{T}_q = \frac{1}{2} \frac{\beta \gamma}{\alpha(\beta + \gamma)} \frac{N}{s}$$
    El costo de la cola representa exactamente la **mitad del costo total**:
    $$\text{Pérdida por cola} = \frac{1}{2} \times 54,000 = \mathbf{27,000} \text{ euros diarios}$$
    Esta suma se esfuma completamente en motores encendidos, contaminación y tiempo improductivo.

---

#### 2. El Peaje Óptimo de Vickrey
- **Estructura del Peaje Dinámico:**
  Vickrey propuso sustituir la cola física por un peaje financiero que crezca linealmente hasta las 9:00 AM y decrezca posteriormente:
  $$\tau(t) = \begin{cases} \beta (t - t_0) & \text{si } t_0 \le t \le t^* \\ \gamma (t_1 - t) & \text{si } t^* \le t \le t_1 \end{cases}$$
  - En los extremos ($t_0 = 7:30$ y $t_1 = 9:30$):
    $$\tau(7.5) = 0 \text{ euros}, \quad \tau(9.5) = 0 \text{ euros}$$
  - En la hora punta ($t^* = 9:00$ AM):
    $$\tau_{max} = \beta (9.0 - 7.5) = 6 \times 1.5 = \mathbf{9.00} \text{ euros}$$

- **Eliminación de la Cola y Bienestar:**
  - Bajo este peaje, la tasa de llegada de vehículos al puente coincide exactamente con la capacidad de descarga $s = 3,000$ veh/h en cada instante.
  - La cola se reduce a **cero segundos** ($T_q(t) = 0$).
  - Cada conductor paga exactamente la misma suma de costo generalizado que antes ($9.00$ euros), por lo que ningún conductor ve empeorado su bienestar individual directo.
  - La recaudación total del peaje es el área bajo el triángulo de peajes:
    $$\text{Recaudación} = \frac{1}{2} \times \tau_{max} \times N = \frac{1}{2} \times 9.00 \times 6,000 = \mathbf{27,000} \text{ euros diarios}$$
  - **Resultado de Eficiencia:** El 100% de la pérdida irrecuperable por congestión vehicular (los 27,000 euros diarios) se rescata y se transfiere al Estado como fondos públicos para financiar transporte colectivo, reparar calzadas o reducir impuestos directos.
  - **Aplicación contemporánea:** Este mecanismo es la base teórica directa de las zonas de bajas emisiones y peajes dinámicos de Singapur (*Electronic Road Pricing* - ERP), el *Congestion Charge* de Londres y la tarificación en los puentes del Hudson en Nueva York.

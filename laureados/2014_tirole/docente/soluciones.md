# Pauta Docente y Solucionario: Regulación, Información Asimétrica y Plataformas Bilaterales
**Premio Nobel de Economía 2014: Jean Tirole**  
*Material exclusivo para el equipo docente — Confidencial*

---

## Objetivos Pedagógicos y Contexto

El objetivo de esta guía es proporcionar al docente las deducciones analíticas formales, respuestas cuantitativas exactas y criterios de discusión teórica para evaluar los tres ejercicios prácticos basados en las contribuciones fundamentales de Jean Tirole:
1. **Laffont & Tirole (1986):** El diseño de contratos regulatorios óptimos bajo información asimétrica combinando selección adversa y riesgo moral.
2. **Rochet & Tirole (2003, 2006):** La teoría de mercados de dos lados, subsidios cruzados y el efecto balancín en la fijación de tarifas.
3. **Tirole (1988, 2017):** Organización industrial de plataformas Big Tech, contratos verticales, cuellos de botella competitivos y la Ley de Mercados Digitales (DMA).

---

## Solución Detallada del Ejercicio 1 (Nivel Básico)

### 1. Régimen de Costo-Plus (Reembolso Contable)

- **Nivel de esfuerzo $e$:**  
  La utilidad de la empresa es $U = t - \psi(e)$. Si el regulador reembolsa exactamente el costo contable incurrido y la transferencia neta fija es $t = 0$, la empresa maximiza:
  $$\max_{e \ge 0} U = 0 - \frac{1}{2} e^2 = -\frac{1}{2} e^2$$
  Dado que el esfuerzo genera desutilidad y ningún beneficio económico ni contractual, la solución es estrictamente en la esquina:
  $$e^* = 0$$

- **Costo observado realizado $C$:**  
  - Empresa Eficiente ($\beta_L = 20$): $C_L = \beta_L - 0 = 20$.
  - Empresa Ineficiente ($\beta_H = 30$): $C_H = \beta_H - 0 = 30$.

- **Problemas de eficiencia:**  
  El régimen Cost-Plus destruye el incentivo dinámico y operativo a la eficiencia productiva (*X-inefficiency*). La empresa infla costos contables, no invierte en tecnologías de ahorro de costos, contrata personal redundante o incurre en gastos suntuarios ("oro en las cañerías" o *gold-plating* bajo el efecto Averch-Johnson). Todo el sobrecosto es transferido íntegramente a las tarifas de los usuarios o al presupuesto fiscal.

---

### 2. Régimen de Precio Techo Fijo (*Price-Cap*)

- **Esfuerzo de la empresa eficiente $\beta_L$:**  
  Bajo un precio fijo regulado $\bar{P}$, la empresa se convierte en reclamante residual (*residual claimant*) del 100% de los ahorros de costos:
  $$\max_{e \ge 0} \pi = \bar{P} - (\beta - e) - \frac{1}{2} e^2$$
  Condición de primer orden:
  $$\frac{\partial \pi}{\partial e} = 1 - e = 0 \implies e^* = 1.0$$
  Tanto la empresa eficiente como la ineficiente eligen el esfuerzo de primer mejor $e^* = 1.0$.

- **Renta informacional apropiada por la empresa eficiente ($U_L$):**  
  Para que la empresa ineficiente ($\beta_H = 30$) participe sin quebrar ($U_H = 0$), el precio techo debe cubrir su costo neto con esfuerzo $e=1$:
  $$\bar{P} = C_H + \psi(1) = (30 - 1) + \frac{1}{2}(1)^2 = 29 + 0.5 = 29.5$$
  Si la empresa es eficiente ($\beta_L = 20$), su costo realizado con esfuerzo $e=1$ es $C_L = 20 - 1 = 19$.  
  Su desutilidad de esfuerzo es $\psi(1) = 0.5$.  
  Por ende, su beneficio neto (renta informacional) es:
  $$U_L = \bar{P} - C_L - \psi(1) = 29.5 - 19 - 0.5 = 10.0$$

- **Pérdida social:**  
  Dado que el costo de los fondos públicos es $\lambda = 0.20$, financiar esta renta informacional de $\$10.0$ cuesta socialmente a los contribuyentes:
  $$\Delta \text{Costo Social} = \lambda \cdot U_L = 0.20 \times 10.0 = 2.0 \text{ unidades de pérdida irrecuperable}$$

---

### 3. Diseño del Menú Óptimo de Laffont-Tirole

- **Condiciones formales:**
  1. *Participación del tipo ineficiente (RI):*  
     $$U_H = t_H - \psi(e_H) \ge 0 \implies t_H = \psi(e_H) = \frac{1}{2} e_H^2$$
  2. *Compatibilidad de incentivos del tipo eficiente (CI):*  
     Si el tipo eficiente finge ser ineficiente, debe reportar un costo observado igual a $C_H = \beta_H - e_H = 30 - e_H$.  
     Para lograr ese costo $C_H$ siendo un tipo de bajo costo ($\beta_L = 20$), el esfuerzo que debe realizar es menor:
     $$\tilde{e} = \beta_L - C_H = 20 - (30 - e_H) = e_H - 10$$
     (O más generalmente, requiere un esfuerzo $\hat{e} = e_H - (\beta_H - \beta_L)$).  
     Por tanto, la renta mínima para que el tipo eficiente diga la verdad es:
     $$U_L \ge \psi(e_H) - \psi(e_H - \Delta\beta) > 0$$

- **Intuición de "No distorsión en la cima":**  
  Para el tipo eficiente ($\beta_L$), no hay ningún tipo aún más eficiente por debajo de él al cual haya que restringirle rentas informacionales. Por lo tanto, el regulador le exige el esfuerzo de primer mejor ($e_L = 1.0$), garantizando plena eficiencia productiva.

- **Intuición de "Distorsión a la baja en el tipo ineficiente":**  
  Para el tipo ineficiente ($\beta_H$), exigirle un esfuerzo elevado $e_H$ haría que para el tipo eficiente sea muy tentador fingir ser ineficiente (ya que podría replicar ese resultado con un esfuerzo mínimo o nulo). Al exigir un contrato con esfuerzo degradado $e_H < 1$, el regulador hace que el contrato ineficiente sea poco atractivo para el tipo eficiente, reduciendo drásticamente la renta informacional $U_L$ que el Estado debe pagarle.

---

## Solución Detallada del Ejercicio 2 (Nivel Intermedio)

### 1. La Regla de Tarificación de Rochet-Tirole

- **Fórmula:**
  $$\frac{p_B - (c - p_S)}{p_B} = \frac{1}{\eta_B}$$
- **Significado de $(c - p_S)$:**  
  Representa el **costo marginal efectivo neto** de atraer a un usuario adicional en el lado $B$.  
  Cuando la plataforma incorpora a un consumidor más, incurre en un costo técnico de procesamiento $c$, pero ese consumidor realiza compras que generan un ingreso comercial de $p_S$ pagado por los vendedores.  
  Si $p_S > c$, el ingreso comercial incremental supera el costo de procesamiento, por lo que atender al consumidor reporta una **ganancia neta** para la plataforma antes de cobrarle nada. Por ende, el costo marginal imputable al consumidor es estrictamente negativo.

---

### 2. Cálculo Numérico del Subsidio Cruzado

- **Datos:** $c = 0.40$, $p_S = 1.00$, $\eta_B = 3.0$.
- **Costo marginal efectivo:**
  $$c - p_S = 0.40 - 1.00 = -0.60$$
- **Despeje algebraico:**
  $$\frac{p_B - (-0.60)}{p_B} = \frac{1}{3.0} = \frac{1}{3}$$
  $$3 (p_B + 0.60) = p_B$$
  $$3 p_B + 1.80 = p_B$$
  $$2 p_B = -1.80 \implies p_B^* = -0.90$$

- **Interpretación del precio negativo ($p_B^* = -0.90$):**  
  La plataforma debe remunerar o subsidiar al usuario con $\$0.90$ por cada uso de la tarjeta. En el mundo real, esto se implementa mediante programas de **cashback** (1% a 2% de devolución directa en efectivo), acumulación de millas de vuelo, puntos de lealtad, acceso a salas VIP y seguros de protección de compras sin costo de anualidad.

- **Error del análisis antimonopolio tradicional:**  
  Bajo la prueba clásica de depredación de precios de *Areeda-Turner* (diseñada para mercados de un solo lado), cobrar un precio inferior al costo marginal medio ($p < MC$) se tipifica como conducta predatoria desleal para expulsar competidores (*predatory pricing*). Sin embargo, Tirole demostró que en plataformas de dos lados, un precio negativo o nulo no es depredatorio ni busca destruir el mercado: es la estructura de precios natural y maximizadora del bienestar social para internalizar externalidades de red cruzadas.

---

### 3. El Efecto Balancín (*See-Saw Effect*)

- **Impacto de la reducción de $p_S$ de $\$1.00$ a $\$0.20$:**  
  Al topar la tasa al comercio en $p_S = 0.20$, el nuevo costo marginal efectivo para atender al consumidor pasa a ser:
  $$c - p_S = 0.40 - 0.20 = +0.20$$
  Recalculando la regla de Rochet-Tirole:
  $$\frac{p_B - 0.20}{p_B} = \frac{1}{3} \implies 3 p_B - 0.60 = p_B \implies 2 p_B = 0.60 \implies p_B^* = +0.30$$
  El precio al consumidor pasa de un subsidio de $-0.90$ a un cargo neto de $+0.30$.
- **Manifestaciones en la economía real:**  
  1. Los bancos eliminan los programas de cashback generosos y recompensas.
  2. Introducen o aumentan las comisiones de apertura y mantenimiento anual de las tarjetas.
  3. Los consumidores desincentivados reducen el uso de medios de pago electrónicos, retrocediendo hacia el efectivo, lo que reduce el volumen total de transacciones electrónicas transparentes.

---

## Solución Detallada del Ejercicio 3 (Nivel Avanzado / Reto)

### 1. La Justificación de Eficiencia de Apple

- **Externalidades bilaterales legítimas:**  
  Apple crea valor al ofrecer un entorno seguro, con filtrado estricto de malware, protección de privacidad de datos, herramientas avanzadas de desarrollo (APIs en Swift/Metal) y una pasarela de pago centralizada que reduce a cero el riesgo de fraude para los usuarios y la tasa de abandono de compras para los desarrolladores.
- **El problema del polizón (*free-riding*):**  
  Si un desarrollador utiliza la tienda de Apple para que millones de usuarios descubran, instalen y confíen en su app gratuitamente, pero luego los redirige a una web exterior para facturar la suscripción mensual, la plataforma no puede monetizar su inversión multimillonaria en I+D ni en infraestructura de seguridad.

---

### 2. La Teoría del Daño y el "Cuello de Botella de Terminación" (*Terminating Bottleneck*)

- **Monopolio sobre los usuarios propios:**  
  Aunque a nivel de hardware Apple compite con Android a escala global (cuota de mercado del ~30% mundial, ~55% en EE.UU.), a nivel de **acceso a los usuarios de iOS ya existentes**, Apple ejerce un monopolio absoluto de terminación (*single-homing* del usuario final). Un usuario de iPhone difícilmente cambiará de teléfono solo porque una app es más cara en la App Store (altos costos de cambio por compras previas, ecosistema de iCloud, reloj inteligente, mensajería iMessage).
- **Extracción de rentas por encima de las externalidades:**  
  Para los desarrolladores, los usuarios de iPhone representan el segmento de mayor poder adquisitivo del mercado. Al no existir tiendas alternativas permitidas en iOS (*sideloading* prohibido históricamente), los desarrolladores están cautivos: no tienen alternativa creíble fuera de la plataforma. La tasa del 30% uniforme fijada en 2008 ha permanecido congelada a pesar de que el costo marginal tecnológico de procesamiento de transacciones cayó más del 90%, evidenciando una extracción pura de renta monopólica desconectada de la internalización eficiente de externalidades.

---

### 3. Diseño de Remedios Regulatorios (Enfoque Tirole)

- **Propuesta de regulación participativa y dinámica de Tirole:**  
  Tirole recomienda evitar remedios regulatorios estáticos o prohibiciones tajantes que destruyan los incentivos de innovación. Aboga por:
  1. **Separación de servicios y fijación de precios desagregada (*unbundling*):** Desacoplar el servicio de distribución/seguridad de la app del servicio de pasarela de pago. Apple puede cobrar una comisión justa y auditable por el uso de su propiedad intelectual y APIs de seguridad, pero debe permitir pasarelas de pago independientes.
  2. **Eliminación de cláusulas anti-redireccionamiento (*anti-steering*):** Permitir a los desarrolladores informar libremente a los consumidores sobre precios en canales alternativos (como ordenó la Comisión Europea en el caso Spotify de 2024 y la Ley de Mercados Digitales - DMA).
  3. **Supervisión regulatoria de interoperabilidad:** Imponer a los *gatekeepers* la obligación técnica de ofrecer APIs abiertas de interoperabilidad sin degradar la seguridad del sistema operativo.

---

## Criterios de Evaluación y Errores Frecuentes

| Ejercicio | Ponderación | Aspecto Clave a Evaluar | Error Frecuente del Alumno |
| :--- | :--- | :--- | :--- |
| **1. Regulación** | 35% | Derivación correcta de $e=0$ en Cost-Plus, cálculo exacto de la renta de 10 en Price-Cap y justificación del principio "no distorsión en la cima". | Creer que en Cost-Plus la empresa se esfuerza por altruismo, o confundir renta informacional con costo social neto. |
| **2. Plataformas** | 35% | Cálculo exacto de $p_B^* = -0.90$, deducción del subsidio cruzado y comprensión del efecto balancín. | Despejar erróneamente la fórmula de Rochet-Tirole obteniendo un precio positivo, o considerar el precio negativo como delito de dumping. |
| **3. Caso Big Tech** | 30% | Capacidad de balancear las dos caras del mercado (eficiencias de red vs. abuso de cuello de botella de terminación). | Adoptar posturas ideológicas binarias (pro-Apple absoluta o anti-Big Tech ciega) sin emplear conceptos de microeconomía aplicada. |

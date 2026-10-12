# Guía del Docente y Solucionario Confidencial

> **Premio Nobel de Economía 1999: Robert A. Mundell**  
> **Tema:** Modelo Mundell-Fleming, Trinidad Imposible y Áreas Monetarias Óptimas  
> **Uso exclusivo para el cuerpo docente.** Contiene el desarrollo analítico exhaustivo, deducciones matemáticas paso a paso, cálculos cuantitativos exactos, criterios pedagógicos de evaluación y preguntas de examen para la guía de ejercicios de estudiantes.

---

## Criterios Pedagógicos Generales

Al evaluar esta unidad macroeconómica, asegúrese de que el estudiante logre:
1. **Comprender el mecanismo de ajuste cambiario vs. monetario:** No memorizar los multiplicadores, sino rastrear la cadena causal de eventos (shock $\to$ diferencial de tasas de interés $\to$ flujo de capitales $\to$ presión sobre la divisa $\to$ intervención del banco central o variación del tipo de cambio).
2. **Dominar la lógica del Trilema Macroeconómico:** Reconocer que la pérdida de autonomía monetaria bajo tipo de cambio fijo e integración financiera no es una opción de política, sino una identidad matemática y de equilibrio de mercado (UIP).
3. **Evaluar las áreas monetarias óptimas con pensamiento crítico:** Comprender que el euro y cualquier unión monetaria implican un compromiso estructural donde la supresión de la válvula de escape cambiaria debe suplirse con movilidad de mano de obra, flexibilidad salarial o transferencias fiscales.

---

## Solución al Ejercicio 1: Estática Comparativa en el Modelo Mundell-Fleming

### 1. Equilibrio Inicial

#### Curva IS
La demanda agregada se formula como:
$$Y = C + I + G + NX$$
Sustituyendo los componentes:
$$C = 50 + 0.80(Y - 0.25 Y) = 50 + 0.80(0.75 Y) = 50 + 0.60 Y$$
$$I = 120 - 10 i$$
$$G = 130$$
$$NX = 40 - 0.10 Y + 20 e$$

Sumando todos los términos:
$$Y = [50 + 0.60 Y] + [120 - 10 i] + 130 + [40 - 0.10 Y + 20 e]$$
$$Y = 340 + 0.50 Y - 10 i + 20 e$$
$$(1 - 0.50) Y = 340 - 10 i + 20 e$$
$$0.50 Y = 340 - 10 i + 20 e$$
$$Y = \frac{340 - 10 i + 20 e}{0.50} = 680 - 20 i + 40 e$$

Con $i = i^* = 6\%$ y $e_0 = 1.0$:
$$Y_0 = 680 - 20(6) + 40(1.0) = 680 - 120 + 40 = \mathbf{600}$$

*(Nota de verificación: con $Y_0 = 600$, $C = 50 + 0.60(600) = 410$, $I = 120 - 60 = 60$, $G = 130$, $NX = 40 - 60 + 20 = 0$. Suma: $410 + 60 + 130 + 0 = 600$. Equilibrio exacto).*

- **Producto inicial de equilibrio:** $Y_0 = 600$
- **Exportaciones netas iniciales:** $NX_0 = 40 - 0.10(600) + 20(1.0) = 40 - 60 + 20 = \mathbf{0.0}$ (balanza comercial equilibrada).

#### Curva LM y Oferta Monetaria
La demanda real de dinero con $P = 1.0$ es:
$$M_0 = 0.40 Y_0 - 8 i^* = 0.40(600) - 8(6) = 240 - 48 = \mathbf{192}$$

---

### 2. Escenario A: Expansión Fiscal con Tipo de Cambio Fijo

El gobierno expande el gasto público en $\Delta G = 25$ ($G' = 155$). La paridad cambiaria se fija en $e = 1.0$.

- La nueva curva IS es:
  $$0.50 Y = (340 + \Delta G) - 10 i + 20 e = 365 - 10(6) + 20(1.0) = 365 - 60 + 20 = 325$$
  $$Y_A = \frac{325}{0.50} = \mathbf{650}$$

- **Incremento del producto:** $\Delta Y = Y_A - Y_0 = 650 - 600 = \mathbf{+50.0}$.
- **Multiplicador del gasto fiscal:** $k_G = \frac{\Delta Y}{\Delta G} = \frac{50}{25} = \frac{1}{0.50} = \mathbf{2.0}$.
- **Oferta monetaria requerida ($M_A$):**
  $$M_A = 0.40(650) - 8(6) = 260 - 48 = \mathbf{212}$$
- **Variación de reservas internacionales ($\Delta M$):**
  $$\Delta M = M_A - M_0 = 212 - 192 = \mathbf{+20.0}$$
  El Banco Central debe comprar 20 unidades de reservas internacionales inyectando dinero nacional para evitar la apreciación del tipo de cambio.
- **Desplazamiento (*crowding-out*):** **0%**. La política fiscal es máximamente efectiva porque la tasa de interés permanece anclada en $i^* = 6\%$ gracias a la acomodación monetaria endógena.

---

### 3. Escenario B: Expansión Fiscal con Tipo de Cambio Flexible

Si el tipo de cambio flota libremente y la oferta de dinero se mantiene en $M_0 = 192$:

- El mercado monetario determina de forma unívoca el nivel de producto:
  $$\frac{M}{P} = 0.40 Y - 8 i^* \implies 192 = 0.40 Y_B - 48 \implies 0.40 Y_B = 240 \implies Y_B = \mathbf{600}$$
- **Incremento del producto:** $\Delta Y = 600 - 600 = \mathbf{0.0}$.
- **Nuevo tipo de cambio nominal ($e_B$):**
  Sustituimos $Y_B = 600$ e $i = 6\%$ en la nueva curva IS ($G' = 155$):
  $$0.50(600) = 365 - 10(6) + 20 e_B$$
  $$300 = 365 - 60 + 20 e_B = 305 + 20 e_B$$
  $$20 e_B = 300 - 305 = -5 \implies \Delta(20 e) = -25 \implies \Delta e = -\frac{25}{20} = -1.25$$
  $$e_B = 1.0 - 1.25 = \mathbf{-0.25} \quad (\text{apreciación cambiaria de } 1.25 \text{ unidades})$$
- **Nuevas Exportaciones Netas ($NX_B$):**
  $$NX_B = 40 - 0.10(600) + 20(e_B) = 40 - 60 + 20(-0.25) = -20 - 5 = \mathbf{-25.0}$$
- **Verificación de desplazamiento externo:**
  $$\Delta NX = NX_B - NX_0 = -25 - 0 = -25 = -\Delta G$$
  El desplazamiento externo es del **100%**: el aumento del gasto público es compensado con exactitud por un colapso idéntico en las exportaciones netas debido a la apreciación de la moneda nacional.

---

## Solución al Ejercicio 2: El Trilema Macroeconómico y Ataques Especulativos

### 1. Tasa de Política Inicial
La condición de paridad descubierta de intereses (UIP) es:
$$i_t = i_t^* + \frac{E_t[e_{t+1}] - e_t}{e_t} + \rho_t$$
Con $i^* = 4\%$, $E_t[e_{t+1}] = e_t = \bar{e} = 4.00$ y $\rho = 1\%$:
$$i_t = 4\% + 0\% + 1\% = \mathbf{5.0\%}$$

---

### 2. Shock Externo y Pérdida de Confianza
- Nueva tasa de la Fed: $i^{*\prime} = 6\%$.
- Nuevo riesgo país: $\rho' = 3\%$.
- Expectativa de depreciación porcentual:
  $$\frac{E_t[e_{t+1}] - \bar{e}}{\bar{e}} = \frac{4.60 - 4.00}{4.00} = \frac{0.60}{4.00} = 0.15 \quad (\mathbf{15.0\%})$$
- Tasa requerida por el Banco Central para sostener la paridad cambiaria:
  $$i_t^{defensa} = 6\% + 15\% + 3\% = \mathbf{24.0\%}$$

#### Dilema de Política y Colapso del Régimen Fijo
Elevar la tasa de política del $5\%$ al $24\%$ destruye el crédito bancario interno, dispara la tasa de morosidad hipotecaria y empresarial, profundiza la recesión e incrementa el déficit fiscal a través de la carga de intereses de la deuda pública. Los especuladores saben que el Banco Central no tolerará el costo económico y político de mantener una tasa del $24\%$ de forma prolongada, lo que precipita un ataque especulativo masivo que agota las reservas internacionales y culmina en una devaluación forzosa.

---

### 3. Vértices del Trilema Macroeconómico

1. **Opción Lado 3 (Flotación Cambiaria con Metas de Inflación):**
   - El país abandona la defensa de $\bar{e} = 4.00$ y permite que la moneda se deprecie hasta absorber la prima de riesgo y el shock de la Fed. Al flotar el tipo de cambio, el Banco Central retiene la autonomía para fijar la tasa de interés interna según las necesidades domésticas de empleo e inflación.
   - *Ejemplos históricos:* La salida del Reino Unido de la disciplina del Mecanismo Europeo de Tipos de Cambio (ERM) en 1992 ("Miércoles Negro"), o la adopción de metas de inflación con tipo de cambio flotante en México tras la crisis del Tequila de 1994-1995 y en Brasil tras la crisis de 1999.

2. **Opción Lado 2 (Controles a los Flujos de Capital):**
   - El país mantiene el tipo de cambio fijo $\bar{e} = 4.00$ y preserva su tasa de interés baja, pero prohíbe o grava fuertemente las salidas transfronterizas de capital, rompiendo el arbitraje de la paridad descubierta de tasas de interés (UIP).
   - *Ejemplo histórico:* Malasia en septiembre de 1998, cuando el Primer Ministro Mahathir Mohamad impuso controles estrictos a las salidas de capital para blindar su economía de la crisis financiera asiática sin elevar las tasas de interés ni devaluar el ringgit.

---

## Solución al Ejercicio 3: Evaluación de un Área Monetaria Óptima frente a Perturbaciones Asimétricas

### 1. La Tasa de Interés Única del Banco Central Común
Las demandas agregadas son:
$$y^N = 100 - 2.0(i - 2\%) + 10$$
$$y^S = 100 - 2.0(i - 2\%) - 6$$

El producto promedio de la unión es:
$$\bar{y} = \frac{y^N + y^S}{2} = 100 - 2.0(i - 2\%) + \frac{10 - 6}{2} = 100 - 2.0(i - 2\%) + 2$$
Para que el promedio coincida con el pleno empleo conjunto ($\bar{y} = 100$):
$$100 = 100 - 2.0(i - 0.02) + 2 \implies 2.0(i - 0.02) = 2 \implies i - 0.02 = 0.01 \implies \mathbf{i = 3\%} \quad (r = 1\%)$$

Niveles de producto con la tasa única $i = 3\%$ ($r = 1\%$):
- En Norte: $y^N = 100 - 2(1) + 10 = 100 - 2 + 10 = \mathbf{108}$ (**brecha del producto positiva de +8%**, sobrecalentamiento e inflación).
- En Sur: $y^S = 100 - 2(1) - 6 = 100 - 2 - 6 = \mathbf{92}$ (**brecha del producto negativa de -8%**, recesión profunda y desempleo).

#### El Problema de "Talla Única" (*One Size Fits All*)
La tasa de interés común del 3% es una media aritmética que no satisface a ninguno de los dos países: para Norte es excesivamente laxa (estimula el crédito en una economía ya sobrecalentada, alimentando burbujas de activos e inflación), mientras que para Sur es excesivamente contractiva (incapaz de estimular la demanda interna para evitar el desempleo masivo).

---

### 2. Mecanismos de Ajuste de Mundell

#### Con Tipos de Cambio Flexibles
Si mantuvieran monedas separadas (corona y peso), el tipo de cambio nominal absorbería de inmediato el shock: la corona norteña se apreciaría y el peso sureño se depreciaría. La depreciación del peso abarataría las exportaciones de Sur y encarecería sus importaciones, trasladando demanda mundial hacia los productos de Sur y restaurando simultáneamente el pleno empleo en ambos países ($y^N = y^S = 100$) sin alterar las tasas de interés ni causar desempleo.

#### Dentro de la Unión Monetaria (Criterios OCA de Mundell, 1961)
1. **Movilidad Laboral:** Los trabajadores desempleados de Sur migran hacia Norte, donde las empresas enfrentan escasez de mano de obra. La migración alivia el desempleo en Sur y modera las presiones salariales en Norte.
2. **Devaluación Interna (Flexibilidad Salarial):** Al no poder devaluar la moneda, Sur reduce sus salarios nominales y precios relativos para recuperar competitividad externa frente a Norte.
3. **Federalismo Fiscal:** Un presupuesto central común recauda más impuestos de Norte (que está en auge) y transfiere automáticamente recursos de desempleo e inversión a Sur.

#### Discusión Crítica: La Crisis del Euro (2010–2012)
En la Eurozona, los tres mecanismos fallaron o fueron insuficientes:
- **La movilidad laboral** fue muy baja debido a barreras idiomáticas, diferencias institucionales y fragmentación de los sistemas de pensiones (a diferencia de EE. UU., donde los trabajadores cruzan estados con facilidad ante shocks locales).
- **El presupuesto fiscal central de la UE** es minúsculo (apenas el 1% del PIB de la UE) y carece de un mecanismo automático de transferencias fiscales anticíclicas o seguro de desempleo común.
- Por ende, el peso del ajuste recayó exclusivamente sobre la **devaluación interna**, imponiendo años de austeridad fiscal extrema, desempleo masivo (superior al 25% en Grecia y España) y contracción del PIB.

---

## Rúbrica de Calificación Sugerida

| Sección | Criterios de Evaluación | Puntaje Máximo |
| :--- | :--- | :---: |
| **Ejercicio 1: Mundell-Fleming** | Deducción correcta de curvas IS y LM, cálculo de multiplicadores, justificación económica del crowding-out externo vs. acomodación monetaria. | 35 puntos |
| **Ejercicio 2: Trilema y UIP** | Aplicación exacta de la condición UIP, cálculo de la tasa defensiva del 24%, explicación conceptual rigurosa de las alternativas del trilema. | 30 puntos |
| **Ejercicio 3: Áreas Monetarias Óptimas** | Cálculo algebraico del dilema de la tasa común, contrastación formal con tipos flotantes y evaluación crítica de los criterios de Mundell aplicados a la Eurozona. | 35 puntos |
| **Total** | | **100 puntos** |

# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2022: Ben S. Bernanke, Douglas W. Diamond y Philip H. Dybvig

> **Nota confidencial para el profesor:** Este documento contiene las soluciones formales, desarrollos analíticos y criterios pedagógicos correspondientes a los ejercicios planteados en `estudiante/ejercicios.qmd`. No distribuir a los estudiantes.

---

### Solución Ejercicio 1 (Equilibrios Múltiples y Umbral Crítico $f^*$)

#### 1. Cálculo de $r_2$ en el equilibrio óptimo ($f = t = 0.20$):
- Dotación inicial invertida: $1.0$.
- Retiros tempranos en $T=1$: el banco atiende a $t = 0.20$ depositantes, pagando $r_1 = 1.25$ a cada uno.
- Activos liquidados en $T=1$: $t \cdot r_1 = 0.20 \times 1.25 = 0.25$.
- Activos remanentes para $T=2$: $1 - 0.25 = 0.75$.
- Valor maduro de los activos en $T=2$: $R \times 0.75 = 1.60 \times 0.75 = 1.20$.
- Población de depositantes pacientes en $T=2$: $1 - t = 1 - 0.20 = 0.80$.
- Pago por depositante paciente ($r_2$):
  $$r_2 = \frac{R(1 - t \cdot r_1)}{1 - t} = \frac{1.20}{0.80} = 1.50$$
- **Evaluación estratégica:** Como $r_2 = 1.50 > r_1 = 1.25$, ningún depositante paciente tiene incentivo a retirar en $T=1$ si anticipa que los demás pacientes esperarán. $f = 0.20$ es un equilibrio de Nash perfecto y eficiente en el sentido de Pareto.

#### 2. Cálculo del umbral crítico de indiferencia ($f^*$):
El umbral de pánico se define donde esperar a $T=2$ rinde exactamente lo mismo que retirar en $T=1$:
$$V_2(f^*) = V_1(f^*) \implies \frac{R(1 - f^* r_1)}{1 - f^*} = r_1$$
Despejando analíticamente:
$$R - R r_1 f^* = r_1 - r_1 f^*$$
$$R - r_1 = f^* (R r_1 - r_1) = f^* r_1 (R - 1)$$
$$f^* = \frac{R - r_1}{r_1(R - 1)}$$
Sustituyendo los valores del problema ($R = 1.60$, $r_1 = 1.25$):
$$f^* = \frac{1.60 - 1.25}{1.25 \times (1.60 - 1.00)} = \frac{0.35}{1.25 \times 0.60} = \frac{0.35}{0.75} \approx 0.4667 \quad (46.67\%)$$

#### 3. Respuesta ante rumor con $f = 0.55$:
- Como $f = 0.55 > f^* \approx 0.4667$, el pago esperado de esperar es:
  $$V_2(0.55) = \frac{1.60 \times (1 - 0.55 \times 1.25)}{1 - 0.55} = \frac{1.60 \times (1 - 0.6875)}{0.45} = \frac{1.60 \times 0.3125}{0.45} = \frac{0.50}{0.45} \approx 1.111$$
- Como $V_2(0.55) \approx 1.111 < r_1 = 1.25$, el incentivo individual óptimo de cada depositante paciente es sumarse inmediatamente a la corrida y retirar sus fondos en $T=1$.
- Al hacerlo todos, $f$ se acelera hasta $1.0$, forzando la liquidación total de la cartera del banco antes de $T=2$. El banco quiebra no por insolvencia intrínseca ni proyectos defectuosos, sino por iliquidez derivada de la falta de coordinación.

---

### Solución Ejercicio 2 (Seguro de Depósitos vs. Riesgo Moral)

#### 1. Por qué el seguro creíble no tiene costo presupuestario en equilibrio:
- La corrida bancaria en Diamond-Dybvig surge únicamente cuando los depositantes temen que el banco se quede sin fondos para pagar a los últimos en la fila.
- Si el Estado garantiza incondicionalmente mediante su poder tributario que todo depositante paciente recibirá $r_2 = 1.50$ en $T=2$, la función de pago esperado se vuelve constante: $V_2^{seguro}(f) = r_2$ para cualquier $f$.
- Dado que $r_2 = 1.50 > r_1 = 1.25$, retirar temprano es una estrategia estrictamente dominada para todos los agentes pacientes.
- Por tanto, en equilibrio ningún agente paciente retira ($f = t$). El banco nunca entra en estrés de liquidez y el Estado nunca tiene que transferir un solo centavo de dinero de los contribuyentes. El seguro opera como una coordinación perfecta hacia el equilibrio bueno.

#### 2. Riesgo moral y necesidad de regulación prudencial:
- **Incentivo perverso de la administración:** 
  - Si el banco elige el *Proyecto Seguro*, el retorno esperado es $1.50$, dejando un margen estable tras pagar a los depositantes.
  - Si elige el *Proyecto Especulativo*, en el escenario positivo ($p = 0.6$) rinde $2.50$, permitiendo a los accionistas embolsarse cuantiosos beneficios netos ($2.50 - r_2$). En el escenario negativo ($1 - p = 0.4$), el banco quiebra ($R=0$), pero los accionistas tienen responsabilidad limitada (*limited liability*) y los depositantes son compensados íntegramente por el Estado.
  - Los accionistas privatizan las ganancias extraordinarias y socializan las pérdidas. Como los depositantes están 100% protegidos, no disciplinan al banco ni exigen mayores tasas por riesgo.
- **Fundamento de la regulación de capital (Basilea):** Para evitar este oportunismo, los reguladores imponen requisitos de capital mínimo propio (patrimonio neto no garantizado en riesgo) y restricciones de liquidez (LCR y NSFR), obligando a los accionistas a absorber las primeras pérdidas antes de activar cualquier garantía pública.

---

### Solución Ejercicio 3 (Banca en la Sombra y Caso Silicon Valley Bank 2023)

#### 1. Descalce de plazos y riesgo de tasa de interés:
- SVB captó depósitos a la vista masivos durante el auge tecnológico (2020-2021) e invirtió la mayor parte en bonos del Tesoro y cédulas hipotecarias de muy largo plazo (10 a 30 años) a tasas bajas (1%-2%).
- Cuando la Reserva Federal aumentó agresivamente las tasas de interés (de 0% a más de 4.75% en 2022-2023), el valor de mercado de dichos títulos de renta fija se desplomó (*duración financiera* elevada).
- Aunque los títulos eran libres de riesgo de impago (*credit risk* nulo), su valor de liquidación inmediata en $T=1$ ($L < 1$) generó pérdidas no realizadas multimillonarias que borraron casi la totalidad del capital contable del banco.

#### 2. Depósitos mayoristas no asegurados y corrida digital:
- Con el 94% de depósitos por encima de la cobertura de la FDIC (250.000 USD), las startups y firmas de capital de riesgo (*Venture Capital*) sabían que en caso de quiebra sufrirían recortes severos (*haircuts*).
- A diferencia de 1930 o 1983, la coordinación no requirió colas en la calle: grupos de WhatsApp, canales de Slack y redes sociales como Twitter/X coordinaron la retirada instantánea de 42.000 millones de USD en menos de 24 horas con un solo clic.
- La velocidad de la corrida digital reduce drásticamente el tiempo de reacción de los supervisores y acorta el margen de maniobra de la institución para obtener liquidez colateralizada.

#### 3. Aplicación del canal de crédito de Bernanke y excepción de riesgo sistémico:
- Bernanke (1983) demostró que cuando quiebran bancos especializados, se destruye el capital relacional y la información no transferible de monitoreo (*delegated monitoring*). Si los clientes corporativos de SVB no podían acceder a su liquidez para pagar nóminas e insumos, miles de startups y proveedores solventes habrían colapsado simultáneamente en un efecto dominó crediticio.
- La FDIC, la Fed y el Tesoro invocaron la *Systemic Risk Exception* para garantizar el 100% de los depósitos no asegurados con el objetivo explícito de frenar el contagio a otros bancos regionales (Signature Bank, First Republic) y evitar que la prima de financiamiento externo (*EFP*) se disparara en toda la economía de la innovación.

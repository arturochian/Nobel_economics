# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2025: Joel Mokyr, Philippe Aghion y Peter Howitt

> **Nota confidencial para el profesor:** Este material contiene las soluciones conceptuales, analíticas y cuantitativas a la guía de ejercicios de `estudiante/ejercicios.qmd`. No divulgar en la versión pública para estudiantes.

---

### Solución Ejercicio 1 (Tasa de Innovación y Obsolescencia Tecnológica)

1. **Impacto de un mayor salto de productividad ($\gamma$):**
   - **Mecanismo:** Un $\gamma$ más elevado incrementa la ventaja de costo o calidad del nuevo innovador frente a las tecnologías preexistentes. Esto expande directamente el flujo de beneficios monopolísticos $\pi_{t+1} = \gamma \pi_t$ que capturará el entrante exitoso.
   - **Efecto en equilibrio:** La condición de arbitraje de libre entrada de Aghion-Howitt iguala el salario de producción al valor esperado de innovar ($w_t = \lambda V_{t+1}$). Mayores rentas esperadas atraen más científicos y recursos al sector de investigación ($n^*$ sube de $0.3786$ a $0.4295$).
   - **Tasa de obsolescencia:** Al aumentar el número de investigadores, la probabilidad de que surja una nueva tecnología en un intervalo dado ($\mu = \lambda n^*$) se acelera. Por tanto, las empresas incumbentes experimentan una mayor tasa de obsolescencia (pasa de $9.46\%$ a $10.74\%$).

2. **Cálculo de vida media esperada ($T_{media} = 1/\mu$):**
   - En el Escenario Base:
     $$T_{media} = \frac{1}{0.0946} \approx 10.57 \text{ años}$$
   - En el Escenario Radical ($\gamma = 1.55$):
     $$T_{media} = \frac{1}{0.1074} \approx 9.31 \text{ años}$$
   - **Interpretación:** En economías con innovación de alto impacto tecnológico, el ciclo de vida de las empresas líderes se acorta más de un año completo, intensificando la rotación de mercado (*turnover* corporativo).

3. **Efecto "Business-Stealing" (Robo de Negocio):**
   - El innovador privado solo calcula su beneficio monopolístico $\pi_{t+1}$ al ingresar al mercado. Sin embargo, no internaliza que su entrada destruye el flujo de rentas del monopolista al que desplaza.
   - Esto introduce una externalidad negativa privada: si este efecto de destrucción no estuviera contrarrestado por los derrames intertemporales de conocimiento (efecto hombros de gigantes analizado por Aghion-Howitt y Mokyr), podría existir un incentivo privado excesivo a reemplazar productos de forma prematura.

---

### Solución Ejercicio 2 (La U-Invertida de Competencia e Innovación)

1. **Aumento de competencia desde el monopolio ($c = 0.15 \to c^* = 0.46$):**
   - **Efecto "Escapar de la Competencia" (*Escape-Competition Effect*):** En industrias donde las empresas rivales operan con tecnologías similares (*neck-and-neck*), un bajo nivel de competencia les permite coludir tácitamente o repartirse rentas de oligopolio sin necesidad de innovar. Al incrementarse la competencia o endurecerse las leyes antimonopolio, esas rentas conjuntas caen drásticamente. La única manera de restablecer márgenes positivos es innovar para adelantarse tecnológicamente al competidor. En este tramo de la curva, la innovación agregada pasa de un crecimiento del $1.37\%$ al $2.48\%$ anual.

2. **Impacto de una hiper-competencia destructiva ($c \to 0.90$):**
   - **Efecto Schumpeteriano de Desaliento:** En sectores asimétricos donde existe un líder consolidado y un seguidor rezagado, si la competencia en precios es despiadada, el seguidor sabe que aun si logra igualar al líder, las rentas futuras serán insignificantes. La falta de margen de beneficio post-innovación desincentiva la inversión de riesgo en I+D para los seguidores, quienes prefieren abandonar el mercado o no financiar proyectos de frontera. El crecimiento cae al $0.93\%$.

3. **Implicancia para la política de competencia (Antitrust / Regulación):**
   - Ni el monopolio protegido ni la competencia atomizada perfecta maximizan el dinamismo tecnológico.
   - Las autoridades antimonopolio deben enfocarse en erradicar barreras artificiales de entrada que congelan el statu quo, pero sin aniquilar los márgenes legítimos necesarios para amortizar costos hundidos de I+D de alto riesgo.

---

### Solución Ejercicio 3 (Reto de Política Pública: Subsidios vs. Patentes)

1. **Evaluación de la Política A (Subsidio fiscal que reduce la tasa de descuento efectiva $r = 0.04 \to r' = 0.02$):**
   - Evaluando analíticamente en `resolver_equilibrio_ah(r = 0.02)`:
     $$n^* = \frac{1.30 \times (0.4 / 0.6) \times 1.0 - (0.02 / 0.25)}{1 + 1.30 \times (0.4 / 0.6)} = \frac{0.8667 - 0.0800}{1.8667} = \frac{0.7867}{1.8667} \approx 0.4214$$
   - Empleo en I+D aumenta de $0.3786$ a $0.4214$ (+11.3%).
   - Tasa de innovación: $\mu = 0.25 \times 0.4214 = 0.1054$ ($10.54\%$ anual).
   - Tasa de crecimiento del PIB: $g = 0.1054 \times \ln(1.30) = 0.1054 \times 0.26236 \approx 2.77\%$ (frente a $2.48\%$ base).

2. **Evaluación de la Política B (Extensión de monopolio / reducción de competencia $c = 0.46 \to c = 0.20$):**
   - Al caer la competencia a $c = 0.20$, la economía desciende por la pendiente izquierda de la U-invertida de Aghion et al. (2005). Las empresas líderes establecidas caen en complacencia (desaparece el incentivo a escapar de la competencia). El multiplicador empírico contrae la tasa de innovación efectiva a casi la mitad, reduciendo el crecimiento económico a niveles cercanos al $1.5\%$ anual.

3. **Conexión con Joel Mokyr:**
   - Mokyr demostró históricamente en *The Gifts of Athena* que las sociedades que basaron su estrategia en proteger gremios y monopolios cerrados (como Gran Bretaña antes de 1750 o Francia en el Antiguo Régimen) terminaron en estancamiento tecnológico debido al bloqueo de los grupos de interés incumbentes (*rent-seeking coalitions*).
   - Por el contrario, la política que abarata la investigación y fomenta la difusión de "conocimiento útil" abierto (subsidios a la ciencia fundamental y capital humano) expande la frontera de posibilidades de producción sin generar atrincheramiento monopolístico.

# Guía para el Docente: Soluciones y Pautas Pedagógicas

## Nobel de Economía 1992: Gary S. Becker

> **Documento reservado para el equipo docente.** Contiene el desarrollo matemático completo de los ejercicios, código R ejecutable para el reto de economía de la familia y orientaciones conceptuales para la enseñanza del enfoque microeconómico del comportamiento no mercantil.

---

## 1. Pautas Pedagógicas y Objetivos de Aprendizaje

Al enseñar las contribuciones de Gary Becker, los docentes enfrentan con frecuencia la resistencia intuitiva de los estudiantes frente a la aplicación de la maximización utilitarista a fenómenos como el crimen, el matrimonio o la discriminación. Es crucial transmitir:

1. **La economía como método, no como objeto temático:** Como sintetizó Becker en su discurso Nobel de 1992, *"el enfoque económico no se define por estudiar mercados de bienes comerciales, sino por un método de análisis basado en agentes maximizadores, equilibrios de mercado y preferencias estables"*.
2. **Neutralidad moral de los modelos positivos:** El modelo de crimen de Becker no justifica el delito ni juzga la moralidad intrínseca; busca explicar qué palancas empíricas de incentivos (certeza de castigo vs. severidad) alteran la tasa delictiva agregada de modo predecible.
3. **El poder de la formación general vs específica:** La distinción de Becker en *Human Capital* (1964) es el fundamento indispensable para comprender la brecha salarial educativa, la retención de talento en empresas modernas y el diseño de programas de aprendices tipo dual alemán o becas corporativas.

---

## 2. Soluciones Detalladas de los Ejercicios

### Ejercicio 1: El Modelo de Crimen y Disuasión Penal (Nivel Básico)

#### Pregunta 1: Neutralidad al riesgo ($U(w) = w$)
- Utilidad del trabajo formal honesto:
  $$U(w_h) = w_h = 40,000$$
- Utilidad esperada de delinquir:
  $$EU(p) = (1 - p) \cdot Y + p \cdot (Y - f) = Y - p \cdot f$$
  Sustituyendo los valores monetarios:
  $$EU(p) = 70,000 - p \cdot 45,000$$
- Condición de indiferencia ($EU(p^*) = U(w_h)$):
  $$70,000 - 45,000 p^* = 40,000 \implies 45,000 p^* = 30,000 \implies p^* = \frac{30,000}{45,000} = \frac{2}{3} \approx 0.6667 \; (66.67\%)$$
- **Decisión ante efectividad policial:**
  - Si $p = 0.60 < p^*$: $EU(0.60) = 70,000 - 0.60(45,000) = 70,000 - 27,000 = \$43,000 > \$40,000$. **El individuo decide delinquir**, pues el crimen ofrece un retorno esperado superior al salario honesto.
  - Si $p = 0.70 > p^*$: $EU(0.70) = 70,000 - 0.70(45,000) = 70,000 - 31,500 = \$38,500 < \$40,000$. **El individuo es disuadido** y prefiere trabajar en el sector honesto.

#### Pregunta 2: Preferencia por el riesgo ($U(w) = w^2$)
- Utilidades evaluadas:
  - $U(w_h) = (40,000)^2 = 1,600,000,000 = 1.6 \times 10^9$
  - $U(Y) = (70,000)^2 = 4,900,000,000 = 4.9 \times 10^9$
  - $U(Y - f) = (25,000)^2 = 625,000,000 = 0.625 \times 10^9$
- Ecuación de indiferencia:
  $$EU(p^{**}) = (1 - p^{**}) U(Y) + p^{**} U(Y - f) = U(w_h)$$
  $$4.9 \times 10^9 - p^{**} (4.9 \times 10^9 - 0.625 \times 10^9) = 1.6 \times 10^9$$
  $$4.9 - 4.275 \cdot p^{**} = 1.6 \implies 4.275 \cdot p^{**} = 3.3 \implies p^{**} = \frac{3.3}{4.275} \approx 0.7719 \; (77.19\%)$$
- **Comparación e interpretación:**
  $p^{**} \approx 77.2\% > p^* \approx 66.7\%$.
  Un individuo amante del riesgo asigna una ponderación psíquica muy alta al escenario favorable de obtener $\$70,000$ impunemente. Por tanto, el Estado necesita garantizar una probabilidad de captura sustancialmente mayor para neutralizar el atractivo de la lotería delictiva.

#### Pregunta 3: Elasticidad de la disuasión (Teorema de Becker)
La utilidad esperada es $EU = (1 - p) U(Y) + p U(Y - f)$.
Las desutilidades marginales de aumentar la probabilidad $p$ y la sanción $f$ son:
$$\left| \frac{\partial EU}{\partial p} \right| = U(Y) - U(Y - f)$$
$$\left| \frac{\partial EU}{\partial f} \right| = p U'(Y - f)$$
Por el teorema del valor medio, existe un valor intermedio $\tilde{Y} \in (Y - f, Y)$ tal que:
$$U(Y) - U(Y - f) = f \cdot U'(\tilde{Y})$$
Si el agente es amante del riesgo en el margen, la utilidad marginal es estrictamente creciente ($U'' > 0$). Como $\tilde{Y} > Y - f$, se sigue que $U'(\tilde{Y}) > U'(Y - f)$. En consecuencia:
$$\left| \frac{\partial EU}{\partial p} \right| = f \cdot U'(\tilde{Y}) > f \cdot U'(Y - f) = \frac{f}{p} \left| \frac{\partial EU}{\partial f} \right|$$
Multiplicando por $p / EU$, obtenemos que la elasticidad de disuasión con respecto a la certeza del castigo supera estrictamente a la de la severidad:
$$\varepsilon_p > \varepsilon_f$$
**Implicación de política criminal:**
Aumentar penas en el papel (leyes más duras) es prácticamente inútil si la tasa de resolución policial de delitos es casi nula. Duplicar la presencia policial en zonas calientes eleva $p$, golpeando directamente el sesgo optimista de los delincuentes amantes del riesgo.

---

### Ejercicio 2: Capital Humano General vs. Específico (Nivel Intermedio)

#### Escenario A: Formación General Pura
1. **Financiamiento por empresas en competencia:**
   En un mercado competitivo, las habilidades generales son transferibles a costo cero entre todas las firmas. Si una firma pagara el costo $C = \$8,000$, al inicio del período 2 el trabajador tiene una productividad marginal de $MP_2^* = \$32,000$. Si la firma que financió la capacitación le ofrece un salario $w_2 < \$32,000$ (para recuperar su inversión), cualquier otra firma competidora que no incurrió en costos le ofrecerá inmediatamente $w_2' = \$32,000$. La empresa original sufriría una pérdida neta irrecuperable. Por ello, ninguna empresa privada en equilibrio competitivo financiará la formación general pura.
2. **Salario del período 1:**
   El aprendiz financia su formación aceptando un salario neto reducido por el valor del costo de capacitación:
   $$w_1 = MP_1 - C = 20,000 - 8,000 = \$12,000$$
3. **Cálculo del Valor Presente Neto ($VPN$):**
   $$VPN = (w_1 - MP_1) + \frac{w_2 - MP_2}{1 + r} = -8,000 + \frac{32,000 - 20,000}{1 + 0.10} = -8,000 + \frac{12,000}{1.10} = -8,000 + 10,909.09 = +\$2,909.09$$
   Como $VPN > 0$, **la inversión en capital humano general es altamente rentable** para el trabajador a lo largo de su ciclo de vida.

#### Escenario B: Formación Específica de la Empresa
1. **Salarios con costos y rentas compartidas al 50%:**
   - En el período 1, el costo de $\$8,000$ se divide en partes iguales ($\$4,000$ la firma y $\$4,000$ el trabajador):
     $$w_1^{esp} = MP_1 - 0.50 \times C = 20,000 - 4,000 = \$16,000$$
   - En el período 2, la renta adicional de productividad es $MP_2^{esp} - MP_2 = 32,000 - 20,000 = \$12,000$. Compartiéndola al 50%:
     $$w_2^{esp} = 20,000 + 0.50 \times 12,000 = \$26,000$$
2. **Rechazo de ofertas externas:**
   Fuera de TechLocal, la productividad del trabajador es de solo $\$20,000$. Si otra firma le ofrece su productividad externa ($\$20,000$), el trabajador la rechazará categóricamente, ya que en TechLocal percibe $\$26,000$ gracias a la renta de especificidad.
3. **Estabilidad del empleo durante recesiones:**
   En una recesión, si el valor del producto marginal cae moderadamente (por ejemplo, a $\$28,000$), la empresa aún obtiene un margen positivo ($28,000 - 26,000 = \$2,000$) y el trabajador prefiere seguir empleado antes que percibir el salario alternativo deprimido. Tanto despidos (*layoffs*) como renuncias voluntarias (*quits*) se minimizan drásticamente con capital específico.

---

### Ejercicio 3: La Economía de la Familia y la Paradoja Demográfica (Nivel Avanzado / Reto en R)

#### 1. Precios Sombra
El gasto familiar total es $G(n, q) = p_n n + p_q q + \pi n q$.
Diferenciando parcialmente:
$$\pi_n = \frac{\partial G}{\partial n} = p_n + \pi \cdot q$$
$$\pi_q = \frac{\partial G}{\partial q} = p_q + \pi \cdot n$$
**Explicación económica:**
Aumentar la cantidad de hijos en una unidad no cuesta únicamente el precio base $p_n$, sino que exige proveer el nivel de educación y comodidades vigente ($q$) a ese nuevo descendiente ($\pi \cdot q$). A mayor calidad buscada por los padres, más prohibitivo se vuelve tener hijos adicionales.

#### 2. Código R para la Optimización Numérica
El siguiente script resuelve el problema de optimización no lineal y grafica las sendas de expansión:

```r
# Solución del Reto en R: Cantidad vs Calidad de Hijos (Becker & Lewis)
library(ggplot2)
library(dplyr)

p_n <- 5000
p_q <- 4000
pi  <- 2000

# Función para encontrar (n*, q*) dado un ingreso I
optimizar_familia <- function(Ingreso) {
  # Maximizar U = n^0.5 * q^0.5 equivale a maximizar log(n) + log(q)
  # Sujeto a: p_n * n + p_q * q + pi * n * q = I
  
  # Para cada valor posible de n, despejar q factible:
  # q(n) = (I - p_n * n) / (p_q + pi * n)
  obj <- function(n) {
    q_factible <- (Ingreso - p_n * n) / (p_q + pi * n)
    if (q_factible <= 0) return(-1e9)
    return(-(0.5 * log(n) + 0.5 * log(q_factible))) # minimizar el negativo
  }
  
  n_max <- Ingreso / p_n
  res <- optimize(obj, interval = c(0.05, n_max - 0.05))
  n_opt <- res$minimum
  q_opt <- (Ingreso - p_n * n_opt) / (p_q + pi * n_opt)
  
  return(data.frame(Ingreso = Ingreso, n = n_opt, q = q_opt))
}

# Evaluar para un continuo de ingresos de 30,000 a 300,000
ingresos_seq <- seq(30000, 300000, by = 5000)
resultados <- do.call(rbind, lapply(ingresos_seq, optimizar_familia))

# Gráfico de sendas de calidad y cantidad
# Conforme el ingreso se multiplica por 10, la calidad q crece drásticamente
# mientras la cantidad n muestra rendimientos decrecientes y estancamiento.
```

#### 3. Interpretación de la Transición Demográfica
En los países avanzados, los salarios crecientes elevan el costo de oportunidad del tiempo parental (Becker, 1965) y los retornos del mercado laboral premian fuertemente el capital humano sofisticado. Por consiguiente, los hogares redirigen el incremento de sus rentas hacia financiar maestrías, actividades extracurriculares y mejor salud para 1 o 2 hijos ($q \uparrow$), en lugar de dispersar su presupuesto en familias numerosas ($n \downarrow$).

---

## 3. Rúbrica de Evaluación Analítica

| Criterio | Excelente (90–100%) | Satisfactorio (70–89%) | En Desarrollo (<70%) |
| :--- | :--- | :--- | :--- |
| **Ejercicio 1: Modelo de Crimen** | Deduce con exactitud los valores $p^*$ y $p^{**}$. Demuestra analíticamente el teorema de elasticidades de Becker ($\varepsilon_p > \varepsilon_f$) usando la convexidad de $U(w)$. | Calcula los umbrales correctamente pero tiene explicaciones imprecisas sobre la elasticidad de la aversión al riesgo. | Errores algebraicos en el cálculo de utilidad esperada o confusión conceptual en las probabilidades. |
| **Ejercicio 2: Capital Humano** | Explica con claridad la ausencia de incentivos de las firmas para financiar formación general. Calcula correctamente el $VPN$ y analiza el reparto 50-50 de rentas específicas. | Realiza los cálculos de salarios y $VPN$, pero flaquea en la justificación de estabilidad frente a recesiones. | No distingue entre capital humano general y específico; errores en la fórmula de descuento intertemporal. |
| **Ejercicio 3: Reto Demográfico** | Deduce formalmente los precios sombra cruzados $\pi_n$ y $\pi_q$. Plantea e implementa con éxito la optimización numérica no lineal en R e interpreta la transición demográfica. | Deduce los precios sombra e interpreta la intuición económica, pero presenta fallas menores en la implementación del script R. | No comprende la naturaleza multiplicativa de la restricción presupuestaria; no formula el problema en R. |

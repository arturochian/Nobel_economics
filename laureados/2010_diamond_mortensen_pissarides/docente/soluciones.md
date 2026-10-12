# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2010: Peter A. Diamond, Dale T. Mortensen y Christopher A. Pissarides

> **Nota confidencial para el profesor:** Este material contiene las resoluciones formales, derivaciones matemáticas completas y pautas pedagógicas correspondientes a la guía de actividades en `estudiante/ejercicios.qmd`. Mantener reservado para uso exclusivo del cuerpo docente.

---

### Solución Ejercicio 1: La Curva de Beveridge y la Dinámica de Flujos de Empleo

#### 1. Ecuación Diferencial de Flujos
- **Balance entre flujos de entrada y salida:**
  La variación instantánea del número de desempleados $\dot{u}_t$ es igual al flujo de trabajadores que se separan de su empleo menos el flujo de contrataciones efectivas generadas por la función de emparejamiento $M(u_t, v_t)$:
  $$\dot{u}_t = \delta (1 - u_t) - M(u_t, v_t) = \delta (1 - u_t) - \mu u_t^{1/2} v_t^{1/2}$$
- **Tasas individuales de transición:**
  - Tasa de salida del desempleo para un trabajador:
    $$f_t = \frac{M(u_t, v_t)}{u_t} = \mu \left(\frac{v_t}{u_t}\right)^{1/2} = \mu \theta_t^{1/2}$$
  - Tasa de cobertura de vacantes para una empresa:
    $$q_t = \frac{M(u_t, v_t)}{v_t} = \mu \left(\frac{u_t}{v_t}\right)^{1/2} = \mu \theta_t^{-1/2} = \frac{f_t}{\theta_t}$$

---

#### 2. Derivación Analítica de la Curva de Beveridge
- **Condición de estado estacionario:**
  Haciendo $\dot{u}_t = 0$:
  $$\delta (1 - u^*) = f(\theta) u^* \implies \delta = (\delta + f(\theta)) u^* \implies u^* = \frac{\delta}{\delta + f(\theta)} = \frac{\delta}{\delta + \mu \theta^{1/2}}$$
- **Ecuación explícita de la Curva de Beveridge $v(u)$:**
  A partir de $\delta(1 - u) = \mu u^{1/2} v^{1/2}$, despejamos $v^{1/2}$:
  $$v^{1/2} = \frac{\delta (1 - u)}{\mu u^{1/2}}$$
  Elevando ambos miembros al cuadrado:
  $$v(u) = \frac{\delta^2 (1 - u)^2}{\mu^2 u}$$
- **Demostración de pendiente negativa:**
  Derivando $v(u)$ con respecto a $u$ aplicando la regla del cociente:
  $$\frac{dv}{du} = \frac{\mu^2 u \left[2 \delta^2 (1 - u)(-1)\right] - \delta^2 (1 - u)^2 \mu^2}{(\mu^2 u)^2}$$
  Factorizando $\delta^2 (1 - u) \mu^2$ en el numerador:
  $$\frac{dv}{du} = \frac{\delta^2 \mu^2 (1 - u) \left[-2u - (1 - u)\right]}{\mu^4 u^2} = -\frac{\delta^2 (1 - u)(1 + u)}{\mu^2 u^2}$$
  Dado que en todo equilibrio económico $0 < u < 1$, los términos $(1 - u) > 0$, $(1 + u) > 0$, $\delta^2 > 0$ y $\mu^2 u^2 > 0$. Por lo tanto:
  $$\frac{dv}{du} = -\frac{\delta^2 (1 - u^2)}{\mu^2 u^2} < 0 \quad \forall u \in (0, 1)$$
  La relación entre vacantes y desempleo es estrictamente decreciente en el plano $(u, v)$, lo que formaliza la regularidad empírica de la Curva de Beveridge.

---

#### 3. Cálculo Numérico y Choque Estructural
- **Equilibrio inicial con $\theta = 1.0$, $\mu = 0.60$, $\delta = 0.03$:**
  - Tasa de salida del desempleo:
    $$f(1.0) = 0.60 \times (1.0)^{1/2} = \mathbf{0.60 \text{ mensual (60% al mes)}}$$
  - Duración promedio del desempleo:
    $$\mathbb{E}[D] = \frac{1}{f} = \frac{1}{0.60} \approx \mathbf{1.67 \text{ meses (aprox. 50 días)}}$$
  - Desempleo de equilibrio estacionario:
    $$u^* = \frac{0.03}{0.03 + 0.60} = \frac{0.03}{0.63} = \frac{1}{21} \approx \mathbf{0.0476 \ (4.76\%)}$$
  - Vacantes de equilibrio:
    $$v^* = \theta \times u^* = 1.0 \times 0.0476 = \mathbf{0.0476 \ (4.76\%)}$$

- **Choque estructural de desajuste de habilidades ($\mu = 0.40$):**
  - Tasa de salida del desempleo:
    $$f^{\text{nuevo}}(1.0) = 0.40 \times (1.0)^{1/2} = \mathbf{0.40 \text{ mensual}}$$
  - Duración promedio:
    $$\mathbb{E}[D]^{\text{nuevo}} = \frac{1}{0.40} = \mathbf{2.50 \text{ meses}}$$
  - Nuevo desempleo de equilibrio:
    $$u^{*\text{nuevo}} = \frac{0.03}{0.03 + 0.40} = \frac{0.03}{0.43} \approx \mathbf{0.0698 \ (6.98\%)}$$
  - Nuevas vacantes de equilibrio:
    $$v^{*\text{nuevo}} = 1.0 \times 0.0698 = \mathbf{0.0698 \ (6.98\%)}$$

- **Explicación económica para evaluación pedagógica:**
  - El estudiante debe destacar que la tasa de desempleo salta de $4.76\%$ a $6.98\%$ (+2.22 puntos porcentuales) aun cuando el ratio de vacantes por desempleado $\theta$ se mantiene inalterado. 
  - La curva de Beveridge completa se ha desplazado hacia el cuadrante superior derecho: para cualquier nivel dado de vacantes, hay más personas desempleadas porque el proceso de búsqueda es menos productivo.
  - *Implicación de política:* Un estímulo macroeconómico de demanda agregada (monetario o fiscal) solo aumentaría más las vacantes sin resolver el problema de fondo; la respuesta correcta radica en políticas activas de empleo (capacitación laboral, reconversión de habilidades técnicas y subsidios a la movilidad geográfica).

---

### Solución Ejercicio 2: La Condición de Hosios y la Eficiencia Social

#### 1. Identificación Conceptual de Externalidades
- **Externalidades causadas por una empresa que abre una vacante:**
  1. *Externalidad de congestión negativa:* Al aumentar el número total de vacantes en el mercado, se reduce la probabilidad de que las demás firmas encuentren candidatos por unidad de tiempo ($q'(\theta) < 0$), encareciendo la búsqueda para los competidores.
  2. *Externalidad positiva de grosor de mercado (*thick-market*):* Un mayor número de vacantes eleva la probabilidad de que los trabajadores desempleados consigan trabajo rápidamente ($f'(\theta) > 0$), reduciendo el desempleo agregado.
- **Externalidades causadas por un trabajador desempleado:**
  1. *Externalidad de congestión negativa:* Hace más difícil que otros desempleados sean contratados.
  2. *Externalidad positiva:* Facilita que las empresas con vacantes encuentren empleados más velozmente.

---

#### 2. El Problema del Planificador Social Benevolente
- **Hamiltoniano en valor presente:**
  $$\mathcal{H} = e^{-rt} \left[ p(1 - u) + z u - c v \right] + \lambda_t \left[ \delta (1 - u) - \mu u^\alpha v^{1-\alpha} \right]$$
  donde $\lambda_t$ es el valor sombra de reducir el desempleo (equivalente al valor social de un empleo ocupado).
- **Condiciones de optimalidad de primer orden:**
  1. Respecto a las vacantes $v$:
     $$\frac{\partial \mathcal{H}}{\partial v} = -c - \lambda_t (1 - \alpha) \frac{M(u, v)}{v} = 0 \implies c = -\lambda_t (1 - \alpha) q(\theta)$$
     Definiendo $\mu_t = -\lambda_t$ (el valor social positivo del empleo):
     $$\mu_t = \frac{c}{(1 - \alpha) q(\theta)}$$
  2. Respecto al desempleo $u$:
     $$r \mu_t - \dot{\mu}_t = (p - z) - \delta \mu_t - \alpha \frac{M(u, v)}{u} \mu_t = (p - z) - (\delta + \alpha \theta q(\theta)) \mu_t$$
  En estado estacionario ($\dot{\mu}_t = 0$):
  $$(r + \delta + \alpha \theta q(\theta)) \mu_t = p - z \implies \mu_t = \frac{p - z}{r + \delta + \alpha \theta q(\theta)}$$
- **Igualando ambas expresiones de $\mu_t$:**
  $$\frac{c}{(1 - \alpha) q(\theta)} = \frac{p - z}{r + \delta + \alpha \theta q(\theta)}$$
  Multiplicando cruzado:
  $$\frac{(r + \delta) c}{q(\theta)} + \alpha c \theta = (1 - \alpha)(p - z)$$
  $$\frac{(r + \delta) c}{q(\theta)} = (1 - \alpha)(p - z) - \alpha c \theta$$
- **Interpretación del término $(1 - \alpha)$:**
  La elasticidad de emparejamiento con respecto a las vacantes es $\frac{\partial \ln M}{\partial \ln v} = 1 - \alpha$. Para que las decisiones de inversión en vacantes sean socialmente óptimas, la fracción del excedente neto $(p - z)$ que remunera a las empresas debe coincidir exactamente con su aporte marginal tecnológico a la función de matching.

---

#### 3. Comparación con el Mercado Descentralizado y la Condición de Hosios (1990)
- **Comparación término a término:**
  - Condición social: $\frac{(r + \delta) c}{q(\theta^{SP})} = (1 - \alpha)(p - z) - \alpha c \theta^{SP}$
  - Condición descentralizada: $\frac{(r + \delta) c}{q(\theta^*)} = (1 - \beta)(p - z) - \beta c \theta^*$
- Ambas ecuaciones determinan la misma tensión $\theta^* = \theta^{SP}$ si y sólo si:
  $$\mathbf{\beta = \alpha}$$
  **La condición de Hosios establece que la economía descentralizada es socialmente eficiente si el poder de negociación del trabajador ($\beta$) iguala la elasticidad del desempleo en la función de emparejamiento ($\alpha$).**
- **Diagnóstico Normativo:**
  - **Caso $\beta > \alpha$ (Poder sindical excesivo):** Los trabajadores extraen más rentas que su contribución marginal al emparejamiento. El costo salarial es excesivo, las empresas abren muy pocas vacantes, $\theta^* < \theta^{SP}$, y el desempleo resultante es ineficientemente alto (**subempleo**).
  - **Caso $\beta < \alpha$ (Monopsonio empresarial):** Las empresas extraen una tajada desproporcionada del excedente. Se produce una entrada masiva de vacantes ($\theta^* > \theta^{SP}$), incurriendo en un gasto social despilfarrador de costos de apertura ($c v$) y generando una externalidad de congestión masiva sobre las demás firmas (**sobrecreación de vacantes e ineficiencia por congestión**).

---

### Solución Ejercicio 3: Reforma al Seguro de Desempleo y Tensión Laboral

#### 1. Derivación Analítica del Efecto Marginal de $z$
- **Condición de creación de empleo en equilibrio:**
  $$(1 - \beta)(p - z) - c \left[ \beta \theta + \frac{r + \delta}{\mu} \theta^\alpha \right] = 0$$
- Definiendo la función implícita $F(\theta, z) = (1 - \beta)(p - z) - c \beta \theta - \frac{c(r + \delta)}{\mu} \theta^\alpha = 0$:
  $$\frac{\partial F}{\partial z} = -(1 - \beta)$$
  $$\frac{\partial F}{\partial \theta} = -c \beta - \frac{c(r + \delta) \alpha}{\mu} \theta^{\alpha - 1} = -c \left[ \beta + \frac{\alpha (r + \delta)}{\mu} \theta^{\alpha - 1} \right] < 0$$
- Aplicando el Teorema de la Función Implícita ($\frac{d\theta^*}{dz} = -\frac{\partial F/\partial z}{\partial F/\partial \theta}$):
  $$\frac{d\theta^*}{dz} = -\frac{-(1 - \beta)}{-c \left[ \beta + \frac{\alpha (r + \delta)}{\mu} \theta^{\alpha - 1} \right]} = -\frac{1 - \beta}{c \left[ \beta + \frac{\alpha (r + \delta)}{\mu} (\theta^*)^{\alpha - 1} \right]} < \mathbf{0}$$
  El signo es **estrictamente negativo**, ya que el numerador $(1 - \beta) > 0$ y el denominador es la suma de términos estrictamente positivos.
- **Efecto sobre el desempleo de equilibrio:**
  Dado que $u^* = \frac{\delta}{\delta + \mu (\theta^*)^{1-\alpha}}$:
  $$\frac{du^*}{d\theta} = -\frac{\delta \mu (1 - \alpha) (\theta^*)^{-\alpha}}{\left[\delta + \mu (\theta^*)^{1-\alpha}\right]^2} < 0$$
  Por regla de la cadena:
  $$\frac{du^*}{dz} = \left(\frac{du^*}{d\theta}\right) \left(\frac{d\theta^*}{dz}\right) = (-) \times (-) = \mathbf{> 0}$$
  Un aumento de los beneficios por desempleo incrementa inequívocamente la tasa de desempleo de estado estacionario.

---

#### 2. Mecanismo de Transmisión Económica
1. **Elevación del salario de reserva:** La utilidad esperada del desempleado $U$ aumenta directamente con $z$. Esto mejora la posición de amenaza del trabajador en la mesa de negociación salarial.
2. **Aumento del salario negociado:** Según la curva de Nash $w = (1 - \beta) z + \beta(p + c\theta)$, por cada dólar de aumento en $z$, el salario exigido aumenta en $(1 - \beta)$ dólares (manteniendo $\theta$ constante).
3. **Compresión del excedente empresarial:** El valor de un empleo ocupado para la firma cae: $J = \frac{p - w}{r + \delta}$.
4. **Desincentivo a la creación de vacantes:** Al ser $J < c / q(\theta)$, las empresas dejan de abrir vacantes. La tasa de tensión $\theta$ se desploma hasta que la tasa de cobertura $q(\theta)$ sube lo suficiente para restaurar el retorno nulo $V = 0$.
5. **Reducción de contrataciones y mayor desempleo:** La tasa de salida del desempleo $f(\theta)$ se reduce, prolongando la duración promedio de las personas sin empleo y aumentando el desempleo agregado $u^*$.

---

#### 3. Dilema Normativo y Evidencia Empírica Moderna
- **Por qué el subsidio óptimo NO es cero ($z^* > 0$):**
  1. *Aversión al riesgo y suavizamiento del consumo:* En las economías reales, los trabajadores son adversos al riesgo y enfrentan restricciones crediticias. La pérdida súbita del ingreso laboral provoca un colapso del bienestar y del consumo familiar (Baily 1978; Chetty 2008). El seguro social corrige esta falla de mercado.
  2. *Calidad del emparejamiento (*match quality*):* Con subsidios nulos ($z = 0$), los desempleados se ven forzados por necesidad a aceptar el primer trabajo precario o de baja productividad disponible. Un subsidio adecuado permite una búsqueda más eficiente, mejorando la productividad del empleo final y reduciendo la tasa de rotación futura.
- **Seguro de desempleo óptimo contra-cíclico (Landais, Michaillat y Saez, 2018):**
  - En recesiones severas, la demanda de empleo está deprimida ("recesión con escasez de vacantes"): la elasticidad del esfuerzo de búsqueda individual sobre el empleo agregado es muy pequeña (búsqueda tipo juego de sillas musicales). Por ende, el costo en distorsión moral de elevar $z$ es mínimo, mientras que el valor social de proteger a las familias es máximo.
  - En expansiones de pleno empleo, donde abundan las vacantes, el subsidio debe reducirse para no desincentivar la reinserción rápida. Por consiguiente, la política óptima dicta **prestaciones más generosas y de mayor duración en recesión, y más restrictivas en auge**.

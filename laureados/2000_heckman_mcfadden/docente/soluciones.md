# Guía Docente y Solucionario: Selección Muestral y Modelos de Elección Discreta

**Premio Nobel de Economía 2000: James J. Heckman y Daniel L. McFadden**  
*Material pedagógico exclusivo para el docente.*

---

## 1. Pautas Pedagógicas y Objetivos de Aprendizaje

Esta unidad didáctica introduce a los estudiantes a dos pilares fundacionales de la microeconometría cuantitativa. A menudo, los cursos introductorios de econometría transmiten la noción de que "recopilar datos y estimar MCO" es suficiente para responder cualquier pregunta causal o predictiva. Las contribuciones de Heckman y McFadden enseñan dos lecciones estructurales:
1. **La muestra no es inocente:** Los datos económicos son generados por agentes racionales que toman decisiones de autoselección. Ignorar quién entra y quién se queda fuera de la muestra sesga las conclusiones causales tanto como omitir variables fundamentales.
2. **Las decisiones discretas exigen microfundamentación probabilística:** Los seres humanos eligen entre alternativas cualitativas discretas (transportes, carreras, productos) guiados por la maximización de utilidad. El modelo de regresión lineal continuo es conceptual y empíricamente inapropiado para este tipo de variables dependientes.

Al finalizar la unidad, los estudiantes deberán:
- Derivar algebraicamente la Razón Inversa de Mills y explicar por qué MCO produce un sesgo por variable omitida en presencia de autoselección.
- Justificar teóricamente por qué una restricción de exclusión es indispensable para identificar robustamente el modelo de Heckman.
- Explicar la teoría del Modelo de Utilidad Aleatoria (RUM), demostrar la propiedad IIA del Logit Condicional y resolver la clásica paradoja del autobús rojo/azul.

---

## 2. Solución Detallada de los Ejercicios

### Solución al Ejercicio 1: Intuición del Sesgo de Selección y Cálculo de Mills (Nivel Básico)

#### 1. Comportamiento de la Razón Inversa de Mills:
La razón inversa de Mills se define como $\lambda(z) = \frac{\phi(z)}{\Phi(z)}$, donde $\phi(z) = \frac{1}{\sqrt{2\pi}} e^{-z^2/2}$ y $\Phi(z) = \int_{-\infty}^z \phi(t) dt$.

- **Cálculo numérico:**
  - Para $z = -1.645$:  
    $\phi(-1.645) = 0.1031$, $\Phi(-1.645) = 0.0500$.  
    $$\lambda(-1.645) = \frac{0.1031}{0.0500} \approx \mathbf{2.062}$$
  - Para $z = 0.000$:  
    $\phi(0) = \frac{1}{\sqrt{2\pi}} \approx 0.3989$, $\Phi(0) = 0.5000$.  
    $$\lambda(0) = \frac{0.3989}{0.5000} \approx \mathbf{0.798}$$
  - Para $z = +1.645$:  
    $\phi(+1.645) = 0.1031$, $\Phi(+1.645) = 0.9500$.  
    $$\lambda(+1.645) = \frac{0.1031}{0.9500} \approx \mathbf{0.109}$$

- **Monotonicidad e interpretación:**
  - $\lambda(z)$ es una función estrictamente **decreciente** y convexa en $z$ ($\lim_{z \to -\infty} \lambda(z) = +\infty$, $\lim_{z \to +\infty} \lambda(z) = 0$).
  - Las personas que tienen una propensión muy baja a participar ($z$ muy negativo), pero que a pesar de ello deciden trabajar ($d_i = 1$), presentan un valor de $\lambda$ extraordinariamente elevado ($\lambda \approx 2.06$).
  - *Intuición económica:* Para que alguien con características observables desfavorables decida ingresar al mercado laboral, su componente de choque inobservable $u_i$ debió haber sido excepcionalmente positivo para superar el umbral de reserva ($u_i > -W_i'\gamma$). En cambio, para alguien casi seguro de participar ($z = 1.645$), el hecho de observarla empleada no aporta prácticamente información adicional sobre su error inobservable ($\lambda \approx 0.11$).

#### 2. Dirección del Sesgo de MCO:
- Supongamos que $\rho = \text{Corr}(u_i, \epsilon_i) > 0$. Esto significa que aquellos factores inobservables que impulsan a una persona a trabajar (tenacidad, destreza, motivación) también hacen que gane más en el mercado ($y_i^*$).
- Si la educación eleva la probabilidad de participar ($\gamma_{\text{educ}} > 0$):
  - Las personas con **alta educación** tienen un $z_i$ elevado; casi todas trabajan, por lo que su error inobservable esperado $\mathbb{E}[\epsilon \mid d=1]$ es cercano a 0 ($\lambda$ bajo).
  - Las personas con **baja educación** tienen un $z_i$ bajo; solo trabaja una fracción pequeña y muy selecta, con un error inobservable $\mathbb{E}[\epsilon \mid d=1]$ sumamente alto ($\lambda$ alto).
- **Consecuencia sobre la recta de regresión:**
  En la muestra observada, el salario promedio de las personas con baja educación está "inflado" artificialmente hacia arriba por la presencia de choques inobservables de alta productividad. Por tanto, la diferencia salarial observada entre personas con alta y baja educación es menor que la diferencia real en la población general:
  $$\hat{\beta}_{1, \text{MCO}} < \beta_{1, \text{Verdadero}}$$
  MCO **subestima** el retorno genuino a la educación. Al introducir $\hat{\lambda}_i$ como control, Heckit absorbe este componente omitido y recupera la pendiente real $\beta_1$.

---

### Solución al Ejercicio 2: Restricciones de Exclusión y Multicolinealidad en Heckit (Nivel Intermedio)

#### 1. Identificación por Forma Funcional vs. Restricción de Exclusión:
- **En teoría matemática:** Sí, el modelo de Heckman es identificable incluso si $W_i = X_i$, gracias a la no linealidad intrínseca de la función de razón inversa de Mills $\lambda(X_i'\gamma) = \frac{\phi(X_i'\gamma)}{\Phi(X_i'\gamma)}$. Puesto que $\lambda(\cdot)$ no es una función estrictamente lineal de sus argumentos, formalmente no existe colinealidad perfecta exacta.
- **En la práctica empírica:** Para valores moderados del índice latente ($X_i'\gamma \in [-1.5, +1.5]$, que abarca a la inmensa mayoría de las observaciones en una muestra real), la función $\lambda(z)$ es prácticamente lineal ($\lambda(z) \approx 0.798 - 0.60 z$). Si no existe ninguna variable en $W_i$ excluida de $X_i$, el término $\hat{\lambda}_i$ es aproximadamente una combinación lineal de las columnas de $X_i$:
  $$\hat{\lambda}_i \approx \alpha_0 + \sum_k \delta_k X_{ik}$$
  Esto genera **multicolinealidad casi perfecta** en la Etapa 2 de MCO. Los errores estándar de $\hat{\beta}$ y $\hat{\theta}$ explotan, los estimadores se vuelven sumamente sensibles al tamaño de muestra y los intervalos de confianza pierden toda precisión práctica.

#### 2. Evaluación de las Candidatas a Exclusión:
- **Candidata A (Número de niños menores de 6 años):**  
  *Válida.* La presencia de infantes incrementa drásticamente las responsabilidades de cuidado doméstico y eleva el salario de reserva de la madre (desincentivando la participación laboral, $\gamma_{\text{kids}} < 0$). Sin embargo, la presencia de un niño pequeño en el hogar no altera la productividad intrínseca o el valor marginal de mercado de la persona por hora trabajada. Es la variable de exclusión canónica en la literatura empírica.
- **Candidata B (Ingresos no laborales del cónyuge):**  
  *Válida.* Por el efecto ingreso de la teoría del consumidor, contar con rentas familiares o salario del cónyuge reduce la necesidad de trabajar (reduciendo la oferta laboral), pero no determina la productividad de mercado de la mujer.
- **Candidata C (Años de experiencia previa):**  
  *Inválida.* La experiencia laboral acumula capital humano (*on-the-job training*), incrementa la destreza técnica y eleva de manera directa la productividad marginal y el salario de mercado ($X_i$). Excluirla de la ecuación salarial generaría un sesgo directo por omisión de variable en la Etapa 2.

---

### Solución al Ejercicio 3: Reto Teórico — McFadden RUM y la Paradoja IIA (Nivel Avanzado)

#### 1. Deducción del Odds Ratio:
Dadas las probabilidades de elección en el Logit Condicional:
$$P_j = \frac{e^{V_j}}{\sum_{m \in \mathcal{C}} e^{V_m}}, \quad P_k = \frac{e^{V_k}}{\sum_{m \in \mathcal{C}} e^{V_m}}$$
Dividiendo ambas expresiones:
$$\frac{P_j}{P_k} = \frac{\frac{e^{V_j}}{\sum_{m} e^{V_m}}}{\frac{e^{V_k}}{\sum_{m} e^{V_m}}} = \frac{e^{V_j}}{e^{V_k}} = \exp(V_j - V_k)$$
El cociente depende exclusivamente de las utilidades determinísticas de las alternativas $j$ y $k$. Cualquier cambio en los atributos de una tercera alternativa $m \neq j, k$, o incluso la entrada o salida de alternativas en $\mathcal{C}$, cancela el denominador común y deja el cociente $\frac{P_j}{P_k}$ inalterado. Esto demuestra formalmente la propiedad de **Independencia de Alternativas Irrelevantes (IIA)**.

#### 2. La Paradoja del Autobús Rojo / Autobús Azul:
- **Escenario inicial:**
  - $V_{\text{auto}} = 0$, $V_{\text{bus azul}} = 0$.
  - Probabilidades iniciales:
    $$P_{\text{auto}} = \frac{e^0}{e^0 + e^0} = \frac{1}{2} = 50\%$$
    $$P_{\text{bus azul}} = \frac{e^0}{e^0 + e^0} = \frac{1}{2} = 50\%$$
- **Introducción del Autobús Rojo ($V_{\text{bus rojo}} = 0$):**
  - Aplicando mecánicamente la fórmula del Logit Multinomial con $\mathcal{C} = \{\text{auto}, \text{bus azul}, \text{bus rojo}\}$:
    $$P_{\text{auto}} = \frac{e^0}{e^0 + e^0 + e^0} = \frac{1}{3} \approx \mathbf{33.3\%}$$
    $$P_{\text{bus azul}} = \frac{1}{3} \approx \mathbf{33.3\%}$$
    $$P_{\text{bus rojo}} = \frac{1}{3} \approx \mathbf{33.3\%}$$
- **Contradicción con la realidad:**
  - El autobús rojo y el autobús azul son sustitutos perfectos. El viajero no distingue entre ellos salvo por un detalle irrelevante de pintura. La disponibilidad de un autobús rojo debería redistribuir la cuota de autobuses, pero **no** alterar la cuota del auto.
  - Las cuotas reales esperadas serían:
    $$P_{\text{auto}} = 50\%, \quad P_{\text{bus azul}} = 25\%, \quad P_{\text{bus rojo}} = 25\%$$
  - El modelo Logit estándar falla catastróficamente porque asume que los términos de error $\epsilon_{\text{bus azul}}$ y $\epsilon_{\text{bus rojo}}$ son estadísticamente independientes, cuando en realidad están perfectamente correlacionados ($\text{Corr} = 1$).

#### 3. Solución con el Logit Anidado (*Nested Logit*):
Daniel McFadden demostró que agrupando las alternativas en una jerarquía de dos niveles:
- **Nivel superior:** Auto vs. Transporte Público (Bus).
- **Nivel inferior:** Nido Bus compuesto por {Bus Azul, Bus Rojo}.

La función de distribución conjunta de los errores adopta una distribución de Valor Extremo Generalizado (GEV). Si el parámetro de correlación dentro del nido de autobuses tiende a 1, la probabilidad de la rama del auto permanece inalterada en $50\%$, y la probabilidad de la rama de autobús ($50\%$) se reparte equitativamente en $25\%$ y $25\%$, eliminando la anomalía de la IIA.

---

## 3. Criterios de Evaluación y Rúbrica Sugerida

| Nivel | Ejercicio 1 (Mills y Sesgo Heckman) | Ejercicio 2 (Restricciones Exclusión) | Ejercicio 3 (RUM e IIA McFadden) |
| :--- | :--- | :--- | :--- |
| **Excelente (90–100%)** | Calcula los tres valores de $\lambda$ con precisión decimal. Explica con maestría económica por qué $\rho > 0$ genera subestimación de la pendiente en la muestra observada. | Demuestra la casi linealidad de $\lambda$ en el rango empírico y justifica con solvencia económica la validez de los tres candidatos a instrumento. | Deduce el Odds Ratio paso a paso. Resuelve el caso numérico ($33.3\%$ vs $25\%$) y explica el rol del nido en el Nested Logit. |
| **Aceptable (70–89%)** | Calcula $\lambda$ correctamente pero titubea al argumentar la dirección del sesgo de MCO. | Comprende el rol de la restricción de exclusión pero clasifica erróneamente una de las tres variables. | Obtiene las probabilidades pero ofrece una explicación superficial de por qué colapsa el supuesto de independencia estocástica. |
| **Insuficiente (<70%)** | Errores en la fórmula de Mills o confusión entre truncamiento y censura. | No comprende por qué la no linealidad pura no basta en muestras finitas. | No deduce algebraicamente la IIA ni comprende la paradoja del autobús. |

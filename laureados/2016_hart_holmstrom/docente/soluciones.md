# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2016: Oliver Hart y Bengt Holmström

> **Nota confidencial para el profesor:** Este material contiene las resoluciones formales, derivaciones matemáticas completas y pautas pedagógicas correspondientes a la guía de actividades en `estudiante/ejercicios.qmd`. Mantener reservado para uso exclusivo del cuerpo docente.

---

### Solución Ejercicio 1 (El Principio de Informatividad y Remuneración Ejecutiva Relativa)

#### 1. Contrato Estándar sin Benchmarking
- **Varianza total del ruido:**
  Dado que los choques $\eta$ y $\varepsilon_y$ son mutuamente independientes:
  $$\operatorname{Var}(y) = \sigma_y^2 = \sigma_\eta^2 + \sigma_\varepsilon^2 = 4.0 + 1.0 = \mathbf{5.0}$$
- **Poder óptimo del incentivo ($\beta^*$):**
  Aplicando la fórmula clásica de Holmström (1979) para el modelo LEN con $k = 1.0$ y $r = 1.0$:
  $$\beta^* = \frac{1}{1 + r k \sigma_y^2} = \frac{1}{1 + (1.0)(1.0)(5.0)} = \frac{1}{6} \approx \mathbf{0.1667 \ (16.67\%)}$$
- **Esfuerzo gerencial inducido:**
  $$e^* = \frac{\beta^*}{k} = \frac{1/6}{1.0} \approx \mathbf{0.1667}$$
- **Prima de riesgo soportada:**
  $$\text{Prima de Riesgo (RP)} = \frac{1}{2} r (\beta^*)^2 \sigma_y^2 = \frac{1}{2} (1.0) \left(\frac{1}{6}\right)^2 (5.0) = \frac{5}{72} \approx \mathbf{0.0694}$$
- **Excedente social total generado:**
  $$W = e^* - \frac{1}{2} (e^*)^2 - \text{RP} = \frac{1}{6} - \frac{1}{72} - \frac{5}{72} = \frac{12 - 6}{72} = \frac{6}{72} = \mathbf{\frac{1}{12} \approx 0.0833}$$

---

#### 2. Incorporación de un Índice Sectorial (Principio de Informatividad)
- **Fundamento conceptual:**
  El Principio de Informatividad establece que cualquier variable observable $z$ que reduzca la incertidumbre condicional sobre el esfuerzo del agente ($e$) debe formar parte del contrato óptimo. El índice sectorial $z$ no refleja el esfuerzo del CEO, pero está contaminado por el mismo choque exógeno de la industria ($\eta$). Al condicionar el salario en $(y - \gamma^* z)$, el principal descuenta las fluctuaciones macroeconómicas ajenas al control del directivo.
- **Derivación del ponderador óptimo de filtrado ($\gamma^*$):**
  Buscamos el escalar $\gamma$ que minimice la varianza residual de la señal combinada $\hat{y} = y - \gamma z$:
  $$\operatorname{Var}(y - \gamma z) = \operatorname{Var}(y) + \gamma^2 \operatorname{Var}(z) - 2\gamma \operatorname{Cov}(y, z)$$
  Dado que $\operatorname{Cov}(y, z) = \operatorname{Cov}(\eta + \varepsilon_y, \eta + \varepsilon_z) = \sigma_\eta^2 = 4.0$, y $\operatorname{Var}(z) = \sigma_\eta^2 + \sigma_{\varepsilon_z}^2 = 4.0 + 1.0 = 5.0$:
  $$\frac{\partial \operatorname{Var}}{\partial \gamma} = 2\gamma \operatorname{Var}(z) - 2\operatorname{Cov}(y, z) = 0 \implies \gamma^* = \frac{\operatorname{Cov}(y, z)}{\operatorname{Var}(z)} = \frac{4.0}{5.0} = \mathbf{0.80}$$
- **Varianza residual purgada:**
  $$\sigma_{\text{resid}}^2 = \operatorname{Var}(y - 0.8 z) = 5.0 - (0.8)^2 (5.0) = 5.0 - 3.2 = \mathbf{1.80}$$
  *(Nótese que la varianza cayó de $5.0$ a $1.8$, una reducción del $64\%$ en la volatilidad soportada por el CEO).*
- **Nuevo poder óptimo de los incentivos bajo RPE ($\beta^*_{\text{RPE}}$):**
  $$\beta^*_{\text{RPE}} = \frac{1}{1 + (1.0)(1.0)(1.80)} = \frac{1}{2.80} \approx \mathbf{0.3571 \ (35.71\%)}$$
- **Impacto en el esfuerzo y el bienestar:**
  - El esfuerzo se incrementa en más del doble: $e^*_{\text{RPE}} = 0.3571$ (vs. $0.1667$).
  - La prima de riesgo es: $\text{RP}_{\text{RPE}} = \frac{1}{2}(1.0)(0.3571)^2(1.80) \approx 0.1148$.
  - El nuevo excedente social total es:
    $$W_{\text{RPE}} = 0.3571 - \frac{1}{2}(0.3571)^2 - 0.1148 \approx \mathbf{0.1786}$$
  - **Conclusión pedagógica:** El bienestar social y la productividad empresarial crecen un **$114\%$** gracias a la simple inclusión de una métrica de benchmarking relativo, demostrando el poder normativo del teorema de Holmström.

---

#### 3. Reflexión sobre Gobierno Corporativo y Realidad Empírica
- **Evidencia empírica contradictoria:** Bertrand y Mullainathan (2001) demostraron empíricamente que en muchas empresas cotizadas, los CEOs reciben remuneraciones vinculadas a la suerte (*pay for luck*): se les premia cuando el sector sube, pero los comités rara vez les penalizan o ajustan a la baja cuando el sector cae.
- **Fallas de gobernanza:** Lucian Bebchuk y Jesse Fried (*Pay without Performance*, 2004) explican que las juntas directivas frecuentemente sufren de captura gerencial (*managerial power hypothesis*). Los directivos utilizan consultores de remuneración para diseñar contratos que simulan estar basados en mérito pero que omiten deliberadamente el benchmarking relativo (RPE), permitiendo apropiarse de rentas corporativas sin asumir el riesgo de ser comparados rigurosamente con sus pares competidores.

---

### Solución Ejercicio 2 (Incentivos Multitarea y Distorsión en Educación y Salud)

#### 1. El Óptimo Social (Primer Mejor)
El bienestar social neto sin restricciones de verificabilidad es:
$$\max_{e_1, e_2} W(e_1, e_2) = 2 e_1 + 4 e_2 - \frac{1}{2}\left(e_1^2 + e_2^2 + 2(0.6) e_1 e_2\right)$$
Condiciones de primer orden:
$$\frac{\partial W}{\partial e_1} = 2 - e_1 - 0.6 e_2 = 0 \implies e_1 + 0.6 e_2 = 2$$
$$\frac{\partial W}{\partial e_2} = 4 - 0.6 e_1 - e_2 = 0 \implies 0.6 e_1 + e_2 = 4$$
Multiplicando la primera ecuación por $0.6$ y restando:
$$0.6 e_1 + 0.36 e_2 = 1.2$$
$$(1 - 0.36) e_2 = 4 - 1.2 \implies 0.64 e_2 = 2.8 \implies e_2^{FB} = \frac{2.8}{0.64} = \mathbf{4.375}$$
Sustituyendo en $e_1$:
$$e_1 = 2 - 0.6(4.375) = 2 - 2.625 = -0.625$$
Dado que el esfuerzo no puede ser negativo ($e_1 \ge 0$), la solución óptima restringida en la frontera es:
$$e_1^{FB} = \mathbf{0.0}, \qquad e_2^{FB} = \mathbf{4.0}$$
**Interpretación:** El planificador social preferiría que el 100% de la energía docente se consagre al desarrollo cognitivo y crítico profundo de los estudiantes, prescindiendo del adiestramiento artificial para pruebas mecánicas.

---

#### 2. La Respuesta del Docente ante un Bono Agresivo
El docente maximiza su utilidad neta:
$$\max_{e_1, e_2} \beta_1 e_1 - \frac{1}{2}\left(e_1^2 + e_2^2 + 1.2 e_1 e_2\right)$$
Condiciones de primer orden:
1. $e_1 + 0.6 e_2 = \beta_1$
2. $0.6 e_1 + e_2 = 0 \implies e_2 = -0.6 e_1$ *(o canibalización directa del tiempo de tutoría)*

Sustituyendo $e_2 = -0.6 e_1$:
$$e_1 - 0.36 e_1 = \beta_1 \implies 0.64 e_1 = \beta_1 \implies e_1(\beta_1) = \frac{\beta_1}{0.64} = \mathbf{1.5625 \beta_1}$$
El esfuerzo sustraído a la dimensión no medible es:
$$\Delta e_2 = -0.6 (1.5625 \beta_1) = -\mathbf{0.9375 \beta_1}$$

**Evaluación con bono agresivo $\beta_1 = 3.0$ y base $e_{2,\text{base}} = 3.0$:**
- Esfuerzo en exámenes estandarizados: $e_1 = 1.5625 \times 3.0 = \mathbf{4.6875}$.
- Esfuerzo remanente en pensamiento crítico:
  $$e_2 = \max(0, 3.0 - 0.9375 \times 3.0) = 3.0 - 2.8125 = \mathbf{0.1875}$$
  *(¡El pensamiento crítico y la atención personalizada prácticamente colapsan a cero!).*
- Beneficio social integral:
  $$B = 2(4.6875) + 4(0.1875) = 9.375 + 0.75 = \mathbf{10.125}$$
  Sin el bono ($\beta_1 = 0$, $e_1 = 0, e_2 = 3.0$), el beneficio social era:
  $$B_{\text{fijo}} = 2(0) + 4(3.0) = \mathbf{12.00}$$
- **Resultado:** Introducir el bono salarial reduce el beneficio social de 12.00 a 10.125, además de generar un elevado agotamiento docente (costo de esfuerzo elevado).

---

#### 3. Conclusión Pedagógica y Aplicación en Sanidad
- **Recomendación de Holmström y Milgrom (1991):** Cuando un puesto de trabajo exige múltiples tareas que compiten por el tiempo del empleado, y una de las dimensiones más prioritarias no puede medirse de forma objetiva, la intensidad del incentivo sobre las dimensiones medibles debe reducirse drásticamente o eliminarse por completo ($\beta_1 \approx 0$). De lo contrario, el agente optimiza la métrica descuidando la misión real (*Goodhart's Law*: "cuando una métrica se convierte en un objetivo, deja de ser una buena métrica").
- **Paralelo sanitario:** Si se retribuye a los médicos por acto clínico o volumen de cirugías (*fee-for-service*), aumentan las intervenciones quirúrgicas innecesarias y se desatiende el seguimiento preventivo y la escucha clínica. Por ello, muchos sistemas de salud combinan salarios fijos o pagos capitativos ajustados por riesgo con auditorías cualitativas.

---

### Solución Ejercicio 3 (Contratos Incompletos y el Dilema de la Privatización de Prisiones)

#### 1. Incentivos Bajo Propiedad Privada (Régimen 1)
- **Función de utilidad de la empresa privada:**
  La empresa es dueña de las instalaciones penitenciarias. Puede imponer el recorte de costos $e$ sin autorización gubernamental y quedarse con el 100% del ahorro ($c \cdot e$). En la mejora de calidad $i$, requiere renegociar con el Estado, capturando una fracción $\lambda = 0.5$ del valor social $b \cdot i$:
  $$U_{\text{priv}}(e, i) = c \cdot e + \lambda b \cdot i - \frac{1}{2} e^2 - \frac{1}{2} i^2 = 3 e + 0.5(4) i - \frac{1}{2} e^2 - \frac{1}{2} i^2$$
- **Esfuerzos óptimos privados:**
  $$e_{\text{priv}}^* = c = \mathbf{3.0}$$
  $$i_{\text{priv}}^* = \lambda b = 0.5(4) = \mathbf{2.0}$$
- **Excedente social total generado ($W_{\text{priv}}$):**
  $$W_{\text{priv}} = \left[ b \cdot i_{\text{priv}} - d \cdot e_{\text{priv}} \right] + c \cdot e_{\text{priv}} - \frac{1}{2}(e_{\text{priv}})^2 - \frac{1}{2}(i_{\text{priv}})^2$$
  $$W_{\text{priv}} = [4(2.0) - 2.5(3.0)] + 3(3.0) - \frac{1}{2}(3.0^2) - \frac{1}{2}(2.0^2)$$
  $$W_{\text{priv}} = [8.0 - 7.5] + 9.0 - 4.5 - 2.0 = 0.5 + 9.0 - 6.5 = \mathbf{3.00}$$

---

#### 2. Incentivos Bajo Propiedad Pública (Régimen 2)
- **Función de utilidad del alcaide público:**
  El Estado es dueño de las instalaciones. El funcionario no puede implementar recortes que degraden la seguridad sin autorización del Ministerio. Al renegociar innovaciones, solo captura una fracción reducida $\mu = 0.2$ tanto de los ahorros como de los reconocimientos por calidad:
  $$U_{\text{pub}}(e, i) = \mu c \cdot e + \mu b \cdot i - \frac{1}{2} e^2 - \frac{1}{2} i^2 = 0.2(3) e + 0.2(4) i - \frac{1}{2} e^2 - \frac{1}{2} i^2$$
- **Esfuerzos óptimos públicos:**
  $$e_{\text{pub}}^* = \mu c = 0.2(3) = \mathbf{0.60}$$
  $$i_{\text{pub}}^* = \mu b = 0.2(4) = \mathbf{0.80}$$
- **Excedente social total generado ($W_{\text{pub}}$):**
  $$W_{\text{pub}} = [4(0.80) - 2.5(0.60)] + 3(0.60) - \frac{1}{2}(0.60^2) - \frac{1}{2}(0.80^2)$$
  $$W_{\text{pub}} = [3.20 - 1.50] + 1.80 - 0.18 - 0.32$$
  $$W_{\text{pub}} = 1.70 + 1.80 - 0.50 = \mathbf{3.00}$$

---

#### 3. Análisis Comparativo e Implicaciones de Hart, Shleifer y Vishny (1997)
- **El umbral crítico del daño colateral ($d$):**
  Nótese que para $d = 2.5$, ambos regímenes empatan en $3.00$. Pero calculemos la derivada de la diferencia de bienestar respecto al deterioro de calidad $d$:
  $$\frac{\partial (W_{\text{pub}} - W_{\text{priv}})}{\partial d} = e_{\text{priv}}^* - e_{\text{pub}}^* = 3.0 - 0.6 = \mathbf{+2.40 > 0}$$
  Si el deterioro de calidad es más grave (por ejemplo, $d = 2.8$, motines, violencia carcelaria o reincidencia criminal por falta de guardias calificados):
  $$W_{\text{priv}}(d = 2.8) = [8.0 - 8.4] + 9.0 - 6.5 = \mathbf{2.10}$$
  $$W_{\text{pub}}(d = 2.8) = [3.20 - 1.68] + 1.80 - 0.50 = \mathbf{2.82}$$
  La propiedad pública supera claramente a la privada ($2.82 > 2.10$).
- **Por qué falla la privatización carcelaria según Oliver Hart:**
  Una empresa privada con fines de lucro tiene incentivos muy poderosos a recortar costos ($e = 3.0$), pero no internaliza el daño cualitativo que provoca cuando los estándares mínimos no pueden especificarse ni monitorearse en el contrato (violencia interna, mala alimentación, falta de rehabilitación). Dado que el Estado no puede prever todas las triquiñuelas de reducción de gastos en un pliego de condiciones, la titularidad pública del activo actúa como una salvaguarda institucional esencial.
- **Cuándo privatizar vs cuándo gestionar públicamente:**
  - **Privatización eficiente:** Servicios donde la calidad es fácilmente especificable y verificable contractualmente y donde las reducciones de costos no dañan la misión esencial (ej. recolección de basura, asfaltado de autopistas, suministro de material de oficina, generación eléctrica).
  - **Gestión pública superior:** Servicios donde la calidad es inobservable, el capital humano sensible y los recortes oportunistas generan catástrofes sociales no contratables (ej. prisiones de máxima seguridad, fuerzas armadas, policía, diseño curricular de educación inicial).

# Guía Docente y Solucionario: Bertil Ohlin y James E. Meade (Nobel 1977)

> **Material de uso pedagógico exclusivo para el profesorado.**  
> Este documento contiene pautas de enseñanza, desarrollos analíticos completos paso a paso, comentarios conceptuales y criterios de evaluación para los ejercicios contenidos en `laureados/1977_ohlin_meade/estudiante/ejercicios.qmd`.

---

## 1. Pautas Pedagógicas y Contexto Teórico

### El legado intelectual de Ohlin y Meade
El Premio Nobel de 1977 consolidó la teoría moderna de la economía internacional. Al enseñar este contenido, se recomienda articular tres conceptos nodales:

1. **La transición del modelo ricardiano al modelo Heckscher-Ohlin:**  
   Ricardo fundamentó la ventaja comparativa en diferencias tecnológicas exógenas con un único factor (productividad laboral). Ohlin demostró que, aun si dos países tienen acceso a la **misma tecnología**, surgirá comercio mutuamente ventajoso debido a diferencias en sus **dotaciones factoriales relativas** ($K/L$). Esto permite conectar la macroeconomía del comercio con la microeconomía de la distribución del ingreso (Stolper-Samuelson y Rybczynski).
2. **El principio de asignación de instrumentos de Meade:**  
   En economía abierta, las políticas no pueden evaluarse de manera aislada. Los estudiantes suelen cometer el error de proponer recetas mono-instrumentales (e.g., "reducir el desempleo bajando impuestos o aumentando el gasto público"). Enfatice que si la economía enfrenta simultáneamente un déficit de balanza de pagos (Zona III de Meade), la expansión fiscal pura precipitará una crisis cambiaría de reservas. Es indispensable combinar políticas de variación del gasto (*expenditure-changing*) con políticas de reorientación (*expenditure-switching*).
3. **La prudencia analítica de la Teoría del Segundo Mejor:**  
   Meade (1955) demostró que el libre comercio preferencial o regional no es necesariamente un paso hacia la eficiencia global. Enfatice la distinción entre *creación de comercio* (eficiencia paretiana) y *desviación de comercio* (ineficiencia asignativa). Este teorema sigue siendo una de las advertencias más poderosas contra el pensamiento económico dogmático.

---

## 2. Solución Detallada del Ejercicio 1 (Nivel Básico)

### Pregunta 1: Intensidad y Abundancia Factorial Relativa

- **Ratios capital-trabajo por sector:**
  - Sector Alimentos ($A$):
    $$k_A = \frac{a_{KA}}{a_{LA}} = \frac{1}{4} = 0,25 \text{ unidades de capital por hora de trabajo}$$
  - Sector Semiconductores ($S$):
    $$k_S = \frac{a_{KS}}{a_{LS}} = \frac{3}{2} = 1,50 \text{ unidades de capital por hora de trabajo}$$
  - Como $k_S = 1,50 > k_A = 0,25$, el sector **Semiconductores es intensivo en capital** y el sector **Alimentos es intensivo en trabajo**.

- **Dotación factorial agregada de cada país:**
  - País Alfa ($\alpha$):
    $$\left(\frac{\bar{K}}{\bar{L}}\right)_\alpha = \frac{150}{400} = 0,375$$
  - País Beta ($\beta$):
    $$\left(\frac{\bar{K}}{\bar{L}}\right)_\beta = \frac{200}{200} = 1,000$$
  - Dado que $(K/L)_\beta = 1,000 > (K/L)_\alpha = 0,375$, el **País Beta es relativamente abundante en capital** y el **País Alfa es relativamente abundante en trabajo**.

---

### Pregunta 2: Patrón de Comercio según el Teorema Heckscher-Ohlin

- **Enunciado del Teorema:** Un país exporta el bien que utiliza de forma intensiva su factor de producción relativamente abundante, e importa el bien que utiliza intensivamente su factor escaso.
- **Predicción empírica:**
  - El **País Alfa** (abundante en trabajo) exportará **Alimentos** (bien intensivo en trabajo) e importará **Semiconductores**.
  - El **País Beta** (abundante en capital) exportará **Semiconductores** (bien intensivo en capital) e importará **Alimentos**.
- **Intuición:** En autarquía, la abundancia relativa de trabajo en Alfa hace que los salarios sean relativamente bajos frente a la renta del capital, confiriéndole una ventaja de costos en Alimentos. Lo opuesto ocurre en Beta, donde el capital es barato, abaratando la producción de Semiconductores.

---

### Pregunta 3: El Teorema de Stolper-Samuelson

- Al abrirse al comercio, el precio relativo de los Semiconductores aumenta en Beta ($\Delta (p_S/p_A) > 0$).
- De acuerdo con el **Teorema de Stolper-Samuelson (1941)**:
  - Como los Semiconductores son intensivos en capital, la remuneración real del factor intensivo —la **tasa de rendimiento del capital ($r$)**— aumenta más que proporcionalmente respecto a los precios de ambos bienes ($\Delta r > \Delta p_S > \Delta p_A$). Por tanto, la renta real del capital ($r/p_A$ y $r/p_S$) **aumenta estrictamente**.
  - En contrapartida, el **salario real de los trabajadores ($w/p_A$ y $w/p_S$) cae estrictamente** en términos de ambos bienes.
- *Lección de economía política:* El libre comercio genera ganadores netos (propietarios del factor abundante) y perdedores netos (propietarios del factor escaso), fundamentando la resistencia política al libre comercio.

---

### Pregunta 4: El Teorema de Rybczynski

El sistema de pleno empleo para el País Alfa viene dado por:
$$\begin{cases}
a_{LA} Q_A + a_{LS} Q_S = \bar{L}_\alpha \implies 4 Q_A + 2 Q_S = \bar{L}_\alpha \\
a_{KA} Q_A + a_{KS} Q_S = \bar{K}_\alpha \implies 1 Q_A + 3 Q_S = 150
\end{cases}$$

- **Situación inicial ($\bar{L}_\alpha = 400$):**
  De la segunda ecuación: $Q_A = 150 - 3 Q_S$.  
  Sustituyendo en la primera:
  $$4(150 - 3 Q_S) + 2 Q_S = 400 \implies 600 - 12 Q_S + 2 Q_S = 400 \implies 10 Q_S = 200 \implies Q_S = 20$$
  $$Q_A = 150 - 3(20) = 150 - 60 = 90$$

- **Situación post-inmigración ($\bar{L}_\alpha' = 480$, $\Delta \bar{L}/\bar{L} = +20\%$):**
  $$4(150 - 3 Q_S') + 2 Q_S' = 480 \implies 600 - 10 Q_S' = 480 \implies 10 Q_S' = 120 \implies Q_S' = 12$$
  $$Q_A' = 150 - 3(12) = 150 - 36 = 114$$

- **Evaluación del Teorema de Rybczynski:**
  - Variación porcentual en Alimentos (intensivo en trabajo):
    $$\frac{114 - 90}{90} = \frac{24}{90} = +26,67\% > +20\%$$
    La producción de Alimentos se expande de forma **más que proporcional** al incremento de la dotación de trabajo (efecto de magnificación de Jones).
  - Variación porcentual en Semiconductores (intensivo en capital):
    $$\frac{12 - 20}{20} = -\frac{8}{20} = -40,0\% < 0$$
    La producción de Semiconductores experimenta una **contracción absoluta**.
- Se verifica con exactitud matemática el Teorema de Rybczynski (1955).

---

## 3. Solución Detallada del Ejercicio 2 (Nivel Intermedio)

### Pregunta 1: Derivación de las Curvas de Política de Meade

- **Equilibrio Interno ($IB$):**  
  La condición es $Y = Y^* = 100$.  
  La demanda agregada es:
  $$Y = A + CA = A + [0 + \eta_R (R - 100) - m (A - 100)] = A(1 - m) + \eta_R R - 100 \eta_R + 100 m$$
  Diferenciando totalmente con $dY = 0$:
  $$(1 - m) dA + \eta_R dR = 0 \implies \left. \frac{dR}{dA} \right|_{IB} = -\frac{1 - m}{\eta_R}$$
  Con $m = 0,20$ y $\eta_R = 0,50$:
  $$\left. \frac{dR}{dA} \right|_{IB} = -\frac{1 - 0,20}{0,50} = -\frac{0,80}{0,50} = -1,60$$
  Ecuación explícita de $IB$:  
  $$0,80 A + 0,50 R - 50 + 20 = 100 \implies 0,80 A + 0,50 R = 130 \implies R = 260 - 1,60 A$$

- **Equilibrio Externo ($EB$):**  
  La condición es $CA = CA^* = 0$.  
  $$CA = \eta_R (R - 100) - m (A - 100) = 0$$
  Diferenciando totalmente con $dCA = 0$:
  $$\eta_R dR - m dA = 0 \implies \left. \frac{dR}{dA} \right|_{EB} = \frac{m}{\eta_R}$$
  Con $m = 0,20$ y $\eta_R = 0,50$:
  $$\left. \frac{dR}{dA} \right|_{EB} = \frac{0,20}{0,50} = 0,40$$
  Ecuación explícita de $EB$:  
  $$0,50 R - 50 - 0,20 A + 20 = 0 \implies 0,50 R = 0,20 A + 30 \implies R = 60 + 0,40 A$$

- **Punto óptimo simultáneo $(A^*, R^*)$:**  
  Igualando ambas ecuaciones:
  $$260 - 1,60 A = 60 + 0,40 A \implies 2,00 A = 200 \implies A^* = 100$$
  $$R^* = 60 + 0,40(100) = 100$$
  El óptimo macroeconómico es $(A^* = 100, R^* = 100)$.

---

### Pregunta 2: Diagnóstico del Desequilibrio en Meridia

- **Estado actual ($A = 85, R = 88$):**
  - Nivel de producto:
    $$Y = 0,80(85) + 0,50(88) - 30 = 68 + 44 - 30 = 82 < 100$$
    Existe una **brecha recesiva** de $-18$ unidades de producto (desempleo abierto).
  - Saldo en cuenta corriente:
    $$CA = 0,50(88 - 100) - 0,20(85 - 100) = 0,50(-12) - 0,20(-15) = -6,0 + 3,0 = -3,0 < 0$$
    Existe un **déficit en balanza de pagos** de $-3,0$.
- **Ubicación en las Zonas de Meade:**
  Como el país sufre **Desempleo ($Y < Y^*$)** y simultáneamente **Déficit Externo ($CA < 0$)**, se ubica inequívocamente en la **Zona III de Meade (El Dilema Agudo)**.
- **Consecuencia de una política mono-instrumental:**  
  Si el gobierno utiliza exclusivamente política fiscal expansiva para fijar $Y = 100$ con el tipo de cambio congelado en $R = 88$:
  $$100 = 0,80 A + 0,50(88) - 30 = 0,80 A + 14 \implies 0,80 A = 86 \implies A = 107,5$$
  Calculando el saldo externo con $A = 107,5$ y $R = 88$:
  $$CA = 0,50(88 - 100) - 0,20(107,5 - 100) = -6,0 - 0,20(7,5) = -6,0 - 1,5 = -7,5$$
  El déficit comercial se dispara de $-3,0$ a $-7,5$ (un incremento del $150\%$), lo que provocaría un colapso cambiario o agotamiento de reservas. Esta contradicción intrínseca define el **dilema de política de Meade**.

---

### Pregunta 3: Regla de Asignación de Instrumentos de Tinbergen-Meade

Para restaurar el equilibrio simultáneo $(A^* = 100, R^* = 100)$:
1. **Instrumento 1 (Expenditure-changing):**  
   Política fiscal/monetaria expansiva para aumentar el gasto interno en:
   $$\Delta A = 100 - 85 = +15 \text{ unidades}$$
2. **Instrumento 2 (Expenditure-switching):**  
   Devaluación cambiaria o depreciación del tipo de cambio real para ganar competitividad en:
   $$\Delta R = 100 - 88 = +12 \text{ puntos básicos (depreciación real del } 13,64\%)$$
Ambas políticas deben aplicarse **de manera coordinada e interactiva**: la devaluación evita que el aumento del gasto interno filtre la demanda al exterior vía importaciones, mientras que el aumento del gasto absorbe la capacidad productiva liberada por el encarecimiento de bienes extranjeros.

---

## 4. Solución Detallada del Ejercicio 3 (Nivel Reto)

### Pregunta 1: Régimen Inicial con Arancel Uniforme Multilateral (MFN)

- Precios internacionales: $P_B = 30$, $P_C = 20$.
- Arancel no discriminatorio: $t = 15$.
  - Precio de $B$ en Arcadia: $30 + 15 = 45$.
  - Precio de $C$ en Arcadia: $20 + 15 = 35$.
- **Decisión del consumidor:** Los agentes compran exclusivamente a $C$, que es el proveedor más barato ($P_0 = 35$).
- **Variables de equilibrio:**
  - Cantidad demandada:
    $$Q_0 = 120 - 35 = 85 \text{ toneladas}$$
  - Excedente del consumidor ($CS_0$):
    $$CS_0 = \frac{1}{2} (120 - 35) \times 85 = \frac{1}{2} \times 85 \times 85 = 3.612,5$$
  - Ingresos arancelarios ($T_0$):
    $$T_0 = t \times Q_0 = 15 \times 85 = 1.275$$
  - Bienestar nacional total ($W_0$):
    $$W_0 = CS_0 + T_0 = 3.612,5 + 1.275 = 4.887,5$$

---

### Pregunta 2: Creación de la Unión Aduanera Preferencial con el País B

- Aranceles: $t_B = 0$, $t_C = 15$.
  - Precio de $B$ en Arcadia: $30 + 0 = 30$.
  - Precio de $C$ en Arcadia: $20 + 15 = 35$.
- **Decisión del consumidor:** El trigo de $B$ resulta ahora más barato que el de $C$ ($30 < 35$). Todo el mercado es capturado por $B$ a $P_1 = 30$.
- **Variables de equilibrio:**
  - Cantidad demandada:
    $$Q_1 = 120 - 30 = 90 \text{ toneladas}$$
  - Excedente del consumidor ($CS_1$):
    $$CS_1 = \frac{1}{2} (120 - 30) \times 90 = \frac{1}{2} \times 90 \times 90 = 4.050$$
  - Ingresos arancelarios ($T_1$):
    Como todas las importaciones entran libres de gravamen desde $B$:
    $$T_1 = 0 \times 90 = 0$$
  - Bienestar nacional total ($W_1$):
    $$W_1 = CS_1 + T_1 = 4.050 + 0 = 4.050$$

---

### Pregunta 3: Evaluación según la Teoría del Segundo Mejor

- **Variación neta del bienestar nacional ($\Delta W$):**
  $$\Delta W = W_1 - W_0 = 4.050 - 4.887,5 = -837,5$$
  ¡El bienestar agregado de Arcadia se redujo en $837,5$ dólares!

- **Descomposición de Meade:**
  1. **Efecto Creación de Comercio:**  
     Ganancia de excedente en las $5$ unidades adicionales consumidas ($90 - 85$) debido al menor precio doméstico ($35 \to 30$):
     $$\text{Creación} = \frac{1}{2} (35 - 30) \times (90 - 85) = \frac{1}{2} \times 5 \times 5 = +12,5$$
  2. **Efecto Desviación de Comercio:**  
     Sobrecosto real de abastecerse con un socio regional ineficiente ($P_B = 30$) en vez del proveedor global óptimo ($P_C = 20$) sobre las $85$ unidades iniciales:
     $$\text{Desviación} = (P_B - P_C) \times Q_0 = (30 - 20) \times 85 = 10 \times 85 = -850$$
  3. **Balance Neto:**
     $$\Delta W = \text{Creación} - \text{Desviación} = +12,5 - 850 = -837,5$$

- **Interpretación metodológica del Segundo Mejor:**
  - En un mundo de **Primer Mejor** (*First Best*), la abolición universal de todos los aranceles ($P = 20$, $Q = 100$, $CS = 5.000$) maximiza el bienestar global.
  - Sin embargo, cuando subsiste una distorsión no eliminable frente a terceros países ($t_C = 15$), eliminar aranceles con un socio bilateral selectivo introduce una nueva distorsión asignativa artificial: subsidia a un productor ineficiente regional frente a un productor eficiente global.
  - Como el efecto de desviación de comercio supera con creces la creación, el libre comercio preferencial resulta inferior al statu quo con arancel uniforme.

---

## 5. Rúbrica de Evaluación Sugerida

| Criterio | Excelente (90–100%) | Satisfactorio (70–89%) | Insuficiente (<70%) |
| :--- | :--- | :--- | :--- |
| **Ejercicio 1: Heckscher-Ohlin y Rybczynski** | Deriva con precisión matemática las intensidades factoriales, fundamenta el patrón H-O, aplica rigurosamente Stolper-Samuelson y demuestra el efecto de magnificación en Rybczynski. | Resuelve correctamente el sistema de ecuaciones pero presenta explicaciones teóricas vagas sobre Stolper-Samuelson o Rybczynski. | Errores en la clasificación de factores o cálculo algebraico incorrecto de las dotaciones. |
| **Ejercicio 2: Diagrama de Meade y Políticas** | Obtiene las pendientes exactas de $IB$ y $EB$, diagnostica con claridad la Zona III y formula el paquete de dos instrumentos coordinados. | Halla las ecuaciones pero falla en explicar el dilema de utilizar solo política fiscal o no calcula el déficit derivado. | No comprende las pendientes de las curvas de Meade ni la regla de Tinbergen. |
| **Ejercicio 3: Segundo Mejor y Uniones Aduaneras** | Calcula con precisión excedentes, aranceles y descompone formalmente en creación (+12,5) y desviación (-850), extrayendo la conclusión epistemológica de Meade. | Encuentra la pérdida de bienestar pero no explicita la descomposición geométrica o aritmética entre creación y desviación. | Confunde la ganancia del consumidor con una ganancia de bienestar nacional, omitiendo la pérdida arancelaria. |

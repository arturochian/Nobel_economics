# Guía Docente y Solucionario: Wassily Leontief (Nobel 1973)

> **Material de uso pedagógico exclusivo para el profesorado.**  
> Este documento contiene el marco conceptual docente, el solucionario analítico y numérico paso a paso, comentarios metodológicos y rúbricas de evaluación para los ejercicios propuestos en `laureados/1973_leontief/estudiante/ejercicios.qmd`.

---

## 1. Pautas Pedagógicas y Contexto Teórico

### El Legado Intelectual de Wassily Leontief
Al abordar la obra de Leontief en cursos de grado o posgrado en economía, es fundamental transmitir tres pilares conceptuales:

1. **La Operacionalización del Equilibrio General:**  
   Antes de Leontief, el equilibrio general de Léon Walras era una estructura axiomática no computable. Leontief demostró que, admitiendo el supuesto simplificador de coeficientes fijos a corto plazo ($x_j = \min \{ z_{ij}/a_{ij} \}$), el sistema de interdependencia económica podía resolverse algebraicamente mediante matrices reales y procesarse computacionalmente.
2. **La Dualidad Directo vs. Indirecto ($L = (I - A)^{-1}$):**  
   El concepto central del análisis insumo-producto es que una política o shock que afecta a una industria nunca se agota en dicha industria. Para producir un automóvil adicional no solo se necesita mano de obra en la planta automotriz, sino acero, caucho, electricidad, transporte y seguros; y para producir ese acero se requiere carbón, maquinaria y más electricidad. La matriz inversa de Leontief internaliza automáticamente todas las rondas infinitas de la cadena de suministro.
3. **El Rigor Empírico y la Paradoja de Leontief (1953):**  
   Leontief personificó la honestidad científica al publicar un resultado que contradecía frontalmente el teorema Heckscher-Ohlin predominante en su época. La "paradoja" demostró que el contenido factorial del comercio no puede medirse observando únicamente las industrias exportadoras finales, sino que debe calcularse a lo largo de toda la red interindustrial.

### Errores Comunes de los Estudiantes
- **Confundir la matriz de flujos $Z$ con la matriz técnica $A$:** Muchos estudiantes intentan invertir directamente $(I - Z)$ en lugar de normalizar primero por las columnas de producción bruta ($a_{ij} = z_{ij} / x_j$).
- **Inversión de subíndices:** Olvidar que las filas representan a los sectores vendedores/proveedores y las columnas a los sectores compradores/usuarios.
- **Normalización de los encadenamientos de Rasmussen:** Dividir incorrectamente por $n$ o no centrar los índices de arrastre y dispersión en torno a 1.0.
- **Omitir la Inversa de Leontief en los cálculos factoriales:** Calcular la intensidad de capital y trabajo únicamente con los coeficientes directos, pasando por alto que el aporte revolucionario de Leontief consistió precisamente en formular $k_{\text{total}}' = k' (I - A)^{-1}$.

---

## 2. Solución Detallada del Ejercicio 1 (Nivel Básico)

### Pregunta 1: Producción Bruta y Valor Agregado
- **Producción Bruta ($x_i = \sum_j z_{ij} + y_i$):**
  $$x_I = z_{II} + z_{IA} + y_I = 40 + 60 + 100 = 200 \text{ millones de USD}$$
  $$x_A = z_{AI} + z_{AA} + y_A = 20 + 30 + 50 = 100 \text{ millones de USD}$$
  Vector de producción bruta:
  $$x = \begin{pmatrix} 200 \\ 100 \end{pmatrix}$$
- **Valor Agregado ($v_j = x_j - \sum_i z_{ij}$):**
  $$v_I = x_I - (z_{II} + z_{AI}) = 200 - (40 + 20) = 200 - 60 = 140 \text{ millones de USD}$$
  $$v_A = x_A - (z_{IA} + z_{AA}) = 100 - (60 + 30) = 100 - 90 = 10 \text{ millones de USD}$$
  Vector de valor agregado:
  $$v = \begin{pmatrix} 140 \\ 10 \end{pmatrix}$$
- **Identidad Macroeconómica del PIB:**
  $$\text{PIB}_{\text{Demanda}} = \sum y_i = 100 + 50 = 150 \text{ millones de USD}$$
  $$\text{PIB}_{\text{Ingreso}} = \sum v_j = 140 + 10 = 150 \text{ millones de USD}$$
  Ambos enfoques coinciden estrictamente.

### Pregunta 2: Matriz de Coeficientes Técnicos ($A$)
- **Cálculo de coeficientes $a_{ij} = z_{ij} / x_j$:**
  $$a_{II} = \frac{z_{II}}{x_I} = \frac{40}{200} = 0.20$$
  $$a_{IA} = \frac{z_{IA}}{x_A} = \frac{60}{100} = 0.60$$
  $$a_{AI} = \frac{z_{AI}}{x_I} = \frac{20}{200} = 0.10$$
  $$a_{AA} = \frac{z_{AA}}{x_A} = \frac{30}{100} = 0.30$$
  Matriz técnica:
  $$A = \begin{pmatrix} 0.20 & 0.60 \\ 0.10 & 0.30 \end{pmatrix}$$
- **Interpretación de $a_{IA} = 0.60$:**  
  Para que la Agricultura genere $1.00$ dólar de producción bruta, debe consumir directamente $0.60$ dólares en insumos provistos por el sector Industria (maquinaria, fertilizantes químicos, combustible, etc.).

### Pregunta 3: Cálculo de la Matriz Inversa de Leontief ($L = (I - A)^{-1}$)
- **Matriz $(I - A)$:**
  $$I - A = \begin{pmatrix} 1 & 0 \\ 0 & 1 \end{pmatrix} - \begin{pmatrix} 0.20 & 0.60 \\ 0.10 & 0.30 \end{pmatrix} = \begin{pmatrix} 0.80 & -0.60 \\ -0.10 & 0.70 \end{pmatrix}$$
- **Determinante:**
  $$\det(I - A) = (0.80)(0.70) - (-0.60)(-0.10) = 0.56 - 0.06 = 0.50$$
  Dado que $\det(I - A) = 0.50 > 0$ y los elementos diagonales de $(I - A)$ son positivos ($0.80 > 0, 0.70 > 0$), se satisfacen plenamente las condiciones de viabilidad de Hawkins-Simon.
- **Inversión Matricial:**
  $$L = (I - A)^{-1} = \frac{1}{0.50} \begin{pmatrix} 0.70 & 0.60 \\ 0.10 & 0.80 \end{pmatrix} = \begin{pmatrix} 1.40 & 1.20 \\ 0.20 & 1.60 \end{pmatrix}$$

### Pregunta 4: Simulación de un Shock de Demanda Final
- **Cálculo del impacto con $\Delta y = (20, 0)'$:**
  $$\Delta x = L \Delta y = \begin{pmatrix} 1.40 & 1.20 \\ 0.20 & 1.60 \end{pmatrix} \begin{pmatrix} 20 \\ 0 \end{pmatrix} = \begin{pmatrix} 1.40 \times 20 \\ 0.20 \times 20 \end{pmatrix} = \begin{pmatrix} 28 \\ 4 \end{pmatrix}$$
- **Descomposición del incremento en la Industria ($\Delta x_I = 28$):**
  - **Impacto directo:** $\Delta y_I = 20$ millones de dólares ($71.4\%$ del total).
  - **Impacto indirecto:** $\Delta x_I - \Delta y_I = 28 - 20 = 8$ millones de dólares ($28.6\%$ del total).
- **Impacto en la Agricultura ($\Delta x_A = 4$):**  
  Aunque la demanda final agrícola no experimentó cambio alguno ($\Delta y_A = 0$), su producción bruta debe expandirse en $4$ millones de dólares para abastecer las materias primas indirectas requeridas por la expansión industrial.

---

## 3. Solución Detallada del Ejercicio 2 (Nivel Intermedio)

### Pregunta 1: Multiplicadores de Producción hacia Atrás
Dada la matriz inversa:
$$L = \begin{pmatrix} 1.348 & 0.285 & 0.165 \\ 0.191 & 1.385 & 0.098 \\ 0.246 & 0.202 & 1.150 \end{pmatrix}$$

- **Multiplicadores por columna ($M_j = \sum_{i=1}^3 L_{ij}$):**
  - **Manufactura ($M$):** $M_M = 1.348 + 0.191 + 0.246 = 1.785$
  - **Servicios ($S$):** $M_S = 0.285 + 1.385 + 0.202 = 1.872$
  - **Energía ($E$):** $M_E = 0.165 + 0.098 + 1.150 = 1.413$
- **Por qué $L_{jj} > 1.0$:**  
  Para entregar 1 unidad neta de producto a la demanda final, el propio sector debe producir esa unidad inicial más la cantidad adicional de su propio bien consumida a lo largo de las rondas intermedias de producción (autoconsumo intermedio directo e indirecto inducido por la demanda de sus proveedores).

### Pregunta 2: Encadenamientos de Rasmussen y Tipología
- **Promedio del sistema:**
  $$\bar{M} = \frac{1.785 + 1.872 + 1.413}{3} = \frac{5.070}{3} = 1.690$$
- **Backward Linkages ($BL_j = M_j / \bar{M}$):**
  - $BL_M = 1.785 / 1.690 \approx 1.056 > 1$
  - $BL_S = 1.872 / 1.690 \approx 1.108 > 1$
  - $BL_E = 1.413 / 1.690 \approx 0.836 < 1$
- **Forward Linkages ($FL_i = \text{Suma Fila}_i / \bar{M}$):**
  - Fila Manufactura: $1.348 + 0.285 + 0.165 = 1.798 \implies FL_M = 1.798 / 1.690 \approx 1.064 > 1$
  - Fila Servicios: $0.191 + 1.385 + 0.098 = 1.674 \implies FL_S = 1.674 / 1.690 \approx 0.991 \le 1$
  - Fila Energía: $0.246 + 0.202 + 1.150 = 1.598 \implies FL_E = 1.598 / 1.690 \approx 0.946 < 1$

| Sector | Backward ($BL$) | Forward ($FL$) | Tipología de Rasmussen |
|:---|:---:|:---:|:---|
| **Manufactura** | $1.056 > 1$ | $1.064 > 1$ | **Sector Clave** (Alto arrastre y alto empuje) |
| **Servicios** | $1.108 > 1$ | $0.991 \le 1$ | **Sector Impulsor** (Arrastre superior al promedio hacia atrás) |
| **Energía** | $0.836 < 1$ | $0.946 < 1$ | **Sector Independiente** (Débil interconexión relativa en este modelo) |

### Pregunta 3: Aproximación por Serie de Neumann
Con $\Delta y = (1, 0, 0)'$:
- **Ronda 0 (Directo):**
  $$\Delta x^{(0)} = \Delta y = \begin{pmatrix} 1.000 \\ 0.000 \\ 0.000 \end{pmatrix}$$
- **Ronda 1:**
  $$\Delta x^{(1)} = A \Delta y = \begin{pmatrix} 0.20 & 0.15 & 0.10 \\ 0.10 & 0.25 & 0.05 \\ 0.15 & 0.10 & 0.10 \end{pmatrix} \begin{pmatrix} 1 \\ 0 \\ 0 \end{pmatrix} = \begin{pmatrix} 0.200 \\ 0.100 \\ 0.150 \end{pmatrix}$$
- **Ronda 2:**
  $$\Delta x^{(2)} = A \Delta x^{(1)} = \begin{pmatrix} 0.20(0.20) + 0.15(0.10) + 0.10(0.15) \\ 0.10(0.20) + 0.25(0.10) + 0.05(0.15) \\ 0.15(0.20) + 0.10(0.10) + 0.10(0.15) \end{pmatrix} = \begin{pmatrix} 0.040 + 0.015 + 0.015 \\ 0.020 + 0.025 + 0.0075 \\ 0.030 + 0.010 + 0.015 \end{pmatrix} = \begin{pmatrix} 0.0700 \\ 0.0525 \\ 0.0550 \end{pmatrix}$$
- **Impacto Acumulado en Rondas 0 + 1 + 2:**
  $$\Delta x_{\text{acum}} = \begin{pmatrix} 1.000 + 0.200 + 0.0700 \\ 0.000 + 0.100 + 0.0525 \\ 0.000 + 0.150 + 0.0550 \end{pmatrix} = \begin{pmatrix} 1.2700 \\ 0.1525 \\ 0.2050 \end{pmatrix}$$
- **Comparación con el vector exacto de la Inversa de Leontief $L_{\cdot 1} = (1.348, 0.191, 0.246)'$:**
  - Manufactura: $1.2700 / 1.348 \approx 94.2\%$ del impacto total alcanzado en solo 2 rondas.
  - Servicios: $0.1525 / 0.191 \approx 79.8\%$ del impacto alcanzado.
  - Energía: $0.2050 / 0.246 \approx 83.3\%$ del impacto alcanzado.
  Esto ilustra cómo las rondas de insumos convergen rápidamente hacia el equilibrio final de Leontief.

---

## 4. Solución Detallada del Ejercicio 3 (Nivel Reto)

### Pregunta 1: Requerimientos Factoriales Directos
- **Coeficientes directos:** $k = (0.50, 1.00)'$, $l = (0.05, 0.04)'$.
- **Canasta de Exportaciones ($y^{\text{exp}} = (80, 20)'$):**
  $$K_{\text{dir}}^{\text{exp}} = (0.50)(80) + (1.00)(20) = 40 + 20 = 60 \text{ USD}$$
  $$L_{\text{dir}}^{\text{exp}} = (0.05)(80) + (0.04)(20) = 4.0 + 0.8 = 4.8 \text{ personas-año}$$
  $$(K/L)_{\text{dir}}^{\text{exp}} = \frac{60}{4.8} = 12.50 \text{ USD por persona-año}$$
- **Canasta de Importaciones Competitivas ($y^{\text{imp}} = (30, 70)'$):**
  $$K_{\text{dir}}^{\text{imp}} = (0.50)(30) + (1.00)(70) = 15 + 70 = 85 \text{ USD}$$
  $$L_{\text{dir}}^{\text{imp}} = (0.05)(30) + (0.04)(70) = 1.5 + 2.8 = 4.3 \text{ personas-año}$$
  $$(K/L)_{\text{dir}}^{\text{imp}} = \frac{85}{4.3} \approx 19.767 \text{ USD por persona-año}$$
- **Ratio de Intensidad Directa:**
  $$\Theta_{\text{dir}} = \frac{(K/L)_{\text{dir}}^{\text{exp}}}{(K/L)_{\text{dir}}^{\text{imp}}} = \frac{12.50}{19.767} \approx 0.632$$

### Pregunta 2: Requerimientos Factoriales Totales (Leontief 1953)
- **Vectores de requerimientos totales ($k_{\text{tot}}' = k' L$, $l_{\text{tot}}' = l' L$):**
  $$L = \begin{pmatrix} 1.4815 & 0.3704 \\ 0.1852 & 1.2963 \end{pmatrix}$$
  - **Capital total por sector:**
    $$k_{\text{tot}, M} = 0.50(1.4815) + 1.00(0.1852) = 0.74075 + 0.1852 = 0.92595$$
    $$k_{\text{tot}, R} = 0.50(0.3704) + 1.00(1.2963) = 0.1852 + 1.2963 = 1.4815$$
    $$k_{\text{tot}}' = (0.9260, \; 1.4815)$$
  - **Trabajo total por sector:**
    $$l_{\text{tot}, M} = 0.05(1.4815) + 0.04(0.1852) = 0.074075 + 0.007408 = 0.081483$$
    $$l_{\text{tot}, R} = 0.05(0.3704) + 0.04(1.2963) = 0.01852 + 0.051852 = 0.070372$$
    $$l_{\text{tot}}' = (0.0815, \; 0.0704)$$
- **Factores totales incorporados:**
  - **Exportaciones:**
    $$K_{\text{tot}}^{\text{exp}} = (0.92595)(80) + (1.4815)(20) = 74.076 + 29.630 = 103.706 \text{ USD}$$
    $$L_{\text{tot}}^{\text{exp}} = (0.081483)(80) + (0.070372)(20) = 6.5186 + 1.4074 = 7.926 \text{ personas-año}$$
    $$(K/L)_{\text{tot}}^{\text{exp}} = \frac{103.706}{7.926} \approx 13.084 \text{ USD por persona-año}$$
  - **Importaciones:**
    $$K_{\text{tot}}^{\text{imp}} = (0.92595)(30) + (1.4815)(70) = 27.7785 + 103.705 = 131.4835 \text{ USD}$$
    $$L_{\text{tot}}^{\text{imp}} = (0.081483)(30) + (0.070372)(70) = 2.4445 + 4.9260 = 7.3705 \text{ personas-año}$$
    $$(K/L)_{\text{tot}}^{\text{imp}} = \frac{131.4835}{7.3705} \approx 17.839 \text{ USD por persona-año}$$
- **Ratio de Intensidad Total de Leontief:**
  $$\Theta_{\text{tot}} = \frac{(K/L)_{\text{tot}}^{\text{exp}}}{(K/L)_{\text{tot}}^{\text{imp}}} = \frac{13.084}{17.839} \approx 0.733 < 1.0$$

### Pregunta 3: Análisis Conceptual y Debate Económico
1. **Diferencia entre Directo y Total:**  
   Al calcular los factores totales, el ratio $(K/L)$ de las exportaciones se incrementa (de $12.50$ a $13.08$) debido a que el sector manufacturero arrastra como insumos intermedios recursos básicos intensivos en capital. Recíprocamente, el ratio de los sustitutos de importación se reduce (de $19.77$ a $17.84$) porque la extracción de recursos requiere maquinaria industrial que incorpora mano de obra. La inversa de Leontief captura con precisión estas interdependencias indirectas.
2. **Confirmación de la Paradoja de Leontief:**  
   Dado que $\Theta_{\text{tot}} = 0.733 < 1.0$, una economía que se presume abundante en capital está exportando una canasta que contiene menos capital por trabajador que los bienes importados, desafiando la formulación canónica del teorema de Heckscher-Ohlin (que exigía $\Theta > 1.0$). En el estudio histórico de Leontief (1953) sobre EE.UU. en 1947, el ratio obtenido fue de $0.77$.
3. **El Papel del Capital Humano:**  
   Si los trabajadores del sector manufacturero cuentan con mayor educación y destreza técnica (por ejemplo, con una productividad efectiva que duplica a la estándar), la dotación de "unidades de eficiencia" de trabajo en exportaciones se duplicaría, o bien el valor monetario del capital invertido en formación y destrezas (capital humano) debería sumarse al capital físico. Al contabilizar el capital humano, la intensidad de capital total de las exportaciones supera a la de las importaciones, resolviendo el enigma empírico.

---

## 5. Rúbrica de Evaluación Sugerida

| Criterio | Excelente (90–100%) | Aceptable (70–89%) | Insuficiente (< 70%) |
|:---|:---|:---|:---|
| **Álgebra Matricial Insumo-Producto** | Deriva $A$, calcula $\det(I - A)$ e invierte la matriz sin errores aritméticos, interpretando los coeficientes económicos. | Inversión correcta con errores menores de redondeo o confusión leve en subíndices. | No sabe formular la matriz $(I - A)$ o comete fallos conceptuales graves en la inversión. |
| **Multiplicadores y Rasmussen** | Calcula con precisión $M_j$, normaliza $BL$ y $FL$ en torno a 1.0 y clasifica adecuadamente los sectores. | Multiplicadores correctos pero omite la normalización del promedio o clasifica erróneamente los cuadrantes. | Confunde sumas de filas con columnas o no comprende la interpretación económica. |
| **Serie de Neumann** | Calcula adecuadamente las rondas 0, 1 y 2, sumando los efectos y cuantificando el porcentaje de convergencia. | Realiza las primeras rondas pero no compara contra el límite de la matriz inversa. | No aplica la multiplicación sucesiva de matrices técnicas. |
| **Paradoja de Leontief** | Formula con rigor $k' (I - A)^{-1}$ y $l' (I - A)^{-1}$, evalúa ambas canastas, calcula $\Theta < 1$ y articula la discusión sobre capital humano. | Realiza los cálculos numéricos pero flaquea en la explicación teórica frente a Heckscher-Ohlin. | Omite el cálculo total con la inversa de Leontief o calcula de forma errónea los ratios factoriales. |

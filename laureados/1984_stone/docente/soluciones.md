# Guía Docente y Solucionario: Sir Richard Stone (Nobel 1984)

> **Material de uso exclusivo para el cuerpo docente.**  
> Este documento contiene las pautas pedagógicas, los fundamentos analíticos y el solucionario detallado paso a paso de la guía de ejercicios de `laureados/1984_stone/estudiante/ejercicios.qmd`.

---

## 1. Pautas Pedagógicas y Contexto Teórico

### El papel de Sir Richard Stone en la Ciencia Económica
Richard Stone es considerado el creador de la infraestructura estadística sobre la que descansa toda la macroeconomía empírica y la política económica contemporánea. Antes de Stone, la teoría económica macroscópica carecía de una correspondencia unívoca con datos empíricos observables.

Al impartir este módulo docente, es crucial destacar a los alumnos:
1. **La Partida Doble como Principio de Coherencia Macroeconómica:** La contabilidad nacional no es una mera suma de números agregados, sino una red cerrada de circuitos financieros donde ningún recurso se crea de la nada ni desaparece. Cada ingreso es el gasto de otro agente. Esta disciplina contable es lo que permite verificar empíricamente modelos teóricos sin incurrir en dobles contabilizaciones.
2. **De la Tabla Insumo-Producto a la SAM:** Mientras que Leontief se concentró en las relaciones tecnológicas interindustriales ($X = AX + Y$), Stone comprendió que la producción remunera a los factores y los factores alimentan a los hogares, cerrando el flujo circular. La SAM es la base indispensable sobre la que se construyen todos los modelos modernos de Equilibrio General Computable (CGE).
3. **El Sistema Lineal de Gasto (LES):** Es el primer puente empírico exitoso entre la teoría axiomática del consumidor (Pareto, Slutsky, Hicks) y los datos reales de gasto de las familias. La noción de "consumo de subsistencia" ($\gamma_i$) frente a "ingreso supernumerario" es conceptualmente muy intuitiva para los estudiantes y conecta directamente con la definición moderna de líneas de pobreza monetaria.

---

## 2. Solución Detallada del Ejercicio 1 (Nivel Básico)

### Pregunta 1: Gasto de Subsistencia e Ingreso Supernumerario
- Datos: $\gamma_1 = 20, \gamma_2 = 15, \gamma_3 = 5$; precios $p_1 = 2, p_2 = 4, p_3 = 1$; ingreso $y = 200$.
- Gasto de subsistencia por bien:
  - Bien 1 (Alimentos): $p_1 \gamma_1 = 2 \times 20 = 40$ €
  - Bien 2 (Vivienda): $p_2 \gamma_2 = 4 \times 15 = 60$ €
  - Bien 3 (Esparcimiento): $p_3 \gamma_3 = 1 \times 5 = 5$ €
- Gasto mínimo de subsistencia total:
  $$S = \sum_{j=1}^3 p_j \gamma_j = 40 + 60 + 5 = 105 \text{ €}$$
- Ingreso supernumerario (discrecional):
  $$y^* = y - S = 200 - 105 = 95 \text{ €}$$

### Pregunta 2: Demandas Óptimas y Distribución del Presupuesto
Fórmula de gasto del LES: $p_i q_i = p_i \gamma_i + \beta_i y^*$.
- **Bien 1 (Alimentos):**
  - Gasto: $p_1 q_1 = 40 + 0.20 \times 95 = 40 + 19 = 59 \text{ €}$
  - Cantidad física: $q_1^* = \frac{59}{2} = 29.5 \text{ unidades}$
- **Bien 2 (Vivienda):**
  - Gasto: $p_2 q_2 = 60 + 0.30 \times 95 = 60 + 28.5 = 88.5 \text{ €}$
  - Cantidad física: $q_2^* = \frac{88.5}{4} = 22.125 \text{ unidades}$
- **Bien 3 (Esparcimiento):**
  - Gasto: $p_3 q_3 = 5 + 0.50 \times 95 = 5 + 47.5 = 52.5 \text{ €}$
  - Cantidad física: $q_3^* = \frac{52.5}{1} = 52.5 \text{ unidades}$

*Comprobación de la restricción presupuestaria:*
$$\sum_{i=1}^3 p_i q_i^* = 59 + 88.5 + 52.5 = 200 \text{ €} \equiv y$$

*Participaciones presupuestarias ($w_i = \frac{p_i q_i}{y}$):*
- $w_1 = \frac{59}{200} = 0.295 \quad (29.5\%)$
- $w_2 = \frac{88.5}{200} = 0.4425 \quad (44.25\%)$
- $w_3 = \frac{52.5}{200} = 0.2625 \quad (26.25\%)$

### Pregunta 3: Cálculo de Elasticidades
- **Elasticidad Ingreso ($\eta_i = \frac{\beta_i}{w_i}$):**
  - Alimentos: $\eta_1 = \frac{0.20}{0.295} \approx 0.678 < 1$ (Bien necesario). Coincide plenamente con la Ley de Engel: a mayor ingreso, menor proporción del gasto se destina a alimentación.
  - Vivienda: $\eta_2 = \frac{0.30}{0.4425} \approx 0.678 < 1$ (Bien necesario).
  - Esparcimiento: $\eta_3 = \frac{0.50}{0.2625} \approx 1.905 > 1$ (Bien de lujo o superior).
- **Elasticidad Precio Propia no compensada ($\epsilon_{11}$):**
  $$\epsilon_{11} = -1 + (1 - \beta_1) \frac{\gamma_1}{q_1^*} = -1 + (1 - 0.20) \frac{20}{29.5} = -1 + 0.80 \times 0.67797 = -1 + 0.5424 = -0.4576$$
  La demanda de alimentos es marcadamente inelástica ante el precio propio ($\approx -0.46$).

### Pregunta 4: Caso Límite sin Subsistencia ($\gamma_i = 0$)
Si $\gamma_i = 0$ para todo $i$:
$$U = \sum_{i=1}^n \beta_i \ln(q_i) = \ln \left( \prod_{i=1}^n q_i^{\beta_i} \right)$$
Dado que la función logarítmica es monótona creciente, este ordenamiento de preferencias es idéntico al de una **función de utilidad Cobb-Douglas** estandarizada $\prod q_i^{\beta_i}$.
Las demandas se reducen a:
$$q_i^* = \frac{\beta_i y}{p_i} \implies p_i q_i = \beta_i y$$
En este caso, las participaciones de gasto son estrictamente constantes e iguales a los parámetros estructurales ($w_i = \beta_i$) y todas las elasticidades ingreso son iguales a la unidad ($\eta_i = 1$). Por lo tanto, el LES de Stone generaliza a la Cobb-Douglas incorporando niveles mínimos de subsistencia física.

---

## 3. Solución Detallada del Ejercicio 2 (Nivel Intermedio)

### Pregunta 1: Verificación de Partida Doble
Calculamos la suma de cada fila (ingresos) y cada columna (gastos):
- **Actividades ($A$):**
  - Fila (Ingresos): $40 + 0 + 120 + 40 = 200$
  - Columna (Gastos): $40 + 140 + 0 + 20 = 200$ $\implies$ $y_A = E_A = 200$.
- **Factores ($F$):**
  - Fila (Ingresos): $140 + 0 + 0 + 0 = 140$
  - Columna (Gastos): $0 + 0 + 140 + 0 = 140$ $\implies$ $y_F = E_F = 140$.
- **Hogares ($H$):**
  - Fila (Ingresos): $0 + 140 + 0 + 10 = 150$
  - Columna (Gastos): $120 + 0 + 0 + 30 = 150$ $\implies$ $y_H = E_H = 150$.
- **Exógeno ($G$):**
  - Fila (Ingresos): $20 + 0 + 30 + 0 = 50$
  - Columna (Gastos): $40 + 0 + 10 + 0 = 50$ $\implies$ $y_G = E_G = 50$.

La matriz está estrictamente balanceada en partida doble: cada sector gasta exactamente lo que ingresa.

### Pregunta 2: Matriz de Coeficientes Medios Endógenos ($A_n$)
Las cuentas endógenas son $A, F, H$, con ingresos $y_{endo} = [200, 140, 150]'$.
Dividiendo cada columna del bloque $3 \times 3$ por su respectivo ingreso:

$$A_n = \begin{pmatrix} 
\frac{40}{200} & \frac{0}{140} & \frac{120}{150} \\ 
\frac{140}{200} & \frac{0}{140} & \frac{0}{150} \\ 
\frac{0}{200} & \frac{140}{140} & \frac{0}{150} 
\end{pmatrix} = \begin{pmatrix} 
0.20 & 0 & 0.80 \\ 
0.70 & 0 & 0 \\ 
0 & 1.0 & 0 
\end{pmatrix}$$

### Pregunta 3: Matriz de Multiplicadores de Stone ($M = (I - A_n)^{-1}$)
Calculamos $I - A_n$:

$$I - A_n = \begin{pmatrix} 
0.80 & 0 & -0.80 \\ 
-0.70 & 1.0 & 0 \\ 
0 & -1.0 & 1.0 
\end{pmatrix}$$

Determinante:
$$\det(I - A_n) = 0.80(1 - 0) - 0.80(0.70) = 0.80 - 0.56 = 0.24$$

Matriz adjunta de cofactores transpuesta:
$$\text{Adj}(I - A_n) = \begin{pmatrix} 
1.0 & 0.80 & 0.80 \\ 
0.70 & 0.80 & 0.56 \\ 
0.70 & 0.80 & 0.80 
\end{pmatrix}$$

Dividiendo entre $\det = 0.24$:

$$M = \begin{pmatrix} 
\frac{1.0}{0.24} & \frac{0.80}{0.24} & \frac{0.80}{0.24} \\ 
\frac{0.70}{0.24} & \frac{0.80}{0.24} & \frac{0.56}{0.24} \\ 
\frac{0.70}{0.24} & \frac{0.80}{0.24} & \frac{0.80}{0.24} 
\end{pmatrix} = \begin{pmatrix} 
4.1667 & 3.3333 & 3.3333 \\ 
2.9167 & 3.3333 & 2.3333 \\ 
2.9167 & 3.3333 & 3.3333 
\end{pmatrix}$$

*Interpretación de $M_{AH} = 3.3333$:*  
Si los hogares reciben una transferencia exógena de $1$ euro, la producción bruta total de la economía se expande en $3.33$ euros debido al ciclo de retroalimentación (consumo de los hogares $\rightarrow$ demanda intermedia y final de empresas $\rightarrow$ remuneración a factores $\rightarrow$ nuevo consumo).

### Pregunta 4: Simulación del Shock Fiscal
Shock exógeno en Actividades: $x = [30, 0, 0]'$.
El impacto en las cuentas endógenas es:

$$\Delta y = M \cdot x = 30 \times \begin{pmatrix} 4.1667 \\ 2.9167 \\ 2.9167 \end{pmatrix} = \begin{pmatrix} 125.0 \\ 87.5 \\ 87.5 \end{pmatrix}$$

- La producción de **Actividades** aumenta en **$125.0$ millones de euros** (multiplicador de $4.17$).
- Las rentas de **Factores** (salarios y beneficios) aumentan en **$87.5$ millones de euros** (multiplicador de $2.92$).
- El ingreso disponible de los **Hogares** aumenta en **$87.5$ millones de euros** (multiplicador de $2.92$).

---

## 4. Solución Detallada del Ejercicio 3 (Nivel Reto)

### Pregunta 1: Gasto de Subsistencia y Viabilidad Financiera
- Estado inicial ($p_1^0 = 1.0, p_2^0 = 1.0, y^0 = 100$):
  - $S^0 = 1(50) + 1(10) = 60$
  - Ingreso supernumerario inicial: $y^{*0} = 100 - 60 = 40$
  - Demandas iniciales:
    - $q_1^0 = 50 + \frac{0.40}{1}(40) = 50 + 16 = 66$ unidades
    - $q_2^0 = 10 + \frac{0.60}{1}(40) = 10 + 24 = 34$ unidades
- Tras el shock de precios ($p_1^1 = 2.0, p_2^1 = 1.0$):
  - Nuevo gasto de subsistencia: $S^1 = 2(50) + 1(10) = 100 + 10 = 110$
  - Si el ingreso es $y = 100$:
    $$y - S^1 = 100 - 110 = -10 < 0$$
  *Conclusión:* El hogar es incapaz de comprar su canasta básica indispensable. El hogar cae en una condición de déficit nutricional o pobreza extrema severa, donde el ingreso no alcanza a cubrir la subsistencia biológica básica.

### Pregunta 2: Transferencia Monetaria Compensatoria
Para que el ingreso supernumerario vuelva a ser de $y^{*1} = 40$:
$$y^1 - S^1 = 40 \implies y^1 - 110 = 40 \implies y^1 = 150$$
La transferencia requerida es:
$$\Delta y_{comp} = y^1 - y^0 = 150 - 100 = 50 \text{ unidades monetarias}$$
Nótese que coincide algebraicamente con el incremento del costo de la subsistencia del bien 1:
$$\Delta S = (p_1^1 - p_1^0) \gamma_1 = (2 - 1) \times 50 = 50$$

### Pregunta 3: Efecto en el Consumo de Alimentos
Con la transferencia compensatoria ($y = 150, y^* = 40$):
$$q_1^1 = \gamma_1 + \frac{\beta_1}{p_1^1} y^* = 50 + \frac{0.40}{2.0} (40) = 50 + 8 = 58 \text{ unidades}$$
- A pesar de que el ingreso supernumerario se mantuvo inalterado, el consumo de alimentos se reduce de $66$ a $58$ unidades debido a la sustitución hacia otros bienes originada por el encarecimiento relativo ($p_1$).
- Sin embargo, $q_1^1 = 58 > \gamma_1 = 50$. Dado que la utilidad Stone-Geary tiene asíntotas verticales en $q_i = \gamma_i$ ($\lim_{q_i \to \gamma_i^+} \ln(q_i - \gamma_i) = -\infty$), siempre que el ingreso cubra la subsistencia ($y \ge S$), el consumo jamás descenderá por debajo del nivel de subsistencia $\gamma_i$.

### Pregunta 4: Implicancias para la Medición de la Pobreza
- **Actualización de la línea de pobreza:** La línea de pobreza extrema monetaria se define habitualmente como el costo de la canasta alimentaria mínima: $LPE = \sum p_j \gamma_j$. Si las agencias estadísticas solo actualizan los precios $p_j$ sin revisar las cantidades $\gamma_j$, asumen que los requerimientos de consumo no cambian con la urbanización o la demografía.
- **Sesgos temporales:** A medida que las sociedades se enriquecen, bienes anteriormente considerados suntuarios (acceso a telecomunicaciones, refrigeración, transporte público) se convierten en necesidades de subsistencia social. Si los $\gamma_j$ no se actualizan periódicamente, la línea de pobreza subestimará la privación real de los hogares.

---

## 5. Rúbrica de Evaluación Sugerida

| Criterio | Excelente (90–100%) | Satisfactorio (70–89%) | Requiere Mejora (<70%) |
| :--- | :--- | :--- | :--- |
| **Dominio del LES (Ejercicio 1)** | Deducirá correctamente el gasto de subsistencia, demandas, elasticidades y el límite Cobb-Douglas con justificación analítica impecable. | Calcula bien las demandas pero comete errores menores en elasticidades o en la interpretación del límite. | Confunde gasto total con ingreso supernumerario o viola la restricción presupuestaria. |
| **Álgebra Matricial SAM (Ejercicio 2)** | Verifica el balance de partida doble, calcula correctamente $A_n$, invierte $(I - A_n)$ y computa los impactos del shock. | Balancea la matriz pero comete errores en la inversión matricial o en el cálculo del shock. | No comprende la partición endógena/exógena o no verifica la partida doble. |
| **Análisis de Políticas y Bienestar (Ejercicio 3)** | Identifica la inviabilidad sin transferencia, calcula la compensación exacta y argumenta rigurosamente el comportamiento asintótico. | Calcula la transferencia requerida pero no explica con profundidad la sustitución o las líneas de pobreza. | No logra relacionar el costo de la subsistencia con la línea de pobreza extrema. |

# Guía Docente y Solucionario Confidencial

## Nobel de Economía 2011: Thomas J. Sargent y Christopher A. Sims
> **Uso exclusivo para el cuerpo docente.** Contiene el desarrollo analítico completo de los ejercicios propuestos en `estudiante/ejercicios.qmd`, sugerencias pedagógicas y rúbrica de evaluación.

---

# Orientación Pedagógica

La enseñanza de las contribuciones de Sargent y Sims permite integrar dos pilares metodológicos de la macroeconomía contemporánea:
1. **El rigor empírico dinámico (Sims):** Superar la falsa dicotomía entre teoría abstracta y correlaciones estáticas mediante sistemas multivariados dinámicos (VAR/SVAR) donde se explicita el supuesto de identificación causal.
2. **La coherencia con expectativas racionales (Sargent):** Enseñar a los estudiantes que los agentes económicos no son autómatas con expectativas estáticas o adaptativas. Cuando las autoridades cambian las reglas de política, la conducta del público muta endógenamente, invalidando los modelos econométricos tradicionales (Crítica de Lucas).

Se sugiere organizar una sesión de laboratorio de 2 a 3 horas donde los alumnos corran el script `estimacion_svar_macro.R`, modifiquen el orden de Cholesky y constaten visualmente cómo cambian las funciones impulso-respuesta.

---

# Solución Detallada de los Ejercicios

## Ejercicio 1: El Ordenamiento de Cholesky y la Matriz Contemporánea de Impacto (Nivel Básico)

### 1. Factorización de Cholesky paso a paso
Se tiene la matriz simétrica y definida positiva de varianzas y covarianzas de los residuos:
$$\Sigma_u = \begin{pmatrix} 0.49 & 0.14 & 0.07 \\ 0.14 & 0.29 & 0.11 \\ 0.07 & 0.11 & 0.18 \end{pmatrix}$$

Buscamos $P$ triangular inferior tal que $P P' = \Sigma_u$:
$$\begin{pmatrix} p_{11} & 0 & 0 \\ p_{21} & p_{22} & 0 \\ p_{31} & p_{32} & p_{33} \end{pmatrix} \begin{pmatrix} p_{11} & p_{21} & p_{31} \\ 0 & p_{22} & p_{32} \\ 0 & 0 & p_{33} \end{pmatrix} = \begin{pmatrix} 0.49 & 0.14 & 0.07 \\ 0.14 & 0.29 & 0.11 \\ 0.07 & 0.11 & 0.18 \end{pmatrix}$$

**Paso 1: Primera columna de $P$**
- $p_{11}^2 = \Sigma_{11} = 0.49 \implies p_{11} = \sqrt{0.49} = \mathbf{0.70}$
- $p_{21} p_{11} = \Sigma_{21} = 0.14 \implies p_{21} = \frac{0.14}{0.70} = \mathbf{0.20}$
- $p_{31} p_{11} = \Sigma_{31} = 0.07 \implies p_{31} = \frac{0.07}{0.70} = \mathbf{0.10}$

**Paso 2: Segunda columna de $P$**
- $p_{21}^2 + p_{22}^2 = \Sigma_{22} = 0.29 \implies (0.20)^2 + p_{22}^2 = 0.29 \implies 0.04 + p_{22}^2 = 0.29 \implies p_{22} = \sqrt{0.25} = \mathbf{0.50}$
- $p_{31} p_{21} + p_{32} p_{22} = \Sigma_{32} = 0.11 \implies (0.10)(0.20) + p_{32}(0.50) = 0.11$
  $$0.02 + 0.50 p_{32} = 0.11 \implies 0.50 p_{32} = 0.09 \implies p_{32} = \frac{0.09}{0.50} = \mathbf{0.18}$$

**Paso 3: Tercera columna de $P$**
- $p_{31}^2 + p_{32}^2 + p_{33}^2 = \Sigma_{33} = 0.18$
  $$(0.10)^2 + (0.18)^2 + p_{33}^2 = 0.18 \implies 0.01 + 0.0324 + p_{33}^2 = 0.18$$
  $$0.0424 + p_{33}^2 = 0.18 \implies p_{33}^2 = 0.1376 \implies p_{33} = \sqrt{0.1376} \approx \mathbf{0.3709}$$

Por tanto, la matriz de impacto estructural contemporáneo es:
$$P = \begin{pmatrix} 0.70 & 0 & 0 \\ 0.20 & 0.50 & 0 \\ 0.10 & 0.18 & 0.3709 \end{pmatrix}$$

---

### 2. Impacto contemporáneo de un shock de política monetaria ($\varepsilon^i_t$)
El vector de innovaciones reducidas en $t$ se obtiene como:
$$u_t = P \varepsilon_t = \begin{pmatrix} 0.70 & 0 & 0 \\ 0.20 & 0.50 & 0 \\ 0.10 & 0.18 & 0.3709 \end{pmatrix} \begin{pmatrix} \varepsilon^y_t \\ \varepsilon^\pi_t \\ \varepsilon^i_t \end{pmatrix}$$

Para un shock puramente monetario no anticipado unitario, tenemos $\varepsilon_t = [0, 0, 1]'$. Multiplicando:
$$u_t = \begin{pmatrix} 0.70 & 0 & 0 \\ 0.20 & 0.50 & 0 \\ 0.10 & 0.18 & 0.3709 \end{pmatrix} \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix} = \begin{pmatrix} 0 \\ 0 \\ 0.3709 \end{pmatrix}$$

- **Impacto en el producto:** $\frac{\partial y_t}{\partial \varepsilon^i_t} = \mathbf{0}$.
- **Impacto en la inflación:** $\frac{\partial \pi_t}{\partial \varepsilon^i_t} = \mathbf{0}$.
- **Impacto en la tasa de interés:** $\frac{\partial i_t}{\partial \varepsilon^i_t} = p_{33} = \mathbf{0.3709}$ (o normalizado a 1.0 dividiendo entre $p_{33}$).

**Justificación económica de los ceros:**
La estructura triangular impone que la economía real (fijación de planes de producción, empleo e inventarios) y la fijación de precios al consumidor sufren rigideces y contratos previos que impiden una reacción instantánea durante el trimestre en que el banco central modifica la tasa. La política monetaria solo afecta al producto y a los precios con rezago ($t+1, t+2, \dots$). En contraste, el banco central fija su tasa $i_t$ observando las señales contemporáneas de producto e inflación ($p_{31} = 0.10, p_{32} = 0.18$).

---

### 3. Sensibilidad al orden de las variables
Para $K = 3$ variables, existen $K! = 3! = 6$ posibles ordenamientos recursivos:
1. $[y, \pi, i]$ (orden estándar de Sims / CEE 1999)
2. $[y, i, \pi]$
3. $[\pi, y, i]$
4. $[\pi, i, y]$
5. $[i, y, \pi]$
6. $[i, \pi, y]$

Si se elige el orden $[i_t, y_t, \pi_t]'$, la primera fila de la nueva matriz triangular $P^*$ asigna ceros a las columnas 2 y 3. Esto implicaría que:
- La tasa de interés de política monetaria **no responde contemporáneamente** ni a la brecha de producto ni a la inflación ($p^*_{12} = 0, p^*_{13} = 0$), lo cual contradice la práctica de la banca central moderna que monitorea indicadores líderes en tiempo real.
- El producto y la inflación responderían **instantáneamente** a la tasa de interés en el mismo trimestre del shock ($p^*_{21} \ne 0, p^*_{31} \ne 0$), ignorando las rigideces nominales y los rezagos de transmisión de la política económica.

---

## Ejercicio 2: La "Paradoja del Precio" (*Price Puzzle*) y Variables Informacionales (Nivel Intermedio)

### 1. Causa informacional y sesgo por variable omitida
El *price puzzle* surge de una especificación deficiente del conjunto de información en el VAR:
- **Operación prospectiva del Banco Central:** En la práctica, los bancos centrales no son puramente reactivos frente al pasado. Cuentan con equipos técnicos que monitorean indicadores adelantados (mercados de commodities, tipos de cambio, encuestas de expectativas, agregados monetarios).
- **El choque aparente:** Si el banco central observa un shock inminente en los precios mundiales de la energía o materias primas que causará inflación dentro de dos trimestres, el banco central eleva preventivamente la tasa de interés en el presente trimestre.
- **La trampa econométrica:** Si el econometrista estima un VAR que solo incluye $[y_t, \pi_t, i_t]$, el modelo no "ve" la información sobre las materias primas que motivó la subida de tasas. Para el VAR, la subida de tasas parece una innovación exógena inesperada $\varepsilon^i_t > 0$, la cual va seguida inexorablemente por la inflación prevista que el banco central intentó mitigar. En consecuencia, la regresión OLS estima un coeficiente positivo espurio entre la subida de tasas previa y la inflación posterior.

### 2. Solución econométrica
Para eliminar el sesgo, Christopher Sims (1992) propuso incluir variables que aproximen la información prospectiva del banco central:
- **Índice de Precios de Materias Primas (*Commodity Price Index*):** Al incluir un índice de precios del petróleo y materias primas (o precios al por mayor) colocado antes de la tasa de interés en el ordenamiento de Cholesky, el VAR "purga" la función de reacción del banco central de los movimientos anticipatorios. La tasa residual de interés pasa a capturar innovaciones genuinamente exógenas, logrando que la respuesta de los precios sea negativa y monotónica tras el shock, erradicando el *price puzzle*.

### 3. Perspectiva de Thomas Sargent
Thomas Sargent (1979, 1987) argumenta que la fijación de la tasa de interés es en su inmensa mayoría una **política sistemática** derivada del equilibrio de expectativas racionales:
- Intentar interpretar las innovaciones residuales $\varepsilon^i_t$ como "la política monetaria" es un error conceptual: los bancos centrales bien gestionados no operan mediante sorpresas aleatorias ni "ruido blanco". Su efectividad radica en la credibilidad y previsibilidad de su regla de respuesta sistemática.
- Los shocks monetarios capturados por un VAR representan en gran medida errores de medición, cambios transitorios en la demanda de reservas o errores operativos menores, y no el verdadero efecto estabilizador del régimen monetario.

---

## Ejercicio 3: Métodos Alternativos de Identificación: Signos vs. Largo Plazo (Nivel Avanzado / Reto)

### 1. Identificación por Restricciones de Largo Plazo (Blanchard y Quah, 1989)
En una representación Wold del VAR en primeras diferencias:
$$\Delta Y_t = C(L) \varepsilon_t = \sum_{j=0}^\infty C_j \varepsilon_{t-j}$$
La matriz de multiplicadores de largo plazo que mide el impacto acumulado de los shocks sobre los niveles es:
$$C(1) = \sum_{j=0}^\infty C_j = \left( I - \sum_{i=1}^p A_i \right)^{-1} P$$
Dado que $\Sigma_u = P P'$, se cumple que:
$$C(1) C(1)' = \left( I - \sum_{i=1}^p A_i \right)^{-1} \Sigma_u \left( I - \sum_{i=1}^p A_i \right)^{-1'} = \Omega$$
Blanchard y Quah imponen que el shock de demanda $\varepsilon^d_t$ no tiene efecto permanente sobre el logaritmo del PIB ($y$), lo que equivale a imponer que la entrada $(1, 2)$ de la matriz de largo plazo $C(1)$ sea idénticamente cero:
$$C(1) = \begin{pmatrix} c_{11}(1) & 0 \\ c_{21}(1) & c_{22}(1) \end{pmatrix}$$
Dado que $C(1)$ es triangular inferior, puede obtenerse mediante la descomposición de Cholesky directa de la matriz de largo plazo $\Omega$. Una vez conocida $C(1)$, la matriz contemporánea estructural se recupera unívocamente como:
$$P = \left( I - \sum_{i=1}^p A_i \right) C(1)$$
Este método permite que el shock de demanda afecte al PIB contemporáneamente sin imponer restricciones arbitrarias en $t = 0$.

### 2. Identificación por Restricciones de Signos (Uhlig, 2005)
Uhlig parte de una factorización arbitraria (como Cholesky, $\tilde{P}$) y aplica matrices ortogonales de rotación $Q$ ($Q Q' = I$):
$$P = \tilde{P} Q$$
- Genera miles de matrices de rotación aleatorias $Q$ (utilizando descomposiciones QR de matrices normales estándar).
- Para cada rotación, computa las funciones impulso-respuesta $IRF_h(Q)$.
- Retiene únicamente las rotaciones que satisfacen las restricciones de signo: la tasa de interés debe subir, la inflación no debe aumentar y los agregados monetarios deben contraerse durante los trimestres $h = 0, \dots, 4$.
- **Ventaja epistemológica:** No impone ceros contemporáneos "increíbles" en $t = 0$ ni supuestos asintóticos en el infinito.
- **Costo inferencial:** No produce un único estimador puntual, sino una familia o conjunto de modelos admisibles (*set identification* o identificación parcial), requiriendo bandas bayesianas para resumir la incertidumbre epistémica.

### 3. Síntesis y Evaluación Crítica
- **Sims (Cholesky):** Sencillo, exacto e intuitivo, pero vulnerable a la arbitrariedad del orden secuencial.
- **Blanchard-Quah (Largo Plazo):** Basado en teoría sólida (neutralidad monetaria de largo plazo), pero altamente impreciso estadísticamente en muestras finitas porque estimar sumas infinitas de rezagos tiene gran varianza.
- **Uhlig (Signos):** Agnóstico y flexible, pero puede ser tautológico si restringe a priori el mismo signo que la teoría busca contrastar.
- **Crítica de Lucas y Sargent:** Ninguno de estos métodos es inmune a cambios permanentes en el régimen de política económica. Si el banco central adopta un nuevo mandato (ej. metas de inflación), los coeficientes de las ecuaciones cambian porque las expectativas racionales de los agentes se reconfiguran. Por ello, Sargent aboga por estimar modelos estructurales de equilibrio general dinámico estocástico (DSGE) donde los parámetros de preferencias y tecnología son invariantes ante la política.

---

# Rúbrica de Evaluación Sugerida (Total: 100 puntos)

| Componente | Criterios de Evaluación | Puntaje |
|---|---|:---:|
| **Ejercicio 1: Álgebra de Cholesky** | - Derivación correcta paso a paso de los coeficientes de la matriz $P$ (15 pts).<br>- Cálculo del impacto contemporáneo de $\varepsilon^i_t$ y explicación económica de los ceros (10 pts).<br>- Análisis del número de ordenamientos ($K!$) y consecuencias teóricas del orden alternativo (10 pts). | **35 pts** |
| **Ejercicio 2: Paradoja del Precio** | - Explicación clara del sesgo por variable omitida y la naturaleza prospectiva del banco central (15 pts).<br>- Propuesta de soluciones empíricas (precios de materias primas/spreads) (10 pts).<br>- Discusión de la crítica de Sargent sobre política sistemática vs shocks (10 pts). | **35 pts** |
| **Ejercicio 3: Identificación Estructural** | - Formulación matemática de la condición de largo plazo de Blanchard-Quah (10 pts).<br>- Comprensión del método de rotación de Uhlig y su trade-off de identificación de conjuntos (10 pts).<br>- Comparación crítica rigurosa e integración con la crítica de Lucas (10 pts). | **30 pts** |
| **Total** | **Evaluación integral de macroeconometría teórica y aplicada.** | **100 pts** |

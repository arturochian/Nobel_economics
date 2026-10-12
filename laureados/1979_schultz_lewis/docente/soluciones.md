# Solucionario y Pautas Docentes: Modelo Dual de Lewis y Capital Humano Agrícola de Schultz

**Premio Nobel de Economía 1979: Theodore W. Schultz y Sir Arthur Lewis**  
*Material exclusivo para el equipo docente — Nobel_economics*

---

## 1. Orientación Pedagógica y Objetivos de Aprendizaje

Esta unidad formativa aborda dos de las contribuciones más influyentes en la historia de la economía del desarrollo:
1. **El Modelo Dual de W. Arthur Lewis (1954):** Permite a los estudiantes vincular el análisis del mercado de trabajo clásico/neoclásico con el cambio estructural macroeconómico y la dinámica distributiva entre salarios y beneficios.
2. **La Hipótesis "Pobres pero Eficientes" y el Capital Humano de Theodore Schultz (1964, 1975):** Permite derribar mitos etnocéntricos sobre el campesinado del Sur Global, demostrando con optimización microeconómica rigurosa que la inversión en capital humano es indispensable para desbloquear el cambio tecnológico.

---

## 2. Solución Detallada a los Ejercicios

### Ejercicio 1: La Asignación Intersectorial y el Punto de Inflexión de Lewis (Nivel Básico)

#### Pregunta 1: Productividad Marginal Agrícola y Salario Institucional
- La función de producción agrícola es $Y_A = 20 L_A^{0.5}$.
- El producto marginal del trabajo ($MPL_A$) se obtiene derivando respecto a $L_A$:
  $$MPL_A = \frac{\partial Y_A}{\partial L_A} = 20 \times 0.5 \, L_A^{-0.5} = 10 L_A^{-0.5} = \frac{10}{\sqrt{L_A}}$$
- Para que $MPL_A \ge \bar{w}_{sub} = 1.0$:
  $$\frac{10}{\sqrt{L_A}} \ge 1.0 \iff \sqrt{L_A} \le 10 \iff L_A \le 100$$
- **Interpretación económica:** El umbral máximo de trabajadores agrícolas es $L_A^* = 100$. Si la población campesina excede los 100 trabajadores ($L_A > 100$), el producto marginal cae por debajo de la subsistencia ($MPL_A < 1.0$). En ese tramo, el salario rural de reserva se desvincula de la productividad marginal y queda anclado por la norma comunitaria de subsistencia: $w_A = \bar{w}_{sub} = 1.0$. Existe desempleo encubierto / mano de obra redundante.

#### Pregunta 2: Cálculo del Punto de Inflexión de Lewis (LTP)
- Dado que la fuerza laboral total es $L = 1000$ y la condición de pleno empleo agregado es $L_A + L_M = 1000$:
  $$L_M^* = L - L_A^* = 1000 - 100 = 900$$
- La economía alcanza el Punto de Inflexión de Lewis cuando la industria moderna ha logrado absorber **$900$ trabajadores**.
- En ese instante exacto:
  - Salario rural: $w_A^* = \max(1.0, MPL_A(100)) = 1.0$.
  - Salario urbano de equilibrio: $w_M^* = 1.35 \times w_A^* = 1.35$.
  - A partir de $L_M > 900$ ($L_A < 100$), $MPL_A$ superará $1.0$, y ambos salarios ($w_A$ y $w_M$) comenzarán a subir en términos reales.

#### Pregunta 3: Demanda de Trabajo Industrial y Stock Crítico de Capital
- Función de producción industrial: $Y_M = 2 K^{0.4} L_M^{0.6}$.
- Condición de maximización de beneficios: $MPL_M = w_M$.
  $$MPL_M = 0.6 \times 2 K^{0.4} L_M^{-0.4} = 1.2 K^{0.4} L_M^{-0.4} = w_M$$
- Despejando $L_M$:
  $$L_M^{0.4} = \frac{1.2 K^{0.4}}{w_M} \implies L_M^d = K \left( \frac{1.2}{w_M} \right)^{1 / 0.4} = K \left( \frac{1.2}{w_M} \right)^{2.5}$$
- Para $w_M = 1.35$:
  $$\frac{1.2}{1.35} = \frac{8}{9} \approx 0.888889 \implies (0.888889)^{2.5} \approx 0.744955$$
  Por ende: $L_M^d = 0.744955 \cdot K$.
- Para alcanzar el empleo crítico del Punto de Inflexión ($L_M^* = 900$):
  $$0.744955 \cdot K^* = 900 \implies K^* = \frac{900}{0.744955} \approx 1208.13 \text{ unidades de capital}$$

---

### Ejercicio 2: Acumulación de Capital, Excedente y Dinámica de Transición (Nivel Intermedio)

#### Pregunta 1: Participación de los Beneficios en la Industria
- En un mercado competitivo con función Cobb-Douglas $Y_M = A_M K^\beta L_M^{1 - \beta}$, el salario real iguala al producto marginal: $w_M = (1 - \beta) \frac{Y_M}{L_M}$.
- Multiplicando por el empleo $L_M$, la masa salarial total es:
  $$w_M L_M = (1 - \beta) Y_M$$
- Los beneficios brutos son el residuo del producto:
  $$\Pi_t = Y_M - w_M L_M = Y_M - (1 - \beta) Y_M = \beta Y_M$$
- Para $\beta = 0.40$:
  - Participación de los beneficios: $\frac{\Pi_t}{Y_{M,t}} = \beta = 0.40 \quad (40\%)$.
  - Participación de la masa salarial: $\frac{w_M L_{M,t}}{Y_{M,t}} = 1 - \beta = 0.60 \quad (60\%)$.

#### Pregunta 2: Ecuación en Diferencias del Crecimiento del Capital
- Sustituyendo la demanda de trabajo $L_M^d = K \left( \frac{(1 - \beta) A_M}{w_M} \right)^{1/\beta}$ en la función de producción:
  $$Y_{M,t} = A_M K_t^\beta \left[ K_t \left( \frac{(1 - \beta) A_M}{w_M} \right)^{1/\beta} \right]^{1 - \beta} = A_M K_t \left( \frac{(1 - \beta) A_M}{w_M} \right)^{(1 - \beta)/\beta} = \Phi K_t$$
- Expresión de $\Phi$:
  $$\Phi = A_M \left( \frac{(1 - \beta) A_M}{w_M} \right)^{\frac{1 - \beta}{\beta}} = A_M^{1/\beta} \left( \frac{1 - \beta}{w_M} \right)^{\frac{1 - \beta}{\beta}}$$
- Evaluación numérica con $A_M = 2$, $\beta = 0.40$, $w_M = 1.35$:
  - $\frac{1}{\beta} = 2.5$, $\frac{1 - \beta}{\beta} = \frac{0.6}{0.4} = 1.5$.
  - $\Phi = 2^{2.5} \times \left( \frac{0.6}{1.35} \right)^{1.5} = \sqrt{32} \times \left( \frac{4}{9} \right)^{1.5} \approx 5.656854 \times \frac{8}{27} \approx 5.656854 \times 0.296296 \approx 1.676105$.
- Beneficios totales: $\Pi_t = \beta \Phi K_t = 0.40 \times 1.676105 K_t \approx 0.670442 K_t$.
- Ley de movimiento del capital con $s_\Pi = 0.30$ y $\delta = 0.05$:
  $$K_{t+1} = (1 - \delta) K_t + s_\Pi \Pi_t = (1 - 0.05) K_t + 0.30 \times (0.670442 K_t) = (0.95 + 0.201133) K_t = 1.151133 K_t$$
- Tasa de crecimiento del capital:
  $$g_K = 1.151133 - 1 = 0.151133 \approx 15.11\% \text{ por período}$$

#### Pregunta 3: Tiempo de Transición hacia el Punto de Inflexión
- La trayectoria temporal del capital es $K_t = K_0 (1 + g_K)^t$.
- Igualando a $K^* = 1208.13$ con $K_0 = 150$:
  $$150 \times (1.151133)^{T^*} = 1208.13 \implies (1.151133)^{T^*} = \frac{1208.13}{150} \approx 8.0542$$
- Tomando logaritmos:
  $$T^* = \frac{\ln(8.0542)}{\ln(1.151133)} = \frac{2.08621}{0.140747} \approx 14.82 \approx 15 \text{ períodos}$$
- **Impacto de la reducción de $s_\Pi$ a $0.15$ (consumo conspicuo o fuga de capitales):**
  $$K_{t+1} = 0.95 K_t + 0.15 \times (0.670442 K_t) = (0.95 + 0.100566) K_t = 1.050566 K_t \implies g_K' \approx 5.06\%$$
  $$T^{*\prime} = \frac{\ln(8.0542)}{\ln(1.050566)} = \frac{2.08621}{0.049329} \approx 42.29 \approx 43 \text{ períodos}$$
- **Conclusión de Lewis:** El ritmo de desarrollo y la absorción de los pobres rurales no depende de la caridad ni del crecimiento natural de la población, sino de la tasa a la que la clase capitalista reinvierte su excedente. Si la burguesía o el Estado malgastan las ganancias, el país queda atrapado en la trampa del excedente laboral.

---

### Ejercicio 3: La Hipótesis de Schultz y la Habilidad para Afrontar Desequilibrios (Nivel Reto)

#### Pregunta 1: La Condición de "Pobres pero Eficientes"
- En la Aldea A (tradicional), para $S = 2$:
  $$Y_A = 10 \cdot (1 + 0.015 \times 2) \cdot K_{trad}^{0.15} = 10 \cdot 1.03 \cdot K_{trad}^{0.15} = 10.3 \cdot K_{trad}^{0.15}$$
- Producto marginal de $K_{trad}$:
  $$MPK_{trad} = \frac{\partial Y_A}{\partial K_{trad}} = 10.3 \times 0.15 \, K_{trad}^{-0.85} = 1.545 K_{trad}^{-0.85}$$
- Condición de óptimo económico: $MPK_{trad} = P_K = 1$:
  $$1.545 K_{trad}^{-0.85} = 1 \implies K_{trad}^{0.85} = 1.545 \implies K_{trad}^* = (1.545)^{1/0.85} \approx 1.669$$
- Producción óptima:
  $$Y_A^* = 10.3 \times (1.669)^{0.15} \approx 10.3 \times 1.0797 \approx 11.12$$
- Beneficio neto: $\pi^* = 11.12 - 1.67 = 9.45$.
- Si un programa estatal subsidia o fuerza al agricultor a duplicar el insumo tradicional ($K = 3.34$):
  $$Y_A(3.34) = 10.3 \times (3.34)^{0.15} \approx 10.3 \times 1.1979 \approx 12.34$$
  - Aumento en ingresos brutos: $12.34 - 11.12 = 1.22$.
  - Costo de los insumos adicionales: $3.34 - 1.67 = 1.67$.
  - Pérdida neta adicional: $1.22 - 1.67 = -0.45$.
- **Demostración de Schultz:** Los campesinos tradicionales no usan pocos insumos por pereza o desidia; no los usan porque han llegado al límite de los rendimientos marginales de su tecnología. Son plenamente racionales y eficientes dentro de su frontera técnica.

#### Pregunta 2: Retorno a la Escolaridad ante el Choque Tecnológico (Schultz 1975)
- Función de eficiencia en la Aldea B: $\Omega(S) = 1 + 1.2 \left( \frac{S}{S + 4} \right)$.
- Derivada respecto a $S$:
  $$\frac{d \Omega(S)}{dS} = 1.2 \left( \frac{(S + 4) - S}{(S + 4)^2} \right) = \frac{4.8}{(S + 4)^2}$$
- Tasa marginal de retorno sobre la eficiencia: $\frac{d \ln \Omega}{dS} = \frac{\Omega'(S)}{\Omega(S)}$.
- En $S = 0$: $\Omega(0) = 1.0$, $\Omega'(0) = \frac{4.8}{16} = 0.30 \implies 30\%$ de incremento en la eficiencia técnica al adquirir los primeros rudimentos de alfabetización.
- Comparación entre $S = 0$ y $S = 6$ años:
  - **Aldea A (Tradicional):**
    $$Y(S=6) / Y(S=0) = \frac{1 + 0.015 \times 6}{1.0} = \frac{1.09}{1.00} = +9.0\% \text{ de aumento}$$
  - **Aldea B (Moderna / Revolución Verde):**
    $$\Omega(6) = 1 + 1.2 \left( \frac{6}{10} \right) = 1 + 0.72 = 1.72 \implies +72.0\% \text{ de aumento}$$
- **Validación del mecanismo de Schultz:** En una agricultura tradicional que no cambia, las habilidades necesarias se transmiten por tradición oral; el rendimiento de la escuela es marginal ($+9\%$). En cambio, cuando irrumpe la Revolución Verde, el campesino instruido es capaz de leer etiquetas de pesticidas, calcular dosificaciones de nitrógeno por hectárea y calibrar riegos motorizados, generando un salto productivo masivo ($+72\%$).

#### Pregunta 3: Implicancia para las Políticas de Desarrollo
- La política tradicional (a) basada en precios artificiales y subsidios a semillas autóctonas fracasa porque no altera la elasticidad tecnológica ($\gamma \approx 0.15$). Solo transfiere rentas sin expandir la frontera de posibilidades de producción.
- La política de Schultz (b) es la base del éxito de la Revolución Verde del CIMMYT (México) y del IRRI (Filipinas): vincular el desarrollo de insumos genéticos de alto impacto con la educación rural y la extensión agrícola, garantizando que el agricultor adquiera el capital humano necesario para adoptar con éxito la innovación.

---

## 3. Rúbrica de Calificación Sugerida (100 Puntos)

| Criterio | Puntos | Descripción de Desempeño |
|---|:---:|---|
| **Ejercicio 1: Lewis y LTP** | 30 | Deducción correcta de $MPL_A$ (10 pts), cálculo del punto de inflexión $L_M^* = 900$ (10 pts) y stock de capital $K^* = 1208.13$ (10 pts). |
| **Ejercicio 2: Dinámica de Capital** | 35 | Demostración de $\Pi = \beta Y$ (10 pts), obtención analítica de $\Phi$ y $g_K \approx 15.11\%$ (15 pts), y cálculo del tiempo de transición bajo ambos escenarios (10 pts). |
| **Ejercicio 3: Schultz y Capital Humano** | 35 | Demostración de la eficiencia en Aldea A (12 pts), derivación de $\Omega'(S)$ y comparación de retornos $S=6$ (15 pts), y análisis crítico de políticas públicas (8 pts). |

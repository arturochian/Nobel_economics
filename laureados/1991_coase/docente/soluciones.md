# Guía para el Docente: Soluciones y Pautas Pedagógicas

## Nobel de Economía 1991: Ronald H. Coase

> **Documento reservado para el equipo docente.** Contiene el desarrollo matemático completo de los ejercicios, soluciones analíticas detalladas, código R ejecutable para el reto de la frontera empresarial y rúbrica pedagógica de evaluación.

---

## 1. Pautas Pedagógicas y Objetivos de Aprendizaje

Al abordar las contribuciones de Ronald H. Coase en el aula universitaria, los profesores enfrentan dos confusiones profundamente arraigadas en los manuales de economía elemental:

1. **El Mito del "Mundo Coaseano sin Fricciones":** Muchos estudiantes (e incluso algunos libros introductorios) asumen erróneamente que Coase creía que los mercados siempre resuelven las externalidades mediante negociación privada y que el Estado es innecesario. Es fundamental enfatizar que el Teorema de Coase con costos de transacción nulos ($T = 0$) fue un recurso metodológico de reducción al absurdo para criticar la teoría de externalidades de Pigou. Como afirmó Coase en su conferencia Nobel de 1991: *"Lo que hice fue mostrar que en el mundo sin costos de transacción de los economistas, las instituciones no importaban. Mi propósito real era introducir los costos de transacción en el centro del análisis económico, porque en el mundo real siempre son positivos y las instituciones importan decisivamente"*.
2. **La Naturaleza Recíproca del Daño:** La intuición moral tradicional etiqueta mecánicamente a una parte como "culpable/agresor" (la fábrica que contamina o el confitero que hace ruido) y a la otra como "víctima inocente" (el médico o el vecino). Coase demostró que el conflicto es económico y simétrico: para proteger el silencio del médico se debe sacrificar la producción de dulces del confitero. El objetivo social no es castigar al causante físico, sino maximizar el valor conjunto del producto social evitando el daño más costoso.
3. **El Mecanismo de Precios no es Gratuito:** El artículo de 1937 rompió con la ficción walrasiana de un subastador que fija precios sin coste. Utilizar el mercado consume recursos reales (búsqueda, redacción de contratos, resolución de disputas). La empresa existe precisamente como una isla de planificación administrativa consciente que suprime el sistema de precios para ahorrar costos de transacción.

---

## 2. Soluciones Detalladas de los Ejercicios

### Ejercicio 1: El Conflicto del Médico y el Confitero (Nivel Básico)

#### Pregunta 1: El Óptimo Social (Primer Mejor)
- Funciones dadas:
  $$B(Q) = 80 Q - 2 Q^2 \implies MB(Q) = 80 - 4 Q$$
  $$D(Q) = 2 Q^2 \implies MD(Q) = 4 Q$$
- Función de excedente social neto:
  $$W(Q) = B(Q) - D(Q) = (80 Q - 2 Q^2) - 2 Q^2 = 80 Q - 4 Q^2$$
- Condición de primer orden para maximizar el bienestar social:
  $$\frac{dW}{dQ} = MB(Q) - MD(Q) = 80 - 8 Q = 0 \implies 8 Q^* = 80 \implies Q^* = 10 \text{ horas}$$
  La condición de segundo orden confirma un máximo estricto: $\frac{d^2 W}{dQ^2} = -8 < 0$.
- Evaluación monetaria en el óptimo social ($Q^* = 10$):
  $$B(10) = 80(10) - 2(10)^2 = 800 - 200 = \$600$$
  $$D(10) = 2(10)^2 = 2(100) = \$200$$
  $$W(Q^*) = B(10) - D(10) = 600 - 200 = \$400$$

#### Pregunta 2: Régimen Legal 1 (Derecho al Confitero)
- Si el confitero tiene derecho a emitir ruido libremente y opera de forma unilateral:
  $$\max_Q B(Q) \implies MB(Q) = 0 \implies 80 - 4 Q_{priv} = 0 \implies Q_{priv} = 20 \text{ horas}$$
- Valores bajo decisión unilateral no cooperativa:
  $$B(20) = 80(20) - 2(20)^2 = 1,600 - 800 = \$800$$
  $$D(20) = 2(20)^2 = 2(400) = \$800$$
  $$W(Q_{priv}) = B(20) - D(20) = 800 - 800 = \$0$$
- Pérdida irrecuperable de eficiencia social ($DWL$):
  $$DWL_1 = W(Q^*) - W(Q_{priv}) = 400 - 0 = \$400$$
  Existe una clara ineficiencia: el confitero genera $\$400$ de sobreproducción ruidosa cuyo daño marginal acumulado supera su beneficio marginal.

#### Pregunta 3: Negociación Coaseana bajo el Régimen 1 ($T = 0$)
- Para reducir las horas de operación de 20 a 10:
  - Pérdida de beneficio del confitero: $\Delta B = B(20) - B(10) = 800 - 600 = \$200$. Por tanto, el confitero exige como compensación mínima:
    $$P_{\min} = \$200$$
  - Reducción del daño sufrido por el médico: $\Delta D = D(20) - D(10) = 800 - 200 = \$600$. Por tanto, el médico está dispuesto a pagar como máximo:
    $$P_{\max} = \$600$$
- Rango de compensación mutuamente ventajosa:
  $$P \in [\$200, \$600]$$
- Si pactan cualquier pago $P \in (200, 600)$, por ejemplo el valor medio de Nash $P = \$400$:
  - Ganancia neta del confitero: $(B(10) + P) - B(20) = (600 + 400) - 800 = \$200$.
  - Ganancia neta del médico: $(-D(10) - P) - (-D(20)) = (-200 - 400) - (-800) = \$200$.
  - Excedente social conjunto: $(600 + 400) + (-200 - 400) = 600 - 200 = \$400 = W(Q^*)$.

#### Pregunta 4: Régimen Legal 2 (Derecho al Médico)
- Si el médico tiene derecho legal a exigir silencio absoluto y no negocian:
  $$Q = 0 \implies B(0) = 0, \quad D(0) = 0 \implies W(0) = \$0$$
- Negociación coaseana ($T = 0$):
  - El confitero desea operar 10 horas, lo que le reporta un beneficio bruto de $B(10) = \$600$. El pago máximo que ofrecerá al médico es:
    $$R_{\max} = \$600$$
  - El daño que sufrirá el médico al pasar de 0 a 10 horas es $D(10) = \$200$. El pago mínimo exigido por el médico es:
    $$R_{\min} = \$200$$
- Rango de pago:
  $$R \in [\$200, \$600]$$
  Cualquier pago en este intervalo induce al médico a vender 10 horas de permiso al confitero.
- **Conclusión del Teorema de Coase:** En ambos regímenes legales la cantidad de horas de ruido final es exactamente $Q^* = 10$ horas y el excedente social total es idéntico: $\$400$. La asignación de recursos es independiente del régimen legal. Lo único que varía es la **distribución de la riqueza**: en el Régimen 1 el médico paga al confitero (el médico es más pobre en riqueza final), mientras que en el Régimen 2 el confitero paga al médico (el médico es más rico en riqueza final).

---

### Ejercicio 2: Costos de Transacción, Fricciones y Reglas de Responsabilidad (Nivel Intermedio)

#### Pregunta 1: Ganancias Brutas de Negociación
- Ganancia bruta de negociar desde el Régimen 1 (confitero tiene derechos):
  $$\Delta W_1 = W(Q^*) - W(Q_{priv}) = 400 - 0 = \$400$$
- Ganancia bruta de negociar desde el Régimen 2 (médico tiene derechos):
  $$\Delta W_2 = W(Q^*) - W(0) = 400 - 0 = \$400$$

#### Pregunta 2: Umbrales Críticos de Fricción ($T$)
- Umbral máximo para que la negociación sea viable:
  $$T_1^* = \Delta W_1 = \$400$$
  $$T_2^* = \Delta W_2 = \$400$$
- Análisis con costos de transacción $T = \$250$:
  - Dado que $T = \$250 < \$400$, en ambos regímenes la ganancia conjunta del acuerdo supera el costo de transacción ($\Delta W > T$).
  - Las partes negociarán y se alcanzará el nivel óptimo $Q^* = 10$ horas.
  - El excedente social neto alcanzado en ambos casos será:
    $$W_{neto} = W(Q^*) - T = 400 - 250 = \$150$$
  - En este caso simétrico, ambos alcanzan el óptimo porque $T$ está por debajo del umbral de ambos. Sin embargo, si $T$ aumentara a $\$450$, la negociación colapsaría en ambos regímenes ($W = 0$).
  - Si las funciones fuesen asimétricas (como en la replicación numérica principal, donde $\Delta W_1 = 1,600$ y $\Delta W_2 = 3,600$), un costo de $T = 2,000$ causaría el colapso bajo el régimen 1 pero permitiría el acuerdo eficiente bajo el régimen 2, rompiendo la invarianza de asignación.

#### Pregunta 3: Multiplicidad de Víctimas y el Problema del Polizón (*Free Rider*)
- Al haber 100 familias, reunir una compensación colectiva para pagarle al confitero enfrenta severos costos de transacción:
  1. **Problema del polizón (*free-riding*):** Como la reducción del ruido es un bien público no excluyente en el vecindario, cada familia tiene un incentivo a declarar que no le molesta el ruido para no aportar dinero a la bolsa común, esperando que los demás financien la compensación.
  2. **Costos de coordinación y retención estratégica (*holdout*):** Convocar asambleas, contratar abogados colectivos y redactar contratos multilaterales dispara los costos de transacción agregados ($T \gg \Delta W_1$).
- En consecuencia, la negociación voluntaria privada fracasará inevitablemente.
- **Calabresi y Melamed (1972):**
  - **Regla de propiedad (*Property rule*):** Otorga un derecho absoluto que solo puede transmitirse mediante consentimiento voluntario (ej. orden judicial de cese). Es eficiente cuando los costos de transacción son bajos (pocas partes).
  - **Regla de responsabilidad objetiva (*Liability rule*):** Permite a una parte invadir el derecho de la otra sin su consentimiento previo, siempre y cuando indemnice a posteriori el daño evaluado objetivamente por el tribunal. Cuando hay múltiples víctimas o altos costos de transacción, una regla de responsabilidad objetiva (o un impuesto correctivo pigouviano) es superior, ya que no requiere la imposible unanimidad negociada entre 100 partes.

---

### Ejercicio 3: La Frontera de la Empresa: Make or Buy en la Era Digital (Nivel Avanzado / Reto en R)

#### Pregunta 1: Derivación Analítica
- Funciones:
  $$MC_m(N) = m_0 + m_1 N$$
  $$MC_f(N) = g_0 + g_1 N$$
- La frontera óptima $N^*$ iguala ambos costos marginales:
  $$MC_f(N^*) = MC_m(N^*) \implies g_0 + g_1 N^* = m_0 + m_1 N^*$$
  $$(g_1 - m_1) N^* = m_0 - g_0 \implies N^* = \frac{m_0 - g_0}{g_1 - m_1}$$
- Sustituyendo los parámetros tradicionales ($m_0 = 80, m_1 = 0.25, g_0 = 20, g_1 = 1.00$):
  $$N^*_{base} = \frac{80 - 20}{1.00 - 0.25} = \frac{60}{0.75} = 80 \text{ transacciones integradas}$$
- **Regla de decisión gerencial:**
  - Para toda tarea $N \le 80$: $MC_f(N) \le MC_m(N) \implies$ **Producir internamente (*Make*)**.
  - Para toda tarea $N > 80$: $MC_m(N) < MC_f(N) \implies$ **Comprar en el mercado abierto (*Buy*)**.

#### Pregunta 2: Impacto de Plataformas Digitales
- Nuevos parámetros de mercado: $m_0' = 40, m_1' = 0.20$. Parámetros internos idénticos: $g_0 = 20, g_1 = 1.00$.
- Nueva frontera:
  $$N^*_{digital} = \frac{40 - 20}{1.00 - 0.20} = \frac{20}{0.80} = 25 \text{ transacciones integradas}$$
- **Interpretación económica:**
  La reducción radical de los costos de búsqueda, reputación digital y contratación en el mercado hace que 55 tareas que antes convenía organizar jerárquicamente dentro de la firma ($N \in [26, 80]$) ahora sea más barato adquirirlas de proveedores externos especializados o profesionales independientes. Esto explica el auge contemporáneo del *outsourcing*, las plataformas de trabajo por encargo (*gig economy*) y la estructura de redes modulares frente al conglomerado industrial verticalmente integrado del siglo XX.

#### Pregunta 3: Código R para la Simulación y Visualización

```r
# ==============================================================================
# Solución al Reto Docente: Frontera Óptima de la Empresa en R
# ==============================================================================
library(ggplot2)
library(dplyr)
library(scales)

# Parámetros del modelo
m0_base <- 80; m1_base <- 0.25
m0_dig  <- 40; m1_dig  <- 0.20
g0      <- 20; g1      <- 1.00

# Puntos de corte analíticos
N_star_base <- (m0_base - g0) / (g1 - m1_base) # 80
N_star_dig  <- (m0_dig - g0)  / (g1 - m1_dig)  # 25

# Rango de transacciones
df <- data.frame(N = seq(1, 95, length.out = 300)) %>%
  mutate(
    MC_mercado_base = m0_base + m1_base * N,
    MC_mercado_dig  = m0_dig + m1_dig * N,
    MC_firma        = g0 + g1 * N
  )

# Gráfico
p <- ggplot(df, aes(x = N)) +
  # Áreas sombreadas para el caso digital
  geom_ribbon(
    data = filter(df, N <= N_star_dig),
    aes(ymin = MC_firma, ymax = MC_mercado_dig),
    fill = "#3498db", alpha = 0.2
  ) +
  geom_line(aes(y = MC_mercado_base, color = "Mercado Tradicional (MCm_base)"), linewidth = 1.2) +
  geom_line(aes(y = MC_mercado_dig, color = "Plataformas Digitales (MCm_digital)"), linewidth = 1.2, linetype = "dashed") +
  geom_line(aes(y = MC_firma, color = "Organización Interna (MCf)"), linewidth = 1.2) +
  # Puntos de frontera
  annotate("point", x = N_star_base, y = g0 + g1 * N_star_base, size = 3.5, color = "#2c3e50") +
  annotate("point", x = N_star_dig, y = g0 + g1 * N_star_dig, size = 3.5, color = "#8e44ad") +
  annotate("text", x = N_star_base - 5, y = (g0 + g1 * N_star_base) + 8,
           label = paste0("Frontera Base\nN* = ", N_star_base), fontface = "bold", size = 3.5) +
  annotate("text", x = N_star_dig + 2, y = (g0 + g1 * N_star_dig) + 10,
           label = paste0("Frontera Digital\nN* = ", N_star_dig), fontface = "bold", color = "#8e44ad", size = 3.5) +
  scale_color_manual(
    name = "Mecanismo:",
    values = c(
      "Mercado Tradicional (MCm_base)" = "#e74c3c",
      "Plataformas Digitales (MCm_digital)" = "#8e44ad",
      "Organización Interna (MCf)" = "#2980b9"
    )
  ) +
  labs(
    title = "Solución Docente: Contracción de la Frontera Empresarial por Plataformas",
    subtitle = "El abaratamiento de los costos de transacción del mercado induce desintegración vertical",
    x = "Volumen de Transacciones Internas (N)",
    y = "Costo Marginal de Coordinación ($)"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom")

print(p)
```

---

## 3. Rúbrica de Evaluación Analítica

| Criterio | Excelente (90–100%) | Satisfactorio (70–89%) | Requiere Mejora (<70%) |
| :--- | :--- | :--- | :--- |
| **1. Comprensión del Teorema de Coase** | Demuestra con rigor la invarianza de la asignación eficiente bajo $T=0$, identifica con exactitud los rangos de pago y aclara la diferencia entre asignación de recursos y distribución de renta. | Calcula los equilibrios correctamente pero confunde la distribución de la renta con una falla de eficiencia. | No logra despejar el óptimo social o asume erróneamente que la asignación física cambia con la ley bajo $T=0$. |
| **2. Impacto de Costos de Transacción ($T > 0$)** | Deduce los umbrales algebraicos de fricción, explica el colapso del pacto y vincula el problema con el análisis institucional comparativo de Calabresi y Melamed. | Calcula el valor numérico con $T = 250$ pero no conceptualiza los problemas de acción colectiva (*free rider*). | Omite los umbrales de transacción o no comprende por qué $T > 0$ restaura la relevancia de la ley. |
| **3. Frontera de la Empresa (Make or Buy)** | Deriva formalmente $N^*$, interpreta los parámetros económicos y explica la dinámica del outsourcing frente a plataformas digitales con claridad conceptual. | Despeja $N^*$ correctamente pero su interpretación económica sobre la desintegración vertical es superficial. | Errores matemáticos en la igualación de costos marginales o confusión entre costos de mercado y de gestión. |
| **4. Implementación Computacional en R** | Código limpio, modular, sin errores, con etiquetas claras y visualización estéticamente atractiva. | Código funcional pero desordenado o con advertencias de ejecución. | Código incompleto, que no corre o con dependencias no declaradas. |

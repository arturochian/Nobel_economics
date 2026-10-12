# Guía Docente y Solucionario Confidencial: Gobernanza Económica (Nobel 2009)

> **Material Exclusivo para el Profesorado**  
> **Asignaturas sugeridas:** Microeconomía Avanzada, Economía Institucional, Organización Industrial, Teoría de Juegos, Economía Ambiental y de Recursos Naturales.  
> **Tema:** Elinor Ostrom (Gobernanza de los Bienes Comunes) y Oliver E. Williamson (Economía de Costos de Transacción y Límites de la Empresa).

---

## Solución Detallada del Ejercicio 1: Sobrepastoreo Comunal y Principios de Ostrom

### 1. Equilibrio de Acceso Abierto (Tragedia de Hardin / Nash)

Cada ganadero $i \in \{1, \dots, 10\}$ maximiza su beneficio tomando las decisiones ajenas $X_{-i} = \sum_{j \neq i} x_j$ como dadas:
$$\max_{x_i} \pi_i(x_i, X_{-i}) = x_i \cdot (200 - 2(x_i + X_{-i})) - 40 x_i = (160 - 2 X_{-i}) x_i - 2 x_i^2$$

- **Condición de Primer Orden (FOC):**
  $$\frac{\partial \pi_i}{\partial x_i} = 160 - 2 X_{-i} - 4 x_i = 0 \implies x_i(X_{-i}) = \frac{160 - 2 X_{-i}}{4} = 40 - \frac{1}{2} X_{-i}$$

- **Equilibrio Simétrico:**
  Dado que los 10 ganaderos son idénticos, en equilibrio $x_i = x^{NE}$ para todo $i$, de modo que $X_{-i} = 9 x^{NE}$ y $X^{NE} = 10 x^{NE}$:
  $$x^{NE} = 40 - \frac{1}{2}(9 x^{NE}) \implies x^{NE} + \frac{9}{2} x^{NE} = 40 \implies \frac{11}{2} x^{NE} = 40$$
  $$x^{NE} = \frac{80}{11} \approx 7.2727 \text{ vacas por ganadero}$$

- **Valores Agregados de Equilibrio:**
  - Ganado total en la meseta: $X^{NE} = 10 \times \frac{80}{11} = \frac{800}{11} \approx 72.73 \text{ vacas}$.
  - Precio de mercado por animal:
    $$P(X^{NE}) = 200 - 2\left(\frac{800}{11}\right) = 200 - \frac{1600}{11} = \frac{600}{11} \approx 54.55 \text{ dólares}$$.
  - Margen de ganancia unitario: $P(X^{NE}) - c = \frac{600}{11} - 40 = \frac{160}{11} \approx 14.55 \text{ dólares}$.
  - Beneficio individual:
    $$\pi_i^{NE} = x^{NE} \times \left(P(X^{NE}) - 40\right) = \left(\frac{80}{11}\right) \times \left(\frac{160}{11}\right) = \frac{12800}{121} \approx 105.79 \text{ dólares}$$.
  - Renta económica total del pastizal:
    $$\Pi^{NE} = 10 \times \pi_i^{NE} = \frac{128000}{121} \approx 1057.85 \text{ dólares}$$.

---

### 2. Asignación Socialmente Óptima (Planificador Comunitario)

El planificador comunitario maximiza el beneficio total conjunto del pastizal:
$$\max_X \Pi(X) = X \cdot (200 - 2X) - 40 X = 160 X - 2 X^2$$

- **Condición de Primer Orden (FOC):**
  $$\frac{d\Pi}{dX} = 160 - 4 X = 0 \implies X^* = \frac{160}{4} = 40 \text{ vacas totales}$$

- **Cuota individual equitativa y resultados óptimos:**
  - Cuota por ganadero: $x^* = \frac{X^*}{10} = \frac{40}{10} = 4.00 \text{ vacas}$.
  - Precio por animal: $P(X^*) = 200 - 2(40) = 120 \text{ dólares}$.
  - Margen de ganancia unitario: $120 - 40 = 80 \text{ dólares}$.
  - Beneficio individual: $\pi_i^* = 4 \times 80 = 320 \text{ dólares}$.
  - Renta agregada máxima: $\Pi^* = 10 \times 320 = 3200 \text{ dólares}$.

- **Comparación y Renta Económica Disipada:**
  $$\Delta \Pi = \Pi^* - \Pi^{NE} = 3200 - 1057.85 = 2142.15 \text{ dólares disipados}$$
  $$\text{Porcentaje de renta disipada} = \frac{2142.15}{3200} \times 100\% = 66.94\%$$
  Bajo acceso abierto no cooperativo, se destruye prácticamente el **67%** de la riqueza económica generada por el recurso natural debido a que cada usuario ignora la externalidad negativa que sus animales imponen sobre la ganancia de peso del ganado ajeno.

---

### 3. Diagnóstico Institucional de Ostrom

Puntos esenciales que el estudiante debe articular:
1. **Límites claramente definidos (Principio 1):** Cierra el acceso libre a pastores foráneos. Solo los 10 comuneros reconocidos tienen derecho consuetudinario de pastoreo, transformando un régimen de "acceso abierto de nadie" en una "propiedad comunitaria delimitada".
2. **Monitoreo mutuo entre pares (Principio 4):** A diferencia de un inspector gubernamental (que cobra salario y desconoce el terreno), los propios ganaderos coinciden en los abrevaderos y senderos a diario. El costo marginal de vigilar a los pares mientras cuidan su propio ganado es prácticamente nulo.
3. **Sanciones graduadas (Principio 5):** Un ganadero que sobrepase la cuota de 4 vacas en 1 cabeza recibe primero una advertencia pública o una pequeña multa comunitaria (p. ej., aportar forraje o reparar cercas comunes). Si reincide de mala fe, la penalización escala hasta la pérdida de derechos de pastoreo. Esto preserva la cohesión social sin provocar rupturas hostiles.
4. **Resolución local y rápida de conflictos (Principio 6):** En caso de discrepancia (p. ej., una ternera recién nacida o ganado extraviado), la asamblea local de ancianos o regantes juzga de inmediato sin costos de litigio judicial formal.

---

## Solución Detallada del Ejercicio 2: Hold-up y Frontera de Williamson

### 1. Primer Mejor (Eficiencia Social)

El excedente social total conjunto es:
$$\max_I W(I) = V(I) - C(I) = 24 I - \frac{1}{2} I^2$$

- FOC: $\frac{dW}{dI} = 24 - I = 0 \implies I^* = 24$.
- Valor bruto generado: $V(24) = 24 \times 24 = 576$.
- Costo de inversión: $C(24) = \frac{1}{2}(24)^2 = 288$.
- Excedente social máximo: $W^* = 576 - 288 = 288$.

---

### 2. Segundo Mejor en Mercado Libre y Chantaje Contractual (*Hold-up*)

- **Excedente de Cuasi-renta ex-post:**
  Una vez realizada la inversión $I$, el costo $C(I)$ es un costo hundido no recuperable (*sunk cost*).
  La cuasi-renta a repartir si se llega a un acuerdo bilateral es:
  $$S(I) = V(I) - \bar{V}(I) = 24 I - 4 I = 20 I$$

- **Reparto de Nash (50/50):**
  Cada parte recibe su valor de reserva más la mitad de la cuasi-renta generada por la cooperación:
  - Pago bruto recibido por el Vendedor:
    $$\text{Pago}_S(I) = \bar{V}(I) + \frac{1}{2} S(I) = 4 I + \frac{1}{2}(20 I) = 14 I$$
  - Excedente neto capturado por el Comprador:
    $$\text{Pago}_B(I) = V(I) - \text{Pago}_S(I) = 24 I - 14 I = 10 I$$

- **Decisión de Inversión ex-ante del Vendedor:**
  El vendedor anticipa el chantaje ex-post y maximiza su beneficio esperado neto:
  $$\max_I \pi_S(I) = \text{Pago}_S(I) - C(I) = 14 I - \frac{1}{2} I^2$$
  - FOC: $\frac{d\pi_S}{dI} = 14 - I = 0 \implies I^{mercado} = 14$.

- **Comparación y Pérdida de Eficiencia:**
  - Subinversión: $I^{mercado} = 14 < I^* = 24$ (una caída del $41.7\%$ en la inversión tecnológica).
  - Valor real producido: $V(14) = 24 \times 14 = 336$.
  - Costo de inversión incurrido: $C(14) = \frac{1}{2}(14)^2 = 98$.
  - Excedente social realizado bajo mercado: $W^{mercado} = 336 - 98 = 238$.
  - **Pérdida de bienestar social por hold-up:**
    $$\Delta W = W^* - W^{mercado} = 288 - 238 = 50 \text{ unidades de valor}$$

El vendedor subinvierte porque anticipa que el comprador se apropiará del $50\%$ de la cuasi-renta que su esfuerzo privado genere ex-post.

---

### 3. La Solución de Williamson: Jerarquía e Integración Vertical

- **Mecanismo de la Jerarquía:**
  Al absorber la empresa proveedora, el comprador adquiere la propiedad formal de los activos físicos y el código de software. El proveedor pasa a ser un departamento interno de I+D. La toma de decisiones se rige por directiva ejecutiva interna (*fiat*), eliminando la posibilidad de que una de las partes amenace con marcharse con el activo. La empresa integrada elige la inversión para maximizar el valor del grupo: $I = I^* = 24$.
- **Cálculo de Eficiencia Comparada con Costo Burocrático:**
  - Excedente bruto en jerarquía: $W^* = 288$.
  - Costo burocrático administrativo de la empresa integrada: $G_H = 35$.
  - Excedente social neto bajo jerarquía:
    $$W_{neto}^{jerarquía} = 288 - 35 = 253$$.
  - Excedente neto bajo mercado con hold-up: $W^{mercado} = 238$.
  - Ganancia neta de la integración:
    $$253 - 238 = +15 \text{ unidades a favor de la integración vertical}$$.
- **Conclusión de Williamson:**
  Dado que la ganancia de superar el *hold-up* ($50$) supera con creces el costo administrativo burocrático de la jerarquía ($35$), la integración vertical es la estructura discreta de gobernanza superior y eficiente.

---

## Solución del Ejercicio 3: Reto de Gobernanza Policéntrica y Cadenas Globales

### Parte A: Gobernanza Policéntrica de Cuencas Hídricas
1. **Estructuras Anidadas en Tres Niveles (*Nested Enterprises*):**
   - **Nivel Micro (Comunidades Locales de Regadío):** Gestión de turnos de riego (*tandas*), mantenimiento de acequias y compuertas secundarias por parte de las asociaciones de campesinos.
   - **Nivel Meso (Subcuenca / Junta de Usuarios Mixta):** Coordinación entre las cooperativas agrícolas y las empresas hidroeléctricas locales para acordar calendarios estacionales de desembalse y turbinado.
   - **Nivel Macro (Autoridad de Cuenca Hidrográfica):** Fijación del caudal ecológico mínimo y asignación prioritaria de agua para consumo humano metropolitano durante sequías extremas, con compensaciones económicas acordadas.
2. **Monitoreo y Sanción de Bajo Costo:**
   - En lugar de inspectores satelitales percibidos como imposición hostil, se emplean jueces de aguas electos por los propios regantes (como el histórico Tribunal de las Aguas de Valencia estudiado por Ostrom) y reglas visuales de turno horario.
3. **Resolución Rápida de Controversias:**
   - La mediación entre pares resuelve infracciones en horas en la plaza del pueblo mediante apercibimientos públicos y multas en especie, evitando los años de demora y los costos judiciales del sistema estatal formal.

### Parte B: Cadenas Globales de Semiconductores (Williamson)
1. **Clasificación de Procesos:**
   - **Proceso 1 (Obleas estándar):** Especificidad baja ($k_1 \approx 0.10$), baja incertidumbre bilateral. Insumo estandarizado con múltiples oferentes en el mercado internacional.
   - **Proceso 2 (Empaquetado avanzado 3D):** Especificidad intermedia-alta ($k_2 \approx 0.65$), alta incertidumbre tecnológica. Exige coordinación estrecha de diseño pero con maquinaria parcialmente versátil.
   - **Proceso 3 (Fotolitografía EUV):** Especificidad de activos extrema ($k_3 \approx 0.95$), equipo hiperespecífico no reconvertible.
2. **Estructura Óptima:**
   - **Proceso 1 $\to$ Mercado ($M$):** Se adquiere mediante subastas y compras directas a precios spot/futuros. Los incentivos de alta potencia aseguran precios mínimos y flexibilidad global.
   - **Proceso 2 $\to$ Forma Híbrida ($X$):** Alianza estratégica a largo plazo o *joint venture* con un socio de fundición (ej. TSMC o ASE Group) con contratos relacionales de co-inversión, reparto de patentes y cláusulas de arbitraje técnico.
   - **Proceso 3 $\to$ Jerarquía o Integración Relacional Profunda:** Dado que ASML tiene un monopolio tecnológico de EUV, los grandes fabricantes (Intel, TSMC, Samsung) estructuran acuerdos bilaterales con toma de participaciones minoritarias de capital (*equity tie-ins*) y financiación directa de I+D para alinear incentivos y blindar las asignaciones de máquinas.
3. **Peligros de la Mala Asignación:**
   - Integrar verticalmente el Proceso 1 generaría ineficiencia burocrática y desaprovecharía economías de escala globales.
   - Operar el Proceso 2 bajo mercado simple provocaría congelamiento de inversiones por miedo al robo de propiedad intelectual o al chantaje en la entrega de empaquetados.

---

## Rúbrica Pedagógica de Evaluación

| Criterio | Excelente (90 - 100%) | Satisfactorio (70 - 89%) | Necesita Mejora (< 70%) |
|:---|:---|:---|:---|
| **Deducción Matemática (Ej. 1 y 2)** | Deriva FOCs con precisión analítica, identifica equilibrios y calcula la pérdida de peso muerto exacta. | Llega a los resultados numéricos con pequeños errores algebraicos o de notación. | Incapaz de formular las funciones de mejor respuesta o el reparto de Nash. |
| **Comprensión Institucional (Ostrom)** | Articula con fluidez cómo las normas comunitarias modifican los pagos esperados sin recurrir al Estado. | Enumera los principios de Ostrom de forma descriptiva sin conectarlos al juego no cooperativo. | Confunde bienes comunes con bienes públicos puros o recursos privados. |
| **Teoría de Costos de Transacción (Williamson)** | Explica el mecanismo de hold-up a través de la especificidad y justifica la elección de estructuras discretas. | Identifica la integración vertical como solución pero no formaliza el trade-off con los costos burocráticos. | Asume que la integración vertical siempre es superior o desconoce el rol de los activos específicos. |
| **Aplicación a Casos Reales (Ej. 3)** | Diseña soluciones coherentes y fundamentadas en las dos mitades del premio Nobel para problemas modernos. | Propone soluciones intuitivas con fundamentación teórica parcial. | Respuestas genéricas desconectadas de los principios de gobernanza. |

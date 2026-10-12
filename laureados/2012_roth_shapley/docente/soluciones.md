# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2012: Alvin E. Roth y Lloyd S. Shapley

> **Nota confidencial para el profesor:** Este material contiene las resoluciones formales completas, justificaciones matemáticas y pautas pedagógicas de evaluación correspondientes a los ejercicios propuestos en `estudiante/ejercicios.qmd`. Mantener reservado para uso docente.

---

### Solución Ejercicio 1 (Algoritmo de Gale-Shapley y Detección de Pares Bloqueadores)

#### 1. Algoritmo de Aceptación Diferida: Médicos Proponen (DA-D)

- **Preferencias de Médicos:**  
  $d_1: h_1 \succ h_2 \succ h_3$  
  $d_2: h_2 \succ h_1 \succ h_3$  
  $d_3: h_1 \succ h_2 \succ h_3$  
- **Preferencias de Hospitales:**  
  $h_1: d_2 \succ d_1 \succ d_3$  
  $h_2: d_1 \succ d_2 \succ d_3$  
  $h_3: d_1 \succ d_2 \succ d_3$  

**Paso a paso:**
- **Ronda 1:**
  - Los médicos libres proponen a su opción favorita:
    - $d_1 \to h_1$
    - $d_2 \to h_2$
    - $d_3 \to h_1$
  - Evaluación en hospitales:
    - $h_1$ recibe propuestas de $\{d_1, d_3\}$. Como en el orden de $h_1$, $d_1 \succ d_3$, $h_1$ **retiene provisionalmente a $d_1$** y **rechaza a $d_3$**.
    - $h_2$ recibe propuesta de $\{d_2\}$; lo **retiene provisionalmente**.
    - $h_3$ no recibe propuestas.
- **Ronda 2:**
  - $d_3$ (único rechazado libre) propone a su segunda opción: $h_2$.
  - Evaluación en hospitales:
    - $h_2$ compara su retenido provisional $d_2$ con el nuevo proponente $d_3$.
    - En el orden de $h_2$, $d_2 \succ d_3$. Por tanto, $h_2$ **mantiene retenido a $d_2$** y **rechaza a $d_3$**.
- **Ronda 3:**
  - $d_3$ propone a su tercera opción: $h_3$.
  - Evaluación en hospitales:
    - $h_3$ no tenía a nadie retenido, por lo que **retiene provisionalmente a $d_3$**.
- **Terminación:**
  - Ningún médico libre tiene opciones pendientes.
  - Asignación final:
    $$\mathbf{\mu_D = \{(d_1, h_1), (d_2, h_2), (d_3, h_3)\}}$$
  - El algoritmo converge exactamente en **3 rondas**.

---

#### 2. Algoritmo de Aceptación Diferida: Hospitales Proponen (DA-H)

**Paso a paso:**
- **Ronda 1:**
  - Cada hospital libre propone a su médico favorito:
    - $h_1 \to d_2$
    - $h_2 \to d_1$
    - $h_3 \to d_1$
  - Evaluación en médicos:
    - $d_1$ recibe ofertas de $\{h_2, h_3\}$. En las preferencias de $d_1$, $h_2 \succ h_3$. Por tanto, $d_1$ **retiene provisionalmente a $h_2$** y **rechaza a $h_3$**.
    - $d_2$ recibe oferta de $\{h_1\}$; lo **retiene provisionalmente**.
    - $d_3$ no recibe ofertas.
- **Ronda 2:**
  - $h_3$ (rechazado) propone a su segunda opción: $d_2$.
  - Evaluación en médicos:
    - $d_2$ compara su retenido $h_1$ con la nueva oferta $h_3$.
    - En las preferencias de $d_2$, $h_1 \succ h_3$. Por tanto, $d_2$ **mantiene retenido a $h_1$** y **rechaza a $h_3$**.
- **Ronda 3:**
  - $h_3$ propone a su tercera opción: $d_3$.
  - Evaluación en médicos:
    - $d_3$ estaba libre y acepta provisionalmente a $h_3$.
- **Terminación:**
  - Asignación final:
    $$\mathbf{\mu_H = \{(d_1, h_2), (d_2, h_1), (d_3, h_3)\}}$$

**Comparación e Implicancia Teórica:**
- Observamos que $\mu_H \neq \mu_D$:
  - En $\mu_D$, tanto $d_1$ como $d_2$ obtienen su primera opción ($h_1$ y $h_2$).
  - En $\mu_H$, tanto $h_1$ como $h_2$ obtienen su primera opción ($d_2$ y $d_1$), mientras que los médicos caen a su segunda preferencia.
- **Conclusión:** El conjunto de asignaciones estables contiene al menos dos asignaciones distintas. Esto prueba empíricamente la existencia de una estructura de retículo (*lattice*) donde los extremos están definidos por el emparejamiento óptimo para un lado y pésimo para el otro.

---

#### 3. Diagnóstico de Pares Bloqueadores en $\mu_{\text{alt}}$

- Asignación analizada: $\mu_{\text{alt}} = \{(d_1, h_3), (d_2, h_2), (d_3, h_1)\}$.
- **Racionalidad individual:** Todos los agentes prefieren su pareja asignada antes que quedarse solos/desempleados. Es individualmente racional.
- **Identificación de Pares Bloqueadores:**
  - Evaluemos el par $(d_1, h_1)$:
    - Para el médico $d_1$: bajo $\mu_{\text{alt}}$ está con $h_3$. En sus preferencias: $h_1 \succ h_3$. Por tanto, **$d_1$ prefiere estrictamente a $h_1$**.
    - Para el hospital $h_1$: bajo $\mu_{\text{alt}}$ está con $d_3$. En sus preferencias: $d_1 \succ d_3$. Por tanto, **$h_1$ prefiere estrictamente a $d_1$**.
    - **Conclusión:** $(d_1, h_1)$ es un **par bloqueador**.
  - Evaluemos también el par $(d_1, h_2)$:
    - $d_1$ prefiere $h_2 \succ h_3$.
    - $h_2$ está con $d_2$. En sus preferencias: $d_1 \succ d_2$. Por tanto, $(d_1, h_2)$ es también un par bloqueador.
- **Comportamiento en la práctica:** Al existir un par bloqueador como $(d_1, h_1)$, el médico $d_1$ y el hospital $h_1$ tienen incentivos para contactarse fuera del sistema oficial y acordar un contrato privado a espaldas de la asignación centralizada, lo que provocaría el colapso inmediato del mercado (*unraveling*).

---

### Solución Ejercicio 2 (Asimetría Proponente-Receptor y Veracidad Estratégica)

#### 1. Teoremas de Optimalidad y Pesimalidad
- **Teorema de Optimalidad Proponente (Gale y Shapley, 1962):** En el algoritmo de aceptación diferida, la asignación resultante cuando propone el lado $D$ es unánimemente la mejor asignación estable posible para todos los integrantes de $D$: no existe ninguna otra asignación estable en la que algún miembro de $D$ obtenga una pareja estrictamente superior.
- **Teorema de Pesimalidad Receptora (Knuth 1976, Roth 1984):** Simultáneamente, la asignación proponente-óptima $\mu_D$ otorga a cada integrante del lado receptor $H$ su peor pareja dentro de todo el conjunto de emparejamientos estables.
- **Interpretación Económica:** Quien propone explora el mercado de arriba hacia abajo, asegurando la opción más alta compatible con la estabilidad del sistema. El receptor se ve forzado a esperar pasivamente las propuestas y solo puede retener o descartar según las opciones que decidan acudir a él.
- **El Rediseño del NRMP en 1998 por Alvin Roth:** Desde 1952, el NRMP utilizaba un algoritmo donde los hospitales hacían las propuestas (hospital-proposing). Tras el análisis de Roth, se evidenció que este mecanismo perjudicaba de forma sistemática a los estudiantes de medicina. La junta directiva del NRMP contrató a Roth para reprogramar el sistema centralizado, adoptando en 1998 el algoritmo con los estudiantes como proponentes (*student-optimal stable matching*), resolviendo de manera equitativa la tensión histórica entre estudiantes y directores de departamento.

#### 2. Incentivos Estratégicos y Manipulabilidad
- **Veracidad para el Lado Proponente (Dubins-Freedman 1981, Roth 1982):**
  - Cuando los médicos proponen, revelar el orden real de preferencias es una **estrategia débilmente dominante** (*strategy-proof*). Ningún médico puede mejorar su asignación falsificando su lista o truncándola.
- **Manipulabilidad del Lado Receptor:**
  - Por el contrario, el lado receptor **sí puede manipular con éxito** el mecanismo mediante el **truncamiento estratégico** (*strategic truncation*).
  - *Mecanismo intuitivo:* Si un hospital retiene a un candidato de rango medio, los proponentes más competitivos que fueron rechazados en otros hospitales dejan de postular a ese hospital. Si el hospital declara falsamente inaceptable a su candidato provisional, este candidato desplazado es forzado a proponer a otros hospitales, desatando una reacción en cadena de propuestas cruzadas que puede forzar a un candidato superior a quedar libre y terminar proponiendo al hospital manipulador.
  - Sin embargo, Roth (1984, 1986) demostró que en mercados grandes con información incompleta, la probabilidad de éxito de dicha manipulación converge a cero.

---

### Solución Ejercicio 3 (Reto: Top Trading Cycles y Trasplante Renal)

#### 1. Ronda 1 del Algoritmo TTC
- **Preferencias efectivas:**
  - $P_1$ apunta a $D_2$ (su favorito compatible).
  - $P_2$ apunta a $D_3$ (su favorito compatible).
  - $P_3$ apunta a $D_1$ (su favorito compatible).
  - $P_4$ apunta a $D_2$.
- **Apontamientos de donantes:**
  - Por construcción del protocolo de intercambio emparejado, cada donante $D_i$ apunta estrictamente a su propio paciente vinculado $P_i$.
- **Identificación del Ciclo:**
  - La cadena de apuntamientos es:
    $$P_1 \longrightarrow D_2 \longrightarrow P_2 \longrightarrow D_3 \longrightarrow P_3 \longrightarrow D_1 \longrightarrow P_1$$
  - Existe un **ciclo cerrado de 3 vías** formado por los pares $\{1, 2, 3\}$.
  - Nótese que $P_4$ apunta a $D_2$, pero nadie apunta a $D_4$, por lo que el par 4 no entra en el ciclo.
- **Ejecución y Retiro:**
  - $P_1$ recibe el riñón de $D_2$.
  - $P_2$ recibe el riñón de $D_3$.
  - $P_3$ recibe el riñón de $D_1$.
  - Los pares $\{1, 2, 3\}$ han obtenido su máxima opción disponible, se ejecutan las cirugías y son retirados del registro.

#### 2. Ronda 2 y Resultado Final
- **Pares restantes:** Únicamente el par $(P_4, D_4)$.
- Como los donantes $D_1, D_2, D_3$ ya donaron y salieron del mercado, $P_4$ no cuenta con ningún donante compatible disponible.
- Por tanto, $P_4$ se apunta a sí mismo / a su propio donante: $P_4 \to D_4 \to P_4$ (ciclo degenerado de tamaño 1).
- **Balance del Mercado:**
  - 3 pacientes incompatibles recibieron trasplantes exitosos gracias al mecanismo cooperativo.
  - $P_4$ permanece sin trasplante (debe esperar futuros ingresos al registro o donantes cadavéricos en lista de espera tradicional).
  - La asignación es **Pareto-eficiente**: ningún paciente podría mejorar sin empeorar a otro.

#### 3. Cadenas Altruistas vs. Ciclos Cerrados
- **La restricción de simultaneidad en ciclos cerrados:** En un ciclo como $P_1 \leftrightarrow P_2$, si el donante $D_1$ dona por la mañana pero el donante $D_2$ se niega a donar por la tarde, el paciente $P_2$ queda sin riñón y sin su donante protector. Dado que la ley prohíbe exigir judicialmente la donación forzada de un órgano, todas las cirugías de un ciclo deben realizarse **exactamente al mismo tiempo**. Esto satura los quirófanos y equipos de trasplante (un ciclo de 3 vías requiere 6 quirófanos simultáneos).
- **La ventaja de los Donantes No Dirigidos (Cadenas Abiertas):**
  - Un donante altruista entrega su riñón al paciente $P_A$ sin exigir nada a cambio.
  - El donante $D_A$ queda entonces como un donante disponible para el siguiente paciente $P_B$, iniciando una **cadena secuencial**.
  - Si un participante en la cadena se retracta en el futuro, ningún paciente previo ha sido perjudicado (ya recibieron su riñón).
  - Esto permite realizar los trasplantes de manera asincrónica a lo largo de semanas o meses, expandiendo las cadenas hasta alcanzar récords de más de 30 a 60 trasplantes a partir de un solo donante inicial (*Never Ending Altruistic Donor Chains*).

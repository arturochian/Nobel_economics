# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2018: William D. Nordhaus y Paul M. Romer

> **Nota pedagógica confidencial:** Este documento contiene las resoluciones analíticas, derivaciones formales y notas docentes para la guía de ejercicios de `estudiante/ejercicios.qmd`. Está diseñado exclusivamente para la labor de cátedra y evaluación universitaria.

---

### Solución Ejercicio 1 (La Controversia del Descuento Intergeneracional: Nordhaus vs. Stern)

1. **Comparación Cuantitativa de Escenarios:**
   - **Resultados en 2020:** 
     - Según la tabla generada en `replicacion/salidas/tab_dice_escenarios_carbono.csv`:
       - Escenario Nordhaus Óptimo ($r = 4.25\%$): $SCC_{2020} = \$44.1 \text{ USD / tCO}_2$.
       - Escenario Stern Ético ($r = 1.40\%$): $SCC_{2020} = \$520.7 \text{ USD / tCO}_2$.
     - **Ratio:** $\frac{520.7}{44.1} \approx 11.8 \text{ veces mayor}$.
   - **Cálculo del Valor Presente ($PV$) a 100 años (daño de USD 1 billón / $10^{12}$ en 2120):**
     - Bajo la tasa de Nordhaus ($r = 4.25\%$):
       $$PV_{\text{Nordhaus}} = \frac{1,000,000,000,000}{(1 + 0.0425)^{100}} = \frac{10^{12}}{64.082} \approx \$15,605 \text{ millones de USD} \quad (\approx \$15.6 \text{B})$$
     - Bajo la tasa de Stern ($r = 1.40\%$):
       $$PV_{\text{Stern}} = \frac{1,000,000,000,000}{(1 + 0.0140)^{100}} = \frac{10^{12}}{4.032} \approx \$248,016 \text{ millones de USD} \quad (\approx \$248.0 \text{B})$$
     - **Interpretación:** Un daño distante en el siglo XXII vale casi **16 veces más** en el presente bajo la tasa de Stern que bajo la tasa de Nordhaus. Esto ilustra matemáticamente por qué el supuesto de la tasa de descuento es la variable más determinante en la economía del cambio climático.

2. **Debate Normativo vs. Positivo:**
   - **Postura ética de Stern (Enfoque Prescriptivo):** Se fundamenta en Frank Ramsey (1928): descontar el bienestar de personas que aún no han nacido únicamente por el hecho de nacer en una fecha posterior es éticamente injustificable ("una debilidad de la imaginación humana"). Por ende, fija la tasa pura de preferencia temporal $\rho \approx 0.1\%$ anual (solo reconociendo una probabilidad infinitesimal de extinción de la especie humana).
   - **Postura empírica de Nordhaus (Enfoque Descriptivo):** La tasa de descuento de las políticas públicas debe coincidir con la tasa real de retorno del capital observada en los mercados financieros ($r \approx 4-5\%$). Nordhaus señala dos objeciones cruciales a Stern:
     1. *Justicia distributiva intertemporal:* Dado que el crecimiento económico per cápita es positivo ($g > 0$), las generaciones futuras serán considerablemente más ricas que la generación actual. Forzar a los ciudadanos presentes (más pobres) a sacrificios monumentales para beneficiar a descendientes multimillonarios viola principios elementales de equidad distributiva.
     2. *Inconsistencia en la asignación del capital público:* Si un gobierno utiliza una tasa artificial del $1.4\%$ para justificar proyectos climáticos pero exige un retorno de mercado del $5\%$ para construir hospitales, erradicar la desnutrición infantil o invertir en agua potable en países en desarrollo, estará desviando recursos escasos desde proyectos de altísima rentabilidad social inmediata hacia proyectos con retornos muy inferiores y lejanos.

---

### Solución Ejercicio 2 (Bienes No Rivales, Teorema de Euler y Falla de la Competencia Perfecta)

1. **Demostración de Rendimientos Crecientes a Escala:**
   - Por hipótesis, la función es homogénea de grado 1 en los factores rivales:
     $$F(\lambda K, \lambda L, A) = \lambda F(K, L, A)$$
   - Dado que el conocimiento técnico tiene producto marginal estrictamente positivo ($\frac{\partial F}{\partial A} > 0$), si multiplicamos también el stock de ideas no rivales por $\lambda > 1$:
     $$F(\lambda K, \lambda L, \lambda A) > F(\lambda K, \lambda L, A) = \lambda F(K, L, A)$$
   - Por definición, $F(\lambda K, \lambda L, \lambda A) > \lambda F(K, L, A)$, lo que demuestra formalmente que la función de producción exhibe **rendimientos crecientes a escala** en el conjunto de todos sus factores $(K, L, A)$.

2. **El Teorema de Euler y la Incompatibilidad con la Competencia Perfecta:**
   - En una economía perfectamente competitiva donde los factores se pagan a su producto marginal:
     $$\text{Gasto en factores rivales} = r K + w L = \frac{\partial Y}{\partial K} K + \frac{\partial Y}{\partial L} L = Y$$
   - Por el Teorema de Euler para funciones linealmente homogéneas en $(K, L)$, el total de la producción $Y$ se agota exactamente remunerando al capital y al trabajo.
   - **El remanente es cero:** No queda ningún excedente económico para remunerar a los científicos, ingenieros o empresas que financiaron los costos fijos de investigar y diseñar la tecnología $A$.
   - **Conclusión de Romer:** Para que exista investigación deliberada con fines de lucro dentro del mercado descentralizado, las empresas innovadoras deben cobrar un precio por encima del costo marginal ($P > MC$) a través de poder de monopolio temporal (patentes, propiedad intelectual). La competencia perfecta no puede explicar el progreso técnico endógeno.

3. **Costo Marginal Cero y el Dilema de Eficiencia:**
   - **Costo marginal nulo ($MC \approx 0$):** Una vez sintetizada la molécula o compilado el código binario de un modelo de inteligencia artificial, el costo de suministrar una dosis o copia adicional es prácticamente cero.
   - **El dilema de bienestar:**
     - *Eficiencia estática:* Para maximizar el bienestar a corto plazo, el precio debería ser igual al costo marginal ($P = MC = 0$), garantizando el libre acceso de toda la humanidad.
     - *Eficiencia dinámica:* Si el precio es cero, los ingresos son nulos y ninguna firma invertirá los miles de millones de costos hundidos ($FC$) necesarios para generar la innovación original.
     - Las patentes resuelven imperfectamente este dilema concediendo un monopolio temporal ($P > MC$), permitiendo recuperar la inversión pero generando una pérdida de peso muerto transitoria.

---

### Solución Ejercicio 3 (Reto de Política Pública: Impuesto al Carbono vs. Subsidio a la Innovación Limpia)

1. **Por qué la Política A (Solo Impuesto al Carbono) es Insuficiente y Políticamente Costosa:**
   - Si no existen tecnologías limpias maduras y accesibles, la elasticidad-precio de la demanda de combustibles fósiles es casi inelástica en el corto plazo.
   - Para inducir abatimiento significativo, el impuesto tendría que ser astronómicamente alto desde el primer año, provocando inflación energética severa, rechazo social violento (por ejemplo, el movimiento de los *chalecos amarillos* en Francia) y pérdidas de competitividad industrial.
   - El impuesto corrige la externalidad climática negativa de Nordhaus, pero no corrige la externalidad positiva de derrame tecnológico (*spillover*) de Romer en el desarrollo de baterías o paneles solares.

2. **Por qué la Política B (Solo Subsidios a la I+D Verde) es Insuficiente:**
   - Abaratar las tecnologías renovables expande la oferta energética, pero si quemar carbón y gas sigue siendo gratuito en términos de daño atmosférico, las plantas térmicas ya construidas seguirán funcionando mientras su costo marginal operativo sea inferior al costo total de nuevas inversiones.
   - Puede surgir además la *paradoja de Jevons* o efecto rebote: energías limpias más baratas incrementan la demanda agregada de energía sin garantizar la clausura rápida de las fuentes contaminantes existentes.

3. **Conexión en el Código de Simulación:**
   - En `modelo_dice_y_romer.R`, el progreso técnico en emisiones está representado por la reducción de la intensidad de carbono $\sigma_t = \sigma_0 (1 - g_\sigma)^t$.
   - En el modelo de Romer, la tasa de descubrimiento $g = \delta s_A H$ responde a la masa de investigadores. Un subsidio específico a la I+D verde reasigna científicos calificados hacia el sector limpio, aumentando $g_\sigma$ de un $1.5\%$ tendencial a más del $3.5\%$ anual, reduciendo drásticamente la curva convexa de costos de abatimiento $\Lambda(\mu)$.

4. **El "Doble Dividendo" y Reciclaje Fiscal Óptimo:**
   - La arquitectura de política óptima recomendada por la literatura moderna (Acemoglu, Aghion, Bursztyn & Hemous 2012; Nordhaus 2013) combina ambos instrumentos de forma sinérgica:
     $$\text{Ingresos del Impuesto al Carbono} = \tau_{\text{Nordhaus}} \times \text{Emisiones}$$
   - En lugar de destinar la recaudación al gasto corriente, el Estado recicla estos ingresos hacia:
     1. Un fondo fiduciario de subsidios a la investigación básica y premios a patentes limpias de código abierto (resolviendo el fallo de Romer).
     2. Transferencias de suma fija (*dividendo ciudadano del carbono*) a familias de menores ingresos para neutralizar la regresividad del impuesto.
   - Este esquema es presupuestariamente neutral, socialmente progresivo y tecnológicamente acelerador.

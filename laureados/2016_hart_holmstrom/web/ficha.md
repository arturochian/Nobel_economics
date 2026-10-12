---
anio: 2016
slug: 2016_hart_holmstrom
laureados: ["Oliver Hart", "Bengt Holmström"]
motivacion_oficial: "for their contributions to contract theory"
area: ["Microeconomía", "Teoría de Contratos", "Gobierno Corporativo"]
tags: ["contratos incompletos", "derechos de propiedad", "modelo principal-agente", "principio de informatividad", "incentivos multitarea", "remuneración ejecutiva"]
referencias_clave: ["holmstrom1979moral", "grossman1986costs", "holmstrom1991multitask", "hart1990property", "hart1995firms", "hart1997proper", "nobel2016scientific"]
replicacion: "laureados/2016_hart_holmstrom/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Oliver Hart y Bengt Holmström transformaron la comprensión de las instituciones económicas modernas al crear las herramientas teóricas para descifrar cómo diseñar contratos óptimos bajo riesgo moral e incertidumbre, y cómo la asignación de la propiedad y el control resuelve las inevitables lagunas de los acuerdos en un mundo imperfecto.

## Resumen de la investigación
Las economías de mercado funcionan articuladas por una densa red de relaciones contractuales: desde el vínculo laboral entre una compañía y sus empleados hasta las pólizas de seguros, los acuerdos de suministro entre proveedores y fabricantes, y la concesión de infraestructura estatal a empresas privadas. A pesar de su ubicuidad, hasta los años setenta la ciencia económica trataba a la empresa como una "caja negra" que combinaba insumos mecánicamente bajo el supuesto implícito de que todos los acuerdos podían redactarse y ejecutarse sin fricción.

Bengt Holmström y Oliver Hart demostraron que los contratos reales están condicionados por dos límites estructurales irreductibles: la **información asimétrica** y la **incompletitud contractual**.

A finales de la década de 1970 y principios de los noventa, **Bengt Holmström** reformuló la teoría del principal-agente. Descubrió el **Principio de Informatividad**: el salario o bono de un empleado debe vincularse a cualquier variable que aporte información sobre su esfuerzo no observable, pero debe purgarse rigurosamente de cualquier ruido o choque que esté fuera de su control. Más tarde, junto a Paul Milgrom, Holmström descubrió el fenómeno de la **multitarea** (*multitasking*): cuando los trabajadores deben equilibrar tareas cuantificables (como el volumen de ventas) con tareas cualitativas esenciales pero difíciles de medir (como la calidad del servicio o el mantenimiento del capital), remunerar agresivamente la métrica medible provoca que el trabajador desatienda o destruya la dimensión cualitativa. Por tanto, en muchas organizaciones es socialmente óptimo ofrecer salarios fijos con incentivos débiles.

A mediados de los años ochenta, **Oliver Hart** (junto a Sanford Grossman y John Moore) desarrolló la **teoría de los contratos incompletos** y el enfoque de los derechos de propiedad (*Property Rights Theory* - GHM). Hart argumentó que debido a la complejidad del mundo y a los costos de transacción, es imposible redactar un contrato que contemple todas las contingencias futuras. Ante eventos no previstos, surge la pregunta de quién decide: la titularidad de los activos físicos otorga los **derechos residuales de control** (*residual rights of control*). Hart demostró que la propiedad debe asignarse a la parte cuya inversión específica de capital humano sea más decisiva para el éxito del proyecto, sentando las bases científicas para entender qué empresas deben fusionarse, cuándo recurrir a la integración vertical y qué servicios públicos (como prisiones o escuelas) nunca deberían privatizarse.

## Metodología y resultados
1. **El Modelo LEN y el Principio de Informatividad (Holmström, 1979):**
   Holmström formalizó la relación entre un principal neutral al riesgo y un agente adverso al riesgo (con aversión CARA $r$ y costo de esfuerzo $C(e) = \frac{1}{2}ke^2$) bajo el marco Lineal-Exponencial-Normal:
   $$\beta^* = \frac{1}{1 + r k \sigma_y^2}$$
   Demostró que el poder del incentivo $\beta^*$ disminuye con la varianza del ruido ambiental $\sigma_y^2$ y con la aversión al riesgo $r$. Si existe una señal informativa externa de mercado $z$ correlacionada con los choques sectoriales ($\rho$), el principal debe implementar la Evaluación de Desempeño Relativo (*Relative Performance Evaluation* - RPE):
   $$\sigma_{\text{resid}}^2 = \sigma_y^2(1 - \rho^2) \implies \beta^*_{\text{RPE}} = \frac{1}{1 + r k \sigma_y^2(1 - \rho^2)} > \beta^*$$
   Filtrar el ruido de la industria reduce la prima de riesgo exigida por el directivo y eleva el esfuerzo y el excedente social total.

2. **Incentivos Multitarea y Preservación de la Calidad (Holmström y Milgrom, 1991):**
   En puestos con esfuerzo multidimensional (cantidad $e_1$ medible vs. calidad $e_2$ inobservable) y sustituibilidad de recursos ($\gamma > 0$):
   $$e_1(\beta_1) = \frac{c_2 \beta_1}{c_1 c_2 - \gamma^2}, \qquad e_2(\beta_1) = -\frac{\gamma \beta_1}{c_1 c_2 - \gamma^2}$$
   Un esquema agresivo de pago por piezas o metas cuantitativas provoca la canibalización del esfuerzo en calidad. Holmström y Milgrom justificaron matemáticamente por qué profesiones críticas (docentes, jueces, policías) deben percibir sueldos planos sin bonos por rendimiento a corto plazo.

3. **Contratos Incompletos y Derechos Residuales de Control (Grossman y Hart, 1986; Hart y Moore, 1990):**
   Hart y sus coautores demostraron que cuando las inversiones ex-ante en capital humano $i_B$ e $i_S$ no son contractuales y las partes renegocian ex-post según la solución de Nash, la asignación del activo confiere poder de negociación:
   $$i_B^* = \frac{1}{2}(1 + \lambda_B) A_B \quad (\text{si } B \text{ es dueño}), \qquad i_B^* = \frac{1}{2} A_B \quad (\text{si } S \text{ es dueño})$$
   La propiedad del activo físico resuelve el dilema del chantaje (*hold-up problem*): debe otorgarse a la parte cuya inversión sea más inelástica o crítica para la creación de valor conjunto.

4. **Límites de la Privatización y Bienes Públicos (Hart, Shleifer y Vishny, 1997):**
   Al aplicar el marco a la prestación de servicios esenciales, Hart probó que un operador privado tiene incentivos muy fuertes para introducir reducciones de costes no contratables que deterioran la calidad social no observable (salubridad carcelaria, rehabilitación de presos, trato humanitario). La provisión pública directa es superior siempre que los recortes de gastos comprometan gravemente la misión pública.

## Antes y después

### Antes
- **La empresa neoclásica como función de producción abstracta:** La economía trataba a las corporaciones como cajas negras regidas únicamente por curvas de costos y precios, sin explicar por qué existen jerarquías internas ni qué determina los límites de una compañía frente al mercado.
- **Fe ciega en el pago por desempeño unidimensional:** Se asumía de forma ingenua que vincular la paga de cualquier trabajador o ejecutivo directamente a una métrica observable siempre elevaba la eficiencia económica.
- **Presunción de contratos completos:** La literatura formal suponía que las partes podían redactar acuerdos exhaustivos que cubrieran cualquier contingencia mediante tribunales infalibles.
- **Ola de privatizaciones sin marco analítico:** Durante las décadas de 1980 y 1990, las decisiones de privatizar prisiones, hospitales o escuelas se debatían bajo posturas ideológicas binarias, sin un marco microeconómico sobre la contractibilidad de la calidad.

### Después (qué cambió gracias al aporte)
- **Fundación de la teoría moderna del gobierno corporativo y de la empresa:** Los derechos residuales de control se consolidaron como el criterio universal para entender fusiones, adquisiciones, capital de riesgo y la estructura financiera de las organizaciones.
- **Diseño sofisticado de remuneración ejecutiva:** Se popularizó el uso de compensaciones ajustadas por benchmarking relativo de mercado (RPE) y se comprendió el peligro sistémico de los bonos basados en ganancias contables de corto plazo.
- **Arquitectura de puestos de trabajo e incentivos equilibrados:** Las empresas y entidades públicas entendieron por qué los incentivos monetarios de alta potencia son dañinos en actividades complejas y colaborativas, justificando el rol de la motivación intrínseca y los salarios fijos.
- **Criterio riguroso para la provisión pública vs. privada:** La doctrina Hart-Shleifer-Vishny se convirtió en el estándar técnico internacional para determinar qué servicios deben permanecer bajo administración estatal y cuáles pueden concesionarse eficientemente al sector privado.

## Cómo se aplica hoy

1. **Regulación de Remuneración Ejecutiva y Métricas Relativas de la SEC (2022):**
   En agosto de 2022, la Comisión de Bolsa y Valores de EE. UU. (SEC) adoptó la regla final sobre *"Pay Versus Performance"* derivada de la ley Dodd-Frank ([SEC Final Rule: Pay Versus Performance](https://www.sec.gov/rules/final/2022/34-95607.pdf)). La normativa exige a las corporaciones cotizadas desglosar la relación entre la retribución ejecutiva y el Retorno Total para el Accionista (TSR) en comparación con un índice de pares de la industria, aplicando directamente el **Principio de Informatividad de Holmström (1979)** para evitar que los ejecutivos reciban primas millonarias derivadas de simples vientos de cola del ciclo económico general (*pay for luck*).

2. **Reversión de la Privatización de Prisiones Federales en EE. UU. (Orden Ejecutiva 14006, 2021):**
   En enero de 2021, el presidente de los Estados Unidos emitió la [Orden Ejecutiva 14006](https://www.whitehouse.gov/briefing-room/presidential-actions/2021/01/26/executive-order-on-reforming-our-incarceration-system-to-eliminate-the-use-of-privately-operated-criminal-detention-facilities/), instruyendo al Departamento de Justicia a rescindir todos los contratos con prisiones privadas operadas con fines de lucro. El Departamento de Justicia citó auditorías de la Oficina del Inspector General que documentaron que las cárceles privadas presentaban mayores tasas de violencia, peores condiciones sanitarias y menos personal capacitado debido a recortes de costos no supervisables, validando empíricamente la predicción central del modelo de **Hart, Shleifer y Vishny (1997)** sobre la degradación de calidad no contractible.

3. **Integración Vertical y Soberanía Tecnológica en la Cadena de Suministro (Apple, Tesla y la IA, 2023–2024):**
   Las decisiones de gigantes tecnológicos como Apple (al desarrollar sus propios chips de la serie M y silicio para IA en lugar de comprarlos a Intel) o Tesla (al integrar internamente la fundición a presión *Gigacasting* y la arquitectura de sus baterías) se analizan bajo el modelo **Grossman-Hart-Moore (1986, 1990)** de derechos de propiedad. Al retener el control exclusivo sobre el diseño físico y el software central, estas compañías evitan el riesgo de chantaje tecnológico (*hold-up*) de proveedores externos y preservan sus incentivos para realizar inversiones masivas y no recuperables en I+D ([Apple Silicon Transition Case Study - Harvard Business Review](https://hbr.org/2020/11/apples-silicon-revolution)).

## Replicación en R
- **Qué se replicó:** Simulación microeconómica ilustrativa de tres pilares de la teoría:
  1. El equilibrio del modelo LEN de Holmström (1979) evaluando el trade-off entre riesgo e incentivos y la ganancia en bienestar derivada del Principio de Informatividad y la Evaluación de Desempeño Relativo (RPE).
  2. El modelo multitarea de Holmström y Milgrom (1991), cuantificando la canibalización de la calidad inobservable ante pagos agresivos por cantidad.
  3. La frontera de asignación óptima de la propiedad de activos de Grossman y Hart (1986), evaluando la decisión de integración vertical según la importancia relativa del capital humano.
- **Entorno de ejecución:** Script autónomo [modelo_teoria_contratos.R](../replicacion/R/modelo_teoria_contratos.R) ejecutado con R 4.6.0 (`tidyverse`, `scales`, `patchwork`).
- **Principales hallazgos cuantitativos:**
  - En el modelo de riesgo-incentivos, un incremento en la volatilidad de $\sigma_y^2 = 0.5$ a $\sigma_y^2 = 3.0$ reduce el incentivo óptimo $\beta^*$ de $66.7\%$ a $25.0\%$. Incorporar una señal de mercado correlacionada al $85\%$ ($\rho = 0.85$) purga el ruido, restituyendo el incentivo a $54.6\%$ y duplicando con creces el excedente social (de $0.125$ a $0.332$).
  - En el modelo multitarea con sustituibilidad $\gamma = 0.7$, un incentivo agresivo de $\beta_1 = 1.0$ colapsa el esfuerzo de calidad a cero ($e_2 = 0.0$), reduciendo el excedente total a $0.710$. Un esquema amortiguado ($\beta_1 = 0.35$) restaura el equilibrio ($e_2 = 0.72$) elevando el bienestar a $1.492$.
  - En la frontera de propiedad de Hart, cuando la elasticidad del comprador es alta ($\theta = 0.80$), la integración bajo control del comprador genera un excedente de $0.925$ frente a $0.794$ si el activo se asigna al proveedor de forma equivocada.
- **Limitaciones:** El modelo asume preferencias lineales CARA-Normal y reparto de Nash simétrico; en mercados reales intervienen fricciones financieras y asimetrías de información dinámicas.

## Para profundizar
- Holmström, B. (1979). *Moral Hazard and Observability*. The Bell Journal of Economics, 10(1), 74-91 [@holmstrom1979moral].
- Grossman, S. J., & Hart, O. D. (1986). *The Costs and Benefits of Ownership: A Theory of Vertical and Lateral Integration*. Journal of Political Economy, 94(4), 691-719 [@grossman1986costs].
- Holmström, B., & Milgrom, P. (1991). *Multitask Principal-Agent Analyses: Incentive Contracts, Asset Ownership, and Job Design*. Journal of Law, Economics, & Organization, 7, 24-52 [@holmstrom1991multitask].
- Hart, O., & Moore, J. (1990). *Property Rights and the Nature of the Firm*. Journal of Political Economy, 98(6), 1119-1158 [@hart1990property].
- Hart, O., Shleifer, A., & Vishny, R. W. (1997). *The Proper Scope of Government: Theory and an Application to Prisons*. The Quarterly Journal of Economics, 112(4), 1127-1160 [@hart1997proper].
- Royal Swedish Academy of Sciences (2016). *Contract Theory*. Scientific Background on the Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 2016 [@nobel2016scientific].

---
anio: 2001
slug: 2001_akerlof_spence_stiglitz
laureados: ["George A. Akerlof", "A. Michael Spence", "Joseph E. Stiglitz"]
motivacion_oficial: "for their analyses of markets with asymmetric information"
area: ["Microeconomía", "Economía de la Información", "Economía Financiera"]
tags: ["información asimétrica", "selección adversa", "señalización", "screening", "mercado de limones", "racionamiento de crédito"]
referencias_clave: ["akerlof1970lemons", "spence1973signaling", "rothschild1976equilibrium", "stiglitz1981credit", "shapiro1984equilibrium", "nobel2001scientific"]
replicacion: "laureados/2001_akerlof_spence_stiglitz/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
George Akerlof, Michael Spence y Joseph Stiglitz demolieron el postulado clásico de que los precios coordinan perfectamente la economía al demostrar que cuando una parte sabe más que la otra, los mercados pueden colapsar, discriminar o racionar recursos, transformando para siempre el diseño de los contratos, las finanzas y las políticas públicas.

## Resumen de la investigación
Durante casi dos siglos, la teoría económica dominante asumió que los mercados operaban con información simétrica y transparente: compradores y vendedores conocían con exactitud la calidad de los productos, la habilidad de los trabajadores y el riesgo de las inversiones. Bajo esta premisa, la "mano invisible" de Adam Smith y el equilibrio general de Arrow-Debreu garantizaban que los precios se ajustaran libremente para vaciar la oferta y la demanda de forma socialmente óptima.

En la década de 1970, George A. Akerlof, A. Michael Spence y Joseph E. Stiglitz transformaron la disciplina al fundar la **economía de la información asimétrica**:

1. **George Akerlof (1970) y la Selección Adversa (*Adverse Selection*):** En su célebre artículo sobre el mercado de automóviles usados ("The Market for 'Lemons'"), Akerlof demostró que cuando los compradores no pueden verificar la calidad previa, sólo están dispuestos a pagar según la calidad promedio esperada. Como consecuencia, los propietarios de vehículos de alta calidad ("cerezas") se niegan a vender a precios tan bajos y retiran sus autos del mercado. Esta salida deprime aún más la calidad promedio, provocando un desmoronamiento acumulativo (*market unraveling*) que puede destruir completamente el intercambio comercial, incluso cuando existen enormes ganancias potenciales del comercio.
2. **Michael Spence (1973) y la Señalización (*Job Market Signaling*):** Spence analizó cómo los agentes informados pueden superar la desconfianza del mercado emitiendo señales costosas y observables. En el mercado laboral, demostró que la educación no necesita mejorar las competencias del trabajador para ser valiosa: si adquirir un título universitario resulta sistemáticamente más costoso o difícil para individuos con menor talento intrínseco (condición de *Single-Crossing* de Spence-Mirrlees), las empresas pueden utilizar la credencial educativa como un filtro creíble para distinguir y remunerar el talento.
3. **Joseph Stiglitz (1976, 1981) y el Filtrado (*Screening*):** Stiglitz abordó el problema desde la perspectiva del lado desinformado del mercado. Junto a Michael Rothschild (1976), formuló la teoría de contratos autoselectivos en seguros, donde las compañías ofrecen un menú de opciones (bajas primas con altos deducibles para clientes prudentes vs. cobertura completa con altas primas para clientes de alto riesgo). Junto a Andrew Weiss (1981), descubrió el fenómeno del **racionamiento de crédito**: los bancos no pueden subir la tasa de interés para vaciar la demanda insatisfecha porque las tasas altas expulsan a los prestatarios solventes (selección adversa) e incentivan proyectos temerarios (riesgo moral), haciendo óptimo rechazar solicitudes de crédito solventes.

## Metodología y resultados
1. **El Teorema del Colapso de Mercado de Akerlof (1970):**
   Considerando un mercado con calidad $q \sim \mathcal{U}[0, 100]$, valoración del vendedor $V_S(q) = q$ y valoración del comprador $V_B(q) = \alpha q$ con $\alpha > 1$. Al precio $P$, la calidad promedio en oferta es $\bar{q}(P) = P/2$. La disposición a pagar de los compradores neutrales al riesgo es:
   $$\text{WTP}(P) = \alpha \frac{P}{2}$$
   El equilibrio competitivo exige $P = \frac{\alpha}{2} P \implies P(1 - \alpha/2) = 0$. Si $\alpha < 2$ (las ganancias del comercio son moderadas), el único equilibrio factible es $P^* = 0$. El mercado colapsa por completo y el volumen de transacciones se reduce a cero, extinguiendo el excedente social.

2. **Señalización Laboral y Condición de Single-Crossing de Spence (1973):**
   Con dos tipos de trabajadores $\theta_L < \theta_H$ y costos de educación $C_L(e) = c_L e > C_H(e) = c_H e$, las curvas de indiferencia en el plano $(e, w)$ satisfacen la condición de cruce único:
   $$\left. \frac{dw}{de} \right|_{U_L} = c_L > c_H = \left. \frac{dw}{de} \right|_{U_H}$$
   Las empresas ofrecen un contrato escalonado con salario $\theta_H$ si $e \ge e^*$ y $\theta_L$ en caso contrario. El rango de equilibrios separadores está acotado por las restricciones de compatibilidad de incentivos:
   $$\frac{\theta_H - \theta_L}{c_L} \le e^* \le \frac{\theta_H - \theta_L}{c_H}$$
   El equilibrio de Riley ($e^* = \frac{\theta_H - \theta_L}{c_L}$) minimiza la sobreinversión en educación, pero impone una pérdida de bienestar social neta debido al costo improductivo de la señalización.

3. **Racionamiento de Crédito y Retorno Bancario de Stiglitz y Weiss (1981):**
   Bajo responsabilidad limitada de los prestatarios, un aumento en la tasa de interés contractual $r$ incrementa el umbral de retorno del proyecto necesario para solicitar crédito, provocando la retirada de proyectos seguros. La función de beneficio esperado del banco $\pi_B(r)$ presenta una concavidad estricta y alcanza un pico en una tasa óptima interna $r^*$:
   $$\left. \frac{d\pi_B(r)}{dr} \right|_{r = r^*} = 0 \quad \text{con } r^* < r_{\text{walrasiano}}$$
   Frente a un exceso de demanda de crédito, los bancos prefieren racionar cuantitativamente el préstamo mediante cupos antes que elevar la tasa de interés, invalidando el mecanismo clásico de vaciado de mercado.

## Antes y después

### Antes
- **Equilibrio Walrasiano infalible:** La microeconomía clásica asumía que el sistema de precios siempre coordinaba de manera eficiente la oferta y la demanda en todos los mercados bajo competencia perfecta.
- **La educación como acumulación de capital humano exclusivo:** Se entendía que los salarios más altos de los graduados universitarios reflejaban estrictamente los conocimientos técnicos adquiridos durante sus estudios.
- **La tasa de interés como precio de vaciado del dinero:** Se consideraba que la escasez de crédito se debía a rigideces nominales o regulaciones artificiales, y que la libre fijación de tasas de interés garantizaría el acceso al crédito de cualquier proyecto productivo.
- **Teoría de seguros sin riesgo moral ni selección adversa:** Las primas actuariales se consideraban transparentes y las fallas de cobertura se atribuían a la falta de liquidez o miopía de los consumidores.

### Después (qué cambió gracias al aporte)
- **Comprensión de las fallas estructurales de mercado:** La asimetría de información se consolidó como una de las causas primordiales de ineficiencia económica, justificando la intervención pública regulatoria.
- **Teoría de la señalización y el credencialismo:** Se formalizó el papel de las credenciales, marcas, títulos y auditorías como mecanismos estratégicos para mitigar la asimetría informativa, deslindando la función productiva de la señalizadora.
- **Diseño moderno de contratos y teoría del mecanismo (*Mechanism Design*):** Las aseguradoras y entidades financieras aprendieron a diseñar menús de contratos autoselectivos (screening) que inducen a los agentes a revelar su verdadero perfil de riesgo.
- **Macroeconomía del crédito y acelerador financiero:** El racionamiento de crédito de Stiglitz-Weiss se convirtió en el fundamento microeconómico del canal crediticio de la política monetaria y las crisis bancarias.

## Cómo se aplica hoy

1. **Regulación de Seguros de Salud y la Ley de Cuidado de Salud a Bajo Precio (Affordable Care Act - ACA, EE. UU., 2010–presente):**
   La prohibición de denegar pólizas por condiciones preexistentes expone a las aseguradoras privadas a una espiral destructiva de selección adversa (*death spiral* de Akerlof y Rothschild-Stiglitz): si solo los enfermos se aseguran, las primas suben, expulsando a los jóvenes sanos y colapsando el sistema. Para contrarrestar esta falla, la ley implementó el mandato de cobertura obligatoria y el programa federal de ajuste de riesgo (*Risk Adjustment Program* de los Centros de Servicios de Medicare y Medicaid, [CMS Risk Adjustment](https://www.cms.gov/marketplace/premium-adjustment-risk-adjustment)), que redistribuye fondos de las aseguradoras con afiliados sanos hacia aquellas con carteras de alto riesgo.

2. **Sistemas de Reputación Bilateral y Garantías en Plataformas Digitales (eBay, Airbnb y Uber, 2000–2024):**
   Las plataformas de economía colaborativa operan en entornos donde compradores y vendedores son anónimos, lo que generaría un colapso del mercado por incertidumbre de calidad. Siguiendo las recomendaciones de Akerlof, empresas como eBay introdujeron la "Garantía de Devolución de Dinero" (*Money Back Guarantee*) y sistemas de reputación verificada, mientras que Airbnb implementó depósitos de garantía y seguros de anfitrión ([Airbnb Host Guarantee Case Analysis](https://news.airbnb.com/aircover/)), convirtiendo la certificación y la señalización creíble en pilares de un comercio electrónico global de billones de dólares.

3. **Pruebas de Estrés Bancario y Regulación Prudencial de Liquidez (Reserva Federal y BCE, 2010–2024):**
   El modelo de racionamiento de crédito de Stiglitz y Weiss (1981) demostró que cuando el riesgo macroeconómico se intensifica, los bancos prefieren congelar el crédito a elevar las tasas de interés. Tras la crisis de 2008 y la quiebra de Silicon Valley Bank en 2023, la Junta de la Reserva Federal (FRB) y el Banco Central Europeo (BCE) aplican las directrices de Basilea III, exigiendo colchones de capital contracíclico y pruebas de estrés anuales ([Federal Reserve Dodd-Frank Act Stress Testing](https://www.federalreserve.gov/supervisionreg/dfa-stress-tests.htm)) para evitar que la selección adversa en el mercado interbancario paralice la transmisión del crédito a los sectores productivos.

## Replicación en R
- **Qué se replicó:** Simulación microeconómica integral de tres modelos fundacionales:
  1. El desmoronamiento y colapso iterativo del mercado de automóviles usados de Akerlof (1970) comparando la derivación teórica continua contra un experimento Monte Carlo con $5,000$ vehículos.
  2. El equilibrio de señalización laboral de Spence (1973), graficando las curvas de indiferencia bajo la condición de Single-Crossing, identificando la franja de equilibrios separadores $[e^*=10, e^*=20]$ y cuantificando la pérdida de bienestar social en el equilibrio de Riley.
  3. El mecanismo de screening y racionamiento de crédito de Stiglitz y Weiss (1981), contrastando el equilibrio con racionamiento frente a la tasa walrasiana.
- **Entorno de ejecución:** Script autónomo [mercados_informacion_asimetrica.R](../replicacion/R/mercados_informacion_asimetrica.R) ejecutado con R 4.6.0 (`tidyverse`, `scales`, `patchwork`).
- **Principales hallazgos cuantitativos:**
  - En el modelo de Akerlof con $\alpha = 1.35$, la disposición a pagar esperada $\mathbb{E}[V_B \mid P] = 0.675 P$ se sitúa permanentemente por debajo del precio exigido por los vendedores, provocando el colapso a $P^* = 0$ y una pérdida social del $100\%$ ($W = 0$ frente a $W^{FB} = 17.5$). La introducción de garantías técnicas a costo $c=2$ restituye el $88.6\%$ del excedente social ($W = 15.5$).
  - En el modelo de Spence con costos de educación $c_L = 1.0$ y $c_H = 0.5$, el equilibrio separador de Riley exige un umbral educativo de $e^* = 10$. Aunque permite remunerar al Tipo H con su productividad real ($w_H = 20$), impone una pérdida de bienestar social neta de $2.0$ unidades ($W = 12.0$ vs. $14.0$ en pooling) debido al costo de educarse como simple filtro señalizador.
- **Limitaciones:** Los modelos asumen agentes neutrales al riesgo y funciones de costo lineales; en mercados laborales empíricos la educación combina roles de acumulación de capital humano productivo y de señalización.

## Para profundizar
- Akerlof, G. A. (1970). *The Market for "Lemons": Quality Uncertainty and the Market Mechanism*. The Quarterly Journal of Economics, 84(3), 488–500 [@akerlof1970lemons].
- Spence, M. (1973). *Job Market Signaling*. The Quarterly Journal of Economics, 87(3), 355–374 [@spence1973signaling].
- Spence, A. M. (1974). *Market Signaling: Informational Transfer in Hiring and Related Screening Processes*. Harvard University Press [@spence1974market].
- Rothschild, M., & Stiglitz, J. E. (1976). *Equilibrium in Competitive Insurance Markets: An Essay on the Economics of Imperfect Information*. The Quarterly Journal of Economics, 90(4), 629–649 [@rothschild1976equilibrium].
- Stiglitz, J. E., & Weiss, A. (1981). *Credit Rationing in Markets with Imperfect Information*. The American Economic Review, 71(3), 393–410 [@stiglitz1981credit].
- Shapiro, C., & Stiglitz, J. E. (1984). *Equilibrium Unemployment as a Worker Discipline Device*. The American Economic Review, 74(3), 433–444 [@shapiro1984equilibrium].
- Royal Swedish Academy of Sciences (2001). *Markets with Asymmetric Information*. Scientific Background on the Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 2001 [@nobel2001scientific].

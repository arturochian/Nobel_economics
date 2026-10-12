---
anio: 2022
slug: 2022_bernanke_diamond_dybvig
laureados: ["Ben S. Bernanke", "Douglas W. Diamond", "Philip H. Dybvig"]
motivacion_oficial: "for research on banks and financial crises"
area: ["Economía Financiera", "Macroeconomía Bancaria"]
tags: ["corridas bancarias", "modelo Diamond-Dybvig", "seguro de depósitos", "acelerador financiero", "Gran Depresión", "intermediación financiera"]
referencias_clave: ["diamond_dybvig1983", "bernanke1983nonmonetary", "diamond1984delegated", "bernanke_gertler1989", "nobel2022scientific"]
replicacion: "laureados/2022_bernanke_diamond_dybvig/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Ben S. Bernanke, Douglas W. Diamond y Philip H. Dybvig sentaron las bases analíticas de la banca moderna al demostrar por qué la transformación de plazos hace a los bancos intrínsecamente vulnerables a corridas de pánico y cómo la destrucción del crédito bancario amplifica y perpetúa las peores catástrofes macroeconómicas.

## Resumen de la investigación
Antes de las investigaciones de los laureados a comienzos de la década de 1980, la profesión económica carecía de una teoría formal rigurosa sobre el papel fundamental de los intermediarios financieros en la economía. Muchos modelos macroeconómicos estándar trataban al sector financiero como un simple "velo" neutral: se suponía que los ahorros fluían sin fricciones hacia la inversión productiva mediante precios de mercado descentralizados.

Douglas W. Diamond y Philip H. Dybvig (1983) revolucionaron el campo al responder a una pregunta elemental: ¿por qué existen los bancos? Su respuesta mostró que la sociedad necesita reconciliar dos deseos en conflicto: los ahorristas desean tener liquidez disponible en cualquier momento ante emergencias imprevistas, mientras que las empresas necesitan financiamiento ilíquido de largo plazo para construir fábricas e infraestructura. Los bancos resuelven esta tensión mediante la transformación de plazos y maduración (*maturity transformation*), absorbiendo depósitos a la vista y concediendo préstamos a largo plazo. Sin embargo, Diamond y Dybvig descubrieron que esta valiosa función social crea una fragilidad estructural inevitable: la posibilidad de corridas bancarias (*bank runs*) impulsadas por profecías autocumplidas. Si los ahorristas temen que otros retirarán sus fondos, la mejor respuesta individual es correr al banco antes de que este se quede sin dinero, forzando la liquidación de préstamos productivos y provocando la quiebra de una entidad completamente solvente.

Por su parte, Ben S. Bernanke (1983) transformó la comprensión histórica de la Gran Depresión de la década de 1930. Frente a la ortodoxia monetarista de Milton Friedman y Anna Schwartz (que atribuía la depresión exclusivamente a una contracción de la oferta de dinero provocada por la Reserva Federal), Bernanke demostró que las quiebras bancarias masivas tuvieron un efecto no monetario devastador e independiente: destruyeron el capital informacional que los bancos acumulan sobre la solvencia de sus clientes locales (*delegated monitoring*, Diamond 1984). Al desaparecer los bancos, el costo de intermediación crediticia se disparó, provocando una congelación del crédito que convirtió una recesión ordinaria en la depresión económica más prolongada del siglo XX.

## Metodología y resultados
1. **El Modelo Diamond-Dybvig (1983) de Equilibrios Múltiples:**
   En un marco de teoría de juegos con tres periodos ($T=0, 1, 2$), agentes con choques idiosincráticos de liquidez y una regla de atención por orden de llegada (*sequential service constraint*), existen dos equilibrios de Nash:
   - *Equilibrio óptimo:* Solo retiran en $T=1$ los depositantes con necesidades reales de consumo; los proyectos maduran en $T=2$ con máxima eficiencia.
   - *Equilibrio de pánico:* Los depositantes pacientes anticipan que los demás retirarán, por lo que retiran preventivamente en $T=1$, destruyendo los activos ilíquidos.
   Diamond y Dybvig demostraron matemáticamente que una garantía estatal creíble (seguro de depósitos o prestamista de última instancia) elimina el equilibrio de pánico sin requerir gasto fiscal en equilibrio, pues anula el incentivo individual a retirar.

2. **Monitoreo Delegado (Diamond, 1984):**
   Diamond modeló cómo los bancos resuelven las asimetrías de información entre ahorristas y prestatarios mediante el monitoreo delegado (*delegated monitoring*). Al diversificar préstamos entre múltiples prestatarios, el banco minimiza los costos de verificación y ofrece contratos de deuda no contingentes que los inversionistas individuales no podrían replicar por sí mismos.

3. **El Canal de Crédito y el Acelerador Financiero (Bernanke 1983; Bernanke y Gertler 1989):**
   Bernanke y Mark Gertler formalizaron el mecanismo por el cual el deterioro del patrimonio neto bancario y corporativo incrementa la prima de financiamiento externo (*external finance premium*). Este canal crediticio no monetario actúa como un amplificador procíclico: pequeños shocks iniciales en la economía real provocan caídas desproporcionadas en el crédito y la inversión.

## Antes y después

### Antes
- **La banca como caja negra pasiva:** Los modelos de equilibrio general walrasianos y macroeconómicos asumían mercados de capitales perfectos (teorema de Modigliani-Miller generalizado); los bancos se consideraban meros pasamanos contables sin fricciones ni valor agregado distintivo.
- **Las corridas atribuidas a la irracionalidad colectiva:** Se consideraba que los pánicos bancarios eran arranques de locura psicológica o histeria de masas irracional, sin fundamentos de comportamiento optimizador individual.
- **La Gran Depresión vista como un shock puramente monetario:** Se sostenía que la crisis de los años 30 se explicaba exclusivamente por la reducción pasiva de $M1$ y la inacción de las autoridades de banca central en la emisión monetaria.

### Después (qué cambió gracias al aporte)
- **Fundamento microeconómico de la intermediación:** Se demostró analíticamente que la vulnerabilidad financiera no es un defecto accidental, sino una consecuencia matemática intrínseca de crear liquidez mediante descalce de plazos.
- **Equilibrios múltiples y racionalidad del pánico:** Se formalizó que participar en una corrida bancaria es una decisión estrictamente racional y óptima para un individuo si prevé que los demás correrán.
- **Prioridad macroprudencial y prestamista de última instancia:** Los bancos centrales y reguladores reorientaron su mandato para supervisar activamente la liquidez bancaria, las garantías de depósitos y la estabilidad del capital financiero para prevenir catástrofes reales.

## Cómo se aplica hoy

1. **Esquemas Modernos de Seguro de Depósitos (FDIC y Unión Europea):**
   El seguro de depósitos respaldado por el Estado es hoy la piedra angular de la estabilidad financiera internacional. En Estados Unidos, la *Federal Deposit Insurance Corporation* protege cuentas minoristas hasta 250.000 USD ([FDIC Deposit Insurance](https://www.fdic.gov/resources/deposit-insurance/)), mientras que en la Unión Europea la Directiva 2014/49/UE armoniza la garantía obligatoria de 100.000 EUR por depositante y entidad ([Comisión Europea - Directiva 2014/49/UE](https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:32014L0049)), neutralizando el incentivo a corridas minoristas en más de 27 países.

2. **Regulación Internacional de Liquidez de Basilea III (LCR y NSFR, 2013–presente):**
   Tras la crisis financiera global de 2008, el Comité de Basilea de Supervisión Bancaria introdujo por primera vez requerimientos cuantitativos explícitos de liquidez basados en los modelos de Diamond y Dybvig: el Coeficiente de Cobertura de Liquidez (*Liquidity Coverage Ratio*, LCR) exige mantener activos líquidos de alta calidad para resistir una corrida de 30 días, y el Coeficiente de Financiación Neta Estable (*Net Stable Funding Ratio*, NSFR) penaliza el descalce excesivo de plazos en el balance ([Bank for International Settlements - Basel III Liquidity Standards](https://www.bis.org/bcbs/publ/d238.htm)).

3. **Gestión de la Crisis de Silicon Valley Bank y Signature Bank (Marzo de 2023):**
   Cuando Silicon Valley Bank sufrió retiros no asegurados masivos de 42.000 millones de USD en menos de 24 horas a través de banca digital, la Reserva Federal, el Tesoro de EE.UU. y la FDIC aplicaron directamente el instrumental de Diamond-Dybvig y Bernanke. Invocaron la excepción de riesgo sistémico (*Systemic Risk Exception*) para garantizar la totalidad de los depósitos no asegurados y establecieron el programa *Bank Term Funding Program* (BTFP), prestando fondos contra bonos a valor nominal para frenar el colapso del crédito en el ecosistema tecnológico ([Federal Reserve Board - Joint Statement on SVB 2023](https://www.federalreserve.gov/newsevents/pressreleases/monetary20230312b.htm)).

## Replicación en R
- **Qué se replicó:** Simulación estructural de la matriz de pagos en el modelo de corridas de Diamond y Dybvig (1983) en función de la fracción de retiros $f$, determinación analítica del umbral crítico de pánico $f^*$, efecto de estabilización del seguro de depósitos y simulación del mecanismo del canal de crédito y acelerador financiero de Bernanke (1983) / Bernanke & Gertler (1989).
- **Con qué datos:** Parámetros calibrados estándar ($t = 0.25$, $R = 1.50$, $r_1 = 1.20$, $L = 1.0$).
- **Resultados obtenidos:** Se determinó que el equilibrio bueno opera en $f = 0.25$ con pagos $r_1 = 1.20$ y $r_2 = 1.40$. Si la fracción de retiros supera el umbral crítico $f^* = 0.50$, el retorno esperado por esperar colapsa por debajo de $1.20$, desencadenando la corrida bancaria inevitable hasta la quiebra en $f > 0.833$. La incorporación de la garantía de depósitos aplana el pago en $1.40$, erradicando completamente el equilibrio de pánico. En el canal de crédito, la contracción del patrimonio neto bancario eleva de forma no lineal la prima de financiamiento externo y estrangula el volumen crediticio disponible.
- **Limitaciones:** El modelo canónico no modela endógenamente la conducta de riesgo moral de los gestores bancarios ni la velocidad instantánea de las transferencias digitales contemporáneas.

## Para profundizar
- Diamond, D. W., & Dybvig, P. H. (1983). *Bank Runs, Deposit Insurance, and Liquidity*. `diamond_dybvig1983`.
- Bernanke, B. S. (1983). *Nonmonetary Effects of the Financial Crisis in the Propagation of the Great Depression*. `bernanke1983nonmonetary`.
- Diamond, D. W. (1984). *Financial Intermediation and Delegated Monitoring*. `diamond1984delegated`.
- Bernanke, B. S., & Gertler, M. (1989). *Agency Costs, Net Worth, and Business Fluctuations*. `bernanke_gertler1989`.
- The Royal Swedish Academy of Sciences (2022). *Financial Intermediation and Financial Crises (Scientific Background)*. `nobel2022scientific`.

---
anio: 2020
slug: 2020_milgrom_wilson
laureados: ["Paul R. Milgrom", "Robert B. Wilson"]
motivacion_oficial: "for improvements to auction theory and inventions of new auction formats"
area: ["Microeconomía", "Teoría de Juegos", "Diseño de Mercados"]
tags: ["subastas de valor común", "maldición del ganador", "subastas simultáneas de múltiples rondas", "SMRA", "asignación de espectro radioeléctrico", "principio de vinculación"]
referencias_clave: ["wilson1977bidding", "milgrom1982theory", "milgrom2000putting", "milgrom2004putting", "nobel2020scientific"]
replicacion: "laureados/2020_milgrom_wilson/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Paul R. Milgrom y Robert B. Wilson revolucionaron la teoría microeconómica al descifrar cómo la información privada y el valor común determinan el comportamiento estratégico en las subastas, diseñando nuevos formatos multironda que han asignado cientos de miles de millones de dólares en espectro radioeléctrico, energía y recursos públicos a nivel global.

## Resumen de la investigación
Las subastas son uno de los mecanismos más antiguos y universales de intercambio económico: determinan desde el precio de las emisiones de deuda soberana y la energía mayorista hasta los anuncios publicitarios en buscadores de internet. Sin embargo, durante siglos se gestionaron con formatos tradicionales (subasta inglesa ascendente, holandesa descendente o sobre cerrado) sin una comprensión formal de cómo interactúan la incertidumbre y la asimetría informativa.

En los modelos clásicos de valores privados independientes (formalizados por William Vickrey en 1961), cada participante conoce exactamente cuánto vale el bien para sí mismo. Robert Wilson demostró a finales de los años sesenta y setenta que muchos mercados clave del mundo real operan bajo **valor común**: el activo posee un valor objetivo idéntico para todos los competidores (como una reserva petrolífera submarina o una banda de frecuencias de telecomunicaciones), pero nadie conoce ese valor con certeza; cada participante solo dispone de estimaciones o señales ruidosas. Wilson descubrió que los postores que no ajustan sus ofertas sufren sistemáticamente la **maldición del ganador** (*winner's curse*): quien gana suele ser el que sobrestimó más el valor real, incurriendo en pérdidas catastróficas. Para evitarlo, los postores racionales reducen drásticamente sus posturas (*bid shading*).

Posteriormente, Paul Milgrom y Robert Weber (1982) generalizaron la teoría integrando componentes de valores privados y comunes mediante el concepto de **afiliación estadística**. Probaron el **Principio de Vinculación** (*Linkage Principle*): las subastas que revelan mayor información pública durante el proceso (como los formatos ascendentes dinámicos frente a los sobres cerrados) mitigan el temor a la maldición del ganador, incentivan ofertas más agresivas y generan mayores ingresos promedio para el vendedor.

En 1994, la Comisión Federal de Comunicaciones (FCC) de Estados Unidos enfrentó la tarea sin precedentes de asignar miles de licencias de telefonía móvil por todo el país. Los métodos tradicionales (sorteos o audiencias discrecionales) eran ineficientes o propensos a la corrupción. Milgrom y Wilson (junto con Preston McAfee) transformaron la teoría en ingeniería económica práctica al inventar la **Subasta Ascendente Simultánea de Múltiples Rondas** (*Simultaneous Multiple Round Auction* - SMRA). Al permitir que todas las licencias se pujaran al mismo tiempo en rondas sucesivas con reglas de cierre unificado y requisitos de actividad, resolvieron el **problema de exposición** (*exposure problem*) y sentaron las bases del diseño moderno de mercados.

## Metodología y resultados
1. **La Teoría del Valor Común y el Equilibrio de Wilson (1977):**
   Wilson formuló el primer análisis matemático riguroso de subastas competitivas con información asimétrica sobre un valor común $V$. Si cada participante observa una señal $X_i = V + \varepsilon_i$, la señal más alta $\max_i X_i$ es un estimador positivamente sesgado de $V$:
   $$\mathbb{E}\left[\max_{j=1,\dots,N} X_j \;\middle|\; V\right] = V + \varepsilon_0 \left(\frac{N - 1}{N + 1}\right)$$
   Wilson demostró que en el equilibrio de Nash-Bayes, los postores racionales descuentan este sesgo condicionando su puja no en $\mathbb{E}[V \mid X_i]$, sino en $\mathbb{E}[V \mid X_i, X_j \le X_i \ \forall j \neq i]$. A medida que aumenta el número de competidores $N$, el postor racional sombrea más su postura para protegerse del sesgo extremo del ganador.

2. **Afiliación de Información y el Principio de Vinculación (Milgrom y Weber, 1982):**
   Ampliaron el marco al permitir que las señales y valoraciones sean interdependientes y estadísticamente afiliadas. Su hallazgo central derrumbó la equivalencia de ingresos de Vickrey:
   $$\mathbb{E}[\text{Ingreso}_{\text{Ascendente}}] \ge \mathbb{E}[\text{Ingreso}_{\text{Segundo Precio Sellado}}] \ge \mathbb{E}[\text{Ingreso}_{\text{Primer Precio Sellado}}]$$
   En una subasta ascendente pública, ver a los rivales continuar pujando aporta información confiable de que sus señales también son optimistas, lo que disipa la incertidumbre del valor común y permite a los participantes pujar más cerca de su verdadero valor.

3. **Arquitectura de Mercados de la SMRA (1994):**
   Diseñaron un mecanismo de asignación multiobjeto con tres innovaciones estructurales:
   - *Simultaneidad y cierre unificado:* Todas las licencias cierran simultáneamente solo cuando no hay pujas en ninguna, permitiendo a los operadores armar redes complementarias (ej. regiones contiguas) sin temor a quedar atrapados en licencias aisladas.
   - *Reglas de actividad de Milgrom-Wilson:* Exigen mantener pujas activas en cada ronda proporcionales a la cuota elegible, impidiendo que operadores estratégicos esperen de forma oportunista (*sniping*) hasta el final.

## Antes y después

### Antes
- **Asignación discrecional y loterías arbitrarias:** Los gobiernos distribuían bienes de enorme valor público (como el espectro electromagnético) mediante "concursos de belleza" opacos, sujetos al cabildeo político, o mediante sorteos aleatorios que luego alimentaban mercados secundarios especulativos.
- **Teoría limitada a valores privados simples:** Los modelos económicos asumían que los bienes tenían un valor subjetivo conocido exclusivamente por cada individuo (paradigma de Vickrey), ignorando que en las transacciones más cuantiosas de la economía el valor es común y desconocido.
- **Quiebras recurrentes por la maldición del ganador:** En licitaciones petroleras, mineras y de concesiones de obras públicas, las empresas ganadoras caían con frecuencia en la bancarrota al descubrir que habían pagado un sobreprecio ruin derivado de errores de estimación.

### Después (qué cambió gracias al aporte)
- **Ingeniería económica y diseño de mercados:** La teoría de juegos pasó de ser un ejercicio abstracto en pizarrones a una disciplina aplicada capaz de programar mercados reales a gran escala (*Market Design*).
- **Adopción universal del formato SMRA y subastas de reloj:** Reguladores de telecomunicaciones de todos los continentes reemplazaron las concesiones arbitrarias por subastas ascendentes simultáneas, recaudando billones de dólares para las arcas públicas y maximizando la eficiencia asignativa.
- **Modelos de licitación en compras públicas y finanzas:** Las agencias estatales y los bancos de inversión rediseñaron sus plataformas de contratación y emisión de bonos reconociendo explícitamente la interdependencia informativa y las reglas de revelación de precios.

## Cómo se aplica hoy

1. **Subastas de Espectro 5G de la FCC y Reguladores Mundiales:**
   La Comisión Federal de Comunicaciones de EE. UU. continúa utilizando variantes de la SMRA y subastas de incentivos diseñadas por Milgrom. En 2021, la Subasta 107 de la FCC (banda C para telefonía móvil 5G) recaudó un récord histórico de más de \$81,000 millones de dólares asignando 5,684 licencias a operadores como Verizon y AT&T ([FCC Auction 107 Factsheet](https://www.fcc.gov/auction/107)). Formatos análogos son empleados regularmente por la Bundesnetzagentur en Alemania ([BNetzA Frequenzauktionen](https://www.bundesnetzagentur.de/DE/Fachthemen/Telekommunikation/Frequenzen/start.html)) y Ofcom en el Reino Unido.

2. **Mercados de Derechos de Emisión de Carbono (RCDE UE / EU ETS):**
   El Régimen de Comercio de Derechos de Emisión de la Unión Europea subasta cientos de millones de derechos de emisión de gases de efecto invernadero a través del European Energy Exchange (EEX) utilizando subastas periódicas a precio uniforme de valor común diseñadas para garantizar liquidez, evitar la manipulación de precios y reflejar el valor social del carbono ([Comisión Europea - EU ETS Auctioning](https://climate.ec.europa.eu/eu-action/eu-emissions-trading-system-eu-ets/auctioning_en)).

3. **Plataformas de Publicidad Digital en Tiempo Real (RTB / Google y Meta):**
   Las plataformas de intercambio publicitario (*Ad Exchanges*) ejecutan billones de micro-subastas diarias para adjudicar espacios en milisegundos. Basándose en los teoremas de Milgrom y Wilson sobre sombreado de pujas y valor común, en 2019 Google Ad Manager migró de un modelo de segundo precio a una subasta de primer precio (*first-price auction*), obligando a los algoritmos de compra programática a estimar el sesgo de selección adverso y aplicar algoritmos de sombreado bayesiano dinámico ([Google Ad Manager First-Price Transition](https://blog.google/products/admanager/rolling-out-first-price-auctions-google-ad-manager/)).

## Replicación en R
- **Qué se replicó:** Simulación de Monte Carlo ilustrativa del modelo bayesiano de valor común (Wilson 1977; Milgrom y Weber 1982) comparando postores ingenuos frente a postores racionales bayesianos a lo largo de diversos grados de competencia ($N \in [2, 30]$), así como la dinámica de rondas sucesivas de la Subasta Ascendente Simultánea (SMRA) con complementariedad espacial y reglas de actividad.
- **Datos y entorno:** Datos generados mediante simulación estocástica controlada con semilla fija (`set.seed(20201012)`), ejecutada en R con los paquetes `tidyverse`, `scales` y `patchwork`.
- **Resultados obtenidos:**
  - El modelo confirma que la puja ingenua incurre en pérdidas financieras netas a partir de $N = 3$, alcanzando un 99.6% de quiebras para $N = 10$ con pérdidas medias de -12.7 unidades monetarias por subasta.
  - La estrategia bayesiana de Wilson mantiene beneficios estrictamente positivos y cero pérdidas para todo $N$, sombreando la puja en consonancia con el orden estadístico condicional.
  - El algoritmo SMRA converge de forma ordenada en 15 rondas, resolviendo el problema de exposición y asignando las licencias al postor con sinergias agregadas superiores.
- **Limitaciones:** Asume ruidos de estimación independientes condicionales con distribución uniforme; en subastas reales de espectro, los postores enfrentan señales log-normales correlacionadas y posibles asimetrías de información interna (*insider information*).

## Para profundizar
- Wilson, R. (1977). *A Bidding Model of Perfect Competition*. The Review of Economic Studies, 44(3), 511-518 [@wilson1977bidding].
- Milgrom, P. R., & Weber, R. J. (1982). *A Theory of Auctions and Competitive Bidding*. Econometrica, 50(5), 1089-1122 [@milgrom1982theory].
- Milgrom, P. (2000). *Putting Auction Theory to Work: The Simultaneous Ascending Auction*. Journal of Political Economy, 108(2), 245-272 [@milgrom2000putting].
- Milgrom, P. (2004). *Putting Auction Theory to Work*. Cambridge University Press [@milgrom2004putting].
- Economic Sciences Prize Committee (2020). *Scientific Background: Improvements to Auction Theory and Inventions of New Auction Formats*. Royal Swedish Academy of Sciences [@nobel2020scientific].

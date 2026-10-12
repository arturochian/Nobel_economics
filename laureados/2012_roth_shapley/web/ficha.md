---
anio: 2012
slug: 2012_roth_shapley
laureados: ["Alvin E. Roth", "Lloyd S. Shapley"]
motivacion_oficial: "for the theory of stable allocations and the practice of market design"
area: ["Microeconomía", "Teoría de Juegos", "Diseño de Mercados"]
tags: ["asignaciones estables", "emparejamiento", "algoritmo Gale-Shapley", "aceptación diferida", "valor de Shapley", "donación cruzada de riñones", "matching de médicos y escuelas"]
referencias_clave: ["gale1962college", "shapley1953value", "roth1984evolution", "roth2004kidney", "roth2002engineer", "nobel2012scientific"]
replicacion: "laureados/2012_roth_shapley/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Lloyd S. Shapley sentó las bases matemáticas de las asignaciones estables y los juegos cooperativos, y Alvin E. Roth transformó esa teoría abstracta en ingeniería económica aplicada, rediseñando desde la asignación de médicos y plazas escolares hasta los registros nacionales de donación cruzada de riñones que salvan miles de vidas cada año.

## Resumen de la investigación
En la teoría económica tradicional, la asignación eficiente de recursos se logra casi invariablemente mediante el mecanismo de precios: la oferta y la demanda determinan un vector de precios monetarios que equilibra el mercado. Sin embargo, existen esferas cruciales de la vida social y económica donde los precios monetarios son impracticables, ilegales o moralmente inadmisibles. Nadie puede comprar un cupo para ingresar a una escuela pública prestigiosa, vender una vacante en un hospital de especialidades médicas o comercializar legalmente órganos humanos para trasplantes. En estos entornos, el problema económico consiste en lograr un **emparejamiento bilateral** (*two-sided matching*) armónico entre las preferencias de dos grupos independientes de agentes.

En 1962, David Gale y Lloyd Shapley publicaron un artículo seminal de apenas siete páginas en *The American Mathematical Monthly* titulado *"College Admissions and the Stability of Marriage"*. En él plantearon una pregunta puramente matemática: ¿es siempre posible emparejar a un grupo de hombres y mujeres (o estudiantes y universidades) de modo que ninguna pareja prefiera estar junta antes que con sus compañeros asignados? La respuesta fue afirmativa mediante el **algoritmo de aceptación diferida** (*Deferred Acceptance* - DA), probando que siempre existe al menos una asignación **estable**. En 1974, Shapley y Herbert Scarf ampliaron este marco a mercados con indivisibilidades y sin transferencias monetarias mediante el algoritmo **Top Trading Cycles** (TTC).

Dos décadas después, Alvin E. Roth descubrió que esta elegante teoría matemática tenía un vínculo asombroso con el mundo real. Al estudiar la historia del mercado laboral de médicos recién graduados en Estados Unidos (*National Resident Matching Program* - NRMP), Roth (1984) comprobó que dicho mercado había colapsado repetidamente en la primera mitad del siglo XX debido a ofertas precipitadas y desordenadas (*unraveling*). Para resolverlo, los directores de hospitales habían diseñado empíricamente en 1952 un algoritmo centralizado que resultó ser, matemáticamente, el algoritmo de aceptación diferida de Gale y Shapley antes de que fuera formalizado en la literatura teórica. Roth demostró formalmente que el éxito y la longevidad de un mercado de emparejamiento dependen críticamente de la **estabilidad** de sus asignaciones. A partir de esa revelación, Roth inauguró la **ingeniería de diseño de mercados** (*market design*), combinando teoría de juegos, algoritmos computacionales y experimentos de laboratorio para rediseñar sistemas de asignación educativa y fundar el intercambio moderno de órganos.

## Metodología y resultados
1. **El Algoritmo de Aceptación Diferida y Estabilidad (Gale y Shapley, 1962):**
   Gale y Shapley formalizaron el concepto de **par bloqueador** (*blocking pair*): un par $(d, h)$ bloquea una asignación $\mu$ si el médico $d$ prefiere $h$ sobre su hospital asignado $\mu(d)$ y el hospital $h$ prefiere $d$ sobre su médico asignado $\mu(h)$. Una asignación es **estable** si es individualmente racional y carece de pares bloqueadores. El algoritmo DA garantiza:
   - *Existencia y convergencia:* Siempre converge en tiempo polinómico $O(n^2)$ a una asignación estable.
   - *Optimalidad del proponente:* Si proponen los médicos, el resultado $\mu_D$ es unánimemente el más preferido por todos los médicos entre todas las asignaciones estables posibles; simultáneamente, es el peor posible para los hospitales receptores (*pesimalidad receptora*).
   - *No manipulabilidad (*strategy-proofness*):* Para los proponentes, declarar sus preferencias verdaderas es una estrategia débilmente dominante (Dubins y Freedman 1981; Roth 1982).

2. **Top Trading Cycles para Bienes Indivisibles (Shapley y Scarf 1974; Roth, Sönmez y Ünver 2004):**
   Para intercambiar bienes únicos donde cada participante acude con una dotación inicial (como pacientes con donantes de riñón biológicamente incompatibles), el algoritmo TTC construye un grafo dirigido donde cada paciente apunta a su donante compatible favorito y cada donante apunta a su paciente vinculado. El algoritmo identifica ciclos dirigidos disjuntos, ejecuta los trasplantes correspondientes y elimina a los involucrados en rondas sucesivas. Roth, Sönmez y Ünver probaron que este procedimiento es eficiente en el sentido de Pareto, pertenece al núcleo estricto (*strict core*) y no puede ser manipulado estratégicamente por los receptores.

3. **La Práctica del Diseño de Mercados y Cadenas Altruistas (Roth 1984, 2002, 2004):**
   Roth resolvió los problemas operativos del mundo real que la teoría original ignoraba:
   - *Parejas de médicos en el NRMP:* Médicos casados que buscan residencias en la misma ciudad geográfica (lo que introduce complementariedades no monótonas).
   - *Cadenas de donación con donantes no dirigidos:* El diseño de cadenas iniciadas por un donante altruista ("buen samaritano"), permitiendo programar cirugías de forma asincrónica a lo largo del tiempo sin temor a retractaciones oportunistas.

## Antes y después

### Antes
- **Colapso por ofertas prematuras (*unraveling*):** En los mercados de empleo profesional (médicos, jueces, pasantías jurídicas), los empleadores intentaban adelantarse a la competencia haciendo ofertas con años de anticipación a estudiantes de cursos iniciales, con "ofertas explosivas" que exigían respuesta en minutos, resultando en emparejamientos ineficientes y desinformados.
- **Teoría económica limitada a mercados con dinero:** La microeconomía neoclásica asumía que los problemas de escasez solo se solucionaban mediante ajustes de precios monetarios, considerando los ámbitos sin dinero como anomalías fuera del alcance del diseño económico formal.
- **Muerte evitable de pacientes en diálisis:** Las personas con donantes vivos dispuestos pero biológicamente incompatibles (por anticuerpos o tipo de sangre) no tenían alternativa legal: el donante regresaba a casa y el paciente permanecía años en hemodiálisis o fallecía en listas de espera de donantes fallecidos.

### Después (qué cambió gracias al aporte)
- **Nacimiento de la ingeniería económica (*Market Design*):** Los economistas asumieron un rol análogo al de los ingenieros civiles: diagnosticar patologías institucionales, diseñar algoritmos a medida, verificar propiedades de incentivos y programar software de asignación a gran escala.
- **Sistemas de asignación escolar transparentes y equitativos:** Ciudades de todo el planeta eliminaron los sistemas viciados donde las familias debían mentir estratégicamente sobre sus opciones escolares, reemplazándolos por mecanismos de Gale-Shapley o TTC libres de manipulación.
- **Redes globales de intercambio emparejado de riñones:** La creación de registros computarizados de trasplante cruzado permitió desbloquear miles de cadenas de trasplante en vida, multiplicando exponencialmente la disponibilidad de órganos compatibles en hospitales de todo el mundo.

## Cómo se aplica hoy

1. **El Sistema Nacional de Residencia Médica en EE.UU. (NRMP):**
   El [National Resident Matching Program (NRMP)](https://www.nrmp.org/) asigna anualmente más de 40,000 plazas de residencia médica y especialidades en Estados Unidos utilizando la variante del algoritmo de Gale-Shapley con los candidatos como proponentes diseñada por Alvin Roth y Elliott Peranson en 1998 ([Roth & Peranson 1999](https://doi.org/10.1257/aer.89.4.748)). En el Match de 2024, el NRMP procesó un récord de 50,413 solicitantes inscritos y 41,503 puestos en 6,395 programas hospitalarios con una tasa de asignación estable superior al 93%.

2. **Registros Nacionales de Intercambio Renal (UNOS y National Kidney Registry - NKR):**
   La Red Unida para la Compartición de Órganos ([UNOS Kidney Paired Donation Program](https://unos.org/transplant/kidney-paired-donation/)) y el [National Kidney Registry (NKR)](https://www.kidneyregistry.org/) en Estados Unidos coordinan redes computarizadas de donación emparejada basadas en el modelo de Roth, Sönmez y Ünver (2004). Mediante cadenas de donantes altruistas no dirigidos y algoritmos de optimización combinatoria, el NKR ha facilitado más de 7,500 trasplantes de riñón que de otro modo habrían sido biológicamente imposibles. Protocolos similares operan en el Reino Unido a través del NHS Blood and Transplant ([UK Living Kidney Sharing Schemes](https://www.odt.nhs.uk/living-donation/uk-living-kidney-sharing-scheme/)) y en la Organización Nacional de Trasplantes (ONT) en España.

3. **Asignación Centralizada de Plazas Escolares en Nueva York y Boston:**
   El Departamento de Educación de la Ciudad de Nueva York adoptó en 2003 un sistema basado en el algoritmo de aceptación diferida de Gale-Shapley diseñado por Abdulkadiroğlu, Pathak y Roth ([AER 2005](https://doi.org/10.1257/0002828054201396)), reduciendo del 10% a menos del 1% el número de estudiantes sin escuela asignada ([NYC Public Schools High School Admissions](https://www.schools.nyc.gov/enrollment/enroll-grade-by-grade/high-school)). Boston Public Schools reformó su sistema en 2005 para eliminar las trampas del mecanismo manipulable previo, implementando una variante de aceptación diferida probada libre de manipulación.

4. **Sistemas de Admisión Escolar y Universitaria a Nivel Nacional (Chile y Francia):**
   El Sistema de Admisión Escolar (SAE) de Chile, implementado a escala nacional desde 2016-2019 tras la Ley de Inclusión Escolar, utiliza el algoritmo de Gale-Shapley con aceptación diferida para asignar cientos de miles de plazas escolares sin selección arbitraria ([Ministerio de Educación de Chile - SAE](https://www.sistemadeadmisionescolar.cl/)). En Francia, la plataforma nacional de acceso a la educación superior [Parcoursup](https://www.parcoursup.gouv.fr/) gestiona la admisión de más de 900,000 postulantes universitarios basándose en variantes dinámicas del mecanismo de aceptación diferida.

## Replicación en R
- **Qué se replicó:** Implementación autónoma del algoritmo de aceptación diferida de Gale y Shapley (1962) para mercados bilaterales de médicos y hospitales, contrastando la dirección de las propuestas (DA con médicos proponentes vs. DA con hospitales proponentes) y comparándolo con emparejamientos aleatorios descentralizados en 500 réplicas de Monte Carlo. Adicionalmente, se modeló el algoritmo Top Trading Cycles (TTC) de Shapley-Scarf y Roth-Sönmez-Ünver (2004) para registros de donación cruzada de riñones bajo restricciones de histocompatibilidad biológica (HLA/ABO).
- **Datos y entorno:** Simulación estocástica controlada con semilla fija (`set.seed(20121015)`), desarrollada en R 4.6.0 utilizando los paquetes `tidyverse`, `scales` y `patchwork`.
- **Resultados obtenidos:**
  - El algoritmo de Gale-Shapley garantiza exactamente **0.00 pares bloqueadores** en todas las simulaciones, mientras que el emparejamiento descentralizado genera en promedio **96.7 pares bloqueadores** por mercado, confirmando empíricamente la necesidad del mecanismo centralizado para evitar el colapso.
  - Se valida el teorema de optimalidad proponente: cuando los médicos proponen, alcanzan un ranking promedio de satisfacción de **3.14** (entre 20 opciones), pero caen a **6.00** cuando proponen los hospitales.
  - La simulación de TTC demuestra marcadas economías de escala en el registro renal: ampliar el registro de 20 a 100 y 150 pares eleva la tasa de trasplantes viables del 60% a más del **95.6% - 97.0%**, verificando el hallazgo de Roth de que los registros nacionales unificados salvan sustancialmente más vidas que los registros hospitalarios aislados.
- **Limitaciones:** El modelo ilustrativo asume preferencias estrictas sobre el conjunto total y cuotas hospitalarias unitarias. En la práctica real, los algoritmos integran restricciones de compatibilidad de parejas de postulantes simultáneos y cuotas de diversidad socioeconómica.

## Para profundizar
- Gale, D., & Shapley, L. S. (1962). *College Admissions and the Stability of Marriage*. The American Mathematical Monthly, 69(1), 9-15 [@gale1962college].
- Shapley, L. S., & Scarf, H. (1974). *On Cores and Indivisibility*. Journal of Mathematical Economics, 1(1), 23-37 [@shapley1974cores].
- Shapley, L. S. (1953). *A Value for n-Person Games*. Contributions to the Theory of Games, Vol. II [@shapley1953value].
- Roth, A. E. (1984). *The Evolution of the Labor Market for Medical Interns and Residents: A Case Study in Game Theory*. Journal of Political Economy, 92(6), 991-1016 [@roth1984evolution].
- Roth, A. E. (2002). *The Economist as Engineer: Game Theory, Experimentation, and Computation as Tools for Design Economics*. Econometrica, 70(4), 1341-1378 [@roth2002engineer].
- Roth, A. E., Sönmez, T., & Ünver, M. U. (2004). *Kidney Exchange*. The Quarterly Journal of Economics, 119(2), 457-488 [@roth2004kidney].
- Economic Sciences Prize Committee (2012). *Scientific Background: Stable Allocations and the Practice of Market Design*. Royal Swedish Academy of Sciences [@nobel2012scientific].

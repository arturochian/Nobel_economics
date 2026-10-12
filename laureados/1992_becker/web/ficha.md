---
anio: 1992
slug: 1992_becker
laureados: ["Gary S. Becker"]
motivacion_oficial: "for having extended the domain of microeconomic analysis to a wide range of human behaviour and interaction, including nonmarket behaviour"
area: ["Economía Laboral", "Microeconomía Aplicada", "Economía del Crimen y la Familia"]
tags: ["capital humano", "economía del crimen", "economía de la discriminación", "economía de la familia", "calidad vs cantidad de hijos", "formación general y específica", "disuasión penal", "teorema del niño malcriado"]
referencias_clave: ["becker1957discrimination", "becker1964human_capital", "becker1965time", "becker1968crime", "becker1974altruism", "becker1981family", "becker1993nobel_lecture"]
replicacion: "laureados/1992_becker/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
---

## En una frase
Gary S. Becker revolucionó las ciencias sociales al derribar la frontera entre lo mercantil y lo social, demostrando que el instrumental microeconómico de optimización racional, precios sombra y equilibrio explica rigurosamente decisiones sobre educación, discriminación racial, criminalidad, matrimonio y fecundidad.

## Resumen de la investigación
Durante más de un siglo, la teoría económica se autoconcebía como la ciencia de los bienes comerciales transados por dinero en mercados formales. Gary S. Becker (Universidad de Chicago) desafió radicalmente este consenso al sostener que la economía es un **método general de análisis del comportamiento humano**, aplicable a cualquier esfera donde agentes racionales persigan metas sujetas a restricciones de recursos y tiempo. Sus investigaciones seminales transformaron cuatro grandes áreas:

1. **La Teoría del Capital Humano (1964):** Junto a Theodore Schultz y Jacob Mincer, Becker fundamentó que el conocimiento, las habilidades técnicas y la salud adquiridos por una persona constituyen un stock de capital productivo acumulable. Su avance analítico decisivo fue diferenciar entre **formación general** (habilidades transferibles entre cualquier firma, financiadas por el propio empleado) y **formación específica** (destrezas exclusivas de una empresa, cuyos costos y retornos son compartidos entre empleador y trabajador para evitar rupturas contractuales oportunistas), explicando la concavidad de las curvas de salarios a lo largo de la edad.
2. **La Economía de la Discriminación (1957):** Introdujo en la teoría neoclásica el prejuicio personal como un "gusto por la discriminación" monetizado ($d$). Demostró que discriminar no es gratis: los empleadores con prejuicios renuncian voluntariamente a utilidades al pagar sobrecostos por contratar mano de obra privilegiada. Predijo que, en mercados de competencia abierta a largo plazo, las empresas no discriminadoras poseen una ventaja estructural de costos que erosiona la segregación salarial.
3. **La Economía del Crimen y el Castigo (1968):** Formuló la decisión delictiva no como una anomalía psiquiátrica o irracional, sino como un cálculo de utilidad esperada bajo incertidumbre. El delincuente potencial sopesa las ganancias ilícitas contra la probabilidad de detección y arresto ($p$) y la severidad del castigo ($f$). Además, derivó la regla de política criminal óptima para el Estado, probando que si los infractores son amantes del riesgo en el margen, aumentar la certeza de la captura ($p$) disuade el crimen con mayor intensidad que endurecer desproporcionadamente las penas nominales carcelarias ($f$).
4. **La Economía de la Familia y Asignación del Tiempo (1965, 1974, 1981):** En *A Treatise on the Family*, modeló el hogar como una unidad productiva básica donde los cónyuges asignan su tiempo escaso entre el mercado laboral y el trabajo doméstico mediante ventajas comparativas. Formuló la interacción entre la **cantidad y calidad de los hijos**, explicando por qué el crecimiento de los salarios reales provoca la transición demográfica hacia familias de menor tamaño pero con mayor inversión educativa por descendiente.

## Metodología y resultados

1. **El Modelo de Disuasión Penal y Pérdida Social (Becker, 1968):**
   - La decisión de delinquir obedece a la condición de optimización:
     $$EU = (1 - p) U(Y) + p U(Y - f) > U(w_h)$$
     donde $Y$ es el botín ilícito, $w_h$ el salario honesto alternativo, $p$ la probabilidad de arresto y $f$ la sanción.
   - El planificador social benevolente elige $(p^*, f^*)$ para minimizar la función de costo social:
     $$L(p, f) = D(O) + C(p, O) + b \cdot p \cdot f \cdot O$$
     donde $D(O)$ es el daño social por los delitos $O$, $C(p, O)$ es el gasto en policía y tribunales, y $b$ es el costo social de ejecutar el castigo ($b \approx 0$ para multas pecuniarias; $b > 0$ para encarcelamiento).
   - Demostró que cuando los delincuentes son amantes del riesgo en el margen ($U'' > 0$), la elasticidad respecto a la certeza del castigo supera a la elasticidad respecto a la severidad ($\varepsilon_p > \varepsilon_f$).

2. **Divergencia entre Formación General y Específica (Becker, 1964):**
   - **Formación general:** Como la productividad $MP_t$ se eleva en todas las firmas del mercado, en competencia perfecta la firma no puede recuperar costos posteriores. Por ende, el trabajador financia el entrenamiento aceptando salarios iniciales menores al producto ($w_0 = MP_0 - c$), apropiándose íntegramente del premio salarial en etapas posteriores.
   - **Formación específica:** La productividad adicional solo existe dentro de la empresa patrocinadora. Para protegerse mutuamente contra el riesgo de despido o renuncia intempestiva (*hold-up problem*), empresa y trabajador comparten la inversión inicial y las rentas futuras ($w_{reserva} < w_t < MP_t$), estabilizando el empleo a lo largo del ciclo económico.

3. **La Interacción Cantidad-Calidad en la Demanda de Hijos (Becker & Lewis, 1973):**
   - La restricción presupuestaria familiar incorpora un término multiplicativo de interacción:
     $$p_n n + p_q q + \pi n q = I$$
     donde $n$ es el número de hijos y $q$ es la calidad (inversión por hijo).
   - El costo sombra de un hijo adicional es $\pi_n = p_n + \pi q$. Por lo tanto, conforme los padres eligen estándares educativos más exigentes ($q \uparrow$), tener un hijo adicional se vuelve automáticamente más costoso, explicando analíticamente la reducción de la natalidad en economías avanzadas.

## Antes y después

### Antes
- **Economía confinada al dinero y al comercio:** La disciplina se limitaba a transacciones comerciales explícitas; la familia, el crimen y la educación eran dominio exclusivo de sociólogos, psicólogos o criminólogos.
- **La educación como gasto de consumo o caja negra:** La escolaridad se interpretaba como un consumo cultural pasivo o una credencial estática, sin modelar formalmente la acumulación intertemporal de habilidades productivas.
- **Criminología basada en la patología:** Se asumía que los criminales padecían desviaciones psicológicas irracionales inmunes al cálculo de costos de oportunidad y penas esperadas.
- **Sociología descriptiva del matrimonio:** La fecundidad y el matrimonio se trataban como costumbres culturales fijas ajenas a la teoría de precios y salarios relativos.

### Después (qué cambió gracias al aporte)
- **Universalidad del método económico:** Se consolidó el "imperialismo económico" saludable, aplicando la teoría de precios, optimización y equilibrio a cualquier decisión humana.
- **Teoría moderna del capital humano:** La inversión en educación y entrenamiento se convirtió en el eje central de las políticas públicas de crecimiento, innovación y reducción de la desigualdad.
- **Análisis Económico del Derecho (*Law and Economics*):** El modelo de disuasión de Becker fundó la criminología cuantitativa moderna y el diseño de sistemas de sanciones, multas e incentivos policiales basados en evidencia.
- **Microeconomía de la familia y demografía económica:** Las políticas de natalidad, licencias de paternidad y oferta laboral femenina pasaron a diseñarse bajo modelos rigurosos de costo de oportunidad del tiempo y división del trabajo.

## Cómo se aplica hoy

1. **Estrategias de Policía Focalizada y Disuasión de Puntos Calientes (NYPD, CEPR y NBER, 1994–presente):**
   La predicción de Becker de que la probabilidad de arresto ($p$) disuade más que la severidad de las penas ($f$) fundamentó la transición hacia la vigilancia policial basada en evidencia (*Hot Spots Policing* y *CompStat*). Estudios coordinados por el [National Bureau of Economic Research (NBER)](https://www.nber.org/papers/w21035) y centros criminológicos de vanguardia confirman que la presencia policial visible en esquinas críticas reduce sustancialmente el crimen violento con un costo social inferior al encarcelamiento masivo tardío.

2. **Índice de Capital Humano (HCI) del Banco Mundial y Evaluaciones de la OCDE (1996–presente):**
   El [Banco Mundial](https://www.worldbank.org/en/publication/human-capital) calcula y publica el *Human Capital Index* para más de 170 países, midiendo la pérdida de productividad nacional derivada de déficits en educación y nutrición infantil. Asimismo, la [Organización para la Cooperación y el Desarrollo Económicos (OCDE)](https://www.oecd.org/education/education-at-a-glance/) publica anualmente *Education at a Glance*, calculando el valor presente neto y la tasa de retorno de la educación superior según el marco formal formulado en *Human Capital* (Becker, 1964).

3. **Experimentos de Auditoría Laboral y Medición de la Discriminación (EEOC y Bertrand & Mullainathan, 2004–presente):**
   A partir del concepto beckeriano del coeficiente de discriminación por gusto, los célebres estudios experimentales de correspondencia (*audit studies*), como el de [Bertrand & Mullainathan (2004, AER)](https://doi.org/10.1257/0002828042002561), envían hojas de vida idénticas con nombres asociados a minorías étnicas a vacantes de empleo reales. Estas métricas son utilizadas sistemáticamente por la [Equal Employment Opportunity Commission (EEOC)](https://www.eeoc.gov/) de EE. UU. y tribunales laborales europeos para detectar y sancionar brechas salariales y barreras invisibles de contratación.

4. **Reformas de Licencias Parentales Compartidas y Subsidios a la Primera Infancia (Unión Europea, 2019–presente):**
   La modelación de Becker sobre la división del tiempo en el hogar y la interacción calidad-cantidad de hijos es la base teórica de la Directiva Europea 2019/1158 de la [Comisión Europea](https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX%3A32019L1158) sobre conciliación de la vida familiar y profesional, que establece licencias de paternidad intransferibles para neutralizar la penalización laboral por maternidad en las empresas.

## Replicación en R
La carpeta de replicación contiene un script totalmente autónomo y ejecutable en R: [`laureados/1992_becker/replicacion/R/crimen_capital_humano_y_familia.R`](../replicacion/R/crimen_capital_humano_y_familia.R).

El script reproduce:
1. **La superficie de disuasión penal de Becker (1968):** Simula el volumen agregado de delitos $O(p, f)$ y minimiza la función de pérdida social $L(p, f) = D(O) + C(p, O) + b p f O$, hallando el punto de política óptimo que equilibra la certidumbre de aprehensión con el costo del sistema judicial y penitenciario ([`salidas/fig_becker_crimen_disuasion.png`](../replicacion/salidas/fig_becker_crimen_disuasion.png)).
2. **Los perfiles edad-ingreso bajo acumulación de capital humano (Becker, 1964):** Simula la evolución salarial a lo largo de 47 años de vida laboral (edades 18 a 65), evidenciando el sacrificio salarial inicial de la formación general, la edad de cruce (*crossover age* en torno a los 24 años) y la concavidad de la trayectoria en comparación con la formación específica y el trabajo no calificado ([`salidas/fig_becker_capital_humano_perfiles.png`](../replicacion/salidas/fig_becker_capital_humano_perfiles.png)).
3. **Generación de datos consolidados:** Exporta [`salidas/tab_resultados_becker.csv`](../replicacion/salidas/tab_resultados_becker.csv) con las métricas de política criminal evaluadas.

## Para profundizar
- **Becker, Gary S. (1957).** *The Economics of Discrimination*. University of Chicago Press. [@becker1957discrimination]
- **Becker, Gary S. (1964).** *Human Capital: A Theoretical and Empirical Analysis, with Special Reference to Education*. NBER / Columbia University Press. [@becker1964human_capital]
- **Becker, Gary S. (1965).** "A Theory of the Allocation of Time". *The Economic Journal*, 75(299), 493–517. [@becker1965time]
- **Becker, Gary S. (1968).** "Crime and Punishment: An Economic Approach". *Journal of Political Economy*, 76(2), 169–217. [@becker1968crime]
- **Becker, Gary S. (1974).** "A Theory of Social Interactions". *Journal of Political Economy*, 82(6), 1063–1093. [@becker1974altruism]
- **Becker, Gary S. (1981).** *A Treatise on the Family*. Harvard University Press. [@becker1981family]
- **Becker, Gary S. (1993).** "Nobel Lecture: The Economic Way of Looking at Behavior". *Journal of Political Economy*, 101(3), 385–409. [@becker1993nobel_lecture]
- **Royal Swedish Academy of Sciences (1992).** *Gary S. Becker's Contributions to Economics*. Nobel Prize Advanced Information. [@nobel1992_advanced]

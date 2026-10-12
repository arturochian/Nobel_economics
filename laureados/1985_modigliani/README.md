# Nobel de Economía 1985: Franco Modigliani

> **Motivación oficial:**  
> *"for his pioneering analyses of saving and of financial markets"* (Por sus análisis pioneros del ahorro y de los mercados financieros).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 15 de octubre de 1985.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras fundamentales de Modigliani (*Post-Keynesian Economics* 1954, *The American Economic Review* 1958, 1963, *The Journal of Business* 1961, Discurso Nobel 1986) y los documentos oficiales de la Academia Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI/JSTOR, enlaces estables y régimen de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la fundamentación analítica, derivación micro y macroeconómica, gráficos reproducibles y calibración computacional.
  - [R/hipotesis_ciclo_vida_consumo.R](replicacion/R/hipotesis_ciclo_vida_consumo.R): Script autónomo y modular en R que modela la trayectoria individual de consumo, ingreso y riqueza a lo largo del ciclo vital (edades 20 a 85), así como el impacto del cambio demográfico (envejecimiento poblacional y tasa de dependencia) sobre la tasa de ahorro agregada.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_modigliani_ciclo_vida_perfiles.png](replicacion/salidas/fig_modigliani_ciclo_vida_perfiles.png), [fig_modigliani_ahorro_demografia.png](replicacion/salidas/fig_modigliani_ahorro_demografia.png)) y tabla consolidada de escenarios demográficos ([tab_resultados_modigliani.csv](replicacion/salidas/tab_resultados_modigliani.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: suavizamiento intertemporal y función de consumo; intermedio: teoremas de Modigliani-Miller, WACC y escudo fiscal; reto: agregación demográfica, tasa de dependencia y desahorro en economías envejecidas).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, fundamentos analíticos y solucionario completo paso a paso con rúbrica de evaluación para los docentes.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo de las Contribuciones

Franco Modigliani (1918–2003), eminente economista italoestadounidense y profesor en el Massachusetts Institute of Technology (MIT), transformó dos de las ramas más cruciales de la ciencia económica: la macroeconomía del consumo intertemporal y los fundamentos de las finanzas corporativas.

### 1. La Hipótesis del Ciclo de Vida del Ahorro (Life-Cycle Hypothesis, LCH)
- **Modigliani y Brumberg (1954); Ando y Modigliani (1963):**  
  Partiendo de la premisa de que los agentes económicos planifican su consumo y ahorro no en función del ingreso disponible corriente del período (como postulaba la función keynesiana simple), sino en función de sus **recursos vitales esperados**, formularon la hipótesis del ciclo de vida.
- **Suavizamiento del consumo (*consumption smoothing*):**  
  Los individuos buscan una trayectoria de bienestar estable a lo largo de su vida. Por ello, recurren al endeudamiento o consumo asistido en la juventud temprana, acumulan activos financieros y reales durante sus años de madurez laboral activa, y desahorran sistemáticamente durante la etapa de jubilación para financiar su vejez.
- **Resolución de la paradoja del consumo de Kuznets:**  
  Explicó por qué en datos de corte transversal la propensión marginal a consumir es decreciente en el corto plazo, mientras que en series de tiempo históricas de largo plazo la propensión media a consumir se mantiene notablemente estable: el acervo de riqueza ($W$) se expande en sincronía con el ingreso ($Y$), estabilizando la relación $C/Y = \alpha (W/Y) + \beta$.
- **Implicancias demográficas y macroeconómicas agregadas:**  
  Demostró que el ahorro nacional agregado depende esencialmente de la tasa de crecimiento demográfico ($n$) y del avance de la productividad ($g$). En una sociedad en expansión demográfica o con crecimiento salarial dinámico, los trabajadores activos ahorran un volumen superior al que desahorran los jubilados. Por el contrario, en sociedades con envejecimiento severo y bajas tasas de natalidad, la masa de jubilados en desahorro presiona a la baja la tasa de ahorro agregada.

### 2. Los Teoremas de Modigliani-Miller (Finanzas Corporativas)
- **Modigliani y Miller (1958, 1963):**  
  Revolucionaron la economía financiera al establecer las condiciones bajo las cuales las decisiones de financiamiento de una corporación son irrelevantes para su valor económico intrínseco.
- **Proposición I (Neutralidad de la estructura de capital sin fricciones):**  
  En mercados financieros perfectos, sin impuestos ni costos de quiebra, el valor total de una empresa está determinado exclusivamente por la rentabilidad y el riesgo de sus activos operativos reales, no por la proporción en que se divide entre deuda y capital propio ($V_L = V_U$). Cualquier apalancamiento que la empresa tome puede ser replicado o neutralizado individualmente por los inversores mediante endeudamiento personal (*homemade leverage*).
- **Proposición II (Costo del capital propio y WACC):**  
  El costo exigido por los accionistas ($r_E$) se incrementa de forma estrictamente lineal con la ratio de apalancamiento $D/E$. Sin embargo, este aumento compensa con exactitud el mayor riesgo financiero asumido, dejando inalterado el costo medio ponderado del capital (WACC, *Weighted Average Cost of Capital*).
- **El Escudo Fiscal de la Deuda (1963):**  
  Al incorporar la fiscalidad corporativa donde los intereses de la deuda son deducibles del impuesto sobre beneficios, demostraron que el endeudamiento genera un escudo fiscal (*tax shield*) que eleva el valor de la empresa apalancada: $V_L = V_U + \tau_C D$, sentando la base de la teoría del trade-off en finanzas modernas.

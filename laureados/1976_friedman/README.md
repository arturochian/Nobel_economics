# Nobel de Economía 1976: Milton Friedman

> **Motivación oficial:**  
> *"for his achievements in the fields of consumption analysis, monetary history and theory and for his demonstration of the complexity of stabilization policy"* (Por sus logros en los campos del análisis del consumo, la historia y teoría monetarias y por su demostración de la complejidad de la política de estabilización).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 14 de octubre de 1976.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras fundamentales de Friedman (*A Theory of the Consumption Function* 1957, *A Monetary History of the United States* 1963 con Anna Schwartz, *The Role of Monetary Policy* 1968, *The Quantity Theory of Money: A Restatement* 1956, Discurso Nobel 1977) y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI/JSTOR, enlaces estables y régimen de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la fundamentación analítica, derivaciones matemáticas, simulación computacional, gráficos reproducibles y calibración de política macroeconómica.
  - [R/ingreso_permanente_y_monetarismo.R](replicacion/R/ingreso_permanente_y_monetarismo.R): Script autónomo y modular en R que modela la función de consumo bajo la Hipótesis del Ingreso Permanente vs Keynesianismo ingenuo (choques transitorios vs permanentes y reconciliación de la paradoja de Kuznets) y simula la espiral aceleracionista de la Curva de Phillips con expectativas adaptativas y verticalidad en la tasa natural $u_n$.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_friedman_ingreso_permanente.png](replicacion/salidas/fig_friedman_ingreso_permanente.png), [fig_friedman_curva_phillips_vertical.png](replicacion/salidas/fig_friedman_curva_phillips_vertical.png)) y tabla consolidada de trayectorias macroeconómicas ([tab_resultados_friedman.csv](replicacion/salidas/tab_resultados_friedman.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: ingreso permanente vs keynesianismo ante choques de política fiscal; intermedio: teoría cuantitativa, rezagos largos y variables, y regla del $k\%$; reto: expectativas adaptativas, espiral aceleracionista y ratio de sacrificio en la desinflación).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, fundamentos analíticos, solucionario completo paso a paso y rúbrica de evaluación para los docentes.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo de las Contribuciones

Milton Friedman (1912–2006), figura señera de la Universidad de Chicago y líder de la Escuela Monetarista, transformó la macroeconomía moderna al desafiar los consensos keynesianos imperantes en la posguerra a través de cuatro grandes pilares:

### 1. La Hipótesis del Ingreso Permanente (Permanent Income Hypothesis, PIH, 1957)
- **Friedman (1957):**  
  Frente al postulado keynesiano de que el consumo corriente depende pasivamente del ingreso disponible corriente ($C = a + c Y$), demostró que los consumidores racionales optimizan su nivel de vida a lo largo de su horizonte temporal de acuerdo a sus expectativas de recursos a largo plazo (*ingreso permanente*).
- **Suavizamiento intertemporal y choques transitorios:**  
  Un incremento transitorio e imprevisto en el ingreso (como un bono único o una devolución fiscal extraordinaria) es absorbido en su mayor parte por el ahorro financiero o el pago de deudas, de modo que el consumo corriente solo se eleva en la cuantía del rendimiento de anualidad del activo.
- **Resolución de la paradoja del consumo de Kuznets:**  
  Explicó rigurosamente por qué en encuestas de corte transversal los hogares ricos exhiben una menor propensión media a consumir ($C/Y$), mientras que en series de tiempo históricas de largo plazo la relación $C/Y$ agregada permanece notablemente constante: la dispersión transversal refleja errores transitorios de ingreso que sesgan por atenuación la pendiente estimada, mientras que en el largo plazo secular el consumo crece en estricta proporción con el ingreso permanente ($C/Y = k \approx 0.90$).

### 2. Monetarismo e Historia Monetaria (1956, 1963)
- **Friedman y Schwartz (1963):**  
  En su monumental obra *A Monetary History of the United States, 1867–1960*, demostraron mediante una exhaustiva investigación histórica y econométrica que las grandes recesiones económicas estadounidenses —y en especial la Gran Depresión de 1929–1933— fueron causadas por contracciones catastróficas de la oferta de dinero consentidas por la Reserva Federal, desterrando el mito de que el dinero era un factor pasivo o irrelevante.
- **Reformulación de la Teoría Cuantitativa:**  
  Presentó la Teoría Cuantitativa no como una tautología mecánica, sino como una teoría de demanda de dinero empíricamente estable. De allí emanó su célebre formulación: *"la inflación es siempre y en todo lugar un fenómeno monetario, en el sentido de que solo es y puede ser producida por un aumento más rápido de la cantidad de dinero que de la producción"*.

### 3. La Tasa Natural de Desempleo y la Curva de Phillips Aumentada (1968, 1977)
- **Friedman (1968); Phelps (1967):**  
  Anticipó con extraordinaria lucidez el fenómeno de la estanflación de la década de 1970 antes de que ocurriera, demoliendo la idea de un trade-off permanente entre inflación y desempleo.
- **Expectativas Adaptativas y la Hipótesis Aceleracionista:**  
  A corto plazo, una aceleración de la emisión monetaria puede reducir el desempleo debido a la lentitud con que trabajadores y empresas ajustan sus expectativas (ilusión monetaria transitoria). Sin embargo, una vez que las expectativas de inflación se adaptan a la realidad, las curvas de Phillips de corto plazo se desplazan hacia arriba.
- **Verticalidad en la Tasa Natural ($u_n$ / NAIRU):**  
  Para mantener el desempleo por debajo de su nivel estructural de equilibrio de forma duradera, el banco central se ve forzado a acelerar continuamente la inflación ($\Delta \pi > 0$). En el largo plazo, la Curva de Phillips es **estrictamente vertical** en la Tasa Natural de Desempleo ($u_n$). La política monetaria solo puede determinar la tasa de inflación de largo plazo, nunca el nivel de empleo real.

### 4. La Complejidad de la Estabilización: Rezagos Largos y Variables
- **Inestabilidad del ajuste fino (*fine-tuning*):**  
  Friedman demostró que los efectos de las políticas fiscales y monetarias operan con rezagos de transmisión internos y externos prolongados y de duración sumamente impredecible (*long and variable lags*).
- **Efectos procíclicos involuntarios:**  
  Las intervenciones discrecionales contracíclicas suelen terminar surtiendo su máximo efecto cuando la economía ya ha salido naturalmente de la recesión, sobrecalentando la actividad y exacerbando las oscilaciones cíclicas.
- **Reglas vs. Discrecionalidad:**  
  Propuso sustituir la discrecionalidad de las autoridades por reglas automáticas, predecibles y transparentes (como la regla de crecimiento monetario constante del $k\%$ anual), sentando las bases doctrinarias para la independencia de los bancos centrales y la prioridad del anclaje de expectativas de inflación en la política monetaria moderna.

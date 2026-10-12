# Nobel de Economía 1979: Theodore W. Schultz y Sir Arthur Lewis

> **Motivación oficial:**  
> *"for their pioneering research into economic development research with particular consideration of the problems of developing countries"* (Por sus investigaciones pioneras sobre el desarrollo económico, con especial consideración a los problemas de los países en desarrollo).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 16 de octubre de 1979.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras fundamentales de Lewis (*Economic Development with Unlimited Supplies of Labour* 1954, *The Theory of Economic Growth* 1955, Discurso Nobel 1980) y de Schultz (*Investment in Human Capital* 1961, *Transforming Traditional Agriculture* 1964, *The Value of the Ability to Deal with Disequilibria* 1975, Discurso Nobel 1980), junto con las comunicaciones oficiales de la Fundación Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI, enlaces directos y régimen de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de acceso abierto (*Open Access*).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la formalización matemática del modelo de desarrollo dual de Lewis, la condición analítica del Punto de Inflexión de Lewis (LTP), la función de producción agrícola schultziana con rendimientos a la inversión en capital humano, simulación cuantitativa en R, análisis de políticas y ejercicios.
  - [R/desarrollo_dual_y_capital_humano.R](replicacion/R/desarrollo_dual_y_capital_humano.R): Script modular autónomo y reproducible en R que simula la transición intersectorial de mano de obra y capital, calcula el punto de inflexión salarial y evalúa los retornos a la escolaridad bajo tecnologías agrícolas cambiantes.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_lewis_desarrollo_dual.png](replicacion/salidas/fig_lewis_desarrollo_dual.png), [fig_schultz_capital_humano_agricola.png](replicacion/salidas/fig_schultz_capital_humano_agricola.png)) y tabla consolidada de resultados cuantitativos ([tab_resultados_desarrollo_1979.csv](replicacion/salidas/tab_resultados_desarrollo_1979.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: equilibrio dual de Lewis, salario de reserva y determinación del punto de inflexión; intermedio: ahorro capitalista, acumulación dinámica y velocidad de absorción laboral; reto: hipótesis de "pobres pero eficientes" de Schultz, asignación óptima de factores e inversión en capital humano ante desequilibrios tecnológicos).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, fundamentos analíticos, solucionario matemático paso a paso y rúbrica de evaluación para el cuerpo docente.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el portal web estático.

---

## Resumen Ejecutivo de las Contribuciones

El Premio Nobel de Economía de 1979 premió a dos pioneros que revolucionaron la comprensión científica de la pobreza y el crecimiento en el mundo en desarrollo, articulando dos perspectivas complementarias: la transformación estructural macroeconómica (Sir W. Arthur Lewis) y la racionalidad microeconómica del campesinado y el capital humano (Theodore W. Schultz).

### 1. Sir W. Arthur Lewis: El Modelo de Desarrollo Dual y la Oferta Ilimitada de Mano de Obra (1954)
- **Economía Dual:** Lewis (1915–1991), nacido en Santa Lucía y profesor en Manchester y Princeton, postuló que las economías en desarrollo no se comportan según los postulados clásicos de escasez de mano de obra, sino que están escindidas en dos sectores:
  1. *Sector Tradicional/Subsistencia:* Caracterizado por alta densidad demográfica, escaso capital y una productividad marginal del trabajo cercana a cero ($MPL_A \approx 0$). En este sector, los salarios no se fijan competitivamente por productividad marginal, sino por normas de reparto social del producto medio de subsistencia ($\bar{w}_{sub}$).
  2. *Sector Moderno/Industrial:* Emplea capital reproducible y contrata mano de obra con afán de lucro hasta igualar el producto marginal al salario urbano ($MPL_M = w_M$).
- **Oferta Perfectamente Elástica y Acumulación Capitalista:** Dado el enorme excedente laboral rural, la industria puede contratar trabajadores a un salario real prácticamente constante ($w_M = (1 + \mu) \bar{w}_{sub}$, con una prima urbana $\mu \approx 30\%-50\%$). Los beneficios capitalistas generados no se consumen de forma suntuaria, sino que se reinvierten sistemáticamente, expandiendo el stock de capital y desplazando la demanda de trabajo.
- **El Punto de Inflexión de Lewis (*Lewis Turning Point*):** A medida que la industria absorbe mano de obra, el excedente agrícola desaparece. Llegado un momento crítico, el producto marginal en el campo supera el salario de subsistencia ($MPL_A > \bar{w}_{sub}$). La oferta de trabajo a la ciudad deja de ser elástica: los salarios rurales y urbanos comienzan a subir con rapidez, la economía ingresa en una etapa plenamente comercial y neoclásica, y la desigualdad funcional se reduce.

### 2. Theodore W. Schultz: Modernización Agrícola y Capital Humano (1964, 1975)
- **Rechazo del Mito de la Irracionalidad Campesina:** Theodore W. Schultz (1902–1998), profesor de la Universidad de Chicago, desafió de raíz el prejuicio etnocéntrico dominante en la década de 1950 que consideraba a los campesinos del Tercer Mundo como agentes pasivos, perezosos o inmunes a los incentivos económicos.
- **La Hipótesis "Pobres pero Eficientes" (*Poor but Efficient*):** En su obra maestra *Transforming Traditional Agriculture* (1964), demostró empíricamente (utilizando datos de aldeas en Guatemala, India y la experiencia de la gripe española de 1918) que los agricultores tradicionales son asignativamente eficientes: han optimizado el uso de sus tierras y herramientas tradicionales hasta alcanzar un equilibrio estático donde el rendimiento marginal de factores tradicionales adicionales es nulo. Por ende, los campesinos no son pobres por ineficiencia, sino porque las tecnologías disponibles son primitivas.
- **La Inversión en Personas (Capital Humano):** Schultz (1961, 1980) probó que la verdadera palanca del desarrollo económico no reside en las represas faraónicas ni en el mero hormigón fabril, sino en la **inversión en capital humano**: educación formal, nutrición, salud pública y capacitación tecnológica.
- **Habilidad para Afrontar Desequilibrios (*Dealing with Disequilibria*, 1975):** Con la llegada de la Revolución Verde (semillas híbridas de alto rendimiento, fertilizantes y riego), el entorno estático se quebró. Schultz formalizó que el valor primordial de la educación agrícola reside en la capacidad cognitiva de procesar información científica, calcular dosificaciones y adoptar innovaciones ante situaciones de desequilibrio dinámico.

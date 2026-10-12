# Nobel de Economía 1974: Gunnar Myrdal y Friedrich August von Hayek

> **Motivación oficial:**  
> *"for their pioneering work in the theory of money and economic fluctuations and for their penetrating analysis of the interdependence of economic, social and institutional phenomena"* (Por su trabajo pionero en la teoría del dinero y las fluctuaciones económicas y por su penetrante análisis de la interdependencia de los fenómenos económicos, sociales e institucionales).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 9 de octubre de 1974.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras fundamentales de Hayek (*The Use of Knowledge in Society* 1945, *Prices and Production* 1931, *The Pretence of Knowledge* 1974/1975) y de Myrdal (*Economic Theory and Under-developed Regions* 1957, *Monetary Equilibrium* 1939, *Asian Drama* 1968, *An American Dilemma* 1944), junto con los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI/JSTOR, enlaces estables y régimen de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la fundamentación analítica, derivaciones matemáticas, simulación computacional estocástica, gráficos reproducibles y calibración de política económica.
  - [R/precios_conocimiento_y_causacion_circular.R](replicacion/R/precios_conocimiento_y_causacion_circular.R): Script autónomo y modular en R que modela la coordinación informativa del sistema de precios descentralizado de Hayek frente a la planificación central rezagada, y la dinámica espacial de divergencia Centro-Periferia de Myrdal bajo efectos de retroceso (*backwash*) y derrame (*spread*).
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_hayek_sistema_precios_informacion.png](replicacion/salidas/fig_hayek_sistema_precios_informacion.png), [fig_myrdal_causacion_circular.png](replicacion/salidas/fig_myrdal_causacion_circular.png)) y tabla consolidada de resultados cuantitativos ([tab_resultados_hayek_myrdal_1974.csv](replicacion/salidas/tab_resultados_hayek_myrdal_1974.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: el sistema de precios de Hayek ante choques de oferta locales vs planificación central y cálculo del *deadweight loss*; intermedio: causación circular acumulativa de Myrdal, cálculo de la tasa de divergencia a 15 años y determinación del "Gran Impulso" de inversión regional; reto: síntesis del ciclo austríaco de malas inversiones con el desequilibrio *ex-ante* vs *ex-post* de Estocolmo).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, fundamentos analíticos, solucionario completo paso a paso y rúbrica de evaluación para los docentes.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo de las Contribuciones

El Premio Nobel de 1974 reconoció dos trayectorias colosales que desafiaron el reduccionismo mecanicista de la economía neoclásica tradicional a través de pilares complementarios:

### 1. Friedrich August von Hayek: El Problema del Conocimiento y la Teoría Monetaria del Ciclo
- **El Sistema de Precios como Transmisor de Información Dispersa (1945):**  
  En su célebre artículo *The Use of Knowledge in Society*, Hayek demostró que el problema económico fundamental de una sociedad no es simplemente la asignación matemática de recursos "dados", sino la **utilización del conocimiento que no está dado a nadie en su totalidad**. La mayor parte del conocimiento humano es tácito, subjetivo y atado a circunstancias particulares de "tiempo y lugar". Los precios de mercado actúan como un sistema espontáneo de telecomunicaciones que sintetiza la escasez relativa e induce a millones de agentes a coordinarse eficientemente sin necesidad de una autoridad planificadora central.
- **La Teoría del Ciclo Económico y las Malas Inversiones (1931):**  
  En *Prices and Production*, integró la teoría del capital de Böhm-Bawerk con la tasa natural de interés de Wicksell para explicar las fluctuaciones cíclicas. La expansión crediticia fiduciaria que reduce las tasas de mercado por debajo de la tasa natural envía una señal falsa a los empresarios, estimulando proyectos desproporcionadamente extensos en las etapas de producción alejadas del consumo (*malinvestments*). Cuando el ahorro real resulta insuficiente para sostener dicha estructura temporal, sobreviene una crisis inevitable de reajuste y liquidación.
- **La Pretensión del Conocimiento (1974):**  
  En su discurso Nobel, denunció el cientificismo imperante en la macroeconomía, alertando que pretender diseñar y controlar mecánicamente variables agregadas complejas como el empleo y la inflación mediante modelos puramente cuantitativos constituye una "fatal arrogancia" que agrava la inestabilidad.

### 2. Gunnar Myrdal: Causación Circular Acumulativa y Equilibrio Monetario Institucional
- **El Principio de la Causación Circular Acumulativa (1957):**  
  En *Economic Theory and Under-developed Regions*, Myrdal refutó la premisa ortodoxa de que el libre mercado y el comercio internacional generan espontáneamente la convergencia espacial del ingreso por habitante. Demostró la existencia de **fuerzas centrípetas o efectos de retroceso (*backwash effects*)**: las regiones ricas atraen el capital financiero, los trabajadores calificados y la innovación, empobreciendo a las regiones periféricas. Si los efectos de difusión (*spread effects*) son débiles, las disparidades regionales crecen indefinidamente, requiriéndose la intervención deliberada de un Estado desarrollista con inversiones estratégicas en infraestructura, capital humano e instituciones.
- **Equilibrio Monetario: Análisis Ex-Ante vs. Ex-Post (1939):**  
  En *Monetary Equilibrium*, Myrdal formuló la distinción analítica fundamental entre los planes calculados con anticipación (*ex-ante*) y los resultados contables realizados (*ex-post*). Demostró que, aunque el ahorro y la inversión son contablemente idénticos *ex-post*, las discrepancias *ex-ante* entre los planes de ahorro de las familias y de inversión de las empresas desatan ganancias inesperadas (*windfall profits*) y movimientos acumulativos de precios y empleo.
- **Economía Institucional y Pobreza Multidimensional (1944, 1968):**  
  En *An American Dilemma* (sobre las relaciones raciales en EE.UU.) y *Asian Drama* (sobre el subdesarrollo en el sur de Asia), probó que la economía no puede divorciarse de las instituciones políticas, la salud, la nutrición, las jerarquías sociales y la cultura, anticipando el enfoque multidimensional de la economía del desarrollo moderna.

---

## Síntesis Doctrinal del Nobel 1974

La aparente paradoja de galardonar simultáneamente a un campeón del libre mercado (Hayek) y a un pionero de la planificación del desarrollo y el estado de bienestar (Myrdal) se resuelve al comprender la profunda complementariedad de sus aportes:
- **Hayek** explica con precisión insuperable por qué los mercados descentralizados son indispensables para coordinar y procesar la información microeconómica local en tiempo real, demostrando el fracaso inevitable de la fijación burocrática de precios y cuotas.
- **Myrdal** explica con igual contundencia por qué los mercados librados enteramente a sus fuerzas espontáneas no garantizan la equidad territorial ni eliminan las trampas estructurales de pobreza, demostrando la necesidad insustituible de bienes públicos, instituciones inclusivas e inversiones estratégicas de desarrollo.

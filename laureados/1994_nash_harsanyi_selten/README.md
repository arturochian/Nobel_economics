# Nobel de Economía 1994: John C. Harsanyi, John F. Nash Jr. y Reinhard Selten

> **Motivación oficial:**  
> *"for their pioneering analysis of equilibria in the theory of non-cooperative games"* (Por su análisis pionero de los equilibrios en la teoría de juegos no cooperativos).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 11 de octubre de 1994.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Nash (*PNAS* 1950, *Annals of Mathematics* 1951, *Econometrica* 1950), Selten (*ZgS* 1965, *IJGT* 1975), Harsanyi (*Management Science* 1967–1968, *IJGT* 1973) y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias de las referencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la fundamentación matemática, demostración de existencia por teorema de Kakutani, derivación analítica de equilibrios mixtos, inducción hacia atrás de Selten, transformación bayesiana de Harsanyi y código en R.
  - [R/equilibrios_juegos_no_cooperativos.R](replicacion/R/equilibrios_juegos_no_cooperativos.R): Script autónomo y modular en R que computa y grafica los equilibrios de Nash en juegos 2x2, resuelve el juego dinámico de entrada eliminando amenazas no creíbles y simula el umbral bayesiano de disuasión.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_nash_equilibrio_mixto.png](replicacion/salidas/fig_nash_equilibrio_mixto.png), [fig_selten_juego_dinamico_spe.png](replicacion/salidas/fig_selten_juego_dinamico_spe.png)) y tabla de comparación de resultados ([tab_resultados_juegos_1994.csv](replicacion/salidas/tab_resultados_juegos_1994.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: inspección fiscal y cálculo de estrategias mixtas; intermedio: disuasión de entrada y compromiso creíble con inversión previa en capacidad; reto: subasta de primer precio con valores privados independientes y conjetura de equilibrio lineal simétrico de Harsanyi).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes, fundamentación matemática de los teoremas de punto fijo y racionalidad secuencial, y solucionario paso a paso de todos los ejercicios con rúbrica de evaluación.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo de las Contribuciones

La teoría de juegos revolucionó la ciencia económica moderna al proporcionar las herramientas matemáticas rigurosas para estudiar la toma de decisiones estratégicas: situaciones en las que el bienestar de cada agente depende no solo de sus propias acciones, sino de las elecciones anticipadas de los demás.

El Premio Nobel de 1994 reconoció a los tres arquitectos fundamentales de la teoría de juegos no cooperativos:

1. **John F. Nash Jr. (1950, 1951):**
   - Estableció la distinción fundamental entre **juegos cooperativos** (donde existen compromisos vinculantes exigibles) y **juegos no cooperativos** (donde los acuerdos deben ser autosostenibles).
   - Formuló el **Equilibrio de Nash**: un perfil de estrategias en el cual ningún jugador puede mejorar estrictamente su pago desviándose de manera unilateral.
   - Demostró el **Teorema de Existencia Universal** para juegos finitos mediante teoremas de punto fijo (Kakutani y Brouwer), probando que todo juego finito posee al menos un equilibrio en estrategias mixtas.
   - Formuló la **solución de negociación axiomática de Nash** (*Nash bargaining solution*, 1950), basada en la maximización del producto de ganancias sobre el punto de desacuerdo.

2. **Reinhard Selten (1965, 1975):**
   - Identificó que en juegos secuenciales y dinámicos, muchos equilibrios de Nash son implausibles porque se sustentan en **amenazas no creíbles** (*non-credible threats*) en contingencias que no ocurren en la trayectoria prevista.
   - Introdujo el concepto de **Equilibrio Perfecto en Subjuegos** (*Subgame Perfect Equilibrium*, SPE), exigiendo que las estrategias constituyan un equilibrio de Nash en todos y cada uno de los subjuegos del juego original.
   - Formalizó el algoritmo de **inducción hacia atrás** (*backward induction*) y concibió el refinamiento de **equilibrio perfecto en la mano temblorosa** (*trembling hand perfection*, 1975).

3. **John C. Harsanyi (1967–1968, 1973):**
   - Resolvió el problema aparentemente insoluble de los **juegos con información incompleta** (donde los participantes desconocen las funciones de pago o costes de los demás).
   - Desarrolló la **transformación harsanyiana a juegos bayesianos**, modelando la incertidumbre mediante la introducción de una jugada previa ficticia de la "Naturaleza" que asigna **tipos privados** a cada jugador según una distribución a priori común (*common prior*).
   - Definió el **Equilibrio de Nash Bayesiano** (BNE), que se convirtió en la base metodológica de la economía de la información, el diseño de subastas y la teoría de incentivos.
   - Formuló la **doctrina de purificación de Harsanyi** (1973), demostrando que un equilibrio en estrategias mixtas puede entenderse como el límite de equilibrios en estrategias puras de un juego bayesiano donde los pagos de los jugadores sufren pequeñas perturbaciones aleatorias privadas.

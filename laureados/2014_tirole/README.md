# Nobel de Economía 2014: Jean Tirole

> **Motivación oficial:** *"for his analysis of market power and regulation"* (Por su análisis del poder de mercado y la regulación).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 13 de octubre de 2014.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Laffont y Tirole (1986, 1993), Rochet y Tirole (2003, 2006), los libros de texto de Tirole (1988, 2017) y los documentos oficiales del comité Nobel (2014).
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Directorio preparado para almacenamiento local de referencias documentales.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con formulación matemática del menú de contratos de regulación y de las condiciones de equilibrio en plataformas bilaterales.
  - [R/regulacion_plataformas_tirole.R](replicacion/R/regulacion_plataformas_tirole.R): Script autónomo en R que ejecuta la simulación numérica de los modelos de Laffont-Tirole y Rochet-Tirole.
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_menu_contratos_regulacion.png`, `fig_plataformas_dos_lados.png`) y tabla de resultados (`tab_resultados_tirole.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: trade-off entre esfuerzo y renta informacional; intermedio: regla de precios de Rochet-Tirole y subsidios cruzados; avanzado/reto: defensa de la competencia en plataformas de Big Tech como Apple App Store y Google).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes confidenciales con deducciones analíticas formales, cálculos cuantitativos y criterios de evaluación.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

Jean Tirole refundó la organización industrial, la teoría de la regulación y el análisis de la competencia al proporcionar un marco riguroso de teoría de juegos e información asimétrica para entender cómo operan las grandes corporaciones y cómo deben intervenir los gobiernos:

1. **La Nueva Economía de la Regulación (Laffont & Tirole, 1986, 1993):**
   Antes de Tirole, los reguladores oscilaban entre reembolsar costos ciegamente (*cost-plus*, lo que destruía los incentivos a la eficiencia) o imponer tarifas fijas (*price-caps*, lo que transfería rentas exorbitantes a las empresas eficientes). Junto a Jean-Jacques Laffont, demostró que un menú óptimo de contratos de incentivos induce a la empresa a revelar su verdadero nivel de eficiencia: las firmas eficientes eligen contratos de alta potencia de incentivos, mientras que para las menos eficientes se mitiga la renta informacional mediante una distorsión controlada del esfuerzo.

2. **Plataformas Bilaterales y Mercados de Dos Lados (Rochet & Tirole, 2003, 2006):**
   Rochet y Tirole demostraron que mercados como tarjetas de pago, consolas de videojuegos, motores de búsqueda y tiendas de aplicaciones no pueden analizarse como industrias convencionales. Debido a las externalidades de red cruzadas, la plataforma optimiza no solo el nivel total de precios, sino la estructura relativa de los precios cobrados a cada lado del mercado. Justificaron por qué cobrar precios nulos o negativos (subsidios, cashback, gratuidad) a uno de los lados es eficiente y no representa una práctica predatoria de precios.

3. **La Teoría Moderna de la Organización Industrial (Tirole, 1988):**
   Su tratado seminal unificó décadas de teoría de juegos aplicada para estudiar el abuso de posición dominante, ventas atadas, barreras a la entrada, contratos verticales y colusión tácita. Sus marcos teóricos constituyen la base analítica sobre la cual los tribunales antimonopolio y las autoridades de regulación global juzgan hoy el comportamiento de gigantes tecnológicos y monopolios de infraestructura.

# Nobel de Economía 2021: David Card, Joshua D. Angrist y Guido W. Imbens

> **Motivación oficial:**  
> - **David Card:** *"for his empirical contributions to labour economics"* (Por sus contribuciones empíricas a la economía laboral).  
> - **Joshua D. Angrist y Guido W. Imbens:** *"for their methodological contributions to the analysis of causal relationships"* (Por sus contribuciones metodológicas al análisis de relaciones causales).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 11 de octubre de 2021.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Card, Angrist e Imbens (AER 1994, Econometrica 1994, AER 1990, ILR Review 1990, QJE 1991, libro Princeton 2009) y los informes científicos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Almacén de documentos de acceso abierto (`nobel2021scientific.pdf`, `nobel2021popular.pdf`, `card1993minimum_w4509.pdf`, `imbens1992late_t0118.pdf`, `angrist1989draft_w3014.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación completa con derivación econométrica, estimación en R, diagnóstico de supuestos y discusión de controversias.
  - [R/diferencias_en_diferencias_card.R](replicacion/R/diferencias_en_diferencias_card.R): Script autónomo en R que realiza el cálculo de la tabla 2x2 DiD, las regresiones de MCO y de panel con efectos fijos por restaurante, y la generación de figuras y tablas.
  - [datos/](replicacion/datos/): Datos originales de la encuesta a 410 restaurantes de comida rápida de New Jersey y Pennsylvania (`cardkrueger1994.csv`, `cardkrueger1994.dta`).
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_did_salario_minimo.png`, `fig_late_angrist_imbens.png`) y tabla de resultados (`tab_did_estimacion.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: tabla 2x2 DiD y cálculo de cambios; intermedio: supuesto de tendencias paralelas y amenazas empíricas; avanzado: marco LATE, compliers y el estimador de Wald).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas docentes, derivaciones algebraicas rigurosas y solucionario detallado.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

David Card, Joshua D. Angrist y Guido W. Imbens revolucionaron la economía empírica y las ciencias sociales al instaurar la **"Revolución de la Credibilidad"** (*Credibility Revolution*):
1. **El Poder de los Experimentos Naturales:** Frente a la imposibilidad ética o práctica de realizar experimentos clínicos de laboratorio en la sociedad, demostraron que situaciones del mundo real —como modificaciones en fronteras legislativas entre estados vecinos o sorteos aleatorios— pueden ser aprovechadas para inferir causalidad con rigor inmaculado.
2. **Revisión Empírica del Mercado Laboral:** David Card y Alan Krueger (1994) probaron empíricamente que un aumento moderado del salario mínimo en New Jersey frente a Pennsylvania no redujo el empleo juvenil en locales de comida rápida, derrumbando dogmas simplistas y estimulando el análisis de imperfecciones de mercado (como el monopsonio).
3. **El Teorema del Efecto Tratamiento Promedio Local (LATE):** Joshua Angrist y Guido Imbens (1994) demostraron formalmente que, en presencia de cumplimiento imperfecto, las Variables Instrumentales identifican de manera nítida el efecto causal promedio en el subgrupo de "cumplidores" (*compliers*), dotando de una base teórica sólida y transparente a la evaluación de programas sociales, educativos y de salud pública en todo el mundo.

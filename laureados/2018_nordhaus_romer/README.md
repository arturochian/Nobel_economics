# Nobel de Economía 2018: William D. Nordhaus y Paul M. Romer

> **Motivaciones oficiales:**
> - **William D. Nordhaus:** *"for integrating climate change into long-run macroeconomic analysis"* (Por integrar el cambio climático en el análisis macroeconómico de largo plazo).
> - **Paul M. Romer:** *"for integrating technological innovations into long-run macroeconomic analysis"* (Por integrar las innovaciones tecnológicas en el análisis macroeconómico de largo plazo).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 8 de octubre de 2018.

---

## Estructura y Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones fundamentales de Nordhaus (1993, 2007, 2013, 2017) y Romer (1986, 1990, 1994), junto con el documento de trasfondo científico oficial de la Academia Sueca.
  - [manifest.csv](referencias/manifest.csv): Control de metadatos de las fuentes académicas, DOIs, URLs y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Directorio preparado para almacenamiento de documentos de libre acceso (`.gitkeep`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con la derivación matemática de ambos modelos, análisis del Costo Social del Carbono y discusión de la doble falla de mercado.
  - [R/modelo_dice_y_romer.R](replicacion/R/modelo_dice_y_romer.R): Script autónomo en R que simula las ecuaciones biofísicas y económicas del modelo DICE de Nordhaus y la asignación intersectorial de investigadores en el modelo de Romer (1990).
  - [salidas/](replicacion/salidas/): Figuras en alta resolución y tablas generadas por la ejecución del script:
    - [fig_dice_trayectoria_clima.png](replicacion/salidas/fig_dice_trayectoria_clima.png): Proyecciones de temperatura (2020--2100) y Costo Social del Carbono bajo BAU, Nordhaus Óptimo y Stern Ético.
    - [fig_romer_crecimiento_ideas.png](replicacion/salidas/fig_romer_crecimiento_ideas.png): Dinámica comparativa de acumulación de ideas y PIB per cápita (Mercado vs Subsidio a I+D vs Óptimo Social).
    - [tab_dice_escenarios_carbono.csv](replicacion/salidas/tab_dice_escenarios_carbono.csv): Métricas cuantitativas clave de temperatura, daño porcentual al PIB y SCC proyectado.
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con 3 ejercicios prácticos estructurados (básico: tasa de descuento de Stern vs Nordhaus; intermedio: bienes no rivales y colapso de la competencia perfecta con Teorema de Euler; avanzado/reto: diseño coordinado de impuestos al carbono y subsidios a la innovación limpia).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pauta confidencial de evaluación y resolución analítica detallada para los docentes.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada con front-matter YAML para integración en el portal estático del proyecto.

---

## Resumen Ejecutivo del Aporte

William D. Nordhaus y Paul M. Romer redefinieron los límites de la macroeconomía moderna al integrar de manera rigurosa dos factores determinantes para el bienestar humano:

1. **La Naturaleza y el Clima (Nordhaus):**
   - Creó los **Modelos de Evaluación Integrada** (IAM), destacando el modelo **DICE** (*Dynamic Integrated Climate-Economy*), uniendo la acumulación de capital, las emisiones de gases de efecto invernadero y la inercia térmica planetaria con funciones empíricas de daño económico.
   - Formalizó el concepto y cálculo del **Costo Social del Carbono (SCC)**, demostrando que la atmósfera es un bien público global sobreexplotado que requiere precios uniformes al carbono (impuestos pigouvianos o mercados de permisos de emisión como el EU ETS) para alinear los costos privados con los costos sociales.

2. **Las Ideas y el Conocimiento (Romer):**
   - Demostró que el progreso tecnológico es el resultado deliberado de inversiones económicas impulsadas por incentivos de mercado (**crecimiento endógeno**), no un residuo exógeno no explicado.
   - Formuló la propiedad económica revolucionaria de las **ideas como bienes no rivales**: pueden ser utilizadas simultáneamente por un número ilimitado de personas sin agotarse, lo que genera rendimientos crecientes a escala agregados.
   - Probó que la acumulación de ideas es incompatible con la competencia perfecta tradicional (Teorema de Euler) y que los mercados descentralizados generan una subinversión estructural en investigación y desarrollo ($s_A^{\text{mercado}} < s_A^{\text{óptimo}}$), fundamentando económicamente los subsidios a la ciencia, las universidades y las patentes temporales.

3. **La Síntesis para la Transición Ecológica:**
   - Abordar el cambio climático exige coordinar ambos aportes: internalizar el daño de la externalidad fósil negativa fijando precios al carbono (Nordhaus) y corregir la externalidad positiva de los bienes no rivales mediante subsidios masivos a la innovación en tecnologías limpias (Romer).

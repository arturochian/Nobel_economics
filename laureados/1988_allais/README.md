# Nobel de Economía 1988: Maurice Allais

> **Motivación oficial:**  
> *"for his pioneering contributions to the theory of markets and efficient utilization of resources"* (Por sus contribuciones pioneras a la teoría de los mercados y la utilización eficiente de los recursos).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 18 de octubre de 1988.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras cumbres de Allais (*À la recherche d'une discipline économique* 1943, *Économie et Intérêt* 1947, *Econometrica* 1953, Discurso Nobel 1989), los desarrollos de Machina (1982) y Boiteux (1956), y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI, enlaces verificados y estado de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la derivación matemática, gráficos analíticos y comparación cuantitativa reproducible.
  - [R/paradoja_allais_y_eficiencia.R](replicacion/R/paradoja_allais_y_eficiencia.R): Script autónomo y modular en R que modela la Paradoja de Allais en el triángulo símplex de Marschak-Machina (apertura en abanico) y simula el modelo de regulación de monopolio natural bajo costo marginal vs. costo medio.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_allais_paradoja_triangulo.png](replicacion/salidas/fig_allais_paradoja_triangulo.png), [fig_allais_tarificacion_costo_marginal.png](replicacion/salidas/fig_allais_tarificacion_costo_marginal.png)) y tabla consolidada de resultados ([tab_resultados_allais.csv](replicacion/salidas/tab_resultados_allais.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: paradoja de Allais y efecto certeza; intermedio: tarificación al costo marginal y tarifas en dos partes; reto: derivación analítica de la Regla de Oro del capital e ineficiencia dinámica).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, fundamentos analíticos y solucionario completo paso a paso con rúbrica de evaluación para los docentes.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo de las Contribuciones

Maurice Allais (1911–2010), distinguido ingeniero de minas y economista francés, fue el fundador de la escuela francesa de ingenieros-economistas y uno de los teóricos cuantitativos más originales del siglo XX:

1. **La Paradoja de Allais (1953):**
   - Demostró experimentalmente que el comportamiento de los decisores reales bajo incertidumbre viola de forma sistemática el **axioma de independencia** de la teoría de la utilidad esperada de von Neumann y Morgenstern.
   - Identificó el **efecto certeza** (*certainty effect*): los individuos sobrevaloran drásticamente las ganancias 100% seguras en relación con ganancias meramente probables.
   - Dio pie a la hipótesis de apertura en abanico (*fanning out*) en el triángulo de Marschak-Machina y sentó las bases para el surgimiento de la economía conductual (*behavioral economics*) y la teoría prospectiva (*Prospect Theory*) de Kahneman y Tversky.

2. **Teoría de los Mercados y Eficiencia Asignativa (1943, 1952):**
   - Formuló de manera independiente y simultánea los **dos Teoremas Fundamentales de la Economía del Bienestar**, probando que el equilibrio competitivo general es óptimo en el sentido de Pareto.
   - Demostró que la maximización del excedente social exige obligatoriamente la **tarificación al costo marginal** ($P = CMg$).
   - Resolvió el dilema del monopolio natural (donde el costo marginal es inferior al costo medio, provocando déficit de explotación), proponiendo esquemas de tarifas en dos partes y subsidios estatales no distorsionantes, aplicados ampliamente en empresas públicas como Électricité de France (EDF) y SNCF.

3. **La Regla de Oro de la Acumulación de Capital (1947):**
   - En su tratado *Économie et Intérêt* (1947), dedujo catorce años antes que Edmund Phelps que el consumo per cápita en estado estacionario se maximiza cuando la tasa de interés real neta iguala la tasa de crecimiento demográfico ($r = n$).
   - Definió conceptualmente la **ineficiencia dinámica**: el despilfarro intertemporal que ocurre cuando una economía sobreahorra, acumulando un exceso de capital cuya reposición cuesta más que el producto marginal que rinde.

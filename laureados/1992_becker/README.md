# Nobel de Economía 1992: Gary S. Becker

> **Motivación oficial:** *"for having extended the domain of microeconomic analysis to a wide range of human behaviour and interaction, including nonmarket behaviour"* (Por haber extendido el dominio del análisis microeconómico a un amplio rango del comportamiento y la interacción humana, incluyendo la conducta no mercantil).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 13 de octubre de 1992.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las obras clave de Gary S. Becker (1957–1993) y los documentos oficiales del Comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de publicaciones, identificadores DOI, enlaces verificados y estado de licencias de acceso.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos de libre acceso y reportes oficiales del Comité Nobel.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte reproducible en Quarto con el desarrollo teórico y empírico de la economía del crimen, los perfiles de capital humano y la economía de la familia.
  - [R/crimen_capital_humano_y_familia.R](replicacion/R/crimen_capital_humano_y_familia.R): Script autónomo en R que simula y optimiza la política penal de Becker (1968) y modela los perfiles edad-ingreso bajo formación general y específica (1964).
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_becker_crimen_disuasion.png](replicacion/salidas/fig_becker_crimen_disuasion.png), [fig_becker_capital_humano_perfiles.png](replicacion/salidas/fig_becker_capital_humano_perfiles.png)) y tabla de resultados numéricos ([tab_resultados_becker.csv](replicacion/salidas/tab_resultados_becker.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de 3 ejercicios prácticos (básico sobre el modelo de crimen, utilidad esperada y elasticidades de disuasión; intermedio sobre formación general vs específica y cálculo de VPN; avanzado/reto en R sobre la economía de la familia y el trade-off calidad-cantidad de hijos).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, derivaciones matemáticas completas, código R reproducible para el reto demográfico y rúbrica analítica confidencial para el profesor.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada con front-matter YAML para su integración en el portal web del proyecto.

---

## Resumen Ejecutivo del Aporte

Gary S. Becker es universalmente reconocido como el economista que expandió las fronteras de la microeconomía hacia el estudio riguroso de fenómenos sociales tradicionalmente considerados ajenos a los mercados:

1. **Teoría del Capital Humano (1964):** Formalizó que las destrezas, conocimientos y salud de los trabajadores son activos de capital acumulables. Su distinción entre **formación general** (transferible y financiada por el trabajador mediante salarios iniciales menores) y **formación específica** (no transferible, con costos y rentas compartidas entre firma y empleado) explicó los perfiles de ingresos cóncavos en el ciclo de vida y la estabilidad laboral ante recesiones.
2. **Economía de la Discriminación (1957):** Modeló el prejuicio como un "coeficiente de discriminación" en la función de utilidad de los empleadores, demostrando que discriminar impone un costo monetario al discriminador y que los mercados competitivos ejercen una fuerza disciplinante que penaliza a las firmas prejuiciosas frente a las eficientes.
3. **Economía del Crimen y Castigo (1968):** Formuló la decisión de infringir la ley como un problema de maximización de utilidad esperada frente a la probabilidad de captura ($p$) y la severidad del castigo ($f$). Desarrolló la regla del planificador social que minimiza el costo social neto del delito y demostró que delincuentes con preferencia por el riesgo son más disuadidos por la certidumbre de arresto que por la severidad nominal de las penas.
4. **Economía de la Familia (1974, 1981):** Analizó el matrimonio como un mercado de emparejamiento assortativo, la fecundidad mediante la interacción entre la cantidad y calidad de los hijos, y la cooperación doméstica mediante el célebre "Teorema del Niño Malcriado" (*Rotten Kid Theorem*).

---

## Instrucciones de Reproducción

Para ejecutar el script de replicación y regenerar todas las figuras y tablas desde la raíz del proyecto:

```bash
# Ejecutar script R
Rscript laureados/1992_becker/replicacion/R/crimen_capital_humano_y_familia.R
```

Para renderizar el informe de Quarto:

```bash
quarto render laureados/1992_becker/replicacion/replicar.qmd
```

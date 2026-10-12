# Nobel de Economía 2025: Joel Mokyr, Philippe Aghion y Peter Howitt

> **Motivación oficial:** *"for having explained innovation-driven economic growth"* (Por haber explicado el crecimiento económico impulsado por la innovación).  
> - **Joel Mokyr (1/2):** *"for having identified the prerequisites for sustained growth through technological progress"* (Por haber identificado los prerrequisitos para el crecimiento sostenido a través del progreso tecnológico).  
> - **Philippe Aghion y Peter Howitt (1/2 conjuntamente):** *"for the theory of sustained growth through creative destruction"* (Por la teoría del crecimiento sostenido a través de la destrucción creativa).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 13 de octubre de 2025.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Mokyr, Aghion y Howitt y los documentos científicos oficiales de la Real Academia Sueca de Ciencias.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y licencias de acceso de las obras clave.
  - [pdf/](referencias/pdf/): Directorio preparado para almacenamiento de documentos de libre acceso.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación analítica y dinámica del modelo de crecimiento schumpeteriano y la relación de competencia e innovación.
  - [R/modelo_crecimiento_schumpeteriano.R](replicacion/R/modelo_crecimiento_schumpeteriano.R): Script autónomo en R que simula la dinámica de I+D, el proceso de Poisson de saltos de calidad, la comparación con el modelo neoclásico de Solow y la curva en U-invertida de competencia.
  - [salidas/](replicacion/salidas/): Figuras generadas en alta resolución (`fig_destruccion_creativa.png`, `fig_u_invertida_competencia.png`) y tabla de simulación de escenarios de política (`tab_simulacion_crecimiento.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Cuaderno de 3 ejercicios prácticos graduados (básico sobre tasa de innovación y obsolescencia, intermedio sobre la U-invertida de competencia, y avanzado/reto sobre subsidios a I+D vs. patentes).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Guía pedagógica confidencial con soluciones analíticas, cuantitativas y de economía política.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con YAML front-matter para integración en la plataforma web del repositorio.

---

## Resumen Ejecutivo del Aporte

Joel Mokyr, Philippe Aghion y Peter Howitt unificaron la teoría económica y la historia institucional para descifrar el motor del enriquecimiento moderno de las naciones:

1. **Philippe Aghion y Peter Howitt (1992, 1998):** Formalizaron matemáticamente la intuición de Joseph Schumpeter en un modelo de crecimiento endógeno con saltos de calidad (*quality ladders*). Demostraron que el motor del crecimiento es la búsqueda de rentas monopólicas mediante I+D, donde cada innovación exitosa desplaza inevitablemente a la tecnología anterior (*destrucción creativa*). Más adelante, demostraron la célebre relación de **U-invertida entre competencia e innovación** (Aghion et al. 2005).
2. **Joel Mokyr (1990, 2002):** Identificó los fundamentos epistemológicos e institucionales de la Revolución Industrial. Demostró que el crecimiento moderno se originó en la **Ilustración Industrial**, un fenómeno cultural e institucional que redujo los costos de acceso al "conocimiento útil" y conectó la ciencia teórica ($\Omega$) con las habilidades técnicas prácticas ($\lambda$).

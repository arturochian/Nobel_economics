# Nobel de Economía 1998: Amartya Sen

> **Motivación oficial:** *"for his contributions to welfare economics"* (Por sus contribuciones a la economía del bienestar).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 14 de octubre de 1998.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las 10 obras clave de Amartya Sen y los reportes oficiales de la Real Academia Sueca de Ciencias (1970–1999).
  - [manifest.csv](referencias/manifest.csv): Control de publicaciones, identificadores DOI, enlaces verificados y estado de licencias de acceso.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos de libre acceso y reportes oficiales del Comité Nobel.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte reproducible en Quarto con el desarrollo teórico y empírico de la medición axiomática de la pobreza y el colapso de titularidades en hambrunas.
  - [R/capacidades_pobreza_y_hambrunas.R](laureados/1998_sen/replicacion/R/capacidades_pobreza_y_hambrunas.R): Script autónomo en R que calcula el Índice de Sen $P_S = H [I + (1-I) G_p]$ bajo diferentes axiomas distributivos y simula dinámicamente la hambruna de Bengala de 1943 con FAD nulo.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_sen_indice_pobreza.png](replicacion/salidas/fig_sen_indice_pobreza.png), [fig_sen_hambrunas_titularidades.png](replicacion/salidas/fig_sen_hambrunas_titularidades.png)) y tabla de resultados numéricos ([tab_resultados_sen.csv](replicacion/salidas/tab_resultados_sen.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de 3 ejercicios prácticos (básico sobre descomposición analítica del Índice de Sen y axiomas éticos, intermedio sobre la Paradoja del Liberal Paretiano y ciclos de elección social, avanzado/reto sobre modelación de titularidades y evaluación de políticas anti-hambruna en R).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, deducciones matemáticas completas, soluciones numéricas, código en R para el reto y rúbrica analítica confidencial para el profesor.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada con front-matter YAML para su integración en el portal web del proyecto.

---

## Resumen Ejecutivo del Aporte

Amartya Sen revolucionó la ciencia económica al devolverle una dimensión ética y filosófica insoslayable, conectando la teoría de la elección colectiva, la medición del bienestar y las políticas de erradicación de la pobreza extrema:

1. **Economía del Bienestar y Elección Social (1970):** Demostró que el pesimismo del Teorema de Imposibilidad de Arrow puede superarse introduciendo la comparabilidad interpersonal parcial de utilidades. A su vez, formuló la **Paradoja del Liberal Paretiano** (*The Impossibility of a Paretian Liberal*), probando que la eficiencia de Pareto y el respeto irrestricto a los derechos y libertades individuales son matemáticamente incompatibles.
2. **Medición Axiomática de la Pobreza y Enfoque de Capacidades (1976, 1985, 1999):** Formuló el célebre **Índice de Pobreza de Sen** ($P_S = H [I + (1-I) G_p]$), integrando la incidencia ($H$), la profundidad ($I$) y la desigualdad interna entre los pobres ($G_p$) para satisfacer los axiomas éticos de monotonía y transferencia. Más tarde concibió el **Enfoque de Capacidades** (*Capability Approach*), evaluando el bienestar no por los bienes poseídos sino por las libertades reales de las personas para funcionar y desarrollarse, inspirando la creación del Índice de Desarrollo Humano (IDH) del PNUD.
3. **Economía de las Hambrunas y Titularidades (1981):** En *Poverty and Famines*, desmanteló la creencia generalizada de que las hambrunas se deben a caídas repentinas en la oferta física de alimentos (*Food Availability Decline*, FAD). Probó que en catástrofes como la de Bengala (1943) la producción fue normal o superior a la media, pero millones murieron por un **fallo de titularidades** (*entitlement failure*) derivado de la inflación y la pérdida de poder adquisitivo de los jornaleros sin tierra.

---

## Instrucciones de Reproducción

Para ejecutar el script de replicación y generar las figuras y tablas desde la raíz del proyecto:

```bash
# Ejecutar script R
Rscript laureados/1998_sen/replicacion/R/capacidades_pobreza_y_hambrunas.R
```

Para renderizar el informe de Quarto:

```bash
quarto render laureados/1998_sen/replicacion/replicar.qmd
```

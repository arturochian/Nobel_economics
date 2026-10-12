# Nobel de Economía 2015: Angus Deaton

> **Motivación oficial:** *"for his analysis of consumption, poverty, and welfare"* (Por su análisis del consumo, la pobreza y el bienestar).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 12 de octubre de 2015.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las 9 obras clave de Angus Deaton y los reportes oficiales del Comité Nobel (1980–2020).
  - [manifest.csv](referencias/manifest.csv): Control de publicaciones, identificadores DOI, enlaces verificados y estado de licencias de acceso.
  - [pdf/](referencias/pdf/): Almacén para documentos de libre acceso y reportes de la Real Academia Sueca de Ciencias.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte reproducible en Quarto con el desarrollo teórico y empírico del sistema AIDS y la paradoja del consumo.
  - [R/modelo_demanda_aids.R](replicacion/R/modelo_demanda_aids.R): Script autónomo en R que estima el Sistema Casi Ideal de Demanda (AIDS), deriva matrices de elasticidades y simula la dinámica intertemporal de exceso de suavidad frente a shocks de ingreso.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_curvas_engel_aids.png](replicacion/salidas/fig_curvas_engel_aids.png), [fig_paradoja_deaton_consumo.png](replicacion/salidas/fig_paradoja_deaton_consumo.png)) y tabla de elasticidades estimadas ([tab_elasticidades_aids.csv](replicacion/salidas/tab_elasticidades_aids.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de 3 ejercicios prácticos (básico sobre curvas de Engel y bienes necesarios vs. de lujo, intermedio sobre la Paradoja de Deaton y la PIH, avanzado/reto sobre escalas de equivalencia y medición de pobreza en encuestas de hogares).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, deducciones matemáticas completas, soluciones numéricas y rúbrica confidencial para el profesor.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada con front-matter YAML para su integración en el portal web del proyecto.

---

## Resumen Ejecutivo del Aporte

Angus Deaton transformó la ciencia económica al conectar de forma inédita la teoría microeconómica del consumidor, la macroeconomía del consumo intertemporal y la economía empírica del bienestar:

1. **El Sistema Casi Ideal de Demanda (AIDS, 1980):** Junto a John Muellbauer, revolucionó el análisis de la demanda al formular un sistema matemático flexible que permite estimar cómo las familias redistribuyen su presupuesto ante cambios de precios e ingresos sin imponer restricciones arbitrarias, convirtiéndose en el estándar universal de los ministerios de hacienda para diseñar políticas tributarias y de bienestar.
2. **La Paradoja de Deaton y el Ahorro Precautorio (1987, 1989, 1991):** Evidenció empíricamente que el consumo agregado es mucho más suave de lo que predice la Hipótesis del Ingreso Permanente con shocks persistentes (*excess smoothness*), demostrando que las restricciones de liquidez a nivel micro y el ahorro precautorio (*buffer-stock saving*) impiden a los hogares endeudarse libremente contra sus ingresos futuros.
3. **Pobreza, Bienestar y 'Muertes por Desesperación' (1997, 2015, 2020):** Como consultor y referente del Banco Mundial, sentó las bases metodológicas para recolectar e interpretar encuestas de hogares en países en desarrollo, alertó sobre los sesgos de las líneas globales de pobreza absoluta y, junto a Anne Case, descubrió la alarmante crisis de mortalidad en adultos de mediana edad en Estados Unidos causada por suicidios, alcoholismo y la epidemia de opiáceos (*deaths of despair*).

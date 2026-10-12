# Nobel de Economía 1993: Robert W. Fogel y Douglass C. North

> **Motivación oficial:** *"for having renewed research in economic history by applying economic theory and quantitative methods in order to explain economic and institutional change"* (Por haber renovado la investigación en historia económica aplicando la teoría económica y métodos cuantitativos para explicar el cambio económico e institucional).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 12 de octubre de 1993.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las obras seminales de Robert W. Fogel y Douglass C. North y los reportes oficiales del Comité Nobel (1962–1994).
  - [manifest.csv](referencias/manifest.csv): Inventario de publicaciones, identificadores DOI, enlaces verificados y estado de licencias de acceso.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos oficiales del Comité Nobel y artículos en acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte reproducible integral en Quarto con el desarrollo teórico, empírico y econométrico del ahorro social contrafáctico de Fogel y el modelo de instituciones y compromiso creíble de North.
  - [R/cliometria_ferrocarriles_e_instituciones.R](replicacion/R/cliometria_ferrocarriles_e_instituciones.R): Script autónomo y modular en R que calcula el ahorro social ($SS$) en EE. UU. (1890) bajo distintos supuestos de elasticidad y simula el impacto de los derechos de propiedad y la Revolución Gloriosa inglesa (1688) sobre las tasas de interés y los costos de transacción.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_fogel_ahorro_social_contrafactico.png](replicacion/salidas/fig_fogel_ahorro_social_contrafactico.png), [fig_north_instituciones_crecimiento.png](replicacion/salidas/fig_north_instituciones_crecimiento.png)) y tabla de resultados cliométricos ([tab_resultados_cliometria.csv](replicacion/salidas/tab_resultados_cliometria.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con 3 ejercicios formativos (básico sobre ahorro social contrafáctico de Fogel, intermedio sobre compromiso creíble de North y Weingast en 1688, y avanzado/reto en R sobre costos de transacción y tamaño de mercado).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Material confidencial para profesores: derivaciones matemáticas completas, soluciones cuantitativas paso a paso, código en R para el reto y rúbrica analítica de evaluación.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada con metadatos YAML y secciones canónicas para el portal web del proyecto.

---

## Resumen Ejecutivo del Aporte

Robert W. Fogel y Douglass C. North fundaron y consolidaron la **Cliometría** (o *Nueva Historia Económica*), transformando el estudio del pasado mediante la aplicación rigurosa de la teoría económica formal y las técnicas econométricas modernas:

1. **Robert W. Fogel y la Medición Contrafáctica del Ahorro Social (1964):**
   - Demolió el "axioma de indispensabilidad" de los ferrocarriles para el desarrollo de Estados Unidos.
   - Diseñó el concepto metodológico de **ahorro social contrafáctico** (*social saving*): calculó el costo de transportar los bienes de 1890 mediante un sistema alternativo de canales, ríos navegables y carreteras en lugar del ferrocarril.
   - Demostró que el ahorro social total representó únicamente entre el **2.7% y el 4.7% del PNB** de EE. UU. en 1890. El ferrocarril adelantó el crecimiento nacional en tan solo uno o dos años, probando que el crecimiento económico moderno no surge de una sola tecnología revolucionaria milagrosa, sino de una multitud de innovaciones incrementales complementarias.
   - Asimismo, revolucionó el estudio cuantitativo de la economía esclavista (*Time on the Cross*, 1974) y fundó la historia antropométrica y tecnofisiológica sobre nutrición, estatura y mortalidad a largo plazo.

2. **Douglass C. North y la Nueva Economía Institucional (1973, 1989, 1990):**
   - Redefinió las **instituciones** como *"las reglas del juego en una sociedad"* (límites formales como leyes y constituciones, y restricciones informales como costumbres y modelos mentales).
   - Postuló que el capital, la tecnología y el trabajo no son las *causas* del crecimiento económico sostenido, sino *el crecimiento en sí mismo*; la causa primordial reside en instituciones eficientes que generen derechos de propiedad seguros y alineen el rendimiento privado con el rendimiento social.
   - En *North & Weingast (1989)*, demostró que la Revolución Gloriosa de 1688 en Inglaterra introdujo un **compromiso creíble** (*credible commitment*) al subordinar la Corona al Parlamento, protegiendo los derechos de propiedad y colapsando las tasas de interés de la deuda soberana de ~11.5% a ~3.8%, lo que desató la revolución financiera previa a la Revolución Industrial.
   - Conceptualizó los **costos de transacción** y la **dependencia de la trayectoria** (*path dependence*), explicando por qué economías ineficientes pueden quedar atrapadas en trampas de atraso durante siglos.

---

## Instrucciones de Reproducción

Para ejecutar el script de replicación y regenerar todas las figuras y tablas desde la raíz del repositorio:

```powershell
# Ejecutar script R de cliometria
Rscript laureados/1993_fogel_north/replicacion/R/cliometria_ferrocarriles_e_instituciones.R
```

Para compilar el informe reproducible en Quarto a formato HTML:

```powershell
quarto render laureados/1993_fogel_north/replicacion/replicar.qmd
```

# Nobel de Economía 2004: Finn E. Kydland y Edward C. Prescott

> **Motivación oficial:** *"for their contributions to dynamic macroeconomics: the time consistency of economic policy and the driving forces behind business cycles"* (por sus contribuciones a la macroeconomía dinámica: la consistencia temporal de la política económica y las fuerzas impulsoras detrás de los ciclos económicos).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 11 de octubre de 2004.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Entradas BibTeX verificadas de las obras seminales de Kydland y Prescott (1977, 1982, 1997), extensiones clave (Barro-Gordon 1983, Rogoff 1985) y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Inventario sistemático de fuentes, identificadores DOI, enlaces canónicos y licencias de acceso.
  - [pdf/](referencias/pdf/): Directorio preparado para albergar documentos y reportes oficiales de la Real Academia Sueca de Ciencias.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Documento Quarto reproducible con desarrollo matemático exhaustivo, simulación del dilema de consistencia temporal (reglas vs. discreción) y calibración dinámica del modelo RBC con filtro Hodrick-Prescott.
  - [R/consistencia_temporal_y_rbc.R](replicacion/R/consistencia_temporal_y_rbc.R): Script autónomo en R que simula la teoría de juegos de política monetaria y la dinámica estocástica de equilibrio general con descomposición matricial del filtro HP.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución (`fig_kydland_consistencia_temporal.png`, `fig_prescott_rbc_ciclos.png`) y matriz de resultados cuantitativos consolidada (`tab_resultados_kydland_prescott.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica estructurada con tres niveles de dificultad (básico: álgebra del sesgo inflacionario; intermedio: delegación institucional y banquero conservador de Rogoff; avanzado/reto: derivación matricial del filtro HP y momentos empíricos del modelo RBC).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Manual confidencial para profesores con derivaciones analíticas paso a paso, demostraciones formales, soluciones numéricas y rúbrica de corrección pedagógica.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha canónica con metadatos estructurados en YAML para el portal web del proyecto Nobel_economics.

---

## Resumen Ejecutivo del Aporte

Finn E. Kydland y Edward C. Prescott transformaron de manera radical la teoría macroeconómica moderna y la práctica de las políticas públicas a través de dos innovaciones revolucionarias:

1. **Inconsistencia Temporal de la Política Económica (1977):**
   - **El fin de la teoría del control óptimo tradicional:** Kydland y Prescott demostraron que la política económica no puede concebirse como un problema de ingeniería física donde un planificador maneja variables inertes. Los agentes económicos privados toman decisiones mirando al futuro y formando expectativas racionales sobre la conducta futura del gobierno.
   - **El sesgo inflacionario de la discrecionalidad:** Cuando las autoridades gozan de discrecionalidad absoluta periodo a periodo, tienen un incentivo perverso a defraudar las expectativas previas (por ejemplo, generando inflación sorpresiva para reducir transitoriamente el desempleo a lo largo de una curva de Phillips de corto plazo). No obstante, los agentes privados anticipan este incentivo y elevan sus expectativas de inflación. En el equilibrio de Nash, el resultado es una inflación sistemáticamente más alta sin ganancia alguna en producción o empleo.
   - **Compromiso y diseño institucional:** La solución no reside en una mejor optimización discrecional, sino en la autolimitación mediante **reglas de política con compromiso creíble**, lo cual sentó las bases para los mandatos de inflación (*inflation targeting*) y la independencia formal de los bancos centrales modernos en todo el mundo.

2. **Teoría de los Ciclos Económicos Reales (RBC) y Dinámica Agregada (1982, 1997):**
   - **Las fluctuaciones como respuesta de equilibrio:** Frente al consenso previo que atribuía los ciclos económicos a fallas de mercado, desequilibrios monetarios o rigideces nominales, Kydland y Prescott probaron que una porción sustancial de las oscilaciones agregadas puede explicarse como la respuesta de equilibrio óptima de empresas y hogares racionales frente a choques exógenos de productividad y tecnología (el residuo de Solow).
   - **Microfundamentos y calibración cuantitativa:** Introdujeron la metodología de microfundamentar los modelos macroeconómicos mediante equilibrio general dinámico estocástico (DSGE), calibrando parámetros con microdatos y hechos estilizados de largo plazo en lugar de recurrir a regresiones econométricas ad-hoc sin restricciones.
   - **El Filtro Hodrick-Prescott (HP):** Desarrollaron una técnica matricial de optimización para aislar de forma no paramétrica las tendencias de crecimiento de las fluctuaciones cíclicas de alta frecuencia, estableciendo el estándar global para medir los hechos estilizados del ciclo macroeconómico.

---

## Cómo Ejecutar la Replicación

Para reproducir computacionalmente los modelos, generar las figuras y verificar las tablas desde PowerShell:

```powershell
& "C:\Program Files\R\R-4.6.0\bin\Rscript.exe" laureados/2004_kydland_prescott/replicacion/R/consistencia_temporal_y_rbc.R
```

O dentro de una sesión interactiva de R:

```r
source("laureados/2004_kydland_prescott/replicacion/R/consistencia_temporal_y_rbc.R")
```

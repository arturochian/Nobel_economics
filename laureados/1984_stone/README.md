# Nobel de Economía 1984: Sir Richard Stone

> **Motivación oficial:**  
> *"for having made fundamental contributions to the development of systems of national accounts and hence greatly improved the basis for empirical economic analysis"* (Por haber hecho contribuciones fundamentales al desarrollo de los sistemas de cuentas nacionales y por tanto haber mejorado enormemente las bases para el análisis económico empírico).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 25 de octubre de 1984.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras fundamentales de Stone (*The Economic Journal* 1941 con James Meade, *Linear Expenditure Systems* 1954, *The Measurement of Consumers' Expenditure* 1954, informes del SNA de Naciones Unidas 1953 y 1968, *Cambridge Growth Project* 1962, Discurso Nobel 1986) y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI, enlaces directos y régimen de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la derivación matemática del Sistema Lineal de Gasto (Stone-Geary), el álgebra de balance de la Matriz de Contabilidad Social (SAM) y los multiplicadores contables de Stone.
  - [R/cuentas_nacionales_y_sistema_gasto.R](replicacion/R/cuentas_nacionales_y_sistema_gasto.R): Script autónomo y reproducible en R que simula y estima el LES para múltiples bienes y modela el flujo circular de partida doble en una SAM de 7 cuentas institucionales.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_stone_sistema_gasto_les.png](replicacion/salidas/fig_stone_sistema_gasto_les.png), [fig_stone_matriz_contabilidad_sam.png](replicacion/salidas/fig_stone_matriz_contabilidad_sam.png)) y tabla estructurada de resultados ([tab_resultados_stone.csv](replicacion/salidas/tab_resultados_stone.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: Sistema Lineal de Gasto y consumo de subsistencia; intermedio: equilibrio contable y multiplicadores en una Matriz de Contabilidad Social; reto: consistencia de agregados macroeconómicos y calibración de un modelo CGE simple).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, fundamentos analíticos y solucionario completo paso a paso con rúbrica de evaluación para los docentes.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el portal web estático.

---

## Resumen Ejecutivo de las Contribuciones

Sir John Richard Nicholas Stone (1913–1991), profesor de la Universidad de Cambridge y director pionero del *Department of Applied Economics* (DAE), es reconocido internacionalmente como el **padre de la contabilidad nacional moderna**:

1. **El Sistema de Cuentas Nacionales (SNA 1953, 1968):**
   - Durante la Segunda Guerra Mundial, convocado por John Maynard Keynes al Tesoro británico junto con James Meade (Nobel 1977), diseñó el primer sistema integrado de estimación del ingreso nacional y el gasto británico (*White Paper* de 1941) para evaluar la capacidad bélica del país sin generar inflación hiperbólica.
   - Presidió y redactó los comités de estandarización de las Naciones Unidas que promulgaron el primer estándar internacional de Cuentas Nacionales (SNA 1953) y su profunda expansión estructural (SNA 1968).
   - Introdujo el principio de **partida doble cerrada en macromagnitudes**: cada transacción económica es a la vez un ingreso para un sector institucional y un egreso idéntico para otro, garantizando que el Producto Interno Bruto (PIB) calculado por la vía de la producción, el ingreso y el gasto coincida de forma unívoca y sin brechas estadísticas.

2. **Matrices de Contabilidad Social (SAM - Social Accounting Matrices):**
   - Lideró el *Cambridge Growth Project* (1962) con Alan Brown, articulando las tablas insumo-producto (*Input-Output*) de Wassily Leontief con las cuentas sectoriales de distribución institucional del ingreso.
   - Concibió la Matriz de Contabilidad Social (SAM) como una matriz cuadrada y balanceada donde las filas representan entradas financieras (ingresos) y las columnas representan salidas (gastos), cerrando el flujo circular entre actividades productivas, factores de producción (trabajo y capital), hogares desglosados y el sector público.
   - Creó los **multiplicadores contables de Stone** ($M = (I - A)^{-1}$), herramienta estándar en bancos centrales, el Banco Mundial y el FMI para cuantificar el impacto distributivo de transferencias fiscales y shocks sectoriales.

3. **El Sistema Lineal de Gasto (Linear Expenditure System - LES, 1954):**
   - En su artículo seminal de 1954 en *The Economic Journal*, formuló y estimó el primer sistema completo de demanda empíricamente contrastable y derivado rigurosamente de la teoría de maximización de la utilidad del consumidor (función de utilidad Stone-Geary).
   - Descompuso el gasto del hogar en dos componentes esenciales: el **gasto comprometido de subsistencia** ($\gamma_i$), que el consumidor debe adquirir obligatoriamente con independencia de su riqueza, y la asignación fraccionaria ($\beta_i$) del **ingreso supernumerario o discrecional** ($y - \sum p_j \gamma_j$).
   - Demostró cómo imponer y verificar econométricamente las restricciones teóricas fundamentales de la microeconomía: aditividad presupuestaria, homogeneidad de grado cero y simetría de Slutsky.

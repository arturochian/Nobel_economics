# Nobel de Economía 1977: Bertil Ohlin y James E. Meade

> **Motivación oficial:**  
> *"for their pathbreaking contribution to the theory of international trade and international capital movements"* (Por su contribución pionera a la teoría del comercio internacional y los movimientos internacionales de capital).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 14 de octubre de 1977.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras seminales de Bertil Ohlin (*Interregional and International Trade* 1933, Discurso Nobel 1977), James E. Meade (*The Balance of Payments* 1951, *Trade and Welfare* 1955, *The Theory of Customs Unions* 1955, Discurso Nobel 1977), los teoremas clave de Lipsey y Lancaster (1956), Stolper y Samuelson (1941) y el dictamen oficial de la Academia Nobel.
  - [manifest.csv](referencias/manifest.csv): Control metódico de fuentes bibliográficas, identificadores DOI/JSTOR/editorial, enlaces estables y régimen de derechos de autor.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia de libre acceso (Open Access).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la fundamentación analítica, derivación micro y macroeconómica, gráficos reproducibles y simulación computacional del modelo 2x2x2 y las curvas de política de Meade.
  - [R/heckscher_ohlin_y_segundo_mejor.R](replicacion/R/heckscher_ohlin_y_segundo_mejor.R): Script autónomo y modular en R que computa la caja de Edgeworth, las Fronteras de Posibilidades de Producción (FPP), la igualación de precios de factores (FPE), las curvas de Equilibrio Interno ($IB$) y Externo ($EB$) de Meade y la Teoría del Segundo Mejor en acuerdos comerciales preferenciales.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_ohlin_heckscher_comercio.png](replicacion/salidas/fig_ohlin_heckscher_comercio.png), [fig_meade_equilibrio_interno_externo.png](replicacion/salidas/fig_meade_equilibrio_interno_externo.png)) y tabla consolidada de escenarios ([tab_resultados_ohlin_meade.csv](replicacion/salidas/tab_resultados_ohlin_meade.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: dotaciones factoriales, ventaja comparativa y teorema de Rybczynski; intermedio: el diagrama de Meade, dilema de desequilibrio interno-externo y asignación de instrumentos; reto: la Teoría del Segundo Mejor de Meade, creación vs. desviación de comercio y uniones aduaneras).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, fundamentos analíticos, solucionario matemático completo paso a paso y rúbrica de evaluación detallada.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo de las Contribuciones

En 1977, la Real Academia Sueca de Ciencias premió conjuntamente al economista sueco **Bertil Ohlin** (1899–1979) y al economista británico **James Edward Meade** (1907–1995) por transformar de forma definitiva el análisis del comercio mundial, la movilidad de factores productivos y la política macroeconómica en economías abiertas.

### 1. Bertil Ohlin y el Modelo Heckscher-Ohlin (1933)
- **Superación del modelo ricardiano:**  
  David Ricardo explicó el comercio internacional a partir de diferencias tecnológicas exógenas entre países con un único factor de producción (trabajo). Ohlin, integrando y ampliando las intuiciones pioneras de su maestro Eli Heckscher (1919), formuló una teoría general sustentada en la **dotación relativa de múltiples factores de producción** (capital, trabajo, tierra).
- **El Teorema Heckscher-Ohlin (H-O):**  
  Un país con abundancia relativa de un factor productivo (por ejemplo, capital) disfrutará de un costo de autarquía relativamente más bajo en bienes cuya tecnología sea intensiva en dicho factor (maquinaria, manufacturas avanzadas), exportando dichos bienes e importando aquellos intensivos en su factor relativamente escaso (ropa, alimentos).
- **El Teorema de Igualación de Precios de los Factores (FPE):**  
  Ohlin demostró que el libre comercio de mercancías actúa como un sustituto perfecto o casi perfecto de la movilidad física de factores: al comercializar bienes intensivos en mano de obra o capital, los precios de los factores ($w$ y $r$) convergen internacionalmente, cerrando la brecha salarial entre naciones incluso en ausencia de migración de trabajadores o flujos de capital físico.
- **Teoremas conexos (HOS):**  
  Constituyó la matriz de la que emergieron el Teorema de Stolper-Samuelson (1941) —que explica la distribución interna del ingreso tras la apertura comercial— y el Teorema de Rybczynski (1955) sobre acumulación factorial sesgada.

### 2. James E. Meade: Equilibrio Interno, Externo y la Teoría del Segundo Mejor (1951, 1955)
- **El problema de la Balanza de Pagos (*The Balance of Payments*, 1951):**  
  Meade construyó el primer modelo riguroso de política macroeconómica para economías abiertas, articulando dos metas simultáneas:
  1. *Equilibrio Interno ($IB$):* Pleno empleo y estabilidad del nivel de precios ($Y = Y^*$).
  2. *Equilibrio Externo ($EB$):* Cuenta corriente equilibrada o posición externa sostenible ($CA = 0$).
- **Regla de Asignación y los Dos Instrumentos (Tinbergen-Meade):**  
  Para alcanzar dos metas independientes se precisan dos instrumentos de política independientes:
  - *Políticas de variación del gasto (Expenditure-changing):* Política fiscal y monetaria que regulan el nivel total de absorción interna ($A = C + I + G$).
  - *Políticas de reorientación del gasto (Expenditure-switching):* Tipo de cambio real ($R = e P^*/P$) o aranceles/subsidios que desvían el consumo entre bienes nacionales y extranjeros.
  Meade identificó las célebres cuatro zonas de desequilibrio macroeconómico y demostró el dilema donde las recetas tradicionales entran en contradicción (por ejemplo, recesión con déficit en balanza de pagos).
- **La Teoría del Segundo Mejor (*Theory of the Second Best*, 1955):**  
  En *Trade and Welfare* (1955) y *The Theory of Customs Unions* (1955), Meade formuló la advertencia normativa más profunda del análisis de bienestar: si en una economía existe una distorsión insalvable (un arancel no eliminable, un monopolio o una externalidad), eliminar otra distorsión de forma parcial no garantiza un aumento del bienestar social.
- **Creación vs. Desviación de Comercio:**  
  Aplicado a la integración económica regional (uniones aduaneras o tratados de libre comercio), Meade evidenció que acuerdos comerciales preferenciales pueden perjudicar el bienestar agregado si la *desviación de comercio* (reemplazar importaciones baratas de países terceros eficientes por bienes caros del socio regional) supera a la *creación de comercio*.

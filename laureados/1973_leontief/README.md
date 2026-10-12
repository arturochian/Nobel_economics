# Nobel de Economía 1973: Wassily Leontief

> **Motivación oficial:**  
> *"for the development of the input-output method and for its application to important economic problems"* (Por el desarrollo del método insumo-producto y por su aplicación a problemas económicos importantes).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 18 de octubre de 1973.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras seminales de Wassily Leontief (*Quantitative Input and Output Relations in the Economic System of the United States* 1936, *The Structure of American Economy, 1919-1929* 1941, *Domestic Production and Foreign Trade; The American Capital Position Re-Examined* 1953, *Input-Output Economics* 1966, Discurso Nobel 1974) y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI/JSTOR, enlaces estables y régimen de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia de acceso abierto.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la fundamentación analítica, derivaciones matriciales, descomposición por rondas de impacto (Serie de Neumann), cálculo de encadenamientos de Rasmussen y análisis empírico de la Paradoja de Leontief.
  - [R/insumo_producto_y_paradoja.R](replicacion/R/insumo_producto_y_paradoja.R): Script autónomo y modular en R que balancea una matriz insumo-producto de 4 sectores (Agricultura, Manufactura, Servicios, Energía), deriva los coeficientes técnicos y la matriz inversa $(I - A)^{-1}$, clasifica los sectores por poder y sensibilidad de dispersión, simula un shock de demanda final y calcula la intensidad factorial (Capital/Trabajo) de exportaciones e importaciones competitivas.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_leontief_matriz_multiplicadores.png](replicacion/salidas/fig_leontief_matriz_multiplicadores.png), [fig_leontief_paradoja_intensidad.png](replicacion/salidas/fig_leontief_paradoja_intensidad.png)) y tabla consolidada de indicadores estructurales ([tab_resultados_insumo_producto_1973.csv](replicacion/salidas/tab_resultados_insumo_producto_1973.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: construcción de coeficientes técnicos, inversión matricial y shock de demanda en una economía bidimensional; intermedio: multiplicadores de producción, encadenamientos de Rasmussen y taxonomía sectorial; reto: descomposición factorial directa e indirecta y evaluación de la Paradoja de Leontief).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, fundamentos analíticos, solucionario completo paso a paso y rúbrica de evaluación para los docentes.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el sitio web estático del proyecto.

---

## Resumen Ejecutivo de las Contribuciones

Wassily Leontief (1906–1999), economista ruso-estadounidense y profesor en la Universidad de Harvard y la Universidad de Nueva York, revolucionó la economía cuantitativa y la modelización empírica al transformar el concepto abstracto de interdependencia general en una herramienta matemática y estadística operativa:

### 1. El Método Insumo-Producto (Input-Output Analysis, 1936, 1941, 1966)
- **Operacionalización del Equilibrio General:**  
  Antes de Leontief, el equilibrio general walrasiano era un elegante sistema de ecuaciones puramente teórico sin aplicación empírica directa. Leontief concibió la economía como una red de flujos interindustriales donde la producción de cada sector requiere insumos intermedios provenientes de otros sectores, además de factores primarios (trabajo y capital).
- **La Matriz de Coeficientes Técnicos ($A$):**  
  Bajo el supuesto de rendimientos constantes a escala y proporciones fijas en el corto plazo (función de producción Leontief tipo $x_j = \min \{ z_{1j}/a_{1j}, \dots, z_{nj}/a_{nj} \}$), definió los coeficientes directos $a_{ij} = z_{ij} / x_j$, que cuantifican cuántas unidades monetarias del sector $i$ son consumidas directamente para producir una unidad del sector $j$.

### 2. La Matriz Inversa de Leontief y los Multiplicadores ($L = (I - A)^{-1}$)
- **Requerimientos Directos e Indirectos:**  
  A partir del balance contable $x = A x + y$ (donde $y$ es la demanda final y $x$ la producción bruta total), Leontief resolvió el sistema mediante la inversión matricial:
  $$x = (I - A)^{-1} y$$
  Cada elemento $L_{ij}$ de la matriz inversa mide cuánta producción bruta total del sector $i$ se necesita, tanto directa como indirectamente a lo largo de todas las cadenas de suministro, para satisfacer una unidad adicional de demanda final del sector $j$.
- **Expansión en Serie de Neumann y Rondas de Impacto:**  
  La inversa se descompone como la suma infinita de rondas productivas:
  $$(I - A)^{-1} = I + A + A^2 + A^3 + \dots$$
  donde $I$ representa el impacto directo, $A$ el requerimiento de insumos de primera ronda, $A^2$ el de segunda ronda, y así sucesivamente, garantizando convergencia siempre que el radio espectral de $A$ sea menor a la unidad (condiciones de Hawkins-Simon).
- **Encadenamientos de Rasmussen (Backward y Forward Linkages):**  
  Permitió identificar los "sectores clave" de una economía nacional: aquellos con un alto poder de dispersión hacia atrás (estimulan fuertemente a sus proveedores upstream) y una alta sensibilidad de dispersión hacia adelante (abastecen insumos críticos a las industrias downstream).

### 3. La Paradoja de Leontief (1953)
- **Desafío Empírico al Teorema de Heckscher-Ohlin:**  
  El teorema clásico de Heckscher-Ohlin postulaba que un país exporta bienes intensivos en su factor de producción relativamente abundante e importa bienes intensivos en su factor escaso. En 1947, Estados Unidos era indiscutiblemente la economía con mayor abundancia relativa de capital en el mundo.
- **El Hallazgo Sorprendente:**  
  Al calcular por primera vez el contenido factorial total (directo e indirecto) de la canasta comercial estadounidense utilizando la matriz insumo-producto de 1947, Leontief descubrió que:
  - Un millón de dólares de exportaciones estadounidenses requería **menos capital por trabajador** que un millón de dólares de bienes que sustituían importaciones competitivas ($(K/L)_{exp} < (K/L)_{imp}$).
  - La relación de intensidad factorial era de aproximadamente $0.77$, lo que implicaba que Estados Unidos se comportaba empíricamente como un exportador neto de servicios de trabajo y un importador neto de servicios de capital.
- **Revolución en la Teoría del Comercio Internacional:**  
  La paradoja forzó a la profesión a abandonar los modelos bidimensionales simples y catalizó el desarrollo de la teoría del capital humano, los modelos de liderazgo tecnológico y R&D, las inversiones factoriales y el análisis multidimensional de comercio.

### 4. Relevancia Contemporánea y Aplicaciones Actuales
- **Tablas Input-Output Globales:** Bases de datos como WIOD (World Input-Output Database), TiVA (Trade in Value Added de la OCDE-OMC) y EORA aplican directamente la formulación de Leontief a nivel multirregional para descomponer las cadenas globales de valor (GVCs).
- **Contabilidad de Huella de Carbono y Emisiones:** El modelo ambiental de Leontief ($e' (I - A)^{-1} y$) es el estándar metodológico internacional para calcular las emisiones de gases de efecto invernadero basadas en el consumo (Scope 3).
- **Evaluación de Resiliencia ante Shocks de Suministro:** Empleado sistemáticamente por bancos centrales y gobiernos para medir la vulnerabilidad de las economías ante disrupciones de cuellos de botella en energía, semiconductores y materias primas críticas.

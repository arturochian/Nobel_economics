# Nobel de Economía 2006: Edmund S. Phelps

> **Motivación oficial:** *"for his analysis of intertemporal tradeoffs in macroeconomic policy"* (Por su análisis de las compensaciones intertemporales en la política macroeconómica).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 9 de octubre de 2006.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Edmund S. Phelps (Economica 1967, JPE 1968, AER 1961, libros de W. W. Norton de 1970 y 1972) y el documento oficial de antecedentes científicos de la Real Academia Sueca de Ciencias.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI, enlaces y estados de licencias.
  - [pdf/](referencias/pdf/): Directorio preparado para albergar documentos y reimpresiones de libre acceso.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa de la Curva de Phillips aumentada por expectativas (demostrando la espiral inflacionaria aceleracionista y la verticalidad de largo plazo en la tasa natural de desempleo) y la Regla de Oro de acumulación de capital en el modelo neoclásico de Solow-Swan.
  - [R/phelps_curva_phillips_regla_oro.R](replicacion/R/phelps_curva_phillips_regla_oro.R): Script autónomo y reproducible en R que computa las dinámicas macroeconómicas, genera los gráficos analíticos y exporta tablas cuantitativas.
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_phelps_curva_phillips.png`, `fig_phelps_regla_oro.png`) y datos tabulares numéricos (`tab_phelps_simulaciones.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres ejercicios prácticos graduados (básico sobre la derivación de la tasa natural de desempleo y la ausencia de compensación permanente entre inflación y empleo; intermedio sobre la condición de la Regla de Oro $r = g$ y la tasa óptima de ahorro; avanzado/reto sobre expectativas adaptativas vs. racionales, desinflación creíble y el ratio de sacrificio).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Guía pedagógica confidencial con respuestas analíticas completas, derivaciones matemáticas paso a paso y criterios de evaluación para el profesor.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa con front-matter YAML estandarizado, síntesis conceptual, cuadro comparativo "Antes y después", aplicaciones institucionales contemporáneas (bancos centrales con metas de inflación, estimaciones de la NAIRU por CBO y OCDE, y fondos soberanos de sostenibilidad intergeneracional).

---

## Resumen Ejecutivo del Aporte

A finales de la década de 1950 y durante los años 1960, el pensamiento macroeconómico dominante sostenía que existía una relación inversa estable y permanente entre la inflación y el desempleo (la Curva de Phillips original). Las autoridades creían que podían elegir permanentemente un desempleo menor a cambio de tolerar una inflación moderadamente más alta. Asimismo, en el ámbito del crecimiento económico, el debate sobre el ahorro y la inversión carecía de un criterio riguroso que definiera el nivel óptimo de acumulación de capital entre distintas generaciones.

Edmund S. Phelps transformó de raíz ambos pilares de la macroeconomía mediante una perspectiva unificada: **el análisis de las compensaciones intertemporales (*intertemporal tradeoffs*)**:

1. **La Curva de Phillips Aumentada por Expectativas y la Tasa Natural de Desempleo (1967, 1968, 1970):**
   Phelps demostró que los agentes económicos (trabajadores y empresas) negocian salarios y fijan precios en términos reales, anticipando la inflación futura. Si las autoridades intentan mantener sistemáticamente el desempleo por debajo de su nivel de equilibrio estructural —la **tasa natural de desempleo** (*natural rate of unemployment*)—, las expectativas de inflación se revisan al alza. Como consecuencia, la inflación no se mantiene estable: se **acelera indefinidamente** en una espiral ascendente. A largo plazo, la Curva de Phillips es estrictamente vertical en la tasa natural de desempleo. Por tanto, no existe una compensación permanente entre inflación y desempleo: un mayor empleo artificial hoy solo se consigue a costa de una inflación descontrolada que exigirá mañana una costosa recesión desinflacionaria. Además, en el célebre volumen sobre las "islas de Phelps" (1970), sentó los microfundamentos de búsqueda e información imperfecta en el mercado laboral.

2. **La Regla de Oro de la Acumulación de Capital (1961):**
   En su célebre fábula para economistas del crecimiento (*"A Fable for Growthmen"*), Phelps formuló la **Regla de Oro** de acumulación de capital en el modelo neoclásico: el sendero de estado estacionario que maximiza el consumo per cápita para todas las generaciones se alcanza cuando la tasa de rendimiento real neta del capital iguala la tasa de crecimiento de la economía ($r^* = g + n$), lo que equivale a ahorrar una fracción del ingreso exactamente igual a la participación del capital en el producto ($s_{GR} = \alpha$). Phelps demostró el *trade-off* intergeneracional: si una economía tiene poco capital, para que las generaciones futuras alcancen el máximo consumo per cápita posible, la generación presente debe realizar el sacrificio de ahorrar más y consumir menos hoy.

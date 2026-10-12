---
anio: 1987
slug: 1987_solow
laureados: ["Robert M. Solow"]
motivacion_oficial: "for his contributions to the theory of economic growth [por sus contribuciones a la teoría del crecimiento económico]"
area: ["Macroeconomía", "Teoría del Crecimiento Económico"]
tags: ["modelo de Solow", "crecimiento neoclásico", "residuo de Solow", "PTF", "contabilidad del crecimiento", "regla de oro", "convergencia", "estado estacionario"]
referencias_clave: ["solow1956contribution", "solow1957technical", "swan1956economic", "solow1988growth", "mankiw1992contribution"]
replicacion: "laureados/1987_solow/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Robert M. Solow fundó la teoría moderna del crecimiento económico al demostrar matemáticamente que las economías convergen hacia un equilibrio estable de largo plazo y probar empíricamente que la mayor parte del aumento sostenido en el nivel de vida proviene de la innovación y el progreso tecnológico (el Residuo de Solow), no de la mera acumulación de capital físico.

## Resumen de la investigación
A mediados de la década de 1950, la teoría macroeconómica del crecimiento estaba dominada por el modelo keynesiano de Harrod-Domar (Roy Harrod 1939, Evsey Domar 1946). Dicho modelo asumía coeficientes técnicos de producción fijos (función tipo Leontief), lo que implicaba una inestabilidad estructural conocida como el "filo de la navaja" (*razor's edge*): si la tasa de inversión planificada no coincidía con milimétrica precisión con la tasa natural de crecimiento demográfico, la economía se precipitaría inevitablemente hacia el desempleo masivo crónico o hacia la hiperinflación.

En su artículo seminal de 1956, *"A Contribution to the Theory of Economic Growth"*, Robert M. Solow (en paralelo e independientemente con el economista australiano Trevor Swan) sustituyó la rigidez tecnológica por una **función de producción neoclásica agregada** caracterizada por la sustitución continua entre factores productivos (capital y trabajo) y rendimientos marginales decrecientes. 

Bajo este marco, Solow demostró que la relación capital-producto se ajusta endógenamente a través del mercado, guiando a la economía hacia un **estado estacionario** (*steady state*) globalmente estable. Sus principales conclusiones teóricas fueron:
1. Una mayor tasa de ahorro e inversión incrementa de forma permanente el *nivel* de producción y riqueza por habitante, pero es incapaz de alterar la *tasa* de crecimiento económico sostenido de largo plazo.
2. A largo plazo, el crecimiento sostenido del ingreso por habitante depende exclusivamente de la tasa exógena de **progreso técnico**.

Un año más tarde, en su artículo empírico de 1957, *"Technical Change and the Aggregate Production Function"*, Solow ideó el marco cuantitativo de la **Contabilidad del Crecimiento** (*growth accounting*). Al contrastar su modelo con los datos históricos de los Estados Unidos entre 1909 y 1949, descompuso la tasa de crecimiento del PIB entre el aporte de los factores tangibles (horas trabajadas y stock de capital) y un término no observado: el **Residuo de Solow**, equivalente a la **Productividad Total de los Factores (PTF)**. El resultado conmovió a la profesión económica: el $87.5\%$ del incremento histórico en el producto por hora hombre provino del cambio técnico y la productividad, mientras que la acumulación de capital físico explicó apenas el $12.5\%$.

## Metodología y resultados

### 1. El Modelo Neoclásico de Solow-Swan (1956)
El modelo parte de una función de producción homogénea de grado 1 (rendimientos constantes a escala) con progreso técnico aumentador de trabajo (*Harrod-neutral*):

$$Y(t) = K(t)^\alpha [A(t) L(t)]^{1-\alpha}, \quad \alpha \in (0, 1)$$

donde $L(t)$ crece a una tasa demográfica exógena $n$ y la eficiencia de la mano de obra $A(t)$ crece a la tasa de progreso tecnológico $g$. Definiendo las variables por unidad de trabajo eficiente, $k(t) \equiv \frac{K(t)}{A(t)L(t)}$ e $y(t) \equiv \frac{Y(t)}{A(t)L(t)} = k(t)^\alpha$, la dinámica de acumulación viene dada por la ecuación diferencial fundamental:

$$\dot{k}(t) = s k(t)^\alpha - (n + g + \delta) k(t)$$

donde $s$ es la tasa constante de ahorro e inversión bruta y $\delta$ es la tasa de depreciación física del capital.
- **Estado Estacionario:** Ocurre cuando $\dot{k} = 0$, determinando el capital por trabajador eficiente de largo plazo:
  $$k^* = \left( \frac{s}{n + g + \delta} \right)^{\frac{1}{1-\alpha}}, \qquad y^* = (k^*)^\alpha = \left( \frac{s}{n + g + \delta} \right)^{\frac{\alpha}{1-\alpha}}$$
- **La Regla de Oro del Capital:** Maximizando el consumo sostenible por trabajador eficiente $c^* = y^* - (n + g + \delta)k^*$, se deduce que la tasa de ahorro óptima que maximiza el bienestar intertemporal es exactamente igual a la participación del capital en el ingreso nacional: $s_{oro} = \alpha$. Si $s > \alpha$, la economía cae en **ineficiencia dinámica** (sobreacumulación de capital).
- **Convergencia Asintótica:** Linealizando alrededor de $k^*$, la economía cierra la brecha a una tasa anual $\lambda = (1 - \alpha)(n + g + \delta)$, lo que predice convergencia incondicional entre economías con idénticos fundamentos estructurales.

### 2. Contabilidad del Crecimiento y el Residuo de Solow (1957)
Diferenciando logarítmicamente la función de producción agregada bajo competencia perfecta y rendimientos constantes a escala, Solow estableció que el crecimiento del producto se descompone aditivamente en:

$$\frac{\dot{Y}}{Y} = \alpha \frac{\dot{K}}{K} + (1 - \alpha) \frac{\dot{L}}{L} + \frac{\dot{A}}{A}$$

El **Residuo de Solow** ($g_A$) se obtiene despejando:

$$g_A \equiv \frac{\dot{A}}{A} = \frac{\dot{Y}}{Y} - \left[ \alpha \frac{\dot{K}}{K} + (1 - \alpha) \frac{\dot{L}}{L} \right]$$

Este término mide la velocidad a la que la economía genera más bienes y servicios con la misma dotación de insumos físicos y humanos, capturando la innovación tecnológica, mejoras gerenciales, eficiencia logística y asignación de recursos.

---

## Antes y después

### Antes
- **El Pesimismo del "Filo de la Navaja" (Harrod-Domar):** La teoría macroeconómica del crecimiento asumía que las proporciones entre capital y trabajo eran rígidas. Como resultado, el equilibrio macroeconómico con pleno empleo se consideraba una casualidad estadística inverosímil, condenando a las economías capitalistas a oscilar violentamente entre desempleo masivo y escasez de mano de obra.
- **Fetichismo de la Acumulación de Capital Físico:** Las estrategias de desarrollo de la posguerra (y los planes quinquenales de planificación central) asumían que la clave exclusiva para superar la pobreza residía en forzar tasas masivas de ahorro para construir fábricas, carreteras y presas hidroeléctricas.
- **Inexistencia de una Medición del Progreso Técnico:** No existía ningún método econométrico riguroso para aislar la contribución de la tecnología al bienestar material nacional.

### Después (qué cambió gracias al aporte)
- **Equilibrio Estable y Rendimientos Decrecientes:** Solow probó que la sustitución flexible entre capital y trabajo y los rendimientos decrecientes del capital garantizan que las economías se autorregulan hacia un sendero de crecimiento equilibrado, desmantelando la inestabilidad de Harrod-Domar.
- **La Tecnología como Motor del Crecimiento:** Quedó demostrado que acumular capital físico por sí solo está sujeto a rendimientos decrecientes y no puede sostener el crecimiento a perpetuidad; el verdadero motor del enriquecimiento secular per cápita es la innovación y el progreso tecnológico.
- **Estándar Universal de Contabilidad Económica:** El marco del Residuo de Solow (PTF) se convirtió en el instrumento analítico oficial utilizado por todos los organismos internacionales y oficinas estadísticas del mundo para medir la productividad agregada.
- **Nacimiento de la Nueva Literatura de Crecimiento:** La necesidad de explicar qué determina el residuo de Solow impulsó décadas más tarde la teoría del capital humano de Mankiw, Romer y Weil (1992) y las teorías del crecimiento endógeno de Romer (1986), Lucas (1988) y Aghion-Howitt (1992).

---

## Cómo se aplica hoy

1. **Estadísticas Oficiales de Productividad de la U.S. Bureau of Labor Statistics (BLS):**  
   Desde 1983 y de forma trimestral y anual continua (incluidos los informes de 2024), la [U.S. Bureau of Labor Statistics](https://www.bls.gov/productivity/) calcula oficialmente la serie histórica de *Total Factor Productivity (TFP)* del sector privado estadounidense utilizando la metodología de Solow (1957) combinada con índices de Törnqvist para monitorear el pulso de la productividad ante el auge de la inteligencia artificial y la digitalización.
2. **The Conference Board Total Economy Database (TED) y EU KLEMS:**  
   [The Conference Board](https://www.conference-board.org/data/economydatabase) y el consorcio europeo [EU KLEMS](https://euklems-intanprod-llee.luiss.it/) aplican directamente la descomposición de Solow en más de 120 países industrializados y emergentes para evaluar el impacto de la inversión en bienes intangibles (software, I+D y diseño) frente a activos tangibles en la Unión Europea y la OCDE.
3. **Monitoreo del Crecimiento Potencial en el Fondo Monetario Internacional (FMI) y Banco Mundial:**  
   En las revisiones anuales del Artículo IV del FMI y en el *World Economic Outlook* ([FMI WEO](https://www.imf.org/en/Publications/WEO)), los equipos técnicos descomponen el crecimiento del PIB de las economías mediante funciones de producción tipo Solow para proyectar el PIB potencial de equilibrio, diagnosticar la sostenibilidad fiscal y evaluar las reformas estructurales pro-productividad.
4. **Penn World Table (PWT):**  
   El consorcio del Groningen Growth and Development Centre (GGDC) y la Universidad de California Davis publica la [Penn World Table](https://www.rug.nl/ggdc/productivity/pwt/) (versión 10.01 actualizada), que provee series estandarizadas de capital, horas trabajadas y Productividad Total de los Factores para más de 180 países desde 1950, constituyendo la base empírica global de la macroeconomía moderna.

---

## Replicación en R

La carpeta de replicación contiene un conjunto integral de herramientas de simulación y estimación:
- Script principal: [`laureados/1987_solow/replicacion/R/modelo_crecimiento_solow.R`](file:///laureados/1987_solow/replicacion/R/modelo_crecimiento_solow.R).
- Documento Quarto: [`laureados/1987_solow/replicacion/replicar.qmd`](file:///laureados/1987_solow/replicacion/replicar.qmd).

El script reproduce fielmente los dos componentes centrales de Solow:
1. **Dinámica de Transición y Regla de Oro:** Modela la curva de inversión $s f(k)$ frente a la depreciación y dilución $(n + g + \delta)k$, calculando el estado estacionario $k^* \approx 4.32$, el equilibrio de la Regla de Oro $k_{oro}^* \approx 8.82$ ($s_{oro} = \alpha = 0.35$), y simulando trayectorias temporales convergentes desde economías subdesarrolladas ($k_0 < k^*$) y economías sobrecapitalizadas ($k_0 > k^*$).
2. **Contabilidad del Crecimiento:** Simula un panel temporal de 50 años (1971–2020) con semilla fija (`set.seed(1987)`), calcula el Residuo de Solow anual y genera la descomposición del PIB, demostrando que la PTF explica la mayor parte del crecimiento secular acumulado.

**Salidas generadas:**
- [`fig_solow_estado_estacionario.png`](file:///laureados/1987_solow/replicacion/salidas/fig_solow_estado_estacionario.png): Panel doble con el diagrama de equilibrio y las trayectorias temporales de convergencia.
- [`fig_solow_contabilidad_crecimiento.png`](file:///laureados/1987_solow/replicacion/salidas/fig_solow_contabilidad_crecimiento.png): Descomposición anual de fuentes de crecimiento y evolución de índices de largo plazo.
- [`tab_resultados_solow.csv`](file:///laureados/1987_solow/replicacion/salidas/tab_resultados_solow.csv): Resumen tabular de todas las métricas analíticas.

---

## Para profundizar

- **Artículos Seminales de Solow:**
  - Solow, R. M. (1956). "A Contribution to the Theory of Economic Growth", *Quarterly Journal of Economics*, 70(1), 65–94. [@solow1956contribution].
  - Solow, R. M. (1957). "Technical Change and the Aggregate Production Function", *Review of Economics and Statistics*, 39(3), 312–320. [@solow1957technical].
  - Swan, T. W. (1956). "Economic Growth and Capital Accumulation", *Economic Record*, 32(2), 334–361. [@swan1956economic].
  - Solow, R. M. (1988). "Growth Theory and After" (Conferencia Nobel), *American Economic Review*, 78(3), 307–317. [@solow1988growth].
- **Extensión Empírica con Capital Humano:**
  - Mankiw, N. G., D. Romer, y D. N. Weil (1992). "A Contribution to the Empirics of Economic Growth", *Quarterly Journal of Economics*, 107(2), 407–437. [@mankiw1992contribution].
- **Documentos Oficiales del Comité Nobel:**
  - Real Academia Sueca de Ciencias (1987). *Press Release: The Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 1987*. [@nobel1987press].
  - Real Academia Sueca de Ciencias (1987). *Information to the Public: Robert M. Solow and the Theory of Economic Growth*. [@nobel1987popular].

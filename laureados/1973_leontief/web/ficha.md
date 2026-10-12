---
anio: 1973
slug: 1973_leontief
laureados: ["Wassily Leontief"]
motivacion_oficial: "for the development of the input-output method and for its application to important economic problems [por el desarrollo del método insumo-producto y por su aplicación a problemas económicos importantes]"
area: ["Economía Cuantitativa", "Econometría", "Comercio Internacional"]
tags: ["análisis insumo-producto", "matriz de coeficientes técnicos", "inversa de Leontief", "encadenamientos de Rasmussen", "paradoja de Leontief", "teorema de Heckscher-Ohlin", "equilibrio general empírico", "cadenas globales de valor", "huella de carbono"]
referencias_clave: ["leontief1936quantitative", "leontief1941structure", "leontief1953domestic", "leontief1966input", "leontief1974lecture"]
replicacion: "laureados/1973_leontief/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Wassily Leontief convirtió la interdependencia general de la economía en un modelo matemático y empírico operativo mediante las tablas insumo-producto y su matriz inversa $(I - A)^{-1}$, descubriendo además la célebre paradoja que refutó empíricamente el teorema clásico del comercio internacional de Heckscher-Ohlin.

## Resumen de la investigación
Wassily Leontief (1906–1999), profesor en Harvard University y New York University, resolvió una de las mayores limitaciones históricas de la ciencia económica: cómo pasar de la noción teórica de que "todos los mercados dependen de todos los mercados" (el equilibrio general walrasiano) a un sistema cuantitativo aplicable a datos reales para planificar, predecir y evaluar políticas públicas.

Sus aportes nucleares abarcan:

1. **El Análisis Insumo-Producto (Input-Output Analysis, 1936, 1941, 1966):**  
   Concibió la actividad económica como una red matricial en la que cada sector compra insumos intermedios a otros sectores y vende su producción como insumo o a usuarios finales (hogares, gobierno, inversión y exportaciones). Asumiendo funciones de producción de proporciones fijas en el corto plazo (funciones Leontief), formuló la **Matriz de Coeficientes Técnicos ($A$)**.
2. **La Matriz Inversa de Leontief ($L = (I - A)^{-1}$):**  
   Demostró que resolver el sistema de balance contable $x = Ax + y$ permite calcular exactamente la producción bruta necesaria ($x$) para satisfacer cualquier vector de demanda final ($y$). Cada coeficiente $L_{ij}$ mide la producción del sector $i$ requerida directa e indirectamente por cada unidad de demanda final del sector $j$, sintetizando matemáticamente la propagación en cascada de la **Serie de Neumann** ($I + A + A^2 + A^3 + \dots$).
3. **Encadenamientos Intersectoriales y Multiplicadores de Rasmussen (1956):**  
   A partir de la inversa de Leontief, se cuantifican los multiplicadores de arrastre hacia atrás (poder de dispersión o *backward linkages*) y de sensibilidad hacia adelante (*forward linkages*), permitiendo a planificadores y bancos centrales identificar los "sectores clave" para la industrialización y el crecimiento económico.
4. **La Paradoja de Leontief (1953):**  
   Al calcular por primera vez el contenido factorial de capital y trabajo incorporado directa e indirectamente en el comercio de Estados Unidos tras la Segunda Guerra Mundial, descubrió que EE.UU. (el país más abundante en capital del mundo) exportaba bienes con menor ratio capital/trabajo que sus importaciones sustitutas, obligando a repensar las teorías del comercio internacional basadas en dotaciones factoriales simples.

---

## Metodología y resultados

### 1. La Estructura Insumo-Producto y la Inversa de Leontief
La economía se modela como un sistema de $n$ industrias interconectadas:
$$x_i = \sum_{j=1}^n z_{ij} + y_i = \sum_{j=1}^n a_{ij} x_j + y_i$$
donde $z_{ij}$ son las transacciones intersectoriales, $a_{ij} = z_{ij}/x_j$ son los coeficientes técnicos directos, $y_i$ es la demanda final y $x_i$ es la producción bruta. En notación matricial compacta:
$$x = A x + y \implies (I - A) x = y \implies x = (I - A)^{-1} y$$

La matriz $L = (I - A)^{-1}$ existe y es estrictamente no negativa si el radio espectral de $A$ es menor a la unidad y se cumplen las condiciones de viabilidad de Hawkins-Simon (1949). Esto permite descomponer el efecto de un estímulo en una progresión geométrica de rondas de insumos:
$$(I - A)^{-1} = I + A + A^2 + A^3 + \dots$$
donde $I$ es el impacto directo, $A$ la primera ronda de proveedores, $A^2$ la segunda ronda de subproveedores, etc.

### 2. Multiplicadores y Encadenamientos de Rasmussen
- **Poder de dispersión hacia atrás ($BL_j$):** Suma por columnas normalizada de $L$. Mide la capacidad de un sector para traccionar a sus proveedores upstream.
- **Sensibilidad de dispersión hacia adelante ($FL_i$):** Suma por filas normalizada de $L$. Mide en qué grado un sector abastece insumos críticos a la producción downstream.
- **Taxonomía:** Los sectores con $BL > 1$ y $FL > 1$ se catalogan como **Sectores Clave** de la economía.

### 3. La Paradoja de Leontief (1953)
Sea $k$ el vector de coeficientes directos de capital y $l$ el vector de mano de obra. Los requerimientos factoriales totales (directos más indirectos) son:
$$k_{\text{total}}' = k' (I - A)^{-1}, \quad l_{\text{total}}' = l' (I - A)^{-1}$$
Para una canasta de exportaciones $y^{\text{exp}}$ y una de importaciones competitivas $y^{\text{imp}}$:
$$(K/L)^{\text{exp}} = \frac{k_{\text{total}}' y^{\text{exp}}}{l_{\text{total}}' y^{\text{exp}}}, \quad (K/L)^{\text{imp}} = \frac{k_{\text{total}}' y^{\text{imp}}}{l_{\text{total}}' y^{\text{imp}}}$$
El Teorema de Heckscher-Ohlin predijo que para Estados Unidos:
$$\Theta = \frac{(K/L)^{\text{exp}}}{(K/L)^{\text{imp}}} > 1$$
Sin embargo, los datos empíricos de 1947 arrojaron:
$$(K/L)^{\text{exp}} \approx \$13.991 \text{ por trabajador}, \quad (K/L)^{\text{imp}} \approx \$18.178 \text{ por trabajador} \implies \Theta \approx 0.77 < 1.0$$
Estados Unidos se comportaba empíricamente como un exportador de bienes intensivos en mano de obra y un importador de bienes intensivos en capital físico, desatando la célebre controversia sobre el papel del capital humano, la tecnología y los recursos naturales.

---

## Antes y después

### Antes
- **Equilibrio general abstracto e inoperable:** La teoría del equilibrio general de Walras y Pareto formulaba cientos de ecuaciones teóricas, pero era considerada empíricamente inútil e inaplicable a la gestión económica real.
- **Microeconomía aislada o agregación ciega:** Las políticas públicas solo contaban con análisis microeconómicos de equilibrio parcial (un mercado aislado) o agregados macroeconómicos indiferenciados (PIB, consumo, inversión sin detalle sectorial).
- **Ceguera ante las cadenas de suministro indirectas:** Para evaluar el impacto de un arancel, un plan militar o una obra pública, solo se medía el empleo y gasto en la fábrica final, ignorando los cuellos de botella en insumos intermedios.
- **Fe dogmática en Heckscher-Ohlin:** Se aceptaba sin contrastación estadística que las naciones ricas en capital siempre exportaban productos intensivos en capital.

### Después (qué cambió gracias al aporte)
- **Nacimiento de la modelización multisectorial:** Las tablas insumo-producto se convirtieron en un componente central obligatorio del Sistema de Cuentas Nacionales de las Naciones Unidas (SCN/SNA).
- **Cálculo de multiplicadores indirectos y cadenas de valor:** Gobiernos y organismos internacionales pudieron cuantificar el impacto multiplicador exacto de inversiones, programas fiscales y regulaciones a través de la matriz $(I - A)^{-1}$.
- **Revolución empírica en el comercio internacional:** La Paradoja de Leontief obligó a incorporar formalmente el capital humano, la educación de los trabajadores, la inversión en I+D (R&D) y los recursos naturales en los modelos comerciales.
- **Fundamento de los modelos CGE y ambientales:** Toda la modelización moderna de equilibrio general computable (CGE), matrices de contabilidad social (SAM) y cálculo de huella de carbono descansa directamente sobre el andamiaje matricial de Leontief.

---

## Cómo se aplica hoy

1. **Cadenas Globales de Valor y Comercio en Valor Agregado (OCDE / OMC, TiVA):**  
   La iniciativa [OECD-WTO Trade in Value Added (TiVA)](https://www.oecd.org/sti/ind/measuring-trade-in-value-added.htm) utiliza matrices insumo-producto multirregionales (MRIO) mundiales para descomponer el contenido importado de las exportaciones. Por ejemplo, en la fabricación del iPhone o de aeronaves Airbus, la matriz de Leontief permite atribuir el valor agregado real generado en cada país en lugar de registrar erróneamente el valor bruto final.
2. **Contabilidad de Emisiones de Carbono de Alcance 3 (Scope 3) y EXIOBASE / EORA:**  
   El estándar internacional del [GHG Protocol](https://ghgprotocol.org/) y el Panel Intergubernamental del Cambio Climático ([IPCC](https://www.ipcc.ch/), Informe AR6 2022) calculan la huella de carbono basada en el consumo multiplicando la intensidad de emisiones directas por la inversa de Leontief global ($E_{\text{total}} = e' (I - A)^{-1} y$). Empresas multinacionales y gobiernos determinan así qué porcentaje de las emisiones de un país fueron consumidas en el exterior o importadas a través de bienes extranjeros.
3. **Resiliencia ante Shocks de Suministro y Cuellos de Botella (Banco Central Europeo / Fed de Nueva York):**  
   Durante la crisis energética de 2022 tras la invasión de Ucrania, el [Banco Central Europeo (BCE)](https://www.ecb.europa.eu/) utilizó modelos insumo-producto a nivel europeo para estimar el impacto en cascada del racionamiento de gas sobre sectores industriales clave como químicos, metales y alimentos. Paralelamente, la [Reserva Federal de Nueva York](https://www.newyorkfed.org/research/policy/gscpi_index.html) utiliza estructuras multisectoriales para monitorear el Global Supply Chain Pressure Index (GSCPI).

---

## Replicación en R

El paquete de replicación autónomo [`laureados/1973_leontief/replicacion/R/insumo_producto_y_paradoja.R`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/1973_leontief/replicacion/R/insumo_producto_y_paradoja.R) implementa:
- Construcción y balance de una Matriz Insumo-Producto de 4 sectores (Agricultura, Manufactura, Servicios, Energía), verificando la consistencia de $\text{PIB}_{\text{demanda}} = \text{PIB}_{\text{ingreso}} = \$755$ mil millones USD.
- Obtención de la Matriz de Coeficientes Técnicos $A$ y la Inversa de Leontief $L = (I - A)^{-1}$.
- Estimación de multiplicadores hacia atrás ($BL$) y hacia adelante ($FL$), clasificando a la Manufactura como Sector Clave ($BL = 1.187, FL = 1.217$).
- Simulación de un shock exógeno de demanda final de $+\$50$ mil millones en Manufactura y descomposición por rondas de transmisión (Serie de Neumann: Directo, Ronda 1, Ronda 2, Ronda 3+).
- Evaluación del contenido factorial directo y total de capital ($K$) y trabajo ($L$) en exportaciones vs sustitutos de importación, reproduciendo con éxito la Paradoja de Leontief con un ratio $\Theta = 0.888 < 1.0$.
- Generación de gráficos listos para publicación:
  - [`fig_leontief_matriz_multiplicadores.png`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/1973_leontief/replicacion/salidas/fig_leontief_matriz_multiplicadores.png): Mapa de calor de la inversa de Leontief y plano de cuadrantes de Rasmussen.
  - [`fig_leontief_paradoja_intensidad.png`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/1973_leontief/replicacion/salidas/fig_leontief_paradoja_intensidad.png): Descomposición por rondas de transmisión y ratios de capital por trabajador en el comercio exterior.
  - [`tab_resultados_insumo_producto_1973.csv`](file:///c:/Users/ArturoChianNunez/Documents/GitHub/Nobel_economics/laureados/1973_leontief/replicacion/salidas/tab_resultados_insumo_producto_1973.csv): Tabla consolidada con todos los indicadores sectoriales y factoriales.

---

## Para profundizar

- **Leontief, W. W. (1936).** *Quantitative Input and Output Relations in the Economic System of the United States*. The Review of Economics and Statistics, 18(3), 105–125. [`leontief1936quantitative`]
- **Leontief, W. W. (1941).** *The Structure of American Economy, 1919–1929: An Empirical Application of Equilibrium Analysis*. Harvard University Press. [`leontief1941structure`]
- **Leontief, W. W. (1953).** *Domestic Production and Foreign Trade; The American Capital Position Re-Examined*. Proceedings of the American Philosophical Society, 97(4), 332–349. [`leontief1953domestic`]
- **Leontief, W. W. (1966).** *Input-Output Economics*. Oxford University Press. [`leontief1966input`]
- **Leontief, W. W. (1974).** *Structure of the World Economy: Outline of a Simple Input-Output Model (Nobel Lecture)*. The American Economic Review, 64(6), 823–834. [`leontief1974lecture`]
- **Miller, R. E., & Blair, P. D. (2009).** *Input-Output Analysis: Foundations and Extensions* (2nd ed.). Cambridge University Press.
- **Rasmussen, P. N. (1956).** *Studies in Inter-Sectoral Relations*. Einar Harcks Forlag, Copenhagen.
- **Leamer, E. E. (1980).** *The Leontief Paradox, Reconsidered*. Journal of Political Economy, 88(3), 495–503.

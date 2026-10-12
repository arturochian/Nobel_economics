---
anio: 2024
slug: 2024_acemoglu_johnson_robinson
laureados: ["Daron Acemoglu", "Simon Johnson", "James A. Robinson"]
motivacion_oficial: "for studies of how institutions are formed and affect prosperity"
area: ["Economía Institucional", "Economía del Desarrollo", "Economía Política"]
tags: ["instituciones extractivas", "instituciones inclusivas", "derechos de propiedad", "variables instrumentales", "mortalidad de colonos", "estado de derecho"]
referencias_clave: ["acemoglu2001colonial", "acemoglu2002reversal", "acemoglu2005institutions", "acemoglu2006economic", "acemoglu2012why"]
replicacion: "laureados/2024_acemoglu_johnson_robinson/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
Daron Acemoglu, Simon Johnson y James A. Robinson demostraron causalmente que las instituciones políticas y económicas —y no la geografía ni la cultura aisladas— son el motor fundamental de las diferencias de riqueza entre las naciones del mundo.

## Resumen de la investigación
¿Por qué algunos países prosperan de manera sostenida mientras otros permanecen atrapados en la pobreza crónica? Durante décadas, el pensamiento económico gravitó entre explicaciones basadas en la dotación de capital físico, el clima y las enfermedades tropicales (la hipótesis geográfica) o los valores culturales y religiosos.

Acemoglu, Johnson y Robinson (AJR) revolucionaron este debate al articular una teoría integrada de la economía política del desarrollo. Su tesis central distingue dos tipos de arquitectura institucional:
- **Instituciones inclusivas:** Aquellas que protegen ampliamente los derechos de propiedad, aseguran la igualdad ante la ley, garantizan el estado de derecho y permiten la entrada de nuevos competidores al mercado. Al alinear los retornos del talento con la inversión privada, fomentan la innovación y la adopción tecnológica continuo.
- **Instituciones extractivas:** Aquellas diseñadas para concentrar el poder político y extraer rentas económicas del grueso de la población en beneficio de una élite reducida. Aunque pueden generar episodios pasajeros de crecimiento mediante reasignación forzosa de recursos (como en la Unión Soviética del siglo XX), terminan colapsando porque ahogan la destrucción creativa schumpeteriana y desincentivan la inversión ciudadana.

En su célebre artículo de 2001 en la *American Economic Review*, AJR resolvieron el desafío empírico de probar causalidad mediante un experimento natural histórico: las diferencias en las tasas de mortalidad que enfrentaron los soldados, marineros y misioneros colonizadores europeos en los siglos XVII a XIX determinaron si las potencias crearon colonias de asentamiento con instituciones protectoras de derechos o enclaves extractivos de mano de obra y recursos naturales. Cinco siglos más tarde, este legado institucional persiste y explica la brecha contemporánea de ingreso per cápita.

## Metodología y resultados
1. **La Cadena Causal Histórica:**
   AJR estructuraron una cadena de causalidad secuencial:
   $$\text{Mortalidad colonial} \longrightarrow \text{Asentamiento europeo} \longrightarrow \text{Instituciones tempranas} \longrightarrow \text{Instituciones actuales} \longrightarrow \text{PIB per cápita actual}$$
   Donde la malaria y la fiebre amarilla causaban mortalidades devastadoras (más de 100 por cada 1,000 al año, como en África Occidental o el Caribe), los europeos crearon aparatos autoritarios de extracción. Donde la mortalidad era baja (Nueva Inglaterra, Canadá, Australia, Nueva Zelanda), emigraron en masa y exigieron instituciones representativas y controles al poder del soberano.

2. **Inferencia Causal vía Variables Instrumentales (2SLS):**
   Utilizando el logaritmo de la mortalidad de colonos como instrumento ($Z_i = \ln(\text{Settler Mortality})$) para la protección contra el riesgo de expropiación ($R_i$), la primera etapa arrojó un estadístico $F = 22.95$ ($p < 0.0001$), demostrando que el instrumento es fuerte. En la segunda etapa, el estimador causal 2SLS arrojó $\hat{\beta}_{\text{IV}} = 0.944$, casi el doble del estimador de Mínimos Cuadrados Ordinarios ($\hat{\beta}_{\text{MCO}} = 0.522$), confirmando que el error de medición en las variables institucionales subestimaba el verdadero impacto de las instituciones en la regresión ordinaria.

3. **La "Inversión de la Fortuna" (*Reversal of Fortune*):**
   En su trabajo complementario de 2002 (*Quarterly Journal of Economics*), demostraron que los países que eran más ricos y urbanizados en el año 1500 (como las civilizaciones Inca, Azteca o el Imperio Mogol) son hoy relativamente más pobres que regiones que estaban poco pobladas en 1500 (como América del Norte o Australia). Este hecho refuta frontalmente la hipótesis de que la geografía sea un determinante inmutable del bienestar, demostrando que fueron las instituciones extractivas impuestas en las zonas ricas y pobladas las que revirtieron su trayectoria.

## Antes y después

### Antes
- **Predominio del determinismo geográfico y cultural:** Se atribuía el subdesarrollo de las regiones tropicales a la carga climática, las plagas agrícolas o presuntas incompatibilidades culturales con la ética de trabajo moderna ([Sachs, 2003](https://www.nber.org/papers/w9490)).
- **Modelos neoclásicos sin gobernanza:** El crecimiento a largo plazo se modelaba casi exclusivamente en función de la acumulación de capital físico, trabajo y progreso tecnológico exógeno (modelos de Solow-Swan), tratando a los gobiernos y las leyes como un "residuo" no modelado.
- **Correlaciones espurias en econometría:** Existían cientos de regresiones empíricas entre gobernanza y crecimiento, pero estaban viciadas por causalidad reversa (los países ricos tienen más dinero para pagar policías y jueces imparciales) y sesgos de variables omitidas.

### Después (qué cambió gracias al aporte)
- **Las instituciones como causa fundamental:** La profesión económica reconoció que el capital, la educación y la tecnología no son causas últimas de la riqueza, sino causas proximales; la causa fundamental son los incentivos generados por las instituciones políticas y económicas.
- **Revolución metodológica de persistencia histórica:** Se inauguró un fértil programa de investigación en econometría histórica que utiliza experimentos naturales de largo plazo (fronteras coloniales, mita minera, rutas marítimas) para evaluar impactos institucionales causales.
- **Economía política endógena:** Se formularon modelos matemáticos rigurosos de teoría de juegos donde las élites deciden estratégicamente si democratizar o reprimir para evitar revoluciones populares (*Economic Origins of Dictatorship and Democracy*, 2006).

## Cómo se aplica hoy

1. **Indicadores de Gobernanza Mundial del Banco Mundial (*Worldwide Governance Indicators* - WGI):**
   Los WGI sintetizan mediciones de control de la corrupción, estado de derecho, calidad regulatoria y efectividad gubernamental en más de 200 economías. Estos índices son utilizados sistemáticamente por el Banco Mundial y donantes multilaterales para condicionar asignaciones presupuestarias y créditos concesionales a la solidez institucional de cada país ([World Bank Worldwide Governance Indicators](https://www.worldbank.org/en/publication/worldwide-governance-indicators)).

2. **Marco Reforzado de Gobernanza del Fondo Monetario Internacional (FMI, 2018):**
   En mayo de 2018, el Directorio Ejecutivo del FMI aprobó un nuevo marco regulatorio sobre gobernanza que evalúa explícitamente vulnerabilidades institucionales en el sector financiero, compras públicas, administración tributaria y protección jurídica de contratos antes de aprobar paquetes de asistencia financiera y rescates soberanos ([IMF Policy Paper: Review of 1997 Guidance Note on Governance](https://www.imf.org/en/Publications/Policy-Papers/Issues/2018/05/14/pp040618-review-of-1997-guidance-note-on-governance)).

3. **Modernización Judicial, Seguridad Jurídica y la iniciativa *Business Ready* (Banco Mundial, 2024):**
   Sustituyendo al antiguo *Doing Business*, el Banco Mundial lanzó en octubre de 2024 el marco *Business Ready* (B-READY), evaluando la protección a los derechos de propiedad privada, la eficiencia de los tribunales comerciales y la resolución transparente de disputas como el pilar decisivo para atraer inversión extranjera directa y relocalización de cadenas de suministro (*nearshoring*) en América Latina y el Sudeste Asiático ([World Bank Business Ready 2024](https://www.worldbank.org/en/businessready)).

## Replicación en R
- **Qué se replicó:** Estimación econométrica completa de Mínimos Cuadrados Ordinarios (MCO), ecuación de primera etapa y MCO en Dos Etapas (2SLS / IV) correspondientes a la Tabla 4 del artículo original de Acemoglu, Johnson y Robinson (2001, AER).
- **Con qué datos:** Conjunto de datos oficial de 64 ex-colonias (`ajr_2001.csv`) que incluye el logaritmo del PIB per cápita en 1995 (`logpgp95`), el índice promedio de protección contra riesgo de expropiación 1985–1995 (`avexpr`, 0 a 10), el logaritmo de mortalidad de colonos europeos por mil anuales (`logem4`) y la latitud absoluta (`lat_abst`).
- **Resultados obtenidos vs. el paper:**
  - *MCO:* Coeficiente de $0.522$ ($e.e. = 0.061$, en el paper: $0.52$, $e.e. = 0.06$).
  - *Primera Etapa:* Coeficiente de $-0.607$ ($e.e. = 0.127$, en el paper: $-0.61$, $e.e. = 0.13$), con estadístico $F = 22.95$.
  - *2SLS / IV:* Coeficiente causal de $0.944$ ($e.e. = 0.157$, en el paper: $0.94$, $e.e. = 0.16$).
  - Los resultados numéricos coinciden de forma idéntica con los valores publicados.
- **Limitaciones:** El debate metodológico posterior (Albouy, 2012) señaló heterogeneidad en las fuentes históricas de mortalidad militar vs. civil; asimismo, Sachs (2003) argumentó posibles efectos directos de la ecología de la malaria no mediados por instituciones.

## Para profundizar
- Acemoglu, D., Johnson, S., & Robinson, J. A. (2001). *The Colonial Origins of Comparative Development: An Empirical Investigation*. American Economic Review, 91(5), 1369–1401. `acemoglu2001colonial`.
- Acemoglu, D., Johnson, S., & Robinson, J. A. (2002). *Reversal of Fortune: Geography and Institutions in the Making of the Modern World Income Distribution*. The Quarterly Journal of Economics, 117(4), 1231–1294. `acemoglu2002reversal`.
- Acemoglu, D., Johnson, S., & Robinson, J. A. (2005). *Institutions as a Fundamental Cause of Long-Run Growth*. Handbook of Economic Growth, 1A, 385–472. `acemoglu2005institutions`.
- Acemoglu, D., & Robinson, J. A. (2006). *Economic Origins of Dictatorship and Democracy*. Cambridge University Press. `acemoglu2006economic`.
- Acemoglu, D., & Robinson, J. A. (2012). *Why Nations Fail: The Origins of Power, Prosperity, and Poverty*. Crown Business. `acemoglu2012why`.
- The Royal Swedish Academy of Sciences (2024). *Scientific Background on the Sveriges Riksbank Prize in Economic Sciences 2024: How Institutions Are Formed and Affect Prosperity*. `nobel2024scientific`.

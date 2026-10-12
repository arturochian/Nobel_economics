---
anio: 1969
slug: 1969_frisch_tinbergen
laureados: ["Ragnar Frisch", "Jan Tinbergen"]
motivacion_oficial: "for having developed and applied dynamic models for the analysis of economic processes [por haber desarrollado y aplicado modelos dinámicos al análisis de los procesos económicos]"
area: ["Econometría", "Macroeconomía"]
tags: ["modelos dinámicos", "ciclos económicos", "econometría", "impulso-respuesta", "política económica"]
referencias_clave: ["frisch1933propagation", "tinbergen1939testing", "tinbergen1952policy", "frisch1970lecture", "tinbergen1969lecture"]
replicacion: "laureados/1969_frisch_tinbergen/replicacion/replicar.qmd"
nivel_replicacion: "ilustrativa"
dificultad: "intermedio"
tiempo_lectura: "9 minutos"
tiene_app: true
---

## En una frase

Frisch y Tinbergen ayudaron a convertir las teorías sobre una economía que cambia en el tiempo en sistemas de ecuaciones que podían contrastarse con datos, simularse y usarse para pensar políticas.

> **Si solo tienes 2 minutos.** Imagina una campana: un golpe externo es el **impulso** y la forma de la campana determina cómo se propaga el sonido. Frisch formalizó esa separación para estudiar fluctuaciones económicas; Tinbergen llevó modelos con varias relaciones al contraste empírico y a la política económica. Nuestra replicación permite cambiar el golpe y la “forma de la campana” para observar la trayectoria resultante. Es una simulación didáctica, no una reproducción de sus cifras.

## Resumen de la investigación

El primer Premio del Banco de Suecia en Ciencias Económicas en Memoria de Alfred Nobel fue concedido en 1969 a **Ragnar Frisch**, afiliado a la Universidad de Oslo, y **Jan Tinbergen**, afiliado a la Netherlands School of Economics. La motivación literal fue “for having developed and applied dynamic models for the analysis of economic processes”. Nombres, afiliaciones, fecha y texto se pueden comprobar en la [API oficial del Premio Nobel](https://api.nobelprize.org/2.1/nobelPrize/eco/1969).

Un modelo es **dinámico** cuando relaciona lo que ocurre hoy con estados anteriores. En 1933, Frisch distinguió el **impulso** —la perturbación que inicia el movimiento— de la **propagación** —cómo la estructura económica le da forma y duración— [`frisch1933propagation`; [registro bibliográfico](https://books.google.com/books?id=vzYvAAAAMAAJ)].

Tinbergen estimó sistemas para someter explicaciones del ciclo a pruebas estadísticas. Su estudio para la Sociedad de Naciones examinó Estados Unidos entre 1919 y 1932 ([National Library of Scotland](https://digital.nls.uk/league-of-nations/archive/190317052)). Una retrospectiva oficial resume el reparto de énfasis: Frisch desarrolló métodos generales de análisis dinámico y Tinbergen fue pionero en su aplicación empírica ([NobelPrize.org](https://www.nobelprize.org/prizes/uncategorized/the-sveriges-riksbank-prize-in-economic-sciences-in-memory-of-alfred-nobel-1969-2007/)).

## Metodología y resultados

Hay que declarar variables, especificar ecuaciones y confrontar sus coeficientes con observaciones. Tinbergen expuso esas tres piezas en su [conferencia Nobel de 1969](https://www.nobelprize.org/prizes/economic-sciences/1969/tinbergen/lecture/) y advirtió que el ajuste puede deteriorarse, obligando a revisar modelo y datos.

La idea impulso–propagación admite una representación mínima:

$$y_t=(c+v)y_{t-1}-v y_{t-2}+u_t.$$

Aquí, $y_t$ es la desviación de la actividad respecto de un equilibrio, $c$ recoge persistencia del gasto, $v$ un mecanismo acelerador y $u_t$ el golpe externo. El impulso puede durar un periodo, pero los rezagos hacen que su efecto continúe y oscile. Esta ecuación es una analogía computable inspirada en el mecanismo de Frisch; **no** es una transcripción de su sistema de 1933.

El otro legado es conectar el modelo con decisiones. *On the Theory of Economic Policy* organizó relaciones entre variables objetivo e instrumentos de política; la ficha bibliográfica y capítulos digitalizados se conservan en el [repositorio institucional de Erasmus University Rotterdam](https://hdl.handle.net/1765/15884). Un modelo no reemplaza el juicio: el propio Tinbergen lo describió como un marco al que hay que añadir conocimiento detallado en su [conferencia Nobel](https://www.nobelprize.org/prizes/economic-sciences/1969/tinbergen/lecture/).

## Antes y después

### Antes

Las explicaciones económicas podían ser verbales o estáticas: describían relaciones en un momento, pero no siempre hacían explícito cómo una situación producía la siguiente ni qué observación permitiría rechazar la explicación. La presentación histórica del Nobel sitúa el avance de Frisch y Tinbergen en la integración de teoría económica y métodos estadísticos ([NobelPrize.org](https://www.nobelprize.org/prizes/uncategorized/the-sveriges-riksbank-prize-in-economic-sciences-in-memory-of-alfred-nobel-1969-2007/)).

### Después (qué cambió gracias al aporte)

Quedó establecido un lenguaje de trabajo que hoy parece normal: escribir un sistema, estimarlo, simular un choque, comparar la trayectoria pronosticada con los datos y explorar escenarios de política. Frisch insistió en pasar de teoría abstracta a aplicaciones en su [conferencia Nobel](https://www.nobelprize.org/prizes/economic-sciences/1969/frisch/lecture/); Tinbergen explicó tanto el valor como las limitaciones prácticas de construir modelos en la suya ([NobelPrize.org](https://www.nobelprize.org/prizes/economic-sciences/1969/tinbergen/lecture/)). El cambio no fue que un modelo pudiera “adivinar” la economía, sino que sus supuestos y consecuencias quedaran explícitos y discutibles.

## Cómo se aplica hoy

1. **Proyecciones de bancos centrales.** El Banco Central Europeo y el Eurosistema producen proyecciones macroeconómicas que cubren crecimiento, inflación, salarios, desempleo y comercio para comprender el estado futuro de la economía ([BCE, página de proyecciones macroeconómicas](https://www.ecb.europa.eu/press/projections/html/index.en.html)). El modelo actual es mucho más sofisticado que los sistemas pioneros, pero conserva la disciplina de enlazar variables en el tiempo y revisar escenarios.

2. **Análisis fiscal y programas de gobierno en los Países Bajos.** El CPB usa **Saffier 3.0**, en servicio desde diciembre de 2021, para proyecciones de hasta ocho años, escenarios y efectos macroeconómicos de políticas, incluidas plataformas electorales y acuerdos de gobierno ([CPB, Saffier 3.0](https://www.cpb.nl/saffier-30)). Es una continuación institucional reconocible del programa de modelización aplicado asociado con Tinbergen.

3. **Capacidad de pronóstico y análisis de políticas.** En 2025, el FMI publicó el *Macroframework Foundations Tool*, un marco integrado con ecuaciones de comportamiento y retroalimentaciones entre sectores para elaborar proyecciones y analizar políticas ([FMI, manual MFT 1.0](https://www.elibrary.imf.org/abstract/journals/005/2025/011/article-A001-en.xml)). La aplicación ilustra por qué consistencia contable, dinámica y escenarios siguen siendo competencias prácticas para gobiernos y organismos internacionales.

## Pruébalo tú mismo

La [app Shiny](../shiny/README.md) ofrece cuatro controles y un botón de restablecimiento. Cambia primero el acelerador y luego la persistencia del choque: dos trayectorias parecidas pueden provenir de mecanismos distintos. La app funciona localmente y queda preparada para exportación global a Shinylive.

## Replicación en R

La replicación es **ilustrativa** y usa datos simulados con semilla fija. Con un impulso de 10, $c=0.6$ y $v=0.7$, la actividad sube a 10, llega a 13 y oscila con amplitud decreciente. Otro ejercicio genera innovaciones aleatorias y estima los dos rezagos.

Salidas: [respuesta base](../replicacion/salidas/fig_impulso_propagacion_1969.png) y [comparación de aceleradores](../replicacion/salidas/fig_comparacion_acelerador_1969.png).

No usamos los datos de 1919–1932 de Tinbergen, no reconstruimos el sistema continuo de Frisch y no comparamos cifras con una tabla publicada. Por eso no corresponde llamarla replicación parcial o completa. El objetivo verificable es más acotado: mostrar, con el mismo código en el cuaderno y la app, cómo impulso, persistencia y acelerador producen trayectorias distintas.

## Para profundizar

- Frisch (1933), “Propagation Problems and Impulse Problems in Dynamic Economics” [`frisch1933propagation`].
- Tinbergen (1939), *Statistical Testing of Business-Cycle Theories*, vol. II [`tinbergen1939testing`].
- Tinbergen (1952), *On the Theory of Economic Policy* [`tinbergen1952policy`].
- Frisch (1970), conferencia Nobel “From Utopian Theory to Practical Applications” [`frisch1970lecture`].
- Tinbergen (1969), conferencia Nobel “The Use of Models: Experience and Prospects” [`tinbergen1969lecture`].

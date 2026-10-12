# Nobel de Economía 2022: Ben S. Bernanke, Douglas W. Diamond y Philip H. Dybvig

> **Motivación oficial:** *"for research on banks and financial crises"* (Por sus investigaciones sobre los bancos y las crisis financieras).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 10 de octubre de 2022.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Bernanke, Diamond y Dybvig y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Directorio preparado para almacenar documentos y artículos de libre acceso.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa del modelo Diamond-Dybvig y el canal de crédito de Bernanke.
  - [R/modelo_diamond_dybvig.R](replicacion/R/modelo_diamond_dybvig.R): Script autónomo en R que simula la matriz de pagos, calcula el umbral de pánico y grafica los equilibrios.
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_diamond_dybvig_panico.png`, `fig_canal_credito_bernanke.png`) y datos tabulares (`tab_pagos_liquidez.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de ejercicios prácticos graduados (básico sobre equilibrios múltiples de Nash, intermedio sobre seguro de depósitos y riesgo moral, y avanzado sobre corridas digitales en Silicon Valley Bank).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas confidenciales, derivaciones algebraicas y respuestas detalladas para el profesor.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha técnica y divulgativa con front-matter YAML para integración en la plataforma web del proyecto.

---

## Resumen Ejecutivo del Aporte

Ben S. Bernanke, Douglas W. Diamond y Philip H. Dybvig transformaron radicalmente la comprensión moderna del sistema bancario, las crisis financieras y la regulación macroprudencial:

1. **Diamond y Dybvig (1983):** Demostraron que los bancos prestan un servicio social indispensable al transformar activos ilíquidos a largo plazo en pasivos líquidos a la vista para los ahorristas (*descalce de plazos*). Sin embargo, este mecanismo engendra una vulnerabilidad congénita: la posibilidad de corridas bancarias como profecías autocumplidas (*self-fulfilling runs*). Probaron que las garantías gubernamentales creíbles (seguro de depósitos y prestamista de última instancia) eliminan los incentivos al pánico de forma gratuita en equilibrio.
2. **Diamond (1984):** Formuló la teoría del monitoreo delegado (*delegated monitoring*), explicando cómo los bancos reducen los costos de verificación y las asimetrías de información diversificando créditos masivos.
3. **Bernanke (1983):** Demostró empírica y conceptualmente que la Gran Depresión no fue un mero choque monetario pasivo, sino que el colapso del sistema bancario destruyó el capital informacional sobre deudores, disparando el costo de intermediación crediticia (*credit channel*) y hundiendo la actividad productiva real.

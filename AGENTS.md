# AGENTS.md — Nobel_economics

> Documento de especificación para un agente de IA. Léelo completo antes de actuar. Tu trabajo es **construir** el repositorio y la web descritos aquí. No omitas secciones; si algo es ambiguo, elige la opción más simple y regístrala en `docs/DECISIONES.md`.

---

## 1. Objetivo

Repositorio que, para **cada Premio Nobel de Economía** (Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel, 1969–presente):

1. Tiene una carpeta propia con los **papers/libros de referencia** (descargados cuando sea legal; si no, referenciados con metadatos y enlace).
2. **Replica en R** el aporte central (simulación, datos públicos o reproducción de resultados clave).
3. Alimenta una **web estática** que explica, por laureado/investigación:
   - Resumen de la investigación.
   - Metodología y resultados.
   - **Antes y después**: cómo era el campo antes y qué cambió gracias al aporte.
   - **Aplicaciones actuales** (políticas públicas, industria, finanzas, tecnología, etc.).

Idioma de contenido: **español** (términos técnicos en inglés entre paréntesis la primera vez). Código y nombres de archivo: ASCII, sin espacios.

---

## 2. Estructura del repositorio

```
Nobel_economics/
├── AGENTS.md
├── README.md
├── renv.lock                      # entorno R reproducible
├── .gitignore
├── data/
│   └── laureados.csv              # catálogo maestro (ver §3)
├── scripts/
│   ├── 00_setup.R                 # instala/restaura paquetes (renv)
│   ├── 01_descargar_referencias.R # descarga papers/libros (ver §5)
│   ├── 02_replicar_todo.R         # corre todas las replicaciones
│   ├── 03_generar_contenido_web.R # convierte fichas md -> JSON para la web
│   └── utils.R                    # helpers comunes
├── laureados/
│   └── AAAA_apellido/             # ej. 2019_banerjee_duflo_kremer
│       ├── README.md              # ficha (plantilla §4)
│       ├── referencias/
│       │   ├── referencias.bib    # BibTeX de obras clave
│       │   ├── manifest.csv       # id, titulo, doi, url, estado_descarga, licencia
│       │   └── pdf/               # solo material de acceso abierto
│       ├── replicacion/
│       │   ├── replicar.qmd       # Quarto (o .Rmd) reproducible
│       │   ├── R/                 # funciones
│       │   ├── datos/             # datos pequeños o script de descarga
│       │   └── salidas/           # figuras/tablas (png, csv)
│       └── web/
│           └── ficha.md           # contenido para la web (front-matter YAML)
├── web/                           # sitio estático (ver §6)
│   ├── (código del sitio)
│   └── content/                   # generado desde laureados/*/web/ficha.md
├── .github/workflows/
│   ├── r-check.yml                # CI: restaura renv y corre replicaciones ligeras
│   └── deploy-web.yml             # CI: build + GitHub Pages
└── docs/
    ├── DECISIONES.md
    ├── FUENTES.md                 # fuentes de datos y licencias
    └── ESTADO.md                  # tabla de progreso por laureado
```

Nombre de carpeta: `AAAA_apellido[_apellido2...]` en minúsculas, sin tildes (ej. `1994_nash_harsanyi_selten`, `2021_card_angrist_imbens`).

---

## 3. Catálogo maestro `data/laureados.csv`

Columnas: `anio, laureados, pais_afiliacion, area, aporte_corto, slug, prioridad, estado`.

- Obtén la lista oficial de https://www.nobelprize.org/prizes/economic-sciences/ (o API `https://api.nobelprize.org/2.1/laureates?nobelPrizeCategory=eco`). **No inventes** laureados ni citas: verifica cada uno contra nobelprize.org (incluye el "prize motivation").
- Incluye todos los años desde 1969 hasta el más reciente publicado. Años sin premio no existen en economía; verifica.
- `estado` ∈ {`pendiente`, `referencias`, `replicado`, `web`, `completo`}.
- `prioridad`: 1 = piloto (hacer primero), 2 = resto.

**Pilotos (prioridad 1)** — construir end-to-end antes del resto:
`1990 Markowitz/Miller/Sharpe` (portafolios), `1994 Nash/Harsanyi/Selten` (juegos), `1997 Merton/Scholes` (Black-Scholes), `2002 Kahneman/Smith`, `2019 Banerjee/Duflo/Kremer`, `2021 Card/Angrist/Imbens` (diseño causal), `2024 Acemoglu/Johnson/Robinson` (instituciones).
Después, el resto en orden cronológico.

---

## 4. Plantilla de ficha `laureados/<slug>/README.md` y `web/ficha.md`

`web/ficha.md` usa front-matter YAML + secciones fijas:

```markdown
---
anio: 2021
slug: 2021_card_angrist_imbens
laureados: ["David Card", "Joshua D. Angrist", "Guido W. Imbens"]
motivacion_oficial: "..."   # cita literal de nobelprize.org, traducida entre corchetes si se traduce
area: ["Economía laboral", "Econometría"]
tags: ["experimentos naturales", "inferencia causal", "LATE"]
referencias_clave: ["card1994minimum", "angrist1996identification"]  # claves de referencias.bib
replicacion: "replicacion/replicar.qmd"
nivel_replicacion: "completa | parcial | ilustrativa"
---

## En una frase
## Resumen de la investigación
## Metodología y resultados
## Antes y después
### Antes
### Después (qué cambió gracias al aporte)
## Cómo se aplica hoy
(ejemplos concretos y fechados, con fuentes enlazadas)
## Replicación en R
(qué se replicó, con qué datos, qué resultado se obtuvo vs. el paper, limitaciones)
## Para profundizar
(lecturas, con claves BibTeX)
```

Reglas de contenido:
- Cada afirmación factual (cifras, fechas, aplicaciones) lleva **fuente enlazada**. Prohibido inventar citas, DOIs o cifras; si no se puede verificar, escribir "por verificar" y registrarlo en `docs/ESTADO.md`.
- Longitud objetivo: 600–1200 palabras por ficha. Tono divulgativo riguroso; fórmulas en LaTeX (`$...$`) solo si aportan.
- "Antes y después" debe ser concreto (ej. qué se creía/hacía antes, qué herramienta/política existe ahora).
- "Cómo se aplica hoy": mínimo 3 aplicaciones con ejemplo real.

---

## 5. Descarga de referencias (`scripts/01_descargar_referencias.R`)

- Por cada laureado, en `referencias.bib` lista las **3–8 obras clave** (artículos seminales, libros, discurso Nobel y *Advanced/Scientific Background* del comité, ambos en nobelprize.org y de libre acceso).
- Descarga automática **solo si es legal**: vía Unpaywall API (`https://api.unpaywall.org/v2/<doi>?email=...`), OpenAlex (`open_access.oa_url`), arXiv, RePEc/SSRN abiertos, nobelprize.org. Usa `httr2`, `jsonlite`, `rcrossref`/`openalexR`.
- **Nunca** uses Sci-Hub ni otras fuentes piratas. Para libros con copyright: solo metadatos + enlace (Google Books/WorldCat/editorial).
- Registra todo en `manifest.csv` (`estado_descarga` ∈ `descargado`, `solo_enlace`, `fallo`) y la licencia detectada.
- Respeta rate limits (`Sys.sleep`), reintentos con backoff, idempotencia (no re-descargar si existe).
- `.gitignore`: ignora `*.pdf` mayores a 20 MB; usa Git LFS (`*.pdf`) o publica solo manifest si el peso del repo crece. Documenta la decisión.
- Email de contacto para APIs: leer de variable de entorno `NOBEL_CONTACT_EMAIL` (nunca hardcodeado).

---

## 6. Replicación en R

Estándares:
- R ≥ 4.3, `renv` para versiones, `tidyverse`, estilo tidyverse (`styler`/`lintr`).
- Cada `replicar.qmd` debe: (1) declarar objetivo y qué resultado del paper se reproduce, (2) obtener datos de forma automática (paquetes de R, APIs abiertas: FRED, World Bank, Penn World Table, Kenneth French Data Library, datos del replication package del autor) o **simular** datos con semilla fija (`set.seed`), (3) generar figuras/tablas en `salidas/`, (4) cerrar con comparación contra el resultado publicado y limitaciones.
- Tres niveles: **completa** (mismos datos/resultado), **parcial** (datos sustitutos), **ilustrativa** (simulación didáctica). Indícalo en la ficha. No afirmes replicar si no es así.
- Los scripts deben correr en <5 min cada uno en CI; si no, ofrecer modo `FAST=TRUE` con muestra reducida.
- Ideas de referencia para pilotos:
  - Markowitz/Sharpe: frontera eficiente y CAPM con datos de Kenneth French / `tidyquant`.
  - Nash: equilibrios en juegos 2x2 y dilema del prisionero iterado (simulación).
  - Black–Scholes–Merton: fórmula cerrada vs. Monte Carlo vs. árbol binomial.
  - Kahneman: función de valor de la teoría prospectiva, simulación de aversión a pérdidas.
  - Banerjee/Duflo/Kremer: análisis de un RCT con datos abiertos (ej. replication packages en Harvard Dataverse / J-PAL) y ajuste por múltiples hipótesis.
  - Card/Angrist/Imbens: DiD (salario mínimo NJ–PA, Card & Krueger) y IV/LATE con `fixest`, `AER`.
  - Acemoglu/Johnson/Robinson: IV con mortalidad de colonos (datos del replication package AER 2001).
- Para laureados teóricos sin datos replicables, haz una **simulación didáctica** del modelo central.

---

## 7. Sitio web

**Stack recomendado (simple y estático):** Quarto website **o** Astro/Next.js estático. Elegir uno, justificar en `docs/DECISIONES.md`. Despliegue en **GitHub Pages**.

Requisitos funcionales:
1. **Home**: línea de tiempo interactiva 1969–hoy (un nodo por año) + buscador y filtros por área (micro, macro, finanzas, econometría, desarrollo, teoría de juegos, comportamental, historia económica, etc.), década y tag.
2. **Página por año/laureado** (generada desde `ficha.md`): secciones del §4 con navegación lateral; bloque destacado "Antes → Después"; tarjetas de "Aplicaciones hoy"; lista de referencias con enlace a PDF (si existe) o a la fuente; enlace a la carpeta de replicación en GitHub y figuras principales embebidas desde `salidas/`.
3. **Página "Temas"**: agrupa laureados por tema y muestra relaciones entre aportes (grafo opcional).
4. **Página "Metodologías"**: glosario de métodos (DiD, IV, RCT, VAR, equilibrio de Nash, etc.) enlazando a los laureados que los usan.
5. **Acerca de / Metodología del proyecto** y estado de completitud.
6. Búsqueda de texto completo en cliente (Pagefind/Lunr).
7. Responsive, accesible (WCAG AA), modo claro/oscuro, carga rápida (Lighthouse ≥ 90).
8. Sin backend; contenido proviene de `data/laureados.csv` + fichas md (build-time).

Diseño: sobrio, editorial/académico; tipografía serif para texto largo, sans para UI; paleta contenida. Evitar plantillas genéricas.

---

## 8. Plan de ejecución (orden obligatorio)

1. **Fase 0 – Andamiaje**: estructura, `README.md`, `.gitignore`, `renv`, CI, `utils.R`.
2. **Fase 1 – Catálogo**: generar y verificar `data/laureados.csv` desde nobelprize.org.
3. **Fase 2 – Pilotos (7)**: referencias + replicación + ficha completa para cada uno.
4. **Fase 3 – Web**: construir el sitio, alimentarlo con los pilotos, desplegar.
5. **Fase 4 – Resto de laureados** en lotes (por década), actualizando `docs/ESTADO.md`.
6. **Fase 5 – Calidad**: revisar enlaces rotos, verificar citas, lint, CI en verde.

Al terminar cada fase: commit con mensaje convencional (`feat:`, `docs:`, `chore:`), actualizar `docs/ESTADO.md`.

---

## 9. Criterios de aceptación (por laureado)

- [ ] Carpeta con nombre canónico y estructura completa.
- [ ] `referencias.bib` (≥3 entradas verificadas) y `manifest.csv` coherentes.
- [ ] `replicar.qmd` renderiza sin errores desde un entorno limpio (`renv::restore()`).
- [ ] `ficha.md` con todas las secciones, fuentes enlazadas, ≥3 aplicaciones actuales.
- [ ] Aparece correctamente en la web y en la búsqueda.
- [ ] Nivel de replicación declarado con honestidad.

## 10. Reglas para el agente

- No inventes datos, citas, DOIs ni URLs: verifica con fuentes (nobelprize.org, Crossref, OpenAlex). Ante duda, marca "por verificar".
- Respeta derechos de autor: solo descarga material de acceso abierto/licencia permitida.
- Prefiere añadir archivos nuevos; no reescribas trabajo ya aprobado por el usuario.
- Mantén secretos fuera del repo (`.Renviron`, emails, tokens).
- Cambios pequeños y commits frecuentes; documenta decisiones no obvias en `docs/DECISIONES.md`.
- Si el alcance excede una sesión, avanza por fases y deja `docs/ESTADO.md` actualizado para retomar.

---

## 11. Arranque: Nobel 2026 (PRIORIDAD 0 — hacer primero)

Este anexo **prevalece sobre el orden de pilotos del §3 y §8**: el primer laureado a construir end-to-end es el de **2026**, anunciado el **12 de octubre de 2026**.

**Datos verificados en nobelprize.org** (https://www.nobelprize.org/prizes/economic-sciences/2026/press-release/):
- Laureados: **Robert E. Hall** (Stanford University, EE. UU.) y **Michael Woodford** (Columbia University, EE. UU.).
- Motivación oficial: "for microeconomic foundations of macroeconomic stabilisation" (verifica la redacción exacta en el press release antes de copiarla a `motivacion_oficial`).
- Materiales oficiales (de libre acceso, descárgalos como referencias base):
  - Press release: https://www.nobelprize.org/prizes/economic-sciences/2026/press-release/
  - Popular information ("Microfoundations deliver macro insights"): https://www.nobelprize.org/prizes/economics/2026/popular-information/
  - Scientific background ("Microeconomic foundations of macroeconomic stabilization"): https://www.nobelprize.org/prizes/economics/2026/advanced-information/
  - Hechos de cada laureado: `.../2026/hall/facts/` y `.../2026/woodford/facts/`.

**Tareas concretas:**
1. Crear `laureados/2026_hall_woodford/` con la estructura del §2.
2. Añadir la fila 2026 a `data/laureados.csv` con `prioridad = 0`.
3. `referencias.bib`: 3–8 obras clave **tomadas del Scientific Background del comité** (no de memoria). Verifica DOI en Crossref/OpenAlex. Incluye también el discurso Nobel cuando se publique.
4. Replicación en R (`replicar.qmd`), nivel a declarar con honestidad. Sugerencias:
   - Ilustrativa: modelo Nuevo Keynesiano de 3 ecuaciones (curva IS, curva de Phillips, regla de Taylor); funciones impulso-respuesta ante un shock de política monetaria y de demanda; comparación de reglas de política. Paquetes: base R/`tidyverse`; opcional `gEcon`/solución manual con álgebra matricial.
   - Parcial: modelo de búsqueda y emparejamiento (Diamond-Mortensen-Pissarides) y desempleo con datos de FRED (`fredr`, sin API key hardcodeada: usar variable de entorno `FRED_API_KEY`).
   - Parcial: regla de Taylor estimada con datos de FRED (tasa de fondos federales, inflación, brecha del producto).
   - No afirmes replicar resultados de los autores salvo que uses sus datos/código.
5. `ficha.md` completa (§4) con "Antes y después" concreto (p. ej. macro de la síntesis neoclásica y modelos sin microfundamentos / crítica de Lucas, vs. modelos de política con agentes optimizadores usados por bancos centrales) y ≥3 aplicaciones actuales con fuente. **No inventes** contribuciones específicas de Hall o Woodford: básate exclusivamente en el Scientific Background del comité; lo no verificable va como "por verificar" en `docs/ESTADO.md`.
6. Dado que el premio es de hoy, cualquier cobertura periodística es reciente: prioriza fuentes primarias (Academia Sueca) sobre prensa.

Después del 2026, continúa con los pilotos del §3 y luego el resto cronológico.

---

## 12. Enfoque académico y docente (aplica a todo el repo)

El repo es material **educativo para compartir**: un docente lo entrega a sus estudiantes, quienes deben poder (a) **reproducir el código** sin ayuda y (b) **entender la economía** en la web de forma amigable.

Requisitos transversales (se suman a los de §6 y §7):
- **Reproducibilidad para estudiantes**: instrucciones paso a paso (instalar R, RStudio, Quarto, `renv::restore()`, renderizar un `.qmd`) en `README.md` y en `docs/GUIA_ESTUDIANTE.md`. Asumir que el estudiante nunca usó `renv` ni Quarto. Alternativa sin instalación: `.devcontainer/` (GitHub Codespaces) y/o `Dockerfile` con R + Quarto.
- **Cada `replicar.qmd`** incluye: bloque "¿Qué vas a aprender?", código comentado en español, sección "Ejercicios para el estudiante" (3 ejercicios: básico, intermedio, reto) y "Preguntas de discusión". Las soluciones van en `docente/` (no en la web pública del estudiante).
- **Lectura amigable en la web**: cada ficha abre con "En una frase" y un recuadro "Si solo tienes 2 minutos"; glosario emergente de términos técnicos; analogías cotidianas; nivel de dificultad (básico/intermedio/avanzado) por ficha; tiempo estimado de lectura.
- **Licencias**: código MIT, contenido textual CC BY 4.0; papers de terceros solo con su licencia propia (ver `docs/FUENTES.md`). Añadir `LICENSE` y `CITATION.cff`.
- **Cita sugerida** y créditos del docente en "Acerca de".

### 12.1 Estructura de carpetas adicional (se añade a la de §2)

```
Nobel_economics/
├── LICENSE
├── CITATION.cff
├── Dockerfile                      # R + Quarto reproducible
├── .devcontainer/devcontainer.json # Codespaces: abrir y correr sin instalar
├── docs/
│   ├── GUIA_ESTUDIANTE.md          # cómo clonar, instalar, correr y entender
│   ├── GUIA_DOCENTE.md             # cómo usarlo en clase, evaluación, rúbricas
│   ├── ORQUESTACION.md             # plan de subagentes (ver §13)
│   └── PLANTILLAS/
│       ├── ficha_plantilla.md
│       └── replicar_plantilla.qmd  # esqueleto con ejercicios
├── laureados/
│   └── AAAA_apellido/
│       ├── ... (estructura de §2)
│       ├── docente/                # soluciones, rúbrica, preguntas de examen (opcional)
│       └── estudiante/
│           └── ejercicios.qmd      # ejercicios sin solución
└── web/
    └── content/                    # generado; nunca editar a mano
```

---

## 13. Orquestación con subagentes

El agente principal (**Orquestador**) NO escribe contenido de laureados: coordina, valida y hace merge. Los subagentes trabajan en paralelo, cada uno en su propia carpeta `laureados/<slug>/` (sin pisar archivos de otros).

### 13.1 Roles

| Subagente | Entrada | Salida | No debe tocar |
|---|---|---|---|
| **Catalogador** | nobelprize.org / API | `data/laureados.csv` verificado | fichas |
| **Referencista** (1 por laureado) | slug, Scientific Background | `referencias.bib`, `manifest.csv`, PDFs abiertos | replicación |
| **Replicador-R** (1 por laureado) | slug, referencias | `replicacion/` + `replicar.qmd` renderizado + `salidas/` + `estudiante/ejercicios.qmd` | ficha |
| **Redactor** (1 por laureado) | referencias + salidas | `web/ficha.md` y `README.md` del laureado | código R |
| **Verificador** | todo lo anterior | informe de verificación (citas, DOIs, enlaces, cifras) en `docs/ESTADO.md` | contenido (solo reporta) |
| **Desarrollador-Web** | fichas + csv | `web/` (sitio, buscador, temas, metodologías) | `laureados/` |
| **Editor-Didáctico** | fichas + qmd | glosario, ejercicios, guías (`docs/GUIA_*.md`), revisión de claridad para estudiantes | datos |
| **QA/CI** | repo | workflows, lint, enlaces rotos, build limpio | contenido |

### 13.2 Flujo y paralelismo

```
Fase A (secuencial):  Orquestador crea andamiaje (§8 Fase 0) + Catalogador (Fase 1)
Fase B (2026 primero): Referencista -> {Replicador-R || Redactor (esqueleto)} -> Redactor (final) -> Verificador
                       en paralelo: Desarrollador-Web construye el sitio con la ficha 2026 como caso real
Fase C (pilotos):     lanzar en paralelo hasta 7 cadenas B (una por piloto), máx. 4 concurrentes
Fase D (resto):       lotes por década (p. ej. 1969-1979), cada lote en paralelo
Fase E (calidad):     Verificador + QA/CI + Editor-Didáctico sobre todo el repo
```

Reglas de coordinación:
1. **Un laureado = un propietario por archivo.** Conflictos de merge se evitan por diseño de carpetas; `data/laureados.csv`, `docs/ESTADO.md` y `docs/DECISIONES.md` solo los edita el Orquestador (los subagentes le envían su actualización).
2. **Contrato de entrega**: cada subagente termina con un reporte breve: archivos creados, qué verificó, qué marcó "por verificar", nivel de replicación honesto, tiempo de ejecución.
3. **Prompt base de cada subagente**: leer `AGENTS.md` completo, su rol (§13.1) y el slug asignado; no inventar citas/DOIs/cifras; idioma español; respetar plantillas de `docs/PLANTILLAS/`.
4. **Definición de hecho** por laureado = checklist de §9 + ejercicios para estudiante (§12) + aprobación del Verificador.
5. **Fallos**: si `replicar.qmd` no renderiza o una cita no se verifica, el Orquestador reasigna una vez; si persiste, marca `estado` y la causa en `docs/ESTADO.md` y sigue con el siguiente.
6. **Presupuesto de contexto**: un subagente por laureado y por rol; pasar solo slug y rutas, no contenido pegado.
7. **Commits**: un commit por laureado y fase (`feat(2026): referencias`, `feat(2026): replicacion`, ...).

### 13.3 Orden de arranque (primer sprint)

1. Orquestador: andamiaje + `docs/ORQUESTACION.md` (copia resumida de §13) + plantillas.
2. Catalogador: CSV completo; fila 2026 con `prioridad=0`.
3. Cadena 2026 (§11) con los roles de §13.1; en paralelo Desarrollador-Web y Editor-Didáctico.
4. Revisión humana del docente de la ficha 2026 y de la web antes de lanzar los pilotos (Fase C).

---

## 14. Estructura canónica final (ORDENADA) — fuente de verdad

Consolida §2 y §12.1. Si hay contradicción, **manda esta sección**. Principio: *raíz limpia* (solo lo que un estudiante necesita ver primero), todo lo demás agrupado por función.

```
Nobel_economics/
│
├── README.md                  # portada: qué es + inicio rápido (3 pasos)
├── AGENTS.md                  # instrucciones para IA
├── LICENSE  CITATION.cff
├── .gitignore  .gitattributes # (LFS para PDFs si hace falta)
├── renv.lock  .Rprofile       # entorno R reproducible
├── Dockerfile
├── .devcontainer/
├── .github/workflows/         # r-check.yml, deploy-web.yml
│
├── data/                      # catálogo global
│   ├── laureados.csv
│   └── glosario.csv           # términos técnicos -> web
│
├── laureados/                 # UN LAUREADO = UNA CARPETA
│   ├── 2026_hall_woodford/
│   │   ├── README.md          # índice de la carpeta (qué hay y por dónde empezar)
│   │   ├── referencias/       # bib, manifest.csv, pdf/ (solo acceso abierto)
│   │   ├── replicacion/       # replicar.qmd, R/, datos/, salidas/
│   │   ├── estudiante/        # ejercicios.qmd (sin solución)
│   │   ├── docente/           # soluciones, rúbrica (no se publica en la web)
│   │   └── web/               # ficha.md (fuente única del contenido web)
│   └── AAAA_apellido/         # misma estructura; nombre ASCII, minúsculas
│
├── scripts/                   # automatización numerada (00_ ... 03_), utils.R
│
├── web/                       # sitio estático
│   ├── src/                   # código del sitio
│   ├── content/               # GENERADO desde laureados/*/web — no editar
│   └── public/                # imágenes, fuentes
│
├── docs/
│   ├── GUIA_ESTUDIANTE.md  GUIA_DOCENTE.md
│   ├── ORQUESTACION.md  DECISIONES.md  FUENTES.md  ESTADO.md
│   └── PLANTILLAS/            # ficha_plantilla.md, replicar_plantilla.qmd
│
└── _output/                   # builds locales (ignorado por git)
```

Reglas de orden:
1. **Raíz**: no crear archivos sueltos fuera de lo listado; todo código en `scripts/`, todo contenido en `laureados/`.
2. **Una sola fuente por dato**: contenido web solo en `laureados/*/web/ficha.md`; metadatos en `data/laureados.csv`. `web/content/` se regenera.
3. **Nombres**: ASCII, minúsculas, sin espacios; carpetas de laureados `AAAA_apellido[_apellido2]`; scripts con prefijo numérico; salidas con prefijo `fig_`/`tab_`.
4. **Cada carpeta de laureado tiene `README.md`** de 5 líneas con enlaces a sus subcarpetas, para que un estudiante no se pierda.
5. **Carpetas vacías** llevan `.gitkeep`.
6. **Ignorar en git**: `_output/`, `.Rproj.user/`, `*.html` renderizados, `.Renviron`, `node_modules/`, PDFs >20 MB, datos crudos grandes.
7. **Archivos pesados** (PDF/datos): solo en `referencias/pdf/` y `replicacion/datos/`; si pasan de 20 MB, script de descarga en lugar del archivo.

---

## 15. Apps Shiny interactivas (obligatorio por laureado)

Para que el material sea súper amigable, **cada laureado debe tener al menos una app Shiny** donde el estudiante mueva parámetros y vea cómo cambia el resultado (sin escribir código). Ejemplo 2026: modelo Nuevo Keynesiano con sliders para la regla de Taylor, persistencia del shock y pendiente de la curva de Phillips, mostrando impulso-respuesta en vivo.

### 15.1 Estructura (se suma a §14)

```
laureados/AAAA_apellido/
└── shiny/
    ├── app.R              # app autocontenida (o ui.R/server.R)
    ├── R/                 # funciones (reutilizar las de replicacion/R/, sin duplicar lógica)
    └── README.md          # qué enseña la app, parámetros, cómo correrla local
web/public/apps/           # GENERADO: export shinylive (no editar)
```

### 15.2 Requisitos

- **Despliegue sin servidor (preferido):** exportar con **`shinylive`** (Shiny corriendo en el navegador vía WebAssembly/webR) para que funcione dentro de GitHub Pages, sin backend, e incrustarla en la ficha con `<iframe>`. Si un paquete no es compatible con webR, usar Shiny normal en shinyapps.io o Posit Connect Cloud y **registrar la decisión en `docs/DECISIONES.md`**; la ficha enlaza a la app.
- **Local:** `shiny::runApp("laureados/<slug>/shiny")` debe funcionar tras `renv::restore()`. Documentarlo en `docs/GUIA_ESTUDIANTE.md`.
- **Didáctica:** título claro, 2–5 controles (sliders/selectores) con etiquetas en español y ayuda breve, un gráfico principal, un recuadro "¿Qué estoy viendo?" que explica el resultado y botón "Restablecer valores".
- **Ligera y robusta:** sin API keys ni descargas en vivo; usar datos simulados con semilla o archivos pequeños en `shiny/` o `replicacion/datos/`. Respuesta < 1 s por interacción.
- **Accesible:** contraste AA, etiquetas en controles, texto alternativo en gráficos, `bslib` con modo claro/oscuro coherente con la web.
- **Coherencia:** la app usa el mismo modelo/código que `replicar.qmd`; no inventes resultados distintos. Indicar nivel (ilustrativa/parcial/completa) igual que en la ficha.
- **Ejercicio guiado:** `estudiante/ejercicios.qmd` incluye al menos un ejercicio del tipo "usa la app y responde: ¿qué pasa si…?"; las respuestas van en `docente/`.
- **Testeo:** `shinytest2` o prueba de humo (la app arranca sin error) en CI (`r-check.yml`).
- **Paquetes:** `shiny`, `bslib`, `plotly` o `ggplot2`; fijarlos en `renv.lock`.

### 15.3 Cambios en otros roles y fases

- **Nuevo subagente "Desarrollador-Shiny"** (1 por laureado): entrada = `replicacion/R/` + ficha; salida = `shiny/` + export shinylive; no toca `ficha.md` ni la web. Va **después del Replicador-R y en paralelo al Redactor**.
- **Desarrollador-Web:** incrusta la app en cada página de laureado (sección "Pruébalo tú mismo") y añade en el Home un filtro/insignia "Tiene app interactiva".
- **Verificador:** comprueba que la app corre y que sus parámetros por defecto reproducen la figura principal de `salidas/`.
- **Definición de hecho (§9 y §13.2.4):** se suma "app Shiny funcional y enlazada en la web".
- **Fase B 2026** queda: Referencista → {Replicador-R → Desarrollador-Shiny || Redactor} → Verificador.

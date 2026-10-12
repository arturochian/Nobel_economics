import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { parse as parseCsv } from "csv-parse/sync";
import yaml from "js-yaml";
import katex from "katex";
import { marked } from "marked";

const webDir = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const rootDir = path.resolve(webDir, "..");
const outDir = path.join(webDir, "dist");
const laureatesDir = path.join(rootDir, "laureados");
const githubRepo = "https://github.com/arturochian/Nobel_economics";

marked.use({
  extensions: [
    {
      name: "blockMath",
      level: "block",
      start(source) { return source.indexOf("$$"); },
      tokenizer(source) {
        const match = /^\$\$\s*([\s\S]+?)\s*\$\$(?:\n|$)/.exec(source);
        return match ? { type: "blockMath", raw: match[0], text: match[1] } : undefined;
      },
      renderer(token) {
        return katex.renderToString(token.text, { displayMode: true, throwOnError: false });
      }
    },
    {
      name: "inlineMath",
      level: "inline",
      start(source) { return source.indexOf("$"); },
      tokenizer(source) {
        const match = /^\$(?!\s)((?:\\.|[^$\\\n])+?)(?<!\s)\$/.exec(source);
        return match ? { type: "inlineMath", raw: match[0], text: match[1] } : undefined;
      },
      renderer(token) {
        return katex.renderToString(token.text, { displayMode: false, throwOnError: false });
      }
    }
  ]
});

const esc = (value = "") => String(value)
  .replaceAll("&", "&amp;").replaceAll("<", "&lt;")
  .replaceAll(">", "&gt;").replaceAll('"', "&quot;");
const slugify = (value = "") => String(value).normalize("NFD")
  .replace(/[\u0300-\u036f]/g, "").toLowerCase()
  .replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "");
const arr = (value) => Array.isArray(value) ? value : value ? [value] : [];
const plain = (value = "") => String(value).replace(/<[^>]*>/g, " ")
  .replace(/[\*_`#$>\[\]()]/g, " ").replace(/\s+/g, " ").trim();
const exists = (target) => fs.existsSync(target);

function readFrontMatter(file) {
  const raw = fs.readFileSync(file, "utf8").replace(/^\uFEFF/, "");
  const match = raw.match(/^---\s*\r?\n([\s\S]*?)\r?\n---\s*\r?\n?/);
  if (!match) return { data: {}, body: raw };
  return { data: yaml.load(match[1]) || {}, body: raw.slice(match[0].length) };
}

function sectionText(markdown, title) {
  const sections = [...markdown.matchAll(/^##\s+(.+)$/gm)];
  const index = sections.findIndex((match) => match[1].trim().toLowerCase() === title.toLowerCase());
  if (index < 0) return "";
  const start = sections[index].index + sections[index][0].length;
  const end = sections[index + 1]?.index ?? markdown.length;
  return plain(markdown.slice(start, end));
}

function addHeadingIds(html) {
  return html.replace(/<h([23])>([\s\S]*?)<\/h\1>/g, (_, level, content) => {
    const id = slugify(plain(content));
    return `<h${level} id="${id}">${content}<a class="heading-anchor" href="#${id}" aria-label="Enlace a esta sección">#</a></h${level}>`;
  });
}

function readManifest(slug) {
  const file = path.join(laureatesDir, slug, "referencias", "manifest.csv");
  if (!exists(file)) return [];
  try { return parseCsv(fs.readFileSync(file, "utf8"), { columns: true, skip_empty_lines: true, bom: true }); }
  catch { return []; }
}

function readFigures(slug) {
  const dir = path.join(laureatesDir, slug, "replicacion", "salidas");
  if (!exists(dir)) return [];
  return fs.readdirSync(dir).filter((name) => /\.(png|jpe?g|svg|webp)$/i.test(name)).slice(0, 4);
}

function link(depth, target = "") {
  const value = `${"../".repeat(depth)}${target}`;
  return value || "./";
}

function rewriteRepositoryLinks(markdown, slug) {
  return markdown
    .replace(/file:\/{3}[^)\s]*?Nobel_economics[\\/](laureados[\\/][^)\s]+)/gi, (_, relative) =>
      `${githubRepo}/blob/main/${relative.replaceAll("\\", "/")}`)
    .replace(/\]\(((?:\.\.\/)*(?:replicacion|referencias|shiny)\/[^)\s]*)([^)]*)\)/g, (_, relative, suffix) => {
      const clean = relative.replace(/^(?:\.\.\/)+/, "");
      return `](${githubRepo}/blob/main/laureados/${slug}/${clean}${suffix})`;
    });
}

function icon(name) {
  const icons = {
    search: '<svg aria-hidden="true" viewBox="0 0 24 24"><path d="m21 21-4.3-4.3m2.3-5.2A7.5 7.5 0 1 1 4 11.5a7.5 7.5 0 0 1 15 0Z"/></svg>',
    sun: '<svg aria-hidden="true" viewBox="0 0 24 24"><circle cx="12" cy="12" r="4"/><path d="M12 2v2m0 16v2M4.9 4.9l1.4 1.4m11.4 11.4 1.4 1.4M2 12h2m16 0h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>'
  };
  return icons[name];
}

function shell({ title, description, depth = 0, active = "", body, pageClass = "" }) {
  const home = link(depth);
  const nav = [
    ["inicio", "Inicio", home], ["temas", "Temas", `${home}temas/`],
    ["metodos", "Metodologías", `${home}metodologias/`], ["acerca", "Acerca", `${home}acerca/`]
  ].map(([key, label, href]) => `<a ${active === key ? 'aria-current="page"' : ""} href="${href}">${label}</a>`).join("");
  return `<!doctype html>
<html lang="es" data-theme="auto"><head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>${esc(title)} · Nobel de Economía</title>
<meta name="description" content="${esc(description)}"><meta name="color-scheme" content="light dark">
<link rel="icon" href="${home}assets/mark.svg" type="image/svg+xml">
<link rel="stylesheet" href="${home}assets/katex.min.css">
<link rel="stylesheet" href="${home}assets/site.css">
<script>document.documentElement.dataset.theme=localStorage.getItem('theme')||'auto'</script>
</head><body class="${pageClass}">
<a class="skip-link" href="#contenido">Saltar al contenido</a>
<header class="site-header"><div class="header-inner">
<a class="brand" href="${home}" aria-label="Nobel de Economía, inicio"><span class="brand-mark">N</span><span>Nobel <i>de Economía</i></span></a>
<nav aria-label="Navegación principal">${nav}</nav>
<button class="theme-toggle" type="button" aria-label="Cambiar modo de color" title="Cambiar modo de color">${icon("sun")}</button>
</div></header>
<main id="contenido">${body}</main>
<footer><div><strong>Nobel de Economía</strong><p>Economía que se puede leer, discutir y reproducir.</p></div><div><a href="${githubRepo}">Código en GitHub</a><p>Contenido CC BY 4.0 · Código MIT</p></div></footer>
<script src="${home}assets/site.js" defer></script>
</body></html>`;
}

function writePage(relative, html) {
  const target = path.join(outDir, relative, "index.html");
  fs.mkdirSync(path.dirname(target), { recursive: true });
  fs.writeFileSync(target, html);
}

function pill(value) { return `<span class="pill">${esc(value)}</span>`; }

fs.rmSync(outDir, { recursive: true, force: true });
fs.mkdirSync(outDir, { recursive: true });

const catalog = parseCsv(fs.readFileSync(path.join(rootDir, "data", "laureados.csv"), "utf8"), {
  columns: true, skip_empty_lines: true, bom: true, relax_column_count: true
});
const catalogSlugs = new Set(catalog.map((row) => row.slug));
const fichaSlugs = exists(laureatesDir) ? fs.readdirSync(laureatesDir, { withFileTypes: true })
  .filter((item) => item.isDirectory() && exists(path.join(laureatesDir, item.name, "web", "ficha.md")))
  .map((item) => item.name) : [];
const uncatalogued = fichaSlugs.filter((slug) => !catalogSlugs.has(slug)).map((slug) => ({
  slug, anio: slug.slice(0, 4), laureados: "", pais_afiliacion: "", area: "",
  aporte_corto: "", prioridad: 2, estado: "web"
}));
const entries = [...catalog, ...uncatalogued].map((row) => {
  const ficha = path.join(laureatesDir, row.slug, "web", "ficha.md");
  const parsed = exists(ficha) ? readFrontMatter(ficha) : { data: {}, body: "" };
  const metadata = parsed.data;
  const areas = arr(metadata.area).length ? arr(metadata.area) : String(row.area || "").split(/\s*\/\s*/).filter(Boolean);
  const figures = readFigures(row.slug);
  return {
    ...row, anio: Number(row.anio), prioridad: Number(row.prioridad),
    laureates: arr(metadata.laureados).length ? arr(metadata.laureados) : String(row.laureados || "").split(/,\s*/),
    areas, tags: arr(metadata.tags), body: parsed.body, metadata, figures,
    summary: sectionText(parsed.body, "En una frase") || row.aporte_corto || "Ficha en preparación.",
    available: exists(ficha), hasApp: exists(path.join(laureatesDir, row.slug, "shiny", "app.R"))
  };
}).sort((a, b) => b.anio - a.anio);

const availableCount = entries.filter((item) => item.available).length;
const appCount = entries.filter((item) => item.hasApp).length;
const areas = [...new Set(entries.flatMap((item) => item.areas))].sort((a, b) => a.localeCompare(b, "es"));
const tags = [...new Set(entries.flatMap((item) => item.tags))].sort((a, b) => a.localeCompare(b, "es"));
const decades = [...new Set(entries.map((item) => Math.floor(item.anio / 10) * 10))].sort((a, b) => b - a);

const byYear = new Map(entries.map((item) => [item.anio, item]));
const lastYear = Math.max(2026, ...entries.map((item) => item.anio));
const timelineYears = Array.from({ length: lastYear - 1969 + 1 }, (_, offset) => 1969 + offset);
const missingYearCount = timelineYears.filter((year) => !byYear.has(year)).length;
const timeline = timelineYears.map((year) => {
  const item = byYear.get(year);
  return item
    ? `<a class="timeline-node ${item.available ? "is-ready" : ""}" href="laureados/${item.slug}/" title="${esc(item.laureates.join(", "))}" aria-label="${year}: ${esc(item.laureates.join(", "))}"><span>${year}</span></a>`
    : `<span class="timeline-node is-missing" title="${year}: pendiente de catalogación" aria-label="${year}: pendiente de catalogación"><span>${year}</span></span>`;
}).join("");
const timelineDescription = missingYearCount === 0
  ? "La colección cubre todos los premios desde 1969. Selecciona un año para abrir su ficha, replicación y materiales docentes."
  : `Los nodos dorados ya tienen una ficha para leer; ${missingYearCount} ${missingYearCount === 1 ? "año continúa" : "años continúan"} en preparación.`;

const cards = entries.map((item) => `<article class="laureate-card" data-year="${item.anio}" data-decade="${Math.floor(item.anio / 10) * 10}" data-area="${esc(item.areas.join("|"))}" data-tags="${esc(item.tags.join("|"))}" data-state="${esc(item.estado)}" data-app="${item.hasApp}" data-search="${esc([item.anio, ...item.laureates, ...item.areas, ...item.tags, item.summary].join(" ").toLowerCase())}">
<a href="laureados/${item.slug}/" aria-label="Abrir ficha de ${esc(item.laureates.join(", "))}"><div class="card-year">${item.anio}<span class="status-dot ${item.available ? "ready" : "pending"}" aria-hidden="true"></span></div>
<h2>${esc(item.laureates.join(" · "))}</h2><p>${esc(item.summary)}</p>
<div class="card-meta">${item.areas.slice(0, 2).map(pill).join("")}${item.hasApp ? '<span class="pill interactive">Interactiva</span>' : ""}</div></a></article>`).join("");

const homeBody = `<section class="hero"><div class="eyebrow">Archivo vivo · 1969—${entries[0]?.anio || "hoy"}</div>
<h1>Las ideas que cambiaron<br><em>la economía.</em></h1>
<p class="hero-intro">Una historia visual y reproducible del Premio Nobel de Economía: qué descubrió cada laureado, qué cambió y cómo comprobarlo con R.</p>
<div class="hero-stats"><div><strong>${entries.length}</strong><span>años catalogados</span></div><div><strong>${availableCount}</strong><span>fichas publicadas</span></div><div><strong>${appCount}</strong><span>apps interactivas</span></div></div>
</section>
<section class="timeline-section" aria-labelledby="timeline-title"><div class="section-heading"><div><span class="kicker">Explora por año</span><h2 id="timeline-title">Una línea de tiempo de ideas</h2></div><p>${timelineDescription}</p></div><div class="timeline" tabindex="0" aria-label="Premios Nobel de Economía por año">${timeline}</div></section>
<section class="archive" aria-labelledby="archive-title"><div class="section-heading"><div><span class="kicker">El archivo</span><h2 id="archive-title">Encuentra una investigación</h2></div><p id="result-count" aria-live="polite">${entries.length} resultados</p></div>
<div class="filters"><label class="search-field">${icon("search")}<span class="sr-only">Buscar</span><input id="search" type="search" placeholder="Busca una idea, persona o método…" autocomplete="off"></label>
<label><span>Área</span><select id="area-filter"><option value="">Todas</option>${areas.map((x) => `<option>${esc(x)}</option>`).join("")}</select></label>
<label><span>Década</span><select id="decade-filter"><option value="">Todas</option>${decades.map((x) => `<option value="${x}">${x}</option>`).join("")}</select></label>
<label><span>Etiqueta</span><select id="tag-filter"><option value="">Todas</option>${tags.map((x) => `<option>${esc(x)}</option>`).join("")}</select></label>
<label><span>Estado</span><select id="state-filter"><option value="">Todos</option><option value="completo">Completo</option><option value="web">Web</option><option value="replicado">Replicado</option><option value="referencias">Referencias</option><option value="pendiente">Pendiente</option></select></label>
<label class="check-filter"><input id="app-filter" type="checkbox"><span>Con app</span></label></div>
<div id="cards" class="card-grid">${cards}</div><div id="empty-results" class="empty" hidden><strong>No encontramos coincidencias.</strong><p>Prueba con menos filtros o con otra palabra.</p></div></section>`;
writePage("", shell({ title: "Ideas que cambiaron la economía", description: "Archivo educativo y reproducible de los Premios Nobel de Economía.", active: "inicio", body: homeBody, pageClass: "home" }));

for (const item of entries) {
  const depth = 2;
  const manifests = readManifest(item.slug);
  const headings = [...item.body.matchAll(/^##\s+(.+)$/gm)].map((m) => m[1].trim());
  let article;
  if (item.available) {
    const content = addHeadingIds(marked.parse(rewriteRepositoryLinks(item.body, item.slug)));
    const refs = manifests.length ? `<section class="references" aria-labelledby="referencias-verificadas"><h2 id="referencias-verificadas">Referencias verificadas</h2><ol>${manifests.map((ref) => {
      const validUrl = /^https?:\/\//i.test(ref.url || "");
      const validDoi = ref.doi && !/^(?:NA|N\/A|null|por verificar)$/i.test(ref.doi.trim());
      const title = esc(ref.titulo || ref.id);
      return `<li>${validUrl ? `<a href="${esc(ref.url)}" rel="noopener">${title}</a>` : `<span class="reference-title">${title}</span>`}<span>${validDoi ? `DOI ${esc(ref.doi)}` : esc(ref.licencia || (validUrl ? "Fuente enlazada" : "Enlace por verificar"))}</span></li>`;
    }).join("")}</ol></section>` : "";
    const figureBlock = item.figures.length ? `<section class="figures" aria-labelledby="resultados-replicacion"><h2 id="resultados-replicacion">Resultados de la replicación</h2><div class="figure-grid">${item.figures.map((name) => `<figure><a href="../../assets/figures/${item.slug}/${encodeURIComponent(name)}"><img loading="lazy" src="../../assets/figures/${item.slug}/${encodeURIComponent(name)}" alt="Figura de la replicación de ${esc(item.laureates.join(", "))}"></a><figcaption>${esc(name.replace(/^fig_/, "").replace(/\.[^.]+$/, "").replaceAll("_", " "))}</figcaption></figure>`).join("")}</div></section>` : "";
    const appPath = path.join(webDir, "public", "apps", item.slug, "index.html");
    const appBlock = item.hasApp ? `<section class="app-callout" aria-labelledby="app-title"><div><span class="kicker">Laboratorio interactivo</span><h2 id="app-title">Pruébalo tú mismo</h2><p>Mueve los parámetros y observa cómo responde el modelo. La app utiliza el mismo enfoque que la replicación.</p></div>${exists(appPath) ? `<iframe title="Aplicación interactiva de ${esc(item.laureates.join(", "))}" loading="lazy" src="../../apps/${item.slug}/"></iframe>` : `<a class="button" href="${githubRepo}/tree/main/laureados/${item.slug}/shiny">Abrir instrucciones de la app</a>`}</section>` : "";
    const readingTime = Math.max(2, Math.ceil(plain(item.body).split(/\s+/).filter(Boolean).length / 220));
    const level = item.metadata.nivel_replicacion === "completa" ? "avanzado" : item.metadata.nivel_replicacion === "parcial" ? "intermedio" : "básico";
    article = `<div class="article-layout"><aside class="toc"><span>En esta página</span><nav>${headings.map((h) => `<a href="#${slugify(h)}">${esc(h)}</a>`).join("")}</nav></aside><article class="prose"><aside class="two-minute"><div><span>Si solo tienes 2 minutos</span><div class="reading-badges"><b>${readingTime} min de lectura</b><b>Nivel ${level}</b></div></div><p>${esc(item.summary)}</p><small>Resumen generado desde la ficha del proyecto.</small></aside>${content}${figureBlock}${appBlock}${refs}</article></div>`;
  } else {
    article = `<article class="pending-page"><span class="kicker">Ficha en preparación</span><h2>Este capítulo aún está en construcción.</h2><p>El año y sus metadatos ya forman parte del catálogo. La explicación, referencias y replicación se publicarán conforme avanza la revisión académica.</p><a class="button" href="../../">Volver al archivo</a></article>`;
  }
  const detailBody = `<header class="entry-hero"><a class="back" href="../../">← Volver al archivo</a><div class="entry-year">${item.anio}</div><h1>${esc(item.laureates.join(" · "))}</h1><p class="motivation">“${esc(item.metadata.motivacion_oficial || item.aporte_corto)}”</p><div class="entry-meta">${item.areas.map(pill).join("")}${item.metadata.nivel_replicacion ? pill(`Replicación ${item.metadata.nivel_replicacion}`) : ""}${item.hasApp ? '<span class="pill interactive">App interactiva</span>' : ""}</div></header>${article}`;
  writePage(path.join("laureados", item.slug), shell({ title: `${item.anio} — ${item.laureates.join(", ")}`, description: item.summary, depth, body: detailBody, pageClass: "entry" }));
}

const themeGroups = areas.map((area) => {
  const linked = entries.filter((item) => item.areas.includes(area));
  return `<section class="topic-group"><h2 id="${slugify(area)}">${esc(area)}</h2><p>${linked.length} ${linked.length === 1 ? "premio relacionado" : "premios relacionados"}</p><div>${linked.map((x) => `<a href="../laureados/${x.slug}/"><span>${x.anio}</span>${esc(x.laureates.join(" · "))}</a>`).join("")}</div></section>`;
}).join("");
writePage("temas", shell({ title: "Temas", description: "Los Premios Nobel de Economía agrupados por campo.", depth: 1, active: "temas", body: `<header class="page-intro"><span class="kicker">Mapa del conocimiento</span><h1>Temas</h1><p>Una misma idea suele cruzar varios campos. Explora las conexiones entre macroeconomía, instituciones, finanzas, desarrollo y más.</p></header><div class="topic-grid">${themeGroups}</div>` }));

const methodMatchers = [
  ["Diferencias en diferencias (DiD)", /diferencias en diferencias|\bDiD\b/i, "Compara el cambio de un grupo tratado con el de un grupo de control."],
  ["Variables instrumentales (IV)", /variables instrumentales|\bIV\b|instrumento/i, "Aísla variación exógena para estimar efectos causales."],
  ["Ensayo controlado aleatorizado (RCT)", /\bRCT\b|aleatori[oz]/i, "Asigna una intervención al azar para construir un contrafactual."],
  ["Series de tiempo y VAR", /\bVAR\b|series de tiempo|cointegraci|ARCH|GARCH/i, "Estudia relaciones y shocks dinámicos en datos temporales."],
  ["Equilibrio y teoría de juegos", /equilibrio|juegos|Nash|subasta|mecanismo/i, "Modela decisiones interdependientes entre agentes estratégicos."],
  ["Modelos dinámicos (DSGE)", /DSGE|dinámic|impulso-respuesta|Taylor/i, "Conecta decisiones microeconómicas con fluctuaciones agregadas."],
  ["Simulación y calibración", /simulaci|calibra/i, "Convierte un modelo teórico en resultados cuantitativos reproducibles."],
  ["Elección discreta y selección", /elección discreta|selecci[oó]n|logit/i, "Modela decisiones cualitativas y corrige muestras no aleatorias."]
];
const methods = methodMatchers.map(([name, matcher, explanation]) => {
  const linked = entries.filter((x) => matcher.test(`${x.areas.join(" ")} ${x.tags.join(" ")} ${x.summary}`));
  return `<article class="method-card"><span class="method-number">${String(linked.length).padStart(2, "0")}</span><h2>${name}</h2><p>${explanation}</p><div>${linked.slice(0, 8).map((x) => `<a href="../laureados/${x.slug}/">${x.anio} · ${esc(x.laureates[0])}</a>`).join("") || "<span>Próximamente</span>"}</div></article>`;
}).join("");
writePage("metodologias", shell({ title: "Metodologías", description: "Glosario de métodos enlazado a las fichas Nobel.", depth: 1, active: "metodos", body: `<header class="page-intro"><span class="kicker">Caja de herramientas</span><h1>Metodologías</h1><p>Del experimento natural al equilibrio general: una puerta de entrada a los métodos que hicieron posibles estos descubrimientos.</p></header><div class="method-grid">${methods}</div>` }));

const statusCounts = entries.reduce((acc, x) => ({ ...acc, [x.estado]: (acc[x.estado] || 0) + 1 }), {});
writePage("acerca", shell({ title: "Acerca del proyecto", description: "Método, alcance y estado del archivo Nobel de Economía.", depth: 1, active: "acerca", body: `<header class="page-intro"><span class="kicker">Proyecto abierto</span><h1>Leer la economía<br>con las manos.</h1><p>No basta con contar una idea: aquí cada capítulo intenta hacerla visible y reproducible.</p></header><div class="about-grid"><article><h2>Qué construimos</h2><p>Un archivo educativo en español de todos los Premios Nobel de Economía desde 1969. Cada ficha conecta el contexto histórico, el método, el cambio que produjo y una replicación en R.</p><p>El sitio se genera exclusivamente desde el catálogo y las fichas versionadas en el repositorio. No hay base de datos ni backend.</p></article><article><h2>Cómo leer el estado</h2><dl class="status-list">${Object.entries(statusCounts).map(([state, count]) => `<div><dt>${esc(state)}</dt><dd>${count}</dd></div>`).join("")}<div><dt>fichas visibles</dt><dd>${availableCount}</dd></div></dl></article><article><h2>Rigor y límites</h2><p>Las replicaciones distinguen entre completas, parciales e ilustrativas. Las fuentes enlazadas conservan sus licencias originales y el material en elaboración se muestra como tal.</p><a class="text-link" href="${githubRepo}">Ver metodología y fuentes en GitHub →</a></article><article><h2>Para el aula</h2><p>Las guías, ejercicios y aplicaciones interactivas permiten recorrer los modelos sin ocultar sus supuestos. El código puede ejecutarse localmente o en un entorno reproducible.</p><a class="text-link" href="${githubRepo}/blob/main/docs/GUIA_ESTUDIANTE.md">Guía para estudiantes →</a></article></div>` }));

const index = entries.map((x) => ({ title: `${x.anio} · ${x.laureates.join(", ")}`, url: `laureados/${x.slug}/`, text: plain(`${x.summary} ${x.body}`), areas: x.areas, tags: x.tags, available: x.available }));
fs.writeFileSync(path.join(outDir, "search-index.json"), JSON.stringify(index));

const assetOut = path.join(outDir, "assets");
fs.mkdirSync(assetOut, { recursive: true });
for (const name of ["site.css", "site.js", "mark.svg"]) fs.copyFileSync(path.join(webDir, "src", "assets", name), path.join(assetOut, name));
fs.copyFileSync(path.join(webDir, "node_modules", "katex", "dist", "katex.min.css"), path.join(assetOut, "katex.min.css"));
fs.cpSync(path.join(webDir, "node_modules", "katex", "dist", "fonts"), path.join(assetOut, "fonts"), { recursive: true });
for (const item of entries) {
  if (!item.figures.length) continue;
  const dest = path.join(assetOut, "figures", item.slug);
  fs.mkdirSync(dest, { recursive: true });
  for (const name of item.figures) fs.copyFileSync(path.join(laureatesDir, item.slug, "replicacion", "salidas", name), path.join(dest, name));
}
const publicDir = path.join(webDir, "public");
if (exists(publicDir)) fs.cpSync(publicDir, outDir, { recursive: true });
fs.writeFileSync(path.join(outDir, ".nojekyll"), "");
console.log(`Sitio generado: ${entries.length} años, ${availableCount} fichas, ${appCount} apps.`);

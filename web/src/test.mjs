import fs from "node:fs";
import path from "node:path";
import { execFileSync } from "node:child_process";
import { fileURLToPath } from "node:url";

const webDir = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
execFileSync(process.execPath, [path.join(webDir, "src", "build.mjs")], { stdio: "inherit" });

const required = [
  "dist/index.html", "dist/temas/index.html", "dist/metodologias/index.html",
  "dist/acerca/index.html", "dist/search-index.json", "dist/.nojekyll"
];
for (const relative of required) {
  if (!fs.existsSync(path.join(webDir, relative))) throw new Error(`Falta ${relative}`);
}

const home = fs.readFileSync(path.join(webDir, "dist", "index.html"), "utf8");
if (!home.includes("2026_hall_woodford")) throw new Error("La portada no incluye la ficha 2026");
if (!home.includes('id="search"')) throw new Error("La portada no incluye búsqueda");

const pages = fs.readdirSync(path.join(webDir, "dist", "laureados"));
if (pages.length < 58) throw new Error(`Solo se generaron ${pages.length} páginas de laureados; se esperaban los 58 años de 1969 a 2026`);
const index = JSON.parse(fs.readFileSync(path.join(webDir, "dist", "search-index.json"), "utf8"));
const available = index.filter((item) => item.available).length;
if (available < 58) throw new Error(`Solo se publicaron ${available} fichas; se esperaban las 58 fichas de 1969 a 2026`);
for (let year = 1969; year <= 2026; year += 1) {
  if (!index.some((item) => Number(item.title.slice(0, 4)) === year && item.available)) {
    throw new Error(`Falta una ficha disponible para ${year}`);
  }
}
if (home.includes("timeline-node is-missing")) throw new Error("La línea de tiempo todavía contiene años sin ficha");

const page2026 = fs.readFileSync(path.join(webDir, "dist", "laureados", "2026_hall_woodford", "index.html"), "utf8");
if (!page2026.includes('class="katex"')) throw new Error("Las fórmulas LaTeX no se renderizaron con KaTeX");
if (page2026.includes("$\\sigma^{-1}")) throw new Error("La ficha 2026 conserva fórmulas LaTeX sin renderizar");
const css = fs.readFileSync(path.join(webDir, "dist", "assets", "site.css"), "utf8");
if (!css.includes(".heading-anchor") || !css.includes("opacity: 0")) throw new Error("El enlace # de los títulos no queda oculto en reposo");
console.log(`Pruebas web superadas: ${pages.length} páginas, ${available} fichas disponibles.`);

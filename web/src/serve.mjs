import fs from "node:fs";
import http from "node:http";
import path from "node:path";
import { spawn } from "node:child_process";
import { fileURLToPath } from "node:url";

const webDir = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const root = path.join(webDir, "dist");
const port = Number(process.env.PORT || 4173);
const host = "127.0.0.1";
const mime = {
  ".css": "text/css; charset=utf-8",
  ".html": "text/html; charset=utf-8",
  ".js": "text/javascript; charset=utf-8",
  ".json": "application/json; charset=utf-8",
  ".png": "image/png",
  ".svg": "image/svg+xml"
};

if (!fs.existsSync(path.join(root, "index.html"))) {
  console.error("No existe web/dist/index.html. Ejecuta primero npm run build.");
  process.exit(1);
}

const server = http.createServer((request, response) => {
  const pathname = decodeURIComponent(new URL(request.url, `http://${host}`).pathname);
  const relative = pathname.endsWith("/") ? `${pathname}index.html` : pathname;
  const target = path.resolve(root, `.${relative}`);

  if (!target.startsWith(`${root}${path.sep}`) || !fs.existsSync(target) || !fs.statSync(target).isFile()) {
    response.writeHead(404, { "Content-Type": "text/plain; charset=utf-8" });
    response.end("Pagina no encontrada");
    return;
  }

  response.writeHead(200, {
    "Content-Type": mime[path.extname(target).toLowerCase()] || "application/octet-stream"
  });
  fs.createReadStream(target).pipe(response);
});

server.listen(port, host, () => {
  const url = `http://${host}:${port}/`;
  console.log(`Web disponible en ${url}`);

  if (process.env.NOBEL_OPEN_BROWSER === "1" && process.platform === "win32") {
    spawn("cmd", ["/c", "start", "", url], { detached: true, stdio: "ignore" }).unref();
  }
});

# Sitio web

Sitio estático generado en tiempo de compilación desde `../data/laureados.csv` y
`../laureados/*/web/ficha.md`. No edites `content/` ni `dist/` a mano.

```bash
npm ci
npm run build
npm run serve
```

El resultado se escribe en `dist/` y funciona tanto en la raíz de un dominio
como bajo la subruta de GitHub Pages. Las fichas ausentes se presentan como
entradas “en preparación” a partir del catálogo, por lo que el sitio se puede
publicar durante el avance del proyecto.

## Abrir con doble clic en Windows

Ejecuta `ver_web.bat`. El archivo instala las dependencias cuando sea necesario,
genera el sitio, abre `http://localhost:4173/` en el navegador y mantiene el
servidor activo. Para detenerlo, vuelve a la ventana del lanzador y pulsa
`Ctrl+C`.

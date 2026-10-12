# Pendientes para la publicación pública de la web

Este documento reúne mejoras que se realizarán **después de completar el catálogo, las fichas, las referencias, las replicaciones y las aplicaciones de los laureados pendientes**. No bloquea el avance académico actual.

## Objetivo de publicación

Publicar el proyecto como sitio estático distribuido por Netlify, preferentemente en:

```text
https://nobel.arturochian.com/
```

La VPS con Hermes se utilizará para mantener, validar y actualizar el repositorio. Netlify construirá y distribuirá la web después de cada cambio aprobado y enviado a la rama `main`.

```text
Hermes en la VPS -> GitHub -> Netlify -> visitantes
```

## Condición para iniciar estos trabajos

- [ ] Catálogo maestro completo desde 1969 hasta el último premio publicado.
- [ ] Todas las fichas previstas creadas o marcadas explícitamente como pendientes.
- [ ] Referencias y estados de replicación revisados.
- [ ] Figuras finales disponibles y correctamente nombradas.
- [ ] Aplicaciones Shiny terminadas o con una decisión de publicación documentada.
- [ ] Revisión docente del contenido completada.

## Prioridad 1 — Integración con `arturochian.com`

### Tarjeta del proyecto

- [ ] Añadir una tarjeta en `https://arturochian.com/projects/`.
- [ ] Utilizar como título: **Nobel de Economía: ideas, evidencia y replicación**.
- [ ] Utilizar una descripción equivalente a:

  > Archivo educativo en español que explica cómo los Premios Nobel transformaron la economía, con referencias verificadas, replicaciones reproducibles en R y aplicaciones interactivas.

- [ ] Añadir etiquetas: `Economía`, `Ciencia abierta`, `R` y `Docencia`.
- [ ] Añadir el llamado a la acción **Explorar el archivo**.
- [ ] Crear una imagen destacada propia, legible en modo claro y oscuro.
- [ ] Enlazar la tarjeta con `https://nobel.arturochian.com/`.

### Identidad compartida

- [ ] Incluir en la web Nobel el texto **Un proyecto educativo de Arturo Chian**.
- [ ] Añadir un enlace visible de regreso a `https://arturochian.com/projects/`.
- [ ] Añadir enlaces al repositorio, metodología, licencia y forma de citar.
- [ ] Mantener una paleta compatible con el verde esmeralda del sitio principal.
- [ ] Conservar la identidad editorial propia del proyecto Nobel.

## Prioridad 2 — Transparencia y estado del proyecto

- [ ] Mostrar en la portada el número de fichas disponibles frente al total de premios.
- [ ] Añadir un indicador de cobertura por década.
- [ ] Diferenciar visualmente `completo`, `web`, `replicado`, `referencias` y `pendiente`.
- [ ] Mostrar la fecha de la última actualización del catálogo.
- [ ] Evitar expresiones que sugieran cobertura completa mientras existan años pendientes.
- [ ] Añadir una página o bloque de novedades con las últimas fichas terminadas.

## Prioridad 3 — SEO y presentación al compartir

- [ ] Configurar la URL canónica `https://nobel.arturochian.com/`.
- [ ] Generar título y descripción únicos para cada ficha.
- [ ] Añadir metadatos Open Graph y Twitter Card.
- [ ] Crear una imagen Open Graph general y, si es viable, una por ficha.
- [ ] Generar `sitemap.xml`.
- [ ] Crear `robots.txt`.
- [ ] Añadir datos estructurados Schema.org de tipo `WebSite`, `Article` o `LearningResource`.
- [ ] Crear favicon e iconos para dispositivos móviles.
- [ ] Corregir en `arturochian.com` las URL canónicas que todavía apunten al subdominio de despliegue de Netlify.
- [ ] Verificar cómo se presenta el enlace en WhatsApp, LinkedIn y X.

## Prioridad 4 — Netlify y dominio

- [ ] Crear un proyecto Netlify independiente para `Nobel_economics`.
- [ ] Conectar el repositorio GitHub y la rama `main`.
- [ ] Configurar los siguientes valores:

  | Ajuste | Valor |
  |---|---|
  | Base directory | `web` |
  | Build command | `npm run build` |
  | Publish directory | `dist` |
  | Node.js | `22` |

- [ ] Añadir `nobel.arturochian.com` como dominio personalizado.
- [ ] Crear el registro DNS indicado por Netlify.
- [ ] Confirmar HTTPS y renovación automática del certificado.
- [ ] Configurar notificaciones de despliegue exitoso y fallido.
- [ ] Añadir encabezados de seguridad y políticas de caché para activos estáticos.
- [ ] Mantener `web/dist/` fuera de Git; Netlify debe generarlo durante el build.
- [ ] Desactivar `.github/workflows/deploy-web.yml` si GitHub Pages deja de utilizarse.
- [ ] Documentar el procedimiento de reversión a un despliegue anterior.

## Prioridad 5 — Rendimiento y figuras

- [ ] Conservar los PNG originales como archivos descargables.
- [ ] Generar miniaturas WebP o AVIF para la navegación y las fichas.
- [ ] Añadir dimensiones `width` y `height` a las imágenes para evitar saltos de diseño.
- [ ] Usar carga diferida para imágenes fuera de pantalla.
- [ ] Eliminar salidas gráficas duplicadas.
- [ ] Normalizar los nombres con prefijo `fig_`.
- [ ] Medir Lighthouse en móvil y escritorio.
- [ ] Alcanzar puntuación mínima de 90 en rendimiento, accesibilidad, buenas prácticas y SEO.

## Prioridad 6 — Aplicaciones interactivas

- [ ] Exportar las apps compatibles mediante Shinylive.
- [ ] Guardar los resultados generados en `web/public/apps/` únicamente mediante el proceso automatizado.
- [ ] Verificar funcionamiento sin backend y sin claves API.
- [ ] Para apps incompatibles con webR, desplegar Shiny Server en la VPS.
- [ ] Enlazar las apps alojadas en la VPS mediante HTTPS y un dominio o ruta estable.
- [ ] Comprobar que los valores iniciales reproducen las figuras de la replicación.
- [ ] Añadir texto alternativo, etiquetas accesibles y ayuda breve.
- [ ] Medir el tiempo de respuesta de cada interacción.

## Prioridad 7 — Experiencia educativa

- [ ] Crear una página **Empieza aquí** para estudiantes.
- [ ] Añadir recorridos temáticos, por ejemplo:
  - Finanzas y precios de activos.
  - Causalidad y evaluación de políticas.
  - Macroeconomía y política monetaria.
  - Desarrollo e instituciones.
  - Teoría de juegos y diseño de mercados.
  - Economía del comportamiento.
- [ ] Incorporar un glosario emergente conectado con `data/glosario.csv`.
- [ ] Añadir enlaces para descargar ejercicios y materiales de clase.
- [ ] Añadir una guía breve para docentes en cada recorrido.
- [ ] Evaluar una portada resumida en inglés, manteniendo las fichas principales en español.
- [ ] Añadir RSS o un registro de nuevas fichas publicadas.

## Prioridad 8 — Analítica y privacidad

- [ ] Integrar Simple Analytics, coherente con `arturochian.com`.
- [ ] Medir únicamente eventos útiles y no invasivos:
  - apertura de ficha;
  - búsqueda;
  - uso de filtros;
  - clic en replicación;
  - apertura de aplicación;
  - descarga de material;
  - regreso al portafolio principal.
- [ ] No enviar contenido de búsquedas, datos personales ni identificadores académicos.
- [ ] Documentar la analítica utilizada en la página Acerca de.

## Prioridad 9 — Calidad previa al lanzamiento

- [ ] Ejecutar `npm ci`, `npm run lint`, `npm test` y `npm run build`.
- [ ] Revisar todos los enlaces internos y externos.
- [ ] Confirmar que no existen enlaces `file:///`.
- [ ] Verificar fórmulas, figuras y referencias en una muestra de todas las décadas.
- [ ] Probar la navegación con teclado y lector de pantalla.
- [ ] Revisar contraste WCAG AA en ambos modos de color.
- [ ] Probar en móvil, tableta y escritorio.
- [ ] Comprobar páginas de error y rutas inexistentes.
- [ ] Ejecutar una revisión humana final del docente.
- [ ] Publicar primero mediante un deploy de prueba de Netlify.
- [ ] Asociar el dominio solo después de aprobar el deploy de prueba.

## Automatización futura con Hermes

- [ ] Crear en `VPS_HERMES` una skill denominada `nobel-economics-web`.
- [ ] Limitarla a `/home/ubuntu/Nobel_economics`.
- [ ] Hacer que sincronice mediante `git pull --ff-only` antes de trabajar.
- [ ] Exigir `npm test` y `npm run build` antes de proponer una publicación.
- [ ] Mostrar resumen y diff antes de cualquier commit.
- [ ] Solicitar confirmación explícita antes de `git commit` y `git push`.
- [ ] No modificar DNS, Netlify ni dominios desde Hermes sin una orden expresa.
- [ ] Informar el commit publicado y el estado esperado del deploy de Netlify.

## Definición de publicación terminada

- [ ] `https://nobel.arturochian.com/` responde mediante HTTPS.
- [ ] La tarjeta del proyecto aparece en `https://arturochian.com/projects/`.
- [ ] La portada informa correctamente la cobertura y la fecha de actualización.
- [ ] Todas las fichas terminadas aparecen en búsqueda y filtros.
- [ ] No hay enlaces internos rotos ni contenido local accidental.
- [ ] SEO, Open Graph, sitemap y robots están configurados.
- [ ] Lighthouse alcanza al menos 90 en las cuatro categorías objetivo.
- [ ] La analítica respeta la privacidad documentada.
- [ ] El flujo Hermes -> GitHub -> Netlify está probado y documentado.
- [ ] Existe un procedimiento de reversión verificado.


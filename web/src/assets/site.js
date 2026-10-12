const root = document.documentElement;
const themeButton = document.querySelector(".theme-toggle");

themeButton?.addEventListener("click", () => {
  const current = root.dataset.theme;
  const next = current === "dark" ? "light" : current === "light" ? "auto" : "dark";
  root.dataset.theme = next;
  localStorage.setItem("theme", next);
  themeButton.title = `Modo de color: ${next}`;
});

const search = document.querySelector("#search");
const cards = [...document.querySelectorAll(".laureate-card")];
const controls = ["area-filter", "decade-filter", "tag-filter", "state-filter", "app-filter"]
  .map((id) => document.getElementById(id)).filter(Boolean);

if (cards.length) {
  const scriptUrl = new URL(document.currentScript.src);
  const indexUrl = new URL("../search-index.json", scriptUrl);
  fetch(indexUrl).then((response) => response.ok ? response.json() : [])
    .then((items) => {
      const content = new Map(items.map((item) => [item.url.split("/").filter(Boolean).at(-1), item.text]));
      for (const card of cards) {
        const slug = card.querySelector("a")?.href.split("/").filter(Boolean).at(-1);
        card.dataset.search += ` ${content.get(slug) || ""}`;
      }
      applyFilters();
    }).catch(() => {});
}

function normalize(value) {
  return String(value || "").normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase().trim();
}

function applyFilters() {
  const query = normalize(search?.value);
  const area = document.getElementById("area-filter")?.value || "";
  const decade = document.getElementById("decade-filter")?.value || "";
  const tag = document.getElementById("tag-filter")?.value || "";
  const state = document.getElementById("state-filter")?.value || "";
  const app = document.getElementById("app-filter")?.checked;
  let visible = 0;

  for (const card of cards) {
    const matches = (!query || normalize(card.dataset.search).includes(query))
      && (!area || card.dataset.area.split("|").includes(area))
      && (!decade || card.dataset.decade === decade)
      && (!tag || card.dataset.tags.split("|").includes(tag))
      && (!state || card.dataset.state === state)
      && (!app || card.dataset.app === "true");
    card.hidden = !matches;
    if (matches) visible += 1;
  }
  const count = document.getElementById("result-count");
  if (count) count.textContent = `${visible} ${visible === 1 ? "resultado" : "resultados"}`;
  const empty = document.getElementById("empty-results");
  if (empty) empty.hidden = visible !== 0;
}

search?.addEventListener("input", applyFilters);
for (const control of controls) control.addEventListener("change", applyFilters);

const headings = [...document.querySelectorAll(".prose h2[id]")];
const tocLinks = [...document.querySelectorAll(".toc a")];
if (headings.length && "IntersectionObserver" in window) {
  const observer = new IntersectionObserver((records) => {
    const active = records.filter((record) => record.isIntersecting).at(-1);
    if (!active) return;
    for (const link of tocLinks) link.classList.toggle("active", link.hash === `#${active.target.id}`);
  }, { rootMargin: "-18% 0px -70%", threshold: 0 });
  headings.forEach((heading) => observer.observe(heading));
}

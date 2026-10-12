# ==============================================================================
# Script: crimen_capital_humano_y_familia.R
# Autor: Proyecto Nobel_economics
# Descripción: Replicación y simulación de los modelos fundamentales de Gary S. Becker
#              (Premio Nobel de Economía 1992):
#              1. Modelo de Crimen y Castigo (Becker, 1968): Elección racional,
#                 probabilidad de arresto (p), severidad de la sanción (f) y costo social.
#              2. Teoría del Capital Humano (Becker, 1964): Perfiles edad-ingresos
#                 bajo formación general, específica y sin inversión.
# Salidas:
#   - salidas/fig_becker_crimen_disuasion.png
#   - salidas/fig_becker_capital_humano_perfiles.png
#   - salidas/tab_resultados_becker.csv
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(tibble)
})

# Fijar semilla para reproducibilidad exacta
set.seed(1992)

# Determinar directorio base de ejecución
# Si se ejecuta desde laureados/1992_becker/ o desde la raíz del repositorio
dir_actual <- getwd()
if (grepl("1992_becker$", dir_actual)) {
  dir_salidas <- file.path("replicacion", "salidas")
} else if (file.exists(file.path("laureados", "1992_becker"))) {
  dir_salidas <- file.path("laureados", "1992_becker", "replicacion", "salidas")
} else {
  dir_salidas <- file.path("salidas")
}

if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

# ==============================================================================
# 1. MODELO DE ECONOMÍA DEL CRIMEN Y CASTIGO (Becker, 1968)
# ==============================================================================
# Un individuo comete delitos O si la utilidad esperada del delito supera
# su salario honesto en el mercado w_h.
# Utilidad esperada: EU = (1 - p) * U(w_c) + p * U(w_c - f)
# Función de oferta agregada de delitos:
# O(p, f) = A * p^(-alpha) * f^(-beta), con alpha, beta > 0.
# Becker postuló que si los delincuentes son amantes del riesgo en el margen,
# alpha > beta (más sensibles a la probabilidad de captura p que a la severidad f).
#
# Daño social neto: D(O) = d1 * O + 0.5 * d2 * O^2
# Costo de aprehensión y justicia: C(p, O) = c1 * p * O + c2 * p^2
# Costo social de las sanciones: B(p, f, O) = b * p * f * O (b=0 multas, b>0 prisión)
# Pérdida social total: L(p, f) = D(O) + C(p, O) + B(p, f, O)
# ==============================================================================

# Parámetros del modelo
A_crimen  <- 1000
alpha_p   <- 0.85   # Elasticidad respecto a probabilidad de captura
beta_f    <- 0.55   # Elasticidad respecto a severidad de la sanción (amantes del riesgo: alpha > beta)
d1        <- 5
d2        <- 0.05
c1        <- 8
c2        <- 2500
b_prision <- 0.20   # Costo social del castigo por unidad (costo penitenciario)

# Malla de combinaciones de política pública (p, f)
grid_p <- seq(0.05, 0.70, length.out = 80)
grid_f <- seq(10, 100, length.out = 80)

grid_crimen <- expand.grid(p = grid_p, f = grid_f) %>%
  mutate(
    # Delitos esperados
    delitos_O = A_crimen * (p^(-alpha_p)) * (f^(-beta_f)),
    # Componentes de costo social
    danio_D   = d1 * delitos_O + 0.5 * d2 * (delitos_O^2),
    costo_C   = c1 * p * delitos_O + c2 * (p^2),
    costo_B   = b_prision * p * f * delitos_O,
    costo_L   = danio_D + costo_C + costo_B
  )

# Encontrar la política óptima que minimiza la pérdida social L(p, f)
optimo_idx <- which.min(grid_crimen$costo_L)
optimo_politica <- grid_crimen[optimo_idx, ]

# Generar gráfico de disuasión y curvas de costo social
fig_crimen <- ggplot(grid_crimen, aes(x = p, y = f)) +
  geom_contour_filled(aes(z = delitos_O), breaks = c(0, 1500, 2500, 4000, 6500, 10000, 18000), alpha = 0.85) +
  scale_fill_viridis_d(option = "rocket", direction = -1, name = "Delitos esperados\nO(p, f)") +
  geom_contour(aes(z = costo_L), color = "cyan3", linetype = "dashed", linewidth = 0.6) +
  geom_point(data = optimo_politica, aes(x = p, y = f), color = "gold", size = 4, shape = 18) +
  annotate("text", x = optimo_politica$p + 0.03, y = optimo_politica$f - 4,
           label = paste0("Óptimo de Becker\n(p* = ", round(optimo_politica$p, 2),
                          ", f* = ", round(optimo_politica$f, 1), ")"),
           color = "white", fontface = "bold", size = 3.5, hjust = 0) +
  labs(
    title = "Modelo de Crimen y Castigo de Becker (1968): Disuasión y Política Óptima",
    subtitle = "Zonas de volumen de delitos esperados O(p, f) y líneas punteadas de pérdida social L(p, f)",
    x = "Probabilidad de aprehensión y condena (p)",
    y = "Severidad de la sanción / Castigo (f)",
    caption = "Fuente: Nobel_economics basado en Becker (1968). Nota: El óptimo minimiza el costo social L(p, f) = D(O) + C(p, O) + b*p*f*O."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "gray30", size = 9.5),
    legend.position = "right",
    panel.grid.minor = element_blank()
  )

ruta_fig_crimen <- file.path(dir_salidas, "fig_becker_crimen_disuasion.png")
ggsave(ruta_fig_crimen, plot = fig_crimen, width = 8, height = 5.2, dpi = 300)
message("Figura guardada: ", ruta_fig_crimen)

# ==============================================================================
# 2. TEORÍA DEL CAPITAL HUMANO: PERFILES EDAD-INGRESOS (Becker, 1964)
# ==============================================================================
# Becker distingue entre:
# 1. Sin inversión (mano de obra sin calificación formal):
#    Ingreso plano o con leve crecimiento por experiencia no estructurada.
# 2. Capital humano general:
#    El trabajador financia íntegramente la formación aceptando un salario neto menor
#    al inicio (w_t = MP_t - C_entrenamiento). Al ser transferible, tras formarse
#    recibe el valor íntegro de su mayor productividad en cualquier empresa,
#    resultando en un perfil marcadamente cóncavo y ascendente.
# 3. Capital humano específico de la empresa:
#    La formación solo tiene valor en la firma actual. Empresa y trabajador
#    comparten costos y retornos para mitigar riesgos de renuncia o despido.
#    El salario inicial es intermedio y la trayectoria madura comparte las rentas.
# ==============================================================================

edades <- 18:65

simular_perfiles <- function() {
  datos_lista <- list()
  
  for (edad in edades) {
    t <- edad - 18 # años desde inicio de vida laboral activa
    
    # Perfil 1: Sin inversión en capital humano
    w_no_inv <- 18000 + 180 * t - 2.5 * (t^2)
    
    # Perfil 2: Capital humano general (inversión intensiva en edades 18-24)
    # Reducción inicial de salario por pago implícito de capacitación
    costo_formacion_gen <- if (edad <= 23) 11000 - 900 * (edad - 18) else 0
    prod_marginal_gen   <- 18000 + 1750 * t - 26 * (t^2)
    w_general           <- prod_marginal_gen - costo_formacion_gen
    
    # Perfil 3: Capital humano específico (costos compartidos 50-50 entre firma y empleado)
    costo_formacion_esp <- if (edad <= 23) 5500 - 450 * (edad - 18) else 0
    # En la etapa post-formación, la firma paga el salario alternativo más una fracción del retorno específico
    prod_marginal_esp   <- 18000 + 1300 * t - 19 * (t^2)
    renta_especifica    <- (prod_marginal_esp - w_no_inv) * 0.55
    w_especifico        <- ifelse(edad <= 23, prod_marginal_esp - costo_formacion_esp, w_no_inv + renta_especifica)
    
    datos_lista[[length(datos_lista) + 1]] <- tibble(
      edad = edad,
      sin_inversion = round(w_no_inv, 1),
      formacion_general = round(w_general, 1),
      formacion_especifica = round(w_especifico, 1)
    )
  }
  
  bind_rows(datos_lista)
}

df_perfiles <- simular_perfiles()

df_perfiles_long <- df_perfiles %>%
  pivot_longer(cols = -edad, names_to = "tipo_inversion", values_to = "ingreso_anual") %>%
  mutate(
    tipo_inversion_label = factor(
      tipo_inversion,
      levels = c("sin_inversion", "formacion_especifica", "formacion_general"),
      labels = c("Sin inversión (no calificado)",
                 "Formación específica (costos y rentas compartidas)",
                 "Formación general (inversión financiada por trabajador)")
    )
  )

fig_perfiles <- ggplot(df_perfiles_long, aes(x = edad, y = ingreso_anual, color = tipo_inversion_label)) +
  geom_line(linewidth = 1.2) +
  scale_color_manual(
    name = "Régimen de Capital Humano",
    values = c("Sin inversión (no calificado)" = "#7f7f7f",
               "Formación específica (costos y rentas compartidas)" = "#2b8cbe",
               "Formación general (inversión financiada por trabajador)" = "#d95f02")
  ) +
  scale_y_continuous(labels = scales::dollar_format(prefix = "$", big.mark = ",")) +
  scale_x_continuous(breaks = seq(20, 65, by = 5)) +
  # Anotaciones explicativas de la dinámica de Becker
  annotate("rect", xmin = 18, xmax = 24, ymin = 5000, ymax = 35000, alpha = 0.12, fill = "orange") +
  annotate("text", x = 21, y = 8000, label = "Período de inversión\n(salario sacrificado)", size = 3, fontface = "italic") +
  annotate("text", x = 28, y = 29000, label = "Edad de cruce\n(crossover age ~24)", size = 3, fontface = "bold", color = "#d95f02") +
  annotate("text", x = 50, y = 51000, label = "Pico de productividad madura\ny depreciación por edad", size = 3, fontface = "italic") +
  labs(
    title = "Teoría del Capital Humano de Becker (1964): Perfiles Edad-Ingresos",
    subtitle = "Divergencia entre formación general y formación específica a lo largo del ciclo vital",
    x = "Edad cronológica (años)",
    y = "Ingreso laboral anual (USD constantes)",
    caption = "Fuente: Nobel_economics basado en Becker (1964). Formación general genera perfiles marcadamente cóncavos."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(color = "gray30", size = 9.5),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    legend.box = "horizontal",
    panel.grid.minor = element_blank()
  ) +
  guides(color = guide_legend(nrow = 2))

ruta_fig_perfiles <- file.path(dir_salidas, "fig_becker_capital_humano_perfiles.png")
ggsave(ruta_fig_perfiles, plot = fig_perfiles, width = 8.5, height = 5.5, dpi = 300)
message("Figura guardada: ", ruta_fig_perfiles)

# ==============================================================================
# 3. TABLA CONSOLIDADA DE RESULTADOS
# ==============================================================================
# Resumen de métricas comparativas del modelo penal y de capital humano

# Puntos clave del ciclo de vida de capital humano
hitos_edad <- c(20, 25, 35, 45, 55, 65)
tab_capital_humano <- df_perfiles %>%
  filter(edad %in% hitos_edad) %>%
  mutate(
    premio_general_vs_noinv = formacion_general - sin_inversion,
    premio_especifico_vs_noinv = formacion_especifica - sin_inversion
  )

# Resumen de políticas de control del crimen
politicas_crimen <- tibble(
  politica = c("Baja probabilidad / Alta pena", "Probabilidad media / Pena media",
               "Alta probabilidad / Baja pena", "Óptimo de costo social (Becker)"),
  p = c(0.10, 0.30, 0.60, round(optimo_politica$p, 3)),
  f = c(90.0, 50.0, 20.0, round(optimo_politica$f, 1))
) %>%
  mutate(
    delitos_O = round(A_crimen * (p^(-alpha_p)) * (f^(-beta_f)), 1),
    costo_social_L = round(
      d1 * delitos_O + 0.5 * d2 * (delitos_O^2) +
      c1 * p * delitos_O + c2 * (p^2) +
      b_prision * p * f * delitos_O, 1
    )
  )

# Guardar tabla consolidada
ruta_tab <- file.path(dir_salidas, "tab_resultados_becker.csv")
write.csv(politicas_crimen, ruta_tab, row.names = FALSE)
message("Tabla guardada: ", ruta_tab)

message("Replicación de Becker (1992) completada con éxito.")

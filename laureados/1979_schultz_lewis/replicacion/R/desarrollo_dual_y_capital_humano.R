# ==============================================================================
# Script: desarrollo_dual_y_capital_humano.R
# Tema: Premio Nobel de Economia 1979 - Theodore W. Schultz y Sir Arthur Lewis
# Proposito: Simulacion cuantitativa y visualizacion cientifica del Modelo Dual de
#            Arthur Lewis (1954) y la Teoria de la Modernizacion Agricola y Capital
#            Humano de Theodore Schultz (1964, 1975).
# ==============================================================================

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(readr)
  library(tibble)
  library(patchwork)
})

# Fijar semilla para estricta reproducibilidad
set.seed(19791016)

# Definir rutas de guardado
dir_salidas <- file.path("laureados", "1979_schultz_lewis", "replicacion", "salidas")
if (!dir.exists(dir_salidas)) {
  dir.create(dir_salidas, recursive = TRUE)
}

# ------------------------------------------------------------------------------
# PARTE 1: MODELO DE DESARROLLO DUAL DE W. ARTHUR LEWIS (1954)
# ------------------------------------------------------------------------------
# La economia posee dos sectores:
# 1. Sector Tradicional/Agricola: dotacion de trabajo LA. Con abundancia laboral,
#    el producto marginal MPL_A es muy bajo. El salario rural esta anclado al nivel
#    de subsistencia w_sub institucional.
# 2. Sector Moderno/Industrial: intensivo en capital K y trabajo LM. Demanda
#    trabajo hasta que MPL_M = w_M.
#    El salario industrial ofrece una prima urbana mu: w_M = (1 + mu) * w_A.
# 3. Punto de Inflexion de Lewis (Lewis Turning Point - LTP):
#    Cuando el excedente laboral se absorbe, MPL_A supera w_sub, y los salarios
#    reales rurales e industriales se disparan.

cat(">>> Simulando Dinamica de Transicion del Modelo Dual de Lewis (1954)...\n")

# Parametros estructurales
L_total     <- 1000      # Fuerza laboral total de la economia
A_A         <- 25        # Productividad sector tradicional
alpha_A     <- 0.50      # Elasticidad trabajo en agricultura
w_sub       <- 1.0       # Salario de subsistencia institucional
mu_urbana   <- 0.35      # Prima salarial urbana (35%)

A_M         <- 1.80      # Productividad total factores en industria
beta_M      <- 0.40      # Elasticidad del capital en manufactura (1-beta = 0.60 para trabajo)
delta       <- 0.05      # Tasa de depreciacion del capital
s_pi        <- 0.28      # Tasa de reinversion del excedente capitalista

T_periodos  <- 45        # Horizontes temporales
K_0         <- 140       # Stock de capital industrial inicial

# Vectores de almacenamiento
t_vec    <- 1:T_periodos
K_vec    <- numeric(T_periodos)
LM_vec   <- numeric(T_periodos)
LA_vec   <- numeric(T_periodos)
wA_vec   <- numeric(T_periodos)
wM_vec   <- numeric(T_periodos)
MPLA_vec <- numeric(T_periodos)
YM_vec   <- numeric(T_periodos)
YA_vec   <- numeric(T_periodos)
Pi_vec   <- numeric(T_periodos)
Fase_vec <- character(T_periodos)

# Inicializacion
K_actual <- K_0

for (t in 1:T_periodos) {
  K_vec[t] <- K_actual
  
  # Resolver asignacion de equilibrio de mano de obra en el periodo t
  # Demanda de trabajo industrial como funcion de wM:
  # MPL_M = (1 - beta_M) * A_M * (K / LM)^beta_M = w_M
  # => LM = K * (( (1 - beta_M) * A_M ) / w_M )^(1 / beta_M)
  
  # Funcion para hallar LM tal que w_M(LM) iguale la oferta de mano de obra
  # donde w_A(LA) = max(w_sub, alpha_A * A_A * LA^(alpha_A - 1))
  # y w_M = (1 + mu_urbana) * w_A
  
  f_equilibrio <- function(LM_cand) {
    LM_cand <- max(1, min(LM_cand, L_total - 1))
    LA_cand <- L_total - LM_cand
    mpla_cand <- alpha_A * A_A * (LA_cand)^(alpha_A - 1)
    wa_cand   <- max(w_sub, mpla_cand)
    wm_cand   <- (1 + mu_urbana) * wa_cand
    
    # Demanda de trabajo industrial con este salario
    lm_demanda <- K_actual * (((1 - beta_M) * A_M) / wm_cand)^(1 / beta_M)
    return(lm_demanda - LM_cand)
  }
  
  # Busqueda de raiz en (1, L_total - 1)
  sol <- uniroot(f_equilibrio, lower = 1, upper = L_total - 1)
  LM_eq <- sol$root
  LA_eq <- L_total - LM_eq
  
  # Calcular variables del equilibrio en t
  mpla_eq <- alpha_A * A_A * (LA_eq)^(alpha_A - 1)
  wa_eq   <- max(w_sub, mpla_eq)
  wm_eq   <- (1 + mu_urbana) * wa_eq
  
  ym_eq   <- A_M * (K_actual^beta_M) * (LM_eq^(1 - beta_M))
  ya_eq   <- A_A * (LA_eq^alpha_A)
  pi_eq   <- ym_eq - wm_eq * LM_eq
  
  # Guardar
  LM_vec[t]   <- LM_eq
  LA_vec[t]   <- LA_eq
  wA_vec[t]   <- wa_eq
  wM_vec[t]   <- wm_eq
  MPLA_vec[t] <- mpla_eq
  YM_vec[t]   <- ym_eq
  YA_vec[t]   <- ya_eq
  Pi_vec[t]   <- pi_eq
  Fase_vec[t] <- ifelse(mpla_eq <= w_sub, "Fase I: Excedente Laboral", "Fase II: Post-Inflexion Lewis")
  
  # Dinamica del capital para el siguiente periodo: K_{t+1} = (1 - delta) * K_t + s_pi * Pi_t
  K_actual <- (1 - delta) * K_actual + s_pi * pi_eq
}

df_lewis <- tibble(
  periodo       = t_vec,
  capital       = K_vec,
  empleo_ind    = LM_vec,
  empleo_agr    = LA_vec,
  salario_rural = wA_vec,
  salario_urbano= wM_vec,
  mpla          = MPLA_vec,
  pib_industrial= YM_vec,
  pib_agricola  = YA_vec,
  beneficios    = Pi_vec,
  fase          = Fase_vec,
  share_ind_emp = LM_vec / L_total,
  share_pi_ym   = Pi_vec / YM_vec
)

# Identificar periodo del punto de inflexion de Lewis
t_inflexion <- min(df_lewis$periodo[df_lewis$fase == "Fase II: Post-Inflexion Lewis"])
cat(sprintf("-> Punto de Inflexion de Lewis (LTP) alcanzado en el periodo: t = %d\n", t_inflexion))

# ------------------------------------------------------------------------------
# PARTE 2: TEORIA DEL CAPITAL HUMANO Y AGRICULTURA DE SCHULTZ (1964, 1975)
# ------------------------------------------------------------------------------
cat(">>> Simulando Modelo de Schultz: Pobres pero Eficientes y Capital Humano...\n")

# 1. Rendimientos marginales del capital tradicional vs moderno (Schultz 1964)
k_rango <- seq(5, 100, length.out = 100)

# Capital tradicional: rendimientos fuertemente decrecientes
# Y_trad = 15 * K_trad^0.15 => MPK_trad = 2.25 * K_trad^(-0.85)
mpk_tradicional <- 2.25 * (k_rango)^(-0.85)

# Capital moderno con tecnologia avanzada y capital humano complementario
# Y_mod = 12 * K_mod^0.45 => MPK_mod = 5.4 * K_mod^(-0.55)
mpk_moderno     <- 5.40 * (k_rango)^(-0.55)

df_mpk <- tibble(
  capital = rep(k_rango, 2),
  mpk     = c(mpk_tradicional, mpk_moderno),
  tipo    = rep(c("Insumo Tradicional (Schultz 1964)", "Insumo Tecnologico Moderno"), each = length(k_rango))
)

# 2. Adopcion de nuevas tecnologias segun nivel de escolaridad (Schultz 1975)
# "The Value of the Ability to Deal with Disequilibria"
escolaridad <- seq(0, 14, by = 0.2) # Anos de educacion formal del campesino

# Tasa de adopcion de semillas de alto rendimiento (HYV) / tecnicas modernas: funcion logistica
tasa_adopcion <- 1 / (1 + exp(-0.75 * (escolaridad - 4.5)))

# Productividad agricola (ingreso neto por hectarea en miles de USD)
# Entorno estatico (tecnologia tradicional inmutable): retorno a la educacion casi plano (2% anual)
ingreso_estatico <- 1.5 * exp(0.02 * escolaridad)

# Entorno dinamico (Revolucion Verde / nuevas tecnologias): retorno schultziano alto (9.5% anual)
ingreso_dinamico <- 1.5 * (1 + 1.2 * tasa_adopcion) * exp(0.045 * escolaridad)

df_schultz_educ <- tibble(
  escolaridad      = escolaridad,
  tasa_adopcion    = tasa_adopcion * 100,
  ingreso_estatico = ingreso_estatico,
  ingreso_dinamico = ingreso_dinamico
)

# ------------------------------------------------------------------------------
# GENERACION DE FIGURAS CIENTIFICAS (GGPLOT2 + PATCHWORK)
# ------------------------------------------------------------------------------

tema_academico <- theme_minimal(base_family = "sans", base_size = 11) +
  theme(
    plot.title         = element_text(face = "bold", size = 12, color = "#1a252f"),
    plot.subtitle      = element_text(size = 9.5, color = "#4a5568", margin = margin(b = 6)),
    axis.title         = element_text(face = "bold", size = 10, color = "#2d3748"),
    axis.text          = element_text(color = "#4a5568"),
    panel.grid.minor   = element_blank(),
    panel.grid.major   = element_line(color = "#e2e8f0", linewidth = 0.5),
    legend.position    = "bottom",
    legend.title       = element_text(face = "bold", size = 9),
    legend.text        = element_text(size = 8.5),
    strip.text         = element_text(face = "bold", color = "#1a202c")
  )

# --- FIGURA 1: MODELO DUAL DE ARTHUR LEWIS ---
p1_emp <- ggplot(df_lewis, aes(x = periodo)) +
  geom_line(aes(y = empleo_ind, color = "Industria (LM)"), linewidth = 1.1) +
  geom_line(aes(y = empleo_agr, color = "Agricultura (LA)"), linewidth = 1.1) +
  geom_vline(xintercept = t_inflexion, linetype = "dashed", color = "#e53e3e", linewidth = 0.9) +
  annotate("text", x = t_inflexion + 1.5, y = 800, label = paste("Punto Inflexion Lewis\n(t =", t_inflexion, ")"),
           color = "#e53e3e", fontface = "bold", size = 3.2, hjust = 0) +
  scale_color_manual(values = c("Industria (LM)" = "#2b6cb0", "Agricultura (LA)" = "#38a169")) +
  labs(
    title = "A. Asignacion del Empleo Intersectorial",
    x = "Periodo (t)", y = "Trabajadores", color = "Sector:"
  ) +
  tema_academico

p1_sal <- ggplot(df_lewis, aes(x = periodo)) +
  geom_line(aes(y = salario_urbano, color = "Salario Urbano Moderno (w_M)"), linewidth = 1.1) +
  geom_line(aes(y = salario_rural, color = "Salario Rural (w_A)"), linewidth = 1.1) +
  geom_line(aes(y = mpla, color = "Prod. Marginal Agricola (MPLA)"), linetype = "dotted", linewidth = 1.0) +
  geom_vline(xintercept = t_inflexion, linetype = "dashed", color = "#e53e3e", linewidth = 0.9) +
  scale_color_manual(values = c(
    "Salario Urbano Moderno (w_M)" = "#3182ce",
    "Salario Rural (w_A)" = "#2f855a",
    "Prod. Marginal Agricola (MPLA)" = "#d69e2e"
  )) +
  labs(
    title = "B. Evolucion de Salarios y Despegue Salarial",
    x = "Periodo (t)", y = "Salario Real / MPL", color = "Variable:"
  ) +
  tema_academico

p1_cap <- ggplot(df_lewis, aes(x = periodo)) +
  geom_line(aes(y = capital, color = "Stock de Capital (K_t)"), linewidth = 1.1) +
  geom_line(aes(y = beneficios * 2, color = "Excedente/Beneficios (x2)"), linewidth = 1.0, linetype = "longdash") +
  geom_vline(xintercept = t_inflexion, linetype = "dashed", color = "#e53e3e", linewidth = 0.9) +
  scale_color_manual(values = c("Stock de Capital (K_t)" = "#805ad5", "Excedente/Beneficios (x2)" = "#dd6b20")) +
  labs(
    title = "C. Acumulacion de Capital y Beneficios Capitalistas",
    x = "Periodo (t)", y = "Unidades de Capital / Beneficios", color = "Indicador:"
  ) +
  tema_academico

L_grid <- seq(50, 850, by = 10)
demanda_t5   <- (1 - beta_M) * A_M * (df_lewis$capital[5]^beta_M) * (L_grid^(-beta_M))
demanda_tLTP <- (1 - beta_M) * A_M * (df_lewis$capital[t_inflexion]^beta_M) * (L_grid^(-beta_M))
demanda_t40  <- (1 - beta_M) * A_M * (df_lewis$capital[40]^beta_M) * (L_grid^(-beta_M))

df_demanda <- tibble(
  L = rep(L_grid, 3),
  w = c(demanda_t5, demanda_tLTP, demanda_t40),
  Curva = factor(
    rep(c("Demanda t=5 (K inicial)", "Demanda t=Inflexion", "Demanda t=40 (K maduro)"), each = length(L_grid)),
    levels = c("Demanda t=5 (K inicial)", "Demanda t=Inflexion", "Demanda t=40 (K maduro)")
  )
)

p1_curv <- ggplot() +
  geom_line(data = df_demanda, aes(x = L, y = w, color = Curva), linewidth = 1.1) +
  geom_segment(aes(x = 0, xend = df_lewis$empleo_ind[t_inflexion],
                   y = (1 + mu_urbana) * w_sub, yend = (1 + mu_urbana) * w_sub),
               color = "#e53e3e", linewidth = 1.2) +
  geom_segment(aes(x = df_lewis$empleo_ind[t_inflexion], xend = 850,
                   y = (1 + mu_urbana) * w_sub, yend = df_lewis$salario_urbano[40]),
               color = "#e53e3e", linewidth = 1.2, linetype = "dotdash") +
  annotate("text", x = 120, y = 1.55, label = "Oferta Ilimitada de Trabajo\n(Salario Plano)",
           color = "#c53030", fontface = "bold", size = 3) +
  annotate("text", x = 650, y = 3.6, label = "Oferta Inelastica\n(Salario Creciente)",
           color = "#c53030", fontface = "bold", size = 3) +
  scale_color_manual(values = c(
    "Demanda t=5 (K inicial)" = "#718096",
    "Demanda t=Inflexion" = "#3182ce",
    "Demanda t=40 (K maduro)" = "#2c5282"
  )) +
  labs(
    title = "D. Diagrama Clasico de Lewis: Demanda y Oferta de Trabajo",
    x = "Empleo Industrial (LM)", y = "Salario Real Urbano (w_M)", color = "Curva:"
  ) +
  tema_academico

fig_lewis_completa <- (p1_emp + p1_sal) / (p1_cap + p1_curv) +
  plot_annotation(
    title = "El Modelo de Desarrollo Dual con Oferta Ilimitada de Mano de Obra (Lewis, 1954)",
    subtitle = "Simulacion del despegue industrial, reinversion de beneficios capitalistas y aparicion del Punto de Inflexion de Lewis",
    caption = "Fuente: Simulacion basada en Lewis (1954, The Manchester School). Script reproducible en R.",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14, color = "#1a252f"),
      plot.subtitle = element_text(size = 10.5, color = "#4a5568")
    )
  )

ruta_fig1 <- file.path(dir_salidas, "fig_lewis_desarrollo_dual.png")
ggsave(ruta_fig1, plot = fig_lewis_completa, width = 12, height = 9, dpi = 300)
cat(sprintf("-> Guardada figura de Lewis en: %s\n", ruta_fig1))

# --- FIGURA 2: TEORIA DE SCHULTZ SOBRE AGRICULTURA Y CAPITAL HUMANO ---
p2_mpk <- ggplot(df_mpk, aes(x = capital, y = mpk, color = tipo)) +
  geom_line(linewidth = 1.2) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "#718096") +
  annotate("text", x = 70, y = 0.8, label = "Coste de oportunidad de fondos",
           color = "#718096", size = 3.2, fontface = "italic") +
  scale_color_manual(values = c(
    "Insumo Tradicional (Schultz 1964)" = "#e53e3e",
    "Insumo Tecnologico Moderno" = "#2b6cb0"
  )) +
  labs(
    title = "A. Hipotesis 'Pobres pero Eficientes' (Schultz 1964)",
    subtitle = "El rendimiento de factores tradicionales tiende a cero; la modernizacion exige insumos no tradicionales",
    x = "Stock de Factor / Insumo Agricola", y = "Producto Marginal del Factor (MPK)", color = "Regimen:"
  ) +
  tema_academico

p2_adop <- ggplot(df_schultz_educ, aes(x = escolaridad, y = tasa_adopcion)) +
  geom_line(color = "#2f855a", linewidth = 1.2) +
  geom_point(color = "#22543d", size = 2) +
  geom_vline(xintercept = 4.5, linetype = "dotted", color = "#d69e2e", linewidth = 0.9) +
  annotate("text", x = 5.0, y = 30, label = "Umbral de Alfabetizacion\ny Educacion Basica (4.5 anos)",
           color = "#b7791f", fontface = "bold", size = 3.2, hjust = 0) +
  labs(
    title = "B. Tasa de Adopcion de Semillas Mejoradas y Nuevas Tecnicas",
    subtitle = "La escolaridad acelera el dominio del conocimiento tecnico en la Revolucion Verde",
    x = "Anos de Escolaridad del Agricultor", y = "% Adopcion de Tecnologia Moderna"
  ) +
  tema_academico

p2_prod <- ggplot(df_schultz_educ, aes(x = escolaridad)) +
  geom_line(aes(y = ingreso_estatico, color = "Entorno Tradicional Estatico"), linewidth = 1.1, linetype = "dashed") +
  geom_line(aes(y = ingreso_dinamico, color = "Entorno Dinamico con Cambio Tecnologico"), linewidth = 1.2) +
  scale_color_manual(values = c(
    "Entorno Tradicional Estatico" = "#718096",
    "Entorno Dinamico con Cambio Tecnologico" = "#2b6cb0"
  )) +
  labs(
    title = "C. Habilidad para Afrontar Desequilibrios (Schultz 1975)",
    subtitle = "El valor del capital humano se maximiza durante periodos de rapida transformacion tecnologica",
    x = "Anos de Escolaridad del Agricultor", y = "Ingreso Neto Agricola (Miles USD / ha)", color = "Ambiente:"
  ) +
  tema_academico

# Panel D: Descomposicion del Valor Agregado Agricola segun Capital Humano
df_barras <- tibble(
  Nivel_Educativo = factor(c("Sin Instruccion\n(0 anos)", "Primaria Basica\n(5 anos)", "Secundaria/Tecnica\n(10 anos)"),
                           levels = c("Sin Instruccion\n(0 anos)", "Primaria Basica\n(5 anos)", "Secundaria/Tecnica\n(10 anos)")),
  Tradicional = c(1.50, 1.65, 1.83),
  Adopcion_Tecnica = c(0.15, 0.95, 1.85),
  Eficiencia_Asignativa = c(0.05, 0.40, 1.15)
) %>%
  pivot_longer(cols = c("Tradicional", "Adopcion_Tecnica", "Eficiencia_Asignativa"),
               names_to = "Componente", values_to = "Ingreso")

df_barras$Componente <- factor(df_barras$Componente,
                               levels = c("Eficiencia_Asignativa", "Adopcion_Tecnica", "Tradicional"),
                               labels = c("Eficiencia en Desequilibrio (Schultz 1975)",
                                          "Adopcion Insumos Modernos (Schultz 1964)",
                                          "Base Tradicional de Subsistencia"))

p2_bar <- ggplot(df_barras, aes(x = Nivel_Educativo, y = Ingreso, fill = Componente)) +
  geom_bar(stat = "identity", width = 0.55) +
  scale_fill_manual(values = c(
    "Eficiencia en Desequilibrio (Schultz 1975)" = "#3182ce",
    "Adopcion Insumos Modernos (Schultz 1964)" = "#38a169",
    "Base Tradicional de Subsistencia" = "#a0aec0"
  )) +
  labs(
    title = "D. Descomposicion del Ingreso Finca segun Escolaridad",
    subtitle = "El capital humano desbloquea el potencial productivo de la investigacion cientifica",
    x = "Nivel Educativo del Productor", y = "Ingreso Estimado por Hectarea", fill = "Componente:"
  ) +
  tema_academico

fig_schultz_completa <- (p2_mpk + p2_adop) / (p2_prod + p2_bar) +
  plot_annotation(
    title = "Transformacion de la Agricultura Tradicional y Capital Humano (Schultz, 1964, 1975)",
    subtitle = "Rechazo del mito de la irracionalidad campesina e identificacion de la inversion en personas como motor de desarrollo",
    caption = "Fuente: Simulacion basada en Schultz (1964, Transforming Traditional Agriculture; 1975, JEL).",
    theme = theme(
      plot.title = element_text(face = "bold", size = 14, color = "#1a252f"),
      plot.subtitle = element_text(size = 10.5, color = "#4a5568")
    )
  )

ruta_fig2 <- file.path(dir_salidas, "fig_schultz_capital_humano_agricola.png")
ggsave(ruta_fig2, plot = fig_schultz_completa, width = 12, height = 9, dpi = 300)
cat(sprintf("-> Guardada figura de Schultz en: %s\n", ruta_fig2))

# ------------------------------------------------------------------------------
# PARTE 3: EXPORTACION DE TABLA DE RESULTADOS CONSOLIDADOS
# ------------------------------------------------------------------------------
cat(">>> Exportando metricas a tab_resultados_desarrollo_1979.csv...\n")

# Hitos temporales representativos del modelo de Lewis
hitos_t <- c(1, 10, t_inflexion, t_inflexion + 10, T_periodos)

tab_lewis_resumen <- df_lewis %>%
  filter(periodo %in% hitos_t) %>%
  mutate(
    periodo_etiqueta = case_when(
      periodo == 1 ~ "t = 1 (Estado Inicial / Excedente Laboral Masivo)",
      periodo == 10 ~ "t = 10 (Fase 1: Acumulacion Capitalista con Salario Fijo)",
      periodo == t_inflexion ~ sprintf("t = %d (Punto de Inflexion de Lewis / LTP)", t_inflexion),
      periodo == t_inflexion + 10 ~ sprintf("t = %d (Fase 2: Transicion Neoclasica y Salarios al Alza)", t_inflexion + 10),
      periodo == T_periodos ~ sprintf("t = %d (Economia Madura Integrada)", T_periodos)
    )
  ) %>%
  select(
    periodo,
    etiqueta = periodo_etiqueta,
    fase,
    capital,
    empleo_industrial = empleo_ind,
    empleo_agricola = empleo_agr,
    salario_rural,
    salario_urbano,
    mpla,
    pib_industrial,
    pib_agricola,
    beneficios_capitalistas = beneficios,
    participacion_empleo_ind = share_ind_emp
  )

ruta_tab <- file.path(dir_salidas, "tab_resultados_desarrollo_1979.csv")
write_csv(tab_lewis_resumen, ruta_tab)
cat(sprintf("-> Guardada tabla de resultados en: %s\n", ruta_tab))

cat("==============================================================================\n")
cat("EJECUCION COMPLETADA CON EXITO: Todas las figuras y tablas fueron generadas.\n")
cat("==============================================================================\n")

#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, arrow, openxlsx, writexl)

log_info("DEFINE DIRECTORY")

setwd("/Users/sebas/OneDrive/Documents/curso_r_cs/")

input_1 <- "input_data/economias_ilicitas/Datos-anónimos-encuesta-PNIS.xlsx"

output_1 <- "importar/sesion_3/output/usuarios_pnis_gp.xlsx"

log_info("LOAD DATA")
usuarios_pnis <- read.xlsx(input_1)

usuarios_g_p <- usuarios_pnis %>% 
  group_by(P93, P2) %>% 
  summarise(n_p = n()) %>% 
  ungroup()

rm(usuarios_pnis)

log_info("EXPORT")
write_xlsx(usuarios_g_p, output_1)

gc()

log_info("DONE replicar_resultados_pnis.R")

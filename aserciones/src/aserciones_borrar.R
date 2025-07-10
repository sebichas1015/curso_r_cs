#
# Authors:     SCB
# Maintainers: SCB
# =========================================
# 

pacman::p_load(argparse, here, dplyr, arrow, assertr, logger, openxlsx, janitor,
               sf)

log_info("load data")
path_munis <- "/Users/sebas/OneDrive/Documents/CEPAP/team_data/munis_col_2023/input/MGN2023_MPIO_POLITICO/MGN_ADM_MPIO_GRAFICO.shp"

path_lideres <- "/Users/sebas/OneDrive/Documents/curso_r_cs/input_data/violencia/Base-de-datos-líderes-asesinados_2021.xlsx"

munis <- st_read(path_munis)

lideres <- read.xlsx(path_lideres)

log_info("clean names")
munis <- munis %>% 
  clean_names()

lideres <- lideres %>% 
  clean_names()

log_info("select")
munis <- munis %>% 
  select(-dpto_ccdgo, -dpto_cnmbr)

log_info("verify dptos")
lideres <- lideres %>% 
  verify(length(unique(departamento)) == 33)

log_info("verify id")
lideres <- lideres %>% 
  assert(not_na, id)

log_info("month")
lideres %>% 
  mutate(mes = as.integer(mes)) %>% 
  filter(!(is.na(mes))) %>% 
  verify(all(mes >= 1))

log_info("join")
n_init <- nrow(lideres)

territorios_lideres <- lideres %>% 
  left_join(munis, by = c("municipio" = "mpio_cnmbr")) %>% 
  verify(nrow(.) == n_init)





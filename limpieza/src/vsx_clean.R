#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, assertr, arrow, tidyr, here, janitor, purrr,
                openxlsx, stringr, stringi, writexl)

log_info("DEFINE DIRECTORY")
input_lideres <- here("input_data/violencia/Base-de-datos-líderes-asesinados_2021.xlsx")

output_lideres <- here("limpieza/output/lideres_clean.parquet")

output_lideres_tierras <- here("limpieza/output/lideres_tierras_clean.xlsx")

log_info("CREATE FUNCTIONS")
verify_not_na_cols <- function(df) {
  
  df_1 <- df %>% 
    summarise_all(~ any(!is.na(.))) %>% 
    verify(all(. == TRUE))
  
  return(df)
  
}

log_info("LOAD DATA")
lideres <- read.xlsx(input_lideres) %>%
  clean_names()

log_info("CLEAN COLS")
lideres <- lideres %>%
  mutate_all(~str_to_upper(.)) %>%
  mutate(perfil = str_squish(perfil)) %>%
  mutate(perfil = stri_trans_general(perfil, "latin-ascii"))

lideres_tierras <- lideres %>%
  filter(str_detect(perfil, "TIERRAS")) %>%
  verify(nrow(.) > 0)

log_info("EXPORT")
write_parquet(lideres, output_lideres)

write_xlsx(lideres_tierras, output_lideres_tierras)

log_info("DONE clase_limpiar_strings_lideres.R")

#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, assertr, arrow, tidyr, here, janitor, purrr,
                openxlsx, stringr, stringi, writexl)

log_info("DEFINE DIRECTORY")
input_archivo <- here("input_data/archivo_historico/Catálogo Min Interior 1948-2003.xlsx")

output_archivo_tierras <- here("limpieza/output/archivo_tierras_clean.xlsx")

log_info("CREATE FUNCTIONS")

log_info("LOAD DATA")
archivo_mininterior <- read.xlsx(input_archivo) %>% 
  clean_names()

log_info("CLEAN COLS")
archivo_mininterior <- archivo_mininterior %>%
  mutate_all(~str_to_upper(.)) %>%
  mutate(asunto_o_tema = str_squish(asunto_o_tema)) %>%
  mutate(asunto_o_tema = stri_trans_general(asunto_o_tema, "latin-ascii"))

archivo_paras <- archivo_mininterior %>%
  filter(str_detect(asunto_o_tema, "PARAMILITAR")) %>%
  verify(nrow(.) > 0)

archivo_convivir <- archivo_mininterior %>% 
  filter(str_detect(asunto_o_tema, "CONVIVIR"))

archivo_sp <- archivo_mininterior %>% 
  filter(str_detect(asunto_o_tema, "PARAMIL") | str_detect(asunto_o_tema, "CONVIVIR"))

log_info("EXPORT")
write_parquet(archivo, output_archivo)

write_xlsx(archivo_tierras, output_archivo_tierras)

log_info("DONE clase_limpiar_strings_archivo.R")

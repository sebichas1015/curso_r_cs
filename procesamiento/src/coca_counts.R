#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, assertr, arrow, tidyr, here, janitor, purrr,
                openxlsx)

log_info("DEFINE DIRECTORY")
input_coca <- here("input_data/economias_ilicitas/Datos-anónimos-encuesta-PNIS.xlsx")

output_coca <- here("procesamiento/output/coca_count.xlsx")

output_coca <- here("procesamiento/output/")

log_info("CREATE FUNCTIONS")
verify_not_na_cols <- function(df) {
  
  df_1 <- df %>% 
    summarise_all(~ any(!is.na(.))) %>% 
    verify(all(. == TRUE))
  
  return(df)
  
}

log_info("LOAD DATA")
coca_pnis <- read.xlsx(input_coca) %>%
  clean_names()

log_info("COUNTS")
gini_tierras <- coca_pnis %>%
  pivot_wider()

log_info("COUNTS")
gini_tierras <- coca_pnis %>%
  pivot_long:



  pivot_wider(names_from = departamento,
              values_from = area_ha)




log_info("EXPORT")
write_parquet(gini_tierras, output_gini)

log_info("DONE clase_limpiar_strings_gini.R")

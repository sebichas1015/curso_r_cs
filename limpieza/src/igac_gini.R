#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, assertr, arrow, tidyr, here, janitor, purrr,
                openxlsx)

log_info("DEFINE DIRECTORY")
input_gini <- here("/mnt/c/Users/sebas/OneDrive/Documents/CEPAP/team_data/cifras_agro/igac_gini/process/output/gini_igac.parquet")

output_gini <- here("limpieza/output/gini_tierras.parquet")

log_info("CREATE FUNCTIONS")
verify_not_na_cols <- function(df) {
  
  df_1 <- df %>% 
    summarise_all(~ any(!is.na(.))) %>% 
    verify(all(. == TRUE))
  
  return(df)
  
}

log_info("LOAD DATA")
gini_tierras <- read_parquet(input_gini) %>%
  clean_names()

log_info("PIVOT")
gini_tierras <- gini_tierras %>%
  pivot_wider(names_from = departamento,
              values_from = area_ha)

log_info("EXPORT")
write_parquet(gini_tierras, output_gini)

log_info("DONE clase_limpiar_strings_gini.R")

#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, assertr, arrow, writexl, readr, openxlsx, haven)

log_info("DEFINE DIRECTORY")
setwd("/Users/sebas/OneDrive/Documents/curso_r_cs/")

input_coca <- "input_data/economias_ilicitas/RPT_CultivosIlicitos_2024-12-22--194158.xlsx"

input_gini_t <- "input_data/agropecuario/GINI_COL_IGAC_V3_07052024.xlsx"

input_ins_viol <- "input_data/violencia/Replication Dataset-Panel Data.dta"

input_cnmh_df <- "input_data/violencia/CasosDF_202409.parquet"

input_censo <- "input_data/agropecuario/censo_agro_import.parquet"

log_info("LOAD DATA")
table_censo <- read_parquet(input_censo, col_select = c("recordid", "p_s12p150a", "s05_tenencia"))

table_coca <- read.xlsx(input_coca, startRow = 9)

table_gini <- read.xlsx(input_gini_t, sheet = "Gini Municipal", startRow = 4)

log_info("DELETE OBJECTS")
rm(table_pnis, table_hogares, table_ins_viol, table_cnmhdf, table_censo)

gc()

log_info("DONE clase_import_1.R")

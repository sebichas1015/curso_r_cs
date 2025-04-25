#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, assertr, arrow, writexl, readr, openxlsx, haven)

log_info("DEFINE DIRECTORY")
setwd("/Users/sebas/OneDrive/Documents/curso_r_cs/")

input_pnis <- "input_data/economias_ilicitas/Datos-anónimos-encuesta-PNIS.xlsx"

input_hogares <- "input_data/agropecuario/S15H(Hogares).csv"

input_ins_viol <- "input_data/violencia/Replication Dataset-Panel Data.dta"

input_cnmh_df <- "input_data/violencia/CasosDF_202409.parquet"

input_censo <- "input_data/agropecuario/censo_agro_import.parquet"

log_info("LOAD DATA")
table_pnis <- read.xlsx(input_pnis)

table_hogares <- read_delim(input_hogares)

table_ins_viol <- read_dta(input_ins_viol)

table_cnmhdf <- read_parquet(input_cnmh_df)

table_censo <- read_parquet(input_censo, col_select = c("recordid", "p_s12p150a", "s05_tenencia"))

log_info("DELETE OBJECTS")
rm(table_pnis, table_hogares, table_ins_viol, table_cnmhdf, table_censo)

gc()

log_info("DONE clase_import_1.R")

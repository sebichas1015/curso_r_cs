#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, assertr, arrow, writexl, readr, openxlsx, haven)

log_info("DEFINE DIRECTORY")
setwd("/Users/sebas/OneDrive/Documents/curso_r_cs/")

input_saber_2020 <- "input_data/educacion/Saber_11__2020-2_20250425.csv"

input_ins_frn <- "input_data/violencia/Cross-sectional dataset Daly 2012.dta"

input_censo <- "input_data/agropecuario/censo_agro_import.parquet"

input_hom_selc <- "input_data/violencia/VictimasAS_202409.xlsx"

log_info("LOAD DATA")
s11 <- read_delim(input_saber_2020)

ins_frn <- read_dta(input_ins_frn)

table_censo <- read_parquet(input_censo,
                            col_select = c("recordid", "p_depto", "p_munic"))

cnmh_hs <- read.xlsx(input_hom_selc)

log_info("DELETE OBJECTS")
rm(s11, ins_frn, table_censo, cnmh_hs)

gc()

log_info("DONE taller_import_1.R")

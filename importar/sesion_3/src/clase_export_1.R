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

input_censo <- "input_data/agropecuario/censo_agro_import.parquet"

output_pnis <- "importar/sesion_3/output/pnis.parquet"

output_hogares <- "importar/sesion_3/output/s15h_hogares.csv"

output_ins_viol <- "importar/sesion_3/output/ins_viol.xlsx"

output_censo <- "importar/sesion_3/output/censo_agro_vars.ods"

log_info("LOAD DATA")
table_pnis <- read.xlsx(input_pnis)

table_hogares <- read_delim(input_hogares)

table_ins_viol <- read_dta(input_ins_viol)

table_censo <- read_parquet(input_censo,
                            col_select = c("recordid", "p_s12p150a",
                                           "s05_tenencia"))

log_info("FIRST 5 RECORDS")
table_pnis <- table_pnis %>% 
  head()

table_hogares <- table_hogares %>% 
  head()

table_ins_viol <- table_ins_viol %>% 
  head()

table_censo <- head(table_censo)

log_info("EXPORT")
write_parquet(table_pnis, output_pnis)

write_csv(table_hogares, output_hogares)

write_xlsx(table_ins_viol, output_ins_viol)


wb <- createWorkbook()

addWorksheet(wb, "hoja_censo")

writeData(wb, "hoja_censo", table_censo)

saveWorkbook(wb, output_censo, overwrite = TRUE)

rm(table_hogares, table_coca, table_censo)

gc()

log_info("DONE clase_export.R")

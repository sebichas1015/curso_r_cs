#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, assertr, arrow, writexl, readr, openxlsx)

log_info("DEFINE DIRECTORY")

setwd("/Users/sebas/OneDrive/Documents/curso_r_cs/")

input_hogares <- "input_data/agropecuario/S15H(Hogares).csv"

input_coca <- "input_data/economias_ilicitas/RPT_CultivosIlicitos_2024-12-22--194158.xlsx"

input_censo <- "input_data/agropecuario/censo_agro_import.parquet"

output_hogares <- "introduccion/output/s15h_hogares.parquet"

output_coca <- "introduccion/output/coca_anio_mpio.parquet"

output_censo <- "introduccion/output/censo_agro_vars.parquet"

log_info("LOAD DATA")
table_hogares <- read_delim(input_hogares)

table_censo <- read_parquet(input_censo,
                            col_select = c("recordid", "p_s12p150a",
                                           "s05_tenencia"))

n_table_hogares <- nrow(table_hogares)

n_table_coca <- nrow(table_coca)

n_table_censo <- nrow(table_censo)

table_coca <- read.xlsx(input_coca, startRow = 9)

log_info("CREATE RECORD NUMBER")
table_hogares <- table_hogares %>%
  mutate(id_record = row_number()) %>%
  verify(nrow(.) == n_table_hogares)

table_coca <- table_coca %>%
  mutate(id_record = row_number()) %>%
  verify(nrow(.) == n_table_coca)

table_censo <- table_censo %>%
  mutate(id_record = row_number()) %>%
  verify(nrow(.) == n_table_censo)

log_info("EXPORT")
write_parquet(table_hogares, output_hogares)

write_parquet(table_coca, output_coca)

write_parquet(table_censo, output_censo)

rm(table_hogares, table_coca, table_censo)

gc()

log_info("DONE clase_import_export.R")

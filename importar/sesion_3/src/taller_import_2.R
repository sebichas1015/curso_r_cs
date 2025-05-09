#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, assertr, arrow, writexl, readr, openxlsx, haven)

log_info("DEFINE DIRECTORY")
setwd("/Users/sebas/OneDrive/Documents/curso_r_cs/")

input_coca <- "input_data/economias_ilicitas/RPT_CultivosIlicitos_2025-05-08--223228.xlsx"

input_la <- "input_data/violencia/Base-de-datos-líderes-asesinados_2021.xlsx"

input_cnmh_df <- "input_data/violencia/CasosDF_202409.parquet"

output_coca <- "importar/sesion_3/output/coca.xlsx"

output_la <- "importar/sesion_3/output/la.csv"

output_cnmh_df <- "importar/sesion_3/output/cnmh_df.parquet"

log_info("LOAD DATA")
table_cnmh_df <- read_parquet(input_cnmh_df, c("Año", "Mes", "Día", "Departamento",
                                               "Municipio", "Presunto.Responsable"))
table_coca <- read.xlsx(input_coca, startRow = 9)

table_la <- read.xlsx(input_la, sheet = "Instrumento")

log_info("EXPORT")
write_parquet(table_cnmh_df, output_cnmh_df)

write_csv(table_coca, output_coca)

write_xlsx(table_la, output_la)

log_info("DELETE OBJECTS")
rm(table_cnmh_df, table_coca, table_la)

gc()

log_info("DONE clase_import_1.R")

#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, assertr, arrow, tidyr, here)

log_info("DEFINE DIRECTORY")
input_coca <- here("introduccion/output/coca_anio_mpio.parquet")

output_coca <- here("limpieza/output/coca_pivot.parquet")

log_info("LOAD DATA")
table_coca <- read_parquet(input_coca)

n_table_coca <- nrow(table_coca)

log_info("PIVOT")
table_coca <- table_coca %>%
  pivot_longer(cols = c("1999", "2000", "2001", "2002", "2003", "2004", "2005",
                        "2006", "2007", "2008", "2009", "2010", "2011", "2012",
                        "2013", "2014", "2015", "2016", "2017", "2018", "2019",
                        "2020", "2021", "2022", "2023"),
              names_to = "anio",
              values_to = "hectareas_coca") %>%
verify(nrow(.) == n_table_coca * 25) %>%
filter(!(is.na(hectareas_coca))) %>%
verify(nrow(.) > 0) %>%
assert(not_na, hectareas_coca) %>%
mutate(id_record = row_number()) %>%
verify(ncol(.) == 7)

log_info("EXPORT")
write_parquet(table_coca, output_coca)

rm(table_coca)

gc()

log_info("DONE clase_pivot.R")

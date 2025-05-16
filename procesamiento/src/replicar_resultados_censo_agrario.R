#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, tidyr, logger, assertr, arrow, writexl)

log_info("DEFINE DIRECTORY")

setwd("/Users/sebas/OneDrive/Documents/curso_r_cs/")

input_1 <- "input_data/agropecuario/censo_agro_import.parquet"

output_1 <- "introduccion/output/total_has.xlsx"

log_info("LOAD DATA")
vars_inpt <- c("recordid", "p_s12p150a", "pred_etnica")

censo_agr_2014 <- read_parquet(input_1, col_select = all_of(vars_inpt)) %>%
  assert(is_uniq, recordid) %>%
  assert(not_na, recordid)

cols_censo_agr_2014 <- colnames(censo_agr_2014)

n_censo_agr_2014 <- nrow(censo_agr_2014)

log_info("STANDARDIZE VALUES")
censo_agr_2014 <- censo_agr_2014 %>% 
  mutate(p_s12p150a_has_clean = p_s12p150a/10000) %>%
  select(-p_s12p150a) %>%
  verify(nrow(.) == n_censo_agr_2014)

total_has <- censo_agr_2014 %>%
  filter(pred_etnica == 7) %>%
  verify(length(unique(pred_etnica)) == 1) %>%
  verify(nrow(.) > 0) %>%
  summarise(total_has = sum(p_s12p150a_has_clean, na.rm = TRUE))

total_upas <- censo_agr_2014 %>%
  filter(pred_etnica == 7) %>%
  filter(!is.na(p_s12p150a_has_clean)) %>% 
  verify(length(unique(pred_etnica)) == 1) %>%
  verify(nrow(.) > 0) %>%
  summarise(total_upas = n())

sum_may_500 <- censo_agr_2014 %>% 
  filter(pred_etnica == 7) %>%
  filter(p_s12p150a_has_clean > 500) %>% 
  summarise(sum_total = sum(p_s12p150a_has_clean, na.rm = TRUE)) %>% 
  mutate(sum_total_miles = sum_total/1000)

prom_may_500 <- censo_agr_2014 %>% 
  filter(pred_etnica == 7) %>%
  filter(p_s12p150a_has_clean > 500) %>% 
  summarise(prom_total = mean(p_s12p150a_has_clean, na.rm = TRUE)) %>% 
  mutate(prom_total = round(prom_total))

upas_men_10 <- censo_agr_2014 %>% 
  filter(pred_etnica == 7) %>%
  filter(p_s12p150a_has_clean < 10) %>%
  summarise(tam_prom = mean(p_s12p150a_has_clean, na.rm = TRUE)) %>% 
  mutate(tam_prom_round = round(tam_prom))

rm(censo_agr_2014)
gc()

log_info("DONE.")

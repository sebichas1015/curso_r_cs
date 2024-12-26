#
# Authors:     Sebas
# Maintainers: Sebas
# Year: 2024
# =========================================

pacman::p_load(dplyr, logger, assertr, arrow, tidyr, here, janitor, purrr,
                writexl)

log_info("DEFINE DIRECTORY")
input_censo <- here("introduccion/output/censo_agro_vars.parquet")

output_censo <- here("limpieza/output/censo_agro_ext_ethnc.parquet")

output_censo_tenencia <- here("limpieza/output/censo_agro_tenencia.xlsx")

log_info("CREATE FUNCTIONS")
verify_not_na_cols <- function(df) {
  
  df_1 <- df %>% 
    summarise_all(~ any(!is.na(.))) %>% 
    verify(all(. == TRUE))
  
  return(df)
  
}

log_info("LOAD DATA")
censo_agrpcr <- read_parquet(input_censo,
                            col_select = c("id_record", "p_s12p150a",
                                           "s05_tenencia")) %>%
clean_names() %>%
  assert(is_uniq, id_record) %>%
  assert(not_na, id_record)

n_cesos_agrpcr <- ncol(censo_agrpcr)

log_info("CLEAN")
censo_agrpcr <- censo_agrpcr %>%
  mutate(p_s12p150a_has_clean = p_s12p150a/10000) %>% 
  mutate(s05_tenencia_clean = case_when(
    s05_tenencia == 1 ~ "propia",
    s05_tenencia == 2 ~ "arriendo",
    s05_tenencia == 3 ~ "aparceria",
    s05_tenencia == 4 ~ "usufructo",
    s05_tenencia == 5 ~ "comodato",
    s05_tenencia == 6 ~ "ocupacion_de_hecho",
    s05_tenencia == 7 ~ "propiedad_colectiva",
    s05_tenencia == 8 ~ "adjudicatario_o_comunero",
    s05_tenencia == 9 ~ "otra_forma_de_tenencia",
    s05_tenencia == 11 ~ "mixta",
    s05_tenencia == 99 ~ "no_sabe", TRUE ~ NA)) %>%
  select(-p_s12p150a, -s05_tenencia) %>%
  verify(ncol(.) == n_cesos_agrpcr) %>%
  verify_not_na_cols()

has_propias <- censo_agrpcr %>%
  filter(s05_tenencia_clean == "propia") %>%
  summarise(total_has = sum(p_s12p150a_has_clean, na.rm = TRUE))

tenencia_has <- censo_agrpcr %>%
  group_by(s05_tenencia_clean) %>%
  summarise(total_hectareas = sum(p_s12p150a_has_clean, na.rm = TRUE)) %>%
  ungroup()

log_info("EXPORT")
write_parquet(censo_agrpcr, output_censo)

write_xlsx(tenencia_has, output_censo_tenencia)

log_info("DONE clase_limpiar_strings.R")

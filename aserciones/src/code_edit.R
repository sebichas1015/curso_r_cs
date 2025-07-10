#
# Authors:     SCB
# Maintainers: SCB
# =========================================
# 


pacman::p_load(arrow, openxlsx, assertr, dplyr, logger, janitor)

path_df <- "/Users/sebas/OneDrive/Documents/curso_r_cs/input_data/violencia/VictimasAS_202409.xlsx"

path_output <- "/Users/sebas/OneDrive/Documents/curso_r_cs/aserciones/output/asesntos_arrors.parquet"

df <- read.xlsx(path_df)

df <- df %>% 
  clean_names()

df_sampl_1 <- df %>% 
  sample_n(10) %>% 
  mutate(id_caso = "80659")
  
df_sampl_2 <- df %>% 
  sample_n(10) %>% 
  mutate(id_caso = "399406")

df <- df %>% 
  bind_rows(df_sampl_1) %>% 
  bind_rows(df_sampl_2)

write_parquet(df, path_output)







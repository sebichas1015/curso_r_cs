#
# Authors:     SCB
# Maintainers: SCB
# =========================================
# 

pacman::p_load(arrow, openxlsx, assertr, dplyr, logger, janitor, sf)

path_df <- "/Users/sebas/OneDrive/Documents/curso_r_cs/aserciones/output/asesntos_arrors.parquet"

path_munis <- "/Users/sebas/OneDrive/Documents/CEPAP/team_data/munis_col_2023/input/MGN2023_MPIO_POLITICO/MGN_ADM_MPIO_GRAFICO.shp"

df <- read_parquet(path_df)

munis <- st_read(path_munis)

df <- df %>% 
  clean_names()

## 1. adicione una verificacion para corroborar si un id_caso se asocia a mas
## de un anio
cantidad_anios_id_caso <- df %>% 
  group_by(id_caso) %>% 
  summarise(n_dist_an = n_distinct(ano, na.rm = TRUE)) %>% 
  ungroup()

## 2. Adicione una verificacion para corroborar si un id_caso se asocia a mas
## de un municipio
cantidad_munis_id_caso <- df %>% 
  group_by(id_caso) %>% 
  summarise(n_dist_an = n_distinct(municipio, na.rm = TRUE)) %>% 
  ungroup()

## 3. Adicione una verificacion para corroborar si al recuperar las coordenadas
## por nombres de municipios se estarian duplicando los registros
df_names_coord <- df %>% 
  left_join(munis, by = c("municipio" = "mpio_cnmbr"))

## 4. Adicione una verificacion para corroborar si al recuperar las coordenadas
## por codigos dane se estarian duplicando los registros
df_coord <- df %>% 
  left_join(munis, by = c("codigo_dane_de_municipio" = "mpio_cdpmp"))

## 5. identifique si los id_caso de df estan duplicados a traves de una verificacion

## 6. Adicione una nueva verificacion para df que usted considere pertinente




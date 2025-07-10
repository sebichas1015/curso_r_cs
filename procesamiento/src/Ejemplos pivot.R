library(tidyr)
library(dplyr)


#Ejemplos pivot_longer
#Ejemplo 1

Casos_tuberculosis<-table4a

Casos_tuberculosis_long <- Casos_tuberculosis %>%
  pivot_longer(cols = c(`1999`, `2000`),
               names_to = "year",
               values_to = "cases")

#Ejemplo2
billboard<-billboard
  
billboard_long <- billboard %>%
  pivot_longer(cols = starts_with("wk"),
               names_to = "week",
               values_to = "rank",
               values_drop_na = TRUE)

#Ejemplos pivot_wider

#Ejemplo1
Casos_tuberculosis_2<-table2
View(Casos_tuberculosis_2)

Casos_tuberculosis_2_wider<-Casos_tuberculosis_2 %>% 
  pivot_wider(names_from = type,
            values_from = count)

#Ejemplo2
library(ggplot2)

economics_long<-economics_long %>% 
  select(-value01)

economics_wide <-economics_long %>% 
  pivot_wider(names_from = variable,
              values_from = value)


#Ejemplo split_cells


table3<-table3
table3_wide<-table3 %>% 
  separate_wider_delim(cols = rate,delim="/",names = c("cases", "population"))


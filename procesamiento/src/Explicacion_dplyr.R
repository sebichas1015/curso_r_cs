# Authors:     DCH
# Maintainers: DCH
# Copyright:   2025, UNAL
# =========================================


library(dplyr)

# ---- Functions ----

saber_11_2020<-read.csv("Saber_11__2020-2_20250509.csv")
#select
saber_11_2020_matematicas<-saber_11_2020 %>% 
  select(ESTU_TIPODOCUMENTO,ESTU_NACIONALIDAD,PUNT_MATEMATICAS)

#filter
saber_11_2020_matematicas<-saber_11_2020 %>% 
  select(ESTU_TIPODOCUMENTO,ESTU_NACIONALIDAD,PUNT_MATEMATICAS) %>% 
  filter(ESTU_TIPODOCUMENTO=="TI")  

#mutate
saber_11_2020_matematicas<-saber_11_2020_matematicas %>% 
  mutate(PUNT_MATEMATICAS_ESTAN=((PUNT_MATEMATICAS-mean(PUNT_MATEMATICAS,na.rm=TRUE))))

#group_by

saber_11_2020_matematicas2<-saber_11_2020_matematicas %>% 
  group_by(ESTU_NACIONALIDAD) %>% 
  mutate(PUNT_MATEMATICAS_ESTAN=((PUNT_MATEMATICAS-mean(PUNT_MATEMATICAS,na.rm=TRUE))))

saber_11_2020_matematicas_VEN<-saber_11_2020_matematicas %>% 
  filter(ESTU_NACIONALIDAD=="VENEZUELA") %>% 
  mutate(PUNT_MATEMATICAS_ESTAN=((PUNT_MATEMATICAS-mean(PUNT_MATEMATICAS,na.rm=TRUE))/sd(PUNT_MATEMATICAS,na.rm=TRUE)))

#group_by-summarise-arrange

puntajes<-saber_11_2020_matematicas %>% 
  group_by(ESTU_NACIONALIDAD) %>% 
  summarise(PROMEDIO_PUNTAJE=mean(PUNT_MATEMATICAS)) %>% 
  arrange(desc(PROMEDIO_PUNTAJE))


#count

saber_11_2020_matematicas %>% count(ESTU_NACIONALIDAD,name="frecuencia") %>% 
  arrange(-frecuencia)





























































# Vectores con información de personas

fechas_nacimiento <- as.Date(c("1990-05-12", "1985-10-23", "2000-07-15", "2010-01-01", "1975-09-30"))
nombre <- c("Ana", "Luis", "María", "Carlos", "Lucía")
hectareas <- c(1.5, 3.0, 0.8, 2.5, 1.0)        # Double
edad <- c(10, 35, 70, 18, 65)                 # Enteros (int)
adscrito_pnis <- c(FALSE, TRUE, FALSE, TRUE, FALSE)  # Booleano

# Crear el data frame con los vectores anteriores
datos_poblacion <- data.frame(
  Nombre = nombre,
  fechas_nacimiento = fechas_nacimiento,
  Edad = edad,
  Hectareas = hectareas,
  Adscrito_PNIS = adscrito_pnis
)

# Ver el contenido
print(datos_poblacion)

# Crear un vector vacío para guardar la clasificación etaria
grupo_etario <- c()

# Clasificar cada persona según su edad
for (i in 1:nrow(datos_poblacion)) {
  edad_persona <- datos_poblacion$Edad[i]
  
  if (edad_persona >= 0 && edad_persona <= 14) {
    grupo_etario[i] <- "Niños y jóvenes"
  } else if (edad_persona >= 15 && edad_persona <= 64) {
    grupo_etario[i] <- "Adultos"
  } else {
    grupo_etario[i] <- "Adultos mayores"
  }
}

# Agregar la clasificación al data frame
datos_poblacion$Grupo_Etario <- grupo_etario


# Definir una función para calcular el promedio de hectáreas
promedio_hectareas <- function(hectareas_vector) {
  return(mean(hectareas_vector))
}

# Usar la función
promedio_total <- promedio_hectareas(datos_poblacion$Hectareas)
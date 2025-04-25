
# 1. Variable entera
entero <- 42L  # El sufijo L indica un valor entero
typeof(entero)  # Muestra el tipo de la variable

# 2. Variable numérica floatante
num <- 25.5
typeof(num)  

# 3. Variable lógica (booleana)
logico <- TRUE
typeof(logico)  

# 4. Variable de texto (carácter)
texto <- "Hola, R!"
typeof(texto) 

# 5. Fecha (Date)
fecha <- as.Date("2023-05-15")
typeof(fecha)  


# Crear una matriz de 2 filas y 3 columnas con los nombres de las 6 regiones geográficas de Colombia
regiones <- matrix(c("Amazonía", "Andina", "Caribe", "Orinoquía", "Pacífica", "Insular"), 
                   nrow = 2, 
                   ncol = 3)
# Ver la matriz
regiones

# Acceder al elemento de la fila 1, columna 2
regiones[1, 2]

# Obtener las dimensiones de la matriz
dim(regiones)

# Cambiar el valor de la fila 2, columna 3
regiones[2, 3] <- "Archipiélago"
regiones
ar <- array(c(11:14, 21:24, 31:34), dim = c(2, 2, 3))


# Crear un data frame con datos de conflicto armado

Fecha = as.Date(c("2023-01-10", "2023-03-15", "2023-05-20", "2023-07-05"))
Departamento = c("Antioquia", "Cauca", "Nariño", "Chocó")
Numero_victimas = c(25, 40, 15, 60)
Tipo_ataque = c("Enfrentamiento", "Atentado", "Emboscada", "Asalto")

conflicto_armado <- data.frame(Fecha,Departamento,Numero_victimas,Tipo_ataque)

# Ver el data frame
conflicto_armado

# Acceder a una columna del data frame
conflicto_armado$Departamento

# Acceder a una fila específica
conflicto_armado[2, ]

# Ver las dimensiones del data frame
dim(conflicto_armado)


edad <- 25
#Uso de if-else
if (edad < 13) {
  print("Eres un niño.\n")
} else if (edad >= 13 && edad < 18) {
  print("Eres un adolescente.\n")
} else if (edad >= 18 && edad < 65) {
  print("Eres un adulto.\n")
} else {
  print("Eres una persona mayor.\n")
}


#Creamos un vector con edades
edades <- c(25, 30, 22, 40, 35, 28, 50, 19, 24, 33)

suma_edades <- 0
#Ejecucion del for del largo del vector edades
for (i in 1:length(edades)) {
  suma_edades <- suma_edades + edades[i]
  print(suma_edades)
}






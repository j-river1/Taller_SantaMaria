#Formato para precipitaciones
#Juan Camilo Rivera Palacio
#8 de Agosto del 2018

#Librerias
library(gdata)
library(here)
library(tidyr)
library(dplyr)

#Crear  dos carpeta carpetas. 
#1. Datos = Donde estan los datos originales
#2. Datos_formato = donde estan los datos originales con formato
dir.create(file.path(here(), "Datos"), showWarnings = FALSE)
dir.create(file.path(here(), "Datos", "Datos_formato"), showWarnings = FALSE)


#Lecturas de datos
#hay una carpeta Datos donde estan el archivo de precipitacion
datos_preci <- read.xls(file.path(here("Datos"),"Precipitaciones historicas.xlsx"))

#Seleccionar las fincas
fincas <- as.character(unique(datos_preci$finca))


#Dar_formato

Dar_formato <- function(x)
{
  
  #seleccionar la finca
  finca <- subset(datos_preci, finca == x)
  
  #elimar las columnas
  finca$finfinca <- NULL
  finca$NMANO <- NULL
  finca$NMSEMANA <- NULL
  finca$dsdia <- NULL
  finca$DSOBSERVACION <- NULL
  finca$finca <- NULL
  finca$FELECTURA <- as.Date(finca$FELECTURA) 
  
  #nombres de las columnas
  names(finca) <- c("Date", "Value")
  finca$Date <- finca$Date[order(finca$Date)]
  
  #tabla con todos los posibles dias
  dias <- seq(from = finca$Date[1], to = finca$Date[length(finca$Date)], by = "days")
  tabla_dias <- data.frame(Date = dias, Value = NA)
  
  result <- left_join(tabla_dias,finca, by = "Date")
  result$Value.x <- NULL
  names(result) <- c("Date", "Value")
  
  write.table(result, file = paste0(here("Datos", "Datos_formato"),"/", x,"_P_MM.txt"))
}

lapply(fincas, Dar_formato)


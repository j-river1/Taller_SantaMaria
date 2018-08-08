#Pregunta Jorge Mario Montesino
#Borrar Memoria
rm(list=ls())


#librerias
library (moments)
library(nortest)
library(forecast)
library(tseries)
library(stats)
library(here)
library(stringr)
library(stats)


data1=read.csv(paste0(here(),"/Data/Ratio2012-2018xFincas.csv"), header = TRUE, sep=";", dec=",")


#Limpieza de datos para la columna SantaMaria
colnames(data1)[23] <- "SANTA_MARIA"
data1$SANTA_MARIA <- as.character(data1$SANTA_MARIA)
data1$SANTA_MARIA <- str_replace_all(data1$SANTA_MARIA, ",,", "")

for (i in 1:nrow(data1))
{
numero <- data1[i,23]
last_string <- substr(numero, nchar(numero), nchar(numero))

  if(last_string == ",")
  {
    substr(data1[i,23], nchar(numero), nchar(numero))  <- "0"
  }
}

data1$SANTA_MARIA <- str_replace_all(data1$SANTA_MARIA, ",", ".")
data1$SANTA_MARIA <- as.numeric(data1$SANTA_MARIA)

#CUNASDOS

CUNASDOS[1:158] <- NA
CUNASDOS <- CUNASDOS[!is.na(CUNASDOS)] 



#Graficas
jpeg('CUNASDOS.jpg') 
plot(CUNASDOS, type="l", xlab="Semanas", ylag="CUNASDOS",xaxp= c(1,313,6),yaxp= c(0.7,1.18,8))
dev.off()

#Funciones para encontrar 
mean(CUNASDOS)
sd(CUNASDOS)
kurtosis(CUNASDOS)

#Prueba de normalidad para muestras pequenhas. Es normal si es mayor a 0.05, se rechaza hipotesis nula
#los datos no son normales.
shapiro.test(CUNASDOS)
adf.test(CUNASDOS)



acf(CUNASDOS)
pacf(CUNASDOS)
auto.arima(CUNASDOS)
arima(CUNASDOS)


arimaCUNASDOS=arima(CUNASDOS, order=c(30,1,1))
plot(arimaCUNASDOS$residuals, type="l")
Box.test(arimaCUNASDOS$residuals, type="Ljung-Box")
forecast(arimaCUNASDOS, 23)
plot(forecast(arimaCUNASDOS, 23))



CUNASDOS
plot(CUNASDOS, type="l", xlab="Semanas", ylag="CUNASDOS",xaxp= c(1,313,6),yaxp= c(0.7,1.18,8))
mean(CUNASDOS)
sd(CUNASDOS)

kurtosis(CUNASDOS)
shapiro.test(CUNASDOS)

lillie.test(CUNASDOS)


adf.test(CUNASDOS)
acf(CUNASDOS)
pacf(CUNASDOS)
auto.arima(CUNASDOS[160,2])
arima(CUNASDOS, order=c(5,0,1))
arimaCUNASDOS=arima(CUNASDOS, order=c(30,1,1))
arimaCUNASDOS



plot(arimaCUNASDOS$residuals, type="l")

Box.test(arimaCUNASDOS$residuals, type="Ljung-Box")
forecast(arimaCUNASDOS, 23)
plot(forecast(arimaCUNASDOS, 23))

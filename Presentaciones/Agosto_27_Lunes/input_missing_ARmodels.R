#Example and aplications of AR
#Juan Camilo Rivera


rm(list=ls())
#library
library(partsm)
library(gdata)
library(rpart)
library(rpart.plot)

#Load the data
data("gergnp")

#Standarize of data
lgergnp <- log(gergnp, base=exp(1))

#Components of model
#*regular. If first and second position are  1, that means intercept and  linear tendence are included
#*thrid seasonal dummies are included. 
#*seasonal, If intercepts (mean) and seasonal trends are included in the model. 
#*regressor variables. if there is a regressor variables so is 1. 

detcomp <- list(regular=c(0,0,0), seasonal=c(1,0), regvar=0)
aic <- bic <- Fnextp <- Fpval <- rep(NA, 4)
for(p in 1:4){

#fix model   
lmpar <- fit.ar.par(wts=lgergnp, detcomp=detcomp, type="PAR", p=p)

#Stadistic and Schwarz and Akaike
aic[p] <- AIC(lmpar@lm.par, k=2)
bic[p] <- AIC(lmpar@lm.par, k=log(length(residuals(lmpar@lm.par))))

#Performance parameters varying p
Fout <- Fnextp.test(wts=lgergnp, detcomp=detcomp, p=p, type="PAR")
Fnextp[p] <- Fout@Fstat
Fpval[p] <- round(Fout@pval,2)
}

#See stadistic
Fpval
aic
bic


#Periodic 
dcsi <- list(regular=c(0,0,0), seasonal=c(1,0), regvar=0)
out.Fparsi <- Fpar.test(wts=lgergnp, detcomp=dcsi, p=2)
show(out.Fparsi)


dcsit <- list(regular=c(0,0,0), seasonal=c(1,1), regvar=0)
out.Fparsit <- Fpar.test(wts=lgergnp, detcomp=dcsit, p=2)
show(out.Fparsit)




out.pred <- predictpiar(wts=lgergnp, p=2, hpred=24)
out.pred@wts <- exp(1)^out.pred@wts
out.pred@fcast <- exp(1)^out.pred@fcast
out.pred@ucb <- exp(1)^out.pred@ucb
out.pred@lcb <- exp(1)^out.pred@lcb

jpeg("forecast.jpg")
plotpredpiar(out.pred)
dev.off()

out.pred@wts <- exp(1)^out.pred@wts
out.pred@fcast <- exp(1)^out.pred@fcast
out.pred@ucb <- exp(1)^out.pred@ucb
out.pred@lcb <- exp(1)^out.pred@lcb
plotpredpiar(out.pred)



#Llenado de faltantes.
#Rmwagen

year_max <- 2016
year_min <- 2015
origin <- "2015-01-1"
PREC_CLIMATE <- NULL
n_GPCA_iter <- 5
n_GPCA_iteration_residuals <- 5
p_test <- 1
p_prec <- 3
p_temp <- 10
exogen <- NULL
exogen_sim <- exogen
station <- c("Agroipsa_aux", "Agroipsa")
#station <- c("Agroipsa")
TN_CLIMATE <- NULL
TX_CLIMATE <- NULL
PREC_CLIMATE <- NULL





generacion_Datos_Temperatura <- ComprehensiveTemperatureGenerator( station = station,
                                                                   Tx_all = datos_TX,
                                                                   Tn_all = datos_TM,
                                                                   year_min = year_min,
                                                                   year_max = year_max,
                                                                   p= p_temp,
                                                                   n_GPCA_iteration = n_GPCA_iter,
                                                                   n_GPCA_iteration_residuals = n_GPCA_iteration_residuals,
                                                                   exogen= exogen,
                                                                   exogen_sim = exogen_sim,
                                                                   sample= "monthly",
                                                                   mean_climate_Tn=TN_CLIMATE,
                                                                   mean_climate_Tx=TX_CLIMATE)
#Extraer los valores del llenado

#Tomar los datos de los anos 2015 y 2016
datos_TX_2015_2016 <- subset(datos_TX, year >= 2015 & year <= 2016)
datos_TM_2015_2016 <- subset(datos_TM, year >= 2015 & year <= 2016)
datos_TM_2015_2016$Data <- "Real"
datos_TX_2015_2016$Data <- "Real"

#Indices de los faltantes
indices_TX <- which(as.vector(is.na(datos_TX_2015_2016$Agroipsa))== TRUE)
indices_TM <- which(as.vector(is.na(datos_TM_2015_2016$Agroipsa))== TRUE)

#Generado
datos_llenado_TX <- generacion_Datos_Temperatura$output$Tx_gen
datos_llenado_TM <- generacion_Datos_Temperatura$output$Tn_gen

#Escoger los datos que estan llenados

datos_TX_2015_2016$Agroipsa[indices_TX] <- datos_llenado_TX$Agroipsa_aux[indices_TX]
datos_TM_2015_2016$Agroipsa[indices_TM] <- datos_llenado_TM$Agroipsa_aux[indices_TM]

datos_TX_2015_2016$Data[indices_TX] <- "Generated"
datos_TM_2015_2016$Data[indices_TM] <- "Generated"

#Graficar

datos_TX_2015_2016$Date <- paste0(datos_TX_2015_2016$year, "-", datos_TX_2015_2016$month, "-", datos_TX_2015_2016$day)
datos_TX_2015_2016$Date <- as.Date(as.character(datos_TX_2015_2016$Date), format = "%Y-%m-%d" )

ggplot(datos_TX_2015_2016, aes(y=Agroipsa, x=Date, color = Data)) + geom_point() + labs(title="Input value minimum temperature", subtitle = "Chiapas, Station Agroipsa")
ggsave("./Graficas/Tempera_Minima_llenado.jpg")


datos_TM_2015_2016$Date <- paste0(datos_TM_2015_2016$year, "-", datos_TM_2015_2016$month, "-", datos_TM_2015_2016$day)
datos_TM_2015_2016$Date <- as.Date(as.character(datos_TM_2015_2016$Date), format = "%Y-%m-%d" )

ggplot(datos_TM_2015_2016, aes(y=Agroipsa, x=Date, color = Data)) + geom_point() + labs(title="Input value maximum temperature", subtitle = "Chiapas, Station Agroipsa")
ggsave("./Graficas/Tempera_Maxima_llenado.jpg")



#Precipitacion 

fechas_P <- as.data.frame(str_split_fixed(datos_P$Date, "-", 3))
colnames(fechas_P) <- c("year", "month", "day")
datos_P$year <- as.numeric(as.character(fechas_P$year))
datos_P$month <- as.numeric(fechas_P$month)
datos_P$day <- as.numeric(fechas_P$day)
names(datos_P)[which((names(datos_P))=="Value")] <- "Agroipsa"
datos_P$Agroipsa_aux <- datos_P$Agroipsa
datos_P$Date <- NULL
datos_P$Datos <- NULL
datos_P$Agroipsa_aux <- as.numeric(datos_P$Agroipsa_aux)
datos_P$Agroipsa <- as.numeric(datos_P$Agroipsa)



generacion_Datos_Precipita <- ComprehensivePrecipitationGenerator(station=station,
                                                                  prec_all=datos_P,
                                                                  year_min=year_min,
                                                                  year_max=year_max,
                                                                  p=p_prec,
                                                                  n_GPCA_iteration=n_GPCA_iter,
                                                                  n_GPCA_iteration_residuals= n_GPCA_iteration_residuals,
                                                                  exogen=exogen,
                                                                  exogen_sim=exogen_sim,
                                                                  sample="monthly",
                                                                  mean_climate_prec=PREC_CLIMATE,
                                                                  no_spline=FALSE)

#Extraer los valores del llenado

#Tomar los datos de los anos 2015 y 2016
datos_P_2015_2016 <- subset(datos_P, year >= 2015 & year <= 2016)
datos_P_2015_2016$Data <- "Real"

#Indices de los faltantes
indices_P <- which(as.vector(is.na(datos_P_2015_2016$Agroipsa))== TRUE)


#Generado
datos_llenado_P <- generacion_Datos_Precipita$prec_gen

#Escoger los datos que estan llenados
datos_P_2015_2016$Agroipsa[indices_P] <- datos_llenado_P$Agroipsa_aux[indices_P]
datos_P_2015_2016$Data[indices_P] <- "Generated"


#Graficar
datos_P_2015_2016$Date <- paste0(datos_P_2015_2016$year, "-", datos_P_2015_2016$month, "-", datos_P_2015_2016$day)
datos_P_2015_2016$Date <- as.Date(as.character(datos_P_2015_2016$Date), format = "%Y-%m-%d" )


ggplot(datos_P_2015_2016, aes(y=Agroipsa, x=Date, color = Data)) + geom_point() + labs(title="Input value maximum precipitation.", subtitle = "Chiapas, Station Agroipsa")
ggsave("./Graficas/Precipit_llenado.jpg")



#*******************************
#Outliers 
#*******************************

# Inject outliers into data.
cars1 <- cars[1:30, ]  # original data
cars_outliers <- data.frame(speed=c(19,19,20,20,20), dist=c(190, 186, 210, 220, 218))  # introduce outliers.
cars2 <- rbind(cars1, cars_outliers)  # data with outliers.

# Plot of data with outliers.
jpeg('outlier_no.jpg')
par(mfrow=c(1, 2))
plot(cars2$speed, cars2$dist, xlim=c(0, 28), ylim=c(0, 230), main="With Outliers", xlab="speed", ylab="dist", pch="*", col="red", cex=2)
abline(lm(dist ~ speed, data=cars2), col="blue", lwd=3, lty=2)

# Plot of original data without outliers. Note the change in slope (angle) of best fit line.
plot(cars1$speed, cars1$dist, xlim=c(0, 28), ylim=c(0, 230), main="Outliers removed", xlab="speed", ylab="dist", pch="*", col="red", cex=2)
abline(lm(dist ~ speed, data=cars1), col="blue", lwd=3, lty=2)

dev.off()

rm(list=ls())



#Detection outliers
par(mfrow=c(1, 1))
url <- "http://rstatistics.net/wp-content/uploads/2015/09/ozone.csv"  
# alternate source:  https://raw.githubusercontent.com/selva86/datasets/master/ozone.csv
inputData <- read.csv(url)  # import data

outlier_values <- boxplot.stats(inputData$pressure_height)$out  # outlier values.

jpeg('boxplot_pressure.jpg')
boxplot(inputData$pressure_height, main="Pressure Height", outcol="red", col="blue")
dev.off()


#****************
#Cooks distance
#****************

url <- "http://www.biostatisticien.eu/springeR/Birth_weight.xls"
birth.weight <- read.xls(url)
finalmodel <- lm(BWT~ SMOKE + AGE + LWT, data=birth.weight )
jpeg('cook_distance.jpg')
plot (cooks.distance(finalmodel), type ="h")
dev.off()


#*******************
#Welsch-Kuh distance
#*******************

jpeg("\Graficas\welsch.jpg")
plot (abs(dffits(finalmodel)), type ="h")
dev.off()

threshold.fitt <- 2*sqrt((8+1)/(189))
birth.weight$ID[abs(dffits(finalmodel)) >= threshold.fitt]



#*****************
#CART
#*****************

set.seed(123)
data(ptitanic)
str(ptitanic)
tree <- rpart(survived ~ ., data = ptitanic, control = rpart.control(cp = 0.0001))
printcp(tree)

data(ptitanic)
bestcp <- tree$cptable[which.min(tree$cptable[,"xerror"]),"CP"]
tree.pruned <- prune(tree, cp = bestcp)

prp(tree.pruned, faclen = 0, cex = 0.8, extra = 1)





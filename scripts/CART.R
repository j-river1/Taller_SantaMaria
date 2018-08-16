#*****************
#CART
#*****************
library (rpart)
library(partsm)
library(rpart.plot)
library(here)
library(rsq)
library(SDMTools)
install.packages("titanic")


fit1 <- rpart(Reliability ~ Price + Country + Mileage + Type, data = cu.summary, parms = list(split = 'gini'))

#arbol principal 
printcp(fit1)

#Con las mejores rendimientos 
bestcp <- fit1$cptable[which.min(fit1$cptable[,"xerror"]),"CP"]
tree.pruned <- prune(fit1, cp = bestcp)


jpeg(paste0(here("scripts", "Graficas"),"/tree_cars.jpg"))
prp(tree.pruned, faclen = 0, cex = 0.8, extra = 1)
dev.off()

summary(fit1)
summary(fit1, cp=0.06)

#**********************
#RANDOM FOREST
#**********************

library(randomForest)

#organizar los 
data("ptitanic")

#quitar los valores faltantes
datos_titanic <- na.omit(ptitanic)

#Dummys variables 
datos_titanic$Male <- ifelse(datos_titanic$sex == "male", 1, 0)
datos_titanic$Child <- ifelse(datos_titanic$age <= 10, 1, 0)


#regresion is numeric
datos_titanic$Survived <- ifelse(datos_titanic$survived == "died", 0, 1)
datos_titanic$first_class <- ifelse(datos_titanic$pclass == "1st", 1, 0)
datos_titanic$second_class <- ifelse(datos_titanic$pclass == "2nd", 1, 0)
datos_titanic$thrid_class <- ifelse(datos_titanic$pclass == "3rd", 1, 0)


#training set
indexTrain <- sample(x=c(TRUE, FALSE),size=nrow(datos_titanic),replace=TRUE,prob=c(0.8, 0.2))
data_train <- datos_titanic[indexTrain,]

#testing test
data_test <- datos_titanic[!indexTrain,]


formulaRF <- formula(Survived ~ Male + first_class+ second_class + thrid_class + age)
forest  <- randomForest::randomForest(formula=formulaRF, data = data_train)

#Change parameters
#1000 arboles y 1500 rows 
forest <- randomForest(formula= formulaRF, data = datos_titanic,
                       ntree = 1000, mtry = 3, sampsize = 500 )



#prediccion rate
data_test$prediccion <- predict(forest, data_test)
data_test$estado <-ifelse(data_test$prediccion > 0.5, 1, 0)
error <- data_test$estado != data_test$Survived
erro_predict <- sum(ifelse(error== TRUE, 1, 0))/length(error)
















#Neuranal Newwork
#Juan Camilo Rivera
#Example


library("neuralnet")
library("NeuralNetTools")
library(here)
#Data base 

set.seed(12)
raiz_cuadrada <- data.frame(Entrada = seq(1:10), Salida = sqrt(seq(1:10)))

#Entrenar el modelo
model <- neuralnet(formula = Salida ~ Entrada,
                      data = raiz_cuadrada,
                    hidden = 5,
                 threshold = 0.01)

#modelo imprimir

print(model)

jpeg('square_ANN.jpg')
plot(model)
dev.off()

final_output <- cbind(raiz_cuadrada$Entrada, raiz_cuadrada$Salida, as.data.frame(model$net.result))
colnames(final_output) <- c("Entrada", "Salida_Deseada", "Salida_Red")
final_output



set.seed(1)

data = Boston

max_data <- apply(data, 2, max) 
min_data <- apply(data, 2, min)
data_scaled <- scale(data,center = min_data, scale = max_data - min_data) 

index = sample(1:nrow(data),round(0.70*nrow(data)))
train_data <- as.data.frame(data_scaled[index,])
test_data <- as.data.frame(data_scaled[-index,])

n = names(data)
f = as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))
net_data = neuralnet(f,data=train_data,hidden=10,linear.output=T)
plot(net_data)
garson(net_data)
plotnet(net_data)








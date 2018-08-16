#kmeans- herchical methods
#librerias 

library(factoextra)

data("USArrests")
df <- scale(USArrests)

#Choose number of cluster

jpeg('optimal_cluster.jpg')
fviz_nbclust(df, kmeans, method= "wss") + geom_vline(xintercept = 4, linetype=2)
dev.off()

km_res <- kmeans(df, 4, nstart = 25)
km_res

#Calcular la media por cada cluster

aggregate(USArrests, by = list(cluster=km_res$cluster), mean)

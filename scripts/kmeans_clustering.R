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

#adicionar al cluster original 

dd <- cbind(USArrests, cluster= km_res$cluster)
km_res$centers
km_res$size

jpeg('cluster_diagrama.jpg')
fviz_cluster(km_res, data =df, palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),
             ellipse.type = "euclid",
             star.plot = TRUE,
             repel = TRUE,
             ggtheme = theme_minimal())
dev.off()
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


#Clustering Hierarchical


#libraries 
library("factoextra")

#load the data 
data("USArrests")

df <- scale(USArrests)

#df <- df[1:10]
head(df)

#Similaridad o desiguales 

x <- c(1,2)
y <- c(2,4)

dist_xy <- data.frame(x = x, y= y)

plot(x, y, col= "red", pch=15)

#diferent methods
dist_point <- dist(dist_xy, method = "euclidean")
dist_point <- dist(dist_xy, method = "maximum")

res_dist <- dist(df, method = "euclidean")
head(res_dist)

as.matrix(res_dist)[1:6,1:6]
res_hc <- hclust( d = res_dist, method = "single")


#jpeg("ddad.png")
fviz_dend(res_hc, cex=0.5)
#dev.off()

jpeg("ddad.png")
res_hc <- hclust( d = res_dist, method = "complete")
fviz_dend(res_hc, cex=0.5)
dev.off()


res_hc <- hclust( d = res_dist, method = "complete")
fviz_dend(res_hc, cex=0.5)


res_hc <- hclust( d = res_dist, method = "average")
fviz_dend(res_hc, cex=0.5)

#verify cluster tree
res_coph <- cophenetic(res_hc)
cor(res_dist , res_coph)

#podemos cambiar la distancia con method
#cortar el arbol en cuatro

grp <- cutree (res_hc, k=4)
head(grp)

jpeg("dendograma_groups.png")
fviz_dend(res_hc, k=4,
          cex= 0.5,
          k_colors = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),
          color_labels_by_k = TRUE,
          rect= TRUE
          )
dev.off()

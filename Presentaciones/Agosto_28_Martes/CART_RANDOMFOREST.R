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


jpeg("tree_CART.jpg")
prp(tree.pruned, faclen = 0, cex = 0.8, extra = 1)
dev.off()
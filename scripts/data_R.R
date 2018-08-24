#R as calculadora

#Operaciones. R as calculadora
library(MASS)


2*(-3.2)
2(-3,2)
5^2
5**2
sin(2*pi/3)
log(1)
c(1,2,3,4,5)
c(1,2,3,4,5)*2

#Asignacion de variables 
#Continuacion de la consola
2*
3

x <- sin(2*pi/3)
sin(2*pi/3) -> x
y <- .Last.value
rm(y)
remove(y)

#asignacion de variables con caracteres
value <- "Hello world"
#mayusculas y minisculas 
Value <- "Hello world"

#Espacios
value <- "Hello  world"


#Main function 
attach(Cars93)
search()
names(Cars93)
find("Cars93")


#Principal functions 
value <- 12
string <- "Hello"
2<4
cn <- 4 + 4i

#functions
mode(value)
mode(string)
mode(cn)
names(Cars93)

#vectors

value_num  <- c(1,2,3,5)
value_char <- c("koala", "kangaroo", "elephant")
value_logical <- c(F, T, T,T)
value_logical2 <- c(FALSE, TRUE, TRUE,TRUE)

error_vector <- c(value_num, value_char)

value_seq <- seq(from = 2, to = 10, by =2 )
value_logical <- c(1,2,3, rep(3,4), seq(from=1, to=6, by=2))

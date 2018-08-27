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


#Dates
dates <- c("92/27/02", "92/02/27", "92/01/14",
                        +"92/02/28", "92/02/01")
dates <- as.Date(dates, "%y/%m/%d")
dates
class(dates)

#time series 
ts(1:12, frequency = 12, start = c(1959, 1))



#matrices 
set.seed(12)
value <- rnorm(6)
dim (value) <- c(2,3)
matrix(value, 2, 3)

#llenado por filas 
matrix(value, 2, 3, byrow=T)

#llenado por columnas
matrix <- matrix(value, 2, 3, byrow=F)


#data frame
BMI <- data.frame(Gender = c("M", "F", "M", "F"),
                    Height = c(1.83, 1.76, 1.82, 1.60),
                    Weight = c(67, 58, 48, 76),
                    row.names = c("Jack", "Julia", "Henry", "Emma"))
#marix as data.frame

data_frame <- data.frame(matrix)

#acceder a vector o matrix. Muestra aleatoria 
x <- sample(1:5, 20, T)
x == 1
ones <- x == 1
x[ones]<-0
other <- x > 1
x[other]
which(x > 1)



#Acceder a data frame
BMI[,"Gender"] <- "M"

#Acceder por fila
BMI[1,] <- 0

#llenar la data frame
BMI[] <- 1:12 

#Acceder a mas filas
BMI[1:2,] 


#Acceder a mas columnas
BMI[,1:2] 

#Operations data frames and matrices 

cbind(1:4,5:8)
X1 <- data.frame(Id=1:4,GENDER=c("M","F","F","M"),Weight=c(75,68,48,72))
X2 <- data.frame(Id=1:4,GENDER=c("M","F","F","M"),Height=c(182,165,160,178))
cbind(X1,X2)
merge(X1,X2)
X3 <- data.frame(Id=c(2,1,4,3),GENDER=c("F","M","M","F"), Height=c(165,182,178,160))
merge(X1, X3)

X <- data.frame(Id=1:4,GENDER=c("M","F","F","M"),Weight=c(75,68,48,72),Income=c(80,90,60,50))
Y <- data.frame(Id=1:4,GENDER=c("M","F","F","M"),Height=c(182,165,160,178),Salary=c(70,90,40,40))

merge(X,Y,by=c("GENDER","Weight"))
merge(X,Y,by=c("GENDER","Weight"),all=TRUE)


#rbind y cbind

rbind(1:4,5:8)
df1 <- data.frame(A=1:5, B=LETTERS[1:5])
df2 <- data.frame(A=6:10, E=letters[1:5])
smartbind(df1, df2)


rbind(1:4,5:8)
X <- matrix(c(1:4, 1, 6:8), nr = 2)
apply(X, MARGIN=1, FUN=mean)
apply(X, MARGIN=2, FUN=sum)




















#Read the tables 

#scan 
# Reading variable names:
variable.names <- scan("intima_media.txt",skip=4,nlines=1,what="")
# Reading data:
data <- scan("intima_media.txt",skip=7,dec=",")
mytable <- as.data.frame(matrix(data,ncol=9,byrow=TRUE))
colnames(mytable) <- variable.names




#read table
mydata <- read.table("Intima_Media_Thickness.txt",sep=" ",
                     header=TRUE,dec=",")
mydata
# To display the content of mydata.
head(mydata)
# Only displays the first few rows
# of the data.frame.
attach(mydata)
mean(AGE)
# Mean of age.
var(taille) # Variance of the heights.

read.csv(file.choose())
# To read comma-separated data
# (with a . as decimal mark).
read.csv2(file.choose()) # To read semi-colon-separated data
# (with a , as decimal mark).
To read Tab-separated data, it is better to use
read.delim(file.choose()) # (with a . as decimal mark).
read.delim2(file.choose())# (with a , as decimal mark).








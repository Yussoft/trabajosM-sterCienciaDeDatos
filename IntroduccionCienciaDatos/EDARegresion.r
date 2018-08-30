library(ggplot2)
library(corrplot)
library(car)
library(dplyr)
library(tidyr)
library(moments)
library(reshape2)
library(caret)
set.seed(77183983)

# Se establece el path y se lee el fichero
datapath = "C://M?ster//IntroCienciaDatos//Datasets Regresion//autoMPG6"
data = read.csv(paste0(datapath,"//autoMPG6.dat"), header = FALSE, skip = 10)

# Se cambian los nombres de las variables
colnames(data) <- c("Displacement", "HorsePower", "Weight", "Acceleration", "ModelYear", "Mpg")

# Usando str vemos la estructura del set y los tipos de las variables
print("Data structure:")
str(data)

# Primer vistazo a los datos
print("Summary:")
print(summary(data))

# Boxplots
boxplot(data)
boxplot(data[,c(1,2)])
boxplot(data[,c(3)], xlab=("Weight"))
boxplot(data[,c(4)], xlab=("Acceleration"))
boxplot(data[,c(5)], xlab=("ModelYear"))

# Estudio de correlacion entre entradas y salida
plot(Displacement~Mpg, data)
plot(HorsePower~Mpg, data)
plot(Weight~Mpg, data)
plot(Acceleration~Mpg, data)
plot(ModelYear~Mpg, data)

# Matriz de correlacion
corrplot.mixed(cor(data), upper="color", lower = "number")

# ScatterPlot Matrix
scatterplotMatrix(~Displacement+HorsePower+Weight+Acceleration+ModelYear+Mpg, data=data, 
                  col=palette()[1])

# Estudio de skewness y Kurtosis
sk = skewness(data)
kurtosis = kurtosis(data)

# Funcion de normalizacion
normalize <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}

# Normalizacion de una copia del set
norm_data <- data.frame(data)
norm_data["Displacement"] <- as.data.frame(apply(norm_data["Displacement"], 2, normalize))
norm_data["HorsePower"] <- as.data.frame(apply(norm_data["HorsePower"],2, normalize))
norm_data["Weight"] <- as.data.frame(apply(norm_data["Weight"], 2, normalize))
norm_data["Acceleration"] <- as.data.frame(apply(norm_data["Acceleration"], 2, normalize))
norm_data["ModelYear"] <- as.data.frame(apply(norm_data["ModelYear"], 2, normalize))
norm_data["Mpg"] <- as.data.frame(apply(norm_data["Mpg"], 2, normalize))

# Boxplot normalizado
aux <- gather(norm_data, var, value)
ggplot(aux, aes(y=value, x=factor(var)))+geom_boxplot(aes(fill=factor(var)))

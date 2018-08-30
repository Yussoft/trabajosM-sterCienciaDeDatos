library(ggplot2)
library(corrplot)
library(car)
library(dplyr)
library(tidyr)
library(moments)
library(reshape2)
library(caret)
library(randomForest)
set.seed(77183983)

# Se establece el path y se lee el fichero
datapath = "C:/Users/Yus/Google Drive/Master/IntroCienciaDatos/Datasets Clasificacion/vehicle"
data = read.csv(paste0(datapath,"//vehicle.dat"), comment.char = "@")

# Se cambian los nombres de las variables
colnames(data) <- c("Compactness","Circularity", "Distance_circularity", "Radius_ratio",
                    "Praxis_aspect_ratio", "Max_length_aspect_ratio", "Scatter_ratio", 
                    "Elongatedness", "Praxis_rectangular", "Length_rectangular", "Major_variance", 
                    "Minor_variance", "Gyration_radius", "Major_skewness", "Minor_skewness", 
                    "Minor_kurtosis", "Major_kurtosis", "Hollows_ratio", "Class")

# As we can see with str(), all the variables are numeric.
print("Data structure:")
str(data)

# Primer vistazo a los datos
print("Summary:")
print(summary(data))

# Eliminamos variables con poco peso en el problema
# según RandomForest y su selección de variables
rf <- randomForest(formula = Class~., data=data)
ranking <- varImp(rf)
variables <- rownames(ranking)

# Obtenemos los indices de los nombres de las variables ordenadas
# segun relevancia  en el ranking
index = sort(ranking$Overall, decreasing=TRUE, index.return=TRUE)
variables <- variables[index$ix]
variables.seleccionadas <- variables[1:10]

# Nos quedamos con las que nos interesan
data.var <- data[,variables.seleccionadas]
data.var["Class"] <- data$Class

# Gráficos de apoyo
pairs(data.var[,-11], main = "ScatterPlot de las variables",
      pch = 21, bg = c("red", "green3", "blue")[unclass(data.var$Class)])

corr <- cor(data.var[,-11])
corrplot.mixed(corr, outline = TRUE, tl.cex = 0.6,
               lower.col = "black", lower="number", upper="shade")

# Gráficos de densidad
p1 <- ggplot(data.var, aes(Max_length_aspect_ratio))+geom_density(aes(fill=factor(Class), alpha=0.5))

p2 <- ggplot(data.var, aes(Minor_variance))+geom_density(aes(fill=factor(Class), alpha=0.5))

p3 <- ggplot(data.var, aes(Length_rectangular))+geom_density(aes(fill=factor(Class), alpha=0.5))

p4 <- ggplot(data.var, aes(Major_variance))+geom_density(aes(fill=factor(Class), alpha=0.5))

p5 <- ggplot(data.var, aes(Elongatedness))+geom_density(aes(fill=factor(Class), alpha=0.5))

p6 <- ggplot(data.var, aes(Distance_circularity))+geom_density(aes(fill=factor(Class), alpha=0.5))

p7 <- ggplot(data.var, aes(Scatter_ratio))+geom_density(aes(fill=factor(Class), alpha=0.5))

p8 <- ggplot(data.var, aes(Compactness))+geom_density(aes(fill=factor(Class), alpha=0.5))

p9 <- ggplot(data.var, aes(Hollows_ratio))+geom_density(aes(fill=factor(Class), alpha=0.5))

p10 <- ggplot(data.var, aes(Praxis_aspect_ratio))+geom_density(aes(fill=factor(Class), alpha=0.5))

require(ggpubr)

# Imprimir todas las gráficas juntas.
ggarrange(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,ncol=2,nrow =5)

# Funcion de normalizacion
normalize <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}

# Se crea una copia del set y se normalizan las columnas
norm_data <- data.frame(data.var)
norm_data["Max_length_aspect_ratio"] <- as.data.frame(apply(norm_data["Max_length_aspect_ratio"], 2, normalize))
norm_data["Minor_variance"] <- as.data.frame(apply(norm_data["Minor_variance"],2, normalize))
norm_data["Length_rectangular"] <- as.data.frame(apply(norm_data["Length_rectangular"], 2, normalize))
norm_data["Major_variance"] <- as.data.frame(apply(norm_data["Major_variance"], 2, normalize))
norm_data["Elongatedness"] <- as.data.frame(apply(norm_data["Elongatedness"], 2, normalize))
norm_data["Distance_circularity"] <- as.data.frame(apply(norm_data["Distance_circularity"], 2, normalize))
norm_data["Scatter_ratio"] <- as.data.frame(apply(norm_data["Scatter_ratio"], 2, normalize))
norm_data["Compactness"] <- as.data.frame(apply(norm_data["Compactness"], 2, normalize))
norm_data["Hollows_ratio"] <- as.data.frame(apply(norm_data["Hollows_ratio"], 2, normalize))
norm_data["Praxis_aspect_ratio"] <- as.data.frame(apply(norm_data["Praxis_aspect_ratio"], 2, normalize))

# Boxplots
aux <- gather(data.var[,-c(11)], var, value)
ggplot(aux, aes(y=value))+geom_boxplot(aes(fill=factor(var)))

aux2 <- gather(norm_data[,-c(11)], var, value)
ggplot(aux2, aes(y=value))+geom_boxplot(aes(fill=factor(var)))

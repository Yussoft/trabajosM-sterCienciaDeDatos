library(ggplot2)
library(corrplot)
library(car)
library(dplyr)
library(tidyr)
library(moments)
library(reshape2)
library(caret)
library(class)
set.seed(77183983)

# Leer los datos
datapath = "C:/Users/Yus/Google Drive/Master/IntroCienciaDatos/Datasets Clasificacion/vehicle"
data = read.csv(paste0(datapath,"//vehicle.dat"), comment.char = "@")

# Cambiar el nombre de las variables
colnames(data) <- c("Compactness","Circularity", "Distance_circularity", "Radius_ratio",
                    "Praxis_aspect_ratio", "Max_length_aspect_ratio", "Scatter_ratio", 
                    "Elongatedness", "Praxis_rectangular", "Length_rectangular", "Major_variance", 
                    "Minor_variance", "Gyration_radius", "Major_skewness", "Minor_skewness", 
                    "Minor_kurtosis", "Major_kurtosis", "Hollows_ratio", "Class")

# Se comienza con el modelo KNN, se trata de buscar el mejor valor de k.
# Para ello definimos la función de validación cruzada primero.

kfold_cv_knn <- function(iter, k, tt= "test") {
  
  file <-paste0(datapath,"//vehicle-10-", iter, "tra.dat", sep="") 
  # print(paste0("Read:",file))
  x_tra<-read.csv(file, comment.char="@", header=F)
  file <-paste0(datapath,"//vehicle-10-", iter, "tst.dat", sep="")
  # print(paste0("Read:",file))
  x_tst<-read.csv(file, comment.char="@", header=F) 
  
  # Se aniaden los nombres de todas las variables
  names <- c("Compactness","Circularity", "Distance_circularity", "Radius_ratio",
             "Praxis_aspect_ratio", "Max_length_aspect_ratio", "Scatter_ratio", 
             "Elongatedness", "Praxis_rectangular", "Length_rectangular", "Major_variance", 
             "Minor_variance", "Gyration_radius", "Major_skewness", "Minor_skewness", 
             "Minor_kurtosis", "Major_kurtosis", "Hollows_ratio", "Class")
  names(x_tst) <- names
  names(x_tra) <- names
  
  
  # Aniadimos las variables que se escogieron en el EDA
  variables <- c("Max_length_aspect_ratio","Minor_variance", "Length_rectangular", "Major_variance",
                 "Elongatedness","Distance_circularity", "Scatter_ratio", "Compactness","Hollows_ratio",
                 "Praxis_rectangular","Class")
  # Filtramos las variables que no queremos
  x_tra <- x_tra[,names(x_tra) %in% variables]
  x_tst <- x_tra[,names(x_tra) %in% variables]
  
  # En función de si empleamos train o test para evaluar resultados
  if (tt == "train"){ 
    test <- x_tra 
  } else if(tt == "test") { 
    test <- x_tst 
  } 
  
  # Prediccion de knn
  pred <- knn(train = x_tra[,-ncol(x_tra)], test = test[,-ncol(test)], cl = x_tra$Class, k = k)
  # % de acierto
  length(pred[pred==test[,ncol(test)]])/length(pred)
}

test_k <- function(k, test = "test"){
  # kfold_cv_knn <- fuunction(iter, k, tt= "test")
  # mean(sapply(1:10, kfold_cv_knn, k=k, tt=test))
  mean(sapply(1:10, kfold_cv_knn, k=k, tt=test))
}

# Ejecutamos train y test
train.results <- sapply(1:17, test_k, "train")
test.results <- sapply(1:17, test_k, "test")

# Se unen y se preparan los resultados para la gráfica
resultados <- data.frame(train.results, test.results)
k_probadas <- as.factor(1:17)

aux <- gather(resultados, var, value)
# Mostramos los resultados
ggplot(aux, aes(x=rep(k_probadas,2), y=value, group=var, col=var))+geom_line(size=1.5)+geom_point(size=3, fill="white")

library(reshape2)
library(MASS)
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

kfold_cv_LDA <- function(iter, tt= "test") {
  
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
  # variables <- c("Max_length_aspect_ratio","Minor_variance", "Length_rectangular", "Major_variance",
  #                "Elongatedness","Distance_circularity", "Scatter_ratio", "Compactness","Hollows_ratio",
  #                "Praxis_rectangular","Class")
  
  # Variables sin correlaciones
  variables <- c("Compactness","Circularity", "Distance_circularity", "Radius_ratio",
             "Praxis_aspect_ratio", "Max_length_aspect_ratio", "Scatter_ratio",
             "Elongatedness", "Praxis_rectangular", "Length_rectangular", "Major_variance",
             "Minor_variance", "Gyration_radius", "Major_skewness", "Minor_skewness",
             "Minor_kurtosis", "Major_kurtosis", "Hollows_ratio", "Class")


  # Filtramos las variables que no queremos
  x_tra <- x_tra[,names(x_tra) %in% variables]
  x_tst <- x_tra[,names(x_tra) %in% variables]
  x_tra[,-ncol(x_tra)] <- scale(x_tra[,-ncol(x_tra)], center=TRUE, scale=TRUE)
  x_tst[,-ncol(x_tra)] <- scale(x_tst[,-ncol(x_tst)], center=TRUE, scale=TRUE)

  # En función de si empleamos train o test para evaluar resultados
  if (tt == "train"){ 
    test <- x_tra 
  } else if(tt == "test") { 
    test <- x_tst 
  } 
  
  # Prediccion de knn
  lda.model <- lda(Class~., data = x_tra)
  pred <- predict(lda.model, test)
  # % de acierto
  length(pred[pred$class==test[,ncol(test)]])/length(pred$class)
}

# Ejecutamos train y test
train.results <- mean(sapply(1:10, kfold_cv_LDA, tt="train"))
test.results <- mean(sapply(1:10, kfold_cv_LDA, tt="test"))

# Se unen y se preparan los resultados para la gráfica
resultados <- data.frame(train.results, test.results)
print(resultados)

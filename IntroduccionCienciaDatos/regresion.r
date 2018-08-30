library(ggplot2)
library(corrplot)
library(car)
library(dplyr)
library(tidyr)
library(moments)
library(reshape2)
library(caret)
set.seed(77183983)

# Read the data

datapath = "C://Users//Yus//Google Drive//Master//IntroCienciaDatos//Datasets Regresion//autoMPG6"
data = read.csv(paste0(datapath,"//autoMPG6.dat"), header = FALSE, skip = 10)

# Change the names of the variables
colnames(data) <- c("Displacement", "HorsePower", "Weight", "Acceleration", "ModelYear", "Mpg")

# Normalize max-min function.
normalize <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}

# Copy the data into a new variable an normalize all the columns
norm_data <- data.frame(data)
norm_data["Displacement"] <- as.data.frame(apply(norm_data["Displacement"], 2, normalize))
norm_data["HorsePower"] <- as.data.frame(apply(norm_data["HorsePower"],2, normalize))
norm_data["Weight"] <- as.data.frame(apply(norm_data["Weight"], 2, normalize))
norm_data["Acceleration"] <- as.data.frame(apply(norm_data["Acceleration"], 2, normalize))
norm_data["ModelYear"] <- as.data.frame(apply(norm_data["ModelYear"], 2, normalize))
norm_data["Mpg"] <- as.data.frame(apply(norm_data["Mpg"], 2, normalize))

# Fit a regression model for each variables without normalization, for ordinary least squares it is invariant.
fitDisplacement <- lm(Mpg~Displacement, data=data)
sumDisplacement <- summary(fitDisplacement)

fitHorsePower <- lm(Mpg~HorsePower, data=data)
sumHorsePower <- summary(fitHorsePower)

fitWeight <- lm(Mpg~Weight, data=data)
sumWeight <- summary(fitWeight)

fitAcceleration <- lm(Mpg~Acceleration, data=data)
sumAcceleration <- summary(fitAcceleration)

fitModelYear <- lm(Mpg~ModelYear, data=data)
sumModelYear <- summary(fitModelYear)

lm_fold <- function(iter, formula, tt= "test") {
  
  # Load the required test or train data fold
  file <-paste(paste0(datapath,"//autoMPG6-5-", iter, "tra.dat", sep=""))
  x_tra<-read.csv(file, comment.char="@")
  file <-paste(paste0(datapath,"//autoMPG6-5-", iter, "tst.dat", sep=""))
  x_tst<-read.csv(file, comment.char="@")
  
  # Add names
  names(x_tst) <- c("Displacement", "HorsePower", "Weight", "Acceleration", "ModelYear", "Mpg")
  names(x_tra) <- c("Displacement", "HorsePower", "Weight", "Acceleration", "ModelYear", "Mpg")
  
  if (tt== "train") {
    test <-x_tra
  }
  else {
    test <-x_tst
  }
  
  fitlm=lm(formula,data=x_tra)
  # print(summary(fitlm))
  yprime=predict(fitlm,test)
  # print(test$Mpg)
  # print(yprime)
  # Return the RMSE measure for the given fold
  sqrt(sum(abs(test$Mpg-yprime)^2)/length(yprime))
}

RMSE.Test <- c()
RMSE.Training <- c()

# Train and validate the models for each variable
RMSE.Training <- c(RMSE.Training,mean(sapply(1:5, lm_fold, Mpg~Displacement,"train")))
RMSE.Training <- c(RMSE.Training,mean(sapply(1:5, lm_fold, Mpg~HorsePower,"train")))
RMSE.Training <- c(RMSE.Training,mean(sapply(1:5, lm_fold, Mpg~Weight,"train")))
RMSE.Training <- c(RMSE.Training,mean(sapply(1:5, lm_fold, Mpg~Acceleration,"train")))
RMSE.Training <- c(RMSE.Training,mean(sapply(1:5, lm_fold, Mpg~ModelYear, "train")))
RMSE.Test <- c(RMSE.Test,mean(sapply(1:5, lm_fold, Mpg~Displacement,"test")))
RMSE.Test <- c(RMSE.Test,mean(sapply(1:5, lm_fold, Mpg~HorsePower,"test")))
RMSE.Test <- c(RMSE.Test,mean(sapply(1:5, lm_fold, Mpg~Weight,"test")))
RMSE.Test <- c(RMSE.Test,mean(sapply(1:5, lm_fold, Mpg~Acceleration,"test")))
RMSE.Test <- c(RMSE.Test,mean(sapply(1:5, lm_fold, Mpg~ModelYear,"test")))

# Modelos lineales m?ltiples
multlm <- lm(Mpg~., data=data)
sumMult <- summary(multlm)

WMlm <- lm(Mpg~Weight+ModelYear, data=data)
sumWMlm <- summary(WMlm)

wminterlm <- lm(Mpg~Weight*ModelYear, data=data)
sumwminterlm <- summary(wminterlm)

# Interacciones y no linealidad
model.quadratic.WM <- lm(Mpg~(Weight*ModelYear), data)
sumQuadWM <- summary(model.quadratic.WM)

inter.nolineal <- lm(Mpg~ ModelYear +I(Weight*ModelYear)+I(Weight^2 * ModelYear), data)
sumInterNoL <- summary(inter.nolineal)

# kfold CV for multiple regression models
RMSE.Test.M <- c()
RMSE.Training.M <- c()

RMSE.Training.M <- c(RMSE.Training.M,mean(sapply(1:5, lm_fold, Mpg~.,"train")))
RMSE.Training.M <- c(RMSE.Training.M,mean(sapply(1:5, lm_fold, Mpg~Weight+ModelYear,"train")))
RMSE.Training.M <- c(RMSE.Training.M,mean(sapply(1:5, lm_fold, Mpg~Weight*ModelYear,"train")))
RMSE.Training.M <- c(RMSE.Training.M,mean(sapply(1:5, lm_fold, 
                                                 Mpg~ ModelYear +I(Weight*ModelYear)+I(Weight^2 * ModelYear),
                                                 "train")))

RMSE.Test.M <- c(RMSE.Test.M,mean(sapply(1:5, lm_fold, Mpg~.,"test")))
RMSE.Test.M <- c(RMSE.Test.M,mean(sapply(1:5, lm_fold, Mpg~Weight+ModelYear,"test")))
RMSE.Test.M <- c(RMSE.Test.M,mean(sapply(1:5, lm_fold, Mpg~Weight*ModelYear,"test")))
RMSE.Test.M <- c(RMSE.Test.M,mean(sapply(1:5, lm_fold, 
                                         Mpg~ ModelYear +I(Weight*ModelYear)+I(Weight^2 * ModelYear),
                                         "test")))

# KNN for regression
require(kknn)

# A k-fold CV function for KNN is 
knn_cvfold <- function(iter, formula, k=7, tt= "test") {
  
  # Load the required test or train data fold
  file <-paste(paste0(datapath,"//autoMPG6-5-", iter, "tra.dat", sep=""))
  x_tra<-read.csv(file, comment.char="@")
  file <-paste(paste0(datapath,"//autoMPG6-5-", iter, "tst.dat", sep=""))
  x_tst<-read.csv(file, comment.char="@")
  
  # Add names
  names(x_tst) <- c("Displacement", "HorsePower", "Weight", "Acceleration", "ModelYear", "Mpg")
  names(x_tra) <- c("Displacement", "HorsePower", "Weight", "Acceleration", "ModelYear", "Mpg")
  
  if (tt== "train") {
    test <-x_tra
  }
  else {
    test <-x_tst
  }
  
  knnfit=kknn(formula,x_tra,test,k=k) 
  yprime=knnfit$fitted.values
  # Return the RMSE measure for the given fold
  sqrt(sum(abs(test$Mpg-yprime)^2)/length(yprime))
}

KNN.train <- c()
KNN.test <- c()

# KNN with all the variables
KNN.train <- c(KNN.train, mean(sapply(1:5,knn_cvfold,Mpg~.,7, "train")))
KNN.test <- c(KNN.test, mean(sapply(1:5,knn_cvfold,Mpg~., 7, "test")))
# KNN with Weight+ModelYear
KNN.train <- c(KNN.train, mean(sapply(1:5,knn_cvfold,Mpg~Weight+ModelYear, 7, "train")))
KNN.test <- c(KNN.test, mean(sapply(1:5,knn_cvfold,Mpg~Weight+ModelYear, 7, "test")))
# KNN with interaction
KNN.train <- c(KNN.train, mean(sapply(1:5,knn_cvfold,Mpg~Weight*ModelYear, 7, "train")))
KNN.test <- c(KNN.test, mean(sapply(1:5,knn_cvfold,Mpg~Weight*ModelYear, 7, "test")))
#KNN with interactions and non-linearity
KNN.train <- c(KNN.train, mean(sapply(1:5,knn_cvfold,
                                      Mpg~ModelYear +I(Weight*ModelYear)+I(Weight^2 * ModelYear),
                                      7, "train")))
KNN.test <- c(KNN.test, mean(sapply(1:5,knn_cvfold,
                                    Mpg~ModelYear +I(Weight*ModelYear)+I(Weight^2 * ModelYear),
                                    7, "test")))

# Load the regression results for the rest of the datasets
ruta_resultados <- "C://Users//Yus//Google Drive//Master//IntroCienciaDatos//"
reg_train_results <- read.csv(paste0(ruta_resultados,"regr_train_alumnos.csv"), sep = ";")
reg_test_results <- read.csv(paste0(ruta_resultados,"regr_test_alumnos.csv"), sep = ";")

# Change the results for Mpg6 with ours
reg_test_results$out_test_lm[[3]] <- 2.924419^2 
reg_train_results$out_train_lm[[3]] <- 2.95144^2 
reg_test_results$out_test_kknn[[3]] <- 1.877867^2
reg_train_results$out_train_kknn[[3]]<- 2.755446^2

# Compare lm(other) to knn(ref) train
dif_train <- (reg_train_results$out_train_lm - reg_train_results$out_train_kknn) / 
  reg_train_results$out_train_lm 

dif_test <- (reg_test_results$out_test_lm - reg_test_results$out_test_kknn) / 
  reg_test_results$out_test_lm 

wilcox_train <- cbind(ifelse (dif_train<0, abs(dif_train)+0.1, 0+0.1), ifelse (dif_train>0, abs(dif_train)+0.1, 0+0.1)) 
wilcox_test <- cbind(ifelse (dif_test<0, abs(dif_test)+0.1, 0+0.1), ifelse (dif_test>0, abs(dif_test)+0.1, 0+0.1)) 

colnames(wilcox_train) <- c(colnames(reg_train_results)[2], colnames(reg_train_results)[3])
colnames(wilcox_test) <- c(colnames(reg_test_results)[2], colnames(reg_test_results)[3])
LM.KNN.train<-wilcox.test( wilcox_train[,1], wilcox_train[,2],alternative = "two.sided", paired=TRUE)
LM.KNN.test<-wilcox.test( wilcox_test[,1], wilcox_test[,2],alternative = "two.sided", paired=TRUE)

# Test de friedman y holm
friedman.train <- friedman.test(as.matrix(reg_train_results[,-c(1)])) 
friedman.test <- friedman.test(as.matrix(reg_test_results[,-c(1)]))

# Holm train
tam <-dim(reg_train_results[,-c(1)]) 
groups <-rep(1:tam[2], each=tam[1])
pairwise.wilcox.test(as.matrix(reg_train_results[,-c(1)]), groups, p.adjust= "holm", paired = TRUE)

# Holm test
tam <-dim(reg_test_results[,-c(1)]) 
groups <-rep(1:tam[2], each=tam[1])
pairwise.wilcox.test(as.matrix(reg_test_results[,-c(1)]), groups, p.adjust= "holm", paired = TRUE)



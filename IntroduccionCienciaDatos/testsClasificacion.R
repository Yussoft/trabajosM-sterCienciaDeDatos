
# Load the regression results for the rest of the datasets
ruta_resultados <- "C://Users//Yus//Google Drive//Master//IntroCienciaDatos//"
clasif_train_results <- read.csv(paste0(ruta_resultados,"clasif_train_alumnos.csv"), sep = ";")
clasif_test_results <- read.csv(paste0(ruta_resultados,"clasif_test_alumnos.csv"), sep = ";")

# Change the results for Mpg6 with ours
clasif_train_results$out_train_knn[17] <- 0.8209853    
clasif_train_results$out_train_lda[17] <- 0.7989229
clasif_train_results$out_train_qda[17] <- 0.9123989
clasif_test_results$out_test_knn[17]<- 0.8204630
clasif_test_results$out_test_lda[17] <- 0.7989229
clasif_test_results$out_test_qda[17] <- 0.9123989

# Compare lm(other) to knn(ref) train
LDAvsKNNtrain <- wilcox.test(clasif_train_results$out_train_knn, clasif_train_results$out_train_lda, alternative="two.sided", paired=T)
LDAvsKNNtest <- wilcox.test(clasif_test_results$out_test_knn, clasif_test_results$out_test_lda, alternative="two.sided", paired=T)

QDAvsKNNtrain <- wilcox.test(clasif_train_results$out_train_knn, clasif_train_results$out_train_qda, alternative="two.sided", paired=T)
QDAvsKNNtest <- wilcox.test(clasif_test_results$out_test_knn, clasif_test_results$out_test_qda, alternative="two.sided", paired=T)

QDAvsLDAtrain <- wilcox.test(clasif_train_results$out_train_lda, clasif_train_results$out_train_qda, alternative="two.sided", paired=T) 
QDAvsLDAtest <- wilcox.test(clasif_test_results$out_test_lda, clasif_test_results$out_test_qda, alternative="two.sided", paired=T)

clasif_train_results <- clasif_train_results[,-1]
clasif_test_results <- clasif_test_results[,-1] 
tam <- dim(clasif_train_results) 
groups <- rep(1:tam[2],each=tam[1]) 
pairwise.wilcox.test(x=as.matrix(clasif_train_results),groups,p.adjust="holm",paired=T)
tam <- dim(clasif_test_results) 
groups <- rep(1:tam[2],each=tam[1]) 
pairwise.wilcox.test(x=as.matrix(clasif_test_results),groups,p.adjust="holm",paired=T)


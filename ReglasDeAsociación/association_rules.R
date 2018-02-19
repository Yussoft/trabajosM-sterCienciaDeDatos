library(arules)
library(mlbench) # Zoo dataset

data(Zoo) # Cargamos el dataset Zoo

# Transformamos en factor todos las variables booleanas
Zoo$hair <- as.factor(Zoo$hair)
Zoo$feathers <- as.factor(Zoo$feathers)
Zoo$eggs <- as.factor(Zoo$eggs)
Zoo$milk <- as.factor(Zoo$milk)
Zoo$airborne <- as.factor(Zoo$airborne)
Zoo$aquatic <- as.factor(Zoo$aquatic)
Zoo$predator <- as.factor(Zoo$predator)
Zoo$toothed <- as.factor(Zoo$toothed)
Zoo$backbone <- as.factor(Zoo$backbone)
Zoo$breathes <- as.factor(Zoo$breathes)
Zoo$venomous <- as.factor(Zoo$venomous)
Zoo$fins <- as.factor(Zoo$fins)
# Zoo$legs <- as.factor(Zoo$legs) Con leg hacemos una discretización 
Zoo$tail <- as.factor(Zoo$tail)
Zoo$domestic <- as.factor(Zoo$domestic)
Zoo$catsize <- as.factor(Zoo$catsize)

# Realizamos un corte donde los animales con 0 patas se clasifican como no_legs
# y los animales con un número de patas mayor que 0 como has_legs
Zoo$legs <- ordered(cut(Zoo$legs,c(-Inf,0,Inf)), 
                    labels = c("no_legs","has_legs"))

Zoo <- as(Zoo, "transactions")
summary(Zoo)

# Con el uso de summary podemos ver que los items más frecuentes son:
# 1. no venenoso
# 2. no domésticos
# 3. no tienen branquias
# 4. tienen columna vertebral
# 5. no tienen plumas

# A continuación vemos la frecuencia de los items que superan el soporte mínimo 
# de 0.1 

itemFrequencyPlot(Zoo, support = 0.1, cex.names = 0.8)

# Como se puede ver en la gráfica, comprobamos que los item sets más frecuentes 
# son los que hemos listado arriba con la ayuda de summary()

item_freq <- apriori(Zoo, parameter = list(support = 0.1 , 
                                                       target = "frequent"))
item_freq <- sort(item_freq, by = "support")

# En este gráfico podemos ver la frecuencia que hay de itemsets para cada
# tamaño.
barplot(table(size(item_freq)), xlab = "Itemset size", ylab="Count")


# Debido a que los itemSets frecuenctes pueden ser demasiados, buscamos otros 
# conjuntos iniciales de generación de reglas como los maximales o cerrados.

item_sets_maximales <- item_freq[is.maximal(item_freq)]
item_sets_cerrados <- item_freq[is.closed(item_freq)]

# Con este gráfico podemos ver la cantidad de itemsets frecuentes con soporte 
# 0.1 frente a los cerrados y maximales.
barplot(c(frequent=length(item_freq), closed = length(item_sets_cerrados), 
          maximal = length(item_sets_maximales)), xlab = "itemsets", 
        ylab = "count")

# Una vez tenemos diferentes conjuntos de items pasamos a generar reglas con 
# soporte 0.1, confianza 0.8 y con un tamaño mínimo de 2.

rules <- apriori(Zoo, parameter = list(support = 0.1, confidence = 0.8, 
                                       minlen = 2))

barplot(table(size(rules)), xlab = "Rule size", ylab="Count")

# Como podemos ver con el gráfico, la mayoría de las reglas que confianza 0.8 
# tienen 8 y 9 items. A continuación ordenamos las reglas por soporte para ver 
# las más frecuentes.

sorted_rules <- sort(rules, by="confidence")

# Para eliminar las reglas redundantes hacemos
subset_matrix <- is.subset(sorted_rules, sorted_rules) 
subset_matrix[lower.tri(subsetMatrix, diag=TRUE)] <- FALSE 
redundant <- colSums(subsetMatrix, na.rm=TRUE) >= 1 
rules_pruned <- rulesSorted[!redundant]  #
#remove redundant rules 
inspect(head(rulesPruned))

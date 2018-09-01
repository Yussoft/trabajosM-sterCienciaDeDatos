ruta <- "C:/Users/Yus/Desktop/moa-release-2017.06b/moa-release-2017.06b"

# Sección 2.1
# data <- read.csv(paste0(ruta,"/res21.csv"), sep=";")
# print(shapiro.test(data[,1]))
# print(shapiro.test(data[,2]))
# print(wilcox.test( data[,1], data[,2],alternative = "two.sided", paired=TRUE))
# print(paste0("Media 1:",mean(data[,1])))
# print(paste0("Media 2:",mean(data[,2])))

# Sección 2.2
# data <- read.csv(paste0(ruta,"/res22.csv"), sep=";")
# print(shapiro.test(data[,1]))
# print(shapiro.test(data[,2]))
# print(wilcox.test( data[,1], data[,2]))
# print(paste0("Media 1:",mean(data[,1])))
# print(paste0("Media 2:",mean(data[,2])))

# Sección 2.3
# data <- read.csv(paste0(ruta,"/res23.csv"), sep=";")
# print(shapiro.test(data[,1]))
# print(shapiro.test(data[,2]))
# print(t.test( data[,1], data[,2]))
# print(paste0("Media 1:",mean(data[,1])))
# print(paste0("Media 2:",mean(data[,2])))

# Sección 2.4
# data <- read.csv(paste0(ruta,"/res24.csv"), sep=";")
# print(shapiro.test(data[,1]))
# print(shapiro.test(data[,2]))
# print(wilcox.test( data[,1], data[,2]))
# print(paste0("Media 1:",mean(data[,1])))
# print(paste0("Media 2:",mean(data[,2])))

# Sección 2.5
data <- read.csv(paste0(ruta,"/res25.csv"), sep=";")
print(shapiro.test(data[,1]))
print(shapiro.test(data[,2]))
print(wilcox.test( data[,1], data[,2]))
print(paste0("Media 1:",mean(data[,1])))
print(paste0("Media 2:",mean(data[,2])))

# Jesús Sánchez de Castro 77183983P
# Correo: jsdc94@correo.ugr.es
# Ejercicio de trabajo autónomo. Series temporales. Curso 2017-2018.
require(tseries)
data_path <- "C:/Users/Yus/Google Drive/Master/trabajosMasterCienciaDeDatos/SeriesTemporales/"

# Este dataset contiene el número de personas viviendo en Austria en miles, muestreados 
# trimestralmente desde 1971 hasta 1992.
serie <- scan(paste0(data_path,"serie1.dat"))

# Como se cuenta con 87 valores, correspondiendo a medidas trimestrales, y tenemos datos
# de 21 años, he decidio dejar los dos últimos años de test. Se busca predecir 2 valores, 
# los dos primeros trimestres de 1993.
NTest = 8 # 8 trimestres son 2 años
NPred = 2 # 2 trimestres de 1993 a predecir

# Para comenzar se supone una estacionalidad anual de 4 trimestres
serie.ts <- ts(serie, frequency = 10)
plot(decompose(serie.ts))
plot(serie)

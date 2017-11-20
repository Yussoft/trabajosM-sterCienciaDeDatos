# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 16/11/2017
# Ejercicio 11:
# Escribe una función trocear(palabra, num) que devuelva una lista con trozos de tamaño
# num de palabra.
from math import ceil

def trocear(palabra, num):

    resultado = []

    for i in range(0, len(palabra), num):
        resultado.append(palabra[i:i+num])

    return resultado

cad = "123456789"
num = 3
print("La cadena",cad,"en trozos de tamaño",num,":",trocear(cad, num))
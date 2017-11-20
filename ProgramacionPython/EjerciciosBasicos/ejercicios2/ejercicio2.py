# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 20/11/2017
# Ejercicio 2:
# Escribe una función contar_numeros_impares(numeros) que cuente la cantidad de número
# impares que hay en una lista.
import random
import ejercicios2.utils as utils

def contar_numeros_impares (numeros):

    contador = 0

    for elem in numeros:

        if elem%2 == 1:
            contador += 1

    return contador

n = 100000
lista = utils.generar_secuencia(n)

print("El número de impares es",contar_numeros_impares(lista))
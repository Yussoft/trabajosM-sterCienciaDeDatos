# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 20/11/2017
# Ejercicio 3:
# Escribe una función numeros_pares(numeros) que devuelva los números pares que hay en
# una lista.

import ejercicios2.utils as utils

def numeros_pares(numeros):

    pares = []

    for elem in numeros:

        if elem%2 == 0:
            pares.append(elem)

    return pares

n = 90
lista = utils.generar_secuencia(n)

print("Los números pares que hay en los primeros",n,"numeros es",numeros_pares(lista))
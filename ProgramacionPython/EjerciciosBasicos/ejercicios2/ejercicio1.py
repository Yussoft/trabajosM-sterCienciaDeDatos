# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 20/11/2017
# Ejercicio 2:
# Escribe una función sum_nums_lista(numeros) que sume todos los números de una lista.
# Compara el tiempo entre usar o no range
import ejercicios2.utils as utils
import random
import time

# Suma los elementos de una lista iterando sobre los elementos
def sum_nums_lista1(numeros):

    suma = 0
    for elem in numeros:
        suma += elem

    return suma

# Suma los elementos de una lista iterando con range(0,len(lista))
def sum_nums_lista2(numeros):

    suma = 0
    for i in range(0,len(numeros)):
        suma += numeros[i]

    return suma


lista = utils.generar_lista(100000,0,9)

t0 = time.time()
r1 = sum_nums_lista1(lista)

print("La suma de la lista es",r1,". TIEMPO:",time.time() - t0) # TIEMPO: 0.0060160160064697266

t0 = time.time()
r2 = sum_nums_lista2(lista)
print("(RANGE) La suma de la lista es",r2,". TIEMPO:",time.time()-t0) # TIEMPO: 0.01002645492553711

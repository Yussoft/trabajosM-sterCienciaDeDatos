# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 20/11/2017
# Ejercicio 4:
# Escribe una función combinar_listas(l1, l2) que devuelva una lista que esté formada por
# todos los elementos de l1 y a continuación todos los de l2. Por ejemplo combinar_listas([1,
# 2, 8] , [5, 10]) devolvería [1, 2, 8, 5, 10]

import ejercicios2.utils as utils

def combinar_listas(l1,l2):

    return l1+l2

l1 = utils.generar_lista(5,0,20)
l2 = utils.generar_lista(5,0,20)
print("La combinación de la lista",l1,"y la lista",l2,"es",combinar_listas(l1,l2))
# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 15/11/2017
# Ejercicio 5:
# Escribe una función vocales(palabra) que devuelva las vocales que aparecen en la palabra.


def vocales (palabra):

    vocales = ['a','e','i','o','u']
    vocales_en_palabra = []
    for char in palabra:
        if char.lower() in vocales:
            vocales_en_palabra.append(char.lower())

    return vocales_en_palabra

def eliminar_repetidos (lista):

    resultado = []
    for i in lista:
        if i not in resultado:
            resultado.append(i)
    return resultado


palabra = "Murcielago"
print("La palabra",palabra,"tiene las siguientes vocales ",eliminar_repetidos(vocales(palabra)))
palabra = "Abracadabra"
print("La palabra",palabra,"tiene las siguientes vocales ",eliminar_repetidos(vocales(palabra)))

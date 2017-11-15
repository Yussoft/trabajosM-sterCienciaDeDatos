# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 15/11/2017
# Ejercicio 7:
# Escribe una función comunes(palabra1, palabra2) que devuelva una cadena formada por los
# caracteres comunes a las dos palabras.

def comunes(palabra1, palabra2):
    comunes = []

    w1 = list(palabra1)
    w2 = list(palabra2)

    for element in w1:
        if element.lower() in w2:
            comunes.append(element.lower())

    return comunes

def eliminar_repetidos (lista):

    resultado = []
    for i in lista:
        if i not in resultado:
            resultado.append(i)
    return resultado

p1 = "Holacaracola"
p2 = "CocaCola"

print(eliminar_repetidos(comunes(p1,p2)))
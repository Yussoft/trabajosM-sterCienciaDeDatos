# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 15/11/2017
# Ejercicio 4:
# Escribe una función num_vocales(palabra) que devuelva el número de vocales que aparece
# en la palabra.

def num_vocales(palabra):
    vowels = ['a','e','i','o','u']
    contador = 0

    for i in palabra:
        if i.lower() in vowels:
            contador+=1

    return contador


palabra = "Abracadabra"
print("La palabra",palabra,"tiene",num_vocales(palabra),"vocales.")
# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 15/11/2017
# Ejercicio 1:
# Escribe una función contar_letras(palabra, letra) que devuelva el número de veces que
# aparece una letra en una palabra.

def contar_letras(palabra, letra):

    # Ponemos todas las letras de la palabra en minúsculas
    palabra = palabra.lower()

    # Creamos un contador,
    contador = 0
    for letras in palabra: # Para cada letra en la palabra pasada como argumento
        if letras == letra: # Si la letra es la letra que estamos buscando
            contador += 1 # aumentamos el contador

    return contador

palabra = "Abracadabra"
letra = "a"
apariciones = contar_letras(palabra, letra)
print("El número de apariciones de",letra.upper(),"'s que hay en",palabra,"es",apariciones)


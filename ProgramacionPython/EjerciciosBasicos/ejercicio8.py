# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 15/11/2017
# Ejercicio 7:
# Escribe una función eco_palabra(palabra) que devuelva una cadena formada por palabra
# repetida tantas veces como sea su longitud. Por ejemplo 'hola' -> 'holaholaholahola'

def eco_palabra(palabra):

    length = len(palabra)
    result = ""
    for i in range(0,length):
        result += palabra

    return result


p = "hola"
print("La palabra",p,"de longitud",len(p),":",eco_palabra(p))

# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 15/11/2017
# Ejercicio 3:
# Escribe una función buscar(palabra, sub) que devuelva la posición en la que se puede
# encontrar sub dentro de palabra o -1 en caso de que no esté.

def buscar(palabra, sub):

    indice = 0

    if sub in palabra: # Si la subcadena está en la palabra
        c = sub[0] # Guardamos el primer carácter de la subcadena
        for char in palabra: # Por cada carácter de la palabra
            if char.lower() == c: # Si el carácter es el primer carácter de la subcadena
                if palabra[indice:indice+len(sub)] == sub: # Miramos si coincide la subcadena
                    return indice # Devolvemos el índice

            indice += 1
    return -1

palabra = "Abracadabra"
sub = "dabra"
print("La posición en la que empieza",sub,"en",palabra,"es",buscar(palabra, sub))
print("La posición en la que empieza",sub,"en",palabra,"es",palabra.find(sub),"(usando string.find(sub))")
print("Si no se encuentra, se devuelve -1")
print("palabra = 'Hola' y subcadena = 'hi', indice = ",buscar("hola","hi"))
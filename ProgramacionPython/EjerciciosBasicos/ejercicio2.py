# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 15/11/2017
# Ejercicio 2:
# Escribe una función eliminar_letras(palabra, letra) que devuelva una versión de palabra que
# no contiene el carácter letra.

def eliminar_letras(palabra, letra):

    resultado = ''
    for l in palabra:
        if (l.lower() != letra):
            resultado += l

    return resultado

palabra = "Abracadabra"
letra = "a"

print("Esta función tiene en cuenta que haya mayúsculas, pasándolas a minúscula antes de comparar.")
print("Si a la palabra",palabra,"le quitamos la letra",letra,"obtenemos :",eliminar_letras(palabra,letra))
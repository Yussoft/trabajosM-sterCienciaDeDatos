# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 15/11/2017
# Ejercicio 6:
# Escribe una función es_inversa(palabra1, palabra2) que devuelve True si una palabra es la
# misma que la otra pero con los caracteres en orden inverso. Por ejemplo 'absd' y 'dsba'

def es_inversa(palabra1, palabra2):

    chars1 = list(palabra1.lower())
    chars2 = list(palabra2.lower())

    resultado = False
    if len(chars1) == len(chars2):
        for i in range(0, len(chars1)):
            print("Comprobación",i,":",chars1[i], chars2[len(chars2)-i-1])
            if chars1[i] != chars2[len(chars2)-i-1]:
                return False
        return True
    else:
        return False

# La función comprueba si tienen el mismo tamaño, después comprueba que el orden de las letras está invertido.

p1 = "hola"
p2 = "aloh"
print("¿Es la palabra", p2, "la inversa de",p1,"?")
if (es_inversa(p1,p2)):
    print("Si lo es.")
else: print ("No lo es.")
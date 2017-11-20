# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 15/11/2017
# Ejercicio 9:
# Escribe una función palindromo(frase) que determine si frase es un palíndromo. Es decir,
# que se lea igual de izquierda a derecha que de derecha a izquierda (sin considerar espacios).

def palindromo(frase):

    w = list(frase)

    for i in range(0, len(w)):
        if w[i] != w[len(w)-i-1]:
            return False

    return True

p = "girafarig"
print("La palabra",p,"¿Es un palindromo?",palindromo(p))
p = "noesunpalindromo"
print("La palabra",p,"¿Es un palindromo?",palindromo(p))
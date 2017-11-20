# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 16/11/2017
# Ejercicio 10;
# Escribe una función orden_alfabetico(palabra) que determine si las letras que forman
# palabra aparecen en orden alfabético. Por ejemplo: 'abejo'

def orden_alfabetico(palabra):

    chars = list(palabra)

    for i in range(0, len(chars)):

        if i+1 < len(chars):
            if chars[i] > chars[i+1]:
                return False
        else:
            if chars[i] < chars[i-1]:
                return False
    return True

p1 = "abcdefghijk"
p2 = "azbc"
print("La palabra",p1,"está ordenada alfabéticamente:",orden_alfabetico(p1))
print("La palabra",p2,"está ordenada alfabéticamente:",orden_alfabetico(p2))
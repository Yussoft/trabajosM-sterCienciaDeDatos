# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 16/11/2017
# Ejercicio 12;
# Un anagrama de una palabra pal1 es una palabra formada con las mismas letras que pal1
# pero en orden distinto. Escribe una función anagrama(palabra1, palabra2) que determine si
# es una anagrama. Ejemplo: marta – trama,

def anagrama(palabra1, palabra2):

    p1 = list(palabra1)
    p2 = list(palabra2)

    p1.sort()
    p2.sort()

    return (p1 == p2)

p1 = "anagrama"
p2 = "granaama"
print("La palabra",p1,"es un anagrama de",p2,":",anagrama(p1,p2))

p2 = "gramaama"
print("La palabra",p1,"es un anagrama de",p2,":",anagrama(p1,p2))
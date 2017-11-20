# Jesús Sánchez de Castro, Máster de ciencia de datos UGR 20/11/2017
# Ejercicio 5:
# Escribe una función mezclar(la, lb) que dadas dos listas ordenadas devuelva una lista
# conteniendo los elementos de ambas listas ordenados de forma ascendente.

import ejercicios2.utils as u

def mezclar(la,lb):

     lc = la+lb
     lc.sort()
     return lc

la = u.generar_lista(10,0,10)
lb = u.generar_lista(10,0,10)

la.sort()
lb.sort()

print("La mezcla de la lista",la,"y la lista",lb,"es",mezclar(la,lb))
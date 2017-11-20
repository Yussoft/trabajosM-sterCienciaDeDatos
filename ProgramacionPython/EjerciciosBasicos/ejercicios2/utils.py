import random

def generar_lista(n, lim1=1, lim2=-1):
    if (lim2 == -1):
        lim2 = n
    l = []
    for i in range(n):
        l.append(random.randint(lim1, lim2))

    return l


def generar_set(n, lim1=1, lim2=-1):
    if (lim2 == -1):
        lim2 = n
    l = set()
    for i in range(n):
        l.add(random.randint(lim1, lim2))

    return l

def generar_secuencia(n):

    l = []
    for i in range(n):
        l.append(i)

    return l
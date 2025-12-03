## Ejercicio N° 1
Taylor Swift trajo The Eras Tour a Latinoamérica y pasó por Buenos Aires
el 9, 10 y 11 de noviembre. Una gran cantidad de swifties hicieron fila en la
entrada del estadio por 7 meses para asegurar un lugar cercano a la artista
dentro del estadio.

La comunidad de "Swifties Developers" desarrolló un sistema para enumerar los
lugares en la fila, y posteriormente acceder de manera ordenada al estadio.
Como tuvo tanto éxito, se quiere digitalizar dicho sistema para próximos
recitales con tanta concurrencia. Se cuenta con la siguiente información:

Una lista simple que contiene: DNI de la swiftie, número de la fila, fecha en
la que se puso a hacer la fila y fecha para la que tiene entradas. Se decidió
encriptar el número en la fila que le toca a cada una, código que, el día del
recital, será desencriptado para poder acceder al estadio. Para el proceso de
encriptación se debe realizar lo siguiente:

- Recuperar el código de encriptación que se encuentra en una matriz de
enteros, cuyas dimensiones son el mes en el que inició la fila y el día para el
que tiene entradas.
- Obtener el código de swiftie, para lo cual existe una función swiftieEncriptada(),
que retorna dicho código y recibe como parámetro el número de fila y el código
correspondiente de la matriz.

Se pide:
1. Cargar una lista doble que deberá tener un nodo por cada fecha del recital,
en los cuales se registre la cantidad de asistentes, seguido por nodos con la
información de las swifties que van en cada fecha (código y DNI).

*Nota:* Los nodos que indican la fecha y cantidad de asistentes deben tener
los campos código y DNI vacíos. Luego, los nodos con información de cada swiftie
indican el código encriptado y el DNI, dejando vacíos los campos de fecha y
cantidad. Una vez que se cargó a la swiftie en la lista doble, se la debe eliminar
de la lista de entrada.

2. Informar la fecha con la mayor cantidad de swifties.

Ejemplo de la lista doble:
|-----------|       |------------------|       |------------|       |------------------|       |------------|       |------------------|
|fecha: 9/11|       |fecha:            |       |fecha: 10/11|       |fecha:            |       |fecha: 11/11|       |fecha:            |
|cant: 45633| ----> |cant:             | ----> |cant: 45633 | ----> |cant:             | ----> |cant: 45633 | ----> |cant:             |
|cod:       | <---- |cod:a#14s/54d(aa4d| <---- |cod:        | <---- |cod:a#14s/54d(aa4d| <---- |cod:        | <---- |cod:a#14s/54d(aa4d|
|dni:       |       |dni: 11222666     |       |dni:        |       |dni: 11222666     |       |dni:        |       |dni: 11222666     |
|-----------|       |------------------|       |------------|       |------------------|       |------------|       |------------------|

<details>
<summary>Solución</summary>

```
accion ejercicio(prim: puntero a Fan) es
  ambiente
    Fecha = registro
      año: N(4)
      mes: 1..12
      dia: 1..31
    fin_registro
  
    Fan = registro
      dni: N(8)
      pos: entero
      fila: Fecha
      fecha: Fecha
      prox: puntero a Fan
    fin_registro
    
    Encriptado = registro
      fecha: Fecha
      cant: entero
      cod: AN(64)
      dni: N(8)
      ant, prox: puntero a Encriptado
    fin_registro
    
    i, may_espec, may_espec_dia: entero
    p: puntero a Fan
    prim_sal, ult_sal, s, r, q: puntero a Encriptado
    codigos: arreglo [1..12, 1..31] de entero
  proceso
    p := prim
    
    para i := 9 hasta 11 hacer
      nuevo(q)
      *q.fecha.año := 2025
      *q.fecha.mes := 11
      *q.fecha.dia := i
      *q.cant := 0
      *q.prox := nil
      
      si (prim_sal = nil) entonces
        prim_sal := q
        ult_sal := q
        *q.ant := nil
      contrario
        *ult_sal.prox := q
        *q.ant := ult_sal
        ult_sal := q 
      fin_si
    fin_para
    
    mientras (p <> nil) hacer
      nuevo(q)
      *q.dni := *p.dni
      *q.cod := siwftieEncriptada(*p.pos, codigos[*q.fila.mes, *q.fch.dia])
      
      s := nil
      r := prim_sal
      mientras (*r.fecha.mes <> *p.fecha.mes) hacer
        s := r
        r := *r.prox
      fin_mientras
      *r.cant := *r.cant + 1
      
      s := r
      r := *r.prox
      
      si (no (r = nil)) entonces
        ult_sal := q
      contrario
        *r.ant := q
      fin_si
      *q.prox := r
      *q.ant := s
      *s.prox := q
    
      p := *p.prox
    fin_mientras
    
    may_espec := 0
    may_espec_dia := 0
    para i := 9 hasta 11 hacer
      r := prim_sal
      
      mientras (r <> nil) y (*r.fecha.dia <> i) hacer
        r := *r.prox
      fin_mientras
      
      si (*r.cant > may_espect) entonces
        may_espect := *r.cant
        may_espec_dia := i
      fin_si
    fin_para
    
    escribir("La fecha con la mayor cantidad de espectadores fue el dia nro ",
    may_espec_dia, " con un total de ", may_espec, " espectadores.")
fin_accion
```

</details>

## Ejercicio N° 2
Se tiene una lista circular de entrada donde cada nodo contiene como dato un
valor entero que representa un código binario. Se debe cargar en una nueva
lista simple aquellos nodos que no cumplen con el siguiente patrón: 

(10) * N, siendo N cualquier número natural.

*Ejemplo:* N = 3, valor 101010.

Se pide:
1. Para controlar el cumplimiento del patrón, realizar una función recursiva
que retorne un valor lógico.
2. Mostrar cómo quedó la lista circular con los nodos que cumplen el patrón.

Caso base:
  verdadero, si cant > n && num = 0
  falso, si cant > n && num <> 0
Caso recursivo:
  cumple_patron(num DIV 100, cant + 1) si cant <= n  

<details>
<summary>Solución</summary>

```
accion ejercicio(prim: puntero a Nodo) es
  ambiente
    Nodo = registro
      dato: entero
      prox: puntero a Nodo
    fin_registro
    
    n: entero
    a, p, aux: puntero a Nodo
    prim_q, q: puntero a Nodo
    
    funcion cumple_patron(num: entero, cant: entero): logico es
      si (cant <= n) entonces
        cumple_patron := cumple_patron(num DIV 100, cant + 1)
      contrario
        si (num = 0) entonces
          cumple_patron := verdadero
        contrario
          cumple_patron := falso
        fin_si
      fin_si
    fin_funcion
  proceso
    prim_q := nil
    p := prim
    
    escribir("Ingrese el número de veces que debe repetirse el 10: ")
    leer(n)
    
    repetir
      si (cumple_patron(*p.dato, 1)) entonces
        a := p  
        p := *p.prox
      contrario
        nuevo(q)
        *q.dato := *p.dato
        *q.prox := prim_q
        prim_q := q
        
        aux := p
        p := *p.prox
        si (a = nil) entonces
          prim_q := p
          disponer(aux)
        contrario
          *a.prox := p
          disponer(aux)
        fin_si
      fin_si
    hasta que (*p.prox <> prim)
    
    escribir("Los nodos que cumplen el patrón son: ")
    p := prim
    repetir
      escribir("Número: ", *p.dato)
      p := *p.prox
    hasta que (p = prim)
fin_accion
```

</details>

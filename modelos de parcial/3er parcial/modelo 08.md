## Ejercicio N° 1
Se requiere un algoritmo para gestionar la torre de control de un Aeropuerto
con 2 terminales. Se cuenta con una lista de vuelos que contiene por cada uno
la siguiente información

| Código de vuelo [AN(8)] | Terminal [I – Internacional, C – Cabotaje] | Estado [A - Por aterrizar. D - Por despegar] | Horario estimado [Hora y Minutos N(4] |
|-------------------------|--------------------------------------------|----------------------------------------------|---------------------------------------|

Luego, el operador de la torre puede realizar dos acciones: reconocimiento y
acción.

En la etapa de reconocimiento, se verifica si hay algún nuevo avión esperando
para aterrizar y/o despegar (considerar que está esperando si la hora estimada
está dentro de los 10 minutos de la hora actual), y de ser así desde la Torre
se los asigna en la fila correspondiente de acuerdo al horario estimado de
aterrizaje o despegue.  En la etapa de acción, se autoriza la operación de
aterrizar o despegar, al primero de los aviones que esté esperando (los que
esperan para aterrizar tienen prioridad). Se quita ese avión de la fila y se
informa el éxito de la operación.

Escribir un algoritmo que inicialice la torre de control, y gestione las dos
operaciones Reconocimiento y Acción, imprimiendo la operación tomada. Suponga
que existe una función que recibe como parámetros de entrada 2 horas (hora y
minutos, como un dato de tipo N(4)) y devuelve la diferencia entre ambas en
minutos. 

<details>
<summary>Solución</summary>


```
accion ejercicio(vuelos: puntero a Vuelo) es
  ambiente
    Vuelo = registro
      cod: N(8)
      term: ('I', 'C')
      estado: ('A', 'D')
      est: N(4)
      prox: puntero a Vuelo
    fin_registro
    
    hora_actual: N(4)
    prim, ult, a, r, p, q, aux: puntero a Vuelo
  proceso
    prim := nil
    ult := nil
    p := vuelos
    
    escribir("Ingrese la hora actual: ")
    leer(hora_actual)
    
    mientras (p <> nil) hacer
      si (diferencia(hora_actual, *p.est) <= 10) entonces
        nuevo(q)
        *q.cod := *p.cod
        *q.term := *p.term
        *q.estado := *p.estado
        *q.est := *p.est
        
        *q.prox := nil
        si (ult = nil) entonces
          ult := q
          prim := q
        contrario 
          a := nil
          r := prim
          
          mientras (r <> nil) y (*r.est < *q.est) hacer
            a := r
            r := *r.prox
          fin_mientras
          
          si (a = nil) y (r = prim) entonces
            *q.prox := r
            prim := q
          contrario
            si (r = nil) y (a = ult) entonces
              *ult.prox := q
              ult := q
            contrario
              *a.prox := q
              *q.prox := r
            fin_si
          fin_si
        fin_si
      fin_si
      
      p := *p.prox
    fin_mientras

    r := prim
    mientras (r <> nil) hacer
      escribir("Se autoriza la operación de ", *r.estado, " para el vuelo ", *r.cod)
      
      aux := r
      r := *r.prox
      prim := r
      disponer(aux)
    fin_mientras
fin_accion
```

</details>

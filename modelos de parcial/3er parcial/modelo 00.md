## Ejercicio N° 1
Para el día del tercer parcial de Algoritmos se decidió agrupar a los alumnos
en 6 aulas. Cada aula tendrá un profesor a cargo. Se dispone de una lista
simplemente enlazada de alumnos con los siguientes datos:
- Legajo.
- Nombre y apellido.
- Comisión.
- Notas: arreglo de [1..5] de enteros

Además, se cuenta con dos funciones:
- EsAlumnoLibre(), que recibe como parámetro el legajo del alumno y devuelve
verdadero o falso, en función de si el alumno se encuentra libre o no.
- AsignarAula(), que devuelve un número aleatorio entre 1 y 6.

Se solicita:
1. Generar un lista doblemente enlazada, de los alumnos en condiciones de
rendir (es decir, que no se encuentren libres) con la siguiente información:
- Número de curso.
- Cantidad.
- Legajo.

Se deberá cargar un nodo por cada curso, y de forma intermedia, un nodo por
cada alumno asignado a dicho curso. Los nodos de los cursos serán los nodos
de cabecera, mientras que los nodos intermedios contendrán información del
alumno, de forma tal que:

a) Si es un nodo de cabecera:
  - El campo número de curso será el número del curso (1..6).
  - El campo cantidad indicará la cantidad de alumnos asignados a dicho curso
  (deberá actualizarse cada vez que se asigne un nuevo alumno).
  - El campo legajo será 0.

b) Si es un nodo intermedio:
  - El campo número de curso será el número del curso (1..6).
  - El campo cantidad será 1.
  - El campo legajo será el legajo del alumno correspondiente.

En el caso de que el alumno se encuentre en condiciones de rendir, se debe
eliminarlo de la lista original.

2. Informar:
- El promedio de alumnos por aula.
- El aula con la mayor cantidad de alumnos.

<details>
<summary>Solución</summary>

```
accion ejercicio(prim: puntero a Alumno) es
  ambiente
    Alumno = registro
      leg: N(5)
      nom: AN(30)
      com: ('A', 'B', 'C', 'D')
      notas: arreglo [1..5] de entero
    fin_registro
    
    Nodo = registro
      dato: Informe
      curso: 1..6
      cant: entero
      leg: N(5)
      ant, prox: puntero a Nodo 
    fin_registro
      
    may_cant, may_aul: entero
    i, total: entero
    p, a, b: puntero a Alumno
    prim_sal, ult_sal, s, r, q: puntero a Nodo
    alumnos: arreglo [1..6] de entero
    reg: Informe
  proceso
    prim_sal := nil
    a := nil
    p := prim
      
    para i := 6 hasta 1, -1 hacer
      nuevo(q)
      *q.curso := i
      *q.cant := 0
      *q.leg := 0
      *q.ant := nil
      
      si (prim_sal <> nil) entonces
        *prim_sal.ant := q
      contrario
        ult_sal := q
      fin_si
      
      *q.prox := prim_sal
      prim_sal := q
      alumnos[i] := 0
    fin_para
      
    mientras (p <> nil) hacer
      si (EsAlumnoLibre(*p.leg)) entonces
        a := p
        p := *p.prox
      contrario
        // obtengo nro de curso y
        // aumento cantidad de alumnos en aula (consigna 2)
        asignado := AsignarAula()
        alumnos[curso] := alumnos[curso] + 1
      
        // creo nodo de alumno
        nuevo(q)
        *q.curso := asignado 
        *q.cant := 1
        *q.leg := *p.leg
      
        // avanzo hasta encontrar el nodo cabeza del curso
        // e incremento la cantidad de alumnos +1
        s := nil
        r := prim_sal
        mientras (*r.curso < asignado) hacer
          s := r
          r := *r.prox
        fin_mientras
        *r.cant := *r.cant + 1
      
        // avanzo 1 nodo más. En este momento estamos entre la cabeza y el
        // primer nodo alumno, o nil en caso de ser el último curso sin alumnos
        // s -> nodo cabeza
        // r -> nodo alumno o nil
        s := r
        r := *r.prox
      
        *q.prox := r
        *q.ant := s
        *r.ant := q
        *s.prox := q
      fin_si
    fin_mientras
      
    may_cant := alumnos[1]
    may_aul := 1 
    total := alumnos[1]
    para i := 2 hasta 6 hacer
      total := total + alumnos[i]
      si (alumnos[i] > may_cant) entonces
        may_cant := alumnos[i]
        may_aul := i
      fin_si
    fin_para
      
    escribir("El curso con la mayor cantidad de alumnos fue el n° ", may_aul)
    escribir("y el promedio de alumnos por curso fue de ", total / 6, " alumnos.")
fin_accion
```

</details>

## Ejercicio N° 2
Dada la lista de alumnos del primer ejercicio, se desea generar una lista
simplemente enlazada que se encuentre ordenada por número de legajo, con todos
los alumnos que hayan obtenido una calificación mayor a 6 en al menos 3
instancias de exámenes.

Para comprobar si los alumnos aprobaron al menos tres instancias, utilizar una
función recursiva. Finalmente, mostrar los estudiantes que se cargaron en la
nueva lista.

Caso base:
  - verdadero, si pos > 6 & aprob >= 3 
  - falso, si pos > 6 & aprob <= 2
Caso recursivo:
  - es_regular(notas, pos + 1, aprob + 1), si pos <= 6 & notas[pos] > 6
  - es_regular(notas, pos + 1, aprob), si pos <= 6 & notas[pos] <= 6  

<details>
<summary>Solución</summary>
```
accion ejercicio(prim: puntero a Nodo) es
  ambiente
    Nodo = registro
      leg: N(5)
      nom: AN(30)
      com: ('A', 'B', 'C', 'D')
      notas: arreglo [1..5] de entero
      prox: puntero a Nodo
    fin_registro
    
    prim_q, q, p: puntero a Nodo
  
    funcion es_regular(notas: arreglo [1..5] de entero, pos: entero,
      aprob: entero): lógico es
      si (pos > 6) entonces
        si (aprob >= 3) entonces
          es_regular := verdadero
        contrario
          es_regular := falso
        fin_si
      contrario
        si (notas[pos] > 6) entonces
          es_regular := es_regular(notas, pos + 1, aprob + 1)
        contrario
          es_regular := es_regular(notas, pos + 1, aprob)
        fin_si
      fin_si
    fin_funcion
  proceso
    prim_q := nil
    p := prim
  
    mientras (p <> nil) hacer
      si (es_regular(*p.notas, 1, 0)) entonces
        nuevo(q)
        *q.leg := *p.leg
        *q.nom := *p.nom
        *q.com := *p.com
        *q.notas := *p.notas
        
        *q.prox := prim_q
        prim_q := q
      fin_si
      
      p := *p.prox
    fin_mientras
fin_accion
```
</details>

## Ejercicio 1
Para el día del tercer parcial de Algoritmos se decidió agrupar a los alumnos
en 6 aulas. Cada aula tendrá un profesor a cargo. Se dispone de una lista
simplemente enlazada de alumnos con los siguientes datos:

- Legajo.
- Nombre y apellido.
- Comisión.
- Notas: arreglo de [1..5] de enteros

Además, se cuenta con dos funciones:
1. EsAlumnoLibre(), que recibe como parámetro el legajo del alumno y devuelve
verdadero o falso, en función de si el alumno se encuentra libre o no.
2. AsignarAula(), que devuelve un número aleatorio entre 1 y 6.

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

## Ejercicio 2
Dada la lista de alumnos del primer ejercicio, se desea generar una lista
simplemente enlazada que se encuentre ordenada por número de legajo, con todos
los alumnos que hayan obtenido una calificación mayor a 6 en al menos 3
instancias de exámenes.

Para comprobar si los alumnos aprobaron al menos tres instancias, utilizar una
función recursiva. Finalmente, mostrar los estudiantes que se cargaron en la
nueva lista.

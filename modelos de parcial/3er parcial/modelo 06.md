## Ejercicio N° 1
La Asociación de fútbol argentino (AFA) solicita ayuda a los alumnos de la
carrera Ingeniería en Sistemas de Información de la UTN para que desarrollen un
programa que permita manejar de manera automatizada la designación de los
árbitros para cada partido en las distintas fechas de la superliga. Para ello
cuenta con el archivo FECHAS, de las distintas designaciones de los partidos:

| Equipo_Local *AN(40)* |	Equipo_Visitante *AN(40)* |	Hora *N(4)* | Fecha *Fecha* | Ciudad_Local *(A - B – C)* |
|-----------------------|---------------------------|-------------|---------------|----------------------------|

El campo Ciudad_Local indica dónde se jugará el partido.

A su vez, disponen de una lista circular con el nombre de los distintos
árbitros (desordenada y no se conoce la cantidad):

| Apellido y Nombre *AN(80)* | Cantidad *N(2)* | Localidad *(A – B – C)* |
|----------------------------|-----------------|-------------------------|

El campo Localidad corresponde a la ciudad donde vive el árbitro, de modo que
el mismo no tenga incidencia en el juego. El campo Cantidad indica el número
de partidos asignados a cada árbitro, el cual no debe superar a un MÁXIMO de
10 partidos.

Se pide:
1. Para cada partido descripto en el archivo Fechas, asignar un árbitro a cada
partido, siempre y cuando este no pertenezca a la misma ciudad; modificando su
estado a asignado; luego de haber asignado al último árbitro, se deberá volver
a asignar desde el principio. La lista/s de salida deberá contener nombre el
equipo local, nombre del equipo visitante, y apellido y nombre del árbitro asignado.

Consideración: Determinar el/los tipo/s de lista/s que mejor se apliquen a la
resolución del problema, teniendo en cuenta que se necesita mostrar desde el
último partido del torneo con el correspondiente árbitro asignado.

2. Una vez terminado el proceso anterior, con la lista de árbitros restantes
generar una lista doblemente encadenada con los árbitros que tengan asignados
10 partidos, ordenada de manera decreciente por el nombre y apellido.

## Ejercicio N° 2
Dado el siguiente problema: "Invertir los números de un arreglo de enteros"

1. Escriba una función recursiva que lo resuelva.
2. Indique el planteo formal de la solución recursiva.

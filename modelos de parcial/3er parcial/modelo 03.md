## Ejercicio 1
Dada una lista simple que contiene los 32 equipos clasificados para el Mundial,
los datos que provee son países, grupo, puntos, tarjetas amarillas, tarjetas
rojas (datos que vienen vacíos en todos los nodos) y un arreglo con la edad de
los 26 jugadores.

Se solicita un programa que asista en la realización del sorteo de grupos,
agregando el dato del grupo asignado a la lista de entrada, la cual debe quedar
ordenada (se debe reordenar sobre la misma lista). El usuario del programa
ingresa el grupo y el nombre del país sorteado.

Al final del sorteo se debe mostrar el equipo con el menor y el mayor promedio
de edad. Para esto se debe calcular el promedio de cada equipo usando una
función recursiva.

## Ejercicio 2
Dada la lista de equipos generada anteriormente, que se encuentra ordenada por
grupos, y un archivo con información de los partidos que tiene el siguiente
formato:

**PARTIDOS** *(ordenado por ID_Partido, Equipo_local y Equipo_Visitante)*
| ID_Partido | Equipo_local | Equipo_Visitante |
|------------|--------------|------------------|

(Un mismo equipo juega varios partidos, independientemente de que sea local
o visitante).

También se tiene un archivo indexado donde se tienen los resultados de los
mismos, así como las amonestaciones colocadas:

**RESULTADOS** *(indexado por ID_Partido)*
| ID_Partido [N(5)] | goles_local [N(2)] | goles_visitante [N(2)] | rojas [N(2)] | amarillas[N(2)] |
|-------------------|--------------------|------------------------|--------------|-----------------|

Se pide:
1. Generar una lista doblemente enlazada con los equipos que pasarán a la 
siguiente fase del Mundial 2022, ordenada por cantidad de puntos obtenidos.
- Suma 3 puntos el equipo ganador, y en caso de empate cada equipo suma 1 punto.
Diferencia de gol es la resta entre los goles a favor y los goles en contra.
- Pasan a la siguiente fase los equipos que: Sumen más de 4 puntos; sumen 4
puntos y tengan una diferencia de gol superior a 2. Dicha diferencia de gol
ha de ser positiva; o sumen 3 puntos, y algún equipo en el grupo tenga 9 puntos.
2. Mostrar por pantalla: (a) los nombres de los equipos que pasaron a la siguiente
fase. (b) el equipo que tiene la mayor cantidad de tarjetas rojas.

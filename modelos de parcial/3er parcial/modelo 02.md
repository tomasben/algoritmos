## Ejercicio 1
Una importante cadena de supermercados está realizando un sorteo por su
aniversario, repartiendo importantes premios y descuentos a sus clientes, de
acuerdo a las compras realizadas (cuantas más compras realiza un cliente, más
chances suma). La información de las compras se encuentra en un archivo secuencial
ordenado por fecha de compra:

| Fecha_compra | DNI_cliente | Cantidad_artículos | Importe_total |
|--------------|-------------|--------------------|---------------|

Además, cuenta con un programa de fidelización de clientes. La información de
los socios adheridos al programa se encuentra dentro de un archivo indexado por
DNI del cliente:

| DNI_cliente | ApellidoyNombre | Fecha_adhesión | Categoría |
|-------------|-----------------|----------------|-----------|

Se pide:
1. Crear una lista simplemente enlazada (ordenada por Nombre y apellido) con
información de las personas que forman parte del programa de socios. Los datos
a almacenar son los siguientes:

| ApellidoyNombre | Chances_total |
|-----------------|---------------|

Para ello, se debe tener en cuenta lo siguiente:
- Cuando se agrega a un cliente, se le otorgan 5 chances por única vez. Por
cada $100 que gaste en cada compra posterior, se le sumará una chance extra.
- En caso de que la categoría del cliente sea "Black", tendrá una cantidad
aleatoria de chances. Esta cantidad se genera mediante un giro de ruleta,
simulado con la información almacenada en una lista circular simple de la
siguiente manera:
    
1. Se genera un valor aleatorio con la función Tirar(), la cual retorna un
número entre 1 y 55. Para obtener el número de chances extra, deben realizarse
tantos saltos sobre la resulta como indique el valor obtenido con la función.
2. Los valores para los siguientes clientes se obtendrán a partir de la última
posición que haya quedado.

## Ejercicio 2
Una clínica dispone de un sistema informático para monitorear la temperatura
de sus pacientes de forma automatizada, rápida y segura. La información se
almacena en una lista simplemente encadenada con los siguientes datos:

| DNI del paciente | Nombre y apellido | Edad | Nro. de cama | Nro. de habitación | Temperaturas |
|------------------|-------------------|------|--------------|--------------------|--------------|

El campo temperaturas contiene un arreglo de 4 mediciones. Se pide mostrar el
nombre y apellido, y luego eliminar de la lista a los pacientes que no hayan
registrado temperaturas mayores a 36.5º C.

Para determinar si el paciente cumple la condición mencionada anteriormente
se debe desarrollar y utilizar una función recursiva.

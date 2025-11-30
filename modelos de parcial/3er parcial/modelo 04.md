## Ejercicio 1
Una empresa que tiene un negocio de e-commerce quiere conocer la opinión de
los clientes en cuanto a su experiencia en la página a la hora de realizar
consultas sobre los servicios que ofrece. Se registraron en una lista simple
las opiniones de los usuarios respecto de cada compra:

**Lista de opiniones** *(ordenada por usuario)*
| id_usuario | fecha_opinión | calificación (1..5) | servicio_calificado (1..20) |
|------------|---------------|---------------------|-----------------------------|

Los datos de los distintos compradores están registrados en un archivo indexado:

**Usuarios** *(indexado por Usuario)*
| Usuario | Apellido y Nombre | DNI | Dirección | Correo | Categoría ("Sin categoría", "Silver", "Gold") |
|---------|-------------------|-----|-----------|--------|-----------------------------------------------|

Se posee ad*emás una lista circular simple con códigos de cupones de descuento
disponibles (cod_descuento, porcentaje_descuento).

Se le solicita:
1. Generar una lista doblemente enlazada, ordenada por promedio de calificación
de manera ascendente, de los usuarios a los que se les debe enviar un cupón de
descuento.
- Téngase en cuenta que un mismo usuario puede realizar más de una compra y
dejar más de una opinión, pero no deben repetirse usuarios en la lista de salida.
- Para determinar el descuento se le asignará el próximo cupón disponible en la
lista circular, solo si la función bonificación(categoría, código_último_servicio)
retorna verdadero. De lo contrario no se debe incluir a los usuarios en la lista,
ya que no les corresponde un descuento. El código de último servicio debe ser de
la opinión (fecha_opinión) más reciente.
- Los datos que debe incluir cada nodo de la lista doble de salida son los siguientes:

| id_usuario | Apellido y Nombre | Correo | Cantidad de opiniones | Promedio de opiniones | Descuento |
|------------|-------------------|--------|-----------------------|-----------------------|-----------|

2. Al finalizar el proceso, mostrar por pantalla el nombre e ID de los 5 usuarios
con el mayor promedio de calificación y los 5 usuarios con el menor promedio de
calificación.

## Ejercicio 2
Dada una lista doblemente enlazada con la información de las compras realizadas
por los clientes, donde en cada compra se indica el método de pago (efectivo,
tarjeta de crédito, Mercado Pago, Modo, etc), con el siguiente formato:

| id_compra | fecha_compra | método_pago | nro_tarjeta | monto |
|-----------|--------------|-------------|-------------|-------|

Se le solicita:
1. Validar las compras realizadas con tarjeta de cŕedito (método_pago = "TC")
utilizando una función recursiva. La información de las tarjetas de crédito
se encuentra dentro de un arreglo de 16 posiciones en cada nodo (en el campo
nro_tarjeta), debiendo realizarse los siguientes pasos:

a) Comenzar a procesar desde el último dígito hacia el primero.
b) Doblar (duplicar) los dígitos en posiciones impares. Si el resultado de la
operación es mayor que 9, se deben sumar los dígitos del número (por ejemplo,
si el resultado es 14, entonces 1 + 4 = 5).
c) Sumar todos los dígitos obtenidos.
d) Verificar si la suma de los dígitos es divisible por 10. En caso de serlo,
el número de tarjeta es válido.
2. Eliminar de la lista de entrada aquellas compras que se hayan realizado con
un número de tarjeta inválido, sin modificar los nodos con números de tarjeta
válidos.

## Ejercicio N° 1
Luego de realizadas las elecciones, el gobierno de una isla caribeña comenzó a
realizar una serie de medidas tendientes a controlar la economía del país y
sus habitantes para la comercialización de dólares. Para ello tiene los
siguientes archivos:  

**Personas**, indexado por DNI 
| DNI *N(8)* | APYNOM *AN(40)* | DIRECCIÓN *AN(60)* | ESTADO CIVIL *("S" - Solt, "C" - Cas, "D" - Divor)* |
|------------|-----------------|--------------------|-----------------------------------------------------|

**Antecedentes**, indexado por DNI, MES 
| DNI *N(8)* | MES *(1..12)* | INGRESOS *N(1,2)* | GASTOS *N(1,2)* |
|------------|---------------|-------------------|-----------------|

**Pedidos de Compra**, ORDENADO por DNI, MES 
| DNI *N(8)* | MES *(1..12)* | MONTO_SOLIC *N(7,2)* |
|------------|---------------|----------------------|

El monto de dinero disponible para realizar una compra de dólares resulta de
calcular, en determinado mes, todos los ingresos de quien es solicitante menos
sus gastos.

Además se cuenta con una lista simple que permite implementar una alícuota
para definir el monto mínimo de compra y monto máximo de compra, teniendo en
cuenta el mes y el estado civil (la lista contiene información de la alícuota
mínima y máxima, según el mes y el estado civil). La alícuota se aplica de la
siguiente manera (ejemplo): Alícuota mínima: 18%; alícuota máxima: 30%; monto
para compra = $50000 monto mínimo de compra = $50000 * 18%; monto máximo = $50000 * 25%

Se solicita, entonces, un algoritmo que permita:
1. Almacenar, en una estructura de datos adecuada, los pedidos de compra de
dólares autorizados (con DNI, MES, y MONTO SOLICITADO), teniendo en cuenta
monto de dinero disponible, monto máximo y monto mínimo por solicitante.
2. Almacenar, en una estructura de datos adecuada, los pedidos de compra que
no han sido autorizados, informando motivo ("1" - Excede monto máximo | "2" - 
No alcanza monto mínimo).
3. Informar porcentaje de pedidos rechazados sobre el total de pedidos de compras.

## Ejercicio N° 2
Dada una lista circular simple, que contiene códigos en formato numérico (12),
se solicita mostrar por pantalla aquellos códigos que cumplan la siguiente
condición:

- El dígito ubicado en la posición K (de atrás para adelante) del mismo debe
ser un número primo.
- La posición K debe ser ingresada por el usuario, y para saber si el número
es primo o no debe realizar una función recursiva.

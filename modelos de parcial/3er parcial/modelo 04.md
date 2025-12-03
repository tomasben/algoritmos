## Ejercicio N° 1
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

Se posee además una lista circular simple con códigos de cupones de descuento
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

<details>
<summary>Solución</summary>

```
accion ejercicio() es
  ambiente
    
  proceso

fin_accion
```

</details>

## Ejercicio N° 2
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
- Comenzar a procesar desde el último dígito hacia el primero.
- Doblar (duplicar) los dígitos en posiciones impares. Si el resultado de la
operación es mayor que 9, se deben sumar los dígitos del número (por ejemplo,
si el resultado es 14, entonces 1 + 4 = 5).
- Sumar todos los dígitos obtenidos.
- Verificar si la suma de los dígitos es divisible por 10. En caso de serlo,
el número de tarjeta es válido.

2. Eliminar de la lista de entrada aquellas compras que se hayan realizado con
un número de tarjeta inválido, sin modificar los nodos con números de tarjeta
válidos.

Caso base:
  verdadero, si pos = 0 && num MOD 10 = 0
  falso, si pos = 0 && num MOD 10 <> 0
Caso recursivo:
  es_valida(tarj, pos - 1, sum + tarj[pos]), si (pos > 1) && ((pos MOD 2) = 0)
  es_valida(tarj, pos - 1, sum + suma_doble), si (pos > 1) && ((pos MOD 2) <> 0)
  
<details>
<summary>Solución</summary>

```
accion ejercicio(prim, ult: puntero Nodo) es
  ambiente
    Nodo = registro
      id_com: N(8)
      fecha: N(8)
      método: ("TC", "TD", "EF")
      nro_tarj: arreglo [1..16] de N(1)
      monto: real
      ant, prox: puntero a Nodo
    fin_registro
    
    aux, a, p: puntero a Nodo
    
    funcion es_valida(tarj: arreglo [1..6] de N(1), pos: entero,
      total: entero): logico es
      ambiente
        dig: entero
      proceso
        si (pos = 0) entonces
          si ((total MOD 10) = 0) entonces
            es_valida := verdadero
          contrario
            es_valida := falso
          fin_si
        contrario 
          si ((pos MOD 2) = 0) entonces
            es_valida := es_valida(tarj, pos - 1, total + tarj[pos])
          contrario
            dig := (total MOD 10) * 2
            
            si (dig > 9) entonces
              mientras (dig <> 0) hacer
                total := total + (dig MOD 10)
                dig := dig DIV 10
              fin_mientras
              es_valida := es_valida(tarj, pos - 1, total)
            contrario
              es_valida := es_valida(tarj, pos - 1, total + dig)
            fin_si
          fin_si
        fin_si
    fin_funcion
  proceso
    a := nil
    p := prim
    
    mientras (p <> nil) hacer
      si (*p.metodo = "TC") && (es_valida(*p.nro_tarj, 16, 0)) entonces
        a := p  
        p := *p.prox
      contrario
        si (a = nil) entonces
          aux := p
          p := *p.prox
          *p.ant := nil
          prim := p
          disponer(aux)
        contrario
          si (*p.prox = nil) entonces
            *a.prox := nil
            ult := a
            disponer(p)
          contrario
            aux := p
            p := *p.prox
            *p.ant := a
            *a.prox := p
            disponer(aux)
          fin_si
        fin_si
      fin_si
    fin_mientras
fin_accion
```

</details>

## Ejercicio N° 1
La empresa “El Dormilón” se dedica a la venta de colchones posee el siguiente
archivo secuencial con información de todas las ventas del último mes (cada
entrada del archivo significa una venta), el mismo no se encuentra ordenado
por ningún campo:

**VENTAS** (archivo secuencial)
| Id_Venta N(8) | Cod_Articulo N(8) | Precio N(18,2) | Dimensión X N(3) | Dimensión Y N(3) |
|---------------|-------------------|----------------|------------------|------------------|

El dato "Cod_Articulo" es un dato único, los cuales están almacenados en una
lista simplemente encadenada ordenada por el campo tipo, con los siguientes datos:

**ARTICULOS**
| Cod_Articulo N(8) | Modelo AN(40) | Fabricante AN(40) | Comision N(2) |
|-------------------|---------------|-------------------|---------------|

La comisión es el porcentaje con el cual se queda la fábrica por el producto
vendido. La empresa le ha solicitado que escriba un algoritmo que permita:
1. Generar una lista simplemente encadenada que posea por lo menos los
siguientes datos: Cod_Articulo, Fabricante, Modelo y cantidad vendida en el
último mes. La lista debe estar ordenada por Cod_Articulo.
2. Informar la ganancia total de “El Dormilón”. Por cada venta se debe
calcular: precio - (precio * comisión/100)

<details>
<summary>Solución</summary>

```
accion ejercicio(prim: puntero a Articulo) es
  ambiente
    Venta = registro
      id_venta: N(8)
      cod_art: N(8)
      precio: N(18,2)
      dim_x: N(3)
      dim_y: N(3)
    fin_registro
    
    Articulo = registro
      cod_art: N(8)
      modelo: AN(40)
      fabricante: AN(40)
      com: N(2)
    fin_registro
    
    Nodo = registro
      cod_art: N(8)
      fabricante: AN(40)
      modelo: AN(40)
      ventas: entero
    fin_registro
    
    ventas: archivo de Venta
    ven: Venta
    
    total: entero
    p: puntero a Articulo
    prim_q, a, q: puntero a Nodo
  proceso
    abrir e/ (ventas); leer(ventas, ven)
    total := 0
    
    prim_q := nil
    
    mientras no fda(ventas) hacer
      p := prim
      mientras (p <> nil) y (*p.cod_art <> ven.cod_art) hacer
        p := *p.prox
      fin_mientras
      
      si (p = nil) entonces
        escribir("Error: no se encontró información del producto vendido.")
      contrario
        a := nil
        q := prim_q
        
        mientras (q <> nil) y (*q.cod_art < vent.cod_art) hacer
          a := q
          q := *q.prox
        fin_mientras
        
        si (a = nil) entonces
          nuevo(q)
          *q.prox := prim_q
          prim_q := q
        contrario
          si (q = nil) entonces
            nuevo(q)
            *q.
          contrario
          
          fin_si
        fin_si
        
      fin_si
      
    fin_mientras
  
fin_accion
```

</details>

## Ejercicio N° 2
Dada una lista doblemente encadenada de números naturales, se desea eliminar
de la lista todos los elementos cuyo “número promedio” sea igual a un valor
ingresado por el usuario. Para calcular el número promedio de un número, se
debe utilizar una función recursiva. Dado un número natural, definiremos como
su número promedio al número que se obtiene de sumar sus dígitos impares y
restar sus dígitos pares. Por ej.: el número promedio de 318547 es 4 esto es,
numeroPromedio(318547) = numeroPromedio(31854)+7 = numeroPromedio(3185) - 4 + 7 = …

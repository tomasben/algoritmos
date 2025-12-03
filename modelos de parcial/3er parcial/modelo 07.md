## Ejercicio N° 1
Una empresa de helados llamada FRREze trabaja actualmente con listas para
manejar los pedidos que recibe y, al final de la jornada, los vuelca al disco
rígido. Sin embargo desea ampliar las funcionalidades del sistema actual para
ofrecer mayor información sobre las ventas diarias a los administradores. Se
posee una lista simplemente enlazada, ordenada, de los gustos de la empresa
con sus correspondientes nombres y precio por unidad.

| CodGusto N(10) | Nombre Gusto AN(50) | Precio Unitario N(5,2) |
|----------------|---------------------|------------------------|

A su vez se posee otra lista simplemente encadenada, de pedidos por día
ordenada por CodPedido y CodGusto. Cada vez que un cliente compra un helado
se almacena el código del pedido, el código del gusto de helado escogido, el
nombre del vendedor y la cantidad de unidades del mismo.

| CodPedido N(10) | CodGusto N(10) | Nombre vendedor AN(30) | Cantidad N(10) |
|-----------------|----------------|------------------------|----------------|
   
Las dos funcionalidades adicionales que se desean son:
1. Generar una lista doblemente enlazada de los gustos de helado vendidos en
el día, indicando código del gusto y su cantidad total.
2. Una opción para consultar que, a partir del nombre de un gusto, ingresado
por teclado, muestre el monto ($) obtenido en el día por ese gusto. Considerar
que solo se realiza una sola consulta y en caso de errores en el ingreso
informar por pantalla.

<details>
<summary>Solución</summary>

```
accion ejercicio(gustos: puntero a Gusto, pedidos: puntero a Orden) es
  ambiente
    Gusto = registro
      cod_gus: N(10)
      nom: AN(50)
      precio: N(5,2)
    fin_registro
    
    Orden = registro
      cod_ped: N(10)
      cod_gus: N(10)
      nom: AN(30)
      cant: N(10)
    fin_registro
    
    Resumen = registro
      cod_gus: N(10)
      cant: entero
      ant, prox: puntero a Resumen
    fin_registro
    
    g: puntero a Gustos
    p: puntero a Orden
    prim_q, ult_q, q: puntero a Resumen
    continuar: caracter
    buscado: N(10)
  proceso
    p := pedidos
    prim_q := nil
    ult_q := nil
    
    mientras (p <> nil) hacer
      q := prim_q
    
      // si la lista de pedidos en el día ésta vacía, creo un nuevo nodo
      si (q = nil) entonces
        nuevo(q)
        *q.cod_gus := *p.cod_gus
        *q.cant := *p.cant
        *q.prox := nil
        *q.ant := nil
        prim_q := q
        ult_q := q
      contrario
        // en caso de tener elementos, buso el nodo del gusto 
        mientras (q <> nil) y (*q.cod_gus <> *p.cod_gus) hacer
          q := *q.prox
        fin_mientras
        
        // si no lo encontré, creo el nodo y lo añado al final
        si (q = nil) entonces
          nuevo(q)
          *q.cod_gus := *p.cod_gus
          *q.cant := *p.cant
          *ult_q.prox := q
          *q.ant := ult_q
          *q.prox := nil
          ult_q := q
        contrario
          // en caso de haberlo encontrado, sumo la cantidad de la compra
          *q.cant := *q.cant + *p.cant
        fin_si
      fin_si
      
      p := *p.prox
    fin_mientras
    
    escribir("Consultar montos recaudados por gusto de helado")
    repetir
      escribir("Ingrese el código del gusto buscado: ")
      leer(buscado)
      
      q := prim_q
      mientras (q <> nil) y (*q.cod_gus <> buscado) hacer
        q := *q.prox
      fin_mientras
      
      si (q = nil) entonces
        escribir("No se registraron ventas en el día para el gusto ingresado.")
      contrario
        g := gustos
        mientras (g <> nil) y (*g.cod_gus <> *q.cod_gus) hacer
          g := *g.prox
        fin_mientras
        
        si (g <> nil) entonces
          escribir("El monto total recaudado en el día para el gusto: ", *g.nom,
          " fue de $", *q.cant * *g.precio)
          
        contrario 
          escribir("Error: no se encontró información del gusto de helado")
        fin_si
        
      fin_si
      
      escribir("Desea realizar otra consulta? [s/n]")
      leer(continuar)
    hasta que (continuar = 'n')
fin_accion
```

</details>

## Ejercico N° 2
Dada una lista circular simplemente encadenada de números enteros positivos,
se desea eliminar de la lista todos los números que contengan más de 2 dígitos
igual a cero (en cualquier posición). Para detectar dichos números debe
utilizar una función recursiva que reciba un número entero positivo, por
ejemplo 1007, y devuelva un número que indique la cantidad de ceros que hay en
el número, en este caso 2.

Caso base:
  verdadero, si num = 0 && cant > 2
  falso, si num = 0 && cant <= 2
  verdadero, si num <> 0 && cant > 2
Caso recursivo:
  contiene_ceros(num DIV 10, cant + 1), si num <> 0 && num MOD 10 = 0
  contiene_ceros(num DIV 10, cant), si num <> 0 && num MOD 10 <> 0

<details>
<summary>Solución</summary>

```
accion ejercicio(prim: puntero a Nodo) es
  ambiente
    Nodo = registro
      num: entero
      prox: puntero a Nodo
    fin_registro
    
    a, p, aux: puntero a Nodo
    
    función contiene_ceros(num: entero, cant: entero): lógico es
      si (num = 0) entonces
        si (cant > 2) entonces
          contiene_ceros := verdadero
        contrario
          contiene_ceros := falso
        fin_si
      contrario
        si (cant > 2) entonces
          contiene_ceros := verdadero
        fin_si
      
        si ((num MOD 10) = 0) entonces
          contiene_ceros := contiene_ceros(num DIV 10, cant + 1)
        contrario
          contiene_ceros := contiene_ceros(num DIV 10, cant)
        fin_si
      fin_si
    fin_funcion
  proceso
    p := prim
    
    mientras (*p.prox <> prim) hacer
      si (contiene_ceros(*p.num, 0)) entonces
        aux := p
        p := *p.prox
        si (a = nil) entonces
          prim := p
        contrario 
          *a.prox := p
        fin_si
        disponer(aux)
      contrario  
        a := p
        p := *p.prox
      fin_si
    fin_mientras
   
    // al haber parado antes del último elemento, nos quedó un nodo sin tratar
    si (contiene_ceros(*p.num, 0)) entonces
      *a.prox := *p.prox
      disponer(p)
    fin_si
fin_accion
```

</details>

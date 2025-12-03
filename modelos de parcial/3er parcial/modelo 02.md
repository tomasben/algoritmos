## Ejercicio N° 1
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

```
accion ejercicio es
  ambiente
    Fecha = registro
      año: N(4)
      mes: 1..12
      dia: 1..31
    fin_registro
  
    Compra = registro
      fecha: Fecha
      dni: N(8)
      cant: entero
      importe: real
    fin_registro
    
    Cliente = registro
      dni: N(8)
      nom: AN(30)
      adhesion: Fecha
      cat: ("Plata",  "Oro", "Diamante", "Black")
    fin_registro
    
    Nodo = registro
      nom: AN(30)
      chances: entero
      prox: puntero a Nodo
    fin_registro
    
    Tira = registro
      num: entero
      prox: puntero a Tira
    fin_registro
    
    compras: archivo de Compra ordenado por fecha
    com: Compra
    clientes: archivo de Cliente indexado por dni
    cli: Cliente
    
    ruleta: puntero a Tira
    r: puntero a Tira
    prim, a, p, q: puntero a Nodo  
    
    funcion girar_ruleta(): entero es
      ambiente
        i, n: 1..55
      proceso
        n := Tirar()
        para i := 1 hasta n hacer
          r := *r.prox
        fin_para
        
        girar_ruleta := *r.num
    fin_funcion
  proceso
    abrir e/ (compras); leer(compras, com)
    abrir e/s (clientes)
  
    // asigno r al principio de la ruleta y no lo modifico más
    r := ruleta
    prim := nil
    
    mientras no fda(compras) hacer
      p := prim
      
      si (p = nil) entonces
        nuevo(q)
        *q.nom := com.nom
        *q.chances := 5
        
        cli.dni := com.dni
        leer(clientes, cli)
        si existe entonces
          si cli.cat = "black" entonces
            *q.chances := 5 + girar_ruleta()
          fin_si
        fin_si
        
        *q.prox := prim
        prim := q
      contrario
        mientras (p <> nil) y (*p.nom <> com.nom) hacer
          a := p
          p := *p.prox
        fin_mientras
        
        si (p = nil) entonces
          nuevo(q)
          
          cli.dni := com.dni
          leer(clientes, cli)
          si existe entonces
            *q.nom := cli.nom
          fin_si
          *q.chances := 5
          
          a := nil
          p := prim
          mientras (p <> nil) y (*q.nom > *p.dato.nom) hacer
            a := p
            p := *p.prox
          fin_mientras
          
          si (a = nil) entonces
            *q.prox := prim
            prim := q
          contrario
            si (p = nil) entonces
              *q.prox := nil
            contrario
              *q.prox := p
            fin_si
            *a.prox := q
          fin_si
        contrario
          *p.chances := *p.chances + com.importe DIV 100 
        fin_si
      fin_si
      
      leer(compras, com)
    fin_mientras
fin_accion
```

## Ejercicio N° 2
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

```
accion ejercicio(prim: puntero a Nodo) es
  ambiente
    Nodo = registro
      dni: N(8)
      nom: AN(30)
      edad: N(2)
      cama: N(3)
      habitación: N(3)
      temp: arreglo [1..4] de real
      prox: puntero a Nodo
    fin_registro
    
    funcion temp_alta(paciente: arreglo [1..4] de real, pos: entero): logico es
      si (pos > 4) entonces
        temp_alta := falso
      contrario
        si (paciente[pos] <= 36.5) entonces
          temp_alta := temp_alta(paciente, pos + 1)
        contrario
          temp_alta := verdadero
        fin_si
      fin_si
    fin_funcion
    
    p, a, aux: puntero a Nodo
  proceso
    p := prim
    
    escribir("Los pacientes con mediciones menores a 36.5° fueron: ")
    mientras (p <> nil) hacer
      si (temp_alta(*p.temp, 1)) entonces
        a := p
        p := *p.prox
      contrario
        escribir(*p.nom)
        
        aux := p
        si (p = prim) entonces
          p := *p.prox
          prim := p
        contrario
          p := *p.prox
          *a.prox := p
        fin_si
        disponer(aux)
      fin_si
    fin_mientras
fin_accion
```

#set page(numbering: "1", margin: (x: 2.2cm, y: 1.8cm))
#set text(lang: "es", size: 10.5pt)
#set heading(numbering: "1.")

#let cell(body) = rect(inset: 6pt, radius: 2pt, stroke: 0.7pt, body)
#let arrow = [→]

= Apunte de listas y punteros

== 1. Punteros: dirección y contenido

Un *puntero* almacena una dirección de memoria. El dato real está en la celda de memoria apuntada por esa dirección.

Analogía útil: una dirección de casa no es la casa. Con la dirección usted *llega* a la casa; con un puntero usted *accede* al dato.

- *Variable*: guarda directamente un valor (por ejemplo, `x = 25`).
- *Puntero* `p`: guarda una dirección (por ejemplo, `0x1040`).
- *Valor apuntado* `*p`: es el contenido guardado en la dirección que está en `p`.

#figure(
  align(center)[
    #table(
      columns: 3,
      inset: 4pt,
      stroke: 0.6pt,
      [*Elemento*], [*Qué guarda*], [*Ejemplo*],
      [Variable `x`], [Dato], [`25`],
      [Puntero `p`], [Dirección], [`0x1040`],
      [Acceso `*p`], [Dato en `0x1040`], [`25`],
    )
  ],
  caption: [Variable, puntero y desreferenciación.]
)

== 2. Notación de pseudocódigo usada en el repositorio

- `NIL`: ausencia de nodo.
- `NUEVO(p)` o `Nuevo(p)`: reserva memoria para un nodo y deja su dirección en `p`.
- `DISPONER(p)` o `Disponer(p)`: libera el nodo apuntado por `p`.
- `p := prim`: `p` pasa a apuntar al primer nodo.
- `*p.campo`: campo del registro almacenado en el nodo apuntado por `p`.
- `p.prox`, `p.ant`: enlaces al siguiente/anterior.
- Parámetros puntero (`prim`, `ult`) pueden cambiar dentro de subacciones: si se inserta o elimina el primer/último nodo, deben actualizarse.

```text
ACCION ejemplo(ES ref prim, ult: puntero a Nodo) ES
  AMBIENTE
    Nodo = REGISTRO
      dato: entero
      ant, prox: puntero a Nodo
    FIN_REGISTRO
  PROCESO
    SI (prim = NIL) ENTONCES
      NUEVO(prim)
      ult := prim
      *prim.ant := NIL
      *prim.prox := NIL
    FIN_SI
FIN_ACCION
```

== 3. Lista enlazada: idea general

Una lista enlazada es una secuencia de nodos conectados por punteros.

- `prim`: puntero externo al primer nodo.
- `ult`: puntero externo al último nodo (si la estructura lo conserva).
- Lista vacía: `prim = NIL` (y si existe `ult`, también `ult = NIL`).

#figure(
  align(center)[
    #cell([`prim`]) #arrow
    #cell([`[dato | prox]`]) #arrow
    #cell([`[dato | prox]`]) #arrow
    #cell([`[dato | NIL]`])
  ],
  caption: [Recorrido de lista simple desde `prim` hasta `NIL`.]
)

Búsqueda típica (con puntero actual `q` y anterior `aux`):

```text
q := prim
aux := NIL
MIENTRAS (q <> NIL) Y (*q.clave <> buscada) HACER
  aux := q
  q := *q.prox
FIN_MIENTRAS
```

== 4. Pilas (LIFO)

En pila, el último en entrar es el primero en salir.

- *Push (carga apilada)*: insertar al inicio.
- *Pop*: extraer del inicio.
- Vacía: `prim = NIL`.

```text
PROCESO apilar(ES ref prim: puntero a Nodo; x: entero)
  NUEVO(q)
  *q.dato := x
  *q.prox := prim
  prim := q
FIN_PROCESO

PROCESO desapilar(ES ref prim: puntero a Nodo; ES ref x: entero)
  SI (prim = NIL) ENTONCES ERROR
  aux := prim
  x := *aux.dato
  prim := *aux.prox
  DISPONER(aux)
FIN_PROCESO
```

#figure(
  align(center)[
    #cell([tope = `prim`])
    #v(0.4em)
    [↓]
    #cell([`[30]`])
    #v(0.4em)
    [↓]
    #cell([`[20]`])
    #v(0.4em)
    [↓]
    #cell([`[10]`])
  ],
  caption: [Pila: inserción y extracción en el tope.]
)

== 5. Colas (FIFO)

En cola, el primero en entrar es el primero en salir.

Conviene guardar *ambos* punteros externos:
- `prim`: frente (de aquí se remueve).
- `ult`: final (aquí se inserta).

Así, *encolar* cuesta `O(1)` sin recorrer toda la lista.

```text
PROCESO encolar(ES ref prim, ult: puntero a Nodo; x: entero)
  NUEVO(q)
  *q.dato := x
  *q.prox := NIL
  SI (prim = NIL) ENTONCES
    prim := q
    ult := q
  CONTRARIO
    *ult.prox := q
    ult := q
  FIN_SI
FIN_PROCESO

PROCESO desencolar(ES ref prim, ult: puntero a Nodo; ES ref x: entero)
  SI (prim = NIL) ENTONCES ERROR
  aux := prim
  x := *aux.dato
  prim := *aux.prox
  SI (prim = NIL) ENTONCES
    ult := NIL
  FIN_SI
  DISPONER(aux)
FIN_PROCESO
```

#figure(
  align(center)[
    #cell([`prim`]) #arrow
    #cell([`[11]`]) #arrow
    #cell([`[22]`]) #arrow
    #cell([`[33]`]) #arrow [ `NIL` ]
    #h(1.2em) #cell([`ult` apunta aquí ↑])
  ],
  caption: [Cola: se inserta por `ult` y se remueve por `prim`.]
)

== 6. Lista simplemente enlazada

=== 6.1 Estructura y recorrido

```text
Nodo = REGISTRO
  dato: TipoDato
  prox: puntero a Nodo
FIN_REGISTRO
```

Listado:

```text
p := prim
MIENTRAS (p <> NIL) HACER
  ESCRIBIR(*p.dato)
  p := *p.prox
FIN_MIENTRAS
```

=== 6.2 Inserción ordenada (vacía / inicio / medio / final)

Patrón con `q` (actual) y `aux` (anterior):

```text
aux := NIL
q := prim
MIENTRAS (q <> NIL) Y (*q.clave < clave_nueva) HACER
  aux := q
  q := *q.prox
FIN_MIENTRAS

NUEVO(p)
*p.clave := clave_nueva
*p.prox := q

SI (aux = NIL) ENTONCES      // vacía o inserción al inicio
  prim := p
CONTRARIO                     // medio o final
  *aux.prox := p
FIN_SI
```

#figure(
  align(center)[
    #cell([Antes: `aux`]) #arrow #cell([`q`]) #arrow #cell([siguiente])
    #v(0.4em)
    [↓ inserto `p`]
    #cell([Después: `aux`]) #arrow #cell([`p` nuevo]) #arrow #cell([`q`])
  ],
  caption: [Inserción entre `aux` y `q` en lista simple.]
)

=== 6.3 Eliminación y actualización

Eliminar requiere primero localizar:

```text
aux := NIL
q := prim
MIENTRAS (q <> NIL) Y (*q.clave <> buscada) HACER
  aux := q
  q := *q.prox
FIN_MIENTRAS

SI (q <> NIL) ENTONCES
  SI (aux = NIL) ENTONCES     // inicio
    prim := *q.prox
  CONTRARIO                   // medio o final
    *aux.prox := *q.prox
  FIN_SI
  DISPONER(q)
FIN_SI
```

Actualizar datos (sin alterar estructura):

```text
SI (q <> NIL) ENTONCES
  *q.dato.campo := nuevo_valor
FIN_SI
```

#figure(
  align(center)[
    #cell([`aux`]) #arrow #cell([`q`]) #arrow #cell([`r`])
    #v(0.4em)
    [↓ eliminar `q`]
    #cell([`aux`]) #arrow #cell([`r`]) #h(1em) [y `DISPONER(q)`]
  ],
  caption: [Eliminación en lista simple (caso medio).]
)

== 7. Lista circular simplemente enlazada

Invariante clave: si `ult` existe, entonces `*ult.prox = prim`.

- No se llega a `NIL` durante el recorrido.
- Condición típica: `MIENTRAS (q.prox <> prim) ...`.
- Debe tratarse aparte el caso de *único nodo* (`prim = ult`).

```text
q := prim
MIENTRAS (*q.prox <> prim) Y (*q.clave <> buscada) HACER
  aux := q
  q := *q.prox
FIN_MIENTRAS
```

Eliminación (resumen):
- Vacía: error.
- Único nodo y coincide: `DISPONER(prim)`, luego `prim := NIL`, `ult := NIL`.
- Inicio: mover `prim` y reconectar `*ult.prox := prim`.
- Medio/final: saltar `q`; si era `ult`, actualizar `ult := aux`.

#figure(
  align(center)[
    #cell([`prim`]) #arrow #cell([A]) #arrow #cell([B]) #arrow #cell([C = ult])
    #v(0.4em)
    [#arrow vuelve a `prim`]
  ],
  caption: [Circularidad simple: el último vuelve al primero.]
)

== 8. Lista doblemente enlazada

Cada nodo tiene `ant` y `prox`.

Invariantes no circulares:
- `*prim.ant = NIL`
- `*ult.prox = NIL`

Al modificar estructura, normalmente se corrigen *dos enlaces*:
- el `prox` de un nodo,
- y el `ant` del nodo contiguo.

```text
Nodo = REGISTRO
  dato: TipoDato
  ant, prox: puntero a Nodo
FIN_REGISTRO
```

Inserción entre `aux` y `q`:

```text
*p.ant := aux
*p.prox := q
SI (aux <> NIL) ENTONCES *aux.prox := p SINO prim := p FIN_SI
SI (q <> NIL) ENTONCES *q.ant := p SINO ult := p FIN_SI
```

Eliminación de `q`:

```text
ant := *q.ant
sig := *q.prox

SI (ant <> NIL) ENTONCES
  *ant.prox := sig
SINO
  prim := sig
FIN_SI

SI (sig <> NIL) ENTONCES
  *sig.ant := ant
SINO
  ult := ant
FIN_SI

DISPONER(q)
```

Casos a cubrir siempre: lista vacía, único nodo, inicio, medio y final.

#figure(
  align(center)[
    #cell([`aux`]) #arrow #cell([`q`]) #arrow #cell([`r`])
    #h(1.2em) [y también: `q.ant` ← `aux`, `r.ant` ← `q`]
    #v(0.4em)
    [↓ inserto `p`]
    #cell([`aux`]) #arrow #cell([`p` nuevo]) #arrow #cell([`q`])
    #h(1.2em) [ajustando `ant` en ambos lados]
  ],
  caption: [Inserción en lista doble: se actualizan enlaces hacia adelante y hacia atrás.]
)

== 9. Lista circular doblemente enlazada (breve)

Invariantes:
- `*prim.ant = ult`
- `*ult.prox = prim`

Diferencias respecto de la doble no circular:
- nunca hay `NIL` entre nodos internos;
- recorridos pueden empezar en cualquier nodo y detenerse al volver al inicio;
- al insertar/eliminar inicio o final, siempre hay que conservar ambos invariantes circulares.

#figure(
  align(center)[
    #cell([`prim`]) #arrow #cell([A]) #arrow #cell([B]) #arrow #cell([`ult`]) #arrow [ `prim` ]
    #v(0.4em)
    [y en sentido inverso: `prim` ← A ← B ← `ult` ← `prim`]
  ],
  caption: [Circular doble: ciclo en ambos sentidos.]
)

== 10. Complejidad temporal

#table(
  columns: 3,
  inset: 4pt,
  stroke: 0.6pt,
  [*Operación*], [*Costo típico*], [*Observación*],
  [Recorrer / buscar], [`O(n)`], [En listas enlazadas se avanza nodo a nodo.],
  [Encontrar posición de inserción/eliminación], [`O(n)`], [El costo dominante suele ser la búsqueda.],
  [Enlazar o desenlazar nodo ya localizado], [`O(1)`], [Cambiar punteros locales es constante.],
  [Push/Pop de pila], [`O(1)`], [Siempre sobre `prim`.],
  [Encolar/Desencolar con `prim` y `ult`], [`O(1)`], [Sin recorrido adicional.],
)

== 11. Estrategia para resolver ejercicios

1. Escriba primero los *casos límite* (vacía, único nodo, inicio, medio, final).
2. Defina qué punteros necesita (`q` actual, `aux` anterior, `prim`, `ult`).
3. Busque la posición con un `MIENTRAS` correcto para el tipo de lista (lineal o circular).
4. Recién después modifique enlaces.
5. Si elimina, reconecte primero y `DISPONER` al final.
6. Verifique invariantes (`prim`, `ult`, circularidad, `ant/prox`).

== 12. Errores frecuentes

- Desreferenciar `NIL` (`*q.campo` cuando `q = NIL`).
- Olvidar actualizar `prim` o `ult` al insertar/eliminar extremos.
- Romper circularidad (no restaurar `ult.prox = prim`, o `prim.ant = ult`).
- Ejecutar `DISPONER` antes de reconectar la lista.
- No separar casos límite (vacía, único nodo, inicio, medio, final).

Este apunte resume los patrones que más se repiten en los ejercicios de `10. listas`.

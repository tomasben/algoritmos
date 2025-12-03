## Ejercicio 1
Durante la Feria del Libro se relevó información sobre las editoriales participantes y los
libros que presentan. Los datos fueron almacenados en dos secuencias de caracteres, las cuales
deben ser procesadas para obtener distintos informes.

**Datos de Entrada**
A. Secuencia de Editoriales:**

Cada editorial está representada de la siguiente manera:
- Nombre de la editorial (cantidad indeterminada de caracteres, finaliza con '&')
- Provincia (2 caracteres que representan un número del '01' al '23')

*Ejemplo:* Planeta&01Sudamericana&03...

B. Secuencia de Libros:

Por cada editorial hay una cantidad indeterminada de libros, separados por el carácter '@'.
Cada libro contiene los siguientes campos:
- Tema (1 carácter): L = Literatura / C = Ciencia / A = Autoayuda y desarrollo personal / I = Infantiles
- Cantidad de páginas: (3 caracteres, por ejemplo 245)
- Nombre del libro (cantidad indeterminada de caracteres, finaliza con '&')
- Resumen: texto libre (finaliza con el carácter '#'). Las palabras están separadas por una
cantidad variable de espacios en blanco.

*Ejemplo:* L245Elprincipito&Una vida a vivir y aprender.#1072El principe del bosque&Una historia sobre la amistad#@C120FisicaparaTodos&Conceptos basicos para jovenes#...

Se solicita escribir un algoritmo en pseudocódigo que permita:
1. Generar una secuencia de salida con los nombres de los libros de tema 'Literatura' (tema = 'L')
que tengan más de 200 y hasta 300 páginas inclusive. Deben estar separados por un '$'.
2. Para cada editorial, informar la longitud promedio de los resúmenes, expresada en cantidad de
palabras (una palabra se define como una secuencia de caracteres alfabéticos, separada por espacios
en blanco).
3. Indicar en qué provincia se encuentra la editorial con mayor cantidad de libros presentados.
Nota: En caso de ser necesario debe escribir una función para convertir caracteres a números.

<details>
<summary>Solución</summary>

```
ACCION ejercicio ES
  AMBIENTE
    editoriales, libros, salida: secuencia de caracter
    ed, li, tema: caracter
    libros, paginas, palabras, may_lib: entero
    provincia, may_lib_prov: N(2)
    i, j, k: entero
    condicion: logico

    FUNCION convertir(car: caracter): entero ES
      SEGUN car HACER
        '0': car_a_num := 0
        '1': car_a_num := 1
        '2': car_a_num := 2
        '3': car_a_num := 3
        '4': car_a_num := 4
        '5': car_a_num := 5
        '6': car_a_num := 6
        '7': car_a_num := 7
        '8': car_a_num := 8
        '9': car_a_num := 9
      FIN_SEGUN
    FIN_FUNCION
  PROCESO
    ARR(editoriales); AVZ(editoriales, ed)
    ARR(libros); AVZ(libros, li)
    CREAR(salida)

    may_lib := 0

    MIENTRAS NO FDS(editoriales) HACER
      ESCRIBIR("Para la editorial: ")
      MIENTRAS ed <> '&' HACER
        ESCRIBIR(ed)
        AVZ(editoriales, ed)
      FIN_MIENTRAS
      AVZ(editoriales, ed)

      provincia := 0
      PARA i := 1 HASTA 0, -1 HACER
        provincia := provincia + convertir(ed) * 10 ** i
        AVZ(editoriales, ed)
      FIN_PARA

      libros := 0
      palabras := 0
      MIENTRAS li <> '@' HACER
        libros := libros + 1

        tema := li
        AVZ(libros, li)

        paginas := 0
        PARA j := 2 HASTA 0, -1 HACER
          paginas := paginas + convertir(j) * 10 ** j
          AVZ(libros, li)
        FIN_PARA

        SI tema = 'T' Y paginas > 200 Y paginas <= 300 ENTONCES
          condicion := verdadero
        CONTRARII
          condicion := falso
        FIN_SI

        MIENTRAS li <> '&' HACER
          SI condicion ENTONCES
            ESCRIBIR(salida, li)
          FIN_SI
          AVZ(libros, li)
        FIN_MIENTRAS
        AVZ(libros, li)

        SI condicion ENTONCES
          ESCRIBIR(salida, '$')
        FIN_SI

        MIENTRAS li <> '#' HACER
          palabras := palabras + 1

          MIENTRAS li <> ' ' Y li <> '#' HACER
            AVZ(libros, li)
          FIN_MIENTRAS
        FIN_MIENTRAS
      FIN_MIENTRAS

      ESCRIBIR("La longitud promedio de los resúmenes fue de: ", palabras / libros, " palabras.")

      SI may_lib < libros ENTONCES
        may_lib := libros
        may_lib_prov := provincia
      FIN_SI
    FIN_MIENTRAS

    ESCRIBIR("La editorial con la mayor cantidad de libros esta ubicada en la provincia nro: " may_lib_prov)

    CERRAR(editoriales)
    CERRAR(libros)
    CERRAR(salida)
FIN_ACCION
```

</details>

## Ejercicio 2
La red de estaciones de carga urbana para vehículos eléctricos (VE) dispone de un sistema de
monitoreo que registra las sesiones de carga realizadas durante el mes de JUNIO. La información
se encuentra ordenada por Número de Estación, Tipo de Vehículo y Número de Carga, y para cada
sesión de carga se registra:

| Nro. de Estación | Tipo de Vehículo (SD, SV, UT) | Nro. Carga | Fecha de carga | Duración carga (minutos) | Costo carga |
|------------------|-------------------------------|------------|----------------|--------------------------|-------------|

Nota: SD: Sedan, SV: Suv y UT: Utilitario

Se pide escribir un algoritmo para:
1. Listar todas las cargas de la primera quincena.
2. Mostrar el total recaudado por estación y por tipo de vehículo.
3. Crear un archivo de salida que contenga, por cada estación:
  - Número de Estación
  - Total recaudado en vehículos de tipo UTILITARIO
4. Informar cuáles son las estaciones de carga que tuvieron mayor recaudación
en vehículos tipo SEDAN que en vehículos tipo UTILITARIO.

<details>
<summary>Solución</summary>

```
ACCION ejercicio ES
  AMBIENTE
    Carga = REGISTRO
      nro_est: N(2)
      tipo: AN(2)
      nro_carga: N(15)
      fecha = REGISTRO
        año: N(4)
        mes: 1..12
        dia: 1..31
      FIN_REGISTRO
      duracion: N(3)
      costo: real
    FIN_REGISTRO

    Informe = REGISTRO
      nro_est: N(2)
      tot_ut: real
    FIN_REGISTRO

    junio: archivo de Carga ordenado por nro_est, tipo, nro_carga
    reg: Carga
    salida: archivo de Informe
    inf: Informe

    cant_est, cant_tipo, est_ut, est_sed: real
    resg_est: N(2)
    resg_tipo: AN(2)

    PROCEDIMIENTO corte_estacion() ES
      corte_tipo()
      ESCRIBIR("Para la estacion ", resg_est, " el total recaudado fue de: ", cant_est)
      cant_est := 0

      inf.nro_est := reg.nro_est
      inf.tot_ut := est.ut
      ESCRIBIR(salida, inf)

      SI est_ut < est_sed ENTONCES
        ESCRIBIR("La estación ", resg_est, " obtuvo mayores ganancias de vehículos de
        tipo sedan que de utilitario.")
      FIN_SI
      est_ut := 0
      est_sed := 0
      resg_est := reg.nro_est
    FIN_PROCEDIMIENTO

    PROCEDIMIENTO corte_tipo() ES
      ESCRIBIR("Para el tipo de vehículo ", resg_tipo, " se registraron ganancias de: ", cant_tipo)
      cant_est := cant_est + cant_tipo
      cant_tipo := 0
      resg_tipo := reg.tipo
    FIN_PROCEDIMIENTO
  PROCESO
    ABRIR E/ (junio); LEER(junio, reg)
    ABRIR /S (salida)

    resg_est := reg.nro_est; resg_tipo := reg.tipo
    cant_est := 0; cant_tipo := 0; est_ut := 0; est_sed := 0

    MIENTRAS NO FDA(junio) HACER
      SI resg_est <> reg.nro_est ENTONCES
        corte_estacion()
      CONTRARIO
        SI resg_tipo <> reg.tipo ENTONCES
          corte_tipo()
        FIN_SI
      FIN_SI

      SI reg.fecha.dia <= 15 ENTONCES
        ESCRIBIR("Estacion: "); ESCRIBIR(reg.nro_est)
        ESCRIBIR("Tipo: "); ESCRIBIR(reg.tipo)
        ESCRIBIR("Importe: "); ESCRIBIR(reg.costo)
      FIN_SI

      SEGUN reg.tipo HACER
        "UT": est_ut := est_ut + reg.costo
        "SD": est_sed := est_sed + reg.costo
      FIN_SI

      cant_tipo := cant_tipo + reg.costo

      LEER(junio, reg)
    FIN_MIENTRAS
    corte_estacion()

    CERRAR(junio)
    CERRAR(salida)
FIN_ACCION
```

</details>

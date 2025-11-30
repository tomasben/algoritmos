- Convertir carácteres a números
```
FUNCION convertir(car: caracter): entero ES
  SEGUN num HACER
    '1': convertir := 1
    '2': convertir := 2
    '3': convertir := 3
    '4': convertir := 4
    '5': convertir := 5
    '6': convertir := 6
    '7': convertir := 7
    '8': convertir := 8
    '9': convertir := 9
  FIN_SEGUN
FIN_FUNCIÓN
```

- Extraer números de secuencias de n enteros o carácteres
```
num := 0
PARA i := (n - 1) HASTA 0, -1 HACER
  num := num + convertir(car) ** (10 * i)
  AVZ(sec, car)
FIN_PARA
```

ó

```
num := 0
PARA i := n HASTA 1, -1 HACER
  num := num + convertir(car) ** (10 * i - 1)
  AVZ(sec, car)
FIN_PARA
```

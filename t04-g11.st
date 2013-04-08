" Grupo 11 "
" Roberto Omaña     06-39990 "
" Leopoldo Pimentel 06-­40095 "

"Parte 1"

OrderedCollection extend [
   
   "1."
   subCollectionFrom: begin to: end [
      |subColeccion|
      subColeccion := OrderedCollection new.
      [begin to: end do: [:each | subColeccion add: (self at:each)]]
         on: Error 
         do: [Transcript show: 'Error en la ejecución de subCollectionFrom: ' ].
      ^subColeccion
   ]
   
   "2."
   filter: condition [
      |filtredCollection|
      filtredCollection:= self select: condition.
      ^filtredCollection
   ]
]

"3."
Array extend [
   esCuadradoMagicoNormal [
      
      |result length magicNumber leftDiagonalSum rightDiagonalSum|
      length:= self size.
      
      "Obtención del número mágico."
      magicNumber:= (length*((length*length)+1))/2.

      "Chequeo si el arreglo es cuadrado y si todos sus elementos
      están comprendidos entre 1 y n²"
      1 to: length do: [:row |
                           |rowList checkRank|
                           rowList := self at:row.
                           checkRank := rowList select: [:each | 
                                         (1<=each) and: (each<=(length*length))
                                         ].
                           (((rowList size) == length) and: ((checkRank size) == length))
                           ifTrue: [nil]
                           ifFalse: [^result:= false].
                        ].
      
      "Chequeo si la suma de los elementos de cada fila es igual al número mágico."
      1 to: length do: [:row |
                           |rowList rowSum|
                           rowList := self at:row.
                           rowSum := 0.
                           1 to: length do: [:col |
                                             |rowElement|
                                             rowElement := rowList at:col.
                                             rowSum := rowSum + rowElement. 
                                          ].
                           (rowSum == magicNumber)
                           ifTrue: [nil]
                           ifFalse: [^result := false]
                        ].
      
      "Chequeo si la suma de los elementos de cada columna es igual al número mágico."
      1 to: length do: [:col |
                           |columnSum|
                           columnSum := 0.
                           1 to: length do: [:row |
                                             |rowList columnElement|
                                             rowList := self at:row.
                                             columnElement := rowList at:col.
                                             columnSum := columnSum + columnElement. 
                                          ].
                           (columnSum == magicNumber)
                           ifTrue: [nil]
                           ifFalse: [^result := false]
                        ].
      
      "Chequeo si la suma de los elementos de cada diagonal es igual al número mágico."
      leftDiagonalSum := 0.
      rightDiagonalSum := 0.
      1 to: length do: [:row |
                           |rowList leftDiagonalElement rightDiagonalElement|
                           rowList := self at:row.
                           leftDiagonalElement := rowList at:row.
                           rightDiagonalElement := rowList at:(length+1-row).
                           leftDiagonalSum := leftDiagonalSum + leftDiagonalElement.
                           rightDiagonalSum := rightDiagonalSum + rightDiagonalElement.
                        ].
      ((leftDiagonalSum == magicNumber) and: (rightDiagonalSum == magicNumber))
      ifTrue: [^result := true]
      ifFalse: [^result := false]
   ]
]

"Parte 2"

Object subclass: Coleccion [
   
   | coleccion |

   "Inicializa la Coleccion en cuestion."
   inicializar [
      <category:'initialization'>
      coleccion := OrderedCollection new.
   ]

   " Devuelve la lista que maneja la Coleccion."
   getColeccion [
      <category:'accessing'>
      ^coleccion
   ]

   "Devuelve true si una coleccion es Vacia, falso sino."
   coleccionVacia [
      ((self getColeccion) size > 0)
      ifTrue: [^false]
      ifFalse: [^true]
   ]

]

"Constructor de la clase Coleccion."
Coleccion class extend [
   
   new [
      | c |
      c := super new.
      c inicializar.
      ^c.
   ]

]

Coleccion subclass: Pila [

   empilar: elemento [
      ^(super getColeccion) addFirst: elemento
   ]

   tope [
      (super coleccionVacia)
      ifTrue: [Transcript show: 'Error en función tope: Pila Vacía.'; cr.]
      ifFalse: [^coleccion first]
   ] 

   desempilar [
      (super coleccionVacia)
      ifTrue: [Transcript show: 'Error en función desempilar: Pila Vacía.'; cr.]
      ifFalse: [^(super getColeccion) removeFirst]
   ]

   desempilarHasta: condicion [
      (super coleccionVacia)
      ifTrue: [Transcript show: 'Error en función desempilarHasta: Pila Vacía.'; cr.]
      ifFalse: [
                  |primerElemento|
                  primerElemento := (super getColeccion) detect: condicion.
                  [self tope ~~ primerElemento] whileTrue: [self desempilar].
                  ^(super getColeccion)
               ]
      
   ]

]

"Constructor de la clase Pila"
Pila class extend [
    
   new [
      ^(super new)
   ]

]

Coleccion subclass: Cola [

   getCola [
      ^(super getColeccion)
   ]

   encolar: elemento [
      ^(self getCola) addLast: elemento
   ]

   proximo [
      (super coleccionVacia)
      ifTrue: [Transcript show: 'Error en función proximo: Cola Vacía.'; cr.]
      ifFalse: [^(self getCola) first]
   ]

   desencolar [
      (super coleccionVacia)
      ifTrue: [Transcript show: 'Error en función desencolar: Cola Vacía.'; cr.]
      ifFalse:[^(self getCola) removeFirst]
   ]

]

"Constructor de la clase Cola"
Cola class extend [
   
   new [
      ^(super new)
   ]

]

Cola subclass: ColaMemoria [
   
   |desencolados|

   inicializar [
      <category:'initialization'>
      desencolados := OrderedCollection new.
   ]

   encolar: elemento [
      ^(super getCola) addLast: elemento
   ]

   proximo [
      (super coleccionVacia)
      ifTrue: [Transcript show: 'Error en función proximo: ColaMemoria Vacía.'; cr.]
      ifFalse: [^(super proximo)]
   ]

   desencolar [
      (super coleccionVacia)
      ifTrue: [Transcript show: 'Error en función desencolar: ColaMemoria Vacía.'; cr.]
      ifFalse:[
               (self obtenerDesencolados) add: (self proximo).
               ^(super desencolar)
            ]
   ]

   obtenerDesencolados [
      <category:'accessing'>
      ^desencolados
   ]
]

ColaMemoria class extend [
   
   new [
      | colaMemoria |
      colaMemoria := super new.
      colaMemoria inicializar.
      ^colaMemoria.
   ]

]

"Main"

|a b c d e f g h i j arreglo k|

" Declaremos una Lista Ordenada "
a := OrderedCollection new.
a add: 8.
a add: 9.
a add: 10.
a add: 11.
a printNl.

b:= a subCollectionFrom: 1 to: 2.
b printNl.

c := a filter: [:x|x>9].
c printNl.

d := Pila new.
d printNl.

d empilar: 12.
(d getColeccion) printNl.

d empilar: 25.
(d getColeccion) printNl.

d empilar: 33.
(d getColeccion) printNl.

d empilar: 48.
(d getColeccion) printNl.

e := d tope.
e printNl. 

d desempilar.
(d getColeccion) printNl.

d desempilarHasta: [:x|x<25].
(d getColeccion) printNl.


f := Cola new.
f printNl.

f encolar: 12.
(f getColeccion) printNl.

f encolar: 25.
(f getColeccion) printNl.

e := f proximo.
e printNl. 

f desencolar.
(f getColeccion) printNl.


g := ColaMemoria new.
g printNl.

g encolar: 10.
(g getColeccion) printNl.

g encolar: 22.
(g getColeccion) printNl.

i := g proximo.
i printNl. 

g desencolar.
(g getColeccion) printNl.

h := g obtenerDesencolados.
h printNl.
" Grupo 11 "
" Roberto Omaña     06-39990 "
" Leopoldo Pimentel 06-­40095 "

"Parte 1"

OrderedCollection extend [
   subCollectionFrom: begin to: end [
      begin to: end do: [:i | self at:i]
   ]

   filter: condicion [
      |coleccionFiltrada|
      coleccionFiltrada:= self select: condicion.
      ^coleccionFiltrada
   ]
]

|a b c|

" Declaremos una Lista Ordenada "
a := OrderedCollection new.
a add: 1.
a add: 2.
a add: 3.
a add: 4.
a printNl.

b:= a subCollectionFrom: 2 to: 3.
b printNl.

c := a filter: [:x|x<3].
c printNl.
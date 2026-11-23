"
I am a two dimensional array that stores only the elements given to me, each in a `CTLinkedStoragePoolArray2DNode`. My instance variables `rows` and `columns` hold a `CTLinkedStoragePoolCircular` for each row and for each column, and a node is pushed on both the lists of its position.

- `dimensions:terms:`, on my class side, takes the number of rows and columns and the associations from positions to elements.
- `at:at:put:` pushes a new node and answers it.
- `at:at:` answers the node at a position, or a new one with the coefficient 0 that is not stored.

```smalltalk
| array |
array := CTLinkedStoragePoolArray2D
	dimensions: #( 4 4 )
	terms: {
		(#( 1 1 ) -> 50).
		(#( 2 3 ) -> 20) }.
(array at: 2 at: 3) coeff. ""20""
(array at: 2 at: 2) coeff ""0""
```

The method `pivotNode:` is empty.
"
Class {
	#name : #CTLinkedStoragePoolArray2D,
	#superclass : #Object,
	#instVars : [
		'rows',
		'columns'
	],
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #creating }
CTLinkedStoragePoolArray2D class >> dimensions: dims terms: coefficients [
	| array sorted |
	array := self new
		         rows:
			         ((1 to: dims first) collect: [ :i | 
					          CTLinkedStoragePoolCircular new ]);
		         columns:
			         ((1 to: dims second) collect: [ :i | 
					          CTLinkedStoragePoolCircular new ]);
		         yourself.
	sorted := SortedCollection sortUsing: [ :a :b | 
		          a key hornerBase2 < b key hornerBase2 ].
	sorted addAll: coefficients.
	sorted do: [ :anAssoc | 
		| position coeff |
		position := anAssoc key.
		coeff := anAssoc value.
		array at: position first at: position second put: coeff ].
	^ array
]

{ #category : #accessing }
CTLinkedStoragePoolArray2D >> at: row at: col [
	^ Continuation currentDo: [ :hop | 
		  (rows at: row) do: [ :node | 
			  node column = col ifTrue: [ hop value: node ] ].
		  CTLinkedStoragePoolArray2DNode new
			  coeff: 0;
			  row: row;
			  column: col;
			  yourself ]
]

{ #category : #accessing }
CTLinkedStoragePoolArray2D >> at: row at: col put: anObject [
	| rowLink colLink node |
	node := CTLinkedStoragePoolArray2DNode new
		        coeff: anObject;
		        row: row;
		        column: col;
		        yourself.
	rowLink := (rows at: row) push: node.
	colLink := (columns at: col) push: node.
	^ node
		  rowLink: rowLink;
		  colLink: colLink;
		  yourself
]

{ #category : #accessing }
CTLinkedStoragePoolArray2D >> columns: anObject [
	columns := anObject
]

{ #category : #accessing }
CTLinkedStoragePoolArray2D >> pivotNode: aNode [
	
]

{ #category : #accessing }
CTLinkedStoragePoolArray2D >> rows: anObject [
	rows := anObject
]

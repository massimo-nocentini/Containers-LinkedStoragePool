Class {
	#name : #CTLinkedStoragePoolArray2D,
	#superclass : #Object,
	#instVars : [
		'rows',
		'columns'
	],
	#category : #'Containers-LinkedStoragePool-Examples'
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
CTLinkedStoragePoolArray2D >> at: row at: col put: anObject [
	| rowLink colLink node |
	node := CTLinkedStoragePoolArray2DNode new
		        coeff: anObject;
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
CTLinkedStoragePoolArray2D >> rows: anObject [
	rows := anObject
]

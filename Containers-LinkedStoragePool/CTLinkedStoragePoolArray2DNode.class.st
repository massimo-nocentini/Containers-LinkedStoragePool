Class {
	#name : #CTLinkedStoragePoolArray2DNode,
	#superclass : #Object,
	#instVars : [
		'coeff',
		'rowLink',
		'colLink',
		'row',
		'column'
	],
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> coeff [
	^ coeff
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> coeff: anObject [
	coeff := anObject
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> colLink [
	^ colLink
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> colLink: anObject [
	colLink := anObject
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> column [
	^ column
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> column: anObject [
	column := anObject
]

{ #category : #printing }
CTLinkedStoragePoolArray2DNode >> printOn: aStream [
	aStream
		nextPutAll: coeff asString;
		nextPutAll: ('({1} {2})' format: { 
						 row.
						 column }) subscript
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> row [
	^ row
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> row: anObject [
	row := anObject
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> rowLink [
	^ rowLink
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> rowLink: anObject [
	rowLink := anObject
]

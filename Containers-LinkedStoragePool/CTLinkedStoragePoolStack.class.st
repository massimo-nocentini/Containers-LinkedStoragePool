Class {
	#name : #CTLinkedStoragePoolStack,
	#superclass : #CTLinkedStoragePool,
	#instVars : [
		'top'
	],
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #initialization }
CTLinkedStoragePoolStack >> newLink [
	^ ValueLink new
]

{ #category : #adding }
CTLinkedStoragePoolStack >> pop [
	^ top ifNil: [ CollectionIsEmpty signal ] ifNotNil: [ 
		  | p y |
		  p := top.
		  top := p nextLink.
		  y := p value.
		  self releaseLink: p.
		  y ]
]

{ #category : #adding }
CTLinkedStoragePoolStack >> push: anObject [
	top := self allocateOrReuse
		       value: anObject;
		       nextLink: top;
		       yourself
]

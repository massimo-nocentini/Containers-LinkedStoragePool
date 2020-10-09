Class {
	#name : #CTLinkedStoragePoolStack,
	#superclass : #CTLinkedStoragePool,
	#instVars : [
		'top'
	],
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #adding }
CTLinkedStoragePoolStack >> pop [
	^ top ifNil: [ CollectionIsEmpty signal ] ifNotNil: [ 
		  | p |
		  p := top.
		  top := top nextLink.
		  p value ignoreBlock: [ self releaseLink: p ] ]
]

{ #category : #adding }
CTLinkedStoragePoolStack >> push: anObject [
	top := self allocateOrReuse
		       value: anObject;
		       nextLink: top;
		       yourself
]

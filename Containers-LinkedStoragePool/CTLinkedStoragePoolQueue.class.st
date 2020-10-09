Class {
	#name : #CTLinkedStoragePoolQueue,
	#superclass : #CTLinkedStoragePoolStack,
	#instVars : [
		'bottom'
	],
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #adding }
CTLinkedStoragePoolQueue >> pop [
	^ top ifNil: [ CollectionIsEmpty signal ] ifNotNil: [ 
		  | p |
		  p := top.
		  top := top nextLink.
		  p value ignoreBlock: [ 
			  self releaseLink: p.
			  top ifNil: [ bottom := top ] ] ]
]

{ #category : #adding }
CTLinkedStoragePoolQueue >> push: anObject [
	| p |
	p := self allocateOrReuse
		     value: anObject;
		     nextLink: nil;
		     yourself.
	top ifNil: [ top := p ] ifNotNil: [ bottom nextLink: p ].
	bottom := p
]
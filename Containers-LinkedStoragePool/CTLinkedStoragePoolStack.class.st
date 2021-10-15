Class {
	#name : #CTLinkedStoragePoolStack,
	#superclass : #CTLinkedStoragePool,
	#instVars : [
		'top'
	],
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #adding }
CTLinkedStoragePoolStack >> head [

	^ top ifNil: [ CollectionIsEmpty signal ] ifNotNil: [ top value ]
]

{ #category : #'as yet unclassified' }
CTLinkedStoragePoolStack >> ifEmpty: eBlock ifNotEmpty: neBlock [
	^ top ifNil: [ eBlock cull: self ] ifNotNil: [ neBlock cull: self ]
]

{ #category : #testing }
CTLinkedStoragePoolStack >> isEmpty [
	^ top isNil
]

{ #category : #adding }
CTLinkedStoragePoolStack >> pop [

	^ top ifNil: [ CollectionIsEmpty signal ] ifNotNil: [ 
		  | p |
		  p := top.
		  top := top nextLink.
		  p value yourself: [ self releaseLink: p ] ]
]

{ #category : #adding }
CTLinkedStoragePoolStack >> push: anObject [

	top := self allocateOrReuseLink
		       value: anObject;
		       nextLink: top;
		       yourself
]

{ #category : #removing }
CTLinkedStoragePoolStack >> removeAll [
	| link |
	top ifNotNil: [ 
		link := top.
		[ link nextLink ] whileNotNil: [ link := link nextLink ].
		link nextLink: avail.
		avail := top.
		top := nil ]
]

Class {
	#name : #CTLinkedStoragePoolStack,
	#superclass : #CTLinkedStoragePool,
	#instVars : [
		'top'
	],
	#category : #'Containers-LinkedStoragePool'
}

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
		  p value ignoreBlock: [ self releaseLink: p ] ]
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

Class {
	#name : #CTLinkedStoragePool,
	#superclass : #Object,
	#instVars : [
		'avail'
	],
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #accessing }
CTLinkedStoragePool class >> stack [
	^ CTLinkedStoragePoolStack
]

{ #category : #initialization }
CTLinkedStoragePool >> allocateOrReuse [
	^ avail ifNil: [ self newLink ] ifNotNil: [ 
		  | x |
		  x := avail.
		  avail := avail nextLink.
		  x ]
]

{ #category : #initialization }
CTLinkedStoragePool >> newLink [
	self subclassResponsibility
]

{ #category : #initialization }
CTLinkedStoragePool >> releaseLink: aValueLink [
	aValueLink nextLink: avail.
	avail := aValueLink
]

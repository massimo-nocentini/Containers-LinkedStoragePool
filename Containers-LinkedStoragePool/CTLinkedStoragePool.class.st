Class {
	#name : #CTLinkedStoragePool,
	#superclass : #Object,
	#instVars : [
		'avail'
	],
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #utilities }
CTLinkedStoragePool class >> queue [
	^ CTLinkedStoragePoolQueue
]

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
CTLinkedStoragePool >> free: n [
	[ n > 0 and: [ avail isNotNil ] ] whileTrue: [ 
		avail := avail nextLink ]
]

{ #category : #initialization }
CTLinkedStoragePool >> newLink [
	^ ValueLink new
]

{ #category : #initialization }
CTLinkedStoragePool >> releaseLink: aValueLink [
	aValueLink nextLink: avail.
	avail := aValueLink
]

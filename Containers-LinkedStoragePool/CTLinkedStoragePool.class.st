Class {
	#name : #CTLinkedStoragePool,
	#superclass : #Object,
	#instVars : [
		'avail'
	],
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #'as yet unclassified' }
CTLinkedStoragePool class >> circular [
	^ CTLinkedStoragePoolCircular
]

{ #category : #'as yet unclassified' }
CTLinkedStoragePool class >> doublyCircular [
	^ CTLinkedStoragePoolCircularDoubly
]

{ #category : #'as yet unclassified' }
CTLinkedStoragePool class >> polynomial [
	^ CTLinkedStoragePoolPolynomial
]

{ #category : #utilities }
CTLinkedStoragePool class >> queue [
	^ CTLinkedStoragePoolQueue
]

{ #category : #accessing }
CTLinkedStoragePool class >> stack [
	^ CTLinkedStoragePoolStack
]

{ #category : #initialization }
CTLinkedStoragePool >> allocateOrReuseLink [
	^ avail
		  ifNil: [ self newLink ]
		  ifNotNil: [ avail ignoreBlock: [ avail := avail nextLink ] ]
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

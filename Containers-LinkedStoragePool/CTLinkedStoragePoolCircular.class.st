Class {
	#name : #CTLinkedStoragePoolCircular,
	#superclass : #CTLinkedStoragePool,
	#instVars : [
		'head'
	],
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #initialization }
CTLinkedStoragePoolCircular >> initialize [
	super initialize.
	head := ValueLink new
		        value: 0;
		        yourself.
	head nextLink: head
]

{ #category : #testing }
CTLinkedStoragePoolCircular >> isEmpty [
	^ head nextLink == head
]

{ #category : #initialization }
CTLinkedStoragePoolCircular >> pop [
	^ head nextLink == head
		  ifTrue: [ CollectionIsEmpty signal ]
		  ifFalse: [ 
			  head nextLink in: [ :p | 
				  p value ignoreBlock: [ 
					  head
						  value: head value - 1;
						  nextLink: p nextLink.
					  self releaseLink: p ] ] ]
]

{ #category : #initialization }
CTLinkedStoragePoolCircular >> push: anObject [
	| p |
	p := self allocateOrReuse
		     value: anObject;
		     nextLink: head nextLink;
		     yourself.
	head
		value: head value + 1;
		nextLink: p
]

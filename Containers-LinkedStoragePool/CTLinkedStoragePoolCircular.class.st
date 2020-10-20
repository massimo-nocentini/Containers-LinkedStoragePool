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
	head := self newLink
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
			  | removingLink |
			  removingLink := head nextLink.
			  head
				  value: head value - 1;
				  nextLink: removingLink nextLink.
			  removingLink value ignoreBlock: [ self releaseLink: removingLink ] ]
]

{ #category : #initialization }
CTLinkedStoragePoolCircular >> push: anObject [
	| p |
	p := self allocateOrReuseLink
		     value: anObject;
		     nextLink: head nextLink;
		     yourself.
	head
		value: head value + 1;
		nextLink: p.
	^ p
]

{ #category : #accessing }
CTLinkedStoragePoolCircular >> size [
	^ head value
]

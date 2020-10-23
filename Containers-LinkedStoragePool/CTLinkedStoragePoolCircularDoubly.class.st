Class {
	#name : #CTLinkedStoragePoolCircularDoubly,
	#superclass : #CTLinkedStoragePoolCircular,
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #initialization }
CTLinkedStoragePoolCircularDoubly >> initialize [
	super initialize.
	head previousLink: head
]

{ #category : #testing }
CTLinkedStoragePoolCircularDoubly >> isEmpty [
	^ super isEmpty and: [ head previousLink == head ]
]

{ #category : #initialization }
CTLinkedStoragePoolCircularDoubly >> newLink [
	^ CTDoubleValueLink new
]

{ #category : #'API-remotes' }
CTLinkedStoragePoolCircularDoubly >> pop [
	^ head nextLink == head
		  ifTrue: [ CollectionIsEmpty signal ]
		  ifFalse: [ 
			  | removingLink |
			  removingLink := head nextLink.
			  removingLink previousLink nextLink: removingLink nextLink.
			  removingLink nextLink previousLink: removingLink previousLink.
			  removingLink value ignoreBlock: [ 
				  head value: head value - 1.
				  self releaseLink: removingLink ] ]
]

{ #category : #'API-remotes' }
CTLinkedStoragePoolCircularDoubly >> push: anObject [
	| p |
	"p := self allocateOrReuseLink
		     value: anObject;
		     previousLink: head;
		     nextLink: head nextLink;
		     yourself.
	head nextLink previousLink: p.
	head nextLink: p.
	^ p"
	p := (super push: anObject)
		     previousLink: head;
		     yourself.
	head nextLink nextLink previousLink: p.
	^ p
]

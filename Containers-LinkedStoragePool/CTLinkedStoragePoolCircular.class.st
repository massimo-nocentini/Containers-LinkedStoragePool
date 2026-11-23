"
I am a circular list of linked objects. My instance variable `head` is a link of its own, that holds my `size` as its value: the link after `head` is the one of the last object pushed, and the link of the first object pushed is followed by `head`.

- `push:` adds an object after `head` and answers its link.
- `pop` removes the object after `head` and answers it, or signals `CollectionIsEmpty`.
- `do:` goes from the last object pushed to the first.

```smalltalk
| circular |
circular := CTLinkedStoragePoolCircular new.
circular push: 3; push: 4.
circular size. ""2""
circular pop ""4""
```
"
Class {
	#name : #CTLinkedStoragePoolCircular,
	#superclass : #CTLinkedStoragePool,
	#instVars : [
		'head'
	],
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #enumerating }
CTLinkedStoragePoolCircular >> do: aBlock [
	| p |
	p := head nextLink.
	[ p == head ] whileFalse: [ 
		aBlock value: p value.
		p := p nextLink ]
]

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

	^ self isEmpty
		  ifTrue: [ CollectionIsEmpty signal ]
		  ifFalse: [ 
			  | removingLink |
			  removingLink := head nextLink.
			  head
				  value: head value - 1;
				  nextLink: removingLink nextLink.
			  removingLink value yourself: [ self releaseLink: removingLink ] ]
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

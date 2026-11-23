"
I am a queue of linked objects, the first one pushed is the first one popped. I push after `bottom`, the link of the last object, and I pop from `top`, as a stack does.

```smalltalk
| queue |
queue := CTLinkedStoragePoolQueue new.
queue push: 3; push: 4.
queue pop. ""3""
queue head ""4""
```
"
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
		  p value yourself: [ 
			  self releaseLink: p.
			  top ifNil: [ bottom := top ] ] ]
]

{ #category : #adding }
CTLinkedStoragePoolQueue >> push: anObject [
	| p |
	p := self allocateOrReuseLink
		     value: anObject;
		     nextLink: nil;
		     yourself.
	top ifNil: [ top := p ] ifNotNil: [ bottom nextLink: p ].
	bottom := p
]

{ #category : #removing }
CTLinkedStoragePoolQueue >> removeAll [
	top ifNotNil: [ 
		bottom nextLink: avail.
		avail := top.
		top := bottom := nil ]
]

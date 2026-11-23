"
I am a stack of linked objects, the last one pushed is the first one popped. My instance variable `top` is the link of that object, or nil when I am empty.

- `push:` adds an object, in a link of the pool or in a new one.
- `pop` removes the object on the top, gives its link back to the pool and answers the object.
- `head` answers the object on the top, which stays there.
- `removeAll` gives all my links back to the pool.

Both `pop` and `head` signal `CollectionIsEmpty` when I am empty.

```smalltalk
| stack |
stack := CTLinkedStoragePoolStack new.
stack push: 3; push: 4.
stack pop. ""4""
stack head ""3""
```
"
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

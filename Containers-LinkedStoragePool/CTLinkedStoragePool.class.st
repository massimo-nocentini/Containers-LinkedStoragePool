"
I am the common superclass of the collections made of links that keep the links they release, to use them again. My instance variable `avail` is the first of the released links, chained by their `nextLink`, or nil when there is none.

- `allocateOrReuseLink` takes the first link of `avail`, or a `newLink` when there is none.
- `releaseLink:` puts a link in front of `avail`.
- `newLink` answers a new `ValueLink`; a subclass may answer another kind of link.

My class side names the concrete pools. `circular`, `doublyCircular`, `polynomial` and `queue` answer a class, while `stack` answers a new `CTLinkedStoragePoolStack`:

```smalltalk
| stack |
stack := CTLinkedStoragePool stack.
stack push: 3; push: 4.
stack pop ""4""
```
"
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

	^ CTLinkedStoragePoolStack new
]

{ #category : #initialization }
CTLinkedStoragePool >> allocateOrReuseLink [

	^ avail
		  ifNil: [ self newLink ]
		  ifNotNil: [ avail yourself: [ avail := avail nextLink ] ]
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

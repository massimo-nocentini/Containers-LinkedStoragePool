"
I am a polynomial, kept as a circular list of its terms. A term is an association from the array of its exponents, one for each variable, to its coefficient. The arrays are compared by the numbers whose decimal digits they are, see `exponents:lessThan:` on my class side.

- `termAssociations:` makes a polynomial from a collection of terms, which it sorts in place. The term with the largest exponents is the first one that `do:` and `pop` give.
- `+` adds the terms of the receiver to the argument, which it changes and answers. A term whose coefficient becomes zero is removed. The receiver must not be empty, nor have a term with exponents smaller than those of every term of the argument.

```smalltalk
| p q |
p := CTLinkedStoragePool polynomial termAssociations: {
	(#( 0 1 0 ) -> -2).
	(#( 2 0 0 ) -> 1) }.
q := CTLinkedStoragePool polynomial termAssociations: {
	(#( 0 1 0 ) -> 2).
	(#( 1 0 0 ) -> 1) }.
p + q == q. ""true""
Array streamContents: [ :aStream |
	q do: [ :each | aStream nextPut: each ] ]
""{#(2 0 0)->1. #(1 0 0)->1}""
```
"
Class {
	#name : #CTLinkedStoragePoolPolynomial,
	#superclass : #CTLinkedStoragePoolCircular,
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #comparing }
CTLinkedStoragePoolPolynomial class >> exponents: exponentsP lessThan: exponentsQ [
	^ exponentsP hornerBase10 < exponentsQ hornerBase10
]

{ #category : #creating }
CTLinkedStoragePoolPolynomial class >> termAssociations: aCollection [

	aCollection sort: [ :a :b | self exponents: a key lessThan: b key ].
	^ self new yourself: [ :polynomial | 
		  aCollection do: [ :each | polynomial push: each ] ]
]

{ #category : #adding }
CTLinkedStoragePoolPolynomial >> + anObject [
	^ anObject addPolynomial: self headLink: head
]

{ #category : #adding }
CTLinkedStoragePoolPolynomial >> addPolynomial: aPolynomial headLink: otherHead [
	| p q q1 exponentsP exponentsQ |
	p := otherHead nextLink.
	q1 := head.
	q := q1 nextLink.
	[ 
	[ 
	exponentsP := p value key.
	exponentsQ := q value key.
	self class exponents: exponentsP lessThan: exponentsQ ] whileTrue: [ 
		q1 := q.
		q := q nextLink ].
	exponentsP = exponentsQ
		ifTrue: [ 
			q value value: q value value + p value value.
			q value value = 0
				ifTrue: [ 
					| q2 |
					q2 := q.
					q := q nextLink.
					q1 nextLink: q.
					self releaseLink: q2 ]
				ifFalse: [ 
					q1 := q.
					q := q nextLink ] ]
		ifFalse: [ 
			| q2 |
			q2 := self allocateOrReuseLink
				      value: p value key -> p value value;
				      nextLink: q;
				      yourself.
			q1 nextLink: q2.
			q1 := q2 ].
	p := p nextLink.
	p == otherHead ] whileFalse.
	^ self
]

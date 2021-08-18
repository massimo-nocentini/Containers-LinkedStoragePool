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

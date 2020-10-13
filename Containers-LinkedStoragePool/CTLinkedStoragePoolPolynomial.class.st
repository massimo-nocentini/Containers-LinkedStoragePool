Class {
	#name : #CTLinkedStoragePoolPolynomial,
	#superclass : #CTLinkedStoragePoolCircular,
	#category : #'Containers-LinkedStoragePool'
}

{ #category : #adding }
CTLinkedStoragePoolPolynomial class >> exponents: exponentsP lessThen: exponentsQ [
	exponentsP with: exponentsQ do: [ :p :q | p < q ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'as yet unclassified' }
CTLinkedStoragePoolPolynomial class >> termAssociations: aCollection [
	^ self new ignoreBlock: [ :polynomial | 
		  aCollection do: [ :each | polynomial push: each ] ]
]

{ #category : #adding }
CTLinkedStoragePoolPolynomial >> + anObject [
	^ anObject addPolynomial: self headLink: head
]

{ #category : #adding }
CTLinkedStoragePoolPolynomial >> addPolynomial: aPolynomial headLink: otherHead [
	| p q q1 exponentsP exponentsQ |
	"A1: initialize."
	p := head nextLink.
	q1 := otherHead.
	q := q1 nextLink.

	""
	[ 
	[ 
	exponentsP := p value key.
	exponentsQ := q value key.
	self class exponents: exponentsP lessThen: exponentsQ ] whileTrue: [ 
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
					aPolynomial releaseLink: q2 ]
				ifFalse: [ 
					q1 := q.
					q := q nextLink ] ]
		ifFalse: [ 
			| q2 |
			q2 := aPolynomial allocateOrReuse
				      value: p value key -> p value value;
				      nextLink: q;
				      yourself.
			q1 nextLink: q2.
			q1 := q2 ].
	p := p nextLink.
	p == head ] whileFalse.
	^ aPolynomial
]

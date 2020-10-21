"
A CTLinkedStoragePoolPolynomialTest is a test class for testing the behavior of CTLinkedStoragePoolPolynomial
"
Class {
	#name : #CTLinkedStoragePoolPolynomialTest,
	#superclass : #TestCase,
	#category : #'Containers-LinkedStoragePool-Tests'
}

{ #category : #tests }
CTLinkedStoragePoolPolynomialTest >> testOrderingOfTermsAssociations [
	self
		assert: (CTLinkedStoragePool polynomial
				 exponents: #( 1 0 0 )
				 lessThan: #( 1 2 0 ));
		deny: (CTLinkedStoragePool polynomial
				 exponents: #( 0 0 0 )
				 lessThan: #( 0 0 0 ));
		deny: (CTLinkedStoragePool polynomial
				 exponents: #( 6 0 0 )
				 lessThan: #( 1 2 0 ))
]

{ #category : #tests }
CTLinkedStoragePoolPolynomialTest >> testPolynomialAdditionFromKnuthTextbook [
	self withKnuthPolynomialsDo: [ :p :q | 
		| r |
		"SUT"
		r := p + q.

		"the order is important and the result can be read as side-effect on `p`"
		self assert: r equals: q.

		"Actually check for the result."
		r := Array streamContents: [ :array | 
			     [ r isEmpty ] whileFalse: [ array nextPut: r pop ] ].
		self assert: r equals: { 
				(#( 2 0 0 ) -> 1).
				(#( 1 0 0 ) -> 1).
				(#( 0 1 0 ) -> 1 negated) } ]
]

{ #category : #tests }
CTLinkedStoragePoolPolynomialTest >> testPolynomialAdditionIsCommutativeFromKnuthTextbook [
	self withKnuthPolynomialsDo: [ :p :q | 
		| r |
		"SUT"
		r := q + p.

		"the order is important and the result can be read as side-effect on `p`"
		self assert: r equals: p.

		"Actually check for the result."
		r := Array streamContents: [ :array | 
			     [ r isEmpty ] whileFalse: [ array nextPut: r pop ] ].
		self assert: r equals: { 
				(#( 2 0 0 ) -> 1).
				(#( 1 0 0 ) -> 1).
				(#( 0 1 0 ) -> 1 negated) } ]
]

{ #category : #tests }
CTLinkedStoragePoolPolynomialTest >> withKnuthPolynomialsDo: aBlock [
	| p q |
	p := CTLinkedStoragePool polynomial termAssociations: { 
			     (#( 0 0 1 ) -> 1 negated).
			     (#( 0 1 0 ) -> 2 negated).
			     (#( 2 0 0 ) -> 1) } shuffled.
	q := CTLinkedStoragePool polynomial termAssociations: { 
			     (#( 0 0 1 ) -> 1).
			     (#( 0 1 0 ) -> 1).
			     (#( 1 0 0 ) -> 1) } shuffled.
	aBlock value: p value: q
]

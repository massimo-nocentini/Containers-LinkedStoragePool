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
				 lessThanOrEqualsTo: #( 1 2 0 ));
		deny: (CTLinkedStoragePool polynomial
				 exponents: #( 0 0 0 )
				 lessThanOrEqualsTo: #( 0 0 0 ));
		deny: (CTLinkedStoragePool polynomial
				 exponents: #( 6 0 0 )
				 lessThanOrEqualsTo: #( 1 2 0 ))
]

{ #category : #tests }
CTLinkedStoragePoolPolynomialTest >> testPolynomialsFromKnuthTextbook [
	| p q r |
	p := CTLinkedStoragePool polynomial termAssociations: { 
			     (#( 0 0 1 ) -> 1 negated).
			     (#( 0 1 0 ) -> 2 negated).
			     (#( 2 0 0 ) -> 1) } shuffled.
	q := CTLinkedStoragePool polynomial termAssociations: { 
			     (#( 0 0 1 ) -> 1).
			     (#( 0 1 0 ) -> 1).
			     (#( 1 0 0 ) -> 1) } shuffled.

	"SUT"
	r := q + p.

	"the order is important and the result can be read as side-effect on `p`"
	self assert: r equals: q.

	"Actually check for the result."
	r := Array streamContents: [ :array | 
		     [ r isEmpty ] whileFalse: [ array nextPut: r pop ] ].
	self assert: r equals: { 
			(#( 2 0 0 ) -> 1).
			(#( 1 0 0 ) -> 1).
			(#( 0 1 0 ) -> 1 negated) }
]

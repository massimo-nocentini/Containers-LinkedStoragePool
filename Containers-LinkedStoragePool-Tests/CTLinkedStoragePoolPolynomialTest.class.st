"
A CTLinkedStoragePoolPolynomialTest is a test class for testing the behavior of CTLinkedStoragePoolPolynomial
"
Class {
	#name : #CTLinkedStoragePoolPolynomialTest,
	#superclass : #TestCase,
	#category : #'Containers-LinkedStoragePool-Tests'
}

{ #category : #tests }
CTLinkedStoragePoolPolynomialTest >> testPolynomialsFromKnuthTextbook [
	| p q r |
	p := CTLinkedStoragePool polynomial termAssociations: { 
			     (#( 0 0 1 ) -> 1 negated).
			     (#( 0 1 0 ) -> 2 negated).
			     (#( 2 0 0 ) -> 1) }.
	q := CTLinkedStoragePool polynomial termAssociations: { 
			     (#( 0 0 1 ) -> 1).
			     (#( 0 1 0 ) -> 1).
			     (#( 1 0 0 ) -> 1) }.

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

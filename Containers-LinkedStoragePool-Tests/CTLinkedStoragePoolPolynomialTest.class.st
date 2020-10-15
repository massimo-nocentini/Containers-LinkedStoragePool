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
	r := p + q.

	"the order is important and the result can be read as side-effect on `p`"
	self assert: r equals: p.

	"Actually check for the result."
	r := Array streamContents: [ :array | 
		     [ r isEmpty ] whileFalse: [ array nextPut: r pop ] ].
	self assert: r equals: { 
			(#( 2 0 0 ) -> 1).
			(#( 1 0 0 ) -> 1).
			(#( 0 1 0 ) -> 1 negated) }
]

{ #category : #tests }
CTLinkedStoragePoolPolynomialTest >> testPolynomialAdditionIsCommutativeFromKnuthTextbook [
	| P Q X Y v w terms otherTerms |
	terms := { 
		         (#( 0 0 1 ) -> 1 negated).
		         (#( 0 1 0 ) -> 2 negated).
		         (#( 2 0 0 ) -> 1) }.
	otherTerms := { 
		              (#( 0 0 1 ) -> 1).
		              (#( 0 1 0 ) -> 1).
		              (#( 1 0 0 ) -> 1) }.
	P := CTLinkedStoragePool polynomial termAssociations: terms shuffled.
	X := CTLinkedStoragePool polynomial termAssociations: terms shuffled.
	Q := CTLinkedStoragePool polynomial termAssociations:
		     otherTerms shuffled.
	Y := CTLinkedStoragePool polynomial termAssociations:
		     otherTerms shuffled.

	"Actually check for the result."
	v := Array streamContents: [ :array | 
		     | V |
		     V := P + Q.
		     [ V isEmpty ] whileFalse: [ array nextPut: V pop ] ].
	w := Array streamContents: [ :array | 
		     | W |
		     W := Y + X.
		     [ W isEmpty ] whileFalse: [ array nextPut: W pop ] ].
	self assert: w equals: v
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
	r := p + q.

	"the order is important and the result can be read as side-effect on `p`"
	self assert: r equals: p.

	"Actually check for the result."
	r := Array streamContents: [ :array | 
		     [ r isEmpty ] whileFalse: [ array nextPut: r pop ] ].
	self assert: r equals: { 
			(#( 2 0 0 ) -> 1).
			(#( 1 0 0 ) -> 1).
			(#( 0 1 0 ) -> 1 negated) }
]

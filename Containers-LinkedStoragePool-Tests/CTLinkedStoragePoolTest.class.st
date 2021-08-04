Class {
	#name : #CTLinkedStoragePoolTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-LinkedStoragePool-Tests'
}

{ #category : #tests }
CTLinkedStoragePoolTest >> testEmptyCircularList [

	| stack |
	stack := CTLinkedStoragePoolCircular new.

	^ self
		  assert: stack isEmpty;
		  exportSlotsGraphOf: stack
]

{ #category : #tests }
CTLinkedStoragePoolTest >> testEmptyQueue [

	| queue |
	queue := CTLinkedStoragePoolQueue new.

	^ self
		  assert: queue isEmpty;
		  exportSlotsGraphOf: queue
]

{ #category : #tests }
CTLinkedStoragePoolTest >> testEmptyStack [

	| stack |
	stack := CTLinkedStoragePoolStack new.

	^ self
		  assert: stack isEmpty;
		  exportSlotsGraphOf: stack
]

{ #category : #tests }
CTLinkedStoragePoolTest >> testOrderingOfTermsAssociations [
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
CTLinkedStoragePoolTest >> testPolynomialAdditionFromKnuthTextbook [

	self withKnuthPolynomialsDo: [ :p :q | 
		| r |
		self
			exportSlotsGraphOf: p pathSuffix: 'p';
			exportSlotsGraphOf: q pathSuffix: 'q'.

		"SUT"
		r := p + q.

		self exportSlotsGraphOf: r pathSuffix: 'r'.

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
CTLinkedStoragePoolTest >> testPolynomialAdditionIsCommutativeFromKnuthTextbook [
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
CTLinkedStoragePoolTest >> testPopFromEmptyCircular [

	self
		should: [ 
			CTLinkedStoragePoolCircular new
				push: 3;
				pop;
				pop ]
		raise: CollectionIsEmpty
]

{ #category : #tests }
CTLinkedStoragePoolTest >> testPopFromEmptyQueue [

	self
		should: [ 
			CTLinkedStoragePoolQueue new
				push: 3;
				pop;
				pop ]
		raise: CollectionIsEmpty
]

{ #category : #tests }
CTLinkedStoragePoolTest >> testPopFromEmptyStack [

	self
		should: [ 
			CTLinkedStoragePoolStack new
				push: 3;
				pop;
				pop ]
		raise: CollectionIsEmpty
]

{ #category : #tests }
CTLinkedStoragePoolTest >> testRemoveAllFromQueue [

	| queue |
	queue := (1 to: 5)
		         inject: CTLinkedStoragePoolQueue new
		         into: [ :pool :each | pool push: each ].

	queue
		pop;
		pop.

	self exportSlotsGraphOf: queue pathSuffix: 'full'.

	queue removeAll.

	self exportSlotsGraphOf: queue pathSuffix: 'empty'.

	self assert: queue isEmpty
]

{ #category : #tests }
CTLinkedStoragePoolTest >> testRemoveAllFromStack [

	| stack |
	stack := (1 to: 5)
		         inject: CTLinkedStoragePoolStack new
		         into: [ :pool :each | pool push: each ].

	stack
		pop;
		pop.

	self exportSlotsGraphOf: stack pathSuffix: 'full'.

	stack removeAll.

	self exportSlotsGraphOf: stack pathSuffix: 'empty'.

	self assert: stack isEmpty
]

{ #category : #tests }
CTLinkedStoragePoolTest >> testSomePushesThenPopsOnCircular [

	| circular steps |
	steps := OrderedCollection new
		         add: (Message selector: #push: arguments: { 3 });
		         add: (Message selector: #push: arguments: { 4 });
		         add: (Message selector: #push: arguments: { 5 });
		         add: (Message selector: #pop);
		         add: (Message selector: #pop);
		         add: (Message selector: #pop);
		         add: (Message selector: #push: arguments: { 6 });
		         yourself.

	circular := CTLinkedStoragePoolCircular new.

	steps withIndexDo: [ :each :i | 
		each sendTo: circular.
		self exportSlotsGraphOf: circular pathSuffix: i asString ]
]

{ #category : #tests }
CTLinkedStoragePoolTest >> testSomePushesThenPopsOnQueue [

	| queue steps |
	steps := OrderedCollection new
		         add: (Message selector: #push: arguments: { 3 });
		         add: (Message selector: #push: arguments: { 4 });
		         add: (Message selector: #push: arguments: { 5 });
		         add: (Message selector: #pop);
		         add: (Message selector: #pop);
		         add: (Message selector: #pop);
		         add: (Message selector: #push: arguments: { 6 });
		         yourself.

	queue := CTLinkedStoragePoolQueue new.

	steps withIndexDo: [ :each :i | 
		each sendTo: queue.
		self exportSlotsGraphOf: queue pathSuffix: i asString ]
]

{ #category : #tests }
CTLinkedStoragePoolTest >> testSomePushesThenPopsOnStack [

	| stack steps |
	steps := OrderedCollection new
		         add: (Message selector: #push: arguments: { 3 });
		         add: (Message selector: #push: arguments: { 4 });
		         add: (Message selector: #push: arguments: { 5 });
		         add: (Message selector: #pop);
		         add: (Message selector: #pop);
		         add: (Message selector: #pop);
		         add: (Message selector: #push: arguments: { 6 });
		         yourself.

	stack := CTLinkedStoragePoolStack new.

	steps withIndexDo: [ :each :i | 
		each sendTo: stack.
		self exportSlotsGraphOf: stack pathSuffix: i asString ]
]

{ #category : #tests }
CTLinkedStoragePoolTest >> withKnuthPolynomialsDo: aBlock [
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

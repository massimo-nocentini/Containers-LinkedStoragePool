Class {
	#name : #CTLinkedStoragePoolTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-LinkedStoragePool-Tests'
}

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

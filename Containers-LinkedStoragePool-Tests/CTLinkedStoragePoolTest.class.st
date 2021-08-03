Class {
	#name : #CTLinkedStoragePoolTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-LinkedStoragePool-Tests'
}

{ #category : #tests }
CTLinkedStoragePoolTest >> testEmptyStack [

	^ self exportSlotsGraphOf: CTLinkedStoragePoolStack new
]

{ #category : #tests }
CTLinkedStoragePoolTest >> testSomePushesThenPopsOnStack [

	| stack |
	stack := CTLinkedStoragePoolStack new
		         push: 3;
		         push: 4;
		         push: 5;
		         pop;
		         pop;
		         push: 6;
		         yourself.

	^ self exportSlotsGraphOf: stack
]

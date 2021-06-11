Class {
	#name : #CTLinkedStorageLinkTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-LinkedStoragePool-Tests'
}

{ #category : #utilities }
CTLinkedStorageLinkTest >> imagesPath [

	^ self iceWorkingDirectory / 'images'
]

{ #category : #tests }
CTLinkedStorageLinkTest >> testEmptyLink [

	| l |
	l := Link new.

	^ self exportSlotsGraphOf: l
]

{ #category : #tests }
CTLinkedStorageLinkTest >> testLinkReferencingAnotherLink [

	| l1 l2 |
	l1 := Link new.
	l2 := Link new.

	l1 nextLink: l2.

	^ self exportSlotsGraphOf: l1
]

{ #category : #tests }
CTLinkedStorageLinkTest >> testLinkReferencingAnotherLinkRecursive [

	| l1 l2 |
	l1 := Link new.
	l2 := Link new.

	l1 nextLink: l2.

	^ self exportSlotsGraphOf: l1
]

{ #category : #tests }
CTLinkedStorageLinkTest >> testLinkReferencingItself [

	| l |
	l := Link new.
	l nextLink: l.

	^ self exportSlotsGraphOf: l
]

{ #category : #tests }
CTLinkedStorageLinkTest >> testLinkReferencingItselfRecursive [

	| l |
	l := Link new.
	l nextLink: l.

	^ self exportSlotsGraphOf: l
]

{ #category : #tests }
CTLinkedStorageLinkTest >> testLinkReferencingThree [

	| l |
	l := Link new.
	l nextLink: 3.

	^ self exportSlotsGraphOf: l
]

{ #category : #tests }
CTLinkedStorageLinkTest >> testTwoLinksReferencingEachOtherRecursive [

	| l1 l2 l3 |
	l1 := Link new.
	l2 := Link new.
	l3 := Link new.
	l1 nextLink: l2.
	l2 nextLink: l3.
	l3 nextLink: l1.

	^ self exportSlotsGraphOf: l1
]

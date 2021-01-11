Class {
	#name : #CTLinkedStorageValueLinkTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-LinkedStoragePool-Tests'
}

{ #category : #utilities }
CTLinkedStorageValueLinkTest >> imagesPath [

	^ self iceWorkingDirectory / 'images'
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testEmptyLink [

	| l |
	l := Link new.

	^ self
		  export: l
		  pathSuffix: ''
		  selector: #gtInspectorSlotsGraphInCanvas:
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testLinkReferencingAnotherLink [

	| l1 l2 |
	l1 := Link new.
	l2 := Link new.

	l1 nextLink: l2.

	^ self
		  export: l1
		  pathSuffix: ''
		  selector: #gtInspectorSlotsGraphInCanvas:
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testLinkReferencingAnotherLinkRecursive [

	| l1 l2 |
	l1 := Link new.
	l2 := Link new.

	l1 nextLink: l2.

	^ self export: l1 pathSuffix: '' selector: [ :aLink :aCanvas | 
		  aLink
			  gtInspectorSlotsGraphRecursiveInCanvas: aCanvas
			  recursiveReferences: aLink recursiveReferences ]
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testLinkReferencingItself [

	| l |
	l := Link new.
	l nextLink: l.

	^ self
		  export: l
		  pathSuffix: ''
		  selector: #gtInspectorSlotsGraphInCanvas:
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testLinkReferencingItselfRecursive [

	| l |
	l := Link new.
	l nextLink: l.

	^ self export: l pathSuffix: '' selector: [ :aLink :aCanvas | 
		  aLink
			  gtInspectorSlotsGraphRecursiveInCanvas: aCanvas
			  recursiveReferences: aLink recursiveReferences ]
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testLinkReferencingThree [

	| l |
	l := Link new.
	l nextLink: 3.

	^ self
		  export: l
		  pathSuffix: ''
		  selector: #gtInspectorSlotsGraphInCanvas:
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testTwoLinksReferencingEachOtherRecursive [

	| l1 l2 l3 |
	l1 := Link new.
	l2 := Link new.
	l3 := Link new.
	l1 nextLink: l2.
	l2 nextLink: l3.
	l3 nextLink: l1.

	^ self export: l1 pathSuffix: '' selector: [ :aLink :aCanvas | 
		  aLink
			  gtInspectorSlotsGraphRecursiveInCanvas: aCanvas
			  recursiveReferences: aLink recursiveReferences ]
]

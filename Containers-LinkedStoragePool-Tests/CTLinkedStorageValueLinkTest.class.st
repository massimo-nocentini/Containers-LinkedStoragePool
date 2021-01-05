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
CTLinkedStorageValueLinkTest >> testLinkReferencingItself [

	| l |
	l := Link new.
	l nextLink: l.

	^ self
		  export: l
		  pathSuffix: ''
		  selector: #gtInspectorSlotsGraphInCanvas:;
		  export: l
		  pathSuffix: 'recursive'
		  selector: #gtInspectorSlotsGraphRecursiveInCanvas:
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testTwoLinksReferencingEachOther [

	| l1 l2 |
	l1 := Link new.
	l2 := Link new.
	l1 nextLink: l2.
	l2 nextLink: l1.

	^ self
		  export: l1
		  pathSuffix: ''
		  selector: #gtInspectorSlotsGraphInCanvas:;
		  export: l1
		  pathSuffix: 'recursive'
		  selector: #gtInspectorSlotsGraphRecursiveInCanvas:
]

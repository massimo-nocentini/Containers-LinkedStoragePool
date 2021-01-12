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
CTLinkedStorageValueLinkTest >> test11ValueLinksLoop [

	| l |
	l := 1 ~~> nil.
	l nextLink: l.

	^ self exportSlotsGraphOf: l
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> test11ValueLinksLoopRecursive [

	^ self exportSlotsGraphRecursiveOf: self test11ValueLinksLoop
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> test21ValueLinks [

	| l |
	l := 2 ~~> self testSimpleValueLink.

	^ self exportSlotsGraphOf: l
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> test321ValueLinks [

	| l |
	l := 3 ~~> self test21ValueLinks.

	^ self exportSlotsGraphOf: l
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> test43214ValueLinksFrom2Recursive [

	^ self exportSlotsGraphRecursiveOf:
		  self test43214ValueLinksRecursive nextLink nextLink
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> test43214ValueLinksRecursive [

	| l1 l |
	l1 := 1 ~~> nil.
	l := 4 ~~> (3 ~~> (2 ~~> l1)).
	l1 nextLink: l.
	
	^ self exportSlotsGraphRecursiveOf: l
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> test4321ValueLinks [

	| l |
	l := 4 ~~> self test321ValueLinks.

	^ self exportSlotsGraphOf: l
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> test4321ValueLinksRecursive [

	^ self exportSlotsGraphRecursiveOf: self test4321ValueLinks
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> test4321ValueLinksSimplerRepr [

	^ self
		  export: self test4321ValueLinks
		  pathSuffix: ''
		  selector: #gtInspectorLinksUsingCanvas:
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testAsLinkedList [

	^ self exportSlotsGraphOf: self testSimpleValueLink asLinkedList
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testAsLinkedList4321 [

	^ self exportSlotsGraphOf: self test4321ValueLinks asLinkedList
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testAsLinkedListFromInterval [

	^ self exportSlotsGraphOf: ((1 to: 10) as: LinkedList)
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testAsValueLink [

	^ self exportSlotsGraphRecursiveOf: (1 to: 10) asValueLink
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testNilAsLinkedList [

	^ self exportSlotsGraphOf: nil asLinkedList
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testSimpleValueLink [

	| l |
	l := 1 ~~> nil.

	^ self exportSlotsGraphOf: l
]

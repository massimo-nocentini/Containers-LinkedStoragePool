Extension { #name : #Association }

{ #category : #'*Containers-LinkedStoragePool-Examples' }
Association >> decrementCountIfZero: zBlock forTopologicalSortAlgorithm: aTSA [

	^ (key := key - 1) ifZero: zBlock
]

{ #category : #'*Containers-LinkedStoragePool-Examples' }
Association >> ifSink: sBlock otherwise: oBlock forTopologicalSortAlgorithm: aTSA [

	^ key ifZero: sBlock ifNotZero: oBlock
]

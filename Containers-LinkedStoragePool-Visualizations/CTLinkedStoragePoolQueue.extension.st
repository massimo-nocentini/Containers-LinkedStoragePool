Extension { #name : #CTLinkedStoragePoolQueue }

{ #category : #'*Containers-LinkedStoragePool-Visualizations' }
CTLinkedStoragePoolQueue >> asSlotsGroupKnownReferences: anIdentitySet [
	| aGroup bottomShape bottomEdge |
	aGroup := super asSlotsGroupKnownReferences:
		          anIdentitySet
		          | (bottom ifNil: [ {  } ] ifNotNil: [ { bottom } ]).
	bottomShape := (aGroup shapeFromModel: self) shapeFromModel: bottom.
	bottomEdge := RSEdgeBuilder arrowedLine
		              color: Color gray;
		              toShapes:
			              ({ ((aGroup shapeFromModel: top) shapes 
				                shapeFromModel: bottom) } reject: #isNil);
		              fromShapes: { bottomShape };
		              useAssociation: bottom asReflexiveAssociation.
	^ aGroup
		  add: bottomEdge;
		  yourself
]

{ #category : #'*Containers-LinkedStoragePool-Visualizations' }
CTLinkedStoragePoolQueue >> instVarsNamesOrderedCollection [
	"We choose the following order in which the `value` slot is 
	the rightmost because that allows us to compose better shapes 
	pointed by its reference."

	^ { 
		  (#avail -> [ :_ | avail ]).
		  (#bottom -> [ :_ | bottom ]).
		  (#top -> [ :_ | top ]) }
]

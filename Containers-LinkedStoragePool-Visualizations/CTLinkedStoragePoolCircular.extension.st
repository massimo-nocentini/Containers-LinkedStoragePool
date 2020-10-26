Extension { #name : #CTLinkedStoragePoolCircular }

{ #category : #'*Containers-LinkedStoragePool-Visualizations' }
CTLinkedStoragePoolCircular >> asSlotsGroupKnownReferences: anIdentitySet [
	| aGroup frontGroup rearGroup frontAndRearLinks frontComposite rearComposite composite meShape |
	aGroup := super asSlotsGroupKnownReferences:
		          anIdentitySet | (Array streamContents: [ :aStream | 
			           avail ifNotNil: [ aStream nextPut: avail ].
			           head ifNotNil: [ aStream nextPut: head ] ]).
	frontGroup := avail ifNil: [ RSGroup new ] ifNotNil: [ 
		              avail
			              asSlotsGroupRecursiveKnownReferences: anIdentitySet
			              layoutBlock: [ :shapes | 
			              RSVerticalLineLayout on: shapes ] ].
	rearGroup := head ifNil: [ RSGroup new ] ifNotNil: [ 
		             head
			             asSlotsGroupRecursiveKnownReferences: anIdentitySet
			             layoutBlock: [ :shapes | 
			             RSVerticalLineLayout on: shapes ] ].
	frontAndRearLinks := RSEdgeBuilder arrowedLine
		                     color: Color gray;
		                     toShapes: ({ 
				                      (frontGroup shapeFromModel: avail).
				                      (rearGroup shapeFromModel: head) } reject:
					                      #isNil);
		                     fromShapes: { 
				                     (aGroup shapeFromModel: avail).
				                     (aGroup shapeFromModel: head) };
		                     useAssociations: { 
				                     avail asReflexiveAssociation.
				                     head asReflexiveAssociation }.
	frontComposite := frontGroup asShapeFor: avail.
	rearComposite := rearGroup asShapeFor: head.
	RSHorizontalLineLayout on: { 
			frontComposite.
			rearComposite }.
	composite := RSComposite new
		             shapes: { 
				             frontComposite.
				             rearComposite };
		             yourself.
	meShape := aGroup asShapeFor: self.
	RSVerticalLineLayout new
		alignCenter;
		applyOn: { 
				meShape.
				composite }.
	^ (RSGroup new
		   add: meShape;
		   add: composite;
		   addAll: frontAndRearLinks;
		   yourself) @ RSDraggable
]

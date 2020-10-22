Extension { #name : #CTLinkedStoragePoolStack }

{ #category : #'*Containers-LinkedStoragePool-Visualizations' }
CTLinkedStoragePoolStack >> asSlotsGroupKnownReferences: anIdentitySet [
	| aGroup frontGroup rearGroup frontAndRearLinks frontComposite rearComposite composite meShape |
	aGroup := super asSlotsGroupKnownReferences:
		          anIdentitySet | (Array streamContents: [ :aStream | 
			           avail ifNotNil: [ aStream nextPut: avail ].
			           top ifNotNil: [ aStream nextPut: top ] ]).
	frontGroup := avail ifNil: [ RSGroup new ] ifNotNil: [ 
		              avail
			              asSlotsGroupRecursiveKnownReferences: anIdentitySet
			              layoutBlock: [ :shapes | 
			              RSVerticalLineLayout on: shapes ] ].
	rearGroup := top ifNil: [ RSGroup new ] ifNotNil: [ 
		             top
			             asSlotsGroupRecursiveKnownReferences: anIdentitySet
			             layoutBlock: [ :shapes | 
			             RSVerticalLineLayout on: shapes ] ].
	frontAndRearLinks := RSEdgeBuilder arrowedLine
		                     color: Color gray;
		                     toShapes: ({ 
				                      (frontGroup shapeFromModel: avail).
				                      (rearGroup shapeFromModel: top) } reject:
					                      #isNil);
		                     fromShapes: { 
				                     (aGroup shapeFromModel: avail).
				                     (aGroup shapeFromModel: top) };
		                     useAssociations: { 
				                     avail asReflexiveAssociation.
				                     top asReflexiveAssociation }.
	frontComposite := frontGroup asShapeFor: avail.
	rearComposite := rearGroup asShapeFor: top.
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

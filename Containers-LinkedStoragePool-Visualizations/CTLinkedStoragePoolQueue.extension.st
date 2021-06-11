Extension { #name : #CTLinkedStoragePoolQueue }

{ #category : #'*Containers-LinkedStoragePool-Visualizations' }
CTLinkedStoragePoolQueue >> instVarsNamesOrderedCollection [

	"We choose the following order in which the `value` slot is 
	the rightmost because that allows us to compose better shapes 
	pointed by its reference."

	^ { #avail. #bottom. #top }
]

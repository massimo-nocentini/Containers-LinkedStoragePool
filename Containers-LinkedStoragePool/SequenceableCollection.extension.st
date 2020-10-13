Extension { #name : #SequenceableCollection }

{ #category : #'*Containers-LinkedStoragePool' }
SequenceableCollection >> horner: base [
	^ self inject: 0 into: [ :acc :each | base * acc + each ]
]

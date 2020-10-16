Extension { #name : #SequenceableCollection }

{ #category : #'*Containers-LinkedStoragePool' }
SequenceableCollection >> horner: base init: init [
	^ self inject: init into: [ :acc :each | base * acc + each ]
]

{ #category : #'*Containers-LinkedStoragePool' }
SequenceableCollection >> hornerBase10 [
	^ self horner: 10 init: 0
]

{ #category : #'*Containers-LinkedStoragePool' }
SequenceableCollection >> hornerBase2 [
	^ self horner: 2 init: 0
]

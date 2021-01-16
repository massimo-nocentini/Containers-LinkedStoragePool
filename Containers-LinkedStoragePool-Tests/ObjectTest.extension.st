Extension { #name : #ObjectTest }

{ #category : #'*Containers-LinkedStoragePool-Tests' }
ObjectTest >> testIgnoreBlock [

	| var |
	self
		assert: (3 ignoreBlock: [ 3 + 4 ]) equals: 3;
		assert: (3 + 4 ignoreBlock: [ :seven | seven + 5 ]) equals: 7.

	"#ignoreBlock: can be used to return a value that is bound to a variable 
	 that immediately has to be updated, as follows:"
	var := 7.
	self
		assert: (var ignoreBlock: [ var := var + 1 ]) equals: 7;
		assert: var equals: 8
]

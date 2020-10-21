Class {
	#name : #CTLinkedStoragePoolArray2DTest,
	#superclass : #TestCase,
	#category : #'Containers-LinkedStoragePool-Tests'
}

{ #category : #tests }
CTLinkedStoragePoolArray2DTest >> testPivot [
	| coefficients array |
	coefficients := { 
		                (#( 1 1 ) -> 50).
		                (#( 2 1 ) -> 10).
		                (#( 2 3 ) -> 20).
		                (#( 4 1 ) -> -30).
		                (#( 4 3 ) -> -60).
		                (#( 4 4 ) -> 5) } shuffled.
	array := CTLinkedStoragePoolArray2D
		         dimensions: #( 4 4 )
		         terms: coefficients.
	self
		assert: (array at: 1 at: 1) coeff equals: 50;
		assert: (array at: 1 at: 2) coeff equals: 0;
		assert: (array at: 1 at: 3) coeff equals: 0;
		assert: (array at: 1 at: 4) coeff equals: 0;
		assert: (array at: 2 at: 1) coeff equals: 10;
		assert: (array at: 2 at: 2) coeff equals: 0;
		assert: (array at: 2 at: 3) coeff equals: 20;
		assert: (array at: 2 at: 4) coeff equals: 0;
		assert: (array at: 4 at: 1) coeff equals: -30;
		assert: (array at: 4 at: 2) coeff equals: 0;
		assert: (array at: 4 at: 3) coeff equals: -60;
		assert: (array at: 4 at: 4) coeff equals: 5
]

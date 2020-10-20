Class {
	#name : #CTLinkedStoragePoolArray2DTest,
	#superclass : #TestCase,
	#category : #'Containers-LinkedStoragePool-Tests'
}

{ #category : #tests }
CTLinkedStoragePoolArray2DTest >> testPivot [
	| coefficients |
	coefficients := { 
		                (#( 1 1 ) -> 50).
		                (#( 2 1 ) -> 10).
		                (#( 2 3 ) -> 20).
		                (#( 4 1 ) -> -30).
		                (#( 4 3 ) -> -60).
		                (#( 4 4 ) -> 5) } shuffled.
	CTLinkedStoragePoolArray2D dimensions: #( 4 4 ) terms: coefficients
]

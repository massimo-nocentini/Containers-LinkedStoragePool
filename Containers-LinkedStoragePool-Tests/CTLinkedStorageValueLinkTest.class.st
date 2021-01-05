Class {
	#name : #CTLinkedStorageValueLinkTest,
	#superclass : #TestCase,
	#category : #'Containers-LinkedStoragePool-Tests'
}

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testEmptyLink [

	| l |
	l := Link new
]

{ #category : #tests }
CTLinkedStorageValueLinkTest >> testMostSimpleLink [

	| l |
	l := Link new.
	l nextLink: l
]

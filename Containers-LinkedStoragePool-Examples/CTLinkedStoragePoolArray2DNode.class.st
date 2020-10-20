Class {
	#name : #CTLinkedStoragePoolArray2DNode,
	#superclass : #Object,
	#instVars : [
		'coeff',
		'rowLink',
		'colLink'
	],
	#category : #'Containers-LinkedStoragePool-Examples'
}

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> coeff [
	^ coeff
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> coeff: anObject [
	coeff := anObject
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> colLink [
	^ colLink
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> colLink: anObject [
	colLink := anObject
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> rowLink [
	^ rowLink
]

{ #category : #accessing }
CTLinkedStoragePoolArray2DNode >> rowLink: anObject [
	rowLink := anObject
]

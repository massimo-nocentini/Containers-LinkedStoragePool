Class {
	#name : #BaselineOfContainersLinkedStoragePool,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersLinkedStoragePool
}

{ #category : #baselines }
BaselineOfContainersLinkedStoragePool >> baseline: spec [
	<baseline>
	spec for: #common do: [ "Externals."
		spec
			baseline: 'dsst'
			with: [ spec repository: 'github://massimo-nocentini/dsst' ];
			baseline: 'MetaSTExporter'
			with: [ 
				spec repository: 'github://massimo-nocentini/MetaSTExporter/src' ].
		"Packages"
		spec
			package: 'Containers-LinkedStoragePool';
			package: 'Containers-LinkedStoragePool-Visualizations';
			package: 'Containers-LinkedStoragePool-Examples';
			package: 'Containers-LinkedStoragePool-Tests' ]
]

{ #category : #'as yet unclassified' }
BaselineOfContainersLinkedStoragePool >> scriptLinkMessagesForDoc [

	<script:
	'BaselineOfContainersLinkedStoragePool new scriptLinkMessagesForDoc'>
	^ MetaSTExporter new
		  selectors:
			  #( recursiveReferences do: nextLink: asLinkedList testEmptyLink
			     testLinkReferencingItself testLinkReferencingItselfRecursive
			     testTwoLinksReferencingEachOtherRecursive
			     testLinkReferencingThree testLinkReferencingAnotherLink
			     testLinkReferencingAnotherLinkRecursive );
		  exportWithRepositoryPath: [ :aPath | 
			  aPath / 'json-for-doc' / 'link-core-messages.json' ]
		  ofPackage: self class package
]

{ #category : #'as yet unclassified' }
BaselineOfContainersLinkedStoragePool >> scriptValueLinkMessagesForDoc [

	<script:
	'BaselineOfContainersLinkedStoragePool new scriptValueLinkMessagesForDoc'>
	^ MetaSTExporter new
		  selectors:
			  #( ~~> asLinkedList asValueLink #foldr:init: #inject:into:
			     #to:by: testSimpleValueLink test4321ValueLinks
			     test321ValueLinks test21ValueLinks test4321ValueLinksRecursive
			     test4321ValueLinksSimplerRepr test43214ValueLinksRecursive
			     test11ValueLinksLoopRecursive test11ValueLinksLoop
			     test43214ValueLinksFrom2Recursive
			     testAsLinkedList testAsLinkedList4321 testNilAsLinkedList
			     testAsLinkedListFromInterval testAsValueLink testAsValueLinkInjectInto );
		  exportWithRepositoryPath: [ :aPath | 
			  aPath / 'json-for-doc' / 'valuelink-core-messages.json' ]
		  ofPackage: self class package
]

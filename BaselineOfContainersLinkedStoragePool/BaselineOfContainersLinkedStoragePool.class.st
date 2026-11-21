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
			baseline: 'ContainersEssentials'
			with: [ spec repository: 'github://massimo-nocentini/Containers-Essentials:master' ].

		spec
			baseline: 'ContainersLinks'
			with: [ spec repository: 'github://massimo-nocentini/Containers-Links:master/src' ].

		"Packages"
		spec
			package: 'Containers-LinkedStoragePool'
			with: [ spec requires: #( 'ContainersEssentials' 'ContainersLinks' ) ];
			package: 'Containers-LinkedStoragePool-Visualizations'
			with: [ spec requires: #( 'Containers-LinkedStoragePool' ) ];
			package: 'Containers-LinkedStoragePool-Tests'
			with: [ spec requires: #( 'Containers-LinkedStoragePool' ) ] ]
]

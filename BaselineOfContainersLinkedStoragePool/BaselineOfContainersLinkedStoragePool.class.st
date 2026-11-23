"
I am the baseline of the linked storage pools. I depend on `ContainersEssentials` and `ContainersLinks`, and load three packages:

- `Containers-LinkedStoragePool`, the pools.
- `Containers-LinkedStoragePool-Visualizations`, which has no class and no method.
- `Containers-LinkedStoragePool-Tests`, their tests.
"
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

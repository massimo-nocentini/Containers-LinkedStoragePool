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
			with: [ 
			spec repository: 'github://massimo-nocentini/Containers-Essentials' ].

		"Packages"
		spec
			package: 'Containers-LinkedStoragePool';
			package: 'Containers-LinkedStoragePool-Visualizations';
			package: 'Containers-LinkedStoragePool-Tests' ]
]

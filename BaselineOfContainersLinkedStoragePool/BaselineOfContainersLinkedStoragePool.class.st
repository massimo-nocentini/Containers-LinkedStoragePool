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

Extension { #name : #Collection }

{ #category : #'*Containers-LinkedStoragePool' }
Collection >> topologicalSort [
	| objs n table stack r qlink f sort |
	objs := self
		        flatCollect: [ :association | 
			        { 
				        association key.
				        association value } ]
		        as: IdentitySet.
	n := objs size.
	stack := CTLinkedStoragePool stack new.
	table := (1 to: n) collect: [ :k | 
		         Association new
			         key: 0;
			         value: nil;
			         yourself ].
	self do: [ :association | 
		| countTopAssoc k aValueLink sourceAssoc |
		k := association value.
		countTopAssoc := table at: k.
		sourceAssoc := table at: association key.
		countTopAssoc key: countTopAssoc key + 1.
		aValueLink := stack allocateOrReuse
			              value: k;
			              nextLink: sourceAssoc value;
			              yourself.
		sourceAssoc value: aValueLink ].
	r := 0.
	qlink := Dictionary new
		         at: 0 put: 0;
		         yourself.
	1 to: n do: [ :k | 
		(table at: k) key = 0 ifTrue: [ 
			qlink at: r put: k.
			r := k ] ].
	f := qlink at: 0.
	sort := LinkedList new.
	[ f = 0 ] whileFalse: [ 
		| p |
		sort add: f.
		n := n - 1.
		(table at: f) in: [ :assoc | 
			p := assoc value.
			assoc value: nil ].
		[ p ] whileNotNil: [ 
			| assoc suc nl |
			suc := p value.
			assoc := table at: suc.
			assoc key: assoc key - 1.
			assoc key = 0 ifTrue: [ 
				qlink at: r put: suc.
				r := suc ].
			nl := p nextLink.
			stack releaseLink: p.
			p := nl ].
		f := qlink at: f ifAbsent: [ 0 ] ].
	self halt.
	^ { 
		  sort.
		  stack.
		  table }
]

{ #category : #'*Containers-LinkedStoragePool' }
Collection >> topologicalSortOnCycleDo: cBlock [
	| objs n table stack r qlink f sort |
	objs := self
		        flatCollect: [ :association | 
			        { 
				        association key.
				        association value } ]
		        as: IdentitySet.
	n := objs size.
	stack := CTLinkedStoragePool stack new.
	table := (1 to: n) collect: [ :k | 
		         Association new
			         key: 0;
			         value: nil;
			         yourself ].
	self do: [ :association | 
		| countTopAssoc k aValueLink sourceAssoc |
		k := association value.
		countTopAssoc := table at: k.
		sourceAssoc := table at: association key.
		countTopAssoc key: countTopAssoc key + 1.
		aValueLink := stack allocateOrReuse
			              value: k;
			              nextLink: sourceAssoc value;
			              yourself.
		sourceAssoc value: aValueLink ].
	r := 0.
	qlink := Dictionary new
		         at: 0 put: 0;
		         yourself.
	1 to: n do: [ :k | 
		(table at: k) key = 0 ifTrue: [ 
			qlink at: r put: k.
			r := k ] ].
	f := qlink at: 0.
	sort := LinkedList new.
	[ f = 0 ] whileFalse: [ 
		| p |
		sort add: f.
		n := n - 1.
		(table at: f) in: [ :assoc | 
			p := assoc value.
			assoc value: nil ].
		[ p ] whileNotNil: [ 
			| assoc suc nl |
			suc := p value.
			assoc := table at: suc.
			assoc key: assoc key - 1.
			assoc key = 0 ifTrue: [ 
				qlink at: r put: suc.
				r := suc ].
			nl := p nextLink.
			stack releaseLink: p.
			p := nl ].
		f := qlink at: f ifAbsent: [ 0 ] ].
	^ n > 0
		  ifTrue: [ 
			  | kk cycle |
			  1 to: n do: [ :k | qlink at: k put: 0 ].
			  1 to: n do: [ :k | 
				  | assoc p |
				  assoc := table at: k.
				  p := assoc value.
				  assoc value: 0.
				  [ p ] whileNotNil: [ 
					  qlink at: p value put: k.
					  p := p nextLink ] ].
			  kk := (qlink select: [ :assoc | assoc ~= 0 ]) associations last
				        key.
			  [ 
			  (table at: kk) value: 1.
			  kk := qlink at: kk.
			  (table at: kk) value = 0 ] whileTrue.
			  cycle := LinkedList new.
			  [ 
			  cycle add: kk.
			  (table at: kk) value: 0.
			  kk := qlink at: kk.
			  (table at: kk) value = 1 ] whileTrue.
			  cycle add: kk.
			  cBlock value: (cycle overlappingPairsCollect: [ :a :b | b -> a ]) ]
		  ifFalse: [ 
			  { 
				  sort.
				  stack.
				  table } ]
]

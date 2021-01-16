Extension { #name : #Collection }

{ #category : #'*Containers-LinkedStoragePool-Examples' }
Collection >> topologicalSortOnCycleDo: cBlock [

	| objs n table r qlink f sort |
	"Compute the set of unique naturals subject of the input relations."
	objs := self
		        flatCollect: [ :association | 
			        { 
				        association key.
				        association value } ]
		        as: IdentitySet.
	n := objs size.

	"T1: initialize."
	table := (1 to: n) collect: [ :k | 
		         Association new
			         key: 0;
			         "COUNT: the number of direct predecessors of this object."
			         value: nil;
			         "TOP: link to the beginning of the list of direct successors of this object."
				         yourself ].

	"T2: next relation."
	self do: [ :relation | 
		| j k |
		"Unpack `relation` such that `relation = (j -> k)` holds."
		j := relation key.
		k := relation value.

		"T3: Increase COUNT by one."
		(table at: k) in: [ :destAssoc | destAssoc key: destAssoc key + 1 ].

		"T3: record the relation."
		(table at: j) in: [ :sourceAssoc | 
			ValueLink new in: [ :p | "Operation (8)"
				(p
					 value: k;
					 nextLink: sourceAssoc value;
					 yourself) ignoreBlock: [ sourceAssoc value: p ] ] ] ].

	"T4: scan for zeros."
	qlink := Dictionary new.
	r := 0.
	1 to: n do: [ :k | 
		| count |
		count := (table at: k) key.
		count = 0 ifTrue: [ r := qlink at: r put: k ] ].
	f := qlink at: 0 ifAbsent: [ 0 ].
	sort := Array streamContents: [ :array | 
		        [ f = 0 ] whileFalse: [ 
			        | p |
			        "T5: output front of queue."
			        array nextPut: f.
			        n := n - 1.
			        p := (table at: f) in: [ :assoc | 
				             assoc value ignoreBlock: [ assoc value: nil ] ].

			        "T6: erase relations."
			        [ p ] whileNotNil: [ 
				        | assoc k count |
				        k := p value.
				        assoc := table at: k.
				        count := assoc
					                 key: assoc key - 1;
					                 key. "decrease COUNT by one."
				        count = 0 ifTrue: [ r := qlink at: r put: k ].
				        p := p nextLink ].

			        "T7: remove from queue."
			        f := qlink at: f ifAbsent: [ 0 ] ] ].
	^ n > 0
		  ifTrue: [ 
			  | kk cycle |
			  "T9"
			  n := objs size.
			  qlink := Dictionary new.
			  1 to: n do: [ :k | 
				  | assoc p |
				  assoc := table at: k.
				  p := assoc value ignoreBlock: [ assoc value: 0 ].

				  "T10"
				  [ p ] whileNotNil: [ 
					  qlink at: p value put: k.
					  p := p nextLink ] ].

			  "T11"
			  kk := qlink anyAssociation key.

			  "T12"
			  [ 
			  (table at: kk) value: 1.
			  kk := qlink at: kk.
			  (table at: kk) value = 0 ] whileTrue.

			  "T13"
			  cycle := Array streamContents: [ :array | 
				           [ 
				           array nextPut: kk.
				           (table at: kk) value: 0.
				           kk := qlink at: kk.
				           (table at: kk) value = 1 ] whileTrue.
				           array nextPut: kk ].

			  "Invoke the given block with the detected cycle."
			  cBlock value: (cycle overlappingPairsCollect: [ :a :b | b -> a ]) ]
		  ifFalse: [ sort ]
]

"
Imported by VwImportClass
"
Class {
	#name : #JunAdjacencyMatrix,
	#superclass : #JunAbstractObject,
	#instVars : [
		'undirectedGraph',
		'adjacencyTable',
		'cachedNodes',
		'cachedArcs',
		'cachedRoots',
		'cachedNodeToArcs'
	],
	#category : #'Jun-Goodies-Tables'
}

{ #category : #'lisp support' }
JunAdjacencyMatrix class >> adjacencyTableFromLispList: aList for: adjacentMatrix [ 
	| pair |
	pair := aList 
				detect: [:car | (car isKindOf: JunLispCons) and: [car head = #adjacencyTable]]
				ifNone: [nil].
	pair isNil ifTrue: [^adjacentMatrix].
	adjacentMatrix 
		privateAdjacencyTable: (JunAdjacencyTable fromLispList: pair tail).
	^adjacentMatrix
]

{ #category : #copyright }
JunAdjacencyMatrix class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunAdjacencyMatrix class >> directedGraph [
	^(self new)
		beDirectedGraph;
		yourself
]

{ #category : #examples }
JunAdjacencyMatrix class >> example00 [
	"JunAdjacencyMatrix example00."

	| adjacencyMatrix |
	adjacencyMatrix := JunAdjacencyMatrix exampleSimple.
	adjacencyMatrix beDirectedGraph.
	Transcript
		cr;
		show: adjacencyMatrix printString.
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example01 [
	"JunAdjacencyMatrix example01."

	| adjacencyMatrix |
	adjacencyMatrix := JunAdjacencyMatrix exampleSimple.
	adjacencyMatrix beUndirectedGraph.
	Transcript
		cr;
		show: adjacencyMatrix printString.
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example02 [
	"JunAdjacencyMatrix example02."

	| adjacencyMatrix |
	adjacencyMatrix := JunAdjacencyMatrix exampleSimple.
	adjacencyMatrix := adjacencyMatrix class 
				fromLispList: adjacencyMatrix toLispList.
	Transcript
		cr;
		show: adjacencyMatrix printString.
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example03 [
	"JunAdjacencyMatrix example03."

	| adjacencyMatrix |
	adjacencyMatrix := JunAdjacencyMatrix exampleSimple.
	adjacencyMatrix beUndirectedGraph.
	adjacencyMatrix := Compiler evaluate: adjacencyMatrix storeString.
	Transcript
		cr;
		show: adjacencyMatrix printString.
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example10 [
	"JunAdjacencyMatrix example10."

	| adjacencyMatrix |
	adjacencyMatrix := JunAdjacencyMatrix exampleSimple.
	Transcript clear.
	adjacencyMatrix nodesDepthFirstDo: 
			[:node :indent :sequence | 
			indent timesRepeat: [Transcript tab].
			Transcript nextPutAll: sequence printString.
			Transcript nextPutAll: ': '.
			Transcript nextPutAll: node printString.
			Transcript cr.
			Transcript flush].
	Transcript cr.
	adjacencyMatrix arcsDepthFirstDo: 
			[:arc :indent :sequence | 
			indent timesRepeat: [Transcript tab].
			Transcript nextPutAll: sequence printString.
			Transcript nextPutAll: ': '.
			Transcript nextPutAll: arc printString.
			Transcript cr.
			Transcript flush].
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example11 [
	"JunAdjacencyMatrix example11."

	| adjacencyMatrix |
	adjacencyMatrix := JunAdjacencyMatrix exampleCycle.
	Transcript clear.
	adjacencyMatrix nodesDepthFirstDo: 
			[:node :indent :sequence | 
			indent timesRepeat: [Transcript tab].
			Transcript nextPutAll: sequence printString.
			Transcript nextPutAll: ': '.
			Transcript nextPutAll: node printString.
			Transcript cr.
			Transcript flush].
	Transcript cr.
	adjacencyMatrix arcsDepthFirstDo: 
			[:arc :indent :sequence | 
			indent timesRepeat: [Transcript tab].
			Transcript nextPutAll: sequence printString.
			Transcript nextPutAll: ': '.
			Transcript nextPutAll: arc printString.
			Transcript cr.
			Transcript flush].
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example12 [
	"JunAdjacencyMatrix example12."

	| adjacencyMatrix |
	adjacencyMatrix := JunAdjacencyMatrix exampleSimple.
	Transcript clear.
	adjacencyMatrix nodesBreadthFirstDo: 
			[:node :indent :sequence | 
			indent timesRepeat: [Transcript tab].
			Transcript nextPutAll: sequence printString.
			Transcript nextPutAll: ': '.
			Transcript nextPutAll: node printString.
			Transcript cr.
			Transcript flush].
	Transcript cr.
	adjacencyMatrix arcsBreadthFirstDo: 
			[:arc :indent :sequence | 
			indent timesRepeat: [Transcript tab].
			Transcript nextPutAll: sequence printString.
			Transcript nextPutAll: ': '.
			Transcript nextPutAll: arc printString.
			Transcript cr.
			Transcript flush].
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example13 [
	"JunAdjacencyMatrix example13."

	| adjacencyMatrix |
	adjacencyMatrix := JunAdjacencyMatrix exampleSimple.
	Transcript clear.
	adjacencyMatrix nodesTopologicalSortDo: 
			[:node :indent :sequence | 
			indent timesRepeat: [Transcript tab].
			Transcript nextPutAll: sequence printString.
			Transcript nextPutAll: ': '.
			Transcript nextPutAll: node printString.
			Transcript cr.
			Transcript flush].
	Transcript cr.
	adjacencyMatrix nodesTopologicalSort do: 
			[:node | 
			Transcript nextPutAll: node printString.
			Transcript cr.
			Transcript flush].
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example14 [
	"JunAdjacencyMatrix example14."

	| adjacencyMatrix startNode shortestPath |
	adjacencyMatrix := JunAdjacencyMatrix exampleSimple.
	Transcript clear.
	(adjacencyMatrix shortestPaths associations 
		asSortedCollection: [:a1 :a2 | a1 key < a2 key]) do: 
				[:pair | 
				startNode := pair key.
				shortestPath := pair value.
				(shortestPath associations asSortedCollection: [:a1 :a2 | a1 key < a2 key]) 
					do: 
						[:assoc | 
						| node distance |
						node := assoc key.
						distance := assoc value.
						Transcript nextPutAll: startNode printString.
						Transcript nextPutAll: ' -- '.
						Transcript nextPutAll: distance printString.
						Transcript nextPutAll: ' -> '.
						Transcript nextPutAll: node printString.
						Transcript cr.
						Transcript flush]].
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example15 [
	"JunAdjacencyMatrix example15."

	| adjacencyMatrix startNode shortestPath |
	adjacencyMatrix := JunAdjacencyMatrix exampleCycle.
	Transcript clear.
	(adjacencyMatrix shortestPaths associations 
		asSortedCollection: [:a1 :a2 | a1 key < a2 key]) do: 
				[:pair | 
				startNode := pair key.
				shortestPath := pair value.
				(shortestPath associations asSortedCollection: [:a1 :a2 | a1 key < a2 key]) 
					do: 
						[:assoc | 
						| node distance |
						node := assoc key.
						distance := assoc value.
						Transcript nextPutAll: startNode printString.
						Transcript nextPutAll: ' -- '.
						Transcript nextPutAll: distance printString.
						Transcript nextPutAll: ' -> '.
						Transcript nextPutAll: node printString.
						Transcript cr.
						Transcript flush]].
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example16 [
	"JunAdjacencyMatrix example16."

	| aMatrix anotherMatrix aBoolean |
	aMatrix := JunAdjacencyMatrix new.
	aMatrix connect: 'a' with: 'b'.
	aMatrix connect: 'a' with: 'c'.
	aMatrix connect: 'b' with: 'c'.
	anotherMatrix := JunAdjacencyMatrix new.
	anotherMatrix connect: 'f' with: 'd'.
	anotherMatrix connect: 'e' with: 'd'.
	anotherMatrix connect: 'e' with: 'f'.
	aBoolean := aMatrix isIsomorphicTo: anotherMatrix.
	Transcript
		cr;
		show: aBoolean printString.
	^Array with: aMatrix with: anotherMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example17 [
	"JunAdjacencyMatrix example17."

	| aMatrix anotherMatrix aBoolean |
	aMatrix := JunAdjacencyMatrix exampleSimple.
	anotherMatrix := JunAdjacencyMatrix exampleCycle.
	aBoolean := aMatrix isIsomorphicTo: anotherMatrix.
	Transcript
		cr;
		show: aBoolean printString.
	^Array with: aMatrix with: anotherMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example20 [
	"JunAdjacencyMatrix example20."

	| adjacencyMatrix fileName aStream |
	adjacencyMatrix := JunAdjacencyMatrix exampleTree.
	fileName := 'ExampleTree.txt'.
	JunControlUtility 
		assert: [aStream := fileName asFilename writeStream]
		do: 
			[Cursor write showWhile: 
					[adjacencyMatrix nodesDepthFirstDo: 
							[:node :indent :sequence | 
							indent timesRepeat: [aStream nextPutAll: '|-- '].
							aStream nextPutAll: node.
							aStream cr.
							aStream flush]]]
		ensure: [aStream close].
	FileBrowser openOnFileNamed: fileName.
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example21 [
	"JunAdjacencyMatrix example21."

	| adjacencyMatrix fileName aStream |
	adjacencyMatrix := JunAdjacencyMatrix exampleForest.
	fileName := 'ExampleForest.txt'.
	JunControlUtility 
		assert: [aStream := fileName asFilename writeStream]
		do: 
			[Cursor write showWhile: 
					[adjacencyMatrix nodesDepthFirstDo: 
							[:node :indent :sequence | 
							indent timesRepeat: [aStream nextPutAll: '|-- '].
							aStream nextPutAll: node.
							aStream cr.
							aStream flush]]]
		ensure: [aStream close].
	FileBrowser openOnFileNamed: fileName.
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example22 [
	"JunAdjacencyMatrix example22."

	| adjacencyMatrix fileName aStream aString |
	adjacencyMatrix := JunAdjacencyMatrix exampleDirectory: 3 withFiles: true.
	adjacencyMatrix isNil ifTrue: [^nil].
	fileName := 'ExampleDirectory.txt'.
	JunControlUtility 
		assert: [aStream := fileName asFilename writeStream]
		do: 
			[Cursor write showWhile: 
					[adjacencyMatrix 
						visitDepthFirst: nil
						nodeDo: 
							[:node :indent :sequence | 
							indent > 0 
								ifTrue: 
									[indent - 1 timesRepeat: [aStream nextPutAll: '|  '].
									node last = $/ 
										ifTrue: [aStream nextPutAll: '+- ']
										ifFalse: [aStream nextPutAll: '|- ']].
							node last = $/ 
								ifTrue: 
									[aString := node copyFrom: 1 to: node size - 1.
									aString := (Filename splitPath: aString) last]
								ifFalse: [aString := (Filename splitPath: node) last].
							aStream nextPutAll: aString.
							aStream cr.
							aStream flush]
						arcDo: []]]
		ensure: [aStream close].
	FileBrowser openOnFileNamed: fileName.
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> example23 [
	"JunAdjacencyMatrix example23."

	| adjacencyMatrix fileName aStream |
	adjacencyMatrix := JunAdjacencyMatrix exampleSmalltalk.
	fileName := 'ExampleSmalltalk.txt'.
	JunControlUtility 
		assert: [aStream := fileName asFilename writeStream]
		do: 
			[Cursor write showWhile: 
					[adjacencyMatrix 
						visitDepthFirst: nil
						nodeDo: 
							[:node :indent :sequence | 
							indent timesRepeat: [aStream nextPutAll: '|-- '].
							aStream nextPutAll: node.
							aStream cr.
							aStream flush]
						arcDo: []]]
		ensure: [aStream close].
	FileBrowser openOnFileNamed: fileName.
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> exampleCycle [
	"JunAdjacencyMatrix exampleCycle."

	| adjacencyMatrix |
	adjacencyMatrix := JunAdjacencyMatrix new.
	adjacencyMatrix connect: 'abc' with: 'def'.
	adjacencyMatrix 
		connect: 'abc'
		with: 'ghi'
		cost: 3.
	adjacencyMatrix connect: 'abc' with: 'jkl'.
	adjacencyMatrix connect: 'def' with: 'mno'.
	adjacencyMatrix connect: 'ghi' with: 'pqr'.
	adjacencyMatrix connect: 'ghi' with: 'stu'.
	adjacencyMatrix connect: 'jkl' with: 'vwx'.
	adjacencyMatrix 
		connect: 'jkl'
		with: 'yz0'
		cost: 2.
	adjacencyMatrix 
		connect: 'stu'
		with: '123'
		cost: 4.
	adjacencyMatrix connect: 'stu' with: '456'.
	adjacencyMatrix connect: '789' with: 'abc'.
	adjacencyMatrix connect: '123' with: '789'.
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> exampleDirectory: diveLevel withFiles: fileBoolean [ 
	"JunAdjacencyMatrix exampleDirectory: 3 withFiles: false."

	| theDirectory adjacencyMatrix aBlock |
	theDirectory := JunFileRequesterDialog 
				requestDirectory: (#jun_Select_a_directory_ >> 'Select a directory.') 
						asString.
	theDirectory isNil ifTrue: [^nil].
	theDirectory isDirectory ifFalse: [^nil].
	adjacencyMatrix := JunAdjacencyMatrix new.
	aBlock := 
			[:aDirectory :aNumber | 
			| aString firstNode lastNode |
			aString := aDirectory asString.
			aString last = Filename separator 
				ifTrue: [aString := aString copyFrom: 1 to: aString size - 1].
			firstNode := aString , '/'.
			aNumber < diveLevel 
				ifTrue: 
					[| fileCollection directoryCollection |
					fileCollection := OrderedCollection new.
					directoryCollection := OrderedCollection new.
					aDirectory directoryContents do: 
							[:each | 
							| aFilename |
							aString := each asString.
							aString last = Filename separator 
								ifTrue: [aString := aString copyFrom: 1 to: aString size - 1].
							aFilename := aDirectory construct: aString.
							aFilename isDirectory 
								ifTrue: [directoryCollection add: aFilename]
								ifFalse: [fileCollection add: aFilename]].
					fileBoolean 
						ifTrue: 
							[fileCollection do: 
									[:theFilename | 
									lastNode := theFilename asString.
									adjacencyMatrix connect: firstNode with: lastNode]].
					directoryCollection do: 
							[:subDirectory | 
							lastNode := subDirectory asString , '/'.
							adjacencyMatrix connect: firstNode with: lastNode.
							aBlock value: subDirectory value: aNumber + 1]]].
	aBlock value: theDirectory value: 1.
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> exampleForest [
	"JunAdjacencyMatrix exampleForest."

	| rootClasses adjacencyMatrix aBlock |
	rootClasses := Array 
				with: Collection
				with: Magnitude
				with: Stream.
	adjacencyMatrix := JunAdjacencyMatrix new.
	aBlock := 
			[:aClass | 
			aClass isMeta not 
				ifTrue: 
					[aClass subclasses do: 
							[:subClass | 
							adjacencyMatrix connect: aClass name with: subClass name.
							aBlock value: subClass]]].
	rootClasses do: [:rootClass | aBlock value: rootClass].
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> exampleSimple [
	"JunAdjacencyMatrix exampleSimple."

	| adjacencyMatrix |
	adjacencyMatrix := JunAdjacencyMatrix new.
	adjacencyMatrix connect: 'abc' with: 'def'.
	adjacencyMatrix 
		connect: 'abc'
		with: 'ghi'
		cost: 3.
	adjacencyMatrix connect: 'abc' with: 'jkl'.
	adjacencyMatrix connect: 'def' with: 'mno'.
	adjacencyMatrix connect: 'ghi' with: 'pqr'.
	adjacencyMatrix connect: 'ghi' with: 'stu'.
	adjacencyMatrix connect: 'jkl' with: 'vwx'.
	adjacencyMatrix 
		connect: 'jkl'
		with: 'yz0'
		cost: 2.
	adjacencyMatrix 
		connect: 'stu'
		with: '123'
		cost: 4.
	adjacencyMatrix connect: 'stu' with: '456'.
	adjacencyMatrix add: '789'.
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> exampleSmalltalk [
	"JunAdjacencyMatrix exampleSmalltalk."

	| rootClasses adjacencyMatrix selectBlock nameBlock connectBlock |
	rootClasses := JunSourceCodeSaver new rootClasses.
	adjacencyMatrix := JunAdjacencyMatrix new.
	selectBlock := 
			[:aClass | 
			(aClass isMeta not and: 
					[| string |
					string := aClass name asString.
					(string copyFrom: 1 to: (3 min: string size)) ~= 'Jun']) 
				yourself].
	nameBlock := 
			[:fullName | 
			| aString index pathName baseName |
			aString := fullName asString.
			index := fullName findLast: [:c | c = $.].
			index > 0 
				ifTrue: 
					[pathName := aString copyFrom: 1 to: index - 1.
					baseName := aString copyFrom: index + 1 to: aString size.
					aString := baseName , ' {' , pathName , '}'].
			aString yourself].
	connectBlock := 
			[:aClass | 
			(selectBlock value: aClass) 
				ifTrue: 
					[aClass subclasses do: 
							[:subClass | 
							(selectBlock value: subClass) 
								ifTrue: 
									[adjacencyMatrix connect: (nameBlock value: aClass fullName)
										with: (nameBlock value: subClass fullName).
									connectBlock value: subClass]]]].
	rootClasses do: [:rootClass | connectBlock value: rootClass].
	^adjacencyMatrix
]

{ #category : #examples }
JunAdjacencyMatrix class >> exampleTree [
	"JunAdjacencyMatrix exampleTree."

	| rootClass adjacencyMatrix aBlock |
	rootClass := Magnitude.
	adjacencyMatrix := JunAdjacencyMatrix new.
	aBlock := 
			[:aClass | 
			aClass isMeta not 
				ifTrue: 
					[aClass subclasses do: 
							[:subClass | 
							adjacencyMatrix connect: aClass name with: subClass name.
							aBlock value: subClass]]].
	aBlock value: rootClass.
	^adjacencyMatrix
]

{ #category : #'lisp support' }
JunAdjacencyMatrix class >> fromLispList: aList [ 
	| adjacentMatrix |
	adjacentMatrix := (Smalltalk at: aList head) new.
	self undirectedGraphFromLispList: aList for: adjacentMatrix.
	self adjacencyTableFromLispList: aList for: adjacentMatrix.
	^adjacentMatrix
]

{ #category : #copyright }
JunAdjacencyMatrix class >> system [
	^'Jun'
]

{ #category : #'instance creation' }
JunAdjacencyMatrix class >> undirectedGraph [
	^(self new)
		beUndirectedGraph;
		yourself
]

{ #category : #'lisp support' }
JunAdjacencyMatrix class >> undirectedGraphFromLispList: aList for: adjacentMatrix [ 
	| pair |
	pair := aList 
				detect: [:car | (car isKindOf: JunLispCons) and: [car head = #undirectedGraph]]
				ifNone: [nil].
	pair isNil ifTrue: [^adjacentMatrix].
	pair tail = #true 
		ifTrue: [adjacentMatrix beUndirectedGraph]
		ifFalse: [adjacentMatrix beDirectedGraph].
	^adjacentMatrix
]

{ #category : #copyright }
JunAdjacencyMatrix class >> version [
	^'799'
]

{ #category : #adding }
JunAdjacencyMatrix >> add: node [ 
	(adjacencyTable add: node) ifNotNil: 
			[:attributes | 
			self flushCachedNodes.
			^attributes].
	^nil
]

{ #category : #'lisp support' }
JunAdjacencyMatrix >> adjacencyTableToLispList [
	| list |
	list := JunLispCons cell.
	list head: #adjacencyTable.
	list tail: adjacencyTable toLispList.
	^list
]

{ #category : #'accessing arcs' }
JunAdjacencyMatrix >> arcs [
	cachedArcs isNil 
		ifTrue: 
			[| arcs |
			arcs := OrderedCollection new: self maximumNumberOfArcs // 4.
			adjacencyTable associationsDo: 
					[:firstAssoc | 
					| first |
					first := firstAssoc key.
					firstAssoc value associationsDo: 
							[:lastAssoc | 
							| last attributes |
							last := lastAssoc key.
							attributes := adjacencyTable at: first with: last.
							attributes isNil 
								ifFalse: 
									[arcs add: (Array 
												with: first
												with: attributes
												with: last)]]].
			arcs := (self messageNotUnderstoodSignal handle: [:ex | arcs]
						do: 
							[arcs asSortedCollection: 
									[:a1 :a2 | 
									a1 first = a2 first 
										ifTrue: [a1 last < a2 last]
										ifFalse: [a1 first < a2 first]]]) 
							asArray.
			cachedArcs := arcs].
	^cachedArcs
]

{ #category : #'accessing arcs' }
JunAdjacencyMatrix >> arcsBreadthFirst [
	^self arcsBreadthFirst: nil
]

{ #category : #'accessing arcs' }
JunAdjacencyMatrix >> arcsBreadthFirst: startNode [ 
	| collection |
	collection := OrderedCollection new: self numberOfArcs.
	self arcsBreadthFirstDo: [:arc | collection add: arc] startNode: startNode.
	^collection
]

{ #category : #'enumerating arcs' }
JunAdjacencyMatrix >> arcsBreadthFirstDo: aBlock [ 
	^self arcsBreadthFirstDo: aBlock startNode: nil
]

{ #category : #'enumerating arcs' }
JunAdjacencyMatrix >> arcsBreadthFirstDo: aBlock startNode: startNode [ 
	^((self 
		visitBreadthFirst: startNode
		nodeDo: []
		arcDo: []) at: #arcsBreadthFirst) 
		do: 
			[:argumentArray | 
			aBlock valueWithArguments: (argumentArray copyFrom: 1 to: aBlock numArgs)]
]

{ #category : #'accessing arcs' }
JunAdjacencyMatrix >> arcsDepthFirst [
	^self arcsDepthFirst: nil
]

{ #category : #'accessing arcs' }
JunAdjacencyMatrix >> arcsDepthFirst: startNode [ 
	| collection |
	collection := OrderedCollection new: self numberOfArcs.
	self arcsDepthFirstDo: [:arc | collection add: arc] startNode: startNode.
	^collection
]

{ #category : #'enumerating arcs' }
JunAdjacencyMatrix >> arcsDepthFirstDo: aBlock [ 
	^self arcsDepthFirstDo: aBlock startNode: nil
]

{ #category : #'enumerating arcs' }
JunAdjacencyMatrix >> arcsDepthFirstDo: aBlock startNode: startNode [ 
	^((self 
		visitDepthFirst: startNode
		nodeDo: []
		arcDo: []) at: #arcsDepthFirst) 
		do: 
			[:argumentArray | 
			aBlock valueWithArguments: (argumentArray copyFrom: 1 to: aBlock numArgs)]
]

{ #category : #'accessing arcs' }
JunAdjacencyMatrix >> arcsOf: aNode [
	
	| aBlock |
	aBlock := [| arcs |
	arcs := self downArcsOfNode: aNode.
	arcs := (self messageNotUnderstoodSignal
		handle: [:ex | arcs]
		do: [arcs asSortedCollection: [:a1 :a2 | a1 last < a2 last]]) asArray.
	arcs yourself].
	cachedNodeToArcs isNil
		ifTrue:
			[| table |
			table := Dictionary new.
			table
				at: aNode
				put: aBlock value.
			cachedNodeToArcs := table]
		ifFalse:
			[(cachedNodeToArcs includesKey: aNode)
				ifFalse:
					[cachedNodeToArcs
						at: aNode
						put: aBlock value]].
	^cachedNodeToArcs at: aNode
]

{ #category : #accessing }
JunAdjacencyMatrix >> beDirectedGraph [
	self isDirectedGraph ifTrue: [^self].
	undirectedGraph := #false
]

{ #category : #accessing }
JunAdjacencyMatrix >> beUndirectedGraph [
	self isUndirectedGraph ifTrue: [^self].
	undirectedGraph := #true.
	self arcs do: 
			[:arc | 
			| first last first2last last2first attributes |
			first := arc first.
			last := arc last.
			first2last := arc at: 2.
			last2first := adjacencyTable at: last with: first.
			(first2last notNil and: [last2first notNil]) 
				ifTrue: [attributes := first2last merge: last2first]
				ifFalse: [attributes := first2last].
			adjacencyTable 
				at: first
				with: last
				put: attributes.
			adjacencyTable 
				at: last
				with: first
				put: attributes].
	self flushCachedArcs
]

{ #category : #'accessing arcs' }
JunAdjacencyMatrix >> between: first and: last [ 
	| attributes |
	attributes := adjacencyTable at: first with: last.
	^attributes
]

{ #category : #'accessing arcs' }
JunAdjacencyMatrix >> between: first and: last attribute: association [ 
	| attributes |
	attributes := adjacencyTable at: first with: last.
	attributes isNil ifTrue: [^nil].
	attributes at: association key put: association value.
	^attributes
]

{ #category : #connecting }
JunAdjacencyMatrix >> connect: first with: last [ 
	^(adjacencyTable 
		connect: first
		with: last
		undirected: self isUndirectedGraph) ifNotNil: 
				[:triplet | 
				triplet ifTrue: [self flushCachedArcs].
				^triplet]
]

{ #category : #connecting }
JunAdjacencyMatrix >> connect: first with: last attribute: association [ 
	| triplet attributes |
	triplet := self connect: first with: last.
	triplet isNil 
		ifFalse: 
			[attributes := adjacencyTable at: first with: last.
			attributes at: association key put: association value.
			self isUndirectedGraph 
				ifTrue: 
					[attributes := adjacencyTable at: last with: first.
					attributes at: association key put: association value]].
	^triplet
]

{ #category : #connecting }
JunAdjacencyMatrix >> connect: first with: last attributes: attributeTable [ 
	| triplet attributes |
	triplet := self connect: first with: last.
	triplet isNil 
		ifFalse: 
			[attributes := adjacencyTable at: first with: last.
			attributeTable 
				associationsDo: [:association | attributes at: association key put: association value].
			self isUndirectedGraph 
				ifTrue: 
					[attributes := adjacencyTable at: last with: first.
					attributeTable 
						associationsDo: [:association | attributes at: association key put: association value]]].
	^triplet
]

{ #category : #connecting }
JunAdjacencyMatrix >> connect: first with: last cost: value [ 
	^self 
		connect: first
		with: last
		attribute: #cost -> (value max: 0)
]

{ #category : #connecting }
JunAdjacencyMatrix >> connect: first with: last length: value [ 
	^self 
		connect: first
		with: last
		attribute: #length -> (value max: 0)
]

{ #category : #connecting }
JunAdjacencyMatrix >> connect: first with: last weight: value [ 
	^self 
		connect: first
		with: last
		attribute: #weight -> (value max: 0)
]

{ #category : #copying }
JunAdjacencyMatrix >> copy [
	^(self class fromLispList: self toLispList) postCopy
]

{ #category : #connecting }
JunAdjacencyMatrix >> disconnect: first with: last [ 
	^(adjacencyTable 
		disconnect: first
		with: last
		undirected: self isUndirectedGraph) ifNotNil: 
				[:triplet | 
				triplet ifTrue: [self flushCachedArcs].
				^triplet]
]

{ #category : #'accessing arcs' }
JunAdjacencyMatrix >> downArcsOfNode: aNode [ 
	^self arcs select: [:arc | arc first = aNode]
]

{ #category : #flushing }
JunAdjacencyMatrix >> flushCachedAll [
	self
		flushCachedNodes;
		flushCachedArcs
]

{ #category : #flushing }
JunAdjacencyMatrix >> flushCachedArcs [
	cachedArcs := nil.
	cachedRoots := nil.
	cachedNodeToArcs := nil
]

{ #category : #flushing }
JunAdjacencyMatrix >> flushCachedNodes [
	cachedNodes := nil.
	cachedRoots := nil
]

{ #category : #testing }
JunAdjacencyMatrix >> hasClosedPath [
	(self 
		visitDepthFirst: nil
		nodeDo: []
		arcDo: []) at: #closedPath ifPresent: [:list | ^list isEmpty not].
	^false
]

{ #category : #testing }
JunAdjacencyMatrix >> includes: aNode [ 
	^adjacencyTable includesKey: aNode
]

{ #category : #'initialize-release' }
JunAdjacencyMatrix >> initialize [
	undirectedGraph := #false.
	adjacencyTable := JunAdjacencyTable new.
	self flushCachedAll
]

{ #category : #testing }
JunAdjacencyMatrix >> isCompleteGraph [
	^self numberOfArcs >= self maximumNumberOfArcs
]

{ #category : #testing }
JunAdjacencyMatrix >> isConnected: first with: last [ 
	^(adjacencyTable at: first with: last) notNil
]

{ #category : #testing }
JunAdjacencyMatrix >> isConnectedGraph [
	^self numberOfRoots <= 1
]

{ #category : #testing }
JunAdjacencyMatrix >> isCyclic [
	^self hasClosedPath
]

{ #category : #testing }
JunAdjacencyMatrix >> isDenseGraph [
	^self isSparseGraph not
]

{ #category : #testing }
JunAdjacencyMatrix >> isDirectedGraph [
	^self isUndirectedGraph not
]

{ #category : #testing }
JunAdjacencyMatrix >> isEmpty [
	^adjacencyTable isEmpty
]

{ #category : #testing }
JunAdjacencyMatrix >> isForest [
	^self numberOfRoots > 1 
		and: [self numberOfArcs = (self numberOfNodes - self numberOfRoots)]
]

{ #category : #testing }
JunAdjacencyMatrix >> isIsomorphicTo: anotherMatrix [ 
	(self isEmpty and: [anotherMatrix isEmpty]) ifTrue: [^true].
	self numberOfNodes = anotherMatrix numberOfNodes ifFalse: [^false].
	self numberOfArcs = anotherMatrix numberOfArcs ifFalse: [^false].
	self numberOfRoots = anotherMatrix numberOfRoots ifFalse: [^false].
	(self numberOfArcs = 0 and: [anotherMatrix numberOfArcs = 0]) 
		ifTrue: [^true].
	self nodes do: 
			[:aNode | 
			anotherMatrix nodes do: 
					[:anotherNode | 
					((self downArcsOfNode: aNode) size 
						= (anotherMatrix downArcsOfNode: anotherNode) size and: 
								[(self upArcsOfNode: aNode) size 
									= (anotherMatrix upArcsOfNode: anotherNode) size]) 
						ifTrue: 
							[(self 
								privateIsomorphicTo: anotherMatrix
								with: aNode
								and: anotherNode) ifTrue: [^true]]]].
	^false
]

{ #category : #testing }
JunAdjacencyMatrix >> isReachable: first with: last [ 
	(adjacencyTable at: first with: last) isNil 
		ifTrue: 
			[self nodesDepthFirstDo: [:node | node = last ifTrue: [^true]]
				startNode: first.
			^false].
	^true
]

{ #category : #testing }
JunAdjacencyMatrix >> isSimple [
	^self hasClosedPath not
]

{ #category : #testing }
JunAdjacencyMatrix >> isSparseGraph [
	^self numberOfArcs < self numberOfNodes
]

{ #category : #testing }
JunAdjacencyMatrix >> isTree [
	^self numberOfRoots = 1 
		and: [self numberOfArcs = (self numberOfNodes - 1)]
]

{ #category : #testing }
JunAdjacencyMatrix >> isUndirectedGraph [
	^undirectedGraph = #true
]

{ #category : #accessing }
JunAdjacencyMatrix >> maximumNumberOfArcs [
	| maximumNumberOfArcs |
	maximumNumberOfArcs := self size * (self size - 1).
	self isUndirectedGraph 
		ifTrue: [maximumNumberOfArcs := maximumNumberOfArcs / 2].
	^maximumNumberOfArcs
]

{ #category : #accessing }
JunAdjacencyMatrix >> minimumNumberOfArcs [
	^0
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> nodes [
	cachedNodes isNil 
		ifTrue: 
			[| nodes |
			nodes := adjacencyTable keys.
			nodes := (self messageNotUnderstoodSignal handle: [:ex | nodes]
						do: [nodes asSortedCollection: [:n1 :n2 | n1 < n2]]) asArray.
			cachedNodes := nodes].
	^cachedNodes
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> nodesBreadthFirst [
	^self nodesBreadthFirst: nil
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> nodesBreadthFirst: startNode [ 
	| collection |
	collection := OrderedCollection new: self numberOfNodes.
	self nodesBreadthFirstDo: [:node | collection add: node]
		startNode: startNode.
	^collection
]

{ #category : #'enumerating nodes' }
JunAdjacencyMatrix >> nodesBreadthFirstDo: aBlock [ 
	^self nodesBreadthFirstDo: aBlock startNode: nil
]

{ #category : #'enumerating nodes' }
JunAdjacencyMatrix >> nodesBreadthFirstDo: aBlock startNode: startNode [ 
	^((self 
		visitBreadthFirst: startNode
		nodeDo: []
		arcDo: []) at: #nodesBreadthFirst) 
		do: 
			[:argumentArray | 
			aBlock valueWithArguments: (argumentArray copyFrom: 1 to: aBlock numArgs)]
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> nodesDepthFirst [
	^self nodesDepthFirst: nil
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> nodesDepthFirst: startNode [ 
	| collection |
	collection := OrderedCollection new: self numberOfNodes.
	self nodesDepthFirstDo: [:node | collection add: node] startNode: startNode.
	^collection
]

{ #category : #'enumerating nodes' }
JunAdjacencyMatrix >> nodesDepthFirstDo: aBlock [ 
	^self nodesDepthFirstDo: aBlock startNode: nil
]

{ #category : #'enumerating nodes' }
JunAdjacencyMatrix >> nodesDepthFirstDo: aBlock startNode: startNode [ 
	^((self 
		visitDepthFirst: startNode
		nodeDo: []
		arcDo: []) at: #nodesDepthFirst) 
		do: 
			[:argumentArray | 
			aBlock valueWithArguments: (argumentArray copyFrom: 1 to: aBlock numArgs)]
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> nodesPartialOrder [
	^self nodesPartialOrder: nil
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> nodesPartialOrder: startNode [ 
	| collection |
	collection := OrderedCollection new: self numberOfNodes.
	self nodesPartialOrderDo: [:node | collection add: node]
		startNode: startNode.
	^collection
]

{ #category : #'enumerating nodes' }
JunAdjacencyMatrix >> nodesPartialOrderDo: aBlock [ 
	| visitingDictionary visitingAttributes |
	visitingDictionary := Dictionary new: self size.
	visitingAttributes := self 
				visitDepthFirst: nil
				nodeDo: [:node :indent :sequence | visitingDictionary at: node put: (Array with: indent with: sequence)]
				arcDo: [].
	(visitingAttributes at: #topologicalSort) do: 
			[:node | 
			| array indent sequence |
			array := visitingDictionary at: node.
			indent := array first.
			sequence := array last.
			aBlock 
				valueWithArguments: ((Array 
						with: node
						with: indent
						with: sequence) copyFrom: 1 to: aBlock numArgs)]
]

{ #category : #'enumerating nodes' }
JunAdjacencyMatrix >> nodesPartialOrderDo: aBlock startNode: startNode [ 
	| visitingDictionary |
	visitingDictionary := Dictionary new: self size.
	((self 
		visitDepthFirst: startNode
		nodeDo: 
			[:node :indent :sequence | 
			| array |
			array := Array with: indent with: sequence.
			visitingDictionary at: node put: array]
		arcDo: []) at: #topologicalSort) 
		do: 
			[:node | 
			| array indent sequence |
			array := visitingDictionary at: node.
			indent := array first.
			sequence := array last.
			aBlock 
				valueWithArguments: ((Array 
						with: node
						with: indent
						with: sequence) copyFrom: 1 to: aBlock numArgs)]
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> nodesTopologicalSort [
	^self nodesPartialOrder
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> nodesTopologicalSort: startNode [ 
	^self nodesPartialOrder: startNode
]

{ #category : #'enumerating nodes' }
JunAdjacencyMatrix >> nodesTopologicalSortDo: aBlock [ 
	^self nodesPartialOrderDo: aBlock startNode: nil
]

{ #category : #'enumerating nodes' }
JunAdjacencyMatrix >> nodesTopologicalSortDo: aBlock startNode: startNode [ 
	^self nodesPartialOrderDo: aBlock startNode: startNode
]

{ #category : #accessing }
JunAdjacencyMatrix >> numberOfArcs [
	| numberOfArcs |
	numberOfArcs := self arcs size.
	self isUndirectedGraph ifTrue: [numberOfArcs := numberOfArcs / 2].
	^numberOfArcs
]

{ #category : #accessing }
JunAdjacencyMatrix >> numberOfNodes [
	| numberOfNodes |
	numberOfNodes := self nodes size.
	^numberOfNodes
]

{ #category : #accessing }
JunAdjacencyMatrix >> numberOfRoots [
	^self roots size
]

{ #category : #'accessing arcs' }
JunAdjacencyMatrix >> pairs [
	^self arcs collect: [:arc | Array with: arc first with: arc last]
]

{ #category : #printing }
JunAdjacencyMatrix >> printMax [
	^100
]

{ #category : #printing }
JunAdjacencyMatrix >> printOn: aStream [ 
	| block size |
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream space.
	block := 
			[:each | 
			aStream space.
			each printOn: aStream].
	aStream nextPutAll: '(nodes'.
	(size := self numberOfNodes) > self printMax 
		ifTrue: 
			[(self nodes copyFrom: 1 to: self printMax // 2) 
				do: [:each | block value: each].
			aStream
				space;
				nextPutAll: '...'.
			(self nodes copyFrom: size - (self printMax // 2) to: size) 
				do: [:each | block value: each]]
		ifFalse: [self nodes do: [:each | block value: each]].
	aStream nextPutAll: ')'.
	aStream space.
	block := 
			[:array | 
			aStream space.
			aStream nextPutAll: '('.
			array first printOn: aStream.
			aStream nextPutAll: '=>'.
			array last printOn: aStream.
			aStream nextPutAll: ')'].
	aStream nextPutAll: '(arcs'.
	(size := self numberOfArcs) > self printMax 
		ifTrue: 
			[(self arcs copyFrom: 1 to: self printMax // 2) 
				do: [:array | block value: array].
			aStream
				space;
				nextPutAll: '...'.
			(self arcs copyFrom: size - (self printMax // 2) to: size) 
				do: [:array | block value: array]]
		ifFalse: [self arcs do: [:array | block value: array]].
	aStream nextPutAll: ')'.
	aStream nextPutAll: ')'
]

{ #category : #private }
JunAdjacencyMatrix >> privateAdjacencyTable [
	^adjacencyTable
]

{ #category : #private }
JunAdjacencyMatrix >> privateAdjacencyTable: privateAdjacentTable [ 
	adjacencyTable := privateAdjacentTable.
	self flushCachedAll
]

{ #category : #private }
JunAdjacencyMatrix >> privateIsomorphicTo: anotherMatrix with: aNode and: anotherNode [ 
	| aCollection aTable anotherCollection anotherTable aCopiedMatrix anotherCopiedMatrix |
	aCollection := OrderedCollection new: self numberOfNodes.
	aTable := self 
				visitDepthFirst: aNode
				nodeDo: [:node :indent :squence | aCollection add: indent]
				arcDo: [:arc :indent :squence | ].
	anotherCollection := OrderedCollection new: anotherMatrix numberOfNodes.
	anotherTable := anotherMatrix 
				visitDepthFirst: anotherNode
				nodeDo: [:node :indent :squence | anotherCollection add: indent]
				arcDo: [:arc :indent :squence | ].
	aCollection = anotherCollection ifFalse: [^false].
	aCollection := (aTable at: #visitingTable) associations 
				select: [:assoc | assoc value = #unvisited].
	anotherCollection := (anotherTable at: #visitingTable) associations 
				select: [:assoc | assoc value = #unvisited].
	aCollection size = anotherCollection size ifFalse: [^false].
	aCollection := (aTable at: #visitingTable) associations 
				select: [:assoc | assoc value = #visited].
	anotherCollection := (anotherTable at: #visitingTable) associations 
				select: [:assoc | assoc value = #visited].
	aCopiedMatrix := self copy.
	anotherCopiedMatrix := anotherMatrix copy.
	aCollection collect: [:assoc | aCopiedMatrix remove: assoc key].
	anotherCollection 
		collect: [:assoc | anotherCopiedMatrix remove: assoc key].
	^aCopiedMatrix isIsomorphicTo: anotherCopiedMatrix
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> reachableNodesFrom: startNode [ 
	| collection |
	collection := OrderedCollection new: self numberOfNodes.
	self 
		visitDepthFirst: startNode
		nodeDo: [:node | node ~= startNode ifTrue: [collection add: node]]
		arcDo: [].
	^collection
]

{ #category : #removing }
JunAdjacencyMatrix >> remove: node [ 
	^(adjacencyTable remove: node) ifNotNil: 
			[:key | 
			self flushCachedAll.
			^key]
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> roots [
	cachedRoots isNil 
		ifTrue: 
			[self isEmpty 
				ifTrue: [cachedRoots := Array new]
				ifFalse: 
					[| set roots |
					set := Set new.
					self arcs do: [:anArc | set add: anArc last].
					roots := self nodes select: [:aNode | (set includes: aNode) not].
					cachedRoots := roots]].
	^cachedRoots
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> shortestPathFrom: startNode [ 
	^(self visitDijkstra: startNode) at: #distanceTable
]

{ #category : #'accessing nodes' }
JunAdjacencyMatrix >> shortestPaths [
	| table |
	table := Dictionary new: self numberOfNodes.
	self nodes do: [:node | table at: node put: (self shortestPathFrom: node)].
	^table
]

{ #category : #accessing }
JunAdjacencyMatrix >> size [
	^adjacencyTable size
]

{ #category : #printing }
JunAdjacencyMatrix >> storeOn: aStream [ 
	aStream nextPutAll: '(('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' fromLispList: (JunLispParser parse: '.
	self toLispList saveString storeOn: aStream.
	aStream nextPutAll: ')) yourself)'
]

{ #category : #'lisp support' }
JunAdjacencyMatrix >> toLispList [
	| list |
	list := JunLispCons cell.
	list head: self class name.
	list add: self undirectedGraphToLispList.
	list add: self adjacencyTableToLispList.
	^list
]

{ #category : #accessing }
JunAdjacencyMatrix >> transitiveClosure [
	| transitiveClosure |
	transitiveClosure := self copy.
	transitiveClosure nodes do: 
			[:toNode | 
			transitiveClosure nodes do: 
					[:fromNode | 
					(transitiveClosure isConnected: fromNode with: toNode) 
						ifTrue: 
							[transitiveClosure nodes do: 
									[:aNode | 
									((transitiveClosure isConnected: fromNode with: aNode) 
										or: [transitiveClosure isConnected: toNode with: aNode]) 
											ifTrue: [transitiveClosure connect: fromNode with: aNode]]]]].
	^transitiveClosure
]

{ #category : #'lisp support' }
JunAdjacencyMatrix >> undirectedGraphToLispList [
	| list |
	list := JunLispCons cell.
	list head: #undirectedGraph.
	list tail: undirectedGraph.
	^list
]

{ #category : #'accessing arcs' }
JunAdjacencyMatrix >> upArcsOfNode: aNode [ 
	^self arcs select: [:arc | arc last = aNode]
]

{ #category : #visiting }
JunAdjacencyMatrix >> visitBreadthFirst: visitingAttributes fromNode: fromNode graphQueue: graphQueue nodeDo: nodeBlock arcDo: arcBlock [ 
	| nodesBreadthFirst arcsBreadthFirst closedPath visitingTable argumentArray |
	nodesBreadthFirst := visitingAttributes at: #nodesBreadthFirst.
	arcsBreadthFirst := visitingAttributes at: #arcsBreadthFirst.
	closedPath := visitingAttributes at: #closedPath.
	visitingTable := visitingAttributes at: #visitingTable.
	visitingTable at: fromNode put: #entered.
	graphQueue add: fromNode -> 0.
	[graphQueue isEmpty] whileFalse: 
			[| anAssociation theNode indentLevel |
			anAssociation := graphQueue removeFirst.
			theNode := anAssociation key.
			indentLevel := anAssociation value.
			visitingAttributes at: #nodeSequenceNumber
				put: (visitingAttributes at: #nodeSequenceNumber) + 1.
			argumentArray := Array 
						with: theNode
						with: indentLevel
						with: (visitingAttributes at: #nodeSequenceNumber).
			nodesBreadthFirst add: argumentArray.
			nodeBlock 
				valueWithArguments: (argumentArray copyFrom: 1 to: nodeBlock numArgs).
			visitingTable at: theNode put: #visited.
			(self arcsOf: theNode) do: 
					[:anArc | 
					| toNode |
					toNode := anArc last.
					visitingAttributes at: #arcSequenceNumber
						put: (visitingAttributes at: #arcSequenceNumber) + 1.
					argumentArray := Array 
								with: anArc
								with: indentLevel
								with: (visitingAttributes at: #arcSequenceNumber).
					arcsBreadthFirst add: argumentArray.
					arcBlock 
						valueWithArguments: (argumentArray copyFrom: 1 to: arcBlock numArgs).
					(visitingTable at: toNode) = #unvisited 
						ifTrue: 
							[graphQueue add: toNode -> (indentLevel + 1).
							visitingTable at: toNode put: #entered]
						ifFalse: [closedPath add: toNode]]]
]

{ #category : #visiting }
JunAdjacencyMatrix >> visitBreadthFirst: aNode nodeDo: nodeBlock arcDo: arcBlock [ 
	| visitingAttributes graphQueue |
	visitingAttributes := (JunAttributeTable new)
				at: #nodeSequenceNumber put: 0;
				at: #arcSequenceNumber put: 0;
				at: #nodesBreadthFirst put: (OrderedCollection new: self numberOfNodes);
				at: #arcsBreadthFirst put: (OrderedCollection new: self numberOfArcs);
				at: #closedPath put: OrderedCollection new;
				at: #visitingTable
					put: 
						[| visitingTable |
						visitingTable := Dictionary new.
						self nodes do: [:node | visitingTable at: node put: #unvisited].
						visitingTable yourself] 
								value;
				yourself.
	graphQueue := OrderedCollection new.
	aNode isNil 
		ifTrue: 
			[self roots do: 
					[:fromNode | 
					((visitingAttributes at: #visitingTable) at: fromNode) = #unvisited 
						ifTrue: 
							[self 
								visitBreadthFirst: visitingAttributes
								fromNode: fromNode
								graphQueue: graphQueue
								nodeDo: nodeBlock
								arcDo: arcBlock]].
			self nodes do: 
					[:fromNode | 
					((visitingAttributes at: #visitingTable) at: fromNode) = #unvisited 
						ifTrue: 
							[self 
								visitBreadthFirst: visitingAttributes
								fromNode: fromNode
								graphQueue: graphQueue
								nodeDo: nodeBlock
								arcDo: arcBlock]]]
		ifFalse: 
			[((visitingAttributes at: #visitingTable) at: aNode) = #unvisited 
				ifTrue: 
					[self 
						visitBreadthFirst: visitingAttributes
						fromNode: aNode
						graphQueue: graphQueue
						nodeDo: nodeBlock
						arcDo: arcBlock]].
	^visitingAttributes
]

{ #category : #visiting }
JunAdjacencyMatrix >> visitDepthFirst: visitingAttributes fromNode: fromNode indentLevel: indentLevel nodeDo: nodeBlock arcDo: arcBlock [ 
	| nodesDepthFirst arcsDepthFirst topologicalSort closedPath visitingTable argumentArray |
	nodesDepthFirst := visitingAttributes at: #nodesDepthFirst.
	arcsDepthFirst := visitingAttributes at: #arcsDepthFirst.
	topologicalSort := visitingAttributes at: #topologicalSort.
	closedPath := visitingAttributes at: #closedPath.
	visitingTable := visitingAttributes at: #visitingTable.
	visitingAttributes at: #nodeSequenceNumber
		put: (visitingAttributes at: #nodeSequenceNumber) + 1.
	argumentArray := Array 
				with: fromNode
				with: indentLevel
				with: (visitingAttributes at: #nodeSequenceNumber).
	nodesDepthFirst add: argumentArray.
	nodeBlock 
		valueWithArguments: (argumentArray copyFrom: 1 to: nodeBlock numArgs).
	visitingTable at: fromNode put: #visited.
	(self arcsOf: fromNode) do: 
			[:anArc | 
			| toNode |
			toNode := anArc last.
			visitingAttributes at: #arcSequenceNumber
				put: (visitingAttributes at: #arcSequenceNumber) + 1.
			argumentArray := Array 
						with: anArc
						with: indentLevel
						with: (visitingAttributes at: #arcSequenceNumber).
			arcsDepthFirst add: argumentArray.
			arcBlock 
				valueWithArguments: (argumentArray copyFrom: 1 to: arcBlock numArgs).
			(visitingTable at: toNode) = #unvisited 
				ifTrue: 
					[self 
						visitDepthFirst: visitingAttributes
						fromNode: toNode
						indentLevel: indentLevel + 1
						nodeDo: nodeBlock
						arcDo: arcBlock]
				ifFalse: [closedPath add: toNode]].
	topologicalSort add: fromNode
]

{ #category : #visiting }
JunAdjacencyMatrix >> visitDepthFirst: aNode nodeDo: nodeBlock arcDo: arcBlock [ 
	| visitingAttributes |
	visitingAttributes := (JunAttributeTable new)
				at: #nodeSequenceNumber put: 0;
				at: #arcSequenceNumber put: 0;
				at: #nodesDepthFirst put: (OrderedCollection new: self numberOfNodes);
				at: #arcsDepthFirst put: (OrderedCollection new: self numberOfArcs);
				at: #topologicalSort put: (OrderedCollection new: self numberOfNodes);
				at: #closedPath put: OrderedCollection new;
				at: #visitingTable
					put: 
						[| visitingTable |
						visitingTable := Dictionary new.
						self nodes do: [:node | visitingTable at: node put: #unvisited].
						visitingTable yourself] 
								value;
				yourself.
	aNode isNil 
		ifTrue: 
			[self roots do: 
					[:fromNode | 
					((visitingAttributes at: #visitingTable) at: fromNode) = #unvisited 
						ifTrue: 
							[self 
								visitDepthFirst: visitingAttributes
								fromNode: fromNode
								indentLevel: 0
								nodeDo: nodeBlock
								arcDo: arcBlock]].
			self nodes do: 
					[:fromNode | 
					((visitingAttributes at: #visitingTable) at: fromNode) = #unvisited 
						ifTrue: 
							[self 
								visitDepthFirst: visitingAttributes
								fromNode: fromNode
								indentLevel: 0
								nodeDo: nodeBlock
								arcDo: arcBlock]]]
		ifFalse: 
			[((visitingAttributes at: #visitingTable) at: aNode) = #unvisited 
				ifTrue: 
					[self 
						visitDepthFirst: visitingAttributes
						fromNode: aNode
						indentLevel: 0
						nodeDo: nodeBlock
						arcDo: arcBlock]].
	^visitingAttributes
]

{ #category : #visiting }
JunAdjacencyMatrix >> visitDijkstra: aNode [ 
	^self visitDijkstra: aNode attributeSymbol: #cost
]

{ #category : #visiting }
JunAdjacencyMatrix >> visitDijkstra: aNode attributeSymbol: aSymbol [ 
	| visitingAttributes |
	visitingAttributes := (JunAttributeTable new)
				at: #distanceTable
					put: 
						[| distanceTable |
						distanceTable := Dictionary new.
						self nodes do: [:node | distanceTable at: node put: nil].
						distanceTable yourself] 
								value;
				at: #visitedNodes put: Set new;
				at: #unvisitedNodes put: Set new;
				yourself.
	aNode isNil ifTrue: [^visitingAttributes].
	self 
		visitDijkstra: visitingAttributes
		fromNode: aNode
		attributeSymbol: aSymbol.
	^visitingAttributes
]

{ #category : #visiting }
JunAdjacencyMatrix >> visitDijkstra: visitingAttributes fromNode: fromNode attributeSymbol: aSymbol [ 
	| visitedNodes unvisitedNodes distanceTable toNode |
	visitedNodes := visitingAttributes at: #visitedNodes.
	unvisitedNodes := visitingAttributes at: #unvisitedNodes.
	distanceTable := visitingAttributes at: #distanceTable.
	distanceTable at: fromNode put: 0.
	visitedNodes add: fromNode.
	(self reachableNodesFrom: fromNode) do: 
			[:node | 
			distanceTable at: node put: nil.
			unvisitedNodes add: node].
	(self arcsOf: fromNode) do: 
			[:array | 
			| length |
			toNode := array last.
			length := ((array at: 2) at: aSymbol ifAbsent: [1]) max: 0.
			distanceTable at: toNode put: length].
	[unvisitedNodes isEmpty not] whileTrue: 
			[| aNode minDistance theDistance |
			aNode := nil.
			minDistance := nil.
			unvisitedNodes do: 
					[:node | 
					theDistance := distanceTable at: node.
					theDistance notNil 
						ifTrue: 
							[minDistance isNil 
								ifTrue: 
									[minDistance := theDistance.
									aNode := node]
								ifFalse: 
									[theDistance < minDistance 
										ifTrue: 
											[minDistance := theDistance.
											aNode := node]]]].
			aNode isNil ifTrue: [aNode := unvisitedNodes detect: [:node | true]].
			unvisitedNodes remove: aNode.
			visitedNodes add: aNode.
			(self arcsOf: aNode) do: 
					[:array | 
					| length |
					toNode := array last.
					(unvisitedNodes includes: toNode) 
						ifTrue: 
							[length := ((array at: 2) at: aSymbol ifAbsent: [1]) max: 0.
							(distanceTable at: toNode) isNil 
								ifTrue: 
									[(distanceTable at: aNode) isNil 
										ifTrue: [theDistance := length]
										ifFalse: [theDistance := length + (distanceTable at: aNode)]]
								ifFalse: 
									[(distanceTable at: aNode) isNil 
										ifTrue: [theDistance := (distanceTable at: toNode) min: length]
										ifFalse: 
											[theDistance := (distanceTable at: toNode) 
														min: length + (distanceTable at: aNode)]].
							distanceTable at: toNode put: theDistance]]].
	^visitingAttributes
]

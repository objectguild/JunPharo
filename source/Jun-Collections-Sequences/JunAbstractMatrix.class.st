"
Imported by VwImportClass
"
Class {
	#name : #JunAbstractMatrix,
	#superclass : #JunSequence,
	#instVars : [
		'matrixSize'
	],
	#category : #'Jun-Collections-Sequences'
}

{ #category : #copyright }
JunAbstractMatrix class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'lisp support' }
JunAbstractMatrix class >> fromLispList: aList [ 
	"JunMatrix fromLispList: ((JunMatrix exampleMatrix) toLispList)."

	| aTable aMatrix rowSize columnSize |
	aTable := self tableFromLispList: aList tail.
	rowSize := aTable at: #rowSize.
	columnSize := aTable at: #columnSize.
	aMatrix := (Smalltalk at: aList head) new: rowSize by: columnSize.
	aMatrix class fromTable: aTable for: aMatrix.
	^aMatrix
]

{ #category : #'lisp support' }
JunAbstractMatrix class >> fromTable: aTable for: aMatrix [ 
	"JunMatrix fromLispList: ((JunMatrix exampleMatrix) toLispList)."

	self rowsFromTable: aTable for: aMatrix.
	^aMatrix
]

{ #category : #'instance creation' }
JunAbstractMatrix class >> new [
	"JunMatrix new."

	^self new: 0
]

{ #category : #'instance creation' }
JunAbstractMatrix class >> new: squareSize [ 
	"JunMatrix new: 3."

	^self new: squareSize by: squareSize
]

{ #category : #'instance creation' }
JunAbstractMatrix class >> new: anInteger1 by: anInteger2 [ 
	"JunMatrix new: 3 by: 3."

	| matrix rowSize columnSize |
	rowSize := (anInteger1 max: 0) asInteger.
	columnSize := (anInteger2 max: 0) asInteger.
	matrix := self basicNew: rowSize.
	1 to: rowSize do: [:row | matrix basicAt: row put: (Array new: columnSize)].
	matrix rowSize: rowSize columnSize: columnSize.
	^matrix
]

{ #category : #'instance creation' }
JunAbstractMatrix class >> new: rowSize by: columnSize collection: collection [ 
	"JunMatrix new: 3 by: 3 collection: #(1 2 3 4 5 6 7 8 9)."

	^(self new: rowSize by: columnSize)
		collection: collection
]

{ #category : #'instance creation' }
JunAbstractMatrix class >> new: squareSize collection: collection [ 
	"JunMatrix new: 3 collection: #(1 2 3 4 5 6 7 8 9)."

	^(self new: squareSize)
		collection: collection
]

{ #category : #'lisp support' }
JunAbstractMatrix class >> rowsFromTable: aTable for: aMatrix [ 
	| aList |
	aList := aTable at: #rows ifAbsent: [^aMatrix].
	aList with: (1 to: aList size)
		do: 
			[:list :index | 
			| collection |
			collection := OrderedCollection new: list size.
			list do: 
					[:each | 
					| species object |
					((each isKindOf: JunLispCons) and: 
							[(species := Smalltalk at: each head ifAbsent: [nil]) notNil 
								and: [species respondsTo: #fromLispList:]]) 
						ifTrue: [object := species fromLispList: each]
						ifFalse: [object := each].
					collection add: object].
			aMatrix atRow: index put: collection asArray].
	^aMatrix
]

{ #category : #copyright }
JunAbstractMatrix class >> system [
	^'Jun'
]

{ #category : #'instance creation' }
JunAbstractMatrix class >> unit: squareSize [ 
	^self subclassResponsibility
]

{ #category : #copyright }
JunAbstractMatrix class >> version [
	^'799'
]

{ #category : #comparing }
JunAbstractMatrix >> = otherCollection [ 
	self species == otherCollection species ifFalse: [^false].
	self matrixSize = otherCollection matrixSize ifFalse: [^false].
	^super = otherCollection
]

{ #category : #adding }
JunAbstractMatrix >> add: newObject [ 
	self shouldNotImplement
]

{ #category : #accessing }
JunAbstractMatrix >> at: indexInteger [ 
	^self atPoint: (self computeLocation: indexInteger)
]

{ #category : #accessing }
JunAbstractMatrix >> at: indexInteger put: anObject [ 
	^self atPoint: (self computeLocation: indexInteger) put: anObject
]

{ #category : #accessing }
JunAbstractMatrix >> atAllPut: anObject [ 
	"Put anObject at every one of the receiver's indices."

	| index row |
	index := 1.
	1 to: self rowSize
		do: 
			[:rowIndex | 
			row := self basicAt: rowIndex.
			1 to: self columnSize
				do: 
					[:columnIndex | 
					row at: columnIndex put: anObject.
					index := index + 1]]
]

{ #category : #'accessing column' }
JunAbstractMatrix >> atColumn: anInteger [ 
	| column |
	column := Array new: self rowSize.
	1 to: self rowSize do: [:i | column at: i put: (self row: i column: anInteger)].
	^column
]

{ #category : #'accessing column' }
JunAbstractMatrix >> atColumn: anInteger put: aCollection [ 
	1 to: (self rowSize min: aCollection size)
		do: 
			[:i | 
			self 
				row: i
				column: anInteger
				put: (aCollection at: i)]
]

{ #category : #accessing }
JunAbstractMatrix >> atPoint: aPoint [ 
	^(self basicAt: aPoint x) at: aPoint y
]

{ #category : #accessing }
JunAbstractMatrix >> atPoint: aPoint put: anObject [
	^(self basicAt: aPoint x) at: aPoint y put: anObject
]

{ #category : #'accessing row' }
JunAbstractMatrix >> atRow: anInteger [ 
	| row |
	row := Array new: self columnSize.
	1 to: self columnSize do: [:j | row at: j put: (self row: anInteger column: j)].
	^row
]

{ #category : #'accessing row' }
JunAbstractMatrix >> atRow: anInteger put: aCollection [ 
	1 to: (self columnSize min: aCollection size)
		do: 
			[:j | 
			self 
				row: anInteger
				column: j
				put: (aCollection at: j)]
]

{ #category : #accessing }
JunAbstractMatrix >> collection: collection [ 
	| index row |
	index := 1.
	1 to: self rowSize
		do: 
			[:rowIndex | 
			row := self basicAt: rowIndex.
			1 to: self columnSize
				do: 
					[:columnIndex | 
					row at: columnIndex put: (collection at: index).
					index := index + 1]]
]

{ #category : #enumerating }
JunAbstractMatrix >> columnIndex: anInteger do: aBlock [ 
	self columnIndex: anInteger doI: [:v :i | aBlock value: v]
]

{ #category : #enumerating }
JunAbstractMatrix >> columnIndex: anInteger doI: aBlock [ 
	1 to: self rowSize do: [:i | aBlock value: (self row: i column: anInteger)
			value: i]
]

{ #category : #'accessing column' }
JunAbstractMatrix >> columnSize [
	^matrixSize y
]

{ #category : #'lisp support' }
JunAbstractMatrix >> columnSizeToLispList [
	| list |
	list := self lispCons.
	list head: #columnSize.
	list tail: self columnSize.
	^list
]

{ #category : #'accessing column' }
JunAbstractMatrix >> columns [
	| anArray |
	anArray := Array new: self columnSize.
	1 to: self columnSize
		do: [:index | anArray at: index put: (self atColumn: index)].
	^anArray
]

{ #category : #arithmetic }
JunAbstractMatrix >> compute: aSymbol with: aMatrix [ 
	^self subclassResponsibility
]

{ #category : #private }
JunAbstractMatrix >> computeLocation: anInteger [ 
	^anInteger - 1 // self columnSize + 1 @ (anInteger - 1 \\ self columnSize + 1)
]

{ #category : #copying }
JunAbstractMatrix >> copy [
	^self copyFrom: 1 @ 1 to: self matrixSize
]

{ #category : #copying }
JunAbstractMatrix >> copyFrom: startPoint to: endPoint [ 
	| i j m v sp ep |
	sp := 1 @ 1 max: startPoint.
	ep := startPoint max: (self matrixSize min: endPoint).
	m := self species new: ep x - sp x + 1 by: ep y - sp y + 1.
	i := 1.
	[i <= m rowSize]
		whileTrue: 
			[j := 1.
			[j <= m columnSize]
				whileTrue: 
					[v := self atPoint: sp - (1 @ 1) + (i @ j).
					m atPoint: i @ j put: v.
					j := j + 1].
			i := i + 1].
	^m
]

{ #category : #enumerating }
JunAbstractMatrix >> do: aBlock [ 
	self doIJ: [:v :i :j | aBlock value: v]
]

{ #category : #enumerating }
JunAbstractMatrix >> doIJ: aBlock [ 
	| i j rowSize columnSize row |
	rowSize := self rowSize.
	columnSize := self columnSize.
	i := 1.
	[i <= rowSize]
		whileTrue: 
			[row := self basicAt: i.
			j := 1.
			[j <= columnSize]
				whileTrue: 
					[aBlock
						value: (row at: j)
						value: i
						value: j.
					j := j + 1].
			i := i + 1]
]

{ #category : #'matrix functions' }
JunAbstractMatrix >> horizontalFlip [
	"(JunAbstractMatrix new: 3 collection: #(1 2 3 4 5 6 7 8 9)) horizontalFlip."

	"(JunAbstractMatrix new: 3 by: 4 collection: #(1 2 3 4 5 6 7 8 9 10 11 12)) horizontalFlip."

	| newMatrix columnSize |
	newMatrix := self species new: self rowSize
				by: (columnSize := self columnSize).
	self doIJ: 
			[:v :i :j | 
			newMatrix 
				row: i
				column: columnSize - j + 1
				put: v].
	^newMatrix
]

{ #category : #testing }
JunAbstractMatrix >> isSquare [
	"(JunAbstractMatrix new: 3 by: 3) isSquare."
	"(JunAbstractMatrix new: 3 by: 4) isSquare."

	^self rowSize = self columnSize
]

{ #category : #accessing }
JunAbstractMatrix >> matrixSize [
	^matrixSize
]

{ #category : #'matrix functions' }
JunAbstractMatrix >> mirror [
	"(JunAbstractMatrix new: 3 collection: #(1 2 3 4 5 6 7 8 9)) mirror."

	"(JunAbstractMatrix new: 3 by: 4 collection: #(1 2 3 4 5 6 7 8 9 10 11 12)) mirror."

	^self horizontalFlip
]

{ #category : #printing }
JunAbstractMatrix >> printOn: aStream [ 
	aStream nextPutAll: 'Matrix ('.
	self
		doIJ: 
			[:v :i :j | 
			v printOn: aStream.
			j = self columnSize
				ifTrue: [i = self rowSize ifFalse: [aStream nextPutAll: ' , ']]
				ifFalse: [aStream nextPutAll: ' ']].
	aStream nextPutAll: ')'
]

{ #category : #converting }
JunAbstractMatrix >> reduceGeneralityIfPossible [
	| collection |
	collection := OrderedCollection new: self size.
	self do: [:each | collection add: each reduceGeneralityIfPossible].
	^self species
		new: self rowSize
		by: self columnSize
		collection: collection
]

{ #category : #removing }
JunAbstractMatrix >> remove: oldObject ifAbsent: anExceptionBlock [ 
	self shouldNotImplement
]

{ #category : #enumerating }
JunAbstractMatrix >> reverseDo: aBlock [ 
	self reverseDoIJ: [:v :i :j | aBlock value: v]
]

{ #category : #enumerating }
JunAbstractMatrix >> reverseDoIJ: aBlock [ 
	| i j row |
	i := self rowSize.
	[i > 0]
		whileTrue: 
			[row := self basicAt: i.
			j := self columnSize.
			[j > 0]
				whileTrue: 
					[aBlock
						value: (row at: j)
						value: i
						value: j.
					j := j - 1].
			i := i - 1]
]

{ #category : #accessing }
JunAbstractMatrix >> row: rowNumber column: columnNumber [ 
	^(self basicAt: rowNumber)
		at: columnNumber
]

{ #category : #accessing }
JunAbstractMatrix >> row: rowNumber column: columnNumber put: anObject [ 
	^(self basicAt: rowNumber)
		at: columnNumber put: anObject
]

{ #category : #private }
JunAbstractMatrix >> rowIndex: anInteger convert: aBlock [ 
	self rowIndex: anInteger convertJ: [:v :j | aBlock value: v value: j]
]

{ #category : #private }
JunAbstractMatrix >> rowIndex: anInteger convertJ: aBlock [ 
	| row |
	row := self basicAt: anInteger.
	1 to: self columnSize do: [:j | row at: j put: (aBlock value: (row at: j)
				value: j)]
]

{ #category : #enumerating }
JunAbstractMatrix >> rowIndex: anInteger do: aBlock [ 
	self rowIndex: anInteger doJ: [:v :j | aBlock value: v]
]

{ #category : #enumerating }
JunAbstractMatrix >> rowIndex: anInteger doJ: aBlock [ 
	| row |
	row := self basicAt: anInteger.
	1 to: self columnSize do: [:j | aBlock value: (row at: j)
			value: j]
]

{ #category : #'accessing row' }
JunAbstractMatrix >> rowSize [
	^matrixSize x
]

{ #category : #private }
JunAbstractMatrix >> rowSize: sizeOfRow columnSize: sizeOfColumn [ 
	matrixSize := sizeOfRow @ sizeOfColumn
]

{ #category : #'lisp support' }
JunAbstractMatrix >> rowSizeToLispList [
	| list |
	list := self lispCons.
	list head: #rowSize.
	list tail: self rowSize.
	^list
]

{ #category : #'accessing row' }
JunAbstractMatrix >> rows [
	| anArray |
	anArray := Array new: self rowSize.
	1 to: self rowSize
		do: [:index | anArray at: index put: (self atRow: index)].
	^anArray
]

{ #category : #'lisp support' }
JunAbstractMatrix >> rowsToLispList [
	| list |
	list := self lispCons.
	list head: #rows.
	list tail: (self class defaultLispConsClass 
				list: (self rows collect: 
							[:row | 
							self class defaultLispConsClass 
								list: (row collect: 
											[:each | 
											| it |
											(each respondsTo: #toLispList) 
												ifTrue: 
													[self errorSignal handle: [:exception | it := each yourself]
														do: [it := each toLispList]]
												ifFalse: [it := each yourself].
											it yourself])])).
	^list
]

{ #category : #accessing }
JunAbstractMatrix >> size [
	^self columnSize * self rowSize
]

{ #category : #printing }
JunAbstractMatrix >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' new: '.
	self rowSize storeOn: aStream.
	aStream nextPutAll: ' by: '.
	self columnSize storeOn: aStream.
	aStream nextPutAll: ' collection: '.
	self asArray storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'lisp support' }
JunAbstractMatrix >> toLispList [
	"self showLispList: ((JunMatrix exampleMatrix) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self rowSizeToLispList.
	list add: self columnSizeToLispList.
	list add: self rowsToLispList.
	^list
]

{ #category : #'matrix functions' }
JunAbstractMatrix >> transpose [
	"(JunAbstractMatrix new: 3 collection: #(1 2 3 4 5 6 7 8 9)) transpose."

	"(JunAbstractMatrix new: 3 by: 4 collection: #(1 2 3 4 5 6 7 8 9 10 11 12)) transpose."

	| newMatrix |
	newMatrix := self species new: self columnSize by: self rowSize.
	self doIJ: 
			[:v :i :j | 
			newMatrix 
				row: j
				column: i
				put: v].
	^newMatrix
]

{ #category : #'matrix functions' }
JunAbstractMatrix >> upsideDown [
	"(JunAbstractMatrix new: 3 collection: #(1 2 3 4 5 6 7 8 9)) upsideDown."

	"(JunAbstractMatrix new: 3 by: 4 collection: #(1 2 3 4 5 6 7 8 9 10 11 12)) upsideDown."

	^self verticalFlip
]

{ #category : #'matrix functions' }
JunAbstractMatrix >> verticalFlip [
	"(JunAbstractMatrix new: 3 collection: #(1 2 3 4 5 6 7 8 9)) verticalFlip."

	"(JunAbstractMatrix new: 3 by: 4 collection: #(1 2 3 4 5 6 7 8 9 10 11 12)) verticalFlip."

	| newMatrix rowSize |
	newMatrix := self species new: (rowSize := self rowSize)
				by: self columnSize.
	self doIJ: 
			[:v :i :j | 
			newMatrix 
				row: rowSize - i + 1
				column: j
				put: v].
	^newMatrix
]

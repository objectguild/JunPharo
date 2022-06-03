"
Imported by VwImportClass
"
Class {
	#name : #JunBooleanMatrix,
	#superclass : #JunAbstractMatrix,
	#category : #'Jun-Collections-Sequences'
}

{ #category : #copyright }
JunBooleanMatrix class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunBooleanMatrix class >> system [
	^'Jun'
]

{ #category : #'instance creation' }
JunBooleanMatrix class >> unit: squareSize [ 
	"JunBooleanMatrix unit: 4."

	| unitMatrix |
	unitMatrix := self new: squareSize.
	unitMatrix doIJ: [:v :i :j | unitMatrix atPoint: i @ j put: (i = j
				ifTrue: [true]
				ifFalse: [false])].
	^unitMatrix
]

{ #category : #copyright }
JunBooleanMatrix class >> version [
	^'799'
]

{ #category : #'matrix functions' }
JunBooleanMatrix >> closureMatrix [
	"(JunBooleanMatrix new: 3 collection: #(true false true true true false true false true)) closureMatrix."

	self isSquare not ifTrue: [^self error: 'The receiver must be a square matrix'].
	^self raisedTo: self rowSize
]

{ #category : #arithmetic }
JunBooleanMatrix >> compute: aSymbol with: aMatrix [ 
	| newMatrix newValue |
	(aMatrix isKindOf: Boolean)
		ifTrue: 
			[newMatrix := self copy.
			newMatrix
				doIJ: 
					[:v :i :j | 
					newValue := newMatrix row: i column: j.
					newValue := newValue perform: aSymbol with: aMatrix.
					newMatrix
						row: i
						column: j
						put: newValue]]
		ifFalse: 
			[newMatrix := self copy.
			newMatrix
				doIJ: 
					[:v :i :j | 
					newValue := newMatrix row: i column: j.
					(i <= aMatrix rowSize and: [j <= aMatrix columnSize])
						ifTrue: [newValue := newValue perform: aSymbol with: (aMatrix atPoint: i @ j)].
					newMatrix
						row: i
						column: j
						put: newValue]].
	^newMatrix
]

{ #category : #testing }
JunBooleanMatrix >> includesFalse [
	self do: [:v | v = false ifTrue: [^true]].
	^false
]

{ #category : #'matrix functions' }
JunBooleanMatrix >> product: aBooleanMatrix [ 
	"(JunBooleanMatrix new: 3 collection: #(true false false true true false false false true)) 
	product: (JunBooleanMatrix new: 3 collection: #(true false true true true false false false true))."

	| newMatrix answer |
	self columnSize = aBooleanMatrix rowSize ifFalse: [^self error: 'my column size is not equal to your row size)'].
	newMatrix := self species new: self rowSize by: aBooleanMatrix columnSize.
	1 to: self rowSize do: [:i | 1 to: aBooleanMatrix columnSize
			do: 
				[:j | 
				answer := false.
				self rowIndex: i doJ: [:value :k | answer := answer or: [value and: [aBooleanMatrix atPoint: k @ j]]].
				newMatrix atPoint: i @ j put: answer]].
	^newMatrix
]

{ #category : #'matrix functions' }
JunBooleanMatrix >> raisedTo: anInteger [ 
	"(JunBooleanMatrix new: 3 collection: #(true false true true true false false false true)) 
	raisedTo: 2."

	| power poweredMatrix |
	self isSquare not ifTrue: [^self error: 'The receiver must be a square matrix.'].
	power := anInteger rounded.
	power < 0 ifTrue: [^self error: 'The argument must be positive or zero.'].
	power = 0 ifTrue: [^self class unit: self rowSize].
	power = 1 ifTrue: [^self].
	poweredMatrix := self.
	power - 1 timesRepeat: [poweredMatrix := self product: poweredMatrix].
	^poweredMatrix
]

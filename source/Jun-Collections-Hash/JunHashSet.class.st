"
Imported by VwImportClass
"
Class {
	#name : #JunHashSet,
	#superclass : #JunHashAbstract,
	#instVars : [
		'hashTally',
		'hashArray'
	],
	#category : #'Jun-Collections-Hash'
}

{ #category : #copyright }
JunHashSet class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunHashSet class >> example1 [
	"JunHashSet example1."

	| aCollection |
	aCollection := JunHashSet new.
	Transcript clear.
	aCollection add: 'abc'.
	aCollection add: 'def'.
	aCollection add: 'ghi'.
	aCollection add: 'jkl'.
	aCollection add: 'mno'.
	aCollection add: 'pqr'.
	aCollection add: 'stu'.
	aCollection add: 'vwx'.
	aCollection add: 'yz0'.
	Transcript
		cr;
		show: (aCollection includes: 'abc') printString.
	aCollection add: 'abc' copy.
	Transcript
		cr;
		show: aCollection size printString.
	aCollection add: '123'.
	aCollection add: '456'.
	aCollection add: '789'.
	aCollection remove: 'ghi'.
	Transcript
		cr;
		show: aCollection size printString.
	Transcript cr.
	aCollection printOn: Transcript.
	Transcript flush.
	^aCollection
]

{ #category : #examples }
JunHashSet class >> example2 [
	"JunHashSet example2."

	| aCollection |
	aCollection := JunHashSet new.
	Transcript clear.
	aCollection add: 'abc'.
	aCollection add: 'def'.
	aCollection add: 'ghi'.
	aCollection add: 'jkl'.
	aCollection add: 'mno'.
	aCollection add: 'pqr'.
	aCollection add: 'stu'.
	aCollection add: 'vwx'.
	aCollection add: 'yz0'.
	aCollection add: 'abc' copy.
	aCollection add: '123'.
	aCollection add: '456'.
	aCollection add: '789'.
	Transcript cr.
	aCollection printOn: Transcript.
	Transcript cr.
	(aCollection select: [:each | each = 'ghi']) printOn: Transcript.
	Transcript cr.
	(aCollection select: [:each | each first isDigit]) printOn: Transcript.
	Transcript cr.
	(aCollection reject: [:each | each first isDigit]) printOn: Transcript.
	Transcript cr.
	(aCollection 
		collect: [:each | each inject: 0 into: [:v :c | v + c asInteger]]) 
			printOn: Transcript.
	Transcript cr.
	(aCollection inject: 0
		into: [:value :each | value + (each inject: 0 into: [:v :c | v + c asInteger])]) 
			printOn: Transcript.
	Transcript flush.
	^aCollection
]

{ #category : #copyright }
JunHashSet class >> system [
	^'Jun'
]

{ #category : #copyright }
JunHashSet class >> version [
	^'799'
]

{ #category : #adding }
JunHashSet >> add: theObject [ 
	| hashIndex |
	(hashIndex := self indexOf: theObject) = 0 
		ifTrue: 
			[hashTally := self null.
			hashIndex := self hashIndexOf: theObject.
			(hashIndex := self indexOfNullFrom: hashIndex to: hashArray size) = 0 
				ifTrue: [hashIndex := self indexOfNullFrom: 1 to: hashIndex - 1].
			hashIndex = 0 
				ifTrue: 
					[| oldArray |
					oldArray := hashArray.
					hashArray := Array new: hashArray size * 2 withAll: self null.
					oldArray do: [:anObject | anObject == self null ifFalse: [self add: anObject]].
					self add: theObject]
				ifFalse: [hashArray at: hashIndex put: theObject]]
		ifFalse: [hashArray at: hashIndex put: theObject].
	^theObject
]

{ #category : #private }
JunHashSet >> compare: firstObject with: secondObject [ 
	^firstObject = secondObject
]

{ #category : #enumerating }
JunHashSet >> do: aBlock [ 
	| aValue |
	hashArray 
		do: [:anObject | anObject == self null ifFalse: [aValue := aBlock value: anObject]].
	^aValue
]

{ #category : #private }
JunHashSet >> hashIndexOf: theObject [ 
	^theObject hash \\ hashArray size + 1
]

{ #category : #testing }
JunHashSet >> includes: theObject [ 
	^(self indexOf: theObject) ~= 0
]

{ #category : #private }
JunHashSet >> indexOf: theObject [ 
	| hashIndex anObject |
	hashIndex := self hashIndexOf: theObject.
	((anObject := hashArray at: hashIndex) == self null 
		or: [(self compare: theObject with: anObject) not]) 
			ifTrue: 
				[(hashIndex := self 
							indexOf: theObject
							from: hashIndex + 1
							to: hashArray size) = 0 
					ifTrue: 
						[hashIndex := self 
									indexOf: theObject
									from: 1
									to: hashIndex - 1]].
	^hashIndex
]

{ #category : #private }
JunHashSet >> indexOf: theObject from: fromIndex to: toIndex [ 
	fromIndex to: toIndex
		do: 
			[:anIndex | 
			| anObject |
			(anObject := hashArray at: anIndex) == self null 
				ifFalse: [(self compare: theObject with: anObject) ifTrue: [^anIndex]]].
	^0
]

{ #category : #private }
JunHashSet >> indexOfNullFrom: fromIndex to: toIndex [ 
	fromIndex to: toIndex
		do: [:anIndex | (hashArray at: anIndex) == self null ifTrue: [^anIndex]].
	^0
]

{ #category : #'initialize-release' }
JunHashSet >> initialize [
	self initialize: 10
]

{ #category : #'initialize-release' }
JunHashSet >> initialize: capacity [ 
	super initialize: capacity.
	hashTally := self null.
	hashArray := Array new: capacity withAll: self null
]

{ #category : #copying }
JunHashSet >> postCopy [
	hashArray := hashArray copy
]

{ #category : #removing }
JunHashSet >> remove: theObject [ 
	^self remove: theObject ifAbsent: [self class notFoundSignal raise]
]

{ #category : #removing }
JunHashSet >> remove: theObject ifAbsent: aBlock [ 
	| hashIndex anObject |
	(hashIndex := self indexOf: theObject) = 0 ifTrue: [^aBlock value].
	hashTally := self null.
	anObject := hashArray at: hashIndex.
	hashArray at: hashIndex put: self null.
	^anObject
]

{ #category : #accessing }
JunHashSet >> size [
	hashTally == self null ifTrue: [hashTally := super size].
	^hashTally
]

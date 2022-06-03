"
Imported by VwImportClass
"
Class {
	#name : #JunSequence,
	#superclass : #SequenceableCollection,
	#category : #'Jun-Collections-Sequences'
}

{ #category : #copyright }
JunSequence class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #defaults }
JunSequence class >> defaultLispConsClass [
	^JunLispCons
]

{ #category : #defaults }
JunSequence class >> defaultLispNilClass [
	^JunLispNil
]

{ #category : #defaults }
JunSequence class >> defaultLispParserClass [
	^JunLispParser
]

{ #category : #'lisp support' }
JunSequence class >> fromLispList: aList [ 
	| anObject |
	anObject := (Smalltalk at: aList head) new.
	anObject class fromLispList: aList for: anObject.
	^anObject
]

{ #category : #'lisp support' }
JunSequence class >> fromLispList: aList for: anObject [ 
	| aTable |
	aTable := self tableFromLispList: aList tail.
	anObject class fromTable: aTable for: anObject.
	^anObject
]

{ #category : #'lisp support' }
JunSequence class >> fromTable: aTable for: anObject [ 
	| vars index var value nth |
	vars := anObject class allInstVarNames.
	(aTable associations asSortedCollection: [:a :b | a key head < b key head]) 
		do: 
			[:assoc | 
			index := assoc key head.
			var := assoc key tail.
			value := assoc value.
			nth := vars findFirst: [:each | each = var].
			nth > 0 
				ifTrue: 
					[nth = index ifFalse: [index := nth].
					anObject instVarAt: index put: value]
				ifFalse: 
					[Transcript
						cr;
						show: 'Not found instance variable ' , var printString , ' in ' 
									, anObject class printString]].
	^anObject
]

{ #category : #'lisp support' }
JunSequence class >> lispCons [
	^self defaultLispConsClass cell
]

{ #category : #'lisp support' }
JunSequence class >> lispNil [
	^self defaultLispNilClass null
]

{ #category : #'lisp support' }
JunSequence class >> showLispList: aList [ 
	^JunAbstractObject showLispList: aList
]

{ #category : #copyright }
JunSequence class >> system [
	^'Jun'
]

{ #category : #'lisp support' }
JunSequence class >> tableFromLispList: aList [ 
	"JunSequence tableFromLispList: (JunLispParser parse: '((a . 1) (b . 2) (c . 3))')."

	| aTable |
	aTable := JunAttributeTable new.
	aList do: 
			[:pair | 
			(pair isKindOf: self defaultLispConsClass) 
				ifTrue: [aTable at: pair head put: pair tail]].
	^aTable
]

{ #category : #copyright }
JunSequence class >> version [
	^'799'
]

{ #category : #arithmetic }
JunSequence >> * aSequence [ 
	^self compute: #* with: aSequence
]

{ #category : #arithmetic }
JunSequence >> + aSequence [ 
	^self compute: #+ with: aSequence
]

{ #category : #copying }
JunSequence >> , aSequence [ 
	| newSequence |
	newSequence := self shallowCopy.
	aSequence do: [:each | newSequence add: each].
	^newSequence
]

{ #category : #arithmetic }
JunSequence >> - aSequence [ 
	^self compute: #- with: aSequence
]

{ #category : #arithmetic }
JunSequence >> / aSequence [ 
	^self compute: #/ with: aSequence
]

{ #category : #arithmetic }
JunSequence >> // aSequence [ 
	^self compute: #// with: aSequence
]

{ #category : #comparing }
JunSequence >> = otherCollection [ 
	| size |
	self species == otherCollection species ifFalse: [^false].
	(size := self size) = otherCollection size ifFalse: [^false].
	1 to: size do: [:index | (self at: index)
			= (otherCollection at: index) ifFalse: [^false]].
	^true
]

{ #category : #adding }
JunSequence >> addAll: aCollection [ 
	aCollection do: [:each | self add: each]
]

{ #category : #converting }
JunSequence >> asArray [
	| anArray index |
	anArray := Array new: self size.
	index := 1.
	self do: 
		[:each | 
		anArray at: index put: each.
		index := index + 1].
	^anArray
]

{ #category : #converting }
JunSequence >> asBag [
	| aBag |
	aBag := Bag new.
	self do: [:each | aBag add: each].
	^aBag
]

{ #category : #converting }
JunSequence >> asOrderedCollection [
	| anOrderedCollection |
	anOrderedCollection := OrderedCollection new.
	self do: [:each | anOrderedCollection addLast: each].
	^anOrderedCollection
]

{ #category : #converting }
JunSequence >> asSet [
	| aSet |
	aSet := Set new.
	self do: [:each | aSet add: each].
	^aSet
]

{ #category : #converting }
JunSequence >> asSortedCollection [
	^self asArray asSortedCollection
]

{ #category : #converting }
JunSequence >> asSortedCollection: aBlock [ 
	^self asArray asSortedCollection: aBlock
]

{ #category : #accessing }
JunSequence >> at: indexInteger [ 
	| count |
	count := 1.
	self do: 
		[:each | 
		indexInteger = count ifTrue: [^each].
		count := count + 1].
	^self subscriptOutOfBoundsError: indexInteger
]

{ #category : #accessing }
JunSequence >> at: indexInteger put: anObject [ 
	^self subclassResponsibility
]

{ #category : #enumerating }
JunSequence >> collect: aBlock [ 
	| newCollection |
	newCollection := self species new.
	self do: [:each | newCollection add: (aBlock value: each)].
	^newCollection
]

{ #category : #arithmetic }
JunSequence >> compute: aSymbol with: aSequence [ 
	| array1 array2 newSequence |
	array1 := self asArray.
	(aSequence isKindOf: Number)
		ifTrue: [1 to: array1 size do: [:i | array1 at: i put: ((array1 at: i)
						perform: aSymbol with: aSequence)]]
		ifFalse: 
			[array2 := aSequence asArray.
			1 to: (array1 size min: array2 size)
				do: [:i | array1 at: i put: ((array1 at: i)
							perform: aSymbol with: (array2 at: i))]].
	newSequence := self species new.
	newSequence addAll: array1.
	^newSequence
]

{ #category : #copying }
JunSequence >> copy [
	| newSequence |
	newSequence := self species new.
	self do: [:each | newSequence add: each].
	^newSequence
]

{ #category : #copying }
JunSequence >> copyWith: newElement [ 
	| newSequence |
	newSequence := self shallowCopy.
	newSequence add: newElement.
	^newSequence
]

{ #category : #copying }
JunSequence >> copyWithout: oldElement [ 
	^self select: [:each | oldElement ~= each]
]

{ #category : #enumerating }
JunSequence >> findFirst: aBlock [ 
	| index |
	index := 1.
	self do: 
		[:each | 
		(aBlock value: each)
			ifTrue: [^index].
		index := index + 1].
	^0
]

{ #category : #enumerating }
JunSequence >> findLast: aBlock [ 
	| index |
	index := self size.
	self
		reverseDo: 
			[:each | 
			(aBlock value: each)
				ifTrue: [^index].
			index := index - 1].
	^0
]

{ #category : #comparing }
JunSequence >> hash [
	self size = 0 ifTrue: [^17171].
	^((self at: 1) hash bitShift: -3)
		bitXor: (self at: self size) hash
]

{ #category : #'lisp support' }
JunSequence >> kindName [
	^self class name
]

{ #category : #'lisp support' }
JunSequence >> lispCons [
	^self class lispCons
]

{ #category : #'lisp support' }
JunSequence >> lispNil [
	^self class lispNil
]

{ #category : #enumerating }
JunSequence >> reverse [
	| reverseSequence |
	reverseSequence := self species new.
	self reverseDo: [:each | reverseSequence add: each].
	^reverseSequence
]

{ #category : #enumerating }
JunSequence >> select: aBlock [ 
	| newCollection |
	newCollection := self species new.
	self do: [:each | (aBlock value: each)
			ifTrue: [newCollection add: each]].
	^newCollection
]

{ #category : #copying }
JunSequence >> shallowCopy [
	| newSequence |
	newSequence := self species new.
	self do: [:each | newSequence add: each].
	^newSequence
]

{ #category : #'lisp support' }
JunSequence >> showLispList [
	^self showLispList: self toLispList
]

{ #category : #'lisp support' }
JunSequence >> showLispList: aList [ 
	^self class showLispList: aList
]

{ #category : #accessing }
JunSequence >> size [
	| tally |
	tally := 0.
	self do: [:each | tally := tally + 1].
	^tally
]

{ #category : #private }
JunSequence >> subscriptOutOfBoundsError: index [ 
	^self error: 'subscript out of bounds: ' , index printString
]

{ #category : #'lisp support' }
JunSequence >> toLispList [
	| list vars |
	list := self lispCons.
	list head: self kindName.
	vars := self class allInstVarNames.
	(1 to: vars size) with: vars
		do: 
			[:index :var | 
			| couple pair |
			couple := self lispCons.
			couple head: index.
			couple tail: var.
			pair := self lispCons.
			pair head: couple.
			pair tail: (self instVarAt: index).
			list add: pair].
	^list
]

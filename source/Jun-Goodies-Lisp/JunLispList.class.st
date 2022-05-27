"
Imported by VwImportClass
"
Class {
	#name : #JunLispList,
	#superclass : #SequenceableCollection,
	#category : #'Jun-Goodies-Lisp'
}

{ #category : #'instance creation' }
JunLispList class >> cell [
	^JunLispCons cell
]

{ #category : #copyright }
JunLispList class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunLispList class >> head: headObject [ 
	^JunLispCons head: headObject
]

{ #category : #'instance creation' }
JunLispList class >> head: headObject tail: tailObject [ 
	^JunLispCons head: headObject tail: tailObject
]

{ #category : #'instance creation' }
JunLispList class >> list: anArray [ 
	"JunLispList list: #(1 2 3 4)"

	| size list |
	size := anArray size.
	list := self null.
	size
		to: 1
		by: -1
		do: [:i | list := self head: (anArray at: i)
						tail: list].
	^list
]

{ #category : #'instance creation' }
JunLispList class >> loadFrom: aStream [ 
	^JunLispParser parse: aStream
]

{ #category : #'instance creation' }
JunLispList class >> new: anInteger [ 
	"JunLispList new: 5"

	| newList |
	newList := self null.
	anInteger timesRepeat: [newList := self head: self null tail: newList].
	^newList
]

{ #category : #'instance creation' }
JunLispList class >> null [
	^JunLispNil null
]

{ #category : #copyright }
JunLispList class >> system [
	^'Jun'
]

{ #category : #copyright }
JunLispList class >> version [
	^'799'
]

{ #category : #'instance creation' }
JunLispList class >> with: anObject [ 
	"JunLispList with: 1"

	^self head: anObject
]

{ #category : #'instance creation' }
JunLispList class >> with: firstObject with: secondObject [ 
	"JunLispList with: 1 with: 2"

	^self head: firstObject tail: (self with: secondObject)
]

{ #category : #'instance creation' }
JunLispList class >> with: firstObject with: secondObject with: thirdObject [ 
	"JunLispList with: 1 with: 2 with: 3"

	^self head: firstObject tail: (self with: secondObject with: thirdObject)
]

{ #category : #'instance creation' }
JunLispList class >> with: firstObject with: secondObject with: thirdObject with: fourthObject [ 
	"JunLispList with: 1 with: 2 with: 3 with: 4"

	^self head: firstObject tail: (self
			with: secondObject
			with: thirdObject
			with: fourthObject)
]

{ #category : #accessing }
JunLispList >> at: indexInteger put: anObject [ 
	^self subscriptOutOfBoundsError: indexInteger
]

{ #category : #enumerating }
JunLispList >> do: aBlock [ 
	^self
]

{ #category : #testing }
JunLispList >> isCons [
	^self null not
]

{ #category : #testing }
JunLispList >> isLiteralSymbol: aSymbol [ 
	^self errorSignal handle: [:exception | false]
		do: [Scanner isLiteralSymbol: aSymbol]
]

{ #category : #testing }
JunLispList >> isQuotedSymbol: aSymbol [ 
	^(self isLiteralSymbol: aSymbol) not
]

{ #category : #testing }
JunLispList >> null [
	^false
]

{ #category : #accessing }
JunLispList >> size [
	| tally |
	tally := 0.
	self do: [:each | tally := tally + 1].
	^tally
]

{ #category : #private }
JunLispList >> subscriptOutOfBoundsError: index [ 
	^self error: 'subscript out of bounds: ' , index printString
]

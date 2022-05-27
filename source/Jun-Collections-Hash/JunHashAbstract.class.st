"
Imported by VwImportClass
"
Class {
	#name : #JunHashAbstract,
	#superclass : #JunAbstractObject,
	#category : #'Jun-Collections-Hash'
}

{ #category : #copyright }
JunHashAbstract class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunHashAbstract class >> new: capacity [ 
	^(super new)
		initialize: capacity;
		yourself
]

{ #category : #accessing }
JunHashAbstract class >> null [
	"JunHashAbstract null."

	"Transcript cr; show: JunHashAbstract null hash printString."

	^JunHashNull null
]

{ #category : #copyright }
JunHashAbstract class >> system [
	^'Jun'
]

{ #category : #copyright }
JunHashAbstract class >> version [
	^'799'
]

{ #category : #'instance creation' }
JunHashAbstract class >> with: anObject [ 
	| newCollection |
	newCollection := self new.
	newCollection add: anObject.
	^newCollection
]

{ #category : #'instance creation' }
JunHashAbstract class >> with: firstObject with: secondObject [ 
	| newCollection |
	newCollection := self new.
	newCollection add: firstObject.
	newCollection add: secondObject.
	^newCollection
]

{ #category : #'instance creation' }
JunHashAbstract class >> with: firstObject with: secondObject with: thirdObject [ 
	| newCollection |
	newCollection := self new.
	newCollection add: firstObject.
	newCollection add: secondObject.
	newCollection add: thirdObject.
	^newCollection
]

{ #category : #'instance creation' }
JunHashAbstract class >> with: firstObject with: secondObject with: thirdObject with: fourthObject [ 
	| newCollection |
	newCollection := self new.
	newCollection add: firstObject.
	newCollection add: secondObject.
	newCollection add: thirdObject.
	newCollection add: fourthObject.
	^newCollection
]

{ #category : #'instance creation' }
JunHashAbstract class >> withAll: aCollection [ 
	| newCollection |
	newCollection := self new.
	newCollection addAll: aCollection.
	^newCollection
]

{ #category : #adding }
JunHashAbstract >> add: theObject [ 
	^self subclassResponsibility
]

{ #category : #adding }
JunHashAbstract >> addAll: aCollection [ 
	aCollection do: [:each | self add: each].
	^aCollection
]

{ #category : #converting }
JunHashAbstract >> asArray [
	| collection index |
	collection := Array new: self size.
	index := 0.
	self do: [:each | collection at: (index := index + 1) put: each].
	^collection
]

{ #category : #converting }
JunHashAbstract >> asBag [
	| aBag |
	aBag := Bag new.
	self do: [:each | aBag add: each].
	^aBag
]

{ #category : #converting }
JunHashAbstract >> asList [
	| aList |
	aList := List new: self size.
	self do: [:each | aList addLast: each].
	^aList
]

{ #category : #converting }
JunHashAbstract >> asOrderedCollection [
	| collection index |
	collection := OrderedCollection new: self size.
	index := 0.
	self do: [:each | collection at: (index := index + 1) put: each].
	^collection
]

{ #category : #converting }
JunHashAbstract >> asSet [
	| aSet |
	aSet := Set withAll: self.
	^aSet
]

{ #category : #converting }
JunHashAbstract >> asSortedCollection [
	^self asArray asSortedCollection
]

{ #category : #converting }
JunHashAbstract >> asSortedCollection: sortBlock [ 
	^self asArray asSortedCollection: sortBlock
]

{ #category : #enumerating }
JunHashAbstract >> collect: aBlock [ 
	| aCollection |
	aCollection := self class new.
	self do: [:anObject | aCollection add: (aBlock value: anObject)].
	^aCollection
]

{ #category : #enumerating }
JunHashAbstract >> detect: aBlock [ 
	^self detect: aBlock ifNone: [self class notFoundSignal raise]
]

{ #category : #enumerating }
JunHashAbstract >> detect: aBlock ifNone: exceptionBlock [ 
	self do: [:anObject | (aBlock value: anObject) ifTrue: [^anObject]].
	^exceptionBlock value
]

{ #category : #enumerating }
JunHashAbstract >> do: aBlock [ 
	^self subclassResponsibility
]

{ #category : #testing }
JunHashAbstract >> includes: theObject [ 
	^self subclassResponsibility
]

{ #category : #'initialize-release' }
JunHashAbstract >> initialize [
	^self
]

{ #category : #'initialize-release' }
JunHashAbstract >> initialize: capacity [ 
	^self
]

{ #category : #enumerating }
JunHashAbstract >> inject: thisValue into: binaryBlock [ 
	| nextValue |
	nextValue := thisValue.
	self do: [:each | nextValue := binaryBlock value: nextValue value: each].
	^nextValue
]

{ #category : #testing }
JunHashAbstract >> isEmpty [
	^self size <= 0
]

{ #category : #private }
JunHashAbstract >> maxPrint [
	^4000
]

{ #category : #accessing }
JunHashAbstract >> null [
	"JunHashAbstract new null."

	"Transcript cr; show: JunHashAbstract new null hash printString."

	^JunHashNull null
]

{ #category : #printing }
JunHashAbstract >> printOn: aStream [ 
	| tooMany sizeInteger anInteger |
	tooMany := aStream position + self maxPrint.
	sizeInteger := self size.
	anInteger := 0.
	aStream nextPutAll: '('.
	self do: 
			[:anObject | 
			aStream position > tooMany 
				ifTrue: 
					[aStream nextPutAll: (#etc << #dialogs >> '...etc...') asString , ')'.
					^self].
			anObject printOn: aStream.
			anInteger := anInteger + 1.
			anInteger < sizeInteger ifTrue: [aStream space]].
	aStream nextPutAll: ')'.
	aStream flush
]

{ #category : #enumerating }
JunHashAbstract >> reject: aBlock [ 
	^self select: [:anObject | (aBlock value: anObject) not]
]

{ #category : #removing }
JunHashAbstract >> remove: theObject [ 
	^self subclassResponsibility
]

{ #category : #enumerating }
JunHashAbstract >> select: aBlock [ 
	| aCollection |
	aCollection := self class new.
	self 
		do: [:anObject | (aBlock value: anObject) ifTrue: [aCollection add: anObject]].
	^aCollection
]

{ #category : #accessing }
JunHashAbstract >> size [
	| anInteger |
	anInteger := 0.
	self do: [:anObject | anInteger := anInteger + 1].
	^anInteger
]

{ #category : #enumerating }
JunHashAbstract >> with: aSequenceableCollection do: aBlock [ 
	| index |
	self size = aSequenceableCollection size 
		ifFalse: [^self error: 'collection sizes do not match'].
	index := 0.
	self do: 
			[:each | 
			aBlock value: each
				value: (aSequenceableCollection at: (index := index + 1))]
]

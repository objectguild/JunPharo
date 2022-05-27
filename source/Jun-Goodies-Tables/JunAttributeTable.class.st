"
Imported by VwImportClass
"
Class {
	#name : #JunAttributeTable,
	#superclass : #JunAbstractObject,
	#instVars : [
		'attributeTable'
	],
	#category : #'Jun-Goodies-Tables'
}

{ #category : #'lisp support' }
JunAttributeTable class >> attributeTableFromLispList: aList for: targetAttributes [ 
	| pair |
	pair := aList 
				detect: [:car | (car isKindOf: JunLispCons) and: [car head = #attributeTable]]
				ifNone: [nil].
	pair isNil ifTrue: [^targetAttributes].
	pair tail do: 
			[:cons | 
			| object species |
			((cons tail isKindOf: JunLispCons) and: 
					[(species := Smalltalk at: cons tail head ifAbsent: [nil]) notNil 
						and: [species respondsTo: #fromLispList:]]) 
				ifTrue: [object := species fromLispList: cons tail]
				ifFalse: [object := cons tail].
			targetAttributes at: cons head put: object].
	^targetAttributes
]

{ #category : #copyright }
JunAttributeTable class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunAttributeTable class >> example1 [
	"JunAttributeTable example1."

	| attributes |
	attributes := JunAttributeTable new.
	Transcript
		cr;
		show: attributes printString.
	^attributes
]

{ #category : #examples }
JunAttributeTable class >> example2 [
	"JunAttributeTable example2."

	| attributes |
	attributes := JunAttributeTable new.
	attributes at: #one put: 1.
	attributes at: #two put: 2.
	attributes at: #three put: 3.
	attributes at: #four put: 4.
	attributes at: #five put: 5.
	attributes at: #six put: 6.
	attributes at: #seven put: 7.
	attributes at: #eight put: 8.
	attributes at: #nine put: 9.
	attributes at: #ten put: 10.
	Transcript
		cr;
		show: attributes printString.
	^attributes
]

{ #category : #examples }
JunAttributeTable class >> example3 [
	"JunAttributeTable example3."

	| list attributes |
	list := JunLispParser 
				parse: '
	(JunAttributeTable
		(size . 10)
		(attributeTable
			(eight . 8)
			(five . 5)
			(four . 4)
			(nine . 9)
			(one . 1)
			(seven . 7)
			(six . 6)
			(ten JunAttributeTable
				(size . 10)
				(attributeTable
					(eight . 8)
					(five . 5)
					(four . 4)
					(nine . 9)
					(one . 1)
					(seven . 7)
					(six . 6)
					(ten . 10)
					(three . 3)
					(two . 2)))
			(three . 3)
			(two . 2)))
	'.
	attributes := JunAttributeTable fromLispList: list.
	Transcript
		cr;
		show: attributes printString.
	^attributes
]

{ #category : #examples }
JunAttributeTable class >> example4 [
	"JunAttributeTable example4."

	| attributes |
	attributes := JunAttributeTable new.
	attributes at: #one put: 1.
	attributes at: #two put: 2.
	attributes at: #three put: 3.
	attributes at: #four put: 4.
	attributes at: #five put: 5.
	attributes at: #six put: 6.
	attributes at: #seven put: 7.
	attributes at: #eight put: 8.
	attributes at: #nine put: 9.
	attributes at: #ten put: 10.
	attributes := Compiler evaluate: attributes storeString.
	Transcript
		cr;
		show: attributes printString.
	^attributes
]

{ #category : #'instance creation' }
JunAttributeTable class >> fromDictionary: aDictionary [ 
	"JunAttributeTable fromDictionary: ((Dictionary new)
			add: #eyePoint -> (20 , 20 , 20);
			add: #viewFactor -> 10;
			add: #shading -> #smoothShading;
			add: #projection -> #perspectiveProjection;
			add: #upVector -> (-0.4 , -0.4 , 0.8);
			add: #sightPoint -> (0.0 , 0.0 , 0.0);
			add: #presentation -> #solidPresentation;
			add: #zoomHeight -> 8.5;
			yourself)."

	| attributes |
	attributes := self new: aDictionary size.
	aDictionary keysAndValuesDo: [:key :value | attributes at: key put: value].
	^attributes
]

{ #category : #'lisp support' }
JunAttributeTable class >> fromLispList: aList [ 
	| attributes |
	attributes := (Smalltalk at: aList head) 
				new: (self sizeFromLispList: aList).
	self attributeTableFromLispList: aList for: attributes.
	^attributes
]

{ #category : #'instance creation' }
JunAttributeTable class >> fromString: aString [ 
	"JunAttributeTable fromString: '
		(JunAttributeTable
			(attributeTable
				(eight . 8)
				(five . 5)
				(four . 4)
				(nine . 9)
				(one . 1)
				(seven . 7)
				(six . 6)
				(ten . 10)
				(three . 3)
				(two . 2)))
		'."

	| list attributes |
	list := JunLispParser parse: aString.
	attributes := JunAttributeTable fromLispList: list.
	^attributes
]

{ #category : #'instance creation' }
JunAttributeTable class >> new [
	^self new: 0
]

{ #category : #'instance creation' }
JunAttributeTable class >> new: size [ 
	^(super new)
		initialize: size;
		yourself
]

{ #category : #'lisp support' }
JunAttributeTable class >> sizeFromLispList: aList [ 
	| pair |
	pair := aList 
				detect: [:car | (car isKindOf: JunLispCons) and: [car head = #size]]
				ifNone: [nil].
	pair isNil ifTrue: [^0].
	^pair tail
]

{ #category : #copyright }
JunAttributeTable class >> system [
	^'Jun'
]

{ #category : #copyright }
JunAttributeTable class >> version [
	^'799'
]

{ #category : #adding }
JunAttributeTable >> add: anAssociation [ 
	^self at: anAssociation key put: anAssociation value
]

{ #category : #converting }
JunAttributeTable >> asDictionary [
	^self attributeTable copy
]

{ #category : #converting }
JunAttributeTable >> asString [
	^self saveString
]

{ #category : #accessing }
JunAttributeTable >> associationAt: key [ 
	^attributeTable associationAt: key
]

{ #category : #accessing }
JunAttributeTable >> associationAt: key ifAbsent: aBlock [ 
	^attributeTable associationAt: key ifAbsent: aBlock
]

{ #category : #accessing }
JunAttributeTable >> associations [
	^attributeTable associations
]

{ #category : #enumerating }
JunAttributeTable >> associationsDo: aBlock [ 
	attributeTable associationsDo: aBlock
]

{ #category : #accessing }
JunAttributeTable >> at: key [ 
	^attributeTable at: key
]

{ #category : #accessing }
JunAttributeTable >> at: key ifAbsent: aBlock [ 
	^attributeTable at: key ifAbsent: aBlock
]

{ #category : #accessing }
JunAttributeTable >> at: key ifAbsentPut: valueBlock [ 
	^attributeTable at: key ifAbsentPut: valueBlock
]

{ #category : #accessing }
JunAttributeTable >> at: key ifPresent: aBlock [ 
	^attributeTable at: key ifPresent: aBlock
]

{ #category : #accessing }
JunAttributeTable >> at: key put: value [ 
	^attributeTable at: key put: value
]

{ #category : #accessing }
JunAttributeTable >> attributeTable [
	^attributeTable
]

{ #category : #'lisp support' }
JunAttributeTable >> attributeTableToLispList [
	| list |
	list := JunLispCons cell.
	list head: #attributeTable.
	self bindings do: 
			[:assoc | 
			| pair |
			pair := JunLispCons cell.
			pair head: assoc key.
			(assoc value respondsTo: #toLispList) 
				ifTrue: 
					[self errorSignal handle: [:exception | pair tail: assoc value]
						do: [pair tail: assoc value toLispList]]
				ifFalse: [pair tail: assoc value].
			list add: pair].
	^list
]

{ #category : #accessing }
JunAttributeTable >> bindings [
	| bindings |
	bindings := self associations.
	bindings := (self messageNotUnderstoodSignal handle: [:ex | bindings]
				do: [bindings asSortedCollection: [:a1 :a2 | a1 < a2]]) asArray.
	^bindings
]

{ #category : #enumerating }
JunAttributeTable >> bindingsDo: aBlock [ 
	attributeTable associationsDo: aBlock
]

{ #category : #copying }
JunAttributeTable >> copy [
	^(self class fromLispList: self toLispList) postCopy
]

{ #category : #testing }
JunAttributeTable >> includesKey: key [ 
	^attributeTable includesKey: key
]

{ #category : #'initialize-release' }
JunAttributeTable >> initialize: size [ 
	attributeTable := Dictionary new: (size max: 0)
]

{ #category : #testing }
JunAttributeTable >> isEmpty [
	^self size = 0
]

{ #category : #accessing }
JunAttributeTable >> keyAtValue: value [ 
	^attributeTable keyAtValue: value
]

{ #category : #accessing }
JunAttributeTable >> keyAtValue: value ifAbsent: exceptionBlock [ 
	^attributeTable keyAtValue: value ifAbsent: exceptionBlock
]

{ #category : #accessing }
JunAttributeTable >> keys [
	^attributeTable keys
]

{ #category : #enumerating }
JunAttributeTable >> keysAndValuesDo: aBlock [ 
	attributeTable keysAndValuesDo: aBlock
]

{ #category : #enumerating }
JunAttributeTable >> keysDo: aBlock [ 
	attributeTable keysDo: aBlock
]

{ #category : #accessing }
JunAttributeTable >> merge: anotherAttributes [ 
	| mergedAttributes |
	mergedAttributes := self copy.
	anotherAttributes associationsDo: 
			[:assoc | 
			(mergedAttributes includesKey: assoc key) 
				ifFalse: [mergedAttributes at: assoc key put: assoc value]].
	^mergedAttributes
]

{ #category : #printing }
JunAttributeTable >> printMax [
	^30
]

{ #category : #printing }
JunAttributeTable >> printOn: aStream [ 
	| block bindings size |
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	self isEmpty ifTrue: [^aStream nextPutAll: ')'].
	block := 
			[:assoc | 
			aStream space.
			aStream nextPutAll: '('.
			assoc printOn: aStream.
			aStream nextPutAll: ')'].
	aStream space.
	bindings := self bindings.
	aStream nextPutAll: '(bindings'.
	(size := bindings size) > self printMax 
		ifTrue: 
			[(self bindings copyFrom: 1 to: self printMax // 2) 
				do: [:assoc | block value: assoc].
			aStream
				space;
				nextPutAll: '...'.
			(self bindings copyFrom: size - (self printMax // 2) to: size) 
				do: [:assoc | block value: assoc]]
		ifFalse: [self bindings do: [:assoc | block value: assoc]].
	aStream nextPutAll: ')'.
	aStream nextPutAll: ')'
]

{ #category : #removing }
JunAttributeTable >> removeKey: key [ 
	^attributeTable removeKey: key ifAbsent: [^nil]
]

{ #category : #printing }
JunAttributeTable >> saveString [
	| list |
	list := JunLispCons cell.
	list head: self class name.
	list add: self attributeTableToLispList.
	^list saveString
]

{ #category : #accessing }
JunAttributeTable >> size [
	^attributeTable size
]

{ #category : #'lisp support' }
JunAttributeTable >> sizeToLispList [
	| list |
	list := JunLispCons cell.
	list head: #size.
	list tail: self size.
	^list
]

{ #category : #printing }
JunAttributeTable >> storeOn: aStream [ 
	aStream nextPutAll: '(('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' fromString: '.
	self saveString storeOn: aStream.
	aStream nextPutAll: ') yourself)'
]

{ #category : #'lisp support' }
JunAttributeTable >> toLispList [
	| list |
	list := JunLispCons cell.
	list head: self class name.
	list add: self sizeToLispList.
	list add: self attributeTableToLispList.
	^list
]

{ #category : #accessing }
JunAttributeTable >> values [
	^attributeTable values
]

{ #category : #enumerating }
JunAttributeTable >> valuesDo: aBlock [ 
	attributeTable do: aBlock
]

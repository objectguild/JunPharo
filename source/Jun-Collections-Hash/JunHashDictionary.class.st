"
Imported by VwImportClass
"
Class {
	#name : #JunHashDictionary,
	#superclass : #JunHashSet,
	#category : #'Jun-Collections-Hash'
}

{ #category : #copyright }
JunHashDictionary class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunHashDictionary class >> example1 [
	"JunHashDictionary example1."

	| aDictionary |
	aDictionary := JunHashDictionary new.
	aDictionary at: 'Asaoka' put: 'Aho'.
	aDictionary at: 'Hiroko' put: 'Baka'.
	aDictionary at: 'Asaoka' put: 'Kawaii'.
	aDictionary at: 'Hiroko' put: 'Kirei'.
	Transcript
		cr;
		show: aDictionary printString.
	^aDictionary
]

{ #category : #copyright }
JunHashDictionary class >> system [
	^'Jun'
]

{ #category : #copyright }
JunHashDictionary class >> version [
	^'799'
]

{ #category : #accessing }
JunHashDictionary >> associationAt: keyObject [ 
	^self associationAt: keyObject
		ifAbsent: 
			[(KeyNotFoundError 
				receiver: self
				selector: #associationAt:
				index: keyObject) raiseRequest]
]

{ #category : #accessing }
JunHashDictionary >> associationAt: keyObject ifAbsent: aBlock [ 
	| hashIndex |
	(hashIndex := self indexOf: keyObject -> self null) = 0 ifTrue: [^aBlock value].
	^hashArray at: hashIndex
]

{ #category : #accessing }
JunHashDictionary >> associations [
	^self asArray
]

{ #category : #enumerating }
JunHashDictionary >> associationsDo: aBlock [ 
	self do: [:assoc | aBlock value: assoc]
]

{ #category : #accessing }
JunHashDictionary >> at: keyObject [ 
	^self at: keyObject
		ifAbsent: 
			[(KeyNotFoundError 
				receiver: self
				selector: #at:
				index: keyObject) raiseRequest]
]

{ #category : #accessing }
JunHashDictionary >> at: keyObject ifAbsent: aBlock [ 
	^(self associationAt: keyObject ifAbsent: [nil]) ifNil: [aBlock value]
		ifNotNil: [:anAssociation | anAssociation value]
]

{ #category : #accessing }
JunHashDictionary >> at: keyObject ifAbsentPut: valueBlock [ 
	^self at: keyObject ifAbsent: [self at: keyObject put: valueBlock value]
]

{ #category : #accessing }
JunHashDictionary >> at: keyObject put: valueObject [ 
	| anAssociation |
	anAssociation := keyObject -> valueObject.
	self add: anAssociation.
	^valueObject
]

{ #category : #enumerating }
JunHashDictionary >> bindingsDo: aBlock [ 
	self associationsDo: aBlock
]

{ #category : #private }
JunHashDictionary >> compare: firstObject with: secondObject [ 
	(firstObject == self null or: [secondObject == self null]) ifTrue: [^false].
	^firstObject key = secondObject key
]

{ #category : #testing }
JunHashDictionary >> includesKey: keyObject [ 
	^super includes: keyObject -> self null
]

{ #category : #accessing }
JunHashDictionary >> keys [
	| collection index |
	collection := Array new: self size.
	index := 0.
	self keysDo: [:key | collection at: (index := index + 1) put: key].
	^collection
]

{ #category : #enumerating }
JunHashDictionary >> keysAndValuesDo: aBlock [ 
	self do: [:assoc | aBlock value: assoc key value: assoc value]
]

{ #category : #enumerating }
JunHashDictionary >> keysDo: aBlock [ 
	self do: [:assoc | aBlock value: assoc key]
]

{ #category : #removing }
JunHashDictionary >> removeKey: keyObject [ 
	^self removeKey: keyObject
		ifAbsent: 
			[(KeyNotFoundError 
				receiver: self
				selector: #removeKey:
				index: keyObject) raiseRequest]
]

{ #category : #removing }
JunHashDictionary >> removeKey: keyObject ifAbsent: aBlock [ 
	^super remove: keyObject -> self null ifAbsent: aBlock
]

{ #category : #accessing }
JunHashDictionary >> values [
	| collection index |
	collection := Array new: self size.
	index := 0.
	self valuesDo: [:value | collection at: (index := index + 1) put: value].
	^collection
]

{ #category : #enumerating }
JunHashDictionary >> valuesDo: aBlock [ 
	self do: [:assoc | aBlock value: assoc value]
]

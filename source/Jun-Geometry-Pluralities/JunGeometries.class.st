"
Imported by VwImportClass
"
Class {
	#name : #JunGeometries,
	#superclass : #JunGeometry,
	#instVars : [
		'geometries'
	],
	#category : #'Jun-Geometry-Pluralities'
}

{ #category : #copyright }
JunGeometries class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'lisp support' }
JunGeometries class >> fromTable: aTable for: anObjectOfGeometries [ 
	"JunGeometries fromLispList: (((0 , 0 , 1 triangle: 1 , 0 , 0 and: 0 , 1 , 0) asTriangles subdivideLevel: 4) toLispList)."

	self geometriesFromTable: aTable for: anObjectOfGeometries.
	^anObjectOfGeometries
]

{ #category : #'lisp support' }
JunGeometries class >> geometriesFromTable: aTable for: anObjectOfGeometries [ 
	| aList |
	aList := aTable at: #geometries ifAbsent: [^anObjectOfGeometries].
	anObjectOfGeometries 
		geometries: (aList collect: [:each | self fromLispList: each]) asArray.
	^anObjectOfGeometries
]

{ #category : #'instance creation' }
JunGeometries class >> new: sizeInteger [ 
	^(self new)
		initialize: sizeInteger;
		yourself
]

{ #category : #copyright }
JunGeometries class >> system [
	^'Jun'
]

{ #category : #copyright }
JunGeometries class >> version [
	^'799'
]

{ #category : #copying }
JunGeometries >> , geometryCollection [ 
	^(self copy)
		addAll: geometryCollection;
		yourself
]

{ #category : #comparing }
JunGeometries >> = another [ 
	| size |
	self class == another class ifFalse: [^false].
	(size := self geometries size) = another geometries size ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			(self geometries at: index) = (another geometries at: index) 
				ifFalse: [^false]].
	^true
]

{ #category : #adding }
JunGeometries >> add: aGeometry [ 
	self geometries add: aGeometry
]

{ #category : #adding }
JunGeometries >> addAll: aCollection [ 
	aCollection do: [:each | self add: each].
	^aCollection
]

{ #category : #converting }
JunGeometries >> asArray [
	^self geometries asArray
]

{ #category : #converting }
JunGeometries >> asBoundingBall [
	^self boundingBall
]

{ #category : #converting }
JunGeometries >> asBoundingBalls [
	| boundingBalls |
	boundingBalls := self boundingBallsClass new.
	boundingBalls boundingBalls: (self collect: [:each | each boundingBall]).
	^boundingBalls
]

{ #category : #converting }
JunGeometries >> asBoundingBox [
	^self boundingBox
]

{ #category : #converting }
JunGeometries >> asBoundingBoxes [
	| boundingBoxes |
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes boundingBoxes: (self collect: [:each | each boundingBox]).
	^boundingBoxes
]

{ #category : #converting }
JunGeometries >> asJunOpenGL3dObject [
	| compoundObject |
	compoundObject := JunOpenGL3dCompoundObject new: self size.
	self do: [:each | compoundObject add: each asJunOpenGL3dObject].
	^compoundObject
]

{ #category : #converting }
JunGeometries >> asOrderedCollection [
	^self geometries asOrderedCollection
]

{ #category : #accessing }
JunGeometries >> at: index [ 
	^self geometries at: index
]

{ #category : #accessing }
JunGeometries >> at: index put: geometry [ 
	^self geometries at: index put: geometry
]

{ #category : #accessing }
JunGeometries >> boundingBall [
	| boundingBall |
	self isEmpty ifTrue: [^self boundingBallClass new].
	boundingBall := nil.
	self do: 
			[:each | 
			boundingBall isNil 
				ifTrue: [boundingBall := each boundingBall]
				ifFalse: [boundingBall := each boundingBall merge: boundingBall]].
	^boundingBall
]

{ #category : #accessing }
JunGeometries >> boundingBox [
	| boundingBox |
	self isEmpty ifTrue: [^self boundingBoxClass new].
	boundingBox := nil.
	self do: 
			[:each | 
			boundingBox isNil 
				ifTrue: [boundingBox := each boundingBox]
				ifFalse: [boundingBox := each boundingBox merge: boundingBox]].
	^boundingBox
]

{ #category : #enumerating }
JunGeometries >> collect: aBlock [ 
	| copy |
	copy := self class new.
	self do: [:each | copy add: (aBlock value: each)].
	^copy
]

{ #category : #copying }
JunGeometries >> copyWith: another [ 
	| copy |
	copy := self class new: self size + 1.
	copy addAll: (self geometries copyWith: another).
	^copy
]

{ #category : #copying }
JunGeometries >> copyWithout: another [ 
	| copy |
	copy := self class new: self size - 1.
	copy addAll: (self geometries copyWithout: another).
	^copy
]

{ #category : #enumerating }
JunGeometries >> detect: aBlock [ 
	^self detect: aBlock ifNone: [nil]
]

{ #category : #enumerating }
JunGeometries >> detect: aBlock ifNone: exceptionBlock [ 
	self do: [:each | (aBlock value: each) ifTrue: [^each]].
	^exceptionBlock value
]

{ #category : #enumerating }
JunGeometries >> do: aBlock [ 
	self geometries do: [:each | aBlock value: each]
]

{ #category : #comparing }
JunGeometries >> equal: another [ 
	| size |
	self class == another class ifFalse: [^false].
	(size := self geometries size) = another geometries size ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self geometries at: index) equal: (another geometries at: index)) 
				ifFalse: [^false]].
	^true
]

{ #category : #enumerating }
JunGeometries >> findFirst: aBlock [ 
	^self geometries findFirst: aBlock
]

{ #category : #enumerating }
JunGeometries >> findLast: aBlock [ 
	^self geometries findLast: aBlock
]

{ #category : #accessing }
JunGeometries >> geometries [
	^geometries
]

{ #category : #accessing }
JunGeometries >> geometries: geometryCollection [ 
	geometries := geometryCollection asOrderedCollection
]

{ #category : #'lisp support' }
JunGeometries >> geometriesToLispList [
	| list |
	list := self lispCons.
	list head: #geometries.
	list tail: (self class defaultLispConsClass 
				list: (self geometries collect: [:each | each toLispList])).
	^list
]

{ #category : #'initialize-release' }
JunGeometries >> initialize [
	super initialize.
	geometries := OrderedCollection new
]

{ #category : #'initialize-release' }
JunGeometries >> initialize: sizeInteger [ 
	geometries := OrderedCollection new: (sizeInteger asInteger max: 0)
]

{ #category : #testing }
JunGeometries >> isEmpty [
	^self geometries isEmpty
]

{ #category : #copying }
JunGeometries >> postCopy [
	geometries := geometries copy
]

{ #category : #printing }
JunGeometries >> printOn: aStream [ 
	aStream nextPutAll: '(('.
	aStream nextPutAll: self class printString.
	aStream nextPutAll: ' new)'.
	aStream cr.
	aStream tab.
	aStream nextPutAll: 'addAll: (('.
	aStream nextPutAll: self geometries class printString.
	aStream nextPutAll: ' new: '.
	aStream nextPutAll: self geometries size printString.
	aStream nextPutAll: ')'.
	self do: 
			[:each | 
			aStream cr.
			aStream tab.
			aStream tab.
			aStream nextPutAll: 'add: ['.
			each printOn: aStream.
			aStream nextPutAll: ' yourself] value;'].
	aStream nextPutAll: ' yourself); yourself)'
]

{ #category : #enumerating }
JunGeometries >> reject: aBlock [ 
	^self select: [:each | (aBlock value: each) == false]
]

{ #category : #enumerating }
JunGeometries >> select: aBlock [ 
	| copy |
	copy := self class new.
	self do: [:each | (aBlock value: each) ifTrue: [copy add: each]].
	^copy
]

{ #category : #accessing }
JunGeometries >> size [
	^self geometries size
]

{ #category : #printing }
JunGeometries >> storeOn: aStream [ 
	aStream nextPutAll: '(('.
	aStream nextPutAll: self class printString.
	aStream nextPutAll: ' new)'.
	aStream cr.
	aStream tab.
	aStream nextPutAll: 'addAll: (('.
	aStream nextPutAll: self geometries class printString.
	aStream nextPutAll: ' new: '.
	aStream nextPutAll: self geometries size printString.
	aStream nextPutAll: ')'.
	self do: 
			[:each | 
			aStream cr.
			aStream tab.
			aStream tab.
			aStream nextPutAll: 'add: ['.
			each storeOn: aStream.
			aStream nextPutAll: ' yourself] value;'].
	aStream nextPutAll: ' yourself); yourself)'
]

{ #category : #subdividing }
JunGeometries >> subdivide [
	| copy |
	copy := self class new.
	self do: [:each | copy addAll: each subdivide geometries].
	^copy
]

{ #category : #subdividing }
JunGeometries >> subdivideLevel: levelNumber [ 
	| copy |
	copy := self class new.
	self 
		do: [:each | copy addAll: (each subdivideLevel: levelNumber) geometries].
	^copy
]

{ #category : #'lisp support' }
JunGeometries >> toLispList [
	"self showLispList: (((0 , 0 , 1 triangle: 1 , 0 , 0 and: 0 , 1 , 0) asTriangles subdivideLevel: 4) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self geometriesToLispList.
	^list
]

{ #category : #transforming }
JunGeometries >> transform: aTransformation [ 
	| transformedCopy |
	transformedCopy := self class new.
	transformedCopy 
		addAll: (self collect: [:each | each transform: aTransformation]).
	^transformedCopy
]

{ #category : #enumerating }
JunGeometries >> with: aCollection do: aBlock [ 
	self geometries with: aCollection
		do: [:each :object | aBlock value: each value: object]
]

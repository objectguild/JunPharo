"
Imported by VwImportClass
"
Class {
	#name : #JunBoundingObjects,
	#superclass : #JunGeometries,
	#category : #'Jun-Geometry-Pluralities'
}

{ #category : #copyright }
JunBoundingObjects class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunBoundingObjects class >> new: sizeInteger [ 
	^(self new)
		initialize: sizeInteger;
		yourself
]

{ #category : #copyright }
JunBoundingObjects class >> system [
	^'Jun'
]

{ #category : #copyright }
JunBoundingObjects class >> version [
	^'799'
]

{ #category : #accessing }
JunBoundingObjects >> boundingObjects [
	^geometries
]

{ #category : #accessing }
JunBoundingObjects >> boundingObjects: boundingObjectCollection [ 
	geometries := boundingObjectCollection asOrderedCollection
]

{ #category : #testing }
JunBoundingObjects >> containsOrTouchesPoint: aPoint [ 
	^self containsPoint: aPoint
]

{ #category : #testing }
JunBoundingObjects >> containsPoint: aPoint [ 
	^(self detect: [:each | each containsPoint: aPoint] ifNone: [nil]) notNil
]

{ #category : #testing }
JunBoundingObjects >> containsPoints: pointCollection [ 
	| aSet |
	aSet := pointCollection asSet.
	aSet do: [:aPoint | (self containsPoint: aPoint) ifFalse: [^false]].
	^true
]

{ #category : #accessing }
JunBoundingObjects >> detailedBoundingBalls [
	self is3d ifTrue: [^self octaBoundingBalls].
	self is2d ifTrue: [^self tetraBoundingBalls].
	^self boundingBallsClass new
]

{ #category : #accessing }
JunBoundingObjects >> detailedBoundingBoxes [
	self is3d ifTrue: [^self octaBoundingBoxes].
	self is2d ifTrue: [^self tetraBoundingBoxes].
	^self boundingBoxesClass new
]

{ #category : #testing }
JunBoundingObjects >> intersects: aBoundingObject [ 
	^(self detect: [:each | each intersects: aBoundingObject] ifNone: [nil]) 
		notNil
]

{ #category : #testing }
JunBoundingObjects >> intersectsOrTouches: aBoundingObject [ 
	^(self intersects: aBoundingObject) or: [self touches: aBoundingObject]
]

{ #category : #testing }
JunBoundingObjects >> isBoundingObjects [
	^true
]

{ #category : #testing }
JunBoundingObjects >> isEmpty [
	^self size < 1 or: 
			[(self detect: [:boundingBox | boundingBox isEmpty not] ifNone: [nil]) 
				isNil]
]

{ #category : #accessing }
JunBoundingObjects >> octaBoundingBalls [
	^self shouldNotImplement
]

{ #category : #accessing }
JunBoundingObjects >> octaBoundingBoxes [
	^self shouldNotImplement
]

{ #category : #accessing }
JunBoundingObjects >> size [
	^self boundingObjects size
]

{ #category : #accessing }
JunBoundingObjects >> tetraBoundingBalls [
	^self shouldNotImplement
]

{ #category : #accessing }
JunBoundingObjects >> tetraBoundingBoxes [
	^self shouldNotImplement
]

{ #category : #testing }
JunBoundingObjects >> touches: aBoundingObject [ 
	^(self detect: [:each | each touches: aBoundingObject] ifNone: [nil]) 
		notNil
]

{ #category : #testing }
JunBoundingObjects >> touchesPoint: aPoint [ 
	^(self detect: [:each | each touchesPoint: aPoint] ifNone: [nil]) notNil
]

{ #category : #testing }
JunBoundingObjects >> whichSideOf: bisector [ 
	| anArray hasPlus hasMinus hasZero |
	anArray := self boundingObjects 
				collect: [:boundingObject | boundingObject whichSideOf: bisector].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

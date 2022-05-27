"
Imported by VwImportClass
"
Class {
	#name : #JunBoundingObject,
	#superclass : #JunGeometry,
	#category : #'Jun-Geometry-Boundaries'
}

{ #category : #copyright }
JunBoundingObject class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunBoundingObject class >> fromObject: anObject [ 
	^self subclassResponsibility
]

{ #category : #'instance creation' }
JunBoundingObject class >> fromPoints: pointCollection [ 
	^self subclassResponsibility
]

{ #category : #copyright }
JunBoundingObject class >> system [
	^'Jun'
]

{ #category : #copyright }
JunBoundingObject class >> version [
	^'799'
]

{ #category : #converting }
JunBoundingObject >> asBoundingBall [
	^self boundingBall
]

{ #category : #converting }
JunBoundingObject >> asBoundingBox [
	^self boundingBox
]

{ #category : #accessing }
JunBoundingObject >> boundingBall [
	^self subclassResponsibility
]

{ #category : #accessing }
JunBoundingObject >> boundingBox [
	^self subclassResponsibility
]

{ #category : #testing }
JunBoundingObject >> containsOrTouchesPoint: aPoint [ 
	^self containsPoint: aPoint
]

{ #category : #testing }
JunBoundingObject >> containsPoint: aPoint [ 
	^self subclassResponsibility
]

{ #category : #testing }
JunBoundingObject >> containsPoints: pointCollection [ 
	| aSet |
	aSet := pointCollection asSet.
	aSet do: [:aPoint | (self containsPoint: aPoint) ifFalse: [^false]].
	^true
]

{ #category : #accessing }
JunBoundingObject >> detailedBoundingBalls [
	self is3d ifTrue: [^self octaBoundingBalls].
	self is2d ifTrue: [^self tetraBoundingBalls].
	^self boundingBallsClass new
]

{ #category : #accessing }
JunBoundingObject >> detailedBoundingBoxes [
	self is3d ifTrue: [^self octaBoundingBoxes].
	self is2d ifTrue: [^self tetraBoundingBoxes].
	^self boundingBoxesClass new
]

{ #category : #accessing }
JunBoundingObject >> innerBoundingBall [
	^self subclassResponsibility
]

{ #category : #accessing }
JunBoundingObject >> innerBoundingBox [
	^self subclassResponsibility
]

{ #category : #testing }
JunBoundingObject >> intersects: aBoundingObject [ 
	^self subclassResponsibility
]

{ #category : #testing }
JunBoundingObject >> intersectsOrTouches: aBoundingObject [ 
	^(self intersects: aBoundingObject) or: [self touches: aBoundingObject]
]

{ #category : #testing }
JunBoundingObject >> isBoundingObject [
	^true
]

{ #category : #testing }
JunBoundingObject >> isEmpty [
	self is3d ifTrue: [^self volume < self class accuracy].
	self is2d ifTrue: [^self area < self class accuracy].
	^false
]

{ #category : #testing }
JunBoundingObject >> isolates: aBoundingObject [ 
	^self subclassResponsibility
]

{ #category : #testing }
JunBoundingObject >> isolatesOrTouches: aBoundingObject [ 
	^(self isolates: aBoundingObject) or: [self touches: aBoundingObject]
]

{ #category : #testing }
JunBoundingObject >> isolatesOrTouchesPoint: aPoint [ 
	^(self isolatesPoint: aPoint) or: [self touchesPoint: aPoint]
]

{ #category : #testing }
JunBoundingObject >> isolatesPoint: aPoint [ 
	^(self containsPoint: aPoint) not
]

{ #category : #testing }
JunBoundingObject >> isolatesPoints: pointCollection [ 
	| aSet |
	aSet := pointCollection asSet.
	aSet do: [:aPoint | (self isolatesPoint: aPoint) ifFalse: [^false]].
	^true
]

{ #category : #accessing }
JunBoundingObject >> octaBoundingBalls [
	^self subclassResponsibility
]

{ #category : #accessing }
JunBoundingObject >> octaBoundingBoxes [
	^self subclassResponsibility
]

{ #category : #accessing }
JunBoundingObject >> outerBoundingBall [
	^self boundingBall
]

{ #category : #accessing }
JunBoundingObject >> outerBoundingBox [
	^self boundingBox
]

{ #category : #accessing }
JunBoundingObject >> tetraBoundingBalls [
	^self subclassResponsibility
]

{ #category : #accessing }
JunBoundingObject >> tetraBoundingBoxes [
	^self subclassResponsibility
]

{ #category : #testing }
JunBoundingObject >> touches: aBoundingObject [ 
	^self subclassResponsibility
]

{ #category : #testing }
JunBoundingObject >> touchesPoint: aPoint [ 
	^self subclassResponsibility
]

{ #category : #testing }
JunBoundingObject >> touchesPoints: pointCollection [ 
	| aSet |
	(self containsPoint: pointCollection) ifFalse: [^false].
	(self isolatesPoint: pointCollection) ifTrue: [^false].
	aSet := pointCollection asSet.
	aSet do: [:aPoint | (self touchesPoint: aPoint) ifTrue: [^true]].
	^false
]

{ #category : #testing }
JunBoundingObject >> whichSideOf: bisector [ 
	^self subclassResponsibility
]

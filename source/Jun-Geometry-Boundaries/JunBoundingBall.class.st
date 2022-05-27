"
Imported by VwImportClass
"
Class {
	#name : #JunBoundingBall,
	#superclass : #JunBoundingObject,
	#instVars : [
		'center',
		'radius'
	],
	#category : #'Jun-Geometry-Boundaries'
}

{ #category : #'instance creation' }
JunBoundingBall class >> center: centerPoint radius: radiusValue [ 
	| ball |
	ball := self new.
	ball center: centerPoint.
	ball radius: radiusValue.
	^ball
]

{ #category : #'lisp support' }
JunBoundingBall class >> centerFromTable: aTable for: aBall [ 
	| aList |
	aList := aTable at: #center ifAbsent: [^aBall].
	aBall center: (self pointClass fromLispList: aList).
	^aBall
]

{ #category : #copyright }
JunBoundingBall class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunBoundingBall class >> fromObject: anObject [ 
	"Jun3dBoundingBall fromObject: (JunOpenGL3dObject benzene)."

	"(JunOpenGL3dCompoundObject
		with: ((Jun2dBoundingBall fromObject: (JunOpenGL3dObject benzene asPointArray collect: [:p | p x , p y]))
				asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5)
		with: JunOpenGL3dObject benzene) show."

	"(JunOpenGL3dCompoundObject
		with: ((Jun3dBoundingBall fromObject: JunOpenGL3dObject benzene)
				asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5)
		with: JunOpenGL3dObject benzene) show."

	| aCollection |
	aCollection := (anObject isKindOf: Collection) 
				ifTrue: 
					[(Array with: (self boundingBoxClass fromObject: anObject) center) 
						, anObject asArray]
				ifFalse: [(Array with: anObject boundingBox center) , anObject asPointArray].
	^self fromPoints: aCollection
]

{ #category : #'instance creation' }
JunBoundingBall class >> fromPoints: pointCollection [ 
	| centerPoint maxDistance aDistance |
	pointCollection isEmpty ifTrue: [^self new].
	centerPoint := (self boundingBoxClass fromPoints: pointCollection) center.
	maxDistance := 0.
	pointCollection do: 
			[:aPoint | 
			aDistance := centerPoint distance: aPoint.
			aDistance > maxDistance ifTrue: [maxDistance := aDistance]].
	^self center: centerPoint radius: maxDistance
]

{ #category : #'lisp support' }
JunBoundingBall class >> fromTable: aTable for: aBall [ 
	"Jun2dBoundingBox fromLispList: (((0 , 0) ball: 1) toLispList)."
	"Jun3dBoundingBox fromLispList: (((0 , 0 , 0) ball: 1) toLispList)."

	self centerFromTable: aTable for: aBall.
	self radiusFromTable: aTable for: aBall.
	^aBall
]

{ #category : #'lisp support' }
JunBoundingBall class >> radiusFromTable: aTable for: aBall [ 
	| aValue |
	aValue := aTable at: #radius ifAbsent: [^aBall].
	aBall radius: aValue.
	^aBall
]

{ #category : #copyright }
JunBoundingBall class >> system [
	^'Jun'
]

{ #category : #copyright }
JunBoundingBall class >> version [
	^'799'
]

{ #category : #comparing }
JunBoundingBall >> = aBoundingBall [ 
	self class == aBoundingBall class ifFalse: [^false].
	^self center = aBoundingBall center 
		and: [self radius = aBoundingBall radius]
]

{ #category : #adding }
JunBoundingBall >> add: aPoint [ 
	| ball |
	(self center distance: aPoint) > self radius 
		ifTrue: 
			[ball := self merge: (self class center: aPoint radius: 0).
			self center: ball center radius: ball radius]
]

{ #category : #accessing }
JunBoundingBall >> boundingBall [
	^self
]

{ #category : #accessing }
JunBoundingBall >> boundingBox [
	^(self boundingBoxClass origin: self center extent: self pointClass zero) 
		expandedBy: self radius
]

{ #category : #accessing }
JunBoundingBall >> center [
	^center
]

{ #category : #accessing }
JunBoundingBall >> center: aPoint [ 
	center := self pointClass coerce: aPoint
]

{ #category : #accessing }
JunBoundingBall >> center: aPoint radius: aRadius [ 
	self center: aPoint.
	self radius: aRadius
]

{ #category : #'lisp support' }
JunBoundingBall >> centerToLispList [
	| list |
	list := self lispCons.
	list head: #center.
	list tail: self center toLispList.
	^list
]

{ #category : #accessing }
JunBoundingBall >> circumference [
	^self peripheryOfCircle
]

{ #category : #testing }
JunBoundingBall >> contains: aBoundingBall [ 
	| delta |
	^(delta := self center distance: aBoundingBall center) <= self radius 
		and: [delta + aBoundingBall radius <= self radius]
]

{ #category : #testing }
JunBoundingBall >> containsPoint: aPoint [ 
	^(self center distance: aPoint) <= self radius 
		or: [self touchesPoint: aPoint]
]

{ #category : #accessing }
JunBoundingBall >> depth [
	^self subclassResponsibility
]

{ #category : #comparing }
JunBoundingBall >> equal: aBoundingBall [ 
	self class == aBoundingBall class ifFalse: [^false].
	^(self center equal: aBoundingBall center) 
		and: [(self radius - aBoundingBall radius) abs < self accuracy]
]

{ #category : #functions }
JunBoundingBall >> expandedBy: aNumber [ 
	^self class center: self center radius: self radius + aNumber asDouble
]

{ #category : #accessing }
JunBoundingBall >> extent [
	^self boundingBox extent
]

{ #category : #comparing }
JunBoundingBall >> hash [
	^self center hash bitXor: self radius hash
]

{ #category : #accessing }
JunBoundingBall >> height [
	^self boundingBox height
]

{ #category : #'initialize-release' }
JunBoundingBall >> initialize [
	center := self pointClass zero.
	radius := 0 asDouble
]

{ #category : #accessing }
JunBoundingBall >> innerBoundingBall [
	^self
]

{ #category : #functions }
JunBoundingBall >> insetBy: aNumber [ 
	^self class center: self center radius: self radius - aNumber asDouble
]

{ #category : #functions }
JunBoundingBall >> intersect: aBoundingBall [ 
	| distance aLine fromPoint toPoint |
	distance := self center distance: aBoundingBall center.
	distance + aBoundingBall radius < self radius 
		ifTrue: [^aBoundingBall copy].
	distance + self radius < aBoundingBall radius ifTrue: [^self copy].
	aLine := self lineClass from: self center to: aBoundingBall center.
	fromPoint := aLine atT: 1 - (aBoundingBall radius / distance).
	toPoint := aLine atT: 0 + (self radius / distance).
	^self class center: (fromPoint center: toPoint)
		radius: (fromPoint distance: toPoint) / 2
]

{ #category : #testing }
JunBoundingBall >> intersects: aBoundingBall [ 
	^(self center distance: aBoundingBall center) 
		<= (self radius + aBoundingBall radius)
]

{ #category : #testing }
JunBoundingBall >> isBoundingBall [
	^true
]

{ #category : #testing }
JunBoundingBall >> isolates: aBoundingBall [ 
	^self radius + aBoundingBall radius 
		> (self center distance: aBoundingBall center)
]

{ #category : #functions }
JunBoundingBall >> merge: aBoundingBall [ 
	| distance aLine fromPoint toPoint |
	distance := self center distance: aBoundingBall center.
	distance + aBoundingBall radius < self radius ifTrue: [^self copy].
	distance + self radius < aBoundingBall radius 
		ifTrue: [^aBoundingBall copy].
	aLine := self lineClass from: self center to: aBoundingBall center.
	fromPoint := aLine atT: 0 - (self radius / distance).
	toPoint := aLine atT: 1 + (aBoundingBall radius / distance).
	^self class center: (fromPoint center: toPoint)
		radius: (fromPoint distance: toPoint) / 2
]

{ #category : #accessing }
JunBoundingBall >> perimeter [
	^self peripheryOfCircle
]

{ #category : #accessing }
JunBoundingBall >> periphery [
	^self peripheryOfCircle
]

{ #category : #accessing }
JunBoundingBall >> peripheryOfCircle [
	^2 * Double pi * self radius
]

{ #category : #copying }
JunBoundingBall >> postCopy [
	super postCopy.
	center := center copy.
	radius := radius copy
]

{ #category : #accessing }
JunBoundingBall >> radius [
	^radius
]

{ #category : #accessing }
JunBoundingBall >> radius: aNumber [ 
	radius := aNumber asDouble abs
]

{ #category : #'lisp support' }
JunBoundingBall >> radiusToLispList [
	| list |
	list := self lispCons.
	list head: #radius.
	list tail: self radius.
	^list
]

{ #category : #'truncation and round off' }
JunBoundingBall >> rounded [
	^self class center: self center rounded radius: self radius rounded
]

{ #category : #printing }
JunBoundingBall >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self center printString.
	aStream nextPutAll: ' ball: '.
	aStream nextPutAll: self radius printString.
	aStream nextPutAll: ')'
]

{ #category : #'lisp support' }
JunBoundingBall >> toLispList [
	"self showLispList: (((0 , 0) ball: 1) toLispList)."
	"self showLispList: (((0 , 0 , 0) ball: 1) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self centerToLispList.
	list add: self radiusToLispList.
	^list
]

{ #category : #testing }
JunBoundingBall >> touches: aBoundingBall [ 
	| distance |
	((self isEqualPoint: self center to: aBoundingBall center) 
		and: [self isEqualNumber: self radius to: aBoundingBall radius]) 
			ifTrue: [^true].
	distance := self center distance: aBoundingBall center.
	distance <= self radius 
		ifTrue: [^self isEqualNumber: self radius to: distance + aBoundingBall radius].
	distance <= aBoundingBall radius 
		ifTrue: [^self isEqualNumber: aBoundingBall radius to: distance + self radius].
	^self isEqualNumber: distance to: self radius + aBoundingBall radius
]

{ #category : #testing }
JunBoundingBall >> touchesPoint: aPoint [ 
	| distance |
	distance := self center distance: aPoint.
	^self isEqualNumber: distance to: self radius
]

{ #category : #transforming }
JunBoundingBall >> transform: aTransformation [ 
	| aLine |
	aLine := self lineClass from: self center
				to: self center + (self radius , 0 , 0).
	aLine := aLine transform: aTransformation.
	^self class center: aLine from radius: (aLine from distance: aLine to)
]

{ #category : #'truncation and round off' }
JunBoundingBall >> truncated [
	^self class center: self center truncated radius: self radius truncated
]

{ #category : #testing }
JunBoundingBall >> whichSideOf: bisector [ 
	| sign |
	sign := self center whichSideOf: bisector.
	sign = 0 ifTrue: [^0].
	(bisector distanceFromPoint: self center) <= self radius ifTrue: [^0].
	^sign
]

{ #category : #accessing }
JunBoundingBall >> width [
	^self boundingBox width
]

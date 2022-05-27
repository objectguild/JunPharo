"
Imported by VwImportClass
"
Class {
	#name : #JunBoundingBox,
	#superclass : #JunBoundingObject,
	#instVars : [
		'origin',
		'corner'
	],
	#category : #'Jun-Geometry-Boundaries'
}

{ #category : #copyright }
JunBoundingBox class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunBoundingBox class >> fromObject: anObject [ 
	"Jun3dBoundingBox fromObject: (JunOpenGL3dObject benzene)."

	"(JunOpenGL3dCompoundObject
		with: ((Jun2dBoundingBox fromObject: (JunOpenGL3dObject benzene asPointArray collect: [:p | p x , p y]))
				asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5)
		with: JunOpenGL3dObject benzene) show."

	"(JunOpenGL3dCompoundObject
		with: ((Jun3dBoundingBox fromObject: JunOpenGL3dObject benzene)
					asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5)
		with: JunOpenGL3dObject benzene) show."

	| aCollection |
	aCollection := (anObject isKindOf: Collection) 
				ifTrue: [anObject asArray]
				ifFalse: [anObject asPointArray].
	^self fromPoints: aCollection
]

{ #category : #'instance creation' }
JunBoundingBox class >> fromPoints: pointCollection [ 
	| boundingBox |
	pointCollection isEmpty ifTrue: [^self new].
	boundingBox := self origin: pointCollection first
				corner: pointCollection first.
	2 to: pointCollection size
		do: [:index | boundingBox := boundingBox add: (pointCollection at: index)].
	^boundingBox
]

{ #category : #'lisp support' }
JunBoundingBox class >> fromTable: aTable for: aBox [ 
	"Jun2dBoundingBox fromLispList: (((0 , 0) box: (1 , 1)) toLispList)."
	"Jun3dBoundingBox fromLispList: (((0 , 0 , 0) box: (1 , 1 , 1)) toLispList)."

	self pointsFromTable: aTable for: aBox.
	^aBox
]

{ #category : #'instance creation' }
JunBoundingBox class >> origin: originPoint corner: cornerPoint [ 
	^(self new)
		origin: originPoint corner: cornerPoint;
		yourself
]

{ #category : #'instance creation' }
JunBoundingBox class >> origin: originPoint extent: extentPoint [ 
	^(self new)
		origin: originPoint extent: extentPoint;
		yourself
]

{ #category : #'lisp support' }
JunBoundingBox class >> pointsFromTable: aTable for: aBox [ 
	| fromList toList |
	fromList := aTable at: #origin ifAbsent: [^aBox].
	toList := aTable at: #corner ifAbsent: [^aBox].
	aBox origin: (self pointClass fromLispList: fromList)
		corner: (self pointClass fromLispList: toList).
	^aBox
]

{ #category : #copyright }
JunBoundingBox class >> system [
	^'Jun'
]

{ #category : #'constants access' }
JunBoundingBox class >> unity [
	"Jun3dBoundingBox unity."

	"Jun2dBoundingBox unity."

	| pointClass |
	pointClass := self pointClass.
	^self origin: pointClass zero corner: pointClass unity
]

{ #category : #copyright }
JunBoundingBox class >> version [
	^'799'
]

{ #category : #'instance creation' }
JunBoundingBox class >> vertex: vertexPoint1 vertex: vertexPoint2 [ 
	^(self new)
		vertex: vertexPoint1 vertex: vertexPoint2;
		yourself
]

{ #category : #'constants access' }
JunBoundingBox class >> zero [
	"Jun3dBoundingBox zero."

	"Jun2dBoundingBox zero."

	| pointClass |
	pointClass := self pointClass.
	^self origin: pointClass zero corner: pointClass zero
]

{ #category : #comparing }
JunBoundingBox >> = aBoundingBox [ 
	self class == aBoundingBox class ifFalse: [^false].
	^self origin = aBoundingBox origin 
		and: [self corner = aBoundingBox corner]
]

{ #category : #adding }
JunBoundingBox >> add: aPoint [ 
	| box |
	(self containsPoint: aPoint) 
		ifFalse: 
			[box := self merge: (self class origin: aPoint corner: aPoint).
			self origin: box origin corner: box corner]
]

{ #category : #functions }
JunBoundingBox >> align: aPoint1 with: aPoint2 [ 
	^self translatedBy: aPoint2 - aPoint1
]

{ #category : #functions }
JunBoundingBox >> areasOutside: boundingBox [ 
	^self boxesOutside: boundingBox
]

{ #category : #converting }
JunBoundingBox >> asBoundingBox [
	^self
]

{ #category : #converting }
JunBoundingBox >> asBoundingBoxes [
	| boundingBoxes |
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes boundingBoxes: (Array with: self).
	^boundingBoxes
]

{ #category : #converting }
JunBoundingBox >> asPointArray [
	^self subclassResponsibility
]

{ #category : #converting }
JunBoundingBox >> asRectangle [
	^self origin x @ self origin y corner: self corner x @ self corner y
]

{ #category : #converting }
JunBoundingBox >> asRectangles [
	^self asBoundingBoxes asRectangles
]

{ #category : #accessing }
JunBoundingBox >> boundingBall [
	| centerPoint |
	centerPoint := self center.
	^self boundingBallClass center: centerPoint
		radius: (self origin distance: centerPoint)
]

{ #category : #accessing }
JunBoundingBox >> boundingBox [
	^self
]

{ #category : #functions }
JunBoundingBox >> boxesOutside: boundingBox [ 
	^self subclassResponsibility
]

{ #category : #accessing }
JunBoundingBox >> center [
	^self origin center: self corner
]

{ #category : #functions }
JunBoundingBox >> containedPointFor: aPoint [ 
	^aPoint min: self origin max: self corner
]

{ #category : #testing }
JunBoundingBox >> contains: aBoundingBox [ 
	^aBoundingBox origin >= self origin 
		and: [aBoundingBox corner <= self corner]
]

{ #category : #testing }
JunBoundingBox >> containsPoint: aPoint [ 
	^(self origin <= aPoint and: [aPoint <= self corner]) 
		or: [self touchesPoint: aPoint]
]

{ #category : #accessing }
JunBoundingBox >> corner [
	^corner
]

{ #category : #accessing }
JunBoundingBox >> corner: cornerPoint [ 
	self origin: self origin corner: cornerPoint
]

{ #category : #'lisp support' }
JunBoundingBox >> cornerToLispList [
	| list |
	list := self lispCons.
	list head: #corner.
	list tail: self corner toLispList.
	^list
]

{ #category : #accessing }
JunBoundingBox >> depth [
	^self subclassResponsibility
]

{ #category : #comparing }
JunBoundingBox >> equal: aBoundingBox [ 
	self class == aBoundingBox class ifFalse: [^false].
	^(self origin equal: aBoundingBox origin) 
		and: [self corner equal: aBoundingBox corner]
]

{ #category : #functions }
JunBoundingBox >> expandedBy: delta [ 
	(delta isKindOf: self class) 
		ifTrue: 
			[^self class origin: self origin - delta origin
				corner: self corner + delta corner].
	^self class origin: self origin - delta corner: self corner + delta
]

{ #category : #accessing }
JunBoundingBox >> extent [
	^self corner - self origin
]

{ #category : #comparing }
JunBoundingBox >> hash [
	^self origin hash bitXor: self corner hash
]

{ #category : #accessing }
JunBoundingBox >> height [
	^self corner y - self origin y
]

{ #category : #'initialize-release' }
JunBoundingBox >> initialize [
	origin := self pointClass zero.
	corner := self pointClass zero
]

{ #category : #accessing }
JunBoundingBox >> innerBoundingBox [
	^self
]

{ #category : #functions }
JunBoundingBox >> insetBy: delta [ 
	(delta isKindOf: self class) 
		ifTrue: 
			[^self class origin: self origin + delta origin
				corner: self corner - delta corner].
	^self class origin: self origin + delta corner: self corner - delta
]

{ #category : #functions }
JunBoundingBox >> intersect: boundingBox [ 
	^self class origin: (self origin max: boundingBox origin)
		corner: (self corner min: boundingBox corner)
]

{ #category : #testing }
JunBoundingBox >> intersects: aBoundingBox [ 
	^self origin < aBoundingBox corner and: 
			[aBoundingBox origin < self corner and: 
					[self origin < self corner and: [aBoundingBox origin < aBoundingBox corner]]]
]

{ #category : #testing }
JunBoundingBox >> isBoundingBox [
	^true
]

{ #category : #testing }
JunBoundingBox >> isolates: aBoundingBox [ 
	^(self origin > aBoundingBox corner 
		or: [aBoundingBox origin > self corner]) and: 
				[self origin < self corner and: [aBoundingBox origin < aBoundingBox corner]]
]

{ #category : #accessing }
JunBoundingBox >> maxLength [
	^self subclassResponsibility
]

{ #category : #functions }
JunBoundingBox >> merge: boundingBox [ 
	^self class origin: (self origin min: boundingBox origin)
		corner: (self corner max: boundingBox corner)
]

{ #category : #accessing }
JunBoundingBox >> minLength [
	^self subclassResponsibility
]

{ #category : #accessing }
JunBoundingBox >> origin [
	^origin
]

{ #category : #accessing }
JunBoundingBox >> origin: originPoint [ 
	self origin: originPoint corner: self corner
]

{ #category : #accessing }
JunBoundingBox >> origin: originPoint corner: cornerPoint [ 
	self vertex: originPoint vertex: cornerPoint
]

{ #category : #accessing }
JunBoundingBox >> origin: originPoint extent: extentPoint [ 
	self origin: originPoint corner: originPoint + extentPoint
]

{ #category : #'lisp support' }
JunBoundingBox >> originToLispList [
	| list |
	list := self lispCons.
	list head: #origin.
	list tail: self origin toLispList.
	^list
]

{ #category : #copying }
JunBoundingBox >> postCopy [
	super postCopy.
	origin := origin copy.
	corner := corner copy
]

{ #category : #'truncation and round off' }
JunBoundingBox >> rounded [
	^self class origin: self origin rounded corner: self corner rounded
]

{ #category : #printing }
JunBoundingBox >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self origin printString.
	aStream nextPutAll: ' box: '.
	aStream nextPutAll: self corner printString.
	aStream nextPutAll: ')'
]

{ #category : #subdividing }
JunBoundingBox >> subdivide [
	"(((0 , 0 box: 1 , 1) subdivide) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) subdivide) showWithUnitArrows) wireframePresentation."

	^self subclassResponsibility
]

{ #category : #subdividing }
JunBoundingBox >> subdivide2 [
	"(((0 , 0 box: 1 , 1) subdivide2) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) subdivide2) showWithUnitArrows) wireframePresentation."

	^self subclassResponsibility
]

{ #category : #subdividing }
JunBoundingBox >> subdivide2Level: anInteger [ 
	"(((0 , 0 box: 1 , 1) subdivide2Level: 0) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 box: 1 , 1) subdivide2Level: 1) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 box: 1 , 1) subdivide2Level: 2) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) subdivide2Level: 0) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) subdivide2Level: 1) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) subdivide2Level: 2) showWithUnitArrows) wireframePresentation."

	| boundingBoxes |
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes boundingBoxes: (Array with: self).
	anInteger timesRepeat: [boundingBoxes := boundingBoxes subdivide2].
	^boundingBoxes
]

{ #category : #subdividing }
JunBoundingBox >> subdivideLevel: levelNumber [ 
	"(((0 , 0 box: 1 , 1) subdivideLevel: 0) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 box: 1 , 1) subdivideLevel: 1) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 box: 1 , 1) subdivideLevel: 2) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) subdivideLevel: 0) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) subdivideLevel: 1) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) subdivideLevel: 2) showWithUnitArrows) wireframePresentation."

	| boundingBoxes |
	boundingBoxes := self boundingBoxesClass new: 2 ** levelNumber.
	boundingBoxes boundingBoxes: (Array with: self).
	levelNumber timesRepeat: [boundingBoxes := boundingBoxes subdivide].
	^boundingBoxes
]

{ #category : #'lisp support' }
JunBoundingBox >> toLispList [
	"self showLispList: (((0 , 0) box: (1 , 1)) toLispList)."
	"self showLispList: (((0 , 0 , 0) box: (1 , 1 , 1)) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self originToLispList.
	list add: self cornerToLispList.
	^list
]

{ #category : #testing }
JunBoundingBox >> touches: aBoundingBox [ 
	^self origin <= aBoundingBox corner and: 
			[aBoundingBox origin <= self corner and: 
					[self origin <= self corner 
						and: [aBoundingBox origin <= aBoundingBox corner]]]
]

{ #category : #transforming }
JunBoundingBox >> transform: aTransformation [ 
	^self class origin: (self origin transform: aTransformation)
		corner: (self corner transform: aTransformation)
]

{ #category : #'truncation and round off' }
JunBoundingBox >> truncated [
	^self class origin: self origin truncated corner: self corner truncated
]

{ #category : #functions }
JunBoundingBox >> unify [
	^self
]

{ #category : #functions }
JunBoundingBox >> union: boundingBox [ 
	| boundingBoxes |
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes add: self.
	boundingBoxes add: boundingBox.
	^boundingBoxes unionBoxes
]

{ #category : #accessing }
JunBoundingBox >> vertex: vertexPoint1 vertex: vertexPoint2 [ 
	origin := (self pointClass coerce: vertexPoint1) 
				min: (self pointClass coerce: vertexPoint2).
	corner := (self pointClass coerce: vertexPoint1) 
				max: (self pointClass coerce: vertexPoint2)
]

{ #category : #testing }
JunBoundingBox >> whichSideOf: aPlane [ 
	| anArray hasPlus hasMinus hasZero |
	anArray := self asPointArray 
				collect: [:aPoint | aPoint whichSideOf: aPlane].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

{ #category : #accessing }
JunBoundingBox >> width [
	^self corner x - self origin x
]

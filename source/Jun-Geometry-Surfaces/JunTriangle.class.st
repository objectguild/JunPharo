"
Imported by VwImportClass
"
Class {
	#name : #JunTriangle,
	#superclass : #JunSurface,
	#instVars : [
		'p1',
		'p2',
		'p3'
	],
	#category : #'Jun-Geometry-Surfaces'
}

{ #category : #copyright }
JunTriangle class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunTriangle class >> first: aPoint1 second: aPoint2 third: aPoint3 [ 
	^self 
		on: aPoint1
		on: aPoint2
		on: aPoint3
]

{ #category : #'lisp support' }
JunTriangle class >> fromTable: aTable for: aTriangle [ 
	"Jun2dTriangle fromLispList: (((0 , 0) triangle: (1 , 0) and: (1 , 1)) toLispList)."
	"Jun3dTriangle fromLispList: (((0 , 0 , 0) triangle: (1 , 1 , 0) and: (1 , 1 , 1)) toLispList)."

	self p1FromTable: aTable for: aTriangle.
	self p2FromTable: aTable for: aTriangle.
	self p3FromTable: aTable for: aTriangle.
	^aTriangle
]

{ #category : #'instance creation' }
JunTriangle class >> on: aPoint1 on: aPoint2 on: aPoint3 [ 
	"Array 
		with: ((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) 
		with: ((0 , 0) triangle: (0 , 1) and: (1 , 1))."

	| aTriangle thePoint1 thePoint2 thePoint3 |
	aTriangle := self new.
	thePoint1 := aTriangle pointClass coerce: aPoint1.
	thePoint2 := aTriangle pointClass coerce: aPoint2.
	thePoint3 := aTriangle pointClass coerce: aPoint3.
	thePoint1 = thePoint2 ifTrue: [^nil].
	thePoint1 = thePoint3 ifTrue: [^nil].
	thePoint2 = thePoint3 ifTrue: [^nil].
	aTriangle setP1: thePoint1.
	aTriangle setP2: thePoint2.
	aTriangle setP3: thePoint3.
	^aTriangle
]

{ #category : #'lisp support' }
JunTriangle class >> p1FromTable: aTable for: aTriangle [ 
	| aList |
	aList := aTable at: #p1 ifAbsent: [^aTriangle].
	aTriangle setP1: (self pointClass fromLispList: aList).
	^aTriangle
]

{ #category : #'lisp support' }
JunTriangle class >> p2FromTable: aTable for: aTriangle [ 
	| aList |
	aList := aTable at: #p2 ifAbsent: [^aTriangle].
	aTriangle setP2: (self pointClass fromLispList: aList).
	^aTriangle
]

{ #category : #'lisp support' }
JunTriangle class >> p3FromTable: aTable for: aTriangle [ 
	| aList |
	aList := aTable at: #p3 ifAbsent: [^aTriangle].
	aTriangle setP3: (self pointClass fromLispList: aList).
	^aTriangle
]

{ #category : #copyright }
JunTriangle class >> system [
	^'Jun'
]

{ #category : #copyright }
JunTriangle class >> version [
	^'799'
]

{ #category : #comparing }
JunTriangle >> = aTriangle [ 
	self class == aTriangle class ifFalse: [^false].
	^(self first = aTriangle first and: [self second = aTriangle second]) 
		and: [self third = aTriangle third]
]

{ #category : #functions }
JunTriangle >> angleWithLine: aLine [ 
	^self asPlane angleWithLine: aLine
]

{ #category : #functions }
JunTriangle >> angleWithPlane: aPlane [ 
	^self asPlane angleWithPlane: aPlane
]

{ #category : #functions }
JunTriangle >> angleWithTriangle: aTriangle [ 
	^self asPlane angleWithPlane: aTriangle asPlane
]

{ #category : #functions }
JunTriangle >> area [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) area) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) area)."

	| a b c s area |
	self hasArea ifFalse: [^Double zero].
	a := self p1 distance: self p2.
	b := self p2 distance: self p3.
	c := self p3 distance: self p1.
	s := (a + b + c) / 2.
	area := (s * (s - a) * (s - b) * (s - c)) sqrt.
	^area
]

{ #category : #functions }
JunTriangle >> areaWithSign [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) areaWithSign) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) areaWithSign)."

	^self subclassResponsibility
]

{ #category : #converting }
JunTriangle >> asArrayOfLines [
	"(0 , 0 , 0 triangle: 1 , 0 , 0 and: 0 , 1 , 0) asArrayOfLines."

	^Array 
		with: (self p1 to: self p2)
		with: (self p2 to: self p3)
		with: (self p3 to: self p1)
]

{ #category : #converting }
JunTriangle >> asArrayOfPlanes [
	^Array with: self asPlane
]

{ #category : #converting }
JunTriangle >> asArrayOfPoints [
	| anArray |
	anArray := Array new: 3.
	anArray at: 1 put: self first.
	anArray at: 2 put: self second.
	anArray at: 3 put: self third.
	^anArray
]

{ #category : #converting }
JunTriangle >> asArrayOfTriangles [
	^Array with: self
]

{ #category : #converting }
JunTriangle >> asBoundingBall [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) asBoundingBall) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) asBoundingBall)."

	^self boundingBallClass fromPoints: (Array 
				with: self p1
				with: self p2
				with: self p3)
]

{ #category : #converting }
JunTriangle >> asBoundingBalls [
	| boundingBalls |
	boundingBalls := self boundingBallsClass new.
	boundingBalls boundingBalls: (Array with: self asBoundingBall).
	^boundingBalls
]

{ #category : #converting }
JunTriangle >> asBoundingBox [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) asBoundingBox) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) asBoundingBox)."

	^self boundingBoxClass fromPoints: (Array 
				with: self p1
				with: self p2
				with: self p3)
]

{ #category : #converting }
JunTriangle >> asBoundingBoxes [
	| boundingBoxes |
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes boundingBoxes: (Array with: self asBoundingBox).
	^boundingBoxes
]

{ #category : #converting }
JunTriangle >> asCircle [
	"(((1 , 0 , 0) triangle: (0 , 1 , 0) and: (0 , 0 , 1)) asCircle) asJunOpenGL3dObject showWithAxes."

	"(((0 , 0) triangle: (1 , 0) and: (0 , 1)) asCircle) asJunOpenGL3dObject showWithAxes."

	| centerPoint |
	centerPoint := self centerOfCircumcircle.
	self is3d 
		ifTrue: 
			[^self circleClass 
				center: centerPoint
				radius: (centerPoint distance: self p1)
				upVector: self normalVector]
		ifFalse: 
			[^self circleClass center: centerPoint
				radius: (centerPoint distance: self p1)]
]

{ #category : #converting }
JunTriangle >> asJunOpenGL3dObject [
	"(1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1) asJunOpenGL3dObject showWithAxes."

	| aPolygon |
	aPolygon := JunOpenGL3dPolygon vertexes: (Array 
						with: (Jun3dPoint coerce: self p1)
						with: (Jun3dPoint coerce: self p2)
						with: (Jun3dPoint coerce: self p3)).
	aPolygon paint: self defaultColor.
	^aPolygon
]

{ #category : #converting }
JunTriangle >> asJunOpenGL3dObjectWithPoints [
	"(1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1) asJunOpenGL3dObjectWithPoints showWithAxes."

	| compoundObject |
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: self asJunOpenGL3dObject.
	compoundObject add: (self p1 asJunOpenGL3dObject paint: ColorValue red).
	compoundObject add: (self p2 asJunOpenGL3dObject paint: ColorValue green).
	compoundObject add: (self p3 asJunOpenGL3dObject paint: ColorValue blue).
	^compoundObject
]

{ #category : #converting }
JunTriangle >> asPlane [
	"(((1 , 0 , 0) triangle: (0 , 1 , 0) and: (0 , 0 , 1)) asPlane) asJunOpenGL3dObject showWithAxes."

	"(((0 , 0) triangle: (1 , 0) and: (0 , 1)) asPlane) asJunOpenGL3dObject showWithAxes."

	^self planeClass 
		on: self p1
		on: self p2
		on: self p3
]

{ #category : #converting }
JunTriangle >> asPointArray [
	| anArray |
	anArray := Array new: 4.
	anArray at: 1 put: self first.
	anArray at: 2 put: self second.
	anArray at: 3 put: self third.
	anArray at: 4 put: self first.
	^anArray
]

{ #category : #converting }
JunTriangle >> asTriangle [
	^self
]

{ #category : #converting }
JunTriangle >> asTriangles [
	^self trianglesClass triangles: (Array with: self)
]

{ #category : #functions }
JunTriangle >> barycenter [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) barycenter) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) barycenter)."

	^self centerOfGravity
]

{ #category : #accessing }
JunTriangle >> boundingBall [
	^self asBoundingBall
]

{ #category : #accessing }
JunTriangle >> boundingBox [
	^self asBoundingBox
]

{ #category : #functions }
JunTriangle >> centerOfCircumcircle [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) centerOfCircumcircle) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) centerOfCircumcircle)."

	^self circumcircle center
]

{ #category : #functions }
JunTriangle >> centerOfGravity [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) centerOfGravity) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) centerOfGravity)."

	| middlePoint centerOfGravity |
	middlePoint := self p2 + ((self p3 - self p2) / 2).
	centerOfGravity := (self lineClass from: p1 to: middlePoint) atT: 2 / 3.
	^centerOfGravity
]

{ #category : #functions }
JunTriangle >> centerOfIncircle [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) centerOfIncircle) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) centerOfIncircle)."

	^self incircle center
]

{ #category : #functions }
JunTriangle >> centerOfOrthics [
	"Array 
		with: (((1 , 0 , 0) triangle: (0 , 1 , 0) and: (0 , 0 , 1)) centerOfOrthics) 
		with: (((1 , 0) triangle: (0 , 1) and: (2 , 2)) centerOfOrthics)."

	| firstLine secondLine |
	firstLine := self lineClass on: self p2 vertical: (self p3 to: self p1).
	secondLine := self lineClass on: self p3 vertical: (self p1 to: self p2).
	^firstLine intersectingPointWithLine: secondLine
]

{ #category : #functions }
JunTriangle >> circumball [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) circumball) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) circumball)."

	"| aTriangle aBody |
	aTriangle := (1 , 0 , 0) triangle: (0 , 1 , 0) and: (0 , 0 , 1).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle circumball asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	"| aTriangle aBody |
	aTriangle := (1 , 0) triangle: (0 , 1) and: (0 , 0).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle circumball asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	| aCircle |
	aCircle := self circumcircle.
	^self boundingBallClass center: aCircle center radius: aCircle radius
]

{ #category : #functions }
JunTriangle >> circumcenter [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) circumcenter) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) circumcenter)."

	^self centerOfCircumcircle
]

{ #category : #functions }
JunTriangle >> circumcircle [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) circumcircle) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) circumcircle)."

	"| aTriangle aBody |
	aTriangle := (1 , 0 , 0) triangle: (0 , 1 , 0) and: (0 , 0 , 1).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle circumcircle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	"| aTriangle aBody |
	aTriangle := (1 , 0) triangle: (0 , 1) and: (0 , 0).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle circumcircle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	| unitVector middlePoint firstLine aTransformation secondLine centerPoint radiusValue |
	self is3d 
		ifTrue: 
			[unitVector := self asPlane normalUnitVector.
			middlePoint := self p1 center: self p2.
			firstLine := Jun3dLine from: middlePoint to: middlePoint + unitVector.
			aTransformation := Jun3dTransformation rotate: (JunAngle fromDeg: 90)
						around: (self p1 to: self p2).
			firstLine := firstLine transform: aTransformation.
			middlePoint := self p1 center: self p3.
			secondLine := Jun3dLine from: middlePoint to: middlePoint + unitVector.
			aTransformation := Jun3dTransformation rotate: (JunAngle fromDeg: 90)
						around: (self p1 to: self p3).
			secondLine := secondLine transform: aTransformation.
			centerPoint := firstLine intersectingPointWithLine: secondLine.
			radiusValue := centerPoint distance: self p1.
			^self circleClass 
				center: centerPoint
				radius: radiusValue
				upVector: self normalVector]
		ifFalse: 
			[centerPoint := (self p1 bisector: self p2) 
						intersectingPointWithLine: (self p2 bisector: self p3).
			radiusValue := centerPoint distance: self p1.
			^self circleClass center: centerPoint radius: radiusValue]
]

{ #category : #functions }
JunTriangle >> circumsphere [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) circumsphere) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) circumsphere)."

	"| aTriangle aBody |
	aTriangle := (1 , 0 , 0) triangle: (0 , 1 , 0) and: (0 , 0 , 1).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle circumsphere asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	"| aTriangle aBody |
	aTriangle := (1 , 0) triangle: (0 , 1) and: (0 , 0).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle circumsphere asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	| aCircle |
	aCircle := self circumcircle.
	^self sphereClass center: aCircle center radius: aCircle radius
]

{ #category : #testing }
JunTriangle >> containsPoint: aPoint [ 
	^self subclassResponsibility
]

{ #category : #functions }
JunTriangle >> detailedTriangles [
	"Array
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) detailedTriangles)
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) detailedTriangles)."

	| detailedTriangles pointArray aPoint aTriangle |
	detailedTriangles := Array new: 4.
	pointArray := Array new: 6.
	pointArray at: 1 put: self p1.
	pointArray at: 2 put: self p2.
	pointArray at: 3 put: self p3.
	aPoint := (pointArray at: 1) center: (pointArray at: 2).
	pointArray at: 4 put: aPoint.
	aPoint := (pointArray at: 2) center: (pointArray at: 3).
	pointArray at: 5 put: aPoint.
	aPoint := (pointArray at: 3) center: (pointArray at: 1).
	pointArray at: 6 put: aPoint.
	aTriangle := self class 
				on: (pointArray at: 1)
				on: (pointArray at: 4)
				on: (pointArray at: 6).
	detailedTriangles at: 1 put: aTriangle.
	aTriangle := self class 
				on: (pointArray at: 4)
				on: (pointArray at: 2)
				on: (pointArray at: 5).
	detailedTriangles at: 2 put: aTriangle.
	aTriangle := self class 
				on: (pointArray at: 5)
				on: (pointArray at: 3)
				on: (pointArray at: 6).
	detailedTriangles at: 3 put: aTriangle.
	aTriangle := self class 
				on: (pointArray at: 4)
				on: (pointArray at: 5)
				on: (pointArray at: 6).
	detailedTriangles at: 4 put: aTriangle.
	^detailedTriangles
]

{ #category : #functions }
JunTriangle >> detailedTrianglesLevel: levelNumber [ 
	"Array
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) detailedTrianglesLevel: 2)
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) detailedTrianglesLevel: 2)."

	| aCollection |
	levelNumber <= 0 ifTrue: [^Array with: self].
	aCollection := OrderedCollection new: 4 ** levelNumber.
	self detailedTriangles 
		do: [:triangle | aCollection addAll: (triangle detailedTrianglesLevel: levelNumber - 1)].
	^aCollection asArray
]

{ #category : #dividing }
JunTriangle >> dividedBy: bisector [ 
	^(self zerosDividedBy: bisector) , (self positivesDividedBy: bisector)
]

{ #category : #comparing }
JunTriangle >> equal: aTriangle [ 
	self class == aTriangle class ifFalse: [^false].
	^((self first equal: aTriangle first) 
		and: [self second equal: aTriangle second]) 
			and: [self third equal: aTriangle third]
]

{ #category : #accessing }
JunTriangle >> first [
	^self p1
]

{ #category : #testing }
JunTriangle >> hasArea [
	^((self p1 equal: self p2) 
		or: [(self p2 equal: self p3) or: [self p3 equal: self p1]]) not
]

{ #category : #functions }
JunTriangle >> inball [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) inball) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) inball)."

	"| aTriangle aBody |
	aTriangle := (1 , 0 , 0) triangle: (0 , 1 , 0) and: (0 , 0 , 1).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle inball asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	"| aTriangle aBody |
	aTriangle := (1 , 0) triangle: (0 , 1) and: (0 , 0).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle inball asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	| aCircle |
	aCircle := self incircle.
	^self boundingBallClass center: aCircle center radius: aCircle radius
]

{ #category : #functions }
JunTriangle >> incenter [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) incenter) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) incenter)."

	^self centerOfIncircle
]

{ #category : #functions }
JunTriangle >> incircle [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) incircle) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) incircle)."

	"| aTriangle aBody |
	aTriangle := (1 , 0 , 0) triangle: (0 , 1 , 0) and: (0 , 0 , 1).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle incircle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	"| aTriangle aBody |
	aTriangle := (1 , 0) triangle: (0 , 1) and: (0 , 0).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle incircle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	| t d12 d23 d31 x y z centerPoint s radiusValue |
	t := self peripheryOfTriangle.
	t < self class accuracy ifTrue: [^self error: 'unexpected triangle'].
	d12 := self p1 distance: self p2.
	d23 := self p2 distance: self p3.
	d31 := self p3 distance: self p1.
	x := (d23 * self p1 x + (d31 * self p2 x) + (d12 * self p3 x)) / t.
	y := (d23 * self p1 y + (d31 * self p2 y) + (d12 * self p3 y)) / t.
	z := (d23 * self p1 z + (d31 * self p2 z) + (d12 * self p3 z)) / t.
	centerPoint := self pointClass 
				x: x
				y: y
				z: z.
	s := self peripheryOfTriangle / 2.
	s < self class accuracy ifTrue: [^self error: 'unexpected triangle'].
	radiusValue := ((s - (self p1 distance: self p2)) 
				* (s - (self p2 distance: self p3)) * (s - (self p3 distance: self p1)) 
				/ s) sqrt.
	self is3d 
		ifTrue: 
			[^self circleClass 
				center: centerPoint
				radius: radiusValue
				upVector: self normalVector]
		ifFalse: [^self circleClass center: centerPoint radius: radiusValue]
]

{ #category : #functions }
JunTriangle >> insphere [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) insphere) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) insphere)."

	"| aTriangle aBody |
	aTriangle := (1 , 0 , 0) triangle: (0 , 1 , 0) and: (0 , 0 , 1).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle insphere asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	"| aTriangle aBody |
	aTriangle := (1 , 0) triangle: (0 , 1) and: (0 , 0).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTriangle asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle reversed asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTriangle insphere asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.25).
	aBody showWithAxes.
	^aTriangle"

	| aCircle |
	aCircle := self incircle.
	^self sphereClass center: aCircle center radius: aCircle radius
]

{ #category : #testing }
JunTriangle >> isTriangle [
	^true
]

{ #category : #accessing }
JunTriangle >> last [
	^self p3
]

{ #category : #accessing }
JunTriangle >> middle [
	^self p2
]

{ #category : #dividing }
JunTriangle >> negativesDividedBy: bisector [ 
	| aTable |
	aTable := self tableDividedBy: bisector.
	^aTable at: #negatives
]

{ #category : #functions }
JunTriangle >> normalUnitVector [
	^self subclassResponsibility
]

{ #category : #functions }
JunTriangle >> normalVector [
	^self subclassResponsibility
]

{ #category : #functions }
JunTriangle >> orthocenter [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) orthocenter) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) orthocenter)."

	^self centerOfOrthics
]

{ #category : #accessing }
JunTriangle >> p1 [
	^p1
]

{ #category : #'lisp support' }
JunTriangle >> p1ToLispList [
	| list |
	list := self lispCons.
	list head: #p1.
	list tail: self p1 toLispList.
	^list
]

{ #category : #accessing }
JunTriangle >> p2 [
	^p2
]

{ #category : #'lisp support' }
JunTriangle >> p2ToLispList [
	| list |
	list := self lispCons.
	list head: #p2.
	list tail: self p2 toLispList.
	^list
]

{ #category : #accessing }
JunTriangle >> p3 [
	^p3
]

{ #category : #'lisp support' }
JunTriangle >> p3ToLispList [
	| list |
	list := self lispCons.
	list head: #p3.
	list tail: self p3 toLispList.
	^list
]

{ #category : #functions }
JunTriangle >> perimeter [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) perimeter) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) perimeter)."

	^self peripheryOfTriangle
]

{ #category : #functions }
JunTriangle >> periphery [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) periphery) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) periphery)."

	^self peripheryOfTriangle
]

{ #category : #functions }
JunTriangle >> peripheryOfTriangle [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) peripheryOfTriangle) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) peripheryOfTriangle)."

	| perimeter |
	perimeter := 0.
	perimeter := perimeter + (self p1 distance: self p2).
	perimeter := perimeter + (self p2 distance: self p3).
	perimeter := perimeter + (self p3 distance: self p1).
	^perimeter
]

{ #category : #accessing }
JunTriangle >> points [
	^Array 
		with: self p1
		with: self p2
		with: self p3
]

{ #category : #dividing }
JunTriangle >> pointsDividedBy: bisector [ 
	| aTable |
	aTable := self tableDividedBy: bisector.
	^aTable at: #points
]

{ #category : #dividing }
JunTriangle >> positivesDividedBy: bisector [ 
	| aTable |
	aTable := self tableDividedBy: bisector.
	^aTable at: #positives
]

{ #category : #printing }
JunTriangle >> printOn: aStream [ 
	aStream nextPutAll: '('.
	self p1 printOn: aStream.
	aStream nextPutAll: ' triangle: '.
	self p2 printOn: aStream.
	aStream nextPutAll: ' and: '.
	self p3 printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #functions }
JunTriangle >> radiusOfCircumcircle [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) radiusOfCircumcircle) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) radiusOfCircumcircle)."

	^self circumcircle radius
]

{ #category : #functions }
JunTriangle >> radiusOfIncircle [
	"Array 
		with: (((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) radiusOfIncircle) 
		with: (((0 , 0) triangle: (0 , 1) and: (1 , 1)) radiusOfIncircle)."

	^self incircle radius
]

{ #category : #converting }
JunTriangle >> reversed [
	^self class 
		on: self p3
		on: self p2
		on: self p1
]

{ #category : #accessing }
JunTriangle >> second [
	^self p2
]

{ #category : #private }
JunTriangle >> setP1: aPoint [ 
	p1 := self pointClass coerce: aPoint
]

{ #category : #private }
JunTriangle >> setP2: aPoint [ 
	p2 := self pointClass coerce: aPoint
]

{ #category : #private }
JunTriangle >> setP3: aPoint [ 
	p3 := self pointClass coerce: aPoint
]

{ #category : #printing }
JunTriangle >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' on: '.
	self p1 storeOn: aStream.
	aStream nextPutAll: ' on: '.
	self p2 storeOn: aStream.
	aStream nextPutAll: ' on: '.
	self p3 storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #subdividing }
JunTriangle >> subdivide [
	"(((0 , 0 triangle: 1 , 0 and: 0 , 1) subdivide) showWithArrows) wireframePresentation."

	"(((0 , 0 , 1 triangle: 1 , 0 , 0 and: 0 , 1 , 0) subdivide) showWithArrows) wireframePresentation."

	^self subdivide4
]

{ #category : #subdividing }
JunTriangle >> subdivide4 [
	"(((((0 , 0) triangle: (1 , 0) and: (0 , 1)) subdivide4) asJunOpenGL3dObject) add: JunOpenGL3dObject xyArrows; show) wireframePresentation."

	"(((((0 , 0 , 1) triangle: (1 , 0 , 0) and: (0 , 1 , 0)) subdivide4) asJunOpenGL3dObject) add: JunOpenGL3dObject xyzArrows; show) wireframePresentation."

	^self trianglesClass triangles: self detailedTriangles
]

{ #category : #subdividing }
JunTriangle >> subdivide4Level: levelNumber [ 
	"(((((0 , 0) triangle: (1 , 0) and: (0 , 1)) subdivide4Level: 0) asJunOpenGL3dObject) add: JunOpenGL3dObject xyArrows; show) wireframePresentation."

	"(((((0 , 0) triangle: (1 , 0) and: (0 , 1)) subdivide4Level: 1) asJunOpenGL3dObject) add: JunOpenGL3dObject xyArrows; show) wireframePresentation."

	"(((((0 , 0) triangle: (1 , 0) and: (0 , 1)) subdivide4Level: 2) asJunOpenGL3dObject) add: JunOpenGL3dObject xyArrows; show) wireframePresentation."

	"(((((0 , 0 , 1) triangle: (1 , 0 , 0) and: (0 , 1 , 0)) subdivide4Level: 0) asJunOpenGL3dObject) add: JunOpenGL3dObject xyzArrows; show) wireframePresentation."

	"(((((0 , 0 , 1) triangle: (1 , 0 , 0) and: (0 , 1 , 0)) subdivide4Level: 1) asJunOpenGL3dObject) add: JunOpenGL3dObject xyzArrows; show) wireframePresentation."

	"(((((0 , 0 , 1) triangle: (1 , 0 , 0) and: (0 , 1 , 0)) subdivide4Level: 2) asJunOpenGL3dObject) add: JunOpenGL3dObject xyzArrows; show) wireframePresentation."

	^self trianglesClass triangles: (self detailedTrianglesLevel: levelNumber)
]

{ #category : #subdividing }
JunTriangle >> subdivideLevel: levelNumber [ 
	"(((0 , 0 triangle: 1 , 0 and: 0 , 1) subdivideLevel: 0) showWithArrows) wireframePresentation."

	"(((0 , 0 triangle: 1 , 0 and: 0 , 1) subdivideLevel: 1) showWithArrows) wireframePresentation."

	"(((0 , 0 triangle: 1 , 0 and: 0 , 1) subdivideLevel: 2) showWithArrows) wireframePresentation."

	"(((0 , 0 , 1 triangle: 1 , 0 , 0 and: 0 , 1 , 0) subdivideLevel: 0) showWithArrows) wireframePresentation."

	"(((0 , 0 , 1 triangle: 1 , 0 , 0 and: 0 , 1 , 0) subdivideLevel: 1) showWithArrows) wireframePresentation."

	"(((0 , 0 , 1 triangle: 1 , 0 , 0 and: 0 , 1 , 0) subdivideLevel: 2) showWithArrows) wireframePresentation."

	^self subdivide4Level: levelNumber
]

{ #category : #dividing }
JunTriangle >> tableDividedBy: bisector [ 
	^self subclassResponsibility
]

{ #category : #accessing }
JunTriangle >> third [
	^self p3
]

{ #category : #'lisp support' }
JunTriangle >> toLispList [
	"self showLispList: (((0 , 0) triangle: (1 , 0) and: (1 , 1)) toLispList)."
	"self showLispList: (((0 , 0 , 0) triangle: (1 , 1 , 0) and: (1 , 1 , 1)) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self p1ToLispList.
	list add: self p2ToLispList.
	list add: self p3ToLispList.
	^list
]

{ #category : #transforming }
JunTriangle >> transform: aTransformation [ 
	^self class 
		on: (self p1 transform: aTransformation)
		on: (self p2 transform: aTransformation)
		on: (self p3 transform: aTransformation)
]

{ #category : #testing }
JunTriangle >> whichSideOf: bisector [ 
	"((1 , 0 , 0) triangle: (0 , 1 , 0) and: (0 , 0 , 1)) whichSideOf: ((1 , 0 , 0) bisector: (0 , 1 , 0))."

	"((1 , 0) triangle: (0 , 1) and: (0 , 0)) whichSideOf: ((1 , 0) bisector: (0 , 1))."

	| anArray hasPlus hasMinus hasZero |
	anArray := (Array 
				with: self p1
				with: self p2
				with: self p3) collect: [:aPoint | aPoint whichSideOf: bisector].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

{ #category : #dividing }
JunTriangle >> zerosDividedBy: bisector [ 
	| aTable |
	aTable := self tableDividedBy: bisector.
	^aTable at: #zeros
]

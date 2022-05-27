"
Imported by VwImportClass
"
Class {
	#name : #Jun3dPolygon,
	#superclass : #JunPlane,
	#instVars : [
		'parameterPolygon',
		'boundingBox',
		'normalVector'
	],
	#category : #'Jun-Geometry-Surfaces'
}

{ #category : #'constants access' }
Jun3dPolygon class >> accuracy [
	^JunGeometry accuracy 
		* (10 ** (JunGeometry accuracy reciprocal log / 2 - 2 max: 0) rounded)
]

{ #category : #test }
Jun3dPolygon class >> containsPointTest [
	"JunPolygon containsPointTest"

	| polygon truePoints falsePoints |
	polygon := self examplePolygon.
	truePoints := OrderedCollection new.
	truePoints add: 0.5 , 0.5 , 0.
	truePoints add: 1 , 0 , 0.
	truePoints add: 1 , 1 , 0.
	truePoints add: 0 , 1 , 0.
	truePoints add: 0 , 0 , 0.
	truePoints add: 0.5 , 0 , 0.
	truePoints add: 0.5 , 1 , 0.
	truePoints add: 0 , 0.5 , 0.
	truePoints add: 1 , 0.5 , 0.
	falsePoints := OrderedCollection new.
	falsePoints add: -1 , -1 , 0.
	falsePoints add: 0.5 , 0.5 , 1.
	falsePoints add: 0 , 2 , 0.
	falsePoints add: 0 , -1 , 0.
	falsePoints add: -1 , 0 , 0.
	falsePoints add: 2 , 0 , 0.
	falsePoints add: 1 , 2 , 0.
	falsePoints add: 1 , -1 , 0.
	falsePoints add: -1 , 1 , 0.
	falsePoints add: 2 , 1 , 0.
	truePoints do: [:point | (polygon containsPoint: point)
			ifFalse: [self halt]].
	falsePoints do: [:point | (polygon containsPoint: point)
			ifTrue: [self halt]]
]

{ #category : #copyright }
Jun3dPolygon class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dPolygon class >> example1 [
	"Jun3dPolygon example1."

	| aBody aPolygon |
	aBody := JunOpenGL3dCompoundObject new.
	aPolygon := Jun3dPolygon points: (Array 
						with: 1 , 1 , 0
						with: -1 , 1 , 0
						with: -1 , -1 , 0
						with: 1 , -1 , 0).
	aBody add: aPolygon asJunOpenGL3dObject.
	aBody show.
	^aPolygon
]

{ #category : #examples }
Jun3dPolygon class >> examplePolygon [
	| points |
	points := Array new: 5.
	points at: 1 put: 0 , 0 , 0.
	points at: 2 put: 1 , 0 , 0.
	points at: 3 put: 1 , 1 , 0.
	points at: 4 put: 0 , 1 , 0.
	points at: 5 put: 0.000000000001 , 0.5 , 0.
	^Jun3dPolygon points: points
]

{ #category : #'lisp support' }
Jun3dPolygon class >> fromTable: aTable for: aPolygon [ 
	"JunPlane fromLispList: ((Jun3dPolygon examplePolygon) toLispList)."

	super fromTable: aTable for: aPolygon.
	self parameterPolygonFromTable: aTable for: aPolygon.
	^aPolygon
]

{ #category : #test }
Jun3dPolygon class >> normalVectorTest [
	"JunPolygon normalVectorTest"

	| points polygon1 normalVector1 polygon2 normalVector2 |
	points := Array new: 8.
	points at: 1 put: 0 , 0 , 0.
	points at: 2 put: 2 , 0 , 0.
	points at: 3 put: 2 , 3 , 0.
	points at: 4 put: 0 , 3 , 0.
	points at: 5 put: 0 , 2 , 0.
	points at: 6 put: 1 , 2 , 0.
	points at: 7 put: 1 , 1 , 0.
	points at: 8 put: 0 , 1 , 0.
	polygon1 := Jun3dPolygon points: points.
	normalVector1 := polygon1 normalVector.
	Transcript cr; show: polygon1 printString , ' -> ' , normalVector1 printString.
	polygon2 := Jun3dPolygon points: points reverse.
	normalVector2 := polygon2 normalVector.
	Transcript cr; show: polygon2 printString , ' -> ' , normalVector2 printString
]

{ #category : #'instance creation' }
Jun3dPolygon class >> on: aPoint1 on: aPoint2 on: aPoint3 [ 
	^self vertexes: (Array
			with: aPoint1
			with: aPoint2
			with: aPoint3)
]

{ #category : #'instance creation' }
Jun3dPolygon class >> on: aPoint vertical: aLine [ 
	^self shouldNotImplement
]

{ #category : #'instance creation' }
Jun3dPolygon class >> origin: aJun3dPoint1 uVector: aJun3dPoint2 vVector: aJun3dPoint3 parameterPolygon: aJun2dPolygon [ 
	| wVector vVector polygon |
	wVector := (aJun3dPoint2 vectorProduct: aJun3dPoint3) unitVector.
	vVector := (wVector vectorProduct: aJun3dPoint2) unitVector.
	polygon := super 
				on: aJun3dPoint1
				on: aJun3dPoint1 + aJun3dPoint2
				on: aJun3dPoint1 + vVector.
	polygon isNil ifTrue: [^nil].
	polygon setParameterPolygon: aJun2dPolygon.
	^polygon
]

{ #category : #'instance creation' }
Jun3dPolygon class >> origin: aJun3dPoint1 uVector: aJun3dPoint2 vVector: aJun3dPoint3 points: anArrayOfJun3dPoint [ 
	| wVector vVector polygon |
	wVector := (aJun3dPoint2 vectorProduct: aJun3dPoint3) unitVector.
	vVector := (wVector vectorProduct: aJun3dPoint2) unitVector.
	polygon := super 
				on: aJun3dPoint1
				on: aJun3dPoint1 + aJun3dPoint2
				on: aJun3dPoint1 + vVector.
	polygon isNil ifTrue: [^nil].
	polygon setParameterPolygon: (self parameterPolygonClass 
				points: (anArrayOfJun3dPoint 
						collect: [:point | polygon parameterPointAtPoint: point])).
	^polygon
]

{ #category : #'class access' }
Jun3dPolygon class >> parameterPolygonClass [
	^Jun2dPolygon
]

{ #category : #'lisp support' }
Jun3dPolygon class >> parameterPolygonFromTable: aTable for: aPolygon [ 
	| aList |
	aList := aTable at: #parameterPolygon ifAbsent: [^aPolygon].
	aPolygon setParameterPolygon: (Jun2dPolygon fromLispList: aList).
	^aPolygon
]

{ #category : #'instance creation' }
Jun3dPolygon class >> points: anArrayOfJun3dPoint [ 
	^self vertexes: anArrayOfJun3dPoint
]

{ #category : #copyright }
Jun3dPolygon class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun3dPolygon class >> version [
	^'799'
]

{ #category : #'instance creation' }
Jun3dPolygon class >> vertexes: anArrayOfJun3dPoint [ 
	| points origin uIndex maxDistance uVector vVector wVector uPoint |
	points := anArrayOfJun3dPoint.
	points size < 3 ifTrue: [^nil].
	origin := points at: 1.
	uIndex := nil.
	maxDistance := nil.
	(2 to: points size) do: 
			[:index | 
			| distance |
			distance := (points at: index) distance: origin.
			(maxDistance isNil or: [maxDistance < distance]) 
				ifTrue: 
					[uIndex := index.
					maxDistance := distance]].
	uPoint := points at: uIndex.
	uVector := (uPoint - origin) unitVector.
	wVector := Jun3dPoint zero.
	1 to: points size
		do: 
			[:index | 
			| point1 point2 point3 |
			point1 := points at: index.
			point2 := points at: index \\ points size + 1.
			point3 := points at: (index + 1) \\ points size + 1.
			wVector := wVector + (point2 - point1 vectorProduct: point3 - point2)].
	vVector := (wVector vectorProduct: uVector) unitVector.
	^self 
		origin: origin
		uVector: uVector
		vVector: vVector
		points: points
]

{ #category : #comparing }
Jun3dPolygon >> = aPolygon [ 
	super = aPolygon ifFalse: [^false].
	^self parameterPolygon = aPolygon parameterPolygon
]

{ #category : #accessing }
Jun3dPolygon >> area [
	^self parameterPolygon area * self uVector length * self vVector length
]

{ #category : #converting }
Jun3dPolygon >> asArrayOfConvexPolygons [
	| convexPolygonStream |
	convexPolygonStream := Array new writeStream.
	self asConvexPolygonsDo: [:polygon | convexPolygonStream nextPut: polygon].
	^convexPolygonStream contents
]

{ #category : #converting }
Jun3dPolygon >> asArrayOfLines [
	"(Jun3dPolygon points: (Array 
				with: 0 , 0 , 0
				with: 2 , 0 , 0
				with: 2 , 2 , 0
				with: 0 , 2 , 0)) 
		asArrayOfLines."

	| collection polyline |
	collection := self points copy asOrderedCollection.
	(collection first equal: collection last) 
		ifFalse: [collection add: collection first].
	polyline := self polylineClass vertexes: collection.
	^polyline asArrayOfLines
]

{ #category : #converting }
Jun3dPolygon >> asArrayOfPoints [
	^Array withAll: self points
]

{ #category : #converting }
Jun3dPolygon >> asArrayOfTrianglePolygons [
	"(Jun3dPolygon vertexes: (Array 
				with: 0 , 0 , 0
				with: 1 , 0 , 0
				with: 1 , 1 , 0
				with: 0 , 1 , 0)) asArrayOfTrianglePolygons."

	| convexPolygons triangles |
	self numberOfPoints = 3 ifTrue: [^Array with: self].
	convexPolygons := self asArrayOfConvexPolygons.
	triangles := OrderedCollection new: self numberOfPoints - 2.
	convexPolygons do: 
			[:convexPolygon | 
			2 to: convexPolygon numberOfPoints - 1
				do: 
					[:index | 
					triangles 
						add: (self class vertexes: (Array 
										with: (convexPolygon pointAt: 1)
										with: (convexPolygon pointAt: index)
										with: (convexPolygon pointAt: index + 1)))]].
	^triangles asArray
]

{ #category : #converting }
Jun3dPolygon >> asArrayOfTriangles [
	"(Jun3dPolygon vertexes: (Array 
				with: 0 , 0 , 0
				with: 1 , 0 , 0
				with: 1 , 1 , 0
				with: 0 , 1 , 0)) asArrayOfTriangles."

	| convexPolygons triangles |
	self numberOfPoints = 3 
		ifTrue: 
			[^Array with: (Jun3dTriangle 
						on: (self pointAt: 1)
						on: (self pointAt: 2)
						on: (self pointAt: 3))].
	convexPolygons := self asArrayOfConvexPolygons.
	triangles := OrderedCollection new: self numberOfPoints - 2.
	convexPolygons do: 
			[:convexPolygon | 
			2 to: convexPolygon numberOfPoints - 1
				do: 
					[:index | 
					triangles add: (Jun3dTriangle 
								on: (convexPolygon pointAt: 1)
								on: (convexPolygon pointAt: index)
								on: (convexPolygon pointAt: index + 1))]].
	^triangles asArray
]

{ #category : #enumerating }
Jun3dPolygon >> asConvexPolygonsDo: aBlock [ 
	self parameterPolygon
		asConvexPolygonsDo: 
			[:pPolygon | 
			| convexPolygon |
			convexPolygon := self copy setParameterPolygon: pPolygon.
			aBlock value: convexPolygon]
]

{ #category : #converting }
Jun3dPolygon >> asJunOpenGL3dObject [
	| aBody |
	self isConvex 
		ifTrue: [aBody := JunOpenGL3dPolygon vertexes: self points]
		ifFalse: 
			[aBody := JunOpenGL3dCompoundObject 
						components: (self asArrayOfConvexPolygons 
								collect: [:polygon | JunOpenGL3dPolygon vertexes: polygon points])].
	aBody objectsDo: [:object | object paint: self defaultColor alpha: nil].
	^aBody
]

{ #category : #converting }
Jun3dPolygon >> asPolyline [
	^JunPolyline vertexes: self points
]

{ #category : #'bounds access' }
Jun3dPolygon >> boundingBox [
	boundingBox isNil ifTrue: [boundingBox := self preferredBoundingBox].
	^boundingBox
]

{ #category : #testing }
Jun3dPolygon >> containsLineSegment: aJun3dLine [ 
	^self containsLineSegmentFrom: aJun3dLine from to: aJun3dLine to
]

{ #category : #testing }
Jun3dPolygon >> containsLineSegmentFrom: aJun3dPoint1 to: aJun3dPoint2 [ 
	((self containsPoint: aJun3dPoint1)
		and: [self containsPoint: aJun3dPoint2])
		ifFalse: [^false].
	^self parameterPolygon absContainsLineSegmentFrom: (self parameterPointAtPoint: aJun3dPoint1)
		to: (self parameterPointAtPoint: aJun3dPoint2)
]

{ #category : #testing }
Jun3dPolygon >> containsPoint: aJun3dPoint [ 
	(super containsPoint: aJun3dPoint)
		ifFalse: [^false].
	"self lineSegmentsDo: [:line | (line lineSegmentDistanceFromPoint: aJun3dPoint)
			< self class accuracy ifTrue: [^true]]."
	^self parameterPolygon absContainsPoint: (self parameterPointAtPoint: aJun3dPoint)
]

{ #category : #functions }
Jun3dPolygon >> distanceFromPoint: aJun3dPoint [ 
	^(self nearestPointFromPoint: aJun3dPoint)
		distance: aJun3dPoint
]

{ #category : #comparing }
Jun3dPolygon >> equal: aPolygon [ 
	(super equal: aPolygon) ifFalse: [^false].
	^self parameterPolygon equal: aPolygon parameterPolygon
]

{ #category : #functions }
Jun3dPolygon >> intersectingPointWithLine: aJun3dLine [ 
	| intersectingPoint |
	intersectingPoint := super intersectingPointWithLine: aJun3dLine.
	intersectingPoint isNil ifTrue: [^nil].
	(self containsPoint: intersectingPoint)
		ifTrue: [^intersectingPoint].
	^nil
]

{ #category : #functions }
Jun3dPolygon >> intersectingPointWithLineSegment: aJun3dLine [ 
	(self boundingBox intersectsOrTouches: aJun3dLine boundingBox)
		ifTrue: 
			[| intersectingPoint |
			intersectingPoint := super intersectingPointWithLineSegment: aJun3dLine.
			intersectingPoint isNil ifTrue: [^nil].
			^(self containsPoint: intersectingPoint)
				ifTrue: [intersectingPoint]
				ifFalse: [nil]]
		ifFalse: [^nil]
]

{ #category : #functions }
Jun3dPolygon >> intersectingPointsWithCurve: aCurve [ 
	| point |
	point := self intersectingPointWithLineSegment: aCurve.
	^point notNil
		ifTrue: [Array with: point]
		ifFalse: [Array new]
]

{ #category : #testing }
Jun3dPolygon >> isConsistent [
	^self parameterPolygon isConsistent
]

{ #category : #testing }
Jun3dPolygon >> isConvex [
	^self parameterPolygon absIsConvex
]

{ #category : #testing }
Jun3dPolygon >> isPolygon [
	^true
]

{ #category : #enumerating }
Jun3dPolygon >> lineSegmentsDo: aBlock [ 
	1 to: self numberOfPoints do: [:index | aBlock value: (Jun3dLine from: (self pointAt: index)
				to: (self pointAt: index \\ self numberOfPoints + 1))]
]

{ #category : #functions }
Jun3dPolygon >> nearestPointFromPoint: aJun3dPoint [ 
	"(Jun3dPolygon 
	with: 0.5d , 0.0d , 1.0d 
	with: 0.0d , 0.0d , 1.0d 
	with: 0.0d , 0.5d , 1.0d) 
	nearestPointFromPoint: 0.0d , 1.0d , 0.5d"

	^self pointAtParameterPoint: (self parameterPolygon asPositivePolygon 
				nearestPointFromPoint: (self parameterPointAtPoint: aJun3dPoint))
]

{ #category : #accessing }
Jun3dPolygon >> normalVector [
	normalVector isNil ifTrue: [normalVector := self preferredNormalVector].
	^normalVector
]

{ #category : #accessing }
Jun3dPolygon >> numberOfPoints [
	^self pointsSize
]

{ #category : #accessing }
Jun3dPolygon >> origin [
	^p1
]

{ #category : #private }
Jun3dPolygon >> parameterArea [
	^self parameterPolygon area
]

{ #category : #enumerating }
Jun3dPolygon >> parameterLineSegmentsDo: aBlock [ 
	1 to: self numberOfPoints do: [:index | aBlock value: (Jun2dLine from: (self parameterPointAt: index)
				to: (self parameterPointAt: index \\ self numberOfPoints + 1))]
]

{ #category : #accessing }
Jun3dPolygon >> parameterPointAt: anInteger [ 
	^self parameterPolygon pointAt: anInteger
]

{ #category : #accessing }
Jun3dPolygon >> parameterPointAtPoint: aPoint [ 
	| thePoint uVector vVector u v |
	thePoint := (Jun3dPoint coerce: aPoint)
				- p1.
	uVector := self uVector.
	vVector := self vVector.
	u := (uVector dotProduct: thePoint)
				/ (uVector dotProduct: uVector).
	v := (vVector dotProduct: thePoint)
				/ (vVector dotProduct: vVector).
	^u , v
]

{ #category : #enumerating }
Jun3dPolygon >> parameterPointsDo: aBlock [ 
	1 to: self numberOfPoints do: [:index | aBlock value: (self parameterPointAt: index)]
]

{ #category : #accessing }
Jun3dPolygon >> parameterPolygon [
	^parameterPolygon
]

{ #category : #'lisp support' }
Jun3dPolygon >> parameterPolygonToLispList [
	| list |
	list := self lispCons.
	list head: #parameterPolygon.
	list tail: self parameterPolygon toLispList.
	^list
]

{ #category : #accessing }
Jun3dPolygon >> pointAt: anInteger [
	"^points at: anInteger"
	^self pointAtParameterPoint: (self parameterPolygon pointAt: anInteger)
]

{ #category : #accessing }
Jun3dPolygon >> pointAtParameterPoint: aJun2dPoint [ 
	^self pointAtU: aJun2dPoint x v: aJun2dPoint y
]

{ #category : #accessing }
Jun3dPolygon >> pointAtU: u v: v [
	^self p1 + (self uVector * u)  + (self vVector * v)
]

{ #category : #accessing }
Jun3dPolygon >> points [
	^(1 to: self pointsSize) collect: [:index | self pointAt: index]
]

{ #category : #enumerating }
Jun3dPolygon >> pointsDo: aBlock [ 
	1 to: self pointsSize do: [:index | aBlock value: (self pointAt: index)]
]

{ #category : #accessing }
Jun3dPolygon >> pointsSize [
	^self parameterPolygon pointsSize
]

{ #category : #'bounds access' }
Jun3dPolygon >> preferredBoundingBox [
	| minX minY minZ maxX maxY maxZ |
	minX := nil.
	minY := nil.
	minZ := nil.
	maxX := nil.
	maxY := nil.
	maxZ := nil.
	self
		pointsDo: 
			[:p | 
			minX == nil
				ifTrue: [minX := p x]
				ifFalse: [minX := minX min: p x].
			minY == nil
				ifTrue: [minY := p y]
				ifFalse: [minY := minY min: p y].
			minZ == nil
				ifTrue: [minZ := p z]
				ifFalse: [minZ := minZ min: p z].
			maxX == nil
				ifTrue: [maxX := p x]
				ifFalse: [maxX := maxX max: p x].
			maxY == nil
				ifTrue: [maxY := p y]
				ifFalse: [maxY := maxY max: p y].
			maxZ == nil
				ifTrue: [maxZ := p z]
				ifFalse: [maxZ := maxZ max: p z]].
	minX isNil ifTrue: [minX := 0].
	minY isNil ifTrue: [minY := 0].
	minZ isNil ifTrue: [minZ := 0].
	maxX isNil ifTrue: [maxX := 0].
	maxY isNil ifTrue: [maxY := 0].
	maxZ isNil ifTrue: [maxZ := 0].
	^Jun3dBoundingBox origin: minX , minY , minZ corner: maxX , maxY , maxZ
]

{ #category : #private }
Jun3dPolygon >> preferredNormalVector [
	| vector |
	vector := Jun3dPoint zero.
	1 to: self pointsSize
		do: 
			[:index | 
			| point1 point2 point3 |
			point1 := self pointAt: index.
			point2 := self pointAt: index \\ self pointsSize + 1.
			point3 := self pointAt: index + 1 \\ self pointsSize + 1.
			vector := vector + (point2 - point1 vectorProduct: point3 - point2)].
	^vector unitVector
]

{ #category : #printing }
Jun3dPolygon >> printOn: aStream [ 
	self storeOn: aStream
]

{ #category : #converting }
Jun3dPolygon >> reversed [
	^self class vertexes: self points reverse
]

{ #category : #private }
Jun3dPolygon >> setParameterPolygon: aJun2dPolygon [ 
	| pPolygon |
	aJun2dPolygon isPositive 
		ifTrue: [pPolygon := aJun2dPolygon]
		ifFalse: 
			[| oldP2 oldP3 |
			pPolygon := aJun2dPolygon transposed.
			oldP2 := p2.
			oldP3 := p3.
			p2 := oldP3.
			p3 := oldP2].
	parameterPolygon := pPolygon.
	boundingBox := nil.
	normalVector := nil
]

{ #category : #printing }
Jun3dPolygon >> storeOn: aStream [ 
	
	[| aString |
	aString := self toLispList saveString.
	aStream nextPutAll: '('.
	aStream nextPutAll: self class printString.
	aStream nextPutAll: ' fromString: '.
	aString storeOn: aStream.
	aStream nextPutAll: ')'] 
			on: self errorSignal
			do: [:exception | super storeOn: aStream]
]

{ #category : #'lisp support' }
Jun3dPolygon >> toLispList [
	"self showLispList: ((Jun3dPolygon examplePolygon) toLispList)."

	| list |
	list := super toLispList.
	list add: self parameterPolygonToLispList.
	^list
]

{ #category : #accessing }
Jun3dPolygon >> uVector [
	^p2 - p1
]

{ #category : #accessing }
Jun3dPolygon >> vVector [
	^p3 - p1
]

{ #category : #testing }
Jun3dPolygon >> whichSideOf: aPlane [ 
	| anArray hasPlus hasMinus hasZero |
	anArray := self points collect: [:aPoint | aPoint whichSideOf: aPlane].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

"
Imported by VwImportClass
"
Class {
	#name : #Jun2dPolygon,
	#superclass : #JunGeometry,
	#instVars : [
		'points',
		'signedArea',
		'bounds'
	],
	#category : #'Jun-Geometry-Surfaces'
}

{ #category : #'geometric functions' }
Jun2dPolygon class >> areaForPoints: anArrayOfPoint [ 
	^(self signedAreaForPoints: anArrayOfPoint) abs
]

{ #category : #'geometric functions' }
Jun2dPolygon class >> areaForTriangle: aPoint1 and: aPoint2 and: aPoint3 [ 
	^(self
		signedAreaForTriangle: aPoint1
		and: aPoint2
		and: aPoint3) abs
]

{ #category : #copyright }
Jun2dPolygon class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun2dPolygon class >> example1 [
	"Jun2dPolygon example1."

	| points |
	points := Array 
				with: 0 , 0
				with: 2 , 0
				with: 2 , 2
				with: 0 , 2.
	^Jun2dPolygon points: points
]

{ #category : #examples }
Jun2dPolygon class >> example2 [
	"Jun2dPolygon example2."

	| points |
	points := Array new: 5.
	points at: 1 put: 0 , 0.
	points at: 2 put: 2 , 0.
	points at: 3 put: 2 , 2.
	points at: 4 put: 1 , 1.
	points at: 5 put: 0 , 2.
	^Jun2dPolygon points: points
]

{ #category : #examples }
Jun2dPolygon class >> example3 [
	"Jun2dPolygon example3."

	| points |
	points := Array new: 5.
	points at: 1 put: 0 , 2.
	points at: 2 put: 0 , 0.
	points at: 3 put: 3 , 0.
	points at: 4 put: 3 , 2.
	points at: 5 put: 2 , 1.
	^Jun2dPolygon points: points
]

{ #category : #examples }
Jun2dPolygon class >> example4 [
	"Jun2dPolygon example4."

	| points |
	points := Array new: 5.
	points at: 1 put: 0 , 0.
	points at: 2 put: 2 , 0.
	points at: 3 put: 2 , 2.
	points at: 4 put: 0 , 2.
	points at: 5 put: 1 , 1.
	^Jun2dPolygon points: points
]

{ #category : #'lisp support' }
Jun2dPolygon class >> fromTable: aTable for: aPolygon [ 
	"Jun2dPolygon fromLispList: ((Jun2dPolygon example3) toLispList)."

	self pointsFromTable: aTable for: aPolygon.
	^aPolygon
]

{ #category : #private }
Jun2dPolygon class >> isConsistentPolygonFromPoints: anArrayOfJun2dPoint [ 
	| size isConcaveBlock isConvexBlock containsBlock points |
	points := (self points: anArrayOfJun2dPoint) asPositivePolygon points.
	size := points size.
	isConcaveBlock := 
			[:index | 
			| p1 p2 p3 |
			p1 := points at: index - 2 \\ size + 1.
			p2 := points at: index.
			p3 := points at: index \\ size + 1.
			(self
				signedAreaForTriangle: p1
				and: p2
				and: p3)
				<= self accuracy negated].
	isConvexBlock := 
			[:index | 
			| p1 p2 p3 |
			p1 := points at: index - 2 \\ size + 1.
			p2 := points at: index.
			p3 := points at: index \\ size + 1.
			(self
				signedAreaForTriangle: p1
				and: p2
				and: p3)
				>= self accuracy].
	containsBlock := 
			[:index | 
			| point ps |
			point := points at: index.
			ps := points reject: [ :p |  p = point "(point distance: p) < self accuracy"].
			self polygonFromPoints: ps containsPoint: point].
	1 to: size
		do: 
			[:index | 
			((isConcaveBlock value: index)
				and: [(containsBlock value: index) not])
				ifTrue: [^false].
			((isConvexBlock value: index)
				and: [containsBlock value: index])
				ifTrue: [^false]].
	^true
]

{ #category : #'instance creation' }
Jun2dPolygon class >> points: anArrayOfPoint [ 
	| boundary |
	boundary := self new.
	boundary setPoints: anArrayOfPoint.
	^boundary
]

{ #category : #'lisp support' }
Jun2dPolygon class >> pointsFromTable: aTable for: aPolygon [ 
	| pointsList |
	pointsList := aTable at: #points ifAbsent: [^aPolygon].
	aPolygon setPoints: (pointsList 
				collect: [:aList | self pointClass fromLispList: aList]).
	^aPolygon
]

{ #category : #private }
Jun2dPolygon class >> polygonFromPoints: anArrayOfPoint containsPoint: aPoint [ 
	| size point around |
	size := anArrayOfPoint size.
	point := Jun2dPoint coerce: aPoint.
	around := (1 to: size)
				inject: 0.0d
				into: 
					[:sum :index | 
					| p1 p2 |
					p1 := anArrayOfPoint at: index.
					p2 := anArrayOfPoint at: index \\ size + 1.
					(point angleBetween: p1 and: p2)
						+ sum].
	^around abs > (Double pi / 4.0d)
]

{ #category : #'geometric functions' }
Jun2dPolygon class >> signedAreaForPoints: anArrayOfPoint [ 
	| size |
	size := anArrayOfPoint size.
	^((1 to: size)
		inject: 0.0d
		into: 
			[:area :index | 
			| p1 p2 |
			p1 := anArrayOfPoint at: index.
			p2 := anArrayOfPoint at: index \\ size + 1.
			p1 y asDouble + p2 y asDouble * (p1 x asDouble - p2 x asDouble) + area])
		/ 2
]

{ #category : #'geometric functions' }
Jun2dPolygon class >> signedAreaForTriangle: aPoint1 and: aPoint2 and: aPoint3 [ 
	^aPoint1 y asDouble + aPoint2 y asDouble * (aPoint1 x asDouble - aPoint2 x asDouble) + (aPoint2 y asDouble + aPoint3 y asDouble * (aPoint2 x asDouble - aPoint3 x asDouble)) + (aPoint3 y asDouble + aPoint1 y asDouble * (aPoint3 x asDouble - aPoint1 x asDouble)) / 2
]

{ #category : #copyright }
Jun2dPolygon class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun2dPolygon class >> version [
	^'799'
]

{ #category : #'instance creation' }
Jun2dPolygon class >> vertexes: anArrayOfJun2dPoint [
	^self points: anArrayOfJun2dPoint
]

{ #category : #'instance creation' }
Jun2dPolygon class >> vertices: anArrayOfJun2dPoint [
	^self points: anArrayOfJun2dPoint
]

{ #category : #comparing }
Jun2dPolygon >> = aPolygon [ 
	| size |
	self class == aPolygon class ifFalse: [^false].
	(size := self points size) = aPolygon points size ifFalse: [^false].
	1 to: size
		do: [:index | (self points at: index) = (aPolygon points at: index) ifFalse: [^false]].
	^true
]

{ #category : #testing }
Jun2dPolygon >> absContainsLineSegment: aJun2dLine [ 
	^self absContainsLineSegmentFrom: aJun2dLine from to: aJun2dLine to
]

{ #category : #testing }
Jun2dPolygon >> absContainsLineSegmentFrom: aJun2dPoint1 to: aJun2dPoint2 [ 
	| tBlock intersectingTs from to dx dy |
	from := aJun2dPoint1.
	to := aJun2dPoint2.
	dx := to x - from x.
	dy := to y - from x.
	tBlock := 
			[:point1 :point2 | 
			| pdx pdy d |
			pdx := point2 x - point1 x.
			pdy := point2 y - point1 y.
			d := pdx * dy - (dx * pdy).
			d < self class accuracy 
				ifTrue: [nil]
				ifFalse: [(pdx * (point1 y - from y) - (pdy * (point1 x - from x))) / d]].
	intersectingTs := OrderedCollection with: 0.0d with: 1.0d.
	self edgesDo: 
			[:p1 :p2 | 
			| t |
			t := tBlock value: p1 value: p2.
			(t notNil and: [0.0d < t and: [t < 1.0d]]) ifTrue: [intersectingTs add: t]].
	intersectingTs := intersectingTs asSortedCollection.
	intersectingTs size = 2 ifTrue: [^self absContainsPoint: (from + to) / 2].
	1 to: intersectingTs size - 1
		do: 
			[:index | 
			| t1 t2 t intersectingPoint |
			t1 := intersectingTs at: index.
			t2 := intersectingTs at: index + 1.
			t := (t1 + t2) / 2.0d.
			intersectingPoint := (to - from) * t + from.
			(self absContainsPoint: intersectingPoint) ifFalse: [^false]].
	^true
]

{ #category : #testing }
Jun2dPolygon >> absContainsPoint: aPoint [ 
	| x y count |
	(self boundingBox containsOrTouchesPoint: aPoint)
		ifFalse: [^false].
	x := aPoint x.
	y := aPoint y.
	count := 0.
	self
		edgesDo: 
			[:p1 :p2 | 
			| point1 point2 |
			((p1 x - aPoint x) abs < self class accuracy and: [(p1 y - aPoint y) abs < self class accuracy])
				ifTrue: [^true].
			p1 x <= p2 x
				ifTrue: 
					[point1 := p1.
					point2 := p2]
				ifFalse: 
					[point1 := p2.
					point2 := p1].
			(point1 x <= x and: [x < point2 x])
				ifTrue: 
					[| y0 |
					y0 := x - point1 x / (point2 x - point1 x) * (point2 y - point1 y) + point1 y.
					(y0 - aPoint y) abs < self class accuracy ifTrue: [^true].
					y0 >= y ifTrue: [count := count + 1]]].
	^count odd
]

{ #category : #testing }
Jun2dPolygon >> absIsConvex [
	^self asPositivePolygon isConvex
]

{ #category : #accessing }
Jun2dPolygon >> area [
	^self signedArea abs
]

{ #category : #converting }
Jun2dPolygon >> asArrayOfConvexPolygons [
	| polygons |
	polygons := Array new writeStream.
	self asConvexPolygonsDo: [:polygon | polygons nextPut: polygon].
	^polygons contents
]

{ #category : #converting }
Jun2dPolygon >> asArrayOfLines [
	"(Jun2dPolygon points: (Array 
				with: 0 , 0
				with: 2 , 0
				with: 2 , 2
				with: 0 , 2)) 
		asArrayOfLines."

	| collection polyline |
	collection := self points copy asOrderedCollection.
	(collection first equal: collection last) 
		ifFalse: [collection add: collection first].
	polyline := self polylineClass vertexes: collection.
	^polyline asArrayOfLines
]

{ #category : #converting }
Jun2dPolygon >> asArrayOfPoints [
	^Array withAll: self points
]

{ #category : #enumerating }
Jun2dPolygon >> asConvexPolygonsDo: aBlock [ 
	| concaveIndex concavePoint divisionVector divisionIndex divisionPoint newPoints1 newPoints2 |
	self isNegative ifTrue: [^self asPositivePolygon asConvexPolygonsDo: [:polygon | aBlock value: polygon asNegativePolygon]].
	self isConvex
		ifTrue: 
			[aBlock value: self.
			^self].
	concaveIndex := self indexOfFirstConcaveVertex.
	concavePoint := self pointAt: concaveIndex.
	divisionVector := (concavePoint - (self pointAt: concaveIndex - 2 \\ self pointsSize + 1)) unitVector + (concavePoint - (self pointAt: concaveIndex \\ self pointsSize + 1)) unitVector.
	divisionVector x abs > divisionVector y abs
		ifTrue: [divisionVector x > 0
				ifTrue: 
					[| minPoint minIndex |
					minPoint := minIndex := nil.
					concaveIndex to: concaveIndex + self pointsSize - 3
						do: 
							[:index | 
							| p1 p2 |
							p1 := self pointAt: index \\ self pointsSize + 1.
							p2 := self pointAt: index + 1 \\ self pointsSize + 1.
							(p1 y < p2 y and: [p1 y < concavePoint y and: [p2 y >= concavePoint y]])
								ifTrue: 
									[| x |
									x := concavePoint y - p1 y * (p2 x - p1 x) / (p2 y - p1 y) + p1 x.
									(concavePoint x < x and: [minPoint isNil or: [x <= minPoint x]])
										ifTrue: 
											[minPoint := x , concavePoint y.
											minIndex := index \\ self pointsSize + 1]]].
					minIndex isNil ifTrue: [self halt].
					divisionIndex := minIndex.
					divisionPoint := minPoint]
				ifFalse: 
					[| maxPoint maxIndex |
					maxPoint := maxIndex := nil.
					concaveIndex to: concaveIndex + self pointsSize - 3
						do: 
							[:index | 
							| p1 p2 |
							p1 := self pointAt: index \\ self pointsSize + 1.
							p2 := self pointAt: index + 1 \\ self pointsSize + 1.
							(p1 y > p2 y and: [p1 y > concavePoint y and: [p2 y <= concavePoint y]])
								ifTrue: 
									[| x |
									x := concavePoint y - p1 y * (p2 x - p1 x) / (p2 y - p1 y) + p1 x.
									(concavePoint x > x and: [maxPoint isNil or: [x >= maxPoint x]])
										ifTrue: 
											[maxPoint := x , concavePoint y.
											maxIndex := index \\ self pointsSize + 1]]].
					maxIndex isNil ifTrue: [self halt].
					divisionIndex := maxIndex.
					divisionPoint := maxPoint]]
		ifFalse: [divisionVector y > 0
				ifTrue: 
					[| minPoint minIndex |
					minPoint := minIndex := nil.
					concaveIndex to: concaveIndex + self pointsSize - 3
						do: 
							[:index | 
							| p1 p2 |
							p1 := self pointAt: index \\ self pointsSize + 1.
							p2 := self pointAt: index + 1 \\ self pointsSize + 1.
							(p1 x > p2 x and: [p1 x > concavePoint x and: [p2 x <= concavePoint x]])
								ifTrue: 
									[| y |
									y := concavePoint x - p1 x * (p2 y - p1 y) / (p2 x - p1 x) + p1 y.
									(concavePoint y < y and: [minPoint isNil or: [y <= minPoint y]])
										ifTrue: 
											[minPoint := concavePoint x , y.
											minIndex := index \\ self pointsSize + 1]]].
					minIndex isNil ifTrue: [self halt].
					divisionIndex := minIndex.
					divisionPoint := minPoint]
				ifFalse: 
					[| maxPoint maxIndex |
					maxPoint := maxIndex := nil.
					concaveIndex to: concaveIndex + self pointsSize - 3
						do: 
							[:index | 
							| p1 p2 |
							p1 := self pointAt: index \\ self pointsSize + 1.
							p2 := self pointAt: index + 1 \\ self pointsSize + 1.
							(p1 x < p2 x and: [p1 x < concavePoint x and: [p2 x >= concavePoint x]])
								ifTrue: 
									[| y |
									y := concavePoint x - p1 x * (p2 y - p1 y) / (p2 x - p1 x) + p1 y.
									(concavePoint y > y and: [maxPoint isNil or: [y >= maxPoint y]])
										ifTrue: 
											[maxPoint := concavePoint x , y.
											maxIndex := index \\ self pointsSize + 1]]].
					maxIndex isNil ifTrue: [self halt].
					divisionIndex := maxIndex.
					divisionPoint := maxPoint]].
	newPoints1 := Array new writeStream.
	newPoints2 := Array new writeStream.
	divisionIndex < concaveIndex
		ifTrue: 
			[1 to: divisionIndex do: [:index | newPoints1 nextPut: (self pointAt: index)].
			divisionPoint ~= (self pointAt: divisionIndex) ifTrue: [newPoints1 nextPut: divisionPoint].
			concaveIndex to: self pointsSize do: [:index | newPoints1 nextPut: (self pointAt: index)].
			newPoints1 := newPoints1 contents.
			divisionPoint ~= (self pointAt: divisionIndex \\ self pointsSize + 1) ifTrue: [newPoints2 nextPut: divisionPoint].
			divisionIndex + 1 to: concaveIndex do: [:index | newPoints2 nextPut: (self pointAt: index)].
			newPoints2 := newPoints2 contents]
		ifFalse: 
			[1 to: concaveIndex do: [:index | newPoints1 nextPut: (self pointAt: index)].
			divisionPoint ~= (self pointAt: divisionIndex \\ self pointsSize + 1) ifTrue: [newPoints1 nextPut: divisionPoint].
			divisionIndex + 1 to: self pointsSize do: [:index | newPoints1 nextPut: (self pointAt: index)].
			newPoints1 := newPoints1 contents.
			concaveIndex to: divisionIndex do: [:index | newPoints2 nextPut: (self pointAt: index)].
			divisionPoint ~= (self pointAt: divisionIndex) ifTrue: [newPoints2 nextPut: divisionPoint].
			newPoints2 := newPoints2 contents].
	(self class points: newPoints1)
		asConvexPolygonsDo: aBlock.
	(self class points: newPoints2)
		asConvexPolygonsDo: aBlock
]

{ #category : #converting }
Jun2dPolygon >> asJunOpenGL3dObject [
	| polygons aBody |
	polygons := Array new writeStream.
	self asJunOpenGL3dObjectsDo: [:polygon | polygons nextPut: polygon].
	polygons := polygons contents.
	aBody := polygons size = 1 
				ifTrue: [polygons first]
				ifFalse: [JunOpenGL3dCompoundObject components: polygons].
	aBody objectsDo: [:object | object paint: self defaultColor alpha: nil].
	^aBody
]

{ #category : #enumerating }
Jun2dPolygon >> asJunOpenGL3dObjectsDo: aBlock [ 
	self
		asConvexPolygonsDo: 
			[:polygon | 
			| vertexes |
			vertexes := polygon points collect: [:p | Jun3dPoint
							x: p x
							y: p y
							z: 0.0d].
			aBlock value: (JunOpenGL3dPolygon vertexes: vertexes)]
]

{ #category : #converting }
Jun2dPolygon >> asNegativePolygon [
	^self signedArea <= 0
		ifTrue: [self]
		ifFalse: [self reversed]
]

{ #category : #converting }
Jun2dPolygon >> asPointArray [
	^points asArray
]

{ #category : #converting }
Jun2dPolygon >> asPositivePolygon [
	^self signedArea >= 0
		ifTrue: [self]
		ifFalse: [self reversed]
]

{ #category : #private }
Jun2dPolygon >> asPositivePolygon: aBoolean [ 
	^aBoolean
		ifTrue: [self asPositivePolygon]
		ifFalse: [self asNegativePolygon]
]

{ #category : #converting }
Jun2dPolygon >> asTriangles [
	| triangleStream |
	triangleStream := Array new writeStream.
	self asTrianglesDo: [:polygon | triangleStream nextPut: polygon].
	^triangleStream contents
]

{ #category : #enumerating }
Jun2dPolygon >> asTrianglesDo: aBlock [ 
	| isPositive voronoiProcessor |
	isPositive := self isPositive.
	voronoiProcessor := JunVoronoi2dProcessor dots: points asSet asArray.
	voronoiProcessor compute.
	voronoiProcessor triangles
		do: 
			[:pointArray | 
			| p1 p2 p3 |
			p1 := pointArray at: 1.
			p2 := pointArray at: 2.
			p3 := pointArray at: 3.
			((self class
				areaForTriangle: p1
				and: p2
				and: p3)
				> self class accuracy and: [self absContainsPoint: p1 + p2 + p3 / 3])
				ifTrue: 
					[| polygon |
					polygon := self class points: pointArray.
					aBlock value: (polygon asPositivePolygon: isPositive)]]
]

{ #category : #'bounds access' }
Jun2dPolygon >> boundingBox [
	bounds isNil
		ifTrue: 
			[| min max |
			min := max := points first.
			self
				pointsDo: 
					[:point | 
					min := min min: point.
					max := max max: point].
			bounds := Jun2dBoundingBox origin: min corner: max].
	^bounds
]

{ #category : #'truncation and round off' }
Jun2dPolygon >> ceiling [
	^self class points: (points collect: [:p | p ceiling])
]

{ #category : #testing }
Jun2dPolygon >> containsLineSegment: aJun2dLine [ 
	^(self absContainsLineSegment: aJun2dLine)
		xor: self isNegative
]

{ #category : #testing }
Jun2dPolygon >> containsLineSegmentFrom: aJun2dPoint1 to: aJun2dPoint2 [ 
	^(self absContainsLineSegmentFrom: aJun2dPoint1 to: aJun2dPoint2)
		xor: self isNegative
]

{ #category : #testing }
Jun2dPolygon >> containsPoint: aPoint [ 
	^(self absContainsPoint: aPoint) xor: self isNegative
]

{ #category : #copying }
Jun2dPolygon >> copyPointsFrom: anInteger1 to: anInteger2 [ 
	^points copyFrom: anInteger1 to: anInteger2
]

{ #category : #functions }
Jun2dPolygon >> crossPointsWithPolygon: aJun2dPolygon [ 
	| mySize yourSize pointStream |
	mySize := points size.
	yourSize := aJun2dPolygon pointsSize.
	pointStream := Array new writeStream.
	1 to: mySize
		do: 
			[:myIndex | 
			| myPoint1 myPoint2 myMinX myMinY myMaxX myMaxY myDt |
			myPoint1 := points at: myIndex.
			myPoint2 := points at: myIndex \\ mySize + 1.
			myMinX := myPoint1 x min: myPoint2 x.
			myMinY := myPoint1 y min: myPoint2 y.
			myMaxX := myPoint1 x max: myPoint2 x.
			myMaxY := myPoint1 y max: myPoint2 y.
			myDt := myPoint2 - myPoint1.
			1 to: yourSize
				do: 
					[:yourIndex | 
					| yourPoint1 yourPoint2 yourMinX yourMinY yourMaxX yourMaxY |
					yourPoint1 := aJun2dPolygon pointAt: yourIndex.
					yourPoint2 := aJun2dPolygon pointAt: yourSize + 1.
					yourMinX := yourPoint1 x min: yourPoint2 x.
					yourMinY := yourPoint1 y min: yourPoint2 y.
					yourMaxX := yourPoint1 x max: yourPoint2 x.
					yourMaxY := yourPoint1 y max: yourPoint2 y.
					(myMinX < yourMaxX and: [yourMinX < myMaxX and: [myMinY < yourMaxY and: [yourMinY < myMaxY]]])
						ifTrue: 
							[| yourDt denominator |
							yourDt := yourPoint2 - yourPoint1.
							denominator := yourDt x * myDt y - (myDt x * yourDt y).
							denominator abs > 0
								ifTrue: 
									[| t |
									t := yourDt x * (yourPoint1 y - myPoint1 y) - (yourDt y * (myPoint1 x - yourPoint2)) / denominator.
									(t > 0 and: [t < 1])
										ifTrue: [pointStream nextPut: myPoint1 + (myDt * t)]]]]].
	^pointStream contents
]

{ #category : #displaying }
Jun2dPolygon >> displayOn: gc [ 
	gc displayPolygon: (points collect: [:p | p x @ p y])
]

{ #category : #functions }
Jun2dPolygon >> distanceFromPoint: aPoint [ 
	| thePoint |
	thePoint := Jun2dPoint coerce: aPoint.
	^(self nearestPointFromPoint: thePoint)
		distance: thePoint
]

{ #category : #functions }
Jun2dPolygon >> distanceFromPolygon: aJun2dPolygon [ 
	| b minDistance |
	b := self boundingBox merge: aJun2dPolygon boundingBox.
	minDistance := (b width max: b height)
				* 2.
	self
		pointsDo: 
			[:myPoint | 
			| yourPoint distance |
			yourPoint := aJun2dPolygon nearestPointOnEdgeFromPoint: myPoint.
			distance := myPoint distance: yourPoint.
			minDistance > distance ifTrue: [minDistance := distance]].
	aJun2dPolygon
		pointsDo: 
			[:yourPoint | 
			| myPoint distance |
			myPoint := self nearestPointOnEdgeFromPoint: yourPoint.
			distance := myPoint distance: yourPoint.
			minDistance > distance ifTrue: [minDistance := distance]].
	^minDistance
]

{ #category : #enumerating }
Jun2dPolygon >> edgesDo: aBlock [ 
	| size |
	size := points size.
	1 to: size do: [:index | aBlock value: (points at: index)
			value: (points at: index \\ size + 1)]
]

{ #category : #comparing }
Jun2dPolygon >> equal: aPolygon [ 
	| size |
	self class == aPolygon class ifFalse: [^false].
	(size := self points size) = aPolygon points size ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self points at: index) equal: (aPolygon points at: index)) 
				ifFalse: [^false]].
	^true
]

{ #category : #'bounds access' }
Jun2dPolygon >> extent [
	^self boundingBox extent
]

{ #category : #'truncation and round off' }
Jun2dPolygon >> floor [
	^self class points: (points collect: [:p | p floor])
]

{ #category : #'bounds access' }
Jun2dPolygon >> height [
	^self extent y
]

{ #category : #private }
Jun2dPolygon >> indexOfFirstConcaveVertex [
	| pointsSize |
	pointsSize := self pointsSize.
	^(1 to: pointsSize)
		detect: 
			[:index | 
			| p1 p2 p3 |
			p1 := self pointAt: index - 2 \\ pointsSize + 1.
			p2 := self pointAt: index.
			p3 := self pointAt: index \\ pointsSize + 1.
			(self class
				signedAreaForTriangle: p1
				and: p2
				and: p3)
				< self class accuracy negated]
		ifNone: [nil]
]

{ #category : #testing }
Jun2dPolygon >> is2d [
	^true
]

{ #category : #private }
Jun2dPolygon >> isConsistent [
	^self class isConsistentPolygonFromPoints: self points
]

{ #category : #testing }
Jun2dPolygon >> isConvex [
	^self isPositive
		ifTrue: [self indexOfFirstConcaveVertex isNil]
		ifFalse: [self asPositivePolygon indexOfFirstConcaveVertex isNil]
]

{ #category : #testing }
Jun2dPolygon >> isNegative [
	^self isPositive not
]

{ #category : #testing }
Jun2dPolygon >> isPositive [
	^self signedArea >= self class accuracy negated
]

{ #category : #functions }
Jun2dPolygon >> nearestPointFromPoint: aPoint [ 
	^(self containsPoint: aPoint)
		ifTrue: [aPoint]
		ifFalse: [self nearestPointOnEdgeFromPoint: aPoint]
]

{ #category : #functions }
Jun2dPolygon >> nearestPointOnEdgeFromPoint: aPoint [ 
	| thePoint nearestPoint minDistance |
	thePoint := aPoint x , aPoint y.
	nearestPoint := nil.
	minDistance := nil.
	self edgesDo: [:point1 :point2 | point1 ~= point2
			ifTrue: 
				[| edge point distance |
				edge := Jun2dLine from: point1 to: point2.
				point := edge lineSegmentNearestPointFromPoint: thePoint.
				distance := thePoint distance: point.
				(minDistance isNil or: [minDistance > distance])
					ifTrue: 
						[minDistance := distance.
						nearestPoint := point]]].
	^nearestPoint
]

{ #category : #accessing }
Jun2dPolygon >> numberOfPoints [
	^self pointsSize
]

{ #category : #accessing }
Jun2dPolygon >> pointAt: anInteger [
	^points at: anInteger
]

{ #category : #accessing }
Jun2dPolygon >> points [
	^points
]

{ #category : #enumerating }
Jun2dPolygon >> pointsDo: aBlock [
	points do: aBlock
]

{ #category : #accessing }
Jun2dPolygon >> pointsSize [
	^points size
]

{ #category : #'lisp support' }
Jun2dPolygon >> pointsToLispList [
	| list |
	list := self lispCons.
	list head: #points.
	list tail: (self class defaultLispConsClass 
				list: (self points collect: [:p | p toLispList])).
	^list
]

{ #category : #copying }
Jun2dPolygon >> postCopy [
	super postCopy.
	points := points copy
]

{ #category : #converting }
Jun2dPolygon >> reversed [
	^self class points: points reverse
]

{ #category : #'truncation and round off' }
Jun2dPolygon >> rounded [
	^self class points: (points collect: [:p | p rounded])
]

{ #category : #'truncation and round off' }
Jun2dPolygon >> rounded: aNumber [ 
	^self class points: (points collect: [:p | p rounded: aNumber])
]

{ #category : #transforming }
Jun2dPolygon >> scaledBy: aNumber [ 
	^self class points: (points collect: [:p | p scaledBy: aNumber])
]

{ #category : #private }
Jun2dPolygon >> setPoints: anArrayOfPoint [ 
	| thePoints |
	thePoints := OrderedCollection new: anArrayOfPoint size.
	anArrayOfPoint do: [:point | thePoints addLast: point x , point y].
	signedArea := nil.
	bounds := nil.
	points := thePoints
]

{ #category : #private }
Jun2dPolygon >> show [
	^(JunOpenGL3dPolylineLoop vertexes: (points collect: [ :p | p , 0])) show
]

{ #category : #accessing }
Jun2dPolygon >> signedArea [
	signedArea isNil ifTrue: [ signedArea := self class signedAreaForPoints: points ].
	^signedArea
]

{ #category : #'lisp support' }
Jun2dPolygon >> toLispList [
	"self showLispList: ((Jun2dPolygon example3) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self pointsToLispList.
	^list
]

{ #category : #transforming }
Jun2dPolygon >> transform: aJun2dTransformation [ 
	^self class points: (points collect: [:p | aJun2dTransformation applyToPoint: p])
]

{ #category : #transforming }
Jun2dPolygon >> translatedBy: aNumber [ 
	^self class points: (points collect: [:p | p translatedBy: aNumber])
]

{ #category : #converting }
Jun2dPolygon >> transposed [
	^self class points: (points collect: [:p | p y , p x])
]

{ #category : #'truncation and round off' }
Jun2dPolygon >> truncated [
	^self class points: (points collect: [:p | p truncated])
]

{ #category : #'truncation and round off' }
Jun2dPolygon >> truncated: aNumber [
	^self class points: (points collect: [:p | p truncated: aNumber])
]

{ #category : #testing }
Jun2dPolygon >> whichSideOf: aLine [ 
	| anArray hasPlus hasMinus hasZero |
	anArray := self points collect: [:aPoint | aPoint whichSideOf: aLine].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

{ #category : #'bounds access' }
Jun2dPolygon >> width [
	^self extent x
]

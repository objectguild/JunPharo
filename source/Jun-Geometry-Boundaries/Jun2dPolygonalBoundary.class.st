"
Imported by VwImportClass
"
Class {
	#name : #Jun2dPolygonalBoundary,
	#superclass : #JunGeometry,
	#instVars : [
		'polygons',
		'bounds'
	],
	#category : #'Jun-Geometry-Boundaries'
}

{ #category : #copyright }
Jun2dPolygonalBoundary class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
Jun2dPolygonalBoundary class >> polygons: anArrayOfJun2dPolygon [ 
	^self new setPolygons: anArrayOfJun2dPolygon
]

{ #category : #'instance creation' }
Jun2dPolygonalBoundary class >> polygons: anArrayOfPolygon1 holes: anArrayOfPolygon2 [
	| boundary |
	boundary := self new.
	boundary setPolygons: anArrayOfPolygon1 holes: anArrayOfPolygon2.
	^boundary
]

{ #category : #private }
Jun2dPolygonalBoundary class >> sortingBlock [
	^[:more :less | more area > less area]
]

{ #category : #copyright }
Jun2dPolygonalBoundary class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun2dPolygonalBoundary class >> version [
	^'799'
]

{ #category : #private }
Jun2dPolygonalBoundary >> _polygonFrom: aJun2dPolygon withHoles: anArrayOfJun2dPolygon [ 
	| loops |
	loops := OrderedCollection new: anArrayOfJun2dPolygon size + 1.
	loops add: aJun2dPolygon points.
	anArrayOfJun2dPolygon do: [:hole | loops add: hole points].
	[loops size > 1]
		whileTrue: 
			[| loop maxYIndex maxYPoint minYPoint minYLoopIndex minYPointIndex minYLoop newLoop |
			loop := loops last.
			loops removeLast.
			maxYIndex := 1.
			maxYPoint := loop first.
			loop keysAndValuesDo: [:index :point | point y > maxYPoint y
					ifTrue: 
						[maxYPoint := point.
						maxYIndex := index]].
			minYPoint := minYLoopIndex := minYPointIndex := nil.
			loops
				keysAndValuesDo: 
					[:pairLoopIndex :pairLoop | 
					1 to: pairLoop size
						do: 
							[:index | 
							| p1 p2 |
							p1 := pairLoop at: index.
							p2 := pairLoop at: index \\ pairLoop size + 1.
							(p1 x > p2 x and: [p1 x > maxYPoint x and: [p2 x <= maxYPoint x]])
								ifTrue: 
									[| y |
									y := maxYPoint x - p1 x * (p2 y - p1 y) / (p2 x - p1 x) + p1 y.
									(maxYPoint y <= y and: [minYPoint isNil or: [y <= minYPoint y]])
										ifTrue: 
											[minYPoint := maxYPoint x , y.
											minYPointIndex := index.
											minYLoopIndex := pairLoopIndex]]]].
			minYPoint isNil ifTrue: [self halt].
			minYLoop := loops at: minYLoopIndex.
			loops removeAtIndex: minYLoopIndex.
			newLoop := Array new writeStream.
			1 to: maxYIndex do: [:index | newLoop nextPut: (loop at: index)].
			minYPoint ~= (minYLoop at: minYPointIndex \\ minYLoop size + 1) ifTrue: [newLoop nextPut: minYPoint].
			minYPointIndex + 1 to: minYLoop size do: [:index | newLoop nextPut: (minYLoop at: index)].
			1 to: minYPointIndex do: [:index | newLoop nextPut: (minYLoop at: index)].
			minYPoint ~= (minYLoop at: minYPointIndex) ifTrue: [newLoop nextPut: minYPoint].
			maxYIndex to: loop size do: [:index | newLoop nextPut: (loop at: index)].
			minYLoopIndex = 1
				ifTrue: [loops addFirst: newLoop contents]
				ifFalse: [loops addLast: newLoop contents]].
	^Jun2dPolygon points: loops first
]

{ #category : #adding }
Jun2dPolygonalBoundary >> add: aJun2dPolygon [ 
	polygons add: aJun2dPolygon
]

{ #category : #adding }
Jun2dPolygonalBoundary >> addHole: aJun2dPolygon [
	^self add: aJun2dPolygon asNegativePolygon
]

{ #category : #adding }
Jun2dPolygonalBoundary >> addPolygon: aJun2dPolygon [
	^self add: aJun2dPolygon asPositivePolygon
]

{ #category : #accessing }
Jun2dPolygonalBoundary >> area [
	^polygons inject: 0 into: [ :sum :polygon | sum + polygon signedArea ]
]

{ #category : #converting }
Jun2dPolygonalBoundary >> as3dPolygons [
	| polygonStream |
	polygonStream := Array new writeStream.
	self as3dPolygonsDo: [:polygon | polygonStream nextPut: polygon].
	^polygonStream contents
]

{ #category : #enumerating }
Jun2dPolygonalBoundary >> as3dPolygonsDo: aBlock [ 
	self asArrayOfPolygonsDo: [:polygon | aBlock value: (Jun3dPolygon points: (polygon points collect: [:p | p , 0]))]
]

{ #category : #converting }
Jun2dPolygonalBoundary >> asArrayOfConvexPolygons [
	| convexPolygons |
	convexPolygons := Array new writeStream.
	self asConvexPolygonsDo: [ :polygon | convexPolygons nextPut: polygon ].
	^convexPolygons contents
]

{ #category : #converting }
Jun2dPolygonalBoundary >> asArrayOfPolygons [
	| polygonStream |
	polygonStream := Array new writeStream.
	self asArrayOfPolygonsDo: [:polygon | polygonStream nextPut: polygon].
	^polygonStream contents
]

{ #category : #enumerating }
Jun2dPolygonalBoundary >> asArrayOfPolygonsDo: aBlock [ 
	| islands holes holesOfIslands |
	islands := Array new writeStream.
	holes := Array new writeStream.
	polygons do: [:polygon | polygon isPositive
			ifTrue: [islands nextPut: polygon]
			ifFalse: [holes nextPut: polygon]].
	islands := (islands contents asSortedCollection: [:less :more | less area < more area]) asArray.
	holes := holes contents.
	holesOfIslands := Dictionary new: islands size.
	islands do: [:island | holesOfIslands at: island put: OrderedCollection new].
	holes
		do: 
			[:hole | 
			| theIsland |
			theIsland := islands detect: [:island | island containsPoint: (hole pointAt: 1)]
						ifNone: [nil].
			theIsland notNil ifTrue: [(holesOfIslands at: theIsland)
					add: hole]].
	islands
		do: 
			[:island | 
			| holesOfTheIsland theIsland |
			holesOfTheIsland := holesOfIslands at: island.
			holesOfTheIsland isEmpty not
				ifTrue: [theIsland := self _polygonFrom: island withHoles: holesOfTheIsland]
				ifFalse: [theIsland := island].
			aBlock value: theIsland]
]

{ #category : #enumerating }
Jun2dPolygonalBoundary >> asConvexPolygonsDo: aBlock [ 
	"| islands holes holesOfIslands |
	islands := Array new writeStream.
	holes := Array new writeStream.
	polygons do: [:polygon | polygon isPositive
			ifTrue: [islands nextPut: polygon]
			ifFalse: [holes nextPut: polygon]].
	islands := (islands contents asSortedCollection: [:less :more | less area < more area]) asArray.
	holes := holes contents.
	holesOfIslands := Dictionary new: islands size.
	islands do: [:island | holesOfIslands at: island put: OrderedCollection new].
	holes
		do: 
			[:hole | 
			| theIsland |
			theIsland := islands detect: [:island | island containsPoint: (hole pointAt: 1)]
						ifNone: [nil].
			theIsland notNil ifTrue: [(holesOfIslands at: theIsland)
					add: hole]].
	islands
		do: 
			[:island | 
			| myHoles |
			myHoles := holesOfIslands at: island.
			myHoles isEmpty
				ifTrue: [island asConvexPolygonsDo: aBlock]
				ifFalse: 
					[| pointStream voronoiProcessor |
					pointStream := Array new writeStream.
					island pointsDo: [:point | pointStream nextPut: point].
					myHoles do: [:hole | hole pointsDo: [:point | pointStream nextPut: point]].
					voronoiProcessor := JunVoronoi2dProcessor dots: pointStream contents.
					voronoiProcessor compute.
					voronoiProcessor triangles
						do: 
							[:pointArray | 
							| p1 p2 p3 |
							p1 := pointArray at: 1.
							p2 := pointArray at: 2.
							p3 := pointArray at: 3.
							((Jun2dPolygon
								areaForTriangle: p1
								and: p2
								and: p3)
								> Jun2dPolygon accuracy and: [self containsPoint: (p1 + p2 / 2) + p3 / 2])
								ifTrue: [aBlock value: (Jun2dPolygon points: pointArray) asPositivePolygon]]]]"
	self asArrayOfPolygons do: [ :p | p asConvexPolygonsDo: aBlock ]
]

{ #category : #converting }
Jun2dPolygonalBoundary >> asJunOpenGL3dObject [
	| objectStream objects aBody |
	objectStream := Array new writeStream.
	self asJunOpenGL3dObjectsDo: [:obj | objectStream nextPut: obj].
	objects := objectStream contents.
	aBody := objects size = 1 
				ifTrue: [objects first]
				ifFalse: [JunOpenGL3dCompoundObject components: objects].
	aBody objectsDo: [:object | object paint: self defaultColor alpha: nil].
	^aBody
]

{ #category : #enumerating }
Jun2dPolygonalBoundary >> asJunOpenGL3dObjectsDo: aBlock [ 
	self asConvexPolygonsDo: [:polygon | aBlock value: polygon asJunOpenGL3dObject]
]

{ #category : #converting }
Jun2dPolygonalBoundary >> asPointArray [
	| points |
	points := Array new writeStream.
	self pointsDo: [:point | points nextPut: point].
	^points contents
]

{ #category : #converting }
Jun2dPolygonalBoundary >> asTriangles [
	| triangleStream |
	triangleStream := Array new writeStream.
	self trianglesDo: [:polygon | triangleStream nextPut: polygon].
	^triangleStream contents
]

{ #category : #'bounds access' }
Jun2dPolygonalBoundary >> boundingBox [
	bounds isNil
		ifTrue: 
			[| min max |
			min := max := polygons first pointAt: 1.
			self
				pointsDo: 
					[:point | 
					min := min min: point.
					max := max max: point].
			bounds := Jun2dBoundingBox origin: min corner: max].
	^bounds
]

{ #category : #testing }
Jun2dPolygonalBoundary >> containsPoint: aPoint [ 
	^(self boundingBox containsPoint: aPoint)
		and: 
			[| containingPolygon |
			containingPolygon := polygons asArray reverse detect: [:polygon | polygon absContainsPoint: aPoint]
						ifNone: [^false].
			containingPolygon isPositive]
]

{ #category : #displaying }
Jun2dPolygonalBoundary >> displayOn: gc [ 
	| image |
	image := gc medium asImage.
	polygons do: [:polygon | polygon isPositive
			ifTrue: [polygon displayOn: gc]
			ifFalse: 
				[| pixmap pixmapGc shape opaqueImage |
				pixmap := Pixmap extent: image extent.
				
				[pixmapGc := pixmap graphicsContext.
				pixmapGc paint: ColorValue white.
				pixmapGc displayRectangle: pixmap bounds.
				pixmapGc paint: ColorValue black.
				polygon displayOn: pixmapGc.
				shape := pixmap asImage convertToPalette: MappedPalette whiteBlack]
					ensure: [pixmap close].
				shape palette: CoveragePalette monoMaskPalette.
				opaqueImage := OpaqueImage figure: image shape: shape.	"image displayOn: gc"
				opaqueImage displayOn: gc]]
]

{ #category : #functions }
Jun2dPolygonalBoundary >> distanceFromPoint: aJun2dPoint [ 
	| minDistance |
	(self containsPoint: aJun2dPoint)
		ifTrue: [^0.0d].
	minDistance := (self boundingBox origin distance: self boundingBox corner)
				* 2.
	polygons reverseDo: [:polygon | minDistance := minDistance min: (aJun2dPoint distance: (polygon nearestPointOnEdgeFromPoint: aJun2dPoint))].
	^minDistance
]

{ #category : #comparing }
Jun2dPolygonalBoundary >> equal: aPolygonalBoundary [ 
	| size |
	self class == aPolygonalBoundary class ifFalse: [^false].
	(size := self polygons size) = aPolygonalBoundary polygons size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self polygons at: index) equal: (aPolygonalBoundary polygons at: index)) 
				ifFalse: [^false]].
	^true
]

{ #category : #'bounds access' }
Jun2dPolygonalBoundary >> extent [
	^self boundingBox extent
]

{ #category : #'bounds access' }
Jun2dPolygonalBoundary >> height [
	^self extent y
]

{ #category : #'initialize-release' }
Jun2dPolygonalBoundary >> initialize [
	polygons := SortedCollection sortBlock: self class sortingBlock
]

{ #category : #testing }
Jun2dPolygonalBoundary >> is2d [
	^true
]

{ #category : #testing }
Jun2dPolygonalBoundary >> isEmpty [
	^polygons isEmpty
]

{ #category : #enumerating }
Jun2dPolygonalBoundary >> pointsDo: aBlock [ 
	polygons do: [:polygon | polygon pointsDo: aBlock]
]

{ #category : #accessing }
Jun2dPolygonalBoundary >> polygons [
	^polygons
]

{ #category : #transforming }
Jun2dPolygonalBoundary >> scaledBy: aNumberOrPoint [ 
	| scale |
	scale := Jun2dPoint coerce: aNumberOrPoint.
	^scale x * scale y >= 0
		ifTrue: [self class polygons: (polygons collect: [:polygon | polygon scaledBy: scale])]
		ifFalse: [self class polygons: (polygons collect: [:polygon | (polygon scaledBy: scale) reversed])]
]

{ #category : #private }
Jun2dPolygonalBoundary >> setPolygons: anArrayOfPolygon1 [ 
	anArrayOfPolygon1 do: [:polygon | self add: polygon]
]

{ #category : #private }
Jun2dPolygonalBoundary >> setPolygons: anArrayOfPolygon1 holes: anArrayOfPolygon2 [ 
	anArrayOfPolygon1 do: [:polygon | self add: polygon asPositivePolygon].
	anArrayOfPolygon2 do: [:polygon | self add: polygon asNegativePolygon]
]

{ #category : #transforming }
Jun2dPolygonalBoundary >> translatedBy: aPoint [ 
	^self class polygons: (polygons collect: [:polygon | polygon translatedBy: aPoint])
]

{ #category : #enumerating }
Jun2dPolygonalBoundary >> trianglesDo: aBlock [ 
	| voronoiProcessor |
	voronoiProcessor := JunVoronoi2dProcessor dots: self asPointArray asSet asArray.
	voronoiProcessor compute.
	voronoiProcessor triangles
		do: 
			[:pointArray | 
			| p1 p2 p3 |
			p1 := pointArray at: 1.
			p2 := pointArray at: 2.
			p3 := pointArray at: 3.
			((Jun2dPolygon
				areaForTriangle: p1
				and: p2
				and: p3)
				> Jun2dPolygon accuracy and: [self containsPoint: p1 + p2 + p3 / 3])
				ifTrue: [aBlock value: (Jun2dPolygon points: pointArray) asPositivePolygon]]
]

{ #category : #testing }
Jun2dPolygonalBoundary >> whichSideOf: aLine [ 
	| anArray hasPlus hasMinus hasZero |
	anArray := self polygons collect: [:polygon | polygon whichSideOf: aLine].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

{ #category : #'bounds access' }
Jun2dPolygonalBoundary >> width [
	^self extent x
]

"
Imported by VwImportClass
"
Class {
	#name : #Jun2dBoundingBoxes,
	#superclass : #JunBoundingBoxes,
	#category : #'Jun-Geometry-Pluralities'
}

{ #category : #copyright }
Jun2dBoundingBoxes class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun2dBoundingBoxes class >> example1 [
	"Jun2dBoundingBoxes example1."

	| boundingBoxes compoundObject |
	boundingBoxes := Jun2dBoundingBoxes new.
	boundingBoxes add: (51 , 33 corner: 195 , 147).
	boundingBoxes add: (93 , 45 corner: 237 , 159).
	boundingBoxes add: (129 , 69 corner: 273 , 183).
	boundingBoxes add: (81 , 111 corner: 225 , 225).
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (boundingBoxes asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: ((boundingBoxes intersectionBoxes 
				asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.25) translatedBy: 0 , 0 , 200).
	compoundObject 
		add: ((boundingBoxes unionBoxes 
				asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.25) translatedBy: 0 , 0 , 400).
	compoundObject 
		add: ((boundingBoxes complementBoxes 
				asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.25) translatedBy: 0 , 0 , 600).
	compoundObject 
		add: ((boundingBoxes differenceBoxes 
				asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.25) translatedBy: 0 , 0 , 800).
	(compoundObject showIn: (200 @ 200 extent: 280 @ 500)) selectAll.
	^boundingBoxes
]

{ #category : #examples }
Jun2dBoundingBoxes class >> example2 [
	"Jun2dBoundingBoxes example2."

	| anObject boundingBoxes compoundObject |
	anObject := JunOpenGL3dObject torus.
	boundingBoxes := Jun2dBoundingBoxes fromObject: anObject maxPartition: 16.
	compoundObject := JunOpenGL3dCompoundObject with: (anObject
						paint: ColorValue magenta alpha: 0.75;
						yourself)
				with: (boundingBoxes asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject show.
	^boundingBoxes
]

{ #category : #examples }
Jun2dBoundingBoxes class >> example3 [
	"Jun2dBoundingBoxes example3."

	| randomStream pointCollection boundingBoxes compoundObject |
	randomStream := JunRandomStream new.
	pointCollection := (1 to: 100) 
				collect: [:index | Jun2dPoint x: randomStream next y: randomStream next].
	boundingBoxes := Jun2dBoundingBoxes fromPoints: pointCollection
				maxPartition: 10.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		addAll: (pointCollection collect: 
					[:aPoint | 
					(JunOpenGL3dVertex point: aPoint , 0)
						size: 4;
						paint: ColorValue blue]).
	compoundObject 
		add: (boundingBoxes asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject show.
	^boundingBoxes
]

{ #category : #examples }
Jun2dBoundingBoxes class >> example4 [
	"Jun2dBoundingBoxes example4."

	| pointCollection boundingBoxes centerPoint compoundObject |
	pointCollection := Jun2dBoundingBoxes examplePoints.
	boundingBoxes := Jun2dBoundingBoxes fromPolyline: pointCollection
				bitSize: 16 @ 16.
	centerPoint := boundingBoxes boundingBox center.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: ((JunOpenGL3dPolyline 
				vertexes: (pointCollection collect: [:p | p x , p y , 0]))
				paint: ColorValue red;
				yourself).
	compoundObject 
		add: (boundingBoxes asJunOpenGL3dObjectColor: ColorValue orange alpha: 0.5).
	compoundObject 
		showEyePoint: centerPoint x , centerPoint y , 10000
		sightPoint: centerPoint
		upVector: 0 , 1 , 0.
	^boundingBoxes
]

{ #category : #examples }
Jun2dBoundingBoxes class >> examplePoints [
	"Jun2dBoundingBoxes examplePoints."

	^(OrderedCollection new)
		add: 272 @ 175;
		add: 281 @ 179;
		add: 293 @ 183;
		add: 302 @ 183;
		add: 314 @ 187;
		add: 328 @ 191;
		add: 342 @ 196;
		add: 352 @ 200;
		add: 362 @ 204;
		add: 373 @ 211;
		add: 383 @ 219;
		add: 389 @ 227;
		add: 392 @ 238;
		add: 396 @ 251;
		add: 396 @ 265;
		add: 394 @ 277;
		add: 388 @ 293;
		add: 383 @ 305;
		add: 374 @ 315;
		add: 362 @ 320;
		add: 348 @ 323;
		add: 337 @ 321;
		add: 325 @ 315;
		add: 320 @ 305;
		add: 319 @ 290;
		add: 321 @ 276;
		add: 326 @ 263;
		add: 332 @ 253;
		add: 340 @ 247;
		add: 351 @ 240;
		add: 364 @ 232;
		add: 377 @ 228;
		add: 386 @ 222;
		add: 397 @ 215;
		add: 404 @ 209;
		add: 411 @ 200;
		add: 414 @ 193;
		add: 416 @ 187;
		add: 417 @ 178;
		add: 417 @ 171;
		add: 417 @ 162;
		add: 417 @ 154;
		add: 414 @ 147;
		add: 412 @ 144;
		add: 410 @ 140;
		add: 406 @ 137;
		add: 401 @ 134;
		add: 397 @ 131;
		add: 390 @ 130;
		add: 383 @ 132;
		add: 374 @ 135;
		add: 367 @ 140;
		add: 360 @ 145;
		add: 352 @ 155;
		add: 347 @ 163;
		add: 341 @ 171;
		add: 337 @ 181;
		add: 332 @ 195;
		add: 327 @ 205;
		add: 320 @ 215;
		add: 312 @ 228;
		add: 301 @ 242;
		add: 291 @ 248;
		add: 282 @ 251;
		add: 269 @ 254;
		add: 262 @ 253;
		add: 253 @ 250;
		add: 246 @ 243;
		add: 238 @ 236;
		add: 235 @ 228;
		add: 233 @ 219;
		add: 231 @ 209;
		add: 232 @ 201;
		add: 233 @ 196;
		add: 239 @ 188;
		add: 243 @ 182;
		add: 245 @ 178;
		add: 247 @ 176;
		add: 249 @ 174;
		add: 250 @ 174;
		add: 252 @ 173;
		yourself
]

{ #category : #'instance creation' }
Jun2dBoundingBoxes class >> fromObject: anObject maxPartition: partitionSize [ 
	| width height denominator point |
	width := anObject boundingBox width.
	height := anObject boundingBox height.
	denominator := width max: height.
	point := width / denominator , (height / denominator).
	point := point * partitionSize.
	point := point rounded.
	^self fromObject: anObject howMany: point
]

{ #category : #'instance creation' }
Jun2dBoundingBoxes class >> fromPoints: pointCollection maxPartition: partitionSize [ 
	| box width height denominator point |
	box := self boundingBoxClass fromPoints: pointCollection.
	width := box width.
	height := box height.
	denominator := width max: height.
	point := width / denominator , (height / denominator).
	point := point * partitionSize.
	point := point rounded.
	^self fromPoints: pointCollection howMany: point
]

{ #category : #'instance creation' }
Jun2dBoundingBoxes class >> fromPolyline: pointCollection [ 
	^self fromPolyline: pointCollection bitSize: 16 , 16
]

{ #category : #'instance creation' }
Jun2dBoundingBoxes class >> fromPolyline: pointCollection bitSize: bitSize [ 
	| boxes points dot box origin corner extent pixmap gc image boundingBoxes |
	boxes := self new.
	pointCollection isEmpty ifTrue: [^boxes].
	points := pointCollection collect: [:p | p x @ p y].
	dot := (bitSize x max: 0) , (bitSize y max: 0).
	dot x * dot y <= 0 ifTrue: [^boxes].
	box := points first extent: 0 @ 0.
	points do: [:p | box := box merge: (p x @ p y extent: 0 @ 0)].
	origin := box origin x , box origin y.
	corner := box corner x , box corner y.
	extent := (box extent roundTo: dot) // dot.
	extent := ((extent x max: 0) @ (extent y max: 0)) rounded.
	extent x * extent y <= 0 ifTrue: [^boxes].
	self 
		assert: [pixmap := Pixmap extent: box extent]
		do: 
			[gc := pixmap graphicsContext.
			gc paint: ColorValue white.
			gc displayRectangle: pixmap bounds.
			gc paint: ColorValue black.
			gc displayPolygon: pointCollection at: box origin negated.
			image := pixmap asImage.
			image := JunImageAdjuster adjust: image extent: extent.
			image := image convertToPalette: MappedPalette whiteBlack]
		ensure: [pixmap close].
	boxes add: (origin corner: corner).
	(0 to: image height - 1) do: 
			[:y | 
			(0 to: image width - 1) do: 
					[:x | 
					(image atX: x y: y) > 0 
						ifTrue: [boxes add: (origin + ((x , y) * dot) extent: dot)]]].
	boundingBoxes := self new.
	boundingBoxes 
		add: (box origin x , box origin y corner: box corner x , box corner y).
	boxes differenceBoxes do: [:each | boundingBoxes add: each].
	^boundingBoxes differenceBoxes
]

{ #category : #private }
Jun2dBoundingBoxes class >> makeBoxesFromObject: aBody howMany: aPoint [ 
	| bodyBoxes boundingBox thePoint howManyX howManyY boxWidth boxHeight zBitmapImage aBox boundingBoxes |
	bodyBoxes := self new.
	aBody polygonsDo: 
			[:aPolygon | 
			boundingBox := self boundingBoxClass 
						fromPoints: (aPolygon vertexes collect: [:p | p x , p y]).
			bodyBoxes add: boundingBox].
	thePoint := self pointClass coerce: aPoint.
	howManyX := thePoint x asInteger.
	howManyY := thePoint y asInteger.
	boundingBox := aBody boundingBox.
	boxWidth := boundingBox width / howManyX.
	boxHeight := boundingBox height / howManyY.
	zBitmapImage := Image 
				extent: howManyX @ howManyY
				depth: 1
				palette: MonoMappedPalette whiteBlack.
	(0 to: howManyY - 1) do: 
			[:yIndex | 
			(0 to: howManyX - 1) do: 
					[:xIndex | 
					aBox := self boundingBoxClass 
								origin: (boundingBox origin x , boundingBox origin y) 
										+ (boxWidth * xIndex , (boxHeight * yIndex))
								extent: boxWidth , boxHeight.
					(bodyBoxes 
						detect: [:each | (each intersects: aBox) or: [each touches: aBox]]
						ifNone: [nil]) notNil 
						ifTrue: 
							[zBitmapImage 
								atX: xIndex
								y: yIndex
								put: 1]
						ifFalse: 
							[zBitmapImage 
								atX: xIndex
								y: yIndex
								put: 0]]].
	boundingBoxes := self new.
	(0 to: howManyY - 1) do: 
			[:yIndex | 
			(0 to: howManyX - 1) do: 
					[:xIndex | 
					aBox := self boundingBoxClass 
								origin: (boundingBox origin x , boundingBox origin y) 
										+ (boxWidth * xIndex , (boxHeight * yIndex))
								extent: boxWidth , boxHeight.
					(zBitmapImage atX: xIndex y: yIndex) = 1 ifTrue: [boundingBoxes add: aBox]]].
	^boundingBoxes
]

{ #category : #private }
Jun2dBoundingBoxes class >> makeBoxesFromPoints: pointCollection howMany: aPoint [ 
	| thePoint howManyX howManyY boundingBox boxWidth boxHeight zBitmapImage aBox boundingBoxes |
	thePoint := self pointClass coerce: aPoint.
	howManyX := thePoint x asInteger.
	howManyY := thePoint y asInteger.
	boundingBox := self boundingBoxClass fromPoints: pointCollection.
	boxWidth := boundingBox width / howManyX.
	boxHeight := boundingBox height / howManyY.
	zBitmapImage := Image 
				extent: howManyX @ howManyY
				depth: 1
				palette: MonoMappedPalette whiteBlack.
	(0 to: howManyY - 1) do: 
			[:yIndex | 
			(0 to: howManyX - 1) do: 
					[:xIndex | 
					aBox := self boundingBoxClass 
								origin: (boundingBox origin x , boundingBox origin y) 
										+ (boxWidth * xIndex , (boxHeight * yIndex))
								extent: boxWidth , boxHeight.
					(pointCollection detect: [:each | aBox containsPoint: each] ifNone: [nil]) 
						notNil 
							ifTrue: 
								[zBitmapImage 
									atX: xIndex
									y: yIndex
									put: 1]
							ifFalse: 
								[zBitmapImage 
									atX: xIndex
									y: yIndex
									put: 0]]].
	boundingBoxes := self new.
	(0 to: howManyY - 1) do: 
			[:yIndex | 
			(0 to: howManyX - 1) do: 
					[:xIndex | 
					aBox := self boundingBoxClass 
								origin: (boundingBox origin x , boundingBox origin y) 
										+ (boxWidth * xIndex , (boxHeight * yIndex))
								extent: boxWidth , boxHeight.
					(zBitmapImage atX: xIndex y: yIndex) = 1 ifTrue: [boundingBoxes add: aBox]]].
	^boundingBoxes
]

{ #category : #copyright }
Jun2dBoundingBoxes class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun2dBoundingBoxes class >> version [
	^'799'
]

{ #category : #accessing }
Jun2dBoundingBoxes >> area [
	| area |
	area := 0.
	self do: [:boundingBox | area := area + boundingBox area].
	^area
]

{ #category : #testing }
Jun2dBoundingBoxes >> is2d [
	^true
]

{ #category : #subdividing }
Jun2dBoundingBoxes >> subdivide [
	"(((0 , 0 box: 1 , 1) asBoundingBoxes subdivide) showWithUnitArrows) wireframePresentation."

	^self subdivide4
]

{ #category : #subdividing }
Jun2dBoundingBoxes >> subdivide4 [
	"(((0 , 0 box: 1 , 1) asBoundingBoxes subdivide) showWithUnitArrows) wireframePresentation."

	| boundingBoxArray boundingBoxes |
	boundingBoxArray := Array new: self size * 4.
	self with: (0 to: self size - 1)
		do: 
			[:boundingBox :n | 
			| offset |
			boundingBoxes := boundingBox subdivide4 boundingBoxes.
			offset := n * 4.
			boundingBoxArray at: 1 + offset put: (boundingBoxes at: 1).
			boundingBoxArray at: 2 + offset put: (boundingBoxes at: 2).
			boundingBoxArray at: 3 + offset put: (boundingBoxes at: 3).
			boundingBoxArray at: 4 + offset put: (boundingBoxes at: 4)].
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes boundingBoxes: boundingBoxArray.
	^boundingBoxes
]

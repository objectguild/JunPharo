"
Imported by VwImportClass
"
Class {
	#name : #Jun3dBoundingBoxes,
	#superclass : #JunBoundingBoxes,
	#category : #'Jun-Geometry-Pluralities'
}

{ #category : #copyright }
Jun3dBoundingBoxes class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dBoundingBoxes class >> example1 [
	"Jun3dBoundingBoxes example1."

	| boundingBoxes compoundObject |
	boundingBoxes := Jun3dBoundingBoxes exampleBoundingBoxes.
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
Jun3dBoundingBoxes class >> example2 [
	"Jun3dBoundingBoxes example2."

	| anObject boundingBoxes compoundObject |
	anObject := JunOpenGL3dObject torus.
	boundingBoxes := Jun3dBoundingBoxes fromObject: anObject maxPartition: 16.
	compoundObject := JunOpenGL3dCompoundObject with: (anObject
						paint: ColorValue magenta alpha: 0.75;
						yourself)
				with: (boundingBoxes asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject show.
	^boundingBoxes
]

{ #category : #examples }
Jun3dBoundingBoxes class >> example3 [
	"Jun3dBoundingBoxes example3."

	| randomStream pointCollection boundingBoxes compoundObject |
	randomStream := JunRandomStream new.
	pointCollection := (1 to: 100) collect: 
					[:index | 
					Jun3dPoint 
						x: randomStream next
						y: randomStream next
						z: randomStream next].
	boundingBoxes := Jun3dBoundingBoxes fromPoints: pointCollection
				maxPartition: 10.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		addAll: (pointCollection collect: 
					[:aPoint | 
					(JunOpenGL3dVertex point: aPoint)
						size: 4;
						paint: ColorValue blue]).
	compoundObject 
		add: (boundingBoxes asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject show.
	^boundingBoxes
]

{ #category : #examples }
Jun3dBoundingBoxes class >> exampleBoundingBoxes [
	"Jun3dBoundingBoxes exampleBoundingBoxes."

	| boundingBoxes |
	boundingBoxes := Jun3dBoundingBoxes new.
	boundingBoxes add: (51 , 33 , 0 corner: 195 , 147 , 80).
	boundingBoxes add: (93 , 45 , 20 corner: 237 , 159 , 100).
	boundingBoxes add: (129 , 69 , 40 corner: 273 , 183 , 120).
	boundingBoxes add: (81 , 111 , 60 corner: 225 , 225 , 140).
	^boundingBoxes
]

{ #category : #'instance creation' }
Jun3dBoundingBoxes class >> fromObject: anObject maxPartition: partitionSize [ 
	| width height depth denominator point |
	width := anObject boundingBox width.
	height := anObject boundingBox height.
	depth := anObject boundingBox depth.
	denominator := width max: (height max: depth).
	point := width / denominator , (height / denominator) 
				, (depth / denominator).
	point := point * partitionSize.
	point := point rounded.
	^self fromObject: anObject howMany: point
]

{ #category : #'instance creation' }
Jun3dBoundingBoxes class >> fromPoints: pointCollection maxPartition: partitionSize [ 
	| box width height depth denominator point |
	box := self boundingBoxClass fromPoints: pointCollection.
	width := box width.
	height := box height.
	depth := box depth.
	denominator := width max: (height max: depth).
	point := width / denominator , (height / denominator) 
				, (depth / denominator).
	point := point * partitionSize.
	point := point rounded.
	^self fromPoints: pointCollection howMany: point
]

{ #category : #private }
Jun3dBoundingBoxes class >> makeBoxesFromObject: aBody howMany: aPoint [ 
	| bodyBoxes boundingBox thePoint howManyX howManyY howManyZ boxWidth boxHeight boxDepth zBitmapArray zBitmapImage xBitmapArray xBitmapImage yBitmapArray yBitmapImage aBox boundingBoxes |
	bodyBoxes := self new.
	aBody polygonsDo: 
			[:aPolygon | 
			boundingBox := self boundingBoxClass fromPoints: aPolygon vertexes.
			bodyBoxes add: boundingBox].
	thePoint := self pointClass coerce: aPoint.
	howManyX := thePoint x asInteger.
	howManyY := thePoint y asInteger.
	howManyZ := thePoint z asInteger.
	boundingBox := aBody boundingBox.
	boxWidth := boundingBox width / howManyX.
	boxHeight := boundingBox height / howManyY.
	boxDepth := boundingBox depth / howManyZ.
	zBitmapArray := Array new: howManyZ.
	(0 to: howManyZ - 1) do: 
			[:zIndex | 
			zBitmapImage := Image 
						extent: howManyX @ howManyY
						depth: 1
						palette: MonoMappedPalette whiteBlack.
			zBitmapArray at: zIndex + 1 put: zBitmapImage].
	xBitmapArray := Array new: howManyX.
	(0 to: howManyX - 1) do: 
			[:xIndex | 
			xBitmapImage := Image 
						extent: howManyY @ howManyZ
						depth: 1
						palette: MonoMappedPalette whiteBlack.
			xBitmapArray at: xIndex + 1 put: xBitmapImage].
	yBitmapArray := Array new: howManyY.
	(0 to: howManyY - 1) do: 
			[:yIndex | 
			yBitmapImage := Image 
						extent: howManyZ @ howManyX
						depth: 1
						palette: MonoMappedPalette whiteBlack.
			yBitmapArray at: yIndex + 1 put: yBitmapImage].
	(0 to: howManyZ - 1) do: 
			[:zIndex | 
			zBitmapImage := zBitmapArray at: zIndex + 1.
			(0 to: howManyY - 1) do: 
					[:yIndex | 
					yBitmapImage := yBitmapArray at: yIndex + 1.
					(0 to: howManyX - 1) do: 
							[:xIndex | 
							xBitmapImage := xBitmapArray at: xIndex + 1.
							aBox := self boundingBoxClass origin: boundingBox origin 
												+ (boxWidth * xIndex , (boxHeight * yIndex) , (boxDepth * zIndex))
										extent: boxWidth , boxHeight , boxDepth.
							(bodyBoxes 
								detect: [:each | (each intersects: aBox) or: [each touches: aBox]]
								ifNone: [nil]) notNil 
								ifTrue: 
									[zBitmapImage 
										atX: xIndex
										y: yIndex
										put: 1.
									xBitmapImage 
										atX: yIndex
										y: zIndex
										put: 1.
									yBitmapImage 
										atX: zIndex
										y: xIndex
										put: 1]
								ifFalse: 
									[zBitmapImage 
										atX: xIndex
										y: yIndex
										put: 0.
									xBitmapImage 
										atX: yIndex
										y: zIndex
										put: 0.
									yBitmapImage 
										atX: zIndex
										y: xIndex
										put: 0]]]].
	(0 to: howManyZ - 1) do: 
			[:zIndex | 
			zBitmapImage := self makeBitmap: (zBitmapArray at: zIndex + 1).
			zBitmapArray at: zIndex + 1 put: zBitmapImage].
	(0 to: howManyX - 1) do: 
			[:xIndex | 
			xBitmapImage := self makeBitmap: (xBitmapArray at: xIndex + 1).
			xBitmapArray at: xIndex + 1 put: xBitmapImage].
	(0 to: howManyY - 1) do: 
			[:yIndex | 
			yBitmapImage := self makeBitmap: (yBitmapArray at: yIndex + 1).
			yBitmapArray at: yIndex + 1 put: yBitmapImage].
	boundingBoxes := self new.
	(0 to: howManyZ - 1) do: 
			[:zIndex | 
			zBitmapImage := zBitmapArray at: zIndex + 1.
			(0 to: howManyY - 1) do: 
					[:yIndex | 
					yBitmapImage := yBitmapArray at: yIndex + 1.
					(0 to: howManyX - 1) do: 
							[:xIndex | 
							xBitmapImage := xBitmapArray at: xIndex + 1.
							aBox := self boundingBoxClass origin: boundingBox origin 
												+ (boxWidth * xIndex , (boxHeight * yIndex) , (boxDepth * zIndex))
										extent: boxWidth , boxHeight , boxDepth.
							(((zBitmapImage atX: xIndex y: yIndex) = 1 
								and: [(xBitmapImage atX: yIndex y: zIndex) = 1]) 
									and: [(yBitmapImage atX: zIndex y: xIndex) = 1]) 
									ifTrue: [boundingBoxes add: aBox]]]].
	^boundingBoxes
]

{ #category : #private }
Jun3dBoundingBoxes class >> makeBoxesFromPoints: pointCollection howMany: aPoint [ 
	| thePoint howManyX howManyY howManyZ boundingBox boxWidth boxHeight boxDepth zBitmapArray zBitmapImage aBox boundingBoxes |
	thePoint := self pointClass coerce: aPoint.
	howManyX := thePoint x asInteger.
	howManyY := thePoint y asInteger.
	howManyZ := thePoint z asInteger.
	boundingBox := self boundingBoxClass fromPoints: pointCollection.
	boxWidth := boundingBox width / howManyX.
	boxHeight := boundingBox height / howManyY.
	boxDepth := boundingBox depth / howManyZ.
	zBitmapArray := Array new: howManyZ.
	(0 to: howManyZ - 1) do: 
			[:zIndex | 
			zBitmapImage := Image 
						extent: howManyX @ howManyY
						depth: 1
						palette: MonoMappedPalette whiteBlack.
			zBitmapArray at: zIndex + 1 put: zBitmapImage].
	(0 to: howManyZ - 1) do: 
			[:zIndex | 
			zBitmapImage := zBitmapArray at: zIndex + 1.
			(0 to: howManyY - 1) do: 
					[:yIndex | 
					(0 to: howManyX - 1) do: 
							[:xIndex | 
							aBox := self boundingBoxClass origin: boundingBox origin 
												+ (boxWidth * xIndex , (boxHeight * yIndex) , (boxDepth * zIndex))
										extent: boxWidth , boxHeight , boxDepth.
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
											put: 0]]]].
	boundingBoxes := self new.
	(0 to: howManyZ - 1) do: 
			[:zIndex | 
			zBitmapImage := zBitmapArray at: zIndex + 1.
			(0 to: howManyY - 1) do: 
					[:yIndex | 
					(0 to: howManyX - 1) do: 
							[:xIndex | 
							aBox := self boundingBoxClass origin: boundingBox origin 
												+ (boxWidth * xIndex , (boxHeight * yIndex) , (boxDepth * zIndex))
										extent: boxWidth , boxHeight , boxDepth.
							(zBitmapImage atX: xIndex y: yIndex) = 1 ifTrue: [boundingBoxes add: aBox]]]].
	^boundingBoxes
]

{ #category : #copyright }
Jun3dBoundingBoxes class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun3dBoundingBoxes class >> version [
	^'799'
]

{ #category : #testing }
Jun3dBoundingBoxes >> is3d [
	^true
]

{ #category : #subdividing }
Jun3dBoundingBoxes >> subdivide [
	"(((0 , 0 , 0 box: 1 , 1 , 1) asBoundingBoxes subdivide) showWithUnitArrows) wireframePresentation."

	^self subdivide8
]

{ #category : #subdividing }
Jun3dBoundingBoxes >> subdivide8 [
	"(((0 , 0 , 0 box: 1 , 1 , 1) asBoundingBoxes subdivide) showWithUnitArrows) wireframePresentation."

	| boundingBoxArray boundingBoxes |
	boundingBoxArray := Array new: self size * 8.
	self with: (0 to: self size - 1)
		do: 
			[:boundingBox :n | 
			| offset |
			boundingBoxes := boundingBox subdivide8 boundingBoxes.
			offset := n * 8.
			boundingBoxArray at: 1 + offset put: (boundingBoxes at: 1).
			boundingBoxArray at: 2 + offset put: (boundingBoxes at: 2).
			boundingBoxArray at: 3 + offset put: (boundingBoxes at: 3).
			boundingBoxArray at: 4 + offset put: (boundingBoxes at: 4).
			boundingBoxArray at: 5 + offset put: (boundingBoxes at: 5).
			boundingBoxArray at: 6 + offset put: (boundingBoxes at: 6).
			boundingBoxArray at: 7 + offset put: (boundingBoxes at: 7).
			boundingBoxArray at: 8 + offset put: (boundingBoxes at: 8)].
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes boundingBoxes: boundingBoxArray.
	^boundingBoxes
]

{ #category : #accessing }
Jun3dBoundingBoxes >> volume [
	| volume |
	volume := 0.
	self do: [:boundingBox | volume := volume + boundingBox volume].
	^volume
]

"
Imported by VwImportClass
"
Class {
	#name : #Jun3dPolyline,
	#superclass : #JunPolyline,
	#category : #'Jun-Geometry-Curves'
}

{ #category : #copyright }
Jun3dPolyline class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dPolyline class >> example1 [
	"Jun3dPolyline example1."

	| aBody aPolyline |
	aBody := JunOpenGL3dCompoundObject new.
	aPolyline := Jun3dPolyline examplePolyline1.
	aBody add: aPolyline asJunOpenGL3dObject.
	aBody show.
	^aPolyline
]

{ #category : #examples }
Jun3dPolyline class >> example2 [
	"Jun3dPolyline example2."

	| aPolyline aBody projectionTable arrayOfTriangles scaleFactor interBody anArray aTable |
	aPolyline := Jun3dPolyline examplePolyline2.
	arrayOfTriangles := aPolyline asArrayOfTriangles.
	projectionTable := (Dictionary new)
				add: #upVector -> (0 , 1 , 0);
				add: #zoomHeight -> 300;
				add: #shading -> #smoothShading;
				add: #eyePoint -> (aPolyline from + (0 , 0 , 10000));
				add: #viewFactor -> 10;
				add: #presentation -> #solidPresentation;
				add: #sightPoint -> aPolyline from;
				yourself.
	scaleFactor := (((aPolyline boundingBox origin x - aPolyline from x) abs 
				max: (aPolyline boundingBox corner x - aPolyline from x) abs) 
					max: ((aPolyline boundingBox origin y - aPolyline from y) abs 
							max: (aPolyline boundingBox corner y - aPolyline from y) abs)) 
					max: ((aPolyline boundingBox origin z - aPolyline from z) abs 
							max: (aPolyline boundingBox corner z - aPolyline from z) abs).
	aBody := JunOpenGL3dCompoundObject new.
	aBody add: ((aPolyline asJunOpenGL3dObjectColor: ColorValue black)
				lineWidth: 1;
				translatedBy: 0 , 0 , 0.1).
	aBody add: ((JunOpenGL3dObject axes scaledBy: scaleFactor * 1.2) 
				translatedBy: aPolyline from).
	aBody showProjectionTable: projectionTable in: (80 @ 300 extent: 300 @ 300).
	interBody := aBody transform: Jun3dTransformation unity.
	anArray := aPolyline 
				asArrayOf2dPointsAndTableOn: (JunPlane on: aPolyline from
						normalVector: aPolyline normalVector).
	aTable := anArray last.
	anArray := anArray first.
	anArray with: (0 to: anArray size - 1)
		do: 
			[:a2dPoint :aNumber | 
			| fromPoint toPoint colorValue |
			fromPoint := aTable at: a2dPoint.
			toPoint := a2dPoint as3dPoint.
			colorValue := ColorValue 
						hue: aNumber / arrayOfTriangles size
						saturation: 1
						brightness: 1.
			interBody add: (toPoint asJunOpenGL3dObjectColor: colorValue).
			interBody 
				add: ((JunOpenGL3dPolyline vertexes: (Array with: fromPoint with: toPoint))
						paint: colorValue;
						halftone: 0.5;
						yourself)].
	interBody 
		add: (((Jun3dCircle 
				center: aPolyline from
				radius: scaleFactor * 1.2
				upVector: aPolyline normalVector) asJunOpenGL3dObject)
				flushAllPaints;
				flushAllAlphas;
				polygonsDo: 
						[:each | 
						each
							paint: ColorValue cyan;
							halftone: 0.25];
				yourself).
	interBody add: (JunOpenGL3dObject axes scaledBy: scaleFactor * 1.2).
	interBody 
		add: (((Jun3dCircle 
				center: 0 , 0 , 0
				radius: scaleFactor * 1.2
				upVector: 0 , 0 , 1) asJunOpenGL3dObject)
				flushAllPaints;
				flushAllAlphas;
				polygonsDo: 
						[:each | 
						each
							paint: ColorValue cyan;
							halftone: 0.25];
				yourself).
	(interBody showProjectionTable: projectionTable
		in: (390 @ 300 extent: 300 @ 300)) resetView.
	aBody := aBody copy.
	arrayOfTriangles with: (0 to: arrayOfTriangles size - 1)
		do: 
			[:aTriangle :aNumber | 
			aBody 
				add: (aTriangle asJunOpenGL3dObjectColor: (ColorValue 
								hue: aNumber / arrayOfTriangles size
								saturation: 1
								brightness: 1))].
	aBody showProjectionTable: projectionTable
		in: (700 @ 300 extent: 300 @ 300).
	^aPolyline
]

{ #category : #examples }
Jun3dPolyline class >> example3 [
	"Jun3dPolyline example3."

	| aPolyline1 aPolyline2 aBody aModel aBlock triangleCollection |
	aPolyline1 := Jun3dPolyline examplePolyline31.
	aPolyline2 := Jun3dPolyline examplePolyline32.
	aBody := JunOpenGL3dCompoundObject new.
	aModel := aBody showProjectionTable: ((Dictionary new)
						add: #sightPoint -> (99.5 , 159.5 , 0.0);
						add: #shading -> #smoothShading;
						add: #upVector -> (0 , -1 , 0);
						add: #viewFactor -> 10;
						add: #presentation -> #solidPresentation;
						add: #zoomHeight -> 370;
						add: #eyePoint -> (0 , 0 , -10000);
						yourself).
	aModel
		useDisplayList: false;
		changed: #object.
	aBlock := 
			[aPolyline1 pointsDo: 
					[:aPoint | 
					aBody add: (((aPoint + (0 , 0 , -0.1)) asJunOpenGL3dObject)
								size: 5;
								yourself)].
			aPolyline2 pointsDo: 
					[:aPoint | 
					aBody add: (((aPoint + (0 , 0 , -0.1)) asJunOpenGL3dObject)
								size: 5;
								yourself)].
			aBody add: ((aPolyline1 asJunOpenGL3dObject)
						lineWidth: 3;
						yourself).
			aBody add: ((aPolyline2 asJunOpenGL3dObject)
						lineWidth: 3;
						yourself)].
	triangleCollection := aPolyline1 sew: aPolyline2
				interim: 
					[:points :symbol | 
					aBody := JunOpenGL3dCompoundObject new.
					aBlock value.
					aBody 
						add: (((Jun3dPolygon 
								points: (points collect: [:aPoint | aPoint + (0 , 0 , 0.1)])) 
									asJunOpenGL3dObject)
								paint: (symbol = #pending 
											ifTrue: [ColorValue cyan]
											ifFalse: [ColorValue magenta]);
								yourself).
					aModel
						displayObject: aBody;
						changed: #object.
					symbol = #pending 
						ifTrue: [(Delay forMilliseconds: 300) wait]
						ifFalse: [(Delay forMilliseconds: 900) wait]].
	aBody := JunOpenGL3dCompoundObject new.
	aBlock value.
	triangleCollection do: 
			[:anArray | 
			aBody 
				add: (((Jun3dPolygon 
						points: (anArray collect: [:aPoint | aPoint + (0 , 0 , 0.1)]) reverse) 
							asJunOpenGL3dObject)
						paint: ColorValue magenta;
						yourself)].
	aModel
		hiddenlinePresentation;
		displayObject: aBody;
		changed: #object.
	^triangleCollection
]

{ #category : #examples }
Jun3dPolyline class >> example4 [
	"Jun3dPolyline example4."

	| aPolyline |
	aPolyline := Jun3dPolyline examplePolyline subdivideAsSpline.
	aPolyline showWithUnitArrows.
	^aPolyline
]

{ #category : #examples }
Jun3dPolyline class >> example5 [
	"Jun3dPolyline example5."

	| aPolyline |
	aPolyline := (Jun3dPolyline 
				vertexes: JunBoundingBoxNode examplePointCollectionOf3dSinCurve) 
					subdivideAsSpline.
	aPolyline showWithAxes.
	^aPolyline
]

{ #category : #examples }
Jun3dPolyline class >> examplePolyline [
	"(Jun3dPolyline examplePolyline) showWithUnitArrows."

	| lines delta line points |
	lines := (0 , 0 , 0 to: 1 , 1 , 1) subdivideLevel: 2.
	delta := 0.1.
	line := 0 , 0 , 0 to: -1 , 1 , 0.
	points := lines asPolyline points.
	points at: 2 put: ((line translatedBy: (points at: 2)) atT: delta negated).
	points at: 4 put: ((line translatedBy: (points at: 4)) atT: delta).
	^Jun3dPolyline points: points
]

{ #category : #examples }
Jun3dPolyline class >> examplePolyline1 [
	"(Jun3dPolyline examplePolyline1) showWithAxes."

	| aPoint |
	^Jun3dPolyline 
		points: (Array 
				with: (aPoint := 50 , 50 , -25)
				with: -50 , 50 , 25
				with: -50 , -50 , -25
				with: 50 , -50 , 25) , (Array with: aPoint)
]

{ #category : #examples }
Jun3dPolyline class >> examplePolyline2 [
	"(Jun3dPolyline examplePolyline2) showWithAxes."

	| anArray |
	Jun3dPolyline 
		assert: [WriteStream on: Array new]
		do: 
			[:aStream | 
			aStream nextPut: 115 , 142 , 25.
			aStream nextPut: 109 , 136 , -25.
			aStream nextPut: 97 , 119 , 25.
			aStream nextPut: 92 , 111 , -25.
			aStream nextPut: 90 , 100 , 25.
			aStream nextPut: 95 , 78 , -25.
			aStream nextPut: 102 , 64 , 25.
			aStream nextPut: 116 , 50 , -25.
			aStream nextPut: 132 , 49 , 25.
			aStream nextPut: 142 , 55 , -25.
			aStream nextPut: 154 , 66 , 25.
			aStream nextPut: 160 , 83 , -25.
			aStream nextPut: 160 , 99 , 25.
			aStream nextPut: 156 , 110 , -25.
			aStream nextPut: 153 , 123 , 25.
			aStream nextPut: 152 , 131 , -25.
			aStream nextPut: 156 , 137 , 25.
			aStream nextPut: 165 , 141 , -25.
			aStream nextPut: 180 , 144 , 25.
			aStream nextPut: 198 , 149 , -25.
			aStream nextPut: 210 , 158 , 25.
			aStream nextPut: 215 , 168 , -25.
			aStream nextPut: 215 , 182 , 25.
			aStream nextPut: 210 , 191 , -25.
			aStream nextPut: 199 , 194 , 25.
			aStream nextPut: 183 , 190 , -25.
			aStream nextPut: 170 , 184 , 25.
			aStream nextPut: 162 , 183 , -25.
			aStream nextPut: 149 , 187 , 25.
			aStream nextPut: 140 , 193 , -25.
			aStream nextPut: 132 , 199 , 25.
			aStream nextPut: 122 , 206 , -25.
			aStream nextPut: 110 , 210 , 25.
			aStream nextPut: 96 , 210 , -25.
			aStream nextPut: 83 , 207 , 25.
			aStream nextPut: 74 , 203 , -25.
			aStream nextPut: 71 , 195 , 25.
			aStream nextPut: 73 , 185 , -25.
			aStream nextPut: 81 , 178 , 25.
			aStream nextPut: 94 , 173 , -25.
			aStream nextPut: 106 , 172 , 25.
			aStream nextPut: 112 , 170 , -25.
			aStream nextPut: 117 , 169 , 25.
			aStream nextPut: 124 , 165 , -25.
			aStream nextPut: 125 , 162 , 25.
			aStream nextPut: 125 , 159 , -25.
			anArray := aStream contents]
		ensure: [:aStream | aStream close].
	anArray := anArray collect: 
					[:aPoint | 
					aPoint transform: ((Jun3dTransformation rotateX: (JunAngle fromDeg: -45)) 
								product: (Jun3dTransformation translate: 100 , 100 , 0))].
	^Jun3dPolyline points: anArray
]

{ #category : #examples }
Jun3dPolyline class >> examplePolyline31 [
	"(Jun3dPolyline examplePolyline31) showWithAxes."

	^Jun3dPolyline 
		points: (Array 
				with: 59 , 5 , 0
				with: 41 , 50 , 0
				with: 113 , 149 , 0) , (Array 
							with: 5 , 221 , 0
							with: 5 , 257 , 0
							with: 32 , 314 , 0)
]

{ #category : #examples }
Jun3dPolyline class >> examplePolyline32 [
	"(Jun3dPolyline examplePolyline32) showWithAxes."

	^Jun3dPolyline points: (Array 
				with: 194 , 50 , 0
				with: 185 , 122 , 0
				with: 149 , 172 , 0
				with: 185 , 275 , 0)
]

{ #category : #copyright }
Jun3dPolyline class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun3dPolyline class >> version [
	^'799'
]

{ #category : #converting }
Jun3dPolyline >> asArrayOf2dPointsAndTableOn: aPlane [ 
	| aTable anArray |
	self 
		assert: 
			[aTable := Dictionary new.
			Array new writeStream]
		do: 
			[:aStream | 
			| upVector xLine yLine yzPlane xzPlane |
			upVector := aPlane normalUnitVector.
			xLine := aPlane p1 to: aPlane p2.
			yLine := xLine 
						transform: (Jun3dTransformation rotate: (JunAngle fromDeg: 90)
								around: (0 , 0 , 0 to: upVector)).
			yzPlane := self planeClass on: aPlane p1 vertical: xLine.
			xzPlane := self planeClass on: aPlane p1 vertical: yLine.
			self points do: 
					[:a3dPoint | 
					| aLine aPoint a2dPoint xValue yValue |
					aLine := a3dPoint to: a3dPoint + upVector.
					aPoint := aPlane intersectingPointWithLine: aLine.
					xValue := (yzPlane distanceFromPoint: aPoint) 
								* (aPoint whichSideOf: yzPlane).
					yValue := (xzPlane distanceFromPoint: aPoint) 
								* (aPoint whichSideOf: xzPlane).
					a2dPoint := xValue , yValue.
					aStream nextPut: a2dPoint.
					aTable at: a2dPoint put: a3dPoint].
			anArray := aStream contents]
		ensure: [:aStream | aStream close].
	^Array with: anArray with: aTable
]

{ #category : #converting }
Jun3dPolyline >> asArrayOfTriangles [
	self numberOfPoints < 3 ifTrue: [^Array new].
	^self asArrayOfTrianglesOn: (self planeClass on: self from
				normalVector: self normalVector)
]

{ #category : #converting }
Jun3dPolyline >> asArrayOfTrianglesOn: aPlane [ 
	| aTable anArray |
	self numberOfPoints < 3 ifTrue: [^Array new].
	anArray := self asArrayOf2dPointsAndTableOn: aPlane.
	aTable := anArray last.
	anArray := anArray first.
	self 
		assert: [Array new writeStream]
		do: 
			[:aStream | 
			(Jun2dPolyline vertexes: anArray) asArrayOfTriangles do: 
					[:a2dTriangle | 
					aStream nextPut: (self triangleClass 
								on: (aTable at: a2dTriangle p1)
								on: (aTable at: a2dTriangle p2)
								on: (aTable at: a2dTriangle p3))].
			anArray := aStream contents]
		ensure: [:aStream | aStream close].
	^anArray
]

{ #category : #functions }
Jun3dPolyline >> intersectingPointsAndIndexesWithPlane: aPlane [
	"| aPolyline aPlane |
	aPolyline := Jun3dPolyline
		vertexes:
			((OrderedCollection new)
				add: 0 , 0 , 0;
				add: 0.25 , 0 , -1;
				add: 0 , 0.25 , 1;
				add: 0.5 , 0.25 , -1;
				add: 0.25 , 0.5 , 1;
				add: 0.75 , 0.5 , -1;
				add: 0.5 , 0.75 , 1;
				add: 1 , 0.75 , -1;
				add: 0.75 , 1 , 1;
				add: 1 , 1 , 0;
				yourself).
	aPlane := 0 , 0
		plane: 1 , 1
		and: 0 , 1.
	^aPolyline intersectingPointsAndIndexesWithPlane: aPlane"
	
	| aCollection |
	aCollection := OrderedCollection new.
	(1 to: self points size - 1)
		with: (2 to: self points size)
		do:
			[:i :j | 
			| aSegment aPoint |
			aSegment := (self points at: i) to: (self points at: j).
			aPoint := aPlane intersectingPointWithLine: aSegment.
			aPoint notNil
				ifTrue:
					[| aParameter |
					aParameter := aSegment tAtPoint: aPoint.
					(aParameter between: 0 and: 1)
						ifTrue:
							[aCollection
								add:
									(Array
										with: aPoint
										with: (Array with: i with: j))]]].
	^aCollection
]

{ #category : #functions }
Jun3dPolyline >> intersectingPointsWithPlane: aPlane [
	"| aPolyline aPlane |
	aPolyline := Jun3dPolyline
		vertexes:
			((OrderedCollection new)
				add: 0 , 0 , 0;
				add: 0.25 , 0 , -1;
				add: 0 , 0.25 , 1;
				add: 0.5 , 0.25 , -1;
				add: 0.25 , 0.5 , 1;
				add: 0.75 , 0.5 , -1;
				add: 0.5 , 0.75 , 1;
				add: 1 , 0.75 , -1;
				add: 0.75 , 1 , 1;
				add: 1 , 1 , 0;
				yourself).
	aPlane := 0 , 0
		plane: 1 , 1
		and: 0 , 1.
	^aPolyline intersectingPointsWithPlane: aPlane"
	
	^(self intersectingPointsAndIndexesWithPlane: aPlane)
		collect: [:array | array first]
]

{ #category : #testing }
Jun3dPolyline >> is3d [
	^true
]

{ #category : #accessing }
Jun3dPolyline >> normalUnitVector [
	^self normalVector unitVector
]

{ #category : #accessing }
Jun3dPolyline >> normalVector [
	| vector |
	vector := Jun3dPoint zero.
	1 to: self numberOfPoints
		do: 
			[:index | 
			| point1 point2 point3 |
			point1 := self pointAt: index.
			point2 := self pointAt: index \\ self numberOfPoints + 1.
			point3 := self pointAt: (index + 1) \\ self numberOfPoints + 1.
			vector := vector + (point2 - point1 vectorProduct: point3 - point2)].
	^vector
]

{ #category : #'bounds access' }
Jun3dPolyline >> preferredBoundingBox [
	| minX minY minZ maxX maxY maxZ |
	minX := nil.
	minY := nil.
	minZ := nil.
	maxX := nil.
	maxY := nil.
	maxZ := nil.
	self pointsDo: 
			[:p | 
			minX == nil ifTrue: [minX := p x] ifFalse: [minX := minX min: p x].
			minY == nil ifTrue: [minY := p y] ifFalse: [minY := minY min: p y].
			minZ == nil ifTrue: [minZ := p z] ifFalse: [minZ := minZ min: p z].
			maxX == nil ifTrue: [maxX := p x] ifFalse: [maxX := maxX max: p x].
			maxY == nil ifTrue: [maxY := p y] ifFalse: [maxY := maxY max: p y].
			maxZ == nil ifTrue: [maxZ := p z] ifFalse: [maxZ := maxZ max: p z]].
	minX isNil ifTrue: [minX := 0].
	minY isNil ifTrue: [minY := 0].
	minZ isNil ifTrue: [minZ := 0].
	maxX isNil ifTrue: [maxX := 0].
	maxY isNil ifTrue: [maxY := 0].
	maxZ isNil ifTrue: [maxZ := 0].
	^Jun3dBoundingBox origin: minX , minY , minZ corner: maxX , maxY , maxZ
]

"
Imported by VwImportClass
"
Class {
	#name : #Jun2dPolyline,
	#superclass : #JunPolyline,
	#category : #'Jun-Geometry-Curves'
}

{ #category : #copyright }
Jun2dPolyline class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun2dPolyline class >> example1 [
	"Jun2dPolyline example1."

	| aBody aPolyline |
	aBody := JunOpenGL3dCompoundObject new.
	aPolyline := Jun2dPolyline examplePolyline1.
	aBody add: aPolyline asJunOpenGL3dObject.
	aBody show.
	^aPolyline
]

{ #category : #examples }
Jun2dPolyline class >> example2 [
	"Jun2dPolyline example2."

	| aPolyline aBody projectionTable arrayOfTriangles scaleFactor |
	aPolyline := Jun2dPolyline examplePolyline2.
	arrayOfTriangles := aPolyline asArrayOfTriangles.
	projectionTable := (Dictionary new)
				add: #upVector -> (0 , 1 , 0);
				add: #zoomHeight -> 300;
				add: #shading -> #smoothShading;
				add: #eyePoint -> (aPolyline from as3dPoint + (0 , 0 , 10000));
				add: #viewFactor -> 10;
				add: #presentation -> #solidPresentation;
				add: #sightPoint -> aPolyline from as3dPoint;
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
	aBody showProjectionTable: projectionTable
		in: (100 @ 300 extent: 300 @ 300).
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
		in: (410 @ 300 extent: 300 @ 300).
	^aPolyline
]

{ #category : #examples }
Jun2dPolyline class >> example3 [
	"Jun2dPolyline example3."

	| aPolyline1 aPolyline2 aBody aModel aBlock triangleCollection |
	aPolyline1 := Jun2dPolyline examplePolyline31.
	aPolyline2 := Jun2dPolyline examplePolyline32.
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
Jun2dPolyline class >> example4 [
	"Jun2dPolyline example4."

	| aPolyline |
	aPolyline := Jun2dPolyline examplePolyline subdivideAsSpline.
	aPolyline showWithUnitArrows.
	^aPolyline
]

{ #category : #examples }
Jun2dPolyline class >> example5 [
	"Jun2dPolyline example5."

	| aPolyline |
	aPolyline := (Jun2dPolyline 
				vertexes: JunBoundingBoxNode examplePointCollectionOf2dSinCurve) 
					subdivideAsSpline.
	aPolyline showWithAxes.
	^aPolyline
]

{ #category : #examples }
Jun2dPolyline class >> examplePolyline [
	"(Jun2dPolyline examplePolyline) showWithUnitArrows."

	| lines delta line points |
	lines := (0 , 0 to: 1 , 1) subdivideLevel: 2.
	delta := 0.1.
	line := 0 , 0 to: -1 , 1.
	points := lines asPolyline points.
	points at: 2 put: ((line translatedBy: (points at: 2)) atT: delta negated).
	points at: 4 put: ((line translatedBy: (points at: 4)) atT: delta).
	^Jun2dPolyline points: points
]

{ #category : #examples }
Jun2dPolyline class >> examplePolyline1 [
	"(Jun2dPolyline examplePolyline1) showWithAxes."

	| aPoint |
	^Jun2dPolyline 
		points: (Array 
				with: (aPoint := 50 , 50)
				with: -50 , 50
				with: -50 , -50
				with: 50 , -50) , (Array with: aPoint)
]

{ #category : #examples }
Jun2dPolyline class >> examplePolyline2 [
	"(Jun2dPolyline examplePolyline2) showWithAxes."

	| anArray |
	Jun2dPolyline 
		assert: [WriteStream on: Array new]
		do: 
			[:aStream | 
			aStream nextPut: 115 , 142.
			aStream nextPut: 109 , 136.
			aStream nextPut: 97 , 119.
			aStream nextPut: 92 , 111.
			aStream nextPut: 90 , 100.
			aStream nextPut: 95 , 78.
			aStream nextPut: 102 , 64.
			aStream nextPut: 116 , 50.
			aStream nextPut: 132 , 49.
			aStream nextPut: 142 , 55.
			aStream nextPut: 154 , 66.
			aStream nextPut: 160 , 83.
			aStream nextPut: 160 , 99.
			aStream nextPut: 156 , 110.
			aStream nextPut: 153 , 123.
			aStream nextPut: 152 , 131.
			aStream nextPut: 156 , 137.
			aStream nextPut: 165 , 141.
			aStream nextPut: 180 , 144.
			aStream nextPut: 198 , 149.
			aStream nextPut: 210 , 158.
			aStream nextPut: 215 , 168.
			aStream nextPut: 215 , 182.
			aStream nextPut: 210 , 191.
			aStream nextPut: 199 , 194.
			aStream nextPut: 183 , 190.
			aStream nextPut: 170 , 184.
			aStream nextPut: 162 , 183.
			aStream nextPut: 149 , 187.
			aStream nextPut: 140 , 193.
			aStream nextPut: 132 , 199.
			aStream nextPut: 122 , 206.
			aStream nextPut: 110 , 210.
			aStream nextPut: 96 , 210.
			aStream nextPut: 83 , 207.
			aStream nextPut: 74 , 203.
			aStream nextPut: 71 , 195.
			aStream nextPut: 73 , 185.
			aStream nextPut: 81 , 178.
			aStream nextPut: 94 , 173.
			aStream nextPut: 106 , 172.
			aStream nextPut: 112 , 170.
			aStream nextPut: 117 , 169.
			aStream nextPut: 124 , 165.
			aStream nextPut: 125 , 162.
			aStream nextPut: 125 , 159.
			anArray := aStream contents]
		ensure: [:aStream | aStream close].
	anArray := anArray 
				collect: [:aPoint | aPoint transform: Jun2dTransformation unity].
	^Jun2dPolyline points: anArray
]

{ #category : #examples }
Jun2dPolyline class >> examplePolyline31 [
	"(Jun2dPolyline examplePolyline31) showWithAxes."

	^Jun2dPolyline 
		points: (Array 
				with: 59 , 5
				with: 41 , 50
				with: 113 , 149) , (Array 
							with: 5 , 221
							with: 5 , 257
							with: 32 , 314)
]

{ #category : #examples }
Jun2dPolyline class >> examplePolyline32 [
	"(Jun2dPolyline examplePolyline32) showWithAxes."

	^Jun2dPolyline points: (Array 
				with: 194 , 50
				with: 185 , 122
				with: 149 , 172
				with: 185 , 275)
]

{ #category : #copyright }
Jun2dPolyline class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun2dPolyline class >> version [
	^'799'
]

{ #category : #converting }
Jun2dPolyline >> asArrayOfTriangles [
	"Jun2dPolyline examplePolyline asArrayOfTriangles."

	| isLoop collectionOfPoints formTriangulation triangleCollection |
	self numberOfPoints < 3 ifTrue: [^Array new].
	isLoop := self from = self to.
	isLoop 
		ifTrue: [collectionOfPoints := self points]
		ifFalse: [collectionOfPoints := self points , (Array with: self from)].
	formTriangulation := JunFormTriangulation2 points: collectionOfPoints.
	self 
		assert: [(Array new: formTriangulation triangles size) writeStream]
		do: 
			[:aStream | 
			formTriangulation triangles do: 
					[:triangle | 
					| p1 p2 p3 |
					p1 := triangle at: 3.
					p2 := triangle at: 2.
					p3 := triangle at: 1.
					isLoop 
						ifTrue: 
							[aStream nextPut: (self triangleClass 
										on: p1
										on: p2
										on: p3)]
						ifFalse: 
							[| fromPoint toPoint |
							fromPoint := self from.
							toPoint := self to.
							((p1 = fromPoint or: [p2 = fromPoint or: [p3 = fromPoint]]) 
								and: [p1 = toPoint or: [p2 = toPoint or: [p3 = toPoint]]]) 
									ifFalse: 
										[aStream nextPut: (self triangleClass 
													on: p1
													on: p2
													on: p3)]]].
			triangleCollection := aStream contents]
		ensure: [:aStream | aStream close].
	^triangleCollection
]

{ #category : #functions }
Jun2dPolyline >> intersectingPointsAndIndexesWithLine: aLine [
	"| aPolyline aLine |
	aPolyline := Jun2dPolyline
		vertexes:
			((OrderedCollection new)
				add: 0 , 0;
				add: 0.25 , 0;
				add: 0 , 0.25;
				add: 0.5 , 0.25;
				add: 0.25 , 0.5;
				add: 0.75 , 0.5;
				add: 0.5 , 0.75;
				add: 1 , 0.75;
				add: 0.75 , 1;
				add: 1 , 1;
				yourself).
	aLine := 0 , 0 to: 1 , 1.
	^aPolyline intersectingPointsAndIndexesWithLine: aLine"
	
	| aCollection |
	aCollection := OrderedCollection new.
	(1 to: self points size - 1)
		with: (2 to: self points size)
		do:
			[:i :j | 
			| aSegment aPoint |
			aSegment := (self points at: i) to: (self points at: j).
			aPoint := aLine intersectingPointWithLine: aSegment.
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
Jun2dPolyline >> intersectingPointsWithLine: aLine [
	"| aPolyline aLine |
	aPolyline := Jun2dPolyline
		vertexes:
			((OrderedCollection new)
				add: 0 , 0;
				add: 0.25 , 0;
				add: 0 , 0.25;
				add: 0.5 , 0.25;
				add: 0.25 , 0.5;
				add: 0.75 , 0.5;
				add: 0.5 , 0.75;
				add: 1 , 0.75;
				add: 0.75 , 1;
				add: 1 , 1;
				yourself).
	aLine := 0 , 0 to: 1 , 1.
	^aPolyline intersectingPointsWithLine: aLine"
	
	^(self intersectingPointsAndIndexesWithLine: aLine)
		collect: [:array | array first]
]

{ #category : #testing }
Jun2dPolyline >> is2d [
	^true
]

{ #category : #'bounds access' }
Jun2dPolyline >> preferredBoundingBox [
	| minX minY maxX maxY |
	minX := nil.
	minY := nil.
	maxX := nil.
	maxY := nil.
	self pointsDo: 
			[:p | 
			minX == nil ifTrue: [minX := p x] ifFalse: [minX := minX min: p x].
			minY == nil ifTrue: [minY := p y] ifFalse: [minY := minY min: p y].
			maxX == nil ifTrue: [maxX := p x] ifFalse: [maxX := maxX max: p x].
			maxY == nil ifTrue: [maxY := p y] ifFalse: [maxY := maxY max: p y]].
	minX isNil ifTrue: [minX := 0].
	minY isNil ifTrue: [minY := 0].
	maxX isNil ifTrue: [maxX := 0].
	maxY isNil ifTrue: [maxY := 0].
	^Jun2dBoundingBox origin: minX , minY corner: maxX , maxY
]

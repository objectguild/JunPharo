"
Imported by VwImportClass
"
Class {
	#name : #JunFormTriangulation,
	#superclass : #JunFormOperation,
	#instVars : [
		'formTriangulation',
		'formTriangles',
		'formArea'
	],
	#category : #'Jun-Geometry-Forms'
}

{ #category : #copyright }
JunFormTriangulation class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #defaults }
JunFormTriangulation class >> defaultTriangulationClass [
	^JunFormTriangulation3
]

{ #category : #examples }
JunFormTriangulation class >> example1 [
	"JunFormTriangulation example1."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formTriangulation aPixmap graphicsContext |
			formTriangulation := JunFormTriangulation points: aPolyline.
			JunControlUtility 
				assert: 
					[aPixmap := Pixmap extent: formTriangulation boundingBox extent rounded]
				do: 
					[graphicsContext := aPixmap graphicsContext.
					graphicsContext paint: ColorValue white.
					graphicsContext displayRectangle: aPixmap bounds.
					JunApplicationModel displayPendingInvalidation.
					Cursor wait showWhile: [formTriangulation triangles].
					formTriangulation displayOn: graphicsContext.
					JunImageDisplayModel show: aPixmap asImage at: aPoint]
				ensure: 
					[aPixmap close.
					JunApplicationModel displayPendingInvalidation].
			aPoint := aPoint translatedBy: 20 @ 20.
			formTriangulation].
	^JunFormTriangulation2 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation class >> example2 [
	"JunFormTriangulation example2."

	| aBlock formTriangulation areaOfTriangles areaWithSignOfTriangles |
	aBlock := 
			[:aPolyline | 
			(Array
				with: JunFormTriangulation1
				with: JunFormTriangulation2
				with: JunFormTriangulation3)
				do: 
					[:triangulationClass | 
					formTriangulation := JunFormTriangulation points: aPolyline by: triangulationClass new.
					areaOfTriangles := formTriangulation area.
					areaWithSignOfTriangles := formTriangulation areaWithSign.
					Transcript cr; show: triangulationClass printString.
					Transcript cr; tab; show: 'total area of triangles: ' , areaOfTriangles printString.
					Transcript cr; tab; show: 'total area of triangles with sign: ' , areaWithSignOfTriangles printString].
			Transcript cr].
	^JunFormTriangulation examplePolylines collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation class >> examplePolylines [
	"JunFormTriangulation examplePolylines."

	| examplePolylines |
	examplePolylines := JunForm2dRegion exampleOriginalPolylines.
	examplePolylines := #(4 10) collect: [:index | examplePolylines at: index].
	^examplePolylines
]

{ #category : #'instance creation' }
JunFormTriangulation class >> points: pointCollection [ 
	^self points: pointCollection by: self defaultTriangulationClass new
]

{ #category : #'instance creation' }
JunFormTriangulation class >> points: pointCollection by: formTriangulationByWhom [ 
	| formTriangulation |
	formTriangulation := self new.
	formTriangulation triangulation: formTriangulationByWhom.
	formTriangulation points: pointCollection.
	^formTriangulation
]

{ #category : #copyright }
JunFormTriangulation class >> system [
	^'Jun'
]

{ #category : #copyright }
JunFormTriangulation class >> version [
	^'799'
]

{ #category : #accessing }
JunFormTriangulation >> area [
	| area |
	area := 0.0d.
	self triangles do: [:triangle | area := area + (self areaOfTriangle: triangle)].
	^area
]

{ #category : #private }
JunFormTriangulation >> areaOfTriangle: threePoints [ 
	"JunFormTriangulation new areaOfTriangle: (Array with: 10@10 with: 90@ 20 with: 50 @ 70)."
	"JunFormTriangulation new areaOfTriangle: (Array with: 10@10 with: 90@ 20 with: 50 @ 70) reverse."

	^(self areaWithSignOfTriangle: threePoints) abs
]

{ #category : #accessing }
JunFormTriangulation >> areaWithSign [
	| area |
	area := 0.0d.
	self triangles do: [:triangle | area := area + (self areaWithSignOfTriangle: triangle)].
	^area
]

{ #category : #private }
JunFormTriangulation >> areaWithSignOfTriangle: threePoints [ 
	"JunFormTriangulation new areaWithSignOfTriangle: (Array with: 10@10 with: 90@ 20 with: 50 @ 70)."
	"JunFormTriangulation new areaWithSignOfTriangle: (Array with: 10@10 with: 90@ 20 with: 50 @ 70) reverse."

	| p1 p2 p3 x1 y1 x2 y2 x3 y3 area |
	p1 := threePoints at: 1.
	p2 := threePoints at: 2.
	p3 := threePoints at: 3.
	x1 := p1 x.
	y1 := p1 y.
	x2 := p2 x.
	y2 := p2 y.
	x3 := p3 x.
	y3 := p3 y.
	area := x1 - x2 * (y1 + y2) + (x2 - x3 * (y2 + y3)) + (x3 - x1 * (y3 + y1)) * 0.5d.
	^area
]

{ #category : #accessing }
JunFormTriangulation >> boundingBox [
	^self triangulation boundingBox
]

{ #category : #accessing }
JunFormTriangulation >> bounds [
	^self triangulation bounds
]

{ #category : #testing }
JunFormTriangulation >> containsLineSegment: twoPoints [ 
	^self triangulation containsLineSegment: twoPoints
]

{ #category : #testing }
JunFormTriangulation >> containsPoint: aPoint [ 
	^self triangulation containsPoint: aPoint
]

{ #category : #defaults }
JunFormTriangulation >> defaultAccuracy [
	^self triangulation defaultAccuracy
]

{ #category : #defaults }
JunFormTriangulation >> defaultSoFarZ [
	^29999
]

{ #category : #defaults }
JunFormTriangulation >> defaultTriangulationClass [
	^self class defaultTriangulationClass
]

{ #category : #displaying }
JunFormTriangulation >> displayOn: graphicsContext [ 
	self displayOn: graphicsContext at: Point zero
]

{ #category : #displaying }
JunFormTriangulation >> displayOn: graphicsContext at: aPoint [ 
	self
		displayOn: graphicsContext
		at: aPoint
		triangles: self triangles
		color: ColorValue red
]

{ #category : #displaying }
JunFormTriangulation >> displayOn: graphicsContext at: aPoint triangles: triangleCollection color: colorValue [ 
	| displayPoint aPolyline |
	displayPoint := Point zero - self boundingBox origin + aPoint.
	graphicsContext paint: ColorValue white.
	graphicsContext displayRectangle: self boundingBox at: displayPoint.
	graphicsContext capStyle: GraphicsContext capButt.
	graphicsContext joinStyle: GraphicsContext joinBevel.
	graphicsContext lineWidth: 1.
	graphicsContext paint: ColorValue gray.
	graphicsContext displayRectangularBorder: (self boundingBox insetBy: (0 @ 0 corner: 1 @ 1))
		at: displayPoint.
	triangleCollection
		do: 
			[:triangle | 
			triangle first = triangle last
				ifTrue: [aPolyline := triangle]
				ifFalse: [aPolyline := triangle , (Array with: triangle first)].
			aPolyline := aPolyline collect: [:each | each x rounded @ each y rounded].
			graphicsContext paint: (colorValue blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolyline at: displayPoint.
			graphicsContext paint: colorValue.
			graphicsContext displayPolyline: aPolyline at: displayPoint].
	graphicsContext paint: ColorValue black.
	graphicsContext displayPolyline: self points at: displayPoint
]

{ #category : #displaying }
JunFormTriangulation >> displayOn: graphicsContext triangles: triangleCollection [ 
	self
		displayOn: graphicsContext
		at: Point zero
		triangles: triangleCollection
		color: ColorValue red
]

{ #category : #'initialize-release' }
JunFormTriangulation >> initialize [
	super initialize.
	formTriangulation := nil.
	formTriangles := nil.
	formArea := nil
]

{ #category : #accessing }
JunFormTriangulation >> points [
	^self triangulation points
]

{ #category : #accessing }
JunFormTriangulation >> points: pointCollection [ 
	self triangulation points: pointCollection.
	formTriangles := nil.
	formArea := nil
]

{ #category : #private }
JunFormTriangulation >> rightHandTriangle: threePoints [ 
	"JunFormTriangulation new rightHandTriangle: (Array with: 10@10 with: 90@ 20 with: 50 @ 70)."
	"JunFormTriangulation new rightHandTriangle: (Array with: 10@10 with: 90@ 20 with: 50 @ 70) reverse."

	| trianglePoints aPlane aTriangle |
	trianglePoints := threePoints collect: [:p | p x , p y , 0].
	aPlane := JunPlane
				on: (trianglePoints at: 1)
				on: (trianglePoints at: 2)
				on: (trianglePoints at: 3).
	0 <= (aPlane valueF: 0 , 0 , self defaultSoFarZ)
		ifTrue: [aTriangle := threePoints yourself]
		ifFalse: [aTriangle := threePoints reverse].
	^aTriangle
]

{ #category : #accessing }
JunFormTriangulation >> segments [
	^self triangulation segments
]

{ #category : #accessing }
JunFormTriangulation >> triangles [
	formTriangles isNil
		ifTrue: 
			[| triangleCollection aStream accuracy |
			triangleCollection := self triangulation triangles.
			aStream := WriteStream on: (Array new: triangleCollection size).
			accuracy := self defaultAccuracy.
			triangleCollection do: [:triangle | aStream nextPut: (triangle
						collect: 
							[:p | 
							| index |
							index := self points findFirst: [:each | (each dist: p)
											< accuracy].
							index < 1 ifTrue: [self error: 'unexpected error'].
							self points at: index])].
			triangleCollection := aStream contents.
			aStream := WriteStream on: (Array new: triangleCollection size).
			triangleCollection do: [:triangle | aStream nextPut: (self rightHandTriangle: triangle)].
			formTriangles := aStream contents].
	^formTriangles
]

{ #category : #private }
JunFormTriangulation >> triangulation [
	formTriangulation isNil ifTrue: [formTriangulation := self defaultTriangulationClass new].
	^formTriangulation
]

{ #category : #private }
JunFormTriangulation >> triangulation: formTriangulationByWhom [ 
	formTriangulation := formTriangulationByWhom
]

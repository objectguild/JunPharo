"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGL3dPolygon,
	#superclass : #JunOpenGL3dVertexesObject,
	#instVars : [
		'stipple',
		'texture'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #copyright }
JunOpenGL3dPolygon class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGL3dPolygon class >> example1 [
	"JunOpenGL3dPolygon example1."

	| polygon list |
	polygon := JunOpenGL3dPolygon vertexes: (Array
					with: 0.0d , 0.0d , 1.0d
					with: 1.0d , 0.0d , 1.0d
					with: 1.0d , 1.0d , 1.0d
					with: 0.0d , 1.0d , 1.0d).
	list := polygon showLispList.
	polygon := polygon class fromLispList: list.
	polygon showLispList.
	^polygon
]

{ #category : #examples }
JunOpenGL3dPolygon class >> example2 [
	"JunOpenGL3dPolygon example2."

	| polygon list |
	polygon := JunOpenGL3dPolygon vertexes: (Array
					with: 0.0d , 0.0d , 1.0d
					with: 1.0d , 0.0d , 1.0d
					with: 1.0d , 1.0d , 1.0d
					with: 0.0d , 1.0d , 1.0d).
	polygon name: 'example'.
	polygon paint: ColorValue gray.
	polygon alpha: 0.75.
	polygon halftone.
	list := polygon showLispList.
	polygon := polygon class fromLispList: list.
	polygon showLispList.
	^polygon
]

{ #category : #examples }
JunOpenGL3dPolygon class >> example3 [
	"JunOpenGL3dPolygon example3."

	| file polygon stream |
	file := JunUniFileModel requestNewFileName: 'zzz.lst'.
	file isNil ifTrue: [^self].
	polygon := JunOpenGL3dPolygon vertexes: (Array
					with: 0.0d , 0.0d , 1.0d
					with: 1.0d , 0.0d , 1.0d
					with: 1.0d , 1.0d , 1.0d
					with: 0.0d , 1.0d , 1.0d).
	polygon name: 'example'.
	polygon paint: ColorValue gray.
	polygon alpha: 0.75.
	polygon halftone.
	stream := file writeStream.
	[Cursor write showWhile: [polygon saveOn: stream]]
		ensure: [stream close].
	stream := file readStream.
	[Cursor read showWhile: [polygon := polygon class loadFrom: stream]]
		ensure: [stream close].
	polygon show.
	^polygon
]

{ #category : #examples }
JunOpenGL3dPolygon class >> example4 [
	"JunOpenGL3dPolygon example4."

	| polygon image texture file stream |
	polygon := JunOpenGL3dPolygon vertexes: (Array 
						with: 0.0d , 0.0d , 1.0d
						with: 1.0d , 0.0d , 1.0d
						with: 1.0d , 1.0d , 1.0d
						with: 0.0d , 1.0d , 1.0d).
	polygon name: 'example'.
	polygon paint: ColorValue gray.
	polygon alpha: 0.75.
	polygon halftone.
	image := JunImageUtility fromDisplay: (10 @ 10 extent: 64 @ 64).
	texture := JunOpenGLTexture image: image.
	texture coordinates: (Array 
				with: 0.0 , 0.0
				with: 1.0 , 0.0
				with: 1.0 , 1.0
				with: 0.0 , 1.0).
	polygon texture: texture.
	file := JunUniFileModel requestNewFileName: 'zzz.lst'.
	file isNil ifTrue: [^self].
	stream := file writeStream.
	[Cursor write showWhile: [polygon saveOn: stream]] ensure: [stream close].
	stream := file readStream.
	[Cursor read showWhile: [polygon := polygon class loadFrom: stream]] 
		ensure: [stream close].
	polygon show.
	^polygon
]

{ #category : #examples }
JunOpenGL3dPolygon class >> example5 [
	"JunOpenGL3dPolygon example5."

	| polygon displayModel |
	polygon := JunOpenGL3dPolygon vertexes: (Array 
						with: 0.0d , 0.0d , 1.0d
						with: 1.0d , 0.0d , 1.0d
						with: 1.0d , 1.0d , 1.0d
						with: 0.0d , 1.0d , 1.0d).
	polygon name: 'example'.
	polygon colors: (Array 
				with: ColorValue red
				with: ColorValue yellow
				with: ColorValue red
				with: ColorValue blue).
	polygon alpha: 0.75.
	displayModel := JunOpenGLDisplayModel new.
	displayModel displayObject: polygon.
	displayModel defaultShading: #smoothShading.
	displayModel open.
	^polygon
]

{ #category : #examples }
JunOpenGL3dPolygon class >> example6 [
	"JunOpenGL3dPolygon example6."

	| polygon displayModel |
	polygon := self example5.
	polygon := polygon class fromLispList: polygon showLispList.
	displayModel := JunOpenGLDisplayModel new.
	displayModel displayObject: polygon.
	displayModel defaultShading: #smoothShading.
	displayModel open.
	^polygon
]

{ #category : #examples }
JunOpenGL3dPolygon class >> example7 [
	"JunOpenGL3dPolygon example7."

	| pointsAndColors createPolygon compoundObject displayModel |
	pointsAndColors := Dictionary new.
	pointsAndColors 
		add: #black -> (Array with: 0 , 0 , 0 with: ColorValue black).
	pointsAndColors 
		add: #white -> (Array with: 1 , 1 , 1 with: ColorValue white).
	pointsAndColors add: #red -> (Array with: 1 , 0 , 0 with: ColorValue red).
	pointsAndColors 
		add: #green -> (Array with: 0 , 1 , 0 with: ColorValue green).
	pointsAndColors 
		add: #blue -> (Array with: 0 , 0 , 1 with: ColorValue blue).
	pointsAndColors 
		add: #cyan -> (Array with: 0 , 1 , 1 with: ColorValue cyan).
	pointsAndColors 
		add: #magenta -> (Array with: 1 , 0 , 1 with: ColorValue magenta).
	pointsAndColors 
		add: #yellow -> (Array with: 1 , 1 , 0 with: ColorValue yellow).
	createPolygon := 
			[:array | 
			(JunOpenGL3dPolygon 
				vertexes: (array collect: [:each | (pointsAndColors at: each) first])
				colors: (array collect: [:each | (pointsAndColors at: each) last])) 
					yourself].
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: (createPolygon value: #(#red #magenta #blue #black)).
	compoundObject add: (createPolygon value: #(#green #black #blue #cyan)).
	compoundObject add: (createPolygon value: #(#blue #magenta #white #cyan)).
	compoundObject add: (createPolygon value: #(#cyan #white #yellow #green)).
	compoundObject add: (createPolygon value: #(#magenta #red #yellow #white)).
	compoundObject add: (createPolygon value: #(#yellow #red #black #green)).
	displayModel := JunOpenGLDisplayModel displayObject: compoundObject.
	displayModel defaultShading: #smoothShading.
	displayModel open.
	^compoundObject
]

{ #category : #examples }
JunOpenGL3dPolygon class >> example8 [
	"JunOpenGL3dPolygon example8."

	| polygon body |
	polygon := JunOpenGL3dPolygon vertexes: (Array 
						with: 0.0d , 0.0d , 1.0d
						with: 1.0d , 0.0d , 1.0d
						with: 1.0d , 1.0d , 1.0d
						with: 0.0d , 1.0d , 1.0d).
	body := JunOpenGL3dCompoundObject new.
	polygon asTriangles 
		do: [:triangle | body add: triangle asJunOpenGL3dObject].
	body add: (JunOpenGL3dObject xyzArrows scaledBy: 2).
	body showProjectionTable: ((Dictionary new)
				add: #upVector -> (0 , 0 , 1);
				add: #zoomHeight -> 4;
				add: #eyePoint -> (15 , 15 , 15);
				add: #viewFactor -> 10;
				add: #shading -> #smoothShading;
				add: #presentation -> #hiddenlinePresentation;
				add: #sightPoint -> (0 , 0 , 0);
				yourself).
	^body
]

{ #category : #utilities }
JunOpenGL3dPolygon class >> polygonsFromVertexes: aPolyline1 andVertexes: aPolyline2 [ 
	"
	| polyline1 polyline2 polygons object | 
	polyline1 := JunOpenGL3dPolyline vertexes: (Array 
	with: 0.0d , 0.0d , 1.0d 
	with: 1.0d , 0.0d , 1.0d 
	with: 1.0d , 1.0d , 1.0d 
	with: 0.0d , 1.0d , 1.0d). 
	polyline2 := JunOpenGL3dPolyline vertexes: (Array 
	with: 0.0d , 0.0d , 2.0d 
	with: 1.0d , 0.0d , 2.0d 
	with: 1.0d , 1.0d , 2.0d 
	with: 0.0d , 1.0d , 2.0d). 
	polygons := JunOpenGL3dPolygon polygonsFromVertexes: polyline1 andVertexes: polyline2. 
	object := JunOpenGL3dCompoundObject components: polygons. 
	object paint: JunOpenGL3dPolygon defaultPaint. 
	object show. 
	^polygons 
	"

	| points1 points2 pairs distances polygons |
	(aPolyline1 isKindOf: JunOpenGL3dVertexesObject) 
		ifTrue: [points1 := aPolyline1 vertexes asArray]
		ifFalse: [points1 := aPolyline1 asArray].
	(aPolyline2 isKindOf: JunOpenGL3dVertexesObject) 
		ifTrue: [points2 := aPolyline2 vertexes asArray]
		ifFalse: [points2 := aPolyline2 asArray].
	pairs := OrderedCollection new: points2 size.
	points1 size = points2 size 
		ifTrue: 
			[points2 with: points1
				do: 
					[:p2 :p1 | 
					| array |
					array := Array with: p2 with: p1.
					pairs add: array]]
		ifFalse: 
			[points2 do: 
					[:p2 | 
					distances := OrderedCollection new: points1 size.
					points1 do: 
							[:p1 | 
							| array |
							array := Array with: p1 with: (p2 distance: p1).
							distances add: array].
					distances := distances asSortedCollection: [:a1 :a2 | a1 last < a2 last].
					distances isEmpty 
						ifFalse: 
							[| array |
							array := Array with: p2 with: distances first first.
							pairs add: array]]].
	polygons := OrderedCollection new: points2 size + 1.
	pairs size < 2 ifTrue: [^polygons asArray].
	pairs add: pairs first.
	2 to: pairs size
		do: 
			[:index | 
			| previous current vertexes |
			previous := pairs at: index - 1.
			current := pairs at: index.
			vertexes := OrderedCollection new: 5.
			vertexes add: previous first.
			vertexes add: current first.
			vertexes add: current last.
			vertexes add: previous last.
			vertexes add: vertexes first.
			polygons add: (self vertexes: vertexes)].
	^polygons asArray
]

{ #category : #utilities }
JunOpenGL3dPolygon class >> polygonsFromVertexesObjects: vertexesObjects [ 
	"
	| polyline1 polyline2 polylines polygons object | 
	polyline1 := JunOpenGL3dPolyline vertexes: (Array 
	with: 0.0d , 0.0d , 1.0d 
	with: 1.0d , 0.0d , 1.0d 
	with: 1.0d , 1.0d , 1.0d 
	with: 0.0d , 1.0d , 1.0d). 
	polyline2 := JunOpenGL3dPolyline vertexes: (Array 
	with: 0.0d , 0.0d , 2.0d 
	with: 1.0d , 0.0d , 2.0d 
	with: 1.0d , 1.0d , 2.0d 
	with: 0.0d , 1.0d , 2.0d). 
	polylines := Array with: polyline1 with: polyline2. 
	polygons := JunOpenGL3dPolygon polygonsFromVertexesObjects: polylines. 
	object := JunOpenGL3dCompoundObject components: polygons. 
	object paint: JunOpenGL3dPolygon defaultPaint. 
	object show. 
	^polygons 
	"

	| collection |
	collection := OrderedCollection new: vertexesObjects size.
	vertexesObjects size < 2 ifTrue: [^collection asArray].
	2 to: vertexesObjects size
		do: 
			[:index | 
			| polygons |
			polygons := self polygonsFromVertexes: (vertexesObjects at: index - 1)
						andVertexes: (vertexesObjects at: index).
			collection addAll: polygons].
	^collection asArray
]

{ #category : #'lisp support' }
JunOpenGL3dPolygon class >> stippleFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #stipple]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject stipple: (JunOpenGLStipple image: list tail).
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dPolygon class >> system [
	^'Jun'
]

{ #category : #'lisp support' }
JunOpenGL3dPolygon class >> textureFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #texture]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject texture: (JunOpenGLTexture fromLispList: list tail).
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dPolygon class >> version [
	^'799'
]

{ #category : #private }
JunOpenGL3dPolygon >> _findAdjacentOnLeft: vertex from: polygons [ 
	| vertex2 |
	vertex2 := self previousVertexOf: vertex.
	vertex2 isNil ifTrue: [^nil].
	polygons 
		do: [:polygon | (vertex2 equal: (polygon nextVertexOf: vertex)) ifTrue: [^polygon]].
	^nil
]

{ #category : #private }
JunOpenGL3dPolygon >> _findAdjacentOnRight: vertex from: polygons [ 
	| vertex2 |
	vertex2 := self nextVertexOf: vertex.
	vertex2 isNil ifTrue: [^nil].
	polygons 
		do: [:polygon | (vertex2 equal: (polygon previousVertexOf: vertex)) ifTrue: [^polygon]].
	^nil
]

{ #category : #converting }
JunOpenGL3dPolygon >> asArrayOfLines [
	| collection polyline |
	collection := self vertexes copy asOrderedCollection.
	(collection first equal: collection last) 
		ifFalse: [collection add: collection first].
	polyline := Jun3dPolyline vertexes: collection.
	^polyline asArrayOfLines
]

{ #category : #enumerating }
JunOpenGL3dPolygon >> geometriesDo: aBlock [ 
	aBlock value: (Jun3dPolygon points: vertexes)
]

{ #category : #accessing }
JunOpenGL3dPolygon >> halftone: halftoneScale [ 
	self stipple: (JunOpenGLStipple halftone: halftoneScale)
]

{ #category : #testing }
JunOpenGL3dPolygon >> hasStipple [
	^stipple notNil
]

{ #category : #testing }
JunOpenGL3dPolygon >> hasTexture [
	^texture notNil
]

{ #category : #'initialize-release' }
JunOpenGL3dPolygon >> initialize [
	super initialize.
	stipple := nil
]

{ #category : #testing }
JunOpenGL3dPolygon >> isPolygon [
	^true
]

{ #category : #'lisp support' }
JunOpenGL3dPolygon >> kindName [
	^#Polygon
]

{ #category : #utilities }
JunOpenGL3dPolygon >> numberOfPolygons [
	^1
]

{ #category : #utilities }
JunOpenGL3dPolygon >> numberOfPolylines [
	^0
]

{ #category : #enumerating }
JunOpenGL3dPolygon >> polygonsDo: aBlock [ 
	aBlock value: self
]

{ #category : #'obj support' }
JunOpenGL3dPolygon >> privateToOBJUsing: aJunOBJWriter [ 
	self hasMaterial 
		ifTrue: [aJunOBJWriter deriveMaterialFor: self]
		ifFalse: 
			[self hasColors ifTrue: [aJunOBJWriter deriveColorsBasedMaterialFor: self]].
	aJunOBJWriter addPolygon: self vertexes normalVectors: self normalVectors
]

{ #category : #rendering }
JunOpenGL3dPolygon >> renderOn: aRenderingContext [ 
	| savedLineWidth oldTextureCoordinateIndex theNormalVectors |
	savedLineWidth := aRenderingContext lineWidth.
	savedLineWidth notNil ifTrue: [aRenderingContext lineWidth: 1].
	self hasPaint ifTrue: [aRenderingContext paint: self paint].
	self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
	self hasStipple ifTrue: [self stipple enableStippleOn: aRenderingContext].
	self hasTexture 
		ifTrue: 
			[oldTextureCoordinateIndex := aRenderingContext textureCoordinateIndex.
			aRenderingContext textureCoordinateIndex: 1.
			self texture enableTextureOn: aRenderingContext].
	self hasTransparency 
		ifTrue: 
			[aRenderingContext enableCullFace.
			aRenderingContext disableDepthMask.
			aRenderingContext enableBlending].
	theNormalVectors := nil.
	aRenderingContext shading == #flat 
		ifTrue: [theNormalVectors := Array with: self normalVector]
		ifFalse: [theNormalVectors := self normalVectors].
	aRenderingContext 
		displayPolygon: self vertexes
		colors: self colors
		normalVectors: theNormalVectors.
	self hasTransparency 
		ifTrue: 
			[aRenderingContext disableCullFace.
			aRenderingContext enableDepthMask.
			aRenderingContext disableBlending].
	self hasTexture 
		ifTrue: 
			[self texture disableTextureOn: aRenderingContext.
			aRenderingContext textureCoordinateIndex: oldTextureCoordinateIndex].
	self hasStipple ifTrue: [self stipple disableStippleOn: aRenderingContext].
	savedLineWidth notNil 
		ifTrue: [aRenderingContext lineWidth: savedLineWidth]
]

{ #category : #accessing }
JunOpenGL3dPolygon >> stipple [
	^stipple
]

{ #category : #accessing }
JunOpenGL3dPolygon >> stipple: aStipple [ 
	stipple := aStipple
]

{ #category : #'lisp support' }
JunOpenGL3dPolygon >> stippleToLispList [
	| list |
	self hasStipple ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #stipple.
	list tail: self stipple image.
	^list
]

{ #category : #accessing }
JunOpenGL3dPolygon >> texture [
	^texture
]

{ #category : #accessing }
JunOpenGL3dPolygon >> texture: aTexture [ 
	texture := aTexture.
	aTexture isNil ifFalse: [aTexture object: self]
]

{ #category : #'lisp support' }
JunOpenGL3dPolygon >> textureToLispList [
	| list |
	self hasTexture ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #texture.
	list tail: self texture toLispList.
	^list
]

{ #category : #'obj support' }
JunOpenGL3dPolygon >> toOBJUsing: aJunOBJWriter [ 
	| oldTextureCoordinateIndex |
	self hasTexture 
		ifTrue: 
			[oldTextureCoordinateIndex := aJunOBJWriter textureCoordinateIndex.
			aJunOBJWriter textureCoordinateIndex: 1].
	self privateToOBJUsing: aJunOBJWriter.
	self hasTexture 
		ifTrue: [aJunOBJWriter textureCoordinateIndex: oldTextureCoordinateIndex]
]

{ #category : #accessing }
JunOpenGL3dPolygon >> vertexes: aCollectionOf3dPoints [ 
	aCollectionOf3dPoints size < 3 ifTrue: [^self error: 'few vertexes'].
	super vertexes: aCollectionOf3dPoints
]

{ #category : #'vrml support' }
JunOpenGL3dPolygon >> vrml10IndexedSetName [
	^'IndexedFaceSet' copy
]

{ #category : #'vrml support' }
JunOpenGL3dPolygon >> vrml20IndexedSetName [
	^'IndexedFaceSet' copy
]

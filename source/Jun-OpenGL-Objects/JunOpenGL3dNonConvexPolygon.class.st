"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGL3dNonConvexPolygon,
	#superclass : #JunOpenGL3dVertexesObject,
	#instVars : [
		'stipple',
		'texture',
		'holes',
		'triangles'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #copyright }
JunOpenGL3dNonConvexPolygon class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGL3dNonConvexPolygon class >> example1 [
	"JunOpenGL3dNonConvexPolygon example1."

	| outline hole nonConvexPolygon |
	outline := Array
				with: 0 , 0 , 0
				with: 1 , 0 , 0
				with: 1 , 1 , 0
				with: 0 , 1 , 0.
	hole := Array
				with: 0.1 , 0.9 , 0
				with: 0.9 , 0.9 , 0
				with: 0.9 , 0.1 , 0
				with: 0.1 , 0.1 , 0.
	nonConvexPolygon := JunOpenGL3dNonConvexPolygon
				vertexes: outline
				holes: (Array with: hole)
				paint: ColorValue blue.
	nonConvexPolygon show.
	^nonConvexPolygon
]

{ #category : #'lisp support' }
JunOpenGL3dNonConvexPolygon class >> fromLispList: aList [ 
	| object |
	object := self new.
	object := self propertiesFromLispList: aList for: object.
	object := self colorFromLispList: aList for: object.
	object := self stippleFromLispList: aList for: object.
	object := self textureFromLispList: aList for: object.
	object := self vertexesFromLispList: aList for: object.
	object := self holesFromLispList: aList for: object.
	object := self transformationFromLispList: aList for: object.
	object computeTriangles.
	^object
]

{ #category : #'lisp support' }
JunOpenGL3dNonConvexPolygon class >> holesFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #holes]]
				ifNone: [nil].
	list notNil ifTrue: [a3dObject holes: (list tail asArray collect: [:pointList | pointList asArray])].
	^a3dObject
]

{ #category : #'lisp support' }
JunOpenGL3dNonConvexPolygon class >> stippleFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #stipple]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject stipple: (JunOpenGLStipple image: list tail).
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dNonConvexPolygon class >> system [
	^'Jun'
]

{ #category : #'lisp support' }
JunOpenGL3dNonConvexPolygon class >> textureFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #texture]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject texture: (JunOpenGLTexture fromLispList: list tail).
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dNonConvexPolygon class >> version [
	^'799'
]

{ #category : #'instance creation' }
JunOpenGL3dNonConvexPolygon class >> vertexes: aCollectionOfJun3dPoints [ 
	^self
		vertexes: aCollectionOfJun3dPoints
		holes: Array new
		triangles: nil
		paint: nil
		alpha: nil
]

{ #category : #'instance creation' }
JunOpenGL3dNonConvexPolygon class >> vertexes: aCollectionOfJun3dPoints holes: aCollectionOfCollectionOfJun3dPoints1 [ 
	^self
		vertexes: aCollectionOfJun3dPoints
		holes: aCollectionOfCollectionOfJun3dPoints1
		triangles: nil
		paint: nil
		alpha: nil
]

{ #category : #'instance creation' }
JunOpenGL3dNonConvexPolygon class >> vertexes: aCollectionOfJun3dPoints holes: aCollectionOfCollectionOfJun3dPoints1 paint: aColorValue [ 
	^self
		vertexes: aCollectionOfJun3dPoints
		holes: aCollectionOfCollectionOfJun3dPoints1
		triangles: nil
		paint: aColorValue
		alpha: nil
]

{ #category : #'instance creation' }
JunOpenGL3dNonConvexPolygon class >> vertexes: aCollectionOfJun3dPoints holes: aCollectionOfCollectionOfJun3dPoints1 paint: aColorValue alpha: aNumber [ 
	^self
		vertexes: aCollectionOfJun3dPoints
		holes: aCollectionOfCollectionOfJun3dPoints1
		triangles: nil
		paint: aColorValue
		alpha: aNumber
]

{ #category : #'instance creation' }
JunOpenGL3dNonConvexPolygon class >> vertexes: aCollectionOfJun3dPoints holes: aCollectionOfCollectionOfJun3dPoints1 triangles: aCollectionOfCollectionOfJun3dPoints2 [
	^self
		vertexes: aCollectionOfJun3dPoints
		holes: aCollectionOfCollectionOfJun3dPoints1
		triangles: aCollectionOfCollectionOfJun3dPoints2
		paint: nil
		alpha: nil
]

{ #category : #'instance creation' }
JunOpenGL3dNonConvexPolygon class >> vertexes: aCollectionOfJun3dPoints holes: aCollectionOfCollectionOfJun3dPoints1 triangles: aCollectionOfCollectionOfJun3dPoints2 paint: aColorValue [ 
	^self
		vertexes: aCollectionOfJun3dPoints
		holes: aCollectionOfCollectionOfJun3dPoints1
		triangles: aCollectionOfCollectionOfJun3dPoints2
		paint: aColorValue
		alpha: nil
]

{ #category : #'instance creation' }
JunOpenGL3dNonConvexPolygon class >> vertexes: aCollectionOfJun3dPoints holes: aCollectionOfCollectionOfJun3dPoints1 triangles: aCollectionOfCollectionOfJun3dPoints2 paint: aColorValue alpha: aNumber [ 
	| nonConvexPolygon |
	nonConvexPolygon := self new.
	nonConvexPolygon
		setVertexes: aCollectionOfJun3dPoints
		holes: aCollectionOfCollectionOfJun3dPoints1
		triangles: aCollectionOfCollectionOfJun3dPoints2
		paint: aColorValue
		alpha: aNumber.
	^nonConvexPolygon
]

{ #category : #'instance creation' }
JunOpenGL3dNonConvexPolygon class >> vertexes: aCollectionOfJun3dPoints paint: aColorValue [ 
	^self
		vertexes: aCollectionOfJun3dPoints
		holes: Array new
		triangles: nil
		paint: aColorValue
		alpha: nil
]

{ #category : #'instance creation' }
JunOpenGL3dNonConvexPolygon class >> vertexes: aCollectionOfJun3dPoints paint: aColorValue alpha: aNumber [ 
	^self
		vertexes: aCollectionOfJun3dPoints
		holes: Array new
		triangles: nil
		paint: aColorValue
		alpha: aNumber
]

{ #category : #converting }
JunOpenGL3dNonConvexPolygon >> asCompoundOfTriangles [
	| compound |
	compound := JunOpenGL3dCompoundObject components: (self triangles
					collect: 
						[:vertices | 
						| triangle |
						triangle := JunOpenGL3dPolygon vertexes: vertices.
						triangle stipple: self stipple.
						triangle]).
	compound name: self name.
	compound paint: self paint.
	compound alpha: self alpha.
	compound texture: self texture.
	^compound
]

{ #category : #private }
JunOpenGL3dNonConvexPolygon >> computeTriangles [
	triangles isNil
		ifTrue: 
			[| plane boundaries triangleStream |
			plane := JunParametricPlane vertices: self vertexes.
			boundaries := OrderedCollection new: self holes size + 1.
			boundaries add: (Jun2dParametricClosedCurve vertices: (self vertexes collect: [:vertex | plane uvAtPoint: vertex])).
			self holes do: [:hole | boundaries add: (Jun2dParametricClosedCurve vertices: (hole collect: [:vertex | plane uvAtPoint: vertex]))].
			triangleStream := Array new writeStream.
			(JunParametricCurveBoundedPlane on: plane boundaries: boundaries)
				trianglesDo: [:v1 :v2 :v3 | triangleStream nextPut: (Array
							with: v1
							with: v2
							with: v3)].
			triangles := triangleStream contents]
]

{ #category : #enumerating }
JunOpenGL3dNonConvexPolygon >> geometriesDo: aBlock [ 
	self triangles do: [:triangle | aBlock value: (Jun3dPolygon points: triangle)]
]

{ #category : #accessing }
JunOpenGL3dNonConvexPolygon >> halftone: halftoneScale [ 
	self stipple: (JunOpenGLStipple halftone: halftoneScale)
]

{ #category : #testing }
JunOpenGL3dNonConvexPolygon >> hasStipple [
	^stipple notNil
]

{ #category : #testing }
JunOpenGL3dNonConvexPolygon >> hasTexture [
	^texture notNil
]

{ #category : #accessing }
JunOpenGL3dNonConvexPolygon >> holes [
	^holes
]

{ #category : #accessing }
JunOpenGL3dNonConvexPolygon >> holes: anArrayOfArrayOfJun3dPoint [ 
	holes := anArrayOfArrayOfJun3dPoint
]

{ #category : #'lisp support' }
JunOpenGL3dNonConvexPolygon >> holesToLispList [
	| list |
	list := self lispCons.
	list head: #holes.
	list tail: (self defaultLispConsClass list: (holes collect: [:hole | self defaultLispConsClass list: hole])).
	^list
]

{ #category : #'lisp support' }
JunOpenGL3dNonConvexPolygon >> kindName [
	^#NonConvexPolygon
]

{ #category : #utilities }
JunOpenGL3dNonConvexPolygon >> numberOfPolygons [
	^1
]

{ #category : #utilities }
JunOpenGL3dNonConvexPolygon >> numberOfPolylines [
	^0
]

{ #category : #enumerating }
JunOpenGL3dNonConvexPolygon >> pointsDo: aBlock [ 
	vertexes do: aBlock.
	holes do: [:hole | hole do: aBlock]
]

{ #category : #rendering }
JunOpenGL3dNonConvexPolygon >> renderOn: aRenderingContext [ 
	| oldTextureCoordinateIndex |
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
	aRenderingContext
		displayTriangles: self triangles
		outline: self vertexes
		holes: self holes
		normalVector: self normalVector.
	self hasTransparency
		ifTrue: 
			[aRenderingContext disableCullFace.
			aRenderingContext enableDepthMask.
			aRenderingContext disableBlending].
	self hasTexture
		ifTrue: 
			[self texture disableTextureOn: aRenderingContext.
			aRenderingContext textureCoordinateIndex: oldTextureCoordinateIndex].
	self hasStipple ifTrue: [self stipple disableStippleOn: aRenderingContext]
]

{ #category : #converting }
JunOpenGL3dNonConvexPolygon >> reversed [
	| reversed |
	reversed := self copy.
	reversed vertexes: self vertexes reverse.
	reversed holes: (self holes collect: [:hole | hole reverse]).
	reversed triangles: (self triangles collect: [:triangle | triangle reverse]).
	^reversed
]

{ #category : #private }
JunOpenGL3dNonConvexPolygon >> setVertexes: anArrayOfJun3dPoints holes: anArrayOfArrayOfJun3dPoints1 triangles: anArrayOfArrayOfJun3dPoints2 paint: aPaint alpha: aNumber [ 
	vertexes := anArrayOfJun3dPoints.
	holes := anArrayOfArrayOfJun3dPoints1.
	self computeTriangles.
	paint := aPaint.
	alpha := aNumber
]

{ #category : #private }
JunOpenGL3dNonConvexPolygon >> setVertexes: anArrayOfJun3dPoints paint: aPaint alpha: aNumber [ 
	self
		setVertexes: anArrayOfJun3dPoints
		holes: Array new
		triangles: nil
		paint: aPaint
		alpha: aNumber
]

{ #category : #accessing }
JunOpenGL3dNonConvexPolygon >> stipple [
	^stipple
]

{ #category : #accessing }
JunOpenGL3dNonConvexPolygon >> stipple: aStipple [ 
	stipple := aStipple
]

{ #category : #'lisp support' }
JunOpenGL3dNonConvexPolygon >> stippleToLispList [
	| list |
	self hasStipple ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #stipple.
	list tail: self stipple image.
	^list
]

{ #category : #accessing }
JunOpenGL3dNonConvexPolygon >> texture [
	^texture
]

{ #category : #accessing }
JunOpenGL3dNonConvexPolygon >> texture: aTexture [ 
	texture := aTexture.
	aTexture isNil ifFalse: [aTexture object: self]
]

{ #category : #'lisp support' }
JunOpenGL3dNonConvexPolygon >> textureToLispList [
	| list |
	self hasTexture ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #texture.
	list tail: self texture toLispList.
	^list
]

{ #category : #'lisp support' }
JunOpenGL3dNonConvexPolygon >> toLispList [
	| list |
	list := self lispCons.
	list head: self kindName.
	self hasProperties ifTrue: [list add: self propertiesToLispList].
	self hasColor ifTrue: [list add: self colorToLispList].
	self hasStipple ifTrue: [list add: self stippleToLispList].
	self hasTexture ifTrue: [list add: self textureToLispList].
	list add: self vertexesToLispList.
	list add: self holesToLispList.
	^list
]

{ #category : #transforming }
JunOpenGL3dNonConvexPolygon >> transform: aTransformation [ 
	| object |
	object := self copy.
	object vertexes: (self vertexes collect: [:p | p transform: aTransformation]).
	object holes: (self holes collect: [:hole | hole collect: [:p | p transform: aTransformation]]).
	object triangles: (self triangles collect: [:triangle | triangle collect: [:p | p transform: aTransformation]]).
	^object
]

{ #category : #accessing }
JunOpenGL3dNonConvexPolygon >> triangles [
	triangles isNil ifTrue: [ self computeTriangles].
	^triangles
]

{ #category : #accessing }
JunOpenGL3dNonConvexPolygon >> triangles: anArrayOfArrayOfJun3dPoint [
	triangles := anArrayOfArrayOfJun3dPoint
]

{ #category : #accessing }
JunOpenGL3dNonConvexPolygon >> vertexes: aCollectionOf3dPoints [ 
	aCollectionOf3dPoints size < 3 ifTrue: [^self error: 'few vertexes'].
	super vertexes: aCollectionOf3dPoints
]

{ #category : #'vrml support' }
JunOpenGL3dNonConvexPolygon >> vrml10On: aStream [ 
	^self asCompoundOfTriangles vrml10On: aStream
]

{ #category : #'vrml support' }
JunOpenGL3dNonConvexPolygon >> vrml20On: aStream [ 
	self asCompoundOfTriangles vrml20On: aStream
]

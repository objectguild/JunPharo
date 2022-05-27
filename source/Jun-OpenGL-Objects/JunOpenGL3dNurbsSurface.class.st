"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGL3dNurbsSurface,
	#superclass : #JunOpenGL3dPrimitiveObject,
	#instVars : [
		'stipple',
		'texture',
		'controlPoints',
		'uKnotVector',
		'vKnotVector',
		'weights',
		'trimCurves'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #'instance creation' }
JunOpenGL3dNurbsSurface class >> bSplineControlPoints: aMatrix uKnotVector: anArray1 vKnotVector: anArray2 [ 
	| rowSize columnSize |
	rowSize := aMatrix rowSize.
	columnSize := aMatrix columnSize.
	^self
		controlPoints: aMatrix
		weights: (JunMatrix
				new: rowSize
				by: columnSize
				collection: (Array new: rowSize * columnSize withAll: 1))
		uKnotVector: anArray1
		vKnotVector: anArray2
]

{ #category : #'instance creation' }
JunOpenGL3dNurbsSurface class >> bezierControlPoints: aMatrix [ 
	| columnSize rowSize uKnotVector vKnotVector |
	columnSize := aMatrix columnSize.
	rowSize := aMatrix rowSize.
	uKnotVector := Array new: rowSize * 2.
	1 to: rowSize
		do: 
			[:index | 
			uKnotVector at: index put: 0.0.
			uKnotVector at: index + rowSize put: 1.0].
	vKnotVector := Array new: columnSize * 2.
	1 to: columnSize
		do: 
			[:index | 
			vKnotVector at: index put: 0.0.
			vKnotVector at: index + columnSize put: 1.0].
	^self
		bSplineControlPoints: aMatrix
		uKnotVector: uKnotVector
		vKnotVector: vKnotVector
]

{ #category : #'instance creation' }
JunOpenGL3dNurbsSurface class >> controlPoints: aMatrix1 weights: aMatrix2 uKnotVector: anArray1 vKnotVector: anArray2 [
	^self new
		controlPoints: aMatrix1
		weights: aMatrix2
		uKnotVector: anArray1
		vKnotVector: anArray2
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface class >> controlsFromLispList: aList for: a3dObject [ 
	| list rows columns collection matrix |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #controls]]
				ifNone: [nil].
	list isNil
		ifTrue: [a3dObject controlPoints: JunMatrix new]
		ifFalse: 
			[list := list tail.
			rows := list head.
			list := list tail.
			columns := list head.
			list := list tail.
			collection := list asArray.
			matrix := JunMatrix
						new: rows
						by: columns
						collection: collection.
			a3dObject controlPoints: matrix].
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dNurbsSurface class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGL3dNurbsSurface class >> example1 [
	"JunOpenGL3dNurbsSurface example1."

	| nurbs list |
	nurbs := JunOpenGL3dNurbsSurface exampleBezierSurface.
	list := nurbs showLispList.
	nurbs := nurbs class fromLispList: list.
	nurbs showLispList.
	^nurbs
]

{ #category : #examples }
JunOpenGL3dNurbsSurface class >> example2 [
	"JunOpenGL3dNurbsSurface example2."

	| nurbs list |
	nurbs := JunOpenGL3dNurbsSurface exampleBezierSurface.
	nurbs name: 'example'.
	nurbs paint: ColorValue gray.
	nurbs alpha: 0.75.
	nurbs halftone.
	list := nurbs showLispList.
	nurbs := nurbs class fromLispList: list.
	nurbs showLispList.
	^nurbs
]

{ #category : #examples }
JunOpenGL3dNurbsSurface class >> example3 [
	"JunOpenGL3dNurbsSurface example3."

	| file nurbs stream |
	file := JunUniFileModel requestNewFileName: 'zzz.lst'.
	file isNil ifTrue: [^self].
	nurbs := JunOpenGL3dNurbsSurface exampleBezierSurface.
	nurbs name: 'example'.
	nurbs paint: ColorValue gray.
	nurbs alpha: 0.75.
	nurbs halftone.
	stream := file writeStream.
	[Cursor write showWhile: [nurbs saveOn: stream]]
		ensure: [stream close].
	stream := file readStream.
	[Cursor read showWhile: [nurbs := nurbs class loadFrom: stream]]
		ensure: [stream close].
	nurbs show.
	^nurbs
]

{ #category : #examples }
JunOpenGL3dNurbsSurface class >> example4 [
	"JunOpenGL3dNurbsSurface example4."

	| nurbs |
	nurbs := JunOpenGL3dNurbsSurface exampleBSplineSurface.
	nurbs name: 'example'.
	nurbs paint: ColorValue red.
	nurbs show.
	^nurbs
]

{ #category : #examples }
JunOpenGL3dNurbsSurface class >> example5 [
	"JunOpenGL3dNurbsSurface example5."

	| nurbs |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsSurface.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^nurbs
]

{ #category : #examples }
JunOpenGL3dNurbsSurface class >> example6 [
	"JunOpenGL3dNurbsSurface example6."

	| nurbs image texture file stream |
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsSurface.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs halftone: 0.75.
	image := JunImageUtility fromDisplay: (10 @ 10 extent: 64 @ 64).
	texture := JunOpenGLTexture image: image.
	nurbs texture: texture.
	file := JunUniFileModel requestNewFileName: 'zzz.lst'.
	file isNil ifTrue: [^self].
	stream := file writeStream.
	[Cursor write showWhile: [nurbs saveOn: stream]] ensure: [stream close].
	stream := file readStream.
	[Cursor read showWhile: [nurbs := nurbs class loadFrom: stream]] 
		ensure: [stream close].
	nurbs show.
	^nurbs
]

{ #category : #examples }
JunOpenGL3dNurbsSurface class >> example7 [
	"JunOpenGL3dNurbsSurface example7."

	| body nurbs |
	body := JunOpenGL3dCompoundObject new.
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsSurface.
	nurbs name: 'red'.
	nurbs paint: ColorValue red.
	body add: nurbs.
	nurbs := JunOpenGL3dNurbsSurface exampleNurbsSurface.
	nurbs name: 'blue'.
	nurbs paint: ColorValue blue.
	nurbs := nurbs rotatedBy: 60.
	body add: nurbs.
	body show.
	^body
]

{ #category : #examples }
JunOpenGL3dNurbsSurface class >> exampleBSplineSurface [
	"JunOpenGL3dNurbsSurface exampleBSplineSurface show."

	| controlPoints knots |
	controlPoints := JunMatrix new: 4.
	1 to: 4 do: [:x | 1 to: 4 do: [:y | controlPoints atPoint: x @ y put: (Jun3dPoint
					x: x - 2.5 * 2 / 3
					y: y - 2.5 * 2 / 3
					z: (((x = 2 or: [x = 3])
							and: [y = 2 or: [y = 3]])
							ifTrue: [1]
							ifFalse: [-1]))]].
	knots := #(0.0 0.0 0.5 0.5 1.0 1.0 1.0 1.0).
	^JunOpenGL3dNurbsSurface
		bSplineControlPoints: (JunMatrix new: 4 collection: controlPoints)
		uKnotVector: knots
		vKnotVector: knots
]

{ #category : #examples }
JunOpenGL3dNurbsSurface class >> exampleBezierSurface [
	"JunOpenGL3dNurbsSurface exampleBezierSurface show."

	| controlPoints |
	controlPoints := JunMatrix new: 4 by: 6.
	1 to: 4 do: [:x | 1 to: 6 do: [:y | controlPoints atPoint: x @ y put: (Jun3dPoint
					x: x - 2.5 / 3
					y: y - 2.5 / 3
					z: (((x = 2 or: [x = 3])
							and: [y = 2 or: [y = 3]])
							ifTrue: [1]
							ifFalse: [-1]))]].
	^JunOpenGL3dNurbsSurface bezierControlPoints: controlPoints
]

{ #category : #examples }
JunOpenGL3dNurbsSurface class >> exampleNurbsSurface [
	"JunOpenGL3dNurbsSurface exampleNurbsSurface show."

	| controlPoints weights knots |
	controlPoints := JunMatrix new: 4.
	1 to: 4 do: [:x | 1 to: 4 do: [:y | controlPoints atPoint: x @ y put: (Jun3dPoint
					x: x - 2.5 * 2 / 3
					y: y - 2.5 * 2 / 3
					z: (((x = 2 or: [x = 3])
							and: [y = 2 or: [y = 3]])
							ifTrue: [1]
							ifFalse: [-1]))]].
	weights := JunMatrix new: 4 collection: ((1 to: 16)
					collect: [:i | i // 4 + 1 / 2.0]).
	knots := #(0.0 0.0 0.5 0.5 1.0 1.0 1.0 1.0).
	^JunOpenGL3dNurbsSurface
		controlPoints: (JunMatrix new: 4 collection: controlPoints)
		weights: weights
		uKnotVector: knots
		vKnotVector: knots
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface class >> fromLispList: aList [ 
	| object |
	object := self new.
	object := self propertiesFromLispList: aList for: object.
	object := self colorFromLispList: aList for: object.
	object := self stippleFromLispList: aList for: object.
	object := self textureFromLispList: aList for: object.
	object := self controlsFromLispList: aList for: object.
	object := self weightsFromLispList: aList for: object.
	object := self uKnotsFromLispList: aList for: object.
	object := self vKnotsFromLispList: aList for: object.
	object := self transformationFromLispList: aList for: object.
	object := self trimsFromLispList: aList for: object.
	^object
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface class >> stippleFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #stipple]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject stipple: (JunOpenGLStipple image: list tail).
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dNurbsSurface class >> system [
	^'Jun'
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface class >> textureFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #texture]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject texture: (JunOpenGLTexture fromLispList: list tail).
	^a3dObject
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface class >> trimsFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #trims]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	list tail do: [:trimLispList | a3dObject addTrimCurve: (JunOpenGL2dTrimCurve fromLispList: trimLispList)].
	^a3dObject
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface class >> uKnotsFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #uKnots]]
				ifNone: [nil].
	list isNil
		ifTrue: [a3dObject uKnotVector: aList tail asArray]
		ifFalse: [a3dObject uKnotVector: list tail asArray].
	^a3dObject
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface class >> vKnotsFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #vKnots]]
				ifNone: [nil].
	list isNil
		ifTrue: [a3dObject vKnotVector: aList tail asArray]
		ifFalse: [a3dObject vKnotVector: list tail asArray].
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dNurbsSurface class >> version [
	^'799'
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface class >> weightsFromLispList: aList for: a3dObject [ 
	| list rows columns collection matrix |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #weights]]
				ifNone: [nil].
	list isNil
		ifTrue: [a3dObject weights: JunMatrix new]
		ifFalse: 
			[list := list tail.
			rows := list head.
			list := list tail.
			columns := list head.
			list := list tail.
			collection := list asArray.
			matrix := JunMatrix
						new: rows
						by: columns
						collection: collection.
			a3dObject weights: matrix].
	^a3dObject
]

{ #category : #adding }
JunOpenGL3dNurbsSurface >> addTrimCurve: aJunOpenGL2dTrimCurve [ 
	^trimCurves add: aJunOpenGL2dTrimCurve
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> controlPointAt: aPoint [
	^controlPoints atPoint: aPoint
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> controlPointAt: aPoint put: a3dPoint [ 
	^controlPoints atPoint: aPoint put: a3dPoint
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> controlPointAtU: u v: v [
	^controlPoints atPoint: u@v
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> controlPointAtU: u v: v put: a3dPoint [ 
	^controlPoints atPoint: u @ v put: a3dPoint
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> controlPointSize [
	^controlPoints matrixSize
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> controlPoints [
	"Answers a JunMatrix that contains my control points."

	^controlPoints
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> controlPoints: aJunMatrix [ 
	controlPoints := aJunMatrix
]

{ #category : #'private-initialize' }
JunOpenGL3dNurbsSurface >> controlPoints: aMatrix1 weights: aMatrix2 uKnotVector: anArray1 vKnotVector: anArray2 [ 
	controlPoints := aMatrix1.
	weights := aMatrix2.
	uKnotVector := anArray1.
	vKnotVector := anArray2
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface >> controlsToLispList [
	| controls collection |
	controls := self controlPoints.
	collection := OrderedCollection new: controls size + 3.
	collection add: #controls.
	collection add: controls rowSize.
	collection add: controls columnSize.
	controls do: [:p | collection add: p].
	^self defaultLispConsClass list: collection
]

{ #category : #enumerating }
JunOpenGL3dNurbsSurface >> geometriesDo: aBlock [ 
	aBlock value: (JunNurbsSurface
			controlPoints: controlPoints
			weights: weights
			uKnotVector: uKnotVector
			vKnotVector: vKnotVector)
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> halftone: halftoneScale [ 
	self stipple: (JunOpenGLStipple halftone: halftoneScale)
]

{ #category : #testing }
JunOpenGL3dNurbsSurface >> hasStipple [
	^stipple notNil
]

{ #category : #testing }
JunOpenGL3dNurbsSurface >> hasTexture [
	^texture notNil
]

{ #category : #testing }
JunOpenGL3dNurbsSurface >> hasTrimCurves [
	^trimCurves isEmpty not
]

{ #category : #'initialize-release' }
JunOpenGL3dNurbsSurface >> initialize [
	super initialize.
	trimCurves := OrderedCollection new
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface >> kindName [
	^#NurbsSurface
]

{ #category : #utilities }
JunOpenGL3dNurbsSurface >> numberOfPolygons [
	^1
]

{ #category : #utilities }
JunOpenGL3dNurbsSurface >> numberOfPolylines [
	^0
]

{ #category : #enumerating }
JunOpenGL3dNurbsSurface >> pointsDo: aBlock [
	controlPoints do: aBlock
]

{ #category : #copying }
JunOpenGL3dNurbsSurface >> postCopy [
	super postCopy.
	controlPoints := controlPoints copy.
	weights := weights copy.
	uKnotVector := uKnotVector copy.
	vKnotVector := vKnotVector copy.
	trimCurves := trimCurves collect: [:trimCurve | trimCurve copy]
]

{ #category : #removing }
JunOpenGL3dNurbsSurface >> removeTrimCurve: aJunOpenGL2dTrimCurve [
	^trimCurves remove: aJunOpenGL2dTrimCurve
]

{ #category : #removing }
JunOpenGL3dNurbsSurface >> removeTrimCurve: aJunOpenGL2dTrimCurve ifAbsent: errorBlock [
	^trimCurves remove: aJunOpenGL2dTrimCurve ifAbsent: errorBlock
]

{ #category : #rendering }
JunOpenGL3dNurbsSurface >> renderOn: aRenderingContext [ 
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
	aRenderingContext displayNurbsSurface: self.
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
JunOpenGL3dNurbsSurface >> reversed [
	| reversedUKnotVector reversedControlPoints reversedWeights reversedSurface translate1 scale translate2 t |
	reversedUKnotVector := self uKnotVector reverse collect: [:knot | uKnotVector first + uKnotVector last - knot].
	reversedControlPoints := self controlPoints class new: self controlPoints rowSize by: self controlPoints columnSize.
	self controlPoints doIJ: [:point :row :column | reversedControlPoints
			row: self controlPoints rowSize - row + 1
			column: column
			put: point].
	reversedWeights := self weights class new: self weights rowSize by: self weights columnSize.
	self weights doIJ: [:weight :row :column | reversedWeights
			row: self weights rowSize - row + 1
			column: column
			put: weight].
	reversedSurface := self class
				controlPoints: reversedControlPoints
				weights: reversedWeights
				uKnotVector: reversedUKnotVector
				vKnotVector: self vKnotVector.
	translate1 := Jun2dTransformation translate: -0.5d , -0.5d.
	scale := Jun2dTransformation scale: -1.0d , -1.0d.
	translate2 := Jun2dTransformation translate: 0.5d , 0.5d.
	t := Jun2dTransformation unity.
	t product: translate1.
	t product: scale.
	t product: translate2.
	trimCurves do: [:trimCurve | reversedSurface addTrimCurve: (trimCurve transform: t)].
	^reversedSurface
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> stipple [
	^stipple
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> stipple: aStipple [ 
	stipple := aStipple
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface >> stippleToLispList [
	| list |
	self hasStipple ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #stipple.
	list tail: self stipple image.
	^list
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> texture [
	^texture
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> texture: aTexture [ 
	texture := aTexture.
	aTexture isNil ifFalse: [aTexture object: self]
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface >> textureToLispList [
	| list |
	self hasTexture ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #texture.
	list tail: self texture toLispList.
	^list
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface >> toLispList [
	| list |
	list := self lispCons.
	list head: self kindName.
	self hasProperties ifTrue: [list add: self propertiesToLispList].
	self hasColor ifTrue: [list add: self colorToLispList].
	self hasStipple ifTrue: [list add: self stippleToLispList].
	self hasTexture ifTrue: [list add: self textureToLispList].
	self hasTrimCurves ifTrue: [list add: self trimsToLispList].
	list add: self controlsToLispList.
	list add: self weightsToLispList.
	list add: self uKnotsToLispList.
	list add: self vKnotsToLispList.
	^list
]

{ #category : #transforming }
JunOpenGL3dNurbsSurface >> transform: aJun3dTransformation [ 
	| theNurbsSurface cps |
	theNurbsSurface := self copy.
	cps := theNurbsSurface controlPoints.
	cps doIJ: [:point :i :j | cps
			row: i
			column: j
			put: (point transform: aJun3dTransformation)].
	^theNurbsSurface
]

{ #category : #enumerating }
JunOpenGL3dNurbsSurface >> trimCurvesDo: aBlock [
	trimCurves do: aBlock
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface >> trimsToLispList [
	| list |
	self hasTrimCurves ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #trims.
	trimCurves do: [ :trimCurve | list add: trimCurve toLispList].
	^list
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> uDegree [
	^self uOrder - 1
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> uKnotAt: anInteger [
	^uKnotVector at: anInteger
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> uKnotAt: anInteger put: aNumber [
	^uKnotVector at: anInteger put: aNumber
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> uKnotSize [
	^uKnotVector size
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> uKnotVector [
	"Answer an Array that contains my knot vector of u direction"

	^uKnotVector
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> uKnotVector: anArray [ 
	uKnotVector := anArray
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface >> uKnotsToLispList [
	| collection |
	collection := OrderedCollection new: self uKnotVector size + 1.
	collection add: #uKnots.
	self uKnotVector do: [:p | collection add: p].
	^self defaultLispConsClass list: collection
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> uOrder [
	^uKnotVector size - self uSize.
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> uSize [
	^controlPoints rowSize
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> vDegree [
	^self vOrder - 1
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> vKnotAt: anInteger [
	^vKnotVector at: anInteger
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> vKnotAt: anInteger put: aNumber [
	^vKnotVector at: anInteger put: aNumber
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> vKnotSize [
	^vKnotVector size
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> vKnotVector [
	"Answer an Array that contains my knot vector of v direction"

	^vKnotVector
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> vKnotVector: anArray [ 
	vKnotVector := anArray
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface >> vKnotsToLispList [
	| collection |
	collection := OrderedCollection new: self vKnotVector size + 1.
	collection add: #vKnots.
	self vKnotVector do: [:p | collection add: p].
	^self defaultLispConsClass list: collection
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> vOrder [
	^vKnotVector size - self vSize.
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> vSize [
	^controlPoints columnSize
]

{ #category : #'vrml support' }
JunOpenGL3dNurbsSurface >> vrml10On: aStream [ 
	"not supported"
]

{ #category : #'vrml support' }
JunOpenGL3dNurbsSurface >> vrml20On: aStream [ 
	"not supported"
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> weightAtU: u v: v [
	^weights atPoint: u@v
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> weightAtU: u v: v put: aNumber [
	^weights atPoint: u@v put: aNumber
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> weights [
	"Answer a JunMatrix of my weight map of control points."

	^weights
]

{ #category : #accessing }
JunOpenGL3dNurbsSurface >> weights: aJunMatrix [
	weights := aJunMatrix
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsSurface >> weightsToLispList [
	| masses collection |
	masses := self weights.
	collection := OrderedCollection new: masses size + 3.
	collection add: #weights.
	collection add: masses rowSize.
	collection add: masses columnSize.
	masses do: [:p | collection add: p].
	^self defaultLispConsClass list: collection
]

"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGL3dTransformedObject,
	#superclass : #JunOpenGL3dPrimitiveObject,
	#instVars : [
		'object',
		'transformation',
		'transformedObject'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #copyright }
JunOpenGL3dTransformedObject class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGL3dTransformedObject class >> example1 [
	"JunOpenGL3dTransformedObject example1."

	| object transformation list |
	object := JunOpenGL3dObject cube.
	transformation := Jun3dTransformation rotateX: (JunAngle fromDeg: 45).
	object := JunOpenGL3dTransformedObject object: object transformation: transformation.
	list := object showLispList.
	object := object class fromLispList: list.
	object showLispList.
	^object
]

{ #category : #examples }
JunOpenGL3dTransformedObject class >> example2 [
	"JunOpenGL3dTransformedObject example2."

	| object transformation list |
	object := JunOpenGL3dObject cube.
	transformation := Jun3dTransformation rotateX: (JunAngle fromDeg: 45).
	object := JunOpenGL3dTransformedObject object: object transformation: transformation.
	object name: 'example'.
	object paint: ColorValue gray.
	object alpha: 0.75.
	list := object showLispList.
	object := object class fromLispList: list.
	object showLispList.
	^object
]

{ #category : #examples }
JunOpenGL3dTransformedObject class >> example3 [
	"JunOpenGL3dTransformedObject example3."

	| file object transformation stream model |
	file := JunUniFileModel requestNewFileName: 'zzz.lst'.
	file isNil ifTrue: [^self].
	object := JunOpenGL3dObject cube.
	transformation := Jun3dTransformation rotateX: (JunAngle fromDeg: 45).
	object := JunOpenGL3dTransformedObject object: object transformation: transformation.
	object name: 'example'.
	object paint: ColorValue gray.
	object alpha: 0.75.
	stream := file writeStream.
	[Cursor write showWhile: [object saveOn: stream]]
		ensure: [stream close].
	stream := file readStream.
	[Cursor read showWhile: [object := object class loadFrom: stream]]
		ensure: [stream close].
	model := JunOpenGLDisplayModel new.
	model displayObject: object.
	model open.
	^object
]

{ #category : #examples }
JunOpenGL3dTransformedObject class >> example4 [
	"JunOpenGL3dTransformedObject example4."

	| baseSphere halfBody fullBody |
	baseSphere := JunOpenGL3dObject ball: 2.
	baseSphere flushAllPaints.
	halfBody := JunOpenGL3dCompoundObject new.
	halfBody add: (JunOpenGL3dTransformedObject 
				object: baseSphere
				transformation: (Jun3dTransformation translate: 2 , 1 , 0)
				paint: ColorValue red).
	halfBody add: (JunOpenGL3dTransformedObject 
				object: baseSphere
				transformation: (Jun3dTransformation translate: 0 , 2 , 0)
				paint: ColorValue green).
	halfBody add: (JunOpenGL3dTransformedObject 
				object: baseSphere
				transformation: (Jun3dTransformation translate: 0 , 3 , 2)
				paint: ColorValue blue).
	fullBody := JunOpenGL3dCompoundObject new.
	fullBody add: halfBody.
	fullBody 
		add: (JunOpenGL3dTransformedObject object: (halfBody
						establishAllNormalVectors;
						yourself)
				transformation: Jun3dTransformation mirrorY).
	fullBody add: (JunOpenGL3dObject axes scaledBy: 5).
	fullBody show.
	^fullBody
]

{ #category : #examples }
JunOpenGL3dTransformedObject class >> example5 [
	"JunOpenGL3dTransformedObject example5."

	| baseSphere halfBody fullBody |
	baseSphere := (JunOpenGL3dTransformedObject 
				object: (JunOpenGL3dObject ball: 2))
				flushAllPaints;
				yourself.
	halfBody := (JunOpenGL3dCompoundObject new)
				add: ((baseSphere translatedBy: 2 , 1 , 0)
							paint: ColorValue red;
							yourself);
				add: ((baseSphere translatedBy: 0 , 2 , 0)
							paint: ColorValue green;
							yourself);
				add: ((baseSphere translatedBy: 0 , 3 , 2)
							paint: ColorValue blue;
							yourself);
				yourself.
	fullBody := (JunOpenGL3dCompoundObject new)
				add: halfBody;
				add: (JunOpenGL3dTransformedObject object: (halfBody
									establishAllNormalVectors;
									yourself)
							transformation: Jun3dTransformation mirrorY);
				add: (JunOpenGL3dObject axes scaledBy: 5);
				yourself.
	fullBody show.
	^fullBody
]

{ #category : #examples }
JunOpenGL3dTransformedObject class >> example6 [
	"JunOpenGL3dTransformedObject example6."

	| originalPolygon aTransformation junTransformedPolygon glTransformedPolygon originalPolygonAndNormalVector junTransformedPolygonAndNormalVector glTransformedPolygonAndNormalVector mirrorPlane junDisplayObject glDisplayObject projectionTable anArray |
	originalPolygon := JunOpenGL3dPolygon vertexes: (Array 
						with: 1 , 1 , 0
						with: 2 , 1 , 0
						with: 1 , 2 , 0).
	originalPolygon paint: ColorValue red.
	originalPolygon halftone: 0.75.
	originalPolygon establishNormalVectors.
	aTransformation := Jun3dTransformation mirrorY.
	junTransformedPolygon := originalPolygon transform: aTransformation.
	glTransformedPolygon := JunOpenGL3dTransformedObject 
				object: originalPolygon
				transformation: aTransformation.
	originalPolygonAndNormalVector := JunOpenGL3dCompoundObject new.
	originalPolygonAndNormalVector
		add: originalPolygon;
		add: originalPolygon normalVectorObject.
	junTransformedPolygonAndNormalVector := JunOpenGL3dCompoundObject new.
	junTransformedPolygonAndNormalVector
		add: junTransformedPolygon;
		add: junTransformedPolygon normalVectorObject.
	glTransformedPolygonAndNormalVector := JunOpenGL3dCompoundObject new.
	glTransformedPolygon polygonsDo: 
			[:aPolygon | 
			glTransformedPolygonAndNormalVector
				add: aPolygon;
				add: aPolygon normalVectorObject].
	mirrorPlane := (JunOpenGL3dPolygon vertexes: (Array 
						with: 0 , 0 , -1
						with: 0 , 0 , 1
						with: 1 , 0 , 1
						with: 1 , 0 , -1))
				paint: ColorValue cyan;
				halftone: 0.25.
	junDisplayObject := JunOpenGL3dCompoundObject 
				with: originalPolygonAndNormalVector
				with: junTransformedPolygonAndNormalVector
				with: (JunOpenGL3dObject xyzArrows scaledBy: 3)
				with: (mirrorPlane scaledBy: 3).
	glDisplayObject := JunOpenGL3dCompoundObject 
				with: originalPolygonAndNormalVector
				with: glTransformedPolygonAndNormalVector
				with: (JunOpenGL3dObject xyzArrows scaledBy: 3)
				with: (mirrorPlane scaledBy: 3).
	projectionTable := (Dictionary new)
				add: #presentation -> #solidPresentation;
				add: #sightPoint -> (0 , 0 , 0);
				add: #eyePoint -> (40 , 8 , 20);
				add: #shading -> #smoothShading;
				add: #upVector -> (0 , 0 , 1);
				add: #viewFactor -> 10;
				add: #zoomHeight -> 6;
				yourself.
	anArray := Array 
				with: (junDisplayObject showProjectionTable: projectionTable
						in: (100 @ 200 extent: 300 @ 300))
				with: (glDisplayObject showProjectionTable: projectionTable
						in: (450 @ 200 extent: 300 @ 300)).
	anArray do: [:each | each closeTogether: anArray].
	^anArray
]

{ #category : #examples }
JunOpenGL3dTransformedObject class >> example7 [
	"JunOpenGL3dTransformedObject example7."

	| originalHedron polygonCollection aTransformation junTransformedHedron glTransformedHedron originalHedronAndNormalVectors junTransformedHedronAndNormalVectors glTransformedHedronAndNormalVectors mirrorPlane junDisplayObject glDisplayObject projectionTable anArray |
	originalHedron := (JunOpenGL3dObject regularDodecahedron 
				rotatedBy: (JunAngle fromDeg: 30)) translatedBy: 1 , 1.8 , 0.
	originalHedron flushAllPaints.
	polygonCollection := OrderedCollection new.
	originalHedron polygonsDo: [:aPolygon | polygonCollection add: aPolygon].
	polygonCollection with: (0 to: polygonCollection size - 1)
		do: 
			[:aPolygon :anInteger | 
			aPolygon paint: (ColorValue 
						hue: anInteger / polygonCollection size
						saturation: 1
						brightness: 1).
			aPolygon halftone: 0.75].
	originalHedron establishAllNormalVectors.
	aTransformation := Jun3dTransformation mirrorY.
	junTransformedHedron := originalHedron transform: aTransformation.
	glTransformedHedron := JunOpenGL3dTransformedObject object: originalHedron
				transformation: aTransformation.
	originalHedronAndNormalVectors := JunOpenGL3dCompoundObject new.
	originalHedron polygonsDo: 
			[:aPolygon | 
			originalHedronAndNormalVectors
				add: aPolygon;
				add: aPolygon normalVectorObject].
	junTransformedHedronAndNormalVectors := JunOpenGL3dCompoundObject new.
	junTransformedHedron polygonsDo: 
			[:aPolygon | 
			junTransformedHedronAndNormalVectors
				add: aPolygon;
				add: aPolygon normalVectorObject].
	glTransformedHedronAndNormalVectors := JunOpenGL3dCompoundObject new.
	glTransformedHedron polygonsDo: 
			[:aPolygon | 
			glTransformedHedronAndNormalVectors
				add: aPolygon;
				add: aPolygon normalVectorObject].
	mirrorPlane := (JunOpenGL3dPolygon vertexes: (Array 
						with: 0 , 0 , -1
						with: 0 , 0 , 1
						with: 1 , 0 , 1
						with: 1 , 0 , -1))
				paint: ColorValue cyan;
				halftone: 0.25.
	junDisplayObject := JunOpenGL3dCompoundObject 
				with: originalHedronAndNormalVectors
				with: junTransformedHedronAndNormalVectors
				with: (JunOpenGL3dObject xyzArrows scaledBy: 4)
				with: (mirrorPlane scaledBy: 4).
	glDisplayObject := JunOpenGL3dCompoundObject 
				with: originalHedronAndNormalVectors
				with: glTransformedHedronAndNormalVectors
				with: (JunOpenGL3dObject xyzArrows scaledBy: 4)
				with: (mirrorPlane scaledBy: 4).
	projectionTable := (Dictionary new)
				add: #presentation -> #solidPresentation;
				add: #sightPoint -> (0 , 0 , 0);
				add: #eyePoint -> (40 , 8 , 20);
				add: #shading -> #smoothShading;
				add: #upVector -> (0 , 0 , 1);
				add: #viewFactor -> 10;
				add: #zoomHeight -> 8;
				yourself.
	anArray := Array 
				with: (junDisplayObject showProjectionTable: projectionTable
						in: (100 @ 200 extent: 300 @ 300))
				with: (glDisplayObject showProjectionTable: projectionTable
						in: (450 @ 200 extent: 300 @ 300)).
	anArray do: [:each | each closeTogether: anArray].
	^anArray
]

{ #category : #examples }
JunOpenGL3dTransformedObject class >> example8 [
	"JunOpenGL3dTransformedObject example8."

	| baseBody firstBody secondBody thirdBody compoundObject |
	baseBody := JunOpenGL3dObject cube scaledBy: 0.4.
	baseBody flushAllPaints.
	firstBody := JunOpenGL3dTransformedObject object: baseBody
				transformation: (Jun3dTransformation translate: 1 , 0 , 0).
	secondBody := JunOpenGL3dTransformedObject object: baseBody
				transformation: (Jun3dTransformation translate: 0 , 1 , 0).
	thirdBody := JunOpenGL3dTransformedObject object: baseBody
				transformation: (Jun3dTransformation translate: 0 , 0 , 1).
	firstBody paint: ColorValue red.
	secondBody paint: ColorValue green.
	thirdBody paint: ColorValue blue.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: baseBody.
	compoundObject add: firstBody.
	compoundObject add: secondBody.
	compoundObject add: thirdBody.
	compoundObject showWithAxes
]

{ #category : #examples }
JunOpenGL3dTransformedObject class >> example9 [
	"JunOpenGL3dTransformedObject example9."

	| baseBody transformedObject compoundObject |
	baseBody := JunOpenGL3dObject ball.
	baseBody establishAllNormalVectors.
	transformedObject := JunOpenGL3dTransformedObject object: baseBody.
	transformedObject := transformedObject scaledBy: 0.65 , 1 , 1.1.
	transformedObject showWithAxesIn: (100 @ 300 extent: 400 @ 400).
	compoundObject := transformedObject transformedObject.
	compoundObject showWithAxesIn: (510 @ 300 extent: 400 @ 400)
]

{ #category : #examples }
JunOpenGL3dTransformedObject class >> exampleA [
	"JunOpenGL3dTransformedObject exampleA."

	| aBall aTransformation howMany anInterval ballCollection aLine xyzArrows aViewfinder millisecondsToRun |
	aBall := (JunOpenGL3dObject ball: 1)
				objectsDo: [:each | each paint: nil];
				yourself.
	aTransformation := Jun3dTransformation scale: 1 / 25 , (1 / 25) , (1 / 25).
	aBall := JunOpenGL3dTransformedObject object: aBall
				transformation: aTransformation.
	howMany := 25.
	anInterval := 0 to: 1 by: 1 / howMany.
	ballCollection := OrderedCollection new: anInterval size.
	aLine := 0 , -1 , 0 to: 1 , 0 , 0.
	anInterval do: 
			[:n | 
			ballCollection 
				add: ((aBall transform: (Jun3dTransformation translate: (aLine atT: n)))
						paint: (ColorValue 
									hue: n * howMany / anInterval size
									saturation: 1
									brightness: 1);
						yourself)].
	xyzArrows := JunOpenGL3dObject xyzArrows scaledBy: 1.2 , 1.2 , 1.2.
	aViewfinder := JunOpenGLDisplayModel displayObject: xyzArrows.
	aViewfinder openIn: (400 , 400) alignedRectangleWithScreenCenter.
	howMany := 100.
	anInterval := 0 to: 1 by: 1 / howMany.
	aLine := 1 , 0 , 0 to: 0 , 1 , 0.
	millisecondsToRun := Time millisecondsToRun: 
					[anInterval do: 
							[:n | 
							| aBody |
							aBody := JunOpenGL3dCompoundObject new.
							ballCollection do: 
									[:each | 
									aBody add: (each 
												transform: (Jun3dTransformation translate: (aLine atT: n) - aLine first))].
							aBody add: xyzArrows.
							aViewfinder
								displayObject: aBody;
								changed: #object]].
	Transcript
		cr;
		show: millisecondsToRun printString.
	^aBall
]

{ #category : #'lisp support' }
JunOpenGL3dTransformedObject class >> fromLispList: aList [ 
	^JunOpenGL3dCompoundObject objectFromLispList: aList
]

{ #category : #'instance creation' }
JunOpenGL3dTransformedObject class >> object: a3dObject [ 
	^(super new)
		object: a3dObject;
		transformation: Jun3dTransformation unity;
		yourself
]

{ #category : #'instance creation' }
JunOpenGL3dTransformedObject class >> object: a3dObject transformation: aTransformation [ 
	^(super new)
		object: a3dObject;
		transformation: aTransformation;
		yourself
]

{ #category : #'instance creation' }
JunOpenGL3dTransformedObject class >> object: a3dObject transformation: aTransformation paint: aColorValue [ 
	^(super new)
		object: a3dObject;
		transformation: aTransformation;
		paint: aColorValue;
		yourself
]

{ #category : #'instance creation' }
JunOpenGL3dTransformedObject class >> object: a3dObject transformation: aTransformation paint: colorValue alpha: alphaValue [ 
	^(super new)
		object: a3dObject;
		transformation: aTransformation;
		paint: colorValue;
		alpha: alphaValue;
		yourself
]

{ #category : #copyright }
JunOpenGL3dTransformedObject class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGL3dTransformedObject class >> version [
	^'799'
]

{ #category : #'vector accessing' }
JunOpenGL3dTransformedObject >> establishAllNormalVectorsWithSmoothingAngle: anAngle [ 
	super establishAllNormalVectorsWithSmoothingAngle: anAngle.
	self object isNil 
		ifFalse: [self object establishAllNormalVectorsWithSmoothingAngle: anAngle]
]

{ #category : #flushing }
JunOpenGL3dTransformedObject >> flushAllAlphas [
	self flushAlpha.
	self object ifNotNil: [:it | it flushAllAlphas]
]

{ #category : #flushing }
JunOpenGL3dTransformedObject >> flushAllBounds [
	self flushBounds.
	self object ifNotNil: [:it | it flushAllBounds]
]

{ #category : #flushing }
JunOpenGL3dTransformedObject >> flushAllNames [
	self flushName.
	self object ifNotNil: [:it | it flushAllNames]
]

{ #category : #flushing }
JunOpenGL3dTransformedObject >> flushAllNormalVectors [
	self flushNormalVectors.
	self object ifNotNil: [:it | it flushAllNormalVectors]
]

{ #category : #flushing }
JunOpenGL3dTransformedObject >> flushAllPaints [
	self flushPaint.
	self object ifNotNil: [:it | it flushAllPaints]
]

{ #category : #flushing }
JunOpenGL3dTransformedObject >> flushTransformedObject [
	transformedObject := nil
]

{ #category : #enumerating }
JunOpenGL3dTransformedObject >> geometriesDo: aBlock [
	self transformedObject geometriesDo: aBlock
]

{ #category : #'initialize-release' }
JunOpenGL3dTransformedObject >> initialize [
	super initialize.
	object := nil.
	transformation := nil.
	transformedObject := nil
]

{ #category : #testing }
JunOpenGL3dTransformedObject >> isTransformedObject [
	^true
]

{ #category : #utilities }
JunOpenGL3dTransformedObject >> numberOfPolygons [
	^self object numberOfPolygons
]

{ #category : #utilities }
JunOpenGL3dTransformedObject >> numberOfPolylines [
	^self object numberOfPolylines
]

{ #category : #accessing }
JunOpenGL3dTransformedObject >> object [
	^object
]

{ #category : #accessing }
JunOpenGL3dTransformedObject >> object: a3dObject [ 
	object := a3dObject.
	self
		flushBounds;
		flushTransformedObject
]

{ #category : #enumerating }
JunOpenGL3dTransformedObject >> objectsDo: aBlock [ 
	self transformedObject objectsDo: aBlock
]

{ #category : #enumerating }
JunOpenGL3dTransformedObject >> pointsDo: aBlock [ 
	self object isNil ifTrue: [^self].
	self transformation isNil
		ifTrue: [self object pointsDo: aBlock]
		ifFalse: [self object pointsDo: [:point | aBlock value: (point transform: self transformation)]]
]

{ #category : #enumerating }
JunOpenGL3dTransformedObject >> polygonsDo: aBlock [ 
	self object isNil ifTrue: [^self].
	self transformation isNil
		ifTrue: [self object polygonsDo: aBlock]
		ifFalse: [self object polygonsDo: [:aPolygon | aBlock value: (aPolygon transform: self transformation)]]
]

{ #category : #enumerating }
JunOpenGL3dTransformedObject >> polylinesDo: aBlock [ 
	self object isNil ifTrue: [^self].
	self transformation isNil
		ifTrue: [self object polylinesDo: aBlock]
		ifFalse: [self object polylinesDo: [:aPolyline | aBlock value: (aPolyline transform: self transformation)]]
]

{ #category : #rendering }
JunOpenGL3dTransformedObject >> renderOn: aRenderingContext [ 
	self object isNil ifTrue: [^self].
	self hasPaint ifTrue: [aRenderingContext paint: self paint].
	self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
	self transformation isNil 
		ifTrue: [self object renderOn: aRenderingContext]
		ifFalse: 
			[true 
				ifTrue: 
					[aRenderingContext productTransformation: self transformation
						while: [self object renderOn: aRenderingContext]]
				ifFalse: [self transformedObject renderOn: aRenderingContext]]
]

{ #category : #converting }
JunOpenGL3dTransformedObject >> reversed [
	^self copy object: self object reversed
]

{ #category : #'lisp support' }
JunOpenGL3dTransformedObject >> toLispList [
	^self transformedObject toLispList
]

{ #category : #'obj support' }
JunOpenGL3dTransformedObject >> toOBJUsing: aJunOBJWriter [ 
	self transformedObject toOBJUsing: aJunOBJWriter
]

{ #category : #transforming }
JunOpenGL3dTransformedObject >> transform: aTransformation [ 
	| newObject |
	newObject := self copy.
	self transformation isNil
		ifTrue: [newObject transformation: aTransformation]
		ifFalse: [newObject transformation: (self transformation transform: aTransformation)].
	^newObject
]

{ #category : #accessing }
JunOpenGL3dTransformedObject >> transformation [
	^transformation
]

{ #category : #accessing }
JunOpenGL3dTransformedObject >> transformation: aTransforamtion [ 
	transformation := aTransforamtion.
	self
		flushBounds;
		flushTransformedObject
]

{ #category : #accessing }
JunOpenGL3dTransformedObject >> transformedObject [
	transformedObject ifNil: 
			[self object isNil 
				ifTrue: [transformedObject := JunOpenGL3dCompoundObject new]
				ifFalse: 
					[self transformation isNil 
						ifTrue: [transformedObject := self object copy]
						ifFalse: [transformedObject := self object transform: self transformation]].
			self hasProperties ifTrue: [transformedObject name: self name].
			self hasAlpha ifTrue: [transformedObject alpha: self alpha].
			self hasPaint ifTrue: [transformedObject paint: self paint].
			self hasStipple ifTrue: [transformedObject stipple: self stipple].
			self hasTexture ifTrue: [transformedObject texture: self texture]].
	^transformedObject
]

{ #category : #'vrml support' }
JunOpenGL3dTransformedObject >> vrml10On: aStream [ 
	self transformedObject vrml10On: aStream
]

{ #category : #'vrml support' }
JunOpenGL3dTransformedObject >> vrml20On: aStream [ 
	self transformedObject vrml20On: aStream
]

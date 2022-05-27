"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGL3dPolyline,
	#superclass : #JunOpenGL3dVertexesObject,
	#instVars : [
		'lineWidth',
		'stippleFactor',
		'stipplePattern'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #copyright }
JunOpenGL3dPolyline class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGL3dPolyline class >> example1 [
	"JunOpenGL3dPolyline example1."

	| polyline list |
	polyline := JunOpenGL3dPolyline vertexes: (Array
					with: 0.0d , 0.0d , 1.0d
					with: 1.0d , 0.0d , 1.0d
					with: 1.0d , 1.0d , 1.0d
					with: 0.0d , 1.0d , 1.0d).
	list := polyline showLispList.
	polyline := polyline class fromLispList: list.
	polyline showLispList.
	^polyline
]

{ #category : #examples }
JunOpenGL3dPolyline class >> example2 [
	"JunOpenGL3dPolyline example2."

	| polyline list |
	polyline := JunOpenGL3dPolyline vertexes: (Array
					with: 0.0d , 0.0d , 1.0d
					with: 1.0d , 0.0d , 1.0d
					with: 1.0d , 1.0d , 1.0d
					with: 0.0d , 1.0d , 1.0d).
	polyline name: 'example'.
	polyline paint: ColorValue gray.
	polyline alpha: 0.75.
	polyline halftone.
	list := polyline showLispList.
	polyline := polyline class fromLispList: list.
	polyline showLispList.
	^polyline
]

{ #category : #examples }
JunOpenGL3dPolyline class >> example3 [
	"JunOpenGL3dPolyline example3."

	| file polyline stream model |
	file := JunUniFileModel requestNewFileName: 'zzz.lst'.
	file isNil ifTrue: [^self].
	polyline := JunOpenGL3dPolyline vertexes: (Array
					with: 0.0d , 0.0d , 1.0d
					with: 1.0d , 0.0d , 1.0d
					with: 1.0d , 1.0d , 1.0d
					with: 0.0d , 1.0d , 1.0d).
	polyline name: 'example'.
	polyline paint: ColorValue gray.
	polyline alpha: 0.75.
	polyline halftone: 0.3.
	stream := file writeStream.
	[Cursor write showWhile: [polyline saveOn: stream]]
		ensure: [stream close].
	stream := file readStream.
	[Cursor read showWhile: [polyline := polyline class loadFrom: stream]]
		ensure: [stream close].
	model := JunOpenGLDisplayModel new.
	model displayObject: polyline.
	model open.
	^polyline
]

{ #category : #'lisp support' }
JunOpenGL3dPolyline class >> fromLispList: aList [ 
	| object |
	object := self new.
	object := self propertiesFromLispList: aList for: object.
	object := self colorFromLispList: aList for: object.
	object := self lineWidthFromLispList: aList for: object.
	object := self stippleFromLispList: aList for: object.
	object := self vertexesFromLispList: aList for: object.
	object := self transformationFromLispList: aList for: object.
	^object
]

{ #category : #'lisp support' }
JunOpenGL3dPolyline class >> lineWidthFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #width]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject lineWidth: list tail.
	^a3dObject
]

{ #category : #'lisp support' }
JunOpenGL3dPolyline class >> stippleFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #stipple]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject stippleFactor: (list tail nth: 1).
	a3dObject stipplePattern: (list tail nth: 2).
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dPolyline class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGL3dPolyline class >> version [
	^'799'
]

{ #category : #enumerating }
JunOpenGL3dPolyline >> geometriesDo: aBlock [ 
	1 to: vertexes size - 1 do: [:index | aBlock value: (Jun3dLine from: (vertexes at: index)
				to: (vertexes at: index + 1))]
]

{ #category : #accessing }
JunOpenGL3dPolyline >> halftone: halftoneScale [ 
	| patternNumber |
	patternNumber := JunImageProcessor stipple: (0 max: (halftoneScale min: 1)).
	stipplePattern := patternNumber
]

{ #category : #testing }
JunOpenGL3dPolyline >> hasStipple [
	^stipplePattern notNil
]

{ #category : #'initialize-release' }
JunOpenGL3dPolyline >> initialize [
	super initialize.
	lineWidth := self defaultLineWidth.
	stippleFactor := 1.
	stipplePattern := nil
]

{ #category : #testing }
JunOpenGL3dPolyline >> isLoop [
	^false
]

{ #category : #testing }
JunOpenGL3dPolyline >> isPolyline [
	^true
]

{ #category : #'lisp support' }
JunOpenGL3dPolyline >> kindName [
	^#Polyline
]

{ #category : #accessing }
JunOpenGL3dPolyline >> lineWidth [
	^lineWidth
]

{ #category : #accessing }
JunOpenGL3dPolyline >> lineWidth: aNumber [
	lineWidth := aNumber
]

{ #category : #'lisp support' }
JunOpenGL3dPolyline >> lineWidthToLispList [
	| list |
	self lineWidth > 1 ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #width.
	list tail: self lineWidth.
	^list
]

{ #category : #utilities }
JunOpenGL3dPolyline >> numberOfPolygons [
	^0
]

{ #category : #utilities }
JunOpenGL3dPolyline >> numberOfPolylines [
	^1
]

{ #category : #enumerating }
JunOpenGL3dPolyline >> polylinesDo: aBlock [ 
	aBlock value: self
]

{ #category : #rendering }
JunOpenGL3dPolyline >> renderOn: aRenderingContext [ 
	self hasPaint ifTrue: [aRenderingContext paint: self paint].
	self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
	aRenderingContext lineWidth: lineWidth.
	self hasStipple
		ifTrue: 
			[aRenderingContext lineStippleFactor: self stippleFactor pattern: self stipplePattern.
			aRenderingContext enableLineStipple].
	aRenderingContext displayLines: self vertexes.
	self hasStipple ifTrue: [aRenderingContext disableLineStipple]
]

{ #category : #accessing }
JunOpenGL3dPolyline >> stippleFactor [
	stippleFactor isNil ifTrue: [stippleFactor := 1].
	^stippleFactor
]

{ #category : #accessing }
JunOpenGL3dPolyline >> stippleFactor: anInteger [
	stippleFactor := anInteger
]

{ #category : #accessing }
JunOpenGL3dPolyline >> stipplePattern [
	^stipplePattern
]

{ #category : #accessing }
JunOpenGL3dPolyline >> stipplePattern: anInteger [
	stipplePattern := anInteger
]

{ #category : #'lisp support' }
JunOpenGL3dPolyline >> stippleToLispList [
	| list |
	self hasStipple ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #stipple.
	list add: self stippleFactor.
	list add: self stipplePattern.
	^list
]

{ #category : #'lisp support' }
JunOpenGL3dPolyline >> textureToLispList [
	^self shouldNotImplement
]

{ #category : #'lisp support' }
JunOpenGL3dPolyline >> toLispList [
	| list |
	list := self lispCons.
	list head: self kindName.
	(((self hasProperties not and: [self hasColor not])
		and: [self hasStipple not])
		and: [self lineWidth <= 1])
		ifTrue: 
			[self vertexes do: [:p | list add: p].
			^list].
	self hasProperties ifTrue: [list add: self propertiesToLispList].
	self hasColor ifTrue: [list add: self colorToLispList].
	self lineWidth > 1 ifTrue: [list add: self lineWidthToLispList].
	self hasStipple ifTrue: [list add: self stippleToLispList].
	self hasTexture ifTrue: [list add: self textureToLispList].
	list add: self vertexesToLispList.
	^list
]

{ #category : #'vrml support' }
JunOpenGL3dPolyline >> vrml10IndexedSetName [
	^'IndexedLineSet' copy
]

{ #category : #'vrml support' }
JunOpenGL3dPolyline >> vrml20AppearanceOn: aStream [ 
	(self hasColor or: [self hasTexture])
		ifTrue: 
			[aStream tab.
			aStream nextPutAll: 'appearance Appearance {'.
			aStream cr.
			self hasColor
				ifTrue: 
					[aStream tab.
					aStream tab.
					aStream nextPutAll: 'material Material {'.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream tab.
					aStream nextPutAll: 'emissiveColor'.
					aStream space.
					aStream nextPutAll: self paint red asFloat printString.
					aStream space.
					aStream nextPutAll: self paint green asFloat printString.
					aStream space.
					aStream nextPutAll: self paint blue asFloat printString.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream nextPutAll: '} #Material'.
					aStream cr].
			self hasTexture
				ifTrue: 
					[aStream tab.
					aStream tab.
					aStream nextPutAll: 'texture PixelTexture {'.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream tab.
					aStream nextPutAll: 'image '.
					self texture vrmlSFImageOn: aStream.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream nextPutAll: '} #Texture'.
					aStream cr].
			aStream tab.
			aStream nextPutAll: '} #Appearance'.
			aStream cr]
]

{ #category : #'vrml support' }
JunOpenGL3dPolyline >> vrml20IndexedSetName [
	^'IndexedLineSet' copy
]

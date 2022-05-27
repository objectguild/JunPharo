"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGL3dVertex,
	#superclass : #JunOpenGL3dPrimitiveObject,
	#instVars : [
		'point',
		'size'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #copyright }
JunOpenGL3dVertex class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGL3dVertex class >> example1 [
	"JunOpenGL3dVertex example1."

	| vertex list |
	vertex := JunOpenGL3dVertex point: 1 , 2 , 3.
	list := vertex showLispList.
	vertex := vertex class fromLispList: list.
	vertex showLispList.
	^vertex
]

{ #category : #examples }
JunOpenGL3dVertex class >> example2 [
	"JunOpenGL3dVertex example2."

	| vertex list |
	vertex := JunOpenGL3dVertex point: 1 , 2 , 3.
	vertex name: 'example'.
	vertex paint: ColorValue gray.
	vertex alpha: 0.75.
	vertex size: 4.
	list := vertex showLispList.
	vertex := vertex class fromLispList: list.
	vertex showLispList.
	^vertex
]

{ #category : #examples }
JunOpenGL3dVertex class >> example3 [
	"JunOpenGL3dVertex example3."

	| file vertex stream model |
	file := JunUniFileModel requestNewFileName: 'zzz.lst'.
	file isNil ifTrue: [^self].
	vertex := JunOpenGL3dVertex point: 1 , 2 , 3.
	vertex name: 'example'.
	vertex paint: ColorValue gray.
	vertex alpha: 0.75.
	vertex size: 4.
	stream := file writeStream.
	[Cursor write showWhile: [vertex saveOn: stream]]
		ensure: [stream close].
	stream := file readStream.
	[Cursor read showWhile: [vertex := vertex class loadFrom: stream]]
		ensure: [stream close].
	model := JunOpenGLDisplayModel new.
	model displayObject: vertex.
	model open.
	^vertex
]

{ #category : #'lisp support' }
JunOpenGL3dVertex class >> fromLispList: aList [ 
	| object |
	object := self new.
	object := self propertiesFromLispList: aList for: object.
	object := self colorFromLispList: aList for: object.
	object := self pointFromLispList: aList for: object.
	object := self sizeFromLispList: aList for: object.
	object := self transformationFromLispList: aList for: object.
	^object
]

{ #category : #'instance creation' }
JunOpenGL3dVertex class >> point: aJun3dPoint [ 
	^(self new) point: aJun3dPoint; yourself
]

{ #category : #'instance creation' }
JunOpenGL3dVertex class >> point: aJun3dPoint paint: aColorValue [ 
	^(self new) point: aJun3dPoint; paint: aColorValue; yourself
]

{ #category : #'instance creation' }
JunOpenGL3dVertex class >> point: aJun3dPoint paint: aColorValue alpha: aNumber [ 
	^(self new) point: aJun3dPoint; paint: aColorValue; alpha: aNumber; yourself
]

{ #category : #'lisp support' }
JunOpenGL3dVertex class >> pointFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #point]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject point: list tail.
	^a3dObject
]

{ #category : #'lisp support' }
JunOpenGL3dVertex class >> sizeFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #size]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject size: list tail.
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dVertex class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGL3dVertex class >> version [
	^'799'
]

{ #category : #enumerating }
JunOpenGL3dVertex >> geometriesDo: aBlock [ 
	aBlock value: point
]

{ #category : #'initialize-release' }
JunOpenGL3dVertex >> initialize [
	super initialize.
	point := self defaultPoint.
	size := self defaultSize
]

{ #category : #'lisp support' }
JunOpenGL3dVertex >> kindName [
	^#Spot
]

{ #category : #utilities }
JunOpenGL3dVertex >> numberOfPolygons [
	^0
]

{ #category : #utilities }
JunOpenGL3dVertex >> numberOfPolylines [
	^0
]

{ #category : #accessing }
JunOpenGL3dVertex >> point [
	^point
]

{ #category : #accessing }
JunOpenGL3dVertex >> point: a3dPoint [ 
	point := a3dPoint.
	self flushBounds
]

{ #category : #'lisp support' }
JunOpenGL3dVertex >> pointToLispList [
	| list |
	list := self lispCons.
	list head: #point.
	list tail: self point.
	^list
]

{ #category : #enumerating }
JunOpenGL3dVertex >> pointsDo: aBlock [ 
	aBlock value: self point
]

{ #category : #rendering }
JunOpenGL3dVertex >> renderOn: aRenderingContext [ 
	self hasPaint ifTrue: [aRenderingContext paint: self paint].
	self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
	aRenderingContext pointSize: self size.
	aRenderingContext displayPoint: self point
]

{ #category : #reversed }
JunOpenGL3dVertex >> reversed [
	^self copy
]

{ #category : #accessing }
JunOpenGL3dVertex >> size [
	^size
]

{ #category : #accessing }
JunOpenGL3dVertex >> size: aNumber [
	size := aNumber
]

{ #category : #'lisp support' }
JunOpenGL3dVertex >> sizeToLispList [
	| list |
	list := self lispCons.
	list head: #size.
	list tail: self size.
	^list
]

{ #category : #'lisp support' }
JunOpenGL3dVertex >> toLispList [
	| list |
	list := self lispCons.
	list head: self kindName.
	self hasProperties ifTrue: [list add: self propertiesToLispList].
	self hasColor ifTrue: [list add: self colorToLispList].
	list add: self pointToLispList.
	list add: self sizeToLispList.
	^list
]

{ #category : #transforming }
JunOpenGL3dVertex >> transform: aTransformation [ 
	| object |
	object := self copy.
	object point: (self point transform: aTransformation).
	^object
]

{ #category : #'vrml support' }
JunOpenGL3dVertex >> vrml10IndexedSetName [
	^'IndexedLineSet' copy
]

{ #category : #'vrml support' }
JunOpenGL3dVertex >> vrml10On: aStream [ 
	aStream nextPutAll: 'DEF'.
	aStream space.
	aStream nextPutAll: self legalName asString.
	aStream cr.
	aStream nextPutAll: 'Separator {'.
	aStream cr.
	self vrml10ColorOn: aStream.
	self vrml10PointOn: aStream.
	aStream nextPutAll: '} #Separator'.
	aStream cr
]

{ #category : #'vrml support' }
JunOpenGL3dVertex >> vrml10PointOn: aStream [ 
	aStream tab.
	aStream nextPutAll: 'Coordinate3 {'.
	aStream cr.
	aStream tab.
	aStream tab.
	aStream nextPutAll: 'point ['.
	aStream cr.
	point := self point.
	aStream tab.
	aStream tab.
	aStream tab.
	aStream nextPutAll: point x asFloat printString.
	aStream space.
	aStream nextPutAll: point y asFloat printString.
	aStream space.
	aStream nextPutAll: point z asFloat printString.
	aStream space.
	aStream nextPutAll: '#1'.
	aStream cr.
	aStream tab.
	aStream tab.
	aStream nextPutAll: '] #point'.
	aStream cr.
	aStream tab.
	aStream nextPutAll: '} #Coordinate3'.
	aStream cr.
	aStream tab.
	aStream nextPutAll: self vrml10IndexedSetName , ' {'.
	aStream cr.
	aStream tab.
	aStream tab.
	aStream nextPutAll: 'coordIndex ['.
	aStream cr.
	aStream tab.
	aStream tab.
	aStream tab.
	aStream nextPutAll: 1 printString.
	aStream nextPutAll: ','.
	aStream space.
	aStream nextPutAll: '-1'.
	aStream cr.
	aStream tab.
	aStream tab.
	aStream nextPutAll: '] #coordIndex'.
	aStream cr.
	aStream tab.
	aStream nextPutAll: '} #' , self vrml10IndexedSetName.
	aStream cr
]

{ #category : #'vrml support' }
JunOpenGL3dVertex >> vrml20IndexedSetName [
	^'PointSet' copy
]

{ #category : #'vrml support' }
JunOpenGL3dVertex >> vrml20On: aStream [ 
	self name = self defaultName
		ifFalse: 
			[aStream nextPutAll: '#' , self name.
			aStream cr].
	aStream nextPutAll: 'Shape {'.
	aStream cr.
	self vrml20ColorOn: aStream.
	self vrml20PointOn: aStream.
	aStream nextPutAll: '} #Shape'.
	aStream cr
]

{ #category : #'vrml support' }
JunOpenGL3dVertex >> vrml20PointOn: aStream [ 
	aStream tab.
	aStream nextPutAll: 'geometry ' , self vrml20IndexedSetName , ' {'.
	aStream cr.
	aStream tab.
	aStream tab.
	aStream nextPutAll: 'coord Coordinate {'.
	aStream cr.
	aStream tab.
	aStream tab.
	aStream tab.
	aStream nextPutAll: 'point ['.
	aStream cr.
	point := self point.
	aStream tab.
	aStream tab.
	aStream tab.
	aStream tab.
	aStream nextPutAll: point x asFloat printString.
	aStream space.
	aStream nextPutAll: point y asFloat printString.
	aStream space.
	aStream nextPutAll: point z asFloat printString.
	aStream space.
	aStream nextPutAll: '#1'.
	aStream cr.
	aStream tab.
	aStream tab.
	aStream tab.
	aStream nextPutAll: '] #point'.
	aStream cr.
	aStream tab.
	aStream tab.
	aStream nextPutAll: '} #Coordinate'.
	aStream cr.
	aStream tab.
	aStream nextPutAll: '} #' , self vrml20IndexedSetName.
	aStream cr
]

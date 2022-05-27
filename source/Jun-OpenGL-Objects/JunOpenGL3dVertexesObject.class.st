"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGL3dVertexesObject,
	#superclass : #JunOpenGL3dPrimitiveObject,
	#instVars : [
		'vertexes',
		'colors',
		'normalVectors',
		'preferredNormalVector'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject class >> colorsFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #colors]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject colors: (list tail asArray collect: [:rgbList | ColorValue
				red: (rgbList nth: 1)
				green: (rgbList nth: 2)
				blue: (rgbList nth: 3)]).
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dVertexesObject class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject class >> fromLispList: aList [ 
	| object |
	object := self new.
	object := self propertiesFromLispList: aList for: object.
	object := self colorFromLispList: aList for: object.
	object := self stippleFromLispList: aList for: object.
	object := self textureFromLispList: aList for: object.
	object := self vertexesFromLispList: aList for: object.
	object := self transformationFromLispList: aList for: object.
	object := self colorsFromLispList: aList for: object.
	object := self normalVectorsFromLispList: aList for: object.
	^object
]

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject class >> normalVectorsFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #normalVectors]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject normalVectors: list tail asArray.
	^a3dObject
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> on: aPoint1 on: aPoint2 on: aPoint3 [ 
	^self vertexes: (Array 
				with: aPoint1
				with: aPoint2
				with: aPoint3)
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> points: anArrayOfJun3dPoint [ 
	^self vertexes: anArrayOfJun3dPoint
]

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject class >> stippleFromLispList: aList for: a3dObject [ 
	^self subclassResponsibility
]

{ #category : #copyright }
JunOpenGL3dVertexesObject class >> system [
	^'Jun'
]

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject class >> textureFromLispList: aList for: a3dObject [ 
	^self subclassResponsibility
]

{ #category : #copyright }
JunOpenGL3dVertexesObject class >> version [
	^'799'
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> vertexes: anArrayOf3dPoints [ 
	^(self new)
		vertexes: anArrayOf3dPoints;
		yourself
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> vertexes: anArrayOf3dPoints colors: anArrayOfColors [ 
	^(self new)
		vertexes: anArrayOf3dPoints;
		colors: anArrayOfColors;
		yourself
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> vertexes: anArrayOf3dPoints colors: anArrayOfColors alpha: aNumber [ 
	^(self new)
		vertexes: anArrayOf3dPoints;
		colors: anArrayOfColors;
		alpha: aNumber;
		yourself
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> vertexes: anArrayOf3dPoints paint: aPaint [ 
	^(self new)
		vertexes: anArrayOf3dPoints;
		paint: aPaint;
		yourself
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> vertexes: anArrayOf3dPoints paint: aPaint alpha: aNumber [ 
	^(self new)
		vertexes: anArrayOf3dPoints;
		paint: aPaint;
		alpha: aNumber;
		yourself
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> vertexes: anArrayOf3dPoints vectors: anArrayOf3dVectors [ 
	^(self new)
		vertexes: anArrayOf3dPoints;
		normalVectors: anArrayOf3dVectors;
		yourself
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> vertexes: anArrayOf3dPoints vectors: anArrayOf3dVectors colors: anArrayOfColors [ 
	^(self new)
		vertexes: anArrayOf3dPoints;
		normalVectors: anArrayOf3dVectors;
		colors: anArrayOfColors;
		yourself
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> vertexes: anArrayOf3dPoints vectors: anArrayOf3dVectors colors: anArrayOfColors alpha: aNumber [ 
	^(self new)
		vertexes: anArrayOf3dPoints;
		normalVectors: anArrayOf3dVectors;
		colors: anArrayOfColors;
		alpha: aNumber;
		yourself
]

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject class >> vertexesFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #points]]
				ifNone: [nil].
	list isNil
		ifTrue: [a3dObject vertexes: aList tail asArray]
		ifFalse: [a3dObject vertexes: list tail asArray].
	^a3dObject
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> vertices: anArrayOfJun3dPoint [ 
	^self vertexes: anArrayOfJun3dPoint
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> with: aJun3dPoint1 with: aJun3dPoint2 [ 
	^self vertexes: (Array with: aJun3dPoint1 with: aJun3dPoint2)
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> with: aJun3dPoint1 with: aJun3dPoint2 with: aJun3dPoint3 [ 
	^self vertexes: (Array 
				with: aJun3dPoint1
				with: aJun3dPoint2
				with: aJun3dPoint3)
]

{ #category : #'instance creation' }
JunOpenGL3dVertexesObject class >> with: aJun3dPoint1 with: aJun3dPoint2 with: aJun3dPoint3 with: aJun3dPoint4 [ 
	^self vertexes: (Array 
				with: aJun3dPoint1
				with: aJun3dPoint2
				with: aJun3dPoint3
				with: aJun3dPoint4)
]

{ #category : #converting }
JunOpenGL3dVertexesObject >> asArrayOfLines [
	| collection polyline |
	collection := self vertexes copy.
	polyline := Jun3dPolyline vertexes: collection.
	^polyline asArrayOfLines
]

{ #category : #converting }
JunOpenGL3dVertexesObject >> asArrayOfPoints [
	^Array withAll: self vertexes
]

{ #category : #converting }
JunOpenGL3dVertexesObject >> asPlane [
	| points oneThirds point1 point2 point3 |
	(points := self vertexes) size < 3 ifTrue: [^nil].
	oneThirds := (points size / 3) asInteger.
	point1 := points at: 1.
	point2 := points at: 1 + oneThirds.
	point3 := points at: 1 + (oneThirds * 2).
	^JunPlane 
		on: point1
		on: point2
		on: point3
]

{ #category : #converting }
JunOpenGL3dVertexesObject >> asTriangle [
	| points |
	(points := self vertexes) size = 3 ifFalse: [^nil].
	^Jun3dTriangle 
		on: (points at: 1)
		on: (points at: 2)
		on: (points at: 3)
]

{ #category : #accessing }
JunOpenGL3dVertexesObject >> averagePoint [
	| totalPoint averagePoint |
	totalPoint := 0 , 0 , 0.
	self pointsDo: [:eachPoint | totalPoint := totalPoint + eachPoint].
	averagePoint := totalPoint / self numberOfVertexes.
	^averagePoint
]

{ #category : #accessing }
JunOpenGL3dVertexesObject >> colors [
	^colors
]

{ #category : #accessing }
JunOpenGL3dVertexesObject >> colors: aCollection [ 
	colors := aCollection
]

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject >> colorsToLispList [
	| list |
	list := self lispCons.
	list head: #colors.
	self colors do: [:color | list add: (self defaultLispConsClass list: (Array
					with: color red asFloat
					with: color green asFloat
					with: color blue asFloat))].
	^list
]

{ #category : #'vector accessing' }
JunOpenGL3dVertexesObject >> establishAllNormalVectorsWithSmoothingAngle: anAngle [ 
	| vectors |
	vectors := Array new: self numberOfVertexes withAll: self normalVector.
	self normalVectors: vectors
]

{ #category : #flushing }
JunOpenGL3dVertexesObject >> flushColors [
	colors := nil
]

{ #category : #flushing }
JunOpenGL3dVertexesObject >> flushNormalVectors [
	normalVectors := nil.
	preferredNormalVector := nil
]

{ #category : #testing }
JunOpenGL3dVertexesObject >> hasColors [
	^colors notNil
]

{ #category : #testing }
JunOpenGL3dVertexesObject >> hasNormalVectors [
	^normalVectors notNil
]

{ #category : #accessing }
JunOpenGL3dVertexesObject >> indexOf: aPoint [ 
	| vertex |
	1 to: self numberOfVertexes
		do: 
			[:index | 
			vertex := self vertexes at: index.
			(vertex equal: aPoint) ifTrue: [^index]].
	^0
]

{ #category : #accessing }
JunOpenGL3dVertexesObject >> indexOfVertex: aPoint [ 
	| vertex |
	1 to: self numberOfVertexes
		do: 
			[:index | 
			vertex := self vertexes at: index.
			(vertex equal: aPoint) ifTrue: [^index]].
	^0
]

{ #category : #'initialize-release' }
JunOpenGL3dVertexesObject >> initialize [
	super initialize.
	vertexes := Array new.
	colors := nil.
	normalVectors := nil
]

{ #category : #testing }
JunOpenGL3dVertexesObject >> isVertexesObject [
	^true
]

{ #category : #accessing }
JunOpenGL3dVertexesObject >> nextVertexOf: aPoint [ 
	| index |
	index := self indexOfVertex: aPoint.
	index <= 0 ifTrue: [^nil].
	index := index + 1.
	index > self numberOfVertexes ifTrue: [index := 1].
	^self vertexes at: index
]

{ #category : #'vector accessing' }
JunOpenGL3dVertexesObject >> normalUnitVector [
	^self normalVector normalUnitVector
]

{ #category : #'vector accessing' }
JunOpenGL3dVertexesObject >> normalVector [
	^self preferredNormalVector
]

{ #category : #'vector accessing' }
JunOpenGL3dVertexesObject >> normalVector: aJun3dPoint [ 
	preferredNormalVector := aJun3dPoint
]

{ #category : #converting }
JunOpenGL3dVertexesObject >> normalVectorObject [
	| startPoint normalVectorObject |
	startPoint := self averageVertex.
	normalVectorObject := JunOpenGL3dObject 
				coneFrom: startPoint
				to: startPoint + self normalVector
				width: 0.15.
	normalVectorObject
		flushAllPaints;
		flushAllAlphas.
	^normalVectorObject
]

{ #category : #converting }
JunOpenGL3dVertexesObject >> normalVectorObjectAppliedTransformation: aTransformation [ 
	| startPoint normalVector normalVectorObject |
	startPoint := (self transform: aTransformation) averageVertex.
	normalVector := 
			[| aBoolean aPolygon |
			aBoolean := self hasNormalVectors.
			aBoolean ifFalse: [self establishNormalVectors].
			[aPolygon := self transform: aTransformation] 
				ensure: [aBoolean ifFalse: [self flushNormalVectors]].
			aPolygon yourself] 
					value normalVector.
	normalVectorObject := JunOpenGL3dObject 
				coneFrom: startPoint
				to: startPoint + normalVector
				width: 0.15.
	normalVectorObject
		flushAllPaints;
		flushAllAlphas.
	^normalVectorObject
]

{ #category : #'vector accessing' }
JunOpenGL3dVertexesObject >> normalVectors [
	normalVectors ifNil: [^Array with: self normalVector].
	^normalVectors
]

{ #category : #'vector accessing' }
JunOpenGL3dVertexesObject >> normalVectors: anArrayOfJun3dPoint [ 
	normalVectors := anArrayOfJun3dPoint asArray
]

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject >> normalVectorsToLispList [
	| collection |
	collection := OrderedCollection new: self normalVectors size + 1.
	collection add: #normalVectors.
	self normalVectors do: [:p | collection add: p].
	^self defaultLispConsClass list: collection
]

{ #category : #accessing }
JunOpenGL3dVertexesObject >> numberOfVertexes [
	^self vertexes size
]

{ #category : #enumerating }
JunOpenGL3dVertexesObject >> pointsDo: aBlock [ 
	self vertexes do: [:point | aBlock value: point]
]

{ #category : #copying }
JunOpenGL3dVertexesObject >> postCopy [
	super postCopy.
	vertexes := vertexes copy.
	colors := colors copy.
	normalVectors := normalVectors copy.
	preferredNormalVector := preferredNormalVector copy
]

{ #category : #private }
JunOpenGL3dVertexesObject >> preferredNormalVector [
	preferredNormalVector ifNil: 
			[| prevPointBlock nextPointBlock vector |
			prevPointBlock := 
					[:startIndex | 
					| startPoint index |
					startPoint := vertexes at: startIndex.
					index := startIndex - 1.
					
					[startIndex + index > (vertexes size - 1) negated and: 
							[(startPoint distance: (vertexes at: (index - 1) \\ vertexes size + 1)) 
								< startPoint class accuracy]] 
							whileTrue: [index := index - 1].
					startIndex + index > (vertexes size - 1) negated 
						ifTrue: [vertexes at: (index - 1) \\ vertexes size + 1]
						ifFalse: [nil]].
			nextPointBlock := 
					[:startIndex | 
					| startPoint index |
					startPoint := vertexes at: startIndex.
					index := startIndex + 1.
					
					[index - startIndex < (vertexes size - 1) and: 
							[(startPoint distance: (vertexes at: (index - 1) \\ vertexes size + 1)) 
								< startPoint class accuracy]] 
							whileTrue: [index := index + 1].
					index - startIndex < (vertexes size - 1) 
						ifTrue: [vertexes at: (index - 1) \\ vertexes size + 1]
						ifFalse: [nil]].
			vector := Jun3dPoint zero.
			1 to: vertexes size
				do: 
					[:index | 
					| prevPoint nextPoint thePoint |
					prevPoint := prevPointBlock value: index.
					nextPoint := nextPointBlock value: index.
					thePoint := vertexes at: index.
					(prevPoint notNil and: [nextPoint notNil]) 
						ifTrue: 
							[vector := vector 
										+ (thePoint - prevPoint vectorProduct: nextPoint - thePoint)]].
			preferredNormalVector := vector unitVector].
	^preferredNormalVector

	"| vector | 
	vector := Jun3dPoint zero. 
	1 to: vertexes size do: [ :index | | p1 p2 p3 | 
	p1 := vertexes at: index. 
	p2 := vertexes at: index \\ vertexes size + 1. 
	p3 := vertexes at: index + 1 \\ vertexes size + 1. 
	vector := vector + (p2 - p1 vectorProduct: p3 - p2) unitVector]. 
	^vector unitVector"
]

{ #category : #accessing }
JunOpenGL3dVertexesObject >> previousVertexOf: aPoint [ 
	| index |
	index := self indexOfVertex: aPoint.
	index <= 0 ifTrue: [^nil].
	index := index - 1.
	index <= 0 ifTrue: [index := self numberOfVertexes].
	^self vertexes at: index
]

{ #category : #converting }
JunOpenGL3dVertexesObject >> reversed [
	| reversedObject |
	reversedObject := self copy.
	reversedObject vertexes: vertexes reverse.
	colors notNil ifTrue: [reversedObject colors: colors reverse].
	normalVectors notNil ifTrue: [reversedObject normalVectors: normalVectors reverse].
	^reversedObject
]

{ #category : #private }
JunOpenGL3dVertexesObject >> setVertexes: anArrayOf3dPoints paint: aPaint alpha: aNumber [
	vertexes := anArrayOf3dPoints asArray.
	paint := aPaint.
	alpha := aNumber.
]

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject >> stippleToLispList [
	^self subclassResponsibility
]

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject >> textureToLispList [
	^self subclassResponsibility
]

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject >> toLispList [
	| list |
	list := self lispCons.
	list head: self kindName.
	(((((self hasProperties not and: [self hasColor not]) 
		and: [self hasStipple not]) and: [self hasTexture not]) 
		and: [self hasColors not]) and: [self hasNormalVectors not]) 
		ifTrue: 
			[self vertexes do: [:p | list add: p].
			^list].
	self hasProperties ifTrue: [list add: self propertiesToLispList].
	self hasColor ifTrue: [list add: self colorToLispList].
	self hasStipple ifTrue: [list add: self stippleToLispList].
	self hasTexture ifTrue: [list add: self textureToLispList].
	list add: self vertexesToLispList.
	self hasColors ifTrue: [list add: self colorsToLispList].
	self hasNormalVectors ifTrue: [list add: self normalVectorsToLispList].
	^list
]

{ #category : #transforming }
JunOpenGL3dVertexesObject >> transform: aTransformation [ 
	| object vector vertex |
	object := self copy.
	object vertexes: (self vertexes 
				collect: [:point | point transform: aTransformation]).
	self normalVectors ifNotNil: 
			[object 
				normalVectors: ((1 to: self normalVectors size) collect: 
							[:index | 
							vector := self normalVectors at: index.
							vertex := self vertexes at: index.
							((vertex to: vertex + vector) transform: aTransformation) normalVector])].
	preferredNormalVector ifNotNil: 
			[preferredNormalVector := 
					[vector := self normalVector.
					vertex := self averagePoint.
					((vertex to: vertex + vector) transform: aTransformation) normalVector] 
							value].
	^object
]

{ #category : #accessing }
JunOpenGL3dVertexesObject >> vertexes [
	^vertexes
]

{ #category : #accessing }
JunOpenGL3dVertexesObject >> vertexes: aCollectionOf3dPoints [ 
	vertexes := aCollectionOf3dPoints asArray.
	self flushBounds.
	self flushNormalVectors
]

{ #category : #'lisp support' }
JunOpenGL3dVertexesObject >> vertexesToLispList [
	| collection |
	collection := OrderedCollection new: self vertexes size + 1.
	collection add: #points.
	self vertexes do: [:p | collection add: p].
	^self defaultLispConsClass list: collection
]

{ #category : #'vrml support' }
JunOpenGL3dVertexesObject >> vrml10IndexedSetName [
	^self subclassResponsibility
]

{ #category : #'vrml support' }
JunOpenGL3dVertexesObject >> vrml10On: aStream [ 
	aStream nextPutAll: 'DEF'.
	aStream space.
	aStream nextPutAll: self legalName asString.
	aStream cr.
	aStream nextPutAll: 'Separator {'.
	aStream cr.
	self vrml10ColorOn: aStream.
	self vrml10VertexesOn: aStream.
	aStream nextPutAll: '} #Separator'.
	aStream cr
]

{ #category : #'vrml support' }
JunOpenGL3dVertexesObject >> vrml10VertexesOn: aStream [ 
	| points |
	(points := self vrmlVertexes) isEmpty
		ifFalse: 
			[self hasTexture
				ifTrue: 
					[aStream tab.
					aStream nextPutAll: 'Texture2 {'.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream nextPutAll: 'image '.
					self texture vrmlSFImageOn: aStream.
					aStream cr.
					aStream tab.
					aStream nextPutAll: '} #Texture2'.
					aStream cr].
			aStream tab.
			aStream nextPutAll: 'Coordinate3 {'.
			aStream cr.
			aStream tab.
			aStream tab.
			aStream nextPutAll: 'point ['.
			aStream cr.
			1 to: points size
				do: 
					[:index | 
					| point |
					point := points at: index.
					aStream tab.
					aStream tab.
					aStream tab.
					aStream nextPutAll: point x asFloat printString.
					aStream space.
					aStream nextPutAll: point y asFloat printString.
					aStream space.
					aStream nextPutAll: point z asFloat printString.
					index = points size ifFalse: [aStream nextPutAll: ','].
					aStream space.
					aStream nextPutAll: '#'.
					aStream nextPutAll: (index - 1) printString.
					aStream cr].
			aStream tab.
			aStream tab.
			aStream nextPutAll: '] #point'.
			aStream cr.
			aStream tab.
			aStream nextPutAll: '} #Coordinate3'.
			aStream cr.
			(self hasTexture and: [self texture hasCoordinates])
				ifTrue: 
					[aStream tab.
					aStream nextPutAll: 'TextureCoordinate2 {'.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream nextPutAll: 'point ['.
					aStream cr.
					1 to: points size
						do: 
							[:index | 
							| point |
							point := self texture coordinates at: index.
							aStream tab.
							aStream tab.
							aStream tab.
							aStream nextPutAll: point x asFloat printString.
							aStream space.
							aStream nextPutAll: point y asFloat printString.
							index = points size ifFalse: [aStream nextPutAll: ','].
							aStream space.
							aStream nextPutAll: '#'.
							aStream nextPutAll: (index - 1) printString.
							aStream cr].
					aStream tab.
					aStream tab.
					aStream nextPutAll: ']'.
					aStream cr.
					aStream tab.
					aStream nextPutAll: '} #TextureCoordinate2'.
					aStream cr].
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
			1 to: points size
				do: 
					[:index | 
					aStream nextPutAll: (index - 1) printString.
					aStream nextPutAll: ','.
					aStream space].
			aStream nextPutAll: '-1'.
			aStream cr.
			aStream tab.
			aStream tab.
			aStream nextPutAll: '] #coordIndex'.
			aStream cr.
			self hasTexture
				ifTrue: 
					[aStream tab.
					aStream nextPutAll: 'textureCoordIndex ['.
					aStream cr.
					aStream tab.
					aStream tab.
					1 to: points size
						do: 
							[:index | 
							aStream nextPutAll: (index - 1) printString.
							aStream nextPutAll: ','.
							aStream space].
					aStream nextPutAll: '-1'.
					aStream cr.
					aStream tab.
					aStream nextPutAll: '] #textureCoordIndex'].
			aStream tab.
			aStream nextPutAll: '} #' , self vrml10IndexedSetName.
			aStream cr]
]

{ #category : #'vrml support' }
JunOpenGL3dVertexesObject >> vrml20IndexedSetName [
	^self subclassResponsibility
]

{ #category : #'vrml support' }
JunOpenGL3dVertexesObject >> vrml20On: aStream [ 
	self name = self defaultName
		ifFalse: 
			[aStream nextPutAll: '#' , self name.
			aStream cr].
	aStream nextPutAll: 'Shape {'.
	aStream cr.
	self vrml20AppearanceOn: aStream.
	self vrml20VertexesOn: aStream.
	aStream nextPutAll: '} #Shape'.
	aStream cr
]

{ #category : #'vrml support' }
JunOpenGL3dVertexesObject >> vrml20VertexesOn: aStream [ 
	| points |
	(points := self vrmlVertexes) isEmpty
		ifFalse: 
			[aStream tab.
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
			1 to: points size
				do: 
					[:index | 
					| point |
					point := points at: index.
					aStream tab.
					aStream tab.
					aStream tab.
					aStream nextPutAll: point x asFloat printString.
					aStream space.
					aStream nextPutAll: point y asFloat printString.
					aStream space.
					aStream nextPutAll: point z asFloat printString.
					index = points size ifFalse: [aStream nextPutAll: ','].
					aStream space.
					aStream nextPutAll: '#'.
					aStream nextPutAll: (index - 1) printString.
					aStream cr].
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
			aStream tab.
			aStream nextPutAll: 'coordIndex ['.
			aStream cr.
			aStream tab.
			aStream tab.
			aStream tab.
			1 to: points size
				do: 
					[:index | 
					aStream nextPutAll: (index - 1) printString.
					aStream nextPutAll: ','.
					aStream space].
			aStream nextPutAll: '-1'.
			aStream cr.
			aStream tab.
			aStream tab.
			aStream nextPutAll: '] #coordIndex'.
			(self hasTexture and: [self texture hasCoordinates])
				ifTrue: 
					[aStream cr.
					aStream tab.
					aStream tab.
					aStream nextPutAll: 'texCoord TextureCoordinate {'.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream tab.
					aStream nextPutAll: 'point ['.
					aStream cr.
					1 to: points size
						do: 
							[:index | 
							| point |
							point := self texture coordinates at: index.
							aStream tab.
							aStream tab.
							aStream tab.
							aStream tab.
							aStream nextPutAll: point x asFloat printString.
							aStream space.
							aStream nextPutAll: point y asFloat printString.
							index = points size ifFalse: [aStream nextPutAll: ','].
							aStream space.
							aStream nextPutAll: '#'.
							aStream nextPutAll: (index - 1) printString.
							aStream cr].
					aStream tab.
					aStream tab.
					aStream tab.
					aStream nextPutAll: ']'.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream nextPutAll: '} #texCoord'.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream nextPutAll: 'texCoordIndex ['.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream tab.
					1 to: points size
						do: 
							[:index | 
							aStream nextPutAll: (index - 1) printString.
							aStream nextPutAll: ','.
							aStream space].
					aStream nextPutAll: '-1'.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream nextPutAll: '] #texCoordIndex'].
			aStream cr.
			aStream tab.
			aStream nextPutAll: '} #' , self vrml20IndexedSetName.
			aStream cr]
]

{ #category : #'vrml support' }
JunOpenGL3dVertexesObject >> vrmlVertexes [
	^self vertexes
]

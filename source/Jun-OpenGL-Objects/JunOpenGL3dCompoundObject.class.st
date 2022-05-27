"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGL3dCompoundObject,
	#superclass : #JunOpenGL3dObject,
	#instVars : [
		'components',
		'texture',
		'smoothingAngle'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #'instance creation' }
JunOpenGL3dCompoundObject class >> components: aCollection [ 
	^(self new: aCollection size)
		components: aCollection;
		yourself
]

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject class >> componentsFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #bodies]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	list tail do: [:each | a3dObject add: (self objectFromLispList: each)].
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dCompoundObject class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGL3dCompoundObject class >> example1 [
	"JunOpenGL3dCompoundObject example1."

	| compound list |
	compound := JunOpenGL3dCompoundObject axes.
	list := compound showLispList.
	compound := compound class fromLispList: list.
	compound showLispList.
	^compound
]

{ #category : #examples }
JunOpenGL3dCompoundObject class >> example2 [
	"JunOpenGL3dCompoundObject example2."

	| compound list |
	compound := JunOpenGL3dCompoundObject axes.
	compound name: 'example'.
	compound paint: ColorValue gray.
	compound alpha: 0.75.
	list := compound showLispList.
	compound := compound class fromLispList: list.
	compound showLispList.
	^compound
]

{ #category : #examples }
JunOpenGL3dCompoundObject class >> example3 [
	"JunOpenGL3dCompoundObject example3."

	| file compound stream |
	file := JunUniFileModel requestNewFileName: 'zzz.lst'.
	file isNil ifTrue: [^self].
	compound := JunOpenGL3dCompoundObject axes.
	compound name: 'example'.
	compound paint: ColorValue gray.
	compound alpha: 0.75.
	stream := file writeStream.
	[Cursor write showWhile: [compound saveOn: stream]]
		ensure: [stream close].
	stream := file readStream.
	[Cursor read showWhile: [compound := compound class loadFrom: stream]]
		ensure: [stream close].
	compound show.
	^compound
]

{ #category : #examples }
JunOpenGL3dCompoundObject class >> example4 [
	"JunOpenGL3dCompoundObject example4."

	| compound image texture file stream |
	compound := JunOpenGL3dCompoundObject cube.
	compound name: 'example'.
	compound paint: ColorValue gray.
	compound alpha: 0.75.
	image := JunImageUtility fromDisplay: (10 @ 10 extent: 64 @ 64).
	texture := JunOpenGLTexture image: image.
	texture coordinates: (Array 
				with: 0.0 , 0.0
				with: 1.0 , 0.0
				with: 1.0 , 1.0
				with: 0.0 , 1.0).
	compound texture: texture.
	file := JunUniFileModel requestNewFileName: 'zzz.lst'.
	file isNil ifTrue: [^self].
	stream := file writeStream.
	[Cursor write showWhile: [compound saveOn: stream]] ensure: [stream close].
	stream := file readStream.
	[Cursor read showWhile: [compound := compound class loadFrom: stream]] 
		ensure: [stream close].
	compound show.
	^compound
]

{ #category : #examples }
JunOpenGL3dCompoundObject class >> example5 [
	"JunOpenGL3dCompoundObject example5."

	| object body |
	object := JunOpenGL3dObject cube.
	Transcript
		cr;
		show: object area printString.
	body := JunOpenGL3dCompoundObject new.
	object asTriangles 
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

{ #category : #examples }
JunOpenGL3dCompoundObject class >> example6 [
	"JunOpenGL3dCompoundObject example6."

	| object body polygon |
	object := JunOpenGL3dObject globe.
	Transcript
		cr;
		show: object area printString.
	body := JunOpenGL3dCompoundObject new.
	object asTriangles do: 
			[:triangle | 
			polygon := triangle asJunOpenGL3dObject.
			polygon normalVectors: (polygon vertexes 
						collect: [:p | (0 , 0 , 0 to: p) normalUnitVector]).
			body add: polygon].
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

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject class >> fromLispList: aList [ 
	| object |
	object := self new.
	object := self propertiesFromLispList: aList for: object.
	object := self colorFromLispList: aList for: object.
	object := self componentsFromLispList: aList for: object.
	object := self textureFromLispList: aList for: object.
	object := self transformationFromLispList: aList for: object.
	^object
]

{ #category : #'instance creation' }
JunOpenGL3dCompoundObject class >> new [
	^self new: 0
]

{ #category : #'instance creation' }
JunOpenGL3dCompoundObject class >> new: size [
	^super new initialize: size
]

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject class >> patchedBodyFromLispList: aList [ 
	| object list points patches |
	object := self new.
	object := self propertiesFromLispList: aList for: object.
	object := self colorFromLispList: aList for: object.
	list := aList 
				detect: [:car | (car isKindOf: self defaultLispConsClass) and: [car head = #points]]
				ifNone: [nil].
	list isNil ifTrue: [points := nil] ifFalse: [points := list tail asArray].
	list := aList 
				detect: [:car | (car isKindOf: self defaultLispConsClass) and: [car head = #patches]]
				ifNone: [nil].
	list isNil ifTrue: [^object].
	points isNil 
		ifTrue: 
			[list tail do: 
					[:each | 
					| polygon |
					polygon := JunOpenGL3dPolygon fromLispList: each.
					object add: polygon]]
		ifFalse: 
			[patches := (list tail collect: [:each | each asArray]) asArray.
			patches do: 
					[:indexes | 
					| polygon |
					polygon := JunOpenGL3dPolygon new.
					polygon vertexes: (indexes collect: [:index | points at: index]).
					object add: polygon]].
	object := self textureFromLispList: aList for: object.
	object := self transformationFromLispList: list for: object.
	^object
]

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject class >> skinningBodyFromLispList: aList [ 
	| object list |
	object := self new.
	object := self propertiesFromLispList: aList for: object.
	object := self colorFromLispList: aList for: object.
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #polygons]]
				ifNone: [nil].
	list isNil ifTrue: [^object].
	list tail
		do: 
			[:each | 
			| polygon |
			polygon := JunOpenGL3dPolygon fromLispList: each.
			object add: polygon].
	object := self textureFromLispList: aList for: object.
	object := self transformationFromLispList: list for: object.
	^object
]

{ #category : #copyright }
JunOpenGL3dCompoundObject class >> system [
	^'Jun'
]

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject class >> textureFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #texture]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject texture: (JunOpenGLTexture fromLispList: list tail).
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dCompoundObject class >> version [
	^'799'
]

{ #category : #'instance creation' }
JunOpenGL3dCompoundObject class >> with: a3dObject [ 
	| compoundObject |
	compoundObject := self new: 1.
	compoundObject add: a3dObject.
	^compoundObject
]

{ #category : #'instance creation' }
JunOpenGL3dCompoundObject class >> with: a3dObject1 with: a3dObject2 [ 
	| compoundObject |
	compoundObject := self new: 2.
	compoundObject add: a3dObject1.
	compoundObject add: a3dObject2.
	^compoundObject
]

{ #category : #'instance creation' }
JunOpenGL3dCompoundObject class >> with: a3dObject1 with: a3dObject2 with: a3dObject3 [ 
	| compoundObject |
	compoundObject := self new: 3.
	compoundObject add: a3dObject1.
	compoundObject add: a3dObject2.
	compoundObject add: a3dObject3.
	^compoundObject
]

{ #category : #'instance creation' }
JunOpenGL3dCompoundObject class >> with: a3dObject1 with: a3dObject2 with: a3dObject3 with: a3dObject4 [ 
	| compoundObject |
	compoundObject := self new: 4.
	compoundObject add: a3dObject1.
	compoundObject add: a3dObject2.
	compoundObject add: a3dObject3.
	compoundObject add: a3dObject4.
	^compoundObject
]

{ #category : #'instance creation' }
JunOpenGL3dCompoundObject class >> withAll: aCollection [ 
	| compoundObject |
	compoundObject := self new: aCollection size.
	compoundObject addAll: aCollection.
	^compoundObject
]

{ #category : #'vector accessing' }
JunOpenGL3dCompoundObject >> _establishNormalVectorsAt: vertex polygons: polygons smoothingAngle: anAngle [ 
	| polygon vector group polygon1 polygon2 |
	(polygons isNil or: [polygons isEmpty]) ifTrue: [^self].
	polygon := polygons removeFirst.
	vector := polygon normalVector.
	group := OrderedCollection new.
	group add: polygon.

	"Collect polygons of the group to the right."
	polygon1 := polygon.
	
	[polygon2 := polygon1 _findAdjacentOnRight: vertex from: polygons.
	polygon2 notNil and: 
			[(group includes: polygon2) not and: 
					[(polygon1 normalVector dotProduct: polygon2 normalVector) >= anAngle cos]]] 
			whileTrue: 
				[group add: polygon2.
				vector := vector + polygon2 normalVector.
				polygons remove: polygon2.
				polygon1 := polygon2].

	"Collect polygons of the group to the left."
	polygon1 := polygon.
	
	[polygon2 := polygon1 _findAdjacentOnLeft: vertex from: polygons.
	polygon2 notNil and: 
			[(group includes: polygon2) not and: 
					[(polygon1 normalVector dotProduct: polygon2 normalVector) >= anAngle cos]]] 
			whileTrue: 
				[group add: polygon2.
				vector := vector + polygon2 normalVector.
				polygons remove: polygon2.
				polygon1 := polygon2].


	" Set the vertex normals of the group."
	group size > 1 
		ifTrue: 
			[vector := vector unitVector.
			group do: 
					[:aPolygon | 
					| index |
					index := aPolygon indexOfVertex: vertex.
					aPolygon normalVectors at: index put: vector]].

	"Recurse while a polygon exist."
	polygons isEmpty 
		ifFalse: 
			[self 
				_establishNormalVectorsAt: vertex
				polygons: polygons
				smoothingAngle: anAngle]
]

{ #category : #adding }
JunOpenGL3dCompoundObject >> add: a3dObject [ 
	self components add: a3dObject.
	self flushBounds
]

{ #category : #adding }
JunOpenGL3dCompoundObject >> addAll: aCollection [ 
	aCollection do: [:each | self add: each]
]

{ #category : #converting }
JunOpenGL3dCompoundObject >> asCompoundObject [
	^self
]

{ #category : #accessing }
JunOpenGL3dCompoundObject >> components [
	^components
]

{ #category : #accessing }
JunOpenGL3dCompoundObject >> components: aCollection [ 
	components := aCollection asOrderedCollection.
	self flushBounds
]

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject >> componentsToLispList [
	| list |
	list := self lispCons.
	list head: #bodies.
	self components do: [:each | list add: each toLispList].
	^list
]

{ #category : #'obj support' }
JunOpenGL3dCompoundObject >> componentsToOBJUsing: aJunOBJWriter [ 
	| material |
	material := nil.
	self hasMaterial ifTrue: [material := aJunOBJWriter deriveMaterialFor: self].
	self components do: 
			[:each | 
			(material isNil 
				or: [each hasMaterial or: [aJunOBJWriter currentMaterialEquals: material]]) 
					ifFalse: [aJunOBJWriter setMaterial: material].
			each toOBJUsing: aJunOBJWriter]
]

{ #category : #enumerating }
JunOpenGL3dCompoundObject >> detect: aBlock [ 
	^self components detect: aBlock
]

{ #category : #enumerating }
JunOpenGL3dCompoundObject >> do: aBlock [ 
	^self components do: aBlock
]

{ #category : #'vector accessing' }
JunOpenGL3dCompoundObject >> establishAllNormalVectorsWithSmoothingAngle: anAngle [ 
	| aDictionary |
	aDictionary := JunHashEqualityDictionary new.
	self polygonsDo: 
			[:aPolygon | 
			| normalVectors aCollection |
			normalVectors := Array new: aPolygon numberOfVertexes
						withAll: aPolygon normalVector.
			aPolygon normalVectors: normalVectors.
			aPolygon vertexes do: 
					[:vertex | 
					aCollection := aDictionary at: vertex ifAbsentPut: [OrderedCollection new].
					aCollection add: aPolygon]].
	aDictionary keysAndValuesDo: 
			[:vertex :polygons | 
			self 
				_establishNormalVectorsAt: vertex
				polygons: polygons
				smoothingAngle: anAngle].
	self smoothingAngle: anAngle
]

{ #category : #flushing }
JunOpenGL3dCompoundObject >> flushAllAlphas [
	self flushAlpha.
	self do: [:object | object flushAllAlphas]
]

{ #category : #flushing }
JunOpenGL3dCompoundObject >> flushAllBounds [
	self flushBounds.
	self do: [:object | object flushAllBounds]
]

{ #category : #flushing }
JunOpenGL3dCompoundObject >> flushAllColors [
	self flushColors.
	self do: [:object | object flushAllColors]
]

{ #category : #flushing }
JunOpenGL3dCompoundObject >> flushAllNames [
	self flushName.
	self do: [:object | object flushAllNames]
]

{ #category : #flushing }
JunOpenGL3dCompoundObject >> flushAllNormalVectors [
	self flushNormalVectors.
	self do: [:object | object flushAllNormalVectors]
]

{ #category : #flushing }
JunOpenGL3dCompoundObject >> flushAllPaints [
	self flushPaint.
	self do: [:object | object flushAllPaints]
]

{ #category : #flushing }
JunOpenGL3dCompoundObject >> flushSmoothingAngle [
	smoothingAngle := nil
]

{ #category : #enumerating }
JunOpenGL3dCompoundObject >> geometriesDo: aBlock [ 
	self components do: [:component | component geometriesDo: aBlock]
]

{ #category : #testing }
JunOpenGL3dCompoundObject >> hasTexture [
	^texture notNil
]

{ #category : #testing }
JunOpenGL3dCompoundObject >> includes: a3dObject [ 
	^self components includes: a3dObject
]

{ #category : #'initialize-release' }
JunOpenGL3dCompoundObject >> initialize: size [ 
	super initialize.
	components := OrderedCollection new: size.
	smoothingAngle := nil
]

{ #category : #testing }
JunOpenGL3dCompoundObject >> isCompound [
	^true
]

{ #category : #testing }
JunOpenGL3dCompoundObject >> isCompoundBody [
	self components isEmpty ifTrue: [^true].
	self components
		do: 
			[:each | 
			each hasColor ifTrue: [^true].
			each hasStipple ifTrue: [^true].
			(each isKindOf: JunOpenGL3dPolygon) not ifTrue: [^true]].
	^false
]

{ #category : #testing }
JunOpenGL3dCompoundObject >> isEmpty [
	^self components isEmpty
]

{ #category : #testing }
JunOpenGL3dCompoundObject >> isPatchedBody [
	| total points min max size index |
	self isCompoundBody ifTrue: [^false].
	total := 0.
	points := OrderedCollection new: 1024.
	min := nil.
	max := nil.
	self components
		collect: 
			[:polygon | 
			(polygon hasColors or: [polygon hasNormalVectors])
				ifTrue: [^false].
			size := polygon vertexes size.
			total := total + size.
			polygon vertexes
				do: 
					[:p | 
					index := points findFirst: [:each | (each x = p x and: [each y = p y])
									and: [each z = p z]].
					index = 0 ifTrue: [points add: p]].
			min isNil
				ifTrue: [min := size]
				ifFalse: [min := min min: size].
			max isNil
				ifTrue: [max := size]
				ifFalse: [max := max max: size]].
	(min = max and: [points size * 2 > total])
		ifTrue: [^false].
	^true
]

{ #category : #testing }
JunOpenGL3dCompoundObject >> isSkinningBody [
	self isCompoundBody ifTrue: [^false].
	^self isPatchedBody not
]

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject >> kindName [
	^#CompoundBody
]

{ #category : #utilities }
JunOpenGL3dCompoundObject >> numberOfPolygons [
	^self components inject: 0 into: [:sum :obj | sum + obj numberOfPolygons]
]

{ #category : #utilities }
JunOpenGL3dCompoundObject >> numberOfPolylines [
	^self components inject: 0 into: [:sum :obj | sum + obj numberOfPolylines]
]

{ #category : #utilities }
JunOpenGL3dCompoundObject >> numberOfPrimitives [
	^self components inject: 0 into: [:sum :obj | sum + obj numberOfPrimitives]
]

{ #category : #enumerating }
JunOpenGL3dCompoundObject >> objectsDo: aBlock [ 
	aBlock value: self.
	self components do: [:component | component objectsDo: aBlock]
]

{ #category : #private }
JunOpenGL3dCompoundObject >> patcheCollection: aCollection from: pointArray for: aPolygon [ 
	| collection |
	(aPolygon isKindOf: JunOpenGL3dPolygon)
		ifTrue: 
			[collection := OrderedCollection new: aPolygon vertexes size.
			aPolygon vertexes
				do: 
					[:p | 
					| index |
					index := pointArray findFirst: [:each | (each x = p x and: [each y = p y])
									and: [each z = p z]].
					index = 0 ifFalse: [collection add: index]].
			aCollection add: collection asArray]
]

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject >> patchedBodyFromLispList [
	| list polygons points patches |
	list := self lispCons.
	list head: #PatchedBody.
	self hasProperties ifTrue: [list add: self propertiesToLispList].
	self hasColor ifTrue: [list add: self colorToLispList].
	self hasTexture ifTrue: [list add: self textureToLispList].
	Cursor wait showWhile: 
			[polygons := self components.
			points := OrderedCollection new: 1024.
			polygons do: [:polygon | self pointCollection: points for: polygon].
			points := points asArray.
			patches := OrderedCollection new: 1024.
			polygons do: 
					[:polygon | 
					self 
						patcheCollection: patches
						from: points
						for: polygon].
			patches := patches collect: [:each | self defaultLispConsClass list: each]].
	points := self defaultLispConsClass list: points.
	patches := self defaultLispConsClass list: patches.
	points := self defaultLispConsClass head: #points tail: points.
	patches := self defaultLispConsClass head: #patches tail: patches.
	list add: points.
	list add: patches.
	^list
]

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject >> patchedOrSkinningBodyFromLispList [
	self isSkinningBody ifTrue: [^self skinningBodyFromLispList].
	^self patchedBodyFromLispList
]

{ #category : #private }
JunOpenGL3dCompoundObject >> pointCollection: aCollection for: aPolygon [ 
	(aPolygon isKindOf: JunOpenGL3dPolygon)
		ifTrue: [aPolygon vertexes
				do: 
					[:p | 
					| index |
					index := aCollection findFirst: [:each | (each x = p x and: [each y = p y])
									and: [each z = p z]].
					index = 0 ifTrue: [aCollection add: p]]]
]

{ #category : #enumerating }
JunOpenGL3dCompoundObject >> pointsDo: aBlock [ 
	self components do: [:each | each pointsDo: aBlock]
]

{ #category : #enumerating }
JunOpenGL3dCompoundObject >> polygonsDo: aBlock [ 
	self components do: [:each | each polygonsDo: aBlock]
]

{ #category : #enumerating }
JunOpenGL3dCompoundObject >> polylinesDo: aBlock [ 
	self components do: [:each | each polylinesDo: aBlock]
]

{ #category : #copying }
JunOpenGL3dCompoundObject >> postCopy [
	super postCopy.
	components := components copy
]

{ #category : #enumerating }
JunOpenGL3dCompoundObject >> primitivesDo: aBlock [ 
	self components do: [:each | each primitivesDo: aBlock]
]

{ #category : #removing }
JunOpenGL3dCompoundObject >> remove: a3dObject [ 
	self components remove: a3dObject ifAbsent: [nil].
	self flushBounds.
	^a3dObject
]

{ #category : #removing }
JunOpenGL3dCompoundObject >> removeAll: aCollection [ 
	aCollection do: [:obj | self remove: obj].
	^aCollection
]

{ #category : #rendering }
JunOpenGL3dCompoundObject >> renderOn: aRenderingContext [ 
	| oldTextureCoordinateIndex |
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
	self renderOpaqueComponentsOn: aRenderingContext.
	self renderTransparentComponentsOn: aRenderingContext.
	self hasTransparency
		ifTrue: 
			[aRenderingContext disableCullFace.
			aRenderingContext enableDepthMask.
			aRenderingContext disableBlending].
	self hasTexture
		ifTrue: 
			[self texture disableTextureOn: aRenderingContext.
			aRenderingContext textureCoordinateIndex: oldTextureCoordinateIndex]
]

{ #category : #rendering }
JunOpenGL3dCompoundObject >> renderOpaqueComponentsOn: aRenderingContext [ 
	self components do: 
			[:each | 
			each hasTransparency 
				ifFalse: 
					[self hasPaint ifTrue: [aRenderingContext paint: self paint].
					self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
					each renderOn: aRenderingContext.
					(each hasTexture and: [self hasTexture]) 
						ifTrue: [self texture enableTextureOn: aRenderingContext]]]
]

{ #category : #rendering }
JunOpenGL3dCompoundObject >> renderTransparentComponentsOn: aRenderingContext [ 
	self components do: 
			[:each | 
			each hasTransparency 
				ifTrue: 
					[self hasPaint ifTrue: [aRenderingContext paint: self paint].
					self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
					each renderOn: aRenderingContext.
					(each hasTexture and: [self hasTexture]) 
						ifTrue: [self texture enableTextureOn: aRenderingContext]]]
]

{ #category : #converting }
JunOpenGL3dCompoundObject >> reversed [
	^self class withAll: (self components collect: [:obj | obj reversed])
]

{ #category : #enumerating }
JunOpenGL3dCompoundObject >> select: aBlock [ 
	^self class withAll: (self components select: aBlock)
]

{ #category : #accessing }
JunOpenGL3dCompoundObject >> size [
	^self components size
]

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject >> skinningBodyFromLispList [
	| list patches |
	list := self lispCons.
	list head: #SkinningBody.
	self hasProperties ifTrue: [list add: self propertiesToLispList].
	self hasColor ifTrue: [list add: self colorToLispList].
	self hasTexture ifTrue: [list add: self textureToLispList].
	patches := self components collect: [:polygon | polygon toLispList].
	patches := self defaultLispConsClass list: patches.
	patches := self defaultLispConsClass head: #polygons tail: patches.
	list add: patches.
	^list
]

{ #category : #accessing }
JunOpenGL3dCompoundObject >> smoothingAngle [
	^smoothingAngle
]

{ #category : #accessing }
JunOpenGL3dCompoundObject >> smoothingAngle: anAngle [ 
	smoothingAngle := anAngle
]

{ #category : #accessing }
JunOpenGL3dCompoundObject >> texture [
	^texture
]

{ #category : #accessing }
JunOpenGL3dCompoundObject >> texture: aTexture [ 
	texture := aTexture.
	aTexture isNil ifFalse: [aTexture object: self]
]

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject >> textureToLispList [
	| list |
	self hasTexture ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #texture.
	list tail: self texture toLispList.
	^list
]

{ #category : #'lisp support' }
JunOpenGL3dCompoundObject >> toLispList [
	| list |
	self isCompoundBody ifFalse: [^self patchedOrSkinningBodyFromLispList].
	list := self lispCons.
	list head: self kindName.
	self hasProperties ifTrue: [list add: self propertiesToLispList].
	self hasColor ifTrue: [list add: self colorToLispList].
	self hasTexture ifTrue: [list add: self textureToLispList].
	list add: self componentsToLispList.
	^list
]

{ #category : #'obj support' }
JunOpenGL3dCompoundObject >> toOBJUsing: aJunOBJWriter [ 
	| oldTextureCoordinateIndex |
	self rawName ifNotNil: [:it | aJunOBJWriter addGroupNamed: it].
	self hasTexture 
		ifTrue: 
			[oldTextureCoordinateIndex := aJunOBJWriter textureCoordinateIndex.
			aJunOBJWriter textureCoordinateIndex: 1].
	self componentsToOBJUsing: aJunOBJWriter.
	self hasTexture 
		ifTrue: [aJunOBJWriter textureCoordinateIndex: oldTextureCoordinateIndex]
]

{ #category : #transforming }
JunOpenGL3dCompoundObject >> transform: aTransformation [ 
	| object |
	object := self copy.
	object components: (object components collect: [:each | each transform: aTransformation]).
	^object
]

{ #category : #'vrml support' }
JunOpenGL3dCompoundObject >> vrml10ComponentsOn: aStream [ 
	self isCompoundBody ifFalse: [^self vrml10IndexedFaceSetOn: aStream].
	self components do: [:each | each vrml10On: aStream]
]

{ #category : #'vrml support' }
JunOpenGL3dCompoundObject >> vrml10IndexedFaceSetOn: aStream [ 
	| polygons points patches |
	Cursor wait
		showWhile: 
			[polygons := self components.
			points := OrderedCollection new: 1024.
			polygons do: [:polygon | self pointCollection: points for: polygon].
			points := points asArray.
			patches := OrderedCollection new: 1024.
			polygons do: [:polygon | self
					patcheCollection: patches
					from: points
					for: polygon].
			patches := patches asArray].
	points isEmpty
		ifFalse: 
			[aStream tab.
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
			self hasTexture
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
			(self hasTexture and: [self texture hasCoordinates])
				ifTrue: 
					[aStream tab.
					aStream nextPutAll: 'TextureCoordinate2 {'.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream nextPutAll: 'point ['.
					aStream cr.
					1 to: self texture coordinates size
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
							index = self texture coordinates size ifFalse: [aStream nextPutAll: ','].
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
			1 to: patches size
				do: 
					[:nth | 
					| indexes |
					indexes := patches at: nth.
					aStream tab.
					aStream tab.
					aStream tab.
					indexes
						do: 
							[:index | 
							aStream nextPutAll: (index - 1) printString.
							aStream nextPutAll: ','.
							aStream space].
					aStream nextPutAll: '-1'.
					nth = patches size ifFalse: [aStream nextPutAll: ','].
					aStream cr].
			aStream tab.
			aStream tab.
			aStream nextPutAll: '] #coordIndex'.
			aStream cr.
			(self hasTexture and: [self texture hasCoordinates])
				ifTrue: 
					[| i |
					aStream tab.
					aStream tab.
					aStream nextPutAll: 'textureCoordIndex ['.
					aStream cr.
					i := 0.
					1 to: patches size
						do: 
							[:nth | 
							| indexes |
							indexes := patches at: nth.
							aStream tab.
							aStream tab.
							aStream tab.
							i to: i + indexes size - 1
								do: 
									[:index | 
									aStream nextPutAll: index printString.
									aStream nextPutAll: ','.
									aStream space].
							aStream nextPutAll: '-1'.
							i := i + indexes size.
							nth = patches size ifFalse: [aStream nextPutAll: ','].
							aStream cr].
					aStream tab.
					aStream tab.
					aStream nextPutAll: '] #textureCoordIndex'.
					aStream cr].
			aStream tab.
			aStream nextPutAll: '} #' , self vrml10IndexedSetName.
			aStream cr]
]

{ #category : #'vrml support' }
JunOpenGL3dCompoundObject >> vrml10IndexedSetName [
	^'IndexedFaceSet' copy
]

{ #category : #'vrml support' }
JunOpenGL3dCompoundObject >> vrml10On: aStream [ 
	aStream nextPutAll: 'DEF'.
	aStream space.
	aStream nextPutAll: self legalName asString.
	aStream cr.
	aStream nextPutAll: 'Separator {'.
	aStream cr.
	self vrml10ColorOn: aStream.
	self vrml10ComponentsOn: aStream.
	aStream nextPutAll: '} #Separator'.
	aStream cr
]

{ #category : #'vrml support' }
JunOpenGL3dCompoundObject >> vrml20ComponentsOn: aStream [ 
	self isCompoundBody ifFalse: [^self vrml20IndexedFaceSetOn: aStream].
	1 to: self components size
		do: 
			[:nth | 
			| each |
			each := self components at: nth.
			each vrml20On: aStream.
			nth == self components size
				ifFalse: 
					[aStream tab.
					aStream tab.
					aStream nextPutAll: ','.
					aStream cr]]
]

{ #category : #'vrml support' }
JunOpenGL3dCompoundObject >> vrml20IndexedFaceSetOn: aStream [ 
	| polygons points patches |
	Cursor wait
		showWhile: 
			[polygons := self components.
			points := OrderedCollection new: 1024.
			polygons do: [:polygon | self pointCollection: points for: polygon].
			points := points asArray.
			patches := OrderedCollection new: 1024.
			polygons do: [:polygon | self
					patcheCollection: patches
					from: points
					for: polygon].
			patches := patches asArray].
	points isEmpty
		ifFalse: 
			[self name = self defaultName
				ifFalse: 
					[aStream nextPutAll: '#' , self name.
					aStream cr].
			aStream nextPutAll: 'Shape {'.
			aStream cr.
			self vrml20AppearanceOn: aStream.
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
			1 to: points size
				do: 
					[:index | 
					| point |
					point := points at: index.
					aStream tab.
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
			aStream nextPutAll: ' #patches: ' , patches size printString.
			aStream cr.
			1 to: patches size
				do: 
					[:nth | 
					| indexes |
					indexes := patches at: nth.
					aStream tab.
					aStream tab.
					aStream tab.
					indexes
						do: 
							[:index | 
							aStream nextPutAll: (index - 1) printString.
							aStream nextPutAll: ','.
							aStream space].
					aStream nextPutAll: '-1'.
					nth = patches size ifFalse: [aStream nextPutAll: ','].
					aStream cr].
			aStream tab.
			aStream tab.
			aStream nextPutAll: '] #coordIndex'.
			aStream cr.
			(self hasTexture and: [self texture hasCoordinates])
				ifTrue: 
					[| i |
					aStream tab.
					aStream tab.
					aStream nextPutAll: 'texCoord TextureCoordinate {'.
					aStream cr.
					aStream tab.
					aStream tab.
					aStream tab.
					aStream nextPutAll: 'point ['.
					aStream cr.
					1 to: self texture coordinates size
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
							index = self texture coordinates size ifFalse: [aStream nextPutAll: ','].
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
					i := 0.
					1 to: patches size
						do: 
							[:nth | 
							| indexes |
							indexes := patches at: nth.
							aStream tab.
							aStream tab.
							aStream tab.
							i to: i + indexes size - 1
								do: 
									[:index | 
									aStream nextPutAll: index printString.
									aStream nextPutAll: ','.
									aStream space].
							aStream nextPutAll: '-1'.
							i := i + indexes size.
							nth = patches size ifFalse: [aStream nextPutAll: ','].
							aStream cr].
					aStream tab.
					aStream tab.
					aStream nextPutAll: '] #texCoordIndex'.
					aStream cr].
			aStream tab.
			aStream tab.
			aStream nextPutAll: 'solid FALSE'.
			aStream cr.
			aStream tab.
			aStream nextPutAll: '} #' , self vrml20IndexedSetName.
			aStream cr.
			aStream nextPutAll: '} #Shape'.
			aStream cr]
]

{ #category : #'vrml support' }
JunOpenGL3dCompoundObject >> vrml20IndexedSetName [
	^'IndexedFaceSet' copy
]

{ #category : #'vrml support' }
JunOpenGL3dCompoundObject >> vrml20On: aStream [ 
	aStream nextPutAll: 'Transform {'.
	aStream cr.
	aStream tab.
	aStream nextPutAll: 'children ['.
	aStream cr.
	self vrml20ComponentsOn: aStream.
	aStream tab.
	aStream nextPutAll: '] #children'.
	aStream cr.
	aStream tab.
	aStream nextPutAll: 'bboxCenter '.
	aStream nextPutAll: self boundingBox center x asFloat printString.
	aStream space.
	aStream nextPutAll: self boundingBox center y asFloat printString.
	aStream space.
	aStream nextPutAll: self boundingBox center z asFloat printString.
	aStream cr.
	aStream tab.
	aStream nextPutAll: 'bboxSize '.
	aStream nextPutAll: self boundingBox width asFloat printString.
	aStream space.
	aStream nextPutAll: self boundingBox height asFloat printString.
	aStream space.
	aStream nextPutAll: self boundingBox depth asFloat printString.
	aStream cr.
	aStream nextPutAll: '} #Transform'.
	aStream cr
]

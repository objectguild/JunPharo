"
Imported by VwImportClass
"
Class {
	#name : #JunFormTriangulation1,
	#superclass : #JunForm2dRegion,
	#instVars : [
		'normalDelaunayTriangles',
		'insideTriangles',
		'outsideTriangles'
	],
	#category : #'Jun-Geometry-Forms'
}

{ #category : #copyright }
JunFormTriangulation1 class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunFormTriangulation1 class >> example1 [
	"JunFormTriangulation1 example1."

	| aCollection aPoint aBlock |
	aCollection := OrderedCollection new.
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formTriangulation anImage aModel |
			formTriangulation := JunFormTriangulation1 points: aPolyline.
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded
						displayBlock: 
							[:graphicsContext | 
							Cursor wait showWhile: [formTriangulation triangles].
							formTriangulation displayOn: graphicsContext].
			aModel := JunImageDisplayModel show: anImage at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			aPoint := aPoint translatedBy: 20 @ 20.
			formTriangulation].
	^JunFormTriangulation1 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation1 class >> example2 [
	"JunFormTriangulation1 example2."

	| aCollection aPoint aBlock |
	aCollection := OrderedCollection new.
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formTriangulation anImage aModel |
			formTriangulation := JunFormTriangulation1 points: aPolyline.
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded.
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Triangulation 1 (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			Cursor wait showWhile: 
					[formTriangulation trianglesInterim: 
							[:triangles :insides :outsides | 
							JunControlUtility do: 
									[anImage := JunImageUtility 
												imageExtent: formTriangulation boundingBox extent rounded
												displayBlock: 
													[:graphicsContext | 
													formTriangulation 
														displayOn: graphicsContext
														triangles: triangles
														insides: insides
														outsides: outsides].
									aModel
										image: anImage;
										redisplay]
								framesPerSecond: ((JunSensorUtility redButtonPressed 
										or: [JunSensorUtility altDown or: [JunSensorUtility ctrlDown]]) 
											ifTrue: [0]
											ifFalse: [15])]].
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded
						displayBlock: [:graphicsContext | formTriangulation displayOn: graphicsContext].
			aModel
				image: anImage;
				redisplay.
			aPoint := aPoint translatedBy: 20 @ 20.
			formTriangulation].
	^JunFormTriangulation1 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation1 class >> example3 [
	"JunFormTriangulation1 example3."

	| aCollection prefixNumber anIndex aPoint aBlock |
	(JunDialog 
		confirm: (#jun_Do_you_want_to_create_a___EG_files_for_animation_ 
				>> 'Do you want to create all JPEG files for animation?') asString
		initialAnswer: false) ifFalse: [^self].
	aCollection := OrderedCollection new.
	prefixNumber := 100000.
	anIndex := 0.
	anIndex := 1 + (anIndex + prefixNumber truncateTo: prefixNumber).
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formTriangulation anImage aModel aString |
			formTriangulation := JunFormTriangulation1 points: aPolyline.
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded.
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Triangulation 1 (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			Cursor wait showWhile: 
					[formTriangulation trianglesInterim: 
							[:triangles :insides :outsides | 
							anImage := JunImageUtility 
										imageExtent: formTriangulation boundingBox extent rounded
										displayBlock: 
											[:graphicsContext | 
											formTriangulation 
												displayOn: graphicsContext
												triangles: triangles
												insides: insides
												outsides: outsides].
							aModel
								image: anImage;
								redisplay.
							aString := anIndex printString.
							8 - aString size timesRepeat: [aString := '0' , aString].
							JunImageUtility writeImage: anImage to: (aString , '.jpg') asFilename.
							anIndex := anIndex + 1]].
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded
						displayBlock: [:graphicsContext | formTriangulation displayOn: graphicsContext].
			aModel
				image: anImage;
				redisplay.
			aString := anIndex printString.
			8 - aString size timesRepeat: [aString := '0' , aString].
			JunImageUtility writeImage: anImage to: (aString , '.jpg') asFilename.
			anIndex := 1 + (anIndex + prefixNumber truncateTo: prefixNumber).
			aPoint := aPoint translatedBy: 20 @ 20.
			formTriangulation].
	^JunFormTriangulation1 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation1 class >> example4 [
	"JunFormTriangulation1 example4."

	| aCollection anIndex aPoint aBlock |
	(JunDialog 
		confirm: (#jun_Do_you_want_to_create_a_movie_file_for_animation_ 
				>> 'Do you want to create a movie file for animation?') asString
		initialAnswer: false) ifFalse: [^self].
	aCollection := OrderedCollection new.
	anIndex := 1.
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formTriangulation anImage aModel aTick aString aFilename |
			formTriangulation := JunFormTriangulation1 points: aPolyline.
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded.
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Triangulation 1 (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			aTick := 50.
			aString := anIndex printString.
			2 - aString size timesRepeat: [aString := '0' , aString].
			aString := 'Triangulation_1_' , aString.
			aFilename := (JunUniFileName relativeFileNameString: aString , '.mov') 
						asFilename.
			JunImagesToMovie 
				filename: aFilename
				extent: formTriangulation boundingBox extent rounded
				do: 
					[:imagesToMovie | 
					formTriangulation trianglesInterim: 
							[:triangles :insides :outsides | 
							anImage := JunImageUtility 
										imageExtent: formTriangulation boundingBox extent rounded
										displayBlock: 
											[:graphicsContext | 
											formTriangulation 
												displayOn: graphicsContext
												triangles: triangles
												insides: insides
												outsides: outsides].
							aModel
								image: anImage;
								redisplay.
							Cursor write showWhile: [imagesToMovie add: anImage milliseconds: aTick]].
					anImage := JunImageUtility 
								imageExtent: formTriangulation boundingBox extent rounded
								displayBlock: [:graphicsContext | formTriangulation displayOn: graphicsContext].
					aModel
						image: anImage;
						redisplay.
					Cursor write showWhile: [imagesToMovie add: anImage milliseconds: aTick]].
			anIndex := anIndex + 1.
			aPoint := aPoint translatedBy: 20 @ 20.
			formTriangulation].
	^JunFormTriangulation1 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation1 class >> examplePolylines [
	"JunFormTriangulation1 examplePolylines."

	| examplePolylines |
	examplePolylines := JunForm2dRegion exampleOriginalPolylines.
	examplePolylines := #(4 10) collect: [:index | examplePolylines at: index].
	^examplePolylines
]

{ #category : #'instance creation' }
JunFormTriangulation1 class >> points: pointCollection [ 
	^super points: pointCollection
]

{ #category : #copyright }
JunFormTriangulation1 class >> system [
	^'Jun'
]

{ #category : #copyright }
JunFormTriangulation1 class >> version [
	^'799'
]

{ #category : #computing }
JunFormTriangulation1 >> computeInsideAndOutsideTriangles: triangleCollection interim: aBlock [ 
	| insideStream outsideStream |
	insideStream := WriteStream on: (Array new: 256).
	outsideStream := WriteStream on: (Array new: 256).
	triangleCollection
		do: 
			[:triangle | 
			| p1 p2 p3 line1 line2 line3 |
			p1 := triangle at: 1.
			p2 := triangle at: 2.
			p3 := triangle at: 3.
			line1 := Array with: p1 with: p2.
			line2 := Array with: p2 with: p3.
			line3 := Array with: p3 with: p1.
			((self segments includes: line1)
				or: [self segments includes: line1 reverse])
				ifTrue: [line1 := nil].
			((self segments includes: line2)
				or: [self segments includes: line2 reverse])
				ifTrue: [line2 := nil].
			((self segments includes: line3)
				or: [self segments includes: line3 reverse])
				ifTrue: [line3 := nil].
			(((line1 isNil or: [self containsLineSegment: line1])
				and: [line2 isNil or: [self containsLineSegment: line2]])
				and: [line3 isNil or: [self containsLineSegment: line3]])
				ifTrue: 
					[insideStream nextPut: triangle.
					aBlock notNil ifTrue: [aBlock
							value: triangleCollection
							value: insideStream contents
							value: outsideStream contents]]
				ifFalse: 
					[outsideStream nextPut: triangle.
					aBlock notNil ifTrue: [aBlock
							value: triangleCollection
							value: insideStream contents
							value: outsideStream contents]]].
	insideTriangles := insideStream contents.
	outsideTriangles := outsideStream contents.
	^Array with: insideTriangles with: outsideTriangles
]

{ #category : #displaying }
JunFormTriangulation1 >> displayOn: graphicsContext [ 
	self displayOn: graphicsContext at: Point zero
]

{ #category : #displaying }
JunFormTriangulation1 >> displayOn: graphicsContext at: aPoint [ 
	self
		displayOn: graphicsContext
		at: Point zero
		triangles: self triangles
		color: ColorValue red
		insides: nil
		color: ColorValue green
		outsides: nil
		color: ColorValue blue
]

{ #category : #displaying }
JunFormTriangulation1 >> displayOn: graphicsContext at: aPoint triangles: triangleCollection color: colorValue insides: triangleCollection1 color: colorValue1 outsides: triangleCollection2 color: colorValue2 [ 
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
	triangleCollection1 notNil ifTrue: [triangleCollection1
			do: 
				[:triangle | 
				triangle first = triangle last
					ifTrue: [aPolyline := triangle]
					ifFalse: [aPolyline := triangle , (Array with: triangle first)].
				aPolyline := aPolyline collect: [:each | each x rounded @ each y rounded].
				graphicsContext paint: (colorValue1 blendWith: ColorValue white).
				graphicsContext displayPolygon: aPolyline at: displayPoint.
				graphicsContext paint: colorValue1.
				graphicsContext displayPolyline: aPolyline at: displayPoint]].
	triangleCollection2 notNil ifTrue: [triangleCollection2
			do: 
				[:triangle | 
				triangle first = triangle last
					ifTrue: [aPolyline := triangle]
					ifFalse: [aPolyline := triangle , (Array with: triangle first)].
				aPolyline := aPolyline collect: [:each | each x rounded @ each y rounded].
				graphicsContext paint: (colorValue2 blendWith: ColorValue white).
				graphicsContext displayPolygon: aPolyline at: displayPoint.
				graphicsContext paint: colorValue2.
				graphicsContext displayPolyline: aPolyline at: displayPoint]].
	graphicsContext paint: ColorValue black.
	graphicsContext displayPolyline: self points at: displayPoint
]

{ #category : #displaying }
JunFormTriangulation1 >> displayOn: graphicsContext triangles: triangleCollection [ 
	self
		displayOn: graphicsContext
		at: Point zero
		triangles: triangleCollection
		color: ColorValue red
		insides: nil
		color: nil
		outsides: nil
		color: nil
]

{ #category : #displaying }
JunFormTriangulation1 >> displayOn: graphicsContext triangles: triangleCollection insides: triangleCollection1 outsides: triangleCollection2 [ 
	^self
		displayOn: graphicsContext
		at: Point zero
		triangles: triangleCollection
		color: ColorValue red
		insides: triangleCollection1
		color: ColorValue green
		outsides: triangleCollection2
		color: ColorValue blue
]

{ #category : #'initialize-release' }
JunFormTriangulation1 >> initialize [
	super initialize.
	normalDelaunayTriangles := nil.
	insideTriangles := nil.
	outsideTriangles := nil
]

{ #category : #computing }
JunFormTriangulation1 >> normalDelaunayTrianglesInterim: aBlock [ 
	normalDelaunayTriangles isNil
		ifTrue: 
			[| aProcessor triangleCollection |
			aBlock isNil
				ifTrue: 
					[aProcessor := JunVoronoi2dProcessor dots: self pointsWithoutLast.
					aProcessor compute.
					triangleCollection := aProcessor triangles]
				ifFalse: 
					[| aStream |
					aBlock
						value: Array new
						value: nil
						value: nil.
					aStream := WriteStream on: (Array new: self pointsWithoutLast size).
					self pointsWithoutLast with: (1 to: self pointsWithoutLast size)
						do: 
							[:aPoint :anIndex | 
							aStream nextPut: aPoint.
							anIndex >= 3
								ifTrue: 
									[aProcessor := JunVoronoi2dProcessor dots: aStream contents.
									aProcessor compute.
									triangleCollection := aProcessor triangles.
									aBlock
										value: triangleCollection
										value: nil
										value: nil]]].
			normalDelaunayTriangles := triangleCollection.
			self computeInsideAndOutsideTriangles: normalDelaunayTriangles interim: aBlock].
	^insideTriangles
]

{ #category : #accessing }
JunFormTriangulation1 >> points: pointCollection [ 
	super points: pointCollection.
	normalDelaunayTriangles := nil.
	insideTriangles := nil.
	outsideTriangles := nil
]

{ #category : #accessing }
JunFormTriangulation1 >> triangles [
	^self trianglesInterim: nil
]

{ #category : #accessing }
JunFormTriangulation1 >> trianglesInterim: aBlock [ 
	"Usage: aFormTriangulationByAoki trianglesInterim: [:triangles :insides :outsides | self]."

	self pointsWithoutLast size < 3 ifTrue: [^Array new].
	^self normalDelaunayTrianglesInterim: aBlock
]

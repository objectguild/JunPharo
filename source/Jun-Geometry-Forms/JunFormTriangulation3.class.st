"
Imported by VwImportClass
"
Class {
	#name : #JunFormTriangulation3,
	#superclass : #JunForm2dRegion,
	#instVars : [
		'universalDelaunayTriangles'
	],
	#category : #'Jun-Geometry-Forms'
}

{ #category : #copyright }
JunFormTriangulation3 class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunFormTriangulation3 class >> example1 [
	"JunFormTriangulation3 example1."

	| aCollection aPoint aBlock |
	aCollection := OrderedCollection new.
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formTriangulation anImage aModel |
			formTriangulation := JunFormTriangulation3 points: aPolyline.
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
	^JunFormTriangulation3 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation3 class >> example2 [
	"JunFormTriangulation3 example2."

	| aCollection aPoint aBlock |
	aCollection := OrderedCollection new.
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formTriangulation anImage aModel |
			formTriangulation := JunFormTriangulation3 points: aPolyline.
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded.
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Triangulation 3 (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			Cursor wait showWhile: 
					[formTriangulation trianglesInterim: 
							[:triangles | 
							JunControlUtility do: 
									[anImage := JunImageUtility 
												imageExtent: formTriangulation boundingBox extent rounded
												displayBlock: 
													[:graphicsContext | 
													formTriangulation displayOn: graphicsContext triangles: triangles].
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
	^JunFormTriangulation3 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation3 class >> example3 [
	"JunFormTriangulation3 example3."

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
			formTriangulation := JunFormTriangulation3 points: aPolyline.
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded.
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Triangulation 3 (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			Cursor wait showWhile: 
					[formTriangulation trianglesInterim: 
							[:triangles | 
							anImage := JunImageUtility 
										imageExtent: formTriangulation boundingBox extent rounded
										displayBlock: 
											[:graphicsContext | 
											formTriangulation displayOn: graphicsContext triangles: triangles].
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
	^JunFormTriangulation3 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation3 class >> example4 [
	"JunFormTriangulation3 example4."

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
			| formTriangulation anImage aModel aString aTick aFilename |
			formTriangulation := JunFormTriangulation3 points: aPolyline.
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded.
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Triangulation 3 (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			aTick := 50.
			aString := anIndex printString.
			2 - aString size timesRepeat: [aString := '0' , aString].
			aString := 'Triangulation_3_' , aString.
			aFilename := (JunUniFileName relativeFileNameString: aString , '.mov') 
						asFilename.
			JunImagesToMovie 
				filename: aFilename
				extent: formTriangulation boundingBox extent rounded
				do: 
					[:imagesToMovie | 
					formTriangulation trianglesInterim: 
							[:triangles | 
							anImage := JunImageUtility 
										imageExtent: formTriangulation boundingBox extent rounded
										displayBlock: 
											[:graphicsContext | 
											formTriangulation displayOn: graphicsContext triangles: triangles].
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
	^JunFormTriangulation3 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation3 class >> examplePolylines [
	"JunFormTriangulation3 examplePolylines."

	| examplePolylines |
	examplePolylines := JunForm2dRegion exampleOriginalPolylines.
	examplePolylines := #(4 10) collect: [:index | examplePolylines at: index].
	^examplePolylines
]

{ #category : #'instance creation' }
JunFormTriangulation3 class >> points: pointCollection [ 
	^super points: pointCollection
]

{ #category : #copyright }
JunFormTriangulation3 class >> system [
	^'Jun'
]

{ #category : #copyright }
JunFormTriangulation3 class >> version [
	^'799'
]

{ #category : #displaying }
JunFormTriangulation3 >> displayOn: graphicsContext [ 
	self displayOn: graphicsContext at: Point zero
]

{ #category : #displaying }
JunFormTriangulation3 >> displayOn: graphicsContext at: aPoint [ 
	self
		displayOn: graphicsContext
		at: Point zero
		triangles: self triangles
		color: ColorValue red
]

{ #category : #displaying }
JunFormTriangulation3 >> displayOn: graphicsContext at: aPoint triangles: triangleCollection color: colorValue [ 
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
JunFormTriangulation3 >> displayOn: graphicsContext triangles: triangleCollection [ 
	self
		displayOn: graphicsContext
		at: Point zero
		triangles: triangleCollection
		color: ColorValue red
]

{ #category : #'initialize-release' }
JunFormTriangulation3 >> initialize [
	super initialize.
	universalDelaunayTriangles := nil
]

{ #category : #accessing }
JunFormTriangulation3 >> points: pointCollection [ 
	super points: pointCollection.
	universalDelaunayTriangles := nil
]

{ #category : #accessing }
JunFormTriangulation3 >> triangles [
	^self trianglesInterim: nil
]

{ #category : #accessing }
JunFormTriangulation3 >> trianglesInterim: aBlock [ 
	"Usage: aFormTriangulationByOda trianglesInterim: [:triangles | self]."

	self pointsWithoutLast size < 3 ifTrue: [^Array new].
	^self universalDelaunayTrianglesInterim: aBlock
]

{ #category : #computing }
JunFormTriangulation3 >> universalDelaunayTrianglesInterim: aBlock [ 
	universalDelaunayTriangles isNil 
		ifTrue: 
			[| aProcessor triangleCollection |
			aBlock isNil 
				ifTrue: 
					[aProcessor := Jun2dDelaunayProcessor fromPolygon: self pointsWithoutLast.
					triangleCollection := aProcessor insideTriangles]
				ifFalse: 
					[| aStream |
					aBlock value: Array new.
					aStream := WriteStream on: (Array new: self pointsWithoutLast size).
					self pointsWithoutLast with: (1 to: self pointsWithoutLast size)
						do: 
							[:aPoint :anIndex | 
							aStream nextPut: aPoint.
							anIndex >= 3 
								ifTrue: 
									[aProcessor := Jun2dDelaunayProcessor fromPolygon: aStream contents.
									triangleCollection := aProcessor insideTriangles.
									aBlock value: triangleCollection]]].
			universalDelaunayTriangles := triangleCollection].
	^universalDelaunayTriangles
]

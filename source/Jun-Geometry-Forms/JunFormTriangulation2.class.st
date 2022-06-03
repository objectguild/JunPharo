"
Imported by VwImportClass
"
Class {
	#name : #JunFormTriangulation2,
	#superclass : #JunForm2dRegion,
	#instVars : [
		'constrainedDelaunayTriangles'
	],
	#category : #'Jun-Geometry-Forms'
}

{ #category : #copyright }
JunFormTriangulation2 class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunFormTriangulation2 class >> example1 [
	"JunFormTriangulation2 example1."

	| aCollection aPoint aBlock |
	aCollection := OrderedCollection new.
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formTriangulation anImage aModel |
			formTriangulation := JunFormTriangulation2 points: aPolyline.
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
	^JunFormTriangulation2 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation2 class >> example2 [
	"JunFormTriangulation2 example2."

	| aCollection aPoint aBlock |
	aCollection := OrderedCollection new.
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formTriangulation anImage aModel |
			formTriangulation := JunFormTriangulation2 points: aPolyline.
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded.
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Triangulation 2 (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			Cursor wait showWhile: 
					[formTriangulation trianglesInterim: 
							[:triangles :triangle :pending | 
							JunControlUtility do: 
									[anImage := JunImageUtility 
												imageExtent: formTriangulation boundingBox extent rounded
												displayBlock: 
													[:graphicsContext | 
													formTriangulation 
														displayOn: graphicsContext
														triangles: triangles
														triangle: triangle
														pending: pending].
									aModel
										image: anImage;
										redisplay]
								framesPerSecond: ((JunSensorUtility redButtonPressed 
										or: [JunSensorUtility altDown or: [JunSensorUtility ctrlDown]]) 
											ifTrue: [0]
											ifFalse: [30])]].
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded
						displayBlock: [:graphicsContext | formTriangulation displayOn: graphicsContext].
			aModel
				image: anImage;
				redisplay.
			aPoint := aPoint translatedBy: 20 @ 20.
			formTriangulation].
	^JunFormTriangulation2 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation2 class >> example3 [
	"JunFormTriangulation2 example3."

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
			formTriangulation := JunFormTriangulation2 points: aPolyline.
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded.
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Triangulation 2 (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			Cursor wait showWhile: 
					[formTriangulation trianglesInterim: 
							[:triangles :triangle :pending | 
							anImage := JunImageUtility 
										imageExtent: formTriangulation boundingBox extent rounded
										displayBlock: 
											[:graphicsContext | 
											formTriangulation 
												displayOn: graphicsContext
												triangles: triangles
												triangle: triangle
												pending: pending].
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
	^JunFormTriangulation2 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation2 class >> example4 [
	"JunFormTriangulation2 example4."

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
			formTriangulation := JunFormTriangulation2 points: aPolyline.
			anImage := JunImageUtility 
						imageExtent: formTriangulation boundingBox extent rounded.
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Triangulation 2 (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			aTick := 50.
			aString := anIndex printString.
			2 - aString size timesRepeat: [aString := '0' , aString].
			aString := 'Triangulation_2_' , aString.
			aFilename := (JunUniFileName relativeFileNameString: aString , '.mov') 
						asFilename.
			JunImagesToMovie 
				filename: aFilename
				extent: formTriangulation boundingBox extent rounded
				do: 
					[:imagesToMovie | 
					formTriangulation trianglesInterim: 
							[:triangles :triangle :pending | 
							anImage := JunImageUtility 
										imageExtent: formTriangulation boundingBox extent rounded
										displayBlock: 
											[:graphicsContext | 
											formTriangulation 
												displayOn: graphicsContext
												triangles: triangles
												triangle: triangle
												pending: pending].
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
	^JunFormTriangulation2 examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormTriangulation2 class >> examplePolylines [
	"JunFormTriangulation2 examplePolylines."

	| examplePolylines |
	examplePolylines := JunForm2dRegion exampleOriginalPolylines.
	examplePolylines := #(4 10) collect: [:index | examplePolylines at: index].
	^examplePolylines
]

{ #category : #'instance creation' }
JunFormTriangulation2 class >> points: pointCollection [ 
	^super points: pointCollection
]

{ #category : #copyright }
JunFormTriangulation2 class >> system [
	^'Jun'
]

{ #category : #copyright }
JunFormTriangulation2 class >> version [
	^'799'
]

{ #category : #private }
JunFormTriangulation2 >> angle: line1 with: line2 [ 
	| denominator angle numerator gamma |
	denominator := line1 f squared + line1 g squared * (line2 f squared + line2 g squared).
	denominator := denominator sqrt.
	denominator < Jun2dLine accuracy
		ifTrue: [angle := 0.0d]
		ifFalse: 
			[numerator := line1 f * line2 f + (line1 g * line2 g).
			gamma := (numerator / denominator max: -1.0d)
						min: 1.0d.
			gamma := numerator / denominator.
			angle := gamma arcCos].
	^angle
]

{ #category : #computing }
JunFormTriangulation2 >> constrainedDelaunayTriangles: pointCollection on: aStream interim: aBlock [ 
	| point1 point2 points max target associations triangle line1 line2 angle p nth stream |
	pointCollection size < 3 ifTrue: [^self].
	aBlock notNil ifTrue: [aBlock
			value: aStream contents
			value: nil
			value: nil].
	point1 := pointCollection at: 1.
	point2 := pointCollection at: 2.
	pointCollection size = 3
		ifTrue: 
			[triangle := Array
						with: point1
						with: (pointCollection at: 3)
						with: point2.
			aBlock notNil ifTrue: [aBlock
					value: aStream contents
					value: triangle
					value: nil].
			aStream nextPut: triangle.
			^self].
	points := pointCollection copyFrom: 3 to: pointCollection size.
	max := nil.
	target := nil.
	associations := OrderedCollection new: points size.
	points with: (1 to: points size)
		do: 
			[:point :index | 
			triangle := Array
						with: point1
						with: point
						with: point2.
			aBlock notNil ifTrue: [aBlock
					value: aStream contents
					value: triangle
					value: nil].
			line1 := Jun2dLine from: point to: point1.
			line2 := Jun2dLine from: point to: point2.
			angle := self angle: line1 with: line2.
			max isNil
				ifTrue: 
					[max := angle.
					target := index]
				ifFalse: [angle > max
						ifTrue: 
							[max := angle.
							target := index]].
			associations add: index -> angle].
	target isNil ifTrue: [^self].
	triangle := Array
				with: point1
				with: (p := points at: target)
				with: point2.
	aBlock notNil ifTrue: [aBlock
			value: aStream contents
			value: triangle
			value: nil].
	((self containsLineSegment: (Array with: point1 with: p))
		and: [self containsLineSegment: (Array with: point2 with: p)])
		ifFalse: 
			[nth := self
						searchAgain: point1
						with: point2
						associations: associations
						in: points
						on: aStream
						interim: aBlock.
			triangle := Array
						with: point1
						with: (points at: nth)
						with: point2.
			target := nth].
	aStream nextPut: triangle.
	stream := WriteStream on: (Array new: pointCollection size).
	stream nextPut: (points at: target).
	stream nextPut: point2.
	1 to: target - 1 do: [:n | stream nextPut: (points at: n)].
	self
		constrainedDelaunayTriangles: stream contents
		on: aStream
		interim: aBlock.
	stream := WriteStream on: (Array new: pointCollection size).
	stream nextPut: point1.
	target to: points size do: [:n | stream nextPut: (points at: n)].
	self
		constrainedDelaunayTriangles: stream contents
		on: aStream
		interim: aBlock
]

{ #category : #computing }
JunFormTriangulation2 >> constrainedDelaunayTrianglesInterim: aBlock [ 
	constrainedDelaunayTriangles isNil
		ifTrue: 
			[| aStream |
			aStream := WriteStream on: (Array new: 256).
			self
				constrainedDelaunayTriangles: self pointsWithoutLast
				on: aStream
				interim: aBlock.
			constrainedDelaunayTriangles := aStream contents].
	^constrainedDelaunayTriangles
]

{ #category : #displaying }
JunFormTriangulation2 >> displayOn: graphicsContext [ 
	self displayOn: graphicsContext at: Point zero
]

{ #category : #displaying }
JunFormTriangulation2 >> displayOn: graphicsContext at: aPoint [ 
	self
		displayOn: graphicsContext
		at: aPoint
		triangles: self triangles
		color: ColorValue red
		triangle: nil
		color: nil
		pending: nil
		color: nil
]

{ #category : #displaying }
JunFormTriangulation2 >> displayOn: graphicsContext at: aPoint triangles: triangleCollection color: colorValue triangle: pointArray1 color: colorValue1 pending: pointArray2 color: colorValue2 [ 
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
	pointArray1 notNil
		ifTrue: 
			[pointArray1 first = pointArray1 last
				ifTrue: [aPolyline := pointArray1]
				ifFalse: [aPolyline := pointArray1 , (Array with: pointArray1 first)].
			aPolyline := aPolyline collect: [:each | each x rounded @ each y rounded].
			graphicsContext paint: (colorValue1 blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolyline at: displayPoint.
			graphicsContext paint: colorValue1.
			graphicsContext displayPolyline: aPolyline at: displayPoint].
	pointArray2 notNil
		ifTrue: 
			[pointArray2 first = pointArray2 last
				ifTrue: [aPolyline := pointArray2]
				ifFalse: [aPolyline := pointArray2 , (Array with: pointArray2 first)].
			aPolyline := aPolyline collect: [:each | each x rounded @ each y rounded].
			graphicsContext paint: (colorValue2 blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolyline at: displayPoint.
			graphicsContext paint: colorValue2.
			graphicsContext displayPolyline: aPolyline at: displayPoint].
	graphicsContext paint: ColorValue black.
	graphicsContext displayPolyline: self points at: displayPoint
]

{ #category : #displaying }
JunFormTriangulation2 >> displayOn: graphicsContext triangles: triangleCollection [ 
	self
		displayOn: graphicsContext
		at: Point zero
		triangles: triangleCollection
		color: ColorValue red
		triangle: nil
		color: nil
		pending: nil
		color: nil
]

{ #category : #displaying }
JunFormTriangulation2 >> displayOn: graphicsContext triangles: triangleCollection triangle: pointArray1 pending: pointArray2 [ 
	self
		displayOn: graphicsContext
		at: Point zero
		triangles: triangleCollection
		color: ColorValue red
		triangle: pointArray1
		color: ColorValue blue
		pending: pointArray2
		color: ColorValue green
]

{ #category : #'initialize-release' }
JunFormTriangulation2 >> initialize [
	super initialize.
	constrainedDelaunayTriangles := nil
]

{ #category : #accessing }
JunFormTriangulation2 >> points: pointCollection [ 
	super points: pointCollection.
	constrainedDelaunayTriangles := nil
]

{ #category : #private }
JunFormTriangulation2 >> searchAgain: point1 with: point2 associations: associations in: points on: aStream interim: aBlock [ 
	| collection first index point triangle |
	collection := OrderedCollection new: associations size.
	first := true.
	associations 
		do: [:assoc | first ifTrue: [first := false] ifFalse: [collection add: assoc]].
	collection := collection 
				asSortedCollection: [:a1 :a2 | a1 value >= a2 value].
	collection do: 
			[:assoc | 
			index := assoc key.
			point := points at: index.
			triangle := Array 
						with: point1
						with: point
						with: point2.
			aBlock notNil 
				ifTrue: 
					[aBlock 
						value: aStream contents
						value: nil
						value: triangle].
			((self containsLineSegment: (Array with: point1 with: point)) 
				and: [self containsLineSegment: (Array with: point2 with: point)]) 
					ifTrue: [^index]].
	^self error: 'unexpected error'
]

{ #category : #accessing }
JunFormTriangulation2 >> triangles [
	^self trianglesInterim: nil
]

{ #category : #accessing }
JunFormTriangulation2 >> trianglesInterim: aBlock [ 
	"Usage: aFormTriangulationByIgarashi trianglesInterim: [:triangles :triangle :pending | self]."

	self pointsWithoutLast size < 3 ifTrue: [^Array new].
	^self constrainedDelaunayTrianglesInterim: aBlock
]

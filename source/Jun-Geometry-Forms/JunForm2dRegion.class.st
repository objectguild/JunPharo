"
Imported by VwImportClass
"
Class {
	#name : #JunForm2dRegion,
	#superclass : #JunAbstractObject,
	#instVars : [
		'originalPoints',
		'boundingBox',
		'processingPoints',
		'lineSegments'
	],
	#category : #'Jun-Geometry-Forms'
}

{ #category : #copyright }
JunForm2dRegion class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunForm2dRegion class >> example1 [
	"JunForm2dRegion example1."

	| aStream aPolyline aPoint formRegion anImage aModel pointArray |
	aStream := Array new writeStream.
	aStream nextPut: 10 @ 10.
	aStream nextPut: 50 @ 70.
	aStream nextPut: 90 @ 10.
	aStream nextPut: 95 @ 95.
	aStream nextPut: 20 @ 80.
	aStream nextPut: 10 @ 10.
	aPolyline := aStream contents.
	aPoint := 100 @ 100.
	formRegion := JunForm2dRegion points: aPolyline.
	anImage := JunImageUtility imageExtent: 100 @ 100
				displayBlock: 
					[:graphicsContext | 
					graphicsContext paint: ColorValue blue.
					graphicsContext displayPolygon: formRegion points.
					graphicsContext paint: ColorValue black.
					graphicsContext displayPolyline: formRegion points].
	aModel := JunImageDisplayModel 
				show: anImage
				label: 'Region (' , anImage extent printString , ')'
				at: aPoint.
	aStream := Array new writeStream.
	(0 to: 100 by: 1) 
		do: [:y | (0 to: 100 by: 1) do: [:x | aStream nextPut: x @ y]].
	pointArray := aStream contents.
	pointArray do: 
			[:xyPoint | 
			JunControlUtility do: 
					[anImage := JunImageUtility imageExtent: anImage extent
								displayBlock: 
									[:graphicsContext | 
									| aBoolean aRectangle |
									anImage displayOn: graphicsContext.
									aBoolean := formRegion containsPoint: xyPoint.
									aBoolean 
										ifTrue: [graphicsContext paint: ColorValue green]
										ifFalse: [graphicsContext paint: ColorValue red].
									aRectangle := (xyPoint extent: 1 @ 1) expandedBy: 0.
									graphicsContext displayRectangle: aRectangle].
					aModel
						image: anImage;
						redisplay]
				framesPerSecond: ((JunSensorUtility redButtonPressed 
						or: [JunSensorUtility altDown or: [JunSensorUtility ctrlDown]]) 
							ifTrue: [10]
							ifFalse: [0])].
	^formRegion
]

{ #category : #examples }
JunForm2dRegion class >> example2 [
	"JunForm2dRegion example2."

	| aCollection aPoint marginPoint aBlock |
	aCollection := OrderedCollection new.
	aPoint := 100 @ 100.
	marginPoint := 10 @ 10.
	aBlock := 
			[:aPolyline | 
			| formRegion displayPoint anImage aModel aStream aBox pointArray |
			formRegion := JunForm2dRegion points: aPolyline.
			displayPoint := Point zero - formRegion boundingBox origin 
						+ (marginPoint * 2).
			anImage := JunImageUtility 
						imageExtent: formRegion boundingBox extent rounded + (marginPoint * 4)
						displayBlock: 
							[:graphicsContext | 
							graphicsContext paint: ColorValue blue.
							graphicsContext displayPolygon: formRegion points at: displayPoint.
							graphicsContext paint: ColorValue black.
							graphicsContext displayPolyline: formRegion points at: displayPoint].
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Region (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			aStream := Array new writeStream.
			aBox := formRegion boundingBox expandedBy: marginPoint * 1.
			(aBox origin y to: aBox corner y by: 5) do: 
					[:y | 
					(aBox origin x to: aBox corner x by: 5) do: [:x | aStream nextPut: x @ y]].
			pointArray := aStream contents.
			pointArray do: 
					[:xyPoint | 
					JunControlUtility do: 
							[anImage := JunImageUtility imageExtent: anImage extent
										displayBlock: 
											[:graphicsContext | 
											| aBoolean aRectangle |
											anImage displayOn: graphicsContext.
											aBoolean := formRegion containsPoint: xyPoint.
											aBoolean 
												ifTrue: [graphicsContext paint: ColorValue green]
												ifFalse: [graphicsContext paint: ColorValue red].
											aRectangle := (xyPoint extent: 1 @ 1) expandedBy: 1.
											graphicsContext displayRectangle: aRectangle at: displayPoint].
							aModel
								image: anImage;
								redisplay]
						framesPerSecond: ((JunSensorUtility redButtonPressed 
								or: [JunSensorUtility altDown or: [JunSensorUtility ctrlDown]]) 
									ifTrue: [10]
									ifFalse: [0])].
			aPoint := aPoint + (20 @ 20).
			formRegion].
	^JunForm2dRegion examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunForm2dRegion class >> example3 [
	"JunForm2dRegion example3."

	| aCollection aPoint marginPoint aBlock |
	aCollection := OrderedCollection new.
	aPoint := 100 @ 100.
	marginPoint := 10 @ 10.
	aBlock := 
			[:aPolyline | 
			| formRegion displayPoint anImage aModel aStream aBox aRandom pointArray |
			formRegion := JunForm2dRegion points: aPolyline.
			displayPoint := Point zero - formRegion boundingBox origin 
						+ (marginPoint * 2).
			anImage := JunImageUtility 
						imageExtent: formRegion boundingBox extent rounded + (marginPoint * 4)
						displayBlock: 
							[:graphicsContext | 
							graphicsContext paint: ColorValue blue.
							graphicsContext displayPolygon: formRegion points at: displayPoint.
							graphicsContext paint: ColorValue black.
							graphicsContext displayPolyline: formRegion points at: displayPoint].
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Region (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			aStream := Array new writeStream.
			aBox := formRegion boundingBox expandedBy: marginPoint * 1.
			aRandom := Random new.
			(aBox origin y to: aBox corner y by: 5) do: 
					[:y | 
					(aBox origin x to: aBox corner x by: 5) 
						do: [:x | aStream nextPut: x @ y + (aRandom next * 3 - 1.5) asPoint]].
			pointArray := aStream contents.
			pointArray size timesRepeat: 
					[| i j v |
					i := (aRandom next * (pointArray size - 1) + 1) rounded.
					j := (aRandom next * (pointArray size - 1) + 1) rounded.
					v := pointArray at: i.
					pointArray at: i put: (pointArray at: j).
					pointArray at: j put: v].
			pointArray do: 
					[:xyPoint | 
					JunControlUtility do: 
							[anImage := JunImageUtility imageExtent: anImage extent
										displayBlock: 
											[:graphicsContext | 
											| aBoolean aRectangle |
											anImage displayOn: graphicsContext.
											aBoolean := formRegion containsPoint: xyPoint.
											aBoolean 
												ifTrue: [graphicsContext paint: ColorValue green]
												ifFalse: [graphicsContext paint: ColorValue red].
											aRectangle := (xyPoint extent: 1 @ 1) expandedBy: 1.
											graphicsContext displayRectangle: aRectangle at: displayPoint].
							aModel
								image: anImage;
								redisplay]
						framesPerSecond: ((JunSensorUtility redButtonPressed 
								or: [JunSensorUtility altDown or: [JunSensorUtility ctrlDown]]) 
									ifTrue: [10]
									ifFalse: [0])].
			aPoint := aPoint + (20 @ 20).
			formRegion].
	^JunForm2dRegion examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunForm2dRegion class >> example4 [
	"JunForm2dRegion example4."

	| aCollection anIndex aPoint marginPoint aBlock aString aFilename |
	(JunDialog 
		confirm: (#jun_Do_you_want_to_create_a_movie_file_for_animation_ 
				>> 'Do you want to create a movie file for animation?') asString
		initialAnswer: false) ifFalse: [^self].
	aCollection := OrderedCollection new.
	anIndex := 1.
	aPoint := 100 @ 100.
	marginPoint := 10 @ 10.
	aBlock := 
			[:aPolyline | 
			| formRegion displayPoint anImage aModel aTick aStream aBox aRandom pointArray countValue |
			formRegion := JunForm2dRegion points: aPolyline.
			displayPoint := Point zero - formRegion boundingBox origin 
						+ (marginPoint * 2).
			anImage := JunImageUtility 
						imageExtent: formRegion boundingBox extent rounded + (marginPoint * 4)
						displayBlock: 
							[:graphicsContext | 
							graphicsContext paint: ColorValue blue.
							graphicsContext displayPolygon: formRegion points at: displayPoint.
							graphicsContext paint: ColorValue black.
							graphicsContext displayPolyline: formRegion points at: displayPoint].
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Region (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			aTick := 50.
			aString := anIndex printString.
			2 - aString size timesRepeat: [aString := '0' , aString].
			aString := 'MonteCarlo_' , aString.
			aFilename := (JunUniFileName relativeFileNameString: aString , '.mov') 
						asFilename.
			JunImagesToMovie 
				filename: aFilename
				extent: anImage extent
				do: 
					[:imagesToMovie | 
					aStream := Array new writeStream.
					aBox := formRegion boundingBox expandedBy: marginPoint * 1.
					aRandom := Random new.
					(aBox origin y to: aBox corner y by: 10) do: 
							[:y | 
							(aBox origin x to: aBox corner x by: 10) 
								do: [:x | aStream nextPut: x @ y + (aRandom next * 5 - 2.5) asPoint]].
					pointArray := aStream contents.
					pointArray size timesRepeat: 
							[| i j v |
							i := (aRandom next * (pointArray size - 1) + 1) rounded.
							j := (aRandom next * (pointArray size - 1) + 1) rounded.
							v := pointArray at: i.
							pointArray at: i put: (pointArray at: j).
							pointArray at: j put: v].
					countValue := 0.
					pointArray do: 
							[:xyPoint | 
							anImage := JunImageUtility imageExtent: anImage extent
										displayBlock: 
											[:graphicsContext | 
											| aBoolean aRectangle |
											anImage displayOn: graphicsContext.
											aBoolean := formRegion containsPoint: xyPoint.
											aBoolean 
												ifTrue: [graphicsContext paint: ColorValue green]
												ifFalse: [graphicsContext paint: ColorValue red].
											aRectangle := (xyPoint extent: 1 @ 1) expandedBy: 3.
											graphicsContext displayRectangle: aRectangle at: displayPoint].
							countValue \\ 10 = 0 
								ifTrue: 
									[aModel
										image: anImage;
										redisplay.
									Cursor write showWhile: [imagesToMovie add: anImage milliseconds: aTick]].
							countValue := countValue + 1].
					aModel
						image: anImage;
						redisplay.
					Cursor write showWhile: [imagesToMovie add: anImage milliseconds: aTick]].
			anIndex := anIndex + 1.
			aPoint := aPoint + (20 @ 20).
			formRegion].
	^JunForm2dRegion examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunForm2dRegion class >> example5 [
	"JunForm2dRegion example5."

	| aCollection aPoint marginPoint aBlock |
	aCollection := OrderedCollection new.
	aPoint := 100 @ 100.
	marginPoint := 10 @ 10.
	aBlock := 
			[:aPolyline | 
			| formRegion displayPoint anImage aModel countValue |
			formRegion := JunForm2dRegion points: aPolyline.
			displayPoint := Point zero - formRegion boundingBox origin 
						+ (marginPoint * 2).
			anImage := JunImageUtility 
						imageExtent: formRegion boundingBox extent rounded + (marginPoint * 4)
						displayBlock: 
							[:graphicsContext | 
							graphicsContext paint: ColorValue blue.
							graphicsContext displayPolygon: formRegion points at: displayPoint.
							graphicsContext paint: ColorValue red.
							graphicsContext displayPolyline: formRegion points at: displayPoint].
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Thinning (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			countValue := 0.
			anImage := JunImageProcessor makeThin: anImage
						interim: 
							[:interimImage | 
							countValue \\ 25 = 0 
								ifTrue: 
									[JunControlUtility do: 
											[anImage := JunImageUtility imageExtent: anImage extent
														displayBlock: 
															[:graphicsContext | 
															graphicsContext paint: ColorValue green.
															graphicsContext displayPolygon: formRegion points at: displayPoint.
															graphicsContext paint: ColorValue red.
															graphicsContext displayPolyline: formRegion points at: displayPoint.
															(OpaqueImage figure: (interimImage copy 
																		palette: (MappedPalette with: ColorValue white with: ColorValue blue))
																shape: ((interimImage copy)
																		palette: CoveragePalette monoMaskPalette;
																		yourself)) 
																	displayOn: graphicsContext].
											aModel
												image: anImage;
												redisplay]
										forMilliseconds: ((JunSensorUtility redButtonPressed 
												or: [JunSensorUtility altDown or: [JunSensorUtility ctrlDown]]) 
													ifTrue: [0]
													ifFalse: [75])].
							countValue := countValue + 1].
			anImage := JunImageUtility imageExtent: anImage extent
						displayBlock: 
							[:graphicsContext | 
							graphicsContext paint: ColorValue green.
							graphicsContext displayPolygon: formRegion points at: displayPoint.
							graphicsContext paint: ColorValue red.
							graphicsContext displayPolyline: formRegion points at: displayPoint.
							(OpaqueImage figure: (anImage copy 
										palette: (MappedPalette with: ColorValue white with: ColorValue blue))
								shape: ((anImage copy)
										palette: CoveragePalette monoMaskPalette;
										yourself)) 
									displayOn: graphicsContext].
			aModel
				image: anImage;
				redisplay.
			aPoint := aPoint + (20 @ 20).
			formRegion].
	^JunForm2dRegion examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunForm2dRegion class >> example6 [
	"JunForm2dRegion example6."

	| aCollection anIndex aPoint marginPoint aBlock |
	(JunDialog 
		confirm: (#jun_Do_you_want_to_create_a_movie_file_for_animation_ 
				>> 'Do you want to create a movie file for animation?') asString
		initialAnswer: false) ifFalse: [^self].
	aCollection := OrderedCollection new.
	anIndex := 1.
	aPoint := 100 @ 100.
	marginPoint := 10 @ 10.
	aBlock := 
			[:aPolyline | 
			| formRegion displayPoint anImage aModel aTick aString aFilename countValue |
			formRegion := JunForm2dRegion points: aPolyline.
			displayPoint := Point zero - formRegion boundingBox origin 
						+ (marginPoint * 2).
			anImage := JunImageUtility 
						imageExtent: formRegion boundingBox extent rounded + (marginPoint * 4)
						displayBlock: 
							[:graphicsContext | 
							graphicsContext paint: ColorValue blue.
							graphicsContext displayPolygon: formRegion points at: displayPoint.
							graphicsContext paint: ColorValue red.
							graphicsContext displayPolyline: formRegion points at: displayPoint].
			aModel := JunImageDisplayModel 
						show: anImage
						label: 'Thinning (' , anImage extent printString , ')'
						at: aPoint.
			aCollection add: aModel.
			aModel closeTogether: aCollection.
			aTick := 50.
			aString := anIndex printString.
			2 - aString size timesRepeat: [aString := '0' , aString].
			aString := 'Thinning_' , aString.
			aFilename := (JunUniFileName relativeFileNameString: aString , '.mov') 
						asFilename.
			JunImagesToMovie 
				filename: aFilename
				extent: anImage extent
				do: 
					[:imagesToMovie | 
					countValue := 0.
					anImage := JunImageProcessor makeThin: anImage
								interim: 
									[:interimImage | 
									countValue \\ 25 = 0 
										ifTrue: 
											[anImage := JunImageUtility imageExtent: anImage extent
														displayBlock: 
															[:graphicsContext | 
															graphicsContext paint: ColorValue green.
															graphicsContext displayPolygon: formRegion points at: displayPoint.
															graphicsContext paint: ColorValue red.
															graphicsContext displayPolyline: formRegion points at: displayPoint.
															(OpaqueImage figure: (interimImage copy 
																		palette: (MappedPalette with: ColorValue white with: ColorValue blue))
																shape: ((interimImage copy)
																		palette: CoveragePalette monoMaskPalette;
																		yourself)) 
																	displayOn: graphicsContext].
											aModel
												image: anImage;
												redisplay.
											Cursor write showWhile: [imagesToMovie add: anImage milliseconds: aTick]].
									countValue := countValue + 1].
					anImage := JunImageUtility imageExtent: anImage extent
								displayBlock: 
									[:graphicsContext | 
									graphicsContext paint: ColorValue green.
									graphicsContext displayPolygon: formRegion points at: displayPoint.
									graphicsContext paint: ColorValue red.
									graphicsContext displayPolyline: formRegion points at: displayPoint.
									(OpaqueImage figure: (anImage copy 
												palette: (MappedPalette with: ColorValue white with: ColorValue blue))
										shape: ((anImage copy)
												palette: CoveragePalette monoMaskPalette;
												yourself)) 
											displayOn: graphicsContext].
					aModel
						image: anImage;
						redisplay.
					Cursor write showWhile: [imagesToMovie add: anImage milliseconds: aTick]].
			anIndex := anIndex + 1.
			aPoint := aPoint + (20 @ 20).
			formRegion].
	^JunForm2dRegion examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunForm2dRegion class >> exampleOriginalPolylines [
	"JunForm2dRegion exampleOriginalPolylines."

	| messageSelectors polylineCollection |
	messageSelectors := OrderedCollection new.
	messageSelectors add: #examplePolyline1.
	messageSelectors add: #examplePolyline2.
	messageSelectors add: #examplePolyline3.
	messageSelectors add: #examplePolyline4.
	messageSelectors add: #examplePolyline5.
	messageSelectors add: #examplePolyline6.
	messageSelectors add: #examplePolyline7.
	messageSelectors add: #examplePolyline8.
	messageSelectors add: #examplePolyline9.
	messageSelectors add: #examplePolylineA.
	messageSelectors add: #examplePolylineB.
	polylineCollection := messageSelectors collect: 
					[:messageSelector | 
					| aPolyline |
					aPolyline := JunForm2dRegion perform: messageSelector.
					aPolyline := aPolyline collect: [:p | p scaledBy: 2 @ 2].
					aPolyline].
	^polylineCollection
]

{ #category : #examples }
JunForm2dRegion class >> examplePolyline1 [
	"JunForm2dRegion examplePolyline1."

	| aStream |
	aStream := WriteStream on: Array new.
	aStream nextPut: (Point x: 80 y: 96).
	aStream nextPut: (Point x: 79 y: 96).
	aStream nextPut: (Point x: 74 y: 93).
	aStream nextPut: (Point x: 68 y: 90).
	aStream nextPut: (Point x: 63 y: 85).
	aStream nextPut: (Point x: 59 y: 78).
	aStream nextPut: (Point x: 58 y: 71).
	aStream nextPut: (Point x: 60 y: 63).
	aStream nextPut: (Point x: 64 y: 54).
	aStream nextPut: (Point x: 68 y: 48).
	aStream nextPut: (Point x: 73 y: 44).
	aStream nextPut: (Point x: 80 y: 39).
	aStream nextPut: (Point x: 89 y: 37).
	aStream nextPut: (Point x: 98 y: 36).
	aStream nextPut: (Point x: 104 y: 37).
	aStream nextPut: (Point x: 109 y: 38).
	aStream nextPut: (Point x: 115 y: 42).
	aStream nextPut: (Point x: 121 y: 47).
	aStream nextPut: (Point x: 126 y: 53).
	aStream nextPut: (Point x: 129 y: 58).
	aStream nextPut: (Point x: 131 y: 66).
	aStream nextPut: (Point x: 131 y: 72).
	aStream nextPut: (Point x: 131 y: 78).
	aStream nextPut: (Point x: 131 y: 82).
	aStream nextPut: (Point x: 131 y: 86).
	aStream nextPut: (Point x: 131 y: 89).
	aStream nextPut: (Point x: 131 y: 92).
	aStream nextPut: (Point x: 131 y: 99).
	aStream nextPut: (Point x: 132 y: 103).
	aStream nextPut: (Point x: 134 y: 107).
	aStream nextPut: (Point x: 139 y: 111).
	aStream nextPut: (Point x: 141 y: 112).
	aStream nextPut: (Point x: 146 y: 115).
	aStream nextPut: (Point x: 154 y: 120).
	aStream nextPut: (Point x: 162 y: 126).
	aStream nextPut: (Point x: 170 y: 131).
	aStream nextPut: (Point x: 178 y: 138).
	aStream nextPut: (Point x: 185 y: 146).
	aStream nextPut: (Point x: 191 y: 154).
	aStream nextPut: (Point x: 196 y: 164).
	aStream nextPut: (Point x: 200 y: 173).
	aStream nextPut: (Point x: 201 y: 183).
	aStream nextPut: (Point x: 202 y: 191).
	aStream nextPut: (Point x: 201 y: 197).
	aStream nextPut: (Point x: 199 y: 204).
	aStream nextPut: (Point x: 196 y: 210).
	aStream nextPut: (Point x: 191 y: 215).
	aStream nextPut: (Point x: 183 y: 220).
	aStream nextPut: (Point x: 176 y: 222).
	aStream nextPut: (Point x: 167 y: 222).
	aStream nextPut: (Point x: 155 y: 217).
	aStream nextPut: (Point x: 145 y: 210).
	aStream nextPut: (Point x: 136 y: 202).
	aStream nextPut: (Point x: 127 y: 191).
	aStream nextPut: (Point x: 124 y: 181).
	aStream nextPut: (Point x: 122 y: 172).
	aStream nextPut: (Point x: 122 y: 162).
	aStream nextPut: (Point x: 122 y: 153).
	aStream nextPut: (Point x: 122 y: 129).
	aStream nextPut: (Point x: 121 y: 120).
	aStream nextPut: (Point x: 118 y: 110).
	aStream nextPut: (Point x: 115 y: 104).
	aStream nextPut: (Point x: 113 y: 102).
	aStream nextPut: (Point x: 111 y: 101).
	aStream nextPut: (Point x: 109 y: 100).
	aStream nextPut: (Point x: 106 y: 100).
	aStream nextPut: (Point x: 104 y: 100).
	aStream nextPut: (Point x: 102 y: 100).
	aStream nextPut: (Point x: 99 y: 99).
	aStream nextPut: (Point x: 97 y: 99).
	aStream nextPut: (Point x: 94 y: 99).
	aStream nextPut: (Point x: 92 y: 99).
	aStream nextPut: (Point x: 90 y: 98).
	aStream nextPut: (Point x: 80 y: 96).
	^aStream contents
]

{ #category : #examples }
JunForm2dRegion class >> examplePolyline2 [
	"JunForm2dRegion examplePolyline2."

	| aStream |
	aStream := WriteStream on: Array new.
	aStream nextPut: (Point x: 124 y: 99).
	aStream nextPut: (Point x: 119 y: 100).
	aStream nextPut: (Point x: 108 y: 103).
	aStream nextPut: (Point x: 98 y: 106).
	aStream nextPut: (Point x: 84 y: 110).
	aStream nextPut: (Point x: 72 y: 111).
	aStream nextPut: (Point x: 62 y: 111).
	aStream nextPut: (Point x: 55 y: 107).
	aStream nextPut: (Point x: 52 y: 100).
	aStream nextPut: (Point x: 53 y: 88).
	aStream nextPut: (Point x: 57 y: 78).
	aStream nextPut: (Point x: 67 y: 66).
	aStream nextPut: (Point x: 80 y: 60).
	aStream nextPut: (Point x: 94 y: 57).
	aStream nextPut: (Point x: 117 y: 57).
	aStream nextPut: (Point x: 138 y: 62).
	aStream nextPut: (Point x: 150 y: 67).
	aStream nextPut: (Point x: 177 y: 111).
	aStream nextPut: (Point x: 176 y: 131).
	aStream nextPut: (Point x: 169 y: 147).
	aStream nextPut: (Point x: 162 y: 157).
	aStream nextPut: (Point x: 146 y: 168).
	aStream nextPut: (Point x: 135 y: 173).
	aStream nextPut: (Point x: 123 y: 175).
	aStream nextPut: (Point x: 108 y: 170).
	aStream nextPut: (Point x: 103 y: 165).
	aStream nextPut: (Point x: 98 y: 157).
	aStream nextPut: (Point x: 101 y: 146).
	aStream nextPut: (Point x: 113 y: 136).
	aStream nextPut: (Point x: 122 y: 131).
	aStream nextPut: (Point x: 134 y: 124).
	aStream nextPut: (Point x: 141 y: 118).
	aStream nextPut: (Point x: 145 y: 113).
	aStream nextPut: (Point x: 147 y: 105).
	aStream nextPut: (Point x: 144 y: 99).
	aStream nextPut: (Point x: 140 y: 95).
	aStream nextPut: (Point x: 128 y: 90).
	aStream nextPut: (Point x: 118 y: 87).
	aStream nextPut: (Point x: 112 y: 87).
	aStream nextPut: (Point x: 103 y: 87).
	aStream nextPut: (Point x: 92 y: 88).
	aStream nextPut: (Point x: 82 y: 90).
	aStream nextPut: (Point x: 77 y: 92).
	aStream nextPut: (Point x: 75 y: 94).
	aStream nextPut: (Point x: 74 y: 95).
	aStream nextPut: (Point x: 72 y: 97).
	aStream nextPut: (Point x: 72 y: 98).
	aStream nextPut: (Point x: 124 y: 99).
	^aStream contents
]

{ #category : #examples }
JunForm2dRegion class >> examplePolyline3 [
	"JunForm2dRegion examplePolyline3."

	| aStream |
	aStream := WriteStream on: Array new.
	aStream nextPut: (Point x: 64 y: 91).
	aStream nextPut: (Point x: 65 y: 89).
	aStream nextPut: (Point x: 73 y: 84).
	aStream nextPut: (Point x: 81 y: 80).
	aStream nextPut: (Point x: 90 y: 77).
	aStream nextPut: (Point x: 100 y: 77).
	aStream nextPut: (Point x: 109 y: 78).
	aStream nextPut: (Point x: 118 y: 83).
	aStream nextPut: (Point x: 124 y: 89).
	aStream nextPut: (Point x: 129 y: 94).
	aStream nextPut: (Point x: 136 y: 103).
	aStream nextPut: (Point x: 143 y: 110).
	aStream nextPut: (Point x: 149 y: 116).
	aStream nextPut: (Point x: 155 y: 120).
	aStream nextPut: (Point x: 162 y: 125).
	aStream nextPut: (Point x: 170 y: 129).
	aStream nextPut: (Point x: 178 y: 131).
	aStream nextPut: (Point x: 185 y: 132).
	aStream nextPut: (Point x: 198 y: 135).
	aStream nextPut: (Point x: 211 y: 137).
	aStream nextPut: (Point x: 214 y: 137).
	aStream nextPut: (Point x: 212 y: 137).
	aStream nextPut: (Point x: 208 y: 137).
	aStream nextPut: (Point x: 199 y: 137).
	aStream nextPut: (Point x: 191 y: 137).
	aStream nextPut: (Point x: 180 y: 137).
	aStream nextPut: (Point x: 169 y: 135).
	aStream nextPut: (Point x: 162 y: 133).
	aStream nextPut: (Point x: 155 y: 132).
	aStream nextPut: (Point x: 147 y: 130).
	aStream nextPut: (Point x: 140 y: 127).
	aStream nextPut: (Point x: 136 y: 125).
	aStream nextPut: (Point x: 131 y: 122).
	aStream nextPut: (Point x: 125 y: 118).
	aStream nextPut: (Point x: 121 y: 113).
	aStream nextPut: (Point x: 115 y: 109).
	aStream nextPut: (Point x: 111 y: 107).
	aStream nextPut: (Point x: 102 y: 104).
	aStream nextPut: (Point x: 85 y: 98).
	aStream nextPut: (Point x: 83 y: 97).
	aStream nextPut: (Point x: 82 y: 97).
	aStream nextPut: (Point x: 78 y: 96).
	aStream nextPut: (Point x: 64 y: 91).
	^aStream contents
]

{ #category : #examples }
JunForm2dRegion class >> examplePolyline4 [
	"JunForm2dRegion examplePolyline4."

	| aStream |
	aStream := WriteStream on: Array new.
	aStream nextPut: (Point x: 115 y: 142).
	aStream nextPut: (Point x: 109 y: 136).
	aStream nextPut: (Point x: 97 y: 119).
	aStream nextPut: (Point x: 92 y: 111).
	aStream nextPut: (Point x: 90 y: 100).
	aStream nextPut: (Point x: 95 y: 78).
	aStream nextPut: (Point x: 102 y: 64).
	aStream nextPut: (Point x: 116 y: 50).
	aStream nextPut: (Point x: 132 y: 49).
	aStream nextPut: (Point x: 142 y: 55).
	aStream nextPut: (Point x: 154 y: 66).
	aStream nextPut: (Point x: 160 y: 83).
	aStream nextPut: (Point x: 160 y: 99).
	aStream nextPut: (Point x: 156 y: 110).
	aStream nextPut: (Point x: 153 y: 123).
	aStream nextPut: (Point x: 152 y: 131).
	aStream nextPut: (Point x: 156 y: 137).
	aStream nextPut: (Point x: 165 y: 141).
	aStream nextPut: (Point x: 180 y: 144).
	aStream nextPut: (Point x: 198 y: 149).
	aStream nextPut: (Point x: 210 y: 158).
	aStream nextPut: (Point x: 215 y: 168).
	aStream nextPut: (Point x: 215 y: 182).
	aStream nextPut: (Point x: 210 y: 191).
	aStream nextPut: (Point x: 199 y: 194).
	aStream nextPut: (Point x: 183 y: 190).
	aStream nextPut: (Point x: 170 y: 184).
	aStream nextPut: (Point x: 162 y: 183).
	aStream nextPut: (Point x: 149 y: 187).
	aStream nextPut: (Point x: 140 y: 193).
	aStream nextPut: (Point x: 132 y: 199).
	aStream nextPut: (Point x: 122 y: 206).
	aStream nextPut: (Point x: 110 y: 210).
	aStream nextPut: (Point x: 96 y: 210).
	aStream nextPut: (Point x: 83 y: 207).
	aStream nextPut: (Point x: 74 y: 203).
	aStream nextPut: (Point x: 71 y: 195).
	aStream nextPut: (Point x: 73 y: 185).
	aStream nextPut: (Point x: 81 y: 178).
	aStream nextPut: (Point x: 94 y: 173).
	aStream nextPut: (Point x: 106 y: 172).
	aStream nextPut: (Point x: 112 y: 170).
	aStream nextPut: (Point x: 117 y: 169).
	aStream nextPut: (Point x: 124 y: 165).
	aStream nextPut: (Point x: 125 y: 162).
	aStream nextPut: (Point x: 125 y: 159).
	aStream nextPut: (Point x: 115 y: 142).
	^aStream contents
]

{ #category : #examples }
JunForm2dRegion class >> examplePolyline5 [
	"JunForm2dRegion examplePolyline5."

	| aStream |
	aStream := WriteStream on: Array new.
	aStream nextPut: (Point x: 69 y: 119).
	aStream nextPut: (Point x: 67 y: 116).
	aStream nextPut: (Point x: 61 y: 107).
	aStream nextPut: (Point x: 54 y: 90).
	aStream nextPut: (Point x: 54 y: 75).
	aStream nextPut: (Point x: 59 y: 62).
	aStream nextPut: (Point x: 73 y: 49).
	aStream nextPut: (Point x: 91 y: 40).
	aStream nextPut: (Point x: 112 y: 34).
	aStream nextPut: (Point x: 140 y: 33).
	aStream nextPut: (Point x: 162 y: 38).
	aStream nextPut: (Point x: 181 y: 49).
	aStream nextPut: (Point x: 192 y: 60).
	aStream nextPut: (Point x: 200 y: 77).
	aStream nextPut: (Point x: 201 y: 90).
	aStream nextPut: (Point x: 200 y: 102).
	aStream nextPut: (Point x: 190 y: 116).
	aStream nextPut: (Point x: 177 y: 127).
	aStream nextPut: (Point x: 167 y: 133).
	aStream nextPut: (Point x: 150 y: 139).
	aStream nextPut: (Point x: 133 y: 142).
	aStream nextPut: (Point x: 123 y: 142).
	aStream nextPut: (Point x: 112 y: 141).
	aStream nextPut: (Point x: 101 y: 142).
	aStream nextPut: (Point x: 90 y: 145).
	aStream nextPut: (Point x: 86 y: 149).
	aStream nextPut: (Point x: 82 y: 160).
	aStream nextPut: (Point x: 79 y: 167).
	aStream nextPut: (Point x: 75 y: 177).
	aStream nextPut: (Point x: 71 y: 190).
	aStream nextPut: (Point x: 67 y: 198).
	aStream nextPut: (Point x: 63 y: 206).
	aStream nextPut: (Point x: 59 y: 212).
	aStream nextPut: (Point x: 54 y: 216).
	aStream nextPut: (Point x: 51 y: 217).
	aStream nextPut: (Point x: 49 y: 216).
	aStream nextPut: (Point x: 48 y: 211).
	aStream nextPut: (Point x: 48 y: 202).
	aStream nextPut: (Point x: 50 y: 194).
	aStream nextPut: (Point x: 52 y: 186).
	aStream nextPut: (Point x: 56 y: 176).
	aStream nextPut: (Point x: 58 y: 173).
	aStream nextPut: (Point x: 61 y: 168).
	aStream nextPut: (Point x: 64 y: 161).
	aStream nextPut: (Point x: 67 y: 155).
	aStream nextPut: (Point x: 70 y: 148).
	aStream nextPut: (Point x: 71 y: 142).
	aStream nextPut: (Point x: 72 y: 138).
	aStream nextPut: (Point x: 73 y: 135).
	aStream nextPut: (Point x: 73 y: 133).
	aStream nextPut: (Point x: 73 y: 132).
	aStream nextPut: (Point x: 69 y: 119).
	^aStream contents
]

{ #category : #examples }
JunForm2dRegion class >> examplePolyline6 [
	"JunForm2dRegion examplePolyline6."

	| aStream |
	aStream := WriteStream on: Array new.
	aStream nextPut: (Point x: 43 y: 168).
	aStream nextPut: (Point x: 45 y: 166).
	aStream nextPut: (Point x: 66 y: 145).
	aStream nextPut: (Point x: 90 y: 120).
	aStream nextPut: (Point x: 118 y: 94).
	aStream nextPut: (Point x: 135 y: 77).
	aStream nextPut: (Point x: 150 y: 66).
	aStream nextPut: (Point x: 154 y: 63).
	aStream nextPut: (Point x: 155 y: 63).
	aStream nextPut: (Point x: 153 y: 73).
	aStream nextPut: (Point x: 155 y: 105).
	aStream nextPut: (Point x: 161 y: 127).
	aStream nextPut: (Point x: 169 y: 160).
	aStream nextPut: (Point x: 175 y: 180).
	aStream nextPut: (Point x: 178 y: 199).
	aStream nextPut: (Point x: 181 y: 214).
	aStream nextPut: (Point x: 180 y: 218).
	aStream nextPut: (Point x: 171 y: 216).
	aStream nextPut: (Point x: 141 y: 207).
	aStream nextPut: (Point x: 127 y: 202).
	aStream nextPut: (Point x: 115 y: 198).
	aStream nextPut: (Point x: 99 y: 195).
	aStream nextPut: (Point x: 90 y: 194).
	aStream nextPut: (Point x: 81 y: 193).
	aStream nextPut: (Point x: 43 y: 168).
	^aStream contents
]

{ #category : #examples }
JunForm2dRegion class >> examplePolyline7 [
	"JunForm2dRegion examplePolyline7."

	| aStream |
	aStream := WriteStream on: Array new.
	aStream nextPut: (Point x: 50 y: 50).
	aStream nextPut: (Point x: -50 y: 50).
	aStream nextPut: (Point x: -50 y: -50).
	aStream nextPut: (Point x: 50 y: -50).
	aStream nextPut: (Point x: 50 y: 50).
	^aStream contents
]

{ #category : #examples }
JunForm2dRegion class >> examplePolyline8 [
	"JunForm2dRegion examplePolyline8."

	| aStream |
	aStream := WriteStream on: Array new.
	aStream nextPut: (Point x: 0 y: 50).
	aStream nextPut: (Point x: -50 y: 0).
	aStream nextPut: (Point x: 0 y: -50).
	aStream nextPut: (Point x: 50 y: 0).
	aStream nextPut: (Point x: 0 y: 50).
	^aStream contents
]

{ #category : #examples }
JunForm2dRegion class >> examplePolyline9 [
	"JunForm2dRegion examplePolyline9."

	| aStream |
	aStream := WriteStream on: Array new.
	aStream nextPut: (Point x: -63 y: 11).
	aStream nextPut: (Point x: -83 y: 3).
	aStream nextPut: (Point x: -96 y: -12).
	aStream nextPut: (Point x: -99 y: -29).
	aStream nextPut: (Point x: -95 y: -48).
	aStream nextPut: (Point x: -82 y: -66).
	aStream nextPut: (Point x: -59 y: -80).
	aStream nextPut: (Point x: -35 y: -86).
	aStream nextPut: (Point x: -11 y: -83).
	aStream nextPut: (Point x: 15 y: -61).
	aStream nextPut: (Point x: 21 y: -49).
	aStream nextPut: (Point x: 21 y: -28).
	aStream nextPut: (Point x: 24 y: -6).
	aStream nextPut: (Point x: 32 y: 13).
	aStream nextPut: (Point x: 40 y: 21).
	aStream nextPut: (Point x: 60 y: 23).
	aStream nextPut: (Point x: 72 y: 19).
	aStream nextPut: (Point x: 82 y: 18).
	aStream nextPut: (Point x: 94 y: 30).
	aStream nextPut: (Point x: 104 y: 48).
	aStream nextPut: (Point x: 105 y: 65).
	aStream nextPut: (Point x: 96 y: 86).
	aStream nextPut: (Point x: 81 y: 99).
	aStream nextPut: (Point x: 63 y: 104).
	aStream nextPut: (Point x: 45 y: 101).
	aStream nextPut: (Point x: 31 y: 93).
	aStream nextPut: (Point x: 15 y: 79).
	aStream nextPut: (Point x: -3 y: 65).
	aStream nextPut: (Point x: -21 y: 62).
	aStream nextPut: (Point x: -35 y: 69).
	aStream nextPut: (Point x: -48 y: 79).
	aStream nextPut: (Point x: -62 y: 87).
	aStream nextPut: (Point x: -78 y: 90).
	aStream nextPut: (Point x: -91 y: 82).
	aStream nextPut: (Point x: -94 y: 72).
	aStream nextPut: (Point x: -92 y: 59).
	aStream nextPut: (Point x: -80 y: 50).
	aStream nextPut: (Point x: -61 y: 48).
	aStream nextPut: (Point x: -42 y: 50).
	aStream nextPut: (Point x: -31 y: 50).
	aStream nextPut: (Point x: -16 y: 44).
	aStream nextPut: (Point x: -9 y: 36).
	aStream nextPut: (Point x: -13 y: 21).
	aStream nextPut: (Point x: -23 y: 19).
	aStream nextPut: (Point x: -40 y: 21).
	aStream nextPut: (Point x: -49 y: 26).
	aStream nextPut: (Point x: -59 y: 30).
	aStream nextPut: (Point x: -72 y: 32).
	aStream nextPut: (Point x: -82 y: 31).
	aStream nextPut: (Point x: -73 y: 21).
	aStream nextPut: (Point x: -61 y: 20).
	aStream nextPut: (Point x: -63 y: 11).
	^aStream contents
]

{ #category : #examples }
JunForm2dRegion class >> examplePolylineA [
	"JunForm2dRegion examplePolylineA."

	| aStream |
	aStream := WriteStream on: Array new.
	aStream nextPut: 148.54944165028d @ 0.0d.
	aStream nextPut: 122.7275437144d @ 9.6588671647162d.
	aStream nextPut: 124.17509361861d @ 19.667402705031d.
	aStream nextPut: 166.36379087294d @ 39.94041246864d.
	aStream nextPut: 130.06872649937d @ 42.261891103576d.
	aStream nextPut: 113.7711688798d @ 47.125561157053d.
	aStream nextPut: 83.313008081892d @ 42.450097891659d.
	aStream nextPut: 97.16930430929d @ 59.545426263742d.
	aStream nextPut: 91.823464597923d @ 66.713652099185d.
	aStream nextPut: 94.254364410556d @ 80.500832163691d.
	aStream nextPut: 113.14745466108d @ 113.14745466108d.
	aStream nextPut: 64.449267234635d @ 75.460396577943d.
	aStream nextPut: 95.237566696975d @ 131.08326495138d.
	aStream nextPut: 100.13814769035d @ 163.41060525445d.
	aStream nextPut: 60.94069111526d @ 119.60284059555d.
	aStream nextPut: 60.751068264924d @ 146.66605293383d.
	aStream nextPut: 54.708236392496d @ 168.37463849308d.
	aStream nextPut: 19.561652292333d @ 81.480145795844d.
	aStream nextPut: 18.235372496518d @ 115.13361072056d.
	aStream nextPut: 10.652216215256d @ 135.34924012504d.
	aStream nextPut: 6.4082259415831d-15 @ 104.65772811942d.
	aStream nextPut: -7.0111911860156d @ 89.085630653977d.
	aStream nextPut: -21.722095535327d @ 137.14791358809d.
	aStream nextPut: -38.514655304288d @ 160.42508488406d.
	aStream nextPut: -56.374997676534d @ 173.50440225736d.
	aStream nextPut: -72.23444062254d @ 174.38936622137d.
	aStream nextPut: -74.620081537196d @ 146.45015594655d.
	aStream nextPut: -100.59148757093d @ 164.15038870341d.
	aStream nextPut: -58.394079084752d @ 80.372554714817d.
	aStream nextPut: -112.88830180337d @ 132.17521918565d.
	aStream nextPut: -62.073197562641d @ 62.073197562641d.
	aStream nextPut: -72.944501021608d @ 62.300489433325d.
	aStream nextPut: -158.408564736d @ 115.09055908099d.
	aStream nextPut: -108.98368008065d @ 66.785285047813d.
	aStream nextPut: -84.85915124303d @ 43.23789718082d.
	aStream nextPut: -151.68986453557d @ 62.831999165171d.
	aStream nextPut: -136.61307300666d @ 44.388278182768d.
	aStream nextPut: -180.31926396433d @ 43.290825130796d.
	aStream nextPut: -182.01175567735d @ 28.827830055443d.
	aStream nextPut: -137.28245432342d @ 10.804363472326d.
	aStream nextPut: -146.13044946753d @ 1.7895227690485d-14.
	aStream nextPut: -172.28359633569d @ -13.559013089502d.
	aStream nextPut: -161.86933002915d @ -25.637583242375d.
	aStream nextPut: -163.67144789599d @ -39.294038107714d.
	aStream nextPut: -93.16408800243d @ -30.270847173565d.
	aStream nextPut: -80.830110086781d @ -33.480927846055d.
	aStream nextPut: -119.81124929354d @ -61.04688065078d.
	aStream nextPut: -84.666282193731d @ -51.883564457196d.
	aStream nextPut: -149.87052048841d @ -108.88730682913d.
	aStream nextPut: -74.85688568014d @ -63.933820233354d.
	aStream nextPut: -90.409302836324d @ -90.409302836324d.
	aStream nextPut: -120.36293249952d @ -140.9268872931d.
	aStream nextPut: -97.311584545913d @ -133.9379056214d.
	aStream nextPut: -97.229042696316d @ -158.6633773619d.
	aStream nextPut: -48.724356516052d @ -95.626933972381d.
	aStream nextPut: -50.721287344981d @ -122.45201980928d.
	aStream nextPut: -27.149221981482d @ -83.556713539523d.
	aStream nextPut: -33.207851796644d @ -138.32065745376d.
	aStream nextPut: -13.697534906321d @ -86.482831762098d.
	aStream nextPut: -14.003377191852d @ -177.92977759755d.
	aStream nextPut: -3.169760770874d-14 @ -172.55943843942d.
	aStream nextPut: 13.354320130248d @ -169.68272568736d.
	aStream nextPut: 21.070035481877d @ -133.03096843796d.
	aStream nextPut: 30.844501786732d @ -128.47659620083d.
	aStream nextPut: 28.275428734929d @ -87.022821524063d.
	aStream nextPut: 63.007960233942d @ -152.11467213425d.
	aStream nextPut: 57.321170878882d @ -112.49913215475d.
	aStream nextPut: 49.058024418109d @ -80.055419913896d.
	aStream nextPut: 98.716981343266d @ -135.87226836436d.
	aStream nextPut: 124.49559699594d @ -145.76561572561d.
	aStream nextPut: 78.669150464264d @ -78.669150464264d.
	aStream nextPut: 72.701272448186d @ -62.092752606613d.
	aStream nextPut: 142.86573366585d @ -103.79803130293d.
	aStream nextPut: 109.90414796646d @ -67.349348493694d.
	aStream nextPut: 169.36264382871d @ -86.294577224389d.
	aStream nextPut: 92.890951910073d @ -38.476692102899d.
	aStream nextPut: 174.57294459818d @ -56.722188129325d.
	aStream nextPut: 141.22683272491d @ -33.905562749412d.
	aStream nextPut: 152.66988280879d @ -24.180533943083d.
	aStream nextPut: 123.01254333334d @ -9.6812971211708d.
	^aStream contents collect: [:p | p scaledBy: 0.5d]
]

{ #category : #examples }
JunForm2dRegion class >> examplePolylineB [
	"JunForm2dRegion examplePolylineB."

	| aRandom maxRadius aStream |
	aRandom := JunRandomStream new.
	maxRadius := 100.0d.
	aStream := Array new writeStream.
	(0 to: 2 - (1 / 40) by: 1 / 40)
		collect: 
			[:a | 
			| angle radius point |
			angle := Double pi * a.
			radius := aRandom next * 0.6 + 0.4 * maxRadius.
			point := angle cos * radius @ (angle sin * radius).
			aStream nextPut: point].
	^aStream contents
]

{ #category : #examples }
JunForm2dRegion class >> examplePolylines [
	"JunForm2dRegion examplePolylines."

	| examplePolylines |
	examplePolylines := JunForm2dRegion exampleOriginalPolylines.
	examplePolylines := #(4 10) collect: [:index | examplePolylines at: index].
	^examplePolylines
]

{ #category : #'instance creation' }
JunForm2dRegion class >> points: pointCollection [ 
	| formRegion |
	formRegion := self new.
	formRegion points: pointCollection.
	^formRegion
]

{ #category : #copyright }
JunForm2dRegion class >> system [
	^'Jun'
]

{ #category : #copyright }
JunForm2dRegion class >> version [
	^'799'
]

{ #category : #accessing }
JunForm2dRegion >> boundingBox [
	boundingBox isNil ifTrue: [^0 @ 0 extent: 0 @ 0].
	^boundingBox
]

{ #category : #accessing }
JunForm2dRegion >> bounds [
	self boundingBox isNil ifTrue: [^0 @ 0 extent: 0 @ 0].
	^0 @ 0 extent: self boundingBox extent
]

{ #category : #testing }
JunForm2dRegion >> containsLineSegment: twoPoints [ 
	| p1 p2 line accuracy stream intersection intersections |
	p1 := twoPoints at: 1.
	p2 := twoPoints at: 2.
	line := Jun2dLine from: p1 to: p2.
	accuracy := self defaultAccuracy.
	stream := WriteStream on: (Array new: 16).
	self segments
		do: 
			[:segment | 
			| it |
			it := Jun2dLine from: segment first to: segment last.
			intersection := line lineSegmentIntersectingPointWithLineSegment: it.
			intersection notNil ifTrue: [stream nextPut: intersection]].
	intersections := stream contents.
	intersections := intersections
				select: 
					[:p | 
					| exists |
					exists := self pointsWithoutLast detect: [:each | ((Jun2dPoint x: each x y: each y)
									distance: p)
									< accuracy]
								ifNone: [nil].
					exists isNil].
	intersections isEmpty ifFalse: [^false].
	#(0.25 0.5 0.75)
		do: 
			[:t | 
			| p |
			p := line atT: t.
			(self containsPoint: p)
				ifFalse: [^false]].
	^true
]

{ #category : #testing }
JunForm2dRegion >> containsPoint: aPoint [ 
	| accuracy p index line intersections line1 line2 n pp1 p1 pp2 p2 |
	(self boundingBox containsPoint: aPoint)
		ifFalse: [^false].
	accuracy := self defaultAccuracy.
	p := Jun2dPoint x: aPoint x y: aPoint y.
	index := self pointsWithoutLast findFirst: [:each | ((Jun2dPoint x: each x y: each y)
					distance: p)
					< accuracy].
	index > 0 ifTrue: [^true].
	self segments
		do: 
			[:segment | 
			line := Jun2dLine from: segment first to: segment last.
			(line lineSegmentContainsPoint: aPoint)
				ifTrue: [^true]].
	intersections := OrderedCollection new.
	line1 := Jun2dLine from: aPoint to: (Jun2dPoint x: aPoint x + self defaultSoFarX y: aPoint y).
	self segments
		do: 
			[:segment | 
			line2 := Jun2dLine from: segment first to: segment last.
			p := line1 lineSegmentIntersectingPointWithLineSegment: line2.
			p notNil
				ifTrue: 
					[index := self pointsWithoutLast findFirst: [:each | ((Jun2dPoint x: each x y: each y)
									distance: p)
									< accuracy].
					index = 0
						ifFalse: 
							[n := index.
							pp1 := p.
							
							[n - 1 < 1
								ifTrue: [n := self pointsWithoutLast size]
								ifFalse: [n := n - 1].
							p1 := self pointsWithoutLast at: n.
							p1 y = aPoint y]
								whileTrue: [pp1 := p1].
							n := index.
							pp2 := p.
							
							[n + 1 > self pointsWithoutLast size
								ifTrue: [n := 1]
								ifFalse: [n := n + 1].
							p2 := self pointsWithoutLast at: n.
							p2 y = aPoint y]
								whileTrue: [pp2 := p2].
							p := pp1 min: pp2.
							(p1 y >= aPoint y and: [p2 y >= aPoint y])
								ifTrue: [p := nil].
							(p1 y <= aPoint y and: [p2 y <= aPoint y])
								ifTrue: [p := nil]]].
			(p notNil and: [(intersections includes: p) not])
				ifTrue: [intersections add: p]].	"Transcript cr; show: aPoint printString , ' -> ' , intersections printString."
	^intersections size odd
]

{ #category : #defaults }
JunForm2dRegion >> defaultAccuracy [
	^Jun2dLine accuracy * 10.0d
]

{ #category : #defaults }
JunForm2dRegion >> defaultSoFarX [
	^29999
]

{ #category : #'initialize-release' }
JunForm2dRegion >> initialize [
	originalPoints := nil.
	boundingBox := nil.
	processingPoints := nil.
	lineSegments := nil
]

{ #category : #accessing }
JunForm2dRegion >> points [
	^originalPoints
]

{ #category : #accessing }
JunForm2dRegion >> points: pointCollection [ 
	| aBox aStream |
	aBox := nil.
	aStream := WriteStream on: (Array new: pointCollection size).
	pointCollection
		do: 
			[:aPoint | 
			aBox isNil
				ifTrue: [aBox := aPoint extent: 1 @ 1]
				ifFalse: [aBox := aBox merge: (aPoint extent: 1 @ 1)].
			aStream nextPut: aPoint].
	(pointCollection isEmpty not and: [(pointCollection first = pointCollection last) not])
		ifTrue: [aStream nextPut: pointCollection first].
	originalPoints := aStream contents.
	boundingBox := aBox.
	processingPoints := nil.
	lineSegments := nil
]

{ #category : #accessing }
JunForm2dRegion >> pointsWithoutLast [
	processingPoints isNil ifTrue: [processingPoints := self points copyFrom: 1 to: originalPoints size - 1].
	^processingPoints
]

{ #category : #accessing }
JunForm2dRegion >> segments [
	lineSegments isNil
		ifTrue: 
			[| stream segment |
			stream := WriteStream on: (Array new: self points size).
			(1 to: self points size - 1)
				with: (2 to: self points size)
				do: 
					[:n1 :n2 | 
					segment := Array with: (self points at: n1)
								with: (self points at: n2).
					stream nextPut: segment].
			lineSegments := stream contents].
	^lineSegments
]

"
Imported by VwImportClass
"
Class {
	#name : #Jun3dTriangle,
	#superclass : #JunTriangle,
	#category : #'Jun-Geometry-Surfaces'
}

{ #category : #copyright }
Jun3dTriangle class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dTriangle class >> example1 [
	"Jun3dTriangle example1."

	| aTriangle |
	aTriangle := Jun3dTriangle 
				on: 1 , 0 , 0
				on: 0 , 1 , 0
				on: 0 , 0 , 1.
	Transcript
		cr;
		show: aTriangle printString.
	Transcript
		cr;
		show: aTriangle storeString.
	Transcript
		cr;
		show: 'area: ' , aTriangle area printString.
	Transcript
		cr;
		show: 'volume: ' , aTriangle volume printString.
	aTriangle asJunOpenGL3dObject showWithUnitAxes.
	^aTriangle
]

{ #category : #examples }
Jun3dTriangle class >> example2 [
	"Jun3dTriangle example2."

	| aTriangle aPlane aTable compoundObject |
	aTriangle := 1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1.
	aPlane := JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , 1 , 1.
	aTable := aTriangle tableDividedBy: aPlane.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: (self privatePlaneBodyBlock value: aPlane).
	compoundObject add: (self privateTableBodyBlock value: aTable).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
	compoundObject showProjectionTable: Jun3dTriangle privateProjectionTable.
	^aTable
]

{ #category : #examples }
Jun3dTriangle class >> example3 [
	"Jun3dTriangle example3."

	| aTriangle aPlane aTable compoundObject |
	aTriangle := 1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1.
	aPlane := JunPlane on: 0 , 0.5 , 0.5 normalVector: 0 , 1 , 1.
	aTable := aTriangle tableDividedBy: aPlane.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: (self privatePlaneBodyBlock value: aPlane).
	compoundObject add: (self privateTableBodyBlock value: aTable).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
	compoundObject showProjectionTable: Jun3dTriangle privateProjectionTable.
	^aTable
]

{ #category : #examples }
Jun3dTriangle class >> example4 [
	"Jun3dTriangle example4."

	| aTriangle aPlane aTable compoundObject |
	aTriangle := 1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1.
	aPlane := JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , -1 , 0.
	aTable := aTriangle tableDividedBy: aPlane.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: (self privatePlaneBodyBlock value: aPlane).
	compoundObject add: (self privateTableBodyBlock value: aTable).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
	compoundObject showProjectionTable: Jun3dTriangle privateProjectionTable.
	^aTable
]

{ #category : #examples }
Jun3dTriangle class >> example5 [
	"Jun3dTriangle example5."

	| aTriangle aPlane aTable compoundObject |
	aTriangle := 1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1.
	aPlane := (JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , -1 , 0) 
				translatedBy: 0.2 , -0.2 , 0.
	aTable := aTriangle tableDividedBy: aPlane.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: (self privatePlaneBodyBlock value: aPlane).
	compoundObject add: (self privateTableBodyBlock value: aTable).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
	compoundObject showProjectionTable: Jun3dTriangle privateProjectionTable.
	^aTable
]

{ #category : #examples }
Jun3dTriangle class >> example6 [
	"Jun3dTriangle example6."

	| aTriangle aPlane aTable compoundObject |
	aTriangle := 1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1.
	aPlane := (JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , -1 , 0) 
				translatedBy: 0.5 , -0.5 , 0.
	aTable := aTriangle tableDividedBy: aPlane.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: (self privatePlaneBodyBlock value: aPlane).
	compoundObject add: (self privateTableBodyBlock value: aTable).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
	compoundObject showProjectionTable: Jun3dTriangle privateProjectionTable.
	^aTable
]

{ #category : #examples }
Jun3dTriangle class >> example7 [
	"Jun3dTriangle example7."

	| aTriangle aPlane aTable compoundObject |
	aTriangle := 1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1.
	aPlane := (JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , -1 , 0) 
				translatedBy: -0.5 , 0.5 , 0.
	aTable := aTriangle tableDividedBy: aPlane.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: (self privatePlaneBodyBlock value: aPlane).
	compoundObject add: (self privateTableBodyBlock value: aTable).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
	compoundObject showProjectionTable: Jun3dTriangle privateProjectionTable.
	^aTable
]

{ #category : #examples }
Jun3dTriangle class >> example8 [
	"Jun3dTriangle example8."

	| aTriangle aPlane aTable compoundObject |
	aTriangle := 1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1.
	aPlane := (JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , -1 , 0) 
				translatedBy: 0.75 , -0.75 , 0.
	aTable := aTriangle tableDividedBy: aPlane.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: (self privatePlaneBodyBlock value: aPlane).
	compoundObject add: (self privateTableBodyBlock value: aTable).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
	compoundObject showProjectionTable: Jun3dTriangle privateProjectionTable.
	^aTable
]

{ #category : #examples }
Jun3dTriangle class >> example9 [
	"Jun3dTriangle example9."

	| aTriangle aPlane aTable compoundObject |
	aTriangle := 1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1.
	aPlane := (JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , -1 , 0) 
				translatedBy: -0.75 , 0.75 , 0.
	aTable := aTriangle tableDividedBy: aPlane.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: (self privatePlaneBodyBlock value: aPlane).
	compoundObject add: (self privateTableBodyBlock value: aTable).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
	compoundObject showProjectionTable: Jun3dTriangle privateProjectionTable.
	^aTable
]

{ #category : #examples }
Jun3dTriangle class >> exampleA [
	"Jun3dTriangle exampleA."

	| aBoolean aTriangle compoundObject projectionTable displayModel anInteger |
	aBoolean := JunSensorUtility shiftDown or: [JunSensorUtility altDown].
	aTriangle := 1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1.
	compoundObject := JunOpenGL3dCompoundObject new.
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #presentation put: #hiddenlinePresentation.
	displayModel := compoundObject showProjectionTable: projectionTable
				in: (100 @ 250 extent: 400 @ 400).
	anInteger := 1.
	(-0.55 to: 0.55 by: 0.01) do: 
			[:n | 
			JunControlUtility do: 
					[| aPlane aTable |
					aPlane := (JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , -1 , 0) 
								translatedBy: n , n negated , 0.
					aTable := aTriangle tableDividedBy: aPlane.
					compoundObject := JunOpenGL3dCompoundObject new.
					compoundObject add: (self privatePlaneBodyBlock value: aPlane).
					compoundObject add: (self privateTableBodyBlock value: aTable).
					compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
					displayModel displayObject: compoundObject.
					displayModel changed: #object.
					aBoolean 
						ifTrue: 
							[| anImage aString aFilename aStream |
							anImage := displayModel asImage.
							aString := anInteger printString.
							8 - aString size timesRepeat: [aString := '0' , aString].
							aFilename := (aString , '.jpg') asFilename.
							aStream := JunJpegImageStream on: aFilename writeStream.
							[Cursor write showWhile: [aStream nextPutImage: anImage]] 
								ensure: [aStream close]]]
				forMilliseconds: 100.
			anInteger := anInteger + 1].
	^displayModel
]

{ #category : #examples }
Jun3dTriangle class >> exampleB [
	"Jun3dTriangle exampleB."

	| aBoolean aTriangle compoundObject projectionTable displayModel anInteger |
	aBoolean := JunSensorUtility shiftDown or: [JunSensorUtility altDown].
	aTriangle := 1 , 0 , 0 triangle: 0 , 1 , 0 and: 0 , 0 , 1.
	compoundObject := JunOpenGL3dCompoundObject new.
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #presentation put: #hiddenlinePresentation.
	displayModel := compoundObject showProjectionTable: projectionTable
				in: (100 @ 250 extent: 400 @ 400).
	anInteger := 1.
	(0 to: 360 by: 2.5) do: 
			[:n | 
			JunControlUtility do: 
					[| aPlane aTable |
					aPlane := (JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , -1 , 0) 
								transform: (Jun3dTransformation rotate: (JunAngle fromDeg: n)
										around: (0 , 0 , 0 to: 1 , 1 , 1)).
					aTable := aTriangle tableDividedBy: aPlane.
					compoundObject := JunOpenGL3dCompoundObject new.
					compoundObject add: (self privatePlaneBodyBlock value: aPlane).
					compoundObject add: (self privateTableBodyBlock value: aTable).
					compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
					displayModel displayObject: compoundObject.
					displayModel changed: #object.
					aBoolean 
						ifTrue: 
							[| anImage aString aFilename aStream |
							anImage := displayModel asImage.
							aString := anInteger printString.
							8 - aString size timesRepeat: [aString := '0' , aString].
							aFilename := (aString , '.jpg') asFilename.
							aStream := JunJpegImageStream on: aFilename writeStream.
							[Cursor write showWhile: [aStream nextPutImage: anImage]] 
								ensure: [aStream close]]]
				forMilliseconds: 100.
			anInteger := anInteger + 1].
	^displayModel
]

{ #category : #examples }
Jun3dTriangle class >> exampleC [
	"Jun3dTriangle exampleC."

	| aBoolean aBox arrayOfTriangles compoundObject projectionTable foreDisplayModel backDisplayModel anArray anInteger |
	aBoolean := JunSensorUtility shiftDown or: [JunSensorUtility altDown].
	aBox := (-0.5 , -0.5 , -0.5 corner: 0.5 , 0.5 , 0.5) 
				translatedBy: 1 / 3 , (1 / 3) , (1 / 3).
	arrayOfTriangles := aBox asArrayOfTriangles.
	compoundObject := JunOpenGL3dCompoundObject new.
	projectionTable := Jun3dTriangle privateProjectionTable.
	foreDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (100 @ 250 extent: 400 @ 400).
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #eyePoint put: (projectionTable at: #eyePoint) negated.
	backDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (520 @ 250 extent: 400 @ 400).
	(anArray := Array with: foreDisplayModel with: backDisplayModel) 
		do: [:each | each closeTogether: anArray].
	anInteger := 1.
	(-0.55 to: 0.55 by: 0.01) do: 
			[:n | 
			JunControlUtility do: 
					[| aPlane |
					aPlane := (JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , -1 , 0) 
								translatedBy: n , n negated , 0.
					compoundObject := JunOpenGL3dCompoundObject new.
					arrayOfTriangles do: 
							[:aTriangle | 
							| aTable subCompoundObject |
							aTable := aTriangle tableDividedBy: aPlane.
							subCompoundObject := JunOpenGL3dCompoundObject new.
							subCompoundObject add: (self privatePlaneBodyBlock value: aPlane).
							subCompoundObject add: (self privateTableBodyBlock value: aTable).
							subCompoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
							compoundObject add: subCompoundObject].
					foreDisplayModel displayObject: compoundObject.
					backDisplayModel displayObject: compoundObject.
					foreDisplayModel changed: #object.
					backDisplayModel changed: #object.
					aBoolean 
						ifTrue: 
							[| foreImage backImage anImage aString aFilename aStream |
							foreImage := foreDisplayModel asImage.
							backImage := backDisplayModel asImage.
							anImage := JunImageUtility 
										imageExtent: (foreImage width + backImage width) 
												@ (foreImage height max: backImage height)
										displayBlock: 
											[:graphicsContext | 
											foreImage displayOn: graphicsContext at: 0 @ 0.
											backImage displayOn: graphicsContext at: foreImage width @ 0].
							aString := anInteger printString.
							8 - aString size timesRepeat: [aString := '0' , aString].
							aFilename := (aString , '.jpg') asFilename.
							aStream := JunJpegImageStream on: aFilename writeStream.
							[Cursor write showWhile: [aStream nextPutImage: anImage]] 
								ensure: [aStream close]]]
				forMilliseconds: 100.
			anInteger := anInteger + 1].
	^anArray
]

{ #category : #examples }
Jun3dTriangle class >> exampleD [
	"Jun3dTriangle exampleD."

	| aBoolean aBox arrayOfTriangles compoundObject projectionTable foreDisplayModel backDisplayModel anArray anInteger |
	aBoolean := JunSensorUtility shiftDown or: [JunSensorUtility altDown].
	aBox := (-0.5 , -0.5 , -0.5 corner: 0.5 , 0.5 , 0.5) 
				translatedBy: 1 / 3 , (1 / 3) , (1 / 3).
	arrayOfTriangles := aBox asArrayOfTriangles.
	compoundObject := JunOpenGL3dCompoundObject new.
	projectionTable := Jun3dTriangle privateProjectionTable.
	foreDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (100 @ 250 extent: 400 @ 400).
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #eyePoint put: (projectionTable at: #eyePoint) negated.
	backDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (520 @ 250 extent: 400 @ 400).
	(anArray := Array with: foreDisplayModel with: backDisplayModel) 
		do: [:each | each closeTogether: anArray].
	anInteger := 1.
	(0 to: 360 by: 2.5) do: 
			[:n | 
			JunControlUtility do: 
					[| aPlane |
					aPlane := (JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , -1 , 0) 
								transform: (Jun3dTransformation rotate: (JunAngle fromDeg: n)
										around: (0 , 0 , 0 to: 1 , 1 , 1)).
					compoundObject := JunOpenGL3dCompoundObject new.
					arrayOfTriangles do: 
							[:aTriangle | 
							| aTable subCompoundObject |
							aTable := aTriangle tableDividedBy: aPlane.
							subCompoundObject := JunOpenGL3dCompoundObject new.
							subCompoundObject add: (self privatePlaneBodyBlock value: aPlane).
							subCompoundObject add: (self privateTableBodyBlock value: aTable).
							subCompoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
							compoundObject add: subCompoundObject].
					foreDisplayModel displayObject: compoundObject.
					backDisplayModel displayObject: compoundObject.
					foreDisplayModel changed: #object.
					backDisplayModel changed: #object.
					aBoolean 
						ifTrue: 
							[| foreImage backImage anImage aString aFilename aStream |
							foreImage := foreDisplayModel asImage.
							backImage := backDisplayModel asImage.
							anImage := JunImageUtility 
										imageExtent: (foreImage width + backImage width) 
												@ (foreImage height max: backImage height)
										displayBlock: 
											[:graphicsContext | 
											foreImage displayOn: graphicsContext at: 0 @ 0.
											backImage displayOn: graphicsContext at: foreImage width @ 0].
							aString := anInteger printString.
							8 - aString size timesRepeat: [aString := '0' , aString].
							aFilename := (aString , '.jpg') asFilename.
							aStream := JunJpegImageStream on: aFilename writeStream.
							[Cursor write showWhile: [aStream nextPutImage: anImage]] 
								ensure: [aStream close]]]
				forMilliseconds: 100.
			anInteger := anInteger + 1].
	^anArray
]

{ #category : #examples }
Jun3dTriangle class >> exampleE [
	"Jun3dTriangle exampleE."

	| aBoolean aBox arrayOfTriangles compoundObject projectionTable foreDisplayModel backDisplayModel anArray anInteger |
	aBoolean := JunSensorUtility shiftDown or: [JunSensorUtility altDown].
	aBox := (-0.5 , -0.5 , -0.5 corner: 0.5 , 0.5 , 0.5) 
				translatedBy: 1 / 3 , (1 / 3) , (1 / 3).
	arrayOfTriangles := aBox asArrayOfTriangles.
	compoundObject := JunOpenGL3dCompoundObject new.
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #presentation put: #hiddenlinePresentation.
	foreDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (100 @ 250 extent: 400 @ 400).
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #eyePoint put: (projectionTable at: #eyePoint) negated.
	projectionTable at: #presentation put: #hiddenlinePresentation.
	backDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (520 @ 250 extent: 400 @ 400).
	(anArray := Array with: foreDisplayModel with: backDisplayModel) 
		do: [:each | each closeTogether: anArray].
	anInteger := 1.
	(0 to: 360 by: 2.5) do: 
			[:n | 
			| aPlane |
			aPlane := (JunPlane on: 1 / 3 , (1 / 3) , (1 / 3) normalVector: 1 , -1 , 0) 
						transform: (Jun3dTransformation rotate: (JunAngle fromDeg: n)
								around: (0 , 0 , 0 to: 1 , 1 , 1)).
			compoundObject := JunOpenGL3dCompoundObject new.
			arrayOfTriangles do: 
					[:aTriangle | 
					| aTable subCompoundObject |
					aTable := aTriangle tableDividedBy: aPlane.
					subCompoundObject := JunOpenGL3dCompoundObject new.
					subCompoundObject add: (self privatePlaneBodyBlock value: aPlane).
					subCompoundObject add: (self privateTableBodyBlock value: aTable).
					subCompoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
					compoundObject add: subCompoundObject].
			foreDisplayModel displayObject: compoundObject.
			backDisplayModel displayObject: compoundObject.
			foreDisplayModel changed: #object.
			backDisplayModel changed: #object.
			aBoolean 
				ifTrue: 
					[| foreImage backImage anImage aString aFilename aStream |
					foreImage := foreDisplayModel asImage.
					backImage := backDisplayModel asImage.
					anImage := JunImageUtility 
								imageExtent: (foreImage width + backImage width) 
										@ (foreImage height max: backImage height)
								displayBlock: 
									[:graphicsContext | 
									foreImage displayOn: graphicsContext at: 0 @ 0.
									backImage displayOn: graphicsContext at: foreImage width @ 0].
					aString := anInteger printString.
					8 - aString size timesRepeat: [aString := '0' , aString].
					aFilename := (aString , '.jpg') asFilename.
					aStream := JunJpegImageStream on: aFilename writeStream.
					[Cursor write showWhile: [aStream nextPutImage: anImage]] 
						ensure: [aStream close]]
				ifFalse: ['do nothing' yourself].
			anInteger := anInteger + 1].
	^anArray
]

{ #category : #examples }
Jun3dTriangle class >> exampleF [
	"Jun3dTriangle exampleF."

	| aBoolean aBox arrayOfTriangles compoundObject projectionTable foreDisplayModel backDisplayModel lineDisplayModel sectDisplayModel anArray anInteger |
	aBoolean := JunSensorUtility shiftDown or: [JunSensorUtility altDown].
	aBox := 0 , 0 , 0 corner: 1 , 1 , 1.
	arrayOfTriangles := aBox asArrayOfTriangles.
	compoundObject := JunOpenGL3dCompoundObject new.
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #shading put: #smoothShading.
	foreDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (100 @ 250 extent: 300 @ 300).
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #eyePoint put: (projectionTable at: #eyePoint) negated.
	projectionTable at: #shading put: #smoothShading.
	backDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (420 @ 250 extent: 300 @ 300).
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #shading put: #smoothShading.
	lineDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (100 @ 590 extent: 300 @ 300).
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #shading put: #smoothShading.
	sectDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (420 @ 590 extent: 300 @ 300).
	foreDisplayModel displayLightsAllOff.
	backDisplayModel displayLightsAllOff.
	lineDisplayModel displayLightsAllOff.
	sectDisplayModel displayLightsAllOff.
	foreDisplayModel getWindow label: 'Fore'.
	backDisplayModel getWindow label: 'Back'.
	lineDisplayModel getWindow label: 'Line'.
	sectDisplayModel getWindow label: 'Sect'.
	(anArray := Array 
				with: foreDisplayModel
				with: backDisplayModel
				with: lineDisplayModel
				with: sectDisplayModel) do: [:each | each closeTogether: anArray].
	anInteger := 1.
	(0 to: 180 by: 2) do: 
			[:n | 
			JunControlUtility do: 
					[| aCollection aPlane |
					aCollection := OrderedCollection new.
					aPlane := (JunPlane on: 0.5 , 0.5 , 0.5 normalVector: 1 , -1 , 0) 
								transform: (Jun3dTransformation rotate: (JunAngle fromDeg: n)
										around: (0 , 0 , 0 to: 1 , 1 , 1)).
					compoundObject := JunOpenGL3dCompoundObject new.
					arrayOfTriangles do: 
							[:aTriangle | 
							| aTable subCompoundObject |
							aTable := aTriangle tableDividedBy: aPlane.
							subCompoundObject := JunOpenGL3dCompoundObject new.
							subCompoundObject add: (self privatePlaneBodyBlock value: aPlane).
							subCompoundObject add: (self privateColorBodyBlock value: aTable).
							subCompoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
							compoundObject add: subCompoundObject.
							aCollection addAll: (aTable at: #points)].
					foreDisplayModel displayObject: compoundObject.
					backDisplayModel displayObject: compoundObject.
					lineDisplayModel 
						displayObject: (self privateLineBodyBlock value: aCollection).
					sectDisplayModel 
						displayObject: (self privateSectBodyBlock value: aCollection).
					foreDisplayModel changed: #object.
					backDisplayModel changed: #object.
					lineDisplayModel changed: #object.
					sectDisplayModel changed: #object.
					aBoolean 
						ifTrue: 
							[| foreImage backImage lineImage sectImage anImage aString aFilename aStream |
							foreImage := foreDisplayModel asImage.
							backImage := backDisplayModel asImage.
							lineImage := lineDisplayModel asImage.
							sectImage := sectDisplayModel asImage.
							anImage := JunImageUtility 
										imageExtent: (foreImage width + backImage width) 
												@ (foreImage height + lineImage height)
										displayBlock: 
											[:graphicsContext | 
											foreImage displayOn: graphicsContext at: 0 @ 0.
											backImage displayOn: graphicsContext at: foreImage width @ 0.
											lineImage displayOn: graphicsContext at: 0 @ foreImage height.
											sectImage displayOn: graphicsContext at: foreImage width @ foreImage height].
							aString := anInteger printString.
							8 - aString size timesRepeat: [aString := '0' , aString].
							aFilename := (aString , '.jpg') asFilename.
							aStream := JunJpegImageStream on: aFilename writeStream.
							[Cursor write showWhile: [aStream nextPutImage: anImage]] 
								ensure: [aStream close]]]
				forMilliseconds: 100.
			anInteger := anInteger + 1].
	^anArray
]

{ #category : #examples }
Jun3dTriangle class >> exampleG [
	"Jun3dTriangle exampleG."

	| aBoolean aBox arrayOfTriangles compoundObject projectionTable foreDisplayModel backDisplayModel lineDisplayModel sectDisplayModel anArray anInteger |
	aBoolean := JunSensorUtility shiftDown or: [JunSensorUtility altDown].
	aBox := 0 , 0 , 0 corner: 1 , 1 , 1.
	arrayOfTriangles := aBox asArrayOfTriangles.
	compoundObject := JunOpenGL3dCompoundObject new.
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #shading put: #smoothShading.
	foreDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (100 @ 250 extent: 300 @ 300).
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #eyePoint put: (projectionTable at: #eyePoint) negated.
	projectionTable at: #shading put: #smoothShading.
	backDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (420 @ 250 extent: 300 @ 300).
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #shading put: #smoothShading.
	lineDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (100 @ 590 extent: 300 @ 300).
	projectionTable := Jun3dTriangle privateProjectionTable.
	projectionTable at: #shading put: #smoothShading.
	projectionTable at: #sightPoint put: 0.3 , 0.3 , 0.3.
	projectionTable at: #eyePoint put: 100 , -100 , 30.
	projectionTable at: #upVector put: 0 , 0 , 1.
	sectDisplayModel := compoundObject showProjectionTable: projectionTable
				in: (420 @ 590 extent: 300 @ 300).
	foreDisplayModel displayLightsAllOff.
	backDisplayModel displayLightsAllOff.
	lineDisplayModel displayLightsAllOff.
	sectDisplayModel displayLightsAllOff.
	foreDisplayModel getWindow label: 'Fore'.
	backDisplayModel getWindow label: 'Back'.
	lineDisplayModel getWindow label: 'Line'.
	sectDisplayModel getWindow label: 'Sect'.
	(anArray := Array 
				with: foreDisplayModel
				with: backDisplayModel
				with: lineDisplayModel
				with: sectDisplayModel) do: [:each | each closeTogether: anArray].
	anInteger := 1.
	(-0.55 to: 0.55 by: 0.01) do: 
			[:n | 
			JunControlUtility do: 
					[| aCollection aPlane |
					aCollection := OrderedCollection new.
					aPlane := (JunPlane on: 0.5 , 0.5 , 0.5 normalVector: 1 , -1 , 0) 
								translatedBy: n , n negated , 0.
					compoundObject := JunOpenGL3dCompoundObject new.
					arrayOfTriangles do: 
							[:aTriangle | 
							| aTable subCompoundObject |
							aTable := aTriangle tableDividedBy: aPlane.
							subCompoundObject := JunOpenGL3dCompoundObject new.
							subCompoundObject add: (self privatePlaneBodyBlock value: aPlane).
							subCompoundObject add: (self privateColorBodyBlock value: aTable).
							subCompoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5).
							compoundObject add: subCompoundObject.
							aCollection addAll: (aTable at: #points)].
					foreDisplayModel displayObject: compoundObject.
					backDisplayModel displayObject: compoundObject.
					lineDisplayModel 
						displayObject: (self privateLineBodyBlock value: aCollection).
					sectDisplayModel 
						displayObject: (self privateSectBodyBlock value: aCollection).
					foreDisplayModel changed: #object.
					backDisplayModel changed: #object.
					lineDisplayModel changed: #object.
					sectDisplayModel changed: #object.
					aBoolean 
						ifTrue: 
							[| foreImage backImage lineImage sectImage anImage aString aFilename aStream |
							foreImage := foreDisplayModel asImage.
							backImage := backDisplayModel asImage.
							lineImage := lineDisplayModel asImage.
							sectImage := sectDisplayModel asImage.
							anImage := JunImageUtility 
										imageExtent: (foreImage width + backImage width) 
												@ (foreImage height + lineImage height)
										displayBlock: 
											[:graphicsContext | 
											foreImage displayOn: graphicsContext at: 0 @ 0.
											backImage displayOn: graphicsContext at: foreImage width @ 0.
											lineImage displayOn: graphicsContext at: 0 @ foreImage height.
											sectImage displayOn: graphicsContext at: foreImage width @ foreImage height].
							aString := anInteger printString.
							8 - aString size timesRepeat: [aString := '0' , aString].
							aFilename := (aString , '.jpg') asFilename.
							aStream := JunJpegImageStream on: aFilename writeStream.
							[Cursor write showWhile: [aStream nextPutImage: anImage]] 
								ensure: [aStream close]]]
				forMilliseconds: 100.
			anInteger := anInteger + 1].
	^anArray
]

{ #category : #examples }
Jun3dTriangle class >> exampleH [
	"Jun3dTriangle exampleH."

	| aTriangle compoundObject |
	aTriangle := Jun3dTriangle 
				on: 1 , 0 , 0
				on: 0 , 1 , 0
				on: 0 , 0 , 1.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: aTriangle asJunOpenGL3dObject.
	aTriangle threePlanes 
		do: [:aPlane | compoundObject add: aPlane asJunOpenGL3dObject].
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.2).
	compoundObject show.
	^aTriangle
]

{ #category : #'instance creation' }
Jun3dTriangle class >> on: centerPoint normalVector: aVector [ 
	"(Jun3dTriangle
		on: (0.33333333333333d , 0.33333333333333d , 0.33333333333333d)
		normalVector: 1 , 1 , 1) asJunOpenGL3dObject showWithAxes."

	^self 
		on: centerPoint
		normalVector: aVector
		distance: 1
]

{ #category : #'instance creation' }
Jun3dTriangle class >> on: centerPoint normalVector: aVector distance: aNumber [ 
	"(Jun3dTriangle
		on: (0.33333333333333d , 0.33333333333333d , 0.33333333333333d)
		normalVector: 1 , 0 , 0
		distance: 0.81649658092773d) asJunOpenGL3dObject showWithUnitAxes."

	"(Jun3dTriangle
		on: (0.33333333333333d , 0.33333333333333d , 0.33333333333333d)
		normalVector: 0 , 1 , 0
		distance: 0.81649658092773d) asJunOpenGL3dObject showWithUnitAxes."

	"(Jun3dTriangle
		on: (0.33333333333333d , 0.33333333333333d , 0.33333333333333d)
		normalVector: 0 , 0 , 1
		distance: 0.81649658092773d) asJunOpenGL3dObject showWithUnitAxes."

	"(Jun3dTriangle
		on: (0.33333333333333d , 0.33333333333333d , 0.33333333333333d)
		normalVector: 1 , 1 , 1
		distance: 0.81649658092773d) asJunOpenGL3dObject showWithUnitAxes."

	^self 
		on: centerPoint
		normalVector: aVector
		distance: aNumber
		rightVector: 1 , 0 , 0
]

{ #category : #'instance creation' }
Jun3dTriangle class >> on: centerPoint normalVector: normalVector distance: aNumber rightVector: rightVector [ 
	"(Jun3dTriangle
		on: (0.33333333333333d , 0.33333333333333d , 0.33333333333333d)
		normalVector: 1 , 1 , 1
		distance: 0.81649658092773d
		rightVector: 1 , 0 , 0) asJunOpenGL3dObject showWithUnitAxes."

	| aPlane aroundLine aLine aPoint |
	aPlane := JunPlane on: centerPoint normalVector: normalVector.
	aroundLine := centerPoint to: centerPoint + normalVector.
	aLine := aroundLine translatedBy: rightVector.
	aPoint := aPlane intersectingPointWithLine: aLine.
	((centerPoint x - aPoint x) abs < self accuracy and: 
			[(centerPoint y - aPoint y) abs < self accuracy 
				and: [(centerPoint z - aPoint z) abs < self accuracy]]) 
		ifTrue: 
			[aPoint := ((Array 
						with: aPlane p1
						with: aPlane p2
						with: aPlane p3) collect: [:p | (p distance: centerPoint) -> p]) 
						asSortedCollection last 
						value].
	aLine := (centerPoint to: aPoint) normalized.
	aPoint := aLine atT: aNumber.
	^self 
		on: aPoint
		on: (aPoint transform: (Jun3dTransformation rotate: (JunAngle fromDeg: 120)
						around: aroundLine))
		on: (aPoint transform: (Jun3dTransformation rotate: (JunAngle fromDeg: 240)
						around: aroundLine))
]

{ #category : #'instance creation' }
Jun3dTriangle class >> on: centerPoint vertical: aLine [ 
	"(Jun3dTriangle
		on: (0.33333333333333d , 0.33333333333333d , 0.33333333333333d)
		vertical: (0 , 0 , 0 to: 1 , 1 , 1)) asJunOpenGL3dObject showWithAxes."

	^self 
		on: centerPoint
		vertical: aLine
		distance: 1
]

{ #category : #'instance creation' }
Jun3dTriangle class >> on: centerPoint vertical: aLine distance: aNumber [ 
	"(Jun3dTriangle
		on: (0.33333333333333d , 0.33333333333333d , 0.33333333333333d)
		vertical: (0 , 0 , 0 to: 1 , 1 , 1)
		distance: 0.81649658092773d) asJunOpenGL3dObject showWithAxes."

	^self 
		on: centerPoint
		normalVector: aLine normalVector
		distance: aNumber
]

{ #category : #private }
Jun3dTriangle class >> privateColorBodyBlock [
	| aBlock arrayOfPoints arrayOfColors aPolygon |
	aBlock := 
			[:aTable | 
			| compoundObject |
			compoundObject := JunOpenGL3dCompoundObject new.
			(aTable at: #positives) do: 
					[:aTriangle | 
					arrayOfPoints := Array 
								with: aTriangle first
								with: aTriangle second
								with: aTriangle third.
					arrayOfColors := arrayOfPoints collect: 
									[:aPoint | 
									ColorValue 
										red: aPoint x
										green: aPoint y
										blue: aPoint z].
					aPolygon := JunOpenGL3dPolygon vertexes: arrayOfPoints
								colors: arrayOfColors.
					compoundObject add: aPolygon].
			(aTable at: #zeros) 
				do: [:each | compoundObject add: (each asJunOpenGL3dObjectColor: ColorValue gray)].
			(aTable at: #negatives) do: 
					[:aTriangle | 
					arrayOfPoints := Array 
								with: aTriangle first
								with: aTriangle second
								with: aTriangle third.
					arrayOfColors := arrayOfPoints collect: 
									[:aPoint | 
									ColorValue 
										red: aPoint x
										green: aPoint y
										blue: aPoint z].
					aPolygon := JunOpenGL3dPolygon vertexes: arrayOfPoints
								colors: arrayOfColors.
					compoundObject add: aPolygon].
			(aTable at: #points) 
				do: [:each | compoundObject add: (each asJunOpenGL3dObjectColor: ColorValue black)].
			compoundObject yourself].
	^aBlock
]

{ #category : #private }
Jun3dTriangle class >> privateLineBodyBlock [
	| aBlock |
	aBlock := 
			[:intersectingPoints | 
			| arrayOfPoints compoundObject |
			compoundObject := JunOpenGL3dCompoundObject new.
			intersectingPoints isEmpty 
				ifFalse: 
					[arrayOfPoints := (JunPointsOnPlane points: intersectingPoints asArray) 
								sortedPoints.
					compoundObject 
						add: ((Jun3dPolyline points: arrayOfPoints) 
								asJunOpenGL3dObjectColor: ColorValue black) yourself.
					arrayOfPoints with: (0 to: arrayOfPoints size - 1)
						do: 
							[:aPoint :aNumber | 
							| colorValue |
							colorValue := ColorValue 
										hue: aNumber / arrayOfPoints size
										saturation: 1
										brightness: 1.
							compoundObject add: (aPoint asJunOpenGL3dObjectColor: colorValue)]].
			compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5)].
	^aBlock
]

{ #category : #private }
Jun3dTriangle class >> privatePlaneBodyBlock [
	"Jun3dTriangle exampleCompoundObjectBlock."

	| aBlock |
	aBlock := 
			[:aPlane | 
			(JunOpenGL3dPolygon 
				vertexes: (Jun3dCircle 
						center: aPlane p1
						radius: 1
						upVector: aPlane normalVector) trackPoints)
				paint: ColorValue magenta;
				halftone: 0.5;
				yourself].
	^aBlock
]

{ #category : #private }
Jun3dTriangle class >> privateProjectionTable [
	"Jun3dTriangle privateProjectionTable."

	^(Dictionary new)
		add: #viewFactor -> 10;
		add: #presentation -> #solidPresentation;
		add: #eyePoint -> (14.477702891463d , 9.1335346899163d , 5.5654885728598d);
		add: #upVector 
					-> (-0.26322225132661d , -0.1622475126126d , 0.95099410674177d);
		add: #sightPoint -> (0.0d , 0.0d , 0.0d);
		add: #shading -> #smoothShading;
		add: #zoomHeight -> 3.5d;
		yourself
]

{ #category : #private }
Jun3dTriangle class >> privateSectBodyBlock [
	| aBlock |
	aBlock := 
			[:intersectingPoints | 
			| arrayOfPoints compoundObject arrayOfColors aPolygon aPolyline |
			compoundObject := JunOpenGL3dCompoundObject new.
			intersectingPoints isEmpty 
				ifTrue: [JunOpenGL3dCompoundObject new]
				ifFalse: 
					[arrayOfPoints := (JunPointsOnPlane points: intersectingPoints asArray) 
								sortedPoints.
					compoundObject := JunOpenGL3dCompoundObject new.
					arrayOfColors := arrayOfPoints collect: 
									[:aPoint | 
									ColorValue 
										red: aPoint x
										green: aPoint y
										blue: aPoint z].
					arrayOfPoints size > 2 
						ifTrue: 
							[aPolygon := JunOpenGL3dPolygon vertexes: arrayOfPoints
										colors: arrayOfColors.
							compoundObject add: aPolygon]
						ifFalse: 
							[aPolyline := JunOpenGL3dPolyline vertexes: arrayOfPoints
										colors: arrayOfColors.
							compoundObject add: aPolyline]].
			compoundObject add: (JunOpenGL3dObject axes scaledBy: 1.5)].
	^aBlock
]

{ #category : #private }
Jun3dTriangle class >> privateTableBodyBlock [
	| aBlock |
	aBlock := 
			[:aTable | 
			| compoundObject |
			compoundObject := JunOpenGL3dCompoundObject new.
			(aTable at: #positives) 
				do: [:each | compoundObject add: (each asJunOpenGL3dObjectColor: ColorValue cyan)].
			(aTable at: #zeros) 
				do: [:each | compoundObject add: (each asJunOpenGL3dObjectColor: ColorValue gray)].
			(aTable at: #negatives) 
				do: [:each | compoundObject add: (each asJunOpenGL3dObjectColor: ColorValue yellow)].
			(aTable at: #points) 
				do: [:each | compoundObject add: (each asJunOpenGL3dObjectColor: ColorValue black)].
			compoundObject yourself].
	^aBlock
]

{ #category : #copyright }
Jun3dTriangle class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun3dTriangle class >> version [
	^'799'
]

{ #category : #functions }
Jun3dTriangle >> areaWithSign [
	"((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) areaWithSign."

	"((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) reversed areaWithSign."

	^self areaWithSignFromPoint: 0 , 0 
				, ((self p1 z max: (self p2 z max: self p3 z)) + 1)
]

{ #category : #functions }
Jun3dTriangle >> areaWithSignFromPoint: aPoint [ 
	"(Jun3dTriangle on: (0 , 0 , 0) on: (0 , 1 , 0) on: (1 , 1 , 1)) 
		areaWithSignFromPoint: 0 , 0 , 10."

	"(Jun3dTriangle on: (0 , 0 , 0) on: (0 , 1 , 0) on: (1 , 1 , 1)) reversed 
		areaWithSignFromPoint: 0 , 0 , 10."

	| areaWithSign |
	areaWithSign := self area * (self asPlane whichSide: aPoint).
	^areaWithSign
]

{ #category : #functions }
Jun3dTriangle >> centerOfGravity [
	"((0 , 0 , 0) triangle: (0 , 1 , 0) and: (1 , 1 , 1)) centerOfGravity."

	^self pointClass 
		x: (self p1 x + self p2 x + self p3 x) / 3
		y: (self p1 y + self p2 y + self p3 y) / 3
		z: (self p1 z + self p2 z + self p3 z) / 3
]

{ #category : #testing }
Jun3dTriangle >> containsPoint: aPoint [ 
	"((1 , 0 , 0) triangle: (0 , 1 , 0) and: (0 , 0 , 1)) containsPoint: ((1/3) , (1/3) , (1/3))."

	self threePlanes 
		do: [:aPlane | (aPoint whichSideOf: aPlane) < 0 ifTrue: [^false]].
	^(self asPlane distanceFromPoint: aPoint) < self class accuracy
]

{ #category : #testing }
Jun3dTriangle >> is3d [
	^true
]

{ #category : #functions }
Jun3dTriangle >> normalUnitVector [
	^self asPlane normalUnitVector
]

{ #category : #functions }
Jun3dTriangle >> normalVector [
	^self asPlane normalVector
]

{ #category : #dividing }
Jun3dTriangle >> tableDividedBy: aPlane [ 
	| aTable signArray pointArray trianglePlane hasPositive hasNegative hasZero |
	aTable := Dictionary new.
	aTable at: #positives put: (OrderedCollection new: 3).
	aTable at: #negatives put: (OrderedCollection new: 3).
	aTable at: #zeros put: (OrderedCollection new: 3).
	aTable at: #points put: (OrderedCollection new: 3).
	pointArray := Array 
				with: self p1
				with: self p2
				with: self p3.
	signArray := pointArray collect: [:aPoint | aPoint whichSideOf: aPlane].
	trianglePlane := self asPlane.
	hasPositive := signArray includes: 1.
	hasNegative := signArray includes: -1.
	hasZero := signArray includes: 0.
	hasZero 
		ifTrue: 
			[(hasPositive not and: [hasNegative not]) 
				ifTrue: 
					[(aTable at: #zeros) add: self.
					pointArray do: [:aPoint | (aTable at: #points) add: aPoint]]
				ifFalse: 
					[(hasPositive and: [hasNegative]) 
						ifTrue: 
							[| fromPoint toPoints intersectingPoint aLine aTriangle |
							toPoints := OrderedCollection new: 2.
							signArray with: pointArray
								do: 
									[:sign :aPoint | 
									sign = 0 
										ifTrue: 
											[(aTable at: #points) add: aPoint.
											fromPoint := aPoint]
										ifFalse: [toPoints add: aPoint]].
							aLine := toPoints first to: toPoints last.
							intersectingPoint := aPlane intersectingPointWithLine: aLine.
							intersectingPoint notNil 
								ifTrue: 
									[(aTable at: #points) add: intersectingPoint.
									aTriangle := self triangleClass 
												on: fromPoint
												on: intersectingPoint
												on: toPoints first.
									aTriangle notNil 
										ifTrue: 
											[(fromPoint + aTriangle normalVector whichSideOf: trianglePlane) < 0 
												ifTrue: [aTriangle := aTriangle reversed].
											(signArray at: (pointArray indexOf: toPoints first)) > 0 
												ifTrue: [(aTable at: #positives) add: aTriangle]
												ifFalse: [(aTable at: #negatives) add: aTriangle]].
									aTriangle := self triangleClass 
												on: fromPoint
												on: intersectingPoint
												on: toPoints last.
									aTriangle notNil 
										ifTrue: 
											[(fromPoint + aTriangle normalVector whichSideOf: trianglePlane) < 0 
												ifTrue: [aTriangle := aTriangle reversed].
											(signArray at: (pointArray indexOf: toPoints last)) > 0 
												ifTrue: [(aTable at: #positives) add: aTriangle]
												ifFalse: [(aTable at: #negatives) add: aTriangle]]]
								ifFalse: ['do nothing' yourself]]
						ifFalse: 
							[hasPositive ifTrue: [(aTable at: #positives) add: self].
							hasNegative ifTrue: [(aTable at: #negatives) add: self].
							signArray with: pointArray
								do: [:sign :aPoint | sign = 0 ifTrue: [(aTable at: #points) add: aPoint]]]]]
		ifFalse: 
			[(hasPositive and: [hasNegative]) 
				ifTrue: 
					[| positiveCollection negativeCollection fromPoint fromSign firstToPoint lastToPoint aLine firstIntersectingPoint lastIntersectingPoint aTriangle anotherTriangle |
					positiveCollection := OrderedCollection new: 2.
					negativeCollection := OrderedCollection new: 2.
					signArray with: pointArray
						do: 
							[:sign :aPoint | 
							sign > 0 
								ifTrue: [positiveCollection add: aPoint]
								ifFalse: [negativeCollection add: aPoint]].
					positiveCollection size = 1 
						ifTrue: 
							[fromPoint := positiveCollection first.
							fromSign := 1.
							firstToPoint := negativeCollection first.
							lastToPoint := negativeCollection last]
						ifFalse: 
							[fromPoint := negativeCollection first.
							fromSign := -1.
							firstToPoint := positiveCollection first.
							lastToPoint := positiveCollection last].
					aLine := fromPoint to: firstToPoint.
					firstIntersectingPoint := aPlane intersectingPointWithLine: aLine.
					aLine := fromPoint to: lastToPoint.
					lastIntersectingPoint := aPlane intersectingPointWithLine: aLine.
					(firstIntersectingPoint notNil and: [lastIntersectingPoint notNil]) 
						ifTrue: 
							[(aTable at: #points) add: firstIntersectingPoint.
							(aTable at: #points) add: lastIntersectingPoint.
							aTriangle := self triangleClass 
										on: fromPoint
										on: firstIntersectingPoint
										on: lastIntersectingPoint.
							aTriangle notNil 
								ifTrue: 
									[(fromPoint + aTriangle normalVector whichSideOf: trianglePlane) < 0 
										ifTrue: [aTriangle := aTriangle reversed].
									fromSign > 0 
										ifTrue: [(aTable at: #positives) add: aTriangle]
										ifFalse: [(aTable at: #negatives) add: aTriangle]].
							aTriangle := self triangleClass 
										on: firstToPoint
										on: firstIntersectingPoint
										on: lastToPoint.
							anotherTriangle := self triangleClass 
										on: firstToPoint
										on: lastIntersectingPoint
										on: lastToPoint.
							(aTriangle notNil and: [anotherTriangle notNil]) 
								ifTrue: 
									[aTriangle area <= anotherTriangle area 
										ifTrue: 
											[anotherTriangle := self triangleClass 
														on: firstIntersectingPoint
														on: lastToPoint
														on: lastIntersectingPoint]
										ifFalse: 
											[aTriangle := self triangleClass 
														on: firstIntersectingPoint
														on: firstToPoint
														on: lastIntersectingPoint]].
							aTriangle notNil 
								ifTrue: 
									[(aTriangle p1 + aTriangle normalVector whichSideOf: trianglePlane) < 0 
										ifTrue: [aTriangle := aTriangle reversed].
									fromSign > 0 
										ifTrue: [(aTable at: #negatives) add: aTriangle]
										ifFalse: [(aTable at: #positives) add: aTriangle]].
							anotherTriangle notNil 
								ifTrue: 
									[(anotherTriangle p1 + anotherTriangle normalVector 
										whichSideOf: trianglePlane) < 0 
										ifTrue: [anotherTriangle := anotherTriangle reversed].
									fromSign > 0 
										ifTrue: [(aTable at: #negatives) add: anotherTriangle]
										ifFalse: [(aTable at: #positives) add: anotherTriangle]]]
						ifFalse: 
							[fromSign > 0 
								ifTrue: [(aTable at: #negatives) add: self]
								ifFalse: [(aTable at: #positives) add: self]]]
				ifFalse: 
					[hasPositive ifTrue: [(aTable at: #positives) add: self].
					hasNegative ifTrue: [(aTable at: #negatives) add: self]]].
	^aTable
]

{ #category : #functions }
Jun3dTriangle >> threePlanes [
	| threePlanes aLine aPoint aPlane |
	threePlanes := Array new: 3.
	aLine := self p1 to: self p2.
	aPoint := aLine nearestPointFromPoint: self p3.
	aPlane := aPoint plane: (aPoint to: self p3) normalVector.
	threePlanes at: 1 put: aPlane.
	aLine := self p1 to: self p3.
	aPoint := aLine nearestPointFromPoint: self p2.
	aPlane := aPoint plane: (aPoint to: self p2) normalVector.
	threePlanes at: 2 put: aPlane.
	aLine := self p2 to: self p3.
	aPoint := aLine nearestPointFromPoint: self p1.
	aPlane := aPoint plane: (aPoint to: self p1) normalVector.
	threePlanes at: 3 put: aPlane.
	^threePlanes
]

"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLDisplayModel,
	#superclass : #JunApplicationModel,
	#instVars : [
		'displayObject',
		'displayLights',
		'displayProjector',
		'selectedObjects',
		'pushButtons',
		'dollyButton',
		'defaultProjectionTable',
		'superimposeBlock',
		'preferenceTable'
	],
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLDisplayModel class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'lisp support' }
JunOpenGLDisplayModel class >> displayLightsFromTable: aTable for: aModel [ 
	| aList |
	aList := aTable at: #displayLights ifAbsent: [^aModel].
	aModel 
		displayLights: (aList 
				collect: [:list | JunOpenGLDisplayLight fromLispList: list]) asArray.
	^aModel
]

{ #category : #'instance creation' }
JunOpenGLDisplayModel class >> displayObject: a3dObject [ 
	"JunOpenGLDisplayModel displayObject: JunOpenGL3dObject cube."

	^(self new)
		displayObject: a3dObject;
		yourself
]

{ #category : #'lisp support' }
JunOpenGLDisplayModel class >> displayObjectFromTable: aTable for: aModel [ 
	| aList |
	aList := aTable at: #displayObject ifAbsent: [^aModel].
	aModel displayObject: (JunOpenGL3dObject objectFromLispList: aList).
	^aModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> example [
	"JunOpenGLDisplayModel example."

	| displayModel |
	displayModel := JunOpenGLDisplayModel new.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> example0 [
	"JunOpenGLDisplayModel example0."

	| fileName aStream aBody aBox anEnclosure displayModel |
	fileName := JunUniFileModel requestFileNameWithPattern: '*.lst'.
	fileName isNil ifTrue: [^nil].
	fileName isDirectory ifTrue: [^nil].
	aStream := fileName readStream.
	[Cursor read showWhile: [aBody := JunOpenGL3dObject loadFrom: aStream]]
		ensure: [aStream close].
	aBox := aBody boundingBox.
	"anEnclosure := JunOpenGL3dObject origin: aBox origin corner: aBox corner."
	anEnclosure := JunOpenGL3dObject
				globe: 15
				radius: (aBox center distance: aBox origin)
				center: aBox center.
	anEnclosure paint: (ColorValue green blendWith: ColorValue white).
	anEnclosure do: [:each | each stipple: (JunOpenGLStipple halftone: 0.5)].
	aBody isCompound
		ifTrue: [aBody add: anEnclosure]
		ifFalse: [aBody := JunOpenGL3dCompoundObject with: aBody with: anEnclosure].
	displayModel := JunOpenGLDisplayModel new.
	displayModel displayObject: aBody.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> example1 [
	"JunOpenGLDisplayModel example1."

	| anAxes displayModel |
	anAxes := JunOpenGL3dObject xyzArrows.
	anAxes := anAxes transform: (Jun3dTransformation scale: 2.0).
	displayModel := JunOpenGLDisplayModel displayObject: anAxes.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> example2 [
	"JunOpenGLDisplayModel example2."

	| aCube displayModel |
	aCube := JunOpenGL3dObject cube.
	aCube paint: (ColorValue 
				red: 255 / 255
				green: 235 / 255
				blue: 215 / 255).
	displayModel := JunOpenGLDisplayModel displayObject: aCube.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> example3 [
	"JunOpenGLDisplayModel example3."

	| aGlobe displayModel |
	aGlobe := JunOpenGL3dObject ball.
	aGlobe paint: (ColorValue 
				red: 255 / 255
				green: 235 / 255
				blue: 215 / 255).
	displayModel := JunOpenGLDisplayModel displayObject: aGlobe.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> example4 [
	"JunOpenGLDisplayModel example4."

	| aStack displayModel |
	aStack := JunOpenGL3dObject stack.
	displayModel := JunOpenGLDisplayModel new.
	displayModel displayLightsAllOff.
	displayModel displayObject: aStack.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> example5 [
	"JunOpenGLDisplayModel example5."

	| anEddy displayModel |
	anEddy := JunOpenGL3dObject eddy.
	displayModel := JunOpenGLDisplayModel new.
	displayModel displayLightsAllOff.
	displayModel displayObject: anEddy.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> example6 [
	"JunOpenGLDisplayModel example6."

	| displayObject displayModel |
	displayObject := JunOpenGL3dObject water.
	displayModel := JunOpenGLDisplayModel new.
	displayModel displayObject: displayObject.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> example7 [
	"JunOpenGLDisplayModel example7."

	| displayObject displayModel |
	displayObject := JunOpenGL3dObject methane.
	displayModel := JunOpenGLDisplayModel new.
	displayModel displayObject: displayObject.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> example8 [
	"JunOpenGLDisplayModel example8."

	| displayObject displayModel |
	displayObject := JunOpenGL3dObject benzene.
	displayModel := JunOpenGLDisplayModel new.
	displayModel displayObject: displayObject.
	displayModel viewFactor: 1.2.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> example9 [
	"JunOpenGLDisplayModel example9."

	| aBenzene aCube aBody displayModel |
	aBenzene := JunOpenGL3dObject benzene.
	aCube := JunOpenGL3dObject cube.
	aCube paint: (ColorValue red blendWith: ColorValue white).
	aCube do: [:each | each halftone].
	aBody := JunOpenGL3dCompoundObject new.
	aBody add: aBenzene.
	aBody add: (aCube transform: (Jun3dTransformation scale: 1.5)).
	displayModel := JunOpenGLDisplayModel new.
	displayModel displayObject: aBody.
	displayModel open.
	displayModel spawnViewport.
	displayModel showModel useTransparency: false.
	aCube := JunOpenGL3dObject cube.
	aCube paint: (ColorValue red blendWith: ColorValue white).
	aCube alpha: 0.5.
	aBody := JunOpenGL3dCompoundObject new.
	aBody add: aBenzene.
	aBody add: (aCube transform: (Jun3dTransformation scale: 1.5)).
	displayModel := JunOpenGLDisplayModel new.
	displayModel displayObject: aBody.
	displayModel open.
	displayModel spawnViewport.
	displayModel showModel useTransparency: true.
	^displayModel
]

{ #category : #examples }
JunOpenGLDisplayModel class >> exampleA [
	"JunOpenGLDisplayModel exampleA."

	| anImage aTexture aCube |
	anImage := JunOpenGLTexture imageSmalltalkBalloon.
	aTexture := JunOpenGLTexture image: anImage.
	aTexture linear: true; clamp: true; modulate: true; mipmap: true.
	aCube := JunOpenGL3dObject cube.
	aCube texture: aTexture.
	aCube name: 'balloon'.
	aCube show
]

{ #category : #examples }
JunOpenGLDisplayModel class >> exampleB [
	"JunOpenGLDisplayModel exampleB."

	| anImage aTexture aCube |
	anImage := JunOpenGLTexture imageSmalltalkBalloon.
	aTexture := JunOpenGLTexture image: anImage.
	aTexture linear: true; repeat: true.
	aTexture coordinates: (Array
			with: 0.0 , 0.0
			with: 1.0 , 0.0
			with: 1.0 , 1.0
			with: 0.0 , 1.0).
	aCube := JunOpenGL3dObject cube.
	aCube texture: aTexture.
	aCube name: 'balloon2'.
	aCube show
]

{ #category : #examples }
JunOpenGLDisplayModel class >> exampleC [
	"JunOpenGLDisplayModel exampleC."

	| anImage aTexture aGlobe |
	anImage := JunOpenGLTexture imageSmalltalkBalloon.
	aTexture := JunOpenGLTexture image: anImage.
	aTexture
		linear: true;
		repeat: true.
	aGlobe := JunOpenGL3dObject ball: 2.
	aGlobe texture: aTexture.
	aGlobe name: 'balloon3'.
	aGlobe show
]

{ #category : #examples }
JunOpenGLDisplayModel class >> exampleD [
	"JunOpenGLDisplayModel exampleD."

	#(#imageEarth #imageEarth1 #imageEarth2 #imageEarth3) do: 
			[:messageSelector | 
			| xyPointsAndSphere xyPoints anObject anImage aTexture |
			xyPointsAndSphere := JunOpenGL3dObject 
						xyPointsAndSphere: 12
						radius: 1
						longitude: 360
						latitude: 180.
			xyPoints := xyPointsAndSphere first 
						collect: [:aPoint | aPoint x , (1 - aPoint y)].
			anObject := xyPointsAndSphere last.
			anObject paint: ColorValue white.
			anImage := JunOpenGLTexture perform: messageSelector.
			aTexture := JunOpenGLTexture image: anImage.
			aTexture coordinates: xyPoints.
			anObject texture: aTexture.
			anObject name: 'earth'.
			anObject show]
]

{ #category : #examples }
JunOpenGLDisplayModel class >> exampleE [
	"JunOpenGLDisplayModel exampleE."

	| image window gc collection pixmap object polyline model |
	image := JunImageStream sampleImage.
	JunImageDisplayModel show: image in: (100 @ 100 extent: image extent).
	JunApplicationModel displayPendingInvalidation.
	window := ScheduledWindow 
				model: nil
				label: 'Border Trace'
				minimumSize: image extent.
	window component: CompositePart new.
	window background: ColorValue white.
	window openIn: ((100 + image width + 24) @ 100 extent: image extent).
	Cursor crossHair showWhile: 
			[[window sensor noButtonPressed] whileTrue: 
					[JunApplicationModel displayPendingInvalidation.
					Processor yield]].
	gc := window component graphicsContext.
	gc
		clear;
		paint: ColorValue red.
	collection := JunImageProcessor traceBorder: image
				interim: 
					[:p | 
					JunControlUtility do: [gc displayRectangle: (p extent: 1 @ 1)]
						forMicroseconds: 500].
	Cursor crossHair showWhile: 
			[[window sensor noButtonPressed] whileTrue: 
					[JunApplicationModel displayPendingInvalidation.
					Processor yield]].
	pixmap := Pixmap extent: image extent.
	gc := pixmap graphicsContext.
	gc
		clear;
		paint: ColorValue red.
	collection do: [:points | gc displayPolyline: points asArray].
	JunImageDisplayModel show: pixmap asImage in: window displayBox.
	window controller closeAndUnschedule.
	pixmap close.
	Cursor wait showWhile: 
			[object := JunOpenGL3dCompoundObject new.
			collection do: 
					[:points | 
					polyline := JunOpenGL3dPolyline 
								vertexes: (points collect: [:p | p x , p y , 0]).
					polyline paint: ColorValue red.
					object add: polyline]].
	model := object show.
	^model
]

{ #category : #examples }
JunOpenGLDisplayModel class >> exampleF [
	"JunOpenGLDisplayModel exampleF."

	| displayModel timeValue1 timeValue2 amplifiedValue |
	displayModel := JunOpenGLDisplayModel new.
	JunCursorAnimator clockCursors 
		showWhile: [displayModel displayObject: JunOpenGL3dObject aoki].
	displayModel openIn: (300 , 300) alignedRectangleWithScreenCenter.
	displayModel getWindow display.
	timeValue1 := Time millisecondsToRun: 
					[displayModel useDisplayList: false.
					100 timesRepeat: [displayModel grab: 0.1 @ 0.05]].
	Transcript
		cr;
		show: timeValue1 printString.
	displayModel resetView.
	timeValue2 := Time millisecondsToRun: 
					[displayModel useDisplayList: true.
					100 timesRepeat: [displayModel grab: 0.1 @ 0.05]].
	Transcript
		show: ' / ';
		show: timeValue2 printString.
	displayModel closeRequest.
	amplifiedValue := (timeValue1 / timeValue2) asFloat.
	Transcript
		show: ' ==> ';
		show: amplifiedValue printString.
	^amplifiedValue
]

{ #category : #examples }
JunOpenGLDisplayModel class >> exampleG [
	"JunOpenGLDisplayModel exampleG."

	| displayModel upVector movementVector projectionTable |
	displayModel := JunOpenGLDisplayModel 
				displayObject: JunOpenGL3dObject earth.
	upVector := 0 , 0 , 1 
				transform: (Jun3dTransformation rotateX: (JunAngle degrees: 23.5)).
	movementVector := (1 , 0 
				transform: (Jun2dTransformation rotateZ: (JunAngle degrees: -23.5))) 
					scaledBy: 0.05.
	projectionTable := (Dictionary new)
				add: #eyePoint -> (10 , 0 , 0);
				add: #sightPoint -> (0 , 0 , 0);
				add: #upVector -> upVector;
				add: #zoomHeight -> 2.5;
				yourself.
	displayModel
		defaultProjectionTable: projectionTable;
		openIn: (200 @ 250 extent: 300 @ 300) interface: #windowSpecWithoutWidgets;
		windowLabel: (#jun_Earth >> 'Earth') asString;
		projectionTable: projectionTable;
		noControl: true;
		movementVector: movementVector;
		"superimposeBlock: 
				[:model :view :controller | 
				| aLine graphicsContext |
				graphicsContext := view graphicsContext.
				graphicsContext 
					displayRectangle: (view bounds topCenter corner: view bounds bottomRight).
				aLine := (0 , 0 to: (0 , 1 
									transform: (Jun2dTransformation rotateZ: (JunAngle degrees: 23.5)))) 
							translatedBy: view bounds center.
				graphicsContext displayLineFrom: (aLine atT: -1000) asPoint
					to: (aLine atT: 1000) asPoint];"
		yourself.
	^displayModel
]

{ #category : #'lisp support' }
JunOpenGLDisplayModel class >> fromTable: aTable for: aModel [ 
	"JunOpenGLDisplayModel fromLispList: ((JunOpenGLDisplayModel displayObject: JunOpenGL3dObject box) toLispList)."

	self displayObjectFromTable: aTable for: aModel.
	self projectionTableFromTable: aTable for: aModel.
	self displayLightsFromTable: aTable for: aModel.
	self preferenceTableFromTable: aTable for: aModel.
	^aModel
]

{ #category : #resources }
JunOpenGLDisplayModel class >> menuBar [
	"Tools.MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^#('#{UI.Menu}' #(
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_File 
					#defaultString: 'File' ) 
				#submenu: #('#{UI.Menu}' #(
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_New 
								#defaultString: 'New' ) 
							#value: #newModel ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Open___ 
								#defaultString: 'Open...' ) 
							#value: #openLST ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Open_as___ 
								#defaultString: 'Open as...' ) 
							#submenu: #('#{UI.Menu}' #(
									#('#{UI.MenuItem}' 
										#rawLabel: 'VRML 1.0...' 
										#value: #openWRL10 ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 'VRML 2.0...' 
										#value: #openWRL20 ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 'VRML 97...' 
										#value: #openWRL97 ) ) #(3 ) nil ) ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Save___ 
								#defaultString: 'Save...' ) 
							#value: #saveLST ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Save_as___Hokani 
								#defaultString: 'Save as...' ) 
							#submenu: #('#{UI.Menu}' #(
									#('#{UI.MenuItem}' 
										#rawLabel: 'VRML 97...' 
										#value: #saveWRL97 ) ) #(1 ) nil ) ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Save_as_image___ 
								#defaultString: 'Save as image...' ) 
							#value: #saveAsImage ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Quit 
								#defaultString: 'Quit' ) 
							#value: #quitDoing ) ) #(3 3 1 ) nil ) ) 
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_Edit 
					#defaultString: 'Edit' ) 
				#submenu: #('#{UI.Menu}' #(
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Copy 
								#defaultString: 'Copy' ) 
							#value: #copyObject ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Cut 
								#defaultString: 'Cut' ) 
							#value: #cutObject ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Paste 
								#defaultString: 'Paste' ) 
							#value: #pasteObject ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Clear 
								#defaultString: 'Clear' ) 
							#value: #clearObject ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Select_all 
								#defaultString: 'Select all' ) 
							#value: #selectAll ) ) #(4 1 ) nil ) ) 
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_View 
					#defaultString: 'View' ) 
				#submenu: #('#{UI.Menu}' #(
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Zooming 
								#defaultString: 'Zooming' ) 
							#submenu: #('#{UI.Menu}' #(
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Fit_zoom 
											#defaultString: 'Fit zoom' ) 
										#value: #fitZoom ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Close_up 
											#defaultString: 'Close up' ) 
										#value: #closeUp ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Zoom 
											#defaultString: 'Zoom' ) 
										#value: #zoom ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Pan 
											#defaultString: 'Pan' ) 
										#value: #pan ) ) #(2 2 ) nil ) ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Pointing 
								#defaultString: 'Pointing' ) 
							#submenu: #('#{UI.Menu}' #(
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Fit_sight 
											#defaultString: 'Fit sight' ) 
										#value: #fitSight ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Eye_point___ 
											#defaultString: 'Eye point...' ) 
										#value: #changeEyePoint ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Sight_point___ 
											#defaultString: 'Sight point...' ) 
										#value: #changeSightPoint ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Up_vector___ 
											#defaultString: 'Up vector...' ) 
										#value: #changeUpVector ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Zoom_height___ 
											#defaultString: 'Zoom height...' ) 
										#value: #changeZoomHeight ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_View_factor___ 
											#defaultString: 'View factor...' ) 
										#value: #changeViewFactor ) ) #(1 3 2 ) nil ) ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Projection 
								#defaultString: 'Projection' ) 
							#submenu: #('#{UI.Menu}' #(
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Perspective 
											#defaultString: 'Perspective' ) 
										#value: #perspectiveProjection ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Parallel 
											#defaultString: 'Parallel' ) 
										#value: #parallelProjection ) ) #(2 ) nil ) ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Presentation 
								#defaultString: 'Presentation' ) 
							#submenu: #('#{UI.Menu}' #(
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Solid 
											#defaultString: 'Solid' ) 
										#value: #solidPresentation ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Wireframe 
											#defaultString: 'Wireframe' ) 
										#value: #wireframePresentation ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Hidden_line 
											#defaultString: 'Hidden-line' ) 
										#value: #hiddenlinePresentation ) ) #(3 ) nil ) ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Shading 
								#defaultString: 'Shading' ) 
							#submenu: #('#{UI.Menu}' #(
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Flat 
											#defaultString: 'Flat' ) 
										#value: #flatShading ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Smooth 
											#defaultString: 'Smooth' ) 
										#value: #smoothShading ) ) #(2 ) nil ) ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Smoothing 
								#defaultString: 'Smoothing' ) 
							#submenu: #('#{UI.Menu}' #(
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Line_smooth 
											#defaultString: 'Line smooth' ) 
										#value: #lineSmooth ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Polygon_smooth 
											#defaultString: 'Polygon smooth' ) 
										#value: #polygonSmooth ) ) #(2 ) nil ) ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Smoothing_Angle 
								#defaultString: 'Smoothing Angle' ) 
							#value: #changeSmoothingAngle ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Reset 
								#defaultString: 'Reset' ) 
							#value: #resetView ) ) #(2 5 1 ) nil ) ) 
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_Light 
					#defaultString: 'Light' ) 
				#submenu: #('#{UI.Menu}' #(
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Light1 
								#defaultString: 'Light1' ) 
							#value: #openLight1 ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Light2 
								#defaultString: 'Light2' ) 
							#value: #openLight2 ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Light3 
								#defaultString: 'Light3' ) 
							#value: #openLight3 ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Light4 
								#defaultString: 'Light4' ) 
							#value: #openLight4 ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Ambient 
								#defaultString: 'Ambient' ) 
							#value: #openLight5 ) ) #(4 1 ) nil ) ) 
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_Misc 
					#defaultString: 'Misc' ) 
				#submenu: #('#{UI.Menu}' #(
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Texture 
								#defaultString: 'Texture' ) 
							#submenu: #('#{UI.Menu}' #(
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_From_user___ 
											#defaultString: 'From user...' ) 
										#value: #textureFromUser ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_From_file___ 
											#defaultString: 'From file...' ) 
										#value: #textureFromFile ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Take_away 
											#defaultString: 'Take away' ) 
										#value: #textureTakeAway ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Linear_approx_ 
											#defaultString: 'Linear approx.' ) 
										#value: #textureLinear ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Clamp 
											#defaultString: 'Clamp' ) 
										#value: #textureClamp ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Modulate 
											#defaultString: 'Modulate' ) 
										#value: #textureModulate ) 
									#('#{UI.MenuItem}' 
										#rawLabel: 
										#('#{Kernel.UserMessage}' 
											#key: #jun_Mipmap 
											#defaultString: 'Mipmap' ) 
										#value: #textureMipmap ) ) #(3 4 ) nil ) ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Spawn 
								#defaultString: 'Spawn' ) 
							#value: #spawnObject ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Viewport 
								#defaultString: 'Viewport' ) 
							#value: #spawnViewport ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Bounds 
								#defaultString: 'Bounds' ) 
							#value: #showBounds ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Inspect 
								#defaultString: 'Inspect' ) 
							#value: #inspectModel ) ) #(4 1 ) nil ) ) ) #(5 ) nil ) decodeAsLiteralArray
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> openFile: aFilenameOrString [ 
	"JunOpenGLDisplayModel openFile: JunOpenGLDisplayModel requestFile."

	| aFilename aBody aViewfinder |
	aFilenameOrString ifNil: [^nil].
	aFilename := aFilenameOrString asFilename.
	aFilename exists ifFalse: [^nil].
	self 
		assert: [aFilename readStream]
		do: [:aStream | aBody := self new loadFromLST10: aStream]
		ensure: [:aStream | aStream close].
	aBody ifNil: [^nil].
	aViewfinder := self show: aBody.
	^aViewfinder
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> openFile: aFilenameOrString at: aPoint [ 
	"JunOpenGLDisplayModel openFile: JunOpenGLDisplayModel requestFile at: 100 @ 100."

	| aFilename aBody aViewfinder |
	aFilenameOrString ifNil: [^nil].
	aFilename := aFilenameOrString asFilename.
	aFilename exists ifFalse: [^nil].
	self 
		assert: [aFilename readStream]
		do: [:aStream | aBody := self new loadFromLST10: aStream]
		ensure: [:aStream | aStream close].
	aBody ifNil: [^nil].
	aViewfinder := self show: aBody at: aPoint.
	^aViewfinder
]

{ #category : #images }
JunOpenGLDisplayModel class >> pickBoundsImage [
	"JunImageStream show: (JunOpenGLDisplayModel pickBoundsImage)."

	^JunCursors boundsCursor asOpaqueImage
]

{ #category : #images }
JunOpenGLDisplayModel class >> pickNormalImage [
	| image figure shape |
	image := Cursor normal asOpaqueImage.
	figure := Image 
				extent: image figure asImage extent
				depth: image figure asImage depth
				bitsPerPixel: image figure asImage bitsPerPixel
				palette: image figure asImage palette.
	figure 
		copy: (figure bounds insetBy: (3 @ 0 corner: 0 @ 0))
		from: 0 @ 0
		in: image figure asImage
		rule: RasterOp over.
	shape := Image 
				extent: image shape asImage extent
				depth: image shape asImage depth
				bitsPerPixel: image shape asImage bitsPerPixel
				palette: image shape asImage palette.
	shape 
		copy: (shape bounds insetBy: (3 @ 0 corner: 0 @ 0))
		from: 0 @ 0
		in: image shape asImage
		rule: RasterOp over.
	image := OpaqueImage figure: figure shape: shape.
	^image
]

{ #category : #images }
JunOpenGLDisplayModel class >> pickPencilImage [
	"JunImageStream show: (JunOpenGLDisplayModel pickPencilImage)."

	^JunCursors pencilCursor asOpaqueImage
]

{ #category : #'lisp support' }
JunOpenGLDisplayModel class >> preferenceTableFromTable: aTable for: aModel [ 
	| aList preferenceTable |
	aList := aTable at: #preferenceTable ifAbsent: [^aModel].
	preferenceTable := JunAttributeTable fromLispList: aList.
	aModel preferenceTable: preferenceTable.
	^aModel
]

{ #category : #'lisp support' }
JunOpenGLDisplayModel class >> projectionTableFromTable: aTable for: aModel [ 
	| aList projectionTable |
	aList := aTable at: #projectionTable ifAbsent: [^aModel].
	projectionTable := JunAttributeTable fromLispList: aList.
	aModel defaultProjectionTable: projectionTable.
	aModel projectionTable: projectionTable.
	^aModel
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> requestFile [
	"JunOpenGLDisplayModel requestFile ifNotNil: [:it | Transcript cr; show: it printString]."

	| labels values menu filename |
	labels := Array with: (Array 
						with: (#jun__1s__files >> '<1s> files' expandMacrosWith: 'LST')).
	values := Array with: #('*.lst' '*.LST').
	menu := Menu labelList: labels values: values.
	filename := JunFileRequesterDialog 
				requestFilename: (#jun_Select_a__1s__file_ >> 'Select a <1s> file.' 
						expandMacrosWith: 'LST') asString
				fileTypeMenu: menu
				initialFileType: values first.
	filename isNil ifTrue: [^nil].
	^filename
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject [ 
	"JunOpenGLDisplayModel show: JunOpenGL3dObject cube."

	^self show: a3dObject eyePoint: nil
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject at: displayPoint [ 
	"JunOpenGLDisplayModel show: JunOpenGL3dObject cube at: (200@200)."

	^self 
		show: a3dObject
		eyePoint: nil
		sightPoint: nil
		upVector: nil
		viewFactor: nil
		in: (displayPoint extent: 300 @ 300)
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject eyePoint: eyePoint [
	"JunOpenGLDisplayModel 
		show: JunOpenGL3dObject cube 
		eyePoint: 10 , 0 , 0."

	^self
		show: a3dObject
		eyePoint: eyePoint
		sightPoint: nil
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject eyePoint: eyePoint sightPoint: sightPoint [
	"JunOpenGLDisplayModel 
		show: JunOpenGL3dObject cube 
		eyePoint: 10 , 0 , 0 
		sightPoint: 0 , 0 , 0."

	^self
		show: a3dObject
		eyePoint: eyePoint
		sightPoint: sightPoint
		upVector: nil
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject eyePoint: eyePoint sightPoint: sightPoint upVector: upVector [
	"JunOpenGLDisplayModel 
		show: JunOpenGL3dObject cube 
		eyePoint: 10 , 0 , 0 
		sightPoint: 0 , 0 , 0 
		upVector: 0, 1,0."

	^self
		show: a3dObject
		eyePoint: eyePoint
		sightPoint: sightPoint
		upVector: upVector
		viewFactor: nil
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject eyePoint: eyePoint sightPoint: sightPoint upVector: upVector viewFactor: viewFactor [ 
	"JunOpenGLDisplayModel 
		show: JunOpenGL3dObject cube 
		eyePoint: 10 , 0 , 0 
		sightPoint: 0 , 0 , 0 
		upVector: 0, 1,0 
		viewFactor: 10."

	^self
		show: a3dObject
		eyePoint: eyePoint
		sightPoint: sightPoint
		upVector: upVector
		viewFactor: viewFactor
		in: nil
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject eyePoint: eyePoint sightPoint: sightPoint upVector: upVector viewFactor: viewFactor in: displayRectangle [ 
	"JunOpenGLDisplayModel 
		show: JunOpenGL3dObject cube 
		eyePoint: 10 , 0 , 0 
		sightPoint: 0 , 0 , 0 
		upVector: 0, 1, 0 
		viewFactor: 10 
		in: (200 @ 200 extent: 400 @ 200)."

	^self
		show: a3dObject
		eyePoint: eyePoint
		sightPoint: sightPoint
		upVector: upVector
		viewFactor: viewFactor
		zoomHeight: nil
		in: displayRectangle
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject eyePoint: eyePoint sightPoint: sightPoint upVector: upVector viewFactor: viewFactor zoomHeight: zoomHeight in: displayRectangle [ 
	"JunOpenGLDisplayModel 
		show: JunOpenGL3dObject cube 
		eyePoint: 10 , 0 , 0 
		sightPoint: 0 , 0 , 0 
		upVector: 0, 1, 0 
		viewFactor: 10 
		zoomHeight: 2.4 
		in: (200 @ 200 extent: 400 @ 200)."

	| displayModel |
	displayModel := self displayObject: a3dObject.
	eyePoint notNil ifTrue: [displayModel defaultEyePoint: eyePoint].
	sightPoint notNil ifTrue: [displayModel defaultSightPoint: sightPoint].
	upVector notNil ifTrue: [displayModel defaultUpVector: upVector].
	viewFactor notNil ifTrue: [displayModel defaultViewFactor: viewFactor].
	zoomHeight notNil ifTrue: [displayModel defaultZoomHeight: zoomHeight].
	displayRectangle isNil
		ifTrue: [displayModel open]
		ifFalse: [displayModel openIn: displayRectangle].
	^displayModel
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject eyePoint: eyePoint sightPoint: sightPoint upVector: upVector zoomHeight: zoomHeight [ 
	"JunOpenGLDisplayModel 
		show: JunOpenGL3dObject cube 
		eyePoint: 10 , 0 , 0 
		sightPoint: 0 , 0 , 0 
		upVector: 0, 1, 0 
		zoomHeight: 2.4."

	^self 
		show: a3dObject
		eyePoint: eyePoint
		sightPoint: sightPoint
		upVector: upVector
		zoomHeight: zoomHeight
		in: nil
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject eyePoint: eyePoint sightPoint: sightPoint upVector: upVector zoomHeight: zoomHeight in: displayRectangle [ 
	"JunOpenGLDisplayModel 
		show: JunOpenGL3dObject cube 
		eyePoint: 10 , 0 , 0 
		sightPoint: 0 , 0 , 0 
		upVector: 0, 1, 0 
		zoomHeight: 2.4 
		in: (200 @ 200 extent: 400 @ 200)."

	self 
		show: a3dObject
		eyePoint: eyePoint
		sightPoint: sightPoint
		upVector: upVector
		viewFactor: nil
		zoomHeight: zoomHeight
		in: displayRectangle
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject in: displayRectangle [ 
	"JunOpenGLDisplayModel show: JunOpenGL3dObject cube in: (200@200 extent: 400@400)."

	^self
		show: a3dObject
		eyePoint: nil
		sightPoint: nil
		upVector: nil
		viewFactor: nil
		in: displayRectangle
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject projectionTable: aDictionary [ 
	"JunOpenGLDisplayModel 
		show: JunOpenGL3dObject cube 
		projectionTable: (Dictionary new
			add: #presentation -> #solidPresentation;
			add: #sightPoint -> (0.0d , 0.0d , 0.0d);
			add: #eyePoint -> (8.9144349065121d , 5.018580708957d , 6.2726946335082d);
			add: #shading -> #flatShading;
			add: #upVector -> (-0.29701438733281d , -0.49387349075548d , 0.81723401106801d);
			add: #viewFactor -> 10;
			add: #zoomHeight -> 3.9191837441874d;
			yourself)."

	^self 
		show: a3dObject
		projectionTable: aDictionary
		in: nil
]

{ #category : #utilities }
JunOpenGLDisplayModel class >> show: a3dObject projectionTable: aDictionary in: displayRectangle [ 
	"JunOpenGLDisplayModel 
		show: JunOpenGL3dObject cube 
		projectionTable: (Dictionary new
			add: #presentation -> #solidPresentation;
			add: #sightPoint -> (0.0d , 0.0d , 0.0d);
			add: #eyePoint -> (8.9144349065121d , 5.018580708957d , 6.2726946335082d);
			add: #shading -> #flatShading;
			add: #upVector -> (-0.29701438733281d , -0.49387349075548d , 0.81723401106801d);
			add: #viewFactor -> 10;
			add: #zoomHeight -> 3.9191837441874d;
			yourself) 
		in: (200 @ 200 extent: 400 @ 200)."

	| displayModel |
	displayModel := self displayObject: a3dObject.
	aDictionary notNil 
		ifTrue: [displayModel defaultProjectionTable: aDictionary].
	displayRectangle isNil 
		ifTrue: [displayModel open]
		ifFalse: [displayModel openIn: displayRectangle].
	^displayModel
]

{ #category : #copyright }
JunOpenGLDisplayModel class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLDisplayModel class >> version [
	^'799'
]

{ #category : #'interface specs' }
JunOpenGLDisplayModel class >> windowSpec [
	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: 
			#(#UserMessage 
				#key: #jun_Viewfinder 
				#defaultString: 'Viewfinder' ) 
			#min: #(#Point 280 280 ) 
			#bounds: #(#Rectangle 100 100 400 400 ) 
			#flags: 4 
			#menu: #menuBar ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame 20 0 1 0 -20 1 -20 1 ) 
					#name: #displayView 
					#colors: 
					#(#LookPreferences 
						#setBackgroundColor: #(#ColorValue #white ) ) 
					#component: #displayView ) 
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame 1 0 1 0 19 0 19 0 ) 
					#name: #pickButtonView 
					#flags: 0 
					#component: #pickButtonView ) 
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame 1 0 20 0 19 0 38 0 ) 
					#name: #grabButtonView 
					#flags: 0 
					#component: #grabButtonView ) 
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame 1 0 39 0 19 0 57 0 ) 
					#name: #dragButtonView 
					#flags: 0 
					#component: #dragButtonView ) 
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame 1 0 -61 0.5 19 0 61 0.5 ) 
					#name: #xThumbWheelView 
					#flags: 0 
					#component: #xThumbWheelView ) 
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame -61 0.5 -19 1 61 0.5 -1 1 ) 
					#name: #yThumbWheelView 
					#flags: 0 
					#component: #yThumbWheelView ) 
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame -19 1 -61 0.5 -1 1 61 0.5 ) 
					#name: #zThumbWheelView 
					#flags: 0 
					#component: #zThumbWheelView ) 
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame -19 1 -80 0.5 -1 1 -62 0.5 ) 
					#name: #focusButtonView 
					#flags: 0 
					#component: #focusButtonView ) 
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame -19 1 62 0.5 -1 1 80 0.5 ) 
					#name: #dollyButtonView 
					#flags: 0 
					#component: #dollyButtonView ) ) ) )
]

{ #category : #'interface specs' }
JunOpenGLDisplayModel class >> windowSpecWithoutWidgets [
	"Tools.UIPainter new openOnClass: self andSelector: #windowSpecWithoutWidgets"

	<resource: #canvas>
	^#('#{UI.FullSpec}' 
		#window: 
		#('#{UI.WindowSpec}' 
			#label: 
			#('#{Kernel.UserMessage}' 
				#key: #jun_Viewfinder 
				#defaultString: 'Viewfinder' ) 
			#min: #('#{Core.Point}' 280 280 ) 
			#bounds: #('#{Graphics.Rectangle}' 512 384 812 684 ) 
			#menu: #menuBar ) 
		#component: 
		#('#{UI.SpecCollection}' 
			#collection: #(
				#('#{UI.ArbitraryComponentSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 1 0 -1 1 -1 1 ) 
					#name: #displayView 
					#colors: 
					#('#{UI.LookPreferences}' 
						#setBackgroundColor: #('#{Graphics.ColorValue}' #white ) ) 
					#component: #displayView ) ) ) )
]

{ #category : #selecting }
JunOpenGLDisplayModel >> addSelectedObject: a3dObject [ 
	self displayObject isNil ifTrue: [^nil].
	self displayObject isPrimitive ifTrue: [^nil].
	((self selectedObjects includes: a3dObject) not 
		and: [self displayObject includes: a3dObject]) 
			ifTrue: [self selectedObjects add: a3dObject]
]

{ #category : #superimpose }
JunOpenGLDisplayModel >> afterSuperimpose [
	^self
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> altClick: pickedObject [ 
	^nil
]

{ #category : #converting }
JunOpenGLDisplayModel >> asImage [
	| aView imageExtent |
	aView := self getView.
	aView isNil
		ifTrue: [imageExtent := self defaultImageExtent]
		ifFalse: [imageExtent := aView bounds extent].
	^self asImageExtent: imageExtent
]

{ #category : #converting }
JunOpenGLDisplayModel >> asImageExtent: imageExtent [ 
	| aString aBitmap aView renderingContext anImage |
	aString := JunSystem platformName.
	(aString = 'MacOSX' or: [aString = 'Mac']) 
		ifTrue: [^self asImageExtentForMac: imageExtent].
	self 
		assert: 
			[aBitmap := JunOpenGLRetainedMedium extent: imageExtent asPoint rounded.
			(aView := self getView) isNil 
				ifTrue: [aBitmap setBackground: ColorValue white]
				ifFalse: [aBitmap setBackground: aView lookPreferences backgroundColor]]
		do: 
			[self 
				assert: [renderingContext := aBitmap renderingContext]
				do: 
					[self renderOn: renderingContext.
					renderingContext flush]
				ensure: [renderingContext release].
			anImage := aBitmap medium asImage]
		ensure: [aBitmap release].
	^anImage
]

{ #category : #converting }
JunOpenGLDisplayModel >> asImageExtentForMac: imageExtent [ 
	| displayListHolder aBitmap aView renderingContext anImage |
	self useDisplayList 
		ifTrue: 
			[self 
				assert: 
					[displayListHolder := nil asValue.
					aBitmap := JunOpenGLRetainedMedium extent: imageExtent asPoint rounded.
					(aView := self getView) isNil 
						ifTrue: [aBitmap setBackground: ColorValue white]
						ifFalse: [aBitmap setBackground: aView lookPreferences backgroundColor]]
				do: 
					[self 
						assert: [renderingContext := aBitmap renderingContext]
						do: 
							[self renderOn: renderingContext withDisplayList: displayListHolder.
							renderingContext flush]
						ensure: [renderingContext deactivate]]
				ensure: 
					[self 
						assert: [renderingContext initializeContext]
						do: 
							[self renderOn: renderingContext withDisplayList: displayListHolder.
							renderingContext flush]
						ensure: [renderingContext release].
					anImage := aBitmap medium asImage.
					aBitmap release]]
		ifFalse: 
			[self 
				assert: 
					[aBitmap := JunOpenGLRetainedMedium extent: imageExtent asPoint rounded.
					(aView := self getView) isNil 
						ifTrue: [aBitmap setBackground: ColorValue white]
						ifFalse: [aBitmap setBackground: aView lookPreferences backgroundColor]]
				do: 
					[self 
						assert: [renderingContext := aBitmap renderingContext]
						do: 
							[self renderOn: renderingContext.
							renderingContext flush]
						ensure: [renderingContext release].
					anImage := aBitmap medium asImage]
				ensure: [aBitmap release]].
	^anImage
]

{ #category : #converting }
JunOpenGLDisplayModel >> asPointArray [
	self displayObject isNil ifTrue: [^Array new].
	^self displayObject asPointArray
]

{ #category : #superimpose }
JunOpenGLDisplayModel >> beforeSuperimpose [
	^self
]

{ #category : #'bounds accessing' }
JunOpenGLDisplayModel >> boundingBox [
	self displayObject isNil ifTrue: [^Jun3dBoundingBox origin: 0 , 0 , 0 corner: 0 , 0 , 0].
	^self displayObject boundingBox
]

{ #category : #private }
JunOpenGLDisplayModel >> boundingObjectFor: a3dObject [ 
	| aBox originPoint cornerPoint polylineLoop1 polylineLoop2 polylineLoop3 polylineLoop4 polylineLoop5 polylineLoop6 anAxes boundingObject |
	aBox := a3dObject boundingBox.
	originPoint := aBox origin.
	cornerPoint := aBox corner.
	polylineLoop1 := JunOpenGL3dPolylineLoop
				vertexes: (Array
						with: originPoint x , originPoint y , cornerPoint z
						with: originPoint x , cornerPoint y , cornerPoint z
						with: originPoint x , cornerPoint y , originPoint z
						with: originPoint x , originPoint y , originPoint z)
				paint: ColorValue gray
				alpha: 0.5.
	polylineLoop2 := JunOpenGL3dPolylineLoop
				vertexes: (Array
						with: cornerPoint x , originPoint y , cornerPoint z
						with: cornerPoint x , cornerPoint y , cornerPoint z
						with: cornerPoint x , cornerPoint y , originPoint z
						with: cornerPoint x , originPoint y , originPoint z) reverse
				paint: ColorValue gray
				alpha: 0.5.
	polylineLoop3 := JunOpenGL3dPolylineLoop
				vertexes: (Array
						with: originPoint x , cornerPoint y , cornerPoint z
						with: cornerPoint x , cornerPoint y , cornerPoint z
						with: cornerPoint x , cornerPoint y , originPoint z
						with: originPoint x , cornerPoint y , originPoint z)
				paint: ColorValue gray
				alpha: 0.5.
	polylineLoop4 := JunOpenGL3dPolylineLoop
				vertexes: (Array
						with: originPoint x , originPoint y , cornerPoint z
						with: cornerPoint x , originPoint y , cornerPoint z
						with: cornerPoint x , originPoint y , originPoint z
						with: originPoint x , originPoint y , originPoint z) reverse
				paint: ColorValue gray
				alpha: 0.5.
	polylineLoop5 := JunOpenGL3dPolylineLoop
				vertexes: (Array
						with: originPoint x , originPoint y , cornerPoint z
						with: cornerPoint x , originPoint y , cornerPoint z
						with: cornerPoint x , cornerPoint y , cornerPoint z
						with: originPoint x , cornerPoint y , cornerPoint z)
				paint: ColorValue gray
				alpha: 0.5.
	polylineLoop6 := JunOpenGL3dPolylineLoop
				vertexes: (Array
						with: originPoint x , originPoint y , originPoint z
						with: cornerPoint x , originPoint y , originPoint z
						with: cornerPoint x , cornerPoint y , originPoint z
						with: originPoint x , cornerPoint y , originPoint z) reverse
				paint: ColorValue gray
				alpha: 0.5.
	anAxes := JunOpenGL3dObject axes2.
	anAxes := anAxes transform: (Jun3dTransformation scale: cornerPoint - originPoint).
	anAxes := anAxes transform: (Jun3dTransformation translate: originPoint).
	boundingObject := JunOpenGL3dCompoundObject new.
	boundingObject add: polylineLoop1.
	boundingObject add: polylineLoop2.
	boundingObject add: polylineLoop3.
	boundingObject add: polylineLoop4.
	boundingObject add: polylineLoop5.
	boundingObject add: polylineLoop6.
	boundingObject add: anAxes.
	^boundingObject
]

{ #category : #buttons }
JunOpenGLDisplayModel >> buttonState [
	self pushButtons associationsDo: 
			[:association | 
			| button |
			button := association value.
			button value = true ifTrue: [^association key]].
	^nil
]

{ #category : #buttons }
JunOpenGLDisplayModel >> buttonState: keySymbol [ 
	self pushButtons associationsDo: 
			[:association | 
			| button |
			button := association value.
			keySymbol isNil 
				ifTrue: 
					[button value: false.
					self displayPendingInvalidation]
				ifFalse: 
					[association key = keySymbol 
						ifTrue: 
							[button value: true.
							self displayPendingInvalidation]]]
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> changeEyePoint [
	| point x y z string |
	point := self eyePoint.
	x := point x asFloat.
	y := point y asFloat.
	z := point z asFloat.
	string := JunDialog
				request: (#jun_Input_the_eye_point____x___y___z__ >> 'Input the eye point. ( x , y , z )') asString
				initialAnswer: '(' , x printString , ' , ' , y printString , ' , ' , z printString , ')'
				onCancel: [^self].
	point := Object errorSignal handle: [:exception | exception return]
				do: [Compiler isNil
						ifTrue: ["when I am a run time image"
							JunLispSmallCompiler evaluate: string]
						ifFalse: [Compiler evaluate: string]].
	(point isKindOf: Jun3dPoint)
		ifFalse: [^JunDialog warn: string printString , (#jun__is_invalid_point_ >> ' is invalid point.') asString].
	self eyePoint: point
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> changeSightPoint [
	| point x y z string |
	point := self sightPoint.
	x := point x asFloat.
	y := point y asFloat.
	z := point z asFloat.
	string := JunDialog 
				request: (#jun_Input_the_sight_point____x___y___z__ 
						>> 'Input the sight point. ( x , y , z )') asString
				initialAnswer: '(' , x printString , ' , ' , y printString , ' , ' 
						, z printString , ')'
				onCancel: [^self].
	point := Object errorSignal handle: [:exception | exception return]
				do: 
					[Compiler isNil 
						ifTrue: 
							["when I am a run time image"

							JunLispSmallCompiler evaluate: string]
						ifFalse: [Compiler evaluate: string]].
	(point isKindOf: Jun3dPoint) 
		ifFalse: 
			[^JunDialog warn: string printString 
						, (#jun__is_invalid_point_ >> ' is invalid point.') asString].
	self sightPoint: point
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> changeSmoothingAngle [
	| anObject smoothingAngle value string |
	anObject := self displayObject.
	anObject isNil ifTrue: [^self].
	smoothingAngle := anObject smoothingAngle.
	smoothingAngle isNil 
		ifTrue: [smoothingAngle := anObject defaultSmoothingAngle].
	value := smoothingAngle deg asFloat.
	string := JunDialog 
				request: (#jun_Input_the_smoothing_angle_ >> 'Input the smoothing angle.') 
						asString
				initialAnswer: value printString
				onCancel: [^self].
	value := Object errorSignal handle: [:exception | exception return]
				do: 
					[Compiler isNil 
						ifTrue: 
							["when I am a run time image"

							JunLispSmallCompiler evaluate: string]
						ifFalse: [Compiler evaluate: string]].
	(value isKindOf: Number) 
		ifFalse: 
			[^JunDialog warn: string printString 
						, (#jun__is_invalid_value_ >> ' is invalid value.') asString].
	smoothingAngle := JunAngle fromDeg: value.
	self displayObject 
		establishAllNormalVectorsWithSmoothingAngle: smoothingAngle.
	self changed: #presentation
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> changeUpVector [
	| point x y z string |
	point := self upVector.
	x := point x asFloat.
	y := point y asFloat.
	z := point z asFloat.
	string := JunDialog
				request: (#jun_Input_the_up_vector____x___y___z__ >> 'Input the up vector. ( x , y , z )') asString
				initialAnswer: '(' , x printString , ' , ' , y printString , ' , ' , z printString , ')'
				onCancel: [^self].
	point := Object errorSignal handle: [:exception | exception return]
				do: [Compiler isNil
						ifTrue: ["when I am a run time image"
							JunLispSmallCompiler evaluate: string]
						ifFalse: [Compiler evaluate: string]].
	(point isKindOf: Jun3dPoint)
		ifFalse: [^JunDialog warn: string printString , (#jun__is_invalid_point_ >> ' is invalid point.') asString].
	self upVector: point
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> changeViewFactor [
	| value string |
	value := self viewFactor.
	value := value asFloat.
	string := JunDialog
				request: (#jun_Input_the_view_factor_ >> 'Input the view factor.') asString
				initialAnswer: value printString
				onCancel: [^self].
	value := Object errorSignal handle: [:exception | exception return]
				do: [Compiler isNil
						ifTrue: ["when I am a run time image"
							JunLispSmallCompiler evaluate: string]
						ifFalse: [Compiler evaluate: string]].
	(value isKindOf: Number)
		ifFalse: [^JunDialog warn: string printString , (#jun__is_invalid_value_ >> ' is invalid value.') asString].
	self viewFactor: value
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> changeZoomHeight [
	| height string |
	height := self zoomHeight.
	height := height asFloat.
	string := JunDialog
				request: (#jun_Input_the_zoom_height_ >> 'Input the zoom height.') asString
				initialAnswer: height printString
				onCancel: [^self].
	height := Object errorSignal handle: [:exception | exception return]
				do: [Compiler isNil
						ifTrue: ["when I am a run time image"
							JunLispSmallCompiler evaluate: string]
						ifFalse: [Compiler evaluate: string]].
	(height isKindOf: Number)
		ifFalse: [^JunDialog warn: string printString , (#jun__is_invalid_height_ >> ' is invalid height.') asString].
	self zoomHeight: height
]

{ #category : #'texture mapping' }
JunOpenGLDisplayModel >> clamp [
	| aBoolean aTexture |
	aBoolean := false.
	self displayObject isNil ifTrue: [^aBoolean].
	self displayObject objectsDo: 
			[:each | 
			aTexture := each texture.
			aTexture notNil ifTrue: [aBoolean := aTexture clamp]].
	^aBoolean
]

{ #category : #private }
JunOpenGLDisplayModel >> classToSpawn [
	^self class
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> clearObject [
	self selectedObjects isEmpty ifTrue: [^self].
	self displayObject isCompound ifFalse: [^self].
	JunCursorAnimator clockCursors
		showWhile: 
			[self selectedObjects do: [:each | self displayObject remove: each].
			self clearSelectedObjects.
			self changed: #object].
	self updateMenuIndication
]

{ #category : #selecting }
JunOpenGLDisplayModel >> clearSelectedObjects [
	selectedObjects := OrderedCollection new
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> closeUp [
	| aProjection aRadius aDistance aLine aPoint |
	aProjection := self displayProjection.
	aRadius := aProjection regularHeight / 2.
	aDistance := aProjection sightPoint distance: aProjection eyePoint.
	aLine := Jun3dLine from: aProjection sightPoint to: aProjection eyePoint.
	aPoint := aLine atT: aRadius / aDistance.
	aProjection eyePoint: aPoint.
	aProjection zoomHeight: self computeZoomHeight.
	self displayProjection: aProjection.
	self changed: #projection
]

{ #category : #private }
JunOpenGLDisplayModel >> computeSightPoint [
	^self selectedObjects isEmpty
		ifTrue: [self boundingBox center]
		ifFalse: 
			[| centers |
			centers := self selectedObjects collect: [:selectedObject | selectedObject boundingBox center].
			(centers inject: 0 , 0 , 0 into: [:center1 :center2 | center1 + center2])
				/ centers size]
]

{ #category : #private }
JunOpenGLDisplayModel >> computeZoomHeight [
	| maxOffsetX maxOffsetY depth up down right left horizontal vertical aView aBox maxHeight |
	maxOffsetX := 0.0d.
	maxOffsetY := 0.0d.
	depth := self displayProjection distance.
	up := self displayProjection translateTo3dPointFromPoint: 0 @ -1 depth: depth.
	down := self displayProjection translateTo3dPointFromPoint: 0 @ 1 depth: depth.
	right := self displayProjection translateTo3dPointFromPoint: 1 @ 0 depth: depth.
	left := self displayProjection translateTo3dPointFromPoint: -1 @ 0 depth: depth.
	horizontal := JunPlane
				on: self displayProjection eyePoint
				on: left
				on: right.
	vertical := JunPlane
				on: self displayProjection eyePoint
				on: up
				on: down.
	self
		pointsDo: 
			[:p | 
			| offsetX offsetY |
			offsetX := vertical distanceFromPoint: p.
			offsetY := horizontal distanceFromPoint: p.
			offsetX > maxOffsetX ifTrue: [maxOffsetX := offsetX].
			offsetY > maxOffsetY ifTrue: [maxOffsetY := offsetY]].
	((aView := self getView) notNil and: [(aBox := aView bounds) height ~= 0 and: [maxOffsetX ~= 0.0d and: [maxOffsetY ~= 0.0d]]])
		ifTrue: [aBox width / aBox height * maxOffsetY < maxOffsetX
				ifTrue: 
					[| tmpViewHeight |
					tmpViewHeight := aBox width / aBox height * (maxOffsetY / maxOffsetX) * maxOffsetY.
					maxHeight := maxOffsetY * (maxOffsetY / tmpViewHeight)]
				ifFalse: [maxHeight := maxOffsetY]]
		ifFalse: [maxOffsetX > maxOffsetY
				ifTrue: [maxHeight := maxOffsetX]
				ifFalse: [maxHeight := maxOffsetY]].
	maxHeight := maxHeight * self defaultZoomHeightFactor.
	^maxHeight
]

{ #category : #converting }
JunOpenGLDisplayModel >> convertModelPointToView3dPoint: modelPoint in: aRectangle [ 
	| scaleFactor deltaPoint aProjection aPoint view3dPoint |
	scaleFactor := aRectangle height / 2.
	deltaPoint := aRectangle width / 2 , scaleFactor , 0.
	aProjection := self displayProjection.
	aPoint := aProjection translateToPointFrom3dPoint: modelPoint.
	view3dPoint := aPoint x , aPoint y negated , aPoint z negated 
				scaledBy: scaleFactor.
	view3dPoint := view3dPoint translatedBy: deltaPoint.
	^view3dPoint
]

{ #category : #converting }
JunOpenGLDisplayModel >> convertModelPointToViewPoint: modelPoint in: aRectangle [ 
	| view3dPoint viewPoint |
	view3dPoint := self convertModelPointToView3dPoint: modelPoint
				in: aRectangle.
	viewPoint := view3dPoint x rounded @ view3dPoint y rounded.
	^viewPoint
]

{ #category : #converting }
JunOpenGLDisplayModel >> convertModelPointsToView3dPoints: modelPoints in: aRectangle [ 
	| view3dPoints |
	view3dPoints := modelPoints asArray collect: 
					[:p | 
					| view3dPoint |
					view3dPoint := self convertModelPointToView3dPoint: p in: aRectangle.
					view3dPoint yourself].
	^view3dPoints
]

{ #category : #converting }
JunOpenGLDisplayModel >> convertModelPointsToView3dPointsSortedByZ: modelPoints in: aRectangle [ 
	| viewPoints view3dPointsSortedByZ |
	viewPoints := self convertModelPointsToView3dPoints: modelPoints
				in: aRectangle.
	view3dPointsSortedByZ := OrderedCollection new.
	modelPoints with: viewPoints
		do: 
			[:modelPoint :viewPoint | 
			view3dPointsSortedByZ add: viewPoint z 
						-> (Array with: modelPoint with: viewPoint x @ viewPoint y)].
	view3dPointsSortedByZ := view3dPointsSortedByZ asSortedCollection.
	^view3dPointsSortedByZ
]

{ #category : #converting }
JunOpenGLDisplayModel >> convertModelPointsToViewPoints: modelPoints in: aRectangle [ 
	| viewPoints |
	viewPoints := modelPoints asArray collect: 
					[:p | 
					| viewPoint |
					viewPoint := self convertModelPointToViewPoint: p in: aRectangle.
					viewPoint yourself].
	^viewPoints
]

{ #category : #converting }
JunOpenGLDisplayModel >> convertViewPointToModelPoint: viewPoint in: aRectangle [ 
	| aProjection aPoint modelPoint |
	aProjection := self displayProjection.
	aPoint := Jun2dPoint 
				coerce: (self regularizePoint: viewPoint in: aRectangle).
	modelPoint := aProjection translateTo3dPointFromPoint: aPoint.
	^modelPoint
]

{ #category : #converting }
JunOpenGLDisplayModel >> convertViewPointsToModelPoints: viewPoints in: aRectangle [ 
	| modelPoints |
	modelPoints := viewPoints asArray collect: 
					[:p | 
					| modelPoint |
					modelPoint := self convertViewPointToModelPoint: p in: aRectangle.
					modelPoint yourself].
	^modelPoints
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> copyObject [
	JunSensorUtility shiftDown ifTrue: [^self projectionTableToCopyBuffer].
	self displayObject isNil ifTrue: [^self].
	JunCursorAnimator clockCursors showWhile: 
			[| object stream string |
			object := self spawningObject.
			stream := WriteStream on: (String new: 1024).
			stream nextPutAll: self defaultStampForLST10.
			object saveOn: stream.
			string := stream contents.
			string isEmpty ifFalse: [ParagraphEditor currentSelection: string]]
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> ctrlClick: pickedObject [ 
	^nil
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> cutObject [
	self selectedObjects isEmpty ifTrue: [^self].
	self displayObject isCompound ifFalse: [^self].
	JunCursorAnimator clockCursors
		showWhile: 
			[self copyObject.
			self selectedObjects do: [:each | self displayObject remove: each].
			self clearSelectedObjects.
			self changed: #object].
	self updateMenuIndication
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultBaseName [
	^self displayObject ifNil: [super defaultBaseName]
		ifNotNil: 
			[:object | 
			object rawName ifNil: [super defaultBaseName] ifNotNil: [:it | it yourself]]
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultDisplayViewClass [
	^JunOpenGLDisplayView
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultEyePoint [
	| box distance |
	self displayObject isNil ifTrue: [^10000 , 10000 , 10000].
	^self defaultProjectionTable at: #eyePoint
		ifAbsent: 
			[box := self boundingBox.
			distance := box origin distance: box corner.
			distance := distance * 2.
			^distance , distance , distance]
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultEyePoint: eyePoint [ 
	self defaultProjectionTable at: #eyePoint put: eyePoint
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultImageExtent [
	^256 @ 256
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultLightColor [
	^ColorValue brightness: 0.5
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultLightPoint [
	^0 , 0 , 1
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultPresentation [
	^self defaultProjectionTable at: #presentation ifAbsent: [^#solidPresentation]
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultPresentation: aSymbol [ 
	(#(#solidPresentation #wireframePresentation #hiddenlinePresentation) includes: aSymbol)
		ifFalse: [^nil].
	self defaultProjectionTable at: #presentation put: aSymbol
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultProjection [
	^self defaultProjectionTable at: #projection ifAbsent: [^#perspectiveProjection]
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultProjection: aSymbol [ 
	(#(#parallelProjection #perspectiveProjection) includes: aSymbol)
		ifFalse: [^nil].
	self defaultProjectionTable at: #projection put: aSymbol
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultProjectionTable [
	defaultProjectionTable isNil 
		ifTrue: [defaultProjectionTable := Dictionary new].
	^defaultProjectionTable
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultProjectionTable: aDictionary [ 
	| aTable |
	(aDictionary respondsTo: #asDictionary) 
		ifTrue: [aTable := aDictionary asDictionary]
		ifFalse: [aTable := aDictionary yourself].
	defaultProjectionTable := aTable
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultShading [
	^self defaultProjectionTable at: #shading ifAbsent: [^#smoothShading]
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultShading: aSymbol [ 
	(#(#flatShading #smoothShading) includes: aSymbol) ifFalse: [^nil].
	^self defaultProjectionTable at: #shading put: aSymbol
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultSightPoint [
	self displayObject isNil ifTrue: [^0 , 0 , 0].
	^self defaultProjectionTable at: #sightPoint ifAbsent: [^self boundingBox center]
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultSightPoint: sightPoint [ 
	self defaultProjectionTable at: #sightPoint put: sightPoint
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultStampForLST10 [
	"JunOpenGLDisplayModel new defaultStampForLST10."

	| aStream |
	aStream := WriteStream on: String new.
	aStream nextPutAll: '%LST V1.0 List Shape Transmission (Lisp S Expression)'.
	aStream cr.
	aStream nextPutAll: '% This file was created by ' , self class system , self class version.
	aStream cr.
	aStream nextPutAll: '% ' , (JunCalendarModel stringFromDateAndTime: Time dateAndTimeNow).
	aStream cr.
	aStream cr.
	^aStream contents
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultStampForWRL10 [
	"JunOpenGLDisplayModel new defaultStampForWRL10."

	| aStream |
	aStream := WriteStream on: String new.
	aStream nextPutAll: '#VRML V1.0 ascii'.
	aStream cr.
	aStream nextPutAll: '# This file was created by ' , self class system , self class version.
	aStream cr.
	aStream nextPutAll: '# ' , (JunCalendarModel stringFromDateAndTime: Time dateAndTimeNow).
	aStream cr.
	aStream cr.
	^aStream contents
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultStampForWRL20 [
	"JunOpenGLDisplayModel new defaultStampForWRL20."
	"(JunOpenGLDisplayModel displayObject: JunOpenGL3dObject cube) defaultStampForWRL20."

	| aStream |
	aStream := WriteStream on: String new.
	aStream nextPutAll: '#VRML V2.0 utf8'.
	aStream cr.
	aStream cr.
	aStream nextPutAll: 'WorldInfo {'.
	aStream cr.
	aStream tab.
	aStream nextPutAll: 'info ['.
	aStream cr.
	aStream tab; tab.
	aStream nextPutAll: '"This file was created by ' , self class system , self class version , '"'.
	aStream cr.
	aStream tab; tab.
	aStream nextPutAll: '"' , (JunCalendarModel stringFromDateAndTime: Time dateAndTimeNow) , '"'.
	aStream cr.
	aStream tab.
	aStream nextPutAll: ']'.
	aStream cr.
	aStream tab.
	aStream nextPutAll: 'title "'.
	self displayObject notNil ifTrue: [aStream nextPutAll: self displayObject name , ': '].
	aStream nextPutAll: 'Sample of ' , self class name asString , '"'.
	aStream cr.
	aStream nextPutAll: '}'.
	aStream cr.
	aStream cr.
	^aStream contents
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultStampForWRL97 [
	"JunOpenGLDisplayModel new defaultStampForWRL97."

	| aStream |
	aStream := WriteStream on: String new.
	aStream nextPutAll: '#VRML V2.0 utf8'.
	aStream cr.
	aStream nextPutAll: '# This file was created by ' , self class system , self class version.
	aStream cr.
	aStream nextPutAll: '# ' , (JunCalendarModel stringFromDateAndTime: Time dateAndTimeNow).
	aStream cr.
	aStream cr.
	^aStream contents
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultUpVector [
	^self defaultProjectionTable at: #upVector ifAbsent: [^-1 , -1 , 1]
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultUpVector: upVector [ 
	self defaultProjectionTable at: #upVector put: upVector
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultViewFactor [
	^self defaultProjectionTable at: #viewFactor ifAbsent: [^10]
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultViewFactor: viewFactor [ 
	self defaultProjectionTable at: #viewFactor put: viewFactor
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultWindowLabel [
	^self windowLabel
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultZoomHeight [
	^self defaultProjectionTable at: #zoomHeight ifAbsent: [^self defaultZoomHeightFactor]
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultZoomHeight: zoomHeight [ 
	self defaultProjectionTable at: #zoomHeight put: zoomHeight
]

{ #category : #defaults }
JunOpenGLDisplayModel >> defaultZoomHeightFactor [
	^2.4
]

{ #category : #displaying }
JunOpenGLDisplayModel >> display [
	self redisplay
]

{ #category : #lighting }
JunOpenGLDisplayModel >> displayLight1 [
	^self displayLights at: 1
]

{ #category : #lighting }
JunOpenGLDisplayModel >> displayLight2 [
	^self displayLights at: 2
]

{ #category : #lighting }
JunOpenGLDisplayModel >> displayLight3 [
	^self displayLights at: 3
]

{ #category : #lighting }
JunOpenGLDisplayModel >> displayLight4 [
	^self displayLights at: 4
]

{ #category : #lighting }
JunOpenGLDisplayModel >> displayLight5 [
	^self displayLights at: 5
]

{ #category : #lighting }
JunOpenGLDisplayModel >> displayLightCollection [
	| lightCollection t |
	lightCollection := OrderedCollection new.
	t := self displayProjection asEyeTransformation inverse.
	self displayLights do: [:displayLight | displayLight isOn ifTrue: [lightCollection add: (displayLight light transform: t)]].
	^lightCollection
]

{ #category : #lighting }
JunOpenGLDisplayModel >> displayLights [
	displayLights isNil 
		ifTrue: 
			[| lightCollection |
			lightCollection := Array new: 5.
			lightCollection at: 1
				put: (JunOpenGLDisplayLight 
						parallelLight: true
						color: self defaultLightColor
						position: self defaultLightPoint).
			lightCollection at: 2 put: JunOpenGLDisplayLight new.
			lightCollection at: 3 put: JunOpenGLDisplayLight new.
			lightCollection at: 4 put: JunOpenGLDisplayLight new.
			lightCollection at: 5
				put: (JunOpenGLDisplayLight ambientLight: true color: self defaultLightColor).
			self displayLights: lightCollection].
	^displayLights
]

{ #category : #lighting }
JunOpenGLDisplayModel >> displayLights: lightCollection [ 
	lightCollection size = 5 ifFalse: [^nil].
	(lightCollection 
		detect: [:light | (light isKindOf: JunOpenGLDisplayLight) not]
		ifNone: [nil]) isNil 
		ifFalse: [^nil].
	displayLights := lightCollection.
	displayLights do: 
			[:light | 
			light compute: 
					[:which | 
					self updateLightMenuIndication.
					self changed: #light]].
	displayLights 
		with: (Array 
				with: (#jun_Light1 >> 'Light1') asString
				with: (#jun_Light2 >> 'Light2') asString
				with: (#jun_Light3 >> 'Light3') asString
				with: (#jun_Light4 >> 'Light4') asString) 
					, (Array with: (#jun_Ambient >> 'Ambient') asString)
		do: [:light :string | light lightName: string].
	^displayLights
]

{ #category : #lighting }
JunOpenGLDisplayModel >> displayLightsAllOff [
	self displayLights do: [:aLight | aLight beOff].
	self updateLightMenuIndication.
	self changed: #light
]

{ #category : #'lisp support' }
JunOpenGLDisplayModel >> displayLightsToLispList [
	| list |
	list := self lispCons.
	list head: #displayLights.
	list tail: (self class defaultLispConsClass 
				list: (self displayLights collect: 
							[:each | 
							| collection |
							collection := OrderedCollection new.
							each toLispList do: 
									[:it | 
									((it respondsTo: #head) and: [it head = #lightName]) 
										ifFalse: [collection add: it]].
							(self class defaultLispConsClass list: collection) yourself])).
	^list
]

{ #category : #accessing }
JunOpenGLDisplayModel >> displayObject [
	^displayObject
]

{ #category : #accessing }
JunOpenGLDisplayModel >> displayObject: a3dObject [ 
	displayObject := a3dObject.
	self clearSelectedObjects.
	self updateMenuIndication.
	self showModel notNil ifTrue: [self showModel flushObject]
]

{ #category : #'lisp support' }
JunOpenGLDisplayModel >> displayObjectToLispList [
	| list |
	list := self lispCons.
	list head: #displayObject.
	list tail: self displayObject toLispList.
	^list
]

{ #category : #accessing }
JunOpenGLDisplayModel >> displayProjection [
	^self displayProjector projection
]

{ #category : #accessing }
JunOpenGLDisplayModel >> displayProjection: aProjection [ 
	self displayProjector projection: aProjection
]

{ #category : #accessing }
JunOpenGLDisplayModel >> displayProjector [
	displayProjector isNil 
		ifTrue: 
			[| aProjector |
			aProjector := JunOpenGLProjector new.
			self preCreateDisplayProjector: aProjector.
			aProjector
				setEyePoint: self defaultEyePoint;
				setSightPoint: self defaultSightPoint;
				setUpVector: self defaultUpVector;
				setViewFactor: self defaultViewFactor;
				setZoomHeight: self defaultZoomHeight;
				setProjection.
			aProjector presentation: self defaultPresentation.
			aProjector shading: self defaultShading.
			self defaultProjection = #parallelProjection 
				ifTrue: [aProjector parallelProjection]
				ifFalse: [aProjector perspectiveProjection].
			self postCreateDisplayProjector: aProjector.
			displayProjector := aProjector].
	^displayProjector
]

{ #category : #'interface opening' }
JunOpenGLDisplayModel >> displayView [
	| aView |
	aView := self defaultDisplayViewClass model: self.
	^aView
]

{ #category : #superimpose }
JunOpenGLDisplayModel >> doSuperimpose [
	| aView |
	aView := self getView.
	aView isNil ifTrue: [^nil].
	superimposeBlock notNil 
		ifTrue: 
			[| arguments |
			arguments := Array 
						with: self
						with: aView
						with: aView controller.
			superimposeBlock 
				valueWithArguments: (arguments copyFrom: 1 to: superimposeBlock numArgs)]
]

{ #category : #projection }
JunOpenGLDisplayModel >> dolly: factor [ 
	| dollyFactor aLine eyePoint sightPoint |
	InputState default shiftDown
		ifTrue: [dollyFactor := factor / 20]
		ifFalse: [dollyFactor := factor].
	aLine := Jun3dLine from: self eyePoint to: self sightPoint.
	eyePoint := aLine atT: 0.0 + dollyFactor.
	sightPoint := aLine atT: 1.0 + dollyFactor.
	self displayProjector eyePoint: eyePoint.
	self displayProjector sightPoint: sightPoint.
	self changed: #projection
]

{ #category : #buttons }
JunOpenGLDisplayModel >> dollyButton [
	| image figure shape button text pixmap gc index color |
	dollyButton isNil 
		ifTrue: 
			[text := 'd' asComposedText.
			pixmap := Pixmap extent: text bounds extent + (2 @ 2).
			gc := pixmap graphicsContext.
			gc paint: ColorValue white.
			gc displayRectangle: pixmap bounds.
			gc paint: ColorValue black.
			text displayOn: gc at: 1 @ 1.
			image := pixmap asImage.
			pixmap close.
			figure := Image 
						extent: image extent
						depth: 1
						palette: MappedPalette whiteBlack.
			(0 to: image width - 1) do: 
					[:x | 
					(0 to: image height - 1) do: 
							[:y | 
							index := image atX: x y: y.
							index := index bitAnd: image palette maxIndex.
							color := image palette at: index.
							color luminance > 0.5 
								ifTrue: 
									[figure 
										atX: x
										y: y
										put: 0]
								ifFalse: 
									[figure 
										atX: x
										y: y
										put: 1]]].
			pixmap := Pixmap extent: text bounds extent + (2 @ 2).
			gc := pixmap graphicsContext.
			gc paint: ColorValue white.
			gc displayRectangle: pixmap bounds.
			gc paint: ColorValue black.
			text displayOn: gc at: 1 @ 1.
			(Array 
				with: 0 @ 1
				with: 0 @ -1
				with: 1 @ 0
				with: -1 @ 0) do: [:p | text displayOn: gc at: 1 @ 1 + p].
			image := pixmap asImage.
			pixmap close.
			shape := Image 
						extent: image extent
						depth: 1
						palette: MappedPalette whiteBlack.
			(0 to: image width - 1) do: 
					[:x | 
					(0 to: image height - 1) do: 
							[:y | 
							index := image atX: x y: y.
							index := index bitAnd: image palette maxIndex.
							color := image palette at: index.
							color luminance > 0.5 
								ifTrue: 
									[shape 
										atX: x
										y: y
										put: 0]
								ifFalse: 
									[shape 
										atX: x
										y: y
										put: 1]]].
			shape := shape palette: CoveragePalette monoMaskPalette.
			image := OpaqueImage figure: figure shape: shape.
			button := JunButtonModel 
						value: false
						visual: image
						action: self dollyButtonAction.
			dollyButton := button].
	^dollyButton
]

{ #category : #buttons }
JunOpenGLDisplayModel >> dollyButtonAction [
	| actionBlock |
	actionBlock := [:model | model value: model value not].
	^actionBlock
]

{ #category : #'interface opening' }
JunOpenGLDisplayModel >> dollyButtonView [
	| view |
	view := JunButtonView new.
	view model: self dollyButton.
	^view
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> drag: from2dPoint xy: to2dPoint [ 
	| shiftDown |
	self displayObject isNil ifTrue: [^self].
	shiftDown := InputState default shiftDown.
	shiftDown
		ifTrue: [self look: from2dPoint xy: to2dPoint]
		ifFalse: [self slide: from2dPoint xy: to2dPoint]
]

{ #category : #buttons }
JunOpenGLDisplayModel >> dragButton [
	(self pushButtons includesKey: #drag) 
		ifFalse: 
			[| image figure shape button |
			image := JunCursors quartersCursor asOpaqueImage.
			figure := image figure asImage.
			shape := image shape asImage.
			image := OpaqueImage figure: figure shape: shape.
			button := JunButtonModel 
						value: false
						visual: image
						action: self dragButtonAction.
			self pushButtons at: #drag put: button].
	^self pushButtons at: #drag
]

{ #category : #buttons }
JunOpenGLDisplayModel >> dragButtonAction [
	| actionBlock |
	actionBlock := 
			[:model | 
			model value: model value not.
			model value 
				ifTrue: 
					[self focusButton value: false.
					self grabButton value: false.
					self pickButton value: false].
			self changed: #state].
	^actionBlock
]

{ #category : #'interface opening' }
JunOpenGLDisplayModel >> dragButtonView [
	| view |
	view := JunButtonView new.
	view model: self dragButton.
	^view
]

{ #category : #projection }
JunOpenGLDisplayModel >> eyePoint [
	^self displayProjector eyePoint
]

{ #category : #projection }
JunOpenGLDisplayModel >> eyePoint: a3dPoint [ 
	self displayProjector eyePoint: a3dPoint.
	self changed: #projection
]

{ #category : #projection }
JunOpenGLDisplayModel >> fit [
	self displayObject isNil ifTrue: [^self].
	JunCursorAnimator clockCursors
		showWhile: 
			[self fitSilently.
			self useDisplayList
				ifTrue: [self changed: #object]
				ifFalse: [self changed: #projection]]
]

{ #category : #projection }
JunOpenGLDisplayModel >> fitSight [
	| sightPoint |
	self displayObject isNil ifTrue: [^self].
	JunCursorAnimator clockCursors
		showWhile: 
			[sightPoint := self computeSightPoint.
			self sightPoint: sightPoint]
]

{ #category : #projection }
JunOpenGLDisplayModel >> fitSilently [
	| sightPoint zoomHeight |
	self displayObject isNil ifTrue: [^self].
	JunCursorAnimator clockCursors
		showWhile: 
			[sightPoint := self computeSightPoint.
			self displayProjector sightPoint: sightPoint.
			zoomHeight := self computeZoomHeight.
			self displayProjector zoomHeight: zoomHeight]
]

{ #category : #projection }
JunOpenGLDisplayModel >> fitZoom [
	| zoomHeight |
	self displayObject isNil ifTrue: [^self].
	JunCursorAnimator clockCursors
		showWhile: 
			[zoomHeight := self computeZoomHeight.
			self zoomHeight: zoomHeight]
]

{ #category : #shading }
JunOpenGLDisplayModel >> flatShading [
	self displayProjector flatShading.
	self updateViewMenuIndication.
	self changed: #shading
]

{ #category : #flushing }
JunOpenGLDisplayModel >> flushDisplayLights [
	displayLights := nil
]

{ #category : #flushing }
JunOpenGLDisplayModel >> flushDisplayObject [
	displayObject := nil
]

{ #category : #flushing }
JunOpenGLDisplayModel >> flushDisplayProjector [
	displayProjector := nil
]

{ #category : #flushing }
JunOpenGLDisplayModel >> flushLights [
	self flushDisplayLights
]

{ #category : #flushing }
JunOpenGLDisplayModel >> flushMovementVector [
	self getView ifNotNil: [:aView | aView controller flushMovementVector]
]

{ #category : #flushing }
JunOpenGLDisplayModel >> flushProjector [
	self flushDisplayProjector
]

{ #category : #flushing }
JunOpenGLDisplayModel >> flushSelectedObjects [
	selectedObjects := nil
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> focus: aRectangle1 to: aRectangle2 [ 
	| originalRectangle newRectangle aProjection originalCenter newCenter originalTop originalBottom originalLeft originalRight originalHeight originalWidth newTop newBottom newLeft newRight newHeight newWidth newViewHeight newViewWidth tmpViewHeight newZoomHeight |
	InputState default shiftDown 
		ifTrue: 
			[originalRectangle := aRectangle2.
			newRectangle := aRectangle1]
		ifFalse: 
			[originalRectangle := aRectangle1.
			newRectangle := aRectangle2].
	self displayObject isNil ifTrue: [^self].
	aProjection := self displayProjection.
	originalCenter := aProjection 
				translateTo3dPointFromPoint: (originalRectangle origin 
						+ originalRectangle corner) / 2.0d.
	newCenter := aProjection 
				translateTo3dPointFromPoint: (newRectangle origin + newRectangle corner) 
						/ 2.0d.
	aProjection 
		sightPoint: aProjection sightPoint + (newCenter - originalCenter).
	originalTop := aProjection 
				translateTo3dPointFromPoint: 0 , originalRectangle origin y.
	originalBottom := aProjection 
				translateTo3dPointFromPoint: 0 , originalRectangle corner y.
	originalLeft := aProjection 
				translateTo3dPointFromPoint: originalRectangle origin x , 0.
	originalRight := aProjection 
				translateTo3dPointFromPoint: originalRectangle corner x , 0.
	originalHeight := (originalTop - originalBottom) length.
	originalWidth := (originalLeft - originalRight) length.
	newTop := aProjection 
				translateTo3dPointFromPoint: 0 , newRectangle origin y.
	newBottom := aProjection 
				translateTo3dPointFromPoint: 0 , newRectangle corner y.
	newLeft := aProjection 
				translateTo3dPointFromPoint: newRectangle origin x , 0.
	newRight := aProjection 
				translateTo3dPointFromPoint: newRectangle corner x , 0.
	newHeight := (newTop - newBottom) length.
	newWidth := (newLeft - newRight) length.
	newViewHeight := aProjection regularHeight * newHeight / originalHeight.
	newViewWidth := newViewHeight * newWidth / newHeight.
	originalWidth / originalHeight * newViewHeight < newViewWidth 
		ifTrue: 
			[tmpViewHeight := originalWidth / originalHeight 
						* (newViewHeight / newViewWidth).
			newZoomHeight := newViewHeight / tmpViewHeight]
		ifFalse: [newZoomHeight := newViewHeight].
	(originalHeight * 0.01d < newHeight 
		and: [newHeight * 0.01d < originalHeight]) 
			ifTrue: [aProjection zoomHeight: newZoomHeight].
	self displayProjection: aProjection.
	self changed: #projection
]

{ #category : #buttons }
JunOpenGLDisplayModel >> focusButton [
	(self pushButtons includesKey: #focus) 
		ifFalse: 
			[| image figure shape button |
			image := JunCursors glassCursor asOpaqueImage.
			figure := image figure asImage.
			shape := image shape asImage.
			image := OpaqueImage figure: figure shape: shape.
			button := JunButtonModel 
						value: false
						visual: image
						action: self focusButtonAction.
			self pushButtons at: #focus put: button].
	^self pushButtons at: #focus
]

{ #category : #buttons }
JunOpenGLDisplayModel >> focusButtonAction [
	| actionBlock |
	actionBlock := 
			[:model | 
			model value: model value not.
			model value 
				ifTrue: 
					[self grabButton value: false.
					self dragButton value: false.
					self pickButton value: false].
			self changed: #state].
	^actionBlock
]

{ #category : #'interface opening' }
JunOpenGLDisplayModel >> focusButtonView [
	| view |
	view := JunButtonView new.
	view model: self focusButton.
	^view
]

{ #category : #private }
JunOpenGLDisplayModel >> getCollection: numberOfValues centerValue: centerValue fromValue: fromValue toValue: toValue [ 
	"JunOpenGLDisplayModel new getCollection: 10 centerValue: 0,0,0 fromValue: 2,0,0 toValue: 1,1,0."

	| howMany aDistance stepValue aStream aValue aLine theValue |
	howMany := numberOfValues - 1.
	aDistance := centerValue distance: fromValue.
	aLine := Jun3dLine from: centerValue to: toValue.
	aLine := aLine normalizedLine.
	stepValue := (aLine atT: aDistance)
				- fromValue / howMany.
	aStream := (Array new: numberOfValues) writeStream.
	aValue := fromValue.
	aStream nextPut: aValue.
	1 to: howMany
		do: 
			[:n | 
			aValue := aValue + stepValue.
			aLine := Jun3dLine from: centerValue to: aValue.
			aLine := aLine normalizedLine.
			theValue := aLine atT: aDistance.
			aStream nextPut: theValue].
	^aStream contents
]

{ #category : #private }
JunOpenGLDisplayModel >> getCollection: numberOfValues fromValue: fromValue toValue: toValue [ 
	"JunOpenGLDisplayModel new getCollection: 10 fromValue: 2,0,0 toValue: 1,1,0."

	| howMany stepValue aStream aValue |
	howMany := numberOfValues - 1.
	stepValue := toValue - fromValue / howMany.
	aStream := (Array new: numberOfValues) writeStream.
	aValue := fromValue.
	aStream nextPut: aValue.
	1 to: howMany
		do: 
			[:n | 
			aValue := aValue + stepValue.
			aStream nextPut: aValue].
	^aStream contents
]

{ #category : #private }
JunOpenGLDisplayModel >> grab3dPoint: aPoint [ 
	| projection handleSphere prj line candidates |
	projection := self displayProjection.
	handleSphere := self grabSphere.
	prj := projection asParallelProjection.
	line := Jun3dLine from: (prj translateTo3dPointInNearBoundaryPlaneFromPoint: aPoint)
				to: (prj translateTo3dPointInFarBoundaryPlaneFromPoint: aPoint).
	candidates := handleSphere crossPointsWithLine: line.
	^candidates isEmpty
		ifTrue: [prj translateTo3dPointFromPoint: aPoint]
		ifFalse: [candidates first]
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> grab: deltaPoint [ 
	| fromPoint toPoint |
	self displayObject isNil ifTrue: [^self].
	fromPoint := 0 , 0.
	InputState default shiftDown
		ifTrue: [toPoint := deltaPoint x / 10 , (deltaPoint y / 10)]
		ifFalse: [toPoint := deltaPoint x , deltaPoint y].
	self grab: fromPoint xy: toPoint
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> grab: from2dPoint xy: to2dPoint [ 
	| aProjection grabSphere centerPoint fromPoint toPoint rotationAngle |
	self displayObject isNil ifTrue: [^self].
	aProjection := self displayProjection.
	grabSphere := self grabSphere.
	centerPoint := grabSphere center.
	fromPoint := self grab3dPoint: from2dPoint x , from2dPoint y.
	toPoint := self grab3dPoint: to2dPoint x , to2dPoint y.
	rotationAngle := (Jun3dLine from: centerPoint to: toPoint) 
				angleWithLine: (Jun3dLine from: centerPoint to: fromPoint).
	rotationAngle rad abs > self thetaAccuracy 
		ifTrue: 
			[| rotationAxis transformation transformationInv upPoint |
			rotationAxis := Jun3dLine from: centerPoint
						to: centerPoint - (fromPoint - centerPoint product: toPoint - centerPoint).
			transformation := Jun3dTransformation rotate: rotationAngle
						around: rotationAxis.
			transformationInv := Jun3dTransformation rotate: rotationAngle negated
						around: rotationAxis.
			upPoint := aProjection sightPoint + aProjection unitUpVector.
			aProjection eyePoint: (transformationInv applyTo: aProjection eyePoint).
			aProjection 
				upVector: (transformation applyTo: upPoint) - aProjection sightPoint.
			self displayProjection: aProjection.
			self changed: #projection]
]

{ #category : #buttons }
JunOpenGLDisplayModel >> grabButton [
	(self pushButtons includesKey: #grab) 
		ifFalse: 
			[| image figure shape button |
			image := JunCursors handCursor asOpaqueImage.
			figure := image figure asImage.
			shape := image shape asImage.
			image := OpaqueImage figure: figure shape: shape.
			button := JunButtonModel 
						value: false
						visual: image
						action: self grabButtonAction.
			self pushButtons at: #grab put: button].
	^self pushButtons at: #grab
]

{ #category : #buttons }
JunOpenGLDisplayModel >> grabButtonAction [
	| actionBlock |
	actionBlock := 
			[:model | 
			model value: model value not.
			model value 
				ifTrue: 
					[self focusButton value: false.
					self dragButton value: false.
					self pickButton value: false].
			self changed: #state].
	^actionBlock
]

{ #category : #'interface opening' }
JunOpenGLDisplayModel >> grabButtonView [
	| view |
	view := JunButtonView new.
	view model: self grabButton.
	^view
]

{ #category : #private }
JunOpenGLDisplayModel >> grabSphere [
	| projection grabSphere |
	projection := self displayProjection.
	grabSphere := JunSphereSurface center: projection sightPoint radius: projection regularHeight / 2.
	^grabSphere
]

{ #category : #'texture mapping' }
JunOpenGLDisplayModel >> hasTextureMapping [
	| aBoolean aTexture |
	aBoolean := false.
	self displayObject isNil ifTrue: [^aBoolean].
	self displayObject objectsDo: 
			[:each | 
			aTexture := each texture.
			aTexture notNil ifTrue: [aBoolean := true]].
	^aBoolean
]

{ #category : #presentation }
JunOpenGLDisplayModel >> hiddenlinePresentation [
	self displayProjector hiddenlinePresentation.
	self updateViewMenuIndication.
	self changed: #presentation
]

{ #category : #'initialize-release' }
JunOpenGLDisplayModel >> initialize [
	super initialize.
	displayObject := nil.
	displayLights := nil.
	displayProjector := nil.
	selectedObjects := nil.
	pushButtons := nil.
	dollyButton := nil.
	defaultProjectionTable := nil.
	superimposeBlock := nil.
	preferenceTable := nil
]

{ #category : #testing }
JunOpenGLDisplayModel >> isEmpty [
	^self displayObject isNil or: [self displayObject isCompound and: [self displayObject components isEmpty]]
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> lineSmooth [
	self displayProjector lineSmooth: self displayProjector lineSmooth not.
	self updateViewMenuIndication.
	self changed: #smoothing
]

{ #category : #'texture mapping' }
JunOpenGLDisplayModel >> linear [
	| aBoolean aTexture |
	aBoolean := false.
	self displayObject isNil ifTrue: [^aBoolean].
	self displayObject objectsDo: 
			[:each | 
			aTexture := each texture.
			aTexture notNil ifTrue: [aBoolean := aTexture linear]].
	^aBoolean
]

{ #category : #reading }
JunOpenGLDisplayModel >> loadFromLST10: stream [ 
	"
	| file stream object | 
	(file := JunFileDialog request) isNil ifTrue: [^nil].
	stream := file readStream. 
	[object := JunOpenGLDisplayModel new loadFromLST10: stream] 
		valueNowOrOnUnwindDo: [stream close]. 
	object isNil ifTrue: [^nil]. 
	object show. 
	^object 
	"

	| object position string message |
	object := nil.
	Cursor read
		showWhile: 
			[position := stream position.
			string := stream next: 10.
			(string copyFrom: 1 to: (10 min: string size))
				= (self defaultStampForLST10 copyFrom: 1 to: 10)
				ifTrue: 
					[stream position: position.
					Object errorSignal
						handle: 
							[:exception | 
							object := nil.
							JunDialog warn: (stream displayString contractTo: 40) printString , (#jun__can_not_read_ >> ' can not read.') asString.
							exception return]
						do: [object := JunOpenGL3dObject loadFrom: stream]]
				ifFalse: 
					[message := WriteStream on: String new.
					message nextPutAll: (stream displayString contractTo: 40) printString.
					message nextPutAll: ((#jun__may_not_be__1s__ >> ' may not be <1s>.') asString expandMacrosWith: 'LST').
					message cr.
					message nextPutAll: (#jun_Do_you_want_to_proceed_ >> 'Do you want to proceed?') asString.
					(JunDialog confirm: message contents initialAnswer: false)
						ifTrue: 
							[stream position: position.
							Object errorSignal
								handle: 
									[:exception | 
									object := nil.
									JunDialog warn: (stream displayString contractTo: 40) printString , (#jun__can_not_read_ >> ' can not read.') asString.
									exception return]
								do: [object := JunOpenGL3dObject loadFrom: stream]]]].
	^object
]

{ #category : #reading }
JunOpenGLDisplayModel >> loadFromLST: stream [ 
	"
	| file stream object | 
	(file := JunFileDialog request) isNil ifTrue: [^nil].
	stream := file readStream. 
	[object := JunOpenGLDisplayModel new loadFromLST: stream] 
		valueNowOrOnUnwindDo: [stream close]. 
	object isNil ifTrue: [^nil]. 
	object show. 
	^object 
	"

	^self loadFromLST10: stream
]

{ #category : #reading }
JunOpenGLDisplayModel >> loadFromWRL10: stream [ 
	"
	| file stream displayModel | 
	(file := JunFileDialog request) isNil ifTrue: [^nil].
	stream := file readStream. 
	[displayModel := JunOpenGLDisplayModel new. 
	displayModel loadFromWRL10: stream] 
		valueNowOrOnUnwindDo: [stream close]. 
	displayModel displayObject isNil ifTrue: [^nil].
	displayModel open. 
	^displayModel 
	"

	| string |
	Cursor read showWhile: [Object errorSignal
			handle: 
				[:exception | 
				string := stream displayString.
				(string isEmpty not and: [(string copyFrom: (string size - 2 max: 1)
						to: string size) asLowercase = 'wrl'])
					ifTrue: [JunDialog warn: (stream displayString contractTo: 40) printString , (#jun__may_not_be__1s__ >> ' may not be <1s>.' expandMacrosWith: 'VRML-1.0')]
					ifFalse: [JunDialog warn: (stream displayString contractTo: 40) printString , (#jun__can_not_read_ >> ' can not read.') asString].
				exception return]
			do: [JunVrmlCompiler
					sourceStream: stream
					parser: JunVrmlParser10
					generator: JunVrmlGenerator10
					displayModel: self]].
	^self
]

{ #category : #reading }
JunOpenGLDisplayModel >> loadFromWRL20: stream [ 
	"
	| file stream displayModel | 
	(file := JunFileDialog request) isNil ifTrue: [^nil].
	stream := file readStream. 
	[displayModel := JunOpenGLDisplayModel new loadFromWRL20: stream] 
		valueNowOrOnUnwindDo: [stream close]. 
	displayModel displayObject isNil ifTrue: [^nil].
	displayModel open. 
	^displayModel 
	"

	| string |
	Cursor read showWhile: [Object errorSignal
			handle: 
				[:exception | 
				string := stream displayString.
				(string isEmpty not and: [(string copyFrom: (string size - 2 max: 1)
						to: string size) asLowercase = 'wrl'])
					ifTrue: [JunDialog warn: (stream displayString contractTo: 40) printString , (#jun__may_not_be__1s__ >> ' may not be <1s>.' expandMacrosWith: 'VRML-2.0')]
					ifFalse: [JunDialog warn: (stream displayString contractTo: 40) printString , (#jun__can_not_read_ >> ' can not read.') asString].
				exception return]
			do: [JunVrmlCompiler
					sourceStream: stream
					parser: JunVrmlParser97
					generator: JunVrmlGenerator97
					displayModel: self]].
	^self
]

{ #category : #reading }
JunOpenGLDisplayModel >> loadFromWRL97: stream [ 
	"
	| file stream displayModel | 
	(file := JunFileDialog request) isNil ifTrue: [^nil]. 
	stream := file readStream. 
	[displayModel := JunOpenGLDisplayModel new 
	loadFromWRL97: stream] 
	valueNowOrOnUnwindDo: [stream close]. 
	displayModel displayObject isNil ifTrue: [^nil]. 
	displayModel open. 
	^displayModel 
	"

	| string |
	Cursor read showWhile: [Object errorSignal
			handle: 
				[:exception | 
				string := stream displayString.
				(string isEmpty not and: [(string copyFrom: (string size - 2 max: 1)
						to: string size) asLowercase = 'wrl'])
					ifTrue: [JunDialog warn: (stream displayString contractTo: 40) printString , (#jun__may_not_be__1s__ >> ' may not be <1s>.' expandMacrosWith: 'VRML-2.0')]
					ifFalse: [JunDialog warn: (stream displayString contractTo: 40) printString , (#jun__can_not_read_ >> ' can not read.') asString].
				exception return]
			do: [JunVrmlCompiler
					sourceStream: stream
					parser: JunVrmlParser97
					generator: JunVrmlGenerator97
					displayModel: self]].
	^self
]

{ #category : #reading }
JunOpenGLDisplayModel >> loadFromWRL: stream [ 
	"
	| file stream displayModel | 
	(file := JunFileDialog request) isNil ifTrue: [^nil]. 
	stream := file readStream. 
	[displayModel := JunOpenGLDisplayModel new 
	loadFromWRL: stream] 
	valueNowOrOnUnwindDo: [stream close]. 
	displayModel displayObject isNil ifTrue: [^nil]. 
	displayModel open. 
	^displayModel 
	"

	^self loadFromWRL97: stream
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> look: from2dPoint xy: to2dPoint [ 
	| aProjection fromPoint toPoint |
	self displayObject isNil ifTrue: [^self].
	aProjection := self displayProjection.
	fromPoint := aProjection translateTo3dPointFromPoint: from2dPoint x , from2dPoint y.
	toPoint := aProjection translateTo3dPointFromPoint: to2dPoint x , to2dPoint y.
	aProjection eyePoint: aProjection eyePoint - (toPoint - fromPoint).
	self displayProjection: aProjection.
	self changed: #projection
]

{ #category : #'texture mapping' }
JunOpenGLDisplayModel >> mipmap [
	| aBoolean aTexture |
	aBoolean := false.
	self displayObject isNil ifTrue: [^aBoolean].
	self displayObject objectsDo: 
			[:each | 
			aTexture := each texture.
			aTexture notNil ifTrue: [aBoolean := aTexture mipmap]].
	^aBoolean
]

{ #category : #'texture mapping' }
JunOpenGLDisplayModel >> modulate [
	| aBoolean aTexture |
	aBoolean := false.
	self displayObject isNil ifTrue: [^aBoolean].
	self displayObject objectsDo: 
			[:each | 
			aTexture := each texture.
			aTexture notNil ifTrue: [aBoolean := aTexture modulate]].
	^aBoolean
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> movementVector [
	^self getController ifNil: [nil]
		ifNotNil: [:aController | aController movementVector]
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> movementVector: aPoint [ 
	self getController ifNotNil: 
			[:aController | 
			self 
				assert: [aController flushMovementVector]
				do: [aController movementVector: aPoint]
				ensure: [aController createMovementProcess]]
]

{ #category : #'texture mapping' }
JunOpenGLDisplayModel >> nearest [
	^self linear not
]

{ #category : #preferences }
JunOpenGLDisplayModel >> noControl [
	^self preferenceTable at: #noControl ifAbsentPut: [false]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> noControl: aBoolean [ 
	self preferenceTable at: #noControl put: aBoolean = true
]

{ #category : #'interface closing' }
JunOpenGLDisplayModel >> noticeOfWindowClose: aWindow [ 
	super noticeOfWindowClose: aWindow.
	ScheduledControllers scheduledControllers
		do: 
			[:controller | 
			(self displayLights detect: [:each | each == controller model]
				ifNone: [nil]) isNil ifFalse: [controller sensor eventQuit: nil].
			(self showModel notNil and: [controller model == self showModel])
				ifTrue: [controller sensor eventQuit: nil]]
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> openLST [
	self openLST10
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> openLST10 [
	| labels values menu message file object model |
	labels := Array with: (Array 
						with: (#jun__1s__files >> '<1s> files' expandMacrosWith: 'LST')).
	values := Array with: #('*.lst' '*.LST').
	menu := Menu labelList: labels values: values.
	message := #jun_Select_a__1s__file_ >> 'Select a <1s> file.' 
				expandMacrosWith: 'LST'.
	file := JunFileRequesterDialog 
				requestFilename: message
				initialFilename: nil
				fileTypeMenu: menu
				initialFileType: values first.
	file isNil ifTrue: [^self].
	object := self readFromLST10: file.
	object isNil ifTrue: [^self].
	self displayObject: object.
	self resetView.
	(model := self showModel) isNil ifFalse: [model resetView]
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> openLight1 [
	| displayLight window |
	displayLight := self displayLight1.
	(displayLight builder notNil 
		and: [(window := displayLight builder window) isOpen]) 
			ifTrue: 
				[window isCollapsed ifTrue: [window expand].
				window raise]
			ifFalse: 
				[displayLight openInterface: #windowSpecForPositionLight.
				window := displayLight getWindow.
				window label: #jun_Light1 >> 'Light1']
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> openLight2 [
	| displayLight window |
	displayLight := self displayLight2.
	(displayLight builder notNil 
		and: [(window := displayLight builder window) isOpen]) 
			ifTrue: 
				[window isCollapsed ifTrue: [window expand].
				window raise]
			ifFalse: 
				[displayLight openInterface: #windowSpecForPositionLight.
				window := displayLight getWindow.
				window label: #jun_Light2 >> 'Light2']
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> openLight3 [
	| displayLight window |
	displayLight := self displayLight3.
	(displayLight builder notNil 
		and: [(window := displayLight builder window) isOpen]) 
			ifTrue: 
				[window isCollapsed ifTrue: [window expand].
				window raise]
			ifFalse: 
				[displayLight openInterface: #windowSpecForPositionLight.
				window := displayLight getWindow.
				window label: #jun_Light3 >> 'Light3']
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> openLight4 [
	| displayLight window |
	displayLight := self displayLight4.
	(displayLight builder notNil 
		and: [(window := displayLight builder window) isOpen]) 
			ifTrue: 
				[window isCollapsed ifTrue: [window expand].
				window raise]
			ifFalse: 
				[displayLight openInterface: #windowSpecForPositionLight.
				window := displayLight getWindow.
				window label: #jun_Light4 >> 'Light4']
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> openLight5 [
	| displayLight window |
	displayLight := self displayLight5.
	(displayLight builder notNil 
		and: [(window := displayLight builder window) isOpen]) 
			ifTrue: 
				[window isCollapsed ifTrue: [window expand].
				window raise]
			ifFalse: 
				[displayLight openInterface: #windowSpecForAmbientLight.
				window := displayLight getWindow.
				window label: #jun_Ambient >> 'Ambient']
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> openWRL10 [
	| labels values menu message file model |
	labels := Array with: (Array 
						with: (#jun__1s__files >> '<1s> files' expandMacrosWith: 'VRML')).
	values := Array with: #('*.wrl' '*.WRL').
	menu := Menu labelList: labels values: values.
	message := #jun_Select_a__1s__file_ >> 'Select a <1s> file.' 
				expandMacrosWith: 'WRL'.
	file := JunFileRequesterDialog 
				requestFilename: message
				initialFilename: nil
				fileTypeMenu: menu
				initialFileType: values first.
	file isNil ifTrue: [^self].
	self readFromWRL10: file.
	self resetView.
	(model := self showModel) isNil ifFalse: [model resetView]
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> openWRL20 [
	| labels values menu message file model |
	labels := Array with: (Array 
						with: (#jun__1s__files >> '<1s> files' expandMacrosWith: 'VRML')).
	values := Array with: #('*.wrl' '*.WRL').
	menu := Menu labelList: labels values: values.
	message := #jun_Select_a__1s__file_ >> 'Select a <1s> file.' 
				expandMacrosWith: 'WRL'.
	file := JunFileRequesterDialog 
				requestFilename: message
				initialFilename: nil
				fileTypeMenu: menu
				initialFileType: values first.
	file isNil ifTrue: [^self].
	self readFromWRL20: file.
	self resetView.
	(model := self showModel) isNil ifFalse: [model resetView]
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> openWRL97 [
	| labels values menu message file |
	labels := Array with: (Array 
						with: (#jun__1s__files >> '<1s> files' expandMacrosWith: 'VRML')).
	values := Array with: #('*.wrl' '*.WRL').
	menu := Menu labelList: labels values: values.
	message := #jun_Select_a__1s__file_ >> 'Select a <1s> file.' 
				expandMacrosWith: 'WRL'.
	file := JunFileRequesterDialog 
				requestFilename: message
				initialFilename: nil
				fileTypeMenu: menu
				initialFileType: values first.
	file isNil ifTrue: [^self].
	self readFromWRL97: file.
	self changed: #projection
]

{ #category : #projection }
JunOpenGLDisplayModel >> pan [
	^self zoom: 1 / 2
]

{ #category : #projection }
JunOpenGLDisplayModel >> parallelProjection [
	self displayProjector parallelProjection.
	self updateViewMenuIndication.
	self changed: #projection
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> pasteObject [
	| string stream object |
	JunSensorUtility shiftDown ifTrue: [^self projectionTableFromCopyBuffer].
	string := ParagraphEditor currentSelection asString.
	string isEmpty ifTrue: [^self].
	(string copyFrom: 1 to: (10 min: string size))
		= (self defaultStampForLST10 copyFrom: 1 to: 10) ifFalse: [^JunDialog warn: ((#jun_The_contents_of_copy_buffer_is_not__1s__ >> 'The contents of copy buffer is not <1s>.') asString expandMacrosWith: 'LST')].
	JunCursorAnimator clockCursors
		showWhile: 
			[stream := ReadStream on: string.
			object := JunOpenGL3dObject loadFrom: stream.
			self displayObject isNil
				ifTrue: 
					[self displayObject: object.
					self clearSelectedObjects.
					self addSelectedObject: object.
					self resetView]
				ifFalse: [self displayObject isCompound
						ifTrue: 
							[self displayObject add: object.
							self clearSelectedObjects.
							self addSelectedObject: object.
							self changed: #object]
						ifFalse: 
							[object := JunOpenGL3dCompoundObject with: self displayObject with: object.
							self displayObject: object.
							self clearSelectedObjects.
							self addSelectedObject: object.
							self changed: #object]]].
	self updateMenuIndication
]

{ #category : #projection }
JunOpenGLDisplayModel >> perspectiveProjection [
	self displayProjector perspectiveProjection.
	self updateViewMenuIndication.
	self changed: #projection
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> pick: aPoint [ 
	| pickedObject shiftDown controlDown altDown |
	self displayObject isNil ifTrue: [^nil].
	self displayObject isPrimitive ifTrue: [^nil].
	pickedObject := JunOpenGLObjectPicker
				pickObjectAt: aPoint
				fromCompound: self displayObject
				projection: self displayProjection.
	pickedObject isNil
		ifTrue: 
			[self selectedObjects isEmpty
				ifFalse: 
					[self clearSelectedObjects.
					self changed: #selection].
			self updateMenuIndication.
			^nil]
		ifFalse: 
			[shiftDown := InputState default shiftDown.
			shiftDown = true
				ifTrue: [(self selectedObjects includes: pickedObject)
						ifTrue: 
							[self removeSelectedObject: pickedObject.
							self changed: #selection]
						ifFalse: 
							[self addSelectedObject: pickedObject.
							self changed: #selection]]
				ifFalse: 
					[controlDown := InputState default ctrlDown.
					controlDown = true
						ifTrue: [self ctrlClick: pickedObject]
						ifFalse: 
							[altDown := InputState default altDown.
							altDown = true
								ifTrue: [self altClick: pickedObject]
								ifFalse: 
									[self clearSelectedObjects.
									self addSelectedObject: pickedObject.
									self changed: #selection]]].
			self updateMenuIndication.
			^pickedObject]
]

{ #category : #buttons }
JunOpenGLDisplayModel >> pickButton [
	(self pushButtons includesKey: #pick) 
		ifFalse: 
			[| button |
			button := JunButtonModel 
						value: false
						visual: self class pickNormalImage
						action: self pickButtonAction.
			self pushButtons at: #pick put: button].
	^self pushButtons at: #pick
]

{ #category : #buttons }
JunOpenGLDisplayModel >> pickButtonAction [
	| actionBlock |
	actionBlock := 
			[:model | 
			model value: model value not.
			model value 
				ifTrue: 
					[self focusButton value: false.
					self dragButton value: false.
					self grabButton value: false].
			self changed: #state].
	^actionBlock
]

{ #category : #'interface opening' }
JunOpenGLDisplayModel >> pickButtonView [
	| view |
	view := JunButtonView new.
	view model: self pickButton.
	^view
]

{ #category : #enumerating }
JunOpenGLDisplayModel >> pointsDo: aBlock [ 
	self displayObject isNil ifTrue: [^self].
	^self displayObject pointsDo: aBlock
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> polygonSmooth [
	self displayProjector polygonSmooth: self displayProjector polygonSmooth not.
	self updateViewMenuIndication.
	self changed: #smoothing
]

{ #category : #'interface opening' }
JunOpenGLDisplayModel >> postBuildWith: aBuilder [ 
	super postBuildWith: aBuilder.
	self flushProjector.
	self projectionTable: self defaultProjectionTable.
	((self defaultProjectionTable includesKey: #sightPoint) 
		and: [self defaultProjectionTable includesKey: #zoomHeight]) 
			ifFalse: [self fitSilently]
]

{ #category : #accessing }
JunOpenGLDisplayModel >> postCreateDisplayProjector: aProjector [ 
	^aProjector
]

{ #category : #projection }
JunOpenGLDisplayModel >> postGetProjectionTable: aDictionary [ 
	^aDictionary
]

{ #category : #projection }
JunOpenGLDisplayModel >> postPutProjectionTable: aDictionary into: aProjector [ 
	^aDictionary
]

{ #category : #accessing }
JunOpenGLDisplayModel >> preCreateDisplayProjector: aProjector [ 
	^aProjector
]

{ #category : #projection }
JunOpenGLDisplayModel >> preGetProjectionTable: aDictionary [ 
	^aDictionary
]

{ #category : #projection }
JunOpenGLDisplayModel >> prePutProjectionTable: aDictionary into: aProjector [ 
	^aDictionary
]

{ #category : #preferences }
JunOpenGLDisplayModel >> preferenceTable [
	preferenceTable ifNil: [preferenceTable := JunAttributeTable new].
	^preferenceTable
]

{ #category : #preferences }
JunOpenGLDisplayModel >> preferenceTable: aTable [ 
	(aTable isKindOf: JunAttributeTable) 
		ifTrue: [preferenceTable := aTable]
		ifFalse: 
			[(aTable isKindOf: Dictionary) 
				ifTrue: [preferenceTable := JunAttributeTable fromDictionary: aTable]]
]

{ #category : #'lisp support' }
JunOpenGLDisplayModel >> preferenceTableToLispList [
	| list |
	list := self lispCons.
	list head: #preferenceTable.
	list tail: self preferenceTable toLispList.
	^list
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> press: a2dPoint [ 
	| aProjection aPoint |
	aProjection := self displayProjection.
	aPoint := aProjection translateTo3dPointFromPoint: a2dPoint x , a2dPoint y.
	JunSensorUtility shiftDown 
		ifTrue: 
			[Transcript
				cr;
				show: 'press: ' , aPoint printString].
	^aPoint
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> pressBegin: a2dPoint [ 
	| aProjection aPoint |
	aProjection := self displayProjection.
	aPoint := aProjection translateTo3dPointFromPoint: a2dPoint x , a2dPoint y.
	JunSensorUtility shiftDown 
		ifTrue: 
			[Transcript
				cr;
				show: 'begin: ' , aPoint printString].
	^aPoint
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> pressEnd: a2dPoint [ 
	| aProjection aPoint |
	aProjection := self displayProjection.
	aPoint := aProjection translateTo3dPointFromPoint: a2dPoint x , a2dPoint y.
	JunSensorUtility shiftDown 
		ifTrue: 
			[Transcript
				cr;
				show: 'end: ' , aPoint printString].
	^aPoint
]

{ #category : #projection }
JunOpenGLDisplayModel >> projectionTable [
	| projectionTable |
	projectionTable := Dictionary new: 8.
	self preGetProjectionTable: projectionTable.
	projectionTable at: #eyePoint put: self eyePoint.
	projectionTable at: #sightPoint put: self sightPoint.
	projectionTable at: #upVector put: self upVector.
	projectionTable at: #viewFactor put: self viewFactor.
	projectionTable at: #zoomHeight put: self zoomHeight.
	projectionTable at: #presentation put: self displayProjector presentation.
	projectionTable at: #shading put: self displayProjector shading.
	projectionTable at: #projection
		put: ((self displayProjector projection 
				isKindOf: JunOpenGLParallelProjection) 
					ifTrue: [#parallelProjection]
					ifFalse: [#perspectiveProjection]).
	self postGetProjectionTable: projectionTable.
	^projectionTable
]

{ #category : #projection }
JunOpenGLDisplayModel >> projectionTable: aDictionary [ 
	self setProjectionTable: aDictionary.
	self changed: #projection
]

{ #category : #projection }
JunOpenGLDisplayModel >> projectionTableFromCopyBuffer [
	| headerString footerString aString aDictionary |
	headerString := '((JunAttributeTable'.
	footerString := ') attributeTable)'.
	aString := ParagraphEditor currentSelection.
	((aString findString: headerString startingAt: 1) = 1 
		and: [(aString reverse findString: footerString reverse startingAt: 1) = 1]) 
			ifFalse: 
				[headerString := '(JunAttributeTable'.
				footerString := 'attributeTable'.
				aString := ParagraphEditor currentSelection.
				((aString findString: headerString startingAt: 1) = 1 
					and: [(aString reverse findString: footerString reverse startingAt: 1) = 1]) 
						ifFalse: [^nil]].
	aDictionary := Compiler evaluate: aString logged: false.
	(aDictionary isKindOf: Dictionary) ifFalse: [^nil].
	self projectionTable: aDictionary
]

{ #category : #projection }
JunOpenGLDisplayModel >> projectionTableToCopyBuffer [
	| footerString aString |
	footerString := ') yourself)'.
	aString := (JunAttributeTable fromDictionary: self projectionTable) 
				storeString.
	(aString reverse findString: footerString reverse startingAt: 1) = 1 
		ifTrue: 
			[aString := (aString copyFrom: 1 to: aString size - footerString size) 
						, ') attributeTable)'].
	ParagraphEditor copySelection: aString
]

{ #category : #'lisp support' }
JunOpenGLDisplayModel >> projectionTableToLispList [
	| list |
	list := self lispCons.
	list head: #projectionTable.
	list 
		tail: (JunAttributeTable fromDictionary: self projectionTable) toLispList.
	^list
]

{ #category : #buttons }
JunOpenGLDisplayModel >> pushButtons [
	pushButtons ifNil: [pushButtons := Dictionary new].
	^pushButtons
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> quitDoing [
	self closeRequest
]

{ #category : #reading }
JunOpenGLDisplayModel >> readFromLST10: lstFilename [ 
	"
	| object | 
	object := JunOpenGLDisplayModel new readFromLST10: JunUniFileModel requestFileName. 
	object isNil ifTrue: [^nil]. 
	object show. 
	^object 
	"

	| aBody aFilename fileSize aStream aProcess aProgress |
	aBody := nil.
	lstFilename ifNil: [^nil].
	(aFilename := lstFilename asFilename) exists ifFalse: [^nil].
	fileSize := aFilename fileSize.
	self 
		assert: 
			[aStream := aFilename asFilename readStream.
			aProcess := 
					[aProgress := JunProgress new open.
					aProgress message: (#jun_reading__1s____ >> 'reading <1s>...' 
								expandMacrosWith: (Filename splitPath: aFilename asString) last).
					[true] whileTrue: 
							[aProgress value: aStream position / fileSize.
							(Delay forMilliseconds: 1000) wait]] 
							newProcess.
			aProcess priority: Processor activeProcess priority + 1.
			aProcess resume.
			aStream yourself]
		do: 
			[Cursor read showWhile: [aBody := self loadFromLST10: aStream].
			(Delay forMilliseconds: 500) wait]
		ensure: 
			[aStream close.
			aProcess terminate.
			aProgress close].
	^aBody
]

{ #category : #reading }
JunOpenGLDisplayModel >> readFromLST: lstFilename [ 
	"
	| object | 
	object := JunOpenGLDisplayModel new readFromLST: JunOpenGLDisplayModel requestFile. 
	object isNil ifTrue: [^nil]. 
	object show. 
	^object 
	"

	^self readFromLST10: lstFilename
]

{ #category : #reading }
JunOpenGLDisplayModel >> readFromWRL10: wrlFilename [ 
	"
	| displayModel | 
	displayModel := JunOpenGLDisplayModel new. 
	displayModel readFromWRL10: JunUniFileModel requestFileName. 
	displayModel open. 
	^displayModel 
	"

	| aFilename fileSize aStream aProcess aProgress |
	wrlFilename ifNil: [^nil].
	(aFilename := wrlFilename asFilename) exists ifFalse: [^nil].
	fileSize := aFilename fileSize.
	self 
		assert: 
			[aStream := wrlFilename asFilename readStream.
			aProcess := 
					[aProgress := JunProgress new open.
					aProgress message: (#jun_reading__1s____ >> 'reading <1s>...' 
								expandMacrosWith: (Filename splitPath: aFilename asString) last).
					[true] whileTrue: 
							[aProgress value: aStream position / fileSize.
							(Delay forMilliseconds: 1000) wait]] 
							newProcess.
			aProcess priority: Processor activeProcess priority + 1.
			aProcess resume.
			aStream yourself]
		do: 
			[Cursor read showWhile: [self loadFromWRL10: aStream].
			(Delay forMilliseconds: 500) wait]
		ensure: 
			[aStream close.
			aProcess terminate.
			aProgress close].
	^self displayObject
]

{ #category : #reading }
JunOpenGLDisplayModel >> readFromWRL20: wrlFilename [ 
	"
	| displayModel | 
	displayModel := JunOpenGLDisplayModel new. 
	displayModel readFromWRL20: JunUniFileModel requestFileName. 
	displayModel open. 
	^displayModel 
	"

	| aFilename fileSize aStream aProcess aProgress |
	wrlFilename ifNil: [^nil].
	(aFilename := wrlFilename asFilename) exists ifFalse: [^nil].
	fileSize := aFilename fileSize.
	self 
		assert: 
			[aStream := wrlFilename asFilename readStream.
			aProcess := 
					[aProgress := JunProgress new open.
					aProgress message: (#jun_reading__1s____ >> 'reading <1s>...' 
								expandMacrosWith: (Filename splitPath: aFilename asString) last).
					[true] whileTrue: 
							[aProgress value: aStream position / fileSize.
							(Delay forMilliseconds: 1000) wait]] 
							newProcess.
			aProcess priority: Processor activeProcess priority + 1.
			aProcess resume.
			aStream yourself]
		do: 
			[Cursor read showWhile: [self loadFromWRL20: aStream].
			(Delay forMilliseconds: 500) wait]
		ensure: 
			[aStream close.
			aProcess terminate.
			aProgress close].
	^self displayObject
]

{ #category : #reading }
JunOpenGLDisplayModel >> readFromWRL97: wrlFilename [ 
	"
	| displayModel | 
	displayModel := JunOpenGLDisplayModel new. 
	displayModel readFromWRL97: JunUniFileModel requestFileName. 
	displayModel open. 
	^displayModel 
	"

	| aFilename fileSize aStream aProcess aProgress |
	wrlFilename ifNil: [^nil].
	(aFilename := wrlFilename asFilename) exists ifFalse: [^nil].
	fileSize := aFilename fileSize.
	self 
		assert: 
			[aStream := wrlFilename asFilename readStream.
			aProcess := 
					[aProgress := JunProgress new open.
					aProgress message: (#jun_reading__1s____ >> 'reading <1s>...' 
								expandMacrosWith: (Filename splitPath: aFilename asString) last).
					[true] whileTrue: 
							[aProgress value: aStream position / fileSize.
							(Delay forMilliseconds: 1000) wait]] 
							newProcess.
			aProcess priority: Processor activeProcess priority + 1.
			aProcess resume.
			aStream yourself]
		do: 
			[Cursor read showWhile: [self loadFromWRL97: aStream].
			(Delay forMilliseconds: 500) wait]
		ensure: 
			[aStream close.
			aProcess terminate.
			aProgress close].
	^self displayObject
]

{ #category : #reading }
JunOpenGLDisplayModel >> readFromWRL: wrlFilename [ 
	"
	| displayModel | 
	displayModel := JunOpenGLDisplayModel new. 
	displayModel readFromWRL: JunUniFileModel requestFileName. 
	displayModel open. 
	^displayModel 
	"

	^self readFromWRL97: wrlFilename
]

{ #category : #displaying }
JunOpenGLDisplayModel >> redisplay [
	self changed: #object
]

{ #category : #private }
JunOpenGLDisplayModel >> regularizePoint: aPoint in: aRectangle [ 
	| x y |
	x := (aPoint x - (aRectangle width / 2)) / (aRectangle height / 2).
	y := (aPoint y - (aRectangle height / 2)) negated / (aRectangle height / 2).
	^x @ y
]

{ #category : #selecting }
JunOpenGLDisplayModel >> removeSelectedObject: a3dObject [ 
	self displayObject isNil ifTrue: [^nil].
	self displayObject isPrimitive ifTrue: [^nil].
	(self selectedObjects includes: a3dObject)
		ifTrue: [self selectedObjects remove: a3dObject]
]

{ #category : #rendering }
JunOpenGLDisplayModel >> renderOn: renderingContext [ 
	| lightCollection renderingObject aProjector |
	renderingContext isNil ifTrue: [^self].
	renderingContext clear.
	lightCollection := self displayLightCollection.
	renderingObject := self displayObject.
	renderingObject isNil 
		ifTrue: [self displayProjector projectOn: renderingContext]
		ifFalse: 
			[self selectedObjects isEmpty 
				ifTrue: 
					[self displayProjector 
						project: renderingObject
						withLights: lightCollection
						on: renderingContext]
				ifFalse: 
					[aProjector := self displayProjector copy.
					self displayProjector presentation = #solidPresentation 
						ifTrue: [aProjector wireframePresentation].
					self displayProjector presentation = #wireframePresentation 
						ifTrue: [aProjector wireframePresentation].
					self displayProjector presentation = #hiddenlinePresentation 
						ifTrue: [aProjector hiddenlinePresentation].
					aProjector 
						project: renderingObject
						withLights: lightCollection
						on: renderingContext.
					self displayProjector presentation = #solidPresentation 
						ifTrue: [aProjector solidPresentation].
					self displayProjector presentation = #wireframePresentation 
						ifTrue: [aProjector solidPresentation].
					self displayProjector presentation = #hiddenlinePresentation 
						ifTrue: [aProjector solidPresentation].
					self selectedObjects 
						do: [:each | aProjector project: each on: renderingContext]]]
]

{ #category : #rendering }
JunOpenGLDisplayModel >> renderOn: renderingContext withDisplayList: displayListHolder [ 
	| lightCollection renderingObject aProjector |
	renderingContext isNil ifTrue: [^self].
	renderingContext clear.
	lightCollection := self displayLightCollection.
	renderingObject := self displayObject.
	renderingObject isNil 
		ifTrue: [self displayProjector projectOn: renderingContext]
		ifFalse: 
			[self selectedObjects isEmpty 
				ifTrue: 
					[self displayProjector 
						project: renderingObject
						withLights: lightCollection
						on: renderingContext
						withDisplayList: displayListHolder]
				ifFalse: 
					[aProjector := self displayProjector copy.
					self displayProjector presentation = #solidPresentation 
						ifTrue: [aProjector wireframePresentation].
					self displayProjector presentation = #wireframePresentation 
						ifTrue: [aProjector wireframePresentation].
					self displayProjector presentation = #hiddenlinePresentation 
						ifTrue: [aProjector hiddenlinePresentation].
					aProjector 
						project: renderingObject
						withLights: lightCollection
						on: renderingContext
						withDisplayList: displayListHolder.
					self displayProjector presentation = #solidPresentation 
						ifTrue: [aProjector solidPresentation].
					self displayProjector presentation = #wireframePresentation 
						ifTrue: [aProjector solidPresentation].
					self displayProjector presentation = #hiddenlinePresentation 
						ifTrue: [aProjector solidPresentation].
					self selectedObjects 
						do: [:each | aProjector project: each on: renderingContext]]]
]

{ #category : #'texture mapping' }
JunOpenGLDisplayModel >> repeat [
	^self clamp not
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> resetView [
	self displayObject ifNil: [^self changed: #object].
	self flushProjector.
	self fit.
	self updateMenuIndication
]

{ #category : #projection }
JunOpenGLDisplayModel >> rightVector [
	^self displayProjector rightVector
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> saveLST [
	self saveLST10
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> saveLST10 [
	| labels values menu message file |
	self displayObject isNil ifTrue: [^self].
	labels := Array with: (Array 
						with: (#jun__1s__files >> '<1s> files' expandMacrosWith: 'LST')).
	values := Array with: #('*.lst' '*.LST').
	menu := Menu labelList: labels values: values.
	message := #jun_Input_a__1s__file_ >> 'Input a <1s> file.' 
				expandMacrosWith: 'LST'.
	file := JunFileRequesterDialog 
				requestNewFilename: message
				initialFilename: self defaultBaseName , '.lst'
				fileTypeMenu: menu
				initialFileType: values first.
	file isNil ifTrue: [^self].
	self writeToLST10: file object: self displayObject
]

{ #category : #writing }
JunOpenGLDisplayModel >> saveToLST10: stream [ 
	"
	| object model stream | 
	object := JunOpenGL3dObject cube. 
	model := JunOpenGLDisplayModel displayObject: object. 
	stream := 'dummy.lst' asFilename writeStream. 
	[model saveToLST10: stream] 
		valueNowOrOnUnwindDo: [stream close]. 
	^model 
	"

	self saveToLST10: stream object: self displayObject
]

{ #category : #writing }
JunOpenGLDisplayModel >> saveToLST10: stream object: object [ 
	"
	| object model stream | 
	object := JunOpenGL3dObject cube. 
	model := JunOpenGLDisplayModel displayObject: object. 
	stream := 'dummy.lst' asFilename writeStream. 
	[model saveToLST10: stream object: object] 
		valueNowOrOnUnwindDo: [stream close]. 
	^model 
	"

	Cursor write
		showWhile: 
			[stream nextPutAll: self defaultStampForLST10.
			object saveOn: stream].
	^object
]

{ #category : #writing }
JunOpenGLDisplayModel >> saveToLST: stream [ 
	"
	| object model stream | 
	object := JunOpenGL3dObject cube. 
	model := JunOpenGLDisplayModel displayObject: object. 
	stream := 'dummy.lst' asFilename writeStream. 
	[model saveToLST: stream] 
		valueNowOrOnUnwindDo: [stream close]. 
	^model 
	"

	^self saveToLST10: stream
]

{ #category : #writing }
JunOpenGLDisplayModel >> saveToWRL10: stream object: object [ 
	"
	| object model stream | 
	object := JunOpenGL3dObject cube. 
	model := JunOpenGLDisplayModel displayObject: object. 
	stream := 'dummy.lst' asFilename writeStream. 
	[model saveToWRL10: stream object: object] 
		valueNowOrOnUnwindDo: [stream close]. 
	^model 
	"

	Cursor write
		showWhile: 
			[stream nextPutAll: self defaultStampForWRL10.
			object vrml10On: stream].
	^object
]

{ #category : #writing }
JunOpenGLDisplayModel >> saveToWRL20: stream object: object [ 
	"
	| object model stream | 
	object := JunOpenGL3dObject cube. 
	model := JunOpenGLDisplayModel displayObject: object. 
	stream := 'dummy.lst' asFilename writeStream. 
	[model saveToWRL20: stream object: object] 
		valueNowOrOnUnwindDo: [stream close]. 
	^model 
	"

	| size |
	size := object boundingBox width.
	size := size max: object boundingBox height.
	size := size max: object boundingBox depth.
	Cursor write
		showWhile: 
			[stream nextPutAll: self defaultStampForWRL20.
			stream nextPutAll: 'Viewpoint {'.
			stream cr.
			stream tab.
			stream nextPutAll: 'position 0.0 0.0 '.
			stream nextPutAll: (size * 2) asFloat printString.
			stream cr.
			stream nextPutAll: '}'.
			stream cr.
			stream cr.
			stream nextPutAll: 'NavigationInfo {'.
			stream cr.
			stream tab.
			stream nextPutAll: 'speed '.
			stream nextPutAll: (size / 10) asFloat printString.
			stream cr.
			stream nextPutAll: '}'.
			stream cr.
			stream cr.
			object vrml20On: stream].
	^object
]

{ #category : #writing }
JunOpenGLDisplayModel >> saveToWRL97: stream [ 
	"
	| object model stream | 
	object := JunOpenGL3dObject cube. 
	model := JunOpenGLDisplayModel displayObject: object. 
	stream := 'dummy.wrl' asFilename writeStream. 
	[model saveToWRL97: stream] 
	valueNowOrOnUnwindDo: [stream close]. 
	^model 
	"

	Cursor write showWhile: [self vrml97On: stream].
	^self displayObject
]

{ #category : #writing }
JunOpenGLDisplayModel >> saveToWRL: stream [ 
	"
	| object model stream | 
	object := JunOpenGL3dObject cube. 
	model := JunOpenGLDisplayModel displayObject: object. 
	stream := 'dummy.wrl' asFilename writeStream. 
	[model saveToWRL: stream] 
	valueNowOrOnUnwindDo: [stream close]. 
	^model 
	"

	^self saveToWRL97: stream
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> saveWRL [
	self saveWRL20
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> saveWRL10 [
	| labels values menu message file |
	self displayObject isNil ifTrue: [^self].
	labels := Array with: (Array 
						with: (#jun__1s__files >> '<1s> files' expandMacrosWith: 'VRML')).
	values := Array with: #('*.wrl' '*.WRL').
	menu := Menu labelList: labels values: values.
	message := #jun_Input_a__1s__file_ >> 'Input a <1s> file.' 
				expandMacrosWith: 'WRL'.
	file := JunFileRequesterDialog 
				requestNewFilename: message
				initialFilename: self defaultBaseName , '.wrl'
				fileTypeMenu: menu
				initialFileType: values first.
	file isNil ifTrue: [^self].
	self writeToWRL10: file object: self displayObject
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> saveWRL20 [
	| labels values menu message file box transformation object |
	self displayObject isNil ifTrue: [^self].
	labels := Array with: (Array 
						with: (#jun__1s__files >> '<1s> files' expandMacrosWith: 'VRML')).
	values := Array with: #('*.wrl' '*.WRL').
	menu := Menu labelList: labels values: values.
	message := #jun_Input_a__1s__file_ >> 'Input a <1s> file.' 
				expandMacrosWith: 'WRL'.
	file := JunFileRequesterDialog 
				requestNewFilename: message
				initialFilename: self defaultBaseName , '.wrl'
				fileTypeMenu: menu
				initialFileType: values first.
	file isNil ifTrue: [^self].
	box := self displayObject boundingBox.
	transformation := Jun3dTransformation translate: (0 , 0 , 0) - box center.
	object := self displayObject transform: transformation.
	self writeToWRL20: file object: object
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> saveWRL97 [
	| labels values menu message file |
	self displayObject isNil ifTrue: [^self].
	labels := Array with: (Array 
						with: (#jun__1s__files >> '<1s> files' expandMacrosWith: 'VRML')).
	values := Array with: #('*.wrl' '*.WRL').
	menu := Menu labelList: labels values: values.
	message := #jun_Input_a__1s__file_ >> 'Input a <1s> file.' 
				expandMacrosWith: 'WRL'.
	file := JunFileRequesterDialog 
				requestNewFilename: message
				initialFilename: self defaultBaseName , '.wrl'
				fileTypeMenu: menu
				initialFileType: values first.
	file isNil ifTrue: [^self].
	self writeToWRL97: file
]

{ #category : #selecting }
JunOpenGLDisplayModel >> selectAll [
	self displayObject isNil ifTrue: [^nil].
	self displayObject isPrimitive ifTrue: [^self].
	self clearSelectedObjects.
	self displayObject do: [:each | self selectedObjects add: each].
	self changed: #selection.
	self updateMenuIndication
]

{ #category : #selecting }
JunOpenGLDisplayModel >> selectedObject [
	self selectedObjects isEmpty ifTrue: [^nil].
	^self selectedObjects last
]

{ #category : #selecting }
JunOpenGLDisplayModel >> selectedObject: a3dObject [ 
	self selectedObjects: (Array with: a3dObject)
]

{ #category : #selecting }
JunOpenGLDisplayModel >> selectedObjects [
	selectedObjects isNil ifTrue: [self clearSelectedObjects].
	^selectedObjects
]

{ #category : #selecting }
JunOpenGLDisplayModel >> selectedObjects: aCollection [ 
	self clearSelectedObjects.
	aCollection do: [:each | self addSelectedObject: each].
	self changed: #selection.
	self updateMenuIndication
]

{ #category : #projection }
JunOpenGLDisplayModel >> setProjectionTable: aDictionary [ 
	| aTable aProjector |
	(aDictionary respondsTo: #asDictionary) 
		ifTrue: [aTable := aDictionary asDictionary]
		ifFalse: [aTable := aDictionary yourself].
	aProjector := self displayProjector.
	self prePutProjectionTable: aTable into: aProjector.
	(aTable includesKey: #eyePoint) 
		ifTrue: [aProjector eyePoint: (aTable at: #eyePoint)].
	(aTable includesKey: #sightPoint) 
		ifTrue: [aProjector sightPoint: (aTable at: #sightPoint)].
	(aTable includesKey: #upVector) 
		ifTrue: [aProjector upVector: (aTable at: #upVector)].
	(aTable includesKey: #viewFactor) 
		ifTrue: [aProjector viewFactor: (aTable at: #viewFactor)].
	(aTable includesKey: #zoomHeight) 
		ifTrue: [aProjector zoomHeight: (aTable at: #zoomHeight)].
	(aTable includesKey: #presentation) 
		ifTrue: [aProjector presentation: (aTable at: #presentation)].
	(aTable includesKey: #shading) 
		ifTrue: [aProjector shading: (aTable at: #shading)].
	(aTable includesKey: #projection) 
		ifTrue: 
			[(aTable at: #projection) = #parallelProjection 
				ifTrue: [aProjector parallelProjection]
				ifFalse: [aProjector perspectiveProjection]].
	self postPutProjectionTable: aTable into: aProjector
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> showBounds [
	| spawningObject compoundObject displayModel boundingObject |
	self displayObject isNil ifTrue: [^self].
	spawningObject := self spawningObject.
	boundingObject := self boundingObjectFor: spawningObject.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: boundingObject.
	compoundObject add: spawningObject.
	displayModel := JunOpenGLDisplayModel displayObject: compoundObject.
	displayModel displayProjection: self displayProjection copy.
	displayModel open.
	displayModel changed: #object
]

{ #category : #accessing }
JunOpenGLDisplayModel >> showModel [
	self dependents do: [:each | (each isKindOf: JunOpenGLShowModel)
			ifTrue: [^each]].
	^nil
]

{ #category : #projection }
JunOpenGLDisplayModel >> sightPoint [
	^self displayProjector sightPoint
]

{ #category : #projection }
JunOpenGLDisplayModel >> sightPoint: a3dPoint [ 
	self displayProjector sightPoint: a3dPoint.
	self changed: #projection
]

{ #category : #manipulating }
JunOpenGLDisplayModel >> slide: from2dPoint xy: to2dPoint [ 
	| aProjection fromPoint toPoint |
	self displayObject isNil ifTrue: [^self].
	aProjection := self displayProjection.
	fromPoint := aProjection translateTo3dPointFromPoint: from2dPoint x , from2dPoint y.
	toPoint := aProjection translateTo3dPointFromPoint: to2dPoint x , to2dPoint y.
	aProjection sightPoint: aProjection sightPoint - (toPoint - fromPoint).
	aProjection eyePoint: aProjection eyePoint - (toPoint - fromPoint).
	self displayProjection: aProjection.
	self changed: #projection
]

{ #category : #shading }
JunOpenGLDisplayModel >> smoothShading [
	self displayProjector smoothShading.
	self updateViewMenuIndication.
	self changed: #shading
]

{ #category : #presentation }
JunOpenGLDisplayModel >> solidPresentation [
	self displayProjector solidPresentation.
	self updateViewMenuIndication.
	self changed: #presentation
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> spawnObject [
	| displayModel aView |
	displayModel := self classToSpawn displayObject: self spawningObject.
	displayModel defaultProjectionTable: self projectionTable.
	aView := self getView.
	aView isNil 
		ifTrue: [displayModel open]
		ifFalse: 
			[| box area |
			box := aView topComponent displayBox.
			area := 0 @ 0 extent: aView topComponent displayBox extent.
			area := area align: area topLeft with: box topRight + (8 @ 0).
			displayModel openIn: area].
	displayModel changed: #object.
	^displayModel
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> spawnViewport [
	| model window |
	(model := self showModel) isNil 
		ifTrue: [model := JunOpenGLShowModel displayModel: self].
	(model builder notNil and: [(window := model builder window) isOpen]) 
		ifTrue: 
			[window isCollapsed ifTrue: [window expand].
			window raise]
		ifFalse: 
			[| view box area |
			view := self getView.
			view isNil 
				ifTrue: [model open]
				ifFalse: 
					[box := view topComponent displayBox.
					area := 0 @ 0 extent: view topComponent displayBox extent.
					area := area align: area topLeft with: box topRight + (8 @ 0).
					model openIn: area]].
	JunApplicationModel displayPendingInvalidation
]

{ #category : #private }
JunOpenGLDisplayModel >> spawningObject [
	| spawningObject |
	self selectedObjects isEmpty 
		ifTrue: 
			[self displayObject isTransformedObject 
				ifTrue: [spawningObject := self displayObject transformedObject]
				ifFalse: [spawningObject := self displayObject copy]]
		ifFalse: 
			[self selectedObjects size > 1 
				ifTrue: 
					[spawningObject := JunOpenGL3dCompoundObject new.
					self selectedObjects do: [:each | spawningObject add: each copy]]
				ifFalse: [spawningObject := self selectedObjects first copy]].
	^spawningObject
]

{ #category : #superimpose }
JunOpenGLDisplayModel >> superimpose [
	self beforeSuperimpose.
	self doSuperimpose.
	self afterSuperimpose
]

{ #category : #superimpose }
JunOpenGLDisplayModel >> superimposeBlock: aBlock [ 
	superimposeBlock := aBlock
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> textureClamp [
	| aBoolean aTexture |
	self displayObject isNil ifTrue: [^self].
	aBoolean := self clamp not.
	self displayObject objectsDo: 
			[:each | 
			aTexture := each texture.
			aTexture notNil 
				ifTrue: 
					[aTexture clamp: aBoolean.
					each texture: aTexture]].
	self updateMiscMenuIndication.
	self changed: #texture
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> textureFromFile [
	| labels values menu aFilename imageDispenser anImage aTexture |
	self displayObject isNil ifTrue: [^self].
	labels := Array 
				with: (Array with: (#jun_Image_files >> 'Image files') asString)
				with: (Array with: (#jun_All_files >> 'All files') asString).
	values := Array with: JunSystem defaultImageExtensionPatterns with: #('*').
	menu := Menu labelList: labels values: values.
	aFilename := JunFileRequesterDialog 
				requestFilename: (#jun_Select_an_image_file_ >> 'Select an image file.') 
						asString
				fileTypeMenu: menu
				initialFileType: values first.
	aFilename isNil ifTrue: [^nil].
	imageDispenser := JunImageDispenser default.
	anImage := imageDispenser at: aFilename.
	(anImage isKindOf: Image) 
		ifFalse: 
			[JunDialog warn: (aFilename asString contractTo: 40) printString 
						, (#jun__is_not_an_image_file_ >> ' is not an image file.') asString.
			^nil].
	aTexture := JunOpenGLTexture image: anImage.
	self hasTextureMapping 
		ifTrue: 
			[aTexture linear: self linear.
			aTexture clamp: self clamp.
			aTexture modulate: self modulate.
			aTexture mipmap: self mipmap].
	self selectedObjects isEmpty 
		ifTrue: [self displayObject texture: aTexture]
		ifFalse: [self selectedObjects do: [:each | each texture: aTexture]].
	self updateMiscMenuIndication.
	self changed: #texture
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> textureFromUser [
	| anImage aTexture |
	self displayObject isNil ifTrue: [^self].
	anImage := Image fromUser.
	aTexture := JunOpenGLTexture image: anImage.
	self hasTextureMapping
		ifTrue: 
			[aTexture linear: self linear.
			aTexture clamp: self clamp.
			aTexture modulate: self modulate.
			aTexture mipmap: self mipmap].
	self selectedObjects isEmpty
		ifTrue: [self displayObject texture: aTexture]
		ifFalse: [self selectedObjects do: [:each | each texture: aTexture]].
	self updateMiscMenuIndication.
	self changed: #texture
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> textureLinear [
	| aBoolean aTexture |
	self displayObject isNil ifTrue: [^self].
	aBoolean := self linear not.
	self displayObject objectsDo: 
			[:each | 
			aTexture := each texture.
			aTexture notNil 
				ifTrue: 
					[aTexture linear: aBoolean.
					each texture: aTexture]].
	self updateMiscMenuIndication.
	self changed: #texture
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> textureMipmap [
	| aBoolean aTexture |
	self displayObject isNil ifTrue: [^self].
	aBoolean := self mipmap not.
	self displayObject objectsDo: 
			[:each | 
			aTexture := each texture.
			aTexture notNil 
				ifTrue: 
					[aTexture mipmap: aBoolean.
					each texture: aTexture]].
	self updateMiscMenuIndication.
	self changed: #texture
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> textureModulate [
	| aBoolean aTexture |
	self displayObject isNil ifTrue: [^self].
	aBoolean := self modulate not.
	self displayObject objectsDo: 
			[:each | 
			aTexture := each texture.
			aTexture notNil 
				ifTrue: 
					[aTexture modulate: aBoolean.
					each texture: aTexture]].
	self updateMiscMenuIndication.
	self changed: #texture
]

{ #category : #'menu messages' }
JunOpenGLDisplayModel >> textureTakeAway [
	self displayObject isNil ifTrue: [^self].
	self selectedObjects isEmpty
		ifTrue: [self displayObject texture: nil]
		ifFalse: [self selectedObjects do: [:each | each texture: nil]].
	self updateMiscMenuIndication.
	self changed: #texture
]

{ #category : #private }
JunOpenGLDisplayModel >> thetaAccuracy [
	^0.001
]

{ #category : #'lisp support' }
JunOpenGLDisplayModel >> toLispList [
	"self showLispList: ((JunOpenGLDisplayModel displayObject: JunOpenGL3dObject box) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self displayObjectToLispList.
	list add: self projectionTableToLispList.
	list add: self displayLightsToLispList.
	list add: self preferenceTableToLispList.
	^list
]

{ #category : #'vrml support' }
JunOpenGLDisplayModel >> transformationForVrml97 [
	| vz vy vx collection |
	vz := (self eyePoint - self sightPoint) unitVector.
	vy := self upVector.
	vx := (vy y * vz z - (vy z * vz y) , (vy z * vz x - (vy x * vz z)) , (vy x * vz y - (vy y * vz x))) unitVector.
	collection := OrderedCollection new: 16.
	collection add: vx x.
	collection add: vy x.
	collection add: vz x.
	collection add: 0.
	collection add: vx y.
	collection add: vy y.
	collection add: vz y.
	collection add: 0.
	collection add: vx z.
	collection add: vy z.
	collection add: vz z.
	collection add: 0.
	collection add: 0.
	collection add: 0.
	collection add: 0.
	collection add: 1.
	^(Jun3dTransformation translate: 0 , 0 , 0 - self sightPoint)
		product: (Jun3dTransformation fromArray: collection asArray)
]

{ #category : #projection }
JunOpenGLDisplayModel >> upVector [
	^self displayProjector upVector
]

{ #category : #projection }
JunOpenGLDisplayModel >> upVector: a3dPoint [ 
	self displayProjector upVector: a3dPoint.
	self changed: #projection
]

{ #category : #'menu accessing' }
JunOpenGLDisplayModel >> updateEditMenuIndication [
	| menuItem aMenu displayObjectIsEmpty |
	menuItem := self menuItemLabeled: 'Edit' inMenu: self menuBar.
	menuItem isNil ifTrue: [^self].
	aMenu := menuItem submenu.
	aMenu isNil ifTrue: [^nil].
	displayObjectIsEmpty := self isEmpty.
	menuItem := aMenu menuItemWithValue: #copyObject ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	menuItem := aMenu menuItemWithValue: #cutObject ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[(displayObjectIsEmpty or: [self selectedObjects isEmpty]) 
				ifTrue: [menuItem disable]
				ifFalse: [menuItem enable]].
	menuItem := aMenu menuItemWithValue: #clearObject ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[(displayObjectIsEmpty or: [self selectedObjects isEmpty]) 
				ifTrue: [menuItem disable]
				ifFalse: [menuItem enable]].
	menuItem := aMenu menuItemWithValue: #selectAll ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]]
]

{ #category : #'menu accessing' }
JunOpenGLDisplayModel >> updateFileMenuIndication [
	| menuItem aMenu displayObjectIsEmpty |
	menuItem := self menuItemLabeled: 'File' inMenu: self menuBar.
	menuItem isNil ifTrue: [^self].
	aMenu := menuItem submenu.
	aMenu isNil ifTrue: [^nil].
	displayObjectIsEmpty := self isEmpty.
	menuItem := aMenu menuItemWithValue: #saveLST ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	menuItem := self menuItemLabeled: 'Save' asString inMenu: aMenu.
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	menuItem := self menuItemLabeled: 'Save as...' asString inMenu: aMenu.
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	menuItem := aMenu menuItemWithValue: #saveAsImage ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]]
]

{ #category : #'menu accessing' }
JunOpenGLDisplayModel >> updateLightMenuIndication [
	| menuItem aMenu |
	menuItem := self menuItemLabeled: 'Light' inMenu: self menuBar.
	menuItem isNil ifTrue: [^self].
	aMenu := menuItem submenu.
	aMenu isNil ifTrue: [^self].
	#(1 2 3 4 5) 
		with: (Array 
				with: 'Light1'
				with: 'Light2'
				with: 'Light3'
				with: 'Light4') , (Array with: 'Ambient')
		do: 
			[:index :symbol | 
			menuItem := self menuItemLabeled: symbol inMenu: aMenu.
			menuItem notNil 
				ifTrue: 
					[(self displayLights at: index) isOn 
						ifTrue: [menuItem beOn]
						ifFalse: [menuItem beOff]]]
]

{ #category : #'menu accessing' }
JunOpenGLDisplayModel >> updateMenuIndication [
	super updateMenuIndication.
	self updateFileMenuIndication.
	self updateEditMenuIndication.
	self updateViewMenuIndication.
	self updateLightMenuIndication.
	self updateMiscMenuIndication.
	self showModel notNil ifTrue: [self showModel updateMenuIndication]
]

{ #category : #'menu accessing' }
JunOpenGLDisplayModel >> updateMiscMenuIndication [
	| menuItem aMenu subMenu displayObjectIsEmpty |
	menuItem := self menuItemLabeled: 'Misc' inMenu: self menuBar.
	menuItem isNil ifTrue: [^self].
	aMenu := menuItem submenu.
	aMenu isNil ifTrue: [^nil].
	displayObjectIsEmpty := self isEmpty.
	menuItem := self menuItemLabeled: 'Texture' inMenu: aMenu.
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty 
				ifTrue: [menuItem disable]
				ifFalse: 
					[menuItem enable.
					subMenu := menuItem submenu.
					subMenu notNil 
						ifTrue: 
							[menuItem := subMenu menuItemWithValue: #textureMipmap ifNone: [nil].
							menuItem notNil 
								ifTrue: [self mipmap ifTrue: [menuItem beOn] ifFalse: [menuItem beOff]].
							menuItem := subMenu menuItemWithValue: #textureModulate ifNone: [nil].
							menuItem notNil 
								ifTrue: [self modulate ifTrue: [menuItem beOn] ifFalse: [menuItem beOff]].
							menuItem := subMenu menuItemWithValue: #textureClamp ifNone: [nil].
							menuItem notNil 
								ifTrue: [self clamp ifTrue: [menuItem beOn] ifFalse: [menuItem beOff]].
							menuItem := subMenu menuItemWithValue: #textureLinear ifNone: [nil].
							menuItem notNil 
								ifTrue: [self linear ifTrue: [menuItem beOn] ifFalse: [menuItem beOff]]]]].
	menuItem := aMenu menuItemWithValue: #spawnObject ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	menuItem := aMenu menuItemWithValue: #spawnViewport ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	menuItem := aMenu menuItemWithValue: #showBounds ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	menuItem := aMenu menuItemWithValue: #inspectModel ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[JunSystem isRuntimeVersion 
				ifTrue: [menuItem disable]
				ifFalse: [menuItem enable]]
]

{ #category : #'menu accessing' }
JunOpenGLDisplayModel >> updateViewMenuIndication [
	| menuItem aMenu displayObjectIsEmpty |
	menuItem := self menuItemLabeled: 'View' inMenu: self menuBar.
	menuItem isNil ifTrue: [^self].
	aMenu := menuItem submenu.
	aMenu isNil ifTrue: [^self].
	displayObjectIsEmpty := self isEmpty.
	menuItem := self menuItemLabeled: 'Zooming' inMenu: aMenu.
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	menuItem := self menuItemLabeled: 'Pointing' inMenu: aMenu.
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	menuItem := aMenu menuItemWithValue: #resetView ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	(self displayProjector projection isKindOf: JunOpenGLPerspectiveProjection) 
		ifTrue: 
			[menuItem := self menuItemLabelArray: #('Projection' 'Perspective')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOn].
			menuItem := self menuItemLabelArray: #('Projection' 'Parallel')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOff]]
		ifFalse: 
			[menuItem := self menuItemLabelArray: #('Projection' 'Perspective')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOff].
			menuItem := self menuItemLabelArray: #('Projection' 'Parallel')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOn]].
	self displayProjector presentation = #solidPresentation 
		ifTrue: 
			[menuItem := self menuItemLabelArray: #('Presentation' 'Solid')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOn].
			menuItem := self menuItemLabelArray: #('Presentation' 'Wireframe')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOff].
			menuItem := self menuItemLabelArray: #('Presentation' 'Hidden-line')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOff]].
	self displayProjector presentation = #wireframePresentation 
		ifTrue: 
			[menuItem := self menuItemLabelArray: #('Presentation' 'Solid')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOff].
			menuItem := self menuItemLabelArray: #('Presentation' 'Wireframe')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOn].
			menuItem := self menuItemLabelArray: #('Presentation' 'Hidden-line')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOff]].
	self displayProjector presentation = #hiddenlinePresentation 
		ifTrue: 
			[menuItem := self menuItemLabelArray: #('Presentation' 'Solid')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOff].
			menuItem := self menuItemLabelArray: #('Presentation' 'Wireframe')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOff].
			menuItem := self menuItemLabelArray: #('Presentation' 'Hidden-line')
						inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOn]].
	self displayProjector shading = #flatShading 
		ifTrue: 
			[menuItem := self menuItemLabelArray: #('Shading' 'Flat') inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOn].
			menuItem := self menuItemLabelArray: #('Shading' 'Smooth') inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOff]]
		ifFalse: 
			[menuItem := self menuItemLabelArray: #('Shading' 'Flat') inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOff].
			menuItem := self menuItemLabelArray: #('Shading' 'Smooth') inMenu: aMenu.
			menuItem notNil ifTrue: [menuItem beOn]].
	menuItem := self menuItemLabelArray: #('Smoothing' 'Line smooth')
				inMenu: aMenu.
	menuItem notNil 
		ifTrue: 
			[self displayProjector lineSmooth 
				ifTrue: [menuItem beOn]
				ifFalse: [menuItem beOff].
			(JunOpenGLInterface gluVersion findString: 'Microsoft' startingAt: 1) > 0 
				ifTrue: [menuItem disable]].
	menuItem := self menuItemLabelArray: #('Smoothing' 'Polygon smooth')
				inMenu: aMenu.
	menuItem notNil 
		ifTrue: 
			[self displayProjector polygonSmooth 
				ifTrue: [menuItem beOn]
				ifFalse: [menuItem beOff].
			(JunOpenGLInterface gluVersion findString: 'Microsoft' startingAt: 1) > 0 
				ifTrue: [menuItem disable]]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> useDisplayList [
	^self preferenceTable at: #useDisplayList ifAbsentPut: [true]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> useDisplayList: aBoolean [ 
	| oldBoolean |
	oldBoolean := self useDisplayList.
	self preferenceTable at: #useDisplayList put: aBoolean = true.
	oldBoolean = self useDisplayList 
		ifFalse: 
			[self getView ifNotNil: 
					[:aView | 
					aView
						flushCachedBitmap;
						redisplay]]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> useFrameBuffer [
	^self preferenceTable at: #useFrameBuffer ifAbsentPut: [false]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> useFrameBuffer: aBoolean [ 
	| oldBoolean |
	oldBoolean := self useFrameBuffer.
	self preferenceTable at: #useFrameBuffer put: aBoolean = true.
	(self useFrameBuffer and: [self usePixelBuffer]) 
		ifTrue: [self preferenceTable at: #usePixelBuffer put: false].
	oldBoolean = self useFrameBuffer 
		ifFalse: 
			[self getView ifNotNil: 
					[:aView | 
					aView
						flushCachedBitmap;
						redisplay]]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> useMovementProcess [
	^self preferenceTable at: #useMovementProcess ifAbsentPut: [true]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> useMovementProcess: aBoolean [ 
	self preferenceTable at: #useMovementProcess put: aBoolean = true
]

{ #category : #preferences }
JunOpenGLDisplayModel >> usePixelBuffer [
	^self preferenceTable at: #usePixelBuffer ifAbsentPut: [false]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> usePixelBuffer: aBoolean [ 
	| oldBoolean |
	oldBoolean := self usePixelBuffer.
	self preferenceTable at: #usePixelBuffer put: aBoolean = true.
	(self usePixelBuffer and: [self useFrameBuffer]) 
		ifTrue: [self preferenceTable at: #useFrameBuffer put: false].
	oldBoolean = self usePixelBuffer 
		ifFalse: 
			[self getView ifNotNil: 
					[:aView | 
					aView
						flushCachedBitmap;
						redisplay]]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> usePressActivity [
	^self preferenceTable at: #usePressActivity ifAbsentPut: [false]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> usePressActivity: aBoolean [ 
	self preferenceTable at: #usePressActivity put: aBoolean = true
]

{ #category : #preferences }
JunOpenGLDisplayModel >> useYellowButtonMenu [
	^self preferenceTable at: #useYellowButtonMenu ifAbsentPut: [false]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> useYellowButtonMenu: aBoolean [ 
	self preferenceTable at: #useYellowButtonMenu put: aBoolean = true
]

{ #category : #projection }
JunOpenGLDisplayModel >> viewFactor [
	^self displayProjector viewFactor
]

{ #category : #projection }
JunOpenGLDisplayModel >> viewFactor: factor [ 
	self displayProjector viewFactor: factor.
	self changed: #projection
]

{ #category : #'vrml support' }
JunOpenGLDisplayModel >> vrml97NavigationInfoOn: stream [ 
	stream nextPutAll: 'NavigationInfo {'.
	stream cr.
	stream tab.
	stream nextPutAll: 'type ["EXAMINE", "ANY"]'.
	stream cr.
	stream tab.
	stream nextPutAll: 'avatarSize [0.25, 1.6, 0.75'.
	stream nextPutAll: ', ' , self sightPoint x asFloat printString.
	stream nextPutAll: ', ' , self sightPoint y asFloat printString.
	stream nextPutAll: ', ' , self sightPoint z asFloat printString.
	stream nextPutAll: ']'.
	stream cr.
	stream tab.
	stream nextPutAll: 'visibilityLimit ' , self displayProjector far asFloat printString.
	stream cr.
	stream nextPutAll: '}'.
	stream cr
]

{ #category : #'vrml support' }
JunOpenGLDisplayModel >> vrml97On: stream [ 
	stream nextPutAll: self defaultStampForWRL97.
	stream cr.
	self vrml97WorldInfoOn: stream.
	stream cr.
	self vrml97ViewpointOn: stream.
	stream cr.
	self vrml97NavigationInfoOn: stream.
	stream cr.
	self displayObject vrml20On: stream
]

{ #category : #'vrml support' }
JunOpenGLDisplayModel >> vrml97ViewpointOn: stream [ 
	| eyePoint transformation rotationVector rotationAngle |
	eyePoint := self eyePoint.
	transformation := self transformationForVrml97.
	rotationVector := transformation rotationVector.
	rotationAngle := transformation rotationAngle.
	stream nextPutAll: 'Viewpoint {'.
	stream cr.
	stream tab.
	stream nextPutAll: 'fieldOfView ' , ((self zoomHeight / (self eyePoint distance: self sightPoint) / 2) arcTan * 2) asFloat printString.
	stream cr.
	stream tab.
	stream nextPutAll: 'position'.
	stream space.
	stream nextPutAll: eyePoint x asFloat printString.
	stream space.
	stream nextPutAll: eyePoint y asFloat printString.
	stream space.
	stream nextPutAll: eyePoint z asFloat printString.
	stream cr.
	stream tab.
	stream nextPutAll: 'orientation'.
	stream space.
	stream nextPutAll: rotationVector x asFloat printString.
	stream space.
	stream nextPutAll: rotationVector y asFloat printString.
	stream space.
	stream nextPutAll: rotationVector z asFloat printString.
	stream space.
	stream nextPutAll: rotationAngle rad asFloat printString.
	stream cr.
	stream nextPutAll: '}'.
	stream cr
]

{ #category : #'vrml support' }
JunOpenGLDisplayModel >> vrml97WorldInfoOn: stream [ 
	stream nextPutAll: 'WorldInfo {'.
	stream cr.
	stream tab.
	stream nextPutAll: 'info ['.
	stream cr.
	stream tab; tab.
	stream nextPutAll: '"This file was created by ' , self class system , self class version , '"'.
	stream cr.
	stream tab; tab.
	stream nextPutAll: '"' , (JunCalendarModel stringFromDateAndTime: Time dateAndTimeNow) , '"'.
	stream cr.
	stream tab.
	stream nextPutAll: ']'.
	stream cr.
	stream tab.
	stream nextPutAll: 'title "'.
	self displayObject notNil ifTrue: [stream nextPutAll: self displayObject name , ': '].
	stream nextPutAll: 'Sample of ' , self class name asString , '"'.
	stream cr.
	stream nextPutAll: '}'.
	stream cr
]

{ #category : #'wheel actions' }
JunOpenGLDisplayModel >> wheel: wheelUpBoolean at: mouseCursorPoint in: viewDisplayBox [ 
	| aSymbol |
	((self class nineBoxesOf: viewDisplayBox) 
		detect: [:association | association value containsPoint: mouseCursorPoint]
		ifNone: [nil]) ifNil: [^nil]
			ifNotNil: [:association | aSymbol := association key].
	aSymbol = #topLeft ifTrue: [self wheelActionInTopLeftBox: wheelUpBoolean].
	aSymbol = #topCenter ifTrue: [self wheelActionInTopCenterBox: wheelUpBoolean].
	aSymbol = #topRight ifTrue: [self wheelActionInTopRightBox: wheelUpBoolean].
	aSymbol = #leftCenter ifTrue: [self wheelActionInLeftCenterBox: wheelUpBoolean].
	aSymbol = #rightCenter ifTrue: [self wheelActionInRightCenterBox: wheelUpBoolean].
	aSymbol = #center ifTrue: [self wheelActionInCenterBox: wheelUpBoolean].
	aSymbol = #bottomLeft ifTrue: [self wheelActionInBottomLeftBox: wheelUpBoolean].
	aSymbol = #bottomCenter ifTrue: [self wheelActionInBottomCenterBox: wheelUpBoolean].
	aSymbol = #bottomRight ifTrue: [self wheelActionInBottomRightBox: wheelUpBoolean]
]

{ #category : #'wheel actions' }
JunOpenGLDisplayModel >> wheelActionInBottomCenterBox: wheelUpBoolean [ 
	| value factor |
	JunSensorUtility altDown ifTrue: [value := 0.01] ifFalse: [value := 0.1].
	wheelUpBoolean 
		ifTrue: [factor := value negated , 0]
		ifFalse: [factor := value , 0].
	self grab: factor
]

{ #category : #'wheel actions' }
JunOpenGLDisplayModel >> wheelActionInBottomLeftBox: wheelUpBoolean [ 
	self wheelActionInTopRightBox: wheelUpBoolean
]

{ #category : #'wheel actions' }
JunOpenGLDisplayModel >> wheelActionInBottomRightBox: wheelUpBoolean [ 
	self wheelActionInTopLeftBox: wheelUpBoolean
]

{ #category : #'wheel actions' }
JunOpenGLDisplayModel >> wheelActionInCenterBox: wheelUpBoolean [ 
	self wheelActionInRightCenterBox: wheelUpBoolean
]

{ #category : #'wheel actions' }
JunOpenGLDisplayModel >> wheelActionInLeftCenterBox: wheelUpBoolean [ 
	| value factor |
	JunSensorUtility altDown ifTrue: [value := 0.01] ifFalse: [value := 0.1].
	wheelUpBoolean 
		ifTrue: [factor := 0 , value]
		ifFalse: [factor := 0 , value negated].
	self grab: factor
]

{ #category : #'wheel actions' }
JunOpenGLDisplayModel >> wheelActionInRightCenterBox: wheelUpBoolean [ 
	| value factor |
	JunSensorUtility altDown ifTrue: [value := 0.01] ifFalse: [value := 0.1].
	wheelUpBoolean ifTrue: [factor := 1 - value] ifFalse: [factor := 1 + value].
	self zoom: factor
]

{ #category : #'wheel actions' }
JunOpenGLDisplayModel >> wheelActionInTopCenterBox: wheelUpBoolean [ 
	| angle transformation line vector |
	JunSensorUtility altDown ifTrue: [angle := 1] ifFalse: [angle := 5].
	wheelUpBoolean 
		ifTrue: 
			[transformation := (JunAngle fromDeg: angle) 
						transformationToRotate: (self sightPoint to: self eyePoint)]
		ifFalse: 
			[transformation := (JunAngle fromDeg: angle negated) 
						transformationToRotate: (self sightPoint to: self eyePoint)].
	line := (self sightPoint to: self sightPoint + self upVector normalVector) 
				transform: transformation.
	vector := line to - line from.
	self upVector: vector
]

{ #category : #'wheel actions' }
JunOpenGLDisplayModel >> wheelActionInTopLeftBox: wheelUpBoolean [ 
	| value factor |
	JunSensorUtility altDown ifTrue: [value := 0.01] ifFalse: [value := 0.1].
	wheelUpBoolean 
		ifTrue: [factor := value negated , value]
		ifFalse: [factor := value , value negated].
	self grab: factor
]

{ #category : #'wheel actions' }
JunOpenGLDisplayModel >> wheelActionInTopRightBox: wheelUpBoolean [ 
	| value factor |
	JunSensorUtility altDown ifTrue: [value := 0.01] ifFalse: [value := 0.1].
	wheelUpBoolean 
		ifTrue: [factor := value , value]
		ifFalse: [factor := value negated , value negated].
	self grab: factor
]

{ #category : #preferences }
JunOpenGLDisplayModel >> windowLabel [
	^self preferenceTable at: #windowLabel ifAbsentPut: [nil]
]

{ #category : #preferences }
JunOpenGLDisplayModel >> windowLabel: aString [ 
	self preferenceTable at: #windowLabel put: aString.
	self windowLabel ifNotNil: [self setWindowLabel]
]

{ #category : #presentation }
JunOpenGLDisplayModel >> wireframePresentation [
	self displayProjector wireframePresentation.
	self updateViewMenuIndication.
	self changed: #presentation
]

{ #category : #writing }
JunOpenGLDisplayModel >> writeToLST10: aFilename [ 
	"
	| aBody aModel | 
	aBody := JunOpenGL3dObject cube. 
	aModel := JunOpenGLDisplayModel displayObject: aBody. 
	aModel writeToLST10: 'dummy.lst' asFilename. 
	^aModel 
	"

	^self writeToLST10: aFilename object: self displayObject
]

{ #category : #writing }
JunOpenGLDisplayModel >> writeToLST10: aFilename object: aBody [ 
	"
	| aBody aModel | 
	aBody := JunOpenGL3dObject cube. 
	aModel := JunOpenGLDisplayModel displayObject: aBody. 
	aModel writeToLST10: 'dummy.lst' asFilename object: aBody. 
	^aModel 
	"

	| aStream aProgress estimatedSize aProcess |
	aFilename ifNil: [^nil].
	aBody ifNil: [^nil].
	self 
		assert: 
			[aStream := aFilename asFilename writeStream.
			aProgress := JunProgress new open.
			aProgress 
				message: (#jun_Please_wait_to_estimate_ >> 'Please wait to estimate.') 
						asString.
			Cursor wait showWhile: [estimatedSize := aBody estimatedFileSizeToSave].
			aProcess := 
					[aProgress message: (#jun_writing__1s____ >> 'writing <1s>...' 
								expandMacrosWith: (Filename splitPath: aFilename asString) last).
					[true] whileTrue: 
							[aProgress value: aStream position / estimatedSize.
							(Delay forMilliseconds: 1000) wait]] 
							newProcess.
			aProcess priority: Processor activeProcess priority + 1.
			aProcess resume.
			aStream yourself]
		do: 
			[Cursor write showWhile: [self saveToLST10: aStream object: aBody].
			(Delay forMilliseconds: 500) wait]
		ensure: 
			[aStream close.
			aProcess terminate.
			aProgress close].
	^aBody
]

{ #category : #writing }
JunOpenGLDisplayModel >> writeToLST: aFilename [ 
	"
	| aBody aModel | 
	aBody := JunOpenGL3dObject cube. 
	aModel := JunOpenGLDisplayModel displayObject: aBody. 
	aModel writeToLST: 'dummy.lst' asFilename. 
	^aModel 
	"

	^self writeToLST10: aFilename
]

{ #category : #writing }
JunOpenGLDisplayModel >> writeToWRL10: aFilename object: aBody [ 
	"
	| object model | 
	object := JunOpenGL3dObject cube. 
	model := JunOpenGLDisplayModel displayObject: object. 
	model writeToWRL10: 'dummy.wrl' asFilename object: object. 
	^model 
	"

	| aStream aProgress estimatedSize aProcess |
	aFilename ifNil: [^nil].
	aBody ifNil: [^nil].
	self 
		assert: 
			[aStream := aFilename asFilename writeStream.
			aProgress := JunProgress new open.
			aProgress 
				message: (#jun_Please_wait_to_estimate_ >> 'Please wait to estimate.') 
						asString.
			Cursor wait 
				showWhile: [estimatedSize := aBody estimatedFileSizeToSaveAsVRML].
			aProcess := 
					[aProgress message: (#jun_writing__1s____ >> 'writing <1s>...' 
								expandMacrosWith: (Filename splitPath: aFilename asString) last).
					[true] whileTrue: 
							[aProgress value: aStream position / estimatedSize.
							(Delay forMilliseconds: 1000) wait]] 
							newProcess.
			aProcess priority: Processor activeProcess priority + 1.
			aProcess resume.
			aStream yourself]
		do: 
			[Cursor write showWhile: [self saveToWRL10: aStream object: aBody].
			(Delay forMilliseconds: 500) wait]
		ensure: 
			[aStream close.
			aProcess terminate.
			aProgress close].
	^aBody
]

{ #category : #writing }
JunOpenGLDisplayModel >> writeToWRL20: aFilename object: aBody [ 
	"
	| object model | 
	object := JunOpenGL3dObject cube. 
	model := JunOpenGLDisplayModel displayObject: object. 
	model writeToWRL20: 'dummy.wrl' asFilename object: object. 
	^model 
	"

	| aStream aProgress estimatedSize aProcess |
	aFilename ifNil: [^nil].
	aBody ifNil: [^nil].
	self 
		assert: 
			[aStream := aFilename asFilename writeStream.
			aProgress := JunProgress new open.
			aProgress 
				message: (#jun_Please_wait_to_estimate_ >> 'Please wait to estimate.') 
						asString.
			Cursor wait 
				showWhile: [estimatedSize := aBody estimatedFileSizeToSaveAsVRML].
			aProcess := 
					[aProgress message: (#jun_writing__1s____ >> 'writing <1s>...' 
								expandMacrosWith: (Filename splitPath: aFilename asString) last).
					[true] whileTrue: 
							[aProgress value: aStream position / estimatedSize.
							(Delay forMilliseconds: 1000) wait]] 
							newProcess.
			aProcess priority: Processor activeProcess priority + 1.
			aProcess resume.
			aStream yourself]
		do: 
			[Cursor write showWhile: [self saveToWRL20: aStream object: aBody].
			(Delay forMilliseconds: 500) wait]
		ensure: 
			[aStream close.
			aProcess terminate.
			aProgress close].
	^aBody
]

{ #category : #writing }
JunOpenGLDisplayModel >> writeToWRL97: aFilename [ 
	"
	| object model | 
	object := JunOpenGL3dObject cube. 
	model := JunOpenGLDisplayModel displayObject: object. 
	model writeToWRL97: 'dummy.wrl' asFilename. 
	^model 
	"

	| aStream aProgress estimatedSize aProcess |
	aFilename ifNil: [^nil].
	self displayObject ifNil: [^nil].
	self 
		assert: 
			[aStream := aFilename asFilename writeStream.
			aProgress := JunProgress new open.
			aProgress 
				message: (#jun_Please_wait_to_estimate_ >> 'Please wait to estimate.') 
						asString.
			Cursor wait 
				showWhile: [estimatedSize := self displayObject estimatedFileSizeToSaveAsVRML].
			aProcess := 
					[aProgress message: (#jun_writing__1s____ >> 'writing <1s>...' 
								expandMacrosWith: (Filename splitPath: aFilename asString) last).
					[true] whileTrue: 
							[aProgress value: aStream position / estimatedSize.
							(Delay forMilliseconds: 1000) wait]] 
							newProcess.
			aProcess priority: Processor activeProcess priority + 1.
			aProcess resume.
			aStream yourself]
		do: 
			[Cursor write showWhile: [self saveToWRL97: aStream].
			(Delay forMilliseconds: 500) wait]
		ensure: 
			[aStream close.
			aProcess terminate.
			aProgress close].
	^self displayObject
]

{ #category : #writing }
JunOpenGLDisplayModel >> writeToWRL: aFilename [ 
	"
	| object model | 
	object := JunOpenGL3dObject cube. 
	model := JunOpenGLDisplayModel displayObject: object. 
	model writeToWRL: 'dummy.wrl' asFilename. 
	^model 
	"

	^self writeToWRL97: aFilename
]

{ #category : #'interface opening' }
JunOpenGLDisplayModel >> xThumbWheelView [
	| thumbWheel thumbWheelView |
	thumbWheel := JunThumbWheel vertical.
	thumbWheelView := JunThumbWheelView new.
	thumbWheelView model: thumbWheel.
	thumbWheel
		compute: 
			[:value | 
			| factor |
			factor := 0 , (value / 50) negated.
			self grab: factor].
	^thumbWheelView
]

{ #category : #'interface opening' }
JunOpenGLDisplayModel >> yThumbWheelView [
	| thumbWheel thumbWheelView |
	thumbWheel := JunThumbWheel horizontal.
	thumbWheelView := JunThumbWheelView new.
	thumbWheelView model: thumbWheel.
	thumbWheel
		compute: 
			[:value | 
			| factor |
			factor := value / 50 , 0.
			self grab: factor].
	^thumbWheelView
]

{ #category : #'interface opening' }
JunOpenGLDisplayModel >> zThumbWheelView [
	| thumbWheel thumbWheelView |
	thumbWheel := JunThumbWheel vertical.
	thumbWheelView := JunThumbWheelView new.
	thumbWheelView model: thumbWheel.
	thumbWheel compute: [:value | self dollyButton value = true
			ifTrue: 
				[| factor |
				factor := value / 400.
				self dolly: factor]
			ifFalse: 
				[| factor |
				factor := 1 + (value / 100).
				self zoom: factor]].
	^thumbWheelView
]

{ #category : #projection }
JunOpenGLDisplayModel >> zoom [
	^self zoom: 2
]

{ #category : #projection }
JunOpenGLDisplayModel >> zoom: factor [ 
	| zoomFactor |
	InputState default shiftDown
		ifTrue: [factor >= 1.0
				ifTrue: [zoomFactor := 1.0 + (factor - 1.0 * 0.1)]
				ifFalse: [zoomFactor := 1.0 - (1.0 - factor * 0.1)]]
		ifFalse: [zoomFactor := factor].
	self displayProjector zoom: zoomFactor.
	self changed: #projection
]

{ #category : #projection }
JunOpenGLDisplayModel >> zoomHeight [
	^self displayProjector zoomHeight
]

{ #category : #projection }
JunOpenGLDisplayModel >> zoomHeight: aNumber [ 
	self displayProjector zoomHeight: aNumber.
	self changed: #projection
]

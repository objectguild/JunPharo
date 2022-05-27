"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLStereoDisplayModel,
	#superclass : #JunOpenGLDisplayModel,
	#instVars : [
		'crossingHolder'
	],
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLStereoDisplayModel class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGLStereoDisplayModel class >> example [
	"JunOpenGLStereoDisplayModel example."

	| displayModel |
	displayModel := JunOpenGLStereoDisplayModel new.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLStereoDisplayModel class >> example2 [
	"JunOpenGLStereoDisplayModel example2."

	| aCube displayModel |
	aCube := JunOpenGL3dObject cube.
	aCube paint: (ColorValue
			red: 255 / 255
			green: 235 / 255
			blue: 215 / 255).
	displayModel := JunOpenGLStereoDisplayModel new.
	displayModel displayObject: aCube.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLStereoDisplayModel class >> example21 [
	"JunOpenGLStereoDisplayModel example21."

	| aCube displayModel |
	aCube := JunOpenGL3dObject cube.
	aCube paint: ColorValue gray.
	displayModel := JunOpenGLStereoDisplayModel new.
	displayModel displayObject: aCube.
	displayModel
		open;
		parallelProjection;
		wireframePresentation;
		crossing: true.
	^displayModel
]

{ #category : #examples }
JunOpenGLStereoDisplayModel class >> example8 [
	"JunOpenGLStereoDisplayModel example8."

	| displayObject displayModel |
	displayObject := JunOpenGL3dObject benzene.
	displayModel := JunOpenGLStereoDisplayModel new.
	displayModel displayObject: displayObject.
	displayModel viewFactor: 1.2.
	displayModel open.
	^displayModel
]

{ #category : #examples }
JunOpenGLStereoDisplayModel class >> example81 [
	"JunOpenGLStereoDisplayModel example81."

	| displayObject displayModel |
	displayObject := JunOpenGL3dObject benzene.
	displayModel := JunOpenGLStereoDisplayModel new.
	displayModel displayObject: displayObject.
	displayModel viewFactor: 1.2.
	displayModel
		open;
		parallelProjection;
		hiddenlinePresentation;
		crossing: true.
	^displayModel
]

{ #category : #resources }
JunOpenGLStereoDisplayModel class >> menuBar [
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
								#key: #jun_Save___ 
								#defaultString: 'Save...' ) 
							#value: #saveLST ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Quit 
								#defaultString: 'Quit' ) 
							#value: #quitDoing ) ) #(2 1 1 ) nil ) ) 
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
								#key: #jun_Reset 
								#defaultString: 'Reset' ) 
							#value: #resetView ) ) #(2 4 1 ) nil ) ) 
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
								#key: #jun_Spawn 
								#defaultString: 'Spawn' ) 
							#value: #spawnObject ) 
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
							#value: #inspectModel ) ) #(2 1 ) nil ) ) ) #(5 ) nil ) decodeAsLiteralArray
]

{ #category : #copyright }
JunOpenGLStereoDisplayModel class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLStereoDisplayModel class >> version [
	^'799'
]

{ #category : #'interface specs' }
JunOpenGLStereoDisplayModel class >> windowSpec [
	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: 
			#(#UserMessage 
				#key: #jun_Stereo_Viewfinder 
				#defaultString: 'Stereo Viewfinder' ) 
			#min: #(#Point 280 280 ) 
			#bounds: #(#Rectangle 100 100 640 400 ) 
			#flags: 4 
			#menu: #menuBar ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame 1 0.5 1 0 -20 1 -20 1 ) 
					#name: #leftDisplayView 
					#colors: 
					#(#LookPreferences 
						#setBackgroundColor: #(#ColorValue #white ) ) 
					#component: #leftDisplayView ) 
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame 20 0 1 0 -1 0.5 -20 1 ) 
					#name: #rightDisplayView 
					#colors: 
					#(#LookPreferences 
						#setBackgroundColor: #(#ColorValue #white ) ) 
					#component: #rightDisplayView ) 
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
					#component: #dollyButtonView ) 
				#(#CheckBoxSpec 
					#layout: #(#LayoutOrigin 0 0.8 -18 1 ) 
					#model: #crossingHolder 
					#label: 
					#(#UserMessage 
						#key: #jun_Crossing 
						#defaultString: 'Crossing' ) 
					#style: #default ) ) ) )
]

{ #category : #accessing }
JunOpenGLStereoDisplayModel >> crossing [
	^self crossingHolder value
]

{ #category : #accessing }
JunOpenGLStereoDisplayModel >> crossing: aBoolean [ 
	self crossingHolder value: aBoolean = true
]

{ #category : #aspects }
JunOpenGLStereoDisplayModel >> crossingHolder [
	crossingHolder isNil 
		ifTrue: 
			[crossingHolder := false asValue.
			crossingHolder compute: [:arg | self changed: #crossing]].
	^crossingHolder
]

{ #category : #defaults }
JunOpenGLStereoDisplayModel >> defaultPresentation [
	^self defaultProjectionTable at: #presentation
		ifAbsent: [^#wireframePresentation]
]

{ #category : #defaults }
JunOpenGLStereoDisplayModel >> defaultProjection [
	^self defaultProjectionTable at: #projection
		ifAbsent: [^#parallelProjection]
]

{ #category : #defaults }
JunOpenGLStereoDisplayModel >> defaultStereoscope [
	^self defaultProjectionTable at: #stereoscope ifAbsent: [^#noncrossing]
]

{ #category : #'initialize-release' }
JunOpenGLStereoDisplayModel >> initialize [
	super initialize.
	crossingHolder := nil
]

{ #category : #'interface opening' }
JunOpenGLStereoDisplayModel >> leftDisplayView [
	| aView |
	aView := JunOpenGLAngledDisplayView model: self angle: self stereoAngle.
	^aView
]

{ #category : #accessing }
JunOpenGLStereoDisplayModel >> postCreateDisplayProjector: aProjector [ 
	self defaultStereoscope = #crossing 
		ifTrue: [self crossing: true]
		ifFalse: [self crossing: false]
]

{ #category : #projection }
JunOpenGLStereoDisplayModel >> postGetProjectionTable: aDictionary [ 
	aDictionary at: #stereoscope
		put: (self crossing ifTrue: [#crossing] ifFalse: [#noncrossing]).
	^aDictionary
]

{ #category : #projection }
JunOpenGLStereoDisplayModel >> postPutProjectionTable: aDictionary into: aProjector [ 
	(aDictionary includesKey: #stereoscope) 
		ifTrue: 
			[(aDictionary at: #stereoscope) = #crossing 
				ifTrue: [self crossing: true]
				ifFalse: [self crossing: false]]
]

{ #category : #rendering }
JunOpenGLStereoDisplayModel >> renderOn: renderingContext angle: anAngle [ 
	self 
		renderOn: renderingContext
		angle: anAngle
		withDisplayList: nil
]

{ #category : #rendering }
JunOpenGLStereoDisplayModel >> renderOn: renderingContext angle: anAngle withDisplayList: displayListHolder [ 
	| aProjector |
	aProjector := self displayProjector copy.
	anAngle notNil 
		ifTrue: 
			[| transformation aProjection |
			transformation := Jun3dTransformation 
						rotate: (self crossing ifTrue: [anAngle negated] ifFalse: [anAngle])
						around: (Jun3dLine from: 0 , 0 , 0 to: aProjector upVector).
			aProjection := aProjector projection copy.
			aProjection eyePoint: (transformation applyTo: aProjection eyePoint).
			aProjector projection: aProjection].
	self 
		renderOn: renderingContext
		projector: aProjector
		withDisplayList: displayListHolder
]

{ #category : #rendering }
JunOpenGLStereoDisplayModel >> renderOn: renderingContext projector: projector withDisplayList: displayListHolder [ 
	| lightCollection renderingObject aProjector |
	renderingContext isNil ifTrue: [^self].
	renderingContext clear.
	lightCollection := self displayLightCollection.
	renderingObject := self displayObject.
	renderingObject isNil 
		ifTrue: [projector projectOn: renderingContext]
		ifFalse: 
			[self selectedObjects isEmpty 
				ifTrue: 
					[projector 
						project: renderingObject
						withLights: lightCollection
						on: renderingContext
						withDisplayList: displayListHolder]
				ifFalse: 
					[aProjector := projector copy.
					projector presentation = #solidPresentation 
						ifTrue: [aProjector wireframePresentation].
					projector presentation = #wireframePresentation 
						ifTrue: [aProjector wireframePresentation].
					projector presentation = #hiddenlinePresentation 
						ifTrue: [aProjector hiddenlinePresentation].
					aProjector 
						project: renderingObject
						withLights: lightCollection
						on: renderingContext
						withDisplayList: displayListHolder.
					projector presentation = #solidPresentation 
						ifTrue: [aProjector solidPresentation].
					projector presentation = #wireframePresentation 
						ifTrue: [aProjector solidPresentation].
					projector presentation = #hiddenlinePresentation 
						ifTrue: [aProjector solidPresentation].
					self selectedObjects 
						do: [:each | aProjector project: each on: renderingContext]]]
]

{ #category : #'interface opening' }
JunOpenGLStereoDisplayModel >> rightDisplayView [
	| aView |
	aView := JunOpenGLAngledDisplayView model: self
				angle: self stereoAngle negated.
	^aView
]

{ #category : #private }
JunOpenGLStereoDisplayModel >> stereoAngle [
	^JunAngle fromDeg: 1.5
]

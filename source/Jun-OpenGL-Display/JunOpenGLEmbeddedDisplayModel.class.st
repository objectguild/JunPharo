"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLEmbeddedDisplayModel,
	#superclass : #JunOpenGLDisplayModel,
	#instVars : [
		'needsToFit'
	],
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLEmbeddedDisplayModel class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'interface specs' }
JunOpenGLEmbeddedDisplayModel class >> embeddedWindowSpec [
	^self windowSpec
]

{ #category : #examples }
JunOpenGLEmbeddedDisplayModel class >> example1 [
	"JunOpenGLEmbeddedDisplayModel example1."

	| displayModel |
	displayModel := JunOpenGLEmbeddedDisplayModel displayObject: JunOpenGL3dObject cube.
	displayModel open.
	^displayModel
]

{ #category : #resources }
JunOpenGLEmbeddedDisplayModel class >> menuBar [
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
							#value: #saveAsImage ) ) #(3 ) nil ) ) 
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

{ #category : #copyright }
JunOpenGLEmbeddedDisplayModel class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLEmbeddedDisplayModel class >> version [
	^'799'
]

{ #category : #accessing }
JunOpenGLEmbeddedDisplayModel >> displayObject: a3dObject [ 
	self needsToFit: true.
	self setDisplayObject: a3dObject
]

{ #category : #'interface opening' }
JunOpenGLEmbeddedDisplayModel >> displayView [
	| aView |
	aView := JunOpenGLEmbeddedDisplayView model: self.
	aView controller menuHolder value: self menuBar.
	aView controller performer: self.
	^aView
]

{ #category : #private }
JunOpenGLEmbeddedDisplayModel >> getSubCanvas [
	| aView aSubCanvas |
	aView := self getView.
	aView isNil ifTrue: [^nil].
	aSubCanvas := aView.
	[aSubCanvas notNil and: [(aSubCanvas isKindOf: SubCanvas) not]] 
		whileTrue: 
			[(aSubCanvas respondsTo: #container) 
				ifTrue: [aSubCanvas := aSubCanvas container]
				ifFalse: [aSubCanvas := nil]].
	^aSubCanvas
]

{ #category : #accessing }
JunOpenGLEmbeddedDisplayModel >> needsToFit [
	needsToFit isNil ifTrue: [needsToFit := true].
	^needsToFit
]

{ #category : #accessing }
JunOpenGLEmbeddedDisplayModel >> needsToFit: aBoolean [ 
	needsToFit := aBoolean
]

{ #category : #accessing }
JunOpenGLEmbeddedDisplayModel >> setDisplayObject: a3dObject [ 
	displayObject isNil ifTrue: [self flushProjector].
	displayObject := a3dObject.
	self clearSelectedObjects.
	self updateMenuIndication.
	self showModel notNil ifTrue: [self showModel flushObject].
	self needsToFit 
		ifTrue: 
			[self fitSilently.
			self needsToFit: false].
	self changed: #object
]

{ #category : #'menu messages' }
JunOpenGLEmbeddedDisplayModel >> spawn [
	self displayObject notNil ifTrue: [self displayObject show]
]

{ #category : #'menu messages' }
JunOpenGLEmbeddedDisplayModel >> spawnObject [
	| displayModel aView |
	displayModel := self class superclass displayObject: self spawningObject.
	displayModel displayProjection: self displayProjection copy.
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

{ #category : #private }
JunOpenGLEmbeddedDisplayModel >> spawnViewport [
	| model window |
	(model := self showModel) isNil 
		ifTrue: [model := JunOpenGLShowModel displayModel: self].
	(model builder notNil and: [(window := model builder window) isOpen]) 
		ifTrue: 
			[window isCollapsed ifTrue: [window expand].
			window raise]
		ifFalse: 
			[| canvas box area |
			canvas := self getSubCanvas.
			canvas isNil 
				ifTrue: [model open]
				ifFalse: 
					[box := canvas topComponent displayBox.
					area := 0 @ 0 extent: canvas bounds extent.
					area := area align: area topLeft with: box topRight + (5 @ 0).
					model openIn: area]].
	JunApplicationModel displayPendingInvalidation
]

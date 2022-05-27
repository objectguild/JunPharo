"
Imported by VwImportClass
"
Class {
	#name : #JunCADModel,
	#superclass : #JunOpenGLDisplayModel,
	#instVars : [
		'layerNames',
		'hiddenObjects',
		'font'
	],
	#category : #'Jun-DXF-Support'
}

{ #category : #fonts }
JunCADModel class >> characterBox [
	| obj obs pl r1 r2 cc |
	obs := OrderedCollection new: 20.
	r1 := 0.
	r2 := 32.
	0
		to: 24
		by: 2
		do: 
			[:col | 
			pl := JunOpenGL3dPolyline vertexes: (Array with: col , r1 , 0 with: col , r2 , 0).
			obs add: pl].
	0
		to: 24
		by: 5
		do: 
			[:col | 
			r1 := 1.
			col \\ 10 = 0 ifTrue: [r1 := r1 + 1].
			pl := JunOpenGL3dPolyline vertexes: (Array with: col , 0 , 0 with: col , (0 - r1) , 0).
			obs add: pl.
			pl := JunOpenGL3dPolyline vertexes: (Array with: col , 32 , 0 with: col , (32 + r1) , 0).
			obs add: pl].
	0
		to: 32
		by: 2
		do: 
			[:row | 
			r1 := 0.
			r2 := 24.
			row \\ 5 = 0
				ifTrue: 
					[r1 := r1 - 1.
					r2 := r2 + 1].
			row \\ 10 = 0
				ifTrue: 
					[r1 := r1 - 1.
					r2 := r2 + 1].
			pl := JunOpenGL3dPolyline vertexes: (Array with: r1 , row , 0 with: r2 , row , 0).
			obs add: pl].
	r2 := 24.
	0
		to: 32
		by: 5
		do: 
			[:row | 
			r1 := 1.
			row \\ 10 = 0 ifTrue: [r1 := r1 + 1].
			pl := JunOpenGL3dPolyline vertexes: (Array with: 0 - r1 , row , 0 with: 0 , row , 0).
			obs add: pl.
			pl := JunOpenGL3dPolyline vertexes: (Array with: r2 , row , 0 with: r2 + r1 , row , 0).
			obs add: pl].
	cc := JunOpenGL3dPolylineLoop vertexes: (Array with: -1, -1, 0 with: -1, 1, 0 with: 1, 1, 0 with: 1, -1, 0).
	obs add: cc.
	cc := JunOpenGL3dPolylineLoop vertexes: (Array with: -1, 31, 0 with: -1, 33, 0 with: 1, 33, 0 with: 1, 31, 0).
	obs add: cc.
	obj := JunOpenGL3dCompoundObject components: obs.
	^obj
]

{ #category : #copyright }
JunCADModel class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunCADModel class >> example1 [
	"JunCADModel example1"

	JunCADModel open
]

{ #category : #resources }
JunCADModel class >> menuBar [
	"MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 'File' 
				#submenu: #(#Menu #(
						#(#MenuItem 
							#rawLabel: 'New' 
							#value: #newModel ) 
						#(#MenuItem 
							#rawLabel: 'Open...' 
							#value: #openLST ) 
						#(#MenuItem 
							#rawLabel: 'Open as...' 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 'DXF File...' 
										#value: #openDXF ) 
									#(#MenuItem 
										#rawLabel: 'VRML 1.0...' 
										#value: #openWRL10 ) 
									#(#MenuItem 
										#rawLabel: 'VRML 2.0...' 
										#value: #openWRL20 ) ) #(3 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 'Save...' 
							#value: #saveLST ) 
						#(#MenuItem 
							#rawLabel: 'Save as...' 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 'DXF file...' 
										#value: #saveDXF ) 
									#(#MenuItem 
										#rawLabel: 'VRML 1.0...' 
										#value: #saveWRL10 ) 
									#(#MenuItem 
										#rawLabel: 'VRML 2.0...' 
										#value: #saveWRL20 ) ) #(3 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 'Save as image...' 
							#value: #saveAsImage ) 
						#(#MenuItem 
							#rawLabel: 'Quit' 
							#value: #quitDoing ) ) #(3 3 1 ) nil ) ) 
			#(#MenuItem 
				#rawLabel: 'Edit' 
				#submenu: #(#Menu #(
						#(#MenuItem 
							#rawLabel: 'Copy' 
							#value: #copyObject ) 
						#(#MenuItem 
							#rawLabel: 'Cut' 
							#value: #cutObject ) 
						#(#MenuItem 
							#rawLabel: 'Paste' 
							#value: #pasteObject ) 
						#(#MenuItem 
							#rawLabel: 'Clear' 
							#value: #clearObject ) 
						#(#MenuItem 
							#rawLabel: 'Select all' 
							#value: #selectAll ) ) #(4 1 ) nil ) ) 
			#(#MenuItem 
				#rawLabel: 'View' 
				#submenu: #(#Menu #(
						#(#MenuItem 
							#rawLabel: 'Zooming' 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 'Fit zoom' 
										#value: #fitZoom ) 
									#(#MenuItem 
										#rawLabel: 'Close up' 
										#value: #closeUp ) 
									#(#MenuItem 
										#rawLabel: 'Zoom' 
										#value: #zoom ) 
									#(#MenuItem 
										#rawLabel: 'Pan' 
										#value: #pan ) ) #(2 2 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 'Pointing' 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 'Fit sight' 
										#value: #fitSight ) 
									#(#MenuItem 
										#rawLabel: 'Eye point...' 
										#value: #changeEyePoint ) 
									#(#MenuItem 
										#rawLabel: 'Sight point...' 
										#value: #changeSightPoint ) 
									#(#MenuItem 
										#rawLabel: 'Up vector...' 
										#value: #changeUpVector ) 
									#(#MenuItem 
										#rawLabel: 'View factor...' 
										#value: #changeViewFactor ) ) #(1 3 1 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 'Projection' 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 'Perspective' 
										#value: #perspectiveProjection ) 
									#(#MenuItem 
										#rawLabel: 'Parallel' 
										#value: #parallelProjection ) ) #(2 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 'Presentation' 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 'Solid' 
										#value: #solidPresentation ) 
									#(#MenuItem 
										#rawLabel: 'Wireframe' 
										#value: #wireframePresentation ) 
									#(#MenuItem 
										#rawLabel: 'Hidden-line' 
										#value: #hiddenlinePresentation ) ) #(3 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 'Shading' 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 'Flat' 
										#value: #flatShading ) 
									#(#MenuItem 
										#rawLabel: 'Smooth' 
										#value: #smoothShading ) ) #(2 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 'Smoothing' 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 'Line smooth' 
										#value: #lineSmooth ) 
									#(#MenuItem 
										#rawLabel: 'Polygon smooth' 
										#value: #polygonSmooth ) ) #(2 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 'Reset' 
							#value: #resetView ) ) #(2 4 1 ) nil ) ) 
			#(#MenuItem 
				#rawLabel: 'Light' 
				#submenu: #(#Menu #(
						#(#MenuItem 
							#rawLabel: 'Light1' 
							#value: #openLight1 ) 
						#(#MenuItem 
							#rawLabel: 'Light2' 
							#value: #openLight2 ) 
						#(#MenuItem 
							#rawLabel: 'Light3' 
							#value: #openLight3 ) 
						#(#MenuItem 
							#rawLabel: 'Light4' 
							#value: #openLight4 ) 
						#(#MenuItem 
							#rawLabel: 'Ambient' 
							#value: #openLight5 ) ) #(4 1 ) nil ) ) 
			#(#MenuItem 
				#rawLabel: 'Layers' 
				#submenu: #(#Menu #(
						#(#MenuItem 
							#rawLabel: 'Show all' 
							#value: #allLayersShow ) 
						#(#MenuItem 
							#rawLabel: 'Hide all' 
							#value: #allLayersHide ) ) #(2 ) nil ) ) 
			#(#MenuItem 
				#rawLabel: 'Misc' 
				#submenu: #(#Menu #(
						#(#MenuItem 
							#rawLabel: 'Texture' 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 'From user...' 
										#value: #textureFromUser ) 
									#(#MenuItem 
										#rawLabel: 'From file...' 
										#value: #textureFromFile ) 
									#(#MenuItem 
										#rawLabel: 'Take away' 
										#value: #textureTakeAway ) 
									#(#MenuItem 
										#rawLabel: 'Linear approx.' 
										#value: #textureLinear ) 
									#(#MenuItem 
										#rawLabel: 'Clamp' 
										#value: #textureClamp ) 
									#(#MenuItem 
										#rawLabel: 'Modulate' 
										#value: #textureModulate ) 
									#(#MenuItem 
										#rawLabel: 'Mipmap' 
										#value: #textureMipmap ) ) #(3 4 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 'Spawn' 
							#value: #spawnObject ) 
						#(#MenuItem 
							#rawLabel: 'Viewport' 
							#value: #spawnViewport ) 
						#(#MenuItem 
							#rawLabel: 'Bounds' 
							#value: #showBounds ) 
						#(#MenuItem 
							#rawLabel: 'Inspect' 
							#value: #inspectModel ) ) #(4 1 ) nil ) ) ) #(6 ) nil ) decodeAsLiteralArray
]

{ #category : #copyright }
JunCADModel class >> system [
	^'Jun'
]

{ #category : #copyright }
JunCADModel class >> version [
	^'799'
]

{ #category : #'interface specs' }
JunCADModel class >> windowSpec [
	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: 
			#(#UserMessage 
				#key: #jun_DXF_Viewer 
				#defaultString: 'DXF Viewer' ) 
			#min: #(#Point 280 280 ) 
			#bounds: #(#Rectangle 302 343 602 643 ) 
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
						#setBackgroundColor: #(#ColorValue #black ) ) 
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

{ #category : #'interface opening' }
JunCADModel >> addLayerMenuItems [
	"set the 'Layers' menu to be check-marked lines with layer names 
	so the user can turn individual layers on and off"

	| bar daMenu sub strings groupSize menuItemGroup valueGroup theMenuItem theValue ss eachLayerSubmenu |
	bar := self builder menuAt: #menuBar.
	bar isNil ifTrue: [^nil].
	daMenu := self menuItemLabeled: 'Layers' inMenu: bar.
	daMenu isNil ifTrue: [^nil].
	"Transcript cr; show: '    menu ', daMenu printString."
	sub := daMenu submenu.
	sub menuItems do: [:x | sub removeItem: x].
	theMenuItem := MenuItem labeled: 'LayerWindow'.
	theMenuItem disable.
	"sub addItem: theMenuItem value: #openLayerWindow.
	menuItemGroup := Array with: 'Show All' with: 'Hide All'.
	valueGroup := Array with: [self allLayersShow] with: [self allLayersHide].
	sub addItemGroup: menuItemGroup values: valueGroup."
	sub addItemLabel: 'Show All' value: #allLayersShow.
	sub addItemLabel: 'Hide All' value: #allLayersHide.
	strings := self layerNames keys asSortedCollection.
	groupSize := strings size.
	menuItemGroup := Array new: groupSize.
	valueGroup := Array new: groupSize.
	1 to: groupSize
		do: 
			[:index | 
			ss := strings at: index.
			theMenuItem := MenuItem labeled: ss.
			theMenuItem beOn.
			theValue := [self toggleLayer: ss].
			menuItemGroup at: index put: theMenuItem.
			valueGroup at: index put: theValue].
	"sub addItemGroup: menuItemGroup values: valueGroup."
	eachLayerSubmenu := Menu new addItemGroup: menuItemGroup values: valueGroup.
	sub addItem: ((MenuItem labeled: 'Layers') submenu: eachLayerSubmenu)
]

{ #category : #'menu messages' }
JunCADModel >> allLayersHide [
	self toggleAllLayersOff.
	self changed: #object
]

{ #category : #'menu messages' }
JunCADModel >> allLayersShow [
	self toggleAllLayersOn.
	self changed: #object
]

{ #category : #defaults }
JunCADModel >> defaultEyePoint [
	"assume 2d data, looking down Z axis"

	| box distance |
	self displayObject isNil ifTrue: [^0 , 0 , 10000].
	^self defaultProjectionTable at: #eyePoint
		ifAbsent: 
			[box := self boundingBox.
			distance := box depth.
			distance := distance * 2 max: 10000.
			^self defaultSightPoint + (0 , 0 , distance)]
]

{ #category : #defaults }
JunCADModel >> defaultUpVector [
	"assume 2d data, looking down Z axis"

	^self defaultProjectionTable at: #upVector ifAbsent: [^0 , 1 , 0]
]

{ #category : #accessing }
JunCADModel >> displayProjector [
	"overide this to set Parallel projection"

	displayProjector isNil
		ifTrue: 
			[displayProjector := JunOpenGLProjector new.
			displayProjector projection: displayProjector projection asParallelProjection.
			displayProjector eyePoint: self defaultEyePoint.
			displayProjector sightPoint: self defaultSightPoint.
			displayProjector upVector: self defaultUpVector.
			displayProjector viewFactor: self defaultViewFactor].
	^displayProjector
]

{ #category : #projection }
JunCADModel >> fitSilently [
	"assume 2d kind of data, so look from top down along the Z axis"

	| sightPoint zoomHeight |
	self displayObject isNil ifTrue: [^self].
	JunCursorAnimator clockCursors
		showWhile: 
			[sightPoint := self computeSightPoint.
			self displayProjector sightPoint: sightPoint.
			zoomHeight := self computeZoomHeight.
			self displayProjector zoomHeight: zoomHeight]
]

{ #category : #accessing }
JunCADModel >> flushHiddenObjects [
	hiddenObjects := nil.
	^self
]

{ #category : #accessing }
JunCADModel >> font [
	font isNil
		ifTrue: 
			[| separatorString directoryString fontName filename |
			fontName := 'dxffont.lst'.
			separatorString := String with: Filename separator.
			directoryString := Filename currentDirectory asString.
			directoryString last = Filename separator
				ifTrue: [directoryString := directoryString , 'fonts' , separatorString]
				ifFalse: [directoryString := directoryString , separatorString , 'fonts' , separatorString].
			filename := Filename named: directoryString , fontName.
			filename exists ifTrue: [self loadFont: filename]].
	^font
]

{ #category : #layers }
JunCADModel >> hiddenLayerAt: aString [ 
	"find object in the cache"

	| obs aLayer |
	obs := self hiddenObjects.
	aLayer := obs detect: [:x | x name = aString]
				ifNone: [nil].
	^aLayer
]

{ #category : #accessing }
JunCADModel >> hiddenObjects [
	"cache the layers which have been hidden, in case they get turned on again"

	hiddenObjects isNil ifTrue: [hiddenObjects := OrderedCollection new].
	^hiddenObjects
]

{ #category : #layers }
JunCADModel >> layerAt: aString [ 
	"find object in the layers list"

	| obs aLayer |
	obs := displayObject components.
	aLayer := obs detect: [:x | x name = aString]
				ifNone: [nil].
	^aLayer
]

{ #category : #accessing }
JunCADModel >> layerNameStrings [
	^self layerNames keys asSortedCollection
]

{ #category : #accessing }
JunCADModel >> layerNames [
	^layerNames
]

{ #category : #accessing }
JunCADModel >> layerNames: aList [ 
	layerNames := aList.
	^self
]

{ #category : #layers }
JunCADModel >> layersMenu [
	"answer the final menu with all the layer labels"

	| bar daMenu sub |
	bar := self builder menuAt: #menuBar.
	bar isNil ifTrue: [^nil].
	daMenu := self menuItemLabeled: 'Layers' inMenu: bar.
	daMenu isNil ifTrue: [^nil].
	sub := self menuItemLabeled: 'Layers' inMenu: daMenu submenu.
	sub isNil ifTrue: [^nil].
	^sub submenu
]

{ #category : #fonts }
JunCADModel >> loadFont [
	| letters model x offset ob objects y xSpacing ySpacing |
	letters := self readFromLST10: 'fonts\dxffont.lst'.
	"letters := self readFromLST10: 'd:\data\dxf\fonts\dxffont.lst'."
	letters isNil ifTrue: [^self].
	x := 0.
	y := 0.
	xSpacing := 24.
	ySpacing := 32.
	objects := OrderedCollection new: letters size.
	letters
		do: 
			[:letter | 
			(x >= (xSpacing * 8))
				ifTrue: [x := 0. y := y - ySpacing].
			offset := x , y , 0.
			ob := letter translatedBy: offset.
			ob paint: (ColorValue red).
			objects add: ob.
			x := x + xSpacing].
	self displayObject: (JunOpenGL3dCompoundObject components: objects).
	self resetView.
	(model := self showModel) isNil ifFalse: [model resetView]
]

{ #category : #fonts }
JunCADModel >> loadFont: aFilename [ 
	| letters theLetter |
	letters := self readFromLST10: aFilename.
	letters isNil ifTrue: [^self].
	font isNil ifTrue:[ font := Dictionary new: 40].
	letters do: [:letter | Transcript cr; show: 'letter: ' , letter name.
			theLetter := letter name first. "character"
			font at: theLetter put: letter.]
]

{ #category : #'menu messages' }
JunCADModel >> openDXF [
	| labels values menu file object model |
	labels := Array with: (Array 
						with: (#jun__1s__files >> '<1s> files' expandMacrosWith: 'DXF')).
	values := Array with: #('*.dxf' '*.DXF').
	menu := Menu labelList: labels values: values.
	file := JunFileRequesterDialog 
				requestFilename: (#jun_Select_a__1s__file_ >> 'Select a <1s> file.' 
						expandMacrosWith: 'DXF')
				initialFilename: nil
				fileTypeMenu: menu
				initialFileType: values first.
	file isNil ifTrue: [^self].
	object := self readFromDXF: file.
	object isNil ifTrue: [^self].
	self setLayerNames: object keys.
	self displayObject: (JunOpenGL3dCompoundObject components: object values).
	self addLayerMenuItems.
	self resetView.
	(model := self showModel) isNil ifFalse: [model resetView]
]

{ #category : #'menu messages' }
JunCADModel >> openParser: aParser [ 
	| object model |
	object := aParser layers.
	object isNil ifTrue: [^self].
	self setLayerNames: object keys.
	self displayObject: (JunOpenGL3dCompoundObject components: object values).
	self addLayerMenuItems.
	self resetView.
	(model := self showModel) isNil ifFalse: [model resetView]
]

{ #category : #reading }
JunCADModel >> readFromDXF: file [ 
	"
	| object | 
	object := JunOpenGLDisplayModel new readFromDXF: JunUniFileModel requestFileName. 
	object isNil ifTrue: [^nil]. 
	object show. 
	^object 
	"

	| parser obj |
	obj := nil.
	file isNil ifTrue: [^nil].
	parser := JunDXFParser onSmart: file.
	parser parsedOk ifTrue: [obj := parser layers].
	^obj
]

{ #category : #layers }
JunCADModel >> setLayerNames: aList [ 
	"keep track of which layers are displayed. 
	boolean values are not currently used..."

	self layerNames: Dictionary new.
	aList do: [:x | self layerNames at: x put: true]
]

{ #category : #fonts }
JunCADModel >> showFont [
	| letters model x offset ob square newUnit objects y xSpacing ySpacing |
	letters := self readFromLST10: 'fonts\dxffont.lst'.
	"letters := self readFromLST10: 'd:\data\dxf\fonts\dxffont.lst'."
	letters isNil ifTrue: [^self].
	x := 0.
	y := 0.
	xSpacing := 24.
	ySpacing := 32.
	objects := OrderedCollection new: letters size.
	letters
		do: 
			[:letter | 
			(x >= (xSpacing * 8))
				ifTrue: [x := 0. y := y - ySpacing].
			offset := x , y , 0.
			ob := letter translatedBy: offset.
			ob paint: (ColorValue red).
			square := self class characterBox translatedBy: offset.
			square paint: (ColorValue gray).
			newUnit := JunOpenGL3dCompoundObject components: (Array with: ob with: square).
			objects add: newUnit.
			x := x + xSpacing].
	self displayObject: (JunOpenGL3dCompoundObject components: objects).
	self resetView.
	(model := self showModel) isNil ifFalse: [model resetView]
]

{ #category : #layers }
JunCADModel >> toggleAllLayersOff [
	"hide all layers"

	self layerNameStrings do: [:x | self toggleLayerOff: x]
]

{ #category : #layers }
JunCADModel >> toggleAllLayersOn [
	"show all layers"

	self layerNameStrings do: [:x | self toggleLayerOn: x]
]

{ #category : #'menu messages' }
JunCADModel >> toggleLayer: aString [ 
	| layer |
	layer := self layerAt: aString.
	layer isNil
		ifTrue: [self toggleLayerOn: aString]
		ifFalse: [self toggleLayerOff: aString].
	self changed: #object
]

{ #category : #layers }
JunCADModel >> toggleLayerMenu: aString [ 
	"change the checkmark in the Layers menu"

	| mItem layerMenu |
	layerMenu := self layersMenu.
	layerMenu isNil ifTrue: [^nil].
	mItem := self menuItemLabeled: aString inMenu: layerMenu.
	mItem isNil 
		ifFalse: [mItem isOn ifTrue: [mItem beOff] ifFalse: [mItem beOn]]
]

{ #category : #layers }
JunCADModel >> toggleLayerOff: aString [ 
	"hide this layer by removing it from the displayObject and caching it"

	| layer obj |
	layer := self layerAt: aString.
	layer isNil
		ifFalse: 
			[self hiddenObjects add: layer.
			obj := self displayObject components remove: layer ifAbsent: [nil].
			obj isNil ifFalse: [self toggleLayerMenu: aString]]
]

{ #category : #layers }
JunCADModel >> toggleLayerOn: aString [ 
	"make this layer visible again"

	| layer |
	layer := self hiddenLayerAt: aString.
	layer isNil
		ifFalse: 
			[self hiddenObjects remove: layer.
			self displayObject add: layer.
			self toggleLayerMenu: aString]
]

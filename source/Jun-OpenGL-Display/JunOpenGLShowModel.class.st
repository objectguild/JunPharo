"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLShowModel,
	#superclass : #JunApplicationModel,
	#instVars : [
		'displayModel',
		'showObject',
		'showProjector',
		'viewportSight',
		'viewportHeight',
		'useTransparency',
		'pushButtons'
	],
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLShowModel class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunOpenGLShowModel class >> displayModel: aDisplayModel [ 
	"JunOpenGLShowModel 
	displayModel: (JunOpenGLDisplayModel displayObject: JunOpenGL3dObject cube)."

	| showModel |
	showModel := self new.
	showModel displayModel: aDisplayModel.
	^showModel
]

{ #category : #'instance creation' }
JunOpenGLShowModel class >> displayObject: a3dObject [ 
	"JunOpenGLShowModel displayObject: JunOpenGL3dObject cube."

	| showModel |
	showModel := self new.
	showModel displayObject: a3dObject.
	^showModel
]

{ #category : #examples }
JunOpenGLShowModel class >> example [
	"JunOpenGLShowModel example."

	| showModel |
	showModel := JunOpenGLShowModel new.
	showModel open.
	^showModel
]

{ #category : #examples }
JunOpenGLShowModel class >> example1 [
	"JunOpenGLShowModel example1."

	| fileName aStream aBody showModel |
	fileName := JunUniFileModel requestFileName.
	fileName isNil ifTrue: [^nil].
	aStream := fileName readStream.
	[Cursor read showWhile: [aBody := JunOpenGL3dObject loadFrom: aStream]]
		ensure: [aStream close].
	showModel := JunOpenGLShowModel new.
	showModel displayObject: aBody.
	showModel open.
	^showModel
]

{ #category : #examples }
JunOpenGLShowModel class >> example2 [
	"JunOpenGLShowModel example2."

	| aCube showModel |
	aCube := JunOpenGL3dObject cube.
	aCube := aCube translatedBy: 2 , 2 , 2.
	aCube paint: (ColorValue
			red: 255 / 255
			green: 235 / 255
			blue: 215 / 255).
	showModel := JunOpenGLShowModel new.
	showModel displayObject: aCube.
	showModel open.
	^showModel
]

{ #category : #resources }
JunOpenGLShowModel class >> menuBar [
	"MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_View 
					#defaultString: 'View' ) 
				#submenu: #(#Menu #(
						#(#MenuItem 
							#rawLabel: 
							#(#UserMessage 
								#key: #jun_Zooming 
								#defaultString: 'Zooming' ) 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Fit_zoom 
											#defaultString: 'Fit zoom' ) 
										#value: #fitZoom ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Zoom 
											#defaultString: 'Zoom' ) 
										#value: #zoom ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Pan 
											#defaultString: 'Pan' ) 
										#value: #pan ) ) #(1 2 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 
							#(#UserMessage 
								#key: #jun_Pointing 
								#defaultString: 'Pointing' ) 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Fit_sight 
											#defaultString: 'Fit sight' ) 
										#value: #fitSight ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Eye_point___ 
											#defaultString: 'Eye point...' ) 
										#value: #changeEyePoint ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Sight_point___ 
											#defaultString: 'Sight point...' ) 
										#value: #changeSightPoint ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Up_vector___ 
											#defaultString: 'Up vector...' ) 
										#value: #changeUpVector ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Zoom_height___ 
											#defaultString: 'Zoom height...' ) 
										#value: #changeZoomHeight ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_View_factor___ 
											#defaultString: 'View factor...' ) 
										#value: #changeViewFactor ) ) #(1 3 2 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 
							#(#UserMessage 
								#key: #jun_Projection 
								#defaultString: 'Projection' ) 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Perspective 
											#defaultString: 'Perspective' ) 
										#value: #perspectiveProjection ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Parallel 
											#defaultString: 'Parallel' ) 
										#value: #parallelProjection ) ) #(2 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 
							#(#UserMessage 
								#key: #jun_Presentation 
								#defaultString: 'Presentation' ) 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Solid 
											#defaultString: 'Solid' ) 
										#value: #solidPresentation ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Wireframe 
											#defaultString: 'Wireframe' ) 
										#value: #wireframePresentation ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Hidden_line 
											#defaultString: 'Hidden-line' ) 
										#value: #hiddenlinePresentation ) ) #(3 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 
							#(#UserMessage 
								#key: #jun_Shading 
								#defaultString: 'Shading' ) 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Flat 
											#defaultString: 'Flat' ) 
										#value: #flatShading ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Smooth 
											#defaultString: 'Smooth' ) 
										#value: #smoothShading ) ) #(2 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 
							#(#UserMessage 
								#key: #jun_Smoothing 
								#defaultString: 'Smoothing' ) 
							#submenu: #(#Menu #(
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Line_smooth 
											#defaultString: 'Line smooth' ) 
										#value: #lineSmooth ) 
									#(#MenuItem 
										#rawLabel: 
										#(#UserMessage 
											#key: #jun_Polygon_smooth 
											#defaultString: 'Polygon smooth' ) 
										#value: #polygonSmooth ) ) #(2 ) nil ) ) 
						#(#MenuItem 
							#rawLabel: 
							#(#UserMessage 
								#key: #jun_Reset 
								#defaultString: 'Reset' ) 
							#value: #resetView ) ) #(2 4 1 ) nil ) ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Misc 
					#defaultString: 'Misc' ) 
				#submenu: #(#Menu #(
						#(#MenuItem 
							#rawLabel: 
							#(#UserMessage 
								#key: #jun_Spawn 
								#defaultString: 'Spawn' ) 
							#value: #spawnObject ) 
						#(#MenuItem 
							#rawLabel: 
							#(#UserMessage 
								#key: #jun_Viewfinder 
								#defaultString: 'Viewfinder' ) 
							#value: #spawnViewfinder ) 
						#(#MenuItem 
							#rawLabel: 
							#(#UserMessage 
								#key: #jun_Stipple_or_Transparency 
								#defaultString: 'Stipple or Transparency' ) 
							#value: #switchStippleAndTransparency ) 
						#(#MenuItem 
							#rawLabel: 
							#(#UserMessage 
								#key: #jun_Inspect 
								#defaultString: 'Inspect' ) 
							#value: #inspectModel ) ) #(2 1 1 ) nil ) ) ) #(2 ) nil ) decodeAsLiteralArray
]

{ #category : #'instance creation' }
JunOpenGLShowModel class >> new [
	
	^super new yourself
]

{ #category : #utilities }
JunOpenGLShowModel class >> show: a3dObject [ 
	"JunOpenGLShowModel show: JunOpenGL3dObject cube."

	^self show: a3dObject eyePoint: nil
]

{ #category : #utilities }
JunOpenGLShowModel class >> show: a3dObject eyePoint: eyePoint [
	"JunOpenGLShowModel 
		show: JunOpenGL3dObject cube 
		eyePoint: 10 , 0 , 0."

	^self
		show: a3dObject
		eyePoint: eyePoint
		sightPoint: nil
]

{ #category : #utilities }
JunOpenGLShowModel class >> show: a3dObject eyePoint: eyePoint sightPoint: sightPoint [
	"JunOpenGLShowModel 
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
JunOpenGLShowModel class >> show: a3dObject eyePoint: eyePoint sightPoint: sightPoint upVector: upVector [
	"JunOpenGLShowModel 
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
JunOpenGLShowModel class >> show: a3dObject eyePoint: eyePoint sightPoint: sightPoint upVector: upVector viewFactor: viewFactor [ 
	"JunOpenGLShowModel 
		show: JunOpenGL3dObject cube 
		eyePoint: 10 , 0 , 0 
		sightPoint: 0 , 0 , 0 
		upVector: 0, 1,0 
		viewFactor: 10."

	| showModel |
	showModel := self displayObject: a3dObject.
	eyePoint notNil ifTrue: [showModel defaultEyePoint: eyePoint].
	sightPoint notNil ifTrue: [showModel defaultSightPoint: sightPoint].
	upVector notNil ifTrue: [showModel defaultUpVector: upVector].
	viewFactor notNil ifTrue: [showModel defaultViewFactor: viewFactor].
	showModel open.
	^showModel
]

{ #category : #copyright }
JunOpenGLShowModel class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLShowModel class >> version [
	^'799'
]

{ #category : #'interface specs' }
JunOpenGLShowModel class >> windowSpec [
	"UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: 
			#(#UserMessage 
				#key: #jun_Viewport 
				#defaultString: 'Viewport' ) 
			#min: #(#Point 280 280 ) 
			#bounds: #(#Rectangle 100 100 400 400 ) 
			#flags: 4 
			#menu: #menuBar ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame 20 0 1 0 -20 1 -20 1 ) 
					#name: #showView 
					#colors: 
					#(#LookPreferences 
						#setBackgroundColor: #(#ColorValue #white ) ) 
					#component: #showView ) 
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame 1 0 1 0 19 0 19 0 ) 
					#name: #bullButtonView 
					#flags: 0 
					#component: #bullButtonView ) 
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
					#component: #zThumbWheelView ) ) ) )
]

{ #category : #'bounds accessing' }
JunOpenGLShowModel >> boundingBox [
	self showObject isNil ifTrue: [^Jun3dBoundingBox origin: 0 , 0 , 0 corner: 0 , 0 , 0].
	^self showObject boundingBox
]

{ #category : #manipulating }
JunOpenGLShowModel >> bull: from2dPoint xy: to2dPoint [ 
	| aModel aProjection grabSphere fromPoint toPoint rotationAngle |
	self displayObject isNil ifTrue: [^self].
	aModel := self displayModel.
	aProjection := aModel displayProjection.
	grabSphere := aModel grabSphere.
	fromPoint := self grab3dPoint: from2dPoint x , from2dPoint y.
	toPoint := self grab3dPoint: to2dPoint x , to2dPoint y.
	rotationAngle := (Jun3dLine from: grabSphere center to: toPoint)
				angleWithLine: (Jun3dLine from: grabSphere center to: fromPoint).
	rotationAngle rad abs > self thetaAccuracy
		ifTrue: 
			[| rotationAxis transformation transformationInv upPoint |
			rotationAxis := Jun3dLine from: grabSphere center to: grabSphere center - (fromPoint - grabSphere center product: toPoint - grabSphere center).
			transformation := Jun3dTransformation rotate: rotationAngle around: rotationAxis.
			transformationInv := Jun3dTransformation rotate: (rotationAngle mul: -1)
						around: rotationAxis.
			upPoint := aProjection sightPoint + aProjection unitUpVector.
			aProjection eyePoint: (transformationInv applyTo: aProjection eyePoint).
			aProjection upVector: (transformation applyTo: upPoint)
					- aProjection sightPoint.
			aModel displayProjection: aProjection.
			aModel changed: #projection]
]

{ #category : #buttons }
JunOpenGLShowModel >> bullButton [
	pushButtons isNil ifTrue: [pushButtons := Dictionary new].
	(pushButtons includesKey: #bull)
		ifFalse: 
			[| image figure shape button |
			image := Cursor bull asOpaqueImage.
			figure := image figure asImage.
			shape := image shape asImage.
			image := OpaqueImage figure: figure shape: shape.
			button := JunButtonModel
						value: false
						visual: image
						action: 
							[:model | 
							model value: model value not.
							model value
								ifTrue: 
									[self grabButton value: false.
									self dragButton value: false].
							self changed: #state].
			pushButtons at: #bull put: button].
	^pushButtons at: #bull
]

{ #category : #'interface opening' }
JunOpenGLShowModel >> bullButtonView [
	| view |
	view := JunButtonView new.
	view model: self bullButton.
	^view
]

{ #category : #buttons }
JunOpenGLShowModel >> buttonState [
	| buttonModel |
	pushButtons isNil ifTrue: [self bullButton; dragButton; grabButton].
	pushButtons
		associationsDo: 
			[:association | 
			buttonModel := association value.
			buttonModel value = true ifTrue: [^association key]].
	^nil
]

{ #category : #'menu messages' }
JunOpenGLShowModel >> changeEyePoint [
	| point x y z string |
	point := self showProjector eyePoint.
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
JunOpenGLShowModel >> changeSightPoint [
	| point x y z string |
	point := self showProjector sightPoint.
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
JunOpenGLShowModel >> changeUpVector [
	| point x y z string |
	point := self showProjector upVector.
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
JunOpenGLShowModel >> changeViewFactor [
	| value string |
	value := self showProjector viewFactor.
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
JunOpenGLShowModel >> changeZoomHeight [
	| height string |
	height := self showProjector zoomHeight.
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

{ #category : #private }
JunOpenGLShowModel >> computeSightPoint [
	^self displayModel displayProjection sightPoint
]

{ #category : #private }
JunOpenGLShowModel >> computeViewportHeight [
	| aProjection currentHeight nearHeight |
	aProjection := self displayModel displayProjection.
	currentHeight := aProjection regularHeight.
	nearHeight := 2 * (aProjection sightPoint distance: aProjection nearCenter).
	currentHeight > nearHeight ifTrue: [currentHeight := nearHeight].
	^currentHeight
]

{ #category : #private }
JunOpenGLShowModel >> computeZoomHeight [
	| maxOffsetX maxOffsetY depth up down right left horizontal vertical factor maxHeight |
	maxOffsetX := 0.0d.
	maxOffsetY := 0.0d.
	depth := self showProjection distance.
	up := self showProjection translateTo3dPointFromPoint: 0 @ -1 depth: depth.
	down := self showProjection translateTo3dPointFromPoint: 0 @ 1 depth: depth.
	right := self showProjection translateTo3dPointFromPoint: 1 @ 0 depth: depth.
	left := self showProjection translateTo3dPointFromPoint: -1 @ 0 depth: depth.
	horizontal := JunPlane
				on: self showProjection eyePoint
				on: left
				on: right.
	vertical := JunPlane
				on: self showProjection eyePoint
				on: up
				on: down.
	self showObject
		pointsDo: 
			[:p | 
			| offsetX offsetY |
			offsetX := vertical distanceFromPoint: p.
			offsetY := horizontal distanceFromPoint: p.
			offsetX > maxOffsetX ifTrue: [maxOffsetX := offsetX].
			offsetY > maxOffsetY ifTrue: [maxOffsetY := offsetY]].
	factor := 2.5d.
	maxOffsetX > maxOffsetY
		ifTrue: [maxHeight := maxOffsetX * factor]
		ifFalse: [maxHeight := maxOffsetY * factor].
	^maxHeight
]

{ #category : #defaults }
JunOpenGLShowModel >> defaultEyePoint [
	^self displayModel defaultEyePoint
]

{ #category : #defaults }
JunOpenGLShowModel >> defaultEyePoint: eyePoint [ 
	self displayModel defaultEyePoint: eyePoint
]

{ #category : #defaults }
JunOpenGLShowModel >> defaultSightPoint [
	^self displayModel defaultSightPoint
]

{ #category : #defaults }
JunOpenGLShowModel >> defaultSightPoint: sightPoint [ 
	self displayModel defaultSightPoint: sightPoint
]

{ #category : #defaults }
JunOpenGLShowModel >> defaultUpVector [
	^self displayModel defaultUpVector
]

{ #category : #defaults }
JunOpenGLShowModel >> defaultUpVector: upVector [ 
	self displayModel defaultUpVector: upVector
]

{ #category : #defaults }
JunOpenGLShowModel >> defaultViewFactor [
	^self displayModel defaultViewFactor
]

{ #category : #defaults }
JunOpenGLShowModel >> defaultViewFactor: viewFactor [ 
	self displayModel defaultViewFactor: viewFactor
]

{ #category : #accessing }
JunOpenGLShowModel >> displayModel [
	displayModel isNil ifTrue: [self displayModel: JunOpenGLDisplayModel new].
	^displayModel
]

{ #category : #accessing }
JunOpenGLShowModel >> displayModel: aDisplayModel [ 
	displayModel = aDisplayModel
		ifFalse: 
			[displayModel := aDisplayModel.
			(displayModel dependents includes: self)
				ifFalse: [displayModel addDependent: self]]
]

{ #category : #accessing }
JunOpenGLShowModel >> displayObject [
	^self displayModel displayObject
]

{ #category : #accessing }
JunOpenGLShowModel >> displayObject: a3dObject [ 
	self displayModel displayObject: a3dObject
]

{ #category : #manipulating }
JunOpenGLShowModel >> drag: from2dPoint xy: to2dPoint [ 
	| shiftDown |
	self displayObject isNil ifTrue: [^self].
	shiftDown := InputState default shiftDown.
	shiftDown
		ifTrue: [self look: from2dPoint xy: to2dPoint]
		ifFalse: [self slide: from2dPoint xy: to2dPoint]
]

{ #category : #buttons }
JunOpenGLShowModel >> dragButton [
	pushButtons isNil ifTrue: [pushButtons := Dictionary new].
	(pushButtons includesKey: #drag)
		ifFalse: 
			[| image figure shape button |
			image := JunCursors quartersCursor asOpaqueImage.
			figure := image figure asImage.
			shape := image shape asImage.
			image := OpaqueImage figure: figure shape: shape.
			button := JunButtonModel
						value: false
						visual: image
						action: 
							[:model | 
							model value: model value not.
							model value
								ifTrue: 
									[self bullButton value: false.
									self grabButton value: false].
							self changed: #state].
			pushButtons at: #drag put: button].
	^pushButtons at: #drag
]

{ #category : #'interface opening' }
JunOpenGLShowModel >> dragButtonView [
	| view |
	view := JunButtonView new.
	view model: self dragButton.
	^view
]

{ #category : #projection }
JunOpenGLShowModel >> eyePoint: a3dPoint [ 
	self showProjector eyePoint: a3dPoint.
	self changed: #projection
]

{ #category : #projection }
JunOpenGLShowModel >> fit [
	self showObject isNil ifTrue: [^self].
	JunCursorAnimator clockCursors
		showWhile: 
			[self fitSilently.
			self changed: #projection]
]

{ #category : #projection }
JunOpenGLShowModel >> fitSight [
	| sightPoint |
	self showObject isNil ifTrue: [^self].
	JunCursorAnimator clockCursors
		showWhile: 
			[sightPoint := self computeSightPoint.
			self sightPoint: sightPoint]
]

{ #category : #projection }
JunOpenGLShowModel >> fitSilently [
	| sightPoint zoomHeight |
	self showObject isNil ifTrue: [^self].
	JunCursorAnimator clockCursors
		showWhile: 
			[sightPoint := self computeSightPoint.
			self showProjector sightPoint: sightPoint.
			zoomHeight := self computeZoomHeight.
			self showProjector zoomHeight: zoomHeight]
]

{ #category : #projection }
JunOpenGLShowModel >> fitZoom [
	| zoomHeight |
	self showObject isNil ifTrue: [^self].
	JunCursorAnimator clockCursors
		showWhile: 
			[zoomHeight := self computeZoomHeight.
			self zoomHeight: zoomHeight]
]

{ #category : #shading }
JunOpenGLShowModel >> flatShading [
	self showProjector flatShading.
	self updateViewMenuIndication.
	self changed: #shading
]

{ #category : #accessing }
JunOpenGLShowModel >> flushObject [
	showObject := nil
]

{ #category : #accessing }
JunOpenGLShowModel >> flushProjector [
	showProjector := nil
]

{ #category : #private }
JunOpenGLShowModel >> getView [
	| aView |
	aView := self dependents detect: [:each | (each isKindOf: JunOpenGLShowView)
					and: [each model = self]]
				ifNone: [nil].
	aView isNil ifTrue: [^nil].
	^aView
]

{ #category : #private }
JunOpenGLShowModel >> grab3dPoint: aPoint [ 
	| projection handleSphere prj line candidates |
	projection := self showProjection.
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
JunOpenGLShowModel >> grab: deltaPoint [ 
	| fromPoint toPoint |
	self displayObject isNil ifTrue: [^self].
	fromPoint := 0 , 0.
	InputState default shiftDown
		ifTrue: [toPoint := deltaPoint x / 10 , (deltaPoint y / 10)]
		ifFalse: [toPoint := deltaPoint x , deltaPoint y].
	self grab: fromPoint xy: toPoint
]

{ #category : #manipulating }
JunOpenGLShowModel >> grab: from2dPoint xy: to2dPoint [ 
	| aProjection grabSphere fromPoint toPoint rotationAngle |
	self displayObject isNil ifTrue: [^self].
	aProjection := self showProjection.
	grabSphere := self grabSphere.
	fromPoint := self grab3dPoint: from2dPoint x , from2dPoint y.
	toPoint := self grab3dPoint: to2dPoint x , to2dPoint y.
	rotationAngle := (Jun3dLine from: grabSphere center to: toPoint)
				angleWithLine: (Jun3dLine from: grabSphere center to: fromPoint).
	rotationAngle rad abs > self thetaAccuracy
		ifTrue: 
			[| rotationAxis transformation transformationInv upPoint |
			rotationAxis := Jun3dLine from: grabSphere center to: grabSphere center - (fromPoint - grabSphere center product: toPoint - grabSphere center).
			transformation := Jun3dTransformation rotate: rotationAngle around: rotationAxis.
			transformationInv := Jun3dTransformation rotate: (rotationAngle mul: -1)
						around: rotationAxis.
			upPoint := aProjection sightPoint + aProjection unitUpVector.
			aProjection eyePoint: (transformationInv applyTo: aProjection eyePoint).
			aProjection upVector: (transformation applyTo: upPoint)
					- aProjection sightPoint.
			self showProjection: aProjection.
			self changed: #projection]
]

{ #category : #buttons }
JunOpenGLShowModel >> grabButton [
	pushButtons isNil ifTrue: [pushButtons := Dictionary new].
	(pushButtons includesKey: #grab)
		ifFalse: 
			[| image figure shape button |
			image := JunCursors handCursor asOpaqueImage.
			figure := image figure asImage.
			shape := image shape asImage.
			image := OpaqueImage figure: figure shape: shape.
			button := JunButtonModel
						value: false
						visual: image
						action: 
							[:model | 
							model value: model value not.
							model value
								ifTrue: 
									[self bullButton value: false.
									self dragButton value: false].
							self changed: #state].
			pushButtons at: #grab put: button].
	^pushButtons at: #grab
]

{ #category : #'interface opening' }
JunOpenGLShowModel >> grabButtonView [
	| view |
	view := JunButtonView new.
	view model: self grabButton.
	^view
]

{ #category : #private }
JunOpenGLShowModel >> grabSphere [
	| projection grabSphere |
	projection := self showProjection.
	grabSphere := JunSphereSurface center: projection sightPoint radius: projection regularHeight / 2.
	^grabSphere
]

{ #category : #presentation }
JunOpenGLShowModel >> hiddenlinePresentation [
	self showProjector hiddenlinePresentation.
	self updateViewMenuIndication.
	self changed: #presentation
]

{ #category : #'initialize-release' }
JunOpenGLShowModel >> initialize [
	displayModel := nil.
	showObject := nil.
	showProjector := nil.
	useTransparency := true
]

{ #category : #testing }
JunOpenGLShowModel >> isEmpty [
	^self displayObject isNil or: [self displayObject isCompound and: [self displayObject components isEmpty]]
]

{ #category : #'menu messages' }
JunOpenGLShowModel >> lineSmooth [
	self showProjector lineSmooth: self showProjector lineSmooth not.
	self updateViewMenuIndication.
	self changed: #smoothing
]

{ #category : #manipulating }
JunOpenGLShowModel >> look: from2dPoint xy: to2dPoint [ 
	| aProjection fromPoint toPoint |
	self displayObject isNil ifTrue: [^self].
	aProjection := self showProjection.
	fromPoint := aProjection translateTo3dPointFromPoint: from2dPoint x , from2dPoint y.
	toPoint := aProjection translateTo3dPointFromPoint: to2dPoint x , to2dPoint y.
	aProjection eyePoint: aProjection eyePoint - (toPoint - fromPoint).
	self showProjection: aProjection.
	self changed: #projection
]

{ #category : #projection }
JunOpenGLShowModel >> pan [
	^self zoom: 1 / 2
]

{ #category : #projection }
JunOpenGLShowModel >> parallelProjection [
	| projection |
	projection := self showProjection asParallelProjection.
	self showProjection: projection.
	self updateViewMenuIndication.
	self changed: #projection
]

{ #category : #projection }
JunOpenGLShowModel >> perspectiveProjection [
	| projection |
	projection := self showProjection asPerspectiveProjection.
	self showProjection: projection.
	self updateViewMenuIndication.
	self changed: #projection
]

{ #category : #'menu messages' }
JunOpenGLShowModel >> polygonSmooth [
	self showProjector polygonSmooth: self showProjector polygonSmooth not.
	self updateViewMenuIndication.
	self changed: #smoothing
]

{ #category : #'interface opening' }
JunOpenGLShowModel >> postBuildWith: aBuilder [ 
	super postBuildWith: aBuilder.
	self flushProjector.
	self fitSilently.
	self spawnViewfinder
]

{ #category : #private }
JunOpenGLShowModel >> regularizePoint: aPoint in: aRectangle [ 
	| x y |
	x := (aPoint x - (aRectangle width / 2)) / (aRectangle height / 2).
	y := (aPoint y - (aRectangle height / 2)) negated / (aRectangle height / 2).
	^x @ y
]

{ #category : #rendering }
JunOpenGLShowModel >> renderOn: renderingContext [ 
	| lightCollection |
	renderingContext clear.
	self displayObject isNil ifTrue: [^self].
	lightCollection := self displayModel displayLightCollection.
	"lightCollection do: [:aLight | aLight lightingOn: renderingContext]."
	self showProjector
		project: self showObject
		withLights: lightCollection
		on: renderingContext.
	self showProjector project: self viewportBeam on: renderingContext.
	renderingContext flush
]

{ #category : #'menu messages' }
JunOpenGLShowModel >> resetView [
	self flushProjector.
	self flushObject.
	self fit.
	self updateMenuIndication
]

{ #category : #accessing }
JunOpenGLShowModel >> showObject [
	| aProjection currentHeight nearHeight currentSight aSphere aStipple xyzAxes aBody aScavenger |
	aProjection := self displayModel displayProjection.
	currentHeight := self computeViewportHeight.
	currentSight := aProjection sightPoint.
	nearHeight := 2 * (aProjection sightPoint distance: aProjection nearCenter).
	currentHeight > nearHeight ifTrue: [currentHeight := nearHeight].
	((showObject isNil or: [viewportHeight isNil
			or: 
				[| delta |
				delta := (currentHeight - viewportHeight) abs.
				delta > JunGeometry accuracy]])
		or: [viewportSight isNil
				or: 
					[| delta |
					delta := currentSight distance: viewportSight.
					delta > JunGeometry accuracy]])
		ifTrue: 
			[viewportHeight := currentHeight.
			viewportSight := currentSight.
			aScavenger := JunScavenger new.
			showObject isNil
				ifTrue: [aScavenger run]
				ifFalse: 
					[self displayObject isNil
						ifTrue: [aSphere := showObject components at: 1]
						ifFalse: [aSphere := showObject components at: 2].
					aSphere do: [:each | each stipple notNil ifTrue: [each stipple flushPointerOfPixels]].
					aScavenger run].
			aSphere := JunOpenGL3dObject
						globe: 15
						radius: viewportHeight / 2
						center: viewportSight.
			aSphere paint: ColorValue cyan.
			self useTransparency
				ifTrue: [aSphere alpha: 0.25]
				ifFalse: 
					[aStipple := JunOpenGLStipple halftone: 0.25.
					aSphere do: [:each | each stipple: aStipple]].
			xyzAxes := JunOpenGL3dObject axes2.
			xyzAxes := xyzAxes scaledBy: viewportHeight / 2.
			aBody := JunOpenGL3dCompoundObject new.
			self displayObject isNil ifFalse: [aBody add: self displayObject].
			aBody add: aSphere.
			aBody add: xyzAxes.
			showObject := aBody].
	^JunOpenGL3dCompoundObject with: showObject with: self viewportObject
]

{ #category : #accessing }
JunOpenGLShowModel >> showProjection [
	^self showProjector projection
]

{ #category : #accessing }
JunOpenGLShowModel >> showProjection: aProjection [ 
	self showProjector projection: aProjection
]

{ #category : #accessing }
JunOpenGLShowModel >> showProjector [
	showProjector isNil 
		ifTrue: 
			[showProjector := JunOpenGLProjector new.
			showProjector eyePoint: self defaultEyePoint.
			showProjector sightPoint: self defaultSightPoint.
			showProjector upVector: self defaultUpVector.
			showProjector viewFactor: self defaultViewFactor.
			showProjector smoothShading].
	^showProjector
]

{ #category : #'interface opening' }
JunOpenGLShowModel >> showView [
	| aView |
	aView := JunOpenGLShowView model: self.
	^aView
]

{ #category : #projection }
JunOpenGLShowModel >> sightPoint: a3dPoint [ 
	self showProjector sightPoint: a3dPoint.
	self changed: #projection
]

{ #category : #manipulating }
JunOpenGLShowModel >> slide: from2dPoint xy: to2dPoint [ 
	| aProjection fromPoint toPoint |
	self displayObject isNil ifTrue: [^self].
	aProjection := self showProjection.
	fromPoint := aProjection translateTo3dPointFromPoint: from2dPoint x , from2dPoint y.
	toPoint := aProjection translateTo3dPointFromPoint: to2dPoint x , to2dPoint y.
	aProjection sightPoint: aProjection sightPoint - (toPoint - fromPoint).
	aProjection eyePoint: aProjection eyePoint - (toPoint - fromPoint).
	self showProjection: aProjection.
	self changed: #projection
]

{ #category : #shading }
JunOpenGLShowModel >> smoothShading [
	self showProjector smoothShading.
	self updateViewMenuIndication.
	self changed: #shading
]

{ #category : #presentation }
JunOpenGLShowModel >> solidPresentation [
	self showProjector solidPresentation.
	self updateViewMenuIndication.
	self changed: #presentation
]

{ #category : #'menu messages' }
JunOpenGLShowModel >> spawnObject [
	| aDiaplayModel aView |
	InputState default shiftDown 
		ifTrue: 
			[aDiaplayModel := JunOpenGLDisplayModel 
						displayObject: (JunOpenGL3dCompoundObject with: self showObject
								with: self viewportBeam)]
		ifFalse: 
			[aDiaplayModel := JunOpenGLDisplayModel displayObject: self showObject].
	aDiaplayModel displayProjection: self showProjection copy.
	aView := self getView.
	aView isNil 
		ifTrue: [aDiaplayModel open]
		ifFalse: 
			[| box area |
			box := aView topComponent displayBox.
			area := 0 @ 0 extent: aView topComponent displayBox extent.
			area := area align: area topLeft with: box topRight + (8 @ 0).
			aDiaplayModel openIn: area].
	aDiaplayModel changed: #object.
	^aDiaplayModel
]

{ #category : #'menu messages' }
JunOpenGLShowModel >> spawnViewfinder [
	| model window |
	model := self displayModel.
	(model builder notNil and: [(window := model builder window) isOpen])
		ifTrue: 
			[window isCollapsed ifTrue: [window expand].
			window raise]
		ifFalse: [model open].
	JunApplicationModel displayPendingInvalidation
]

{ #category : #'menu messages' }
JunOpenGLShowModel >> switchStippleAndTransparency [
	self useTransparency: self useTransparency not
]

{ #category : #private }
JunOpenGLShowModel >> thetaAccuracy [
	^0.001
]

{ #category : #projection }
JunOpenGLShowModel >> upVector: a3dPoint [ 
	self showProjector upVector: a3dPoint.
	self changed: #projection
]

{ #category : #updating }
JunOpenGLShowModel >> update: aspectSymbol with: aParameter from: aSender [ 
	aSender = self displayModel ifTrue: [self changed: aspectSymbol].
	^self update: aspectSymbol with: aParameter
]

{ #category : #'menu accessing' }
JunOpenGLShowModel >> updateMenuIndication [
	super updateMenuIndication.
	self updateViewMenuIndication.
	self updateMiscMenuIndication
]

{ #category : #'menu accessing' }
JunOpenGLShowModel >> updateMiscMenuIndication [
	| menuItem aMenu displayObjectIsEmpty |
	menuItem := self menuItemLabeled: 'Misc' inMenu: self menuBar.
	menuItem isNil ifTrue: [^self].
	aMenu := menuItem submenu.
	aMenu isNil ifTrue: [^self].
	displayObjectIsEmpty := self isEmpty.
	menuItem := aMenu menuItemWithValue: #spawnObject ifNone: [nil].
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	menuItem := aMenu menuItemWithValue: #spawnViewfinder ifNone: [nil].
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
JunOpenGLShowModel >> updateViewMenuIndication [
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
	menuItem := self menuItemLabeled: 'Reset' inMenu: aMenu.
	menuItem notNil 
		ifTrue: 
			[displayObjectIsEmpty ifTrue: [menuItem disable] ifFalse: [menuItem enable]].
	(self showProjector projection isKindOf: JunOpenGLPerspectiveProjection) 
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
	self showProjector presentation = #solidPresentation 
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
	self showProjector presentation = #wireframePresentation 
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
	self showProjector presentation = #hiddenlinePresentation 
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
	self showProjector shading = #flatShading 
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
			[self showProjector lineSmooth 
				ifTrue: [menuItem beOn]
				ifFalse: [menuItem beOff]].
	menuItem := self menuItemLabelArray: #('Smoothing' 'Polygon smooth')
				inMenu: aMenu.
	menuItem notNil 
		ifTrue: 
			[self showProjector polygonSmooth 
				ifTrue: [menuItem beOn]
				ifFalse: [menuItem beOff]]
]

{ #category : #accessing }
JunOpenGLShowModel >> useTransparency [
	^useTransparency = true
]

{ #category : #accessing }
JunOpenGLShowModel >> useTransparency: aBoolean [ 
	| previousBoolean |
	previousBoolean := self useTransparency.
	useTransparency := aBoolean = true.
	previousBoolean = self useTransparency
		ifFalse: 
			[self flushObject.
			self changed: #object]
]

{ #category : #projection }
JunOpenGLShowModel >> viewFactor: factor [ 
	self showProjector viewFactor: factor.
	self changed: #projection
]

{ #category : #accessing }
JunOpenGLShowModel >> viewportBeam [
	| aProjection far sight near eye eyeBeam aPolyline |
	aProjection := self displayModel displayProjection.
	far := aProjection farCenter.
	sight := aProjection sightPoint.
	near := aProjection nearCenter.
	eye := aProjection eyePoint.
	eyeBeam := JunOpenGL3dCompoundObject new.
	(far distance: near)
		> (sight distance: near)
		ifTrue: 
			[aPolyline := JunOpenGL3dPolyline vertexes: (Array with: far with: sight).
			aPolyline paint: ColorValue magenta.
			eyeBeam add: aPolyline].
	aPolyline := JunOpenGL3dPolyline vertexes: (Array with: sight with: near).
	aPolyline paint: ColorValue blue.
	eyeBeam add: aPolyline.
	(eye distance: sight)
		> (near distance: sight)
		ifTrue: 
			[aPolyline := JunOpenGL3dPolyline vertexes: (Array with: near with: eye).
			aPolyline paint: ColorValue yellow.
			eyeBeam add: aPolyline].
	eyeBeam name: 'viewport eye beam'.
	^eyeBeam
]

{ #category : #accessing }
JunOpenGLShowModel >> viewportObject [
	| aPlate aProjection aRadius aDistance aLine aPoint aPolyline p1 p2 p3 p4 xLine yLine xAxis yAxis aBody |
	aPlate := self viewportPlate.
	aProjection := self displayModel displayProjection.
	viewportHeight isNil ifTrue: [viewportHeight := self computeViewportHeight].
	aRadius := viewportHeight / 2.
	aDistance := aProjection sightPoint distance: aProjection eyePoint.
	aLine := Jun3dLine from: aProjection sightPoint to: aProjection eyePoint.
	aPoint := aLine atT: aRadius / aDistance.
	aPlate := aPlate translatedBy: aPoint.
	aPolyline := JunOpenGL3dPolylineLoop vertexes: aPlate components last vertexes.
	p1 := aPolyline vertexes at: 1.
	p2 := aPolyline vertexes at: 2.
	p3 := aPolyline vertexes at: 3.
	p4 := aPolyline vertexes at: 4.
	xLine := Jun3dLine from: p1 + (p4 - p1 / 2) to: p2 + (p3 - p2 / 2).
	yLine := Jun3dLine from: p1 + (p2 - p1 / 2) to: p4 + (p3 - p4 / 2).
	xAxis := JunOpenGL3dCompoundObject new.
	xAxis add: (JunOpenGL3dPolyline vertexes: (Array with: (xLine atT: 0)
				with: (xLine atT: 1))).
	xAxis add: (JunOpenGL3dPolygon vertexes: (Array
				with: (xLine atT: 1)
				with: (xLine atT: 0.9)
						- ((yLine atT: 1)
								- (yLine atT: 0.9) / 4)
				with: (xLine atT: 0.9)
						+ ((yLine atT: 1)
								- (yLine atT: 0.9) / 4)
				with: (xLine atT: 1))).
	xAxis paint: ColorValue red.
	xAxis name: aPlate name , ' x axis'.
	yAxis := JunOpenGL3dCompoundObject new.
	yAxis add: (JunOpenGL3dPolyline vertexes: (Array with: (yLine atT: 0)
				with: (yLine atT: 1))).
	yAxis add: (JunOpenGL3dPolygon vertexes: (Array
				with: (yLine atT: 1)
				with: (yLine atT: 0.9)
						- ((xLine atT: 1)
								- (xLine atT: 0.9) / 4)
				with: (yLine atT: 0.9)
						+ ((xLine atT: 1)
								- (xLine atT: 0.9) / 4)
				with: (yLine atT: 1))).
	yAxis paint: ColorValue green.
	xAxis name: aPlate name , ' y axis'.
	aBody := JunOpenGL3dCompoundObject
				with: aPlate
				with: aPolyline
				with: xAxis
				with: yAxis.
	aBody name: 'viewport'.
	^aBody
]

{ #category : #accessing }
JunOpenGLShowModel >> viewportPlate [
	| aProjection height aView width p1 p2 p4 p3 anArray aPlate |
	aProjection := self displayModel displayProjection.
	viewportHeight isNil ifTrue: [viewportHeight := self computeViewportHeight].
	height := viewportHeight.
	(self displayModel builder notNil and: [self displayModel builder window isOpen])
		ifTrue: 
			[aView := self displayModel builder componentAt: #displayView.
			width := height * aView bounds width / aView bounds height]
		ifFalse: [width := height].
	p1 := 0 , 0 , 0.
	p2 := aProjection unitRightVector scaledBy: width.
	p4 := aProjection unitUpVector scaledBy: height.
	p3 := p2 + (p4 - p2 / 2).
	p3 := p3 + p3.
	anArray := Array
				with: p1
				with: p2
				with: p3
				with: p4.
	aPlate := JunOpenGL3dCompoundObject new.
	self useTransparency ifTrue: [aPlate add: (JunOpenGL3dPolygon vertexes: anArray reverse)].
	aPlate add: (JunOpenGL3dPolygon vertexes: anArray).
	aPlate := aPlate translatedBy: 0 , 0 , 0 - (p2 + (p4 - p2 / 2)).
	aPlate paint: ColorValue yellow.
	self useTransparency
		ifTrue: [aPlate alpha: 0.2]
		ifFalse: [aPlate components first stipple: (JunOpenGLStipple halftone: 0.125)].
	aPlate name: 'viewport plate'.
	^aPlate
]

{ #category : #accessing }
JunOpenGLShowModel >> viewportSight [
	| aProjection currentSight |
	aProjection := self displayModel displayProjection.
	currentSight := aProjection sightPoint.
	^currentSight
]

{ #category : #presentation }
JunOpenGLShowModel >> wireframePresentation [
	self showProjector wireframePresentation.
	self updateViewMenuIndication.
	self changed: #presentation
]

{ #category : #'interface opening' }
JunOpenGLShowModel >> xThumbWheelView [
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
JunOpenGLShowModel >> yThumbWheelView [
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
JunOpenGLShowModel >> zThumbWheelView [
	| thumbWheel thumbWheelView |
	thumbWheel := JunThumbWheel vertical.
	thumbWheelView := JunThumbWheelView new.
	thumbWheelView model: thumbWheel.
	thumbWheel
		compute: 
			[:value | 
			| factor |
			factor := 1 + (value / 100).
			self zoom: factor].
	^thumbWheelView
]

{ #category : #projection }
JunOpenGLShowModel >> zoom [
	^self zoom: 2
]

{ #category : #projection }
JunOpenGLShowModel >> zoom: factor [ 
	| zoomFactor |
	InputState default shiftDown
		ifTrue: [factor >= 1.0
				ifTrue: [zoomFactor := 1.0 + (factor - 1.0 * 0.1)]
				ifFalse: [zoomFactor := 1.0 - (1.0 - factor * 0.1)]]
		ifFalse: [zoomFactor := factor].
	self showProjector zoom: zoomFactor.
	self changed: #projection
]

{ #category : #projection }
JunOpenGLShowModel >> zoomHeight: aNumber [ 
	self showProjector zoomHeight: aNumber.
	self changed: #projection
]

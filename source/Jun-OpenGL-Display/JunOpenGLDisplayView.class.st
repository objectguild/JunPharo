"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLDisplayView,
	#superclass : #JunAbstractView,
	#instVars : [
		'cachedBitmap',
		'cachedRenderingContext',
		'displayListHolder',
		'bitmapSemaphore'
	],
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLDisplayView class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGLDisplayView class >> example1 [
	"JunOpenGLDisplayView example1."

	| modelCollection aModel aWindow aView aCollection aPolygon aBody |
	modelCollection := OrderedCollection new.
	aModel := JunOpenGLDisplayModel new.
	aModel displayObject: JunOpenGL3dObject benzene.
	aModel openIn: (200 @ 300 extent: 350 @ 300).
	modelCollection add: aModel.
	aModel eyePoint: 10 , 0 , 0.
	aModel upVector: 0 , 1 , 0.
	aModel zoomHeight: 4.75.
	aWindow := aModel getWindow.
	aView := aModel getView.
	aCollection := Array 
				with: 0 @ 0
				with: 0 @ aView bounds height
				with: aView bounds width @ aView bounds height
				with: aView bounds width @ 0.
	aCollection := aView convertViewPointsToModelPoints: aCollection.
	aPolygon := JunOpenGL3dPolygon vertexes: aCollection.
	aPolygon paint: ColorValue yellow.
	aPolygon halftone: 0.5.
	aBody := JunOpenGL3dCompoundObject new.
	aBody add: aModel displayObject copy.
	aBody add: aPolygon.
	aModel := JunOpenGLDisplayModel new.
	aModel displayObject: aBody.
	aModel openIn: (aWindow displayBox topRight + (8 @ 0) 
				extent: aWindow displayBox extent).
	modelCollection add: aModel.
	aCollection := aCollection 
				collect: [:p | p rotatedBy: 30 degreesToRadians].
	Transcript
		cr;
		show: (aView convertModelPointsToView3dPoints: aCollection) printString.
	modelCollection do: [:each | each closeTogether: modelCollection].
	^aModel
]

{ #category : #examples }
JunOpenGLDisplayView class >> example2 [
	"JunOpenGLDisplayView example2."

	| aCollection aModel aWindow aView oldViewPoints modelPoints aPolygon aBody aGraphicsContext newViewPoints |
	aCollection := OrderedCollection new.
	aModel := JunOpenGLDisplayModel new.
	aModel displayObject: JunOpenGL3dObject benzene.
	aModel openIn: (200 @ 300 extent: 350 @ 300).
	aCollection add: aModel.
	aModel eyePoint: 10 , 0 , 0.
	aModel upVector: 0 , 1 , 0.
	aModel zoomHeight: 4.75.
	aWindow := aModel getWindow.
	aView := aModel getView.
	oldViewPoints := Array 
				with: 0 @ 0
				with: 0 @ aView bounds height
				with: aView bounds width @ aView bounds height
				with: aView bounds width @ 0.
	modelPoints := aView convertViewPointsToModelPoints: oldViewPoints.
	aPolygon := JunOpenGL3dPolygon vertexes: modelPoints.
	aPolygon paint: ColorValue yellow.
	aPolygon halftone: 0.5.
	aBody := JunOpenGL3dCompoundObject new.
	aBody add: aModel displayObject copy.
	aBody add: aPolygon.
	aModel := JunOpenGLDisplayModel new.
	aModel displayObject: aBody.
	aModel openIn: (aWindow displayBox topRight + (8 @ 0) 
				extent: aWindow displayBox extent).
	aCollection add: aModel.
	aView := aModel getView.
	aGraphicsContext := aView graphicsContext.
	aGraphicsContext paint: ColorValue black.
	aGraphicsContext lineWidth: 1.
	newViewPoints := aView convertModelPointsToViewPoints: modelPoints.
	oldViewPoints with: newViewPoints
		do: [:op :np | aGraphicsContext displayLineFrom: op to: np].
	10 timesRepeat: 
			[aModel grab: 0 @ 0.25.
			newViewPoints := aView convertModelPointsToViewPoints: modelPoints.
			oldViewPoints with: newViewPoints
				do: [:op :np | aGraphicsContext displayLineFrom: op to: np].
			(Delay forSeconds: 1) wait].
	10 timesRepeat: 
			[aModel grab: 0.25 @ 0.
			newViewPoints := aView convertModelPointsToView3dPoints: modelPoints.
			oldViewPoints with: newViewPoints
				do: [:op :np | aGraphicsContext displayLineFrom: op to: (np x @ np y) rounded].
			Transcript
				cr;
				show: (newViewPoints collect: [:p | p z roundTo: 0.001]) printString.
			(Delay forSeconds: 1) wait].
	aCollection do: [:each | each closeTogether: aCollection].
	^aModel
]

{ #category : #examples }
JunOpenGLDisplayView class >> example3 [
	"JunOpenGLDisplayView example3."

	| aBody modelPoints aModel |
	aBody := JunOpenGL3dObject box.
	aBody polygonsDo: 
			[:aPolygon | 
			aPolygon paint: ColorValue red.
			aPolygon halftone: 0.75].
	modelPoints := aBody asPointArray asSet asArray.
	aModel := JunOpenGLDisplayModel new.
	aModel displayObject: aBody.
	aModel defaultProjectionTable: ((Dictionary new)
				add: #presentation -> #hiddenlinePresentation;
				add: #eyePoint -> (9.36371 , 5.75695 , 4.81826);
				add: #upVector -> (-0.32669 , 0.85981 , -0.39241);
				add: #sightPoint -> (-0.10112 , 0.03549 , 0.16195);
				add: #viewFactor -> 10;
				add: #shading -> #smoothShading;
				add: #zoomHeight -> 2.39845;
				yourself).
	aModel superimposeBlock: 
			[:model :view :controller | 
			| graphicsContext aCollection |
			graphicsContext := view graphicsContext.
			aCollection := view convertModelPointsToView3dPointsSortedByZ: modelPoints.
			aCollection reverseDo: 
					[:assoc | 
					assoc key <= 0 
						ifTrue: 
							[| modelPoint aStream aText viewPoint |
							modelPoint := assoc value first.
							viewPoint := assoc value last.
							aStream := String new writeStream.
							aStream nextPut: $(.
							modelPoint asArray do: [:each | each asRational printOn: aStream]
								separatedBy: [aStream nextPutAll: ', '].
							aStream nextPut: $).
							aText := aStream contents asComposedText.
							view 
								displayText: aText
								on: graphicsContext
								at: viewPoint rounded
								textColor: ColorValue black
								vergeColor: ColorValue veryLightGray
								styleSymbol: #small
								alignmentSymbol: #center]]].
	aModel openIn: (400 , 300) alignedRectangleWithScreenCenter.
	^aModel
]

{ #category : #copyright }
JunOpenGLDisplayView class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLDisplayView class >> version [
	^'799'
]

{ #category : #converting }
JunOpenGLDisplayView >> asBitmap [
	| aString aBitmap |
	aString := JunSystem platformName.
	(aString = 'MacOSX' or: [aString = 'Mac']) 
		ifTrue: 
			[ObjectMemory allocationFailedSignal handle: [:exception | aBitmap := nil]
				do: [aBitmap := self asBitmapForMac].
			aBitmap notNil ifTrue: [^aBitmap]].
	aBitmap := self cachedBitmap.
	((self model respondsTo: #useDisplayList) and: [self model useDisplayList]) 
		ifTrue: 
			[self 
				assert: 
					[cachedRenderingContext isNil 
						ifTrue: [cachedRenderingContext := aBitmap renderingContext]
						ifFalse: [cachedRenderingContext initializeContext].
					displayListHolder isNil ifTrue: [displayListHolder := nil asValue]]
				do: 
					[self renderOn: cachedRenderingContext withDisplayList: displayListHolder.
					cachedRenderingContext isNil ifFalse: [cachedRenderingContext flush]]
				ensure: 
					[cachedRenderingContext isNil ifFalse: [cachedRenderingContext deactivate]]]
		ifFalse: 
			[| renderingContext |
			self 
				assert: [renderingContext := aBitmap renderingContext]
				do: 
					[self renderOn: renderingContext.
					renderingContext flush]
				ensure: [renderingContext release]].
	^aBitmap
]

{ #category : #converting }
JunOpenGLDisplayView >> asBitmapForMac [
	| aBitmap |
	aBitmap := self cachedBitmap.
	((self model respondsTo: #useDisplayList) and: [self model useDisplayList]) 
		ifTrue: 
			[| firstTime |
			firstTime := false.
			self 
				assert: 
					[cachedRenderingContext isNil 
						ifTrue: [cachedRenderingContext := aBitmap renderingContext]
						ifFalse: [cachedRenderingContext initializeContext].
					displayListHolder isNil 
						ifTrue: 
							[displayListHolder := nil asValue.
							firstTime := true]]
				do: 
					[self renderOn: cachedRenderingContext withDisplayList: displayListHolder.
					cachedRenderingContext isNil ifFalse: [cachedRenderingContext flush]]
				ensure: 
					[cachedRenderingContext isNil ifFalse: [cachedRenderingContext deactivate]].
			(firstTime and: [cachedRenderingContext notNil]) 
				ifTrue: 
					[self 
						assert: [cachedRenderingContext initializeContext]
						do: 
							[self renderOn: cachedRenderingContext withDisplayList: displayListHolder.
							cachedRenderingContext isNil ifFalse: [cachedRenderingContext flush]]
						ensure: 
							[cachedRenderingContext isNil ifFalse: [cachedRenderingContext deactivate]]]]
		ifFalse: 
			[| renderingContext |
			self 
				assert: [renderingContext := aBitmap renderingContext]
				do: 
					[self renderOn: renderingContext.
					renderingContext flush]
				ensure: [renderingContext release]].
	^aBitmap
]

{ #category : #converting }
JunOpenGLDisplayView >> asImage [
	^self asBitmap medium asImage
]

{ #category : #'bounds accessing' }
JunOpenGLDisplayView >> bounds: newBounds [ 
	super bounds: newBounds.
	self flushCachedBitmap.
	self model changed: #value
]

{ #category : #private }
JunOpenGLDisplayView >> cachedBitmap [
	cachedBitmap isNil ifTrue: [self createBitmap].
	^cachedBitmap
]

{ #category : #'controller accessing' }
JunOpenGLDisplayView >> controller: aController [ 
	(self controller respondsTo: #flushMovementVector) 
		ifTrue: [self controller flushMovementVector].
	super controller: aController
]

{ #category : #converting }
JunOpenGLDisplayView >> convertModelPointToView3dPoint: modelPoint [ 
	^self model convertModelPointToView3dPoint: modelPoint in: self bounds
]

{ #category : #converting }
JunOpenGLDisplayView >> convertModelPointToViewPoint: modelPoint [ 
	^self model convertModelPointToViewPoint: modelPoint in: self bounds
]

{ #category : #converting }
JunOpenGLDisplayView >> convertModelPointsToView3dPoints: modelPoints [ 
	^self model convertModelPointsToView3dPoints: modelPoints in: self bounds
]

{ #category : #converting }
JunOpenGLDisplayView >> convertModelPointsToView3dPointsSortedByZ: modelPoints [ 
	^self model convertModelPointsToView3dPointsSortedByZ: modelPoints in: self bounds
]

{ #category : #converting }
JunOpenGLDisplayView >> convertModelPointsToViewPoints: modelPoints [ 
	^self model convertModelPointsToViewPoints: modelPoints in: self bounds
]

{ #category : #converting }
JunOpenGLDisplayView >> convertViewPointToModelPoint: viewPoint [ 
	^self model convertViewPointToModelPoint: viewPoint in: self bounds
]

{ #category : #converting }
JunOpenGLDisplayView >> convertViewPointsToModelPoints: viewPoints [ 
	^self model convertViewPointsToModelPoints: viewPoints in: self bounds
]

{ #category : #private }
JunOpenGLDisplayView >> createBitmap [
	cachedBitmap := JunOpenGLRetainedMedium for: self.
	cachedBitmap setBackground: self lookPreferences backgroundColor.
	^cachedBitmap
]

{ #category : #debug }
JunOpenGLDisplayView >> debug: aBlock [ 
	"aBlock value"
]

{ #category : #'controller accessing' }
JunOpenGLDisplayView >> defaultControllerClass [
	^JunOpenGLDisplayController
]

{ #category : #displaying }
JunOpenGLDisplayView >> displayOn: graphicsContext [ 
	self isOpen ifFalse: [^self].
	self hasOpenGLResource ifFalse: [^self].
	false 
		ifTrue: 
			[| renderingContext |
			self 
				assert: [renderingContext := self renderingContext]
				do: 
					[self renderOn: renderingContext.
					renderingContext flush]
				ensure: [renderingContext release]]
		ifFalse: 
			[bitmapSemaphore critical: 
					[self messageNotUnderstoodSignal handle: 
							[:exception | 
							exception messageText.
							exception return]
						do: 
							[self asBitmap 
								displayOn: graphicsContext
								at: graphicsContext clippingBounds origin
								bounds: graphicsContext clippingBounds]]].
	(self model respondsTo: #superimpose) ifTrue: [self model superimpose]
]

{ #category : #private }
JunOpenGLDisplayView >> flushCachedBitmap [
	self flushCachedRenderingContext.
	cachedBitmap notNil ifTrue: [bitmapSemaphore critical: [cachedBitmap release]].
	cachedBitmap := nil
]

{ #category : #private }
JunOpenGLDisplayView >> flushCachedRenderingContext [
	cachedRenderingContext notNil ifTrue: [cachedRenderingContext release].
	cachedRenderingContext := nil.
	displayListHolder := nil
]

{ #category : #'initialize-release' }
JunOpenGLDisplayView >> initialize [
	super initialize.
	bitmapSemaphore := Semaphore forMutualExclusion
]

{ #category : #'bounds accessing' }
JunOpenGLDisplayView >> preferredBounds [
	| aContext aBlock |
	aContext := thisContext.
	aBlock := nil.
	aBlock := 
			[:context | 
			(aContext receiver == context receiver 
				and: [aContext selector == context selector]) 
					ifTrue: 
						[^self error: 'This ' , self class name 
									, ' is expected to be wrapped by a BoundedWrapper.'].
			context sender isNil ifFalse: [aBlock value: context sender]].
	aBlock value: aContext sender.
	container isNil ifTrue: [^super preferredBounds] ifFalse: [^self bounds]
]

{ #category : #displaying }
JunOpenGLDisplayView >> redisplay [
	self flushCachedRenderingContext.
	self isOpen ifTrue: [self displayOn: self graphicsContext]
]

{ #category : #'initialize-release' }
JunOpenGLDisplayView >> release [
	super release.
	self flushCachedBitmap
]

{ #category : #rendering }
JunOpenGLDisplayView >> renderOn: renderingContext [ 
	self model renderOn: renderingContext
]

{ #category : #rendering }
JunOpenGLDisplayView >> renderOn: renderingContext withDisplayList: aDisplayListHolder [ 
	self model renderOn: renderingContext withDisplayList: aDisplayListHolder
]

{ #category : #rendering }
JunOpenGLDisplayView >> renderingContext [
	| renderingContext |
	renderingContext := JunOpenGLRenderingContext on: self medium.
	renderingContext viewport: self viewportInMedium.
	^renderingContext
]

{ #category : #updating }
JunOpenGLDisplayView >> update: aspectSymbol with: aParameter from: aSender [ 
	self isOpen ifFalse: [^self].
	aspectSymbol = #object ifTrue: [^self redisplay].
	aspectSymbol = #light ifTrue: [^self redisplay].
	aspectSymbol = #projection ifTrue: [^self displayOn: self graphicsContext].
	aspectSymbol = #presentation ifTrue: [^self redisplay].
	aspectSymbol = #shading ifTrue: [^self redisplay].
	aspectSymbol = #selection ifTrue: [^self redisplay].
	aspectSymbol = #state ifTrue: [^self controller flushMovementVector].
	aspectSymbol = #texture ifTrue: [^self redisplay].
	super update: aspectSymbol with: aParameter
]

{ #category : #private }
JunOpenGLDisplayView >> viewportInMedium [
	| rect |
	rect := self bounds translatedBy: (self localPointToGlobal: Point zero).
	^rect
]

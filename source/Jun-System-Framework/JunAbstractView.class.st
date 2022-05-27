"
Imported by VwImportClass
"
Class {
	#name : #JunAbstractView,
	#superclass : #View,
	#category : #'Jun-System-Framework'
}

{ #category : #evaluating }
JunAbstractView class >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	^JunControlUtility 
		assert: assertBlock
		do: doBlock
		ensure: ensureBlock
]

{ #category : #copyright }
JunAbstractView class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #evaluating }
JunAbstractView class >> do: aBlock during: millisecondTime [ 
	^JunControlUtility do: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractView class >> do: doBlock ensure: ensureBlock [ 
	^JunControlUtility do: doBlock ensure: ensureBlock
]

{ #category : #evaluating }
JunAbstractView class >> do: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility do: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractView class >> do: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility do: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunAbstractView class >> do: aBlock framesPerSecond: aNumber [ 
	^JunControlUtility do: aBlock framesPerSecond: aNumber
]

{ #category : #evaluating }
JunAbstractView class >> fork: aBlock during: millisecondTime [ 
	^JunControlUtility fork: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractView class >> fork: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility fork: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractView class >> fork: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility fork: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunAbstractView class >> punctuallyDo: aBlock during: millisecondTime [ 
	^JunControlUtility punctuallyDo: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractView class >> punctuallyDo: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility punctuallyDo: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractView class >> punctuallyDo: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility punctuallyDo: aBlock forMilliseconds: millisecondTime
]

{ #category : #copyright }
JunAbstractView class >> system [
	^'Jun'
]

{ #category : #copyright }
JunAbstractView class >> version [
	^'799'
]

{ #category : #evaluating }
JunAbstractView >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	^self class 
		assert: assertBlock
		do: doBlock
		ensure: ensureBlock
]

{ #category : #'bounds accessing' }
JunAbstractView >> bounds: newBounds [ 
	super bounds: newBounds.
	(self model respondsTo: #changedViewBox:) 
		ifTrue: [self model changedViewBox: newBounds]
]

{ #category : #private }
JunAbstractView >> composedText: composedText vergeColor: vergeColor [ 
	^self model composedText: composedText vergeColor: vergeColor
]

{ #category : #'controller accessing' }
JunAbstractView >> defaultControllerClass [
	^JunAbstractController
]

{ #category : #defaults }
JunAbstractView >> defaultDecorator [
	| aDecorator |
	aDecorator := BorderDecorator on: self.
	aDecorator useBorder.
	aDecorator noMenuBar.
	aDecorator noVerticalScrollBar.
	aDecorator noHorizontalScrollBar.
	^aDecorator
]

{ #category : #displaying }
JunAbstractView >> displayComposedText: composedText on: graphicsContext at: atPoint [ 
	self 
		displayComposedText: composedText
		on: graphicsContext
		at: atPoint
		textColor: ColorValue black
		vergeColor: ColorValue white
		alignmentSymbol: #origin
]

{ #category : #displaying }
JunAbstractView >> displayComposedText: composedText on: graphicsContext at: atPoint alignmentSymbol: alignmentSymbol [ 
	self 
		displayComposedText: composedText
		on: graphicsContext
		at: atPoint
		textColor: ColorValue black
		vergeColor: self backgroundColor
		alignmentSymbol: alignmentSymbol
]

{ #category : #displaying }
JunAbstractView >> displayComposedText: composedText on: graphicsContext at: atPoint textColor: textColor vergeColor: vergeColor [ 
	self 
		displayComposedText: composedText
		on: graphicsContext
		at: atPoint
		textColor: textColor
		vergeColor: vergeColor
		alignmentSymbol: #origin
]

{ #category : #displaying }
JunAbstractView >> displayComposedText: composedText on: graphicsContext at: atPoint textColor: textColor vergeColor: vergeColor alignmentSymbol: alignmentSymbol [ 
	| vergeComposedText composedBox displayPoint |
	vergeComposedText := self composedText: composedText vergeColor: vergeColor.
	composedBox := composedText bounds.
	composedBox := composedBox align: (composedBox perform: alignmentSymbol)
				with: atPoint.
	displayPoint := composedBox origin.
	(self model neighborhoodPoints: displayPoint) do: 
			[:aPoint | 
			graphicsContext paint: vergeColor.
			vergeComposedText displayOn: graphicsContext at: aPoint].
	graphicsContext paint: textColor.
	composedText displayOn: graphicsContext at: displayPoint
]

{ #category : #displaying }
JunAbstractView >> displayImage: anImage on: graphicsContext at: atPoint [ 
	^self 
		displayImage: anImage
		on: graphicsContext
		at: atPoint
		alignmentSymbol: #origin
]

{ #category : #displaying }
JunAbstractView >> displayImage: anImage on: graphicsContext at: atPoint alignmentSymbol: alignmentSymbol [ 
	| composedBox displayPoint |
	composedBox := anImage bounds.
	composedBox := composedBox align: (composedBox perform: alignmentSymbol)
				with: atPoint.
	displayPoint := composedBox origin.
	anImage displayOn: graphicsContext at: displayPoint
]

{ #category : #displaying }
JunAbstractView >> displayOn: aGraphicsContext [ 
	(self model respondsTo: #displayOn:) 
		ifTrue: [self model displayOn: aGraphicsContext]
]

{ #category : #displaying }
JunAbstractView >> displayOn: graphicsContext dotBox: aRectangle [ 
	aRectangle width < 3 
		ifTrue: [graphicsContext displayRectangle: aRectangle]
		ifFalse: 
			[graphicsContext 
				displayWedgeBoundedBy: (aRectangle expandedBy: (0 @ 0 corner: 1 @ 1))
				startAngle: 0
				sweepAngle: 360]
]

{ #category : #displaying }
JunAbstractView >> displayText: aText on: graphicsContext at: atPoint [ 
	self 
		displayText: aText
		on: graphicsContext
		at: atPoint
		textColor: ColorValue black
		vergeColor: ColorValue white
		styleSymbol: #default
		alignmentSymbol: #origin
]

{ #category : #displaying }
JunAbstractView >> displayText: aText on: graphicsContext at: atPoint alignmentSymbol: alignmentSymbol [ 
	self 
		displayText: aText
		on: graphicsContext
		at: atPoint
		textColor: ColorValue black
		vergeColor: ColorValue white
		styleSymbol: #default
		alignmentSymbol: alignmentSymbol
]

{ #category : #displaying }
JunAbstractView >> displayText: aText on: graphicsContext at: atPoint styleSymbol: styleSymbol [ 
	self 
		displayText: aText
		on: graphicsContext
		at: atPoint
		textColor: ColorValue black
		vergeColor: ColorValue white
		styleSymbol: styleSymbol
		alignmentSymbol: #origin
]

{ #category : #displaying }
JunAbstractView >> displayText: aText on: graphicsContext at: atPoint styleSymbol: styleSymbol alignmentSymbol: alignmentSymbol [ 
	self 
		displayText: aText
		on: graphicsContext
		at: atPoint
		textColor: ColorValue black
		vergeColor: ColorValue white
		styleSymbol: styleSymbol
		alignmentSymbol: alignmentSymbol
]

{ #category : #displaying }
JunAbstractView >> displayText: aText on: graphicsContext at: atPoint textColor: textColor vergeColor: vergeColor [ 
	self 
		displayText: aText
		on: graphicsContext
		at: atPoint
		textColor: textColor
		vergeColor: vergeColor
		styleSymbol: #default
		alignmentSymbol: #origin
]

{ #category : #displaying }
JunAbstractView >> displayText: aText on: graphicsContext at: atPoint textColor: textColor vergeColor: vergeColor styleSymbol: styleSymbol alignmentSymbol: alignmentSymbol [ 
	| composedText |
	composedText := ComposedText withText: aText asText
				style: (TextAttributes styleNamed: styleSymbol
						ifAbsent: [TextAttributes default]).
	self 
		displayComposedText: composedText
		on: graphicsContext
		at: atPoint
		textColor: textColor
		vergeColor: vergeColor
		alignmentSymbol: alignmentSymbol
]

{ #category : #evaluating }
JunAbstractView >> do: aBlock during: millisecondTime [ 
	^self class do: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractView >> do: doBlock ensure: ensureBlock [ 
	^self class do: doBlock ensure: ensureBlock
]

{ #category : #evaluating }
JunAbstractView >> do: aBlock forMicroseconds: microsecondTime [ 
	^self class do: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractView >> do: aBlock forMilliseconds: millisecondTime [ 
	^self class do: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunAbstractView >> do: aBlock framesPerSecond: aNumber [ 
	^self class do: aBlock framesPerSecond: aNumber
]

{ #category : #evaluating }
JunAbstractView >> fork: aBlock during: millisecondTime [ 
	^self class fork: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractView >> fork: aBlock forMicroseconds: microsecondTime [ 
	^self class fork: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractView >> fork: aBlock forMilliseconds: millisecondTime [ 
	^self class fork: aBlock forMilliseconds: millisecondTime
]

{ #category : #testing }
JunAbstractView >> hasOpenGLResource [
	^JunOpenGLInterface hasOpenGLResource
]

{ #category : #evaluating }
JunAbstractView >> punctuallyDo: aBlock during: millisecondTime [ 
	^self class punctuallyDo: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractView >> punctuallyDo: aBlock forMicroseconds: microsecondTime [ 
	^self class punctuallyDo: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractView >> punctuallyDo: aBlock forMilliseconds: millisecondTime [ 
	^self class punctuallyDo: aBlock forMilliseconds: millisecondTime
]

{ #category : #displaying }
JunAbstractView >> redisplay [
	self isOpen 
		ifTrue: 
			[self clearInside.
			self displayOn: self graphicsContext]
]

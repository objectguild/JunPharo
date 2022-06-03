"
Imported by VwImportClass
"
Class {
	#name : #JunApplicationModel,
	#superclass : #ApplicationModel,
	#instVars : [
		'closeBlock',
		'closeTogether'
	],
	#classInstVars : [
		'beingRegistry'
	],
	#category : #'Jun-System-Framework'
}

{ #category : #evaluating }
JunApplicationModel class >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	^JunControlUtility 
		assert: assertBlock
		do: doBlock
		ensure: ensureBlock
]

{ #category : #'lisp support' }
JunApplicationModel class >> colorValueFromLispList: aList [ 
	"self colorValueFromLispList: (JunApplicationModel new colorValueToLispList: (ColorValue pink))."

	| aClass aTable |
	aClass := Smalltalk at: aList head.
	aTable := self tableFromLispList: aList tail.
	^aClass 
		red: (aTable at: #red)
		green: (aTable at: #green)
		blue: (aTable at: #blue)
]

{ #category : #copyright }
JunApplicationModel class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #debug }
JunApplicationModel class >> debug: aBlock [ 
	"aBlock value"
]

{ #category : #defaults }
JunApplicationModel class >> defaultBaseName [
	^JunSystem defaultBaseName
]

{ #category : #utilities }
JunApplicationModel class >> displayPendingInvalidation [
	"JunApplicationModel displayPendingInvalidation."

	ScheduledControllers scheduledControllers do: [:each | each view displayPendingInvalidation]
]

{ #category : #evaluating }
JunApplicationModel class >> do: aBlock during: millisecondTime [ 
	^JunControlUtility do: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunApplicationModel class >> do: doBlock ensure: ensureBlock [ 
	^JunControlUtility do: doBlock ensure: ensureBlock
]

{ #category : #evaluating }
JunApplicationModel class >> do: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility do: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunApplicationModel class >> do: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility do: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunApplicationModel class >> do: aBlock framesPerSecond: aNumber [ 
	^JunControlUtility do: aBlock framesPerSecond: aNumber
]

{ #category : #resources }
JunApplicationModel class >> editMenu [
	"MenuEditor new openOnClass: self andSelector: #editMenu"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Find___ 
					#defaultString: 'Find...' ) 
				#value: #find ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Replace___ 
					#defaultString: 'Replace...' ) 
				#value: #replace ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Undo 
					#defaultString: 'Undo' ) 
				#value: #undo ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Copy 
					#defaultString: 'Copy' ) 
				#value: #copySelection ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Cut 
					#defaultString: 'Cut' ) 
				#value: #cut ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Paste 
					#defaultString: 'Paste' ) 
				#value: #paste ) ) #(2 1 3 ) nil ) decodeAsLiteralArray
]

{ #category : #resources }
JunApplicationModel class >> editMenu2 [
	"MenuEditor new openOnClass: self andSelector: #editMenu2"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Find___ 
					#defaultString: 'Find...' ) 
				#value: #find ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Replace___ 
					#defaultString: 'Replace...' ) 
				#value: #replace ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Undo 
					#defaultString: 'Undo' ) 
				#value: #undo ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Copy 
					#defaultString: 'Copy' ) 
				#value: #copySelection ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Cut 
					#defaultString: 'Cut' ) 
				#value: #cut ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Paste 
					#defaultString: 'Paste' ) 
				#value: #paste ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Accept 
					#defaultString: 'Accept' ) 
				#value: #accept ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Cancel 
					#defaultString: 'Cancel' ) 
				#value: #cancel ) ) #(2 1 3 2 ) nil ) decodeAsLiteralArray
]

{ #category : #resources }
JunApplicationModel class >> editMenu3 [
	"MenuEditor new openOnClass: self andSelector: #editMenu3"

	<resource: #menu>
	^#(#Menu #(
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Find___ 
					#defaultString: 'Find...' ) 
				#value: #find ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Replace___ 
					#defaultString: 'Replace...' ) 
				#value: #replace ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Undo 
					#defaultString: 'Undo' ) 
				#value: #undo ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Copy 
					#defaultString: 'Copy' ) 
				#value: #copySelection ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Cut 
					#defaultString: 'Cut' ) 
				#value: #cut ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Paste 
					#defaultString: 'Paste' ) 
				#value: #paste ) 
			#(#MenuItem 
				#rawLabel: #(#UserMessage 
					#key: #jun_Do_it 
					#defaultString: 'Do it' ) 
				#value: #doIt ) 
			#(#MenuItem 
				#rawLabel: #(#UserMessage 
					#key: #jun_Print_it 
					#defaultString: 'Print it' ) 
				#value: #printIt ) 
			#(#MenuItem 
				#rawLabel: #(#UserMessage 
					#key: #jun_Inspect_it 
					#defaultString: 'Inspect it' ) 
				#value: #inspectIt ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Accept 
					#defaultString: 'Accept' ) 
				#value: #accept ) 
			#(#MenuItem 
				#rawLabel: 
				#(#UserMessage 
					#key: #jun_Cancel 
					#defaultString: 'Cancel' ) 
				#value: #cancel ) ) #(2 1 3 3 2 ) nil ) decodeAsLiteralArray
]

{ #category : #examples }
JunApplicationModel class >> example1 [
	"JunApplicationModel example1."

	| aModel |
	aModel := JunApplicationModel new.
	aModel open.
	^aModel
]

{ #category : #evaluating }
JunApplicationModel class >> fork: aBlock during: millisecondTime [ 
	^JunControlUtility fork: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunApplicationModel class >> fork: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility fork: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunApplicationModel class >> fork: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility fork: aBlock forMilliseconds: millisecondTime
]

{ #category : #'lisp support' }
JunApplicationModel class >> fromLispList: aList [ 
	| aModel |
	aModel := (Smalltalk at: aList head) new.
	aModel class fromLispList: aList for: aModel.
	^aModel
]

{ #category : #'lisp support' }
JunApplicationModel class >> fromLispList: aList for: aModel [ 
	| aTable |
	aTable := self tableFromLispList: aList tail.
	aModel class fromTable: aTable for: aModel.
	^aModel
]

{ #category : #'instance creation' }
JunApplicationModel class >> fromString: aString [ 
	^self fromLispList: (self defaultLispParserClass parse: aString)
]

{ #category : #'lisp support' }
JunApplicationModel class >> fromTable: aTable for: aModel [ 
	| vars index var value nth |
	vars := aModel class allInstVarNames.
	(aTable associations asSortedCollection: [:a :b | a key head < b key head]) 
		do: 
			[:assoc | 
			index := assoc key head.
			var := assoc key tail.
			value := assoc value.
			nth := vars findFirst: [:each | each = var].
			nth > 0 
				ifTrue: 
					[nth = index ifFalse: [index := nth].
					aModel instVarAt: index put: value]
				ifFalse: 
					[Transcript
						cr;
						show: 'Not found instance variable ' , var printString , ' in ' 
									, aModel class printString]].
	^aModel
]

{ #category : #'lisp support' }
JunApplicationModel class >> lispCons [
	^self defaultLispConsClass cell
]

{ #category : #'lisp support' }
JunApplicationModel class >> lispNil [
	^self defaultLispNilClass null
]

{ #category : #'instance creation' }
JunApplicationModel class >> new [
	
	^(self basicNew)
		initialize;
		yourself
]

{ #category : #utilities }
JunApplicationModel class >> nineBoxes [
	"JunApplicationModel nineBoxes."

	^self nineBoxesOf: JunSystem screenBoundingBox
]

{ #category : #utilities }
JunApplicationModel class >> nineBoxesOf: aBox [ 
	"JunApplicationModel nineBoxesOf: (JunSystem screenBounds) first."

	| collection area box |
	collection := OrderedCollection new: 9.
	area := aBox origin extent: aBox extent / 3.
	#(#topLeft #topCenter #topRight #leftCenter #center #rightCenter #bottomLeft #bottomCenter #bottomRight) 
		do: 
			[:symbol | 
			box := (area align: (area perform: symbol) with: (aBox perform: symbol)) 
						rounded.
			collection add: symbol -> box].
	^collection
]

{ #category : #evaluating }
JunApplicationModel class >> punctuallyDo: aBlock during: millisecondTime [ 
	^JunControlUtility punctuallyDo: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunApplicationModel class >> punctuallyDo: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility punctuallyDo: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunApplicationModel class >> punctuallyDo: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility punctuallyDo: aBlock forMilliseconds: millisecondTime
]

{ #category : #registry }
JunApplicationModel class >> register: applicationModel [ 
	beingRegistry isNil ifTrue: [beingRegistry := WeakDictionary new].
	beingRegistry at: applicationModel hash put: applicationModel.
	self debug: 
			[Transcript
				cr;
				show: applicationModel printString , ' was born']
]

{ #category : #'lisp support' }
JunApplicationModel class >> showLispList: aList [ 
	^JunAbstractObject showLispList: aList
]

{ #category : #copyright }
JunApplicationModel class >> system [
	^'Jun'
]

{ #category : #'lisp support' }
JunApplicationModel class >> tableFromLispList: aList [ 
	"JunApplicationModel tableFromLispList: (JunLispParser parse: '((a . 1) (b . 2) (c . 3))')."

	| aTable |
	aTable := JunAttributeTable new.
	aList do: 
			[:pair | 
			(pair isKindOf: self defaultLispConsClass) 
				ifTrue: [aTable at: pair head put: pair tail]].
	^aTable
]

{ #category : #copyright }
JunApplicationModel class >> version [
	^'799'
]

{ #category : #'interface specs' }
JunApplicationModel class >> windowBounds [
	"JunApplicationModel windowBounds."

	"(JunApplicationModel withAllSubclasses 
		collect: [:aClass | aClass name -> aClass windowBounds]) 
			asSortedCollection do: 
				[:each | 
				Transcript
					cr;
					show: each printString]."

	^self windowBoundsInterface: #windowSpec
]

{ #category : #'interface specs' }
JunApplicationModel class >> windowBoundsInterface: aSymbol [ 
	"JunApplicationModel windowBoundsInterface: #windowSpec."

	"(JunApplicationModel withAllSubclasses 
		collect: [:aClass | aClass name -> (aClass windowBoundsInterface: #windowSpec)]) 
			asSortedCollection do: 
				[:each | 
				Transcript
					cr;
					show: each printString]."

	| box array index |
	box := 0 @ 0 extent: 200 @ 200.
	(self respondsTo: aSymbol) ifFalse: [^box].
	array := self perform: aSymbol.
	index := array indexOf: #window:.
	index < 1 ifTrue: [^box].
	array := array at: index + 1.
	index := array indexOf: #bounds:.
	index < 1 ifTrue: [^box].
	array := array at: index + 1.
	(array first = #Rectangle or: [array first = '#{Graphics.Rectangle}']) 
		ifFalse: [^box].
	box := Rectangle origin: (array at: 2) @ (array at: 3)
				corner: (array at: 4) @ (array at: 5).
	^box
]

{ #category : #'interface specs' }
JunApplicationModel class >> windowLabel [
	"JunApplicationModel windowLabel."
	"(JunApplicationModel withAllSubclasses collect: [:aClass | aClass name -> aClass windowLabel]) asSortedCollection
		do: [:each | Transcript cr; show: each printString]."

	| string array index |
	string := String new.
	(self respondsTo: #windowSpec) ifFalse: [^string].
	array := self perform: #windowSpec.
	index := array indexOf: #window:.
	index < 1 ifTrue: [^string].
	array := array at: index + 1.
	index := array indexOf: #label:.
	index < 1 ifTrue: [^string].
	array := array at: index + 1.
	(array isKindOf: String) ifTrue: [^string := array].
	(array first = #UserMessage or: [array first = '#{Kernel.UserMessage}']) 
		ifFalse: [^string].
	string := ((array at: 3) >> (array at: 5)) asString.
	^string
]

{ #category : #'interface specs' }
JunApplicationModel class >> windowSpec [
	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#('#{UI.FullSpec}' 
		#window: 
		#('#{UI.WindowSpec}' 
			#label: 
			#(#UserMessage 
				#key: #jun_Application 
				#defaultString: 'Application' ) 
			#bounds: #('#{Graphics.Rectangle}' 700 525 900 725 ) 
			#colors: 
			#('#{UI.LookPreferences}' 
				#setForegroundColor: nil 
				#setBackgroundColor: #('#{Graphics.ColorValue}' #white ) 
				#setSelectionForegroundColor: nil 
				#setSelectionBackgroundColor: nil 
				#setBorderColor: nil ) ) 
		#component: 
		#('#{UI.SpecCollection}' 
			#collection: #(
				#('#{UI.ArbitraryComponentSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 1 0 -1 1 -1 1 ) 
					#name: #createView 
					#component: #createView ) ) ) )
]

{ #category : #utilities }
JunApplicationModel >> alignedRectangleWithScreenCenter: extentPoint [ 
	"JunApplicationModel new alignedRectangleWithScreenCenter: 400 @ 300."

	^self class alignedRectangleWithScreenCenter: extentPoint
]

{ #category : #converting }
JunApplicationModel >> asImage [
	^self asWindowImage
]

{ #category : #converting }
JunApplicationModel >> asString [
	^self toLispList saveString
]

{ #category : #converting }
JunApplicationModel >> asWindowImage [
	| aWindow anImage |
	aWindow := self getWindow.
	aWindow isNil ifTrue: [^nil].
	aWindow isCollapsed ifTrue: [aWindow expand].
	aWindow raise.
	aWindow display.
	anImage := aWindow asImage.
	^anImage
]

{ #category : #evaluating }
JunApplicationModel >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	^self class 
		assert: assertBlock
		do: doBlock
		ensure: ensureBlock
]

{ #category : #displaying }
JunApplicationModel >> changedViewBox: newBounds [ 
	^self yourself
]

{ #category : #'interface closing' }
JunApplicationModel >> closeBlock [
	^closeBlock
]

{ #category : #'interface closing' }
JunApplicationModel >> closeBlock: aBlock [ 
	closeBlock := aBlock
]

{ #category : #'interface closing' }
JunApplicationModel >> closeRequest [
	self builder ifNil: 
			[self getWindow 
				ifNotNil: [:aWindow | aWindow isOpen ifTrue: [aWindow sensor eventQuit: nil]]]
		ifNotNil: 
			[:aBuilder | 
			aBuilder window 
				ifNotNil: [:aWindow | aWindow isOpen ifTrue: [aWindow sensor eventQuit: nil]]]
]

{ #category : #'interface closing' }
JunApplicationModel >> closeTogether [
	closeTogether ifNil: [closeTogether := Array new]
		ifNotNil: 
			[:aCollection | 
			closeTogether := aCollection reject: 
							[:each | 
							self errorSignal handle: [:exception | exception returnWith: true]
								do: [each getWindow isNil]]].
	^closeTogether
]

{ #category : #'interface closing' }
JunApplicationModel >> closeTogether: modelCollection [
	
	(modelCollection isKindOf: Collection)
		ifTrue:
			[closeTogether := modelCollection select: [:each | (each == self) not]]
		ifFalse: [closeTogether := Array with: modelCollection]
]

{ #category : #'interface closing' }
JunApplicationModel >> closeTogetherWhenAltDown: modelCollection [ 
	self closeBlock: 
			[:it | 
			JunSensorUtility altDown 
				ifTrue: 
					[self errorSignal handle: 
							[:exception | 
							(modelCollection respondsTo: #closeRequest) 
								ifTrue: [modelCollection closeRequest].
							exception return]
						do: 
							[modelCollection do: 
									[:each | 
									it = each 
										ifFalse: [(each respondsTo: #closeRequest) ifTrue: [each closeRequest]]]]]]
]

{ #category : #'interface closing' }
JunApplicationModel >> closeTogetherWhenShiftDown: modelCollection [ 
	self closeBlock: 
			[:it | 
			JunSensorUtility shiftDown 
				ifTrue: 
					[self errorSignal handle: 
							[:exception | 
							(modelCollection respondsTo: #closeRequest) 
								ifTrue: [modelCollection closeRequest].
							exception return]
						do: 
							[modelCollection do: 
									[:each | 
									it = each 
										ifFalse: [(each respondsTo: #closeRequest) ifTrue: [each closeRequest]]]]]]
]

{ #category : #'interface closing' }
JunApplicationModel >> closeTogetherWhenShiftDownOrAltDown: modelCollection [ 
	self closeBlock: 
			[:it | 
			(JunSensorUtility shiftDown or: [JunSensorUtility altDown]) 
				ifTrue: 
					[self errorSignal handle: 
							[:exception | 
							(modelCollection respondsTo: #closeRequest) 
								ifTrue: [modelCollection closeRequest].
							exception return]
						do: 
							[modelCollection do: 
									[:each | 
									it = each 
										ifFalse: [(each respondsTo: #closeRequest) ifTrue: [each closeRequest]]]]]]
]

{ #category : #'lisp support' }
JunApplicationModel >> colorValueToLispList: colorValue [ 
	"self showLispList: (JunApplicationModel new colorValueToLispList: (ColorValue pink))."

	| list species |
	list := self lispCons.
	list head: colorValue class name.
	species := self class defaultLispConsClass.
	list add: (species head: #red tail: colorValue red asFloat).
	list add: (species head: #green tail: colorValue green asFloat).
	list add: (species head: #blue tail: colorValue blue asFloat).
	^list
]

{ #category : #private }
JunApplicationModel >> composedText: composedText vergeColor: vergeColor [
	
	| aText aStream vergeComposedText |
	aText := composedText text.
	aStream := TextStream on: (String new: 16).
	(1 to: aText size)
		do:
			[:index | 
			| emphasis |
			emphasis := aText emphasisAt: index.
			(emphasis isNil or: [emphasis isSymbol])
				ifTrue: [aStream emphasis: emphasis]
				ifFalse:
					[| array |
					array := emphasis
						collect:
							[:each | 
							(each isKindOf: Association)
								ifTrue:
									[each key = #color
										ifTrue: [#color -> vergeColor]
										ifFalse: [each]]
								ifFalse: [each]].
					aStream emphasis: array].
			aStream nextPut: (aText at: index)].
	aText := aStream contents.
	vergeComposedText := ComposedText
		withText: aText
		style: composedText textStyle
		compositionWidth: composedText width.
	^vergeComposedText
]

{ #category : #'interface opening' }
JunApplicationModel >> createView [
	| aView |
	aView := JunAbstractView new.
	aView model: self.
	^aView
]

{ #category : #debug }
JunApplicationModel >> debug: aBlock [ 
	self class debug: aBlock
]

{ #category : #defaults }
JunApplicationModel >> defaultBaseName [
	^self class defaultBaseName
]

{ #category : #defaults }
JunApplicationModel >> defaultDisplayViewClass [
	^ScheduledWindow
]

{ #category : #defaults }
JunApplicationModel >> defaultImageQuality [
	^JunImageUtility defaultImageQuality
]

{ #category : #defaults }
JunApplicationModel >> defaultOffsetPoint [
	^25 @ 25
]

{ #category : #displaying }
JunApplicationModel >> displayComposedText: composedText on: graphicsContext at: atPoint [ 
	self 
		displayComposedText: composedText
		on: graphicsContext
		at: atPoint
		textColor: ColorValue black
		vergeColor: ColorValue white
		alignmentSymbol: #origin
]

{ #category : #displaying }
JunApplicationModel >> displayComposedText: composedText on: graphicsContext at: atPoint alignmentSymbol: alignmentSymbol [ 
	self 
		displayComposedText: composedText
		on: graphicsContext
		at: atPoint
		textColor: ColorValue black
		vergeColor: ColorValue white
		alignmentSymbol: alignmentSymbol
]

{ #category : #displaying }
JunApplicationModel >> displayComposedText: composedText on: graphicsContext at: atPoint textColor: textColor vergeColor: vergeColor [ 
	self 
		displayComposedText: composedText
		on: graphicsContext
		at: atPoint
		textColor: textColor
		vergeColor: vergeColor
		alignmentSymbol: #origin
]

{ #category : #displaying }
JunApplicationModel >> displayComposedText: composedText on: graphicsContext at: atPoint textColor: textColor vergeColor: vergeColor alignmentSymbol: alignmentSymbol [ 
	| vergeComposedText composedBox displayPoint |
	vergeComposedText := self composedText: composedText vergeColor: vergeColor.
	composedBox := composedText bounds.
	composedBox := composedBox align: (composedBox perform: alignmentSymbol)
				with: atPoint.
	displayPoint := composedBox origin.
	(self neighborhoodPoints: displayPoint) do: 
			[:aPoint | 
			graphicsContext paint: vergeColor.
			vergeComposedText displayOn: graphicsContext at: aPoint].
	graphicsContext paint: textColor.
	composedText displayOn: graphicsContext at: displayPoint
]

{ #category : #displaying }
JunApplicationModel >> displayImage: anImage on: graphicsContext at: atPoint [ 
	^self 
		displayImage: anImage
		on: graphicsContext
		at: atPoint
		alignmentSymbol: #origin
]

{ #category : #displaying }
JunApplicationModel >> displayImage: anImage on: graphicsContext at: atPoint alignmentSymbol: alignmentSymbol [ 
	| composedBox displayPoint |
	composedBox := anImage bounds.
	composedBox := composedBox align: (composedBox perform: alignmentSymbol)
				with: atPoint.
	displayPoint := composedBox origin.
	anImage displayOn: graphicsContext at: displayPoint
]

{ #category : #displaying }
JunApplicationModel >> displayOn: graphicsContext dotBox: aRectangle [ 
	aRectangle width < 3 
		ifTrue: [graphicsContext displayRectangle: aRectangle]
		ifFalse: 
			[graphicsContext 
				displayWedgeBoundedBy: (aRectangle expandedBy: (0 @ 0 corner: 1 @ 1))
				startAngle: 0
				sweepAngle: 360]
]

{ #category : #private }
JunApplicationModel >> displayPendingInvalidation [
	| aWindow |
	(aWindow := self getWindow) notNil ifTrue: [aWindow displayPendingInvalidation].
	ScheduledControllers scheduledControllers do: [:each | each view displayPendingInvalidation]
]

{ #category : #displaying }
JunApplicationModel >> displayText: aText on: graphicsContext at: atPoint [ 
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
JunApplicationModel >> displayText: aText on: graphicsContext at: atPoint alignmentSymbol: alignmentSymbol [ 
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
JunApplicationModel >> displayText: aText on: graphicsContext at: atPoint styleSymbol: styleSymbol [ 
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
JunApplicationModel >> displayText: aText on: graphicsContext at: atPoint styleSymbol: styleSymbol alignmentSymbol: alignmentSymbol [ 
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
JunApplicationModel >> displayText: aText on: graphicsContext at: atPoint textColor: textColor vergeColor: vergeColor [ 
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
JunApplicationModel >> displayText: aText on: graphicsContext at: atPoint textColor: textColor vergeColor: vergeColor styleSymbol: styleSymbol alignmentSymbol: alignmentSymbol [ 
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
JunApplicationModel >> do: aBlock during: millisecondTime [ 
	^self class do: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunApplicationModel >> do: doBlock ensure: ensureBlock [ 
	^self class do: doBlock ensure: ensureBlock
]

{ #category : #evaluating }
JunApplicationModel >> do: aBlock forMicroseconds: microsecondTime [ 
	^self class do: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunApplicationModel >> do: aBlock forMilliseconds: millisecondTime [ 
	^self class do: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunApplicationModel >> do: aBlock framesPerSecond: aNumber [ 
	^self class do: aBlock framesPerSecond: aNumber
]

{ #category : #finalization }
JunApplicationModel >> finalize [
	self debug: 
			[Transcript
				cr;
				show: self printString , ' passed away'].
	super finalize
]

{ #category : #flushing }
JunApplicationModel >> flushMenus [
	^self
]

{ #category : #flushing }
JunApplicationModel >> flushVisuals [
	^self
]

{ #category : #evaluating }
JunApplicationModel >> fork: aBlock during: millisecondTime [ 
	^self class fork: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunApplicationModel >> fork: aBlock forMicroseconds: microsecondTime [ 
	^self class fork: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunApplicationModel >> fork: aBlock forMilliseconds: millisecondTime [ 
	^self class fork: aBlock forMilliseconds: millisecondTime
]

{ #category : #private }
JunApplicationModel >> getController [
	| aView |
	aView := self getView.
	aView isNil ifTrue: [^nil].
	^aView controller
]

{ #category : #private }
JunApplicationModel >> getControllers [
	^self getViews collect: [:each | each controller]
]

{ #category : #private }
JunApplicationModel >> getView [
	| aView |
	aView := self dependents detect: 
					[:each | 
					(each isKindOf: self defaultDisplayViewClass) and: [each model = self]]
				ifNone: [nil].
	aView isNil ifTrue: [^nil].
	^aView
]

{ #category : #private }
JunApplicationModel >> getViews [
	| viewCollection |
	viewCollection := self dependents select: 
					[:each | 
					(each isKindOf: self defaultDisplayViewClass) and: [each model = self]].
	^viewCollection
]

{ #category : #private }
JunApplicationModel >> getWindow [
	self getView ifNil: 
			[self builder ifNil: [^nil]
				ifNotNil: 
					[:aBuilder | 
					aBuilder window ifNil: [^nil]
						ifNotNil: [:aWindow | aWindow isOpen ifTrue: [^aWindow] ifFalse: [^nil]]]]
		ifNotNil: [:aView | ^aView topComponent]
]

{ #category : #private }
JunApplicationModel >> getWindows [
	^self getViews collect: [:each | each topComponent]
]

{ #category : #'initialize-release' }
JunApplicationModel >> initialize [
	super initialize.
	closeBlock := nil.
	closeTogether := nil
]

{ #category : #'menu messages' }
JunApplicationModel >> inspectModel [
	JunSystem isRuntimeVersion ifTrue: [^self].
	self inspect
]

{ #category : #keyboard }
JunApplicationModel >> keyboardDispathDebug [
	^false
]

{ #category : #keyboard }
JunApplicationModel >> keyboardEvent: event fromController: controller [ 
	self keyboardDispathDebug ifTrue: [Transcript cr; show: event keyValue printString].
	^event
]

{ #category : #'lisp support' }
JunApplicationModel >> kindName [
	^self class name
]

{ #category : #'lisp support' }
JunApplicationModel >> lispCons [
	^self class lispCons
]

{ #category : #'lisp support' }
JunApplicationModel >> lispNil [
	^self class lispNil
]

{ #category : #private }
JunApplicationModel >> marginRectangleForVisibleScreenArea [
	^10 @ 30 corner: 10 @ 10
]

{ #category : #'menu accessing' }
JunApplicationModel >> menuBar [
	| aMenu |
	aMenu := nil.
	self getWindow ifNotNil: 
			[:aWindow | 
			aWindow isOpen 
				ifTrue: 
					[aWindow keyboardProcessor ifNotNil: 
							[:aKeyboardProcessor | 
							aKeyboardProcessor menuBar ifNotNil: 
									[:aMenuBar | 
									(aMenuBar isKindOf: MenuBar) 
										ifTrue: 
											[| index |
											index := aMenuBar class allInstVarNames indexOf: 'menuChannel'.
											index > 0 
												ifTrue: 
													[(aMenuBar instVarAt: index) 
														ifNotNil: [:menuChannel | aMenu := menuChannel value]]]]]]].
	aMenu ifNil: 
			[(self class respondsTo: #menuBar) ifTrue: [aMenu := self class menuBar]].
	^aMenu
]

{ #category : #'menu accessing' }
JunApplicationModel >> menuItemLabelArray: labelArray inMenu: parentMenu [ 
	^JunMenuUtility menuItemLabelArray: labelArray inMenu: parentMenu
]

{ #category : #'menu accessing' }
JunApplicationModel >> menuItemLabelArray: labelArray inMenu: parentMenu ifNone: exceptionBlock [ 
	^JunMenuUtility 
		menuItemLabelArray: labelArray
		inMenu: parentMenu
		ifNone: exceptionBlock
]

{ #category : #'menu accessing' }
JunApplicationModel >> menuItemLabeled: aString inMenu: aMenu [ 
	^JunMenuUtility menuItemLabeled: aString inMenu: aMenu
]

{ #category : #'menu accessing' }
JunApplicationModel >> menuItemLabeled: aString inMenu: aMenu ifNone: exceptionBlock [ 
	^JunMenuUtility 
		menuItemLabeled: aString
		inMenu: aMenu
		ifNone: exceptionBlock
]

{ #category : #'menu messages' }
JunApplicationModel >> newModel [
	| aModel |
	aModel := self class new.
	self getWindow ifNil: [aModel open]
		ifNotNil: 
			[:aWindow | 
			aModel openIn: (Screen default 
						makeRectangleVisible: (aWindow displayBox translatedBy: 25 @ 25))].
	^aModel
]

{ #category : #'interface closing' }
JunApplicationModel >> noticeOfWindowClose: aWindow [
	
	super noticeOfWindowClose: aWindow.
	closeBlock notNil
		ifTrue:
			[closeBlock
				valueWithArguments:
					((Array
						with: self
						with: aWindow
						with: self getView
						with: self getViews)
						copyFrom: 1
						to: closeBlock numArgs)].
	closeTogether
		ifNotNil:
			[self errorSignal
				handle:
					[:exception | 
					(closeTogether respondsTo: #closeRequest)
						ifTrue: [closeTogether closeRequest].
					exception return]
				do:
					[closeTogether
						do:
							[:each | (each respondsTo: #closeRequest) ifTrue: [each closeRequest]]]].
	Cursor normal show
]

{ #category : #'interface opening' }
JunApplicationModel >> openAt: aPoint [ 
	"JunApplicationModel new openAt: JunSystem screenCenter."

	^self openAt: aPoint interface: #windowSpec
]

{ #category : #'interface opening' }
JunApplicationModel >> openAt: aPoint interface: aSymbol [ 
	"JunApplicationModel new openAt: JunSystem screenCenter interface: #windowSpec."

	| aWindow aBox |
	self allButOpenInterface: aSymbol.
	aWindow := self builder window.
	aBox := aPoint extent: aWindow bounds extent.
	aWindow openIn: aBox.
	aWindow displayPendingInvalidation.
	self postOpenWith: self builder.
	^aWindow
]

{ #category : #'interface opening' }
JunApplicationModel >> openIn: aRectangle [ 
	"JunApplicationModel new openIn: ((400 , 300) alignedRectangleWithScreenCenter)."

	^self openIn: aRectangle interface: #windowSpec
]

{ #category : #'interface opening' }
JunApplicationModel >> openIn: aRectangle interface: aSymbol [ 
	"JunApplicationModel new openIn: ((400 , 300) alignedRectangleWithScreenCenter) interface: #windowSpec."

	| aWindow |
	self allButOpenInterface: aSymbol.
	aWindow := self builder window.
	aWindow openIn: (aRectangle origin rounded 
				extent: ((aRectangle extent max: aWindow minimumSize) 
						min: aWindow maximumSize) rounded).
	aWindow displayPendingInvalidation.
	self postOpenWith: self builder.
	^aWindow
]

{ #category : #'interface opening' }
JunApplicationModel >> openWithExtent: aPoint [

	^self openIn: (self alignedRectangleWithScreenCenter: aPoint)
]

{ #category : #'interface opening' }
JunApplicationModel >> postBuildWith: aBuilder [

	(aBuilder source == self and: [aBuilder keyboardProcessor keyboardHook isNil])
		ifTrue: 
			[aBuilder keyboardProcessor
				keyboardHook: [:event :controller | self keyboardEvent: event fromController: controller]].
	super postBuildWith: aBuilder
]

{ #category : #'interface opening' }
JunApplicationModel >> postOpenWith: aBuilder [ 
	super postOpenWith: aBuilder.
	self setWindowLabel.
	self updateMenuIndication
]

{ #category : #evaluating }
JunApplicationModel >> punctuallyDo: aBlock during: millisecondTime [ 
	^self class punctuallyDo: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunApplicationModel >> punctuallyDo: aBlock forMicroseconds: microsecondTime [ 
	^self class punctuallyDo: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunApplicationModel >> punctuallyDo: aBlock forMilliseconds: millisecondTime [ 
	^self class punctuallyDo: aBlock forMilliseconds: millisecondTime
]

{ #category : #'menu messages' }
JunApplicationModel >> quitDoing [
	self closeRequest
]

{ #category : #'menu messages' }
JunApplicationModel >> quitModel [
	self closeRequest
]

{ #category : #'menu messages' }
JunApplicationModel >> readImageFrom: aFilename [ 
	| aClass aStream anImage |
	aClass := JunImageStream imageStreamClassForFileName: aFilename.
	aClass isNil ifTrue: [^nil].
	self 
		assert: [aStream := aClass on: aFilename asFilename readStream]
		do: [Cursor read showWhile: [anImage := aStream nextImage]]
		ensure: [aStream close].
	^anImage
]

{ #category : #'menu messages' }
JunApplicationModel >> requestNewImageFilename [
	"JunApplicationModel new requestNewImageFilename."

	| labels values menu message aFilename |
	labels := Array 
				with: (Array with: (#jun_Image_files >> 'Image files') asString).
	values := Array with: JunSystem defaultImageExtensionPatterns.
	menu := Menu labelList: labels values: values.
	message := #jun_Input_an_image_file_ >> 'Input an image file.' 
				expandMacrosWith: 'image'.
	aFilename := JunFileRequesterDialog 
				requestNewFilename: message
				initialFilename: ((JunSensorUtility shiftDown 
						or: [JunSensorUtility altDown]) 
							ifTrue: 
								[self getWindow ifNil: [self defaultBaseName]
									ifNotNil: 
										[:window | 
										JunSensorUtility altDown 
											ifTrue: [window label asString , self defaultBaseName]
											ifFalse: [window label asString]]]
							ifFalse: [self defaultBaseName]) , '.jpg'
				fileTypeMenu: menu
				initialFileType: values first.
	aFilename isNil ifTrue: [^nil].
	^aFilename
]

{ #category : #'menu messages' }
JunApplicationModel >> saveAsImage [
	| anImage aFilename |
	anImage := self asImage.
	anImage isNil ifTrue: [^nil].
	aFilename := self requestNewImageFilename.
	aFilename isNil ifTrue: [^nil].
	self writeImage: anImage to: aFilename.
	^anImage
]

{ #category : #'menu messages' }
JunApplicationModel >> saveAsImageTo: aFilename [ 
	| anImage |
	anImage := self asImage.
	anImage isNil ifTrue: [^nil].
	self writeImage: anImage to: aFilename
]

{ #category : #'interface opening' }
JunApplicationModel >> secretOpen [
	| aWindow aRectangle |
	self allButOpenInterface: #windowSpec.
	aWindow := self builder window.
	aRectangle := Screen default bounds corner - (25 @ 50) 
				extent: aWindow bounds extent.
	aWindow setDisplayBox: aRectangle.
	aWindow privateOpenForced: true.
	aWindow collapse.
	Cursor normal show.
	self displayPendingInvalidation.
	self postOpenWith: self builder.
	^aWindow
]

{ #category : #private }
JunApplicationModel >> setSize: extent [ 
	| aWindow difExtent newExtent newBox aView |
	aWindow := self getWindow.
	aWindow isNil ifTrue: [^nil].
	aView := self getView.
	aView isNil ifTrue: [^nil].
	difExtent := extent - aView bounds extent.
	newExtent := aWindow bounds extent + difExtent.
	newExtent := newExtent rounded max: aWindow minimumSize.
	newBox := aWindow globalOrigin extent: newExtent.
	aWindow displayBox: newBox rounded
]

{ #category : #'interface opening' }
JunApplicationModel >> setWindowLabel [
	| aWindow |
	aWindow := self getWindow.
	aWindow isNil ifTrue: [^nil].
	aWindow model = self ifFalse: [^nil].
	(self respondsTo: #defaultWindowLabel) 
		ifTrue: 
			[(self perform: #defaultWindowLabel) ifNotNil: [:it | aWindow label: it]]
		ifFalse: 
			[(self builder notNil and: 
					[self builder windowSpec notNil 
						and: [self builder windowSpec respondsTo: #label]]) 
				ifTrue: [aWindow label: self builder windowSpec label asString]]
]

{ #category : #'lisp support' }
JunApplicationModel >> showLispList [
	^self showLispList: self toLispList
]

{ #category : #'lisp support' }
JunApplicationModel >> showLispList: aList [ 
	^self class showLispList: aList
]

{ #category : #'lisp support' }
JunApplicationModel >> toLispList [
	| list vars collection |
	list := self lispCons.
	list head: self kindName.
	vars := self class allInstVarNames.
	collection := self toLispListInstanceVariables.
	(1 to: vars size) with: vars
		do: 
			[:index :var | 
			(collection includes: var) 
				ifTrue: 
					[| couple pair |
					couple := self lispCons.
					couple head: index.
					couple tail: var.
					pair := self lispCons.
					pair head: couple.
					pair tail: (self instVarAt: index).
					list add: pair]].
	^list
]

{ #category : #'lisp support' }
JunApplicationModel >> toLispListInstanceVariables [
	^Array new
]

{ #category : #'menu messages' }
JunApplicationModel >> underConstruction [
	JunDialog 
		warn: (#jun_Sorry__it_is_under_construction_ 
				>> 'Sorry, it is under construction.') asString
]

{ #category : #'menu accessing' }
JunApplicationModel >> updateMenuIndication [
	^self
]

{ #category : #private }
JunApplicationModel >> updateMenus [
	| aWindow aBlock aCollection |
	self flushMenus.
	aWindow := self getWindow.
	aWindow isNil ifTrue: [^nil].
	aBlock := nil.
	aCollection := OrderedCollection new.
	aBlock := 
			[:aComponent | 
			(aComponent isKindOf: MenuBar)
				ifTrue: [aCollection add: aComponent].
			(aComponent respondsTo: #component)
				ifTrue: [aBlock value: aComponent component].
			(aComponent respondsTo: #components)
				ifTrue: [aComponent components do: [:each | aBlock value: each]]].
	aBlock value: aWindow component.
	aCollection do: [:each | each updateMenu]
]

{ #category : #private }
JunApplicationModel >> updateWindow [
	| aWindow |
	self flushMenus.
	self updateMenus.
	self setWindowLabel.
	self flushVisuals.
	(aWindow := self getWindow) notNil ifTrue: [aWindow refresh]
]

{ #category : #'menu messages' }
JunApplicationModel >> writeImage: anImage to: aFilename [ 
	^JunImageUtility writeImage: anImage to: aFilename
]

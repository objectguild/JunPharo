"
Imported by VwImportClass
"
Class {
	#name : #JunAbstractModel,
	#superclass : #JunApplicationModel,
	#instVars : [
		'attributeTable'
	],
	#category : #'Jun-System-Framework'
}

{ #category : #copyright }
JunAbstractModel class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunAbstractModel class >> example1 [
	"JunAbstractModel example1."

	| aModel |
	aModel := JunAbstractModel new.
	aModel open.
	^aModel
]

{ #category : #examples }
JunAbstractModel class >> example2 [
	"JunAbstractModel example2."

	| aModel |
	aModel := JunAbstractModel new.
	aModel displayBlock: 
			[:graphicsContext :aView :aController | 
			| anImage |
			graphicsContext
				paint: ColorValue red;
				displayRectangle: (aView bounds insetBy: 10);
				paint: ColorValue green;
				displayRectangle: (aView bounds insetBy: 20);
				paint: ColorValue blue;
				displayRectangle: (aView bounds insetBy: 30);
				paint: ColorValue white;
				displayRectangle: (aView bounds insetBy: 40).
			anImage := JunSampleTriangle exampleAoki.
			anImage displayOn: graphicsContext
				at: aView bounds center - anImage bounds center].
	aModel open.
	^aModel
]

{ #category : #examples }
JunAbstractModel class >> example3 [
	"JunAbstractModel example3."

	| aModel |
	aModel := JunAbstractModel new.
	aModel displayBlock: 
			[:graphicsContext :aView :aController | 
			| anImage |
			graphicsContext
				paint: ColorValue red;
				displayRectangle: (aView bounds insetBy: 10);
				paint: ColorValue green;
				displayRectangle: (aView bounds insetBy: 20);
				paint: ColorValue blue;
				displayRectangle: (aView bounds insetBy: 30);
				paint: ColorValue white;
				displayRectangle: (aView bounds insetBy: 40).
			anImage := JunSampleTriangle exampleAoki.
			anImage displayOn: graphicsContext
				at: aView bounds center - anImage bounds center].
	aModel open.
	(Delay forSeconds: 3) wait.
	aModel displayBlock: 
			[:graphicsContext :aView :aController | 
			| anImage |
			graphicsContext
				paint: ColorValue cyan;
				displayRectangle: (aView bounds insetBy: 10);
				paint: ColorValue magenta;
				displayRectangle: (aView bounds insetBy: 20);
				paint: ColorValue yellow;
				displayRectangle: (aView bounds insetBy: 30);
				paint: ColorValue white;
				displayRectangle: (aView bounds insetBy: 40).
			anImage := JunSampleTriangle exampleMickey.
			anImage displayOn: graphicsContext
				at: aView bounds center - anImage bounds center].
	^aModel
]

{ #category : #examples }
JunAbstractModel class >> example4 [
	"JunAbstractModel example4."

	| aModel aBox |
	aModel := JunAbstractModel new.
	aModel displayBlock: 
			[:graphicsContext :aView :aController :viewCollection | 
			| anImage |
			graphicsContext
				paint: ColorValue red;
				displayRectangle: (aView bounds insetBy: 10);
				paint: ColorValue green;
				displayRectangle: (aView bounds insetBy: 20);
				paint: ColorValue blue;
				displayRectangle: (aView bounds insetBy: 30);
				paint: ColorValue white;
				displayRectangle: (aView bounds insetBy: 40).
			anImage := JunSampleTriangle exampleAoki.
			anImage displayOn: graphicsContext
				at: aView bounds center - anImage bounds center].
	aBox := 100 @ 200 extent: aModel class windowBounds extent.
	3 timesRepeat: [aModel openIn: (aBox := aBox translatedBy: 150 @ 50)].
	(Delay forSeconds: 3) wait.
	aModel displayBlock: 
			[:graphicsContext :aView :aController :viewCollection | 
			| anImage |
			graphicsContext
				paint: ColorValue cyan;
				displayRectangle: (aView bounds insetBy: 10);
				paint: ColorValue magenta;
				displayRectangle: (aView bounds insetBy: 20);
				paint: ColorValue yellow;
				displayRectangle: (aView bounds insetBy: 30);
				paint: ColorValue white;
				displayRectangle: (aView bounds insetBy: 40).
			anImage := JunSampleTriangle exampleMickey.
			anImage displayOn: graphicsContext
				at: aView bounds center - anImage bounds center].
	^aModel
]

{ #category : #resources }
JunAbstractModel class >> menuBar [
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
								#key: #jun_Quit 
								#defaultString: 'Quit' ) 
							#value: #quitModel ) ) #(1 1 ) nil ) ) 
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_Misc 
					#defaultString: 'Misc' ) 
				#submenu: #('#{UI.Menu}' #(
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Inspect 
								#defaultString: 'Inspect' ) 
							#value: #inspectModel ) ) #(1 ) nil ) ) ) #(2 ) nil ) decodeAsLiteralArray
]

{ #category : #copyright }
JunAbstractModel class >> system [
	^'Jun'
]

{ #category : #copyright }
JunAbstractModel class >> version [
	^'799'
]

{ #category : #'interface specs' }
JunAbstractModel class >> windowSpec [
	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#('#{UI.FullSpec}' 
		#window: 
		#('#{UI.WindowSpec}' 
			#label: 
			#('#{Kernel.UserMessage}' 
				#key: #jun_Abstract_MVC 
				#defaultString: 'Abstract MVC' ) 
			#min: #('#{Core.Point}' 220 240 ) 
			#max: #('#{Core.Point}' 0 0 ) 
			#bounds: #('#{Graphics.Rectangle}' 512 384 812 684 ) 
			#flags: 4 
			#menu: #menuBar 
			#colors: 
			#('#{UI.LookPreferences}' 
				#setBackgroundColor: #('#{Graphics.ColorValue}' #white ) ) ) 
		#component: 
		#('#{UI.SpecCollection}' 
			#collection: #(
				#('#{UI.ArbitraryComponentSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 1 0 -1 1 -1 1 ) 
					#component: #createView ) ) ) )
]

{ #category : #resources }
JunAbstractModel class >> yellowButtonMenu [
	^nil
]

{ #category : #converting }
JunAbstractModel >> asImage [
	| aView aPoint aPixmap anImage |
	(aView := self getView) isNil 
		ifTrue: [aPoint := 100 @ 100]
		ifFalse: [aPoint := aView bounds extent].
	self 
		assert: [aPixmap := Pixmap extent: aPoint]
		do: 
			[Cursor execute showWhile: 
					[| aGraphicsContext |
					(aGraphicsContext := aPixmap graphicsContext)
						paint: (self getWindow ifNil: [ColorValue white]
									ifNotNil: [:aWindow | aWindow backgroundPattern]);
						displayRectangle: aPixmap bounds.
					aView notNil ifTrue: [aView displayOn: aGraphicsContext].
					anImage := aPixmap asImage]]
		ensure: [aPixmap close].
	^anImage
]

{ #category : #accessing }
JunAbstractModel >> attributeTable [
	^attributeTable
]

{ #category : #'interface opening' }
JunAbstractModel >> createView [
	| aView |
	aView := self defaultViewClass new.
	aView model: self.
	(aView controller respondsTo: #menuHolder:) 
		ifTrue: [aView controller menuHolder: [self yellowButtonMenu]].
	(aView controller respondsTo: #performer:) 
		ifTrue: [aView controller performer: self].
	^aView
]

{ #category : #defaults }
JunAbstractModel >> defaultViewClass [
	^JunAbstractView
]

{ #category : #displaying }
JunAbstractModel >> displayBlock [
	^self attributeTable at: #displayBlock ifAbsentPut: [nil]
]

{ #category : #displaying }
JunAbstractModel >> displayBlock: aBlock [ 
	self attributeTable at: #displayBlock
		put: 
			[:graphicsContext | 
			| numberOfArguments |
			numberOfArguments := aBlock numArgs.
			numberOfArguments = 0 ifTrue: [aBlock value].
			numberOfArguments = 1 ifTrue: [aBlock value: graphicsContext].
			numberOfArguments = 2 
				ifTrue: [aBlock value: graphicsContext value: self getView].
			numberOfArguments = 3 
				ifTrue: 
					[aBlock 
						value: graphicsContext
						value: self getView
						value: (self getView ifNil: [nil] ifNotNil: [:aView | aView controller])].
			numberOfArguments = 4 
				ifTrue: 
					[aBlock valueWithArguments: (Array 
								with: graphicsContext
								with: self getView
								with: (self getView ifNil: [nil] ifNotNil: [:aView | aView controller])
								with: self getViews)]].
	self changed
]

{ #category : #displaying }
JunAbstractModel >> displayOn: graphicsContext [
	
	self displayBlock
		ifNotNil:
			[:aBlock | 
			[aBlock value: graphicsContext]
				on: self errorSignal
				do:
					[:exception | 
					| aStream aString |
					self
						assert: [aStream := String new writeStream]
						do:
							[aStream
								nextPutAll: 'ERROR! ';
								nextPutAll: exception description;
								cr;
								nextPutAll: 'in ';
								nextPutAll: thisContext printString;
								cr;
								nextPutAll: 'at ';
								nextPutAll: JunCalendarModel stringFromDateAndTime;
								flush.
							aString := aStream contents]
						ensure: [aStream close].
					Transcript
						cr;
						show: aString.
					self getView
						ifNotNil:
							[:view | 
							| aComposedText |
							aComposedText := ComposedText
								withText: aString asText allBold
								style: TextAttributes default
								compositionWidth: view bounds width - 40.
							self
								displayComposedText: aComposedText
								on: graphicsContext
								at: view bounds center - aComposedText bounds center
								textColor: ColorValue red
								vergeColor: ColorValue white].
					exception return]]
]

{ #category : #private }
JunAbstractModel >> getView [
	| aView |
	aView := self dependents 
				detect: [:each | (each isKindOf: self defaultViewClass) and: [each model = self]]
				ifNone: [nil].
	^aView
]

{ #category : #private }
JunAbstractModel >> getViews [
	| viewCollection |
	viewCollection := self dependents 
				select: [:each | (each isKindOf: self defaultViewClass) and: [each model = self]].
	^viewCollection
]

{ #category : #'initialize-release' }
JunAbstractModel >> initialize [
	super initialize.
	attributeTable := JunAttributeTable new
]

{ #category : #'interface closing' }
JunAbstractModel >> noticeOfWindowClose: aWindow [ 
	super noticeOfWindowClose: aWindow.
	self dependents do: 
			[:each | 
			((each isKindOf: ScheduledWindow) and: [each model = self]) 
				ifTrue: [each sensor eventQuit: nil]]
]

{ #category : #'menu messages' }
JunAbstractModel >> openImage [
	| labels values menu filename |
	labels := Array 
				with: (Array with: (#jun_Gazou_file >> 'image files') asString).
	JunMovieInterface isValid 
		ifTrue: [values := Array with: JunSystem defaultImageExtensionPatterns]
		ifFalse: [values := Array with: #('*.gif' '*.GIF')].
	menu := Menu labelList: labels values: values.
	filename := JunFileRequesterDialog 
				requestFilename: (#jun_Select_a_gazou_file_ >> 'Select a image file') 
						asString
				initialFilename: nil
				fileTypeMenu: menu
				initialFileType: values first.
	filename isNil ifTrue: [^nil].
	^self openImageFrom: filename
]

{ #category : #'menu messages' }
JunAbstractModel >> openImageFrom: aFilename [ 
	| anImage |
	aFilename asFilename exists ifFalse: [^nil].
	JunMovieInterface isValid 
		ifTrue: 
			[| aMovie |
			self 
				assert: [aMovie := JunQuickTimeMovie filename: aFilename]
				do: [Cursor read showWhile: [anImage := aMovie asImage]]
				ensure: [aMovie releaseMovie]]
		ifFalse: 
			[| aStream |
			self 
				assert: [aStream := JunGifImageStream on: aFilename readStream]
				do: [Cursor read showWhile: [anImage := aStream nextImage]]
				ensure: [aStream close]].
	^anImage
]

{ #category : #'menu messages' }
JunAbstractModel >> saveImage [
	| labels values menu filename |
	labels := Array 
				with: (Array with: (#jun_Gazou_file >> 'image files') asString).
	values := Array with: #('*.jpg' '*.JPG').
	menu := Menu labelList: labels values: values.
	filename := JunFileRequesterDialog 
				requestNewFilename: (#jun_Input_a_gazou_file_ >> 'Input a image file') 
						asString
				initialFilename: self defaultBaseName , '.jpg'
				fileTypeMenu: menu
				initialFileType: values first.
	filename isNil ifTrue: [^nil].
	^self saveImageTo: filename
]

{ #category : #'menu messages' }
JunAbstractModel >> saveImageTo: aFilename [ 
	| anImage |
	(anImage := self asImage) isNil ifTrue: [^nil].
	JunMovieInterface isValid 
		ifTrue: 
			[| aStream |
			self 
				assert: 
					[aStream := JunJpegImageStream on: aFilename writeStream quality: 0.95]
				do: [Cursor write showWhile: [aStream nextPutImage: anImage]]
				ensure: [aStream close]]
		ifFalse: 
			[| aStream |
			self 
				assert: [aStream := JunGifImageStream on: aFilename writeStream]
				do: [Cursor write showWhile: [aStream nextPutImage: anImage]]
				ensure: [aStream close]].
	^aFilename
]

{ #category : #'menu accessing' }
JunAbstractModel >> updateFileMenuIndication [
	| menuItem aMenu |
	(menuItem := self menuItemLabeled: 'File' inMenu: self menuBar) isNil 
		ifTrue: [^self].
	(aMenu := menuItem submenu) isNil ifTrue: [^nil].
	(menuItem := aMenu menuItemWithValue: #newModel ifNone: [nil]) notNil 
		ifTrue: [menuItem enable].
	(menuItem := aMenu menuItemWithValue: #quitModel ifNone: [nil]) notNil 
		ifTrue: [menuItem enable]
]

{ #category : #'menu accessing' }
JunAbstractModel >> updateMenuIndication [
	super updateMenuIndication.
	self updateFileMenuIndication.
	self updateMiscMenuIndication.
	self updateYellowButtonMenuIndication
]

{ #category : #'menu accessing' }
JunAbstractModel >> updateMiscMenuIndication [
	| menuItem aMenu |
	(menuItem := self menuItemLabeled: 'Misc' inMenu: self menuBar) isNil 
		ifTrue: [^self].
	(aMenu := menuItem submenu) isNil ifTrue: [^nil].
	(menuItem := aMenu menuItemWithValue: #inspectModel ifNone: [nil]) notNil 
		ifTrue: 
			[JunSystem isRuntimeVersion 
				ifTrue: [menuItem disable]
				ifFalse: [menuItem enable]]
]

{ #category : #'menu accessing' }
JunAbstractModel >> updateYellowButtonMenuIndication [
	| aMenu menuItem |
	(aMenu := self yellowButtonMenu) isNil ifTrue: [^nil].
	(menuItem := aMenu menuItemWithValue: #yourself ifNone: [nil]) notNil 
		ifTrue: [menuItem enable]
]

{ #category : #'menu accessing' }
JunAbstractModel >> yellowButtonMenu [
	^self attributeTable at: #yellowButtonMenu ifAbsentPut: [self class yellowButtonMenu]
]

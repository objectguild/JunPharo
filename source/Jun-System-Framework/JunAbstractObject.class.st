"
Imported by VwImportClass
"
Class {
	#name : #JunAbstractObject,
	#superclass : #Object,
	#category : #'Jun-System-Framework'
}

{ #category : #evaluating }
JunAbstractObject class >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	^JunControlUtility 
		assert: assertBlock
		do: doBlock
		ensure: ensureBlock
]

{ #category : #'lisp support' }
JunAbstractObject class >> colorValueFromLispList: aList [ 
	"self colorValueFromLispList: (JunAbstractObject new colorValueToLispList: (ColorValue pink))."

	| aClass aTable |
	aClass := Smalltalk at: aList head.
	aTable := self tableFromLispList: aList tail.
	^aClass 
		red: (aTable at: #red)
		green: (aTable at: #green)
		blue: (aTable at: #blue)
]

{ #category : #copyright }
JunAbstractObject class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #defaults }
JunAbstractObject class >> defaultBaseName [
	^JunSystem defaultBaseName
]

{ #category : #evaluating }
JunAbstractObject class >> do: aBlock during: millisecondTime [ 
	^JunControlUtility do: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractObject class >> do: doBlock ensure: ensureBlock [ 
	^JunControlUtility do: doBlock ensure: ensureBlock
]

{ #category : #evaluating }
JunAbstractObject class >> do: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility do: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractObject class >> do: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility do: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunAbstractObject class >> do: aBlock framesPerSecond: aNumber [ 
	^JunControlUtility do: aBlock framesPerSecond: aNumber
]

{ #category : #evaluating }
JunAbstractObject class >> fork: aBlock during: millisecondTime [ 
	^JunControlUtility fork: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractObject class >> fork: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility fork: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractObject class >> fork: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility fork: aBlock forMilliseconds: millisecondTime
]

{ #category : #'lisp support' }
JunAbstractObject class >> fromLispList: aList [ 
	| anObject |
	anObject := (Smalltalk at: aList head) new.
	anObject class fromLispList: aList for: anObject.
	^anObject
]

{ #category : #'lisp support' }
JunAbstractObject class >> fromLispList: aList for: anObject [ 
	| aTable |
	aTable := self tableFromLispList: aList tail.
	anObject class fromTable: aTable for: anObject.
	^anObject
]

{ #category : #'instance creation' }
JunAbstractObject class >> fromString: aString [ 
	^self fromLispList: (self defaultLispParserClass parse: aString)
]

{ #category : #'lisp support' }
JunAbstractObject class >> fromTable: aTable for: anObject [ 
	| vars index var value nth |
	vars := anObject class allInstVarNames.
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
					anObject instVarAt: index put: value]
				ifFalse: 
					[Transcript
						cr;
						show: 'Not found instance variable ' , var printString , ' in ' 
									, anObject class printString]].
	^anObject
]

{ #category : #'lisp support' }
JunAbstractObject class >> lispCons [
	^self defaultLispConsClass cell
]

{ #category : #'lisp support' }
JunAbstractObject class >> lispNil [
	^self defaultLispNilClass null
]

{ #category : #'lisp support' }
JunAbstractObject class >> lispTextStyle [
	"JunAbstractObject lispTextStyle."

	| lispTextStyle spaceWidth tabStop |
	lispTextStyle := TextAttributes styleNamed: #fixed ifAbsent: [nil].
	lispTextStyle ifNil: 
			[| fontDescription characterAttributes textAttributes deviceFont |
			fontDescription := FontDescription new.
			fontDescription family: #('*Courier*' '*courier*').
			fontDescription pixelSize: 12.
			fontDescription boldness: 0.5.
			fontDescription italic: false.
			fontDescription outline: false.
			fontDescription shadow: false.
			fontDescription underline: false.
			fontDescription fixedWidth: false.
			fontDescription serif: false.
			fontDescription strikeout: false.
			fontDescription encodings: Locale current preferredEncodings.
			characterAttributes := CharacterAttributes newWithDefaultAttributes.
			characterAttributes setDefaultQuery: fontDescription.
			textAttributes := TextAttributes new.
			textAttributes setCharacterAttributes: characterAttributes.
			self errorSignal handle: [:exception | ]
				do: 
					[deviceFont := Screen default defaultFontPolicy findFont: fontDescription.
					textAttributes lineGrid: deviceFont height.
					textAttributes baseline: deviceFont ascent].
			lispTextStyle := textAttributes]
		ifNotNil: [:it | lispTextStyle := it copy].
	spaceWidth := (ComposedText withText: ' ' asText style: lispTextStyle) 
				bounds width.
	tabStop := 8.
	lispTextStyle 
		useTabs: (spaceWidth * tabStop to: 1000 by: spaceWidth * tabStop).
	^lispTextStyle
]

{ #category : #'instance creation' }
JunAbstractObject class >> new [
	^(super new)
		initialize;
		yourself
]

{ #category : #evaluating }
JunAbstractObject class >> punctuallyDo: aBlock during: millisecondTime [ 
	^JunControlUtility punctuallyDo: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractObject class >> punctuallyDo: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility punctuallyDo: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractObject class >> punctuallyDo: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility punctuallyDo: aBlock forMilliseconds: millisecondTime
]

{ #category : #'lisp support' }
JunAbstractObject class >> showLispList: aList [ 
	"JunAbstractObject showLispList: JunOpenGL3dObject axes toLispList."
	"JunAbstractObject showLispList: JunNurbsCurve exampleCircle toLispList."

	| aStream aModel aLabel aView aWindow aKeyboardProcessor |
	self 
		assert: [aStream := WriteStream on: (String new: 1024)]
		do: 
			[aList saveOn: aStream.
			aModel := aStream contents asValue.
			aLabel := (#jun_Lisp_List__S_expression_ >> 'Lisp List (S expression)') 
						asString]
		ensure: [aStream close].
	aView := TextEditorView new.
	aView model: aModel.
	aView textStyle: self lispTextStyle.
	aWindow := ScheduledWindow new.
	aWindow label: aLabel.
	aKeyboardProcessor := KeyboardProcessor new.
	aKeyboardProcessor addKeyboardReceiver: aView.
	aWindow controller dispatcher keyboardProcessor: aKeyboardProcessor.
	aWindow background: ColorValue white.
	aWindow component: (LookPreferences edgeDecorator on: aView).
	aWindow openWithExtent: 400 @ 300.
	^aList
]

{ #category : #copyright }
JunAbstractObject class >> system [
	^'Jun'
]

{ #category : #'lisp support' }
JunAbstractObject class >> tableFromLispList: aList [ 
	"JunAbstractObject tableFromLispList: (JunLispParser parse: '((a . 1) (b . 2) (c . 3))')."

	| aTable |
	aTable := JunAttributeTable new.
	aList do: 
			[:pair | 
			(pair isKindOf: self defaultLispConsClass) 
				ifTrue: [aTable at: pair head put: pair tail]].
	^aTable
]

{ #category : #copyright }
JunAbstractObject class >> version [
	^'799'
]

{ #category : #converting }
JunAbstractObject >> asString [
	^self toLispList saveString
]

{ #category : #evaluating }
JunAbstractObject >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	^self class 
		assert: assertBlock
		do: doBlock
		ensure: ensureBlock
]

{ #category : #'lisp support' }
JunAbstractObject >> colorValueToLispList: colorValue [ 
	"self showLispList: (JunAbstractObject new colorValueToLispList: (ColorValue pink))."

	| list species |
	list := self lispCons.
	list head: colorValue class name.
	species := self class defaultLispConsClass.
	list add: (species head: #red tail: colorValue red asFloat).
	list add: (species head: #green tail: colorValue green asFloat).
	list add: (species head: #blue tail: colorValue blue asFloat).
	^list
]

{ #category : #defaults }
JunAbstractObject >> defaultBaseName [
	^self class defaultBaseName
]

{ #category : #evaluating }
JunAbstractObject >> do: aBlock during: millisecondTime [ 
	^self class do: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractObject >> do: doBlock ensure: ensureBlock [ 
	^self class do: doBlock ensure: ensureBlock
]

{ #category : #evaluating }
JunAbstractObject >> do: aBlock forMicroseconds: microsecondTime [ 
	^self class do: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractObject >> do: aBlock forMilliseconds: millisecondTime [ 
	^self class do: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunAbstractObject >> do: aBlock framesPerSecond: aNumber [ 
	^self class do: aBlock framesPerSecond: aNumber
]

{ #category : #evaluating }
JunAbstractObject >> fork: aBlock during: millisecondTime [ 
	^self class fork: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractObject >> fork: aBlock forMicroseconds: microsecondTime [ 
	^self class fork: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractObject >> fork: aBlock forMilliseconds: millisecondTime [ 
	^self class fork: aBlock forMilliseconds: millisecondTime
]

{ #category : #'initialize-release' }
JunAbstractObject >> initialize [
	^self yourself
]

{ #category : #'lisp support' }
JunAbstractObject >> kindName [
	^self class name
]

{ #category : #'lisp support' }
JunAbstractObject >> lispCons [
	^self class lispCons
]

{ #category : #'lisp support' }
JunAbstractObject >> lispNil [
	^self class lispNil
]

{ #category : #evaluating }
JunAbstractObject >> punctuallyDo: aBlock during: millisecondTime [ 
	^self class punctuallyDo: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractObject >> punctuallyDo: aBlock forMicroseconds: microsecondTime [ 
	^self class punctuallyDo: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractObject >> punctuallyDo: aBlock forMilliseconds: millisecondTime [ 
	^self class punctuallyDo: aBlock forMilliseconds: millisecondTime
]

{ #category : #'lisp support' }
JunAbstractObject >> showLispList [
	^self showLispList: self toLispList
]

{ #category : #'lisp support' }
JunAbstractObject >> showLispList: aList [ 
	^self class showLispList: aList
]

{ #category : #'lisp support' }
JunAbstractObject >> toLispList [
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
JunAbstractObject >> toLispListInstanceVariables [
	^self class allInstVarNames asArray
]

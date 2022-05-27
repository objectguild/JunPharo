"
Imported by VwImportClass
"
Class {
	#name : #JunLispSmallCompiler,
	#superclass : #JunAbstractObject,
	#instVars : [
		'source',
		'mark',
		'prevEnd',
		'hereChar',
		'token',
		'tokenType',
		'saveComments',
		'currentComment',
		'buffer',
		'typeTable',
		'parseNode'
	],
	#category : #'Jun-Goodies-Lisp'
}

{ #category : #copyright }
JunLispSmallCompiler class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #evaluating }
JunLispSmallCompiler class >> evaluate: textOrString [ 
	^self
		evaluate: textOrString
		for: nil
		logged: false
]

{ #category : #evaluating }
JunLispSmallCompiler class >> evaluate: textOrString for: anObject logged: logFlag [ 
	^self
		evaluate: textOrString
		for: anObject
		notifying: nil
		logged: logFlag
]

{ #category : #evaluating }
JunLispSmallCompiler class >> evaluate: textOrString for: anObject notifying: aController logged: logFlag [ 
	^self new
		evaluate: textOrString
		in: nil
		receiver: anObject
		notifying: aController
		ifFail: [^nil]
]

{ #category : #evaluating }
JunLispSmallCompiler class >> evaluate: textOrString logged: logFlag [ 
	^self
		evaluate: textOrString
		for: nil
		logged: logFlag
]

{ #category : #evaluating }
JunLispSmallCompiler class >> evaluate: textOrString notifying: aController logged: logFlag [ 
	^self
		evaluate: textOrString
		for: nil
		notifying: aController
		logged: logFlag
]

{ #category : #examples }
JunLispSmallCompiler class >> example0 [
	"JunLispSmallCompiler example0."

	| stream |
	stream := WriteStream on: Array new.
	stream nextPut: (JunLispSmallCompiler evaluate: '(nil)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(true)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(false)').
	stream contents do: [:each | Transcript cr; show: each printString].
	^stream contents
]

{ #category : #examples }
JunLispSmallCompiler class >> example1 [
	"JunLispSmallCompiler example1."

	| stream |
	stream := WriteStream on: Array new.
	stream nextPut: (JunLispSmallCompiler evaluate: '(123)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(123.456)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(123.456d7)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(-123)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(-123.456)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(-123.456d7)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(-123.456d-7)').
	stream contents do: [:each | Transcript cr; show: each printString].
	^stream contents
]

{ #category : #examples }
JunLispSmallCompiler class >> example2 [
	"JunLispSmallCompiler example2."

	| stream |
	stream := WriteStream on: Array new.
	stream nextPut: (JunLispSmallCompiler evaluate: '($c)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(''string'')').
	stream nextPut: (JunLispSmallCompiler evaluate: '(#symbol)').
	stream contents do: [:each | Transcript cr; show: each printString].
	^stream contents
]

{ #category : #examples }
JunLispSmallCompiler class >> example3 [
	"JunLispSmallCompiler example3."

	| stream |
	stream := WriteStream on: Array new.
	stream nextPut: (JunLispSmallCompiler evaluate: '(123 @ 456)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(123 , 456)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(123 , 456 , 789)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(Point x: 123 y: 456)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(Jun2dPoint x: 123 y: 456)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(Jun3dPoint x: 123 y: 456 z: 789)').
	stream contents do: [:each | Transcript cr; show: each printString].
	^stream contents
]

{ #category : #examples }
JunLispSmallCompiler class >> example4 [
	"JunLispSmallCompiler example4."

	| stream |
	stream := WriteStream on: Array new.
	stream nextPut: (JunLispSmallCompiler evaluate: '(ColorValue hue: 0.57 saturation: 0.46 brightness: 1.0)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(ColorValue red: 0.57 green: 0.46 blue: 1.0)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(ColorValue cyan: 0.57 magenta: 0.46 yellow: 1.0)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(ColorValue brightness: 0.7)').
	stream nextPut: (JunLispSmallCompiler evaluate: '(ColorValue scaledRed: 546 scaledGreen: 546 scaledBlue: 546)').
	stream contents do: [:each | Transcript cr; show: each printString].
	^stream contents
]

{ #category : #examples }
JunLispSmallCompiler class >> example5 [
	"JunLispSmallCompiler example5."
	"JunDisplayModel show: JunLispSmallCompiler example5."

	^JunLispSmallCompiler evaluate: '(Image extent: 6@7 depth: 24 bitsPerPixel: 24 palette: (FixedPalette redShift: 3 redMask: 31 greenShift: 11 greenMask: 31 blueShift: 19 blueMask: 31) usingBits: #[127 0 0 127 0 0 127 0 0 127 0 0 127 0 0 255 255 255 0 0 255 255 255 255 255 255 127 0 0 127 0 0 127 0 0 255 255 255 0 0 127 0 0 127 0 0 255 255 255 127 0 0 127 0 0 255 255 255 0 0 127 0 0 127 0 0 255 255 255 127 0 0 127 0 0 255 255 255 0 0 127 0 0 127 0 0 255 255 255 127 0 0 127 0 0 255 255 255 0 0 127 0 0 127 0 0 255 255 255 127 0 0 127 0 0 127 0 0 0 0 127 0 0 127 0 0 127 0 0 127 0 0 127 0 0 127 0 0 0 0])'
]

{ #category : #examples }
JunLispSmallCompiler class >> example6 [
	"JunLispSmallCompiler example6."
	"JunDisplayModel show: JunLispSmallCompiler example6."

	^JunLispSmallCompiler evaluate: '(Image extent: 14@15 depth: 24 bitsPerPixel: 24 palette: (FixedPalette redShift: 3 redMask: 31 greenShift: 11 greenMask: 31 blueShift: 19 blueMask: 31) usingBits: (ByteArray fromPackedString: ''????????????????????????????@@@@????????????@@@@????????@@@@@@C???????????<@@@C???<@@@@@@@@@@@C???<@@@@@@@@@@@C???<@@O???0@@@O???????0@@@O???????0@@@O???????????0@@@O???????0@@????@@@@????????@@@@????????@@@@????????????@@@@????????@@C???<@@@C???????<@@@C???????<@@@C???????????<@@@C???????<@@O???0@@@O???????0@@@O???????0@@@O???????????????0@@@O???0@@????????????????????????????????????????????????????????@@C???????????????????????????????????????????????????????<@@O???????????????????????????????????????????????????????0@@????????????????????????????????????????????????????????@@@@@@@@@@@@@@C???????<@@@@@@@@@@@@@@@@@@@C???<@@@@@@@@@@@@@@O???????????0@@@O???0@@@O???????????????????0@@@O???????0@@????????????@@@@????@@@@@@@@@@@@@@@@????????@@@@@@@@@@@@@@C???????????<@@@C???<@@@C???????????<@@@C???<@@@C???????<@@O???0@@@@@@@O???????????????????????0@@@O???????????????0@@''))'
]

{ #category : #examples }
JunLispSmallCompiler class >> example7 [
	"JunLispSmallCompiler example7."
	"JunDisplayModel show: JunLispSmallCompiler example7."

	^JunLispSmallCompiler evaluate: '(OpaqueImage basicNew instVarAt: 1 put: (CachedImage on: ((Image extent: 16@16 depth: 1 bitsPerPixel: 1 palette: MonoMappedPalette whiteBlack usingBits: #[0 0 0 0 64 16 0 0 96 16 0 0 112 56 0 0 121 255 0 0 124 198 0 0 126 68 0 0 127 124 0 0 124 108 0 0 124 198 0 0 76 130 0 0 6 0 0 0 6 0 0 0 3 0 0 0 3 0 0 0 0 0 0 0]))); instVarAt: 2 put: (CachedImage on: ((Image extent: 16@16 depth: 1 bitsPerPixel: 1 palette: CoveragePalette monoMaskPalette usingBits: #[192 16 0 0 224 56 0 0 240 56 0 0 249 255 0 0 255 255 0 0 255 255 0 0 255 254 0 0 255 254 0 0 254 254 0 0 255 239 0 0 255 199 0 0 143 199 0 0 15 0 0 0 7 128 0 0 7 128 0 0 3 0 0 0]))); yourself)'
]

{ #category : #examples }
JunLispSmallCompiler class >> example8 [
	"JunLispSmallCompiler example8."
	"JunDisplayModel show: JunLispSmallCompiler example8."

	^JunLispSmallCompiler evaluate: '(Image extent: 256@64 depth: 8 bitsPerPixel: 8 palette: (MappedPalette withColors: ((Array new: 256) at: 1 put: ColorValue black; at: 2 put: (ColorValue scaledRed: 546 scaledGreen: 546 scaledBlue: 546); at: 3 put: (ColorValue scaledRed: 1092 scaledGreen: 1092 scaledBlue: 1092); at: 4 put: (ColorValue scaledRed: 2184 scaledGreen: 2184 scaledBlue: 2184); at: 5 put: (ColorValue scaledRed: 2730 scaledGreen: 2730 scaledBlue: 2730); at: 6 put: (ColorValue scaledRed: 3822 scaledGreen: 3822 scaledBlue: 3822); at: 7 put: (ColorValue scaledRed: 4369 scaledGreen: 4369 scaledBlue: 4369); at: 8 put: ColorValue lightGray; at: 9 put: (ColorValue scaledRed: 6007 scaledGreen: 6007 scaledBlue: 6007); at: 10 put: (ColorValue scaledRed: 7099 scaledGreen: 7099 scaledBlue: 7099); at: 11 put: (ColorValue scaledRed: 7645 scaledGreen: 7645 scaledBlue: 7645); at: 12 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 546); at: 13 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 1092); at: 14 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 2184); at: 15 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 2730); at: 16 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 3822); at: 17 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 4369); at: 18 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 5461); at: 19 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 6007); at: 20 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 7099); at: 21 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 7645); at: 22 put: (ColorValue scaledRed: 0 scaledGreen: 546 scaledBlue: 0); at: 23 put: (ColorValue scaledRed: 0 scaledGreen: 1092 scaledBlue: 0); at: 24 put: (ColorValue scaledRed: 0 scaledGreen: 2184 scaledBlue: 0); at: 25 put: (ColorValue scaledRed: 0 scaledGreen: 2730 scaledBlue: 0); at: 26 put: (ColorValue scaledRed: 0 scaledGreen: 3822 scaledBlue: 0); at: 27 put: (ColorValue scaledRed: 0 scaledGreen: 4369 scaledBlue: 0); at: 28 put: (ColorValue scaledRed: 0 scaledGreen: 5461 scaledBlue: 0); at: 29 put: (ColorValue scaledRed: 0 scaledGreen: 6007 scaledBlue: 0); at: 30 put: (ColorValue scaledRed: 0 scaledGreen: 7099 scaledBlue: 0); at: 31 put: (ColorValue scaledRed: 0 scaledGreen: 7645 scaledBlue: 0); at: 32 put: (ColorValue scaledRed: 546 scaledGreen: 0 scaledBlue: 0); at: 33 put: (ColorValue scaledRed: 1092 scaledGreen: 0 scaledBlue: 0); at: 34 put: (ColorValue scaledRed: 2184 scaledGreen: 0 scaledBlue: 0); at: 35 put: (ColorValue scaledRed: 2730 scaledGreen: 0 scaledBlue: 0); at: 36 put: (ColorValue scaledRed: 3822 scaledGreen: 0 scaledBlue: 0); at: 37 put: (ColorValue scaledRed: 4369 scaledGreen: 0 scaledBlue: 0); at: 38 put: (ColorValue scaledRed: 5461 scaledGreen: 0 scaledBlue: 0); at: 39 put: (ColorValue scaledRed: 6007 scaledGreen: 0 scaledBlue: 0); at: 40 put: (ColorValue scaledRed: 7099 scaledGreen: 0 scaledBlue: 0); at: 41 put: (ColorValue scaledRed: 7645 scaledGreen: 0 scaledBlue: 0); at: 42 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 1638); at: 43 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 3276); at: 44 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 4915); at: 45 put: (ColorValue scaledRed: 0 scaledGreen: 0 scaledBlue: 6553); at: 46 put: ColorValue blue; at: 47 put: (ColorValue scaledRed: 0 scaledGreen: 1638 scaledBlue: 0); at: 48 put: (ColorValue scaledRed: 0 scaledGreen: 1638 scaledBlue: 1638); at: 49 put: (ColorValue scaledRed: 0 scaledGreen: 1638 scaledBlue: 3276); at: 50 put: (ColorValue scaledRed: 0 scaledGreen: 1638 scaledBlue: 4915); at: 51 put: (ColorValue scaledRed: 0 scaledGreen: 1638 scaledBlue: 6553); at: 52 put: (ColorValue scaledRed: 0 scaledGreen: 1638 scaledBlue: 8191); at: 53 put: (ColorValue scaledRed: 0 scaledGreen: 3276 scaledBlue: 0); at: 54 put: (ColorValue scaledRed: 0 scaledGreen: 3276 scaledBlue: 1638); at: 55 put: (ColorValue scaledRed: 0 scaledGreen: 3276 scaledBlue: 3276); at: 56 put: (ColorValue scaledRed: 0 scaledGreen: 3276 scaledBlue: 4915); at: 57 put: (ColorValue scaledRed: 0 scaledGreen: 3276 scaledBlue: 6553); at: 58 put: (ColorValue scaledRed: 0 scaledGreen: 3276 scaledBlue: 8191); at: 59 put: (ColorValue scaledRed: 0 scaledGreen: 4915 scaledBlue: 0); at: 60 put: (ColorValue scaledRed: 0 scaledGreen: 4915 scaledBlue: 1638); at: 61 put: (ColorValue scaledRed: 0 scaledGreen: 4915 scaledBlue: 3276); at: 62 put: (ColorValue scaledRed: 0 scaledGreen: 4915 scaledBlue: 4915); at: 63 put: (ColorValue scaledRed: 0 scaledGreen: 4915 scaledBlue: 6553); at: 64 put: (ColorValue scaledRed: 0 scaledGreen: 4915 scaledBlue: 8191); at: 65 put: (ColorValue scaledRed: 0 scaledGreen: 6553 scaledBlue: 0); at: 66 put: (ColorValue scaledRed: 0 scaledGreen: 6553 scaledBlue: 1638); at: 67 put: (ColorValue scaledRed: 0 scaledGreen: 6553 scaledBlue: 3276); at: 68 put: (ColorValue scaledRed: 0 scaledGreen: 6553 scaledBlue: 4915); at: 69 put: (ColorValue scaledRed: 0 scaledGreen: 6553 scaledBlue: 6553); at: 70 put: (ColorValue scaledRed: 0 scaledGreen: 6553 scaledBlue: 8191); at: 71 put: ColorValue green; at: 72 put: (ColorValue scaledRed: 0 scaledGreen: 8191 scaledBlue: 1638); at: 73 put: (ColorValue scaledRed: 0 scaledGreen: 8191 scaledBlue: 3276); at: 74 put: (ColorValue scaledRed: 0 scaledGreen: 8191 scaledBlue: 4915); at: 75 put: (ColorValue scaledRed: 0 scaledGreen: 8191 scaledBlue: 6553); at: 76 put: ColorValue cyan; at: 77 put: (ColorValue scaledRed: 1638 scaledGreen: 0 scaledBlue: 0); at: 78 put: (ColorValue scaledRed: 1638 scaledGreen: 0 scaledBlue: 1638); at: 79 put: (ColorValue scaledRed: 1638 scaledGreen: 0 scaledBlue: 3276); at: 80 put: (ColorValue scaledRed: 1638 scaledGreen: 0 scaledBlue: 4915); at: 81 put: (ColorValue scaledRed: 1638 scaledGreen: 0 scaledBlue: 6553); at: 82 put: (ColorValue scaledRed: 1638 scaledGreen: 0 scaledBlue: 8191); at: 83 put: (ColorValue scaledRed: 1638 scaledGreen: 1638 scaledBlue: 0); at: 84 put: (ColorValue scaledRed: 1638 scaledGreen: 1638 scaledBlue: 1638); at: 85 put: (ColorValue scaledRed: 1638 scaledGreen: 1638 scaledBlue: 3276); at: 86 put: (ColorValue scaledRed: 1638 scaledGreen: 1638 scaledBlue: 4915); at: 87 put: (ColorValue scaledRed: 1638 scaledGreen: 1638 scaledBlue: 6553); at: 88 put: (ColorValue scaledRed: 1638 scaledGreen: 1638 scaledBlue: 8191); at: 89 put: (ColorValue scaledRed: 1638 scaledGreen: 3276 scaledBlue: 0); at: 90 put: (ColorValue scaledRed: 1638 scaledGreen: 3276 scaledBlue: 1638); at: 91 put: (ColorValue scaledRed: 1638 scaledGreen: 3276 scaledBlue: 3276); at: 92 put: (ColorValue scaledRed: 1638 scaledGreen: 3276 scaledBlue: 4915); at: 93 put: (ColorValue scaledRed: 1638 scaledGreen: 3276 scaledBlue: 6553); at: 94 put: (ColorValue scaledRed: 1638 scaledGreen: 3276 scaledBlue: 8191); at: 95 put: (ColorValue scaledRed: 1638 scaledGreen: 4915 scaledBlue: 0); at: 96 put: (ColorValue scaledRed: 1638 scaledGreen: 4915 scaledBlue: 1638); at: 97 put: (ColorValue scaledRed: 1638 scaledGreen: 4915 scaledBlue: 3276); at: 98 put: (ColorValue scaledRed: 1638 scaledGreen: 4915 scaledBlue: 4915); at: 99 put: (ColorValue scaledRed: 1638 scaledGreen: 4915 scaledBlue: 6553); at: 100 put: (ColorValue scaledRed: 1638 scaledGreen: 4915 scaledBlue: 8191); at: 101 put: (ColorValue scaledRed: 1638 scaledGreen: 6553 scaledBlue: 0); at: 102 put: (ColorValue scaledRed: 1638 scaledGreen: 6553 scaledBlue: 1638); at: 103 put: (ColorValue scaledRed: 1638 scaledGreen: 6553 scaledBlue: 3276); at: 104 put: (ColorValue scaledRed: 1638 scaledGreen: 6553 scaledBlue: 4915); at: 105 put: (ColorValue scaledRed: 1638 scaledGreen: 6553 scaledBlue: 6553); at: 106 put: (ColorValue scaledRed: 1638 scaledGreen: 6553 scaledBlue: 8191); at: 107 put: (ColorValue scaledRed: 1638 scaledGreen: 8191 scaledBlue: 0); at: 108 put: (ColorValue scaledRed: 1638 scaledGreen: 8191 scaledBlue: 1638); at: 109 put: (ColorValue scaledRed: 1638 scaledGreen: 8191 scaledBlue: 3276); at: 110 put: (ColorValue scaledRed: 1638 scaledGreen: 8191 scaledBlue: 4915); at: 111 put: (ColorValue scaledRed: 1638 scaledGreen: 8191 scaledBlue: 6553); at: 112 put: (ColorValue scaledRed: 1638 scaledGreen: 8191 scaledBlue: 8191); at: 113 put: (ColorValue scaledRed: 3276 scaledGreen: 0 scaledBlue: 0); at: 114 put: (ColorValue scaledRed: 3276 scaledGreen: 0 scaledBlue: 1638); at: 115 put: (ColorValue scaledRed: 3276 scaledGreen: 0 scaledBlue: 3276); at: 116 put: (ColorValue scaledRed: 3276 scaledGreen: 0 scaledBlue: 4915); at: 117 put: (ColorValue scaledRed: 3276 scaledGreen: 0 scaledBlue: 6553); at: 118 put: (ColorValue scaledRed: 3276 scaledGreen: 0 scaledBlue: 8191); at: 119 put: (ColorValue scaledRed: 3276 scaledGreen: 1638 scaledBlue: 0); at: 120 put: (ColorValue scaledRed: 3276 scaledGreen: 1638 scaledBlue: 1638); at: 121 put: (ColorValue scaledRed: 3276 scaledGreen: 1638 scaledBlue: 3276); at: 122 put: (ColorValue scaledRed: 3276 scaledGreen: 1638 scaledBlue: 4915); at: 123 put: (ColorValue scaledRed: 3276 scaledGreen: 1638 scaledBlue: 6553); at: 124 put: (ColorValue scaledRed: 3276 scaledGreen: 1638 scaledBlue: 8191); at: 125 put: (ColorValue scaledRed: 3276 scaledGreen: 3276 scaledBlue: 0); at: 126 put: (ColorValue scaledRed: 3276 scaledGreen: 3276 scaledBlue: 1638); at: 127 put: (ColorValue scaledRed: 3276 scaledGreen: 3276 scaledBlue: 3276); at: 128 put: (ColorValue scaledRed: 3276 scaledGreen: 3276 scaledBlue: 4915); at: 129 put: (ColorValue scaledRed: 3276 scaledGreen: 3276 scaledBlue: 6553); at: 130 put: (ColorValue scaledRed: 3276 scaledGreen: 3276 scaledBlue: 8191); at: 131 put: (ColorValue scaledRed: 3276 scaledGreen: 4915 scaledBlue: 0); at: 132 put: (ColorValue scaledRed: 3276 scaledGreen: 4915 scaledBlue: 1638); at: 133 put: (ColorValue scaledRed: 3276 scaledGreen: 4915 scaledBlue: 3276); at: 134 put: (ColorValue scaledRed: 3276 scaledGreen: 4915 scaledBlue: 4915); at: 135 put: (ColorValue scaledRed: 3276 scaledGreen: 4915 scaledBlue: 6553); at: 136 put: (ColorValue scaledRed: 3276 scaledGreen: 4915 scaledBlue: 8191); at: 137 put: (ColorValue scaledRed: 3276 scaledGreen: 6553 scaledBlue: 0); at: 138 put: (ColorValue scaledRed: 3276 scaledGreen: 6553 scaledBlue: 1638); at: 139 put: (ColorValue scaledRed: 3276 scaledGreen: 6553 scaledBlue: 3276); at: 140 put: (ColorValue scaledRed: 3276 scaledGreen: 6553 scaledBlue: 4915); at: 141 put: (ColorValue scaledRed: 3276 scaledGreen: 6553 scaledBlue: 6553); at: 142 put: (ColorValue scaledRed: 3276 scaledGreen: 6553 scaledBlue: 8191); at: 143 put: (ColorValue scaledRed: 3276 scaledGreen: 8191 scaledBlue: 0); at: 144 put: (ColorValue scaledRed: 3276 scaledGreen: 8191 scaledBlue: 1638); at: 145 put: (ColorValue scaledRed: 3276 scaledGreen: 8191 scaledBlue: 3276); at: 146 put: (ColorValue scaledRed: 3276 scaledGreen: 8191 scaledBlue: 4915); at: 147 put: (ColorValue scaledRed: 3276 scaledGreen: 8191 scaledBlue: 6553); at: 148 put: (ColorValue scaledRed: 3276 scaledGreen: 8191 scaledBlue: 8191); at: 149 put: (ColorValue scaledRed: 4915 scaledGreen: 0 scaledBlue: 0); at: 150 put: (ColorValue scaledRed: 4915 scaledGreen: 0 scaledBlue: 1638); at: 151 put: (ColorValue scaledRed: 4915 scaledGreen: 0 scaledBlue: 3276); at: 152 put: (ColorValue scaledRed: 4915 scaledGreen: 0 scaledBlue: 4915); at: 153 put: (ColorValue scaledRed: 4915 scaledGreen: 0 scaledBlue: 6553); at: 154 put: (ColorValue scaledRed: 4915 scaledGreen: 0 scaledBlue: 8191); at: 155 put: (ColorValue scaledRed: 4915 scaledGreen: 1638 scaledBlue: 0); at: 156 put: (ColorValue scaledRed: 4915 scaledGreen: 1638 scaledBlue: 1638); at: 157 put: (ColorValue scaledRed: 4915 scaledGreen: 1638 scaledBlue: 3276); at: 158 put: (ColorValue scaledRed: 4915 scaledGreen: 1638 scaledBlue: 4915); at: 159 put: (ColorValue scaledRed: 4915 scaledGreen: 1638 scaledBlue: 6553); at: 160 put: (ColorValue scaledRed: 4915 scaledGreen: 1638 scaledBlue: 8191); at: 161 put: (ColorValue scaledRed: 4915 scaledGreen: 3276 scaledBlue: 0); at: 162 put: (ColorValue scaledRed: 4915 scaledGreen: 3276 scaledBlue: 1638); at: 163 put: (ColorValue scaledRed: 4915 scaledGreen: 3276 scaledBlue: 3276); at: 164 put: (ColorValue scaledRed: 4915 scaledGreen: 3276 scaledBlue: 4915); at: 165 put: (ColorValue scaledRed: 4915 scaledGreen: 3276 scaledBlue: 6553); at: 166 put: (ColorValue scaledRed: 4915 scaledGreen: 3276 scaledBlue: 8191); at: 167 put: (ColorValue scaledRed: 4915 scaledGreen: 4915 scaledBlue: 0); at: 168 put: (ColorValue scaledRed: 4915 scaledGreen: 4915 scaledBlue: 1638); at: 169 put: (ColorValue scaledRed: 4915 scaledGreen: 4915 scaledBlue: 3276); at: 170 put: (ColorValue scaledRed: 4915 scaledGreen: 4915 scaledBlue: 4915); at: 171 put: (ColorValue scaledRed: 4915 scaledGreen: 4915 scaledBlue: 6553); at: 172 put: (ColorValue scaledRed: 4915 scaledGreen: 4915 scaledBlue: 8191); at: 173 put: (ColorValue scaledRed: 4915 scaledGreen: 6553 scaledBlue: 0); at: 174 put: (ColorValue scaledRed: 4915 scaledGreen: 6553 scaledBlue: 1638); at: 175 put: (ColorValue scaledRed: 4915 scaledGreen: 6553 scaledBlue: 3276); at: 176 put: (ColorValue scaledRed: 4915 scaledGreen: 6553 scaledBlue: 4915); at: 177 put: (ColorValue scaledRed: 4915 scaledGreen: 6553 scaledBlue: 6553); at: 178 put: (ColorValue scaledRed: 4915 scaledGreen: 6553 scaledBlue: 8191); at: 179 put: (ColorValue scaledRed: 4915 scaledGreen: 8191 scaledBlue: 0); at: 180 put: (ColorValue scaledRed: 4915 scaledGreen: 8191 scaledBlue: 1638); at: 181 put: (ColorValue scaledRed: 4915 scaledGreen: 8191 scaledBlue: 3276); at: 182 put: (ColorValue scaledRed: 4915 scaledGreen: 8191 scaledBlue: 4915); at: 183 put: (ColorValue scaledRed: 4915 scaledGreen: 8191 scaledBlue: 6553); at: 184 put: (ColorValue scaledRed: 4915 scaledGreen: 8191 scaledBlue: 8191); at: 185 put: (ColorValue scaledRed: 6553 scaledGreen: 0 scaledBlue: 0); at: 186 put: (ColorValue scaledRed: 6553 scaledGreen: 0 scaledBlue: 1638); at: 187 put: (ColorValue scaledRed: 6553 scaledGreen: 0 scaledBlue: 3276); at: 188 put: (ColorValue scaledRed: 6553 scaledGreen: 0 scaledBlue: 4915); at: 189 put: (ColorValue scaledRed: 6553 scaledGreen: 0 scaledBlue: 6553); at: 190 put: (ColorValue scaledRed: 6553 scaledGreen: 0 scaledBlue: 8191); at: 191 put: (ColorValue scaledRed: 6553 scaledGreen: 1638 scaledBlue: 0); at: 192 put: (ColorValue scaledRed: 6553 scaledGreen: 1638 scaledBlue: 1638); at: 193 put: (ColorValue scaledRed: 6553 scaledGreen: 1638 scaledBlue: 3276); at: 194 put: (ColorValue scaledRed: 6553 scaledGreen: 1638 scaledBlue: 4915); at: 195 put: (ColorValue scaledRed: 6553 scaledGreen: 1638 scaledBlue: 6553); at: 196 put: (ColorValue scaledRed: 6553 scaledGreen: 1638 scaledBlue: 8191); at: 197 put: (ColorValue scaledRed: 6553 scaledGreen: 3276 scaledBlue: 0); at: 198 put: (ColorValue scaledRed: 6553 scaledGreen: 3276 scaledBlue: 1638); at: 199 put: (ColorValue scaledRed: 6553 scaledGreen: 3276 scaledBlue: 3276); at: 200 put: (ColorValue scaledRed: 6553 scaledGreen: 3276 scaledBlue: 4915); at: 201 put: (ColorValue scaledRed: 6553 scaledGreen: 3276 scaledBlue: 6553); at: 202 put: (ColorValue scaledRed: 6553 scaledGreen: 3276 scaledBlue: 8191); at: 203 put: (ColorValue scaledRed: 6553 scaledGreen: 4915 scaledBlue: 0); at: 204 put: (ColorValue scaledRed: 6553 scaledGreen: 4915 scaledBlue: 1638); at: 205 put: (ColorValue scaledRed: 6553 scaledGreen: 4915 scaledBlue: 3276); at: 206 put: (ColorValue scaledRed: 6553 scaledGreen: 4915 scaledBlue: 4915); at: 207 put: (ColorValue scaledRed: 6553 scaledGreen: 4915 scaledBlue: 6553); at: 208 put: (ColorValue scaledRed: 6553 scaledGreen: 4915 scaledBlue: 8191); at: 209 put: (ColorValue scaledRed: 6553 scaledGreen: 6553 scaledBlue: 0); at: 210 put: (ColorValue scaledRed: 6553 scaledGreen: 6553 scaledBlue: 1638); at: 211 put: (ColorValue scaledRed: 6553 scaledGreen: 6553 scaledBlue: 3276); at: 212 put: (ColorValue scaledRed: 6553 scaledGreen: 6553 scaledBlue: 4915); at: 213 put: (ColorValue scaledRed: 6553 scaledGreen: 6553 scaledBlue: 6553); at: 214 put: (ColorValue scaledRed: 6553 scaledGreen: 6553 scaledBlue: 8191); at: 215 put: (ColorValue scaledRed: 6553 scaledGreen: 8191 scaledBlue: 0); at: 216 put: (ColorValue scaledRed: 6553 scaledGreen: 8191 scaledBlue: 1638); at: 217 put: (ColorValue scaledRed: 6553 scaledGreen: 8191 scaledBlue: 3276); at: 218 put: (ColorValue scaledRed: 6553 scaledGreen: 8191 scaledBlue: 4915); at: 219 put: (ColorValue scaledRed: 6553 scaledGreen: 8191 scaledBlue: 6553); at: 220 put: (ColorValue scaledRed: 6553 scaledGreen: 8191 scaledBlue: 8191); at: 221 put: ColorValue red; at: 222 put: (ColorValue scaledRed: 8191 scaledGreen: 0 scaledBlue: 1638); at: 223 put: (ColorValue scaledRed: 8191 scaledGreen: 0 scaledBlue: 3276); at: 224 put: (ColorValue scaledRed: 8191 scaledGreen: 0 scaledBlue: 4915); at: 225 put: (ColorValue scaledRed: 8191 scaledGreen: 0 scaledBlue: 6553); at: 226 put: ColorValue magenta; at: 227 put: (ColorValue scaledRed: 8191 scaledGreen: 1638 scaledBlue: 0); at: 228 put: (ColorValue scaledRed: 8191 scaledGreen: 1638 scaledBlue: 1638); at: 229 put: (ColorValue scaledRed: 8191 scaledGreen: 1638 scaledBlue: 3276); at: 230 put: (ColorValue scaledRed: 8191 scaledGreen: 1638 scaledBlue: 4915); at: 231 put: (ColorValue scaledRed: 8191 scaledGreen: 1638 scaledBlue: 6553); at: 232 put: (ColorValue scaledRed: 8191 scaledGreen: 1638 scaledBlue: 8191); at: 233 put: (ColorValue scaledRed: 8191 scaledGreen: 3276 scaledBlue: 0); at: 234 put: (ColorValue scaledRed: 8191 scaledGreen: 3276 scaledBlue: 1638); at: 235 put: (ColorValue scaledRed: 8191 scaledGreen: 3276 scaledBlue: 3276); at: 236 put: (ColorValue scaledRed: 8191 scaledGreen: 3276 scaledBlue: 4915); at: 237 put: (ColorValue scaledRed: 8191 scaledGreen: 3276 scaledBlue: 6553); at: 238 put: (ColorValue scaledRed: 8191 scaledGreen: 3276 scaledBlue: 8191); at: 239 put: (ColorValue scaledRed: 8191 scaledGreen: 4915 scaledBlue: 0); at: 240 put: (ColorValue scaledRed: 8191 scaledGreen: 4915 scaledBlue: 1638); at: 241 put: (ColorValue scaledRed: 8191 scaledGreen: 4915 scaledBlue: 3276); at: 242 put: (ColorValue scaledRed: 8191 scaledGreen: 4915 scaledBlue: 4915); at: 243 put: (ColorValue scaledRed: 8191 scaledGreen: 4915 scaledBlue: 6553); at: 244 put: (ColorValue scaledRed: 8191 scaledGreen: 4915 scaledBlue: 8191); at: 245 put: (ColorValue scaledRed: 8191 scaledGreen: 6553 scaledBlue: 0); at: 246 put: (ColorValue scaledRed: 8191 scaledGreen: 6553 scaledBlue: 1638); at: 247 put: (ColorValue scaledRed: 8191 scaledGreen: 6553 scaledBlue: 3276); at: 248 put: (ColorValue scaledRed: 8191 scaledGreen: 6553 scaledBlue: 4915); at: 249 put: (ColorValue scaledRed: 8191 scaledGreen: 6553 scaledBlue: 6553); at: 250 put: (ColorValue scaledRed: 8191 scaledGreen: 6553 scaledBlue: 8191); at: 251 put: ColorValue yellow; at: 252 put: (ColorValue scaledRed: 8191 scaledGreen: 8191 scaledBlue: 1638); at: 253 put: (ColorValue scaledRed: 8191 scaledGreen: 8191 scaledBlue: 3276); at: 254 put: (ColorValue scaledRed: 8191 scaledGreen: 8191 scaledBlue: 4915); at: 255 put: (ColorValue scaledRed: 8191 scaledGreen: 8191 scaledBlue: 6553); at: 256 put: ColorValue white; yourself)) usingBits: (ByteArray fromPackedString: ''@@@@@@@@@@@A@PDA@PDA@PHB@ HB@ HB@0LC@0LC@0LDA@PDA@PDA@TEAPTEAPTEA XFA XFA XGA0\GA0\GA0 HB@ HB@ HBP$IBP$IBP$JB (JB (JB ,KB0,KB0,KC@0LC@0LC@0MCP4MCP4MCP8NC 8NC 8NC0<OC0<OC0<PDA@PDA@PDADQDQDQDQDQD!HRD!HRD!HSD1LSD1LSD1PTEAPTEAPTEQTUEQTUEQTVE!XVE!XVE!\WE1\WE1\WFA XFA XFA YFQ$YFQ$YFQ(ZF!(ZF!(ZF1,[F1,[F1,\GA0\GA0\GA4]GQ4]GQ4]G!8^G!8^G!8_G1<_G1<_G0@@@@@@@@@@@PDA@PDA@PDB@ HB@ HB@ LC@0LC@0LCA@PDA@PDA@PEAPTEAPTEAPXFA XFA XFA0\GA0\GA0\HB@ HB@ HB@$IBP$IBP$IB (JB (JB (KB0,KB0,KB00LC@0LC@0LCP4MCP4MCP4NC 8NC 8NC <OC0<OC0<ODA@PDA@PDA@QDQDQDQDQDQHRD!HRD!HRD1LSD1LSD1LTEAPTEAPTEATUEQTUEQTUE!XVE!XVE!XWE1\WE1\WE1 XFA XFA XFQ$YFQ$YFQ$ZF!(ZF!(ZF!,[F1,[F1,[GA0\GA0\GA0]GQ4]GQ4]GQ8^G!8^G!8^G1<_G1<_G1<@@@@@@@@@@@DA@PDA@PDA@ HB@ HB@ HC@0LC@0LC@0PDA@PDA@PDAPTEAPTEAPTFA XFA XFA \GA0\GA0\GB@ HB@ HB@ IBP$IBP$IBP(JB (JB (JB0,KB0,KB0,LC@0LC@0LC@4MCP4MCP4MC 8NC 8NC 8OC0<OC0<OC1@PDA@PDA@PDQDQDQDQDQDRD!HRD!HRD!LSD1LSD1LSEAPTEAPTEAPUEQTUEQTUEQXVE!XVE!XVE1\WE1\WE1\XFA XFA XFA$YFQ$YFQ$YF!(ZF!(ZF!([F1,[F1,[F10\GA0\GA0\GQ4]GQ4]GQ4^G!8^G!8^G!<_G1<_G1<_@@@@@@@@@@@A@PDA@PDA@PHB@ HB@ HB@0LC@0LC@0LDA@PDA@PDA@TEAPTEAPTEA XFA XFA XGA0\GA0\GA0 HB@ HB@ HBP$IBP$IBP$JB (JB (JB ,KB0,KB0,KC@0LC@0LC@0MCP4MCP4MCP8NC 8NC 8NC0<OC0<OC0<PDA@PDA@PDADQDQDQDQDQD!HRD!HRD!HSD1LSD1LSD1PTEAPTEAPTEQTUEQTUEQTVE!XVE!XVE!\WE1\WE1\WFA XFA XFA YFQ$YFQ$YFQ(ZF!(ZF!(ZF1,[F1,[F1,\GA0\GA0\GA4]GQ4]GQ4]G!8^G!8^G!8_G1<_G1<_G0@@@@@@@@@@@PDA@PDA@PDB@ HB@ HB@ LC@0LC@0LCA@PDA@PDA@PEAPTEAPTEAPXFA XFA XFA0\GA0\GA0\HB@ HB@ HB@$IBP$IBP$IB (JB (JB (KB0,KB0,KB00LC@0LC@0LCP4MCP4MCP4NC 8NC 8NC <OC0<OC0<ODA@PDA@PDA@QDQDQDQDQDQHRD!HRD!HRD1LSD1LSD1LTEAPTEAPTEATUEQTUEQTUE!XVE!XVE!XWE1\WE1\WE1 XFA XFA XFQ$YFQ$YFQ$ZF!(ZF!(ZF!,[F1,[F1,[GA0\GA0\GA0]GQ4]GQ4]GQ8^G!8^G!8^G1<_G1<_G1<@@@@@@@@@@@DA@PDA@PDA@ HB@ HB@ HC@0LC@0LC@0PDA@PDA@PDAPTEAPTEAPTFA XFA XFA \GA0\GA0\GB@ HB@ HB@ IBP$IBP$IBP(JB (JB (JB0,KB0,KB0,LC@0LC@0LC@4MCP4MCP4MC 8NC 8NC 8OC0<OC0<OC1@PDA@PDA@PDQDQDQDQDQDRD!HRD!HRD!LSD1LSD1LSEAPTEAPTEAPUEQTUEQTUEQXVE!XVE!XVE1\WE1\WE1\XFA XFA XFA$YFQ$YFQ$YF!(ZF!(ZF!([F1,[F1,[F10\GA0\GA0\GQ4]GQ4]GQ4^G!8^G!8^G!<_G1<_G1<_@@@@@@@@@@@A@PDA@PDA@PHB@ HB@ HB@0LC@0LC@0LDA@PDA@PDA@TEAPTEAPTEA XFA XFA XGA0\GA0\GA0 HB@ HB@ HBP$IBP$IBP$JB (JB (JB ,KB0,KB0,KC@0LC@0LC@0MCP4MCP4MCP8NC 8NC 8NC0<OC0<OC0<PDA@PDA@PDADQDQDQDQDQD!HRD!HRD!HSD1LSD1LSD1PTEAPTEAPTEQTUEQTUEQTVE!XVE!XVE!\WE1\WE1\WFA XFA XFA YFQ$YFQ$YFQ(ZF!(ZF!(ZF1,[F1,[F1,\GA0\GA0\GA4]GQ4]GQ4]G!8^G!8^G!8_G1<_G1<_G0@@@@@@@@@@@PDA@PDA@PDB@ HB@ HB@ LC@0LC@0LCA@PDA@PDA@PEAPTEAPTEAPXFA XFA XFA0\GA0\GA0\HB@ HB@ HB@$IBP$IBP$IB (JB (JB (KB0,KB0,KB00LC@0LC@0LCP4MCP4MCP4NC 8NC 8NC <OC0<OC0<ODA@PDA@PDA@QDQDQDQDQDQHRD!HRD!HRD1LSD1LSD1LTEAPTEAPTEATUEQTUEQTUE!XVE!XVE!XWE1\WE1\WE1 XFA XFA XFQ$YFQ$YFQ$ZF!(ZF!(ZF!,[F1,[F1,[GA0\GA0\GA0]GQ4]GQ4]GQ8^G!8^G!8^G1<_G1<_G1< HB@ HB@ HBD!HRD!HRD!H"H"H"H"H"H#H2L#H2L#H2P$IBP$IBP$IRT%IRT%IRT&I"X&I"X&I"\''''I2\''''I2\''''JB (JB (JB )JR$)JR$)JR(*J"(*J"(*J2,+J2,+J2,,KB0,KB0,KB4-KR4-KR4-K"8.K"8.K"8/K2</K2</K3@0LC@0LC@0LSD1LSD1LSD2L#H2L#H2L#L3L3L3L3L3MCP4MCP4MCP5MST5MST5MSX6M#X6M#X6M3\7M3\7M3\8NC 8NC 8NC$9NS$9NS$9N#(:N#(:N#(;N3,;N3,;N30<OC0<OC0<OS4=OS4=OS4>O#8>O#8>O#<?O3<?O3<?HB@ HB@ HB@!HRD!HRD!HRH"H"H"H"H"H2L#H2L#H2L$IBP$IBP$IBT%IRT%IRT%I"X&I"X&I"X''''I2\''''I2\''''I2 (JB (JB (JR$)JR$)JR$*J"(*J"(*J",+J2,+J2,+KB0,KB0,KB0-KR4-KR4-KR8.K"8.K"8.K2</K2</K2<0LC@0LC@0LCD1LSD1LSD1L#H2L#H2L#H3L3L3L3L3L3P4MCP4MCP4MST5MST5MST6M#X6M#X6M#\7M3\7M3\7NC 8NC 8NC 9NS$9NS$9NS(:N#(:N#(:N3,;N3,;N3,<OC0<OC0<OC4=OS4=OS4=O#8>O#8>O#8?O3<?O3<?O2@ HB@ HB@ HRD!HRD!HRD"H"H"H"H"H"L#H2L#H2L#IBP$IBP$IBP%IRT%IRT%IRX&I"X&I"X&I2\''''I2\''''I2\(JB (JB (JB$)JR$)JR$)J"(*J"(*J"(+J2,+J2,+J20,KB0,KB0,KR4-KR4-KR4.K"8.K"8.K"</K2</K2</LC@0LC@0LC@1LSD1LSD1LSH2L#H2L#H2L3L3L3L3L3L4MCP4MCP4MCT5MST5MST5M#X6M#X6M#X7M3\7M3\7M3 8NC 8NC 8NS$9NS$9NS$:N#(:N#(:N#,;N3,;N3,;OC0<OC0<OC0=OS4=OS4=OS8>O#8>O#8>O3<?O3<?O3< HB@ HB@ HBD!HRD!HRD!H"H"H"H"H"H#H2L#H2L#H2P$IBP$IBP$IRT%IRT%IRT&I"X&I"X&I"\''''I2\''''I2\''''JB (JB (JB )JR$)JR$)JR(*J"(*J"(*J2,+J2,+J2,,KB0,KB0,KB4-KR4-KR4-K"8.K"8.K"8/K2</K2</K3@0LC@0LC@0LSD1LSD1LSD2L#H2L#H2L#L3L3L3L3L3MCP4MCP4MCP5MST5MST5MSX6M#X6M#X6M3\7M3\7M3\8NC 8NC 8NC$9NS$9NS$9N#(:N#(:N#(;N3,;N3,;N30<OC0<OC0<OS4=OS4=OS4>O#8>O#8>O#<?O3<?O3<?HB@ HB@ HB@!HRD!HRD!HRH"H"H"H"H"H2L#H2L#H2L$IBP$IBP$IBT%IRT%IRT%I"X&I"X&I"X''''I2\''''I2\''''I2 (JB (JB (JR$)JR$)JR$*J"(*J"(*J",+J2,+J2,+KB0,KB0,KB0-KR4-KR4-KR8.K"8.K"8.K2</K2</K2<0LC@0LC@0LCD1LSD1LSD1L#H2L#H2L#H3L3L3L3L3L3P4MCP4MCP4MST5MST5MST6M#X6M#X6M#\7M3\7M3\7NC 8NC 8NC 9NS$9NS$9NS(:N#(:N#(:N3,;N3,;N3,<OC0<OC0<OC4=OS4=OS4=O#8>O#8>O#8?O3<?O3<?O2@ HB@ HB@ HRD!HRD!HRD"H"H"H"H"H"L#H2L#H2L#IBP$IBP$IBP%IRT%IRT%IRX&I"X&I"X&I2\''''I2\''''I2\(JB (JB (JB$)JR$)JR$)J"(*J"(*J"(+J2,+J2,+J20,KB0,KB0,KR4-KR4-KR4.K"8.K"8.K"</K2</K2</LC@0LC@0LC@1LSD1LSD1LSH2L#H2L#H2L3L3L3L3L3L4MCP4MCP4MCT5MST5MST5M#X6M#X6M#X7M3\7M3\7M3 8NC 8NC 8NS$9NS$9NS$:N#(:N#(:N#,;N3,;N3,;OC0<OC0<OC0=OS4=OS4=OS8>O#8>O#8>O3<?O3<?O3< HB@ HB@ HBD!HRD!HRD!H"H"H"H"H"H#H2L#H2L#H2P$IBP$IBP$IRT%IRT%IRT&I"X&I"X&I"\''''I2\''''I2\''''JB (JB (JB )JR$)JR$)JR(*J"(*J"(*J2,+J2,+J2,,KB0,KB0,KB4-KR4-KR4-K"8.K"8.K"8/K2</K2</K3@0LC@0LC@0LSD1LSD1LSD2L#H2L#H2L#L3L3L3L3L3MCP4MCP4MCP5MST5MST5MSX6M#X6M#X6M3\7M3\7M3\8NC 8NC 8NC$9NS$9NS$9N#(:N#(:N#(;N3,;N3,;N30<OC0<OC0<OS4=OS4=OS4>O#8>O#8>O#<?O3<?O3<?HB@ HB@ HB@!HRD!HRD!HRH"H"H"H"H"H2L#H2L#H2L$IBP$IBP$IBT%IRT%IRT%I"X&I"X&I"X''''I2\''''I2\''''I2 (JB (JB (JR$)JR$)JR$*J"(*J"(*J",+J2,+J2,+KB0,KB0,KB0-KR4-KR4-KR8.K"8.K"8.K2</K2</K2<0LC@0LC@0LCD1LSD1LSD1L#H2L#H2L#H3L3L3L3L3L3P4MCP4MCP4MST5MST5MST6M#X6M#X6M#\7M3\7M3\7NC 8NC 8NC 9NS$9NS$9NS(:N#(:N#(:N3,;N3,;N3,<OC0<OC0<OC4=OS4=OS4=O#8>O#8>O#8?O3<?O3<?O4A@PDA@PDA@PTEAPTEAPTEBP$IBP$IBP$MCP4MCP4MCQDQDQDQDQDQEQTUEQTUEQTYFQ$YFQ$YFQ4]GQ4]GQ4]HRD!HRD!HRD%IRT%IRT%IR$)JR$)JR$)KR4-KR4-KR41LSD1LSD1LST5MST5MST5NS$9NS$9NS$=OS4=OS4=OTEAPTEAPTEAQTUEQTUEQTUIRT%IRT%IRT5MST5MST5MTUEQTUEQTUEUUUUUUUUUUU%YVU%YVU%YWU5]WU5]WU5!XVE!XVE!XVU%YVU%YVU%ZV%)ZV%)ZV%-[V5-[V5-[WE1\WE1\WE1]WU5]WU5]WU9^W%9^W%9^W5=_W5=_W5=@PDA@PDA@PDEAPTEAPTEAP$IBP$IBP$ICP4MCP4MCP4QDQDQDQDQDQTUEQTUEQTUFQ$YFQ$YFQ$]GQ4]GQ4]GRD!HRD!HRD!IRT%IRT%IRT)JR$)JR$)JR4-KR4-KR4-LSD1LSD1LSD5MST5MST5MS$9NS$9NS$9OS4=OS4=OS5APTEAPTEAPTUEQTUEQTUERT%IRT%IRT%MST5MST5MSUEQTUEQTUEQUUUUUUUUUUUYVU%YVU%YVU5]WU5]WU5]XVE!XVE!XVE%YVU%YVU%YV%)ZV%)ZV%)[V5-[V5-[V51\WE1\WE1\WU5]WU5]WU5^W%9^W%9^W%=_W5=_W5=_PDA@PDA@PDAAPTEAPTEAPTIBP$IBP$IBP4MCP4MCP4MDQDQDQDQDQDUEQTUEQTUEQ$YFQ$YFQ$YGQ4]GQ4]GQ4!HRD!HRD!HRT%IRT%IRT%JR$)JR$)JR$-KR4-KR4-KSD1LSD1LSD1MST5MST5MST9NS$9NS$9NS4=OS4=OS4=PTEAPTEAPTEEQTUEQTUEQT%IRT%IRT%IST5MST5MST5QTUEQTUEQTUUUUUUUUUUUVU%YVU%YVU%]WU5]WU5]WVE!XVE!XVE!YVU%YVU%YVU)ZV%)ZV%)ZV5-[V5-[V5-\WE1\WE1\WE5]WU5]WU5]W%9^W%9^W%9_W5=_W5=_W4A@PDA@PDA@PTEAPTEAPTEBP$IBP$IBP$MCP4MCP4MCQDQDQDQDQDQEQTUEQTUEQTYFQ$YFQ$YFQ4]GQ4]GQ4]HRD!HRD!HRD%IRT%IRT%IR$)JR$)JR$)KR4-KR4-KR41LSD1LSD1LST5MST5MST5NS$9NS$9NS$=OS4=OS4=OTEAPTEAPTEAQTUEQTUEQTUIRT%IRT%IRT5MST5MST5MTUEQTUEQTUEUUUUUUUUUUU%YVU%YVU%YWU5]WU5]WU5!XVE!XVE!XVU%YVU%YVU%ZV%)ZV%)ZV%-[V5-[V5-[WE1\WE1\WE1]WU5]WU5]WU9^W%9^W%9^W5=_W5=_W5=@PDA@PDA@PDEAPTEAPTEAP$IBP$IBP$ICP4MCP4MCP4QDQDQDQDQDQTUEQTUEQTUFQ$YFQ$YFQ$]GQ4]GQ4]GRD!HRD!HRD!IRT%IRT%IRT)JR$)JR$)JR4-KR4-KR4-LSD1LSD1LSD5MST5MST5MS$9NS$9NS$9OS4=OS4=OS5APTEAPTEAPTUEQTUEQTUERT%IRT%IRT%MST5MST5MSUEQTUEQTUEQUUUUUUUUUUUYVU%YVU%YVU5]WU5]WU5]XVE!XVE!XVE%YVU%YVU%YV%)ZV%)ZV%)[V5-[V5-[V51\WE1\WE1\WU5]WU5]WU5^W%9^W%9^W%=_W5=_W5=_PDA@PDA@PDAAPTEAPTEAPTIBP$IBP$IBP4MCP4MCP4MDQDQDQDQDQDUEQTUEQTUEQ$YFQ$YFQ$YGQ4]GQ4]GQ4!HRD!HRD!HRT%IRT%IRT%JR$)JR$)JR$-KR4-KR4-KSD1LSD1LSD1MST5MST5MST9NS$9NS$9NS4=OS4=OS4=PTEAPTEAPTEEQTUEQTUEQT%IRT%IRT%IST5MST5MST5QTUEQTUEQTUUUUUUUUUUUVU%YVU%YVU%]WU5]WU5]WVE!XVE!XVE!YVU%YVU%YVU)ZV%)ZV%)ZV5-[V5-[V5-\WE1\WE1\WE5]WU5]WU5]W%9^W%9^W%9_W5=_W5=_W4A@PDA@PDA@PTEAPTEAPTEBP$IBP$IBP$MCP4MCP4MCQDQDQDQDQDQEQTUEQTUEQTYFQ$YFQ$YFQ4]GQ4]GQ4]HRD!HRD!HRD%IRT%IRT%IR$)JR$)JR$)KR4-KR4-KR41LSD1LSD1LST5MST5MST5NS$9NS$9NS$=OS4=OS4=OTEAPTEAPTEAQTUEQTUEQTUIRT%IRT%IRT5MST5MST5MTUEQTUEQTUEUUUUUUUUUUU%YVU%YVU%YWU5]WU5]WU5!XVE!XVE!XVU%YVU%YVU%ZV%)ZV%)ZV%-[V5-[V5-[WE1\WE1\WE1]WU5]WU5]WU9^W%9^W%9^W5=_W5=_W5=@PDA@PDA@PDEAPTEAPTEAP$IBP$IBP$ICP4MCP4MCP4QDQDQDQDQDQTUEQTUEQTUFQ$YFQ$YFQ$]GQ4]GQ4]GRD!HRD!HRD!IRT%IRT%IRT)JR$)JR$)JR4-KR4-KR4-LSD1LSD1LSD5MST5MST5MS$9NS$9NS$9OS4=OS4=OS5APTEAPTEAPTUEQTUEQTUERT%IRT%IRT%MST5MST5MSUEQTUEQTUEQUUUUUUUUUUUYVU%YVU%YVU5]WU5]WU5]XVE!XVE!XVE%YVU%YVU%YV%)ZV%)ZV%)[V5-[V5-[V51\WE1\WE1\WU5]WU5]WU5^W%9^W%9^W%=_W5=_W5=_XFA XFA XFA!XVE!XVE!XVI"X&I"X&I"X6M#X6M#X6M$YFQ$YFQ$YFU%YVU%YVU%Y&Y&Y&Y&Y&Y''''Y6]''''Y6]''''Y6!(ZF!(ZF!(ZV%)ZV%)ZV%*Z&)*Z&)*Z&-+Z6-+Z6-+[F1,[F1,[F1-[V5-[V5-[V9.[&9.[&9.[6=/[6=/[6=0\GA0\GA0\GE1\WE1\WE1\''''I2\''''I2\''''I3\7M3\7M3\7Q4]GQ4]GQ4]WU5]WU5]WU6]''''Y6]''''Y6]'''']7]7]7]7]7^G!8^G!8^G!9^W%9^W%9^W):^''''):^''''):^7-;^7-;^7-<_G1<_G1<_G5=_W5=_W5=_''''9>_''''9>_''''9?_7=?_7=?_6A XFA XFA XVE!XVE!XVE"X&I"X&I"X&M#X6M#X6M#YFQ$YFQ$YFQ%YVU%YVU%YVY&Y&Y&Y&Y&Y6]''''Y6]''''Y6](ZF!(ZF!(ZF%)ZV%)ZV%)Z&)*Z&)*Z&)+Z6-+Z6-+Z61,[F1,[F1,[V5-[V5-[V5.[&9.[&9.[&=/[6=/[6=/\GA0\GA0\GA1\WE1\WE1\WI2\''''I2\''''I2\7M3\7M3\7M4]GQ4]GQ4]GU5]WU5]WU5]''''Y6]''''Y6]''''Y7]7]7]7]7]7!8^G!8^G!8^W%9^W%9^W%:^''''):^''''):^''''-;^7-;^7-;_G1<_G1<_G1=_W5=_W5=_W9>_''''9>_''''9>_7=?_7=?_7= XFA XFA XFE!XVE!XVE!X&I"X&I"X&I#X6M#X6M#X6Q$YFQ$YFQ$YVU%YVU%YVU&Y&Y&Y&Y&Y&]''''Y6]''''Y6]''''ZF!(ZF!(ZF!)ZV%)ZV%)ZV)*Z&)*Z&)*Z6-+Z6-+Z6-,[F1,[F1,[F5-[V5-[V5-[&9.[&9.[&9/[6=/[6=/[7A0\GA0\GA0\WE1\WE1\WE2\''''I2\''''I2\''''M3\7M3\7M3]GQ4]GQ4]GQ5]WU5]WU5]WY6]''''Y6]''''Y6]7]7]7]7]7]8^G!8^G!8^G%9^W%9^W%9^''''):^''''):^'''');^7-;^7-;^71<_G1<_G1<_W5=_W5=_W5>_''''9>_''''9>_''''=?_7=?_7=?XFA XFA XFA!XVE!XVE!XVI"X&I"X&I"X6M#X6M#X6M$YFQ$YFQ$YFU%YVU%YVU%Y&Y&Y&Y&Y&Y''''Y6]''''Y6]''''Y6!(ZF!(ZF!(ZV%)ZV%)ZV%*Z&)*Z&)*Z&-+Z6-+Z6-+[F1,[F1,[F1-[V5-[V5-[V9.[&9.[&9.[6=/[6=/[6=0\GA0\GA0\GE1\WE1\WE1\''''I2\''''I2\''''I3\7M3\7M3\7Q4]GQ4]GQ4]WU5]WU5]WU6]''''Y6]''''Y6]'''']7]7]7]7]7^G!8^G!8^G!9^W%9^W%9^W):^''''):^''''):^7-;^7-;^7-<_G1<_G1<_G5=_W5=_W5=_''''9>_''''9>_''''9?_7=?_7=?_6A XFA XFA XVE!XVE!XVE"X&I"X&I"X&M#X6M#X6M#YFQ$YFQ$YFQ%YVU%YVU%YVY&Y&Y&Y&Y&Y6]''''Y6]''''Y6](ZF!(ZF!(ZF%)ZV%)ZV%)Z&)*Z&)*Z&)+Z6-+Z6-+Z61,[F1,[F1,[V5-[V5-[V5.[&9.[&9.[&=/[6=/[6=/\GA0\GA0\GA1\WE1\WE1\WI2\''''I2\''''I2\7M3\7M3\7M4]GQ4]GQ4]GU5]WU5]WU5]''''Y6]''''Y6]''''Y7]7]7]7]7]7!8^G!8^G!8^W%9^W%9^W%:^''''):^''''):^''''-;^7-;^7-;_G1<_G1<_G1=_W5=_W5=_W9>_''''9>_''''9>_7=?_7=?_7= XFA XFA XFE!XVE!XVE!X&I"X&I"X&I#X6M#X6M#X6Q$YFQ$YFQ$YVU%YVU%YVU&Y&Y&Y&Y&Y&]''''Y6]''''Y6]''''ZF!(ZF!(ZF!)ZV%)ZV%)ZV)*Z&)*Z&)*Z6-+Z6-+Z6-,[F1,[F1,[F5-[V5-[V5-[&9.[&9.[&9/[6=/[6=/[7A0\GA0\GA0\WE1\WE1\WE2\''''I2\''''I2\''''M3\7M3\7M3]GQ4]GQ4]GQ5]WU5]WU5]WY6]''''Y6]''''Y6]7]7]7]7]7]8^G!8^G!8^G%9^W%9^W%9^''''):^''''):^'''');^7-;^7-;^71<_G1<_G1<_W5=_W5=_W5>_''''9>_''''9>_''''=?_7=?_7=?XFA XFA XFA!XVE!XVE!XVI"X&I"X&I"X6M#X6M#X6M$YFQ$YFQ$YFU%YVU%YVU%Y&Y&Y&Y&Y&Y''''Y6]''''Y6]''''Y6!(ZF!(ZF!(ZV%)ZV%)ZV%*Z&)*Z&)*Z&-+Z6-+Z6-+[F1,[F1,[F1-[V5-[V5-[V9.[&9.[&9.[6=/[6=/[6=0\GA0\GA0\GE1\WE1\WE1\''''I2\''''I2\''''I3\7M3\7M3\7Q4]GQ4]GQ4]WU5]WU5]WU6]''''Y6]''''Y6]'''']7]7]7]7]7^G!8^G!8^G!9^W%9^W%9^W):^''''):^''''):^7-;^7-;^7-<_G1<_G1<_G5=_W5=_W5=_''''9>_''''9>_''''9?_7=?_7=?_6A XFA XFA XVE!XVE!XVE"X&I"X&I"X&M#X6M#X6M#YFQ$YFQ$YFQ%YVU%YVU%YVY&Y&Y&Y&Y&Y6]''''Y6]''''Y6](ZF!(ZF!(ZF%)ZV%)ZV%)Z&)*Z&)*Z&)+Z6-+Z6-+Z61,[F1,[F1,[V5-[V5-[V5.[&9.[&9.[&=/[6=/[6=/\GA0\GA0\GA1\WE1\WE1\WI2\''''I2\''''I2\7M3\7M3\7M4]GQ4]GQ4]GU5]WU5]WU5]''''Y6]''''Y6]''''Y7]7]7]7]7]7!8^G!8^G!8^W%9^W%9^W%:^''''):^''''):^''''-;^7-;^7-;_G1<_G1<_G1=_W5=_W5=_W9>_''''9>_''''9>_7=?_7=?_7>@ HB@ HB@ HFA XFA XFA (JB (JB (JC 8NC 8NC 8RD!HRD!HRD!XVE!XVE!XVF!(ZF!(ZF!(^G!8^G!8^G"H"H"H"H"H"I"X&I"X&I"X*J"(*J"(*J"8.K"8.K"8.L#H2L#H2L#H6M#X6M#X6M#(:N#(:N#(:O#8>O#8>O#9BP$IBP$IBP$YFQ$YFQ$YFR$)JR$)JR$)NS$9NS$9NS%IRT%IRT%IRU%YVU%YVU%YZV%)ZV%)ZV%9^W%9^W%9^X&I"X&I"X&I&Y&Y&Y&Y&Y&)*Z&)*Z&)*[&9.[&9.[&92\''''I2\''''I2\''''Y6]''''Y6]''''Y6^''''):^''''):^'''')>_''''9>_''''9>_ HB@ HB@ HBA XFA XFA XJB (JB (JB 8NC 8NC 8ND!HRD!HRD!HVE!XVE!XVE!(ZF!(ZF!(ZG!8^G!8^G!8"H"H"H"H"H"X&I"X&I"X&J"(*J"(*J"(.K"8.K"8.K#H2L#H2L#H2M#X6M#X6M#X:N#(:N#(:N#8>O#8>O#8>P$IBP$IBP$IFQ$YFQ$YFQ$)JR$)JR$)JS$9NS$9NS$9RT%IRT%IRT%YVU%YVU%YVV%)ZV%)ZV%)^W%9^W%9^W&I"X&I"X&I"Y&Y&Y&Y&Y&Y*Z&)*Z&)*Z&9.[&9.[&9.\''''I2\''''I2\''''I6]''''Y6]''''Y6]''''):^''''):^''''):_''''9>_''''9>_''''8B@ HB@ HB@ XFA XFA XFB (JB (JB (NC 8NC 8NC!HRD!HRD!HRE!XVE!XVE!XZF!(ZF!(ZF!8^G!8^G!8^H"H"H"H"H"H&I"X&I"X&I"(*J"(*J"(*K"8.K"8.K"82L#H2L#H2L#X6M#X6M#X6N#(:N#(:N#(>O#8>O#8>O$IBP$IBP$IBQ$YFQ$YFQ$YJR$)JR$)JR$9NS$9NS$9NT%IRT%IRT%IVU%YVU%YVU%)ZV%)ZV%)ZW%9^W%9^W%9"X&I"X&I"X&Y&Y&Y&Y&Y&Z&)*Z&)*Z&).[&9.[&9.[''''I2\''''I2\''''I2]''''Y6]''''Y6]''''Y:^''''):^''''):^''''9>_''''9>_''''9>@ HB@ HB@ HFA XFA XFA (JB (JB (JC 8NC 8NC 8RD!HRD!HRD!XVE!XVE!XVF!(ZF!(ZF!(^G!8^G!8^G"H"H"H"H"H"I"X&I"X&I"X*J"(*J"(*J"8.K"8.K"8.L#H2L#H2L#H6M#X6M#X6M#(:N#(:N#(:O#8>O#8>O#9BP$IBP$IBP$YFQ$YFQ$YFR$)JR$)JR$)NS$9NS$9NS%IRT%IRT%IRU%YVU%YVU%YZV%)ZV%)ZV%9^W%9^W%9^X&I"X&I"X&I&Y&Y&Y&Y&Y&)*Z&)*Z&)*[&9.[&9.[&92\''''I2\''''I2\''''Y6]''''Y6]''''Y6^''''):^''''):^'''')>_''''9>_''''9>_ HB@ HB@ HBA XFA XFA XJB (JB (JB 8NC 8NC 8ND!HRD!HRD!HVE!XVE!XVE!(ZF!(ZF!(ZG!8^G!8^G!8"H"H"H"H"H"X&I"X&I"X&J"(*J"(*J"(.K"8.K"8.K#H2L#H2L#H2M#X6M#X6M#X:N#(:N#(:N#8>O#8>O#8>P$IBP$IBP$IFQ$YFQ$YFQ$)JR$)JR$)JS$9NS$9NS$9RT%IRT%IRT%YVU%YVU%YVV%)ZV%)ZV%)^W%9^W%9^W&I"X&I"X&I"Y&Y&Y&Y&Y&Y*Z&)*Z&)*Z&9.[&9.[&9.\''''I2\''''I2\''''I6]''''Y6]''''Y6]''''):^''''):^''''):_''''9>_''''9>_''''8B@ HB@ HB@ XFA XFA XFB (JB (JB (NC 8NC 8NC!HRD!HRD!HRE!XVE!XVE!XZF!(ZF!(ZF!8^G!8^G!8^H"H"H"H"H"H&I"X&I"X&I"(*J"(*J"(*K"8.K"8.K"82L#H2L#H2L#X6M#X6M#X6N#(:N#(:N#(>O#8>O#8>O$IBP$IBP$IBQ$YFQ$YFQ$YJR$)JR$)JR$9NS$9NS$9NT%IRT%IRT%IVU%YVU%YVU%)ZV%)ZV%)ZW%9^W%9^W%9"X&I"X&I"X&Y&Y&Y&Y&Y&Z&)*Z&)*Z&).[&9.[&9.[''''I2\''''I2\''''I2]''''Y6]''''Y6]''''Y:^''''):^''''):^''''9>_''''9>_''''9>@ HB@ HB@ HFA XFA XFA (JB (JB (JC 8NC 8NC 8RD!HRD!HRD!XVE!XVE!XVF!(ZF!(ZF!(^G!8^G!8^G"H"H"H"H"H"I"X&I"X&I"X*J"(*J"(*J"8.K"8.K"8.L#H2L#H2L#H6M#X6M#X6M#(:N#(:N#(:O#8>O#8>O#9BP$IBP$IBP$YFQ$YFQ$YFR$)JR$)JR$)NS$9NS$9NS%IRT%IRT%IRU%YVU%YVU%YZV%)ZV%)ZV%9^W%9^W%9^X&I"X&I"X&I&Y&Y&Y&Y&Y&)*Z&)*Z&)*[&9.[&9.[&92\''''I2\''''I2\''''Y6]''''Y6]''''Y6^''''):^''''):^'''')>_''''9>_''''9>_ HB@ HB@ HBA XFA XFA XJB (JB (JB 8NC 8NC 8ND!HRD!HRD!HVE!XVE!XVE!(ZF!(ZF!(ZG!8^G!8^G!8"H"H"H"H"H"X&I"X&I"X&J"(*J"(*J"(.K"8.K"8.K#H2L#H2L#H2M#X6M#X6M#X:N#(:N#(:N#8>O#8>O#8>P$IBP$IBP$IFQ$YFQ$YFQ$)JR$)JR$)JS$9NS$9NS$9RT%IRT%IRT%YVU%YVU%YVV%)ZV%)ZV%)^W%9^W%9^W&I"X&I"X&I"Y&Y&Y&Y&Y&Y*Z&)*Z&)*Z&9.[&9.[&9.\''''I2\''''I2\''''I6]''''Y6]''''Y6]''''):^''''):^''''):_''''9>_''''9>_'''':B (JB (JB (ZF!(ZF!(ZF"(*J"(*J"(*N#(:N#(:N#)JR$)JR$)JR%)ZV%)ZV%)ZZ&)*Z&)*Z&):^''''):^''''):^(*J"(*J"(*J&)*Z&)*Z&)***********+*:.+*:.+*:2,+J2,+J2,+Z6-+Z6-+Z6.+*:.+*:.+*>/+:>/+:>/,KB0,KB0,KB1,[F1,[F1,[J2,+J2,+J2,;N3,;N3,;N4-KR4-KR4-KV5-[V5-[V5-+Z6-+Z6-+Z7-;^7-;^7-;"8.K"8.K"8.[&9.[&9.[&:.+*:.+*:.+.;.;.;.;.;/K2</K2</K2=/[6=/[6=/[:>/+:>/+:>/;>?/;>?/;> (JB (JB (JF!(ZF!(ZF!(*J"(*J"(*J#(:N#(:N#(:R$)JR$)JR$)ZV%)ZV%)ZV&)*Z&)*Z&)*^''''):^''''):^''''*J"(*J"(*J")*Z&)*Z&)*Z***********:.+*:.+*:.,+J2,+J2,+J6-+Z6-+Z6-+*:.+*:.+*:/+:>/+:>/+;B0,KB0,KB0,[F1,[F1,[F2,+J2,+J2,+N3,;N3,;N3-KR4-KR4-KR5-[V5-[V5-[Z6-+Z6-+Z6-;^7-;^7-;^8.K"8.K"8.K&9.[&9.[&9.+*:.+*:.+*;.;.;.;.;.;2</K2</K2</[6=/[6=/[6>/+:>/+:>/+>?/;>?/;>?(JB (JB (JB!(ZF!(ZF!(ZJ"(*J"(*J"(:N#(:N#(:N$)JR$)JR$)JV%)ZV%)ZV%)*Z&)*Z&)*Z''''):^''''):^''''):"(*J"(*J"(*Z&)*Z&)*Z&***********.+*:.+*:.++J2,+J2,+J2-+Z6-+Z6-+Z:.+*:.+*:.+:>/+:>/+:>0,KB0,KB0,KF1,[F1,[F1,+J2,+J2,+J3,;N3,;N3,;R4-KR4-KR4-[V5-[V5-[V6-+Z6-+Z6-+^7-;^7-;^7.K"8.K"8.K"9.[&9.[&9.[*:.+*:.+*:.;.;.;.;.;.</K2</K2</K6=/[6=/[6=/+:>/+:>/+:?/;>?/;>?/:B (JB (JB (ZF!(ZF!(ZF"(*J"(*J"(*N#(:N#(:N#)JR$)JR$)JR%)ZV%)ZV%)ZZ&)*Z&)*Z&):^''''):^''''):^(*J"(*J"(*J&)*Z&)*Z&)***********+*:.+*:.+*:2,+J2,+J2,+Z6-+Z6-+Z6.+*:.+*:.+*>/+:>/+:>/,KB0,KB0,KB1,[F1,[F1,[J2,+J2,+J2,;N3,;N3,;N4-KR4-KR4-KV5-[V5-[V5-+Z6-+Z6-+Z7-;^7-;^7-;"8.K"8.K"8.[&9.[&9.[&:.+*:.+*:.+.;.;.;.;.;/K2</K2</K2=/[6=/[6=/[:>/+:>/+:>/;>?/;>?/;> (JB (JB (JF!(ZF!(ZF!(*J"(*J"(*J#(:N#(:N#(:R$)JR$)JR$)ZV%)ZV%)ZV&)*Z&)*Z&)*^''''):^''''):^''''*J"(*J"(*J")*Z&)*Z&)*Z***********:.+*:.+*:.,+J2,+J2,+J6-+Z6-+Z6-+*:.+*:.+*:/+:>/+:>/+;B0,KB0,KB0,[F1,[F1,[F2,+J2,+J2,+N3,;N3,;N3-KR4-KR4-KR5-[V5-[V5-[Z6-+Z6-+Z6-;^7-;^7-;^8.K"8.K"8.K&9.[&9.[&9.+*:.+*:.+*;.;.;.;.;.;2</K2</K2</[6=/[6=/[6>/+:>/+:>/+>?/;>?/;>?(JB (JB (JB!(ZF!(ZF!(ZJ"(*J"(*J"(:N#(:N#(:N$)JR$)JR$)JV%)ZV%)ZV%)*Z&)*Z&)*Z''''):^''''):^''''):"(*J"(*J"(*Z&)*Z&)*Z&***********.+*:.+*:.++J2,+J2,+J2-+Z6-+Z6-+Z:.+*:.+*:.+:>/+:>/+:>0,KB0,KB0,KF1,[F1,[F1,+J2,+J2,+J3,;N3,;N3,;R4-KR4-KR4-[V5-[V5-[V6-+Z6-+Z6-+^7-;^7-;^7.K"8.K"8.K"9.[&9.[&9.[*:.+*:.+*:.;.;.;.;.;.</K2</K2</K6=/[6=/[6=/+:>/+:>/+:?/;>?/;>?/:B (JB (JB (ZF!(ZF!(ZF"(*J"(*J"(*N#(:N#(:N#)JR$)JR$)JR%)ZV%)ZV%)ZZ&)*Z&)*Z&):^''''):^''''):^(*J"(*J"(*J&)*Z&)*Z&)***********+*:.+*:.+*:2,+J2,+J2,+Z6-+Z6-+Z6.+*:.+*:.+*>/+:>/+:>/,KB0,KB0,KB1,[F1,[F1,[J2,+J2,+J2,;N3,;N3,;N4-KR4-KR4-KV5-[V5-[V5-+Z6-+Z6-+Z7-;^7-;^7-;"8.K"8.K"8.[&9.[&9.[&:.+*:.+*:.+.;.;.;.;.;/K2</K2</K2=/[6=/[6=/[:>/+:>/+:>/;>?/;>?/;> (JB (JB (JF!(ZF!(ZF!(*J"(*J"(*J#(:N#(:N#(:R$)JR$)JR$)ZV%)ZV%)ZV&)*Z&)*Z&)*^''''):^''''):^''''*J"(*J"(*J")*Z&)*Z&)*Z***********:.+*:.+*:.,+J2,+J2,+J6-+Z6-+Z6-+*:.+*:.+*:/+:>/+:>/+;B0,KB0,KB0,[F1,[F1,[F2,+J2,+J2,+N3,;N3,;N3-KR4-KR4-KR5-[V5-[V5-[Z6-+Z6-+Z6-;^7-;^7-;^8.K"8.K"8.K&9.[&9.[&9.+*:.+*:.+*;.;.;.;.;.;2</K2</K2</[6=/[6=/[6>/+:>/+:>/+>?/;>?/;>?0LC@0LC@0LCA0\GA0\GA0\KB0,KB0,KB0<OC0<OC0<OD1LSD1LSD1LWE1\WE1\WE1,[F1,[F1,[G1<_G1<_G1<#H2L#H2L#H2\''''I2\''''I2\''''J2,+J2,+J2,/K2</K2</K3L3L3L3L3L3M3\7M3\7M3\;N3,;N3,;N3<?O3<?O3<?P4MCP4MCP4MGQ4]GQ4]GQ4-KR4-KR4-KS4=OS4=OS4=ST5MST5MST5]WU5]WU5]WV5-[V5-[V5-_W5=_W5=_W6M#X6M#X6M#Y6]''''Y6]''''Y6]+Z6-+Z6-+Z6=/[6=/[6=/\7M3\7M3\7M7]7]7]7]7]7-;^7-;^7-;_7=?_7=?_7<C@0LC@0LC@0\GA0\GA0\GB0,KB0,KB0,OC0<OC0<OC1LSD1LSD1LSE1\WE1\WE1\[F1,[F1,[F1<_G1<_G1<_H2L#H2L#H2L''''I2\''''I2\''''I2,+J2,+J2,+K2</K2</K2<3L3L3L3L3L3\7M3\7M3\7N3,;N3,;N3,?O3<?O3<?O4MCP4MCP4MCQ4]GQ4]GQ4]KR4-KR4-KR4=OS4=OS4=OT5MST5MST5MWU5]WU5]WU5-[V5-[V5-[W5=_W5=_W5=#X6M#X6M#X6]''''Y6]''''Y6]''''Z6-+Z6-+Z6-/[6=/[6=/[7M3\7M3\7M3]7]7]7]7]7];^7-;^7-;^7=?_7=?_7=?@0LC@0LC@0LGA0\GA0\GA0,KB0,KB0,KC0<OC0<OC0<SD1LSD1LSD1\WE1\WE1\WF1,[F1,[F1,_G1<_G1<_G2L#H2L#H2L#I2\''''I2\''''I2\+J2,+J2,+J2</K2</K2</L3L3L3L3L3L7M3\7M3\7M3,;N3,;N3,;O3<?O3<?O3=CP4MCP4MCP4]GQ4]GQ4]GR4-KR4-KR4-OS4=OS4=OS5MST5MST5MSU5]WU5]WU5][V5-[V5-[V5=_W5=_W5=_X6M#X6M#X6M''''Y6]''''Y6]''''Y6-+Z6-+Z6-+[6=/[6=/[6=3\7M3\7M3\7]7]7]7]7]7^7-;^7-;^7-?_7=?_7=?_0LC@0LC@0LCA0\GA0\GA0\KB0,KB0,KB0<OC0<OC0<OD1LSD1LSD1LWE1\WE1\WE1,[F1,[F1,[G1<_G1<_G1<#H2L#H2L#H2\''''I2\''''I2\''''J2,+J2,+J2,/K2</K2</K3L3L3L3L3L3M3\7M3\7M3\;N3,;N3,;N3<?O3<?O3<?P4MCP4MCP4MGQ4]GQ4]GQ4-KR4-KR4-KS4=OS4=OS4=ST5MST5MST5]WU5]WU5]WV5-[V5-[V5-_W5=_W5=_W6M#X6M#X6M#Y6]''''Y6]''''Y6]+Z6-+Z6-+Z6=/[6=/[6=/\7M3\7M3\7M7]7]7]7]7]7-;^7-;^7-;_7=?_7=?_7<C@0LC@0LC@0\GA0\GA0\GB0,KB0,KB0,OC0<OC0<OC1LSD1LSD1LSE1\WE1\WE1\[F1,[F1,[F1<_G1<_G1<_H2L#H2L#H2L''''I2\''''I2\''''I2,+J2,+J2,+K2</K2</K2<3L3L3L3L3L3\7M3\7M3\7N3,;N3,;N3,?O3<?O3<?O4MCP4MCP4MCQ4]GQ4]GQ4]KR4-KR4-KR4=OS4=OS4=OT5MST5MST5MWU5]WU5]WU5-[V5-[V5-[W5=_W5=_W5=#X6M#X6M#X6]''''Y6]''''Y6]''''Z6-+Z6-+Z6-/[6=/[6=/[7M3\7M3\7M3]7]7]7]7]7];^7-;^7-;^7=?_7=?_7=?@0LC@0LC@0LGA0\GA0\GA0,KB0,KB0,KC0<OC0<OC0<SD1LSD1LSD1\WE1\WE1\WF1,[F1,[F1,_G1<_G1<_G2L#H2L#H2L#I2\''''I2\''''I2\+J2,+J2,+J2</K2</K2</L3L3L3L3L3L7M3\7M3\7M3,;N3,;N3,;O3<?O3<?O3=CP4MCP4MCP4]GQ4]GQ4]GR4-KR4-KR4-OS4=OS4=OS5MST5MST5MSU5]WU5]WU5][V5-[V5-[V5=_W5=_W5=_X6M#X6M#X6M''''Y6]''''Y6]''''Y6-+Z6-+Z6-+[6=/[6=/[6=3\7M3\7M3\7]7]7]7]7]7^7-;^7-;^7-?_7=?_7=?_0LC@0LC@0LCA0\GA0\GA0\KB0,KB0,KB0<OC0<OC0<OD1LSD1LSD1LWE1\WE1\WE1,[F1,[F1,[G1<_G1<_G1<#H2L#H2L#H2\''''I2\''''I2\''''J2,+J2,+J2,/K2</K2</K3L3L3L3L3L3M3\7M3\7M3\;N3,;N3,;N3<?O3<?O3<?P4MCP4MCP4MGQ4]GQ4]GQ4-KR4-KR4-KS4=OS4=OS4=ST5MST5MST5]WU5]WU5]WV5-[V5-[V5-_W5=_W5=_W6M#X6M#X6M#Y6]''''Y6]''''Y6]+Z6-+Z6-+Z6=/[6=/[6=/\7M3\7M3\7M7]7]7]7]7]7-;^7-;^7-;_7=?_7=?_7<C@0LC@0LC@0\GA0\GA0\GB0,KB0,KB0,OC0<OC0<OC1LSD1LSD1LSE1\WE1\WE1\[F1,[F1,[F1<_G1<_G1<_H2L#H2L#H2L''''I2\''''I2\''''I2,+J2,+J2,+K2</K2</K2<3L3L3L3L3L3\7M3\7M3\7N3,;N3,;N3,?O3<?O3<?O4MCP4MCP4MCQ4]GQ4]GQ4]KR4-KR4-KR4=OS4=OS4=OT5MST5MST5MWU5]WU5]WU5-[V5-[V5-[W5=_W5=_W5=#X6M#X6M#X6]''''Y6]''''Y6]''''Z6-+Z6-+Z6-/[6=/[6=/[7M3\7M3\7M3]7]7]7]7]7];^7-;^7-;^7=?_7=?_7=? 8NC 8NC 8NG!8^G!8^G!8.K"8.K"8.K#8>O#8>O#8>S$9NS$9NS$9^W%9^W%9^W&9.[&9.[&9._''''9>_''''9>_'''':N#(:N#(:N#):^''''):^''''):^+*:.+*:.+*:>/+:>/+:>/,;N3,;N3,;N7-;^7-;^7-;.;.;.;.;.;/;>?/;>?/;?C0<OC0<OC0<_G1<_G1<_G2</K2</K2</O3<?O3<?O3=OS4=OS4=OS5=_W5=_W5=_[6=/[6=/[6=?_7=?_7=?_8>O#8>O#8>O''''9>_''''9>_''''9>/+:>/+:>/+;>?/;>?/;>?3<?O3<?O3<?_7=?_7=?_7>?/;>?/;>?/??????????8NC 8NC 8NC!8^G!8^G!8^K"8.K"8.K"8>O#8>O#8>O$9NS$9NS$9NW%9^W%9^W%9.[&9.[&9.[''''9>_''''9>_''''9>#(:N#(:N#(:^''''):^''''):^''''*:.+*:.+*:./+:>/+:>/+;N3,;N3,;N3-;^7-;^7-;^;.;.;.;.;.;>?/;>?/;>?0<OC0<OC0<OG1<_G1<_G1</K2</K2</K3<?O3<?O3<?S4=OS4=OS4=_W5=_W5=_W6=/[6=/[6=/_7=?_7=?_7>O#8>O#8>O#9>_''''9>_''''9>_+:>/+:>/+:>?/;>?/;>?/<?O3<?O3<?O7=?_7=?_7=?/;>?/;>?/;??????????>C 8NC 8NC 8^G!8^G!8^G"8.K"8.K"8.O#8>O#8>O#9NS$9NS$9NS%9^W%9^W%9^[&9.[&9.[&9>_''''9>_''''9>_(:N#(:N#(:N''''):^''''):^''''):.+*:.+*:.++:>/+:>/+:>3,;N3,;N3,;^7-;^7-;^7.;.;.;.;.;.?/;>?/;>?/<OC0<OC0<OC1<_G1<_G1<_K2</K2</K2<?O3<?O3<?O4=OS4=OS4=OW5=_W5=_W5=/[6=/[6=/[7=?_7=?_7=?#8>O#8>O#8>_''''9>_''''9>_'''':>/+:>/+:>//;>?/;>?/;?O3<?O3<?O3=?_7=?_7=?_;>?/;>?/;>??????????? 8NC 8NC 8NG!8^G!8^G!8.K"8.K"8.K#8>O#8>O#8>S$9NS$9NS$9^W%9^W%9^W&9.[&9.[&9._''''9>_''''9>_'''':N#(:N#(:N#):^''''):^''''):^+*:.+*:.+*:>/+:>/+:>/,;N3,;N3,;N7-;^7-;^7-;.;.;.;.;.;/;>?/;>?/;?C0<OC0<OC0<_G1<_G1<_G2</K2</K2</O3<?O3<?O3=OS4=OS4=OS5=_W5=_W5=_[6=/[6=/[6=?_7=?_7=?_8>O#8>O#8>O''''9>_''''9>_''''9>/+:>/+:>/+;>?/;>?/;>?3<?O3<?O3<?_7=?_7=?_7>?/;>?/;>?/??????????8NC 8NC 8NC!8^G!8^G!8^K"8.K"8.K"8>O#8>O#8>O$9NS$9NS$9NW%9^W%9^W%9.[&9.[&9.[''''9>_''''9>_''''9>#(:N#(:N#(:^''''):^''''):^''''*:.+*:.+*:./+:>/+:>/+;N3,;N3,;N3-;^7-;^7-;^;.;.;.;.;.;>?/;>?/;>?0<OC0<OC0<OG1<_G1<_G1</K2</K2</K3<?O3<?O3<?S4=OS4=OS4=_W5=_W5=_W6=/[6=/[6=/_7=?_7=?_7>O#8>O#8>O#9>_''''9>_''''9>_+:>/+:>/+:>?/;>?/;>?/<?O3<?O3<?O7=?_7=?_7=?/;>?/;>?/;??????????>C 8NC 8NC 8^G!8^G!8^G"8.K"8.K"8.O#8>O#8>O#9NS$9NS$9NS%9^W%9^W%9^[&9.[&9.[&9>_''''9>_''''9>_(:N#(:N#(:N''''):^''''):^''''):.+*:.+*:.++:>/+:>/+:>3,;N3,;N3,;^7-;^7-;^7.;.;.;.;.;.?/;>?/;>?/<OC0<OC0<OC1<_G1<_G1<_K2</K2</K2<?O3<?O3<?O4=OS4=OS4=OW5=_W5=_W5=/[6=/[6=/[7=?_7=?_7=?#8>O#8>O#8>_''''9>_''''9>_'''':>/+:>/+:>//;>?/;>?/;?O3<?O3<?O3=?_7=?_7=?_;>?/;>?/;>??????????? 8NC 8NC 8NG!8^G!8^G!8.K"8.K"8.K#8>O#8>O#8>S$9NS$9NS$9^W%9^W%9^W&9.[&9.[&9._''''9>_''''9>_'''':N#(:N#(:N#):^''''):^''''):^+*:.+*:.+*:>/+:>/+:>/,;N3,;N3,;N7-;^7-;^7-;.;.;.;.;.;/;>?/;>?/;?C0<OC0<OC0<_G1<_G1<_G2</K2</K2</O3<?O3<?O3=OS4=OS4=OS5=_W5=_W5=_[6=/[6=/[6=?_7=?_7=?_8>O#8>O#8>O''''9>_''''9>_''''9>/+:>/+:>/+;>?/;>?/;>?3<?O3<?O3<?_7=?_7=?_7>?/;>?/;>?/??????????8NC 8NC 8NC!8^G!8^G!8^K"8.K"8.K"8>O#8>O#8>O$9NS$9NS$9NW%9^W%9^W%9.[&9.[&9.[''''9>_''''9>_''''9>#(:N#(:N#(:^''''):^''''):^''''*:.+*:.+*:./+:>/+:>/+;N3,;N3,;N3-;^7-;^7-;^;.;.;.;.;.;>?/;>?/;>?0<OC0<OC0<OG1<_G1<_G1</K2</K2</K3<?O3<?O3<?S4=OS4=OS4=_W5=_W5=_W6=/[6=/[6=/_7=?_7=?_7>O#8>O#8>O#9>_''''9>_''''9>_+:>/+:>/+:>?/;>?/;>?/<?O3<?O3<?O7=?_7=?_7=?/;>?/;>?/;??????????0@a''))'
]

{ #category : #'instance creation' }
JunLispSmallCompiler class >> new [
	^(super new)
		initScanner;
		yourself
]

{ #category : #copyright }
JunLispSmallCompiler class >> system [
	^'Jun'
]

{ #category : #copyright }
JunLispSmallCompiler class >> version [
	^'799'
]

{ #category : #parsing }
JunLispSmallCompiler >> arrayLiteral [
	| stream |
	stream := WriteStream on: (Array new: 16).
	[tokenType = #rightParenthesis]
		whileFalse: 
			[tokenType == #doIt ifTrue: [^self notify: 'array element or right parenthesis'].
			self arrayLiteralElement.
			stream nextPut: parseNode].
	parseNode := stream contents.
	self scanToken
]

{ #category : #parsing }
JunLispSmallCompiler >> arrayLiteralElement [
	self constant ifTrue: [^self].
	tokenType = #leftParenthesis
		ifTrue: 
			[self scanToken.
			self arrayLiteral.
			^self].
	tokenType = #leftBracket
		ifTrue: 
			[self scanToken.
			self byteArrayLiteral.
			^self].
	self scanLitToken.
	parseNode := token.
	self scanToken
]

{ #category : #parsing }
JunLispSmallCompiler >> byteArrayLiteral [
	| stream |
	stream := WriteStream on: (ByteArray new: 16).
	[tokenType = #rightBracket]
		whileFalse: 
			[(tokenType == #number and: [token isInteger and: [token >= 0 and: [token <= 255]]])
				ifFalse: [^self notify: '8-bit integer or right bracket'].
			stream nextPut: token.
			self scanToken].
	parseNode := stream contents.
	self scanToken
]

{ #category : #translating }
JunLispSmallCompiler >> compile: aString [ 
	| tokenArray |
	tokenArray := self scanTokens: aString.
	^self translate: tokenArray
]

{ #category : #parsing }
JunLispSmallCompiler >> constant [
	| size |
	tokenType == #word
		ifTrue: 
			[size := token size.
			size = 5
				ifTrue: [token = 'false'
						ifTrue: 
							[self scanToken.
							parseNode := false.
							^true]]
				ifFalse: [size = 4
						ifTrue: [token = 'true'
								ifTrue: 
									[self scanToken.
									parseNode := true.
									^true]]
						ifFalse: [size = 3 ifTrue: [token = 'nil'
									ifTrue: 
										[self scanToken.
										parseNode := nil.
										^true]]]].
			^false].
	(tokenType == #string or: [tokenType == #number or: [tokenType == #character]])
		ifTrue: 
			[parseNode := token.
			self scanToken.
			^true].
	(token == #- and: [hereChar notNil and: [hereChar isDigit]])
		ifTrue: 
			[self scanToken.
			parseNode := token negated.
			self scanToken.
			^true].
	tokenType == #literalQuote ifFalse: [^false].
	self scanToken.
	(tokenType == #word or: [tokenType == #binary or: [tokenType == #verticalBar or: [tokenType == #string]]])
		ifTrue: 
			[parseNode := token asSymbol.
			self scanToken.
			^true].
	tokenType == #keyword
		ifTrue: 
			[self scanLitKeywords.
			parseNode := token asSymbol.
			self scanToken.
			^true].
	tokenType == #leftParenthesis
		ifTrue: 
			[self scanToken.
			self arrayLiteral.
			^true].
	tokenType == #leftBracket
		ifTrue: 
			[self scanToken.
			self byteArrayLiteral.
			^true].
	^self notify: 'word, binary, keyword, (, or ['
]

{ #category : #'public access' }
JunLispSmallCompiler >> evaluate: textOrStream in: aContext receiver: receiver notifying: aRequestor ifFail: failBlock [ 
	| aString |
	(textOrStream isKindOf: PositionableStream)
		ifTrue: [aString := textOrStream contents asString]
		ifFalse: [aString := textOrStream asString].
	^self compile: aString
]

{ #category : #'public access' }
JunLispSmallCompiler >> evaluate: textOrStream in: aContext to: receiver notifying: aRequestor ifFail: failBlock [ 
	| value |
	value := nil.
	Cursor execute showWhile: [value := self
					evaluate: textOrStream
					in: aContext
					receiver: receiver
					notifying: aRequestor
					ifFail: failBlock].
	^value
]

{ #category : #'initialize-release' }
JunLispSmallCompiler >> initScanner [
	buffer := WriteStream on: (String new: 32).
	saveComments := true.
	typeTable := JunLispSmallTypeTable typeTable
]

{ #category : #'error handling' }
JunLispSmallCompiler >> notify: string [ 
	self error: string
]

{ #category : #'error handling' }
JunLispSmallCompiler >> offEnd: aString [ 
	^self notify: aString
]

{ #category : #'initialize-release' }
JunLispSmallCompiler >> on: inputStream [ 
	source := inputStream.
	hereChar := source next.
	prevEnd := 0
]

{ #category : #'initialize-release' }
JunLispSmallCompiler >> scan: inputStream [ 
	self on: inputStream.
	self scanToken
]

{ #category : #'public access' }
JunLispSmallCompiler >> scanFieldNames: stringOrArray [ 
	"JunLispSmallCompiler new scanFieldNames: 'abc def ghi'."

	| stream |
	(stringOrArray isMemberOf: Array)
		ifTrue: [^stringOrArray].
	stringOrArray isEmpty ifTrue: [^Array new: 0].
	self scan: (ReadStream on: stringOrArray asString).
	stream := WriteStream on: (Array new: 10).
	[tokenType = #doIt]
		whileFalse: 
			[tokenType = #word ifTrue: [stream nextPut: token].
			self scanToken].
	^stream contents
]

{ #category : #scanning }
JunLispSmallCompiler >> scanLitKeywords [
	| inKeywords |
	inKeywords := true.
	[inKeywords and: [hereChar notNil and: [(typeTable at: hereChar asInteger)
				= #xLetter]]]
		whileTrue: 
			[| t lastP lastCh |
			t := token.
			lastP := source position.
			lastCh := hereChar.
			self xLetter.
			tokenType = #keyword
				ifTrue: [token := t , token]
				ifFalse: 
					[inKeywords := false.
					token := t.
					hereChar := lastCh.
					source position: lastP.
					tokenType := #keyword]].
	token := token asSymbol
]

{ #category : #scanning }
JunLispSmallCompiler >> scanLitToken [
	tokenType = #leftParenthesis
		ifTrue: 
			[self scanToken.
			self scanLitVec]
		ifFalse: [tokenType = #word
				ifTrue: [token := token asSymbol]
				ifFalse: [tokenType = #keyword
						ifTrue: [self scanLitKeywords]
						ifFalse: [(token == #- and: [hereChar notNil and: [(typeTable at: hereChar asInteger)
										= #xDigit]])
								ifTrue: 
									[self scanToken.
									token := token negated]
								ifFalse: [((token isMemberOf: Character)
										and: [tokenType ~~ #character])
										ifTrue: [token := token asSymbol]]]]]
]

{ #category : #scanning }
JunLispSmallCompiler >> scanLitVec [
	| s |
	s := WriteStream on: (Array new: 16).
	[tokenType = #rightParenthesis or: [tokenType = #doIt]]
		whileFalse: 
			[self scanLitToken.
			s nextPut: token.
			self scanToken].
	token := s contents
]

{ #category : #'public access' }
JunLispSmallCompiler >> scanPositionsFor: aSymbol inString: aString [ 
	"JunLispSmallCompiler new scanPositionsFor: #JunLispSmallCompiler inString: 
	'| x y | 
	JunLispSmallCompiler compile: x. 
	Smalltalk at: #JunLispSmallCompiler put: nil. 
	(JunLispSmallCompiler compile: x y: y). 
	JunLispSmallCompiler foo'"

	| positions string |
	self scan: aString readStream.
	string := aSymbol asString.
	positions := (Array new: 16) writeStream.
	[tokenType = #doIt]
		whileFalse: 
			[(tokenType = #word and: [string = token])
				ifTrue: [positions nextPut: mark].
			self scanToken].
	^positions contents
]

{ #category : #scanning }
JunLispSmallCompiler >> scanToken [
	| skipped |
	
	[hereChar == nil
		ifTrue: 
			[prevEnd := source position.
			mark := prevEnd + 1.
			tokenType := #doIt.
			^token := nil].
	skipped := 0.
	(tokenType := typeTable at: hereChar asInteger) == #xDelimiter]
		whileTrue: 
			[skipped := skipped + 1.
			hereChar := source next].
	mark := source position.
	prevEnd := mark - skipped - 1.
	tokenType == #xLetter
		ifTrue: [self xLetter]
		ifFalse: [(tokenType at: 1)
				= $x
				ifTrue: [self perform: tokenType]
				ifFalse: 
					[token := hereChar.
					hereChar := source next]].
	^token
]

{ #category : #'public access' }
JunLispSmallCompiler >> scanTokens: textOrString [ 
	"JunLispSmallCompiler new scanTokens: 
	'(JunLispSmallCompiler #(aaa #(bbb 123 456.7d) nil true false) 
	#[1 2 3 4 5 6 7 8 9] identifier keyword: 8r31 
	''string'' embedded.period key:word: . )'."

	| stream |
	self scan: (ReadStream on: textOrString asString).
	stream := WriteStream on: (Array new: 16).
	[tokenType = #doIt]
		whileFalse: 
			[self arrayLiteralElement.
			stream nextPut: parseNode].
	^stream contents
]

{ #category : #'string and character' }
JunLispSmallCompiler >> separate: separateCollection dividers: dividerCollection [ 
	"JunLispSmallCompiler new separate: #(a b c d e f g h) dividers: #(d f)."

	^JunStringUtility separate: separateCollection dividers: dividerCollection
]

{ #category : #'string and character' }
JunLispSmallCompiler >> separators [
	"JunLispSmallCompiler new separators."

	| stream |
	stream := WriteStream on: (String new: 4).
	stream nextPut: Character space.
	stream nextPut: Character tab.
	stream nextPut: Character cr.
	stream nextPut: Character lf.
	^stream contents
]

{ #category : #scanning }
JunLispSmallCompiler >> step [
	| c |
	c := hereChar.
	hereChar := source next.
	^c
]

{ #category : #'string and character' }
JunLispSmallCompiler >> stringMatch: string and: pattern [ 
	"JunLispSmallCompiler new stringMatch: 'Jun Aoki' and: 'Ju*[A-B]?ki'."

	^JunStringUtility stringMatch: string and: pattern
]

{ #category : #translating }
JunLispSmallCompiler >> translate: tokenArray [ 
	| value receiver selector |
	tokenArray isEmpty ifTrue: [^nil].
	(tokenArray size = 1 and: [tokenArray first isKindOf: Array])
		ifTrue: 
			[value := nil.
			tokenArray do: [:each | value := self translate: each].
			^value].
	tokenArray size = 1 ifTrue: [^tokenArray first].
	receiver := tokenArray at: 1.
	selector := tokenArray at: 2.
	((receiver isKindOf: Number)
		and: [selector = #@ or: [selector = #,]])
		ifTrue: [^self translateToPoint: tokenArray].
	(((receiver = #Point and: [selector = #x:])
		or: [receiver = #Jun3dPoint and: [selector = #x:]])
		or: [receiver = #Jun2dPoint and: [selector = #x:]])
		ifTrue: [^self translateToPoint: tokenArray].
	(receiver = #ByteArray and: [selector = #fromPackedString:])
		ifTrue: [^self translateToByteArray: tokenArray].
	(((receiver = #Image and: [selector = #extent:])
		or: [receiver = #OpaqueImage and: [selector = #basicNew]])
		or: [receiver = #CachedImage and: [selector = #on:]])
		ifTrue: [^self translateToImage: tokenArray].
	(receiver = #ColorValue and: [(#(#red: #hue: #cyan: #scaledRed: #brightness:) includes: selector)
			or: [ColorValue constantNames includes: selector]])
		ifTrue: [^self translateToColor: tokenArray].
	^self notify: 'unexpected error'
]

{ #category : #translating }
JunLispSmallCompiler >> translateToByteArray: tokenArray [ 
	| aSymbol aSelector byteArray |
	(tokenArray isKindOf: ByteArray)
		ifTrue: [^tokenArray].
	aSymbol := tokenArray at: 1.
	aSelector := tokenArray at: 2.
	(aSymbol = #ByteArray and: [aSelector = #fromPackedString:])
		ifFalse: [^self notify: 'unexpected error'].
	byteArray := ByteArray fromPackedString: (tokenArray at: 3).
	^byteArray
]

{ #category : #translating }
JunLispSmallCompiler >> translateToColor: tokenArray [ 
	| symbol collection stream selector arguments color |
	symbol := tokenArray at: 1.
	symbol = #ColorValue ifFalse: [^self notify: 'unexpected error'].
	selector := tokenArray at: 2.
	(ColorValue constantNames includes: selector)
		ifTrue: [color := ColorValue perform: selector]
		ifFalse: 
			[collection := OrderedCollection new.
			stream := WriteStream on: (String new: 32).
			2
				to: tokenArray size
				by: 2
				do: 
					[:index | 
					stream nextPutAll: (tokenArray at: index).
					collection add: (tokenArray at: index + 1)].
			selector := stream contents asSymbol.
			arguments := collection asArray.
			color := ColorValue perform: selector withArguments: arguments].
	^color
]

{ #category : #translating }
JunLispSmallCompiler >> translateToImage: tokenArray [ 
	| aSymbol anImage |
	aSymbol := tokenArray at: 1.
	(aSymbol = #Image or: [aSymbol = #OpaqueImage or: [aSymbol = #CachedImage]])
		ifFalse: [^self notify: 'unexpected error'].
	aSymbol = #Image
		ifTrue: 
			[| extentPoint colorDepth bitsPerPixel anObject aPalette byteArray |
			extentPoint := (tokenArray at: 3)
						@ (tokenArray at: 5).
			colorDepth := tokenArray at: 7.
			bitsPerPixel := tokenArray at: 9.
			anObject := tokenArray at: 11.
			(anObject isKindOf: Array)
				ifTrue: 
					[aPalette := self translateToPalette: (tokenArray at: 11).
					byteArray := self translateToByteArray: (tokenArray at: 13)]
				ifFalse: 
					[aPalette := self translateToPalette: (Array with: (tokenArray at: 11)
									with: (tokenArray at: 12)).
					byteArray := self translateToByteArray: (tokenArray at: 14)].
			anImage := Image
						extent: extentPoint
						depth: colorDepth
						bitsPerPixel: bitsPerPixel
						palette: aPalette
						usingBits: byteArray].
	aSymbol = #OpaqueImage
		ifTrue: 
			[| figureImage shapeImage |
			figureImage := self translateToImage: (tokenArray at: 6).
			shapeImage := self translateToImage: (tokenArray at: 11).
			anImage := OpaqueImage figure: figureImage shape: shapeImage].
	aSymbol = #CachedImage
		ifTrue: 
			[anImage := self translate: (tokenArray at: 3).
			anImage := CachedImage on: anImage].
	^anImage
]

{ #category : #translating }
JunLispSmallCompiler >> translateToPalette: tokenArray [ 
	| aSymbol aPalette |
	aSymbol := tokenArray at: 1.
	(aSymbol = #CoveragePalette or: [aSymbol = #FixedPalette or: [aSymbol = #MappedPalette or: [aSymbol = #MonoMappedPalette]]])
		ifFalse: [^self notify: 'unexpected error'].
	aSymbol = #CoveragePalette
		ifTrue: 
			[| selector |
			selector := tokenArray at: 2.
			(CoveragePalette constantNames includes: selector)
				ifTrue: [aPalette := CoveragePalette perform: selector]
				ifFalse: [aPalette := CoveragePalette perform: selector with: (tokenArray at: 3)]].
	aSymbol = #FixedPalette
		ifTrue: 
			[| collection stream selector arguments |
			collection := OrderedCollection new.
			stream := WriteStream on: (String new: 32).
			2
				to: tokenArray size
				by: 2
				do: 
					[:index | 
					stream nextPutAll: (tokenArray at: index).
					collection add: (tokenArray at: index + 1)].
			selector := stream contents asSymbol.
			arguments := collection asArray.
			aPalette := FixedPalette perform: selector withArguments: arguments].
	(aSymbol = #MappedPalette or: [aSymbol = #MonoMappedPalette])
		ifTrue: 
			[| sort selector array arguments index location it |
			sort := Smalltalk at: aSymbol.
			selector := tokenArray at: 2.
			(sort constantNames includes: selector)
				ifTrue: [aPalette := sort perform: selector]
				ifFalse: 
					[array := tokenArray at: 3.
					arguments := Array new: ((array at: 1)
									at: 3).
					array := array copyFrom: 2 to: array size - 2.
					index := array
								nextIndexOf: #at:
								from: 1
								to: array size.
					[index isNil]
						whileFalse: 
							[location := array at: index + 1.
							it := array at: index + 3.
							(it isKindOf: Array)
								ifFalse: [it := Array with: (array at: index + 3)
												with: (array at: index + 4)].
							arguments at: location put: (self translateToColor: it).
							index := array
										nextIndexOf: #at:
										from: index + 1
										to: array size].
					aPalette := sort perform: selector with: arguments]].
	^aPalette
]

{ #category : #translating }
JunLispSmallCompiler >> translateToPoint: tokenArray [ 
	| receiver selector arguments point |
	receiver := tokenArray at: 1.
	selector := tokenArray at: 2.
	((receiver isKindOf: Number)
		and: [selector = #@ or: [selector = #,]])
		ifTrue: 
			[2
				to: tokenArray size
				by: 2
				do: 
					[:index | 
					selector := tokenArray at: index.
					arguments := Array with: (tokenArray at: index + 1).
					(receiver respondsTo: selector)
						ifFalse: [^tokenArray].
					point := receiver perform: selector withArguments: arguments.
					receiver := point].
			^point].
	(receiver = #Point or: [receiver = #Jun3dPoint or: [receiver = #Jun2dPoint]])
		ifFalse: [^self notify: 'unexpected error'].
	receiver = #Point ifTrue: [point := Point x: (tokenArray at: 3)
					y: (tokenArray at: 5)].
	receiver = #Jun3dPoint ifTrue: [point := Jun3dPoint
					x: (tokenArray at: 3)
					y: (tokenArray at: 5)
					z: (tokenArray at: 7)].
	receiver = #Jun2dPoint ifTrue: [point := Jun2dPoint x: (tokenArray at: 3)
					y: (tokenArray at: 5)].
	^point
]

{ #category : #x }
JunLispSmallCompiler >> xBinary [
	| char |
	tokenType := #binary.
	char := hereChar.
	hereChar := source next.
	(hereChar notNil and: [(typeTable at: hereChar asInteger)
			= #xBinary and: [hereChar ~= $-]])
		ifTrue: [token := Symbol intern: (String with: char with: self step)]
		ifFalse: [token := Symbol internCharacter: char]
]

{ #category : #x }
JunLispSmallCompiler >> xDefault [
	self notify: 'unknown character'
]

{ #category : #x }
JunLispSmallCompiler >> xDelimiter [
	self scanToken
]

{ #category : #x }
JunLispSmallCompiler >> xDigit [
	tokenType := #number.
	hereChar == nil ifFalse: [source skip: -1].
	token := Number readSmalltalkSyntaxFrom: source.
	hereChar := source next
]

{ #category : #x }
JunLispSmallCompiler >> xDollar [
	token := source next.
	hereChar := source next.
	tokenType := #character
]

{ #category : #x }
JunLispSmallCompiler >> xDoubleQuote [
	| savedEnd char |
	savedEnd := prevEnd.
	saveComments ifFalse: [[(char := source next) == $"]
			whileFalse: [char == nil ifTrue: [^self offEnd: 'unmatched comment quote']]]
		ifTrue: 
			[buffer reset.
			[(char := source next) == $"]
				whileFalse: 
					[char == nil ifTrue: [^self offEnd: 'unmatched comment quote'].
					buffer nextPut: char].
			currentComment == nil
				ifTrue: [currentComment := OrderedCollection with: buffer contents]
				ifFalse: [currentComment add: buffer contents].
			buffer position > 200 ifTrue: [buffer := WriteStream on: (String new: 40)]].
	hereChar := source next.
	self scanToken.
	prevEnd := savedEnd
]

{ #category : #x }
JunLispSmallCompiler >> xLetter [
	| type char |
	buffer reset.
	buffer nextPut: hereChar.
	
	[char := source next.
	char notNil
		and: 
			[type := typeTable at: char asInteger.
			type == #xLetter or: [type == #xDigit]]]
		whileTrue: [buffer nextPut: char].
	type == #colon
		ifTrue: 
			[buffer nextPut: char.
			char := source next.
			tokenType := #keyword]
		ifFalse: [tokenType := #word].
	hereChar := char.
	token := buffer contents
]

{ #category : #x }
JunLispSmallCompiler >> xLitQuote [
	| start |
	self step.
	self scanToken.
	tokenType = #leftParenthesis
		ifTrue: 
			[start := mark.
			self scanToken.
			self scanLitVec.
			tokenType == #doIt
				ifTrue: 
					[mark := start.
					self offEnd: 'unmatched parenthesis']]
		ifFalse: [tokenType = #word
				ifTrue: [token := token asSymbol]
				ifFalse: [tokenType = #keyword ifTrue: [self scanLitKeywords]]].
	tokenType := #literal
]

{ #category : #x }
JunLispSmallCompiler >> xSingleQuote [
	| char |
	char := source next.
	buffer on: (String new: 32).
	
	[char == nil ifTrue: [^self offEnd: 'unmatched string quote'].
	char == $' and: [(char := source next) ~~ $']]
		whileFalse: 
			[buffer nextPut: char.
			char := source next].
	hereChar := char.
	token := buffer contents.
	tokenType := #string
]

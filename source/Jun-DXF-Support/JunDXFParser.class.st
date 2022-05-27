"
Imported by VwImportClass
"
Class {
	#name : #JunDXFParser,
	#superclass : #JunDXFScanner,
	#instVars : [
		'layers',
		'layer',
		'dxfNames',
		'itemCount',
		'definedObjects',
		'item',
		'doNurbs',
		'layerColors',
		'settings',
		'outside',
		'happy'
	],
	#classVars : [
		'ColorTable',
		'Text1'
	],
	#category : #'Jun-DXF-Support'
}

{ #category : #utilities }
JunDXFParser class >> calculateARC: aPoint radius: r from: a1 to: a2 [ 
	"answer a Polyline"
	"| x1 x2 |
		0 to: 360 by: 50 do:[:x | 
		x1 := x.
		x2 := x + 10.
		(self calculateARC: (0, 0, 0) radius: 1000 from: x1 to: x2) show]."
	"(JunDXFParser calculateARC: (0, 0, 0) radius: 10 from: 315 to: 45) show"

	| x y pi2 delta angle1 angle2 points nx ny xStart xEnd sweep |
	x := aPoint x.
	y := aPoint y.
	aPoint z.
	pi2 := Float pi * 2.
	angle1 := a1 / 360.0 * pi2.
	angle2 := a2 / 360.0 * pi2.
	angle2 = 0 ifTrue: [angle2 := pi2].
	points := OrderedCollection new: 8.
	xStart := angle1.
	xEnd := angle2.
	sweep := angle2 - angle1 \\ pi2.
	delta := sweep / 8.0.
	xStart > xEnd ifTrue: [xEnd := xEnd + pi2].
	"Transcript cr; show: 'xStart: ', xStart printString, '   xEnd: ', xEnd printString, '  sweep: ', sweep printString,  '  delta: ', delta printString."
	[xStart < xEnd]
		whileTrue: 
			[nx := x + (xStart cos * r).
			ny := y + (xStart sin * r).
			points add: nx , ny , 0.
			xStart := xStart + delta].
	nx := x + (xEnd cos * r).
	ny := y + (xEnd sin * r).
	points add: nx, ny, 0.
	^points
]

{ #category : #accessing }
JunDXFParser class >> colorAt: anInteger [ 
	| index |
	index := anInteger.
	ColorTable isNil
		ifTrue: 
			[ColorTable := Array new: 7.
			ColorTable at: 1 put: ColorValue red.
			ColorTable at: 2 put: ColorValue yellow.
			ColorTable at: 3 put: ColorValue green.
			ColorTable at: 4 put: ColorValue cyan.
			ColorTable at: 5 put: ColorValue blue.
			ColorTable at: 6 put: ColorValue purple.
			ColorTable at: 7 put: ColorValue white.
			"ColorTable at: 7 put: ColorValue black."
			].
	(index between: 1 and: 7)
		ifFalse: [index := 7].
	^ColorTable at: index
]

{ #category : #copyright }
JunDXFParser class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunDXFParser class >> example1 [
	"JunDXFParser example1."
	"JunDXFParser on: 'd:\data\dxf\awk\wing1b.dxf'"

	| parser stream |
	stream := ReadStream on: self text1.
	parser := JunDXFParser new.
	parser on: stream.
	^parser
]

{ #category : #examples }
JunDXFParser class >> example2 [
	"JunDXFParser example2."

	| parser stream |
	stream := ReadStream on: self text2.
	parser := JunDXFParser new.
	parser on: stream.
	^parser
]

{ #category : #examples }
JunDXFParser class >> exampleArc [
	"JunDXFParser exampleArc."

	| parser stream |
	stream := ReadStream on: self textArc.
	parser := JunDXFParser new.
	parser debugOn.
	parser on: stream.
	^parser
]

{ #category : #examples }
JunDXFParser class >> exampleCircle [
	"JunDXFParser exampleCircle."

	| parser stream |
	stream := ReadStream on: self textCircle.
	parser := JunDXFParser new.
	parser debugOn.
	parser on: stream.
	^parser
]

{ #category : #examples }
JunDXFParser class >> exampleDefLine [
	"JunDXFParser exampleDefLine."

	| parser stream |
	stream := ReadStream on: self textDefLine.
	parser := JunDXFParser new.
	parser debugOn.
	parser on: stream.
	^parser
]

{ #category : #examples }
JunDXFParser class >> exampleLine [
	"JunDXFParser exampleLine."

	| parser stream |
	stream := ReadStream on: self textLine.
	parser := JunDXFParser new.
	parser debugOn.
	parser on: stream.
	^parser
]

{ #category : #examples }
JunDXFParser class >> examplePolyline [
	"JunDXFParser examplePolyline."

	| parser stream |
	stream := ReadStream on: self textPolyline.
	parser := JunDXFParser new.
	parser debugOn.
	parser on: stream.
	^parser
]

{ #category : #accessing }
JunDXFParser class >> flushColors [
	"JunDXFParser flushColors"

	ColorTable := nil
]

{ #category : #'instance creation' }
JunDXFParser class >> on: aFilename [ 
	"JunDXFParser on: 'd:\data\dxf\awk\wing1t.dxf'"

	| scanner stream |
	stream := aFilename asFilename readStream.
	scanner := JunDXFParser new.
	scanner on: stream.
	^scanner
]

{ #category : #'instance creation' }
JunDXFParser class >> on: aFilename separator: aCharacter [ 
	"JunDXFParser on: 'd:\data\dxf\awk\wing1t.dxf'"

	| scanner stream |
	stream := aFilename asFilename readStream.
	scanner := JunDXFParser new.
	scanner lineSeparator: aCharacter.
	scanner on: stream.
	^scanner parse
]

{ #category : #'instance creation' }
JunDXFParser class >> onDebug: aFilename [ 
	"JunDXFParser on: 'd:\data\dxf\awk\wing1t.dxf'"

	| scanner stream |
	stream := aFilename asFilename readStream.
	scanner := JunDXFParser new.
	scanner onSmart: stream.
	scanner debugOn.
	^scanner parse
]

{ #category : #'instance creation' }
JunDXFParser class >> onLF: aFilename [
	"JunDXFParser on: 'd:\data\dxf\awk\wing1t.dxf'"

	| scanner stream |
	stream := aFilename asFilename readStream.
	scanner := JunDXFParser new lf.
	scanner on: stream.
	^scanner parse
]

{ #category : #'instance creation' }
JunDXFParser class >> onParse: aFilename [ 
	"JunDXFParser on: 'd:\data\dxf\awk\wing1t.dxf'"

	| scanner stream |
	stream := aFilename asFilename readStream.
	scanner := JunDXFParser new.
	scanner on: stream.
	^scanner parse
]

{ #category : #'instance creation' }
JunDXFParser class >> onSmart: aFilename [ 
	"JunDXFParser on: 'd:\data\dxf\awk\wing1t.dxf'"
	"Determines from the file itself whether to use CR or LF"

	| parser stream |
	stream := aFilename asFilename readStream.
	parser := JunDXFParser new.
	parser onSmart: stream.
	^parser parse
]

{ #category : #copyright }
JunDXFParser class >> system [
	^'Jun'
]

{ #category : #examples }
JunDXFParser class >> text1 [
	Text1  := '  0
SECTION
  2
HEADER
 10
1.123
 20
2.345
 0
ENDSEC
  0
SECTION
  2
TABLES
 10
1.0
  0
ENDSEC
  0
SECTION
  2
BLOCKS
 10
1.3
  0
ENDSEC
  0
SECTION
  2
ENTITIES
 10
3.4
  0
ENDSEC
  0
EOF
'.
	^Text1
]

{ #category : #examples }
JunDXFParser class >> text2 [
	"JunDXFParser text2."
	Text1  := '  0
SECTION
  2
HEADER
  9
$ACADVER
  1
AC1006
  9
$CLAYER
  8
LAYER-1
  9
$EXTMIN
 10
0.000000
 20
0.000000
  9
$EXTMAX
 10
12.415473
 20
6.960133
  9
$FASTZOOM
 70
0
  9
$FILLMODE
 70
1
  0
ENDSEC
  0
SECTION
  2
TABLES
  0
TABLE
  2
LTYPE
 70
16
  0
LTYPE
  2
CONTINUOUS
 70
64
  3
Solid Line
 72
65
 73
0
 40
0.000000
  0
LTYPE
  2
LTYPE01
 70
64
  3
CUSTOM
 72
65
 73
2
 40
0.111111
 49
0.083333
 49
-0.027778
  0
LTYPE
  2
LTYPE02
 70
64
  3
CUSTOM
 72
65
 73
2
 40
0.194444
 49
0.166667
 49
-0.027778
  0
LTYPE
  2
LTYPE03
 70
64
  3
CUSTOM
 72
65
 73
2
 40
0.375000
 49
0.333333
 49
-0.041667
  0
LTYPE
  2
LTYPE04
 70
64
  3
CUSTOM
 72
65
 73
2
 40
0.722222
 49
0.666667
 49
-0.055556
  0
LTYPE
  2
LTYPE05
 70
64
  3
CUSTOM
 72
65
 73
4
 40
0.152778
 49
0.083333
 49
-0.027778
 49
0.013889
 49
-0.027778
  0
LTYPE
  2
LTYPE06
 70
64
  3
CUSTOM
 72
65
 73
4
 40
0.236111
 49
0.166667
 49
-0.027778
 49
0.013889
 49
-0.027778
  0
LTYPE
  2
LTYPE07
 70
64
  3
CUSTOM
 72
65
 73
4
 40
0.444444
 49
0.333333
 49
-0.041667
 49
0.027778
 49
-0.041667
  0
LTYPE
  2
LTYPE08
 70
64
  3
CUSTOM
 72
65
 73
4
 40
0.805556
 49
0.666667
 49
-0.055556
 49
0.027778
 49
-0.055556
  0
LTYPE
  2
LTYPE09
 70
64
  3
CUSTOM
 72
65
 73
6
 40
0.194444
 49
0.083333
 49
-0.027778
 49
0.013889
 49
-0.027778
 49
0.013889
 49
-0.027778
  0
LTYPE
  2
LTYPE10
 70
64
  3
CUSTOM
 72
65
 73
6
 40
0.277778
 49
0.166667
 49
-0.027778
 49
0.013889
 49
-0.027778
 49
0.013889
 49
-0.027778
  0
LTYPE
  2
LTYPE11
 70
64
  3
CUSTOM
 72
65
 73
6
 40
0.500000
 49
0.333333
 49
-0.041667
 49
0.027778
 49
-0.027778
 49
0.027778
 49
-0.041667
  0
LTYPE
  2
LTYPE12
 70
64
  3
CUSTOM
 72
65
 73
6
 40
0.861111
 49
0.666667
 49
-0.055556
 49
0.027778
 49
-0.027778
 49
0.027778
 49
-0.055556
  0
LTYPE
  2
LTYPE13
 70
64
  3
CUSTOM
 72
65
 73
8
 40
0.319444
 49
0.166667
 49
-0.027778
 49
0.013889
 49
-0.027778
 49
0.013889
 49
-0.027778
 49
0.013889
 49
-0.027778
  0
LTYPE
  2
LTYPE14
 70
64
  3
CUSTOM
 72
65
 73
8
 40
0.555556
 49
0.333333
 49
-0.041667
 49
0.027778
 49
-0.027778
 49
0.027778
 49
-0.027778
 49
0.027778
 49
-0.041667
  0
LTYPE
  2
LTYPE15
 70
64
  3
CUSTOM
 72
65
 73
8
 40
0.944444
 49
0.666667
 49
-0.055556
 49
0.027778
 49
-0.041667
 49
0.027778
 49
-0.041667
 49
0.027778
 49
-0.055556
  0
ENDTAB
  0
TABLE
  2
LAYER
 70
2
  0
LAYER
  2
LAYER-1
 70
0
 62
7
  6
CONTINUOUS
  0
LAYER
  2
LAYER-2
 70
0
 62
7
  6
CONTINUOUS
  0
ENDTAB
  0
ENDSEC
  0
SECTION
  2
BLOCKS
  0
ENDSEC
  0
SECTION
  2
ENTITIES
  0
POLYLINE
  8
LAYER-2
 66
  1
210
  0
220
  0
230
  1
 70
  0
 62
  0
  0
VERTEX
  8
LAYER-2
 10
0.434028
 20
2.013898
 30
0.000000
  0
VERTEX
  8
LAYER-2
 10
0.610805
 20
2.190675
 30
0.000000
  0
VERTEX
  8
LAYER-2
 10
0.787582
 20
2.013898
 30
0.000000
  0
VERTEX
  8
LAYER-2
 10
0.610805
 20
1.837121
 30
0.000000
  0
SEQEND
  8
LAYER-2
  0
POLYLINE
  8
LAYER-2
 66
  1
 70
  1
 62
  0
  0
VERTEX
  8
LAYER-2
 10
0.607639
 20
1.840287
 30
0.000000
  0
VERTEX
  8
LAYER-2
 10
0.784416
 20
2.017064
 30
0.000000
  0
VERTEX
  8
LAYER-2
 10
0.961193
 20
1.840287
 30
0.000000
  0
VERTEX
  8
LAYER-2
 10
0.784416
 20
1.663510
 30
0.000000
  0
SEQEND
  8
LAYER-2
  0
ENDSEC
  0
EOF
'.
	^Text1
]

{ #category : #examples }
JunDXFParser class >> textArc [
	Text1  := '   0
SECTION
  2
ENTITIES
  0
ARC
  5
73
  8
0
  6
CONTINUOUS
 62
     7
 10
0.042566
 20
0.095575
 30
0.0
 40
1.6
 50
90.0
 51
270.0
  0
LINE
  5
70
  8
0
  6
CONTINUOUS
 62
     6
 10
-0.0547
 20
-0.0547
 30
0.0
 11
0.0547
 21
0.0547
 31
0.0
  0
ENDSEC
  0
EOF
'.
	^Text1
]

{ #category : #examples }
JunDXFParser class >> textCircle [
	Text1  := '   0
SECTION
  2
ENTITIES
  0
LINE
  5
70
  8
0
  6
CONTINUOUS
 62
     6
 10
-0.0547
 20
-0.0547
 30
0.0
 11
0.0547
 21
0.0547
 31
0.0
  0
CIRCLE
  5
72
  8
0
 62
     7
 10
0.0
 20
0.0
 30
0.0
 40
1.5
  0
ENDSEC
  0
EOF
'.
	^Text1
]

{ #category : #examples }
JunDXFParser class >> textDefLine [
	Text1  := '  0
SECTION
  2
BLOCKS
  0
BLOCK
  8
0
  2
WGV
 70
     0
 10
0.0
 20
0.0
 30
0.0
  3
WGV
  1

  0
LINE
  5
6F
  8
0
  6
CONTINUOUS
 62
     6
 10
0.0547
 20
-0.0547
 30
0.0
 11
0.0547
 21
0.0547
 31
0.0
  0
LINE
  5
70
  8
0
  6
CONTINUOUS
 62
     6
 10
-0.0547
 20
-0.0547
 30
0.0
 11
0.0547
 21
0.0547
 31
0.0
  0
LINE
  5
71
  8
0
  6
CONTINUOUS
 62
     6
 10
-0.0547
 20
0.0547
 30
0.0
 11
0.0547
 21
-0.0547
 31
0.0
  0
LINE
  5
72
  8
0
  6
CONTINUOUS
 62
     6
 10
-0.0547
 20
-0.0547
 30
0.0
 11
-0.0547
 21
0.0547
 31
0.0
  0
ENDBLK
  0
ENDSEC
  0
EOF
'.
	^Text1
]

{ #category : #examples }
JunDXFParser class >> textFlush [
	"JunDXFParser textFlush"

	Text1 := nil
]

{ #category : #examples }
JunDXFParser class >> textLine [
	Text1  := '  0
SECTION
  2
ENTITIES
  0
LINE
  5
6F
  8
0
  6
CONTINUOUS
 62
     6
 10
0.0547
 20
-0.0547
 30
0.0
 11
0.0547
 21
0.0547
 31
0.0
  0
LINE
  5
70
  8
0
  6
CONTINUOUS
 62
     6
 10
-0.0547
 20
-0.0547
 30
0.0
 11
0.0547
 21
0.0547
 31
0.0
  0
LINE
  5
71
  8
0
  6
CONTINUOUS
 62
     6
 10
-0.0547
 20
0.0547
 30
0.0
 11
0.0547
 21
-0.0547
 31
0.0
  0
LINE
  5
72
  8
0
  6
CONTINUOUS
 62
     6
 10
-0.0547
 20
-0.0547
 30
0.0
 11
-0.0547
 21
0.0547
 31
0.0
  0
ENDSEC
  0
EOF
'.
	^Text1
]

{ #category : #examples }
JunDXFParser class >> textPolyline [
	Text1  := '  0
SECTION
  2
ENTITIES
  0
POLYLINE
  5
66
  8
0
 66
     1
 10
0.0
 20
0.0
 30
0.0
  0
VERTEX
  5
5DDF
  8
0
 10
-0.0306
 20
0.0305
 30
0.0
  0
VERTEX
  5
5DE0
  8
0
 10
0.0306
 20
0.0305
 30
0.0
  0
VERTEX
  5
5DE1
  8
0
 10
0.0306
 20
-0.0306
 30
0.0
  0
VERTEX
  5
5DE2
  8
0
 10
-0.0306
 20
-0.0306
 30
0.0
  0
VERTEX
  5
5DE3
  8
0
 10
-0.0306
 20
0.0305
 30
0.0
  0
SEQEND
  5
5DE4
  8
0
  0
ENDBLK
  0
ENDSEC
  0
EOF
'.
	^Text1
]

{ #category : #examples }
JunDXFParser class >> textText [
	Text1  := '  0
SECTION
  2
BLOCKS
  0
BLOCK
  0
TEXT
  5
6479
  8
RE-GRID-TICK-TXT
 10
1.0
 20
4.0
 30
0.0
 40
7.99998
  1
abcdefghijklmnopqrstuvwxyz
 50
90.0
 41
1.043755
  7
ROMANS
 72
     1
 11
1.1
 21
5.0
 31
0.0
 73
     2
  0
ENDBLK
  0
ENDSEC
  0
EOF
'.
	^Text1
]

{ #category : #copyright }
JunDXFParser class >> version [
	^'799'
]

{ #category : #graphics }
JunDXFParser >> addLayeredItem: anItem [ 
	| layerName layerItem |
	self debug: 'addLayeredItem ' , anItem key , '->' , anItem value printString.
	layerName := anItem key.
	layerItem := anItem value.
	(layerItem isCompound and: [layerItem components isEmpty])
		ifTrue: [self halt].
	(layers includesKey: layerName)
		ifFalse: [layers at: layerName put: JunOpenGL3dCompoundObject new].
	(self contained: layerItem)
		ifTrue: [(layers at: layerName)
				add: layerItem]
		ifFalse: 
			[self outside add: layerItem.
			self count: #outside.]
]

{ #category : #'parsing entities' }
JunDXFParser >> applyExtrusion: a3dPoint to: aJunObject [ 
	"answer the given object, transformed"

	| v1 ev th av rl tf |
	v1 := 0 , 0 , 1.
	ev := a3dPoint unitVector.
	av := v1 product: ev.
	rl := Jun3dLine from: Jun3dPoint zero to: av.
	th := (v1 dotProduct: ev) arcCos.
	tf := Jun3dTransformation rotate: th around: rl.
	^aJunObject transform: tf
]

{ #category : #accessing }
JunDXFParser >> circleNurbs [
	doNurbs  := true.
	^self
]

{ #category : #accessing }
JunDXFParser >> contained: anItem [ 
	| bb |
	bb := self settings at: 'box' ifAbsentPut: [nil].
	bb isNil ifTrue: [^true].
	^bb contains: anItem
]

{ #category : #counting }
JunDXFParser >> count: aSymbol [ 
	"self debug: 'count: ', aSymbol."

	(itemCount includesKey: aSymbol)
		ifFalse: [itemCount at: aSymbol put: 0].
	itemCount at: aSymbol put: (itemCount at: aSymbol)
			+ 1
]

{ #category : #accessing }
JunDXFParser >> doNurbs [
	doNurbs isNil ifTrue: [doNurbs := false].
	^doNurbs
]

{ #category : #accessing }
JunDXFParser >> dxfnames [
	^dxfNames
]

{ #category : #graphics }
JunDXFParser >> findBad [
	| rc |
	Transcript cr; show: 'Searching layers...'.
	self layers
		keysAndValuesDo: 
			[:k :v | 
			Transcript cr; show: '  ' , k.
			rc := v select: [:xx | xx origin z > 1.0].
			rc isNil ifFalse: [rc components isEmpty
					ifFalse: 
						[Transcript show: '  hit.'.
						rc inspect]]]
]

{ #category : #graphics }
JunDXFParser >> findEmpty [
	| rc |
	Transcript cr; show: 'Searching layers...'.
	self layers
		keysAndValuesDo: 
			[:k :v | 
			Transcript cr; show: '  ' , k.
			rc := v select: [:x | x isCompound and: [x components isEmpty]].
			rc isNil
				ifFalse: 
					[Transcript show: '  hit.'.
					rc inspect]]
]

{ #category : #graphics }
JunDXFParser >> findLayer: aBlock [ 
	| rc |
	Transcript cr; show: 'Searching layers...'.
	self layers
		keysAndValuesDo: 
			[:k :v | 
			Transcript cr; show: '  ' , k.
			rc := v select: aBlock.
			rc isNil
				ifFalse: 
					[Transcript show: '  hit.'.
					rc inspect]]
]

{ #category : #'initialize-release' }
JunDXFParser >> initCounts [
	itemCount := Dictionary new: 10.
	^self
]

{ #category : #'initialize-release' }
JunDXFParser >> initParser [
	layers := Dictionary new: 20.
	dxfNames := Dictionary new: 20.
	^self
]

{ #category : #'initialize-release' }
JunDXFParser >> initialize [
	self initParser.
	self initCounts.
	^self
]

{ #category : #accessing }
JunDXFParser >> layerColors [
	layerColors isNil ifTrue: [layerColors := Dictionary new: 50].
	^layerColors
]

{ #category : #accessing }
JunDXFParser >> layerColorsAt: aString [ 
	^self layerColors at: aString ifAbsent: [ColorValue blue]
]

{ #category : #accessing }
JunDXFParser >> layerNames [
	^layers keys asSortedCollection
]

{ #category : #accessing }
JunDXFParser >> layerObjects [
	^layers values
]

{ #category : #accessing }
JunDXFParser >> layers [
	^layers
]

{ #category : #parsing }
JunDXFParser >> newDxfDefinition: aString [ 
	| rc newObject blocks |
	self debug: 'newDxfDefinition: ' , aString.
	rc := false.
	definedObjects := OrderedCollection new: 10.
	blocks := Dictionary new: 4.
	blocks at: 'POLYLINE' put: #parsePOLYLINE.
	blocks at: 'LINE' put: #parseLINE.
	blocks at: 'ARC' put: #parseARC.
	blocks at: 'CIRCLE' put: #parseCIRCLE.
	self flag: #TT_TODO. "Add support for parsing TEXT entities (needed for ASTM)"

	definedObjects := OrderedCollection new: 10.
	[dataString = 'ENDBLK']
		whileFalse: 
			[rc := false.
			self nextPair.
			groupCode = 0
				ifTrue: 
					["self debug: ' in newDxfDef ' , dataKey , '->' , dataString , ' ' , mark 
					printString."
					rc := self perform: (blocks at: dataString ifAbsent: [#yourself]).
					rc = true ifTrue: [rc = true ifTrue: [definedObjects add: item value]]]].
	self debug: 'newDxfDefinition now adding: ' , aString , '  for: ' , definedObjects printString.
	self count: #names.
	newObject := JunOpenGL3dCompoundObject components: definedObjects.
	dxfNames at: aString put: newObject.
	^true
]

{ #category : #accessing }
JunDXFParser >> outside [
	outside isNil ifTrue: [outside := OrderedCollection new: 50].
	^outside
]

{ #category : #defaults }
JunDXFParser >> paintColor: anInteger [ 
	| index |
	index := anInteger.
	(index between: 1 and: 7)
		ifFalse: [index := 1].
	^self class colorAt: index
]

{ #category : #parsing }
JunDXFParser >> parse [
	| blocks rc |
	blocks := Dictionary new: 5.
	blocks at: 'HEADER' put: #parseHeader.
	blocks at: 'TABLES' put: #parseTables.
	blocks at: 'BLOCKS' put: #parseBlocks.
	blocks at: 'CLASSES' put: #parseClasses.
	blocks at: 'ENTITIES' put: #parseEntities.
	happy := false.
	
	[self nextPair.
	dataString = 'EOF']
		whileFalse: 
			[self debug: 'parse: ' , dataKey , '->' , dataString.
			groupCode = 0 ifFalse: [^failBlock value: 'invalid groupcode (not 0)'].
			dataString = 'SECTION' ifFalse: [^failBlock value: 'invalid section string (not SECTION)'].
			self nextPair.
			groupCode = 2 ifFalse: [^failBlock value: 'invalid section groupcode (not 2)'].
			rc := self perform: (blocks at: dataString ifAbsent: [#yourself]).
			rc = true ifTrue: [self count: #sections]].
	self showCounts.
	self setLayerNames.
	self updateLayerColors.
	happy := true.
	^self
]

{ #category : #'parsing entities' }
JunDXFParser >> parse3DFACE [
	| markName vertexes x1 y1 z1 x2 y2 z2 x3 y3 z3 x4 y4 z4 newItem isQuad |
	self debug: 'parse3DFACE'.
	markName := mark printString.
	layer := ''.
	x1 := y1 := z1 := 0.0.
	x2 := y2 := z2 := 0.0.
	x3 := y3 := z3 := 0.0.
	x4 := y4 := z4 := 0.0.
	isQuad := false.
	vertexes := OrderedCollection new: 4.
	
	[self nextPair.
	dataString = 'EOF' 
		ifTrue: 
			[self debug: 'parse3DFACE at eof -returning nil'.
			^nil].
	groupCode = 0] 
			whileFalse: 
				[groupCode = 10 ifTrue: [x1 := dataNumber].
				groupCode = 20 ifTrue: [y1 := dataNumber].
				groupCode = 30 ifTrue: [z1 := dataNumber].
				groupCode = 11 ifTrue: [x2 := dataNumber].
				groupCode = 21 ifTrue: [y2 := dataNumber].
				groupCode = 31 ifTrue: [z2 := dataNumber].
				groupCode = 12 ifTrue: [x3 := dataNumber].
				groupCode = 22 ifTrue: [y3 := dataNumber].
				groupCode = 32 ifTrue: [z3 := dataNumber].
				groupCode = 13 
					ifTrue: 
						[isQuad := true.
						x4 := dataNumber].
				groupCode = 23 
					ifTrue: 
						[isQuad := true.
						y4 := dataNumber].
				groupCode = 33 
					ifTrue: 
						[isQuad := true.
						z4 := dataNumber]].
	vertexes
		add: x1 , y1 , z1;
		add: x2 , y2 , z2;
		add: x3 , y3 , z3.
	isQuad ifTrue: [vertexes add: x4 , y4 , z4].
	newItem := JunOpenGL3dPolygon vertexes: vertexes.
	vertexes size timesRepeat: [self count: #vertex].
	self unNextPair.
	newItem name: markName.
	item := layer -> newItem.
	self count: #polygon.
	self debug: 'parsePolygon returning happy ' , vertexes first printString.
	^true
]

{ #category : #'parsing entities' }
JunDXFParser >> parseARC [
	"answer a Polyline"

	| x y z r a1 a2 points newItem markName |
	x := y := z := 0.0.
	self debug: 'parseARC  ' , dataKey , ' -> ' , dataString , ' ' , mark printString.
	markName := mark printString.
	
	[self nextPair.
	dataString = 'EOF'
		ifTrue: 
			["self debug: ' in parseARC after nextPair ', dataKey, ' -> ', dataString, ' ', mark 
			printString."
			self debug: 'parseARC at eof -returning nil'.
			^nil].
	groupCode = 0]
		whileFalse: 
			["self debug: ' in parseCircle: ', dataKey, ' -> ', dataString."
			groupCode = 8 ifTrue: [layer := dataString].
			groupCode = 10 ifTrue: [x := dataNumber].
			groupCode = 20 ifTrue: [y := dataNumber].
			groupCode = 30 ifTrue: [z := dataNumber].
			groupCode = 40 ifTrue: [r := dataNumber].
			groupCode = 50 ifTrue: [a1 := dataNumber].
			groupCode = 51 ifTrue: [a2 := dataNumber]].
	self debug: 'parseARC got ' , x printString , ' ' , y printString , ' ' , z printString , '  angle1: ' , a1 printString.
	points := self class
				calculateARC: x , y , z
				radius: r
				from: a1
				to: a2.
	newItem := JunOpenGL3dPolyline vertexes: points.
	self unNextPair.
	newItem name: markName.
	item := layer -> newItem.
	self count: #arc.
	^true
]

{ #category : #parsing }
JunDXFParser >> parseBlock [
	self debug: 'parseBlock'.
	[groupCode = 0 and: [dataString = 'ENDBLK']]
		whileFalse: 
			[self nextPair.
			((groupCode = 2 | groupCode = 3) and: [dataString first ~= $$])
				ifTrue: [self newDxfDefinition: dataString]].
	^true
]

{ #category : #parsing }
JunDXFParser >> parseBlocks [
	self debug: 'parseBlocks'.
	[groupCode = 0 and: [dataString = 'ENDSEC']]
		whileFalse: 
			[self nextPair.
			(groupCode = 0 and: [dataString = 'BLOCK'])
				ifTrue: [self parseBlock]].
	^true
]

{ #category : #'parsing entities' }
JunDXFParser >> parseCIRCLE [
	"answer a Jun3DPoint"

	| x y z weights controls knots r newItem pi pi2 delta angle1 angle2 points xx nx ny markName |
	x := y := z := 0.0.
	self debug: 'parseCIRCLE ' , dataKey , ' -> ' , dataString , ' ' , mark printString.
	weights := #(1.0 0.707107 1.0 0.707107 1.0 0.707107 1.0 0.707107 1.0).
	knots := #(0 0 0 1 1 2 2 3 3 4 4 4).
	controls := OrderedCollection new: 9.
	markName := mark printString.
	
	[self nextPair.
	dataString = 'EOF'
		ifTrue: 
			["self debug: ' in parseCIRCLE after nextPair ', dataKey, ' -> ', dataString, ' ', mark 
			printString."
			self debug: 'parseVERTEX at eof -returning nil'.
			^nil].
	groupCode = 0]
		whileFalse: 
			["self debug: ' in parseCircle: ', dataKey, ' -> ', dataString."
			groupCode = 8 ifTrue: [layer := dataString].
			groupCode = 10 ifTrue: [x := dataNumber].
			groupCode = 20 ifTrue: [y := dataNumber].
			groupCode = 30 ifTrue: [z := dataNumber].
			groupCode = 40 ifTrue: [r := dataNumber]].
	self debug: 'parseCIRCLE got ' , x printString , ' ' , y printString , ' ' , z printString.
	self doNurbs
		ifTrue: 
			[controls add: x , (y - r) , 0.
			controls add: x + r , (y - r) , 0.
			controls add: x + r , y , 0.
			controls add: x + r , (y + r) , 0.
			controls add: x , (y + r) , 0.
			controls add: x - r , (y + r) , 0.
			controls add: x - r , y , 0.
			controls add: x - r , (y - r) , 0.
			controls add: x , (y - r) , 0.
			newItem := JunOpenGL3dNurbsCurve
						controlPoints: controls
						weights: weights
						knotVector: knots]
		ifFalse: 
			[pi := Float pi.
			pi2 := Float pi * 2.
			delta := pi / 16.0.
			angle1 := 0.0.
			angle2 := pi2.
			points := OrderedCollection new: 16.
			xx := angle1.
			[xx < (angle2 + delta)]
				whileTrue: 
					[nx := x + (xx cos * r).
					ny := y + (xx sin * r).
					points add: nx , ny , 0.
					xx := xx + delta].
			newItem := (JunOpenGL3dPolyline vertexes: points)].
	self unNextPair.
	newItem name: markName.
	item := layer -> newItem.
	self count: #circle.
	^true
]

{ #category : #parsing }
JunDXFParser >> parseClasses [
	[groupCode = 0 and: [dataString = 'ENDSEC']]
		whileFalse: [self nextPair].
	^true
]

{ #category : #'parsing entities' }
JunDXFParser >> parseENTITYCOLOR [
	"$CECOLOR indicates... how to treat color
		0 - BYBLOCK
		256 - BYLAYER"

	| newItem nn |
	self debug: 'parseENTITYCOLOR' , dataKey , '->' , dataString.
	
	[self nextPair.
	dataString = 'EOF'
		ifTrue: 
			["self debug: ' in parseENTITYCOLOR after nextPair ', dataKey, ' -> ', dataString, ' ', mark 
			printString."
			self debug: 'parseENTITYCOLOR at eof -returning nil'.
			^nil].
	groupCode = 0 or: [groupCode = 9]]
		whileFalse: 
			[groupCode = 62 ifTrue: [nn := dataNumber]].
	self debug: 'parseENTITYCOLOR got ' , nn printString.
	newItem := nn.
	item := newItem.
	self unNextPair.
	^true
]

{ #category : #'parsing entities' }
JunDXFParser >> parseEXTMAX [
	"answer a 3d point"

	self debug: 'parseEXTMAX ' , dataKey , '->' , dataString.
	self parseEXTMINMAX.
	self debug: 'parseEXTMAX got ' , item printString.
	self settings at: 'EXTMAX' put: item.
	self count: #settings.
	^true
]

{ #category : #'parsing entities' }
JunDXFParser >> parseEXTMIN [
	"answer a 3d point"

	self debug: 'parseEXTMIN ' , dataKey , '->' , dataString.
	self parseEXTMINMAX.
	self debug: 'parseEXTMIN got ' , item printString.
	self settings at: 'EXTMIN' put: item.
	self count: #settings.
	^true
]

{ #category : #'parsing entities' }
JunDXFParser >> parseEXTMINMAX [
	"answer a 3d point"

	| x y z newItem |
	x := y := z := 0.0.
	self debug: 'parseEXTMINMAX' , dataKey , '->' , dataString.
	
	[self nextPair.
	dataString = 'EOF'
		ifTrue: 
			["self debug: ' in parseEXTMINMAX after nextPair ', dataKey, ' -> ', dataString, ' ', mark 
			printString."
			self debug: 'parseEXTMINMAX at eof -returning nil'.
			^nil].
	groupCode = 0 or: [groupCode = 9]]
		whileFalse: 
			[groupCode = 10 ifTrue: [x := dataNumber].
			groupCode = 20 ifTrue: [y := dataNumber].
			groupCode = 30 ifTrue: [z := dataNumber]].
	self debug: 'parseEXTMINMAX got ' , x printString , ' ' , y printString , ' ' , z printString.
	newItem := x , y , z.
	item := newItem.
	self unNextPair.
	^true
]

{ #category : #parsing }
JunDXFParser >> parseEntities [
	| rc blocks |
	self debug: 'parseEntities '.
	blocks := Dictionary new: 6.
	blocks at: 'POLYLINE' put: #parsePOLYLINE.
	blocks at: 'LINE' put: #parseLINE.
	blocks at: 'CIRCLE' put: #parseCIRCLE.
	blocks at: 'ARC' put: #parseARC.
	blocks at: 'INSERT' put: #parseINSERT.
	blocks at: '3DFACE' put: #parse3DFACE.
	definedObjects := OrderedCollection new: 10.
	"should have parse EXTMIN and EXTMAX by now, so calculate boundingBox"
	self setBoundingBox.
	[dataString = 'ENDSEC'] whileFalse: 
			[rc := false.
			self nextPair.
			groupCode = 0 
				ifTrue: 
					["self debug: ' in parseEntities ' , dataKey , '->' , dataString , ' ' , mark 
					printString."

					rc := self perform: (blocks at: dataString ifAbsent: [#yourself]).
					rc = true 
						ifTrue: 
							[self addLayeredItem: item.
							self count: #entities]]].
	self nextPair.
	^true
]

{ #category : #parsing }
JunDXFParser >> parseHeader [
	| blocks |
	blocks := Dictionary new: 5.
	blocks at: '$EXTMIN' put: #parseEXTMIN.
	blocks at: '$EXTMAX' put: #parseEXTMAX.
	blocks at: '$CECOLOR' put: #parseENTITYCOLOR.

	[groupCode = 0 and: [dataString = 'ENDSEC']]
		whileFalse: 
			[groupCode = 9 ifTrue: [self perform: (blocks at: dataString ifAbsent: [#yourself])].
			self nextPair].
	^true
]

{ #category : #'parsing entities' }
JunDXFParser >> parseINSERT [
	"answer a Polyline"

	| x y z xScale yScale zScale angle extrudeX extrudeY extrudeZ defName newItem markName |
	x := y := z := 0.0.
	extrudeX := extrudeY := extrudeZ := 0.
	xScale := yScale := zScale := 1.0.
	self debug: 'parseINSERT  ' , dataKey , ' -> ' , dataString , ' ' , mark printString.
	angle := 0.
	markName := mark printString.
	
	[self nextPair.
	dataString = 'EOF'
		ifTrue: 
			["self debug: ' in parseINSERT after nextPair ', dataKey, ' -> ', dataString, ' ', mark 
			printString."
			self debug: 'parseINSERT at eof -returning nil'.
			^nil].
	groupCode = 0]
		whileFalse: 
			["self debug: ' in parseINSERT ', dataKey, ' -> ', dataString."
			groupCode = 2 ifTrue: [defName := dataString].
			groupCode = 8 ifTrue: [layer := dataString].
			groupCode = 10 ifTrue: [x := dataNumber].
			groupCode = 20 ifTrue: [y := dataNumber].
			groupCode = 30 ifTrue: [z := dataNumber].
			groupCode = 41 ifTrue: [xScale := dataNumber].
			groupCode = 42 ifTrue: [yScale := dataNumber].
			groupCode = 43 ifTrue: [zScale := dataNumber].
			groupCode = 50 ifTrue: [angle := dataNumber]].
	self debug: 'parseINSERT got ' , x printString , ' ' , y printString , ' ' , z printString , '  angle: ' , angle printString.
	(dxfNames includesKey: defName)
		ifFalse: [^failBlock value: 'parseINSERT missing definition name: ' , defName].
	newItem := dxfNames at: defName.
	newItem := newItem scaledBy: xScale , yScale , zScale.
	angle = 0 ifFalse: [newItem := newItem rotatedBy: (JunAngle fromDeg: angle)].
	newItem := newItem translatedBy: x , y , z.
	(extrudeX ~= 0 or: [extrudeY ~= 0 or: [extrudeZ ~= 0]])
		ifTrue: [newItem := self applyExtrusion: extrudeX , extrudeY , extrudeZ to: newItem].
	self unNextPair.
	newItem name: markName.
	item := layer -> newItem.
	self count: #insert.
	^true
]

{ #category : #'parsing entities' }
JunDXFParser >> parseLAYER [
	"answer a color for this layer"

	| color name |
	color := 0.
	self debug: 'parseLAYER'.
	
	[self nextPair.
	dataString = 'EOF'
		ifTrue: 
			[self debug: 'parseLAYER at eof -returning nil'.
			^nil].
	groupCode = 0]
		whileFalse: 
			[groupCode = 62 ifTrue: [color := dataNumber].
			groupCode = 2 ifTrue: [name := dataString]].
	self setLayerColor: name to: color.
	self count: #layers.
	item := name -> color.
	self unNextPair.
	^true
]

{ #category : #'parsing entities' }
JunDXFParser >> parseLINE [
	"answer an association of point1 -> point2"
	"todo: 
	line style 
	line thickness..."

	| x y z x2 y2 z2 color newItem markName |
	x := y := z := 0.0.
	x2 := y2 := z2 := 0.0.
	self debug: 'parseLINE ', dataKey, '->', dataString.
	color := 0.
	markName := mark printString.
	
	[self nextPair.
	"self debug: '  in parseLINE after nextPair ', dataKey, ' -> ', dataString, ' ', mark printString."
	dataString = 'EOF'
		ifTrue: 
			[self debug: 'parseLINE at eof -returning nil'.
			^nil].
	groupCode = 0]
		whileFalse: 
			[
			groupCode = 62 ifTrue: [color := dataNumber].
			groupCode = 8 ifTrue: [layer := dataString].
			groupCode = 10 ifTrue: [x := dataNumber].
			groupCode = 20 ifTrue: [y := dataNumber].
			groupCode = 30 ifTrue: [z := dataNumber].
			groupCode = 11 ifTrue: [x2 := dataNumber].
			groupCode = 21 ifTrue: [y2 := dataNumber].
			groupCode = 31 ifTrue: [z2 := dataNumber]].
	self debug: 'parseLINE got ', x printString, ' ', y printString, ' ', z printString.
	newItem := JunOpenGL3dPolyline vertexes: (Array with: x , y , z with: x2 , y2 , z2).
	(color > 0) ifTrue:[ newItem paint: (self paintColor: color)].
	self unNextPair.
	newItem name: markName.
	item := layer -> newItem.
	self count: #line.
	^true
]

{ #category : #parsing }
JunDXFParser >> parseOld [
	
	[self nextPair.
	dataString = 'EOF']
		whileFalse: 
			[
			self debug: 'parse: ', dataKey, '->', dataString.
			groupCode = 0 ifFalse: [^failBlock value: 'invalid groupcode (not 0)'].
			dataString = 'SECTION' ifFalse: [^failBlock value: 'invalid section string (not SECTION)'].
			self nextPair.
			groupCode = 2 ifFalse: [^failBlock value: 'invalid section groupcode (not 2)'].
			dataString = 'HEADER' ifTrue: [self parseHeader].
			dataString = 'TABLES' ifTrue: [self parseTables].
			dataString = 'BLOCKS' ifTrue: [self parseBlocks].
			dataString = 'CLASSES' ifTrue: [self parseClasses].
			dataString = 'ENTITIES' ifTrue: [self parseEntities]].
	self showCounts.
	^self
]

{ #category : #'parsing entities' }
JunDXFParser >> parsePOLYLINE [
	"	polyline := JunOpenGL3dPolyline vertexes: (Array 
	with: 0.0d , 0.0d , 1.0d 
	with: 1.0d , 0.0d , 1.0d 
	with: 1.0d , 1.0d , 1.0d 
	with: 0.0d , 1.0d , 1.0d). 
	polyline name: 'example'. 
	polyline paint: ColorValue gray. 
	polyline alpha: 0.75. 
	polyline halftone: 0.3."

	| vertexes rc isClosed newItem extrudeX extrudeY extrudeZ markName |
	self debug: 'parsePOLYLINE'.
	markName := mark printString.
	isClosed := false.
	rc := false.
	layer := ''.
	vertexes := OrderedCollection new: 10.
	extrudeX := extrudeY := extrudeZ := 0.
	self nextPair.
	[dataString = 'SEQEND' or: [dataString = 'EOF']]
		whileFalse: 
			[rc := false.
			groupCode = 8 ifTrue: ["self debug: 'inside parsePolyline: ' , groupCode printString , ': ' , dataString."
				layer := dataString].
			groupCode = 70 ifTrue: [isClosed := (dataNumber bitAt: 1)
							= 1].
			groupCode = 210 ifTrue: [extrudeX := dataNumber].
			groupCode = 220 ifTrue: [extrudeY := dataNumber].
			groupCode = 230 ifTrue: [extrudeZ := dataNumber].
			dataString = 'VERTEX'
				ifTrue: 
					[rc := self parseVERTEX.
					rc = true ifTrue: [vertexes add: item value]]
				ifFalse: [self nextPair]].
	newItem := isClosed = true
				ifTrue: [JunOpenGL3dPolylineLoop vertexes: vertexes]
				ifFalse: [JunOpenGL3dPolyline vertexes: vertexes].
	(extrudeX ~= 0 or: [extrudeY ~= 0 or: [extrudeZ ~= 0]])
		ifTrue: 
			[newItem := self applyExtrusion: extrudeX , extrudeY , extrudeZ to: newItem].
	newItem name: markName.
	item := layer -> newItem.
	self count: #polyline.
	self debug: 'parsePolyline returning happy ' , vertexes first printString.
	^true
]

{ #category : #parsing }
JunDXFParser >> parseTables [
	| blocks |
	self debug: 'parseEntities '.
	blocks := Dictionary new: 5.
	blocks at: 'LAYER' put: #parseLAYER.
	[dataString = 'ENDSEC']
		whileFalse: 
			[self nextPair.
			groupCode = 0 ifTrue: ["self debug: ' in parseTables ' , dataKey , '->' , dataString , ' ' , mark 
				printString."
				self perform: (blocks at: dataString ifAbsent: [#yourself])]].
	^true
]

{ #category : #'parsing entities' }
JunDXFParser >> parseVERTEX [
	"answer a Jun3DPoint"

	| x y z |
	x := y := z := 0.0.
	self debug: 'parseVERTEX'.
	[self nextPair.
	dataString = 'EOF' ifTrue: [self debug: 'parseVERTEX at eof -returning nil'.
			^nil].
	groupCode = 0]
		whileFalse: [
			groupCode = 10 ifTrue: [x := dataNumber].
			groupCode = 20 ifTrue: [y := dataNumber].
			groupCode = 30 ifTrue: [z := dataNumber].
			groupCode = 8 ifTrue:[layer := dataString].
		].
	item := layer -> (x, y, z).
	self count: #vertex.
	^true
]

{ #category : #parsing }
JunDXFParser >> parsedOk [
	^happy = true
]

{ #category : #parsing }
JunDXFParser >> reparse [
	self resetScanner.
	self initialize.
	self parse.
	^self
]

{ #category : #graphics }
JunDXFParser >> setBoundingBox [
	| b1 b2 |
	self debug: 'setBoundingBox '.
	b1 := self settings at: 'EXTMIN' ifAbsentPut: [nil].
	b2 := self settings at: 'EXTMAX' ifAbsentPut: [nil].
	self settings at: 'box' put: nil.
	(b1 notNil and: [b2 notNil])
		ifTrue: [self settings at: 'box' put: (Jun3dBoundingBox origin: b1 corner: b2)]
]

{ #category : #accessing }
JunDXFParser >> setLayerColor: aName to: anInteger [ 
	self layerColors at: aName put: (self class colorAt: anInteger)
]

{ #category : #graphics }
JunDXFParser >> setLayerNames [
	self debug: 'setLayerNames '.
	self layers keysAndValuesDo: [:name :obs | obs name: name].
	^self
]

{ #category : #accessing }
JunDXFParser >> settings [
	settings isNil ifTrue: [settings := Dictionary new: 10].
	^settings
]

{ #category : #graphics }
JunDXFParser >> show [
	| ob |
	"Transcript cr; show: 'Defined Names'.
	dxfNames
		keysAndValuesDo: 
			[:k :v | 
			Transcript cr; show: '  ' , k.
			v show]."
	Transcript cr; show: 'Layers'.
	ob := JunOpenGL3dCompoundObject components: layers values.
	"ob add: (JunOpenGL3dObject axes)."
	ob show.
	^self
]

{ #category : #graphics }
JunDXFParser >> showCAD [
	| cad |
	cad := JunCADModel new.
	cad open.
	cad openParser: self.
	^self
]

{ #category : #counting }
JunDXFParser >> showCounts [
	Transcript cr; cr; show: 'Parsed Entities'.
	itemCount keysAndValuesDo: [:key :val | Transcript cr; show: val printString , ' ' , key printString]
]

{ #category : #graphics }
JunDXFParser >> showLayers [
	Transcript cr; show: 'Layers'.
	layers
		keysAndValuesDo: 
			[:k :v | 
			Transcript cr; show: '  Layer: ' , k.
			v name: k.
			v show].
	^self
]

{ #category : #graphics }
JunDXFParser >> showNames [
	Transcript cr; show: 'Defined Names'.
	dxfNames
		keysAndValuesDo: 
			[:k :v | 
			Transcript cr; show: '  ' , k.
			v show].
	^self
]

{ #category : #graphics }
JunDXFParser >> showReal [
	| nn |
	layers
		keysAndValuesDo: 
			[:k :v | 
			v name: k.
			v paint: (self layerColors at: k ifAbsent: [ColorValue blue])].
	nn := JunOpenGL3dCompoundObject components: layers values.
	nn show
]

{ #category : #accessing }
JunDXFParser >> updateLayerColors [
	self layers keysAndValuesDo: [:layerName :junObject | junObject paint: (self layerColorsAt: layerName)]
]

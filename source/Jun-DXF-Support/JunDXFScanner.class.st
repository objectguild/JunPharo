"
Imported by VwImportClass
"
Class {
	#name : #JunDXFScanner,
	#superclass : #JunAbstractObject,
	#instVars : [
		'source',
		'mark',
		'groupCode',
		'dataKey',
		'dataString',
		'dataNumber',
		'failBlock',
		'debug',
		'lineSeparator',
		'lines'
	],
	#category : #'Jun-DXF-Support'
}

{ #category : #copyright }
JunDXFScanner class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunDXFScanner class >> example [
	"JunDXFScanner example."

	| pair scanner file stream |
	file := JunUniFileModel requestFileName.
	file isNil ifTrue: [^self].
	stream := file readStream.
	scanner := JunDXFScanner new.
	scanner on: stream.
	[(pair := scanner nextPair).
	pair key == #eof]
		whileFalse: [Transcript cr; show: pair key printString , ':	(', scanner groupCode printString, ') ', pair value printString]
]

{ #category : #examples }
JunDXFScanner class >> example2 [
	"JunDXFScanner example2."

	| pair scanner stream |
	stream := ReadStream on: '  0
SECTION
 10
1.123
 20
2.345
 0
ENDSEC'.
	scanner := JunDXFScanner new.
	scanner on: stream.
	[(pair := scanner nextPair).
	pair key == #eof]
		whileFalse: [Transcript cr; show: pair key printString , ':	(', scanner groupCode printString, ') ', pair value printString].
	^scanner
]

{ #category : #'instance creation' }
JunDXFScanner class >> new [
	^(super new)
		initScanner;
		yourself
]

{ #category : #'instance creation' }
JunDXFScanner class >> on: aFilename [ 
	"JunDXFScanner on: 'd:\data\dxf\awk\tp1.dxf'."

	| scanner stream |
	stream := aFilename asFilename readStream.
	scanner := JunDXFScanner new.
	scanner on: stream.
	^scanner
]

{ #category : #'instance creation' }
JunDXFScanner class >> onSmart: aFilename [ 
	"JunDXFScanner onSmart: 'd:\data\dxf\awk\tp1.dxf'."

	| scanner |
	scanner := self on: aFilename.
	scanner findSeparator.
	^scanner
]

{ #category : #copyright }
JunDXFScanner class >> system [
	^'Jun'
]

{ #category : #copyright }
JunDXFScanner class >> version [
	^'799'
]

{ #category : #accessing }
JunDXFScanner >> cr [
	self lineSeparator: Character cr.
	^self
]

{ #category : #accessing }
JunDXFScanner >> dataKey [
	^dataKey
]

{ #category : #accessing }
JunDXFScanner >> dataKey: aString [
	dataKey := aString.
	^self
]

{ #category : #accessing }
JunDXFScanner >> dataNumber [
	^dataNumber
]

{ #category : #accessing }
JunDXFScanner >> dataString [
	^dataString
]

{ #category : #accessing }
JunDXFScanner >> dataString: aString [ 
	dataString := aString.
	^self
]

{ #category : #accessing }
JunDXFScanner >> debug [
	debug isNil ifTrue: [debug := false].
	^debug
]

{ #category : #printing }
JunDXFScanner >> debug: aString [ 
	debug = true ifTrue: [Transcript cr; show: 'l: ', lines printString, '  #: ', mark printString, '  ', aString]
]

{ #category : #accessing }
JunDXFScanner >> debugOff [
	debug := false.
	^self
]

{ #category : #accessing }
JunDXFScanner >> debugOn [
	debug := true.
	^self
]

{ #category : #accessing }
JunDXFScanner >> findSeparator [
	| separator char |
	separator := nil.
	[source atEnd not
		and: 
			[char := source next.
			char = Character lf
				ifTrue: [separator := Character lf]
				ifFalse: [char = Character cr ifTrue: [source peek = Character lf
							ifTrue: 
								[source next.
								separator := Character cr]
							ifFalse: [separator := Character cr]]].
			separator isNil]]
		whileTrue: [].
	separator notNil ifTrue: [self lineSeparator: separator].
	source position: 0.
	^self
]

{ #category : #accessing }
JunDXFScanner >> groupCode [
	^groupCode
]

{ #category : #'initialize-release' }
JunDXFScanner >> initScanner [
	| label string |
	"typeTable := self scannerTableClass initialize scannerTable.
	keywordTable := self keywordTableClass initialize keywordTable."
	lines := 0.
	failBlock := 
			[:errorMessage | 
			label := errorMessage , ' near ' , (dataString printString contractTo: 10).
			string := source upToEnd.
			string isEmpty
				ifTrue: [string := '--> end of file']
				ifFalse: [string := '--> ' , (string contractTo: 30)].
			self error: label , '\' withCRs , string]
]

{ #category : #accessing }
JunDXFScanner >> lf [
	self lineSeparator: Character lf.
	^self
]

{ #category : #accessing }
JunDXFScanner >> lineSeparator [
	lineSeparator isNil ifTrue: [lineSeparator := Character cr].
	^lineSeparator
]

{ #category : #accessing }
JunDXFScanner >> lineSeparator: aCharacter [ 
	lineSeparator := aCharacter
]

{ #category : #accessing }
JunDXFScanner >> lines [
	^lines
]

{ #category : #scanning }
JunDXFScanner >> nextPair [
	"0 - 9 String 
	10-59	Double precision 3D point 
	60-79	16-bit integer 
	90-99	32-bit integer"

	mark := source position.
	source atEnd
		ifTrue: 
			[dataKey := #eof.
			dataString := 'EOF'.
			^dataKey -> dataString].
	dataKey := source upTo: self  lineSeparator.
	lines := lines + 1.
	dataKey := dataKey select: [:x | x isDigit].
	groupCode := dataKey asNumber.
	dataString := (source upTo: self lineSeparator) trimLeft.
	lines := lines + 1.
	(groupCode > 9 and: [groupCode < 100])
		ifTrue: [dataNumber := dataString asNumber].
	^dataKey -> dataString
]

{ #category : #'initialize-release' }
JunDXFScanner >> on: inputStream [ 
	source := inputStream.
	mark := source position
]

{ #category : #'initialize-release' }
JunDXFScanner >> onSmart: inputStream [ 
	self on: inputStream.
	self findSeparator
]

{ #category : #'initialize-release' }
JunDXFScanner >> resetScanner [
	source position: 0.
	mark := source position.
	self initScanner.
	^self
]

{ #category : #scanning }
JunDXFScanner >> unNextPair [
	source position: mark.
	lines := lines - 2.
]

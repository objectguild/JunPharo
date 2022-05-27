"
Imported by VwImportClass
"
Class {
	#name : #JunLispScanner,
	#superclass : #JunAbstractObject,
	#instVars : [
		'source',
		'mark',
		'token',
		'tokenType',
		'typeTable',
		'failBlock',
		'compiler'
	],
	#category : #'Jun-Goodies-Lisp'
}

{ #category : #copyright }
JunLispScanner class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunLispScanner class >> new [
	^(super new)
		initScanner;
		yourself
]

{ #category : #copyright }
JunLispScanner class >> system [
	^'Jun'
]

{ #category : #copyright }
JunLispScanner class >> version [
	^'799'
]

{ #category : #'initialize-release' }
JunLispScanner >> initScanner [
	| label string |
	typeTable := JunLispScannerTable scannerTable.
	failBlock := 
			[:errorMessage | 
			label := errorMessage , ' near ' , (token printString contractTo: 10).
			string := source upToEnd.
			string isEmpty
				ifTrue: [string := '--> end of file']
				ifFalse: [string := '--> ' , (string contractTo: 30)].
			self error: label , '\' withCRs , string].
	Compiler isNil
		ifTrue: ["when I am a run time image"
			compiler := JunLispSmallCompiler new]
		ifFalse: [compiler := Compiler new]
]

{ #category : #scanning }
JunLispScanner >> multiChar: type [ 
	self perform: type
]

{ #category : #private }
JunLispScanner >> nextChar [
	| char |
	char := source next.
	char = Character lf ifTrue: [^Character cr].
	char = Character cr
		ifTrue: 
			[source peek = Character lf ifTrue: [source next].
			^Character cr].
	char isNil ifTrue: [^$!].
	^char
]

{ #category : #scanning }
JunLispScanner >> nextToken [
	| char |
	mark := source position.
	char := self peekChar.
	tokenType := typeTable at: char asInteger.
	[tokenType == #xDelimiter]
		whileTrue: 
			[self nextChar.
			char := self peekChar.
			tokenType := typeTable at: char asInteger].
	(tokenType at: 1)
		= $x
		ifTrue: [self multiChar: tokenType]
		ifFalse: [self singleChar: tokenType].
	^token
]

{ #category : #reading }
JunLispScanner >> numberFrom: aStream [ 
	^Number readFrom: aStream
]

{ #category : #reading }
JunLispScanner >> objectFrom: aStream [ 
	| buffer char string object |
	buffer := WriteStream on: (String new: 20).
	char := aStream next.
	
	[char := aStream next.
	char = $}] whileFalse: 
				[char == nil ifTrue: [^failBlock value: 'Syntax error unmatched ${'].
				buffer nextPut: char].
	string := buffer contents.
	Object errorSignal handle: 
			[:exception | 
			| target replacement index |
			(exception originator isKindOf: QualifiedName) 
				ifTrue: 
					[target := exception originator asString.
					replacement := exception originator path last.
					index := 1.
					
					[index := string indexOfSubCollection: target startingAt: index.
					index = 0] 
							whileFalse: 
								[string := string 
											changeFrom: index
											to: index + target size - 1
											with: replacement].
					exception restart]
				ifFalse: [exception reject]]
		do: 
			[object := compiler 
						evaluate: string
						in: nil
						receiver: nil
						notifying: nil
						ifFail: []].
	^object
]

{ #category : #'initialize-release' }
JunLispScanner >> on: inputStream [ 
	source := inputStream.
	mark := source position
]

{ #category : #private }
JunLispScanner >> peekChar [
	| char |
	char := source peek.
	char = Character lf ifTrue: [^Character cr].
	char = Character cr ifTrue: [^Character cr].
	char isNil ifTrue: [^$!].
	^char
]

{ #category : #scanning }
JunLispScanner >> singleChar: type [ 
	self nextChar.
	token := type
]

{ #category : #reading }
JunLispScanner >> stringFrom: aStream [ 
	| buffer char string |
	buffer := WriteStream on: (String new: 20).
	char := aStream next.
	char = $" ifTrue: [
		[char := aStream peek.
		char ~~ nil]
			whileTrue: 
				[char = $"
					ifTrue: 
						[aStream next.
						char := aStream peek.
						char = $" ifFalse: [^String fromString: buffer contents]].
				buffer nextPut: aStream next]].
	string := aStream upToEnd.
	string size > 100 ifTrue: [string := string copyFrom: 1 to: 100].
	^failBlock value: 'Syntax error unmatched $'''
]

{ #category : #reading }
JunLispScanner >> symbolFrom: aStream [ 
	| buffer char type |
	buffer := WriteStream on: (String new: 20).
	char := aStream peek.
	[char notNil and: [(type := typeTable at: char asInteger) == #xSymbol or: [type == #xDigit or: [type == #xSign]]]]
		whileTrue: 
			[buffer nextPut: aStream next.
			char := aStream peek].
	buffer contents = 'nil' ifTrue: [^JunLispNil null].
	^Symbol intern: buffer contents
]

{ #category : #private }
JunLispScanner >> unNextChar [
	source skip: -1
]

{ #category : #scanning }
JunLispScanner >> unNextToken [
	source position: mark
]

{ #category : #x }
JunLispScanner >> xBinary [
	^failBlock value: 'Syntax error ' , source peek printString
]

{ #category : #x }
JunLispScanner >> xBrace [
	tokenType := #object.
	token := self objectFrom: source
]

{ #category : #x }
JunLispScanner >> xComment [
	| char |
	[(char := self nextChar) = Character cr]
		whileFalse: [char == nil ifTrue: [^self nextToken]].
	^self nextToken
]

{ #category : #x }
JunLispScanner >> xDigit [
	tokenType := #number.
	token := self numberFrom: source
]

{ #category : #x }
JunLispScanner >> xDoubleQuote [
	tokenType := #string.
	token := self stringFrom: source
]

{ #category : #x }
JunLispScanner >> xSign [
	| char sign |
	sign := self nextChar.
	char := self peekChar.
	char isDigit
		ifTrue: 
			[tokenType := #number.
			token := self numberFrom: source.
			sign == $- ifTrue: [token := token negated]]
		ifFalse: 
			[self unNextChar.
			tokenType := #symbol.
			token := self symbolFrom: source]
]

{ #category : #x }
JunLispScanner >> xSymbol [
	tokenType := #symbol.
	token := self symbolFrom: source
]

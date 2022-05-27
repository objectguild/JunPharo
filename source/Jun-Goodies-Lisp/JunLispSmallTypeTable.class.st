"
Imported by VwImportClass
"
Class {
	#name : #JunLispSmallTypeTable,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'value0',
		'defaultValue',
		'letterValue',
		'digitValue',
		'separatorValue'
	],
	#classVars : [
		'TypeTable'
	],
	#category : #'Jun-Goodies-Lisp'
}

{ #category : #copyright }
JunLispSmallTypeTable class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunLispSmallTypeTable class >> system [
	^'Jun'
]

{ #category : #'table access' }
JunLispSmallTypeTable class >> typeTable [
	TypeTable isNil
		ifTrue: 
			[| newTable |
			newTable := self new: 255 withAll: #xDefault.
			newTable atAllSeparatorsPut: #xDelimiter.
			newTable atAllDigitsPut: #xDigit.
			newTable atAllLettersPut: #xLetter.
			newTable at: $_ asInteger put: #xLetter.
			'!%&*+,-/<=>?@\~' do: [:bin | newTable at: bin asInteger put: #xBinary].
			#(177 215 183 247) do: [:bin | newTable at: bin put: #xBinary].
			newTable at: $" asInteger put: #xDoubleQuote.
			newTable at: $$ asInteger put: #xDollar.
			newTable at: $' asInteger put: #xSingleQuote.
			newTable at: $# asInteger put: #literalQuote.
			newTable at: $( asInteger put: #leftParenthesis.
			newTable at: $) asInteger put: #rightParenthesis.
			newTable at: $. asInteger put: #period.
			newTable at: $: asInteger put: #colon.
			newTable at: $; asInteger put: #semicolon.
			newTable at: $[ asInteger put: #leftBracket.
			newTable at: $] asInteger put: #rightBracket.
			newTable at: $^ asInteger put: #upArrow.
			newTable at: $| asInteger put: #verticalBar.
			TypeTable := newTable].
	^TypeTable
]

{ #category : #copyright }
JunLispSmallTypeTable class >> version [
	^'799'
]

{ #category : #accessing }
JunLispSmallTypeTable >> at: index put: value [ 
	<primitive: 61>
	index isInteger ifFalse: [^super at: index put: value].
	(index >= 1 and: [index <= self basicSize])
		ifTrue: [^self improperStoreError].
	index = 0 ifTrue: [^value0 := value].
	value = (self at: index) ifTrue: [^value].
	^self improperStoreError
]

{ #category : #accessing }
JunLispSmallTypeTable >> atAllDigitsPut: value [ 
	digitValue := value.
	0 to: self size do: [:index | (Character value: index) isDigit ifTrue: [self at: index put: value]]
]

{ #category : #accessing }
JunLispSmallTypeTable >> atAllLettersPut: value [ 
	letterValue := value.
	0 to: self size do: [:index | (Character value: index) isLetter ifTrue: [self at: index put: value]]
]

{ #category : #accessing }
JunLispSmallTypeTable >> atAllPut: value [ 
	value0 := value.
	defaultValue := value.
	letterValue := value.
	digitValue := value.
	separatorValue := value.
	^super atAllPut: value
]

{ #category : #accessing }
JunLispSmallTypeTable >> atAllSeparatorsPut: value [ 
	separatorValue := value.
	0 to: self size do: [:index | (Character value: index) isSeparator ifTrue: [self at: index put: value]]
]

{ #category : #accessing }
JunLispSmallTypeTable >> atDefaultPut: value [ 
	defaultValue := value
]

{ #category : #accessing }
JunLispSmallTypeTable >> basicAt: index put: value [ 
	<primitive: 61>
	index isInteger ifFalse: [^super basicAt: index put: value].
	(index >= 1 and: [index <= self basicSize])
		ifTrue: [^self improperStoreError].
	^super subscriptBoundsError: index
]

{ #category : #'error handling' }
JunLispSmallTypeTable >> subscriptBoundsError: index [ 
	| char |
	((index between: self size + 1 and: Character maxValue)
		or: [index = 0])
		ifFalse: [^super subscriptBoundsError: index].
	index = 0 ifTrue: [^value0].
	char := Character value: index.
	char isLetter ifTrue: [^letterValue].
	char isSeparator ifTrue: [^separatorValue].
	char isDigit ifTrue: [^digitValue].
	^defaultValue
]

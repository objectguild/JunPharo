"
Imported by VwImportClass
"
Class {
	#name : #JunLispScannerTable,
	#superclass : #Array,
	#type : #variable,
	#classVars : [
		'ScanningTable'
	],
	#category : #'Jun-Goodies-Lisp'
}

{ #category : #copyright }
JunLispScannerTable class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'table access' }
JunLispScannerTable class >> scannerTable [
	ScanningTable isNil
		ifTrue: 
			[| newTable |
			newTable := self new: 256 withAll: #xBinary.
			newTable atAll: #(9 10 11 12 13 32) put: #xDelimiter.
			newTable atAll: ($0 asInteger to: $9 asInteger)
				put: #xDigit.
			newTable atAll: ($A asInteger to: $Z asInteger)
				put: #xSymbol.
			newTable atAll: ($a asInteger to: $z asInteger)
				put: #xSymbol.
			128 to: 256 do: [:i | newTable at: i put: #xSymbol].
			newTable at: $' asInteger put: #quote.
			newTable at: $" asInteger put: #xDoubleQuote.
			newTable at: ${ asInteger put: #xBrace.
			newTable at: $+ asInteger put: #xSign.
			newTable at: $- asInteger put: #xSign.
			newTable at: $< asInteger put: #xSymbol.
			newTable at: $> asInteger put: #xSymbol.
			newTable at: $= asInteger put: #xSymbol.
			newTable at: $~ asInteger put: #xSymbol.
			newTable at: $* asInteger put: #xSymbol.
			newTable at: $/ asInteger put: #xSymbol.
			newTable at: $_ asInteger put: #xSymbol.
			newTable at: $: asInteger put: #xSymbol.
			newTable at: $, asInteger put: #xSymbol.
			newTable at: $\ asInteger put: #xSymbol.
			newTable at: $% asInteger put: #xComment.
			newTable at: $( asInteger put: #leftParenthesis.
			newTable at: $) asInteger put: #rightParenthesis.
			newTable at: $[ asInteger put: #leftParenthesis.
			newTable at: $] asInteger put: #rightParenthesis.
			newTable at: $. asInteger put: #period.
			newTable at: $` asInteger put: #quote.
			newTable at: $! asInteger put: #eof.
			ScanningTable := newTable].
	^ScanningTable
]

{ #category : #copyright }
JunLispScannerTable class >> system [
	^'Jun'
]

{ #category : #copyright }
JunLispScannerTable class >> version [
	^'799'
]

{ #category : #accessing }
JunLispScannerTable >> at: index [ 
	(index isInteger and: [index between: 257 and: 65536])
		ifTrue: [(index - 1) asCharacter isLetter
				ifTrue: [^#xSymbol]
				ifFalse: [^#xBinary]]
		ifFalse: [^super at: index]
]

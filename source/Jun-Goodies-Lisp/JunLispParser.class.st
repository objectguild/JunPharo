"
Imported by VwImportClass
"
Class {
	#name : #JunLispParser,
	#superclass : #JunLispScanner,
	#instVars : [
		'prevMark',
		'prevToken',
		'prevTokenType',
		'progressValue',
		'readLimit'
	],
	#category : #'Jun-Goodies-Lisp'
}

{ #category : #copyright }
JunLispParser class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunLispParser class >> example1 [
	"JunLispParser example1."

	| list |
	list := JunLispParser parse: '(1 2 3 4 (5 6 7 8 9) 10)'.
	^list
]

{ #category : #examples }
JunLispParser class >> example2 [
	"JunLispParser example2."

	| list |
	list := JunLispParser parse: '
			(10 (1 2)
			 20 (3 4 . 100)
			 30 (5 6) . 200)
	'.
	^list
]

{ #category : #examples }
JunLispParser class >> example3 [
	"JunLispParser example3."

	| list |
	list := JunLispParser parse: '
			(PetriNet JunAoki
				(Place
					(p1 . {100@100})
					(p2 . {200@200})
					(p3 . {300@300})
					(p4 . {400@400})
					(p5 . {500@500}))
				(Transition
					(t1 . {100@100})
					(t2 . {200@200})
					(t3 . {300@300})
					(t4 . {400@400})
					(t5 . {500@500}))
				(InputFunction
					(t1 p1 p2 p3 p4 p5)
					(t2 . p4)
					(t3 . p5))
				(OutputFunction
					(t1 p1 p2 p3 p4 p5)
					(t2 . p4)
					(t3 . p5))
				(Marking {#(1 2 3 4 5)}))'.
	Transcript cr; show: list saveString.
	list := JunLispParser parse: list saveString.
	^list
]

{ #category : #examples }
JunLispParser class >> example4 [
	"JunLispParser example4."

	| list |
	list := JunLispParser parse: '(1 2 3 4 (5 6 7 ~ 8 9) 10)'.
	^list
]

{ #category : #examples }
JunLispParser class >> example5 [
	"JunLispParser example5."

	| list |
	list := JunLispParser parse: '(1 2 3 4 (5 6 7 {100@100 8 9) 10)'.	"error"
	^list
]

{ #category : #examples }
JunLispParser class >> example6 [
	"JunLispParser example6."

	| list |
	list := JunLispParser parse: '(1 2 3 4 (5 6 7 ''aaaaa 8 9) 10)'.	"error"
	^list
]

{ #category : #examples }
JunLispParser class >> example7 [
	"JunLispParser example7."

	| list |
	list := JunLispParser parse: ' `(`(1 2 `3) . `4) '.	"`(`(1 2 `3) . `4) -> (quote ((quote (1 2 (quote 3))) quote 4))"
	^list
]

{ #category : #examples }
JunLispParser class >> example8 [
	"JunLispParser example8."

	| parser progress list |
	parser := JunLispParser new.
	progress := JunProgress new.
	parser
		compute: 
			[:value | 
			progress value: value.
			Transcript cr; show: value printString].
	progress message: (#jun_parsing___ >> 'parsing...') asString.
	progress do: [list := parser parse: '
			(PetriNet JunAoki
				(Place
					(p1 . {100@100})
					(p2 . {200@200})
					(p3 . {300@300})
					(p4 . {400@400})
					(p5 . {500@500}))
				(Transition
					(t1 . {100@100})
					(t2 . {200@200})
					(t3 . {300@300})
					(t4 . {400@400})
					(t5 . {500@500}))
				(InputFunction
					(t1 p1 p2 p3 p4 p5)
					(t2 . p4)
					(t3 . p5))
				(OutputFunction
					(t1 p1 p2 p3 p4 p5)
					(t2 . p4)
					(t3 . p5))
				(Marking {#(1 2 3 4 5)}))' readStream].
	Transcript cr; show: list saveString.
	list := JunLispParser parse: list saveString.
	^list
]

{ #category : #private }
JunLispParser class >> makeStream: aStream [ 
	| stream |
	((aStream isKindOf: String)
		or: [aStream isKindOf: Text])
		ifTrue: [stream := ReadStream on: aStream asString]
		ifFalse: [stream := aStream].
	^stream
]

{ #category : #utilities }
JunLispParser class >> parse: aStream [ 
	^self new parse: (self makeStream: aStream)
]

{ #category : #utilities }
JunLispParser class >> parse: aStream ifFail: aBlock [ 
	^self new parse: (self makeStream: aStream)
		ifFail: aBlock
]

{ #category : #copyright }
JunLispParser class >> system [
	^'Jun'
]

{ #category : #copyright }
JunLispParser class >> version [
	^'799'
]

{ #category : #progress }
JunLispParser >> compute: aBlock [ 
	(self progressValue isKindOf: ValueHolder)
		ifTrue: [self progressValue compute: aBlock]
]

{ #category : #private }
JunLispParser >> init: sourceStream ifFail: aBlock [ 
	| position |
	super on: sourceStream.
	failBlock := aBlock.
	position := sourceStream position.
	sourceStream setToEnd.
	readLimit := sourceStream position.
	sourceStream position: position
]

{ #category : #scanning }
JunLispParser >> nextToken [
	prevMark := mark.
	prevToken := token.
	prevTokenType := tokenType.
	token := super nextToken.
	self progress: source position / readLimit.
	^token
]

{ #category : #parsing }
JunLispParser >> parse: sourceStream [ 
	| label string |
	^self parse: sourceStream
		ifFail: 
			[:errorMessage | 
			label := errorMessage , ' near ' , (token printString contractTo: 20).
			string := source upToEnd.
			string isEmpty
				ifTrue: [string := '--> end of file']
				ifFalse: [string := '--> ' , (string contractTo: 30)].
			self error: label , '\' withCRs , string.
			^JunLispNil null]
]

{ #category : #parsing }
JunLispParser >> parse: sourceStream ifFail: aBlock [ 
	| result |
	self init: sourceStream ifFail: aBlock.
	result := self scan.
	^result
]

{ #category : #progress }
JunLispParser >> progress [
	^self progressValue value
]

{ #category : #progress }
JunLispParser >> progress: normalizedNumber [ 
	(0 <= normalizedNumber and: [normalizedNumber <= 1])
		ifTrue: 
			[| truncatedValue |
			truncatedValue := normalizedNumber roundTo: 0.005.
			self progressValue value = truncatedValue ifFalse: [self progressValue value: truncatedValue]]
]

{ #category : #progress }
JunLispParser >> progressValue [
	progressValue isNil ifTrue: [progressValue := ValueHolder with: 0].
	^progressValue
]

{ #category : #progress }
JunLispParser >> progressValue: aValueHolder [ 
	progressValue := aValueHolder
]

{ #category : #'scan and parse' }
JunLispParser >> scan [
	source atEnd ifTrue: [^JunLispCons null].
	^self scanList
]

{ #category : #'scan and parse' }
JunLispParser >> scanList [
	| expression |
	self nextToken.
	tokenType == #eof ifTrue: [^JunLispCons null].
	tokenType == #number ifTrue: [^token].
	tokenType == #string ifTrue: [^token].
	tokenType == #object ifTrue: [^token].
	tokenType == #symbol ifTrue: [^token].
	tokenType == #quote
		ifTrue: 
			[expression := JunLispCons head: self scanList tail: JunLispCons null.
			^JunLispCons head: #quote tail: expression].
	tokenType == #leftParenthesis ifTrue: [^self scanListAux].
	^failBlock value: 'Syntax error'
]

{ #category : #'scan and parse' }
JunLispParser >> scanListAux [
	| cdr |
	self nextToken.
	tokenType == #eof ifTrue: [^JunLispCons null].
	tokenType == #rightParenthesis ifTrue: [^JunLispCons null].
	tokenType == #leftParenthesis ifTrue: [^JunLispCons head: self scanListAux tail: self scanListAux].
	tokenType == #number ifTrue: [^JunLispCons head: token tail: self scanListAux].
	tokenType == #string ifTrue: [^JunLispCons head: token tail: self scanListAux].
	tokenType == #object ifTrue: [^JunLispCons head: token tail: self scanListAux].
	tokenType == #symbol ifTrue: [^JunLispCons head: token tail: self scanListAux].
	tokenType == #period
		ifTrue: 
			[cdr := self scanList.
			self nextToken.
			tokenType == #rightParenthesis
				ifTrue: [^cdr]
				ifFalse: [^failBlock value: 'Syntax error']].
	tokenType == #quote
		ifTrue: 
			[cdr := JunLispCons head: self scanList tail: JunLispCons null.
			cdr := JunLispCons head: #quote tail: cdr.
			^JunLispCons head: cdr tail: self scanListAux].
	self unNextToken.
	^failBlock value: 'Syntax error'
]

{ #category : #scanning }
JunLispParser >> unNextToken [
	super unNextToken.
	mark := prevMark.
	token := prevToken.
	tokenType := prevTokenType
]

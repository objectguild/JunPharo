"
Imported by VwImportClass
"
Class {
	#name : #JunLispInterpreter,
	#superclass : #JunApplicationModel,
	#instVars : [
		'lispTable',
		'bindStack',
		'failBlock',
		'textValue',
		'textCollector',
		'levelNumber',
		'spySymbols'
	],
	#classVars : [
		'QuestionMenu'
	],
	#category : #'Jun-Goodies-Lisp'
}

{ #category : #copyright }
JunLispInterpreter class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'public access' }
JunLispInterpreter class >> evaluate: sExpression [ 
	^self new evaluateTopLevel: sExpression ifFail: [:errorMessage | self error: errorMessage]
]

{ #category : #'public access' }
JunLispInterpreter class >> evaluate: sExpression ifFail: aBlock [ 
	^self new evaluateTopLevel: sExpression ifFail: aBlock
]

{ #category : #'public access' }
JunLispInterpreter class >> evaluateFrom: aStream [ 
	^self new evaluateTopLevel: (JunLispParser parse: aStream)
		ifFail: [:errorMessage | self error: errorMessage]
]

{ #category : #'public access' }
JunLispInterpreter class >> evaluateFrom: aStream ifFail: aBlock [ 
	^self new evaluateTopLevel: (JunLispCons parse: aStream ifFail: aBlock)
		ifFail: aBlock
]

{ #category : #examples }
JunLispInterpreter class >> example [
	"JunLispInterpreter example."

	JunLispInterpreter open
]

{ #category : #examples }
JunLispInterpreter class >> example01 [
	"JunLispInterpreter example01."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	nil

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example02 [
	"JunLispInterpreter example02."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	123

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example03 [
	"JunLispInterpreter example03."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	"abc"

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example04 [
	"JunLispInterpreter example04."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(cons 3 4)

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example05 [
	"JunLispInterpreter example05."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(quote (3 4))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example06 [
	"JunLispInterpreter example06."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(car (quote (3 4)))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example07 [
	"JunLispInterpreter example07."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(cdr (quote (3 4)))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example08 [
	"JunLispInterpreter example08."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(cons (car `(1 2 3)) `(3 4))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example09 [
	"JunLispInterpreter example09."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(+ 1 2 3 4 5 6 7 8 9 10)

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example10 [
	"JunLispInterpreter example10."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(progn
		(setq x 100)
		(setq y 200 z 300)
		(+ x y z))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example11 [
	"JunLispInterpreter example11."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(progn
		(defun plus (x y) (+ x y))
		(plus 3 4))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example12 [
	"JunLispInterpreter example12."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(progn
		(defun concat (x y) 
			(cond
				((atom x) y)
				(t (cons
						(car x)
						(concat (cdr x) y)))))
		(concat `(1 2 3) `(4 5)))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example13 [
	"JunLispInterpreter example13."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(do
		(image gc point)
		(setq image {Image fromUser})
		(setq gc {ScheduledControllers activeController view graphicsContext})
		(setq point {50@50})
		(send image `displayOn:at: gc point))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example14 [
	"JunLispInterpreter example14."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(progn
		(defun plus nlambda (x) (plus1 x))
		(defun plus1 lambda (x)
			(cond
				((null x) 0)
				(t (+ (car x) (plus1 (cdr x))))))
		(plus 1 2 3 4 5 6 7 8 9 10))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example15 [
	"JunLispInterpreter example15."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	((lambda (x y) (cons x (cons y nil))) 3 4)

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example16 [
	"JunLispInterpreter example16."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	((nlambda (x) x) 1 2 3 4 5 6 7 8 9 10)

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example17 [
	"JunLispInterpreter example17."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(progn
		(setq x 100)
		(setq y 200)
		(do
			(x y)
			(setq x 10000)
			(setq y 20000)
			(send {Transcript} `cr)
			(send {Transcript} `show: (send x `printString))
			(send {Transcript} `cr)
			(send {Transcript} `show: (send y `printString)))
		(send {Transcript} `cr)
		(send {Transcript} `show: (send x `printString))
		(send {Transcript} `cr)
		(send {Transcript} `show: (send y `printString)))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example18 [
	"JunLispInterpreter example18."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(do
		(count)
		(setq count 1)
		(while
			(<= count 100)
			do
			(send {Transcript} `cr)
			(send {Transcript} `show: (send count `printString))
			(setq count (+ count 1))))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example19 [
	"JunLispInterpreter example18."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(do
		(count)
		(setq count 1)
		(repeat
			(send {Transcript} `cr)
			(send {Transcript} `show: (send count `printString))
			(setq count (+ count 1))
			until
			(<= count 100)))

	'.
	^aList
]

{ #category : #examples }
JunLispInterpreter class >> example20 [
	"JunLispInterpreter example20."

	| aList |
	aList := JunLispInterpreter evaluateFrom: '

	(progn
		(if
			(= (send {Dialog} `confirm: "Are you happy?") {true})
			then
			(send {Transcript} `cr)
			(send {Transcript} `show: "yes")
			else 
			(send {Transcript} `cr)
			(send {Transcript} `show: "no")))

	'.
	^aList
]

{ #category : #'class initialization' }
JunLispInterpreter class >> flushMenus [
	"JunLispInterpreter flushMenus"

	QuestionMenu := nil
]

{ #category : #'class initialization' }
JunLispInterpreter class >> initialize [
	"JunLispInterpreter initialize."

	"self install"
]

{ #category : #'class initialization' }
JunLispInterpreter class >> initializeFont [
	"JunLispInterpreter initializeFont."

	TextAttributes styleNamed: #lispDefault
		put: JunAbstractObject lispTextStyle
]

{ #category : #'class initialization' }
JunLispInterpreter class >> install [
	"JunLispInterpreter install."

	self initializeFont.
	self flushMenus
]

{ #category : #'instance creation' }
JunLispInterpreter class >> new [
	
	^super new yourself
]

{ #category : #printing }
JunLispInterpreter class >> printString: anObject [ 
	"JunLispInterpreter printString: 'string'."
	"JunLispInterpreter printString: #symbol."
	"JunLispInterpreter printString: 123."
	"JunLispInterpreter printString: 123.456."
	"JunLispInterpreter printString: 123.456e7."
	"JunLispInterpreter printString: JunLispNil null."
	"JunLispInterpreter printString: nil."

	| aStream |
	aStream := WriteStream on: (String new: 32).
	(anObject isKindOf: JunLispCons)
		ifTrue: [anObject printOn: aStream level: 0]
		ifFalse: [JunLispCons new printOn: aStream object: anObject].
	^aStream contents
]

{ #category : #copyright }
JunLispInterpreter class >> system [
	^'Jun'
]

{ #category : #copyright }
JunLispInterpreter class >> version [
	^'799'
]

{ #category : #'interface specs' }
JunLispInterpreter class >> windowSpec [
	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#('#{UI.FullSpec}' 
		#window: 
		#('#{UI.WindowSpec}' 
			#label: 
			#('#{Kernel.UserMessage}' 
				#key: #jun_Lisp 
				#defaultString: 'Lisp' ) 
			#min: #('#{Core.Point}' 350 400 ) 
			#max: #('#{Core.Point}' 0 0 ) 
			#bounds: #('#{Graphics.Rectangle}' 960 600 1410 1100 ) ) 
		#component: 
		#('#{UI.SpecCollection}' 
			#collection: #(
				#('#{UI.TextEditorSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 1 0 -1 1 -1 0.3 ) 
					#name: #textValue 
					#model: #textValue 
					#callbacksSpec: 
					#('#{UI.UIEventCallbackSubSpec}' 
						#focusOutSelector: 
						#textValueChange: 
						#valueChangeSelector: 
						#textValueChange: ) 
					#tabable: true 
					#menu: #textMenu 
					#style: #lispDefault 
					#tabRequiresControl: true ) 
				#('#{UI.ArbitraryComponentSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 1 0.3 -1 1 -1 1 ) 
					#name: #textCollectorView 
					#flags: 9 
					#component: #textCollectorView ) 
				#('#{UI.ResizingSplitterSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 -1 0.3 -1 1 1 0.3 ) 
					#name: #resizingSplitter 
					#horizontal: true 
					#minAboveSize: 60 
					#minBelowSize: 60 
					#aboveWidgets: 'textValue' 
					#belowWidgets: 'textCollectorView' ) ) ) )
]

{ #category : #'shallow binding' }
JunLispInterpreter >> bind: symbol value: value [ 
	| saveValue assoc |
	lispTable intern: symbol.
	saveValue := lispTable getprop: symbol key: #apval.
	assoc := Association key: symbol value: saveValue.
	bindStack addLast: assoc.
	self
		putprop: symbol
		key: #apval
		value: value
]

{ #category : #'shallow binding' }
JunLispInterpreter >> bindMark [
	| assoc |
	assoc := Association key: nil value: nil.
	bindStack addLast: assoc
]

{ #category : #'menu messages' }
JunLispInterpreter >> doIt: aText from: aController [ 
	| stream result |
	stream := ReadStream on: aController selection asString.
	result := JunLispNil null.
	[stream atEnd]
		whileFalse: 
			[result := self execute: stream.
			self skipSeparators: stream].
	^result
]

{ #category : #evaluating }
JunLispInterpreter >> evaluate: sExpression [
	
	(sExpression isKindOf: JunLispList)
		ifTrue: [^self listEvaluate: sExpression].
	(sExpression isKindOf: Symbol)
		ifTrue:
			[| result apval |
			result := JunLispNil null.
			self spy: sExpression start: sExpression with: true.
			sExpression = #t
				ifTrue: [result := #t]
				ifFalse:
					[lispTable intern: sExpression.
					apval := lispTable getprop: sExpression key: #apval.
					apval isNil
						ifTrue:
							[^self fatal: (self printString: sExpression) , ' is unbound atom'].
					result := apval].
			self spy: sExpression end: result with: sExpression.
			^result].
	^sExpression
]

{ #category : #evaluating }
JunLispInterpreter >> evaluateTopLevel: sExpression [ 
	| result |
	failBlock := 
			[:errorMessage | 
			textCollector show: errorMessage; cr.
			Cursor normal show.
			^JunLispNil null].
	levelNumber := 0.
	Cursor execute showWhile: [result := self evaluate: sExpression].
	^result
]

{ #category : #evaluating }
JunLispInterpreter >> evaluateTopLevel: sExpression ifFail: aBlock [ 
	failBlock := aBlock.
	levelNumber := 0.
	^self evaluate: sExpression
]

{ #category : #executing }
JunLispInterpreter >> execute: aStream [ 
	| start list end string result |
	self skipSeparators: aStream.
	start := aStream position + 1.
	list := JunLispParser parse: aStream.
	end := aStream position.
	string := aStream contents copyFrom: start to: end.
	textCollector show: '> ' , string.
	textCollector cr.
	result := self evaluateTopLevel: list.
	textCollector show: (self printString: result).
	textCollector cr.
	^result
]

{ #category : #'func eval' }
JunLispInterpreter >> exprEval: funcBody arguList: arguList [
	
	| result expression funcName lvarList arguValues |
	result := JunLispNil null.
	expression := funcBody.
	funcName := expression head.
	self
		spy: funcName
		start: (JunLispCons head: funcName tail: arguList)
		with: true.
	expression := expression tail.
	expression := expression tail.
	lvarList := expression head.
	expression := expression tail.
	arguList length ~= lvarList length
		ifTrue:
			[^self
				fatal:
					'too few or many arguments ' , (self printString: arguList) , ' vs '
						, (self printString: lvarList) , ' for ' , funcName].
	arguValues := arguList collect: [:each | self evaluate: each].
	(arguList isEmpty not and: [(arguList = arguValues) not])
		ifTrue:
			[self
				spy: funcName
				start: (JunLispCons head: funcName tail: arguValues)
				with: false].
	self bindMark.
	lvarList
		with: arguValues
		do: [:lvar :value | self bind: lvar value: value].
	expression do: [:each | result := self evaluate: each].
	self unbind.
	self
		spy: funcName
		end: result
		with: (JunLispCons head: funcName tail: arguValues).
	^result
]

{ #category : #'error handling' }
JunLispInterpreter >> fatal: message [ 
	bindStack reverseDo: [:assoc | assoc key notNil ifTrue: [assoc value notNil
				ifTrue: [self
						putprop: assoc key
						key: #apval
						value: assoc value]
				ifFalse: [self remprop: assoc key key: #apval]]].
	^failBlock value: '*** Error: ' , message
]

{ #category : #'func eval' }
JunLispInterpreter >> fexprEval: funcBody arguList: arguList [
	
	| result expression funcName lvarList lvar |
	result := JunLispNil null.
	expression := funcBody.
	funcName := expression head.
	self
		spy: funcName
		start: (JunLispCons head: funcName tail: arguList)
		with: true.
	expression := expression tail.
	expression := expression tail.
	lvarList := expression head.
	expression := expression tail.
	lvarList length ~= 1
		ifTrue:
			[^self
				fatal:
					'too few or many arguments ' , (self printString: lvarList) , ' for '
						, (self printString: funcName)].
	self bindMark.
	lvar := lvarList head.
	self bind: lvar value: arguList.
	expression do: [:each | result := self evaluate: each].
	self unbind.
	self
		spy: funcName
		end: result
		with: (JunLispCons head: funcName tail: arguList).
	^result
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrAdd: arguList [ 
	| v a |
	v := JunLispNil null.
	arguList
		do: 
			[:each | 
			a := self evaluate: each.
			(a respondsTo: #+)
				ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a) , ' for +'].
			v = JunLispNil null
				ifTrue: [v := a]
				ifFalse: [v := v + a]].
	^v
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrCond: arguList [ 
	| result |
	arguList do: [:each | (self evaluate: each head)
			~= JunLispNil null
			ifTrue: 
				[result := JunLispNil null.
				(each tail isKindOf: JunLispCons)
					ifTrue: [each tail do: [:expr | result := self evaluate: expr]].
				^result]].
	^JunLispNil null
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrDefun: arguList [ 
	| funcName funcType |
	funcName := arguList head.
	(funcName isKindOf: Symbol)
		ifFalse: [^self fatal: 'unexpected function name ' , (self printString: funcName) , ' for defun'].
	funcType := arguList tail head.
	funcType = #lambda
		ifTrue: 
			[self
				putprop: funcName
				key: #expr
				value: arguList.
			^funcName].
	funcType = #nlambda
		ifTrue: 
			[self
				putprop: funcName
				key: #fexpr
				value: arguList.
			^funcName].
	self
		putprop: funcName
		key: #expr
		value: (JunLispCons head: funcName tail: (JunLispCons head: #lambda tail: arguList tail)).
	^funcName
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrDiv: arguList [ 
	| v a |
	v := JunLispNil null.
	arguList
		do: 
			[:each | 
			a := self evaluate: each.
			(a respondsTo: #/)
				ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a) , ' for /'].
			v = JunLispNil null
				ifTrue: [v := a]
				ifFalse: [v := v / a]].
	^v
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrDo: arguList [ 
	| locals executions result |
	locals := arguList head.
	executions := arguList tail.
	self bindMark.
	locals do: [:lvar | self bind: lvar value: JunLispNil null].
	result := JunLispNil null.
	executions do: [:each | result := self evaluate: each].
	self unbind.
	^result
]

{ #category : #'func eval' }
JunLispInterpreter >> fsubrEval: funcBody arguList: arguList [
	
	| result funcName messageSelector |
	result := JunLispNil null.
	funcName := funcBody head.
	self
		spy: funcName
		start: (JunLispCons head: funcName tail: arguList)
		with: true.
	messageSelector := funcBody tail head.
	result := self perform: messageSelector with: arguList.
	self
		spy: funcName
		end: result
		with: (JunLispCons head: funcName tail: arguList).
	^result
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrIdiv: arguList [ 
	| v a |
	v := JunLispNil null.
	arguList
		do: 
			[:each | 
			a := self evaluate: each.
			(a respondsTo: #//)
				ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a) , ' for //'].
			v = JunLispNil null
				ifTrue: [v := a]
				ifFalse: [v := v // a]].
	^v
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrIf: arguList [ 
	| predicate then list truePart falsePart bool result |
	predicate := arguList head.
	then := arguList tail head.
	list := arguList tail tail.
	truePart := JunLispNil null.
	falsePart := JunLispNil null.
	bool := true.
	list do: [:each | each = #else
			ifTrue: [bool := false]
			ifFalse: [bool
					ifTrue: [truePart := JunLispCons head: each tail: truePart]
					ifFalse: [falsePart := JunLispCons head: each tail: falsePart]]].
	then = #then ifFalse: [^self fatal: 'unexpected format for if'].
	truePart := truePart reverse.
	falsePart := falsePart reverse.
	result := JunLispNil null.
	(self evaluate: predicate)
		= JunLispNil null
		ifTrue: [falsePart do: [:each | result := self evaluate: each]]
		ifFalse: [truePart do: [:each | result := self evaluate: each]].
	^result
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrList: arguList [
	| v a |
	v := JunLispNil null.
	arguList
		reverseDo:
			[:each | 
			a := self evaluate: each.
			v := JunLispCons head: a tail: v].
	^v
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrMlt: arguList [ 
	| v a |
	v := JunLispNil null.
	arguList
		do: 
			[:each | 
			a := self evaluate: each.
			(a respondsTo: #*)
				ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a) , ' for *'].
			v = JunLispNil null
				ifTrue: [v := a]
				ifFalse: [v := v * a]].
	^v
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrMod: arguList [ 
	| v a |
	v := JunLispNil null.
	arguList
		do: 
			[:each | 
			a := self evaluate: each.
			(a respondsTo: #\\)
				ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a) , ' for \\'].
			v = JunLispNil null
				ifTrue: [v := a]
				ifFalse: [v := v \\ a]].
	^v
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrProgn: arguList [ 
	| result |
	result := JunLispNil null.
	arguList do: [:each | result := self evaluate: each].
	^result
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrQuote: arguList [
	^arguList head
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrRead: arguList [ 
	| message default answer |
	message := (#jun_Input_an_S_expression_ >> 'Input an S expression.') asString.
	message := (String new: 16 withAll: Character space)
				, message , (String new: 16 withAll: Character space).
	default := String new.
	arguList length >= 1
		ifTrue: 
			[message := self evaluate: (arguList nth: 1).
			(message isKindOf: String)
				ifFalse: [message := self printString: message]].
	arguList length >= 2
		ifTrue: 
			[default := self evaluate: (arguList nth: 2).
			(default isKindOf: String)
				ifFalse: [default := self printString: default]].
	answer := JunDialog
				request: message
				initialAnswer: default
				onCancel: [nil].
	(answer isNil or: [answer isEmpty])
		ifTrue: [^JunLispNil null].
	^JunLispParser parse: (ReadStream on: answer)
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrRepeat: arguList [ 
	| reverse predicate until executions result |
	reverse := arguList reverse.
	predicate := reverse head.
	until := reverse tail head.
	executions := reverse tail tail reverse.
	until = #until ifFalse: [^self fatal: 'unexpected format for repeat'].
	result := JunLispNil null.
	executions do: [:each | result := self evaluate: each].
	[(self evaluate: predicate)
		= JunLispNil null]
		whileFalse: [executions do: [:each | result := self evaluate: each]].
	^result
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrSend: arguList [ 
	| list receiver selector arguments result |
	list := arguList.
	receiver := self evaluate: list head.
	list := list tail.
	selector := self evaluate: list head.
	(selector isKindOf: Symbol)
		ifFalse: [^self fatal: 'unexpected selector ' , (self printString: selector) , ' for send'].
	list := list tail.
	arguments := OrderedCollection new.
	[list isKindOf: JunLispCons]
		whileTrue: 
			[arguments add: (self evaluate: list head).
			list := list tail].
	result := receiver perform: selector withArguments: arguments asArray.
	^result
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrSetq: arguList [ 
	| list a1 a2 |
	list := arguList.
	a2 := JunLispNil null.
	[list isKindOf: JunLispCons]
		whileTrue: 
			[a1 := list head.
			(a1 isKindOf: Symbol)
				ifFalse: [^self fatal: 'unexpected variable ' , (self printString: a1) , ' for setq'].
			list := list tail.
			a2 := self evaluate: list head.
			self
				putprop: a1
				key: #apval
				value: a2.
			list := list tail].
	^a2
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrSub: arguList [ 
	| v a |
	v := JunLispNil null.
	arguList
		do: 
			[:each | 
			a := self evaluate: each.
			(a respondsTo: #-)
				ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a) , ' for -'].
			v = JunLispNil null
				ifTrue: [v := a]
				ifFalse: [v := v - a]].
	^v
]

{ #category : #'fsubr functions' }
JunLispInterpreter >> fsubrWhile: arguList [ 
	| predicate do executions result |
	predicate := arguList head.
	do := arguList tail head.
	executions := arguList tail tail.
	do = #do ifFalse: [^self fatal: 'unexpected format for while'].
	result := JunLispNil null.
	[(self evaluate: predicate)
		= JunLispNil null]
		whileFalse: [executions do: [:each | result := self evaluate: each]].
	^result
]

{ #category : #'property access' }
JunLispInterpreter >> getprop: identifier key: key [ 
	| value |
	lispTable intern: identifier.
	value := lispTable getprop: identifier key: key.
	value isNil ifTrue: [^JunLispNil null].
	^value
]

{ #category : #'initialize-release' }
JunLispInterpreter >> initialize [
	
	lispTable := JunLispTable new.
	bindStack := OrderedCollection new.
	failBlock := [:errorMessage | self error: errorMessage].
	textCollector := TextCollector new.
	levelNumber := 0.
	self initializeSubrFunctions.
	self initializeFsubrFunctions.
	self initializeExprFunctions.
	self initializeFexprFunctions.
	^self
]

{ #category : #'initialize-release' }
JunLispInterpreter >> initializeExprFunctions [
	self evaluateTopLevel: (JunLispParser parse: '

	% Expr Functions
	(progn

		% ++
		(defun ++ lambda (x)
			(+ x 1))

		% --
		(defun -- lambda (x)
			(- x 1))

		% assoc
		(defun assoc lambda (x a)
			(cond
				((null a) nil)
				((equal x (car (car a))) (car a))
				(t (assoc x (cdr a)))))

		% copy
		(defun copy lambda (x)
			(cond
				((null x) nil)
				(t (cons (car x) (copy (cdr x))))))

		% mapc
		(defun mapc lambda (f x)
			(cond
				((null x) nil)
				(t (progn
					(eval (cons f (cons `(car x) nil)))
					(mapc f (cdr x))))))

		% mapcar
		(defun mapcar lambda (f x)
			(cond
				((null x) nil)
				(t (cons
					(eval (cons f (cons `(car x) nil)))
					(mapcar f (cdr x))))))
			
		) % end

	')
]

{ #category : #'initialize-release' }
JunLispInterpreter >> initializeFexprFunctions [
	self evaluateTopLevel: (JunLispParser parse: '

	% Expr Functions
	(progn

		% and
		(defun and nlambda (x)
			(do	(list)
				(setq list x)
				(while
					(if (null list) then nil else (eval (car list)))
					do
					(setq list (cdr list)))
				(if (null list) then t else nil)))

		% or
		(defun or nlambda (x)
			(do	(list)
				(setq list x)
				(while
					(if (null list) then nil else (not (eval (car list))))
					do
					(setq list (cdr list)))
				(if (null list) then nil else t)))

		) % end

	')
]

{ #category : #'initialize-release' }
JunLispInterpreter >> initializeFsubrFunctions [
	self setFsubrFunc: #(#* #fsubrMlt:).
	self setFsubrFunc: #(#+ #fsubrAdd:).
	self setFsubrFunc: #(#- #fsubrSub:).
	self setFsubrFunc: #(#/ #fsubrDiv:).
	self setFsubrFunc: #(#// #fsubrIdiv:).
	self setFsubrFunc: #(#cond #fsubrCond:).
	self setFsubrFunc: #(#defun #fsubrDefun:).
	self setFsubrFunc: #(#do #fsubrDo:).
	self setFsubrFunc: #(#if #fsubrIf:).
	self setFsubrFunc: #(#list #fsubrList:).
	self setFsubrFunc: #(#progn #fsubrProgn:).
	self setFsubrFunc: #(#quote #fsubrQuote:).
	self setFsubrFunc: #(#read #fsubrRead:).
	self setFsubrFunc: #(#repeat #fsubrRepeat:).
	self setFsubrFunc: #(#send #fsubrSend:).
	self setFsubrFunc: #(#setq #fsubrSetq:).
	self setFsubrFunc: #(#while #fsubrWhile:).
	self setFsubrFunc: #(#\\ #fsubrMod:).
]

{ #category : #'initialize-release' }
JunLispInterpreter >> initializeSubrFunctions [
	self setSubrFunc: #(#< #subrLt: 2).
	self setSubrFunc: #(#<= #subrLe: 2).
	self setSubrFunc: #(#= #subrEqual: 2).
	self setSubrFunc: #(#== #subrEq: 2).
	self setSubrFunc: #(#> #subrGt: 2).
	self setSubrFunc: #(#>= #subrGe: 2).
	self setSubrFunc: #(#append #subrAppend: 2).
	self setSubrFunc: #(#atom #subrAtom: 1).
	self setSubrFunc: #(#car #subrCar: 1).
	self setSubrFunc: #(#cdr #subrCdr: 1).
	self setSubrFunc: #(#clear #subrClear 0).
	self setSubrFunc: #(#cons #subrCons: 2).
	self setSubrFunc: #(#consp #subrConsp: 1).
	self setSubrFunc: #(#dtpr #subrConsp: 1).
	self setSubrFunc: #(#doublep #subrDoublep: 1).
	self setSubrFunc: #(#eq #subrEq: 2).
	self setSubrFunc: #(#equal #subrEqual: 2).
	self setSubrFunc: #(#eval #subrEval: 1).
	self setSubrFunc: #(#exprs #subrExprs 0).
	self setSubrFunc: #(#fexprs #subrFexprs 0).
	self setSubrFunc: #(#floatp #subrFloatp: 1).
	self setSubrFunc: #(#fsubrs #subrFsubrs 0).
	self setSubrFunc: #(#gc #subrGc 0).
	self setSubrFunc: #(#gensym #subrGensym 0).
	self setSubrFunc: #(#getprop #subrGetprop: 2).
	self setSubrFunc: #(#integerp #subrIntegerp: 1).
	self setSubrFunc: #(#last #subrLast: 1).
	self setSubrFunc: #(#length #subrLength: 1).
	self setSubrFunc: #(#listp #subrListp: 1).
	self setSubrFunc: #(#member #subrMember: 2).
	self setSubrFunc: #(#memq #subrMemq: 2).
	self setSubrFunc: #(#nconc #subrNconc: 2).
	self setSubrFunc: #(#neq #subrNeq: 2).
	self setSubrFunc: #(#nequal #subrNequal: 2).
	self setSubrFunc: #(#nospy #subrNospy: 1).
	self setSubrFunc: #(#not #subrNull: 1).
	self setSubrFunc: #(#notrace #subrNotrace 0).
	self setSubrFunc: #(#nth #subrNth: 2).
	self setSubrFunc: #(#null #subrNull: 1).
	self setSubrFunc: #(#numberp #subrNumberp: 1).
	self setSubrFunc: #(#oblist #subrOblist 0).
	self setSubrFunc: #(#pp #subrPp: 1).
	self setSubrFunc: #(#princ #subrPrinc: 1).
	self setSubrFunc: #(#print #subrPrint: 1).
	self setSubrFunc: #(#putprop #subrPutprop: 3).
	self setSubrFunc: #(#remprop #subrRemprop: 2).
	self setSubrFunc: #(#reverse #subrReverse: 1).
	self setSubrFunc: #(#rplaca #subrRplaca: 2).
	self setSubrFunc: #(#rplacd #subrRplacd: 2).
	self setSubrFunc: #(#spy #subrSpy: 1).
	self setSubrFunc: #(#stringp #subrStringp: 1).
	self setSubrFunc: #(#subrs #subrSubrs 0).
	self setSubrFunc: #(#symbolp #subrSymbolp: 1).
	self setSubrFunc: #(#terpri #subrTerpri 0).
	self setSubrFunc: #(#trace #subrTrace 0).
	self setSubrFunc: #(#~= #subrNequal: 2).
	self setSubrFunc: #(#~~ #subrNeq: 2)
]

{ #category : #'menu messages' }
JunLispInterpreter >> inspectIt: aText from: aController [ 
	| result |
	JunSystem isRuntimeVersion ifTrue: [^nil].
	result := self doIt: aText from: aController.
	result inspect.
	^result
]

{ #category : #'menu messages' }
JunLispInterpreter >> investigate [
	JunSystem isRuntimeVersion ifTrue: [^nil].
	self inspect
]

{ #category : #evaluating }
JunLispInterpreter >> listEvaluate: sExpression [ 
	| funcName arguList funcBody |
	sExpression null ifTrue: [^sExpression].
	funcName := sExpression head.
	arguList := sExpression tail.
	(funcName isKindOf: JunLispCons)
		ifTrue: 
			[funcBody := funcName.
			funcBody head = #lambda
				ifTrue: 
					[funcBody := JunLispCons head: #lambda tail: funcBody.
					^self exprEval: funcBody arguList: arguList].
			funcBody head = #nlambda
				ifTrue: 
					[funcBody := JunLispCons head: #nlambda tail: funcBody.
					^self fexprEval: funcBody arguList: arguList].
			^self fatal: 'unexpected function ' , (self printString: funcBody)].
	(funcName isKindOf: Symbol)
		ifFalse: [^self fatal: 'null function ' , (self printString: funcName)].
	funcBody := self getprop: funcName key: #fexpr.
	funcBody = JunLispNil null ifFalse: [^self fexprEval: funcBody arguList: arguList].
	funcBody := self getprop: funcName key: #expr.
	funcBody = JunLispNil null ifFalse: [^self exprEval: funcBody arguList: arguList].
	funcBody := self getprop: funcName key: #fsubr.
	funcBody = JunLispNil null ifFalse: [^self fsubrEval: funcBody arguList: arguList].
	funcBody := self getprop: funcName key: #subr.
	funcBody = JunLispNil null ifFalse: [^self subrEval: funcBody arguList: arguList].
	^self fatal: 'undefined function ' , (self printString: funcName)
]

{ #category : #'interface opening' }
JunLispInterpreter >> postOpenWith: aBuilder [ 
	| aSpecWrapper textCollectorView |
	super postOpenWith: aBuilder.
	aSpecWrapper := aBuilder componentAt: #textCollectorView.
	aSpecWrapper isNil 
		ifFalse: 
			[textCollectorView := aSpecWrapper widget.
			textCollectorView controller deselect]
]

{ #category : #printing }
JunLispInterpreter >> printString: anObject [ 
	^self class printString: anObject
]

{ #category : #'property access' }
JunLispInterpreter >> putprop: identifier key: key value: value [ 
	lispTable intern: identifier.
	^lispTable
		putprop: identifier
		key: key
		value: value
]

{ #category : #adaptor }
JunLispInterpreter >> questionMenu [
	"JunLispInterpreter flushMenus."

	| menuBlock mainMenu subMenu |
	QuestionMenu isNil
		ifTrue: 
			[menuBlock := 
					[:list | 
					| labels lines values index |
					labels := OrderedCollection new.
					lines := OrderedCollection new.
					values := OrderedCollection new.
					index := 0.
					list do: [:assoc | assoc isNil
							ifTrue: [lines add: index]
							ifFalse: 
								[labels add: assoc key.
								values add: assoc value.
								index := index + 1]].
					(Menu
						labelArray: labels asArray
						lines: lines asArray
						values: values asArray) yourself].
			subMenu := OrderedCollection new.
			subMenu add: 'gc' -> #subrGc.
			subMenu add: 'investigate' -> #investigate.
			mainMenu := OrderedCollection new.
			mainMenu add: 'find...' -> #find.
			mainMenu add: 'replace...' -> #replace.
			mainMenu add: nil.
			mainMenu add: 'undo' -> #undo.
			mainMenu add: nil.
			mainMenu add: 'copy' -> #copySelection.
			mainMenu add: 'cut' -> #cut.
			mainMenu add: 'paste' -> #paste.
			mainMenu add: nil.
			mainMenu add: 'do it' -> #doIt:from:.
			mainMenu add: 'inspect' -> #inspectIt:from:.
			mainMenu add: nil.
			mainMenu add: 'lisp' -> (menuBlock value: subMenu).
			QuestionMenu := menuBlock value: mainMenu].
	^QuestionMenu
]

{ #category : #'property access' }
JunLispInterpreter >> remprop: identifier key: key [ 
	| value |
	lispTable intern: identifier.
	value := lispTable remprop: identifier key: key.
	value isNil ifTrue: [^JunLispNil null].
	^value
]

{ #category : #private }
JunLispInterpreter >> setFsubrFunc: bodyArray [ 
	self
		putprop: (bodyArray at: 1) asSymbol
		key: #fsubr
		value: (JunLispCons list: bodyArray)
]

{ #category : #private }
JunLispInterpreter >> setSubrFunc: bodyArray [ 
	self
		putprop: (bodyArray at: 1) asSymbol
		key: #subr
		value: (JunLispCons list: bodyArray)
]

{ #category : #private }
JunLispInterpreter >> skipSeparators: stream [ 
	| char |
	[stream atEnd not
		and: 
			[char := stream peek.
			(JunLispScannerTable scannerTable at: char asInteger)
				= #xDelimiter]]
		whileTrue: [stream next]
]

{ #category : #private }
JunLispInterpreter >> spy: funcName end: sExpression with: aList [
	
	spySymbols
		ifNotNil:
			[:it | 
			(it isEmpty or: [it includes: funcName])
				ifTrue:
					[levelNumber timesRepeat: [textCollector nextPutAll: '| '].
					textCollector
						nextPutAll: (self printString: sExpression);
						nextPutAll: ' <== ';
						nextPutAll: (self printString: aList);
						cr;
						flush.
					levelNumber := levelNumber - 1]]
]

{ #category : #private }
JunLispInterpreter >> spy: funcName start: sExpression with: aBoolean [
	
	spySymbols
		ifNotNil:
			[:it | 
			(it isEmpty or: [it includes: funcName])
				ifTrue:
					[aBoolean ifTrue: [levelNumber := levelNumber + 1].
					levelNumber timesRepeat: [textCollector nextPutAll: '| '].
					textCollector
						nextPutAll: (self printString: sExpression);
						cr;
						flush]]
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrAppend: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a1 isKindOf: JunLispList)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a1) , ' for append'].
	(a2 isKindOf: JunLispList)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for append'].
	^a1 append: a2
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrAtom: arguArray [ 
	| a1 |
	a1 := arguArray at: 1.
	(a1 isKindOf: JunLispCons) ifFalse: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrCar: arguArray [ 
	| list |
	list := arguArray at: 1.
	(list isKindOf: JunLispCons)
		ifTrue: [^list head].
	(list isKindOf: JunLispNil)
		ifTrue: [^JunLispNil null].
	^self fatal: 'unexpected argument ' , (self printString: list) , ' for car'
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrCdr: arguArray [ 
	| list |
	list := arguArray at: 1.
	(list isKindOf: JunLispCons)
		ifTrue: [^list tail].
	(list isKindOf: JunLispNil)
		ifTrue: [^JunLispNil null].
	^self fatal: 'unexpected argument ' , (self printString: list) , ' for cdr'
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrClear [
	textCollector clear.
	^#t
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrCons: arguArray [ 
	^JunLispCons head: (arguArray at: 1)
		tail: (arguArray at: 2)
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrConsp: arguArray [ 
	| a1 |
	a1 := arguArray at: 1.
	(a1 isKindOf: JunLispCons)
		ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrDoublep: arguArray [ 
	| a1 |
	a1 := arguArray at: 1.
	(a1 isKindOf: Double)
		ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrEq: arguArray [ 
	| bool |
	(arguArray at: 1)
		== (arguArray at: 2)
		ifTrue: [bool := #t]
		ifFalse: [bool := JunLispNil null].
	^bool
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrEqual: arguArray [ 
	| bool |
	(arguArray at: 1)
		= (arguArray at: 2)
		ifTrue: [bool := #t]
		ifFalse: [bool := JunLispNil null].
	^bool
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrEval: arguArray [ 
	^self evaluate: (arguArray at: 1)
]

{ #category : #'func eval' }
JunLispInterpreter >> subrEval: funcBody arguList: arguList [
	
	| result funcName messageSelector arguCount arguValues |
	result := JunLispNil null.
	funcName := funcBody head.
	self
		spy: funcName
		start: (JunLispCons head: funcName tail: arguList)
		with: true.
	messageSelector := funcBody tail head.
	arguCount := funcBody tail tail head.
	arguList length < arguCount
		ifTrue:
			[^self fatal: 'too few arguments for ' , (self printString: funcName)].
	arguList length > arguCount
		ifTrue:
			[^self fatal: 'too mary arguments for ' , (self printString: funcName)].
	arguValues := arguList collect: [:each | self evaluate: each].
	(arguList isEmpty not and: [(arguList = arguValues) not])
		ifTrue:
			[self
				spy: funcName
				start: (JunLispCons head: funcName tail: arguValues)
				with: false].
	arguValues isEmpty
		ifTrue: [result := self perform: messageSelector]
		ifFalse:
			[result := self
				perform: messageSelector
				with: arguValues asArray].
	self
		spy: funcName
		end: result
		with: (JunLispCons head: funcName tail: arguValues).
	^result
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrExprs [
	| list |
	list := JunLispNil null.
	self subrOblist reverse do: [:id | (self getprop: id key: #expr)
			= JunLispNil null ifFalse: [list := JunLispCons head: id tail: list]].
	^list
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrFexprs [
	| list |
	list := JunLispNil null.
	self subrOblist reverse do: [:id | (self getprop: id key: #fexpr)
			= JunLispNil null ifFalse: [list := JunLispCons head: id tail: list]].
	^list
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrFloatp: arguArray [ 
	| a1 |
	a1 := arguArray at: 1.
	(a1 isKindOf: Float)
		ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrFsubrs [
	| list |
	list := JunLispNil null.
	self subrOblist reverse do: [:id | (self getprop: id key: #fsubr)
			= JunLispNil null ifFalse: [list := JunLispCons head: id tail: list]].
	^list
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrGc [
	ObjectMemory globalCompactingGC.
	^#t
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrGe: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a1 isKindOf: JunLispList)
		ifTrue: [^self fatal: 'unexpected argument ' , (self printString: a1) , ' for >='].
	(a2 isKindOf: JunLispList)
		ifTrue: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for >='].
	a1 >= a2 ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrGensym [
	| clock |
	(Delay forMilliseconds: 1) wait.
	clock := Time millisecondClockValue.
	^('id' , clock printString) asSymbol
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrGetprop: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a1 isKindOf: Symbol)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a1) , ' for getprop'].
	(a2 isKindOf: Symbol)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for getprop'].
	^self getprop: a1 key: a2
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrGt: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a1 isKindOf: JunLispList)
		ifTrue: [^self fatal: 'unexpected argument ' , (self printString: a1) , ' for >'].
	(a2 isKindOf: JunLispList)
		ifTrue: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for >'].
	a1 > a2 ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrIntegerp: arguArray [ 
	| a1 |
	a1 := arguArray at: 1.
	(a1 isKindOf: Integer)
		ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrLast: arguArray [ 
	| list |
	list := arguArray at: 1.
	(list isKindOf: JunLispCons)
		ifTrue: [^list last].
	^self fatal: 'unexpected argument ' , (self printString: list) , ' for last'
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrLe: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a1 isKindOf: JunLispList)
		ifTrue: [^self fatal: 'unexpected argument ' , (self printString: a1) , ' for <='].
	(a2 isKindOf: JunLispList)
		ifTrue: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for <='].
	a1 <= a2 ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrLength: arguArray [ 
	| list |
	list := arguArray at: 1.
	(list isKindOf: JunLispList)
		ifTrue: [^list length].
	^self fatal: 'unexpected argument ' , (self printString: list) , ' for length'
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrListp: arguArray [ 
	| a1 |
	a1 := arguArray at: 1.
	(a1 isKindOf: JunLispList)
		ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrLt: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a1 isKindOf: JunLispList)
		ifTrue: [^self fatal: 'unexpected argument ' , (self printString: a1) , ' for <'].
	(a2 isKindOf: JunLispList)
		ifTrue: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for <'].
	a1 < a2 ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrMember: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a2 isKindOf: JunLispList)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for member'].
	^a2 member: a1
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrMemq: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a2 isKindOf: JunLispList)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for memq'].
	^a2 memq: a1
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrNconc: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a1 isKindOf: JunLispCons)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a1) , ' for nconc'].
	a1 nconc: a2.
	^a1
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrNeq: arguArray [ 
	| bool |
	((arguArray at: 1)
		== (arguArray at: 2)) not
		ifTrue: [bool := #t]
		ifFalse: [bool := JunLispNil null].
	^bool
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrNequal: arguArray [ 
	| bool |
	((arguArray at: 1)
		= (arguArray at: 2)) not
		ifTrue: [bool := #t]
		ifFalse: [bool := JunLispNil null].
	^bool
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrNospy: arguArray [
	
	| symbol |
	symbol := arguArray at: 1.
	(symbol isKindOf: Symbol)
		ifTrue:
			[spySymbols
				ifNotNil: [:it | (it includes: symbol) ifTrue: [it remove: symbol]].
			spySymbols isEmpty ifTrue: [spySymbols := nil].
			^symbol].
	^self
		fatal: 'unexpected argument ' , (self printString: symbol) , ' for nospy'
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrNotrace [
	
	spySymbols := nil.
	^#t
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrNth: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a1 isKindOf: Number)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a1) , ' for nth'].
	(a2 isKindOf: JunLispList)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for nth'].
	^a2 nth: a1
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrNull: arguArray [ 
	((arguArray at: 1)
		isMemberOf: JunLispNil)
		ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrNumberp: arguArray [ 
	| a1 |
	a1 := arguArray at: 1.
	(a1 isKindOf: Number)
		ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrOblist [
	| list |
	list := JunLispNil null.
	lispTable identifiers reverseDo: [:each | list := JunLispCons head: each tail: list].
	^list
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrPp: arguArray [ 
	| a pretty |
	a := arguArray at: 1.
	pretty := a ppString.
	textCollector show: pretty.
	^a
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrPrinc: arguArray [ 
	| a |
	a := arguArray at: 1.
	(a isKindOf: String)
		ifTrue: [textCollector show: a]
		ifFalse: [textCollector show: (self printString: a)].
	^a
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrPrint: arguArray [ 
	| a |
	a := self subrPrinc: arguArray.
	textCollector cr.
	^a
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrPutprop: arguArray [ 
	| a1 a2 a3 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	a3 := arguArray at: 3.
	(a1 isKindOf: Symbol)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a1) , ' for putprop'].
	(a2 isKindOf: Symbol)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for putprop'].
	^self
		putprop: a1
		key: a2
		value: a3
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrRead [
	| message answer |
	message := (#jun_Input_an_S_expression_ >> 'Input an S expression.') asString.
	message := (String new: 16 withAll: Character space)
				, message , (String new: 16 withAll: Character space).
	answer := JunDialog
				request: message
				initialAnswer: String new
				onCancel: [nil].
	(answer isNil or: [answer isEmpty])
		ifTrue: [^JunLispNil null].
	^JunLispParser parse: (ReadStream on: answer)
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrRemprop: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a1 isKindOf: Symbol)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a1) , ' for remprop'].
	(a2 isKindOf: Symbol)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for remprop'].
	^self remprop: a1 key: a2
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrReverse: arguArray [ 
	| a1 |
	a1 := arguArray at: 1.
	(a1 isKindOf: JunLispList)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a1) , ' for reverse'].
	^a1 reverse
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrRplaca: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a1 isKindOf: JunLispCons)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for rplaca'].
	a1 rplaca: a2.
	^a1
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrRplacd: arguArray [ 
	| a1 a2 |
	a1 := arguArray at: 1.
	a2 := arguArray at: 2.
	(a1 isKindOf: JunLispCons)
		ifFalse: [^self fatal: 'unexpected argument ' , (self printString: a2) , ' for rplacd'].
	a1 rplacd: a2.
	^a1
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrSpy: arguArray [
	
	| symbol |
	symbol := arguArray at: 1.
	(symbol isKindOf: Symbol)
		ifTrue:
			[spySymbols ifNil: [spySymbols := OrderedCollection new].
			(spySymbols includes: symbol) ifFalse: [spySymbols add: symbol].
			^symbol].
	^self
		fatal: 'unexpected argument ' , (self printString: symbol) , ' for spy'
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrStringp: arguArray [ 
	| a1 |
	a1 := arguArray at: 1.
	((a1 isKindOf: String)
		and: [(a1 isKindOf: Symbol) not])
		ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrSubrs [
	| list |
	list := JunLispNil null.
	self subrOblist reverse do: [:id | (self getprop: id key: #subr)
			= JunLispNil null ifFalse: [list := JunLispCons head: id tail: list]].
	^list
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrSymbolp: arguArray [ 
	| a1 |
	a1 := arguArray at: 1.
	(a1 isKindOf: Symbol) ifTrue: [^#t].
	^JunLispNil null
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrTerpri [
	textCollector cr.
	^#t
]

{ #category : #'subr functions' }
JunLispInterpreter >> subrTrace [
	
	spySymbols := OrderedCollection new.
	^#t
]

{ #category : #accessing }
JunLispInterpreter >> textCollector [
	^textCollector
]

{ #category : #adaptor }
JunLispInterpreter >> textCollectorView [
	| textCollectorView |
	textCollectorView := TextCollectorView new model: self textCollector.
	textCollectorView controller: TextEditorController new.
	textCollectorView controller keyboardProcessor: builder keyboardProcessor.
	textCollectorView textStyle: JunAbstractObject lispTextStyle.
	^textCollectorView
]

{ #category : #adaptor }
JunLispInterpreter >> textMenu [
	^[self questionMenu]
]

{ #category : #adaptor }
JunLispInterpreter >> textValue [
	textValue isNil ifTrue: [textValue := Text new asValue].
	^textValue
]

{ #category : #adaptor }
JunLispInterpreter >> textValueChange: aController [ 
	aController accepted ifFalse: [aController accept]
]

{ #category : #'shallow binding' }
JunLispInterpreter >> unbind [
	| assoc |
	
	[assoc := bindStack removeLast.
	assoc key notNil]
		whileTrue: [assoc value notNil
				ifTrue: [self
						putprop: assoc key
						key: #apval
						value: assoc value]
				ifFalse: [self remprop: assoc key key: #apval]]
]

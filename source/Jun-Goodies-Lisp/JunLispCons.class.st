"
Imported by VwImportClass
"
Class {
	#name : #JunLispCons,
	#superclass : #JunLispList,
	#instVars : [
		'head',
		'tail'
	],
	#classVars : [
		'HorizontalLevel',
		'VerticalLevel'
	],
	#category : #'Jun-Goodies-Lisp'
}

{ #category : #'instance creation' }
JunLispCons class >> cell [
	^super new head: self null tail: self null
]

{ #category : #utilities }
JunLispCons class >> classHierarchy: aClass [ 
	"JunLispCons classHierarchy: Number."

	| theClass list |
	aClass isMeta 
		ifTrue: [theClass := aClass soleInstance]
		ifFalse: [theClass := aClass].
	list := self subclassHierarchy: theClass.
	(theClass allSuperclasses select: [:each | each isMeta not]) 
		do: [:each | list := self head: each fullName tail: (self head: list tail: self null)].
	^list
]

{ #category : #copyright }
JunLispCons class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunLispCons class >> example1 [
	"JunLispCons example1."

	| list |
	list := JunLispCons list: #(1 2 3 4 5 6 7 8 9 10 ).
	Transcript cr; show: list printString.
	^list
]

{ #category : #examples }
JunLispCons class >> example2 [
	"JunLispCons example2."

	| null list |
	null := JunLispCons null.
	list := JunLispCons list: #(1 2 ).
	list := JunLispCons head: list tail: null.
	list := JunLispCons head: list tail: null.
	Transcript cr; show: list printString.
	^list
]

{ #category : #examples }
JunLispCons class >> example3 [
	"JunLispCons example3."

	| x y z |
	x := JunLispCons list: #(1 2 3 ).
	y := JunLispCons list: #(4 5 6 ).
	z := JunLispCons list: #(1 2 3 4 5 6 ).
	Transcript cr; show: '(setq x ''(1 2 3)) => ' , x printString.
	Transcript cr; show: '(setq y ''(4 5 6)) => ' , y printString.
	Transcript cr; show: '(setq z ''(1 2 3 4 5 6)) => ' , z printString.
	Transcript cr; show: '(append x y) => ' , (x append: y) printString.
	Transcript cr; show: '(length z) => ' , z length printString.
	Transcript cr; show: '(member 3 z) => ' , (z member: 3) printString.
	Transcript cr; show: '(nth 4 z) => ' , (z nth: 4) printString.
	^z
]

{ #category : #examples }
JunLispCons class >> example4 [
	"JunLispCons example4."

	| list |
	list := JunLispCons list: #(1 2 ).
	list := JunLispCons head: list tail: (JunLispCons list: #(3 4 )).
	list := JunLispCons head: list tail: (JunLispCons list: #(5 6 )).
	Transcript cr; show: list saveString.
	^list
]

{ #category : #examples }
JunLispCons class >> example5 [
	"JunLispCons example5."

	| list |
	list := JunLispCons loadFrom: '
			(PetriNet JunAoki
				(Place p1 p2 p3 p4 p5)
				(Transition t1 t2 t3 t4 t5)
				(InputFunction
					(t1 p1 p2 p3 p4 p5)
					(t2 . p4)
					(t3 . p5))
				(OutputFunction
					(t1 p1 p2 p3 p4 p5)
					(t2 . p4)
					(t3 . p5))
				(Marking {#(1 2 3 4 5)})))'.
	Transcript cr; show: list saveString.
	^list
]

{ #category : #examples }
JunLispCons class >> example6 [
	"JunLispCons example6."

	| list |
	list := JunLispCons loadFrom: '(aaa bbb ccc)'.
	^list
]

{ #category : #examples }
JunLispCons class >> example7 [
	"JunLispCons example7."

	| list |
	list := JunLispCons loadFrom: ' `(`(1 2 `3) . `4 ) '.
	^list
]

{ #category : #examples }
JunLispCons class >> example8 [
	"JunLispCons example8."

	| list |
	list := JunLispCons loadFrom: ' ({100@100} {200@200} {Image fromUser}) '.
	^list
]

{ #category : #examples }
JunLispCons class >> example9 [
	"JunLispCons example9."

	JunLispCons null.
	JunLispCons cell.
	JunLispCons new: 5.
	JunLispCons head: 10 tail: (JunLispCons head: 20 tail: JunLispCons null).
	JunLispCons list: #(10 20 ).
	JunLispCons loadFrom: ' (10 {100@200} {Image fromUser}) '.
	(JunLispCons list: #(10 20 )) head.
	(JunLispCons list: #(10 20 )) tail.
	(JunLispCons list: #(10 20 ))
		append: (JunLispCons list: #(30 40 )).
	(JunLispCons list: #(10 20 )) last.
	(JunLispCons list: #(10 20 )) length.
	(JunLispCons list: #(10 20 ))
		nth: 2.
	(JunLispCons list: #(10 20 ))
		do: [:each | Transcript cr; show: each printString].
	(JunLispCons list: (0 to: 100)) printString.
	(JunLispCons list: (0 to: 100)) ppString.
	(JunLispCons list: (0 to: 100)) saveString
]

{ #category : #examples }
JunLispCons class >> exampleA [
	"JunLispCons exampleA."

	"I/O testing of the literal symbol and the quoted symbol"

	| lispList |
	lispList := JunLispParser 
				parse: (JunLispList list: (Array 
								with: 'is_a' 
								with: #has_a
								with: 'is a' 
								with: #'has a')) 
						saveString.
	lispList inspect.
	^lispList
]

{ #category : #'instance creation' }
JunLispCons class >> head: headObject [ 
	^super new head: headObject tail: self null
]

{ #category : #'instance creation' }
JunLispCons class >> head: headObject tail: tailObject [ 
	^super new head: headObject tail: tailObject
]

{ #category : #'level accessing' }
JunLispCons class >> horizontalLevel [
	HorizontalLevel isNil ifTrue: [HorizontalLevel := 50].
	^HorizontalLevel
]

{ #category : #'level accessing' }
JunLispCons class >> horizontalLevel: anInteger [ 
	HorizontalLevel := anInteger
]

{ #category : #'class initialization' }
JunLispCons class >> initialize [
	"JunLispCons initialize."

	HorizontalLevel := VerticalLevel := nil
]

{ #category : #'instance creation' }
JunLispCons class >> list: anArray [ 
	| size list |
	size := anArray size.
	list := self null.
	size
		to: 1
		by: -1
		do: [:i | list := self head: (anArray at: i)
						tail: list].
	^list
]

{ #category : #'instance creation' }
JunLispCons class >> new [
	^self cell
]

{ #category : #'instance creation' }
JunLispCons class >> null [
	^JunLispNil null
]

{ #category : #utilities }
JunLispCons class >> subclassHierarchy: aClass [ 
	"JunLispCons subclassHierarchy: Number."

	| theClass list collection sub |
	aClass isMeta 
		ifTrue: [theClass := aClass soleInstance]
		ifFalse: [theClass := aClass].
	list := self null.
	theClass subclasses isEmpty 
		ifFalse: 
			[collection := OrderedCollection new.
			collection addAll: (theClass subclasses select: [:each | each isMeta not]).
			collection := collection 
						asSortedCollection: [:x :y | x fullName > y fullName].
			collection do: 
					[:each | 
					sub := self subclassHierarchy: each.
					list := self head: sub tail: list]].
	^self head: theClass fullName tail: list
]

{ #category : #utilities }
JunLispCons class >> superclassHierarchy: aClass [ 
	"JunLispCons superclassHierarchy: Number."

	| theClass list |
	aClass isMeta 
		ifTrue: [theClass := aClass soleInstance]
		ifFalse: [theClass := aClass].
	list := self head: theClass fullName tail: self null.
	(theClass allSuperclasses select: [:each | each isMeta not]) 
		do: [:each | list := self head: each fullName tail: (self head: list tail: self null)].
	^list
]

{ #category : #copyright }
JunLispCons class >> system [
	^'Jun'
]

{ #category : #copyright }
JunLispCons class >> version [
	^'799'
]

{ #category : #'level accessing' }
JunLispCons class >> verticalLevel [
	VerticalLevel isNil ifTrue: [VerticalLevel := 10].
	^VerticalLevel
]

{ #category : #'level accessing' }
JunLispCons class >> verticalLevel: anInteger [ 
	VerticalLevel := anInteger
]

{ #category : #testing }
JunLispCons >> = anObject [ 
	(anObject isKindOf: self class)
		ifFalse: [^false].
	self head = anObject head ifTrue: [^self tail = anObject tail].
	^false
]

{ #category : #adding }
JunLispCons >> add: newObject [ 
	^self nconc: (self class head: newObject tail: self class null)
]

{ #category : #functions }
JunLispCons >> append: list [ 
	(tail isKindOf: self class)
		ifFalse: [^self class head: head tail: list].
	^self class head: head tail: (tail append: list)
]

{ #category : #accessing }
JunLispCons >> at: indexInteger [
	| count |
	count := 1.
	self
		mapcdr: 
			[:cdr | 
			indexInteger = count ifTrue: [^cdr head].
			count := count + 1].
	^self subscriptOutOfBoundsError: indexInteger
]

{ #category : #accessing }
JunLispCons >> at: indexInteger put: anObject [ 
	| count |
	count := 1.
	self
		mapcdr: 
			[:cdr | 
			indexInteger = count ifTrue: [^cdr head: anObject].
			count := count + 1].
	^self subscriptOutOfBoundsError: indexInteger
]

{ #category : #enumerating }
JunLispCons >> collect: aBlock [ 
	| list result |
	list := self.
	result := self class null.
	[list isKindOf: self class]
		whileTrue: 
			[result := self class head: (aBlock value: list head)
						tail: result.
			list := list tail].
	^result reverse
]

{ #category : #enumerating }
JunLispCons >> do: aBlock [ 
	| list |
	list := self.
	[list isKindOf: self class]
		whileTrue: 
			[aBlock value: list head.
			list := list tail]
]

{ #category : #accessing }
JunLispCons >> head [
	^head
]

{ #category : #accessing }
JunLispCons >> head: anObject [ 
	^head := anObject
]

{ #category : #accessing }
JunLispCons >> head: headObject tail: tailObject [ 
	self head: headObject.
	self tail: tailObject
]

{ #category : #functions }
JunLispCons >> last [
	| list |
	list := self class head: nil tail: self.
	self do: [:each | list := list tail].
	^list
]

{ #category : #functions }
JunLispCons >> length [
	| count |
	count := 0.
	self do: [:each | count := count + 1].
	^count
]

{ #category : #functions }
JunLispCons >> mapcdr: aBlock [ 
	| list |
	list := self.
	[list isKindOf: self class]
		whileTrue: 
			[aBlock value: list.
			list := list tail]
]

{ #category : #functions }
JunLispCons >> member: anObject [ 
	| list |
	list := self.
	self do: 
		[:each | 
		each = anObject ifTrue: [^list].
		list := list tail].
	^self species null
]

{ #category : #functions }
JunLispCons >> memq: anObject [ 
	| list |
	list := self.
	self do: 
		[:each | 
		each == anObject ifTrue: [^list].
		list := list tail].
	^self species null
]

{ #category : #functions }
JunLispCons >> nconc: list [ 
	self last rplacd: list
]

{ #category : #functions }
JunLispCons >> nth: nth [ 
	| count list |
	nth <= 0 ifTrue: [^self species null].
	count := 1.
	list := self.
	list do: 
		[:each | 
		count >= nth ifTrue: [^each].
		count := count + 1].
	^self species null
]

{ #category : #'pretty printing' }
JunLispCons >> ppOn: aStream [ 
	self
		ppOn: aStream
		list: self
		position: 0.
	aStream cr
]

{ #category : #'pretty printing' }
JunLispCons >> ppOn: aStream list: list position: position [ 
	(list isKindOf: self class)
		ifFalse: [^self ppOn: aStream object: list].
	(list head isKindOf: self class) not
		ifTrue: 
			[aStream nextPutAll: '('.
			self ppOn: aStream object: list head.
			(list tail isKindOf: JunLispList)
				ifTrue: [self
						ppOn: aStream
						tail: list tail
						position: position + 1]
				ifFalse: 
					[aStream nextPutAll: ' . '.
					self ppOn: aStream object: list tail].
			aStream nextPutAll: ')']
		ifFalse: 
			[aStream nextPutAll: '('.
			self
				ppOn: aStream
				list: list head
				position: position + 1.
			(list tail isKindOf: self class)
				ifTrue: [(list tail head isKindOf: self class)
						ifTrue: 
							[aStream cr.
							self ppOn: aStream spaceAndTab: position.
							self
								ppOn: aStream
								tail: list tail
								position: position]
						ifFalse: 
							[self ppOn: aStream space: 1.
							self
								ppOn: aStream
								tail: list tail
								position: position + 1]]
				ifFalse: [(list tail isKindOf: JunLispList)
						ifFalse: 
							[aStream nextPutAll: ' . '.
							self ppOn: aStream object: list tail]].
			aStream nextPutAll: ')']
]

{ #category : #'pretty printing' }
JunLispCons >> ppOn: aStream object: anObject [ 
	(anObject isKindOf: Symbol)
		ifTrue: [^aStream nextPutAll: anObject asString].
	(anObject isKindOf: String)
		ifTrue: 
			[aStream nextPutAll: '"'.
			anObject
				do: 
					[:char | 
					char = $" ifTrue: [aStream nextPut: $"].
					aStream nextPut: char].
			^aStream nextPutAll: '"'].
	(anObject isKindOf: Number)
		ifTrue: [^anObject storeOn: aStream].
	(anObject isMemberOf: JunLispNil)
		ifTrue: [^aStream nextPutAll: 'nil'].
	aStream nextPutAll: '{'.
	aStream nextPutAll: (anObject printString contractTo: 80).
	aStream nextPutAll: '}'
]

{ #category : #'pretty printing' }
JunLispCons >> ppOn: aStream space: anInteger [ 
	anInteger timesRepeat: [aStream nextPut: Character space]
]

{ #category : #'pretty printing' }
JunLispCons >> ppOn: aStream spaceAndTab: anInteger [ 
	| tabs spaces |
	tabs := anInteger // self tabStop.
	spaces := anInteger \\ self tabStop.
	tabs * (self tabStop // 4) timesRepeat: [aStream tab].
	spaces timesRepeat: [aStream space]
]

{ #category : #'pretty printing' }
JunLispCons >> ppOn: aStream tail: list position: position [ 
	list null ifTrue: [^self].
	(list tail isKindOf: JunLispList)
		ifTrue: [list tail null
				ifTrue: 
					[self ppOn: aStream space: 1.
					self
						ppOn: aStream
						list: list head
						position: position + 1]
				ifFalse: 
					[self ppOn: aStream space: 1.
					self
						ppOn: aStream
						list: list head
						position: position + 1.
					aStream cr.
					self ppOn: aStream spaceAndTab: position.
					self
						ppOn: aStream
						tail: list tail
						position: position]]
		ifFalse: 
			[self ppOn: aStream space: 1.
			self
				ppOn: aStream
				list: list head
				position: position + 1.
			aStream nextPutAll: ' . '.
			self ppOn: aStream object: list tail]
]

{ #category : #'pretty printing' }
JunLispCons >> ppString [
	| stream |
	stream := WriteStream on: (String new: 20).
	self ppOn: stream.
	^stream contents
]

{ #category : #printing }
JunLispCons >> printOn: aStream [ 
	self printOn: aStream level: 0
]

{ #category : #printing }
JunLispCons >> printOn: aStream level: level [ 
	| verticalLevel |
	verticalLevel := self class verticalLevel.
	(verticalLevel isZero not and: [level >= verticalLevel])
		ifTrue: 
			[aStream nextPutAll: '( ... )'.
			^self].
	self null ifTrue: [^super printOn: aStream].
	aStream nextPutAll: '('.
	(head isKindOf: self class)
		ifTrue: [head printOn: aStream level: level + 1]
		ifFalse: [self printOn: aStream object: head].
	(tail isKindOf: JunLispList)
		ifTrue: [self
				printOn: aStream
				tail: tail
				level: level]
		ifFalse: 
			[aStream nextPutAll: ' . '.
			self printOn: aStream object: tail.
			^aStream nextPutAll: ')']
]

{ #category : #printing }
JunLispCons >> printOn: aStream object: anObject [ 
	| aBoolean |
	aBoolean := true.
	((anObject isKindOf: Symbol) 
		and: [aBoolean := self isLiteralSymbol: anObject]) 
			ifTrue: [^aStream nextPutAll: anObject asString].
	((anObject isKindOf: String) and: [aBoolean]) 
		ifTrue: 
			[aStream nextPutAll: '"'.
			anObject do: 
					[:char | 
					char = $" ifTrue: [aStream nextPut: $"].
					aStream nextPut: char].
			^aStream nextPutAll: '"'].
	(anObject isKindOf: Number) ifTrue: [^anObject storeOn: aStream].
	(anObject isMemberOf: JunLispNil) ifTrue: [^aStream nextPutAll: 'nil'].
	aStream nextPutAll: '{'.
	aStream nextPutAll: (anObject printString contractTo: 80).
	aStream nextPutAll: '}'
]

{ #category : #printing }
JunLispCons >> printOn: aStream tail: cdr level: level [ 
	| tailPart count horizontalLevel |
	cdr null ifTrue: [^aStream nextPutAll: ')'].
	tailPart := cdr.
	count := 1.
	horizontalLevel := self class horizontalLevel.
	tailPart do: 
		[:each | 
		(horizontalLevel isZero not and: [count >= horizontalLevel])
			ifTrue: 
				[aStream nextPutAll: ' ... )'.
				^self].
		aStream nextPutAll: ' '.
		(each isKindOf: self class)
			ifTrue: [tailPart head printOn: aStream level: level + 1]
			ifFalse: [self printOn: aStream object: each].
		tailPart := tailPart tail.
		count := count + 1].
	(tailPart isKindOf: JunLispList)
		ifTrue: [aStream nextPutAll: ')']
		ifFalse: 
			[aStream nextPutAll: ' . '.
			self printOn: aStream object: tailPart.
			aStream nextPutAll: ')']
]

{ #category : #functions }
JunLispCons >> reverse [
	| list |
	list := self class null.
	self do: [:each | list := self class head: each tail: list].
	^list
]

{ #category : #functions }
JunLispCons >> rplaca: anObject [ 
	self head: anObject
]

{ #category : #functions }
JunLispCons >> rplacd: anObject [ 
	self tail: anObject
]

{ #category : #saving }
JunLispCons >> saveOn: aStream [ 
	self
		saveOn: aStream
		list: self
		position: 0.
	aStream cr
]

{ #category : #saving }
JunLispCons >> saveOn: aStream list: list position: position [ 
	| location length |
	(list isKindOf: self class)
		ifFalse: [^self saveOn: aStream object: list].
	(list head isKindOf: self class) not
		ifTrue: 
			[aStream nextPutAll: '('.
			location := aStream position.
			self saveOn: aStream object: list head.
			(list tail isKindOf: JunLispList)
				ifTrue: 
					[length := aStream position - location min: 40.
					length := 0.
					self
						saveOn: aStream
						tail: list tail
						position: position + 1 + length]
				ifFalse: 
					[aStream nextPutAll: ' . '.
					self saveOn: aStream object: list tail].
			aStream nextPutAll: ')']
		ifFalse: 
			[aStream nextPutAll: '('.
			self
				saveOn: aStream
				list: list head
				position: position + 1.
			(list tail isKindOf: self class)
				ifTrue: [(list tail head isKindOf: self class)
						ifTrue: 
							[aStream cr.
							self saveOn: aStream spaceAndTab: position.
							self
								saveOn: aStream
								tail: list tail
								position: position]
						ifFalse: 
							[self saveOn: aStream space: 1.
							self
								saveOn: aStream
								tail: list tail
								position: position + 1]]
				ifFalse: [(list tail isKindOf: JunLispList)
						ifFalse: 
							[aStream nextPutAll: ' . '.
							self saveOn: aStream object: list tail]].
			aStream nextPutAll: ')']
]

{ #category : #saving }
JunLispCons >> saveOn: aStream object: anObject [ 
	| aBoolean aString |
	aBoolean := true.
	((anObject isKindOf: Symbol) 
		and: [aBoolean := self isLiteralSymbol: anObject]) 
			ifTrue: [^aStream nextPutAll: anObject asString].
	((anObject isKindOf: String) and: [aBoolean]) 
		ifTrue: 
			[aStream nextPutAll: '"'.
			anObject do: 
					[:char | 
					char = $" ifTrue: [aStream nextPut: $"].
					aStream nextPut: char].
			^aStream nextPutAll: '"'].
	(anObject isKindOf: Integer) ifTrue: [^anObject storeOn: aStream].
	(anObject isKindOf: Float) ifTrue: [^anObject storeOn: aStream].
	(anObject isKindOf: Double) ifTrue: [^anObject storeOn: aStream].
	(anObject isMemberOf: JunLispNil) ifTrue: [^aStream nextPutAll: 'nil'].
	aStream nextPutAll: '{'.
	((anObject isKindOf: Point) or: [anObject isKindOf: Rectangle]) 
		ifTrue: [aString := anObject printString]
		ifFalse: [aString := anObject storeString].
	aStream nextPutAll: aString.
	aStream nextPutAll: '}'
]

{ #category : #saving }
JunLispCons >> saveOn: aStream space: anInteger [ 
	anInteger timesRepeat: [aStream nextPut: Character space]
]

{ #category : #saving }
JunLispCons >> saveOn: aStream spaceAndTab: anInteger [ 
	| tabs spaces |
	tabs := anInteger // self tabStop.
	spaces := anInteger \\ self tabStop.
	tabs timesRepeat: [aStream tab].
	spaces timesRepeat: [aStream space]
]

{ #category : #saving }
JunLispCons >> saveOn: aStream tail: list position: position [ 
	list null ifTrue: [^self].
	(list tail isKindOf: JunLispList)
		ifTrue: [list tail null
				ifTrue: 
					[self saveOn: aStream space: 1.
					self
						saveOn: aStream
						list: list head
						position: position + 1]
				ifFalse: 
					[self saveOn: aStream space: 1.
					self
						saveOn: aStream
						list: list head
						position: position + 1.
					aStream cr.
					self saveOn: aStream spaceAndTab: position.
					self
						saveOn: aStream
						tail: list tail
						position: position]]
		ifFalse: 
			[self saveOn: aStream space: 1.
			self
				saveOn: aStream
				list: list head
				position: position + 1.
			aStream nextPutAll: ' . '.
			self saveOn: aStream object: list tail]
]

{ #category : #saving }
JunLispCons >> saveString [
	| stream |
	stream := WriteStream on: (String new: 20).
	self saveOn: stream.
	^stream contents
]

{ #category : #private }
JunLispCons >> tabStop [
	^8
]

{ #category : #accessing }
JunLispCons >> tail [
	^tail
]

{ #category : #accessing }
JunLispCons >> tail: anObject [ 
	^tail := anObject
]

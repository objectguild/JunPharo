"
Imported by VwImportClass
"
Class {
	#name : #Jun2dPoint,
	#superclass : #JunPoint,
	#instVars : [
		'x',
		'y'
	],
	#classInstVars : [
		'enhancements'
	],
	#category : #'Jun-Geometry-Basic'
}

{ #category : #copyright }
Jun2dPoint class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun2dPoint class >> example1 [
	"Jun2dPoint example1."

	| aPoint |
	aPoint := 1 , 0.5.
	Transcript
		cr;
		show: aPoint printString.
	Transcript
		cr;
		show: aPoint storeString.
	aPoint asJunOpenGL3dObject showWithUnitAxes.
	^aPoint
]

{ #category : #examples }
Jun2dPoint class >> example2 [
	"Jun2dPoint example2."

	| aPolyline graphicsContext tS tT |
	aPolyline := OrderedCollection new.
	aPolyline add: 0 , 0.
	aPolyline add: 50 , 0.
	aPolyline add: 50 , 50.
	aPolyline add: 0 , 50.
	aPolyline add: 0 , 0.
	graphicsContext := ScheduledControllers activeController view graphicsContext.
	tS := Jun2dTransformation scale: 1.5 , 1.5.
	tT := Jun2dTransformation translate: (Jun2dPoint fromPoint: graphicsContext medium bounds center).
	graphicsContext clear.
	graphicsContext paint: ColorValue black.
	graphicsContext displayPolyline: (aPolyline collect: [:p | (p transform: tT) asPoint]).
	graphicsContext paint: ColorValue red.
	graphicsContext displayPolyline: (aPolyline collect: [:p | (p transform: (tS product: tT)) asPoint]).
	Cursor crossHair showWhile: [graphicsContext medium sensor waitClickButton].
	[InputState default mouseButtons > 0] whileTrue.
	graphicsContext medium display
]

{ #category : #examples }
Jun2dPoint class >> example3 [
	"Jun2dPoint example3."

	| aPolyline tR tT graphicsContext |
	aPolyline := OrderedCollection new.
	aPolyline add: 0 , 0.
	aPolyline add: 100 , 0.
	aPolyline add: 100 , 100.
	aPolyline add: 0 , 100.
	aPolyline add: 0 , 0.
	graphicsContext := ScheduledControllers activeController view graphicsContext.
	tR := Jun2dTransformation rotate: (JunAngle fromDeg: 30).
	tT := Jun2dTransformation translate: (Jun2dPoint fromPoint: graphicsContext medium bounds center).
	graphicsContext clear.
	graphicsContext paint: ColorValue black.
	graphicsContext displayPolyline: (aPolyline collect: [:p | (p transform: tT) asPoint]).
	graphicsContext paint: ColorValue red.
	graphicsContext displayPolyline: (aPolyline collect: [:p | (p transform: (tR product: tT)) asPoint]).
	Cursor crossHair showWhile: [graphicsContext medium sensor waitClickButton].
	[InputState default mouseButtons > 0] whileTrue.
	graphicsContext medium display
]

{ #category : #'instance creation' }
Jun2dPoint class >> fromArray: anArray [ 
	^self x: (anArray at: 1)
		y: (anArray at: 2)
]

{ #category : #'instance creation' }
Jun2dPoint class >> fromNumber: aNumber [ 
	^self x: aNumber y: aNumber
]

{ #category : #'instance creation' }
Jun2dPoint class >> fromPoint: aPoint [ 
	^self x: aPoint x y: aPoint y
]

{ #category : #'lisp support' }
Jun2dPoint class >> fromTable: aTable for: aPoint [ 
	"Jun2dPoint fromLispList: ((1 , 2) toLispList)."

	self xFromTable: aTable for: aPoint.
	self yFromTable: aTable for: aPoint.
	^aPoint
]

{ #category : #'class initialization' }
Jun2dPoint class >> install [
	"Jun2dPoint install."

	self installEnhancements
]

{ #category : #enhancements }
Jun2dPoint class >> installEnhancements [
	"Jun2dPoint installEnhancements."

	| classified |

	classified := '*' , self class category.

	Number 
		compile: ', aNumber 
	^Jun2dPoint
		x: self
		y: aNumber' 
		classified: classified.
	
	Number 
		compile: 'asDouble 
	^ self asFloat' 
		classified: classified
]

{ #category : #utilities }
Jun2dPoint class >> neighborhood24Points: aPoint [ 
	"Jun2dPoint neighborhood24Points: Point zero."

	| aCollection |
	aCollection := OrderedCollection new: 24.
	-2 to: 2
		do: 
			[:y | 
			-2 to: 2
				do: [:x | (x = 0 and: [y = 0]) ifFalse: [aCollection add: aPoint + (x , y)]]].
	^aCollection
]

{ #category : #utilities }
Jun2dPoint class >> neighborhood4Points: aPoint [ 
	"Jun2dPoint neighborhood4Points: Jun2dPoint zero."

	| aCollection |
	aCollection := OrderedCollection new: 4.
	aCollection add: aPoint + (1 , 0).
	aCollection add: aPoint + (0 , 1).
	aCollection add: aPoint + (-1 , 0).
	aCollection add: aPoint + (0 , -1).
	^aCollection
]

{ #category : #utilities }
Jun2dPoint class >> neighborhood8Points: aPoint [ 
	"Jun2dPoint neighborhood8Points: Jun2dPoint zero."

	| aCollection |
	aCollection := OrderedCollection new: 8.
	aCollection add: aPoint + (1 , 0).
	aCollection add: aPoint + (1 , 1).
	aCollection add: aPoint + (0 , 1).
	aCollection add: aPoint + (-1 , 1).
	aCollection add: aPoint + (-1 , 0).
	aCollection add: aPoint + (-1 , -1).
	aCollection add: aPoint + (0 , -1).
	aCollection add: aPoint + (1 , -1).
	^aCollection
]

{ #category : #utilities }
Jun2dPoint class >> neighborhoodPoints: aPoint [ 
	"Jun2dPoint neighborhoodPoints: Jun2dPoint zero."

	^self neighborhood8Points: aPoint
]

{ #category : #'class initialization' }
Jun2dPoint class >> obsolete [
	self uninstall.
	super obsolete
]

{ #category : #'instance creation' }
Jun2dPoint class >> rho: rho theta: theta [ 
	^self x: rho * theta cos y: rho * theta sin
]

{ #category : #copyright }
Jun2dPoint class >> system [
	^'Jun'
]

{ #category : #'class initialization' }
Jun2dPoint class >> uninstall [
	"Jun2dPoint uninstall."

	self uninstallEnhancements
]

{ #category : #enhancements }
Jun2dPoint class >> uninstallEnhanceClass: aClass selector: aSelector [ 
	| anArray aProtocol oldCode |
	aClass isBehavior ifFalse: [^self].
	(aSelector isKindOf: Symbol)
		ifFalse: [^self].
	enhancements isNil ifTrue: [^self].
	anArray := enhancements
				detect: 
					[:array | 
					| bool |
					bool := aClass name asString = (array at: 1).
					bool := bool and: [aSelector = (array at: 3)].
					bool yourself]
				ifNone: [nil].
	anArray isNil ifTrue: [^self].
	aProtocol := anArray at: 2.
	oldCode := anArray at: 4.
	oldCode isNil
		ifTrue: ["remove method"
			aClass removeSelector: aSelector]
		ifFalse: ["restore method"
			aClass compile: oldCode classified: aProtocol].
	enhancements remove: anArray
]

{ #category : #enhancements }
Jun2dPoint class >> uninstallEnhancements [
	"Jun2dPoint uninstallEnhancements."

	| aClass aSelector |
	enhancements notNil
		ifTrue: 
			[enhancements copy
				do: 
					[:anArray | 
					aClass := Compiler evaluate: (anArray at: 1)
								logged: false.
					aSelector := anArray at: 3.
					self uninstallEnhanceClass: aClass selector: aSelector].
			enhancements := nil]
]

{ #category : #'constants access' }
Jun2dPoint class >> unity [
	"Jun2dPoint unity."

	^self x: 1.0d y: 1.0d
]

{ #category : #copyright }
Jun2dPoint class >> version [
	^'799'
]

{ #category : #'instance creation' }
Jun2dPoint class >> x: xNumber y: yNumber [ 
	^(self basicNew) setX: xNumber; setY: yNumber
]

{ #category : #'instance creation' }
Jun2dPoint class >> x: xNumber y: yNumber z: zNumber [ 
	^self x: xNumber y: yNumber
]

{ #category : #'lisp support' }
Jun2dPoint class >> xFromTable: aTable for: aPoint [ 
	| aValue |
	aValue := aTable at: #x ifAbsent: [^aPoint].
	aPoint setX: aValue.
	^aPoint
]

{ #category : #'lisp support' }
Jun2dPoint class >> yFromTable: aTable for: aPoint [ 
	| aValue |
	aValue := aTable at: #y ifAbsent: [^aPoint].
	aPoint setY: aValue.
	^aPoint
]

{ #category : #'constants access' }
Jun2dPoint class >> zero [
	"Jun2dPoint zero."

	^self x: 0.0d y: 0.0d
]

{ #category : #arithmetic }
Jun2dPoint >> * aPoint [ 
	self class = aPoint class ifTrue: [^self class x: x * aPoint x y: y * aPoint y].
	^self retry: #* coercing: aPoint
]

{ #category : #arithmetic }
Jun2dPoint >> + aPoint [ 
	self class = aPoint class ifTrue: [^self class x: x + aPoint x y: y + aPoint y].
	^self retry: #+ coercing: aPoint
]

{ #category : #converting }
Jun2dPoint >> , aNumber [ 
	^Jun3dPoint
		x: self x
		y: self y
		z: aNumber
]

{ #category : #arithmetic }
Jun2dPoint >> - aPoint [ 
	self class = aPoint class ifTrue: [^self class x: x - aPoint x y: y - aPoint y].
	^self retry: #- coercing: aPoint
]

{ #category : #arithmetic }
Jun2dPoint >> / aPoint [ 
	self class = aPoint class ifTrue: [^self class x: x / aPoint x y: y / aPoint y].
	^self retry: #/ coercing: aPoint
]

{ #category : #comparing }
Jun2dPoint >> < aPoint [ 
	self class = aPoint class ifTrue: [^x < aPoint x and: [y < aPoint y]].
	^self retry: #< coercing: aPoint
]

{ #category : #comparing }
Jun2dPoint >> <= aPoint [ 
	self class = aPoint class ifTrue: [^x <= aPoint x and: [y <= aPoint y]].
	^self retry: #<= coercing: aPoint
]

{ #category : #comparing }
Jun2dPoint >> = aPoint [ 
	self class = aPoint class ifTrue: [^x = aPoint x and: [y = aPoint y]].
	^self retry: #= coercing: aPoint
]

{ #category : #comparing }
Jun2dPoint >> > aPoint [ 
	self class = aPoint class ifTrue: [^x > aPoint x and: [y > aPoint y]].
	^self retry: #> coercing: aPoint
]

{ #category : #comparing }
Jun2dPoint >> >= aPoint [ 
	self class = aPoint class ifTrue: [^x >= aPoint x and: [y >= aPoint y]].
	^self retry: #>= coercing: aPoint
]

{ #category : #arithmetic }
Jun2dPoint >> abs [
	^self class x: x abs y: y abs
]

{ #category : #functions }
Jun2dPoint >> angleBetween: aJun2dPoint1 and: aJun2dPoint2 [ 
	| v1 v2 r1 r2 |
	v1 := aJun2dPoint1 - self.
	v2 := aJun2dPoint2 - self.
	r1 := v1 r.
	r2 := v2 r.
	(r1 < self class accuracy or: [r2 < self class accuracy])
		ifTrue: [^JunAngle zero]
		ifFalse: 
			[| sin |
			sin := self y asDouble + aJun2dPoint1 y asDouble * (self x asDouble - aJun2dPoint1 x asDouble) + (aJun2dPoint1 y asDouble + aJun2dPoint2 y asDouble * (aJun2dPoint1 x asDouble - aJun2dPoint2 x asDouble)) + (aJun2dPoint2 y asDouble + self y asDouble * (aJun2dPoint2 x asDouble - self x asDouble)) / 2 * 2.0d / r1 / r2.
			sin := (sin max: -1.0d) min: 1.0d.
			^(v1 dotProduct: v2)
				>= 0
				ifTrue: [JunAngle fromRad: sin arcSin]
				ifFalse: [sin abs < self class accuracy
						ifTrue: [JunAngle fromRad: Double pi]
						ifFalse: [JunAngle fromRad: Double pi - sin arcSin abs * sin sign]]]
]

{ #category : #converting }
Jun2dPoint >> as2dPoint [
	^self
]

{ #category : #converting }
Jun2dPoint >> as3dPoint [
	^self , 0
]

{ #category : #converting }
Jun2dPoint >> asArray [
	| array |
	array := Array new: 2.
	array at: 1 put: x.
	array at: 2 put: y.
	^array
]

{ #category : #functions }
Jun2dPoint >> ball: radiusValue [ 
	^Jun2dBoundingBall center: self radius: radiusValue
]

{ #category : #functions }
Jun2dPoint >> bisector: aPoint [ 
	^Jun2dLine between: self and: aPoint
]

{ #category : #functions }
Jun2dPoint >> box: aPoint [ 
	^Jun2dBoundingBox vertex: self vertex: aPoint
]

{ #category : #'truncation and round off' }
Jun2dPoint >> ceiling [
	^self class x: x ceiling y: y ceiling
]

{ #category : #functions }
Jun2dPoint >> corner: aPoint [ 
	^Jun2dBoundingBox origin: self corner: aPoint
]

{ #category : #'double dispatching' }
Jun2dPoint >> differenceFromPoint: aPoint [ 
	^self class x: aPoint x - x y: aPoint y - y
]

{ #category : #functions }
Jun2dPoint >> dotProduct: aPoint [ 
	| newPoint |
	newPoint := self * aPoint.
	^newPoint x + newPoint y
]

{ #category : #comparing }
Jun2dPoint >> equal: aPoint [ 
	self class == aPoint class ifFalse: [^false].
	^(self x - aPoint x) abs < self accuracy 
		and: [(self y - aPoint y) abs < self accuracy]
]

{ #category : #'double dispatching' }
Jun2dPoint >> equalFromPoint: aPoint [ 
	^aPoint x = x and: [aPoint y = y]
]

{ #category : #functions }
Jun2dPoint >> extent: aPoint [ 
	^Jun2dBoundingBox origin: self extent: aPoint
]

{ #category : #'truncation and round off' }
Jun2dPoint >> floor [
	^self class x: x floor y: y floor
]

{ #category : #coercing }
Jun2dPoint >> generality [
	^200
]

{ #category : #functions }
Jun2dPoint >> grid: aPoint [ 
	| newX newY |
	(aPoint isKindOf: self class)
		ifFalse: [^self retry: #grid: coercing: aPoint].
	aPoint x = 0
		ifTrue: [newX := 0]
		ifFalse: [newX := self x roundTo: aPoint x].
	aPoint y = 0
		ifTrue: [newY := 0]
		ifFalse: [newY := self y roundTo: aPoint y].
	^self class x: newX y: newY
]

{ #category : #comparing }
Jun2dPoint >> hash [
	^(x hash bitShift: 2)
		bitXor: y hash
]

{ #category : #testing }
Jun2dPoint >> is2d [
	^true
]

{ #category : #testing }
Jun2dPoint >> isZero [
	^x isZero and: [y isZero]
]

{ #category : #comparing }
Jun2dPoint >> max: aPoint [ 
	self class = aPoint class ifTrue: [^self class x: (x max: aPoint x)
			y: (y max: aPoint y)].
	^self retry: #max: coercing: aPoint
]

{ #category : #comparing }
Jun2dPoint >> min: aPoint [ 
	self class = aPoint class ifTrue: [^self class x: (x min: aPoint x)
			y: (y min: aPoint y)].
	^self retry: #min: coercing: aPoint
]

{ #category : #arithmetic }
Jun2dPoint >> min: minValue max: maxValue [ 
	| minPoint maxPoint |
	minPoint := self class coerce: minValue.
	maxPoint := self class coerce: maxValue.
	^self class
		x: (minPoint x max: (self x min: maxPoint x))
		y: (minPoint y max: (self y min: maxPoint y))
]

{ #category : #functions }
Jun2dPoint >> product: aJun2dPoint [ 
	^x * aJun2dPoint y - (y * aJun2dPoint x)
]

{ #category : #'double dispatching' }
Jun2dPoint >> productFromPoint: aPoint [ 
	^self class x: aPoint x * x y: aPoint y * y
]

{ #category : #'double dispatching' }
Jun2dPoint >> quoFromInteger: anInteger [ 
	^(anInteger / self) truncated
]

{ #category : #'double dispatching' }
Jun2dPoint >> quotientFromPoint: aPoint [ 
	^self class x: aPoint x / x y: aPoint y / y
]

{ #category : #functions }
Jun2dPoint >> radius: radiusValue [ 
	^Jun2dCircle center: self radius: radiusValue
]

{ #category : #'truncation and round off' }
Jun2dPoint >> rounded [
	^self class x: x rounded y: y rounded
]

{ #category : #private }
Jun2dPoint >> setX: aNumber [
	x := aNumber asDouble
]

{ #category : #private }
Jun2dPoint >> setY: aNumber [
	y := aNumber asDouble
]

{ #category : #functions }
Jun2dPoint >> sphere: radiusValue [ 
	^JunSphere center: self x , self y , 0 radius: radiusValue
]

{ #category : #printing }
Jun2dPoint >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	self x storeOn: aStream.
	aStream nextPutAll: ' , '.
	self y storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'double dispatching' }
Jun2dPoint >> sumFromPoint: aPoint [ 
	^self class x: aPoint x + x y: aPoint y + y
]

{ #category : #'polar coordinates' }
Jun2dPoint >> theta [
	| theta |
	x isZero
		ifTrue: 
			[y isZero ifTrue: [^JunAngle zero].
			y >= 0
				ifTrue: [^0.5d * JunAngle pi]
				ifFalse: [^1.5d * JunAngle pi]].
	theta := JunAngle fromRad: (y asDouble / x asDouble) arcTan.
	x >= 0
		ifTrue: [y >= 0
				ifTrue: [^theta]
				ifFalse: [^2.0d * JunAngle pi + theta]]
		ifFalse: [^1.0d * JunAngle pi + theta]
]

{ #category : #'lisp support' }
Jun2dPoint >> toLispList [
	"self showLispList: ((1 , 2) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self xToLispList.
	list add: self yToLispList.
	^list
]

{ #category : #transforming }
Jun2dPoint >> transformationToRotate: anAngle [ 
	^Jun2dTransformation rotate: anAngle around: self
]

{ #category : #'truncation and round off' }
Jun2dPoint >> truncated [
	^self class x: x truncated y: y truncated
]

{ #category : #functions }
Jun2dPoint >> vectorProduct: aJun2dPoint [ 
	| aPoint |
	aPoint := (Jun3dPoint coerce: self) 
				vectorProduct: (Jun3dPoint coerce: aJun2dPoint).
	^aPoint x , aPoint y
]

{ #category : #testing }
Jun2dPoint >> whichSideOf: aLine [ 
	^aLine whichSide: self
]

{ #category : #accessing }
Jun2dPoint >> x [
	^x
]

{ #category : #'lisp support' }
Jun2dPoint >> xToLispList [
	| list |
	list := self lispCons.
	list head: #x.
	list tail: self x.
	^list
]

{ #category : #accessing }
Jun2dPoint >> y [
	^y
]

{ #category : #'lisp support' }
Jun2dPoint >> yToLispList [
	| list |
	list := self lispCons.
	list head: #y.
	list tail: self y.
	^list
]

{ #category : #accessing }
Jun2dPoint >> z [
	^0
]

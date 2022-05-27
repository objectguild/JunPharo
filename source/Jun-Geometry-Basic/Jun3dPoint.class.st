"
Imported by VwImportClass
"
Class {
	#name : #Jun3dPoint,
	#superclass : #JunPoint,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#classInstVars : [
		'enhancements'
	],
	#category : #'Jun-Geometry-Basic'
}

{ #category : #copyright }
Jun3dPoint class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dPoint class >> example1 [
	"Jun3dPoint example1."

	| aPoint |
	aPoint := 1 , 0.5 , 0.25.
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
Jun3dPoint class >> example2 [
	"Jun3dPoint example2."

	| aPolyline1 aPolyline2 graphicsContext viewPoint tS tP tT tPT tSPT |
	aPolyline1 := OrderedCollection new.
	aPolyline1 add: 0 , 0 , 50.
	aPolyline1 add: 50 , 0 , 50.
	aPolyline1 add: 50 , 50 , 50.
	aPolyline1 add: 0 , 50 , 50.
	aPolyline1 add: 0 , 0 , 50.
	aPolyline2 := OrderedCollection new.
	aPolyline2 add: 0 , 0 , 0.
	aPolyline2 add: 50 , 0 , 0.
	aPolyline2 add: 50 , 50 , 0.
	aPolyline2 add: 0 , 50 , 0.
	aPolyline2 add: 0 , 0 , 0.
	graphicsContext := ScheduledControllers activeController view graphicsContext.
	viewPoint := 25 , 25 , 150.
	tS := Jun3dTransformation scale: 1.5 , 1.5 , 1.5.
	tP := Jun3dTransformation perspective: viewPoint.
	tT := Jun3dTransformation translate: (Jun3dPoint fromPoint: graphicsContext medium bounds center).
	tPT := tP product: tT.
	tSPT := (tS product: tP)
				product: tT.
	graphicsContext clear.
	graphicsContext paint: ColorValue gray.
	graphicsContext displayPolyline: (aPolyline2 collect: [:p | (p transform: tPT) asPoint]).
	graphicsContext paint: ColorValue red.
	aPolyline1 with: aPolyline2
		do: 
			[:p1 :p2 | 
			| from to |
			from := (p1 transform: tPT) asPoint.
			to := (p2 transform: tPT) asPoint.
			graphicsContext displayLineFrom: from to: to].
	graphicsContext paint: ColorValue black.
	graphicsContext displayPolyline: (aPolyline1 collect: [:p | (p transform: tPT) asPoint]).
	graphicsContext paint: ColorValue gray.
	graphicsContext displayPolyline: (aPolyline2 collect: [:p | (p transform: tSPT) asPoint]).
	graphicsContext paint: ColorValue red.
	aPolyline1 with: aPolyline2
		do: 
			[:p1 :p2 | 
			| from to |
			from := (p1 transform: tSPT) asPoint.
			to := (p2 transform: tSPT) asPoint.
			graphicsContext displayLineFrom: from to: to].
	graphicsContext paint: ColorValue black.
	graphicsContext displayPolyline: (aPolyline1 collect: [:p | (p transform: tSPT) asPoint]).
	Cursor crossHair showWhile: [graphicsContext medium sensor waitClickButton].
	[InputState default mouseButtons > 0] whileTrue.
	graphicsContext medium display
]

{ #category : #examples }
Jun3dPoint class >> example3 [
	"Jun3dPoint example3."

	| aPolyline1 aPolyline2 graphicsContext viewPoint tR tP tT tPT tRPT |
	aPolyline1 := OrderedCollection new.
	aPolyline1 add: 0 , 0 , 50.
	aPolyline1 add: 50 , 0 , 50.
	aPolyline1 add: 50 , 50 , 50.
	aPolyline1 add: 0 , 50 , 50.
	aPolyline1 add: 0 , 0 , 50.
	aPolyline2 := OrderedCollection new.
	aPolyline2 add: 0 , 0 , 0.
	aPolyline2 add: 50 , 0 , 0.
	aPolyline2 add: 50 , 50 , 0.
	aPolyline2 add: 0 , 50 , 0.
	aPolyline2 add: 0 , 0 , 0.
	graphicsContext := ScheduledControllers activeController view graphicsContext.
	viewPoint := 25 , 25 , 150.
	tR := Jun3dTransformation rotate: (JunAngle fromDeg: 30).
	tP := Jun3dTransformation perspective: viewPoint.
	tT := Jun3dTransformation translate: (Jun3dPoint fromPoint: graphicsContext medium bounds center).
	tPT := tP product: tT.
	tRPT := (tR product: tP)
				product: tT.
	graphicsContext clear.
	graphicsContext paint: ColorValue gray.
	graphicsContext displayPolyline: (aPolyline2 collect: [:p | (p transform: tPT) asPoint]).
	graphicsContext paint: ColorValue red.
	aPolyline1 with: aPolyline2
		do: 
			[:p1 :p2 | 
			| from to |
			from := (p1 transform: tPT) asPoint.
			to := (p2 transform: tPT) asPoint.
			graphicsContext displayLineFrom: from to: to].
	graphicsContext paint: ColorValue black.
	graphicsContext displayPolyline: (aPolyline1 collect: [:p | (p transform: tPT) asPoint]).
	graphicsContext paint: ColorValue gray.
	graphicsContext displayPolyline: (aPolyline2 collect: [:p | (p transform: tRPT) asPoint]).
	graphicsContext paint: ColorValue red.
	aPolyline1 with: aPolyline2
		do: 
			[:p1 :p2 | 
			| from to |
			from := (p1 transform: tRPT) asPoint.
			to := (p2 transform: tRPT) asPoint.
			graphicsContext displayLineFrom: from to: to].
	graphicsContext paint: ColorValue black.
	graphicsContext displayPolyline: (aPolyline1 collect: [:p | (p transform: tRPT) asPoint]).
	Cursor crossHair showWhile: [graphicsContext medium sensor waitClickButton].
	[InputState default mouseButtons > 0] whileTrue.
	graphicsContext medium display
]

{ #category : #'instance creation' }
Jun3dPoint class >> fromArray: anArray [ 
	^self
		x: (anArray at: 1)
		y: (anArray at: 2)
		z: (anArray at: 3)
]

{ #category : #'instance creation' }
Jun3dPoint class >> fromNumber: aNumber [ 
	^self
		x: aNumber
		y: aNumber
		z: aNumber
]

{ #category : #'instance creation' }
Jun3dPoint class >> fromPoint: aPoint [ 
	^self
		x: aPoint x
		y: aPoint y
		z: ((aPoint respondsTo: #z)
				ifTrue: [aPoint z]
				ifFalse: [0.0d])
]

{ #category : #'lisp support' }
Jun3dPoint class >> fromTable: aTable for: aPoint [ 
	"Jun3dPoint fromLispList: ((1 , 2 , 3) toLispList)."

	self xFromTable: aTable for: aPoint.
	self yFromTable: aTable for: aPoint.
	self zFromTable: aTable for: aPoint.
	^aPoint
]

{ #category : #'class initialization' }
Jun3dPoint class >> install [
	"Jun3dPoint install."

	self installEnhancements
]

{ #category : #enhancements }
Jun3dPoint class >> installEnhancements [
	"Jun3dPoint installEnhancements."

	Point 
		compile: ', aNumber 
	^Jun3dPoint
		x: self x
		y: self y
		z: aNumber' 
		classified: '*' , self class category
]

{ #category : #utilities }
Jun3dPoint class >> neighborhood124Points: aPoint [ 
	"Jun3dPoint neighborhood124Points: Jun3dPoint zero."

	| aCollection |
	aCollection := OrderedCollection new: 24.
	-2 to: 2
		do: 
			[:z | 
			-2 to: 2
				do: 
					[:y | 
					-2 to: 2
						do: 
							[:x | 
							(x = 0 and: [y = 0 and: [z = 0]]) 
								ifFalse: [aCollection add: aPoint + (x , y , z)]]]].
	^aCollection
]

{ #category : #utilities }
Jun3dPoint class >> neighborhood26Points: aPoint [ 
	"Jun3dPoint neighborhood26Points: Jun3dPoint zero."

	| aCollection |
	aCollection := OrderedCollection new: 9 + 8 + 9.
	"----------"
	aCollection add: aPoint + (0 , 0 , 1).
	"----------"
	aCollection add: aPoint + (1 , 0 , 1).
	aCollection add: aPoint + (1 , 1 , 1).
	aCollection add: aPoint + (0 , 1 , 1).
	aCollection add: aPoint + (-1 , 1 , 1).
	aCollection add: aPoint + (-1 , 0 , 1).
	aCollection add: aPoint + (-1 , -1 , 1).
	aCollection add: aPoint + (0 , -1 , 1).
	aCollection add: aPoint + (1 , -1 , 1).
	"----------"
	aCollection add: aPoint + (1 , 0 , 0).
	aCollection add: aPoint + (1 , 1 , 0).
	aCollection add: aPoint + (0 , 1 , 0).
	aCollection add: aPoint + (-1 , 1 , 0).
	aCollection add: aPoint + (-1 , 0 , 0).
	aCollection add: aPoint + (-1 , -1 , 0).
	aCollection add: aPoint + (0 , -1 , 0).
	aCollection add: aPoint + (1 , -1 , 0).
	"----------"
	aCollection add: aPoint + (1 , 0 , -1).
	aCollection add: aPoint + (1 , 1 , -1).
	aCollection add: aPoint + (0 , 1 , -1).
	aCollection add: aPoint + (-1 , 1 , -1).
	aCollection add: aPoint + (-1 , 0 , -1).
	aCollection add: aPoint + (-1 , -1 , -1).
	aCollection add: aPoint + (0 , -1 , -1).
	aCollection add: aPoint + (1 , -1 , -1).
	"----------"
	aCollection add: aPoint + (0 , 0 , -1).
	"----------"
	^aCollection
]

{ #category : #utilities }
Jun3dPoint class >> neighborhood6Points: aPoint [ 
	"Jun3dPoint neighborhood6Points: Jun3dPoint zero."

	| aCollection |
	aCollection := OrderedCollection new: 6.
	aCollection add: aPoint + (0 , 0 , 1).
	aCollection add: aPoint + (1 , 0 , 0).
	aCollection add: aPoint + (0 , 1 , 0).
	aCollection add: aPoint + (-1 , 0 , 0).
	aCollection add: aPoint + (0 , -1 , 0).
	aCollection add: aPoint + (0 , 0 , -1).
	^aCollection
]

{ #category : #utilities }
Jun3dPoint class >> neighborhoodPoints: aPoint [ 
	"Jun3dPoint neighborhoodPoints: Jun3dPoint zero."

	^self neighborhood26Points: aPoint
]

{ #category : #'class initialization' }
Jun3dPoint class >> obsolete [
	self uninstall.
	super obsolete
]

{ #category : #'instance creation' }
Jun3dPoint class >> rho: rho phi: phi theta: theta [ 
	^self
		x: rho * theta sin * phi cos
		y: rho * theta sin * phi sin
		z: rho * theta cos
]

{ #category : #copyright }
Jun3dPoint class >> system [
	^'Jun'
]

{ #category : #'class initialization' }
Jun3dPoint class >> uninstall [
	"Jun3dPoint uninstall."

	self uninstallEnhancements
]

{ #category : #enhancements }
Jun3dPoint class >> uninstallEnhanceClass: aClass selector: aSelector [ 
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
Jun3dPoint class >> uninstallEnhancements [
	"Jun3dPoint uninstallEnhancements."

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
Jun3dPoint class >> unity [
	"Jun3dPoint unity."

	^self
		x: 1.0d
		y: 1.0d
		z: 1.0d
]

{ #category : #copyright }
Jun3dPoint class >> version [
	^'799'
]

{ #category : #'instance creation' }
Jun3dPoint class >> x: xNumber y: yNumber [ 
	^self 
		x: xNumber
		y: yNumber
		z: 0
]

{ #category : #'instance creation' }
Jun3dPoint class >> x: xNumber y: yNumber z: zNumber [ 
	^(self basicNew) setX: xNumber; setY: yNumber; setZ: zNumber
]

{ #category : #'lisp support' }
Jun3dPoint class >> xFromTable: aTable for: aPoint [ 
	| aValue |
	aValue := aTable at: #x ifAbsent: [^aPoint].
	aPoint setX: aValue.
	^aPoint
]

{ #category : #'lisp support' }
Jun3dPoint class >> yFromTable: aTable for: aPoint [ 
	| aValue |
	aValue := aTable at: #y ifAbsent: [^aPoint].
	aPoint setY: aValue.
	^aPoint
]

{ #category : #'lisp support' }
Jun3dPoint class >> zFromTable: aTable for: aPoint [ 
	| aValue |
	aValue := aTable at: #z ifAbsent: [^aPoint].
	aPoint setZ: aValue.
	^aPoint
]

{ #category : #'constants access' }
Jun3dPoint class >> zero [
	"Jun3dPoint zero."

	^self
		x: 0.0d
		y: 0.0d
		z: 0.0d
]

{ #category : #arithmetic }
Jun3dPoint >> * aPoint [ 
	(aPoint isKindOf: self class)
		ifTrue: [^self class
				x: x * aPoint x
				y: y * aPoint y
				z: z * aPoint z].
	^self retry: #* coercing: aPoint
]

{ #category : #arithmetic }
Jun3dPoint >> + aPoint [ 
	(aPoint isKindOf: self class)
		ifTrue: [^self class
				x: x + aPoint x
				y: y + aPoint y
				z: z + aPoint z].
	^self retry: #+ coercing: aPoint
]

{ #category : #arithmetic }
Jun3dPoint >> - aPoint [ 
	(aPoint isKindOf: self class)
		ifTrue: [^self class
				x: x - aPoint x
				y: y - aPoint y
				z: z - aPoint z].
	^self retry: #- coercing: aPoint
]

{ #category : #arithmetic }
Jun3dPoint >> / aPoint [ 
	(aPoint isKindOf: self class)
		ifTrue: [^self class
				x: x / aPoint x
				y: y / aPoint y
				z: z / aPoint z].
	^self retry: #/ coercing: aPoint
]

{ #category : #comparing }
Jun3dPoint >> < aPoint [ 
	(aPoint isKindOf: self class)
		ifTrue: [^(x < aPoint x and: [y < aPoint y])
				and: [z < aPoint z]].
	^self retry: #< coercing: aPoint
]

{ #category : #comparing }
Jun3dPoint >> <= aPoint [ 
	(aPoint isKindOf: self class)
		ifTrue: [^(x <= aPoint x and: [y <= aPoint y])
				and: [z <= aPoint z]].
	^self retry: #<= coercing: aPoint
]

{ #category : #comparing }
Jun3dPoint >> = aPoint [ 
	(aPoint isKindOf: self class) 
		ifTrue: [^(x = aPoint x and: [y = aPoint y]) and: [z = aPoint z]].
	^self retry: #= coercing: aPoint
]

{ #category : #comparing }
Jun3dPoint >> > aPoint [ 
	(aPoint isKindOf: self class)
		ifTrue: [^(x > aPoint x and: [y > aPoint y])
				and: [z > aPoint z]].
	^self retry: #> coercing: aPoint
]

{ #category : #comparing }
Jun3dPoint >> >= aPoint [ 
	(aPoint isKindOf: self class)
		ifTrue: [^(x >= aPoint x and: [y >= aPoint y])
				and: [z >= aPoint z]].
	^self retry: #>= coercing: aPoint
]

{ #category : #arithmetic }
Jun3dPoint >> abs [
	^self class
		x: x abs
		y: y abs
		z: z abs
]

{ #category : #converting }
Jun3dPoint >> as2dPoint [
	^self x , self y
]

{ #category : #converting }
Jun3dPoint >> as3dPoint [
	^self
]

{ #category : #converting }
Jun3dPoint >> asArray [
	| array |
	array := Array new: 3.
	array at: 1 put: x.
	array at: 2 put: y.
	array at: 3 put: z.
	^array
]

{ #category : #functions }
Jun3dPoint >> ball: radiusValue [ 
	^Jun3dBoundingBall center: self radius: radiusValue
]

{ #category : #functions }
Jun3dPoint >> bisector: aPoint [ 
	^JunPlane between: self and: aPoint
]

{ #category : #functions }
Jun3dPoint >> box: aPoint [ 
	^Jun3dBoundingBox vertex: self vertex: aPoint
]

{ #category : #'truncation and round off' }
Jun3dPoint >> ceiling [
	^self class
		x: x ceiling
		y: y ceiling
		z: z ceiling
]

{ #category : #functions }
Jun3dPoint >> circularCone: radiusValue height: heightValue [ 
	"(1 , 1 , 1) circularCone: 1 height: 2."

	^JunCircularCone 
		center: self
		radius: radiusValue
		height: heightValue
]

{ #category : #functions }
Jun3dPoint >> circularCylinder: radiusValue height: heightValue [ 
	"(1 , 1 , 1) circularCylinder: 1 height: 2."

	^JunCircularCylinder 
		center: self
		radius: radiusValue
		height: heightValue
]

{ #category : #functions }
Jun3dPoint >> cone: radiusValue height: heightValue [ 
	"(1 , 1 , 1) cone: 1 height: 2."

	^self circularCone: radiusValue height: heightValue
]

{ #category : #functions }
Jun3dPoint >> corner: aPoint [ 
	^Jun3dBoundingBox origin: self corner: aPoint
]

{ #category : #functions }
Jun3dPoint >> cylinder: radiusValue height: heightValue [ 
	"(1 , 1 , 1) cylinder: 1 height: 2."

	^self circularCylinder: radiusValue height: heightValue
]

{ #category : #'double dispatching' }
Jun3dPoint >> differenceFromPoint: aPoint [ 
	| p |
	p := self coerce: aPoint.
	^self class
		x: p x - x
		y: p y - y
		z: p z - z
]

{ #category : #functions }
Jun3dPoint >> dotProduct: aPoint [ 
	| newPoint |
	newPoint := self * aPoint.
	^newPoint x + newPoint y + newPoint z
]

{ #category : #comparing }
Jun3dPoint >> equal: aPoint [ 
	self class == aPoint class ifFalse: [^false].
	^((self x - aPoint x) abs < self accuracy 
		and: [(self y - aPoint y) abs < self accuracy]) 
			and: [(self z - aPoint z) abs < self accuracy]
]

{ #category : #'double dispatching' }
Jun3dPoint >> equalFromPoint: aPoint [ 
	| p |
	p := self coerce: aPoint.
	^p x = x and: [p y = y and: [p z = z]]
]

{ #category : #functions }
Jun3dPoint >> extent: aPoint [ 
	^Jun3dBoundingBox origin: self extent: aPoint
]

{ #category : #'truncation and round off' }
Jun3dPoint >> floor [
	^self class
		x: x floor
		y: y floor
		z: z floor
]

{ #category : #coercing }
Jun3dPoint >> generality [
	^220
]

{ #category : #functions }
Jun3dPoint >> grid: aPoint [ 
	| newX newY newZ |
	(aPoint isKindOf: self class)
		ifFalse: [^self retry: #grid: coercing: aPoint].
	aPoint x = 0
		ifTrue: [newX := 0]
		ifFalse: [newX := self x roundTo: aPoint x].
	aPoint y = 0
		ifTrue: [newY := 0]
		ifFalse: [newY := self y roundTo: aPoint y].
	aPoint z = 0
		ifTrue: [newZ := 0]
		ifFalse: [newZ := self z roundTo: aPoint z].
	^self class
		x: newX
		y: newY
		z: newZ
]

{ #category : #comparing }
Jun3dPoint >> hash [
	^(((x hash bitShift: 2)
		bitXor: y hash)
		bitShift: 2)
		bitXor: z hash
]

{ #category : #functions }
Jun3dPoint >> intersectingPointWithLine: aJun3dLine [ 
	^(aJun3dLine containsPoint: self)
		ifTrue: [self]
		ifFalse: [nil]
]

{ #category : #testing }
Jun3dPoint >> is3d [
	^true
]

{ #category : #testing }
Jun3dPoint >> isZero [
	^(x isZero and: [y isZero])
		and: [z isZero]
]

{ #category : #comparing }
Jun3dPoint >> max: aPoint [ 
	(aPoint isKindOf: self class)
		ifTrue: [^self class
				x: (x max: aPoint x)
				y: (y max: aPoint y)
				z: (z max: aPoint z)].
	^self retry: #max: coercing: aPoint
]

{ #category : #comparing }
Jun3dPoint >> min: aPoint [ 
	(aPoint isKindOf: self class)
		ifTrue: [^self class
				x: (x min: aPoint x)
				y: (y min: aPoint y)
				z: (z min: aPoint z)].
	^self retry: #min: coercing: aPoint
]

{ #category : #arithmetic }
Jun3dPoint >> min: minValue max: maxValue [ 
	| minPoint maxPoint |
	minPoint := self class coerce: minValue.
	maxPoint := self class coerce: maxValue.
	^self class 
		x: (minPoint x max: (self x min: maxPoint x))
		y: (minPoint y max: (self y min: maxPoint y))
		z: (minPoint z max: (self z min: maxPoint z))
]

{ #category : #'polar coordinates' }
Jun3dPoint >> phi [
	| phi |
	x isZero
		ifTrue: 
			[y isZero ifTrue: [^JunAngle zero].
			y >= 0
				ifTrue: [^0.5d * JunAngle pi]
				ifFalse: [^1.5d * JunAngle pi]].
	phi := JunAngle fromRad: (y asDouble / x asDouble) arcTan.
	x >= 0
		ifTrue: [y >= 0
				ifTrue: [^phi]
				ifFalse: [^2.0d * JunAngle pi + phi]]
		ifFalse: [^1.0d * JunAngle pi + phi]
]

{ #category : #functions }
Jun3dPoint >> product: aPoint [ 
	^self vectorProduct: aPoint
]

{ #category : #'double dispatching' }
Jun3dPoint >> productFromPoint: aPoint [ 
	| p |
	p := self coerce: aPoint.
	^self class
		x: p x * x
		y: p y * y
		z: p z * z
]

{ #category : #'double dispatching' }
Jun3dPoint >> quoFromInteger: anInteger [ 
	^(anInteger / self) truncated
]

{ #category : #'double dispatching' }
Jun3dPoint >> quotientFromPoint: aPoint [ 
	| p |
	p := self coerce: aPoint.
	^self class
		x: p x / x
		y: p y / y
		z: p z / z
]

{ #category : #functions }
Jun3dPoint >> radius: radiusValue [ 
	^Jun3dCircle center: self radius: radiusValue
]

{ #category : #functions }
Jun3dPoint >> radius: radiusValue normalVector: normalVector [ 
	^self radius: radiusValue upVector: normalVector
]

{ #category : #functions }
Jun3dPoint >> radius: radiusValue upVector: upVector [ 
	^Jun3dCircle 
		center: self
		radius: radiusValue
		upVector: upVector
]

{ #category : #'truncation and round off' }
Jun3dPoint >> rounded [
	^self class
		x: x rounded
		y: y rounded
		z: z rounded
]

{ #category : #private }
Jun3dPoint >> setX: aNumber [ 
	x := aNumber asDouble
]

{ #category : #private }
Jun3dPoint >> setY: aNumber [ 
	y := aNumber asDouble
]

{ #category : #private }
Jun3dPoint >> setZ: aNumber [ 
	z := aNumber asDouble
]

{ #category : #functions }
Jun3dPoint >> sphere: radiusValue [ 
	^JunSphere center: self radius: radiusValue
]

{ #category : #printing }
Jun3dPoint >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	self x storeOn: aStream.
	aStream nextPutAll: ' , '.
	self y storeOn: aStream.
	aStream nextPutAll: ' , '.
	self z storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'double dispatching' }
Jun3dPoint >> sumFromPoint: aPoint [ 
	| p |
	p := self coerce: aPoint.
	^self class
		x: p x + x
		y: p y + y
		z: p z + z
]

{ #category : #sweeping }
Jun3dPoint >> sweep: aJun3dPoint [
	^Jun3dLine from: self to: self + aJun3dPoint
]

{ #category : #sweeping }
Jun3dPoint >> sweepAround: aJun3dLine [ 
	| center radius normalVector |
	center := aJun3dLine nearestPointFromPoint: self.
	radius := self distance: center.
	normalVector := aJun3dLine asUnitVector.
	^JunNurbsCurve
		circleCenter: center
		normalVector: normalVector
		radius: radius
]

{ #category : #functions }
Jun3dPoint >> tetrahedron: aPoint1 and: aPoint2 and: aPoint3 [ 
	"(1 , 0 , 0) tetrahedron: (0 , 1 , 0) and: (0 , 0 , 1) and: (0 , 0 , 0)."

	^JunTetrahedron 
		on: self
		on: aPoint1
		on: aPoint2
		on: aPoint3
]

{ #category : #'polar coordinates' }
Jun3dPoint >> theta [
	| wk theta |
	wk := (x * x + (y * y)) sqrt.
	z isZero
		ifTrue: 
			[wk isZero ifTrue: [^JunAngle zero].
			^0.5d * JunAngle pi].
	theta := JunAngle fromRad: (wk asDouble / z asDouble) arcTan.
	z >= 0
		ifTrue: [^theta]
		ifFalse: [^1.0d * JunAngle pi + theta]
]

{ #category : #'lisp support' }
Jun3dPoint >> toLispList [
	"self showLispList: ((1 , 2 , 3) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self xToLispList.
	list add: self yToLispList.
	list add: self zToLispList.
	^list
]

{ #category : #transforming }
Jun3dPoint >> transformationToAlignVectorWithVector: aJun3dPoint [ 
	^Jun3dTransformation alignVector: self withVector: aJun3dPoint
]

{ #category : #transforming }
Jun3dPoint >> transformationToRotate: anAngle [ 
	^Jun3dTransformation rotate: anAngle around: (self to: self + (0 , 0 , 1))
]

{ #category : #'truncation and round off' }
Jun3dPoint >> truncated [
	^self class
		x: x truncated
		y: y truncated
		z: z truncated
]

{ #category : #functions }
Jun3dPoint >> vectorProduct: aPoint [ 
	^self class
		x: y * aPoint z - (z * aPoint y)
		y: z * aPoint x - (x * aPoint z)
		z: x * aPoint y - (y * aPoint x)
]

{ #category : #testing }
Jun3dPoint >> whichSideOf: aPlane [ 
	^aPlane whichSide: self
]

{ #category : #accessing }
Jun3dPoint >> x [
	^x
]

{ #category : #'lisp support' }
Jun3dPoint >> xToLispList [
	| list |
	list := self lispCons.
	list head: #x.
	list tail: self x.
	^list
]

{ #category : #accessing }
Jun3dPoint >> y [
	^y
]

{ #category : #'lisp support' }
Jun3dPoint >> yToLispList [
	| list |
	list := self lispCons.
	list head: #y.
	list tail: self y.
	^list
]

{ #category : #accessing }
Jun3dPoint >> z [
	^z
]

{ #category : #'lisp support' }
Jun3dPoint >> zToLispList [
	| list |
	list := self lispCons.
	list head: #z.
	list tail: self z.
	^list
]

"
Imported by VwImportClass
"
Class {
	#name : #JunAngle,
	#superclass : #JunGeometry,
	#instVars : [
		'rad',
		'deg',
		'sin',
		'cos',
		'tan'
	],
	#classInstVars : [
		'enhancements'
	],
	#category : #'Jun-Geometry-Basic'
}

{ #category : #coercing }
JunAngle class >> coerce: anObject [ 
	(anObject isKindOf: self)
		ifTrue: [^anObject].
	^self fromRad: anObject
]

{ #category : #copyright }
JunAngle class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunAngle class >> degrees: degrees [ 
	^self fromDeg: degrees
]

{ #category : #'constants access' }
JunAngle class >> doublePi [
	"JunAngle doublePi."

	^self fromRad: super doublePi
]

{ #category : #examples }
JunAngle class >> example1 [
	"JunAngle example1."

	| anAngle |
	anAngle := JunAngle fromDeg: 45.
	Transcript
		cr;
		show: anAngle printString.
	Transcript
		cr;
		show: anAngle storeString.
	anAngle asJunOpenGL3dObject showWithUnitAxes.
	^anAngle
]

{ #category : #'instance creation' }
JunAngle class >> fromDeg: degrees [ 
	^self basicNew deg: degrees
]

{ #category : #'instance creation' }
JunAngle class >> fromRad: radians [ 
	^self basicNew rad: radians
]

{ #category : #'lisp support' }
JunAngle class >> fromTable: aTable for: anAngle [ 
	"JunAngle fromLispList: ((JunAngle degrees: 45) toLispList)."

	self radiansFromTable: aTable for: anAngle.
	^anAngle
]

{ #category : #coercing }
JunAngle class >> generality [
	^self zero generality
]

{ #category : #'constants access' }
JunAngle class >> halfPi [
	"JunAngle halfPi."

	^self fromRad: super halfPi
]

{ #category : #'class initialization' }
JunAngle class >> install [
	"JunAngle install."

	self installEnhancements
]

{ #category : #enhancements }
JunAngle class >> installEnhancements [
	"JunAngle installEnhancements."

	| classified |

	classified := '*' , self class category.

	Number 
		compile: 'asDegrees 
	^JunAngle degrees: self' 
		classified: classified.

	Number 
		compile: 'asRadians 
	^JunAngle radians: self' 
		classified: classified
]

{ #category : #'class initialization' }
JunAngle class >> obsolete [
	self uninstall.
	super obsolete
]

{ #category : #'constants access' }
JunAngle class >> pi [
	"JunAngle pi."

	^self fromRad: super pi
]

{ #category : #'constants access' }
JunAngle class >> quarterPi [
	"JunAngle quarterPi."

	^self fromRad: super quarterPi
]

{ #category : #'instance creation' }
JunAngle class >> radians: radians [ 
	^self fromRad: radians
]

{ #category : #'lisp support' }
JunAngle class >> radiansFromTable: aTable for: anAngle [ 
	| aValue |
	aValue := aTable at: #radians ifAbsent: [^anAngle].
	anAngle radians: aValue.
	^anAngle
]

{ #category : #copyright }
JunAngle class >> system [
	^'Jun'
]

{ #category : #'class initialization' }
JunAngle class >> uninstall [
	"JunAngle uninstall."

	self uninstallEnhancements
]

{ #category : #enhancements }
JunAngle class >> uninstallEnhanceClass: aClass selector: aSelector [ 
	| anArray aProtocol oldCode |
	aClass isBehavior ifFalse: [^self].
	(aSelector isKindOf: Symbol) ifFalse: [^self].
	enhancements isNil ifTrue: [^self].
	anArray := enhancements detect: 
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
		ifTrue: 
			["remove method"

			aClass removeSelector: aSelector]
		ifFalse: 
			["restore method"

			aClass compile: oldCode classified: aProtocol].
	enhancements remove: anArray
]

{ #category : #enhancements }
JunAngle class >> uninstallEnhancements [
	"JunAngle uninstallEnhancements."

	| aClass aSelector |
	enhancements notNil 
		ifTrue: 
			[enhancements copy do: 
					[:anArray | 
					aClass := Compiler evaluate: (anArray at: 1) logged: false.
					aSelector := anArray at: 3.
					self uninstallEnhanceClass: aClass selector: aSelector].
			enhancements := nil]
]

{ #category : #'constants access' }
JunAngle class >> unity [
	^self shouldNotImplement
]

{ #category : #copyright }
JunAngle class >> version [
	^'799'
]

{ #category : #'constants access' }
JunAngle class >> zero [
	^self fromRad: 0
]

{ #category : #arithmetic }
JunAngle >> * anAngle [ 
	(anAngle isKindOf: self class)
		ifTrue: [^self class fromRad: rad * anAngle rad].
	^self retry: #* coercing: anAngle
]

{ #category : #arithmetic }
JunAngle >> + anAngle [ 
	(anAngle isKindOf: self class)
		ifTrue: [^self class fromRad: rad + anAngle rad].
	^self retry: #+ coercing: anAngle
]

{ #category : #arithmetic }
JunAngle >> - anAngle [ 
	(anAngle isKindOf: self class)
		ifTrue: [^self class fromRad: rad - anAngle rad].
	^self retry: #- coercing: anAngle
]

{ #category : #arithmetic }
JunAngle >> / anAngle [ 
	(anAngle isKindOf: self class)
		ifTrue: [^self class fromRad: rad / anAngle rad].
	^self retry: #/ coercing: anAngle
]

{ #category : #comparing }
JunAngle >> < anAngle [ 
	(anAngle isKindOf: self class)
		ifTrue: [^rad < anAngle rad].
	^self retry: #< coercing: anAngle
]

{ #category : #comparing }
JunAngle >> <= anAngle [ 
	(anAngle isKindOf: self class)
		ifTrue: [^rad <= anAngle rad].
	^self retry: #<= coercing: anAngle
]

{ #category : #comparing }
JunAngle >> = anAngle [ 
	(anAngle isKindOf: self class) ifTrue: [^rad = anAngle rad].
	^self retry: #= coercing: anAngle
]

{ #category : #comparing }
JunAngle >> > anAngle [ 
	(anAngle isKindOf: self class)
		ifTrue: [^rad > anAngle rad].
	^self retry: #> coercing: anAngle
]

{ #category : #comparing }
JunAngle >> >= anAngle [ 
	(anAngle isKindOf: self class)
		ifTrue: [^rad >= anAngle rad].
	^self retry: #>= coercing: anAngle
]

{ #category : #arithmetic }
JunAngle >> abs [
	^self class fromRad: rad abs
]

{ #category : #converting }
JunAngle >> asAngle [
	^self
]

{ #category : #converting }
JunAngle >> asDegrees [
	^self
]

{ #category : #converting }
JunAngle >> asJunOpenGL3dObject [
	"(JunAngle fromDeg: 30) asJunOpenGL3dObject showWithAxes."

	| compoundObject aBall |
	compoundObject := JunOpenGL3dCompoundObject new.
	aBall := JunOpenGL3dObject 
				pieFrom: 0
				to: self radiansToDegrees
				by: 5
				radius: 1.
	compoundObject add: aBall reversed.
	compoundObject add: aBall.
	compoundObject 
		objectsDo: [:each | each paint: self defaultColor alpha: self defaultAlpha].
	^compoundObject
]

{ #category : #converting }
JunAngle >> asRadians [
	^self
]

{ #category : #coercing }
JunAngle >> coerce: anObject [ 
	^self class coerce: anObject
]

{ #category : #accessing }
JunAngle >> cos [
	cos isNil ifTrue: [cos := rad cos].
	^cos
]

{ #category : #accessing }
JunAngle >> deg [
	deg isNil ifTrue: [deg := rad radiansToDegrees].
	^deg
]

{ #category : #accessing }
JunAngle >> deg: degrees [ 
	self setDeg: degrees
]

{ #category : #accessing }
JunAngle >> degrees [
	^self deg
]

{ #category : #accessing }
JunAngle >> degrees: degrees [ 
	self deg: degrees
]

{ #category : #converting }
JunAngle >> degreesToRadians [
	^self rad
]

{ #category : #'double dispatching' }
JunAngle >> differenceFromDouble: aDouble [

	^aDouble retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> differenceFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> differenceFromFloat: aFloat [

	^aFloat retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> differenceFromFraction: aFraction [

	^aFraction retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> differenceFromInteger: anInteger [

	^anInteger retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> differenceFromPoint: aPoint [

	^aPoint retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> differenceFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> differenceFromSmallInteger: aSmallInteger [

	^self differenceFromInteger: aSmallInteger
]

{ #category : #arithmetic }
JunAngle >> div: aNumber [ 
	^self class fromRad: rad / aNumber
]

{ #category : #comparing }
JunAngle >> equal: anAngle [ 
	self class == anAngle class ifFalse: [^false].
	^(self rad - anAngle rad) abs < self accuracy
]

{ #category : #'double dispatching' }
JunAngle >> equalFromDouble: aDouble [

	^aDouble retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> equalFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> equalFromFloat: aFloat [

	^aFloat retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> equalFromFraction: aFraction [

	^aFraction retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> equalFromInfinitesimal: aNumber [

	^aNumber retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> equalFromInfinity: aNumber [

	^aNumber retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> equalFromInteger: anInteger [

	^anInteger retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> equalFromPoint: aPoint [

	^aPoint retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> equalFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> equalFromSomeNumber: aNumber [
	^aNumber retry: #= coercing: self
]

{ #category : #coercing }
JunAngle >> generality [
	^120
]

{ #category : #comparing }
JunAngle >> hash [
	^rad hash
]

{ #category : #'initialize-release' }
JunAngle >> initialize [
	super initialize.
	rad := deg := sin := cos := tan := nil.
	^self
]

{ #category : #testing }
JunAngle >> isAngle [
	^true
]

{ #category : #testing }
JunAngle >> isZero [
	^rad isZero
]

{ #category : #'double dispatching' }
JunAngle >> lessFromDouble: aDouble [

	^aDouble retry: #< coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> lessFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #< coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> lessFromFloat: aFloat [

	^aFloat retry: #< coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> lessFromFraction: aFraction [

	^aFraction retry: #< coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> lessFromInteger: anInteger [

	^anInteger retry: #< coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> lessFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #< coercing: self
]

{ #category : #comparing }
JunAngle >> max: anAngle [ 
	^self class fromRad: (rad max: anAngle rad)
]

{ #category : #comparing }
JunAngle >> min: anAngle [ 
	^self class fromRad: (rad min: anAngle rad)
]

{ #category : #arithmetic }
JunAngle >> mul: aNumber [ 
	^self class fromRad: rad * aNumber
]

{ #category : #arithmetic }
JunAngle >> negated [
	^self class fromRad: self rad negated
]

{ #category : #printing }
JunAngle >> printOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' degrees: '.
	self deg storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'double dispatching' }
JunAngle >> productFromDouble: aDouble [

	^aDouble retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> productFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> productFromFloat: aFloat [

	^aFloat retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> productFromFraction: aFraction [

	^aFraction retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> productFromInteger: anInteger [

	^anInteger retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> productFromPoint: aPoint [

	^aPoint retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> productFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> productFromSmallInteger: aSmallInteger [

	^self productFromInteger: aSmallInteger
]

{ #category : #'double dispatching' }
JunAngle >> quotientFromDouble: aDouble [

	^aDouble retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> quotientFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> quotientFromFloat: aFloat [

	^aFloat retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> quotientFromFraction: aFraction [

	^aFraction retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> quotientFromInteger: anInteger [

	^anInteger retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> quotientFromPoint: aPoint [

	^aPoint retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> quotientFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #/ coercing: self
]

{ #category : #accessing }
JunAngle >> rad [
	^rad
]

{ #category : #accessing }
JunAngle >> rad: radians [ 
	self setRad: radians
]

{ #category : #accessing }
JunAngle >> radians [
	^self rad
]

{ #category : #accessing }
JunAngle >> radians: radians [ 
	self rad: radians
]

{ #category : #converting }
JunAngle >> radiansToDegrees [
	^self deg
]

{ #category : #'lisp support' }
JunAngle >> radiansToLispList [
	| list |
	list := self lispCons.
	list head: #radians.
	list tail: self radians.
	^list
]

{ #category : #arithmetic }
JunAngle >> reciprocal [
	^self class fromRad: self rad reciprocal
]

{ #category : #coercing }
JunAngle >> retry: aSymbol coercing: aNumber [ 
	aSymbol = #= ifTrue: [Object messageNotUnderstoodSignal handle: [:exception | ^false]
			do: [self generality = aNumber generality ifTrue: [^false]]].
	self generality < aNumber generality ifTrue: [^(aNumber coerce: self)
			perform: aSymbol with: aNumber].
	self generality > aNumber generality ifTrue: [^self perform: aSymbol with: (self coerce: aNumber)].
	^self error: 'coercion attempt failed'
]

{ #category : #private }
JunAngle >> setDeg: degrees [ 
	| aValue |
	aValue := degrees asDouble.
	self setRad: aValue degreesToRadians.
	deg := aValue
]

{ #category : #private }
JunAngle >> setRad: radians [ 
	rad := radians asDouble.
	deg := nil.
	sin := nil.
	cos := nil.
	tan := nil
]

{ #category : #accessing }
JunAngle >> sin [
	sin isNil ifTrue: [sin := rad sin].
	^sin
]

{ #category : #printing }
JunAngle >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' radians: '.
	self rad storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'double dispatching' }
JunAngle >> sumFromDouble: aDouble [

	^aDouble retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> sumFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> sumFromFloat: aFloat [

	^aFloat retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> sumFromFraction: aFraction [

	^aFraction retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> sumFromInteger: anInteger [

	^anInteger retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> sumFromPoint: aPoint [

	^aPoint retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> sumFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunAngle >> sumFromSmallInteger: aSmallInteger [

	^self sumFromInteger: aSmallInteger
]

{ #category : #accessing }
JunAngle >> tan [
	tan isNil ifTrue: [tan := rad tan].
	^tan
]

{ #category : #'lisp support' }
JunAngle >> toLispList [
	"self showLispList: ((JunAngle degrees: 45) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self radiansToLispList.
	^list
]

{ #category : #transforming }
JunAngle >> transformationToRotate [
	^Jun2dTransformation rotate: self
]

{ #category : #transforming }
JunAngle >> transformationToRotate: aLineOrPoint [ 
	^aLineOrPoint transformationToRotate: self
]

{ #category : #transforming }
JunAngle >> transformationToRotateX [
	^Jun3dTransformation rotateX: self
]

{ #category : #transforming }
JunAngle >> transformationToRotateY [
	^Jun3dTransformation rotateY: self
]

{ #category : #transforming }
JunAngle >> transformationToRotateZ [
	^Jun3dTransformation rotateZ: self
]

{ #category : #converting }
JunAngle >> uniformed [
	| radians pi2 |
	pi2 := Double pi * 2.0.
	radians := rad \\ pi2.
	radians negative ifTrue: [radians := pi2 - radians].
	^self class fromRad: radians
]

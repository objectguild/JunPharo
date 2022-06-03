"
Imported by VwImportClass
"
Class {
	#name : #JunSphere,
	#superclass : #JunSolid,
	#instVars : [
		'x0',
		'y0',
		'z0',
		'radius'
	],
	#category : #'Jun-Geometry-Solid'
}

{ #category : #'instance creation' }
JunSphere class >> center: centerPoint radius: radiusValue [ 
	| aCircle |
	aCircle := self new.
	aCircle setCenter: centerPoint.
	aCircle setRadius: radiusValue.
	^aCircle
]

{ #category : #'lisp support' }
JunSphere class >> centerFromTable: aTable for: aSphere [ 
	| aList |
	aList := aTable at: #center ifAbsent: [^aSphere].
	aSphere setCenter: (self pointClass fromLispList: aList).
	^aSphere
]

{ #category : #copyright }
JunSphere class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunSphere class >> example1 [
	"JunSphere example1."

	| aSphere |
	aSphere := JunSphere center: 1 , 1 , 1 radius: 1.
	Transcript
		cr;
		show: aSphere printString.
	Transcript
		cr;
		show: aSphere storeString.
	Transcript
		cr;
		show: 'area: ' , aSphere area printString.
	Transcript
		cr;
		show: 'volume: ' , aSphere volume printString.
	aSphere asJunOpenGL3dObject showWithUnitAxes.
	^aSphere
]

{ #category : #'lisp support' }
JunSphere class >> fromTable: aTable for: aSphere [ 
	"JunSphere fromLispList: (((0 , 0 , 0) sphere: 1) toLispList)."

	self centerFromTable: aTable for: aSphere.
	self radiusFromTable: aTable for: aSphere.
	^aSphere
]

{ #category : #'lisp support' }
JunSphere class >> radiusFromTable: aTable for: aSphere [ 
	| aValue |
	aValue := aTable at: #radius ifAbsent: [^aSphere].
	aSphere setRadius: aValue.
	^aSphere
]

{ #category : #copyright }
JunSphere class >> system [
	^'Jun'
]

{ #category : #copyright }
JunSphere class >> version [
	^'799'
]

{ #category : #comparing }
JunSphere >> = aSphere [ 
	self class == aSphere class ifFalse: [^false].
	^((self x0 = aSphere x0 and: [self y0 = aSphere y0]) 
		and: [self z0 = aSphere z0]) and: [self r = aSphere r]
]

{ #category : #accessing }
JunSphere >> area [
	^4 * Double pi * (self radius ** 2)
]

{ #category : #converting }
JunSphere >> asJunOpenGL3dObject [
	"((1 , 1 , 1) sphere: 1) asJunOpenGL3dObject showWithAxes."

	| aSphere |
	aSphere := JunOpenGL3dObject 
				ball: 3
				radius: self radius
				center: self center.
	aSphere objectsDo: [:each | each paint: self defaultColor].
	^aSphere
]

{ #category : #accessing }
JunSphere >> center [
	^self x0 , self y0 , self z0
]

{ #category : #'lisp support' }
JunSphere >> centerToLispList [
	| list |
	list := self lispCons.
	list head: #center.
	list tail: self center toLispList.
	^list
]

{ #category : #testing }
JunSphere >> isSphere [
	^true
]

{ #category : #printing }
JunSphere >> printOn: aStream [ 
	aStream nextPutAll: '('.
	self center printOn: aStream.
	aStream nextPutAll: ' sphere: '.
	self radius printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #parameters }
JunSphere >> r [
	^self radius
]

{ #category : #accessing }
JunSphere >> radius [
	^radius
]

{ #category : #'lisp support' }
JunSphere >> radiusToLispList [
	| list |
	list := self lispCons.
	list head: #radius.
	list tail: self radius.
	^list
]

{ #category : #private }
JunSphere >> setCenter: aPoint [ 
	| centerPoint |
	centerPoint := self pointClass coerce: aPoint.
	self setX0: centerPoint x.
	self setY0: centerPoint y.
	self setZ0: centerPoint z
]

{ #category : #private }
JunSphere >> setR: aNumber [ 
	self setRadius: aNumber
]

{ #category : #private }
JunSphere >> setRadius: aNumber [ 
	radius := aNumber asDouble
]

{ #category : #private }
JunSphere >> setX0: aNumber [ 
	x0 := aNumber asDouble
]

{ #category : #private }
JunSphere >> setY0: aNumber [ 
	y0 := aNumber asDouble
]

{ #category : #private }
JunSphere >> setZ0: aNumber [ 
	z0 := aNumber asDouble
]

{ #category : #printing }
JunSphere >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' center: '.
	self center storeOn: aStream.
	aStream nextPutAll: ' radius: '.
	self radius storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'lisp support' }
JunSphere >> toLispList [
	"self showLispList: (((0 , 0 , 0) sphere: 1) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self centerToLispList.
	list add: self radiusToLispList.
	^list
]

{ #category : #accessing }
JunSphere >> volume [
	^4 * Double pi * (self radius ** 3) / 3
]

{ #category : #testing }
JunSphere >> whichSideOf: aPlane [ 
	"((0 , 0 , 0) sphere: 1) whichSideOf: ((1 , 0 , 0) bisector: (0 , 1 , 0))."

	"((0 , 0 , 0) sphere: 1) whichSideOf: ((1 , 0 , 0) bisector: (2 , -1 , 0))."

	"((0 , 0 , 0) sphere: 1) whichSideOf: ((-1 , 2 , 0) bisector: (0 , 1 , 0))."

	| sign |
	sign := self center whichSideOf: aPlane.
	sign = 0 ifTrue: [^0].
	(aPlane distanceFromPoint: self center) <= self radius ifTrue: [^0].
	^sign
]

{ #category : #parameters }
JunSphere >> x0 [
	^x0
]

{ #category : #parameters }
JunSphere >> y0 [
	^y0
]

{ #category : #parameters }
JunSphere >> z0 [
	^z0
]

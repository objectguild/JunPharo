"
Imported by VwImportClass
"
Class {
	#name : #JunCircularCylinder,
	#superclass : #JunSphere,
	#instVars : [
		'height'
	],
	#category : #'Jun-Geometry-Solid'
}

{ #category : #'instance creation' }
JunCircularCylinder class >> center: centerPoint radius: radiusValue height: heightValue [ 
	| aCirclarCylinder |
	aCirclarCylinder := self new.
	aCirclarCylinder setCenter: centerPoint.
	aCirclarCylinder setRadius: radiusValue.
	aCirclarCylinder setHeight: heightValue.
	^aCirclarCylinder
]

{ #category : #copyright }
JunCircularCylinder class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunCircularCylinder class >> example1 [
	"JunCircularCylinder example1."

	| aCircularCylinder |
	aCircularCylinder := JunCircularCylinder 
				center: 1 , 1 , 1
				radius: 1
				height: 2.
	Transcript
		cr;
		show: aCircularCylinder printString.
	Transcript
		cr;
		show: aCircularCylinder storeString.
	Transcript
		cr;
		show: 'area: ' , aCircularCylinder area printString.
	Transcript
		cr;
		show: 'volume: ' , aCircularCylinder volume printString.
	aCircularCylinder asJunOpenGL3dObject showWithUnitAxes.
	^aCircularCylinder
]

{ #category : #'lisp support' }
JunCircularCylinder class >> fromTable: aTable for: aCylinder [ 
	"JunCircularCylinder fromLispList: (((0 , 0 , 0) circularCylinder: 1 height: 1) toLispList)."

	super fromTable: aTable for: aCylinder.
	self heightFromTable: aTable for: aCylinder.
	^aCylinder
]

{ #category : #'lisp support' }
JunCircularCylinder class >> heightFromTable: aTable for: aCylinder [ 
	| aValue |
	aValue := aTable at: #height ifAbsent: [^aCylinder].
	aCylinder setHeight: aValue.
	^aCylinder
]

{ #category : #copyright }
JunCircularCylinder class >> system [
	^'Jun'
]

{ #category : #copyright }
JunCircularCylinder class >> version [
	^'799'
]

{ #category : #comparing }
JunCircularCylinder >> = aCircularCylinder [ 
	super = aCircularCylinder ifFalse: [^false].
	^self h = aCircularCylinder h
]

{ #category : #accessing }
JunCircularCylinder >> area [
	^2 * Double pi * self radius * (self height + self radius)
]

{ #category : #converting }
JunCircularCylinder >> asJunOpenGL3dObject [
	"((1 , 1 , 1) circularCylinder: 1 height: 2) asJunOpenGL3dObject showWithAxes."

	| aCylinder |
	aCylinder := (JunOpenGL3dObject 
				cylinderBy: 10
				radius: self radius
				height: self height) translatedBy: self center.
	aCylinder objectsDo: [:each | each paint: self defaultColor].
	^aCylinder
]

{ #category : #parameters }
JunCircularCylinder >> h [
	^self height
]

{ #category : #accessing }
JunCircularCylinder >> height [
	^height
]

{ #category : #'lisp support' }
JunCircularCylinder >> heightToLispList [
	| list |
	list := self lispCons.
	list head: #height.
	list tail: self height.
	^list
]

{ #category : #testing }
JunCircularCylinder >> isCircularCylinder [
	^true
]

{ #category : #testing }
JunCircularCylinder >> isSphere [
	^false
]

{ #category : #printing }
JunCircularCylinder >> printOn: aStream [ 
	aStream nextPutAll: '('.
	self center printOn: aStream.
	aStream nextPutAll: ' circularCylinder: '.
	self radius printOn: aStream.
	aStream nextPutAll: ' height: '.
	self height printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #private }
JunCircularCylinder >> setHeight: aNumber [ 
	height := aNumber asDouble
]

{ #category : #printing }
JunCircularCylinder >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' center: '.
	self center storeOn: aStream.
	aStream nextPutAll: ' radius: '.
	self radius storeOn: aStream.
	aStream nextPutAll: ' height: '.
	self height storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'lisp support' }
JunCircularCylinder >> toLispList [
	"self showLispList: (((0 , 0 , 0) circularCylinder: 1 height: 1) toLispList)."

	| list |
	list := super toLispList.
	list add: self heightToLispList.
	^list
]

{ #category : #accessing }
JunCircularCylinder >> volume [
	^Double pi * (self radius ** 2) * self height
]

{ #category : #testing }
JunCircularCylinder >> whichSideOf: bisector [ 
	| anArray hasPlus hasMinus hasZero |
	anArray := (Array 
				with: (self circleClass center: self center radius: self radius)
				with: (self circleClass center: self center + (0 , 0 , self height)
						radius: self radius)) 
					collect: [:each | each whichSideOf: bisector].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

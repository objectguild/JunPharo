"
Imported by VwImportClass
"
Class {
	#name : #JunCircularCone,
	#superclass : #JunSphere,
	#instVars : [
		'height'
	],
	#category : #'Jun-Geometry-Solid'
}

{ #category : #'instance creation' }
JunCircularCone class >> center: centerPoint radius: radiusValue height: heightValue [ 
	| aCirclarCone |
	aCirclarCone := self new.
	aCirclarCone setCenter: centerPoint.
	aCirclarCone setRadius: radiusValue.
	aCirclarCone setHeight: heightValue.
	^aCirclarCone
]

{ #category : #copyright }
JunCircularCone class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunCircularCone class >> example1 [
	"JunCircularCone example1."

	| aCircularCone |
	aCircularCone := JunCircularCone 
				center: 1 , 1 , 1
				radius: 1
				height: 2.
	Transcript
		cr;
		show: aCircularCone printString.
	Transcript
		cr;
		show: aCircularCone storeString.
	Transcript
		cr;
		show: 'area: ' , aCircularCone area printString.
	Transcript
		cr;
		show: 'volume: ' , aCircularCone volume printString.
	aCircularCone asJunOpenGL3dObject showWithUnitAxes.
	^aCircularCone
]

{ #category : #'lisp support' }
JunCircularCone class >> fromTable: aTable for: aCone [ 
	"JunCircularCone fromLispList: (((0 , 0 , 0) circularCone: 1 height: 1) toLispList)."

	super fromTable: aTable for: aCone.
	self heightFromTable: aTable for: aCone.
	^aCone
]

{ #category : #'lisp support' }
JunCircularCone class >> heightFromTable: aTable for: aCone [ 
	| aValue |
	aValue := aTable at: #height ifAbsent: [^aCone].
	aCone setHeight: aValue.
	^aCone
]

{ #category : #copyright }
JunCircularCone class >> system [
	^'Jun'
]

{ #category : #copyright }
JunCircularCone class >> version [
	^'799'
]

{ #category : #comparing }
JunCircularCone >> = aCircularCone [ 
	super = aCircularCone ifFalse: [^false].
	^self h = aCircularCone h
]

{ #category : #accessing }
JunCircularCone >> area [
	^Double pi * self radius 
		* ((self height ** 2 + (self radius ** 2)) sqrt + self radius)
]

{ #category : #converting }
JunCircularCone >> asJunOpenGL3dObject [
	"((1 , 1 , 1) circularCone: 1 height: 2) asJunOpenGL3dObject showWithAxes."

	| aCone |
	aCone := (JunOpenGL3dObject 
				cone: 10
				radius: self radius
				height: self height) translatedBy: self center.
	aCone objectsDo: [:each | each paint: self defaultColor].
	^aCone
]

{ #category : #parameters }
JunCircularCone >> h [
	^self height
]

{ #category : #accessing }
JunCircularCone >> height [
	^height
]

{ #category : #'lisp support' }
JunCircularCone >> heightToLispList [
	| list |
	list := self lispCons.
	list head: #height.
	list tail: self height.
	^list
]

{ #category : #testing }
JunCircularCone >> isCircularCone [
	^true
]

{ #category : #testing }
JunCircularCone >> isSphere [
	^false
]

{ #category : #printing }
JunCircularCone >> printOn: aStream [ 
	aStream nextPutAll: '('.
	self center printOn: aStream.
	aStream nextPutAll: ' circularCone: '.
	self radius printOn: aStream.
	aStream nextPutAll: ' height: '.
	self height printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #private }
JunCircularCone >> setHeight: aNumber [ 
	height := aNumber asDouble
]

{ #category : #printing }
JunCircularCone >> storeOn: aStream [ 
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
JunCircularCone >> toLispList [
	"self showLispList: (((0 , 0 , 0) circularCone: 1 height: 1) toLispList)."

	| list |
	list := super toLispList.
	list add: self heightToLispList.
	^list
]

{ #category : #accessing }
JunCircularCone >> volume [
	^Double pi * (self radius ** 2) * self height / 3
]

{ #category : #testing }
JunCircularCone >> whichSideOf: bisector [ 
	| anArray hasPlus hasMinus hasZero |
	anArray := (Array 
				with: (self circleClass center: self center radius: self radius)
				with: self center + (0 , 0 , self height)) 
					collect: [:each | each whichSideOf: bisector].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

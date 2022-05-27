"
Imported by VwImportClass
"
Class {
	#name : #JunCircle,
	#superclass : #JunSurface,
	#instVars : [
		'radius'
	],
	#category : #'Jun-Geometry-Surfaces'
}

{ #category : #'lisp support' }
JunCircle class >> centerFromTable: aTable for: aCircle [ 
	| aList |
	aList := aTable at: #center ifAbsent: [^aCircle].
	aCircle setCenter: (self pointClass fromLispList: aList).
	^aCircle
]

{ #category : #copyright }
JunCircle class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'lisp support' }
JunCircle class >> fromTable: aTable for: aCircle [ 
	"Jun2dCircle fromLispList: (((0 , 0) radius: 1) toLispList)."
	"Jun3dCircle fromLispList: (((0 , 0 , 0) radius: 1) toLispList)."

	self radiusFromTable: aTable for: aCircle.
	self centerFromTable: aTable for: aCircle.
	^aCircle
]

{ #category : #'lisp support' }
JunCircle class >> radiusFromTable: aTable for: aCircle [ 
	| aValue |
	aValue := aTable at: #radius ifAbsent: [^aCircle].
	aCircle setRadius: aValue.
	^aCircle
]

{ #category : #copyright }
JunCircle class >> system [
	^'Jun'
]

{ #category : #copyright }
JunCircle class >> version [
	^'799'
]

{ #category : #comparing }
JunCircle >> = aCircle [ 
	self class == aCircle class ifFalse: [^false].
	^self radius = aCircle radius
]

{ #category : #accessing }
JunCircle >> area [
	^Double pi * (self radius ** 2)
]

{ #category : #converting }
JunCircle >> asArrayOfPlanes [
	^Array with: self asPlane
]

{ #category : #converting }
JunCircle >> asArrayOfTriangles [
	^Array with: self asTriangle
]

{ #category : #converting }
JunCircle >> asPlane [
	^self subclassResponsibility
]

{ #category : #converting }
JunCircle >> asTriangle [
	^self subclassResponsibility
]

{ #category : #accessing }
JunCircle >> center [
	^self pointClass zero
]

{ #category : #'lisp support' }
JunCircle >> centerToLispList [
	| list |
	list := self lispCons.
	list head: #center.
	list tail: self center toLispList.
	^list
]

{ #category : #comparing }
JunCircle >> equal: aCircle [ 
	self class == aCircle class ifFalse: [^false].
	^(self radius - aCircle radius) abs < self accuracy
]

{ #category : #testing }
JunCircle >> isCircle [
	^true
]

{ #category : #printing }
JunCircle >> printOn: aStream [ 
	aStream nextPutAll: '('.
	self center printOn: aStream.
	aStream nextPutAll: ' radius: '.
	self radius printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #parameters }
JunCircle >> r [
	^self radius
]

{ #category : #accessing }
JunCircle >> radius [
	^radius
]

{ #category : #'lisp support' }
JunCircle >> radiusToLispList [
	| list |
	list := self lispCons.
	list head: #radius.
	list tail: self radius.
	^list
]

{ #category : #private }
JunCircle >> setR: aNumber [ 
	self setRadius: aNumber
]

{ #category : #private }
JunCircle >> setRadius: aNumber [ 
	radius := aNumber asDouble
]

{ #category : #printing }
JunCircle >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' center: '.
	self center storeOn: aStream.
	aStream nextPutAll: ' radius: '.
	self radius storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'lisp support' }
JunCircle >> toLispList [
	"self showLispList: (((0 , 0) radius: 1) toLispList)."
	"self showLispList: (((0 , 0 , 0) radius: 1) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self radiusToLispList.
	list add: self centerToLispList.
	^list
]

{ #category : #functions }
JunCircle >> trackPoints [
	"
	| centerPoint radiusValue upVector aCircle aPolyline |
	centerPoint := 1 / 3 , (1 / 3) , (1 / 3).
	radiusValue := centerPoint distance: 0 , 0 , 1.
	upVector := 1 , 1 , 1.
	aCircle := centerPoint radius: radiusValue upVector: upVector.
	aPolyline := Jun3dPolyline points: aCircle trackPoints.
	aPolyline asJunOpenGL3dObject showWithAxes.
	"

	^self trackPointsBy: 36
]

{ #category : #functions }
JunCircle >> trackPointsBy: divisionNumber [ 
	^self subclassResponsibility
]

{ #category : #transforming }
JunCircle >> transform: aTransformation [ 
	^self class center: (self center transform: aTransformation)
		radius: ((0 , 0 , 0 to: self radius , 0 , 0) transform: aTransformation) 
				length
]

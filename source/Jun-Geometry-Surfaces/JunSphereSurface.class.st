"
Imported by VwImportClass
"
Class {
	#name : #JunSphereSurface,
	#superclass : #JunSurface,
	#instVars : [
		'center',
		'radius'
	],
	#category : #'Jun-Geometry-Surfaces'
}

{ #category : #'instance creation' }
JunSphereSurface class >> center: aJun3dPoint radius: aNumber [
	| sphere |
	sphere := self new.
	sphere center: aJun3dPoint.
	sphere radius: aNumber.
	^sphere
]

{ #category : #'lisp support' }
JunSphereSurface class >> centerFromTable: aTable for: aSphereSurface [ 
	| aList |
	aList := aTable at: #center ifAbsent: [^aSphereSurface].
	aSphereSurface center: (self pointClass fromLispList: aList).
	^aSphereSurface
]

{ #category : #copyright }
JunSphereSurface class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunSphereSurface class >> exampleSphereSurface [
	"JunSphereSurface exampleSphereSurface."

	^JunSphereSurface center: 0 , 0 , 0 radius: 1
]

{ #category : #'lisp support' }
JunSphereSurface class >> fromTable: aTable for: aSphereSurface [ 
	"JunSphereSurface fromLispList: ((JunSphereSurface exampleSphereSurface) toLispList)."

	self centerFromTable: aTable for: aSphereSurface.
	self radiusFromTable: aTable for: aSphereSurface.
	^aSphereSurface
]

{ #category : #'lisp support' }
JunSphereSurface class >> radiusFromTable: aTable for: aSphereSurface [ 
	| aValue |
	aValue := aTable at: #radius ifAbsent: [^aSphereSurface].
	aSphereSurface radius: aValue.
	^aSphereSurface
]

{ #category : #copyright }
JunSphereSurface class >> system [
	^'Jun'
]

{ #category : #copyright }
JunSphereSurface class >> version [
	^'799'
]

{ #category : #comparing }
JunSphereSurface >> = sphereSurface [ 
	self class == sphereSurface class ifFalse: [^false].
	^self radius = sphereSurface radius 
		and: [self center = sphereSurface center]
]

{ #category : #accessing }
JunSphereSurface >> center [
	^center
]

{ #category : #accessing }
JunSphereSurface >> center: aJun3dPoint [
	center := aJun3dPoint
]

{ #category : #'lisp support' }
JunSphereSurface >> centerToLispList [
	| list |
	list := self lispCons.
	list head: #center.
	list tail: self center toLispList.
	^list
]

{ #category : #functions }
JunSphereSurface >> crossPointsWithLine: aJun3dLine [ 
	| nearestPointOnLine distance shift shiftVector |
	nearestPointOnLine := aJun3dLine nearestPointFromPoint: self center.
	distance := self center distance: nearestPointOnLine.
	distance > self radius ifTrue: [^Array new].
	(distance - self radius) abs < self class accuracy ifTrue: [^Array with: nearestPointOnLine].
	shift := (radius * radius - (distance * distance)) sqrt.
	shiftVector := (aJun3dLine to - aJun3dLine from) unitVector * shift.
	^Array with: nearestPointOnLine + shiftVector with: nearestPointOnLine - shiftVector
]

{ #category : #testing }
JunSphereSurface >> is3d [
	^true
]

{ #category : #accessing }
JunSphereSurface >> radius [
	^radius
]

{ #category : #accessing }
JunSphereSurface >> radius: aNumber [
	radius := aNumber asDouble
]

{ #category : #'lisp support' }
JunSphereSurface >> radiusToLispList [
	| list |
	list := self lispCons.
	list head: #radius.
	list tail: self radius.
	^list
]

{ #category : #printing }
JunSphereSurface >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' center: '.
	self center storeOn: aStream.
	aStream nextPutAll: ' radius: '.
	self radius storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'lisp support' }
JunSphereSurface >> toLispList [
	"self showLispList: ((JunSphereSurface exampleSphereSurface) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self centerToLispList.
	list add: self radiusToLispList.
	^list
]

{ #category : #testing }
JunSphereSurface >> whichSideOf: bisector [ 
	| sign |
	sign := self center whichSideOf: bisector.
	sign = 0 ifTrue: [^0].
	(bisector distanceFromPoint: self center) <= self radius ifTrue: [^0].
	^sign
]

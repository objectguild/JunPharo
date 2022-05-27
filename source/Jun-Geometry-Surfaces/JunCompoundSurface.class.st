"
Imported by VwImportClass
"
Class {
	#name : #JunCompoundSurface,
	#superclass : #JunSurface,
	#instVars : [
		'components',
		'boundingBox'
	],
	#category : #'Jun-Geometry-Surfaces'
}

{ #category : #'instance creation' }
JunCompoundSurface class >> components: anArrayOfJunSurface [ 
	| surface |
	surface := self new.
	surface setComponents: anArrayOfJunSurface.
	^surface
]

{ #category : #'lisp support' }
JunCompoundSurface class >> componentsFromTable: aTable for: aCompoundSurface [ 
	| aList |
	aList := aTable at: #components ifAbsent: [^aCompoundSurface].
	aCompoundSurface 
		setComponents: (aList collect: [:each | self fromLispList: each]) asArray.
	^aCompoundSurface
]

{ #category : #copyright }
JunCompoundSurface class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunCompoundSurface class >> exampleCompoundSurface [
	"JunCompoundSurface exampleCompoundSurface."

	| aCollection |
	aCollection := OrderedCollection new.
	aCollection add: (0 , 0 radius: 1).
	aCollection add: (0 , 0 , 0 radius: 1).
	aCollection add: JunNurbsSurface exampleNurbsSurface.
	aCollection add: (0 , 0 , 0 plane: 1 , 1 , 0 and: 1 , 1 , 1).
	aCollection add: Jun3dPolygon examplePolygon.
	aCollection add: JunSphereSurface exampleSphereSurface.
	aCollection add: (0 , 0 triangle: 1 , 0 and: 1 , 1).
	aCollection add: (0 , 0 , 0 triangle: 1 , 1 , 0 and: 1 , 1 , 1).
	^JunCompoundSurface components: aCollection
]

{ #category : #'lisp support' }
JunCompoundSurface class >> fromTable: aTable for: aCompoundSurface [ 
	"JunCompoundSurface fromLispList: ((JunCompoundSurface exampleCompoundSurface) toLispList)."

	self componentsFromTable: aTable for: aCompoundSurface.
	^aCompoundSurface
]

{ #category : #copyright }
JunCompoundSurface class >> system [
	^'Jun'
]

{ #category : #copyright }
JunCompoundSurface class >> version [
	^'799'
]

{ #category : #comparing }
JunCompoundSurface >> = aCompoundSurface [ 
	| size |
	self class == aCompoundSurface class ifFalse: [^false].
	(size := self components size) = aCompoundSurface components size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			(self components at: index) = (aCompoundSurface components at: index) 
				ifFalse: [^false]].
	^true
]

{ #category : #'bounds access' }
JunCompoundSurface >> boundingBox [
	boundingBox isNil ifTrue: [boundingBox := self preferredBoundingBox].
	^boundingBox
]

{ #category : #accessing }
JunCompoundSurface >> components [
	^components
]

{ #category : #'lisp support' }
JunCompoundSurface >> componentsToLispList [
	| list |
	list := self lispCons.
	list head: #components.
	list tail: (self class defaultLispConsClass 
				list: (self components collect: [:each | each toLispList])).
	^list
]

{ #category : #functions }
JunCompoundSurface >> distanceFromPoint: aJun3dPoint [ 
	^(self nearestPointFromPoint: aJun3dPoint) distance: aJun3dPoint
]

{ #category : #comparing }
JunCompoundSurface >> equal: aCompoundSurface [ 
	| size |
	self class == aCompoundSurface class ifFalse: [^false].
	(size := self components size) = aCompoundSurface components size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self components at: index) 
				equal: (aCompoundSurface components at: index)) ifFalse: [^false]].
	^true
]

{ #category : #functions }
JunCompoundSurface >> intersectingPointWithLine: aJun3dLine [ 
	components do: [ :surface | | intersectingPoint |
		intersectingPoint := surface intersectingPointWithLine: aJun3dLine.
		intersectingPoint notNil ifTrue: [ ^intersectingPoint]].
	^nil
]

{ #category : #functions }
JunCompoundSurface >> intersectingPointWithLineSegment: aJun3dLine [ 
	components do: [ :surface | | intersectingPoint |
		intersectingPoint := surface intersectingPointWithLineSegment: aJun3dLine.
		intersectingPoint notNil ifTrue: [ ^intersectingPoint]].
	^nil
]

{ #category : #testing }
JunCompoundSurface >> isCompoundSurface [
	^true
]

{ #category : #functions }
JunCompoundSurface >> nearestPointFromPoint: aJun3dPoint [ 
	| thePoint minDistance |
	thePoint := components first nearestPointFromPoint: aJun3dPoint.
	minDistance := aJun3dPoint distance: thePoint.
	2 to: components size
		do: 
			[:index | 
			| point distance |
			point := (components at: index)
						nearestPointFromPoint: aJun3dPoint.
			distance := aJun3dPoint distance: point.
			minDistance > distance
				ifTrue: 
					[thePoint := point.
					minDistance := distance]].
	^thePoint
]

{ #category : #private }
JunCompoundSurface >> preferredBoundingBox [
	| bounds |
	bounds := components first boundingBox.
	2 to: components size do: [:index | bounds := bounds merge: (components at: index) boundingBox].
	^bounds
]

{ #category : #private }
JunCompoundSurface >> setComponents: anArrayOfJunSurface [ 
	components := anArrayOfJunSurface.
	boundingBox := nil
]

{ #category : #'lisp support' }
JunCompoundSurface >> toLispList [
	"self showLispList: ((JunCompoundSurface exampleCompoundSurface) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self componentsToLispList.
	^list
]

{ #category : #testing }
JunCompoundSurface >> whichSideOf: bisector [ 
	| anArray hasPlus hasMinus hasZero |
	anArray := self components 
				collect: [:component | component whichSideOf: bisector].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

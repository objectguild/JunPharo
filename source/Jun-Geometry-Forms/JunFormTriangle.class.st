"
Imported by VwImportClass
"
Class {
	#name : #JunFormTriangle,
	#superclass : #JunAbstractObject,
	#instVars : [
		'p1',
		'p2',
		'p3'
	],
	#category : #'Jun-Geometry-Forms'
}

{ #category : #copyright }
JunFormTriangle class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunFormTriangle class >> p1: aPoint1 p2: aPoint2 p3: aPoint3 [ 
	"JunFormTriangle p1: 60@32 p2: 88@12 p3: 124@4."

	| aTriangle |
	aTriangle := self new.
	aTriangle setP1: aPoint1.
	aTriangle setP2: aPoint2.
	aTriangle setP3: aPoint3.
	^aTriangle
]

{ #category : #copyright }
JunFormTriangle class >> system [
	^'Jun'
]

{ #category : #copyright }
JunFormTriangle class >> version [
	^'799'
]

{ #category : #'instance creation' }
JunFormTriangle class >> vertexPoints: pointArray [ 
	"JunFormTriangle vertexPoints: ((OrderedCollection new) add: 60@32; add: 88@12; add: 124@4; yourself)."

	^self
		p1: (pointArray at: 1)
		p2: (pointArray at: 2)
		p3: (pointArray at: 3)
]

{ #category : #converting }
JunFormTriangle >> asPointArray [
	^Array
		with: self p1
		with: self p2
		with: self p3
]

{ #category : #converting }
JunFormTriangle >> asPolyline [
	^self asPointArray
]

{ #category : #converting }
JunFormTriangle >> asPolylineLoop [
	^Array
		with: self p1
		with: self p2
		with: self p3
		with: self p1
]

{ #category : #accessing }
JunFormTriangle >> p1 [
	^p1
]

{ #category : #accessing }
JunFormTriangle >> p2 [
	^p2
]

{ #category : #accessing }
JunFormTriangle >> p3 [
	^p3
]

{ #category : #accessing }
JunFormTriangle >> points [
	^self asPointArray
]

{ #category : #printing }
JunFormTriangle >> printOn: aStream [ 
	| aCollection aPoint |
	aStream nextPutAll: 'triangle ('.
	aCollection := self points.
	1 to: aCollection size
		do: 
			[:index | 
			aPoint := aCollection at: index.
			aStream nextPutAll: aPoint printString.
			index < aCollection size ifTrue: [aStream nextPutAll: ', ']].
	aStream nextPutAll: ')'
]

{ #category : #private }
JunFormTriangle >> setP1: aPoint [ 
	p1 := aPoint
]

{ #category : #private }
JunFormTriangle >> setP2: aPoint [ 
	p2 := aPoint
]

{ #category : #private }
JunFormTriangle >> setP3: aPoint [ 
	p3 := aPoint
]

"
Imported by VwImportClass
"
Class {
	#name : #JunFormTriangleNode,
	#superclass : #JunFormTriangle,
	#instVars : [
		'm1',
		'm2',
		'm3',
		'sp1',
		'sp2',
		'sp3',
		'tn1',
		'tn2',
		'tn3'
	],
	#category : #'Jun-Geometry-Forms'
}

{ #category : #copyright }
JunFormTriangleNode class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunFormTriangleNode class >> system [
	^'Jun'
]

{ #category : #copyright }
JunFormTriangleNode class >> version [
	^'799'
]

{ #category : #'instance creation' }
JunFormTriangleNode class >> vertexPoints: pointArray spinePoints: spinePoints [ 
	| triangleNode |
	triangleNode := super vertexPoints: pointArray.
	triangleNode setSp1: (spinePoints detect: [:each | each = triangleNode m1]
			ifNone: [nil]).
	triangleNode setSp2: (spinePoints detect: [:each | each = triangleNode m2]
			ifNone: [nil]).
	triangleNode setSp3: (spinePoints detect: [:each | each = triangleNode m3]
			ifNone: [nil]).
	^triangleNode
]

{ #category : #accessing }
JunFormTriangleNode >> againstPointAtMidPoint: aPoint [ 
	self m1 = aPoint ifTrue: [^self p3].
	self m2 = aPoint ifTrue: [^self p1].
	self m3 = aPoint ifTrue: [^self p2].
	^nil
]

{ #category : #enumerating }
JunFormTriangleNode >> do: aBlock [ 
	self do: aBlock visited: Set new
]

{ #category : #enumerating }
JunFormTriangleNode >> do: aBlock visited: aSet [ 
	aSet add: self.
	aBlock value: self.
	(self tn1 notNil and: [(aSet includes: self tn1) not])
		ifTrue: [self tn1 do: aBlock visited: aSet].
	(self tn2 notNil and: [(aSet includes: self tn2) not])
		ifTrue: [self tn2 do: aBlock visited: aSet].
	(self tn3 notNil and: [(aSet includes: self tn3) not])
		ifTrue: [self tn3 do: aBlock visited: aSet]
]

{ #category : #'triangle accessing' }
JunFormTriangleNode >> flushTriangleNodes [
	self tn1: nil.
	self tn2: nil.
	self tn3: nil
]

{ #category : #testing }
JunFormTriangleNode >> isJunction [
	^false
]

{ #category : #testing }
JunFormTriangleNode >> isSleeve [
	^false
]

{ #category : #testing }
JunFormTriangleNode >> isTerminal [
	^false
]

{ #category : #accessing }
JunFormTriangleNode >> m1 [
	m1 isNil ifTrue: [m1 := self p1 + (self p2 - self p1 / (2 @ 2))].
	^m1
]

{ #category : #accessing }
JunFormTriangleNode >> m2 [
	m2 isNil ifTrue: [m2 := self p2 + (self p3 - self p2 / (2 @ 2))].
	^m2
]

{ #category : #accessing }
JunFormTriangleNode >> m3 [
	m3 isNil ifTrue: [m3 := self p3 + (self p1 - self p3 / (2 @ 2))].
	^m3
]

{ #category : #accessing }
JunFormTriangleNode >> pointsAtMidPoint: aPoint [ 
	self m1 = aPoint ifTrue: [^Array with: self p1 with: self p2].
	self m2 = aPoint ifTrue: [^Array with: self p2 with: self p3].
	self m3 = aPoint ifTrue: [^Array with: self p3 with: self p1].
	^nil
]

{ #category : #printing }
JunFormTriangleNode >> printOn: aStream [ 
	| aCollection aPoint |
	self isTerminal ifTrue: [aStream nextPutAll: 'terminal'].
	self isSleeve ifTrue: [aStream nextPutAll: 'sleeve'].
	self isJunction ifTrue: [aStream nextPutAll: 'junction'].
	aStream nextPutAll: 'Triangle ('.
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
JunFormTriangleNode >> setP1: aPoint [ 
	super setP1: aPoint.
	m3 := nil.
	m1 := nil
]

{ #category : #private }
JunFormTriangleNode >> setP2: aPoint [ 
	super setP2: aPoint.
	m1 := nil.
	m2 := nil
]

{ #category : #private }
JunFormTriangleNode >> setP3: aPoint [ 
	super setP3: aPoint.
	m2 := nil.
	m3 := nil
]

{ #category : #private }
JunFormTriangleNode >> setSp1: aPoint [ 
	sp1 := aPoint
]

{ #category : #private }
JunFormTriangleNode >> setSp2: aPoint [ 
	sp2 := aPoint
]

{ #category : #private }
JunFormTriangleNode >> setSp3: aPoint [ 
	sp3 := aPoint
]

{ #category : #accessing }
JunFormTriangleNode >> sp1 [
	^sp1
]

{ #category : #accessing }
JunFormTriangleNode >> sp2 [
	^sp2
]

{ #category : #accessing }
JunFormTriangleNode >> sp3 [
	^sp3
]

{ #category : #accessing }
JunFormTriangleNode >> spinePoints [
	| aStream |
	aStream := WriteStream on: (Array new: 3).
	self sp1 isNil ifFalse: [aStream nextPut: self sp1].
	self sp2 isNil ifFalse: [aStream nextPut: self sp2].
	self sp3 isNil ifFalse: [aStream nextPut: self sp3].
	^aStream contents
]

{ #category : #'triangle accessing' }
JunFormTriangleNode >> threeTriangles: midPoint1 with: midPoint2 [ 
	| againstPoint1 againstPoint2 otherPoint arrayOfTrianglePoints trianglePoints |
	againstPoint1 := self againstPointAtMidPoint: midPoint1.
	againstPoint2 := self againstPointAtMidPoint: midPoint2.
	otherPoint := self points detect: [:p | (p = againstPoint1) not and: [(p = againstPoint2) not]].
	arrayOfTrianglePoints := Array new: 3.
	trianglePoints := Array
				with: midPoint1
				with: midPoint2
				with: otherPoint.
	arrayOfTrianglePoints at: 1 put: trianglePoints.
	(midPoint1 dist: againstPoint1)
		< (midPoint2 dist: againstPoint2)
		ifTrue: 
			[trianglePoints := Array
						with: midPoint1
						with: midPoint2
						with: againstPoint1.
			arrayOfTrianglePoints at: 2 put: trianglePoints.
			trianglePoints := Array
						with: midPoint1
						with: againstPoint1
						with: againstPoint2.
			arrayOfTrianglePoints at: 3 put: trianglePoints]
		ifFalse: 
			[trianglePoints := Array
						with: midPoint1
						with: midPoint2
						with: againstPoint2.
			arrayOfTrianglePoints at: 2 put: trianglePoints.
			trianglePoints := Array
						with: midPoint2
						with: againstPoint2
						with: againstPoint1.
			arrayOfTrianglePoints at: 3 put: trianglePoints].
	^arrayOfTrianglePoints
]

{ #category : #'triangle accessing' }
JunFormTriangleNode >> tn1 [
	^tn1
]

{ #category : #'triangle accessing' }
JunFormTriangleNode >> tn1: triangleNode [ 
	tn1 := triangleNode
]

{ #category : #'triangle accessing' }
JunFormTriangleNode >> tn2 [
	^tn2
]

{ #category : #'triangle accessing' }
JunFormTriangleNode >> tn2: triangleNode [ 
	tn2 := triangleNode
]

{ #category : #'triangle accessing' }
JunFormTriangleNode >> tn3 [
	^tn3
]

{ #category : #'triangle accessing' }
JunFormTriangleNode >> tn3: triangleNode [ 
	tn3 := triangleNode
]

{ #category : #'triangle accessing' }
JunFormTriangleNode >> triangleNodes [
	| aStream |
	aStream := WriteStream on: (Array new: 3).
	self tn1 isNil ifFalse: [aStream nextPut: self tn1].
	self tn2 isNil ifFalse: [aStream nextPut: self tn2].
	self tn3 isNil ifFalse: [aStream nextPut: self tn3].
	^aStream contents
]

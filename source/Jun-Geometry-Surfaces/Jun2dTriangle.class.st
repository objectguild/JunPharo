"
Imported by VwImportClass
"
Class {
	#name : #Jun2dTriangle,
	#superclass : #JunTriangle,
	#category : #'Jun-Geometry-Surfaces'
}

{ #category : #copyright }
Jun2dTriangle class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun2dTriangle class >> example1 [
	"Jun2dTriangle example1."

	| aTriangle |
	aTriangle := Jun2dTriangle 
				on: 1 , 0
				on: 0 , 1
				on: 0 , 0.
	Transcript
		cr;
		show: aTriangle printString.
	Transcript
		cr;
		show: aTriangle storeString.
	Transcript
		cr;
		show: 'area: ' , aTriangle area printString.
	Transcript
		cr;
		show: 'volume: ' , aTriangle volume printString.
	aTriangle asJunOpenGL3dObject showWithUnitAxes.
	^aTriangle
]

{ #category : #'instance creation' }
Jun2dTriangle class >> on: centerPoint distance: aNumber [ 
	"(Jun2dTriangle
		on: (0.5 , 0.5)
		distance: 0.5) asJunOpenGL3dObject showWithUnitAxes."

	^self 
		on: centerPoint
		distance: aNumber
		rightVector: 1 , 0
]

{ #category : #'instance creation' }
Jun2dTriangle class >> on: centerPoint distance: aNumber rightVector: rightVector [ 
	"(Jun2dTriangle
		on: (0.5 , 0.5)
		distance: 0.5d sqrt
		rightVector: -1 , -1) asJunOpenGL3dObject showWithUnitAxes."

	| a3dTriangle |
	a3dTriangle := Jun3dTriangle 
				on: centerPoint x , centerPoint y , 0
				normalVector: 0 , 0 , 1
				distance: aNumber
				rightVector: rightVector x , rightVector y , 0.
	^self 
		on: a3dTriangle p1 x , a3dTriangle p1 y
		on: a3dTriangle p2 x , a3dTriangle p2 y
		on: a3dTriangle p3 x , a3dTriangle p3 y
]

{ #category : #copyright }
Jun2dTriangle class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun2dTriangle class >> version [
	^'799'
]

{ #category : #functions }
Jun2dTriangle >> areaWithSign [
	"(Jun2dTriangle on: (0 , 0) on: (0 , 1) on: (1 , 1)) areaWithSign."

	"(Jun2dTriangle on: (0 , 0) on: (0 , 1) on: (1 , 1)) reversed areaWithSign."

	| areaWithSign |
	areaWithSign := 0.
	areaWithSign := areaWithSign 
				+ ((self first x - self second x) * (self first y + self second y)).
	areaWithSign := areaWithSign 
				+ ((self second x - self third x) * (self second y + self third y)).
	areaWithSign := areaWithSign 
				+ ((self third x - self first x) * (self third y + self first y)).
	areaWithSign := areaWithSign / 2.
	^areaWithSign
]

{ #category : #functions }
Jun2dTriangle >> centerOfGravity [
	"((0 , 0) triangle: (0 , 1) and: (1 , 1)) centerOfGravity."

	^self pointClass 
		x: (self p1 x + self p2 x + self p3 x) / 3
		y: (self p1 y + self p2 y + self p3 y) / 3
]

{ #category : #testing }
Jun2dTriangle >> containsPoint: aPoint [ 
	"((1 , 0) triangle: (0 , 1) and: (0 , 0)) containsPoint: ((1/3) , (1/3))."

	self threeLines 
		do: [:aLine | (aPoint whichSideOf: aLine) < 0 ifTrue: [^false]].
	^true
]

{ #category : #testing }
Jun2dTriangle >> is2d [
	^true
]

{ #category : #functions }
Jun2dTriangle >> normalUnitVector [
	^self shouldNotImplement
]

{ #category : #functions }
Jun2dTriangle >> normalVector [
	^self shouldNotImplement
]

{ #category : #dividing }
Jun2dTriangle >> tableDividedBy: aLine [ 
	| aPlane aTable |
	aPlane := self planeClass 
				on: aLine from as3dPoint
				on: aLine to as3dPoint
				on: 0 , 0 , 1.
	aTable := (Jun3dTriangle 
				on: self p1 as3dPoint
				on: self p2 as3dPoint
				on: self p3 as3dPoint) tableDividedBy: aPlane.
	aTable at: #positives
		put: ((aTable at: #positives) collect: 
					[:each | 
					self class 
						on: each p1 as2dPoint
						on: each p2 as2dPoint
						on: each p3 as2dPoint]).
	aTable at: #negatives
		put: ((aTable at: #negatives) collect: 
					[:each | 
					self class 
						on: each p1 as2dPoint
						on: each p2 as2dPoint
						on: each p3 as2dPoint]).
	aTable at: #zeros
		put: ((aTable at: #zeros) collect: 
					[:each | 
					self class 
						on: each p1 as2dPoint
						on: each p2 as2dPoint
						on: each p3 as2dPoint]).
	aTable at: #points
		put: ((aTable at: #points) collect: [:each | each as2dPoint]).
	^aTable
]

{ #category : #functions }
Jun2dTriangle >> threeLines [
	| threeLines aLine |
	threeLines := Array new: 3.
	aLine := self p1 to: self p2.
	threeLines at: 1 put: aLine.
	aLine := self p2 to: self p3.
	threeLines at: 2 put: aLine.
	aLine := self p3 to: self p1.
	threeLines at: 3 put: aLine.
	^threeLines
]

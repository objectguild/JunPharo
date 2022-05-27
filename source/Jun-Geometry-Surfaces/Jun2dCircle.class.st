"
Imported by VwImportClass
"
Class {
	#name : #Jun2dCircle,
	#superclass : #JunCircle,
	#instVars : [
		'x0',
		'y0'
	],
	#category : #'Jun-Geometry-Surfaces'
}

{ #category : #'instance creation' }
Jun2dCircle class >> center: centerPoint radius: radiusValue [ 
	| aCircle |
	aCircle := self new.
	aCircle setCenter: centerPoint.
	aCircle setRadius: radiusValue.
	^aCircle
]

{ #category : #copyright }
Jun2dCircle class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun2dCircle class >> example1 [
	"Jun2dCircle example1."

	| aCircle |
	aCircle := Jun2dCircle center: 1 , 1 radius: 1.
	Transcript
		cr;
		show: aCircle printString.
	Transcript
		cr;
		show: aCircle storeString.
	Transcript
		cr;
		show: 'area: ' , aCircle area printString.
	Transcript
		cr;
		show: 'volume: ' , aCircle volume printString.
	aCircle asJunOpenGL3dObject showWithUnitAxes.
	^aCircle
]

{ #category : #'instance creation' }
Jun2dCircle class >> radius: radiusValue [ 
	"(Jun2dCircle radius: 1) asJunOpenGL3dObject showWithUnitAxes."

	| aCircle |
	aCircle := self new.
	aCircle setCenter: 0 , 0.
	aCircle setRadius: radiusValue.
	^aCircle
]

{ #category : #copyright }
Jun2dCircle class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun2dCircle class >> version [
	^'799'
]

{ #category : #comparing }
Jun2dCircle >> = aCircle [ 
	super = aCircle ifFalse: [^false].
	^self x0 = aCircle x0 and: [self y0 = aCircle y0]
]

{ #category : #converting }
Jun2dCircle >> asJunOpenGL3dObject [
	"(1 , 1 radius: 1) asJunOpenGL3dObject showWithAxes."

	| aCircle |
	aCircle := (JunOpenGL3dObject circleBy: 10 radius: self radius) 
				translatedBy: self center.
	aCircle objectsDo: [:each | each paint: self defaultColor].
	^aCircle
]

{ #category : #converting }
Jun2dCircle >> asPlane [
	"(0.5 , 0.5 radius: 0.5) asPlane asJunOpenGL3dObject showWithUnitAxes."

	| centerPoint aLine aPoint |
	centerPoint := self center , 0.
	aLine := centerPoint to: self center , 1.
	aPoint := centerPoint + (self radius , 0 , 0).
	^self planeClass 
		on: aPoint
		on: (aPoint transform: (Jun3dTransformation rotate: (JunAngle fromDeg: 120)
						around: aLine))
		on: (aPoint transform: (Jun3dTransformation rotate: (JunAngle fromDeg: 240)
						around: aLine))
]

{ #category : #converting }
Jun2dCircle >> asTriangle [
	"(0.5 , 0.5 radius: 0.5) asTriangle asJunOpenGL3dObject showWithUnitAxes."

	| centerPoint aPoint |
	centerPoint := self center.
	aPoint := centerPoint + (self radius , 0).
	^self triangleClass 
		on: aPoint
		on: (aPoint transform: (Jun2dTransformation rotate: (JunAngle fromDeg: 120)
						around: centerPoint))
		on: (aPoint transform: (Jun2dTransformation rotate: (JunAngle fromDeg: 240)
						around: centerPoint))
]

{ #category : #accessing }
Jun2dCircle >> center [
	^self x0 , self y0
]

{ #category : #comparing }
Jun2dCircle >> equal: aCircle [ 
	(super equal: aCircle) ifFalse: [^false].
	^(self x0 - aCircle x0) abs < self accuracy 
		and: [(self y0 - aCircle y0) abs < self accuracy]
]

{ #category : #testing }
Jun2dCircle >> is2d [
	^true
]

{ #category : #private }
Jun2dCircle >> setCenter: aPoint [ 
	| centerPoint |
	centerPoint := self pointClass coerce: aPoint.
	self setX0: centerPoint x.
	self setY0: centerPoint y
]

{ #category : #private }
Jun2dCircle >> setX0: aNumber [ 
	x0 := aNumber asDouble
]

{ #category : #private }
Jun2dCircle >> setY0: aNumber [ 
	y0 := aNumber asDouble
]

{ #category : #functions }
Jun2dCircle >> trackPointsBy: divisionNumber [ 
	^((Jun3dCircle 
		center: self center x , self center y , 0
		radius: self radius
		upVector: 0 , 0 , 1) trackPointsBy: divisionNumber) 
		collect: [:aPoint | aPoint x , aPoint y]
]

{ #category : #testing }
Jun2dCircle >> whichSideOf: aLine [ 
	"((0 , 0) radius: 1) whichSideOf: ((1 , 0) bisector: (0 , 1))."

	"((0 , 0) radius: 1) whichSideOf: ((1 , 0) bisector: (2 , -1))."

	"((0 , 0) radius: 1) whichSideOf: ((-1 , 2) bisector: (0 , 1))."

	| sign |
	sign := self center whichSideOf: aLine.
	sign = 0 ifTrue: [^0].
	(aLine distanceFromPoint: self center) <= self radius ifTrue: [^0].
	^sign
]

{ #category : #parameters }
Jun2dCircle >> x0 [
	^x0
]

{ #category : #parameters }
Jun2dCircle >> y0 [
	^y0
]

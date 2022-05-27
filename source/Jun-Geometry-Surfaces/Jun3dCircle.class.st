"
Imported by VwImportClass
"
Class {
	#name : #Jun3dCircle,
	#superclass : #JunCircle,
	#instVars : [
		'x0',
		'y0',
		'z0',
		'upVector'
	],
	#category : #'Jun-Geometry-Surfaces'
}

{ #category : #'instance creation' }
Jun3dCircle class >> center: centerPoint radius: radiusValue [ 
	^self 
		center: centerPoint
		radius: radiusValue
		upVector: 0 , 0 , 1
]

{ #category : #'instance creation' }
Jun3dCircle class >> center: centerPoint radius: radiusValue normalVector: normalVector [ 
	^self 
		center: centerPoint
		radius: radiusValue
		upVector: normalVector
]

{ #category : #'instance creation' }
Jun3dCircle class >> center: centerPoint radius: radiusValue upVector: normalVector [ 
	| aCircle |
	aCircle := self new.
	aCircle setCenter: centerPoint.
	aCircle setRadius: radiusValue.
	aCircle setUpVector: normalVector.
	^aCircle
]

{ #category : #copyright }
Jun3dCircle class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dCircle class >> example1 [
	"Jun3dCircle example1."

	| aCircle |
	aCircle := Jun3dCircle 
				center: 1 , 1 , 1
				radius: 1
				upVector: 0 , 1 , 1.
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

{ #category : #'lisp support' }
Jun3dCircle class >> fromTable: aTable for: aCircle [ 
	"Jun3dCircle fromLispList: (((0 , 0 , 0) radius: 1) toLispList)."

	super fromTable: aTable for: aCircle.
	self upVectorFromTable: aTable for: aCircle.
	^aCircle
]

{ #category : #'instance creation' }
Jun3dCircle class >> radius: radiusValue [ 
	"(Jun3dCircle radius: 1) asJunOpenGL3dObject showWithUnitAxes."

	^self 
		center: 0 , 0 , 0
		radius: radiusValue
		upVector: 0 , 0 , 1
]

{ #category : #'instance creation' }
Jun3dCircle class >> radius: radiusValue normalVector: normalVector [ 
	"(Jun3dCircle radius: 1 normalVector: 1 , 1 , 1) asJunOpenGL3dObject showWithUnitAxes."

	^self 
		center: 0 , 0 , 0
		radius: radiusValue
		upVector: normalVector
]

{ #category : #'instance creation' }
Jun3dCircle class >> radius: radiusValue upVector: upVector [ 
	"(Jun3dCircle radius: 1 upVector: 1 , 1 , 0) asJunOpenGL3dObject showWithUnitAxes."

	^self 
		center: 0 , 0 , 0
		radius: radiusValue
		upVector: upVector
]

{ #category : #copyright }
Jun3dCircle class >> system [
	^'Jun'
]

{ #category : #'lisp support' }
Jun3dCircle class >> upVectorFromTable: aTable for: aCircle [ 
	| aList |
	aList := aTable at: #upVector ifAbsent: [^aCircle].
	aCircle setUpVector: (self pointClass fromLispList: aList).
	^aCircle
]

{ #category : #copyright }
Jun3dCircle class >> version [
	^'799'
]

{ #category : #comparing }
Jun3dCircle >> = aCircle [ 
	super = aCircle ifFalse: [^false].
	^((self x0 = aCircle x0 and: [self y0 = aCircle y0]) 
		and: [self z0 = aCircle z0]) and: [self uv = aCircle uv]
]

{ #category : #converting }
Jun3dCircle >> asArrayOfPlanes [
	^Array with: self asPlane
]

{ #category : #converting }
Jun3dCircle >> asArrayOfTriangles [
	^Array with: self asTriangle
]

{ #category : #converting }
Jun3dCircle >> asJunOpenGL3dObject [
	"(1 , 1 , 1 radius: 1 upVector: 1 , 1 , 1) asJunOpenGL3dObject showWithAxes."

	| aCircle |
	aCircle := (JunOpenGL3dObject 
				circleBy: 10
				radius: self radius
				upVector: self upVector) translatedBy: self center.
	aCircle objectsDo: [:each | each paint: self defaultColor].
	^aCircle
]

{ #category : #converting }
Jun3dCircle >> asPlane [
	"((0.33333333333333d , 0.33333333333333d , 0.33333333333333d) radius: 0.81649658092773d upVector: 1 , 1 , 1) asPlane asJunOpenGL3dObject showWithUnitAxes."

	^self planeClass on: self center vertical: (0 , 0 , 0 to: self upVector)
]

{ #category : #converting }
Jun3dCircle >> asTriangle [
	"((0.33333333333333d , 0.33333333333333d , 0.33333333333333d) radius: 0.81649658092773d upVector: 1 , 1 , 1) asTriangle asJunOpenGL3dObject showWithUnitAxes."

	^self triangleClass 
		on: self center
		normalVector: self upVector
		distance: self radius
]

{ #category : #accessing }
Jun3dCircle >> center [
	^self x0 , self y0 , self z0
]

{ #category : #comparing }
Jun3dCircle >> equal: aCircle [ 
	(super equal: aCircle) ifFalse: [^false].
	^(((self x0 - aCircle x0) abs < self accuracy 
		and: [(self y0 - aCircle y0) abs < self accuracy]) 
			and: [(self z0 - aCircle z0) abs < self accuracy]) 
			and: [self uv equal: aCircle uv]
]

{ #category : #testing }
Jun3dCircle >> is3d [
	^true
]

{ #category : #printing }
Jun3dCircle >> printOn: aStream [ 
	(self upVector equal: 0 , 0 , 1) 
		ifTrue: [super printOn: aStream]
		ifFalse: 
			[aStream nextPutAll: '('.
			self center printOn: aStream.
			aStream nextPutAll: ' radius: '.
			self radius printOn: aStream.
			aStream nextPutAll: ' upVector: '.
			self upVector printOn: aStream.
			aStream nextPutAll: ')']
]

{ #category : #private }
Jun3dCircle >> setCenter: aPoint [ 
	| centerPoint |
	centerPoint := self pointClass coerce: aPoint.
	self setX0: centerPoint x.
	self setY0: centerPoint y.
	self setZ0: centerPoint z
]

{ #category : #private }
Jun3dCircle >> setUV: normalVector [ 
	self setUpVector: normalVector
]

{ #category : #private }
Jun3dCircle >> setUpVector: normalVector [ 
	upVector := self pointClass coerce: normalVector
]

{ #category : #private }
Jun3dCircle >> setX0: aNumber [ 
	x0 := aNumber asDouble
]

{ #category : #private }
Jun3dCircle >> setY0: aNumber [ 
	y0 := aNumber asDouble
]

{ #category : #private }
Jun3dCircle >> setZ0: aNumber [ 
	z0 := aNumber asDouble
]

{ #category : #printing }
Jun3dCircle >> storeOn: aStream [ 
	(self upVector equal: 0 , 0 , 1) 
		ifTrue: [super storeOn: aStream]
		ifFalse: 
			[aStream nextPutAll: '('.
			aStream nextPutAll: self class name.
			aStream nextPutAll: ' center: '.
			self center storeOn: aStream.
			aStream nextPutAll: ' radius: '.
			self radius storeOn: aStream.
			aStream nextPutAll: ' upVector: '.
			self upVector storeOn: aStream.
			aStream nextPutAll: ')']
]

{ #category : #'lisp support' }
Jun3dCircle >> toLispList [
	"self showLispList: (((0 , 0 , 0) radius: 1) toLispList)."

	| list |
	list := super toLispList.
	list add: self upVectorToLispList.
	^list
]

{ #category : #functions }
Jun3dCircle >> trackPointsBy: divisionNumber [ 
	"
	| centerPoint radiusValue upVector aCircle aPolyline compoundObject |
	centerPoint := 1 / 3 , (1 / 3) , (1 / 3).
	radiusValue := centerPoint distance: 0 , 0 , 1.
	upVector := 1 , 1 , 1.
	aCircle := centerPoint radius: radiusValue upVector: upVector.
	aPolyline := Jun3dPolyline points: (aCircle trackPointsBy: 36).
	compoundObject := aPolyline asJunOpenGL3dObject asCompoundObject.
	compoundObject add: JunOpenGL3dObject axes.
	compoundObject show.
	"

	| pointCollection aPlane axisLine aPoint standardLine |
	self 
		assert: 
			[aPlane := self asPlane.
			axisLine := self center to: self center + self upVector.
			aPoint := (self center to: aPlane p2) normalized atT: self radius.
			standardLine := axisLine translatedBy: aPoint - self center.
			Array new writeStream]
		do: 
			[:aStream | 
			(0 to: 360 by: 360 / divisionNumber) do: 
					[:degrees | 
					| aTransformation aLine |
					aTransformation := Jun3dTransformation rotate: (JunAngle fromDeg: degrees)
								around: axisLine.
					aLine := standardLine transform: aTransformation.
					aPoint := aPlane intersectingPointWithLine: aLine.
					"aPoint := (self center to: aPoint) normalized atT: self radius."
					aStream nextPut: aPoint].
			pointCollection := aStream contents]
		ensure: [:aStream | aStream close].
	^pointCollection
]

{ #category : #transforming }
Jun3dCircle >> transform: aTransformation [ 
	"Reasonable cases: The transformation makes a right circle."
	"(Jun3dCircle center: 0, 0, 0 radius: 100 upVector: 1, 0, 0) transform: (Jun3dTransformation translate: 10, 20, 30)"
	"(Jun3dCircle center: 0, 0, 0 radius: 100 upVector: 1, 0, 0) transform: (Jun3dTransformation rotateY: (JunAngle fromDeg: 45))"
	"(Jun3dCircle center: 0, 0, 0 radius: 100 upVector: 1, 0, 0) transform: (Jun3dTransformation scale: 0, 1, 1)"
	"(Jun3dCircle center: 0, 0, 0 radius: 100 upVector: 1, 0, 0) transform: (Jun3dTransformation scale: 2, 1, 1)"
	"(Jun3dCircle center: 0, 10, 20 radius: 100 upVector: 1, 0, 0) transform: (Jun3dTransformation scale: 1, 2, 2)"
	"(Jun3dCircle center: 0, 0, 0 radius: 100 upVector: 12, 9, 0) transform: (Jun3dTransformation scale: (16 / 9), 1, (20 / 15))"


	"Erroneous cases: The transformation makes an ellipse or very small circle."
	"(Jun3dCircle center: 0, 0, 0 radius: 100 upVector: 1, 0, 0) transform: (Jun3dTransformation scale: 1, 2, 3)"
	"(Jun3dCircle center: 0, 0, 0 radius: 100 upVector: 1, 0, 0) transform: (Jun3dTransformation scale: 1, 0, 0)"

	| accuracy inscribedSquare transformedParallelogram north east south west ns ew isRhonbus isSquare newCenter newRadius newUpVector originalPlane |
	accuracy := self accuracy.
	inscribedSquare := self trackPointsBy: 4.
	transformedParallelogram := inscribedSquare 
				collect: [:point | point transform: aTransformation].
	north := transformedParallelogram at: 1.
	east := transformedParallelogram at: 2.
	south := transformedParallelogram at: 3.
	west := transformedParallelogram at: 4.
	ns := south - north.
	ew := west - east.
	(ns length < accuracy or: [ew length < accuracy]) 
		ifTrue: 
			[(ns length < accuracy and: [ew length < accuracy]) 
				ifTrue: [^self error: 'transformed circle too small to define upVector'].
			^self error: 'transformation on the circle does not make a circle'].
	isRhonbus := (ns unitVector dotProduct: ew unitVector) abs < accuracy.
	isSquare := isRhonbus and: [(ns length - ew length) abs < accuracy].
	isSquare 
		ifFalse: [^self error: 'transformation on the circle does not make a circle'].
	newCenter := self center transform: aTransformation.
	newRadius := (ns length + ew length) / 4.
	newUpVector := ((0 , 0 , 0 to: self upVector) transform: aTransformation) 
				normalVector.
	newUpVector length < accuracy 
		ifTrue: 
			[originalPlane := JunPlane vertexes: (inscribedSquare copyFrom: 1 to: 3).
			(originalPlane normalVector dotProduct: self upVector) < 0 
				ifTrue: [originalPlane := originalPlane reversed].
			newUpVector := (originalPlane transform: aTransformation) normalVector].
	^self class 
		center: newCenter
		radius: newRadius
		upVector: newUpVector
]

{ #category : #accessing }
Jun3dCircle >> upVector [
	^upVector
]

{ #category : #'lisp support' }
Jun3dCircle >> upVectorToLispList [
	| list |
	list := self lispCons.
	list head: #upVector.
	list tail: self upVector toLispList.
	^list
]

{ #category : #parameters }
Jun3dCircle >> uv [
	^self upVector
]

{ #category : #testing }
Jun3dCircle >> whichSideOf: aPlane [ 
	"((0 , 0 , 0) radius: 1) whichSideOf: ((1 , 0 , 0) bisector: (0 , 1 , 0))."

	"((0 , 0 , 0) radius: 1) whichSideOf: ((1 , 0 , 0) bisector: (2 , -1 , 0))."

	"((0 , 0 , 0) radius: 1) whichSideOf: ((-1 , 2 , 0) bisector: (0 , 1 , 0))."

	| sign |
	sign := self center whichSideOf: aPlane.
	sign = 0 ifTrue: [^0].
	((aPlane intersectingLineWithPlane: self asPlane) 
		distanceFromPoint: self center) <= self radius 
		ifTrue: [^0].
	^sign
]

{ #category : #parameters }
Jun3dCircle >> x0 [
	^x0
]

{ #category : #parameters }
Jun3dCircle >> y0 [
	^y0
]

{ #category : #parameters }
Jun3dCircle >> z0 [
	^z0
]

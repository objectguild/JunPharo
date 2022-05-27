"
Imported by VwImportClass
"
Class {
	#name : #Jun2dLine,
	#superclass : #JunLine,
	#instVars : [
		'x0',
		'y0',
		'f',
		'g'
	],
	#category : #'Jun-Geometry-Curves'
}

{ #category : #'instance creation' }
Jun2dLine class >> between: aPoint1 and: aPoint2 [ 
	"Jun2dLine between: (0 , 0) and: (1 , 1)."

	^(self new)
		between: aPoint1 and: aPoint2;
		yourself
]

{ #category : #copyright }
Jun2dLine class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun2dLine class >> example1 [
	"Jun2dLine example1."

	| aLine |
	aLine := Jun2dLine from: 1 , 0 to: 0 , 1.
	Transcript
		cr;
		show: aLine printString.
	Transcript
		cr;
		show: aLine storeString.
	aLine asJunOpenGL3dObject showWithUnitAxes.
	^aLine
]

{ #category : #examples }
Jun2dLine class >> example2 [
	"Jun2dLine example2."

	| aLine pointCollection graphicsContext |
	aLine := Jun2dLine unity.
	pointCollection := OrderedCollection new.
	100 to: 200 do: [:each | pointCollection add: (aLine atT: each) rounded].
	graphicsContext := ScheduledControllers activeController view graphicsContext.
	graphicsContext clear.
	graphicsContext lineWidth: 10.
	graphicsContext paint: ColorValue red.
	graphicsContext displayPolyline: pointCollection.
	Cursor crossHair showWhile: [graphicsContext medium sensor waitClickButton].
	graphicsContext medium display.
	^aLine
]

{ #category : #examples }
Jun2dLine class >> example3 [
	"Jun2dLine example3."

	| aLine graphicsContext referencePoint scalePoint offsetPoint tTr tS tR tTt aT origin object polyline |
	aLine := Jun2dLine from: -2 , -2 to: 2 , 2.
	graphicsContext := ScheduledControllers activeController view graphicsContext.
	referencePoint := 0 , 0.
	scalePoint := 40 , 40.
	offsetPoint := Jun2dPoint fromPoint: graphicsContext medium bounds center.
	tTr := Jun2dTransformation translate: referencePoint negated.
	tS := Jun2dTransformation scale: scalePoint.
	tR := Jun2dTransformation rotate: (JunAngle fromDeg: 0).
	tTt := Jun2dTransformation translate: offsetPoint.
	(0 to: 360 by: 4)
		do: 
			[:angle | 
			tR := Jun2dTransformation rotate: (JunAngle fromDeg: angle).
			aT := ((tTr product: tS)
						product: tR)
						product: tTt.
			origin := Jun2dPoint zero transform: tTt.
			object := aLine transform: aT.
			graphicsContext clear.
			graphicsContext paint: ColorValue blue.
			graphicsContext
				displayArcBoundedBy: ((0 @ 0 extent: 0 @ 0)
						expandedBy: 2)
				startAngle: 0
				sweepAngle: 360
				at: origin asPoint.
			graphicsContext paint: ColorValue red.
			object asPointArrays
				do: 
					[:points | 
					polyline := points collect: [:p | p rounded].
					graphicsContext displayPolyline: polyline]].
	Cursor crossHair showWhile: [graphicsContext medium sensor waitClickButton].
	graphicsContext medium display.
	^aLine
]

{ #category : #'instance creation' }
Jun2dLine class >> from: fromPoint to: toPoint [ 
	"Jun2dLine from: (0 , 0) to: (1 , 1)."

	^(self new)
		from: fromPoint to: toPoint;
		yourself
]

{ #category : #'instance creation' }
Jun2dLine class >> on: aPoint vertical: aLine [ 
	"Jun2dLine on: (0 , 1) vertical: (Jun2dLine from: (0 , 0) to: (1 , 1))."

	^(self new)
		on: aPoint vertical: aLine;
		yourself
]

{ #category : #copyright }
Jun2dLine class >> system [
	^'Jun'
]

{ #category : #'constants access' }
Jun2dLine class >> unity [
	"Jun2dLine unity."

	^(self from: Jun2dPoint zero to: Jun2dPoint unity) normalizedLine
]

{ #category : #copyright }
Jun2dLine class >> version [
	^'799'
]

{ #category : #'constants access' }
Jun2dLine class >> zero [
	^self shouldNotImplement
]

{ #category : #comparing }
Jun2dLine >> = aLine [ 
	self class == aLine class ifFalse: [^false].
	^((x0 = aLine x0 and: [y0 = aLine y0]) and: [f = aLine f]) 
		and: [g = aLine g]
]

{ #category : #parameters }
Jun2dLine >> a [
	^self g negated
]

{ #category : #functions }
Jun2dLine >> angleWithLine: aLine [ 
	"(0 , 0 to: 1 , 1) angleWithLine: (0 , 0 to: -1 , -1)."

	| theLine denominator numerator gamma |
	(aLine isKindOf: self class) 
		ifTrue: [theLine := aLine]
		ifFalse: [theLine := Jun2dLine from: aLine first to: aLine last].
	denominator := (f squared + g squared) 
				* (theLine f squared + theLine g squared).
	denominator := denominator sqrt.
	denominator < self class accuracy 
		ifTrue: [^self error: 'unexpected line parameters'].
	numerator := f * theLine f + (g * theLine g).
	gamma := (numerator / denominator max: -1.0d) min: 1.0d.
	^JunAngle fromRad: gamma arcCos
]

{ #category : #accessing }
Jun2dLine >> atT: t [ 
	"(Jun2dLine from: (0 , 0) to: (1 , 1)) atT: 0."
	"(Jun2dLine from: (0 , 0) to: (1 , 1)) atT: 1."
	"(Jun2dLine from: (0 , 0) to: (1 , 1)) atT: -1."
	"(Jun2dLine from: (0 , 0) to: (1 , 1)) atT: 2."
	"(Jun2dLine from: (0 , 0) to: (1 , 1)) atT: -2."

	^Jun2dPoint x: x0 + (f * t) y: y0 + (g * t)
]

{ #category : #accessing }
Jun2dLine >> atX: x [ 
	"(Jun2dLine from: (0 , 0) to: (1 , 1)) atX: 0.5."
	"(Jun2dLine from: (0 , 0) to: (1 , 1)) atX: -5."
	"(Jun2dLine from: (0 , 0) to: (1 , 2)) atX: 0.5."
	"(Jun2dLine from: (0 , 0) to: (1 , 2)) atX: -5."

	| aLine aPoint |
	aLine := self class from: x , 0 to: x , 1.
	aPoint := aLine intersectingPointWithLine: self.
	^aPoint
]

{ #category : #accessing }
Jun2dLine >> atY: y [ 
	"(Jun2dLine from: (0 , 0) to: (1 , 1)) atY: 0.5."
	"(Jun2dLine from: (0 , 0) to: (1 , 1)) atY: -5."
	"(Jun2dLine from: (0 , 0) to: (1 , 2)) atY: 0.5."
	"(Jun2dLine from: (0 , 0) to: (1 , 2)) atY: -5."

	| aLine aPoint |
	aLine := self class from: 0 , y to: 1 , y.
	aPoint := aLine intersectingPointWithLine: self.
	^aPoint
]

{ #category : #accessing }
Jun2dLine >> atZ: z [ 
	self shouldNotImplement
]

{ #category : #parameters }
Jun2dLine >> b [
	^self f
]

{ #category : #accessing }
Jun2dLine >> between: aPoint1 and: aPoint2 [ 
	| point1 point2 dx dy denominator |
	point1 := Jun2dPoint coerce: aPoint1.
	point2 := Jun2dPoint coerce: aPoint2.
	point1 = point2 ifTrue: [^self error: 'can not define a line'].
	dx := point2 x - point1 x.
	dy := point2 y - point1 y.
	denominator := dx squared + dy squared.
	denominator < self class accuracy 
		ifTrue: [^self error: 'can not define a line'].
	denominator := denominator sqrt.
	self setX0: (point1 x + point2 x) / 2.0d.
	self setY0: (point1 y + point2 y) / 2.0d.
	self setF: dy negated / denominator.
	self setG: dx / denominator
]

{ #category : #parameters }
Jun2dLine >> c [
	^self x0 * self g - (self y0 * self f)
]

{ #category : #comparing }
Jun2dLine >> equal: aLine [ 
	self class == aLine class ifFalse: [^false].
	^(((x0 - aLine x0) abs < self accuracy 
		and: [(y0 - aLine y0) abs < self accuracy]) 
			and: [(f - aLine f) abs < self accuracy]) 
			and: [(g - aLine g) abs < self accuracy]
]

{ #category : #parameters }
Jun2dLine >> f [
	^f
]

{ #category : #accessing }
Jun2dLine >> from: fromPoint to: toPoint [ 
	| point1 point2 |
	point1 := Jun2dPoint coerce: fromPoint.
	point2 := Jun2dPoint coerce: toPoint.
	self setX0: point1 x.
	self setY0: point1 y.
	self setF: point2 x - point1 x.
	self setG: point2 y - point1 y
]

{ #category : #parameters }
Jun2dLine >> g [
	^g
]

{ #category : #functions }
Jun2dLine >> intersectingPointWithLine: aLine [ 
	"(0 , 0 to: 1 , 1) intersectingPointWithLine: (0 , 2 to: 6 , 0)."

	| t |
	t := self intersectingTWithLine: aLine.
	t isNil ifTrue: [^nil].
	^self atT: t
]

{ #category : #functions }
Jun2dLine >> intersectingPointsWithPolyline: aPolyline [
	
	^aPolyline intersectingPointsWithLine: self
]

{ #category : #functions }
Jun2dLine >> intersectingTWithLine: aLine [ 
	"(0 , 0 to: 1 , 1) intersectingPointWithLine: (0 , 2 to: 6 , 0)."

	| theLine yourF yourG denominator |
	(aLine isKindOf: self class) 
		ifTrue: [theLine := aLine]
		ifFalse: [theLine := Jun2dLine from: aLine first to: aLine last].
	yourF := theLine f.
	yourG := theLine g.
	denominator := yourF * g - (f * yourG).
	denominator abs < self class accuracy 
		ifTrue: 
			["parallel"

			^nil].
	^(yourF * (theLine y0 - y0) - (yourG * (theLine x0 - x0))) / denominator
]

{ #category : #testing }
Jun2dLine >> is2d [
	^true
]

{ #category : #testing }
Jun2dLine >> lineSegmentContainsPoint: aJun2dPoint [ 
	^(self containsPoint: aJun2dPoint)
		and: 
			[| t |
			t := self tAtPoint: aJun2dPoint.
			t between: self class accuracy negated and: 1 + self class accuracy]
]

{ #category : #functions }
Jun2dLine >> lineSegmentDistanceFromPoint: aPoint [ 
	"(0 , 0 to: 1 , 1) lineSegmentDistanceFromPoint: -1 , -1."

	| thePoint pointOnMe |
	thePoint := Jun2dPoint coerce: aPoint.
	pointOnMe := self lineSegmentNearestPointFromPoint: thePoint.
	^thePoint distance: pointOnMe
]

{ #category : #functions }
Jun2dLine >> lineSegmentIntersectingPointWithLineSegment: aLine [ 
	"(0 , 0 to: 1 , 1) intersectingPointWithLine: (0 , 2 to: 6 , 0)."

	| intersectingPoint |
	intersectingPoint := self intersectingPointWithLine: aLine.
	^(intersectingPoint notNil and: 
			[(self lineSegmentContainsPoint: intersectingPoint) 
				and: [aLine lineSegmentContainsPoint: intersectingPoint]]) 
		ifTrue: [intersectingPoint]
		ifFalse: [nil]
]

{ #category : #functions }
Jun2dLine >> lineSegmentNearestPointFromPoint: aPoint [ 
	"(0 , 0 to: 1 , 1) lineSegmentNearestPointFromPoint: -1 , -1."

	| thePoint denominator x y t |
	thePoint := Jun2dPoint coerce: aPoint.
	denominator := f squared + g squared.
	denominator < self class accuracy 
		ifTrue: [^self error: 'can not define a line'].
	x := thePoint x - x0.
	y := thePoint y - y0.
	t := (f * x + (g * y)) / denominator.
	t < 0 ifTrue: [t := 0.0d].
	t > 1 ifTrue: [t := 1.0d].
	^self atT: t
]

{ #category : #testing }
Jun2dLine >> lineSegmentStrictlyContainsPoint: aJun2dPoint [ 
	^(self containsPoint: aJun2dPoint)
		and: 
			[| t |
			t := self tAtPoint: aJun2dPoint.
			t between: self class accuracy and: 1 - self class accuracy]
]

{ #category : #parameters }
Jun2dLine >> n [
	"Answer my normalized constant."

	| denominator |
	denominator := f squared + g squared.
	denominator < self class accuracy ifTrue: [^self error: 'can not define a line'].
	^1.0d / denominator sqrt
]

{ #category : #functions }
Jun2dLine >> nearestPointFromPoint: aPoint [ 
	"(0 , 0 to: 1 , 1) nearestPointFromPoint: -1 , -1."

	| thePoint denominator x y |
	thePoint := Jun2dPoint coerce: aPoint.
	denominator := f squared + g squared.
	denominator < self class accuracy 
		ifTrue: [^self error: 'can not define a line'].
	x := thePoint x - x0.
	y := thePoint y - y0.
	^self atT: (f * x + (g * y)) / denominator
]

{ #category : #functions }
Jun2dLine >> normalizedLine [
	| copy n |
	copy := self copy.
	n := self n.
	copy setF: f * n.
	copy setG: g * n.
	^copy
]

{ #category : #accessing }
Jun2dLine >> on: aPoint vertical: aLine [ 
	| thePoint theLine |
	thePoint := Jun2dPoint coerce: aPoint.
	(aLine isKindOf: self class)
		ifTrue: [theLine := aLine]
		ifFalse: [theLine := self class from: aLine first to: aLine last].
	self setX0: thePoint x.
	self setY0: thePoint y.
	self setF: theLine g negated.
	self setG: theLine f
]

{ #category : #parameters }
Jun2dLine >> parameterArray [
	| array |
	array := Array new: 4.
	array at: 1 put: x0.
	array at: 2 put: y0.
	array at: 3 put: f.
	array at: 4 put: g.
	^array
]

{ #category : #parameters }
Jun2dLine >> parameterMatrix [
	"(Jun2dLine from: (0 , 0) to: (1 , 1)) parameterMatrix."

	^JunMatrix
		new: 2
		by: 2
		collection: self parameterArray
]

{ #category : #transforming }
Jun2dLine >> rotatedBy: anAngle [ 
	^self transform: (Jun2dTransformation rotate: anAngle)
]

{ #category : #transforming }
Jun2dLine >> scaledBy: aPoint [ 
	^self transform: (Jun2dTransformation scale: aPoint)
]

{ #category : #private }
Jun2dLine >> setF: aNumber [ 
	f := aNumber asDouble
]

{ #category : #private }
Jun2dLine >> setG: aNumber [ 
	g := aNumber asDouble
]

{ #category : #private }
Jun2dLine >> setX0: aNumber [ 
	x0 := aNumber asDouble
]

{ #category : #private }
Jun2dLine >> setY0: aNumber [ 
	y0 := aNumber asDouble
]

{ #category : #accessing }
Jun2dLine >> tAtPoint: aPoint [ 
	| dominator x y |
	dominator := f squared + g squared.
	dominator < self class accuracy ifTrue: [^self error: 'can''t define a line'].
	x := aPoint x - x0.
	y := aPoint y - y0.
	^f * x + (g * y) / dominator
]

{ #category : #accessing }
Jun2dLine >> tAtX: aNumber [ 
	f abs < self class accuracy ifTrue: [^nil].
	^aNumber - x0 / f
]

{ #category : #accessing }
Jun2dLine >> tAtY: aNumber [ 
	g abs < self class accuracy ifTrue: [^nil].
	^aNumber - y0 / g
]

{ #category : #transforming }
Jun2dLine >> transform: aTransformation [ 
	^self class from: (self from transform: aTransformation)
		to: (self to transform: aTransformation)
]

{ #category : #transforming }
Jun2dLine >> translatedBy: aPoint [ 
	^self transform: (Jun2dTransformation translate: aPoint)
]

{ #category : #functions }
Jun2dLine >> valueF: aPoint [ 
	"((-2 , -2) to: (0 , 2)) valueF: (0 , 0)."

	| thePoint |
	thePoint := self pointClass coerce: aPoint.
	^self a * thePoint x + (self b * thePoint y) + self c
]

{ #category : #functions }
Jun2dLine >> whichSide: aPoint [ 
	"((-2 , -2) to: (0 , 2)) whichSide: (-1 , 0)."

	^(self valueF: aPoint) sign
]

{ #category : #parameters }
Jun2dLine >> x0 [
	^x0
]

{ #category : #parameters }
Jun2dLine >> y0 [
	^y0
]

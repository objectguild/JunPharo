"
Imported by VwImportClass
"
Class {
	#name : #Jun3dLine,
	#superclass : #JunLine,
	#instVars : [
		'x0',
		'y0',
		'z0',
		'f',
		'g',
		'h'
	],
	#category : #'Jun-Geometry-Curves'
}

{ #category : #copyright }
Jun3dLine class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dLine class >> example1 [
	"Jun3dLine example1."

	| aLine |
	aLine := Jun3dLine from: 1 , 0 , 0.5 to: 0 , 1 , 0.5.
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
Jun3dLine class >> example2 [
	"Jun3dLine example2."

	| aLine pointCollection graphicsContext |
	aLine := Jun3dLine unity.
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
Jun3dLine class >> example3 [
	"Jun3dLine example3."

	| aLine graphicsContext viewPoint referencePoint scalePoint offsetPoint tTr tS tP tTt |
	aLine := Jun3dLine from: -2 , -2 , -2 to: 2 , 2 , 2.
	graphicsContext := ScheduledControllers activeController view 
				graphicsContext.
	viewPoint := 0 , 0 , 300.
	referencePoint := 0 , 0 , 0.
	scalePoint := 40 , 40 , 40.
	offsetPoint := Jun3dPoint fromPoint: graphicsContext medium bounds center.
	tTr := Jun3dTransformation translate: referencePoint negated.
	tS := Jun3dTransformation scale: scalePoint.
	tP := Jun3dTransformation perspective: viewPoint.
	tTt := Jun3dTransformation translate: offsetPoint.
	(0 to: 360 by: 4) do: 
			[:angle | 
			| tRz tRy tRx aT origin object |
			tRz := Jun3dTransformation rotateZ: (JunAngle fromDeg: angle).
			tRy := Jun3dTransformation rotateY: (JunAngle fromDeg: angle).
			tRx := Jun3dTransformation rotateX: (JunAngle fromDeg: angle).
			aT := (((((tTr product: tS) product: tRz) product: tRy) product: tRx) 
						product: tP) product: tTt.
			origin := Jun3dPoint zero transform: tTt.
			object := aLine transform: aT.
			aLine do: 
					[graphicsContext clear.
					graphicsContext paint: ColorValue blue.
					graphicsContext 
						displayArcBoundedBy: ((0 @ 0 extent: 0 @ 0) expandedBy: 2)
						startAngle: 0
						sweepAngle: 360
						at: origin asPoint.
					graphicsContext paint: ColorValue red.
					object asPointArrays do: 
							[:points | 
							| polyline |
							polyline := points collect: [:p | p rounded].
							graphicsContext displayPolyline: polyline]]
				forMilliseconds: 100].
	Cursor crossHair 
		showWhile: [graphicsContext medium sensor waitClickButton].
	graphicsContext medium display.
	^aLine
]

{ #category : #examples }
Jun3dLine class >> example4 [
	"Jun3dLine example4."

	| aLine lineCollection anInterval aPlane planeCollection aViewfinder |
	aLine := 1 , 1 , 1 to: 0.5 , 0.5 , 0.5.
	lineCollection := OrderedCollection new.
	(anInterval := 0 to: 360 - 30 by: 30) with: (1 to: anInterval size)
		do: 
			[:degrees :n | 
			lineCollection 
				add: ((aLine first to: (aLine atT: 0.5 + (n / anInterval size * 0.5))) 
						transform: (Jun3dTransformation rotate: (JunAngle fromDeg: degrees)
								around: (0 , 0 , 0 to: 1 , 1 , 2)))].
	aPlane := JunPlane 
				on: 0 , 0 , 1.5
				on: 1 , 0 , 1.5
				on: 0 , 1 , 1.5.
	planeCollection := OrderedCollection new.
	(0 to: 360 by: 5) do: 
			[:degrees | 
			planeCollection add: (aPlane 
						transform: (Jun3dTransformation rotate: (JunAngle fromDeg: degrees)
								around: (0 , 0 , 0 to: 1 , 1 , 0)))].
	aViewfinder := JunOpenGLDisplayModel new.
	aViewfinder openIn: (600 , 600) alignedRectangleWithScreenCenter.
	planeCollection do: 
			[:eachPlane | 
			| aBody |
			aBody := JunOpenGL3dCompoundObject new.
			aLine do: 
					[lineCollection with: (0 to: lineCollection size - 1)
						do: 
							[:eachLine :n | 
							| reflectingLine |
							reflectingLine := eachLine reflectingLineWithPlane: eachPlane.
							aBody add: (JunOpenGL3dObject 
										arrowLine: eachLine
										color: (ColorValue 
												hue: n / lineCollection size
												saturation: 1
												brightness: 1)
										lineWidth: 2).
							aBody 
								add: (((JunOpenGL3dObject 
										circleBy: 10
										radius: 2.5
										upVector: eachPlane normalVector) translatedBy: eachPlane first)
										polygonsDo: 
												[:each | 
												each
													paint: ColorValue veryLightGray;
													halftone: 0.5];
										yourself).
							(eachPlane intersectingPointWithLine: eachLine) ifNotNil: 
									[:aPoint | 
									aBody add: ((JunOpenGL3dPolyline 
												vertexes: (Array with: eachLine last with: aPoint))
												paint: ColorValue gray;
												yourself)].
							(eachPlane intersectingPointWithLine: reflectingLine) ifNotNil: 
									[:aPoint | 
									aBody add: ((JunOpenGL3dPolyline 
												vertexes: (Array with: aPoint with: reflectingLine first))
												paint: ColorValue gray;
												yourself)].
							aBody add: (JunOpenGL3dObject 
										arrowLine: reflectingLine
										color: (ColorValue 
												hue: n / lineCollection size
												saturation: 1
												brightness: 1)
										lineWidth: 2)]]
				forMilliseconds: 25.
			aViewfinder
				displayObject: aBody;
				resetView]
]

{ #category : #'instance creation' }
Jun3dLine class >> from: fromPoint to: toPoint [ 
	"Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)."

	^(self new)
		from: fromPoint to: toPoint;
		yourself
]

{ #category : #'instance creation' }
Jun3dLine class >> on: aPoint vertical: aPlane [ 
	"Jun3dLine on: 1 , 1 , 1 vertical: (1 , 0 , 0 plane: 0 , 1 , 0 and: 0 , 0 , 1)."

	^(self new)
		on: aPoint vertical: aPlane;
		yourself
]

{ #category : #copyright }
Jun3dLine class >> system [
	^'Jun'
]

{ #category : #'constants access' }
Jun3dLine class >> unity [
	"Jun3dLine unity."

	^(self from: Jun3dPoint zero to: Jun3dPoint unity) normalizedLine
]

{ #category : #copyright }
Jun3dLine class >> version [
	^'799'
]

{ #category : #'constants access' }
Jun3dLine class >> zero [
	^self shouldNotImplement
]

{ #category : #comparing }
Jun3dLine >> = aLine [ 
	self class == aLine class ifFalse: [^false].
	^((((x0 = aLine x0 and: [y0 = aLine y0]) and: [z0 = aLine z0]) 
		and: [f = aLine f]) and: [g = aLine g]) 
		and: [h = aLine h]
]

{ #category : #functions }
Jun3dLine >> angleWithLine: aLine [ 
	"(0 , 0 , 0 to: 1 , 1 , 1) angleWithLine: (0 , 0 , 0 to: -1 , -1 , -1)."

	| theLine denominator numerator gamma |
	(aLine isKindOf: self class) 
		ifTrue: [theLine := aLine]
		ifFalse: [theLine := Jun3dLine from: aLine first to: aLine last].
	denominator := (f squared + g squared + h squared) 
				* (theLine f squared + theLine g squared + theLine h squared).
	denominator := denominator sqrt.
	denominator < self class accuracy 
		ifTrue: [^self error: 'unexpected line parameters'].
	numerator := f * theLine f + (g * theLine g) + (h * theLine h).
	gamma := (numerator / denominator max: -1.0d) min: 1.0d.
	^JunAngle fromRad: gamma arcCos
]

{ #category : #converting }
Jun3dLine >> asUnitVector [
	^(f, g, h) unitVector
]

{ #category : #accessing }
Jun3dLine >> atT: t [ 
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)) atT: 0."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)) atT: 1."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)) atT: -1."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)) atT: 2."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)) atT: -2."

	^Jun3dPoint
		x: x0 + (f * t)
		y: y0 + (g * t)
		z: z0 + (h * t)
]

{ #category : #accessing }
Jun3dLine >> atX: x [ 
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)) atX: 0.5."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)) atX: -5."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 2 , 3)) atX: 0.5."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 2 , 3)) atX: -5."

	| aPlane aPoint |
	aPlane := JunPlane
				on: x , 0 , 0
				on: x , 1 , 0
				on: x , 0 , 1.
	aPoint := aPlane intersectingPointWithLine: self.
	^aPoint
]

{ #category : #accessing }
Jun3dLine >> atY: y [ 
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)) atY: 0.5."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)) atY: -5."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 2 , 3)) atY: 0.5."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 2 , 3)) atY: -5."

	| aPlane aPoint |
	aPlane := JunPlane
				on: 0 , y , 0
				on: 0 , y , 1
				on: 1 , y , 0.
	aPoint := aPlane intersectingPointWithLine: self.
	^aPoint
]

{ #category : #accessing }
Jun3dLine >> atZ: z [ 
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)) atZ: 0.5."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 1 , 1)) atZ: -5."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 2 , 3)) atZ: 0.5."
	"(Jun3dLine from: (0 , 0 , 0) to: (1 , 2 , 3)) atZ: -5."

	| aPlane aPoint |
	aPlane := JunPlane
				on: 0 , 0 , z
				on: 1 , 0 , z
				on: 0 , 1 , z.
	aPoint := aPlane intersectingPointWithLine: self.
	^aPoint
]

{ #category : #testing }
Jun3dLine >> containsLineSegment: aJun3dLine [ 
	^(self lineSegmentContainsPoint: aJun3dLine from)
		and: [self lineSegmentContainsPoint: aJun3dLine to]
]

{ #category : #functions }
Jun3dLine >> distanceFromLine: aLine [ 
	"(0 , 0 , 0 to: 1 , 1 , 1) distanceFromLine: (1 , 0 , 1 to: 0 , -1 , 1)."

	| theLine dx dy dz fg gh hf denominator |
	(aLine isKindOf: self class) 
		ifTrue: [theLine := aLine]
		ifFalse: [theLine := Jun3dLine from: aLine first to: aLine last].
	dx := theLine x0 - x0.
	dy := theLine y0 - y0.
	dz := theLine z0 - z0.
	fg := f * theLine g - (theLine f * g).
	gh := g * theLine h - (theLine g * h).
	hf := h * theLine f - (theLine h * f).
	denominator := fg squared + gh squared + hf squared.
	denominator < self class accuracy 
		ifTrue: [^self distanceFromPoint: theLine from].
	denominator := denominator sqrt.
	^(dx * gh + (dy * hf) + (dz * fg)) abs / denominator
]

{ #category : #comparing }
Jun3dLine >> equal: aLine [ 
	self class == aLine class ifFalse: [^false].
	^(((((x0 - aLine x0) abs < self accuracy 
		and: [(y0 - aLine y0) abs < self accuracy]) 
			and: [(z0 - aLine z0) abs < self accuracy]) 
			and: [(f - aLine f) abs < self accuracy]) 
			and: [(g - aLine g) abs < self accuracy]) 
			and: [(h - aLine h) abs < self accuracy]
]

{ #category : #parameters }
Jun3dLine >> f [
	^f
]

{ #category : #accessing }
Jun3dLine >> from: fromPoint to: toPoint [ 
	| point1 point2 |
	point1 := Jun3dPoint coerce: fromPoint.
	point2 := Jun3dPoint coerce: toPoint.
	self setX0: point1 x.
	self setY0: point1 y.
	self setZ0: point1 z.
	self setF: point2 x - point1 x.
	self setG: point2 y - point1 y.
	self setH: point2 z - point1 z
]

{ #category : #parameters }
Jun3dLine >> g [
	^g
]

{ #category : #parameters }
Jun3dLine >> h [
	^h
]

{ #category : #functions }
Jun3dLine >> intersectingPointWithLine: aJun3dLine [ 
	"(0 , 0 , 0 to: 1.5 , 0 , 0) intersectingPointWithLine: (1 , 1 , -1 to: 1 , -1 , -1)."

	| yourF yourG yourH denominatorXY denominatorYZ denominatorZX yourX0 yourY0 yourZ0 t yourT x y z yourX yourY yourZ |
	yourF := aJun3dLine f.
	yourG := aJun3dLine g.
	yourH := aJun3dLine h.
	yourX0 := aJun3dLine x0.
	yourY0 := aJun3dLine y0.
	yourZ0 := aJun3dLine z0.
	denominatorXY := yourF * g - (f * yourG).
	denominatorYZ := yourG * h - (g * yourH).
	denominatorZX := yourH * f - (h * yourF).
	((denominatorXY abs max: denominatorYZ abs) max: denominatorZX abs) 
		< self class accuracy 
			ifTrue: 
				["parallel"

				^nil].
	(denominatorXY abs >= denominatorYZ abs 
		and: [denominatorXY abs >= denominatorZX abs]) 
			ifTrue: 
				[t := (yourF * (yourY0 - y0) - (yourG * (yourX0 - x0))) / denominatorXY.
				yourF abs > yourG abs 
					ifTrue: [yourT := (f * t + x0 - yourX0) / yourF]
					ifFalse: [yourT := (g * t + y0 - yourY0) / yourG]]
			ifFalse: 
				[denominatorYZ abs >= denominatorZX abs 
					ifTrue: 
						[t := (yourG * (yourZ0 - z0) - (yourH * (yourY0 - y0))) / denominatorYZ.
						yourG abs > yourH abs 
							ifTrue: [yourT := (g * t + y0 - yourY0) / yourG]
							ifFalse: [yourT := (h * t + z0 - yourZ0) / yourH]]
					ifFalse: 
						[t := (yourH * (yourX0 - x0) - (yourF * (yourZ0 - z0))) / denominatorZX.
						yourH abs > yourF abs 
							ifTrue: [yourT := (h * t + z0 - yourZ0) / yourH]
							ifFalse: [yourT := (f * t + x0 - yourX0) / yourF]]].
	x := f * t + x0.
	y := g * t + y0.
	z := h * t + z0.
	yourX := yourF * yourT + yourX0.
	yourY := yourG * yourT + yourY0.
	yourZ := yourH * yourT + yourZ0.
	((x - yourX) abs > self class accuracy or: 
			[(y - yourY) abs > self class accuracy 
				or: [(z - yourZ) abs > self class accuracy]]) 
		ifTrue: [^nil].
	^Jun3dPoint 
		x: x
		y: y
		z: z
]

{ #category : #functions }
Jun3dLine >> intersectingPointWithPlane: aPlane [
	
	^aPlane intersectingPointWithLine: self
]

{ #category : #functions }
Jun3dLine >> intersectingPointsLine: aLine viewPoint: aPoint [ 
	"(50 , 50 , -50 to: -50 , -50 , -50) 
		intersectingPointsLine: (-50 , 50 , 50 to: 50 , -50 , 50) 
		viewPoint: 0 , 0 , 100."

	| theLine thePoint planeI planeJ jf jt if it de t1 t2 p1 p2 |
	(aLine isKindOf: self class) 
		ifTrue: [theLine := aLine]
		ifFalse: [theLine := Jun3dLine from: aLine first to: aLine last].
	thePoint := Jun3dPoint coerce: aPoint.
	planeI := JunPlane 
				on: thePoint
				on: self from
				on: self to.
	planeI isNil ifTrue: [^Array new].
	planeJ := JunPlane 
				on: thePoint
				on: theLine from
				on: theLine to.
	planeJ isNil ifTrue: [^Array new].
	jf := planeJ valueF: self from.
	jt := planeJ valueF: self to.
	if := planeI valueF: theLine from.
	it := planeI valueF: theLine to.
	(jf * jt < self class accuracy and: [if * it < self class accuracy]) 
		ifTrue: 
			[(0.0d - jf) abs < self class accuracy 
				ifTrue: 
					[t1 := t2 := 0.0d.
					p1 := self atT: t1.
					p2 := self atT: t2.
					^Array with: p1 with: p2]
				ifFalse: 
					[de := jf - jt.
					de = 0.0 ifTrue: [de := self class accuracy].
					t1 := jf / de].
			(0 - if) abs < self class accuracy 
				ifTrue: 
					[t1 := t2 := 0.0d.
					p1 := theLine atT: t1.
					p2 := theLine atT: t2.
					^Array with: p1 with: p2]
				ifFalse: 
					[de := if - it.
					de = 0.0d ifTrue: [de := self class accuracy].
					t2 := if / de].
			p1 := self atT: t1.
			p2 := theLine atT: t2.
			^Array with: p1 with: p2].
	^Array new
]

{ #category : #private }
Jun3dLine >> intersectingTWithLine: aJun3dLine [ 
	"(Jun3dLine from: 0, 0, 0 to: 1.5, 0, 0) intersectingTWithLine: (Jun3dLine from: 1, 1, -1 to: 1, -1, -1)"

	| yourF yourG yourH denominatorXY denominatorYZ denominatorZX yourX0 yourY0 yourZ0 |
	yourF := aJun3dLine f.
	yourG := aJun3dLine g.
	yourH := aJun3dLine h.
	yourX0 := aJun3dLine x0.
	yourY0 := aJun3dLine y0.
	yourZ0 := aJun3dLine z0.
	denominatorXY := yourF * g - (f * yourG).
	denominatorYZ := yourG * h - (g * yourH).
	denominatorZX := yourH * f - (h * yourF).
	((denominatorXY abs max: denominatorYZ abs)
		max: denominatorZX abs)
		< self class accuracy ifTrue: ["parallel"
		^nil].
	^(denominatorXY abs >= denominatorYZ abs and: [denominatorXY abs >= denominatorZX abs])
		ifTrue: 
			[| t |
			t := yourF * (yourY0 - y0) - (yourG * (yourX0 - x0)) / denominatorXY.
			(yourF * h - (f * yourH) * t + (z0 - aJun3dLine z0 * yourF) - (x0 - yourX0 * yourH)) abs < self class accuracy
				ifTrue: [t]
				ifFalse: [nil]]
		ifFalse: [denominatorYZ abs >= denominatorZX abs
				ifTrue: 
					[| t |
					t := yourG * (yourZ0 - z0) - (yourH * (yourY0 - y0)) / denominatorYZ.
					(yourG * f - (g * yourF) * t + (x0 - yourX0 * yourG - (y0 - yourY0 * yourF))) abs < self class accuracy
						ifTrue: [t]
						ifFalse: [nil]]
				ifFalse: 
					[| t |
					t := yourH * (yourX0 - x0) - (yourF * (yourZ0 - z0)) / denominatorZX.
					(yourH * g - (h * yourG) * t + (y0 - yourY0 * yourH) - (z0 - yourZ0 * yourG)) abs < self class accuracy
						ifTrue: [t]
						ifFalse: [nil]]]
]

{ #category : #functions }
Jun3dLine >> intersectsLine: aLine viewPoint: aPoint [ 
	"(50 , 50 , -50 to: -50 , -50 , -50) 
		intersectsLine: (-50 , 50 , 50 to: 50 , -50 , 50) 
		viewPoint: 0 , 0 , 100."

	^(self intersectingPointsLine: aLine viewPoint: aPoint) isEmpty not
]

{ #category : #testing }
Jun3dLine >> is3d [
	^true
]

{ #category : #testing }
Jun3dLine >> lineSegmentContainsPoint: aPoint [ 
	| thePoint |
	thePoint := Jun3dPoint coerce: aPoint.
	^(self lineSegmentDistanceFromPoint: thePoint)
		< self class accuracy
]

{ #category : #functions }
Jun3dLine >> lineSegmentDistanceFromPoint: aPoint [ 
	"(0 , 0 , 0 to: 1 , 1 , 1) lineSegmentDistanceFromPoint: -1 , 1 , 1."

	| thePoint denominator x y z pointOnMe t |
	thePoint := Jun3dPoint coerce: aPoint.
	denominator := f squared + g squared + h squared.
	denominator < self class accuracy 
		ifTrue: [^self error: 'can not define a line'].
	x := aPoint x - x0.
	y := aPoint y - y0.
	z := aPoint z - z0.
	t := (f * x + (g * y) + (h * z)) / denominator.
	(t < 0.0d or: [1 < t]) 
		ifTrue: 
			[t < 0.0d 
				ifTrue: [pointOnMe := self atT: 0.0d]
				ifFalse: [pointOnMe := self atT: 1.0d]]
		ifFalse: [pointOnMe := self atT: t].
	^thePoint distance: pointOnMe
]

{ #category : #functions }
Jun3dLine >> lineSegmentNearestPointFromPoint: aPoint [ 
	"(0 , 0 , 0 to: 1 , 1 , 1) lineSegmentNearestPointFromPoint: -1 , 1 , 1."

	| denominator x y z pointOnMe t |
	denominator := f squared + g squared + h squared.
	denominator < self class accuracy 
		ifTrue: [^self error: 'can not define a line'].
	x := aPoint x - x0.
	y := aPoint y - y0.
	z := aPoint z - z0.
	t := (f * x + (g * y) + (h * z)) / denominator.
	(t < 0.0d or: [1 < t]) 
		ifTrue: 
			[t < 0.0d 
				ifTrue: [pointOnMe := self atT: 0.0d]
				ifFalse: [pointOnMe := self atT: 1.0d]]
		ifFalse: [pointOnMe := self atT: t].
	^pointOnMe
]

{ #category : #testing }
Jun3dLine >> lineSegmentStrictlyContainsPoint: aPoint [ 
	^(self lineSegmentContainsPoint: aPoint)
		and: [(self from distance: aPoint)
				> self class accuracy and: [(self to distance: aPoint)
					> self class accuracy]]
]

{ #category : #parameters }
Jun3dLine >> n [
	"Answer my normalized constant."

	| denominator |
	denominator := f squared + g squared + h squared.
	denominator < self class accuracy 
		ifTrue: [^self error: 'can not define a line'].
	^1.0d / denominator sqrt
]

{ #category : #functions }
Jun3dLine >> nearestPointFromLine: aJun3dLine [ 
	| commonNormalVector plane theLineOnPlane f1 g1 x1 y1 t |
	commonNormalVector := f , g , h 
				vectorProduct: aJun3dLine f , aJun3dLine g , aJun3dLine h.
	commonNormalVector length < self class accuracy ifTrue: [^nil].
	plane := JunPlane on: self from normalVector: commonNormalVector.
	theLineOnPlane := plane projectionOfLine: aJun3dLine.
	f1 := theLineOnPlane f.
	g1 := theLineOnPlane g.
	x1 := theLineOnPlane x0.
	y1 := theLineOnPlane y0.
	t := ((x0 - x1) * g1 + ((y1 - y0) * f1)) / (f1 * g - (f * g1)).
	^self atT: t
]

{ #category : #functions }
Jun3dLine >> nearestPointFromPoint: aPoint [ 
	"(0 , 0 , 0 to: 1 , 1 , 1) nearestPointFromPoint: -1 , 1 , 1."

	| thePoint denominator x y z t pointOnMe |
	thePoint := Jun3dPoint coerce: aPoint.
	denominator := f squared + g squared + h squared.
	denominator < self class accuracy 
		ifTrue: [^self error: 'can not define a line'].
	x := thePoint x - x0.
	y := thePoint y - y0.
	z := thePoint z - z0.
	t := (f * x + (g * y) + (h * z)) / denominator.
	pointOnMe := self atT: t.
	^pointOnMe
]

{ #category : #functions }
Jun3dLine >> normalizedLine [
	| copy n |
	copy := self copy.
	n := self n.
	copy setF: f * n.
	copy setG: g * n.
	copy setH: h * n.
	^copy
]

{ #category : #accessing }
Jun3dLine >> on: aPoint vertical: aPlane [ 
	| fromPoint toPoint |
	fromPoint := self pointClass coerce: aPoint.
	toPoint := aPlane footOfPerpendicularFrom: fromPoint.
	self from: fromPoint to: toPoint
]

{ #category : #parameters }
Jun3dLine >> parameterArray [
	| array |
	array := Array new: 6.
	array at: 1 put: x0.
	array at: 2 put: y0.
	array at: 3 put: z0.
	array at: 4 put: f.
	array at: 5 put: g.
	array at: 6 put: h.
	^array
]

{ #category : #parameters }
Jun3dLine >> parameterMatrix [
	"(Jun3dLine from: 0 , 0 , 0 to: 1 , 1 , 1) parameterMatrix."

	^JunMatrix
		new: 2
		by: 3
		collection: self parameterArray
]

{ #category : #functions }
Jun3dLine >> projectionOfPoint: aJun3dPoint [ 
	^self atT: (self tAtPoint: aJun3dPoint)
]

{ #category : #functions }
Jun3dLine >> reflectingLineWithPlane: aPlane [ 
	^aPlane reflectingLineWithLine: self
]

{ #category : #transforming }
Jun3dLine >> rotatedBy: anAngle [ 
	^self transform: (Jun3dTransformation rotate: anAngle)
]

{ #category : #transforming }
Jun3dLine >> scaledBy: aPoint [ 
	^self transform: (Jun3dTransformation scale: aPoint)
]

{ #category : #private }
Jun3dLine >> setF: aNumber [ 
	f := aNumber asDouble
]

{ #category : #private }
Jun3dLine >> setG: aNumber [ 
	g := aNumber asDouble
]

{ #category : #private }
Jun3dLine >> setH: aNumber [ 
	h := aNumber asDouble
]

{ #category : #private }
Jun3dLine >> setX0: aNumber [ 
	x0 := aNumber asDouble
]

{ #category : #private }
Jun3dLine >> setY0: aNumber [ 
	y0 := aNumber asDouble
]

{ #category : #private }
Jun3dLine >> setZ0: aNumber [ 
	z0 := aNumber asDouble
]

{ #category : #sweeping }
Jun3dLine >> sweepAround: aJun3dLine [ 
	"(Jun3dLine from: 0, 1, 0 to: 1, 1, 0) sweepAround: (Jun3dLine from: 0, 0, 0 to: 1, 0, 0)"

	^self asNurbsCurve sweepAround: aJun3dLine
]

{ #category : #accessing }
Jun3dLine >> tAtPoint: aPoint [ 
	| dominator x y z |
	dominator := f squared + g squared + h squared.
	dominator < self class accuracy ifTrue: [^self error: 'Can''t define a line'].
	x := aPoint x - x0.
	y := aPoint y - y0.
	z := aPoint z - z0.
	^f * x + (g * y) + (h * z) / dominator
]

{ #category : #accessing }
Jun3dLine >> tAtX: aNumber [ 
	f abs < self class accuracy ifTrue: [^nil].
	^aNumber - x0 / f
]

{ #category : #accessing }
Jun3dLine >> tAtY: aNumber [ 
	g abs < self class accuracy ifTrue: [^nil].
	^aNumber - y0 / g
]

{ #category : #accessing }
Jun3dLine >> tAtZ: aNumber [ 
	h abs < self class accuracy ifTrue: [^nil].
	^aNumber - z0 / h
]

{ #category : #transforming }
Jun3dLine >> transform: aTransformation [ 
	^self class from: (self from transform: aTransformation)
		to: (self to transform: aTransformation)
]

{ #category : #transforming }
Jun3dLine >> translatedBy: aPoint [ 
	^self transform: (Jun3dTransformation translate: aPoint)
]

{ #category : #parameters }
Jun3dLine >> x0 [
	^x0
]

{ #category : #parameters }
Jun3dLine >> y0 [
	^y0
]

{ #category : #parameters }
Jun3dLine >> z0 [
	^z0
]

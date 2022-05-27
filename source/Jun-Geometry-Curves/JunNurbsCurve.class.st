"
Imported by VwImportClass
"
Class {
	#name : #JunNurbsCurve,
	#superclass : #JunCurve,
	#instVars : [
		'controlPoints',
		'weights',
		'knotVector'
	],
	#category : #'Jun-Geometry-Curves'
}

{ #category : #'instance creation' }
JunNurbsCurve class >> bSplineControlPoints: anArrayOfPoints knotVector: anArrayOfNumbers [ 
	| numberOfPoints |
	numberOfPoints := anArrayOfPoints size.
	^self
		controlPoints: anArrayOfPoints
		weights: (Array new: numberOfPoints withAll: 1.0)
		knotVector: anArrayOfNumbers
]

{ #category : #'instance creation' }
JunNurbsCurve class >> bezierControlPoints: anArrayOfPoints [ 
	| numberOfPoints knotVector |
	numberOfPoints := anArrayOfPoints size.
	knotVector := Array new: numberOfPoints * 2.
	1 to: numberOfPoints do: [:index | knotVector at: index put: 0.0; at: index + numberOfPoints put: 1.0].
	^self bSplineControlPoints: anArrayOfPoints knotVector: knotVector
]

{ #category : #'instance creation' }
JunNurbsCurve class >> bezierControlPoints: anArrayOfPoint weights: anArrayOfNumber [ 
	| numberOfPoints knotVector |
	numberOfPoints := anArrayOfPoint size.
	knotVector := Array new: numberOfPoints * 2.
	1 to: numberOfPoints do: [:index | knotVector at: index put: 0.0; at: index + numberOfPoints put: 1.0].
	^self
		controlPoints: anArrayOfPoint
		weights: anArrayOfNumber
		knotVector: knotVector
]

{ #category : #'instance creation' }
JunNurbsCurve class >> circleCenter: aJun3dPoint1 normalVector: aJun3dPoint2 radius: aNumber [ 
	"JunNurbsCurve circleCenter: 0, 0, 0 normalVector: 1, 1, 1 radius: 1"

	| center normal controlPoints weights knots scale xVector yVector |
	center := aJun3dPoint1.
	normal := aJun3dPoint2 unitVector.
	scale := aNumber , aNumber , aNumber.
	xVector := 0 , 0 , 1 vectorProduct: normal.
	xVector length < xVector class accuracy
		ifTrue: 
			[xVector := 1 , 0 , 0.
			yVector := 0 , 1 , 0]
		ifFalse: 
			[xVector := xVector unitVector * scale.
			yVector := (normal vectorProduct: xVector) unitVector * scale].
	controlPoints := Array new: 9.
	controlPoints at: 1 put: center + yVector negated.
	controlPoints at: 2 put: center + xVector + yVector negated.
	controlPoints at: 3 put: center + xVector.
	controlPoints at: 4 put: center + xVector + yVector.
	controlPoints at: 5 put: center + yVector.
	controlPoints at: 6 put: center + xVector negated + yVector.
	controlPoints at: 7 put: center + xVector negated.
	controlPoints at: 8 put: center + xVector negated + yVector negated.
	controlPoints at: 9 put: center + yVector negated.
	weights := Array new: 9.
	weights at: 1 put: 1.0d.
	weights at: 2 put: 1.0d / 2.0 sqrt.
	weights at: 3 put: 1.0d.
	weights at: 4 put: 1.0d / 2.0 sqrt.
	weights at: 5 put: 1.0d.
	weights at: 6 put: 1.0d / 2.0 sqrt.
	weights at: 7 put: 1.0d.
	weights at: 8 put: 1.0d / 2.0 sqrt.
	weights at: 9 put: 1.0d.
	knots := #(0 0 0 1 1 2 2 3 3 4 4 4).
	^JunNurbsCurve
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'instance creation' }
JunNurbsCurve class >> controlPoints: anArrayOfPoints weights: anArrayOfNumber1 knotVector: anArrayOfNumber2 [ 
	^self new
		controlPoints: anArrayOfPoints
		weights: anArrayOfNumber1
		knotVector: anArrayOfNumber2
]

{ #category : #'lisp support' }
JunNurbsCurve class >> controlPointsFromTable: aTable for: aNurbsCurve [ 
	| pointsList |
	pointsList := aTable at: #controlPoints ifAbsent: [^aNurbsCurve].
	aNurbsCurve controlPoints: (pointsList 
				collect: [:aList | self pointClass fromLispList: aList]).
	^aNurbsCurve
]

{ #category : #copyright }
JunNurbsCurve class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunNurbsCurve class >> example1 [
	"JunNurbsCurve example1."

	| window rc projection |
	window := ScheduledWindow new.
	window minimumSize: 250 @ 250.
	window open.
	rc := window renderingContext.
	
	[projection := JunOpenGLProjection default.
	projection eyePoint: 0 , 0 , -5000.
	projection sightPoint: 0 , 0 , 0.
	projection near: 1.
	projection far: 1000000.
	rc projection: projection.
	rc disableLighting.
	rc disableFog.
	rc clear.
	rc paint: ColorValue blue.
	rc displayNurbsCurve: JunNurbsCurve exampleBSplineCurve]
		ensure: [rc flush].
	Cursor crossHair showWhile: [rc medium sensor waitClickButton].
	window controller closeAndUnschedule
]

{ #category : #examples }
JunNurbsCurve class >> example2 [
	"JunNurbsCurve example2."

	| window rc projection |
	window := ScheduledWindow new.
	window minimumSize: 250 @ 250.
	window open.
	rc := window renderingContext.
	
	[projection := JunOpenGLProjection default.
	projection eyePoint: 0 , 0 , 10.
	projection sightPoint: 0 , 0 , 0.
	projection near: 1.
	projection far: 1000000.
	rc projection: projection.
	rc disableLighting.
	rc disableFog.
	rc clear.
	rc paint: ColorValue blue.
	JunNurbsCurve exampleCircle renderOn: rc]
		ensure: [rc flush].
	Cursor crossHair showWhile: [rc medium sensor waitClickButton].
	window controller closeAndUnschedule
]

{ #category : #examples }
JunNurbsCurve class >> exampleBSplineCurve [
	"JunNurbsCurve exampleBSplineCurve."

	| controlPoints knotVector |
	controlPoints := Array new: 9.
	controlPoints at: 1 put: 1000 , -1000 , 0.
	controlPoints at: 2 put: -1000 , -1000 , 0.
	controlPoints at: 3 put: -1000 , 1000 , 0.
	controlPoints at: 4 put: 1000 , 1000 , 0.
	controlPoints at: 5 put: 1000 , -1000 , 0.
	controlPoints at: 6 put: -1000 , -1000 , 0.
	controlPoints at: 7 put: -1000 , 1000 , 0.
	controlPoints at: 8 put: 1000 , 1000 , 0.
	controlPoints at: 9 put: 1000 , -1000 , 0.
	knotVector := #(0 1 2 3 4 5 6 7 8 9 10 11 12).
	^self bSplineControlPoints: controlPoints knotVector: knotVector
]

{ #category : #examples }
JunNurbsCurve class >> exampleBezierCurve [
	"JunNurbsCurve exampleBezierCurve."

	| controlPoints |
	controlPoints := Array new: 5.
	controlPoints at: 1 put: 1 , -1 , 0.
	controlPoints at: 2 put: -1 , -1 , 0.
	controlPoints at: 3 put: -1 , 1 , 0.
	controlPoints at: 4 put: 1 , 1 , 0.
	controlPoints at: 5 put: 1 , -1 , 0.
	^self bezierControlPoints: controlPoints
]

{ #category : #examples }
JunNurbsCurve class >> exampleCircle [
	"JunNurbsCurve exampleCircle."

	| controlPoints weights knots |
	controlPoints := Array new: 9.
	controlPoints at: 1 put: 0 , -1 , 0.
	controlPoints at: 2 put: 1 , -1 , 0.
	controlPoints at: 3 put: 1 , 0 , 0.
	controlPoints at: 4 put: 1 , 1 , 0.
	controlPoints at: 5 put: 0 , 1 , 0.
	controlPoints at: 6 put: -1 , 1 , 0.
	controlPoints at: 7 put: -1 , 0 , 0.
	controlPoints at: 8 put: -1 , -1 , 0.
	controlPoints at: 9 put: 0 , -1 , 0.
	weights := Array new: 9.
	weights at: 1 put: 1.0d.
	weights at: 2 put: 1 / 2.0d sqrt.
	weights at: 3 put: 1.0d.
	weights at: 4 put: 1 / 2.0d sqrt.
	weights at: 5 put: 1.0d.
	weights at: 6 put: 1 / 2.0d sqrt.
	weights at: 7 put: 1.0d.
	weights at: 8 put: 1 / 2.0d sqrt.
	weights at: 9 put: 1.0d.
	knots := #(0 0 0 1 1 2 2 3 3 4 4 4).
	^JunNurbsCurve 
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'lisp support' }
JunNurbsCurve class >> fromTable: aTable for: aNurbsCurve [ 
	"JunNurbsCurve fromLispList: ((JunNurbsCurve exampleCircle) toLispList)."

	self controlPointsFromTable: aTable for: aNurbsCurve.
	self weightsFromTable: aTable for: aNurbsCurve.
	self knotVectorFromTable: aTable for: aNurbsCurve.
	^aNurbsCurve
]

{ #category : #'lisp support' }
JunNurbsCurve class >> knotVectorFromTable: aTable for: aNurbsCurve [ 
	| aList |
	aList := aTable at: #knotVector ifAbsent: [^aNurbsCurve].
	aNurbsCurve knotVector: aList asArray.
	^aNurbsCurve
]

{ #category : #copyright }
JunNurbsCurve class >> system [
	^'Jun'
]

{ #category : #'instance creation' }
JunNurbsCurve class >> unitCircle [
	| controlPoints weights knots |
	controlPoints := Array new: 9.
	controlPoints at: 1 put: 0 , -1 , 0.
	controlPoints at: 2 put: 1 , -1 , 0.
	controlPoints at: 3 put: 1 , 0 , 0.
	controlPoints at: 4 put: 1 , 1 , 0.
	controlPoints at: 5 put: 0 , 1 , 0.
	controlPoints at: 6 put: -1 , 1 , 0.
	controlPoints at: 7 put: -1 , 0 , 0.
	controlPoints at: 8 put: -1 , -1 , 0.
	controlPoints at: 9 put: 0 , -1 , 0.
	weights := Array new: 9.
	weights at: 1 put: 1.0.
	weights at: 2 put: 1 / 2.0 sqrt.
	weights at: 3 put: 1.0.
	weights at: 4 put: 1 / 2.0 sqrt.
	weights at: 5 put: 1.0.
	weights at: 6 put: 1 / 2.0 sqrt.
	weights at: 7 put: 1.0.
	weights at: 8 put: 1 / 2.0 sqrt.
	weights at: 9 put: 1.0.
	knots := #(0 0 0 1 1 2 2 3 3 4 4 4).
	^JunNurbsCurve
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #copyright }
JunNurbsCurve class >> version [
	^'799'
]

{ #category : #'lisp support' }
JunNurbsCurve class >> weightsFromTable: aTable for: aNurbsCurve [ 
	| aList |
	aList := aTable at: #weights ifAbsent: [^aNurbsCurve].
	aNurbsCurve weights: aList asArray.
	^aNurbsCurve
]

{ #category : #comparing }
JunNurbsCurve >> = aNurbsCurve [ 
	| size |
	self class == aNurbsCurve class ifFalse: [^false].
	(size := self controlPoints size) = aNurbsCurve controlPoints size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			(self controlPoints at: index) = (aNurbsCurve controlPoints at: index) 
				ifFalse: [^false]].
	(size := self weights size) = aNurbsCurve weights size ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			(self weights at: index) = (aNurbsCurve weights at: index) 
				ifFalse: [^false]].
	(size := self knotVector size) = aNurbsCurve knotVector size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			(self knotVector at: index) = (aNurbsCurve knotVector at: index) 
				ifFalse: [^false]].
	^true
]

{ #category : #converting }
JunNurbsCurve >> asArrayOfLines [
	| pointCollection lineCollection startPoint endPoint |
	pointCollection := self asPointArray.
	lineCollection := OrderedCollection new.
	startPoint := pointCollection first.
	2 to: pointCollection size
		do: 
			[:index | 
			endPoint := pointCollection at: index.
			lineCollection add: (startPoint to: endPoint).
			startPoint := endPoint].
	^lineCollection asArray
]

{ #category : #converting }
JunNurbsCurve >> asJunOpenGL3dNurbsCurve [
	^JunOpenGL3dNurbsCurve controlPoints: controlPoints copy weights: weights copy knotVector: knotVector copy
]

{ #category : #converting }
JunNurbsCurve >> asJunOpenGL3dObject [
	^self asJunOpenGL3dNurbsCurve
]

{ #category : #converting }
JunNurbsCurve >> asJunOpenGL3dPolyline [
	^self asJunOpenGL3dPolyline: controlPoints size * 4
]

{ #category : #converting }
JunNurbsCurve >> asJunOpenGL3dPolyline: anInteger [ 
	^JunOpenGL3dPolyline vertexes: (self asPointArray: anInteger)
]

{ #category : #converting }
JunNurbsCurve >> asNurbsCurve [
	^self
]

{ #category : #converting }
JunNurbsCurve >> asPointArray [
	^self asPointArray: controlPoints size * 4
]

{ #category : #converting }
JunNurbsCurve >> asPointArray: anInteger [ 
	| divisions |
	divisions := anInteger rounded.
	^(0 to: divisions)
		collect: [:index | self atT: index / divisions]
]

{ #category : #accessing }
JunNurbsCurve >> atT: aNumber [ 
	| bspline numerator dominator |
	(aNumber between: 0 and: 1)
		ifFalse: [^nil].
	bspline := self bspline.
	numerator := Jun3dPoint zero.
	dominator := 0.
	1 to: controlPoints size
		do: 
			[:i | 
			| nw |
			nw := (bspline i: i t: aNumber)
						* (weights at: i).
			numerator := numerator + (nw * (controlPoints at: i)).
			dominator := dominator + nw].
	dominator = 0 ifTrue: [^self controlPointAt: self controlPointSize].
	^numerator / dominator
]

{ #category : #accessing }
JunNurbsCurve >> bspline [
	^JunBSplineFunction knotVector: self knotVector copy order: self order
]

{ #category : #accessing }
JunNurbsCurve >> center [
	^self atT: 0.5d
]

{ #category : #accessing }
JunNurbsCurve >> controlPointAt: anInteger [
	^controlPoints at: anInteger
]

{ #category : #accessing }
JunNurbsCurve >> controlPointAt: anInteger put: aJun3dPoint [
	controlPoints at: anInteger put: aJun3dPoint
]

{ #category : #accessing }
JunNurbsCurve >> controlPointSize [
	^controlPoints size
]

{ #category : #accessing }
JunNurbsCurve >> controlPoints [
	"Answers anArray that contains my control points."

	^controlPoints copy
]

{ #category : #accessing }
JunNurbsCurve >> controlPoints: anArray [ 
	controlPoints := anArray
]

{ #category : #private }
JunNurbsCurve >> controlPoints: anArrayOfPoints weights: anArrayOfNumber1 knotVector: anArrayOfNumber2 [ 
	controlPoints := anArrayOfPoints.
	weights := anArrayOfNumber1.
	knotVector := anArrayOfNumber2
]

{ #category : #'lisp support' }
JunNurbsCurve >> controlPointsToLispList [
	| list |
	list := self lispCons.
	list head: #controlPoints.
	list tail: (self class defaultLispConsClass 
				list: (self controlPoints collect: [:p | p toLispList])).
	^list
]

{ #category : #accessing }
JunNurbsCurve >> degree [
	^self order - 1
]

{ #category : #comparing }
JunNurbsCurve >> equal: aNurbsCurve [ 
	| size |
	self class == aNurbsCurve class ifFalse: [^false].
	(size := self controlPoints size) = aNurbsCurve controlPoints size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self controlPoints at: index) 
				equal: (aNurbsCurve controlPoints at: index)) ifFalse: [^false]].
	(size := self weights size) = aNurbsCurve weights size ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self weights at: index) - (aNurbsCurve weights at: index)) abs 
				< self accuracy ifFalse: [^false]].
	(size := self knotVector size) = aNurbsCurve knotVector size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self knotVector at: index) - (aNurbsCurve knotVector at: index)) abs 
				< self accuracy ifFalse: [^false]].
	^true
]

{ #category : #testing }
JunNurbsCurve >> is3d [
	^true
]

{ #category : #accessing }
JunNurbsCurve >> knotVector [
	"Answer an Array that contains my knots."

	^knotVector
]

{ #category : #accessing }
JunNurbsCurve >> knotVector: anArray [ 
	knotVector := anArray
]

{ #category : #'lisp support' }
JunNurbsCurve >> knotVectorToLispList [
	| list |
	list := self lispCons.
	list head: #knotVector.
	list tail: (self class defaultLispConsClass list: self knotVector).
	^list
]

{ #category : #accessing }
JunNurbsCurve >> order [
	^knotVector size - controlPoints size.
]

{ #category : #copying }
JunNurbsCurve >> postCopy [
	super postCopy.
	knotVector := knotVector copy.
	controlPoints := controlPoints copy.
	weights := weights copy
]

{ #category : #displaying }
JunNurbsCurve >> renderOn: renderingContext [ 
	renderingContext displayNurbsCurve: self
]

{ #category : #converting }
JunNurbsCurve >> reversed [
	| reversedKnots |
	reversedKnots := (1 to: knotVector size)
				collect: [:index | knotVector last - (knotVector at: knotVector size + 1 - index)].
	^self class
		controlPoints: self controlPoints reverse
		weights: self weights reverse
		knotVector: reversedKnots
]

{ #category : #sweeping }
JunNurbsCurve >> sweepAround: aJun3dLine [ 
	"JunNurbsCurve exampleCircle sweepAround: (Jun3dLine from: 0, 2, 0 to: 1, 2, 0)"
	"(JunNurbsCurve exampleCircle sweepAround: (Jun3dLine from: 0, 2, 0 to: 1, 2, 0)) reversed asJunOpenGL3dObject paint: ColorValue blue; show"

	| circles cps ws uKnotVector vKnotVector |
	circles := controlPoints collect: [:point | point sweepAround: aJun3dLine].
	cps := JunMatrix new: self controlPointSize by: circles first controlPointSize.
	ws := JunMatrix new: self controlPointSize by: circles first controlPointSize.
	1 to: circles size do: [:rowIndex | 1 to: circles first controlPointSize
			do: 
				[:columnIndex | 
				cps
					row: rowIndex
					column: columnIndex
					put: ((circles at: rowIndex)
							controlPointAt: columnIndex).
				ws
					row: rowIndex
					column: columnIndex
					put: ((circles at: rowIndex)
							weightAt: columnIndex) * (self weightAt: rowIndex)]].
	uKnotVector := knotVector copy.
	vKnotVector := circles first knotVector copy.
	^JunNurbsSurface
		controlPoints: cps
		weights: ws
		uKnotVector: uKnotVector
		vKnotVector: vKnotVector
]

{ #category : #'lisp support' }
JunNurbsCurve >> toLispList [
	"(JunNurbsCurve exampleCircle) toLispList."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self controlPointsToLispList.
	list add: self weightsToLispList.
	list add: self knotVectorToLispList.
	^list
]

{ #category : #transforming }
JunNurbsCurve >> transform: aJunTransformaion [ 
	| theNurbsCurve |
	theNurbsCurve := self copy.
	1 to: theNurbsCurve controlPointSize
		do: 
			[:index | 
			| point transformedPoint |
			point := theNurbsCurve controlPointAt: index.
			transformedPoint := point transform: aJunTransformaion.
			theNurbsCurve controlPointAt: index put: transformedPoint].
	^theNurbsCurve
]

{ #category : #accessing }
JunNurbsCurve >> weightAt: anInteger [
	^weights at: anInteger
]

{ #category : #accessing }
JunNurbsCurve >> weightAt: anInteger put: aNumber [
	^weights at: anInteger put: aNumber
]

{ #category : #accessing }
JunNurbsCurve >> weights [
	"Answer an Array of my weight map of control points."

	^weights copy
]

{ #category : #accessing }
JunNurbsCurve >> weights: anArray [ 
	weights := anArray
]

{ #category : #'lisp support' }
JunNurbsCurve >> weightsToLispList [
	| list |
	list := self lispCons.
	list head: #weights.
	list tail: (self class defaultLispConsClass list: self weights).
	^list
]

{ #category : #testing }
JunNurbsCurve >> whichSideOf: aPlane [ 
	| anArray hasPlus hasMinus hasZero |
	anArray := self asPointArray 
				collect: [:aPoint | aPoint whichSideOf: aPlane].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

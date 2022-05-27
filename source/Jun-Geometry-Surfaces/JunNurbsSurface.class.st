"
Imported by VwImportClass
"
Class {
	#name : #JunNurbsSurface,
	#superclass : #JunSurface,
	#instVars : [
		'controlPoints',
		'uKnotVector',
		'vKnotVector',
		'weights'
	],
	#category : #'Jun-Geometry-Surfaces'
}

{ #category : #'instance creation' }
JunNurbsSurface class >> bSplineControlPoints: aMatrix uKnotVector: anArray1 vKnotVector: anArray2 [ 
	| rowSize columnSize |
	rowSize := aMatrix rowSize.
	columnSize := aMatrix columnSize.
	^self
		controlPoints: aMatrix
		weights: (JunMatrix
				new: rowSize
				by: columnSize
				collection: (Array new: rowSize * columnSize withAll: 1))
		uKnotVector: anArray1
		vKnotVector: anArray2
]

{ #category : #'instance creation' }
JunNurbsSurface class >> bezierControlPoints: aMatrix [ 
	| columnSize rowSize uKnotVector vKnotVector |
	columnSize := aMatrix columnSize.
	rowSize := aMatrix rowSize.
	uKnotVector := Array new: rowSize * 2.
	1 to: rowSize
		do: 
			[:index | 
			uKnotVector at: index put: 0.0.
			uKnotVector at: index + rowSize put: 1.0].
	vKnotVector := Array new: columnSize * 2.
	1 to: columnSize
		do: 
			[:index | 
			vKnotVector at: index put: 0.0.
			vKnotVector at: index + columnSize put: 1.0].
	^self
		bSplineControlPoints: aMatrix
		uKnotVector: uKnotVector
		vKnotVector: vKnotVector
]

{ #category : #'instance creation' }
JunNurbsSurface class >> controlPoints: aMatrix1 weights: aMatrix2 uKnotVector: anArray1 vKnotVector: anArray2 [
	^self new
		controlPoints: aMatrix1
		weights: aMatrix2
		uKnotVector: anArray1
		vKnotVector: anArray2
]

{ #category : #'lisp support' }
JunNurbsSurface class >> controlPointsFromTable: aTable for: aNurbsSurface [ 
	| aList |
	aList := aTable at: #controlPoints ifAbsent: [^aNurbsSurface].
	aNurbsSurface controlPoints: (JunMatrix fromLispList: aList).
	^aNurbsSurface
]

{ #category : #copyright }
JunNurbsSurface class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunNurbsSurface class >> example1 [
	"JunNurbsSurface example1."

	| aBezierSurface window rc projection |
	aBezierSurface := JunNurbsSurface exampleBezierSurface.
	window := ScheduledWindow new.
	window minimumSize: 250 @ 250.
	window open.
	rc := window renderingContext.
	
	[projection := JunOpenGLProjection default.
	projection eyePoint: 0 , 1 , 3.
	projection sightPoint: Jun3dPoint zero.
	rc projection: projection.
	rc clear.
	rc lightAmbientColor: ColorValue darkGray.
	rc 
		lightIndex: 0
		position: 0 , 1 , 3
		color: ColorValue white.
	rc enableLighting.
	rc paint: ColorValue blue.
	rc materialShininess: 10.0.
	rc displayNurbsSurface: aBezierSurface] 
			ensure: [rc flush].
	Cursor crossHair showWhile: [rc medium sensor waitClickButton].
	window controller closeAndUnschedule.
	^aBezierSurface
]

{ #category : #examples }
JunNurbsSurface class >> example2 [
	"JunNurbsSurface example2."

	| aBezierSurface window rc projection |
	aBezierSurface := JunNurbsSurface exampleBezierSurface.
	window := ScheduledWindow new.
	window minimumSize: 250 @ 250.
	window open.
	rc := window renderingContext.
	
	[rc materialShininess: 10.0.
	rc 
		lightIndex: 0
		position: 0 , 0 , 1
		color: ColorValue white.
	projection := JunOpenGLProjection default.
	projection eyePoint: 10 , 10 , 10.
	rc projection: projection.
	rc clearDepthBuffer.
	rc disableBlending.
	rc
		enableFog;
		fogColor: ColorValue white.
	rc disableFog.
	rc disableLighting.
	rc paint: ColorValue blue alpha: 0.5.
	rc displayNurbsSurface: aBezierSurface.
	rc paint: ColorValue white alpha: 0.5.
	rc nurbsSamplingTolerance: 100.
	rc displayNurbsSurfaceMesh: aBezierSurface] 
			ensure: [rc flush].
	Cursor crossHair showWhile: [window sensor waitClickButton].
	window controller closeAndUnschedule.
	^aBezierSurface
]

{ #category : #examples }
JunNurbsSurface class >> exampleBSplineSurface [
	| controlPoints knots |
	controlPoints := JunMatrix new: 4.
	1 to: 4 do: [:x | 1 to: 4 do: [:y | controlPoints atPoint: y @ x put: (Jun3dPoint
					x: x - 2.5 * 2 / 3
					y: y - 2.5 * 2 / 3
					z: (((x = 2 or: [x = 3])
							and: [y = 2 or: [y = 3]])
							ifTrue: [1]
							ifFalse: [-1]))]].
	knots := #(0.0 0.0 0.5 0.5 1.0 1.0 1.0 1.0).
	^JunNurbsSurface
		bSplineControlPoints: (JunMatrix new: 4 collection: controlPoints)
		uKnotVector: knots
		vKnotVector: knots
]

{ #category : #examples }
JunNurbsSurface class >> exampleBezierSurface [
	| controlPoints |
	controlPoints := JunMatrix new: 6 by: 4.
	1 to: 4 do: [:x | 1 to: 6 do: [:y | controlPoints atPoint: y @ x put: (Jun3dPoint
					x: x - 2.5 / 3
					y: y - 2.5 / 3
					z: (((x = 2 or: [x = 3])
							and: [y = 2 or: [y = 3]])
							ifTrue: [1]
							ifFalse: [-1]))]].
	^JunNurbsSurface bezierControlPoints: controlPoints
]

{ #category : #examples }
JunNurbsSurface class >> exampleNurbsSurface [
	"JunNurbsSurface exampleNurbsSurface."

	| controlPoints weights knots |
	controlPoints := JunMatrix new: 4.
	1 to: 4
		do: 
			[:x | 
			1 to: 4
				do: 
					[:y | 
					controlPoints atPoint: y @ x
						put: (Jun3dPoint 
								x: (x - 2.5) * 2 / 3
								y: (y - 2.5) * 2 / 3
								z: (((x = 2 or: [x = 3]) and: [y = 2 or: [y = 3]]) ifTrue: [1] ifFalse: [-1]))]].
	weights := JunMatrix new: 4
				collection: ((1 to: 16) collect: [:i | (i // 4 + 1) / 2.0]).
	knots := #(0 0 1 1 2 2 2 2).
	^JunNurbsSurface 
		controlPoints: (JunMatrix new: 4 collection: controlPoints)
		weights: weights
		uKnotVector: knots
		vKnotVector: knots
]

{ #category : #'lisp support' }
JunNurbsSurface class >> fromTable: aTable for: aNurbsSurface [ 
	"JunNurbsSurface fromLispList: ((JunNurbsSurface exampleNurbsSurface) toLispList)."

	self controlPointsFromTable: aTable for: aNurbsSurface.
	self uKnotVectorFromTable: aTable for: aNurbsSurface.
	self vKnotVectorFromTable: aTable for: aNurbsSurface.
	self weightsFromTable: aTable for: aNurbsSurface.
	^aNurbsSurface
]

{ #category : #copyright }
JunNurbsSurface class >> system [
	^'Jun'
]

{ #category : #'lisp support' }
JunNurbsSurface class >> uKnotVectorFromTable: aTable for: aNurbsSurface [ 
	| aList |
	aList := aTable at: #uKnotVector ifAbsent: [^aNurbsSurface].
	aNurbsSurface uKnotVector: aList asArray.
	^aNurbsSurface
]

{ #category : #'lisp support' }
JunNurbsSurface class >> vKnotVectorFromTable: aTable for: aNurbsSurface [ 
	| aList |
	aList := aTable at: #vKnotVector ifAbsent: [^aNurbsSurface].
	aNurbsSurface vKnotVector: aList asArray.
	^aNurbsSurface
]

{ #category : #copyright }
JunNurbsSurface class >> version [
	^'799'
]

{ #category : #'lisp support' }
JunNurbsSurface class >> weightsFromTable: aTable for: aNurbsSurface [ 
	| aList |
	aList := aTable at: #weights ifAbsent: [^aNurbsSurface].
	aNurbsSurface weights: (JunMatrix fromLispList: aList).
	^aNurbsSurface
]

{ #category : #comparing }
JunNurbsSurface >> = aNurbsSurface [ 
	| size |
	self class == aNurbsSurface class ifFalse: [^false].
	(size := self controlPoints size) = aNurbsSurface controlPoints size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			(self controlPoints at: index) = (aNurbsSurface controlPoints at: index) 
				ifFalse: [^false]].
	(size := self weights size) = aNurbsSurface weights size ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			(self weights at: index) = (aNurbsSurface weights at: index) 
				ifFalse: [^false]].
	(size := self uKnotVector size) = aNurbsSurface uKnotVector size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			(self uKnotVector at: index) = (aNurbsSurface uKnotVector at: index) 
				ifFalse: [^false]].
	(size := self vKnotVector size) = aNurbsSurface vKnotVector size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			(self vKnotVector at: index) = (aNurbsSurface vKnotVector at: index) 
				ifFalse: [^false]].
	^true
]

{ #category : #converting }
JunNurbsSurface >> asJunOpenGL3dNurbsSurface [
	^JunOpenGL3dNurbsSurface
		controlPoints: controlPoints
		weights: weights
		uKnotVector: uKnotVector
		vKnotVector: vKnotVector
]

{ #category : #converting }
JunNurbsSurface >> asJunOpenGL3dObject [
	^self asJunOpenGL3dNurbsSurface
]

{ #category : #converting }
JunNurbsSurface >> asJunOpenGL3dPolygons: aPoint [ 
	| uDivisions vDivisions polygons |
	uDivisions := aPoint x rounded.
	vDivisions := aPoint y rounded.
	polygons := Array new: uDivisions * vDivisions.
	1 to: uDivisions do: [:uIndex | 1 to: vDivisions do: [:vIndex | polygons at: uIndex - 1 * vDivisions + vIndex put: (JunOpenGL3dPolygon vertexes: (Array
						with: (self atU: uIndex - 1 / uDivisions v: vIndex - 1 / vDivisions)
						with: (self atU: uIndex / uDivisions v: vIndex - 1 / vDivisions)
						with: (self atU: uIndex / uDivisions v: vIndex / vDivisions)
						with: (self atU: uIndex - 1 / uDivisions v: vIndex / vDivisions)))]].
	^JunOpenGL3dCompoundObject components: polygons
]

{ #category : #converting }
JunNurbsSurface >> asPointArray [
	^self asPointArray: self uSize * 2 @ (self vSize * 2)
]

{ #category : #converting }
JunNurbsSurface >> asPointArray: aPoint [ 
	| points uDivisions vDivisions |
	uDivisions := aPoint x rounded - 1.
	vDivisions := aPoint y rounded - 1.
	points := OrderedCollection new: uDivisions + 1 * (vDivisions + 1).
	(0 to: uDivisions)
		do: [:uIndex | (0 to: vDivisions)
				do: [:vIndex | points add: (self atU: uIndex / uDivisions v: vIndex / vDivisions)]].
	^points asArray
]

{ #category : #accessing }
JunNurbsSurface >> atU: aNumber1 v: aNumber2 [ 
	| numerator dominator uBspline vBspline |
	(aNumber1 between: 0.0d and: 1.0d)
		ifFalse: [^nil].
	(aNumber2 between: 0.0d and: 1.0d)
		ifFalse: [^nil].
	uBspline := self uBspline.
	vBspline := self vBspline.
	numerator := Jun3dPoint zero.
	dominator := 0.
	1 to: self uSize do: [:uIndex | 1 to: self vSize
			do: 
				[:vIndex | 
				| nw |
				nw := (uBspline i: uIndex t: aNumber1)
							* (vBspline i: vIndex t: aNumber2) * (self weightAtU: uIndex v: vIndex).
				numerator := numerator + (nw * (self controlPointAtU: uIndex v: vIndex)).
				dominator := dominator + nw]].
	dominator = 0 ifTrue: [^self controlPointAtU: self uSize v: self vSize].
	^numerator / dominator
]

{ #category : #'bounds accessing' }
JunNurbsSurface >> boundingBox [
	| aPoint minX maxX minY maxY minZ maxZ |
	aPoint := self controlPointAtU: 1 v: 1.
	minX := maxX := aPoint x.
	minY := maxY := aPoint y.
	minZ := maxZ := aPoint z.
	self controlPoints
		do: 
			[:point | 
			point x < minX ifTrue: [minX := point x].
			point x > maxX ifTrue: [maxX := point x].
			point y < minY ifTrue: [minY := point y].
			point y > maxY ifTrue: [maxY := point y].
			point z < minZ ifTrue: [minZ := point z].
			point z > maxZ ifTrue: [maxZ := point z]].
	^Jun3dBoundingBox origin: minX , minY , minZ corner: maxX , maxY , maxZ
]

{ #category : #accessing }
JunNurbsSurface >> controlPointAt: aPoint [
	^controlPoints atPoint: aPoint
]

{ #category : #accessing }
JunNurbsSurface >> controlPointAt: aPoint put: a3dPoint [ 
	^controlPoints atPoint: aPoint put: a3dPoint
]

{ #category : #accessing }
JunNurbsSurface >> controlPointAtU: u v: v [
	^controlPoints atPoint: u@v
]

{ #category : #accessing }
JunNurbsSurface >> controlPointAtU: u v: v put: a3dPoint [ 
	^controlPoints atPoint: u @ v put: a3dPoint
]

{ #category : #accessing }
JunNurbsSurface >> controlPointSize [
	^controlPoints matrixSize
]

{ #category : #accessing }
JunNurbsSurface >> controlPoints [
	"Answers a JunMatrix that contains my control points."

	^controlPoints
]

{ #category : #accessing }
JunNurbsSurface >> controlPoints: aJunMatrix [ 
	controlPoints := aJunMatrix
]

{ #category : #private }
JunNurbsSurface >> controlPoints: aMatrix1 weights: aMatrix2 uKnotVector: anArray1 vKnotVector: anArray2 [ 
	controlPoints := aMatrix1.
	weights := aMatrix2.
	uKnotVector := anArray1.
	vKnotVector := anArray2
]

{ #category : #'lisp support' }
JunNurbsSurface >> controlPointsToLispList [
	| list |
	list := self lispCons.
	list head: #controlPoints.
	list tail: self controlPoints toLispList.
	^list
]

{ #category : #comparing }
JunNurbsSurface >> equal: aNurbsSurface [ 
	| size |
	self class == aNurbsSurface class ifFalse: [^false].
	(size := self controlPoints size) = aNurbsSurface controlPoints size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self controlPoints at: index) 
				equal: (aNurbsSurface controlPoints at: index)) ifFalse: [^false]].
	(size := self weights size) = aNurbsSurface weights size ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self weights at: index) - (aNurbsSurface weights at: index)) abs 
				< self accuracy ifFalse: [^false]].
	(size := self uKnotVector size) = aNurbsSurface uKnotVector size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self uKnotVector at: index) - (aNurbsSurface uKnotVector at: index)) abs 
				< self accuracy ifFalse: [^false]].
	(size := self vKnotVector size) = aNurbsSurface vKnotVector size 
		ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self vKnotVector at: index) - (aNurbsSurface vKnotVector at: index)) abs 
				< self accuracy ifFalse: [^false]].
	^true
]

{ #category : #'bounds accessing' }
JunNurbsSurface >> pointsDo: aBlock [
	controlPoints do: aBlock
]

{ #category : #displaying }
JunNurbsSurface >> renderOn: renderingContext [ 
	renderingContext displayNurbsSurface: self
]

{ #category : #converting }
JunNurbsSurface >> reversed [
	| reversedUKnots reversedVKnots |
	reversedUKnots := (1 to: uKnotVector size)
				collect: [:index | uKnotVector last - (uKnotVector at: uKnotVector size + 1 - index)].
	reversedVKnots := (1 to: vKnotVector size)
				collect: [:index | vKnotVector last - (vKnotVector at: vKnotVector size + 1 - index)].

	^self class
				controlPoints: self controlPoints transpose
				weights: self weights transpose
				uKnotVector: reversedUKnots
				vKnotVector: reversedVKnots
]

{ #category : #'lisp support' }
JunNurbsSurface >> toLispList [
	"self showLispList: ((JunNurbsSurface exampleNurbsSurface) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self controlPointsToLispList.
	list add: self uKnotVectorToLispList.
	list add: self vKnotVectorToLispList.
	list add: self weightsToLispList.
	^list
]

{ #category : #private }
JunNurbsSurface >> trimCurvesDo: aBlock [
]

{ #category : #accessing }
JunNurbsSurface >> uBspline [
	^JunBSplineFunction knotVector: self uKnotVector copy order: self uOrder
]

{ #category : #accessing }
JunNurbsSurface >> uKnotAt: anInteger [
	^uKnotVector at: anInteger
]

{ #category : #accessing }
JunNurbsSurface >> uKnotAt: anInteger put: aNumber [
	^uKnotVector at: anInteger put: aNumber
]

{ #category : #accessing }
JunNurbsSurface >> uKnotVector [
	"Answer an Array that contains my knot vector of u direction"

	^uKnotVector
]

{ #category : #accessing }
JunNurbsSurface >> uKnotVector: anArray [ 
	uKnotVector := anArray
]

{ #category : #'lisp support' }
JunNurbsSurface >> uKnotVectorToLispList [
	| list |
	list := self lispCons.
	list head: #uKnotVector.
	list tail: (self class defaultLispConsClass list: self uKnotVector).
	^list
]

{ #category : #accessing }
JunNurbsSurface >> uOrder [
	^uKnotVector size - self uSize.
]

{ #category : #accessing }
JunNurbsSurface >> uSize [
	^controlPoints rowSize
]

{ #category : #accessing }
JunNurbsSurface >> vBspline [
	^JunBSplineFunction knotVector: self vKnotVector copy order: self vOrder
]

{ #category : #accessing }
JunNurbsSurface >> vKnotAt: anInteger [
	^vKnotVector at: anInteger
]

{ #category : #accessing }
JunNurbsSurface >> vKnotAt: anInteger put: aNumber [
	^vKnotVector at: anInteger put: aNumber
]

{ #category : #accessing }
JunNurbsSurface >> vKnotVector [
	"Answer an Array that contains my knot vector of v direction"

	^vKnotVector
]

{ #category : #accessing }
JunNurbsSurface >> vKnotVector: anArray [ 
	vKnotVector := anArray
]

{ #category : #'lisp support' }
JunNurbsSurface >> vKnotVectorToLispList [
	| list |
	list := self lispCons.
	list head: #vKnotVector.
	list tail: (self class defaultLispConsClass list: self vKnotVector).
	^list
]

{ #category : #accessing }
JunNurbsSurface >> vOrder [
	^vKnotVector size - self vSize.
]

{ #category : #accessing }
JunNurbsSurface >> vSize [
	^controlPoints columnSize
]

{ #category : #accessing }
JunNurbsSurface >> weightAtU: u v: v [
	^weights atPoint: u@v
]

{ #category : #accessing }
JunNurbsSurface >> weightAtU: u v: v put: aNumber [
	^weights atPoint: u@v put: aNumber
]

{ #category : #accessing }
JunNurbsSurface >> weights [
	"Answer a JunMatrix of my weight map of control points."

	^weights
]

{ #category : #accessing }
JunNurbsSurface >> weights: aJunMatrix [
	weights := aJunMatrix
]

{ #category : #'lisp support' }
JunNurbsSurface >> weightsToLispList [
	| list |
	list := self lispCons.
	list head: #weights.
	list tail: self weights toLispList.
	^list
]

{ #category : #testing }
JunNurbsSurface >> whichSideOf: aPlane [ 
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

"
Imported by VwImportClass
"
Class {
	#name : #JunLine,
	#superclass : #JunCurve,
	#category : #'Jun-Geometry-Curves'
}

{ #category : #copyright }
JunLine class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunLine class >> from: fromPoint to: toPoint [ 
	^self subclassResponsibility
]

{ #category : #'lisp support' }
JunLine class >> fromTable: aTable for: aLine [ 
	"JunLine fromLispList: ((0 , 0 to: 1 , 1) toLispList)."
	"JunLine fromLispList: ((0 , 0 , 0 to: 1 , 1 , 1) toLispList)."

	self pointsFromTable: aTable for: aLine.
	^aLine
]

{ #category : #'lisp support' }
JunLine class >> pointsFromTable: aTable for: aLine [ 
	| fromList toList |
	fromList := aTable at: #from ifAbsent: [^aLine].
	toList := aTable at: #to ifAbsent: [^aLine].
	aLine from: (self pointClass fromLispList: fromList)
		to: (self pointClass fromLispList: toList).
	^aLine
]

{ #category : #copyright }
JunLine class >> system [
	^'Jun'
]

{ #category : #copyright }
JunLine class >> version [
	^'799'
]

{ #category : #comparing }
JunLine >> = aLine [ 
	self class == aLine class ifFalse: [^false].
	^self first = aLine first and: [self last = aLine last]
]

{ #category : #functions }
JunLine >> angleWithLine: aLine [ 
	^self subclassResponsibility
]

{ #category : #converting }
JunLine >> asArrayOfLines [
	^Array with: self
]

{ #category : #converting }
JunLine >> asArrays [
	^Array with: (Array with: self from with: self to)
]

{ #category : #converting }
JunLine >> asBoundingBall [
	| centerPoint aRadius |
	centerPoint := self center.
	aRadius := centerPoint distance: self to.
	^self boundingBallClass center: self center radius: aRadius
]

{ #category : #converting }
JunLine >> asBoundingBox [
	^self boundingBoxClass origin: self from corner: self to
]

{ #category : #converting }
JunLine >> asJunOpenGL3dObject [
	"((1 , -1 , 0.5) to: (-1 , 1 , 0.5)) asJunOpenGL3dObject showWithAxes."

	| aPolyline |
	aPolyline := JunOpenGL3dPolyline 
				vertexes: (Array with: self from with: self to).
	aPolyline lineWidth: 1.
	aPolyline paint: self defaultColor.
	^aPolyline
]

{ #category : #converting }
JunLine >> asJunOpenGL3dObjectWithPoints [
	"((1 , -1 , 0.5) to: (-1 , 1 , 0.5)) asJunOpenGL3dObjectWithPoints showWithAxes."

	| aPolyline compoundObject |
	aPolyline := JunOpenGL3dPolyline 
				vertexes: (Array with: (self atT: -0.2) with: (self atT: 1.2)).
	aPolyline lineWidth: 1.
	aPolyline paint: ColorValue green.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: aPolyline.
	compoundObject add: (self from asJunOpenGL3dObject paint: ColorValue red).
	compoundObject add: (self to asJunOpenGL3dObject paint: ColorValue blue).
	^compoundObject
]

{ #category : #converting }
JunLine >> asLineLength: aLength [ 
	"
	| aLine aLength |
	aLine := 1 , 1 , 0 to: 2 , 2 , 1.
	aLine asJunOpenGL3dObject showWithUnitAxes.
	aLength := JunGeometry pi * 2.
	aLine := aLine asLineLength: aLength.
	Transcript
		cr;
		nextPutAll: aLine length printString;
		nextPutAll: ' - ';
		nextPutAll: aLength printString;
		nextPutAll: ' = ';
		nextPutAll: ((aLine length - aLength) asRational 
					asFixedPoint: aLength defaultNumberOfDigits - 1) printString;
		flush.
	aLine asJunOpenGL3dObject showWithUnitAxes.
	^aLine
	"

	^self asLineLength: aLength scalingCenter: self first
]

{ #category : #converting }
JunLine >> asLineLength: aLength scalingCenter: aPoint [ 
	"
	| aLine aLength |
	aLine := 1 , 1 , 0 to: 2 , 2 , 1.
	aLine asJunOpenGL3dObject showWithUnitAxes.
	aLength := JunGeometry pi * 2.
	aLine := aLine asLineLength: aLength
				scalingCenter: aLine first.
	Transcript
		cr;
		nextPutAll: aLine length printString;
		nextPutAll: ' - ';
		nextPutAll: aLength printString;
		nextPutAll: ' = ';
		nextPutAll: ((aLine length - aLength) asRational 
					asFixedPoint: aLength defaultNumberOfDigits - 1) printString;
		flush.
	aLine asJunOpenGL3dObject showWithUnitAxes.
	^aLine
	"

	| transformation line scale |
	transformation := aPoint negated transformationToTranslate.
	line := self transform: transformation.
	scale := aLength / line length.
	transformation := (Jun3dPoint fromNumber: scale) transformationToScale 
				product: aPoint transformationToTranslate.
	^line transform: transformation
]

{ #category : #converting }
JunLine >> asNurbsCurve [
	^JunNurbsCurve bezierControlPoints: (Array with: self from with: self center with: self to)
]

{ #category : #converting }
JunLine >> asPointArrays [
	^self asArrays collect: [:array | array collect: [:each | each asPoint]]
]

{ #category : #converting }
JunLine >> asPolyline [
	^self polylineClass vertexes: (Array with: self from with: self to)
]

{ #category : #accessing }
JunLine >> atT: t [ 
	^self subclassResponsibility
]

{ #category : #accessing }
JunLine >> atX: x [ 
	^self subclassResponsibility
]

{ #category : #accessing }
JunLine >> atY: y [ 
	^self subclassResponsibility
]

{ #category : #accessing }
JunLine >> atZ: z [ 
	^self subclassResponsibility
]

{ #category : #accessing }
JunLine >> boundingBall [
	^self asBoundingBall
]

{ #category : #accessing }
JunLine >> boundingBox [
	^self asBoundingBox
]

{ #category : #testing }
JunLine >> containsPoint: aPoint [ 
	| thePoint |
	thePoint := self pointClass coerce: aPoint.
	^(self distanceFromPoint: thePoint) < self class accuracy
]

{ #category : #functions }
JunLine >> distanceFromPoint: aPoint [ 
	"Array 
		with: ((0 , 0 , 0 to: 1 , 1 , 1) distanceFromPoint: -1 , 1 , 0)
		with: ((0 , 0 to: 1 , 1) distanceFromPoint: -1 , 1)."

	| thePoint pointOnMe |
	thePoint := self pointClass coerce: aPoint.
	pointOnMe := self footOfPerpendicularFrom: thePoint.
	^thePoint distance: pointOnMe
]

{ #category : #functions }
JunLine >> footOfPerpendicularFrom: aPoint [ 
	"Array 
		with: ((0 , 0 , 0 to: 1 , 1 , 1) footOfPerpendicularFrom: -1 , 1 , 0)
		with: ((0 , 0 to: 1 , 1) footOfPerpendicularFrom: -1 , 1)."

	^self nearestPointFromPoint: aPoint
]

{ #category : #'lisp support' }
JunLine >> fromToLispList [
	| list |
	list := self lispCons.
	list head: #from.
	list tail: self from toLispList.
	^list
]

{ #category : #comparing }
JunLine >> hash [
	^self first hash + self last hash
]

{ #category : #testing }
JunLine >> isLine [
	^true
]

{ #category : #functions }
JunLine >> isNormal [
	^(1 - self n) abs < self class accuracy
]

{ #category : #testing }
JunLine >> isParallelWithLine: aLine [ 
	"(0 , 0 to: 1 , 1) isParallelWithLine: (0 , 2 to: 1 , 3)."
	"(0 , 0 , 0 to: 1 , 1 , 0) isParallelWithLine: (0 , 2 , 0 to: 1 , 3 , 0)."

	| degrees |
	degrees := (self angleWithLine: aLine) deg.
	^(0.0d - degrees) abs < self class accuracy 
		or: [(180.0d - degrees) abs < self class accuracy]
]

{ #category : #accessing }
JunLine >> length [
	^self first distance: self last
]

{ #category : #parameters }
JunLine >> n [
	^self subclassResponsibility
]

{ #category : #functions }
JunLine >> nearestPointFromPoint: aPoint [ 
	^self subclassResponsibility
]

{ #category : #accessing }
JunLine >> normalUnitVector [
	| aLine |
	aLine := self normalizedLine.
	^aLine to - aLine from
]

{ #category : #accessing }
JunLine >> normalVector [
	^self to - self from
]

{ #category : #functions }
JunLine >> normalized [
	^self normalizedLine
]

{ #category : #functions }
JunLine >> normalizedLine [
	^self subclassResponsibility
]

{ #category : #printing }
JunLine >> printOn: aStream [ 
	aStream nextPutAll: '('.
	self from printOn: aStream.
	aStream nextPutAll: ' to: '.
	self to printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #converting }
JunLine >> reversed [
	^self class from: self to to: self from
]

{ #category : #printing }
JunLine >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' from: '.
	self from storeOn: aStream.
	aStream nextPutAll: ' to: '.
	self to storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #subdividing }
JunLine >> subdivide [
	"(((0 , 0 to: 1 , 1) subdivide) showWithArrows) wireframePresentation."

	"(((0 , 0 , 0 to: 1 , 1 , 1) subdivide) showWithArrows) wireframePresentation."

	^self polylineClass vertexes: (Array 
				with: self from
				with: self center
				with: self to)
]

{ #category : #subdividing }
JunLine >> subdivideLevel: levelNumber [ 
	"(((0 , 0 to: 1 , 1) subdivideLevel: 0) showWithArrows) wireframePresentation."

	"(((0 , 0 to: 1 , 1) subdivideLevel: 1) showWithArrows) wireframePresentation."

	"(((0 , 0 to: 1 , 1) subdivideLevel: 2) showWithArrows) wireframePresentation."

	"(((0 , 0 , 0 to: 1 , 1 , 1) subdivideLevel: 0) showWithArrows) wireframePresentation."

	"(((0 , 0 , 0 to: 1 , 1 , 1) subdivideLevel: 1) showWithArrows) wireframePresentation."

	"(((0 , 0 , 0 to: 1 , 1 , 1) subdivideLevel: 2) showWithArrows) wireframePresentation."

	| polyline |
	polyline := self asPolyline.
	levelNumber timesRepeat: [polyline := polyline subdivide].
	^polyline
]

{ #category : #'lisp support' }
JunLine >> toLispList [
	"(0 , 0 to: 1 , 1) toLispList."
	"(0 , 0 , 0 to: 1 , 1 , 1) toLispList."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self fromToLispList.
	list add: self toToLispList.
	^list
]

{ #category : #'lisp support' }
JunLine >> toToLispList [
	| list |
	list := self lispCons.
	list head: #to.
	list tail: self to toLispList.
	^list
]

{ #category : #transforming }
JunLine >> transform: aTransformation [ 
	^self class from: (self from transform: aTransformation)
		to: (self to transform: aTransformation)
]

{ #category : #transforming }
JunLine >> transformationToRotate: anAngle [ 
	^Jun3dTransformation rotate: anAngle around: self
]

{ #category : #testing }
JunLine >> whichSideOf: bisector [
	^self shouldNotImplement
]

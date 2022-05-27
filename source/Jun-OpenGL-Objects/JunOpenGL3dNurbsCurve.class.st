"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGL3dNurbsCurve,
	#superclass : #JunOpenGL3dPrimitiveObject,
	#instVars : [
		'lineWidth',
		'stippleFactor',
		'stipplePattern',
		'controlPoints',
		'weights',
		'knotVector'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #'instance creation' }
JunOpenGL3dNurbsCurve class >> bSplineControlPoints: anArrayOfPoints knotVector: anArrayOfNumbers [ 
	| numberOfPoints |
	numberOfPoints := anArrayOfPoints size.
	^self
		controlPoints: anArrayOfPoints
		weights: (Array new: numberOfPoints withAll: 1.0)
		knotVector: anArrayOfNumbers
]

{ #category : #'instance creation' }
JunOpenGL3dNurbsCurve class >> bezierControlPoints: anArrayOfPoints [ 
	| numberOfPoints knotVector |
	numberOfPoints := anArrayOfPoints size.
	knotVector := Array new: numberOfPoints * 2.
	1 to: numberOfPoints do: [:index | knotVector at: index put: 0.0; at: index + numberOfPoints put: 1.0].
	^self bSplineControlPoints: anArrayOfPoints knotVector: knotVector
]

{ #category : #'instance creation' }
JunOpenGL3dNurbsCurve class >> bezierControlPoints: anArrayOfPoint weights: anArrayOfNumber [ 
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
JunOpenGL3dNurbsCurve class >> circle [
	"JunOpenGL3dNurbsCurve circle show."

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
	^JunOpenGL3dNurbsCurve 
		controlPoints: controlPoints
		weights: weights
		knotVector: knots
]

{ #category : #'instance creation' }
JunOpenGL3dNurbsCurve class >> controlPoints: anArrayOfPoints weights: anArrayOfNumber1 knotVector: anArrayOfNumber2 [ 
	^self new
		controlPoints: anArrayOfPoints
		weights: anArrayOfNumber1
		knotVector: anArrayOfNumber2
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve class >> controlsFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #controls]]
				ifNone: [nil].
	list isNil
		ifTrue: [a3dObject controlPoints: aList tail asArray]
		ifFalse: [a3dObject controlPoints: list tail asArray].
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dNurbsCurve class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGL3dNurbsCurve class >> example1 [
	"JunOpenGL3dNurbsCurve example1."

	| nurbs list |
	nurbs := JunOpenGL3dNurbsCurve exampleBSplineCurve.
	list := nurbs showLispList.
	nurbs := nurbs class fromLispList: list.
	nurbs showLispList.
	^nurbs
]

{ #category : #examples }
JunOpenGL3dNurbsCurve class >> example2 [
	"JunOpenGL3dNurbsCurve example2."

	| nurbs list |
	nurbs := JunOpenGL3dNurbsCurve exampleBSplineCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue gray.
	nurbs alpha: 0.75.
	nurbs halftone.
	list := nurbs showLispList.
	nurbs := nurbs class fromLispList: list.
	nurbs showLispList.
	^nurbs
]

{ #category : #examples }
JunOpenGL3dNurbsCurve class >> example3 [
	"JunOpenGL3dNurbsCurve example3."

	| file nurbs stream |
	file := JunUniFileModel requestNewFileName: 'zzz.lst'.
	file isNil ifTrue: [^self].
	nurbs := JunOpenGL3dNurbsCurve exampleBSplineCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue gray.
	nurbs alpha: 0.75.
	nurbs halftone.
	stream := file writeStream.
	[Cursor write showWhile: [nurbs saveOn: stream]]
		ensure: [stream close].
	stream := file readStream.
	[Cursor read showWhile: [nurbs := nurbs class loadFrom: stream]]
		ensure: [stream close].
	nurbs show.
	^nurbs
]

{ #category : #examples }
JunOpenGL3dNurbsCurve class >> example4 [
	"JunOpenGL3dNurbsCurve example4."

	| nurbs |
	nurbs := JunOpenGL3dNurbsCurve exampleCircle.
	nurbs name: 'example'.
	nurbs paint: ColorValue red.
	nurbs show.
	^nurbs
]

{ #category : #examples }
JunOpenGL3dNurbsCurve class >> example5 [
	"JunOpenGL3dNurbsCurve example5."

	| nurbs |
	nurbs := JunOpenGL3dNurbsCurve exampleBezierCurve.
	nurbs name: 'example'.
	nurbs paint: ColorValue blue.
	nurbs show.
	^nurbs
]

{ #category : #examples }
JunOpenGL3dNurbsCurve class >> exampleBSplineCurve [
	"JunOpenGL3dNurbsCurve exampleBSplineCurve."

	| controlPoints |
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
	^self bezierControlPoints: controlPoints
]

{ #category : #examples }
JunOpenGL3dNurbsCurve class >> exampleBezierCurve [
	"JunOpenGL3dNurbsCurve exampleBezierCurve."

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
JunOpenGL3dNurbsCurve class >> exampleCircle [
	"JunOpenGL3dNurbsCurve exampleCircle."

	^JunOpenGL3dNurbsCurve circle
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve class >> fromLispList: aList [ 
	| object |
	object := self new.
	object := self propertiesFromLispList: aList for: object.
	object := self colorFromLispList: aList for: object.
	object := self lineWidthFromLispList: aList for: object.
	object := self stippleFromLispList: aList for: object.
	object := self controlsFromLispList: aList for: object.
	object := self weightsFromLispList: aList for: object.
	object := self knotsFromLispList: aList for: object.
	object := self transformationFromLispList: aList for: object.
	^object
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve class >> knotsFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #knots]]
				ifNone: [nil].
	list isNil
		ifTrue: [a3dObject knotVector: aList tail asArray]
		ifFalse: [a3dObject knotVector: list tail asArray].
	^a3dObject
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve class >> lineWidthFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #width]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject lineWidth: list tail.
	^a3dObject
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve class >> stippleFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #stipple]]
				ifNone: [nil].
	list isNil ifTrue: [^a3dObject].
	a3dObject stippleFactor: (list tail nth: 1).
	a3dObject stipplePattern: (list tail nth: 2).
	^a3dObject
]

{ #category : #copyright }
JunOpenGL3dNurbsCurve class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGL3dNurbsCurve class >> version [
	^'799'
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve class >> weightsFromLispList: aList for: a3dObject [ 
	| list |
	list := aList detect: [:car | (car isKindOf: self defaultLispConsClass)
					and: [car head = #weights]]
				ifNone: [nil].
	list isNil
		ifTrue: [a3dObject weights: aList tail asArray]
		ifFalse: [a3dObject weights: list tail asArray].
	^a3dObject
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> controlPointAt: anInteger [
	^controlPoints at: anInteger
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> controlPointAt: anInteger put: aJun3dPoint [
	controlPoints at: anInteger put: aJun3dPoint
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> controlPointSize [
	^controlPoints size
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> controlPoints [
	"Answers anArray that contains my control points."

	^controlPoints copy
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> controlPoints: anArray [ 
	controlPoints := anArray
]

{ #category : #'private-initialize' }
JunOpenGL3dNurbsCurve >> controlPoints: anArrayOfPoints weights: anArrayOfNumber1 knotVector: anArrayOfNumber2 [ 
	controlPoints := anArrayOfPoints.
	weights := anArrayOfNumber1.
	knotVector := anArrayOfNumber2
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve >> controlsToLispList [
	| controls collection |
	controls := self controlPoints.
	collection := OrderedCollection new: controls size + 1.
	collection add: #controls.
	controls do: [:p | collection add: p].
	^self defaultLispConsClass list: collection
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> degree [
	^self order - 1
]

{ #category : #enumerating }
JunOpenGL3dNurbsCurve >> geometriesDo: aBlock [ 
	aBlock value: (JunNurbsCurve
			controlPoints: controlPoints
			weights: weights
			knotVector: knotVector)
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> halftone: halftoneScale [ 
	| patternNumber |
	patternNumber := JunImageProcessor stipple: (0 max: (halftoneScale min: 1)).
	stipplePattern := patternNumber
]

{ #category : #testing }
JunOpenGL3dNurbsCurve >> hasStipple [
	^stipplePattern notNil
]

{ #category : #'initialize-release' }
JunOpenGL3dNurbsCurve >> initialize [
	super initialize.
	lineWidth := self defaultLineWidth.
	stippleFactor := 1.
	stipplePattern := nil
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve >> kindName [
	^#NurbsCurve
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> knotVector [
	"Answer an Array that contains my knots."

	^knotVector
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> knotVector: anArray [ 
	knotVector := anArray
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve >> knotsToLispList [
	| collection |
	collection := OrderedCollection new: self knotVector size + 1.
	collection add: #knots.
	self knotVector do: [:p | collection add: p].
	^self defaultLispConsClass list: collection
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> lineWidth [
	^lineWidth
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> lineWidth: aNumber [ 
	lineWidth := aNumber
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve >> lineWidthToLispList [
	| list |
	self lineWidth > 1 ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #width.
	list tail: self lineWidth.
	^list
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> numberOfControlPoints [
	^controlPoints size
]

{ #category : #utilities }
JunOpenGL3dNurbsCurve >> numberOfPolygons [
	^0
]

{ #category : #utilities }
JunOpenGL3dNurbsCurve >> numberOfPolylines [
	^1
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> order [
	^knotVector size - controlPoints size.
]

{ #category : #enumerating }
JunOpenGL3dNurbsCurve >> pointsDo: aBlock [
	controlPoints do: aBlock
]

{ #category : #copying }
JunOpenGL3dNurbsCurve >> postCopy [
	super postCopy.
	controlPoints := controlPoints copy.
	weights := weights copy.
	knotVector := knotVector copy
]

{ #category : #rendering }
JunOpenGL3dNurbsCurve >> renderOn: aRenderingContext [ 
	self hasPaint ifTrue: [aRenderingContext paint: self paint].
	self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
	aRenderingContext lineWidth: lineWidth.
	self hasStipple
		ifTrue: 
			[aRenderingContext lineStippleFactor: self stippleFactor pattern: self stipplePattern.
			aRenderingContext enableLineStipple].
	aRenderingContext displayNurbsCurve: self.
	self hasStipple ifTrue: [aRenderingContext disableLineStipple]
]

{ #category : #converting }
JunOpenGL3dNurbsCurve >> reversed [
	^self class
		controlPoints: self controlPoints reverse
		weights: self weights reverse
		knotVector: self knotVector reverse
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> stippleFactor [
	stippleFactor isNil ifTrue: [stippleFactor := 1].
	^stippleFactor
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> stippleFactor: anInteger [ 
	stippleFactor := anInteger
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> stipplePattern [
	^stipplePattern
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> stipplePattern: anInteger [ 
	stipplePattern := anInteger
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve >> stippleToLispList [
	| list |
	self hasStipple ifFalse: [^self lispNil].
	list := self lispCons.
	list head: #stipple.
	list add: self stippleFactor.
	list add: self stipplePattern.
	^list
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve >> textureToLispList [
	^self shouldNotImplement
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve >> toLispList [
	| list |
	list := self lispCons.
	list head: self kindName.
	self hasProperties ifTrue: [list add: self propertiesToLispList].
	self hasColor ifTrue: [list add: self colorToLispList].
	self lineWidth > 1 ifTrue: [list add: self lineWidthToLispList].
	self hasStipple ifTrue: [list add: self stippleToLispList].
	self hasTexture ifTrue: [list add: self textureToLispList].
	list add: self controlsToLispList.
	list add: self weightsToLispList.
	list add: self knotsToLispList.
	^list
]

{ #category : #transforming }
JunOpenGL3dNurbsCurve >> transform: aJun3dTransformation [ 
	| theNurbsCurve |
	theNurbsCurve := self copy.
	1 to: theNurbsCurve numberOfControlPoints
		do: 
			[:index | 
			| point transformedPoint |
			point := theNurbsCurve controlPointAt: index.
			transformedPoint := point transform: aJun3dTransformation.
			theNurbsCurve controlPointAt: index put: transformedPoint].
	^theNurbsCurve
]

{ #category : #'vrml support' }
JunOpenGL3dNurbsCurve >> vrml10On: aStream [ 
	"not supported"
]

{ #category : #'vrml support' }
JunOpenGL3dNurbsCurve >> vrml20On: aStream [ 
	"not supported"
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> weights [
	"Answer an Array of my weight map of control points."

	^weights copy
]

{ #category : #accessing }
JunOpenGL3dNurbsCurve >> weights: anArray [ 
	weights := anArray
]

{ #category : #'lisp support' }
JunOpenGL3dNurbsCurve >> weightsToLispList [
	| masses collection |
	masses := self weights.
	collection := OrderedCollection new: masses size + 1.
	collection add: #weights.
	masses do: [:p | collection add: p].
	^self defaultLispConsClass list: collection
]

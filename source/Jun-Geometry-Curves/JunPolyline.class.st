"
Imported by VwImportClass
"
Class {
	#name : #JunPolyline,
	#superclass : #JunCurve,
	#instVars : [
		'pointCollection',
		'boundingBox',
		'segmentLengths'
	],
	#category : #'Jun-Geometry-Curves'
}

{ #category : #copyright }
JunPolyline class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'lisp support' }
JunPolyline class >> fromTable: aTable for: aPolyline [ 
	"Jun2dPolyline fromLispList: ((Jun2dPolyline examplePolyline) toLispList)."
	"Jun3dPolyline fromLispList: ((Jun3dPolyline examplePolyline) toLispList)."

	self pointsFromTable: aTable for: aPolyline.
	^aPolyline
]

{ #category : #'instance creation' }
JunPolyline class >> on: aPoint1 on: aPoint2 on: aPoint3 [ 
	^self vertexes: (Array 
				with: aPoint1
				with: aPoint2
				with: aPoint3)
]

{ #category : #'instance creation' }
JunPolyline class >> points: anArrayOfJun3dPoint [ 
	^self vertexes: anArrayOfJun3dPoint
]

{ #category : #'lisp support' }
JunPolyline class >> pointsFromTable: aTable for: aPolyline [ 
	| pointsList |
	pointsList := aTable at: #points ifAbsent: [^aPolyline].
	aPolyline setPoints: (pointsList 
				collect: [:aList | self pointClass fromLispList: aList]).
	^aPolyline
]

{ #category : #copyright }
JunPolyline class >> system [
	^'Jun'
]

{ #category : #copyright }
JunPolyline class >> version [
	^'799'
]

{ #category : #'instance creation' }
JunPolyline class >> vertexes: anArrayOfJun3dPoint [ 
	^(self new)
		setPoints: anArrayOfJun3dPoint;
		yourself
]

{ #category : #'instance creation' }
JunPolyline class >> vertices: anArrayOfJun3dPoint [ 
	^self vertexes: anArrayOfJun3dPoint
]

{ #category : #'instance creation' }
JunPolyline class >> with: aJun3dPoint1 with: aJun3dPoint2 [ 
	^self vertexes: (Array with: aJun3dPoint1 with: aJun3dPoint2)
]

{ #category : #'instance creation' }
JunPolyline class >> with: aJun3dPoint1 with: aJun3dPoint2 with: aJun3dPoint3 [ 
	^self vertexes: (Array
			with: aJun3dPoint1
			with: aJun3dPoint2
			with: aJun3dPoint3)
]

{ #category : #'instance creation' }
JunPolyline class >> with: aJun3dPoint1 with: aJun3dPoint2 with: aJun3dPoint3 with: aJun3dPoint4 [ 
	^self vertexes: (Array 
				with: aJun3dPoint1
				with: aJun3dPoint2
				with: aJun3dPoint3
				with: aJun3dPoint4)
]

{ #category : #comparing }
JunPolyline >> = aPolyline [ 
	| size |
	self class == aPolyline class ifFalse: [^false].
	(size := self points size) = aPolyline points size ifFalse: [^false].
	1 to: size
		do: [:index | (self points at: index) = (aPolyline points at: index) ifFalse: [^false]].
	^true
]

{ #category : #converting }
JunPolyline >> asArrayOfLines [
	| points lines index |
	points := self points.
	lines := Array new: self size - 1.
	index := 0.
	(1 to: points size - 1) with: (2 to: points size)
		do: 
			[:i :j | 
			| pi pj |
			pi := points at: i.
			pj := points at: j.
			index := index + 1.
			lines at: index put: (pi to: pj)].
	^lines
]

{ #category : #converting }
JunPolyline >> asArrayOfPoints [
	^Array withAll: self points
]

{ #category : #converting }
JunPolyline >> asArrayOfTriangles [
	^self subclassResponsibility
]

{ #category : #converting }
JunPolyline >> asJunOpenGL3dObject [
	| aBody |
	aBody := JunOpenGL3dPolyline vertexes: self points.
	aBody paint: self defaultColor alpha: nil.
	^aBody
]

{ #category : #converting }
JunPolyline >> asNurbsCurve [
	^JunNurbsCurve bezierControlPoints: self points asArray
]

{ #category : #converting }
JunPolyline >> asPolygon [
	^self polygonClass vertexes: self points
]

{ #category : #converting }
JunPolyline >> asPolyline [
	^self
]

{ #category : #converting }
JunPolyline >> asPolylineLength: aLength [ 
	"
	| aCollection aPolyline aLength |
	aCollection := OrderedCollection new.
	aCollection add: 1 , 1 , 0.
	aCollection add: 2 , 2 , 1.
	aCollection add: 2 , 1 , 2.
	aCollection add: 3 , 2 , 3.
	aCollection add: 3 , 1 , 4.
	aCollection add: 4 , 2 , 5.
	aPolyline := Jun3dPolyline points: aCollection.
	aPolyline asJunOpenGL3dObject showWithUnitAxes.
	aLength := JunGeometry pi * 2.
	aPolyline := aPolyline asPolylineLength: aLength.
	Transcript
		cr;
		nextPutAll: aPolyline length printString;
		nextPutAll: ' - ';
		nextPutAll: aLength printString;
		nextPutAll: ' = ';
		nextPutAll: ((aPolyline length - aLength) asRational 
					asFixedPoint: aLength defaultNumberOfDigits - 1) printString;
		flush.
	aPolyline asJunOpenGL3dObject showWithUnitAxes.
	^aPolyline
	"

	^self asPolylineLength: aLength scalingCenter: self first
]

{ #category : #converting }
JunPolyline >> asPolylineLength: aLength scalingCenter: aPoint [ 
	"
	| aCollection aPolyline aLength |
	aCollection := OrderedCollection new.
	aCollection add: 1 , 1 , 0.
	aCollection add: 2 , 2 , 1.
	aCollection add: 2 , 1 , 2.
	aCollection add: 3 , 2 , 3.
	aCollection add: 3 , 1 , 4.
	aCollection add: 4 , 2 , 5.
	aPolyline := Jun3dPolyline points: aCollection.
	aPolyline asJunOpenGL3dObject showWithUnitAxes.
	aLength := JunGeometry pi * 2.
	aPolyline := aPolyline asPolylineLength: aLength
				scalingCenter: aPolyline first.
	Transcript
		cr;
		nextPutAll: aPolyline length printString;
		nextPutAll: ' - ';
		nextPutAll: aLength printString;
		nextPutAll: ' = ';
		nextPutAll: ((aPolyline length - aLength) asRational 
					asFixedPoint: aLength defaultNumberOfDigits - 1) printString;
		flush.
	aPolyline asJunOpenGL3dObject showWithUnitAxes.
	^aPolyline
	"

	| transformation polyline scale |
	transformation := aPoint negated transformationToTranslate.
	polyline := self transform: transformation.
	scale := aLength / polyline length.
	transformation := (Jun3dPoint fromNumber: scale) transformationToScale 
				product: aPoint transformationToTranslate.
	^polyline transform: transformation
]

{ #category : #accessing }
JunPolyline >> atT: normalizedNumber [ 
	| targetLength |
	normalizedNumber <= 0 ifTrue: [^self pointAt: 1].
	normalizedNumber >= 1 ifTrue: [^self pointAt: self numberOfPoints].
	targetLength := self length * normalizedNumber.
	(1 to: self numberOfPoints - 1) with: (2 to: self numberOfPoints)
		do: 
			[:i :j | 
			| minLength maxLength |
			((minLength := segmentLengths at: i) <= targetLength 
				and: [targetLength <= (maxLength := segmentLengths at: j)]) 
					ifTrue: 
						[^((self pointAt: i) to: (self pointAt: j)) 
							atT: (targetLength - minLength) / (maxLength - minLength)]].
	self error: 'unexpected error.'
]

{ #category : #accessing }
JunPolyline >> atX: xValue [ 
	self asArrayOfLines do: 
			[:aLine | 
			(aLine from x <= xValue and: [xValue <= aLine to x]) 
				ifTrue: [^aLine atX: xValue]].
	self error: 'unexpected error.'
]

{ #category : #accessing }
JunPolyline >> atY: yValue [ 
	self asArrayOfLines do: 
			[:aLine | 
			(aLine from y <= yValue and: [yValue <= aLine to y]) 
				ifTrue: [^aLine atY: yValue]].
	self error: 'unexpected error.'
]

{ #category : #accessing }
JunPolyline >> atZ: zValue [ 
	self asArrayOfLines do: 
			[:aLine | 
			(aLine from z <= zValue and: [zValue <= aLine to z]) 
				ifTrue: [^aLine atZ: zValue]].
	self error: 'unexpected error.'
]

{ #category : #accessing }
JunPolyline >> averagePoint [
	| averagePoint |
	averagePoint := 0.
	self points do: [:p | averagePoint := averagePoint + p].
	^averagePoint / self numberOfPoints
]

{ #category : #'bounds access' }
JunPolyline >> boundingBox [
	boundingBox isNil ifTrue: [boundingBox := self preferredBoundingBox].
	^boundingBox
]

{ #category : #private }
JunPolyline >> computeSplinePoints: controlPoints [ 
	| size extras values derivatives derivs123 spline d c b a steps t p |
	size := controlPoints size.
	size < 3 
		ifTrue: 
			[^(OrderedCollection new: 2)
				addAll: controlPoints;
				yourself].
	(self size > 3 and: [self first = self last]) 
		ifTrue: 
			[extras := 2.
			values := Array new: 2 * extras + size.
			1 to: extras
				do: 
					[:i | 
					values at: i put: (self at: size - extras + i - 1).
					values at: size + extras + i put: (self at: i + 1)].
			values 
				replaceFrom: extras + 1
				to: extras + size
				with: controlPoints]
		ifFalse: 
			[extras := 0.
			values := controlPoints].
	derivatives := Array new: 3.
	1 to: 3 do: [:i | derivatives at: i put: (Array new: values size)].
	derivs123 := 
			[:data :first :second :third | 
			| n v h |
			n := data size.
			n > 2 
				ifTrue: 
					[v := Array new: n.
					v at: 1 put: 4.0d.
					h := Array new: n.
					h at: 1 put: 6.0d * (data first - ((data at: 2) * 2.0d) + (data at: 3)).
					2 to: n - 2
						do: 
							[:i | 
							v at: i put: 4.0d - (1.0d / (v at: i - 1)).
							h at: i
								put: 6.0d * ((data at: i) - ((data at: i + 1) * 2.0d) + (data at: i + 2)) 
										- ((h at: i - 1) / (v at: i - 1))].
					second at: n - 1 put: (h at: n - 2) / (v at: n - 2).
					n - 2 to: 2
						by: -1
						do: [:i | second at: i put: ((h at: i - 1) - (second at: i + 1)) / (v at: i - 1)]].
			second at: 1 put: self pointClass zero.
			second at: n put: self pointClass zero.
			1 to: n - 1
				do: 
					[:i | 
					first at: i
						put: (data at: i + 1) - (data at: i) 
								- (((second at: i) * 2.0d + (second at: i + 1)) / 6.0d).
					third at: i put: (second at: i + 1) - (second at: i)]].
	derivs123 valueWithArguments: (Array 
				with: values
				with: (derivatives at: 1)
				with: (derivatives at: 2)
				with: (derivatives at: 3)).
	extras > 0 
		ifTrue: 
			[1 to: 3
				do: 
					[:i | 
					derivatives at: i
						put: ((derivatives at: i) copyFrom: extras + 1 to: extras + size)]].
	spline := OrderedCollection new: size * 4.
	spline add: self first.
	1 to: self size - 1
		do: 
			[:k | 
			d := controlPoints at: k.
			c := (derivatives at: 1) at: k.
			b := ((derivatives at: 2) at: k) / 2.0d.
			a := ((derivatives at: 3) at: k) / 6.0d.
			steps := ((derivatives at: 2) at: k) abs 
						+ ((derivatives at: 2) at: k + 1) abs.
			steps := 4 max: (steps x + steps y) // 100.
			1 to: steps
				do: 
					[:j | 
					t := j asFloat / steps.
					p := ((a * t + b) * t + c) * t + d.
					(spline last equal: p) ifFalse: [spline add: p]].
			p := controlPoints at: k + 1.
			(spline last equal: p) ifFalse: [spline add: p]].
	^spline
]

{ #category : #comparing }
JunPolyline >> equal: aPolyline [ 
	| size |
	self class == aPolyline class ifFalse: [^false].
	(size := self points size) = aPolyline points size ifFalse: [^false].
	1 to: size
		do: 
			[:index | 
			((self points at: index) equal: (aPolyline points at: index)) 
				ifFalse: [^false]].
	^true
]

{ #category : #sewing }
JunPolyline >> findIndexOfPoints: candidatePoints from: startPoint to: endPoint interim: aBlock [ 
	| aDistance aCollection anArray |
	candidatePoints isEmpty ifTrue: [^0].
	aDistance := startPoint distance: endPoint.
	aCollection := OrderedCollection new: candidatePoints size.
	candidatePoints with: (1 to: candidatePoints size)
		do: 
			[:point :index | 
			| distance1 distance2 key value |
			distance1 := point distance: startPoint.
			distance2 := point distance: endPoint.
			key := (startPoint to: point) angleWithLine: (endPoint to: point).
			value := Array 
						with: distance1
						with: distance2
						with: index.
			aCollection add: key -> value.
			anArray := Array with: (Array 
								with: startPoint
								with: endPoint
								with: point)
						with: #pending.
			aBlock valueWithArguments: (anArray copyFrom: 1 to: aBlock numArgs)].
	aCollection := aCollection asSortedCollection.
	aCollection reverseDo: 
			[:anAssociation | 
			| angle distance1 distance2 index |
			angle := anAssociation key.
			distance1 := anAssociation value at: 1.
			distance2 := anAssociation value at: 2.
			index := anAssociation value at: 3.
			(angle > self class accuracy and: 
					[(aDistance + distance1 - distance2) abs > self class accuracy 
						and: [(aDistance + distance2 - distance1) abs > self class accuracy]]) 
				ifTrue: 
					[anArray := Array with: (Array 
										with: startPoint
										with: endPoint
										with: (candidatePoints at: index))
								with: #decided.
					aBlock valueWithArguments: (anArray copyFrom: 1 to: aBlock numArgs).
					^index]].
	^0
]

{ #category : #'initialize-release' }
JunPolyline >> initialize [
	super initialize.
	pointCollection := nil.
	boundingBox := nil.
	segmentLengths := nil
]

{ #category : #functions }
JunPolyline >> intersectingPointsWithLine: aLine [
	
	^self subclassResponsibility
]

{ #category : #functions }
JunPolyline >> intersectingPointsWithPlane: aPlane [
	
	^self subclassResponsibility
]

{ #category : #testing }
JunPolyline >> isPolyline [
	^true
]

{ #category : #accessing }
JunPolyline >> length [
	segmentLengths isNil 
		ifTrue: 
			[| collection length |
			collection := OrderedCollection new: self numberOfPoints.
			length := 0.
			(1 to: self numberOfPoints - 1) with: (2 to: self numberOfPoints)
				do: 
					[:i :j | 
					collection add: length.
					length := length + ((self pointAt: i) distance: (self pointAt: j))].
			collection add: length.
			segmentLengths := collection].
	^segmentLengths last
]

{ #category : #accessing }
JunPolyline >> numberOfPoints [
	^self size
]

{ #category : #accessing }
JunPolyline >> pointAt: anIndex [ 
	^self points at: anIndex
]

{ #category : #accessing }
JunPolyline >> points [
	pointCollection isNil ifTrue: [pointCollection := Array new].
	^pointCollection
]

{ #category : #enumerating }
JunPolyline >> pointsDo: aBlock [ 
	1 to: self numberOfPoints
		do: [:index | aBlock value: (self pointAt: index)]
]

{ #category : #accessing }
JunPolyline >> pointsSize [
	^self size
]

{ #category : #'lisp support' }
JunPolyline >> pointsToLispList [
	| list |
	list := self lispCons.
	list head: #points.
	list tail: (self class defaultLispConsClass 
				list: (self points collect: [:p | p toLispList])).
	^list
]

{ #category : #copying }
JunPolyline >> postCopy [
	pointCollection := pointCollection copy.
	boundingBox := boundingBox copy.
	segmentLengths := segmentLengths copy
]

{ #category : #'bounds access' }
JunPolyline >> preferredBoundingBox [
	^self subclassResponsibility
]

{ #category : #printing }
JunPolyline >> printOn: aStream [ 
	aStream nextPutAll: self class printString.
	aStream nextPutAll: ' ('.
	self points do: [:point | point printOn: aStream]
		separatedBy: [aStream space].
	aStream nextPutAll: ')'
]

{ #category : #converting }
JunPolyline >> reversed [
	^self class vertexes: self points reverse
]

{ #category : #private }
JunPolyline >> setPoints: collectionOfPoints [ 
	pointCollection := (collectionOfPoints 
				collect: [:p | self pointClass coerce: p]) asArray.
	boundingBox := nil.
	segmentLengths := nil
]

{ #category : #sewing }
JunPolyline >> sew: aPolyline [ 
	^self sew: aPolyline interim: [:array :symbol | nil yourself]
]

{ #category : #sewing }
JunPolyline >> sew: aPolyline interim: aBlock [ 
	| aStream startPoint endPoint anIndex anArray aPoint collectionOfPoints |
	self 
		assert: [aStream := Array new writeStream]
		do: 
			[collectionOfPoints := aPolyline points.
			(1 to: collectionOfPoints size - 1) do: 
					[:index | 
					startPoint := collectionOfPoints at: index.
					endPoint := collectionOfPoints at: index + 1.
					anIndex := self 
								findIndexOfPoints: self points
								from: startPoint
								to: endPoint
								interim: aBlock.
					anIndex > 0 
						ifTrue: 
							[aPoint := self points at: anIndex.
							aStream nextPut: (Array 
										with: startPoint
										with: endPoint
										with: aPoint)]].
			collectionOfPoints := self points.
			(1 to: collectionOfPoints size - 1) do: 
					[:index | 
					startPoint := collectionOfPoints at: index.
					endPoint := collectionOfPoints at: index + 1.
					anIndex := self 
								findIndexOfPoints: aPolyline points
								from: startPoint
								to: endPoint
								interim: aBlock.
					anIndex > 0 
						ifTrue: 
							[aPoint := aPolyline points at: anIndex.
							aStream nextPut: (Array 
										with: endPoint
										with: startPoint
										with: aPoint)]].
			anArray := aStream contents]
		ensure: [aStream close].
	^anArray
]

{ #category : #sewing }
JunPolyline >> sewWith: aPolyline [ 
	| triangleCollection |
	triangleCollection := OrderedCollection new.
	(1 to: self points size - 1) with: (2 to: self points size)
		do: 
			[:firstIndex :secondIndex | 
			| firstPoint secondPoint angleCollection |
			firstPoint := self points at: firstIndex.
			secondPoint := self points at: secondIndex.
			angleCollection := OrderedCollection new.
			aPolyline points do: 
					[:thirdPoint | 
					| firstLine secondLine anAngle |
					firstLine := firstPoint to: thirdPoint.
					secondLine := secondPoint to: thirdPoint.
					anAngle := firstLine angleWithLine: secondLine.
					angleCollection add: anAngle -> thirdPoint].
			angleCollection := angleCollection asSortedCollection: [:a1 :a2 | a1 < a2].
			angleCollection isEmpty not 
				ifTrue: 
					[| aPoint aTriangle |
					aPoint := angleCollection last value.
					aTriangle := firstPoint triangle: secondPoint and: aPoint.
					triangleCollection add: aTriangle]].
	(1 to: aPolyline points size - 1) with: (2 to: aPolyline points size)
		do: 
			[:firstIndex :secondIndex | 
			| firstPoint secondPoint angleCollection |
			firstPoint := aPolyline points at: firstIndex.
			secondPoint := aPolyline points at: secondIndex.
			angleCollection := OrderedCollection new.
			self points do: 
					[:thirdPoint | 
					| firstLine secondLine anAngle |
					firstLine := firstPoint to: thirdPoint.
					secondLine := secondPoint to: thirdPoint.
					anAngle := firstLine angleWithLine: secondLine.
					angleCollection add: anAngle -> thirdPoint].
			angleCollection := angleCollection asSortedCollection: [:a1 :a2 | a1 < a2].
			angleCollection isEmpty not 
				ifTrue: 
					[| aPoint aTriangle |
					aPoint := angleCollection last value.
					aTriangle := firstPoint triangle: aPoint and: secondPoint.
					triangleCollection add: aTriangle]].
	^triangleCollection
]

{ #category : #accessing }
JunPolyline >> size [
	^self points size
]

{ #category : #subdividing }
JunPolyline >> subdivide [
	"((Jun2dPolyline examplePolyline) subdivide) showWithArrows."

	"((Jun3dPolyline examplePolyline) subdivide) showWithArrows."

	| points vertexes polyline |
	points := self points.
	vertexes := OrderedCollection new: self size * 2 - 1.
	(1 to: points size - 1) with: (2 to: points size)
		do: 
			[:i :j | 
			| pi pj |
			pi := points at: i.
			pj := points at: j.
			vertexes add: pi.
			vertexes add: (pi to: pj) center].
	vertexes add: points last.
	polyline := self polylineClass vertexes: vertexes.
	^polyline
]

{ #category : #subdividing }
JunPolyline >> subdivideAsSpline [
	"((Jun2dPolyline examplePolyline) subdivideAsSpline) showWithUnitArrows."

	"((Jun3dPolyline examplePolyline) subdivideAsSpline) showWithUnitArrows."

	^self polylineClass vertexes: (self computeSplinePoints: self points)
]

{ #category : #subdividing }
JunPolyline >> subdivideAsSplineLevel: levelNumber [ 
	"((Jun2dPolyline examplePolyline) subdivideAsSplineLevel: 0) showWithUnitArrows."

	"((Jun2dPolyline examplePolyline) subdivideAsSplineLevel: 1) showWithUnitArrows."

	"((Jun2dPolyline examplePolyline) subdivideAsSplineLevel: 2) showWithUnitArrows."

	"((Jun3dPolyline examplePolyline) subdivideAsSplineLevel: 0) showWithUnitArrows."

	"((Jun3dPolyline examplePolyline) subdivideAsSplineLevel: 1) showWithUnitArrows."

	"((Jun3dPolyline examplePolyline) subdivideAsSplineLevel: 2) showWithUnitArrows."

	| polyline |
	polyline := self copy.
	levelNumber timesRepeat: [polyline := polyline subdivideAsSpline].
	^polyline
]

{ #category : #subdividing }
JunPolyline >> subdivideLevel: levelNumber [ 
	"((Jun2dPolyline examplePolyline) subdivideLevel: 0) showWithUnitArrows."

	"((Jun2dPolyline examplePolyline) subdivideLevel: 1) showWithUnitArrows."

	"((Jun2dPolyline examplePolyline) subdivideLevel: 2) showWithUnitArrows."

	"((Jun3dPolyline examplePolyline) subdivideLevel: 0) showWithUnitArrows."

	"((Jun3dPolyline examplePolyline) subdivideLevel: 1) showWithUnitArrows."

	"((Jun3dPolyline examplePolyline) subdivideLevel: 2) showWithUnitArrows."

	| polyline |
	polyline := self copy.
	levelNumber timesRepeat: [polyline := polyline subdivide].
	^polyline
]

{ #category : #'lisp support' }
JunPolyline >> toLispList [
	"self showLispList: ((Jun2dPolyline examplePolyline) toLispList)."
	"self showLispList: ((Jun3dPolyline examplePolyline) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self pointsToLispList.
	^list
]

{ #category : #transforming }
JunPolyline >> transform: aTransformation [ 
	^self class 
		points: (self points collect: [:p | p transform: aTransformation])
]

{ #category : #testing }
JunPolyline >> whichSideOf: aPlane [ 
	| anArray hasPlus hasMinus hasZero |
	anArray := self points collect: [:aPoint | aPoint whichSideOf: aPlane].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

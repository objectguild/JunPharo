"
Imported by VwImportClass
"
Class {
	#name : #JunPoint,
	#superclass : #JunGeometry,
	#category : #'Jun-Geometry-Basic'
}

{ #category : #coercing }
JunPoint class >> coerce: anObject [ 
	(anObject isKindOf: self)
		ifTrue: [^anObject].
	((anObject respondsTo: #x)
		and: [anObject respondsTo: #y])
		ifTrue: [^self fromPoint: anObject].
	anObject respondsToArithmetic ifTrue: [^self fromNumber: anObject].
	^self fromArray: anObject
]

{ #category : #copyright }
JunPoint class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunPoint class >> fromArray: anArray [ 
	^self subclassResponsibility
]

{ #category : #'instance creation' }
JunPoint class >> fromNumber: aNumber [ 
	^self subclassResponsibility
]

{ #category : #'instance creation' }
JunPoint class >> fromPoint: aPoint [ 
	^self subclassResponsibility
]

{ #category : #coercing }
JunPoint class >> generality [
	^self zero generality
]

{ #category : #utilities }
JunPoint class >> neighborhood24Points: aPoint [ 
	"JunPoint neighborhood24Points: Point zero."

	| aCollection |
	aCollection := OrderedCollection new: 24.
	-2 to: 2
		do: 
			[:y | 
			-2 to: 2
				do: [:x | (x = 0 and: [y = 0]) ifFalse: [aCollection add: aPoint + (x @ y)]]].
	^aCollection
]

{ #category : #utilities }
JunPoint class >> neighborhood4Points: aPoint [ 
	"JunPoint neighborhood4Points: Point zero."

	| aCollection |
	aCollection := OrderedCollection new: 4.
	aCollection add: aPoint + (1 @ 0).
	aCollection add: aPoint + (0 @ 1).
	aCollection add: aPoint + (-1 @ 0).
	aCollection add: aPoint + (0 @ -1).
	^aCollection
]

{ #category : #utilities }
JunPoint class >> neighborhood8Points: aPoint [ 
	"JunPoint neighborhood8Points: Point zero."

	| aCollection |
	aCollection := OrderedCollection new: 8.
	aCollection add: aPoint + (1 @ 0).
	aCollection add: aPoint + (1 @ 1).
	aCollection add: aPoint + (0 @ 1).
	aCollection add: aPoint + (-1 @ 1).
	aCollection add: aPoint + (-1 @ 0).
	aCollection add: aPoint + (-1 @ -1).
	aCollection add: aPoint + (0 @ -1).
	aCollection add: aPoint + (1 @ -1).
	^aCollection
]

{ #category : #utilities }
JunPoint class >> neighborhoodPoints: aPoint [ 
	"JunPoint neighborhoodPoints: Point zero."

	^self neighborhood8Points: aPoint
]

{ #category : #'instance creation' }
JunPoint class >> new [
	^self shouldNotImplement
]

{ #category : #'instance creation' }
JunPoint class >> new: size [ 
	^self shouldNotImplement
]

{ #category : #copyright }
JunPoint class >> system [
	^'Jun'
]

{ #category : #'constants access' }
JunPoint class >> unity [
	^self subclassResponsibility
]

{ #category : #copyright }
JunPoint class >> version [
	^'799'
]

{ #category : #'constants access' }
JunPoint class >> zero [
	^self subclassResponsibility
]

{ #category : #arithmetic }
JunPoint >> * aNumber [ 
	^self subclassResponsibility
]

{ #category : #arithmetic }
JunPoint >> + aNumber [ 
	^self subclassResponsibility
]

{ #category : #arithmetic }
JunPoint >> - aNumber [ 
	^self subclassResponsibility
]

{ #category : #arithmetic }
JunPoint >> / aNumber [ 
	^self subclassResponsibility
]

{ #category : #arithmetic }
JunPoint >> // aNumber [ 
	^(self / aNumber) floor
]

{ #category : #comparing }
JunPoint >> < aMagnitude [ 
	^self subclassResponsibility
]

{ #category : #comparing }
JunPoint >> <= aMagnitude [ 
	^(self > aMagnitude) not
]

{ #category : #comparing }
JunPoint >> = aValue [ 
	aValue respondsToArithmetic
		ifTrue: [^(self - aValue) isZero]
		ifFalse: [^false]
]

{ #category : #comparing }
JunPoint >> > aMagnitude [ 
	^aMagnitude < self
]

{ #category : #comparing }
JunPoint >> >= aMagnitude [ 
	^(self < aMagnitude) not
]

{ #category : #arithmetic }
JunPoint >> \\ aNumber [ 
	^self - (self // aNumber * aNumber)
]

{ #category : #arithmetic }
JunPoint >> abs [
	self negative
		ifTrue: [^self negated]
		ifFalse: [^self]
]

{ #category : #testing }
JunPoint >> accuracy: aNumber containsPoint: aJunPoint [ 
	^(self distance: (self class coerce: aJunPoint))
		< aNumber
]

{ #category : #converting }
JunPoint >> alignedBoxWithCenter: centerPoint [ 
	"(400 , 300) alignedBoxWithCenter: (400 , 300)."
	"(400 , 300 , 200) alignedBoxWithCenter: (400 , 300 , 200)."

	^self class alignedBox: self withCenter: centerPoint
]

{ #category : #converting }
JunPoint >> alignedBoxWithScreenCenter [
	"(400 , 300) alignedBoxWithScreenCenter."
	"(400 , 300 , 200) alignedBoxWithScreenCenter."

	^self class alignedBoxWithScreenCenter: self
]

{ #category : #converting }
JunPoint >> alignedRectangleWithCenter: centerPoint [ 
	"(400 , 300) alignedRectangleWithCenter: (400 , 300)."
	"(400 , 300 , 200) alignedRectangleWithCenter: (400 , 300 , 200)."

	^JunGeometry alignedBox: self asPoint rounded
		withCenter: centerPoint asPoint rounded
]

{ #category : #converting }
JunPoint >> alignedRectangleWithScreenCenter [
	"(400 , 300) alignedRectangleWithScreenCenter."
	"(400 , 300 , 200) alignedRectangleWithScreenCenter."

	^JunGeometry alignedBoxWithScreenCenter: self asPoint rounded
]

{ #category : #functions }
JunPoint >> array: secondPoint [ 
	^Array with: self with: secondPoint
]

{ #category : #functions }
JunPoint >> array: secondPoint with: thirdPoint [ 
	^Array 
		with: self
		with: secondPoint
		with: thirdPoint
]

{ #category : #functions }
JunPoint >> array: secondPoint with: thirdPoint with: forthPoint [ 
	^Array 
		with: self
		with: secondPoint
		with: thirdPoint
		with: forthPoint
]

{ #category : #converting }
JunPoint >> asArrayOfPoints [
	^Array with: self
]

{ #category : #converting }
JunPoint >> asArrays [
	^Array with: (Array with: self)
]

{ #category : #converting }
JunPoint >> asBoundingBall [
	^self boundingBallClass origin: self corner: self
]

{ #category : #converting }
JunPoint >> asBoundingBox [
	^self boundingBoxClass origin: self corner: self
]

{ #category : #converting }
JunPoint >> asJunOpenGL3dObject [
	"(1 , 1 , 1) asJunOpenGL3dObject showWithAxes."

	| aVertex |
	aVertex := JunOpenGL3dVertex point: self.
	aVertex size: 5.
	aVertex paint: self defaultColor.
	^aVertex
]

{ #category : #converting }
JunPoint >> asPoint [
	^self x @ self y
]

{ #category : #converting }
JunPoint >> asPointArrays [
	^Array with: (Array with: self asPoint)
]

{ #category : #converting }
JunPoint >> asRectangle [
	"(100 , 200 extent: 400 , 300) asRectangle."
	"(100 , 200 , 300 extent: 400 , 300 , 200) asRectangle."

	^Rectangle origin: self asPoint corner: self asPoint
]

{ #category : #comparing }
JunPoint >> between: min and: max [ 
	^self >= min and: [self <= max]
]

{ #category : #accessing }
JunPoint >> boundingBox [
	^self asBoundingBox
]

{ #category : #'truncation and round off' }
JunPoint >> ceiling [
	^self subclassResponsibility
]

{ #category : #functions }
JunPoint >> center: aPoint [ 
	| thePoint |
	thePoint := self class coerce: aPoint.
	^self + (thePoint - self / 2)
]

{ #category : #coercing }
JunPoint >> coerce: anObject [ 
	^self class coerce: anObject
]

{ #category : #testing }
JunPoint >> containsPoint: aJunPoint [
	^self accuracy: self class accuracy containsPoint: aJunPoint
]

{ #category : #functions }
JunPoint >> corner: aPoint [ 
	^self asPoint corner: aPoint asPoint
]

{ #category : #'double dispatching' }
JunPoint >> differenceFromDouble: aDouble [

	^aDouble retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> differenceFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> differenceFromFloat: aFloat [

	^aFloat retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> differenceFromFraction: aFraction [

	^aFraction retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> differenceFromInteger: anInteger [

	^anInteger retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> differenceFromPoint: aPoint [

	^aPoint retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> differenceFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #- coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> differenceFromSmallInteger: aSmallInteger [

	^self differenceFromInteger: aSmallInteger
]

{ #category : #functions }
JunPoint >> dist: aPoint [ 
	^self distance: aPoint
]

{ #category : #functions }
JunPoint >> distance: aPoint [ 
	^(self - aPoint) rho
]

{ #category : #functions }
JunPoint >> dotProduct: aPoint [ 
	^self subclassResponsibility
]

{ #category : #'double dispatching' }
JunPoint >> equalFromDouble: aDouble [

	^aDouble retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> equalFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> equalFromFloat: aFloat [

	^aFloat retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> equalFromFraction: aFraction [

	^aFraction retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> equalFromInfinitesimal: aNumber [

	^aNumber retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> equalFromInfinity: aNumber [

	^aNumber retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> equalFromInteger: anInteger [

	^anInteger retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> equalFromPoint: aPoint [

	^aPoint retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> equalFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #= coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> equalFromSomeNumber: aNumber [

	^aNumber retry: #= coercing: self
]

{ #category : #functions }
JunPoint >> extent: aPoint [ 
	^self asPoint extent: aPoint asPoint
]

{ #category : #'truncation and round off' }
JunPoint >> floor [
	^self subclassResponsibility
]

{ #category : #functions }
JunPoint >> from: aPoint [ 
	"Array 
		with: ((0 , 0 , 0) from: (1 , 1 , 1))
		with: ((0 , 0) from: (1 , 1))."

	^self lineClass from: aPoint to: self
]

{ #category : #coercing }
JunPoint >> generality [
	^self subclassResponsibility
]

{ #category : #comparing }
JunPoint >> hash [
	^self subclassResponsibility
]

{ #category : #functions }
JunPoint >> innerProduct: aPoint [ 
	^self dotProduct: aPoint
]

{ #category : #testing }
JunPoint >> isPoint [
	^true
]

{ #category : #testing }
JunPoint >> isZero [
	^self subclassResponsibility
]

{ #category : #functions }
JunPoint >> length [
	^self rho
]

{ #category : #functions }
JunPoint >> length: aNumber [ 
	| length scale |
	length := self length.
	length > self class accuracy
		ifTrue: [scale := aNumber / length]
		ifFalse: [^self].
	^self * scale
]

{ #category : #'double dispatching' }
JunPoint >> lessFromDouble: aDouble [

	^aDouble retry: #< coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> lessFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #< coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> lessFromFloat: aFloat [

	^aFloat retry: #< coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> lessFromFraction: aFraction [

	^aFraction retry: #< coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> lessFromInteger: anInteger [

	^anInteger retry: #< coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> lessFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #< coercing: self
]

{ #category : #comparing }
JunPoint >> max: aMagnitude [ 
	self > aMagnitude
		ifTrue: [^self]
		ifFalse: [^aMagnitude]
]

{ #category : #comparing }
JunPoint >> min: aMagnitude [ 
	self < aMagnitude
		ifTrue: [^self]
		ifFalse: [^aMagnitude]
]

{ #category : #arithmetic }
JunPoint >> min: minValue max: maxValue [ 
	^self subclassResponsibility
]

{ #category : #arithmetic }
JunPoint >> negated [
	^self class zero - self
]

{ #category : #testing }
JunPoint >> negative [
	^self < self class zero
]

{ #category : #functions }
JunPoint >> neighborhoodPoints [
	^self class neighborhoodPoints: self
]

{ #category : #accessing }
JunPoint >> normalUnitVector [
	^self unitVector
]

{ #category : #accessing }
JunPoint >> normalVector [
	^self
]

{ #category : #functions }
JunPoint >> outerProduct: aPoint [ 
	^self vectorProduct: aPoint
]

{ #category : #functions }
JunPoint >> plane: normalVector [ 
	"Array 
		with: ((0 , 0 , 0) plane: (1 , 0 , 0)) 
		with: ((0 , 0) plane: (1 , 0))."

	^self planeClass on: self normalVector: normalVector
]

{ #category : #functions }
JunPoint >> plane: aPoint1 and: aPoint2 [ 
	"Array 
		with: ((0 , 0 , 0) plane: (1 , 0 , 0) and: (1 , 1 , 1)) 
		with: ((0 , 0) plane: (1 , 0) and: (1 , 1))."

	^self planeClass 
		on: self
		on: aPoint1
		on: aPoint2
]

{ #category : #functions }
JunPoint >> polyline: firstPoint with: secondPoint [ 
	^self polylineClass vertexes: (Array 
				with: self
				with: firstPoint
				with: secondPoint)
]

{ #category : #functions }
JunPoint >> polyline: firstPoint with: secondPoint with: thirdPoint [ 
	^self polylineClass vertexes: (Array 
				with: self
				with: firstPoint
				with: secondPoint
				with: thirdPoint)
]

{ #category : #functions }
JunPoint >> polyline: firstPoint with: secondPoint with: thirdPoint with: forthPoint [ 
	^self polylineClass 
		vertexes: (Array with: self) , (Array 
						with: firstPoint
						with: secondPoint
						with: thirdPoint
						with: forthPoint)
]

{ #category : #testing }
JunPoint >> positive [
	^self >= self class zero
]

{ #category : #'double dispatching' }
JunPoint >> productFromDouble: aDouble [

	^aDouble retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> productFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> productFromFloat: aFloat [

	^aFloat retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> productFromFraction: aFraction [

	^aFraction retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> productFromInteger: anInteger [

	^anInteger retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> productFromPoint: aPoint [

	^aPoint retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> productFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #* coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> productFromSmallInteger: aSmallInteger [

	^self productFromInteger: aSmallInteger
]

{ #category : #arithmetic }
JunPoint >> quo: aNumber [ 
	^(self / aNumber) truncated
]

{ #category : #private }
JunPoint >> quoFromInteger: anInteger [ 
	^(anInteger / self) truncated
]

{ #category : #'double dispatching' }
JunPoint >> quotientFromDouble: aDouble [

	^aDouble retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> quotientFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> quotientFromFloat: aFloat [

	^aFloat retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> quotientFromFraction: aFraction [

	^aFraction retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> quotientFromInteger: anInteger [

	^anInteger retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> quotientFromPoint: aPoint [

	^aPoint retry: #/ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> quotientFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #/ coercing: self
]

{ #category : #functions }
JunPoint >> r [
	^self rho
]

{ #category : #arithmetic }
JunPoint >> reciprocal [
	^self class unity / self
]

{ #category : #arithmetic }
JunPoint >> rem: aNumber [ 
	^self - ((self quo: aNumber)
			* aNumber)
]

{ #category : #testing }
JunPoint >> respondsToArithmetic [
	^true
]

{ #category : #coercing }
JunPoint >> retry: aSymbol coercing: aNumber [ 
	aSymbol = #= ifTrue: [Object messageNotUnderstoodSignal handle: [:exception | ^false]
			do: [self generality = aNumber generality ifTrue: [^false]]].
	self generality < aNumber generality ifTrue: [^(aNumber coerce: self)
			perform: aSymbol with: aNumber].
	self generality > aNumber generality ifTrue: [^self perform: aSymbol with: (self coerce: aNumber)].
	^self error: 'coercion attempt failed'
]

{ #category : #'polar coordinates' }
JunPoint >> rho [
	^(self dotProduct: self) sqrt
]

{ #category : #'truncation and round off' }
JunPoint >> roundTo: aNumber [ 
	^(self / aNumber) rounded * aNumber
]

{ #category : #'truncation and round off' }
JunPoint >> rounded [
	^self subclassResponsibility
]

{ #category : #testing }
JunPoint >> sign [
	self > self class zero ifTrue: [^1].
	self < self class zero ifTrue: [^-1].
	^0
]

{ #category : #functions }
JunPoint >> squared [
	^self * self
]

{ #category : #testing }
JunPoint >> strictlyPositive [
	^self > self class zero
]

{ #category : #'double dispatching' }
JunPoint >> sumFromDouble: aDouble [

	^aDouble retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> sumFromFixedPoint: aFixedPoint [

	^aFixedPoint retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> sumFromFloat: aFloat [

	^aFloat retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> sumFromFraction: aFraction [

	^aFraction retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> sumFromInteger: anInteger [

	^anInteger retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> sumFromPoint: aPoint [

	^aPoint retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> sumFromSmallDouble: aSmallDouble [

	^aSmallDouble retry: #+ coercing: self
]

{ #category : #'double dispatching' }
JunPoint >> sumFromSmallInteger: aSmallInteger [

	^self sumFromInteger: aSmallInteger
]

{ #category : #functions }
JunPoint >> to: aPoint [ 
	"Array 
		with: ((0 , 0 , 0) to: (1 , 1 , 1))
		with: ((0 , 0) to: (1 , 1))."

	^self lineClass from: self to: aPoint
]

{ #category : #transforming }
JunPoint >> transform: aTransformation [ 
	^aTransformation applyToPoint: self
]

{ #category : #transforming }
JunPoint >> transformationToAlignWith: relativePoint [ 
	^self transformationClass align: self with: relativePoint
]

{ #category : #transforming }
JunPoint >> transformationToRotate: anAngle [ 
	^self subclassResponsibility
]

{ #category : #transforming }
JunPoint >> transformationToScale [
	^self transformationClass scale: self
]

{ #category : #transforming }
JunPoint >> transformationToTranslate [
	^self transformationClass translate: self
]

{ #category : #functions }
JunPoint >> triangle: aPoint1 and: aPoint2 [ 
	"Array
		with: ((0 , 0 , 0) triangle: (1 , 0 , 0) and: (1 , 1 , 1))
		with: ((0 , 0) triangle: (1 , 0) and: (1 , 1))."

	^self triangleClass 
		on: self
		on: aPoint1
		on: aPoint2
]

{ #category : #'truncation and round off' }
JunPoint >> truncateTo: aNumber [ 
	^(self quo: aNumber)
		* aNumber
]

{ #category : #'truncation and round off' }
JunPoint >> truncated [
	^self subclassResponsibility
]

{ #category : #functions }
JunPoint >> unitVector [
	^self length: 1.0d
]

{ #category : #functions }
JunPoint >> vectorProduct: aPoint [ 
	^self subclassResponsibility
]

{ #category : #testing }
JunPoint >> whichSideOf: bisector [ 
	^self subclassResponsibility
]

{ #category : #accessing }
JunPoint >> x [
	^self subclassResponsibility
]

{ #category : #accessing }
JunPoint >> y [
	^self subclassResponsibility
]

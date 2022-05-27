"
Imported by VwImportClass
"
Class {
	#name : #Jun2dBoundingBall,
	#superclass : #JunBoundingBall,
	#category : #'Jun-Geometry-Boundaries'
}

{ #category : #copyright }
Jun2dBoundingBall class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun2dBoundingBall class >> example1 [
	"Jun2dBoundingBall example1."

	| boundingBall |
	boundingBall := Jun2dBoundingBall center: 1 , 1 radius: 2 sqrt.
	Transcript
		cr;
		show: boundingBall printString.
	Transcript
		cr;
		show: boundingBall storeString.
	Transcript
		cr;
		show: 'area: ' , boundingBall area printString.
	Transcript
		cr;
		show: 'volume: ' , boundingBall volume printString.
	(boundingBall asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5) 
		showWithAxes.
	^boundingBall
]

{ #category : #examples }
Jun2dBoundingBall class >> example2 [
	"Jun2dBoundingBall example2."

	| randomStream pointCollection boundingBall compoundObject |
	randomStream := JunRandomStream new.
	pointCollection := (1 to: 100) 
				collect: [:index | Jun2dPoint x: randomStream next y: randomStream next].
	boundingBall := Jun2dBoundingBall fromPoints: pointCollection.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (boundingBall asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		addAll: (pointCollection collect: 
					[:aPoint | 
					(JunOpenGL3dVertex point: aPoint , 0)
						size: 4;
						paint: ((boundingBall touchesPoint: aPoint) 
									ifTrue: [ColorValue red]
									ifFalse: [ColorValue blue])]).
	compoundObject show.
	^boundingBall
]

{ #category : #examples }
Jun2dBoundingBall class >> example3 [
	"Jun2dBoundingBall example3."

	| firstBoundingBall secondBoundingBall mergeBoundingBall compoundObject |
	firstBoundingBall := (Jun2dBoundingBall center: 0.5 , -0.5 radius: 0) 
				expandedBy: 2.
	secondBoundingBall := (Jun2dBoundingBall center: -0.5 , 0.5 radius: 0) 
				expandedBy: 2.
	mergeBoundingBall := firstBoundingBall merge: secondBoundingBall.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (firstBoundingBall asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (secondBoundingBall asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: (mergeBoundingBall asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	^compoundObject
]

{ #category : #examples }
Jun2dBoundingBall class >> example4 [
	"Jun2dBoundingBall example4."

	| firstBoundingBall secondBoundingBall intersectBoundingBall compoundObject |
	firstBoundingBall := (Jun2dBoundingBall center: 0.5 , -0.5 radius: 0) 
				expandedBy: 2.
	secondBoundingBall := (Jun2dBoundingBall center: -0.5 , 0.5 radius: 0) 
				expandedBy: 2.
	intersectBoundingBall := firstBoundingBall intersect: secondBoundingBall.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (firstBoundingBall asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (secondBoundingBall asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: (intersectBoundingBall asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	^compoundObject
]

{ #category : #examples }
Jun2dBoundingBall class >> example5 [
	"Jun2dBoundingBall example5."

	| boundingBall outerBoundingBox innerBoundingBox compoundObject |
	boundingBall := (Jun2dBoundingBall center: 0.5 , -0.5 radius: 0) 
				expandedBy: 2.
	outerBoundingBox := boundingBall outerBoundingBox.
	innerBoundingBox := boundingBall innerBoundingBox.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (boundingBall asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (outerBoundingBox asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: (innerBoundingBox asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	^compoundObject
]

{ #category : #examples }
Jun2dBoundingBall class >> example6 [
	"Jun2dBoundingBall example6."

	| boundingBall detailedBoundingBoxes detailedBoundingBalls compoundObject |
	boundingBall := (Jun2dBoundingBall center: 0.5 , -0.5 radius: 0) 
				expandedBy: 2.
	detailedBoundingBoxes := boundingBall detailedBoundingBoxes.
	detailedBoundingBalls := boundingBall detailedBoundingBalls.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (boundingBall asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (detailedBoundingBoxes asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: (detailedBoundingBalls asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	^compoundObject
]

{ #category : #'instance creation' }
Jun2dBoundingBall class >> fromPoints: pointCollection [ 
	| x y centerPoint maxDistance aDistance |
	pointCollection isEmpty ifTrue: [^self new].
	x := 0.
	y := 0.
	pointCollection do: 
			[:aPoint | 
			x := x + aPoint x.
			y := y + aPoint y].
	centerPoint := x / pointCollection size , (y / pointCollection size).
	maxDistance := 0.
	pointCollection do: 
			[:aPoint | 
			aDistance := centerPoint distance: aPoint.
			aDistance > maxDistance ifTrue: [maxDistance := aDistance]].
	^self center: centerPoint radius: maxDistance
]

{ #category : #copyright }
Jun2dBoundingBall class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun2dBoundingBall class >> version [
	^'799'
]

{ #category : #accessing }
Jun2dBoundingBall >> area [
	^Double pi * (self radius ** 2)
]

{ #category : #converting }
Jun2dBoundingBall >> asJunOpenGL3dObject [
	"((1 , 1) ball: 1) asJunOpenGL3dObject showWithAxes."

	| compoundObject aBall |
	compoundObject := JunOpenGL3dCompoundObject new.
	aBall := (JunOpenGL3dObject 
				pieFrom: 0
				to: 360
				by: 10
				radius: self radius) translatedBy: self center.
	compoundObject add: aBall reversed.
	compoundObject add: aBall.
	compoundObject 
		objectsDo: [:each | each paint: self defaultColor alpha: self defaultAlpha].
	^compoundObject
]

{ #category : #accessing }
Jun2dBoundingBall >> depth [
	^self shouldNotImplement
]

{ #category : #accessing }
Jun2dBoundingBall >> innerBoundingBox [
	^(self boundingBoxClass origin: self center extent: self pointClass zero) 
		expandedBy: self radius sqrt
]

{ #category : #testing }
Jun2dBoundingBall >> is2d [
	^true
]

{ #category : #accessing }
Jun2dBoundingBall >> octaBoundingBalls [
	^self shouldNotImplement
]

{ #category : #accessing }
Jun2dBoundingBall >> octaBoundingBoxes [
	^self shouldNotImplement
]

{ #category : #accessing }
Jun2dBoundingBall >> tetraBoundingBalls [
	| boundingBalls |
	boundingBalls := self boundingBallsClass new.
	boundingBalls addAll: self boundingBox tetraBoundingBalls.
	^boundingBalls
]

{ #category : #accessing }
Jun2dBoundingBall >> tetraBoundingBoxes [
	| boundingBoxes |
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes addAll: self boundingBox tetraBoundingBoxes.
	^boundingBoxes
]

{ #category : #testing }
Jun2dBoundingBall >> whichSideOf: aLine [ 
	^(self circleClass center: self center radius: self radius) 
		whichSideOf: aLine
]

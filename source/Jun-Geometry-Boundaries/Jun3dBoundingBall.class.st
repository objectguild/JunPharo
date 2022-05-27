"
Imported by VwImportClass
"
Class {
	#name : #Jun3dBoundingBall,
	#superclass : #JunBoundingBall,
	#category : #'Jun-Geometry-Boundaries'
}

{ #category : #copyright }
Jun3dBoundingBall class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dBoundingBall class >> example1 [
	"Jun3dBoundingBall example1."

	| boundingBall |
	boundingBall := Jun3dBoundingBall center: 1 , 1 , 1 radius: 2 sqrt.
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
Jun3dBoundingBall class >> example2 [
	"Jun3dBoundingBall example2."

	| randomStream pointCollection boundingBall compoundObject |
	randomStream := JunRandomStream new.
	pointCollection := (1 to: 100) collect: 
					[:index | 
					Jun3dPoint 
						x: randomStream next
						y: randomStream next
						z: randomStream next].
	boundingBall := Jun3dBoundingBall fromPoints: pointCollection.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (boundingBall asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		addAll: (pointCollection collect: 
					[:aPoint | 
					(JunOpenGL3dVertex point: aPoint)
						size: 4;
						paint: ((boundingBall touchesPoint: aPoint) 
									ifTrue: [ColorValue red]
									ifFalse: [ColorValue blue])]).
	compoundObject show.
	^boundingBall
]

{ #category : #examples }
Jun3dBoundingBall class >> example3 [
	"Jun3dBoundingBall example3."

	| firstBoundingBall secondBoundingBall mergeBoundingBall compoundObject |
	firstBoundingBall := (Jun3dBoundingBall center: 0.5 , -0.5 , 0 radius: 0) 
				expandedBy: 2.
	secondBoundingBall := (Jun3dBoundingBall center: -0.5 , 0.5 , -0 radius: 0) 
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
Jun3dBoundingBall class >> example4 [
	"Jun3dBoundingBall example4."

	| firstBoundingBall secondBoundingBall intersectBoundingBall compoundObject |
	firstBoundingBall := (Jun3dBoundingBall center: 0.5 , -0.5 , 0 radius: 0) 
				expandedBy: 2.
	secondBoundingBall := (Jun3dBoundingBall center: -0.5 , 0.5 , -0 radius: 0) 
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
Jun3dBoundingBall class >> example5 [
	"Jun3dBoundingBall example5."

	| boundingBall outerBoundingBox innerBoundingBox compoundObject |
	boundingBall := (Jun3dBoundingBall center: 0.5 , -0.5 , 0 radius: 0) 
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
Jun3dBoundingBall class >> example6 [
	"Jun3dBoundingBall example6."

	| boundingBall detailedBoundingBoxes detailedBoundingBalls compoundObject |
	boundingBall := (Jun3dBoundingBall center: 0.5 , -0.5 , 0 radius: 0) 
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
Jun3dBoundingBall class >> fromPoints: pointCollection [ 
	| x y z centerPoint maxDistance aDistance |
	pointCollection isEmpty ifTrue: [^self new].
	x := 0.
	y := 0.
	z := 0.
	pointCollection do: 
			[:aPoint | 
			x := x + aPoint x.
			y := y + aPoint y.
			z := z + aPoint z].
	centerPoint := x / pointCollection size 
				, (y / pointCollection size) 
				, (z / pointCollection size).
	maxDistance := 0.
	pointCollection do: 
			[:aPoint | 
			aDistance := centerPoint distance: aPoint.
			aDistance > maxDistance ifTrue: [maxDistance := aDistance]].
	^self center: centerPoint radius: maxDistance
]

{ #category : #copyright }
Jun3dBoundingBall class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun3dBoundingBall class >> version [
	^'799'
]

{ #category : #accessing }
Jun3dBoundingBall >> area [
	^4 * Double pi * (self radius ** 2)
]

{ #category : #converting }
Jun3dBoundingBall >> asJunOpenGL3dObject [
	"((1 , 1 , 1) ball: 1) asJunOpenGL3dObject showWithAxes."

	| aBall |
	aBall := JunOpenGL3dObject 
				ball: 3
				radius: self radius
				center: self center.
	aBall 
		objectsDo: [:each | each paint: self defaultColor alpha: self defaultAlpha].
	^aBall
]

{ #category : #accessing }
Jun3dBoundingBall >> depth [
	^self boundingBox depth
]

{ #category : #accessing }
Jun3dBoundingBall >> innerBoundingBox [
	^(self boundingBoxClass origin: self center extent: self pointClass zero) 
		expandedBy: self radius sqrt sqrt
]

{ #category : #testing }
Jun3dBoundingBall >> is3d [
	^true
]

{ #category : #accessing }
Jun3dBoundingBall >> octaBoundingBalls [
	| boundingBalls |
	boundingBalls := self boundingBallsClass new.
	boundingBalls addAll: self boundingBox octaBoundingBalls.
	^boundingBalls
]

{ #category : #accessing }
Jun3dBoundingBall >> octaBoundingBoxes [
	| boundingBoxes |
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes addAll: self boundingBox octaBoundingBoxes.
	^boundingBoxes
]

{ #category : #accessing }
Jun3dBoundingBall >> tetraBoundingBalls [
	^self shouldNotImplement
]

{ #category : #accessing }
Jun3dBoundingBall >> tetraBoundingBoxes [
	^self shouldNotImplement
]

{ #category : #accessing }
Jun3dBoundingBall >> volume [
	^4 * Double pi * (self radius ** 3) / 3
]

{ #category : #testing }
Jun3dBoundingBall >> whichSideOf: aPlane [ 
	^(self sphereClass center: self center radius: self radius) 
		whichSideOf: aPlane
]

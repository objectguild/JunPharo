"
Imported by VwImportClass
"
Class {
	#name : #Jun2dBoundingBox,
	#superclass : #JunBoundingBox,
	#category : #'Jun-Geometry-Boundaries'
}

{ #category : #copyright }
Jun2dBoundingBox class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun2dBoundingBox class >> example1 [
	"Jun2dBoundingBox example1."

	| boundingBox |
	boundingBox := Jun2dBoundingBox origin: 0 , 0 corner: 2 , 2.
	Transcript
		cr;
		show: boundingBox printString.
	Transcript
		cr;
		show: boundingBox storeString.
	Transcript
		cr;
		show: 'area: ' , boundingBox area printString.
	Transcript
		cr;
		show: 'volume: ' , boundingBox volume printString.
	(boundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5) 
		showWithAxes.
	^boundingBox
]

{ #category : #examples }
Jun2dBoundingBox class >> example2 [
	"Jun2dBoundingBox example2."

	| randomStream pointCollection boundingBox compoundObject |
	randomStream := JunRandomStream new.
	pointCollection := (1 to: 100) 
				collect: [:index | Jun2dPoint x: randomStream next y: randomStream next].
	boundingBox := Jun2dBoundingBox fromPoints: pointCollection.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (boundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		addAll: (pointCollection collect: 
					[:aPoint | 
					(JunOpenGL3dVertex point: aPoint , 0)
						size: 4;
						paint: ((boundingBox touchesPoint: aPoint) 
									ifTrue: [ColorValue red]
									ifFalse: [ColorValue blue])]).
	compoundObject show.
	^boundingBox
]

{ #category : #examples }
Jun2dBoundingBox class >> example3 [
	"Jun2dBoundingBox example3."

	| firstBoundingBox secondBoundingBox compoundObject mergeBoundingBox |
	firstBoundingBox := (Jun2dBoundingBox origin: 0.5 , -0.5 extent: 0 , 0) 
				expandedBy: 2.
	secondBoundingBox := (Jun2dBoundingBox origin: -0.5 , 0.5 extent: 0 , 0) 
				expandedBy: 2.
	mergeBoundingBox := firstBoundingBox merge: secondBoundingBox.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (firstBoundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (secondBoundingBox asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: (mergeBoundingBox asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	^compoundObject
]

{ #category : #examples }
Jun2dBoundingBox class >> example4 [
	"Jun2dBoundingBox example4."

	| firstBoundingBox secondBoundingBox compoundObject intersectBoundingBox |
	firstBoundingBox := (Jun2dBoundingBox origin: 0.5 , -0.5 extent: 0 , 0) 
				expandedBy: 2.
	secondBoundingBox := (Jun2dBoundingBox origin: -0.5 , 0.5 extent: 0 , 0) 
				expandedBy: 2.
	intersectBoundingBox := firstBoundingBox intersect: secondBoundingBox.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (firstBoundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (secondBoundingBox asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: (intersectBoundingBox asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	^compoundObject
]

{ #category : #examples }
Jun2dBoundingBox class >> example5 [
	"Jun2dBoundingBox example5."

	| boundingBox outerBoundingBall innerBoundingBall compoundObject |
	boundingBox := (Jun2dBoundingBox origin: 0.5 , -0.5 extent: 0 , 0) 
				expandedBy: 2 , 1.5.
	outerBoundingBall := boundingBox outerBoundingBall.
	innerBoundingBall := boundingBox innerBoundingBall.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (boundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (outerBoundingBall asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: (innerBoundingBall asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	^compoundObject
]

{ #category : #examples }
Jun2dBoundingBox class >> example6 [
	"Jun2dBoundingBox example6."

	| boundingBox detailedBoundingBoxes detailedBoundingBalls compoundObject |
	boundingBox := (Jun2dBoundingBox origin: 0.5 , -0.5 extent: 0 , 0) 
				expandedBy: 2 , 1.5.
	detailedBoundingBoxes := boundingBox detailedBoundingBoxes.
	detailedBoundingBalls := boundingBox detailedBoundingBalls.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (boundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
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

{ #category : #examples }
Jun2dBoundingBox class >> example7 [
	"Jun2dBoundingBox example7."

	| firstBoundingBox secondBoundingBox boundingBoxesOutside compoundObject |
	firstBoundingBox := (Jun2dBoundingBox origin: 0.5 , -0.5 extent: 0 , 0) 
				expandedBy: 2 , 1.5.
	secondBoundingBox := firstBoundingBox translatedBy: 1 , 1.
	boundingBoxesOutside := firstBoundingBox boxesOutside: secondBoundingBox.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (firstBoundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (secondBoundingBox asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: ((boundingBoxesOutside asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5) translatedBy: 0 , 0 , 1).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	secondBoundingBox := firstBoundingBox insetBy: 1 , 1.
	boundingBoxesOutside := firstBoundingBox boxesOutside: secondBoundingBox.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (firstBoundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (secondBoundingBox asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: ((boundingBoxesOutside asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5) translatedBy: 0 , 0 , 1).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	secondBoundingBox := (firstBoundingBox insetBy: 1 , 1) translatedBy: 1 , 0.
	boundingBoxesOutside := firstBoundingBox boxesOutside: secondBoundingBox.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (firstBoundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (secondBoundingBox asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: ((boundingBoxesOutside asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5) translatedBy: 0 , 0 , 1).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	^compoundObject
]

{ #category : #copyright }
Jun2dBoundingBox class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun2dBoundingBox class >> version [
	^'799'
]

{ #category : #accessing }
Jun2dBoundingBox >> area [
	^self width * self height
]

{ #category : #converting }
Jun2dBoundingBox >> asArrayOfLines [
	"((0,0) box: (1,1)) asArrayOfTriangles."

	| anArray |
	self 
		assert: [(Array new: 4) writeStream]
		do: 
			[:aStream | 
			aStream 
				nextPut: (self origin x , self origin y to: self corner x , self origin y).
			aStream 
				nextPut: (self corner x , self origin y to: self corner x , self corner y).
			aStream 
				nextPut: (self corner x , self corner y to: self origin x , self corner y).
			aStream 
				nextPut: (self origin x , self corner y to: self origin x , self origin y).
			anArray := aStream contents]
		ensure: [:aStream | aStream close].
	^anArray
]

{ #category : #converting }
Jun2dBoundingBox >> asArrayOfPlanes [
	"| planes compound |
	planes := Jun2dBoundingBox unity asArrayOfPlanes.
	compound := JunOpenGL3dCompoundObject new.
	planes do: 
			[:plane | 
			compound 
				add: ((JunOpenGL3dPolygon vertexes: (Array 
								with: plane p1
								with: plane p2
								with: plane p3))
						paint: ColorValue red;
						yourself)].
	compound show.
	^planes"

	| originPoint cornerPoint planeClass |
	originPoint := self origin.
	cornerPoint := self corner.
	planeClass := self planeClass.
	^(Array new: 1)
		at: 1
			put: (planeClass 
					on: originPoint x , originPoint y , 0
					on: cornerPoint x , originPoint y , 0
					on: originPoint x , cornerPoint y , 0);
		yourself
]

{ #category : #converting }
Jun2dBoundingBox >> asArrayOfTriangles [
	"| triangles compound |
	triangles := Jun2dBoundingBox unity asArrayOfTriangles.
	compound := JunOpenGL3dCompoundObject new.
	triangles do: 
			[:triangle | 
			compound 
				add: ((JunOpenGL3dPolygon vertexes: (Array 
								with: triangle p1 , 0
								with: triangle p2 , 0
								with: triangle p3 , 0))
						paint: ColorValue red;
						yourself)].
	compound show.
	^triangles"

	| originPoint cornerPoint triangleClass |
	originPoint := self origin.
	cornerPoint := self corner.
	triangleClass := self triangleClass.
	^Array with: (triangleClass 
				on: originPoint x , originPoint y
				on: cornerPoint x , originPoint y
				on: originPoint x , cornerPoint y)
		with: (triangleClass 
				on: cornerPoint x , cornerPoint y
				on: originPoint x , cornerPoint y
				on: cornerPoint x , originPoint y)
]

{ #category : #converting }
Jun2dBoundingBox >> asJunOpenGL3dObject [
	"((1 , 1) extent: (1 , 1)) asJunOpenGL3dObject showWithAxes."

	| compoundObject aPolygon |
	compoundObject := JunOpenGL3dCompoundObject new.
	aPolygon := JunOpenGL3dPolygon vertexes: (Array 
						with: self origin , 0
						with: self corner x , self origin y , 0
						with: self corner , 0
						with: self origin x , self corner y , 0).
	aPolygon paint: self defaultColor alpha: self defaultAlpha.
	compoundObject add: aPolygon reversed.
	compoundObject add: aPolygon.
	^compoundObject
]

{ #category : #converting }
Jun2dBoundingBox >> asPointArray [
	^Array 
		with: self origin
		with: self corner x , self origin y
		with: self corner
		with: self origin x , self corner y
]

{ #category : #functions }
Jun2dBoundingBox >> boxesOutside: boundingBox [ 
	| boxesOutside aBox yOrigin yCorner |
	boxesOutside := self boundingBoxesClass new.
	(self intersects: boundingBox) 
		ifTrue: 
			[boundingBox origin y > self origin y 
				ifTrue: 
					[aBox := self origin 
								corner: self corner x , (yOrigin := boundingBox origin y).
					boxesOutside add: aBox]
				ifFalse: [yOrigin := self origin y].
			boundingBox corner y < self corner y 
				ifTrue: 
					[aBox := self origin x , (yCorner := boundingBox corner y) 
								corner: self corner.
					boxesOutside add: aBox]
				ifFalse: [yCorner := self corner y].
			boundingBox origin x > self origin x 
				ifTrue: 
					[aBox := self origin x , yOrigin corner: boundingBox origin x , yCorner.
					boxesOutside add: aBox].
			boundingBox corner x < self corner x 
				ifTrue: 
					[aBox := boundingBox corner x , yOrigin corner: self corner x , yCorner.
					boxesOutside add: aBox]]
		ifFalse: 
			[aBox := self copy.
			boxesOutside add: aBox].
	^boxesOutside
]

{ #category : #accessing }
Jun2dBoundingBox >> depth [
	^self shouldNotImplement
]

{ #category : #accessing }
Jun2dBoundingBox >> innerBoundingBall [
	| centerPoint |
	centerPoint := self center.
	^self boundingBallClass center: centerPoint
		radius: (self width min: self height) / 2
]

{ #category : #functions }
Jun2dBoundingBox >> intersectingPointsWithLine: aLine [ 
	| theLine p1 p2 p3 p4 lineCollectionOfRectangle intersectingPointCollection aStream |
	theLine := Jun2dLine from: aLine first x , aLine first y to: aLine last x , aLine last y.
	p1 := self origin.
	p2 := self origin x , self corner y.
	p3 := self corner.
	p4 := self corner x , self origin y.
	lineCollectionOfRectangle := OrderedCollection new.
	lineCollectionOfRectangle add: (Jun2dLine from: p1 to: p2).
	lineCollectionOfRectangle add: (Jun2dLine from: p2 to: p3).
	lineCollectionOfRectangle add: (Jun2dLine from: p3 to: p4).
	lineCollectionOfRectangle add: (Jun2dLine from: p4 to: p1).
	intersectingPointCollection := Set new.
	lineCollectionOfRectangle do: [:eachLine | (eachLine isParallelWithLine: theLine)
			ifTrue: 
				[| distance |
				distance := eachLine distanceFromPoint: theLine first.
				distance abs < JunGeometry accuracy
					ifTrue: 
						[intersectingPointCollection add: eachLine first.
						intersectingPointCollection add: eachLine last]]
			ifFalse: 
				[| intersectingPoint |
				intersectingPoint := eachLine intersectingPointWithLine: theLine.
				intersectingPoint notNil ifTrue: [intersectingPointCollection add: intersectingPoint]]].
	aStream := (Array new: intersectingPointCollection size) writeStream.
	intersectingPointCollection do: [:eachPoint | lineCollectionOfRectangle do: [:eachLine | (eachLine lineSegmentContainsPoint: eachPoint)
				ifTrue: [aStream nextPut: eachPoint]]].
	intersectingPointCollection := aStream contents.
	^intersectingPointCollection
]

{ #category : #testing }
Jun2dBoundingBox >> is2d [
	^true
]

{ #category : #accessing }
Jun2dBoundingBox >> maxLength [
	^self width max: self height
]

{ #category : #accessing }
Jun2dBoundingBox >> minLength [
	^self width min: self height
]

{ #category : #accessing }
Jun2dBoundingBox >> octaBoundingBalls [
	^self shouldNotImplement
]

{ #category : #accessing }
Jun2dBoundingBox >> octaBoundingBoxes [
	^self shouldNotImplement
]

{ #category : #accessing }
Jun2dBoundingBox >> p1 [
	^self origin x , self origin y
]

{ #category : #accessing }
Jun2dBoundingBox >> p2 [
	^self corner x , self origin y
]

{ #category : #accessing }
Jun2dBoundingBox >> p3 [
	^self corner x , self corner y
]

{ #category : #accessing }
Jun2dBoundingBox >> p4 [
	^self origin x , self corner y
]

{ #category : #accessing }
Jun2dBoundingBox >> pp1 [
	"(0 , 0 box: 1 , 1) pp1."

	"(JunOpenGL3dCompoundObject with: (JunOpenGL3dPolygon 
				vertexes: ((0 , 0 box: 1 , 1) pp1 collect: [:p | p , 0])
				paint: ColorValue pink))
		add: JunOpenGL3dObject xyUnitArrows;
		show."

	^Array 
		with: self p1
		with: self p2
		with: self p3
		with: self p4
]

{ #category : #accessing }
Jun2dBoundingBox >> pps [
	"(0 , 0 box: 1 , 1) pps."

	"(JunOpenGL3dCompoundObject 
		components: ((0 , 0 box: 1 , 1) pps collect: 
					[:points | 
					JunOpenGL3dPolygon vertexes: (points collect: [:p | p , 0])
						paint: ColorValue pink]))
		add: JunOpenGL3dObject xyUnitArrows;
		show."

	^Array with: self pp1
]

{ #category : #subdividing }
Jun2dBoundingBox >> subdivide [
	"(((0 , 0 box: 1 , 1) subdivide) showWithUnitArrows) wireframePresentation."

	^self subdivide4
]

{ #category : #subdividing }
Jun2dBoundingBox >> subdivide2 [
	"(((0 , 0 box: 1 , 1) subdivide2) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 box: 1 , 0.9) subdivide2) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 box: 0.9 , 1) subdivide2) showWithUnitArrows) wireframePresentation."

	| originPoint cornerPoint centerPoint boundingBoxArray boundingBoxes |
	originPoint := self origin.
	cornerPoint := self corner.
	centerPoint := self center.
	boundingBoxArray := Array new: 2.
	self height > self width 
		ifTrue: 
			[boundingBoxArray at: 1
				put: (originPoint x , originPoint y box: cornerPoint x , centerPoint y).
			boundingBoxArray at: 2
				put: (originPoint x , centerPoint y box: cornerPoint x , cornerPoint y)]
		ifFalse: 
			[boundingBoxArray at: 1
				put: (originPoint x , originPoint y box: centerPoint x , cornerPoint y).
			boundingBoxArray at: 2
				put: (centerPoint x , originPoint y box: cornerPoint x , cornerPoint y)].
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes boundingBoxes: boundingBoxArray.
	^boundingBoxes
]

{ #category : #subdividing }
Jun2dBoundingBox >> subdivide4 [
	"(((0 , 0 box: 1 , 1) subdivide4) showWithUnitArrows) wireframePresentation."

	| originPoint cornerPoint centerPoint boundingBoxArray boundingBoxes |
	originPoint := self origin.
	cornerPoint := self corner.
	centerPoint := self center.
	boundingBoxArray := Array new: 4.
	boundingBoxArray at: 1
		put: (originPoint x , originPoint y box: centerPoint).
	boundingBoxArray at: 2
		put: (cornerPoint x , originPoint y box: centerPoint).
	boundingBoxArray at: 3
		put: (originPoint x , cornerPoint y box: centerPoint).
	boundingBoxArray at: 4
		put: (cornerPoint x , cornerPoint y box: centerPoint).
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes boundingBoxes: boundingBoxArray.
	^boundingBoxes
]

{ #category : #accessing }
Jun2dBoundingBox >> tetraBoundingBalls [
	| boundingBalls |
	boundingBalls := self boundingBallsClass new.
	self tetraBoundingBoxes 
		do: [:boundingBox | boundingBalls add: boundingBox outerBoundingBall].
	^boundingBalls
]

{ #category : #accessing }
Jun2dBoundingBox >> tetraBoundingBoxes [
	| boundingBoxes boundingBox x y |
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes 
		add: (boundingBox := self boundingBoxClass origin: self origin
						corner: self center).
	boundingBoxes add: (boundingBox translatedBy: (x := self width / 2) , 0).
	boundingBoxes add: (boundingBox translatedBy: x , (y := self height / 2)).
	boundingBoxes add: (boundingBox translatedBy: 0 , y).
	^boundingBoxes
]

{ #category : #testing }
Jun2dBoundingBox >> touchesPoint: aPoint [ 
	^(((self isEqualNumber: self origin x to: aPoint x) 
		or: [self isEqualNumber: self corner x to: aPoint x]) 
			and: [self origin y <= aPoint y and: [aPoint y <= self corner y]]) or: 
				[((self isEqualNumber: self origin y to: aPoint y) 
					or: [self isEqualNumber: self corner y to: aPoint y]) 
						and: [self origin x <= aPoint x and: [aPoint x <= self corner x]]]
]

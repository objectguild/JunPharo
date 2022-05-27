"
Imported by VwImportClass
"
Class {
	#name : #Jun3dBoundingBox,
	#superclass : #JunBoundingBox,
	#category : #'Jun-Geometry-Boundaries'
}

{ #category : #copyright }
Jun3dBoundingBox class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dBoundingBox class >> example1 [
	"Jun3dBoundingBox example1."

	| boundingBox |
	boundingBox := Jun3dBoundingBox origin: 0 , 0 , 0 corner: 2 , 2 , 2.
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
Jun3dBoundingBox class >> example2 [
	"Jun3dBoundingBox example2."

	| randomStream pointCollection boundingBox compoundObject |
	randomStream := JunRandomStream new.
	pointCollection := (1 to: 100) collect: 
					[:index | 
					Jun3dPoint 
						x: randomStream next
						y: randomStream next
						z: randomStream next].
	boundingBox := Jun3dBoundingBox fromPoints: pointCollection.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (boundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		addAll: (pointCollection collect: 
					[:aPoint | 
					(JunOpenGL3dVertex point: aPoint)
						size: 4;
						paint: ((boundingBox touchesPoint: aPoint) 
									ifTrue: [ColorValue red]
									ifFalse: [ColorValue blue])]).
	compoundObject show.
	^boundingBox
]

{ #category : #examples }
Jun3dBoundingBox class >> example3 [
	"Jun3dBoundingBox example3."

	| firstBoundingBox secondBoundingBox compoundObject mergeBoundingBox |
	firstBoundingBox := (Jun3dBoundingBox origin: 0.5 , -0.5 , 0
				extent: 0 , 0 , 0) expandedBy: 2.
	secondBoundingBox := (Jun3dBoundingBox origin: -0.5 , 0.5 , -0
				extent: 0 , 0 , 0) expandedBy: 2.
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
Jun3dBoundingBox class >> example4 [
	"Jun3dBoundingBox example4."

	| firstBoundingBox secondBoundingBox compoundObject intersectBoundingBox |
	firstBoundingBox := (Jun3dBoundingBox origin: 0.5 , -0.5 , 0
				extent: 0 , 0 , 0) expandedBy: 2.
	secondBoundingBox := (Jun3dBoundingBox origin: -0.5 , 0.5 , -0
				extent: 0 , 0 , 0) expandedBy: 2.
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
Jun3dBoundingBox class >> example5 [
	"Jun3dBoundingBox example5."

	| boundingBox outerBoundingBall innerBoundingBall compoundObject |
	boundingBox := (Jun3dBoundingBox origin: 0.5 , -0.5 , 0 extent: 0 , 0 , 0) 
				expandedBy: 2 , 1.5 , 1.
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
Jun3dBoundingBox class >> example6 [
	"Jun3dBoundingBox example6."

	| boundingBox detailedBoundingBoxes detailedBoundingBalls compoundObject |
	boundingBox := (Jun3dBoundingBox origin: 0.5 , -0.5 , 0 extent: 0 , 0 , 0) 
				expandedBy: 2 , 1.5 , 1.
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
Jun3dBoundingBox class >> example7 [
	"Jun3dBoundingBox example7."

	| firstBoundingBox secondBoundingBox boundingBoxesOutside compoundObject |
	firstBoundingBox := (Jun3dBoundingBox origin: 0.5 , -0.5 , 0
				extent: 0 , 0 , 0) expandedBy: 2 , 1.5 , 1.
	secondBoundingBox := (firstBoundingBox expandedBy: 0 , 0 , 1) 
				translatedBy: 1 , 1 , 0.
	boundingBoxesOutside := firstBoundingBox boxesOutside: secondBoundingBox.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (firstBoundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (secondBoundingBox asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: ((boundingBoxesOutside asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5) translatedBy: 0 , 0 , 4).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	secondBoundingBox := firstBoundingBox translatedBy: 1 , 1 , -1.
	boundingBoxesOutside := firstBoundingBox boxesOutside: secondBoundingBox.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (firstBoundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (secondBoundingBox asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: ((boundingBoxesOutside asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5) translatedBy: 0 , 0 , 4).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	secondBoundingBox := firstBoundingBox translatedBy: 1 , 1 , 1.
	boundingBoxesOutside := firstBoundingBox boxesOutside: secondBoundingBox.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (firstBoundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (secondBoundingBox asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: ((boundingBoxesOutside asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5) translatedBy: 0 , 0 , 4).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	secondBoundingBox := (firstBoundingBox insetBy: 0.5 , 1 , 0.5) 
				translatedBy: 0 , 0 , 0.
	boundingBoxesOutside := firstBoundingBox boxesOutside: secondBoundingBox.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject 
		add: (firstBoundingBox asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5).
	compoundObject 
		add: (secondBoundingBox asJunOpenGL3dObjectColor: ColorValue magenta
				alpha: 0.5).
	compoundObject 
		add: ((boundingBoxesOutside asJunOpenGL3dObjectColor: ColorValue yellow
				alpha: 0.5) translatedBy: 0 , 0 , 4).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show.
	^boundingBoxesOutside
]

{ #category : #copyright }
Jun3dBoundingBox class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun3dBoundingBox class >> version [
	^'799'
]

{ #category : #accessing }
Jun3dBoundingBox >> area [
	^(self width * self height + (self height * self depth) 
		+ (self depth * self width)) * 2
]

{ #category : #converting }
Jun3dBoundingBox >> asArrayOfLines [
	"((0,0,0) box: (1,1,1)) asArrayOfLines."

	| anArray |
	self 
		assert: [(Array new: 12) writeStream]
		do: 
			[:aStream | 
			| originPoint cornerPoint |
			originPoint := self origin.
			cornerPoint := self corner.
			aStream nextPut: (originPoint x , originPoint y , originPoint z 
						to: cornerPoint x , originPoint y , originPoint z).
			aStream nextPut: (cornerPoint x , originPoint y , originPoint z 
						to: cornerPoint x , cornerPoint y , originPoint z).
			aStream nextPut: (cornerPoint x , cornerPoint y , originPoint z 
						to: originPoint x , cornerPoint y , originPoint z).
			aStream nextPut: (originPoint x , cornerPoint y , originPoint z 
						to: originPoint x , originPoint y , originPoint z).
			aStream nextPut: (originPoint x , originPoint y , cornerPoint z 
						to: cornerPoint x , originPoint y , cornerPoint z).
			aStream nextPut: (cornerPoint x , originPoint y , cornerPoint z 
						to: cornerPoint x , cornerPoint y , cornerPoint z).
			aStream nextPut: (cornerPoint x , cornerPoint y , cornerPoint z 
						to: originPoint x , cornerPoint y , cornerPoint z).
			aStream nextPut: (originPoint x , cornerPoint y , cornerPoint z 
						to: originPoint x , originPoint y , cornerPoint z).
			aStream nextPut: (originPoint x , originPoint y , originPoint z 
						to: originPoint x , originPoint y , cornerPoint z).
			aStream nextPut: (cornerPoint x , cornerPoint y , originPoint z 
						to: cornerPoint x , cornerPoint y , cornerPoint z).
			aStream nextPut: (cornerPoint x , originPoint y , originPoint z 
						to: cornerPoint x , originPoint y , cornerPoint z).
			aStream nextPut: (originPoint x , cornerPoint y , originPoint z 
						to: originPoint x , cornerPoint y , cornerPoint z).
			anArray := aStream contents]
		ensure: [:aStream | aStream close].
	^anArray
]

{ #category : #converting }
Jun3dBoundingBox >> asArrayOfPlanes [
	"| planes compound |
	planes := Jun3dBoundingBox unity asArrayOfPlanes.
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
	^(Array new: 6)
		at: 1
			put: (planeClass 
					on: originPoint x , originPoint y , originPoint z
					on: originPoint x , cornerPoint y , originPoint z
					on: cornerPoint x , originPoint y , originPoint z);
		at: 2
			put: (planeClass 
					on: originPoint x , originPoint y , originPoint z
					on: cornerPoint x , originPoint y , originPoint z
					on: originPoint x , originPoint y , cornerPoint z);
		at: 3
			put: (planeClass 
					on: originPoint x , originPoint y , originPoint z
					on: originPoint x , originPoint y , cornerPoint z
					on: originPoint x , cornerPoint y , originPoint z);
		at: 4
			put: (planeClass 
					on: cornerPoint x , cornerPoint y , cornerPoint z
					on: cornerPoint x , originPoint y , cornerPoint z
					on: cornerPoint x , cornerPoint y , originPoint z);
		at: 5
			put: (planeClass 
					on: cornerPoint x , cornerPoint y , cornerPoint z
					on: cornerPoint x , cornerPoint y , originPoint z
					on: originPoint x , cornerPoint y , cornerPoint z);
		at: 6
			put: (planeClass 
					on: cornerPoint x , originPoint y , cornerPoint z
					on: cornerPoint x , cornerPoint y , cornerPoint z
					on: originPoint x , cornerPoint y , cornerPoint z);
		yourself
]

{ #category : #converting }
Jun3dBoundingBox >> asArrayOfTriangles [
	"| triangles compound |
	triangles := Jun3dBoundingBox unity asArrayOfTriangles.
	compound := JunOpenGL3dCompoundObject new.
	triangles do: 
			[:triangle | 
			compound 
				add: ((JunOpenGL3dPolygon vertexes: (Array 
								with: triangle p1
								with: triangle p2
								with: triangle p3))
						paint: ColorValue red;
						yourself)].
	compound show.
	^triangles"

	| originPoint cornerPoint triangleClass |
	originPoint := self origin.
	cornerPoint := self corner.
	triangleClass := self triangleClass.
	^(Array new: 12)
		at: 1
			put: (triangleClass 
					on: originPoint x , originPoint y , originPoint z
					on: originPoint x , cornerPoint y , originPoint z
					on: cornerPoint x , originPoint y , originPoint z);
		at: 2
			put: (triangleClass 
					on: cornerPoint x , cornerPoint y , originPoint z
					on: cornerPoint x , originPoint y , originPoint z
					on: originPoint x , cornerPoint y , originPoint z);
		at: 3
			put: (triangleClass 
					on: originPoint x , originPoint y , originPoint z
					on: cornerPoint x , originPoint y , originPoint z
					on: originPoint x , originPoint y , cornerPoint z);
		at: 4
			put: (triangleClass 
					on: cornerPoint x , originPoint y , cornerPoint z
					on: originPoint x , originPoint y , cornerPoint z
					on: cornerPoint x , originPoint y , originPoint z);
		at: 5
			put: (triangleClass 
					on: originPoint x , originPoint y , originPoint z
					on: originPoint x , originPoint y , cornerPoint z
					on: originPoint x , cornerPoint y , originPoint z);
		at: 6
			put: (triangleClass 
					on: originPoint x , cornerPoint y , cornerPoint z
					on: originPoint x , cornerPoint y , originPoint z
					on: originPoint x , originPoint y , cornerPoint z);
		at: 7
			put: (triangleClass 
					on: cornerPoint x , cornerPoint y , cornerPoint z
					on: cornerPoint x , originPoint y , cornerPoint z
					on: cornerPoint x , cornerPoint y , originPoint z);
		at: 8
			put: (triangleClass 
					on: cornerPoint x , originPoint y , originPoint z
					on: cornerPoint x , cornerPoint y , originPoint z
					on: cornerPoint x , originPoint y , cornerPoint z);
		at: 9
			put: (triangleClass 
					on: cornerPoint x , cornerPoint y , cornerPoint z
					on: cornerPoint x , cornerPoint y , originPoint z
					on: originPoint x , cornerPoint y , cornerPoint z);
		at: 10
			put: (triangleClass 
					on: originPoint x , cornerPoint y , originPoint z
					on: originPoint x , cornerPoint y , cornerPoint z
					on: cornerPoint x , cornerPoint y , originPoint z);
		at: 11
			put: (triangleClass 
					on: originPoint x , originPoint y , cornerPoint z
					on: cornerPoint x , originPoint y , cornerPoint z
					on: originPoint x , cornerPoint y , cornerPoint z);
		at: 12
			put: (triangleClass 
					on: cornerPoint x , cornerPoint y , cornerPoint z
					on: originPoint x , cornerPoint y , cornerPoint z
					on: cornerPoint x , originPoint y , cornerPoint z);
		yourself
]

{ #category : #converting }
Jun3dBoundingBox >> asJunOpenGL3dObject [
	"((1 , 1 , 1) extent: (1 , 1 , 1)) asJunOpenGL3dObject showWithAxes."

	| compoundObject |
	compoundObject := JunOpenGL3dObject origin: self origin corner: self corner.
	compoundObject 
		objectsDo: [:each | each paint: self defaultColor alpha: self defaultAlpha].
	^compoundObject
]

{ #category : #converting }
Jun3dBoundingBox >> asPointArray [
	^(Array 
		with: self origin
		with: self corner x , self origin y , self origin z
		with: self corner x , self corner y , self origin z
		with: self origin x , self corner y , self origin z) , (Array 
					with: self corner
					with: self corner x , self origin y , self corner z
					with: self origin x , self origin y , self corner z
					with: self origin x , self corner y , self corner z)
]

{ #category : #functions }
Jun3dBoundingBox >> boxesOutside: boundingBox [ 
	| boxesOutside zOrigin zCorner aBox yOrigin yCorner |
	boxesOutside := self boundingBoxesClass new.
	(self intersects: boundingBox) 
		ifTrue: 
			[zOrigin := self origin z.
			zCorner := self corner z.
			(self origin z <= boundingBox origin z 
				and: [boundingBox corner z <= self corner z]) 
					ifTrue: 
						[zOrigin := boundingBox origin z.
						zCorner := boundingBox corner z.
						aBox := self origin corner: self corner x , self corner y , zOrigin.
						self origin z = zOrigin ifFalse: [boxesOutside add: aBox].
						aBox := self origin x , self origin y , zCorner corner: self corner.
						zCorner = self corner z ifFalse: [boxesOutside add: aBox]]
					ifFalse: 
						[self origin z < boundingBox origin z 
							ifTrue: 
								[zOrigin := boundingBox origin z.
								zCorner := self corner z.
								aBox := self origin corner: self corner x , self corner y , zOrigin.
								self origin z = zOrigin ifFalse: [boxesOutside add: aBox]].
						boundingBox corner z < self corner z 
							ifTrue: 
								[zOrigin := boundingBox corner z.
								zCorner := self origin z.
								aBox := self origin x , self origin y , zOrigin corner: self corner.
								zOrigin = self corner z ifFalse: [boxesOutside add: aBox]]].
			boundingBox origin y > self origin y 
				ifTrue: 
					[aBox := self origin x , self origin y , zOrigin 
								corner: self corner x , (yOrigin := boundingBox origin y) , zCorner.
					boxesOutside add: aBox]
				ifFalse: [yOrigin := self origin y].
			boundingBox corner y < self corner y 
				ifTrue: 
					[aBox := self origin x , (yCorner := boundingBox corner y) , zOrigin 
								corner: self corner x , self corner y , zCorner.
					boxesOutside add: aBox]
				ifFalse: [yCorner := self corner y].
			boundingBox origin x > self origin x 
				ifTrue: 
					[aBox := self origin x , yOrigin , zOrigin 
								corner: boundingBox origin x , yCorner , zCorner.
					boxesOutside add: aBox].
			boundingBox corner x < self corner x 
				ifTrue: 
					[aBox := boundingBox corner x , yOrigin , zOrigin 
								corner: self corner x , yCorner , zCorner.
					boxesOutside add: aBox]]
		ifFalse: 
			[aBox := self copy.
			boxesOutside add: aBox].
	^boxesOutside
]

{ #category : #accessing }
Jun3dBoundingBox >> depth [
	^self corner z - self origin z
]

{ #category : #accessing }
Jun3dBoundingBox >> innerBoundingBall [
	| centerPoint |
	centerPoint := self center.
	^self boundingBallClass center: centerPoint
		radius: ((self width min: self height) min: self depth) / 2
]

{ #category : #testing }
Jun3dBoundingBox >> is3d [
	^true
]

{ #category : #accessing }
Jun3dBoundingBox >> maxLength [
	^(self width max: self height) max: self depth
]

{ #category : #accessing }
Jun3dBoundingBox >> minLength [
	^(self width min: self height) min: self depth
]

{ #category : #accessing }
Jun3dBoundingBox >> octaBoundingBalls [
	| boundingBalls |
	boundingBalls := self boundingBallsClass new.
	self octaBoundingBoxes 
		do: [:boundingBox | boundingBalls add: boundingBox outerBoundingBall].
	^boundingBalls
]

{ #category : #accessing }
Jun3dBoundingBox >> octaBoundingBoxes [
	| boundingBoxes boundingBox z y |
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes 
		add: (boundingBox := self boundingBoxClass origin: self origin
						corner: self center).
	boundingBoxes 
		add: (boundingBox translatedBy: 0 , 0 , (z := self depth / 2)).
	boundingBoxes 
		add: (boundingBox translatedBy: 0 , (y := self height / 2) , z).
	boundingBoxes add: (boundingBox translatedBy: 0 , y , 0).
	boundingBoxes 
		add: (boundingBox := self boundingBoxClass origin: self center
						corner: self corner).
	boundingBoxes add: (boundingBox translatedBy: 0 , y negated , 0).
	boundingBoxes add: (boundingBox translatedBy: 0 , y negated , z negated).
	boundingBoxes add: (boundingBox translatedBy: 0 , 0 , z negated).
	^boundingBoxes
]

{ #category : #accessing }
Jun3dBoundingBox >> p1 [
	^self origin x , self origin y , self origin z
]

{ #category : #accessing }
Jun3dBoundingBox >> p2 [
	^self corner x , self origin y , self origin z
]

{ #category : #accessing }
Jun3dBoundingBox >> p3 [
	^self corner x , self corner y , self origin z
]

{ #category : #accessing }
Jun3dBoundingBox >> p4 [
	^self origin x , self corner y , self origin z
]

{ #category : #accessing }
Jun3dBoundingBox >> p5 [
	^self corner x , self corner y , self corner z
]

{ #category : #accessing }
Jun3dBoundingBox >> p6 [
	^self origin x , self corner y , self corner z
]

{ #category : #accessing }
Jun3dBoundingBox >> p7 [
	^self origin x , self origin y , self corner z
]

{ #category : #accessing }
Jun3dBoundingBox >> p8 [
	^self corner x , self origin y , self corner z
]

{ #category : #accessing }
Jun3dBoundingBox >> pp1 [
	"(0 , 0 , 0 box: 1 , 1 , 1) pp1."

	"(JunOpenGL3dCompoundObject with: (JunOpenGL3dPolygon 
				vertexes: ((0 , 0 , 0 box: 1 , 1 , 1) pp1)
				paint: ColorValue pink))
		add: JunOpenGL3dObject xyzUnitArrows;
		show."

	^Array 
		with: self p1
		with: self p4
		with: self p3
		with: self p2
]

{ #category : #accessing }
Jun3dBoundingBox >> pp2 [
	"(0 , 0 , 0 box: 1 , 1 , 1) pp2."

	"(JunOpenGL3dCompoundObject with: (JunOpenGL3dPolygon 
				vertexes: ((0 , 0 , 0 box: 1 , 1 , 1) pp2)
				paint: ColorValue pink))
		add: JunOpenGL3dObject xyzUnitArrows;
		show."

	^Array 
		with: self p1
		with: self p2
		with: self p8
		with: self p7
]

{ #category : #accessing }
Jun3dBoundingBox >> pp3 [
	"(0 , 0 , 0 box: 1 , 1 , 1) pp3."

	"(JunOpenGL3dCompoundObject with: (JunOpenGL3dPolygon 
				vertexes: ((0 , 0 , 0 box: 1 , 1 , 1) pp3)
				paint: ColorValue pink))
		add: JunOpenGL3dObject xyzUnitArrows;
		show."

	^Array 
		with: self p1
		with: self p7
		with: self p6
		with: self p4
]

{ #category : #accessing }
Jun3dBoundingBox >> pp4 [
	"(0 , 0 , 0 box: 1 , 1 , 1) pp4."

	"(JunOpenGL3dCompoundObject with: (JunOpenGL3dPolygon 
				vertexes: ((0 , 0 , 0 box: 1 , 1 , 1) pp4)
				paint: ColorValue pink))
		add: JunOpenGL3dObject xyzUnitArrows;
		show."

	^Array 
		with: self p5
		with: self p3
		with: self p4
		with: self p6
]

{ #category : #accessing }
Jun3dBoundingBox >> pp5 [
	"(0 , 0 , 0 box: 1 , 1 , 1) pp5."

	"(JunOpenGL3dCompoundObject with: (JunOpenGL3dPolygon 
				vertexes: ((0 , 0 , 0 box: 1 , 1 , 1) pp5)
				paint: ColorValue pink))
		add: JunOpenGL3dObject xyzUnitArrows;
		show."

	^Array 
		with: self p5
		with: self p8
		with: self p2
		with: self p3
]

{ #category : #accessing }
Jun3dBoundingBox >> pp6 [
	"(0 , 0 , 0 box: 1 , 1 , 1) pp6."

	"(JunOpenGL3dCompoundObject with: (JunOpenGL3dPolygon 
				vertexes: ((0 , 0 , 0 box: 1 , 1 , 1) pp6)
				paint: ColorValue pink))
		add: JunOpenGL3dObject xyzUnitArrows;
		show."

	^Array 
		with: self p5
		with: self p6
		with: self p7
		with: self p8
]

{ #category : #accessing }
Jun3dBoundingBox >> pps [
	"(0 , 0 , 0 box: 1 , 1 , 1) pps."

	"(JunOpenGL3dCompoundObject components: ((0 , 0 , 0 box: 1 , 1 , 1) pps 
				collect: [:points | JunOpenGL3dPolygon vertexes: points paint: ColorValue pink]))
		add: JunOpenGL3dObject xyzUnitArrows;
		show."

	^(Array new: 6)
		at: 1 put: self pp1;
		at: 2 put: self pp2;
		at: 3 put: self pp3;
		at: 4 put: self pp4;
		at: 5 put: self pp5;
		at: 6 put: self pp6;
		yourself
]

{ #category : #subdividing }
Jun3dBoundingBox >> subdivide [
	"(((0 , 0 , 0 box: 1 , 1 , 1) subdivide) showWithUnitArrows) wireframePresentation."

	^self subdivide8
]

{ #category : #subdividing }
Jun3dBoundingBox >> subdivide2 [
	"(((0 , 0 , 0 box: 1 , 1 , 1) subdivide2) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 0.9 , 0.9) subdivide2) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 0.9 , 1 , 0.9) subdivide2) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 0.9 , 0.9 , 1) subdivide2) showWithUnitArrows) wireframePresentation."

	| originPoint cornerPoint centerPoint boundingBoxArray boundingBoxes |
	originPoint := self origin.
	cornerPoint := self corner.
	centerPoint := self center.
	boundingBoxArray := Array new: 2.
	(self depth > self width and: [self depth > self height]) 
		ifTrue: 
			[boundingBoxArray at: 1
				put: (originPoint x , originPoint y , originPoint z 
						box: cornerPoint x , cornerPoint y , centerPoint z).
			boundingBoxArray at: 2
				put: (originPoint x , originPoint y , centerPoint z 
						box: cornerPoint x , cornerPoint y , cornerPoint z)]
		ifFalse: 
			[self height > self width 
				ifTrue: 
					[boundingBoxArray at: 1
						put: (originPoint x , originPoint y , originPoint z 
								box: cornerPoint x , centerPoint y , cornerPoint z).
					boundingBoxArray at: 2
						put: (originPoint x , centerPoint y , originPoint z 
								box: cornerPoint x , cornerPoint y , cornerPoint z)]
				ifFalse: 
					[boundingBoxArray at: 1
						put: (originPoint x , originPoint y , originPoint z 
								box: centerPoint x , cornerPoint y , cornerPoint z).
					boundingBoxArray at: 2
						put: (centerPoint x , originPoint y , originPoint z 
								box: cornerPoint x , cornerPoint y , cornerPoint z)]].
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes boundingBoxes: boundingBoxArray.
	^boundingBoxes
]

{ #category : #subdividing }
Jun3dBoundingBox >> subdivide8 [
	"(((0 , 0 , 0 box: 1 , 1 , 1) subdivide8) showWithUnitArrows) wireframePresentation."

	| originPoint cornerPoint centerPoint boundingBoxArray boundingBoxes |
	originPoint := self origin.
	cornerPoint := self corner.
	centerPoint := self center.
	boundingBoxArray := Array new: 8.
	boundingBoxArray at: 1
		put: (originPoint x , originPoint y , originPoint z box: centerPoint).
	boundingBoxArray at: 2
		put: (cornerPoint x , originPoint y , originPoint z box: centerPoint).
	boundingBoxArray at: 3
		put: (originPoint x , cornerPoint y , originPoint z box: centerPoint).
	boundingBoxArray at: 4
		put: (cornerPoint x , cornerPoint y , originPoint z box: centerPoint).
	boundingBoxArray at: 5
		put: (originPoint x , originPoint y , cornerPoint z box: centerPoint).
	boundingBoxArray at: 6
		put: (cornerPoint x , originPoint y , cornerPoint z box: centerPoint).
	boundingBoxArray at: 7
		put: (originPoint x , cornerPoint y , cornerPoint z box: centerPoint).
	boundingBoxArray at: 8
		put: (cornerPoint x , cornerPoint y , cornerPoint z box: centerPoint).
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes boundingBoxes: boundingBoxArray.
	^boundingBoxes
]

{ #category : #accessing }
Jun3dBoundingBox >> tetraBoundingBalls [
	^self shouldNotImplement
]

{ #category : #accessing }
Jun3dBoundingBox >> tetraBoundingBoxes [
	^self shouldNotImplement
]

{ #category : #testing }
Jun3dBoundingBox >> touchesPoint: aPoint [ 
	^(((self isEqualNumber: self origin x to: aPoint x) 
		or: [self isEqualNumber: self corner x to: aPoint x]) and: 
				[(self origin y <= aPoint y and: [aPoint y <= self corner y]) 
					and: [self origin z <= aPoint z and: [aPoint z <= self corner z]]]) 
		or: 
			[(((self isEqualNumber: self origin y to: aPoint y) 
				or: [self isEqualNumber: self corner y to: aPoint y]) and: 
						[(self origin x <= aPoint x and: [aPoint x <= self corner x]) 
							and: [self origin z <= aPoint z and: [aPoint z <= self corner z]]]) 
				or: 
					[((self isEqualNumber: self origin z to: aPoint z) 
						or: [self isEqualNumber: self corner z to: aPoint z]) and: 
								[(self origin x <= aPoint x and: [aPoint x <= self corner x]) 
									and: [self origin y <= aPoint y and: [aPoint y <= self corner y]]]]]
]

{ #category : #accessing }
Jun3dBoundingBox >> volume [
	^self width * self height * self depth
]

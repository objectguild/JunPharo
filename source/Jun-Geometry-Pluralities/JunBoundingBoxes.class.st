"
Imported by VwImportClass
"
Class {
	#name : #JunBoundingBoxes,
	#superclass : #JunBoundingObjects,
	#category : #'Jun-Geometry-Pluralities'
}

{ #category : #copyright }
JunBoundingBoxes class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #defaults }
JunBoundingBoxes class >> defaultPartitionSize [
	^10
]

{ #category : #'instance creation' }
JunBoundingBoxes class >> fromObject: anObject [ 
	^self fromObject: anObject maxPartition: self defaultPartitionSize
]

{ #category : #'instance creation' }
JunBoundingBoxes class >> fromObject: anObject howMany: aPoint [ 
	^self makeBoxesFromObject: anObject howMany: aPoint
]

{ #category : #'instance creation' }
JunBoundingBoxes class >> fromObject: anObject maxPartition: partitionSize [ 
	^self subclassResponsibility
]

{ #category : #'instance creation' }
JunBoundingBoxes class >> fromPoints: pointCollection [ 
	^self fromPoints: pointCollection maxPartition: self defaultPartitionSize
]

{ #category : #'instance creation' }
JunBoundingBoxes class >> fromPoints: pointCollection howMany: aPoint [ 
	^self makeBoxesFromPoints: pointCollection howMany: aPoint
]

{ #category : #'instance creation' }
JunBoundingBoxes class >> fromPoints: anObject maxPartition: partitionSize [ 
	^self subclassResponsibility
]

{ #category : #private }
JunBoundingBoxes class >> makeBitmap: sourceImage [ 
	"(JunOpenGL3dCompoundObject
		with: ((Jun2dBoundingBoxes fromPoints: ((0 to: 360) collect: [:a | 1 , 0 rotatedBy: a degreesToRadians]))
				asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5)
		with: ((JunOpenGL3dObject ball) alpha: 0.5; yourself)) show."

	| expandedImage bitmapImage |
	expandedImage := Image 
				extent: sourceImage extent + (2 @ 2)
				depth: 1
				palette: MonoMappedPalette whiteBlack.
	JunImageProcessor fill: expandedImage color: ColorValue white.
	expandedImage 
		copy: (expandedImage bounds insetBy: 1)
		from: 0 @ 0
		in: sourceImage
		rule: RasterOp over.
	JunImageProcessor fill: expandedImage seed: 0 @ 0.
	bitmapImage := Image 
				extent: sourceImage extent
				depth: 1
				palette: MonoMappedPalette whiteBlack.
	bitmapImage 
		copy: bitmapImage bounds
		from: 1 @ 1
		in: expandedImage
		rule: RasterOp over.
	0 to: bitmapImage height - 1
		do: 
			[:y | 
			0 to: bitmapImage width - 1
				do: 
					[:x | 
					| v |
					(bitmapImage atX: x y: y) = 0 
						ifTrue: [v := 1]
						ifFalse: 
							[v := 0.
							(sourceImage atX: x y: y) = 1 ifTrue: [v := 1]].
					bitmapImage 
						atX: x
						y: y
						put: v]].
	^bitmapImage
]

{ #category : #private }
JunBoundingBoxes class >> makeBoxesFromObject: aBody howMany: aPoint [ 
	^self subclassResponsibility
]

{ #category : #private }
JunBoundingBoxes class >> makeBoxesFromPoints: pointCollection howMany: aPoint [ 
	^self subclassResponsibility
]

{ #category : #copyright }
JunBoundingBoxes class >> system [
	^'Jun'
]

{ #category : #copyright }
JunBoundingBoxes class >> version [
	^'799'
]

{ #category : #converting }
JunBoundingBoxes >> asBoundingBox [
	^self boundingBox
]

{ #category : #converting }
JunBoundingBoxes >> asBoundingBoxes [
	^self
]

{ #category : #converting }
JunBoundingBoxes >> asJunOpenGL3dObject [
	| compoundObject |
	compoundObject := JunOpenGL3dCompoundObject new: self size.
	self 
		do: [:boundingBox | compoundObject add: boundingBox asJunOpenGL3dObject].
	^compoundObject
]

{ #category : #converting }
JunBoundingBoxes >> asRectangle [
	^self asBoundingBox asRectangle
]

{ #category : #converting }
JunBoundingBoxes >> asRectangles [
	| aCollection |
	aCollection := OrderedCollection new: self size.
	self do: [:boundingBox | aCollection add: boundingBox asRectangle].
	^aCollection
]

{ #category : #accessing }
JunBoundingBoxes >> boundingBall [
	| boundingBall |
	self isEmpty ifTrue: [^self boundingBallClass new].
	boundingBall := nil.
	self do: 
			[:aBox | 
			boundingBall isNil 
				ifTrue: [boundingBall := aBox boundingBall]
				ifFalse: [boundingBall := aBox boundingBall merge: boundingBall]].
	^boundingBall
]

{ #category : #accessing }
JunBoundingBoxes >> boundingBox [
	| boundingBox |
	self isEmpty ifTrue: [^self boundingBoxClass new].
	boundingBox := nil.
	self do: 
			[:aBox | 
			boundingBox isNil 
				ifTrue: [boundingBox := aBox]
				ifFalse: [boundingBox := aBox merge: boundingBox]].
	^boundingBox
]

{ #category : #accessing }
JunBoundingBoxes >> boundingBoxes [
	^self boundingObjects
]

{ #category : #accessing }
JunBoundingBoxes >> boundingBoxes: boundingBoxCollection [ 
	self boundingObjects: boundingBoxCollection
]

{ #category : #functions }
JunBoundingBoxes >> complementBoxes [
	| complementBoxes intersectionBox |
	complementBoxes := self unionBoxes.
	intersectionBox := self intersectionBox.
	intersectionBox isNil ifTrue: [^complementBoxes].
	complementBoxes := complementBoxes copyWithout: intersectionBox.
	complementBoxes := complementBoxes reject: [:aBox | aBox isEmpty].
	^complementBoxes
]

{ #category : #functions }
JunBoundingBoxes >> differenceBoxes [
	| firstRectangle differenceBoxes |
	self isEmpty ifTrue: [^self copy].
	firstRectangle := self boundingBoxes first.
	differenceBoxes := self class new.
	differenceBoxes add: firstRectangle.
	(self boundingBoxes copyFrom: 2 to: self boundingBoxes size) do: 
			[:aRectangle | 
			| boundingBoxes |
			boundingBoxes := self class new.
			differenceBoxes do: 
					[:each | 
					(each intersects: firstRectangle) 
						ifTrue: [boundingBoxes addAll: (each boxesOutside: aRectangle)]
						ifFalse: [boundingBoxes add: each]].
			differenceBoxes := boundingBoxes].
	differenceBoxes := differenceBoxes reject: [:aBox | aBox isEmpty].
	^differenceBoxes
]

{ #category : #functions }
JunBoundingBoxes >> intersectionBox [
	| intersectionBox |
	self isEmpty ifTrue: [^nil].
	intersectionBox := nil.
	self do: 
			[:each | 
			intersectionBox isNil 
				ifTrue: [intersectionBox := each]
				ifFalse: 
					[(intersectionBox intersects: each) 
						ifTrue: [intersectionBox := intersectionBox intersect: each]
						ifFalse: [^nil]]].
	intersectionBox isEmpty ifTrue: [^nil].
	^intersectionBox
]

{ #category : #functions }
JunBoundingBoxes >> intersectionBoxes [
	| intersectionBox |
	intersectionBox := self intersectionBox.
	intersectionBox isNil ifTrue: [^self class new].
	^(self class new)
		add: intersectionBox;
		yourself
]

{ #category : #testing }
JunBoundingBoxes >> isBoundingBoxes [
	^true
]

{ #category : #subdividing }
JunBoundingBoxes >> subdivide [
	"(((0 , 0 box: 1 , 1) asBoundingBoxes subdivide) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) asBoundingBoxes subdivide) showWithUnitArrows) wireframePresentation."

	^self subclassResponsibility
]

{ #category : #subdividing }
JunBoundingBoxes >> subdivide2 [
	"(((0 , 0 box: 1 , 1) asBoundingBoxes subdivide2) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) asBoundingBoxes subdivide2) showWithUnitArrows) wireframePresentation."

	| boundingBoxArray boundingBoxes |
	boundingBoxArray := Array new: self size * 2.
	self with: (0 to: self size - 1)
		do: 
			[:boundingBox :n | 
			| offset |
			boundingBoxes := boundingBox subdivide2 boundingBoxes.
			offset := n * 2.
			boundingBoxArray at: 1 + offset put: (boundingBoxes at: 1).
			boundingBoxArray at: 2 + offset put: (boundingBoxes at: 2)].
	boundingBoxes := self boundingBoxesClass new.
	boundingBoxes boundingBoxes: boundingBoxArray.
	^boundingBoxes
]

{ #category : #subdividing }
JunBoundingBoxes >> subdivide2Level: anInteger [ 
	"(((0 , 0 box: 1 , 1) asBoundingBoxes subdivide2Level: 0) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 box: 1 , 1) asBoundingBoxes subdivide2Level: 1) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 box: 1 , 1) asBoundingBoxes subdivide2Level: 2) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) asBoundingBoxes subdivide2Level: 0) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) asBoundingBoxes subdivide2Level: 1) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) asBoundingBoxes subdivide2Level: 2) showWithUnitArrows) wireframePresentation."

	| boundingBoxes |
	boundingBoxes := self.
	anInteger timesRepeat: [boundingBoxes := boundingBoxes subdivide2].
	^boundingBoxes
]

{ #category : #subdividing }
JunBoundingBoxes >> subdivideLevel: anInteger [ 
	"(((0 , 0 box: 1 , 1) asBoundingBoxes subdivideLevel: 0) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 box: 1 , 1) asBoundingBoxes subdivideLevel: 1) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 box: 1 , 1) asBoundingBoxes subdivideLevel: 2) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) asBoundingBoxes subdivideLevel: 0) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) asBoundingBoxes subdivideLevel: 1) showWithUnitArrows) wireframePresentation."

	"(((0 , 0 , 0 box: 1 , 1 , 1) asBoundingBoxes subdivideLevel: 2) showWithUnitArrows) wireframePresentation."

	| boundingBoxes |
	boundingBoxes := self copy.
	anInteger timesRepeat: [boundingBoxes := boundingBoxes subdivide].
	^boundingBoxes
]

{ #category : #functions }
JunBoundingBoxes >> unify [
	^self asBoundingBox
]

{ #category : #functions }
JunBoundingBoxes >> unionBoxes [
	| unionBoxes intersectionBox |
	unionBoxes := self class new.
	((intersectionBox := self intersectionBox) isNil 
		ifTrue: [self boundingBoxes]
		ifFalse: [self boundingBoxes copyWith: intersectionBox]) do: 
				[:aBox | 
				| boundingBoxes |
				boundingBoxes := self class new.
				boundingBoxes add: aBox.
				unionBoxes do: 
						[:each | 
						(each intersects: aBox) 
							ifTrue: [boundingBoxes addAll: (each boxesOutside: aBox)]
							ifFalse: [boundingBoxes add: each]].
				unionBoxes := boundingBoxes].
	unionBoxes := unionBoxes reject: [:aBox | aBox isEmpty].
	^unionBoxes
]

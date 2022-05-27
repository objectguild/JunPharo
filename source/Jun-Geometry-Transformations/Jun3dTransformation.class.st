"
Imported by VwImportClass
"
Class {
	#name : #Jun3dTransformation,
	#superclass : #JunTransformation,
	#instVars : [
		'a',
		'b',
		'c',
		'p',
		'd',
		'e',
		'f',
		'q',
		'g',
		'h',
		'i',
		'r',
		'l',
		'm',
		'n',
		's'
	],
	#category : #'Jun-Geometry-Transformations'
}

{ #category : #'typical transformation' }
Jun3dTransformation class >> align: alignmentPoint with: relativePoint [ 
	^self translate: relativePoint - alignmentPoint
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> alignPoints: anArrayOfAssociations [ 
	"Jun3dTransformation alignPoints: (Array
			with: 0 , 0 , 0 -> (0 , -1 , 0)
			with: 1 , 0 , 0 -> (-1 , 0 , 0)
			with: 0 , 2 , 0 -> (0 , 1 , 0)
			with: 0 , 0 , 1 -> (0 , 0 , 1))."

	| aTransformation solvingBlock |
	aTransformation := self unity.
	solvingBlock := 
			[:getSelector :setSelectors | 
			| equationsCollection solution |
			equationsCollection := OrderedCollection 
						new: anArrayOfAssociations size * 5.
			anArrayOfAssociations do: 
					[:assoc | 
					equationsCollection addAll: assoc key asArray.
					equationsCollection add: 1.0d.
					equationsCollection add: (assoc value perform: getSelector) negated].
			solution := (JunLinearEquations 
						new: anArrayOfAssociations size
						by: 5
						collection: equationsCollection) solution.
			1 to: 4
				do: 
					[:index | 
					(solution at: index) ifNotNil: 
							[:it | 
							| selector |
							selector := setSelectors at: index.
							aTransformation perform: selector with: it]]].
	solvingBlock value: #x value: #(#setA: #setD: #setG: #setL:).
	solvingBlock value: #y value: #(#setB: #setE: #setH: #setM:).
	solvingBlock value: #z value: #(#setC: #setF: #setI: #setN:).
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> alignVector: aJun3dPoint1 to: aJun3dPoint2 [ 
	| zero axisVector normalVector1 normalVector2 |
	(aJun3dPoint1 - aJun3dPoint2) length < aJun3dPoint2 accuracy 
		ifTrue: [^self unity].
	zero := Jun3dPoint zero.
	axisVector := (aJun3dPoint1 vectorProduct: aJun3dPoint2) unitVector.
	normalVector1 := aJun3dPoint1 vectorProduct: axisVector.
	normalVector2 := aJun3dPoint2 vectorProduct: axisVector.
	^self alignPoints: (Array 
				with: aJun3dPoint1 -> aJun3dPoint2
				with: axisVector -> axisVector
				with: normalVector1 -> normalVector2
				with: zero -> zero)
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> alignVector: aJun3dPoint1 withVector: aJun3dPoint2 [ 
	| aTransformation |
	aTransformation := self errorSignal 
				handle: [:exception | exception returnWith: self unity]
				do: [self alignVector: aJun3dPoint1 to: aJun3dPoint2].
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> cabinet: anAngle [ 
	"Jun3dTransformation cabinet: (JunAngle fromDeg: 45)."

	| theAngle aTransformation |
	theAngle := JunAngle coerce: anAngle.
	aTransformation := self unity.
	aTransformation setG: theAngle cos / 2.
	aTransformation setH: theAngle sin / 2.
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> cavalie: anAngle [ 
	"Jun3dTransformation cavalie: (JunAngle fromDeg: 45)."

	| theAngle aTransformation |
	theAngle := JunAngle coerce: anAngle.
	aTransformation := self unity.
	aTransformation setG: theAngle cos.
	aTransformation setH: theAngle sin.
	^aTransformation
]

{ #category : #copyright }
Jun3dTransformation class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #debug }
Jun3dTransformation class >> debug: aBlock [ 
	"aBlock value"
]

{ #category : #examples }
Jun3dTransformation class >> example1 [
	"Jun3dTransformation example1."

	| aTransformation |
	aTransformation := Jun3dTransformation fromArray: #(1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1).
	Transcript cr; show: aTransformation printString.
	Transcript cr; show: aTransformation storeString.
	^aTransformation
]

{ #category : #examples }
Jun3dTransformation class >> example2 [
	"Jun3dTransformation example2."

	| fromPoint toPoint tT graphicsContext |
	fromPoint := 50 , 100 , 0.
	toPoint := 100 , 50 , 0.
	tT := Jun3dTransformation translate: 100 , 100 , 0.
	graphicsContext := ScheduledControllers activeController view graphicsContext.
	graphicsContext clear.
	graphicsContext paint: ColorValue blue.
	graphicsContext displayLineFrom: fromPoint asPoint to: toPoint asPoint.
	graphicsContext paint: ColorValue red.
	graphicsContext displayLineFrom: (fromPoint transform: tT) asPoint to: (toPoint transform: tT) asPoint.
	Cursor crossHair showWhile: [graphicsContext medium sensor waitClickButton].
	graphicsContext medium display.
	^tT
]

{ #category : #examples }
Jun3dTransformation class >> example3 [
	"Jun3dTransformation example3."

	| fromPoint toPoint tS graphicsContext |
	fromPoint := 50 , 100 , 0.
	toPoint := 100 , 50 , 0.
	tS := Jun3dTransformation scale: 2 , 2 , 0.
	graphicsContext := ScheduledControllers activeController view graphicsContext.
	graphicsContext clear.
	graphicsContext paint: ColorValue blue.
	graphicsContext displayLineFrom: fromPoint asPoint to: toPoint asPoint.
	graphicsContext paint: ColorValue red.
	graphicsContext displayLineFrom: (fromPoint transform: tS) asPoint to: (toPoint transform: tS) asPoint.
	Cursor crossHair showWhile: [graphicsContext medium sensor waitClickButton].
	graphicsContext medium display.
	^tS
]

{ #category : #examples }
Jun3dTransformation class >> example4 [
	"Jun3dTransformation example4."

	| fromPoint toPoint tR graphicsContext |
	fromPoint := 50 , 100 , 0.
	toPoint := 100 , 50 , 0.
	tR := Jun3dTransformation rotate: (JunAngle fromDeg: 20).
	graphicsContext := ScheduledControllers activeController view graphicsContext.
	graphicsContext clear.
	graphicsContext paint: ColorValue blue.
	graphicsContext displayLineFrom: fromPoint asPoint to: toPoint asPoint.
	graphicsContext paint: ColorValue red.
	graphicsContext displayLineFrom: (fromPoint transform: tR) asPoint to: (toPoint transform: tR) asPoint.
	Cursor crossHair showWhile: [graphicsContext medium sensor waitClickButton].
	graphicsContext medium display.
	^tR
]

{ #category : #examples }
Jun3dTransformation class >> example5 [
	"Jun3dTransformation example5."

	| fromPoint toPoint aLine tR graphicsContext |
	fromPoint := 50 , 100 , 0.
	toPoint := 100 , 50 , 0.
	aLine := Array with: (fromPoint center: toPoint)
				with: ((fromPoint center: toPoint)
						transform: (Jun3dTransformation translate: 0 , 0 , 100)).
	graphicsContext := ScheduledControllers activeController view graphicsContext.
	graphicsContext clear.
	graphicsContext paint: ColorValue blue.
	graphicsContext displayLineFrom: fromPoint asPoint to: toPoint asPoint.
	graphicsContext paint: ColorValue red.
	10
		to: 170
		by: 10
		do: 
			[:angle | 
			tR := Jun3dTransformation rotate: (JunAngle fromDeg: angle)
						around: aLine.
			graphicsContext displayLineFrom: (fromPoint transform: tR) asPoint to: (toPoint transform: tR) asPoint].
	Cursor crossHair showWhile: [graphicsContext medium sensor waitClickButton].
	graphicsContext medium display.
	^tR
]

{ #category : #lessons }
Jun3dTransformation class >> lessonRotation1 [
	"Jun3dTransformation lessonRotation1."

	| characterN pointP xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonRotation2 [
	"Jun3dTransformation lessonRotation2."

	| characterN pointP aTransformation xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	aTransformation := Jun3dTransformation rotateX: (JunAngle fromDeg: 30).
	characterN := characterN transform: aTransformation.
	pointP := pointP transform: aTransformation.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonRotation3 [
	"Jun3dTransformation lessonRotation3."

	| characterN pointP aTransformation xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	aTransformation := Jun3dTransformation rotateY: (JunAngle fromDeg: 30).
	characterN := characterN transform: aTransformation.
	pointP := pointP transform: aTransformation.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonRotation4 [
	"Jun3dTransformation lessonRotation4."

	| characterN pointP aTransformation xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	aTransformation := Jun3dTransformation rotateZ: (JunAngle fromDeg: 30).
	characterN := characterN transform: aTransformation.
	pointP := pointP transform: aTransformation.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonRotation5 [
	"Jun3dTransformation lessonRotation5."

	| characterN pointP aTransformation xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	aTransformation := ((Jun3dTransformation rotateX: (JunAngle fromDeg: 30))
				product: (Jun3dTransformation rotateY: (JunAngle fromDeg: 30)))
				product: (Jun3dTransformation rotateZ: (JunAngle fromDeg: 30)).
	characterN := characterN transform: aTransformation.
	pointP := pointP transform: aTransformation.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonRotation6 [
	"Jun3dTransformation lessonRotation6."

	| characterN pointP aTransformation xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	aTransformation := ((Jun3dTransformation rotateZ: (JunAngle fromDeg: 30))
				product: (Jun3dTransformation rotateY: (JunAngle fromDeg: 30)))
				product: (Jun3dTransformation rotateX: (JunAngle fromDeg: 30)).
	characterN := characterN transform: aTransformation.
	pointP := pointP transform: aTransformation.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonRotation7 [
	"Jun3dTransformation lessonRotation7."

	| characterN pointP aLine aTransformation xyzAxes aPolyline compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	aLine := Jun3dLine from: 0 , 0 , 0 to: characterN boundingBox corner.
	aTransformation := Jun3dTransformation rotate: (JunAngle fromDeg: 30)
				around: aLine.
	characterN := characterN transform: aTransformation.
	pointP := pointP transform: aTransformation.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	aPolyline := JunOpenGL3dPolyline vertexes: (Array with: (aLine atT: -2)
					with: (aLine atT: 2)).
	aPolyline paint: ColorValue cyan.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject add: aPolyline.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonScaling1 [
	"Jun3dTransformation lessonScaling1."

	| characterN pointP xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonScaling2 [
	"Jun3dTransformation lessonScaling2."

	| characterN pointP aTransformation xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	aTransformation := Jun3dTransformation scale: 1.5 , 1.5 , 1.5.
	characterN := characterN transform: aTransformation.
	pointP := pointP transform: aTransformation.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonScaling3 [
	"Jun3dTransformation lessonScaling3."

	| characterN pointP aTransformation xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	aTransformation := Jun3dTransformation scale: 0.5 , 0.5 , 0.5.
	characterN := characterN transform: aTransformation.
	pointP := pointP transform: aTransformation.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonScaling4 [
	"Jun3dTransformation lessonScaling4."

	| characterN pointP aTransformation xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	aTransformation := Jun3dTransformation scale: -1 , -1 , 1.
	characterN := characterN transform: aTransformation.
	pointP := pointP transform: aTransformation.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonShearing1 [
	"Jun3dTransformation lessonShearing1."

	| characterN pointP xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonShearing2 [
	"Jun3dTransformation lessonShearing2."

	| characterN pointP aTransformation xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	aTransformation := Jun3dTransformation fromArray: #(1 0 0 0 0 1 0 0 0 0.5 1 0 0 0 0 1).
	characterN := characterN transform: aTransformation.
	pointP := pointP transform: aTransformation.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonTranslation1 [
	"Jun3dTransformation lessonTranslation1."

	| characterN pointP xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #lessons }
Jun3dTransformation class >> lessonTranslation2 [
	"Jun3dTransformation lessonTranslation2."

	| characterN pointP aTransformation xyzAxes compoundObject |
	characterN := JunOpenGL3dObject characterN.
	characterN paint: ColorValue magenta.
	characterN := characterN translatedBy: characterN boundingBox corner.
	pointP := JunOpenGL3dObject cube.
	pointP := pointP scaledBy: 0.1.
	pointP := pointP translatedBy: characterN boundingBox corner.
	aTransformation := Jun3dTransformation translate: 0 , 0 , 1.2.
	characterN := characterN transform: aTransformation.
	pointP := pointP transform: aTransformation.
	xyzAxes := JunOpenGL3dObject axes.
	xyzAxes := xyzAxes scaledBy: 3.5.
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: characterN.
	compoundObject add: xyzAxes.
	compoundObject add: pointP.
	compoundObject show.
	Transcript cr; show: pointP boundingBox center printString
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> mirrorX [
	| aTransformation |
	aTransformation := self unity.
	aTransformation setA: -1.
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> mirrorY [
	| aTransformation |
	aTransformation := self unity.
	aTransformation setE: -1.
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> mirrorZ [
	| aTransformation |
	aTransformation := self unity.
	aTransformation setI: -1.
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> parallel: aPoint [ 
	"Jun3dTransformation parallel: (Jun3dPoint fromArray: #(100 100 100))."

	| thePoint aTransformation |
	thePoint := Jun3dPoint coerce: aPoint.
	aTransformation := self unity.
	aTransformation setG: (thePoint x / thePoint z) negated.
	aTransformation setH: (thePoint y / thePoint z) negated.
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> perspective: aPoint [ 
	"Jun3dTransformation perspective: (Jun3dPoint fromArray: #(100 100 100))."

	| thePoint aTransformation |
	thePoint := Jun3dPoint coerce: aPoint.
	aTransformation := self unity.
	aTransformation setA: thePoint z negated.
	aTransformation setE: thePoint z negated.
	aTransformation setG: thePoint x.
	aTransformation setH: thePoint y.
	aTransformation setI: -1.
	aTransformation setR: 1.
	aTransformation setS: thePoint z negated.
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> rotate: anAngle [ 
	"Jun3dTransformation rotate: (JunAngle fromDeg: 45)."

	^self rotateZ: anAngle
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> rotate: anAngle around: aLine [ 
	"Jun3dTransformation 
	rotate: (JunAngle fromDeg: 45) 
	around: (Array 
	with: (Jun3dPoint fromArray: #(75 75 0)) 
	with: (Jun3dPoint fromArray: #(75 75 75)))."

	| theAngle firstPoint lastPoint aVector aV aL aT aRx aRy aRz rRy rRx rT aTransformation |
	theAngle := JunAngle coerce: anAngle.
	firstPoint := Jun3dPoint coerce: aLine first.
	lastPoint := Jun3dPoint coerce: aLine last.
	aVector := lastPoint - firstPoint.
	aV := (aVector y squared + aVector z squared) sqrt.
	aL := (aVector x squared + aVector y squared + aVector z squared) sqrt.
	aT := self translate: firstPoint negated.
	aRx := self unity.
	aV isZero
		ifFalse: 
			[aRx setE: aVector z / aV.
			aRx setF: aVector y / aV.
			aRx setH: (aVector y / aV) negated.
			aRx setI: aVector z / aV].
	aRy := self unity.
	aL isZero
		ifFalse: 
			[aRy setA: aV / aL.
			aRy setC: aVector x / aL.
			aRy setG: (aVector x / aL) negated.
			aRy setI: aV / aL].
	aRz := self rotate: theAngle.
	rRy := self unity.
	aL isZero
		ifFalse: 
			[rRy setA: aV / aL.
			rRy setC: (aVector x / aL) negated.
			rRy setG: aVector x / aL.
			rRy setI: aV / aL].
	rRx := self unity.
	aV isZero
		ifFalse: 
			[rRx setE: aVector z / aV.
			rRx setF: (aVector y / aV) negated.
			rRx setH: aVector y / aV.
			rRx setI: aVector z / aV].
	rT := self translate: firstPoint.
	aTransformation := aT product: aRx.
	aTransformation := aTransformation product: aRy.
	aTransformation := aTransformation product: aRz.
	aTransformation := aTransformation product: rRy.
	aTransformation := aTransformation product: rRx.
	aTransformation := aTransformation product: rT.
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> rotateX: anAngle [ 
	"Jun3dTransformation rotateX: (JunAngle fromDeg: 45)."

	| theAngle aTransformation |
	theAngle := JunAngle coerce: anAngle.
	aTransformation := self unity.
	aTransformation setE: theAngle cos.
	aTransformation setF: theAngle sin.
	aTransformation setH: theAngle sin negated.
	aTransformation setI: theAngle cos.
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> rotateY: anAngle [ 
	"Jun3dTransformation rotateY: (JunAngle fromDeg: 45)."

	| theAngle aTransformation |
	theAngle := JunAngle coerce: anAngle.
	aTransformation := self unity.
	aTransformation setA: theAngle cos.
	aTransformation setC: theAngle sin negated.
	aTransformation setG: theAngle sin.
	aTransformation setI: theAngle cos.
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> rotateZ: anAngle [ 
	"Jun3dTransformation rotateZ: (JunAngle fromDeg: 45)."

	| theAngle aTransformation |
	theAngle := JunAngle coerce: anAngle.
	aTransformation := self unity.
	aTransformation setA: theAngle cos.
	aTransformation setB: theAngle sin.
	aTransformation setD: theAngle sin negated.
	aTransformation setE: theAngle cos.
	^aTransformation
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> scale: aPoint [ 
	"Jun3dTransformation scale: (Jun3dPoint fromArray: #(1 2 3))."

	| thePoint aTransformation |
	thePoint := Jun3dPoint coerce: aPoint.
	aTransformation := self unity.
	aTransformation setA: thePoint x.
	aTransformation setE: thePoint y.
	aTransformation setI: thePoint z.
	^aTransformation
]

{ #category : #copyright }
Jun3dTransformation class >> system [
	^'Jun'
]

{ #category : #'typical transformation' }
Jun3dTransformation class >> translate: aPoint [ 
	"Jun3dTransformation translate: (Jun3dPoint fromArray: #(10 20 30))."

	| thePoint aTransformation |
	thePoint := Jun3dPoint coerce: aPoint.
	aTransformation := self unity.
	aTransformation setL: thePoint x.
	aTransformation setM: thePoint y.
	aTransformation setN: thePoint z.
	^aTransformation
]

{ #category : #'constants access' }
Jun3dTransformation class >> unity [
	"Jun3dTransformation unity"

	| aTransformation |
	aTransformation := self basicNew.
	aTransformation setA: 1; setB: 0; setC: 0; setP: 0.
	aTransformation setD: 0; setE: 1; setF: 0; setQ: 0.
	aTransformation setG: 0; setH: 0; setI: 1; setR: 0.
	aTransformation setL: 0; setM: 0; setN: 0; setS: 1.
	^aTransformation
]

{ #category : #copyright }
Jun3dTransformation class >> version [
	^'799'
]

{ #category : #'constants access' }
Jun3dTransformation class >> zero [
	"Jun3dTransformation zero."

	| aTransformation |
	aTransformation := self basicNew.
	aTransformation setA: 0; setB: 0; setC: 0; setP: 0.
	aTransformation setD: 0; setE: 0; setF: 0; setQ: 0.
	aTransformation setG: 0; setH: 0; setI: 0; setR: 0.
	aTransformation setL: 0; setM: 0; setN: 0; setS: 0.
	^aTransformation
]

{ #category : #comparing }
Jun3dTransformation >> = aTransformation [ 
	self class == aTransformation class ifFalse: [^false].
	^((((((((((((((a = aTransformation a and: [b = aTransformation b]) 
		and: [c = aTransformation c]) and: [p = aTransformation p]) 
		and: [d = aTransformation d]) and: [e = aTransformation e]) 
		and: [f = aTransformation f]) and: [q = aTransformation q]) 
		and: [g = aTransformation g]) and: [h = aTransformation h]) 
		and: [i = aTransformation i]) and: [r = aTransformation r]) 
		and: [l = aTransformation l]) and: [m = aTransformation m]) 
		and: [n = aTransformation n]) and: [s = aTransformation s]
]

{ #category : #accessing }
Jun3dTransformation >> a [
	^a
]

{ #category : #'applying transformation' }
Jun3dTransformation >> applyToPoint: aPoint [ 
	| point nx ny nz scale |
	aPoint class == Jun3dPoint
		ifTrue: [point := aPoint]
		ifFalse: [point := Jun3dPoint coerce: aPoint].
	nx := point x * a + (point y * d) + (point z * g) + l.
	ny := point x * b + (point y * e) + (point z * h) + m.
	nz := point x * c + (point y * f) + (point z * i) + n.
	scale := point x * p + (point y * q) + (point z * r) + s.
	scale = 0.0d ifTrue: [scale := self class accuracy].
	^Jun3dPoint
		x: nx / scale
		y: ny / scale
		z: nz / scale
]

{ #category : #converting }
Jun3dTransformation >> asArray [
	| array |
	array := Array new: 16.
	array at: 1 put: a.
	array at: 2 put: b.
	array at: 3 put: c.
	array at: 4 put: p.
	array at: 5 put: d.
	array at: 6 put: e.
	array at: 7 put: f.
	array at: 8 put: q.
	array at: 9 put: g.
	array at: 10 put: h.
	array at: 11 put: i.
	array at: 12 put: r.
	array at: 13 put: l.
	array at: 14 put: m.
	array at: 15 put: n.
	array at: 16 put: s.
	^array
]

{ #category : #converting }
Jun3dTransformation >> asMatrix [
	^JunMatrix new: 4 collection: self asArray
]

{ #category : #converting }
Jun3dTransformation >> asRotationMatrix [
	| anArray |
	anArray := Array new: 3 * 3.
	anArray at: 1 put: a.
	anArray at: 2 put: b.
	anArray at: 3 put: c.
	anArray at: 4 put: d.
	anArray at: 5 put: e.
	anArray at: 6 put: f.
	anArray at: 7 put: g.
	anArray at: 8 put: h.
	anArray at: 9 put: i.
	^JunMatrix new: 3 collection: anArray
]

{ #category : #converting }
Jun3dTransformation >> asTranslation [
	^Jun3dPoint
		x: l
		y: m
		z: n
]

{ #category : #accessing }
Jun3dTransformation >> b [
	^b
]

{ #category : #accessing }
Jun3dTransformation >> c [
	^c
]

{ #category : #accessing }
Jun3dTransformation >> d [
	^d
]

{ #category : #accessing }
Jun3dTransformation >> e [
	^e
]

{ #category : #comparing }
Jun3dTransformation >> equal: aTransformation [ 
	self class == aTransformation class ifFalse: [^false].
	^(((((((((((((((a - aTransformation a) abs < self accuracy 
		and: [(b - aTransformation b) abs < self accuracy]) 
			and: [(c - aTransformation c) abs < self accuracy]) 
			and: [(p - aTransformation p) abs < self accuracy]) 
			and: [(d - aTransformation d) abs < self accuracy]) 
			and: [(e - aTransformation e) abs < self accuracy]) 
			and: [(f - aTransformation f) abs < self accuracy]) 
			and: [(q - aTransformation q) abs < self accuracy]) 
			and: [(g - aTransformation g) abs < self accuracy]) 
			and: [(h - aTransformation h) abs < self accuracy]) 
			and: [(i - aTransformation i) abs < self accuracy]) 
			and: [(r - aTransformation r) abs < self accuracy]) 
			and: [(l - aTransformation l) abs < self accuracy]) 
			and: [(m - aTransformation m) abs < self accuracy]) 
			and: [(n - aTransformation n) abs < self accuracy]) 
			and: [(s - aTransformation s) abs < self accuracy]
]

{ #category : #accessing }
Jun3dTransformation >> f [
	^f
]

{ #category : #accessing }
Jun3dTransformation >> g [
	^g
]

{ #category : #accessing }
Jun3dTransformation >> h [
	^h
]

{ #category : #comparing }
Jun3dTransformation >> hash [
	^(a + b + c + p + d + e + f + q + g + h + i + r + l + m + n) hash
]

{ #category : #accessing }
Jun3dTransformation >> i [
	^i
]

{ #category : #testing }
Jun3dTransformation >> is3d [
	^true
]

{ #category : #accessing }
Jun3dTransformation >> l [
	^l
]

{ #category : #accessing }
Jun3dTransformation >> m [
	^m
]

{ #category : #accessing }
Jun3dTransformation >> n [
	^n
]

{ #category : #accessing }
Jun3dTransformation >> p [
	^p
]

{ #category : #printing }
Jun3dTransformation >> printOn: aStream [ 
	aStream nextPutAll: self class printString.
	aStream nextPutAll: ' ('.
	a printOn: aStream.
	aStream nextPutAll: ' '.
	b printOn: aStream.
	aStream nextPutAll: ' '.
	c printOn: aStream.
	aStream nextPutAll: ' '.
	p printOn: aStream.
	aStream nextPutAll: ' , '.
	d printOn: aStream.
	aStream nextPutAll: ' '.
	e printOn: aStream.
	aStream nextPutAll: ' '.
	f printOn: aStream.
	aStream nextPutAll: ' '.
	q printOn: aStream.
	aStream nextPutAll: ' , '.
	g printOn: aStream.
	aStream nextPutAll: ' '.
	h printOn: aStream.
	aStream nextPutAll: ' '.
	i printOn: aStream.
	aStream nextPutAll: ' '.
	r printOn: aStream.
	aStream nextPutAll: ' , '.
	l printOn: aStream.
	aStream nextPutAll: ' '.
	m printOn: aStream.
	aStream nextPutAll: ' '.
	n printOn: aStream.
	aStream nextPutAll: ' '.
	s printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'transforming functions' }
Jun3dTransformation >> product: aTransformation [ 
	| transformation |
	transformation := self class basicNew.
	transformation setA: a * aTransformation a + (b * aTransformation d) + (c * aTransformation g) + (p * aTransformation l).
	transformation setB: a * aTransformation b + (b * aTransformation e) + (c * aTransformation h) + (p * aTransformation m).
	transformation setC: a * aTransformation c + (b * aTransformation f) + (c * aTransformation i) + (p * aTransformation n).
	transformation setP: a * aTransformation p + (b * aTransformation q) + (c * aTransformation r) + (p * aTransformation s).
	transformation setD: d * aTransformation a + (e * aTransformation d) + (f * aTransformation g) + (q * aTransformation l).
	transformation setE: d * aTransformation b + (e * aTransformation e) + (f * aTransformation h) + (q * aTransformation m).
	transformation setF: d * aTransformation c + (e * aTransformation f) + (f * aTransformation i) + (q * aTransformation n).
	transformation setQ: d * aTransformation p + (e * aTransformation q) + (f * aTransformation r) + (q * aTransformation s).
	transformation setG: g * aTransformation a + (h * aTransformation d) + (i * aTransformation g) + (r * aTransformation l).
	transformation setH: g * aTransformation b + (h * aTransformation e) + (i * aTransformation h) + (r * aTransformation m).
	transformation setI: g * aTransformation c + (h * aTransformation f) + (i * aTransformation i) + (r * aTransformation n).
	transformation setR: g * aTransformation p + (h * aTransformation q) + (i * aTransformation r) + (r * aTransformation s).
	transformation setL: l * aTransformation a + (m * aTransformation d) + (n * aTransformation g) + (s * aTransformation l).
	transformation setM: l * aTransformation b + (m * aTransformation e) + (n * aTransformation h) + (s * aTransformation m).
	transformation setN: l * aTransformation c + (m * aTransformation f) + (n * aTransformation i) + (s * aTransformation n).
	transformation setS: l * aTransformation p + (m * aTransformation q) + (n * aTransformation r) + (s * aTransformation s).
	^transformation
]

{ #category : #accessing }
Jun3dTransformation >> q [
	^q
]

{ #category : #accessing }
Jun3dTransformation >> r [
	^r
]

{ #category : #function }
Jun3dTransformation >> rotationAngle [
	^JunAngle fromRad: (a + e + i - 1 / 2) arcCos
]

{ #category : #function }
Jun3dTransformation >> rotationVector [
	| denominator |
	denominator := (f - h ** 2 + (c - g) ** 2 + (b - d) ** 2) sqrt.
	^Jun3dPoint
		x: h - f / denominator
		y: c - g / denominator
		z: d - b / denominator
]

{ #category : #accessing }
Jun3dTransformation >> s [
	^s
]

{ #category : #private }
Jun3dTransformation >> setA: aNumber [ 
	a := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setB: aNumber [ 
	b := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setC: aNumber [ 
	c := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setD: aNumber [ 
	d := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setE: aNumber [ 
	e := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setF: aNumber [ 
	f := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setFromArray: anArray [ 
	self
		setA: (anArray at: 1);
		setB: (anArray at: 2);
		setC: (anArray at: 3);
		setP: (anArray at: 4).
	self
		setD: (anArray at: 5);
		setE: (anArray at: 6);
		setF: (anArray at: 7);
		setQ: (anArray at: 8).
	self
		setG: (anArray at: 9);
		setH: (anArray at: 10);
		setI: (anArray at: 11);
		setR: (anArray at: 12).
	self
		setL: (anArray at: 13);
		setM: (anArray at: 14);
		setN: (anArray at: 15);
		setS: (anArray at: 16)
]

{ #category : #private }
Jun3dTransformation >> setG: aNumber [ 
	g := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setH: aNumber [ 
	h := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setI: aNumber [ 
	i := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setL: aNumber [ 
	l := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setM: aNumber [ 
	m := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setN: aNumber [ 
	n := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setP: aNumber [ 
	p := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setQ: aNumber [ 
	q := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setR: aNumber [ 
	r := aNumber asDouble
]

{ #category : #private }
Jun3dTransformation >> setS: aNumber [ 
	s := aNumber asDouble
]

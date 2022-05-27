"
Imported by VwImportClass
"
Class {
	#name : #JunTransformationInterval,
	#superclass : #Object,
	#instVars : [
		'transformationReference',
		'startArray',
		'stopArray',
		'differenceArray'
	],
	#category : #'Jun-Geometry-Transformations'
}

{ #category : #copyright }
JunTransformationInterval class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunTransformationInterval class >> example1 [
	"JunTransformationInterval example1."

	| transformationInteval |
	Transcript clear.
	transformationInteval := JunTransformationInterval
				to: (((Jun2dTransformation scale: 1 , 2) product: (Jun2dTransformation rotate: (JunAngle degrees: 120) around: 0 , 0))
						product: (Jun2dTransformation translate: 7 , 0)).
	(0 to: 1 by: 0.1) do: 
			[:normalizedValue |
			| aTransformation |
			aTransformation := transformationInteval atT: normalizedValue.
			Transcript
				nextPutAll: aTransformation printString;
				cr;
				flush].
	^transformationInteval
]

{ #category : #examples }
JunTransformationInterval class >> example2 [
	"JunTransformationInterval example2."

	| transformationInteval |
	Transcript clear.
	transformationInteval := JunTransformationInterval
				to: (((Jun3dTransformation scale: 1 , 2 , 3)
						product: (Jun3dTransformation rotate: (JunAngle degrees: 120) around: (0 , 0 , 0 to: 1 , 1 , 1)))
							product: (Jun3dTransformation translate: 7 , 0 , 0)).
	(0 to: 1 by: 0.1) do: 
			[:normalizedValue |
			| aTransformation |
			aTransformation := transformationInteval atT: normalizedValue.
			Transcript
				nextPutAll: aTransformation printString;
				cr;
				flush].
	^transformationInteval
]

{ #category : #examples }
JunTransformationInterval class >> example3 [
	"JunTransformationInterval example3."

	| aBody aCube aModel transformationInteval |
	aBody := JunOpenGL3dCompoundObject new.
	aBody add: (aCube := JunOpenGL3dTransformedObject object: JunOpenGL3dObject colorCube).
	aBody add: (JunOpenGL3dObject xyzArrows scaledBy: 10).
	aModel := JunOpenGLDisplayModel displayObject: aBody.
	aModel openWithExtent: 500 @ 500.
	transformationInteval := JunTransformationInterval
				to: (((Jun3dTransformation scale: 1 , 2 , 3)
						product: (Jun3dTransformation rotate: (JunAngle degrees: 120) around: (0 , 0 , 0 to: 1 , 1 , 1)))
							product: (Jun3dTransformation translate: 7 , 0 , 0)).
	(0 to: 1 by: 0.005) do: 
			[:normalizedValue |
			| aTransformation |
			aTransformation := transformationInteval atT: normalizedValue.
			aCube transformation: aTransformation.
			aModel changed: #object].
	^aModel
]

{ #category : #'instance creation' }
JunTransformationInterval class >> from: fromTransformation to: toTransformation [

	| transformationInterval |
	transformationInterval := (self new)
				initialize;
				yourself.
	transformationInterval
		startTransformation: fromTransformation;
		stopTransformation: toTransformation.
	^transformationInterval
]

{ #category : #copyright }
JunTransformationInterval class >> system [
	^'Jun'
]

{ #category : #'instance creation' }
JunTransformationInterval class >> to: toTransformation [

	^self from: toTransformation class unity to: toTransformation
]

{ #category : #copyright }
JunTransformationInterval class >> version [
	^'799'
]

{ #category : #'parametric accessing' }
JunTransformationInterval >> atT: t [

	| anArray anIndex |
	t = 0 ifTrue: [^self startTransformation].
	t = 1 ifTrue: [^self stopTransformation].
	anArray := Array new: self differenceArray size.
	anIndex := 1.
	startArray with: differenceArray
		do: 
			[:startValue :differenceValue |
			anArray at: anIndex put: startValue + (differenceValue * t).
			anIndex := anIndex + 1].
	^transformationReference value fromArray: anArray
]

{ #category : #private }
JunTransformationInterval >> differenceArray [

	differenceArray
		ifNil: 
			[| anArray anIndex |
			anArray := Array new: startArray size.
			anIndex := 1.
			startArray with: stopArray
				do: 
					[:startValue :stopValue |
					anArray at: anIndex put: stopValue - startValue.
					anIndex := anIndex + 1].
			differenceArray := anArray].
	^differenceArray
]

{ #category : #'initialize-release' }
JunTransformationInterval >> initialize [

	super initialize.
	transformationReference := nil.
	startArray := nil.
	stopArray := nil.
	differenceArray := nil.
	^self
]

{ #category : #accessing }
JunTransformationInterval >> startTransformation [

	^transformationReference value fromArray: startArray
]

{ #category : #accessing }
JunTransformationInterval >> startTransformation: aTransformation [

	startArray := aTransformation asArray
]

{ #category : #accessing }
JunTransformationInterval >> stopTransformation [

	^transformationReference value fromArray: stopArray
]

{ #category : #accessing }
JunTransformationInterval >> stopTransformation: aTransformation [

	stopArray := aTransformation asArray.
	transformationReference := LiteralBindingReference pathString: aTransformation class fullName
]

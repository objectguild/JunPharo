"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLShowController,
	#superclass : #JunAbstractControllerWithMenu,
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLShowController class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunOpenGLShowController class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLShowController class >> version [
	^'799'
]

{ #category : #'control defaults' }
JunOpenGLShowController >> bullActivity [
	| currentPoint previousPoint |
	self flushMovementVector.
	currentPoint := self mouse2dPoint.
	previousPoint := currentPoint.
	[self sensor redButtonPressed]
		whileTrue: 
			[currentPoint := self mouse2dPoint.
			currentPoint = previousPoint
				ifFalse: 
					[self model bull: currentPoint xy: previousPoint.
					previousPoint := currentPoint].
			Processor yield]
]

{ #category : #debug }
JunOpenGLShowController >> debug: aBlock [ 
	"aBlock value"
]

{ #category : #movements }
JunOpenGLShowController >> displayController [
	| displayView |
	displayView := self model displayModel dependents detect: [:each | each isKindOf: JunOpenGLDisplayView]
				ifNone: [nil].
	displayView isNil ifTrue: [^nil].
	^displayView controller
]

{ #category : #'control defaults' }
JunOpenGLShowController >> dragActivity [
	| currentPoint previousPoint |
	currentPoint := self mouse2dPoint.
	previousPoint := currentPoint.
	[self sensor redButtonPressed]
		whileTrue: 
			[currentPoint := self mouse2dPoint.
			currentPoint = previousPoint
				ifFalse: 
					[self model drag: previousPoint xy: currentPoint.
					previousPoint := currentPoint].
			Processor yield]
]

{ #category : #movements }
JunOpenGLShowController >> flushMovementVector [
	| displayController |
	displayController := self displayController.
	displayController notNil ifTrue: [displayController flushMovementVector]
]

{ #category : #'control defaults' }
JunOpenGLShowController >> grabActivity [
	| currentPoint previousPoint |
	currentPoint := self mouse2dPoint.
	previousPoint := currentPoint.
	[self sensor anyButtonPressed]
		whileTrue: 
			[currentPoint := self mouse2dPoint.
			currentPoint = previousPoint
				ifFalse: 
					[self model grab: previousPoint xy: currentPoint.
					previousPoint := currentPoint].
			Processor yield]
]

{ #category : #'initialize-release' }
JunOpenGLShowController >> initialize [
	super initialize
]

{ #category : #private }
JunOpenGLShowController >> mouse2dPoint [
	| aPoint |
	aPoint := Jun2dPoint coerce: (self regularizePoint: self sensor mousePoint).
	^aPoint
]

{ #category : #events }
JunOpenGLShowController >> mouseMovedEvent: event [ 
	self viewHasCursor
		ifTrue: 
			[| state |
			state := self model buttonState.
			state = #bull ifTrue: [Cursor bull show].
			state = #grab ifTrue: [JunCursors handCursor show].
			state = #drag ifTrue: [JunCursors quartersCursor show]]
		ifFalse: [Cursor normal show].
	^nil
]

{ #category : #'control defaults' }
JunOpenGLShowController >> redButtonActivity [
	| state |
	state := self model buttonState.
	state = #bull ifTrue: [^Cursor bull showWhile: [self bullActivity]].
	state = #grab ifTrue: [^JunCursors handCursor showWhile: [self grabActivity]].
	state = #drag ifTrue: [^JunCursors quartersCursor showWhile: [self dragActivity]]
]

{ #category : #private }
JunOpenGLShowController >> regularizePoint: aPoint [ 
	^self model regularizePoint: aPoint in: self view bounds
]

{ #category : #'initialize-release' }
JunOpenGLShowController >> release [
	super release.
	view := nil.
	Cursor normal show
]

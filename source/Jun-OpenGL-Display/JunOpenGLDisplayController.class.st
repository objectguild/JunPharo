"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLDisplayController,
	#superclass : #JunAbstractControllerWithMenu,
	#instVars : [
		'movementVector',
		'movementProcess'
	],
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLDisplayController class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunOpenGLDisplayController class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLDisplayController class >> version [
	^'799'
]

{ #category : #'control defaults' }
JunOpenGLDisplayController >> controlActivity [
	self model noControl ifTrue: [^self].
	super controlActivity
]

{ #category : #movements }
JunOpenGLDisplayController >> createMovementProcess [
	self useMovementProcess ifFalse: [^nil].
	movementProcess := 
			[| aVector |
			[view ~~ nil 
				and: [(aVector := self movementVector) ~~ nil and: [aVector isZero not]]] 
					whileTrue: 
						[self model do: 
								[self errorSignal handle: [:exception | exception return]
									do: [self model grab: aVector]]
							forMilliseconds: 83.	"12Hz : 83 = ((1 / 12) asFloat * 1000) rounded"
						Processor yield]] 
					newProcess.
	movementProcess priority: Processor activeProcess priority - 1.
	movementProcess resume
]

{ #category : #debug }
JunOpenGLDisplayController >> debug: aBlock [ 
	"aBlock value"
]

{ #category : #'control defaults' }
JunOpenGLDisplayController >> dragActivity [
	| currentPoint previousPoint |
	self flushMovementVector.
	currentPoint := self mouse2dPoint.
	previousPoint := currentPoint.
	[self sensor anyButtonPressed]
		whileTrue: 
			[currentPoint := self mouse2dPoint.
			currentPoint = previousPoint
				ifFalse: 
					[self model drag: previousPoint xy: currentPoint.
					previousPoint := currentPoint].
			Processor yield]
]

{ #category : #movements }
JunOpenGLDisplayController >> flushMovementVector [
	movementVector := nil.
	Processor yield.
	(Delay forMilliseconds: 1) wait.
	movementProcess ifNotNil: 
			[movementProcess terminate.
			movementProcess := nil]
]

{ #category : #'control defaults' }
JunOpenGLDisplayController >> focusActivity [
	| aRatio |
	self flushMovementVector.
	aRatio := self view bounds width / self view bounds height.
	self model focus: (Rectangle origin: aRatio negated @ -1 corner: aRatio @ 1)
		to: self mouse2dRectangle
]

{ #category : #'control defaults' }
JunOpenGLDisplayController >> grabActivity [
	| currentPoint previousPoint |
	self 
		assert: [self flushMovementVector]
		do: 
			[currentPoint := self mouse2dPoint.
			previousPoint := currentPoint.
			[self sensor anyButtonPressed] whileTrue: 
					[currentPoint := self mouse2dPoint.
					currentPoint = previousPoint 
						ifFalse: 
							[self model grab: previousPoint xy: currentPoint.
							previousPoint := currentPoint].
					Processor yield]]
		ensure: 
			[(Delay forMilliseconds: 50) wait.
			currentPoint := self mouse2dPoint.
			currentPoint = previousPoint 
				ifFalse: 
					[self movementVector: currentPoint - previousPoint.
					self createMovementProcess]]
]

{ #category : #'initialize-release' }
JunOpenGLDisplayController >> initialize [
	super initialize.
	movementVector := nil.
	movementProcess := nil
]

{ #category : #private }
JunOpenGLDisplayController >> mouse2dLineSegment [
	| offset lineSegment |
	offset := self sensor mousePoint - InputSensor cursorPoint.
	lineSegment := LineSegment fromUser translatedBy: offset.
	^Jun2dLine from: (self regularizePoint: lineSegment start)
		to: (self regularizePoint: lineSegment end)
]

{ #category : #private }
JunOpenGLDisplayController >> mouse2dPoint [
	| aPoint |
	aPoint := Jun2dPoint coerce: (self regularizePoint: self sensor mousePoint).
	^aPoint
]

{ #category : #private }
JunOpenGLDisplayController >> mouse2dRectangle [
	| localPoint globalPoint aRectangle aSymbol expandSize originPoint cornerPoint |
	localPoint := self sensor mousePoint.
	globalPoint := InputSensor cursorPoint.
	aRectangle := Screen default
				resizeRectangle: (Rectangle origin: globalPoint extent: 1 @ 1)
				minimumExtent: 1 @ 1
				resizeIncrement: 1 @ 1
				boundedBy: nil
				whileButton: 0
				isDown: true.
	aSymbol := #(#topLeft #topRight #bottomLeft #bottomRight) detect: [:each | globalPoint = (aRectangle perform: each)]
				ifNone: [#center].
	aRectangle := aRectangle align: (aRectangle perform: aSymbol)
				with: localPoint.
	aRectangle height <= 2
		ifTrue: 
			[expandSize := self view bounds height // 4 max: 8.
			aRectangle := aRectangle expandedBy: expandSize].
	originPoint := self regularizePoint: aRectangle origin.
	cornerPoint := self regularizePoint: aRectangle corner.
	^Rectangle origin: originPoint corner: cornerPoint
]

{ #category : #events }
JunOpenGLDisplayController >> mouseMovedEvent: event [ 
	self viewHasCursor
		ifTrue: 
			[| state |
			state := self model buttonState.
			state = #pick ifTrue: [JunCursors crossCursor show].
			state = #grab ifTrue: [JunCursors handCursor show].
			state = #drag ifTrue: [JunCursors quartersCursor show].
			state = #focus ifTrue: [JunCursors glassCursor show]]
		ifFalse: [Cursor normal show].
	^nil
]

{ #category : #events }
JunOpenGLDisplayController >> mouseWheelEvent: event [ 
	self model noControl ifTrue: [^self].
	self model 
		wheel: event up
		at: self sensor cursorPoint
		in: self view bounds.
	^nil
]

{ #category : #movements }
JunOpenGLDisplayController >> movementVector [
	^movementVector
]

{ #category : #movements }
JunOpenGLDisplayController >> movementVector: aPoint [ 
	aPoint ifNil: [movementVector := nil]
		ifNotNil: 
			[| x y |
			x := -1 max: (aPoint x min: 1).
			y := -1 max: (aPoint y min: 1).
			movementVector := x , y]
]

{ #category : #'control defaults' }
JunOpenGLDisplayController >> pickActivity [
	self flushMovementVector.
	self model pick: self mouse2dPoint.
	JunSensorUtility waitNoButton
]

{ #category : #'control defaults' }
JunOpenGLDisplayController >> pressActivity [
	| currentPoint previousPoint |
	self flushMovementVector.
	currentPoint := self mouse2dPoint.
	self model pressBegin: currentPoint.
	previousPoint := nil.
	[self sensor anyButtonPressed] whileTrue: 
			[currentPoint := self mouse2dPoint.
			currentPoint = previousPoint 
				ifFalse: 
					[self model press: currentPoint.
					previousPoint := currentPoint].
			Processor yield].
	currentPoint := self mouse2dPoint.
	self model pressEnd: currentPoint
]

{ #category : #'control defaults' }
JunOpenGLDisplayController >> redButtonActivity [
	| state |
	state := self model buttonState.
	state = #pick 
		ifTrue: [^JunCursors crossCursor showWhile: [self pickActivity]].
	state = #grab 
		ifTrue: [^JunCursors handCursor showWhile: [self grabActivity]].
	state = #drag 
		ifTrue: [^JunCursors quartersCursor showWhile: [self dragActivity]].
	state = #focus 
		ifTrue: [^JunCursors glassCursor showWhile: [self focusActivity]].
	self model usePressActivity ifTrue: [self pressActivity]
]

{ #category : #private }
JunOpenGLDisplayController >> regularizePoint: aPoint [ 
	^self model regularizePoint: aPoint in: self view bounds
]

{ #category : #'initialize-release' }
JunOpenGLDisplayController >> release [
	super release.
	self flushMovementVector.
	view := nil.
	Cursor normal show
]

{ #category : #movements }
JunOpenGLDisplayController >> useMovementProcess [
	^self model useMovementProcess
]

{ #category : #movements }
JunOpenGLDisplayController >> useMovementProcess: aBoolean [ 
	self model useMovementProcess: aBoolean
]

{ #category : #'control defaults' }
JunOpenGLDisplayController >> yellowButtonActivity [
	self yellowButtonShiftActivity ifTrue: [^nil].
	self flushMovementVector.
	self model useYellowButtonMenu 
		ifTrue: [self processMenuAt: self sensor globalCursorPoint centered: true]
]

"
Imported by VwImportClass
"
Class {
	#name : #JunAbstractController,
	#superclass : #Controller,
	#instVars : [
		'pressedEvent'
	],
	#category : #'Jun-System-Framework'
}

{ #category : #evaluating }
JunAbstractController class >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	^JunControlUtility 
		assert: assertBlock
		do: doBlock
		ensure: ensureBlock
]

{ #category : #copyright }
JunAbstractController class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #evaluating }
JunAbstractController class >> do: aBlock during: millisecondTime [ 
	^JunControlUtility do: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractController class >> do: doBlock ensure: ensureBlock [ 
	^JunControlUtility do: doBlock ensure: ensureBlock
]

{ #category : #evaluating }
JunAbstractController class >> do: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility do: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractController class >> do: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility do: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunAbstractController class >> do: aBlock framesPerSecond: aNumber [ 
	^JunControlUtility do: aBlock framesPerSecond: aNumber
]

{ #category : #evaluating }
JunAbstractController class >> fork: aBlock during: millisecondTime [ 
	^JunControlUtility fork: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractController class >> fork: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility fork: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractController class >> fork: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility fork: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunAbstractController class >> punctuallyDo: aBlock during: millisecondTime [ 
	^JunControlUtility punctuallyDo: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractController class >> punctuallyDo: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility punctuallyDo: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractController class >> punctuallyDo: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility punctuallyDo: aBlock forMilliseconds: millisecondTime
]

{ #category : #copyright }
JunAbstractController class >> system [
	^'Jun'
]

{ #category : #copyright }
JunAbstractController class >> version [
	^'799'
]

{ #category : #evaluating }
JunAbstractController >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	^self class 
		assert: assertBlock
		do: doBlock
		ensure: ensureBlock
]

{ #category : #'control defaults' }
JunAbstractController >> controlActivity [
	(self sensor redButtonPressed and: [self viewHasCursor])
		ifTrue: [^self redButtonActivity].
	(self sensor yellowButtonPressed and: [self viewHasCursor])
		ifTrue: [^self yellowButtonActivity]
]

{ #category : #evaluating }
JunAbstractController >> do: aBlock during: millisecondTime [ 
	^self class do: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractController >> do: doBlock ensure: ensureBlock [ 
	^self class do: doBlock ensure: ensureBlock
]

{ #category : #evaluating }
JunAbstractController >> do: aBlock forMicroseconds: microsecondTime [ 
	^self class do: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractController >> do: aBlock forMilliseconds: millisecondTime [ 
	^self class do: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunAbstractController >> do: aBlock framesPerSecond: aNumber [ 
	^self class do: aBlock framesPerSecond: aNumber
]

{ #category : #events }
JunAbstractController >> exitEvent: event [ 
	Cursor normal show.
	^nil
]

{ #category : #evaluating }
JunAbstractController >> fork: aBlock during: millisecondTime [ 
	^self class fork: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractController >> fork: aBlock forMicroseconds: microsecondTime [ 
	^self class fork: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractController >> fork: aBlock forMilliseconds: millisecondTime [ 
	^self class fork: aBlock forMilliseconds: millisecondTime
]

{ #category : #'event driven' }
JunAbstractController >> handleEvent: event [ 
	self view ifNotNil: 
			[:aView | 
			aView topComponent 
				ifNotNil: [:aWindow | aWindow isActive ifFalse: [aWindow becomeActive]]].
	event dispatchTo: self
]

{ #category : #events }
JunAbstractController >> mouseMovedEvent: event [ 
	self controlActivity.
	^nil
]

{ #category : #evaluating }
JunAbstractController >> punctuallyDo: aBlock during: millisecondTime [ 
	^self class punctuallyDo: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractController >> punctuallyDo: aBlock forMicroseconds: microsecondTime [ 
	^self class punctuallyDo: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractController >> punctuallyDo: aBlock forMilliseconds: millisecondTime [ 
	^self class punctuallyDo: aBlock forMilliseconds: millisecondTime
]

{ #category : #'control defaults' }
JunAbstractController >> redButtonActivity [
	^self
]

{ #category : #events }
JunAbstractController >> redButtonPressedEvent: event [

	pressedEvent := event.
	self controlActivity.
	^nil
]

{ #category : #cursor }
JunAbstractController >> viewHasCursor [
	view == nil ifTrue: [^false].
	view isOpen ifFalse: [^false].
	^self sensor ifNil: [false]
		ifNotNil: 
			[:aSensor | 
			aSensor isActive and: 
					[| aRectangle |
					aRectangle := view bounds intersect: view graphicsContext clippingBounds.
					aRectangle containsPoint: aSensor cursorPoint]]
]

{ #category : #'control defaults' }
JunAbstractController >> yellowButtonActivity [
	self yellowButtonShiftActivity ifTrue: [^nil]
]

{ #category : #events }
JunAbstractController >> yellowButtonPressedEvent: event [

	pressedEvent := event.
	self controlActivity.
	^nil
]

{ #category : #'control defaults' }
JunAbstractController >> yellowButtonShiftActivity [

	(self sensor shiftDown and: [self model respondsTo: #inspectModel])
		ifTrue: 
			[| aMenu selectedItem |
			aMenu := Menu labels: (#jun_Inspect >> 'Inspect') asString
						values: #(#inspectModel).
			selectedItem := self trackMenu: aMenu event: pressedEvent.
			selectedItem value ifNotNil: [:aSelector | self model perform: aSelector].
			^true].
	^false
]

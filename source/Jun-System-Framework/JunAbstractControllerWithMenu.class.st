"
Imported by VwImportClass
"
Class {
	#name : #JunAbstractControllerWithMenu,
	#superclass : #ControllerWithMenu,
	#instVars : [
		'pressedEvent'
	],
	#category : #'Jun-System-Framework'
}

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	^JunControlUtility 
		assert: assertBlock
		do: doBlock
		ensure: ensureBlock
]

{ #category : #copyright }
JunAbstractControllerWithMenu class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> do: aBlock during: millisecondTime [ 
	^JunControlUtility do: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> do: doBlock ensure: ensureBlock [ 
	^JunControlUtility do: doBlock ensure: ensureBlock
]

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> do: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility do: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> do: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility do: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> do: aBlock framesPerSecond: aNumber [ 
	^JunControlUtility do: aBlock framesPerSecond: aNumber
]

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> fork: aBlock during: millisecondTime [ 
	^JunControlUtility fork: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> fork: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility fork: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> fork: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility fork: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> punctuallyDo: aBlock during: millisecondTime [ 
	^JunControlUtility punctuallyDo: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> punctuallyDo: aBlock forMicroseconds: microsecondTime [ 
	^JunControlUtility punctuallyDo: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu class >> punctuallyDo: aBlock forMilliseconds: millisecondTime [ 
	^JunControlUtility punctuallyDo: aBlock forMilliseconds: millisecondTime
]

{ #category : #copyright }
JunAbstractControllerWithMenu class >> system [
	^'Jun'
]

{ #category : #copyright }
JunAbstractControllerWithMenu class >> version [
	^'799'
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> assert: assertBlock do: doBlock ensure: ensureBlock [ 
	^self class 
		assert: assertBlock
		do: doBlock
		ensure: ensureBlock
]

{ #category : #'control defaults' }
JunAbstractControllerWithMenu >> controlActivity [
	(self sensor redButtonPressed and: [self viewHasCursor])
		ifTrue: [^self redButtonActivity].
	(self sensor yellowButtonPressed and: [self viewHasCursor])
		ifTrue: [^self yellowButtonActivity]
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> do: aBlock during: millisecondTime [ 
	^self class do: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> do: doBlock ensure: ensureBlock [ 
	^self class do: doBlock ensure: ensureBlock
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> do: aBlock forMicroseconds: microsecondTime [ 
	^self class do: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> do: aBlock forMilliseconds: millisecondTime [ 
	^self class do: aBlock forMilliseconds: millisecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> do: aBlock framesPerSecond: aNumber [ 
	^self class do: aBlock framesPerSecond: aNumber
]

{ #category : #events }
JunAbstractControllerWithMenu >> exitEvent: event [ 
	Cursor normal show.
	^nil
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> fork: aBlock during: millisecondTime [ 
	^self class fork: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> fork: aBlock forMicroseconds: microsecondTime [ 
	^self class fork: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> fork: aBlock forMilliseconds: millisecondTime [ 
	^self class fork: aBlock forMilliseconds: millisecondTime
]

{ #category : #'event driven' }
JunAbstractControllerWithMenu >> handleEvent: event [ 
	self view ifNotNil: 
			[:aView | 
			aView topComponent 
				ifNotNil: [:aWindow | aWindow isActive ifFalse: [aWindow becomeActive]]].
	event dispatchTo: self
]

{ #category : #events }
JunAbstractControllerWithMenu >> mouseMovedEvent: event [ 
	self controlActivity.
	^nil
]

{ #category : #'menu processing' }
JunAbstractControllerWithMenu >> processMenuAt: aPoint centered: aBoolean [

	| aMenu selectedItem |
	self view ifNil: [^self].
	aMenu := self menu.
	aMenu ifNil: [^self].
	aMenu setDynamicPropertiesFrom: self.
	self triggerPopupMenuCreated.
	selectedItem := self trackMenu: aMenu event: pressedEvent.
	selectedItem value
		ifNotNil: 
			[self triggerPopupMenuItemSelected: selectedItem nameKey.
			self dispatchMenuSelection: selectedItem]
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> punctuallyDo: aBlock during: millisecondTime [ 
	^self class punctuallyDo: aBlock during: millisecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> punctuallyDo: aBlock forMicroseconds: microsecondTime [ 
	^self class punctuallyDo: aBlock forMicroseconds: microsecondTime
]

{ #category : #evaluating }
JunAbstractControllerWithMenu >> punctuallyDo: aBlock forMilliseconds: millisecondTime [ 
	^self class punctuallyDo: aBlock forMilliseconds: millisecondTime
]

{ #category : #'control defaults' }
JunAbstractControllerWithMenu >> redButtonActivity [
	^self
]

{ #category : #events }
JunAbstractControllerWithMenu >> redButtonPressedEvent: event [

	pressedEvent := event.
	self controlActivity.
	^nil
]

{ #category : #cursor }
JunAbstractControllerWithMenu >> viewHasCursor [
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
JunAbstractControllerWithMenu >> yellowButtonActivity [
	self yellowButtonShiftActivity ifTrue: [^nil].
	^self processMenuAt: self sensor globalCursorPoint centered: true
]

{ #category : #events }
JunAbstractControllerWithMenu >> yellowButtonPressedEvent: event [

	pressedEvent := event.
	self controlActivity.
	^nil
]

{ #category : #'control defaults' }
JunAbstractControllerWithMenu >> yellowButtonShiftActivity [

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

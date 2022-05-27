"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLAngledDisplayView,
	#superclass : #JunOpenGLDisplayView,
	#instVars : [
		'angle'
	],
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLAngledDisplayView class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunOpenGLAngledDisplayView class >> model: aModel angle: anAngle [ 
	| aView |
	aView := self model: aModel.
	aView angle: anAngle.
	^aView
]

{ #category : #copyright }
JunOpenGLAngledDisplayView class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLAngledDisplayView class >> version [
	^'799'
]

{ #category : #accessing }
JunOpenGLAngledDisplayView >> angle [
	^angle
]

{ #category : #accessing }
JunOpenGLAngledDisplayView >> angle: anAngle [ 
	angle := anAngle
]

{ #category : #rendering }
JunOpenGLAngledDisplayView >> renderOn: renderingContext [ 
	angle notNil 
		ifTrue: [self model renderOn: renderingContext angle: angle]
		ifFalse: [self model renderOn: renderingContext]
]

{ #category : #rendering }
JunOpenGLAngledDisplayView >> renderOn: renderingContext withDisplayList: aDisplayListHolder [ 
	angle notNil 
		ifTrue: 
			[self model 
				renderOn: renderingContext
				angle: angle
				withDisplayList: aDisplayListHolder]
		ifFalse: 
			[self model renderOn: renderingContext withDisplayList: aDisplayListHolder]
]

{ #category : #updating }
JunOpenGLAngledDisplayView >> update: aspectSymbol with: aParameter from: aSender [ 
	| aContext aBlock |
	aContext := thisContext.
	aBlock := nil.
	aBlock := 
			[:context | 
			(aContext receiver == context receiver 
				and: [aContext selector == context selector and: [aspectSymbol = #crossing]]) 
					ifTrue: [^self].
			context sender isNil ifFalse: [aBlock value: context sender]].
	aBlock value: aContext sender.
	self isOpen ifFalse: [^self].
	aspectSymbol = #crossing ifTrue: [^self redisplay].
	super 
		update: aspectSymbol
		with: aParameter
		from: aSender
]

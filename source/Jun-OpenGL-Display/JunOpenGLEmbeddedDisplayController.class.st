"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLEmbeddedDisplayController,
	#superclass : #JunOpenGLDisplayController,
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLEmbeddedDisplayController class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunOpenGLEmbeddedDisplayController class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLEmbeddedDisplayController class >> version [
	^'799'
]

{ #category : #'control defaults' }
JunOpenGLEmbeddedDisplayController >> yellowButtonActivity [
	self yellowButtonShiftActivity ifTrue: [^nil].
	self flushMovementVector.
	^self processMenuAt: self sensor globalCursorPoint centered: true
]

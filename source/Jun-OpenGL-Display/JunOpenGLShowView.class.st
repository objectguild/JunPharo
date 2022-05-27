"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLShowView,
	#superclass : #JunOpenGLDisplayView,
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLShowView class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunOpenGLShowView class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLShowView class >> version [
	^'799'
]

{ #category : #'controller accessing' }
JunOpenGLShowView >> defaultControllerClass [
	^JunOpenGLShowController
]

{ #category : #updating }
JunOpenGLShowView >> update: aspectSymbol with: aParameter from: aSender [ 
	self isOpen 
		ifTrue: 
			[aspectSymbol = #object ifTrue: [^self displayOn: self graphicsContext].
			aspectSymbol = #light ifTrue: [^self displayOn: self graphicsContext].
			aspectSymbol = #projection ifTrue: [^self displayOn: self graphicsContext].
			aspectSymbol = #presentation 
				ifTrue: [^self displayOn: self graphicsContext].
			aspectSymbol = #shading ifTrue: [^self displayOn: self graphicsContext].
			aspectSymbol = #selection ifTrue: [^self displayOn: self graphicsContext].
			aspectSymbol = #state ifTrue: [^self].
			aspectSymbol = #texture ifTrue: [^self displayOn: self graphicsContext]].
	super update: aspectSymbol with: aParameter
]

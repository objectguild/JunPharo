"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGL3dPrimitiveObject,
	#superclass : #JunOpenGL3dObject,
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #copyright }
JunOpenGL3dPrimitiveObject class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunOpenGL3dPrimitiveObject class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGL3dPrimitiveObject class >> version [
	^'799'
]

{ #category : #converting }
JunOpenGL3dPrimitiveObject >> asCompoundObject [
	| compoundObject |
	compoundObject := JunOpenGL3dCompoundObject new.
	compoundObject add: self.
	^compoundObject
]

{ #category : #establishing }
JunOpenGL3dPrimitiveObject >> establishAllNormalVectors [
	self establishNormalVectors
]

{ #category : #flushing }
JunOpenGL3dPrimitiveObject >> flushAllAlphas [
	self flushAlpha
]

{ #category : #flushing }
JunOpenGL3dPrimitiveObject >> flushAllBounds [
	self flushBounds
]

{ #category : #flushing }
JunOpenGL3dPrimitiveObject >> flushAllColors [
	self flushColors
]

{ #category : #flushing }
JunOpenGL3dPrimitiveObject >> flushAllNames [
	self flushName
]

{ #category : #flushing }
JunOpenGL3dPrimitiveObject >> flushAllNormalVectors [
	self flushNormalVectors
]

{ #category : #flushing }
JunOpenGL3dPrimitiveObject >> flushAllPaints [
	self flushPaint
]

{ #category : #testing }
JunOpenGL3dPrimitiveObject >> isPrimitive [
	^true
]

{ #category : #utilities }
JunOpenGL3dPrimitiveObject >> numberOfPrimitives [
	^1
]

{ #category : #enumerating }
JunOpenGL3dPrimitiveObject >> objectsDo: aBlock [ 
	aBlock value: self
]

{ #category : #enumerating }
JunOpenGL3dPrimitiveObject >> pointsDo: aBlock [ 
	^self
]

{ #category : #enumerating }
JunOpenGL3dPrimitiveObject >> polygonsDo: aBlock [ 
	^self
]

{ #category : #enumerating }
JunOpenGL3dPrimitiveObject >> polylinesDo: aBlock [ 
	^self
]

{ #category : #enumerating }
JunOpenGL3dPrimitiveObject >> primitivesDo: aBlock [ 
	aBlock value: self
]

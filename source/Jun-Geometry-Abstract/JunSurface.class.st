"
Imported by VwImportClass
"
Class {
	#name : #JunSurface,
	#superclass : #JunGeometry,
	#category : #'Jun-Geometry-Abstract'
}

{ #category : #copyright }
JunSurface class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunSurface class >> system [
	^'Jun'
]

{ #category : #copyright }
JunSurface class >> version [
	^'799'
]

{ #category : #testing }
JunSurface >> isSurface [
	^true
]

{ #category : #testing }
JunSurface >> whichSideOf: bisector [ 
	^self subclassResponsibility
]

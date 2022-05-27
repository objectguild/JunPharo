"
Imported by VwImportClass
"
Class {
	#name : #JunSolid,
	#superclass : #JunGeometry,
	#category : #'Jun-Geometry-Abstract'
}

{ #category : #copyright }
JunSolid class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunSolid class >> system [
	^'Jun'
]

{ #category : #copyright }
JunSolid class >> version [
	^'799'
]

{ #category : #testing }
JunSolid >> is3d [
	^true
]

{ #category : #testing }
JunSolid >> isSolid [
	^true
]

{ #category : #testing }
JunSolid >> whichSideOf: bisector [ 
	^self subclassResponsibility
]

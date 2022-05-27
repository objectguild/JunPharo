"
Imported by VwImportClass
"
Class {
	#name : #JunCurve,
	#superclass : #JunGeometry,
	#category : #'Jun-Geometry-Abstract'
}

{ #category : #copyright }
JunCurve class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunCurve class >> system [
	^'Jun'
]

{ #category : #copyright }
JunCurve class >> version [
	^'799'
]

{ #category : #converting }
JunCurve >> asNurbsCurve [
	^self subclassResponsibility
]

{ #category : #accessing }
JunCurve >> atT: aNumber [
	^self subclassResponsibility
]

{ #category : #accessing }
JunCurve >> center [
	^self atT: 0.5d
]

{ #category : #accessing }
JunCurve >> first [
	^self from
]

{ #category : #accessing }
JunCurve >> from [
	^self atT: 0.0d
]

{ #category : #testing }
JunCurve >> isCurve [
	^true
]

{ #category : #accessing }
JunCurve >> last [
	^self to
]

{ #category : #accessing }
JunCurve >> middle [
	^self center
]

{ #category : #accessing }
JunCurve >> second [
	^self to
]

{ #category : #accessing }
JunCurve >> to [
	^self atT: 1.0d
]

{ #category : #testing }
JunCurve >> whichSideOf: bisector [ 
	^self subclassResponsibility
]

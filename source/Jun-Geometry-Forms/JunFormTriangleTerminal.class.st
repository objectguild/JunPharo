"
Imported by VwImportClass
"
Class {
	#name : #JunFormTriangleTerminal,
	#superclass : #JunFormTriangleNode,
	#instVars : [
		'tp'
	],
	#category : #'Jun-Geometry-Forms'
}

{ #category : #copyright }
JunFormTriangleTerminal class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunFormTriangleTerminal class >> system [
	^'Jun'
]

{ #category : #copyright }
JunFormTriangleTerminal class >> version [
	^'799'
]

{ #category : #testing }
JunFormTriangleTerminal >> isTerminal [
	^true
]

{ #category : #accessing }
JunFormTriangleTerminal >> tp [
	tp isNil
		ifTrue: 
			[self sp1 notNil ifTrue: [tp := self p3].
			self sp2 notNil ifTrue: [tp := self p1].
			self sp3 notNil ifTrue: [tp := self p2]].
	^tp
]

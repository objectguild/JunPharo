"
Imported by VwImportClass
"
Class {
	#name : #JunFormTriangleJunction,
	#superclass : #JunFormTriangleNode,
	#instVars : [
		'jp'
	],
	#category : #'Jun-Geometry-Forms'
}

{ #category : #copyright }
JunFormTriangleJunction class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunFormTriangleJunction class >> system [
	^'Jun'
]

{ #category : #copyright }
JunFormTriangleJunction class >> version [
	^'799'
]

{ #category : #testing }
JunFormTriangleJunction >> isJunction [
	^true
]

{ #category : #accessing }
JunFormTriangleJunction >> jp [
	jp isNil
		ifTrue: 
			[| d1 d2 d3 distance point |
			d1 := self p1 dist: self p2.
			d2 := self p2 dist: self p3.
			d3 := self p3 dist: self p1.
			distance := d1 + d2 + d3.
			point := self sp1 * (d1 / distance) + (self sp2 * (d2 / distance)) + (self sp3 * (d3 / distance)).
			jp := point].
	^jp
]

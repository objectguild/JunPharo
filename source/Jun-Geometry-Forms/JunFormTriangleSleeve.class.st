"
Imported by VwImportClass
"
Class {
	#name : #JunFormTriangleSleeve,
	#superclass : #JunFormTriangleNode,
	#category : #'Jun-Geometry-Forms'
}

{ #category : #copyright }
JunFormTriangleSleeve class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunFormTriangleSleeve class >> p1: aPoint1 p2: aPoint2 p3: aPoint3 sp1: aPoint4 sp2: aPoint5 [ 
	| triangle |
	triangle := super
				p1: aPoint1
				p2: aPoint2
				p3: aPoint3.
	triangle setSp1: aPoint4.
	triangle setSp2: aPoint5.
	^triangle
]

{ #category : #copyright }
JunFormTriangleSleeve class >> system [
	^'Jun'
]

{ #category : #copyright }
JunFormTriangleSleeve class >> version [
	^'799'
]

{ #category : #testing }
JunFormTriangleSleeve >> isSleeve [
	^true
]

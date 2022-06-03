"
Imported by VwImportClass
"
Class {
	#name : #JunTriangles,
	#superclass : #JunGeometries,
	#category : #'Jun-Geometry-Pluralities'
}

{ #category : #copyright }
JunTriangles class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunTriangles class >> system [
	^'Jun'
]

{ #category : #'instance creation' }
JunTriangles class >> triangles: triangleCollection [ 
	^(self new)
		triangles: triangleCollection;
		yourself
]

{ #category : #copyright }
JunTriangles class >> version [
	^'799'
]

{ #category : #testing }
JunTriangles >> isTriangles [
	^true
]

{ #category : #accessing }
JunTriangles >> triangles [
	^geometries
]

{ #category : #accessing }
JunTriangles >> triangles: triangleCollection [ 
	self geometries: triangleCollection
]

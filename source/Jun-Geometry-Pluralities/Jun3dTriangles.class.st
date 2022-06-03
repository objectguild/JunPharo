"
Imported by VwImportClass
"
Class {
	#name : #Jun3dTriangles,
	#superclass : #JunTriangles,
	#category : #'Jun-Geometry-Pluralities'
}

{ #category : #copyright }
Jun3dTriangles class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dTriangles class >> example1 [
	"Jun3dTriangles example1."

	| triangle triangles |
	triangle := 0 , 0 , 1 triangle: 1 , 0 , 0 and: 0 , 1 , 0.
	triangles := triangle asTriangles.
	Transcript
		cr;
		show: triangles printString.
	^triangles
]

{ #category : #examples }
Jun3dTriangles class >> example2 [
	"Jun3dTriangles example2."

	| triangle triangles |
	triangle := 0 , 0 , 1 triangle: 1 , 0 , 0 and: 0 , 1 , 0.
	triangles := triangle asTriangles subdivideLevel: 4.
	((triangles asJunOpenGL3dObject)
		add: JunOpenGL3dObject xyzArrows;
		showIn: (200 @ 250 extent: 400 @ 400)) wireframePresentation.
	^triangles
]

{ #category : #copyright }
Jun3dTriangles class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun3dTriangles class >> version [
	^'799'
]

{ #category : #testing }
Jun3dTriangles >> is3d [
	^true
]

"
Imported by VwImportClass
"
Class {
	#name : #Jun3dObjectFinder,
	#superclass : #JunAbstractObject,
	#instVars : [
		'objects'
	],
	#category : #'Jun-DXF-Support'
}

{ #category : #copyright }
Jun3dObjectFinder class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dObjectFinder class >> example1 [
	"Jun3dObjectFinder example1"

	| polyline box finder |
	polyline := JunOpenGL3dPolyline vertexes: (Array
					with: 0.0d , 0.0d , 1.0d
					with: 1.0d , 0.0d , 1.0d
					with: 1.0d , 1.0d , 1.0d
					with: 0.0d , 1.0d , 1.0d).
	box := JunOpenGL3dObject box scaledBy: 10.
	finder := Jun3dObjectFinder on: (Array with: polyline with: box).
	^finder
]

{ #category : #examples }
Jun3dObjectFinder class >> example2 [
	"Jun3dObjectFinder example2"

	| box finder box2 |
	box := (JunOpenGL3dObject box scaledBy: 10)
				translatedBy: 100 , 0 , 0.
	box2 := (JunOpenGL3dObject box scaledBy: 2)
				translatedBy: 0 , 100 , 0.
	finder := Jun3dObjectFinder on: (Array with: box with: box2).
	^finder
]

{ #category : #'instance creation' }
Jun3dObjectFinder class >> on: aCollection [ 
	| tmp |
	tmp := Jun3dObjectFinder new.
	tmp objects: (JunOpenGL3dCompoundObject withAll: aCollection).
	^tmp
]

{ #category : #copyright }
Jun3dObjectFinder class >> system [
	^'Jun'
]

{ #category : #testing }
Jun3dObjectFinder class >> test1 [
	"Jun3dObjectFinder test1"

	| box finder box2 faces t1 |
	Transcript cr; show: 'Jun3dObjectFinder test1...'.
	box := (JunOpenGL3dObject box scaledBy: 10)
				translatedBy: 100 , 0 , 0.
	box2 := (JunOpenGL3dObject box scaledBy: 2)
				translatedBy: 0 , 100 , 0.
	finder := Jun3dObjectFinder on: (Array with: box with: box2).
	faces := finder faces.
	t1 := (faces at: 1)
				= (Jun3dBoundingBox origin: -1 , -1 , -1 corner: 111 , 103 , 1).
	t1 := t1 and: [(faces at: 2)
					= (Jun3dBoundingBox origin: -1 , -1 , -1 corner: 111 , 1 , 11)].
	t1 := t1 and: [(faces at: 3)
					= (Jun3dBoundingBox origin: -1 , -1 , -1 corner: 1 , 103 , 11)].
	t1 := t1 and: [(faces at: 4)
					= (Jun3dBoundingBox origin: -1 , 101 , -1 corner: 111 , 103 , 11)].
	t1 := t1 and: [(faces at: 5)
					= (Jun3dBoundingBox origin: 109, -1, -1 corner: 111 , 103 , 11)].
	t1 := t1 and: [(faces at: 6)
					= (Jun3dBoundingBox origin: -1, -1, 9 corner: 111 , 103 , 11)].

	^t1
]

{ #category : #copyright }
Jun3dObjectFinder class >> version [
	^'799'
]

{ #category : #finding }
Jun3dObjectFinder >> face: aFace containsOrTouchesObject: anObject [ 
	anObject pointsDo: [:pp | (aFace containsOrTouchesPoint: pp)
			ifTrue: [^true]].
	^false
]

{ #category : #finding }
Jun3dObjectFinder >> faceObjects [
	| faces buckets foundFaces |
	faces := self faces.
	buckets := (1 to: 6)
				collect: [:b | Array new writeStream].
	Transcript cr; show: 'starting objectsDo loop...'.
	self objects
		objectsDo: 
			[:oo | 
			foundFaces := (1 to: 6)
						select: [:x | oo boundingBox intersects: (faces at: x)].
			Transcript cr; show: 'foundFaces: ', foundFaces printString.
			foundFaces do: [:n | (buckets at: n)
					nextPut: oo]].
	^buckets
]

{ #category : #finding }
Jun3dObjectFinder >> faceSets [
	| faces buckets pointFaces |
	faces := self faces.
	buckets := IdentityDictionary new.
	self objects
		objectsDo: 
			[:oo | 
			pointFaces := self selectFacesTouching: oo from: faces.
			pointFaces do: [:f | (buckets at: (faces at: f)
					ifAbsentPut: [Array new writeStream])
					nextPut: oo]].
	buckets keys do: [:bounds | buckets at: bounds put: (buckets at: bounds) contents].
	^buckets
]

{ #category : #finding }
Jun3dObjectFinder >> faces [
	^self faces: 1
]

{ #category : #finding }
Jun3dObjectFinder >> faces: delta [ 
	| box oo orig face |
	box := self objects boundingBox.
	oo := OrderedCollection new: 6.
	orig := box origin.
	face := (orig extent: box width , box height , 0)
				expandedBy: delta.
	oo add: face.
	face := (orig extent: box width , 0 , box depth)
				expandedBy: delta.
	oo add: face.
	face := (orig extent: box origin x , box height , box depth)
				expandedBy: delta.
	oo add: face.
	box extent - (0 , 0 , box depth).
	face := (orig x , (orig y + box height) , orig z corner: box corner)
				expandedBy: delta.
	oo add: face.
	face := (box extent x , orig y , orig z corner: box corner)
				expandedBy: delta.
	oo add: face.
	face := (orig + (0 , 0 , box depth) corner: box corner)
				expandedBy: delta.
	oo add: face.
	^oo
]

{ #category : #accessing }
Jun3dObjectFinder >> objects [
	^objects
]

{ #category : #accessing }
Jun3dObjectFinder >> objects: aCollection [ 
	objects := aCollection.
	^self
]

{ #category : #finding }
Jun3dObjectFinder >> selectFacesTouching: object from: faces [ 
	^(1 to: faces size)
		select: [:n | self face: (faces at: n)
				containsOrTouchesObject: object]
]

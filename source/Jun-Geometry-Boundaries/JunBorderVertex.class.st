"
Imported by VwImportClass
"
Class {
	#name : #JunBorderVertex,
	#superclass : #JunAbstractObject,
	#instVars : [
		'vertex1',
		'vertex2',
		'label'
	],
	#category : #'Jun-Geometry-Boundaries'
}

{ #category : #copyright }
JunBorderVertex class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunBorderVertex class >> system [
	^'Jun'
]

{ #category : #copyright }
JunBorderVertex class >> version [
	^'799'
]

{ #category : #'instance creation' }
JunBorderVertex class >> vertex: aPoint1 vertex: aPoint2 label: aNumber [ 
	| vertex |
	vertex := self new.
	vertex vertex1: aPoint1.
	vertex vertex2: aPoint2.
	vertex label: aNumber.
	^vertex
]

{ #category : #comparing }
JunBorderVertex >> = aJunContourVertex [ 
	^label = aJunContourVertex label and: [vertex1 = aJunContourVertex vertex1 and: [vertex2 = aJunContourVertex vertex2]]
]

{ #category : #comparing }
JunBorderVertex >> hash [
	^vertex1 hash
]

{ #category : #accessing }
JunBorderVertex >> label [
	^label
]

{ #category : #accessing }
JunBorderVertex >> label: aNumber [
	label := aNumber
]

{ #category : #testing }
JunBorderVertex >> onBorderOfRectangle: aRectangle [ 
	^(self onX: aRectangle left)
		or: [(self onX: aRectangle right)
				or: [(self onY: aRectangle top)
						or: [self onY: aRectangle bottom]]]
]

{ #category : #testing }
JunBorderVertex >> onCornerOfRectangle: aRectangle [ 
	^((self onX: aRectangle left)
		or: [self onX: aRectangle right])
		and: [(self onY: aRectangle top)
				or: [self onY: aRectangle bottom]]
]

{ #category : #testing }
JunBorderVertex >> onX: aNumber [ 
	^vertex1 x = aNumber and: [vertex2 x = aNumber]
]

{ #category : #testing }
JunBorderVertex >> onY: aNumber [ 
	^vertex1 y = aNumber and: [vertex2 y = aNumber]
]

{ #category : #testing }
JunBorderVertex >> onZ: aNumber [ 
	^vertex1 z = aNumber and: [vertex2 z = aNumber]
]

{ #category : #printing }
JunBorderVertex >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	vertex1 printOn: aStream.
	aStream nextPut: $,.
	vertex2 printOn: aStream.
	aStream nextPut: $,.
	label printOn: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
JunBorderVertex >> vertex1 [
	^vertex1
]

{ #category : #accessing }
JunBorderVertex >> vertex1: aNumber [ 
	vertex1 := aNumber
]

{ #category : #accessing }
JunBorderVertex >> vertex2 [
	^vertex2
]

{ #category : #accessing }
JunBorderVertex >> vertex2: aNumber [ 
	vertex2 := aNumber
]

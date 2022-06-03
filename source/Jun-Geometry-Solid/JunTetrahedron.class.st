"
Imported by VwImportClass
"
Class {
	#name : #JunTetrahedron,
	#superclass : #JunSolid,
	#instVars : [
		'p1',
		'p2',
		'p3',
		'p4'
	],
	#category : #'Jun-Geometry-Solid'
}

{ #category : #copyright }
JunTetrahedron class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunTetrahedron class >> example1 [
	"JunTetrahedron example1."

	| aTetrahedron |
	aTetrahedron := JunTetrahedron 
				on: 1 , 0 , 0
				on: 0 , 1 , 0
				on: 0 , 0 , 1
				on: 0 , 0 , 0.
	Transcript
		cr;
		show: aTetrahedron printString.
	Transcript
		cr;
		show: aTetrahedron storeString.
	Transcript
		cr;
		show: 'area: ' , aTetrahedron area printString.
	Transcript
		cr;
		show: 'volume: ' , aTetrahedron volume printString.
	aTetrahedron asJunOpenGL3dObject showWithUnitAxes.
	^aTetrahedron
]

{ #category : #'lisp support' }
JunTetrahedron class >> fromTable: aTable for: aTetrahedron [ 
	"JunTetrahedron fromLispList: (((1 , 0 , 0) tetrahedron: (0 , 1 , 0) and: (0 , 0 , 1) and: (0 , 0 , 0)) toLispList)."

	self p1FromTable: aTable for: aTetrahedron.
	self p2FromTable: aTable for: aTetrahedron.
	self p3FromTable: aTable for: aTetrahedron.
	self p4FromTable: aTable for: aTetrahedron.
	^aTetrahedron
]

{ #category : #'instance creation' }
JunTetrahedron class >> on: aPoint1 on: aPoint2 on: aPoint3 on: aPoint4 [ 
	"JunTetrahedron on: (1 , 0 , 0) on: (0 , 1 , 0) on: (0 , 0 , 1) on: (0 , 0 , 0)."

	| aTetrahedron |
	aTetrahedron := self new.
	aTetrahedron setP1: aPoint1.
	aTetrahedron setP2: aPoint2.
	aTetrahedron setP3: aPoint3.
	aTetrahedron setP4: aPoint4.
	^aTetrahedron
]

{ #category : #'lisp support' }
JunTetrahedron class >> p1FromTable: aTable for: aTetrahedron [ 
	| aList |
	aList := aTable at: #p1 ifAbsent: [^aTetrahedron].
	aTetrahedron setP1: (self pointClass fromLispList: aList).
	^aTetrahedron
]

{ #category : #'lisp support' }
JunTetrahedron class >> p2FromTable: aTable for: aTetrahedron [ 
	| aList |
	aList := aTable at: #p2 ifAbsent: [^aTetrahedron].
	aTetrahedron setP2: (self pointClass fromLispList: aList).
	^aTetrahedron
]

{ #category : #'lisp support' }
JunTetrahedron class >> p3FromTable: aTable for: aTetrahedron [ 
	| aList |
	aList := aTable at: #p3 ifAbsent: [^aTetrahedron].
	aTetrahedron setP3: (self pointClass fromLispList: aList).
	^aTetrahedron
]

{ #category : #'lisp support' }
JunTetrahedron class >> p4FromTable: aTable for: aTetrahedron [ 
	| aList |
	aList := aTable at: #p4 ifAbsent: [^aTetrahedron].
	aTetrahedron setP4: (self pointClass fromLispList: aList).
	^aTetrahedron
]

{ #category : #copyright }
JunTetrahedron class >> system [
	^'Jun'
]

{ #category : #copyright }
JunTetrahedron class >> version [
	^'799'
]

{ #category : #accessing }
JunTetrahedron >> area [
	| area |
	area := 0.
	self triangles do: [:aTriangle | area := area + aTriangle area].
	^area
]

{ #category : #accessing }
JunTetrahedron >> areaWithSign [
	| areaWithSign |
	areaWithSign := 0.
	self triangles 
		do: [:aTriangle | areaWithSign := areaWithSign + aTriangle areaWithSign].
	^areaWithSign
]

{ #category : #converting }
JunTetrahedron >> asJunOpenGL3dObject [
	| compoundObject |
	compoundObject := JunOpenGL3dCompoundObject new.
	self triangles 
		do: [:aTriangle | compoundObject add: aTriangle asJunOpenGL3dObject].
	^compoundObject
]

{ #category : #functions }
JunTetrahedron >> barycenter [
	"((1 , 0 , 0) tetrahedron: (0 , 1 , 0) and: (0 , 0 , 1) and: (0 , 0 , 0)) barycenter."

	^self centerOfGravity
]

{ #category : #functions }
JunTetrahedron >> centerOfCircumcircle [
	"((1 , 0 , 0) tetrahedron: (0 , 1 , 0) and: (0 , 0 , 1) and: (0 , 0 , 0)) centerOfCircumcircle."

	^self circumsphere center
]

{ #category : #functions }
JunTetrahedron >> centerOfGravity [
	"((1 , 0 , 0) tetrahedron: (0 , 1 , 0) and: (0 , 0 , 1) and: (0 , 0 , 0)) centerOfGravity."

	^Jun3dPoint 
		x: (self p1 x + self p2 x + self p3 x + self p4 x) / 4
		y: (self p1 y + self p2 y + self p3 y + self p4 y) / 4
		z: (self p1 z + self p2 z + self p3 z + self p4 z) / 4
]

{ #category : #functions }
JunTetrahedron >> circumball [
	"| aTetrahedorn aBody |
	aTetrahedorn := (1 , 0 , 0) tetrahedron: (0 , 1 , 0) and: (0 , 0 , 1) and: (0 , 0 , 0).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTetrahedorn asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTetrahedorn circumball asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.25).
	aBody showWithAxes.
	^aTetrahedorn"

	| aSphere |
	aSphere := self circumsphere.
	^self boundingBallClass center: aSphere center radius: aSphere radius
]

{ #category : #functions }
JunTetrahedron >> circumcenter [
	"((1 , 0 , 0) tetrahedron: (0 , 1 , 0) and: (0 , 0 , 1) and: (0 , 0 , 0)) circumcenter."

	^self centerOfCircumcircle
]

{ #category : #functions }
JunTetrahedron >> circumsphere [
	"((1 , 0 , 0) tetrahedron: (0 , 1 , 0) and: (0 , 0 , 1) and: (0 , 0 , 0)) circumsphere."

	"| aTetrahedorn aBody |
	aTetrahedorn := (1 , 0 , 0) tetrahedron: (0 , 1 , 0) and: (0 , 0 , 1) and: (-1 , -1 , -1).
	aBody := JunOpenGL3dCompoundObject 
		with: (aTetrahedorn asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.5) 
		with: (aTetrahedorn circumsphere asJunOpenGL3dObjectColor: ColorValue gray alpha: 0.25).
	aBody showWithAxes.
	^aTetrahedorn"

	| firstPlane secondPlane thirdPlane centerPoint radiusValue |
	firstPlane := self p1 bisector: self p2.
	secondPlane := self p2 bisector: self p3.
	thirdPlane := self p3 bisector: self p4.
	centerPoint := firstPlane intersectingPointWithPlane: secondPlane
				withPlane: thirdPlane.
	radiusValue := centerPoint distance: self p1.
	^self sphereClass center: centerPoint radius: radiusValue
]

{ #category : #testing }
JunTetrahedron >> isTetrahedron [
	^true
]

{ #category : #functions }
JunTetrahedron >> normalUnitVectors [
	^self triangles collect: [:aTriangle | aTriangle normalUnitVector]
]

{ #category : #functions }
JunTetrahedron >> normalVectors [
	^self triangles collect: [:aTriangle | aTriangle normalVector]
]

{ #category : #accessing }
JunTetrahedron >> p1 [
	^p1
]

{ #category : #'lisp support' }
JunTetrahedron >> p1ToLispList [
	| list |
	list := self lispCons.
	list head: #p1.
	list tail: self p1 toLispList.
	^list
]

{ #category : #accessing }
JunTetrahedron >> p2 [
	^p2
]

{ #category : #'lisp support' }
JunTetrahedron >> p2ToLispList [
	| list |
	list := self lispCons.
	list head: #p2.
	list tail: self p2 toLispList.
	^list
]

{ #category : #accessing }
JunTetrahedron >> p3 [
	^p3
]

{ #category : #'lisp support' }
JunTetrahedron >> p3ToLispList [
	| list |
	list := self lispCons.
	list head: #p3.
	list tail: self p3 toLispList.
	^list
]

{ #category : #accessing }
JunTetrahedron >> p4 [
	^p4
]

{ #category : #'lisp support' }
JunTetrahedron >> p4ToLispList [
	| list |
	list := self lispCons.
	list head: #p4.
	list tail: self p4 toLispList.
	^list
]

{ #category : #printing }
JunTetrahedron >> printOn: aStream [ 
	aStream nextPutAll: '('.
	self p1 printOn: aStream.
	aStream nextPutAll: ' tetrahedron: '.
	self p2 printOn: aStream.
	aStream nextPutAll: ' and: '.
	self p3 printOn: aStream.
	aStream nextPutAll: ' and: '.
	self p4 printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #functions }
JunTetrahedron >> radiusOfCircumcircle [
	"((1 , 0 , 0) tetrahedron: (0 , 1 , 0) and: (0 , 0 , 1) and: (0 , 0 , 0)) radiusOfCircumcircle."

	^self circumsphere radius
]

{ #category : #private }
JunTetrahedron >> setP1: aPoint [ 
	p1 := self pointClass coerce: aPoint
]

{ #category : #private }
JunTetrahedron >> setP2: aPoint [ 
	p2 := self pointClass coerce: aPoint
]

{ #category : #private }
JunTetrahedron >> setP3: aPoint [ 
	p3 := self pointClass coerce: aPoint
]

{ #category : #private }
JunTetrahedron >> setP4: aPoint [ 
	p4 := self pointClass coerce: aPoint
]

{ #category : #printing }
JunTetrahedron >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' on: '.
	self p1 storeOn: aStream.
	aStream nextPutAll: ' on: '.
	self p2 storeOn: aStream.
	aStream nextPutAll: ' on: '.
	self p3 storeOn: aStream.
	aStream nextPutAll: ' on: '.
	self p4 storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'lisp support' }
JunTetrahedron >> toLispList [
	"self showLispList: (((1 , 0 , 0) tetrahedron: (0 , 1 , 0) and: (0 , 0 , 1) and: (0 , 0 , 0)) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self p1ToLispList.
	list add: self p2ToLispList.
	list add: self p3ToLispList.
	list add: self p4ToLispList.
	^list
]

{ #category : #accessing }
JunTetrahedron >> triangles [
	^Array 
		with: (p1 triangle: p2 and: p3)
		with: (p1 triangle: p3 and: p4)
		with: (p1 triangle: p4 and: p2)
		with: (p2 triangle: p4 and: p3)
]

{ #category : #accessing }
JunTetrahedron >> volume [
	^self volumeWithSign abs
]

{ #category : #accessing }
JunTetrahedron >> volumeWithSign [
	| x21 y21 z21 x31 y31 z31 x41 y41 z41 d34 d24 d23 volumeWithSign |
	x21 := self p2 x - self p1 x.
	y21 := self p2 y - self p1 y.
	z21 := self p2 z - self p1 z.
	x31 := self p3 x - self p1 x.
	y31 := self p3 y - self p1 y.
	z31 := self p3 z - self p1 z.
	x41 := self p4 x - self p1 x.
	y41 := self p4 y - self p1 y.
	z41 := self p4 z - self p1 z.
	d34 := y31 * z41 - (z31 * y41).
	d24 := y21 * z41 - (z21 * y41).
	d23 := y21 * z31 - (z21 * y31).
	volumeWithSign := (x21 * d34 - (x31 * d24) + (x41 * d23)) / 6.
	^volumeWithSign
]

{ #category : #testing }
JunTetrahedron >> whichSideOf: bisector [ 
	| anArray hasPlus hasMinus hasZero |
	anArray := self triangles 
				collect: [:triangles | triangles whichSideOf: bisector].
	hasPlus := anArray includes: 1.
	hasMinus := anArray includes: -1.
	(hasPlus and: [hasMinus]) ifTrue: [^0].
	hasZero := anArray includes: 0.
	hasZero ifTrue: [^0].
	(hasMinus and: [hasPlus not]) ifTrue: [^-1].
	^1
]

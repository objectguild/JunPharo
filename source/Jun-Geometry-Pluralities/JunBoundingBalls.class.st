"
Imported by VwImportClass
"
Class {
	#name : #JunBoundingBalls,
	#superclass : #JunBoundingObjects,
	#category : #'Jun-Geometry-Pluralities'
}

{ #category : #copyright }
JunBoundingBalls class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunBoundingBalls class >> fromObject: anObject [ 
	"Jun3dBoundingBalls fromObject: (JunOpenGL3dObject benzene)."

	"(JunOpenGL3dCompoundObject
		with: ((Jun2dBoundingBalls fromObject: (JunOpenGL3dObject benzene asPointArray collect: [:p | p x , p y]))
				asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5)
		with: JunOpenGL3dObject benzene) show."

	"(JunOpenGL3dCompoundObject
		with: ((Jun3dBoundingBalls fromObject: JunOpenGL3dObject benzene)
				asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5)
		with: JunOpenGL3dObject benzene) show."

	| aCollection |
	aCollection := (anObject isKindOf: Collection) 
				ifTrue: 
					[(Array with: (self boundingBoxClass fromObject: anObject) center) 
						, anObject asArray]
				ifFalse: [(Array with: anObject boundingBox center) , anObject asPointArray].
	^self fromPoints: aCollection
]

{ #category : #'instance creation' }
JunBoundingBalls class >> fromPoints: pointCollection [ 
	self halt
]

{ #category : #copyright }
JunBoundingBalls class >> system [
	^'Jun'
]

{ #category : #copyright }
JunBoundingBalls class >> version [
	^'799'
]

{ #category : #converting }
JunBoundingBalls >> asJunOpenGL3dObject [
	| compoundObject |
	compoundObject := JunOpenGL3dCompoundObject new: self size.
	self 
		do: [:boundingBall | compoundObject add: boundingBall asJunOpenGL3dObject].
	^compoundObject
]

{ #category : #accessing }
JunBoundingBalls >> boundingBall [
	| boundingBall |
	self isEmpty ifTrue: [^self boundingBallClass new].
	boundingBall := nil.
	self do: 
			[:aBall | 
			boundingBall isNil 
				ifTrue: [boundingBall := aBall]
				ifFalse: [boundingBall := aBall merge: boundingBall]].
	^boundingBall
]

{ #category : #accessing }
JunBoundingBalls >> boundingBalls [
	^self boundingObjects
]

{ #category : #accessing }
JunBoundingBalls >> boundingBalls: boundingBallCollection [ 
	self boundingObjects: boundingBallCollection
]

{ #category : #accessing }
JunBoundingBalls >> boundingBox [
	| boundingBox |
	self isEmpty ifTrue: [^self boundingBoxClass new].
	boundingBox := nil.
	self do: 
			[:aBall | 
			boundingBox isNil 
				ifTrue: [boundingBox := aBall boundingBox]
				ifFalse: [boundingBox := aBall boundingBox merge: boundingBox]].
	^boundingBox
]

{ #category : #testing }
JunBoundingBalls >> isBoundingBalls [
	^true
]

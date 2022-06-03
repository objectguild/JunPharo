"
Imported by VwImportClass
"
Class {
	#name : #Jun3dBoundingBalls,
	#superclass : #JunBoundingBalls,
	#category : #'Jun-Geometry-Pluralities'
}

{ #category : #copyright }
Jun3dBoundingBalls class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
Jun3dBoundingBalls class >> example1 [
	"Jun3dBoundingBalls example1."

	| boundingBall detailedBoundingBoxes detailedBoundingBalls compoundObject |
	boundingBall := 0 , 0 , 0 ball: 2.
	detailedBoundingBoxes := boundingBall detailedBoundingBoxes.
	detailedBoundingBalls := boundingBall detailedBoundingBalls.
	compoundObject := JunOpenGL3dCompoundObject 
				with: (boundingBall asJunOpenGL3dObjectColor: ColorValue cyan alpha: 0.5)
				with: (detailedBoundingBoxes asJunOpenGL3dObjectColor: ColorValue magenta
						alpha: 0.25)
				with: (detailedBoundingBalls asJunOpenGL3dObjectColor: ColorValue yellow
						alpha: 0.25).
	compoundObject add: (JunOpenGL3dObject axes scaledBy: 4).
	compoundObject show selectAll.
	^detailedBoundingBalls
]

{ #category : #copyright }
Jun3dBoundingBalls class >> system [
	^'Jun'
]

{ #category : #copyright }
Jun3dBoundingBalls class >> version [
	^'799'
]

{ #category : #testing }
Jun3dBoundingBalls >> is3d [
	^true
]

{ #category : #accessing }
Jun3dBoundingBalls >> volume [
	| volume |
	volume := 0.
	self do: [:boundingBall | volume := volume + boundingBall volume].
	^volume
]

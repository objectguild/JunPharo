"
Imported by VwImportClass
"
Class {
	#name : #JunHashNull,
	#superclass : #JunAbstractObject,
	#classInstVars : [
		'null'
	],
	#category : #'Jun-Collections-Hash'
}

{ #category : #copyright }
JunHashNull class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunHashNull class >> new [
	^self null
]

{ #category : #accessing }
JunHashNull class >> null [
	"JunHashNull null."

	"Transcript cr; show: JunHashNull null hash printString."

	null ifNil: [null := self basicNew].
	^null
]

{ #category : #copyright }
JunHashNull class >> system [
	^'Jun'
]

{ #category : #copyright }
JunHashNull class >> version [
	^'799'
]

{ #category : #printing }
JunHashNull >> printOn: aStream [ 
	aStream nextPutAll: 'null'
]

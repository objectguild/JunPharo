"
Imported by VwImportClass
"
Class {
	#name : #JunLispNil,
	#superclass : #JunLispList,
	#classInstVars : [
		'null'
	],
	#category : #'Jun-Goodies-Lisp'
}

{ #category : #'instance creation' }
JunLispNil class >> cell [
	^JunLispCons cell
]

{ #category : #copyright }
JunLispNil class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunLispNil class >> head: headObject [ 
	^self shouldNotImplement
]

{ #category : #'instance creation' }
JunLispNil class >> head: headObject tail: tailObject [ 
	^self shouldNotImplement
]

{ #category : #'class initialization' }
JunLispNil class >> initialize [
	"JunLispNil initialize."

	self null
]

{ #category : #'instance creation' }
JunLispNil class >> new [
	^self null
]

{ #category : #'instance creation' }
JunLispNil class >> null [
	null isNil ifTrue: [null := super new].
	^null
]

{ #category : #copyright }
JunLispNil class >> system [
	^'Jun'
]

{ #category : #copyright }
JunLispNil class >> version [
	^'799'
]

{ #category : #adding }
JunLispNil >> add: newObject [ 
	^JunLispCons head: newObject tail: self class null
]

{ #category : #functions }
JunLispNil >> append: list [ 
	^list
]

{ #category : #accessing }
JunLispNil >> head [
	^self
]

{ #category : #functions }
JunLispNil >> last [
	^self
]

{ #category : #functions }
JunLispNil >> length [
	^0
]

{ #category : #functions }
JunLispNil >> mapcdr: aBlock [ 
	^self
]

{ #category : #functions }
JunLispNil >> member: anObject [ 
	^self
]

{ #category : #functions }
JunLispNil >> memq: anObject [ 
	^self
]

{ #category : #functions }
JunLispNil >> nconc: list [ 
	^list
]

{ #category : #functions }
JunLispNil >> nth: nth [ 
	^self
]

{ #category : #testing }
JunLispNil >> null [
	^true
]

{ #category : #'pretty printing' }
JunLispNil >> ppOn: aStream [ 
	aStream nextPutAll: 'nil'.
	aStream cr
]

{ #category : #'pretty printing' }
JunLispNil >> ppString [
	^'nil\' withCRs
]

{ #category : #printing }
JunLispNil >> printOn: aStream [ 
	aStream nextPutAll: 'nil'
]

{ #category : #functions }
JunLispNil >> reverse [
	^self
]

{ #category : #saving }
JunLispNil >> saveOn: aStream [ 
	aStream nextPutAll: 'nil'
]

{ #category : #saving }
JunLispNil >> saveString [
	^'nil'
]

{ #category : #accessing }
JunLispNil >> tail [
	^self
]

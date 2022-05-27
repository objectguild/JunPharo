"
Imported by VwImportClass
"
Class {
	#name : #JunTransformation,
	#superclass : #JunGeometry,
	#category : #'Jun-Geometry-Transformations'
}

{ #category : #copyright }
JunTransformation class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'lisp support' }
JunTransformation class >> elementsFromTable: aTable for: aTransformation [ 
	| elementList |
	elementList := aTable at: #elements ifAbsent: [^aTransformation].
	aTransformation setFromArray: elementList asArray.
	^aTransformation
]

{ #category : #'instance creation' }
JunTransformation class >> fromArray: anArray [ 
	"Jun2dTransformation fromArray: #(1 0 0 0 1 0 0 0 1)."

	"Jun3dTransformation fromArray: #(1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1)."

	| aTransformation |
	aTransformation := self basicNew.
	aTransformation setFromArray: anArray.
	^aTransformation
]

{ #category : #'lisp support' }
JunTransformation class >> fromTable: aTable for: aTransformation [ 
	"Jun2dTransformation fromLispList: ((Jun2dTransformation translate: 100 , 200) toLispList)."
	"Jun3dTransformation fromLispList: ((Jun3dTransformation translate: 100 , 200 , 300) toLispList)."

	self elementsFromTable: aTable for: aTransformation.
	^aTransformation
]

{ #category : #'instance creation' }
JunTransformation class >> new [
	^self shouldNotImplement
]

{ #category : #'instance creation' }
JunTransformation class >> new: size [ 
	^self shouldNotImplement
]

{ #category : #copyright }
JunTransformation class >> system [
	^'Jun'
]

{ #category : #'constants access' }
JunTransformation class >> unity [
	^self subclassResponsibility
]

{ #category : #copyright }
JunTransformation class >> version [
	^'799'
]

{ #category : #'constants access' }
JunTransformation class >> zero [
	^self subclassResponsibility
]

{ #category : #'applying transformation' }
JunTransformation >> applyTo: anObject [ 
	^anObject transform: self
]

{ #category : #'applying transformation' }
JunTransformation >> applyToPoint: aPoint [ 
	^self subclassResponsibility
]

{ #category : #converting }
JunTransformation >> asArray [
	^self subclassResponsibility
]

{ #category : #converting }
JunTransformation >> asMatrix [
	^self subclassResponsibility
]

{ #category : #converting }
JunTransformation >> asRotationMatrix [
	^self subclassResponsibility
]

{ #category : #converting }
JunTransformation >> asTranslation [
	^self subclassResponsibility
]

{ #category : #'lisp support' }
JunTransformation >> elementsToLispList [
	| list |
	list := self lispCons.
	list head: #elements.
	list tail: (self class defaultLispConsClass list: self asArray).
	^list
]

{ #category : #comparing }
JunTransformation >> hash [
	^self asArray hash
]

{ #category : #'transforming functions' }
JunTransformation >> inverse [
	^self class fromArray: self asMatrix inverse asDouble asArray
]

{ #category : #'transforming functions' }
JunTransformation >> product: aTransformation [ 
	^self subclassResponsibility
]

{ #category : #printing }
JunTransformation >> storeOn: aStream [ 
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' fromArray: '.
	self asArray storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'lisp support' }
JunTransformation >> toLispList [
	"self showLispList: ((Jun2dTransformation translate: 100 , 200) toLispList)."
	"self showLispList: ((Jun3dTransformation translate: 100 , 200 , 300) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	list add: self elementsToLispList.
	^list
]

{ #category : #transforming }
JunTransformation >> transform: aJunTransformation [ 
	^self product: aJunTransformation
]

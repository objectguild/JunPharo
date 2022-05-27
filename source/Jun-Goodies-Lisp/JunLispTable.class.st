"
Imported by VwImportClass
"
Class {
	#name : #JunLispTable,
	#superclass : #JunAbstractObject,
	#instVars : [
		'properties'
	],
	#category : #'Jun-Goodies-Lisp'
}

{ #category : #copyright }
JunLispTable class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunLispTable class >> system [
	^'Jun'
]

{ #category : #copyright }
JunLispTable class >> version [
	^'799'
]

{ #category : #adding }
JunLispTable >> add: symbol [ 
	self intern: symbol
]

{ #category : #accessing }
JunLispTable >> at: symbol [ 
	^self getprop: symbol key: #apval
]

{ #category : #accessing }
JunLispTable >> at: symbol put: value [ 
	self intern: symbol.
	^self
		putprop: symbol
		key: #apval
		value: value
]

{ #category : #private }
JunLispTable >> errorSymbolNotFound [
	self error: 'symbol not found'
]

{ #category : #'property access' }
JunLispTable >> getprop: identifier key: key [ 
	| property |
	property := properties at: identifier ifAbsent: [^self errorSymbolNotFound].
	^property at: key ifAbsent: [^nil]
]

{ #category : #accessing }
JunLispTable >> identifiers [
	^properties keys asSortedCollection
]

{ #category : #'initialize-release' }
JunLispTable >> initialize [
	properties := Dictionary new
]

{ #category : #private }
JunLispTable >> intern: symbol [ 
	(properties includesKey: symbol)
		ifFalse: [properties at: symbol put: Dictionary new].
	^symbol
]

{ #category : #'property access' }
JunLispTable >> putprop: identifier key: key value: value [ 
	| property |
	property := properties at: identifier ifAbsent: [^self errorSymbolNotFound].
	^property at: key put: value
]

{ #category : #removing }
JunLispTable >> remove: symbol [
	^properties removeKey: symbol ifAbsent: [^nil]
]

{ #category : #'property access' }
JunLispTable >> remprop: identifier key: key [ 
	| property |
	property := properties at: identifier ifAbsent: [^self errorSymbolNotFound].
	^property removeKey: key ifAbsent: [^nil]
]

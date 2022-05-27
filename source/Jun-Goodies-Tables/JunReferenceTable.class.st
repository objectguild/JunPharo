"
Imported by VwImportClass
"
Class {
	#name : #JunReferenceTable,
	#superclass : #JunAttributeTable,
	#category : #'Jun-Goodies-Tables'
}

{ #category : #copyright }
JunReferenceTable class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunReferenceTable class >> system [
	^'Jun'
]

{ #category : #copyright }
JunReferenceTable class >> version [
	^'799'
]

{ #category : #printing }
JunReferenceTable >> printMax [
	^100
]

{ #category : #printing }
JunReferenceTable >> printOn: aStream [ 
	| block references size |
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	self isEmpty ifTrue: [^aStream nextPutAll: ')'].
	block := 
			[:assoc | 
			aStream space.
			aStream nextPutAll: '('.
			assoc printOn: aStream.
			aStream nextPutAll: ')'].
	aStream space.
	references := self references.
	aStream nextPutAll: '(references'.
	(size := references size) > self printMax 
		ifTrue: 
			[(self references copyFrom: 1 to: self printMax // 2) 
				do: [:assoc | block value: assoc].
			aStream
				space;
				nextPutAll: '...'.
			(self references copyFrom: size - (self printMax // 2) to: size) 
				do: [:assoc | block value: assoc]]
		ifFalse: [self references do: [:assoc | block value: assoc]].
	aStream nextPutAll: ')'.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
JunReferenceTable >> references [
	^self bindings
]

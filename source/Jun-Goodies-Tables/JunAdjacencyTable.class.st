"
Imported by VwImportClass
"
Class {
	#name : #JunAdjacencyTable,
	#superclass : #JunAttributeTable,
	#category : #'Jun-Goodies-Tables'
}

{ #category : #copyright }
JunAdjacencyTable class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #copyright }
JunAdjacencyTable class >> system [
	^'Jun'
]

{ #category : #copyright }
JunAdjacencyTable class >> version [
	^'799'
]

{ #category : #adding }
JunAdjacencyTable >> add: node [ 
	self at: node
		ifAbsent: 
			[| table |
			table := JunReferenceTable new.
			self at: node put: table.
			^table].
	^nil
]

{ #category : #accessing }
JunAdjacencyTable >> adjacencies [
	^self bindings
]

{ #category : #accessing }
JunAdjacencyTable >> at: first with: last [ 
	self at: first
		ifPresent: [:table | table at: last ifPresent: [:attributes | ^attributes]].
	^nil
]

{ #category : #accessing }
JunAdjacencyTable >> at: first with: last put: attributes [ 
	self at: first
		ifPresent: 
			[:table | 
			attributes isNil 
				ifTrue: [table removeKey: last]
				ifFalse: [table at: last put: attributes].
			^self].
	self error: 'unexpected error'
]

{ #category : #connecting }
JunAdjacencyTable >> connect: first with: last undirected: boolean [ 
	| triplet |
	self add: first.
	self add: last.
	first = last 
		ifTrue: [triplet := nil]
		ifFalse: 
			[triplet := false.
			(self at: first with: last) isNil 
				ifTrue: 
					[self 
						at: first
						with: last
						put: JunAttributeTable new.
					triplet := true].
			boolean 
				ifTrue: 
					[(self at: last with: first) isNil 
						ifTrue: 
							[self 
								at: last
								with: first
								put: JunAttributeTable new.
							triplet := true]]].
	^triplet
]

{ #category : #connecting }
JunAdjacencyTable >> disconnect: first with: last undirected: boolean [ 
	| triplet |
	first = last 
		ifTrue: [triplet := nil]
		ifFalse: 
			[triplet := false.
			(self at: first with: last) notNil 
				ifTrue: 
					[self 
						at: first
						with: last
						put: nil.
					triplet := true].
			boolean 
				ifTrue: 
					[(self at: last with: first) notNil 
						ifTrue: 
							[self 
								at: last
								with: first
								put: nil.
							triplet := true]]].
	^triplet
]

{ #category : #printing }
JunAdjacencyTable >> printMax [
	^100
]

{ #category : #printing }
JunAdjacencyTable >> printOn: aStream [ 
	| block adjacencies size |
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	self isEmpty ifTrue: [^aStream nextPutAll: ')'].
	block := 
			[:assoc | 
			aStream space.
			aStream nextPutAll: '('.
			assoc key printOn: aStream.
			aStream nextPutAll: '=>'.
			aStream nextPutAll: '('.
			assoc value keys do: [:key | key printOn: aStream]
				separatedBy: [aStream space].
			aStream nextPutAll: ')'.
			aStream nextPutAll: ')'].
	aStream space.
	adjacencies := self adjacencies.
	aStream nextPutAll: '(adjacencies'.
	(size := adjacencies size) > self printMax 
		ifTrue: 
			[(self adjacencies copyFrom: 1 to: self printMax // 2) 
				do: [:assoc | block value: assoc].
			aStream
				space;
				nextPutAll: '...'.
			(self adjacencies copyFrom: size - (self printMax // 2) to: size) 
				do: [:assoc | block value: assoc]]
		ifFalse: [self adjacencies do: [:assoc | block value: assoc]].
	aStream nextPutAll: ')'.
	aStream nextPutAll: ')'
]

{ #category : #removing }
JunAdjacencyTable >> remove: node [ 
	self associationsDo: 
			[:assoc | 
			| table |
			table := assoc value.
			table removeKey: node].
	^self removeKey: node
]

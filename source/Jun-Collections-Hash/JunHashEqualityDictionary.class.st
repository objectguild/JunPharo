"
Imported by VwImportClass
"
Class {
	#name : #JunHashEqualityDictionary,
	#superclass : #JunHashDictionary,
	#category : #'Jun-Collections-Hash'
}

{ #category : #copyright }
JunHashEqualityDictionary class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunHashEqualityDictionary class >> example1 [
	"JunHashEqualityDictionary example1."

	Transcript clear.
	0 to: 8
		do: 
			[:subdivideLevel | 
			| equalityDictionary identityDictionary |
			equalityDictionary := JunHashEqualityDictionary new.
			((0 , 0 , 0 box: 1 , 1 , 1) subdivide2Level: subdivideLevel) do: 
					[:boundingBox | 
					boundingBox pps do: 
							[:points | 
							points do: 
									[:p | 
									equalityDictionary at: p
										put: (equalityDictionary at: p ifAbsentPut: [0]) + 1]]].
			Transcript
				nextPutAll: 'number of points in an equality dictionary: ' 
							, equalityDictionary size printString;
				cr;
				flush.
			identityDictionary := JunHashIdentityDictionary new.
			((0 , 0 , 0 box: 1 , 1 , 1) subdivide2Level: subdivideLevel) do: 
					[:boundingBox | 
					boundingBox pps do: 
							[:points | 
							points do: 
									[:p | 
									identityDictionary at: p
										put: (identityDictionary at: p ifAbsentPut: [0]) + 1]]].
			Transcript
				nextPutAll: 'number of points in an identity dictionary: ' 
							, identityDictionary size printString , ' = (3 * 8) * (2 ** ' 
							, subdivideLevel printString , ')';
				cr;
				flush]
]

{ #category : #examples }
JunHashEqualityDictionary class >> example2 [
	"JunHashEqualityDictionary example2."

	Transcript clear.
	0 to: 3
		do: 
			[:subdivideLevel | 
			| equalityDictionary identityDictionary |
			equalityDictionary := JunHashEqualityDictionary new.
			((0 , 0 , 0 box: 1 , 1 , 1) subdivideLevel: subdivideLevel) do: 
					[:boundingBox | 
					boundingBox pps do: 
							[:points | 
							points do: 
									[:p | 
									equalityDictionary at: p
										put: (equalityDictionary at: p ifAbsentPut: [0]) + 1]]].
			Transcript
				nextPutAll: 'number of points in an equality dictionary: ' 
							, equalityDictionary size printString , ' = ' 
							, (
								[:level | 
								| count |
								count := 2.
								level timesRepeat: [count := count * 2 - 1].
								count yourself] 
										value: subdivideLevel) printString 
								, ' ** 3';
				cr;
				flush.
			identityDictionary := JunHashIdentityDictionary new.
			((0 , 0 , 0 box: 1 , 1 , 1) subdivideLevel: subdivideLevel) do: 
					[:boundingBox | 
					boundingBox pps do: 
							[:points | 
							points do: 
									[:p | 
									identityDictionary at: p
										put: (identityDictionary at: p ifAbsentPut: [0]) + 1]]].
			Transcript
				nextPutAll: 'number of points in an identity dictionary: ' 
							, identityDictionary size printString , ' = 3 * (8 ** ' 
							, (subdivideLevel + 1) printString , ')';
				cr;
				flush]
]

{ #category : #copyright }
JunHashEqualityDictionary class >> system [
	^'Jun'
]

{ #category : #copyright }
JunHashEqualityDictionary class >> version [
	^'799'
]

{ #category : #private }
JunHashEqualityDictionary >> compare: firstObject with: secondObject [ 
	^firstObject key equal: secondObject key
]

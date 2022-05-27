"
Imported by VwImportClass
"
Class {
	#name : #JunHashEqualitySet,
	#superclass : #JunHashSet,
	#category : #'Jun-Collections-Hash'
}

{ #category : #copyright }
JunHashEqualitySet class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunHashEqualitySet class >> example1 [
	"JunHashEqualitySet example1."

	Transcript clear.
	0 to: 8
		do: 
			[:subdivideLevel | 
			| equalitySet identitySet |
			equalitySet := JunHashEqualitySet new.
			((0 , 0 , 0 box: 1 , 1 , 1) subdivide2Level: subdivideLevel) 
				do: [:boundingBox | boundingBox pps do: [:points | points do: [:p | equalitySet add: p]]].
			Transcript
				nextPutAll: 'number of points in an equality set: ' 
							, equalitySet size printString;
				cr;
				flush.
			identitySet := JunHashIdentitySet new.
			((0 , 0 , 0 box: 1 , 1 , 1) subdivide2Level: subdivideLevel) 
				do: [:boundingBox | boundingBox pps do: [:points | points do: [:p | identitySet add: p]]].
			Transcript
				nextPutAll: 'number of points in an identity set: ' 
							, identitySet size printString , ' = (3 * 8) * (2 ** ' 
							, subdivideLevel printString , ')';
				cr;
				flush]
]

{ #category : #examples }
JunHashEqualitySet class >> example2 [
	"JunHashEqualitySet example2."

	Transcript clear.
	0 to: 3
		do: 
			[:subdivideLevel | 
			| equalitySet identitySet |
			equalitySet := JunHashEqualitySet new.
			((0 , 0 , 0 box: 1 , 1 , 1) subdivideLevel: subdivideLevel) 
				do: [:boundingBox | boundingBox pps do: [:points | points do: [:p | equalitySet add: p]]].
			Transcript
				nextPutAll: 'number of points in an equality set: ' 
							, equalitySet size printString , ' = ' 
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
			identitySet := JunHashIdentitySet new.
			((0 , 0 , 0 box: 1 , 1 , 1) subdivideLevel: subdivideLevel) 
				do: [:boundingBox | boundingBox pps do: [:points | points do: [:p | identitySet add: p]]].
			Transcript
				nextPutAll: 'number of points in an identity set: ' 
							, identitySet size printString , ' = 3 * (8 ** ' 
							, (subdivideLevel + 1) printString , ')';
				cr;
				flush]
]

{ #category : #copyright }
JunHashEqualitySet class >> system [
	^'Jun'
]

{ #category : #copyright }
JunHashEqualitySet class >> version [
	^'799'
]

{ #category : #private }
JunHashEqualitySet >> compare: firstObject with: secondObject [ 
	^firstObject equal: secondObject
]

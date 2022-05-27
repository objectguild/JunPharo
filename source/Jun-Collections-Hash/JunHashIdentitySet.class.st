"
Imported by VwImportClass
"
Class {
	#name : #JunHashIdentitySet,
	#superclass : #JunHashSet,
	#category : #'Jun-Collections-Hash'
}

{ #category : #copyright }
JunHashIdentitySet class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunHashIdentitySet class >> example1 [
	"JunHashIdentitySet example1."

	| aCollection |
	aCollection := JunHashIdentitySet new.
	Transcript clear.
	aCollection add: 'abc'.
	aCollection add: 'def'.
	aCollection add: 'ghi'.
	aCollection add: 'jkl'.
	aCollection add: 'mno'.
	aCollection add: 'pqr'.
	aCollection add: 'stu'.
	aCollection add: 'vwx'.
	aCollection add: 'yz0'.
	Transcript
		cr;
		show: (aCollection includes: 'abc') printString.
	aCollection add: 'abc' copy.
	Transcript
		cr;
		show: aCollection size printString.
	aCollection add: '123'.
	aCollection add: '456'.
	aCollection add: '789'.
	aCollection remove: 'ghi' ifAbsent: [].
	Transcript
		cr;
		show: aCollection size printString.
	Transcript cr.
	aCollection printOn: Transcript.
	Transcript flush.
	^aCollection
]

{ #category : #examples }
JunHashIdentitySet class >> example2 [
	"JunHashIdentitySet example2."

	| aCollection |
	aCollection := JunHashIdentitySet new.
	Transcript clear.
	aCollection add: 'abc'.
	aCollection add: 'def'.
	aCollection add: 'ghi'.
	aCollection add: 'jkl'.
	aCollection add: 'mno'.
	aCollection add: 'pqr'.
	aCollection add: 'stu'.
	aCollection add: 'vwx'.
	aCollection add: 'yz0'.
	aCollection add: 'abc' copy.
	aCollection add: '123'.
	aCollection add: '456'.
	aCollection add: '789'.
	Transcript cr.
	aCollection printOn: Transcript.
	Transcript cr.
	(aCollection select: [:each | each = 'ghi']) printOn: Transcript.
	Transcript cr.
	(aCollection select: [:each | each first isDigit]) printOn: Transcript.
	Transcript cr.
	(aCollection reject: [:each | each first isDigit]) printOn: Transcript.
	Transcript cr.
	(aCollection 
		collect: [:each | each inject: 0 into: [:v :c | v + c asInteger]]) 
			printOn: Transcript.
	Transcript cr.
	(aCollection inject: 0
		into: [:value :each | value + (each inject: 0 into: [:v :c | v + c asInteger])]) 
			printOn: Transcript.
	Transcript flush.
	^aCollection
]

{ #category : #copyright }
JunHashIdentitySet class >> system [
	^'Jun'
]

{ #category : #copyright }
JunHashIdentitySet class >> version [
	^'799'
]

{ #category : #private }
JunHashIdentitySet >> compare: firstObject with: secondObject [ 
	^firstObject == secondObject
]

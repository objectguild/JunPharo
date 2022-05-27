"
Imported by VwImportClass
"
Class {
	#name : #JunHashIdentityDictionary,
	#superclass : #JunHashDictionary,
	#category : #'Jun-Collections-Hash'
}

{ #category : #copyright }
JunHashIdentityDictionary class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunHashIdentityDictionary class >> example1 [
	"JunHashIdentityDictionary example1."

	| aDictionary |
	aDictionary := JunHashIdentityDictionary new.
	aDictionary at: 'Asaoka' put: 'Aho'.
	aDictionary at: 'Hiroko' put: 'Baka'.
	aDictionary at: 'Asaoka' put: 'Kawaii'.
	aDictionary at: 'Hiroko' put: 'Kirei'.
	Transcript
		cr;
		show: aDictionary printString.
	^aDictionary
]

{ #category : #examples }
JunHashIdentityDictionary class >> example2 [
	"JunHashIdentityDictionary example2."

	| aDictionary keyObject1 keyObject2 |
	aDictionary := JunHashIdentityDictionary new.
	keyObject1 := 'Asaoka'.
	keyObject2 := 'Hiroko'.
	aDictionary at: keyObject1 put: 'Aho'.
	aDictionary at: keyObject2 put: 'Baka'.
	aDictionary at: keyObject1 put: 'Kawaii'.
	aDictionary at: keyObject2 put: 'Kirei'.
	Transcript
		cr;
		show: aDictionary printString.
	^aDictionary
]

{ #category : #copyright }
JunHashIdentityDictionary class >> system [
	^'Jun'
]

{ #category : #copyright }
JunHashIdentityDictionary class >> version [
	^'799'
]

{ #category : #private }
JunHashIdentityDictionary >> compare: firstObject with: secondObject [ 
	^firstObject key == secondObject key
]

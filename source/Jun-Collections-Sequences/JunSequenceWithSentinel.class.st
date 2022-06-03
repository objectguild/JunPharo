"
Imported by VwImportClass
"
Class {
	#name : #JunSequenceWithSentinel,
	#superclass : #SequenceableCollection,
	#instVars : [
		'sequence',
		'sentinel'
	],
	#category : #'Jun-Collections-Sequences'
}

{ #category : #copyright }
JunSequenceWithSentinel class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'instance creation' }
JunSequenceWithSentinel class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
JunSequenceWithSentinel class >> on: aSequence sentinel: anObject [ 
	| newSequence |
	newSequence := self basicNew.
	newSequence sequence: aSequence.
	newSequence sentinel: anObject.
	^newSequence
]

{ #category : #copyright }
JunSequenceWithSentinel class >> system [
	^'Jun'
]

{ #category : #copyright }
JunSequenceWithSentinel class >> version [
	^'799'
]

{ #category : #accessing }
JunSequenceWithSentinel >> at: anIndex [ 
	^(anIndex >= 1 and: [anIndex <= self size])
		ifTrue: [sequence at: anIndex]
		ifFalse: [sentinel]
]

{ #category : #accessing }
JunSequenceWithSentinel >> at: anIndex put: anObject [ 
	^sequence at: anIndex put: anObject
]

{ #category : #private }
JunSequenceWithSentinel >> sentinel: anObject [ 
	sentinel := anObject
]

{ #category : #private }
JunSequenceWithSentinel >> sequence: aSequence [ 
	sequence := aSequence
]

{ #category : #accessing }
JunSequenceWithSentinel >> size [
	^sequence size
]

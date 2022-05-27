"
Imported by VwImportClass
"
Class {
	#name : #JunLabeledTwoDList,
	#superclass : #JunAbstractObject,
	#instVars : [
		'twoDList',
		'columnLabels',
		'rowLabels'
	],
	#category : #'Jun-Goodies-Tables'
}

{ #category : #copyright }
JunLabeledTwoDList class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunLabeledTwoDList class >> example1 [
	"JunLabeledTwoDList example1."

	| tableModel |
	tableModel := JunTableModel new.
	tableModel table: (JunLabeledTwoDList
			on: #('Vulcans' 188 173 192 'Romulans' 26 26 452)
			columnLabels: #('name' 'x' 'y' 'z')
			rowLabels: #(1 2)).
	tableModel open.
	^tableModel
]

{ #category : #'instance creation' }
JunLabeledTwoDList class >> on: aCollection columnLabels: columnLabels rowLabels: rowLabels [ 
	| twoDList |
	twoDList := TwoDList
				on: aCollection
				columns: columnLabels size
				rows: rowLabels size.
	^self
		twoDList: twoDList
		columnLabels: columnLabels
		rowLabels: rowLabels
]

{ #category : #copyright }
JunLabeledTwoDList class >> system [
	^'Jun'
]

{ #category : #'instance creation' }
JunLabeledTwoDList class >> twoDList: aTwoDList columnLabels: columnLabels rowLabels: rowLabels [ 
	| labeledTwoDList |
	labeledTwoDList := self new.
	labeledTwoDList twoDList: aTwoDList.
	labeledTwoDList columnLabels: columnLabels.
	labeledTwoDList rowLabels: rowLabels.
	^labeledTwoDList
]

{ #category : #copyright }
JunLabeledTwoDList class >> version [
	^'799'
]

{ #category : #accessing }
JunLabeledTwoDList >> at: aPoint [ 
	^self twoDList at: aPoint
]

{ #category : #accessing }
JunLabeledTwoDList >> columnLabels [
	^columnLabels
]

{ #category : #accessing }
JunLabeledTwoDList >> columnLabels: aCollection [ 
	columnLabels := aCollection
]

{ #category : #accessing }
JunLabeledTwoDList >> columnSize [
	^self twoDList columnSize
]

{ #category : #accessing }
JunLabeledTwoDList >> isTransposed [
	^self twoDList isTransposed
]

{ #category : #accessing }
JunLabeledTwoDList >> rowLabels [
	^rowLabels
]

{ #category : #accessing }
JunLabeledTwoDList >> rowLabels: aCollection [ 
	rowLabels := aCollection
]

{ #category : #accessing }
JunLabeledTwoDList >> rowSize [
	^self twoDList rowSize
]

{ #category : #accessing }
JunLabeledTwoDList >> twoDList [
	^twoDList
]

{ #category : #accessing }
JunLabeledTwoDList >> twoDList: aTwoDList [ 
	twoDList := aTwoDList
]

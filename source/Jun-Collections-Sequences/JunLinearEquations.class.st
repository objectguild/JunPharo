"
Imported by VwImportClass
"
Class {
	#name : #JunLinearEquations,
	#superclass : #JunMatrix,
	#instVars : [
		'solutionLocations',
		'defaultValues'
	],
	#category : #'Jun-Collections-Sequences'
}

{ #category : #copyright }
JunLinearEquations class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'lisp support' }
JunLinearEquations class >> defaultValuesFromTable: aTable for: aLinearEquations [ 
	| aList |
	aList := aTable at: #defaultValues ifAbsent: [^aLinearEquations].
	aLinearEquations defaultValues: aList asArray.
	^aLinearEquations
]

{ #category : #examples }
JunLinearEquations class >> example1 [
	"JunLinearEquations example1."

	| aMatrix |
	aMatrix := JunLinearEquations exampleLinearEquations.
	^aMatrix
]

{ #category : #examples }
JunLinearEquations class >> example2 [
	"JunLinearEquations example2."

	| aMatrix |
	aMatrix := JunLinearEquations 
				new: 3
				by: 3
				collection: #(1 2 3  4 5 6  1 1 1).
	aMatrix solve.
	^aMatrix
]

{ #category : #examples }
JunLinearEquations class >> example3 [
	"JunLinearEquations example3."

	| aMatrix |
	aMatrix := JunLinearEquations 
				new: 4
				by: 4
				collection: #(1 -1 0 1  1 2 4 -17  2 -1 1 -3  1 1 1 -6).
	^aMatrix solution
]

{ #category : #examples }
JunLinearEquations class >> example4 [
	"JunMessageSpy spy: [10000 timesRepeat: [JunLinearEquations example4]]."

	| aMatrix |
	aMatrix := JunLinearEquations 
				new: 4
				by: 4
				collection: #(1 -1 0 1  1 2 4 -17  2 -1 1 -3  1 1 1 -6).
	^aMatrix solution
]

{ #category : #examples }
JunLinearEquations class >> exampleLinearEquations [
	"JunLinearEquations exampleLinearEquations."

	| aMatrix |
	aMatrix := JunLinearEquations 
				new: 3
				by: 4
				collection: #(1 3 5 7  11 13 17 19  29 31 37 41).
	aMatrix solve.
	^aMatrix
]

{ #category : #'lisp support' }
JunLinearEquations class >> fromTable: aTable for: aLinearEquations [ 
	"JunLinearEquations fromLispList: ((JunLinearEquations exampleLinearEquations) toLispList)."

	self solutionLocationsFromTable: aTable for: aLinearEquations.
	self defaultValuesFromTable: aTable for: aLinearEquations.
	^aLinearEquations
]

{ #category : #'instance creation' }
JunLinearEquations class >> new: rowSize by: columnSize collection: collection defaultValues: anArrayOfNumber [ 
	^(self
		new: rowSize
		by: columnSize
		collection: collection)
		defaultValues: anArrayOfNumber; yourself
]

{ #category : #'lisp support' }
JunLinearEquations class >> solutionLocationsFromTable: aTable for: aLinearEquations [ 
	| aList |
	aList := aTable at: #solutionLocations ifAbsent: [^aLinearEquations].
	aLinearEquations solutionLocations: aList asArray.
	^aLinearEquations
]

{ #category : #copyright }
JunLinearEquations class >> system [
	^'Jun'
]

{ #category : #copyright }
JunLinearEquations class >> version [
	^'799'
]

{ #category : #accessing }
JunLinearEquations >> defaultValues [
	defaultValues isNil ifTrue: [defaultValues := Array new: self unknownSize].
	^defaultValues
]

{ #category : #accessing }
JunLinearEquations >> defaultValues: anArrayOfNumber [
	defaultValues := anArrayOfNumber
]

{ #category : #'lisp support' }
JunLinearEquations >> defaultValuesToLispList [
	| list |
	list := self lispCons.
	list head: #defaultValues.
	list tail: (self class defaultLispConsClass list: self defaultValues).
	^list
]

{ #category : #testing }
JunLinearEquations >> isConsistent [
	"(JunLinearEquations new: 4 by: 4 collection: #(1 -1 0 1   1 2 4 -17   2 -1 1 -3   1 1 1 -6)) isConsistent."
	"(JunLinearEquations new: 4 by: 4 collection: #(1 -1 0 1   1 2 4 -17   2 -1 1 -3   1 1 1 -7)) isConsistent."
	self solve.
	1 to: self rowSize do: [:row | ((solutionLocations includes: row) not and: [(self atPoint: row @ self columnSize) isZero not])
			ifTrue: [^false]].
	^true
]

{ #category : #testing }
JunLinearEquations >> isSolved [
	^solutionLocations notNil
]

{ #category : #accessing }
JunLinearEquations >> reset [
	solutionLocations := nil
]

{ #category : #accessing }
JunLinearEquations >> solution [
	"(JunLinearEquations new: 3 by: 4 collection: #(1 -1 0 1 1 2 4 -17 2 -1 1 -3)) solution."

	| solution |
	solution := Array new: self unknownSize.
	1 to: self unknownSize do: [:unknown | solution at: unknown put: (self solutionAt: unknown)].
	^solution
]

{ #category : #accessing }
JunLinearEquations >> solutionAt: anInteger [ 
	"(JunLinearEquations new: 3 by: 4 collection: #(1 -1 0 1 1 2 4 -17 2 -1 1 -3)) solutionAt: 1."

	| solutionRow |
	self solve.
	solutionRow := solutionLocations at: anInteger.
	^solutionRow notNil
		ifTrue: [(self atPoint: solutionRow @ self columnSize) negated]
		ifFalse: [self defaultValues at: anInteger]
]

{ #category : #private }
JunLinearEquations >> solutionLocations [
	^solutionLocations
]

{ #category : #private }
JunLinearEquations >> solutionLocations: aCollection [ 
	solutionLocations := aCollection
]

{ #category : #'lisp support' }
JunLinearEquations >> solutionLocationsToLispList [
	| list |
	list := self lispCons.
	list head: #solutionLocations.
	list tail: (self class defaultLispConsClass list: self solutionLocations).
	^list
]

{ #category : #solving }
JunLinearEquations >> solve [
	| rowsToBeProcessed columnsToBeProcessed nextPivotBlock sweepBlock unknownsSize |
	self isSolved ifTrue: [^self].
	unknownsSize := self unknownSize.
	rowsToBeProcessed := (1 to: self rowSize) asSet.
	columnsToBeProcessed := (1 to: unknownsSize) asSet.
	solutionLocations := Array new: unknownsSize.
	nextPivotBlock := 
			[| cellValue nextPivotValue nextPivot |
			nextPivot := nil.
			nextPivotValue := -1.0d.
			rowsToBeProcessed do: [:row | columnsToBeProcessed
					do: 
						[:column | 
						cellValue := (self atPoint: row @ column) abs.
						cellValue >= nextPivotValue
							ifTrue: 
								[nextPivot := row @ column.
								nextPivotValue := cellValue]]].
			nextPivot notNil
				ifTrue: 
					[rowsToBeProcessed remove: nextPivot x.
					columnsToBeProcessed remove: nextPivot y].
			nextPivot].
	sweepBlock := 
			[:pivot | 
			| pivotRatio |
			1 to: self rowSize
				do: 
					[:row | 
					pivotRatio := (self atPoint: row @ pivot y)
								/ (self atPoint: pivot).
					(row ~= pivot x and: [pivotRatio ~= 0])
						ifTrue: 
							[1 to: pivot y - 1 do: [:column | self atPoint: row @ column put: (self atPoint: row @ column)
										- ((self atPoint: pivot x @ column)
												* pivotRatio)].
							self atPoint: row @ pivot y put: 0.
							pivot y + 1 to: self columnSize do: [:column | self atPoint: row @ column put: (self atPoint: row @ column)
										- ((self atPoint: pivot x @ column)
												* pivotRatio)]]]].
	unknownsSize
		timesRepeat: 
			[| pivot |
			pivot := nextPivotBlock value.
			pivot notNil ifTrue: [(self atPoint: pivot)
					~= 0
					ifTrue: 
						[sweepBlock value: pivot.
						solutionLocations at: pivot y put: pivot x]]].
	1 to: solutionLocations size
		do: 
			[:pivotColumn | 
			| pivotRow pivot constantPoint |
			pivotRow := solutionLocations at: pivotColumn.
			pivotRow notNil
				ifTrue: 
					[pivot := pivotRow @ pivotColumn.
					constantPoint := pivotRow @ self columnSize.
					self atPoint: constantPoint put: (self atPoint: constantPoint)
							/ (self atPoint: pivot).
					self atPoint: pivot put: 1]]
]

{ #category : #'lisp support' }
JunLinearEquations >> toLispList [
	"self showLispList: ((JunLinearEquations exampleLinearEquations) toLispList)."

	| list |
	list := super toLispList.
	solutionLocations ifNotNil: [list add: self solutionLocationsToLispList].
	defaultValues ifNotNil: [list add: self defaultValuesToLispList].
	^list
]

{ #category : #accessing }
JunLinearEquations >> unknownSize [
	^self columnSize - 1
]

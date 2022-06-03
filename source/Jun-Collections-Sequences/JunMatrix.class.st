"
Imported by VwImportClass
"
Class {
	#name : #JunMatrix,
	#superclass : #JunAbstractMatrix,
	#classInstVars : [
		'defaultInverseCalculationMethod'
	],
	#category : #'Jun-Collections-Sequences'
}

{ #category : #'inverse calculation' }
JunMatrix class >> calculateInverseByGaussElimination [
	"JunMatrix calculateInverseByGaussElimination."

	self defaultInverseCalculationMethod: #GaussElimination
]

{ #category : #'inverse calculation' }
JunMatrix class >> calculateInverseByLuDecomposition [
	"JunMatrix calculateInverseByLuDecomposition."

	self defaultInverseCalculationMethod: #LuDecomposition
]

{ #category : #copyright }
JunMatrix class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #defaults }
JunMatrix class >> defaultInverseCalculationMethod [
	defaultInverseCalculationMethod isNil ifTrue: [defaultInverseCalculationMethod := #GaussElimination].
	^defaultInverseCalculationMethod
]

{ #category : #defaults }
JunMatrix class >> defaultInverseCalculationMethod: aSymbol [ 
	defaultInverseCalculationMethod := aSymbol
]

{ #category : #examples }
JunMatrix class >> example1 [
	"JunMatrix example1."

	| aMatrix |
	aMatrix := JunMatrix
				new: 3
				by: 3
				collection: #(1 2 3  4 5 6  7 8 9).
	Transcript cr; show: aMatrix printString.
	Transcript cr; show: aMatrix storeString.
	^aMatrix
]

{ #category : #examples }
JunMatrix class >> example2 [
	"JunMatrix example2."
	"
	matrix1: M(1 2 3, 4 5 6, 7 8 9) 
	matrix2: M(1 4 7, 2 5 8, 3 6 9) 
	(matrix1 + matrix2): M(2 6 10, 6 10 14, 10 14 18) 
	"

	| matrix1 matrix2 matrix |
	matrix1 := JunMatrix
				new: 3
				by: 3
				collection: #(1 2 3 4 5 6 7 8 9).
	matrix2 := JunMatrix
				new: 3
				by: 3
				collection: #(1 4 7 2 5 8 3 6 9).
	matrix := matrix1 + matrix2.
	Transcript cr; show: matrix1 printString.
	Transcript cr; show: matrix2 printString.
	Transcript cr; show: matrix printString.
	^matrix
]

{ #category : #examples }
JunMatrix class >> example3 [
	"JunMatrix example3."
	"
	matrix1: M(1 3, 4 2, 1 1, 6 4, 3 2) 
	matrix2: M(1 2, 3 4) 
	(matrix1 puroduct: matrix2): M(10 14, 10 16, 4 6, 18 28, 9 14) 
	"

	| matrix1 matrix2 matrix |
	matrix1 := JunMatrix
				new: 5
				by: 2
				collection: #(1 3 4 2 1 1 6 4 3 2).
	matrix2 := JunMatrix
				new: 2
				by: 2
				collection: #(1 2 3 4).
	matrix := matrix1 product: matrix2.
	Transcript cr; show: matrix1 printString.
	Transcript cr; show: matrix2 printString.
	Transcript cr; show: matrix printString.
	^matrix
]

{ #category : #examples }
JunMatrix class >> example4 [
	"JunMatrix example4."
	"
	matrix: M(1 2 3, 1 3 3, 1 2 4) 
	(matrix inverse): M(6 -2 -3, -1 1 0, -1 0 1) 
	"

	| matrix inverse |
	matrix := JunMatrix
				new: 3
				by: 3
				collection: #(1 2 3 1 3 3 1 2 4).
	inverse := matrix inverse.
	Transcript cr; show: matrix printString.
	Transcript cr; show: inverse printString.
	^inverse
]

{ #category : #examples }
JunMatrix class >> example5 [
	"JunMatrix example5"
	"inverseByGausseElimination does not work."
	"
	| array aMatrix inverse | 
	array := #(1.0 -4.68708e-5 4.85361e-15 0.0 -1.66533e-16 -2.77556e-17 1.0 0.0 1.66533e-16 -1.0 -1.94289e-16 0.0 6.66134e-17 0.4 -0.4 1.0). 
	aMatrix := JunMatrix new: 4 collection: array. 
	inverse := aMatrix inverseByGaussElimination. 
	^inverse product: aMatrix
	"

	| array aMatrix inverse |
	array := #(1.0 -4.68708e-5 4.85361e-15 0.0 -1.66533e-16 -2.77556e-17 1.0 0.0 1.66533e-16 -1.0 -1.94289e-16 0.0 6.66134e-17 0.4 -0.4 1.0).
	aMatrix := JunMatrix new: 4 collection: array.
	inverse := aMatrix inverseByLuDecomposition.
	^inverse product: aMatrix
]

{ #category : #examples }
JunMatrix class >> example6 [
	"JunMatrix calculateInverseByGaussElimination; example6"
	"JunMatrix calculateInverseByLuDecomposition; example6"

	| array aMatrix inverse |
	array := #(1.0 -4.68708e-5 4.85361e-15 0.0 -1.66533e-16 -2.77556e-17 1.0 0.0 1.66533e-16 -1.0 -1.94289e-16 0.0 6.66134e-17 0.4 -0.4 1.0).
	aMatrix := JunMatrix new: 4 collection: array.
	inverse := aMatrix inverse.
	^inverse product: aMatrix
]

{ #category : #examples }
JunMatrix class >> exampleImage [
	"JunImageDisplayModel show: JunMatrix exampleImage."

	"JunImageDisplayModel 
		show: (JunMatrix fromImage: JunMatrix exampleImage) asImage."

	"JunImageDisplayModel 
		show: ((JunMatrix fromImage: JunMatrix exampleImage
				valueBlock: [:color | color red]) asImageColorBlock: 
						[:value | 
						ColorValue 
							red: value
							green: 0
							blue: 0])."

	"JunImageDisplayModel 
		show: ((JunMatrix fromImage: JunMatrix exampleImage
				valueBlock: [:color | color green]) asImageColorBlock: 
						[:value | 
						ColorValue 
							red: 0
							green: value
							blue: 0])."

	"JunImageDisplayModel 
		show: ((JunMatrix fromImage: JunMatrix exampleImage
				valueBlock: [:color | color blue]) asImageColorBlock: 
						[:value | 
						ColorValue 
							red: 0
							green: 0
							blue: value])."

	| anImage aPixmap graphicsContext |
	JunControlUtility 
		assert: 
			[anImage := JunImageStream imageSmalltalkBalloon128x128.
			aPixmap := Pixmap extent: anImage extent]
		do: 
			[graphicsContext := aPixmap graphicsContext.
			anImage displayOn: graphicsContext.
			anImage := aPixmap asImage]
		ensure: [aPixmap close].
	^anImage
]

{ #category : #examples }
JunMatrix class >> exampleMatrix [
	"JunMatrix exampleMatrix."

	| aMatrix |
	aMatrix := JunMatrix 
				new: 3
				by: 4
				collection: #(1 3 5 7  11 13 17 19  29 31 37 41).
	^aMatrix
]

{ #category : #'instance creation' }
JunMatrix class >> fromImage: anImage [ 
	"JunImageDisplayModel 
		show: (JunMatrix fromImage: JunMatrix exampleImage) asImage."

	^self fromImage: anImage valueBlock: [:color | color luminance]
]

{ #category : #'instance creation' }
JunMatrix class >> fromImage: anImage valueBlock: aBlock [ 
	"JunImageDisplayModel 
		show: ((JunMatrix fromImage: JunMatrix exampleImage
				valueBlock: [:color | color blue]) asImageColorBlock: 
						[:value | 
						ColorValue 
							red: 0
							green: 0
							blue: value])."

	| aMatrix |
	aMatrix := self new: anImage width by: anImage height.
	(0 to: anImage height - 1) do: 
			[:y | 
			(0 to: anImage width - 1) do: 
					[:x | 
					| aColor aValue |
					aColor := anImage palette 
								at: ((anImage atX: x y: y) bitAnd: anImage palette maxIndex).
					aValue := aBlock value: aColor.
					aMatrix 
						row: x + 1
						column: y + 1
						put: aValue]].
	^aMatrix
]

{ #category : #copyright }
JunMatrix class >> system [
	^'Jun'
]

{ #category : #'instance creation' }
JunMatrix class >> unit: squareSize [ 
	"JunMatrix unit: 4."

	| unitMatrix |
	unitMatrix := self new: squareSize.
	unitMatrix doIJ: [:v :i :j | unitMatrix atPoint: i @ j put: (i = j
				ifTrue: [1]
				ifFalse: [0])].
	^unitMatrix
]

{ #category : #copyright }
JunMatrix class >> version [
	^'799'
]

{ #category : #converting }
JunMatrix >> asDouble [
	| collection |
	collection := OrderedCollection new.
	self do: [:each | collection add: each asDouble].
	^self species
		new: self rowSize
		by: self columnSize
		collection: collection
]

{ #category : #converting }
JunMatrix >> asFloat [
	| collection |
	collection := OrderedCollection new.
	self do: [:each | collection add: each asFloat].
	^self species
		new: self rowSize
		by: self columnSize
		collection: collection
]

{ #category : #converting }
JunMatrix >> asImage [
	"JunImageDisplayModel 
		show: (JunMatrix fromImage: JunMatrix exampleImage) asImage."

	^self 
		asImageColorBlock: [:value | ColorValue brightness: (0 max: (value min: 1))]
]

{ #category : #converting }
JunMatrix >> asImageColorBlock: aBlock [ 
	"JunImageDisplayModel 
		show: ((JunMatrix fromImage: JunMatrix exampleImage
				valueBlock: [:color | color red]) asImageColorBlock: 
						[:value | 
						ColorValue 
							red: value
							green: 0
							blue: 0])."

	| anImage |
	anImage := Image 
				extent: self rowSize @ self columnSize
				depth: Screen default colorDepth
				bitsPerPixel: Screen default colorBitsPerPixel
				palette: Screen default colorPalette.
	self doIJ: 
			[:value :row :column | 
			| colorValue pixelValue |
			colorValue := aBlock value: value.
			pixelValue := anImage palette indexOfPaintNearest: colorValue.
			anImage 
				atX: row - 1
				y: column - 1
				put: pixelValue].
	^anImage
]

{ #category : #converting }
JunMatrix >> asRational [
	| collection |
	collection := OrderedCollection new.
	self do: [:each | collection add: each asRational].
	^self species
		new: self rowSize
		by: self columnSize
		collection: collection
]

{ #category : #arithmetic }
JunMatrix >> compute: aSymbol with: aMatrix [ 
	| newMatrix newValue |
	(aMatrix isKindOf: Number)
		ifTrue: 
			[newMatrix := self copy.
			newMatrix
				doIJ: 
					[:v :i :j | 
					newValue := newMatrix row: i column: j.
					newValue := newValue perform: aSymbol with: aMatrix.
					newMatrix
						row: i
						column: j
						put: newValue]]
		ifFalse: 
			[newMatrix := self copy.
			newMatrix
				doIJ: 
					[:v :i :j | 
					newValue := newMatrix row: i column: j.
					(i <= aMatrix rowSize and: [j <= aMatrix columnSize])
						ifTrue: [newValue := newValue perform: aSymbol with: (aMatrix atPoint: i @ j)].
					newMatrix
						row: i
						column: j
						put: newValue]].
	^newMatrix
]

{ #category : #'matrix functions' }
JunMatrix >> correlation [
	^self covarianceAndCorrelation at: 2
]

{ #category : #'matrix functions' }
JunMatrix >> covariance [
	^self covarianceAndCorrelation at: 1
]

{ #category : #'matrix functions' }
JunMatrix >> covarianceAndCorrelation [
	| mean sd cov cor |
	mean := Array new: self columnSize.
	sd := Array new: self columnSize.
	cov := JunMatrix new: self columnSize.
	cor := JunMatrix new: self columnSize.
	1 to: self columnSize
		do: 
			[:i | 
			mean at: i put: (self row: 1 column: i).
			1 to: self columnSize do: [:j | cov
					row: i
					column: j
					put: 0]].
	2 to: self rowSize
		do: 
			[:i | 
			| xi |
			xi := i.
			1 to: self columnSize
				do: 
					[:j | 
					| x v xv |
					x := self row: i column: j.
					v := xi - 1 * (mean at: j) + x / xi.
					mean at: j put: v.
					xv := x - v.
					1 to: j do: [:k | cov
							row: j
							column: k
							put: (cov row: j column: k)
									+ (xi * xv * ((self row: i column: k)
												- (mean at: k))) / (xi - 1)]]].
	1 to: self columnSize
		do: 
			[:j | 
			1 to: j
				do: 
					[:k | 
					cov
						row: j
						column: k
						put: (cov row: j column: k)
								/ self rowSize.
					cov
						row: k
						column: j
						put: (cov row: j column: k)].
			sd at: j put: (cov row: j column: j) sqrt].
	1 to: self columnSize do: [:j | 1 to: j
			do: 
				[:k | 
				cor
					row: k
					column: j
					put: (cov row: k column: j)
							/ (sd at: k) / (sd at: j).
				cor
					row: j
					column: k
					put: (cor row: k column: j)]].
	^Array with: cov with: cor
]

{ #category : #'matrix functions' }
JunMatrix >> determinant [
	"(JunMatrix new: 3 collection: #(3 9 4 6 1 8 2 5 3)) determinant."

	| j ansNumber value |
	self isSquare ifFalse: [^self error: 'matrix is not square'].
	self rowSize = 2 ifTrue: [^(self row: 1 column: 1)
			* (self row: 2 column: 2) - ((self row: 1 column: 2)
				* (self row: 2 column: 1))].
	j := 1.
	ansNumber := 0.
	1 to: self columnSize
		do: 
			[:index | 
			value := 1.
			1 to: self rowSize
				do: 
					[:i | 
					j > self columnSize ifTrue: [j := 1].
					value := value * (self row: i column: j).
					j := j + 1].
			ansNumber := ansNumber + value.
			j := j - 1].
	j := self columnSize.
	1 to: self columnSize
		do: 
			[:index | 
			value := 1.
			1 to: self rowSize
				do: 
					[:i | 
					j < 1 ifTrue: [j := self columnSize].
					value := value * (self row: i column: j).
					j := j - 1].
			ansNumber := ansNumber - value.
			j := j + 1].
	^ansNumber
]

{ #category : #'matrix functions' }
JunMatrix >> generalizedInverse [
	"calculate generalized inverse matrix."

	| svd u s v sp |
	svd := self svd.
	u := svd at: 1.
	s := svd at: 2.
	v := svd at: 3.
	sp := s transpose.
	sp doIJ: [:each :i :j | (i == j and: [each isZero not])
			ifTrue: [sp
					row: i
					column: j
					put: each reciprocal]].
	^(v product: sp)
		product: u transpose
]

{ #category : #'matrix functions' }
JunMatrix >> inverse [
	"(JunMatrix new: 3 collection: #(1 2 3 1 3 3 1 2 4)) inverse."

	self inverseCalculationMethod == #GaussElimination ifTrue: [^self inverseByGaussElimination].
	self inverseCalculationMethod == #LuDecomposition ifTrue: [^self inverseByLuDecomposition].
	^self inverseByGaussElimination
]

{ #category : #'matrix functions' }
JunMatrix >> inverseByGaussElimination [
	"(JunMatrix new: 3 collection: #(1 2 3 1 3 3 1 2 4)) inverseByGaussElimination."

	| copy inverse value x v |
	self isSquare ifFalse: [^self error: 'matrix is not square'].
	copy := self asDouble.
	inverse := self class unit: self rowSize.
	1 to: copy columnSize
		do: 
			[:i | 
			value := copy row: i column: i.
			value = 0 
				ifTrue: 
					[x := i.
					[value = 0 and: [x < copy rowSize]] whileTrue: 
							[x := x + 1.
							value := copy row: x column: i].
					value = 0 ifFalse: [value := 1 / value].
					copy rowIndex: i
						doJ: 
							[:each :j | 
							v := each + ((copy row: x column: j) * value).
							copy 
								row: i
								column: j
								put: v].
					inverse rowIndex: i
						doJ: 
							[:each :j | 
							v := each + ((inverse row: x column: j) * value).
							inverse 
								row: i
								column: j
								put: v]]
				ifFalse: 
					[copy rowIndex: i
						doJ: 
							[:each :j | 
							v := each / value.
							copy 
								row: i
								column: j
								put: v].
					inverse rowIndex: i
						doJ: 
							[:each :j | 
							v := each / value.
							inverse 
								row: i
								column: j
								put: v]].
			1 to: copy rowSize
				do: 
					[:k | 
					k ~= i 
						ifTrue: 
							[value := copy row: k column: i.
							copy rowIndex: k
								doJ: 
									[:each :j | 
									v := each - ((copy row: i column: j) * value).
									copy 
										row: k
										column: j
										put: v].
							inverse rowIndex: k
								doJ: 
									[:each :j | 
									v := each - ((inverse row: i column: j) * value).
									inverse 
										row: k
										column: j
										put: v]]]].
	^inverse
]

{ #category : #'matrix functions' }
JunMatrix >> inverseByLuDecomposition [
	"(JunMatrix new: 3 collection: #(1 2 3 1 3 3 1 2 4)) inverseByLuDecomposition."

	| lu luMatrix pivotSequence size inverse index value |
	self isSquare ifFalse: [^self error: 'matrix is not square'].
	lu := self luDecompose.
	lu isNil ifTrue: [^self error: 'matrix is singular'].
	luMatrix := lu at: 1.
	pivotSequence := lu at: 2.
	size := self rowSize.
	inverse := self class new: size.
	1 to: size
		do: 
			[:columnIndex | 
			1 to: size
				do: 
					[:i | 
					index := pivotSequence at: i.
					value := index = columnIndex
								ifTrue: [1]
								ifFalse: [0].
					1 to: i - 1 do: [:j | value := value - ((luMatrix row: index column: j)
										* (inverse row: j column: columnIndex))].
					inverse
						row: i
						column: columnIndex
						put: value].
			size
				to: 1
				by: -1
				do: 
					[:i | 
					value := inverse row: i column: columnIndex.
					index := pivotSequence at: i.
					i + 1 to: size do: [:j | value := value - ((luMatrix row: index column: j)
										* (inverse row: j column: columnIndex))].
					inverse
						row: i
						column: columnIndex
						put: value / (luMatrix row: index column: i)]].
	^inverse
]

{ #category : #private }
JunMatrix >> inverseCalculationMethod [
	^self class defaultInverseCalculationMethod
]

{ #category : #testing }
JunMatrix >> isRegular [
	"(JunMatrix new: 2 collection: #(0 1 2 0)) isRegular."
	"(JunMatrix new: 2 collection: #(2 1 2 1)) isRegular."

	^self determinant isZero not
]

{ #category : #testing }
JunMatrix >> isUnit [
	"(JunMatrix new: 3 collection: #(1 0 0 0 1 0 0 0 1)) isUnit."
	"(JunMatrix new: 3 collection: #(1 2 3 4 5 6 7 8 9)) isUnit."

	self doIJ: [:v :i :j | i = j
			ifTrue: [v = 1 ifFalse: [^false]]
			ifFalse: [v = 0 ifFalse: [^false]]].
	^true
]

{ #category : #'matrix functions' }
JunMatrix >> luDecompose [
	"(JunMatrix new: 3 collection: #(3 9 4 6 1 8 2 5 3)) luDecompose."

	| size weights pivotSequence luMatrix determinant maxValue value index maxIndex pivotIndex pivot |
	self isSquare ifFalse: [^self error: 'matrix is not square'].
	size := self rowSize.
	weights := Array new: size.
	pivotSequence := Array new: size.
	luMatrix := self asDouble.
	determinant := 1.
	1 to: size
		do: 
			[:i | 
			maxValue := 0.
			1 to: size
				do: 
					[:j | 
					value := (luMatrix row: i column: j) abs.
					maxValue < value ifTrue: [maxValue := value]].
			maxValue = 0 ifTrue: [^nil].
			weights at: i put: 1 / maxValue.
			pivotSequence at: i put: i].
	1 to: size
		do: 
			[:columnIndex | 
			maxValue := -1.
			columnIndex to: size
				do: 
					[:i | 
					index := pivotSequence at: i.
					value := (luMatrix row: index column: columnIndex) abs * (weights at: index).
					value > maxValue
						ifTrue: 
							[maxValue := value.
							maxIndex := i]].
			pivotIndex := pivotSequence at: maxIndex.
			maxIndex = columnIndex
				ifFalse: 
					[pivotSequence at: maxIndex put: (pivotSequence at: columnIndex).
					pivotSequence at: columnIndex put: pivotIndex.
					determinant := determinant negated].
			pivot := luMatrix row: pivotIndex column: columnIndex.
			pivot = 0 ifTrue: [^nil].
			determinant := determinant * pivot.
			columnIndex + 1 to: size
				do: 
					[:i | 
					value := luMatrix row: (pivotSequence at: i)
								column: columnIndex.
					value := value / pivot.
					luMatrix
						row: (pivotSequence at: i)
						column: columnIndex
						put: value.
					columnIndex + 1 to: size do: [:j | luMatrix
							row: (pivotSequence at: i)
							column: j
							put: (luMatrix row: (pivotSequence at: i)
									column: j)
									- (value * (luMatrix row: pivotIndex column: j))]]].
	^Array
		with: luMatrix
		with: pivotSequence
		with: determinant
]

{ #category : #'matrix functions' }
JunMatrix >> product: aMatrix [ 
	"(JunMatrix new: 3 collection: #(1 2 3 1 3 3 1 2 4)) 
	product: (JunMatrix new: 3 collection: #(6 -2 -3 -1 1 0 -1 0 1))."

	| newMatrix answer |
	self columnSize = aMatrix rowSize ifFalse: [^self error: 'my column size is not equal to your row size)'].
	newMatrix := self species new: self rowSize by: aMatrix columnSize.
	1 to: self rowSize do: [:i | 1 to: aMatrix columnSize
			do: 
				[:j | 
				answer := 0.
				self rowIndex: i doJ: [:value :k | answer := answer + (value * (aMatrix atPoint: k @ j))].
				newMatrix atPoint: i @ j put: answer]].
	^newMatrix
]

{ #category : #'matrix functions' }
JunMatrix >> projection [
	| transposed |
	transposed := self transpose.
	^(self product: (transposed product: self) generalizedInverse)
		product: transposed
]

{ #category : #'matrix functions' }
JunMatrix >> pseudoInverse [
	"calculate Moore-Penrose pseudo inverse matrix."

	| transposed |
	transposed := self transpose.
	^((transposed product: self)
		product: (((transposed product: self)
				product: transposed)
				product: self) inverse)
		product: transposed
]

{ #category : #'matrix functions' }
JunMatrix >> svd [
	"singular value decomposition. returns an array with u, s, and v, where u * s * v' = self."

	| svd |
	svd := JunSVD new: self.
	^Array
		with: svd u
		with: svd s
		with: svd v
]

{ #category : #'matrix functions' }
JunMatrix >> trace [
	"(JunMatrix new: 3 collection: #(1 2 3 4 5 6 7 8 9)) trace."

	| trace |
	self isSquare ifFalse: [^self error: 'matrix is not square'].
	trace := 0.
	1 to: self columnSize do: [:index | trace := trace + (self row: index column: index)].
	^trace
]

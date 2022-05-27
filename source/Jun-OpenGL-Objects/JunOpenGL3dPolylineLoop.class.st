"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGL3dPolylineLoop,
	#superclass : #JunOpenGL3dPolyline,
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #copyright }
JunOpenGL3dPolylineLoop class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGL3dPolylineLoop class >> example1 [
	"JunOpenGL3dPolylineLoop example1."

	| polylineLoop list |
	polylineLoop := JunOpenGL3dPolylineLoop vertexes: (Array
					with: 0.0d , 0.0d , 1.0d
					with: 1.0d , 0.0d , 1.0d
					with: 1.0d , 1.0d , 1.0d
					with: 0.0d , 1.0d , 1.0d).
	list := polylineLoop toLispList.
	Transcript cr; show: list printString.
	polylineLoop := JunOpenGL3dPolylineLoop fromLispList: list.
	list := polylineLoop toLispList.
	Transcript cr; show: list printString.
	^polylineLoop
]

{ #category : #examples }
JunOpenGL3dPolylineLoop class >> example2 [
	"JunOpenGL3dPolylineLoop example2."

	| polylineLoop list |
	polylineLoop := JunOpenGL3dPolylineLoop vertexes: (Array
					with: 0.0d , 0.0d , 1.0d
					with: 1.0d , 0.0d , 1.0d
					with: 1.0d , 1.0d , 1.0d
					with: 0.0d , 1.0d , 1.0d).
	polylineLoop name: 'example'.
	polylineLoop paint: ColorValue gray.
	polylineLoop alpha: 0.75.
	polylineLoop halftone.
	list := polylineLoop showLispList.
	polylineLoop := polylineLoop class fromLispList: list.
	polylineLoop showLispList.
	^polylineLoop
]

{ #category : #examples }
JunOpenGL3dPolylineLoop class >> example3 [
	"JunOpenGL3dPolylineLoop example3."

	| file polylineLoop stream model |
	file := JunUniFileModel requestNewFileName: 'zzz.lst'.
	file isNil ifTrue: [^self].
	polylineLoop := JunOpenGL3dPolylineLoop vertexes: (Array
					with: 0.0d , 0.0d , 1.0d
					with: 1.0d , 0.0d , 1.0d
					with: 1.0d , 1.0d , 1.0d
					with: 0.0d , 1.0d , 1.0d).
	polylineLoop name: 'example'.
	polylineLoop paint: ColorValue gray.
	polylineLoop alpha: 0.75.
	polylineLoop halftone.
	stream := file writeStream.
	[Cursor write showWhile: [polylineLoop saveOn: stream]]
		ensure: [stream close].
	stream := file readStream.
	[Cursor read showWhile: [polylineLoop := polylineLoop class loadFrom: stream]]
		ensure: [stream close].
	model := JunOpenGLDisplayModel new.
	model displayObject: polylineLoop.
	model open.
	^polylineLoop
]

{ #category : #copyright }
JunOpenGL3dPolylineLoop class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGL3dPolylineLoop class >> version [
	^'799'
]

{ #category : #enumerating }
JunOpenGL3dPolylineLoop >> geometriesDo: aBlock [ 
	1 to: vertexes size do: [:index | aBlock value: (Jun3dLine from: (vertexes at: index)
				to: (vertexes at: index \\ vertexes size + 1))]
]

{ #category : #testing }
JunOpenGL3dPolylineLoop >> isLoop [
	^true
]

{ #category : #'lisp support' }
JunOpenGL3dPolylineLoop >> kindName [
	^#PolylineLoop
]

{ #category : #rendering }
JunOpenGL3dPolylineLoop >> renderOn: aRenderingContext [ 
	self hasPaint ifTrue: [aRenderingContext paint: self paint].
	self hasAlpha ifTrue: [aRenderingContext alpha: self alpha].
	aRenderingContext lineWidth: lineWidth.
	self hasStipple
		ifTrue: 
			[aRenderingContext lineStippleFactor: self stippleFactor pattern: self stipplePattern.
			aRenderingContext enableLineStipple].
	aRenderingContext displayLineLoop: self vertexes.
	self hasStipple ifTrue: [aRenderingContext disableLineStipple]
]

{ #category : #'vrml support' }
JunOpenGL3dPolylineLoop >> vrmlVertexes [
	| points |
	points := self vertexes.
	points first = points last ifTrue: [^points].
	^points , (Array with: points first)
]

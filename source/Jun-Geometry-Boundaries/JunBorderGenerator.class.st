"
Imported by VwImportClass
"
Class {
	#name : #JunBorderGenerator,
	#superclass : #JunAbstractObject,
	#classVars : [
		'MarchingCubes'
	],
	#category : #'Jun-Geometry-Boundaries'
}

{ #category : #'private - source code generation' }
JunBorderGenerator class >> _aroundEdgesOnCubeAtIndex: cubeIndex [ 
	"JunBorderGenerator halt; _aroundEdgesOnCubeAtIndex: 6"
	"JunBorderGenerator _aroundEdgesOnCubeAtIndex: 22"
	"(1 to: 254) collect: [ :index | JunBorderGenerator _aroundEdgesOnCubeAtIndex: index ]"
	| vertexBits verticesOnFaces facePatterns edgeStream edgesOnFaces |
	vertexBits := Array new: 8.
	1 to: 8 do: [:vertex | vertexBits at: vertex put: (cubeIndex bitAnd: (1 bitShift: vertex - 1))
				> 0].
	verticesOnFaces := Array new: 6.
	verticesOnFaces at: 1 put: #(4 3 2 1).
	verticesOnFaces at: 2 put: #(5 6 7 8).
	verticesOnFaces at: 3 put: #(1 5 8 4).
	verticesOnFaces at: 4 put: #(2 3 7 6).
	verticesOnFaces at: 5 put: #(1 2 6 5).
	verticesOnFaces at: 6 put: #(3 4 8 7).
	edgesOnFaces := Array new: 6.
	edgesOnFaces at: 1 put: #(3 2 1 4).
	edgesOnFaces at: 2 put: #(5 6 7 8).
	edgesOnFaces at: 3 put: #(9 8 12 4).
	edgesOnFaces at: 4 put: #(2 11 6 10).
	edgesOnFaces at: 5 put: #(1 10 5 9).
	edgesOnFaces at: 6 put: #(3 12 7 11).
	facePatterns := Dictionary new.
	facePatterns at: (Array
			with: false
			with: false
			with: false
			with: false)
		put: #().
	facePatterns at: (Array
			with: false
			with: false
			with: false
			with: true)
		put: #(#(3 4)).
	facePatterns at: (Array
			with: false
			with: false
			with: true
			with: false)
		put: #(#(2 3)).
	facePatterns at: (Array
			with: false
			with: false
			with: true
			with: true)
		put: #(#(2 4)).
	facePatterns at: (Array
			with: false
			with: true
			with: false
			with: false)
		put: #(#(1 2)).
	facePatterns at: (Array
			with: false
			with: true
			with: false
			with: true)
		put: #(#(1 4) #(3 2)).
	facePatterns at: (Array
			with: false
			with: true
			with: true
			with: false)
		put: #(#(1 3)).
	facePatterns at: (Array
			with: false
			with: true
			with: true
			with: true)
		put: #(#(1 4)).
	facePatterns at: (Array
			with: true
			with: false
			with: false
			with: false)
		put: #(#(4 1)).
	facePatterns at: (Array
			with: true
			with: false
			with: false
			with: true)
		put: #(#(3 1)).
	facePatterns at: (Array
			with: true
			with: false
			with: true
			with: false)
		put: #(#(2 1) #(4 3)).
	facePatterns at: (Array
			with: true
			with: false
			with: true
			with: true)
		put: #(#(2 1)).
	facePatterns at: (Array
			with: true
			with: true
			with: false
			with: false)
		put: #(#(4 2)).
	facePatterns at: (Array
			with: true
			with: true
			with: false
			with: true)
		put: #(#(3 2)).
	facePatterns at: (Array
			with: true
			with: true
			with: true
			with: false)
		put: #(#(4 3)).
	facePatterns at: (Array
			with: true
			with: true
			with: true
			with: true)
		put: #().
	edgeStream := Array new writeStream.
	1 to: 6
		do: 
			[:faceIndex | 
			| pattern |
			pattern := (verticesOnFaces at: faceIndex)
						collect: [:vertexIndex | vertexBits at: vertexIndex].
			edgeStream nextPutAll: ((facePatterns at: pattern)
					collect: [:edges | edges collect: [:edgeIndexOnFace | (edgesOnFaces at: faceIndex)
								at: edgeIndexOnFace]])].
	^edgeStream contents
]

{ #category : #'private - source code generation' }
JunBorderGenerator class >> _aroundPolylinesOnCubeAtIndex: cubeIndex [ 
	"JunBorderGenerator _aroundPolylinesOnCubeAtIndex: 1"
	"JunBorderGenerator _aroundPolylinesOnCubeAtIndex: 21"
	"1 to: 254 do: [ :index | JunBorderGenerator _aroundPolylinesOnCubeAtIndex: index ]"

	| edges polylineStream |
	edges := (self _aroundEdgesOnCubeAtIndex: cubeIndex) asOrderedCollection.
	polylineStream := Array new writeStream.
	[edges isEmpty not]
		whileTrue: 
			[| points nextEdge |
			points := OrderedCollection withAll: edges first.
			edges remove: edges first.
			
			[nextEdge := edges detect: [:edge | edge first = points last]
						ifNone: [nil].
			nextEdge notNil]
				whileTrue: 
					[points addLast: nextEdge last.
					edges remove: nextEdge].
			points first = points last ifFalse: [self halt].
			points removeLast.
			polylineStream nextPut: points asArray].
	^polylineStream contents
]

{ #category : #'private - source code generation' }
JunBorderGenerator class >> _aroundTrianglesOnCubeAtIndex: cubeIndex [ 
	"JunBorderGenerator _aroundTrianglesOnCubeAtIndex: 1"
	"JunBorderGenerator _aroundTrianglesOnCubeAtIndex: 21"

	| triangleIndices facesOfEdges edgeIndicesArray triangleStream newEdgeIndices |
	triangleIndices := Array new: 8.
	triangleIndices at: 1 put: #().
	triangleIndices at: 2 put: #().
	triangleIndices at: 3 put: #(#(1 2 3)).
	triangleIndices at: 4 put: #(#(1 2 3) #(1 3 4)).
	triangleIndices at: 5 put: #(#(1 2 3) #(1 3 4) #(1 4 5)).
	triangleIndices at: 6 put: #(#(2 3 4) #(1 2 4) #(1 4 5) #(1 5 6)).
	triangleIndices at: 7 put: #(#(1 2 7) #(2 6 7) #(2 3 6) #(3 5 6) #(3 4 5)).
	triangleIndices at: 8 put: #(#(1 2 8) #(2 7 8) #(2 3 7) #(3 6 7) #(3 4 6) #(4 5 6)).
	newEdgeIndices := Array new: 8.
	newEdgeIndices at: 1 put: #().
	newEdgeIndices at: 2 put: #().
	newEdgeIndices at: 3 put: #().
	newEdgeIndices at: 4 put: #(#(1 3)).
	newEdgeIndices at: 5 put: #(#(1 3) #(1 4)).
	newEdgeIndices at: 6 put: #(#(1 4) #(1 5) #(2 4)).
	newEdgeIndices at: 7 put: #(#(2 7) #(2 6) #(3 6) #(3 5)).
	newEdgeIndices at: 8 put: #(#(2 8) #(2 7) #(3 7) #(3 6) #(4 6)).
	facesOfEdges := Array new: 12.
	facesOfEdges at: 1 put: #(1 5).
	facesOfEdges at: 2 put: #(1 4).
	facesOfEdges at: 3 put: #(1 6).
	facesOfEdges at: 4 put: #(1 3).
	facesOfEdges at: 5 put: #(2 5).
	facesOfEdges at: 6 put: #(2 4).
	facesOfEdges at: 7 put: #(2 6).
	facesOfEdges at: 8 put: #(2 3).
	facesOfEdges at: 9 put: #(3 5).
	facesOfEdges at: 10 put: #(5 4).
	facesOfEdges at: 11 put: #(4 6).
	facesOfEdges at: 12 put: #(6 3).
	edgeIndicesArray := self _aroundPolylinesOnCubeAtIndex: cubeIndex.
	triangleStream := Array new writeStream.
	edgeIndicesArray
		do: 
			[:edges | 
			| polyline size triangles |
			polyline := edges.
			size := polyline size.
			size < 3 ifTrue: [self halt].
			
			[| newEdges |
			newEdges := (newEdgeIndices at: size)
						collect: [:indices | indices collect: [:index | polyline at: index]].
			newEdges
				contains: 
					[:edgeArray | 
					| faces1 faces2 |
					edgeArray size = 2 ifFalse: [self halt].
					faces1 := facesOfEdges at: edgeArray first.
					faces2 := facesOfEdges at: edgeArray last.
					faces1 contains: [:f | faces2 includes: f]]]
				whileTrue: [polyline := (1 to: size)
								collect: [:index | polyline at: index \\ size + 1]].
			triangles := (triangleIndices at: size)
						collect: [:indices | indices collect: [:index | polyline at: index]].
			triangleStream nextPutAll: triangles].
	^triangleStream contents
]

{ #category : #private }
JunBorderGenerator class >> _edgesWith: evaluationBlock at: aNumber sign: aNumber2 inUnitSquareAt: aPoint do: aBlock [ 
	| x0 x1 y0 y1 index sign |
	x0 := aPoint x.
	x1 := x0 + 1.
	y0 := aPoint y.
	y1 := y0 + 1.
	sign := aNumber2 sign.
	index := 0.
	(evaluationBlock value: x0 value: y1)
		- aNumber * sign >= 0 ifTrue: [index := index + 1].
	(evaluationBlock value: x1 value: y1)
		- aNumber * sign >= 0 ifTrue: [index := index + 2].
	(evaluationBlock value: x1 value: y0)
		- aNumber * sign >= 0 ifTrue: [index := index + 4].
	(evaluationBlock value: x0 value: y0)
		- aNumber * sign >= 0 ifTrue: [index := index + 8].
	(index between: 1 and: 14)
		ifFalse: [^self].
	index = 1
		ifTrue: 
			[aBlock value: (JunBorderVertex
					vertex: x0 @ y0
					vertex: x0 @ y1
					label: aNumber)
				value: (JunBorderVertex
						vertex: x0 @ y1
						vertex: x1 @ y1
						label: aNumber).
			^self].
	index = 2
		ifTrue: 
			[aBlock value: (JunBorderVertex
					vertex: x0 @ y1
					vertex: x1 @ y1
					label: aNumber)
				value: (JunBorderVertex
						vertex: x1 @ y0
						vertex: x1 @ y1
						label: aNumber).
			^self].
	index = 3
		ifTrue: 
			[aBlock value: (JunBorderVertex
					vertex: x0 @ y0
					vertex: x0 @ y1
					label: aNumber)
				value: (JunBorderVertex
						vertex: x1 @ y0
						vertex: x1 @ y1
						label: aNumber).
			^self].
	index = 4
		ifTrue: 
			[aBlock value: (JunBorderVertex
					vertex: x1 @ y0
					vertex: x1 @ y1
					label: aNumber)
				value: (JunBorderVertex
						vertex: x0 @ y0
						vertex: x1 @ y0
						label: aNumber).
			^self].
	index = 5
		ifTrue: 
			["sign < 0" true
				ifTrue: 
					[aBlock value: (JunBorderVertex
								vertex: x0 @ y0
								vertex: x0 @ y1
								label: aNumber)
						value: (JunBorderVertex
							vertex: x0 @ y0
							vertex: x1 @ y0
							label: aNumber).
					aBlock value: (JunBorderVertex
								vertex: x1 @ y0
								vertex: x1 @ y1
								label: aNumber)
						value: (JunBorderVertex
							vertex: x0 @ y1
							vertex: x1 @ y1
							label: aNumber).
					^self]
				ifFalse: 
					[aBlock value: (JunBorderVertex
							vertex: x1 @ y0
							vertex: x1 @ y1
							label: aNumber)
						value: (JunBorderVertex
								vertex: x0 @ y0
								vertex: x1 @ y0
								label: aNumber).
					aBlock value: (JunBorderVertex
							vertex: x0 @ y0
							vertex: x0 @ y1
							label: aNumber)
						value: (JunBorderVertex
								vertex: x0 @ y1
								vertex: x1 @ y1
								label: aNumber)].
			^self].
	index = 6
		ifTrue: 
			[aBlock value: (JunBorderVertex
					vertex: x0 @ y1
					vertex: x1 @ y1
					label: aNumber)
				value: (JunBorderVertex
						vertex: x0 @ y0
						vertex: x1 @ y0
						label: aNumber).
			^self].
	index = 7
		ifTrue: 
			[aBlock value: (JunBorderVertex
					vertex: x0 @ y0
					vertex: x0 @ y1
					label: aNumber)
				value: (JunBorderVertex
						vertex: x0 @ y0
						vertex: x1 @ y0
						label: aNumber).
			^self].
	index = 8
		ifTrue: 
			[aBlock value: (JunBorderVertex
					vertex: x0 @ y0
					vertex: x1 @ y0
					label: aNumber)
				value: (JunBorderVertex
						vertex: x0 @ y0
						vertex: x0 @ y1
						label: aNumber).
			^self].
	index = 9
		ifTrue: 
			[aBlock value: (JunBorderVertex
					vertex: x0 @ y0
					vertex: x1 @ y0
					label: aNumber)
				value: (JunBorderVertex
						vertex: x0 @ y1
						vertex: x1 @ y1
						label: aNumber).
			^self].
	index = 10
		ifTrue: 
			["sign < 0" true
				ifTrue: 
					[aBlock value: (JunBorderVertex
								vertex: x0 @ y0
								vertex: x1 @ y0
								label: aNumber)
						value: (JunBorderVertex
							vertex: x1 @ y0
							vertex: x1 @ y1
							label: aNumber).
					aBlock value: (JunBorderVertex
								vertex: x0 @ y1
								vertex: x1 @ y1
								label: aNumber)
						value: (JunBorderVertex
							vertex: x0 @ y0
							vertex: x0 @ y1
							label: aNumber)]
				ifFalse: 
					[aBlock value: (JunBorderVertex
							vertex: x0 @ y0
							vertex: x1 @ y0
							label: aNumber)
						value: (JunBorderVertex
								vertex: x0 @ y0
								vertex: x0 @ y1
								label: aNumber).
					aBlock value: (JunBorderVertex
							vertex: x0 @ y1
							vertex: x1 @ y1
							label: aNumber)
						value: (JunBorderVertex
								vertex: x1 @ y0
								vertex: x1 @ y1
								label: aNumber)].
			^self].
	index = 11
		ifTrue: 
			[aBlock value: (JunBorderVertex
					vertex: x0 @ y0
					vertex: x1 @ y0
					label: aNumber)
				value: (JunBorderVertex
						vertex: x1 @ y0
						vertex: x1 @ y1
						label: aNumber).
			^self].
	index = 12
		ifTrue: 
			[aBlock value: (JunBorderVertex
					vertex: x1 @ y0
					vertex: x1 @ y1
					label: aNumber)
				value: (JunBorderVertex
						vertex: x0 @ y0
						vertex: x0 @ y1
						label: aNumber).
			^self].
	index = 13
		ifTrue: 
			[aBlock value: (JunBorderVertex
					vertex: x1 @ y0
					vertex: x1 @ y1
					label: aNumber)
				value: (JunBorderVertex
						vertex: x0 @ y1
						vertex: x1 @ y1
						label: aNumber).
			^self].
	index = 14 ifTrue: [aBlock value: (JunBorderVertex
				vertex: x0 @ y1
				vertex: x1 @ y1
				label: aNumber)
			value: (JunBorderVertex
					vertex: x0 @ y0
					vertex: x0 @ y1
					label: aNumber)]
]

{ #category : #'private - source code generation' }
JunBorderGenerator class >> _installMarchingCubeInitializationMethods [
	"JunBorderGenerator _installMarchingCubeInitializationMethods"

	| stream |
	stream := String new writeStream.
	stream nextPut: $!.
	stream nextPutAll: self name.
	stream nextPutAll: ' class methodsFor: ''class initialization''!'.
	stream cr.
	stream nextPutAll: 'initializeMarchingCubes'.
	stream cr.
	stream tab; nextPutAll: '"JunBorderGenerator initializeMarchingCubes"'.
	stream cr.
	stream tab; nextPutAll: 'MarchingCubes := Array new: 254.'.
	0 to: 15 do: [:methodIndex | stream cr; tab; nextPutAll: 'self initializeMarchingCubes' , methodIndex printString , '.'].
	stream nextPutAll: ' ! !'; cr.
	stream contents readStream fileIn.
	0 to: 15
		do: 
			[:methodIndex | 
			stream := String new writeStream.
			stream nextPutAll: '!'.
			stream nextPutAll: self name.
			stream nextPutAll: ' class methodsFor: ''class initialization''!'.
			stream cr.
			stream nextPutAll: 'initializeMarchingCubes' , methodIndex printString.
			stream cr.
			stream nextPutAll: '"JunBorderGenerator initializeMarchingCubes"'.
			stream cr.
			methodIndex * 16 to: methodIndex * 16 + 16 do: [:index | (index between: 1 and: 254)
					ifTrue: [self _marchingCubeProgramAtIndex: index on: stream]].
			stream nextPutAll: '! !'.
			stream cr.
			stream contents readStream fileIn]
]

{ #category : #'private - source code generation' }
JunBorderGenerator class >> _marchingCubeProgramAtIndex: cubeIndex on: aStream [ 
	"| stream | 
	stream := String new writeStream. 
	JunBorderGenerator _marchingCubeProgramAtIndex: 21 on: stream. 
	^stream contents"
	"1 to: 254 do: [ :index |
			| stream | 
			stream := String new writeStream. 
			JunBorderGenerator _marchingCubeProgramAtIndex: index on: stream. 
			stream contents]"

	| vertexStringForEdges triangleStringBlock triangles |
	vertexStringForEdges := Array new: 12.
	vertexStringForEdges at: 1 put: 'JunBorderVertex vertex: point + (0, 0, 0) vertex: point + (1, 0, 0) label: label'.
	vertexStringForEdges at: 2 put: 'JunBorderVertex vertex: point + (1, 0, 0) vertex: point + (1, 1, 0) label: label'.
	vertexStringForEdges at: 3 put: 'JunBorderVertex vertex: point + (0, 1, 0) vertex: point + (1, 1, 0) label: label'.
	vertexStringForEdges at: 4 put: 'JunBorderVertex vertex: point + (0, 0, 0) vertex: point + (0, 1, 0) label: label'.
	vertexStringForEdges at: 5 put: 'JunBorderVertex vertex: point + (0, 0, 1) vertex: point + (1, 0, 1) label: label'.
	vertexStringForEdges at: 6 put: 'JunBorderVertex vertex: point + (1, 0, 1) vertex: point + (1, 1, 1) label: label'.
	vertexStringForEdges at: 7 put: 'JunBorderVertex vertex: point + (0, 1, 1) vertex: point + (1, 1, 1) label: label'.
	vertexStringForEdges at: 8 put: 'JunBorderVertex vertex: point + (0, 0, 1) vertex: point + (0, 1, 1) label: label'.
	vertexStringForEdges at: 9 put: 'JunBorderVertex vertex: point + (0, 0, 0) vertex: point + (0, 0, 1) label: label'.
	vertexStringForEdges at: 10 put: 'JunBorderVertex vertex: point + (1, 0, 0) vertex: point + (1, 0, 1) label: label'.
	vertexStringForEdges at: 11 put: 'JunBorderVertex vertex: point + (1, 1, 0) vertex: point + (1, 1, 1) label: label'.
	vertexStringForEdges at: 12 put: 'JunBorderVertex vertex: point + (0, 1, 0) vertex: point + (0, 1, 1) label: label'.
	triangleStringBlock := 
			[:edgeIndices | 
			| v1 v2 v3 |
			v1 := vertexStringForEdges at: (edgeIndices at: 1).
			v2 := vertexStringForEdges at: (edgeIndices at: 2).
			v3 := vertexStringForEdges at: (edgeIndices at: 3).
			aStream nextPutAll: 'Array with: ('.
			aStream nextPutAll: v1.
			aStream nextPutAll: ') with: ('.
			aStream nextPutAll: v2.
			aStream nextPutAll: ') with: ('.
			aStream nextPutAll: v3.
			aStream nextPutAll: ')'].
	triangles := self _aroundTrianglesOnCubeAtIndex: cubeIndex.
	aStream nextPutAll: 'MarchingCubes at: ' , cubeIndex printString , 'put: '.
	aStream cr; tab; nextPutAll: ' [ :point :label |'.
	aStream cr; tab; nextPutAll: '| triangles |'.
	aStream cr; tab; nextPutAll: 'triangles := Array new: ' , triangles size printString , '.'.
	1 to: triangles size
		do: 
			[:index | 
			aStream cr; tab; tab; nextPutAll: 'triangles at: ' , index printString , ' put: ('.
			triangleStringBlock value: (triangles at: index).
			aStream nextPutAll: ').'].
	aStream cr; tab; nextPutAll: 'triangles].'.
	aStream cr
]

{ #category : #private }
JunBorderGenerator class >> _trianglesWith: evaluationBlock at: aNumber sign: aNumber2 inUnitCubeAt: aJun3dPoint do: aBlock [ 
	| x0 x1 y0 y1 z0 z1 index sign |
	x0 := aJun3dPoint x rounded.
	x1 := x0 + 1.
	y0 := aJun3dPoint y rounded.
	y1 := y0 + 1.
	z0 := aJun3dPoint z rounded.
	z1 := z0 + 1.
	sign := aNumber2 sign.
	index := 0.
	(evaluationBlock value: x0 value: y0 value: z0)
		- aNumber * sign > 0 ifTrue: [index := index + 1].
	(evaluationBlock value: x1 value: y0 value: z0)
		- aNumber * sign > 0 ifTrue: [index := index + 2].
	(evaluationBlock value: x1 value: y1 value: z0)
		- aNumber * sign > 0 ifTrue: [index := index + 4].
	(evaluationBlock value: x0 value: y1 value: z0)
		- aNumber * sign > 0 ifTrue: [index := index + 8].
	(evaluationBlock value: x0 value: y0 value: z1)
		- aNumber * sign > 0 ifTrue: [index := index + 16].
	(evaluationBlock value: x1 value: y0 value: z1)
		- aNumber * sign > 0 ifTrue: [index := index + 32].
	(evaluationBlock value: x1 value: y1 value: z1)
		- aNumber * sign > 0 ifTrue: [index := index + 64].
	(evaluationBlock value: x0 value: y1 value: z1)
		- aNumber * sign > 0 ifTrue: [index := index + 128].
	(index between: 1 and: 254)
		ifFalse: [^self].
	((MarchingCubes at: index) value: aJun3dPoint value: aNumber) do: aBlock.
	^index
]

{ #category : #'2D examples' }
JunBorderGenerator class >> circleExample [
	"JunBorderGenerator circleExample."

	| center circle |
	center := 0 , 0.
	JunCursors cameraCursor showWhile: 
			[circle := JunBorderGenerator 
						polygonalBoundaryWith: [:x :y | center distance: x , y]
						max: 1
						xInterval: (-1.1 to: 1.1 by: 0.1)
						yInterval: (-1.1 to: 1.1 by: 0.1)
						interim: nil.
			(circle asJunOpenGL3dObject)
				paint: ColorValue blue;
				show].
	^circle
]

{ #category : #'solid modeling functions' }
JunBorderGenerator class >> contourBodyFrom: evaluationBlock at: aNumber sign: aNumber2 xInterval: xInterval yInterval: yInterval zInterval: zInterval interim: interimBlock [ 
	| body vertices interpolationBlock backloops triangleCreationBlock0 triangleCreationBlock1 triangleCreationBlock2 triangleCreationBlock3 edgeCreationBlock triangleCreationBlock |
	body := JunBody new.
	vertices := Dictionary new.
	backloops := OrderedCollection new.
	interpolationBlock := 
			[:vertex | 
			| x1 y1 z1 x2 y2 z2 value1 value2 t p1 p2 |
			x1 := xInterval at:(( vertex vertex1 x rounded max: 1) min: xInterval size - 1).
			y1 := yInterval at: ((vertex vertex1 y rounded max: 1) min: yInterval size - 1).
			z1 := zInterval at: ((vertex vertex1 z rounded max: 1) min: zInterval size - 1).
			x2 := xInterval at: ((vertex vertex2 x rounded max: 1) min: xInterval size - 1).
			y2 := yInterval at: ((vertex vertex2 y rounded max: 1) min: yInterval size - 1).
			z2 := zInterval at: ((vertex vertex2 z rounded max: 1) min: zInterval size - 1).
			value1 := (evaluationBlock
						value: x1
						value: y1
						value: z1) asRational.
			value2 := (evaluationBlock
						value: x2
						value: y2
						value: z2) asRational.
			t := value1 = value2
						ifTrue: [0]
						ifFalse: [vertex label asRational - value1 / (value2 - value1)].
			t := (t max: 0)
						min: 1.
			p1 := x1 , y1 , z1.
			p2 := x2 , y2 , z2.
			p2 - p1 * t + p1].
	edgeCreationBlock := [:vertex1 :vertex2 | (vertex1 hasEdgeToVertex: vertex2)
				ifFalse: 
					[| loop |
					loop := vertex1 commonLoopWithVertex: vertex2.
					loop notNil
						ifTrue: 
							[| mel |
							mel := JunMEL
										body: body
										loop: loop
										vertex: vertex1
										vertex: vertex2.
							mel do.
							backloops add: mel newLoop]
						ifFalse: 
							[| loop1 loop2 mekl |
							loop1 := vertex1 loops select: [:l | backloops includes: l].
							loop1 asSet size ~= 1 ifTrue: [self halt].
							loop1 := loop1 first.
							loop2 := vertex2 loops select: [:l | backloops includes: l].
							loop2 asSet size ~= 1 ifTrue: [self halt].
							loop2 := loop2 first.
							mekl := JunMEKL
										body: body
										killLoop: loop1
										aliveLoop: loop2
										vertex: vertex1
										vertex: vertex2.
							mekl do.
							backloops remove: loop1]]].
	triangleCreationBlock0 := 
			[:point1 :point2 :point3 | 
			| vertex1 vertex2 vertex3 loop mevvl mev mel |
			mevvl := JunMEVVL
						body: body
						point: (interpolationBlock value: point1)
						point: (interpolationBlock value: point2).
			mevvl do.
			vertex1 := vertices at: point1 put: mevvl newVertex1.
			vertex2 := vertices at: point2 put: mevvl newVertex2.
			loop := mevvl newLoop.
			mev := JunMEV
						body: body
						vertex: vertex2
						loop: loop
						point: (interpolationBlock value: point3).
			mev do.
			vertex3 := vertices at: point3 put: mev newVertex.
			mel := JunMEL
						body: body
						loop: loop
						vertex: vertex3
						vertex: vertex1.
			mel do.
			backloops add: (vertex1 loopToVertex: vertex3)].
	triangleCreationBlock1 := 
			[:vertex1 :point2 :point3 | 
			| loop vertex2 vertex3 mev mel foreloop |
			loop := vertex1 detectLoop: [:l | backloops includes: l]
						ifNone: [nil].
			mev := JunMEV
						body: body
						vertex: vertex1
						loop: loop
						point: (interpolationBlock value: point2).
			mev do.
			vertex2 := vertices at: point2 put: mev newVertex.
			mev := JunMEV
						body: body
						vertex: vertex2
						loop: loop
						point: (interpolationBlock value: point3).
			mev do.
			vertex3 := vertices at: point3 put: mev newVertex.
			mel := JunMEL
						body: body
						loop: loop
						vertex: vertex3
						vertex: vertex1.
			mel do.
			backloops add: mel newLoop.
			foreloop := vertex1 loopToVertex: vertex2.
			foreloop numberOfVertexes > 3 ifTrue: [self halt].
			(foreloop includesVertex: vertex1)
				ifFalse: [self halt].
			(foreloop includesVertex: vertex2)
				ifFalse: [self halt].
			(foreloop includesVertex: vertex3)
				ifFalse: [self halt].
			backloops remove: foreloop].
	triangleCreationBlock2 := 
			[:vertex1 :vertex2 :point3 | 
			| vertex3 loop mev mel foreloop |
			edgeCreationBlock value: vertex1 value: vertex2.
			loop := vertex1 loopToVertex: vertex2.
			mev := JunMEV
						body: body
						vertex: vertex2
						loop: loop
						point: (interpolationBlock value: point3).
			mev do.
			vertex3 := vertices at: point3 put: mev newVertex.
			mel := JunMEL
						body: body
						loop: loop
						vertex: vertex3
						vertex: vertex1.
			mel do.
			backloops add: mel newLoop.
			foreloop := vertex1 loopToVertex: vertex2.
			foreloop numberOfVertexes > 3 ifTrue: [self halt].
			backloops remove: foreloop].
	triangleCreationBlock3 := 
			[:vertex1 :vertex2 :vertex3 | 
			| foreloop mel |
			edgeCreationBlock value: vertex1 value: vertex2.
			foreloop := vertex1 loopToVertex: vertex2.
			edgeCreationBlock value: vertex2 value: vertex3.
			foreloop := vertex1 loopToVertex: vertex2.
			foreloop == (vertex2 loopToVertex: vertex3) ifFalse: [self halt].
			(vertex3 hasEdgeToVertex: vertex1)
				ifFalse: 
					[mel := JunMEL
								body: body
								loop: foreloop
								vertex: vertex3
								vertex: vertex1.
					mel do.
					backloops add: mel newLoop].
			foreloop := vertex1 loopToVertex: vertex2.
			foreloop numberOfVertexes > 3 ifTrue: [self halt].
			(foreloop includesVertex: vertex1)
				ifFalse: [self halt].
			(foreloop includesVertex: vertex2)
				ifFalse: [self halt].
			(foreloop includesVertex: vertex3)
				ifFalse: [self halt].
			backloops remove: foreloop].
	triangleCreationBlock := 
			[:triangle | 
			| vertex1 vertex2 vertex3 |
			vertex1 := vertices at: (triangle at: 1)
						ifAbsent: [nil].
			vertex2 := vertices at: (triangle at: 2)
						ifAbsent: [nil].
			vertex3 := vertices at: (triangle at: 3)
						ifAbsent: [nil].
			vertex1 notNil
				ifTrue: [vertex2 notNil
						ifTrue: [vertex3 notNil
								ifTrue: [triangleCreationBlock3
										value: vertex1
										value: vertex2
										value: vertex3]
								ifFalse: [triangleCreationBlock2
										value: vertex1
										value: vertex2
										value: (triangle at: 3)]]
						ifFalse: [vertex3 notNil
								ifTrue: [triangleCreationBlock2
										value: vertex3
										value: vertex1
										value: (triangle at: 2)]
								ifFalse: [triangleCreationBlock1
										value: vertex1
										value: (triangle at: 2)
										value: (triangle at: 3)]]]
				ifFalse: [vertex2 notNil
						ifTrue: [vertex3 notNil
								ifTrue: [triangleCreationBlock2
										value: vertex2
										value: vertex3
										value: (triangle at: 1)]
								ifFalse: [triangleCreationBlock1
										value: vertex2
										value: (triangle at: 3)
										value: (triangle at: 1)]]
						ifFalse: [vertex3 notNil
								ifTrue: [triangleCreationBlock1
										value: vertex3
										value: (triangle at: 1)
										value: (triangle at: 2)]
								ifFalse: [triangleCreationBlock0 valueWithArguments: triangle]]]].
	0 to: zInterval size
		do: 
			[:zIndex | 
			0 to: yInterval size do: [:yIndex | 0 to: xInterval size do: [:xIndex | self
						_trianglesWith: [:x :y :z | ((x between: 1 and: xInterval size - 1)
								and: [(y between: 1 and: yInterval size - 1)
										and: [z between: 1 and: zInterval size - 1]])
								ifTrue: [evaluationBlock
										value: (xInterval at: x)
										value: (yInterval at: y)
										value: (zInterval at: z)]
								ifFalse: [aNumber]]
						at: aNumber
						sign: aNumber2
						inUnitCubeAt: xIndex , yIndex , zIndex
						do: triangleCreationBlock]].
			interimBlock value: body].
	backloops isEmpty ifFalse: [self halt].
	^body
]

{ #category : #'3D functions' }
JunBorderGenerator class >> contourPolygonsFrom: evaluationBlock at: aNumber sign: aNumber2 xInterval: xInterval yInterval: yInterval zInterval: zInterval interim: interimBlock [ 
	| polygonStream |
	polygonStream := Array new writeStream.
	1 to: zInterval size - 1
		do: 
			[:zIndex | 
			1 to: yInterval size - 1 do: [:yIndex | 1 to: xInterval size - 1 do: [:xIndex | self
						_trianglesWith: [:x :y :z | evaluationBlock
								value: (xInterval at: x)
								value: (yInterval at: y)
								value: (zInterval at: z)]
						at: aNumber
						sign: aNumber2
						inUnitCubeAt: xIndex , yIndex , zIndex
						do: 
							[:triangle | 
							| polygon |
							polygon := Jun3dPolygon points: (triangle
											collect: 
												[:vertex | 
												| x1 y1 z1 x2 y2 z2 value1 value2 t p1 p2 |
												x1 := xInterval at: vertex vertex1 x rounded.
												y1 := yInterval at: vertex vertex1 y rounded.
												z1 := zInterval at: vertex vertex1 z rounded.
												x2 := xInterval at: vertex vertex2 x rounded.
												y2 := yInterval at: vertex vertex2 y rounded.
												z2 := zInterval at: vertex vertex2 z rounded.
												value1 := (evaluationBlock
															value: x1
															value: y1
															value: z1) asRational.
												value2 := (evaluationBlock
															value: x2
															value: y2
															value: z2) asRational.
												t := value1 = value2
															ifTrue: [0]
															ifFalse: [vertex label asRational - value1 / (value2 - value1)].
												t := (t max: 0)
															min: 1.
												p1 := x1 , y1 , z1.
												p2 := x2 , y2 , z2.
												p2 - p1 * t + p1]).
							polygon notNil ifTrue: [polygonStream nextPut: polygon]]]].
			interimBlock value: polygonStream contents].
	^polygonStream contents
]

{ #category : #'3D functions' }
JunBorderGenerator class >> contourPolygonsFrom: evaluationBlock at: aNumber xInterval: xInterval yInterval: yInterval zInterval: zInterval interim: interimBlock [ 
	^self
		contourPolygonsFrom: evaluationBlock
		at: aNumber
		sign: 1
		xInterval: xInterval
		yInterval: yInterval
		zInterval: zInterval
		interim: interimBlock
]

{ #category : #'2D functions' }
JunBorderGenerator class >> contourPolylinesFrom: evaluationBlock at: aNumber xInterval: xInterval yInterval: yInterval interim: interimBlock [ 
	| danglingPolyedges maxX maxY edgeInsertionBlock border onBorderBlock completedBlock polylines |
	danglingPolyedges := JunDoubleLinkedList new.
	maxX := xInterval size.
	maxY := yInterval size.
	border := 1 @ 1 corner: maxX @ maxY.
	onBorderBlock := 
			[:polyedge | 
			| firstVertex lastVertex |
			firstVertex := polyedge first.
			lastVertex := polyedge last.
			(firstVertex onBorderOfRectangle: border)
				and: [lastVertex onBorderOfRectangle: border]].
	polylines := Array new writeStream.
	completedBlock := 
			[:polyedge | 
			| polyline |
			polyline := Polyline vertices: (polyedge
							collect: 
								[:vertex | 
								| x0 x1 y0 y1 value0 value1 interpolation |
								x0 := xInterval at: vertex vertex1 x.
								x1 := xInterval at: vertex vertex2 x.
								y0 := yInterval at: vertex vertex1 y.
								y1 := yInterval at: vertex vertex2 y.
								value0 := evaluationBlock value: x0 value: y0.
								value1 := evaluationBlock value: x1 value: y1.
								value0 = value1
									ifTrue: [interpolation := 0]
									ifFalse: [interpolation := vertex label - value0 / (value1 - value0)].
								interpolation * (x1 @ y1 - (x0 @ y0)) + (x0 @ y0)]).
			polylines nextPut: polyline.
			interimBlock notNil ifTrue: [interimBlock value: polylines contents]].
	edgeInsertionBlock := 
			[:from :to | 
			| leadingPolyedge trailingPolyedge |
			leadingPolyedge := danglingPolyedges detect: [:polyedge | from = polyedge last]
						ifNone: [nil].
			trailingPolyedge := danglingPolyedges detect: [:polyedge | to = polyedge first]
						ifNone: [nil].
			leadingPolyedge isNil
				ifTrue: [trailingPolyedge isNil
						ifTrue: 
							[| newPolyedge |
							newPolyedge := OrderedCollection with: from with: to.
							(onBorderBlock value: newPolyedge)
								ifTrue: [completedBlock value: newPolyedge]
								ifFalse: [danglingPolyedges add: newPolyedge]]
						ifFalse: 
							[trailingPolyedge addFirst: from.
							(onBorderBlock value: trailingPolyedge)
								ifTrue: 
									[danglingPolyedges remove: trailingPolyedge ifAbsent: [].
									completedBlock value: trailingPolyedge]]]
				ifFalse: [trailingPolyedge isNil
						ifTrue: 
							[leadingPolyedge addLast: to.
							(onBorderBlock value: leadingPolyedge)
								ifTrue: 
									[danglingPolyedges remove: leadingPolyedge ifAbsent: [].
									completedBlock value: leadingPolyedge]]
						ifFalse: [leadingPolyedge == trailingPolyedge
								ifTrue: 
									[leadingPolyedge addLast: to.
									danglingPolyedges remove: leadingPolyedge ifAbsent: [].
									completedBlock value: leadingPolyedge]
								ifFalse: 
									[leadingPolyedge addAllLast: trailingPolyedge.
									danglingPolyedges remove: trailingPolyedge ifAbsent: [].
									(onBorderBlock value: leadingPolyedge)
										ifTrue: 
											[danglingPolyedges remove: leadingPolyedge ifAbsent: [].
											completedBlock value: leadingPolyedge]]]]].
	1 to: xInterval size - 1 do: [:xIndex | 1 to: yInterval size - 1 do: [:yIndex | self
				_edgesWith: [:x :y | evaluationBlock value: (xInterval at: x)
						value: (yInterval at: y)]
				at: aNumber
				sign: 1
				inUnitSquareAt: xIndex @ yIndex
				do: edgeInsertionBlock]].
	^polylines contents
]

{ #category : #copyright }
JunBorderGenerator class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #'2D examples' }
JunBorderGenerator class >> cutFigureExample [
	"JunBorderGenerator cutFigureExample."

	| image scale viewer display boundary |
	image := JunImageUtility fromScreen: (2 @ 2 extent: 128 @ 128).
	scale := image width max: image height.
	viewer := JunOpenGLDisplayModel new.
	viewer defaultProjectionTable: ((Dictionary new)
				add: #eyePoint -> (((0 , scale) * -3 , scale) * 4);
				add: #sightPoint -> (0 , 0 , scale);
				add: #upVector -> (0 , 1 , 0);
				add: #projection -> #parallelProjection;
				yourself).
	viewer open.
	display := JunImageDisplayModel show: image
				at: viewer getWindow displayBox topRight + (8 @ 0).
	JunCursors cameraCursor showWhile: 
			[0.0 to: 0.9
				by: 0.1
				do: 
					[:brightness | 
					| pixmap gc body compound |
					boundary := JunBorderGenerator 
								polygonalBoundaryWith: [:x :y | (image valueAtPoint: x @ y) brightness]
								min: brightness
								max: 1
								xInterval: (0 to: image width - 1)
								yInterval: (0 to: image height - 1)
								interim: [:b | ].
					viewer 
						assert: [pixmap := image asRetainedMedium]
						do: 
							[gc := pixmap graphicsContext.
							gc paint: ColorValue blue.
							boundary polygons do: [:polygon | polygon displayOn: gc].
							display
								image: pixmap asImage;
								redisplay]
						ensure: [pixmap close].
					body := JunOpenGL3dCompoundObject new.
					((boundary scaledBy: 2 @ -2) 
						translatedBy: image width negated @ image height) asJunOpenGL3dObjectsDo: 
								[:object | 
								object paint: (ColorValue brightness: brightness).
								body add: object].
					compound := JunOpenGL3dCompoundObject new.
					compound add: (JunOpenGL3dTransformedObject object: body
								transformation: ((0 , 0 , brightness) * scale * 2) 
										transformationToTranslate).
					viewer displayObject 
						ifNotNil: [:it | compound := compound class with: it with: compound].
					viewer displayObject: compound.
					viewer resetView]].
	^boundary
]

{ #category : #'solid model examples' }
JunBorderGenerator class >> electricFieldBodyExample [
	"JunBorderGenerator electricFieldBodyExample"

	| qs ps displayModel es paints bodies |
	qs := #(1 3 -2 -4).
	ps := Array
				with: 1 , 0 , 0
				with: -1 , 0 , 0
				with: 0 , 1 , 0
				with: 0 , -1 , 0.
	es := Array
				with: 1
				with: 0
				with: -1.
	paints := Array
				with: ColorValue blue
				with: ColorValue yellow
				with: ColorValue red.
	displayModel := JunOpenGLDisplayModel new.
	displayModel open.
	displayModel displayObject: (JunOpenGL3dCompoundObject new paint: ColorValue blue).
	JunCursors cameraCursor showWhile: [bodies := (1 to: es size)
					collect: 
						[:index | 
						| currentDisplayObject lastNumPolygons |
						currentDisplayObject := JunOpenGL3dCompoundObject new.
						currentDisplayObject paint: (paints at: index).
						displayModel displayObject add: currentDisplayObject.
						lastNumPolygons := 0.
						JunBorderGenerator
							contourBodyFrom: 
								[:x :y :z | 
								| e |
								e := 0.
								qs with: ps
									do: 
										[:q :p | 
										| d |
										d := x , y , z distance: p.
										d < p class accuracy
											ifTrue: [e := e + q]
											ifFalse: [e := e + (q / d squared)]].
								e]
							at: (es at: index)
							sign: 1
							xInterval: (-2.2 to: 2.2 by: 0.4)
							yInterval: (-2.2 to: 2.2 by: 0.4)
							zInterval: (-2.2 to: 2.2 by: 0.4)
							interim: [:body | body numberOfLoops ~= lastNumPolygons
									ifTrue: 
										[currentDisplayObject components: (body asJunOpenGL3dObject paint: (paints at: index)) components.
										displayModel fitZoom.
										lastNumPolygons := body numberOfLoops]]]].
	^bodies
]

{ #category : #'3D examples' }
JunBorderGenerator class >> electricFieldExample [
	"JunBorderGenerator electricFieldExample."

	| qs ps es paints viewer block contours |
	qs := #(1 3 -2 -4).
	ps := Array 
				with: 1 , 0 , 0
				with: -1 , 0 , 0
				with: 0 , 1 , 0
				with: 0 , -1 , 0.
	es := Array 
				with: 1
				with: 0
				with: -1.
	paints := Array 
				with: ColorValue blue
				with: ColorValue yellow
				with: ColorValue red.
	viewer := JunOpenGLDisplayModel new.
	viewer open.
	block := 
			[:polygons :index | 
			viewer do: 
					[| compound |
					compound := JunOpenGL3dCompoundObject new.
					polygons do: 
							[:polygon | 
							| body |
							body := polygon asJunOpenGL3dObjectColor: (paints at: index).
							compound add: body].
					viewer displayObject 
						ifNotNil: [:it | compound := compound class with: it with: compound].
					viewer displayObject: compound.
					viewer resetView]
				forMilliseconds: 500].
	contours := OrderedCollection new.
	JunCursors cameraCursor showWhile: 
			[| contour |
			1 to: es size
				do: 
					[:index | 
					| last |
					last := 0.
					contour := JunBorderGenerator 
								contourPolygonsFrom: 
									[:x :y :z | 
									| e |
									e := 0.
									qs with: ps
										do: 
											[:q :p | 
											| d |
											d := x , y , z distance: p.
											d < p class accuracy 
												ifTrue: [e := e + q]
												ifFalse: [e := e + (q / d squared)]].
									e yourself]
								at: (es at: index)
								sign: 1
								xInterval: (-2 to: 2 by: 0.3)
								yInterval: (-2 to: 2 by: 0.3)
								zInterval: (-2 to: 2 by: 0.3)
								interim: 
									[:polygons | 
									polygons size = last 
										ifFalse: 
											[block value: polygons value: index.
											last := polygons size]].
					contours add: contour]].
	^contours
]

{ #category : #'2D examples' }
JunBorderGenerator class >> ellipseExample [
	"JunBorderGenerator ellipseExample."

	| center1 center2 circle |
	center1 := -0.4 , 0.
	center2 := 0.4 , 0.
	JunCursors cameraCursor showWhile: 
			[circle := JunBorderGenerator 
						polygonalBoundaryWith: 
							[:x :y | 
							| p |
							p := x , y.
							(p distance: center1) + (p distance: center2)]
						max: 1
						xInterval: (-1.1 to: 1.1 by: 0.1)
						yInterval: (-1.1 to: 1.1 by: 0.1)
						interim: nil.
			(circle asJunOpenGL3dObject)
				paint: ColorValue blue;
				show].
	^circle
]

{ #category : #'2D examples' }
JunBorderGenerator class >> imageContouringExample [
	"JunBorderGenerator imageContouringExample."

	| image scale compound polygon texture viewer polylines |
	image := JunImageUtility fromScreen: (2 @ 2 extent: 128 @ 128).
	scale := image width max: image height.
	compound := JunOpenGL3dCompoundObject new.
	polygon := JunOpenGL3dPolygon vertexes: (Array 
						with: image width negated , image height negated , 0
						with: image width , image height negated , 0
						with: image width , image height , 0
						with: image width negated , image height , 0).
	polygon paint: ColorValue white.
	texture := JunOpenGLTexture image: image.
	polygon texture: texture.
	texture zPositiveParameters.
	compound add: polygon.
	viewer := compound showProjectionTable: ((Dictionary new)
						add: #eyePoint -> (((0 , scale) * -2 , scale) * 2);
						add: #sightPoint -> ((0 , 0 , scale) / 2);
						add: #upVector -> (0 , 1 , 0);
						add: #projection -> #parallelProjection;
						yourself).
	JunCursors cameraCursor showWhile: 
			[0 to: 1
				by: 0.1
				do: 
					[:brightness | 
					polylines := JunBorderGenerator 
								contourPolylinesFrom: [:x :y | (image valueAtPoint: x @ y) brightness]
								at: brightness
								xInterval: (0 to: image width - 1)
								yInterval: (0 to: image height - 1)
								interim: [:ps | ].
					viewer displayObject 
						addAll: (polylines collect: 
									[:polyline | 
									JunOpenGL3dPolyline 
										vertexes: (polyline vertices collect: 
													[:point | 
													(point x * 2 - image width + 3 , (image height - (point y * 2))) - 2 
														, (brightness * scale)])
										paint: (ColorValue 
												hue: 0
												saturation: 0
												brightness: brightness)]).
					viewer resetView]].
	^polylines
]

{ #category : #'3D examples' }
JunBorderGenerator class >> imageLandscapeExample [
	"JunBorderGenerator imageLandscapeExample."

	| image width height scale viewer block contour |
	image := JunImageUtility fromScreen: (0 @ 0 extent: 100 @ 100).
	width := image width.
	height := image height.
	scale := (width min: height) / 4.
	viewer := JunOpenGLDisplayModel new.
	viewer defaultProjectionTable: ((Dictionary new)
				add: #eyePoint -> (width / 2 , height negated , (height * 2));
				add: #sightPoint -> (width / 2 , (height / 2) , (scale / 2));
				add: #upVector -> (0 , 1 , 0);
				yourself).
	viewer open.
	block := 
			[:polygons | 
			viewer do: 
					[| compound |
					compound := JunOpenGL3dCompoundObject new.
					polygons do: 
							[:polygon | 
							| body |
							body := polygon asJunOpenGL3dObjectColor: ColorValue red.
							compound add: body].
					viewer displayObject: compound.
					viewer resetView]
				forMilliseconds: 1000].
	JunCursors cameraCursor showWhile: 
			[| last |
			last := 0.
			contour := JunBorderGenerator 
						contourPolygonsFrom: 
							[:x :y :z | 
							| p |
							p := (x - 1) rounded @ (height - y) rounded.
							(image valueAtPoint: p) brightness * scale - z]
						at: 0
						sign: 1
						xInterval: (1 to: width by: 1)
						yInterval: (1 to: height by: 1)
						zInterval: (scale / -4 to: scale * 5 / 4 by: scale / 4)
						interim: 
							[:polygons | 
							polygons size = last 
								ifFalse: 
									[block value: polygons.
									last := polygons size]]].
	^contour
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initialize [
	"JunBorderGenerator initialize."

	self initializeMarchingCubes
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes := Array new: 254.
	self initializeMarchingCubes0.
	self initializeMarchingCubes1.
	self initializeMarchingCubes2.
	self initializeMarchingCubes3.
	self initializeMarchingCubes4.
	self initializeMarchingCubes5.
	self initializeMarchingCubes6.
	self initializeMarchingCubes7.
	self initializeMarchingCubes8.
	self initializeMarchingCubes9.
	self initializeMarchingCubes10.
	self initializeMarchingCubes11.
	self initializeMarchingCubes12.
	self initializeMarchingCubes13.
	self initializeMarchingCubes14.
	self initializeMarchingCubes15.
	^MarchingCubes
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes0 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 1
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 2
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 3
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 4
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 5
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles].
	MarchingCubes at: 6
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 7
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 8
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 9
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 10
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles].
	MarchingCubes at: 11
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 12
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 13
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 14
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 15
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 16
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes1 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 17
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 18
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 19
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 20
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 21
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles].
	MarchingCubes at: 22
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 23
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 24
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles].
	MarchingCubes at: 25
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 26
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 27
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 28
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 29
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 30
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 31
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 32
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes10 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 161
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 162
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 163
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 164
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 165
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 166
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 167
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 168
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 169
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 170
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 171
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 172
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 173
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 174
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 175
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 176
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes11 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 177
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 178
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 179
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 180
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 181
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 182
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 183
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 184
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 185
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 186
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 187
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 188
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 189
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 190
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 191
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 192
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes12 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 193
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 194
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 195
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 196
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 197
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 198
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 199
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 200
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 201
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 202
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 203
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 204
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 205
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 206
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 207
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 208
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes13 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 209
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 210
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 211
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 212
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 213
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 214
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 215
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 216
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 217
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 218
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 219
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 220
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 221
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 222
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 223
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 224
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes14 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 225
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 226
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 227
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 228
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 229
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 230
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 231
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 232
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 233
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 234
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 235
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 236
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 237
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 238
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 239
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 240
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes15 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 241
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 242
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 243
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 244
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 245
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 246
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 247
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 248
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 249
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 250
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 251
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 252
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 253
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 254
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes2 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 33
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles].
	MarchingCubes at: 34
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 35
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 36
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 37
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 38
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 39
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 40
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 41
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 42
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles].
	MarchingCubes at: 43
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 44
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 45
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 46
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 47
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 48
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes3 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 49
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 50
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 51
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 52
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 53
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 54
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 55
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 56
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 57
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 58
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 59
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 60
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 61
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 62
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 63
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 64
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes4 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 65
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 66
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles].
	MarchingCubes at: 67
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 68
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 69
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles].
	MarchingCubes at: 70
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 71
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 72
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 73
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 74
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 75
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 76
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 77
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 78
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 79
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 80
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes5 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 81
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 82
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 83
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 84
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 85
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 86
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 87
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 88
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 89
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 90
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 91
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 92
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 93
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 94
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 95
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 96
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes6 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 97
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 98
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 99
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 100
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 101
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 102
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 103
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 104
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 105
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 106
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 107
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 108
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 109
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 110
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 111
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 112
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes7 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 113
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 114
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 115
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 116
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 117
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 118
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 119
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 120
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 121
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 122
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 123
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 124
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 125
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 126
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 127
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 128
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 1.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes8 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 129
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 130
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 131
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 132
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles].
	MarchingCubes at: 133
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 134
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 135
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 136
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 137
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 138
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles].
	MarchingCubes at: 139
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 140
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 141
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 142
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 143
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 144
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> initializeMarchingCubes9 [
	"JunBorderGenerator initializeMarchingCubes."

	MarchingCubes at: 145
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 146
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 147
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 148
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 5.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 5
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 149
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 150
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 151
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 152
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 153
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 154
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 155
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 156
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 157
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 158
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 3.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 1 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (1 , 0 , 0)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 0)
								vertex: point + (0 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 159
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 2.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 1 , 0)
								vertex: point + (1 , 1 , 1)
								label: label)).
			triangles].
	MarchingCubes at: 160
		put: 
			[:point :label | 
			| triangles |
			triangles := Array new: 4.
			triangles at: 1
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 2
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 1)
								vertex: point + (1 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 3
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (1 , 0 , 0)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)).
			triangles at: 4
				put: (Array 
						with: (JunBorderVertex 
								vertex: point + (0 , 1 , 0)
								vertex: point + (0 , 1 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (1 , 0 , 1)
								label: label)
						with: (JunBorderVertex 
								vertex: point + (0 , 0 , 1)
								vertex: point + (0 , 1 , 1)
								label: label)).
			triangles]
]

{ #category : #'class initialization' }
JunBorderGenerator class >> install [
	"JunBorderGenerator install"

	self initialize
]

{ #category : #'3D examples' }
JunBorderGenerator class >> jun3dLogo [
	"JunBorderGenerator jun3dLogo."

	| image weight viewer block contour |
	image := JunSystem logoImage.
	weight := 3.
	viewer := JunOpenGLDisplayModel new.
	viewer defaultProjectionTable: ((Dictionary new)
				add: #eyePoint -> (image bounds center , 1000);
				add: #sightPoint -> (image bounds center , 0);
				add: #upVector -> (0 , 1 , 0);
				yourself).
	viewer open.
	block := 
			[:polygons | 
			| compound |
			compound := JunOpenGL3dCompoundObject 
						components: (polygons collect: 
									[:polygon | 
									(polygon asJunOpenGL3dObjectColor: ColorValue blue) 
										translatedBy: 0 , 0 , 0]).
			viewer displayObject: compound.
			viewer resetView].
	JunCursors cameraCursor showWhile: 
			[| last |
			last := 0.
			contour := JunBorderGenerator 
						contourPolygonsFrom: 
							[:x :y :z | 
							((image valueAtPoint: x @ (image height - y)) brightness squared 
								+ (z / weight) squared) sqrt]
						at: 0.5
						sign: -1
						xInterval: (0 to: image width - 1 by: 2)
						yInterval: (1 to: image height by: 2)
						zInterval: (-4 to: 4 by: 2)
						interim: 
							[:polygons | 
							polygons size = last 
								ifFalse: 
									[block value: polygons.
									last := polygons size]]].
	^contour
]

{ #category : #'2D examples' }
JunBorderGenerator class >> negativeCircleExample [
	"JunBorderGenerator negativeCircleExample."

	| circle |
	JunCursors cameraCursor showWhile: 
			[circle := JunBorderGenerator 
						polygonalBoundaryWith: [:x :y | (x , y) r]
						min: 1
						xInterval: (-1.1 to: 1.1 by: 0.1)
						yInterval: (-1.1 to: 1.1 by: 0.1)
						interim: nil.
			(circle asJunOpenGL3dObject)
				paint: ColorValue blue;
				show].
	^circle
]

{ #category : #'2D functions' }
JunBorderGenerator class >> polygonalBoundaryWith: evaluationBlock max: maxNumber xInterval: xInterval yInterval: yInterval interim: interimBlock [ 
	| danglingPolyedges maxX maxY edgeInsertionBlock completedBlock polygonalBoundary interpolationBlock vertexesOnBorderX0 vertexesOnBorderX1 vertexesOnBorderY0 vertexesOnBorderY1 vertexesOnBorder cornerValue |
	danglingPolyedges := JunDoubleLinkedList new.
	maxX := xInterval size.
	maxY := yInterval size.
	polygonalBoundary := Jun2dPolygonalBoundary new.
	interpolationBlock := 
			[:vertex | 
			| x1 y1 x2 y2 value1 value2 t |
			x1 := xInterval at: vertex vertex1 x.
			y1 := yInterval at: vertex vertex1 y.
			x2 := xInterval at: vertex vertex2 x.
			y2 := yInterval at: vertex vertex2 y.
			value1 := (evaluationBlock value: x1 value: y1) asRational.
			value2 := (evaluationBlock value: x2 value: y2) asRational.
			t := value1 = value2
						ifTrue: [0]
						ifFalse: [vertex label asRational - value1 / (value2 - value1)].
			t := (t max: 0)
						min: 1.
			t asDouble].
	completedBlock := 
			[:polyedge | 
			| points polygon |
			points := polyedge
						collect: 
							[:vertex | 
							| t v1 v2 p1 p2 |
							t := interpolationBlock value: vertex.
							v1 := vertex vertex1.
							v2 := vertex vertex2.
							p1 := (xInterval at: v1 x)
										, (yInterval at: v1 y).
							p2 := (xInterval at: v2 x)
										, (yInterval at: v2 y).
							t * (p2 - p1) + p1].
			polygon := Jun2dPolygon points: points.
			polygonalBoundary add: polygon.
			interimBlock notNil ifTrue: [interimBlock value: polygonalBoundary]].
	edgeInsertionBlock := 
			[:from :to | 
			| leadingPolyedge trailingPolyedge |
			leadingPolyedge := danglingPolyedges detect: [:polyedge | from = polyedge last]
						ifNone: [nil].
			trailingPolyedge := danglingPolyedges detect: [:polyedge | to = polyedge first]
						ifNone: [nil].
			leadingPolyedge isNil
				ifTrue: [trailingPolyedge isNil
						ifTrue: 
							[| newPolyedge |
							newPolyedge := OrderedCollection with: from with: to.
							danglingPolyedges add: newPolyedge]
						ifFalse: [trailingPolyedge addFirst: from]]
				ifFalse: [trailingPolyedge isNil
						ifTrue: [leadingPolyedge addLast: to]
						ifFalse: [leadingPolyedge == trailingPolyedge
								ifTrue: 
									[danglingPolyedges remove: leadingPolyedge ifAbsent: [].
									completedBlock value: leadingPolyedge]
								ifFalse: 
									[leadingPolyedge addAllLast: trailingPolyedge.
									danglingPolyedges remove: trailingPolyedge ifAbsent: []]]]].
	1 to: maxX - 1 do: [:xIndex | 1 to: maxY - 1 do: [:yIndex | self
				_edgesWith: [:x :y | evaluationBlock value: (xInterval at: x)
						value: (yInterval at: y)]
				at: maxNumber
				sign: -1
				inUnitSquareAt: xIndex @ yIndex
				do: edgeInsertionBlock]].
	vertexesOnBorderX0 := Array new writeStream.
	vertexesOnBorderX1 := Array new writeStream.
	vertexesOnBorderY0 := Array new writeStream.
	vertexesOnBorderY1 := Array new writeStream.
	danglingPolyedges
		do: 
			[:polyedge | 
			| firstVertex lastVertex |
			firstVertex := polyedge first.
			lastVertex := polyedge last.
			(firstVertex onX: 1)
				ifTrue: [vertexesOnBorderX0 nextPut: firstVertex vertex1 y + (interpolationBlock value: firstVertex) -> firstVertex].
			(firstVertex onX: maxX)
				ifTrue: [vertexesOnBorderX1 nextPut: firstVertex vertex1 y + (interpolationBlock value: firstVertex) -> firstVertex].
			(firstVertex onY: 1)
				ifTrue: [vertexesOnBorderY0 nextPut: firstVertex vertex1 x + (interpolationBlock value: firstVertex) -> firstVertex].
			(firstVertex onY: maxY)
				ifTrue: [vertexesOnBorderY1 nextPut: firstVertex vertex1 x + (interpolationBlock value: firstVertex) -> firstVertex].
			(lastVertex onX: 1)
				ifTrue: [vertexesOnBorderX0 nextPut: lastVertex vertex1 y + (interpolationBlock value: lastVertex) -> lastVertex].
			(lastVertex onX: maxX)
				ifTrue: [vertexesOnBorderX1 nextPut: lastVertex vertex1 y + (interpolationBlock value: lastVertex) -> lastVertex].
			(lastVertex onY: 1)
				ifTrue: [vertexesOnBorderY0 nextPut: lastVertex vertex1 x + (interpolationBlock value: lastVertex) -> lastVertex].
			(lastVertex onY: maxY)
				ifTrue: [vertexesOnBorderY1 nextPut: lastVertex vertex1 x + (interpolationBlock value: lastVertex) -> lastVertex]].
	cornerValue := evaluationBlock value: xInterval first value: yInterval first.
	cornerValue <= maxNumber
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: 1 @ 1
						vertex: 1 @ 1
						label: 0.
			vertexesOnBorderX0 nextPut: 1 -> vertex.
			vertexesOnBorderY0 nextPut: 1 -> vertex].
	cornerValue := evaluationBlock value: xInterval last value: yInterval first.
	cornerValue <= maxNumber
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: maxX @ 1
						vertex: maxX @ 1
						label: 0.
			vertexesOnBorderX1 nextPut: 1 -> vertex.
			vertexesOnBorderY0 nextPut: maxX -> vertex].
	cornerValue := evaluationBlock value: xInterval last value: yInterval last.
	cornerValue <= maxNumber
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: maxX @ maxY
						vertex: maxX @ maxY
						label: 0.
			vertexesOnBorderX1 nextPut: maxY -> vertex.
			vertexesOnBorderY1 nextPut: maxX -> vertex].
	cornerValue := evaluationBlock value: xInterval first value: yInterval last.
	cornerValue <= maxNumber
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: 1 @ maxY
						vertex: 1 @ maxY
						label: 0.
			vertexesOnBorderX0 nextPut: maxY -> vertex.
			vertexesOnBorderY1 nextPut: 1 -> vertex].
	vertexesOnBorder := Array new writeStream.
	vertexesOnBorder nextPutAll: (vertexesOnBorderY0 contents
			asSortedCollection: 
				[:less :more | 
				| lessX moreX |
				lessX := less value vertex1 x.
				moreX := more value vertex1 x.
				lessX < moreX or: [lessX = moreX and: [less key <= more key]]]).
	vertexesOnBorder nextPutAll: (vertexesOnBorderX1 contents
			asSortedCollection: 
				[:less :more | 
				| lessY moreY |
				lessY := less value vertex1 y.
				moreY := more value vertex1 y.
				lessY < moreY or: [lessY = moreY and: [less key <= more key]]]).
	vertexesOnBorder nextPutAll: (vertexesOnBorderY1 contents
			asSortedCollection: 
				[:more :less | 
				| lessX moreX |
				lessX := less value vertex1 x.
				moreX := more value vertex1 x.
				lessX < moreX or: [lessX = moreX and: [less key <= more key]]]).
	vertexesOnBorder nextPutAll: (vertexesOnBorderX0 contents
			asSortedCollection: 
				[:more :less | 
				| lessY moreY |
				lessY := less value vertex1 y.
				moreY := more value vertex1 y.
				lessY < moreY or: [lessY = moreY and: [less key <= more key]]]).
	vertexesOnBorder := vertexesOnBorder contents.
	(1 to: vertexesOnBorder size by: 2)
		do: 
			[:index | 
			| vertex1 vertex2 |
			vertex1 := (vertexesOnBorder at: index) value.
			vertex2 := (vertexesOnBorder at: index + 1) value.
			edgeInsertionBlock value: vertex1 value: vertex2].
	^polygonalBoundary
]

{ #category : #'2D functions' }
JunBorderGenerator class >> polygonalBoundaryWith: evaluationBlock min: minNumber max: maxNumber xInterval: xInterval yInterval: yInterval interim: interimBlock [ 
	| danglingPolyedges maxX maxY edgeInsertionBlock completedBlock polygonalBoundary interpolationBlock vertexesOnBorderX0 vertexesOnBorderX1 vertexesOnBorderY0 vertexesOnBorderY1 vertexesOnBorder cornerValue |
	danglingPolyedges := JunDoubleLinkedList new.
	maxX := xInterval size.
	maxY := yInterval size.
	polygonalBoundary := Jun2dPolygonalBoundary new.
	interpolationBlock := 
			[:vertex | 
			| x1 y1 x2 y2 value1 value2 t |
			x1 := xInterval at: vertex vertex1 x.
			y1 := yInterval at: vertex vertex1 y.
			x2 := xInterval at: vertex vertex2 x.
			y2 := yInterval at: vertex vertex2 y.
			value1 := (evaluationBlock value: x1 value: y1) asRational.
			value2 := (evaluationBlock value: x2 value: y2) asRational.
			t := value1 = value2
						ifTrue: [0]
						ifFalse: [vertex label asRational - value1 / (value2 - value1)].
			t := (t max: 0)
						min: 1.
			t asDouble].
	completedBlock := 
			[:polyedge | 
			| points polygon |
			points := polyedge
						collect: 
							[:vertex | 
							| t v1 v2 p1 p2 |
							t := interpolationBlock value: vertex.
							v1 := vertex vertex1.
							v2 := vertex vertex2.
							p1 := (xInterval at: v1 x)
										, (yInterval at: v1 y).
							p2 := (xInterval at: v2 x)
										, (yInterval at: v2 y).
							t * (p2 - p1) + p1].
			polygon := Jun2dPolygon points: points.
			polygonalBoundary add: polygon.
			interimBlock notNil ifTrue: [interimBlock value: polygonalBoundary]].
	edgeInsertionBlock := 
			[:from :to | 
			| leadingPolyedge trailingPolyedge |
			leadingPolyedge := danglingPolyedges detect: [:polyedge | from = polyedge last]
						ifNone: [nil].
			trailingPolyedge := danglingPolyedges detect: [:polyedge | to = polyedge first]
						ifNone: [nil].
			leadingPolyedge isNil
				ifTrue: [trailingPolyedge isNil
						ifTrue: 
							[| newPolyedge |
							newPolyedge := OrderedCollection with: from with: to.
							danglingPolyedges add: newPolyedge]
						ifFalse: [trailingPolyedge addFirst: from]]
				ifFalse: [trailingPolyedge isNil
						ifTrue: [leadingPolyedge addLast: to]
						ifFalse: [leadingPolyedge == trailingPolyedge
								ifTrue: 
									[danglingPolyedges remove: leadingPolyedge ifAbsent: [].
									completedBlock value: leadingPolyedge]
								ifFalse: 
									[leadingPolyedge addAllLast: trailingPolyedge.
									danglingPolyedges remove: trailingPolyedge ifAbsent: []]]]].
	1 to: maxX - 1 do: [:xIndex | 1 to: maxY - 1
			do: 
				[:yIndex | 
				self
					_edgesWith: [:x :y | evaluationBlock value: (xInterval at: x)
							value: (yInterval at: y)]
					at: minNumber
					sign: 1
					inUnitSquareAt: xIndex @ yIndex
					do: edgeInsertionBlock.
				self
					_edgesWith: [:x :y | evaluationBlock value: (xInterval at: x)
							value: (yInterval at: y)]
					at: maxNumber
					sign: -1
					inUnitSquareAt: xIndex @ yIndex
					do: edgeInsertionBlock]].
	vertexesOnBorderX0 := Array new writeStream.
	vertexesOnBorderX1 := Array new writeStream.
	vertexesOnBorderY0 := Array new writeStream.
	vertexesOnBorderY1 := Array new writeStream.
	danglingPolyedges
		do: 
			[:polyedge | 
			| firstVertex lastVertex |
			firstVertex := polyedge first.
			lastVertex := polyedge last.
			(firstVertex onX: 1)
				ifTrue: [vertexesOnBorderX0 nextPut: firstVertex vertex1 y + (interpolationBlock value: firstVertex) -> firstVertex].
			(firstVertex onX: maxX)
				ifTrue: [vertexesOnBorderX1 nextPut: firstVertex vertex1 y + (interpolationBlock value: firstVertex) -> firstVertex].
			(firstVertex onY: 1)
				ifTrue: [vertexesOnBorderY0 nextPut: firstVertex vertex1 x + (interpolationBlock value: firstVertex) -> firstVertex].
			(firstVertex onY: maxY)
				ifTrue: [vertexesOnBorderY1 nextPut: firstVertex vertex1 x + (interpolationBlock value: firstVertex) -> firstVertex].
			(lastVertex onX: 1)
				ifTrue: [vertexesOnBorderX0 nextPut: lastVertex vertex1 y + (interpolationBlock value: lastVertex) -> lastVertex].
			(lastVertex onX: maxX)
				ifTrue: [vertexesOnBorderX1 nextPut: lastVertex vertex1 y + (interpolationBlock value: lastVertex) -> lastVertex].
			(lastVertex onY: 1)
				ifTrue: [vertexesOnBorderY0 nextPut: lastVertex vertex1 x + (interpolationBlock value: lastVertex) -> lastVertex].
			(lastVertex onY: maxY)
				ifTrue: [vertexesOnBorderY1 nextPut: lastVertex vertex1 x + (interpolationBlock value: lastVertex) -> lastVertex]].
	cornerValue := evaluationBlock value: xInterval first value: yInterval first.
	(cornerValue >= minNumber and: [cornerValue <= maxNumber])
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: 1 @ 1
						vertex: 1 @ 1
						label: 0.
			vertexesOnBorderX0 nextPut: 1 -> vertex.
			vertexesOnBorderY0 nextPut: 1 -> vertex].
	cornerValue := evaluationBlock value: xInterval last value: yInterval first.
	(cornerValue >= minNumber and: [cornerValue <= maxNumber])
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: maxX @ 1
						vertex: maxX @ 1
						label: 0.
			vertexesOnBorderX1 nextPut: 1 -> vertex.
			vertexesOnBorderY0 nextPut: maxX -> vertex].
	cornerValue := evaluationBlock value: xInterval last value: yInterval last.
	(cornerValue >= minNumber and: [cornerValue <= maxNumber])
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: maxX @ maxY
						vertex: maxX @ maxY
						label: 0.
			vertexesOnBorderX1 nextPut: maxY -> vertex.
			vertexesOnBorderY1 nextPut: maxX -> vertex].
	cornerValue := evaluationBlock value: xInterval first value: yInterval last.
	(cornerValue >= minNumber and: [cornerValue <= maxNumber])
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: 1 @ maxY
						vertex: 1 @ maxY
						label: 0.
			vertexesOnBorderX0 nextPut: maxY -> vertex.
			vertexesOnBorderY1 nextPut: 1 -> vertex].
	vertexesOnBorder := Array new writeStream.
	vertexesOnBorder nextPutAll: (vertexesOnBorderY0 contents
			asSortedCollection: 
				[:less :more | 
				| lessX moreX |
				lessX := less value vertex1 x.
				moreX := more value vertex1 x.
				lessX < moreX or: [lessX = moreX and: [less key <= more key]]]).
	vertexesOnBorder nextPutAll: (vertexesOnBorderX1 contents
			asSortedCollection: 
				[:less :more | 
				| lessY moreY |
				lessY := less value vertex1 y.
				moreY := more value vertex1 y.
				lessY < moreY or: [lessY = moreY and: [less key <= more key]]]).
	vertexesOnBorder nextPutAll: (vertexesOnBorderY1 contents
			asSortedCollection: 
				[:more :less | 
				| lessX moreX |
				lessX := less value vertex1 x.
				moreX := more value vertex1 x.
				lessX < moreX or: [lessX = moreX and: [less key <= more key]]]).
	vertexesOnBorder nextPutAll: (vertexesOnBorderX0 contents
			asSortedCollection: 
				[:more :less | 
				| lessY moreY |
				lessY := less value vertex1 y.
				moreY := more value vertex1 y.
				lessY < moreY or: [lessY = moreY and: [less key <= more key]]]).
	vertexesOnBorder := vertexesOnBorder contents.
	(1 to: vertexesOnBorder size by: 2)
		do: 
			[:index | 
			| vertex1 vertex2 |
			vertex1 := (vertexesOnBorder at: index) value.
			vertex2 := (vertexesOnBorder at: index + 1) value.
			edgeInsertionBlock value: vertex1 value: vertex2].
	^polygonalBoundary
]

{ #category : #'2D functions' }
JunBorderGenerator class >> polygonalBoundaryWith: evaluationBlock min: minNumber xInterval: xInterval yInterval: yInterval interim: interimBlock [ 
	| danglingPolyedges maxX maxY edgeInsertionBlock completedBlock polygonalBoundary interpolationBlock vertexesOnBorderX0 vertexesOnBorderX1 vertexesOnBorderY0 vertexesOnBorderY1 vertexesOnBorder cornerValue |
	danglingPolyedges := JunDoubleLinkedList new.
	maxX := xInterval size.
	maxY := yInterval size.
	polygonalBoundary := Jun2dPolygonalBoundary new.
	interpolationBlock := 
			[:vertex | 
			| x1 y1 x2 y2 value1 value2 t |
			x1 := xInterval at: vertex vertex1 x.
			y1 := yInterval at: vertex vertex1 y.
			x2 := xInterval at: vertex vertex2 x.
			y2 := yInterval at: vertex vertex2 y.
			value1 := (evaluationBlock value: x1 value: y1) asRational.
			value2 := (evaluationBlock value: x2 value: y2) asRational.
			t := value1 = value2
						ifTrue: [0]
						ifFalse: [vertex label asRational - value1 / (value2 - value1)].
			t := (t max: 0)
						min: 1.
			t asDouble].
	completedBlock := 
			[:polyedge | 
			| points polygon |
			points := polyedge
						collect: 
							[:vertex | 
							| t v1 v2 p1 p2 |
							t := interpolationBlock value: vertex.
							v1 := vertex vertex1.
							v2 := vertex vertex2.
							p1 := (xInterval at: v1 x)
										, (yInterval at: v1 y).
							p2 := (xInterval at: v2 x)
										, (yInterval at: v2 y).
							t * (p2 - p1) + p1].
			polygon := Jun2dPolygon points: points.
			polygonalBoundary add: polygon.
			interimBlock notNil ifTrue: [interimBlock value: polygonalBoundary]].
	edgeInsertionBlock := 
			[:from :to | 
			| leadingPolyedge trailingPolyedge |
			leadingPolyedge := danglingPolyedges detect: [:polyedge | from = polyedge last]
						ifNone: [nil].
			trailingPolyedge := danglingPolyedges detect: [:polyedge | to = polyedge first]
						ifNone: [nil].
			leadingPolyedge isNil
				ifTrue: [trailingPolyedge isNil
						ifTrue: 
							[| newPolyedge |
							newPolyedge := OrderedCollection with: from with: to.
							danglingPolyedges add: newPolyedge]
						ifFalse: [trailingPolyedge addFirst: from]]
				ifFalse: [trailingPolyedge isNil
						ifTrue: [leadingPolyedge addLast: to]
						ifFalse: [leadingPolyedge == trailingPolyedge
								ifTrue: 
									[danglingPolyedges remove: leadingPolyedge ifAbsent: [].
									completedBlock value: leadingPolyedge]
								ifFalse: 
									[leadingPolyedge addAllLast: trailingPolyedge.
									danglingPolyedges remove: trailingPolyedge ifAbsent: []]]]].
	1 to: maxX - 1 do: [:xIndex | 1 to: maxY - 1 do: [:yIndex | self
				_edgesWith: [:x :y | evaluationBlock value: (xInterval at: x)
						value: (yInterval at: y)]
				at: minNumber
				sign: 1
				inUnitSquareAt: xIndex @ yIndex
				do: edgeInsertionBlock]].
	vertexesOnBorderX0 := Array new writeStream.
	vertexesOnBorderX1 := Array new writeStream.
	vertexesOnBorderY0 := Array new writeStream.
	vertexesOnBorderY1 := Array new writeStream.
	danglingPolyedges
		do: 
			[:polyedge | 
			| firstVertex lastVertex |
			firstVertex := polyedge first.
			lastVertex := polyedge last.
			(firstVertex onX: 1)
				ifTrue: [vertexesOnBorderX0 nextPut: firstVertex vertex1 y + (interpolationBlock value: firstVertex) -> firstVertex].
			(firstVertex onX: maxX)
				ifTrue: [vertexesOnBorderX1 nextPut: firstVertex vertex1 y + (interpolationBlock value: firstVertex) -> firstVertex].
			(firstVertex onY: 1)
				ifTrue: [vertexesOnBorderY0 nextPut: firstVertex vertex1 x + (interpolationBlock value: firstVertex) -> firstVertex].
			(firstVertex onY: maxY)
				ifTrue: [vertexesOnBorderY1 nextPut: firstVertex vertex1 x + (interpolationBlock value: firstVertex) -> firstVertex].
			(lastVertex onX: 1)
				ifTrue: [vertexesOnBorderX0 nextPut: lastVertex vertex1 y + (interpolationBlock value: lastVertex) -> lastVertex].
			(lastVertex onX: maxX)
				ifTrue: [vertexesOnBorderX1 nextPut: lastVertex vertex1 y + (interpolationBlock value: lastVertex) -> lastVertex].
			(lastVertex onY: 1)
				ifTrue: [vertexesOnBorderY0 nextPut: lastVertex vertex1 x + (interpolationBlock value: lastVertex) -> lastVertex].
			(lastVertex onY: maxY)
				ifTrue: [vertexesOnBorderY1 nextPut: lastVertex vertex1 x + (interpolationBlock value: lastVertex) -> lastVertex]].
	cornerValue := evaluationBlock value: xInterval first value: yInterval first.
	cornerValue >= minNumber
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: 1 @ 1
						vertex: 1 @ 1
						label: 0.
			vertexesOnBorderX0 nextPut: 1 -> vertex.
			vertexesOnBorderY0 nextPut: 1 -> vertex].
	cornerValue := evaluationBlock value: xInterval last value: yInterval first.
	cornerValue >= minNumber
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: maxX @ 1
						vertex: maxX @ 1
						label: 0.
			vertexesOnBorderX1 nextPut: 1 -> vertex.
			vertexesOnBorderY0 nextPut: maxX -> vertex].
	cornerValue := evaluationBlock value: xInterval last value: yInterval last.
	cornerValue >= minNumber
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: maxX @ maxY
						vertex: maxX @ maxY
						label: 0.
			vertexesOnBorderX1 nextPut: maxY -> vertex.
			vertexesOnBorderY1 nextPut: maxX -> vertex].
	cornerValue := evaluationBlock value: xInterval first value: yInterval last.
	cornerValue >= minNumber
		ifTrue: 
			[| vertex |
			vertex := JunBorderVertex
						vertex: 1 @ maxY
						vertex: 1 @ maxY
						label: 0.
			vertexesOnBorderX0 nextPut: maxY -> vertex.
			vertexesOnBorderY1 nextPut: 1 -> vertex].
	vertexesOnBorder := Array new writeStream.
	vertexesOnBorder nextPutAll: (vertexesOnBorderY0 contents
			asSortedCollection: 
				[:less :more | 
				| lessX moreX |
				lessX := less value vertex1 x.
				moreX := more value vertex1 x.
				lessX < moreX or: [lessX = moreX and: [less key <= more key]]]).
	vertexesOnBorder nextPutAll: (vertexesOnBorderX1 contents
			asSortedCollection: 
				[:less :more | 
				| lessY moreY |
				lessY := less value vertex1 y.
				moreY := more value vertex1 y.
				lessY < moreY or: [lessY = moreY and: [less key <= more key]]]).
	vertexesOnBorder nextPutAll: (vertexesOnBorderY1 contents
			asSortedCollection: 
				[:more :less | 
				| lessX moreX |
				lessX := less value vertex1 x.
				moreX := more value vertex1 x.
				lessX < moreX or: [lessX = moreX and: [less key <= more key]]]).
	vertexesOnBorder nextPutAll: (vertexesOnBorderX0 contents
			asSortedCollection: 
				[:more :less | 
				| lessY moreY |
				lessY := less value vertex1 y.
				moreY := more value vertex1 y.
				lessY < moreY or: [lessY = moreY and: [less key <= more key]]]).
	vertexesOnBorder := vertexesOnBorder contents.
	(1 to: vertexesOnBorder size by: 2)
		do: 
			[:index | 
			| vertex1 vertex2 |
			vertex1 := (vertexesOnBorder at: index) value.
			vertex2 := (vertexesOnBorder at: index + 1) value.
			edgeInsertionBlock value: vertex1 value: vertex2].
	^polygonalBoundary
]

{ #category : #'3D examples' }
JunBorderGenerator class >> rugbyballExample [
	"JunBorderGenerator rugbyballExample."

	| center1 center2 viewer block contour |
	center1 := -0.5 , 0 , 0.
	center2 := 0.5 , 0 , 0.
	viewer := JunOpenGLDisplayModel new.
	viewer open.
	block := 
			[:polygons | 
			viewer do: 
					[| compound |
					compound := JunOpenGL3dCompoundObject new.
					polygons do: 
							[:polygon | 
							| body |
							body := polygon asJunOpenGL3dObjectColor: ColorValue green.
							compound add: body].
					viewer displayObject: compound.
					viewer resetView]
				forMilliseconds: 1000].
	JunCursors cameraCursor showWhile: 
			[| lastNumber |
			lastNumber := 0.
			contour := JunBorderGenerator 
						contourPolygonsFrom: 
							[:x :y :z | 
							| p |
							p := x , y , z.
							(p distance: center1) + (p distance: center2)]
						at: 1.3
						sign: -1
						xInterval: (-1 to: 2 by: 0.2)
						yInterval: (-1 to: 1 by: 0.1)
						zInterval: (-1 to: 1 by: 0.1)
						interim: 
							[:polygons | 
							polygons size = lastNumber 
								ifFalse: 
									[block value: polygons.
									lastNumber := polygons size]]].
	^contour
]

{ #category : #'solid model examples' }
JunBorderGenerator class >> sphereBodyExample [
	"JunBorderGenerator sphereBodyExample"

	| center displayModel body |
	center := 0 , 0 , 0.
	displayModel := JunOpenGLDisplayModel new.
	displayModel open.
	displayModel displayObject: (JunOpenGL3dCompoundObject new paint: ColorValue blue).
	JunCursors cameraCursor
		showWhile: 
			[| lastNumLoops |
			lastNumLoops := 0.
			body := JunBorderGenerator
						contourBodyFrom: [:x :y :z | x , y , z distance: center]
						at: 1
						sign: -1
						xInterval: (-1.5 to: 1.5 by: 0.2)
						yInterval: (-1.5 to: 1.5 by: 0.2)
						zInterval: (-1.5 to: 1.5 by: 0.2)
						interim: [:interimBody | interimBody numberOfLoops ~= lastNumLoops
								ifTrue: 
									[displayModel displayObject: interimBody asJunOpenGL3dObject.
									displayModel fitZoom.
									lastNumLoops := interimBody numberOfLoops]]].
	^body
]

{ #category : #'3D examples' }
JunBorderGenerator class >> sphereExample [
	"JunBorderGenerator sphereExample."

	| center viewer block contour |
	center := 0 , 0 , 0.
	viewer := JunOpenGLDisplayModel new.
	viewer open.
	block := 
			[:polygons | 
			viewer do: 
					[| compound |
					compound := JunOpenGL3dCompoundObject new.
					polygons collect: 
							[:polygon | 
							| body |
							body := polygon asJunOpenGL3dObjectColor: ColorValue cyan.
							compound add: body].
					viewer displayObject: compound.
					viewer resetView]
				forMilliseconds: 500].
	JunCursors cameraCursor showWhile: 
			[| last |
			last := 0.
			contour := JunBorderGenerator 
						contourPolygonsFrom: [:x :y :z | x , y , z distance: center]
						at: 1
						sign: -1
						xInterval: (-1.2 to: 1.2 by: 0.2)
						yInterval: (-1.2 to: 1.2 by: 0.2)
						zInterval: (-1.2 to: 1.2 by: 0.2)
						interim: 
							[:polygons | 
							polygons size ~= last 
								ifTrue: 
									[block value: polygons.
									last := polygons size]]].
	^contour
]

{ #category : #copyright }
JunBorderGenerator class >> system [
	^'Jun'
]

{ #category : #'3D examples' }
JunBorderGenerator class >> text3dExample [
	"JunBorderGenerator text3dExample."

	| string weight viewer block contours |
	string := JunDialog 
				request: (#jun_Type_in_your_favorite_phrase_ 
						>> 'Type in your favorite phrase.') asString
				initialAnswer: (#jun_Be_free_ >> 'Be free!') asString.
	(string isNil or: [string isEmpty]) ifTrue: [^nil].
	weight := Compiler evaluate: (JunDialog 
						request: (#jun_Enter_weight_of_the_font_ >> 'Enter weight of the font.') 
								asString , '(0.1 .. 0.9)'
						initialAnswer: '0.5'
						onCancel: [String new])
				logged: false.
	(weight isKindOf: Number) ifFalse: [^nil].
	weight := (weight max: 0.1) min: 0.9.
	viewer := JunOpenGLDisplayModel new.
	viewer defaultProjectionTable: ((Dictionary new)
				add: #eyePoint -> (string asComposedText bounds center , 100);
				add: #sightPoint -> (string asComposedText bounds center , 0);
				add: #upVector -> (0 , 1 , 0);
				yourself).
	viewer open.
	block := 
			[:polygons :x | 
			viewer do: 
					[| compound |
					compound := JunOpenGL3dCompoundObject new.
					polygons do: 
							[:polygon | 
							| body |
							body := (polygon asJunOpenGL3dObjectColor: ColorValue magenta) 
										translatedBy: x , 0 , 0.
							compound add: body].
					viewer displayObject 
						ifNotNil: [:it | compound := compound class with: it with: compound].
					viewer displayObject: compound.
					viewer resetView]
				forMilliseconds: 500].
	contours := OrderedCollection new.
	JunCursors cameraCursor showWhile: 
			[| offset |
			offset := 0.
			string do: 
					[:character | 
					| last text pixmap image contour |
					last := 0.
					text := (String with: character) asComposedText.
					viewer 
						assert: [pixmap := Pixmap extent: text extent]
						do: 
							[| gc |
							pixmap background: ColorValue black.
							gc := pixmap graphicsContext.
							gc paint: ColorValue white.
							gc clear.
							text displayOn: gc.
							image := pixmap asImage]
						ensure: [pixmap close].
					contour := JunBorderGenerator 
								contourPolygonsFrom: 
									[:x :y :z | 
									| p v |
									p := x @ (image height - y).
									v := 1 - (image valueAtPoint: p) brightness.
									(v squared + z squared) sqrt]
								at: weight
								sign: -1
								xInterval: (0 to: image width - 1)
								yInterval: (1 to: image height)
								zInterval: (-1 to: 1)
								interim: 
									[:polygons | 
									polygons size = last 
										ifFalse: 
											[block value: polygons value: offset.
											last := polygons size]].
					offset := offset + image width.
					contours add: contour]].
	^contours
]

{ #category : #'2D examples' }
JunBorderGenerator class >> textExample [
	"JunBorderGenerator textExample."

	| string weight extent viewer boundaries |
	string := JunDialog 
				request: (#jun_Type_in_your_favorite_phrase_ 
						>> 'Type in your favorite phrase.') asString
				initialAnswer: (#jun_Be_free_ >> 'Be free!') asString.
	(string isNil or: [string isEmpty]) ifTrue: [^nil].
	weight := Compiler evaluate: (JunDialog 
						request: (#jun_Enter_weight_of_the_font_ >> 'Enter weight of the font.') 
								asString , '(0.1 .. 0.9)'
						initialAnswer: '0.5'
						onCancel: [String new])
				logged: false.
	(weight isKindOf: Number) ifFalse: [^nil].
	weight := (weight max: 0.1) min: 0.9.
	extent := Jun2dPoint coerce: string asComposedText extent.
	viewer := JunOpenGLDisplayModel new.
	viewer open.
	viewer defaultProjectionTable: ((Dictionary new)
				add: #eyePoint -> (extent / 2 , extent x);
				add: #sightPoint -> (extent / 2 , 0.0d);
				add: #upVector -> (0 , 1 , 0);
				yourself).
	boundaries := OrderedCollection new.
	JunCursors cameraCursor showWhile: 
			[| offset |
			offset := 0.
			string do: 
					[:character | 
					| text image boundary compound |
					text := (String with: character) asComposedText.
					viewer 
						assert: [Pixmap extent: text extent]
						do: 
							[:pixmap | 
							| gc |
							pixmap background: ColorValue black.
							gc := pixmap graphicsContext.
							gc paint: ColorValue white.
							gc clear.
							text displayOn: gc.
							image := pixmap asImage]
						ensure: [:pixmap | pixmap close].
					boundary := JunBorderGenerator 
								polygonalBoundaryWith: [:x :y | (image valueAtPoint: x @ y) brightness]
								min: 1 - weight
								max: 1
								xInterval: (0 to: image width - 1)
								yInterval: (0 to: image height - 1)
								interim: [:b | ].
					boundary := boundary scaledBy: 1 , -1.
					boundary := boundary translatedBy: offset , image height.
					offset := offset + image width.
					compound := boundary asJunOpenGL3dObjectColor: ColorValue blue.
					viewer displayObject 
						ifNotNil: [:it | compound := compound class with: it with: compound].
					viewer displayObject: compound.
					viewer resetView.
					boundaries add: boundary]].
	^boundaries
]

{ #category : #'2D examples' }
JunBorderGenerator class >> textExample2 [
	"JunBorderGenerator textExample2."

	| string weight extent viewer text image |
	string := self definition.
	weight := Compiler evaluate: (JunDialog 
						request: (#jun_Enter_weight_of_the_font_ >> 'Enter weight of the font.') 
								asString , '(0.1 .. 0.9)'
						initialAnswer: '0.5'
						onCancel: [String new])
				logged: false.
	(weight isKindOf: Number) ifFalse: [^nil].
	weight := (weight max: 0.1) min: 0.9.
	extent := Jun2dPoint coerce: string asComposedText extent.
	viewer := JunOpenGLDisplayModel new.
	viewer 
		openIn: ((JunSystem screenCenter extent: 0 @ 0) expandedBy: 300 @ 150).
	viewer defaultProjectionTable: ((Dictionary new)
				add: #eyePoint -> ((0 , 0 , extent x) * 10);
				add: #sightPoint -> (0 , 0 , 0);
				add: #upVector -> (0 , 1 , 0);
				yourself).
	text := string asComposedText.
	viewer 
		assert: [Pixmap extent: text extent]
		do: 
			[:pixmap | 
			| gc |
			pixmap background: ColorValue black.
			gc := pixmap graphicsContext.
			gc paint: ColorValue white.
			gc clear.
			text displayOn: gc.
			image := pixmap asImage]
		ensure: [:pixmap | pixmap close].
	JunCursors cameraCursor showWhile: 
			[| counter polygonalBoundary |
			counter := 0.
			polygonalBoundary := JunBorderGenerator 
						polygonalBoundaryWith: [:x :y | (image valueAtPoint: x @ y) brightness]
						min: 1 - weight
						max: 1
						xInterval: (0 to: image width - 1)
						yInterval: (0 to: image height - 1)
						interim: 
							[:pBoundary | 
							counter := (counter + 1) \\ 10.
							counter = 0 
								ifTrue: 
									[| boundary |
									boundary := pBoundary scaledBy: 1 , -1.
									boundary := boundary 
												translatedBy: image width negated / 2 , (image height / 2).
									viewer displayObject: (boundary asJunOpenGL3dObjectColor: ColorValue red).
									viewer resetView]].
			polygonalBoundary := polygonalBoundary scaledBy: 1 , -1.
			polygonalBoundary := polygonalBoundary 
						translatedBy: image width negated / 2 , (image height / 2).
			viewer 
				displayObject: (polygonalBoundary asJunOpenGL3dObjectColor: ColorValue blue).
			viewer resetView].
	^viewer displayObject
]

{ #category : #copyright }
JunBorderGenerator class >> version [
	^'799'
]

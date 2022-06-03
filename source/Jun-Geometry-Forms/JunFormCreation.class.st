"
Imported by VwImportClass
"
Class {
	#name : #JunFormCreation,
	#superclass : #JunFormOperation,
	#instVars : [
		'formTriangulation',
		'draftTriangleNodes',
		'triangleNodes',
		'chordalAxesTable',
		'chordalAxesInformation',
		'fanTriangles',
		'spinePolylineInformation',
		'finalTriangles',
		'finalSpines',
		'finalBody'
	],
	#category : #'Jun-Geometry-Forms'
}

{ #category : #copyright }
JunFormCreation class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunFormCreation class >> example1 [
	"JunFormCreation example1."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formCreation aPixmap graphicsContext |
			formCreation := JunFormCreation points: aPolyline.
			JunControlUtility 
				assert: [aPixmap := Pixmap extent: formCreation boundingBox extent rounded]
				do: 
					[graphicsContext := aPixmap graphicsContext.
					graphicsContext paint: ColorValue white.
					graphicsContext displayRectangle: aPixmap bounds.
					Cursor wait showWhile: [formCreation points].
					formCreation displayPolylineOn: graphicsContext.
					JunImageDisplayModel show: aPixmap asImage at: aPoint]
				ensure: 
					[aPixmap close.
					JunApplicationModel displayPendingInvalidation].
			aPoint := aPoint translatedBy: 20 @ 20.
			formCreation].
	^JunFormCreation examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormCreation class >> example2 [
	"JunFormCreation example2."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formCreation aPixmap graphicsContext |
			formCreation := JunFormCreation points: aPolyline.
			JunControlUtility 
				assert: [aPixmap := Pixmap extent: formCreation boundingBox extent rounded]
				do: 
					[graphicsContext := aPixmap graphicsContext.
					graphicsContext paint: ColorValue white.
					graphicsContext displayRectangle: aPixmap bounds.
					JunApplicationModel displayPendingInvalidation.
					Cursor wait showWhile: [formCreation triangulatedTriangles].
					formCreation displayTriangulatedTrianglesOn: graphicsContext.
					JunImageDisplayModel show: aPixmap asImage at: aPoint]
				ensure: 
					[aPixmap close.
					JunApplicationModel displayPendingInvalidation].
			aPoint := aPoint translatedBy: 20 @ 20.
			formCreation].
	^JunFormCreation examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormCreation class >> example3 [
	"JunFormCreation example3."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formCreation aPixmap graphicsContext |
			formCreation := JunFormCreation points: aPolyline.
			JunControlUtility 
				assert: [aPixmap := Pixmap extent: formCreation boundingBox extent rounded]
				do: 
					[graphicsContext := aPixmap graphicsContext.
					graphicsContext paint: ColorValue white.
					graphicsContext displayRectangle: aPixmap bounds.
					JunApplicationModel displayPendingInvalidation.
					Cursor wait showWhile: [formCreation draftTriangleNodes].
					formCreation displayDraftTriangleNodesOn: graphicsContext.
					JunImageDisplayModel show: aPixmap asImage at: aPoint]
				ensure: 
					[aPixmap close.
					JunApplicationModel displayPendingInvalidation].
			aPoint := aPoint translatedBy: 20 @ 20.
			formCreation].
	^JunFormCreation examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormCreation class >> example4 [
	"JunFormCreation example4."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formCreation aPixmap graphicsContext |
			formCreation := JunFormCreation points: aPolyline.
			JunControlUtility 
				assert: [aPixmap := Pixmap extent: formCreation boundingBox extent rounded]
				do: 
					[graphicsContext := aPixmap graphicsContext.
					graphicsContext paint: ColorValue white.
					graphicsContext displayRectangle: aPixmap bounds.
					JunApplicationModel displayPendingInvalidation.
					Cursor wait showWhile: [formCreation triangleNodes].
					formCreation displayTriangleNodesOn: graphicsContext.
					JunImageDisplayModel show: aPixmap asImage at: aPoint]
				ensure: 
					[aPixmap close.
					JunApplicationModel displayPendingInvalidation].
			aPoint := aPoint translatedBy: 20 @ 20.
			formCreation].
	^JunFormCreation examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormCreation class >> example5 [
	"JunFormCreation example5."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formCreation aPixmap graphicsContext |
			formCreation := JunFormCreation points: aPolyline.
			JunControlUtility 
				assert: [aPixmap := Pixmap extent: formCreation boundingBox extent rounded]
				do: 
					[graphicsContext := aPixmap graphicsContext.
					graphicsContext paint: ColorValue white.
					graphicsContext displayRectangle: aPixmap bounds.
					JunApplicationModel displayPendingInvalidation.
					Cursor wait showWhile: [formCreation chordalAxes].
					formCreation displayChordalAxesOn: graphicsContext.
					JunImageDisplayModel show: aPixmap asImage at: aPoint]
				ensure: 
					[aPixmap close.
					JunApplicationModel displayPendingInvalidation].
			aPoint := aPoint translatedBy: 20 @ 20.
			formCreation].
	^JunFormCreation examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormCreation class >> example6 [
	"JunFormCreation example6."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formCreation aPixmap graphicsContext |
			formCreation := JunFormCreation points: aPolyline.
			JunControlUtility 
				assert: [aPixmap := Pixmap extent: formCreation boundingBox extent rounded]
				do: 
					[graphicsContext := aPixmap graphicsContext.
					graphicsContext paint: ColorValue white.
					graphicsContext displayRectangle: aPixmap bounds.
					JunApplicationModel displayPendingInvalidation.
					Cursor wait showWhile: [formCreation spinePolylines].
					formCreation displaySpinePolylinesOn: graphicsContext.
					JunImageDisplayModel show: aPixmap asImage at: aPoint]
				ensure: 
					[aPixmap close.
					JunApplicationModel displayPendingInvalidation].
			aPoint := aPoint translatedBy: 20 @ 20.
			formCreation].
	^JunFormCreation examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormCreation class >> example7 [
	"JunFormCreation example7."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formCreation aPixmap graphicsContext |
			formCreation := JunFormCreation points: aPolyline.
			JunControlUtility 
				assert: [aPixmap := Pixmap extent: formCreation boundingBox extent rounded]
				do: 
					[graphicsContext := aPixmap graphicsContext.
					graphicsContext paint: ColorValue white.
					graphicsContext displayRectangle: aPixmap bounds.
					JunApplicationModel displayPendingInvalidation.
					Cursor wait showWhile: 
							[formCreation
								spines;
								triangles].
					formCreation displayOn: graphicsContext.
					JunImageDisplayModel show: aPixmap asImage at: aPoint]
				ensure: 
					[aPixmap close.
					JunApplicationModel displayPendingInvalidation].
			aPoint := aPoint translatedBy: 20 @ 20.
			formCreation].
	^JunFormCreation examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormCreation class >> example8 [
	"JunFormCreation example8."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formCreation compoundObject displayModel |
			formCreation := JunFormCreation points: aPolyline.
			Cursor wait showWhile: 
					[| spineBody0 spineBody1 spineBody2 simpleBody0 simpleBody1 simpleBody2 |
					spineBody0 := formCreation spineBody0.
					spineBody0 primitivesDo: 
							[:each | 
							each paint: ColorValue red.
							(each isKindOf: JunOpenGL3dPolyline) 
								ifTrue: [each lineWidth: 3]
								ifFalse: [each size: 3]].
					spineBody1 := formCreation spineBody1.
					spineBody1 primitivesDo: 
							[:each | 
							each paint: ColorValue red.
							(each isKindOf: JunOpenGL3dPolyline) 
								ifTrue: [each lineWidth: 3]
								ifFalse: [each size: 3]].
					spineBody2 := formCreation spineBody2.
					spineBody2 primitivesDo: 
							[:each | 
							each paint: ColorValue red.
							(each isKindOf: JunOpenGL3dPolyline) 
								ifTrue: [each lineWidth: 3]
								ifFalse: [each size: 3]].
					simpleBody0 := formCreation simpleBody0.
					simpleBody0 objectsDo: 
							[:each | 
							each paint: ColorValue cyan.
							(each isKindOf: JunOpenGL3dPolygon) ifTrue: [each halftone: 0.75]].
					simpleBody1 := formCreation simpleBody1.
					simpleBody1 objectsDo: 
							[:each | 
							each paint: ColorValue magenta.
							(each isKindOf: JunOpenGL3dPolygon) ifTrue: [each halftone: 0.25]].
					simpleBody2 := formCreation simpleBody2.
					simpleBody2 objectsDo: 
							[:each | 
							each paint: ColorValue yellow.
							(each isKindOf: JunOpenGL3dPolygon) ifTrue: [each halftone: 0.25]].
					compoundObject := JunOpenGL3dCompoundObject new.
					compoundObject add: spineBody0.
					compoundObject add: spineBody1.
					compoundObject add: spineBody2.
					compoundObject add: simpleBody0.
					compoundObject add: simpleBody1.
					compoundObject add: simpleBody2].
			displayModel := JunOpenGLDisplayModel new.
			displayModel displayObject: compoundObject.
			displayModel defaultEyePoint: 0 , 2500 , -1000.
			displayModel defaultSightPoint: 0 , 0 , 0.
			displayModel defaultUpVector: 0 , -1 , 0.
			displayModel openIn: (aPoint extent: 300 @ 300).
			JunApplicationModel displayPendingInvalidation.
			aPoint := aPoint translatedBy: 20 @ 20.
			formCreation].
	^JunFormCreation examplePolylines 
		collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormCreation class >> example8a [
	"JunFormCreation example8a."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formCreation compoundObject displayModel |
			formCreation := JunFormCreation points: aPolyline.
			Cursor wait showWhile: [compoundObject := formCreation simpleBody].
			displayModel := JunOpenGLDisplayModel new.
			displayModel displayObject: compoundObject.
			displayModel defaultEyePoint: 0 , 2500 , -1000.
			displayModel defaultSightPoint: 0 , 0 , 0.
			displayModel defaultUpVector: 0 , -1 , 0.
			displayModel openIn: (aPoint extent: 300 @ 300).
			JunApplicationModel displayPendingInvalidation.
			aPoint := aPoint translatedBy: 20 @ 20.
			formCreation].
	^JunFormCreation examplePolylines collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormCreation class >> example9 [
	"JunFormCreation example9."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formCreation compoundObject displayModel |
			formCreation := JunFormCreation points: aPolyline.
			Cursor wait
				showWhile: 
					[compoundObject := formCreation body.
					compoundObject paint: ColorValue red].
			displayModel := JunOpenGLDisplayModel new.
			displayModel displayObject: compoundObject.
			displayModel defaultEyePoint: 0 , 2500 , -1000.
			displayModel defaultSightPoint: 0 , 0 , 0.
			displayModel defaultUpVector: 0 , -1 , 0.
			displayModel openIn: (aPoint extent: 300 @ 300).
			displayModel hiddenlinePresentation.
			JunApplicationModel displayPendingInvalidation.
			aPoint := aPoint translatedBy: 20 @ 20.
			formCreation].
	^JunFormCreation examplePolylines collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormCreation class >> example9a [
	"JunFormCreation example9a."

	| aPoint aBlock |
	aPoint := 100 @ 100.
	aBlock := 
			[:aPolyline | 
			| formCreation compoundObject displayModel |
			formCreation := JunFormCreation points: aPolyline.
			Cursor wait
				showWhile: 
					[compoundObject := formCreation body.
					compoundObject paint: ColorValue red].
			displayModel := JunOpenGLDisplayModel new.
			displayModel displayObject: compoundObject.
			displayModel defaultEyePoint: 0 , 2500 , -1000.
			displayModel defaultSightPoint: 0 , 0 , 0.
			displayModel defaultUpVector: 0 , -1 , 0.
			displayModel openIn: (aPoint extent: 300 @ 300).
			JunApplicationModel displayPendingInvalidation.
			aPoint := aPoint translatedBy: 20 @ 20.
			formCreation].
	^JunFormCreation examplePolylines collect: [:aPolyline | aBlock value: aPolyline]
]

{ #category : #examples }
JunFormCreation class >> examplePolylines [
	"JunFormCreation examplePolylines."

	^JunForm2dRegion examplePolylines
]

{ #category : #'instance creation' }
JunFormCreation class >> points: pointCollection [ 
	| triangleCreater |
	triangleCreater := self new.
	triangleCreater points: pointCollection.
	^triangleCreater
]

{ #category : #copyright }
JunFormCreation class >> system [
	^'Jun'
]

{ #category : #copyright }
JunFormCreation class >> version [
	^'799'
]

{ #category : #converting }
JunFormCreation >> asJunOpenGL3dObject [
	^self body
]

{ #category : #accessing }
JunFormCreation >> body [
	finalBody isNil ifTrue: [finalBody := self computeFinalBody].
	^finalBody
]

{ #category : #accessing }
JunFormCreation >> boundingBox [
	^formTriangulation boundingBox
]

{ #category : #accessing }
JunFormCreation >> bounds [
	^formTriangulation bounds
]

{ #category : #'chordal axes' }
JunFormCreation >> chordalAxes [
	| aStream |
	aStream := WriteStream on: Array new.
	self chordalAxesTerminalToTerminal do: [:chordalAxis | aStream nextPut: chordalAxis].
	self chordalAxesTerminalToJunction do: [:chordalAxis | aStream nextPut: chordalAxis].
	self chordalAxesJunctionToJunction do: [:chordalAxis | aStream nextPut: chordalAxis].
	^aStream contents
]

{ #category : #'chordal axes' }
JunFormCreation >> chordalAxesJunctionToJunction [
	chordalAxesInformation isNil ifTrue: [chordalAxesInformation := self computeChordalAxes].
	^chordalAxesInformation at: 3
]

{ #category : #'chordal axes' }
JunFormCreation >> chordalAxesTable [
	chordalAxesTable isNil ifTrue: [chordalAxesTable := self computeChordalAxesTable].
	^chordalAxesTable
]

{ #category : #'chordal axes' }
JunFormCreation >> chordalAxesTerminalToJunction [
	chordalAxesInformation isNil ifTrue: [chordalAxesInformation := self computeChordalAxes].
	^chordalAxesInformation at: 2
]

{ #category : #'chordal axes' }
JunFormCreation >> chordalAxesTerminalToTerminal [
	chordalAxesInformation isNil ifTrue: [chordalAxesInformation := self computeChordalAxes].
	^chordalAxesInformation at: 1
]

{ #category : #'chordal axes' }
JunFormCreation >> chordalAxis: chordalAxis do: aBlock [ 
	| specialPoint aPoint currentNode nextNode |
	chordalAxis size < 2 ifTrue: [^self].
	specialPoint := chordalAxis at: 1.
	aPoint := chordalAxis at: 2.
	currentNode := (self chordalAxesTable at: aPoint)
				detect: [:each | (each isTerminal and: [each tp = specialPoint])
						or: [each isJunction and: [each jp = specialPoint]]].
	aBlock
		value: nil
		value: specialPoint
		value: currentNode.
	2 to: chordalAxis size
		do: 
			[:index | 
			aPoint := chordalAxis at: index.
			nextNode := (self chordalAxesTable at: aPoint)
						detect: [:each | (each = currentNode) not].
			aBlock
				value: currentNode
				value: aPoint
				value: nextNode.
			nextNode isTerminal
				ifTrue: 
					[aBlock
						value: nextNode
						value: nextNode tp
						value: nil.
					^self].
			nextNode isJunction
				ifTrue: 
					[aBlock
						value: nextNode
						value: nextNode jp
						value: nil.
					^self].
			currentNode := nextNode]
]

{ #category : #'body creation' }
JunFormCreation >> complexBody [
	| body |
	body := JunOpenGL3dCompoundObject new.
	self complexBody1 do: [:each | body add: each].
	self complexBody2 do: [:each | body add: each].
	body paint: self defaultPaint.
	^body
]

{ #category : #'body creation' }
JunFormCreation >> complexBody0 [
	^self simpleBody0
]

{ #category : #'body creation' }
JunFormCreation >> complexBody1 [
	| table body trianglePoints spinePoints sp1 sp2 p1 p2 p3 points1 points2 object |
	table := self tableForSpinePointToLiftUpAmount.
	body := JunOpenGL3dCompoundObject new.
	self triangles do: 
			[:triangle | 
			trianglePoints := triangle points 
						collect: [:p | p x , p y , (table at: p ifAbsent: [0]) negated].
			spinePoints := triangle points select: [:p | table includesKey: p].
			spinePoints := spinePoints collect: [:p | p x , p y , 0].
			(spinePoints size < 1 or: [2 < spinePoints size]) 
				ifTrue: [^self error: 'unexpected error'].
			spinePoints size = 1 
				ifTrue: 
					[sp1 := spinePoints first.
					p1 := (trianglePoints select: [:p | p z = 0]) first.
					p2 := (trianglePoints select: [:p | p z = 0]) last.
					p3 := trianglePoints detect: [:p | p z ~= 0].
					points1 := self 
								pointsOval: sp1
								horizontal: p1
								vertical: p3.
					points2 := self 
								pointsOval: sp1
								horizontal: p2
								vertical: p3.
					object := self 
								sewPoints: points1
								withPoints: points2
								reverseFlag: false.
					body add: object].
			spinePoints size = 2 
				ifTrue: 
					[sp1 := spinePoints first.
					sp2 := spinePoints last.
					p1 := (trianglePoints reject: [:p | p z = 0]) first.
					p2 := (trianglePoints reject: [:p | p z = 0]) last.
					p3 := trianglePoints detect: [:p | p z = 0].
					points1 := self 
								pointsOval: sp1
								horizontal: p3
								vertical: p1.
					points2 := self 
								pointsOval: sp2
								horizontal: p3
								vertical: p2.
					object := self 
								sewPoints: points1
								withPoints: points2
								reverseFlag: false.
					body add: object]].
	^body
]

{ #category : #'body creation' }
JunFormCreation >> complexBody2 [
	| table body trianglePoints spinePoints sp1 p1 p2 p3 points1 points2 object sp2 |
	table := self tableForSpinePointToLiftUpAmount.
	body := JunOpenGL3dCompoundObject new.
	self triangles do: 
			[:triangle | 
			trianglePoints := triangle points 
						collect: [:p | p x , p y , (table at: p ifAbsent: [0])].
			spinePoints := triangle points select: [:p | table includesKey: p].
			spinePoints := spinePoints collect: [:p | p x , p y , 0].
			(spinePoints size < 1 or: [2 < spinePoints size]) 
				ifTrue: [^self error: 'unexpected error'].
			spinePoints size = 1 
				ifTrue: 
					[sp1 := spinePoints first.
					p1 := (trianglePoints select: [:p | p z = 0]) first.
					p2 := (trianglePoints select: [:p | p z = 0]) last.
					p3 := trianglePoints detect: [:p | p z ~= 0].
					points1 := self 
								pointsOval: sp1
								horizontal: p1
								vertical: p3.
					points2 := self 
								pointsOval: sp1
								horizontal: p2
								vertical: p3.
					object := self 
								sewPoints: points1
								withPoints: points2
								reverseFlag: true.
					body add: object].
			spinePoints size = 2 
				ifTrue: 
					[sp1 := spinePoints first.
					sp2 := spinePoints last.
					p1 := (trianglePoints reject: [:p | p z = 0]) first.
					p2 := (trianglePoints reject: [:p | p z = 0]) last.
					p3 := trianglePoints detect: [:p | p z = 0].
					points1 := self 
								pointsOval: sp1
								horizontal: p3
								vertical: p1.
					points2 := self 
								pointsOval: sp2
								horizontal: p3
								vertical: p2.
					object := self 
								sewPoints: points1
								withPoints: points2
								reverseFlag: true.
					body add: object]].
	^body
]

{ #category : #computing }
JunFormCreation >> compute [
	self draftTriangleNodes.
	self triangleNodes.
	self chordalAxesTable.
	self computeChordalAxes.
	self fanTriangles.
	self prunChordalAxes.
	self spines.
	self triangles.
	^self body
]

{ #category : #computing }
JunFormCreation >> computeChordalAxes [
	| visitedTriangles streamChordalAxesTtoT streamChordalAxesTtoJ streamChordalAxesJtoJ |
	visitedTriangles := Set new.
	streamChordalAxesTtoT := WriteStream on: Array new.
	streamChordalAxesTtoJ := WriteStream on: Array new.
	self terminalTriangleNodes do: 
		[:terminalTriangle | 
		| stream sp triangle triangles points |
		(visitedTriangles includes: terminalTriangle)
			ifFalse: 
				[stream := WriteStream on: Array new.
				stream nextPut: terminalTriangle tp.
				sp := terminalTriangle spinePoints first.
				stream nextPut: sp.
				visitedTriangles add: terminalTriangle.
				triangles := (self chordalAxesTable at: sp)
							reject: [:each | each = terminalTriangle].
				triangle := triangles first.
				[triangle isSleeve]
					whileTrue: 
						[points := triangle spinePoints reject: [:each | each = sp].
						sp := points first.
						stream nextPut: sp.
						visitedTriangles add: triangle.
						triangles := (self chordalAxesTable at: sp)
									reject: [:each | each = triangle].
						triangle := triangles first].
				triangle isJunction
					ifTrue: 
						[stream nextPut: triangle jp.
						streamChordalAxesTtoJ nextPut: stream contents].
				triangle isTerminal
					ifTrue: 
						[stream nextPut: triangle tp.
						visitedTriangles add: triangle.
						streamChordalAxesTtoT nextPut: stream contents]]].
	streamChordalAxesJtoJ := WriteStream on: Array new.
	self junctionTriangleNodes
		do: 
			[:junctionTriangle | 
			| nodes stream sp triangles triangle points |
			nodes := junctionTriangle triangleNodes reject: [:each | visitedTriangles includes: each].
			nodes do: [:triangleNode | (visitedTriangles includes: triangleNode)
					ifFalse: 
						[stream := WriteStream on: Array new.
						stream nextPut: junctionTriangle jp.
						sp := triangleNode spinePoints detect: [:each | (self chordalAxesTable at: each)
										includes: junctionTriangle].
						stream nextPut: sp.
						visitedTriangles add: junctionTriangle.
						triangles := (self chordalAxesTable at: sp)
									reject: [:each | each = junctionTriangle].
						triangle := triangles first.
						[triangle isSleeve]
							whileTrue: 
								[points := triangle spinePoints reject: [:each | each = sp].
								sp := points first.
								stream nextPut: sp.
								visitedTriangles add: triangle.
								triangles := (self chordalAxesTable at: sp)
											reject: [:each | each = triangle].
								triangle := triangles first].
						triangle isJunction
							ifTrue: 
								[stream nextPut: triangle jp.
								visitedTriangles add: triangle].
						triangle isTerminal ifTrue: [^self error: 'unexpected error'].
						streamChordalAxesJtoJ nextPut: stream contents]]].
	^Array
		with: streamChordalAxesTtoT contents
		with: streamChordalAxesTtoJ contents
		with: streamChordalAxesJtoJ contents
]

{ #category : #computing }
JunFormCreation >> computeChordalAxesTable [
	| aDictionary triangleNodeCollection aCollection |
	self isEmpty ifTrue: [^Dictionary new].
	aDictionary := Dictionary new.
	triangleNodeCollection := self triangleNodes.
	triangleNodeCollection do: [:triangleNode | triangleNode spinePoints
			do: 
				[:aPoint | 
				(aDictionary includesKey: aPoint)
					ifFalse: [aDictionary at: aPoint put: (OrderedCollection new: 2)].
				aCollection := aDictionary at: aPoint.
				aCollection add: triangleNode]].
	triangleNodeCollection do: 
		[:triangleNode | 
		| spinePoint |
		#(#sp1 #sp2 #sp3) with: #(#tn1: #tn2: #tn3:)
			do: 
				[:msg1 :msg2 | 
				spinePoint := triangleNode perform: msg1.
				spinePoint isNil
					ifFalse: 
						[aCollection := (aDictionary at: spinePoint)
									reject: [:each | each = triangleNode].
						aCollection size > 1 ifTrue: [^self error: 'unexpected error'].
						aCollection size = 1
							ifTrue: [triangleNode perform: msg2 with: (aCollection at: 1)]
							ifFalse: [^self error: 'unexpected error']]]].
	^aDictionary
]

{ #category : #computing }
JunFormCreation >> computeDraftTriangleNodes [
	| triangleCollection aStream midPoints triangleNode |
	triangleCollection := self triangulatedTriangles.
	aStream := WriteStream on: (Array new: self points size).
	(1 to: self points size - 1)
		with: (2 to: self points size)
		do: 
			[:n1 :n2 | 
			| p1 p2 |
			p1 := self points at: n1.
			p2 := self points at: n2.
			aStream nextPut: p2 - p1 / (2 @ 2) + p1].
	midPoints := (Set new) addAll: aStream contents; yourself.
	aStream := WriteStream on: (Array new: triangleCollection size).
	triangleCollection
		do: 
			[:points | 
			| collection |
			triangleNode := JunFormTriangleNode vertexPoints: points.
			collection := OrderedCollection new: 3.
			(midPoints includes: triangleNode m1)
				ifFalse: [collection add: triangleNode m1].
			(midPoints includes: triangleNode m2)
				ifFalse: [collection add: triangleNode m2].
			(midPoints includes: triangleNode m3)
				ifFalse: [collection add: triangleNode m3].
			triangleNode := nil.
			collection size = 1 ifTrue: [triangleNode := JunFormTriangleTerminal vertexPoints: points spinePoints: collection].
			collection size = 2 ifTrue: [triangleNode := JunFormTriangleSleeve vertexPoints: points spinePoints: collection].
			collection size = 3 ifTrue: [triangleNode := JunFormTriangleJunction vertexPoints: points spinePoints: collection].
			triangleNode isNil ifTrue: [^self error: 'unexpected error'].
			aStream nextPut: triangleNode].
	^aStream contents
]

{ #category : #computing }
JunFormCreation >> computeFinalBody [
	^self complexBody
]

{ #category : #computing }
JunFormCreation >> computeFinalSpines [
	^self spinePolylines
]

{ #category : #computing }
JunFormCreation >> computeFinalTriangles [
	| aStream |
	aStream := WriteStream on: Array new.
	self spinePolylineInformationJunctionToJunction do: 
		[:each | 
		| triangleCollection |
		each
			do: 
				[:array | 
				triangleCollection := array last.
				aStream nextPutAll: triangleCollection]].
	self spinePolylineInformationTerminalToJunction do: 
		[:each | 
		| triangleCollection |
		each
			do: 
				[:array | 
				triangleCollection := array last.
				aStream nextPutAll: triangleCollection]].
	self spinePolylineInformationTerminalToTerminal do: 
		[:each | 
		| triangleCollection |
		each
			do: 
				[:array | 
				triangleCollection := array last.
				aStream nextPutAll: triangleCollection]].
	^aStream contents
]

{ #category : #computing }
JunFormCreation >> computeTriangleNodes [
	| aDictionary triangleNodeCollection aCollection removingTriangleNodes rootTriangleNode aStream |
	self isEmpty ifTrue: [^Array new].
	aDictionary := Dictionary new.
	triangleNodeCollection := self draftTriangleNodes.
	triangleNodeCollection do: [:triangleNode | triangleNode spinePoints
			do: 
				[:aPoint | 
				(aDictionary includesKey: aPoint)
					ifFalse: [aDictionary at: aPoint put: (OrderedCollection new: 2)].
				aCollection := aDictionary at: aPoint.
				aCollection add: triangleNode]].
	removingTriangleNodes := OrderedCollection new.
	triangleNodeCollection do: 
		[:triangleNode | 
		| spinePoint |
		#(#sp1 #sp2 #sp3) with: #(#tn1: #tn2: #tn3:)
			do: 
				[:msg1 :msg2 | 
				spinePoint := triangleNode perform: msg1.
				spinePoint isNil
					ifFalse: 
						[aCollection := (aDictionary at: spinePoint)
									reject: [:each | each = triangleNode].
						aCollection size > 1 ifTrue: [^self error: 'unexpected error'].
						aCollection size = 1
							ifTrue: [triangleNode perform: msg2 with: (aCollection at: 1)]
							ifFalse: [removingTriangleNodes add: triangleNode]]]].
	rootTriangleNode := triangleNodeCollection
				detect: 
					[:triangleNode | 
					| boolean |
					boolean := (removingTriangleNodes includes: triangleNode) not.
					boolean and: [(triangleNode triangleNodes detect: [:each | removingTriangleNodes includes: each]
							ifNone: [nil]) isNil]]
				ifNone: [nil].
	rootTriangleNode isNil ifTrue: [^self error: 'unexpected error'].
	aStream := WriteStream on: (Array new: triangleNodeCollection size).
	rootTriangleNode do: [:triangleNode | (removingTriangleNodes includes: triangleNode)
			ifFalse: [aStream nextPut: triangleNode]].
	aStream contents size < 2 ifTrue: [^self error: 'unexpected error'].
	triangleNodeCollection := aStream contents.
	triangleNodeCollection do: [:triangleNode | triangleNode flushTriangleNodes].
	aDictionary := Dictionary new.
	triangleNodeCollection do: [:triangleNode | triangleNode spinePoints
			do: 
				[:aPoint | 
				(aDictionary includesKey: aPoint)
					ifFalse: [aDictionary at: aPoint put: (OrderedCollection new: 2)].
				aCollection := aDictionary at: aPoint.
				aCollection add: triangleNode]].
	aStream := WriteStream on: (Array new: triangleNodeCollection size).
	triangleNodeCollection
		do: 
			[:triangleNode | 
			| spinePoint |
			spinePoint := triangleNode spinePoints detect: [:sp | (aDictionary at: sp) size ~= 2]
						ifNone: [nil].
			spinePoint isNil
				ifTrue: [aStream nextPut: triangleNode]
				ifFalse: 
					[| points collection triangle |
					points := triangleNode points.
					collection := triangleNode spinePoints reject: [:p | p = spinePoint].
					triangle := JunFormTriangleTerminal vertexPoints: points spinePoints: collection.
					aStream nextPut: triangle]].
	triangleNodeCollection := aStream contents.
	^triangleNodeCollection
]

{ #category : #private }
JunFormCreation >> createTriangle: vertexPoints [ 
	| trianglePoints aPlane aTriangle |
	trianglePoints := vertexPoints collect: [:p | p x , p y , 0].
	aPlane := JunPlane
				on: (trianglePoints at: 1)
				on: (trianglePoints at: 2)
				on: (trianglePoints at: 3).
	0 > (aPlane valueF: 0 , 0 , self defaultSoFar)
		ifTrue: [aTriangle := JunFormTriangle vertexPoints: vertexPoints yourself]
		ifFalse: [aTriangle := JunFormTriangle vertexPoints: vertexPoints reverse].
	^aTriangle
]

{ #category : #defaults }
JunFormCreation >> defaultLiftUpFactor [
	^0.8
]

{ #category : #defaults }
JunFormCreation >> defaultOvalFactor [
	^4
]

{ #category : #defaults }
JunFormCreation >> defaultOvalFactors [
	"JunFormCreation new defaultOvalFactors."

	| step |
	step := 90 / self defaultOvalFactor.
	^(0 to: 90 by: step) asArray
]

{ #category : #defaults }
JunFormCreation >> defaultPaint [
	^ColorValue gray
]

{ #category : #defaults }
JunFormCreation >> defaultSoFar [
	^29999
]

{ #category : #displaying }
JunFormCreation >> displayChordalAxesOn: graphicsContext [ 
	self displayChordalAxesOn: graphicsContext at: Point zero
]

{ #category : #displaying }
JunFormCreation >> displayChordalAxesOn: graphicsContext at: aPoint [ 
	| displayPoint |
	displayPoint := Point zero - self boundingBox origin + aPoint.
	graphicsContext paint: ColorValue white.
	graphicsContext displayRectangle: self boundingBox at: displayPoint.
	graphicsContext capStyle: GraphicsContext capButt.
	graphicsContext joinStyle: GraphicsContext joinBevel.
	graphicsContext lineWidth: 1.
	graphicsContext paint: ColorValue gray.
	graphicsContext displayRectangularBorder: (self boundingBox insetBy: (0 @ 0 corner: 1 @ 1))
		at: displayPoint.
	self sleeveTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue green blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue green.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self terminalTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue red blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue red.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self junctionTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue blue blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue blue.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self chordalAxesTerminalToTerminal
		do: 
			[:chordalAxis | 
			graphicsContext lineWidth: 2.
			graphicsContext paint: ColorValue cyan.
			graphicsContext displayPolyline: chordalAxis at: displayPoint].
	self chordalAxesTerminalToJunction
		do: 
			[:chordalAxis | 
			graphicsContext lineWidth: 2.
			graphicsContext paint: ColorValue magenta.
			graphicsContext displayPolyline: chordalAxis at: displayPoint].
	self chordalAxesJunctionToJunction
		do: 
			[:chordalAxis | 
			graphicsContext lineWidth: 2.
			graphicsContext paint: ColorValue yellow.
			graphicsContext displayPolyline: chordalAxis at: displayPoint]
]

{ #category : #displaying }
JunFormCreation >> displayDraftTriangleNodesOn: graphicsContext [ 
	self displayDraftTriangleNodesOn: graphicsContext at: Point zero
]

{ #category : #displaying }
JunFormCreation >> displayDraftTriangleNodesOn: graphicsContext at: aPoint [ 
	| displayPoint |
	displayPoint := Point zero - self boundingBox origin + aPoint.
	graphicsContext paint: ColorValue white.
	graphicsContext displayRectangle: self boundingBox at: displayPoint.
	graphicsContext capStyle: GraphicsContext capButt.
	graphicsContext joinStyle: GraphicsContext joinBevel.
	graphicsContext lineWidth: 1.
	graphicsContext paint: ColorValue gray.
	graphicsContext displayRectangularBorder: (self boundingBox insetBy: (0 @ 0 corner: 1 @ 1))
		at: displayPoint.
	self draftSleeveTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue green blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue green.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self draftTerminalTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue red blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue red.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self draftJunctionTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue blue blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue blue.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self draftTriangleNodes
		do: 
			[:aTriangle | 
			| aCollection |
			aCollection := aTriangle spinePoints.
			1 to: aCollection size
				do: 
					[:n | 
					| p box |
					p := aCollection at: n.
					box := (p extent: 0 @ 0)
								expandedBy: 1.
					graphicsContext paint: ColorValue black.
					graphicsContext displayRectangle: box at: displayPoint]]
]

{ #category : #displaying }
JunFormCreation >> displayOn: graphicsContext [ 
	self displayOn: graphicsContext at: Point zero
]

{ #category : #displaying }
JunFormCreation >> displayOn: graphicsContext at: aPoint [ 
	| displayPoint |
	displayPoint := Point zero - self boundingBox origin + aPoint.
	graphicsContext paint: ColorValue white.
	graphicsContext displayRectangle: self boundingBox at: displayPoint.
	graphicsContext capStyle: GraphicsContext capButt.
	graphicsContext joinStyle: GraphicsContext joinBevel.
	graphicsContext lineWidth: 1.
	graphicsContext paint: ColorValue gray.
	graphicsContext displayRectangularBorder: (self boundingBox insetBy: (0 @ 0 corner: 1 @ 1))
		at: displayPoint.
	self triangles
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue cyan blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue blue.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self spines
		do: 
			[:spinePolyline | 
			graphicsContext lineWidth: 2.
			graphicsContext paint: ColorValue red.
			spinePolyline size = 1
				ifTrue: [graphicsContext displayRectangle: ((spinePolyline first extent: 0 @ 0)
							expandedBy: 1)
						at: displayPoint]
				ifFalse: [graphicsContext displayPolyline: spinePolyline at: displayPoint]]
]

{ #category : #displaying }
JunFormCreation >> displayPolylineOn: graphicsContext [ 
	self displayPolylineOn: graphicsContext at: Point zero
]

{ #category : #displaying }
JunFormCreation >> displayPolylineOn: graphicsContext at: aPoint [ 
	| displayPoint |
	displayPoint := Point zero - self boundingBox origin + aPoint.
	graphicsContext paint: ColorValue white.
	graphicsContext displayRectangle: self boundingBox at: displayPoint.
	graphicsContext capStyle: GraphicsContext capButt.
	graphicsContext joinStyle: GraphicsContext joinBevel.
	graphicsContext lineWidth: 1.
	graphicsContext paint: ColorValue gray.
	graphicsContext displayRectangularBorder: (self boundingBox insetBy: (0 @ 0 corner: 1 @ 1))
		at: displayPoint.
	graphicsContext lineWidth: 1.
	graphicsContext paint: ColorValue black.
	graphicsContext displayPolyline: self points at: displayPoint.
	graphicsContext lineWidth: 1.
	graphicsContext paint: ColorValue green.
	self points do: [:p | graphicsContext displayRectangle: ((p extent: 0 @ 0)
				expandedBy: 1)
			at: displayPoint]
]

{ #category : #displaying }
JunFormCreation >> displaySpinePolylinesOn: graphicsContext [ 
	self displaySpinePolylinesOn: graphicsContext at: Point zero
]

{ #category : #displaying }
JunFormCreation >> displaySpinePolylinesOn: graphicsContext at: aPoint [ 
	| displayPoint |
	displayPoint := Point zero - self boundingBox origin + aPoint.
	graphicsContext paint: ColorValue white.
	graphicsContext displayRectangle: self boundingBox at: displayPoint.
	graphicsContext capStyle: GraphicsContext capButt.
	graphicsContext joinStyle: GraphicsContext joinBevel.
	graphicsContext lineWidth: 1.
	graphicsContext paint: ColorValue gray.
	graphicsContext displayRectangularBorder: (self boundingBox insetBy: (0 @ 0 corner: 1 @ 1))
		at: displayPoint.
	self sleeveTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue green blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue green.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self terminalTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue red blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue red.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self junctionTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue blue blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue blue.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self fanTriangles
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue magenta blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue magenta.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self spinePolylines
		do: 
			[:spinePolyline | 
			graphicsContext lineWidth: 2.
			graphicsContext paint: ColorValue yellow.
			spinePolyline size = 1
				ifTrue: [graphicsContext displayRectangle: ((spinePolyline first extent: 0 @ 0)
							expandedBy: 1)
						at: displayPoint]
				ifFalse: [graphicsContext displayPolyline: spinePolyline at: displayPoint]]
]

{ #category : #displaying }
JunFormCreation >> displayTriangleNodesOn: graphicsContext [ 
	self displayTriangleNodesOn: graphicsContext at: Point zero
]

{ #category : #displaying }
JunFormCreation >> displayTriangleNodesOn: graphicsContext at: aPoint [ 
	| displayPoint |
	displayPoint := Point zero - self boundingBox origin + aPoint.
	graphicsContext paint: ColorValue white.
	graphicsContext displayRectangle: self boundingBox at: displayPoint.
	graphicsContext capStyle: GraphicsContext capButt.
	graphicsContext joinStyle: GraphicsContext joinBevel.
	graphicsContext lineWidth: 1.
	graphicsContext paint: ColorValue gray.
	graphicsContext displayRectangularBorder: (self boundingBox insetBy: (0 @ 0 corner: 1 @ 1))
		at: displayPoint.
	self sleeveTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue green blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue green.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self terminalTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue red blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue red.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self junctionTriangleNodes
		do: 
			[:aTriangle | 
			| aPolylineLoop |
			aPolylineLoop := aTriangle asPolylineLoop.
			graphicsContext lineWidth: 1.
			graphicsContext paint: (ColorValue blue blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolylineLoop at: displayPoint.
			graphicsContext paint: ColorValue blue.
			graphicsContext displayPolyline: aPolylineLoop at: displayPoint].
	self triangleNodes
		do: 
			[:aTriangle | 
			| aCollection |
			aCollection := aTriangle spinePoints.
			1 to: aCollection size
				do: 
					[:n | 
					| p box |
					p := aCollection at: n.
					box := (p extent: 0 @ 0)
								expandedBy: 1.
					graphicsContext paint: ColorValue black.
					graphicsContext displayRectangle: box at: displayPoint]]
]

{ #category : #displaying }
JunFormCreation >> displayTriangulatedTrianglesOn: graphicsContext [ 
	self displayTriangulatedTrianglesOn: graphicsContext at: Point zero
]

{ #category : #displaying }
JunFormCreation >> displayTriangulatedTrianglesOn: graphicsContext at: aPoint [ 
	| displayPoint aPolyline |
	displayPoint := Point zero - self boundingBox origin + aPoint.
	graphicsContext paint: ColorValue white.
	graphicsContext displayRectangle: self boundingBox at: displayPoint.
	graphicsContext capStyle: GraphicsContext capButt.
	graphicsContext joinStyle: GraphicsContext joinBevel.
	graphicsContext lineWidth: 1.
	graphicsContext paint: ColorValue gray.
	graphicsContext displayRectangularBorder: (self boundingBox insetBy: (0 @ 0 corner: 1 @ 1))
		at: displayPoint.
	self triangulation triangles
		do: 
			[:triangle | 
			triangle first = triangle last
				ifTrue: [aPolyline := triangle]
				ifFalse: [aPolyline := triangle , (Array with: triangle first)].
			aPolyline := aPolyline collect: [:each | each x rounded @ each y rounded].
			graphicsContext paint: (ColorValue red blendWith: ColorValue white).
			graphicsContext displayPolygon: aPolyline at: displayPoint.
			graphicsContext paint: ColorValue red.
			graphicsContext displayPolyline: aPolyline at: displayPoint].
	graphicsContext paint: ColorValue black.
	graphicsContext displayPolyline: self points at: displayPoint
]

{ #category : #'triangle node' }
JunFormCreation >> draftJunctionTriangleNodes [
	^self draftTriangleNodes select: [:draftTriangleNode | draftTriangleNode isJunction]
]

{ #category : #'triangle node' }
JunFormCreation >> draftSleeveTriangleNodes [
	^self draftTriangleNodes select: [:draftTriangleNode | draftTriangleNode isSleeve]
]

{ #category : #'triangle node' }
JunFormCreation >> draftTerminalTriangleNodes [
	^self draftTriangleNodes select: [:draftTriangleNode | draftTriangleNode isTerminal]
]

{ #category : #'triangle node' }
JunFormCreation >> draftTriangleNodes [
	draftTriangleNodes isNil ifTrue: [draftTriangleNodes := self computeDraftTriangleNodes].
	^draftTriangleNodes
]

{ #category : #pruning }
JunFormCreation >> fanCenterAndPoints: chordalAxis [ 
	| fanPoints aBoolean |
	fanPoints := Set new.
	self chordalAxis: chordalAxis
		do: 
			[:from :sp :to | 
			from isNil ifTrue: [fanPoints add: to tp].
			(from notNil and: [to notNil])
				ifTrue: 
					[aBoolean := self
								insideFan: fanPoints
								from: sp
								to: (to pointsAtMidPoint: sp) first.
					fanPoints addAll: from points.
					aBoolean ifFalse: [^Array with: sp with: fanPoints]].
			to isNil ifTrue: [^Array with: sp with: fanPoints]].
	^self error: 'unexpected error'
]

{ #category : #pruning }
JunFormCreation >> fanTriangles [
	fanTriangles isNil ifTrue: [self prunChordalAxes].
	^fanTriangles
]

{ #category : #pruning }
JunFormCreation >> fanTriangles: wedgePoints centerPoint: centerPoint [ 
	| aStream trianglePoints |
	aStream := WriteStream on: (Array new: wedgePoints size).
	(1 to: wedgePoints size - 1)
		with: (2 to: wedgePoints size)
		do: 
			[:index1 :index2 | 
			trianglePoints := Array
						with: (wedgePoints at: index1)
						with: (wedgePoints at: index2)
						with: centerPoint.
			aStream nextPut: (self createTriangle: trianglePoints)].
	^aStream contents
]

{ #category : #'initialize-release' }
JunFormCreation >> initialize [
	super initialize.
	formTriangulation := nil.
	draftTriangleNodes := nil.
	triangleNodes := nil.
	chordalAxesTable := nil.
	chordalAxesInformation := nil.
	fanTriangles := nil.
	spinePolylineInformation := nil.
	finalTriangles := nil.
	finalSpines := nil.
	finalBody := nil.
	self triangulation
]

{ #category : #pruning }
JunFormCreation >> insideFan: pointCollection from: fromPoint to: toPoint [ 
	| radius distance |
	radius := toPoint dist: fromPoint.
	pointCollection
		do: 
			[:aPoint | 
			distance := aPoint dist: fromPoint.
			distance > radius ifTrue: [^false]].
	^true
]

{ #category : #testing }
JunFormCreation >> isEmpty [
	^self points isNil or: [self points size < 5]
]

{ #category : #'triangle node' }
JunFormCreation >> junctionTriangleNodes [
	^self triangleNodes select: [:triangleNode | triangleNode isJunction]
]

{ #category : #'body creation' }
JunFormCreation >> ovalFactors [
	"JunFormCreation new ovalFactors."

	| stream radians x y |
	stream := WriteStream on: Array new.
	self defaultOvalFactors
		do: 
			[:degrees | 
			radians := degrees asDouble degreesToRadians.
			x := radians cos.
			y := radians sin.
			x < 1.0d-12 ifTrue: [x := 0.0d].
			stream nextPut: (Array with: x with: y)].
	^stream contents
]

{ #category : #accessing }
JunFormCreation >> points [
	^formTriangulation points
]

{ #category : #accessing }
JunFormCreation >> points: pointCollection [ 
	| aStream aCollection |
	aStream := WriteStream on: (Array new: pointCollection size).
	pointCollection do: [:aPoint | aStream nextPut: (Point x: aPoint x rounded y: aPoint y rounded)].
	aCollection := aStream contents.
	(aCollection isEmpty not and: [(aCollection first = aCollection last) not])
		ifTrue: [aStream nextPut: aCollection first].
	formTriangulation := self triangulation points: aStream contents.
	draftTriangleNodes := nil.
	triangleNodes := nil.
	chordalAxesTable := nil.
	chordalAxesInformation := nil.
	fanTriangles := nil.
	spinePolylineInformation := nil.
	finalTriangles := nil.
	finalSpines := nil.
	finalBody := nil
]

{ #category : #'body creation' }
JunFormCreation >> pointsOval: cPoint horizontal: hPoint vertical: vPoint [ 
	| factors stream point collection |
	factors := self ovalFactors.
	stream := WriteStream on: Array new.
	factors
		do: 
			[:factor | 
			point := hPoint - cPoint * factor first + cPoint.
			point := point x , point y , ((vPoint - cPoint) z * factor last).
			stream nextPut: point].
	collection := stream contents.
	^collection
]

{ #category : #pruning }
JunFormCreation >> prunChordalAxes [
	| aStream |
	fanTriangles := OrderedCollection new.
	aStream := WriteStream on: Array new.
	aStream nextPut: self prunChordalAxesTerminalToTerminal.
	aStream nextPut: self prunChordalAxesTerminalToJunction.
	aStream nextPut: self prunChordalAxesJunctionToJunction.
	^aStream contents
]

{ #category : #pruning }
JunFormCreation >> prunChordalAxesJunctionToJunction [
	| aStream spineInformation |
	aStream := WriteStream on: (Array new: self chordalAxesJunctionToJunction size).
	self chordalAxesJunctionToJunction
		do: 
			[:chordalAxisJunctionToJunction | 
			spineInformation := self prunChordalAxisJunctionToJunction: chordalAxisJunctionToJunction.
			aStream nextPut: spineInformation].
	^aStream contents
]

{ #category : #pruning }
JunFormCreation >> prunChordalAxesTerminalToJunction [
	| aStream spineInformation |
	aStream := WriteStream on: (Array new: self chordalAxesTerminalToJunction size).
	self chordalAxesTerminalToJunction
		do: 
			[:chordalAxisTerminalToJunction | 
			spineInformation := self prunChordalAxisTerminalToJunction: chordalAxisTerminalToJunction.
			aStream nextPut: spineInformation].
	^aStream contents
]

{ #category : #pruning }
JunFormCreation >> prunChordalAxesTerminalToTerminal [
	| aStream spineInformation |
	aStream := WriteStream on: (Array new: self chordalAxesTerminalToTerminal size).
	self chordalAxesTerminalToTerminal
		do: 
			[:chordalAxisTerminalToTerminal | 
			spineInformation := self prunChordalAxisTerminalToTerminal: chordalAxisTerminalToTerminal.
			aStream nextPut: spineInformation].
	^aStream contents
]

{ #category : #pruning }
JunFormCreation >> prunChordalAxisJunctionToJunction: chordalAxisJunctionToJunction [ 
	| aStream triangleCollection previousSp |
	aStream := WriteStream on: (Array new: chordalAxisJunctionToJunction size).
	self chordalAxis: chordalAxisJunctionToJunction
		do: 
			[:from :sp :to | 
			from isNil
				ifTrue: 
					[previousSp := sp.
					triangleCollection := Array new.
					aStream nextPut: (Array with: sp with: triangleCollection)].
			(from notNil and: [to notNil])
				ifTrue: 
					[from isJunction
						ifTrue: 
							[| points |
							triangleCollection := OrderedCollection new: 2.
							points := from pointsAtMidPoint: sp.
							triangleCollection add: (self createTriangle: (Array
										with: previousSp
										with: sp
										with: points first)).
							triangleCollection add: (self createTriangle: (Array
										with: previousSp
										with: sp
										with: points last)).
							aStream nextPut: (Array with: sp with: triangleCollection asArray)].
					(from isJunction not and: [to isJunction not])
						ifTrue: 
							[triangleCollection := OrderedCollection new: 3.
							(from threeTriangles: sp with: previousSp)
								do: [:vertexPoints | triangleCollection add: (self createTriangle: vertexPoints)].
							aStream nextPut: (Array with: sp with: triangleCollection asArray)].
					to isJunction
						ifTrue: 
							[| points |
							triangleCollection := OrderedCollection new: 5.
							from isJunction not ifTrue: [(from threeTriangles: sp with: previousSp)
									do: [:vertexPoints | triangleCollection add: (self createTriangle: vertexPoints)]].
							points := to pointsAtMidPoint: sp.
							triangleCollection add: (self createTriangle: (Array
										with: sp
										with: to jp
										with: points first)).
							triangleCollection add: (self createTriangle: (Array
										with: sp
										with: to jp
										with: points last)).
							aStream nextPut: (Array with: sp with: triangleCollection asArray)]].
			to isNil
				ifTrue: 
					[triangleCollection := Array new.
					aStream nextPut: (Array with: sp with: triangleCollection)].
			previousSp := sp].
	^aStream contents
]

{ #category : #pruning }
JunFormCreation >> prunChordalAxisTerminalToJunction: chordalAxisTerminalToJunction [ 
	| aStream anArray centerPoint wedgePoints centerIndex triangleCollection index previousSp |
	aStream := WriteStream on: (Array new: chordalAxisTerminalToJunction size).
	anArray := self fanCenterAndPoints: chordalAxisTerminalToJunction.
	centerPoint := anArray first.
	wedgePoints := anArray last.
	centerIndex := chordalAxisTerminalToJunction indexOf: centerPoint.
	wedgePoints := self
				sortWedgePoints: wedgePoints
				centerPoint: centerPoint
				terminalPoint: chordalAxisTerminalToJunction first.
	triangleCollection := self fanTriangles: wedgePoints centerPoint: centerPoint.
	fanTriangles addAll: triangleCollection.
	aStream nextPut: (Array with: centerPoint with: triangleCollection asArray).
	index := 1.
	previousSp := nil.
	self chordalAxis: chordalAxisTerminalToJunction
		do: 
			[:from :sp :to | 
			index > centerIndex
				ifTrue: 
					[(from notNil and: [to notNil])
						ifTrue: 
							[to isJunction not
								ifTrue: 
									[triangleCollection := OrderedCollection new: 3.
									(from threeTriangles: sp with: previousSp)
										do: [:vertexPoints | triangleCollection add: (self createTriangle: vertexPoints)].
									aStream nextPut: (Array with: sp with: triangleCollection asArray)].
							to isJunction
								ifTrue: 
									[| points |
									triangleCollection := OrderedCollection new: 5.
									from isJunction not ifTrue: [(from threeTriangles: sp with: previousSp)
											do: [:vertexPoints | triangleCollection add: (self createTriangle: vertexPoints)]].
									points := to pointsAtMidPoint: sp.
									triangleCollection add: (self createTriangle: (Array
												with: sp
												with: to jp
												with: points first)).
									triangleCollection add: (self createTriangle: (Array
												with: sp
												with: to jp
												with: points last)).
									aStream nextPut: (Array with: sp with: triangleCollection asArray)]].
					to isNil
						ifTrue: 
							[triangleCollection := Array new.
							aStream nextPut: (Array with: sp with: triangleCollection)]].
			(index = (centerIndex + 1) and: [from isJunction and: [to isNil]])
				ifTrue: 
					[| points |
					triangleCollection := OrderedCollection new: 2.
					points := from pointsAtMidPoint: previousSp.
					triangleCollection add: (self createTriangle: (Array
								with: previousSp
								with: from jp
								with: points first)).
					triangleCollection add: (self createTriangle: (Array
								with: previousSp
								with: from jp
								with: points last)).
					aStream nextPut: (Array with: previousSp with: triangleCollection asArray)].
			index := index + 1.
			previousSp := sp].
	^aStream contents
]

{ #category : #pruning }
JunFormCreation >> prunChordalAxisTerminalToTerminal: chordalAxisTerminalToTerminal [ 
	| aStream anArray centerPoint1 wedgePoints1 centerIndex1 triangleCollection1 centerPoint2 wedgePoints2 centerIndex2 triangleCollection2 triangleCollection index previousSp |
	aStream := WriteStream on: (Array new: chordalAxisTerminalToTerminal size).
	chordalAxisTerminalToTerminal size = 3
		ifTrue: 
			[centerPoint1 := chordalAxisTerminalToTerminal at: 2.
			wedgePoints1 := Set new.
			self chordalAxis: chordalAxisTerminalToTerminal
				do: 
					[:from :sp :to | 
					from isNil ifTrue: [wedgePoints1 addAll: to points].
					to isNil ifTrue: [wedgePoints1 addAll: from points]].
			wedgePoints1 := wedgePoints1 asArray.
			wedgePoints1 := self
						sortWedgePoints: wedgePoints1
						centerPoint: centerPoint1
						terminalPoint: chordalAxisTerminalToTerminal first.
			wedgePoints1 := wedgePoints1 , (Array with: wedgePoints1 first).
			triangleCollection1 := self fanTriangles: wedgePoints1 centerPoint: centerPoint1.
			fanTriangles addAll: triangleCollection1.
			aStream nextPut: (Array with: centerPoint1 with: triangleCollection1 asArray).
			^aStream contents].
	anArray := self fanCenterAndPoints: chordalAxisTerminalToTerminal.
	centerPoint1 := anArray first.
	wedgePoints1 := anArray last.
	centerIndex1 := chordalAxisTerminalToTerminal indexOf: centerPoint1.
	wedgePoints1 := self
				sortWedgePoints: wedgePoints1
				centerPoint: centerPoint1
				terminalPoint: chordalAxisTerminalToTerminal first.
	triangleCollection1 := self fanTriangles: wedgePoints1 centerPoint: centerPoint1.
	fanTriangles addAll: triangleCollection1.
	aStream nextPut: (Array with: centerPoint1 with: triangleCollection1 asArray).
	anArray := self fanCenterAndPoints: chordalAxisTerminalToTerminal reverse.
	centerPoint2 := anArray first.
	wedgePoints2 := anArray last.
	centerIndex2 := chordalAxisTerminalToTerminal size - (chordalAxisTerminalToTerminal reverse indexOf: centerPoint2) + 1.
	wedgePoints2 := self
				sortWedgePoints: wedgePoints2
				centerPoint: centerPoint2
				terminalPoint: chordalAxisTerminalToTerminal last.
	triangleCollection2 := self fanTriangles: wedgePoints2 centerPoint: centerPoint2.
	fanTriangles addAll: triangleCollection2.
	index := 1.
	previousSp := nil.
	self chordalAxis: chordalAxisTerminalToTerminal
		do: 
			[:from :sp :to | 
			(index > centerIndex1 and: [index <= centerIndex2])
				ifTrue: [(from notNil and: [to notNil])
						ifTrue: 
							[triangleCollection := OrderedCollection new: 3.
							(from threeTriangles: sp with: previousSp)
								do: [:vertexPoints | triangleCollection add: (self createTriangle: vertexPoints)].
							aStream nextPut: (Array with: sp with: triangleCollection asArray)]].
			index := index + 1.
			previousSp := sp].
	aStream nextPut: (Array with: centerPoint2 with: triangleCollection2 asArray).
	^aStream contents
]

{ #category : #'body creation' }
JunFormCreation >> sewPoints: pointCollection1 withPoints: pointCollection2 reverseFlag: aBoolean [ 
	| body points1 points2 p1 p2 p3 p4 points object |
	body := JunOpenGL3dCompoundObject new.
	pointCollection1 first = pointCollection2 first
		ifTrue: 
			[points1 := pointCollection1 reverse.
			points2 := pointCollection2 reverse]
		ifFalse: 
			[points1 := pointCollection1 copy.
			points2 := pointCollection2 copy].
	(1 to: points1 size - 1)
		with: (1 to: points2 size - 1)
		do: 
			[:index1 :index2 | 
			p1 := points1 at: index1.
			p2 := points2 at: index2.
			p3 := points1 at: index1 + 1.
			p4 := points2 at: index2 + 1.
			points := self sortTrianglePoints: (Array
							with: p1
							with: p2
							with: p3).
			aBoolean = true ifTrue: [points := points reverse].
			object := JunOpenGL3dPolygon vertexes: points.
			body add: object.
			p3 = p4
				ifFalse: 
					[points := self sortTrianglePoints: (Array
									with: p2
									with: p3
									with: p4).
					aBoolean = true ifTrue: [points := points reverse].
					object := JunOpenGL3dPolygon vertexes: points.
					body add: object]].
	^body
]

{ #category : #'body creation' }
JunFormCreation >> simpleBody [
	| body |
	body := JunOpenGL3dCompoundObject new.
	self simpleBody1 objectsDo: [:each | (each isKindOf: JunOpenGL3dPolygon)
			ifTrue: [body add: each]].
	self simpleBody2 objectsDo: [:each | (each isKindOf: JunOpenGL3dPolygon)
			ifTrue: [body add: each]].
	body paint: self defaultPaint.
	^body
]

{ #category : #'body creation' }
JunFormCreation >> simpleBody0 [
	| body points polyline polygon |
	body := JunOpenGL3dCompoundObject new.
	self triangles
		do: 
			[:triangle | 
			points := triangle points collect: [:p | p x , p y , 0].
			polyline := JunOpenGL3dPolylineLoop vertexes: points.
			polygon := JunOpenGL3dPolygon vertexes: points.
			body add: (JunOpenGL3dCompoundObject with: polyline with: polygon)].
	^body
]

{ #category : #'body creation' }
JunFormCreation >> simpleBody1 [
	| table body points polyline polygon |
	table := self tableForSpinePointToLiftUpAmount.
	body := JunOpenGL3dCompoundObject new.
	self triangles
		do: 
			[:triangle | 
			points := triangle points collect: [:p | p x , p y , (table at: p ifAbsent: [0]) negated].
			polyline := JunOpenGL3dPolylineLoop vertexes: points.
			polygon := JunOpenGL3dPolygon vertexes: points.
			body add: (JunOpenGL3dCompoundObject with: polyline with: polygon)].
	^body
]

{ #category : #'body creation' }
JunFormCreation >> simpleBody2 [
	| table body points polyline polygon |
	table := self tableForSpinePointToLiftUpAmount.
	body := JunOpenGL3dCompoundObject new.
	self triangles
		do: 
			[:triangle | 
			points := triangle points reverse collect: [:p | p x , p y , (table at: p ifAbsent: [0])].
			polyline := JunOpenGL3dPolylineLoop vertexes: points.
			polygon := JunOpenGL3dPolygon vertexes: points.
			body add: (JunOpenGL3dCompoundObject with: polyline with: polygon)].
	^body
]

{ #category : #'triangle node' }
JunFormCreation >> sleeveTriangleNodes [
	^self triangleNodes select: [:triangleNode | triangleNode isSleeve]
]

{ #category : #private }
JunFormCreation >> sortTrianglePoints: vertexPoints [ 
	| aPlane |
	aPlane := JunPlane
				on: (vertexPoints at: 1)
				on: (vertexPoints at: 2)
				on: (vertexPoints at: 3).
	0 > (aPlane valueF: 0 , 0 , self defaultSoFar)
		ifTrue: [^vertexPoints yourself]
		ifFalse: [^vertexPoints reverse]
]

{ #category : #pruning }
JunFormCreation >> sortWedgePoints: wedgePoints centerPoint: centerPoint terminalPoint: terminalPoint [ 
	| positiveCollection negativeCollection aPlane valueF aStream angle |
	positiveCollection := OrderedCollection new.
	negativeCollection := OrderedCollection new.
	aPlane := JunPlane 
				on: terminalPoint x , terminalPoint y , 0
				on: centerPoint x , centerPoint y , 0
				on: centerPoint x , centerPoint y , 1.
	wedgePoints do: 
			[:aPoint | 
			valueF := aPlane valueF: aPoint x , aPoint y , 0.
			angle := (Jun2dLine from: centerPoint to: terminalPoint) 
						angleWithLine: (Jun2dLine from: centerPoint to: aPoint).
			valueF >= 0 
				ifTrue: [positiveCollection add: (Array with: angle with: aPoint)]
				ifFalse: [negativeCollection add: (Array with: angle with: aPoint)]].
	positiveCollection := positiveCollection 
				asSortedCollection: [:a1 :a2 | a1 first < a2 first].
	negativeCollection := negativeCollection 
				asSortedCollection: [:a1 :a2 | a1 first > a2 first].
	aStream := WriteStream on: (Array new: positiveCollection size * 2).
	negativeCollection do: [:anArray | aStream nextPut: anArray last].
	positiveCollection do: [:anArray | aStream nextPut: anArray last].
	^aStream contents
]

{ #category : #'body creation' }
JunFormCreation >> spineBody0 [
	| body point vertex points polyline |
	body := JunOpenGL3dCompoundObject new.
	self spines
		do: 
			[:spine | 
			spine size = 1
				ifTrue: 
					[point := spine first x , spine first y , 0.
					vertex := JunOpenGL3dVertex point: point.
					body add: vertex].
			spine size > 1
				ifTrue: 
					[points := spine collect: [:p | p x , p y , 0].
					polyline := JunOpenGL3dPolyline vertexes: points.
					body add: polyline]].
	^body
]

{ #category : #'body creation' }
JunFormCreation >> spineBody1 [
	| table body point vertex points polyline |
	table := self tableForSpinePointToLiftUpAmount.
	body := JunOpenGL3dCompoundObject new.
	self spines
		do: 
			[:spine | 
			spine size = 1
				ifTrue: 
					[point := spine first x , spine first y , (table at: spine first ifAbsent: [0]) negated.
					vertex := JunOpenGL3dVertex point: point.
					body add: vertex].
			spine size > 1
				ifTrue: 
					[points := spine collect: [:p | p x , p y , (table at: p ifAbsent: [0]) negated].
					polyline := JunOpenGL3dPolyline vertexes: points.
					body add: polyline]].
	^body
]

{ #category : #'body creation' }
JunFormCreation >> spineBody2 [
	| table body point vertex points polyline |
	table := self tableForSpinePointToLiftUpAmount.
	body := JunOpenGL3dCompoundObject new.
	self spines
		do: 
			[:spine | 
			spine size = 1
				ifTrue: 
					[point := spine first x , spine first y , (table at: spine first ifAbsent: [0]).
					vertex := JunOpenGL3dVertex point: point.
					body add: vertex].
			spine size > 1
				ifTrue: 
					[points := spine collect: [:p | p x , p y , (table at: p ifAbsent: [0])].
					polyline := JunOpenGL3dPolyline vertexes: points.
					body add: polyline]].
	^body
]

{ #category : #'spine polyline' }
JunFormCreation >> spinePolylineInformation [
	| aStream |
	aStream := WriteStream on: Array new.
	self spinePolylineInformationTerminalToTerminal do: [:spineInformation | aStream nextPut: spineInformation].
	self spinePolylineInformationTerminalToJunction do: [:spineInformation | aStream nextPut: spineInformation].
	self spinePolylineInformationJunctionToJunction do: [:spineInformation | aStream nextPut: spineInformation].
	^aStream contents
]

{ #category : #'spine polyline' }
JunFormCreation >> spinePolylineInformationJunctionToJunction [
	spinePolylineInformation isNil ifTrue: [spinePolylineInformation := self prunChordalAxes].
	^spinePolylineInformation at: 3
]

{ #category : #'spine polyline' }
JunFormCreation >> spinePolylineInformationTerminalToJunction [
	spinePolylineInformation isNil ifTrue: [spinePolylineInformation := self prunChordalAxes].
	^spinePolylineInformation at: 2
]

{ #category : #'spine polyline' }
JunFormCreation >> spinePolylineInformationTerminalToTerminal [
	spinePolylineInformation isNil ifTrue: [spinePolylineInformation := self prunChordalAxes].
	^spinePolylineInformation at: 1
]

{ #category : #'spine polyline' }
JunFormCreation >> spinePolylines [
	| aStream |
	aStream := WriteStream on: Array new.
	self spinePolylinesTerminalToTerminal do: [:spinePolyline | aStream nextPut: spinePolyline].
	self spinePolylinesTerminalToJunction do: [:spinePolyline | aStream nextPut: spinePolyline].
	self spinePolylinesJunctionToJunction do: [:spinePolyline | aStream nextPut: spinePolyline].
	^aStream contents
]

{ #category : #'spine polyline' }
JunFormCreation >> spinePolylinesJunctionToJunction [
	^self spinePolylineInformationJunctionToJunction
		collect: 
			[:each | 
			| aPolyline |
			aPolyline := each collect: [:array | array first].
			aPolyline yourself]
]

{ #category : #'spine polyline' }
JunFormCreation >> spinePolylinesTerminalToJunction [
	^self spinePolylineInformationTerminalToJunction
		collect: 
			[:each | 
			| aPolyline |
			aPolyline := each collect: [:array | array first].
			aPolyline yourself]
]

{ #category : #'spine polyline' }
JunFormCreation >> spinePolylinesTerminalToTerminal [
	^self spinePolylineInformationTerminalToTerminal
		collect: 
			[:each | 
			| aPolyline |
			aPolyline := each collect: [:array | array first].
			aPolyline yourself]
]

{ #category : #accessing }
JunFormCreation >> spines [
	finalSpines isNil ifTrue: [finalSpines := self computeFinalSpines].
	^finalSpines
]

{ #category : #'body creation' }
JunFormCreation >> tableForSpinePointToLiftUpAmount [
	| table points dictionary set total amount spines |
	table := self tableForSpinePointToTriangles.
	points := table keys asSet.
	dictionary := Dictionary new: points size.
	table
		keysAndValuesDo: 
			[:point :triangles | 
			set := Set new: 5.
			triangles do: [:triangle | triangle points do: [:each | (points includes: each)
						ifFalse: [set add: each]]].
			total := 0.
			set do: [:each | total := total + (point dist: each)].
			amount := total / set size.
			dictionary at: point put: amount].
	spines := self spines.
	spines do: [:spine | (2 to: spine size - 1)
			do: 
				[:index | 
				| amount1 amount2 amount3 |
				amount1 := dictionary at: (spine at: index - 1).
				amount2 := dictionary at: (spine at: index).
				amount3 := dictionary at: (spine at: index + 1).
				amount := amount1 + amount2 + amount3 / 3.
				dictionary at: (spine at: index)
					put: amount]].
	dictionary keysAndValuesDo: [:key :value | dictionary at: key put: value * self defaultLiftUpFactor].
	^dictionary
]

{ #category : #'body creation' }
JunFormCreation >> tableForSpinePointToTriangles [
	| spines triangles table collection |
	spines := self spines.
	triangles := self triangles.
	table := Dictionary new.
	spines do: [:spine | spine do: [:point | table at: point put: (OrderedCollection new: 5)]].
	triangles do: [:triangle | triangle points
			do: 
				[:point | 
				collection := table at: point ifAbsent: [nil].
				collection notNil ifTrue: [collection add: triangle]]].
	^table
]

{ #category : #'triangle node' }
JunFormCreation >> terminalTriangleNodes [
	^self triangleNodes select: [:triangleNode | triangleNode isTerminal]
]

{ #category : #'triangle node' }
JunFormCreation >> triangleNodes [
	triangleNodes isNil ifTrue: [triangleNodes := self computeTriangleNodes].
	^triangleNodes
]

{ #category : #accessing }
JunFormCreation >> triangles [
	finalTriangles isNil ifTrue: [finalTriangles := self computeFinalTriangles].
	^finalTriangles
]

{ #category : #accessing }
JunFormCreation >> triangulatedTriangles [
	^self triangulation triangles
]

{ #category : #accessing }
JunFormCreation >> triangulation [
	formTriangulation isNil ifTrue: [formTriangulation := JunFormTriangulation new].
	^formTriangulation
]

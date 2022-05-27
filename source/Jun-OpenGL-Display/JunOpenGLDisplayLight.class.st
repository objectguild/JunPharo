"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLDisplayLight,
	#superclass : #JunApplicationModel,
	#instVars : [
		'lightName',
		'lightState',
		'lightColor',
		'lightKind',
		'lightPosition',
		'lightDirection',
		'lightCutoffAngle',
		'coordinateKind',
		'textValue',
		'directionTextValue',
		'cutoffAngleTextValue'
	],
	#category : #'Jun-OpenGL-Display'
}

{ #category : #'instance creation' }
JunOpenGLDisplayLight class >> ambientLight: booleanOnOff color: colorValue [ 
	| displayLight |
	displayLight := self new.
	displayLight lightKind value: #ambient.
	displayLight lightState value: booleanOnOff = true.
	displayLight lightColor color: colorValue.
	^displayLight
]

{ #category : #copyright }
JunOpenGLDisplayLight class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGLDisplayLight class >> example1 [
	"JunOpenGLDisplayLight example1."

	| displayLight |
	displayLight := JunOpenGLDisplayLight new.
	displayLight open.
	^displayLight
]

{ #category : #examples }
JunOpenGLDisplayLight class >> example2 [
	"JunOpenGLDisplayLight example2."

	| displayLight |
	displayLight := JunOpenGLDisplayLight new.
	displayLight lightName: (#jun_Position_Light >> 'Position Light') asString.
	displayLight openInterface: #windowSpecForPositionLight.
	^displayLight
]

{ #category : #examples }
JunOpenGLDisplayLight class >> example3 [
	"JunOpenGLDisplayLight example3."

	| displayLight |
	displayLight := JunOpenGLDisplayLight ambientLight: true color: ColorValue red.
	displayLight lightName: (#jun_Ambient_Light >> 'Ambient Light') asString.
	displayLight openInterface: #windowSpecForAmbientLight.
	^displayLight
]

{ #category : #examples }
JunOpenGLDisplayLight class >> example4 [
	"JunOpenGLDisplayLight example4."

	| displayLight |
	displayLight := JunOpenGLDisplayLight
				parallelLight: true
				color: ColorValue green
				direction: 1 , 0 , -1.
	displayLight lightName: (#jun_Parallel_Light >> 'Parallel Light') asString.
	displayLight open.
	^displayLight
]

{ #category : #examples }
JunOpenGLDisplayLight class >> example5 [
	"JunOpenGLDisplayLight example5."

	| displayLight |
	displayLight := JunOpenGLDisplayLight
				spotLight: true
				color: ColorValue gray
				position: 1 , 1 , -1
				direction: -1 , -1 , 1
				cutoffAngle: (JunAngle fromDeg: 10).
	displayLight lightName: (#jun_Spot_Light >> 'Spot Light') asString.
	displayLight open.
	^displayLight
]

{ #category : #examples }
JunOpenGLDisplayLight class >> example6 [
	"JunOpenGLDisplayLight example6."

	| displayLight |
	displayLight := JunOpenGLDisplayLight
				pointLight: true
				color: ColorValue blue
				position: 1 , 1 , 0.
	displayLight lightName: (#jun_Point_Light >> 'Point Light') asString.
	displayLight open.
	^displayLight
]

{ #category : #examples }
JunOpenGLDisplayLight class >> example7 [
	"JunOpenGLDisplayLight example7."

	| transformedObject compoundObject |
	transformedObject := JunOpenGL3dTransformedObject 
				object: JunOpenGL3dObject ball.
	transformedObject := transformedObject scaledBy: 0.65 , 1 , 1.1.
	(JunSensorUtility shiftDown or: [JunSensorUtility altDown]) 
		ifTrue: [transformedObject establishAllNormalVectors].
	transformedObject showIn: (100 @ 300 extent: 400 @ 400).
	compoundObject := transformedObject transformedObject.
	compoundObject showIn: (510 @ 300 extent: 400 @ 400)
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight class >> fromTable: aTable for: aLight [ 
	"JunOpenGLDisplayLight fromLispList: ((JunOpenGLDisplayLight new) toLispList)."

	self lightNameFromTable: aTable for: aLight.
	self lightStateFromTable: aTable for: aLight.
	self lightColorFromTable: aTable for: aLight.
	self lightKindFromTable: aTable for: aLight.
	self lightPositionFromTable: aTable for: aLight.
	self lightDirectionFromTable: aTable for: aLight.
	self lightCutoffAngleFromTable: aTable for: aLight.
	^aLight
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight class >> lightColorFromTable: aTable for: aLight [ 
	| aList |
	aList := aTable at: #lightColor ifAbsent: [^aLight].
	aLight lightColor value: (self colorValueFromLispList: aList).
	^aLight
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight class >> lightCutoffAngleFromTable: aTable for: aLight [ 
	| aList |
	aList := aTable at: #lightCutoffAngle ifAbsent: [^aLight].
	aLight lightCutoffAngle value: (JunAngle fromLispList: aList).
	^aLight
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight class >> lightDirectionFromTable: aTable for: aLight [ 
	| aList |
	aList := aTable at: #lightDirection ifAbsent: [^aLight].
	aLight lightDirection value: (Jun3dPoint fromLispList: aList).
	^aLight
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight class >> lightKindFromTable: aTable for: aLight [ 
	| aValue |
	aValue := aTable at: #lightKind ifAbsent: [^aLight].
	aLight lightKind value: aValue.
	^aLight
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight class >> lightNameFromTable: aTable for: aLight [
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight class >> lightPositionFromTable: aTable for: aLight [ 
	| aList |
	aList := aTable at: #lightPosition ifAbsent: [^aLight].
	aLight lightPosition value: (Jun3dPoint fromLispList: aList).
	^aLight
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight class >> lightStateFromTable: aTable for: aLight [ 
	| aValue |
	aValue := aTable at: #lightState ifAbsent: [^aLight].
	aLight lightState value: aValue.
	^aLight
]

{ #category : #'instance creation' }
JunOpenGLDisplayLight class >> parallelLight: booleanOnOff color: colorValue direction: a3dPoint [ 
	| displayLight |
	displayLight := self new.
	displayLight lightKind value: #parallel.
	displayLight lightState value: booleanOnOff = true.
	displayLight lightColor color: colorValue.
	displayLight lightDirection value: a3dPoint.
	^displayLight
]

{ #category : #'instance creation' }
JunOpenGLDisplayLight class >> parallelLight: booleanOnOff color: colorValue position: a3dPoint [ 
	| displayLight |
	displayLight := self new.
	displayLight lightKind value: #parallel.
	displayLight lightState value: booleanOnOff = true.
	displayLight lightColor color: colorValue.
	displayLight lightPosition value: a3dPoint.
	^displayLight
]

{ #category : #'instance creation' }
JunOpenGLDisplayLight class >> pointLight: booleanOnOff color: colorValue position: a3dPoint [ 
	| displayLight |
	displayLight := self new.
	displayLight lightKind value: #point.
	displayLight lightState value: booleanOnOff = true.
	displayLight lightColor color: colorValue.
	displayLight lightPosition value: a3dPoint.
	^displayLight
]

{ #category : #'instance creation' }
JunOpenGLDisplayLight class >> spotLight: booleanOnOff color: colorValue position: a3dPoint [ 
	| displayLight |
	displayLight := self new.
	displayLight lightKind value: #spot.
	displayLight lightState value: booleanOnOff = true.
	displayLight lightColor color: colorValue.
	displayLight lightPosition value: a3dPoint.
	^displayLight
]

{ #category : #'instance creation' }
JunOpenGLDisplayLight class >> spotLight: booleanOnOff color: colorValue position: a3dPoint1 direction: a3dPoint2 cutoffAngle: aJunAngle [
	| displayLight |
	displayLight := self new.
	displayLight lightKind value: #spot.
	displayLight lightState value: booleanOnOff = true.
	displayLight lightColor color: colorValue.
	displayLight lightPosition value: a3dPoint1.
	displayLight lightDirection value: a3dPoint2.
	displayLight lightCutoffAngle value: aJunAngle.
	^displayLight
]

{ #category : #copyright }
JunOpenGLDisplayLight class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLDisplayLight class >> version [
	^'799'
]

{ #category : #'interface specs' }
JunOpenGLDisplayLight class >> windowSpec [
	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#('#{UI.FullSpec}' 
		#window: 
		#('#{UI.WindowSpec}' 
			#label: 
			#('#{Kernel.UserMessage}' 
				#key: #jun_Light 
				#defaultString: 'Light' ) 
			#min: #('#{Core.Point}' 234 381 ) 
			#max: #('#{Core.Point}' 234 381 ) 
			#bounds: #('#{Graphics.Rectangle}' 700 525 934 906 ) ) 
		#component: 
		#('#{UI.SpecCollection}' 
			#collection: #(
				#('#{UI.ArbitraryComponentSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 1 0 -1 1 127 0 ) 
					#name: #colorChoiceView 
					#component: #colorChoiceView ) 
				#('#{UI.LabelSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 128 0 -1 0.333333 150 0 ) 
					#label: 
					#('#{Kernel.UserMessage}' 
						#key: #jun_Switch_ 
						#defaultString: 'Switch:' ) 
					#style: #default ) 
				#('#{UI.RadioButtonSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 10 0 151 0 -1 0.333333 173 0 ) 
					#name: #lightState 
					#model: #lightState 
					#label: 
					#('#{Kernel.UserMessage}' 
						#key: #jun_On 
						#defaultString: 'On' ) 
					#style: #default 
					#select: true ) 
				#('#{UI.RadioButtonSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 10 0 174 0 -1 0.333333 196 0 ) 
					#name: #lightState 
					#model: #lightState 
					#label: 
					#('#{Kernel.UserMessage}' 
						#key: #jun_Off 
						#defaultString: 'Off' ) 
					#style: #default 
					#select: false ) 
				#('#{UI.LabelSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0.5 128 0 -1 1 150 0 ) 
					#label: 
					#('#{Kernel.UserMessage}' 
						#key: #jun_Kind_ 
						#defaultString: 'Kind:' ) 
					#style: #default ) 
				#('#{UI.RadioButtonSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 10 0.5 151 0 -1 1 173 0 ) 
					#name: #lightKind 
					#model: #lightKind 
					#label: 
					#('#{Kernel.UserMessage}' 
						#key: #jun_Ambient 
						#defaultString: 'Ambient' ) 
					#style: #default 
					#select: #ambient ) 
				#('#{UI.RadioButtonSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 10 0.5 174 0 -1 1 196 0 ) 
					#name: #lightKind 
					#model: #lightKind 
					#label: 
					#('#{Kernel.UserMessage}' 
						#key: #jun_Parallel_Light 
						#defaultString: 'Parallel' ) 
					#style: #default 
					#select: #parallel ) 
				#('#{UI.RadioButtonSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 10 0.5 197 0 -1 1 219 0 ) 
					#name: #lightKind 
					#model: #lightKind 
					#label: 
					#('#{Kernel.UserMessage}' 
						#key: #jun_Point_Light 
						#defaultString: 'Point' ) 
					#style: #default 
					#select: #point ) 
				#('#{UI.RadioButtonSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 10 0.5 220 0 0 1.0 242 0 ) 
					#name: #lightKind 
					#model: #lightKind 
					#label: 
					#('#{Kernel.UserMessage}' 
						#key: #jun_Spot_Light 
						#defaultString: 'Spot' ) 
					#style: #default 
					#select: #spot ) 
				#('#{UI.LabelSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 243 0 -1 1 265 0 ) 
					#label: 
					#('#{Kernel.UserMessage}' 
						#key: #jun_Position___x___y___z_ 
						#defaultString: 'Position: (x , y , z)' ) 
					#style: #default ) 
				#('#{UI.InputFieldSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 266 0 -1 1 288 0 ) 
					#name: #textValue 
					#model: #textValue 
					#callbacksSpec: 
					#('#{UI.UIEventCallbackSubSpec}' 
						#focusOutSelector: 
						#textValueChanged: 
						#valueChangeSelector: 
						#textValueChanged: ) 
					#menu: #textMenu 
					#style: #default 
					#type: #string ) 
				#('#{UI.LabelSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 289 0 -1 1 311 0 ) 
					#label: 
					#('#{Kernel.UserMessage}' 
						#key: #jun_Direction___x___y___z_ 
						#defaultString: 'Direction: (x , y , z)' ) 
					#style: #default ) 
				#('#{UI.InputFieldSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 312 0 -1 1 334 0 ) 
					#name: #directionTextValue 
					#model: #directionTextValue 
					#callbacksSpec: 
					#('#{UI.UIEventCallbackSubSpec}' 
						#focusOutSelector: 
						#directionTextValueChanged: 
						#valueChangeSelector: 
						#directionTextValueChanged: ) 
					#menu: #textMenu 
					#style: #default 
					#type: #string ) 
				#('#{UI.LabelSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 335 0 -1 1 357 0 ) 
					#label: 
					#('#{Kernel.UserMessage}' 
						#key: #jun_Cutoff_angle___degree_ 
						#defaultString: 'Cutoff angle: (degree)' ) 
					#style: #default ) 
				#('#{UI.InputFieldSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 358 0 -1 1 380 0 ) 
					#name: #cutoffAngleTextValue 
					#model: #cutoffAngleTextValue 
					#callbacksSpec: 
					#('#{UI.UIEventCallbackSubSpec}' 
						#focusOutSelector: 
						#cutoffAngleTextValueChanged: 
						#valueChangeSelector: 
						#cutoffAngleTextValueChanged: ) 
					#menu: #textMenu 
					#style: #default 
					#type: #string ) ) ) )
]

{ #category : #'interface specs' }
JunOpenGLDisplayLight class >> windowSpecForAmbientLight [
	"UIPainter new openOnClass: self andSelector: #windowSpecForAmbientLight"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: 
			#('#{Kernel.UserMessage}' 
				#key: #jun_Light 
				#defaultString: 'Light' ) 
			#min: #(#Point 234 198 ) 
			#max: #(#Point 234 198 ) 
			#bounds: #(#Rectangle 100 100 334 298 ) ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame 1 0 1 0 -1 1 127 0 ) 
					#name: #colorChoiceView 
					#component: #colorChoiceView ) 
				#(#LabelSpec 
					#layout: #(#LayoutFrame 1 0 128 0 -1 0.5 150 0 ) 
					#label: #(#UserMessage #key: #jun_Switch_ #defaultString: 'Switch:') 
					#style: #default )
				#(#RadioButtonSpec 
					#layout: #(#LayoutFrame 10 0 151 0 -1 0.5 173 0 ) 
					#name: #lightState 
					#model: #lightState 
					#label: #(#UserMessage #key: #jun_On #defaultString: 'On') 
					#style: #default 
					#select: true ) 
				#(#RadioButtonSpec 
					#layout: #(#LayoutFrame 10 0 174 0 -1 0.5 196 0 ) 
					#name: #lightState 
					#model: #lightState 
					#label: #(#UserMessage #key: #jun_Off #defaultString: 'Off') 
					#style: #default 
					#select: false ) ) ) )
]

{ #category : #'interface specs' }
JunOpenGLDisplayLight class >> windowSpecForPositionLight [
	"UIPainter new openOnClass: self andSelector: #windowSpecForPositionLight"

	<resource: #canvas>
	^#(#FullSpec 
		#window: 
		#(#WindowSpec 
			#label: 
			#('#{Kernel.UserMessage}' 
				#key: #jun_Light 
				#defaultString: 'Light' ) 
			#min: #(#Point 234 358 ) 
			#max: #(#Point 234 358 ) 
			#bounds: #(#Rectangle 100 100 334 458 ) ) 
		#component: 
		#(#SpecCollection 
			#collection: #(
				#(#ArbitraryComponentSpec 
					#layout: #(#LayoutFrame 1 0 1 0 -1 1 127 0 ) 
					#name: #colorChoiceView 
					#component: #colorChoiceView ) 
				#(#LabelSpec 
					#layout: #(#LayoutFrame 1 0 128 0 -1 0.333333 150 0 ) 
					#label: #(#UserMessage #key: #jun_Switch_ #defaultString: 'Switch:') 
					#style: #default ) 
				#(#RadioButtonSpec 
					#layout: #(#LayoutFrame 10 0 151 0 -1 0.333333 173 0 ) 
					#name: #lightState 
					#model: #lightState 
					#label: #(#UserMessage #key: #jun_On #defaultString: 'On') 
					#style: #default 
					#select: true ) 
				#(#RadioButtonSpec 
					#layout: #(#LayoutFrame 10 0 174 0 -1 0.333333 196 0 ) 
					#name: #lightState 
					#model: #lightState 
					#label: #(#UserMessage #key: #jun_Off #defaultString: 'Off') 
					#style: #default 
					#select: false ) 
				#(#LabelSpec 
					#layout: #(#LayoutFrame 1 0.5 128 0 -1 1 150 0 ) 
					#label: #(#UserMessage #key: #jun_Kind_ #defaultString: 'Kind:') 
					#style: #default ) 
				#(#RadioButtonSpec 
					#layout: #(#LayoutFrame 10 0.5 151 0 -1 1 173 0 ) 
					#name: #lightKind 
					#model: #lightKind 
					#label: #(#UserMessage #key: #jun_Parallel_Light #defaultString: 'Parallel') 
					#style: #default 
					#select: #parallel ) 
				#(#RadioButtonSpec 
					#layout: #(#LayoutFrame 10 0.5 174 0 -1 1 196 0 ) 
					#name: #lightKind 
					#model: #lightKind 
					#label: #(#UserMessage #key: #jun_Point_Light #defaultString: 'Point') 
					#style: #default 
					#select: #point ) 
				#(#RadioButtonSpec 
					#layout: #(#LayoutFrame 10 0.5 197 0 0 1 219 0 ) 
					#name: #lightKind 
					#model: #lightKind 
					#label: #(#UserMessage #key: #jun_Spot_Light #defaultString: 'Spot') 
					#style: #default 
					#select: #spot ) 
				#(#LabelSpec 
					#layout: #(#LayoutFrame 1 0 220 0 -1 1 242 0 ) 
					#label: #(#UserMessage #key: #jun_Position___x___y___z_ #defaultString: 'Position: (x , y , z)') 
					#style: #default ) 
				#(#InputFieldSpec 
					#layout: #(#LayoutFrame 1 0 243 0 -1 1 265 0 ) 
					#name: #textValue 
					#model: #textValue 
					#callbacksSpec: 
					#(#UIEventCallbackSubSpec 
						#focusOutSelector: 
						#textValueChanged: 
						#valueChangeSelector: 
						#textValueChanged: ) 
					#menu: #textMenu 
					#style: #default 
					#type: #string ) 
				#(#LabelSpec 
					#layout: #(#LayoutFrame 1 0 266 0 -1 1 288 0 ) 
					#label: #(#UserMessage #key: #jun_Direction___x___y___z_ #defaultString: 'Direction: (x , y , z)') 
					#style: #default ) 
				#(#InputFieldSpec 
					#layout: #(#LayoutFrame 1 0 289 0 -1 1 311 0 ) 
					#name: #directionTextValue 
					#model: #directionTextValue 
					#callbacksSpec: 
					#(#UIEventCallbackSubSpec 
						#focusOutSelector: 
						#directionTextValueChanged: 
						#valueChangeSelector: 
						#directionTextValueChanged: ) 
					#menu: #textMenu 
					#style: #default 
					#type: #string ) 
				#(#LabelSpec 
					#layout: #(#LayoutFrame 1 0 312 0 -1 1 334 0 ) 
					#label: #(#UserMessage #key: #jun_Cutoff_angle___degree_ #defaultString: 'Cutoff angle: (degree)') 
					#style: #default ) 
				#(#InputFieldSpec 
					#layout: #(#LayoutFrame 1 0 335 0 -1 1 357 0 ) 
					#name: #cutoffAngleTextValue 
					#model: #cutoffAngleTextValue 
					#callbacksSpec: 
					#(#UIEventCallbackSubSpec 
						#focusOutSelector: 
						#cutoffAngleTextValueChanged: 
						#valueChangeSelector: 
						#cutoffAngleTextValueChanged: ) 
					#menu: #textMenu 
					#style: #default 
					#type: #string ) ) ) )
]

{ #category : #switching }
JunOpenGLDisplayLight >> beOff [
	self lightState value: false
]

{ #category : #switching }
JunOpenGLDisplayLight >> beOn [
	self lightState value: true
]

{ #category : #'interface opening' }
JunOpenGLDisplayLight >> colorChoiceView [
	| view |
	view := JunColorChoiceView new.
	view model: self lightColor.
	^view
]

{ #category : #constructing }
JunOpenGLDisplayLight >> compute: aBlock [ 
	^BlockValue block: aBlock arguments: (Array with: self)
]

{ #category : #accessing }
JunOpenGLDisplayLight >> coordinateKind [
	coordinateKind isNil
		ifTrue: 
			[coordinateKind := ValueHolder with: self defaultCoordinateKind.
			coordinateKind compute: [self coordinateKindChanged]].
	^coordinateKind
]

{ #category : #changing }
JunOpenGLDisplayLight >> coordinateKindChanged [
	^self shouldNotImplement
]

{ #category : #aspects }
JunOpenGLDisplayLight >> cutoffAngleTextValue [
	cutoffAngleTextValue isNil
		ifTrue: 
			[| aStream |
			aStream := WriteStream on: String new.
			aStream nextPutAll: '('.
			aStream nextPutAll: self lightCutoffAngle value deg asFloat printString.
			aStream nextPutAll: ')'.
			cutoffAngleTextValue := aStream contents asText asValue].
	^cutoffAngleTextValue
]

{ #category : #changing }
JunOpenGLDisplayLight >> cutoffAngleTextValueChanged: aController [ 
	| number |
	aController accepted ifFalse: [aController accept].
	number := Object errorSignal handle: [:exception | exception return]
				do: [Compiler isNil
						ifTrue: ["when I am a run time image"
							JunLispSmallCompiler evaluate: aController text]
						ifFalse: [Compiler evaluate: aController text]].
	(number isKindOf: Number)
		ifFalse: [^nil].
	self lightCutoffAngle value: (JunAngle fromDeg: number)
]

{ #category : #defaults }
JunOpenGLDisplayLight >> defaultCoordinateKind [
	^#parallel
]

{ #category : #defaults }
JunOpenGLDisplayLight >> defaultLightCutoffAngle [
	^JunAngle fromDeg: 30
]

{ #category : #defaults }
JunOpenGLDisplayLight >> defaultLightDirection [
	^self lightPosition value negated
]

{ #category : #defaults }
JunOpenGLDisplayLight >> defaultLightKind [
	^#parallel
]

{ #category : #defaults }
JunOpenGLDisplayLight >> defaultLightPosition [
	^0, 0, -100
]

{ #category : #defaults }
JunOpenGLDisplayLight >> defaultLightState [
	^false
]

{ #category : #aspects }
JunOpenGLDisplayLight >> directionTextValue [
	directionTextValue isNil
		ifTrue: 
			[| aStream |
			aStream := WriteStream on: String new.
			aStream nextPutAll: '('.
			aStream nextPutAll: self lightDirection value x asFloat printString.
			aStream nextPutAll: ' , '.
			aStream nextPutAll: self lightDirection value y asFloat printString.
			aStream nextPutAll: ' , '.
			aStream nextPutAll: self lightDirection value z asFloat printString.
			aStream nextPutAll: ')'.
			directionTextValue := aStream contents asText asValue].
	^directionTextValue
]

{ #category : #changing }
JunOpenGLDisplayLight >> directionTextValueChanged: aController [ 
	| point |
	aController accepted ifFalse: [aController accept].
	point := Object errorSignal handle: [:exception | exception return]
				do: [Compiler isNil
						ifTrue: ["when I am a run time image"
							JunLispSmallCompiler evaluate: aController text]
						ifFalse: [Compiler evaluate: aController text]].
	(point isKindOf: Jun3dPoint)
		ifFalse: [^self].
	self lightDirection value: point
]

{ #category : #testing }
JunOpenGLDisplayLight >> isOff [
	^self isOn not
]

{ #category : #testing }
JunOpenGLDisplayLight >> isOn [
	^self lightState value = true
]

{ #category : #accessing }
JunOpenGLDisplayLight >> light [
	self isOn
		ifTrue: 
			[self lightKind value = #ambient ifTrue: [^JunOpenGLAmbientLight color: self lightColor color].
			self lightKind value = #parallel ifTrue: [^JunOpenGLParallelLight direction: self lightDirection value color: self lightColor color].
			self lightKind value = #point ifTrue: [^JunOpenGLPointLight at3dPoint: self lightPosition value color: self lightColor color].
			self lightKind value = #spot ifTrue: [^JunOpenGLSpotLight
					at3dPoint: self lightPosition value
					direction: self lightDirection value
					cutoffAngle: self lightCutoffAngle value
					color: self lightColor color]].
	^nil
]

{ #category : #accessing }
JunOpenGLDisplayLight >> lightColor [
	lightColor isNil
		ifTrue: 
			[lightColor := JunColorChoiceHSB new.
			lightColor compute: [self lightColorChanged]].
	^lightColor
]

{ #category : #changing }
JunOpenGLDisplayLight >> lightColorChanged [
	self isOn ifTrue: [self changed: #light]
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight >> lightColorToLispList [
	| list |
	list := self lispCons.
	list head: #lightColor.
	list tail: (self colorValueToLispList: self lightColor value).
	^list
]

{ #category : #accessing }
JunOpenGLDisplayLight >> lightCutoffAngle [
	lightCutoffAngle isNil
		ifTrue: 
			[lightCutoffAngle := ValueHolder with: self defaultLightCutoffAngle.
			lightCutoffAngle compute: [self lightCutoffAngleChanged]].
	^lightCutoffAngle
]

{ #category : #changing }
JunOpenGLDisplayLight >> lightCutoffAngleChanged [
	self isOn ifTrue: [self changed: #light]
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight >> lightCutoffAngleToLispList [
	| list |
	list := self lispCons.
	list head: #lightCutoffAngle.
	list tail: self lightCutoffAngle value toLispList.
	^list
]

{ #category : #accessing }
JunOpenGLDisplayLight >> lightDirection [
	lightDirection isNil
		ifTrue: 
			[lightDirection := ValueHolder with: self defaultLightDirection.
			lightDirection compute: [self lightDirectionChanged]].
	^lightDirection
]

{ #category : #changing }
JunOpenGLDisplayLight >> lightDirectionChanged [
	self isOn ifTrue: [self changed: #light]
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight >> lightDirectionToLispList [
	| list |
	list := self lispCons.
	list head: #lightDirection.
	list tail: self lightDirection value toLispList.
	^list
]

{ #category : #accessing }
JunOpenGLDisplayLight >> lightKind [
	lightKind isNil
		ifTrue: 
			[lightKind := ValueHolder with: self defaultLightKind.
			lightKind compute: [self lightKindChanged]].
	^lightKind
]

{ #category : #changing }
JunOpenGLDisplayLight >> lightKindChanged [
	| specWrapperOfPositionTextView specWrapperOfDirectionTextView specWrapperOfCutoffAngleTextView |
	self builder isNil ifTrue: [^self].
	specWrapperOfPositionTextView := self builder componentAt: #textValue.
	specWrapperOfPositionTextView notNil ifTrue: [(self lightKind value = #ambient or: [self lightKind value = #parallel])
			ifTrue: [specWrapperOfPositionTextView beInvisible]
			ifFalse: [specWrapperOfPositionTextView beVisible]].
	specWrapperOfDirectionTextView := self builder componentAt: #directionTextValue.
	specWrapperOfDirectionTextView notNil ifTrue: [(self lightKind value = #ambient or: [self lightKind value = #point])
			ifTrue: [specWrapperOfDirectionTextView beInvisible]
			ifFalse: [specWrapperOfDirectionTextView beVisible]].
	specWrapperOfCutoffAngleTextView := self builder componentAt: #cutoffAngleTextValue.
	specWrapperOfCutoffAngleTextView notNil ifTrue: [self lightKind value ~= #spot
			ifTrue: [specWrapperOfCutoffAngleTextView beInvisible]
			ifFalse: [specWrapperOfCutoffAngleTextView beVisible]].
	self isOn ifTrue: [self changed: #light]
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight >> lightKindToLispList [
	| list |
	list := self lispCons.
	list head: #lightKind.
	list tail: self lightKind value.
	^list
]

{ #category : #accessing }
JunOpenGLDisplayLight >> lightName [
	lightName isNil ifTrue: [lightName := (#jun_Light >> 'Light') asString].
	^lightName
]

{ #category : #accessing }
JunOpenGLDisplayLight >> lightName: aString [ 
	lightName := aString asString
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight >> lightNameToLispList [
	| list |
	list := self lispCons.
	list head: #lightName.
	list tail: self lightName.
	^list
]

{ #category : #accessing }
JunOpenGLDisplayLight >> lightPosition [
	lightPosition isNil
		ifTrue: 
			[lightPosition := ValueHolder with: self defaultLightPosition.
			lightPosition compute: [self lightPositionChanged]].
	^lightPosition
]

{ #category : #changing }
JunOpenGLDisplayLight >> lightPositionChanged [
	self isOn ifTrue: [self changed: #light]
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight >> lightPositionToLispList [
	| list |
	list := self lispCons.
	list head: #lightPosition.
	list tail: self lightPosition value toLispList.
	^list
]

{ #category : #accessing }
JunOpenGLDisplayLight >> lightState [
	lightState isNil
		ifTrue: 
			[lightState := self defaultLightState asValue.
			lightState compute: [self lightStateChanged]].
	^lightState
]

{ #category : #changing }
JunOpenGLDisplayLight >> lightStateChanged [
	self changed: #light
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight >> lightStateToLispList [
	| list |
	list := self lispCons.
	list head: #lightState.
	list tail: self lightState value.
	^list
]

{ #category : #'interface opening' }
JunOpenGLDisplayLight >> postBuildWith: aBuilder [ 
	super postBuildWith: aBuilder.
	self lightKindChanged.
	aBuilder notNil ifTrue: [aBuilder window label: self lightName]
]

{ #category : #aspects }
JunOpenGLDisplayLight >> textMenu [
	^[Menu labelList: ParagraphEditor editGroupLabels values: ParagraphEditor editGroupSelectors]
]

{ #category : #aspects }
JunOpenGLDisplayLight >> textValue [
	textValue isNil
		ifTrue: 
			[| aStream |
			aStream := WriteStream on: String new.
			aStream nextPutAll: '('.
			aStream nextPutAll: self lightPosition value x asFloat printString.
			aStream nextPutAll: ' , '.
			aStream nextPutAll: self lightPosition value y asFloat printString.
			aStream nextPutAll: ' , '.
			aStream nextPutAll: self lightPosition value z asFloat printString.
			aStream nextPutAll: ')'.
			textValue := aStream contents asText asValue].
	^textValue
]

{ #category : #changing }
JunOpenGLDisplayLight >> textValueChanged: aController [ 
	| point |
	aController accepted ifFalse: [aController accept].
	point := Object errorSignal handle: [:exception | exception return]
				do: [Compiler isNil
						ifTrue: ["when I am a run time image"
							JunLispSmallCompiler evaluate: aController text]
						ifFalse: [Compiler evaluate: aController text]].
	(point isKindOf: Jun3dPoint)
		ifFalse: [^self].
	self lightPosition value: point
]

{ #category : #'lisp support' }
JunOpenGLDisplayLight >> toLispList [
	"self showLispList: ((JunOpenGLDisplayLight new) toLispList)."

	| list |
	list := self lispCons.
	list head: self kindName.
	lightName ifNotNil: [list add: self lightNameToLispList].
	lightState ifNotNil: [list add: self lightStateToLispList].
	lightColor ifNotNil: [list add: self lightColorToLispList].
	lightKind ifNotNil: [list add: self lightKindToLispList].
	lightPosition ifNotNil: [list add: self lightPositionToLispList].
	lightDirection ifNotNil: [list add: self lightDirectionToLispList].
	lightCutoffAngle ifNotNil: [list add: self lightCutoffAngleToLispList].
	^list
]

{ #category : #accessing }
JunOpenGLDisplayLight >> value [
	^self
]

"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLDisplayObjects,
	#superclass : #JunOpenGLDisplayModel,
	#instVars : [
		'typicalObjects'
	],
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLDisplayObjects class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunOpenGLDisplayObjects class >> example [
	"JunOpenGLDisplayObjects example."

	| displayObjects |
	displayObjects := JunOpenGLDisplayObjects 
				messages: JunOpenGLDisplayObjects exampleMessages.
	displayObjects open.
	^displayObjects
]

{ #category : #examples }
JunOpenGLDisplayObjects class >> example1 [
	"JunOpenGLDisplayObjects example1."

	| displayObjects |
	displayObjects := JunOpenGLDisplayObjects messages: (Array 
						with: (MessageSend receiver: JunOpenGL3dObject selector: #aoki)
						with: (MessageSend receiver: JunOpenGL3dObject selector: #doraemon)
						with: (MessageSend receiver: JunOpenGL3dObject selector: #mickey)
						with: (MessageSend receiver: JunOpenGL3dObject selector: #pooh)).
	displayObjects open.
	^displayObjects
]

{ #category : #examples }
JunOpenGLDisplayObjects class >> exampleMessages [
	"JunOpenGLDisplayObjects exampleMessages."

	^JunOpenGLTypicalObjects exampleMessages
]

{ #category : #'instance creation' }
JunOpenGLDisplayObjects class >> messages: messageCollection [ 
	^(super new)
		messages: messageCollection;
		yourself
]

{ #category : #copyright }
JunOpenGLDisplayObjects class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLDisplayObjects class >> version [
	^'799'
]

{ #category : #'interface specs' }
JunOpenGLDisplayObjects class >> windowSpec [
	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#('#{UI.FullSpec}' 
		#window: 
		#('#{UI.WindowSpec}' 
			#label: 
			#('#{Kernel.UserMessage}' 
				#key: #jun_Display_Objects 
				#defaultString: 'Display Objects' ) 
			#min: #('#{Core.Point}' 480 280 ) 
			#bounds: #('#{Graphics.Rectangle}' 700 525 1200 825 ) 
			#flags: 4 
			#menu: #menuBar ) 
		#component: 
		#('#{UI.SpecCollection}' 
			#collection: #(
				#('#{UI.SubCanvasSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' -200 1 0 0 0 1 0 1 ) 
					#name: #list 
					#flags: 0 ) 
				#('#{UI.SubCanvasSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 0 0 0 0 -200 1 0 1 ) 
					#name: #viewfinder 
					#flags: 0 ) ) ) )
]

{ #category : #'interface specs' }
JunOpenGLDisplayObjects class >> windowSpecViewfinder [
	^super windowSpec
]

{ #category : #private }
JunOpenGLDisplayObjects >> classToSpawn [
	^JunOpenGLDisplayModel
]

{ #category : #'initialize-release' }
JunOpenGLDisplayObjects >> initialize [
	super initialize.
	typicalObjects := nil
]

{ #category : #accessing }
JunOpenGLDisplayObjects >> messages [
	^self typicalObjects messages
]

{ #category : #accessing }
JunOpenGLDisplayObjects >> messages: messageSends [ 
	self typicalObjects messages: messageSends
]

{ #category : #'interface opening' }
JunOpenGLDisplayObjects >> postOpenWith: aBuilder [ 
	super postOpenWith: aBuilder.
	(self builder componentAt: #viewfinder) widget 
		client: self
		spec: #windowSpecViewfinder
		builder: aBuilder.
	(self builder componentAt: #list) widget 
		client: self typicalObjects
		spec: #windowSpec
		builder: aBuilder.
	self yourself
]

{ #category : #aspects }
JunOpenGLDisplayObjects >> typicalObjects [
	typicalObjects ifNil: 
			[typicalObjects := JunOpenGLTypicalObjects new.
			typicalObjects compute: 
					[:aBody | 
					self
						displayObject: aBody;
						resetView]].
	^typicalObjects
]

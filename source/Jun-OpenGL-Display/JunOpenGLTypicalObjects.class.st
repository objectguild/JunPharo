"
Imported by VwImportClass
"
Class {
	#name : #JunOpenGLTypicalObjects,
	#superclass : #JunAbstractModel,
	#instVars : [
		'messageCollection',
		'selectionInList',
		'typicalObjectHolder'
	],
	#classVars : [
		'ExampleMessages'
	],
	#category : #'Jun-OpenGL-Display'
}

{ #category : #copyright }
JunOpenGLTypicalObjects class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #defaults }
JunOpenGLTypicalObjects class >> defaultClassToSpawn [
	^JunOpenGLDisplayModel
]

{ #category : #examples }
JunOpenGLTypicalObjects class >> example [
	"JunOpenGLTypicalObjects example."

	| typicalObjects |
	typicalObjects := JunOpenGLTypicalObjects 
				messages: JunOpenGLTypicalObjects exampleMessages.
	typicalObjects open.
	^typicalObjects
]

{ #category : #examples }
JunOpenGLTypicalObjects class >> example1 [
	"JunOpenGLTypicalObjects example1."

	| typicalObjects |
	typicalObjects := JunOpenGLTypicalObjects messages: (Array 
						with: (MessageSend 
								receiver: JunOpenGL3dObject
								selector: #ball:
								argument: 3)
						with: (MessageSend receiver: JunOpenGL3dObject selector: #doraemon)
						with: (MessageSend receiver: JunOpenGL3dObject selector: #mickey)
						with: (MessageSend receiver: JunOpenGL3dObject selector: #pooh)).
	typicalObjects open.
	^typicalObjects
]

{ #category : #examples }
JunOpenGLTypicalObjects class >> example2 [
	"JunOpenGLTypicalObjects example2."

	| typicalObjects aViewfinder aBox |
	typicalObjects := JunOpenGLTypicalObjects messages: (Array 
						with: (MessageSend 
								receiver: JunOpenGL3dObject
								selector: #ball:
								argument: 3)
						with: (MessageSend receiver: JunOpenGL3dObject selector: #doraemon)
						with: (MessageSend receiver: JunOpenGL3dObject selector: #mickey)
						with: (MessageSend receiver: JunOpenGL3dObject selector: #pooh)).
	aViewfinder := JunOpenGLDisplayModel new.
	typicalObjects compute: 
			[:aBody | 
			aViewfinder
				displayObject: aBody;
				resetView].
	aViewfinder open.
	aBox := aViewfinder getWindow displayBox.
	typicalObjects openAt: aBox topRight + (8 @ 0).
	aViewfinder closeTogether: typicalObjects.
	typicalObjects closeTogether: aViewfinder.
	^typicalObjects
]

{ #category : #examples }
JunOpenGLTypicalObjects class >> exampleMessages [
	"JunOpenGLTypicalObjects exampleMessages."

	| receiverObject classOrganization messageSelectors exampleMessages |
	receiverObject := JunOpenGL3dObject.
	classOrganization := receiverObject class organization.
	messageSelectors := (classOrganization 
				listAtCategoriesNamed: (classOrganization categories 
						select: [:each | 'typical*' match: each])) 
					select: 
						[:messageSelector | 
						messageSelector numArgs = 0 
							and: [(messageSelector findString: 'image' startingAt: 1) = 0]].
	exampleMessages := OrderedCollection new.
	messageSelectors do: 
			[:messageSelector | 
			exampleMessages 
				add: (MessageSend receiver: receiverObject selector: messageSelector)].
	exampleMessages := (exampleMessages 
				asSortedCollection: [:m1 :m2 | m1 selector < m2 selector]) asArray.
	(exampleMessages isEmpty and: [ExampleMessages notNil]) 
		ifTrue: [exampleMessages := ExampleMessages]
		ifFalse: [ExampleMessages := exampleMessages].
	^exampleMessages
]

{ #category : #'class initialization' }
JunOpenGLTypicalObjects class >> install [
	"JunOpenGLTypicalObjects install."

	ExampleMessages := nil.
	self exampleMessages
]

{ #category : #resources }
JunOpenGLTypicalObjects class >> menuBar [
	"Tools.MenuEditor new openOnClass: self andSelector: #menuBar"

	<resource: #menu>
	^#('#{UI.Menu}' #(
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_Look 
					#defaultString: 'View' ) 
				#submenu: #('#{UI.Menu}' #(
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Spawn 
								#defaultString: 'Spawn' ) 
							#value: #spawnObject ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Sort_by_selector 
								#defaultString: 'Sort by selector' ) 
							#value: #sortBySelector ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Sort_by_category 
								#defaultString: 'Sort by category' ) 
							#value: #sortByCategory ) 
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Sort_by_receiver 
								#defaultString: 'Sort by receiver' ) 
							#value: #sortByReceiver ) ) #(1 3 ) nil ) ) 
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_Misc 
					#defaultString: 'Misc' ) 
				#submenu: #('#{UI.Menu}' #(
						#('#{UI.MenuItem}' 
							#rawLabel: 
							#('#{Kernel.UserMessage}' 
								#key: #jun_Inspect 
								#defaultString: 'Inspect' ) 
							#value: #inspectModel ) ) #(1 ) nil ) ) ) #(2 ) nil ) decodeAsLiteralArray
]

{ #category : #'instance creation' }
JunOpenGLTypicalObjects class >> messages: messageCollection [ 
	^(super new)
		messages: messageCollection;
		yourself
]

{ #category : #copyright }
JunOpenGLTypicalObjects class >> system [
	^'Jun'
]

{ #category : #copyright }
JunOpenGLTypicalObjects class >> version [
	^'799'
]

{ #category : #'interface specs' }
JunOpenGLTypicalObjects class >> windowSpec [
	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#('#{UI.FullSpec}' 
		#window: 
		#('#{UI.WindowSpec}' 
			#label: 
			#('#{Kernel.UserMessage}' 
				#key: #jun_Typical_Objects 
				#defaultString: 'Typical Objects' ) 
			#min: #('#{Core.Point}' 180 280 ) 
			#max: #('#{Core.Point}' 0 0 ) 
			#bounds: #('#{Graphics.Rectangle}' 700 525 950 825 ) 
			#flags: 4 
			#menu: #menuBar ) 
		#component: 
		#('#{UI.SpecCollection}' 
			#collection: #(
				#('#{UI.SequenceViewSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 1 0 1 0 -1 1 -1 1 ) 
					#name: #list 
					#flags: 15 
					#model: #selectionInList 
					#menu: #yellowButtonMenu 
					#useModifierKeys: true 
					#selectionType: #highlight ) ) ) )
]

{ #category : #resources }
JunOpenGLTypicalObjects class >> yellowButtonMenu [
	"Tools.MenuEditor new openOnClass: self andSelector: #yellowButtonMenu"

	<resource: #menu>
	^#('#{UI.Menu}' #(
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_Spawn 
					#defaultString: 'Spawn' ) 
				#value: #spawnObject ) 
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_Sort_by_selector 
					#defaultString: 'Sort by selector' ) 
				#value: #sortBySelector ) 
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_Sort_by_category 
					#defaultString: 'Sort by category' ) 
				#value: #sortByCategory ) 
			#('#{UI.MenuItem}' 
				#rawLabel: 
				#('#{Kernel.UserMessage}' 
					#key: #jun_Sort_by_receiver 
					#defaultString: 'Sort by receiver' ) 
				#value: #sortByReceiver ) ) #(1 3 ) nil ) decodeAsLiteralArray
]

{ #category : #private }
JunOpenGLTypicalObjects >> categoryOfMessageSend: messageSend [ 
	^(messageSend receiver class organization 
		categoryOfElement: messageSend selector) ifNil: [String new]
			ifNotNil: 
				[:aProtocol | 
				| aString it |
				aString := aProtocol asString.
				it := 'typical objects '.
				(aString findString: it startingAt: 1) = 1 
					ifTrue: 
						[aString := aString copyFrom: (it size + 1 min: aString size)
									to: aString size].
				aString]
]

{ #category : #attributes }
JunOpenGLTypicalObjects >> classToSpawn [
	^self attributeTable at: #classToSpawn
		ifAbsentPut: [self class defaultClassToSpawn]
]

{ #category : #attributes }
JunOpenGLTypicalObjects >> classToSpawn: aClass [ 
	^self attributeTable at: #classToSpawn put: aClass
]

{ #category : #constructing }
JunOpenGLTypicalObjects >> compute: aBlock [ 
	typicalObjectHolder compute: 
			[:aBody | 
			aBlock 
				valueWithArguments: ((Array 
						with: aBody
						with: self
						with: self selectionInList) copyFrom: 1 to: aBlock numArgs)]
]

{ #category : #private }
JunOpenGLTypicalObjects >> getWindow [
	| aWindow |
	aWindow := self dependents 
				detect: [:each | (each isKindOf: ScheduledWindow) and: [each model = self]]
				ifNone: [nil].
	aWindow isNil ifTrue: [^nil].
	^aWindow
]

{ #category : #'initialize-release' }
JunOpenGLTypicalObjects >> initialize [
	super initialize.
	messageCollection := OrderedCollection new.
	selectionInList := SelectionInList new.
	selectionInList selectionIndexHolder 
		compute: [:index | self selectionIndex: index].
	typicalObjectHolder := JunValueHolder with: nil
]

{ #category : #accessing }
JunOpenGLTypicalObjects >> messages [
	^messageCollection
]

{ #category : #accessing }
JunOpenGLTypicalObjects >> messages: messageSends [ 
	self messages addAll: messageSends.
	self remakeList
]

{ #category : #accessing }
JunOpenGLTypicalObjects >> object [
	^typicalObjectHolder value
]

{ #category : #private }
JunOpenGLTypicalObjects >> remakeList [
	self 
		assert: 
			[| index |
			index := self selectionInList selectionIndexHolder value.
			index > 0 ifTrue: [self messages at: index] ifFalse: [nil]]
		do: 
			[self symbolToSort = #selector ifTrue: [self remakeListSortedBySelector].
			self symbolToSort = #receiver ifTrue: [self remakeListSortedByReceiver].
			self symbolToSort = #category ifTrue: [self remakeListSortedByCategory]]
		ensure: 
			[:it | 
			it ifNotNil: 
					[| index |
					index := self messages indexOf: it.
					index > 0 ifTrue: [self selectionInList selectionIndexHolder value: index]]]
]

{ #category : #private }
JunOpenGLTypicalObjects >> remakeListSortedByCategory [
	| aCollection |
	aCollection := self messages collect: 
					[:messageSend | 
					(Dictionary new)
						add: #receiver -> messageSend receiver;
						add: #selector -> messageSend selector;
						add: #arguments -> messageSend arguments;
						add: #category -> (self categoryOfMessageSend: messageSend);
						yourself].
	aCollection := aCollection asSortedCollection: 
					[:a :b | 
					(a at: #category) = (b at: #category) 
						ifTrue: [(a at: #selector) < (b at: #selector)]
						ifFalse: [(a at: #category) < (b at: #category)]].
	self selectionInList 
		list: (aCollection asList collect: 
					[:table | 
					| aText |
					self 
						assert: [TextStream on: String new]
						do: 
							[:textStream | 
							textStream emphasis: nil.
							textStream nextPutAll: '['.
							textStream nextPutAll: (table at: #category).
							textStream nextPutAll: ']'.
							textStream space.
							textStream emphasis: #bold.
							textStream nextPutAll: (table at: #selector).
							textStream emphasis: nil.
							textStream space.
							textStream nextPutAll: '{'.
							textStream 
								nextPutAll: ((table at: #receiver) printString copyUpTo: Character cr).
							textStream nextPutAll: '}'.
							aText := textStream contents]
						ensure: [:textStream | textStream close].
					aText yourself]).
	messageCollection := aCollection asOrderedCollection collect: 
					[:table | 
					MessageSend 
						receiver: (table at: #receiver)
						selector: (table at: #selector)
						arguments: (table at: #arguments)]
]

{ #category : #private }
JunOpenGLTypicalObjects >> remakeListSortedByReceiver [
	| aCollection |
	aCollection := self messages collect: 
					[:messageSend | 
					(Dictionary new)
						add: #receiver -> messageSend receiver;
						add: #selector -> messageSend selector;
						add: #arguments -> messageSend arguments;
						add: #category -> (self categoryOfMessageSend: messageSend);
						yourself].
	aCollection := aCollection asSortedCollection: 
					[:a :b | 
					(a at: #receiver) = (b at: #receiver) 
						ifTrue: [(a at: #selector) < (b at: #selector)]
						ifFalse: [(a at: #receiver) < (b at: #receiver)]].
	self selectionInList 
		list: (aCollection asList collect: 
					[:table | 
					| aText |
					self 
						assert: [TextStream on: String new]
						do: 
							[:textStream | 
							textStream nextPutAll: '{'.
							textStream 
								nextPutAll: ((table at: #receiver) printString copyUpTo: Character cr).
							textStream nextPutAll: '}'.
							textStream space.
							textStream emphasis: #bold.
							textStream nextPutAll: (table at: #selector).
							textStream space.
							textStream emphasis: nil.
							textStream nextPutAll: '['.
							textStream nextPutAll: (table at: #category).
							textStream nextPutAll: ']'.
							textStream emphasis: nil.
							aText := textStream contents]
						ensure: [:textStream | textStream close].
					aText yourself]).
	messageCollection := aCollection asOrderedCollection collect: 
					[:table | 
					MessageSend 
						receiver: (table at: #receiver)
						selector: (table at: #selector)
						arguments: (table at: #arguments)]
]

{ #category : #private }
JunOpenGLTypicalObjects >> remakeListSortedBySelector [
	| aCollection |
	aCollection := self messages collect: 
					[:messageSend | 
					(Dictionary new)
						add: #receiver -> messageSend receiver;
						add: #selector -> messageSend selector;
						add: #arguments -> messageSend arguments;
						add: #category -> (self categoryOfMessageSend: messageSend);
						yourself].
	aCollection := aCollection asSortedCollection: 
					[:a :b | 
					(a at: #selector) = (b at: #selector) 
						ifTrue: [(a at: #category) < (b at: #category)]
						ifFalse: [(a at: #selector) < (b at: #selector)]].
	self selectionInList 
		list: (aCollection asList collect: 
					[:table | 
					| aText |
					self 
						assert: [TextStream on: String new]
						do: 
							[:textStream | 
							textStream emphasis: #bold.
							textStream nextPutAll: (table at: #selector).
							textStream emphasis: nil.
							textStream space.
							textStream nextPutAll: '['.
							textStream nextPutAll: (table at: #category).
							textStream nextPutAll: ']'.
							textStream emphasis: nil.
							textStream space.
							textStream nextPutAll: '{'.
							textStream 
								nextPutAll: ((table at: #receiver) printString copyUpTo: Character cr).
							textStream nextPutAll: '}'.
							aText := textStream contents]
						ensure: [:textStream | textStream close].
					aText yourself]).
	messageCollection := aCollection asOrderedCollection collect: 
					[:table | 
					MessageSend 
						receiver: (table at: #receiver)
						selector: (table at: #selector)
						arguments: (table at: #arguments)]
]

{ #category : #aspects }
JunOpenGLTypicalObjects >> selectionInList [
	^selectionInList
]

{ #category : #aspects }
JunOpenGLTypicalObjects >> selectionIndex: index [ 
	| typicalObject |
	index = 0 
		ifTrue: [typicalObject := nil]
		ifFalse: 
			[Cursor wait showWhile: 
					[typicalObject := (self messages at: index) value.
					(typicalObject isKindOf: JunOpenGL3dObject) 
						ifFalse: 
							[(typicalObject respondsTo: #asJunOpenGL3dObject) 
								ifTrue: [typicalObject := typicalObject asJunOpenGL3dObject]
								ifFalse: [typicalObject := nil]]]].
	typicalObjectHolder value: typicalObject.
	self updateMenuIndication
]

{ #category : #'menu messages' }
JunOpenGLTypicalObjects >> sortByCategory [
	self symbolToSort: #category.
	self remakeList
]

{ #category : #'menu messages' }
JunOpenGLTypicalObjects >> sortByReceiver [
	self symbolToSort: #receiver.
	self remakeList
]

{ #category : #'menu messages' }
JunOpenGLTypicalObjects >> sortBySelector [
	self symbolToSort: #selector.
	self remakeList
]

{ #category : #'menu messages' }
JunOpenGLTypicalObjects >> spawnObject [
	| aViewfinder |
	self object ifNil: [^nil].
	aViewfinder := self classToSpawn displayObject: self object.
	self getWindow ifNil: [aViewfinder open]
		ifNotNil: 
			[:aWindow | 
			| aBox |
			aBox := aWindow displayBox.
			aViewfinder openAt: aBox topRight + (8 @ 0)].
	self closeTogether: (self closeTogether copyWith: aViewfinder)
]

{ #category : #attributes }
JunOpenGLTypicalObjects >> symbolToSort [
	^self attributeTable at: #symbolToSort ifAbsentPut: [#category]
]

{ #category : #attributes }
JunOpenGLTypicalObjects >> symbolToSort: aSymbol [ 
	(#(#selector #category #receiver) includes: aSymbol) ifFalse: [^nil].
	^self attributeTable at: #symbolToSort put: aSymbol
]

{ #category : #'menu accessing' }
JunOpenGLTypicalObjects >> updateMenuIndication [
	| aMenu menuItem |
	super updateMenuIndication.
	aMenu := self menuBar.
	menuItem := self menuItemLabeled: 'View' inMenu: self menuBar.
	menuItem isNil ifTrue: [^self].
	aMenu := menuItem submenu.
	aMenu isNil ifTrue: [^nil].
	(menuItem := aMenu value menuItemWithValue: #spawnObject ifNone: [nil]) 
		ifNotNil: [self object ifNil: [menuItem disable] ifNotNil: [menuItem enable]].
	(menuItem := aMenu value menuItemWithValue: #sortBySelector ifNone: [nil]) 
		ifNotNil: 
			[self symbolToSort = #selector 
				ifTrue: [menuItem beOn]
				ifFalse: [menuItem beOff]].
	(menuItem := aMenu value menuItemWithValue: #sortByCategory ifNone: [nil]) 
		ifNotNil: 
			[self symbolToSort = #category 
				ifTrue: [menuItem beOn]
				ifFalse: [menuItem beOff]].
	(menuItem := aMenu value menuItemWithValue: #sortByReceiver ifNone: [nil]) 
		ifNotNil: 
			[self symbolToSort = #receiver 
				ifTrue: [menuItem beOn]
				ifFalse: [menuItem beOff]].
	aMenu yourself
]

{ #category : #'menu accessing' }
JunOpenGLTypicalObjects >> updateYellowButtonMenuIndication [
	| aMenu |
	aMenu := self yellowButtonMenu.
	(aMenu value menuItemWithValue: #spawnObject ifNone: [nil]) 
		ifNotNil: [:menuItem | self object ifNil: [menuItem disable] ifNotNil: [menuItem enable]].
	(aMenu value menuItemWithValue: #sortBySelector ifNone: [nil]) ifNotNil: 
			[:menuItem | 
			self symbolToSort = #selector 
				ifTrue: [menuItem beOn]
				ifFalse: [menuItem beOff]].
	(aMenu value menuItemWithValue: #sortByCategory ifNone: [nil]) ifNotNil: 
			[:menuItem | 
			self symbolToSort = #category 
				ifTrue: [menuItem beOn]
				ifFalse: [menuItem beOff]].
	(aMenu value menuItemWithValue: #sortByReceiver ifNone: [nil]) ifNotNil: 
			[:menuItem | 
			self symbolToSort = #receiver 
				ifTrue: [menuItem beOn]
				ifFalse: [menuItem beOff]].
	aMenu yourself
]

"
Imported by VwImportClass
"
Class {
	#name : #JunTableModel,
	#superclass : #JunApplicationModel,
	#instVars : [
		'sightingsTable',
		'tableInterface',
		'tableWidget',
		'selectionChangedBlock'
	],
	#category : #'Jun-Goodies-Tables'
}

{ #category : #copyright }
JunTableModel class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunTableModel class >> example1 [
	"JunTableModel example1."

	JunTableModel open
]

{ #category : #examples }
JunTableModel class >> example2 [
	"JunTableModel example2."

	| tableModel |
	tableModel := JunTableModel new.
	tableModel table: (TwoDList
			on: #('Vulcans' 188 173 192 'Romulans' 26 26 452)
			columns: 4
			rows: 2).
	tableModel open.
	^tableModel
]

{ #category : #examples }
JunTableModel class >> example3 [
	"JunTableModel example3."

	| tableModel |
	tableModel := JunTableModel new.
	tableModel table: (TwoDList
			on: #('Vulcans' 188 173 192 'Romulans' 26 26 452)
			columns: 4
			rows: 2).
	tableModel selectionChangedBlock: [Transcript cr; show: tableModel selectionIndex printString , ' -> ' , tableModel selection printString].
	tableModel open.
	^tableModel
]

{ #category : #copyright }
JunTableModel class >> system [
	^'Jun'
]

{ #category : #copyright }
JunTableModel class >> version [
	^'799'
]

{ #category : #'interface specs' }
JunTableModel class >> windowSpec [
	"Tools.UIPainter new openOnClass: self andSelector: #windowSpec"

	<resource: #canvas>
	^#('#{UI.FullSpec}' 
		#window: 
		#('#{UI.WindowSpec}' 
			#label: 
			#(#UserMessage 
				#key: #jun_Table_Model 
				#defaultString: 'Table Model' ) 
			#min: #('#{Core.Point}' 160 120 ) 
			#bounds: #('#{Graphics.Rectangle}' 700 525 1020 765 ) ) 
		#component: 
		#('#{UI.SpecCollection}' 
			#collection: #(
				#('#{UI.TableViewSpec}' 
					#layout: #('#{Graphics.LayoutFrame}' 0 0 0 0 0 1 0 1 ) 
					#name: #table 
					#flags: 12 
					#model: #tableInterface 
					#tabable: false 
					#showHGrid: true 
					#showVGrid: true ) ) ) )
]

{ #category : #'initialize-release' }
JunTableModel >> initialize [
	super initialize.
	sightingsTable := SelectionInTable new.
	sightingsTable tableHolder addDependent: self.
	sightingsTable selectionIndexHolder addDependent: self.
	tableInterface := TableInterface new selectionInTable: sightingsTable.
	selectionChangedBlock := nil.
	^self
]

{ #category : #'interface opening' }
JunTableModel >> postBuildWith: aBuilder [ 
	tableWidget := (self builder componentAt: #table) widget.
	self updateTableMenu
]

{ #category : #accessing }
JunTableModel >> selection [
	^self sightingsTable selection
]

{ #category : #updating }
JunTableModel >> selectionChangedBlock: aBlock [ 
	selectionChangedBlock := aBlock
]

{ #category : #accessing }
JunTableModel >> selectionIndex [
	^self sightingsTable selectionIndex
]

{ #category : #accessing }
JunTableModel >> selectionIndex: aPoint [ 
	self sightingsTable selectionIndex: aPoint
]

{ #category : #aspects }
JunTableModel >> sightingsTable [
	^sightingsTable
]

{ #category : #accessing }
JunTableModel >> table [
	^self sightingsTable table
]

{ #category : #accessing }
JunTableModel >> table: aTable [ 
	self sightingsTable table: (TableAdaptor on: OrderedCollection new adaptors: RowAdaptor new).
	aTable notNil ifTrue: [self sightingsTable table: aTable]
]

{ #category : #aspects }
JunTableModel >> tableInterface [
	^tableInterface
]

{ #category : #aspects }
JunTableModel >> tableInterface: aTableInterface [ 
	tableInterface := aTableInterface
]

{ #category : #'menu messages' }
JunTableModel >> tableMenu [
	^nil
]

{ #category : #updating }
JunTableModel >> update: anAspect with: aParameter from: anObject [ 
	anObject == self sightingsTable tableHolder 
		ifTrue: 
			[self updateTable.
			self changed: #table].
	anObject == self sightingsTable selectionIndexHolder 
		ifTrue: 
			[self updateSelection.
			self changed: #selection].
	self updateTableMenu
]

{ #category : #updating }
JunTableModel >> updateSelection [
	selectionChangedBlock notNil ifTrue: [selectionChangedBlock value]
]

{ #category : #updating }
JunTableModel >> updateTable [
	| table columns rows |
	table := self table.
	(table respondsTo: #columnLabels)
		ifTrue: 
			[columns := table columnLabels.
			columns notNil ifTrue: [self tableInterface columnLabelsArray: columns]].
	(table respondsTo: #rowLabels)
		ifTrue: 
			[rows := table rowLabels.
			rows notNil ifTrue: [self tableInterface rowLabelsArray: rows]]
]

{ #category : #updating }
JunTableModel >> updateTableMenu [
	tableWidget isNil ifFalse: [tableWidget controller menuHolder value: self tableMenu]
]

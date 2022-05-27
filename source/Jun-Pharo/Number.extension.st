Extension { #name : #Number }

{ #category : #'*Jun-Pharo' }
Number >> asDouble [ 

	"Compatibility method to prevent the need to refactor Jun code."

	^ self asFloat
]

{ #category : #'*Jun-Pharo' }
Number >> respondsToArithmetic [

	"Compatibility method to prevent the need to refactor Jun code."

	^ true
]

{ #category : #'*Jun-Pharo' }
Number >> retry: aSymbol coercing: aNumber [ 

	"Compatibility method to prevent the need to refactor Jun code."

	self generality < aNumber generality 
		ifTrue: [ ^ (aNumber coerce: self) perform: aSymbol with: aNumber ].

	self generality > aNumber generality 
		ifTrue: [ ^ self perform: aSymbol with: (self coerce: aNumber) ].

	self error: 'coercion attempt failed'
]

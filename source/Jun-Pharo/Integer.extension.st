Extension { #name : #Integer }

{ #category : #'*Jun-Pharo' }
Integer >> coerce: aNumber [ 

	"Compatibility method to prevent the need to refactor Jun code."

	^ aNumber asInteger
]

{ #category : #'*Jun-Pharo' }
Integer >> generality [ 

	"Compatibility method to prevent the need to refactor Jun code."

	^ 40
]

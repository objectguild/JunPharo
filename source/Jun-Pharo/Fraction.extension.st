Extension { #name : #Fraction }

{ #category : #'*Jun-Pharo' }
Fraction >> coerce: aNumber [ 

	"Compatibility method to prevent the need to refactor Jun code."

	^ aNumber asFraction
]

{ #category : #'*Jun-Pharo' }
Fraction >> generality [ 

	"Compatibility method to prevent the need to refactor Jun code."

	^ 60
]
